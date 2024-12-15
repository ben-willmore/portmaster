## Notes

This is a build of doukutsu-rs, see:
 [https://github.com/doukutsu-rs/doukutsu-rs](https://github.com/doukutsu-rs/doukutsu-rs)

Thanks to Studio Pixel/Nicalis for the original game and Cave Story+. Thanks to the doukutsu-rs team for the amazing reimplementation.


## Compile

```
# This was compliled on on arm64 Ubuntu 24.04 as follows:

git clone https://github.com/doukutsu-rs/doukutsu-rs.git
cd doukutsu-rs
patch -p1 < doukutsu-rs.patch # in src/
cargo build --release
```
