Return-Path: <linux-rdma+bounces-12995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB90B3BB56
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 14:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC48C7B0D2C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 12:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7742E3164A2;
	Fri, 29 Aug 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a+TuDSaB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f228.google.com (mail-yb1-f228.google.com [209.85.219.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3B73043A7
	for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470677; cv=none; b=BnUXNF9QSnDUtwEzdkXT6M+DJM5X4xZaBZEWFkYSTVVOuC8fY4tQYIsW5ul+gVn50j5LLsKfMWrUD7CdC3Go0h3Lf6L+mGVjxgnbuWsENdjNQOUulG42/zZ/+a2scO0qDgtqclUdye9sTXVausOJwHyRKtdV6Bsud7PaNwM3Vyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470677; c=relaxed/simple;
	bh=AxYEawSE2N3A/SjebJ3NpgKipTP1qKQH53ibGarn2wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNB3zhipPZVWR3dH0CBddbSB7tgMwHHB/xOruwLpEPzWMAHVRioSfuaf65B5Yv3TWixueGRAxtdbtTq4stVBkllqWH2FMhVbmcDEpEOke+Pp57ZqkQcCURPFXf8LsCd5663YDbAWcnIdzp8Rli+ISOwinip7sVCN9mqSwTKFpSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a+TuDSaB; arc=none smtp.client-ip=209.85.219.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f228.google.com with SMTP id 3f1490d57ef6-e96e5a3b3b3so1695878276.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 05:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470674; x=1757075474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8I7tlPINdJc8O0KJpNidrGsrL80VvPMNRcUF1iAFB0A=;
        b=tNlBv4vUOILSZegb7vtSGdlchIt+YQVrdY5oWU2b16s7EuZhhHG9GVkTRwZD+rsSZH
         uMuZLxPzG96vHacZ7daJJo79li+ZXA3lZODrkxMSD3t0e+0ighq/AvA/nhKeVtJ8NkJ9
         qMSzWcwuIa8S3BTzCmIoloxtGz8C38ZuU28rw1e00v7mKhMCZD1gVV7Gt4T3Bwe7bFHp
         w10xm805RJnmUrOlmhnydFPY/LxRvsoVGkgploEFQO62chXoHHYxT470Uc9cII6MAKWE
         6217Td/I7myl0BWNAMTXa3MJyBS81QvoOSYouksa0WTJanSqCreM8WAXIXtdTzLXko2z
         h/Xg==
X-Gm-Message-State: AOJu0YxUSAfKtK+IKrWsYcdCXbBITxFo9GIgG7liCB4ZLAEYny+z12eu
	4jE1KiDU16A6wvyBpZASMG+biiSYg9zQVI6lNbdbYT5zUifUWOGCf3DpTV0tpgDKmv3iUXeWSVU
	z+HHfIn8Z+9Rtw4y2r429iZUuS/VwRhPUvHCiKMWHzYSuW+udJWMUN5mjYsNj2Zq+1XdJtdWuL0
	I42cipGkDXSoASpQUe/YDMATGC7ceDzlSbRFFmUo3VsqhoqdSOdinbU2uixmgEl8EocIZYMY2eI
	f2W105mGENKdLh2vg==
X-Gm-Gg: ASbGncskYb1EtOPGhyw5EPrXldB+ETY9UZn/LCdMVFzb3oxYPxOzs7TbFQC8IqjsntW
	jn0+524X9FOefqa5UoFcMHSH9qYQKh3nAQ11i7zZqX//d81l9H4W4vl+Y7ZNrRx6e17nF3tHFqw
	1kJXvljM02LIUptF7W9kmhD5NVuEuTXM+HsFiH/Py7HMGGTd8em5P+0AZNFd6YCyQqCaKQn7rzB
	ZH3stOZMq9DRgB9KVulvax4/Hrt69aDcLcR5fv6cvl5OFeQHyDVwzgXx6DKKTk/xEII1C1yFRBe
	xjYL35/Wg08YGiyJnvOqJ0XY25Xe+lSoD/bUAny2a3C+D0bToriSWy3mVTygnXLr40ixHQ3mk61
	CoaFqDdwEjtZNlzue0k0gKNzjexMgBM+jV7pe6VmMwmPGtTOHlWLCSH3MSB5rFt6Qw5DFgkK5ag
	==
X-Google-Smtp-Source: AGHT+IFcVQxzBjTwACd48yHGA5eEuEmU6kAyu+BdnlCIgU7+1a+XiLlstiY0vfkENJAtxVA7lM0eN58I6Gp+
X-Received: by 2002:a05:6902:110d:b0:e96:c578:c774 with SMTP id 3f1490d57ef6-e96c578ccdcmr20359664276.22.1756470674113;
        Fri, 29 Aug 2025 05:31:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e9847db794fsm145617276.19.2025.08.29.05.31.13
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:31:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e870646b11so466809785a.2
        for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756470673; x=1757075473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I7tlPINdJc8O0KJpNidrGsrL80VvPMNRcUF1iAFB0A=;
        b=a+TuDSaBr+MNJjWLLmunKWWD40GaeLHCPFRlsbHWKZWyEJiV0qLtfQPQJVfedigWa7
         +lSB2LagAi3phIuAORJhCykUVPxD4LZI1uKo56/qiFLa6GK6FeXa2U5w9U3Cbs7B6Cnq
         4zxCznZDLKHmkLmYZazVoCB3YgkyO3Xf1eElc=
X-Received: by 2002:a05:620a:a485:b0:7e7:40f1:8d35 with SMTP id af79cd13be357-7ea10fd12e7mr2957560985a.30.1756470673032;
        Fri, 29 Aug 2025 05:31:13 -0700 (PDT)
X-Received: by 2002:a05:620a:a485:b0:7e7:40f1:8d35 with SMTP id af79cd13be357-7ea10fd12e7mr2957556185a.30.1756470672358;
        Fri, 29 Aug 2025 05:31:12 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm162384585a.66.2025.08.29.05.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:31:11 -0700 (PDT)
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
Subject: [PATCH 2/8] RDMA/bng_re: Add Auxiliary interface
Date: Fri, 29 Aug 2025 12:30:36 +0000
Message-Id: <20250829123042.44459-3-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829123042.44459-1-siva.kallam@broadcom.com>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=all
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add basic Auxiliary interface to the driver which supports
the BCM5770X NIC family.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 MAINTAINERS                            |   7 ++
 drivers/infiniband/Kconfig             |   1 +
 drivers/infiniband/hw/Makefile         |   1 +
 drivers/infiniband/hw/bng_re/Kconfig   |  10 ++
 drivers/infiniband/hw/bng_re/Makefile  |   7 ++
 drivers/infiniband/hw/bng_re/bng_dev.c | 142 +++++++++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_re.h  |  27 +++++
 7 files changed, 195 insertions(+)
 create mode 100644 drivers/infiniband/hw/bng_re/Kconfig
 create mode 100644 drivers/infiniband/hw/bng_re/Makefile
 create mode 100644 drivers/infiniband/hw/bng_re/bng_dev.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_re.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..0f0168872e37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5122,6 +5122,13 @@ W:	http://www.broadcom.com
 F:	drivers/infiniband/hw/bnxt_re/
 F:	include/uapi/rdma/bnxt_re-abi.h
 
+BROADCOM 800 GIGABIT ROCE DRIVER
+M:	Siva Reddy Kallam <siva.kallam@broadcom.com>
+L:	linux-rdma@vger.kernel.org
+S:	Supported
+W:	http://www.broadcom.com
+F:	drivers/infiniband/hw/bng_re/
+
 BROADCOM NVRAM DRIVER
 M:	Rafał Miłecki <zajec5@gmail.com>
 L:	linux-mips@vger.kernel.org
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 3a394cd772f6..9a847a5c453b 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -80,6 +80,7 @@ config INFINIBAND_VIRT_DMA
 if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
 if !UML
 source "drivers/infiniband/hw/bnxt_re/Kconfig"
+source "drivers/infiniband/hw/bng_re/Kconfig"
 source "drivers/infiniband/hw/cxgb4/Kconfig"
 source "drivers/infiniband/hw/efa/Kconfig"
 source "drivers/infiniband/hw/erdma/Kconfig"
diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
index df61b2299ec0..7f2056e6a16b 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -13,4 +13,5 @@ obj-$(CONFIG_INFINIBAND_HFI1)		+= hfi1/
 obj-$(CONFIG_INFINIBAND_HNS_HIP08)	+= hns/
 obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
 obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
+obj-$(CONFIG_INFINIBAND_BNG_RE)		+= bng_re/
 obj-$(CONFIG_INFINIBAND_ERDMA)		+= erdma/
diff --git a/drivers/infiniband/hw/bng_re/Kconfig b/drivers/infiniband/hw/bng_re/Kconfig
new file mode 100644
index 000000000000..85845f72c64d
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config INFINIBAND_BNG_RE
+	tristate "Broadcom Next generation RoCE HCA support"
+	depends on 64BIT
+	depends on INET && DCB && BNGE
+	help
+	  This driver supports Broadcom Next generation
+	  50/100/200/400/800 gigabit RoCE HCAs. The module
+	  will be called bng_re. To compile this driver
+	  as a module, choose M here.
diff --git a/drivers/infiniband/hw/bng_re/Makefile b/drivers/infiniband/hw/bng_re/Makefile
new file mode 100644
index 000000000000..f854dae25b1c
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnge
+
+obj-$(CONFIG_INFINIBAND_BNG_RE) += bng_re.o
+
+bng_re-y := bng_dev.o
diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
new file mode 100644
index 000000000000..208844e98bd6
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/auxiliary_bus.h>
+
+#include <rdma/ib_verbs.h>
+
+#include "bng_re.h"
+#include "bnge.h"
+#include "bnge_auxr.h"
+
+static char version[] =
+		BNG_RE_DESC "\n";
+
+MODULE_AUTHOR("Siva Reddy Kallam <siva.kallam@broadcom.com>");
+MODULE_DESCRIPTION(BNG_RE_DESC);
+MODULE_LICENSE("Dual BSD/GPL");
+
+static struct bng_re_dev *bng_re_dev_add(struct auxiliary_device *adev,
+					 struct bnge_auxr_dev *aux_dev)
+{
+	struct bng_re_dev *rdev;
+
+	/* Allocate bng_re_dev instance */
+	rdev = ib_alloc_device(bng_re_dev, ibdev);
+	if (!rdev) {
+		ibdev_err(NULL, "%s: bng_re_dev allocation failure!",
+			  BNG_ROCE_DRV_MODULE_NAME);
+		return NULL;
+	}
+
+	/* Assign auxiliary device specific data */
+	rdev->netdev = aux_dev->net;
+	rdev->aux_dev = aux_dev;
+	rdev->adev = adev;
+	rdev->fn_id = rdev->aux_dev->pdev->devfn;
+
+	return rdev;
+}
+
+static int bng_re_add_device(struct auxiliary_device *adev)
+{
+	struct bnge_auxr_priv *auxr_priv =
+		container_of(adev, struct bnge_auxr_priv, aux_dev);
+	struct bng_re_en_dev_info *dev_info;
+	struct bng_re_dev *rdev;
+	int rc;
+
+	dev_info = auxiliary_get_drvdata(adev);
+
+	rdev = bng_re_dev_add(adev, auxr_priv->auxr_dev);
+	if (!rdev || !rdev_to_dev(rdev)) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+
+	dev_info->rdev = rdev;
+
+	return 0;
+exit:
+	return rc;
+}
+
+
+static void bng_re_remove_device(struct bng_re_dev *rdev,
+				 struct auxiliary_device *aux_dev)
+{
+	ib_dealloc_device(&rdev->ibdev);
+}
+
+
+static int bng_re_probe(struct auxiliary_device *adev,
+			const struct auxiliary_device_id *id)
+{
+	struct bnge_auxr_priv *aux_priv =
+		container_of(adev, struct bnge_auxr_priv, aux_dev);
+	struct bng_re_en_dev_info *en_info;
+	int rc;
+
+	en_info = kzalloc(sizeof(*en_info), GFP_KERNEL);
+	if (!en_info)
+		return -ENOMEM;
+
+	en_info->auxr_dev = aux_priv->auxr_dev;
+
+	auxiliary_set_drvdata(adev, en_info);
+
+	rc = bng_re_add_device(adev);
+	if (rc)
+		kfree(en_info);
+	return rc;
+}
+
+static void bng_re_remove(struct auxiliary_device *adev)
+{
+	struct bng_re_en_dev_info *dev_info = auxiliary_get_drvdata(adev);
+	struct bng_re_dev *rdev;
+
+	rdev = dev_info->rdev;
+
+	if (rdev)
+		bng_re_remove_device(rdev, adev);
+	kfree(dev_info);
+}
+
+static const struct auxiliary_device_id bng_re_id_table[] = {
+	{ .name = BNG_RE_ADEV_NAME ".rdma", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, bng_re_id_table);
+
+static struct auxiliary_driver bng_re_driver = {
+	.name = "rdma",
+	.probe = bng_re_probe,
+	.remove = bng_re_remove,
+	.id_table = bng_re_id_table,
+};
+
+static int __init bng_re_mod_init(void)
+{
+	int rc;
+
+	pr_info("%s: %s", BNG_ROCE_DRV_MODULE_NAME, version);
+
+	rc = auxiliary_driver_register(&bng_re_driver);
+	if (rc) {
+		pr_err("%s: Failed to register auxiliary driver\n",
+		       BNG_ROCE_DRV_MODULE_NAME);
+	}
+	return rc;
+}
+
+static void __exit bng_re_mod_exit(void)
+{
+	auxiliary_driver_unregister(&bng_re_driver);
+}
+
+module_init(bng_re_mod_init);
+module_exit(bng_re_mod_exit);
diff --git a/drivers/infiniband/hw/bng_re/bng_re.h b/drivers/infiniband/hw/bng_re/bng_re.h
new file mode 100644
index 000000000000..bd3aacdc05c4
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_re.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2025 Broadcom.
+
+#ifndef __BNG_RE_H__
+#define __BNG_RE_H__
+
+#define BNG_ROCE_DRV_MODULE_NAME	"bng_re"
+#define BNG_RE_ADEV_NAME		"bng_en"
+
+#define BNG_RE_DESC	"Broadcom 800G RoCE Driver"
+
+#define	rdev_to_dev(rdev)	((rdev) ? (&(rdev)->ibdev.dev) : NULL)
+
+struct bng_re_en_dev_info {
+	struct bng_re_dev *rdev;
+	struct bnge_auxr_dev *auxr_dev;
+};
+
+struct bng_re_dev {
+	struct ib_device		ibdev;
+	struct net_device		*netdev;
+	struct auxiliary_device         *adev;
+	struct bnge_auxr_dev		*aux_dev;
+	int				fn_id;
+};
+
+#endif
-- 
2.34.1


