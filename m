Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95680356A11
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhDGKmT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbhDGKmS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 06:42:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92131C06175F
        for <linux-rdma@vger.kernel.org>; Wed,  7 Apr 2021 03:42:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ba6so12723283edb.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Apr 2021 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIcYZdIwZLlibhzcK2NBFQ5af+lkjml9BUm9lombpMQ=;
        b=CjX+PK5vUrlNZjlP2CDGaNs5vVOTMawK4xRqC1RiDl1XZrolHVZLJb0wJ9gi8tFxhC
         S4RV99xQ+E7txvjRC8Mswl4eJhQcEW3sip7C9OAwpzA/730DoUap2y6SpZ8IQ8lulxxc
         EuHImZfylpMqNuGT09EuzSafnnNRC0sVuwpIJNDxD/xgHE3Cr0BiINTaHBatmr4ydK4r
         Q4TOGBBVfsqcR6F7wb8el5Vm1FI4K7I8oETOfGlUxiuFApYUwewE0/IiqEYOddQj+nNv
         lBymeIvc31FYL0m0b6Jp//JwfsBdOLWyYHZao9JZf8DcDEuItPJZT45/kzOVpKt5p1es
         nwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIcYZdIwZLlibhzcK2NBFQ5af+lkjml9BUm9lombpMQ=;
        b=FVIKL7I/YsejiigptaeD9P0WPAUq3ayQjkParLwtQVgWAOHbro1IYVSNarbzCRbnhG
         Upek2Ci2FRhRVHzQdFpaC+P8LiTLP2kzAqEJNK8njR0vmFjEsy2g+b6iww3KIbjIpXOx
         3viXQIqzg1x5w+WcGDC1IH3xGx2S3RBEEVIUdr82cow+uVC2VB6EqEhlWCuSfI5e8qHK
         iEZtPwQUz2t7sWVmTKnR2TqgTxRSSUob/v9TLYfAy5nOezSzPNfQTNeTp0v32ukwP/vW
         VVqkITah5qOTBvaNcqpPIh+l58lXF7PHacKLXa98Vnj7Sa42h4U3FUvZG/xso6b7BEg5
         oX8g==
X-Gm-Message-State: AOAM532OfsdQKHPe7hUvuJk0XMiwJht9jfQAVNRpbNpmwNAakUucbnwV
        TJqB8ApO0w6S6oQ8ZL9nfZDxI+qZDiHi6P4w
X-Google-Smtp-Source: ABdhPJzJCddjwIosueICvl8WRtabz1uzObe0/o93zpSY7nfp++OPLVNF3GcI0xo0G8N0sMV+diZSBw==
X-Received: by 2002:a05:6402:31e1:: with SMTP id dy1mr3562236edb.113.1617792126944;
        Wed, 07 Apr 2021 03:42:06 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id j1sm12359779ejt.18.2021.04.07.03.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 03:42:06 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 1/4] RDMA/rtrs-clt: Add a minimum latency multipath policy
Date:   Wed,  7 Apr 2021 12:42:00 +0200
Message-Id: <20210407104203.24792-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407104203.24792-1-gi-oh.kim@ionos.com>
References: <20210407104203.24792-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

This patch adds new multipath policy: min-latency.
Client checks the latency of each path when it sends the heart-beat.
And it sends IO to the path with the minimum latency.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 19 +++++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 57 +++++++++++++++++++-
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  2 +
 drivers/infiniband/ulp/rtrs/rtrs.c           |  3 ++
 5 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index c502dcbae9bb..c8669d3f79f1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -101,6 +101,9 @@ static ssize_t mpath_policy_show(struct device *dev,
 	case MP_POLICY_MIN_INFLIGHT:
 		return sysfs_emit(page, "min-inflight (MI: %d)\n",
 				  clt->mp_policy);
+	case MP_POLICY_MIN_LATENCY:
+		return sysfs_emit(page, "min-latency (ML: %d)\n",
+				  clt->mp_policy);
 	default:
 		return sysfs_emit(page, "Unknown (%d)\n", clt->mp_policy);
 	}
@@ -114,22 +117,32 @@ static ssize_t mpath_policy_store(struct device *dev,
 	struct rtrs_clt *clt;
 	int value;
 	int ret;
+	size_t len = 0;
 
 	clt = container_of(dev, struct rtrs_clt, dev);
 
 	ret = kstrtoint(buf, 10, &value);
 	if (!ret && (value == MP_POLICY_RR ||
-		     value == MP_POLICY_MIN_INFLIGHT)) {
+		     value == MP_POLICY_MIN_INFLIGHT ||
+		     value == MP_POLICY_MIN_LATENCY)) {
 		clt->mp_policy = value;
 		return count;
 	}
 
+	/* distinguish "mi" and "min-latency" with length */
+	len = strnlen(buf, NAME_MAX);
+	if (buf[len - 1] == '\n')
+		len--;
+
 	if (!strncasecmp(buf, "round-robin", 11) ||
-	    !strncasecmp(buf, "rr", 2))
+	    (len == 2 && !strncasecmp(buf, "rr", 2)))
 		clt->mp_policy = MP_POLICY_RR;
 	else if (!strncasecmp(buf, "min-inflight", 12) ||
-		 !strncasecmp(buf, "mi", 2))
+		 (len == 2 && !strncasecmp(buf, "mi", 2)))
 		clt->mp_policy = MP_POLICY_MIN_INFLIGHT;
+	else if (!strncasecmp(buf, "min-latency", 11) ||
+		 (len == 2 && !strncasecmp(buf, "ml", 2)))
+		clt->mp_policy = MP_POLICY_MIN_LATENCY;
 	else
 		return -EINVAL;
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 4369e4cf13f0..f3b8151052cb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -633,6 +633,8 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		} else if (imm_type == RTRS_HB_ACK_IMM) {
 			WARN_ON(con->c.cid);
 			sess->s.hb_missed_cnt = 0;
+			sess->s.hb_cur_latency =
+				ktime_sub(ktime_get(), sess->s.hb_last_sent);
 			if (sess->flags & RTRS_MSG_NEW_RKEY_F)
 				return  rtrs_clt_recv_done(con, wc);
 		} else {
@@ -831,6 +833,57 @@ static struct rtrs_clt_sess *get_next_path_min_inflight(struct path_it *it)
 	return min_path;
 }
 
+/**
+ * get_next_path_min_latency() - Returns path with minimal latency.
+ * @it:	the path pointer
+ *
+ * Return: a path with the lowest latency or NULL if all paths are tried
+ *
+ * Locks:
+ *    rcu_read_lock() must be hold.
+ *
+ * Related to @MP_POLICY_MIN_LATENCY
+ *
+ * This DOES skip an already-tried path.
+ * There is a skip-list to skip a path if the path has tried but failed.
+ * It will try the minimum latency path and then the second minimum latency
+ * path and so on. Finally it will return NULL if all paths are tried.
+ * Therefore the caller MUST check the returned
+ * path is NULL and trigger the IO error.
+ */
+static struct rtrs_clt_sess *get_next_path_min_latency(struct path_it *it)
+{
+	struct rtrs_clt_sess *min_path = NULL;
+	struct rtrs_clt *clt = it->clt;
+	struct rtrs_clt_sess *sess;
+	ktime_t min_latency = INT_MAX;
+	ktime_t latency;
+
+	list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
+		if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
+			continue;
+
+		if (unlikely(!list_empty(raw_cpu_ptr(sess->mp_skip_entry))))
+			continue;
+
+		latency = sess->s.hb_cur_latency;
+
+		if (latency < min_latency) {
+			min_latency = latency;
+			min_path = sess;
+		}
+	}
+
+	/*
+	 * add the path to the skip list, so that next time we can get
+	 * a different one
+	 */
+	if (min_path)
+		list_add(raw_cpu_ptr(min_path->mp_skip_entry), &it->skip_list);
+
+	return min_path;
+}
+
 static inline void path_it_init(struct path_it *it, struct rtrs_clt *clt)
 {
 	INIT_LIST_HEAD(&it->skip_list);
@@ -839,8 +892,10 @@ static inline void path_it_init(struct path_it *it, struct rtrs_clt *clt)
 
 	if (clt->mp_policy == MP_POLICY_RR)
 		it->next_path = get_next_path_rr;
-	else
+	else if (clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
 		it->next_path = get_next_path_min_inflight;
+	else
+		it->next_path = get_next_path_min_latency;
 }
 
 static inline void path_it_deinit(struct path_it *it)
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 59ea2ec44fe5..5c0cea8dd83e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -30,6 +30,7 @@ enum rtrs_clt_state {
 enum rtrs_mp_policy {
 	MP_POLICY_RR,
 	MP_POLICY_MIN_INFLIGHT,
+	MP_POLICY_MIN_LATENCY,
 };
 
 /* see Documentation/ABI/testing/sysfs-class-rtrs-client for details */
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 1b31bda9ca78..bcad5e2168c5 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -112,6 +112,8 @@ struct rtrs_sess {
 	unsigned int		hb_interval_ms;
 	unsigned int		hb_missed_cnt;
 	unsigned int		hb_missed_max;
+	ktime_t			hb_last_sent;
+	ktime_t			hb_cur_latency;
 };
 
 /* rtrs information unit */
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index bc08b7f6e5e2..a7847282a2eb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -337,6 +337,9 @@ static void hb_work(struct work_struct *work)
 		schedule_hb(sess);
 		return;
 	}
+
+	sess->hb_last_sent = ktime_get();
+
 	imm = rtrs_to_imm(RTRS_HB_MSG_IMM, 0);
 	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
 					     0, NULL);
-- 
2.25.1

