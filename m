Return-Path: <linux-rdma+bounces-19681-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L+kJSTo8Gn2awEAu9opvQ
	(envelope-from <linux-rdma+bounces-19681-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 19:02:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDCB489888
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 19:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44E923037880
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F89D32ED27;
	Tue, 28 Apr 2026 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fYNZpQBX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F933382C9
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395407; cv=none; b=o7x8FFv265igxU7vBkRBv5LLE5TLrDgZN5IVmsMk5z9z0pG2l6SgGb57PploSmHeiVyKxxu3g4ReRdfc0edfpWs4Pqai8YACqHXRZTHp6NyNpqrUhcIIuBbifnOzfSeKsZaVcvQSSmR8RXyRhe0JZUjsqALh23shSYNbXRN1MBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395407; c=relaxed/simple;
	bh=/wF2i7aGRZ+viYFLgcDZ9R9H5XwFuKhg/wWVFwxv4/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQfQXDPsg8Ab3SE9sJHrBQIo00TNZk28abtjJl9Mx+kJWel5PYr/7RIrURIfNaio4hpegb2eaxZHyI4ohEsp2jEikKHiYw9Moj7Qm1t66/u8xmVLTWqltycSQhA/r37rVY6/GRBy2mrw81ZCvmi1kCWbvrw4ml/EGQM1HzbnhYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fYNZpQBX; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0e05de34-79a0-415f-afb2-cc6c194ad87d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777395402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfQQ0a9kdz7I4BU0hht/o9f9vSuGDE3HbXG+4cIXQ04=;
	b=fYNZpQBXobeFqTZhsoU9TAXE6IVkrOrionW/8cy041h+0dIMYdsVkto26YE04wIKX7m5vb
	FHffHz7bLEcryhX7aRpUG1f0OV+CCH5htoxsy6ucLEKq90KFqSvhyrujIA6jo6Kgg6xvkz
	Rd/LP4776hgDQ6xmH8i6PmHZeyQ3Zn4=
Date: Tue, 28 Apr 2026 09:56:26 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in
 kernel_sock_shutdown().
To: Kuniyuki Iwashima <kuniyu@google.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
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
 <73aea9b3-6afc-4e93-8bd6-b23d43591879@linux.dev>
 <CAAVpQUBS0aeCEUK2Nvkq_9NqePiTaLoVQ5T4V8gPiJpbvDYj8Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <CAAVpQUBS0aeCEUK2Nvkq_9NqePiTaLoVQ5T4V8gPiJpbvDYj8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: EFDCB489888
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ziepe.ca,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-19681-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

On 4/27/26 11:39 PM, Kuniyuki Iwashima wrote:
> On Mon, Apr 27, 2026 at 11:30 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>> 在 2026/4/27 22:22, Kuniyuki Iwashima 写道:
>>> On Mon, Apr 27, 2026 at 10:12 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>>>
>>>>
>>>>
>>>> 在 2026/4/27 19:15, Zhu Yanjun 写道:
>>>>>
>>>>> 在 2026/4/27 17:58, David Ahern 写道:
>>>>>> On 4/27/26 6:52 PM, Kuniyuki Iwashima wrote:
>>>>>>> To be clear, you meant implementing David' idea, right ?
>>>>>>> I'm asking because dellink won't need locking then.
>>>>>> dellink is not needed with my suggestion. It was added to manage
>>>>>> basically a refcount on the socket to close on last rxe delete in the
>>>>>
>>>>> This is my original implementation.
>>>>>
>>>>> @Kuniyuki Iwashima, can you reproduce this problem in your local host or
>>>>> other test environments?
>>>
>>> The syzbot does not have a repro, but I think it can be
>>> reproduced by calling newlink and dellink with multiple
>>> threads.
>>>
>>> newlink would trigger kmemleak splat while dellink trigger
>>> KASAN splat.
>>>
>>>
>>>>>
>>>>> If yes, can you make tests after applying the commit in the link:
>>>>> https://patchwork.kernel.org/project/linux-rdma/
>>>>> patch/20260424043522.22901-1-yanjun.zhu@linux.dev/
>>>>>
>>>>> Thanks a lot.
>>>>
>>>> Hi, David && Kuniyuki
>>>>
>>>> I read the call trace again.
>>>>
>>>> If net namespace has already released socket in A thread, then rdma link
>>>> del command is called in B thread to release socket.
>>>>
>>>> So A thread has released socket firstly, then B thread also release socket.
>>>>
>>>> The similar call trace would appear.
>>>>
>>>> The followiing is the explanation to the commit
>>>> https://patchwork.kernel.org/project/linux-rdma/patch/20260424043522.22901-1-yanjun.zhu@linux.dev/
>>>>
>>>> The double-free occurs as follows:
>>>>
>>>> CPU 0 (Net NameSpace cleanup)        CPU 1 (RDMA device removal)
>>>> ---------------------                ---------------------------
>>>> rxe_ns_exit()                        rxe_link_delete() (rdma link del )
>>>
>>> If rxe_link_delete() is in progress, it means the user thread is
>>> alive, holding the netns refcount, and rxe_ns_exit() cannot be
>>> called.
>>>
>>> So, dellink() never races with rxe_ns_exit(), and it races only
>>> with the concurrent dellink().
>>>
>>> And when that occurs, the number of threads is not limited to
>>> two, theoretically triple-free, quad-free, ... are possible.
>>
>> Thread 1: rdma link del          Thread 2: rdma link del
>>        (User A calls dellink)           (User B calls dellink)
>>                 |                                 |
>>         (1) Get Socket Pointer            (2) Get Socket Pointer
>>             sk = ns_sk->rxe_sk4               sk = ns_sk->rxe_sk4
>>                 |                                 |
>>         (3) Release Socket                (4) Release Socket
>>             udp_tunnel_sock_release(sk)       udp_tunnel_sock_release(sk)
>>                 |                                 |
>>           [ FIRST FREE ]                          |
>>                 |                          [ DOUBLE FREE! ]
>>                 v                                 v
>>           (Memory freed)                  (Kernel Panic / Crash)
>>
>> I think the above should explain your idea. If so, your solution makes
>> senses to add a per-netns mutex to synchronise.
>>
>> Let us use the first solution
>> https://lore.kernel.org/all/20260424013759.728288-1-kuniyu@google.com/
>>
>> BTW, 1) add mutex_destroy 2) take into account of rdma link add.
>>
>> I am not sure if it is OK or not. @David Ahern
> 
> No, newlink is still racy and the same kind of race leaks
> the udp tunnel.
> 
> If we defer allocation, there are two options:
> 
> 1. David's idea, allocate on first use, and no free
>    until netns destruction (newlink can add a fast path
>    like check the pointer and only take mutex when it's
>    NULL, and check again under mutex and allcoate a
>   tunnel if not yet allocated)
> 
> 2. Manage refcount properly.  (If we allocate a dedicated
>    refcount for each tunnel socket in rxe_ns_sock, we
>    can implement a similar fast path for newlink, and dellink
>    will be lockless thanks to atomic)

I suggest we stick with Option 2 (proper refcounting) but move away from 
a purely lockless dellink. By protecting the tunnel destruction with a 
mutex, we can effectively close the race window and ensure the UDP 
tunnel is cleaned up reliably without compromising the efficiency of the 
fast path in newlink.

Zhu Yanjun

