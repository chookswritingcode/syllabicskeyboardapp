//
//  transliterator.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/9/25.
//
import SwiftUI
import SwiftData



func isVowel(_ s: String) -> Bool {
    return ["a", "i", "o", "e"].contains(s)
}

struct SyllabicVariant {
    let base: String
    let long: String
    let w: String
    let wLong: String
}

// Sample final entries
let finalMap: [String: String] = [
    "p": "ᑉ", "t": "ᑦ", "k": "ᒃ", "ch": "ᒡ", "m": "ᒻ", "n": "ᓐ", "s": "ᔅ",
    "sh": "ᔥ", "y": "ᔾ", "r": "ᕐ", "l": "ᓪ", "f": "ᕝ", "th": "ᕪ",
    "w": "ᐤ", "h": "ᐦ", "ng": "ᖕ", "q": "ᖅ"
]

// Sample baseMap entries
let baseMap: [String: [String: SyllabicVariant]] = [
    "p": [
        "i": SyllabicVariant(base: "ᐱ", long: "ᐲ", w: "ᐼ", wLong: "ᐾ"),
        "a": SyllabicVariant(base: "ᐸ", long: "ᐹ", w: "ᑄ", wLong: "ᑆ"),
        "o": SyllabicVariant(base: "ᐳ", long: "ᐴ", w: "ᐷ", wLong: "ᑃ"),
        "e": SyllabicVariant(base: "ᐯ", long: "ᐯ", w: "ᐺ", wLong: "ᐺ"),
    ],
    "t": [
        "i": SyllabicVariant(base: "ᑎ", long: "ᑏ", w: "ᑙ", wLong: "ᑛ"),
        "a": SyllabicVariant(base: "ᑕ", long: "ᑖ", w: "ᑡ", wLong: "ᑣ"),
        "o": SyllabicVariant(base: "ᑐ", long: "ᑑ", w: "ᑔ", wLong: "ᑟ"),
        "e": SyllabicVariant(base: "ᑌ", long: "ᑌ", w: "ᑗ", wLong: "ᕫ"),
    ],
    "k": [
        "i": SyllabicVariant(base: "ᑭ", long: "ᑮ", w: "ᑶ", wLong: "ᑸ"),
        "a": SyllabicVariant(base: "ᑲ", long: "ᑳ", w: "ᑾ", wLong: "ᒀ"),
        "o": SyllabicVariant(base: "ᑯ", long: "ᑰ", w: "ᑺ", wLong: "ᑼ"),
        "e": SyllabicVariant(base: "ᑫ", long: "ᑫ", w: "ᑴ", wLong: "ᑴ"),
    ],
    "ch": [
        "i": SyllabicVariant(base: "ᒋ", long: "ᒌ", w: "ᒔ", wLong: "ᒖ"),
        "a": SyllabicVariant(base: "ᒐ", long: "ᒑ", w: "ᒜ", wLong: "ᒞ"),
        "o": SyllabicVariant(base: "ᒍ", long: "ᒎ", w: "ᒘ", wLong: "ᒚ"),
        "e": SyllabicVariant(base: "ᒉ", long: "ᒉ", w: "ᒒ", wLong: "ᒒ"),
    ],
    "m": [
        "i": SyllabicVariant(base: "ᒥ", long: "ᒦ", w: "ᒮ", wLong: "ᒰ"),
        "a": SyllabicVariant(base: "ᒪ", long: "ᒫ", w: "ᒶ", wLong: "ᒸ"),
        "o": SyllabicVariant(base: "ᒧ", long: "ᒨ", w: "ᒲ", wLong: "ᒴ"),
        "e": SyllabicVariant(base: "ᒣ", long: "ᒣ", w: "ᒬ", wLong: "ᒬ"),
    ],
    "n": [
        "i": SyllabicVariant(base: "ᓂ", long: "ᓃ", w: "ᣆ", wLong: "ᣈ"),
        "a": SyllabicVariant(base: "ᓇ", long: "ᓈ", w: "ᓋ", wLong: "ᓍ"),
        "o": SyllabicVariant(base: "ᓄ", long: "ᓅ", w: "ᣊ", wLong: "ᣌ"),
        "e": SyllabicVariant(base: "ᓀ", long: "ᓀ", w: "ᓉ", wLong: "ᓉ"),
    ],
    "s": [
        "i": SyllabicVariant(base: "ᓯ", long: "ᓰ", w: "ᓸ", wLong: "ᓺ"),
        "a": SyllabicVariant(base: "ᓴ", long: "ᓵ", w: "ᔀ", wLong: "ᔂ"),
        "o": SyllabicVariant(base: "ᓱ", long: "ᓲ", w: "ᓼ", wLong: "ᓾ"),
        "e": SyllabicVariant(base: "ᓭ", long: "ᓭ", w: "ᓶ", wLong: "ᓶ"),
    ],
    "sh": [
        "i": SyllabicVariant(base: "ᔑ", long: "ᔒ", w: "ᔙ", wLong: "ᔔ"),
        "a": SyllabicVariant(base: "ᔕ", long: "ᔖ", w: "ᔡ", wLong: "ᔣ"),
        "o": SyllabicVariant(base: "ᔓ", long: "ᔔ", w: "ᔝ", wLong: "ᔟ"),
        "e": SyllabicVariant(base: "ᔐ", long: "ᔐ", w: "ᔗ", wLong: "ᔗ"),
    ],
    "y": [
        "i": SyllabicVariant(base: "ᔨ", long: "ᔩ", w: "ᔱ", wLong: "ᔳ"),
        "a": SyllabicVariant(base: "ᔭ", long: "ᔮ", w: "ᔹ", wLong: "ᔻ"),
        "o": SyllabicVariant(base: "ᔪ", long: "ᔫ", w: "ᔵ", wLong: "ᔷ"),
        "e": SyllabicVariant(base: "ᔦ", long: "ᔦ", w: "ᔯ", wLong: "ᔯ"),
    ],
    "r": [
        "i": SyllabicVariant(base: "ᕆ", long: "ᕇ", w: "ᣏ", wLong: "ᣐ"),
        "a": SyllabicVariant(base: "ᕋ", long: "ᕌ", w: "ᣓ", wLong: "ᕎ"),
        "o": SyllabicVariant(base: "ᕈ", long: "ᕉ", w: "ᣑ", wLong: "ᣒ"),
        "e": SyllabicVariant(base: "ᕃ", long: "ᕃ", w: "ᣎ", wLong: "ᣎ"),
    ],
    "l": [
        "i": SyllabicVariant(base: "ᓕ", long: "ᓖ", w: "ᓞ", wLong: "ᓠ"),
        "a": SyllabicVariant(base: "ᓚ", long: "ᓛ", w: "ᓦ", wLong: "ᓨ"),
        "o": SyllabicVariant(base: "ᓗ", long: "ᓘ", w: "ᓢ", wLong: "ᓤ"),
        "e": SyllabicVariant(base: "ᓓ", long: "ᓓ", w: "ᓜ", wLong: "ᓜ"),
    ],
    "f": [
        "i": SyllabicVariant(base: "ᕕ", long: "ᕖ", w: "ᐧᕕ", wLong: "ᐧᕖ"),
        "a": SyllabicVariant(base: "ᕙ", long: "ᕚ", w: "ᐧᕙ", wLong: "ᕛ"),
        "o": SyllabicVariant(base: "ᕗ", long: "ᕘ", w: "ᐧᕗ", wLong: "ᐧᕗ"),
        "e": SyllabicVariant(base: "ᕓ", long: "ᕓ", w: "ᐧᕓ", wLong: "ᐧᕓ"),
    ],
    "th": [
        "i": SyllabicVariant(base: "ᕠ", long: "ᕢ", w: "ᕠ", wLong: "ᐧᕢ"),
        "a": SyllabicVariant(base: "ᕦ", long: "ᕧ", w: "ᕨ", wLong: "ᕨ"),
        "o": SyllabicVariant(base: "ᕤ", long: "ᕥ", w: "ᐧᕤ", wLong: "ᐧᕥ"),
        "e": SyllabicVariant(base: "ᕞ", long: "ᕞ", w: "ᐧᕞ", wLong: "ᐧᕞ"),
    ],
    "a": [
        "i": SyllabicVariant(base: "ᐃ", long: "ᐄ", w: "ᐎ", wLong: "ᐇ"),
        "a": SyllabicVariant(base: "ᐊ", long: "ᐋ", w: "ᐗ", wLong: "ᐙ"),
        "o": SyllabicVariant(base: "ᐅ", long: "ᐆ", w: "ᐒ", wLong: "ᐔ"),
        "e": SyllabicVariant(base: "ᐁ", long: "ᐁ", w: "ᐌ", wLong: "ᐌ"),
    ],
]

let voicedToVoiceless: [String: String] = [
    "b": "p", "d": "t", "g": "k", "v": "f", "z": "s", "zh": "sh", "j": "ch",
    "p": "p", "t": "t", "k": "k", "f": "f", "s": "s", "sh": "sh", "ch": "ch" // identity for voiceless
]

let vowels = ["a", "i", "o", "e"]
let medialW = ""

func transliterateToSyllabics(_ input: String) -> String {
    let inputChars = Array(input.lowercased())
    var result = ""
    var i = 0

    func peek(_ offset: Int) -> String {
        let index = i + offset
        guard index >= 0 && index < inputChars.count else { return "" }
        return String(inputChars[index])
    }

    while i < inputChars.count {
     //   let c1 = peek(0)
      //  let c2 = peek(1)
       // let c3 = peek(2)

        let digraph = peek(0) + peek(1)
        var consonant = ""
        var isDigraph = false

        if baseMap[digraph] != nil || voicedToVoiceless[digraph] != nil {
            consonant = digraph
            isDigraph = true
        } else {
            consonant = peek(0)
        }

        let next = isDigraph ? 2 : 1
        var hasMedialW = false
        var vowel = ""

        let v1 = peek(next)
        let v2 = peek(next + 1)

        if v1 == "w", isVowel(v2) {
            hasMedialW = true
            vowel = v2
        } else if isVowel(v1) {
            vowel = v1
        }

    //    let afterVowel = peek(next + (hasMedialW ? 2 : 1))
     //   let isLong = vowel != "" && vowel == afterVowel
        let lookahead = peek(next + (hasMedialW ? 2 : 1))
        let isLong = vowel != "" && vowel == lookahead && ["a", "i", "o", "e"].contains(vowel)
        
        let voiceless = voicedToVoiceless[consonant] ?? consonant
        let variantSet = baseMap[voiceless]
        
        if let variant = variantSet?[vowel] {
            var syllabic = isLong
                ? (hasMedialW ? variant.wLong : variant.long)
                : (hasMedialW ? variant.w : variant.base)

            if ["p", "t", "k", "f", "s", "ch", "sh"].contains(consonant) {
                syllabic = "ᐦ" + syllabic
            }
            if hasMedialW {
                syllabic = medialW + syllabic
            }
            if consonant == "h", isVowel(vowel) {
                if let variantSet = baseMap["a"], let variant = variantSet[vowel] {
                    let syllabic = isLong ? variant.long : variant.base
                    result += "ᐦ" + syllabic
                    i += (isDigraph ? 2 : 1) + (hasMedialW ? 1 : 0) + (isLong ? 2 : 1)
                    continue
                }
            }

            result += syllabic
            i += (isDigraph ? 2 : 1) + (hasMedialW ? 1 : 0) + 1 + (isLong ? 1 : 0)
            continue
        }

        // Special handling for 'h' + vowel
        if consonant == "h", isVowel(vowel) {
            if let vowelVariant = baseMap["a"]?[vowel] {
                let syllabic = isLong ? vowelVariant.long : vowelVariant.base
                result += "ᐦ" + (hasMedialW ? medialW : "") + syllabic
                i += (isDigraph ? 2 : 1) + (hasMedialW ? 1 : 0) + (isLong ? 2 : 1)
                continue
            }
        }
        
        // Handle standalone "w" + vowel (e.g., wa = ᐗ)
        if peek(0) == "w", isVowel(peek(1)) {
            let wVowel = peek(1)
            if let waSet = baseMap["a"], let waVariant = waSet[wVowel] {
                result += waVariant.w
                i += 2
                continue
            }
        }
        // Final consonant w logic
        if peek(0) == "w" {
            let prev = peek(-1)
            let next = peek(1)

            // Only check prev if it exists
            let hasPrevVowel = prev != "" && isVowel(prev)
            let hasNextVowel = next != "" && isVowel(next)

            if hasPrevVowel && hasNextVowel {
                result += "ᐤ"
                i += 1
                continue
            } else if hasPrevVowel || (!hasNextVowel && next != "") {
                result += "ᐤ"
                i += 1
                continue
            }
        }
        // Final consonant (including digraphs)
        let nextChar = peek(1)

        // Try digraphs first
        // Final consonant digraphs (e.g., sh, ch, zh)
        let normalizedDigraph = voicedToVoiceless[digraph] ?? digraph
        if finalMap.keys.contains(normalizedDigraph), !isVowel(peek(2)) {
            result += finalMap[normalizedDigraph]!
            i += 2
            continue
        }

        // Then single letters
        let final = peek(0)
        let normalizedFinal = voicedToVoiceless[final] ?? final
        if finalMap.keys.contains(normalizedFinal), !isVowel(nextChar) {
            result += finalMap[normalizedFinal]!
            i += 1
            continue
        }
        // Handle standalone vowel
        if isVowel(peek(0)) {
            let isLong = peek(0) == peek(1)
            let v = peek(0)
            if let vowelOnly = baseMap["a"]?[v] {
                result += isLong ? vowelOnly.long : vowelOnly.base
                i += isLong ? 2 : 1
                continue
            }
        }
        
        // Catch-all fallback for unknown characters
        let fallbackChar = isDigraph ? digraph : peek(0)
        result += fallbackChar
        i += isDigraph ? 2 : 1
    }

    return result
}
