Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2422689DA
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 13:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgINLTS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 07:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgINLTD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Sep 2020 07:19:03 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C6D821D24;
        Mon, 14 Sep 2020 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600082342;
        bh=E83cmqT1XoXi97Nmmvk4Ry1wo9DttE4g+t4FA6GLXIE=;
        h=From:To:Cc:Subject:Date:From;
        b=KTHlKriNCO+ZVH3Y1XXTrDvmEe/ozOxU4AiRatM9+p1VZ0h4lztPX+WrWSA4noQnp
         l8ETJV3YGFrgQfbaW4aFia2/EDaJCysEOdY9jwqLkpSn31gxf7ptDsQijsj+Cxrkvx
         DxnclBY2hNjL4KZV2BYHCN/bE//e+1DcvwbTbccg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v3] RDMA/mlx4: Provide port number for special QPs
Date:   Mon, 14 Sep 2020 14:18:57 +0300
Message-Id: <20200914111857.344434-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Special QPs created by mlx4 have same QP port borrowed from
the context, while they are expected to have different ones.

Fix it by using HW physical port instead.

It fixes the following error during driver init:
[   12.074150] mlx4_core 0000:05:00.0: mlx4_ib: initializing demux service for 128 qp1 clients
[   12.084036] <mlx4_ib> create_pv_sqp: Couldn't create special QP (-16)
[   12.085123] <mlx4_ib> create_pv_resources: Couldn't create  QP1 (-16)
[   12.088300] mlx4_en: Mellanox ConnectX HCA Ethernet driver v4.0-0

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Changelog:
v3: mlx4 devices create 2 special QPs in SRIOV mode, separate them by
port number and special bit. The mlx4 is limited to two ports and not
going to be extended, and the port_num is not forwarded to FW too, so
it is safe.
v2: https://lore.kernel.org/linux-rdma/20200907122156.478360-4-leon@kernel.org/#r
---
 drivers/infiniband/hw/mlx4/mad.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index 8bd16474708f..4b565640ba85 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -1792,7 +1792,7 @@ static void pv_qp_event_handler(struct ib_event *event, void *qp_context)
 }

 static int create_pv_sqp(struct mlx4_ib_demux_pv_ctx *ctx,
-			    enum ib_qp_type qp_type, int create_tun)
+			 enum ib_qp_type qp_type, int port, int create_tun)
 {
 	int i, ret;
 	struct mlx4_ib_demux_pv_qp *tun_qp;
@@ -1822,12 +1822,13 @@ static int create_pv_sqp(struct mlx4_ib_demux_pv_ctx *ctx,
 		qp_init_attr.proxy_qp_type = qp_type;
 		qp_attr_mask_INIT = IB_QP_STATE | IB_QP_PKEY_INDEX |
 			   IB_QP_QKEY | IB_QP_PORT;
+		qp_init_attr.init_attr.port_num = ctx->port;
 	} else {
 		qp_init_attr.init_attr.qp_type = qp_type;
 		qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
 		qp_attr_mask_INIT = IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_QKEY;
+		qp_init_attr.init_attr.port_num = port | 1 << 7;
 	}
-	qp_init_attr.init_attr.port_num = ctx->port;
 	qp_init_attr.init_attr.qp_context = ctx;
 	qp_init_attr.init_attr.event_handler = pv_qp_event_handler;
 	tun_qp->qp = ib_create_qp(ctx->pd, &qp_init_attr.init_attr);
@@ -2026,7 +2027,7 @@ static int create_pv_resources(struct ib_device *ibdev, int slave, int port,
 	}

 	if (ctx->has_smi) {
-		ret = create_pv_sqp(ctx, IB_QPT_SMI, create_tun);
+		ret = create_pv_sqp(ctx, IB_QPT_SMI, port, create_tun);
 		if (ret) {
 			pr_err("Couldn't create %s QP0 (%d)\n",
 			       create_tun ? "tunnel for" : "",  ret);
@@ -2034,7 +2035,7 @@ static int create_pv_resources(struct ib_device *ibdev, int slave, int port,
 		}
 	}

-	ret = create_pv_sqp(ctx, IB_QPT_GSI, create_tun);
+	ret = create_pv_sqp(ctx, IB_QPT_GSI, port, create_tun);
 	if (ret) {
 		pr_err("Couldn't create %s QP1 (%d)\n",
 		       create_tun ? "tunnel for" : "",  ret);
--
2.26.2

