Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28B81B8DB4
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2020 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgDZH6R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Apr 2020 03:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgDZH6R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Apr 2020 03:58:17 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25DD820700;
        Sun, 26 Apr 2020 07:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587887896;
        bh=NQRJ5e+Rc0AiDwh/H2tDZecArXxZy0fuZBvYt8MH8ls=;
        h=From:To:Cc:Subject:Date:From;
        b=q57OqVpa9MGZ9ez/3MmTYQbesS7MSwwK3cu1hI3mIDutzv83yGRUzecGLQY7KCmgi
         wOxSFVCkHCUK3Yj5f7MNWwZAkVCroIXR9bHh57EL0IYc7SrkSOsvr61hErR5Zcx3lC
         fUeJGbetMPdTzdCAcCGFzs8Kohapm97EtgdVKh94=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] IB/core: Fix potential NULL pointer dereference in pkey cache
Date:   Sun, 26 Apr 2020 10:58:11 +0300
Message-Id: <20200426075811.129814-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
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

Fix this by testing if the cache pointer is NULL. If yes,
return -ENOENT.

Fixes: 8faea9fd4a39 ("RDMA/cache: Move the cache per-port data into the main ib_port_data")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cache.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 717b798cddad..4263a482ecab 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1054,11 +1054,17 @@ int ib_get_cached_pkey(struct ib_device *device,
 
 	cache = device->port_data[port_num].cache.pkey;
 
+	if (!cache) {
+		ret = -ENOENT;
+		goto out;
+	}
+
 	if (index < 0 || index >= cache->table_len)
 		ret = -EINVAL;
 	else
 		*pkey = cache->table[index];
 
+out:
 	read_unlock_irqrestore(&device->cache_lock, flags);
 
 	return ret;
@@ -1101,6 +1107,8 @@ int ib_find_cached_pkey(struct ib_device *device,
 	cache = device->port_data[port_num].cache.pkey;
 
 	*index = -1;
+	if (!cache)
+		goto out;
 
 	for (i = 0; i < cache->table_len; ++i)
 		if ((cache->table[i] & 0x7fff) == (pkey & 0x7fff)) {
@@ -1117,6 +1125,7 @@ int ib_find_cached_pkey(struct ib_device *device,
 		ret = 0;
 	}
 
+out:
 	read_unlock_irqrestore(&device->cache_lock, flags);
 
 	return ret;
@@ -1141,6 +1150,8 @@ int ib_find_exact_cached_pkey(struct ib_device *device,
 	cache = device->port_data[port_num].cache.pkey;
 
 	*index = -1;
+	if (!cache)
+		goto out;
 
 	for (i = 0; i < cache->table_len; ++i)
 		if (cache->table[i] == pkey) {
@@ -1149,6 +1160,7 @@ int ib_find_exact_cached_pkey(struct ib_device *device,
 			break;
 		}
 
+out:
 	read_unlock_irqrestore(&device->cache_lock, flags);
 
 	return ret;
-- 
2.25.3

