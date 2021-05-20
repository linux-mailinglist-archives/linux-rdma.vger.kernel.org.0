Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93938ABBE
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 13:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbhETL1a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 07:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241719AbhETLZY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 07:25:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 771A6613CC;
        Thu, 20 May 2021 10:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621505626;
        bh=k7ZQxn96Ut7dPs9xt1MIvhK0dxLO0bKpGQ96/Vo6da8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pqoBgG9EvxtZofs9Zy16qksYkVlxUK/nlikBOilbt4XvSxFjJ5tHnmE2DdWFCcOp2
         U0rSXPerreHfzCIkLJQG5zjGk5qD/jvU6EsZ8JdnSgGiH6f1beySg5E0J1ypzpwj80
         elJawLnTVksjKSgpgPv4b1rHTfB9KS9iiHLuWf9gYE620gUxlJaeerEXKhC1oNGa2u
         LLUPKJyz2kxmVzflT0JOvEm8/mTg0D701J/PZFmB7jW8RkkzTp5N2lXGdT8v5a0BwW
         ZOrt6fgQhRn+ZGrVDkJM8Got+LMgTltcU5+kz0HferAsFh5HavwuarhwPJm/5xIUx3
         eVQcazxzihz3A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 1/2] RDMA: Enable Relaxed Ordering by default for kernel ULPs
Date:   Thu, 20 May 2021 13:13:35 +0300
Message-Id: <73af770234656d5f884ead5b8d40132d9ed289d6.1621505111.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621505111.git.leonro@nvidia.com>
References: <cover.1621505111.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Add a new flag IB_ACCESS_DISABLE_RELAXED_ORDERING which replaces
IB_ACCESS_RELAXED_ORDERING and has inverse functionality, and invert all
logic related to it. Since a new flag is added to IB layer, uverbs flags
are now translated into IB flags.

This allows us to enable Relaxed Ordering by default for kernel ULPs
without modifying any ULP code. In addition, new ULPs will get Relaxed
Ordering automatically without the need to explicitly ask for it. Since
all kernel ULPs support Relaxed Ordering, this is a desired behavior.

On the other hand, not all user space apps support Relaxed Ordering, so
we keep it disabled by default for them. Thus, user space apps have to
explicitly enable Relaxed Ordering if they want it. This is the current
behavior for user space, and it is not changed in the scope of this
series.

Note that Relaxed ordering is an optional capability, and as such, it is
ignored by vendors that don't support it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem.c                |  2 +-
 drivers/infiniband/core/uverbs_cmd.c          | 64 +++++++++++++++--
 drivers/infiniband/core/uverbs_std_types_mr.c | 21 ++++--
 drivers/infiniband/hw/mlx5/devx.c             | 10 ++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          | 10 +--
 drivers/infiniband/hw/mlx5/mr.c               | 22 +++---
 drivers/infiniband/hw/mlx5/wr.c               |  8 +--
 include/rdma/ib_verbs.h                       | 68 ++++++++++++++++++-
 8 files changed, 170 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index c26537d2c241..3aa538bd8851 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -242,7 +242,7 @@ static struct ib_umem *__ib_umem_get(struct ib_device *device,
 		}
 	}
 
-	if (access & IB_ACCESS_RELAXED_ORDERING)
+	if (!(access & IB_ACCESS_DISABLE_RELAXED_ORDERING))
 		dma_attr |= DMA_ATTR_WEAK_ORDERING;
 
 	umem->nmap =
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index d5e15a8c870d..4f890bff80f8 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -701,6 +701,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	struct ib_mr                *mr;
 	int                          ret;
 	struct ib_device *ib_dev;
+	u32 access_flags;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
 	if (ret)
@@ -713,7 +714,11 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(uobj))
 		return PTR_ERR(uobj);
 
-	ret = ib_check_mr_access(ib_dev, cmd.access_flags);
+	ret = copy_mr_access_flags(&access_flags, cmd.access_flags);
+	if (ret)
+		goto err_free;
+
+	ret = ib_check_mr_access(ib_dev, access_flags);
 	if (ret)
 		goto err_free;
 
@@ -724,8 +729,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	}
 
 	mr = pd->device->ops.reg_user_mr(pd, cmd.start, cmd.length, cmd.hca_va,
-					 cmd.access_flags,
-					 &attrs->driver_udata);
+					 access_flags, &attrs->driver_udata);
 	if (IS_ERR(mr)) {
 		ret = PTR_ERR(mr);
 		goto err_put;
@@ -772,6 +776,7 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 	struct ib_pd *orig_pd;
 	struct ib_pd *new_pd;
 	struct ib_mr *new_mr;
+	u32 access_flags;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
 	if (ret)
@@ -799,7 +804,11 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 	}
 
 	if (cmd.flags & IB_MR_REREG_ACCESS) {
-		ret = ib_check_mr_access(mr->device, cmd.access_flags);
+		ret = copy_mr_access_flags(&access_flags, cmd.access_flags);
+		if (ret)
+			goto put_uobjs;
+
+		ret = ib_check_mr_access(mr->device, access_flags);
 		if (ret)
 			goto put_uobjs;
 	}
@@ -827,7 +836,7 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 	}
 
 	new_mr = ib_dev->ops.rereg_user_mr(mr, cmd.flags, cmd.start, cmd.length,
-					   cmd.hca_va, cmd.access_flags, new_pd,
+					   cmd.hca_va, access_flags, new_pd,
 					   &attrs->driver_udata);
 	if (IS_ERR(new_mr)) {
 		ret = PTR_ERR(new_mr);
@@ -1660,6 +1669,27 @@ static void copy_ah_attr_to_uverbs(struct ib_uverbs_qp_dest *uverb_attr,
 	uverb_attr->port_num          = rdma_ah_get_port_num(rdma_attr);
 }
 
+static void copy_qp_access_flags(unsigned int *dest_flags,
+				 unsigned int src_flags)
+{
+	*dest_flags = 0;
+
+	process_access_flag(dest_flags, IB_UVERBS_ACCESS_LOCAL_WRITE,
+			    &src_flags, IB_ACCESS_LOCAL_WRITE);
+
+	process_access_flag(dest_flags, IB_UVERBS_ACCESS_REMOTE_WRITE,
+			    &src_flags, IB_ACCESS_REMOTE_WRITE);
+
+	process_access_flag(dest_flags, IB_UVERBS_ACCESS_REMOTE_READ,
+			    &src_flags, IB_ACCESS_REMOTE_READ);
+
+	process_access_flag(dest_flags, IB_UVERBS_ACCESS_REMOTE_ATOMIC,
+			    &src_flags, IB_ACCESS_REMOTE_ATOMIC);
+
+	process_access_flag(dest_flags, IB_UVERBS_ACCESS_MW_BIND, &src_flags,
+			    IB_ACCESS_MW_BIND);
+}
+
 static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_query_qp      cmd;
@@ -1704,7 +1734,9 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 	resp.rq_psn                 = attr->rq_psn;
 	resp.sq_psn                 = attr->sq_psn;
 	resp.dest_qp_num            = attr->dest_qp_num;
-	resp.qp_access_flags        = attr->qp_access_flags;
+
+	copy_qp_access_flags(&resp.qp_access_flags, attr->qp_access_flags);
+
 	resp.pkey_index             = attr->pkey_index;
 	resp.alt_pkey_index         = attr->alt_pkey_index;
 	resp.sq_draining            = attr->sq_draining;
@@ -1774,6 +1806,17 @@ static void copy_ah_attr_from_uverbs(struct ib_device *dev,
 	rdma_ah_set_make_grd(rdma_attr, false);
 }
 
+static int check_qp_access_flags(unsigned int qp_access_flags)
+{
+	if (qp_access_flags &
+	    ~(IB_UVERBS_ACCESS_LOCAL_WRITE | IB_UVERBS_ACCESS_REMOTE_WRITE |
+	      IB_UVERBS_ACCESS_REMOTE_READ | IB_UVERBS_ACCESS_REMOTE_ATOMIC |
+	      IB_UVERBS_ACCESS_MW_BIND))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int modify_qp(struct uverbs_attr_bundle *attrs,
 		     struct ib_uverbs_ex_modify_qp *cmd)
 {
@@ -1868,6 +1911,12 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 		goto release_qp;
 	}
 
+	if (cmd->base.attr_mask & IB_QP_ACCESS_FLAGS &&
+	    check_qp_access_flags(cmd->base.qp_access_flags)) {
+		ret = -EINVAL;
+		goto release_qp;
+	}
+
 	if (cmd->base.attr_mask & IB_QP_STATE)
 		attr->qp_state = cmd->base.qp_state;
 	if (cmd->base.attr_mask & IB_QP_CUR_STATE)
@@ -1885,7 +1934,8 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 	if (cmd->base.attr_mask & IB_QP_DEST_QPN)
 		attr->dest_qp_num = cmd->base.dest_qp_num;
 	if (cmd->base.attr_mask & IB_QP_ACCESS_FLAGS)
-		attr->qp_access_flags = cmd->base.qp_access_flags;
+		copy_qp_access_flags(&attr->qp_access_flags,
+				     cmd->base.qp_access_flags);
 	if (cmd->base.attr_mask & IB_QP_PKEY_INDEX)
 		attr->pkey_index = cmd->base.pkey_index;
 	if (cmd->base.attr_mask & IB_QP_EN_SQD_ASYNC_NOTIFY)
diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index f782d5e1aa25..c9df57da7eed 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -109,7 +109,12 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 
 	ret = uverbs_get_flags32(&attr.access_flags, attrs,
 				 UVERBS_ATTR_REG_DM_MR_ACCESS_FLAGS,
-				 IB_ACCESS_SUPPORTED);
+				 ((IB_UVERBS_ACCESS_HUGETLB << 1) - 1) |
+					 IB_UVERBS_ACCESS_OPTIONAL_RANGE);
+	if (ret)
+		return ret;
+
+	ret = copy_mr_access_flags(&attr.access_flags, attr.access_flags);
 	if (ret)
 		return ret;
 
@@ -225,11 +230,15 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_DMABUF_MR)(
 
 	ret = uverbs_get_flags32(&access_flags, attrs,
 				 UVERBS_ATTR_REG_DMABUF_MR_ACCESS_FLAGS,
-				 IB_ACCESS_LOCAL_WRITE |
-				 IB_ACCESS_REMOTE_READ |
-				 IB_ACCESS_REMOTE_WRITE |
-				 IB_ACCESS_REMOTE_ATOMIC |
-				 IB_ACCESS_RELAXED_ORDERING);
+				 IB_UVERBS_ACCESS_LOCAL_WRITE |
+				 IB_UVERBS_ACCESS_REMOTE_READ |
+				 IB_UVERBS_ACCESS_REMOTE_WRITE |
+				 IB_UVERBS_ACCESS_REMOTE_ATOMIC |
+				 IB_UVERBS_ACCESS_RELAXED_ORDERING);
+	if (ret)
+		return ret;
+
+	ret = copy_mr_access_flags(&access_flags, access_flags);
 	if (ret)
 		return ret;
 
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 3678b0a8710b..72a0828388de 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2169,9 +2169,13 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
 
 	err = uverbs_get_flags32(&access, attrs,
 				 MLX5_IB_ATTR_DEVX_UMEM_REG_ACCESS,
-				 IB_ACCESS_LOCAL_WRITE |
-				 IB_ACCESS_REMOTE_WRITE |
-				 IB_ACCESS_REMOTE_READ);
+				 IB_UVERBS_ACCESS_LOCAL_WRITE |
+				 IB_UVERBS_ACCESS_REMOTE_WRITE |
+				 IB_UVERBS_ACCESS_REMOTE_READ);
+	if (err)
+		return err;
+
+	err = copy_mr_access_flags(&access, access);
 	if (err)
 		return err;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e9a3f34a30b8..bbfed67e6fc9 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -625,12 +625,14 @@ struct mlx5_user_mmap_entry {
 					 IB_ACCESS_REMOTE_WRITE  |\
 					 IB_ACCESS_REMOTE_READ   |\
 					 IB_ACCESS_REMOTE_ATOMIC |\
-					 IB_ZERO_BASED)
+					 IB_ZERO_BASED		 |\
+					 IB_ACCESS_DISABLE_RELAXED_ORDERING)
 
 #define MLX5_IB_DM_SW_ICM_ALLOWED_ACCESS (IB_ACCESS_LOCAL_WRITE   |\
 					  IB_ACCESS_REMOTE_WRITE  |\
 					  IB_ACCESS_REMOTE_READ   |\
-					  IB_ZERO_BASED)
+					  IB_ZERO_BASED		  |\
+					  IB_ACCESS_DISABLE_RELAXED_ORDERING)
 
 #define mlx5_update_odp_stats(mr, counter_name, value)		\
 	atomic64_add(value, &((mr)->odp_stats.counter_name))
@@ -1570,12 +1572,12 @@ static inline bool mlx5_ib_can_reconfig_with_umr(struct mlx5_ib_dev *dev,
 	    MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled))
 		return false;
 
-	if ((diffs & IB_ACCESS_RELAXED_ORDERING) &&
+	if ((diffs & IB_ACCESS_DISABLE_RELAXED_ORDERING) &&
 	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write) &&
 	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
 		return false;
 
-	if ((diffs & IB_ACCESS_RELAXED_ORDERING) &&
+	if ((diffs & IB_ACCESS_DISABLE_RELAXED_ORDERING) &&
 	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read) &&
 	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
 		return false;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 44e14d273b45..d2dd0fb870f6 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -76,12 +76,12 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
 	MLX5_SET(mkc, mkc, lw, !!(acc & IB_ACCESS_LOCAL_WRITE));
 	MLX5_SET(mkc, mkc, lr, 1);
 
-	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
+	if (!(acc & IB_ACCESS_DISABLE_RELAXED_ORDERING)) {
 		MLX5_SET(mkc, mkc, relaxed_ordering_write,
-			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
-	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
+			 MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write));
 		MLX5_SET(mkc, mkc, relaxed_ordering_read,
-			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
+			 MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read));
+	}
 
 	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
 	MLX5_SET(mkc, mkc, qpn, 0xffffff);
@@ -181,7 +181,8 @@ static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
 		return NULL;
 	mr->cache_ent = ent;
 
-	set_mkc_access_pd_addr_fields(mkc, 0, 0, ent->dev->umrc.pd);
+	set_mkc_access_pd_addr_fields(mkc, IB_ACCESS_DISABLE_RELAXED_ORDERING,
+				      0, ent->dev->umrc.pd);
 	MLX5_SET(mkc, mkc, free, 1);
 	MLX5_SET(mkc, mkc, umr_en, 1);
 	MLX5_SET(mkc, mkc, access_mode_1_0, ent->access_mode & 0x3);
@@ -574,7 +575,8 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 		return ERR_PTR(-EINVAL);
 
 	/* Matches access in alloc_cache_mr() */
-	if (!mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags))
+	if (!mlx5_ib_can_reconfig_with_umr(
+		    dev, IB_ACCESS_DISABLE_RELAXED_ORDERING, access_flags))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	ent = &cache->ent[entry];
@@ -953,7 +955,8 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	 * cache then synchronously create an uncached one.
 	 */
 	if (!ent || ent->limit == 0 ||
-	    !mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags)) {
+	    !mlx5_ib_can_reconfig_with_umr(
+		    dev, IB_ACCESS_DISABLE_RELAXED_ORDERING, access_flags)) {
 		mutex_lock(&dev->slow_path_mutex);
 		mr = reg_create(pd, umem, iova, access_flags, page_size, false);
 		mutex_unlock(&dev->slow_path_mutex);
@@ -1685,8 +1688,9 @@ static bool can_use_umr_rereg_access(struct mlx5_ib_dev *dev,
 {
 	unsigned int diffs = current_access_flags ^ target_access_flags;
 
-	if (diffs & ~(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE |
-		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING))
+	if (diffs &
+	    ~(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE |
+	      IB_ACCESS_REMOTE_READ | IB_ACCESS_DISABLE_RELAXED_ORDERING))
 		return false;
 	return mlx5_ib_can_reconfig_with_umr(dev, current_access_flags,
 					     target_access_flags);
diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index cf2852cba45c..54caa6a54451 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -415,12 +415,12 @@ static void set_reg_mkey_segment(struct mlx5_ib_dev *dev,
 	MLX5_SET(mkc, seg, rr, !!(umrwr->access_flags & IB_ACCESS_REMOTE_READ));
 	MLX5_SET(mkc, seg, lw, !!(umrwr->access_flags & IB_ACCESS_LOCAL_WRITE));
 	MLX5_SET(mkc, seg, lr, 1);
-	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
+	if (!(umrwr->access_flags & IB_ACCESS_DISABLE_RELAXED_ORDERING)) {
 		MLX5_SET(mkc, seg, relaxed_ordering_write,
-			 !!(umrwr->access_flags & IB_ACCESS_RELAXED_ORDERING));
-	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
+			 MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr));
 		MLX5_SET(mkc, seg, relaxed_ordering_read,
-			 !!(umrwr->access_flags & IB_ACCESS_RELAXED_ORDERING));
+			 MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr));
+	}
 
 	if (umrwr->pd)
 		MLX5_SET(mkc, seg, pd, to_mpd(umrwr->pd)->pdn);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 05dbc216eb64..b7bda44e9189 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1440,7 +1440,7 @@ enum ib_access_flags {
 	IB_ZERO_BASED = IB_UVERBS_ACCESS_ZERO_BASED,
 	IB_ACCESS_ON_DEMAND = IB_UVERBS_ACCESS_ON_DEMAND,
 	IB_ACCESS_HUGETLB = IB_UVERBS_ACCESS_HUGETLB,
-	IB_ACCESS_RELAXED_ORDERING = IB_UVERBS_ACCESS_RELAXED_ORDERING,
+	IB_ACCESS_DISABLE_RELAXED_ORDERING = IB_UVERBS_ACCESS_OPTIONAL_FIRST,
 
 	IB_ACCESS_OPTIONAL = IB_UVERBS_ACCESS_OPTIONAL_RANGE,
 	IB_ACCESS_SUPPORTED =
@@ -4679,4 +4679,70 @@ static inline u32 rdma_calc_flow_label(u32 lqpn, u32 rqpn)
 
 const struct ib_port_immutable*
 ib_port_immutable_read(struct ib_device *dev, unsigned int port);
+
+static inline void process_access_flag(unsigned int *dest_flags,
+				       unsigned int out_flag,
+				       unsigned int *src_flags,
+				       unsigned int in_flag)
+{
+	if (!(*src_flags & in_flag))
+		return;
+
+	*dest_flags |= out_flag;
+	*src_flags &= ~in_flag;
+}
+
+static inline void process_access_flag_inv(unsigned int *dest_flags,
+					   unsigned int out_flag,
+					   unsigned int *src_flags,
+					   unsigned int in_flag)
+{
+	if (*src_flags & in_flag) {
+		*dest_flags &= ~out_flag;
+		*src_flags &= ~in_flag;
+		return;
+	}
+
+	*dest_flags |= out_flag;
+}
+
+static inline int copy_mr_access_flags(unsigned int *dest_flags,
+				       unsigned int src_flags)
+{
+	*dest_flags = 0;
+
+	process_access_flag(dest_flags, IB_ACCESS_LOCAL_WRITE, &src_flags,
+			    IB_UVERBS_ACCESS_LOCAL_WRITE);
+
+	process_access_flag(dest_flags, IB_ACCESS_REMOTE_WRITE, &src_flags,
+			    IB_UVERBS_ACCESS_REMOTE_WRITE);
+
+	process_access_flag(dest_flags, IB_ACCESS_REMOTE_READ, &src_flags,
+			    IB_UVERBS_ACCESS_REMOTE_READ);
+
+	process_access_flag(dest_flags, IB_ACCESS_REMOTE_ATOMIC, &src_flags,
+			    IB_UVERBS_ACCESS_REMOTE_ATOMIC);
+
+	process_access_flag(dest_flags, IB_ACCESS_MW_BIND, &src_flags,
+			    IB_UVERBS_ACCESS_MW_BIND);
+
+	process_access_flag(dest_flags, IB_ZERO_BASED, &src_flags,
+			    IB_UVERBS_ACCESS_ZERO_BASED);
+
+	process_access_flag(dest_flags, IB_ACCESS_ON_DEMAND, &src_flags,
+			    IB_UVERBS_ACCESS_ON_DEMAND);
+
+	process_access_flag(dest_flags, IB_ACCESS_HUGETLB, &src_flags,
+			    IB_UVERBS_ACCESS_HUGETLB);
+
+	process_access_flag_inv(dest_flags, IB_ACCESS_DISABLE_RELAXED_ORDERING,
+				&src_flags, IB_UVERBS_ACCESS_RELAXED_ORDERING);
+
+	/**
+	 * Don't fail on optional flags as they are not mandatory.
+	 */
+	src_flags &= ~IB_UVERBS_ACCESS_OPTIONAL_RANGE;
+
+	return (src_flags) ? -EINVAL : 0;
+}
 #endif /* IB_VERBS_H */
-- 
2.31.1

