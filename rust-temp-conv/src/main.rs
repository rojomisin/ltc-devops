// convert F to C, and C to F temperature
// usage: ./f2c-c2f <number><char>
// ex: ./temperature-conversion 75F
// ex: ./temperature-conversion 22c

use std::env::{args, Args};

fn main() {
    let mut _args: Args = args();
    let mut _raw = String::new();
    _raw = _args.next().unwrap();
    _raw = _args.next().unwrap();

    let strlen = _raw.len();
    let numpartlen = strlen - 1;
    let _c: char = _raw.as_bytes()[strlen - 1] as char;

    let numo = _raw.to_owned();
    let numpart = &numo[0..numpartlen];
    let numf: f64 = numpart.parse().unwrap();

    let mut result: f64 = 0.0;
    if _c == 'f' || _c == 'F' {
        // convert F to C
        result = (numf - 32.0) / 1.8;
        println!("{}C", result);
    } else if _c == 'c' || _c == 'C' {
        // convert C to F
        result = (1.8 * numf) + 32.0;
        println!("{}F", result);
    } else {
        // if not a valid character F or C panic!
        panic!(
            "must be entered as 75F or 23c, no other letters allowed {}",
            result
        )
    }
}
