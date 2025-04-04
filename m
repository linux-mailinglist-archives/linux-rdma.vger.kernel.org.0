Return-Path: <linux-rdma+bounces-9154-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE04A7BFD0
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 16:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49A717CBD0
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A5C1F461C;
	Fri,  4 Apr 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dk0KpHrR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD791F37D4;
	Fri,  4 Apr 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777964; cv=none; b=sPUH3WIKnH7QoGFx50amWDlUhR4La/sLvtotrmgV903RQZd5AprLjcxGGM2TzyV6L3lx9C6mO9RudZNeNmSzR59j91H7nbqkddfe8XxFXNyRQt9cqs0fn/gGPxFB8QrnYXB/ctGTVL5ek5BrQh7pqi20Q3EqDkjgFF+CsdkFet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777964; c=relaxed/simple;
	bh=//qEM11VkDcC4uZBan6dMlPoLKZnDJ2babKh5NvqDQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m3QONc+35GYXkHbP7Ri7suUJPJzZgY37KCgVvM3LvTnA6vX9i2p949P8gF8FiuqgQlmzzfu3a8oFvTyVObW3marVBJneo4GekBxke/JlQLMm/narFmVXlkFzSKhuoOuwo8J6JjpAQLFYqgwhAzTO+wRyVFyt6Al699EuN83s7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dk0KpHrR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 0760E2027E11; Fri,  4 Apr 2025 07:45:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0760E2027E11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743777956;
	bh=uVbwph+7O+ouZrW3G3mHhw6G2CAiHZ16DZIxMmSqEbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dk0KpHrRle2wTQhrCauoQK/X4mC8Qpx+ZFOQQGL1V0ftBGlWcuoBngrlVnmSe9q0K
	 lv89bQu95HCgh7dQXZqA4dKcRw+lDiYjApA+5X7PL6wvnazQnlu23izDGDyoFCT4ZU
	 woCgd4ql/oOVRy7MHA+X04JVSYsM01FKTGNUmFSY=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH rdma-next 3/3] RDMA/mana_ib: Add support of 4M, 1G, and 2G pages
Date: Fri,  4 Apr 2025 07:45:55 -0700
Message-Id: <1743777955-2316-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Check PF capability flag whether the 4M, 1G, and 2G pages are
supported. Add these pages sizes to mana_ib, if supported.

Define possible page sizes in enum gdma_page_type and
remove unused enum atb_page_size.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c             | 10 +++++--
 drivers/infiniband/hw/mana/mana_ib.h          |  1 +
 .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
 include/net/mana/gdma.h                       | 30 ++++++++++---------
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 730f958..a28b712 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -479,7 +479,7 @@ int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 {
 	unsigned long page_sz;
 
-	page_sz = ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, virt);
+	page_sz = ib_umem_find_best_pgsz(umem, dev->adapter_caps.page_size_cap, virt);
 	if (!page_sz) {
 		ibdev_dbg(&dev->ib_dev, "Failed to find page size.\n");
 		return -EINVAL;
@@ -494,7 +494,7 @@ int mana_ib_create_zero_offset_dma_region(struct mana_ib_dev *dev, struct ib_ume
 	unsigned long page_sz;
 
 	/* Hardware requires dma region to align to chosen page size */
-	page_sz = ib_umem_find_best_pgoff(umem, PAGE_SZ_BM, 0);
+	page_sz = ib_umem_find_best_pgoff(umem, dev->adapter_caps.page_size_cap, 0);
 	if (!page_sz) {
 		ibdev_dbg(&dev->ib_dev, "Failed to find page size.\n");
 		return -EINVAL;
@@ -577,7 +577,7 @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 
 	memset(props, 0, sizeof(*props));
 	props->max_mr_size = MANA_IB_MAX_MR_SIZE;
-	props->page_size_cap = PAGE_SZ_BM;
+	props->page_size_cap = dev->adapter_caps.page_size_cap;
 	props->max_qp = dev->adapter_caps.max_qp_count;
 	props->max_qp_wr = dev->adapter_caps.max_qp_wr;
 	props->device_cap_flags = IB_DEVICE_RC_RNR_NAK_GEN;
@@ -696,6 +696,10 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
 	caps->max_recv_sge_count = resp.max_recv_sge_count;
 	caps->feature_flags = resp.feature_flags;
 
+	caps->page_size_cap = PAGE_SZ_BM;
+	if (mdev_to_gc(dev)->pf_cap_flags1 & GDMA_DRV_CAP_FLAG_1_GDMA_PAGES_4MB_1GB_2GB)
+		caps->page_size_cap |= (SZ_4M | SZ_1G | SZ_2G);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 6903946..f0dbd90 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -60,6 +60,7 @@ struct mana_ib_adapter_caps {
 	u32 max_recv_sge_count;
 	u32 max_inline_data_size;
 	u64 feature_flags;
+	u64 page_size_cap;
 };
 
 struct mana_ib_queue {
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 4a2b17f..b5156d4 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -937,6 +937,7 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
 			err, resp.hdr.status);
 		return err ? err : -EPROTO;
 	}
+	gc->pf_cap_flags1 = resp.pf_cap_flags1;
 	if (resp.pf_cap_flags1 & GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG) {
 		err = mana_gd_query_hwc_timeout(pdev, &hwc->hwc_timeout);
 		if (err) {
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 3db506d..fd37507 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -194,6 +194,19 @@ struct gdma_wqe_request {
 
 enum gdma_page_type {
 	GDMA_PAGE_TYPE_4K,
+	GDMA_PAGE_SIZE_8K,
+	GDMA_PAGE_SIZE_16K,
+	GDMA_PAGE_SIZE_32K,
+	GDMA_PAGE_SIZE_64K,
+	GDMA_PAGE_SIZE_128K,
+	GDMA_PAGE_SIZE_256K,
+	GDMA_PAGE_SIZE_512K,
+	GDMA_PAGE_SIZE_1M,
+	GDMA_PAGE_SIZE_2M,
+	/* Only when GDMA_DRV_CAP_FLAG_1_GDMA_PAGES_4MB_1GB_2GB is set */
+	GDMA_PAGE_SIZE_4M,
+	GDMA_PAGE_SIZE_1G = 18,
+	GDMA_PAGE_SIZE_2G
 };
 
 #define GDMA_INVALID_DMA_REGION 0
@@ -407,6 +420,8 @@ struct gdma_context {
 
 	/* Azure RDMA adapter */
 	struct gdma_dev		mana_ib;
+
+	u64 pf_cap_flags1;
 };
 
 #define MAX_NUM_GDMA_DEVICES	4
@@ -556,6 +571,7 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX BIT(2)
 #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
 #define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
+#define GDMA_DRV_CAP_FLAG_1_GDMA_PAGES_4MB_1GB_2GB BIT(4)
 
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
@@ -704,20 +720,6 @@ struct gdma_query_hwc_timeout_resp {
 	u32 reserved;
 };
 
-enum atb_page_size {
-	ATB_PAGE_SIZE_4K,
-	ATB_PAGE_SIZE_8K,
-	ATB_PAGE_SIZE_16K,
-	ATB_PAGE_SIZE_32K,
-	ATB_PAGE_SIZE_64K,
-	ATB_PAGE_SIZE_128K,
-	ATB_PAGE_SIZE_256K,
-	ATB_PAGE_SIZE_512K,
-	ATB_PAGE_SIZE_1M,
-	ATB_PAGE_SIZE_2M,
-	ATB_PAGE_SIZE_MAX,
-};
-
 enum gdma_mr_access_flags {
 	GDMA_ACCESS_FLAG_LOCAL_READ = BIT_ULL(0),
 	GDMA_ACCESS_FLAG_LOCAL_WRITE = BIT_ULL(1),
-- 
2.43.0


