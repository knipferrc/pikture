[GtkTemplate (ui = "/com/github/mistakenelf/pikture/main_window.ui")]
public class Pikture.MainWindow : Adw.ApplicationWindow {
    [GtkChild] private unowned Viewer viewer;
    [GtkChild] private unowned Adw.Flap adw_flap;
    [GtkChild] private unowned Sidebar sidebar;

    private DialogService dialog_service;

    public MainWindow (Adw.Application app) {
        Object (
                application: app
        );
    }

    construct {
        this.dialog_service = new DialogService (this);
        this.handle_signals ();
    }

    public void open (GLib.File file) {
        this.viewer.set_displayed_image (file.get_path ());
        this.sidebar.set_file_details (file);
    }

    private void handle_signals () {
        this.sidebar.update_displayed_image_signal.connect (this.open_button_clicked);
        this.sidebar.delete_displayed_image_signal.connect (this.delete_image_clicked);
        this.dialog_service.file_opened_signal.connect ((file) => {
            this.viewer.set_displayed_image (file.get_path ());
            this.sidebar.set_file_details (file);
        });
    }

    private async void open_button_clicked () {
        this.dialog_service.open_file_dialog.begin ();
    }

    private void delete_image_clicked () {
        this.viewer.delete_picture ();
    }

    [GtkCallback]
    private void on_flap_button_toggled () {
        this.adw_flap.set_reveal_flap (!this.adw_flap.get_reveal_flap ());
    }
}