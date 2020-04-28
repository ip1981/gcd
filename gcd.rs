use std::env;

fn gcd2(mut a: u64, mut b: u64) -> u64 {
    while b != 0 {
        let c = b;
        b = a % b;
        a = c;
    }

    a
}

fn main() {
    // XXX skip(1) to skip program name:
    let nums = env::args().skip(1).map(|s| s.parse().unwrap());

    let gcd = nums.fold(0, gcd2);

    println!("{}", gcd);
}
