Return-Path: <linux-rdma+bounces-18211-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BGnIC1WuGmKcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18211-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:12:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3C29F96A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EEDE3067860
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BCC3EF645;
	Mon, 16 Mar 2026 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNO3FIgk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3723E9F70;
	Mon, 16 Mar 2026 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688055; cv=none; b=Ao1sB8JbZwdvVag1HYA31i4TRwQyLloJ4itCDRAeYiD8hDGNnCs6cwjJK/xSUOgkcZJhOqC732Xp9oBAwgF4mx3KbAUgaVjUBuKVBGf3q8j8XzWBMB810Ashu7vdYTVWIHrJi3KnvCVXSjzVD69PqA5qCavdn2cs2eiPQIuAKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688055; c=relaxed/simple;
	bh=ZkJ7sb914J7dZHEWxzQioljT/jpfozBIBOswC8fIMs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4pjGvgnvcN7Jcdw501pyiF9FQmA/k0G+Gr5pAba6XtrsnnUDXNtOYc2uY+Mt1TZt1XPV0FIxfjD7ZerTpuP1uJPmkIJ2XKS9xmy4trA8o/exr4+6QJb7OzwW5Zno498V61FgPm5LeuFR+s3RAaxnrcKTlg1S34KkH4NQUbZJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNO3FIgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD275C19421;
	Mon, 16 Mar 2026 19:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773688054;
	bh=ZkJ7sb914J7dZHEWxzQioljT/jpfozBIBOswC8fIMs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NNO3FIgkhb+y967ZSuAWqgsqOZQE2Kc/rsldvSc0SwyJwpwu2bCx1PvpILU/J86hp
	 NfBzEZXDmV98wlv/ffIQgdwhHztXFTt+g3U0RLvjGkhN+f4BsYd28fLZex1CrA1XlB
	 CCTDuy2I1iL8QNuQJ90dXq2xy6yrOshrVwaRD0vTwRSHSH5OqDAZ1qxFYSxllkvzmr
	 f3bnxtz9wcGL6ZCf43uZYzcV9g6RGy1QlTvNxYXF5UxbgQFvO561djTIiriMsUvpzy
	 6crqilxWMX46V0c6IBlZp8AO0wfKa3LPom6Cejyi73BlCsEY1APtnWtUcxhj7jhv4O
	 qbxlfvx/E2HbQ==
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
	linux-mm@kvack.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 7/8] RDMA/umem: Tell DMA mapping that UMEM requires coherency
Date: Mon, 16 Mar 2026 21:06:51 +0200
Message-ID: <20260316-dma-debug-overlap-v3-7-1dde90a7f08b@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
References: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-18211-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qemu.org:url,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: E7D3C29F96A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

The RDMA subsystem exposes DMA regions through the verbs interface, which
assumes a coherent system. Use the DMA_ATTR_REQUIRE_COHERENCE attribute
to ensure coherency and avoid taking the SWIOTLB path.

The RDMA verbs programming model resembles HMM and assumes concurrent DMA
and CPU access to userspace memory. The hardware and programming model
support "one-sided" operations initiated remotely without any local CPU
involvement or notification. These include ATOMIC compare/swap, READ, and
WRITE. A remote CPU can use these operations to traverse data structures,
manipulate locks, and perform similar tasks without the host CPU’s
awareness. If SWIOTLB substitutes memory or DMA is not cache coherent,
these use cases break entirely.

In-kernel RDMA is fine with incoherent mappings because kernel users do
not rely on one-sided operations in ways that would expose these issues.

A given region may also be exported multiple times, which can trigger
warnings about cacheline overlaps. These warnings are suppressed when the
new attribute is used.

infiniband rocep8s0f0: mlx5_ib_reg_user_mr:1592:(pid 5812): start 0x2b28c000, iova 0x2b28c000, length 0x1000, access_flags 0x1
infiniband rocep8s0f0: mlx5_ib_reg_user_mr:1592:(pid 5812): start 0x2b28c001, iova 0x2b28c001, length 0xfff, access_flags 0x1
 ------------[ cut here ]------------
 DMA-API: mlx5_core 0000:08:00.0: cacheline tracking EEXIST, overlapping mappings aren't supported
 WARNING: kernel/dma/debug.c:620 at add_dma_entry+0x1bb/0x280, CPU#6: ibv_rc_pingpong/5812
 Modules linked in: veth xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat xt_addrtype br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay mlx5_fwctl zram zsmalloc mlx5_ib fuse rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm mlx5_core ib_core
 CPU: 6 UID: 2733 PID: 5812 Comm: ibv_rc_pingpong Tainted: G        W           6.19.0+ #129 PREEMPT
 Tainted: [W]=WARN
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:add_dma_entry+0x1be/0x280
 Code: 8b 7b 10 48 85 ff 0f 84 c3 00 00 00 48 8b 6f 50 48 85 ed 75 03 48 8b 2f e8 ff 8e 6a 00 48 89 c6 48 8d 3d 55 ef 2d 01 48 89 ea <67> 48 0f b9 3a 48 85 db 74 1a 48 c7 c7 b0 00 2b 82 e8 9c 25 fd ff
 RSP: 0018:ff11000138717978 EFLAGS: 00010286
 RAX: ffffffffa02d7831 RBX: ff1100010246de00 RCX: 0000000000000000
 RDX: ff110001036fac30 RSI: ffffffffa02d7831 RDI: ffffffff82678650
 RBP: ff110001036fac30 R08: ff11000110dcb4a0 R09: ff11000110dcb478
 R10: 0000000000000000 R11: ffffffff824b30a8 R12: 0000000000000000
 R13: 00000000ffffffef R14: 0000000000000202 R15: ff1100010246de00
 FS:  00007f59b411c740(0000) GS:ff110008dcc99000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007ffe538f7000 CR3: 000000010e066005 CR4: 0000000000373eb0
 Call Trace:
  <TASK>
  debug_dma_map_sg+0x1b4/0x390
  __dma_map_sg_attrs+0x6d/0x1a0
  dma_map_sgtable+0x19/0x30
  ib_umem_get+0x254/0x380 [ib_uverbs]
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
 RIP: 0033:0x7f59b430aeed
 Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
 RSP: 002b:00007ffe538f9430 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 00007ffe538f94c0 RCX: 00007f59b430aeed
 RDX: 00007ffe538f94e0 RSI: 00000000c0181b01 RDI: 0000000000000003
 RBP: 00007ffe538f9480 R08: 0000000000000028 R09: 00007ffe538f9684
 R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffe538f9684
 R13: 000000000000000c R14: 000000002b28d170 R15: 000000000000000c
  </TASK>
 ---[ end trace 0000000000000000 ]---

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index cff4fcca2c345..edc34c69f0f23 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -55,7 +55,8 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
 
 	if (dirty)
 		ib_dma_unmap_sgtable_attrs(dev, &umem->sgt_append.sgt,
-					   DMA_BIDIRECTIONAL, 0);
+					   DMA_BIDIRECTIONAL,
+					   DMA_ATTR_REQUIRE_COHERENT);
 
 	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i) {
 		unpin_user_page_range_dirty_lock(sg_page(sg),
@@ -169,7 +170,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	unsigned long lock_limit;
 	unsigned long new_pinned;
 	unsigned long cur_base;
-	unsigned long dma_attr = 0;
+	unsigned long dma_attr = DMA_ATTR_REQUIRE_COHERENT;
 	struct mm_struct *mm;
 	unsigned long npages;
 	int pinned, ret;

-- 
2.53.0


