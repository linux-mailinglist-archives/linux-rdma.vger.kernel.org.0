Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17380E6153
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfJ0HIS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:18 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A8320578;
        Sun, 27 Oct 2019 07:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160097;
        bh=j20GVGcBfjE8eKjgpSpoTTS6EgqFjJfhvslLsAphC9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3lIuOVrCBIHTc2TqudguX3R0loEWtm+YCMfRC6mwHpTO33Bf3Bn0+IKEKsKHzzFG
         11JsASR0xLa3Pzh2sE2YCV064HoXlUpXiEqdcNVQXdxqCOPx4YdrHGnxJcTHpigseQ
         S/6zqbjIQOqtnk/k2aQXKkjn3xAoaFiwJBuCYudw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 32/43] RDMA/cm: Convert MRA service timeout
Date:   Sun, 27 Oct 2019 09:06:10 +0200
Message-Id: <20191027070621.11711-33-leon@kernel.org>
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

Convert MRA service timeout field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 11502ab48d35..903bacb92a22 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1748,7 +1748,7 @@ static void cm_format_mra(struct cm_mra_msg *mra_msg,
 	CM_SET(MRA_MESSAGE_MRAED, mra_msg, msg_mraed);
 	mra_msg->local_comm_id = cm_id_priv->id.local_id;
 	mra_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	cm_mra_set_service_timeout(mra_msg, service_timeout);
+	CM_SET(MRA_SERVICE_TIMEOUT, mra_msg, service_timeout);
 
 	if (private_data && private_data_len)
 		memcpy(mra_msg->private_data, private_data, private_data_len);
@@ -3033,8 +3033,8 @@ static int cm_mra_handler(struct cm_work *work)
 	work->cm_event.private_data = &mra_msg->private_data;
 	work->cm_event.private_data_len = CM_MRA_PRIVATE_DATA_SIZE;
 	work->cm_event.param.mra_rcvd.service_timeout =
-					cm_mra_get_service_timeout(mra_msg);
-	timeout = cm_convert_to_ms(cm_mra_get_service_timeout(mra_msg)) +
+		CM_GET(MRA_SERVICE_TIMEOUT, mra_msg);
+	timeout = cm_convert_to_ms(CM_GET(MRA_SERVICE_TIMEOUT, mra_msg)) +
 		  cm_convert_to_ms(cm_id_priv->av.timeout);
 
 	spin_lock_irq(&cm_id_priv->lock);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index bf94c3dc391e..96a27876d2ae 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -421,18 +421,6 @@ enum cm_msg_response {
 
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

