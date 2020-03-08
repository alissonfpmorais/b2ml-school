defmodule B2mlWeb.StudentView do
  use B2mlWeb, :view

  def class_select_options(classes) do
    for class <- classes, do: {class.code, class.id}
  end
end
