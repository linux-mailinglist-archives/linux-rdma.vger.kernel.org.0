Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870ADE613E
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfJ0HHE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HHD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:07:03 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6EB20578;
        Sun, 27 Oct 2019 07:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160022;
        bh=+HQAMgNxzGnv9PIUcRnRKXdm+lU+B6QJ/avE7vnlJbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o57V9ZH14ZHoc76whViZhTh8wjiLU+vTBRZSyRMerE7Sdp+8GGeYFNUEPjqCdDhMU
         6WlqcHn5SG+wMGAZcOkN9ixG4dqg7Bab2He27Q0KXzSDAsxTaBGuCzr0ui4fHznBq0
         fa9PQ+uxl8+A0N6KcEbWFXwesdRkL2rHFYcfDB58=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 11/43] RDMA/cm: Service ID Resolution Request (SIDR_REQ) definitions
Date:   Sun, 27 Oct 2019 09:05:49 +0200
Message-Id: <20191027070621.11711-12-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191027070621.11711-1-leon@kernel.org>
References: <20191027070621.11711-1-leon@kernel.org>
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
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h | 11 ++++++++++-
 drivers/infiniband/core/cma.c     |  2 +-
 include/rdma/ib_cm.h              |  2 --
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index e72fc4071313..55a14acaa333 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3465,7 +3465,7 @@ int ib_send_cm_sidr_req(struct ib_cm_id *cm_id,
 	int ret;
 
 	if (!param->path || (param->private_data &&
-	     param->private_data_len > IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE))
+	     param->private_data_len > CM_SIDR_REQ_PRIVATE_DATA_SIZE))
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -3524,7 +3524,7 @@ static void cm_format_sidr_req_event(struct cm_work *work,
 	param->port = work->port->port_num;
 	param->sgid_attr = rx_cm_id->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &sidr_req_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_SIDR_REQ_PRIVATE_DATA_SIZE;
 }
 
 static int cm_sidr_req_handler(struct cm_work *work)
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 656641e6f447..9d32b84bdcb0 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -318,6 +318,15 @@
 #define CM_APR_PRIVATE_DATA_OFFSET 84
 #define CM_APR_PRIVATE_DATA_SIZE 148
 
+#define CM_SIDR_REQ_REQUESTID_OFFSET 0
+#define CM_SIDR_REQ_REQUESTID_MASK GENMASK(31, 0)
+#define CM_SIDR_REQ_PARTITION_KEY_OFFSET 4
+#define CM_SIDR_REQ_PARTITION_KEY_MASK GENMASK(15, 0)
+#define CM_SIDR_REQ_SERVICEID_OFFSET 8
+#define CM_SIDR_REQ_SERVICEID_MASK GENMASK_ULL(63, 0)
+#define CM_SIDR_REQ_PRIVATE_DATA_OFFSET 16
+#define CM_SIDR_REQ_PRIVATE_DATA_SIZE 216
+
 struct cm_req_msg {
 	struct ib_mad_hdr hdr;
 
@@ -1068,7 +1077,7 @@ struct cm_sidr_req_msg {
 	__be16 rsvd;
 	__be64 service_id;
 
-	u32 private_data[IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE / sizeof(u32)];
+	u32 private_data[CM_SIDR_REQ_PRIVATE_DATA_SIZE / sizeof(u32)];
 } __packed;
 
 struct cm_sidr_rep_msg {
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 997f8c29e34e..d3bbca5b61e3 100644
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
-- 
2.20.1

