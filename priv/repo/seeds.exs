import Ecto.Query

alias Fpbackend.Repo
alias FpbackendWeb.Activity
alias FpbackendWeb.Event

Repo.delete_all Activity
Repo.delete_all Event

now = Timex.now |> Timex.local

open_date = Timex.shift(now, days: 30)
close_date = Timex.shift(now, days: 35)
reg_open_date = Timex.shift(now, days: 20)
reg_close_date = Timex.shift(now, days: 25)

Repo.insert! %Event{
    name: "FicOnEvent",
    description: "Amazing event created by Freaks Party. All is amazing when it is, indeed, amazing",
    num_participants: 150,
    minimum_age: 18,
    price: 25,
    date_start: open_date,
    date_end: close_date,
    reg_date_open: reg_open_date,
    reg_date_close: reg_close_date,
    rules: "Don't tell anyone about FicOnEvent"
}

events = Repo.all Event

events |> Enum.each(fn(event) ->
    Repo.insert! %Activity{
        event_id: event.id,
        name: "Awesome Workshop",
        description: "Best production ever. Build your own Panda bears.",
        image_url: "https://es.wikipedia.org/wiki/Ailuropoda_melanoleuca#/media/File:Giant_Panda_2004-03-2.jpg",
        num_participants: event.num_participants,
        type: "workshop",
        official: false,
        date_start: open_date,
        date_end: close_date,
        reg_date_open: reg_open_date,
        reg_date_close: reg_close_date,
    }

    Repo.insert! %Activity{
        event_id: event.id,
        name: "Awesome Production",
        description: "Make the higher cookies tower in the world",
        image_url: "https://thumbs.dreamstime.com/b/chocolate-cookie-tower-11761305.jpg",
        num_participants: event.num_participants,
        type: "production",
        official: true,
        date_start: open_date,
        date_end: close_date,
        reg_date_open: reg_open_date,
        reg_date_close: reg_close_date,
    }

    Repo.insert! %Activity{
        event_id: event.id,
        name: "Awesome Tournament",
        description: "Arkanoid tournament. Preliminar rounds for Mundial.",
        image_url: "http://www.funzola.com/screenshots/arkanoid-classic-screen2.jpg",
        num_participants: event.num_participants,
        type: "tournament",
        official: true,
        date_start: open_date,
        date_end: close_date,
        reg_date_open: reg_open_date,
        reg_date_close: reg_close_date,
    }

    Repo.insert! %Activity{
        event_id: event.id,
        name: "Bored Conference",
        description: "Talk about if neighbours are who choose mayor and if mayor is who wants to be the neighbours, mayor",
        image_url: "http://files.cityoffargo.com/content/1c135507c4ae584ad987877f04901f238b54b3f6/01-mahoney_fargo-commisioners_jalanpaul_DSC_8362-2-2.jpg",
        num_participants: event.num_participants,
        type: "conference",
        official: false,
        date_start: open_date,
        date_end: close_date,
        reg_date_open: reg_open_date,
        reg_date_close: reg_close_date,
    }
end)

