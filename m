Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1755105955
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfKUSQI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:16:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSQI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:16:08 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CEA62068E;
        Thu, 21 Nov 2019 18:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360166;
        bh=rid3HTm6rY2jcUrHuYnN3h0yk8IqJIRA4Mkvmfum/W0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ll0HF5Vcu6TZnNUxa7B9ypLml5iS7IgS36TXDoZtY62O4doaonp9KQXlDlnS6d1N6
         WMqAMsr4oqm04KNsOPzxFukNu9Fam8Hft7af2srS1vmF1/cZYtkuLXV8SCV3M5duqs
         PNIbQrNqnFj+o1bdbQ/s47vPjbMS2Li4P5FRlZFY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 46/48] RDMA/cm: Convert SIDR_REP to new scheme
Date:   Thu, 21 Nov 2019 20:13:11 +0200
Message-Id: <20191121181313.129430-47-leon@kernel.org>
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

Use new scheme to access SIDR_REP fields.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 15 ++++++++-------
 drivers/infiniband/core/cm_msgs.h | 14 --------------
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 41422bf13279..f197f9740362 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3483,10 +3483,10 @@ static void cm_format_sidr_rep(struct cm_sidr_rep_msg *sidr_rep_msg,
 	cm_format_mad_hdr(&sidr_rep_msg->hdr, CM_SIDR_REP_ATTR_ID,
 			  cm_id_priv->tid);
 	sidr_rep_msg->request_id = cm_id_priv->id.remote_id;
-	sidr_rep_msg->status = param->status;
-	cm_sidr_rep_set_qpn(sidr_rep_msg, cpu_to_be32(param->qp_num));
+	IBA_SET(CM_SIDR_REP_STATUS, sidr_rep_msg, param->status);
+	IBA_SET(CM_SIDR_REP_QPN, sidr_rep_msg, param->qp_num);
 	sidr_rep_msg->service_id = cm_id_priv->id.service_id;
-	sidr_rep_msg->qkey = cpu_to_be32(param->qkey);
+	IBA_SET(CM_SIDR_REP_Q_KEY, sidr_rep_msg, param->qkey);
 
 	if (param->info && param->info_length)
 		memcpy(sidr_rep_msg->info, param->info, param->info_length);
@@ -3554,11 +3554,12 @@ static void cm_format_sidr_rep_event(struct cm_work *work,
 	sidr_rep_msg = (struct cm_sidr_rep_msg *)
 				work->mad_recv_wc->recv_buf.mad;
 	param = &work->cm_event.param.sidr_rep_rcvd;
-	param->status = sidr_rep_msg->status;
-	param->qkey = be32_to_cpu(sidr_rep_msg->qkey);
-	param->qpn = be32_to_cpu(cm_sidr_rep_get_qpn(sidr_rep_msg));
+	param->status = IBA_GET(CM_SIDR_REP_STATUS, sidr_rep_msg);
+	param->qkey = IBA_GET(CM_SIDR_REP_Q_KEY, sidr_rep_msg);
+	param->qpn = IBA_GET(CM_SIDR_REP_QPN, sidr_rep_msg);
 	param->info = &sidr_rep_msg->info;
-	param->info_len = sidr_rep_msg->info_length;
+	param->info_len =
+		IBA_GET(CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH, sidr_rep_msg);
 	param->sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &sidr_rep_msg->private_data;
 	work->cm_event.private_data_len = CM_SIDR_REP_PRIVATE_DATA_SIZE;
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 0f3f9f3cd1cb..ee3bd6f7dc47 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -232,18 +232,4 @@ struct cm_sidr_rep_msg {
 
 	u8 private_data[CM_SIDR_REP_PRIVATE_DATA_SIZE];
 } __packed;
-
-static inline __be32 cm_sidr_rep_get_qpn(struct cm_sidr_rep_msg *sidr_rep_msg)
-{
-	return cpu_to_be32(be32_to_cpu(sidr_rep_msg->offset8) >> 8);
-}
-
-static inline void cm_sidr_rep_set_qpn(struct cm_sidr_rep_msg *sidr_rep_msg,
-				       __be32 qpn)
-{
-	sidr_rep_msg->offset8 = cpu_to_be32((be32_to_cpu(qpn) << 8) |
-					(be32_to_cpu(sidr_rep_msg->offset8) &
-					 0x000000FF));
-}
-
 #endif /* CM_MSGS_H */
-- 
2.20.1

