Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 976DAE615F
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfJ0HJB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HJB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:09:01 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C10A20578;
        Sun, 27 Oct 2019 07:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160140;
        bh=sntNoeAN7rmWlijidlWpsDAHI1eK5aV26XXnf41sZ04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7d1XDKZtcT25N+8NxJOmgo0gfV/Aev/0Gnjrk622brpYW7wYA38T+a3quRonwpJ9
         m3gyrm2dz0UZ1bEqlUXtuYkt4TyG92qHtXQ7jZC3nZF4LAEU4GE951Q4iZZEF5gW2c
         89L8TUuq4zd2I7Z0npoBDKw8jKsQzzv//+7to4CI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 41/43] RDMA/cm: Convert LAP fields
Date:   Sun, 27 Oct 2019 09:06:19 +0200
Message-Id: <20191027070621.11711-42-leon@kernel.org>
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

Convert LAP fields to the new scheme.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  9 +++++----
 drivers/infiniband/core/cm_msgs.h | 20 --------------------
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 2fe1e8908445..11dc6e2b7de2 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3124,16 +3124,17 @@ static void cm_format_path_from_lap(struct cm_id_private *cm_id_priv,
 	path->flow_label =
 		cpu_to_be32(CM_GET(LAP_ALTERNATE_FLOW_LABEL, lap_msg));
 	path->hop_limit = lap_msg->alt_hop_limit;
-	path->traffic_class = cm_lap_get_traffic_class(lap_msg);
+	path->traffic_class = CM_GET(LAP_ALTERNATE_TRAFFIC_CLASS, lap_msg);
 	path->reversible = 1;
 	path->pkey = cm_id_priv->pkey;
-	path->sl = cm_lap_get_sl(lap_msg);
+	path->sl = CM_GET(LAP_ALTERNATE_SL, lap_msg);
 	path->mtu_selector = IB_SA_EQ;
 	path->mtu = cm_id_priv->path_mtu;
 	path->rate_selector = IB_SA_EQ;
-	path->rate = cm_lap_get_packet_rate(lap_msg);
+	path->rate = CM_GET(LAP_ALTERNATE_PACKET_RATE, lap_msg);
 	path->packet_life_time_selector = IB_SA_EQ;
-	path->packet_life_time = cm_lap_get_local_ack_timeout(lap_msg);
+	path->packet_life_time =
+		CM_GET(LAP_ALTERNATE_LOCAL_ACK_TIMEOUT, lap_msg);
 	path->packet_life_time -= (path->packet_life_time > 0);
 	cm_format_path_lid_from_lap(lap_msg, path);
 }
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index fa475a59ed53..0bf214a5f388 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -522,26 +522,6 @@ struct cm_lap_msg {
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

