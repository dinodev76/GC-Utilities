# GC-Examples

Various GnuCOBOL utility programs packaged for easy compiling and running using Visual Studio Code.

## Getting Started

These instructions will get you a copy of the project up and running on your local Windows machine for development and testing purposes.

### Prerequisites

1. GnuCOBOL
2. Your favorite IDE (mine is the free Visual Studio Code)

### Installing

1. Download GnuCOBOL:
    See the options at https://www.arnoldtrembley.com/GnuCOBOL.htm.
    For Windows 64 bit, a real easy way to go is https://www.arnoldtrembley.com/GC30B-64bit-rename-7z-to-exe.7z, and the following instructions assume this.

2. Rename the '.7z' to '.exe' and run it, or use 7-Zip to extract all folders/files to C:\GnuCOBOL (or your desired location). A Windows install is not required. Your folder structure should look like this:

<pre>
    GnuCOBOL   
        bin  
        etc  
        include  
        lib  
        share  
        x86_64-w64-mingw32 
</pre>

3. If you do not already have VS Code, download and install it from here: https://code.visualstudio.com/download.

4. Download the GC-Utilities project, e.g. to C:\GC-Utilities. Your folder structure should look something like this:

<pre>
    GC-Utilities  
        .vscode 
        Bin 
        CopyBooks  
        Data
        Listings
        Utilities  
</pre>

5. Run VS Code and select File/Open Folder..., and open the above GC-Utilities folder to get started. It is important to do the Open Folder instead of opening individual files!

## Compiling and Running the Utility Programs

1. **BITWISE**: This subroutine performs bitwise operations (AND, OR and XOR) on the specified inputs.

    To compile it from VS Code, click on BITWISE.cob and select Terminal/Run Task.../Compile Selected Subroutine. That will create BITWISE.dll in the BIN folder.

    The Utilities folder contains C# program CobolBitwiseGen that generates the copybook BITWISEW used by the BITWISE program.

2. **BITWISET**: This program tests the BITWISE subroutine.

    To compile and run it from VS Code, click on BITWISET.cob and select Terminal/Run Task.../Compile and Run Selected Main Program.

3. **CRC32**: This subroutine calculates the CRC-32 checksum of the bytes in the input buffer.

    To compile it from VS Code, click on CRC32.cob and select Terminal/Run Task.../Compile Selected Subroutine. That will create CRC32.dll in the BIN folder.

    The Utilities folder contains C# program CobolBitwiseGen that generates the copybook CRC32W used by the CRC32 program.

4. **CRC32T**: This program tests the CRC32 subroutine.

    To compile and run it from VS Code, click on CRC32T.cob and select Terminal/Run Task.../Compile and Run Selected Main Program.

5. **HEXDUMP**: This subroutine converts the bytes in the input buffer to their hexadecimal representation in the output buffer.

    To compile it from VS Code, click on HEXDUMP.cob and select Terminal/Run Task.../Compile Selected Subroutine. That will create HEXDUMP.dll in the BIN folder.

    The Utilities folder contains C# program CobolBitwiseGen that generates the copybook HEXDUMPW used by the HEXDUMP program.

6. **TRNSLAT**: This subroutine converts the bytes in the input buffer to their hexadecimal representation in the output buffer.

    To compile it from VS Code, click on TRNSLAT.cob and select Terminal/Run Task.../Compile Selected Subroutine. That will create TRNSLAT.dll in the BIN folder.

7. **TRNSLATT**: This program uses subroutine **TRNSLAT**  to convert a file from ASCII to EBCDIC.

    To compile and run it from VS Code, click on TRNSLATT.cob and select Terminal/Run Task.../Compile and Run Selected Main Program.

    The utilities folder contains C# program CobolTranslateGen that generates translation table copybooks to be used by a program like TRNSLATT. The programs support single byte character sets only.

## Authors

* **Brian D Pead** - *Initial work*

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

Many thanks to the following:

* Arnold Trembley for the GnuCOBOL builds and instructions - see https://www.arnoldtrembley.com/.
* The many developers of GnuCOBOL and its predecessors - see https://sourceforge.net/projects/open-cobol/.
