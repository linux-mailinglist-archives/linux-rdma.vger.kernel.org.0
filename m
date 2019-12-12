Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB37E11C972
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfLLJjL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728427AbfLLJjK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:10 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42DFE22527;
        Thu, 12 Dec 2019 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143548;
        bh=aSy8KPLa2NxDpkFwiOcxe7vOLkC+swyd2gyIIrqLNrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2GD2FHCBbOYGnhVDwSK0cbGeHCnbOHCcuHudDP5pd6ZvuNy4A5iLTyfsmnCKTY3Z
         ZeOTdnU0RSvCx/WXjuZ4jK0uABYOUK6b593ab05JytmrVwBCydYk+0YQbzeHkEFLaV
         8gzq+A9Fd10ImoGFoQTvQUIWsY+TfXlQkBecOers=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 10/48] RDMA/cm: Request For Communication Release (DREQ) definitions
Date:   Thu, 12 Dec 2019 11:37:52 +0200
Message-Id: <20191212093830.316934-11-leon@kernel.org>
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

Add DREQ definitions as it is written in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 4 ++--
 drivers/infiniband/core/cm_msgs.h | 2 +-
 include/rdma/ib_cm.h              | 1 -
 include/rdma/ibta_vol1_c12.h      | 7 +++++++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 73f93e354d8b..57e35d2f657f 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2452,7 +2452,7 @@ int ib_send_cm_dreq(struct ib_cm_id *cm_id,
 	unsigned long flags;
 	int ret;
 
-	if (private_data && private_data_len > IB_CM_DREQ_PRIVATE_DATA_SIZE)
+	if (private_data && private_data_len > CM_DREQ_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -2603,7 +2603,7 @@ static int cm_dreq_handler(struct cm_work *work)
 	}
 
 	work->cm_event.private_data = &dreq_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_DREQ_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_DREQ_PRIVATE_DATA_SIZE;
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->local_qpn != cm_dreq_get_remote_qpn(dreq_msg))
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index d36e90ccaeb7..c2b19d21fbe6 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -594,7 +594,7 @@ struct cm_dreq_msg {
 	/* remote QPN/EECN:24, rsvd:8 */
 	__be32 offset8;
 
-	u8 private_data[IB_CM_DREQ_PRIVATE_DATA_SIZE];
+	u8 private_data[CM_DREQ_PRIVATE_DATA_SIZE];
 
 } __packed;
 
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 34dc12b30399..77f4818aaf10 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -65,7 +65,6 @@ enum ib_cm_event_type {
 };
 
 enum ib_cm_data_size {
-	IB_CM_DREQ_PRIVATE_DATA_SIZE	 = 220,
 	IB_CM_DREP_PRIVATE_DATA_SIZE	 = 224,
 	IB_CM_LAP_PRIVATE_DATA_SIZE	 = 168,
 	IB_CM_APR_PRIVATE_DATA_SIZE	 = 148,
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index 892d3122023c..e3116b62d7ba 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -132,4 +132,11 @@
 #define CM_RTU_PRIVATE_DATA CM_FIELD_MLOC(struct cm_rtu_msg, 8, 1792)
 #define CM_RTU_PRIVATE_DATA_SIZE 224
 
+/* Table 112 DREQ Message Contents */
+#define CM_DREQ_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_dreq_msg, 0, 32)
+#define CM_DREQ_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_dreq_msg, 4, 32)
+#define CM_DREQ_REMOTE_QPN_EECN CM_FIELD32_LOC(struct cm_dreq_msg, 8, 24)
+#define CM_DREQ_PRIVATE_DATA CM_FIELD_MLOC(struct cm_dreq_msg, 12, 1760)
+#define CM_DREQ_PRIVATE_DATA_SIZE 220
+
 #endif /* _IBTA_VOL1_C12_H_ */
-- 
2.20.1

