Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0111CC41
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 12:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfLLLaq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 06:30:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfLLLaq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 06:30:46 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E07D22B48;
        Thu, 12 Dec 2019 11:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576150245;
        bh=2djQXSFKlErn/wsEyFiORI5yqaCzda0Xon3WsItaM4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yYnDhlVzNmiSV5rOQXKmiKSbFArllyxzwFRMKlVjrvcodR0EFok4Snx2pOoBoKkjx
         NtlkR7htOE2o3VaWaTPJCltAqzbWGinn/LfNe/l4/KjndTbl/rXv6qbD2hDWuO7xkw
         5vYYlcTry1msJNeirmI5pk2yuRNAKyyIFbyBjJVI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v1 3/4] IB/core: Cut down single member ib_cache structure
Date:   Thu, 12 Dec 2019 13:30:23 +0200
Message-Id: <20191212113024.336702-4-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212113024.336702-1-leon@kernel.org>
References: <20191212113024.336702-1-leon@kernel.org>
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
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cache.c | 30 +++++++++++++++---------------
 include/rdma/ib_verbs.h         |  7 ++-----
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index e55f345799e4..17bfedd24cc3 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1033,7 +1033,7 @@ int ib_get_cached_pkey(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;

-	read_lock_irqsave(&device->cache.lock, flags);
+	read_lock_irqsave(&device->cache_lock, flags);

 	cache = device->port_data[port_num].cache.pkey;

@@ -1042,7 +1042,7 @@ int ib_get_cached_pkey(struct ib_device *device,
 	else
 		*pkey = cache->table[index];

-	read_unlock_irqrestore(&device->cache.lock, flags);
+	read_unlock_irqrestore(&device->cache_lock, flags);

 	return ret;
 }
@@ -1057,9 +1057,9 @@ int ib_get_cached_subnet_prefix(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;

-	read_lock_irqsave(&device->cache.lock, flags);
+	read_lock_irqsave(&device->cache_lock, flags);
 	*sn_pfx = device->port_data[port_num].cache.subnet_prefix;
-	read_unlock_irqrestore(&device->cache.lock, flags);
+	read_unlock_irqrestore(&device->cache_lock, flags);

 	return 0;
 }
@@ -1079,7 +1079,7 @@ int ib_find_cached_pkey(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;

-	read_lock_irqsave(&device->cache.lock, flags);
+	read_lock_irqsave(&device->cache_lock, flags);

 	cache = device->port_data[port_num].cache.pkey;

@@ -1100,7 +1100,7 @@ int ib_find_cached_pkey(struct ib_device *device,
 		ret = 0;
 	}

-	read_unlock_irqrestore(&device->cache.lock, flags);
+	read_unlock_irqrestore(&device->cache_lock, flags);

 	return ret;
 }
@@ -1119,7 +1119,7 @@ int ib_find_exact_cached_pkey(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;

-	read_lock_irqsave(&device->cache.lock, flags);
+	read_lock_irqsave(&device->cache_lock, flags);

 	cache = device->port_data[port_num].cache.pkey;

@@ -1132,7 +1132,7 @@ int ib_find_exact_cached_pkey(struct ib_device *device,
 			break;
 		}

-	read_unlock_irqrestore(&device->cache.lock, flags);
+	read_unlock_irqrestore(&device->cache_lock, flags);

 	return ret;
 }
@@ -1148,9 +1148,9 @@ int ib_get_cached_lmc(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;

-	read_lock_irqsave(&device->cache.lock, flags);
+	read_lock_irqsave(&device->cache_lock, flags);
 	*lmc = device->port_data[port_num].cache.lmc;
-	read_unlock_irqrestore(&device->cache.lock, flags);
+	read_unlock_irqrestore(&device->cache_lock, flags);

 	return ret;
 }
@@ -1166,9 +1166,9 @@ int ib_get_cached_port_state(struct ib_device   *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;

-	read_lock_irqsave(&device->cache.lock, flags);
+	read_lock_irqsave(&device->cache_lock, flags);
 	*port_state = device->port_data[port_num].cache.port_state;
-	read_unlock_irqrestore(&device->cache.lock, flags);
+	read_unlock_irqrestore(&device->cache_lock, flags);

 	return ret;
 }
@@ -1428,7 +1428,7 @@ ib_cache_update(struct ib_device *device, u8 port, bool enforce_security)
 		}
 	}

-	write_lock_irq(&device->cache.lock);
+	write_lock_irq(&device->cache_lock);

 	old_pkey_cache = device->port_data[port].cache.pkey;

@@ -1437,7 +1437,7 @@ ib_cache_update(struct ib_device *device, u8 port, bool enforce_security)
 	device->port_data[port].cache.port_state = tprops->state;

 	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
-	write_unlock_irq(&device->cache.lock);
+	write_unlock_irq(&device->cache_lock);

 	if (enforce_security)
 		ib_security_cache_change(device,
@@ -1530,7 +1530,7 @@ int ib_cache_setup_one(struct ib_device *device)
 	unsigned int p;
 	int err;

-	rwlock_init(&device->cache.lock);
+	rwlock_init(&device->cache_lock);

 	err = gid_table_setup_one(device);
 	if (err)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index cb02d36d41d2..eaf9c948ff9b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2147,10 +2147,6 @@ struct ib_port_cache {
 	enum ib_port_state     port_state;
 };

-struct ib_cache {
-	rwlock_t                lock;
-};
-
 struct ib_port_immutable {
 	int                           pkey_tbl_len;
 	int                           gid_tbl_len;
@@ -2636,7 +2632,8 @@ struct ib_device {
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

