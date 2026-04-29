Return-Path: <linux-rdma+bounces-19733-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGoaKZsM8mkynQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19733-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 15:50:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228044951F0
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 15:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C2533018AD3
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 13:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03A51FBEA6;
	Wed, 29 Apr 2026 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BqxYs9On"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A82FB632
	for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470610; cv=none; b=PY4+pjV6ycZ+2iOqJsHv6/MnsX8BzH1cN21ynxrhvlrFQHoYof1cUH4j6/h2+KA+MT3PcSv5pO/J3zhk8wk7V6S5vIZAYAZFlFivEz9L1tXdTIY8GO49lMk76Ld/Oqe1Se97ce5VGPaOgamoqtPRZ8iQWya7+4ToxV7d46eKMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470610; c=relaxed/simple;
	bh=E/L1yKAQ1jmVpb3D9vzC2Fst4cuj8/vEfyrm41oLXRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuTeteiGU7n7W3ogv08dnDyLjilRe2Ey5TwfJ4LjNnsNZsiCj5HNKrrgOD9CudLPVjUPyv4Tbfl4HTZGYU7xMOiT5m9A0zBmLCTkrw0D0kyMC5YGNjvAEzmARfcDUDWNq3lZmXzmPyG0VY/RMHxcj4bYn2vfcnab4olrBQtlIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BqxYs9On; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3bc69e75-1b4b-4bb9-87c4-7db863acc3d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777470603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oObu7hhZ573NyGzdw/YbFpfWGCbljyrElwCOGzd9LWo=;
	b=BqxYs9OndWM7oSOzFfcI7ccgd9+aBmI4u7nTrcaLm8x2LG1eyxKqt77c0qea5odKRXIBYY
	RSpfw2EbBGIG35fl6BOrKGZTQSKIQF5jxGQQYaYeG4fbGjo0qvc/k52vR1wKxdf5HHqrZL
	haMfL2hVFrJn/XQz3/JH3N/+2Y3OHXc=
Date: Wed, 29 Apr 2026 06:49:55 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix unsafe socket release during namespace
 cleanup
To: Leon Romanovsky <leon@kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20260424043522.22901-1-yanjun.zhu@linux.dev>
 <20260427123503.GI440345@unreal>
 <805dcebc-39c6-4140-b07f-f76b7594c9d8@linux.dev>
 <20260428142653.GQ440345@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260428142653.GQ440345@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 228044951F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19733-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

在 2026/4/28 7:26, Leon Romanovsky 写道:
> On Mon, Apr 27, 2026 at 01:52:17PM -0700, yanjun.zhu wrote:
>> On 4/27/26 5:35 AM, Leon Romanovsky wrote:
>>> On Fri, Apr 24, 2026 at 06:35:22AM +0200, Zhu Yanjun wrote:
>>>> Since all the sockets are created in rdma link create command
>>>> and destroyed in rdma link delete command, keeping
>>>> udp_tunnel_sock_release in rxe_ns_exit risks a "double-free" if
>>>> the namespace and the device are being cleaned up simultaneously.
>>>
>>> Please add a ladder diagram to clarify how it can be possible.
>>
>> Hi, Leon
>>
>> The double-free occurs as follows:
>>
>> CPU 0 (Net NameSpace cleanup)        CPU 1 (RDMA device removal)
>> ---------------------                ---------------------------
>> rxe_ns_exit()                        rxe_link_delete() (rdma link del )
>>    -> sk = ns_sk->rxe_sk4               -> sk = ns_sk->rxe_sk4
>>    -> udp_tunnel_sock_release(sk)
>>       [Success: First Free]             -> udp_tunnel_sock_release(sk)
>>                                            [Crash: Double Free]
>>
>> After removing the socket release logic from rxe_ns_exit(), we ensure
>> that only the device destruction path (rxe_link_delete) is responsible
>> for freeing the tunnel sockets, effectively eliminating the double-free
>> problem.
> 
> I think it is possible to call rxe_ns_exit() without invoking
> rxe_link_delete(), and in that case the UDP socket will not be
> destroyed.

Thanks, my bad. I missed this scenario.

Zhu Yanjun

> 
> Thanks
> 
>>
>> I am not sure if I should put the above into the commit log.
>>
>> Thanks a lot.
>>
>> Zhu Yanjun
>>
>>>
>>> Thanks
>>>
>>>>
>>>> Fixes: 13f2a53c2a71 ("RDMA/rxe: Add net namespace support for IPv4/IPv6 sockets")
>>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe_ns.c | 20 --------------------
>>>>    1 file changed, 20 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
>>>> index 8b9d734229b2..53add78b8e3a 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
>>>> @@ -39,26 +39,6 @@ static void rxe_ns_exit(struct net *net)
>>>>    {
>>>>    	/* called when the network namespace is removed
>>>>    	 */
>>>> -	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>>>> -	struct sock *sk;
>>>> -
>>>> -	rcu_read_lock();
>>>> -	sk = rcu_dereference(ns_sk->rxe_sk4);
>>>> -	rcu_read_unlock();
>>>> -	if (sk) {
>>>> -		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
>>>> -		udp_tunnel_sock_release(sk->sk_socket);
>>>> -	}
>>>> -
>>>> -#if IS_ENABLED(CONFIG_IPV6)
>>>> -	rcu_read_lock();
>>>> -	sk = rcu_dereference(ns_sk->rxe_sk6);
>>>> -	rcu_read_unlock();
>>>> -	if (sk) {
>>>> -		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
>>>> -		udp_tunnel_sock_release(sk->sk_socket);
>>>> -	}
>>>> -#endif
>>>>    }
>>>>    /*
>>>> -- 
>>>> 2.43.0
>>>>
>>>>
>>


