Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC32110591A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKUSNh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:13:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfKUSNh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:13:37 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 186782068E;
        Thu, 21 Nov 2019 18:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360015;
        bh=1vLk3c3Ats0Wv3CoMQwtWCws608wXlTFKlNfuDsm6CI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zkn3hpEUNmBS/tJIPfRFibv6EqHaLC2pq7rPGxHjw/NIandW+vDokQvjnIab+8fHl
         PCunaFn4dfCt45Vx4geA44hvuS1jgslIM96J1DJR19wr+GV84IOgh89pHECvNlZ/ZJ
         yrsr5ZIAErTopIRHoefNoKXqTU030zSa9Oh9gDiI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 06/48] RDMA/cm: Message Receipt Acknowledgment (MRA) message definitions
Date:   Thu, 21 Nov 2019 20:12:31 +0200
Message-Id: <20191121181313.129430-7-leon@kernel.org>
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

Add Message Receipt Acknowledgment (MRA) definitions as it is written
in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 4 ++--
 drivers/infiniband/core/cm_msgs.h | 2 +-
 include/rdma/ib_cm.h              | 1 -
 include/rdma/ibta_vol1_c12.h      | 8 ++++++++
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 3c0cbdc748ac..5a0ee9e46ff9 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2897,7 +2897,7 @@ int ib_send_cm_mra(struct ib_cm_id *cm_id,
 	unsigned long flags;
 	int ret;
 
-	if (private_data && private_data_len > IB_CM_MRA_PRIVATE_DATA_SIZE)
+	if (private_data && private_data_len > CM_MRA_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
 	data = cm_copy_private_data(private_data, private_data_len);
@@ -2991,7 +2991,7 @@ static int cm_mra_handler(struct cm_work *work)
 		return -EINVAL;
 
 	work->cm_event.private_data = &mra_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_MRA_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_MRA_PRIVATE_DATA_SIZE;
 	work->cm_event.param.mra_rcvd.service_timeout =
 					cm_mra_get_service_timeout(mra_msg);
 	timeout = cm_convert_to_ms(cm_mra_get_service_timeout(mra_msg)) +
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 9e50da044c43..888209ec058d 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -391,7 +391,7 @@ enum cm_msg_response {
 	/* service timeout:5, rsvd:3 */
 	u8 offset9;
 
-	u8 private_data[IB_CM_MRA_PRIVATE_DATA_SIZE];
+	u8 private_data[CM_MRA_PRIVATE_DATA_SIZE];
 
 } __packed;
 
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 956256b2fc5d..6d73316be651 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -65,7 +65,6 @@ enum ib_cm_event_type {
 };
 
 enum ib_cm_data_size {
-	IB_CM_MRA_PRIVATE_DATA_SIZE	 = 222,
 	IB_CM_REJ_PRIVATE_DATA_SIZE	 = 148,
 	IB_CM_REP_PRIVATE_DATA_SIZE	 = 196,
 	IB_CM_RTU_PRIVATE_DATA_SIZE	 = 224,
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index 885b7b7fdb86..a9389957d375 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -85,4 +85,12 @@
 #define CM_REQ_PRIVATE_DATA CM_FIELD_MLOC(struct cm_req_msg, 140, 736)
 #define CM_REQ_PRIVATE_DATA_SIZE 92
 
+/* Table 107 MRA Message Contents */
+#define CM_MRA_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_mra_msg, 0, 32)
+#define CM_MRA_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_mra_msg, 4, 32)
+#define CM_MRA_MESSAGE_MRAED CM_FIELD8_LOC(struct cm_mra_msg, 8, 2)
+#define CM_MRA_SERVICE_TIMEOUT CM_FIELD8_LOC(struct cm_mra_msg, 9, 5)
+#define CM_MRA_PRIVATE_DATA CM_FIELD_MLOC(struct cm_mra_msg, 10, 1776)
+#define CM_MRA_PRIVATE_DATA_SIZE 222
+
 #endif /* _IBTA_VOL1_C12_H_ */
-- 
2.20.1

