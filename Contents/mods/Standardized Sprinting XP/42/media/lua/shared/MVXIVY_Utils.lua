local MVXIVY_Utils = {}

function MVXIVY_Utils.addComboBoxItems(comboBox, items, defaultItem)
  for i, item in ipairs(items) do
    comboBox:addItem(item, i == defaultItem)
  end
end

--- Creates a factory function for generating combo boxes with specified options.
-- @param comboBoxNamespace The namespace to use for the combo box.
-- @param localizeNamespace The namespace to use for localization.
-- @param UI The UI object to which the combo box will be added.
-- @return A function that takes an options table and returns a combo box.
function MVXIVY_Utils.useComboBoxFactory(comboBoxNamespace, localizeNamespace, UI)
  -- The options table should have the following fields:
  -- @field name The name of the combo box.
  -- @field label The label text for the combo box.
  -- @field items A table of items to add to the combo box.
  -- @field defaultItem The default item to select in the combo box.
  -- @field description (optional) A description to add below the combo box.
  return function (options)
    local comboBox = UI:addComboBox(
      comboBoxNamespace .. options.name,
      getText(localizeNamespace .. options.label)
    )

    MVXIVY_Utils.addComboBoxItems(
      comboBox,
      options.items,
      options.defaultItem
    )

    if options.description then
       UI:addDescription(getText(localizeNamespace .. options.description))
    end

    return comboBox
  end
end

return MVXIVY_Utils