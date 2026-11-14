// macOS Vision experiment for manual review of scanned, two-column PDF pages.
// Usage: swift tools/content/ocr_moe_scanned_page.swift /path/to/file.pdf PAGE > /tmp/page.tsv
// Rows are observations, not verified vocabulary entries; no content is approved.
import Foundation
import PDFKit
import Vision
import AppKit

guard CommandLine.arguments.count == 3,
      let number = Int(CommandLine.arguments[2]), number > 0,
      let doc = PDFDocument(url: URL(fileURLWithPath: CommandLine.arguments[1])),
      let page = doc.page(at: number - 1) else {
    fputs("Usage: swift ocr_moe_scanned_page.swift PDF PAGE (one-based)\n", stderr)
    exit(2)
}
let bounds = page.bounds(for: .mediaBox)
let scale: CGFloat = 2
let image = NSImage(size: NSSize(width: bounds.width * scale, height: bounds.height * scale))
image.lockFocus()
NSColor.white.setFill()
NSRect(origin: .zero, size: image.size).fill()
let context = NSGraphicsContext.current!.cgContext
context.scaleBy(x: scale, y: scale)
page.draw(with: .mediaBox, to: context)
image.unlockFocus()
var rect = NSRect(origin: .zero, size: image.size)
guard let cg = image.cgImage(forProposedRect: &rect, context: nil, hints: nil) else {
    fputs("Unable to render page\n", stderr); exit(1)
}
print("pdf_page\tcolumn\tx_mid\ty_mid\tconfidence\tocr_text")
for column in 0...1 {
    let start = column == 0 ? 0 : cg.width / 2
    let end = column == 0 ? cg.width / 2 : cg.width
    guard let crop = cg.cropping(to: CGRect(x: start, y: 0, width: end - start, height: cg.height)) else {
        fputs("Unable to crop column\n", stderr); exit(1)
    }
    let request = VNRecognizeTextRequest()
    request.recognitionLevel = .accurate
    request.recognitionLanguages = ["en-US"]
    request.usesLanguageCorrection = false
    try VNImageRequestHandler(cgImage: crop).perform([request])
    let observations = (request.results ?? []).sorted { $0.boundingBox.midY > $1.boundingBox.midY }
    for observation in observations {
        guard let candidate = observation.topCandidates(1).first else { continue }
        let text = candidate.string.replacingOccurrences(of: "\t", with: " ").replacingOccurrences(of: "\n", with: " ")
        print(String(format: "%d\t%@\t%.4f\t%.4f\t%.4f\t%@", number, column == 0 ? "left" : "right", observation.boundingBox.midX, observation.boundingBox.midY, candidate.confidence, text))
    }
}
