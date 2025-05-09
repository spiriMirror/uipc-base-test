#include <cuda_runtime.h>
#include <cub/device/device_select.cuh>
#include <thrust/device_vector.h>
#include <iostream>

void test_device_select(size_t count) {

	std::cout << "Testing DeviceSelect::Flag: Count=" << count << std::endl;

	thrust::device_vector<int> d_in(count);
	thrust::device_vector<int> d_out(count);
	thrust::device_vector<bool> d_flags(count);
	thrust::device_vector<int> d_out_count(1);
	size_t temp_storage_bytes = 0;
	thrust::device_vector<char> d_temp_storage;
	cub::DeviceSelect::Flagged(thrust::raw_pointer_cast(d_temp_storage.data()),
		temp_storage_bytes,
		thrust::raw_pointer_cast(d_in.data()),
		thrust::raw_pointer_cast(d_out.data()),
		thrust::raw_pointer_cast(d_out_count.data()),
		thrust::raw_pointer_cast(d_flags.data()),
		count);
	d_temp_storage.resize(temp_storage_bytes);
	auto F = cub::DeviceSelect::Flagged(thrust::raw_pointer_cast(d_temp_storage.data()),
		temp_storage_bytes,
		thrust::raw_pointer_cast(d_in.data()),
		thrust::raw_pointer_cast(d_out.data()),
		thrust::raw_pointer_cast(d_out_count.data()),
		thrust::raw_pointer_cast(d_flags.data()),
		count);

	if (F != cudaSuccess) {
		std::cerr << "Error: " << cudaGetErrorString(F) << std::endl;
	}
	else {
		std::cout << "Success: " << count << " elements processed." << std::endl;
	}
}

int main()
{
	for (size_t count = 1024; count <= 1024 * 1024; count *= 2) {
		test_device_select(count);
	}
}