defmodule RumbleWeb.AnnotationView do
  use RumbleWeb, :view

  def render("annotation.json", %{annotation: annotation}) do
    %{
      id: annotation.id,
      body: annotation.body,
      at: annotation.at,
      user: render_one(annotation.user, RumbleWeb.UserView, "user.json")
    }
  end
end
