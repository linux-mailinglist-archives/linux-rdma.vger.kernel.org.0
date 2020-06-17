Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D2F1FCE08
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 15:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgFQNCf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 09:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgFQNCf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jun 2020 09:02:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BBCB207DD;
        Wed, 17 Jun 2020 13:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592398955;
        bh=M6fugjqciBVY2bzoL8f21JnnFhUA+Cm7C9N/arRWUHo=;
        h=From:To:Cc:Subject:Date:From;
        b=H2cSzjAyJ2pblvIS5JzjbxmQz3o/z/d5C99VGcngtRA1GTtGsDr+I+nl4iVgx7w6T
         vJe0U5ax6aAWE8CYHs3PlVu4tEoruNanEleluqo17tGpjaKbHFywG1yE00MKeaw5FW
         7rhrKTZmIGojhZCmlLqTEMLq7Bdf+dFCCHPn9F6s=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix integrity enabled QP creation
Date:   Wed, 17 Jun 2020 16:02:30 +0300
Message-Id: <20200617130230.2846915-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

create_flags checks was refactored and broke the creation on integrity
enabled QPs and actually broke the NVMe/RDMA and iSER ULP's when using
mlx5 driven devices.

Fixes: 2978975ce7f1 ("RDMA/mlx5: Process create QP flags in one place")
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index aff412b513ae..fe6af6bed02d 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2668,6 +2668,9 @@ static int process_create_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	if (qp_type == IB_QPT_RAW_PACKET && attr->rwq_ind_tbl)
 		return (create_flags) ? -EINVAL : 0;

+	process_create_flag(dev, &create_flags,
+			    IB_QP_CREATE_INTEGRITY_EN,
+			    MLX5_CAP_GEN(mdev, sho), qp);
 	process_create_flag(dev, &create_flags,
 			    IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK,
 			    MLX5_CAP_GEN(mdev, block_lb_mc), qp);
--
2.26.2

