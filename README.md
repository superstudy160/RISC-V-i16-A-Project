# HDL-RISC-V-i16-A-Project

### [Submission Paper](./rv-16i-a_g6.pdf)

![](./materials/diagram/diagram.svg)

# Structure of the repository
* The source code can be found in [`src`](./src) folder;
* The source code of the report is located at [`report`](./report) folder;

# Running guide
To start the RISC-V module on the testing instruction set, run the following:
```shell
iverilog -o main ./src/riscv_testbench.v; ./main
```
If you want to change the instructions to be executed, you will have to modify the contents of the Instruction Memory module, that is located at [`src/InstructionMemory/instruction_memory.v`](./src/InstructionMemory/instruction_memory.v).

The default instruction sequence is provided in the following table:
||Binary code|Meaning|
|-|-|-|
|0|{ 3'b`011`, 3'b`000`, 10'sd`2` }|`LUI R0, 2`|
|1|{ 3'b`011`, 3'b`001`, 10'sd`3` }|`LUI R1, 3`|
|2|{ 3'b`111`, 3'b`010`, 3'b`000`, 4'b0, 3'b`001` }|`MUL R2, R0, R1`|
|3|{ 3'b`010`, 3'b`011`, 3'b`010`, `-`7'sd`4` }|`DIVi R3, R2, -4`|

# Architecture reference
## `Flags` register reference
|Index|Description|
|-|-|
|`0`|Multiplication overflow|
|`1`|Division has remainder|
|`2`|Division by zero|
|`3`|Division overflow (when dividing by -1 to get higher result)|

## [Instruction bits reference](https://user.eng.umd.edu/~blj/risc/RiSC-isa.pdf)

# Useful stuff

## 0. Realising Verilog files
https://digitaljs.tilk.eu

## 1. Compiling script:
```shell
iverilog -o main main.v; ./main
```

There is [`tasks.json`](./.vscode/tasks.json) file in the `./vscode` folder, which contrains this script as a task. You can run it automatically on the given file using `Ctrl + Shift + B` shortcut.

## 2. Using GTKWave
```verilog
// GTKwave part
$dumpfile("wave.vcd");
$dumpvars(0, AdderTestbench);
```

### 2.1 Opening the `wave.vcd` in GTKWave

```shell
gtkwave wave.vcd
```

## 3. VScode extensions
Vscode Verilog profile with the installed extensions:
```json
{"name":"Verilog","icon":"chip","extensions":"[{\"identifier\":{\"id\":\"dunstontc.dark-plus-syntax\",\"uuid\":\"dd7e0ff7-9eb5-45fe-8b21-00e79b632b7f\"},\"displayName\":\"dark-plus-syntax\"},{\"identifier\":{\"id\":\"hediet.vscode-drawio\",\"uuid\":\"ea6a6046-2132-421f-a984-664909fcf0b8\"},\"displayName\":\"Draw.io Integration\"},{\"identifier\":{\"id\":\"ms-vscode-remote.remote-ssh\",\"uuid\":\"607fd052-be03-4363-b657-2bd62b83d28a\"},\"displayName\":\"Remote - SSH\"},{\"identifier\":{\"id\":\"ms-vscode-remote.remote-ssh-edit\",\"uuid\":\"bfeaf631-bcff-4908-93ed-fda4ef9a0c5c\"},\"displayName\":\"Remote - SSH: Editing Configuration Files\"},{\"identifier\":{\"id\":\"ms-vscode-remote.remote-wsl\",\"uuid\":\"f0c5397b-d357-4197-99f0-cb4202f22818\"},\"displayName\":\"WSL\"},{\"identifier\":{\"id\":\"ms-vscode.remote-explorer\",\"uuid\":\"11858313-52cc-4e57-b3e4-d7b65281e34b\"},\"displayName\":\"Remote Explorer\"},{\"identifier\":{\"id\":\"tomoki1207.pdf\",\"uuid\":\"4386e6f6-ec10-4463-9d23-c24278718947\"},\"displayName\":\"vscode-pdf\"},{\"identifier\":{\"id\":\"usernamehw.errorlens\",\"uuid\":\"9d8c32ab-354c-4daf-a9bf-20b633734435\"},\"displayName\":\"Error Lens\"},{\"identifier\":{\"id\":\"wavetrace.wavetrace\",\"uuid\":\"d4758eca-b0f6-4fc8-ae47-d2b1b00c0c50\"},\"displayName\":\"WaveTrace\"},{\"identifier\":{\"id\":\"zhuangtongfa.material-theme\",\"uuid\":\"26a529c9-2654-4b95-a63f-02f6a52429e6\"},\"displayName\":\"One Dark Pro\"},{\"identifier\":{\"id\":\"eamodio.gitlens\",\"uuid\":\"4de763bd-505d-4978-9575-2b7696ecf94e\"},\"displayName\":\"GitLens — Git supercharged\"},{\"identifier\":{\"id\":\"ms-vscode.hexeditor\",\"uuid\":\"cc7d2112-5178-4472-8e0e-25dced95e7f0\"},\"displayName\":\"Hex Editor\"},{\"identifier\":{\"id\":\"ms-vsliveshare.vsliveshare\",\"uuid\":\"5a6dc0d5-dc02-4121-8e24-cad33a2ff0af\"},\"displayName\":\"Live Share\"},{\"identifier\":{\"id\":\"muuvmuuv.vscode-sundial\",\"uuid\":\"06c45f72-79b0-400c-a701-c420fa7d0a99\"},\"displayName\":\"Sundial – Automatic night mode and settings switch\"},{\"identifier\":{\"id\":\"shd101wyy.markdown-preview-enhanced\",\"uuid\":\"3b1db1fc-c7f7-4bd6-9fa4-b499dfa99a8a\"},\"displayName\":\"Markdown Preview Enhanced\"},{\"identifier\":{\"id\":\"sterben.fpga-support\",\"uuid\":\"e8882a6f-391a-4fe1-a505-feb7aa26b1c3\"},\"displayName\":\"Digital IDE\"},{\"identifier\":{\"id\":\"streetsidesoftware.code-spell-checker\",\"uuid\":\"f6dbd813-b0a0-42c1-90ea-10dde9d925a7\"},\"displayName\":\"Code Spell Checker\"},{\"identifier\":{\"id\":\"yuyichao.digitaljs\",\"uuid\":\"6163a742-2cce-4fde-9b23-bbb2a9440d3c\"},\"displayName\":\"DigitalJS\"}]"}
```

## 4. [Starting ssh-agent on Ubuntu](https://serverfault.com/a/672386)
```shell
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
```

## 5. Diagrams editor
The editor used to create our diagram: https://draw.io/

The extension for VScode: https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio
