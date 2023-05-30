use raytracer::vector;
use raytracer::vector::Point;
use raytracer::vector::TupleType;
use raytracer::vector::Vector;

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_create_point() {
        let p: Point = vector::create_point(4.3, -4.2, 3.1);
        let expected: Point = (4.3, -4.2, 3.1, TupleType::Point as u8);
        assert_eq!(p, expected);
    }

    #[test]
    fn test_create_vector() {
        let v: Vector = vector::create_vector(4.3, -4.2, 3.1);
        let expected: Vector = (4.3, -4.2, 3.1, TupleType::Vector as u8);
        assert_eq!(v, expected);
    }

    #[test]
    fn test_add_vector() {
        let v1: Vector = vector::create_vector(3.0, -2.0, 5.0);
        let v2: Vector = vector::create_vector(-2.0, 3.0, 1.0);
        let sum = vector::add(v1, v2);
        let expected = vector::create_vector(1.0, 1.0, 6.0);
        assert_eq!(sum, expected);
    }

    #[test]
    fn test_diff_vector() {
        let v1: Vector = vector::create_vector(3.0, 2.0, 1.0);
        let v2: Vector = vector::create_vector(5.0, 6.0, 7.0);
        let diff = vector::diff(v1, v2);
        let expected = vector::create_vector(-2.0, -4.0, -6.0);
        assert_eq!(diff, expected);
    }

    #[test]
    fn test_negate_vector() {
        let v1: Vector = vector::create_vector(3.0, -2.0, 5.0);
        let n = vector::negate(v1);
        let expected = vector::create_vector(-3.0, 2.0, -5.0);
        assert_eq!(n, expected);
    }

    #[test]
    fn test_scale_vector() {
        let v: Vector = vector::create_vector(3.0, -2.0, 5.0);
        let scaled = vector::scale(v, 2.0);
        let expected = vector::create_vector(6.0, -4.0, 10.0);
        assert_eq!(scaled, expected);
    }

    #[test]
    fn test_magnitude_vector() {
        let v: Vector = vector::create_vector(1.0, -2.0, 3.0);
        let magnitude = vector::magnitude(v);
        let expected = f64::sqrt(14.0);
        assert_eq!(magnitude, expected);
    }

    #[test]
    fn test_normalize_vector() {
        let v: Vector = vector::create_vector(1.0, 2.0, 3.0);
        let normalized = vector::normalize(v);
        let m = f64::sqrt(14.0);
        let expected = vector::create_vector(1.0 / m, 2.0 / m, 3.0 / m);
        assert_eq!(normalized, expected);
    }

    #[test]
    fn test_dot_vector() {
        let a: Vector = vector::create_vector(1.0, 2.0, 3.0);
        let b: Vector = vector::create_vector(2.0, 3.0, 4.0);
        let dot = vector::dot(a, b);
        let expected = 20.0;
        assert_eq!(dot, expected);
    }

    #[test]
    fn test_cross_vector() {
        let a: Vector = vector::create_vector(1.0, 2.0, 3.0);
        let b: Vector = vector::create_vector(2.0, 3.0, 4.0);
        let c = vector::cross(a, b);
        let expected = vector::create_vector(-1.0, 2.0, -1.0);
        assert_eq!(c, expected);

        let c = vector::cross(b, a);
        let expected = vector::create_vector(1.0, -2.0, 1.0);
        assert_eq!(c, expected);
    }
}
