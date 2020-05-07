Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28371C833E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 09:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEGHKT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 03:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgEGHKS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 03:10:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB0D32075E;
        Thu,  7 May 2020 07:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588835418;
        bh=mEF8VkusOZmamshiXDJp7/1CdUUkxNmxDUSaY67R3As=;
        h=From:To:Cc:Subject:Date:From;
        b=QtlGZXc5oVWO8VGWjz0HloKsdG2aPVULvHWkdOov4a/cBWje9qSp5wta8jGEMcGRC
         DRevNssTPFEolqIeDm0WGZnWtxpXdcUMgL1QGsNIiMCzkBPGVxE0bUlQZOWY+rmTF1
         Tq/UAN9LGbyI0auVAUHj02Eukj8RvkS+/Zia7Zjw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc v2] IB/core: Fix potential NULL pointer dereference in pkey cache
Date:   Thu,  7 May 2020 10:10:12 +0300
Message-Id: <20200507071012.100594-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

The IB core pkey cache is populated by procedure ib_cache_update().
Initially, the pkey cache pointer is NULL. ib_cache_update allocates
a buffer and populates it with the device's pkeys, via repeated calls
to procedure ib_query_pkey().

If there is a failure in populating the pkey buffer via ib_query_pkey(),
ib_cache_update does not replace the old pkey buffer cache with the
updated one -- it leaves the old cache as is.

Since initially the pkey buffer cache is NULL, when calling
ib_cache_update the first time, a failure in ib_query_pkey() will cause
the pkey buffer cache pointer to remain NULL.

In this situation, any calls subsequent to ib_get_cached_pkey(),
ib_find_cached_pkey(), or ib_find_cached_pkey_exact() will try to
dereference the NULL pkey cache pointer, causing a kernel panic.

Fix this by checking the ib_cache_update() return value.

Fixes: 8faea9fd4a39 ("RDMA/cache: Move the cache per-port data into the main ib_port_data")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
Changelog:
v2: Removed error unwinding
v1: https://lore.kernel.org/linux-rdma/20200506053213.566264-1-leon@kernel.org
 I rewrote the patch to take care of ib_cache_update() return value.
v0: https://lore.kernel.org/linux-rdma/20200426075811.129814-1-leon@kernel.org
---
 drivers/infiniband/core/cache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 717b798cddad..a670209bbce6 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1553,8 +1553,11 @@ int ib_cache_setup_one(struct ib_device *device)
 	if (err)
 		return err;

-	rdma_for_each_port (device, p)
-		ib_cache_update(device, p, true);
+	rdma_for_each_port (device, p) {
+		err = ib_cache_update(device, p, true);
+		if (err)
+			return err;
+	}

 	return 0;
 }
--
2.26.2

