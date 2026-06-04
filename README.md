# Akvelon-test

A Haskell project for testing and demonstration purposes.

## Overview

This repository contains Haskell code with comprehensive testing capabilities. The project is structured to separate main application logic from test suites for better organization and maintainability.

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

No additional installation is required beyond having Haskell installed. The project uses only standard Haskell libraries.

## Usage

### Running the Main Application

To execute the main application:

```bash
runhaskell main.hs
```

This command:
- Compiles the `main.hs` file
- Executes the compiled program
- Displays output to the console

### Running Tests

To execute the test suite:

```bash
runhaskell tests.hs
```

This command:
- Compiles the `tests.hs` file
- Runs all test cases
- Reports test results and coverage

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
- `main.hs` - Contains the primary application logic
- `tests.hs` - Contains the test suite

After making changes, simply run the commands above to see the results.

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
- **Language Features:** Pure functional programming, lazy evaluation, strong static typing

## Contributing

When contributing to this project:

1. Ensure all tests pass: `runhaskell tests.hs`
2. Follow standard Haskell naming conventions
3. Keep code modular and well-documented
4. Add new tests for new functionality

## Testing

This project includes comprehensive tests. Always verify your changes work correctly by running:

```bash
runhaskell tests.hs
```

A successful test run should display:
- Number of tests executed
- Passed/failed count
- Any error messages (if applicable)

## Troubleshooting

### Command not found: `runhaskell`

**Solution:** Ensure GHC is properly installed and added to your system PATH. Try:
```bash
ghc --version
```

### Compilation errors

**Solution:** Check that all Haskell files have proper syntax. Common issues:
- Missing type signatures
- Incorrect indentation (Haskell is whitespace-sensitive)
- Missing imports

### Tests failing

**Solution:** Review the test output for detailed error messages and ensure:
- The main application compiles without errors
- All required functions are implemented
- Edge cases are handled properly

## License

This project is provided as-is for testing and educational purposes.

## Support

For issues or questions, please open an issue on the GitHub repository.
