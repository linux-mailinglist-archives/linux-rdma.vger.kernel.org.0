Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D64B317F330
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCJJO4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgCJJO4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:14:56 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2627424681;
        Tue, 10 Mar 2020 09:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583831695;
        bh=yTxZyrNlPUu8Xn9pVGUDo+SdE99/2OynMlpiQKJMIEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2WhhfiHB/+AiFOuKDBSTQxX3j6BhjP0BvFcVUEzSSocaB2nr4xwa5AxpbSlDxJW0
         XCel/c4dQw1AxK6ua+cdNwy6t5FYOIaVNFErZg6s9pr7efS0iZ0CS9Gh+lkWoribvQ
         PRIDxXJrJiSRA2YX/y3eyBoZy+tC1/LXqMxwxDHc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v1 05/11] RDMA/cm: Delete not implemented CM peer to peer communication
Date:   Tue, 10 Mar 2020 11:14:32 +0200
Message-Id: <20200310091438.248429-6-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310091438.248429-1-leon@kernel.org>
References: <20200310091438.248429-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Peer to peer support was never implemented, so delete it to make
code less clutter.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Mark Zhang <markz@mellanox.com>
---
 drivers/infiniband/core/cm.c | 7 -------
 include/rdma/ib_cm.h         | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index aec6867f0ed2..77190704e81b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -261,7 +261,6 @@ struct cm_id_private {
 	__be16 pkey;
 	u8 private_data_len;
 	u8 max_cm_retries;
-	u8 peer_to_peer;
 	u8 responder_resources;
 	u8 initiator_depth;
 	u8 retry_count;
@@ -1380,10 +1379,6 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 
 static int cm_validate_req_param(struct ib_cm_req_param *param)
 {
-	/* peer-to-peer not supported */
-	if (param->peer_to_peer)
-		return -EINVAL;
-
 	if (!param->primary_path)
 		return -EINVAL;
 
@@ -2436,8 +2431,6 @@ static int cm_rep_handler(struct cm_work *work)
 			cm_ack_timeout(cm_id_priv->target_ack_delay,
 				       cm_id_priv->alt_av.timeout - 1);
 
-	/* todo: handle peer_to_peer */
-
 	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
 	ret = atomic_inc_and_test(&cm_id_priv->work_count);
 	if (!ret)
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 8ec482e391aa..058cfbc2b37f 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -360,7 +360,6 @@ struct ib_cm_req_param {
 	u32			starting_psn;
 	const void		*private_data;
 	u8			private_data_len;
-	u8			peer_to_peer;
 	u8			responder_resources;
 	u8			initiator_depth;
 	u8			remote_cm_response_timeout;
-- 
2.24.1

