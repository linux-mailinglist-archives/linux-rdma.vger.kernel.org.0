Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9943D08B1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhGUFdk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 01:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233187AbhGUFcs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 01:32:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A48436108B;
        Wed, 21 Jul 2021 06:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626848005;
        bh=9wuYknJaOZOmuo04+Dx4qDkeTjvxx3y88Fl57uzY3HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3XCx5sdujT+2DVxXfxOrXHxi1RpDnyOkuCh4GAY/FOrzqKzSA/jCJmLbaG7KhCMW
         rWIeP1lSrVsqDuMaGycnyz2a52hHTmYuql9EZor9dmWGzdVPcLr1nIDIR0uV5TeALG
         WhHEHZdEtTEyPr6aIHIvV18iaTMjvNyN7/0J4pOs2ThRwzcT28kBkYLO98kh0A1B/u
         Lf7YggCkSixT9dNipZPjZb3DmQgec97k9rdqibCDuUauFpY1t/wq4mKwJtGlA2W/ta
         fzUsl9rUshlLQRsmoeLVAF9TSiFcGyDy+owkXkKL/kVYv1M5EGQ1uHvJoYUErimvrX
         M5qF1Mj0/I6bA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 5/7] RDMA/core: Configure selinux QP during creation
Date:   Wed, 21 Jul 2021 09:13:04 +0300
Message-Id: <c5c0e543e666d4402a0d6cdb39d1b0e46d185c60.1626846795.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626846795.git.leonro@nvidia.com>
References: <cover.1626846795.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

All QP creation flows called ib_create_qp_security(), but differently.
This caused to the need to provide exclusion conditions for the XRC_TGT,
because such QP already had selinux configuration call.

In order to fix it, move ib_create_qp_security() to the general QP
creation routine.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c          |  7 -------
 drivers/infiniband/core/uverbs_std_types_qp.c |  6 ------
 drivers/infiniband/core/verbs.c               | 11 +++++++----
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 8c8ca7bce3ca..b5153200b8a8 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1447,10 +1447,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	}
 
 	if (cmd->qp_type != IB_QPT_XRC_TGT) {
-		ret = ib_create_qp_security(qp, device);
-		if (ret)
-			goto err_cb;
-
 		atomic_inc(&pd->usecnt);
 		if (attr.send_cq)
 			atomic_inc(&attr.send_cq->usecnt);
@@ -1502,9 +1498,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
-err_cb:
-	ib_destroy_qp_user(qp, uverbs_get_cleared_udata(attrs));
-
 err_put:
 	if (!IS_ERR(xrcd_uobj))
 		uobj_put_read(xrcd_uobj);
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index c00cfb5ed387..92812f6a21b0 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -280,12 +280,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	obj->uevent.uobject.object = qp;
 	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_CREATE_QP_HANDLE);
 
-	if (attr.qp_type != IB_QPT_XRC_TGT) {
-		ret = ib_create_qp_security(qp, device);
-		if (ret)
-			return ret;
-	}
-
 	set_caps(&attr, &cap, false);
 	ret = uverbs_copy_to_struct_or_zero(attrs,
 					UVERBS_ATTR_CREATE_QP_RESP_CAP, &cap,
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 645962490fa4..612c73861e0d 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1216,6 +1216,7 @@ struct ib_qp *_ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
 			    struct ib_udata *udata, struct ib_uqp_object *uobj,
 			    const char *caller)
 {
+	struct ib_udata dummy = {};
 	struct ib_qp *qp;
 	int ret;
 
@@ -1257,9 +1258,15 @@ struct ib_qp *_ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
 	qp->send_cq = attr->send_cq;
 	qp->recv_cq = attr->recv_cq;
 
+	ret = ib_create_qp_security(qp, dev);
+	if (ret)
+		goto err_security;
+
 	rdma_restrack_add(&qp->res);
 	return qp;
 
+err_security:
+	qp->device->ops.destroy_qp(qp, udata ? &dummy : NULL);
 err_create:
 	rdma_restrack_put(&qp->res);
 	kfree(qp);
@@ -1298,10 +1305,6 @@ struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,
 	if (IS_ERR(qp))
 		return qp;
 
-	ret = ib_create_qp_security(qp, device);
-	if (ret)
-		goto err;
-
 	if (qp_init_attr->qp_type == IB_QPT_XRC_TGT) {
 		struct ib_qp *xrc_qp =
 			create_xrc_qp_user(qp, qp_init_attr);
-- 
2.31.1

