public class Pikture.Header : Adw.Bin {
	private Adw.ApplicationWindow window;
	private Gtk.Picture current_image;

	construct {
		var header = new Adw.HeaderBar ();
		var open_button = new Gtk.Button.with_label (_("Open"));
		// open_button.clicked.connect (this.open_button_clicked);
		header.pack_start (open_button);

		this.set_child (header);
	}

	public Header (Adw.ApplicationWindow window) {
		this.window = window;
	}

	private async void open_button_clicked () {
		var dialog = new Gtk.FileDialog ();
		dialog.set_title (_("Select a file"));

		var filter = new Gtk.FileFilter ();
		filter.add_mime_type ("image/*");
		dialog.set_initial_name (name);
		dialog.set_default_filter (filter);
		try {
			var file = yield dialog.open (this.window, null);

			if (file != null) {
				this.current_image.set_filename (file.get_path ());
			}
		} catch (Error e) {
			dialog.dispose ();
		}
	}
}