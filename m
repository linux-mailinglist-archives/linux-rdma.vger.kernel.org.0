Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2437D31F8A2
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 12:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBSLvD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 06:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBSLvC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Feb 2021 06:51:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A854BC061574
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 03:50:21 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id n1so9441001edv.2
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 03:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eg59KUYe+bJ+I9KESrrmcnq1YNvThExgcUsMQCD8RzA=;
        b=Hg0Shs1arYppVSX6c/wGJg9xvCljMBmeuHb8Dogfp8bLIMnk73efqLHpnNK/dNsoR8
         ZEO3yqSJdDcFj3O7tNFkRFlLaeZ8sU8XlcY/eylcncUFJn1V592wKmw56zpAhEhcVcMC
         fgro+X6cRIn7ACSkA63hod1m7OEL2kNyqesnsYl8u8ol9fu+Lcx1C4T8jNOQZxwR/ePH
         5vnpqkjQroY+itF2egWgNKf8ba7gupliju2Houd6YlBw49C3n0pdFBok1zzZ/WFaeOD7
         FfHQ9LU8XaXTGIbqvSMaOzsqHBv5VP0Qo7qZqQ7pxweqV3Skd3f8Xu7N+MzJG83IXfw/
         peRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eg59KUYe+bJ+I9KESrrmcnq1YNvThExgcUsMQCD8RzA=;
        b=mD0hNctDJ9lpZvVsD+A23uTGx7mG5tU4L+hl2MFVZUOQZ/er6O4KGdWVBhajWcnwGX
         QlWooPV6JkosUye8OxezWdvuAn9kOsCKhBxM0KpCW2OotZ9+vhnxl7RqFpaEM/CqTMRe
         wrXSja2zCuG8eY+bx8RoQQKVWDBaWIXBOm4b3LOUCUzVR38s4MU+T830YZbk235GgWsv
         POZ1p7FJ4PqmA3BtaRpxbLacDmNb8lNLtYVYQToVbu0Hm6nwK91yQYZZ0dUhKSmkJbKQ
         M+pYWwd3ClT2mDjLaiFxv3fFjj1ydLGG2OjcGjB9A+Qt5p8uVimO3z6vOHgU2WCNSdMP
         VtWw==
X-Gm-Message-State: AOAM532rcjadS823GcKc8yaDZoiTIW5UQnr1QohbDbbCukApZ3jjF78T
        7AUPqYJbHrGlmu8xTcXXhkALuhy25w2Oog==
X-Google-Smtp-Source: ABdhPJzJF7yuX485kr1TMd8m9rOiRWr09PpMdgx/oOoo+jKhTwy2yYb3BEUiCZZfOKOyeqIyh9FpgA==
X-Received: by 2002:aa7:d8da:: with SMTP id k26mr8823011eds.364.1613735420180;
        Fri, 19 Feb 2021 03:50:20 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:496a:1b00:d976:bb6f:c5ab:7b14])
        by smtp.gmail.com with ESMTPSA id ia25sm2544099ejc.44.2021.02.19.03.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 03:50:19 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Subject: [PATCH 1/2] RDMA/rtrs: Use new shared CQ mechanism
Date:   Fri, 19 Feb 2021 12:50:18 +0100
Message-Id: <20210219115019.38981-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Has the driver use shared CQs providing ~10%-20% improvement during
test.
Instead of opening a CQ for each QP per connection, a CQ for each QP
will be provided by the RDMA core driver that will be shared between
the QPs on that core reducing interrupt overhead.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 +++++-----
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 10 +++++-----
 drivers/infiniband/ulp/rtrs/rtrs.c     | 11 +++++++----
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 0a08b4b742a3..4e9cf06cc17a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -325,7 +325,7 @@ static void rtrs_rdma_error_recovery(struct rtrs_clt_con *con)
 
 static void rtrs_clt_fast_reg_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct rtrs_clt_con *con = cq->cq_context;
+	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		rtrs_err(con->c.sess, "Failed IB_WR_REG_MR: %s\n",
@@ -345,7 +345,7 @@ static void rtrs_clt_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct rtrs_clt_io_req *req =
 		container_of(wc->wr_cqe, typeof(*req), inv_cqe);
-	struct rtrs_clt_con *con = cq->cq_context;
+	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		rtrs_err(con->c.sess, "Failed IB_WR_LOCAL_INV: %s\n",
@@ -586,7 +586,7 @@ static int rtrs_post_recv_empty_x2(struct rtrs_con *con, struct ib_cqe *cqe)
 
 static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct rtrs_clt_con *con = cq->cq_context;
+	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
 	u32 imm_type, imm_payload;
 	bool w_inval = false;
@@ -2241,7 +2241,7 @@ static int init_conns(struct rtrs_clt_sess *sess)
 
 static void rtrs_clt_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct rtrs_clt_con *con = cq->cq_context;
+	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
 	struct rtrs_iu *iu;
 
@@ -2323,7 +2323,7 @@ static int process_info_rsp(struct rtrs_clt_sess *sess,
 
 static void rtrs_clt_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct rtrs_clt_con *con = cq->cq_context;
+	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
 	struct rtrs_msg_info_rsp *msg;
 	enum rtrs_clt_state state;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 8caad0a2322b..1b31bda9ca78 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -91,6 +91,7 @@ struct rtrs_con {
 	struct ib_cq		*cq;
 	struct rdma_cm_id	*cm_id;
 	unsigned int		cid;
+	u16                     cq_size;
 };
 
 struct rtrs_sess {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index d071809e3ed2..37ba121564a2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -199,7 +199,7 @@ static void rtrs_srv_wait_ops_ids(struct rtrs_srv_sess *sess)
 
 static void rtrs_srv_reg_mr_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct rtrs_srv_con *con = cq->cq_context;
+	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
 	struct rtrs_sess *s = con->c.sess;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 
@@ -720,7 +720,7 @@ static void rtrs_srv_stop_hb(struct rtrs_srv_sess *sess)
 
 static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct rtrs_srv_con *con = cq->cq_context;
+	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
 	struct rtrs_sess *s = con->c.sess;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct rtrs_iu *iu;
@@ -862,7 +862,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 
 static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct rtrs_srv_con *con = cq->cq_context;
+	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
 	struct rtrs_sess *s = con->c.sess;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct rtrs_msg_info_req *msg;
@@ -1110,7 +1110,7 @@ static void rtrs_srv_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct rtrs_srv_mr *mr =
 		container_of(wc->wr_cqe, typeof(*mr), inv_cqe);
-	struct rtrs_srv_con *con = cq->cq_context;
+	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
 	struct rtrs_sess *s = con->c.sess;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct rtrs_srv *srv = sess->srv;
@@ -1167,7 +1167,7 @@ static void rtrs_rdma_process_wr_wait_list(struct rtrs_srv_con *con)
 
 static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct rtrs_srv_con *con = cq->cq_context;
+	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
 	struct rtrs_sess *s = con->c.sess;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct rtrs_srv *srv = sess->srv;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index d13aff0aa816..d5ec78280937 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -218,14 +218,15 @@ static int create_cq(struct rtrs_con *con, int cq_vector, u16 cq_size,
 	struct rdma_cm_id *cm_id = con->cm_id;
 	struct ib_cq *cq;
 
-	cq = ib_alloc_cq(cm_id->device, con, cq_size,
-			 cq_vector, poll_ctx);
+	cq = ib_cq_pool_get(cm_id->device, cq_size,
+			    cq_vector, poll_ctx);
 	if (IS_ERR(cq)) {
 		rtrs_err(con->sess, "Creating completion queue failed, errno: %ld\n",
 			  PTR_ERR(cq));
 		return PTR_ERR(cq);
 	}
 	con->cq = cq;
+	con->cq_size = cq_size;
 
 	return 0;
 }
@@ -273,8 +274,9 @@ int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
 	err = create_qp(con, sess->dev->ib_pd, max_send_wr, max_recv_wr,
 			max_send_sge);
 	if (err) {
-		ib_free_cq(con->cq);
+		ib_cq_pool_put(con->cq, con->cq_size);
 		con->cq = NULL;
+		con->cq_size = 0;
 		return err;
 	}
 	con->sess = sess;
@@ -290,8 +292,9 @@ void rtrs_cq_qp_destroy(struct rtrs_con *con)
 		con->qp = NULL;
 	}
 	if (con->cq) {
-		ib_free_cq(con->cq);
+		ib_cq_pool_put(con->cq, con->cq_size);
 		con->cq = NULL;
+		con->cq_size = 0;
 	}
 }
 EXPORT_SYMBOL_GPL(rtrs_cq_qp_destroy);
-- 
2.25.1

