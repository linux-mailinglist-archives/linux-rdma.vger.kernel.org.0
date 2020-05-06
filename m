Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3CC1C6A5C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgEFHrn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgEFHrn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:47:43 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19CBD20714;
        Wed,  6 May 2020 07:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588751262;
        bh=uG+7ZmFdXVmgpeXUBdcBGp5o8jEvLqrsaUUZ5XSIM6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BW9yt0bQuJLxlepPGy1B1NX9XvGEVJGJ4hApGzyY/jMPI+XnRVemgnSjTpJu/hf+q
         ZCdLhd5hQh3xRfeX/LgiSNPgXwgs+gPOiuGdMjLjGA6WanPBY7X1vUKuEkLRsCqRUr
         vwEjL8I+jtMe1ZA2Nr2Gi2wHHQF+PfZQbjCXlQ3Q=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 09/10] RDMA/cm: Remove needless cm_id variable
Date:   Wed,  6 May 2020 10:47:00 +0300
Message-Id: <20200506074701.9775-10-leon@kernel.org>
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

Just put the expression in the only reader

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index e70b4c70f00c..c8b2088dcd0a 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1973,7 +1973,6 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
 	struct cm_id_private *listen_cm_id_priv, *cur_cm_id_priv;
 	struct cm_timewait_info *timewait_info;
 	struct cm_req_msg *req_msg;
-	struct ib_cm_id *cm_id;
 
 	req_msg = (struct cm_req_msg *)work->mad_recv_wc->recv_buf.mad;
 
@@ -2003,8 +2002,7 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
 			     IB_CM_REJ_STALE_CONN, CM_MSG_RESPONSE_REQ,
 			     NULL, 0);
 		if (cur_cm_id_priv) {
-			cm_id = &cur_cm_id_priv->id;
-			ib_send_cm_dreq(cm_id, NULL, 0);
+			ib_send_cm_dreq(&cur_cm_id_priv->id, NULL, 0);
 			cm_deref_id(cur_cm_id_priv);
 		}
 		return NULL;
@@ -2460,7 +2458,6 @@ static int cm_rep_handler(struct cm_work *work)
 	struct cm_rep_msg *rep_msg;
 	int ret;
 	struct cm_id_private *cur_cm_id_priv;
-	struct ib_cm_id *cm_id;
 	struct cm_timewait_info *timewait_info;
 
 	rep_msg = (struct cm_rep_msg *)work->mad_recv_wc->recv_buf.mad;
@@ -2526,8 +2523,7 @@ static int cm_rep_handler(struct cm_work *work)
 			IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
 
 		if (cur_cm_id_priv) {
-			cm_id = &cur_cm_id_priv->id;
-			ib_send_cm_dreq(cm_id, NULL, 0);
+			ib_send_cm_dreq(&cur_cm_id_priv->id, NULL, 0);
 			cm_deref_id(cur_cm_id_priv);
 		}
 
-- 
2.26.2

