Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6D10594E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfKUSPu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:15:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfKUSPt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:49 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9073E2068E;
        Thu, 21 Nov 2019 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360149;
        bh=HVZGhKZCZ6RNhf/urErb6wmJwAtCOX3ao6Mgr17xwVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FudL1eNXGFUCJIvIL++Soi5mX+1gP3yd22j++fbgxLM5xo2KWSz7tsECRorOxLcaa
         TiRUQr9ps8YATKhakgseeAAP6drgozeYvqZhyd5O0Ofrc4mKWFM+5bLdfDnISfX605
         5qbGzrF1ttned2emuyh8yWBBq4BSWLDKfPzJPH3E=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 44/48] RDMA/cm: Convert LAP fields
Date:   Thu, 21 Nov 2019 20:13:09 +0200
Message-Id: <20191121181313.129430-45-leon@kernel.org>
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

