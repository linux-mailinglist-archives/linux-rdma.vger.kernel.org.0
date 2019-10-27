Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B27E615A
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfJ0HIn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:43 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7E2020578;
        Sun, 27 Oct 2019 07:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160122;
        bh=PWWKxEG/5fAGPdxVK22kppOvcxaBQvkdEOWx97ntECA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wMEfw8uL20Rl9UV4VkQ8bx47P9lieWKgWe22Gmi43wBeM3lX2Lr5ZvzMtL0qmfhYa
         Z5MZDJyixDEq9iOjtZB8lf5IsaCsPZCH4Z/gBtqC8lCf3nYtXJm+4IpD5coVrfu3Yf
         x8neOAuiBOgbVJLOFx8ZyUj+tXlmE/oy76G6SU8E=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 39/43] RDMA/cm: Delete unused CM LAP functions
Date:   Sun, 27 Oct 2019 09:06:17 +0200
Message-Id: <20191027070621.11711-40-leon@kernel.org>
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

Clean the code by deleting LAP functions, which are not called anyway.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 98 -------------------------------
 drivers/infiniband/core/cm_msgs.h | 58 ------------------
 2 files changed, 156 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 035617f3b16c..25a20c04e07b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3098,104 +3098,6 @@ static int cm_mra_handler(struct cm_work *work)
 	return -EINVAL;
 }
 
-static void cm_format_lap(struct cm_lap_msg *lap_msg,
-			  struct cm_id_private *cm_id_priv,
-			  struct sa_path_rec *alternate_path,
-			  const void *private_data,
-			  u8 private_data_len)
-{
-	bool alt_ext = false;
-
-	if (alternate_path->rec_type == SA_PATH_REC_TYPE_OPA)
-		alt_ext = opa_is_extended_lid(alternate_path->opa.dlid,
-					      alternate_path->opa.slid);
-	cm_format_mad_hdr(&lap_msg->hdr, CM_LAP_ATTR_ID,
-			  cm_form_tid(cm_id_priv));
-	lap_msg->local_comm_id = cm_id_priv->id.local_id;
-	lap_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	CM_SET(LAP_REMOTE_QPN_EECN, lap_msg, cm_id_priv->remote_qpn);
-	/* todo: need remote CM response timeout */
-	cm_lap_set_remote_resp_timeout(lap_msg, 0x1F);
-	lap_msg->alt_local_lid =
-		htons(ntohl(sa_path_get_slid(alternate_path)));
-	lap_msg->alt_remote_lid =
-		htons(ntohl(sa_path_get_dlid(alternate_path)));
-	lap_msg->alt_local_gid = alternate_path->sgid;
-	lap_msg->alt_remote_gid = alternate_path->dgid;
-	if (alt_ext) {
-		lap_msg->alt_local_gid.global.interface_id
-			= OPA_MAKE_ID(be32_to_cpu(alternate_path->opa.slid));
-		lap_msg->alt_remote_gid.global.interface_id
-			= OPA_MAKE_ID(be32_to_cpu(alternate_path->opa.dlid));
-	}
-	cm_lap_set_flow_label(lap_msg, alternate_path->flow_label);
-	cm_lap_set_traffic_class(lap_msg, alternate_path->traffic_class);
-	lap_msg->alt_hop_limit = alternate_path->hop_limit;
-	cm_lap_set_packet_rate(lap_msg, alternate_path->rate);
-	cm_lap_set_sl(lap_msg, alternate_path->sl);
-	cm_lap_set_subnet_local(lap_msg, 1); /* local only... */
-	cm_lap_set_local_ack_timeout(lap_msg,
-		cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
-			       alternate_path->packet_life_time));
-
-	if (private_data && private_data_len)
-		memcpy(lap_msg->private_data, private_data, private_data_len);
-}
-
-int ib_send_cm_lap(struct ib_cm_id *cm_id,
-		   struct sa_path_rec *alternate_path,
-		   const void *private_data,
-		   u8 private_data_len)
-{
-	struct cm_id_private *cm_id_priv;
-	struct ib_mad_send_buf *msg;
-	unsigned long flags;
-	int ret;
-
-	if (private_data && private_data_len > CM_LAP_PRIVATE_DATA_SIZE)
-		return -EINVAL;
-
-	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	spin_lock_irqsave(&cm_id_priv->lock, flags);
-	if (cm_id->state != IB_CM_ESTABLISHED ||
-	    (cm_id->lap_state != IB_CM_LAP_UNINIT &&
-	     cm_id->lap_state != IB_CM_LAP_IDLE)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = cm_init_av_by_path(alternate_path, NULL, &cm_id_priv->alt_av,
-				 cm_id_priv);
-	if (ret)
-		goto out;
-	cm_id_priv->alt_av.timeout =
-			cm_ack_timeout(cm_id_priv->target_ack_delay,
-				       cm_id_priv->alt_av.timeout - 1);
-
-	ret = cm_alloc_msg(cm_id_priv, &msg);
-	if (ret)
-		goto out;
-
-	cm_format_lap((struct cm_lap_msg *) msg->mad, cm_id_priv,
-		      alternate_path, private_data, private_data_len);
-	msg->timeout_ms = cm_id_priv->timeout_ms;
-	msg->context[1] = (void *) (unsigned long) IB_CM_ESTABLISHED;
-
-	ret = ib_post_send_mad(msg, NULL);
-	if (ret) {
-		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-		cm_free_msg(msg);
-		return ret;
-	}
-
-	cm_id->lap_state = IB_CM_LAP_SENT;
-	cm_id_priv->msg = msg;
-
-out:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(ib_send_cm_lap);
-
 static void cm_format_path_lid_from_lap(struct cm_lap_msg *lap_msg,
 					struct sa_path_rec *path)
 {
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index dfda88462818..41193dc44fee 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -522,89 +522,31 @@ struct cm_lap_msg {
 	u8 private_data[CM_LAP_PRIVATE_DATA_SIZE];
 } __packed;
 
-static inline u8 cm_lap_get_remote_resp_timeout(struct cm_lap_msg *lap_msg)
-{
-	return (u8) ((be32_to_cpu(lap_msg->offset12) & 0xF8) >> 3);
-}
-
-static inline void cm_lap_set_remote_resp_timeout(struct cm_lap_msg *lap_msg,
-						  u8 resp_timeout)
-{
-	lap_msg->offset12 = cpu_to_be32((resp_timeout << 3) |
-					 (be32_to_cpu(lap_msg->offset12) &
-					  0xFFFFFF07));
-}
-
 static inline __be32 cm_lap_get_flow_label(struct cm_lap_msg *lap_msg)
 {
 	return cpu_to_be32(be32_to_cpu(lap_msg->offset56) >> 12);
 }
 
-static inline void cm_lap_set_flow_label(struct cm_lap_msg *lap_msg,
-					 __be32 flow_label)
-{
-	lap_msg->offset56 = cpu_to_be32(
-				 (be32_to_cpu(lap_msg->offset56) & 0x00000FFF) |
-				 (be32_to_cpu(flow_label) << 12));
-}
-
 static inline u8 cm_lap_get_traffic_class(struct cm_lap_msg *lap_msg)
 {
 	return (u8) be32_to_cpu(lap_msg->offset56);
 }
 
-static inline void cm_lap_set_traffic_class(struct cm_lap_msg *lap_msg,
-					    u8 traffic_class)
-{
-	lap_msg->offset56 = cpu_to_be32(traffic_class |
-					 (be32_to_cpu(lap_msg->offset56) &
-					  0xFFFFFF00));
-}
-
 static inline u8 cm_lap_get_packet_rate(struct cm_lap_msg *lap_msg)
 {
 	return lap_msg->offset61 & 0x3F;
 }
 
-static inline void cm_lap_set_packet_rate(struct cm_lap_msg *lap_msg,
-					  u8 packet_rate)
-{
-	lap_msg->offset61 = (packet_rate & 0x3F) | (lap_msg->offset61 & 0xC0);
-}
-
 static inline u8 cm_lap_get_sl(struct cm_lap_msg *lap_msg)
 {
 	return lap_msg->offset62 >> 4;
 }
 
-static inline void cm_lap_set_sl(struct cm_lap_msg *lap_msg, u8 sl)
-{
-	lap_msg->offset62 = (sl << 4) | (lap_msg->offset62 & 0x0F);
-}
-
-static inline u8 cm_lap_get_subnet_local(struct cm_lap_msg *lap_msg)
-{
-	return (lap_msg->offset62 >> 3) & 0x1;
-}
-
-static inline void cm_lap_set_subnet_local(struct cm_lap_msg *lap_msg,
-					   u8 subnet_local)
-{
-	lap_msg->offset62 = ((subnet_local & 0x1) << 3) |
-			     (lap_msg->offset61 & 0xF7);
-}
 static inline u8 cm_lap_get_local_ack_timeout(struct cm_lap_msg *lap_msg)
 {
 	return lap_msg->offset63 >> 3;
 }
 
-static inline void cm_lap_set_local_ack_timeout(struct cm_lap_msg *lap_msg,
-						u8 local_ack_timeout)
-{
-	lap_msg->offset63 = (local_ack_timeout << 3) |
-			    (lap_msg->offset63 & 0x07);
-}
-
 struct cm_apr_msg {
 	struct ib_mad_hdr hdr;
 
-- 
2.20.1

