defimpl Phoenix.Param, for: Rumble.Multimedia.Video do
  def to_param(%{slug: slug, id: id}) do
    "#{id}-#{slug}"
  end
end
