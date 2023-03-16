

use std::process::Command;
fn main() {
    loop {
        if cfg!(target_os = "windows") {
            std::fs::rename("./codeartstudio.exe.update", "./codeartstudio.exe").ok();
            std::fs::rename("./codeartstudio.pck.update", "./codeartstudio.pck").ok();
            
            if let Ok(c) = Command::new("codeartstudio").status()  {
				if let Some(r) = c.code() {
					if r == 12 {
						continue
					}
					
				}
            }
        
        } else {

        }
        break
    }
}
