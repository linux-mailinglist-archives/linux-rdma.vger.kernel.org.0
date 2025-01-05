Return-Path: <linux-rdma+bounces-6817-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6DDA01998
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jan 2025 14:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F6E3A3223
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jan 2025 13:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA61914B955;
	Sun,  5 Jan 2025 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EhzFTUcb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF3514A4FB
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jan 2025 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736082871; cv=none; b=r9w3kGupuoqwzd8MVHIjLr+zpgYOw0oRtfP4GZCuvlwnyjV35aCrDErjuBe0Aev2mNeW9/vlqaOUywljR9cwxSKJZnhxMSW/JbYa1y13whrsC41f7Ke+VgpjM1AdQ5J+dd6GavidLP0wIRx1cIeWfyc3d/ofHK/U9rOUtYb72hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736082871; c=relaxed/simple;
	bh=qyZDjZEuTEjXoFmT3AF5ipKKGTBcWQ+KJbYq89jWE5o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hvEj6C1H9i/CLFrS9mJYnpupO9NqOBaqZrU/Hf8Bh7nGNeme742CxH6c5ac5lZiLAyWhCyTF2Z6VeZ57sEnoawikMN+NbJ48qm5l+ICjKedvQ956VH5SqYBx5HlhIis8oPKMW8pmYa7adHFaDjwJnlf6DSDsMjRY6JTF5nKsHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EhzFTUcb; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736082871; x=1767618871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ozzemAjr3be8SxKA5VXEt7FgHyueIIYaOmrUipJQmOU=;
  b=EhzFTUcbt/fGMwAYWMQ7aIlVpJw+sl+mdWMwvnoLYwDdnITmmOfLTz5K
   JQdxVDgEWfrZ3bUj1EAQ4pNKBfUaBgG8CV9ZIcgHOJ/MXIjjMXsTZW7Mp
   5tdelrG7fw1XhqnKqdkShYG0KsaL1Lmcb+D9S9ErA7zRznxihXsoRxB9X
   c=;
X-IronPort-AV: E=Sophos;i="6.12,290,1728950400"; 
   d="scan'208";a="461794405"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 13:14:28 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:57102]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.166:2525] with esmtp (Farcaster)
 id 0f5ab413-3f19-4bb0-a650-96a681f3c576; Sun, 5 Jan 2025 13:14:24 +0000 (UTC)
X-Farcaster-Flow-ID: 0f5ab413-3f19-4bb0-a650-96a681f3c576
Received: from EX19D013EUA001.ant.amazon.com (10.252.50.140) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 5 Jan 2025 13:14:24 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D013EUA001.ant.amazon.com (10.252.50.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 5 Jan 2025 13:14:23 +0000
Received: from email-imr-corp-prod-pdx-all-2c-475d797d.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Sun, 5 Jan 2025 13:14:23 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com (dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com [10.253.69.224])
	by email-imr-corp-prod-pdx-all-2c-475d797d.us-west-2.amazon.com (Postfix) with ESMTP id CE1F5A039F;
	Sun,  5 Jan 2025 13:14:21 +0000 (UTC)
From: <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>, Daniel Kranzdorf
	<dkkranzd@amazon.com>, "Michael Margolin" <mrgolin@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Align interrupt related fields to same type
Date: Sun, 5 Jan 2025 13:14:21 +0000
Message-ID: <20250105131421.29030-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Yonatan Nachum <ynachum@amazon.com>

There is a lot of implicit casting of interrupt related fields. Use
u32 as common type since this is what the device use as type for max
supported EQs and what IB core expects in num_comp_vectors field.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h      |  8 ++++----
 drivers/infiniband/hw/efa/efa_com.h  |  6 +++---
 drivers/infiniband/hw/efa/efa_main.c | 19 +++++++------------
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index d7fc9d5eeefd..838182d0409c 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_H_
@@ -57,15 +57,15 @@ struct efa_dev {
 	u64 db_bar_addr;
 	u64 db_bar_len;
 
-	unsigned int num_irq_vectors;
-	int admin_msix_vector_idx;
+	u32 num_irq_vectors;
+	u32 admin_msix_vector_idx;
 	struct efa_irq admin_irq;
 
 	struct efa_stats stats;
 
 	/* Array of completion EQs */
 	struct efa_eq *eqs;
-	unsigned int neqs;
+	u32 neqs;
 
 	/* Only stores CQs with interrupts enabled */
 	struct xarray cqs_xa;
diff --git a/drivers/infiniband/hw/efa/efa_com.h b/drivers/infiniband/hw/efa/efa_com.h
index 77282234ce68..4d9ca97e4296 100644
--- a/drivers/infiniband/hw/efa/efa_com.h
+++ b/drivers/infiniband/hw/efa/efa_com.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_COM_H_
@@ -65,7 +65,7 @@ struct efa_com_admin_queue {
 	u16 depth;
 	struct efa_com_admin_cq cq;
 	struct efa_com_admin_sq sq;
-	u16 msix_vector_idx;
+	u32 msix_vector_idx;
 
 	unsigned long state;
 
@@ -89,7 +89,7 @@ struct efa_com_aenq {
 	struct efa_aenq_handlers *aenq_handlers;
 	dma_addr_t dma_addr;
 	u32 cc; /* consumer counter */
-	u16 msix_vector_idx;
+	u32 msix_vector_idx;
 	u16 depth;
 	u8 phase;
 };
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 45a4564c670c..4f03c0ec819f 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -141,8 +141,7 @@ static int efa_request_irq(struct efa_dev *dev, struct efa_irq *irq)
 	return 0;
 }
 
-static void efa_setup_comp_irq(struct efa_dev *dev, struct efa_eq *eq,
-			       int vector)
+static void efa_setup_comp_irq(struct efa_dev *dev, struct efa_eq *eq, u32 vector)
 {
 	u32 cpu;
 
@@ -305,7 +304,7 @@ static void efa_destroy_eq(struct efa_dev *dev, struct efa_eq *eq)
 	efa_free_irq(dev, &eq->irq);
 }
 
-static int efa_create_eq(struct efa_dev *dev, struct efa_eq *eq, u8 msix_vec)
+static int efa_create_eq(struct efa_dev *dev, struct efa_eq *eq, u32 msix_vec)
 {
 	int err;
 
@@ -328,21 +327,17 @@ static int efa_create_eq(struct efa_dev *dev, struct efa_eq *eq, u8 msix_vec)
 
 static int efa_create_eqs(struct efa_dev *dev)
 {
-	unsigned int neqs = dev->dev_attr.max_eq;
-	int err;
-	int i;
-
-	neqs = min_t(unsigned int, neqs,
-		     dev->num_irq_vectors - EFA_COMP_EQS_VEC_BASE);
+	u32 neqs = dev->dev_attr.max_eq;
+	int err, i;
 
+	neqs = min_t(u32, neqs, dev->num_irq_vectors - EFA_COMP_EQS_VEC_BASE);
 	dev->neqs = neqs;
 	dev->eqs = kcalloc(neqs, sizeof(*dev->eqs), GFP_KERNEL);
 	if (!dev->eqs)
 		return -ENOMEM;
 
 	for (i = 0; i < neqs; i++) {
-		err = efa_create_eq(dev, &dev->eqs[i],
-				    i + EFA_COMP_EQS_VEC_BASE);
+		err = efa_create_eq(dev, &dev->eqs[i], i + EFA_COMP_EQS_VEC_BASE);
 		if (err)
 			goto err_destroy_eqs;
 	}
-- 
2.40.1


