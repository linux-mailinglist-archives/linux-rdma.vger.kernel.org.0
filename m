Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70B019FBA2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2020 19:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgDFRct (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Apr 2020 13:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgDFRcs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Apr 2020 13:32:48 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E719D20672;
        Mon,  6 Apr 2020 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586194367;
        bh=HxCKWkSMdqVNCxAkgTk2gKC7iexpWiIjteVFfDXPTWE=;
        h=From:To:Cc:Subject:Date:From;
        b=DMOg+9KqNMfDSK9ckkNvGiEWnlwur5tw7dDV5R53s5e93GDOBwcdCzy4+O1BGaIiz
         biz8Al/YvLejaZsg6HO4oafVvDA1xrsfQzM1EbDRjza7vmC/86bY0QzTFHsxxs24jq
         hC8n5W9lg2ALX/az2/vft4LpVqIosSx/2mhIQEWc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/cm: Fix missing RDMA_CM_EVENT_REJECTED event after receiving REJ message
Date:   Mon,  6 Apr 2020 20:32:42 +0300
Message-Id: <20200406173242.1465911-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The cm_reset_to_idle() call before formatting event changed the CM_ID
state from IB_CM_REQ_RCVD to be IB_CM_IDLE. It caused to wrong value
of CM_REJ_MESSAGE_REJECTED field.

The result of that was that rdma_reject() calls in the passive side
didn't generate RDMA_CM_EVENT_REJECTED event in the active side.

Fixes: 81ddb41f876d ("RDMA/cm: Allow ib_send_cm_rej() to be done under lock")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index bbbfa77dbce7..06f8eeba423a 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1843,11 +1843,9 @@ static void cm_format_mra(struct cm_mra_msg *mra_msg,

 static void cm_format_rej(struct cm_rej_msg *rej_msg,
 			  struct cm_id_private *cm_id_priv,
-			  enum ib_cm_rej_reason reason,
-			  void *ari,
-			  u8 ari_length,
-			  const void *private_data,
-			  u8 private_data_len)
+			  enum ib_cm_rej_reason reason, void *ari,
+			  u8 ari_length, const void *private_data,
+			  u8 private_data_len, enum ib_cm_state state)
 {
 	lockdep_assert_held(&cm_id_priv->lock);

@@ -1855,7 +1853,7 @@ static void cm_format_rej(struct cm_rej_msg *rej_msg,
 	IBA_SET(CM_REJ_REMOTE_COMM_ID, rej_msg,
 		be32_to_cpu(cm_id_priv->id.remote_id));

-	switch(cm_id_priv->id.state) {
+	switch (state) {
 	case IB_CM_REQ_RCVD:
 		IBA_SET(CM_REJ_LOCAL_COMM_ID, rej_msg, be32_to_cpu(0));
 		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REQ);
@@ -1920,8 +1918,9 @@ static void cm_dup_req_handler(struct cm_work *work,
 			      cm_id_priv->private_data_len);
 		break;
 	case IB_CM_TIMEWAIT:
-		cm_format_rej((struct cm_rej_msg *) msg->mad, cm_id_priv,
-			      IB_CM_REJ_STALE_CONN, NULL, 0, NULL, 0);
+		cm_format_rej((struct cm_rej_msg *)msg->mad, cm_id_priv,
+			      IB_CM_REJ_STALE_CONN, NULL, 0, NULL, 0,
+			      cm_id_priv->id.state);
 		break;
 	default:
 		goto unlock;
@@ -2931,6 +2930,7 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 			      u8 ari_length, const void *private_data,
 			      u8 private_data_len)
 {
+	enum ib_cm_state state = cm_id_priv->id.state;
 	struct ib_mad_send_buf *msg;
 	int ret;

@@ -2940,7 +2940,7 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 	    (ari && ari_length > IB_CM_REJ_ARI_LENGTH))
 		return -EINVAL;

-	switch (cm_id_priv->id.state) {
+	switch (state) {
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
 	case IB_CM_REQ_RCVD:
@@ -2952,7 +2952,8 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 		if (ret)
 			return ret;
 		cm_format_rej((struct cm_rej_msg *)msg->mad, cm_id_priv, reason,
-			      ari, ari_length, private_data, private_data_len);
+			      ari, ari_length, private_data, private_data_len,
+			      state);
 		break;
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
@@ -2961,7 +2962,8 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 		if (ret)
 			return ret;
 		cm_format_rej((struct cm_rej_msg *)msg->mad, cm_id_priv, reason,
-			      ari, ari_length, private_data, private_data_len);
+			      ari, ari_length, private_data, private_data_len,
+			      state);
 		break;
 	default:
 		pr_debug("%s: local_id %d, cm_id->state: %d\n", __func__,
--
2.25.1

