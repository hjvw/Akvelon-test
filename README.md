# Akvelon-test

A Haskell project that implements a FizzBuzz detector with text tokenization and pattern matching capabilities. This project demonstrates functional programming concepts in Haskell with comprehensive testing.

## Overview

This repository contains Haskell code with comprehensive testing capabilities. The project processes text input, tokenizes it into words and delimiters, and applies FizzBuzz-like pattern matching to replace words based on position-dependent rules.

**Key Feature:** The application replaces words in your input text with "Fizz", "Buzz", or "FizzBuzz" based on the position of each word using classical FizzBuzz rules (multiples of 3, 5, and 15).

## Prerequisites

Before running this project, ensure you have the following installed:

- **GHC (Glasgow Haskell Compiler)** - Version 8.0 or later
- **Cabal** or **Stack** (optional, for dependency management)
- **runhaskell** - Typically included with GHC installation

You can verify your installation by running:
```bash
ghc --version
runhaskell --version
```

## Project Structure

```
.
├── main.hs          # Main application entry point
├── tests.hs         # Test suite
└── README.md        # This file
```

## Installation

No additional installation is required beyond having Haskell installed. The project uses only standard Haskell libraries:
- `Data.Char` - Character classification utilities
- `System.IO` - I/O operations

## How It Works

### Architecture

The application follows a functional pipeline approach:

```
User Input → Tokenize → Apply FizzBuzz Patterns → Output Result
```

### Core Data Structure

The project uses a custom Haskell record to represent the processing result:

```haskell
data FizzBuzzDetector = FizzBuzzDetector 
    { outputString :: String          -- The processed output text
    , coincidenceCount :: Int          -- Total number of pattern matches
    } deriving (Show, Eq)
```

### Main Algorithm Flow

#### 1. **Tokenization** (`tokenize` function)

Breaks input text into meaningful units - words and delimiters:

```haskell
tokenize :: String -> [String]
```

**How it works:**
- Separates alphanumeric sequences (words) from non-alphanumeric characters (delimiters)
- Preserves apostrophes within words (e.g., "It's" stays as one token)
- Maintains spacing and punctuation as separate tokens

**Example:**
```
Input:  "Hello, world! It's here"
Output: ["Hello", ",", " ", "world", "!", " ", "It's", " ", "here"]
```

#### 2. **FizzBuzz Pattern Matching** (`getOverlappings` function)

The core processing function that applies FizzBuzz rules:

```haskell
getOverlappings :: String -> FizzBuzzDetector
```

**Algorithm:**
- Generates infinite lazy list of FizzBuzz patterns (Fizz at multiples of 3, Buzz at multiples of 5, FizzBuzz at multiples of 15)
- For each word token at position `i`:
  - If divisible by 15: replace with "FizzBuzz" (count 1)
  - Else if divisible by 3: replace with "Fizz" (count 1)
  - Else if divisible by 5: replace with "Buzz" (count 1)
  - Otherwise: keep original word (count 0)
- Non-word tokens (delimiters) are preserved unchanged
- Returns processed output and total match count

**Position Counting:** Only alphanumeric words are counted for position; delimiters don't affect the position counter.

**Example:**
```
Input:  "one two three"
Tokens: ["one", " ", "two", " ", "three"]

Processing:
- Position 1: "one" → "one" (not divisible by 3, 5, 15)
- Position 2: "two" → "two" (not divisible by 3, 5, 15)
- Position 3: "three" → "Fizz" (divisible by 3) ✓

Output: "one two Fizz"
Count: 1
```

## Usage

### Running the Main Application

To execute the main application:

```bash
runhaskell main.hs
```

**Program Flow:**
1. Displays "FizzBuzz" welcome message
2. Prompts user: "Type your text and press Enter: "
3. Reads user input from stdin
4. Processes the input through the FizzBuzz detector
5. Displays the processed result and total match count

**Interactive Example:**
```bash
$ runhaskell main.hs
FizzBuzz 
Type your text and press Enter: one two three four five
Processed Result
one two Fizz four Buzz

===================
Total Matches Found: 2
```

### Running Tests

To execute the test suite:

```bash
runhaskell tests.hs
```

This command:
- Compiles the `tests.hs` file
- Runs all 5 predefined test cases
- Reports which tests pass or fail
- Displays expected vs. actual output for failed tests
- Exits with success (exit code 0) if all tests pass, failure (exit code 1) otherwise

**Test Output Example:**
```
verification
[PASS] TEST 1
[PASS] TEST 2
[PASS] TEST 3
[PASS] TEST 4
[PASS] TEST 5

All 5 verifications passed successfully!
```

## Main Functions Reference

### `tokenize :: String -> [String]`

**Purpose:** Breaks input string into tokens (words and delimiters)

**Parameters:**
- `String` - The input text to tokenize

**Returns:** 
- `[String]` - List of tokens

**Behavior:**
- Alphanumeric characters are grouped into words
- Apostrophes are included within words
- Non-alphanumeric characters are grouped as delimiters
- Preserves all spacing and punctuation

**Examples:**
```haskell
tokenize "Hello, world"    → ["Hello", ",", " ", "world"]
tokenize "It's working"    → ["It's", " ", "working"]
tokenize "test123 abc"     → ["test123", " ", "abc"]
```

### `getOverlappings :: String -> FizzBuzzDetector`

**Purpose:** Processes text through FizzBuzz pattern matching

**Parameters:**
- `String` - The input text to process

**Returns:**
- `FizzBuzzDetector` - Record containing:
  - `outputString`: The processed text with replacements
  - `coincidenceCount`: Total number of matches

**Behavior:**
- Tokenizes input
- Applies FizzBuzz rules based on word position
- Counts total replacements
- Preserves all non-word tokens

**Examples:**
```haskell
getOverlappings "one two three"
→ FizzBuzzDetector "one two Fizz" 1

getOverlappings "Mary had a little lamb"
→ FizzBuzzDetector "Mary had Fizz Buzz Fizz" 3
```

### `main :: IO ()`

**Purpose:** Entry point for the interactive application

**Behavior:**
- Displays welcome message
- Prompts for user input
- Calls `getOverlappings` on input
- Displays formatted results

## Test Suite Overview

The project includes 5 comprehensive test cases covering various scenarios:

| Test | Input | Expected Matches | Purpose |
|------|-------|-----------------|---------|
| TEST 1 | Mary had a little lamb... (full nursery rhyme) | 9 | Complex text with multiple matches |
| TEST 2 | Hi there | 0 | Text with no matches |
| TEST 3 | one two three... (number names) | 7 | Straightforward FizzBuzz sequence |
| TEST 4 | Hello, world! It's a beautiful day. | 3 | Text with punctuation |
| TEST 5 | Haskell | 0 | Single word, no matches |

**Test Execution Process:**
Each test case runs the `getOverlappings` function and verifies:
- Output string matches expected result exactly
- Match count equals expected count
- Tests are run sequentially and report individual pass/fail status

## Development

### Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/hjvw/Akvelon-test.git
   cd Akvelon-test
   ```

2. Run the main application:
   ```bash
   runhaskell main.hs
   ```

3. Run the tests to verify everything works:
   ```bash
   runhaskell tests.hs
   ```

### Editing Code

You can edit the Haskell source files using any text editor:
- `main.hs` - Contains the primary application logic and I/O handling
- `tests.hs` - Contains test cases and test runner

After making changes, simply run the commands above to see the results.

### Key Implementation Details

**Lazy Evaluation:** The pattern list is infinite but evaluated lazily, only generating as many patterns as needed:
```haskell
patterns = [ if i `mod` 15 == 0 then ("FizzBuzz", 1) 
             else if i `mod` 3 == 0 then ("Fizz", 1) 
             else if i `mod` 5 == 0 then ("Buzz", 1) 
             else ("", 0) | i <- [1..] ]
```

**Pattern Matching:** Uses guards and recursive processing to apply patterns:
```haskell
process (t@(c:_):ts) ps@((repl, count):patternRest)
    | isAlphaNum c =        -- Check if token is alphanumeric (word)
        let (w, cnts) = process ts patternRest 
            actualWord = if null repl then t else repl
        in (actualWord : w, count : cnts)
    | otherwise =           -- Non-alphanumeric (delimiter)
        let (w, cnts) = process ts ps 
        in (t : w, cnts)
```

## Building with Cabal or Stack (Optional)

For larger projects, you may want to use build tools. While not required for this project, here are examples:

### Using Cabal

```bash
cabal build
cabal run main
cabal run tests
```

### Using Stack

```bash
stack build
stack run main
stack run tests
```

## Language Information

- **Primary Language:** Haskell (100%)
- **Language Features Used:**
  - Pure functional programming
  - Lazy evaluation
  - Strong static typing
  - Pattern matching and guards
  - Record types
  - List comprehensions
  - Recursive functions
  - I/O operations via monads

## Contributing

When contributing to this project:

1. Ensure all tests pass: `runhaskell tests.hs`
2. Follow standard Haskell naming conventions
3. Keep code modular and well-documented
4. Add new tests for new functionality
5. Maintain the pure functional style where possible

## Testing

This project includes comprehensive tests. Always verify your changes work correctly by running:

```bash
runhaskell tests.hs
```

A successful test run should display:
- `[PASS]` or `[FAIL]` for each test case
- Summary message: "All 5 verifications passed successfully!"
- Exit code 0 on success

### Running Individual Tests

To test specific functionality manually:

```bash
$ runhaskell main.hs
FizzBuzz 
Type your text and press Enter: Mary had a little lamb
Processed Result
Mary had Fizz Buzz Fizz

===================
Total Matches Found: 3
```

## Troubleshooting

### Command not found: `runhaskell`

**Solution:** Ensure GHC is properly installed and added to your system PATH. Try:
```bash
ghc --version
```

If that fails, reinstall GHC from: https://www.haskell.org/downloads/

### Compilation errors

**Solution:** Check that all Haskell files have proper syntax. Common issues:
- Missing type signatures
- Incorrect indentation (Haskell is whitespace-sensitive)
- Missing imports
- Mismatched parentheses or brackets

### Tests failing

**Solution:** Review the test output for detailed error messages and ensure:
- The main application compiles without errors
- All required functions are implemented
- Edge cases are handled properly
- Output exactly matches expected strings (case-sensitive)

### Performance issues

**Solution:** For large input texts, note that:
- Haskell's lazy evaluation may appear slow on first run
- The infinite pattern list is only evaluated as needed
- Consider using compiled version with `ghc -O2 main.hs` for speed

## License

This project is provided as-is for testing and educational purposes.

## Support

For issues or questions, please open an issue on the GitHub repository.

---

**Last Updated:** June 2026
**Language:** Haskell (100%)
**Main Features:** FizzBuzz Pattern Matching, Text Tokenization, Functional Programming Patterns
