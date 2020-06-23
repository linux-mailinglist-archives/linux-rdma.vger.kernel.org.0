Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9CF204FEA
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 13:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbgFWLBU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 07:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732455AbgFWLBR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 07:01:17 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3EF320768;
        Tue, 23 Jun 2020 11:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592910077;
        bh=qrjXtEurLagvKmQk1eXxgrMEV8qKfQSP4ySC2G/Awf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d3UV3U/WJvu/1VkpGwje2mSblagH5dXN5jeo8++Hnx52BwVGAZO4j+wwTd1Zz5vvH
         FXW50QUAKt5dA4rg6PXzglE+xAJLwx7DcGDy/ndC3/F/h30xlinyl0w2lTgZHESZ8v
         qpsX/A657k7z5eTclTadTe+d/hLy7Nsis+eltyn0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Michael Guralnik <michaelgur@mellanox.com>,
        Feras Daoud <ferasda@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/2] RDMA/ipoib: Handle user-supplied address when creating child
Date:   Tue, 23 Jun 2020 14:01:05 +0300
Message-Id: <20200623110105.1225750-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623110105.1225750-1-leon@kernel.org>
References: <20200623110105.1225750-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

Use the address supplied by user when creating a child interface.

Previously, the address requested by the user was ignored and overridden
with parent's GID and the random QP number assigned to the child.

Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Reviewed-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 3cfb682b91b0..a9f1174f7320 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1892,8 +1892,15 @@ static void ipoib_child_init(struct net_device *ndev)
 
 	priv->max_ib_mtu = ppriv->max_ib_mtu;
 	set_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags);
-	memcpy(priv->dev->dev_addr, ppriv->dev->dev_addr, INFINIBAND_ALEN);
-	memcpy(&priv->local_gid, &ppriv->local_gid, sizeof(priv->local_gid));
+	if (memchr_inv(priv->dev->dev_addr, 0, INFINIBAND_ALEN))
+		memcpy(&priv->local_gid, priv->dev->dev_addr + 4,
+		       sizeof(priv->local_gid));
+	else {
+		memcpy(priv->dev->dev_addr, ppriv->dev->dev_addr,
+		       INFINIBAND_ALEN);
+		memcpy(&priv->local_gid, &ppriv->local_gid,
+		       sizeof(priv->local_gid));
+	}
 }
 
 static int ipoib_ndo_init(struct net_device *ndev)
-- 
2.26.2

