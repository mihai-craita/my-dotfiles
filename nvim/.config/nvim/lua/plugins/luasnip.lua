local ls = require("luasnip")

-- load vscode snippets from friendly-snippets plugin
require("luasnip.loaders.from_vscode").lazy_load()

-- set keybinds for both INSERT and VISUAL.
-- For changing choices in choiceNodes (not strictly necessary for a basic setup).
vim.keymap.set("i", "<C-n>", function() if ls.choice_active() then ls.change_choice(1) end end, {})
vim.keymap.set("s", "<C-n>", function() if ls.choice_active() then ls.change_choice(1) end end, {})
vim.keymap.set("i", "<C-p>", function() if ls.choice_active() then ls.change_choice(-1) end end, {})
vim.keymap.set("s", "<C-p>", function() if ls.choice_active() then ls.change_choice(-1) end end, {})


-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local i = ls.insert_node
local fnode = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function() return {os.date('%Y-%m-%d')} end

ls.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            name = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            fnode(date, {}),
        }),
    },
})

local same = function(args, parent, user_args)
    return args[1][1]
end
local same_uppercase = function(args, parent, user_args)
    local str = args[1][1]
    return str:gsub("%a", string.upper, 1)
end
ls.add_snippets("php", {
    snip(
        {
            trig = "getter",
            name = "Getter and setter",
            dscr = "Getter and setter function for attr"
        },
        {
            text({"/**", " * @var "}),
            fnode(same, {2}, {}),
            text({"", " */", "private "}),
            choice(2, {
                text("string"),
                text("int"),
                text("array"),
                text("bool"),
                text("float"),
                i(nil, "type...")
            }),
            text({ " $"}),
            i(1),
            text({";", "", "public function get"}),
            fnode(same_uppercase, {1}, {}),
            text({"()", "{", "    return $this->"}),
            fnode(same, {1}, {}),
            text({";", "}", "", "public function set"}),
            fnode(same_uppercase, {1}, {}),
            text({"($"}),
            fnode(same, {1}, {}),
            text({")", "{", "    $this->"}),
            fnode(same, {1}, {}),
            text({" = $"}),
            fnode(same, {1}, {}),
            text({";", "    return $this;", "}", ""}),
        },
        {}
    )
})
