import UIKit

class KeyboardViewController: UIInputViewController {
    
    var currentVowel: String? = nil
    var isLongVowel: Bool = false
    var hasWGlide: Bool = false
    var isSymbolPage: Bool = false
    
    var longButton: UIButton?
    var wButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard()
        if let font = UIFont(name: "NotoSansSymbols2-Regular", size: 24) {
            print("✅ Font loaded: \(font.fontName)")
        } else {
            print("❌ Font failed to load")
        }
    }
    
    func rebuildKeyboard() {
        view.subviews.forEach { $0.removeFromSuperview() }
        setupKeyboard()
    }
    
    func setupKeyboard() {
        let keyboardStack = UIStackView()
        keyboardStack.axis = .vertical
        keyboardStack.spacing = 8
        keyboardStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardStack)
        
        NSLayoutConstraint.activate([
            keyboardStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            keyboardStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            keyboardStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            keyboardStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        if isSymbolPage {
            keyboardStack.addArrangedSubview(createSymbolPage())
        } else {
            //keyboardStack.addArrangedSubview(createVowelRow())
            keyboardStack.addArrangedSubview(createFinalsAndPunctuationRow())
            //makes 2 syllabic rows
            for row in createSyllabicRows() {
                keyboardStack.addArrangedSubview(row)
            }
            //makes 1 final row
          //  keyboardStack.addArrangedSubview(createFinalsRow())
            
            keyboardStack.addArrangedSubview(createModifierRow())
            
        }
        
        keyboardStack.addArrangedSubview(createUtilityRow())
    }
    
    func createFinalsAndPunctuationRow() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 6
        row.distribution = .fillEqually

        let items = [
            ("ᐤ", "w"), ("ᐦ", "h"), ("ᖕ", "ng"), ("ᖅ", "q"),
            ("?", "?"), ("!", "!"), ("ᐟ", "’"), ("x", "x")
        ]

        for (symbol, id) in items {
            let button = createBaseKey(title: symbol, id: id)
            let selector: Selector = symbol.range(of: "\\p{S}|\\p{P}", options: .regularExpression) != nil
                ? #selector(symbolPressed(_:)) : #selector(syllabicKeyPressed(_:))
            button.addTarget(self, action: selector, for: .touchUpInside)
            row.addArrangedSubview(button)
        }

        return row
    }
    
    let syllabics = [
        ("ᐊ", "a"), ("ᐸ", "p"), ("ᑕ", "t"), ("ᑲ", "k"), ("ᒐ", "c"), ("ᒪ", "m"),
        ("ᓇ", "n"), ("ᓴ", "s"), ("ᔕ", "sh"), ("ᔭ", "y"), ("ᕋ", "r"), ("ᓚ", "l"),
        ("ᕙ", "f"), ("ᕦ", "th")
    ]
    
    let finalConsonantMap: [String: String] = [
        "p": "ᑉ", "t": "ᑦ", "k": "ᒃ", "c": "ᒡ", "m": "ᒻ", "n": "ᓐ", "s": "ᔅ",
        "sh": "ᔥ", "y": "ᔾ", "r": "ᕐ", "l": "ᓪ", "f": "ᕝ", "th": "ᕪ",
        "w": "ᐤ", "h": "ᐦ", "ng": "ᖕ", "q": "ᖅ"
    ]
    
    let vowelMap: [String: [String: String]] = [
        "i": ["base": "ᐃ", "long": "ᐄ", "w": "ᐎ", "w_long": "ᐐ"],
        "a": ["base": "ᐊ", "long": "ᐋ", "w": "ᐗ", "w_long": "ᐙ"],
        "o": ["base": "ᐅ", "long": "ᐆ", "w": "ᐒ", "w_long": "ᐔ"],
        "e": ["base": "ᐁ", "long": "ᐁ\u{0307}", "w": "ᐌ", "w_long": "ᐌ\u{0307}"],
        
    ]
    
    let syllabicMap: [String: [String: [String: String]]] = [
        "p": [
            "i": ["base": "ᐱ", "long": "ᐲ", "w": "ᐼ", "w_long": "ᐾ"],
            "a": ["base": "ᐸ", "long": "ᐹ", "w": "ᑄ", "w_long": "ᑆ"],
            "o": ["base": "ᐳ", "long": "ᐴ", "w": "ᐷ", "w_long": "ᑃ"],
            "e": ["base": "ᐯ", "long": "ᐯ\u{0307}", "w": "ᐺ", "w_long": "ᐺ\u{0307}"]
        ],
        "t": [
            "i": ["base": "ᑎ", "long": "ᑏ", "w": "ᑙ", "w_long": "ᑛ"],
            "a": ["base": "ᑕ", "long": "ᑖ", "w": "ᑡ", "w_long": "ᑣ"],
            "o": ["base": "ᑐ", "long": "ᑑ", "w": "ᑔ", "w_long": "ᑟ"],
            "e": ["base": "ᑌ", "long": "ᑌ\u{0307}", "w": "ᑗ", "w_long": "ᕫ\u{0307}"]
        ],
        "k": [
            "i": ["base": "ᑭ", "long": "ᑮ", "w": "ᑶ", "w_long": "ᑸ"],
            "a": ["base": "ᑲ", "long": "ᑳ", "w": "ᑾ", "w_long": "ᒀ"],
            "o": ["base": "ᑯ", "long": "ᑰ", "w": "ᑺ", "w_long": "ᑼ"],
            "e": ["base": "ᑫ", "long": "ᑫ\u{0307}", "w": "ᑴ", "w_long": "ᑴ\u{0307}"]
        ],
        "c": [
            "i": ["base": "ᒋ", "long": "ᒌ", "w": "ᒔ", "w_long": "ᒖ"],
            "a": ["base": "ᒐ", "long": "ᒑ", "w": "ᒜ", "w_long": "ᒞ"],
            "o": ["base": "ᒍ", "long": "ᒎ", "w": "ᒘ", "w_long": "ᒚ"],
            "e": ["base": "ᒉ", "long": "ᒉ\u{0307}", "w": "ᒒ", "w_long": "ᒒ\u{0307}"]
        ],
        "m": [
            "i": ["base": "ᒥ", "long": "ᒦ", "w": "ᒮ", "w_long": "ᒰ"],
            "a": ["base": "ᒪ", "long": "ᒫ", "w": "ᒶ", "w_long": "ᒸ"],
            "o": ["base": "ᒧ", "long": "ᒨ", "w": "ᒲ", "w_long": "ᒴ"],
            "e": ["base": "ᒣ", "long": "ᒣ\u{0307}", "w": "ᒬ", "w_long": "ᒬ\u{0307}"]
        ],
        "n": [
            "i": ["base": "ᓂ", "long": "ᓃ", "w": "ᣆ", "w_long": "ᣈ"],
            "a": ["base": "ᓇ", "long": "ᓈ", "w": "ᓋ", "w_long": "ᓍ"],
            "o": ["base": "ᓄ", "long": "ᓅ", "w": "ᣊ", "w_long": "ᣌ"],
            "e": ["base": "ᓀ", "long": "ᓀ\u{0307}", "w": "ᓉ", "w_long": "ᓉ\u{0307}"]
        ],
        "s": [
            "i": ["base": "ᓯ", "long": "ᓰ", "w": "ᓸ", "w_long": "ᓺ"],
            "a": ["base": "ᓴ", "long": "ᓵ", "w": "ᔀ", "w_long": "ᔂ"],
            "o": ["base": "ᓱ", "long": "ᓲ", "w": "ᓼ", "w_long": "ᓾ"],
            "e": ["base": "ᓭ", "long": "ᓭ\u{0307}", "w": "ᓶ", "w_long": "ᓶ\u{0307}"]
        ],
        "sh": [
            "i": ["base": "ᔑ", "long": "ᔒ", "w": "ᔙ", "w_long": "ᔟ"],
            "a": ["base": "ᔕ", "long": "ᔖ", "w": "ᔡ", "w_long": "ᔣ"],
            "o": ["base": "ᔓ", "long": "ᔔ", "w": "ᔝ", "w_long": "ᔟ"],
            "e": ["base": "ᔐ", "long": "ᔐ\u{0307}", "w": "ᔗ", "w_long": "ᔗ\u{0307}"]
        ],
        "y": [
            "i": ["base": "ᔨ", "long": "ᔩ", "w": "ᔱ", "w_long": "ᔳ"],
            "a": ["base": "ᔭ", "long": "ᔮ", "w": "ᔹ", "w_long": "ᔻ"],
            "o": ["base": "ᔪ", "long": "ᔫ", "w": "ᔵ", "w_long": "ᔷ"],
            "e": ["base": "ᔦ", "long": "ᔦ\u{0307}", "w": "ᔯ", "w_long": "ᔯ\u{0307}"]
        ],
        "r": [
            "i": ["base": "ᕆ", "long": "ᕇ", "w": "ᣏ", "w_long": "ᣐ"],
            "a": ["base": "ᕋ", "long": "ᕌ", "w": "ᣓ", "w_long": "ᕎ"],
            "o": ["base": "ᕈ", "long": "ᕉ", "w": "ᣑ", "w_long": "ᣒ"],
            "e": ["base": "ᕃ", "long": "ᕃ\u{0307}", "w": "ᣎ", "w_long": "ᣎ\u{0307}"]
        ],
        "l": [
            "i": ["base": "ᓕ", "long": "ᓖ", "w": "ᓞ", "w_long": "ᓠ"],
            "a": ["base": "ᓚ", "long": "ᓛ", "w": "ᓦ", "w_long": "ᓨ"],
            "o": ["base": "ᓗ", "long": "ᓘ", "w": "ᓢ", "w_long": "ᓤ"],
            "e": ["base": "ᓓ", "long": "ᓓ\u{0307}", "w": "ᓜ", "w_long": "ᓜ\u{0307}"]
        ],
        "f": [
            "i": ["base": "ᕕ", "long": "ᕖ", "w": "ᐧᕕ", "w_long": "ᐧᕖ"],
            "a": ["base": "ᕙ", "long": "ᕚ", "w": "ᐧᕙ", "w_long": "ᕛ"],
            "o": ["base": "ᕗ", "long": "ᕘ", "w": "ᐧᕗ", "w_long": "ᐧᕗ\u{0307}"],
            "e": ["base": "ᕓ", "long": "ᕓ\u{0307}", "w": "ᐧᕓ", "w_long": "ᐧᕓ\u{0307}"]
        ],
        "th": [
            "i": ["base": "ᕠ", "long": "ᕢ", "w": "ᕠ", "w_long": "ᐧᕢ"],
            "a": ["base": "ᕦ", "long": "ᕧ", "w": "ᕨ", "w_long": "ᕨ"],
            "o": ["base": "ᕤ", "long": "ᕥ", "w": "ᐧᕤ", "w_long": "ᐧᕥ"],
            "e": ["base": "ᕞ", "long": "ᕞ\u{0307}", "w": "ᐧᕞ", "w_long": "ᐧᕞ\u{0307}"]
        ],
        "a": [
            "i": ["base": "ᐃ", "long": "ᐄ", "w": "ᐎ", "w_long": "ᐐ"],
            "a": ["base": "ᐊ", "long": "ᐋ", "w": "ᐗ", "w_long": "ᐙ"],
            "o": ["base": "ᐅ", "long": "ᐆ", "w": "ᐒ", "w_long": "ᐔ"],
            "e": ["base": "ᐁ", "long": "ᐁ\u{0307}", "w": "ᐌ", "w_long": "ᐌ\u{0307}"]
        ]
    ]
    
   /* func createButton(title: String, isModifier: Bool = false) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = isModifier ? .darkGray : .lightGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }*/
    func createButton(title: String, isModifier: Bool = false, useKaktovikFont: Bool = false) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)

        if useKaktovikFont {
            button.titleLabel?.font = UIFont(name: "NotoSansSymbols2-Regular", size: 24)
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        }

        button.backgroundColor = isModifier ? .darkGray : .lightGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true

        return button
    }
    
    func createBaseKey(title: String, id: String) -> UIButton {
        let button = createButton(title: title)
        button.accessibilityIdentifier = id
        button.addTarget(self, action: #selector(syllabicKeyPressed(_:)), for: .touchUpInside)
        return button
    }
    
    func createSyllabicRows() -> [UIStackView] {
        let rows: [UIStackView] = [UIStackView(), UIStackView()]
        for row in rows {
            row.axis = .horizontal
            row.spacing = 6
            row.distribution = .fillEqually
        }

        let syllables = [
            ("ᐊ", "a"), ("ᐸ", "p"), ("ᑕ", "t"), ("ᑲ", "k"),
            ("ᒐ", "c"), ("ᒪ", "m"), ("ᓇ", "n"),
            ("ᓴ", "s"), ("ᔕ", "sh"), ("ᔭ", "y"),
            ("ᕋ", "r"), ("ᓚ", "l"), ("ᕙ", "f"), ("ᕦ", "th")
        ]

        for (index, (symbol, id)) in syllables.enumerated() {
            let button = createBaseKey(title: symbol, id: id)
            rows[index / 7].addArrangedSubview(button)
        }

        return rows
    }
    /*
    func createVowelRow() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 6
        row.distribution = .fillEqually
        for (symbol, id) in [("ᐁ", "e"), ("ᐃ", "i"), ("ᐅ", "o"), ("ᐊ", "a")] {
            let button = createBaseKey(title: symbol, id: id)
            button.addTarget(self, action: #selector(vowelKeyPressed(_:)), for: .touchUpInside)
            row.addArrangedSubview(button)
        }
        return row
    }
    */
    
    func createModifierRow() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        
        for (label, vowel) in [("ᐊ", "a"), ("ᐃ", "i"), ("ᐅ", "o"), ("ᐁ", "e")] {
            let button = createButton(title: label, isModifier: true)
            button.accessibilityIdentifier = vowel
            button.addTarget(self, action: #selector(setVowel(_:)), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }
        
        longButton = createButton(title: "LNG", isModifier: true)
        longButton?.addTarget(self, action: #selector(toggleLong), for: .touchUpInside)
        stack.addArrangedSubview(longButton!)
        
        wButton = createButton(title: "W", isModifier: true)
        wButton?.addTarget(self, action: #selector(toggleW), for: .touchUpInside)
        stack.addArrangedSubview(wButton!)
        
        return stack
    }
    
    func createPunctuationRow() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 6
        row.distribution = .fillEqually
        for mark in [".", "?", "!", "’", "x"] {
            let button = createButton(title: mark)
            button.addTarget(self, action: #selector(symbolPressed(_:)), for: .touchUpInside)
            row.addArrangedSubview(button)
        }
        return row
    }
 /*
    func createKaktovikRow() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 6
        row.distribution = .fillEqually

        /*
        let chars = [
            ("0", "𑋀"), ("1", "𝋁"), ("2", "𝋂"), ("3", "𝋃"), ("4", "𝋄"), ("5", "𝋅"), ("6", "𝋆"), ("7", "𝋇"), ("8", "𝋈"), ("9", "𝋉"), ("A", "𝋊"), ("B", "𝋋"), ("C", "𝋌"), ("D", "𝋍"), ("E", "𝋎"), ("F", "𝋏"), ("G", "𝋐"), ("H", "𝋑"),("I", "𝋒"),("J", "𝋓")
        ]
*/
        let chars = [
            "𑋀", "𝋁", "𝋂", "𝋃", "𝋄", "𝋅", "𝋆", "𝋇", "𝋈", "𝋉", "𝋊", "𝋋", "𝋌", "𝋍", "𝋎", "𝋏", "𝋐", "𝋑", "𝋒", "𝋓"
        ]
        
        
        for symbol in chars {
            let button = createButton(title: symbol, useKaktovikFont: true)
            button.addTarget(self, action: #selector(symbolPressed(_:)), for: .touchUpInside)
            row.addArrangedSubview(button)
        }

        return row
    }
    */
    
    
    
    func createSymbolPage() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8

        let topRow = UIStackView()
        topRow.axis = .horizontal
        topRow.spacing = 6
        topRow.distribution = .fillEqually
        
     //   let belowRow = UIStackView()
        topRow.axis = .horizontal
        topRow.spacing = 6
        topRow.distribution = .fillEqually

        let bottomRow = UIStackView()
        bottomRow.axis = .horizontal
        bottomRow.spacing = 6
        bottomRow.distribution = .fillEqually

   //     stack.addArrangedSubview(createKaktovikRow())
        
   /*     let chars = [
            "𝋀", "𝋁", "𝋂", "𝋃", "𝋄", "𝋅", "𝋆", "𝋇", "𝋈", "𝋉", "𝋊", "𝋋", "𝋌", "𝋍", "𝋎", "𝋏", "𝋐", "𝋑", "𝋒", "𝋓"
        ]
        
        for symbol in chars {
            let button = createButton(title: symbol, useKaktovikFont: true)
            button.addTarget(self, action: #selector(symbolPressed(_:)), for: .touchUpInside)
            belowRow.addArrangedSubview(button)
        }
        
  */
        
        
        let topChars = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "A"]
        let bottomChars = ["B", "C", "D", "E", "F", "G", "H", "I", "J", "K"]

        for ch in topChars {
            let button = createButton(title: ch)
            button.addTarget(self, action: #selector(symbolPressed(_:)), for: .touchUpInside)
            topRow.addArrangedSubview(button)
        }

        for ch in bottomChars {
            let button = createButton(title: ch)
            button.addTarget(self, action: #selector(symbolPressed(_:)), for: .touchUpInside)
            bottomRow.addArrangedSubview(button)
        }

        let symRow = UIStackView()
        symRow.axis = .horizontal
        symRow.spacing = 6
        symRow.distribution = .fillEqually
        let symbols = ["$", "@", "&", "%", "#", "+", ".", "?", "!", "’", "x"]
        for ch in symbols {
            let button = createButton(title: ch)
            button.addTarget(self, action: #selector(symbolPressed(_:)), for: .touchUpInside)
            symRow.addArrangedSubview(button)
        }

        // Add backspace key
        let deleteButton = createButton(title: "⌫")
        deleteButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        symRow.addArrangedSubview(deleteButton)

        stack.addArrangedSubview(topRow)
        stack.addArrangedSubview(bottomRow)
        stack.addArrangedSubview(symRow)
     //   stack.addArrangedSubview(belowRow)
        return stack
    }
    
    func createUtilityRow() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 8
        row.distribution = .fillProportionally
        
      //  let globe = createButton(title: "🌐")
       // globe.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        let toggle = createButton(title: isSymbolPage ? "ABC" : "123")
        toggle.addTarget(self, action: #selector(toggleSymbolPage), for: .touchUpInside)
        
        let space = createButton(title: "ᖛᖞᖝᖜ")
        space.addTarget(self, action: #selector(spacePressed), for: .touchUpInside)
        space.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        let delete = createButton(title: "⌫")
        delete.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        
     //   row.addArrangedSubview(globe)
        row.addArrangedSubview(toggle)
        row.addArrangedSubview(space)
        row.addArrangedSubview(delete)
        
        return row
    }
    
    @objc func vowelKeyPressed(_ sender: UIButton) {
        guard let base = sender.accessibilityIdentifier?.lowercased() else { return }

        var key = "base"
        if isLongVowel && hasWGlide {
            key = "w_long"
        } else if isLongVowel {
            key = "long"
        } else if hasWGlide {
            key = "w"
        }

        let char = vowelMap[base]?[key] ?? vowelMap[base]?["base"]!
        textDocumentProxy.insertText(char ?? "")
    }
    
    
    
    @objc func syllabicKeyPressed(_ sender: UIButton) {
        guard let base = sender.accessibilityIdentifier?.lowercased() else { return }

    
        // If no vowel is selected, treat it as a final consonant
        if currentVowel == nil {
            if let final = finalConsonantMap[base] {
                textDocumentProxy.insertText(final)
            }
            return
        }

        // Use the syllabicMap to get the correct rotated form
        guard let vowelMap = syllabicMap[base]?[currentVowel!] else { return }

        var key = "base"
        if isLongVowel && hasWGlide {
            key = "w_long"
        } else if isLongVowel {
            key = "long"
        } else if hasWGlide {
            key = "w"
        }

        let char = vowelMap[key] ?? vowelMap["base"]!
        textDocumentProxy.insertText(char)
    }

    @objc func setVowel(_ sender: UIButton) {
        guard let selected = sender.accessibilityIdentifier?.lowercased() else { return }
        currentVowel = (currentVowel == selected) ? nil : selected

        // Update highlight colors
        for case let button as UIButton in sender.superview?.subviews ?? [] {
            // Preserve highlighting for the long and w modifier buttons
            if button === longButton {
                button.backgroundColor = isLongVowel ? .orange : .lightGray
                continue
            }
            if button === wButton {
                button.backgroundColor = hasWGlide ? .orange : .lightGray
                continue
            }

            let bVowel = button.accessibilityIdentifier?.lowercased()
            button.backgroundColor = (bVowel == currentVowel) ? .cyan : .lightGray
        }
    }

    @objc func toggleLong() {
        isLongVowel.toggle()
        longButton?.backgroundColor = isLongVowel ? .orange : .lightGray
    }

    @objc func toggleW() {
        hasWGlide.toggle()
        wButton?.backgroundColor = hasWGlide ? .orange : .lightGray
    }

    @objc func symbolPressed(_ sender: UIButton) {
        if let symbol = sender.currentTitle {
            textDocumentProxy.insertText(symbol)
        }
    }
    
    

    @objc func spacePressed() {
        // Insert EM space (U+2003)
        textDocumentProxy.insertText("\u{2003}")
    }

    @objc func deletePressed() {
        textDocumentProxy.deleteBackward()
    }

    @objc func toggleSymbolPage() {
        isSymbolPage.toggle()
        rebuildKeyboard()
    }
}
