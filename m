Return-Path: <linux-rdma+bounces-15288-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DAFCF10B1
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 14:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 097933040A40
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6E30DD25;
	Sun,  4 Jan 2026 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6BDGzwS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C07238159;
	Sun,  4 Jan 2026 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767534728; cv=none; b=TZbT3q11LUTZxUMd6Rg9fRIux5Gn741UkYEc1wLM81P8+fiUgiNRw/j5VLIFfWWbITOLsCjG3ILtUkNTgylzoj+09h4T6Zm0Tf6oUGcQ4mf3OcAk6xZS9BB38tZrWAcSvFmMBgW5RBF5P9AEE1+KFXmN7sc2FXSkTz5B0lihu10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767534728; c=relaxed/simple;
	bh=Sqsm7E4FnC30GhaI3axA8ZSOLdQDpG9lmUCjOyWWT5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hg28kL+zNbTBcfRVikPKHD1RJFgC5hV9klm/TVlyVbNtZua8kZehTzDE0aW8exCPwTVRnoRcIg8TohesDkXoDpQwKJRhpaIuEUAZjffRYuIiLLLYWP/PxWjDIIvuu5cdp10lBhx38Nc+fO0Mz4iGvJg/idBi4PgqVnktkGqiMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6BDGzwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB89C19422;
	Sun,  4 Jan 2026 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767534725;
	bh=Sqsm7E4FnC30GhaI3axA8ZSOLdQDpG9lmUCjOyWWT5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J6BDGzwSXiyN63U+jblrpW7KqdC4QKxBCmYJGo0tMn/FR9F91qDY0i7m2itqhNeP3
	 bNRMxQNG7+bAzaxDLnCQRaw78sQRSsdD2OOE8SU72XuZKuQhY5sEXEsD5jndiOvUvx
	 v8qqjpHCN1hCAbBTb5vt9pWkLU6t87RKbXwi47bAk9gXPhqm9iHckc9RjOEmyXo/Iv
	 TfU4vERYrb1yVlqsw+Wvq3JnXAf5Vmh/wGzrPGmohjsHmONiik0OPqrciMDXNj9bAk
	 JvyLHkvaH4DbPN/cai9/DJk7bnOHpKMW7/tOoYln1G2AYkMdCum7+MfmcEXeSuFVDe
	 rc5eaJr+XJvhQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next 2/6] RDMA/core: Avoid exporting module local functions and remove not-used ones
Date: Sun,  4 Jan 2026 15:51:34 +0200
Message-ID: <20260104-ib-core-misc-v1-2-00367f77f3a8@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
References: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Some of the functions are local to the module and some are not used
starting from commit 36783dec8d79 ("RDMA/rxe: Delete deprecated module
parameters interface"). Delete and avoid exporting them.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c | 30 ------------------------------
 include/rdma/ib_verbs.h          |  2 --
 2 files changed, 32 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 13e8a1714bbd..0b0efa9d93aa 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -361,34 +361,6 @@ static struct ib_device *__ib_device_get_by_name(const char *name)
 	return NULL;
 }
 
-/**
- * ib_device_get_by_name - Find an IB device by name
- * @name: The name to look for
- * @driver_id: The driver ID that must match (RDMA_DRIVER_UNKNOWN matches all)
- *
- * Find and hold an ib_device by its name. The caller must call
- * ib_device_put() on the returned pointer.
- */
-struct ib_device *ib_device_get_by_name(const char *name,
-					enum rdma_driver_id driver_id)
-{
-	struct ib_device *device;
-
-	down_read(&devices_rwsem);
-	device = __ib_device_get_by_name(name);
-	if (device && driver_id != RDMA_DRIVER_UNKNOWN &&
-	    device->ops.driver_id != driver_id)
-		device = NULL;
-
-	if (device) {
-		if (!ib_device_try_get(device))
-			device = NULL;
-	}
-	up_read(&devices_rwsem);
-	return device;
-}
-EXPORT_SYMBOL(ib_device_get_by_name);
-
 static int rename_compat_devs(struct ib_device *device)
 {
 	struct ib_core_device *cdev;
@@ -2875,7 +2847,6 @@ int ib_add_sub_device(struct ib_device *parent,
 
 	return ret;
 }
-EXPORT_SYMBOL(ib_add_sub_device);
 
 int ib_del_sub_device_and_put(struct ib_device *sub)
 {
@@ -2894,7 +2865,6 @@ int ib_del_sub_device_and_put(struct ib_device *sub)
 
 	return 0;
 }
-EXPORT_SYMBOL(ib_del_sub_device_and_put);
 
 #ifdef CONFIG_INFINIBAND_VIRT_DMA
 int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6aad66bc5dd7..e92bf2e44fd8 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4545,8 +4545,6 @@ static inline bool ib_device_try_get(struct ib_device *dev)
 void ib_device_put(struct ib_device *device);
 struct ib_device *ib_device_get_by_netdev(struct net_device *ndev,
 					  enum rdma_driver_id driver_id);
-struct ib_device *ib_device_get_by_name(const char *name,
-					enum rdma_driver_id driver_id);
 struct net_device *ib_get_net_dev_by_params(struct ib_device *dev, u32 port,
 					    u16 pkey, const union ib_gid *gid,
 					    const struct sockaddr *addr);

-- 
2.52.0


