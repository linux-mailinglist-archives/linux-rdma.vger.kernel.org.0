Return-Path: <linux-rdma+bounces-20974-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBsxO+d+DGoSiQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20974-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:16:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 901C858140A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B86B330682E9
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4F43AFD12;
	Tue, 19 May 2026 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RW5OTl3i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9DC3AFCFF;
	Tue, 19 May 2026 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203306; cv=none; b=dFnaG2SghMJ0R60enViP4gVLVX8uU05HghFGtyn0Y2Tm5pzbC8QaNuSAbZy5xxx0+LRisXnDQkmmVRVPCHYRtB/6a2x9dZTopSwdULVNbNBNZ/GDgBxdtMDx3Arh3JaTgQGAfufKLv80SBfD6XHqLs2FAYNtrBHqtLbaQDoCOrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203306; c=relaxed/simple;
	bh=cW/i5F3zU6zS2MBxCTWXTQxpkm6T26RjXTd4j3uv1tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HFVuzWxQbkjnJ9SIoAj035/UAwwmCOx3BbIyk9tldMXT/sLeS/TO/gw2zjTiO3/7QKESHlJsr3DEPSoeVdLdIjN+mXFFCsZ6aE0EJNMpB7RH+HsUi/ORXvoqPQ99OtgE3fOMXWs/wz63pzumG52GAQ489ac5+MwPn+HIeBnCVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RW5OTl3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B41C2BCB3;
	Tue, 19 May 2026 15:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779203306;
	bh=cW/i5F3zU6zS2MBxCTWXTQxpkm6T26RjXTd4j3uv1tM=;
	h=From:To:Cc:Subject:Date:From;
	b=RW5OTl3iIqu2/cb3B4Z8Oyg57ZLRP0sgNi9/wqJ+rPsdYRUuefiqQ6qvdgJ73up/6
	 fUaI0jCw28LwHyaexuRP5Lel9HaMyizDZRVntlQjrkNeY8kbTxXotF0UMC13VdHsSP
	 sWQsfLwGw6rU3vDZt17o8jqscmI5Lld3PrmyYGm/lzvZ7wgTCASsX3OBnIWpT+Ll2s
	 YRO7yJQ4TQeJBasPmH5Z1NX2+5tGCUo4+KpqPwKrccbLWnBmjdZUPV5syGzupNP/c2
	 qbg0iokeSLzCveoOgxhbZctPddMSXZqDPJcJDV5TXhuJFL/mOx5Fr/10zlIr9kdJ7V
	 /Y+pV6KuZZ5tA==
From: Leon Romanovsky <leon@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH mlx5-next] net/mlx5: Consolidate UAR index to PFN helpers
Date: Tue, 19 May 2026 18:08:18 +0300
Message-ID: <20260519-mlx5-uar-index-v1-1-1027ae724bff@nvidia.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260511-mlx5-uar-index-107c8052c7d6
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20974-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 901C858140A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

mlx5_core's uar2pfn() and mlx5_ib's uar_index2pfn() compute the same
value via slightly different idioms.  Given:

  MLX5_ADAPTER_PAGE_SHIFT = 12
  MLX5_UARS_IN_PAGE       = PAGE_SIZE / MLX5_ADAPTER_PAGE_SIZE
                          = 1 << (PAGE_SHIFT - 12)

when uar_4k is set, uar2pfn()'s "index >> (PAGE_SHIFT - 12)" reduces to
"index / MLX5_UARS_IN_PAGE", which is exactly what uar_index2pfn() does.
When uar_4k is clear, both fall through to the identity case.  The same
arithmetic is also open-coded a third time in uar_index2paddress(), which
just multiplies the result by PAGE_SIZE.

The duplication is historical: uar_index2pfn() landed with the original
mlx5_ib driver in 2013 (e126ba97dba9), uar2pfn() was added in 2017
(a6d51b68611e) when the bfreg allocator moved into mlx5_core, and no
shared header ever exposed the helper.  The two were last touched in
parallel by aa8106f137b9 ("net/mlx5: Add explicit bar address field"),
confirming they are meant to behave identically.

Replace all three local copies with two static inlines in
include/linux/mlx5/driver.h returning phys_addr_t, which is the
appropriate type for a value that subsequently feeds ioremap*() and
rdma_user_mmap_io().  No functional change.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
mlx5_core's uar2pfn() and mlx5_ib's uar_index2pfn() compute the same
value via slightly different idioms. Let's consolidate them.
---
 drivers/infiniband/hw/mlx5/main.c             | 25 ++-----------------------
 drivers/net/ethernet/mellanox/mlx5/core/uar.c | 14 +-------------
 include/linux/mlx5/driver.h                   | 16 ++++++++++++++++
 3 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 428811fa805b..e61db29bc166 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2373,27 +2373,6 @@ static void mlx5_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	}
 }
 
-static phys_addr_t uar_index2pfn(struct mlx5_ib_dev *dev,
-				 int uar_idx)
-{
-	int fw_uars_per_page;
-
-	fw_uars_per_page = MLX5_CAP_GEN(dev->mdev, uar_4k) ? MLX5_UARS_IN_PAGE : 1;
-
-	return (dev->mdev->bar_addr >> PAGE_SHIFT) + uar_idx / fw_uars_per_page;
-}
-
-static u64 uar_index2paddress(struct mlx5_ib_dev *dev,
-				 int uar_idx)
-{
-	unsigned int fw_uars_per_page;
-
-	fw_uars_per_page = MLX5_CAP_GEN(dev->mdev, uar_4k) ?
-				MLX5_UARS_IN_PAGE : 1;
-
-	return (dev->mdev->bar_addr + (uar_idx / fw_uars_per_page) * PAGE_SIZE);
-}
-
 static int get_command(unsigned long offset)
 {
 	return (offset >> MLX5_IB_MMAP_CMD_SHIFT) & MLX5_IB_MMAP_CMD_MASK;
@@ -2643,7 +2622,7 @@ static int uar_mmap(struct mlx5_ib_dev *dev, enum mlx5_ib_mmap_cmd cmd,
 		uar_index = bfregi->sys_pages[idx];
 	}
 
-	pfn = uar_index2pfn(dev, uar_index);
+	pfn = mlx5_uar_index_to_pfn(dev->mdev, uar_index);
 	mlx5_ib_dbg(dev, "uar idx 0x%lx, pfn %pa\n", idx, &pfn);
 
 	err = rdma_user_mmap_io(&context->ibucontext, vma, pfn, PAGE_SIZE,
@@ -4327,7 +4306,7 @@ alloc_uar_entry(struct mlx5_ib_ucontext *c,
 		goto end;
 
 	entry->page_idx = uar_index;
-	entry->address = uar_index2paddress(dev, uar_index);
+	entry->address = mlx5_uar_index_to_paddr(dev->mdev, uar_index);
 	if (alloc_type == MLX5_IB_UAPI_UAR_ALLOC_TYPE_BF)
 		entry->mmap_flag = MLX5_IB_MMAP_TYPE_UAR_WC;
 	else
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/uar.c b/drivers/net/ethernet/mellanox/mlx5/core/uar.c
index 1513112ecec8..a85d8fed1546 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/uar.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/uar.c
@@ -66,18 +66,6 @@ static int uars_per_sys_page(struct mlx5_core_dev *mdev)
 	return 1;
 }
 
-static u64 uar2pfn(struct mlx5_core_dev *mdev, u32 index)
-{
-	u32 system_page_index;
-
-	if (MLX5_CAP_GEN(mdev, uar_4k))
-		system_page_index = index >> (PAGE_SHIFT - MLX5_ADAPTER_PAGE_SHIFT);
-	else
-		system_page_index = index;
-
-	return (mdev->bar_addr >> PAGE_SHIFT) + system_page_index;
-}
-
 static void up_rel_func(struct kref *kref)
 {
 	struct mlx5_uars_page *up = container_of(kref, struct mlx5_uars_page, ref_count);
@@ -132,7 +120,7 @@ static struct mlx5_uars_page *alloc_uars_page(struct mlx5_core_dev *mdev,
 		goto error1;
 	}
 
-	pfn = uar2pfn(mdev, up->index);
+	pfn = mlx5_uar_index_to_pfn(mdev, up->index);
 	if (map_wc) {
 		up->map = ioremap_wc(pfn << PAGE_SHIFT, PAGE_SIZE);
 		if (!up->map) {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04b96c5abb57..10eec559fd58 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -908,6 +908,22 @@ static inline u32 wq_get_byte_sz(u8 log_sz, u8 log_stride)
 	return ((u32)1 << log_sz) << log_stride;
 }
 
+static inline phys_addr_t mlx5_uar_index_to_pfn(struct mlx5_core_dev *mdev,
+						u32 uar_idx)
+{
+	u32 fw_uars_per_page = MLX5_CAP_GEN(mdev, uar_4k) ? MLX5_UARS_IN_PAGE : 1;
+
+	return (mdev->bar_addr >> PAGE_SHIFT) + uar_idx / fw_uars_per_page;
+}
+
+static inline phys_addr_t mlx5_uar_index_to_paddr(struct mlx5_core_dev *mdev,
+						  u32 uar_idx)
+{
+	u32 fw_uars_per_page = MLX5_CAP_GEN(mdev, uar_4k) ? MLX5_UARS_IN_PAGE : 1;
+
+	return mdev->bar_addr + (uar_idx / fw_uars_per_page) * PAGE_SIZE;
+}
+
 static inline void mlx5_init_fbc_offset(struct mlx5_buf_list *frags,
 					u8 log_stride, u8 log_sz,
 					u16 strides_offset,

---
base-commit: 67464f388d52ec172be62c99fc43697437ffa384
change-id: 20260511-mlx5-uar-index-107c8052c7d6

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


