Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A297A164CB
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfEGNjH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:39:07 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40582 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726825AbfEGNjH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:39:07 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:42 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdFN021865;
        Tue, 7 May 2019 16:38:42 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 23/25] RDMA/mlx5: Improve PI handover performance
Date:   Tue,  7 May 2019 16:38:37 +0300
Message-Id: <1557236319-9986-24-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

In some loads, there is performace degradation when using KLM mkey
instead of MTT mkey. This is because KLM descriptor access is via
indirection that might require more HW resources and cycles.
Using KLM descriptor is not nessecery when there are no gaps at the
data/metadata sg lists. As an optimization, use MTT mkey whenever it
is possible. For that matter, allocate internal MTT mkey and choose the
effective pi_mr for in transaction according to the required mapping
scheme.

The setup of the tested benchmark (using iSER ULP):
 - 2 servers with 24 cores (1 initiator and 1 target)
 - ConnectX-4/ConnectX-5 adapters
 - 24 target sessions with 1 LUN each
 - ramdisk backstore
 - PI active

Performance results running fio (24 jobs, 128 iodepth) using
write_generate=1 and read_verify=1 (w/w.o patch):

bs      IOPS(read)        IOPS(write)
----    ----------        ----------
512   1262.4K/1243.3K    1732.1K/1725.1K
4k    570902/571233      773982/743293
32k   72086/72388        96164/71789

Using write_generate=0 and read_verify=0 (w/w.o patch):
bs      IOPS(read)        IOPS(write)
----    ----------        ----------
512   1600.1K/1572.1K    1830.3K/1823.5K
4k    937272/921992      815304/753772
32k   77369/75052        97435/73180

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Suggested-by: Max Gurtovoy <maxg@mellanox.com>
Suggested-by: Idan Burstein <idanb@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   7 +-
 drivers/infiniband/hw/mlx5/mr.c      | 176 ++++++++++++++++++++++++++++++-----
 drivers/infiniband/hw/mlx5/qp.c      |   2 +-
 3 files changed, 162 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index c25a5c4bf9d6..5bc18256b71a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -586,7 +586,12 @@ struct mlx5_ib_mr {
 	int			access_flags; /* Needed for rereg MR */
 
 	struct mlx5_ib_mr      *parent;
-	struct mlx5_ib_mr      *pi_mr; /* Needed for IB_MR_TYPE_INTEGRITY */
+	/* Needed for IB_MR_TYPE_INTEGRITY */
+	struct mlx5_ib_mr      *pi_mr;
+	struct mlx5_ib_mr      *klm_mr;
+	struct mlx5_ib_mr      *mtt_mr;
+	u64			pi_iova;
+
 	atomic_t		num_leaf_free;
 	wait_queue_head_t       q_leaf_free;
 	struct mlx5_async_work  cb_work;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index c01097986e61..f94c47b87426 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1627,8 +1627,10 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr)
 {
 	struct mlx5_ib_mr *mmr = to_mmr(ibmr);
 
-	if (ibmr->type == IB_MR_TYPE_INTEGRITY)
-		dereg_mr(to_mdev(mmr->pi_mr->ibmr.device), mmr->pi_mr);
+	if (ibmr->type == IB_MR_TYPE_INTEGRITY) {
+		dereg_mr(to_mdev(mmr->mtt_mr->ibmr.device), mmr->mtt_mr);
+		dereg_mr(to_mdev(mmr->klm_mr->ibmr.device), mmr->klm_mr);
+	}
 
 	dereg_mr(to_mdev(ibmr->device), mmr);
 
@@ -1636,7 +1638,8 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr)
 }
 
 static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
-				u32 max_num_sg, u32 max_num_meta_sg)
+				u32 max_num_sg, u32 max_num_meta_sg,
+				int desc_size, int access_mode)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
@@ -1659,16 +1662,17 @@ static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 	MLX5_SET(mkc, mkc, free, 1);
 	MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
+	if (access_mode == MLX5_MKC_ACCESS_MODE_MTT)
+		MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
 	MLX5_SET(mkc, mkc, qpn, 0xffffff);
 	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
 
-	mr->access_mode = MLX5_MKC_ACCESS_MODE_KLMS;
+	mr->access_mode = access_mode;
 
-	err = mlx5_alloc_priv_descs(pd->device, mr,
-				    ndescs, sizeof(struct mlx5_klm));
+	err = mlx5_alloc_priv_descs(pd->device, mr, ndescs, desc_size);
 	if (err)
 		goto err_free_in;
-	mr->desc_size = sizeof(struct mlx5_klm);
+	mr->desc_size = desc_size;
 	mr->max_descs = ndescs;
 
 	MLX5_SET(mkc, mkc, access_mode_1_0, mr->access_mode & 0x3);
@@ -1772,12 +1776,22 @@ static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
 		mr->sig->sig_err_exists = false;
 		/* Next UMR, Arm SIGERR */
 		++mr->sig->sigerr_count;
-		mr->pi_mr = mlx5_ib_alloc_pi_mr(pd, max_num_sg,
-						max_num_meta_sg);
-		if (IS_ERR(mr->pi_mr)) {
-			err = PTR_ERR(mr->pi_mr);
+		mr->klm_mr = mlx5_ib_alloc_pi_mr(pd, max_num_sg,
+						max_num_meta_sg,
+						sizeof(struct mlx5_klm),
+						MLX5_MKC_ACCESS_MODE_KLMS);
+		if (IS_ERR(mr->klm_mr)) {
+			err = PTR_ERR(mr->klm_mr);
 			goto err_destroy_psv;
 		}
+		mr->mtt_mr = mlx5_ib_alloc_pi_mr(pd, max_num_sg,
+						max_num_meta_sg,
+						sizeof(struct mlx5_mtt),
+						MLX5_MKC_ACCESS_MODE_MTT);
+		if (IS_ERR(mr->mtt_mr)) {
+			err = PTR_ERR(mr->mtt_mr);
+			goto err_free_klm_mr;
+		}
 	} else {
 		mlx5_ib_warn(dev, "Invalid mr type %d\n", mr_type);
 		err = -EINVAL;
@@ -1802,9 +1816,14 @@ static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
 	return &mr->ibmr;
 
 err_free_pi_mr:
-	if (mr->pi_mr) {
-		dereg_mr(to_mdev(mr->pi_mr->ibmr.device), mr->pi_mr);
-		mr->pi_mr = NULL;
+	if (mr->mtt_mr) {
+		dereg_mr(to_mdev(mr->mtt_mr->ibmr.device), mr->mtt_mr);
+		mr->mtt_mr = NULL;
+	}
+err_free_klm_mr:
+	if (mr->klm_mr) {
+		dereg_mr(to_mdev(mr->klm_mr->ibmr.device), mr->klm_mr);
+		mr->klm_mr = NULL;
 	}
 err_destroy_psv:
 	if (mr->sig) {
@@ -2043,16 +2062,94 @@ static int mlx5_set_page(struct ib_mr *ibmr, u64 addr)
 	return 0;
 }
 
-int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
+static int mlx5_set_page_pi(struct ib_mr *ibmr, u64 addr)
+{
+	struct mlx5_ib_mr *mr = to_mmr(ibmr);
+	__be64 *descs;
+
+	if (unlikely(mr->ndescs + mr->meta_ndescs == mr->max_descs))
+		return -ENOMEM;
+
+	descs = mr->descs;
+	descs[mr->ndescs + mr->meta_ndescs++] =
+		cpu_to_be64(addr | MLX5_EN_RD | MLX5_EN_WR);
+
+	return 0;
+}
+
+static int
+mlx5_ib_map_mtt_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
 			 int data_sg_nents, unsigned int *data_sg_offset,
 			 struct scatterlist *meta_sg, int meta_sg_nents,
 			 unsigned int *meta_sg_offset)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
-	struct mlx5_ib_mr *pi_mr = mr->pi_mr;
+	struct mlx5_ib_mr *pi_mr = mr->mtt_mr;
 	int n;
+	u64 iova;
 
-	WARN_ON(ibmr->type != IB_MR_TYPE_INTEGRITY);
+	pi_mr->ndescs = 0;
+	pi_mr->meta_ndescs = 0;
+
+	ib_dma_sync_single_for_cpu(ibmr->device, pi_mr->desc_map,
+				   pi_mr->desc_size * pi_mr->max_descs,
+				   DMA_TO_DEVICE);
+
+	pi_mr->ibmr.page_size = ibmr->page_size;
+	n = ib_sg_to_pages(&pi_mr->ibmr, data_sg, data_sg_nents, data_sg_offset,
+			   mlx5_set_page);
+	if (n != data_sg_nents)
+		return n;
+
+	iova = pi_mr->ibmr.iova;
+	pi_mr->data_length = pi_mr->ibmr.length;
+	pi_mr->ibmr.length = pi_mr->data_length;
+	ibmr->length = pi_mr->data_length;
+
+	if (meta_sg_nents) {
+		u64 page_mask = ~((u64)ibmr->page_size - 1);
+
+		n += ib_sg_to_pages(&pi_mr->ibmr, meta_sg, meta_sg_nents,
+				    meta_sg_offset, mlx5_set_page_pi);
+
+		pi_mr->meta_length = pi_mr->ibmr.length;
+		/*
+		 * PI address for the HW is the offset of the metadata address
+		 * relative to the first data page address.
+		 * It equals to first data page address + size of data pages +
+		 * metadata offset at the first metadata page
+		 */
+		pi_mr->pi_iova = (iova & page_mask) +
+				 pi_mr->ndescs * ibmr->page_size +
+				 (pi_mr->ibmr.iova & ~page_mask);
+		/*
+		 * In order to use one MTT MR for data and metadata, we register
+		 * also the gaps between the end of the data and the start of
+		 * the metadata (the sig MR will verify that the HW will access
+		 * to right addresses). This mapping is safe because we use
+		 * internal mkey for the registration.
+		 */
+		pi_mr->ibmr.length = pi_mr->pi_iova + pi_mr->meta_length - iova;
+		pi_mr->ibmr.iova = iova;
+		ibmr->length += pi_mr->meta_length;
+	}
+
+	ib_dma_sync_single_for_device(ibmr->device, pi_mr->desc_map,
+				      pi_mr->desc_size * pi_mr->max_descs,
+				      DMA_TO_DEVICE);
+
+	return n;
+}
+
+static int
+mlx5_ib_map_klm_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
+			 int data_sg_nents, unsigned int *data_sg_offset,
+			 struct scatterlist *meta_sg, int meta_sg_nents,
+			 unsigned int *meta_sg_offset)
+{
+	struct mlx5_ib_mr *mr = to_mmr(ibmr);
+	struct mlx5_ib_mr *pi_mr = mr->klm_mr;
+	int n;
 
 	pi_mr->ndescs = 0;
 	pi_mr->meta_ndescs = 0;
@@ -2064,14 +2161,51 @@ int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
 	n = mlx5_ib_sg_to_klms(pi_mr, data_sg, data_sg_nents, data_sg_offset,
 			       meta_sg, meta_sg_nents, meta_sg_offset);
 
+	ib_dma_sync_single_for_device(ibmr->device, pi_mr->desc_map,
+				      pi_mr->desc_size * pi_mr->max_descs,
+				      DMA_TO_DEVICE);
+
 	/* This is zero-based memory region */
 	pi_mr->ibmr.iova = 0;
+	pi_mr->pi_iova = pi_mr->data_length;
 	ibmr->length = pi_mr->ibmr.length;
-	ibmr->iova = pi_mr->ibmr.iova;
 
-	ib_dma_sync_single_for_device(ibmr->device, pi_mr->desc_map,
-				      pi_mr->desc_size * pi_mr->max_descs,
-				      DMA_TO_DEVICE);
+	return n;
+}
+
+int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
+			 int data_sg_nents, unsigned int *data_sg_offset,
+			 struct scatterlist *meta_sg, int meta_sg_nents,
+			 unsigned int *meta_sg_offset)
+{
+	struct mlx5_ib_mr *mr = to_mmr(ibmr);
+	struct mlx5_ib_mr *pi_mr = mr->mtt_mr;
+	int n;
+
+	WARN_ON(ibmr->type != IB_MR_TYPE_INTEGRITY);
+
+	/*
+	 * As a performance optimization, if possible, there is no need to map
+	 * the sg lists to KLM descriptors. First try to map the sg lists to MTT
+	 * descriptors and fallback to KLM only in case of a failure.
+	 * It's more efficient for the HW to work with MTT descriptors
+	 * (especially in high load).
+	 * Use KLM (indirect access) only if it's mandatory.
+	 */
+	n = mlx5_ib_map_mtt_mr_sg_pi(ibmr, data_sg, data_sg_nents,
+				     data_sg_offset, meta_sg, meta_sg_nents,
+				     meta_sg_offset);
+	if (n == data_sg_nents + meta_sg_nents)
+		goto out;
+
+	pi_mr = mr->klm_mr;
+	n = mlx5_ib_map_klm_mr_sg_pi(ibmr, data_sg, data_sg_nents,
+				     data_sg_offset, meta_sg, meta_sg_nents,
+				     meta_sg_offset);
+out:
+	/* This is zero-based memory region */
+	ibmr->iova = 0;
+	mr->pi_mr = pi_mr;
 
 	return n;
 }
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 5bb9bc0975c0..4fb816712c29 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4488,7 +4488,7 @@ static int set_sig_data_segment(const struct ib_send_wr *send_wr,
 	if (pi_mr->meta_ndescs) {
 		prot_len = pi_mr->meta_length;
 		prot_key = pi_mr->ibmr.lkey;
-		prot_va = pi_mr->ibmr.iova + data_len;
+		prot_va = pi_mr->pi_iova;
 		prot = true;
 	}
 
-- 
2.16.3

