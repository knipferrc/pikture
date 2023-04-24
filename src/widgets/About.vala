public class Pikture.About : GLib.Object {
    private Gtk.Window window;
    private Adw.AboutWindow about;

    public About (Gtk.Window window) {
        this.window = window;
        this.build_ui ();
    }

    public void build_ui () {
        const string copyright = "Copyright \xc2\xa9 2023 Tyler Knipfer";
        const string developers[] = {
            "Tyler Knipfer<knipferrc@gmail.com>",
            null
        };

        this.about = new Adw.AboutWindow () {
            application_icon = "com.github.mistakenelf.pikture",
            application_name = _("Pikture"),
            copyright = copyright,
            developers = developers,
            issue_url = "https://github.com/mistakenelf/pikture/issues",
            license_type = Gtk.License.MIT_X11,
            transient_for = this.window,
            translator_credits = _("translator_credits"),
            version = "0.0.1",
            website = "https://github.com/mistakenelf/pikture",
        };
    }

    public void present () {
        this.about.present ();
    }
}