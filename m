Return-Path: <linux-rdma+bounces-14547-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB53C656FF
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 18:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 861B22B103
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC13332917;
	Mon, 17 Nov 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cSIwGULI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113032F746
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399576; cv=none; b=V8A2s92NL1AL/fyC7i/8VLVREUf+/BxJavW/1cVpFDtvhs8DiUbvGJyZjqK2PMTtQrFrLeHahMYybpYUM9idl7YE7ZiB07Jax0zjZP8Rw1Ejl/+K9PqCdW6/PwcJ1H0TLeTKhHI57VSJS6ypdudW91+vhOHo9CsCEFoJSaE16w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399576; c=relaxed/simple;
	bh=nDHz3eC1FzpL6uA+juCEMKu81/1+1H/sZuhqNVV3xhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hK+efb9rTxp9FxGmMjec5gGyJWvHLBdhUGYKpzGlLPVAtaHFEbTCwIzToPr+q1JpTxThE+CkfzsGr1ATgDsLNt6PYj/aqomfrOHl2IE5F65IseuRz4vOYPqtze+G1MZg1a6/0ZN/I8awtzDgvJlJS11Uq0/pIQ/vISLCrLClea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cSIwGULI; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-298145fe27eso60033335ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 09:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399571; x=1764004371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkWTvp5BJ0Zz51pZ2oS2FhCEN4QHYE9K3JJ+RWZxqd0=;
        b=CFT+DW918xLqzZLC69neYeW/M439e6ODHEoRlE72E6xP4AIABn+SzVzqLZh+AAAI13
         9hGZ3F1QyAHt8a0NHq3Lw1y+v+xFIvXUhgEsplyx3C5koqRgijOCyPXZnc3a8ZONSRqA
         4+BE6TgaTQ4nB8teRaCb7NeFNT8qsdmTILhoPhNPF+g+bZN7/O2BVNrwcPCmY4wmdwl3
         GH5nGtikkahXPf7sAOFv/jGsKvx2i2U8IrSnvSd9no2hlrkRPADE9y/7xrOwoY1+Pbe8
         2gvFnyDRw7SpSfOWaP2j2Dx0+5Sy4bP9GPtl/hRKRcq99hRSkV1LgjFAEv5FQV4PEJP9
         laeg==
X-Gm-Message-State: AOJu0Yz87h2lz1v7WUXP/EMKWS0J2kOino8YHeqr8WTbz7cVlO/rg8P2
	wHErpyMoew/SHJvKFkBi4tTXnIiuJVCZzsuQI8y8PVAF+J7rSkt5+3DUjlHPc9LGQDUeceK5IVs
	8LaOxZdCbGcc7/0damenfxiIE/imJYPaKLgCyRSOIsPxM9+zg8LkqJM0TuzFX1eXXjnqAQXWooi
	JBwwNZUpBmEAFMrOXtvgrvwkl3k5WlMNywMY4Jw56sxTfkZHMm7Kkm+WjRdyOPewoOQO3MMhHe0
	6GdMBv8cW4PBT2nEw==
X-Gm-Gg: ASbGncsH/FTvHXvg4S5Jifav2PuiUvp5NXnzjClR2d4O82AjSNRyvjTx51vhHDv4GZc
	rjBwVTzIq5tbcAyzBi3rz+RwfTVh+HuY3rkOk6MtNX5tWFAKEwmhC7526SKAZUstdXiVbSTGW2R
	cauT/KoxNcBKywNqJvSVcOU2MpOQawPP6RJ66xKo7sx+xcjmjvLt9l2PicXTBYwTdPK/gOBrC7p
	6HalgSAsgYvGcQUu5FleKNLRwv+MeyNRmgY6OvEOfNhEMZAc9tR6TGSE4GMQZpkJ7HrkX06D+dU
	p+iBAHRFjCMl6f2T/KHgKlSryemskbU33DaHJ6kEbGtMMfaInSnxdasklL5ANFrhi012yrjGuol
	aovZyEboyQMrkh9Qr0S8tRFFqdHrfFS5ljMqRfd6zQH/lmOTd1jMScwBytgH22JtnBWBObYK0yv
	wRIg71rOj5624AxezweWouZO6jcgsHKqDM
X-Google-Smtp-Source: AGHT+IH9QBcA4nRAud0xzDLOgwTWK56OKW2df7WlWCX4mGnSTtmoF5Nl/FO44BORauiAZBuIp5R7TWFcd4WO
X-Received: by 2002:a17:903:2a8d:b0:290:c516:8c53 with SMTP id d9443c01a7336-2986a74fbe5mr160456075ad.40.1763399571411;
        Mon, 17 Nov 2025 09:12:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2985c2c3f52sm16082525ad.60.2025.11.17.09.12.51
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2025 09:12:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8823f71756dso61978546d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 09:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763399570; x=1764004370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkWTvp5BJ0Zz51pZ2oS2FhCEN4QHYE9K3JJ+RWZxqd0=;
        b=cSIwGULIVyyp1mVfU4OJTF1v2G4YJ46KTTvBAErN2tzBQt4OwAoGWqEI9aR0Pd0nZ5
         DTFuQgVclueFwgiTWsxKDZ8rAvvbqE9CIFsy19anhRoZYyz0oMO3kmegRxPZy1/x1Ntp
         MnJYGtw4jGWqEkzX0N13yjsNQSYUMuSN+RoyY=
X-Received: by 2002:a05:6214:d02:b0:87c:1ec5:841e with SMTP id 6a1803df08f44-882925a3fd2mr200879546d6.8.1763399570329;
        Mon, 17 Nov 2025 09:12:50 -0800 (PST)
X-Received: by 2002:a05:6214:d02:b0:87c:1ec5:841e with SMTP id 6a1803df08f44-882925a3fd2mr200878856d6.8.1763399569822;
        Mon, 17 Nov 2025 09:12:49 -0800 (PST)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314557sm96082236d6.20.2025.11.17.09.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:12:49 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	usman.ansari@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH v3 7/8] RDMA/bng_re: Add basic debugfs infrastructure
Date: Mon, 17 Nov 2025 17:11:25 +0000
Message-ID: <20251117171136.128193-8-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117171136.128193-1-siva.kallam@broadcom.com>
References: <20251117171136.128193-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add basic debugfs infrastructure for Broadcom next generation
controller.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 drivers/infiniband/hw/bng_re/Makefile      |  3 +-
 drivers/infiniband/hw/bng_re/bng_debugfs.c | 39 ++++++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_debugfs.h | 12 +++++++
 drivers/infiniband/hw/bng_re/bng_dev.c     | 12 +++++++
 drivers/infiniband/hw/bng_re/bng_re.h      |  1 +
 5 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.h

diff --git a/drivers/infiniband/hw/bng_re/Makefile b/drivers/infiniband/hw/bng_re/Makefile
index 556b763b43f9..c6aaaf853c77 100644
--- a/drivers/infiniband/hw/bng_re/Makefile
+++ b/drivers/infiniband/hw/bng_re/Makefile
@@ -4,4 +4,5 @@ ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnge -I $(srctree)/driv
 obj-$(CONFIG_INFINIBAND_BNG_RE) += bng_re.o
 
 bng_re-y := bng_dev.o bng_fw.o \
-	    bng_res.o bng_sp.o
+	    bng_res.o bng_sp.o \
+	    bng_debugfs.o
diff --git a/drivers/infiniband/hw/bng_re/bng_debugfs.c b/drivers/infiniband/hw/bng_re/bng_debugfs.c
new file mode 100644
index 000000000000..9ec5a8785250
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_debugfs.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+#include <linux/debugfs.h>
+#include <linux/pci.h>
+
+#include <rdma/ib_verbs.h>
+
+#include "bng_res.h"
+#include "bng_fw.h"
+#include "bnge.h"
+#include "bnge_auxr.h"
+#include "bng_re.h"
+#include "bng_debugfs.h"
+
+static struct dentry *bng_re_debugfs_root;
+
+void bng_re_debugfs_add_pdev(struct bng_re_dev *rdev)
+{
+	struct pci_dev *pdev = rdev->aux_dev->pdev;
+
+	rdev->dbg_root =
+		debugfs_create_dir(dev_name(&pdev->dev), bng_re_debugfs_root);
+}
+
+void bng_re_debugfs_rem_pdev(struct bng_re_dev *rdev)
+{
+	debugfs_remove_recursive(rdev->dbg_root);
+	rdev->dbg_root = NULL;
+}
+
+void bng_re_register_debugfs(void)
+{
+	bng_re_debugfs_root = debugfs_create_dir("bng_re", NULL);
+}
+
+void bng_re_unregister_debugfs(void)
+{
+	debugfs_remove(bng_re_debugfs_root);
+}
diff --git a/drivers/infiniband/hw/bng_re/bng_debugfs.h b/drivers/infiniband/hw/bng_re/bng_debugfs.h
new file mode 100644
index 000000000000..baef71df4242
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_debugfs.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2025 Broadcom.
+
+#ifndef __BNG_RE_DEBUGFS__
+#define __BNG_RE_DEBUGFS__
+
+void bng_re_debugfs_add_pdev(struct bng_re_dev *rdev);
+void bng_re_debugfs_rem_pdev(struct bng_re_dev *rdev);
+
+void bng_re_register_debugfs(void);
+void bng_re_unregister_debugfs(void);
+#endif
diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index cdebe408f50f..9dbd8837457d 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -14,6 +14,7 @@
 #include "bnge_auxr.h"
 #include "bng_re.h"
 #include "bnge_hwrm.h"
+#include "bng_debugfs.h"
 
 static char version[] =
 		BNG_RE_DESC "\n";
@@ -219,6 +220,7 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 
 static void bng_re_dev_uninit(struct bng_re_dev *rdev)
 {
+	bng_re_debugfs_rem_pdev(rdev);
 	bng_re_disable_rcfw_channel(&rdev->rcfw);
 	bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id,
 			     RING_ALLOC_REQ_RING_TYPE_NQ);
@@ -318,6 +320,9 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 	rc = bng_re_get_dev_attr(&rdev->rcfw);
 	if (rc)
 		goto disable_rcfw;
+
+	bng_re_debugfs_add_pdev(rdev);
+
 	return 0;
 disable_rcfw:
 	bng_re_disable_rcfw_channel(&rdev->rcfw);
@@ -424,17 +429,24 @@ static int __init bng_re_mod_init(void)
 
 	pr_info("%s: %s", BNG_ROCE_DRV_MODULE_NAME, version);
 
+	bng_re_register_debugfs();
+
 	rc = auxiliary_driver_register(&bng_re_driver);
 	if (rc) {
 		pr_err("%s: Failed to register auxiliary driver\n",
 		       BNG_ROCE_DRV_MODULE_NAME);
+		goto unreg_debugfs;
 	}
+	return 0;
+unreg_debugfs:
+	bng_re_unregister_debugfs();
 	return rc;
 }
 
 static void __exit bng_re_mod_exit(void)
 {
 	auxiliary_driver_unregister(&bng_re_driver);
+	bng_re_unregister_debugfs();
 }
 
 module_init(bng_re_mod_init);
diff --git a/drivers/infiniband/hw/bng_re/bng_re.h b/drivers/infiniband/hw/bng_re/bng_re.h
index 7598dd91043b..76837f17f12d 100644
--- a/drivers/infiniband/hw/bng_re/bng_re.h
+++ b/drivers/infiniband/hw/bng_re/bng_re.h
@@ -76,6 +76,7 @@ struct bng_re_dev {
 	struct bng_re_nq_record		*nqr;
 	/* Device Resources */
 	struct bng_re_dev_attr		*dev_attr;
+	struct dentry			*dbg_root;
 };
 
 #endif
-- 
2.43.0


