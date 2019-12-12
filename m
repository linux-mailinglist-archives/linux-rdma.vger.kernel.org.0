Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6971211C98F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfLLJk3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbfLLJk3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:40:29 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1078222527;
        Thu, 12 Dec 2019 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143628;
        bh=QwJroHYyDSD2YVXDm/sHAlDiTjnTE9tubeIRfc6ghjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZoy8Guz/meQ2EQgp7ykP1m44j6kI1psa6aiwD7Gis8fvqZXGezeQEt3EoIfExpYE
         8pBERYeEFLe+Gy0kQPgFKYJnqx5NfAcm4YFVIPuNWCjbkB+ZvQUUYoHxsvMV1sOAZj
         g0I+M7JdPwk3Jtz4DMTl+l0kXQ/i/fSgXsj9+wjY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 35/48] RDMA/cm: Convert MRA service timeout
Date:   Thu, 12 Dec 2019 11:38:17 +0200
Message-Id: <20191212093830.316934-36-leon@kernel.org>
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

Convert MRA service timeout field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 080c4411ae16..a5fc328d6d23 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1748,7 +1748,7 @@ static void cm_format_mra(struct cm_mra_msg *mra_msg,
 	IBA_SET(CM_MRA_MESSAGE_MRAED, mra_msg, msg_mraed);
 	mra_msg->local_comm_id = cm_id_priv->id.local_id;
 	mra_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	cm_mra_set_service_timeout(mra_msg, service_timeout);
+	IBA_SET(CM_MRA_SERVICE_TIMEOUT, mra_msg, service_timeout);
 
 	if (private_data && private_data_len)
 		memcpy(mra_msg->private_data, private_data, private_data_len);
@@ -3036,8 +3036,8 @@ static int cm_mra_handler(struct cm_work *work)
 	work->cm_event.private_data = &mra_msg->private_data;
 	work->cm_event.private_data_len = CM_MRA_PRIVATE_DATA_SIZE;
 	work->cm_event.param.mra_rcvd.service_timeout =
-					cm_mra_get_service_timeout(mra_msg);
-	timeout = cm_convert_to_ms(cm_mra_get_service_timeout(mra_msg)) +
+		IBA_GET(CM_MRA_SERVICE_TIMEOUT, mra_msg);
+	timeout = cm_convert_to_ms(IBA_GET(CM_MRA_SERVICE_TIMEOUT, mra_msg)) +
 		  cm_convert_to_ms(cm_id_priv->av.timeout);
 
 	spin_lock_irq(&cm_id_priv->lock);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index e096b1f572bc..601b0fd2c86c 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -91,18 +91,6 @@ enum cm_msg_response {
 
 } __packed;
 
-static inline u8 cm_mra_get_service_timeout(struct cm_mra_msg *mra_msg)
-{
-	return (u8) (mra_msg->offset9 >> 3);
-}
-
-static inline void cm_mra_set_service_timeout(struct cm_mra_msg *mra_msg,
-					      u8 service_timeout)
-{
-	mra_msg->offset9 = (u8) ((mra_msg->offset9 & 0x07) |
-				 (service_timeout << 3));
-}
-
 struct cm_rej_msg {
 	struct ib_mad_hdr hdr;
 
-- 
2.20.1

