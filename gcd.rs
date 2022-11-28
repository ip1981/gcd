// Synopsis:
//
// $ rustc gcd.rs -o gcd-rs
// $ ./gcd-rs 11 22 33 121
// 11
//

use std::{cmp, env, ops};

fn gcd2<T>(mut a: T, mut b: T) -> T
where
    T: cmp::PartialEq + Copy + ops::Rem<Output = T> + ops::Neg<Output = T>,
{
    while b != -b {
        let c = b;
        b = a % b;
        a = c;
    }

    a
}

fn gcdn<T>(nums: impl IntoIterator<Item = T>) -> Option<T>
where
    T: cmp::PartialEq + Copy + ops::Rem<Output = T> + ops::Neg<Output = T>,
{
    nums.into_iter().reduce(gcd2)
}

fn main() {
    let nums = env::args().skip(1).map(|s| s.parse::<i64>().unwrap());

    if let Some(gcd) = gcdn(nums) {
        println!("{gcd}");
    }
}
