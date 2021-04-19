Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB223363CCE
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 09:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbhDSHie (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 03:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbhDSHie (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Apr 2021 03:38:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87537C061761
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 00:38:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y3so3153386eds.5
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 00:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGulsiDP85qTWmeqfCGWtmZxyNJhHyHuAwjDSVPm7EA=;
        b=QUjLCTggyKEx9gHrjKlArxE0WcBi02UZRjWleNgnGUBLnnc2ALFFCv0Bxdl2XvLZ2s
         C75UlfapVRWYD6pK5z0fSuwCb95pdxfSAXf7sHsT2w1AMqoIOlvE1Z+u6HS4FI7tKiXk
         FirAGzuUBGJGoIetsWB+rWySIhSgjs0cU+/eZ1ZdRP6H11aqUQta+5qjcBoKaOPsEHAF
         be30XCg0Y9CtIwlJUORasPbmF5n3fBs5pG40F/dXz5L3KOZImC3KX6953sziQDP0a7SA
         bTy4o3WjtN2cxGffLT0k6ZCW9BUq0VRAUcnRT21be+trGGpIwAc/hxdj5PySm6V1BoXM
         6dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGulsiDP85qTWmeqfCGWtmZxyNJhHyHuAwjDSVPm7EA=;
        b=CuWELO/Ce3O51gIvRSIp1SkV2XJ+GrNEDxVAnqmffoclmTeklaTrxSY4T5Vwjtko61
         e6aKNXrrWLY8WivlcBhN1Z5tX0Tow5sIYzKw48XkGghK6ZqtEifFKcK7hhM9Mqez6GRK
         4c/NXxPK8QICMprUn/VPz4MmYhzVG3rDxO5Gn+wU4r9cvqQ+kHdvWj1uVsXeV1y3jlyU
         09BmWoS+pN6ZhCMiNUebr/dMoBrPoi2QlHKHmBki7zWI/yPQZTX5jDzsl2ZdSRNtiUad
         BZfxqyoM5uUwaTdhylYqtV1OemsTgGnCQr/SRILdDdqmMO2RRmykdTe6kqomeFnt3So5
         YVeQ==
X-Gm-Message-State: AOAM532xXOF3XuyRp9xqxcgX3gcfndQB8Ju5zuQ4fV3QWw2be2Ky0mFJ
        2dxdV6FB/+VxxFEnstiToWtkUA==
X-Google-Smtp-Source: ABdhPJwuQngROLXM5/OEY03WOv/eEFgsUaJ+kI7k6hgpsTFV23qbqCZTQw3IJZ72D8qZZ+iHwu4n1g==
X-Received: by 2002:aa7:ca0f:: with SMTP id y15mr22465588eds.384.1618817883262;
        Mon, 19 Apr 2021 00:38:03 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:38:02 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Gioh Kim <gi-oh.kim@ionos.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCHv5 for-next 17/19] block/rnbd-clt: Remove max_segment_size
Date:   Mon, 19 Apr 2021 09:37:20 +0200
Message-Id: <20210419073722.15351-18-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

We always map with SZ_4K, so do not need max_segment_size.

Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Acked-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/block/rnbd/rnbd-clt.c          |  1 -
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 15 +++++----------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 -
 drivers/infiniband/ulp/rtrs/rtrs.h     |  1 -
 4 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 01f67e08afc3..95381e6663e0 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1289,7 +1289,6 @@ find_and_get_or_create_sess(const char *sessname,
 				   paths, path_cnt, port_nr,
 				   0, /* Do not use pdu of rtrs */
 				   RECONNECT_DELAY, BMAX_SEGMENTS,
-				   BLK_MAX_SEGMENT_SIZE,
 				   MAX_RECONNECTS, nr_poll_queues);
 	if (IS_ERR(sess->rtrs)) {
 		err = PTR_ERR(sess->rtrs);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index eb0a5e2058ae..63623d872602 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1400,7 +1400,7 @@ static void rtrs_clt_close_work(struct work_struct *work);
 static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 					 const struct rtrs_addr *path,
 					 size_t con_num, u16 max_segments,
-					 size_t max_segment_size, u32 nr_poll_queues)
+					 u32 nr_poll_queues)
 {
 	struct rtrs_clt_sess *sess;
 	int err = -ENOMEM;
@@ -1442,7 +1442,7 @@ static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 		       rdma_addr_size((struct sockaddr *)path->src));
 	strlcpy(sess->s.sessname, clt->sessname, sizeof(sess->s.sessname));
 	sess->clt = clt;
-	sess->max_pages_per_mr = max_segments * max_segment_size >> 12;
+	sess->max_pages_per_mr = max_segments;
 	init_waitqueue_head(&sess->state_wq);
 	sess->state = RTRS_CLT_CONNECTING;
 	atomic_set(&sess->connected_cnt, 0);
@@ -2538,7 +2538,6 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 				  void	(*link_ev)(void *priv,
 						   enum rtrs_clt_link_ev ev),
 				  unsigned int max_segments,
-				  size_t max_segment_size,
 				  unsigned int reconnect_delay_sec,
 				  unsigned int max_reconnect_attempts)
 {
@@ -2568,7 +2567,6 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 	clt->port = port;
 	clt->pdu_sz = pdu_sz;
 	clt->max_segments = max_segments;
-	clt->max_segment_size = max_segment_size;
 	clt->reconnect_delay_sec = reconnect_delay_sec;
 	clt->max_reconnect_attempts = max_reconnect_attempts;
 	clt->priv = priv;
@@ -2638,7 +2636,6 @@ static void free_clt(struct rtrs_clt *clt)
  * @pdu_sz: Size of extra payload which can be accessed after permit allocation.
  * @reconnect_delay_sec: time between reconnect tries
  * @max_segments: Max. number of segments per IO request
- * @max_segment_size: Max. size of one segment
  * @max_reconnect_attempts: Number of times to reconnect on error before giving
  *			    up, 0 for * disabled, -1 for forever
  * @nr_poll_queues: number of polling mode connection using IB_POLL_DIRECT flag
@@ -2654,7 +2651,6 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 				 size_t paths_num, u16 port,
 				 size_t pdu_sz, u8 reconnect_delay_sec,
 				 u16 max_segments,
-				 size_t max_segment_size,
 				 s16 max_reconnect_attempts, u32 nr_poll_queues)
 {
 	struct rtrs_clt_sess *sess, *tmp;
@@ -2663,7 +2659,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 
 	clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
 			ops->link_ev,
-			max_segments, max_segment_size, reconnect_delay_sec,
+			max_segments, reconnect_delay_sec,
 			max_reconnect_attempts);
 	if (IS_ERR(clt)) {
 		err = PTR_ERR(clt);
@@ -2673,7 +2669,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		struct rtrs_clt_sess *sess;
 
 		sess = alloc_sess(clt, &paths[i], nr_cpu_ids,
-				  max_segments, max_segment_size, nr_poll_queues);
+				  max_segments, nr_poll_queues);
 		if (IS_ERR(sess)) {
 			err = PTR_ERR(sess);
 			goto close_all_sess;
@@ -2951,8 +2947,7 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 	struct rtrs_clt_sess *sess;
 	int err;
 
-	sess = alloc_sess(clt, addr, nr_cpu_ids, clt->max_segments,
-			  clt->max_segment_size, 0);
+	sess = alloc_sess(clt, addr, nr_cpu_ids, clt->max_segments, 0);
 	if (IS_ERR(sess))
 		return PTR_ERR(sess);
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 692bc83e1f09..98ba5d0a48b8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -166,7 +166,6 @@ struct rtrs_clt {
 	unsigned int		max_reconnect_attempts;
 	unsigned int		reconnect_delay_sec;
 	unsigned int		max_segments;
-	size_t			max_segment_size;
 	void			*permits;
 	unsigned long		*permits_map;
 	size_t			queue_depth;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index b0f56ffeff88..bebaa94c4728 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -58,7 +58,6 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 				 size_t path_cnt, u16 port,
 				 size_t pdu_sz, u8 reconnect_delay_sec,
 				 u16 max_segments,
-				 size_t max_segment_size,
 				 s16 max_reconnect_attempts, u32 nr_poll_queues);
 
 void rtrs_clt_close(struct rtrs_clt *sess);
-- 
2.25.1

