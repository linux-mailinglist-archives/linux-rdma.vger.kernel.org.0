Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B603941CE
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhE1LcP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbhE1LcH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8150DC061761
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g7so4478671edm.4
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DKurLA/0gHvT4nPGy7wrh43l+njp8QOj+CWKGl5rTa8=;
        b=K/j810iT6xofVAAj24od4Pmud41YR/pvDYPFUBy0vGmv+6WZfq1r8Pz27u188S3xGf
         deMToA8htysH8EbX71rh1PbKCQOHkfYe4BiuCEm/Yl3xNZOhuau2a3ZYTVtB4ou08Slm
         p2RRaboGdRsM1LRyzMFhusP5GtaGU3X9ZVOIuRpKhPvvE6cTsihhuBO9/gS1zKJBtZJ5
         lK/1GlqAJPa/kSH9KkxdAbsfo0WBHHD2dR4zbr4QCxCW/hRemWH6bW7+g75gyKMdhXuh
         nQfrYzsGB73mslExiYmMb/OuRQm/wVye/O3fcacra/HOIhLvo8C2j765DcTd94pby5Zz
         RYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DKurLA/0gHvT4nPGy7wrh43l+njp8QOj+CWKGl5rTa8=;
        b=i232Pv9y8faAUCKsrXmy9GxgKJmgNEIRTOpi4/pbz1bedXrHWC+1EDcj1niRgEHijn
         Q0CGMi2xE8We3PfudGuDDk8TzOBTSeJMgvQt5ldQnsGad78sWwX+iOaQH+1/Q0+ySjdP
         LNdFYivyuEx935YxvWxzFT4USIM+B8IxLJq9KQCl6PDa6ISbPqX3p1cP1gZY7JuhCzk9
         04uIRie2poBe6YEalKpA6UTy4d5/mmq+HtPl8NibsTaeypzqfjJ1R3zEkT4WuVwwCqK9
         zqbh4NPI3AWvETdET0FAEdCW71/4wSExNHzP0lH3m+PQuMd7K1ylF9sjxu6cjQb7CHdx
         V6pQ==
X-Gm-Message-State: AOAM530F0SKKmjHaLuXXEx8K0qQiUn6W2sTE5EQ955h5xuK2CVlbiFD7
        aktq2ELidSZxxr0mq5js95ffgV5pFkcyzw==
X-Google-Smtp-Source: ABdhPJxvpYX2OYK9IaYZPxMFwk2pPwos+HnxHv3Ik5dBla2SrtbJpkmVH1ihM81Yu1TMG5s6c7C5Uw==
X-Received: by 2002:aa7:cb48:: with SMTP id w8mr9408738edt.12.1622201430948;
        Fri, 28 May 2021 04:30:30 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:30 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 13/20] RDMA/rtrs-srv: Replace atomic_t with percpu_ref for ids_inflight
Date:   Fri, 28 May 2021 13:30:11 +0200
Message-Id: <20210528113018.52290-14-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
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
index e102b1368d0c..520c24773229 100644
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
+	return scnprintf(page, len, "%lld %lld %lld %lldn %u\n",
+			  (s64)atomic64_read(&r->dir[READ].cnt),
+			  (s64)atomic64_read(&r->dir[READ].size_total),
+			  (s64)atomic64_read(&r->dir[WRITE].cnt),
+			  (s64)atomic64_read(&r->dir[WRITE].size_total), 0);
 }
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 840a3423f749..631d37976518 100644
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

