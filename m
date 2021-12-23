Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AFD47E1A1
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Dec 2021 11:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbhLWKme (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 05:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbhLWKmd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Dec 2021 05:42:33 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9047C061401
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 02:42:32 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o6so19745650edc.4
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 02:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+0v6D/LBxc+snH7jpaZoh7NT/cpyLFaBaraPj4HSEk=;
        b=dZ3BkaFBniPqcyzCFSkWqK+/WQEEg0nQL3XCwEEw4IS4m9BYwHTjYJBCOxe8I58x+4
         pmAGqsmvH/mJF4QmxkWAiYe0/ovh54O8qlKJ6CiaUV7cpNlc5Fg3UGkjCQx047UjDiSs
         20QA9qU/5Oyk+MlwiLtXw7NvmCvJ8FNmIt3Kri9khCVspBmP1vEQOTfsZd/tsr0QJux+
         HiJ3xZAW5CxL8BLcUp2lyhw2Dx6FNM2VPiR8Bp0+4FHloA0Z8joKuJPMzzDLjbJg1YBP
         aRwxcPsQzGfQdfvQMOuVgzUZHZ+WufooMdIMiuDbz4iODra+mRdhj666ukjMhv1IOKy3
         vXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+0v6D/LBxc+snH7jpaZoh7NT/cpyLFaBaraPj4HSEk=;
        b=OL8LnRcFk53jP7JPSl6wkW9kBWiS7JAf3voSc2g/B1Nzen6xN95oKvN5Rsu/flZV5k
         ds+Ib2zb9w9H4+Ju6pwjfHQYaGCj9u2RRyMpqxDCGTm0kIEA8agB/vhUc7F/jhdF1g9s
         GZKEtpRDBDOcgzUnisSiRex0sbIzfZnXr7HsKlSBFWbhXbcTmQwCti0psVabIotYTWWo
         xfsjC1NDsP9+7tsQBfjaFKsKprxGSv/BUZTjbYpWThrdKTOwgjYg41LxhllvwSRqGZf9
         p6NRp1pDXayIJk9sdjqDtoecbF88s3T4Pma1+lEjsg/HK6ufGGCU8cnOavwGPEYRTMkM
         JBaQ==
X-Gm-Message-State: AOAM533fVq6iq5vatl0EZ7UAq4sdf+PP++UHmHPIb879EhfeRnO0+fSd
        VByt2gD9ZXnMiW9xsioocB0A1Ikt4db66g==
X-Google-Smtp-Source: ABdhPJy++PEnBoJvGIm6jShNTBQKPeAogVHR5A95A9i3bCKH0rm4tw6bi83p2waUdk6rxE1DwEMVQA==
X-Received: by 2002:a17:907:7286:: with SMTP id dt6mr1417392ejc.698.1640256151273;
        Thu, 23 Dec 2021 02:42:31 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4536:ce00:c42a:2c1b:a58b:ae52])
        by smtp.gmail.com with ESMTPSA id ho14sm1627224ejc.73.2021.12.23.02.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 02:42:31 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Vaishali Thakkar <vaishali.thakkar@ionos.com>
Subject: [PATCH for-next 1/7] RDMA/rtrs: Rename rtrs_sess to rtrs_path
Date:   Thu, 23 Dec 2021 11:42:23 +0100
Message-Id: <20211223104229.23053-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223104229.23053-1-jinpu.wang@ionos.com>
References: <20211223104229.23053-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Vaishali Thakkar <vaishali.thakkar@ionos.com>

rtrs_sess is in fact a path. This makes it confusing
and difficult to get into the code. So let's rename
the structure and related use cases of it.

Coccinelle was used to do the transformation for
most of the occurrences and remaining ones were
handled manually.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 14 ++--
 drivers/infiniband/ulp/rtrs/rtrs.c     | 98 +++++++++++++-------------
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 78eac9a4f703..016e136f0765 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -90,7 +90,7 @@ struct rtrs_ib_dev {
 };
 
 struct rtrs_con {
-	struct rtrs_sess	*sess;
+	struct rtrs_path	*path;
 	struct ib_qp		*qp;
 	struct ib_cq		*cq;
 	struct rdma_cm_id	*cm_id;
@@ -100,7 +100,7 @@ struct rtrs_con {
 	atomic_t		sq_wr_avail;
 };
 
-struct rtrs_sess {
+struct rtrs_path {
 	struct list_head	entry;
 	struct sockaddr_storage dst_addr;
 	struct sockaddr_storage src_addr;
@@ -313,19 +313,19 @@ int rtrs_iu_post_rdma_write_imm(struct rtrs_con *con, struct rtrs_iu *iu,
 
 int rtrs_post_recv_empty(struct rtrs_con *con, struct ib_cqe *cqe);
 
-int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
+int rtrs_cq_qp_create(struct rtrs_path *path, struct rtrs_con *con,
 		      u32 max_send_sge, int cq_vector, int nr_cqe,
 		      u32 max_send_wr, u32 max_recv_wr,
 		      enum ib_poll_context poll_ctx);
 void rtrs_cq_qp_destroy(struct rtrs_con *con);
 
-void rtrs_init_hb(struct rtrs_sess *sess, struct ib_cqe *cqe,
+void rtrs_init_hb(struct rtrs_path *path, struct ib_cqe *cqe,
 		  unsigned int interval_ms, unsigned int missed_max,
 		  void (*err_handler)(struct rtrs_con *con),
 		  struct workqueue_struct *wq);
-void rtrs_start_hb(struct rtrs_sess *sess);
-void rtrs_stop_hb(struct rtrs_sess *sess);
-void rtrs_send_hb_ack(struct rtrs_sess *sess);
+void rtrs_start_hb(struct rtrs_path *path);
+void rtrs_stop_hb(struct rtrs_path *path);
+void rtrs_send_hb_ack(struct rtrs_path *path);
 
 void rtrs_rdma_dev_pd_init(enum ib_pd_flags pd_flags,
 			   struct rtrs_rdma_dev_pd *pool);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 37952c8e768c..4da889103a5f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -69,16 +69,16 @@ EXPORT_SYMBOL_GPL(rtrs_iu_free);
 
 int rtrs_iu_post_recv(struct rtrs_con *con, struct rtrs_iu *iu)
 {
-	struct rtrs_sess *sess = con->sess;
+	struct rtrs_path *path = con->path;
 	struct ib_recv_wr wr;
 	struct ib_sge list;
 
 	list.addr   = iu->dma_addr;
 	list.length = iu->size;
-	list.lkey   = sess->dev->ib_pd->local_dma_lkey;
+	list.lkey   = path->dev->ib_pd->local_dma_lkey;
 
 	if (list.length == 0) {
-		rtrs_wrn(con->sess,
+		rtrs_wrn(con->path,
 			  "Posting receive work request failed, sg list is empty\n");
 		return -EINVAL;
 	}
@@ -126,7 +126,7 @@ static int rtrs_post_send(struct ib_qp *qp, struct ib_send_wr *head,
 int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
 		       struct ib_send_wr *head)
 {
-	struct rtrs_sess *sess = con->sess;
+	struct rtrs_path *path = con->path;
 	struct ib_send_wr wr;
 	struct ib_sge list;
 
@@ -135,7 +135,7 @@ int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
 
 	list.addr   = iu->dma_addr;
 	list.length = size;
-	list.lkey   = sess->dev->ib_pd->local_dma_lkey;
+	list.lkey   = path->dev->ib_pd->local_dma_lkey;
 
 	wr = (struct ib_send_wr) {
 		.wr_cqe     = &iu->cqe,
@@ -188,11 +188,11 @@ static int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con,
 					  struct ib_send_wr *head)
 {
 	struct ib_rdma_wr wr;
-	struct rtrs_sess *sess = con->sess;
+	struct rtrs_path *path = con->path;
 	enum ib_send_flags sflags;
 
 	atomic_dec_if_positive(&con->sq_wr_avail);
-	sflags = (atomic_inc_return(&con->wr_cnt) % sess->signal_interval) ?
+	sflags = (atomic_inc_return(&con->wr_cnt) % path->signal_interval) ?
 		0 : IB_SEND_SIGNALED;
 
 	wr = (struct ib_rdma_wr) {
@@ -211,12 +211,12 @@ static void qp_event_handler(struct ib_event *ev, void *ctx)
 
 	switch (ev->event) {
 	case IB_EVENT_COMM_EST:
-		rtrs_info(con->sess, "QP event %s (%d) received\n",
+		rtrs_info(con->path, "QP event %s (%d) received\n",
 			   ib_event_msg(ev->event), ev->event);
 		rdma_notify(con->cm_id, IB_EVENT_COMM_EST);
 		break;
 	default:
-		rtrs_info(con->sess, "Unhandled QP event %s (%d) received\n",
+		rtrs_info(con->path, "Unhandled QP event %s (%d) received\n",
 			   ib_event_msg(ev->event), ev->event);
 		break;
 	}
@@ -224,7 +224,7 @@ static void qp_event_handler(struct ib_event *ev, void *ctx)
 
 static bool is_pollqueue(struct rtrs_con *con)
 {
-	return con->cid >= con->sess->irq_con_num;
+	return con->cid >= con->path->irq_con_num;
 }
 
 static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
@@ -240,7 +240,7 @@ static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
 		cq = ib_cq_pool_get(cm_id->device, nr_cqe, cq_vector, poll_ctx);
 
 	if (IS_ERR(cq)) {
-		rtrs_err(con->sess, "Creating completion queue failed, errno: %ld\n",
+		rtrs_err(con->path, "Creating completion queue failed, errno: %ld\n",
 			  PTR_ERR(cq));
 		return PTR_ERR(cq);
 	}
@@ -271,7 +271,7 @@ static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
 
 	ret = rdma_create_qp(cm_id, pd, &init_attr);
 	if (ret) {
-		rtrs_err(con->sess, "Creating QP failed, err: %d\n", ret);
+		rtrs_err(con->path, "Creating QP failed, err: %d\n", ret);
 		return ret;
 	}
 	con->qp = cm_id->qp;
@@ -290,7 +290,7 @@ static void destroy_cq(struct rtrs_con *con)
 	con->cq = NULL;
 }
 
-int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
+int rtrs_cq_qp_create(struct rtrs_path *path, struct rtrs_con *con,
 		       u32 max_send_sge, int cq_vector, int nr_cqe,
 		       u32 max_send_wr, u32 max_recv_wr,
 		       enum ib_poll_context poll_ctx)
@@ -301,13 +301,13 @@ int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
 	if (err)
 		return err;
 
-	err = create_qp(con, sess->dev->ib_pd, max_send_wr, max_recv_wr,
+	err = create_qp(con, path->dev->ib_pd, max_send_wr, max_recv_wr,
 			max_send_sge);
 	if (err) {
 		destroy_cq(con);
 		return err;
 	}
-	con->sess = sess;
+	con->path = path;
 
 	return 0;
 }
@@ -323,24 +323,24 @@ void rtrs_cq_qp_destroy(struct rtrs_con *con)
 }
 EXPORT_SYMBOL_GPL(rtrs_cq_qp_destroy);
 
-static void schedule_hb(struct rtrs_sess *sess)
+static void schedule_hb(struct rtrs_path *path)
 {
-	queue_delayed_work(sess->hb_wq, &sess->hb_dwork,
-			   msecs_to_jiffies(sess->hb_interval_ms));
+	queue_delayed_work(path->hb_wq, &path->hb_dwork,
+			   msecs_to_jiffies(path->hb_interval_ms));
 }
 
-void rtrs_send_hb_ack(struct rtrs_sess *sess)
+void rtrs_send_hb_ack(struct rtrs_path *path)
 {
-	struct rtrs_con *usr_con = sess->con[0];
+	struct rtrs_con *usr_con = path->con[0];
 	u32 imm;
 	int err;
 
 	imm = rtrs_to_imm(RTRS_HB_ACK_IMM, 0);
-	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
+	err = rtrs_post_rdma_write_imm_empty(usr_con, path->hb_cqe, imm,
 					     NULL);
 	if (err) {
-		rtrs_err(sess, "send HB ACK failed, errno: %d\n", err);
-		sess->hb_err_handler(usr_con);
+		rtrs_err(path, "send HB ACK failed, errno: %d\n", err);
+		path->hb_err_handler(usr_con);
 		return;
 	}
 }
@@ -349,63 +349,63 @@ EXPORT_SYMBOL_GPL(rtrs_send_hb_ack);
 static void hb_work(struct work_struct *work)
 {
 	struct rtrs_con *usr_con;
-	struct rtrs_sess *sess;
+	struct rtrs_path *path;
 	u32 imm;
 	int err;
 
-	sess = container_of(to_delayed_work(work), typeof(*sess), hb_dwork);
-	usr_con = sess->con[0];
+	path = container_of(to_delayed_work(work), typeof(*path), hb_dwork);
+	usr_con = path->con[0];
 
-	if (sess->hb_missed_cnt > sess->hb_missed_max) {
-		rtrs_err(sess, "HB missed max reached.\n");
-		sess->hb_err_handler(usr_con);
+	if (path->hb_missed_cnt > path->hb_missed_max) {
+		rtrs_err(path, "HB missed max reached.\n");
+		path->hb_err_handler(usr_con);
 		return;
 	}
-	if (sess->hb_missed_cnt++) {
+	if (path->hb_missed_cnt++) {
 		/* Reschedule work without sending hb */
-		schedule_hb(sess);
+		schedule_hb(path);
 		return;
 	}
 
-	sess->hb_last_sent = ktime_get();
+	path->hb_last_sent = ktime_get();
 
 	imm = rtrs_to_imm(RTRS_HB_MSG_IMM, 0);
-	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
+	err = rtrs_post_rdma_write_imm_empty(usr_con, path->hb_cqe, imm,
 					     NULL);
 	if (err) {
-		rtrs_err(sess, "HB send failed, errno: %d\n", err);
-		sess->hb_err_handler(usr_con);
+		rtrs_err(path, "HB send failed, errno: %d\n", err);
+		path->hb_err_handler(usr_con);
 		return;
 	}
 
-	schedule_hb(sess);
+	schedule_hb(path);
 }
 
-void rtrs_init_hb(struct rtrs_sess *sess, struct ib_cqe *cqe,
+void rtrs_init_hb(struct rtrs_path *path, struct ib_cqe *cqe,
 		  unsigned int interval_ms, unsigned int missed_max,
 		  void (*err_handler)(struct rtrs_con *con),
 		  struct workqueue_struct *wq)
 {
-	sess->hb_cqe = cqe;
-	sess->hb_interval_ms = interval_ms;
-	sess->hb_err_handler = err_handler;
-	sess->hb_wq = wq;
-	sess->hb_missed_max = missed_max;
-	sess->hb_missed_cnt = 0;
-	INIT_DELAYED_WORK(&sess->hb_dwork, hb_work);
+	path->hb_cqe = cqe;
+	path->hb_interval_ms = interval_ms;
+	path->hb_err_handler = err_handler;
+	path->hb_wq = wq;
+	path->hb_missed_max = missed_max;
+	path->hb_missed_cnt = 0;
+	INIT_DELAYED_WORK(&path->hb_dwork, hb_work);
 }
 EXPORT_SYMBOL_GPL(rtrs_init_hb);
 
-void rtrs_start_hb(struct rtrs_sess *sess)
+void rtrs_start_hb(struct rtrs_path *path)
 {
-	schedule_hb(sess);
+	schedule_hb(path);
 }
 EXPORT_SYMBOL_GPL(rtrs_start_hb);
 
-void rtrs_stop_hb(struct rtrs_sess *sess)
+void rtrs_stop_hb(struct rtrs_path *path)
 {
-	cancel_delayed_work_sync(&sess->hb_dwork);
-	sess->hb_missed_cnt = 0;
+	cancel_delayed_work_sync(&path->hb_dwork);
+	path->hb_missed_cnt = 0;
 }
 EXPORT_SYMBOL_GPL(rtrs_stop_hb);
 
-- 
2.25.1

