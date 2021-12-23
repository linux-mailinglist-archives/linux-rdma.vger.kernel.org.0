Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241A847E1A3
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Dec 2021 11:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbhLWKmm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 05:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243258AbhLWKmi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Dec 2021 05:42:38 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879B5C061756
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 02:42:33 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y13so19625129edd.13
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 02:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9zzV9neopjIOxC859BdZWewdMkDgMUs5z1IMByLhjU=;
        b=eWES61Iuhssmbor4jhC++N7Zj0O3Nv1sFjUql7diT8jQKFbTln+rA3E51hEwkJlRnh
         qML80FGYbAGk74rPoEEjznRJ/p1gjqDxVZ8cB/ancySuEl/Ea2Cd7bZNQAFSg1gafr63
         3b1tk6mh7m4Nb724Z5vSrYxbbK3vTiQqPKIAqqHgAGyI02wAATMSyznOkbvKjOkdbw7w
         F/geAK78fBPil5Ckxvw6X67Vpke+F8Z2DdT/uQu1hI3jYKlDeqD9xtY9SzCSigjpMmTI
         aYE+8nin0PSqfQsE8KGveSL+fEh6HWnvzI4lyhoG/t1SyxQfz605Dun1uTUUXuE97l01
         0Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9zzV9neopjIOxC859BdZWewdMkDgMUs5z1IMByLhjU=;
        b=ciIxpGqZmJxhYdRmDiLJ4yScMQgyo7XxYMeIb9Q4o9eWdf6T1PHbK9IikWm1YtnJ+w
         geF1XMfZut6oB8ezdhXhAfnEFGbaETp3EITFUBgOdJODeQE1soh6kL1dYy6o8JOJexgc
         cXkOs93AyFA9OVe3P+WdS7yGUo7KzhOVHkI0VAstJFQGbhN2lUzcZL3kmZ/ECQLSPav6
         R/ybFK+GjKamgsfLL+pbjwhJM3hmNBSsWTAQYdmw8CCcxxrB0SS1PRMemeVIparjhXwN
         KyzCbgCIzv8ELVjusbl9D2tC+DtkO3zqW4N0spMTzR5fCkYmZ2bxv5bVhDamZSMO9MFe
         lslA==
X-Gm-Message-State: AOAM5339cIQ9jsgGg44p4LhMD76onKDBqWHTjjOwomClhCwFhAsgxhiY
        uJK+FPLSvRyGb8XG57H4GCrhNOCCGWGDOA==
X-Google-Smtp-Source: ABdhPJx/xmkDltWhGxiOq0ZJm5BLTszabo3xlyIXdwINXCCcESWpp+RTirKQdAWxkgo8AmseVwHVZw==
X-Received: by 2002:a17:907:162c:: with SMTP id hb44mr1447009ejc.657.1640256151796;
        Thu, 23 Dec 2021 02:42:31 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4536:ce00:c42a:2c1b:a58b:ae52])
        by smtp.gmail.com with ESMTPSA id ho14sm1627224ejc.73.2021.12.23.02.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 02:42:31 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Vaishali Thakkar <vaishali.thakkar@ionos.com>
Subject: [PATCH for-next 2/7] RDMA/rtrs-srv: Rename rtrs_sess to rtrs_path
Date:   Thu, 23 Dec 2021 11:42:24 +0100
Message-Id: <20211223104229.23053-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223104229.23053-1-jinpu.wang@ionos.com>
References: <20211223104229.23053-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Vaishali Thakkar <vaishali.thakkar@ionos.com>

rtrs_sess has been renamed to rtrs_path to improve
the readability of a code. This patch does the
follow up changes in the server side module.

Coccinelle scripts were used to handle most of the
transformations and remaining cases were handled
manually.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  6 +--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 46 ++++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  2 +-
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 9c43ce5ba1c1..e9fa67365b2b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -37,7 +37,7 @@ static ssize_t rtrs_srv_disconnect_store(struct kobject *kobj,
 					  const char *buf, size_t count)
 {
 	struct rtrs_srv_sess *sess;
-	struct rtrs_sess *s;
+	struct rtrs_path *s;
 	char str[MAXHOSTNAMELEN];
 
 	sess = container_of(kobj, struct rtrs_srv_sess, kobj);
@@ -230,7 +230,7 @@ static struct kobj_type ktype_stats = {
 static int rtrs_srv_create_stats_files(struct rtrs_srv_sess *sess)
 {
 	int err;
-	struct rtrs_sess *s = &sess->s;
+	struct rtrs_path *s = &sess->s;
 
 	err = kobject_init_and_add(&sess->stats->kobj_stats, &ktype_stats,
 				   &sess->kobj, "stats");
@@ -258,7 +258,7 @@ static int rtrs_srv_create_stats_files(struct rtrs_srv_sess *sess)
 int rtrs_srv_create_sess_files(struct rtrs_srv_sess *sess)
 {
 	struct rtrs_srv *srv = sess->srv;
-	struct rtrs_sess *s = &sess->s;
+	struct rtrs_path *s = &sess->s;
 	char str[NAME_MAX];
 	int err;
 	struct rtrs_addr path = {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 7df71f8cf149..de4f214233b6 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -62,7 +62,7 @@ static inline struct rtrs_srv_con *to_srv_con(struct rtrs_con *c)
 	return container_of(c, struct rtrs_srv_con, c);
 }
 
-static inline struct rtrs_srv_sess *to_srv_sess(struct rtrs_sess *s)
+static inline struct rtrs_srv_sess *to_srv_sess(struct rtrs_path *s)
 {
 	return container_of(s, struct rtrs_srv_sess, s);
 }
@@ -180,7 +180,7 @@ static inline void rtrs_srv_put_ops_ids(struct rtrs_srv_sess *sess)
 static void rtrs_srv_reg_mr_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 
 	if (wc->status != IB_WC_SUCCESS) {
@@ -197,7 +197,7 @@ static struct ib_cqe local_reg_cqe = {
 
 static int rdma_write_sg(struct rtrs_srv_op *id)
 {
-	struct rtrs_sess *s = id->con->c.sess;
+	struct rtrs_path *s = id->con->c.path;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	dma_addr_t dma_addr = sess->dma_addr[id->msg_id];
 	struct rtrs_srv_mr *srv_mr;
@@ -341,7 +341,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 			    int errno)
 {
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct ib_send_wr inv_wr, *wr = NULL;
 	struct ib_rdma_wr imm_wr;
@@ -482,14 +482,14 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 {
 	struct rtrs_srv_sess *sess;
 	struct rtrs_srv_con *con;
-	struct rtrs_sess *s;
+	struct rtrs_path *s;
 	int err;
 
 	if (WARN_ON(!id))
 		return true;
 
 	con = id->con;
-	s = con->c.sess;
+	s = con->c.path;
 	sess = to_srv_sess(s);
 
 	id->status = status;
@@ -564,7 +564,7 @@ static void unmap_cont_bufs(struct rtrs_srv_sess *sess)
 static int map_cont_bufs(struct rtrs_srv_sess *sess)
 {
 	struct rtrs_srv *srv = sess->srv;
-	struct rtrs_sess *ss = &sess->s;
+	struct rtrs_path *ss = &sess->s;
 	int i, mri, err, mrs_num;
 	unsigned int chunk_bits;
 	int chunks_per_mr = 1;
@@ -677,7 +677,7 @@ static int map_cont_bufs(struct rtrs_srv_sess *sess)
 
 static void rtrs_srv_hb_err_handler(struct rtrs_con *c)
 {
-	close_sess(to_srv_sess(c->sess));
+	close_sess(to_srv_sess(c->path));
 }
 
 static void rtrs_srv_init_hb(struct rtrs_srv_sess *sess)
@@ -702,7 +702,7 @@ static void rtrs_srv_stop_hb(struct rtrs_srv_sess *sess)
 static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct rtrs_iu *iu;
 
@@ -788,7 +788,7 @@ static int rtrs_rdma_do_reject(struct rdma_cm_id *cm_id, int errno);
 static int process_info_req(struct rtrs_srv_con *con,
 			    struct rtrs_msg_info_req *msg)
 {
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct ib_send_wr *reg_wr = NULL;
 	struct rtrs_msg_info_rsp *rsp;
@@ -889,7 +889,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct rtrs_msg_info_req *msg;
 	struct rtrs_iu *iu;
@@ -932,7 +932,7 @@ static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 
 static int post_recv_info_req(struct rtrs_srv_con *con)
 {
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct rtrs_iu *rx_iu;
 	int err;
@@ -969,7 +969,7 @@ static int post_recv_io(struct rtrs_srv_con *con, size_t q_size)
 static int post_recv_sess(struct rtrs_srv_sess *sess)
 {
 	struct rtrs_srv *srv = sess->srv;
-	struct rtrs_sess *s = &sess->s;
+	struct rtrs_path *s = &sess->s;
 	size_t q_size;
 	int err, cid;
 
@@ -993,7 +993,7 @@ static void process_read(struct rtrs_srv_con *con,
 			 struct rtrs_msg_rdma_read *msg,
 			 u32 buf_id, u32 off)
 {
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct rtrs_srv *srv = sess->srv;
 	struct rtrs_srv_ctx *ctx = srv->ctx;
@@ -1051,7 +1051,7 @@ static void process_write(struct rtrs_srv_con *con,
 			  struct rtrs_msg_rdma_write *req,
 			  u32 buf_id, u32 off)
 {
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct rtrs_srv *srv = sess->srv;
 	struct rtrs_srv_ctx *ctx = srv->ctx;
@@ -1102,7 +1102,7 @@ static void process_write(struct rtrs_srv_con *con,
 static void process_io_req(struct rtrs_srv_con *con, void *msg,
 			   u32 id, u32 off)
 {
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct rtrs_msg_rdma_hdr *hdr;
 	unsigned int type;
@@ -1137,7 +1137,7 @@ static void rtrs_srv_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_srv_mr *mr =
 		container_of(wc->wr_cqe, typeof(*mr), inv_cqe);
 	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct rtrs_srv *srv = sess->srv;
 	u32 msg_id, off;
@@ -1194,7 +1194,7 @@ static void rtrs_rdma_process_wr_wait_list(struct rtrs_srv_con *con)
 static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
-	struct rtrs_sess *s = con->c.sess;
+	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	struct rtrs_srv *srv = sess->srv;
 	u32 imm_type, imm_payload;
@@ -1633,7 +1633,7 @@ static int create_con(struct rtrs_srv_sess *sess,
 		      unsigned int cid)
 {
 	struct rtrs_srv *srv = sess->srv;
-	struct rtrs_sess *s = &sess->s;
+	struct rtrs_path *s = &sess->s;
 	struct rtrs_srv_con *con;
 
 	u32 cq_num, max_send_wr, max_recv_wr, wr_limit;
@@ -1648,7 +1648,7 @@ static int create_con(struct rtrs_srv_sess *sess,
 	spin_lock_init(&con->rsp_wr_wait_lock);
 	INIT_LIST_HEAD(&con->rsp_wr_wait_list);
 	con->c.cm_id = cm_id;
-	con->c.sess = &sess->s;
+	con->c.path = &sess->s;
 	con->c.cid = cid;
 	atomic_set(&con->c.wr_cnt, 1);
 	wr_limit = sess->s.dev->ib_dev->attrs.max_qp_wr;
@@ -1859,7 +1859,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	mutex_lock(&srv->paths_mutex);
 	sess = __find_sess(srv, &msg->sess_uuid);
 	if (sess) {
-		struct rtrs_sess *s = &sess->s;
+		struct rtrs_path *s = &sess->s;
 
 		/* Session already holds a reference */
 		put_srv(srv);
@@ -1938,12 +1938,12 @@ static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
 				     struct rdma_cm_event *ev)
 {
 	struct rtrs_srv_sess *sess = NULL;
-	struct rtrs_sess *s = NULL;
+	struct rtrs_path *s = NULL;
 
 	if (ev->event != RDMA_CM_EVENT_CONNECT_REQUEST) {
 		struct rtrs_con *c = cm_id->context;
 
-		s = c->sess;
+		s = c->path;
 		sess = to_srv_sess(s);
 	}
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 7d403c12faf3..c2c08ec8d9e8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -72,7 +72,7 @@ struct rtrs_srv_mr {
 };
 
 struct rtrs_srv_sess {
-	struct rtrs_sess	s;
+	struct rtrs_path	s;
 	struct rtrs_srv	*srv;
 	struct work_struct	close_work;
 	enum rtrs_srv_state	state;
-- 
2.25.1

