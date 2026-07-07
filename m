Return-Path: <linux-rdma+bounces-22813-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CLkAITzITGrFpgEAu9opvQ
	(envelope-from <linux-rdma+bounces-22813-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 11:34:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6635D719D7D
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 11:34:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=pHBhzdAI;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22813-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22813-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78DFA30022D7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F2A3914FF;
	Tue,  7 Jul 2026 09:29:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04FF33066D;
	Tue,  7 Jul 2026 09:29:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416557; cv=none; b=ANfwTCPXLR7ae+f9BPVMcvZ9Y7bpTTNwUbYrMcOvhigF/FadaJqG4on24G0hMIY/mgbktDlkQBgqrjKLHN2vIRS6GKdUU2iOdM4IpxIKs7eVJIvUGg2osGVQZGkgW1hNGl7AWaDzpG5+S+v/lJkwwMmGtqVoqm86v1GWbCoVtt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416557; c=relaxed/simple;
	bh=hZkT2Dsk6x1Rc8lxbgya9SVeGD89lnwkYlre0tYxc2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaVvxV+8a4S0AsvCSDgff+Br7NDj2ibq+noCp08D1uYw4MrslasZBdeWyNyWbLUP8RjDwOdjiDLziKmQQlLhpJh/ajwYxsuIVDpB0rhTs6diKX1reZjO9F2MangL33mt27S+XwWUc0kVvix+xF0gZjqYidJqMR8wEmi3Nt0EDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pHBhzdAI; arc=none smtp.client-ip=115.124.30.118
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783416546; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=x/JBmUH0AmD4h3bq2fvjuR02nLqqtA1dtweQcgT9r2k=;
	b=pHBhzdAIaNpia0nJojGu+fKNii3HdKyNGNztCwxn8bFH7pDMawwPbLLOPG9JcPTWuQGz7YHS1VB/BGRNuEmhDfIEtoRuo+lS0/rKyM4FkwzudoUKAKVeRkLc+slZ/TSjhNizhZx5dxUdrZVPDGzPx1QYXNEVoax9hB07b6XcRx8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X6cl3KV_1783416545;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X6cl3KV_1783416545 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 17:29:05 +0800
Date: Tue, 7 Jul 2026 17:29:04 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: hexlabsecurity@proton.me, "David S. Miller" <davem@davemloft.net>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Eric Dumazet <edumazet@google.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Stefan Raspl <raspl@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Ursula Braun <ubraun@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] net/smc: bound wire-controlled CDC cursors
 against the local buffers
Message-ID: <akzG4Hfeom6fNzFX@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260705-b4-disp-28a1bbca-v4-0-be089b98acc6@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-b4-disp-28a1bbca-v4-0-be089b98acc6@proton.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:davem@davemloft.net,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:alibuda@linux.alibaba.com,m:kuba@kernel.org,m:horms@kernel.org,m:wenjia@linux.ibm.com,m:pabeni@redhat.com,m:raspl@linux.ibm.com,m:guwen@linux.alibaba.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:ubraun@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22813-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6635D719D7D

On 2026-07-05 02:54:04, Bryam Vargas via B4 Relay wrote:
>A peer's CDC producer/consumer cursors are copied from the wire and used,
>without an upper bound against the local buffers, as (a) a raw index into the
>RMB on the urgent path, (b) the receive length in smc_rx_recvmsg(), and (c) the
>send length in smc_tx_sendmsg() on the SMC-D DMB-merge path. A malicious or
>buggy peer can forge a cursor so each runs past the relevant buffer: an
>out-of-bounds read of adjacent kernel memory (disclosed to the peer) on the
>receive/urgent side, and, on the send side, an out-of-bounds write whose
>length the peer controls and whose overflowing bytes are the local sender's
>own outbound data.
>
>This series bounds each length where it is consumed. The clamp is synchronous
>and race-free against the tasklet that advances the cursor, so it is the minimal
>fix for stable. A separate net-next series adds the wire-boundary validation and
>connection abort that Dust Li suggested; those do not replace these clamps.
>
>The clamp is not subsumed by validating cursors at the input boundary. A peer
>that only increments prod.wrap with count == 0 hits the differing-wrap branch of
>smc_curs_diff(), which returns (len - 0) + 0 == len every CDC, so bytes_to_rcv
>(and sndbuf_space on the send side) accumulates past the buffer while every
>per-cursor bound sees count == 0 and accepts the message. The overflow lives in
>the accumulator, not the cursor; only the consumer-side clamp bounds it. And
>because a queued abort runs asynchronously (queue_work -> smc_conn_kill) while
>smc_rx_recvmsg() reads the accumulator under lock_sock, only the synchronous
>clamp closes that window. So the clamp goes to stable; the abort is net-next.
>
>The nearby readable >= rmb_desc->len / len > sndbuf_desc->len tests only feed
>statistics counters (SMC_STAT_RMB_RX_FULL / SMC_STAT_RMB_TX_SIZE_SMALL) on an
>earlier, separate read; they do not bound the copy.
>
>A/B (in-kernel KASAN replaying the sink arithmetic over a real rmb_desc->len /
>sndbuf_desc->len slab; kasan.fault=report kasan_multi_shot, 2026-07-05):
>  - urgent index (1/3):  count = len+1        -> slab-out-of-bounds Read;  clamped -> clean
>  - recv length  (2/3):  bytes_to_rcv = 5*len via wrap++/count=0 -> OOB Read; clamped -> clean
>  - send length  (3/3):  sndbuf_space inflated -> slab-out-of-bounds Write; clamped -> clean
>  - signed overflow:     readable = -1 -> v1 ">len" misses -> OOB; "<0 || >len" -> clean
>  - concurrent TOCTOU race: a producer-side clamp is racy (OOB in a racing consumer
>    kthread on another CPU); the consumer-side clamp is race-free (0 hits / 5,000,000 reads).
>  - every in-bounds / honest-peer arm: clean.
>
>Changes since v3:
>  - split into this stable-bound clamp series and a separate net-next
>    validate/abort series, per Dust Li's review;
>  - tightened the commit messages; noted that the nearby SMC_STAT_* tests are not
>    bounds; no functional change to the three clamps.
>  v3: https://lore.kernel.org/all/20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me/

Hi Bryam,

Are you planning to land these clamps first, and then follow up with a
separate validate/abort series?

Looking at your earlier A/B test, it simulates this logic in userspace to
demonstrate the bug, but it doesn't actually trigger the bug in our
current kernel. If that's the case, the security risk here doesn't seem
high to me, since SMC is only meant to be deployed in trusted environments.

On the other hand, once this is actually triggered, it means the data
we've been handing to userspace is already wrong, which is already a
serious problem, and the connection should be terminated. So I don't
really see much value in merging the bound-clamp patches first.

So, I'd expected to see the real bug and validation/abort patch.

Best regards,
Dust


