Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667B03B6E6A
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 08:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhF2Gzx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 02:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhF2Gzx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 02:55:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF93C061574
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id c17so8557619ejk.13
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6cH6Z7wdQumqLb7ZmTrwNtl31imikISuzvWrMPXUmQ=;
        b=Kjb1gPpV5sGLqfz2Y2Yi8Flz7HIQb8Rh3cBXpHUu7UJyaoBPD6hjy+T7fXxP7W0xkq
         fG6CsZuIluCZcp6H9O7vnvoXesY7lqJPfqo4f1tDvrNnfS8/T3qo/NFq/bnj8HbQg9nz
         XlnklYiUMjCIh5G8DK3HOsHJVst5o/Q/NV2WJNRahVPm83hNGRdBcDQwAo/1scp27wTe
         9G68ec0tts/CYjtm8HhbBpeP5MGmSObdoloby6MdN/lukOcmkdTveSUFVc9Xi3Ez5cc6
         oUEUHfBtRb0GgRUzeXL6XAMUIdQJ5Hg0c9qocxh9eO8sMm/a6L0eWFnz2I/Bmi4YTaCq
         Mj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6cH6Z7wdQumqLb7ZmTrwNtl31imikISuzvWrMPXUmQ=;
        b=IK0LS57JVT+ppHII5mgdM6AaDckjtH1HDBzmRdboHnXxF6+t8+ygpzyTprRhP+VJlt
         iqvZRbH77qsyPl4tcUi3U0tdEQr1u4tw/SCvXU34lHsV9ky+9L0aaV8qPrGzXcbhqSm1
         MW5z841fQEGErNgWfiYG15BMhzC/1hetuOUrozEcFr3BdHAAk5a2E/NIvmoo3qc6Hl4M
         PRh5V797BjS5giFv/Ui9QJaVJqsgfAOTdZS75W6EhQtXxAmbLFl7e7E3LHu68n4umvKY
         X32rT1x0fSx2RS7uHgV9VyAF2DgY+zsCLKqBXhV9YtkhLhF1NwB7mB8oi+BXgq+GFCB2
         2IHw==
X-Gm-Message-State: AOAM532dvFaBmKYS0WN5Nlbcd6sttxjlkYQUvZWxZPXKG+Y9t4SLDuLR
        5ILbOQQA0a3/344mN/RTvQMEFp+3Pp5kHw==
X-Google-Smtp-Source: ABdhPJwz+i2uPISsAYydGt0Dn/LZzC1lKeCLEdhLzRH71jCjIAc5gCfPgpceqfwC6Ndzq5PcePx4sQ==
X-Received: by 2002:a17:906:c2ca:: with SMTP id ch10mr28355575ejb.305.1624949604710;
        Mon, 28 Jun 2021 23:53:24 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49c9:3e00:293f:8e14:7de3:8980])
        by smtp.gmail.com with ESMTPSA id t27sm7717853eje.86.2021.06.28.23.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:53:24 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 2/6] RDMA/rtrs: move wr_cnt from rtrs_srv_con to rtrs_con
Date:   Tue, 29 Jun 2021 08:53:17 +0200
Message-Id: <20210629065321.12600-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629065321.12600-1-jinpu.wang@ionos.com>
References: <20210629065321.12600-1-jinpu.wang@ionos.com>
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

