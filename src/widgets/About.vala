public class Pikture.About : GLib.Object {
    public Gtk.Window window { get; construct; }
    private Adw.AboutWindow about;

    public About (Gtk.Window window) {
        Object (
                window: window
        );
    }

    construct {
        const string copyright = "Copyright \xc2\xa9 2023 Tyler Knipfer";
        const string developers[] = {
            "Tyler Knipfer<knipferrc@gmail.com>",
            null
        };

        this.about = new Adw.AboutWindow () {
            application_icon = Constants.APP_ID,
            application_name = Constants.APP_NAME,
            copyright = copyright,
            developers = developers,
            issue_url = Constants.APP_BUG_TRACKER_URL,
            license_type = Gtk.License.MIT_X11,
            transient_for = this.window,
            translator_credits = _("translator_credits"),
            version = Constants.APP_VERSION,
            website = Constants.APP_HOMEPAGE_URL,
        };
    }

    public void present () {
        this.about.present ();
    }
}