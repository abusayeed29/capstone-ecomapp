<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Mail\OrderConfirmation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class CheckoutController extends Controller
{
    public function success(Request $request, $orderId){
        $order = Order::where('id', $orderId)
        ->where('customer_id', auth('customer')->id())
        ->with(['items.product.primaryImage', 'customer'])
        ->firstOrFail();

        // Avoid blocking the success page on an outbound Stripe API call.
        // We trust the redirect only when the returned session matches the order transaction id.
        if ($request->filled('session_id') && $order->payment_status !== 'paid') {
            if ($request->string('session_id')->value() === $order->transaction_id) {
                $order->update([
                    'payment_status' => 'paid',
                    'status' => 'processing',
                ]);

                dispatch(function () use ($order) {
                    Mail::to($order->customer->email)->send(new OrderConfirmation($order));
                })->afterResponse();

                session()->forget('cart');
            } else {
                logger()->warning('Stripe success session did not match order transaction id.', [
                    'order_id' => $order->id,
                    'request_session_id' => $request->string('session_id')->value(),
                    'order_transaction_id' => $order->transaction_id,
                ]);
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
