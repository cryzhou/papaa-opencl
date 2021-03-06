__kernel void conv_2d(
	__global float *in, 		// W*H input images
	__constant float *filt, 	// K*K filter kernel
	__global float *out, 		// W*H output images
	const int K,				// filter resolution
	const float bias) 			// constant offset/bias
{
	const int W = get_global_size(0);

	// this work item computes output at (x,y) in the output image
	const int x = get_global_id(0); 
	const int y = get_global_id(1);

	float sum = 0;
	int c = 0;

	// loop over rows
	for (int r = 0; r < K; r++) 
	{ 
		// loop over columns
		for(c = 0; c < K; c++)
		{
			sum += filt[r * K + c] * in[(y + r) * (W+K-1) + x + c];
		}
	}
	out[y * W + x] = sum + bias;
}
