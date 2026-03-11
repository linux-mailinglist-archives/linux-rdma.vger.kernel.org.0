Return-Path: <linux-rdma+bounces-18015-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH9jHSC+sWkwFAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18015-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:10:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E80D126916F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1C6E30795D2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED8366560;
	Wed, 11 Mar 2026 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6Q+l0cn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C2327C08;
	Wed, 11 Mar 2026 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256142; cv=none; b=YtiuxbPz8oATUqVsW0+Ybqrb9SsmCL4VqQgvpTDzUGjDVMNRTdUgTk9eyns0f70gsLDSVatzkEY7n+ZmBMEi8I4tf/lpj0cyjYongJmOYBLdcNY5HzCzdlxR3IQTQHhsqijA21ib+sN0+mSXjcZlgjTHRtSvZXnjVs9ukK8X5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256142; c=relaxed/simple;
	bh=Rb7pGPHPDn2aZQQvadJE9PAK4yDKeRrpgUBQyVOU34k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RytpqBMUr3NQPItzouUWbHC4yTmKuB0uXdNYXgnPYtFkfSPQ+riez2+8kuuCg2YbeQfcdVhwQHWMdQKog0vLiZcnUd5a6NGMAcVZda6KV+3nxarQ6i/0yDKDHSxEJO6Fu8Wjf0ofHnngBD6qz+MyZG21QaYTK+nNfwfTY9eEOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6Q+l0cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059A3C4AF09;
	Wed, 11 Mar 2026 19:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773256141;
	bh=Rb7pGPHPDn2aZQQvadJE9PAK4yDKeRrpgUBQyVOU34k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6Q+l0cnDFbPljYyv2EXPuve6Y9BMQ4YF+mnAza1NJccaQKUWdO1Q2BghWaQ1FoHT
	 MOnlUXqUDTnm/7+vptTBowOzAK/hXaqbxr7zYjsO1yoogF0svatd4Rfj6R1eqkaNcn
	 o0/x1FObC/g8ppv2cCeDUuKn+Xo1qBUs794lJKw/VOlgkly8kD9wdYWJcVRHvbA46V
	 C1v5ApXRuA7ycrshsRO668Fgwa3JF+jf2VOObCUBQE083YMwm2VpniTUH5o7hnAEis
	 wcPpuY/QPeAv+bv/IPMygcJ/hGb4RaENbyJCMELlY44REV2vD1zmN/Un5Kh0XjLbz4
	 cdoYGJDHFbIyA==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/8] dma-debug: Allow multiple invocations of overlapping entries
Date: Wed, 11 Mar 2026 21:08:44 +0200
Message-ID: <20260311-dma-debug-overlap-v2-1-e00bc2ca346d@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18015-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,qemu.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E80D126916F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

Repeated DMA mappings with DMA_ATTR_CPU_CACHE_CLEAN trigger the
following splat. This prevents using the attribute in cases where a DMA
region is shared and reused more than seven times.

 ------------[ cut here ]------------
 DMA-API: exceeded 7 overlapping mappings of cacheline 0x000000000438c440
 WARNING: kernel/dma/debug.c:467 at add_dma_entry+0x219/0x280, CPU#4: ibv_rc_pingpong/1644
 Modules linked in: xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat xt_addrtype br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay mlx5_fwctl zram zsmalloc mlx5_ib fuse rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm mlx5_core ib_core
 CPU: 4 UID: 2733 PID: 1644 Comm: ibv_rc_pingpong Not tainted 6.19.0+ #129 PREEMPT
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:add_dma_entry+0x221/0x280
 Code: c0 0f 84 f2 fe ff ff 83 e8 01 89 05 6d 99 11 01 e9 e4 fe ff ff 0f 8e 1f ff ff ff 48 8d 3d 07 ef 2d 01 be 07 00 00 00 48 89 e2 <67> 48 0f b9 3a e9 06 ff ff ff 48 c7 c7 98 05 2b 82 c6 05 72 92 28
 RSP: 0018:ff1100010e657970 EFLAGS: 00010002
 RAX: 0000000000000007 RBX: ff1100010234eb00 RCX: 0000000000000000
 RDX: ff1100010e657970 RSI: 0000000000000007 RDI: ffffffff82678660
 RBP: 000000000438c440 R08: 0000000000000228 R09: 0000000000000000
 R10: 00000000000001be R11: 000000000000089d R12: 0000000000000800
 R13: 00000000ffffffef R14: 0000000000000202 R15: ff1100010234eb00
 FS:  00007fb15f3f6740(0000) GS:ff110008dcc19000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fb15f32d3a0 CR3: 0000000116f59001 CR4: 0000000000373eb0
 Call Trace:
  <TASK>
  debug_dma_map_sg+0x1b4/0x390
  __dma_map_sg_attrs+0x6d/0x1a0
  dma_map_sgtable+0x19/0x30
  ib_umem_get+0x284/0x3b0 [ib_uverbs]
  mlx5_ib_reg_user_mr+0x68/0x2a0 [mlx5_ib]
  ib_uverbs_reg_mr+0x17f/0x2a0 [ib_uverbs]
  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xc2/0x130 [ib_uverbs]
  ib_uverbs_cmd_verbs+0xa0b/0xae0 [ib_uverbs]
  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_PORT_SPEED+0xe0/0xe0 [ib_uverbs]
  ? mmap_region+0x7a/0xb0
  ? do_mmap+0x3b8/0x5c0
  ib_uverbs_ioctl+0xa7/0x110 [ib_uverbs]
  __x64_sys_ioctl+0x14f/0x8b0
  ? ksys_mmap_pgoff+0xc5/0x190
  do_syscall_64+0x8c/0xbf0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7fb15f5e4eed
 Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
 RSP: 002b:00007ffe09a5c540 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 00007ffe09a5c5d0 RCX: 00007fb15f5e4eed
 RDX: 00007ffe09a5c5f0 RSI: 00000000c0181b01 RDI: 0000000000000003
 RBP: 00007ffe09a5c590 R08: 0000000000000028 R09: 00007ffe09a5c794
 R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffe09a5c794
 R13: 000000000000000c R14: 0000000025a49170 R15: 000000000000000c
  </TASK>
 ---[ end trace 0000000000000000 ]---

Fixes: 61868dc55a11 ("dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 86f87e43438c3..be207be749968 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -453,7 +453,7 @@ static int active_cacheline_set_overlap(phys_addr_t cln, int overlap)
 	return overlap;
 }
 
-static void active_cacheline_inc_overlap(phys_addr_t cln)
+static void active_cacheline_inc_overlap(phys_addr_t cln, bool is_cache_clean)
 {
 	int overlap = active_cacheline_read_overlap(cln);
 
@@ -462,7 +462,7 @@ static void active_cacheline_inc_overlap(phys_addr_t cln)
 	/* If we overflowed the overlap counter then we're potentially
 	 * leaking dma-mappings.
 	 */
-	WARN_ONCE(overlap > ACTIVE_CACHELINE_MAX_OVERLAP,
+	WARN_ONCE(!is_cache_clean && overlap > ACTIVE_CACHELINE_MAX_OVERLAP,
 		  pr_fmt("exceeded %d overlapping mappings of cacheline %pa\n"),
 		  ACTIVE_CACHELINE_MAX_OVERLAP, &cln);
 }
@@ -495,7 +495,7 @@ static int active_cacheline_insert(struct dma_debug_entry *entry,
 	if (rc == -EEXIST) {
 		struct dma_debug_entry *existing;
 
-		active_cacheline_inc_overlap(cln);
+		active_cacheline_inc_overlap(cln, entry->is_cache_clean);
 		existing = radix_tree_lookup(&dma_active_cacheline, cln);
 		/* A lookup failure here after we got -EEXIST is unexpected. */
 		WARN_ON(!existing);

-- 
2.53.0


