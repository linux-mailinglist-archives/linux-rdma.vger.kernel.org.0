Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4C1264ADD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 19:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgIJROz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 13:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIJQfB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Sep 2020 12:35:01 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E28C0617AB
        for <linux-rdma@vger.kernel.org>; Thu, 10 Sep 2020 09:34:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 67so4501077pgd.12
        for <linux-rdma@vger.kernel.org>; Thu, 10 Sep 2020 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FaJXhfrjUU4Eb8omzwhQgbkduynoMOFupoGOfbaZ3s0=;
        b=d8XEy/h9aLwc461GtbYpEe6YJG5kQc027sQcQm8cbVphWcNTxqAgmcr9eSuRX9UQQ9
         26gVkQDbm6fPZ7+oet9lRe3ok5l8ezihGzUh4bzHJA63YTEZze9hlwD3/2FlMzV/2BXl
         XuEa2TERzj29I2cbOZy3ofzWAigoEqHbPHn/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FaJXhfrjUU4Eb8omzwhQgbkduynoMOFupoGOfbaZ3s0=;
        b=fRdNdJzSJSYlYoA0EBAIG31dcTaNV6r3VGC49LAbDo7rtPZSXLt/pKq/iZTujEdxHy
         1D1bEV/1JiFYKGC1+WMZlCrevpQKxOPOnhGdfXSjOotHzLt3kFxzVk8NNYoIoD3MNCa4
         gFdNb3EEbi2bcK6B2jtmjHJG5QfMqZ8VYi9pbvSSDYQMsiXzy67oFv2aBNa8AB+6KrsN
         7illZEIy1OJZbauL2dFSz87A18vLcTCQjyqKVRdWXwnrE4ADzahsRpdu+0UN2/SC45YA
         U7ia1FvfgDM79BD3+5Xc4ThcFf16CWbmc9XvMES1GJufMgSYQ1rEP944gxH+He4/SYtX
         QjZg==
X-Gm-Message-State: AOAM530ZqhCVBIUU4Jnj/RiUT46lF7qS1q04W2i5ZvPRUCfW6+Xh4+mg
        0CVNfboLjk2QpmWh+gfWAWg0aQ==
X-Google-Smtp-Source: ABdhPJz8+1xKmpNVjR270T+PrLOO0s0m0+KunPLaRqaGMSDDT6h8BgUh8KAPaMIEr504buLU1S6p+Q==
X-Received: by 2002:a63:1402:: with SMTP id u2mr4824306pgl.400.1599755698842;
        Thu, 10 Sep 2020 09:34:58 -0700 (PDT)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id x25sm5586983pgk.26.2020.09.10.09.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 09:34:58 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi@sslab.ics.keio.ac.jp,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yuval Bason <yuval.bason@cavium.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] qedr: fix resource leak in qedr_create_qp
Date:   Thu, 10 Sep 2020 16:34:38 +0000
Message-Id: <20200910163438.20495-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAEYrHj=pfGB7OuHt90t2aaawr31W9XZCHeHJurt3o0rK44jZ+A@mail.gmail.com>
References: <CAEYrHj=pfGB7OuHt90t2aaawr31W9XZCHeHJurt3o0rK44jZ+A@mail.gmail.com>
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
changelog(v2): Change numbered labels to descriptive labels

 drivers/infiniband/hw/qedr/verbs.c | 52 ++++++++++++++++--------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index b49bef94637e..3b4c84f67023 100644
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
@@ -2158,19 +2180,21 @@ struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
 		rc = qedr_create_kernel_qp(dev, qp, ibpd, attrs);
 
 	if (rc)
-		goto err;
+		goto out_free_qp;
 
 	qp->ibqp.qp_num = qp->qp_id;
 
 	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
 		rc = xa_insert(&dev->qps, qp->qp_id, qp, GFP_KERNEL);
 		if (rc)
-			goto err;
+			goto out_free_qp_resources;
 	}
 
 	return &qp->ibqp;
 
-err:
+out_free_qp_resources:
+	qedr_free_qp_resources(dev, qp, udata);
+out_free_qp:
 	kfree(qp);
 
 	return ERR_PTR(-EFAULT);
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

