Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFEB7220F03
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGOORO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 10:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGOORN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 10:17:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACC3C061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cv18so1996402pjb.1
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VitJw6enlAXHC7jlQGIUjvREvFz6BTqYJ/Vw8Qh0WjU=;
        b=NojDNtnIknV21DOXbHVghAEaeJVtIq8zk1tisIbgLBrbtP3uvHo1PR8/LcH8ol3cwf
         8Z+3KBNbtBq7qV6CQCmJc9R0ODFKQk+GItVaTZDAgbQ625yRBxObHHaIjCJJ5RgR906r
         /241IddwPmnqvNtpQxdaUxYSmMpLJ8k40iq/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VitJw6enlAXHC7jlQGIUjvREvFz6BTqYJ/Vw8Qh0WjU=;
        b=MjXnrcBolvSJoBKL+1+h74El8gSMlIVqniLpxgyWZWcr2aaI/mvKLxx6hmrtaWSuYv
         6Z8EeSyW68LGchxz0mfe2OAaB/IwlAdOWemQnBcinAFBJSF/4RUSEMGsrJ2e6QD56OEd
         wG0aRjR+DuqkeSiKird8kbdKQOx+Prx50TARQENTUNxuGdfBcoxnv+lougOrMuegGYUg
         VdAadSr/x6QydNzcgc+PpVrWq9n0r8oUl9aKAuzzscDCZEH317zUOrnZ1HKi3VT17NSC
         9WdW054efZl/tdXh8iOfaoKg2ALmrvfsfKDha5OepbXSW1KK4JP0e2l2Un8Aov1wlBJk
         UJ0Q==
X-Gm-Message-State: AOAM531BDOafvPFpS0n2v8OBSQ79+GfY/ePJ8CiH8QRCW8VWS9xBnfkx
        jCNi0I4LUPHS3N5xX8IlS1D2P3FIXiWQj63c8tDD9st2C7ek1uK4U+RTBQ6t9YJX1AI2u//wvN4
        kR5wbXFsF2rTWj1apsNX97n58jvscbG2AJ/ORBmQBrcPZV7I21T3MZy+dTdgJFglGqnsD0DfspS
        oFfZo=
X-Google-Smtp-Source: ABdhPJxjSoSFBJ62qfUZ1SYTKwVEh9hifCs2xif+zWSLuCOogjvi/hhdRQTbzJ/hhk5TYhJ4KjNCDQ==
X-Received: by 2002:a17:90a:f607:: with SMTP id bw7mr10829036pjb.18.1594822632503;
        Wed, 15 Jul 2020 07:17:12 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k92sm2399254pje.30.2020.07.15.07.17.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:17:12 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     devesh.sharma@broadcom.com, leon@kernel.org
Subject: [PATCH V2 for-next 1/6] RDMA/bnxt_re: introduce wqe mode to select execution path
Date:   Wed, 15 Jul 2020 10:16:54 -0400
Message-Id: <1594822619-4098-2-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
References: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The bnxt_re driver need to decide on how much SQ and RQ memory
should to be allocated and which wqe posting/polling algorithm
to use.

Making changes to set the wqe-mode to a default value during device
registration sequence. The wqe-mode is passed to the lower layer
driver as well. Going forward in the lower layer driver wqe-mode
will be used to decide execution path. Initializing the wqe-mode
to static wqe type for now.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  1 +
 drivers/infiniband/hw/bnxt_re/main.c      | 23 ++++++++++++++++------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 ++-
 drivers/infiniband/hw/bnxt_re/qplib_res.h | 32 +++++++++++++++++++++----------
 4 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index f32c7e8..e97bee3 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1183,6 +1183,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		goto out;
 	}
 	qplqp->type = (u8)qptype;
+	qplqp->wqe_mode = rdev->chip_ctx->modes.wqe_mode;
 
 	if (init_attr->qp_type == IB_QPT_RC) {
 		qplqp->max_rd_atomic = dev_attr->max_qp_rd_atom;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b12fbc8..dad0df8 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -82,6 +82,15 @@
 static void bnxt_re_dealloc_driver(struct ib_device *ib_dev);
 static void bnxt_re_stop_irq(void *handle);
 
+static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
+{
+	struct bnxt_qplib_chip_ctx *cctx;
+
+	cctx = rdev->chip_ctx;
+	cctx->modes.wqe_mode = bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
+			       mode : BNXT_QPLIB_WQE_MODE_STATIC;
+}
+
 static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_chip_ctx *chip_ctx;
@@ -97,7 +106,7 @@ static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 	kfree(chip_ctx);
 }
 
-static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
+static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
 {
 	struct bnxt_qplib_chip_ctx *chip_ctx;
 	struct bnxt_en_dev *en_dev;
@@ -117,6 +126,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 	rdev->qplib_res.cctx = rdev->chip_ctx;
 	rdev->rcfw.res = &rdev->qplib_res;
 
+	bnxt_re_set_drv_mode(rdev, wqe_mode);
 	return 0;
 }
 
@@ -1386,7 +1396,7 @@ static void bnxt_re_worker(struct work_struct *work)
 	schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
 }
 
-static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
+static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 {
 	struct bnxt_qplib_creq_ctx *creq;
 	struct bnxt_re_ring_attr rattr;
@@ -1406,7 +1416,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
 	}
 	set_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 
-	rc = bnxt_re_setup_chip_ctx(rdev);
+	rc = bnxt_re_setup_chip_ctx(rdev, wqe_mode);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to get chip context\n");
 		return -EINVAL;
@@ -1585,7 +1595,7 @@ static void bnxt_re_remove_device(struct bnxt_re_dev *rdev)
 }
 
 static int bnxt_re_add_device(struct bnxt_re_dev **rdev,
-			      struct net_device *netdev)
+			      struct net_device *netdev, u8 wqe_mode)
 {
 	int rc;
 
@@ -1599,7 +1609,7 @@ static int bnxt_re_add_device(struct bnxt_re_dev **rdev,
 	}
 
 	pci_dev_get((*rdev)->en_dev->pdev);
-	rc = bnxt_re_dev_init(*rdev);
+	rc = bnxt_re_dev_init(*rdev, wqe_mode);
 	if (rc) {
 		pci_dev_put((*rdev)->en_dev->pdev);
 		bnxt_re_dev_unreg(*rdev);
@@ -1711,7 +1721,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 	case NETDEV_REGISTER:
 		if (rdev)
 			break;
-		rc = bnxt_re_add_device(&rdev, real_dev);
+		rc = bnxt_re_add_device(&rdev, real_dev,
+					BNXT_QPLIB_WQE_MODE_STATIC);
 		if (!rc)
 			sch_work = true;
 		release = false;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 568ca39..6146f7d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -224,9 +224,10 @@ struct bnxt_qplib_qp {
 	u32				id;
 	u8				type;
 	u8				sig_type;
-	u32				modify_flags;
+	u8				wqe_mode;
 	u8				state;
 	u8				cur_qp_state;
+	u64				modify_flags;
 	u32				max_inline_data;
 	u32				mtu;
 	u8				path_mtu;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index c29cbd3..03a0f29 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -41,6 +41,28 @@
 
 extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 
+#define CHIP_NUM_57508		0x1750
+#define CHIP_NUM_57504		0x1751
+#define CHIP_NUM_57502		0x1752
+
+enum bnxt_qplib_wqe_mode {
+	BNXT_QPLIB_WQE_MODE_STATIC	= 0x00,
+	BNXT_QPLIB_WQE_MODE_VARIABLE	= 0x01,
+	BNXT_QPLIB_WQE_MODE_INVALID	= 0x02
+};
+
+struct bnxt_qplib_drv_modes {
+	u8	wqe_mode;
+	/* Other modes to follow here */
+};
+
+struct bnxt_qplib_chip_ctx {
+	u16	chip_num;
+	u8	chip_rev;
+	u8	chip_metal;
+	struct bnxt_qplib_drv_modes modes;
+};
+
 #define PTR_CNT_PER_PG		(PAGE_SIZE / sizeof(void *))
 #define PTR_MAX_IDX_PER_PG	(PTR_CNT_PER_PG - 1)
 #define PTR_PG(x)		(((x) & ~PTR_MAX_IDX_PER_PG) / PTR_CNT_PER_PG)
@@ -230,16 +252,6 @@ struct bnxt_qplib_ctx {
 	u64				hwrm_intf_ver;
 };
 
-struct bnxt_qplib_chip_ctx {
-	u16	chip_num;
-	u8	chip_rev;
-	u8	chip_metal;
-};
-
-#define CHIP_NUM_57508		0x1750
-#define CHIP_NUM_57504		0x1751
-#define CHIP_NUM_57502		0x1752
-
 struct bnxt_qplib_res {
 	struct pci_dev			*pdev;
 	struct bnxt_qplib_chip_ctx	*cctx;
-- 
1.8.3.1

