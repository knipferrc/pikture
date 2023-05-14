public class Pikture.App : Adw.Application {
    private MainWindow window;
    private const GLib.ActionEntry[] action_entries = {
        { "quit", GLib.Application.quit },
        { "about", about },
    };

    public App () {
        Object (
                application_id: Constants.APP_ID,
                flags : GLib.ApplicationFlags.HANDLES_OPEN
        );
    }

    construct {
        add_action_entries (action_entries, this);
        set_accels_for_action ("app.quit", { "<Ctrl>Q" });
        set_accels_for_action ("app.about", { "<Ctrl>A" });

        GLib.Intl.setlocale (GLib.LocaleCategory.ALL, "");
        GLib.Intl.bindtextdomain (Constants.GETTEXT_PACKAGE, Constants.LOCALEDIR);
        GLib.Intl.bind_textdomain_codeset (Constants.GETTEXT_PACKAGE, "UTF-8");
        GLib.Intl.textdomain (Constants.GETTEXT_PACKAGE);
    }

    protected override void activate () {
        this.window = new MainWindow (this);
        this.window.present ();

        var settings = new GLib.Settings (Constants.APP_ID);
        settings.bind ("window-height", this.window, "default-height", SettingsBindFlags.DEFAULT);
        settings.bind ("window-width", this.window, "default-width", SettingsBindFlags.DEFAULT);

        if (settings.get_boolean ("window-maximized")) {
            this.window.maximize ();
        }

        if (settings.get_boolean ("window-fullscreen")) {
            this.window.fullscreen ();
        }

        settings.bind ("window-maximized", this.window, "maximized", SettingsBindFlags.SET);
        settings.bind ("window-fullscreen", this.window, "fullscreen", SettingsBindFlags.SET);
    }

    protected override void open (GLib.File[] files, string hint) {
        if (this.window == null) {
            this.window = new MainWindow (this);
        }

        this.window.open (files[0]);
        this.window.present ();
    }

    private void about () {
        var about = new About (active_window);
        about.present ();
    }
}