Return-Path: <linux-rdma+bounces-19640-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NmYFgZU8Gk7RwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19640-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:30:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95E147E100
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D59E3010DBC
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 06:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2643290C2;
	Tue, 28 Apr 2026 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uJqtQ/8h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242D175A72
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777357826; cv=none; b=FLPBBoQjZM7bTCR2E/nqQmTVODRgxcORf5ulWBZHaPCmIIJZ9g5djFqQlVwf4wKh8mbKkxoMARF48cJNIyWAogANBTsYOvsFkDPDdijhlROkIVQ0kmE8HbJ6TuN1W/82f6XIn/2+8yOeOfb1XQ1O7O0ZufpquaHmhLSJ9c8pIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777357826; c=relaxed/simple;
	bh=quO71ul13grDtDPM5Ti7L9IY9DCrAcz4vhnP6nCvIag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWoOXrE7iQexowPAo6Jd1mPfhWnRqOz4Ih/WfeKNuEE7J7lA0pppUDott4aXuvGBNf25YmRV9CqCTsA0qAVGTft/ZGiLOwhed4kc2rHMe785qBN+CgPA+UFPze+hPezjGMfLeSgk2Qo0UegIJCYikB55jUo41beRJeFqYXHgUWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uJqtQ/8h; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73aea9b3-6afc-4e93-8bd6-b23d43591879@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777357821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7sMpve1j9A4pSj7yOBjB+apz19EUDxylXO0EEibMNE=;
	b=uJqtQ/8hDEoRt4Cr1T417EW7Y9MYn6T0kXSixDz4qGk6MkAJc6TSsUW8f30OeyJJsV6YBw
	8vUIJtmEL7M98CwMHH8Uf6e+9/HjfswbnT+kSwEB3+vv+z1m5MBTUngCyZWXAKdSNzqc04
	rnY6GLxC5jnNbJyIaYR9S2sQFZm767I=
Date: Mon, 27 Apr 2026 23:30:00 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in
 kernel_sock_shutdown().
To: Kuniyuki Iwashima <kuniyu@google.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, linux-rdma@vger.kernel.org,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
References: <20260425060436.2316620-1-kuniyu@google.com>
 <20260425060436.2316620-2-kuniyu@google.com>
 <030d3487-b5b9-4067-8b8c-89b4e8756e1a@linux.dev>
 <86499305-4522-4a82-a689-0247f2d5f6c0@kernel.org>
 <4196fe33-88c2-416d-ac20-b68bf7f328a6@linux.dev>
 <CAAVpQUAh2KT=YpfDO5nkqrzH0kbAXEBVe6jtOtLc93wjs3N7Fg@mail.gmail.com>
 <e2e1406f-8d9d-4a96-949d-e75096446d1a@linux.dev>
 <9681c9e2-79a9-4d72-b1ad-229ba6d7aab7@kernel.org>
 <0cf42593-0149-4019-a51b-36f74ff67f51@linux.dev>
 <CAAVpQUDVb4VDibeXz-DmAHF7gOAvDenSTGA6DpEwwS5HaQjM5w@mail.gmail.com>
 <0c1258e2-7060-4084-9a07-dd7af8262dec@kernel.org>
 <0ef2f2e0-e437-4ec9-8ebe-21c702041acb@linux.dev>
 <bbaf583c-2170-41d8-9226-2d4e742f71d1@linux.dev>
 <CAAVpQUDVFb5=DNahoRkhv1iM1TYU4_keJEETeLswUx_QFT6G4w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAAVpQUDVFb5=DNahoRkhv1iM1TYU4_keJEETeLswUx_QFT6G4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E95E147E100
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19640-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ziepe.ca,vger.kernel.org,syzkaller.appspotmail.com];
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
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

在 2026/4/27 22:22, Kuniyuki Iwashima 写道:
> On Mon, Apr 27, 2026 at 10:12 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>>
>>
>> 在 2026/4/27 19:15, Zhu Yanjun 写道:
>>>
>>> 在 2026/4/27 17:58, David Ahern 写道:
>>>> On 4/27/26 6:52 PM, Kuniyuki Iwashima wrote:
>>>>> To be clear, you meant implementing David' idea, right ?
>>>>> I'm asking because dellink won't need locking then.
>>>> dellink is not needed with my suggestion. It was added to manage
>>>> basically a refcount on the socket to close on last rxe delete in the
>>>
>>> This is my original implementation.
>>>
>>> @Kuniyuki Iwashima, can you reproduce this problem in your local host or
>>> other test environments?
> 
> The syzbot does not have a repro, but I think it can be
> reproduced by calling newlink and dellink with multiple
> threads.
> 
> newlink would trigger kmemleak splat while dellink trigger
> KASAN splat.
> 
> 
>>>
>>> If yes, can you make tests after applying the commit in the link:
>>> https://patchwork.kernel.org/project/linux-rdma/
>>> patch/20260424043522.22901-1-yanjun.zhu@linux.dev/
>>>
>>> Thanks a lot.
>>
>> Hi, David && Kuniyuki
>>
>> I read the call trace again.
>>
>> If net namespace has already released socket in A thread, then rdma link
>> del command is called in B thread to release socket.
>>
>> So A thread has released socket firstly, then B thread also release socket.
>>
>> The similar call trace would appear.
>>
>> The followiing is the explanation to the commit
>> https://patchwork.kernel.org/project/linux-rdma/patch/20260424043522.22901-1-yanjun.zhu@linux.dev/
>>
>> The double-free occurs as follows:
>>
>> CPU 0 (Net NameSpace cleanup)        CPU 1 (RDMA device removal)
>> ---------------------                ---------------------------
>> rxe_ns_exit()                        rxe_link_delete() (rdma link del )
> 
> If rxe_link_delete() is in progress, it means the user thread is
> alive, holding the netns refcount, and rxe_ns_exit() cannot be
> called.
> 
> So, dellink() never races with rxe_ns_exit(), and it races only
> with the concurrent dellink().
> 
> And when that occurs, the number of threads is not limited to
> two, theoretically triple-free, quad-free, ... are possible.

Thread 1: rdma link del          Thread 2: rdma link del
      (User A calls dellink)           (User B calls dellink)
               |                                 |
       (1) Get Socket Pointer            (2) Get Socket Pointer
           sk = ns_sk->rxe_sk4               sk = ns_sk->rxe_sk4
               |                                 |
       (3) Release Socket                (4) Release Socket
           udp_tunnel_sock_release(sk)       udp_tunnel_sock_release(sk)
               |                                 |
         [ FIRST FREE ]                          |
               |                          [ DOUBLE FREE! ]
               v                                 v
         (Memory freed)                  (Kernel Panic / Crash)

I think the above should explain your idea. If so, your solution makes 
senses to add a per-netns mutex to synchronise.

Let us use the first solution 
https://lore.kernel.org/all/20260424013759.728288-1-kuniyu@google.com/

BTW, 1) add mutex_destroy 2) take into account of rdma link add.

I am not sure if it is OK or not. @David Ahern

Thanks.

Zhu Yanjun

> 
> 
>>      -> sk = ns_sk->rxe_sk4               -> sk = ns_sk->rxe_sk4
>>      -> udp_tunnel_sock_release(sk)
>>         [Success: First Free]             -> udp_tunnel_sock_release(sk)
>>                                              [Crash: Double Free]
>>
>> After removing the socket release logic from rxe_ns_exit(), we ensure
>> that only the device destruction path (rxe_link_delete) is responsible
>> for freeing the tunnel sockets, effectively eliminating the double-free
>> problem.
>>
>> I am not sure if this is the root cause or not.
>>
>> Please comment.
>>
>> Thanks a lot.
>> Zhu Yanjun
>>
>>>
>>> Zhu Yanjun
>>>
>>>> namespace.
>>>
>>
>> --
>> Best Regards,
>> Yanjun.Zhu
>>


