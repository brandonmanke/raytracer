const vector = @import("vector.zig");
const Vector = vector.Vector;
const Point = vector.Point;

pub const Environment = struct {
    gravity: Vector(f64),
    wind: Vector(f64),
};

pub const Projectile = struct {
    position: Point(f64),
    velocity: Vector(f64),
};

pub fn tick(env: Environment, proj: Projectile) Projectile {
    const position = proj.position.addVector(proj.velocity);
    const velocity = proj.velocity.add(env.gravity).add(env.wind);
    return .{
        .position = position,
        .velocity = velocity,
    };
}
