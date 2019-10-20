Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32BADDD1D
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 08:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfJTGyl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 02:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfJTGyl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 02:54:41 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B7852190F;
        Sun, 20 Oct 2019 06:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571554479;
        bh=i9zmlR9x6m4eR8fC2PUs4Yzm7+SX+QwoD0SpeymNtTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OK9cwEXCTXHiEjTcuxJ9ww8m53D1h1HRxlXWes/wVGNmfVOQSjah2J7mwnKu2KpYm
         TscYPSCjFgoteezKe4C5XKTnfWi52hNgmSSfDX+OZnRg/0t372QQA91NDGxbDJMEpq
         ninyYT31B/mzOMqDpikLSGzwNmAGRbAn77UEelqs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 2/3] IB/core: Cut down single member ib_cache structure
Date:   Sun, 20 Oct 2019 09:54:26 +0300
Message-Id: <20191020065427.8772-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020065427.8772-1-leon@kernel.org>
References: <20191020065427.8772-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Given that ib_cache structure has only single member now, merge the
cache lock directly in the ib_device.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cache.c | 30 +++++++++++++++---------------
 include/rdma/ib_verbs.h         |  7 ++-----
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 46dba17b385d..b626ca682004 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1039,7 +1039,7 @@ int ib_get_cached_pkey(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;

-	read_lock_irqsave(&device->cache.lock, flags);
+	read_lock_irqsave(&device->cache_lock, flags);

 	cache = device->port_data[port_num].cache.pkey;

@@ -1048,7 +1048,7 @@ int ib_get_cached_pkey(struct ib_device *device,
 	else
 		*pkey = cache->table[index];

-	read_unlock_irqrestore(&device->cache.lock, flags);
+	read_unlock_irqrestore(&device->cache_lock, flags);

 	return ret;
 }
@@ -1063,9 +1063,9 @@ int ib_get_cached_subnet_prefix(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;

-	read_lock_irqsave(&device->cache.lock, flags);
+	read_lock_irqsave(&device->cache_lock, flags);
 	*sn_pfx = device->port_data[port_num].cache.subnet_prefix;
-	read_unlock_irqrestore(&device->cache.lock, flags);
+	read_unlock_irqrestore(&device->cache_lock, flags);

 	return 0;
 }
@@ -1085,7 +1085,7 @@ int ib_find_cached_pkey(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;

-	read_lock_irqsave(&device->cache.lock, flags);
+	read_lock_irqsave(&device->cache_lock, flags);

 	cache = device->port_data[port_num].cache.pkey;

@@ -1106,7 +1106,7 @@ int ib_find_cached_pkey(struct ib_device *device,
 		ret = 0;
 	}

-	read_unlock_irqrestore(&device->cache.lock, flags);
+	read_unlock_irqrestore(&device->cache_lock, flags);

 	return ret;
 }
@@ -1125,7 +1125,7 @@ int ib_find_exact_cached_pkey(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;

-	read_lock_irqsave(&device->cache.lock, flags);
+	read_lock_irqsave(&device->cache_lock, flags);

 	cache = device->port_data[port_num].cache.pkey;

@@ -1138,7 +1138,7 @@ int ib_find_exact_cached_pkey(struct ib_device *device,
 			break;
 		}

-	read_unlock_irqrestore(&device->cache.lock, flags);
+	read_unlock_irqrestore(&device->cache_lock, flags);

 	return ret;
 }
@@ -1154,9 +1154,9 @@ int ib_get_cached_lmc(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;

-	read_lock_irqsave(&device->cache.lock, flags);
+	read_lock_irqsave(&device->cache_lock, flags);
 	*lmc = device->port_data[port_num].cache.lmc;
-	read_unlock_irqrestore(&device->cache.lock, flags);
+	read_unlock_irqrestore(&device->cache_lock, flags);

 	return ret;
 }
@@ -1172,9 +1172,9 @@ int ib_get_cached_port_state(struct ib_device   *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;

-	read_lock_irqsave(&device->cache.lock, flags);
+	read_lock_irqsave(&device->cache_lock, flags);
 	*port_state = device->port_data[port_num].cache.port_state;
-	read_unlock_irqrestore(&device->cache.lock, flags);
+	read_unlock_irqrestore(&device->cache_lock, flags);

 	return ret;
 }
@@ -1434,7 +1434,7 @@ ib_cache_update(struct ib_device *device, u8 port, bool	enforce_security)
 		}
 	}

-	write_lock_irq(&device->cache.lock);
+	write_lock_irq(&device->cache_lock);

 	old_pkey_cache = device->port_data[port].cache.pkey;

@@ -1443,7 +1443,7 @@ ib_cache_update(struct ib_device *device, u8 port, bool	enforce_security)
 	device->port_data[port].cache.port_state = tprops->state;

 	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
-	write_unlock_irq(&device->cache.lock);
+	write_unlock_irq(&device->cache_lock);

 	if (enforce_security)
 		ib_security_cache_change(device,
@@ -1511,7 +1511,7 @@ int ib_cache_setup_one(struct ib_device *device)
 	unsigned int p;
 	int err;

-	rwlock_init(&device->cache.lock);
+	rwlock_init(&device->cache_lock);

 	err = gid_table_setup_one(device);
 	if (err)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 1f6d6734f477..adff05eade2c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2146,10 +2146,6 @@ struct ib_port_cache {
 	enum ib_port_state     port_state;
 };

-struct ib_cache {
-	rwlock_t                lock;
-};
-
 struct ib_port_immutable {
 	int                           pkey_tbl_len;
 	int                           gid_tbl_len;
@@ -2609,7 +2605,8 @@ struct ib_device {
 	struct xarray                 client_data;
 	struct mutex                  unregistration_lock;

-	struct ib_cache               cache;
+	/* Synchronize GID, Pkey cache entries, subnet prefix, LMC */
+	rwlock_t cache_lock;
 	/**
 	 * port_data is indexed by port number
 	 */
--
2.20.1

