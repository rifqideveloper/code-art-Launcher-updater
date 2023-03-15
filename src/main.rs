

use std::process::Command;
fn main() {
    if cfg!(target_os = "windows") {
        std::fs::rename("./codeartstudio.exe.update", "./codeartstudio.exe").ok();
        std::fs::rename("./codeartstudio.pck.update", "./codeartstudio.pck").ok();
        Command::new("codeartstudio").output().expect("failed to execute process");
    } else {

    }
}
