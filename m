Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7D720F478
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbgF3MVx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 08:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732221AbgF3MVw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 08:21:52 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93A2920672;
        Tue, 30 Jun 2020 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593519712;
        bh=eA8tWE6SkC6ABO+njv6uNW/zXgo2oRixNXpGw01lz2c=;
        h=From:To:Cc:Subject:Date:From;
        b=HMQeMPAFh5ejK/pjLuXhUCCIhslIsRFHlD3lNvpjkSjtqWzTcor97zQbedDlQlIpa
         sXQo+9U1yz2itmfND9JtwJ97KP+fmAI+CLruANFBuwHbwokzjUITY1jmcNtWec9r0/
         eXCKoWK80m0qnIQhehrRfG8vh3J5wNiSbTI1YPBs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix legacy IPoIB QP initialization
Date:   Tue, 30 Jun 2020 15:21:47 +0300
Message-Id: <20200630122147.445847-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Legacy IPoIB sets IB_QP_CREATE_NETIF_QP QP create flag and because
mlx5 doesn't use this flag, the process_create_flags() failed to
create IPoIB QPs.

Fixes: 2978975ce7f1 ("RDMA/mlx5: Process create QP flags in one place")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index f939c9b769f0..b316c9cafbc5 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2668,6 +2668,10 @@ static int process_create_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	if (qp_type == IB_QPT_RAW_PACKET && attr->rwq_ind_tbl)
 		return (create_flags) ? -EINVAL : 0;
 
+	process_create_flag(dev, &create_flags, IB_QP_CREATE_NETIF_QP,
+			    mlx5_get_flow_namespace(dev->mdev,
+						    MLX5_FLOW_NAMESPACE_BYPASS),
+			    qp);
 	process_create_flag(dev, &create_flags,
 			    IB_QP_CREATE_INTEGRITY_EN,
 			    MLX5_CAP_GEN(mdev, sho), qp);
-- 
2.26.2

