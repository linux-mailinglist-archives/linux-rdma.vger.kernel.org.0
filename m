Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7F2FC4C
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfE3NZz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:25:55 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:35161 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726673AbfE3NZz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 09:25:55 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 May 2019 16:25:34 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4UDPVZm007883;
        Thu, 30 May 2019 16:25:34 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 20/20] RDMA/mlx5: Refactor MR descriptors allocation
Date:   Thu, 30 May 2019 16:25:31 +0300
Message-Id: <1559222731-16715-21-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Improve code readability using static helpers for each memory region
type. Re-use the common logic to get smaller functions that are easy
to maintain and reduce code duplication.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 290 ++++++++++++++++++++++------------------
 1 file changed, 157 insertions(+), 133 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 9025b477d065..c6d8c2eed508 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1651,15 +1651,63 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	return 0;
 }
 
+static void mlx5_set_umr_free_mkey(struct ib_pd *pd, u32 *in, int ndescs,
+				   int access_mode, int page_shift)
+{
+	void *mkc;
+
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+
+	MLX5_SET(mkc, mkc, free, 1);
+	MLX5_SET(mkc, mkc, qpn, 0xffffff);
+	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
+	MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
+	MLX5_SET(mkc, mkc, access_mode_1_0, access_mode & 0x3);
+	MLX5_SET(mkc, mkc, access_mode_4_2, (access_mode >> 2) & 0x7);
+	MLX5_SET(mkc, mkc, umr_en, 1);
+	MLX5_SET(mkc, mkc, log_page_size, page_shift);
+}
+
+static int _mlx5_alloc_mkey_descs(struct ib_pd *pd, struct mlx5_ib_mr *mr,
+				  int ndescs, int desc_size, int page_shift,
+				  int access_mode, u32 *in, int inlen)
+{
+	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	int err;
+
+	mr->access_mode = access_mode;
+	mr->desc_size = desc_size;
+	mr->max_descs = ndescs;
+
+	err = mlx5_alloc_priv_descs(pd->device, mr, ndescs, desc_size);
+	if (err)
+		return err;
+
+	mlx5_set_umr_free_mkey(pd, in, ndescs, access_mode, page_shift);
+
+	err = mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
+	if (err)
+		goto err_free_descs;
+
+	mr->mmkey.type = MLX5_MKEY_MR;
+	mr->ibmr.lkey = mr->mmkey.key;
+	mr->ibmr.rkey = mr->mmkey.key;
+
+	return 0;
+
+err_free_descs:
+	mlx5_free_priv_descs(mr);
+	return err;
+}
+
 static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
 				u32 max_num_sg, u32 max_num_meta_sg,
 				int desc_size, int access_mode)
 {
-	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
 	int ndescs = ALIGN(max_num_sg + max_num_meta_sg, 4);
+	int page_shift = 0;
 	struct mlx5_ib_mr *mr;
-	void *mkc;
 	u32 *in;
 	int err;
 
@@ -1667,48 +1715,28 @@ static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
+	mr->ibmr.pd = pd;
+	mr->ibmr.device = pd->device;
+
 	in = kzalloc(inlen, GFP_KERNEL);
 	if (!in) {
 		err = -ENOMEM;
 		goto err_free;
 	}
 
-	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
-	MLX5_SET(mkc, mkc, free, 1);
-	MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
 	if (access_mode == MLX5_MKC_ACCESS_MODE_MTT)
-		MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
-	MLX5_SET(mkc, mkc, qpn, 0xffffff);
-	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
+		page_shift = PAGE_SHIFT;
 
-	mr->access_mode = access_mode;
-
-	err = mlx5_alloc_priv_descs(pd->device, mr, ndescs, desc_size);
+	err = _mlx5_alloc_mkey_descs(pd, mr, ndescs, desc_size, page_shift,
+				     access_mode, in, inlen);
 	if (err)
 		goto err_free_in;
-	mr->desc_size = desc_size;
-	mr->max_descs = ndescs;
-
-	MLX5_SET(mkc, mkc, access_mode_1_0, mr->access_mode & 0x3);
-	MLX5_SET(mkc, mkc, access_mode_4_2, (mr->access_mode >> 2) & 0x7);
-	MLX5_SET(mkc, mkc, umr_en, 1);
 
-	mr->ibmr.pd = pd;
-	mr->ibmr.device = pd->device;
-	err = mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
-	if (err)
-		goto err_priv_descs;
-
-	mr->mmkey.type = MLX5_MKEY_MR;
-	mr->ibmr.lkey = mr->mmkey.key;
-	mr->ibmr.rkey = mr->mmkey.key;
 	mr->umem = NULL;
 	kfree(in);
 
 	return mr;
 
-err_priv_descs:
-	mlx5_free_priv_descs(mr);
 err_free_in:
 	kfree(in);
 err_free:
@@ -1716,6 +1744,92 @@ static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
 	return ERR_PTR(err);
 }
 
+static int mlx5_alloc_mem_reg_descs(struct ib_pd *pd, struct mlx5_ib_mr *mr,
+				    int ndescs, u32 *in, int inlen)
+{
+	return _mlx5_alloc_mkey_descs(pd, mr, ndescs, sizeof(struct mlx5_mtt),
+				      PAGE_SHIFT, MLX5_MKC_ACCESS_MODE_MTT, in,
+				      inlen);
+}
+
+static int mlx5_alloc_sg_gaps_descs(struct ib_pd *pd, struct mlx5_ib_mr *mr,
+				    int ndescs, u32 *in, int inlen)
+{
+	return _mlx5_alloc_mkey_descs(pd, mr, ndescs, sizeof(struct mlx5_klm),
+				      0, MLX5_MKC_ACCESS_MODE_KLMS, in, inlen);
+}
+
+static int mlx5_alloc_integrity_descs(struct ib_pd *pd, struct mlx5_ib_mr *mr,
+				      int max_num_sg, int max_num_meta_sg,
+				      u32 *in, int inlen)
+{
+	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	u32 psv_index[2];
+	void *mkc;
+	int err;
+
+	mr->sig = kzalloc(sizeof(*mr->sig), GFP_KERNEL);
+	if (!mr->sig)
+		return -ENOMEM;
+
+	/* create mem & wire PSVs */
+	err = mlx5_core_create_psv(dev->mdev, to_mpd(pd)->pdn, 2, psv_index);
+	if (err)
+		goto err_free_sig;
+
+	mr->sig->psv_memory.psv_idx = psv_index[0];
+	mr->sig->psv_wire.psv_idx = psv_index[1];
+
+	mr->sig->sig_status_checked = true;
+	mr->sig->sig_err_exists = false;
+	/* Next UMR, Arm SIGERR */
+	++mr->sig->sigerr_count;
+	mr->klm_mr = mlx5_ib_alloc_pi_mr(pd, max_num_sg, max_num_meta_sg,
+					 sizeof(struct mlx5_klm),
+					 MLX5_MKC_ACCESS_MODE_KLMS);
+	if (IS_ERR(mr->klm_mr)) {
+		err = PTR_ERR(mr->klm_mr);
+		goto err_destroy_psv;
+	}
+	mr->mtt_mr = mlx5_ib_alloc_pi_mr(pd, max_num_sg, max_num_meta_sg,
+					 sizeof(struct mlx5_mtt),
+					 MLX5_MKC_ACCESS_MODE_MTT);
+	if (IS_ERR(mr->mtt_mr)) {
+		err = PTR_ERR(mr->mtt_mr);
+		goto err_free_klm_mr;
+	}
+
+	/* Set bsf descriptors for mkey */
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	MLX5_SET(mkc, mkc, bsf_en, 1);
+	MLX5_SET(mkc, mkc, bsf_octword_size, MLX5_MKEY_BSF_OCTO_SIZE);
+
+	err = _mlx5_alloc_mkey_descs(pd, mr, 4, sizeof(struct mlx5_klm), 0,
+				     MLX5_MKC_ACCESS_MODE_KLMS, in, inlen);
+	if (err)
+		goto err_free_mtt_mr;
+
+	return 0;
+
+err_free_mtt_mr:
+	dereg_mr(to_mdev(mr->mtt_mr->ibmr.device), mr->mtt_mr);
+	mr->mtt_mr = NULL;
+err_free_klm_mr:
+	dereg_mr(to_mdev(mr->klm_mr->ibmr.device), mr->klm_mr);
+	mr->klm_mr = NULL;
+err_destroy_psv:
+	if (mlx5_core_destroy_psv(dev->mdev, mr->sig->psv_memory.psv_idx))
+		mlx5_ib_warn(dev, "failed to destroy mem psv %d\n",
+			     mr->sig->psv_memory.psv_idx);
+	if (mlx5_core_destroy_psv(dev->mdev, mr->sig->psv_wire.psv_idx))
+		mlx5_ib_warn(dev, "failed to destroy wire psv %d\n",
+			     mr->sig->psv_wire.psv_idx);
+err_free_sig:
+	kfree(mr->sig);
+
+	return err;
+}
+
 static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
 					enum ib_mr_type mr_type, u32 max_num_sg,
 					u32 max_num_meta_sg)
@@ -1724,7 +1838,6 @@ static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
 	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
 	int ndescs = ALIGN(max_num_sg, 4);
 	struct mlx5_ib_mr *mr;
-	void *mkc;
 	u32 *in;
 	int err;
 
@@ -1738,121 +1851,32 @@ static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
 		goto err_free;
 	}
 
-	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
-	MLX5_SET(mkc, mkc, free, 1);
-	MLX5_SET(mkc, mkc, qpn, 0xffffff);
-	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
-
-	if (mr_type == IB_MR_TYPE_MEM_REG) {
-		mr->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
-		MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
-		MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
-		err = mlx5_alloc_priv_descs(pd->device, mr,
-					    ndescs, sizeof(struct mlx5_mtt));
-		if (err)
-			goto err_free_in;
-
-		mr->desc_size = sizeof(struct mlx5_mtt);
-		mr->max_descs = ndescs;
-	} else if (mr_type == IB_MR_TYPE_SG_GAPS) {
-		mr->access_mode = MLX5_MKC_ACCESS_MODE_KLMS;
-		MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
-
-		err = mlx5_alloc_priv_descs(pd->device, mr,
-					    ndescs, sizeof(struct mlx5_klm));
-		if (err)
-			goto err_free_in;
-		mr->desc_size = sizeof(struct mlx5_klm);
-		mr->max_descs = ndescs;
-	} else if (mr_type == IB_MR_TYPE_INTEGRITY) {
-		u32 psv_index[2];
-
-		MLX5_SET(mkc, mkc, bsf_en, 1);
-		MLX5_SET(mkc, mkc, bsf_octword_size, MLX5_MKEY_BSF_OCTO_SIZE);
-		MLX5_SET(mkc, mkc, translations_octword_size, 4);
-		mr->sig = kzalloc(sizeof(*mr->sig), GFP_KERNEL);
-		if (!mr->sig) {
-			err = -ENOMEM;
-			goto err_free_in;
-		}
+	mr->ibmr.device = pd->device;
+	mr->umem = NULL;
 
-		/* create mem & wire PSVs */
-		err = mlx5_core_create_psv(dev->mdev, to_mpd(pd)->pdn,
-					   2, psv_index);
-		if (err)
-			goto err_free_sig;
-
-		mr->access_mode = MLX5_MKC_ACCESS_MODE_KLMS;
-		mr->sig->psv_memory.psv_idx = psv_index[0];
-		mr->sig->psv_wire.psv_idx = psv_index[1];
-
-		mr->sig->sig_status_checked = true;
-		mr->sig->sig_err_exists = false;
-		/* Next UMR, Arm SIGERR */
-		++mr->sig->sigerr_count;
-		mr->klm_mr = mlx5_ib_alloc_pi_mr(pd, max_num_sg,
-						max_num_meta_sg,
-						sizeof(struct mlx5_klm),
-						MLX5_MKC_ACCESS_MODE_KLMS);
-		if (IS_ERR(mr->klm_mr)) {
-			err = PTR_ERR(mr->klm_mr);
-			goto err_destroy_psv;
-		}
-		mr->mtt_mr = mlx5_ib_alloc_pi_mr(pd, max_num_sg,
-						max_num_meta_sg,
-						sizeof(struct mlx5_mtt),
-						MLX5_MKC_ACCESS_MODE_MTT);
-		if (IS_ERR(mr->mtt_mr)) {
-			err = PTR_ERR(mr->mtt_mr);
-			goto err_free_klm_mr;
-		}
-	} else {
+	switch (mr_type) {
+	case IB_MR_TYPE_MEM_REG:
+		err = mlx5_alloc_mem_reg_descs(pd, mr, ndescs, in, inlen);
+		break;
+	case IB_MR_TYPE_SG_GAPS:
+		err = mlx5_alloc_sg_gaps_descs(pd, mr, ndescs, in, inlen);
+		break;
+	case IB_MR_TYPE_INTEGRITY:
+		err = mlx5_alloc_integrity_descs(pd, mr, max_num_sg,
+						 max_num_meta_sg, in, inlen);
+		break;
+	default:
 		mlx5_ib_warn(dev, "Invalid mr type %d\n", mr_type);
 		err = -EINVAL;
-		goto err_free_in;
 	}
 
-	MLX5_SET(mkc, mkc, access_mode_1_0, mr->access_mode & 0x3);
-	MLX5_SET(mkc, mkc, access_mode_4_2, (mr->access_mode >> 2) & 0x7);
-	MLX5_SET(mkc, mkc, umr_en, 1);
-
-	mr->ibmr.device = pd->device;
-	err = mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
 	if (err)
-		goto err_free_pi_mr;
+		goto err_free_in;
 
-	mr->mmkey.type = MLX5_MKEY_MR;
-	mr->ibmr.lkey = mr->mmkey.key;
-	mr->ibmr.rkey = mr->mmkey.key;
-	mr->umem = NULL;
 	kfree(in);
 
 	return &mr->ibmr;
 
-err_free_pi_mr:
-	if (mr->mtt_mr) {
-		dereg_mr(to_mdev(mr->mtt_mr->ibmr.device), mr->mtt_mr);
-		mr->mtt_mr = NULL;
-	}
-err_free_klm_mr:
-	if (mr->klm_mr) {
-		dereg_mr(to_mdev(mr->klm_mr->ibmr.device), mr->klm_mr);
-		mr->klm_mr = NULL;
-	}
-err_destroy_psv:
-	if (mr->sig) {
-		if (mlx5_core_destroy_psv(dev->mdev,
-					  mr->sig->psv_memory.psv_idx))
-			mlx5_ib_warn(dev, "failed to destroy mem psv %d\n",
-				     mr->sig->psv_memory.psv_idx);
-		if (mlx5_core_destroy_psv(dev->mdev,
-					  mr->sig->psv_wire.psv_idx))
-			mlx5_ib_warn(dev, "failed to destroy wire psv %d\n",
-				     mr->sig->psv_wire.psv_idx);
-	}
-	mlx5_free_priv_descs(mr);
-err_free_sig:
-	kfree(mr->sig);
 err_free_in:
 	kfree(in);
 err_free:
-- 
2.16.3

