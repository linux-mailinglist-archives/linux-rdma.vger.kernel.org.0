Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223A135531C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbhDFMGG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 08:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343678AbhDFMGF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 08:06:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84646C061756
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 05:05:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r12so21521782ejr.5
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1FMxaEGZsHLD1gd/lUFX9BJDJPcI/a3qGgeA8g4SQ+A=;
        b=KUSNjby/6qrOShkFg4gZg/UvVVYAvsL9vFVfeXJVEOPU7LhhtLIFVFjgaqFs9dW1xc
         ooC86W1hk9yNrTNEuCg1o1enzIDVYiNcXZX8N3FTQJuKzqqw+oSswtxxHOqpEKG8iNnv
         ZGqmONrJV31/XJMyKJWinR85N1hIw5XAzbXZJD6iNiLuFR2vMTzMko7mLiXLwVurkIPJ
         qeEd1nzoAurEezrhKd5dSk22kJA1gBXzOk2pQ+2nKcHds4IoQPfklTVouhsK7K/R3/eS
         NRx3yKS39yEN08uRLjnSOTuhXdCtLESfysilKZN8ht7ke4TthUunyTW3m64WwHzAE5rQ
         XxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1FMxaEGZsHLD1gd/lUFX9BJDJPcI/a3qGgeA8g4SQ+A=;
        b=g1HlZLfNbv8rPtOQe96leoQXHX8c7jXouyUrp7gnGqi4d8Qi922ucb63oG3/akceN+
         +oz1DYubzOS6q8TV+psXcputq3R26Z+/wWSyeEBScUtxRhvOplWrTneQXWketFYqSB4P
         7meUn21xI4W0N/92eV5nlfuyZmWQhxrmag+nvOFGgSgPjTuvr6RfKwQRtp6V1hWJPBxz
         RaKJYyuRjoghB9sZSdB5vWtTFToSL3fTVoz4COUvMrxTK8EkczM4wwYT1kJByUdREl1n
         9cSU5JxuJ3uOXawvG6AlAtv4nSgLqUy2HBMh3ZRfSvVCPXmsFoaG8eH8/FKgURkMbAhT
         Dl5Q==
X-Gm-Message-State: AOAM5325AD3tG8/fr012VyyPgZ5LvajVt+IGQibEr9MSHoa9EhmAC/2a
        scAP/4jzX73TwEd5Jm256T3jT+4fbixlzeVV
X-Google-Smtp-Source: ABdhPJw64QIxUj9SxHTzk9DpW/rSJDA4OlrZoKy9+QPH7BehfgILWYrLwDK0NEHyi/gAa+B1zezxZA==
X-Received: by 2002:a17:907:2bf6:: with SMTP id gv54mr34171203ejc.514.1617710755982;
        Tue, 06 Apr 2021 05:05:55 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id jj15sm10987694ejc.99.2021.04.06.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:05:55 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH 1/4] RDMA/rtrs-clt: Add a minimum latency multipath policy
Date:   Tue,  6 Apr 2021 14:05:50 +0200
Message-Id: <20210406120553.197848-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406120553.197848-1-gi-oh.kim@ionos.com>
References: <20210406120553.197848-1-gi-oh.kim@ionos.com>
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
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 18 +++++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 57 +++++++++++++++++++-
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  2 +
 drivers/infiniband/ulp/rtrs/rtrs.c           |  3 ++
 5 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index c502dcbae9bb..bc46b7a99ba0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -101,6 +101,8 @@ static ssize_t mpath_policy_show(struct device *dev,
 	case MP_POLICY_MIN_INFLIGHT:
 		return sysfs_emit(page, "min-inflight (MI: %d)\n",
 				  clt->mp_policy);
+	case MP_POLICY_MIN_LATENCY:
+		return sprintf(page, "min-latency (ML: %d)\n", clt->mp_policy);
 	default:
 		return sysfs_emit(page, "Unknown (%d)\n", clt->mp_policy);
 	}
@@ -114,22 +116,32 @@ static ssize_t mpath_policy_store(struct device *dev,
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
index 0fa80e0a3f27..4ccdd364777a 100644
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

