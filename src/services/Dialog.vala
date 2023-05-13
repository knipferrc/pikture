public class Pikture.DialogService : GLib.Object {
    public Gtk.Window window { get; construct; }

    public signal void file_opened_signal(GLib.File file);

    public DialogService(Gtk.Window window) {
        Object(
               window: window
        );
    }

    public async void open_file_dialog() {
        var dialog = new Gtk.FileDialog();
        dialog.set_title(_("Select a file"));
        dialog.modal = true;

        try {
            var file = yield dialog.open(this.window, null);

            if (file != null) {
                this.file_opened_signal(file);
            }
        } catch (Error e) {
            print(e.message);
        }
    }
}