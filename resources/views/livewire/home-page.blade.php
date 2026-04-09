<div>
    <!-- Hero Slider -->
    <style>
        @keyframes heroFadeUp {
            from { opacity: 0; transform: translateY(30px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .hero-tag   { animation: heroFadeUp 0.55s cubic-bezier(.22,.61,.36,1) both; animation-delay: 0.05s; }
        .hero-title { animation: heroFadeUp 0.6s  cubic-bezier(.22,.61,.36,1) both; animation-delay: 0.2s; }
        .hero-desc  { animation: heroFadeUp 0.6s  cubic-bezier(.22,.61,.36,1) both; animation-delay: 0.35s; }
        .hero-btn   { animation: heroFadeUp 0.6s  cubic-bezier(.22,.61,.36,1) both; animation-delay: 0.5s; }

        .hero-slider {
            position: relative !important;
            width: 100%;
            height: 560px;
            overflow: hidden;
        }
        .hero-slides-wrap {
            position: absolute;
            inset: 0;
        }
        .hero-dots {
            position: absolute !important;
            bottom: 24px !important;
            left: 0;
            right: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            z-index: 40;
        }
        .hero-dot {
            display: block;
            height: 10px;
            border-radius: 9999px;
            transition: width 0.3s, background-color 0.3s;
            cursor: pointer;
            border: none;
            padding: 0;
            background: rgba(255,255,255,0.55);
            width: 10px;
        }
        .hero-dot.active {
            width: 24px;
            background: #f97316;
        }
        .hero-arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            z-index: 40;
            width: 40px;
            height: 40px;
            border-radius: 9999px;
            background: rgba(255,255,255,0.2);
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            cursor: pointer;
            transition: background 0.2s;
        }
        .hero-arrow:hover { background: rgba(255,255,255,0.4); }
        .hero-arrow.prev  { left: 16px; }
        .hero-arrow.next  { right: 16px; }
    </style>

    <div
        x-data="{
            current: 0,
            slides: [
                {
                    tag: '#Beauty & Makeup',
                    heading: 'Beauty\nMakeup',
                    desc: 'Discover premium beauty and makeup products that bring out your natural glow and confidence.',
                    btn: 'Explore More',
                    image: '{{ asset('images/slider/beauty-makeup.jpg') }}'
                },
                {
                    tag: '#Home & Living',
                    heading: 'Minimalist\nFurniture',
                    desc: 'Experience furniture crafted for comfort and elegance. A treat to your living space.',
                    btn: 'Explore More',
                    image: '{{ asset('images/slider/furniture-1.jpg') }}'
                },
                {
                    tag: '#Latest Technology',
                    heading: 'Top\nElectronics',
                    desc: 'Discover the latest gadgets designed to power your everyday life and creativity.',
                    btn: 'Explore More',
                    image: '{{ asset('images/slider/electronics.jpg') }}'
                }
            ],
            animKey: 0,
            autoPlay: null,
            start() { this.autoPlay = setInterval(() => this.next(), 5500); },
            next()  { this.current = (this.current + 1) % this.slides.length; this.animKey++; },
            go(i)   { this.current = i; this.animKey++; clearInterval(this.autoPlay); this.start(); }
        }"
        x-init="start()"
        class="hero-slider"
    >
        {{-- Slides --}}
        <div class="hero-slides-wrap">
            <template x-for="(slide, i) in slides" :key="i">
                <div
                    x-show="current === i"
                    x-transition:enter="transition-opacity duration-700 ease-in-out"
                    x-transition:enter-start="opacity-0"
                    x-transition:enter-end="opacity-100"
                    x-transition:leave="transition-opacity duration-700 ease-in-out"
                    x-transition:leave-start="opacity-100"
                    x-transition:leave-end="opacity-0"
                    style="position:absolute;inset:0;"
                >
                    <img :src="slide.image" alt=""
                         style="position:absolute;inset:0;width:100%;height:100%;object-fit:cover;object-position:center;"
                         draggable="false" class="select-none">
                    <div style="position:absolute;inset:0;background:linear-gradient(to right, rgba(0,0,0,0.75) 0%, rgba(0,0,0,0.3) 50%, transparent 100%);"></div>
                    <div style="position:absolute;inset:0;display:flex;align-items:center;">
                        <div class="mx-auto max-w-7xl w-full px-4 sm:px-6 lg:px-8">
                            <div class="max-w-xl" :key="animKey">
                                <p class="hero-tag text-orange-400 font-semibold text-sm tracking-widest uppercase mb-3"
                                   x-text="slide.tag"></p>
                                <h1 class="hero-title text-5xl md:text-6xl font-extrabold text-white leading-tight mb-5 whitespace-pre-line"
                                    x-text="slide.heading"></h1>
                                <p class="hero-desc text-gray-300 text-sm md:text-base mb-8 leading-relaxed max-w-sm"
                                   x-text="slide.desc"></p>
                                <a href="{{ route('products.index') }}"
                                   class="hero-btn inline-flex items-center gap-2 bg-white text-gray-900 font-bold px-8 py-3 rounded-full hover:bg-orange-500 hover:text-white transition-all duration-300 text-sm shadow-lg">
                                    <span x-text="slide.btn"></span>
                                    <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </template>
        </div>

        {{-- Prev arrow --}}
        <button @click="go((current - 1 + slides.length) % slides.length)" class="hero-arrow prev" aria-label="Previous">
            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/>
            </svg>
        </button>

        {{-- Next arrow --}}
        <button @click="go((current + 1) % slides.length)" class="hero-arrow next" aria-label="Next">
            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/>
            </svg>
        </button>

        {{-- Dot pagination --}}
        <div class="hero-dots">
            <button @click="go(0)" aria-label="Slide 1">
                <span :class="current === 0 ? 'hero-dot active' : 'hero-dot'"></span>
            </button>
            <button @click="go(1)" aria-label="Slide 2">
                <span :class="current === 1 ? 'hero-dot active' : 'hero-dot'"></span>
            </button>
            <button @click="go(2)" aria-label="Slide 3">
                <span :class="current === 2 ? 'hero-dot active' : 'hero-dot'"></span>
            </button>
        </div>
    </div>

    <!-- Categories Section -->
    <section class="py-16 bg-white">
        <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <h2 class="text-3xl font-bold text-gray-900 mb-8">Shop by Category</h2>
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-6">
                @foreach($categories as $category)
                    <a href="{{ route('products.index', ['category' => $category->slug]) }}" 
                       class="group">
                        <div class="aspect-square rounded-lg overflow-hidden bg-gray-100 mb-3">
                            @if($category->image)
                                <img src="{{ $category->image_url }}" 
                                     alt="{{ $category->name }}"
                                     class="w-full h-full object-cover group-hover:scale-110 transition duration-300">
                            @else
                                <div class="w-full h-full flex items-center justify-center bg-blue-600">
                                    <span class="text-4xl text-white">{{ substr($category->name, 0, 1) }}</span>
                                </div>
                            @endif
                        </div>
                        <h3 class="text-center font-medium text-gray-900 group-hover:text-blue-600">
                            {{ $category->name }}
                        </h3>
                        <p class="text-center text-sm text-gray-500">{{ $category->products_count }} items</p>
                    </a>
                @endforeach
            </div>
        </div>
    </section>

    <!-- Featured Products -->
    <section class="py-16 bg-gray-50">
        <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between mb-8">
                <h2 class="text-3xl font-bold text-gray-900">Featured Products</h2>
                <a href="{{ route('products.index', ['featured' => 1]) }}" 
                   class="text-blue-600 hover:text-indigo-700 font-medium">
                    View All →
                </a>
            </div>
            
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                @foreach($featuredProducts as $product)
                    <livewire:product-card :product="$product" :key="$product->id"  />
                @endforeach
            </div>
        </div>
    </section>

    <!-- New Arrivals -->
    <section class="py-16 bg-white">
        <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between mb-8">
                <h2 class="text-3xl font-bold text-gray-900">New Arrivals</h2>
                <a href="{{ route('products.index', ['sort' => 'newest']) }}" 
                   class="text-blue-600 hover:text-indigo-700 font-medium">
                    View All →
                </a>
            </div>
            
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                @foreach($newArrivals as $product)
                    <livewire:product-card :product="$product" :key="'new-' . $product->id"  />
                @endforeach
            </div>
        </div>
    </section>

    <!-- Benefits Section -->
    <section class="py-16 bg-gray-50">
        <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="text-center">
                    <div class="inline-flex items-center justify-center w-16 h-16 bg-indigo-100 text-blue-600 rounded-full mb-4">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">Quality Guarantee</h3>
                    <p class="text-gray-600">All products are carefully selected and quality tested</p>
                </div>
                <div class="text-center">
                    <div class="inline-flex items-center justify-center w-16 h-16 bg-indigo-100 text-blue-600 rounded-full mb-4">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">Fast Shipping</h3>
                    <p class="text-gray-600">Quick delivery right to your doorstep</p>
                </div>
                <div class="text-center">
                    <div class="inline-flex items-center justify-center w-16 h-16 bg-indigo-100 text-blue-600 rounded-full mb-4">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold mb-2">Secure Payment</h3>
                    <p class="text-gray-600">Your payment information is safe with us</p>
                </div>
            </div>
        </div>
    </section>
</div>
