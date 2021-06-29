Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B013B6E66
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 08:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhF2Gzy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 02:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhF2Gzy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 02:55:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6A5C061574
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q14so29753435eds.5
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBRxRRZoYMjSvEWvj5G/ZD0nol7Dpgz8ughADCODhMk=;
        b=Y+2UQHrUGXMnqgdF4RNCs2mYH2YATNgLhYiKLBS40c7v96+x7JgkpCFvydMteJ98pM
         cekAdNgPoNlfxXSigdl3T+np/DKzlm0qek2lzMyFXGwp6Phgzg9SUgz1lEIQtf5b9A9t
         +fcyePSVeX76iJM5OSLK86VZGtuY/Ti48aZyvZOYaa0yi58mEUkYQNASfc/FXzdSNi2W
         ZAUjoOF4VfY9BGzJPKZUAifB0Vn9GaFTfOrKaLNnvNBOXrgb/D1Q9vDA35ECtshfhQQJ
         6msp2s9p/scxJzWVp63zL1dly198DpMkyPcphuswRrbNStmicxu2kdLxQMEdc/d6X6qB
         LaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBRxRRZoYMjSvEWvj5G/ZD0nol7Dpgz8ughADCODhMk=;
        b=WBYoaPGwGPvhjYMv81Cxk5PXmoRfwnvaoaT2UmLK42PhKufjXooT7legzznStu9KN8
         e9NbKo44NWYoXEdo48RDBgDznmb8K7M5XrVyR8zxrB7Jf0K0/pWD5uQeYJJpHgWZLZTV
         Y5ye5tdP2g4NJzEo5hI0OpCqxNp4qoIueLWUehZ3Tge2E6zP0KcPmQmdIp65WQFR9H1w
         dptNe57r5mykekbtPhsAJFzg6iL26WeP8dCs26deUbTVdEmCB+NIlb918IDgNzi0ylKZ
         XjqAE6De4XICzvELY59PwBqTBEO4Bl4TGX1zd5w2r5vFtJYTLPGfJnCfPK+fcVCc27Vb
         +3rA==
X-Gm-Message-State: AOAM531ut9hxuZSM+aqNUlBkH0c9hgPFV3N9bYC7Hs9txK4x+fHOoWkt
        zYacetNzjKywWONYJXVYlhQIXS2EXfK1BQ==
X-Google-Smtp-Source: ABdhPJx1T6e4FO3KGqJ3iRuDhbkdNDjpBn5pWu50qWqB1pIz1J1YOWxw5N8SuPQhhW0ZZbMzKoB2VQ==
X-Received: by 2002:a05:6402:b9e:: with SMTP id cf30mr38186559edb.47.1624949605512;
        Mon, 28 Jun 2021 23:53:25 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49c9:3e00:293f:8e14:7de3:8980])
        by smtp.gmail.com with ESMTPSA id t27sm7717853eje.86.2021.06.28.23.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:53:25 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 3/6] RDMA/rtrs: Enable the same selective signal for heartbeat and IO
Date:   Tue, 29 Jun 2021 08:53:18 +0200
Message-Id: <20210629065321.12600-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629065321.12600-1-jinpu.wang@ionos.com>
References: <20210629065321.12600-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On idle session, because we do not do signal for heartbeat, it will
overflow the send queue after sometime.

To avoid that, we need to enable the signal for heartbeat. To do that,
add a new member signal_interval in rtrs_path, which will set min of
queue_depth and SERVICE_CON_QUEUE_DEPTH, and track it for both heartbeat
and IO, so the sq queue full accounting is correct.

Fixes: b38041d50add ("RDMA/rtrs: Do not signal for heatbeat")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  7 +++++--
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 11 ++++++-----
 drivers/infiniband/ulp/rtrs/rtrs.c     |  7 ++++++-
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 5cb00ea08919..f023676e05e4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -478,7 +478,7 @@ static int rtrs_post_send_rdma(struct rtrs_clt_con *con,
 	 * From time to time we have to post signalled sends,
 	 * or send queue will fill up and only QP reset can help.
 	 */
-	flags = atomic_inc_return(&con->c.wr_cnt) % sess->queue_depth ?
+	flags = atomic_inc_return(&con->c.wr_cnt) % sess->s.signal_interval ?
 			0 : IB_SEND_SIGNALED;
 
 	ib_dma_sync_single_for_device(sess->s.dev->ib_dev, req->iu->dma_addr,
@@ -680,6 +680,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 	case IB_WC_RDMA_WRITE:
 		/*
 		 * post_send() RDMA write completions of IO reqs (read/write)
+		 * and hb.
 		 */
 		break;
 
@@ -1043,7 +1044,7 @@ static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
 	 * From time to time we have to post signalled sends,
 	 * or send queue will fill up and only QP reset can help.
 	 */
-	flags = atomic_inc_return(&con->c.wr_cnt) % sess->queue_depth ?
+	flags = atomic_inc_return(&con->c.wr_cnt) % sess->s.signal_interval ?
 			0 : IB_SEND_SIGNALED;
 
 	ib_dma_sync_single_for_device(sess->s.dev->ib_dev, req->iu->dma_addr,
@@ -1849,6 +1850,8 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 				return -ENOMEM;
 		}
 		sess->queue_depth = queue_depth;
+		sess->s.signal_interval = min_not_zero(queue_depth,
+						(unsigned short) SERVICE_CON_QUEUE_DEPTH);
 		sess->max_hdr_size = le32_to_cpu(msg->max_hdr_size);
 		sess->max_io_size = le32_to_cpu(msg->max_io_size);
 		sess->flags = le32_to_cpu(msg->flags);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index a44a4fb1b515..b88a4944cb30 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -109,6 +109,7 @@ struct rtrs_sess {
 	unsigned int		con_num;
 	unsigned int		irq_con_num;
 	unsigned int		recon_cnt;
+	unsigned int		signal_interval;
 	struct rtrs_ib_dev	*dev;
 	int			dev_ref;
 	struct ib_cqe		*hb_cqe;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 31b846ca0c5e..44ed15f38896 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -201,7 +201,6 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
 	dma_addr_t dma_addr = sess->dma_addr[id->msg_id];
 	struct rtrs_srv_mr *srv_mr;
-	struct rtrs_srv *srv = sess->srv;
 	struct ib_send_wr inv_wr;
 	struct ib_rdma_wr imm_wr;
 	struct ib_rdma_wr *wr = NULL;
@@ -269,7 +268,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	 * From time to time we have to post signaled sends,
 	 * or send queue will fill up and only QP reset can help.
 	 */
-	flags = (atomic_inc_return(&id->con->c.wr_cnt) % srv->queue_depth) ?
+	flags = (atomic_inc_return(&id->con->c.wr_cnt) % s->signal_interval) ?
 		0 : IB_SEND_SIGNALED;
 
 	if (need_inval) {
@@ -347,7 +346,6 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 	struct ib_send_wr inv_wr, *wr = NULL;
 	struct ib_rdma_wr imm_wr;
 	struct ib_reg_wr rwr;
-	struct rtrs_srv *srv = sess->srv;
 	struct rtrs_srv_mr *srv_mr;
 	bool need_inval = false;
 	enum ib_send_flags flags;
@@ -396,7 +394,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 	 * From time to time we have to post signalled sends,
 	 * or send queue will fill up and only QP reset can help.
 	 */
-	flags = (atomic_inc_return(&con->c.wr_cnt) % srv->queue_depth) ?
+	flags = (atomic_inc_return(&con->c.wr_cnt) % s->signal_interval) ?
 		0 : IB_SEND_SIGNALED;
 	imm = rtrs_to_io_rsp_imm(id->msg_id, errno, need_inval);
 	imm_wr.wr.next = NULL;
@@ -1268,8 +1266,9 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 	case IB_WC_SEND:
 		/*
 		 * post_send() RDMA write completions of IO reqs (read/write)
+		 * and hb.
 		 */
-		atomic_add(srv->queue_depth, &con->sq_wr_avail);
+		atomic_add(s->signal_interval, &con->sq_wr_avail);
 
 		if (unlikely(!list_empty_careful(&con->rsp_wr_wait_list)))
 			rtrs_rdma_process_wr_wait_list(con);
@@ -1659,6 +1658,8 @@ static int create_con(struct rtrs_srv_sess *sess,
 		max_send_wr = min_t(int, wr_limit,
 				    SERVICE_CON_QUEUE_DEPTH * 2 + 2);
 		max_recv_wr = max_send_wr;
+		s->signal_interval = min_not_zero(srv->queue_depth,
+						  (size_t)SERVICE_CON_QUEUE_DEPTH);
 	} else {
 		/* when always_invlaidate enalbed, we need linv+rinv+mr+imm */
 		if (always_invalidate)
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 870b21f551a4..7f2dfb9d11fc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -187,10 +187,15 @@ int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
 				    struct ib_send_wr *head)
 {
 	struct ib_rdma_wr wr;
+	struct rtrs_sess *sess = con->sess;
+	enum ib_send_flags sflags;
+
+	sflags = (atomic_inc_return(&con->wr_cnt) % sess->signal_interval) ?
+		0 : IB_SEND_SIGNALED;
 
 	wr = (struct ib_rdma_wr) {
 		.wr.wr_cqe	= cqe,
-		.wr.send_flags	= flags,
+		.wr.send_flags	= sflags,
 		.wr.opcode	= IB_WR_RDMA_WRITE_WITH_IMM,
 		.wr.ex.imm_data	= cpu_to_be32(imm_data),
 	};
-- 
2.25.1

