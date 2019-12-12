Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E352111C96E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfLLJi5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:38:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbfLLJi5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:38:57 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE32424654;
        Thu, 12 Dec 2019 09:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143536;
        bh=RJ8ovtWVIjgYEChcnekyOvkAKNJp82pTOXXoMemOO7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rr3dXomSwpro26vSfbFCzsjCyYW+PPWp7O7lzLorfaWpTkxLKAGet1powI/+eLh9d
         1sbF9WhSNdN1xzl5K2WrVMkYu6Ulfy88Y1ZwoPCEsfN5dmv1KGRnSrM7EQML8ABoth
         FstT2keknYSWi+HFzcq/ntw1lOXpa1wD9gN7CE5Y=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 06/48] RDMA/cm: Message Receipt Acknowledgment (MRA) message definitions
Date:   Thu, 12 Dec 2019 11:37:48 +0200
Message-Id: <20191212093830.316934-7-leon@kernel.org>
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
index 2db7f736379e..52dbc80a0d1b 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -88,4 +88,12 @@
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

