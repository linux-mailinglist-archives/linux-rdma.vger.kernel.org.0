Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A164AE8782
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 12:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfJ2Lxn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 07:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJ2Lxn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 07:53:43 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 828E521D56;
        Tue, 29 Oct 2019 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572350022;
        bh=is+u4D3oM9AZwjYfpcd7H0Grg1Q2090bxEH+exK6MMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBB80yD6KYwckGTxlFQBfoWtjC0jMfhCQD/8zNvaBdiC2b4PaceSCbfFzgN0eCwZc
         BtxgVRMi4WBmsJHk15fpndpEWPGbIF7ICfi28WyTjTwHeeOW8xOxuJVyeYjhTJWdVE
         T4htS6iMXtWPA/ggTaf7qJeUox97q3xRZmUFCEp8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v1 2/2] IB/core: Cut down single member ib_cache structure
Date:   Tue, 29 Oct 2019 13:53:27 +0200
Message-Id: <20191029115327.16589-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029115327.16589-1-leon@kernel.org>
References: <20191029115327.16589-1-leon@kernel.org>
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
index 1d5c0df7dfab..1d6f1a20194d 100644
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
@@ -1428,7 +1428,7 @@ ib_cache_update(struct ib_device *device, u8 port, bool	enforce_security)
 		}
 	}
 
-	write_lock_irq(&device->cache.lock);
+	write_lock_irq(&device->cache_lock);
 
 	old_pkey_cache = device->port_data[port].cache.pkey;
 
@@ -1437,7 +1437,7 @@ ib_cache_update(struct ib_device *device, u8 port, bool	enforce_security)
 	device->port_data[port].cache.port_state = tprops->state;
 
 	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
-	write_unlock_irq(&device->cache.lock);
+	write_unlock_irq(&device->cache_lock);
 
 	if (enforce_security)
 		ib_security_cache_change(device,
@@ -1495,7 +1495,7 @@ int ib_cache_setup_one(struct ib_device *device)
 	unsigned int p;
 	int err;
 
-	rwlock_init(&device->cache.lock);
+	rwlock_init(&device->cache_lock);
 
 	err = gid_table_setup_one(device);
 	if (err)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6604115f7c85..d78abb616096 100644
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

