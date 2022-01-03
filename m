Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C211D48316D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 14:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiACNdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 08:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiACNds (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 08:33:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90877C061792
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jan 2022 05:33:47 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o6so136029410edc.4
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jan 2022 05:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zsgUPPvb6H+YFTfWSMCgo8eIaYf7eWSm4cXRiDpcLms=;
        b=I+Cm4ZoaAwYA8UU4p98/SNwHNG4BPMM3Tnh0SsZqqUD3oYQQO3e98kA6bA006J/ddW
         7u0CwgjH8dgEm9Utc/2wVtDc5a7DXfjOq2v/9WXzJrszDr4gcvSjN3BG0SVy9r6zdQwc
         wLTvEdUmbpmLnGtKK/z5Lnw2HajEU/x+4MB57fxsHtWIAp8RwFSM3p9/AheMzmJwhchV
         lhWIQObrm84QFha0ZLAXt+Q7TUd2UgJEpFLTkqP+QZV2uCDmzrKjRZ5gykN5ky+7wVzO
         FFI4CV+GVc86znSwAu/KP5aPWUfG+wafvifOOaPhJUpX/XdkGYljCaLGHEvrYuSSXtXo
         3g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zsgUPPvb6H+YFTfWSMCgo8eIaYf7eWSm4cXRiDpcLms=;
        b=uDsS0OQjdmAnzdqaJhzUZuUNfA779y6XnfiPHj0t9nVNlaX0SILjIZrseWs4rl+ZDJ
         +XfMgOJAIvpa6g22qxxpnqvjAMqoeHq25TnL4Sctx8p8P4MnY12mpFOHm2ElOubnNCQx
         nMCAk3VFz6NGUf+Vm+0qQc8n7jATegcg8HA5oZpgsq705Vgs6cz1A401ZFKWKaT/qyc7
         lnfleJZUvD3/D3x+8ZmTRCXze5E/7RDusuh4SQUnvx98zvAPi9o0qzknR2EdThAAfTDO
         PkVJl+nP6e/DFEgBYIbedheT7od3fgWcV1lgAB/FlgcrfXfkl8/34KJT7bf0QGqc36w0
         6rYw==
X-Gm-Message-State: AOAM533OtJZKRExcJokTN7JzV/QdOcQLfKcsVvn7IeKj6Kdake+eDTZO
        IFHcBhihhW6kEQ1fO5TOM1bVmZ5lnfFTjg==
X-Google-Smtp-Source: ABdhPJxEzSugWd2rlqOeahgxmInLYKc4+3pYxXDBPp5SRypHArIhCpCi4orBu//UZ0SRSfHLmysVpg==
X-Received: by 2002:a05:6402:60c:: with SMTP id n12mr45365279edv.17.1641216826016;
        Mon, 03 Jan 2022 05:33:46 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:456d:f000:5d30:da54:5b3e:3042])
        by smtp.gmail.com with ESMTPSA id ne2sm10702408ejc.108.2022.01.03.05.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 05:33:45 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Vaishali Thakkar <vaishali.thakkar@ionos.com>
Subject: [PATCHv2 for-next 4/5] RDMA/rtrs-srv: Rename rtrs_srv to rtrs_srv_sess
Date:   Mon,  3 Jan 2022 14:33:38 +0100
Message-Id: <20220103133339.9483-5-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103133339.9483-1-jinpu.wang@ionos.com>
References: <20220103133339.9483-1-jinpu.wang@ionos.com>
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
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 60 ++++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  4 +-
 drivers/infiniband/ulp/rtrs/rtrs.h           | 11 ++--
 6 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index abff9039cbea..05e59b831ffe 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -263,7 +263,7 @@ static void destroy_sess(struct rnbd_srv_session *srv_sess)
 	kfree(srv_sess);
 }
 
-static int create_sess(struct rtrs_srv *rtrs)
+static int create_sess(struct rtrs_srv_sess *rtrs)
 {
 	struct rnbd_srv_session *srv_sess;
 	char sessname[NAME_MAX];
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
index 643c9ccb4b44..8d61c9cc3f99 100644
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
 static bool exist_sessname(struct rtrs_srv_ctx *ctx,
 			   const char *sessname, const uuid_t *path_uuid)
 {
-	struct rtrs_srv *srv;
+	struct rtrs_srv_sess *srv;
 	struct rtrs_srv_path *srv_path;
 	bool found = false;
 
@@ -973,7 +973,7 @@ static int post_recv_io(struct rtrs_srv_con *con, size_t q_size)
 
 static int post_recv_sess(struct rtrs_srv_path *srv_path)
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
 
@@ -1295,7 +1295,8 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
  * @sessname:	Sessname buffer
  * @len:	Length of sessname buffer
  */
-int rtrs_srv_get_path_name(struct rtrs_srv *srv, char *sessname, size_t len)
+int rtrs_srv_get_path_name(struct rtrs_srv_sess *srv, char *sessname,
+			   size_t len)
 {
 	struct rtrs_srv_path *srv_path;
 	int err = -ENOTCONN;
@@ -1319,7 +1320,7 @@ EXPORT_SYMBOL(rtrs_srv_get_path_name);
  * rtrs_srv_get_queue_depth() - Get rtrs_srv qdepth.
  * @srv:	Session
  */
-int rtrs_srv_get_queue_depth(struct rtrs_srv *srv)
+int rtrs_srv_get_queue_depth(struct rtrs_srv_sess *srv)
 {
 	return srv->queue_depth;
 }
@@ -1345,12 +1346,13 @@ static int rtrs_srv_get_next_cq_vector(struct rtrs_srv_path *srv_path)
 
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
 
@@ -1364,11 +1366,11 @@ static void free_srv(struct rtrs_srv *srv)
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
@@ -1430,7 +1432,7 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 	return ERR_PTR(-ENOMEM);
 }
 
-static void put_srv(struct rtrs_srv *srv)
+static void put_srv(struct rtrs_srv_sess *srv)
 {
 	if (refcount_dec_and_test(&srv->refcount)) {
 		struct rtrs_srv_ctx *ctx = srv->ctx;
@@ -1444,7 +1446,7 @@ static void put_srv(struct rtrs_srv *srv)
 	}
 }
 
-static void __add_path_to_srv(struct rtrs_srv *srv,
+static void __add_path_to_srv(struct rtrs_srv_sess *srv,
 			      struct rtrs_srv_path *srv_path)
 {
 	list_add_tail(&srv_path->s.entry, &srv->paths_list);
@@ -1454,7 +1456,7 @@ static void __add_path_to_srv(struct rtrs_srv *srv,
 
 static void del_path_from_srv(struct rtrs_srv_path *srv_path)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 
 	if (WARN_ON(!srv))
 		return;
@@ -1490,7 +1492,7 @@ static int sockaddr_cmp(const struct sockaddr *a, const struct sockaddr *b)
 	}
 }
 
-static bool __is_path_w_addr_exists(struct rtrs_srv *srv,
+static bool __is_path_w_addr_exists(struct rtrs_srv_sess *srv,
 				    struct rdma_addr *addr)
 {
 	struct rtrs_srv_path *srv_path;
@@ -1573,7 +1575,7 @@ static void rtrs_srv_close_work(struct work_struct *work)
 static int rtrs_rdma_do_accept(struct rtrs_srv_path *srv_path,
 			       struct rdma_cm_id *cm_id)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_msg_conn_rsp msg;
 	struct rdma_conn_param param;
 	int err;
@@ -1622,7 +1624,7 @@ static int rtrs_rdma_do_reject(struct rdma_cm_id *cm_id, int errno)
 }
 
 static struct rtrs_srv_path *
-__find_path(struct rtrs_srv *srv, const uuid_t *sess_uuid)
+__find_path(struct rtrs_srv_sess *srv, const uuid_t *sess_uuid)
 {
 	struct rtrs_srv_path *srv_path;
 
@@ -1638,7 +1640,7 @@ static int create_con(struct rtrs_srv_path *srv_path,
 		      struct rdma_cm_id *cm_id,
 		      unsigned int cid)
 {
-	struct rtrs_srv *srv = srv_path->srv;
+	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_path *s = &srv_path->s;
 	struct rtrs_srv_con *con;
 
@@ -1725,7 +1727,7 @@ static int create_con(struct rtrs_srv_path *srv_path,
 	return err;
 }
 
-static struct rtrs_srv_path *__alloc_path(struct rtrs_srv *srv,
+static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
 					   struct rdma_cm_id *cm_id,
 					   unsigned int con_num,
 					   unsigned int recon_cnt,
@@ -1825,7 +1827,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 {
 	struct rtrs_srv_ctx *ctx = cm_id->context;
 	struct rtrs_srv_path *srv_path;
-	struct rtrs_srv *srv;
+	struct rtrs_srv_sess *srv;
 
 	u16 version, con_num, cid;
 	u16 recon_cnt;
@@ -2184,7 +2186,7 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
 }
 EXPORT_SYMBOL(rtrs_srv_open);
 
-static void close_paths(struct rtrs_srv *srv)
+static void close_paths(struct rtrs_srv_sess *srv)
 {
 	struct rtrs_srv_path *srv_path;
 
@@ -2196,7 +2198,7 @@ static void close_paths(struct rtrs_srv *srv)
 
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
index d5d037660cea..988688f93b62 100644
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
 
@@ -173,11 +173,12 @@ void rtrs_srv_close(struct rtrs_srv_ctx *ctx);
 
 bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int errno);
 
-void rtrs_srv_set_sess_priv(struct rtrs_srv *sess, void *priv);
+void rtrs_srv_set_sess_priv(struct rtrs_srv_sess *sess, void *priv);
 
-int rtrs_srv_get_path_name(struct rtrs_srv *sess, char *sessname, size_t len);
+int rtrs_srv_get_path_name(struct rtrs_srv_sess *sess, char *sessname,
+			   size_t len);
 
-int rtrs_srv_get_queue_depth(struct rtrs_srv *sess);
+int rtrs_srv_get_queue_depth(struct rtrs_srv_sess *sess);
 
 int rtrs_addr_to_sockaddr(const char *str, size_t len, u16 port,
 			  struct rtrs_addr *addr);
-- 
2.25.1

