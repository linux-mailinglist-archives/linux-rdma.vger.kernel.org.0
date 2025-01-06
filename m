Return-Path: <linux-rdma+bounces-6845-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FBAA02FBC
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 19:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB671621F9
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D8A1DACBB;
	Mon,  6 Jan 2025 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4yLdIoL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ABE3597E
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jan 2025 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736188038; cv=none; b=dVUFDL0QVy7oLlpjgY4UHVvwordmwxVuHjX3gm1Tzudivw0X9Hn1R7it5JzRrt0E7WZGdkUIC8iQj6Dd1RVCxfAMS5y3eXbTbyck+n+t0xzLHql50uizVH7CVAYvfAmFiBuIx3sU1DrdwK6zeE7QDT4Rb/jDO5wNrSk6w+FJ65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736188038; c=relaxed/simple;
	bh=/SSMk5qG24R97Mv38tI955ebt+AEK6Fk2f69Ws+JZL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1Ke7/1uHH98IfbX8js73E01qPD73fSO47Xyi9JZh0FzL6E/S0l+z1uQ42wDIKU+on0mlzZSuVA+dRF+KCCTQei54+CHuqxL19Cj3AUOnm36/d2FsTKrWLR3DCOtzWxOic6r2J8PE0DEGZh46dyrcXGwCtJgn9w7gkq4XwZyKBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4yLdIoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B783BC4CED2;
	Mon,  6 Jan 2025 18:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736188038;
	bh=/SSMk5qG24R97Mv38tI955ebt+AEK6Fk2f69Ws+JZL4=;
	h=From:To:Cc:Subject:Date:From;
	b=e4yLdIoLfHq9jBMiwCbaHQd1Lv1H9Hs3TSDxDr2OTsc7CBWR8tEVdbYJltGCoxoe2
	 2yCDozntPEgdraZtyWLEXoTHR0QFTxFZWflGxWbRhHed3UEnRRNhn1aGzXTiWF/tOs
	 IHXYJkWv4ZQwxb4D96k9+6wyqHdTip7idIHlnk0/FydCmI7od4zAYxhBLxCWn9irrx
	 z7ofmMPJrf8AOUgAODt3pJKrlIjaLILPvJz+CxkcHR3MQimsQo3IxqtcOIg1szOPSV
	 jrJAi3yXwWMHCNpq3NIIHbG3MPuxsJdfZj1xBT1czglMMmQQ4etiGno5HD+KZNPUqR
	 1s6pE1leR8dew==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	Artemy Kovalyov <artemyko@mellanox.com>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Doug Ledford <dledford@redhat.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Fix indirect mkey ODP page count
Date: Mon,  6 Jan 2025 20:27:10 +0200
Message-ID: <86c483d9e75ce8fe14e9ff85b62df72b779f8ab1.1736187990.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

Restrict the check for the number of pages handled during an ODP page
fault to direct mkeys.
Perform the check right after handling the page fault and don't
propagate the number of handled pages to callers.

Indirect mkeys and their associated direct mkeys can have different
start addresses. As a result, the calculation of the number of pages to
handle for an indirect mkey may not match the actual page fault
handling done on the direct mkey.

For example:
A 4K sized page fault on a KSM mkey that has a start address that is not
aligned to a page will result a calculation that assumes the number of
pages required to handle are 2.
While the underlying MTT might be aligned will require fetching only a
single page.
Thus, do the calculation and compare number of pages handled only per
direct mkey.

Fixes: db570d7deafb ("IB/mlx5: Add ODP support to MW")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Artemy Kovalyov <artemyko@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index e2468a602e3df..d33ecc37eafed 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -961,8 +961,7 @@ static struct mlx5_ib_mkey *find_odp_mkey(struct mlx5_ib_dev *dev, u32 key)
 /*
  * Handle a single data segment in a page-fault WQE or RDMA region.
  *
- * Returns number of OS pages retrieved on success. The caller may continue to
- * the next data segment.
+ * Returns zero on success. The caller may continue to the next data segment.
  * Can return the following error codes:
  * -EAGAIN to designate a temporary error. The caller will abort handling the
  *  page fault and resolve it.
@@ -975,7 +974,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 					 u32 *bytes_committed,
 					 u32 *bytes_mapped)
 {
-	int npages = 0, ret, i, outlen, cur_outlen = 0, depth = 0;
+	int ret, i, outlen, cur_outlen = 0, depth = 0, pages_in_range;
 	struct pf_frame *head = NULL, *frame;
 	struct mlx5_ib_mkey *mmkey;
 	struct mlx5_ib_mr *mr;
@@ -1010,13 +1009,20 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	case MLX5_MKEY_MR:
 		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
 
+		pages_in_range = (ALIGN(io_virt + bcnt, PAGE_SIZE) -
+				  (io_virt & PAGE_MASK)) >>
+				 PAGE_SHIFT;
 		ret = pagefault_mr(mr, io_virt, bcnt, bytes_mapped, 0, false);
 		if (ret < 0)
 			goto end;
 
 		mlx5_update_odp_stats_with_handled(mr, faults, ret);
 
-		npages += ret;
+		if (ret < pages_in_range) {
+			ret = -EFAULT;
+			goto end;
+		}
+
 		ret = 0;
 		break;
 
@@ -1107,7 +1113,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	kfree(out);
 
 	*bytes_committed = 0;
-	return ret ? ret : npages;
+	return ret;
 }
 
 /*
@@ -1126,8 +1132,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
  *                   the committed bytes).
  * @receive_queue: receive WQE end of sg list
  *
- * Returns the number of pages loaded if positive, zero for an empty WQE, or a
- * negative error code.
+ * Returns zero for success or a negative error code.
  */
 static int pagefault_data_segments(struct mlx5_ib_dev *dev,
 				   struct mlx5_pagefault *pfault,
@@ -1135,7 +1140,7 @@ static int pagefault_data_segments(struct mlx5_ib_dev *dev,
 				   void *wqe_end, u32 *bytes_mapped,
 				   u32 *total_wqe_bytes, bool receive_queue)
 {
-	int ret = 0, npages = 0;
+	int ret = 0;
 	u64 io_virt;
 	__be32 key;
 	u32 byte_count;
@@ -1192,10 +1197,9 @@ static int pagefault_data_segments(struct mlx5_ib_dev *dev,
 						    bytes_mapped);
 		if (ret < 0)
 			break;
-		npages += ret;
 	}
 
-	return ret < 0 ? ret : npages;
+	return ret;
 }
 
 /*
@@ -1431,12 +1435,6 @@ static void mlx5_ib_mr_wqe_pfault_handler(struct mlx5_ib_dev *dev,
 	free_page((unsigned long)wqe_start);
 }
 
-static int pages_in_range(u64 address, u32 length)
-{
-	return (ALIGN(address + length, PAGE_SIZE) -
-		(address & PAGE_MASK)) >> PAGE_SHIFT;
-}
-
 static void mlx5_ib_mr_rdma_pfault_handler(struct mlx5_ib_dev *dev,
 					   struct mlx5_pagefault *pfault)
 {
@@ -1475,7 +1473,7 @@ static void mlx5_ib_mr_rdma_pfault_handler(struct mlx5_ib_dev *dev,
 	if (ret == -EAGAIN) {
 		/* We're racing with an invalidation, don't prefetch */
 		prefetch_activated = 0;
-	} else if (ret < 0 || pages_in_range(address, length) > ret) {
+	} else if (ret < 0) {
 		mlx5_ib_page_fault_resume(dev, pfault, 1);
 		if (ret != -ENOENT)
 			mlx5_ib_dbg(dev, "PAGE FAULT error %d. QP 0x%llx, type: 0x%x\n",
-- 
2.47.1


