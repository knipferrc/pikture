use std::path::Path;

use gtk::prelude::{GtkWindowExt, OrientableExt};
use relm4::{
    adw,
    gtk::{self, traits::WidgetExt},
    ComponentParts, ComponentSender, RelmApp, RelmWidgetExt, SimpleComponent,
};

struct App {
    image_path: String,
}

#[derive(Debug)]
enum AppMsg {
    ChangeImagePath,
}

#[relm4::component]
impl SimpleComponent for App {
    type Input = AppMsg;
    type Output = ();
    type Init = ();

    fn init(
        _: Self::Init,
        root: &Self::Root,
        sender: ComponentSender<Self>,
    ) -> ComponentParts<Self> {
        let model = App {
            image_path: String::from("new"),
        };

        let widgets = view_output!();

        ComponentParts { model, widgets }
    }

    fn update(&mut self, msg: AppMsg, _sender: ComponentSender<Self>) {
        match msg {
            AppMsg::ChangeImagePath => self.image_path = String::from("new"),
        }
    }

    view! {
        adw::Window {
            set_title: Some("Pikture"),
            set_default_size: (700, 400),

            gtk::Box {
                set_orientation: gtk::Orientation::Vertical,

                adw::HeaderBar {},

                gtk::Box {
                    gtk::Image {
                        set_vexpand: true,
                        set_hexpand: true,
                        set_from_file: Some("image.png"),
                    }
                }
            }
        }
    }
}

fn main() {
    let app = RelmApp::new("org.mistakenelf.pikture");
    app.run::<App>(());
}
