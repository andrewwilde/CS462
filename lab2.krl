ruleset Lab2 {
    meta {
        name "lab2"
        author "Andrew Wilde"
    }
    rule first_rule {
        every {
            notify("Andy", "Notifying you.") with sticky = true;
            notify("Second", "Notification") with sticky = true;
        }
    }
}
