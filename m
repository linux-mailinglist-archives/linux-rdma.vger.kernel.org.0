Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945C4149C0F
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 18:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgAZRRO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 12:17:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgAZRRN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 12:17:13 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F7A320702;
        Sun, 26 Jan 2020 17:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580059033;
        bh=YPiOgqP92O2Oav7O/mZ8a4y7oO2N3g+fpbgI1soayqw=;
        h=From:To:Cc:Subject:Date:From;
        b=sSC8StBoqnNg1S4UfDQJ08dx5EX1+LMIQIoAS1bhJPZzeRoZFXuhCna/RwXg/BbMD
         IiSpU/jlqQHGuKrSoeGVctpTHlGSgVj5mq+nvMqISveK0qepjBDVfZPdTmJEeLXtZT
         TZ/BT63T4Vm7uexHVTyX2ZrdcmZWPn13jAOjdwAk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] IB/mlx5: Return failure when  rts2rts_qp_counters_set_id is not supported
Date:   Sun, 26 Jan 2020 19:17:08 +0200
Message-Id: <20200126171708.5167-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

When bind a QP with a counter and the QP state is not RESET, return
failure if the rts2rts_qp_counters_set_id is not supported. This is
to prevent cases like manual bind for Connect-IB devices from returning
success when the feature is not supported.

Fixes: d14133dd4161 ("IB/mlx5: Support set qp counter")
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index a4f8e7030787..957f3a52589b 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3441,9 +3441,6 @@ static int __mlx5_ib_qp_set_counter(struct ib_qp *qp,
 	struct mlx5_ib_qp_base *base;
 	u32 set_id;

-	if (!MLX5_CAP_GEN(dev->mdev, rts2rts_qp_counters_set_id))
-		return 0;
-
 	if (counter)
 		set_id = counter->id;
 	else
@@ -6576,6 +6573,7 @@ void mlx5_ib_drain_rq(struct ib_qp *qp)
  */
 int mlx5_ib_qp_set_counter(struct ib_qp *qp, struct rdma_counter *counter)
 {
+	struct mlx5_ib_dev *dev = to_mdev(qp->device);
 	struct mlx5_ib_qp *mqp = to_mqp(qp);
 	int err = 0;

@@ -6585,6 +6583,11 @@ int mlx5_ib_qp_set_counter(struct ib_qp *qp, struct rdma_counter *counter)
 		goto out;
 	}

+	if (!MLX5_CAP_GEN(dev->mdev, rts2rts_qp_counters_set_id)) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (mqp->state == IB_QPS_RTS) {
 		err = __mlx5_ib_qp_set_counter(qp, counter);
 		if (!err)
--
2.24.1

