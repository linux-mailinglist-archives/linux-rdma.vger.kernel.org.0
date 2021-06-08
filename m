Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081AB39F395
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFHKcj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 06:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhFHKcj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 06:32:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2079DC061574
        for <linux-rdma@vger.kernel.org>; Tue,  8 Jun 2021 03:30:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ci15so31763779ejc.10
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 03:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXPQ5gfawfQniyV8yQcAPx6eoaR9jr7ethn/8o5VfWI=;
        b=briTpJd/T2ApXErndHwV8tcM7tRc2Etzmso7vp+JDBF75zbSQQjZ/3RdzYADWuxETi
         njm/U5/tj1uvgtyBeoBuqzcYr7tPAooPlGXvZEVDKfdo9QAmriFy/QehqXV4vdqEO97j
         1TeGFFI11TftM8+ql1UepG8EPesYM24EoUXLCMiCuXFYs46wvA4tDFwa6RGOd9lQc0yo
         Px3eUWFeEMrp9kuCDnHHNcwKOc4BnwhNB20VoJ8N+L4LCDySwh9ahifAo71edkI9Kgyx
         GmuOHBoHt6S7IeOn3rzH2IDExCr3l4zStRcWIbcIXmZdYdVNVrRiuUMD0Uy3RHzOtOit
         D5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXPQ5gfawfQniyV8yQcAPx6eoaR9jr7ethn/8o5VfWI=;
        b=XukCcf7QSZe14qwClwix6eMWzFR+jZBUDygDQVoVtjnoslrEkkJUcLap9C2cWDYBUN
         QJymYrUy7z/D2o5zUEbZjGt/QGO+BiWmP4ucks8f77rOyuQ/OcqdeSKiK4fDxzN9bnrl
         +cJZsTFplbmppIhAn53hh3K2Xyl6IKgwo/NFmou61uMEK0ZtlzPLXrAZZAQtUsX0ODXu
         yTf1GPM6qYFJ8FJL5BDGVB14rCu23JRttTSbNvM2tDvDawyRtuusdK4FgUYK0x4TI80c
         OpvS4wZzFm6cZucJ3fbRrCtVcmwyFtK0mYuby15EwEuvhT5v1/PqbcArYTBd4k+OAlGb
         YpoQ==
X-Gm-Message-State: AOAM531R5ATFhYgd4lqcxDjPhU7gLcZk9RKuZUFYNOWhryn7hvYd1aeP
        uoGKvkq6EjCkRy0jphoMleO87CgG5OyVMA==
X-Google-Smtp-Source: ABdhPJxwFUxFeb89NJdD9uTdAlbLBghoXNIZyUurjXpqI3GUbNs642jkzAAAkkUz7bLhnWukqVkxQQ==
X-Received: by 2002:a17:906:c9cf:: with SMTP id hk15mr22566842ejb.445.1623148244496;
        Tue, 08 Jun 2021 03:30:44 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4943:5b00:2927:a608:b264:d770])
        by smtp.gmail.com with ESMTPSA id dy19sm8634400edb.68.2021.06.08.03.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:30:44 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-next 4/4] RDMA/rtrs: Rename some variables to avoid confusion
Date:   Tue,  8 Jun 2021 12:30:39 +0200
Message-Id: <20210608103039.39080-5-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608103039.39080-1-jinpu.wang@ionos.com>
References: <20210608103039.39080-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Those variables are passed to create_cq, create_qp, rtrs_iu_alloc and
rtrs_iu_free, so these *_size means the num of unit. And cq_size also
means number of cq element.

Also move the setting of cq_num to common path.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 18 +++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 10 +++++-----
 drivers/infiniband/ulp/rtrs/rtrs-srv.c |  7 +++----
 drivers/infiniband/ulp/rtrs/rtrs.c     | 24 ++++++++++++------------
 5 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index acf0fde410c3..67ff5bf9bfa8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1572,7 +1572,7 @@ static void destroy_con(struct rtrs_clt_con *con)
 static int create_con_cq_qp(struct rtrs_clt_con *con)
 {
 	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
-	u32 max_send_wr, max_recv_wr, cq_size, max_send_sge;
+	u32 max_send_wr, max_recv_wr, cq_num, max_send_sge;
 	int err, cq_vector;
 	struct rtrs_msg_rkey_rsp *rsp;
 
@@ -1628,26 +1628,26 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 			      sess->queue_depth * 3 + 1);
 		max_send_sge = sess->clt->max_segments + 1;
 	}
-	cq_size = max_send_wr + max_recv_wr;
+	cq_num = max_send_wr + max_recv_wr;
 	/* alloc iu to recv new rkey reply when server reports flags set */
 	if (sess->flags & RTRS_MSG_NEW_RKEY_F || con->c.cid == 0) {
-		con->rsp_ius = rtrs_iu_alloc(cq_size, sizeof(*rsp),
+		con->rsp_ius = rtrs_iu_alloc(cq_num, sizeof(*rsp),
 					      GFP_KERNEL, sess->s.dev->ib_dev,
 					      DMA_FROM_DEVICE,
 					      rtrs_clt_rdma_done);
 		if (!con->rsp_ius)
 			return -ENOMEM;
-		con->queue_size = cq_size;
+		con->queue_num = cq_num;
 	}
-	cq_size = max_send_wr + max_recv_wr;
+	cq_num = max_send_wr + max_recv_wr;
 	cq_vector = con->cpu % sess->s.dev->ib_dev->num_comp_vectors;
 	if (con->c.cid >= sess->s.irq_con_num)
 		err = rtrs_cq_qp_create(&sess->s, &con->c, max_send_sge,
-					cq_vector, cq_size, max_send_wr,
+					cq_vector, cq_num, max_send_wr,
 					max_recv_wr, IB_POLL_DIRECT);
 	else
 		err = rtrs_cq_qp_create(&sess->s, &con->c, max_send_sge,
-					cq_vector, cq_size, max_send_wr,
+					cq_vector, cq_num, max_send_wr,
 					max_recv_wr, IB_POLL_SOFTIRQ);
 	/*
 	 * In case of error we do not bother to clean previous allocations,
@@ -1667,9 +1667,9 @@ static void destroy_con_cq_qp(struct rtrs_clt_con *con)
 	lockdep_assert_held(&con->con_mutex);
 	rtrs_cq_qp_destroy(&con->c);
 	if (con->rsp_ius) {
-		rtrs_iu_free(con->rsp_ius, sess->s.dev->ib_dev, con->queue_size);
+		rtrs_iu_free(con->rsp_ius, sess->s.dev->ib_dev, con->queue_num);
 		con->rsp_ius = NULL;
-		con->queue_size = 0;
+		con->queue_num = 0;
 	}
 	if (sess->s.dev_ref && !--sess->s.dev_ref) {
 		rtrs_ib_dev_put(sess->s.dev);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 822a820540d4..eed2a20ee9be 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -71,7 +71,7 @@ struct rtrs_clt_stats {
 struct rtrs_clt_con {
 	struct rtrs_con	c;
 	struct rtrs_iu		*rsp_ius;
-	u32			queue_size;
+	u32			queue_num;
 	unsigned int		cpu;
 	struct mutex		con_mutex;
 	atomic_t		io_cnt;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index bd06a79fd516..76cca2058f6f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -95,7 +95,7 @@ struct rtrs_con {
 	struct ib_cq		*cq;
 	struct rdma_cm_id	*cm_id;
 	unsigned int		cid;
-	u16                     cq_size;
+	int                     nr_cqe;
 };
 
 struct rtrs_sess {
@@ -294,10 +294,10 @@ struct rtrs_msg_rdma_hdr {
 
 /* rtrs.c */
 
-struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t t,
+struct rtrs_iu *rtrs_iu_alloc(u32 queue_num, size_t size, gfp_t t,
 			      struct ib_device *dev, enum dma_data_direction,
 			      void (*done)(struct ib_cq *cq, struct ib_wc *wc));
-void rtrs_iu_free(struct rtrs_iu *iu, struct ib_device *dev, u32 queue_size);
+void rtrs_iu_free(struct rtrs_iu *iu, struct ib_device *dev, u32 queue_num);
 int rtrs_iu_post_recv(struct rtrs_con *con, struct rtrs_iu *iu);
 int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
 		      struct ib_send_wr *head);
@@ -312,8 +312,8 @@ int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
 				   u32 imm_data, enum ib_send_flags flags,
 				   struct ib_send_wr *head);
 
-int rtrs_cq_qp_create(struct rtrs_sess *rtrs_sess, struct rtrs_con *con,
-		      u32 max_send_sge, int cq_vector, int cq_size,
+int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
+		      u32 max_send_sge, int cq_vector, int nr_cqe,
 		      u32 max_send_wr, u32 max_recv_wr,
 		      enum ib_poll_context poll_ctx);
 void rtrs_cq_qp_destroy(struct rtrs_con *con);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index bb73f7762a87..c10dfc296259 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1634,7 +1634,7 @@ static int create_con(struct rtrs_srv_sess *sess,
 	struct rtrs_sess *s = &sess->s;
 	struct rtrs_srv_con *con;
 
-	u32 cq_size, max_send_wr, max_recv_wr, wr_limit;
+	u32 cq_num, max_send_wr, max_recv_wr, wr_limit;
 	int err, cq_vector;
 
 	con = kzalloc(sizeof(*con), GFP_KERNEL);
@@ -1657,7 +1657,6 @@ static int create_con(struct rtrs_srv_sess *sess,
 		 */
 		max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
 		max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
-		cq_size = max_send_wr + max_recv_wr;
 	} else {
 		/*
 		 * In theory we might have queue_depth * 32
@@ -1683,13 +1682,13 @@ static int create_con(struct rtrs_srv_sess *sess,
 		 * requires an invalidate request + drain
 		 * and qp gets into error state.
 		 */
-		cq_size = max_send_wr + max_recv_wr;
 	}
+	cq_num = max_send_wr + max_recv_wr;
 	atomic_set(&con->sq_wr_avail, max_send_wr);
 	cq_vector = rtrs_srv_get_next_cq_vector(sess);
 
 	/* TODO: SOFTIRQ can be faster, but be careful with softirq context */
-	err = rtrs_cq_qp_create(&sess->s, &con->c, 1, cq_vector, cq_size,
+	err = rtrs_cq_qp_create(&sess->s, &con->c, 1, cq_vector, cq_num,
 				 max_send_wr, max_recv_wr,
 				 IB_POLL_WORKQUEUE);
 	if (err) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 4e602e40f623..08e1f7d82c95 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -18,7 +18,7 @@
 MODULE_DESCRIPTION("RDMA Transport Core");
 MODULE_LICENSE("GPL");
 
-struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
+struct rtrs_iu *rtrs_iu_alloc(u32 iu_num, size_t size, gfp_t gfp_mask,
 			      struct ib_device *dma_dev,
 			      enum dma_data_direction dir,
 			      void (*done)(struct ib_cq *cq, struct ib_wc *wc))
@@ -26,10 +26,10 @@ struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
 	struct rtrs_iu *ius, *iu;
 	int i;
 
-	ius = kcalloc(queue_size, sizeof(*ius), gfp_mask);
+	ius = kcalloc(iu_num, sizeof(*ius), gfp_mask);
 	if (!ius)
 		return NULL;
-	for (i = 0; i < queue_size; i++) {
+	for (i = 0; i < iu_num; i++) {
 		iu = &ius[i];
 		iu->direction = dir;
 		iu->buf = kzalloc(size, gfp_mask);
@@ -50,7 +50,7 @@ struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
 }
 EXPORT_SYMBOL_GPL(rtrs_iu_alloc);
 
-void rtrs_iu_free(struct rtrs_iu *ius, struct ib_device *ibdev, u32 queue_size)
+void rtrs_iu_free(struct rtrs_iu *ius, struct ib_device *ibdev, u32 queue_num)
 {
 	struct rtrs_iu *iu;
 	int i;
@@ -58,7 +58,7 @@ void rtrs_iu_free(struct rtrs_iu *ius, struct ib_device *ibdev, u32 queue_size)
 	if (!ius)
 		return;
 
-	for (i = 0; i < queue_size; i++) {
+	for (i = 0; i < queue_num; i++) {
 		iu = &ius[i];
 		ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, iu->direction);
 		kfree(iu->buf);
@@ -212,20 +212,20 @@ static void qp_event_handler(struct ib_event *ev, void *ctx)
 	}
 }
 
-static int create_cq(struct rtrs_con *con, int cq_vector, u16 cq_size,
+static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
 		     enum ib_poll_context poll_ctx)
 {
 	struct rdma_cm_id *cm_id = con->cm_id;
 	struct ib_cq *cq;
 
-	cq = ib_cq_pool_get(cm_id->device, cq_size, cq_vector, poll_ctx);
+	cq = ib_cq_pool_get(cm_id->device, nr_cqe, cq_vector, poll_ctx);
 	if (IS_ERR(cq)) {
 		rtrs_err(con->sess, "Creating completion queue failed, errno: %ld\n",
 			  PTR_ERR(cq));
 		return PTR_ERR(cq);
 	}
 	con->cq = cq;
-	con->cq_size = cq_size;
+	con->nr_cqe = nr_cqe;
 
 	return 0;
 }
@@ -260,20 +260,20 @@ static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
 }
 
 int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
-		       u32 max_send_sge, int cq_vector, int cq_size,
+		       u32 max_send_sge, int cq_vector, int nr_cqe,
 		       u32 max_send_wr, u32 max_recv_wr,
 		       enum ib_poll_context poll_ctx)
 {
 	int err;
 
-	err = create_cq(con, cq_vector, cq_size, poll_ctx);
+	err = create_cq(con, cq_vector, nr_cqe, poll_ctx);
 	if (err)
 		return err;
 
 	err = create_qp(con, sess->dev->ib_pd, max_send_wr, max_recv_wr,
 			max_send_sge);
 	if (err) {
-		ib_cq_pool_put(con->cq, con->cq_size);
+		ib_cq_pool_put(con->cq, con->nr_cqe);
 		con->cq = NULL;
 		return err;
 	}
@@ -290,7 +290,7 @@ void rtrs_cq_qp_destroy(struct rtrs_con *con)
 		con->qp = NULL;
 	}
 	if (con->cq) {
-		ib_cq_pool_put(con->cq, con->cq_size);
+		ib_cq_pool_put(con->cq, con->nr_cqe);
 		con->cq = NULL;
 	}
 }
-- 
2.25.1

