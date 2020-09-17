Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E77826DA07
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 13:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgIQLWQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 07:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbgIQLWL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 07:22:11 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB8B21D7F;
        Thu, 17 Sep 2020 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600341728;
        bh=KE0bGv2UrzNkmo83UWfkusvIinBbauoDx1YdasPozxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trjtcAYZyAoQy62Bwzg54D6PduvC26sb49jkDy+55kLKFgA2+UMhIYNMCOCk6Y1vR
         sf0F+V/tCcwjUptytlnt/gkF72EM7BOEu6nwlQP7vW659yIRADfTJ2obITBCA0VYpu
         GgczjCzTYWgD8/WVrXmn5WT37pCkmYRGMZ+wuH/g=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH rdma-next v1 3/4] RDMA/mlx5: Extend advice MR to support non faulting mode
Date:   Thu, 17 Sep 2020 14:21:51 +0300
Message-Id: <20200917112152.1075974-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917112152.1075974-1-leon@kernel.org>
References: <20200917112152.1075974-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@nvidia.com>

Extend advice MR to support non faulting mode, this improves performance
by eliminating page faults and bring only the existing CPU pages.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c         | 3 ++-
 drivers/infiniband/hw/mlx5/odp.c        | 7 ++++++-
 include/uapi/rdma/ib_user_ioctl_verbs.h | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6b0d6109afc6..dea65e511a3e 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1321,7 +1321,8 @@ int mlx5_ib_advise_mr(struct ib_pd *pd,
 		      struct uverbs_attr_bundle *attrs)
 {
 	if (advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH &&
-	    advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE)
+	    advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
+	    advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
 		return -EOPNOTSUPP;

 	return mlx5_ib_advise_mr_prefetch(pd, advice, flags,
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 5bd5e19d76a2..28b7227d31bf 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -665,6 +665,7 @@ void mlx5_ib_fence_odp_mr(struct mlx5_ib_mr *mr)
 }

 #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
+#define MLX5_PF_FLAGS_SNAPSHOT BIT(2)
 static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 			     u64 user_va, size_t bcnt, u32 *bytes_mapped,
 			     u32 flags)
@@ -673,6 +674,7 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	bool downgrade = flags & MLX5_PF_FLAGS_DOWNGRADE;
 	u64 access_mask;
 	u64 start_idx;
+	bool fault = !(flags & MLX5_PF_FLAGS_SNAPSHOT);

 	page_shift = odp->page_shift;
 	start_idx = (user_va - ib_umem_start(odp)) >> page_shift;
@@ -681,7 +683,7 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	if (odp->umem.writable && !downgrade)
 		access_mask |= ODP_WRITE_ALLOWED_BIT;

-	np = ib_umem_odp_map_dma_and_lock(odp, user_va, bcnt, access_mask, true);
+	np = ib_umem_odp_map_dma_and_lock(odp, user_va, bcnt, access_mask, fault);
 	if (np < 0)
 		return np;

@@ -1851,6 +1853,9 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
 		pf_flags |= MLX5_PF_FLAGS_DOWNGRADE;

+	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
+		pf_flags |= MLX5_PF_FLAGS_SNAPSHOT;
+
 	if (flags & IB_UVERBS_ADVISE_MR_FLAG_FLUSH)
 		return mlx5_ib_prefetch_sg_list(pd, advice, pf_flags, sg_list,
 						num_sge);
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index cfea82acfe57..22483799cd07 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -208,6 +208,7 @@ enum ib_uverbs_read_counters_flags {
 enum ib_uverbs_advise_mr_advice {
 	IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH,
 	IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE,
+	IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT,
 };

 enum ib_uverbs_advise_mr_flag {
--
2.26.2

