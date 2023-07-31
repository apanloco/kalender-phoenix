defmodule KalenderWeb.KalenderController do
  use KalenderWeb, :controller

  def index(conn, %{"year" => year, "month" => month}) do
     render(conn, :index, layout: false, year: year, month: month)
  end

end
