Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783433C43D7
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 08:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhGLGKn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 02:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhGLGKm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jul 2021 02:10:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F81C0613E5
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 23:07:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id w13so10572792wmc.3
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 23:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6cH6Z7wdQumqLb7ZmTrwNtl31imikISuzvWrMPXUmQ=;
        b=BVerEYq8OQfjANGW0tgiVL7PVX/AbkaJn9pd3yYaYTw4T4OaVf9eJGJScVcvHzz72T
         jfklMiEgbeO13Rikk0T+qiAoCKHDyG5ZBEKKA5me/e2YzKoXYVygTWe97u5efabmIbaV
         b786C+3hRUMmq+sHrBXvwUBByIcuTusZDqgV9GnR5KdhOKkr18BzwTkyWOWZU2bO17hA
         /Gy3oQGgaIx6LUWzEmz9B/i406Pbfi8RtdZovGFxG6ZN9p48MukdxpGikdtFJZkALgev
         Wb0cMxWfZZnVMI34fZsAIn/MWFzyjHVDhw28ShG9+KELXKpE9XgfHhHdsn2zJcP5ypv+
         8c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6cH6Z7wdQumqLb7ZmTrwNtl31imikISuzvWrMPXUmQ=;
        b=k7seDK6fJ38ZSLzBKbYXbHGdFx7ASMJjbnJ0NlUggVj5c41AZptT+hKJU4FhysgwMo
         /q6AM36KkQx0NQGGnmyTmgVH/bA3NziGBu73KS3Hfp564n3hmllPgDRSdJQTno4yOuJJ
         1jUST3Pz/I7iV6vwqJJGJyNgSXHZkCv33rU+R54S4WpG25OQwn24gWml7blkJ492hFSo
         iK+M3u4lUPHfk0/QdkrgE18TyuJKKx4CvsC1nTbfDcdOi0D7Kv0kgpS8v+Xr69s5LsrT
         kUZPiwnrAOaxpxhQ5k8JosLqdGXdg7i3IRvqP5g1I+Ko9b28393rJurrT1KXHspCIqW6
         CWYw==
X-Gm-Message-State: AOAM5337HHiy79eOe7/gmbap8TTkbSEfnftKbxJ7skcpmWthRtCxmWki
        ECYRzTSC/yVDZWcj13PEIf7BrQ1yArzLQA==
X-Google-Smtp-Source: ABdhPJwu3LKx9SbGsQhU9S2cJm33hDo7RWZT0ReSyaAeDPzKK0I/bK+5lmnsXNQx3n1Dm8QaypWOsw==
X-Received: by 2002:a05:600c:2907:: with SMTP id i7mr12561746wmd.184.1626070073376;
        Sun, 11 Jul 2021 23:07:53 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49bc:8600:895c:e529:e1b8:7823])
        by smtp.gmail.com with ESMTPSA id s17sm13344245wrv.2.2021.07.11.23.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 23:07:53 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-rc 2/6] RDMA/rtrs: move wr_cnt from rtrs_srv_con to rtrs_con
Date:   Mon, 12 Jul 2021 08:07:46 +0200
Message-Id: <20210712060750.16494-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210712060750.16494-1-jinpu.wang@ionos.com>
References: <20210712060750.16494-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We need to track also the wr used for heatbeat. This is
a preparation for that, will be used in later patch.

The io_cnt in rtrs_clt is removed, use wr_cnt instead.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h | 1 -
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 6 +++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.h | 1 -
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index f2c40e50f25e..5cb00ea08919 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -478,7 +478,7 @@ static int rtrs_post_send_rdma(struct rtrs_clt_con *con,
 	 * From time to time we have to post signalled sends,
 	 * or send queue will fill up and only QP reset can help.
 	 */
-	flags = atomic_inc_return(&con->io_cnt) % sess->queue_depth ?
+	flags = atomic_inc_return(&con->c.wr_cnt) % sess->queue_depth ?
 			0 : IB_SEND_SIGNALED;
 
 	ib_dma_sync_single_for_device(sess->s.dev->ib_dev, req->iu->dma_addr,
@@ -1043,7 +1043,7 @@ static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
 	 * From time to time we have to post signalled sends,
 	 * or send queue will fill up and only QP reset can help.
 	 */
-	flags = atomic_inc_return(&con->io_cnt) % sess->queue_depth ?
+	flags = atomic_inc_return(&con->c.wr_cnt) % sess->queue_depth ?
 			0 : IB_SEND_SIGNALED;
 
 	ib_dma_sync_single_for_device(sess->s.dev->ib_dev, req->iu->dma_addr,
@@ -1601,7 +1601,8 @@ static int create_con(struct rtrs_clt_sess *sess, unsigned int cid)
 	con->cpu  = (cid ? cid - 1 : 0) % nr_cpu_ids;
 	con->c.cid = cid;
 	con->c.sess = &sess->s;
-	atomic_set(&con->io_cnt, 0);
+	/* Align with srv, init as 1 */
+	atomic_set(&con->c.wr_cnt, 1);
 	mutex_init(&con->con_mutex);
 
 	sess->s.con[cid] = &con->c;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index e276a2dfcf7c..3c3ff094588c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -74,7 +74,6 @@ struct rtrs_clt_con {
 	u32			queue_num;
 	unsigned int		cpu;
 	struct mutex		con_mutex;
-	atomic_t		io_cnt;
 	int			cm_err;
 };
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 36f184a3b676..a44a4fb1b515 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -96,6 +96,7 @@ struct rtrs_con {
 	struct rdma_cm_id	*cm_id;
 	unsigned int		cid;
 	int                     nr_cqe;
+	atomic_t		wr_cnt;
 };
 
 struct rtrs_sess {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 3df290086169..31b846ca0c5e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -269,7 +269,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	 * From time to time we have to post signaled sends,
 	 * or send queue will fill up and only QP reset can help.
 	 */
-	flags = (atomic_inc_return(&id->con->wr_cnt) % srv->queue_depth) ?
+	flags = (atomic_inc_return(&id->con->c.wr_cnt) % srv->queue_depth) ?
 		0 : IB_SEND_SIGNALED;
 
 	if (need_inval) {
@@ -396,7 +396,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 	 * From time to time we have to post signalled sends,
 	 * or send queue will fill up and only QP reset can help.
 	 */
-	flags = (atomic_inc_return(&con->wr_cnt) % srv->queue_depth) ?
+	flags = (atomic_inc_return(&con->c.wr_cnt) % srv->queue_depth) ?
 		0 : IB_SEND_SIGNALED;
 	imm = rtrs_to_io_rsp_imm(id->msg_id, errno, need_inval);
 	imm_wr.wr.next = NULL;
@@ -1648,7 +1648,7 @@ static int create_con(struct rtrs_srv_sess *sess,
 	con->c.cm_id = cm_id;
 	con->c.sess = &sess->s;
 	con->c.cid = cid;
-	atomic_set(&con->wr_cnt, 1);
+	atomic_set(&con->c.wr_cnt, 1);
 	wr_limit = sess->s.dev->ib_dev->attrs.max_qp_wr;
 
 	if (con->c.cid == 0) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index f8da2e3f0bda..6785c3b6363e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -42,7 +42,6 @@ struct rtrs_srv_stats {
 
 struct rtrs_srv_con {
 	struct rtrs_con		c;
-	atomic_t		wr_cnt;
 	atomic_t		sq_wr_avail;
 	struct list_head	rsp_wr_wait_list;
 	spinlock_t		rsp_wr_wait_lock;
-- 
2.25.1

