Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6446311C9A2
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfLLJlB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbfLLJlB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:41:01 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 167E42173E;
        Thu, 12 Dec 2019 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143660;
        bh=yc1DwBpFalJ1L0F08H1FGhIh6TYw+bXEDBqhVhhRwdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHAfsfi1ELJxojF7rzBKUwkOc8XjRWWEXsGQOrIw/cEHu2tJeruDthR4D85PqmMl0
         8V482OnVkr5ot1Ydsg8xX/Lliwd3pLszCYEH4BQW4Qm9Dh3qqlUTmKwXIBi/dgRq8V
         IRQbAA+EuSdZsCvL+lATslalSddHx91akJ4la8l8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 45/48] RDMA/cm: Delete unused CM ARP functions
Date:   Thu, 12 Dec 2019 11:38:27 +0200
Message-Id: <20191212093830.316934-46-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212093830.316934-1-leon@kernel.org>
References: <20191212093830.316934-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Clean the code by deleting ARP functions, which are not called anyway.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 66 ------------------------------------
 include/rdma/ib_cm.h         | 34 -------------------
 2 files changed, 100 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 0db15799969f..41422bf13279 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3238,72 +3238,6 @@ deref:	cm_deref_id(cm_id_priv);
 	return -EINVAL;
 }
 
-static void cm_format_apr(struct cm_apr_msg *apr_msg,
-			  struct cm_id_private *cm_id_priv,
-			  enum ib_cm_apr_status status,
-			  void *info,
-			  u8 info_length,
-			  const void *private_data,
-			  u8 private_data_len)
-{
-	cm_format_mad_hdr(&apr_msg->hdr, CM_APR_ATTR_ID, cm_id_priv->tid);
-	apr_msg->local_comm_id = cm_id_priv->id.local_id;
-	apr_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	apr_msg->ap_status = (u8) status;
-
-	if (info && info_length) {
-		apr_msg->info_length = info_length;
-		memcpy(apr_msg->info, info, info_length);
-	}
-
-	if (private_data && private_data_len)
-		memcpy(apr_msg->private_data, private_data, private_data_len);
-}
-
-int ib_send_cm_apr(struct ib_cm_id *cm_id,
-		   enum ib_cm_apr_status status,
-		   void *info,
-		   u8 info_length,
-		   const void *private_data,
-		   u8 private_data_len)
-{
-	struct cm_id_private *cm_id_priv;
-	struct ib_mad_send_buf *msg;
-	unsigned long flags;
-	int ret;
-
-	if ((private_data && private_data_len > CM_APR_PRIVATE_DATA_SIZE) ||
-	    (info && info_length > CM_APR_ADDITIONAL_INFORMATION_SIZE))
-		return -EINVAL;
-
-	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	spin_lock_irqsave(&cm_id_priv->lock, flags);
-	if (cm_id->state != IB_CM_ESTABLISHED ||
-	    (cm_id->lap_state != IB_CM_LAP_RCVD &&
-	     cm_id->lap_state != IB_CM_MRA_LAP_SENT)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = cm_alloc_msg(cm_id_priv, &msg);
-	if (ret)
-		goto out;
-
-	cm_format_apr((struct cm_apr_msg *) msg->mad, cm_id_priv, status,
-		      info, info_length, private_data, private_data_len);
-	ret = ib_post_send_mad(msg, NULL);
-	if (ret) {
-		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-		cm_free_msg(msg);
-		return ret;
-	}
-
-	cm_id->lap_state = IB_CM_LAP_IDLE;
-out:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(ib_send_cm_apr);
-
 static int cm_apr_handler(struct cm_work *work)
 {
 	struct cm_id_private *cm_id_priv;
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 6237c369dbd6..adccdc12b8e3 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -483,21 +483,6 @@ int ib_send_cm_mra(struct ib_cm_id *cm_id,
 		   const void *private_data,
 		   u8 private_data_len);
 
-/**
- * ib_send_cm_lap - Sends a load alternate path request.
- * @cm_id: Connection identifier associated with the load alternate path
- *   message.
- * @alternate_path: A path record that identifies the alternate path to
- *   load.
- * @private_data: Optional user-defined private data sent with the
- *   load alternate path message.
- * @private_data_len: Size of the private data buffer, in bytes.
- */
-int ib_send_cm_lap(struct ib_cm_id *cm_id,
-		   struct sa_path_rec *alternate_path,
-		   const void *private_data,
-		   u8 private_data_len);
-
 /**
  * ib_cm_init_qp_attr - Initializes the QP attributes for use in transitioning
  *   to a specified QP state.
@@ -518,25 +503,6 @@ int ib_cm_init_qp_attr(struct ib_cm_id *cm_id,
 		       struct ib_qp_attr *qp_attr,
 		       int *qp_attr_mask);
 
-/**
- * ib_send_cm_apr - Sends an alternate path response message in response to
- *   a load alternate path request.
- * @cm_id: Connection identifier associated with the alternate path response.
- * @status: Reply status sent with the alternate path response.
- * @info: Optional additional information sent with the alternate path
- *   response.
- * @info_length: Size of the additional information, in bytes.
- * @private_data: Optional user-defined private data sent with the
- *   alternate path response message.
- * @private_data_len: Size of the private data buffer, in bytes.
- */
-int ib_send_cm_apr(struct ib_cm_id *cm_id,
-		   enum ib_cm_apr_status status,
-		   void *info,
-		   u8 info_length,
-		   const void *private_data,
-		   u8 private_data_len);
-
 struct ib_cm_sidr_req_param {
 	struct sa_path_rec	*path;
 	const struct ib_gid_attr *sgid_attr;
-- 
2.20.1

