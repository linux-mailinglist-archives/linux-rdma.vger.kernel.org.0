Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C524857EE
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 19:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbiAESHQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 13:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbiAESHP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 13:07:15 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60731C0611FD
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 10:07:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bm14so165324896edb.5
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jan 2022 10:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/YXm/WpamkAS3c/1BM8JBpv1iKg5djc7xkq8BuqqX4=;
        b=X96iiz3nCG440iAZvdSDUlzkHfcUm5A2+fi4JykBAdR0UBIhNpw6O9a10LMRvZWWAN
         xsWG7O88rjqEE8nLV9TkksLqWVzJZ2VMjhrRyz5KOYqbVzhjh8rRFjX2eAKZXx5MO9mE
         beRYQbcOYlhg7NV/nFm/rCxARhozvC5/kz7YNfVBwQUW5Sxeptt9p3zhU0RVBGIMyQKv
         ZLac8P1N0opXw4Ye1q5EuXl1/CjEJQiuKWAZ/QyscSqHEjnP8dohugtE93u9uBxTNfBR
         VTkG1Jz/u0YpN9Yijo8ropSRXRetEHniGA1xuULfPL/ns9dXpeTKJE0UDr29JWomk/Eo
         aC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/YXm/WpamkAS3c/1BM8JBpv1iKg5djc7xkq8BuqqX4=;
        b=IXuQBW7CvrSZ1GZbVF9P88CIav9rbWWpGu2PhmoLC6l7qALqa2+gUK+bj1NODJvVSW
         /M8kWrxHIGczuCSPF5t5vJAizoInNBBvCWVPgAzCmBUmwrVW31mILxUYygyscrLEk0qO
         w6IDQEvOCahQ93HePgfNVy7WM7mxqOyg6b8rVbVKTfmvNyHFnOXO2Kgs5vihGgcQrP/D
         SIOv5IfK0gotIDbIHs6oD18GJso+7amVzg6zONfDYforgjdocyfb/6SVHn3OCTLJiWQh
         dv1yfWRznaLW6uwqbVtJbSmuO6JPY60QwtRst8MV5JDO9s82DYDXzJAVSsJCJsBS3Gtu
         5aKw==
X-Gm-Message-State: AOAM530K7fbS3M+OtWPxoF+OlZJjJKK1JDlsR2N2LZ1auc6q/x9TjkRm
        PnRjne+jz6KUbEOsGlvMaHNJb8xVCPPT/g==
X-Google-Smtp-Source: ABdhPJy4xzvOTwyn2+pQAlcYYePhXbw94ZThE/eRbEnlDUD098/7sUdJCQXOzZF6lXZeH5WECvsp7w==
X-Received: by 2002:a05:6402:2c4:: with SMTP id b4mr53459305edx.364.1641406033694;
        Wed, 05 Jan 2022 10:07:13 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4592:200:545c:cb34:8a20:aae1])
        by smtp.gmail.com with ESMTPSA id eg12sm15970910edb.25.2022.01.05.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 10:07:13 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        vaishali.thakkar@ionos.com, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com
Subject: [PATCHv3 for-next 4/5] RDMA/rtrs-srv: Rename rtrs_srv to rtrs_srv_sess
Date:   Wed,  5 Jan 2022 19:07:07 +0100
Message-Id: <20220105180708.7774-5-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105180708.7774-1-jinpu.wang@ionos.com>
References: <20220105180708.7774-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Vaishali Thakkar <vaishali.thakkar@ionos.com>

Structure rtrs_srv is used for sessions so in order
to avoid confusions rename it to rtrs_srv_sess.

All changes were done with the help of following
Coccinelle script:

@@
@@
struct
- rtrs_srv
+ rtrs_srv_sess

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-srv.c                |  4 +-
 drivers/block/rnbd/rnbd-srv.h                |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  6 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 59 ++++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  4 +-
 drivers/infiniband/ulp/rtrs/rtrs.h           | 10 ++--
 6 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 1ba1a93a6fe7..1ee808fc600c 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -263,7 +263,7 @@ static void destroy_sess(struct rnbd_srv_session *srv_sess)
 	kfree(srv_sess);
 }
 
-static int create_sess(struct rtrs_srv *rtrs)
+static int create_sess(struct rtrs_srv_sess *rtrs)
 {
 	struct rnbd_srv_session *srv_sess;
 	char pathname[NAME_MAX];
@@ -305,7 +305,7 @@ static int create_sess(struct rtrs_srv *rtrs)
 	return 0;
 }
 
-static int rnbd_srv_link_ev(struct rtrs_srv *rtrs,
+static int rnbd_srv_link_ev(struct rtrs_srv_sess *rtrs,
 			     enum rtrs_srv_link_ev ev, void *priv)
 {
 	struct rnbd_srv_session *srv_sess = priv;
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index 98ddc31eb408..e5604bce123a 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -20,7 +20,7 @@
 struct rnbd_srv_session {
 	/* Entry inside global sess_list */
 	struct list_head        list;
-	struct rtrs_srv		*rtrs;
+	struct rtrs_srv_sess	*rtrs;
 	char			sessname[NAME_MAX];
 	int			queue_depth;
 	struct bio_set		sess_bio_set;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 628ef20ebf0c..b94ae12c2795 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -154,7 +154,7 @@ static const struct attribute_group rtrs_srv_stats_attr_group = {
 
 static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_path *srv_path)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	int err = 0;
 
 	mutex_lock(&srv->paths_mutex);
@@ -199,7 +199,7 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_path *srv_pat
 static void
 rtrs_srv_destroy_once_sysfs_root_folders(struct rtrs_srv_path *srv_path)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 
 	mutex_lock(&srv->paths_mutex);
 	if (!--srv->dev_ref) {
@@ -258,7 +258,7 @@ static int rtrs_srv_create_stats_files(struct rtrs_srv_path *srv_path)
 
 int rtrs_srv_create_path_files(struct rtrs_srv_path *srv_path)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_path *s = &srv_path->s;
 	char str[NAME_MAX];
 	int err;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 1ca31b919e98..24024bce2566 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -108,7 +108,7 @@ static void free_id(struct rtrs_srv_op *id)
 
 static void rtrs_srv_free_ops_ids(struct rtrs_srv_path *srv_path)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	int i;
 
 	if (srv_path->ops_ids) {
@@ -137,7 +137,7 @@ static inline void rtrs_srv_inflight_ref_release(struct percpu_ref *ref)
 
 static int rtrs_srv_alloc_ops_ids(struct rtrs_srv_path *srv_path)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_srv_op *id;
 	int i, ret;
 
@@ -541,7 +541,7 @@ EXPORT_SYMBOL(rtrs_srv_resp_rdma);
  * @srv:	Session pointer
  * @priv:	The private pointer that is associated with the session.
  */
-void rtrs_srv_set_sess_priv(struct rtrs_srv *srv, void *priv)
+void rtrs_srv_set_sess_priv(struct rtrs_srv_sess *srv, void *priv)
 {
 	srv->priv = priv;
 }
@@ -566,7 +566,7 @@ static void unmap_cont_bufs(struct rtrs_srv_path *srv_path)
 
 static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_path *ss = &srv_path->s;
 	int i, mri, err, mrs_num;
 	unsigned int chunk_bits;
@@ -723,7 +723,7 @@ static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 
 static void rtrs_srv_path_up(struct rtrs_srv_path *srv_path)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_srv_ctx *ctx = srv->ctx;
 	int up;
 
@@ -739,7 +739,7 @@ static void rtrs_srv_path_up(struct rtrs_srv_path *srv_path)
 
 static void rtrs_srv_path_down(struct rtrs_srv_path *srv_path)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_srv_ctx *ctx = srv->ctx;
 
 	if (!srv_path->established)
@@ -756,7 +756,7 @@ static void rtrs_srv_path_down(struct rtrs_srv_path *srv_path)
 static bool exist_pathname(struct rtrs_srv_ctx *ctx,
 			   const char *pathname, const uuid_t *path_uuid)
 {
-	struct rtrs_srv *srv;
+	struct rtrs_srv_sess *srv;
 	struct rtrs_srv_path *srv_path;
 	bool found = false;
 
@@ -973,7 +973,7 @@ static int post_recv_io(struct rtrs_srv_con *con, size_t q_size)
 
 static int post_recv_path(struct rtrs_srv_path *srv_path)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_path *s = &srv_path->s;
 	size_t q_size;
 	int err, cid;
@@ -1000,7 +1000,7 @@ static void process_read(struct rtrs_srv_con *con,
 {
 	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_path *srv_path = to_srv_path(s);
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_srv_ctx *ctx = srv->ctx;
 	struct rtrs_srv_op *id;
 
@@ -1058,7 +1058,7 @@ static void process_write(struct rtrs_srv_con *con,
 {
 	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_path *srv_path = to_srv_path(s);
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_srv_ctx *ctx = srv->ctx;
 	struct rtrs_srv_op *id;
 
@@ -1145,7 +1145,7 @@ static void rtrs_srv_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
 	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_path *srv_path = to_srv_path(s);
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	u32 msg_id, off;
 	void *data;
 
@@ -1202,7 +1202,7 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
 	struct rtrs_path *s = con->c.path;
 	struct rtrs_srv_path *srv_path = to_srv_path(s);
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	u32 imm_type, imm_payload;
 	int err;
 
@@ -1295,7 +1295,7 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
  * @pathname:	Pathname buffer
  * @len:	Length of sessname buffer
  */
-int rtrs_srv_get_path_name(struct rtrs_srv *srv, char *pathname,
+int rtrs_srv_get_path_name(struct rtrs_srv_sess *srv, char *pathname,
 			   size_t len)
 {
 	struct rtrs_srv_path *srv_path;
@@ -1320,7 +1320,7 @@ EXPORT_SYMBOL(rtrs_srv_get_path_name);
  * rtrs_srv_get_queue_depth() - Get rtrs_srv qdepth.
  * @srv:	Session
  */
-int rtrs_srv_get_queue_depth(struct rtrs_srv *srv)
+int rtrs_srv_get_queue_depth(struct rtrs_srv_sess *srv)
 {
 	return srv->queue_depth;
 }
@@ -1346,12 +1346,13 @@ static int rtrs_srv_get_next_cq_vector(struct rtrs_srv_path *srv_path)
 
 static void rtrs_srv_dev_release(struct device *dev)
 {
-	struct rtrs_srv *srv = container_of(dev, struct rtrs_srv, dev);
+	struct rtrs_srv_sess *srv = container_of(dev, struct rtrs_srv_sess,
+						 dev);
 
 	kfree(srv);
 }
 
-static void free_srv(struct rtrs_srv *srv)
+static void free_srv(struct rtrs_srv_sess *srv)
 {
 	int i;
 
@@ -1365,11 +1366,11 @@ static void free_srv(struct rtrs_srv *srv)
 	put_device(&srv->dev);
 }
 
-static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
+static struct rtrs_srv_sess *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 					  const uuid_t *paths_uuid,
 					  bool first_conn)
 {
-	struct rtrs_srv *srv;
+	struct rtrs_srv_sess *srv;
 	int i;
 
 	mutex_lock(&ctx->srv_mutex);
@@ -1431,7 +1432,7 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 	return ERR_PTR(-ENOMEM);
 }
 
-static void put_srv(struct rtrs_srv *srv)
+static void put_srv(struct rtrs_srv_sess *srv)
 {
 	if (refcount_dec_and_test(&srv->refcount)) {
 		struct rtrs_srv_ctx *ctx = srv->ctx;
@@ -1445,7 +1446,7 @@ static void put_srv(struct rtrs_srv *srv)
 	}
 }
 
-static void __add_path_to_srv(struct rtrs_srv *srv,
+static void __add_path_to_srv(struct rtrs_srv_sess *srv,
 			      struct rtrs_srv_path *srv_path)
 {
 	list_add_tail(&srv_path->s.entry, &srv->paths_list);
@@ -1455,7 +1456,7 @@ static void __add_path_to_srv(struct rtrs_srv *srv,
 
 static void del_path_from_srv(struct rtrs_srv_path *srv_path)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 
 	if (WARN_ON(!srv))
 		return;
@@ -1491,7 +1492,7 @@ static int sockaddr_cmp(const struct sockaddr *a, const struct sockaddr *b)
 	}
 }
 
-static bool __is_path_w_addr_exists(struct rtrs_srv *srv,
+static bool __is_path_w_addr_exists(struct rtrs_srv_sess *srv,
 				    struct rdma_addr *addr)
 {
 	struct rtrs_srv_path *srv_path;
@@ -1574,7 +1575,7 @@ static void rtrs_srv_close_work(struct work_struct *work)
 static int rtrs_rdma_do_accept(struct rtrs_srv_path *srv_path,
 			       struct rdma_cm_id *cm_id)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_msg_conn_rsp msg;
 	struct rdma_conn_param param;
 	int err;
@@ -1623,7 +1624,7 @@ static int rtrs_rdma_do_reject(struct rdma_cm_id *cm_id, int errno)
 }
 
 static struct rtrs_srv_path *
-__find_path(struct rtrs_srv *srv, const uuid_t *sess_uuid)
+__find_path(struct rtrs_srv_sess *srv, const uuid_t *sess_uuid)
 {
 	struct rtrs_srv_path *srv_path;
 
@@ -1639,7 +1640,7 @@ static int create_con(struct rtrs_srv_path *srv_path,
 		      struct rdma_cm_id *cm_id,
 		      unsigned int cid)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_path *s = &srv_path->s;
 	struct rtrs_srv_con *con;
 
@@ -1726,7 +1727,7 @@ static int create_con(struct rtrs_srv_path *srv_path,
 	return err;
 }
 
-static struct rtrs_srv_path *__alloc_path(struct rtrs_srv *srv,
+static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
 					   struct rdma_cm_id *cm_id,
 					   unsigned int con_num,
 					   unsigned int recon_cnt,
@@ -1826,7 +1827,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 {
 	struct rtrs_srv_ctx *ctx = cm_id->context;
 	struct rtrs_srv_path *srv_path;
-	struct rtrs_srv *srv;
+	struct rtrs_srv_sess *srv;
 
 	u16 version, con_num, cid;
 	u16 recon_cnt;
@@ -2185,7 +2186,7 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
 }
 EXPORT_SYMBOL(rtrs_srv_open);
 
-static void close_paths(struct rtrs_srv *srv)
+static void close_paths(struct rtrs_srv_sess *srv)
 {
 	struct rtrs_srv_path *srv_path;
 
@@ -2197,7 +2198,7 @@ static void close_paths(struct rtrs_srv *srv)
 
 static void close_ctx(struct rtrs_srv_ctx *ctx)
 {
-	struct rtrs_srv *srv;
+	struct rtrs_srv_sess *srv;
 
 	mutex_lock(&ctx->srv_mutex);
 	list_for_each_entry(srv, &ctx->srv_list, ctx_list)
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 6119e6708080..6292e87f6afd 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -73,7 +73,7 @@ struct rtrs_srv_mr {
 
 struct rtrs_srv_path {
 	struct rtrs_path	s;
-	struct rtrs_srv	*srv;
+	struct rtrs_srv_sess	*srv;
 	struct work_struct	close_work;
 	enum rtrs_srv_state	state;
 	spinlock_t		state_lock;
@@ -90,7 +90,7 @@ struct rtrs_srv_path {
 	struct rtrs_srv_stats	*stats;
 };
 
-struct rtrs_srv {
+struct rtrs_srv_sess {
 	struct list_head	paths_list;
 	int			paths_up;
 	struct mutex		paths_ev_mutex;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index c529b6d63c9a..eeb238f3012e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -15,7 +15,7 @@
 struct rtrs_permit;
 struct rtrs_clt;
 struct rtrs_srv_ctx;
-struct rtrs_srv;
+struct rtrs_srv_sess;
 struct rtrs_srv_op;
 
 /*
@@ -163,7 +163,7 @@ struct rtrs_srv_ops {
 	 *	@priv:		Private data from user if previously set with
 	 *			rtrs_srv_set_sess_priv()
 	 */
-	int (*link_ev)(struct rtrs_srv *sess, enum rtrs_srv_link_ev ev,
+	int (*link_ev)(struct rtrs_srv_sess *sess, enum rtrs_srv_link_ev ev,
 		       void *priv);
 };
 
@@ -173,12 +173,12 @@ void rtrs_srv_close(struct rtrs_srv_ctx *ctx);
 
 bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int errno);
 
-void rtrs_srv_set_sess_priv(struct rtrs_srv *sess, void *priv);
+void rtrs_srv_set_sess_priv(struct rtrs_srv_sess *sess, void *priv);
 
-int rtrs_srv_get_path_name(struct rtrs_srv *sess, char *pathname,
+int rtrs_srv_get_path_name(struct rtrs_srv_sess *sess, char *pathname,
 			   size_t len);
 
-int rtrs_srv_get_queue_depth(struct rtrs_srv *sess);
+int rtrs_srv_get_queue_depth(struct rtrs_srv_sess *sess);
 
 int rtrs_addr_to_sockaddr(const char *str, size_t len, u16 port,
 			  struct rtrs_addr *addr);
-- 
2.25.1

