defmodule KalenderWeb.KalenderController do
  use KalenderWeb, :controller

  # def index(conn, _params) do
  #   render(conn, :index, layout: false)
  # end

  def index(conn, %{"year" => year, "month" => month}) do
     render(conn, :index, year: year, month: month)
  end
end
