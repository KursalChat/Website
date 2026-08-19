#set page(
  paper: "a4",
  numbering: "1",
  columns: 2,
)
#set par(justify: true)
#set heading(numbering: "1.")
#show link: underline
#set document(title: "Kursal: A peer to peer encrypted messenger", author: "Erik LP. (Kodeur_Kubik), Armand H. (Arlo)")

#place(
  top + center,
  float: true,
  scope: "parent",
  clearance: 2em,
)[
  #align(center, text(17pt)[
    *Kursal: A peer to peer encrypted messenger*
  ])

  #grid(
    columns: (1fr, 1fr),
    align(center)[
      Erik LP. \
      #link("https://github.com/KodeurKubik", "Kodeur_Kubik") \
      #link("mailto:kubik@kursal.chat")
    ],
    align(center)[
      Armand H. \
      #link("https://github.com/Arlo1234", "Arlo") \
      #link("mailto:arlo@kursal.chat")
    ],
  )

  #block(width: 90%, [
    *Abstract* \
    Kursal proposes an end-to-end encrypted, peer-to-peer protocol for exchanging messages and files over a decentralized network. It uses #link("https://signal.org/docs/", [Signal])'s encryption methods combined with #link("https://libp2p.io/", [libp2p])'s protocols to achieve a fully decentralized setup. The network relies on volunteer nodes: the more nodes that are connected, the more robust the network gets. Any node can offer itself as a public relay to help others connect across NATs or behind firewalls. Kursal's objective is to combine security, decentralization and usability into one unified application.
  ])
]

*Version*: 1.5 \
*Date*: August 20, 2026 \
*Website*: https://kursal.chat/

= Introduction
Messaging platforms have become the most widely adopted systems for online communication, file transfers and calls. However, commonly used messengers either do not encrypt messages on their servers or lack transparency. Others compromise user privacy by collecting private user data. Even transparent systems are vulnerable. Governments could still access centralized hosting servers, block or filter content, censor users, or spy on them. This is where Kursal steps in as a potential solution: all messages, files, and calls are end-to-end encrypted and transit over a decentralized network hosted by volunteers.

== Motivation
Growing centralization in digital communication threatens user privacy and autonomy. Proposals like the European Union's Chat Control initiative to scan user messages for harmful content highlight the risk of surveillance becoming normalized under the guise of safety. Kursal aims to demonstrate a different path: a fully decentralized, peer-to-peer protocol for private communication based on modern cryptography. We believe privacy and security can coexist through open, verifiable, and community-driven technology. We do not endorse crimes but believe in non-privacy-intrusive ways of countering them. Our goal is to demonstrate that decentralized peer-to-peer encrypted messaging can achieve the same level of usability and reliability as centralized platforms.

= First Contact <first_contact>
There are three ways for two peers "Alice" and "Bob" to initiate communication over the Kursal network. Each method has its advantages and disadvantages:
- *One-Time Password*: Easy to share. Takes time to publish on the network, is single-use and requires computation.
- *Long-Term Code*: Multiple usage code that requires no computation. File size of 6 KB that must be transferred via an external channel.
- *Nearby Share*: Easy to share. Devices must be on the same Wi-Fi network (which must support mDNS) to initiate the connection.

== With a One-Time Password <otp>
Alice generates a one-time password (referred to as OTP) composed of 8 random words. The interface can also display this code as a QR-code that can be scanned by the other user. The word dataset mainly comes from #link("https://www.eff.org/dice") and we filtered and added words, resulting in a total of #link("https://raw.githubusercontent.com/KursalChat/Kursal/refs/heads/main/kursal-core/src/first_contact/otp_wordlist.txt", [11 080 words]). Alice computes the argon2id @argon2 hash of this OTP, referred to as `OTP_H`; for benchmarks and the exact hashing configuration, see @dht_bruteforce. This hash becomes the key that encrypts an initial payload `(PQXDH_payload, Peer ID, pubkey, relays)` with XChaCha20-Poly1305 @chacha, where `PQXDH_payload` is a PQXDH @signal-pqxdh pre-key bundle. Alice then publishes the encrypted payload to the distributed hash table (DHT) @libp2p-kademlia under the key `SHA-256(OTP_H)` (see @dht for the record format). The DHT key is public, so it is derived by hashing `OTP_H` rather than using it directly: a relay can see where the record is stored but cannot derive the key that decrypts it. The DHT entry expires and is automatically removed after 10 minutes. The public sign key (`pubkey`) is a public Dilithium-5 @crystals-dilithium key that will later prove the integrity of messages. The `relays` entry contains addresses on which Alice can be contacted (direct and relays). Bob may now fetch the corresponding DHT entry by first hashing the OTP he received from an external source. He can then complete the PQXDH protocol and initiate a Double Ratchet @signal-doubleratchet extended by the ML-KEM Braid Protocol @signal-mlkembraid. For Alice to also complete the PQXDH protocol, Bob must send the final PQXDH payload, his public signing key, his public listening addresses (like Alice's `relays`) and a Double Ratchet initial message through a relay.

#figure(
  image("friend_code.svg"),
  caption: [Direct contact with an OTP],
)

== With a Long-Term Code <ltc>
Exchanging individual one-time passwords can be time-consuming. To simplify long-term contact management, Alice creates an object containing her peer ID, an initial PQXDH payload @signal-pqxdh, a public Dilithium-5 @crystals-dilithium signing key as well as public addresses to reach Alice (direct IP or via relays). The PQXDH payload does not contain a one-time pre-key as this payload can be used multiple times by different users. Its Kyber pre-key is kept in cache by Alice and deleted once the Long-Term Code (referred to as LTC) is renewed or invalidated. This object can then be encoded into a ".kursal" file (which is approximately 6 KB in size). After receiving the file, Bob decodes this object and completes the PQXDH protocol by sending the PQXDH payload, his public signing key and his public listening addresses to Alice. They can initiate a Double Ratchet @signal-doubleratchet extended by the ML-KEM Braid Protocol @signal-mlkembraid as described in @otp. Because one bundle is used by many contacts, its pre-keys are not single-use: there is no one-time pre-key, and the Kyber pre-key is kept instead of being deleted after use. This slightly weakens forward secrecy for the first messages of a conversation: until the Double Ratchet takes its first step, those messages rely only on long-lived keys, so they could be exposed if the device is later compromised and the early traffic was recorded. Every later message, and every contact added through a One-Time Password or Nearby Share, keeps full forward secrecy. Because the Long-Term Code also carries no one-time pre-key, its very first handshake message is not intrinsically single-use: an attacker who recorded it could replay it to the publisher to try to establish a duplicate session. The publishing side therefore keeps a short replay cache and, if a contact for that identity already exists, refuses to rebuild the session or reset the mailbox state, so a replayed first message is dropped instead of taking effect.

== Nearby Share
The Nearby Share process allows devices to discover each other over the same local network via multicast DNS (mDNS) or via Bluetooth (BLE). To protect user privacy and prevent unsolicited key exchanges, this is a two-step process:

First, the discovery phase: devices broadcast a beacon containing a randomly generated, ephemeral "adjective-animal" username (e.g., "Orange Mouse"). Users can identify each other using these temporary names.

Second, the handshake phase: one user initiates a connection, and the other must explicitly accept the request. After mutual consent, the public keys and initial PQXDH payloads @signal-pqxdh are exchanged. Both mDNS and Bluetooth are implemented in Kursal.

== Security Code <security_code>
Each security code is unique to each contact and should be verified as soon as the communication is established. It should match on both sides and if not, it very likely means a man-in-the-middle attack is happening. Security codes should *not* be verified by sending them over the chat because in the case of a man-in-the-middle attack, the attacker could impersonate this code as well. Until the code is verified, a session is trust-on-first-use: a party that controls the first-contact channel, for example a cracked One-Time Password or the local network during a Nearby Share, can mount an undetected man-in-the-middle. Only the out-of-band comparison of this code closes that window, so the interface warns the user prominently while a contact remains unverified.

It is computed deterministically from both parties' identity and signing keys, so each side obtains the same result. The two public identity keys and the two Dilithium-5 public signing keys are sorted and concatenated, then hashed with SHA-256. The digest is turned into 8 groups of 4 decimal digits and shown in the interface.

= Continuous Communication <continuous>
Kursal is based on #link("https://github.com/libp2p/rust-libp2p/tree/master/swarm", [rust libp2p's swarm]) architecture. It supports both TCP and QUIC protocols and automatically finds the optimal networking solution. Every link is encrypted at the transport layer before any Kursal payload crosses it: a TCP connection is wrapped in a #link("https://noiseprotocol.org/", [Noise]) XX handshake, which agrees a key with Curve25519 and protects the channel with ChaCha20-Poly1305 @chacha and SHA-256, while a QUIC connection is protected by TLS 1.3. This layer is independent of the end-to-end encryption described in @first_contact and hides from passive observers the metadata a relay would otherwise carry in clear. Each connection initially starts from a relay and will, if possible, be upgraded using #link("https://github.com/libp2p/rust-libp2p/tree/master/protocols/dcutr/", [DCUTR]) (Direct Connection Upgrade Through Relay). This upgrade can be a direct peer-to-peer connection or both peers can attempt a NAT traversal using hole punching. If both of those fail, the connection is maintained through the relay. Each node is identified by its peer ID, derived from an Ed25519 transport keypair that is separate from the identity and signing keys used for messaging. This transport keypair rotates regularly to prevent tracking.

Each message receives a delivery receipt in reply. The receipt travels back through the same end-to-end encrypted session, so its arrival already proves it came from the recipient and no separate signature is needed. A message is marked as delivered only once this receipt arrives.

#figure(
  image("reply_receipt.svg"),
  caption: [Delivery receipt for a received message],
)

== Peer Rediscovery <rediscovery>
Because peer IDs rotate regularly, a contact's transport address can change while one of the two parties is offline. When a node rotates its identity, or its reachable addresses otherwise change, it sends an address-update message over its existing authenticated, encrypted session to every reachable contact, and repeats this announcement periodically as a heartbeat. Contacts that are offline at that moment instead recover the new routing through the offline mailbox described in @offline: every stored bundle carries the sender's current peer ID and addresses, so retrieving queued messages is by itself enough to learn how to reach the sender again.

= Distributed Hash Table <dht>
Several Kursal mechanisms publish records to a Kademlia distributed hash table @libp2p-kademlia hosted by the volunteer network, including one-time password exchange (@otp) and offline messaging (@offline). Because any node may write to the DHT, every record uses a uniform, self-policing format that storing nodes can validate before accepting it.

A record carries its key, its value, a publication timestamp, and a proof-of-work nonce. A storing node checks only the payload size, the timestamp (within the record's lifetime and at most two minutes in the future), and the proof of work. It does not verify authenticity, and it does not need to. A record's value is always encrypted under a key that only the legitimate parties know: the one-time password for an OTP record, or the shared mailbox root for a bundle. A forged record simply fails to decrypt, so no signature is required.

The proof of work requires the publisher to find a nonce such that the Argon2id @argon2 hash of the record (its key, value and timestamp) together with that nonce falls below a fixed target. Argon2id is memory-hard, so the search cannot be cheaply collapsed with GPUs or ASICs the way a plain SHA-256 target could, which keeps honest CPUs and a well-resourced attacker on comparable footing. Two targets exist: a lighter one for short-lived records and a heavier one for long-lived records such as offline bundles. Every write therefore costs measurable computation, which makes flooding the DHT, or a single mailbox, expensive, while verification stays a single Argon2id evaluation. Records expire automatically: short-lived records live for 10 minutes, and long-lived records for up to three weeks, after which the network discards them.

= Offline Messaging <offline>
Two contacts are often offline at the same time, so Kursal stores messages for absent peers in the distributed hash table (@dht) instead of relying on a server. Each pair of contacts shares a private, append-only mailbox that only the two of them can locate or read.

== Mailbox Keys
The two peers build the mailbox roots from two shared secrets: a classical one and a post-quantum one. The classical secret is a Curve25519 Diffie-Hellman agreement: for a One-Time Password or Nearby Share the joining peer generates a fresh ephemeral key and agrees it with the other's one-time pre-key, so the secret is ephemeral; the Long-Term Code, which carries no one-time pre-key, instead agrees the two identity keys directly (see @ltc). The post-quantum secret comes from ML-KEM: during first contact one peer encapsulates to the other's Kyber pre-key and sends the resulting ciphertext, which the other decapsulates, so both end up with the same value. The two secrets are combined through HKDF-SHA256, using both identity public keys as the salt and a different label for each direction, to produce two 32-byte root keys, one per direction. An attacker would have to break both Curve25519 and ML-KEM to recover them, so the mailbox is as quantum-safe as the rest of Kursal. And because only the two peers can compute the roots, no one else can even find the mailbox.

Each direction keeps a counter that only increases. The key under which bundle number $n$ is stored, which we call its tag, is derived from the root and the counter with HKDF-SHA256. Successive tags are therefore pseudo-random and unlinkable: an observer cannot tell that two records belong to the same conversation, nor count how many messages a pair exchanges.

== Bundling and Publication
Outgoing messages, already encrypted with the Double Ratchet @signal-doubleratchet, are queued and grouped into a bundle. A bundle is flushed as soon as any of three thresholds is met: fifteen queued messages, fifteen seconds elapsed since the first message was queued, or 50 KB of accumulated ciphertext. Batching amortizes the per-record proof-of-work cost over several messages.

The bundle contains the queued ciphertexts together with the sender's current peer ID and reachable addresses. It is encrypted with XChaCha20-Poly1305 @chacha under a per-bundle key derived from the root and the counter, then published as a long-lived, proof-of-work record (@dht). The sender's public signing key is deliberately omitted from the record, so a stored bundle reveals nothing about who published it. A bundle is re-published until it is retrieved or until it expires after three weeks.

== Retrieval
A returning peer looks for new bundles by computing the next tags from its receiving root and fetching a window of thirty-two counters in parallel. For each bundle found, the peer decrypts it. Decryption only succeeds with the shared mailbox key, so a bundle that decrypts is necessarily from the contact. The peer then advances its counter and applies the messages it contains. It also adopts the embedded peer ID and addresses, reconnecting directly to a contact whose transport identity rotated while it was away (@rediscovery). Once back online, the peer confirms each retrieved message with the delivery receipt described in @continuous. If a counter stays empty, for example because a bundle has not yet propagated, the peer retries; after 48 hours without progress it skips the gap so that a single lost bundle cannot stall the conversation permanently.

= Data Streams
In order to transfer a large amount or a continuous stream of data like file transfers and calls, Kursal cannot encrypt each packet with Double Ratchet as this method would be too computationally intensive. Therefore, each time a data stream is about to happen (calls, file transfers, ...), both agree on a random, temporary key to encrypt all following packets using the XChaCha20-Poly1305 @chacha protocol. This allows lightweight encryption for one-time transfers. Each peer generates a random 32-byte key that is sent to the other via Double Ratchet. Both peers then concatenate the two random keys, in an order fixed by role, caller before callee for a call and sender before receiver for a file, and pass the result through HKDF-SHA256, so the two sides always agree on the keys. A call, which flows both ways, derives one key per direction; a file transfer, which only flows from sender to receiver, uses a single key. This ensures a cryptographically secure mix that cannot be guessed by compromising one of the original keys. XChaCha20-Poly1305 uses a large random nonce, so keystream reuse is not a concern even for long transfers. Each packet additionally carries a monotonically increasing sequence number that is authenticated as associated data, and the receiver rejects any sequence number it has already accepted, so packets cannot be silently replayed, reordered or moved between transfers. For file transfers, the sender also announces a BLAKE2s-256 digest of the whole file, which the receiver recomputes once the transfer completes and rejects on mismatch, so truncation or corruption is caught even though every individual packet was already authenticated.

= Local Storage <storage>
Everything Kursal keeps on the device, namely messages, contacts, Signal sessions, pre-keys, file transfer records and settings, lives in an embedded #link("https://github.com/cberner/redb", [redb]) database, and no value is ever written to it in clear. Each value is sealed with XChaCha20-Poly1305 @chacha under the database key, with a fresh random nonce per write, so two identical values never produce the same ciphertext and a stolen database file leaks neither content nor repetition.

The database key is not kept next to the data. A 32-byte master secret is generated on first launch and stored in the secret store of the operating system: Keychain on macOS and iOS, Credential Manager on Windows, Keystore on Android and the Secret Service on Linux. The database key is then derived from that master secret with HKDF-SHA256 under a fixed label. If the master secret is missing while a database file exists, Kursal refuses to start.

== Backups
A user can export the whole state, master secret included, as a single encrypted backup file. A 16-byte random salt is drawn, a key is derived from a user-chosen password with Argon2id @argon2, and the archive is sealed with ChaCha20-Poly1305 @chacha under a fresh random nonce. Salt and nonce travel in clear inside the file, while the password never leaves the device. A backup therefore rests on the strength of that password alone rather than on the device's secret store, which is what makes it restorable on another machine.

= Implementation
We propose a Kursal implementation written in Rust available at #link("https://kursal.chat/repository") under the #link("https://www.gnu.org/licenses/agpl-3.0.html", [GNU AGPLv3]) license, available on Linux, macOS, Windows, Android and iOS. Our implementation uses Signal's #link("https://github.com/signalapp/libsignal", [libsignal]) and libp2p's #link("https://github.com/libp2p/rust-libp2p", [rust-libp2p]) libraries. The Double Ratchet payload encryption therefore follows libsignal's construction: message keys are derived from the ratchet chain with HKDF-SHA256, the message content is encrypted with AES-256-CBC and the resulting ciphertext is authenticated with HMAC-SHA256. Kursal does not use libsignal's sealed sender envelopes, since the offline mailbox described in @offline already publishes bundles that carry no sender key of any kind.

We plan to improve this initial version over time by adding group conversations and broadcasting channels. These features are listed on our #link("https://github.com/orgs/KursalChat/projects/1", [TODO list]) and will be implemented over time.

= Risk Mitigation <risks>
== DHT Interception <dht_interception>
Intercepting the DHT is defined by accessing an encrypted initial PQXDH payload by finding the OTP. In a hypothetical scenario, a hacker could pre-compute all pairs of OTP and their hash and decrypt the payload. The initial payload does not contain any sensitive information as it is only made up of public keys. The hacker could attempt a man-in-the-middle attack but it could be detected by a different security code (see @security_code).

== DHT Brute Forcing <dht_bruteforce>
To evaluate possible risks of pre-calculating every possible OTP and its corresponding hash, we can estimate how long it would take to compute. Given a computer hashing speed of $"CS"=1000$ hashes per second and per device, a time period of $1000$ years, which approximates to $T ≈ 3 * 10^10$ seconds. Rounding the wordlist down to 11 000 words, the number of possible OTPs is $P = 11000^8 = 2.14 * 10^32$. We can approximate the number of devices $D$ needed with this hashing speed to calculate every possibility:
$ D = (P) / ("CS" * T) ≈ 7.1 * 10^18 "devices" $
This means that in order to intercept 0.1% of the DHT entries, one would need to compute at $1000$ hashes per second for $1000$ years with $7.1 * 10^15$ devices. And for one interception in a million, it drops to $7.1 * 10^12$ devices for the next $1000$ years at $1000$ hashes per second. These figures describe covering a fraction of all live DHT records at once; brute forcing one chosen target's OTP is a separate and even harder problem, as it still costs on the order of $P slash 2$ Argon2id evaluations to land a single chosen record. For more details about what DHT interceptions lead to, refer to @dht_interception.

The Argon2id configuration used is deliberately tuned to take a significant amount of time on modern computers. We are therefore well under the theoretical 1000 hashes per second, making brute-forcing impractical and future-proof. Here are the results of the hashing benchmark with:
$"memory" = 256 "MiB"$, $"iterations" = 1$, $"parallelism" = 1$. The high memory limit prevents massive parallelization.

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 6pt,
    align: horizon,
    table.header([*CPU*], [Time per iteration], [Iter./sec. \ (threaded)]),
    // [Intel Core \ i5-14600kf], [709.5 ms \ 35.6 ms (threaded)], "28.07",
    // ender (obsolete)

    [MacBook \ Pro M5], [194.9 ms \ 19.6 ms (threaded)], "51.15",
    // kubik

    [Intel Core \ i5-12400F], [497.8 ms \ 41.6 ms (threaded)], "24.02",
    // nite

    // [Intel Core \ i5-10310U], [1536ms \ 192.5ms (threaded)], "5.20",
    // koschi

    [Google \ Pixel 8], [1510 ms \ 169 ms (threaded)], "5.93",
    // arlo
  ),
  caption: [Hashing Benchmark: 1000 iterations],
)

The assumed value of $"CS" = 1000$ hashes per second is an extremely high speed that is not reached by modern computers running the Argon2id configuration above; our fastest measured machine is roughly 20 times slower, so the estimate is deliberately conservative. Brute forcing is therefore theoretically possible but wildly impractical. The protection comes from the size of the keyspace combined with the per-guess Argon2id cost, and not from secrecy of the salt: the salt ships inside the open-source client and is public, so a fixed salt offers no precomputation barrier on its own. It does not need to, because a precomputed table would require on the order of $10^32$ entries, which is infeasible to build or store regardless of the salt.

== Malicious Relays
Relays, even malicious, will never be able to read your messages as they are encrypted. However, they can observe traffic metadata. Peer ID rotation limits long-term tracking by third parties that only ever see the peer ID, such as passive DHT observers, but it does *not* hide you from a relay that is actively carrying your traffic: that relay sees a stable IP address and connection, and the address-update message you send right after rotating links your old and new peer IDs together. Against a malicious relay, unlinkability therefore requires a network-level anonymiser (Tor, VPN or proxy); without one, the relay also learns your IP address.

== DHT Flooding
Because any node may publish to the distributed hash table, a malicious actor could try to exhaust storage or bury a victim's mailbox under spurious records. Every write is gated by a proof of work (@dht). Flooding the network, or even a single mailbox tag, then costs the attacker real computation for every record, while an honest node still checks each one with a single Argon2id evaluation. Because the proof of work is memory-hard (@dht), an attacker cannot cheaply collapse it with GPUs or ASICs, so the cost stays comparable to that of an honest CPU node. Long-lived records such as offline bundles carry the heavier difficulty. A targeted mailbox flood is not possible in any case, since writing to a specific tag requires the shared root that only the two contacts know.

== Offline Metadata
Offline bundles are stored on untrusted volunteer nodes. Because each mailbox tag is derived from a secret only the two contacts share, a storing node sees only an opaque, random-looking key: it cannot tell which user a record belongs to, tell that two records belong to the same conversation, or count how many messages a pair exchanges. Because the mailbox roots are post-quantum (@offline), this stays true even against a future quantum attacker, which cannot work out the tags from the public identity keys alone. A bundle carries no signature and no sender key of any kind, so a stored bundle cannot be tied to whoever published it. The messages inside are Double Ratchet @signal-doubleratchet ciphertext, so their confidentiality and forward secrecy come from the ratchet itself.

This unlinkability rests on the mailbox roots, so we make them forward-secret rather than a fixed function of long-term keys. Each root is seeded at first contact from the ephemeral pre-key material of the handshake, namely the one-time pre-key and the one-time Kyber secret, whose private halves are erased after use, and not from the static identity keys. Each direction then advances a one-way HKDF chain: the tag and encryption key for counter $n$ are derived from chain state $n$, which is replaced by its successor and wiped before counter $n+1$. Because the chain is one-way and its seed no longer survives on the device, an attacker who later obtains the device's long-term identity keys, even one who had archived the entire public DHT, cannot recompute or link a contact's already-consumed tags. The one exception is the Long-Term Code, whose reusable bundle keeps its pre-key material (@ltc), so its earliest bundles share the same reduced guarantee as its first messages, while every mailbox opened through a One-Time Password or Nearby Share is fully forward-secret.

== Operating System
If the operating system itself is compromised, Kursal cannot guarantee the integrity of messages. The master secret from which the database key is derived (@storage) sits in the #link("https://docs.rs/keyring/latest/keyring/", [keychain]) of the computer, so malware or the operating system itself could read it and, with it, the entire local database. It is up to the user to choose a trusted operating system and keep it secure.

#bibliography("works.bib")
