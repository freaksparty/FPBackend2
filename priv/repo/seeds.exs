alias Fpbackend.Repo
alias FpbackendWeb.Activity
alias FpbackendWeb.Event
alias FpbackendWeb.Sponsor
alias FpbackendWeb.User
alias FpbackendWeb.News

Repo.delete_all Activity
Repo.delete_all Event
Repo.delete_all Sponsor
Repo.delete_all User
Repo.delete_all News

now = Timex.now |> Timex.local

open_date = Timex.shift(now, days: 30)
close_date = Timex.shift(now, days: 35)
reg_open_date = Timex.shift(now, days: 20)
reg_close_date = Timex.shift(now, days: 25)

born_date = Timex.shift(now, years: -20)

Repo.insert! %User{
    login: "user",
    password: "gooduser",
    password_hash: Comeonin.Bcrypt.hashpwsalt("gooduser"),
    name: "User",
    dni: "123456789Z",
    email: "user@user.com",
    phone: "+34900900900",
    shirt_size: "M",
    borndate: born_date
}

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
user = Repo.one User

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

    Repo.insert! %Sponsor{
        event_id: event.id,
        name: "Bandai",
        url: "http://www.bandai.com/",
        image_url: "http://www.bandai.co.jp/e/shared/img/icon/sns.gif",
    }

    Repo.insert! %Sponsor{
        event_id: event.id,
        name: "DealExtreme",
        url: "www.dx.com",
        image_url: "http://www.zurloan.com/wp-content/uploads/2011/08/deal-extreme.png",
    }

    Repo.insert! %Sponsor{
        event_id: event.id,
        name: "Poetry Club",
        image_url: "https://pbs.twimg.com/profile_images/644264040731136000/_xjq-Xiv.jpg",
    }

    image_url = "https://estaticos.muyinteresante.es/uploads/images/pyr/55520750c0ea197b3fd51098/cuac-pato-p.jpg"

    1..11 |> Enum.each( fn(value) ->
        Repo.insert! %News{
            event_id: event.id,
            creator: user.id,
            title: "Awesome New #{value}",
            image_url: (if (:rand.uniform(10) < 6), do: image_url, else: nil),
            content: Elixilorem.paragraphs(3),
            reg_date_created: now,
            reg_date_publish: now,
            priority: :rand.uniform(10) < 2,
            priority_hours: :rand.uniform(24)
        }
    end)

    
end)

