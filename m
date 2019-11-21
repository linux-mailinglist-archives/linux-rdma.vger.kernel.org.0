Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4315105931
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKUSOu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:14:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSOu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:14:50 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C02B12068E;
        Thu, 21 Nov 2019 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360089;
        bh=2Ov+7H0Rwlv2jh8mlF75RBpfNhpvW3JxM3BgFz8C3j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYNAlQFhm3Ss+HrjljkX/no8K1ranu8FTKrUnVzbyIUQ/G674+lQ1eKmZlylWWZqd
         2LdI7BXUXGq+IjzP25AlG64B2bb/FIudsbY2U/dQg08epYkAvtpkfsPZkrZOIJ63aX
         bXurXvuYAEjQoQOlNhdaSuZ29pXdV0tOjVfUkAjA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 27/48] RDMA/cm: Convert REQ MAX CM retries
Date:   Thu, 21 Nov 2019 20:12:52 +0200
Message-Id: <20191121181313.129430-28-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121181313.129430-1-leon@kernel.org>
References: <20191121181313.129430-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Convert REQ MAX CM retries to new scheme.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h | 11 -----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 549ea886f0de..1b0cdaea035e 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1290,7 +1290,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		param->local_cm_response_timeout);
 	req_msg->pkey = param->primary_path->pkey;
 	IBA_SET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg, param->primary_path->mtu);
-	cm_req_set_max_cm_retries(req_msg, param->max_cm_retries);
+	IBA_SET(CM_REQ_MAX_CM_RETRIES, req_msg, param->max_cm_retries);
 
 	if (param->qp_type != IB_QPT_XRC_INI) {
 		IBA_SET(CM_REQ_RESPONDED_RESOURCES, req_msg,
@@ -2028,7 +2028,7 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->tid = req_msg->hdr.tid;
 	cm_id_priv->timeout_ms = cm_convert_to_ms(
 		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg));
-	cm_id_priv->max_cm_retries = cm_req_get_max_cm_retries(req_msg);
+	cm_id_priv->max_cm_retries = IBA_GET(CM_REQ_MAX_CM_RETRIES, req_msg);
 	cm_id_priv->remote_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
 	cm_id_priv->initiator_depth = IBA_GET(CM_REQ_RESPONDED_RESOURCES, req_msg);
 	cm_id_priv->responder_resources = IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index a754c7fa4fc0..54573280652a 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,17 +70,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_max_cm_retries(struct cm_req_msg *req_msg)
-{
-	return req_msg->offset51 >> 4;
-}
-
-static inline void cm_req_set_max_cm_retries(struct cm_req_msg *req_msg,
-					     u8 retries)
-{
-	req_msg->offset51 = (u8) ((req_msg->offset51 & 0xF) | (retries << 4));
-}
-
 static inline u8 cm_req_get_srq(struct cm_req_msg *req_msg)
 {
 	return (req_msg->offset51 & 0x8) >> 3;
-- 
2.20.1

