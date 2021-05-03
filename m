Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD01371488
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhECLt1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhECLtZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E7FC06138D
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r9so7404293ejj.3
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkpxEEkKKpPlgc4wb6EvnsvOqCNLQTpTjL7yczJzulk=;
        b=gcMIl+bkoZjLAMo4Y/jO/SDDO55tFXw36wUMCqbPEzHLFhXv2ZoqNXu8bghdnKJCOC
         wog1F80oTe+ivWNUTtZSV3ED6ZMJ86q3G2JqW715hbD/sskU0KPyRo6tu+c0mTD+y2S5
         B51ijVGJjMqjst8cdL3ozcrWCKBqL2qBJU5gEfjmLTnZ0iKANOJQxVyGi2xock6nLAAw
         g5SvpY0ywjeAubvL54dUHcg1Kn6+wHSXGccqZERL4kCeEZHfMeImM/zpiao9xB+jyLxN
         Wd8OLMQhYZg/n9iO47PNQmvVBvVl34Ihitf7boYilyEhOYp0I+8nXUH2/6+xZuMRet5y
         9U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkpxEEkKKpPlgc4wb6EvnsvOqCNLQTpTjL7yczJzulk=;
        b=aWk8bQhy6lcs2UDX/7mPCjfOodsBS6pgiQzuZIKXHl+/DXzQldfjQ+YrZpiVBVovrz
         ckq9xdUhAuMvHiRHcB9OTCEkmO5uMkeznwQx01FGNtFmUlGHzTfowrG/oQaX1O4j5u87
         qCywqEYw0sVk47w4smpzUoHvD0Zu31udIOYTD0/J1Fl3ZaY0cGUv3Cs32VTs7jUG/nH7
         yDjXEM4/cM14arcDtrtx9523gnB3bsHCnSbM7EQqWKOXGfWmNjK9efSzoJzyW0CzdvID
         1XXZ261dcxzVkbwlavjLD4ABTg9bjnhcM4qduiBOBsZjPbssTbm5cd+RbQ0z9cCKSErx
         TVJw==
X-Gm-Message-State: AOAM530vSanoYamF9Cw2wjl801c2yaab/ODPNBKVqDRYpyis5rNMGSjZ
        TD/RXoal2cv29OaJ4JVKxdTx2jJYv6S5AA==
X-Google-Smtp-Source: ABdhPJxqoD9Hd14pE/zt6+UXlBtlrR3mkFSUu7vf8iDsoWEk1Ig2qOh5Wugnw7q9XKj2S9fPv/6zdg==
X-Received: by 2002:a17:906:d28e:: with SMTP id ay14mr16054207ejb.33.1620042510950;
        Mon, 03 May 2021 04:48:30 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:30 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 14/20] RDMA/rtrs-srv: Replace atomic_t with percpu_ref for ids_inflight
Date:   Mon,  3 May 2021 13:48:12 +0200
Message-Id: <20210503114818.288896-15-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
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

