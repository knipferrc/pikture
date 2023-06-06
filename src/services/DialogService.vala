public class Pikture.DialogService : GLib.Object {
    public Gtk.Window window { get; construct; }

    public signal void file_opened_signal(GLib.File file);
    public signal void delete_image_signal();
    public signal void file_save_signal(GLib.File file);

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
        } catch (Error error) {
            stderr.printf(error.message);
        }
    }

    public void open_delete_image_dialog(string filename) {
        var alert = new Adw.MessageDialog(this.window, "Are you sure?", "%s will be deleted".printf(filename));
        alert.add_response("cancel", _("Cancel"));
        alert.add_response("delete", _("Delete"));
        alert.set_response_appearance("delete", Adw.ResponseAppearance.DESTRUCTIVE);
        alert.set_default_response("cancel");
        alert.set_close_response("cancel");

        alert.response.connect((dialog, response) => {
            if (response == "delete") {
                this.delete_image_signal();
            }
        });

        alert.present();
    }

    public async void save_file_dialog() {
        var dialog = new Gtk.FileDialog();
        dialog.set_title(_("Save file"));
        dialog.modal = true;

        try {
            var file = yield dialog.save(this.window, null);

            if (file != null) {
                this.file_save_signal(file);
            }
        } catch (Error error) {
            stderr.printf(error.message);
        }
    }
}
