# uipc-base-test
A minimal test case for libuipc's 3rd party.

## Known Issue

- On Windows, some machines will get `Invalid Argument` when calling `cub::DeviceSelect::Flagged(),` which finally throws `CudaErrorInvalidValue`.
  [device_select.cu](./cube_test/device_select.cu)
