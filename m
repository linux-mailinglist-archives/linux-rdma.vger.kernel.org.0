Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29E24FD9C8
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245198AbiDLJ5Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359459AbiDLHnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA112094
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 684286152A
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D62C385A8;
        Tue, 12 Apr 2022 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748273;
        bh=jxzBQ3p511Q4zNZoSo17Nc0/mX6rU2ZH6d6/tFfjLPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UumpKQeQoMVNt7SOEtOxZkIlnh/nSfb6z0CABQObZQkG2AoKQrNONJkxwe1i0rPYM
         2ba49t/b0olKqD5O9jEl7Zb03iFeQLhcrujO2Nn8oZu6I3zkvBeareKBG6e6HE/MZO
         Oh2XGspM5M+tR6vLXhSHibz7zv54LK1TZGrb0H0spDWNyEaQUcq+NUJ4QDCagvuEdf
         AdyZ85+ogCGjwVflppE3NxKRSv0ARJ1FLXL2sciTZ7oV1RrR7Y546mcjd05oUNAqkK
         kg4oAUBBdmuU+yTPZEZ+UP8g7Rt1v9tWWhOy47/usdDONkrA/xVTRIZZ5Ae4m/2RSc
         00xHVC9SUBOXg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 06/12] RDMA/mlx5: Introduce mlx5_umr_post_send_wait()
Date:   Tue, 12 Apr 2022 10:24:01 +0300
Message-Id: <f027dd592fde62402b2d49efded8d1d22229d22b.1649747695.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649747695.git.leonro@nvidia.com>
References: <cover.1649747695.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Introduce mlx5_umr_post_send_wait() that uses a UMR adjusted flow for
posting WQEs. The next patches will gradually move UMR operations to use
this flow. Once done, will get rid of mlx5_ib_post_send_wait().

mlx5_umr_post_send_wait gets already written WQE segments and will only
memcpy it to the SQ. This way, we avoid packing all the data in a WR just
to unpack it into the WQE.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/umr.c | 92 ++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/umr.h | 12 +++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 8131501dc052..f17f64cb1925 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -3,6 +3,7 @@
 
 #include "mlx5_ib.h"
 #include "umr.h"
+#include "wr.h"
 
 static __be64 get_umr_enable_mr_mask(void)
 {
@@ -228,3 +229,94 @@ void mlx5r_umr_resource_cleanup(struct mlx5_ib_dev *dev)
 	ib_free_cq(dev->umrc.cq);
 	ib_dealloc_pd(dev->umrc.pd);
 }
+
+static int mlx5r_umr_post_send(struct ib_qp *ibqp, u32 mkey, struct ib_cqe *cqe,
+			       struct mlx5r_umr_wqe *wqe, bool with_data)
+{
+	unsigned int wqe_size =
+		with_data ? sizeof(struct mlx5r_umr_wqe) :
+			    sizeof(struct mlx5r_umr_wqe) -
+				    sizeof(struct mlx5_wqe_data_seg);
+	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
+	struct mlx5_core_dev *mdev = dev->mdev;
+	struct mlx5_ib_qp *qp = to_mqp(ibqp);
+	struct mlx5_wqe_ctrl_seg *ctrl;
+	union {
+		struct ib_cqe *ib_cqe;
+		u64 wr_id;
+	} id;
+	void *cur_edge, *seg;
+	unsigned long flags;
+	unsigned int idx;
+	int size, err;
+
+	if (unlikely(mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR))
+		return -EIO;
+
+	spin_lock_irqsave(&qp->sq.lock, flags);
+
+	err = mlx5r_begin_wqe(qp, &seg, &ctrl, &idx, &size, &cur_edge, 0,
+			      cpu_to_be32(mkey), false, false);
+	if (WARN_ON(err))
+		goto out;
+
+	qp->sq.wr_data[idx] = MLX5_IB_WR_UMR;
+
+	mlx5r_memcpy_send_wqe(&qp->sq, &cur_edge, &seg, &size, wqe, wqe_size);
+
+	id.ib_cqe = cqe;
+	mlx5r_finish_wqe(qp, ctrl, seg, size, cur_edge, idx, id.wr_id, 0,
+			 MLX5_FENCE_MODE_NONE, MLX5_OPCODE_UMR);
+
+	mlx5r_ring_db(qp, 1, ctrl);
+
+out:
+	spin_unlock_irqrestore(&qp->sq.lock, flags);
+
+	return err;
+}
+
+static void mlx5r_umr_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct mlx5_ib_umr_context *context =
+		container_of(wc->wr_cqe, struct mlx5_ib_umr_context, cqe);
+
+	context->status = wc->status;
+	complete(&context->done);
+}
+
+static inline void mlx5r_umr_init_context(struct mlx5r_umr_context *context)
+{
+	context->cqe.done = mlx5r_umr_done;
+	init_completion(&context->done);
+}
+
+static int mlx5r_umr_post_send_wait(struct mlx5_ib_dev *dev, u32 mkey,
+				   struct mlx5r_umr_wqe *wqe, bool with_data)
+{
+	struct umr_common *umrc = &dev->umrc;
+	struct mlx5r_umr_context umr_context;
+	int err;
+
+	err = umr_check_mkey_mask(dev, be64_to_cpu(wqe->ctrl_seg.mkey_mask));
+	if (WARN_ON(err))
+		return err;
+
+	mlx5r_umr_init_context(&umr_context);
+
+	down(&umrc->sem);
+	err = mlx5r_umr_post_send(umrc->qp, mkey, &umr_context.cqe, wqe,
+				  with_data);
+	if (err)
+		mlx5_ib_warn(dev, "UMR post send failed, err %d\n", err);
+	else {
+		wait_for_completion(&umr_context.done);
+		if (umr_context.status != IB_WC_SUCCESS) {
+			mlx5_ib_warn(dev, "reg umr failed (%u)\n",
+				     umr_context.status);
+			err = -EFAULT;
+		}
+	}
+	up(&umrc->sem);
+	return err;
+}
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index 0fe6cdd633d4..d984213caf60 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -79,4 +79,16 @@ int mlx5r_umr_set_umr_ctrl_seg(struct mlx5_ib_dev *dev,
 			       struct mlx5_wqe_umr_ctrl_seg *umr,
 			       const struct ib_send_wr *wr);
 
+struct mlx5r_umr_context {
+	struct ib_cqe cqe;
+	enum ib_wc_status status;
+	struct completion done;
+};
+
+struct mlx5r_umr_wqe {
+	struct mlx5_wqe_umr_ctrl_seg ctrl_seg;
+	struct mlx5_mkey_seg mkey_seg;
+	struct mlx5_wqe_data_seg data_seg;
+};
+
 #endif /* _MLX5_IB_UMR_H */
-- 
2.35.1

