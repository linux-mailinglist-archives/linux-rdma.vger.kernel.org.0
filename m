Return-Path: <linux-rdma+bounces-9401-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93439A87B3D
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 11:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D320172529
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 09:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373B425E830;
	Mon, 14 Apr 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Zp9kwcVA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE031B21A7;
	Mon, 14 Apr 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621243; cv=none; b=mO8S+Z7VZlYiRuAULwfELAqi+OKEe1Fn8OYR03/id/fr892g6cXB6RoZbqkxIXWdctL4vDFW8q3RgM482bMBsPYtZiNEnsUcHzkgXwfqxIiiXiVKYmslHnmdDVOE0VWneOnfJmhT8gZbQ3qXqsxzmatUjbRCOo1/lA1c7Lf67ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621243; c=relaxed/simple;
	bh=SgC9nKmAXqOqD7lU7C44bE42f0kscW5919alLDnydik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BUMIQUWNC97ed3OXO0yQ1Zxv+G4tNPxnrEzUKHCC7nMr6kXnRy5NY5onc75REUYFuMQvcbVR3HZp3xMuNX5cvYfcWpRbmL4RlapfsfkNOSgr/rFak2zyBkIB8j+WdkX1BS5NF8znIYDNoOsIyVfiE3nWPIqtIRbll3i1VjcwHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Zp9kwcVA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id D1C3821180D3; Mon, 14 Apr 2025 02:00:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D1C3821180D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744621234;
	bh=1yD9vuRJtl+z43VxkiUGzUyb0pDEZDwEzowuVDXBCEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zp9kwcVAi/aESsVoaTeho7EVkrFMBtx98eeWTWrv44BzJQoklx3mFYadji++dRIZE
	 VsysN9fDIZxhyTL9zqkV/46DFhlNd4r6ChngqBhgoxX2pSpWOCdRsgs2CbW0s3VMc5
	 QUkcEfNrNovpfKqD+tSw8NzepOuKma3wzXHmX4iM=
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
Subject: [PATCH rdma-next v2 3/3] RDMA/mana_ib: Add support of 4M, 1G, and 2G pages
Date: Mon, 14 Apr 2025 02:00:34 -0700
Message-Id: <1744621234-26114-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744621234-26114-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1744621234-26114-1-git-send-email-kotaranov@linux.microsoft.com>
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
 drivers/infiniband/hw/mana/main.c               | 10 +++++++---
 drivers/infiniband/hw/mana/mana_ib.h            |  1 +
 drivers/net/ethernet/microsoft/mana/gdma_main.c |  1 +
 include/net/mana/gdma.h                         | 17 +++--------------
 4 files changed, 12 insertions(+), 17 deletions(-)

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
index 3db506d..89abf98 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -407,6 +407,8 @@ struct gdma_context {
 
 	/* Azure RDMA adapter */
 	struct gdma_dev		mana_ib;
+
+	u64 pf_cap_flags1;
 };
 
 #define MAX_NUM_GDMA_DEVICES	4
@@ -556,6 +558,7 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX BIT(2)
 #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
 #define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
+#define GDMA_DRV_CAP_FLAG_1_GDMA_PAGES_4MB_1GB_2GB BIT(4)
 
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
@@ -704,20 +707,6 @@ struct gdma_query_hwc_timeout_resp {
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


