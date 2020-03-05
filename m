Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB217A866
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCEPBY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgCEPBY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:01:24 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2750E20801;
        Thu,  5 Mar 2020 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420483;
        bh=ZhprH3dSSGzXl4em1h3FvJt6V2LvO3EYwAPLHRbzQv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yMLtb4qkAdkC+K4uv/FZSDgZkLP8rOYtoPvqkGre/1GwPl6PMCmluJVwL068qciT/
         nf9e7JgcSebk7vvp/eVDVB2/yzqzj+ZkLFj2BeNwlMBXwUDfz/XPU/Q8cbCLqJLDsw
         6U8oIHsGo7apVFvyZJ2Hb45B0mVvoW5Q3tSsI2eQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 5/9] RDMA/ucma: Extend ucma_connect to receive ECE parameters
Date:   Thu,  5 Mar 2020 17:01:01 +0200
Message-Id: <20200305150105.207959-6-leon@kernel.org>
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

Active side of CMID initiates connection through librdmacm's rdma_connect()
and kernel's ucma_connect(). Extend UCMA interface to handle those new
parameters.

Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c      | 13 +++++++++++++
 drivers/infiniband/core/cma_priv.h |  1 +
 drivers/infiniband/core/ucma.c     | 14 +++++++++++---
 include/rdma/rdma_cm.h             | 11 +++++++++++
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 5165158a7aaa..b16f74c7be10 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4000,6 +4000,19 @@ int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 }
 EXPORT_SYMBOL(rdma_connect);

+int rdma_connect_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
+		     struct rdma_ucm_ece *ece)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+
+	id_priv->ece.vendor_id = ece->vendor_id;
+	id_priv->ece.attr_mod = ece->attr_mod;
+
+	return rdma_connect(id, conn_param);
+}
+EXPORT_SYMBOL(rdma_connect_ece);
+
 static int cma_accept_ib(struct rdma_id_private *id_priv,
 			 struct rdma_conn_param *conn_param)
 {
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index 5edcf44a9307..caece96ebcf5 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -95,6 +95,7 @@ struct rdma_id_private {
 	 * Internal to RDMA/core, don't use in the drivers
 	 */
 	struct rdma_restrack_entry     res;
+	struct rdma_ucm_ece ece;
 };

 #if IS_ENABLED(CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS)
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 16b6cf57fa85..c06394350fed 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1070,12 +1070,15 @@ static void ucma_copy_conn_param(struct rdma_cm_id *id,
 static ssize_t ucma_connect(struct ucma_file *file, const char __user *inbuf,
 			    int in_len, int out_len)
 {
-	struct rdma_ucm_connect cmd;
 	struct rdma_conn_param conn_param;
+	struct rdma_ucm_ece ece = {};
+	struct rdma_ucm_connect cmd;
 	struct ucma_context *ctx;
+	size_t in_size;
 	int ret;

-	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+	in_size = min_t(size_t, in_len, sizeof(cmd));
+	if (copy_from_user(&cmd, inbuf, in_size))
 		return -EFAULT;

 	if (!cmd.conn_param.valid)
@@ -1086,8 +1089,13 @@ static ssize_t ucma_connect(struct ucma_file *file, const char __user *inbuf,
 		return PTR_ERR(ctx);

 	ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
+	if (field_avail(cmd, ece, in_size)) {
+		ece.vendor_id = cmd.ece.vendor_id;
+		ece.attr_mod = cmd.ece.attr_mod;
+	}
+
 	mutex_lock(&ctx->mutex);
-	ret = rdma_connect(ctx->cm_id, &conn_param);
+	ret = rdma_connect_ece(ctx->cm_id, &conn_param, &ece);
 	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return ret;
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 71f48cfdc24c..86a849214c84 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -264,6 +264,17 @@ int rdma_init_qp_attr(struct rdma_cm_id *id, struct ib_qp_attr *qp_attr,
  */
 int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param);

+/**
+ * rdma_connect_ece - Initiate an active connection request with ECE data.
+ * @id: Connection identifier to connect.
+ * @conn_param: Connection information used for connected QPs.
+ * @ece: ECE parameters
+ *
+ * See rdma_connect() explanation.
+ */
+int rdma_connect_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
+		     struct rdma_ucm_ece *ece);
+
 /**
  * rdma_listen - This function is called by the passive side to
  *   listen for incoming connection requests.
--
2.24.1

