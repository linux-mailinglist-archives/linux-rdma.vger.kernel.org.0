Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34431C6A58
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEFHr3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgEFHr3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:47:29 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99162206D5;
        Wed,  6 May 2020 07:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588751248;
        bh=7HoAY1aS9BVS/j+CtAI8iSMS1b0nJTGmyQKYKOIr9SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PBSZnpjEE1+qy7XwvI3VN3/utAVmjhAQI8m4vD8WJ950dgWPZ0/S8ajskKUNxCQSu
         WqQdigBxh2oSYEJFvDgqG7GPCEOq3WuPN6KTwHv8wD0IqpdyUQ+OI78ibwTXiFXEae
         y9zvT8IJoQGy0s2wvR9dKUdHUppar5h6eawo84TE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 05/10] RDMA/cm: Pass the cm_id_private into cm_cleanup_timewait
Date:   Wed,  6 May 2020 10:46:56 +0300
Message-Id: <20200506074701.9775-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506074701.9775-1-leon@kernel.org>
References: <20200506074701.9775-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Also rename it to cm_remove_remote(). This function now removes the
tracking of the remote ID/QPN in the redblack trees from a cm_id_private.

Replace a open-coded version with a call. The open coded version was
deleting only the remote_id, however at this call site the qpn can not
have been in the RB tree either, so the cm_remove_remote() will do the
same.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index e7c20c44a361..3899e9d88eb1 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -968,8 +968,10 @@ static u8 cm_ack_timeout(u8 ca_ack_delay, u8 packet_life_time)
 	return min(31, ack_timeout);
 }
 
-static void cm_cleanup_timewait(struct cm_timewait_info *timewait_info)
+static void cm_remove_remote(struct cm_id_private *cm_id_priv)
 {
+	struct cm_timewait_info *timewait_info = cm_id_priv->timewait_info;
+
 	if (timewait_info->inserted_remote_id) {
 		rb_erase(&timewait_info->remote_id_node, &cm.remote_id_table);
 		timewait_info->inserted_remote_id = 0;
@@ -1008,7 +1010,7 @@ static void cm_enter_timewait(struct cm_id_private *cm_id_priv)
 		return;
 
 	spin_lock_irqsave(&cm.lock, flags);
-	cm_cleanup_timewait(cm_id_priv->timewait_info);
+	cm_remove_remote(cm_id_priv);
 	list_add_tail(&cm_id_priv->timewait_info->list, &cm.timewait_list);
 	spin_unlock_irqrestore(&cm.lock, flags);
 
@@ -1039,7 +1041,7 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
 	cm_id_priv->id.state = IB_CM_IDLE;
 	if (cm_id_priv->timewait_info) {
 		spin_lock_irqsave(&cm.lock, flags);
-		cm_cleanup_timewait(cm_id_priv->timewait_info);
+		cm_remove_remote(cm_id_priv);
 		spin_unlock_irqrestore(&cm.lock, flags);
 		kfree(cm_id_priv->timewait_info);
 		cm_id_priv->timewait_info = NULL;
@@ -1140,7 +1142,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	spin_lock(&cm.lock);
 	/* Required for cleanup paths related cm_req_handler() */
 	if (cm_id_priv->timewait_info) {
-		cm_cleanup_timewait(cm_id_priv->timewait_info);
+		cm_remove_remote(cm_id_priv);
 		kfree(cm_id_priv->timewait_info);
 		cm_id_priv->timewait_info = NULL;
 	}
@@ -1986,7 +1988,7 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
 	/* Check for stale connections. */
 	timewait_info = cm_insert_remote_qpn(cm_id_priv->timewait_info);
 	if (timewait_info) {
-		cm_cleanup_timewait(cm_id_priv->timewait_info);
+		cm_remove_remote(cm_id_priv);
 		cur_cm_id_priv = cm_acquire_id(timewait_info->work.local_id,
 					   timewait_info->work.remote_id);
 
@@ -2007,7 +2009,7 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
 		cm_id_priv->id.device,
 		cpu_to_be64(IBA_GET(CM_REQ_SERVICE_ID, req_msg)));
 	if (!listen_cm_id_priv) {
-		cm_cleanup_timewait(cm_id_priv->timewait_info);
+		cm_remove_remote(cm_id_priv);
 		spin_unlock_irq(&cm.lock);
 		cm_issue_rej(work->port, work->mad_recv_wc,
 			     IB_CM_REJ_INVALID_SERVICE_ID, CM_MSG_RESPONSE_REQ,
@@ -2502,9 +2504,7 @@ static int cm_rep_handler(struct cm_work *work)
 	/* Check for a stale connection. */
 	timewait_info = cm_insert_remote_qpn(cm_id_priv->timewait_info);
 	if (timewait_info) {
-		rb_erase(&cm_id_priv->timewait_info->remote_id_node,
-			 &cm.remote_id_table);
-		cm_id_priv->timewait_info->inserted_remote_id = 0;
+		cm_remove_remote(cm_id_priv);
 		cur_cm_id_priv = cm_acquire_id(timewait_info->work.local_id,
 					   timewait_info->work.remote_id);
 
-- 
2.26.2

