Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A02666F3
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 19:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgIKMxw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 08:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgIKMwR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Sep 2020 08:52:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4D6C061757
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 05:52:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md22so2617144pjb.0
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JBjfpNNCcSR2lMWRcTwj2x61e5MJUnNyTU2oRJeCo1g=;
        b=NhAveaOXGgERFl5ZKAud73NbmDI+dThozoPKNkxWvHQ5bB9w4oQAsCV7WHF56spxyM
         r3yo0OOfZZUURq8/cDZCSBXjtQ3F4SxJhmLHkGyyKTrZWw+GNFPKr3XJuxFS/PGI6o0U
         iBPVkclSUf3GeXFWPTRuc8PE8xvyULPLxbrYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JBjfpNNCcSR2lMWRcTwj2x61e5MJUnNyTU2oRJeCo1g=;
        b=aPE6r0QJdjCiakaqn1rdPlzVb3CRcmlGIc+KnxLPOY3MKv/y8uEWsii+l0U0BJr4T1
         ySN6NeK98FSaNiAzIll7bhCdOcOqaY20Hq1pXb7+EfLoBJ8oSlomz8iIoqLtTWRTdm/l
         HIdCknP07rVICKzM6QyiQgA7NLc7dd4kWNeRsh4FPbW4jK8KvQrKB83v5AajJGT07gOd
         Y5zoVcQhCDK2w73sznAZ6E4sA9p4MyCZe0hyIL2pGeEiQuj+wNTfzB8mGj8UY0Hk5Vfh
         x5hvrpb5PMpcNZweEiClhJx4gqcpKKHTsPx9UAZ28Tm8qzu4fWmcZ9qGvuebhUXr16cb
         fZEQ==
X-Gm-Message-State: AOAM532pi7cjXLYtL6nrFxJtMXkaF3F0+LBrgPjc2E/Aa3Pom/vEr7Gg
        dWrXGk77qC3SKnQ1Hy93Zep0TA==
X-Google-Smtp-Source: ABdhPJyxE06IXjEiMlIdvqyFhkPPd6AGf7OYQAxMt+Shm1MLO4D2RnAX3Pg5Tyn7r0RrhY1jVdobag==
X-Received: by 2002:a17:90b:d90:: with SMTP id bg16mr2084477pjb.199.1599828736809;
        Fri, 11 Sep 2020 05:52:16 -0700 (PDT)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id gg13sm1239543pjb.3.2020.09.11.05.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 05:52:16 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi@sslab.ics.keio.ac.jp,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yuval Bason <yuval.bason@cavium.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] qedr: fix resource leak in qedr_create_qp
Date:   Fri, 11 Sep 2020 12:51:59 +0000
Message-Id: <20200911125159.4577-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <AEYrHjmsd4Sp2R54y55pVL3CXr1KXedoBnTEczCBkpE9+SsFNg@mail.gmail.com>
References: <AEYrHjmsd4Sp2R54y55pVL3CXr1KXedoBnTEczCBkpE9+SsFNg@mail.gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When xa_insert() fails, the acquired resource in qedr_create_qp should
also be freed. However, current implementation does not handle the
error.

Fix this by adding a new goto label that calls qedr_free_qp_resources.

Fixes: 1212767e23bb ("qedr: Add wrapping generic structure for qpidr and adjust idr routines.")
Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
changelog(v3): Fix linebreak of the fix tag
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

