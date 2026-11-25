---
name: arkko-csharp-style
description: 基于 Arkko 的 .editorconfig 提炼出的 C# 代码风格规范，覆盖文件编码与缩进、大括号与换行、命名规则、var 与类型关键字、using 排序、空行、初始化器与折行。当在本仓库或沿用该 .editorconfig 的 .NET 项目中新建或修改 .cs 文件、生成 WinForms/OpenXml 代码、做代码审查或格式检查，或用户提到代码风格、EditorConfig、ReSharper 格式化时使用。
---

# Arkko C# 代码风格

本规范来自仓库根目录 `.editorconfig`。开始写代码前先确认 `.editorconfig` 仍在仓库根目录；若其内容已变化，按新文件为准，并更新本 Skill。

## 文件与空白

- 编码 UTF-8 无 BOM，行尾 CRLF。
- `.cs` 缩进 4 个空格，禁止 Tab；`*.csproj`、`*.props`、XML、JSON、YAML、shell 缩进 2 个空格。
- 不删除行尾空白，但也不要主动制造。
- 文件末尾不加空行：不要为补末尾换行反复改动。
- 需要局部关闭格式化时用 `@formatter:off` / `@formatter:on` 注释标记。

## 大括号与换行

- 左大括号不换行，类型、方法、属性、控制块一律同行。
- `else`、`catch`、`finally` 不换行：写成 `} else {`、`} catch (Exception ex) {`。
- `if`、`else`、`for`、`foreach`、`while` 必须带大括号，即使只有一条语句；也不主动删除冗余大括号。
- `using` 语句只有跨多行时才加大括号。
- 空块写成 `{ }`（同一行，块内保留一个空格）。
- `switch` 的 `case` 标签与 `switch` 同级缩进）。
- `namespace` 内容不缩进；优先使用文件级 `namespace X;`。
- `#region` 内部内容不缩进。

## 命名

| 符号 | 规则 | 示例 |
|---|---|---|
| 接口 | `I` + PascalCase | `IRepository` |
| private const | PascalCase | `private const int MaxRetry = 3;` |
| private 实例字段 | `_` + camelCase | `private bool _isDirty;` |
| private static 字段 | `_` + camelCase | `private static string? _cache;` |
| private static readonly | PascalCase | `private static readonly TimeSpan Timeout = ...;` |
| Unity 序列化字段 | camelCase，无前缀 | `[SerializeField] private int sampleCount;` |

命名规则严重级别为 warning：IDE 会提示，编译不报错，但新代码必须符合。

## 类型、var 与成员引用

- 不在任何位置使用 `var`：局部变量、字段、`using` 声明都写显式类型。
- 优先使用类型关键字：`int`、`string`、`bool`，不写 `Int32`、`String`（包括静态成员访问，如 `string.Empty` 而非 `String.Empty`）。
- 不写 `this.`，字段、属性、方法、事件一律直接引用。
- 非接口成员必须显式写访问修饰符。
- 修饰符顺序：`public, private, protected, async, file, new, internal, abstract, virtual, sealed, readonly, override, extern, unsafe, volatile, static, required`。
  - 例：`public static readonly`、`private static async Task`。
- 算术与关系表达式去掉多余括号；其他二元运算（逻辑 `&&`/`||` 等）保留括号以明确优先级。
- 可用于 `ReadOnlySpan<byte>` 场景时优先 UTF-8 字面量 `"..."u8`（suggestion）。

## using、初始化器与空行

- `using` 指令不强制 `System` 前置，按字母序排列；未使用的 using 直接删除。
- 对象/集合初始化器保持单行：`new ReportFormData { ReportNo = x, ReportId = y }`；初始化器花括号前留一个空格。
- 初始化器花括号内保留空格：`{ 1, 2 }`；空初始化器写 `{ }`。
- 多行初始化列表、多行参数列表末尾加逗号。
- 方法声明前后各留 1 个空行；单行方法定义前后各 1 个空行；单行字段前后各 1 个空行；块语句前留 1 个空行。
- 表达式体成员（属性、方法）写成单行。
- 构造函数初始化列表写成单行。
- 多行参数或调用链不做纵向对齐；参数折行时左括号后换行、右括号单独一行。

## 代码示例

```csharp
public sealed class ReportWriter {
    private const int MaxRetry = 3;
    private static readonly TimeSpan Timeout = TimeSpan.FromSeconds(30);
    private string _outputPath = string.Empty;

    public void Write(string path, byte[] content) {
        if (string.IsNullOrWhiteSpace(path)) {
            return;
        } else {
            _outputPath = path;
            File.WriteAllBytes(path, content);
        }
    }

    public byte[] Read(string path) => File.ReadAllBytes(path);
}
```

## 与存量代码的偏差

- 现有代码可能会出现私有字段没有 `_` 前缀，部分 `catch` 另起一行，还存在 `using var` 写法。新代码按本规范；不要为对齐旧写法而复制这些偏差。
- 需要统一时，用 `dotnet format`（读取 `.editorconfig`）或 ReSharper 的 Code Cleanup 全量格式化，再单独提交。

## 校验

1. `dotnet build` 保证无新增警告。
2. `dotnet format --verify-no-changes` 检查空白、缩进、using 与换行；报告差异时按本规范修正，不要盲目接受工具改写。
3. 新增 `.cs` 文件确认：UTF-8 无 BOM、CRLF、4 空格缩进、无 `var`、无 `this.`。

.editorconfig 的完整键值对照见 `references/editorconfig-rules.md`。
