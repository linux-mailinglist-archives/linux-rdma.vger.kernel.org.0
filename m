Return-Path: <linux-rdma+bounces-19605-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNthBNXN72knGAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19605-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 22:57:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3328747A668
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 22:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C60CD3039FD0
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFF8396D13;
	Mon, 27 Apr 2026 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FPslwzXu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A5D3A5E72
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323151; cv=none; b=O6xQSRgLh5ECV0kUN0EEu/UNIqANF8ggruY5bdU7sUivM8w4l4avZyKsIIOnc9glU17Q4dObj4Zc8voYjSCqgD4XzUZhrPi4XbJE2JjOmpkcTQNO7EoEZzkMIzzPX0QIDJGJHd+3Xq54bcrqZcXuETSY4lhJsCHihXJlhC74LyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323151; c=relaxed/simple;
	bh=9wnPa5fHfJF/WJL8fwr6rEp13fLcHu3GTsn/ORH8aKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIln7qO1Vpe51IftIwMmzvyE9uvqytR4gzfmXt4rVNa75p5d7tr6Gm6wY8MDrc3HYqvc+VJWysveabjzAc8hy1y9MPCw1hqIqMiFt4sj3s7OzwXuMA7fG51IQRLHhjNMgbqvKja02ZSRWZ4cGx/rDR8MzroZpZOW5vIB2ysWC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FPslwzXu; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <805dcebc-39c6-4140-b07f-f76b7594c9d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777323141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ639XV0TBbUyLiX4BwOReSKUNdfOwh00HexvPuzmv0=;
	b=FPslwzXubNYjtnss1XEI+Amdzo0+pD2NaucB8oqvQ5z+WFBEukatO0IH6qkAqc44ko8VTc
	tsolwGGLxyia53pbgo/aSo2mS5mIQgNCmREvzQa7soP6IU2bBmVjycp1WxzHKeSFwxZ5Yo
	liyKXfVg1ku3RjIG1h0fFurT/CRW8rk=
Date: Mon, 27 Apr 2026 13:52:17 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix unsafe socket release during namespace
 cleanup
To: Leon Romanovsky <leon@kernel.org>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20260424043522.22901-1-yanjun.zhu@linux.dev>
 <20260427123503.GI440345@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260427123503.GI440345@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 3328747A668
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19605-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

On 4/27/26 5:35 AM, Leon Romanovsky wrote:
> On Fri, Apr 24, 2026 at 06:35:22AM +0200, Zhu Yanjun wrote:
>> Since all the sockets are created in rdma link create command
>> and destroyed in rdma link delete command, keeping
>> udp_tunnel_sock_release in rxe_ns_exit risks a "double-free" if
>> the namespace and the device are being cleaned up simultaneously.
> 
> Please add a ladder diagram to clarify how it can be possible.

Hi, Leon

The double-free occurs as follows:

CPU 0 (Net NameSpace cleanup)        CPU 1 (RDMA device removal)
---------------------                ---------------------------
rxe_ns_exit()                        rxe_link_delete() (rdma link del )
   -> sk = ns_sk->rxe_sk4               -> sk = ns_sk->rxe_sk4
   -> udp_tunnel_sock_release(sk)
      [Success: First Free]             -> udp_tunnel_sock_release(sk)
                                           [Crash: Double Free]

After removing the socket release logic from rxe_ns_exit(), we ensure
that only the device destruction path (rxe_link_delete) is responsible
for freeing the tunnel sockets, effectively eliminating the double-free 
problem.

I am not sure if I should put the above into the commit log.

Thanks a lot.

Zhu Yanjun

> 
> Thanks
> 
>>
>> Fixes: 13f2a53c2a71 ("RDMA/rxe: Add net namespace support for IPv4/IPv6 sockets")
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_ns.c | 20 --------------------
>>   1 file changed, 20 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
>> index 8b9d734229b2..53add78b8e3a 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
>> @@ -39,26 +39,6 @@ static void rxe_ns_exit(struct net *net)
>>   {
>>   	/* called when the network namespace is removed
>>   	 */
>> -	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>> -	struct sock *sk;
>> -
>> -	rcu_read_lock();
>> -	sk = rcu_dereference(ns_sk->rxe_sk4);
>> -	rcu_read_unlock();
>> -	if (sk) {
>> -		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
>> -		udp_tunnel_sock_release(sk->sk_socket);
>> -	}
>> -
>> -#if IS_ENABLED(CONFIG_IPV6)
>> -	rcu_read_lock();
>> -	sk = rcu_dereference(ns_sk->rxe_sk6);
>> -	rcu_read_unlock();
>> -	if (sk) {
>> -		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
>> -		udp_tunnel_sock_release(sk->sk_socket);
>> -	}
>> -#endif
>>   }
>>   
>>   /*
>> -- 
>> 2.43.0
>>
>>


