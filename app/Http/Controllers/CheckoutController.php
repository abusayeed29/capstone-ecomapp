<?php

namespace App\Http\Controllers;

use Stripe\Stripe;
use App\Models\Order;
use App\Mail\OrderConfirmation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Stripe\Checkout\Session as StripeSession;

class CheckoutController extends Controller
{
    public function success(Request $request, $orderId){
        $order = Order::where('id', $orderId)
        ->where('customer_id', auth('customer')->id())
        ->with(['items.product.primaryImage', 'customer'])
        ->firstOrFail();

        // Verify Stripe payment if session_id exists
        if ($request->has('session_id')) {
            Stripe::setApiKey(config('services.stripe.secret'));
            
            try {
                $session = StripeSession::retrieve($request->session_id);
                
                if ($session->payment_status === 'paid' && $order->payment_status !== 'paid') {
                    $order->update([
                        'payment_status' => 'paid',
                        'status' => 'processing',
                    ]);

                    try {
                        Mail::to($order->customer->email)->send(new OrderConfirmation($order));
                    } catch (\Exception $e) {
                        logger()->error('Order confirmation email failed: ' . $e->getMessage(), [
                            'order_id' => $order->id,
                            'customer_email' => $order->customer->email,
                        ]);
                    }

                    // Clear cart
                    session()->forget('cart');
                }
            } catch (\Exception $e) {
                logger()->error('Stripe session verification failed: ' . $e->getMessage());
            }
        }
        return view('checkout.success', compact('order'));
    }

    public function cancel(Request $request, $orderId){
        $order = Order::where('id',$orderId)
        ->where('customer_id',auth('customer')->id())
        ->firstOrFail();

        return view('checkout.cancel');
    }
}
