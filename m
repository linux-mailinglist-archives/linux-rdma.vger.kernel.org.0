Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDFA58C462
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Aug 2022 09:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiHHHsQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Aug 2022 03:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiHHHsP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Aug 2022 03:48:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE911820
        for <linux-rdma@vger.kernel.org>; Mon,  8 Aug 2022 00:48:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D77FB80A07
        for <linux-rdma@vger.kernel.org>; Mon,  8 Aug 2022 07:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D09C433D6;
        Mon,  8 Aug 2022 07:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659944892;
        bh=c+lmh5t7c9Lwu292lBosd1OxMMQtUC8Nvd0Jtmme9oE=;
        h=From:To:Cc:Subject:Date:From;
        b=hAThMT2sq/w71AJDHTly/M2wb6BmB9TM1iqSeBLRtHUJu/3LC9PW/duKNcY+tWMsa
         knTfo89tje3KxpjTktkbSn7tKTA7/kju8k2bX7nExQauCu6K5H85Xat88xaHorrPIy
         NmwLBo2i0Sr8spJ3CSq9TY7Cg3eOP71XoT2DjtpmpSAZn9I/xjBxfGPE8+oUeb2ua6
         QTUehXkSkmuDHgxHPBkxbw72BWJmv/Uq7RsOz/RRG764YRE4IbEt/Vwx1j6thSQZTQ
         wzmcVerZbp7Ccz5Arg2lAuBq+IIJ9WpZpZftdpSzwCUooWSCX7VMJe+xUZddx8CQpk
         f1rqhPgoKzXGw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Bloch <mbloch@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Use the proper number of ports
Date:   Mon,  8 Aug 2022 10:48:06 +0300
Message-Id: <a54a56c2ede16044a29d119209b35189c662ac72.1659944855.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Bloch <mbloch@nvidia.com>

The cited commit allowed the driver to operate over HCAs that have
4 physical ports. Use the number of ports of the RDMA device in the for
loop instead of using the struct size.

Fixes: 4cd14d44b11d ("net/mlx5: Support devices with more than 2 ports")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 34 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b68fddeac0f1..63c89a72cc35 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2738,26 +2738,24 @@ static int set_has_smi_cap(struct mlx5_ib_dev *dev)
 	int err;
 	int port;
 
-	for (port = 1; port <= ARRAY_SIZE(dev->port_caps); port++) {
-		dev->port_caps[port - 1].has_smi = false;
-		if (MLX5_CAP_GEN(dev->mdev, port_type) ==
-		    MLX5_CAP_PORT_TYPE_IB) {
-			if (MLX5_CAP_GEN(dev->mdev, ib_virt)) {
-				err = mlx5_query_hca_vport_context(dev->mdev, 0,
-								   port, 0,
-								   &vport_ctx);
-				if (err) {
-					mlx5_ib_err(dev, "query_hca_vport_context for port=%d failed %d\n",
-						    port, err);
-					return err;
-				}
-				dev->port_caps[port - 1].has_smi =
-					vport_ctx.has_smi;
-			} else {
-				dev->port_caps[port - 1].has_smi = true;
-			}
+	if (MLX5_CAP_GEN(dev->mdev, port_type) != MLX5_CAP_PORT_TYPE_IB)
+		return 0;
+
+	for (port = 1; port <= dev->num_ports; port++) {
+		if (!MLX5_CAP_GEN(dev->mdev, ib_virt)) {
+			dev->port_caps[port - 1].has_smi = true;
+			continue;
 		}
+		err = mlx5_query_hca_vport_context(dev->mdev, 0, port, 0,
+						   &vport_ctx);
+		if (err) {
+			mlx5_ib_err(dev, "query_hca_vport_context for port=%d failed %d\n",
+				    port, err);
+			return err;
+		}
+		dev->port_caps[port - 1].has_smi = vport_ctx.has_smi;
 	}
+
 	return 0;
 }
 
-- 
2.37.1

