Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48063B6E69
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 08:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhF2Gz4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 02:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhF2Gz4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 02:55:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D79EC061574
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id c17so8557859ejk.13
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VInWHDB2M54SAf2pi/ohFQ/fjdS46jXhiC35qkGExsU=;
        b=JuvnF+YlcFip2sz1zpc31VjAzrQimerZtxnnP9rhmn+nVbmgopd2yNwiFTiOtub/d2
         1QGTx+MWlYbz5IejntMrd++RXea7SHr7VATdnbsuMJKmBZ3JuQjUYzZOSSlbqKnG5atz
         gMIn9UnUzoKtWmVZqp2Gz67QHiaEND4Og3SPg58HP4QJe15FQAF7XTxYEueQEQmacium
         T95Gy8zbMQ5cHZvmW/ZRIY9v5mdw0nEdmn2TnTVBbZD/D0GDQIzAeAwPKxxkjjyiXGym
         O/s8KnvfRh3WY9/lCkvO9wSTgCz5pbHEN1z6llWUK+AxojHTAReMY0xVkdGOJ9O/7A09
         HkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VInWHDB2M54SAf2pi/ohFQ/fjdS46jXhiC35qkGExsU=;
        b=IFw2AUEY1Xe9twAFxqFIL0U0EVzTcChzfvPEylKPWOqHdwicigzpVqPg/R9zoKCeQw
         4viNgb1m7v/gnAYOWKff7La5hcBnsHYrjx9SxKxsgKyPvJ7wUMEHm9lG5VOvbzQX1mJH
         bjU3DspwTpgyOPst/Un6UZyKH+ka2IQLY5FXd6f3PQX1Qlrlii71hC4HyDSYx6M6wBG4
         Pbta4rAjGShAsJDiXb88NH4eV1O1M07FdAoOQtJxRIaQD9aSVkGOwKykLXTNpET3zput
         GyB6jnGY2o1bVdWHc6khrI1AlPt2Ar+tROo5e14ZR+NjwZxjLW1tLUwD42omVPXZNGZr
         uAJw==
X-Gm-Message-State: AOAM5302iY5XY8R373rE93ycAhrtJR8w2XLLPP59EsKQMOjXGBOOAcAf
        rOyoiginj8c9g+WyhQfABVtmlY+uJT2n1A==
X-Google-Smtp-Source: ABdhPJzvotEUD2R120BLxtl+E0mWcAx/3nMuBXZvmpVEHPjLmHkmNI11a0/KryaUj6jCBFk7CLmFRQ==
X-Received: by 2002:a17:906:2306:: with SMTP id l6mr27996542eja.362.1624949607768;
        Mon, 28 Jun 2021 23:53:27 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49c9:3e00:293f:8e14:7de3:8980])
        by smtp.gmail.com with ESMTPSA id t27sm7717853eje.86.2021.06.28.23.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:53:27 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 6/6] RDMA/rtrs: Move sq_wr_avail to rtrs_con
Date:   Tue, 29 Jun 2021 08:53:21 +0200
Message-Id: <20210629065321.12600-7-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629065321.12600-1-jinpu.wang@ionos.com>
References: <20210629065321.12600-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to account HB for sq_wr_avail properly,
move sq_wr_avail from rtrs_srv_con to rtrs_con.

Although rtrs-clt do not care sq_wr_avail, but still init it
to max_send_wr.

Fixes: b38041d50add ("RDMA/rtrs: Do not signal for heatbeat")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 ++++----
 drivers/infiniband/ulp/rtrs/rtrs-srv.h | 1 -
 drivers/infiniband/ulp/rtrs/rtrs.c     | 1 +
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index f023676e05e4..ece3205531b8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1680,6 +1680,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 			      sess->queue_depth * 3 + 1);
 		max_send_sge = 2;
 	}
+	atomic_set(&con->c.sq_wr_avail, max_send_wr);
 	cq_num = max_send_wr + max_recv_wr;
 	/* alloc iu to recv new rkey reply when server reports flags set */
 	if (sess->flags & RTRS_MSG_NEW_RKEY_F || con->c.cid == 0) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 76581ebaed1d..d12ddfa50747 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -97,6 +97,7 @@ struct rtrs_con {
 	unsigned int		cid;
 	int                     nr_cqe;
 	atomic_t		wr_cnt;
+	atomic_t		sq_wr_avail;
 };
 
 struct rtrs_sess {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 44ed15f38896..cd9a4ccf4c28 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -507,11 +507,11 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 		ib_update_fast_reg_key(mr->mr, ib_inc_rkey(mr->mr->rkey));
 	}
 	if (unlikely(atomic_sub_return(1,
-				       &con->sq_wr_avail) < 0)) {
+				       &con->c.sq_wr_avail) < 0)) {
 		rtrs_err(s, "IB send queue full: sess=%s cid=%d\n",
 			 kobject_name(&sess->kobj),
 			 con->c.cid);
-		atomic_add(1, &con->sq_wr_avail);
+		atomic_add(1, &con->c.sq_wr_avail);
 		spin_lock(&con->rsp_wr_wait_lock);
 		list_add_tail(&id->wait_list, &con->rsp_wr_wait_list);
 		spin_unlock(&con->rsp_wr_wait_lock);
@@ -1268,7 +1268,7 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		 * post_send() RDMA write completions of IO reqs (read/write)
 		 * and hb.
 		 */
-		atomic_add(s->signal_interval, &con->sq_wr_avail);
+		atomic_add(s->signal_interval, &con->c.sq_wr_avail);
 
 		if (unlikely(!list_empty_careful(&con->rsp_wr_wait_list)))
 			rtrs_rdma_process_wr_wait_list(con);
@@ -1680,7 +1680,7 @@ static int create_con(struct rtrs_srv_sess *sess,
 		 */
 	}
 	cq_num = max_send_wr + max_recv_wr;
-	atomic_set(&con->sq_wr_avail, max_send_wr);
+	atomic_set(&con->c.sq_wr_avail, max_send_wr);
 	cq_vector = rtrs_srv_get_next_cq_vector(sess);
 
 	/* TODO: SOFTIRQ can be faster, but be careful with softirq context */
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 6785c3b6363e..e81774f5acd3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -42,7 +42,6 @@ struct rtrs_srv_stats {
 
 struct rtrs_srv_con {
 	struct rtrs_con		c;
-	atomic_t		sq_wr_avail;
 	struct list_head	rsp_wr_wait_list;
 	spinlock_t		rsp_wr_wait_lock;
 };
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index b56dc5b82db0..ca542e477d38 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -191,6 +191,7 @@ static int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con,
 	struct rtrs_sess *sess = con->sess;
 	enum ib_send_flags sflags;
 
+	atomic_dec_if_positive(&con->sq_wr_avail);
 	sflags = (atomic_inc_return(&con->wr_cnt) % sess->signal_interval) ?
 		0 : IB_SEND_SIGNALED;
 
-- 
2.25.1

