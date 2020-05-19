Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A3B1D9196
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 10:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgESIDR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 04:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgESIDQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 04:03:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6A1C05BD0A
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 01:03:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so14788552wrt.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BId8hISg7s9csDflvenBQTsQbDpnhw42cMQmmFngrIs=;
        b=XuwqGHUL19VqxJ9B+AAIsOwkfu1MxpyMU7DTse6WI2hyV6dOMkZ1D9CAp1jqAfYTn6
         RSAnVkEO7vsW6gRRuWh7TKGUgAS7BJ/ERkvrSa8tSFFO9c2jFfKbiWC7d8yuuu5/+Ss7
         nhfYyurt2U/O4/e6hxQc57hGhEYsscocKoosOVgHxng9agrUGMmY/IV9Bz5yMXu3ChTz
         n8OWC0X0xXb1J1nbKbUUiTComdOAcSIRjqw42/Xxo034D6IxqVDARvPcxSER5s3XiuMC
         +57Ja5sJIxQHKyIYWNM0nINxNsvdz4rrnQ4Kfx2uGbSa/E6DilTfYdLHiaf5QiukH66Y
         0iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BId8hISg7s9csDflvenBQTsQbDpnhw42cMQmmFngrIs=;
        b=lWuDMGrJtXt08/BKkAgzU2whM+OJt/pZfLnZOxQYw+QvGl0ByVStdhN8VXaBOIeP3i
         V4jQQw837n7qJ+GX2m/choXUHBaTGhee9JkYmPZU6rUvhNYBNeNLGccic/Elz9Wna+yq
         beWyV0sRvLgKyPJrNra0THtrNC6HQ2ZkBkTtQ7q6bPhfuXza9B1kjlnDybhmRtAPtkw4
         DxmKPDhvG0Pq+WHWmZd8AzPb8zozh5/agVf6TwYxbSNHJP45O24U43uMeKnJSBPFFEbH
         bz9DBRkj/bAqdNyAN1rNjJ3dTSt/DfTaSg1IuAC1X+2jO1SoVTbBjPyHiVturHfkKiPa
         8y7g==
X-Gm-Message-State: AOAM533dLJGwpQCgIhOkJBFza2pQjj1tkO82q1nBEU5PLREqtCcfVBqi
        3tlTEAdqgwOZDBJ2Ka9gm7QLzhEuJCgP9Fk=
X-Google-Smtp-Source: ABdhPJwUAYicBzIAHIFMocrzhz5ZQRCD5UiUd/x1Dap5/S3HkeiVnjuHFfnDJbKyOeLJNQUhBY4q+Q==
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr24757706wrn.266.1589875393543;
        Tue, 19 May 2020 01:03:13 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id g10sm18915386wrx.4.2020.05.19.01.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 01:03:12 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca,
        linux-next@vger.kernel.org
Cc:     jinpu.wang@cloud.ionos.com, dledford@redhat.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, bvanassche@acm.org,
        rdunlap@infradead.org, leon@kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Subject: [PATCH 1/1] rnbd/rtrs: pass max segment size from blk user to the rdma library
Date:   Tue, 19 May 2020 10:01:36 +0200
Message-Id: <20200519080136.885628-2-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200519080136.885628-1-danil.kipnis@cloud.ionos.com>
References: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
 <20200519080136.885628-1-danil.kipnis@cloud.ionos.com>
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

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
---
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
index 0fa3a229d90e..59a36831927b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -12,7 +12,6 @@
 
 #include <linux/module.h>
 #include <linux/rculist.h>
-#include <linux/blkdev.h> /* for BLK_MAX_SEGMENT_SIZE */
 
 #include "rtrs-clt.h"
 #include "rtrs-log.h"
@@ -1408,7 +1407,8 @@ static void rtrs_clt_close_work(struct work_struct *work);
 
 static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 					 const struct rtrs_addr *path,
-					 size_t con_num, u16 max_segments)
+					 size_t con_num, u16 max_segments,
+					 size_t max_segment_size)
 {
 	struct rtrs_clt_sess *sess;
 	int err = -ENOMEM;
@@ -1445,7 +1445,7 @@ static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 	strlcpy(sess->s.sessname, clt->sessname, sizeof(sess->s.sessname));
 	sess->s.con_num = con_num;
 	sess->clt = clt;
-	sess->max_pages_per_mr = max_segments * BLK_MAX_SEGMENT_SIZE >> 12;
+	sess->max_pages_per_mr = max_segments * max_segment_size >> 12;
 	init_waitqueue_head(&sess->state_wq);
 	sess->state = RTRS_CLT_CONNECTING;
 	atomic_set(&sess->connected_cnt, 0);
@@ -2531,6 +2531,7 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 				  void	(*link_ev)(void *priv,
 						   enum rtrs_clt_link_ev ev),
 				  unsigned int max_segments,
+				  size_t max_segment_size,
 				  unsigned int reconnect_delay_sec,
 				  unsigned int max_reconnect_attempts)
 {
@@ -2560,6 +2561,7 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 	clt->port = port;
 	clt->pdu_sz = pdu_sz;
 	clt->max_segments = max_segments;
+	clt->max_segment_size = max_segment_size;
 	clt->reconnect_delay_sec = reconnect_delay_sec;
 	clt->max_reconnect_attempts = max_reconnect_attempts;
 	clt->priv = priv;
@@ -2641,6 +2643,7 @@ static void free_clt(struct rtrs_clt *clt)
  * @pdu_sz: Size of extra payload which can be accessed after permit allocation.
  * @reconnect_delay_sec: time between reconnect tries
  * @max_segments: Max. number of segments per IO request
+ * @max_segment_size: Max. size of one segment
  * @max_reconnect_attempts: Number of times to reconnect on error before giving
  *			    up, 0 for * disabled, -1 for forever
  *
@@ -2655,6 +2658,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 				 size_t paths_num, u16 port,
 				 size_t pdu_sz, u8 reconnect_delay_sec,
 				 u16 max_segments,
+				 size_t max_segment_size,
 				 s16 max_reconnect_attempts)
 {
 	struct rtrs_clt_sess *sess, *tmp;
@@ -2663,7 +2667,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 
 	clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
 			ops->link_ev,
-			max_segments, reconnect_delay_sec,
+			max_segments, max_segment_size, reconnect_delay_sec,
 			max_reconnect_attempts);
 	if (IS_ERR(clt)) {
 		err = PTR_ERR(clt);
@@ -2673,7 +2677,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		struct rtrs_clt_sess *sess;
 
 		sess = alloc_sess(clt, &paths[i], nr_cpu_ids,
-				  max_segments);
+				  max_segments, max_segment_size);
 		if (IS_ERR(sess)) {
 			err = PTR_ERR(sess);
 			goto close_all_sess;
@@ -2923,7 +2927,8 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
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

