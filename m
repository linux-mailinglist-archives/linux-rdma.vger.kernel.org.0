Return-Path: <linux-rdma+bounces-13575-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B378BB920A0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 17:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1186C2A6F47
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39672EC08A;
	Mon, 22 Sep 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b7Er1Bh3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BA02E7F2D
	for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555836; cv=none; b=aYD0Tcf3Yk14Jmh+KrNEvSQqme4EF8ipTCpBiWvzVLnqWpplwNvGhqtjiu1GHOSrzjcfddeOcWrFRSi8oDKlBL0L3ZyuKZU6wTyTeKbOFBdBQ556WMcmfnvGQySRBm9+EzjBAM834JCGZ3sPp0K4ltZhNrWjYreyIrTHrkK6V/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555836; c=relaxed/simple;
	bh=J4LifS0XFxE9XnnUkpq/M7Ahh2VjCfmc40Jk58R0ZCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmNbQonMB75YUjbNAvhS+BxfXLz5omSF+fwZ/BoHHC246fbNgWd2DwG5NtEShH3nkmqUW2ebdby9cs8hrmZmMgeJ8XcfbZ8Ku5Wm6EBx3Gb1UrDVjiWkbBjMBV370KfQt2oKz9O2WEMTC5QstnhWLp56h+wIYZP4jURrE3DKzvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b7Er1Bh3; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-84b9484c061so94100185a.3
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 08:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555834; x=1759160634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiAUve12B6y0VXa7aGKojambByjOg98b5E/1OlA7Abs=;
        b=PxXGAsOrsmhlK9e/2456fcLgdLd4mouxIgiij2P4bVfsxKSIg8BSHp56N1zN/jTu2U
         S4RCK3J/V5Sg9F+Uhlb+28RbZzW1fbTvWTdtVf2OoTix3570p/gqqCwp5x4GmO6y7wlo
         Jhew3YjO2fcgpQLL3MU1NzKFiBgXSAK+LYiSaR0qe6bEpZrPOZ8cCrVse8UHO1EF7Mu3
         QQeyWEbVoOWfnmXpFIR0tTRh8E/G92+VK+LENn2rVQwbCU4JKjpdLrEqiJp8Uq0uGniU
         cxNK2tQ71dNfP7guMlWTVsLPOtlvXt00vfRALjW+shIocNFcHsa4yn4PUBddKYg++cMp
         QHAQ==
X-Gm-Message-State: AOJu0YxGnXl/EyFgyxUjDUnTu7Dag423xsK3e53K+pNZc7JoqxcrxMvT
	4ZeRbZebclEI+y9aW3qf2vrkWuCs0JDWGBzKnjKS7M9QppwYjEoPJx2/m/4ckePYZd7ITjzzTFh
	NOM94jDNbhoxjD5kKDvAJCJZHhIBSzbtd1367lnm2AINm2upspDUloqPjJYzHCmni4szV+YRTnG
	9mKUwRlYAAMVycAvYcWPzDZ1sYYkAQ2WTpSyrS0hGv4urGS7MdcfhDZTmgSAGelCWOrOJAzL56A
	vv8kPoF4nnP8mtfWw==
X-Gm-Gg: ASbGncvdUCen23+1X3gQtWaBYmjo1hHvj6vNSC/4dwxf93hYu0UiPgnZH6OzQwhyrAr
	GtWOTPJ/bSe5dkjSz/rxjKm5UU0XXYBfv9xw3odQam3JnmAjW1Q92yynbl1kKnZh1i17cj+mL11
	Z1rcE0iivTkEDsni/XEcng282Xz1KhpTQezv2ahjKiwVUCGpOv30KH2F4ObCXGjWiKdNYLAJhK3
	FQ7kA54LvNo0agsE8qTu75BZUUw+qHbglkUf/9xPieV7khmuxD4TRYtOdX5teRrx8Boxz+0Us1U
	BwPFU6aB6S3jipKLZfXtga2OZBfp/zhgWebLFUiLoEg8502v0h2ROO6idiugrwhh/xIN281rb1u
	zlrRTGsIe2cuUEpZG3p9kAMEiyDN5ZOh/yw/9xamfuQFjp1S1C11uWUj8vdsGw95Yxh13UIZp1g
	==
X-Google-Smtp-Source: AGHT+IGIj0xpkH+tuyjv6RKSH8jjyMqodhqgzAPRbh2dNlTI6Zr23UvaoxqhKkhQXzKnFzqEY9/2SNUBDcjo
X-Received: by 2002:a05:6214:27e4:b0:78f:2eca:2002 with SMTP id 6a1803df08f44-7991f606907mr152941206d6.64.1758555833685;
        Mon, 22 Sep 2025 08:43:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-7934ee8ba93sm8335156d6.23.2025.09.22.08.43.53
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:43:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-82968fe9e8cso1266708185a.0
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758555833; x=1759160633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiAUve12B6y0VXa7aGKojambByjOg98b5E/1OlA7Abs=;
        b=b7Er1Bh3ai3gVsMW+Cno2hhgZ03t0RnwtVRTUvlFs3C1I6PLTBgX5xJTOqIoOhSy/O
         tbMd/d01Or8BaBgkof33DXlQyTlL5AxsY1yp056nqEqPV9WvYSlCyOLc3DuBp2L8aUjN
         LJb5vu2KuWRnNxxKAl4TZ5G+Eem1VB/28exv0=
X-Received: by 2002:a05:620a:3943:b0:84f:f50c:ec00 with SMTP id af79cd13be357-84ff50cec3cmr96893585a.60.1758555832854;
        Mon, 22 Sep 2025 08:43:52 -0700 (PDT)
X-Received: by 2002:a05:620a:3943:b0:84f:f50c:ec00 with SMTP id af79cd13be357-84ff50cec3cmr96890485a.60.1758555832278;
        Mon, 22 Sep 2025 08:43:52 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84ada77bb17sm179496785a.30.2025.09.22.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:43:51 -0700 (PDT)
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
Subject: [PATCH v2 7/8] RDMA/bng_re: Add basic debugfs infrastructure
Date: Mon, 22 Sep 2025 15:43:02 +0000
Message-Id: <20250922154303.246809-8-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922154303.246809-1-siva.kallam@broadcom.com>
References: <20250922154303.246809-1-siva.kallam@broadcom.com>
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
2.34.1


