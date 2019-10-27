Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB61E614C
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfJ0HHx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HHx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:07:53 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B13320578;
        Sun, 27 Oct 2019 07:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160072;
        bh=A4axtiCr1Xv9rmG4bu0Uli1KacuuhhwBC3yY8s0E+s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MryLK25dtg8gudJjNIcxZETByXjZ4UzXWCC3sc+wJ7JW8Ahm8hPzXIY+24+X2Ptcv
         1t3Ux4NLV5vA1eJCQAC6FfSafIdLMDBXPWgsePH2nGc8eqBfX/i9lLhPi3fQgOmDUf
         2kdm0YEIsC/bGG1DhoNrXg6f32qlYfiDhAPngopw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 25/43] RDMA/cm: Convert REQ SRQ field
Date:   Sun, 27 Oct 2019 09:06:03 +0200
Message-Id: <20191027070621.11711-26-leon@kernel.org>
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

Convert REQ SRQ field to new scheme.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h | 11 -----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 0450d75f8d53..d28501559d7d 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1297,7 +1297,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		       param->responder_resources);
 		CM_SET(REQ_RETRY_COUNT, req_msg, param->retry_count);
 		CM_SET(REQ_RNR_RETRY_COUNT, req_msg, param->rnr_retry_count);
-		cm_req_set_srq(req_msg, param->srq);
+		CM_SET(REQ_SRQ, req_msg, param->srq);
 	}
 
 	req_msg->primary_local_gid = pri_path->sgid;
@@ -1704,7 +1704,7 @@ static void cm_format_req_event(struct cm_work *work,
 		CM_GET(REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg);
 	param->retry_count = CM_GET(REQ_RETRY_COUNT, req_msg);
 	param->rnr_retry_count = CM_GET(REQ_RNR_RETRY_COUNT, req_msg);
-	param->srq = cm_req_get_srq(req_msg);
+	param->srq = CM_GET(REQ_SRQ, req_msg);
 	param->ppath_sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &req_msg->private_data;
 	work->cm_event.private_data_len = CM_REQ_PRIVATE_DATA_SIZE;
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 677b61a85e1f..112ece857fd8 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -400,17 +400,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_srq(struct cm_req_msg *req_msg)
-{
-	return (req_msg->offset51 & 0x8) >> 3;
-}
-
-static inline void cm_req_set_srq(struct cm_req_msg *req_msg, u8 srq)
-{
-	req_msg->offset51 = (u8) ((req_msg->offset51 & 0xF7) |
-				  ((srq & 0x1) << 3));
-}
-
 static inline __be32 cm_req_get_primary_flow_label(struct cm_req_msg *req_msg)
 {
 	return cpu_to_be32(be32_to_cpu(req_msg->primary_offset88) >> 12);
-- 
2.20.1

