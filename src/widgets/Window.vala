[GtkTemplate (ui = "/com/github/mistakenelf/pikture/window.ui")]
public class Pikture.Window : Adw.ApplicationWindow {
    [GtkChild] private unowned Header header;
    [GtkChild] private unowned Adw.Flap flap;
    [GtkChild] private unowned Sidebar sidebar;
    [GtkChild] private unowned Adw.TabView view;
    [GtkChild] private unowned Adw.TabBar tab_bar;
    [GtkChild] private unowned Adw.ToastOverlay toast_overlay;

    private DialogService dialog_service;
    private Canvas active_canvas;

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
        this.view.page_attached.connect ((widget, i) => {
            if (widget != null) {
                this.view.set_selected_page (widget);
                this.active_canvas = widget.child as Canvas;
                this.sidebar.set_file_details (this.active_canvas.get_current_file ());
                widget.set_title (this.active_canvas.get_current_file ().get_basename ());
            }
        });

        this.view.page_detached.connect (() => {
            if (this.view.get_n_pages () == 0) {
                this.view.set_visible (false);
                this.flap.set_reveal_flap (false);
                this.sidebar.reset_details ();
                this.header.hide_action_buttons ();
                this.tab_bar.visible = false;
            }
        });

        this.view.notify["selected-page"].connect (() => {
            var selected_page = this.view.get_selected_page ();
            if (selected_page != null) {
                this.active_canvas = selected_page.child as Canvas;
                this.sidebar.set_file_details (this.active_canvas.get_current_file ());
            }
        });

        this.header.open_file_signal.connect (() => {
            this.dialog_service.open_file_dialog.begin ();
        });

        this.header.delete_file_signal.connect (() => {
            this.dialog_service.open_delete_image_dialog (this.active_canvas.get_current_file ().get_basename ());
        });

        this.header.flap_toggled_signal.connect (() => {
            this.flap.set_reveal_flap (!this.flap.get_reveal_flap ());
        });

        this.header.rotate_clockwise_signal.connect (() => {
            this.active_canvas.rotate_picture (Gdk.PixbufRotation.CLOCKWISE);
        });

        this.header.rotate_counter_clockwise_signal.connect (() => {
            this.active_canvas.rotate_picture (Gdk.PixbufRotation.COUNTERCLOCKWISE);
        });

        this.header.save_file_signal.connect (() => {
            this.dialog_service.save_file_dialog.begin ();
        });

        this.dialog_service.file_opened_signal.connect ((file) => {
            this.view.set_visible (true);
            this.add_tab (file);
        });

        this.dialog_service.delete_image_signal.connect (() => {
            var toast = new Adw.Toast ("%s has been deleted".printf (this.active_canvas.get_current_file ().get_basename ()));
            this.toast_overlay.add_toast (toast);
            this.active_canvas.delete_picture ();
            this.sidebar.reset_details ();
            this.view.close_page (this.view.get_selected_page ());
        });

        this.dialog_service.file_save_signal.connect ((file) => {
            this.active_canvas.save_picture (file.get_path (), file.get_basename ());
        });
    }

    private void add_tab (GLib.File file) {
        var canvas = new Canvas ();
        canvas.set_displayed_picture (file.get_path ());

        this.sidebar.set_file_details (file);
        this.flap.set_reveal_flap (true);
        this.header.show_action_buttons ();
        this.tab_bar.visible = true;

        this.view.add_page (canvas, null);
    }
}
