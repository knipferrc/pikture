[GtkTemplate (ui = "/com/github/mistakenelf/pikture/window.ui")]
public class Pikture.Window : Adw.ApplicationWindow {
    [GtkChild] private unowned Header header;
    [GtkChild] private unowned Adw.Flap adw_flap;
    [GtkChild] private unowned Sidebar sidebar;
    [GtkChild] private unowned Gtk.Notebook notebook;

    private DialogService dialog_service;
    private Viewport active_viewport;

    public Window (Adw.Application app) {
        Object (
                application: app
        );
    }

    construct {
        this.dialog_service = new DialogService (this);
        this.connect_signals ();
    }

    public void open (GLib.File[] files) {
        foreach (GLib.File file in files) {
            this.add_tab (file);
        }
    }

    private void connect_signals () {
        this.notebook.page_added.connect ((widget, i) => {
            this.active_viewport = widget as Viewport;
            this.notebook.set_current_page ((int) i);
        });

        this.notebook.page_removed.connect (() => {
            if (this.notebook.get_n_pages () == 0) {
                this.notebook.set_visible (false);
                this.adw_flap.set_reveal_flap (false);
                this.sidebar.reset_details ();
                this.header.hide_action_buttons ();
            }
        });

        this.notebook.switch_page.connect ((widget, i) => {
            if (widget != null) {
                this.active_viewport = widget as Viewport;
                this.sidebar.set_file_details (this.active_viewport.get_current_file ());
            }
        });

        this.header.open_file_signal.connect (() => {
            this.dialog_service.open_file_dialog.begin ();
        });

        this.header.delete_file_signal.connect (() => {
            this.dialog_service.open_delete_image_dialog (this.active_viewport.get_current_file ().get_basename ());
        });

        this.header.flap_toggled_signal.connect (() => {
            this.adw_flap.set_reveal_flap (!this.adw_flap.get_reveal_flap ());
        });

        this.header.rotate_clockwise_signal.connect (() => {
            this.active_viewport.rotate_picture (Gdk.PixbufRotation.CLOCKWISE);
        });

        this.header.rotate_counter_clockwise_signal.connect (() => {
            this.active_viewport.rotate_picture (Gdk.PixbufRotation.COUNTERCLOCKWISE);
        });

        this.header.save_file_signal.connect (() => {
            this.dialog_service.save_file_dialog.begin ();
        });

        this.dialog_service.file_opened_signal.connect ((file) => {
            this.notebook.set_visible (true);
            this.add_tab (file);
        });

        this.dialog_service.delete_image_signal.connect (() => {
            this.active_viewport.delete_picture ();
            this.sidebar.reset_details ();
        });

        this.dialog_service.file_save_signal.connect ((file) => {
            this.active_viewport.save_picture (file.get_path (), file.get_basename ());
        });
    }

    private void add_tab (GLib.File file) {
        var viewport = new Viewport ();
        viewport.set_displayed_picture (file.get_path ());

        this.sidebar.set_file_details (file);
        this.adw_flap.set_reveal_flap (true);
        this.header.show_action_buttons ();

        var tab = new Tab (viewport.get_current_file ().get_basename ());
        this.notebook.append_page (viewport, tab);

        tab.close_tab_signal.connect (() => {
            this.notebook.detach_tab (viewport);
        });
    }
}