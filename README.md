# compiler-lab

这是一个针对编译原理课程实验的改进版且兼容原框架的辅助框架。

## 这个框架改进了什么

先看亮点：

- 提交语义和原框架保持一致，但 `.gitignore` 从黑名单改成了白名单，规避了误识别和手动维护忽略规则的问题。
- 在保留原始 git trace 约束的前提下，引入了更适合 IDEA 使用的 Gradle 工作流，不仅更方便点击运行，也更方便直接调试；这一点是原来的 `make` 流程做不到的。
- 内置了 JUnit 测试和更多测试集，日常开发、回归和调试都更方便。
- `Makefile` 和 `make submit` 仍然保留，所以最终提交方式和原框架一致。

具体来说：

- 重构了 `.gitignore`。原框架使用黑名单思路，容易误识别文件，而且如果你新增了评测无关文件，通常还要手动更新 `.gitignore`。当前框架改成了白名单思路，只显式追踪需要参与提交的核心文件，在保持提交语义与原框架一致的前提下，规避了误识别问题，也不再需要为这些额外文件手动维护忽略规则。
- 新增了 Gradle 配置，把原来 `Makefile` 里的核心能力迁移了过去，包括 ANTLR 生成、编译、运行、测试，以及 git trace 兼容逻辑。原框架里每次编译和测试都会额外生成一次 git 记录，用来追踪开发过程、防止作弊；当前 Gradle 流程保留了这一点，不会因为改用 Gradle 而出问题。
- `Makefile` 只做了少量适配来兼容当前目录结构，所以不管是用 Gradle 还是用 `make`，当前框架都能正常跑通。
- 提交流程没有搬进 Gradle。提交时仍然直接执行 `make submit`，最终效果和原框架一致。
- 当前框架内置了 JUnit 测试，并且补充了更多测试集，日常开发比原框架更方便。

## 代码放哪里

- `src/main/java/Main.java`：统一的程序入口。原框架里每做一个实验阶段，通常都要直接修改 `Main`；当前框架把这个变化点收敛成“在 `Main` 里切换调用哪个阶段入口”。
- `src/main/java/lab*/`：按阶段拆分的预留入口和实现代码。原本应该写在 `Main` 类和 `main` 方法里的阶段性处理流程，现在分别写到这里对应的预留类和入口方法中。
- `src/main/antlr/SysY/`：ANTLR 预留语法文件。`SysYLexer.g4` 里放词法规则，`SysYParser.g4` 里放语法规则。文件里的 `@header { package SysY; }` 是预留给生成代码加包声明的；如果没有这段，ANTLR 生成出来的类就不属于任何包，而当前框架里的实验代码都在包内，包内类不能直接访问无包类。使用时，把具体的词法规则粘贴到 `SysYLexer.g4`，把具体的语法规则粘贴到 `SysYParser.g4`。
- `src/test/java/`：按阶段拆分的 JUnit 测试类。这些测试会直接调用对应的预留入口；如果你要改入口类名、方法名或它们之间的绑定关系，记得同步调整测试。
- `src/test/test-sets/`：按阶段组织的输入输出样例集，可以直接拿来做回归测试。

如果你在 IDEA 里开发，平时主要改这两块：

- `src/main/antlr/SysY/*.g4`
- `src/main/java/**`

## 先替换 `.git`

当前仓库里的 `.git` 追踪的是这个辅助框架本身的必要文件，但这里面有不少文件并不是课程实验最终需要提交的内容。为了让仓库状态尽量和原始实验一致，建议你在 clone 完这个框架后，先把 `.git` 替换成原始实验仓库的 `.git`。

在 Ubuntu 下可以这样做：

```bash
cd 你的框架目录
rm -rf .git
cp -r 原始实验仓库路径/.git ./
```

例如：

```bash
cd ~/codes/compilers/compilers-lab
rm -rf .git
cp -r ~/codes/compilers/Lab/.git ./
```

这个替换有时会让 IDEA 的项目识别状态暂时不稳定，所以更稳妥的做法是：

- 先替换 `.git`，再用 IDEA 打开项目
- 如果你已经打开了 IDEA，再替换 `.git` 后建议直接重启 IDEA

## IDEA / Gradle 怎么用

### 先改 git trace 学号

参考原始文档，先改 [Makefile.git](/home/immortal/codes/compilers/lab-share/Makefile.git:1) 的前两行：

- 第 1 行：`STUID = 你的学号`
- 第 2 行：`STUNAME = 你的姓名`

当前框架额外还需要改 [build.gradle](/home/immortal/codes/compilers/lab-share/build.gradle:26)：

- 第 26 行：`studentId = '你的学号'`

因为 git trace 会读取这些配置。`make` 路径下用的是 `Makefile.git` 里的学号，Gradle 路径下用的是 `build.gradle` 里的 `studentId`；如果你要同时使用两套流程，这两处都要同步。

### Gradle 没有自动导入

如果 IDEA 没自动识别 Gradle，可以按下面顺序操作：

1. 在左侧项目树里找到并打开 `build.gradle`
2. 如果编辑器顶部或右上角出现 `Load Gradle Changes`、`Import Gradle Project` 之类的提示，直接点它
3. 如果没有提示，打开菜单里的 `View -> Tool Windows -> Gradle`，先看右侧是否已经有 `Gradle` 工具窗口
4. 如果右侧已经有 `Gradle` 工具窗口，但任务列表是空的，点工具窗口里的刷新按钮
5. 如果右侧没有 `Gradle` 工具窗口，或者项目还没被识别成 Gradle 项目：
   在 `build.gradle` 文件上点右键，选择 `Link Gradle Project`
6. 选择当前项目的 `build.gradle` 后，等待 IDEA 同步完成
7. 同步完成后，再打开右侧 `Gradle` 工具窗口，确认里面已经能看到当前项目、`Tasks`、`build`、`application`、`verification` 这些节点

只要 Gradle 导入成功，后面的编译、测试、ANTLR 生成都可以直接在 IDEA 里点任务运行。

### 如何生成 ANTLR 代码

在 IDEA 右侧打开 `Gradle` 工具窗口，展开当前项目的 `Tasks`：

1. 打开 `build`
2. 双击 `generateProjectGrammars`

这几个任务的关系是：

- `generateProjectGrammars`：总入口。一般直接运行这个即可，它会负责串起下面所有具体的 grammar 生成任务。
- `generateSysYSysYLexer`：只生成 `SysYLexer.g4` 对应的词法分析器代码。这个更贴近做词法分析实验时的使用场景。
- `generateSysYSysYParser`：只生成 `SysYParser.g4` 对应的语法分析器代码，而且它依赖前面的 lexer 任务，所以运行 parser 任务时也会先生成 lexer。这个更贴近做语法分析实验时的使用场景。

实际使用时建议这样理解：

- 平时正常开发，直接点 `generateProjectGrammars`
- 只改了词法规则，想单独验证 lexer 生成，可以点 `generateSysYSysYLexer`
- 改了语法规则，点 `generateSysYSysYParser` 也可以，但通常直接点总入口更省心

生成结果默认在：

```text
build/generated-src/antlr/main/
```

这里面的文件是生成产物，不要手改。

### 如何运行带 git trace 的主程序

`Main` 不建议直接点左侧运行按钮，而是要在 IDEA 顶部运行配置里手动新增一个 `Gradle` 配置：

1. 打开顶部运行配置下拉框，点击 `Edit Configurations`
2. 点击 `+`，新增一个 `Gradle` 配置
3. `Tasks` 填 `run`
4. 在参数里填写 `-PappArgs=你的测试文件路径`

测试文件路径就填你要传给 `Main` 的输入文件，例如某个 `.sy` 或 `.sysy` 文件路径。配置好之后，直接在 IDEA 顶部选择这个配置，然后点右上角绿色三角运行按钮即可。

这样运行时会自动先走 `traceCompile`，也就是先生成 ANTLR 代码，再执行和原始 `make compile` 兼容的 git trace，最后编译并运行 `Main`。

如果你要调试 `Main`，也是用同一个配置，直接点 IDEA 右上角绿色虫子调试按钮即可。调试时同样会自动先经过 git trace。

### 如何运行带 git trace 的测试

测试不需要手动新增运行配置。直接打开对应测试类：

- 点测试类左侧运行按钮，会运行整个测试类
- 点单个测试方法左侧运行按钮，会只运行这个测试方法

这里会自动关联到带 git trace 的测试流程，不需要你额外手动配置。

如果你要调试测试，直接点测试类或测试方法左侧的调试按钮即可。调试时也会自动关联到带 git trace 的测试流程。

## Make 和 Gradle 怎么选

- 想在 IDEA 里开发、调试、点按钮跑任务：优先用 Gradle
- 想走课程原始流程：继续用 `make`
- 想提交到 OJ：直接 `make submit`

当前框架里两条路都保留了：

```bash
make run FILEPATH=tests/test1.sysy
make test
make submit
```

Gradle 路径则主要通过 IDEA 顶部运行配置运行 `Main`，以及通过测试类左侧按钮运行测试。

日常开发推荐 Gradle，最终提交仍然用 `make submit`。
