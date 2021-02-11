Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA2E318576
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 07:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhBKG4j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 01:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhBKG4K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 01:56:10 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0018BC06174A
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 22:55:29 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id w1so8329291ejf.11
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 22:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=saWY5GASALjPbmyhoF8udsOtRJK9w83GiDPFZZu1Gsc=;
        b=EZSZ+BySUS6ytHnxJ/L4N0GP/c72G/I5jYg3cg72pZRQm+LgjfoPUYWJkJFue/wX0V
         XbnF0bzHNb6VfZsR7xbkcjePDj48YHPkYwONHCPBKlYmLiyuDqdxwBesd2iqoXYiupap
         uenp3981bp6LKTkqas6+3rX2P9qX921XdbE0oJauO0LQQXKyu3SDBcEIQGdUG8FGUe0b
         JpbKfd70lHCr51XpA3QDh9hhKFBpV4ila8ZVhtO2EmH1zh2mS+kGJU3nmvrPfnYzh4II
         Q9ip9hHHl0Gu5aInfhaFthCd3JUwjapXr/RGkPENDo7MBNn94UB6R7tUfXrpL/sL4pHA
         PwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saWY5GASALjPbmyhoF8udsOtRJK9w83GiDPFZZu1Gsc=;
        b=ARqF9a0yUzcx5+hm9x6kqPmeh8NUhIXl24mpNzXYJLNXvSEXtNKazkw/YhSjnZo3Qp
         yo6MI8H7OX22tceh5LwO5Wk7aXs4BO3/1wyIYD2cMDt99Xb4V2ektJgy6wXAr/Q7Amcm
         nEdi8aiG6F9KRSXvLVTjln7Lsix3ABB1HPdTe1pTGLRGBhuI4gwErQBfpkRZH6p1idnB
         sFmzWEdtLn3w5YPm75rUX7cp5JLEynRJo8QmQ6t62HZuxVikioTZBRPQkvy6Y38XjVkC
         fzjkMuqm8xu/x94vYyJCP1heW9lStTjqe+g/YRl2JMz90nPAmp2jJTqyxOJhoweGhA7P
         iZ0A==
X-Gm-Message-State: AOAM530spppu2uqt1aj3ronmxbPp8KAC0knE/DgWmRlMMXEorMeWIjsk
        z3uvpBF1Uo4CQMV+TyqqmWGUuIIfnSTqWQ==
X-Google-Smtp-Source: ABdhPJwi0nlaYhaivOzYDpEuDUURI0ACHrZ2Z4AHf0XZG+fxBkg4kLS8Xja5sLJ3v4Itmv9ZWxpksA==
X-Received: by 2002:a17:906:688f:: with SMTP id n15mr6808529ejr.71.1613026528405;
        Wed, 10 Feb 2021 22:55:28 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49a6:4a00:4d27:617f:73f7:3a8b])
        by smtp.gmail.com with ESMTPSA id v9sm3241486ejd.92.2021.02.10.22.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 22:55:28 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 1/4] RDMA/rtrs-srv: Fix BUG: KASAN: stack-out-of-bounds
Date:   Thu, 11 Feb 2021 07:55:23 +0100
Message-Id: <20210211065526.7510-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
References: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[  125.352752] ==================================================================
[  125.353122] BUG: KASAN: stack-out-of-bounds in _mlx4_ib_post_send+0x1bd2/0x2770 [mlx4_ib]
[  125.353337] Read of size 4 at addr ffff8880d5a7f980 by task kworker/0:1H/565

[  125.353655] CPU: 0 PID: 565 Comm: kworker/0:1H Tainted: G           O      5.4.84-storage #5.4.84-1+feature+linux+5.4.y+dbg+20201216.1319+b6b887b~deb10
[  125.353924] Hardware name: Supermicro H8QG6/H8QG6, BIOS 3.00       09/04/2012
[  125.354144] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
[  125.354317] Call Trace:
[  125.354531]  dump_stack+0x96/0xe0
[  125.354715]  print_address_description.constprop.4+0x1f/0x300
[  125.354943]  ? irq_work_claim+0x2e/0x50
[  125.355129]  __kasan_report.cold.8+0x78/0x92
[  125.355334]  ? _mlx4_ib_post_send+0x1bd2/0x2770 [mlx4_ib]
[  125.355545]  kasan_report+0x10/0x20
[  125.355730]  _mlx4_ib_post_send+0x1bd2/0x2770 [mlx4_ib]
[  125.355930]  ? check_chain_key+0x1d7/0x2e0
[  125.356203]  ? _mlx4_ib_post_recv+0x630/0x630 [mlx4_ib]
[  125.356399]  ? lockdep_hardirqs_on+0x1a8/0x290
[  125.356595]  ? stack_depot_save+0x218/0x56e
[  125.356781]  ? do_profile_hits.isra.6.cold.13+0x1d/0x1d
[  125.356973]  ? check_chain_key+0x1d7/0x2e0
[  125.357174]  ? save_stack+0x4d/0x80
[  125.357374]  ? save_stack+0x19/0x80
[  125.357547]  ? __kasan_slab_free+0x125/0x170
[  125.357728]  ? kfree+0xe7/0x3b0
[  125.357899]  rdma_write_sg+0x5b0/0x950 [rtrs_server]

The problem is when we send imm_wr, the type should be ib_rdma_wr, so
hw driver like mlx4 can do rdma_wr(wr), so fix it by use the ib_rdma_wr
as type for imm_wr.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 64 +++++++++++++-------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 918f1cf140cd..e13e91c2a44a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -222,7 +222,8 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	dma_addr_t dma_addr = sess->dma_addr[id->msg_id];
 	struct rtrs_srv_mr *srv_mr;
 	struct rtrs_srv *srv = sess->srv;
-	struct ib_send_wr inv_wr, imm_wr;
+	struct ib_send_wr inv_wr;
+	struct ib_rdma_wr imm_wr;
 	struct ib_rdma_wr *wr = NULL;
 	enum ib_send_flags flags;
 	size_t sg_cnt;
@@ -274,15 +275,15 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	if (need_inval && always_invalidate) {
 		wr->wr.next = &rwr.wr;
 		rwr.wr.next = &inv_wr;
-		inv_wr.next = &imm_wr;
+		inv_wr.next = &imm_wr.wr;
 	} else if (always_invalidate) {
 		wr->wr.next = &rwr.wr;
-		rwr.wr.next = &imm_wr;
+		rwr.wr.next = &imm_wr.wr;
 	} else if (need_inval) {
 		wr->wr.next = &inv_wr;
-		inv_wr.next = &imm_wr;
+		inv_wr.next = &imm_wr.wr;
 	} else {
-		wr->wr.next = &imm_wr;
+		wr->wr.next = &imm_wr.wr;
 	}
 	/*
 	 * From time to time we have to post signaled sends,
@@ -300,7 +301,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 		inv_wr.ex.invalidate_rkey = rkey;
 	}
 
-	imm_wr.next = NULL;
+	imm_wr.wr.next = NULL;
 	if (always_invalidate) {
 		struct rtrs_msg_rkey_rsp *msg;
 
@@ -321,22 +322,22 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 		list.addr   = srv_mr->iu->dma_addr;
 		list.length = sizeof(*msg);
 		list.lkey   = sess->s.dev->ib_pd->local_dma_lkey;
-		imm_wr.sg_list = &list;
-		imm_wr.num_sge = 1;
-		imm_wr.opcode = IB_WR_SEND_WITH_IMM;
+		imm_wr.wr.sg_list = &list;
+		imm_wr.wr.num_sge = 1;
+		imm_wr.wr.opcode = IB_WR_SEND_WITH_IMM;
 		ib_dma_sync_single_for_device(sess->s.dev->ib_dev,
 					      srv_mr->iu->dma_addr,
 					      srv_mr->iu->size, DMA_TO_DEVICE);
 	} else {
-		imm_wr.sg_list = NULL;
-		imm_wr.num_sge = 0;
-		imm_wr.opcode = IB_WR_RDMA_WRITE_WITH_IMM;
+		imm_wr.wr.sg_list = NULL;
+		imm_wr.wr.num_sge = 0;
+		imm_wr.wr.opcode = IB_WR_RDMA_WRITE_WITH_IMM;
 	}
-	imm_wr.send_flags = flags;
-	imm_wr.ex.imm_data = cpu_to_be32(rtrs_to_io_rsp_imm(id->msg_id,
+	imm_wr.wr.send_flags = flags;
+	imm_wr.wr.ex.imm_data = cpu_to_be32(rtrs_to_io_rsp_imm(id->msg_id,
 							     0, need_inval));
 
-	imm_wr.wr_cqe   = &io_comp_cqe;
+	imm_wr.wr.wr_cqe   = &io_comp_cqe;
 	ib_dma_sync_single_for_device(sess->s.dev->ib_dev, dma_addr,
 				      offset, DMA_BIDIRECTIONAL);
 
@@ -363,7 +364,8 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 {
 	struct rtrs_sess *s = con->c.sess;
 	struct rtrs_srv_sess *sess = to_srv_sess(s);
-	struct ib_send_wr inv_wr, imm_wr, *wr = NULL;
+	struct ib_send_wr inv_wr, *wr = NULL;
+	struct ib_rdma_wr imm_wr;
 	struct ib_reg_wr rwr;
 	struct rtrs_srv *srv = sess->srv;
 	struct rtrs_srv_mr *srv_mr;
@@ -400,15 +402,15 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 	if (need_inval && always_invalidate) {
 		wr = &inv_wr;
 		inv_wr.next = &rwr.wr;
-		rwr.wr.next = &imm_wr;
+		rwr.wr.next = &imm_wr.wr;
 	} else if (always_invalidate) {
 		wr = &rwr.wr;
-		rwr.wr.next = &imm_wr;
+		rwr.wr.next = &imm_wr.wr;
 	} else if (need_inval) {
 		wr = &inv_wr;
-		inv_wr.next = &imm_wr;
+		inv_wr.next = &imm_wr.wr;
 	} else {
-		wr = &imm_wr;
+		wr = &imm_wr.wr;
 	}
 	/*
 	 * From time to time we have to post signalled sends,
@@ -417,13 +419,13 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 	flags = (atomic_inc_return(&con->wr_cnt) % srv->queue_depth) ?
 		0 : IB_SEND_SIGNALED;
 	imm = rtrs_to_io_rsp_imm(id->msg_id, errno, need_inval);
-	imm_wr.next = NULL;
+	imm_wr.wr.next = NULL;
 	if (always_invalidate) {
 		struct ib_sge list;
 		struct rtrs_msg_rkey_rsp *msg;
 
 		srv_mr = &sess->mrs[id->msg_id];
-		rwr.wr.next = &imm_wr;
+		rwr.wr.next = &imm_wr.wr;
 		rwr.wr.opcode = IB_WR_REG_MR;
 		rwr.wr.wr_cqe = &local_reg_cqe;
 		rwr.wr.num_sge = 0;
@@ -440,21 +442,21 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 		list.addr   = srv_mr->iu->dma_addr;
 		list.length = sizeof(*msg);
 		list.lkey   = sess->s.dev->ib_pd->local_dma_lkey;
-		imm_wr.sg_list = &list;
-		imm_wr.num_sge = 1;
-		imm_wr.opcode = IB_WR_SEND_WITH_IMM;
+		imm_wr.wr.sg_list = &list;
+		imm_wr.wr.num_sge = 1;
+		imm_wr.wr.opcode = IB_WR_SEND_WITH_IMM;
 		ib_dma_sync_single_for_device(sess->s.dev->ib_dev,
 					      srv_mr->iu->dma_addr,
 					      srv_mr->iu->size, DMA_TO_DEVICE);
 	} else {
-		imm_wr.sg_list = NULL;
-		imm_wr.num_sge = 0;
-		imm_wr.opcode = IB_WR_RDMA_WRITE_WITH_IMM;
+		imm_wr.wr.sg_list = NULL;
+		imm_wr.wr.num_sge = 0;
+		imm_wr.wr.opcode = IB_WR_RDMA_WRITE_WITH_IMM;
 	}
-	imm_wr.send_flags = flags;
-	imm_wr.wr_cqe   = &io_comp_cqe;
+	imm_wr.wr.send_flags = flags;
+	imm_wr.wr.wr_cqe   = &io_comp_cqe;
 
-	imm_wr.ex.imm_data = cpu_to_be32(imm);
+	imm_wr.wr.ex.imm_data = cpu_to_be32(imm);
 
 	err = ib_post_send(id->con->c.qp, wr, NULL);
 	if (unlikely(err))
-- 
2.25.1

