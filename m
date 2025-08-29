Return-Path: <linux-rdma+bounces-13000-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCA0B3BB5C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 14:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25117C3188
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4132318144;
	Fri, 29 Aug 2025 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eroPlF02"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5C31A067
	for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470709; cv=none; b=E7eNKoiu0p4OegOWsAywaoUMBAwRg6+gzcjzG1mfEulvXkkpsrUYPy9tUWVRimm34PExffJNERSoAqG8pf5XmTiebziWMVVE/y9l8rGAWFu7YoRQ+ydn7KX0rq6bggasXRm+J8cvgDE2Kt6vOH+XORVZr6ipgwLtQiRitJWVGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470709; c=relaxed/simple;
	bh=RIFRi3MNJGSSdjQM1Ui6VxpUsWC/b8GxminKx27eVwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7iebkV2s3wrSY5FUElaBECb621RZIvBQSWaRJU4vmAtRnE8Ls+rK7oTmCyTEIx/0BAgwGj+SnlpdTF6j5siJFCoJC0ld2aNYv2YQYeWyEKiD2YnkmI0vkzWY3DTqkW3R+Ssp53DOf9pcVfIZR7p2xKwNmEpaavSD3XXylBueOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eroPlF02; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-771fa8e4190so1454277b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 05:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470707; x=1757075507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocs1O7M+XeHOMJsN32xtyWTZCKjfIDggqthostXpTY0=;
        b=R2jLAGrAFpFRK7O9eEVbygZJa+UMAWvyged9+OIJYURSbAjSNQA3p4Arxurd7HnA2M
         EF3JUPSfofK/OOl3O8GPfAxZSudzDtT1qGwkg91ixHIAK7Ac5ArSFxfsJ/waYw/mb6Xs
         Jl7O/33SvErwPs66tmw1pQMCKgKx1hQlqyq8Q7kXWAQ1g4p966MCbe1SAWTClO0bVjbv
         uOJNfTjyu/gtHAB4wYUhK+DscdfplcP82wOzM+84YUS933R3qVSCOJyKCF07kB7tBib9
         fDKNEE/bV9lavCWPPObAmVsEMqSs6YqKFoCAma7fcu5K0Dqz/tlGzIbSxnN25Pcmdjo9
         AIqw==
X-Gm-Message-State: AOJu0YzOl/QyEbslAg2PmqsBphG2iOml6qthB+anGuz6ESTlyopJ4v13
	Vh3jeECS/cOyX3QF7wDV97bhuYiiQmgYRyXh2KGBrK/YZ3kY3rIz1/xpSqsfsUqTQ8h1X0bCeuT
	ecn8i743ipNam+lm7ZT2ck1fcdR2VCFEH5pnhejloFmamiQiTKaxS5YKwp3MazjS1hNKXRy4IJU
	6ax2qbyv2yUCGDzakdmLrNdj+Rv4pCLaA2Q/xVKgnp44UN8LLZjLwmPmAkbbUosw01NOap4YrTB
	tDEzYXUm2bl/Q9gVw==
X-Gm-Gg: ASbGnct5Nx1bA4Kk//mNxfrU9TuMqbeq+5mWLelVvuy5uOlxqeqh+Je/oTj2UIDKiqP
	7wTjm2jE/FsC61cqQocpGI2DqGSHT+GBPotuW7h2G2d/uzStmuWMTy/kYVh8BgRgE0dqgrGA/F1
	iE2bLR/zwsp0VFzsuWsSVq1tWqfp9gbQ8GdvHzWNaO5otRJRnLnu3uehlJyL+7c5UrFoVf8wJA5
	7mgvSKF7SMEJ5NGFzmzp/E/X6qgjw/mjkb7W0ZvlI5HgorC32SupdnXKi3VwY/irTPvlsL0gvhY
	OSlnP2Q5U+jXbSMFISbwfz/8/4ECHnnKQi/1hpP/QKXI35JsKKOTc73yYeUO/kAlJzR5rsxG9Il
	YEVkJ1hOjzukMGbWnXyr1+WaL0FKiKGsjSOC2qUyhz5xXBGtfBz5qgpNV7WRk/smjhtBN6UeZtd
	li
X-Google-Smtp-Source: AGHT+IGLU/KHGkr3wb8ShYYuGidCnAykApspsWfUe09lWyejol0ydA1TjINeTiNEhEJio1hFT89mLHIaAsZh
X-Received: by 2002:a05:6a00:230c:b0:770:57c4:e959 with SMTP id d2e1a72fcca58-77057c4ec55mr24936549b3a.9.1756470707358;
        Fri, 29 Aug 2025 05:31:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7722a47cf68sm131799b3a.9.2025.08.29.05.31.47
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:31:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109affec8so42242011cf.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 05:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756470706; x=1757075506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocs1O7M+XeHOMJsN32xtyWTZCKjfIDggqthostXpTY0=;
        b=eroPlF02U/MdI2GZnv5mTnA1ENp6pVRWbXOViPrbDAHLIYIcWX/wnpShakdlx4nrSB
         q8wpqQJNuw4c4wtUkqI67WAMypn/Fen28Gb4JTANEuXzC+/umqDXs2RlFUG3DSTLlVlT
         kGrIzZrz71cqCMxCoFUNd8o1Q33AlpNYhDesc=
X-Received: by 2002:a05:622a:211:b0:4b2:a07c:d728 with SMTP id d75a77b69052e-4b2aaa2b1d3mr340921461cf.27.1756470706071;
        Fri, 29 Aug 2025 05:31:46 -0700 (PDT)
X-Received: by 2002:a05:622a:211:b0:4b2:a07c:d728 with SMTP id d75a77b69052e-4b2aaa2b1d3mr340920941cf.27.1756470705437;
        Fri, 29 Aug 2025 05:31:45 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm162384585a.66.2025.08.29.05.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:31:45 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Usman Ansari <usman.ansari@broadcom.com>
Subject: [PATCH 7/8] RDMA/bng_re: Add basic debugfs infrastructure
Date: Fri, 29 Aug 2025 12:30:41 +0000
Message-Id: <20250829123042.44459-8-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829123042.44459-1-siva.kallam@broadcom.com>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
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
index 9faa64af3047..773121682bbe 100644
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


