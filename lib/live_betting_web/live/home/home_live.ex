defmodule LiveBettingWeb.HomeLive do
  use LiveBettingWeb, :live_view

  alias LiveBetting.Schema.{Event, Team}

  def assign_event_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "event")

    if changeset.valid? do
      assign(socket, form_event: form, check_errors: false)
    else
      assign(socket, form_event: form)
    end
  end

  def assign_team_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "team")

    if changeset.valid? do
      assign(socket, form_team: form, check_errors: false)
    else
      assign(socket, form_team: form)
    end
  end

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:modal_active, false)
      |> assign(:trigger_submit, false)
      |> assign_event_form(Event.event_changeset(%Event{}, %{}))
      |> assign_team_form(Team.team_changeset(%Team{}, %{}))
      |> allow_upload(:logo_url, accept: ~w(.jpg .jpeg .png), max_entries: 1, auto_upload: false)
      |> assign(:files, [])
    }
  end

  def handle_event("showModal", %{"context" => context, "value" => _}, socket) do
    {:noreply, socket |> assign(modal_active: !socket.assigns.modal_active) |> assign(:modal_context, context)}
  end

  def handle_event("create_team", params, socket) do
    {:noreply, socket |> assign(modal_active: !socket.assigns.modal_active)}
  end

  def handle_event("validate_team", params, socket) do
    {:noreply, socket |> assign(modal_active: !socket.assigns.modal_active)}
  end

  def handle_event("create_event", params, socket) do
    {:noreply, socket |> assign(modal_active: !socket.assigns.modal_active)}
  end

  def handle_event("validate_event", params, socket) do
    {:noreply, socket |> assign(modal_active: !socket.assigns.modal_active)}
  end
end
