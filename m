Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9E47E1A2
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Dec 2021 11:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347775AbhLWKml (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 05:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbhLWKmi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Dec 2021 05:42:38 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BB8C061401
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 02:42:34 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m21so20972225edc.0
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 02:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LqnsBQEApZrMiM7aj+y5XbBDeXGilUwNl3oTAjH7hPw=;
        b=Y03N/Y/+vlm+1XaEgYhIOhPz99dDRH9wRMl+v1bUzWw7rgG8AwlNY3eJm+RRhjF9QZ
         xbOpDPx38bxqjtGsiHHRyozf2tV0hC+LxQPvbclPz1XEXeS9uQSji4j6/SjxB6rQJ0Sk
         2p2Y0kzPbGfg6bumOgFNV9syQ/70SSd70VXxoRiCBWXPPiU6qvnBwmQfAX98RGqxJJYQ
         caFKI7CPQXSHD089P5xsQGfVy7PHcfNQ5NsLowOEh3FM+IhJtPNtTNyQkcFUWiXhO+F6
         ql5fBJBbhFsgpLX4BDv4PWv2J5zTjRYC7GGr3G8nPxMv9UCSeWSMCAVVpTufJr70SnUp
         rkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LqnsBQEApZrMiM7aj+y5XbBDeXGilUwNl3oTAjH7hPw=;
        b=cLKjLsK42X1F/ghLjONfJbQDaal0C2najhvli01UNCiKgfUEycECZzQ1UuBbeW8G94
         HYHdF9aYhccv8v11w2YHtfpee1XNVY/qwCmS+rwoRxxsnFq59rIRZGzgoZ7IJdxktaAB
         mgaXx8hnCLQ16+Y2+R0LxU66ec8xj9PAfgiKgdrdMpD+qJTZmq6n2irl6G2l6mf/PLOd
         vee6G0eeM/MZ6fW0WdFkANwZhPLNlA/WGwa2UO0B00Y0BO2VxgC+BPOLYbJMQBVJeEvf
         FU6L05XGqBtJGtGWLAk3zy7xXfAMEx438Y8D9ustXDiXrnFWNAHUM1Vpi3tL3Gj11Rzh
         2QhQ==
X-Gm-Message-State: AOAM532kSYE/yh/IOR9lq6+Cn2CZyPoKym6pwAEdhqVEZKyi9gZGNov2
        4h/x6Y0lIxg1qDvtESxmK6Sl2cUAEdl87A==
X-Google-Smtp-Source: ABdhPJyWMWqHGtatk3FohXRnJG7l/aD27RinVK11RxVlNoEdwsU1Ase6dhcVtC+I6J8crJWGHM7EHQ==
X-Received: by 2002:a17:906:ed2:: with SMTP id u18mr1449084eji.366.1640256152537;
        Thu, 23 Dec 2021 02:42:32 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4536:ce00:c42a:2c1b:a58b:ae52])
        by smtp.gmail.com with ESMTPSA id ho14sm1627224ejc.73.2021.12.23.02.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 02:42:32 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Vaishali Thakkar <vaishali.thakkar@ionos.com>
Subject: [PATCH for-next 3/7] RDMA/rtrs-clt: Rename rtrs_sess to rtrs_path
Date:   Thu, 23 Dec 2021 11:42:25 +0100
Message-Id: <20211223104229.23053-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223104229.23053-1-jinpu.wang@ionos.com>
References: <20211223104229.23053-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Vaishali Thakkar <vaishali.thakkar@ionos.com>

rtrs_sess has been renamed to rtrs_path. This patch does
the followup changes in a client side module.

Coccinelle was used to do most of the transformation
and remaining ones were handled manually.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c |  4 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 66 ++++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  4 +-
 3 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
index 76e4352fe3f6..608069b7c303 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -13,7 +13,7 @@
 
 void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
 {
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 	struct rtrs_clt_stats *stats = sess->stats;
 	struct rtrs_clt_stats_pcpu *s;
 	int cpu;
@@ -180,7 +180,7 @@ static inline void rtrs_clt_update_rdma_stats(struct rtrs_clt_stats *stats,
 void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir)
 {
 	struct rtrs_clt_con *con = req->con;
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 	struct rtrs_clt_stats *stats = sess->stats;
 	unsigned int len;
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index e39709dee179..e767692ec221 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -298,7 +298,7 @@ static bool rtrs_clt_change_state_from_to(struct rtrs_clt_sess *sess,
 
 static void rtrs_rdma_error_recovery(struct rtrs_clt_con *con)
 {
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 
 	if (rtrs_clt_change_state_from_to(sess,
 					   RTRS_CLT_CONNECTED,
@@ -330,7 +330,7 @@ static void rtrs_clt_fast_reg_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 
 	if (wc->status != IB_WC_SUCCESS) {
-		rtrs_err(con->c.sess, "Failed IB_WR_REG_MR: %s\n",
+		rtrs_err(con->c.path, "Failed IB_WR_REG_MR: %s\n",
 			  ib_wc_status_msg(wc->status));
 		rtrs_rdma_error_recovery(con);
 	}
@@ -350,7 +350,7 @@ static void rtrs_clt_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 
 	if (wc->status != IB_WC_SUCCESS) {
-		rtrs_err(con->c.sess, "Failed IB_WR_LOCAL_INV: %s\n",
+		rtrs_err(con->c.path, "Failed IB_WR_LOCAL_INV: %s\n",
 			  ib_wc_status_msg(wc->status));
 		rtrs_rdma_error_recovery(con);
 	}
@@ -387,7 +387,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 		return;
 	if (WARN_ON(!req->con))
 		return;
-	sess = to_clt_sess(con->c.sess);
+	sess = to_clt_sess(con->c.path);
 
 	if (req->sg_cnt) {
 		if (req->dir == DMA_FROM_DEVICE && req->need_inv) {
@@ -417,7 +417,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 			refcount_inc(&req->ref);
 			err = rtrs_inv_rkey(req);
 			if (err) {
-				rtrs_err(con->c.sess, "Send INV WR key=%#x: %d\n",
+				rtrs_err(con->c.path, "Send INV WR key=%#x: %d\n",
 					  req->mr->rkey, err);
 			} else if (can_wait) {
 				wait_for_completion(&req->inv_comp);
@@ -445,7 +445,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	req->con = NULL;
 
 	if (errno) {
-		rtrs_err_rl(con->c.sess, "IO request failed: error=%d path=%s [%s:%u] notify=%d\n",
+		rtrs_err_rl(con->c.path, "IO request failed: error=%d path=%s [%s:%u] notify=%d\n",
 			    errno, kobject_name(&sess->kobj), sess->hca_name,
 			    sess->hca_port, notify);
 	}
@@ -459,12 +459,12 @@ static int rtrs_post_send_rdma(struct rtrs_clt_con *con,
 				struct rtrs_rbuf *rbuf, u32 off,
 				u32 imm, struct ib_send_wr *wr)
 {
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 	enum ib_send_flags flags;
 	struct ib_sge sge;
 
 	if (!req->sg_size) {
-		rtrs_wrn(con->c.sess,
+		rtrs_wrn(con->c.path,
 			 "Doing RDMA Write failed, no data supplied\n");
 		return -EINVAL;
 	}
@@ -507,21 +507,21 @@ static void rtrs_clt_recv_done(struct rtrs_clt_con *con, struct ib_wc *wc)
 {
 	struct rtrs_iu *iu;
 	int err;
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 
 	WARN_ON((sess->flags & RTRS_MSG_NEW_RKEY_F) == 0);
 	iu = container_of(wc->wr_cqe, struct rtrs_iu,
 			  cqe);
 	err = rtrs_iu_post_recv(&con->c, iu);
 	if (err) {
-		rtrs_err(con->c.sess, "post iu failed %d\n", err);
+		rtrs_err(con->c.path, "post iu failed %d\n", err);
 		rtrs_rdma_error_recovery(con);
 	}
 }
 
 static void rtrs_clt_rkey_rsp_done(struct rtrs_clt_con *con, struct ib_wc *wc)
 {
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 	struct rtrs_msg_rkey_rsp *msg;
 	u32 imm_type, imm_payload;
 	bool w_inval = false;
@@ -534,7 +534,7 @@ static void rtrs_clt_rkey_rsp_done(struct rtrs_clt_con *con, struct ib_wc *wc)
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
 
 	if (wc->byte_len < sizeof(*msg)) {
-		rtrs_err(con->c.sess, "rkey response is malformed: size %d\n",
+		rtrs_err(con->c.path, "rkey response is malformed: size %d\n",
 			  wc->byte_len);
 		goto out;
 	}
@@ -600,7 +600,7 @@ static int rtrs_post_recv_empty_x2(struct rtrs_con *con, struct ib_cqe *cqe)
 static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 	u32 imm_type, imm_payload;
 	bool w_inval = false;
 	int err;
@@ -646,7 +646,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 			if (sess->flags & RTRS_MSG_NEW_RKEY_F)
 				return  rtrs_clt_recv_done(con, wc);
 		} else {
-			rtrs_wrn(con->c.sess, "Unknown IMM type %u\n",
+			rtrs_wrn(con->c.path, "Unknown IMM type %u\n",
 				  imm_type);
 		}
 		if (w_inval)
@@ -658,7 +658,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		else
 			err = rtrs_post_recv_empty(&con->c, &io_comp_cqe);
 		if (err) {
-			rtrs_err(con->c.sess, "rtrs_post_recv_empty(): %d\n",
+			rtrs_err(con->c.path, "rtrs_post_recv_empty(): %d\n",
 				  err);
 			rtrs_rdma_error_recovery(con);
 		}
@@ -693,7 +693,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 static int post_recv_io(struct rtrs_clt_con *con, size_t q_size)
 {
 	int err, i;
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 
 	for (i = 0; i < q_size; i++) {
 		if (sess->flags & RTRS_MSG_NEW_RKEY_F) {
@@ -1013,7 +1013,7 @@ static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
 				   u32 size, u32 imm, struct ib_send_wr *wr,
 				   struct ib_send_wr *tail)
 {
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 	struct ib_sge *sge = req->sge;
 	enum ib_send_flags flags;
 	struct scatterlist *sg;
@@ -1074,7 +1074,7 @@ static int rtrs_map_sg_fr(struct rtrs_clt_io_req *req, size_t count)
 static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 {
 	struct rtrs_clt_con *con = req->con;
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_clt_sess *sess = to_clt_sess(s);
 	struct rtrs_msg_rdma_write *msg;
 
@@ -1168,7 +1168,7 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 {
 	struct rtrs_clt_con *con = req->con;
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_clt_sess *sess = to_clt_sess(s);
 	struct rtrs_msg_rdma_read *msg;
 	struct rtrs_ib_dev *dev = sess->s.dev;
@@ -1601,7 +1601,7 @@ static int create_con(struct rtrs_clt_sess *sess, unsigned int cid)
 	/* Map first two connections to the first CPU */
 	con->cpu  = (cid ? cid - 1 : 0) % nr_cpu_ids;
 	con->c.cid = cid;
-	con->c.sess = &sess->s;
+	con->c.path = &sess->s;
 	/* Align with srv, init as 1 */
 	atomic_set(&con->c.wr_cnt, 1);
 	mutex_init(&con->con_mutex);
@@ -1613,7 +1613,7 @@ static int create_con(struct rtrs_clt_sess *sess, unsigned int cid)
 
 static void destroy_con(struct rtrs_clt_con *con)
 {
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 
 	sess->s.con[con->c.cid] = NULL;
 	mutex_destroy(&con->con_mutex);
@@ -1622,7 +1622,7 @@ static void destroy_con(struct rtrs_clt_con *con)
 
 static int create_con_cq_qp(struct rtrs_clt_con *con)
 {
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 	u32 max_send_wr, max_recv_wr, cq_num, max_send_sge, wr_limit;
 	int err, cq_vector;
 	struct rtrs_msg_rkey_rsp *rsp;
@@ -1711,7 +1711,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 
 static void destroy_con_cq_qp(struct rtrs_clt_con *con)
 {
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 
 	/*
 	 * Be careful here: destroy_con_cq_qp() can be called even
@@ -1745,7 +1745,7 @@ static void destroy_cm(struct rtrs_clt_con *con)
 
 static int rtrs_rdma_addr_resolved(struct rtrs_clt_con *con)
 {
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	int err;
 
 	mutex_lock(&con->con_mutex);
@@ -1764,7 +1764,7 @@ static int rtrs_rdma_addr_resolved(struct rtrs_clt_con *con)
 
 static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
 {
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 	struct rtrs_clt *clt = sess->clt;
 	struct rtrs_msg_conn_req msg;
 	struct rdma_conn_param param;
@@ -1799,7 +1799,7 @@ static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
 static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 				       struct rdma_cm_event *ev)
 {
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 	struct rtrs_clt *clt = sess->clt;
 	const struct rtrs_msg_conn_rsp *msg;
 	u16 version, queue_depth;
@@ -1887,7 +1887,7 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 
 static inline void flag_success_on_conn(struct rtrs_clt_con *con)
 {
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 
 	atomic_inc(&sess->connected_cnt);
 	con->cm_err = 1;
@@ -1896,7 +1896,7 @@ static inline void flag_success_on_conn(struct rtrs_clt_con *con)
 static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 				    struct rdma_cm_event *ev)
 {
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	const struct rtrs_msg_conn_rsp *msg;
 	const char *rej_msg;
 	int status, errno;
@@ -1937,7 +1937,7 @@ static inline void flag_error_on_conn(struct rtrs_clt_con *con, int cm_err)
 	if (con->cm_err == 1) {
 		struct rtrs_clt_sess *sess;
 
-		sess = to_clt_sess(con->c.sess);
+		sess = to_clt_sess(con->c.path);
 		if (atomic_dec_and_test(&sess->connected_cnt))
 
 			wake_up(&sess->state_wq);
@@ -1949,7 +1949,7 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 				     struct rdma_cm_event *ev)
 {
 	struct rtrs_clt_con *con = cm_id->context;
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_clt_sess *sess = to_clt_sess(s);
 	int cm_err = 0;
 
@@ -2020,7 +2020,7 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 
 static int create_cm(struct rtrs_clt_con *con)
 {
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_clt_sess *sess = to_clt_sess(s);
 	struct rdma_cm_id *cm_id;
 	int err;
@@ -2375,7 +2375,7 @@ static int init_conns(struct rtrs_clt_sess *sess)
 static void rtrs_clt_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 	struct rtrs_iu *iu;
 
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
@@ -2456,7 +2456,7 @@ static int process_info_rsp(struct rtrs_clt_sess *sess,
 static void rtrs_clt_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
-	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
 	struct rtrs_msg_info_rsp *msg;
 	enum rtrs_clt_state state;
 	struct rtrs_iu *iu;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 9afffccff973..57579b2c91d1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -125,7 +125,7 @@ struct rtrs_rbuf {
 };
 
 struct rtrs_clt_sess {
-	struct rtrs_sess	s;
+	struct rtrs_path	s;
 	struct rtrs_clt	*clt;
 	wait_queue_head_t	state_wq;
 	enum rtrs_clt_state	state;
@@ -186,7 +186,7 @@ static inline struct rtrs_clt_con *to_clt_con(struct rtrs_con *c)
 	return container_of(c, struct rtrs_clt_con, c);
 }
 
-static inline struct rtrs_clt_sess *to_clt_sess(struct rtrs_sess *s)
+static inline struct rtrs_clt_sess *to_clt_sess(struct rtrs_path *s)
 {
 	return container_of(s, struct rtrs_clt_sess, s);
 }
-- 
2.25.1

