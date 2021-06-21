Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3753AE2ED
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 07:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhFUF5m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 01:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFUF4E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 01:56:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2943C061760
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:53:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id og14so26729585ejc.5
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijpwdXfU4jHah3Oo2g8JYu3i3PUYSWgdqTlXPVgKNy4=;
        b=aHIPaEcswa5v163wt/1COtJQnqrxeXOgt/YP4FfRF70FQH9FrXgCGHR8RpWS0357DV
         /3/uW2ZJYhK5PVIEfrJ5KNlahJ7psCw8mqRCRvuwJKZPvSoL3gk/UCCwBrSVYgrtkwqZ
         UoVY1nscJU0xojZE1Fc765xDTM0sClay7idw3AdcPa8ftUkf3OHY6tteSZmN0EF45ccK
         pGZHXJeR4s2x8cqwTFiErg46wpal0/rW/AXAUQweKd0THxgHDHnW8OtO4DOW3irCccFF
         5lF8mF5Y2YiYss6XGWY1JbfhQ/1jM30lKJtpe4uu/g+yoW0UesW3kxtMlyTAcSNDxwjo
         Reiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijpwdXfU4jHah3Oo2g8JYu3i3PUYSWgdqTlXPVgKNy4=;
        b=FdzEgrgKH1OAMIeL9SbSP6svxZoK+cJtCG1TKyYI80Uu0gsa5lTUANtsaIPSbxesj5
         sCeyg2NCljTVBMA8dCjSC7u5a8qeO9dtS9jDZEXqbUQyQs3icPz7fZQa7IPDXeATEUUy
         HJP3lqbx4kvaxl4SM8XQD6h8OqEt0LgMpRPlGA4FrqQytZuW29eRkCl9QS4IzRd/iKBW
         MsCnBKGhYTrnUjy4wcTEO1v+aItUGh6j8STOGRfS3VdPmQv29JJTG5vQoHKi9/QD44tn
         suvyjV5V57olVnf/iSb73k0oqRMj/s0nhFGEAfDQOEwLRbeFbur9jmrd1YNIpmxKyKux
         /3xQ==
X-Gm-Message-State: AOAM530++7MOO02/2TyMlil11M+XJqhnmoKuU/8+cnuFPhFY8R5zoOxu
        zMpYXVrtpNgxbtCSWzDHdTVII3rwSyyj2Q==
X-Google-Smtp-Source: ABdhPJwnWSBIxHhKTe02XLtkhahTEHCUqkwwuPUYRhCDV6W+B6Rle+pGJ9ZRZ5CoE7tOBRGXYVSu7g==
X-Received: by 2002:a17:907:3fa7:: with SMTP id hr39mr1032173ejc.23.1624254829183;
        Sun, 20 Jun 2021 22:53:49 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49f3:be00:dc22:f90e:1d6c:a47])
        by smtp.gmail.com with ESMTPSA id i18sm1919617edc.7.2021.06.20.22.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 22:53:49 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Jack Wang <jinpu.wang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH resend for-next 5/5] rnbd/rtrs-clt: Query and use max_segments from rtrs-clt.
Date:   Mon, 21 Jun 2021 07:53:40 +0200
Message-Id: <20210621055340.11789-6-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621055340.11789-1-jinpu.wang@ionos.com>
References: <20210621055340.11789-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

With fast memory registration on write request, rnbd-clt
can do bigger IO without split. rnbd-clt now can query
rtrs-clt to get the max_segments, instead of using
BMAX_SEGMENTS.

BMAX_SEGMENTS is not longer needed, so remove it.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c          |  5 +++--
 drivers/block/rnbd/rnbd-clt.h          |  5 +----
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 18 ++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs.h     |  2 +-
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index c604a402cd5c..d6f12e6c91f7 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -92,7 +92,7 @@ static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
 	dev->fua		    = !!(rsp->cache_policy & RNBD_FUA);
 
 	dev->max_hw_sectors = sess->max_io_size / SECTOR_SIZE;
-	dev->max_segments = BMAX_SEGMENTS;
+	dev->max_segments = sess->max_segments;
 
 	return 0;
 }
@@ -1292,7 +1292,7 @@ find_and_get_or_create_sess(const char *sessname,
 	sess->rtrs = rtrs_clt_open(&rtrs_ops, sessname,
 				   paths, path_cnt, port_nr,
 				   0, /* Do not use pdu of rtrs */
-				   RECONNECT_DELAY, BMAX_SEGMENTS,
+				   RECONNECT_DELAY,
 				   MAX_RECONNECTS, nr_poll_queues);
 	if (IS_ERR(sess->rtrs)) {
 		err = PTR_ERR(sess->rtrs);
@@ -1306,6 +1306,7 @@ find_and_get_or_create_sess(const char *sessname,
 	sess->max_io_size = attrs.max_io_size;
 	sess->queue_depth = attrs.queue_depth;
 	sess->nr_poll_queues = nr_poll_queues;
+	sess->max_segments = attrs.max_segments;
 
 	err = setup_mq_tags(sess);
 	if (err)
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index b5322c5aaac0..9ef8c4f306f2 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -20,10 +20,6 @@
 #include "rnbd-proto.h"
 #include "rnbd-log.h"
 
-/* Max. number of segments per IO request, Mellanox Connect X ~ Connect X5,
- * choose minimial 30 for all, minus 1 for internal protocol, so 29.
- */
-#define BMAX_SEGMENTS 29
 /*  time in seconds between reconnect tries, default to 30 s */
 #define RECONNECT_DELAY 30
 /*
@@ -89,6 +85,7 @@ struct rnbd_clt_session {
 	atomic_t		busy;
 	size_t			queue_depth;
 	u32			max_io_size;
+	u32			max_segments;
 	struct blk_mq_tag_set	tag_set;
 	u32			nr_poll_queues;
 	struct mutex		lock; /* protects state and devs_list */
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 042110739941..d7aed4388765 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1357,7 +1357,6 @@ static void free_sess_reqs(struct rtrs_clt_sess *sess)
 static int alloc_sess_reqs(struct rtrs_clt_sess *sess)
 {
 	struct rtrs_clt_io_req *req;
-	struct rtrs_clt *clt = sess->clt;
 	int i, err = -ENOMEM;
 
 	sess->reqs = kcalloc(sess->queue_depth, sizeof(*sess->reqs),
@@ -1466,6 +1465,8 @@ static void query_fast_reg_mode(struct rtrs_clt_sess *sess)
 	sess->max_pages_per_mr =
 		min3(sess->max_pages_per_mr, (u32)max_pages_per_mr,
 		     ib_dev->attrs.max_fast_reg_page_list_len);
+	sess->clt->max_segments =
+		min(sess->max_pages_per_mr, sess->clt->max_segments);
 }
 
 static bool rtrs_clt_change_state_get_old(struct rtrs_clt_sess *sess,
@@ -1503,9 +1504,8 @@ static void rtrs_clt_reconnect_work(struct work_struct *work);
 static void rtrs_clt_close_work(struct work_struct *work);
 
 static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
-					 const struct rtrs_addr *path,
-					 size_t con_num, u16 max_segments,
-					 u32 nr_poll_queues)
+					const struct rtrs_addr *path,
+					size_t con_num, u32 nr_poll_queues)
 {
 	struct rtrs_clt_sess *sess;
 	int err = -ENOMEM;
@@ -2668,7 +2668,6 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 				  u16 port, size_t pdu_sz, void *priv,
 				  void	(*link_ev)(void *priv,
 						   enum rtrs_clt_link_ev ev),
-				  unsigned int max_segments,
 				  unsigned int reconnect_delay_sec,
 				  unsigned int max_reconnect_attempts)
 {
@@ -2766,7 +2765,6 @@ static void free_clt(struct rtrs_clt *clt)
  * @port: port to be used by the RTRS session
  * @pdu_sz: Size of extra payload which can be accessed after permit allocation.
  * @reconnect_delay_sec: time between reconnect tries
- * @max_segments: Max. number of segments per IO request
  * @max_reconnect_attempts: Number of times to reconnect on error before giving
  *			    up, 0 for * disabled, -1 for forever
  * @nr_poll_queues: number of polling mode connection using IB_POLL_DIRECT flag
@@ -2781,7 +2779,6 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 				 const struct rtrs_addr *paths,
 				 size_t paths_num, u16 port,
 				 size_t pdu_sz, u8 reconnect_delay_sec,
-				 u16 max_segments,
 				 s16 max_reconnect_attempts, u32 nr_poll_queues)
 {
 	struct rtrs_clt_sess *sess, *tmp;
@@ -2790,7 +2787,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 
 	clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
 			ops->link_ev,
-			max_segments, reconnect_delay_sec,
+			reconnect_delay_sec,
 			max_reconnect_attempts);
 	if (IS_ERR(clt)) {
 		err = PTR_ERR(clt);
@@ -2800,7 +2797,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		struct rtrs_clt_sess *sess;
 
 		sess = alloc_sess(clt, &paths[i], nr_cpu_ids,
-				  max_segments, nr_poll_queues);
+				  nr_poll_queues);
 		if (IS_ERR(sess)) {
 			err = PTR_ERR(sess);
 			goto close_all_sess;
@@ -3062,6 +3059,7 @@ int rtrs_clt_query(struct rtrs_clt *clt, struct rtrs_attrs *attr)
 		return -ECOMM;
 
 	attr->queue_depth      = clt->queue_depth;
+	attr->max_segments     = clt->max_segments;
 	/* Cap max_io_size to min of remote buffer size and the fr pages */
 	attr->max_io_size = min_t(int, clt->max_io_size,
 				  clt->max_segments * SZ_4K);
@@ -3076,7 +3074,7 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 	struct rtrs_clt_sess *sess;
 	int err;
 
-	sess = alloc_sess(clt, addr, nr_cpu_ids, clt->max_segments, 0);
+	sess = alloc_sess(clt, addr, nr_cpu_ids, 0);
 	if (IS_ERR(sess))
 		return PTR_ERR(sess);
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index dc3e1af1a85b..859c79685daf 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -57,7 +57,6 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 				 const struct rtrs_addr *paths,
 				 size_t path_cnt, u16 port,
 				 size_t pdu_sz, u8 reconnect_delay_sec,
-				 u16 max_segments,
 				 s16 max_reconnect_attempts, u32 nr_poll_queues);
 
 void rtrs_clt_close(struct rtrs_clt *sess);
@@ -110,6 +109,7 @@ int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index);
 struct rtrs_attrs {
 	u32		queue_depth;
 	u32		max_io_size;
+	u32		max_segments;
 };
 
 int rtrs_clt_query(struct rtrs_clt *sess, struct rtrs_attrs *attr);
-- 
2.25.1

