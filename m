Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1E1E6159
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfJ0HIj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:39 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3449420578;
        Sun, 27 Oct 2019 07:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160118;
        bh=AU9t3noQHIVz8bR53zJwoh07k82zztmtr/tyygAj3zQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KGP53OGZnAO2CyKC+Oe0u3yKsAbvvNdxJhrjkxIPb+aKH7X7dxVbHj2bWsXClw1rR
         zX7RSMI8Xjl1K8rwlBYX7/rKpJsvqk+DI+rcTQPbc7Hzk1is8NdlPw5N1HVcxWzIjR
         HTOo8WX7bRUzMoYqLzCd0CGE0CVMuc8yherXp1/o=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 38/43] RDMA/cm: Convert REP SRQ field
Date:   Sun, 27 Oct 2019 09:06:16 +0200
Message-Id: <20191027070621.11711-39-leon@kernel.org>
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

Convert REP SRQ field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 11 -----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 78d595c1d39b..035617f3b16c 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2077,10 +2077,10 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 		rep_msg->initiator_depth = param->initiator_depth;
 		CM_SET(REP_END_TO_END_FLOW_CONTROL, rep_msg,
 		       param->flow_control);
-		cm_rep_set_srq(rep_msg, param->srq);
+		CM_SET(REP_SRQ, rep_msg, param->srq);
 		CM_SET(REP_LOCAL_QPN, rep_msg, param->qp_num);
 	} else {
-		cm_rep_set_srq(rep_msg, 1);
+		CM_SET(REP_SRQ, rep_msg, 1);
 		CM_SET(REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg, param->qp_num);
 	}
 
@@ -2227,7 +2227,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->failover_accepted = CM_GET(REP_FAILOVER_ACCEPTED, rep_msg);
 	param->flow_control = CM_GET(REP_END_TO_END_FLOW_CONTROL, rep_msg);
 	param->rnr_retry_count = CM_GET(REP_RNR_RETRY_COUNT, rep_msg);
-	param->srq = cm_rep_get_srq(rep_msg);
+	param->srq = CM_GET(REP_SRQ, rep_msg);
 	work->cm_event.private_data = &rep_msg->private_data;
 	work->cm_event.private_data_len = CM_REP_PRIVATE_DATA_SIZE;
 }
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index c02bba29a27d..dfda88462818 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -462,17 +462,6 @@ struct cm_rep_msg {
 
 } __packed;
 
-static inline u8 cm_rep_get_srq(struct cm_rep_msg *rep_msg)
-{
-	return (u8) ((rep_msg->offset27 >> 4) & 0x1);
-}
-
-static inline void cm_rep_set_srq(struct cm_rep_msg *rep_msg, u8 srq)
-{
-	rep_msg->offset27 = (u8) ((rep_msg->offset27 & 0xEF) |
-				  ((srq & 0x1) << 4));
-}
-
 struct cm_rtu_msg {
 	struct ib_mad_hdr hdr;
 
-- 
2.20.1

