Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177E51C677B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 07:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgEFFcT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 01:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgEFFcT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 01:32:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1F3520714;
        Wed,  6 May 2020 05:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588743139;
        bh=0a/MR5nokuh2cJqHQK1MkFW2yKgYcIwvRQIvyg7ZE4k=;
        h=From:To:Cc:Subject:Date:From;
        b=KvERTAX8wtk1LVkebSo1QVN0cl/HtlEcCoAruptmhjyfbVR0rK2UT9y1ZQxypaQON
         CFebS7emMngg3kQ42MQ1EoUqWjbzeJWyRzx4rBcjAT358zDsETsv+3qR8rSONI3rN3
         oTjiO0nKXzA9+QlNyRRqoQldnPMUMDcwnhTzb0EA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc v1] IB/core: Fix potential NULL pointer dereference in pkey cache
Date:   Wed,  6 May 2020 08:32:13 +0300
Message-Id: <20200506053213.566264-1-leon@kernel.org>
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
v1: I rewrote the patch to take care of ib_cache_update() return value.
v0: https://lore.kernel.org/linux-rdma/20200426075811.129814-1-leon@kernel.org
---
 drivers/infiniband/core/cache.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 717b798cddad..1cbebfa374a5 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1553,10 +1553,17 @@ int ib_cache_setup_one(struct ib_device *device)
 	if (err)
 		return err;

-	rdma_for_each_port (device, p)
-		ib_cache_update(device, p, true);
+	rdma_for_each_port (device, p) {
+		err = ib_cache_update(device, p, true);
+		if (err)
+			goto out;
+	}

 	return 0;
+
+out:
+	ib_cache_release_one(device);
+	return err;
 }

 void ib_cache_release_one(struct ib_device *device)
--
2.26.2

