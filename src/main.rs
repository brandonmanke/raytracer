mod vector;
use vector::Point;
use vector::Vector;

mod util;

fn main() {
    println!("Hello, world!! {}", 1e10);
    let p: Point = vector::create_point(1.0, 2.0, 3.0);
    println!("x: {}, y: {}, z: {}, type: {}", p.0, p.1, p.2, p.3);

    let v: Vector = vector::create_vector(1.0, 2.0, 3.0);
    println!("x: {}, y: {}, z: {}, type: {}", v.0, v.1, v.2, v.3);

    println!("util::equal {}", util::equal(1.0, 1.1));

    let a: Vector = vector::create_vector(1.0, 2.0, 3.0);
    let b: Vector = vector::create_vector(1.0, 2.0, 3.0);
    let c: Vector = vector::create_vector(-1.0, 2.0, 3.0);
    println!("cmp_vector {}", vector::cmp_vector(a, b));
    println!("cmp_vector {}", vector::cmp_vector(b, c));

    let v1: Vector = vector::create_vector(3.0, -2.0, 5.0);
    let v2: Vector = vector::create_vector(-2.0, 3.0, 1.0);
    let sum: Vector = vector::add(v1, v2);
    println!("add_vector = {}, {}, {}, {}", sum.0, sum.1, sum.2, sum.3);

    let v1: Vector = vector::create_vector(3.0, 2.0, 1.0);
    let v2: Vector = vector::create_vector(5.0, 6.0, 7.0);
    let diff: Vector = vector::diff(v1, v2);
    println!(
        "diff_vector = {}, {}, {}, {}",
        diff.0, diff.1, diff.2, diff.3
    );

    let v1: Vector = vector::create_vector(3.0, -2.0, 5.0);
    let n = vector::negate(v1);
    println!("negate = {}, {}, {}, {}", n.0, n.1, n.2, n.3);

    println!("magnitude {}", vector::magnitude(v1));
    let scaled = vector::scale(v1, 2.0);
    println!(
        "scale {}, {}, {}, {}",
        scaled.0, scaled.1, scaled.2, scaled.3
    );

    let norm = vector::normalize(v1);

    let dot = vector::dot(a, b);

    println!("normalize {}, {}, {}", norm.0, norm.1, norm.2);
    println!("dot {}", dot);

    let a: Vector = vector::create_vector(1.0, 2.0, 3.0);
    let b: Vector = vector::create_vector(2.0, 3.0, 4.0);
    let c = vector::cross(a, b);

    println!("cross {}, {}, {}", c.0, c.1, c.2);
}
