public class Pikture.MainWindow : Adw.ApplicationWindow {
	private string current_image_uri;
	private Gtk.Image current_image;

	public MainWindow (Gtk.Application app) {
		Object (
		        application: app
		);
	}

	construct {
		this.set_default_size (400, 300);

		var layout_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

		var header = this.construct_header ();
		this.current_image = new Gtk.Image ();
		this.current_image.vexpand = true;
		this.current_image.hexpand = true;

		layout_box.append (header);
		layout_box.append (this.current_image);

		this.set_content (layout_box);
	}

	private async void open_button_clicked () {
		var dialog = new Gtk.FileDialog ();
		dialog.set_title ("Select a file");

		var filter = new Gtk.FileFilter ();
		filter.add_mime_type ("image/*");
		dialog.set_initial_name (name);
		dialog.set_default_filter (filter);
		try {
			var file = yield dialog.open (this, null);

			if (file != null) {
				this.current_image_uri = file.get_uri ();
				this.current_image_uri = this.current_image_uri.replace ("file:///", "/");
				this.current_image.set_from_file (this.current_image_uri);
			}
		} catch (Error e) {
		}
	}

	private Adw.HeaderBar construct_header () {
		var header = new Adw.HeaderBar ();
		var open_button = new Gtk.Button ();
		open_button.label = "Open";

		open_button.clicked.connect (this.open_button_clicked);

		header.pack_start (open_button);

		return header;
	}
}