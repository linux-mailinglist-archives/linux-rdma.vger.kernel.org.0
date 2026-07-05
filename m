Return-Path: <linux-rdma+bounces-22762-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 46l+OLUNSmp19wAAu9opvQ
	(envelope-from <linux-rdma+bounces-22762-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 09:54:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE6D70943F
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 09:54:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Deca1j0U;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22762-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22762-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C44D301184C
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BF636729A;
	Sun,  5 Jul 2026 07:54:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92D285C8B;
	Sun,  5 Jul 2026 07:54:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238046; cv=none; b=ccj0bZASGopxV8KVrX31xihnunbNwdOqhINPKugLDJi005xGoQbNvTfZ1dAePSQeED3Ls5okw5seBu5bc8fFAo/OW6rjCmu58WDaIIHqF+ZqlKF1XBC2/N0NRZfm67mxnNEKvgjv6vVI/U2PjMF8scnrgIBZmfnhpgNdcFWC6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238046; c=relaxed/simple;
	bh=dyysRfmK3tbb8Vzxzn802wbSb/HCPq3aBDjjKEzA7GA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UALC35iQT/g650dyEf7VvEDqa1A6iVAWZnoleHkp8uC2XtNP4b08paiQ+DHzwlGG4H22r08NU69dzLLs6/n31Wxr9UC606Y3m5awuhXUgkuRxxJnw9EW0BpN2a53kQXRi8gvgfMiku/hEACy28CtOCL2mSmzlI2b28hi9v1t2iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Deca1j0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13793C2BCB8;
	Sun,  5 Jul 2026 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783238046;
	bh=dyysRfmK3tbb8Vzxzn802wbSb/HCPq3aBDjjKEzA7GA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Deca1j0UTLnflSTWDIcyzmeXEpSb1k1fMN3QI3bRvWPgK5IV9Twsc574ewLJZAU6x
	 GUJY0HK/ARCA1FyKSgRDL9mJFi7zizc1d7OVlvQGRSckM3QQCP3XMOkSioUG1ZH1eL
	 JSvhhJla3uAKwEzDaOt3H/ABAVTb4bvJosqZnzW8BMcnBGItpX89/sO7F/WTkk7yB1
	 u9ukxNLT5Tg54y/IpysQAPlC+DRVsPMOPCyfSjejWmF6ojWcb+hEgLbPrV2E1XmcsU
	 8zUL9QeccH0aYm8H5SK7OnKmdopSgCFTpZ5gMIw2a2PdpjBivieZp/QDVnHBQGPs//
	 yXlWsSK7KLoaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22AEC43458;
	Sun,  5 Jul 2026 07:54:05 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Subject: [PATCH net v4 0/3] net/smc: bound wire-controlled CDC cursors
 against the local buffers
Date: Sun, 05 Jul 2026 02:54:04 -0500
Message-Id: <20260705-b4-disp-28a1bbca-v4-0-be089b98acc6@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwNSmoC/x3MOQqAMBBA0avI1A7EGNeriEWWUaeJkogIIXc3W
 L7i/wSRAlOEuUoQ6OHIpy9QdQX20H4nZFcMUsheDKJDo9BxvFCOujHGarR22rpWO1JqhJJdgTZ
 +/+UCnm5Yc/4AfamGPmcAAAA=
To: Dust Li <dust.li@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Eric Dumazet <edumazet@google.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Stefan Raspl <raspl@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Ursula Braun <ubraun@linux.ibm.com>, 
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238044; l=3668;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=dyysRfmK3tbb8Vzxzn802wbSb/HCPq3aBDjjKEzA7GA=;
 b=HDewF+Yu/0F2KKKd8NDY4C5jcdeSR0e8yWyf9dOQ6MjpTgWesHZkUaySdrllEV+bbLdT8Mpik
 uFHCMyE++RMCDx5xWNFefKAeCI0nt71WL4UcNCZWfmAkXThb9VqLVRc
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dust.li@linux.alibaba.com,m:davem@davemloft.net,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:alibuda@linux.alibaba.com,m:kuba@kernel.org,m:horms@kernel.org,m:wenjia@linux.ibm.com,m:pabeni@redhat.com,m:raspl@linux.ibm.com,m:guwen@linux.alibaba.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:ubraun@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22762-lists,linux-rdma=lfdr.de,hexlabsecurity.proton.me];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-rdma@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[hexlabsecurity@proton.me];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FE6D70943F

A peer's CDC producer/consumer cursors are copied from the wire and used,
without an upper bound against the local buffers, as (a) a raw index into the
RMB on the urgent path, (b) the receive length in smc_rx_recvmsg(), and (c) the
send length in smc_tx_sendmsg() on the SMC-D DMB-merge path. A malicious or
buggy peer can forge a cursor so each runs past the relevant buffer: an
out-of-bounds read of adjacent kernel memory (disclosed to the peer) on the
receive/urgent side, and, on the send side, an out-of-bounds write whose
length the peer controls and whose overflowing bytes are the local sender's
own outbound data.

This series bounds each length where it is consumed. The clamp is synchronous
and race-free against the tasklet that advances the cursor, so it is the minimal
fix for stable. A separate net-next series adds the wire-boundary validation and
connection abort that Dust Li suggested; those do not replace these clamps.

The clamp is not subsumed by validating cursors at the input boundary. A peer
that only increments prod.wrap with count == 0 hits the differing-wrap branch of
smc_curs_diff(), which returns (len - 0) + 0 == len every CDC, so bytes_to_rcv
(and sndbuf_space on the send side) accumulates past the buffer while every
per-cursor bound sees count == 0 and accepts the message. The overflow lives in
the accumulator, not the cursor; only the consumer-side clamp bounds it. And
because a queued abort runs asynchronously (queue_work -> smc_conn_kill) while
smc_rx_recvmsg() reads the accumulator under lock_sock, only the synchronous
clamp closes that window. So the clamp goes to stable; the abort is net-next.

The nearby readable >= rmb_desc->len / len > sndbuf_desc->len tests only feed
statistics counters (SMC_STAT_RMB_RX_FULL / SMC_STAT_RMB_TX_SIZE_SMALL) on an
earlier, separate read; they do not bound the copy.

A/B (in-kernel KASAN replaying the sink arithmetic over a real rmb_desc->len /
sndbuf_desc->len slab; kasan.fault=report kasan_multi_shot, 2026-07-05):
  - urgent index (1/3):  count = len+1        -> slab-out-of-bounds Read;  clamped -> clean
  - recv length  (2/3):  bytes_to_rcv = 5*len via wrap++/count=0 -> OOB Read; clamped -> clean
  - send length  (3/3):  sndbuf_space inflated -> slab-out-of-bounds Write; clamped -> clean
  - signed overflow:     readable = -1 -> v1 ">len" misses -> OOB; "<0 || >len" -> clean
  - concurrent TOCTOU race: a producer-side clamp is racy (OOB in a racing consumer
    kthread on another CPU); the consumer-side clamp is race-free (0 hits / 5,000,000 reads).
  - every in-bounds / honest-peer arm: clean.

Changes since v3:
  - split into this stable-bound clamp series and a separate net-next
    validate/abort series, per Dust Li's review;
  - tightened the commit messages; noted that the nearby SMC_STAT_* tests are not
    bounds; no functional change to the three clamps.
  v3: https://lore.kernel.org/all/20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me/

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Bryam Vargas (3):
      net/smc: bound the wire-controlled producer cursor to the RMB
      net/smc: bound the receive length to the RMB in smc_rx_recvmsg()
      net/smc: bound the send length to the send buffer in smc_tx_sendmsg()

 net/smc/smc_cdc.h | 27 ++++++++++++++++++++++++---
 net/smc/smc_rx.c  | 12 ++++++++++++
 net/smc/smc_tx.c  | 13 +++++++++++++
 3 files changed, 49 insertions(+), 3 deletions(-)
---
base-commit: d6456743424721a837e1509b912f362caaeecd97
change-id: 20260705-b4-disp-28a1bbca-cc9f53ade448

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>



