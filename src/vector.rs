use crate::util;

pub enum TupleType {
    Vector = 0,
    Point = 1,
}

pub type Vector = (f64, f64, f64, u8);
pub type Point = (f64, f64, f64, u8);

pub fn create_vector(x: f64, y: f64, z: f64) -> Vector {
    (x, y, z, TupleType::Vector as u8)
}

pub fn create_point(x: f64, y: f64, z: f64) -> Point {
    (x, y, z, TupleType::Point as u8)
}

pub fn cmp_vector(a: Vector, b: Vector) -> bool {
    if util::equal(a.0, b.0) == false {
        return false;
    }
    if util::equal(a.1, b.1) == false {
        return false;
    }
    if util::equal(a.2, b.2) == false {
        return false;
    }
    return true;
}

// TODO: operator overloading here

pub fn add(a: Vector, b: Vector) -> Vector {
    (a.0 + b.0, a.1 + b.1, a.2 + b.2, TupleType::Vector as u8)
}

pub fn diff(a: Vector, b: Vector) -> Vector {
    (a.0 - b.0, a.1 - b.1, a.2 - b.2, TupleType::Vector as u8)
}

pub fn negate(v: Vector) -> Vector {
    (-v.0, -v.1, -v.2, TupleType::Vector as u8)
}

pub fn scale(v: Vector, scalar: f64) -> Vector {
    (
        scalar * v.0,
        scalar * v.1,
        scalar * v.2,
        TupleType::Vector as u8,
    )
}

pub fn magnitude(v: Vector) -> f64 {
    f64::sqrt(f64::powi(v.0, 2) + f64::powi(v.1, 2) + f64::powi(v.2, 2))
}

pub fn normalize(v: Vector) -> Vector {
    let m = magnitude(v);
    (v.0 / m, v.1 / m, v.2 / m, TupleType::Vector as u8)
}

pub fn dot(a: Vector, b: Vector) -> f64 {
    a.0 * b.0 + a.1 * b.1 + a.2 * b.2
}

pub fn cross(a: Vector, b: Vector) -> Vector {
    // input order dependent
    (
        a.1 * b.2 - a.2 * b.1,
        a.2 * b.0 - a.0 * b.2,
        a.0 * b.1 - a.1 * b.0,
        TupleType::Vector as u8,
    )
}
