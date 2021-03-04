Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FA332D29C
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 13:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhCDMIw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 07:08:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233981AbhCDMIi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 07:08:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E95664F2B;
        Thu,  4 Mar 2021 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614859678;
        bh=M5o+8xbjC7EVTQ2Ye4VwpeLXrHWhsGBE+Hj9QLhHnvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8BFDDD8vHJAvrO23nMwRV4UQBrZSR5CtuwGlMgvYJDS0F64Q9RzsRjuAvh5zViV5
         gNHvqooaiYuFB/GTvj3xQDQp42vlvz47xlD2jCyYhAe8Edl+zZdd/aUFvz2f7mQnA4
         rViWX2x4lIIrqXD0JbqLZvfemSRF6fQvWsQoZctUvVjGDWPuRJWKb+69tjCnrIYqXq
         3SiWBTSgIdCBMYcmf0tnSelgOe0rIdJta+mKR6P4X94Tfwv3NYeI0mPRvWWWg1KSxt
         CNN5Wp0DDPsIAAA0+0QdV96G4UCBL/df2V2Brwzntz5wNR9tpVrPQV8wJ5bJoCZ4vD
         37gijx1iSGsFw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/4] RDMA/mlx5: Zero out ODP related items in the mlx5_ib_mr
Date:   Thu,  4 Mar 2021 14:07:42 +0200
Message-Id: <20210304120745.1090751-2-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304120745.1090751-1-leon@kernel.org>
References: <20210304120745.1090751-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

All of the ODP code assumes when it calls mlx5_mr_cache_alloc() the ODP
related fields are zero'd. This is true if the MR was just allocated, but
if the MR is recycled through the cache then the values are never zero'd.

This causes a bug in the odp_stats, they don't reset when the MR is
reallocated, also is_odp_implicit is never 0'd.

So we can use memset on a block of the mlx5_ib_mr reorganize the structure
to put all the data that can be zero'd by the cache at the end.

It is organized as an anonymous struct because the next patch will make
this a union.

Delete the unused smr_info. Don't set the kernel only desc_size on the
user path. No longer any need to zero mr->parent before freeing it, the
memset() will get it now.

Fixes: a3de94e3d61e ("IB/mlx5: Introduce ODP diagnostic counters")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 103 ++++++++++++++++-----------
 drivers/infiniband/hw/mlx5/mr.c      |  14 ++--
 drivers/infiniband/hw/mlx5/odp.c     |   1 -
 3 files changed, 66 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index a2cee68a8390..5bfd14c438c1 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -547,11 +547,6 @@ static inline const struct mlx5_umr_wr *umr_wr(const struct ib_send_wr *wr)
 	return container_of(wr, struct mlx5_umr_wr, wr);
 }

-struct mlx5_shared_mr_info {
-	int mr_id;
-	struct ib_umem		*umem;
-};
-
 enum mlx5_ib_cq_pr_flags {
 	MLX5_IB_CQ_PR_FLAGS_CQE_128_PAD	= 1 << 0,
 };
@@ -654,47 +649,69 @@ struct mlx5_ib_dm {
 	atomic64_add(value, &((mr)->odp_stats.counter_name))

 struct mlx5_ib_mr {
-	struct ib_mr		ibmr;
-	void			*descs;
-	dma_addr_t		desc_map;
-	int			ndescs;
-	int			data_length;
-	int			meta_ndescs;
-	int			meta_length;
-	int			max_descs;
-	int			desc_size;
-	int			access_mode;
-	unsigned int		page_shift;
-	struct mlx5_core_mkey	mmkey;
-	struct ib_umem	       *umem;
-	struct mlx5_shared_mr_info	*smr_info;
-	struct list_head	list;
-	struct mlx5_cache_ent  *cache_ent;
-	u32 out[MLX5_ST_SZ_DW(create_mkey_out)];
-	struct mlx5_core_sig_ctx    *sig;
-	void			*descs_alloc;
-	int			access_flags; /* Needed for rereg MR */
-
-	struct mlx5_ib_mr      *parent;
-	/* Needed for IB_MR_TYPE_INTEGRITY */
-	struct mlx5_ib_mr      *pi_mr;
-	struct mlx5_ib_mr      *klm_mr;
-	struct mlx5_ib_mr      *mtt_mr;
-	u64			data_iova;
-	u64			pi_iova;
-
-	/* For ODP and implicit */
-	struct xarray		implicit_children;
-	union {
-		struct list_head elm;
-		struct work_struct work;
-	} odp_destroy;
-	struct ib_odp_counters	odp_stats;
-	bool			is_odp_implicit;
+	struct ib_mr ibmr;
+	struct mlx5_core_mkey mmkey;

-	struct mlx5_async_work  cb_work;
+	/* User MR data */
+	struct mlx5_cache_ent *cache_ent;
+	struct ib_umem *umem;
+
+	/* This is zero'd when the MR is allocated */
+	struct {
+		/* Used only while the MR is in the cache */
+		struct {
+			u32 out[MLX5_ST_SZ_DW(create_mkey_out)];
+			struct mlx5_async_work cb_work;
+			/* Cache list element */
+			struct list_head list;
+		};
+
+		/* Used only by kernel MRs (umem == NULL) */
+		struct {
+			void *descs;
+			void *descs_alloc;
+			dma_addr_t desc_map;
+			int max_descs;
+			int ndescs;
+			int desc_size;
+			int access_mode;
+
+			/* For Kernel IB_MR_TYPE_INTEGRITY */
+			struct mlx5_core_sig_ctx *sig;
+			struct mlx5_ib_mr *pi_mr;
+			struct mlx5_ib_mr *klm_mr;
+			struct mlx5_ib_mr *mtt_mr;
+			u64 data_iova;
+			u64 pi_iova;
+			int meta_ndescs;
+			int meta_length;
+			int data_length;
+		};
+
+		/* Used only by User MRs (umem != NULL) */
+		struct {
+			unsigned int page_shift;
+			/* Current access_flags */
+			int access_flags;
+
+			/* For User ODP */
+			struct mlx5_ib_mr *parent;
+			struct xarray implicit_children;
+			union {
+				struct work_struct work;
+			} odp_destroy;
+			struct ib_odp_counters odp_stats;
+			bool is_odp_implicit;
+		};
+	};
 };

+/* Zero the fields in the mr that are variant depending on usage */
+static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
+{
+	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
+}
+
 static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
 {
 	return IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) && mr->umem &&
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index db05b0e0a8d7..ea8f068a6da3 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -590,6 +590,8 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 		ent->available_mrs--;
 		queue_adjust_cache_locked(ent);
 		spin_unlock_irq(&ent->lock);
+
+		mlx5_clear_mr(mr);
 	}
 	mr->access_flags = access_flags;
 	return mr;
@@ -615,16 +617,14 @@ static struct mlx5_ib_mr *get_cache_mr(struct mlx5_cache_ent *req_ent)
 			ent->available_mrs--;
 			queue_adjust_cache_locked(ent);
 			spin_unlock_irq(&ent->lock);
-			break;
+			mlx5_clear_mr(mr);
+			return mr;
 		}
 		queue_adjust_cache_locked(ent);
 		spin_unlock_irq(&ent->lock);
 	}
-
-	if (!mr)
-		req_ent->miss++;
-
-	return mr;
+	req_ent->miss++;
+	return NULL;
 }

 static void detach_mr_from_cache(struct mlx5_ib_mr *mr)
@@ -993,8 +993,6 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,

 	mr->ibmr.pd = pd;
 	mr->umem = umem;
-	mr->access_flags = access_flags;
-	mr->desc_size = sizeof(struct mlx5_mtt);
 	mr->mmkey.iova = iova;
 	mr->mmkey.size = umem->length;
 	mr->mmkey.pd = to_mpd(pd)->pdn;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index b103555b1f5d..d98755e78362 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -227,7 +227,6 @@ static void free_implicit_child_mr(struct mlx5_ib_mr *mr, bool need_imr_xlt)

 	dma_fence_odp_mr(mr);

-	mr->parent = NULL;
 	mlx5_mr_cache_free(mr_to_mdev(mr), mr);
 	ib_umem_odp_release(odp);
 }
--
2.29.2

