Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321CF3A41C4
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhFKMMp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 08:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhFKMMk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Jun 2021 08:12:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DA0C061574
        for <linux-rdma@vger.kernel.org>; Fri, 11 Jun 2021 05:10:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ci15so4195211ejc.10
        for <linux-rdma@vger.kernel.org>; Fri, 11 Jun 2021 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LmfvrlqKSugQrOL3uDjwzUCdVnUY/gjEb2dxgjwjjNg=;
        b=fAnUYJgum7cGYE2JHYhFz3/HVmaY307Sh6Qi57160xT/FvgFp/OBcRiQ+v//ZHOYyS
         3WWzqb+nWvdGMf+dEqKseRlOF1HagmerwyOTrSoHstKNIBzKkPT5iHdE3tn7QnLKmGgZ
         PqqYFq4giI+pBB40h87S8NszZ72K6+/gQ2K5J6kKQXny2P2GzHLhhP+u86LnlqiC34vi
         Kcs3f4saaP+LronH/XChEsOw+6k3RRoyek+QU/zHRx8ow+gK8wb6/Er8fCPHBlTvdvuo
         TKoTSMYDqflSueq8gksuaYfJCl6qXkaal8HlMKJiqoZFOgFW5J3aoKE2jP368gA03jqk
         ZTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmfvrlqKSugQrOL3uDjwzUCdVnUY/gjEb2dxgjwjjNg=;
        b=IeNuXdxmmqWVMNzrBKvTI6XvF+ULoL9RgPX0WTLvuimYOXx479xXubey7YtLhOyrdK
         9FWO3GLMMe+xFf8xHGmmgn3hA/FGNnShKDhCkuF+YvYEv1D0dr0cM2LfHmQzbUlFYkFt
         RIK+ySacHUoTv1Af1t0Fmc9UzkwkOi8yX3st4uXzRHk/7MQwtoIPxM1t0bGvuK5b3n3g
         sXjZn2Kk6haKKp/qfDbJJZtgRXjV3IBAQ3RUrMHT8xBeUr2RSVDWUrXb94IR5Yp3gihe
         MwhVbZ0zgnQCqM/cKar6iJcJzj7lBetDptlYXWizQ6Fzlapia5FRp7x9lLOCH+TnfLa9
         LXuQ==
X-Gm-Message-State: AOAM533Xq01BO5Oawkv1eyGOq9b8zG1/7++Fa8qG9omiqI/ccg93VE0G
        HDWiCrut/HgxonowqNdPkfFAxbMdM9vrYg==
X-Google-Smtp-Source: ABdhPJwZPMZrUj5Ej651reVSiTGgNJLB6e3l+Nfs/+yvQMpia9i+JHZ3VX75XHk6lR1+6QxfdUQ92w==
X-Received: by 2002:a17:907:628a:: with SMTP id nd10mr3425060ejc.326.1623413440217;
        Fri, 11 Jun 2021 05:10:40 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4954:2e00:fd6f:fc71:2689:4a7a])
        by smtp.gmail.com with ESMTPSA id n11sm2084116ejg.43.2021.06.11.05.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 05:10:39 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Leon Romanovsky <leonro@nvidia.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 5/5] RDMA/rtrs: Check device max_qp_wr limit when create QP
Date:   Fri, 11 Jun 2021 14:10:34 +0200
Message-Id: <20210611121034.48837-6-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210611121034.48837-1-jinpu.wang@ionos.com>
References: <20210611121034.48837-1-jinpu.wang@ionos.com>
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

