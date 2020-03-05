Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C988A17A86A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCEPBh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:01:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgCEPBh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:01:37 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8FAE20801;
        Thu,  5 Mar 2020 15:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420496;
        bh=jY00GYGJcow2hOEZSpZyW/IhqHsGuuCSVkwXU4RYp+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCH21xq5YdKxu7YL90+qWv/FYRMDojwpxlLpRqP6eBZ8pC/YX3vH/NwA3qEZrbx3m
         mw2zZckUo8LOKfcrLVZJuaUqYB2Wkytk5IlHJYYgSuVUekzQdgB3cSs+DqSiFssrG8
         8t0gNJRKn3oCeWhqsIhAjz4oglxleErrx+WkL+Qc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 9/9] RDMA/cma: Provide ECE reject reason
Date:   Thu,  5 Mar 2020 17:01:05 +0200
Message-Id: <20200305150105.207959-10-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305150105.207959-1-leon@kernel.org>
References: <20200305150105.207959-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

IBTA declares "vendor option not supported" reject reason in REJ
messages if passive side doesn't want to accept proposed ECE options.

Due to the fact that ECE is managed by userspace, there is a need to let
users to provide such rejected reason.

Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c    | 14 ++++++++------
 drivers/infiniband/core/ucma.c   |  7 ++++++-
 include/rdma/ib_cm.h             |  3 ++-
 include/rdma/rdma_cm.h           | 13 ++++++++++---
 include/uapi/rdma/rdma_user_cm.h |  7 ++++++-
 5 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index f1f0d51667b7..0b57c15139cf 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4191,8 +4191,8 @@ int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event)
 }
 EXPORT_SYMBOL(rdma_notify);

-int rdma_reject(struct rdma_cm_id *id, const void *private_data,
-		u8 private_data_len)
+int rdma_reject_ece(struct rdma_cm_id *id, const void *private_data,
+		    u8 private_data_len, enum rdma_ucm_reject_reason reason)
 {
 	struct rdma_id_private *id_priv;
 	int ret;
@@ -4206,10 +4206,12 @@ int rdma_reject(struct rdma_cm_id *id, const void *private_data,
 			ret = cma_send_sidr_rep(id_priv, IB_SIDR_REJECT, 0,
 						private_data, private_data_len);
 		} else {
+			enum ib_cm_rej_reason r =
+				(reason) ?: IB_CM_REJ_CONSUMER_DEFINED;
+
 			trace_cm_send_rej(id_priv);
-			ret = ib_send_cm_rej(id_priv->cm_id.ib,
-					     IB_CM_REJ_CONSUMER_DEFINED, NULL,
-					     0, private_data, private_data_len);
+			ret = ib_send_cm_rej(id_priv->cm_id.ib, r, NULL, 0,
+					     private_data, private_data_len);
 		}
 	} else if (rdma_cap_iw_cm(id->device, id->port_num)) {
 		ret = iw_cm_reject(id_priv->cm_id.iw,
@@ -4219,7 +4221,7 @@ int rdma_reject(struct rdma_cm_id *id, const void *private_data,

 	return ret;
 }
-EXPORT_SYMBOL(rdma_reject);
+EXPORT_SYMBOL(rdma_reject_ece);

 int rdma_disconnect(struct rdma_cm_id *id)
 {
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 135453f75733..1b5fd3020bcb 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1178,12 +1178,17 @@ static ssize_t ucma_reject(struct ucma_file *file, const char __user *inbuf,
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;

+	if (cmd.reason &&
+	    cmd.reason != RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED)
+		return -EINVAL;
+
 	ctx = ucma_get_ctx_dev(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);

 	mutex_lock(&ctx->mutex);
-	ret = rdma_reject(ctx->cm_id, cmd.private_data, cmd.private_data_len);
+	ret = rdma_reject_ece(ctx->cm_id, cmd.private_data,
+			      cmd.private_data_len, cmd.reason);
 	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return ret;
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 0f1ea5f2d01c..ed328a99ed0a 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -168,7 +168,8 @@ enum ib_cm_rej_reason {
 	IB_CM_REJ_INVALID_CLASS_VERSION		= 31,
 	IB_CM_REJ_INVALID_FLOW_LABEL		= 32,
 	IB_CM_REJ_INVALID_ALT_FLOW_LABEL	= 33,
-	IB_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED	= 35,
+	IB_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED	=
+		RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED,
 };

 struct ib_cm_rej_event_param {
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 8d961d8b7cdb..56d85d30e55d 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -324,11 +324,18 @@ int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
  */
 int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event);

+
 /**
- * rdma_reject - Called to reject a connection request or response.
+ * rdma_reject_ece - Called to reject a connection request or response.
  */
-int rdma_reject(struct rdma_cm_id *id, const void *private_data,
-		u8 private_data_len);
+int rdma_reject_ece(struct rdma_cm_id *id, const void *private_data,
+		    u8 private_data_len, enum rdma_ucm_reject_reason reason);
+
+static inline int rdma_reject(struct rdma_cm_id *id, const void *private_data,
+			      u8 private_data_len)
+{
+	return rdma_reject_ece(id, private_data, private_data_len, 0);
+}

 /**
  * rdma_disconnect - This function disconnects the associated QP and
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index c4ca1412bcf9..e545f2de1e13 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -78,6 +78,10 @@ enum rdma_ucm_port_space {
 	RDMA_PS_UDP   = 0x0111,
 };

+enum rdma_ucm_reject_reason {
+	RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED = 35
+};
+
 /*
  * command ABI structures.
  */
@@ -234,7 +238,8 @@ struct rdma_ucm_accept {
 struct rdma_ucm_reject {
 	__u32 id;
 	__u8  private_data_len;
-	__u8  reserved[3];
+	__u8  reason; /* enum rdma_ucm_reject_reason */
+	__u8  reserved[2];
 	__u8  private_data[RDMA_MAX_PRIVATE_DATA];
 };

--
2.24.1

