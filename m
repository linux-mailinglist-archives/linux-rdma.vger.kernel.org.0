Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698DBE613D
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfJ0HG7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HG7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:06:59 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52B1E20578;
        Sun, 27 Oct 2019 07:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160019;
        bh=ZK/U1PxloyapGGvlixvM17Fo6r6raT6LuJZJEizhlxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yG5v/L5oESqRC+lltw8AhYstGp17qgxMTe39uZwGvvkcFHNMdGPZ/xQohCZbs4Rbb
         6Ap1BpHWIGh68c0tE8RlryZFa2XMRknofq3/X9u4/QMqiKKB6aqt7gQuby9zpyDy/7
         Hhz16pM9F5HO1t+1OOIdFGc0eBsKD5pjsURMrS0s=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 10/43] RDMA/cm: Alternate Path Response (APR) message definitions
Date:   Sun, 27 Oct 2019 09:05:48 +0200
Message-Id: <20191027070621.11711-11-leon@kernel.org>
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

Add APR definitions as it is written in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 20 ++++++++++++++++++--
 include/rdma/ib_cm.h              |  1 -
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index a735481d85f0..e72fc4071313 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3320,8 +3320,8 @@ int ib_send_cm_apr(struct ib_cm_id *cm_id,
 	unsigned long flags;
 	int ret;
 
-	if ((private_data && private_data_len > IB_CM_APR_PRIVATE_DATA_SIZE) ||
-	    (info && info_length > IB_CM_APR_INFO_LENGTH))
+	if ((private_data && private_data_len > CM_APR_PRIVATE_DATA_SIZE) ||
+	    (info && info_length > CM_APR_ADDITIONAL_INFORMATION_SIZE))
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -3375,7 +3375,7 @@ static int cm_apr_handler(struct cm_work *work)
 	work->cm_event.param.apr_rcvd.apr_info = &apr_msg->info;
 	work->cm_event.param.apr_rcvd.info_len = apr_msg->info_length;
 	work->cm_event.private_data = &apr_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_APR_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_APR_PRIVATE_DATA_SIZE;
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED ||
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 76a5053933e9..656641e6f447 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -302,6 +302,22 @@
 #define CM_LAP_PRIVATE_DATA_OFFSET 64
 #define CM_LAP_PRIVATE_DATA_SIZE 168
 
+#define CM_APR_LOCAL_COMM_ID_OFFSET 0
+#define CM_APR_LOCAL_COMM_ID_MASK GENMASK(31, 0)
+#define CM_APR_REMOTE_COMM_ID_OFFSET 4
+#define CM_APR_REMOTE_COMM_ID_MASK GENMASK(31, 0)
+#define CM_APR_ADDITIONAL_INFORMATION_LENGTH_OFFSET 8
+#define CM_APR_ADDITIONAL_INFORMATION_LENGTH_MASK GENMASK(7, 0)
+
+#define CM_APR_AR_STATUS_OFFSET 9
+#define CM_APR_AR_STATUS_MASK GENMASK(7, 0)
+
+#define CM_APR_ADDITIONAL_INFORMATION_OFFSET 12
+#define CM_APR_ADDITIONAL_INFORMATION_SIZE 72
+
+#define CM_APR_PRIVATE_DATA_OFFSET 84
+#define CM_APR_PRIVATE_DATA_SIZE 148
+
 struct cm_req_msg {
 	struct ib_mad_hdr hdr;
 
@@ -1039,9 +1055,9 @@ struct cm_apr_msg {
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
-- 
2.20.1

