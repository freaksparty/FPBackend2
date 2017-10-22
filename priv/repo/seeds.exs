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

lorem = "Curabitur pretium tincidunt lacus. Nulla gravida orci a odio. Nullam varius, turpis et commodo pharetra, est eros bibendum elit, nec luctus magna felis sollicitudin mauris. Integer in mauris eu nibh euismod gravida. Duis ac tellus et risus vulputate vehicula. Donec lobortis risus a elit. Etiam tempor. Ut ullamcorper, ligula eu tempor congue, eros est euismod turpis, id tincidunt sapien risus a quam. Maecenas fermentum consequat mi. Donec fermentum. Pellentesque malesuada nulla a mi. Duis sapien sem, aliquet nec, commodo eget, consequat quis, neque. Aliquam faucibus, elit ut dictum aliquet, felis nisl adipiscing sapien, sed malesuada diam lacus eget erat. Cras mollis scelerisque nunc. Nullam arcu. Aliquam consequat. Curabitur augue lorem, dapibus quis, laoreet et, pretium ac, nisi. Aenean magna nisl, mollis quis, molestie eu, feugiat in, orci. In hac habitasse platea dictumst.\nFusce convallis, mauris imperdiet gravida bibendum, nisl turpis suscipit mauris, sed placerat ipsum urna sed risus. In convallis tellus a mauris. Curabitur non elit ut libero tristique sodales. Mauris a lacus. Donec mattis semper leo. In hac habitasse platea dictumst. Vivamus facilisis diam at odio. Mauris dictum, nisi eget consequat elementum, lacus ligula molestie metus, non feugiat orci magna ac sem. Donec turpis. Donec vitae metus. Morbi tristique neque eu mauris. Quisque gravida ipsum non sapien. Proin turpis lacus, scelerisque vitae, elementum at, lobortis ac, quam. Aliquam dictum eleifend risus. In hac habitasse platea dictumst. Etiam sit amet diam. Suspendisse odio. Suspendisse nunc. In semper bibendum libero.\nProin nonummy, lacus eget pulvinar lacinia, pede felis dignissim leo, vitae tristique magna lacus sit amet eros. Nullam ornare. Praesent odio ligula, dapibus sed, tincidunt eget, dictum ac, nibh. Nam quis lacus. Nunc eleifend molestie velit. Morbi lobortis quam eu velit. Donec euismod vestibulum massa. Donec non lectus. Aliquam commodo lacus sit amet nulla. Cras dignissim elit et augue. Nullam non diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In hac habitasse platea dictumst. Aenean vestibulum. Sed lobortis elit quis lectus. Nunc sed lacus at augue bibendum dapibus."

now = Timex.now |> Timex.local

open_date = Timex.shift(now, days: 30)
close_date = Timex.shift(now, days: 35)
reg_open_date = Timex.shift(now, days: 20)
reg_close_date = Timex.shift(now, days: 25)

born_date = Timex.shift(now, years: -20)

Repo.insert! User.registration_changeset(%User{}, %{
    login: "user",
    password: "gooduser",
    name: "User",
    dni: "123456789Z",
    email: "user@user.com",
    phone: "900900900",
    shirt_size: "M",
    borndate: born_date
})

Repo.insert! Event.changeset(%Event{}, %{
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
})

events = Repo.all Event
user = Repo.one User

events |> Enum.each(fn(event) ->
    Repo.insert! Activity.changeset(%Activity{}, %{
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
    })

    Repo.insert! Activity.changeset(%Activity{}, %{
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
    })

    Repo.insert!Activity.changeset( %Activity{}, %{
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
    })

    Repo.insert! Activity.changeset(%Activity{}, %{
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
    })

    Repo.insert! Sponsor.changeset(%Sponsor{}, %{
        event_id: event.id,
        name: "Bandai",
        url: "http://www.bandai.com/",
        image_url: "http://www.bandai.co.jp/e/shared/img/icon/sns.gif",
    })

    Repo.insert! Sponsor.changeset(%Sponsor{}, %{
        event_id: event.id,
        name: "DealExtreme",
        url: "www.dx.com",
        image_url: "http://www.zurloan.com/wp-content/uploads/2011/08/deal-extreme.png",
    })

    Repo.insert! Sponsor.changeset(%Sponsor{}, %{
        event_id: event.id,
        name: "Poetry Club",
        image_url: "https://pbs.twimg.com/profile_images/644264040731136000/_xjq-Xiv.jpg",
    })

    image_url = "https://estaticos.muyinteresante.es/uploads/images/pyr/55520750c0ea197b3fd51098/cuac-pato-p.jpg"

    1..11 |> Enum.each( fn(value) ->
        Repo.insert! News.changeset(%News{}, %{
            event_id: event.id,
            creator: user.id,
            title: "Awesome New #{value}",
            image_url: (if (:rand.uniform(10) < 6), do: image_url, else: nil),
            content: lorem,
            reg_date_created: now,
            reg_date_publish: now,
            priority: :rand.uniform(10) < 2,
            priority_hours: :rand.uniform(24)
        })
    end)

    
end)

