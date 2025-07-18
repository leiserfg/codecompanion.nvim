local BaseFormatter = require("codecompanion.strategies.chat.ui.formatters.base")

---@class CodeCompanion.Chat.UI.Formatters.Reasoning : CodeCompanion.Chat.UI.Formatters.Base
local Reasoning = setmetatable({}, { __index = BaseFormatter })
Reasoning.__class = "Reasoning"

function Reasoning:can_handle(message, opts, tags)
  return message.reasoning ~= nil
end

function Reasoning:get_type()
  return self.chat.MESSAGE_TYPES.LLM_MESSAGE -- Reasoning is part of LLM response
end

function Reasoning:format(message, opts, state)
  local lines = {}

  -- Use rich state methods
  if not state.has_reasoning_output then
    table.insert(lines, "### Reasoning")
    table.insert(lines, "")
    state:mark_reasoning_started()
  end

  -- Add reasoning content
  for _, line in ipairs(vim.split(message.reasoning, "\n", { plain = true, trimempty = false })) do
    table.insert(lines, line)
  end

  return lines, nil
end

return Reasoning
