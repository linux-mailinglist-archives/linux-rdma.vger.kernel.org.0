Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4AE613A
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfJ0HGs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HGs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:06:48 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A7420578;
        Sun, 27 Oct 2019 07:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160008;
        bh=tsUc/LlbEEebRXKvQSXmo/LtK7Itt4f+6OfVyVlJe0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1lzRU36A3ltslSBgwdQE8P+Pp99M4TcXnJv3gjXkU0A58VlA2nHKCKsK5NeciOON
         ANSj8omd35e0QopR67RbGwxU421Hy/F8SULq4G4Cn/78N4ZP3zj5mGwCtqe9ddFvXx
         OKvgxLvaPbvgUfvwCymR03unrP+5sJj5Sykmp+rI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 07/43] RDMA/cm: Request For Communication Release (DREQ) definitions
Date:   Sun, 27 Oct 2019 09:05:45 +0200
Message-Id: <20191027070621.11711-8-leon@kernel.org>
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

Add DREQ definitions as it is written in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h | 11 ++++++++++-
 include/rdma/ib_cm.h              |  1 -
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 41cf2a0de051..7f3cc66372eb 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2449,7 +2449,7 @@ int ib_send_cm_dreq(struct ib_cm_id *cm_id,
 	unsigned long flags;
 	int ret;
 
-	if (private_data && private_data_len > IB_CM_DREQ_PRIVATE_DATA_SIZE)
+	if (private_data && private_data_len > CM_DREQ_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -2600,7 +2600,7 @@ static int cm_dreq_handler(struct cm_work *work)
 	}
 
 	work->cm_event.private_data = &dreq_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_DREQ_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_DREQ_PRIVATE_DATA_SIZE;
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->local_qpn != cm_dreq_get_remote_qpn(dreq_msg))
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 6917e007c573..dded0bd59479 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -251,6 +251,15 @@
 #define CM_RTU_PRIVATE_DATA_OFFSET 8
 #define CM_RTU_PRIVATE_DATA_SIZE 224
 
+#define CM_DREQ_LOCAL_COMM_ID_OFFSET 0
+#define CM_DREQ_LOCAL_COMM_ID_MASK GENMASK(31, 0)
+#define CM_DREQ_REMOTE_COMM_ID_OFFSET 4
+#define CM_DREQ_REMOTE_COMM_ID__MASK GENMASK(31, 0)
+#define CM_DREQ_REMOTE_QPN_EECN_OFFSET 8
+#define CM_DREQ_REMOTE_QPN_EECN_MASK GENMASK(23, 0)
+#define CM_DREQ_PRIVATE_DATA_OFFSET 12
+#define CM_DREQ_PRIVATE_DATA_SIZE 220
+
 struct cm_req_msg {
 	struct ib_mad_hdr hdr;
 
@@ -831,7 +840,7 @@ struct cm_dreq_msg {
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
-- 
2.20.1

