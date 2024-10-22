Return-Path: <linux-rdma+bounces-5472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFCD9AA022
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 12:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8708B287753
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2541E199253;
	Tue, 22 Oct 2024 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UtvkcPi/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EFF146A63
	for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593186; cv=none; b=TJToG+0W1x+KPsZFHeMOlDB/0WS2mEalf42NefYujn1sKMihOHdP57ybaWkk+AeTOgZ4Ga57g4z2kKnw9HhDkx7utz+QNrApEvMdGHse8MZFBbtiocEb0PI8uOiXD1kzlHnHmUqGNj0KSh6qGReJOAvrlwqB/PYGrwgH6+d41P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593186; c=relaxed/simple;
	bh=mnSYP/SOuN8t3nAxrrsapAkpPbQJItFxsaqLXjzp7gE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PYntwSBf8dgVICTsuWBAkA7s0BAcD/ovcxMyu/6JSxzhsPX3qcpritiNUxd+EypKZU/sVkGiDPjyKqDFAXEdWNxMLzUMeGGSLRF0BkBeAzIDaLMOCL//PRu4GzhTkUqN7zzXCkvn8frK944/250GjAjfLjVSlRiTXWg9wFnGY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UtvkcPi/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so4427003b3a.1
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2024 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729593184; x=1730197984; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JbYTziunN82GAEgv5HSwv0EbSQy4zkA4qCqja8EBW1I=;
        b=UtvkcPi/SD3fu/62mqnxDoPBfnT9kCM2OBv2Nyv8AY+/LzMGsVREmjnkt4LPB84j4c
         VSNItStyJDbsVV+gosyawErwZ1+1pQVm9wD3aHxtyTDToi+rQ+PIwgARnlGGDe9PQiyG
         DCyMYAkcrWvppZiYC/5tNebg/tRo9v5LiSkhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729593184; x=1730197984;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbYTziunN82GAEgv5HSwv0EbSQy4zkA4qCqja8EBW1I=;
        b=vaXZ7T29Dc4BMnISQ2Jj/7vNxblBbVami9oVML05eRiTONCB5fKGOgvQ1e2V5U53+o
         2hLGuIhnJKG0+vz1hHGkJFD5zV+Ka1SISMNOkJvtE2pvzG31f/Vs8HanQtikE/d2HNBv
         /FP+AuEgevejm3ze53X7YkmgmcdI17YDAbOJcDHEAYzj+QCH+f70owr4NnLbLhptjhoj
         D/WzsRqxyG3gqkypC8KkEwIF0hOsLe4FE4P8qzzN9eJ6lW8TcF3vAz/vzgnpGHfy/1MJ
         Sm/T1/nnm2mOajiddmRRijw8pPOk4J/KxdgazI8vBjQKyAKvDKliw/lwK76jZcroZbqX
         uzZQ==
X-Gm-Message-State: AOJu0Yz4LSS7eLc7K8MXVq6Us6WF5ss1JUe6mwIxKzJXju3E3TuEfHkO
	6dljfU5eJCW+cF0bbo7fFl6GbhUiIIlll2VeQlFKi5NqPRuwliRmt/bp9P56s1jXoDrBaJSS0vM
	=
X-Google-Smtp-Source: AGHT+IGZYBRIkLY+b/XQGoBE16xWL9w2Ihhl0CHfaPPo8+8tr7aUI2srA5nj3RgGaa120qLNDB9cDA==
X-Received: by 2002:a05:6a00:9285:b0:71e:4a46:fdb6 with SMTP id d2e1a72fcca58-71edc13b70amr5020375b3a.3.1729593183822;
        Tue, 22 Oct 2024 03:33:03 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec131393dsm4414572b3a.37.2024.10.22.03.33.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2024 03:33:02 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	kashyap.desai@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 4/4] RDMA/bnxt_re: Add debugfs hook in the driver
Date: Tue, 22 Oct 2024 03:11:56 -0700
Message-Id: <1729591916-29134-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1729591916-29134-1-git-send-email-selvin.xavier@broadcom.com>
References: <1729591916-29134-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Adding support for a per device debugfs folder for exporting
some of the device specific debug information.
Added support to get QP info for now. The same folder can be
used to export other debug features in future.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/Makefile   |   3 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   2 +
 drivers/infiniband/hw/bnxt_re/debugfs.c  | 141 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/debugfs.h  |  21 +++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |   4 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   1 +
 drivers/infiniband/hw/bnxt_re/main.c     |  13 ++-
 7 files changed, 183 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/debugfs.c
 create mode 100644 drivers/infiniband/hw/bnxt_re/debugfs.h

diff --git a/drivers/infiniband/hw/bnxt_re/Makefile b/drivers/infiniband/hw/bnxt_re/Makefile
index ee9bb1b..f63417d 100644
--- a/drivers/infiniband/hw/bnxt_re/Makefile
+++ b/drivers/infiniband/hw/bnxt_re/Makefile
@@ -4,4 +4,5 @@ ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnxt
 obj-$(CONFIG_INFINIBAND_BNXT_RE) += bnxt_re.o
 bnxt_re-y := main.o ib_verbs.o \
 	     qplib_res.o qplib_rcfw.o	\
-	     qplib_sp.o qplib_fp.o  hw_counters.o
+	     qplib_sp.o qplib_fp.o  hw_counters.o	\
+	     debugfs.o
diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 311bb7c..7f931c7 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -213,6 +213,8 @@ struct bnxt_re_dev {
 	struct delayed_work dbq_pacing_work;
 	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
 	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
+	struct dentry			*dbg_root;
+	struct dentry			*qp_debugfs;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
new file mode 100644
index 0000000..dd38dd6c
--- /dev/null
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Copyright (c) 2024, Broadcom. All rights reserved.  The term
+ * Broadcom refers to Broadcom Limited and/or its subsidiaries.
+ *
+ * Description: Debugfs component of the bnxt_re driver
+ */
+
+#include <linux/debugfs.h>
+#include <linux/pci.h>
+#include <rdma/ib_addr.h>
+
+#include "bnxt_ulp.h"
+#include "roce_hsi.h"
+#include "qplib_res.h"
+#include "qplib_sp.h"
+#include "qplib_fp.h"
+#include "qplib_rcfw.h"
+#include "bnxt_re.h"
+#include "ib_verbs.h"
+#include "debugfs.h"
+
+static struct dentry *bnxt_re_debugfs_root;
+
+static inline const char *bnxt_re_qp_state_str(u8 state)
+{
+	switch (state) {
+	case CMDQ_MODIFY_QP_NEW_STATE_RESET:
+		return "RST";
+	case CMDQ_MODIFY_QP_NEW_STATE_INIT:
+		return "INIT";
+	case CMDQ_MODIFY_QP_NEW_STATE_RTR:
+		return "RTR";
+	case CMDQ_MODIFY_QP_NEW_STATE_RTS:
+		return "RTS";
+	case CMDQ_MODIFY_QP_NEW_STATE_SQE:
+		return "SQER";
+	case CMDQ_MODIFY_QP_NEW_STATE_SQD:
+		return "SQD";
+	case CMDQ_MODIFY_QP_NEW_STATE_ERR:
+		return "ERR";
+	default:
+		return "Invalid QP state";
+	}
+}
+
+static inline const char *bnxt_re_qp_type_str(u8 type)
+{
+	switch (type) {
+	case CMDQ_CREATE_QP1_TYPE_GSI: return "QP1";
+	case CMDQ_CREATE_QP_TYPE_GSI: return "QP1";
+	case CMDQ_CREATE_QP_TYPE_RC: return "RC";
+	case CMDQ_CREATE_QP_TYPE_UD: return "UD";
+	case CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE: return "RAW_ETHERTYPE";
+	default: return "Invalid transport type";
+	}
+}
+
+static ssize_t qp_info_read(struct file *filep,
+			    char __user *buffer,
+			    size_t count, loff_t *ppos)
+{
+	struct bnxt_re_qp *qp = filep->private_data;
+	char *buf;
+	int len;
+
+	if (*ppos)
+		return 0;
+
+	buf = kasprintf(GFP_KERNEL,
+			"QPN\t\t: %d\n"
+			"transport\t: %s\n"
+			"state\t\t: %s\n"
+			"mtu\t\t: %d\n"
+			"timeout\t\t: %d\n"
+			"remote QPN\t: %d\n",
+			qp->qplib_qp.id,
+			bnxt_re_qp_type_str(qp->qplib_qp.type),
+			bnxt_re_qp_state_str(qp->qplib_qp.state),
+			qp->qplib_qp.mtu,
+			qp->qplib_qp.timeout,
+			qp->qplib_qp.dest_qpn);
+	if (!buf)
+		return -ENOMEM;
+	if (count < strlen(buf)) {
+		kfree(buf);
+		return -ENOSPC;
+	}
+	len = simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
+	kfree(buf);
+	return len;
+}
+
+static const struct file_operations debugfs_qp_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = qp_info_read,
+};
+
+void bnxt_re_debug_add_qpinfo(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp)
+{
+	char resn[32];
+
+	sprintf(resn, "0x%x", qp->qplib_qp.id);
+	qp->dentry = debugfs_create_file(resn, 0400, rdev->qp_debugfs, qp, &debugfs_qp_fops);
+}
+
+void bnxt_re_debug_rem_qpinfo(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp)
+{
+	if (!bnxt_re_debugfs_root || !rdev->qp_debugfs)
+		return;
+
+	debugfs_remove(qp->dentry);
+}
+
+void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
+{
+	struct pci_dev *pdev = rdev->en_dev->pdev;
+
+	rdev->dbg_root = debugfs_create_dir(dev_name(&pdev->dev), bnxt_re_debugfs_root);
+
+	rdev->qp_debugfs = debugfs_create_dir("QPs", rdev->dbg_root);
+}
+
+void bnxt_re_debugfs_rem_pdev(struct bnxt_re_dev *rdev)
+{
+	debugfs_remove_recursive(rdev->qp_debugfs);
+
+	debugfs_remove_recursive(rdev->dbg_root);
+	rdev->dbg_root = NULL;
+}
+
+void bnxt_re_register_debugfs(void)
+{
+	bnxt_re_debugfs_root = debugfs_create_dir("bnxt_re", NULL);
+}
+
+void bnxt_re_unregister_debugfs(void)
+{
+	debugfs_remove(bnxt_re_debugfs_root);
+}
diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.h b/drivers/infiniband/hw/bnxt_re/debugfs.h
new file mode 100644
index 0000000..cd3be0a9
--- /dev/null
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Copyright (c) 2024, Broadcom. All rights reserved.  The term
+ * Broadcom refers to Broadcom Limited and/or its subsidiaries.
+ *
+ * Description: Debugfs header
+ */
+
+#ifndef __BNXT_RE_DEBUGFS__
+#define __BNXT_RE_DEBUGFS__
+
+void bnxt_re_debug_add_qpinfo(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp);
+void bnxt_re_debug_rem_qpinfo(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp);
+
+void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev);
+void bnxt_re_debugfs_rem_pdev(struct bnxt_re_dev *rdev);
+
+void bnxt_re_register_debugfs(void);
+void bnxt_re_unregister_debugfs(void);
+
+#endif
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e66ae9f..10e96f1 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -62,6 +62,7 @@
 
 #include "bnxt_re.h"
 #include "ib_verbs.h"
+#include "debugfs.h"
 
 #include <rdma/uverbs_types.h>
 #include <rdma/uverbs_std_types.h>
@@ -939,6 +940,8 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	else if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_UD)
 		atomic_dec(&rdev->stats.res.ud_qp_count);
 
+	bnxt_re_debug_rem_qpinfo(rdev, qp);
+
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
 
@@ -1622,6 +1625,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		if (active_qps > rdev->stats.res.ud_qp_watermark)
 			rdev->stats.res.ud_qp_watermark = active_qps;
 	}
+	bnxt_re_debug_add_qpinfo(rdev, qp);
 
 	return 0;
 qp_destroy:
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index b789e47..e02a5e7 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -95,6 +95,7 @@ struct bnxt_re_qp {
 	struct ib_ud_header	qp1_hdr;
 	struct bnxt_re_cq	*scq;
 	struct bnxt_re_cq	*rcq;
+	struct dentry		*dentry;
 };
 
 struct bnxt_re_cq {
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 0a18d24..04fa81e 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -67,6 +67,7 @@
 #include <rdma/bnxt_re-abi.h>
 #include "bnxt.h"
 #include "hw_counters.h"
+#include "debugfs.h"
 
 static char version[] =
 		BNXT_RE_DESC "\n";
@@ -1870,6 +1871,8 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 	u8 type;
 	int rc;
 
+	bnxt_re_debugfs_rem_pdev(rdev);
+
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
 
@@ -2070,6 +2073,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
 		hash_init(rdev->srq_hash);
 
+	bnxt_re_debugfs_add_pdev(rdev);
+
 	return 0;
 free_sctx:
 	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
@@ -2389,18 +2394,24 @@ static int __init bnxt_re_mod_init(void)
 	int rc;
 
 	pr_info("%s: %s", ROCE_DRV_MODULE_NAME, version);
+	bnxt_re_register_debugfs();
+
 	rc = auxiliary_driver_register(&bnxt_re_driver);
 	if (rc) {
 		pr_err("%s: Failed to register auxiliary driver\n",
 			ROCE_DRV_MODULE_NAME);
-		return rc;
+		goto err_debug;
 	}
 	return 0;
+err_debug:
+	bnxt_re_unregister_debugfs();
+	return rc;
 }
 
 static void __exit bnxt_re_mod_exit(void)
 {
 	auxiliary_driver_unregister(&bnxt_re_driver);
+	bnxt_re_unregister_debugfs();
 }
 
 module_init(bnxt_re_mod_init);
-- 
2.5.5


