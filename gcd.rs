use std::env;

fn gcd2(a: u64, b: u64) -> u64
{
  let mut a1 = a;
  let mut b1 = b;

  while b1 != 0 {
    let c1 = b1;
    b1 = a1 % b1;
    a1 = c1;
  }

  a1
}


fn main ()
{
  // XXX skip(1) to skip program name:
  let nums = env::args().skip(1).map(|s| s.parse().unwrap());

  let gcd = nums.fold(0, |g, n| gcd2(g, n));

  println!("{}", gcd);
}

