Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E262A38281C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhEQJVD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbhEQJUn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE44C06174A
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id s22so7909925ejv.12
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkpxEEkKKpPlgc4wb6EvnsvOqCNLQTpTjL7yczJzulk=;
        b=UmRF0cBo0igX1FkJ+GCZEHNtftudl+Dm7NumDbrcIEpkPAJaTnS+Y+jkSDPPfRw3dx
         UYpzwCCTcNvHgif4ENubqYXi5vGC3o12TRgxqxCVKwb0GkHizX90rGCL5P33jr7wC6Dw
         NtM/DA0B5uEbXLpcOvWMlU9oPnXEh+K9zXbsHqL/jkAoePtWFLZ4oGc3cXxUU/K2tCSe
         NqSjsKg01jbQ8YnmVpfpK/kGD1buFps0Oyb6l4t0XFWyFfhuEXm7BZ3Cura6fJ89inc4
         wRmdrHaBin96Q0TBFCpBFHdsf8rzyxH3VLURsOwzImyXRYfnAlPpHNGuNiitcu+ItYLE
         n8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkpxEEkKKpPlgc4wb6EvnsvOqCNLQTpTjL7yczJzulk=;
        b=QKUlKQjQEUW1SL+zCIluericeQ0bgnjN7es6s6z1CXTnreLgMaE/znVOcMyBry0BEj
         JTs0PwzbAxhNonwWCVLpcA2lBlyWVg5Ef9+6KZYaoiKgKa/S4HD3VfvW2njXUyUuuwlk
         sofXMHzjS8dRHtwb2ZXcJiu2N7Y3U/QHLa+SdG5nHdSd1qdGp87THrnIqNhQsTmR+RoI
         6i/2xIvDyg2o87dwtOjj6AUUq1k8cFmg4T17Hc+F6p5kPuIt/BtMtTy3vb2mdQHDxXpA
         oFrFN3Uk/hEzvboSRtFaQgzYHVwA4dxL94w9WnzhS280Uh+cs/eiAIznPxPGJ9OzNzlM
         wo6Q==
X-Gm-Message-State: AOAM533NtB2H6YnBFzdA8PyQe47dZjKxBa5Sjh0xt9JcjDhU0VpqNxe4
        BzOv6mJ/HZSXbz3XTqb13XdB1e+c51qJWQ==
X-Google-Smtp-Source: ABdhPJx8exkzzUqxB27ag+XaYgbUrF5lz98/DsSg0nu/wRLpW4egq5fRLA9GhWqFaVdVzBkwnwXakg==
X-Received: by 2002:a17:906:a3c9:: with SMTP id ca9mr2461496ejb.553.1621243165208;
        Mon, 17 May 2021 02:19:25 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:25 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 13/19] RDMA/rtrs-srv: Replace atomic_t with percpu_ref for ids_inflight
Date:   Mon, 17 May 2021 11:18:37 +0200
Message-Id: <20210517091844.260810-14-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

ids_inflight is used to track the inflight IOs. But the use of atomic_t
variable can cause performance drops and can also become a performance
bottleneck.

This commit replaces the use of atomic_t with a percpu_ref structure. The
advantage it offers is, it doesn't check if the reference has fallen to 0,
until the user explicitly signals it to; and that is done by the
percpu_ref_kill() function call. After that, the percpu_ref structure
behaves like an atomic_t and for every put call, checks whether the
reference has fallen to 0 or not.

rtrs_srv_stats_rdma_to_str shows the count of ids_inflight as 0
for user-mode tools not to be confused.

Fixes: 9cb837480424e ("RDMA/rtrs: server: main functionality")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 12 +++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 43 +++++++++++++-------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  4 +-
 3 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
index e102b1368d0c..df1d7d6b1884 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
@@ -27,12 +27,10 @@ ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
 				    char *page, size_t len)
 {
 	struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
-	struct rtrs_srv_sess *sess = stats->sess;
 
-	return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
-			 (s64)atomic64_read(&r->dir[READ].cnt),
-			 (s64)atomic64_read(&r->dir[READ].size_total),
-			 (s64)atomic64_read(&r->dir[WRITE].cnt),
-			 (s64)atomic64_read(&r->dir[WRITE].size_total),
-			 atomic_read(&sess->ids_inflight));
+	return sysfs_emit(page, "%lld %lld %lld %lldn\n",
+			  (s64)atomic64_read(&r->dir[READ].cnt),
+			  (s64)atomic64_read(&r->dir[READ].size_total),
+			  (s64)atomic64_read(&r->dir[WRITE].cnt),
+			  (s64)atomic64_read(&r->dir[WRITE].size_total));
 }
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 54a29285240d..f66f2be9f519 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -111,7 +111,6 @@ static void rtrs_srv_free_ops_ids(struct rtrs_srv_sess *sess)
 	struct rtrs_srv *srv = sess->srv;
 	int i;
 
-	WARN_ON(atomic_read(&sess->ids_inflight));
 	if (sess->ops_ids) {
 		for (i = 0; i < srv->queue_depth; i++)
 			free_id(sess->ops_ids[i]);
@@ -126,11 +125,19 @@ static struct ib_cqe io_comp_cqe = {
 	.done = rtrs_srv_rdma_done
 };
 
+static inline void rtrs_srv_inflight_ref_release(struct percpu_ref *ref)
+{
+	struct rtrs_srv_sess *sess = container_of(ref, struct rtrs_srv_sess, ids_inflight_ref);
+
+	percpu_ref_exit(&sess->ids_inflight_ref);
+	complete(&sess->complete_done);
+}
+
 static int rtrs_srv_alloc_ops_ids(struct rtrs_srv_sess *sess)
 {
 	struct rtrs_srv *srv = sess->srv;
 	struct rtrs_srv_op *id;
-	int i;
+	int i, ret;
 
 	sess->ops_ids = kcalloc(srv->queue_depth, sizeof(*sess->ops_ids),
 				GFP_KERNEL);
@@ -144,8 +151,14 @@ static int rtrs_srv_alloc_ops_ids(struct rtrs_srv_sess *sess)
 
 		sess->ops_ids[i] = id;
 	}
-	init_waitqueue_head(&sess->ids_waitq);
-	atomic_set(&sess->ids_inflight, 0);
+
+	ret = percpu_ref_init(&sess->ids_inflight_ref,
+			      rtrs_srv_inflight_ref_release, 0, GFP_KERNEL);
+	if (ret) {
+		pr_err("Percpu reference init failed\n");
+		goto err;
+	}
+	init_completion(&sess->complete_done);
 
 	return 0;
 
@@ -156,21 +169,14 @@ static int rtrs_srv_alloc_ops_ids(struct rtrs_srv_sess *sess)
 
 static inline void rtrs_srv_get_ops_ids(struct rtrs_srv_sess *sess)
 {
-	atomic_inc(&sess->ids_inflight);
+	percpu_ref_get(&sess->ids_inflight_ref);
 }
 
 static inline void rtrs_srv_put_ops_ids(struct rtrs_srv_sess *sess)
 {
-	if (atomic_dec_and_test(&sess->ids_inflight))
-		wake_up(&sess->ids_waitq);
+	percpu_ref_put(&sess->ids_inflight_ref);
 }
 
-static void rtrs_srv_wait_ops_ids(struct rtrs_srv_sess *sess)
-{
-	wait_event(sess->ids_waitq, !atomic_read(&sess->ids_inflight));
-}
-
-
 static void rtrs_srv_reg_mr_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
@@ -1479,8 +1485,15 @@ static void rtrs_srv_close_work(struct work_struct *work)
 		rdma_disconnect(con->c.cm_id);
 		ib_drain_qp(con->c.qp);
 	}
-	/* Wait for all inflights */
-	rtrs_srv_wait_ops_ids(sess);
+
+	/*
+	 * Degrade ref count to the usual model with a single shared
+	 * atomic_t counter
+	 */
+	percpu_ref_kill(&sess->ids_inflight_ref);
+
+	/* Wait for all completion */
+	wait_for_completion(&sess->complete_done);
 
 	/* Notify upper layer if we are the last path */
 	rtrs_srv_sess_down(sess);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 9543ae19996c..f8da2e3f0bda 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -81,8 +81,8 @@ struct rtrs_srv_sess {
 	spinlock_t		state_lock;
 	int			cur_cq_vector;
 	struct rtrs_srv_op	**ops_ids;
-	atomic_t		ids_inflight;
-	wait_queue_head_t	ids_waitq;
+	struct percpu_ref       ids_inflight_ref;
+	struct completion       complete_done;
 	struct rtrs_srv_mr	*mrs;
 	unsigned int		mrs_num;
 	dma_addr_t		*dma_addr;
-- 
2.25.1

