Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D5811C9A0
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfLLJk6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbfLLJk6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:40:58 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF062465B;
        Thu, 12 Dec 2019 09:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143657;
        bh=HVZGhKZCZ6RNhf/urErb6wmJwAtCOX3ao6Mgr17xwVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcc4ATgMIxA52smpOuNtiRrGgszj4H0vqj7d37iZgBRDD+c3J4t4Sub6+bWQMkB0Q
         oYSkIZedHy0X8/nCYXOXfyDH0fLcOfiLBiygIIcHmwkd+SXZKw0F5UAtCQf2jk+AM4
         Jd3TWtnnZ+LzsaQ8efM7x/vj/2pNpHBvVMMb6B1c=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 44/48] RDMA/cm: Convert LAP fields
Date:   Thu, 12 Dec 2019 11:38:26 +0200
Message-Id: <20191212093830.316934-45-leon@kernel.org>
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

Convert LAP fields to the new scheme.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  9 +++++----
 drivers/infiniband/core/cm_msgs.h | 20 --------------------
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index b41ee97cda86..0db15799969f 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3127,16 +3127,17 @@ static void cm_format_path_from_lap(struct cm_id_private *cm_id_priv,
 	path->flow_label =
 		cpu_to_be32(IBA_GET(CM_LAP_ALTERNATE_FLOW_LABEL, lap_msg));
 	path->hop_limit = lap_msg->alt_hop_limit;
-	path->traffic_class = cm_lap_get_traffic_class(lap_msg);
+	path->traffic_class = IBA_GET(CM_LAP_ALTERNATE_TRAFFIC_CLASS, lap_msg);
 	path->reversible = 1;
 	path->pkey = cm_id_priv->pkey;
-	path->sl = cm_lap_get_sl(lap_msg);
+	path->sl = IBA_GET(CM_LAP_ALTERNATE_SL, lap_msg);
 	path->mtu_selector = IB_SA_EQ;
 	path->mtu = cm_id_priv->path_mtu;
 	path->rate_selector = IB_SA_EQ;
-	path->rate = cm_lap_get_packet_rate(lap_msg);
+	path->rate = IBA_GET(CM_LAP_ALTERNATE_PACKET_RATE, lap_msg);
 	path->packet_life_time_selector = IB_SA_EQ;
-	path->packet_life_time = cm_lap_get_local_ack_timeout(lap_msg);
+	path->packet_life_time =
+		IBA_GET(CM_LAP_ALTERNATE_LOCAL_ACK_TIMEOUT, lap_msg);
 	path->packet_life_time -= (path->packet_life_time > 0);
 	cm_format_path_lid_from_lap(lap_msg, path);
 }
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 978eff812ce1..0f3f9f3cd1cb 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -192,26 +192,6 @@ struct cm_lap_msg {
 	u8 private_data[CM_LAP_PRIVATE_DATA_SIZE];
 } __packed;
 
-static inline u8 cm_lap_get_traffic_class(struct cm_lap_msg *lap_msg)
-{
-	return (u8) be32_to_cpu(lap_msg->offset56);
-}
-
-static inline u8 cm_lap_get_packet_rate(struct cm_lap_msg *lap_msg)
-{
-	return lap_msg->offset61 & 0x3F;
-}
-
-static inline u8 cm_lap_get_sl(struct cm_lap_msg *lap_msg)
-{
-	return lap_msg->offset62 >> 4;
-}
-
-static inline u8 cm_lap_get_local_ack_timeout(struct cm_lap_msg *lap_msg)
-{
-	return lap_msg->offset63 >> 3;
-}
-
 struct cm_apr_msg {
 	struct ib_mad_hdr hdr;
 
-- 
2.20.1

