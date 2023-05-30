pub const EPSILON: f64 = 0.00001;

// This is solved with: https://docs.rs/float-cmp/latest/float_cmp/
// But the book has us write our own, so I've obligated to do that.
pub fn equal(a: f64, b: f64) -> bool {
    (a - b).abs() < EPSILON
}
