Return-Path: <linux-rdma+bounces-16762-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNKtIiKAjGl9pwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16762-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 14:12:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E011C124A95
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 14:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66070301E6F5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542E4357A5D;
	Wed, 11 Feb 2026 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Nv0uc4nN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE0322B6F
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815460; cv=none; b=nrUAIW2au6BxZKe4Eevx0noeMZUVSdzjFIb/eruP2/VDnTD34t73mFzXI6Szw+5uGmn4zLIz5vXsVhvsUCty0Mppx90opaJnm2b99Jd9LKabNqIDOxG9Y6aV+x7+6z7PWFU1kxJS8ivDW0Qr0lI9iPBAZZvfZYhHEq7JADnekmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815460; c=relaxed/simple;
	bh=bQkhmk5+Xr9MBrhgVWpFOLeZuToMlKzAipTCOw4CsAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LJCevLgNaD4nCAeAIsdHIFsvsCXHYdkgSx/teI6AKgTIpXVUTQUPWTg3U3SFxFEAQogsW2iz3omU9UINrHCYDGclOEHLThOY5EPyLuUwr0KpSk3hCjRPDxnfJxV+WubG+LA2TrvkOP/b8cKABQXxZdBdNAksP42L3I9xY4W0rM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Nv0uc4nN; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1770815458; x=1802351458;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h8QcQxulFOZq0XdRVD7F0NOfE40pEjOGUsYO1IXcA5w=;
  b=Nv0uc4nNsbNxxs66aUOrtEItZISjSvXKT3glqdQqeqR8Kv6fwnsCra2q
   1b2q+pK8KmtQwUkOowTgJomFrUWPiDRdpQQ519bm3oouK+6OdSTaIxh9x
   VoCzdOtsAXDg0SWgWKjXmKTo+FLZI5s+Z2kbE1y9xMcudbqpD/RUeRvpt
   N5DMgL9jxe2YgA5fpx4tK/0K8vDOpCzSnh0oaDDuZ/lZp5YIGUbyqxxmn
   6ozqYrNhGvG5rXPhrxEgAWR6B6T9dQJJuz6dgUNjySffio71K+fXGC4hx
   7VvBy968mMeYvbG1ygBEoQFwcB5n3gjoYrIcNWa6FZ9k5HyZVzDoD9eBg
   A==;
X-CSE-ConnectionGUID: 85eaQzioSte8eyYTXhMnYA==
X-CSE-MsgGUID: yTkFCd0sRGimBGJtmM2mAA==
X-IronPort-AV: E=Sophos;i="6.21,283,1763424000"; 
   d="scan'208";a="12859825"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 13:10:56 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:20797]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.62:2525] with esmtp (Farcaster)
 id 60341683-3f66-4de3-b642-7957f8256181; Wed, 11 Feb 2026 13:10:56 +0000 (UTC)
X-Farcaster-Flow-ID: 60341683-3f66-4de3-b642-7957f8256181
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 11 Feb 2026 13:10:55 +0000
Received: from dev-dsk-tomsela-1c-ce9cc34e.eu-west-1.amazon.com (10.15.30.17)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 11 Feb 2026 13:10:54 +0000
From: Tom Sela <tomsela@amazon.com>
To: <mrgolin@amazon.com>, <tomsela@amazon.com>, <jgg@nvidia.com>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs exposure
Date: Wed, 11 Feb 2026 13:10:48 +0000
Message-ID: <20260211131048.36217-1-tomsela@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16762-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tomsela@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E011C124A95
X-Rspamd-Action: no action

Add tracking of unique Address Handle usage to provide visibility into
active AH resource consumption. The implementation uses a hash table to
deduplicate identical AH requests that receive the same handle, ensuring
accurate resource counting.

The counter will be exposed via sysfs device attribute.

Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Tom Sela <tomsela@amazon.com>
---
 drivers/infiniband/hw/efa/Makefile    |  4 +-
 drivers/infiniband/hw/efa/efa.h       |  5 ++-
 drivers/infiniband/hw/efa/efa_main.c  | 13 ++++++-
 drivers/infiniband/hw/efa/efa_sysfs.c | 33 ++++++++++++++++
 drivers/infiniband/hw/efa/efa_sysfs.h | 15 +++++++
 drivers/infiniband/hw/efa/efa_verbs.c | 56 ++++++++++++++++++++++++++-
 6 files changed, 120 insertions(+), 6 deletions(-)
 create mode 100644 drivers/infiniband/hw/efa/efa_sysfs.c
 create mode 100644 drivers/infiniband/hw/efa/efa_sysfs.h

diff --git a/drivers/infiniband/hw/efa/Makefile b/drivers/infiniband/hw/efa/Makefile
index 6e83083af0bc..0ba04eab17a1 100644
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
+efa-y := efa_com_cmd.o efa_com.o efa_main.o efa_verbs.o efa_sysfs.o
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 96f9c3bc98b2..d332bc4edcb7 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_H_
@@ -69,6 +69,9 @@ struct efa_dev {
 
 	/* Only stores CQs with interrupts enabled */
 	struct xarray cqs_xa;
+	/* AH tracking xarray and counter*/
+	struct xarray ahs_xa;
+	atomic64_t ah_count;
 };
 
 struct efa_ucontext {
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 6c415b9adb5f..3c6fa5af941a 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -12,6 +12,7 @@
 #include <rdma/uverbs_ioctl.h>
 
 #include "efa.h"
+#include "efa_sysfs.h"
 
 #define PCI_DEV_ID_EFA0_VF 0xefa0
 #define PCI_DEV_ID_EFA1_VF 0xefa1
@@ -561,6 +562,8 @@ static struct efa_dev *efa_probe_device(struct pci_dev *pdev)
 	edev->dmadev = &pdev->dev;
 	dev->pdev = pdev;
 	xa_init(&dev->cqs_xa);
+	xa_init(&dev->ahs_xa);
+	atomic64_set(&dev->ah_count, 0);
 
 	pci_mem_bars = pci_select_bars(pdev, IORESOURCE_MEM);
 	if (EFA_BASE_BAR_MASK & ~pci_mem_bars) {
@@ -619,8 +622,14 @@ static struct efa_dev *efa_probe_device(struct pci_dev *pdev)
 	if (err)
 		goto err_free_mgmnt_irq;
 
+	err = efa_sysfs_init(dev);
+	if (err)
+		goto err_admin_destroy;
+
 	return dev;
 
+err_admin_destroy:
+	efa_com_admin_destroy(edev);
 err_free_mgmnt_irq:
 	efa_free_irq(dev, &dev->admin_irq);
 err_disable_msix:
@@ -645,6 +654,7 @@ static void efa_remove_device(struct pci_dev *pdev,
 	struct efa_com_dev *edev;
 
 	edev = &dev->edev;
+	efa_sysfs_destroy(dev);
 	efa_com_dev_reset(edev, reset_reason);
 	efa_com_admin_destroy(edev);
 	efa_free_irq(dev, &dev->admin_irq);
@@ -653,6 +663,7 @@ static void efa_remove_device(struct pci_dev *pdev,
 	devm_iounmap(&pdev->dev, edev->reg_bar);
 	efa_release_bars(dev, EFA_BASE_BAR_MASK);
 	xa_destroy(&dev->cqs_xa);
+	xa_destroy(&dev->ahs_xa);
 	ib_dealloc_device(&dev->ibdev);
 	pci_disable_device(pdev);
 }
diff --git a/drivers/infiniband/hw/efa/efa_sysfs.c b/drivers/infiniband/hw/efa/efa_sysfs.c
new file mode 100644
index 000000000000..79602cf77424
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_sysfs.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/sysfs.h>
+
+#include "efa_sysfs.h"
+
+static ssize_t ah_count_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct efa_dev *efa_dev = pci_get_drvdata(to_pci_dev(dev));
+
+	return sysfs_emit(buf, "%lld\n", atomic64_read(&efa_dev->ah_count));
+}
+
+static DEVICE_ATTR_RO(ah_count);
+
+int efa_sysfs_init(struct efa_dev *dev)
+{
+	struct device *device = &dev->pdev->dev;
+
+	if (device_create_file(device, &dev_attr_ah_count))
+		dev_err(device, "Failed to create AH count sysfs file\n");
+
+	return 0;
+}
+
+void efa_sysfs_destroy(struct efa_dev *dev)
+{
+	device_remove_file(&dev->pdev->dev, &dev_attr_ah_count);
+}
diff --git a/drivers/infiniband/hw/efa/efa_sysfs.h b/drivers/infiniband/hw/efa/efa_sysfs.h
new file mode 100644
index 000000000000..fda3a885c150
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_sysfs.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef _EFA_SYSFS_H_
+#define _EFA_SYSFS_H_
+
+#include "efa.h"
+
+int efa_sysfs_init(struct efa_dev *dev);
+
+void efa_sysfs_destroy(struct efa_dev *dev);
+
+#endif /* _EFA_SYSFS_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 22d3e25c3b9d..1d8cb4a7f946 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/dma-buf.h>
@@ -2104,6 +2104,51 @@ int efa_mmap(struct ib_ucontext *ibucontext,
 	return __efa_mmap(dev, ucontext, vma);
 }
 
+static int efa_add_ah(struct efa_dev *dev, u16 ah)
+{
+	unsigned long refcount;
+	void *entry;
+	int err;
+
+	xa_lock(&dev->ahs_xa);
+	entry = xa_load(&dev->ahs_xa, ah);
+	refcount = entry ? xa_to_value(entry) : 0;
+	if (refcount == 0)
+		atomic64_inc(&dev->ah_count);
+
+	err = xa_err(__xa_store(&dev->ahs_xa, ah, xa_mk_value(refcount + 1), GFP_ATOMIC));
+	xa_unlock(&dev->ahs_xa);
+
+	return err;
+}
+
+static int efa_remove_ah(struct efa_dev *dev, u16 ah)
+{
+	unsigned long refcount;
+	void *entry;
+	int err;
+
+	xa_lock(&dev->ahs_xa);
+	entry = xa_load(&dev->ahs_xa, ah);
+	refcount = entry ? xa_to_value(entry) : 0;
+	if (refcount == 0) {
+		/* AH already removed or never existed - unexpected but handle gracefully */
+		xa_unlock(&dev->ahs_xa);
+		return 0;
+	}
+
+	refcount--;
+
+	if (refcount == 0) {
+		err = xa_err(__xa_erase(&dev->ahs_xa, ah));
+		atomic64_dec(&dev->ah_count);
+	} else {
+		err = xa_err(__xa_store(&dev->ahs_xa, ah, xa_mk_value(refcount), GFP_ATOMIC));
+	}
+	xa_unlock(&dev->ahs_xa);
+	return err;
+}
+
 static int efa_ah_destroy(struct efa_dev *dev, struct efa_ah *ah)
 {
 	struct efa_com_destroy_ah_params params = {
@@ -2150,6 +2195,10 @@ int efa_create_ah(struct ib_ah *ibah,
 	memcpy(ah->id, ah_attr->grh.dgid.raw, sizeof(ah->id));
 	ah->ah = result.ah;
 
+	err = efa_add_ah(dev, ah->ah);
+	if (err)
+		goto err_destroy_ah;
+
 	resp.efa_address_handle = result.ah;
 
 	if (udata->outlen) {
@@ -2158,13 +2207,15 @@ int efa_create_ah(struct ib_ah *ibah,
 		if (err) {
 			ibdev_dbg(&dev->ibdev,
 				  "Failed to copy udata for create_ah response\n");
-			goto err_destroy_ah;
+			goto err_remove_ah;
 		}
 	}
 	ibdev_dbg(&dev->ibdev, "Created ah[%d]\n", ah->ah);
 
 	return 0;
 
+err_remove_ah:
+	efa_remove_ah(dev, ah->ah);
 err_destroy_ah:
 	efa_ah_destroy(dev, ah);
 err_out:
@@ -2185,6 +2236,7 @@ int efa_destroy_ah(struct ib_ah *ibah, u32 flags)
 		return -EOPNOTSUPP;
 	}
 
+	efa_remove_ah(dev, ah->ah);
 	efa_ah_destroy(dev, ah);
 	return 0;
 }
-- 
2.47.3


