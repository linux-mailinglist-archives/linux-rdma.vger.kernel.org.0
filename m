Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC0E1C6A59
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgEFHrc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgEFHrc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:47:32 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D59206D5;
        Wed,  6 May 2020 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588751251;
        bh=IY1GK5EtLFuICg/6Sfr5qJ6azTCwHK4eFis/f/EG2qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpmPbbZBYhvRpPJBsvfXWZIVTHw/gGXN/N7N9aoIA3WAQerxDPc8srpcrzNSOA03B
         Sp0+mOr61KnVecrvwCFe2KMup3GmWGdlMVRJZYQECCpHqKQYgZZ2XGiHy6PcdMQ3rW
         2H6pbtPVDrBBoX79yi2+GDac6fUxkMW0i/BOBH9Y=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 07/10] RDMA/cm: Make find_remote_id() return a cm_id_private
Date:   Wed,  6 May 2020 10:46:58 +0300
Message-Id: <20200506074701.9775-8-leon@kernel.org>
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

The only caller doesn't care about the timewait, so acquire and return the
cm_id_private from the function.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index acb0c5c5c5cf..dfbad8b924b3 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -742,12 +742,14 @@ static struct cm_timewait_info * cm_insert_remote_id(struct cm_timewait_info
 	return NULL;
 }
 
-static struct cm_timewait_info * cm_find_remote_id(__be64 remote_ca_guid,
-						   __be32 remote_id)
+static struct cm_id_private *cm_find_remote_id(__be64 remote_ca_guid,
+					       __be32 remote_id)
 {
 	struct rb_node *node = cm.remote_id_table.rb_node;
 	struct cm_timewait_info *timewait_info;
+	struct cm_id_private *res = NULL;
 
+	spin_lock_irq(&cm.lock);
 	while (node) {
 		timewait_info = rb_entry(node, struct cm_timewait_info,
 					 remote_id_node);
@@ -759,10 +761,14 @@ static struct cm_timewait_info * cm_find_remote_id(__be64 remote_ca_guid,
 			node = node->rb_left;
 		else if (be64_gt(remote_ca_guid, timewait_info->remote_ca_guid))
 			node = node->rb_right;
-		else
-			return timewait_info;
+		else {
+			res = cm_acquire_id(timewait_info->work.local_id,
+					     timewait_info->work.remote_id);
+			break;
+		}
 	}
-	return NULL;
+	spin_unlock_irq(&cm.lock);
+	return res;
 }
 
 static struct cm_timewait_info * cm_insert_remote_qpn(struct cm_timewait_info
@@ -2993,24 +2999,15 @@ static void cm_format_rej_event(struct cm_work *work)
 
 static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 {
-	struct cm_timewait_info *timewait_info;
 	struct cm_id_private *cm_id_priv;
 	__be32 remote_id;
 
 	remote_id = cpu_to_be32(IBA_GET(CM_REJ_LOCAL_COMM_ID, rej_msg));
 
 	if (IBA_GET(CM_REJ_REASON, rej_msg) == IB_CM_REJ_TIMEOUT) {
-		spin_lock_irq(&cm.lock);
-		timewait_info = cm_find_remote_id(
+		cm_id_priv = cm_find_remote_id(
 			*((__be64 *)IBA_GET_MEM_PTR(CM_REJ_ARI, rej_msg)),
 			remote_id);
-		if (!timewait_info) {
-			spin_unlock_irq(&cm.lock);
-			return NULL;
-		}
-		cm_id_priv =
-			cm_acquire_id(timewait_info->work.local_id, remote_id);
-		spin_unlock_irq(&cm.lock);
 	} else if (IBA_GET(CM_REJ_MESSAGE_REJECTED, rej_msg) ==
 		   CM_MSG_RESPONSE_REQ)
 		cm_id_priv = cm_acquire_id(
-- 
2.26.2

