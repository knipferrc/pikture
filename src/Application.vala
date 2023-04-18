public class Pikture.App : Adw.Application {
    private MainWindow main_window;
    private const GLib.ActionEntry[] action_entries = {
        { "quit", quit },
        { "about", about },
        { "preferences", preferences },
    };

    public App () {
        Object (application_id: "com.github.mistakenelf.pikture",
                flags : GLib.ApplicationFlags.HANDLES_OPEN
        );

        add_action_entries (action_entries, this);
        set_accels_for_action ("app.quit", { "<Ctrl>Q" });
        set_accels_for_action ("app.about", { "<Ctrl>A" });
        set_accels_for_action ("app.preferences", { "<Ctrl>E" });
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

    private void preferences () {
        var win = new Adw.PreferencesWindow ();
        win.destroy_with_parent = true;
        win.transient_for = active_window;
        win.modal = true;
        win.present ();
    }

    private void about () {
        const string copyright = "Copyright \xc2\xa9 2023 Tyler Knipfer";
        const string developers[] = {
            "Tyler Knipfer<knipferrc@gmail.com>",
            null
        };

        var about = new Adw.AboutWindow () {
            application_icon = "com.github.mistakenelf.pikture",
            application_name = "Pikture",
            copyright = copyright,
            developers = developers,
            issue_url = "https://github.com/knipferrc/pikture/issues",
            license_type = Gtk.License.MIT_X11,
            transient_for = active_window,
            translator_credits = _("translator_credits"),
            version = "0.0.1",
            website = "https://github.com/knipferrc/pikture",
        };

        about.present ();
    }
}