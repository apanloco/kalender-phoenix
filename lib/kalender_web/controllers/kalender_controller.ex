defmodule KalenderWeb.KalenderController do
  use KalenderWeb, :controller
  alias HTTPoison

  def index(conn, %{"year" => year, "month" => month}) do
    case HTTPoison.get("https://calendar-api.akerud.se/#{year}/#{month}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        data = body |> Jason.decode!()
        render(conn, "index.html", layout: false, year: year, month: month, data: data)

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        send_resp(conn, status_code, "Something went wrong")

      {:error, %HTTPoison.Error{reason: _reason}} ->
        send_resp(conn, 500, "Internal server error")
    end
  end

  def home(conn, _params) do
    date = DateTime.utc_now()
    redirect(conn, to: ~p"/#{Map.fetch!(date, :year)}/#{Map.fetch!(date, :month)}")
  end
end
