# .editorconfig 键值对照

源文件：仓库根目录 `.editorconfig`（261 行）。本文件保留原始键名与取值，供逐条核对；`SKILL.md` 是可执行摘要。

## 1. 通用段 `[*]`

| 键 | 值 | 含义 |
|---|---|---|
| `charset` | `utf-8` | UTF-8 无 BOM |
| `end_of_line` | `crlf` | 行尾 CRLF |
| `trim_trailing_whitespace` | `false` | 不裁剪行尾空白 |
| `insert_final_newline` | `false` | 文件末尾不强制换行 |
| `indent_style` | `space` | 空格缩进 |
| `indent_size` | `4` | 默认 4 空格，被后文按文件类型覆盖 |

## 2. Microsoft .NET 属性

| 键 | 值 | 含义 |
|---|---|---|
| `csharp_indent_switch_labels` | `false` | `case` 与 `switch` 同级 |
| `csharp_new_line_before_catch` | `false` | `} catch` 同行 |
| `csharp_new_line_before_else` | `false` | `} else` 同行 |
| `csharp_new_line_before_finally` | `false` | `} finally` 同行 |
| `csharp_new_line_before_members_in_object_initializers` | `false` | 初始化器成员前不换行 |
| `csharp_new_line_before_open_brace` | `none` | 所有构造的左大括号同行 |
| `csharp_preferred_modifier_order` | `public, private, protected, async, file, new, internal, abstract, virtual, sealed, readonly, override, extern, unsafe, volatile, static, required` | 修饰符顺序 |
| `csharp_style_prefer_utf8_string_literals` | `true:suggestion` | 优先 `u8` 字面量 |
| `csharp_style_var_elsewhere` | `false:suggestion` | 其他场景不用 `var` |
| `csharp_style_var_for_built_in_types` | `false:suggestion` | 内置类型不用 `var` |
| `csharp_style_var_when_type_is_apparent` | `false:suggestion` | 类型明显也不用 `var` |
| `dotnet_sort_system_directives_first` | `false` | `System` 不强制排在最前 |
| `dotnet_style_parentheses_in_arithmetic_binary_operators` | `never_if_unnecessary:none` | 算术表达式去多余括号 |
| `dotnet_style_parentheses_in_other_binary_operators` | `always_for_clarity:none` | 其他二元运算保留括号 |
| `dotnet_style_parentheses_in_relational_binary_operators` | `never_if_unnecessary:none` | 关系表达式去多余括号 |
| `dotnet_style_predefined_type_for_locals_parameters_members` | `true:suggestion` | 局部变量/参数/成员用 `int`、`string` 等关键字 |
| `dotnet_style_predefined_type_for_member_access` | `true:suggestion` | 成员访问也用关键字，如 `string.Empty` |
| `dotnet_style_qualification_for_event` | `false:suggestion` | 不用 `this.` 修饰事件 |
| `dotnet_style_qualification_for_field` | `false:suggestion` | 不用 `this.` 修饰字段 |
| `dotnet_style_qualification_for_method` | `false:suggestion` | 不用 `this.` 修饰方法 |
| `dotnet_style_qualification_for_property` | `false:suggestion` | 不用 `this.` 修饰属性 |
| `dotnet_style_require_accessibility_modifiers` | `for_non_interface_members:suggestion` | 非接口成员必须写访问修饰符 |

## 3. 命名规则

| `dotnet_naming_rule.*` | 符号范围 | 风格 | 严重级别 |
|---|---|---|---|
| `interfaces_rule` | 所有可见性的 `interface` | `i_upper_camel_case_style`（`I` + PascalCase） | warning |
| `private_constants_rule` | private `const` 字段 | `upper_camel_case_style`（PascalCase） | warning |
| `private_instance_fields_rule` | private 实例字段（含 readonly） | `lower_camel_case_style`（`_` + camelCase） | warning |
| `private_static_fields_rule` | private `static` 字段 | 同上，且 `resharper_exclusive_prefixes_suffixes = true` | warning |
| `private_static_readonly_rule` | private `static readonly` 字段 | `upper_camel_case_style`（PascalCase） | warning |
| `unity_serialized_field_rule` | Unity 序列化字段 | `lower_camel_case_style_1`（camelCase，无前缀） | warning |

关键风格定义：

- `i_upper_camel_case_style`：`capitalization = pascal_case`，`required_prefix = I`
- `lower_camel_case_style`：`capitalization = camel_case`，`required_prefix = _`
- `lower_camel_case_style_1`：`capitalization = camel_case`，无前缀
- `upper_camel_case_style`：`capitalization = pascal_case`，无前缀

## 4. ReSharper 格式化属性

| 键 | 值 | 含义 |
|---|---|---|
| `resharper_align_multiline_binary_expressions_chain` | `false` | 二元表达式链不纵向对齐 |
| `resharper_align_multiline_calls_chain` | `false` | 调用链不纵向对齐 |
| `resharper_align_multiline_ctor_init` | `false` | 构造函数初始化器不对齐 |
| `resharper_align_multiline_extends_list` | `false` | 继承列表不对齐 |
| `resharper_align_multiline_statement_conditions` | `false` | 条件表达式不对齐 |
| `resharper_align_multiline_type_argument` | `false` | 泛型实参不对齐 |
| `resharper_align_multiline_type_parameter` | `false` | 泛型形参不对齐 |
| `resharper_align_ternary` | `none` | 三元表达式不对齐 |
| `resharper_blank_lines_around_function_declaration` | `1` | 方法声明前后 1 空行 |
| `resharper_blank_lines_around_single_line_function_definition` | `1` | 单行方法前后 1 空行 |
| `resharper_blank_lines_before_block_statements` | `1` | 块语句前 1 空行 |
| `resharper_csharp_blank_lines_around_single_line_field` | `1` | 单行字段前后 1 空行 |
| `resharper_braces_for_for` | `required` | `for` 必须带大括号 |
| `resharper_braces_for_foreach` | `required` | `foreach` 必须带大括号 |
| `resharper_braces_for_ifelse` | `required` | `if`/`else` 必须带大括号 |
| `resharper_braces_for_using` | `required_for_multiline_statement` | `using` 仅多行语句需要 |
| `resharper_braces_for_while` | `required` | `while` 必须带大括号 |
| `resharper_braces_redundant` | `false` | 不删除冗余大括号 |
| `resharper_csharp_empty_block_style` | `together` | 空块 `{ }` 同一行 |
| `resharper_csharp_indent_type_constraints` | `false` | 类型约束不缩进 |
| `resharper_csharp_insert_final_newline` | `true` | 与 `insert_final_newline = false` 冲突，以通用段为准 |
| `resharper_csharp_stick_comment` | `false` | 注释不粘在上一行 |
| `resharper_csharp_wrap_after_declaration_lpar` | `true` | 参数折行时左括号后换行 |
| `resharper_disable_space_changes_before_trailing_comment` | `true` | 不调整行尾注释前空格 |
| `resharper_formatter_off_tag` / `on_tag` | `@formatter:off` / `@formatter:on` | 局部关闭格式化的标记 |
| `resharper_function_declaration_return_type_style` | `line_break` | 方法声明返回类型断行 |
| `resharper_function_definition_return_type_style` | `line_break` | 方法定义返回类型断行 |
| `resharper_indent_aligned_ternary` | `false` | 三元不对齐缩进 |
| `resharper_indent_braces_inside_statement_conditions` | `false` | 条件内大括号不额外缩进 |
| `resharper_indent_nested_foreach/for/lock/while/fixed_stmt` | `true` | 嵌套控制语句缩进 |
| `resharper_indent_preprocessor_region` | `no_indent` | `#region` 内容不缩进 |
| `resharper_indent_switch_labels` | `false` | `case` 与 `switch` 同级 |
| `resharper_instance_members_qualify_declared_in` | `base_class` | 仅基类成员需要限定 |
| `resharper_keep_existing_declaration_parens_arrangement` | `false` | 不保留手写参数括号换行 |
| `resharper_line_break_after_colon_in_member_initializer_lists` | `on_single_line` | 初始化器冒号后不换行 |
| `resharper_line_break_before_function_try_block` | `line_break` | `try` 块前换行 |
| `resharper_line_break_before_requires_clause` | `on_single_line` | `requires` 子句同行 |
| `resharper_member_initializer_list_style` | `on_single_line` | 构造函数初始化列表单行 |
| `resharper_namespace_indentation` | `none` | `namespace` 内容不缩进 |
| `resharper_new_line_before_catch` | `false` | `} catch` 同行 |
| `resharper_new_line_before_else` | `false` | `} else` 同行 |
| `resharper_new_line_before_while` | `false` | `} while` 同行 |
| `resharper_outdent_statement_labels` | `true` | 语句标签顶格 |
| `resharper_place_accessorholder_attribute_on_same_line` | `false` | 属性特性另起行 |
| `resharper_place_accessor_attribute_on_same_line` | `false` | 访问器特性另起行 |
| `resharper_place_expr_accessor_on_single_line` | `true` | 表达式体访问器单行 |
| `resharper_place_expr_method_on_single_line` | `true` | 表达式体方法单行 |
| `resharper_place_expr_property_on_single_line` | `true` | 表达式体属性单行 |
| `resharper_requires_expression_braces` | `end_of_line` | `requires` 大括号行尾 |
| `resharper_simple_block_style` | `line_break` | 单语句块换行 |
| `resharper_simple_case_statement_style` | `line_break` | `case` 体换行 |
| `resharper_simple_embedded_statement_style` | `line_break` | 嵌入语句换行 |
| `resharper_space_before_initializer_braces` | `true` | 初始化器 `{` 前留空格 |
| `resharper_space_within_empty_blocks` | `true` | `{ }` 内留空格 |
| `resharper_space_within_empty_initializer_braces` | `true` | 空初始化器 `{ }` 内留空格 |
| `resharper_space_within_initializer_braces` | `true` | `{ 1, 2 }` 内留空格 |
| `resharper_toplevel_function_declaration/definition_return_type_style` | `line_break` | 顶层函数返回类型断行 |
| `resharper_trailing_comma_in_multiline_lists` | `true` | 多行列表尾逗号 |
| `resharper_use_indent_from_vs` | `false` | 不沿用 Visual Studio 缩进设置 |
| `resharper_wrap_after_expression_lbrace` | `false` | 表达式大括号后不换行 |
| `resharper_wrap_base_clause_style` | `chop_if_long` | 基类子句过长才折行 |
| `resharper_wrap_before_arrow_with_expressions` | `true` | 表达式体箭头前换行 |
| `resharper_wrap_before_declaration_rpar` | `true` | 参数折行时右括号单独一行 |
| `resharper_wrap_before_primary_constructor_declaration_rpar` | `true` | 主构造函数右括号单独一行 |
| `resharper_wrap_braced_init_list_style` | `chop_if_long` | 初始化列表过长才折行 |
| `resharper_wrap_ctor_initializer_style` | `chop_if_long` | 构造函数初始化器过长才折行 |
| `resharper_wrap_primary_constructor_parameters_style` | `wrap_if_long` | 主构造函数参数过长才折行 |

`resharper_cpp_*` 键只影响 C/C++，本仓库不适用。

## 5. ReSharper 检查级别

| 键 | 值 |
|---|---|
| `resharper_arrange_redundant_parentheses_highlighting` | `hint` |
| `resharper_arrange_this_qualifier_highlighting` | `hint` |
| `resharper_arrange_trailing_comma_in_multiline_lists_highlighting` | `suggestion` |
| `resharper_arrange_type_member_modifiers_highlighting` | `hint` |
| `resharper_arrange_type_modifiers_highlighting` | `hint` |
| `resharper_built_in_type_reference_style_*_highlighting` | `hint` |
| `resharper_convert_if_statement_to_switch_statement_highlighting` | `none` |
| `resharper_convert_to_primary_constructor_highlighting` | `none` |
| `resharper_suggest_var_or_type_*_highlighting` | `hint` |
| `resharper_mvc_*`、`resharper_razor_assembly_not_resolved`、`resharper_web_config_*` | `warning` |
| `resharper_redundant_base_qualifier_highlighting` | `warning` |

除命名规则（`warning`）外，风格类检查多为 `hint`/`suggestion`，不阻断编译，但改动代码时按规范执行，不要用"编译通过"当作风格合格。

## 6. 按文件类型缩进

| 文件类型 | `indent_size` |
|---|---|
| XML 家族（`*.xml`、`*.xsd`、`*.xsl`、`*.manifest`、`*.nuspec`、`*.dotsettings`、`StyleCop.Cache` 等） | `2` |
| `*.bash`、`*.sh`、`*.zsh` | `2` |
| `*.overridetasks`、`*.targets`、`*.tasks` | `2` |
| `*.props` | `2` |
| `*.androidproj`、`*.ccproj`、`*.csproj` | `2` |
| JSON 家族（`*.json`、`*.jsonc`、`*.har`、`*.postman_collection*`、`.eslintrc`、`.prettierrc`、`*.mcmeta` 等） | `2` |
| `*.yaml`、`*.yml` | `2` |
| C# 与 XAML 等（`*.cs`、`*.cshtml`、`*.xaml`、`*.razor`、C/C++ 头与源、`*.fs`、`*.vb`、shader 等，见文件末尾大括号段） | `4`，`tab_width = 4` |
