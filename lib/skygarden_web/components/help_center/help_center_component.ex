defmodule SkygardenWeb.HelpCenter.HelpCenterComponent do
  use Phoenix.Component

  def help_center_layout(assigns) do
    ~H"""
    <.hero_section />
    <.faq_section />
    """
  end

  def hero_section(assigns) do
    ~H"""
    """
  end
  
  def faq_section(assigns)do
    ~H"""
    """
  end


end
