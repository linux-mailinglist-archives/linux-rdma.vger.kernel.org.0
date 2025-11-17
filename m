Return-Path: <linux-rdma+bounces-14543-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8A7C65759
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 18:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0129D4F1F0A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A34329C7D;
	Mon, 17 Nov 2025 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PwN2YBOJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076D328B51
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399554; cv=none; b=nsewZ9Z98eReWVYPGXKas3a3+kBx/8ghFdeyeL58Fr3QM1lCY6dyNe5tioVsIIsHvM3oW/QX3tbOKKYz8xkBUeWPijivsPvC77c4M/aUuzG8tVflrVFf+957Lu7XCYU88AkZupm+ZqxR47Areb4fVVYwPXDYoiikWnmu7CTRNIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399554; c=relaxed/simple;
	bh=xQaoQUyFA2OOoOxPb7HMFwHrbLGMuZvFEhsS7oOEFRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjPwQZjuhPgzOQj2Ot1vo5Lv8l6NXiabKXV9Sw/d+68YvXldVPoGakxTKuKY8m4bLD5ONedM+GFV3s/ToeCb2sNxvPLYglr10WNA95I46P5rKKym8Sv2UnCMXQknYUhbEzaY4SwOVIf1v9G58DyFF/qgkP7V835iiag/oiKCGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PwN2YBOJ; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-3e89a44007dso906797fac.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 09:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399552; x=1764004352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bliFMzDhNAvMQaBtvLYCtrwp9ER8GDCWnv/7cQ7F4w=;
        b=LGd9ejcddGKBAMPEepvjn4JNRsmldAAIPgz1Ypp6d7k7LEAWZMRlQ5iVAbmF/rZ5l3
         2t/cb+PbFldcdqwrQbZoLAkWYGfndwP85yFsQ27fyRmF05ZIdoIvsJfod9Xhz96qcQpi
         I8PRujCoMsy7cu6wEDa06B0hk3iKdJGNhgY3ITVCRJAUu8ogeHcRBbTGFmLV6yfOxY7I
         XDo8/EFIi1+fUTcPYrDRdfy1wtyovmoknxbyaT80V9ZwmHy42G3HHCuGnGjSITY7FcyU
         sLl5sdOnDbIxD4hl0DOkPsaBLlgNHxgQBo9+ryWTIUbjciUcW4uBLIxaeNuGFKRY9lwM
         AJ3g==
X-Gm-Message-State: AOJu0YwMHUChY9aW76SysXrsoQIALnVbCvgYlwjN+VGJWC4nPc9OpoYs
	GiCJSLrmI0J5YV4vlRTLV/Wjhk5FoqFaBT3odzQsTIC+VIpspyurY1mJFzorGy/X7+i/gpyvVdH
	2v7N4IltvBVFUZfiykeHBVnL/yAnXDMHZst8Be9YdVa/0OWNyPTZkm9PWif/6mKjTRfvcdATPsF
	RCRrdV2lOmH0hVPfroBwZOVEnZJSSenV/IxOrlczI1xSswtTCRUnb9my3zwiUgYQiSCa670GPnE
	FkB8lVQBChataUfkA==
X-Gm-Gg: ASbGncvUO1yadp/EF2sA93W/Fm1d7vBK4mOzwIi2byBHC073cuzEJSM4PRKBV/fqAaP
	mAzhxkhsmViDYtR8mT219gr+4ha9/CgxEjHBiNxv7U8mmA8mTDB3UsHsjQBYNNAqRZ7RQPxGcIh
	ONcTMi9r2To/lJfG2+eaS2/xISQ6Rje9Z21RwKe6oM0bNau1mRP0pzhV8P3CyCiUFkzz1NrpG94
	yWpLaQmu7cCbLg8sHtFmaUC7/fxAG3teMsfT5RdNrIAkcPSYzEo8MvV3C/Zllfuqh+OnEVGGdJP
	tzWCVSDM0nQsvg8NQH470TKiWDW4GrH7HHpRnO1fsRt/hSpReBN2JJfKyRgnKydxm2vvAO5ObJ7
	c+EcT8kIxWWeuNf3LGXqhCGvAF7zaZiu9K5TtoeO7PDZclxGr08tFcycMGbB6CULCxLvBs5FPIh
	iBt2f2mFbtmEgGoSWOru9p4fkyVMcRIZxfqy4=
X-Google-Smtp-Source: AGHT+IERjFgsZGw47QAtXwNqsAYv3UzIXwXoRL6bl3O3HUA9FCgUi60OViAwgVZN94k7k5bmBnvS569nFI5H
X-Received: by 2002:a05:6870:400d:b0:3db:6c26:b6c5 with SMTP id 586e51a60fabf-3ec60fe2014mr27903fac.16.1763399551679;
        Mon, 17 Nov 2025 09:12:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3e85200d466sm1288989fac.5.2025.11.17.09.12.31
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2025 09:12:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edad69b4e8so110340761cf.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763399551; x=1764004351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bliFMzDhNAvMQaBtvLYCtrwp9ER8GDCWnv/7cQ7F4w=;
        b=PwN2YBOJIC/JXRSkYzO9XP+FAY9AwVPPaL7ObQ4NoQD1bgRSv1YkJINxpBxvqtF17B
         s5a+gacAeqpb64Yean5L2NQyQbN1eN4YuhglZQWAJjEOzJm2xHZ3MqMCVqbMl/QyZDpp
         TPKw1SzYLRfyO/c7dqd86QUrU2BRXuNT4nnO8=
X-Received: by 2002:a05:622a:120c:b0:4ee:199d:649c with SMTP id d75a77b69052e-4ee308a565emr774711cf.33.1763399550644;
        Mon, 17 Nov 2025 09:12:30 -0800 (PST)
X-Received: by 2002:a05:622a:120c:b0:4ee:199d:649c with SMTP id d75a77b69052e-4ee308a565emr773931cf.33.1763399550161;
        Mon, 17 Nov 2025 09:12:30 -0800 (PST)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314557sm96082236d6.20.2025.11.17.09.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:12:29 -0800 (PST)
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
Subject: [PATCH v3 3/8] RDMA/bng_re: Register and get the resources from bnge driver
Date: Mon, 17 Nov 2025 17:11:21 +0000
Message-ID: <20251117171136.128193-4-siva.kallam@broadcom.com>
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

Register and get the basic required resources from bnge driver.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 149 +++++++++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_re.h  |   5 +
 drivers/infiniband/hw/bng_re/bng_res.h |  16 +++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/infiniband/hw/bng_re/bng_res.h

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index 08aba72a26f7..cad065df2032 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -7,8 +7,10 @@
 
 #include <rdma/ib_verbs.h>
 
+#include "bng_res.h"
 #include "bng_re.h"
 #include "bnge.h"
+#include "bnge_hwrm.h"
 #include "bnge_auxr.h"
 
 static char version[] =
@@ -40,6 +42,144 @@ static struct bng_re_dev *bng_re_dev_add(struct auxiliary_device *adev,
 	return rdev;
 }
 
+
+static int bng_re_register_netdev(struct bng_re_dev *rdev)
+{
+	struct bnge_auxr_dev *aux_dev;
+
+	aux_dev = rdev->aux_dev;
+	return bnge_register_dev(aux_dev, rdev->adev);
+}
+
+static void bng_re_destroy_chip_ctx(struct bng_re_dev *rdev)
+{
+	struct bng_re_chip_ctx *chip_ctx;
+
+	if (!rdev->chip_ctx)
+		return;
+
+	chip_ctx = rdev->chip_ctx;
+	rdev->chip_ctx = NULL;
+	kfree(chip_ctx);
+}
+
+static int bng_re_setup_chip_ctx(struct bng_re_dev *rdev)
+{
+	struct bng_re_chip_ctx *chip_ctx;
+	struct bnge_auxr_dev *aux_dev;
+
+	aux_dev = rdev->aux_dev;
+
+	chip_ctx = kzalloc(sizeof(*chip_ctx), GFP_KERNEL);
+	if (!chip_ctx)
+		return -ENOMEM;
+	chip_ctx->chip_num = aux_dev->chip_num;
+	chip_ctx->hw_stats_size = aux_dev->hw_ring_stats_size;
+
+	rdev->chip_ctx = chip_ctx;
+
+	return 0;
+}
+
+static void bng_re_init_hwrm_hdr(struct input *hdr, u16 opcd)
+{
+	hdr->req_type = cpu_to_le16(opcd);
+	hdr->cmpl_ring = cpu_to_le16(-1);
+	hdr->target_id = cpu_to_le16(-1);
+}
+
+static void bng_re_fill_fw_msg(struct bnge_fw_msg *fw_msg, void *msg,
+			       int msg_len, void *resp, int resp_max_len,
+			       int timeout)
+{
+	fw_msg->msg = msg;
+	fw_msg->msg_len = msg_len;
+	fw_msg->resp = resp;
+	fw_msg->resp_max_len = resp_max_len;
+	fw_msg->timeout = timeout;
+}
+
+static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
+{
+	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
+	struct hwrm_ver_get_output ver_get_resp = {};
+	struct hwrm_ver_get_input ver_get_req = {};
+	struct bng_re_chip_ctx *cctx;
+	struct bnge_fw_msg fw_msg = {};
+	int rc;
+
+	bng_re_init_hwrm_hdr((void *)&ver_get_req, HWRM_VER_GET);
+	ver_get_req.hwrm_intf_maj = HWRM_VERSION_MAJOR;
+	ver_get_req.hwrm_intf_min = HWRM_VERSION_MINOR;
+	ver_get_req.hwrm_intf_upd = HWRM_VERSION_UPDATE;
+	bng_re_fill_fw_msg(&fw_msg, (void *)&ver_get_req, sizeof(ver_get_req),
+			    (void *)&ver_get_resp, sizeof(ver_get_resp),
+			    BNGE_DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnge_send_msg(aux_dev, &fw_msg);
+	if (rc) {
+		ibdev_err(&rdev->ibdev, "Failed to query HW version, rc = 0x%x",
+			  rc);
+		return;
+	}
+
+	cctx = rdev->chip_ctx;
+	cctx->hwrm_intf_ver =
+		(u64)le16_to_cpu(ver_get_resp.hwrm_intf_major) << 48 |
+		(u64)le16_to_cpu(ver_get_resp.hwrm_intf_minor) << 32 |
+		(u64)le16_to_cpu(ver_get_resp.hwrm_intf_build) << 16 |
+		le16_to_cpu(ver_get_resp.hwrm_intf_patch);
+
+	cctx->hwrm_cmd_max_timeout = le16_to_cpu(ver_get_resp.max_req_timeout);
+
+	if (!cctx->hwrm_cmd_max_timeout)
+		cctx->hwrm_cmd_max_timeout = BNG_ROCE_FW_MAX_TIMEOUT;
+}
+
+static int bng_re_dev_init(struct bng_re_dev *rdev)
+{
+	int rc;
+
+	/* Registered a new RoCE device instance to netdev */
+	rc = bng_re_register_netdev(rdev);
+	if (rc) {
+		ibdev_err(&rdev->ibdev,
+				"Failed to register with netedev: %#x\n", rc);
+		return -EINVAL;
+	}
+
+	set_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+
+	if (rdev->aux_dev->auxr_info->msix_requested < BNG_RE_MIN_MSIX) {
+		ibdev_err(&rdev->ibdev,
+			  "RoCE requires minimum 2 MSI-X vectors, but only %d reserved\n",
+			  rdev->aux_dev->auxr_info->msix_requested);
+		bnge_unregister_dev(rdev->aux_dev);
+		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+		return -EINVAL;
+	}
+	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
+		  rdev->aux_dev->auxr_info->msix_requested);
+
+	rc = bng_re_setup_chip_ctx(rdev);
+	if (rc) {
+		bnge_unregister_dev(rdev->aux_dev);
+		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+		ibdev_err(&rdev->ibdev, "Failed to get chip context\n");
+		return -EINVAL;
+	}
+
+	bng_re_query_hwrm_version(rdev);
+
+	return 0;
+}
+
+static void bng_re_dev_uninit(struct bng_re_dev *rdev)
+{
+	bng_re_destroy_chip_ctx(rdev);
+	if (test_and_clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
+		bnge_unregister_dev(rdev->aux_dev);
+}
+
 static int bng_re_add_device(struct auxiliary_device *adev)
 {
 	struct bnge_auxr_priv *auxr_priv =
@@ -58,7 +198,14 @@ static int bng_re_add_device(struct auxiliary_device *adev)
 
 	dev_info->rdev = rdev;
 
+	rc = bng_re_dev_init(rdev);
+	if (rc)
+		goto re_dev_dealloc;
+
 	return 0;
+
+re_dev_dealloc:
+	ib_dealloc_device(&rdev->ibdev);
 exit:
 	return rc;
 }
@@ -67,6 +214,7 @@ static int bng_re_add_device(struct auxiliary_device *adev)
 static void bng_re_remove_device(struct bng_re_dev *rdev,
 				 struct auxiliary_device *aux_dev)
 {
+	bng_re_dev_uninit(rdev);
 	ib_dealloc_device(&rdev->ibdev);
 }
 
@@ -90,6 +238,7 @@ static int bng_re_probe(struct auxiliary_device *adev,
 	rc = bng_re_add_device(adev);
 	if (rc)
 		kfree(en_info);
+
 	return rc;
 }
 
diff --git a/drivers/infiniband/hw/bng_re/bng_re.h b/drivers/infiniband/hw/bng_re/bng_re.h
index bd3aacdc05c4..db692ad8db0e 100644
--- a/drivers/infiniband/hw/bng_re/bng_re.h
+++ b/drivers/infiniband/hw/bng_re/bng_re.h
@@ -11,6 +11,8 @@
 
 #define	rdev_to_dev(rdev)	((rdev) ? (&(rdev)->ibdev.dev) : NULL)
 
+#define BNG_RE_MIN_MSIX		2
+
 struct bng_re_en_dev_info {
 	struct bng_re_dev *rdev;
 	struct bnge_auxr_dev *auxr_dev;
@@ -18,9 +20,12 @@ struct bng_re_en_dev_info {
 
 struct bng_re_dev {
 	struct ib_device		ibdev;
+	unsigned long			flags;
+#define BNG_RE_FLAG_NETDEV_REGISTERED		0
 	struct net_device		*netdev;
 	struct auxiliary_device         *adev;
 	struct bnge_auxr_dev		*aux_dev;
+	struct bng_re_chip_ctx		*chip_ctx;
 	int				fn_id;
 };
 
diff --git a/drivers/infiniband/hw/bng_re/bng_res.h b/drivers/infiniband/hw/bng_re/bng_res.h
new file mode 100644
index 000000000000..d64833498e2a
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_res.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2025 Broadcom.
+
+#ifndef __BNG_RES_H__
+#define __BNG_RES_H__
+
+#define BNG_ROCE_FW_MAX_TIMEOUT	60
+
+struct bng_re_chip_ctx {
+	u16	chip_num;
+	u16	hw_stats_size;
+	u64	hwrm_intf_ver;
+	u16	hwrm_cmd_max_timeout;
+};
+
+#endif
-- 
2.43.0


