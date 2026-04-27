Return-Path: <linux-rdma+bounces-19574-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD6eBorf7mklzAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19574-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 06:01:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F08146CBBF
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 06:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 202FC303FFDA
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 03:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D1363090;
	Mon, 27 Apr 2026 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uaF+Cndi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3482E11D2
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262002; cv=none; b=RqL028QC4mbhGLVDqb+HEzRksnM1HXl1PUYviJqzR5hfr+qhSJRxM4NfahyQ+1hGKM3uJ1a2lMHvX8Er6r2d5IG6ia+mGyf5zQud7k4AvxGFGbcOGg30qu36tTakoPGtV/kXj9ABr5yHkTxXOo9Kx0EvDYbB3uAsYTYi2H+fc3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262002; c=relaxed/simple;
	bh=+OD/Dg3SA/LhWwIqpwy0KZRl9OVmK1Aidy3B2X7eMR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvVlclpwC9QEdgIPf3jx9mJyCYwWzXSvoZJamm0LnobnXb33yyCSIbrfo2N5rKf+g41UlnfBt2HpVteL5TXnhLjUwEe0rvrrX9BtVNqcrZYp/H8x50wSHndn1PqV6cfjQpwjx3fF6nQiNSBKJANDAutzGp+/i81oHgmteP8TytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uaF+Cndi; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e2e1406f-8d9d-4a96-949d-e75096446d1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777261997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57RD2Nl4TCXbIRnskQlePWmFZL5uSjKSB5pIZjzV17c=;
	b=uaF+Cndi5QuawDjEEAPK/4ZVR/p7YR9Vs95O3SSZAHnXv5l9d2PHHi2K/N38ojKNBCTy7+
	Rhz2pZvQ1YP1VUJ/EVEkB9aRXCrqSob8uVygMBvMxqxtvCJJ7O5t8A7KuwRn5CwYYKaO/Y
	KJVMoaQKRxzZBiVm/QCuMnIXcIPHzo0=
Date: Sun, 26 Apr 2026 20:53:11 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAAVpQUAh2KT=YpfDO5nkqrzH0kbAXEBVe6jtOtLc93wjs3N7Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1F08146CBBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ziepe.ca,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-19574-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]


在 2026/4/26 20:10, Kuniyuki Iwashima 写道:
> On Sun, Apr 26, 2026 at 7:57 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>> 在 2026/4/26 9:42, David Ahern 写道:
>>> On 4/25/26 3:25 PM, Zhu Yanjun wrote:
>>>> 在 2026/4/24 23:04, Kuniyuki Iwashima 写道:
>>>>> syzbot reported null-ptr-deref in kernel_sock_shutdown(). [0]
>>>>>
>>>>> The problem is ->newlink() and ->dellink() can be called
>>>>> concurrently with no synchronisation, leading sk leak or
>>>>> double free, etc.
>>>>>
>>>>> We defer UDP tunnel allocation to the first device creation,
>>>>> but this would requrie per-netns locking.
>>>>>
>>>>> Let's allocate UDP tunnels in the __init_net hook.
>>>>>
>>>>> Now extra sock_hold() and __sock_put() are no longer needed.
>>>>>
>>>>> Note that rxe_ns_pernet_sk6() is broken and will be fixed
>>>>> in the following patch.
>>>>>
>>> ...
>>>> All the commits are functionally correct, but I noticed some regressions
>>>> when running:
>>>> make -C tools/testing/selftests/rdma/ TARGET=rdma run_tests
>>>>
>>>> After applying this commit, the UDP port 4791 starts listening in both
>>>> init_net and all other net namespaces as soon as modprobe rdma_rxe is
>>>> executed. This breaks tests that expect the port to be unoccupied until
>>>> a device is actually created.
>>> Not opening the port until an rxe device is created in that namespace
>>> needs to be kept.
>> This change alters the user-visible behavior:
>> the UDP port is now always listening per netns,
>> even without an rxe device.
>>
>> Is this intentional, or should we preserve the
>> previous lazy allocation semantics?
> I did it intentionally because before f1327abd6abe
> the port was reserved while loading the module, and
> if the tunnel creation failed, the module was unloaded.
>
> Rather I feel f1327abd6abe introduced the user-visible
> change.
>
> That said, I don't have a strong preference, so up to you
> maintainers.  Simple lockless solution vs per-newlink/dellink
> locking.
To be honest, I do not have a strong preference here, though

I lean slightly toward the per-newlink/dellink locking approach.

Both the simple lockless solution and the locking approach seem

reasonable, depending on whether we prioritize simplicity or

explicit synchronization and lifecycle clarity.

It would be helpful to get feedback from David Ahern, Leon,

and Jason to converge on a final direction.

Zhu Yanjun

>
> FWIW, there is another example that reserves a port in every
> netns while loading the module, see rds_tcp_listen_init().
>
-- 
Best Regards,
Yanjun.Zhu


