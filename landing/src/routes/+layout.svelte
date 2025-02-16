<script lang="ts">
	import '../app.css';
	let { children } = $props();

	const description = 'Join the only university-exclusive social media built on the at protocol.';
</script>

<svelte:head>
	<!-- SEO Meta Tags -->
	<title>Boshi</title>
	<meta name="author" content="Matthew DeGuzman, Alex Eum" />

	<!-- Open Graph/Facebook -->
	<meta name="description" content={description} />
	<meta property="og:title" content="Boshi" />
	<meta property="og:description" content={description} />
	<meta
		property="og:image"
		content={`https://${import.meta.env.VITE_BASE_URL}.deguzman.cloud/og-image.png`}
	/>

	<meta property="og:url" content={`https://${import.meta.env.VITE_BASE_URL}.deguzman.cloud`} />
	<meta property="og:type" content="website" />

	<!-- Twitter Card -->
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:site" content="@matthew_d13" />
</svelte:head>
{@render children()}
