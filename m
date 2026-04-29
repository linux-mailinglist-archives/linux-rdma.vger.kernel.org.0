Return-Path: <linux-rdma+bounces-19758-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H9RG/GU8mnLsgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19758-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 01:32:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5B49B5C5
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 01:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AE6F300824C
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 23:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253CA37B011;
	Wed, 29 Apr 2026 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K15mvZGp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914FC2F84F
	for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777505516; cv=none; b=QcEEk6zpUAPo4/GwLWUgeG/0eeOP/nwxyTHr9TamrwNS98GPyM1G3SrbUDSWNyboPgJTfY+g+TYV7oJ1t641izykk9P1p/l1lLY9gli0dx2cfh0qmZ9vWceIFyfFHNetqJ8ony8hQ7YX7TMbtm1p1SxKluIq7SofhVz3vKRQoNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777505516; c=relaxed/simple;
	bh=A8ZTk5usKXyP1lxuJ4xP3WQ2rEwp786RLG2wrwavhRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOadYEZE0gfbDudZ+7t2yl+oQvUSwsVtyHzCkFbpRBrcCbyX9f4a1m4fXtcku97w/KnK4jQk+bqe+ZuWURZhbO8yxu7JLu9kKxaKpxAzsL2As905KfQ88G6fKQOEG8Cb7g64YB+w2SO8LULqih6WdmlRY/UekSGiliZ110W366E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K15mvZGp; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8b7650f8-2957-4318-841a-473738a605ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777505512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02h3M7BZd32IKv0zzGgTvlhjP2kOtP8JnCQD9PVdmcc=;
	b=K15mvZGpUUvhVHg4yCKXcMUbBukvjvkz0lUS1ON9bacdFitw3oBeDyXF+cVbkOHVsUFUjp
	UH34fT2uxq5NNBQniROaOF5nCLWNqijjeq65a56Ck27fbLBaA61N115QbEHTRH+Lz1VJTi
	jGm2Ah5Bje6+IxOuB4zvgfmV2xHY0gA=
Date: Wed, 29 Apr 2026 16:31:48 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix unsafe socket release during namespace
 cleanup
To: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20260424043522.22901-1-yanjun.zhu@linux.dev>
 <20260427123503.GI440345@unreal>
 <805dcebc-39c6-4140-b07f-f76b7594c9d8@linux.dev>
 <20260428142653.GQ440345@unreal>
 <3bc69e75-1b4b-4bb9-87c4-7db863acc3d2@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <3bc69e75-1b4b-4bb9-87c4-7db863acc3d2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: DDF5B49B5C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19758-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 4/29/26 6:49 AM, Zhu Yanjun wrote:
> 在 2026/4/28 7:26, Leon Romanovsky 写道:
>> On Mon, Apr 27, 2026 at 01:52:17PM -0700, yanjun.zhu wrote:
>>> On 4/27/26 5:35 AM, Leon Romanovsky wrote:
>>>> On Fri, Apr 24, 2026 at 06:35:22AM +0200, Zhu Yanjun wrote:
>>>>> Since all the sockets are created in rdma link create command
>>>>> and destroyed in rdma link delete command, keeping
>>>>> udp_tunnel_sock_release in rxe_ns_exit risks a "double-free" if
>>>>> the namespace and the device are being cleaned up simultaneously.
>>>>
>>>> Please add a ladder diagram to clarify how it can be possible.
>>>
>>> Hi, Leon
>>>
>>> The double-free occurs as follows:
>>>
>>> CPU 0 (Net NameSpace cleanup)        CPU 1 (RDMA device removal)
>>> ---------------------                ---------------------------
>>> rxe_ns_exit()                        rxe_link_delete() (rdma link del )
>>>    -> sk = ns_sk->rxe_sk4               -> sk = ns_sk->rxe_sk4
>>>    -> udp_tunnel_sock_release(sk)
>>>       [Success: First Free]             -> udp_tunnel_sock_release(sk)
>>>                                            [Crash: Double Free]
>>>
>>> After removing the socket release logic from rxe_ns_exit(), we ensure
>>> that only the device destruction path (rxe_link_delete) is responsible
>>> for freeing the tunnel sockets, effectively eliminating the double-free
>>> problem.
>>
>> I think it is possible to call rxe_ns_exit() without invoking
>> rxe_link_delete(), and in that case the UDP socket will not be
>> destroyed.
> 
> Thanks, my bad. I missed this scenario.
> 
> Zhu Yanjun
> 
>>
>> Thanks
>>
>>>
>>> I am not sure if I should put the above into the commit log.
>>>
>>> Thanks a lot.

Hi, Leon

I have performed further tests to verify the execution order and the 
necessity of the cleanup code in rxe_ns_exit().

My findings show that a double-free race condition is unlikely because 
of how the kernel manages namespace references:

Reference Dependency: The RXE RDMA link holds a reference to the network 
namespace.

Order of Execution: When a namespace is deleted while an RDMA link 
exists, rxe_ns_exit() is not invoked immediately. It is deferred until 
the RDMA link itself is deleted (e.g., via rdma link del), which drops 
the final reference count of the namespace.

Redundancy: Consequently, rxe_ns_exit() always follows the device 
cleanup path (rxe_link_delete). Since all tunnel sockets are already 
released during the device cleanup, the code in rxe_ns_exit() is 
redundant and does nothing.

Removing this code simplifies the driver by centralizing socket 
destruction in the device management path, where the sockets are 
originally created.

This ensures that we don't attempt to release the same resources twice, 
even if the destruction is technically serialized by the kernel's 
reference counting.

What are your thoughts on this observation?

Thanks,

Zhu Yanjun

>>>
>>> Zhu Yanjun
>>>
>>>>
>>>> Thanks
>>>>
>>>>>
>>>>> Fixes: 13f2a53c2a71 ("RDMA/rxe: Add net namespace support for IPv4/ 
>>>>> IPv6 sockets")
>>>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>> ---
>>>>>    drivers/infiniband/sw/rxe/rxe_ns.c | 20 --------------------
>>>>>    1 file changed, 20 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/ 
>>>>> infiniband/sw/rxe/rxe_ns.c
>>>>> index 8b9d734229b2..53add78b8e3a 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
>>>>> @@ -39,26 +39,6 @@ static void rxe_ns_exit(struct net *net)
>>>>>    {
>>>>>        /* called when the network namespace is removed
>>>>>         */
>>>>> -    struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>>>>> -    struct sock *sk;
>>>>> -
>>>>> -    rcu_read_lock();
>>>>> -    sk = rcu_dereference(ns_sk->rxe_sk4);
>>>>> -    rcu_read_unlock();
>>>>> -    if (sk) {
>>>>> -        rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
>>>>> -        udp_tunnel_sock_release(sk->sk_socket);
>>>>> -    }
>>>>> -
>>>>> -#if IS_ENABLED(CONFIG_IPV6)
>>>>> -    rcu_read_lock();
>>>>> -    sk = rcu_dereference(ns_sk->rxe_sk6);
>>>>> -    rcu_read_unlock();
>>>>> -    if (sk) {
>>>>> -        rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
>>>>> -        udp_tunnel_sock_release(sk->sk_socket);
>>>>> -    }
>>>>> -#endif
>>>>>    }
>>>>>    /*
>>>>> -- 
>>>>> 2.43.0
>>>>>
>>>>>
>>>
> 


