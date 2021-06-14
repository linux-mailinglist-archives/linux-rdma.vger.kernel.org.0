Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB8A3A5ECC
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jun 2021 11:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhFNJGr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Jun 2021 05:06:47 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:33624 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhFNJGq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Jun 2021 05:06:46 -0400
Received: by mail-ej1-f41.google.com with SMTP id g20so15501966ejt.0
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jun 2021 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7wBlBhcjt+JBKvdzfqGXD54W6BOnME0Fs8J1TkKeak=;
        b=b9A+5sSF2zJZ5gX/DzFpF3XZXr2MsIE1ZFvmcT2XDTV6VO/bHUSCcQMCD2JjS+2PFI
         RZTS5P5tXzRzCvEvPvLUOEKjK2hKIiMUn6E6s1TkjUVjp6gxrN7BVWUDmjmJkVCQ7DSw
         lH5FExywr+ZGQmXTy7prJRmHeHuXfUatLDMY+zWPHQDLjvguoGqIbxgGdlHG2pP5qJkP
         LEirpK6SKPDFwyyXxcd6mIpJMr7fOL40sMOCnd9Wp+WVA4gHkbR3Uob7Wp89o7Tl0Q92
         0MqyVUK6uwF+wE65jEslfjagxbMyBR3LyE5r/wIazOswR5uxwg+KBnpETbbMC+sZNznj
         H91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7wBlBhcjt+JBKvdzfqGXD54W6BOnME0Fs8J1TkKeak=;
        b=FSxTw4IpSDGYKP8s065YnH0TLOEkkkLdYZbxnx/2laM62wiP2V/Yt7LgIWAf8rzJjc
         NCV9/VYFFKglbtG9AE3S8PW2G1OSnnVJzrRbehhwcG27cKa6gHtSZYdA2We/PspPdS8W
         cXgsrn8G3J+eXqPpxHD3BoUTwGxlF8VGufPQ+FqjRzacd1hzuAlGQdIoJo5VWbbmsKY1
         sJU8heL6lajHqYCXX/BeS16hMKt7i+kjwApJXfk9T0vdK5+gktj1+Q5E1jjSkEPf9u9L
         xr4dNdVZtijpAi/4WH+KS9tO3q1AWoN6jeXtieVRRNS59GQJoVBMx2t0nymjsNSGdTRb
         QETQ==
X-Gm-Message-State: AOAM530qi6s5iIadBVuwjCm35gVcyUyUwgynendNpCrwyC+2qJU0pB+h
        QORhk35LIvMLx7zNJM2r8vYkY8fDfSDMmw==
X-Google-Smtp-Source: ABdhPJzdc7ZCWtfHznXBFU8fFiZXGwxuaVArrq5je7NKaCrLlHOlzlRSHunX5er5LGPI34grbdlzeg==
X-Received: by 2002:a17:906:22c7:: with SMTP id q7mr14152713eja.547.1623661422932;
        Mon, 14 Jun 2021 02:03:42 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4960:8600:dc5e:964f:b034:cb7d])
        by smtp.gmail.com with ESMTPSA id qq26sm6764355ejb.6.2021.06.14.02.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 02:03:42 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Leon Romanovsky <leonro@nvidia.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 5/5] RDMA/rtrs: Check device max_qp_wr limit when create QP
Date:   Mon, 14 Jun 2021 11:03:37 +0200
Message-Id: <20210614090337.29557-6-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614090337.29557-1-jinpu.wang@ionos.com>
References: <20210614090337.29557-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently we only check device max_qp_wr limit for IO connection,
but not for service connection. We should check for both.

So save the max_qp_wr device limit in wr_limit, and use it for both
IO connections and service connections.

While at it, also remove an outdated comments.

Suggested-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 29 +++++++++++++-------------
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 13 ++++--------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 67ff5bf9bfa8..125e0bead262 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1572,21 +1572,12 @@ static void destroy_con(struct rtrs_clt_con *con)
 static int create_con_cq_qp(struct rtrs_clt_con *con)
 {
 	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
-	u32 max_send_wr, max_recv_wr, cq_num, max_send_sge;
+	u32 max_send_wr, max_recv_wr, cq_num, max_send_sge, wr_limit;
 	int err, cq_vector;
 	struct rtrs_msg_rkey_rsp *rsp;
 
 	lockdep_assert_held(&con->con_mutex);
 	if (con->c.cid == 0) {
-		/*
-		 * Two (request + registration) completion for send
-		 * Two for recv if always_invalidate is set on server
-		 * or one for recv.
-		 * + 2 for drain and heartbeat
-		 * in case qp gets into error state.
-		 */
-		max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
-		max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
 		max_send_sge = 1;
 		/* We must be the first here */
 		if (WARN_ON(sess->s.dev))
@@ -1606,6 +1597,17 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		}
 		sess->s.dev_ref = 1;
 		query_fast_reg_mode(sess);
+		wr_limit = sess->s.dev->ib_dev->attrs.max_qp_wr;
+		/*
+		 * Two (request + registration) completion for send
+		 * Two for recv if always_invalidate is set on server
+		 * or one for recv.
+		 * + 2 for drain and heartbeat
+		 * in case qp gets into error state.
+		 */
+		max_send_wr =
+			min_t(int, wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
+		max_recv_wr = max_send_wr;
 	} else {
 		/*
 		 * Here we assume that session members are correctly set.
@@ -1617,14 +1619,13 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		if (WARN_ON(!sess->queue_depth))
 			return -EINVAL;
 
+		wr_limit = sess->s.dev->ib_dev->attrs.max_qp_wr;
 		/* Shared between connections */
 		sess->s.dev_ref++;
-		max_send_wr =
-			min_t(int, sess->s.dev->ib_dev->attrs.max_qp_wr,
+		max_send_wr = min_t(int, wr_limit,
 			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
 			      sess->queue_depth * 3 + 1);
-		max_recv_wr =
-			min_t(int, sess->s.dev->ib_dev->attrs.max_qp_wr,
+		max_recv_wr = min_t(int, wr_limit,
 			      sess->queue_depth * 3 + 1);
 		max_send_sge = sess->clt->max_segments + 1;
 	}
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index c10dfc296259..1a30fd833792 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1649,22 +1649,17 @@ static int create_con(struct rtrs_srv_sess *sess,
 	con->c.sess = &sess->s;
 	con->c.cid = cid;
 	atomic_set(&con->wr_cnt, 1);
+	wr_limit = sess->s.dev->ib_dev->attrs.max_qp_wr;
 
 	if (con->c.cid == 0) {
 		/*
 		 * All receive and all send (each requiring invalidate)
 		 * + 2 for drain and heartbeat
 		 */
-		max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
-		max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
+		max_send_wr = min_t(int, wr_limit,
+				    SERVICE_CON_QUEUE_DEPTH * 2 + 2);
+		max_recv_wr = max_send_wr;
 	} else {
-		/*
-		 * In theory we might have queue_depth * 32
-		 * outstanding requests if an unsafe global key is used
-		 * and we have queue_depth read requests each consisting
-		 * of 32 different addresses. div 3 for mlx5.
-		 */
-		wr_limit = sess->s.dev->ib_dev->attrs.max_qp_wr / 3;
 		/* when always_invlaidate enalbed, we need linv+rinv+mr+imm */
 		if (always_invalidate)
 			max_send_wr =
-- 
2.25.1

