Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB40D321A16
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 15:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBVOSw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 09:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhBVOQh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 09:16:37 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72142C06174A
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 06:15:54 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id j6so2519230eja.12
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 06:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XH73av95zFq3ZGWS+TtRnD2+tLkV/fN69mwbUHICneY=;
        b=T9gY6WjxkxYrdB9DOFqDEeRU76NStSMRcPKXqtWIqy4Un/wGb80OTl+jCb7ukaPaIh
         T8am3rOHYjIxNlGpl21eJeaqpzjrJsD17xGcCrrIFzIwXtZZzJOHCFKQ7Q6NaMq+cGW9
         sC6RnLq8MBs6ExM8ZGi09Gv2RJg6mkJxmSKn5JyD/rGZ8TdNqshauh5krv6TrLmPwIFY
         k9wSRIsMs+B4VLPYrseyljjAi76Jz73a8DhH25O2OMQahLUpsAomK3g9oDfKJi/aOwJ4
         pw/L/qYhbDmAMH9DWrg2yO8uF8sJiZX9JLplHJO/jHfj0SrPe3P28I7n/qgWBa7xIWY7
         do/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XH73av95zFq3ZGWS+TtRnD2+tLkV/fN69mwbUHICneY=;
        b=OaaW/iARA8muFfqYMw3DObR00mBnWVAuYllBEyscXZeGl3Qyv1I4/OYeiHAGgz8mYC
         OzLUcWWJLlc8Y4yAq+a+IW5IjiljKqZhsu6UcJ7PxeVXRn6T0QsG9WQtGPK5ZzICDlRM
         vV881pRnyWFbj6/tRkQgsYlTecitlyCOaPl2d0CQH+I46zjyOEO/T7VP+xE5cW1mspDe
         tuo2rTGmtNaZGMA7COHEPem5nEouC1kQXm0iSoU1YoOYPHwyCxhl3pzguiFfsJbyQL0M
         Q2qOBD1QEU1a0oJpLvRuSp/Y/1TeAxhTrX2Hx5nNmpJ2WNn2xeNg2oIbD/nWtFnfZmNW
         4k/Q==
X-Gm-Message-State: AOAM533cLf2Um4z8pVQABhC9W7XZBeIggygUNvLPZbDpdd2hltf+xHX9
        GBgcoezEp2lltA40zrf9xBXrCr7E5CKOIQ==
X-Google-Smtp-Source: ABdhPJxlZ8QBgAmq2pTSkwaOdjBHO9SmzoT/URmN8C2X6JuJ4KKi30hHsaQVlYPPpKAcrvKJFNz1Zw==
X-Received: by 2002:a17:906:4e8f:: with SMTP id v15mr11208494eju.357.1614003352963;
        Mon, 22 Feb 2021 06:15:52 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:496a:ec00:9029:bb23:33bd:ec62])
        by smtp.gmail.com with ESMTPSA id m19sm11615606eds.8.2021.02.22.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 06:15:52 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCHv2 for-next 1/2] RDMA/rtrs: Use new shared CQ mechanism
Date:   Mon, 22 Feb 2021 15:15:50 +0100
Message-Id: <20210222141551.54345-1-jinpu.wang@cloud.ionos.com>
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
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 +++++-----
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 10 +++++-----
 drivers/infiniband/ulp/rtrs/rtrs.c     |  9 +++++----
 4 files changed, 16 insertions(+), 14 deletions(-)

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
index d13aff0aa816..64f2fd63e9c5 100644
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
@@ -273,7 +274,7 @@ int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
 	err = create_qp(con, sess->dev->ib_pd, max_send_wr, max_recv_wr,
 			max_send_sge);
 	if (err) {
-		ib_free_cq(con->cq);
+		ib_cq_pool_put(con->cq, con->cq_size);
 		con->cq = NULL;
 		return err;
 	}
@@ -290,7 +291,7 @@ void rtrs_cq_qp_destroy(struct rtrs_con *con)
 		con->qp = NULL;
 	}
 	if (con->cq) {
-		ib_free_cq(con->cq);
+		ib_cq_pool_put(con->cq, con->cq_size);
 		con->cq = NULL;
 	}
 }
-- 
2.25.1

