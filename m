Return-Path: <linux-rdma+bounces-19572-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD7jK5HQ7mlQyAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19572-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 04:57:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1573E46C3F2
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 04:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 692A93007E11
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 02:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1248F34B1A7;
	Mon, 27 Apr 2026 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vyo13fOg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9504418EFD1
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777258636; cv=none; b=cFY5+nfXXl8HrrnN2NfVKhBE+nKTsI18ZDiVOBtGG2jiH0kvH9ENSdFh+dUWFJbppYRelUJFsdzTERdQmR5YuHZMppPufdFGTtDRV6gVndf6MuE/5CorsewY5XjgP8251Pm3HfbXhXUhnb6bngBeMXsNLxKku2fJL2owqkLSj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777258636; c=relaxed/simple;
	bh=Dzan5Zn88TXc4Yovjg5Q1N/z+aPnuxmWFVkYUiroIsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfZwMC2FyrWiQqFOxVq26o+l2e32/lNq4bFETp2MqtAcfNgSsLH7X9UdKG2YRgnzkB5oLnRNvHz2k3XdOPa9K/k7SdWaCWD7CufJhs5b4S+va8gMjGNvIOLh2dMIDuD59bRI2KCmNR8+BiWFcTdjBDoO+rGeEdepQMlIiaiNFNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vyo13fOg; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4196fe33-88c2-416d-ac20-b68bf7f328a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777258632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPbmtloTdxQ2ZTXnzY+Xn3/UKJUG57B0NapmEWLs9G8=;
	b=vyo13fOgQNTHCPNeNEZLurcnNH3EE7Olw6Rccm4eEGWZJURaz66Y8/ZU81YAoUYCRh5ueZ
	7It2ITn6ESQ4ZLf6p46/SR/qOSM/rmuddqdiE3KW4lyngeAiWh00pF27iz81JbiecKu1tH
	//e6TvQTsOmL8fAnSenlufvEwHk3Ggg=
Date: Sun, 26 Apr 2026 19:57:05 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in
 kernel_sock_shutdown().
To: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, linux-rdma@vger.kernel.org,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
References: <20260425060436.2316620-1-kuniyu@google.com>
 <20260425060436.2316620-2-kuniyu@google.com>
 <030d3487-b5b9-4067-8b8c-89b4e8756e1a@linux.dev>
 <86499305-4522-4a82-a689-0247f2d5f6c0@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <86499305-4522-4a82-a689-0247f2d5f6c0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1573E46C3F2
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
	TAGGED_FROM(0.00)[bounces-19572-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,google.com,gmail.com,ziepe.ca,linux.dev];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]

在 2026/4/26 9:42, David Ahern 写道:
> On 4/25/26 3:25 PM, Zhu Yanjun wrote:
>> 在 2026/4/24 23:04, Kuniyuki Iwashima 写道:
>>> syzbot reported null-ptr-deref in kernel_sock_shutdown(). [0]
>>>
>>> The problem is ->newlink() and ->dellink() can be called
>>> concurrently with no synchronisation, leading sk leak or
>>> double free, etc.
>>>
>>> We defer UDP tunnel allocation to the first device creation,
>>> but this would requrie per-netns locking.
>>>
>>> Let's allocate UDP tunnels in the __init_net hook.
>>>
>>> Now extra sock_hold() and __sock_put() are no longer needed.
>>>
>>> Note that rxe_ns_pernet_sk6() is broken and will be fixed
>>> in the following patch.
>>>
> ...
>>
>> All the commits are functionally correct, but I noticed some regressions
>> when running:
>> make -C tools/testing/selftests/rdma/ TARGET=rdma run_tests
>>
>> After applying this commit, the UDP port 4791 starts listening in both
>> init_net and all other net namespaces as soon as modprobe rdma_rxe is
>> executed. This breaks tests that expect the port to be unoccupied until
>> a device is actually created.
> 
> Not opening the port until an rxe device is created in that namespace
> needs to be kept.

This change alters the user-visible behavior:
the UDP port is now always listening per netns,
even without an rxe device.

Is this intentional, or should we preserve the
previous lazy allocation semantics?

Zhu Yanjun

