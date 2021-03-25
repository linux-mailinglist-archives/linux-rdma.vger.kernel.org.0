Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813BF349574
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhCYPab (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhCYPaJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:30:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3534C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:30:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jy13so3623087ejc.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V+oNHeYm6T889iC0TKZ6lC3gbkAN4B7t7g1f3Sr4HFs=;
        b=JOPuniZD+CLqPzyYsXKM+el3JnnPG5ZSoEgcqp/+gxUBq/QkuSNCuilMI9vZGjNXQd
         0j6m0SkEXtzxKMUmM8e9kU1S2JEX2JzX/c17Acu3OCV+HI0b3lcbsznOs9iPaIf3T05C
         0lI6u9AXh7h/69dsGxvncDzm5i6dMs1rxd+S3JHB5NIaVEA9PulHPq7aN+Rss3yVJUZs
         feZiLQ4Pk2bfUNZxbe1afp3fX28fJlBpbo/qUhKz9zF7Vl4O6nl99dDOto9uovj/GmUD
         XUWXVE96IAb7/lnM1d1v2ETxa3bblX7/Ry6LPTnXhXvpsoukrYYOWuC/j55u9QmrkjvY
         OFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+oNHeYm6T889iC0TKZ6lC3gbkAN4B7t7g1f3Sr4HFs=;
        b=F3SY4T0YJ3TFH8214Tt6ME26lnMAjaSqYa6kkAyUbhjCiPLnxGdhr9fiY0ZMXkHbpH
         x/GM2Oz+ZRXtnCvwoFt23c17sQqGYCiWMXYMl9Ao0Xr+l6YlcXUOzmMoZl4VR+AnoJdQ
         qAHsZ/NHWIpAfndBGznP7xnF+YCswQJ2oX3fJHFCefCXCtJpFo0iDTQx+E6saRZ/tj6x
         ktj8ZkXM1+EtqMtSri8WBObRdMj7xD6hreRfbamJDKGLHMVGtZQYJxIoBEkpQ0rOoFJ1
         ZkC/KHbGtPV5009NCF8dBZYfhYBNYoj69djkCggOHxHmfX3cI8MFhBnvS3eIrBevL/Rs
         4+Cw==
X-Gm-Message-State: AOAM531W6iaxI5ccU9jE4P6VXietbq5Ph0KIy8aa/8WGyPNwWaxBKoVg
        lUB8ghDnza7sElhRgeJ3ynq2hg==
X-Google-Smtp-Source: ABdhPJyI//JwuJ3YcIVEtye7GvX0SjMQPLpbaQ0eKXf362IA/40zdAHYeo7lNfiTrNOn3eU5c94DrA==
X-Received: by 2002:a17:906:3388:: with SMTP id v8mr10291297eja.278.1616686207671;
        Thu, 25 Mar 2021 08:30:07 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:30:07 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-rc 22/24] block/rnbd-clt: Remove max_segment_size
Date:   Thu, 25 Mar 2021 16:29:09 +0100
Message-Id: <20210325152911.1213627-23-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
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
index 60410115c4f4..4e876bceb76f 100644
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

