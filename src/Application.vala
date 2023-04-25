public class Pikture.App : Adw.Application {
    private MainWindow main_window;
    private const GLib.ActionEntry[] action_entries = {
        { "quit", GLib.Application.quit },
        { "about", about },
    };

    construct {
        add_action_entries (action_entries, this);
        set_accels_for_action ("app.quit", { "<Ctrl>Q" });
        set_accels_for_action ("app.about", { "<Ctrl>A" });
    }

    public App () {
        Object (application_id: "com.github.mistakenelf.pikture",
                flags : GLib.ApplicationFlags.HANDLES_OPEN
        );
    }

    protected override void activate () {
        this.main_window = new MainWindow (this);
        this.main_window.present ();
    }

    protected override void open (GLib.File[] files, string hint) {
        if (this.main_window == null) {
            this.main_window = new MainWindow (this);
        }

        this.main_window.open (files[0]);
        this.main_window.present ();
    }

    private void about () {
        var about = new About (active_window);
        about.present ();
    }
}