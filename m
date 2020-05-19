Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259801D9501
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 13:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgESLPa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 07:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgESLPa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 07:15:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD623C05BD09
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 04:15:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so15385447wrx.10
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 04:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pW+kzW15PGpcVZl9bvylaiuLX6HBC4BMUpt01iLWbg8=;
        b=OCX1l0/w+oipbAIJkYvZpnb0IY6T/iw40cWz/mUpc5ipI6nkf5eVKW/xDPBDedSjuq
         WRo+H3z06R83TfSwoYzE2+/SPPU971baQ42ghi4kCvr1nLapTbBY1PNeyV3Pp0hzZ3qR
         jtRQ4ypsyJij8D8oNNw3i4kHSRtIj4AzCroQIQAn86+BNtSp0gBLO3wHdOhNPjo6uvsZ
         2Ww2Rx0whieONSf32doO3hz9QYNEM3RPAZ3snOdKzWu8RzGsU+wrrchmcKudFj2LH9DZ
         6QKUd3QoqLx8qwFz03GQ7NsGBlgValxDofm4qk+uLw7DYnjPhwbvOC0oT4UCVp0Gkq/n
         QmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pW+kzW15PGpcVZl9bvylaiuLX6HBC4BMUpt01iLWbg8=;
        b=It/cWDlm0zoRao/TdMJSCPFgS+j6nEUZ48W7FLJXX5yFBVNtYRo6PUNH4uV/Iwa6YG
         H4SnpR+zhGkhP4F5mHvdC6A16KTahJl6RyHTeQl/6+6iDrfzy/xHBr0krcoMhvHCUQsw
         9QObWl9Tn+qu0LMs34gNo2xX8xNejZCDCY0gI/DEe243O6zrldptGWmiWi0dG7WQ6KzU
         6Z4Bf5HEMIso5S+YRbKxYthrvXXzjP+spgQ8iTaUwzgQYLanttZA/09j3fTx8fO+ASVx
         0l+euD320U15eBjA32b3ohKboy3z55P+Yu8dtQOo5Vihr5I03JXJoFCJX2QhTX7ovRJr
         0kyQ==
X-Gm-Message-State: AOAM531n5NuxRHxIA5SQMmaQbb4sDrVP2aH9/NQAanOJYJtlhfmaaqtO
        q4t7m91PS1FfdATGQ4bo6YlX
X-Google-Smtp-Source: ABdhPJwv1K7qCs+9eTltTGz2wzBJo4gjAQUG8TlOwOSqdOfJjjHWwHLoI9blPbZpSER2l1s9Ik1eVA==
X-Received: by 2002:adf:fb0f:: with SMTP id c15mr26665427wrr.410.1589886928247;
        Tue, 19 May 2020 04:15:28 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id g24sm21516746wrb.35.2020.05.19.04.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 04:15:27 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-next@vger.kernel.org, axboe@kernel.dk, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     bvanassche@acm.org, leon@kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rdunlap@infradead.org
Subject: [PATCH v2] rnbd/rtrs: pass max segment size from blk user to the rdma library
Date:   Tue, 19 May 2020 13:14:19 +0200
Message-Id: <20200519111419.924170-1-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200519084812.GP188135@unreal>
References: <20200519084812.GP188135@unreal>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When Block Device Layer is disabled, BLK_MAX_SEGMENT_SIZE is undefined.
The rtrs is a transport library and should compile independently of the
block layer. The desired max segment size should be passed down by the
user.

Introduce max_segment_size parameter for the rtrs_clt_open() call.

Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Fixes: cb80329c9434 ("RDMA/rtrs: client: private header with client structs and functions")
Fixes: b5c27cdb094e ("RDMA/rtrs: public interface header to establish RDMA connections")

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
---
v1->v2 Add Fixes lines.

 drivers/block/rnbd/rnbd-clt.c          |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 17 +++++++++++------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
 drivers/infiniband/ulp/rtrs/rtrs.h     |  1 +
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 55bff3b1be71..450a571e6a1e 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1216,6 +1216,7 @@ find_and_get_or_create_sess(const char *sessname,
 				   paths, path_cnt, port_nr,
 				   sizeof(struct rnbd_iu),
 				   RECONNECT_DELAY, BMAX_SEGMENTS,
+				   BLK_MAX_SEGMENT_SIZE,
 				   MAX_RECONNECTS);
 	if (IS_ERR(sess->rtrs)) {
 		err = PTR_ERR(sess->rtrs);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 468fdd0d8713..b2e465ad4423 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -12,7 +12,6 @@
 
 #include <linux/module.h>
 #include <linux/rculist.h>
-#include <linux/blkdev.h> /* for BLK_MAX_SEGMENT_SIZE */
 
 #include "rtrs-clt.h"
 #include "rtrs-log.h"
@@ -1407,7 +1406,8 @@ static void rtrs_clt_close_work(struct work_struct *work);
 
 static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 					 const struct rtrs_addr *path,
-					 size_t con_num, u16 max_segments)
+					 size_t con_num, u16 max_segments,
+					 size_t max_segment_size)
 {
 	struct rtrs_clt_sess *sess;
 	int err = -ENOMEM;
@@ -1444,7 +1444,7 @@ static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 	strlcpy(sess->s.sessname, clt->sessname, sizeof(sess->s.sessname));
 	sess->s.con_num = con_num;
 	sess->clt = clt;
-	sess->max_pages_per_mr = max_segments * BLK_MAX_SEGMENT_SIZE >> 12;
+	sess->max_pages_per_mr = max_segments * max_segment_size >> 12;
 	init_waitqueue_head(&sess->state_wq);
 	sess->state = RTRS_CLT_CONNECTING;
 	atomic_set(&sess->connected_cnt, 0);
@@ -2530,6 +2530,7 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 				  void	(*link_ev)(void *priv,
 						   enum rtrs_clt_link_ev ev),
 				  unsigned int max_segments,
+				  size_t max_segment_size,
 				  unsigned int reconnect_delay_sec,
 				  unsigned int max_reconnect_attempts)
 {
@@ -2559,6 +2560,7 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 	clt->port = port;
 	clt->pdu_sz = pdu_sz;
 	clt->max_segments = max_segments;
+	clt->max_segment_size = max_segment_size;
 	clt->reconnect_delay_sec = reconnect_delay_sec;
 	clt->max_reconnect_attempts = max_reconnect_attempts;
 	clt->priv = priv;
@@ -2640,6 +2642,7 @@ static void free_clt(struct rtrs_clt *clt)
  * @pdu_sz: Size of extra payload which can be accessed after permit allocation.
  * @reconnect_delay_sec: time between reconnect tries
  * @max_segments: Max. number of segments per IO request
+ * @max_segment_size: Max. size of one segment
  * @max_reconnect_attempts: Number of times to reconnect on error before giving
  *			    up, 0 for * disabled, -1 for forever
  *
@@ -2654,6 +2657,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 				 size_t paths_num, u16 port,
 				 size_t pdu_sz, u8 reconnect_delay_sec,
 				 u16 max_segments,
+				 size_t max_segment_size,
 				 s16 max_reconnect_attempts)
 {
 	struct rtrs_clt_sess *sess, *tmp;
@@ -2662,7 +2666,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 
 	clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
 			ops->link_ev,
-			max_segments, reconnect_delay_sec,
+			max_segments, max_segment_size, reconnect_delay_sec,
 			max_reconnect_attempts);
 	if (IS_ERR(clt)) {
 		err = PTR_ERR(clt);
@@ -2672,7 +2676,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		struct rtrs_clt_sess *sess;
 
 		sess = alloc_sess(clt, &paths[i], nr_cpu_ids,
-				  max_segments);
+				  max_segments, max_segment_size);
 		if (IS_ERR(sess)) {
 			err = PTR_ERR(sess);
 			goto close_all_sess;
@@ -2921,7 +2925,8 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 	struct rtrs_clt_sess *sess;
 	int err;
 
-	sess = alloc_sess(clt, addr, nr_cpu_ids, clt->max_segments);
+	sess = alloc_sess(clt, addr, nr_cpu_ids, clt->max_segments,
+			  clt->max_segment_size);
 	if (IS_ERR(sess))
 		return PTR_ERR(sess);
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 039a2ebba2f9..167acd3c90fc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -164,6 +164,7 @@ struct rtrs_clt {
 	unsigned int		max_reconnect_attempts;
 	unsigned int		reconnect_delay_sec;
 	unsigned int		max_segments;
+	size_t			max_segment_size;
 	void			*permits;
 	unsigned long		*permits_map;
 	size_t			queue_depth;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index 9879d40467b6..9af750f4d783 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -58,6 +58,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 				 size_t path_cnt, u16 port,
 				 size_t pdu_sz, u8 reconnect_delay_sec,
 				 u16 max_segments,
+				 size_t max_segment_size,
 				 s16 max_reconnect_attempts);
 
 void rtrs_clt_close(struct rtrs_clt *sess);
-- 
2.25.1

