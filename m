Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6817B263308
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 18:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgIIQ42 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730911AbgIIQ4Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Sep 2020 12:56:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3556EC061573
        for <linux-rdma@vger.kernel.org>; Wed,  9 Sep 2020 09:56:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so2672179pfn.9
        for <linux-rdma@vger.kernel.org>; Wed, 09 Sep 2020 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gl5YvAOZp93b/wM56Dis2Ef5sMZofdOKMbfKboGp6yo=;
        b=cdevoIjGxGVYu95IODtQea1YyoLcyw6sCCXKlJU2yUgo03CQRdkf6cy+flAIUtqrdu
         oHoIpUwX9jWbMr2IZRh9TNuMUILi8CzSIPwkJstfmd598FkInQIjDRX0zuSX8v9XSxX0
         ojBsLhQVlcN8Ks5A97aN6vLJ7ahpAMsBuBNMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gl5YvAOZp93b/wM56Dis2Ef5sMZofdOKMbfKboGp6yo=;
        b=Eo/gtBBRDLvJ2YDX5Z26hQ75cqDT+Nki7VUdmh9XuQaE35fry1QrnsKseOKk+CDFqC
         eIWzQWhCwdqK8nsYObMi08mxTVhiiSogosbuUCz6/F1soUkLes6N7byciL/GmrYnRu5G
         2CBNyy32mitulSlMi+OLqmLlCzWa4z4Fxa3DE6jCwIFADldznCErfAHPp/mpYULT+ido
         tZjwu8UNX7s+NEiOmOmt72Rc+C/KRtdtDxlPN7vDRWWYnNdCIWLFPp/FPBpvXhUnxURk
         BknsZVw88R+tW+M9yvjM8yW4xpNz/5KyMTVCJ9WQOEgvojQRhp+QR+cn1KS64N2beUgr
         VViA==
X-Gm-Message-State: AOAM533F8DAmKLiXLpF+LSNb4VzOqrl1HAsU/ubGtqsVhsbKFuCUUm0L
        q97q4XpSIvdy1L6TB9dyT+0YDg==
X-Google-Smtp-Source: ABdhPJxETamqFi5zkOw06l3Tp+NSNEkaTDzqtNwNnisPrhkZdLtx8XcQgkZ5FkusZb9DveNbwGLgdw==
X-Received: by 2002:a17:902:b088:: with SMTP id p8mr1638177plr.86.1599670575585;
        Wed, 09 Sep 2020 09:56:15 -0700 (PDT)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id il14sm2370370pjb.54.2020.09.09.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:56:14 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi@sslab.ics.keio.ac.jp,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yuval Bason <yuval.bason@cavium.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qedr: fix resource leak in qedr_create_qp
Date:   Wed,  9 Sep 2020 16:55:59 +0000
Message-Id: <20200909165600.20556-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When xa_insert() fails, the acquired resource in qedr_create_qp should
also be freed. However, current implementation does not handle the
error.

Fix this by adding a new goto label that calls qedr_free_qp_resources.

Fixes: 1212767e23bb ("qedr: Add wrapping generic structure for qpidr and
adjust idr routines.")
Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 drivers/infiniband/hw/qedr/verbs.c | 48 ++++++++++++++++--------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index b49bef94637e..19688773c58b 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2112,6 +2112,28 @@ static int qedr_create_kernel_qp(struct qedr_dev *dev,
 	return rc;
 }
 
+static int qedr_free_qp_resources(struct qedr_dev *dev, struct qedr_qp *qp,
+				  struct ib_udata *udata)
+{
+	struct qedr_ucontext *ctx =
+		rdma_udata_to_drv_context(udata, struct qedr_ucontext,
+					  ibucontext);
+	int rc;
+
+	if (qp->qp_type != IB_QPT_GSI) {
+		rc = dev->ops->rdma_destroy_qp(dev->rdma_ctx, qp->qed_qp);
+		if (rc)
+			return rc;
+	}
+
+	if (qp->create_type == QEDR_QP_CREATE_USER)
+		qedr_cleanup_user(dev, ctx, qp);
+	else
+		qedr_cleanup_kernel(dev, qp);
+
+	return 0;
+}
+
 struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
 			     struct ib_qp_init_attr *attrs,
 			     struct ib_udata *udata)
@@ -2165,11 +2187,13 @@ struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
 	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
 		rc = xa_insert(&dev->qps, qp->qp_id, qp, GFP_KERNEL);
 		if (rc)
-			goto err;
+			goto err2;
 	}
 
 	return &qp->ibqp;
 
+err2:
+	qedr_free_qp_resources(dev, qp, udata);
 err:
 	kfree(qp);
 
@@ -2671,28 +2695,6 @@ int qedr_query_qp(struct ib_qp *ibqp,
 	return rc;
 }
 
-static int qedr_free_qp_resources(struct qedr_dev *dev, struct qedr_qp *qp,
-				  struct ib_udata *udata)
-{
-	struct qedr_ucontext *ctx =
-		rdma_udata_to_drv_context(udata, struct qedr_ucontext,
-					  ibucontext);
-	int rc;
-
-	if (qp->qp_type != IB_QPT_GSI) {
-		rc = dev->ops->rdma_destroy_qp(dev->rdma_ctx, qp->qed_qp);
-		if (rc)
-			return rc;
-	}
-
-	if (qp->create_type == QEDR_QP_CREATE_USER)
-		qedr_cleanup_user(dev, ctx, qp);
-	else
-		qedr_cleanup_kernel(dev, qp);
-
-	return 0;
-}
-
 int qedr_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct qedr_qp *qp = get_qedr_qp(ibqp);
-- 
2.17.1

