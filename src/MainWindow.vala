using Gtk;

public class Pikture.MainWindow : Adw.ApplicationWindow {
	private Picture current_image;

	construct {
		this.build_ui ();
	}

	public MainWindow (Adw.Application app) {
		Object (
		        application: app
		);
	}

	public void open (GLib.File file) {
		this.current_image.set_filename (file.get_path ());
	}

	private void build_ui () {
		this.set_default_size (700, 500);

		var layout_box = new Box (Orientation.VERTICAL, 0);
		var header = this.construct_header ();

		this.current_image = new Picture ();
		this.current_image.set_margin_bottom (10);
		this.current_image.set_margin_top (10);

		layout_box.append (header);
		layout_box.append (this.current_image);

		this.set_content (layout_box);
	}

	private async void open_button_clicked () {
		var dialog = new FileDialog ();
		dialog.set_title ("Select a file");

		var filter = new FileFilter ();
		filter.add_mime_type ("image/*");
		dialog.set_initial_name (name);
		dialog.set_default_filter (filter);
		try {
			var file = yield dialog.open (this, null);

			if (file != null) {
				this.current_image.set_filename (file.get_path ());
			}
		} catch (Error e) {
		}
	}

	private Adw.HeaderBar construct_header () {
		var header = new Adw.HeaderBar ();
		var open_button = new Button ();
		open_button.label = "Open";

		open_button.clicked.connect (this.open_button_clicked);

		header.pack_start (open_button);

		return header;
	}
}
