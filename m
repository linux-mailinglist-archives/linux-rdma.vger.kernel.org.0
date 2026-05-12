Return-Path: <linux-rdma+bounces-20458-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BcKOpHIAmrQwgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20458-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 08:28:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E52E51B00D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 08:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08D6A3135F78
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 06:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D616F47AF5F;
	Tue, 12 May 2026 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jZpWEPBF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EEC4657DB
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566326; cv=none; b=oGLW/sRDKeRuC1M/umvyQFKdFiXKwf+Fa5qyXBDfKTVDm7qed9fT9mjA2f7cWGPwBowNz+oAZxX80UtUT4b+PE54OmWkU1hjVDu+Pbg7koPt2amvsJyKhrJl3LvdhMlXmkzma0663LoWtnygh+qtGZ0kyg3Onap+C05VvsCbzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566326; c=relaxed/simple;
	bh=rgoHEeeUVc0f6TjLEYUDiowNzF2G3tjQJ2F/Ps9G5Go=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1212HyZtZ5ZshbZ7wzOpapjF/ahd5BZJUlBzBu7TYCeKxxus1WWijySAVK9CUpLxuJjy1OzhtT69yBd14el9aX4pvz9NkdUVpIc8w6tzdoK4/ZHi/XBfDZhq1d6HwyCS/5P6wHYF03VfuYX1ZURjwu9n0duk6dOC8jFZUziNVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jZpWEPBF; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778566314; x=1810102314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FH9CQyC2g26QvS3wuEKQ/qlYxWVv6Gld0CzXFlHB48A=;
  b=jZpWEPBFyNR1VXcLpWS9sXoAQOIEe8F7VWcb+e/O8Gk9nlsLD9u7Zhs/
   2tftti7j4+YRFRg6WSIEW9O1QnC67fPCToq3ea8k3HlBk2ivZaiA62E/h
   roWoIKTHQxQkcacg8L0BM0DSFo6+po+PZWkTpcI7tCkWJCVQLtUJ03lqR
   gj9y39J8wnoxO/7W9vTVTX5W7qlS9ugWbw2pfGV1p2L7idK33CywQkAqy
   xAP288NYtV+ugC4bivN37IxlQX6C1D9DsgFmO1zgpJ9VCam0AlyZzluhW
   IXI2mhFg8x0sAPI2Ooyao93mwhMRVeljJ1EOHfR5Qt4lIiki3g1rVx1gB
   w==;
X-CSE-ConnectionGUID: FWlDAhsoQTe7ksBr5YVvQw==
X-CSE-MsgGUID: ZeRkRgjNQvu9v3tue7Wleg==
X-IronPort-AV: E=Sophos;i="6.23,230,1770595200"; 
   d="scan'208";a="19305414"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:11:48 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:13581]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.227:2525] with esmtp (Farcaster)
 id 1b577752-ead6-4b90-a506-40bbe8d7ba16; Tue, 12 May 2026 06:11:47 +0000 (UTC)
X-Farcaster-Flow-ID: 1b577752-ead6-4b90-a506-40bbe8d7ba16
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 12 May 2026 06:11:47 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 12 May 2026
 06:11:45 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>, Firas Jahjah
	<firasj@amazon.com>
Subject: [PATCH for-next v2 1/2] RDMA/efa: Add initialization of AH cache rhashtable
Date: Tue, 12 May 2026 06:11:20 +0000
Message-ID: <20260512061121.2177521-2-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260512061121.2177521-1-ynachum@amazon.com>
References: <20260512061121.2177521-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 4E52E51B00D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20458-lists,linux-rdma=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

New EFA devices don't support the creation of multiple address handles
to the same remote on the same PD.
To overcome this limitation, introduce an AH cache rhashtable which will
store the refcounts of the same AH creation on the same PD and will
allow the driver to manage AH reuse. The hashtable key is the
combination of PD and GID. Add initialization and teardown logic for the
rhashtable.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/Makefile       |  4 +--
 drivers/infiniband/hw/efa/efa_ah_cache.c | 30 ++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_ah_cache.h | 36 ++++++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_com.c      | 12 +++++++-
 drivers/infiniband/hw/efa/efa_com.h      |  5 +++-
 5 files changed, 83 insertions(+), 4 deletions(-)
 create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
 create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h

diff --git a/drivers/infiniband/hw/efa/Makefile b/drivers/infiniband/hw/efa/Makefile
index 6e83083af0bc..a6a433b0ba2f 100644
--- a/drivers/infiniband/hw/efa/Makefile
+++ b/drivers/infiniband/hw/efa/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
-# Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+# Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
 #
 # Makefile for Amazon Elastic Fabric Adapter (EFA) device driver.
 #
 
 obj-$(CONFIG_INFINIBAND_EFA) += efa.o
 
-efa-y := efa_com_cmd.o efa_com.o efa_main.o efa_verbs.o
+efa-y := efa_com_cmd.o efa_ah_cache.o efa_com.o efa_main.o efa_verbs.o
diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.c b/drivers/infiniband/hw/efa/efa_ah_cache.c
new file mode 100644
index 000000000000..d31871eb9748
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_ah_cache.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright 2026 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#include "efa_ah_cache.h"
+
+static const struct rhashtable_params ah_cache_params = {
+	.key_len = sizeof(struct efa_ah_cache_key),
+	.key_offset = offsetof(struct efa_ah_cache_entry, key),
+	.head_offset = offsetof(struct efa_ah_cache_entry, linkage),
+};
+
+int efa_ah_cache_init(struct efa_ah_cache *ah_cache)
+{
+	int err;
+
+	mutex_init(&ah_cache->lock);
+	err = rhashtable_init(&ah_cache->hashtable, &ah_cache_params);
+	if (err)
+		mutex_destroy(&ah_cache->lock);
+
+	return err;
+}
+
+void efa_ah_cache_destroy(struct efa_ah_cache *ah_cache)
+{
+	rhashtable_destroy(&ah_cache->hashtable);
+	mutex_destroy(&ah_cache->lock);
+}
diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.h b/drivers/infiniband/hw/efa/efa_ah_cache.h
new file mode 100644
index 000000000000..25288fdf778a
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_ah_cache.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright 2026 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef _EFA_AH_CACHE_H_
+#define _EFA_AH_CACHE_H_
+
+#include <linux/refcount.h>
+#include <linux/rhashtable.h>
+
+#define EFA_AH_GID_SIZE 16
+
+struct efa_ah_cache_key {
+	u8 gid[EFA_AH_GID_SIZE];
+	u16 pd;
+};
+
+struct efa_ah_cache_entry {
+	struct efa_ah_cache_key key;
+	u16 ah;
+	bool initialized;
+	refcount_t refcount;
+	struct rhash_head linkage;
+	struct mutex lock; /* Serializes device commands per cache entry */
+};
+
+struct efa_ah_cache {
+	struct rhashtable hashtable;
+	struct mutex lock; /* Protects AH cache hashtable */
+};
+
+int efa_ah_cache_init(struct efa_ah_cache *ah_cache);
+void efa_ah_cache_destroy(struct efa_ah_cache *ah_cache);
+
+#endif /* _EFA_AH_CACHE_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index e97b5f0d7003..b9b922583709 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -688,6 +688,8 @@ void efa_com_admin_destroy(struct efa_com_dev *edev)
 
 	size = aenq->depth * sizeof(*aenq->entries);
 	dma_free_coherent(edev->dmadev, size, aenq->entries, aenq->dma_addr);
+
+	efa_ah_cache_destroy(&edev->ah_cache);
 }
 
 /**
@@ -746,6 +748,12 @@ int efa_com_admin_init(struct efa_com_dev *edev,
 		return -ENODEV;
 	}
 
+	err = efa_ah_cache_init(&edev->ah_cache);
+	if (err) {
+		ibdev_err(edev->efa_dev, "Failed to init AH cache\n");
+		return err;
+	}
+
 	aq->depth = EFA_ADMIN_QUEUE_DEPTH;
 
 	aq->dmadev = edev->dmadev;
@@ -758,7 +766,7 @@ int efa_com_admin_init(struct efa_com_dev *edev,
 
 	err = efa_com_init_comp_ctxt(aq);
 	if (err)
-		return err;
+		goto err_destroy_ah_cache;
 
 	err = efa_com_admin_init_sq(edev);
 	if (err)
@@ -796,6 +804,8 @@ int efa_com_admin_init(struct efa_com_dev *edev,
 			  aq->sq.entries, aq->sq.dma_addr);
 err_destroy_comp_ctxt:
 	devm_kfree(edev->dmadev, aq->comp_ctx);
+err_destroy_ah_cache:
+	efa_ah_cache_destroy(&edev->ah_cache);
 
 	return err;
 }
diff --git a/drivers/infiniband/hw/efa/efa_com.h b/drivers/infiniband/hw/efa/efa_com.h
index 4d9ca97e4296..dc365df7f3dd 100644
--- a/drivers/infiniband/hw/efa/efa_com.h
+++ b/drivers/infiniband/hw/efa/efa_com.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_COM_H_
@@ -14,6 +14,7 @@
 
 #include <rdma/ib_verbs.h>
 
+#include "efa_ah_cache.h"
 #include "efa_common_defs.h"
 #include "efa_admin_defs.h"
 #include "efa_admin_cmds_defs.h"
@@ -112,6 +113,8 @@ struct efa_com_dev {
 	u32 supported_features;
 	u32 dma_addr_bits;
 
+	struct efa_ah_cache ah_cache;
+
 	struct efa_com_mmio_read mmio_read;
 };
 
-- 
2.50.1


