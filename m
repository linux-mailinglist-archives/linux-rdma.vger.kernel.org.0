Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7223D169
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391830AbfFKPxH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 11:53:07 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33036 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391579AbfFKPxH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 11:53:07 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Jun 2019 18:52:59 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x5BFqxL8023036;
        Tue, 11 Jun 2019 18:52:59 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 06/21] RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and mlx5_ib_alloc_mr_integrity
Date:   Tue, 11 Jun 2019 18:52:42 +0300
Message-Id: <1560268377-26560-7-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

mlx5_ib_map_mr_sg_pi() will map the PI and data dma mapped SG lists to the
mlx5 memory region prior to the registration operation. In the new
API, the mlx5 driver will allocate an internal memory region for the
UMR operation to register both PI and data SG lists. The internal MR
will use KLM mode in order to map 2 (possibly non-contiguous/non-align)
SG lists using 1 memory key. In the new API, each ULP will use 1 memory
region for the signature operation (instead of 3 in the old API). This
memory region will have a key that will be exposed to remote server to
perform RDMA operation. The internal memory key that will map the SG lists
will stay private.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/infiniband/hw/mlx5/main.c    |   2 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  11 +++
 drivers/infiniband/hw/mlx5/mr.c      | 187 ++++++++++++++++++++++++++++++++---
 3 files changed, 189 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 340290b883fe..f4880259c8ac 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6126,6 +6126,7 @@ static void mlx5_ib_stage_flow_db_cleanup(struct mlx5_ib_dev *dev)
 static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.add_gid = mlx5_ib_add_gid,
 	.alloc_mr = mlx5_ib_alloc_mr,
+	.alloc_mr_integrity = mlx5_ib_alloc_mr_integrity,
 	.alloc_pd = mlx5_ib_alloc_pd,
 	.alloc_ucontext = mlx5_ib_alloc_ucontext,
 	.attach_mcast = mlx5_ib_mcg_attach,
@@ -6155,6 +6156,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.get_dma_mr = mlx5_ib_get_dma_mr,
 	.get_link_layer = mlx5_ib_port_link_layer,
 	.map_mr_sg = mlx5_ib_map_mr_sg,
+	.map_mr_sg_pi = mlx5_ib_map_mr_sg_pi,
 	.mmap = mlx5_ib_mmap,
 	.modify_cq = mlx5_ib_modify_cq,
 	.modify_device = mlx5_ib_modify_device,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 40eb8be482e4..07bac37c3450 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -587,6 +587,9 @@ struct mlx5_ib_mr {
 	void			*descs;
 	dma_addr_t		desc_map;
 	int			ndescs;
+	int			data_length;
+	int			meta_ndescs;
+	int			meta_length;
 	int			max_descs;
 	int			desc_size;
 	int			access_mode;
@@ -605,6 +608,7 @@ struct mlx5_ib_mr {
 	int			access_flags; /* Needed for rereg MR */
 
 	struct mlx5_ib_mr      *parent;
+	struct mlx5_ib_mr      *pi_mr; /* Needed for IB_MR_TYPE_INTEGRITY */
 	atomic_t		num_leaf_free;
 	wait_queue_head_t       q_leaf_free;
 	struct mlx5_async_work  cb_work;
@@ -1148,8 +1152,15 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 			       u32 max_num_sg, struct ib_udata *udata);
+struct ib_mr *mlx5_ib_alloc_mr_integrity(struct ib_pd *pd,
+					 u32 max_num_sg,
+					 u32 max_num_meta_sg);
 int mlx5_ib_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		      unsigned int *sg_offset);
+int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
+			 int data_sg_nents, unsigned int *data_sg_offset,
+			 struct scatterlist *meta_sg, int meta_sg_nents,
+			 unsigned int *meta_sg_offset);
 int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 			const struct ib_wc *in_wc, const struct ib_grh *in_grh,
 			const struct ib_mad_hdr *in, size_t in_mad_size,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 5f09699fab98..1ae1846256b8 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1639,16 +1639,22 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
-	dereg_mr(to_mdev(ibmr->device), to_mmr(ibmr));
+	struct mlx5_ib_mr *mmr = to_mmr(ibmr);
+
+	if (ibmr->type == IB_MR_TYPE_INTEGRITY)
+		dereg_mr(to_mdev(mmr->pi_mr->ibmr.device), mmr->pi_mr);
+
+	dereg_mr(to_mdev(ibmr->device), mmr);
+
 	return 0;
 }
 
-struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			       u32 max_num_sg, struct ib_udata *udata)
+static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
+				u32 max_num_sg, u32 max_num_meta_sg)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
-	int ndescs = ALIGN(max_num_sg, 4);
+	int ndescs = ALIGN(max_num_sg + max_num_meta_sg, 4);
 	struct mlx5_ib_mr *mr;
 	void *mkc;
 	u32 *in;
@@ -1670,8 +1676,72 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	MLX5_SET(mkc, mkc, qpn, 0xffffff);
 	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
 
+	mr->access_mode = MLX5_MKC_ACCESS_MODE_KLMS;
+
+	err = mlx5_alloc_priv_descs(pd->device, mr,
+				    ndescs, sizeof(struct mlx5_klm));
+	if (err)
+		goto err_free_in;
+	mr->desc_size = sizeof(struct mlx5_klm);
+	mr->max_descs = ndescs;
+
+	MLX5_SET(mkc, mkc, access_mode_1_0, mr->access_mode & 0x3);
+	MLX5_SET(mkc, mkc, access_mode_4_2, (mr->access_mode >> 2) & 0x7);
+	MLX5_SET(mkc, mkc, umr_en, 1);
+
+	mr->ibmr.pd = pd;
+	mr->ibmr.device = pd->device;
+	err = mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
+	if (err)
+		goto err_priv_descs;
+
+	mr->mmkey.type = MLX5_MKEY_MR;
+	mr->ibmr.lkey = mr->mmkey.key;
+	mr->ibmr.rkey = mr->mmkey.key;
+	mr->umem = NULL;
+	kfree(in);
+
+	return mr;
+
+err_priv_descs:
+	mlx5_free_priv_descs(mr);
+err_free_in:
+	kfree(in);
+err_free:
+	kfree(mr);
+	return ERR_PTR(err);
+}
+
+static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
+					enum ib_mr_type mr_type, u32 max_num_sg,
+					u32 max_num_meta_sg)
+{
+	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
+	int ndescs = ALIGN(max_num_sg, 4);
+	struct mlx5_ib_mr *mr;
+	void *mkc;
+	u32 *in;
+	int err;
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	in = kzalloc(inlen, GFP_KERNEL);
+	if (!in) {
+		err = -ENOMEM;
+		goto err_free;
+	}
+
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	MLX5_SET(mkc, mkc, free, 1);
+	MLX5_SET(mkc, mkc, qpn, 0xffffff);
+	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
+
 	if (mr_type == IB_MR_TYPE_MEM_REG) {
 		mr->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
+		MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
 		MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
 		err = mlx5_alloc_priv_descs(pd->device, mr,
 					    ndescs, sizeof(struct mlx5_mtt));
@@ -1682,6 +1752,7 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 		mr->max_descs = ndescs;
 	} else if (mr_type == IB_MR_TYPE_SG_GAPS) {
 		mr->access_mode = MLX5_MKC_ACCESS_MODE_KLMS;
+		MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
 
 		err = mlx5_alloc_priv_descs(pd->device, mr,
 					    ndescs, sizeof(struct mlx5_klm));
@@ -1689,11 +1760,13 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 			goto err_free_in;
 		mr->desc_size = sizeof(struct mlx5_klm);
 		mr->max_descs = ndescs;
-	} else if (mr_type == IB_MR_TYPE_SIGNATURE) {
+	} else if (mr_type == IB_MR_TYPE_SIGNATURE ||
+		   mr_type == IB_MR_TYPE_INTEGRITY) {
 		u32 psv_index[2];
 
 		MLX5_SET(mkc, mkc, bsf_en, 1);
 		MLX5_SET(mkc, mkc, bsf_octword_size, MLX5_MKEY_BSF_OCTO_SIZE);
+		MLX5_SET(mkc, mkc, translations_octword_size, 4);
 		mr->sig = kzalloc(sizeof(*mr->sig), GFP_KERNEL);
 		if (!mr->sig) {
 			err = -ENOMEM;
@@ -1714,6 +1787,14 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 		mr->sig->sig_err_exists = false;
 		/* Next UMR, Arm SIGERR */
 		++mr->sig->sigerr_count;
+		if (mr_type == IB_MR_TYPE_INTEGRITY) {
+			mr->pi_mr = mlx5_ib_alloc_pi_mr(pd, max_num_sg,
+							max_num_meta_sg);
+			if (IS_ERR(mr->pi_mr)) {
+				err = PTR_ERR(mr->pi_mr);
+				goto err_destroy_psv;
+			}
+		}
 	} else {
 		mlx5_ib_warn(dev, "Invalid mr type %d\n", mr_type);
 		err = -EINVAL;
@@ -1727,7 +1808,7 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	mr->ibmr.device = pd->device;
 	err = mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
 	if (err)
-		goto err_destroy_psv;
+		goto err_free_pi_mr;
 
 	mr->mmkey.type = MLX5_MKEY_MR;
 	mr->ibmr.lkey = mr->mmkey.key;
@@ -1737,6 +1818,11 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 
 	return &mr->ibmr;
 
+err_free_pi_mr:
+	if (mr->pi_mr) {
+		dereg_mr(to_mdev(mr->pi_mr->ibmr.device), mr->pi_mr);
+		mr->pi_mr = NULL;
+	}
 err_destroy_psv:
 	if (mr->sig) {
 		if (mlx5_core_destroy_psv(dev->mdev,
@@ -1758,6 +1844,19 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	return ERR_PTR(err);
 }
 
+struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
+			       u32 max_num_sg, struct ib_udata *udata)
+{
+	return __mlx5_ib_alloc_mr(pd, mr_type, max_num_sg, 0);
+}
+
+struct ib_mr *mlx5_ib_alloc_mr_integrity(struct ib_pd *pd,
+					 u32 max_num_sg, u32 max_num_meta_sg)
+{
+	return __mlx5_ib_alloc_mr(pd, IB_MR_TYPE_INTEGRITY, max_num_sg,
+				  max_num_meta_sg);
+}
+
 struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
 			       struct ib_udata *udata)
 {
@@ -1890,13 +1989,16 @@ static int
 mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr,
 		   struct scatterlist *sgl,
 		   unsigned short sg_nents,
-		   unsigned int *sg_offset_p)
+		   unsigned int *sg_offset_p,
+		   struct scatterlist *meta_sgl,
+		   unsigned short meta_sg_nents,
+		   unsigned int *meta_sg_offset_p)
 {
 	struct scatterlist *sg = sgl;
 	struct mlx5_klm *klms = mr->descs;
 	unsigned int sg_offset = sg_offset_p ? *sg_offset_p : 0;
 	u32 lkey = mr->ibmr.pd->local_dma_lkey;
-	int i;
+	int i, j = 0;
 
 	mr->ibmr.iova = sg_dma_address(sg) + sg_offset;
 	mr->ibmr.length = 0;
@@ -1911,12 +2013,36 @@ mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr,
 
 		sg_offset = 0;
 	}
-	mr->ndescs = i;
 
 	if (sg_offset_p)
 		*sg_offset_p = sg_offset;
 
-	return i;
+	mr->ndescs = i;
+	mr->data_length = mr->ibmr.length;
+
+	if (meta_sg_nents) {
+		sg = meta_sgl;
+		sg_offset = meta_sg_offset_p ? *meta_sg_offset_p : 0;
+		for_each_sg(meta_sgl, sg, meta_sg_nents, j) {
+			if (unlikely(i + j >= mr->max_descs))
+				break;
+			klms[i + j].va = cpu_to_be64(sg_dma_address(sg) +
+						     sg_offset);
+			klms[i + j].bcount = cpu_to_be32(sg_dma_len(sg) -
+							 sg_offset);
+			klms[i + j].key = cpu_to_be32(lkey);
+			mr->ibmr.length += sg_dma_len(sg) - sg_offset;
+
+			sg_offset = 0;
+		}
+		if (meta_sg_offset_p)
+			*meta_sg_offset_p = sg_offset;
+
+		mr->meta_ndescs = j;
+		mr->meta_length = mr->ibmr.length - mr->data_length;
+	}
+
+	return i + j;
 }
 
 static int mlx5_set_page(struct ib_mr *ibmr, u64 addr)
@@ -1933,6 +2059,44 @@ static int mlx5_set_page(struct ib_mr *ibmr, u64 addr)
 	return 0;
 }
 
+int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
+			 int data_sg_nents, unsigned int *data_sg_offset,
+			 struct scatterlist *meta_sg, int meta_sg_nents,
+			 unsigned int *meta_sg_offset)
+{
+	struct mlx5_ib_mr *mr = to_mmr(ibmr);
+	struct mlx5_ib_mr *pi_mr = mr->pi_mr;
+	int n;
+
+	WARN_ON(ibmr->type != IB_MR_TYPE_INTEGRITY);
+
+	pi_mr->ndescs = 0;
+	pi_mr->meta_ndescs = 0;
+	pi_mr->meta_length = 0;
+
+	ib_dma_sync_single_for_cpu(ibmr->device, pi_mr->desc_map,
+				   pi_mr->desc_size * pi_mr->max_descs,
+				   DMA_TO_DEVICE);
+
+	n = mlx5_ib_sg_to_klms(pi_mr, data_sg, data_sg_nents, data_sg_offset,
+			       meta_sg, meta_sg_nents, meta_sg_offset);
+
+	/* This is zero-based memory region */
+	pi_mr->ibmr.iova = 0;
+	ibmr->length = pi_mr->ibmr.length;
+	ibmr->iova = pi_mr->ibmr.iova;
+	ibmr->sig_attrs->meta_length = pi_mr->meta_length;
+
+	ib_dma_sync_single_for_device(ibmr->device, pi_mr->desc_map,
+				      pi_mr->desc_size * pi_mr->max_descs,
+				      DMA_TO_DEVICE);
+
+	if (unlikely(n != data_sg_nents + meta_sg_nents))
+		return -ENOMEM;
+
+	return 0;
+}
+
 int mlx5_ib_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		      unsigned int *sg_offset)
 {
@@ -1946,7 +2110,8 @@ int mlx5_ib_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 				   DMA_TO_DEVICE);
 
 	if (mr->access_mode == MLX5_MKC_ACCESS_MODE_KLMS)
-		n = mlx5_ib_sg_to_klms(mr, sg, sg_nents, sg_offset);
+		n = mlx5_ib_sg_to_klms(mr, sg, sg_nents, sg_offset, NULL, 0,
+				       NULL);
 	else
 		n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset,
 				mlx5_set_page);
-- 
2.16.3

