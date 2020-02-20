Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8DA16584A
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 08:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgBTHMw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 02:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgBTHMw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 02:12:52 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 653612465D;
        Thu, 20 Feb 2020 07:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582182772;
        bh=O10T/IBS68LU6927FT7UJxV2RCn8XwhNO7Nmtq+gaaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQmpTBfRz96omqmNZtw49dlu2+j3F7I5RS93K3PoH8xp65XrVhmco1hcis8fCNE75
         OkjPuyRvyqr0trzx70KCQtmr5b7h4zPRkzTbThaASzzFVKjbs+wwVe8viqU+gPY0Gb
         7v7r8TBo7u4VxiShWmcv4NhBkMr1cfZzfpG6ADM0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH rdma-next 1/2] RDMA/ipoib: Don't set constant driver version
Date:   Thu, 20 Feb 2020 09:12:38 +0200
Message-Id: <20200220071239.231800-2-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220071239.231800-1-leon@kernel.org>
References: <20200220071239.231800-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

There is no need to set driver version in in-tree kernel code.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/ulp/ipoib/ipoib.h         | 2 --
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 3 ---
 drivers/infiniband/ulp/ipoib/ipoib_main.c    | 4 ----
 3 files changed, 9 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 2aa3457a30ce..e188a95984b5 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -838,6 +838,4 @@ extern int ipoib_debug_level;
 
 #define IPOIB_QPN(ha) (be32_to_cpup((__be32 *) ha) & 0xffffff)
 
-extern const char ipoib_driver_version[];
-
 #endif /* _IPOIB_H */
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
index 63e4f9d15fd9..a47097d4577c 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
@@ -68,9 +68,6 @@ static void ipoib_get_drvinfo(struct net_device *netdev,
 	strlcpy(drvinfo->bus_info, dev_name(priv->ca->dev.parent),
 		sizeof(drvinfo->bus_info));
 
-	strlcpy(drvinfo->version, ipoib_driver_version,
-		sizeof(drvinfo->version));
-
 	strlcpy(drvinfo->driver, "ib_ipoib", sizeof(drvinfo->driver));
 }
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index f630be064435..9fac1dbc8197 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -52,10 +52,6 @@
 #include <linux/inetdevice.h>
 #include <rdma/ib_cache.h>
 
-#define DRV_VERSION "1.0.0"
-
-const char ipoib_driver_version[] = DRV_VERSION;
-
 MODULE_AUTHOR("Roland Dreier");
 MODULE_DESCRIPTION("IP-over-InfiniBand net driver");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.24.1

