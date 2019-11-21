Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91352105923
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKUSOB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:14:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSOB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:14:01 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1E782068F;
        Thu, 21 Nov 2019 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360040;
        bh=9icpP2GmvywMi1B8SYB2zv0CaDqXBJb5lRpnpnogMAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=STKFnRhY3RVKYe3LeotXYOIfHZZ5ZdGBrY8hXwpwZc5RJv+7mWdx2v8mSbyZ4mCrM
         7n04imz1AfG8O/gqamPV5Mdhy3d+fUV+iYqnwaeRE0YE3MfZ/7vM+ZIzjFIKDFpZ2R
         bbfjnO/lBs+5iC0ADGWCSdRl0AmlFcqiMgtoaMKw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 13/48] RDMA/cm: Alternate Path Response (APR) message definitions
Date:   Thu, 21 Nov 2019 20:12:38 +0200
Message-Id: <20191121181313.129430-14-leon@kernel.org>
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

Add APR definitions as it is written in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h |  4 ++--
 include/rdma/ib_cm.h              |  1 -
 include/rdma/ibta_vol1_c12.h      | 11 +++++++++++
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 002904c03554..275603c56581 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3323,8 +3323,8 @@ int ib_send_cm_apr(struct ib_cm_id *cm_id,
 	unsigned long flags;
 	int ret;
 
-	if ((private_data && private_data_len > IB_CM_APR_PRIVATE_DATA_SIZE) ||
-	    (info && info_length > IB_CM_APR_INFO_LENGTH))
+	if ((private_data && private_data_len > CM_APR_PRIVATE_DATA_SIZE) ||
+	    (info && info_length > CM_APR_ADDITIONAL_INFORMATION_SIZE))
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -3378,7 +3378,7 @@ static int cm_apr_handler(struct cm_work *work)
 	work->cm_event.param.apr_rcvd.apr_info = &apr_msg->info;
 	work->cm_event.param.apr_rcvd.info_len = apr_msg->info_length;
 	work->cm_event.private_data = &apr_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_APR_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_APR_PRIVATE_DATA_SIZE;
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED ||
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 6c94d083c996..1ca2378bbf0d 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -751,9 +751,9 @@ struct cm_apr_msg {
 	u8 info_length;
 	u8 ap_status;
 	__be16 rsvd;
-	u8 info[IB_CM_APR_INFO_LENGTH];
+	u8 info[CM_APR_ADDITIONAL_INFORMATION_SIZE];
 
-	u8 private_data[IB_CM_APR_PRIVATE_DATA_SIZE];
+	u8 private_data[CM_APR_PRIVATE_DATA_SIZE];
 } __packed;
 
 struct cm_sidr_req_msg {
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 08d3217bdaf1..18a3e2ee0758 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -65,7 +65,6 @@ enum ib_cm_event_type {
 };
 
 enum ib_cm_data_size {
-	IB_CM_APR_PRIVATE_DATA_SIZE	 = 148,
 	IB_CM_APR_INFO_LENGTH		 = 72,
 	IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE = 216,
 	IB_CM_SIDR_REP_PRIVATE_DATA_SIZE = 136,
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index 17b730f4cdae..0b7a4023016b 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -168,4 +168,15 @@
 #define CM_LAP_PRIVATE_DATA CM_FIELD_MLOC(struct cm_lap_msg, 64, 1344)
 #define CM_LAP_PRIVATE_DATA_SIZE 168
 
+/* Table 116 APR Message Contents */
+#define CM_APR_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_apr_msg, 0, 32)
+#define CM_APR_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_apr_msg, 4, 32)
+#define CM_APR_ADDITIONAL_INFORMATION_LENGTH                                   \
+	CM_FIELD8_LOC(struct cm_apr_msg, 8, 8)
+#define CM_APR_AR_STATUS CM_FIELD8_LOC(struct cm_apr_msg, 9, 8)
+#define CM_APR_ADDITIONAL_INFORMATION CM_FIELD_MLOC(struct cm_apr_msg, 12, 576)
+#define CM_APR_ADDITIONAL_INFORMATION_SIZE 72
+#define CM_APR_PRIVATE_DATA CM_FIELD_MLOC(struct cm_apr_msg, 84, 1184)
+#define CM_APR_PRIVATE_DATA_SIZE 148
+
 #endif /* _IBTA_VOL1_C12_H_ */
-- 
2.20.1

