Return-Path: <linux-rdma+bounces-22541-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8yBgMQgjQWpClQkAu9opvQ
	(envelope-from <linux-rdma+bounces-22541-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 15:35:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 655EB6D3E88
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 15:35:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b="nLC/7Vft";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22541-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22541-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AE84300EAA8
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CA23A6418;
	Sun, 28 Jun 2026 13:34:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BC352007
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jun 2026 13:34:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782653689; cv=none; b=mKXOlNobxX1b+jskiIRmNGqrVK+axHZP/qTUuxwCcDDVLRD/99U1HPUcLWn095yZAkjpPxQWw00qaKV6bLGO+55tc5p78nD6odbMrWNgE64djbPdJw6XPurR3uwE/CAg27BPdsTSaZb+4jXYUJmztIICcEO0aqaXir/e9DUvwvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782653689; c=relaxed/simple;
	bh=yjahR6nL2C9zXmkL3qDlFdRhOtpUGsLkQJQfXtJyG5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oen6/iiQCYy4HNA1ZrTeWoyOsOJKtCwX29zbHJ8c4CPiQIj5VGcyYhlsnZxzuXLR02QtFjdVUw9DiypVwhqQicxg0Ur2oUanZOsjrMQ2jkHtu4SZeQkdhtXHavfK8aYuFXIVWAseaQYnbdFXjnCPTWNpriFXCSyTmxw+EO5nZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nLC/7Vft; arc=none smtp.client-ip=44.246.68.102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1782653687; x=1814189687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oAvSPJglDMVtv7sigpLyw00HlHCIbvlKnWf62d8OX9k=;
  b=nLC/7Vftq/g/GzYDmdGUFECJjlc7J94JydFUND9QZo/LTzvCmX7NkuY6
   PAUQShmq1rux8AkBYywW4uQETLJozcNIvwgAZBHn8Ve+spDmFHMUKORDA
   7kndK6Lm0YsS909pm4pqmMCLxfYK5wORplV6iBj1SZHxhwzxzcS56JnnN
   G4t/ZsrkQXrqHGxW2P4iszmZFbX3cquKxzciN1OQZJyT9Lz8cY5IKmOvV
   i8K0cyDeKzyO+Ri/g2Uxv8WDyLVZ2tyfaPfGDtMKQJOE9LZH+hr9dHlWo
   vHAdGKZGlEkEH7mSAHhT+dl0qWXoX8aYm7ueQU8rjS9VMkQwqV6pqpS0n
   g==;
X-CSE-ConnectionGUID: qq+ULauSTYWzhfJsRh7z6g==
X-CSE-MsgGUID: ZFVYrmzbR9eWuCjVk3wJGg==
X-IronPort-AV: E=Sophos;i="6.24,230,1774310400"; 
   d="scan'208";a="22663735"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 13:34:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:15602]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.145:2525] with esmtp (Farcaster)
 id 995ef632-c565-4593-b8cc-b2f2a1365502; Sun, 28 Jun 2026 13:34:44 +0000 (UTC)
X-Farcaster-Flow-ID: 995ef632-c565-4593-b8cc-b2f2a1365502
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 28 Jun 2026 13:34:44 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Sun, 28 Jun 2026
 13:34:42 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>, Firas Jahjah
	<firasj@amazon.com>
Subject: [PATCH for-next v5 1/2] RDMA/efa: Add initialization of AH cache rhashtable
Date: Sun, 28 Jun 2026 13:34:21 +0000
Message-ID: <20260628133422.523230-2-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260628133422.523230-1-ynachum@amazon.com>
References: <20260628133422.523230-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,m:firasj@amazon.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22541-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 655EB6D3E88

New EFA devices don't support the creation of multiple address handles
to the same remote on the same PD.
To overcome this limitation, introduce an AH cache rhashtable which will
store the user refcounts of the same AH creation on the same PD and will
allow the driver to manage AH reuse. The hashtable key is the
combination of PD and GID. Add initialization and teardown logic for the
rhashtable.

Each entry holds a refcount to manage the entry lifetime in the
hashtable and a user count that indicates how many users are using the
address handle.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/Makefile       |  4 +--
 drivers/infiniband/hw/efa/efa_ah_cache.c | 42 ++++++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_ah_cache.h | 37 +++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_com.c      | 12 ++++++-
 drivers/infiniband/hw/efa/efa_com.h      |  3 ++
 5 files changed, 95 insertions(+), 3 deletions(-)
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
index 000000000000..73e810678767
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_ah_cache.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Copyright 2026 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#include <linux/slab.h>
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
+static void efa_ah_cache_entry_free(void *ptr, void *arg)
+{
+	struct efa_ah_cache_entry *entry = ptr;
+
+	WARN_ON(entry->usecnt);
+	mutex_destroy(&entry->lock);
+	kfree(entry);
+}
+
+void efa_ah_cache_destroy(struct efa_ah_cache *ah_cache)
+{
+	rcu_barrier();
+	rhashtable_free_and_destroy(&ah_cache->hashtable, efa_ah_cache_entry_free, NULL);
+	mutex_destroy(&ah_cache->lock);
+}
diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.h b/drivers/infiniband/hw/efa/efa_ah_cache.h
new file mode 100644
index 000000000000..42ba17a482c3
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_ah_cache.h
@@ -0,0 +1,37 @@
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
+	unsigned int usecnt;
+	refcount_t refcount;
+	struct rhash_head linkage;
+	struct rcu_head rcu_head;
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
index 7cc3f4af0bb9..7097d1c2f23d 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -724,6 +724,8 @@ void efa_com_admin_destroy(struct efa_com_dev *edev)
 
 	size = aenq->depth * sizeof(*aenq->entries);
 	dma_free_coherent(edev->dmadev, size, aenq->entries, aenq->dma_addr);
+
+	efa_ah_cache_destroy(&edev->ah_cache);
 }
 
 /**
@@ -782,6 +784,12 @@ int efa_com_admin_init(struct efa_com_dev *edev,
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
@@ -794,7 +802,7 @@ int efa_com_admin_init(struct efa_com_dev *edev,
 
 	err = efa_com_init_comp_ctxt(aq);
 	if (err)
-		return err;
+		goto err_destroy_ah_cache;
 
 	err = efa_com_admin_init_sq(edev);
 	if (err)
@@ -832,6 +840,8 @@ int efa_com_admin_init(struct efa_com_dev *edev,
 			  aq->sq.entries, aq->sq.dma_addr);
 err_destroy_comp_ctxt:
 	devm_kfree(edev->dmadev, aq->comp_ctx);
+err_destroy_ah_cache:
+	efa_ah_cache_destroy(&edev->ah_cache);
 
 	return err;
 }
diff --git a/drivers/infiniband/hw/efa/efa_com.h b/drivers/infiniband/hw/efa/efa_com.h
index f8c692b0e092..599db9d583bf 100644
--- a/drivers/infiniband/hw/efa/efa_com.h
+++ b/drivers/infiniband/hw/efa/efa_com.h
@@ -14,6 +14,7 @@
 
 #include <rdma/ib_verbs.h>
 
+#include "efa_ah_cache.h"
 #include "efa_common_defs.h"
 #include "efa_admin_defs.h"
 #include "efa_admin_cmds_defs.h"
@@ -113,6 +114,8 @@ struct efa_com_dev {
 	u32 supported_features;
 	u32 dma_addr_bits;
 
+	struct efa_ah_cache ah_cache;
+
 	u32 dev_api_ver;
 	struct efa_com_mmio_read mmio_read;
 };
-- 
2.50.1


