Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DC0354D64
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 09:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbhDFHHv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 03:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244166AbhDFHHo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 03:07:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064B8C061764
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 00:07:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id mh7so10229317ejb.12
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 00:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9p6hzGO3n9rwReCcMTUMBgkQ/We1yFtqYVf9rejA0g=;
        b=fuI/PWpDO9cyIua2uqhsuAoM8XuPdY5+68V7VI94sbJ8hUnAt6iZggIwgILtnLC6ih
         ZmNacMNouvzDOCNnO7GbyKeBmZB+MxzUKs2P8/WfOlvL0y1Yf1fK06wxs7LZJhLzYNs1
         UG0ZDYn8oiE8uoBdJ6XFzV17UvSYEbt4O3RTlyRoHuV/Obb996vBA2BL+W4CsdHyPHq1
         /b8a422KHw/xVYLSPePnqTF3eaiSA8ycfFX49NcZvavxX/wI18e2FqeB+lt412NtWW++
         HMhqnm+ojlmJ4w7n4lwVl7hCX9gUPg3Y6v1CsaUQ5sUxOa8+MDSiOE3cXJHNSENcs1SU
         z2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9p6hzGO3n9rwReCcMTUMBgkQ/We1yFtqYVf9rejA0g=;
        b=q+5iUiUg5fODH/S5eKNMo18KRT8GdeDNkt19Tb8ftqdnsMvlepf8VtNlo/M01EquJZ
         mMPXpUbrMOHh3Ry2RC7GSDjjMfHbOWV9ufEa+zELwUzjXGpJ/UtNz4r3jKCICVhTUpug
         u9d3UZUS6aehc6qObrbvpUNGnWVJUuQmPWtKxwWNBSn4RywjsxvtBXWgvs5NnjaQ0bSV
         9gXGtOn7p7ReCyB0zBcsSwYZd1Z346vyFpDzBN722ZLFqbcvUQ9qDOvstbQ6hwVvWY2w
         QfLvlLKAC42eqRL5EHSiqfvFvfUmNzPyEh+wWZC39N5pyEVPGyVwpwWwJ0q9yVAkyc1h
         oinQ==
X-Gm-Message-State: AOAM530WI0PgSvvP8oBFkRpqKM3+8V+M7LWSf9m667ee2OtZqQ2hRgKn
        Yrh1KINvTmhvx2PLnzbZbUditQ==
X-Google-Smtp-Source: ABdhPJxtNtAKqmHM44YRSySPOGPs78CY6I2pLWwN6LXxR3bCunUd7U0AJkYgpL3OP2HTLcg1L00p8A==
X-Received: by 2002:a17:906:3c03:: with SMTP id h3mr8813240ejg.329.1617692853649;
        Tue, 06 Apr 2021 00:07:33 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:33 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 17/19] block/rnbd-clt: Remove max_segment_size
Date:   Tue,  6 Apr 2021 09:07:14 +0200
Message-Id: <20210406070716.168541-18-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

We always map with SZ_4K, so do not need max_segment_size.

Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c          |  1 -
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 15 +++++----------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 -
 drivers/infiniband/ulp/rtrs/rtrs.h     |  1 -
 4 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 1fe010ed6f69..7446660eb7f2 100644
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
index 467d135a82cf..1603e0c399e8 100644
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

