Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C335C105924
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKUSOF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:14:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSOF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:14:05 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F4912068E;
        Thu, 21 Nov 2019 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360044;
        bh=gP0nQc+UectxAWo4dpa58eHfj0ZsH50g70EjSsmLlPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gw7T7MVEU/a+z+SxgpIgH+iinfYCzquLFGeoQOHTpkKyMlkTsbk41uPOHlPNRD7gD
         y3ulVPB+evQPNP3CV0Ub10I+zMLiBfjBdmermj9OOxVsnWGia2c2aPUTdah5m5C7i/
         iK8eiXQyFGQpg4TWNgy4mGzu/3AZZZU3yVfP7uVA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 14/48] RDMA/cm: Service ID Resolution Request (SIDR_REQ) definitions
Date:   Thu, 21 Nov 2019 20:12:39 +0200
Message-Id: <20191121181313.129430-15-leon@kernel.org>
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

Add SIDR_REQ message definitions as it is written
in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 4 ++--
 drivers/infiniband/core/cm_msgs.h | 2 +-
 drivers/infiniband/core/cma.c     | 2 +-
 include/rdma/ib_cm.h              | 2 --
 include/rdma/ibta_vol1_c12.h      | 7 +++++++
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 275603c56581..db17421beeff 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3468,7 +3468,7 @@ int ib_send_cm_sidr_req(struct ib_cm_id *cm_id,
 	int ret;
 
 	if (!param->path || (param->private_data &&
-	     param->private_data_len > IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE))
+	     param->private_data_len > CM_SIDR_REQ_PRIVATE_DATA_SIZE))
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -3527,7 +3527,7 @@ static void cm_format_sidr_req_event(struct cm_work *work,
 	param->port = work->port->port_num;
 	param->sgid_attr = rx_cm_id->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &sidr_req_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_SIDR_REQ_PRIVATE_DATA_SIZE;
 }
 
 static int cm_sidr_req_handler(struct cm_work *work)
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 1ca2378bbf0d..47f7ce1ac143 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -764,7 +764,7 @@ struct cm_sidr_req_msg {
 	__be16 rsvd;
 	__be64 service_id;
 
-	u32 private_data[IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE / sizeof(u32)];
+	u32 private_data[CM_SIDR_REQ_PRIVATE_DATA_SIZE / sizeof(u32)];
 } __packed;
 
 struct cm_sidr_rep_msg {
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index ece92889aa88..aeb528b2aa49 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2137,7 +2137,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 		conn_id = cma_ib_new_udp_id(&listen_id->id, ib_event, net_dev);
 		event.param.ud.private_data = ib_event->private_data + offset;
 		event.param.ud.private_data_len =
-				IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE - offset;
+			CM_SIDR_REQ_PRIVATE_DATA_SIZE - offset;
 	} else {
 		conn_id = cma_ib_new_conn_id(&listen_id->id, ib_event, net_dev);
 		cma_set_req_event_data(&event, &ib_event->param.req_rcvd,
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 18a3e2ee0758..8f0c377ad250 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -65,8 +65,6 @@ enum ib_cm_event_type {
 };
 
 enum ib_cm_data_size {
-	IB_CM_APR_INFO_LENGTH		 = 72,
-	IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE = 216,
 	IB_CM_SIDR_REP_PRIVATE_DATA_SIZE = 136,
 	IB_CM_SIDR_REP_INFO_LENGTH	 = 72,
 };
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index 0b7a4023016b..36bb04ee7634 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -179,4 +179,11 @@
 #define CM_APR_PRIVATE_DATA CM_FIELD_MLOC(struct cm_apr_msg, 84, 1184)
 #define CM_APR_PRIVATE_DATA_SIZE 148
 
+/* Table 119 SIDR_REQ Message Contents */
+#define CM_SIDR_REQ_REQUESTID CM_FIELD32_LOC(struct cm_sidr_req_msg, 0, 32)
+#define CM_SIDR_REQ_PARTITION_KEY CM_FIELD16_LOC(struct cm_sidr_req_msg, 4, 16)
+#define CM_SIDR_REQ_SERVICEID CM_FIELD64_LOC(struct cm_sidr_req_msg, 8, 64)
+#define CM_SIDR_REQ_PRIVATE_DATA CM_FIELD_MLOC(struct cm_sidr_req_msg, 16, 1728)
+#define CM_SIDR_REQ_PRIVATE_DATA_SIZE 216
+
 #endif /* _IBTA_VOL1_C12_H_ */
-- 
2.20.1

