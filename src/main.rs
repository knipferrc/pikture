use gtk::prelude::{BoxExt, ButtonExt, GtkWindowExt, OrientableExt};
use relm4::{
    adw,
    gtk::{self, traits::WidgetExt},
    ComponentParts, ComponentSender, RelmApp, RelmWidgetExt, SimpleComponent,
};

struct AppModel {
    current_path: String,
}

#[derive(Debug)]
enum AppMsg {
    ChangeCurrentPath,
}

#[relm4::component]
impl SimpleComponent for AppModel {
    type Input = AppMsg;

    type Output = ();
    type Init = u8;

    fn init(
        _current_path: Self::Init,
        root: &Self::Root,
        sender: ComponentSender<Self>,
    ) -> ComponentParts<Self> {
        let model = AppModel {
            current_path: String::from("."),
        };

        let widgets = view_output!();

        ComponentParts { model, widgets }
    }

    fn update(&mut self, msg: Self::Input, _sender: ComponentSender<Self>) {
        match msg {
            AppMsg::ChangeCurrentPath => {
                self.current_path = "Downloads".to_string();
            }
        }
    }

    view! {
        adw::Window {
            set_title: Some("Refile"),
            set_default_size: (700, 400),

            gtk::Box {
                set_orientation: gtk::Orientation::Vertical,
                adw::HeaderBar {},

                gtk::Box {
                    set_orientation: gtk::Orientation::Horizontal,
                    set_spacing: 5,
                    set_margin_all: 5,

                    gtk::Box {
                        set_orientation: gtk::Orientation::Vertical,
                        set_spacing: 5,
                        set_vexpand: true,

                        gtk::Button {
                            set_label: "Home",
                            connect_clicked[sender] => move |_| {
                                sender.input(AppMsg::ChangeCurrentPath);
                            }
                        },
                        gtk::Button {
                            set_label: "Downloads",
                            connect_clicked[sender] => move |_| {
                                sender.input(AppMsg::ChangeCurrentPath);
                            }
                        },
                    },

                    gtk::Separator {},

                    gtk::Box {
                        set_valign: gtk::Align::Start,
                        gtk::Label {
                            #[watch]
                            set_label: &format!("Current Path: {}", model.current_path),
                            set_margin_all: 5,
                        }
                    }
                }
            }
        }
    }
}

fn main() {
    let app = RelmApp::new("org.mistakenelf.pikture");
    app.run::<AppModel>(0);
}