Return-Path: <linux-rdma+bounces-21144-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B7wAoDFD2qJPgYAu9opvQ
	(envelope-from <linux-rdma+bounces-21144-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 04:54:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B305AE2DE
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 04:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63E49302BCEF
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 02:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80630FC39;
	Fri, 22 May 2026 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OgH5s+bh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB71335BA
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418492; cv=none; b=lQIsdmdQYgSHoxh1N6VqPBSo0sawwuyZdBFaahLZhPjPFgPgJ5Nb/erKVAz5jcsohXADISEb+bb3ID89IbFsusf5/6/wmIjRHBTcB5BSRZhJtqNhOGwZhRuzqV2P/e2v7S/+OjolvfXpuBohFZ8Wg+hH6XhmA4KHWxFLYn682qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418492; c=relaxed/simple;
	bh=9sNDWp4eJAN4hGKgG1/vCZXkYZij+jtvh3me80wz+Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIC55LsPUXMB2Qdp5jpZ5jlOeQMGaJDH/uhPE8HkNPgDbRVs9fJ3VZl16GeR8xigy4zm87iriaCkeDw24DyBUHE9QxnPePrsXe6Wv+sG/xkKKUYnkc/ShyNgTpTqDXLeyw52IKX4mWmUej/RB4b0eSCXdmEdmeawIEACQaikUTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OgH5s+bh; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55f7f791-d573-4009-a3ec-68b7e54483d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779418478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIwzmKCKWaTnt+GnpbaGIGstb9WVL0Zsa54wKJPDKwo=;
	b=OgH5s+bhF8PxVeziGIwGv4CtjbHIg4SZ3M/Jr/cpF+uH6XdrW/i0C9+E5qq0buaKTH69uN
	Cy4ukcWxdAPIgCRAb884rgi6foFkAt5effnAe5H8OmV6+WoPg+7PZR4jJXTUd7s61TbWXa
	C4/F6Bf6N9XHII/uHqGlBj6/uQBzRME=
Date: Thu, 21 May 2026 19:54:31 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] RDMA/rxe: Fix u64 iova-overflow family in
 MR/ODP/RESP/MW paths
To: Tymbark7372 <tymbark7372@proton.me>, linux-rdma@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@nvidia.com, leonro@nvidia.com,
 stable@vger.kernel.org
References: <20260521194402.811-1-tymbark7372@proton.me>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260521194402.811-1-tymbark7372@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21144-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 11B305AE2DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/5/21 12:44, Tymbark7372 写道:
> This patchset fixes a family of u64 overflow bugs in the rxe Soft-RoCE
> driver.  All four sites share one root cause: addition of an
> attacker-influenced iova/addr (u64) with an attacker-influenced
> length/resid (size_t/u32/int promoted to u64), without overflow
> check, leading to an OOB read/write primitive in the rxe responder
> workqueue.

The core premise of these commits is that a user-space program can 
arbitrarily set the IOVA via /dev/infiniband/uverbs0. I am still 
skeptical about this, as my understanding was that the IOVA is managed 
by the subsystem and difficult for a user to modify. If it is indeed 
possible for a user to control or change this IOVA, then I am completely 
fine with this patchset.

Thanks a lot.
Zhu Yanjun

> 
> I originally reported these to security@kernel.org.  Jason Gunthorpe
> confirmed that rxe and siw are development-only drivers without
> embargo handling and asked me to send patches publicly, so I'm
> posting here per his direction.  security@kernel.org is intentionally
> not in Cc per Jason's instruction.
> 
> This is a resend of the patches I sent earlier today as attachments.
> Zhu Yanjun pointed out attachments aren't the convention and asked
> for inline format via git send-email.
> 
> Patches:
> 
>    1/4: rxe_mr.c mr_check_range
>         The USER/MEM_REG case computes iova + length and compares to
>         mr->ibmr.iova + mr->ibmr.length.  Both additions wrap in u64.
>         Use check_add_overflow() for both ends.
> 
>    2/4: rxe_odp.c rxe_check_pagefault
>         Loop condition addr < iova + length wraps when iova is near
>         U64_MAX and length is positive.  Compute iova_end with
>         check_add_overflow() once and use it in the loop condition.
> 
>    3/4: rxe_resp.c duplicate_request
>         Third clause iova + resid > res->read.va_org + res->read.length
>         has u64 wrap on both sides.  Use check_add_overflow() for both
>         ends.  (Site A in check_rkey, also in rxe_resp.c, calls into
>         mr_check_range and is closed by patch 1.)
> 
>    4/4: rxe_mw.c rxe_check_bind_mw
>         Same wrap class as patch 1.  Found by sibling-site grep; not on
>         the OOB-write path of the three primary bugs but a
>         structurally-identical u64 wrap that would let an attacker bind
>         a memory window outside its parent MR's range.
> 
> Verification:
> 
> Each of the three primary sibling triggers (patches 1, 2, 3) has been
> exercised on v7.1.0-rc3 + KASAN in QEMU as the OOB-write case.
> Patches 1 and 3 produce a single-page-fault Oops in rxe_mr_copy after
> the wrap.  Patch 2 produces a single-page-fault Oops in
> rxe_odp_mr_copy.  All three are triggered by a single ibv_post_send
> from an unprivileged local user with /dev/infiniband/uverbs0 open.
> A working LPE exploit demonstrated end-to-end privilege escalation
> via the rxe_odp path under the verification config (KASAN dev-build,
> selinux=0, nokaslr).  Full PoC and writeup were attached to the
> original security@kernel.org submission.
> 
> After applying all four patches, the same triggers no longer fire;
> the wrap checks correctly reject the attacker iova.  Re-tested in the
> same QEMU+KASAN configuration.
> 
> The trigger PoCs are simple libibverbs programs (one per sibling)
> that I am happy to provide on request.
> 
> Fixes / stable:
> 
>    1/4: Fixes 8700e3e7c485 ("Soft RoCE driver"), v4.8+
>    2/4: Fixes 2fae67ab63db ("RDMA/rxe: Add support for Send/Recv/Write/Read with ODP"), v6.15+
>    3/4: Fixes 8700e3e7c485 ("Soft RoCE driver"), v4.8+
>    4/4: Fixes 8700e3e7c485 ("Soft RoCE driver"), v4.8+
> 
> Pre-f04d5b3d916c LTS branches carry the older wrap form
>    iova > mr->ibmr.iova + mr->ibmr.length - length
> instead of the current `iova + length > ...` shape.  Patches 1, 3, 4
> will need a backport variant for those branches; I can provide on
> request.
> 
> Tymbark7372 (4):
>    RDMA/rxe: Fix u64 iova+length overflow in mr_check_range
>    RDMA/rxe: Fix u64 iova+length overflow in rxe_check_pagefault
>    RDMA/rxe: Fix u64 iova+resid overflow in duplicate_request
>    RDMA/rxe: Fix u64 addr+length overflow in rxe_check_bind_mw
> 
>   drivers/infiniband/sw/rxe/rxe_mr.c   | 12 +++++++++---
>   drivers/infiniband/sw/rxe/rxe_odp.c  | 10 ++++++++--
>   drivers/infiniband/sw/rxe/rxe_resp.c | 11 ++++++++---
>   drivers/infiniband/sw/rxe/rxe_mw.c   | 11 ++++++++---
>   4 files changed, 33 insertions(+), 11 deletions(-)
> 
> --
> 2.43.0
> 


