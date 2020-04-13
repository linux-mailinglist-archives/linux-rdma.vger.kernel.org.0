Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E071A67B2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 16:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgDMOQJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 10:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730466AbgDMOQI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 10:16:08 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821E020774;
        Mon, 13 Apr 2020 14:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586787368;
        bh=0+DYeGxuA3rBGJsMtNwcPFFDVHi7+1Guj97iek2BZSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwNjP0zIpPA5KHvx512F8y0iWS0OvqEFIYgzfMUwYVlDePUMghHTheLHoTcgLOt9o
         HomuwMSzju2JmH/2JxhqV0md7p919BOCxoH+i36xnXFeKcHx9TKxBwyDdGJOhsnUkK
         B0RPaIzvvH13ctV/9rZ9JK62X8MlFPDB0IBPRVbw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 6/7] RDMA/cma: Connect ECE to rdma_accept
Date:   Mon, 13 Apr 2020 17:15:37 +0300
Message-Id: <20200413141538.935574-7-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413141538.935574-1-leon@kernel.org>
References: <20200413141538.935574-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The rdma_accept() is called by both passive and active
sides of CMID connection to mark readiness to start data
transfer. For passive side, this is called explicitly,
for active side, it is called implicitly while receiving
REP message.

Provide ECE data to rdma_accept function needed for passive
side to send that REP message.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c    | 19 +++++++++++++++++++
 drivers/infiniband/core/ucma.c   | 14 +++++++++++---
 include/rdma/rdma_cm.h           |  3 +++
 include/uapi/rdma/rdma_user_cm.h |  1 +
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index e33e47caab08..409f752f40ae 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4077,6 +4077,8 @@ static int cma_accept_ib(struct rdma_id_private *id_priv,
 	rep.flow_control = conn_param->flow_control;
 	rep.rnr_retry_count = min_t(u8, 7, conn_param->rnr_retry_count);
 	rep.srq = id_priv->srq ? 1 : 0;
+	rep.ece.vendor_id = id_priv->ece.vendor_id;
+	rep.ece.attr_mod = id_priv->ece.attr_mod;
 
 	trace_cm_send_rep(id_priv);
 	ret = ib_send_cm_rep(id_priv->cm_id.ib, &rep);
@@ -4124,7 +4126,11 @@ static int cma_send_sidr_rep(struct rdma_id_private *id_priv,
 			return ret;
 		rep.qp_num = id_priv->qp_num;
 		rep.qkey = id_priv->qkey;
+
+		rep.ece.vendor_id = id_priv->ece.vendor_id;
+		rep.ece.attr_mod = id_priv->ece.attr_mod;
 	}
+
 	rep.private_data = private_data;
 	rep.private_data_len = private_data_len;
 
@@ -4182,6 +4188,19 @@ int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 }
 EXPORT_SYMBOL(__rdma_accept);
 
+int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
+		      const char *caller, struct rdma_ucm_ece *ece)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+
+	id_priv->ece.vendor_id = ece->vendor_id;
+	id_priv->ece.attr_mod = ece->attr_mod;
+
+	return __rdma_accept(id, conn_param, caller);
+}
+EXPORT_SYMBOL(__rdma_accept_ece);
+
 int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event)
 {
 	struct rdma_id_private *id_priv;
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index b67cdd2ef187..d41598954cc4 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1132,28 +1132,36 @@ static ssize_t ucma_accept(struct ucma_file *file, const char __user *inbuf,
 {
 	struct rdma_ucm_accept cmd;
 	struct rdma_conn_param conn_param;
+	struct rdma_ucm_ece ece = {};
 	struct ucma_context *ctx;
+	size_t in_size;
 	int ret;
 
-	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+	in_size = min_t(size_t, in_len, sizeof(cmd));
+	if (copy_from_user(&cmd, inbuf, in_size))
 		return -EFAULT;
 
 	ctx = ucma_get_ctx_dev(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	if (offsetofend(typeof(cmd), ece) <= in_size) {
+		ece.vendor_id = cmd.ece.vendor_id;
+		ece.attr_mod = cmd.ece.attr_mod;
+	}
+
 	if (cmd.conn_param.valid) {
 		ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
 		mutex_lock(&file->mut);
 		mutex_lock(&ctx->mutex);
-		ret = __rdma_accept(ctx->cm_id, &conn_param, NULL);
+		ret = __rdma_accept_ece(ctx->cm_id, &conn_param, NULL, &ece);
 		mutex_unlock(&ctx->mutex);
 		if (!ret)
 			ctx->uid = cmd.uid;
 		mutex_unlock(&file->mut);
 	} else {
 		mutex_lock(&ctx->mutex);
-		ret = __rdma_accept(ctx->cm_id, NULL, NULL);
+		ret = __rdma_accept_ece(ctx->cm_id, NULL, NULL, &ece);
 		mutex_unlock(&ctx->mutex);
 	}
 	ucma_put_ctx(ctx);
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 761168c41848..8d961d8b7cdb 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -288,6 +288,9 @@ int rdma_listen(struct rdma_cm_id *id, int backlog);
 int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 		  const char *caller);
 
+int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
+		      const char *caller, struct rdma_ucm_ece *ece);
+
 /**
  * rdma_accept - Called to accept a connection request or response.
  * @id: Connection identifier associated with the request.
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index 150b3f075f99..c4ca1412bcf9 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -228,6 +228,7 @@ struct rdma_ucm_accept {
 	struct rdma_ucm_conn_param conn_param;
 	__u32 id;
 	__u32 reserved;
+	struct rdma_ucm_ece ece;
 };
 
 struct rdma_ucm_reject {
-- 
2.25.2

