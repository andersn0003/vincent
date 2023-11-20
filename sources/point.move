module halo2_verifier::point {
    use halo2_verifier::bn254_types::{G1, Fr, FormatG1Compr};
    use aptos_std::crypto_algebra::{Self, Element};
    use halo2_verifier::scalar::{Self, Scalar};

    struct Point<G> has copy, drop {e: Element<G>}

    public fun default<G>(): Point<G> {
        abort 100
    }

    public fun from_bytes<G, Format>(compressed: vector<u8>): Point<G> {
        let e = std::option::extract(&mut crypto_algebra::deserialize<G, Format>(&compressed));
        Point<G> {e}
    }

    public fun to_bytes<G, Format>(self: &Point<G>): vector<u8> {
        crypto_algebra::serialize<G, Format>(&self.e)
    }

    public fun one<G>(): Point<G> {
        Point<G> { e: crypto_algebra::one<G>() }
    }
    public fun zero<G>(): Point<G> {
        Point<G> { e: crypto_algebra::zero<G>() }
    }
    public fun order<G>(): vector<u8> {
        crypto_algebra::order<G>()
    }
    public fun scalar_mul<G>(point: &Point<G>, scalar: &Scalar): Point<G> {
        Point<G> { e: crypto_algebra::scalar_mul<G, Fr>(&point.e, &scalar::inner(scalar)) }
    }
    public fun multi_scalar_mul<G>(point: &vector<Point<G>>, scalar: &vector<Scalar>): Point<G> {
        abort 100
    }
    public fun double<G>(a: &Point<G>): Point<G>{
        Point<G> { e: crypto_algebra::double<G>(&a.e) }
    }
    public fun add<G>(a: &Point<G>, b: &Point<G>): Point<G> {
        Point<G> { e: crypto_algebra::add<G>(&a.e, &b.e) }
    }
    public fun sub<G>(a: &Point<G>, b: &Point<G>): Point<G> {
        Point<G> { e: crypto_algebra::sub<G>(&a.e, &b.e) }
    }
    public fun neg<G>(a: &Point<G>): Point<G> {
        Point<G> { e: crypto_algebra::neg<G>(&a.e) }
    }
}
