![C](https://img.shields.io/badge/C-Standard_99-A8B9CC?style=flat&logo=c&logoColor=white)
![GCC](https://img.shields.io/badge/Compiler-GCC-FFCF00?style=flat&logo=gnu&logoColor=black)
![CMake](https://img.shields.io/badge/Build-CMake-064F8C?style=flat&logo=cmake&logoColor=white)
![Make](https://img.shields.io/badge/Build-GNU_Make-003BCC?style=flat&logo=gnu&logoColor=white)
![Architecture](https://img.shields.io/badge/Structure-Modular_(_Header_%2F_Source_)-blue?style=flat)
![Data Structure](https://img.shields.io/badge/Data_Structure-Linked_List-important?style=flat)
![Memory](https://img.shields.io/badge/Memory-Manual_Mgmt-critical?style=flat)
![UI](https://img.shields.io/badge/UI-Console_%2F_CLI-4EAA25?style=flat&logo=gnometerminal&logoColor=white)

# Dictionary Manager

This is a console application written in C for the BME "Programming Fundamentals" course. It functions as a complete multilingual dictionary manager. The system uses a **linked list** to manage multiple bilingual dictionaries and supports full CRUD (Create, Read, Update, Delete) operations for both dictionaries and the word pairs they contain.

The project is built with a modular structure in C and features manual memory management with `debugmalloc.h` for leak detection.

---

## 📚 Features

### Dictionary Management
* List and select from all available dictionaries.
* Create new bilingual dictionaries (e.g., "english_hungarian").
* Delete existing dictionaries from the list.
* Load a dictionary from a custom-formatted `.txt` file.
* Save a dictionary back to a `.txt` file.

### Word Pair Management
* List all word pairs within a selected dictionary.
* Add new word pairs.
* Modify existing word pairs (first, second, or both words).
* Delete specific word pairs.

### Utilities
* **QUIZ Mode:** Practice vocabulary from a selected dictionary. The app tracks correct/incorrect answers.
* **ASCII Art:** Custom ASCII art logo for the text-based UI.
* **Error Handling:** Robust input validation (e.g., checking for numbers in names, menu bounds).

---

## 🛠️ Technical Implementation

* **Language:** C (using `stdio.h`, `stdlib.h`, `string.h`, `stdbool.h`).
* **Architecture:** Modular design separating logic into:
    * `main.c`: Main application loop and menu handling.
    * `lista_muveletek.c`: Linked list management (add/delete/find nodes).
    * `szotar_muveletek.c`: Dictionary-specific operations (add/edit/delete words).
    * `seged.c`: UI helpers, console clearing, and input validation.
* **Core Data Structure:**
    * The primary data structure is a **linked list** (`struct Lista`) where each node represents one dictionary.
    * Each dictionary `struct Szotar` stores its two languages (`char *nyelv1`, `char *nyelv2`).
    * Word pairs are stored in a **static 3D array** (`char szoparok_tomb[2][1000][50+1]`) within each `Szotar` struct, with a hard-coded capacity of 1000 pairs.
* **Memory Management:**
    * All dictionary nodes (`Lista`) and language names are dynamically allocated using `malloc`.
    * Includes `debugmalloc.h` for memory leak and error detection.
    * A `L_Felszabadit` function handles the cleanup of the entire linked list on exit.

---

## 📂 Modular Folder Structure

To enforce clarity and professional organization, the project uses a standard, build-system compatible directory layout:

* **`src/main/c/`**: Contains all C implementation files (`.c`), such as the main program logic and menu modules.
* **`src/main/public/`**: Contains all header files (`.h`), defining the public interfaces and data structures.
* **`data/`**: Stores example dictionary files (e.g., `magyar_olasz.txt`) required for the program to run.
* **`build/`**: The target output directory for compiled objects and the executable.
* **`CMakeLists.txt`**: The configuration file for the CMake build system.

---

## ⚙️ Compilation & Execution

The project supports both **GNU Make** and **CMake** build systems, ensuring cross-platform compatibility.

### A. Using Makefile (Recommended for Linux/MinGW)
The Makefile automatically handles compilation, linking, and copying the required data files.

1.  **Build (Compile & Link):**
    ```bash
    make
    ```
2.  **Run Application:**
    This command builds the project and immediately runs the executable.
    ```bash
    make run
    ```
3.  **Clean Up:**
    Deletes all generated files in the `build/` directory.
    ```bash
    make clean
    ```

### B. Using CMake (Cross-Platform / Visual Studio)
CMake is the industry standard for C projects. It generates the necessary build files for your specific system.

1.  **Generate Build Files:**
    Create the build directory and configure the project.
    ```bash
    cmake -S . -B build
    ```

2.  **Compile:**
    Build the executable. This step also copies the `data/` folder next to the executable automatically.
    ```bash
    cmake --build build
    ```

3.  **Run Application:**
    * **Windows (Visual Studio / MinGW):**
        ```bash
        ./build/Debug/dictionary_manager.exe
        ```
    * **Linux / Mac:**
        ```bash
        ./build/dictionary_manager
        ```

---

## 🖥️ Controls & Menus

The application operates on a two-tiered menu system.

**Main Menu:**
* `[0]` Select Dictionary (leads to Sub-Menu)
* `[1]` Create New Dictionary
* `[2]` Delete Dictionary
* `[3]` Load from File
* `[4]` Exit

**Dictionary Sub-Menu (after selecting a dictionary):**
* `[0]` List Word Pairs
* `[1]` Save to File
* `[2]` Add Word Pair
* `[3]` Modify Word Pair
* `[4] `Delete Word Pair
* `[5]` Start QUIZ
* `[6]` Back to Main Menu

## 💾 File Persistence Format

The program uses a strict, custom format for saving and loading dictionaries.

* **Filename Convention:**
    * Must be in the format `lang1_lang2` or `lang1_lang2.txt`.
    * The program prevents loading a file if a dictionary with that language pair (in that specific order) already exists.
* **File Content Format:**
    * A single line of text containing all data, using `;` and `,` as delimiters.
    * **Format:** `nyelv1;nyelv2;szo1_nyelv1,szo1_nyelv2;szo2_nyelv1,szo2_nyelv2;...`
    * **Example:** `magyar;olasz;alma,mela;korte,pera;kutya,cane;macska,gatto;`

---

## 📦 Releases

| Version | Description | Download |
| :--- | :--- | :--- |
| **v1.0.0** | **Dictionary Manager v1.0.0** - Initial release of the C console application. Features linked-list based dictionary management, file persistence, and quiz mode. | [Source code (zip)](https://github.com/hajdu-patrik/Dictionary-Manager_C/archive/refs/tags/v1.0.0.zip) |