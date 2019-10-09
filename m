Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA4D13B0
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfJIQKI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36578 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731263AbfJIQKI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so2728730qkc.3
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kbE2tigKcttwGSoKp/C8WI57GOhYaAJ0DTbU2igQ6CE=;
        b=DGcJ0RjYqJbM7AeQtc0TAxWuCLucVyYymtF8bCmv2m9ab7/OpgX8xLS7/2h3smckcc
         TDFW1y9wWyfZhqAEGLm7fHy0ilfHNYGxIESflJjKquLNBVJ11hevIbIKAYEKqsYqjKe6
         f2u86Vb2ZruyE/12l0avz+sGeSSJwFm5Qs21HGNtq3PzKpcGRGQmJErn7/chwHhCn+Pl
         DG0sXiWtXdM/0PkzjsWkO/zsgwrdnPhpkA53zJSU5cjie9nITwuJhuxHKyLzY+5LYZGr
         ooVqneSKM93pfydNLfZ+NFUc3FvQcFg2xe57tSc/GhUcAhCbE7UrSf0gLj8mA8pdUeUx
         jkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbE2tigKcttwGSoKp/C8WI57GOhYaAJ0DTbU2igQ6CE=;
        b=pP+Vl+rz4pCF0j7+JFncva6VxBo731XVlEskO0n1j/g/1Q5PdgbbnEGK4U6Nfzfp5s
         nZUpwshJXjNOlDZAlA43x7Y0sVGFEHbTDBBLF9hOmCJZsAyK/67gKA3ESLHKmpwWQZm8
         S+pAsT88pBY0fkpFXFhFYL+yLSEGeihgjyzx5iT+02FtFB/X+6lj/fq6zZwwu5JMpJmb
         A4lDdfuV523Dsp9KHp4eDuFeXeGKc0rrw9WhG0+/SnS+VPVAPJiG4HZjbon357Fcqmmq
         XoRrCiyyO/mMGB/hndGbU6dBCs29DCSuvTzkEIYb9bzw5537FnFcTtI8+jUInvV7fJHM
         AN0w==
X-Gm-Message-State: APjAAAU8Speq6AKZRgmP9nbnToH5XBn6/cTLlcn3YUXTBFxJ1k9UWzjg
        OJ1CITEOAsY7WLpVxiIvCFislUH3QlI=
X-Google-Smtp-Source: APXvYqzP2WCzrEEzx3TVY+ApTgvkasobCUzvpUNuWhtRVGP8cE93c0zWXCR3WM7wnk4afRqaqyvyjA==
X-Received: by 2002:a05:620a:a12:: with SMTP id i18mr3830748qka.290.1570637406383;
        Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id p22sm1121665qkk.92.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXM-0000qI-MW; Wed, 09 Oct 2019 13:10:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 01/15] RDMA/mlx5: Use SRCU properly in ODP prefetch
Date:   Wed,  9 Oct 2019 13:09:21 -0300
Message-Id: <20191009160934.3143-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009160934.3143-1-jgg@ziepe.ca>
References: <20191009160934.3143-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

When working with SRCU protected xarrays the xarray itself should be the
SRCU 'update' point. Instead prefetch is using live as the SRCU update
point and this prevents switching the locking design to use the xarray
instead.

To solve this the prefetch must only read from the xarray once, and hold
on to the actual MR pointer for the duration of the async
operation. Incrementing num_pending_prefetch delays destruction of the MR,
so it is suitable.

Prefetch calls directly to the pagefault_mr using the MR pointer and only
does a single xarray lookup.

All the testing if a MR is prefetchable or not is now done only in the
prefetch code and removed from the pagefault critical path.

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 261 ++++++++++++++-----------------
 1 file changed, 120 insertions(+), 141 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 3f9478d1937668..4cc5b9420d3ec4 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -606,16 +606,13 @@ void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 	wait_event(imr->q_leaf_free, !atomic_read(&imr->num_leaf_free));
 }
 
-#define MLX5_PF_FLAGS_PREFETCH  BIT(0)
 #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
-static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
-			u64 io_virt, size_t bcnt, u32 *bytes_mapped,
-			u32 flags)
+static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
+			u32 *bytes_mapped, u32 flags)
 {
 	int npages = 0, current_seq, page_shift, ret, np;
 	struct ib_umem_odp *odp_mr = to_ib_umem_odp(mr->umem);
 	bool downgrade = flags & MLX5_PF_FLAGS_DOWNGRADE;
-	bool prefetch = flags & MLX5_PF_FLAGS_PREFETCH;
 	u64 access_mask;
 	u64 start_idx, page_mask;
 	struct ib_umem_odp *odp;
@@ -639,14 +636,6 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 	start_idx = (io_virt - (mr->mmkey.iova & page_mask)) >> page_shift;
 	access_mask = ODP_READ_ALLOWED_BIT;
 
-	if (prefetch && !downgrade && !odp->umem.writable) {
-		/* prefetch with write-access must
-		 * be supported by the MR
-		 */
-		ret = -EINVAL;
-		goto out;
-	}
-
 	if (odp->umem.writable && !downgrade)
 		access_mask |= ODP_WRITE_ALLOWED_BIT;
 
@@ -681,7 +670,8 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 
 	if (ret < 0) {
 		if (ret != -EAGAIN)
-			mlx5_ib_err(dev, "Failed to update mkey page tables\n");
+			mlx5_ib_err(mr->dev,
+				    "Failed to update mkey page tables\n");
 		goto out;
 	}
 
@@ -700,8 +690,10 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 		io_virt += size;
 		next = odp_next(odp);
 		if (unlikely(!next || ib_umem_start(next) != io_virt)) {
-			mlx5_ib_dbg(dev, "next implicit leaf removed at 0x%llx. got %p\n",
-				    io_virt, next);
+			mlx5_ib_dbg(
+				mr->dev,
+				"next implicit leaf removed at 0x%llx. got %p\n",
+				io_virt, next);
 			return -EAGAIN;
 		}
 		odp = next;
@@ -718,7 +710,7 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 		if (!wait_for_completion_timeout(&odp->notifier_completion,
 						 timeout)) {
 			mlx5_ib_warn(
-				dev,
+				mr->dev,
 				"timeout waiting for mmu notifier. seq %d against %d. notifiers_count=%d\n",
 				current_seq, odp->notifiers_seq,
 				odp->notifiers_count);
@@ -775,10 +767,9 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 					 struct ib_pd *pd, u32 key,
 					 u64 io_virt, size_t bcnt,
 					 u32 *bytes_committed,
-					 u32 *bytes_mapped, u32 flags)
+					 u32 *bytes_mapped)
 {
 	int npages = 0, srcu_key, ret, i, outlen, cur_outlen = 0, depth = 0;
-	bool prefetch = flags & MLX5_PF_FLAGS_PREFETCH;
 	struct pf_frame *head = NULL, *frame;
 	struct mlx5_core_mkey *mmkey;
 	struct mlx5_ib_mr *mr;
@@ -800,12 +791,6 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 		goto srcu_unlock;
 	}
 
-	if (prefetch && mmkey->type != MLX5_MKEY_MR) {
-		mlx5_ib_dbg(dev, "prefetch is allowed only for MR\n");
-		ret = -EINVAL;
-		goto srcu_unlock;
-	}
-
 	switch (mmkey->type) {
 	case MLX5_MKEY_MR:
 		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
@@ -815,17 +800,6 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 			goto srcu_unlock;
 		}
 
-		if (prefetch) {
-			if (!is_odp_mr(mr) ||
-			    mr->ibmr.pd != pd) {
-				mlx5_ib_dbg(dev, "Invalid prefetch request: %s\n",
-					    is_odp_mr(mr) ?  "MR is not ODP" :
-					    "PD is not of the MR");
-				ret = -EINVAL;
-				goto srcu_unlock;
-			}
-		}
-
 		if (!is_odp_mr(mr)) {
 			mlx5_ib_dbg(dev, "skipping non ODP MR (lkey=0x%06x) in page fault handler.\n",
 				    key);
@@ -835,7 +809,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 			goto srcu_unlock;
 		}
 
-		ret = pagefault_mr(dev, mr, io_virt, bcnt, bytes_mapped, flags);
+		ret = pagefault_mr(mr, io_virt, bcnt, bytes_mapped, 0);
 		if (ret < 0)
 			goto srcu_unlock;
 
@@ -1009,7 +983,7 @@ static int pagefault_data_segments(struct mlx5_ib_dev *dev,
 		ret = pagefault_single_data_segment(dev, NULL, key,
 						    io_virt, bcnt,
 						    &pfault->bytes_committed,
-						    bytes_mapped, 0);
+						    bytes_mapped);
 		if (ret < 0)
 			break;
 		npages += ret;
@@ -1292,8 +1266,7 @@ static void mlx5_ib_mr_rdma_pfault_handler(struct mlx5_ib_dev *dev,
 	}
 
 	ret = pagefault_single_data_segment(dev, NULL, rkey, address, length,
-					    &pfault->bytes_committed, NULL,
-					    0);
+					    &pfault->bytes_committed, NULL);
 	if (ret == -EAGAIN) {
 		/* We're racing with an invalidation, don't prefetch */
 		prefetch_activated = 0;
@@ -1320,8 +1293,7 @@ static void mlx5_ib_mr_rdma_pfault_handler(struct mlx5_ib_dev *dev,
 
 		ret = pagefault_single_data_segment(dev, NULL, rkey, address,
 						    prefetch_len,
-						    &bytes_committed, NULL,
-						    0);
+						    &bytes_committed, NULL);
 		if (ret < 0 && ret != -EAGAIN) {
 			mlx5_ib_dbg(dev, "Prefetch failed. ret: %d, QP 0x%x, address: 0x%.16llx, length = 0x%.16x\n",
 				    ret, pfault->token, address, prefetch_len);
@@ -1624,114 +1596,137 @@ int mlx5_ib_odp_init(void)
 
 struct prefetch_mr_work {
 	struct work_struct work;
-	struct ib_pd *pd;
 	u32 pf_flags;
 	u32 num_sge;
-	struct ib_sge sg_list[0];
+	struct {
+		u64 io_virt;
+		struct mlx5_ib_mr *mr;
+		size_t length;
+	} frags[];
 };
 
-static void num_pending_prefetch_dec(struct mlx5_ib_dev *dev,
-				     struct ib_sge *sg_list, u32 num_sge,
-				     u32 from)
+static void destroy_prefetch_work(struct prefetch_mr_work *work)
 {
 	u32 i;
-	int srcu_key;
-
-	srcu_key = srcu_read_lock(&dev->mr_srcu);
 
-	for (i = from; i < num_sge; ++i) {
-		struct mlx5_core_mkey *mmkey;
-		struct mlx5_ib_mr *mr;
-
-		mmkey = xa_load(&dev->mdev->priv.mkey_table,
-				mlx5_base_mkey(sg_list[i].lkey));
-		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
-		atomic_dec(&mr->num_pending_prefetch);
-	}
-
-	srcu_read_unlock(&dev->mr_srcu, srcu_key);
+	for (i = 0; i < work->num_sge; ++i)
+		atomic_dec(&work->frags[i].mr->num_pending_prefetch);
+	kvfree(work);
 }
 
-static bool num_pending_prefetch_inc(struct ib_pd *pd,
-				     struct ib_sge *sg_list, u32 num_sge)
+static struct mlx5_ib_mr *
+get_prefetchable_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
+		    u32 lkey)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	bool ret = true;
-	u32 i;
+	struct mlx5_core_mkey *mmkey;
+	struct ib_umem_odp *odp;
+	struct mlx5_ib_mr *mr;
 
-	for (i = 0; i < num_sge; ++i) {
-		struct mlx5_core_mkey *mmkey;
-		struct mlx5_ib_mr *mr;
+	lockdep_assert_held(&dev->mr_srcu);
 
-		mmkey = xa_load(&dev->mdev->priv.mkey_table,
-				mlx5_base_mkey(sg_list[i].lkey));
-		if (!mmkey || mmkey->key != sg_list[i].lkey) {
-			ret = false;
-			break;
-		}
+	mmkey = xa_load(&dev->mdev->priv.mkey_table, mlx5_base_mkey(lkey));
+	if (!mmkey || mmkey->key != lkey || mmkey->type != MLX5_MKEY_MR)
+		return NULL;
 
-		if (mmkey->type != MLX5_MKEY_MR) {
-			ret = false;
-			break;
-		}
+	mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
 
-		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
+	if (!smp_load_acquire(&mr->live))
+		return NULL;
 
-		if (!smp_load_acquire(&mr->live)) {
-			ret = false;
-			break;
-		}
+	if (mr->ibmr.pd != pd || !is_odp_mr(mr))
+		return NULL;
 
-		if (mr->ibmr.pd != pd) {
-			ret = false;
-			break;
-		}
+	/*
+	 * Implicit child MRs are internal and userspace should not refer to
+	 * them.
+	 */
+	if (mr->parent)
+		return NULL;
 
-		atomic_inc(&mr->num_pending_prefetch);
-	}
+	odp = to_ib_umem_odp(mr->umem);
 
-	if (!ret)
-		num_pending_prefetch_dec(dev, sg_list, i, 0);
+	/* prefetch with write-access must be supported by the MR */
+	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
+	    !odp->umem.writable)
+		return NULL;
 
-	return ret;
+	return mr;
 }
 
-static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd, u32 pf_flags,
-				    struct ib_sge *sg_list, u32 num_sge)
+static void mlx5_ib_prefetch_mr_work(struct work_struct *w)
 {
+	struct prefetch_mr_work *work =
+		container_of(w, struct prefetch_mr_work, work);
+	u32 bytes_mapped = 0;
 	u32 i;
-	int ret = 0;
-	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+
+	for (i = 0; i < work->num_sge; ++i)
+		pagefault_mr(work->frags[i].mr, work->frags[i].io_virt,
+			     work->frags[i].length, &bytes_mapped,
+			     work->pf_flags);
+
+	destroy_prefetch_work(work);
+}
+
+static bool init_prefetch_work(struct ib_pd *pd,
+			       enum ib_uverbs_advise_mr_advice advice,
+			       u32 pf_flags, struct prefetch_mr_work *work,
+			       struct ib_sge *sg_list, u32 num_sge)
+{
+	u32 i;
+
+	INIT_WORK(&work->work, mlx5_ib_prefetch_mr_work);
+	work->pf_flags = pf_flags;
 
 	for (i = 0; i < num_sge; ++i) {
-		struct ib_sge *sg = &sg_list[i];
-		int bytes_committed = 0;
+		work->frags[i].io_virt = sg_list[i].addr;
+		work->frags[i].length = sg_list[i].length;
+		work->frags[i].mr =
+			get_prefetchable_mr(pd, advice, sg_list[i].lkey);
+		if (!work->frags[i].mr) {
+			work->num_sge = i - 1;
+			if (i)
+				destroy_prefetch_work(work);
+			return false;
+		}
 
-		ret = pagefault_single_data_segment(dev, pd, sg->lkey, sg->addr,
-						    sg->length,
-						    &bytes_committed, NULL,
-						    pf_flags);
-		if (ret < 0)
-			break;
+		/* Keep the MR pointer will valid outside the SRCU */
+		atomic_inc(&work->frags[i].mr->num_pending_prefetch);
 	}
-
-	return ret < 0 ? ret : 0;
+	work->num_sge = num_sge;
+	return true;
 }
 
-static void mlx5_ib_prefetch_mr_work(struct work_struct *work)
+static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd,
+				    enum ib_uverbs_advise_mr_advice advice,
+				    u32 pf_flags, struct ib_sge *sg_list,
+				    u32 num_sge)
 {
-	struct prefetch_mr_work *w =
-		container_of(work, struct prefetch_mr_work, work);
+	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	u32 bytes_mapped = 0;
+	int srcu_key;
+	int ret = 0;
+	u32 i;
 
-	if (ib_device_try_get(w->pd->device)) {
-		mlx5_ib_prefetch_sg_list(w->pd, w->pf_flags, w->sg_list,
-					 w->num_sge);
-		ib_device_put(w->pd->device);
+	srcu_key = srcu_read_lock(&dev->mr_srcu);
+	for (i = 0; i < num_sge; ++i) {
+		struct mlx5_ib_mr *mr;
+
+		mr = get_prefetchable_mr(pd, advice, sg_list[i].lkey);
+		if (!mr) {
+			ret = -ENOENT;
+			goto out;
+		}
+		ret = pagefault_mr(mr, sg_list[i].addr, sg_list[i].length,
+				   &bytes_mapped, pf_flags);
+		if (ret < 0)
+			goto out;
 	}
 
-	num_pending_prefetch_dec(to_mdev(w->pd->device), w->sg_list,
-				 w->num_sge, 0);
-	kvfree(w);
+out:
+	srcu_read_unlock(&dev->mr_srcu, srcu_key);
+	return ret;
 }
 
 int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
@@ -1739,43 +1734,27 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 			       u32 flags, struct ib_sge *sg_list, u32 num_sge)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	u32 pf_flags = MLX5_PF_FLAGS_PREFETCH;
+	u32 pf_flags = 0;
 	struct prefetch_mr_work *work;
-	bool valid_req;
 	int srcu_key;
 
 	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
 		pf_flags |= MLX5_PF_FLAGS_DOWNGRADE;
 
 	if (flags & IB_UVERBS_ADVISE_MR_FLAG_FLUSH)
-		return mlx5_ib_prefetch_sg_list(pd, pf_flags, sg_list,
+		return mlx5_ib_prefetch_sg_list(pd, advice, pf_flags, sg_list,
 						num_sge);
 
-	work = kvzalloc(struct_size(work, sg_list, num_sge), GFP_KERNEL);
+	work = kvzalloc(struct_size(work, frags, num_sge), GFP_KERNEL);
 	if (!work)
 		return -ENOMEM;
 
-	memcpy(work->sg_list, sg_list, num_sge * sizeof(struct ib_sge));
-
-	/* It is guaranteed that the pd when work is executed is the pd when
-	 * work was queued since pd can't be destroyed while it holds MRs and
-	 * destroying a MR leads to flushing the workquque
-	 */
-	work->pd = pd;
-	work->pf_flags = pf_flags;
-	work->num_sge = num_sge;
-
-	INIT_WORK(&work->work, mlx5_ib_prefetch_mr_work);
-
 	srcu_key = srcu_read_lock(&dev->mr_srcu);
-
-	valid_req = num_pending_prefetch_inc(pd, sg_list, num_sge);
-	if (valid_req)
-		queue_work(system_unbound_wq, &work->work);
-	else
-		kvfree(work);
-
+	if (!init_prefetch_work(pd, advice, pf_flags, work, sg_list, num_sge)) {
+		srcu_read_unlock(&dev->mr_srcu, srcu_key);
+		return -EINVAL;
+	}
+	queue_work(system_unbound_wq, &work->work);
 	srcu_read_unlock(&dev->mr_srcu, srcu_key);
-
-	return valid_req ? 0 : -EINVAL;
+	return 0;
 }
-- 
2.23.0

