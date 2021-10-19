Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C19433E5F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 20:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhJSS2s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 14:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233816AbhJSS2o (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 14:28:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90FC9613A4;
        Tue, 19 Oct 2021 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634667991;
        bh=kezj01FP78O6jTIr8auqDeAgej/KAvIDztgVq52Zu0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbcNsNq3S9yjHXIOQIyYVZagY+lSsmL9wM6XG1oHk9u7onATM9BdYyGcLkQ7ZJ5Yi
         MyLZCjgZazfmk0AKL2BxurM/du6EYqyozHoTNO/HGnFPGjCuo/aGrquLaTndLttJ+H
         YcCQ1rA3GdwYWj4UNuLSkcjgiQHET+/FE//lEp7uw2TLvyBDnNwv2o7fsldWcvKBT3
         tJhNAsH/T0emyFzgt9xZ8uC03wyFlV1siGkIa0swLMrhW5YzTMh3VuctaqilOufS9A
         EEPnFh/f/8R84VrP7hNTn0FqtAciNfdRx1DjcgXcWoCPQg3aAaKcr1bRWvEHOxlyQj
         BnUCRSS28n5Ow==
From:   Jakub Kicinski <kuba@kernel.org>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        saeedm@nvidia.com, leon@kernel.org
Subject: [PATCH rdma-next 2/3] mlx5: use dev_addr_mod()
Date:   Tue, 19 Oct 2021 11:26:03 -0700
Message-Id: <20211019182604.1441387-3-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019182604.1441387-1-kuba@kernel.org>
References: <20211019182604.1441387-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
of VLANs...") introduced a rbtree for faster Ethernet address look
up. To maintain netdev->dev_addr in this tree we need to make all
the writes to it got through appropriate helpers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: saeedm@nvidia.com
CC: leon@kernel.org
CC: linux-rdma@vger.kernel.org
---
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 67571e5040d6..fe76c27835ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -472,11 +472,13 @@ int mlx5i_dev_init(struct net_device *dev)
 {
 	struct mlx5e_priv    *priv   = mlx5i_epriv(dev);
 	struct mlx5i_priv    *ipriv  = priv->ppriv;
+	u8 addr_mod[3];
 
 	/* Set dev address using underlay QP */
-	dev->dev_addr[1] = (ipriv->qpn >> 16) & 0xff;
-	dev->dev_addr[2] = (ipriv->qpn >>  8) & 0xff;
-	dev->dev_addr[3] = (ipriv->qpn) & 0xff;
+	addr_mod[0] = (ipriv->qpn >> 16) & 0xff;
+	addr_mod[1] = (ipriv->qpn >>  8) & 0xff;
+	addr_mod[2] = (ipriv->qpn) & 0xff;
+	dev_addr_mod(dev, 1, addr_mod, sizeof(addr_mod));
 
 	/* Add QPN to net-device mapping to HT */
 	mlx5i_pkey_add_qpn(dev, ipriv->qpn);
-- 
2.31.1

