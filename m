Return-Path: <linux-rdma+bounces-18020-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKT1DBa/sWkwFAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18020-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:14:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87661269232
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8927F304B583
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA2F3E557E;
	Wed, 11 Mar 2026 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH+8WPiK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD173AE6ED;
	Wed, 11 Mar 2026 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256160; cv=none; b=r+sCnCddOlElRc2IKjrIJI3saa3ITp+zQFKp5mn++fEYryDrkImukbrKFVLnaZZs93jzWtVja+ENuWIg/Lhhs4qNLcVvmm0PuWfIpwFlxSQMhf9NdE3zAyrd99NEZTJNi3WW1sucJg7APVn6L6oanY03mL1WVc61EKg9onaHJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256160; c=relaxed/simple;
	bh=gbK+v7FulbHCf4xeffX6pcY7t9uYKpGBULCh9FUaZDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVebcod5xX/cxzbfvZQyIMZ8XEXPJRXq6wMW2hX6uYLk7ncXxAPNh5w+hsN/oDk3POjwCLiC6cie3JogbnW9KtkdEQ/K8H1h6DlZL+1wOxv8H9FQV1Rk0M1lQGiYYwiUoSZu0DTlygRxjpMpOCNo8aso5wvQfjxzTmVawpveiGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH+8WPiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753B9C4CEF7;
	Wed, 11 Mar 2026 19:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773256160;
	bh=gbK+v7FulbHCf4xeffX6pcY7t9uYKpGBULCh9FUaZDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WH+8WPiKHF8Dt8v7aKQoWV/m4UNwNYjgwSonq778FSXuQHPHb/lEGPIG7EyWj2uMv
	 fZ1RkdjHx10MB5/q80znPzHQfuxWxreymIWQhCn1Ned3fMaBibrotQZVr03CCgdCSR
	 DdKDV3J3Rd5ObPVLvOnsb1o7er6N1LQGE7sqKbJYQKGE0WmPuGqR43BGPXkVok/6+L
	 TDvUNLoGp6DrhtujPksC89No8EXlSkkIXhG15iNEt/GKTR3AtvNBbpSrxc8LBHuuiw
	 mPCxIQbK2A7bytiGW/D33YzwAuEg957pOE10uIkuiQtOzbtTknj18zbKxWsqx4WKS+
	 O+RAatznjIzVA==
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
Subject: [PATCH v2 7/8] RDMA/umem: Tell DMA mapping that UMEM requires coherency
Date: Wed, 11 Mar 2026 21:08:50 +0200
Message-ID: <20260311-dma-debug-overlap-v2-7-e00bc2ca346d@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18020-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,qemu.org:url]
X-Rspamd-Queue-Id: 87661269232
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

The RDMA subsystem exposes DMA regions through the verbs interface, which
assumes a coherent system. Use the DMA_ATTR_REQUIRE_COHERENCE attribute to
ensure coherency and avoid taking the SWIOTLB path.

In addition, a given region may be exported multiple times, which will trigger
warnings about cacheline overlaps. These warnings are suppressed when using
the new attribute.

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


