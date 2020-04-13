Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C121A67AB
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgDMOPz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 10:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbgDMOPy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 10:15:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F19E02075E;
        Mon, 13 Apr 2020 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586787353;
        bh=5SxG+vfqzQ0AIvyZx+UqeMEVznL1wxuQAfJTL29qngI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLMljx7CeXuvHgsJJanIRsNKWAqXAP4EwbDmacwNau2KfXmwVDk6kns7yCBy9nirx
         pzLGiDf8aM/Pv49cP8iZsSNFFRzozxlTpfBydqAv+/mnRP0IZjb8PKSMMJ5OuXm9Eu
         MEDaUxiv+h2OQkSaS6ezBJ0M7iAaAyyqv4ccMNQU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 3/7] RDMA/ucma: Extend ucma_connect to receive ECE parameters
Date:   Mon, 13 Apr 2020 17:15:34 +0300
Message-Id: <20200413141538.935574-4-leon@kernel.org>
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

Active side of CMID initiates connection through librdmacm's rdma_connect()
and kernel's ucma_connect(). Extend UCMA interface to handle those new
parameters.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c      | 13 +++++++++++++
 drivers/infiniband/core/cma_priv.h |  1 +
 drivers/infiniband/core/ucma.c     | 14 +++++++++++---
 include/rdma/rdma_cm.h             | 11 +++++++++++
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 22df46933d60..6ded5d3ecc1d 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4031,6 +4031,19 @@ int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
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
index 16b6cf57fa85..f7415d8d2140 100644
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
+	if (offsetofend(typeof(cmd), ece) <= in_size) {
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
2.25.2

