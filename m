Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9413334E254
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Mar 2021 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhC3Hij (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhC3HiQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Mar 2021 03:38:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9A1C061764
        for <linux-rdma@vger.kernel.org>; Tue, 30 Mar 2021 00:38:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l4so23295657ejc.10
        for <linux-rdma@vger.kernel.org>; Tue, 30 Mar 2021 00:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOrWylNgv4HQ5STa2oRnjcaCVNNyjdluAJ/C+cL7Khg=;
        b=AZwIYOkoi8zraRAtQeHYJ/gWrZ78BQAe9idZDujwTMEIG+b8HskQpgLDV87C6Rtnqe
         evUa6eH89/PbN3UhMdTO13q67tx9uCHcGCo35QpWsKGcH5Id6yZ5EE2pno+S+/sAOruA
         Z0aJMJ9yohJDbbcv1Zfb6+JeBr17pM7d4qHVziQL7RIksug5IUMJz/dIsHE6X+FSm4A2
         u6q+kPvsY45Cu+2+1wgATLy7z9is0paR9Y8ZJLX5CkP9kCaHSKlNnrg75DgrR43ua3H7
         c3FTPTXU8H+zn8VXPQXXzUskBbFGtT6WVfqXWFGxJtIFHnac9WNJjQaO4QKKJ+AwSFyZ
         QaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOrWylNgv4HQ5STa2oRnjcaCVNNyjdluAJ/C+cL7Khg=;
        b=Kv6kDvDWl67jN80TAXYdoPxNB3Vxn3ZMxAkiVhvmItboE1RYOeA9Ak0YZuCgO2bn+t
         zeqr7lYxO+gRvJMBkrosFTaNK+aYTG/iA1SZq6cXgZJJm2xsa5lUMXDnvqVghKkzJB6I
         41ignXYkrrc+rHg1Kjm4yNKvwidMTBDHFqMiCsd+DOsXqdlaihIvfR8oUbqmSCGomlqR
         KD8+Eik21yPeWzVnaOypDunt9xkDyn4QZeTCQ4lUdPIUTaQ+XeSMi2weZtf0G0XieXPm
         4TCz/jGsX8bLy5P8mc+53Kxp6SORT3Vv6vIpPXD8Hg4I5tmtm0Cmt2ePxcWr/pe7JQpW
         nXDw==
X-Gm-Message-State: AOAM533MhBFS/rOA771Nx5yoLoKnVTCYbmmVsDA30YfEbltZoHnSgHqP
        wwjMjA7+yNLzUtnP468G5Ai0ts/YPqTigvOq
X-Google-Smtp-Source: ABdhPJy7VyIE/oOQM5xjoduVDlOXvH1LpM0JlkkBm2RZLHRuS1ZfKrrEsALCWXvwmmfmE9eDTKaN/Q==
X-Received: by 2002:a17:906:ecaa:: with SMTP id qh10mr32193080ejb.425.1617089894488;
        Tue, 30 Mar 2021 00:38:14 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:14 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 22/24] block/rnbd-clt: Remove max_segment_size
Date:   Tue, 30 Mar 2021 09:37:50 +0200
Message-Id: <20210330073752.1465613-23-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
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
index 6f3ca2e3bc02..9d1bc49d5595 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1295,7 +1295,6 @@ find_and_get_or_create_sess(const char *sessname,
 				   paths, path_cnt, port_nr,
 				   0, /* Do not use pdu of rtrs */
 				   RECONNECT_DELAY, BMAX_SEGMENTS,
-				   BLK_MAX_SEGMENT_SIZE,
 				   MAX_RECONNECTS, nr_poll_queues);
 	if (IS_ERR(sess->rtrs)) {
 		err = PTR_ERR(sess->rtrs);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index cf9dbcbc11e7..db15257dc978 100644
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
index c25a0fd8a607..feb76af95e96 100644
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

