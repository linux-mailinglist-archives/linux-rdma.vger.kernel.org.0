Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662C32D4708
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgLIQq2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgLIQq2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:46:28 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8330C0613D6
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:45:47 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id b2so2297107edm.3
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpPnc2m5XVQy3plvidZQlq66m0N1fBZky9SIH8zFy/w=;
        b=QVQZBQCYWkccBchSdNl7bwgKhAKNKGqYaekt8HSjKb695Uy1AOLNcGHpWgUjnkMtid
         rkzaAE2xje2a3FKLJdIFyMbId1/Ksumssfy6S/jQapaPNL6w86XqQrV67HuJo3vXO2+e
         v64eUMP2/g40xYp06lf0IBZrlxH9yRVL/Tj/KbYjyNxIeQsWQ6zpNdL6P5TsRojPSAwp
         AUUoE9yHF0j2XSnbWfWbd1zXOyq+pcnctckAHtjIiYi3DuP0/5RDwOHLkHIP2dy6QQ+W
         TD+/x/VnDBodzyn7q61xpr1ckdT88koGE3q/XaGqJDl8b0P/Q3a4jDq+pvFB7Q//w7XD
         P2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpPnc2m5XVQy3plvidZQlq66m0N1fBZky9SIH8zFy/w=;
        b=MybAvI1Wlcqjoh2sO9fkB3h8aQwohkiTh4B2qHJGJtkwZtgUp1h1a/muVyiRT8VtY1
         90czqQiZBscb3TFfa3/C79rSDMy4Ix69iezSwS7Dh5zDJ2Mwh0yH0aelZk0yXCWeCeec
         8ucn4ZwEK1FvHyva9U8dkYXL0ULS69DRhOOFVJ5jxgAD3a/GzAzWEdKplP6/21WFE4ku
         41oiXSBiDRlGxR0RYSMh2VQMl3shbhVZdRyClQfo352f5fmnGzXNkKr8CHe3bZHBNKWp
         KjOmd5CFlU8WRGg1qrCF5bIp4+m/pKOsdE7RbW2TMY4fdp7S+P47U5/jVV3TWxnYa2YY
         QKbA==
X-Gm-Message-State: AOAM532C55skc/irfhtnO5WbHZ9SgbCWdDoiS+/HxNY7LiMMP8Vx1ypN
        c4s8J8nL5Mq/j7unbHuwEkS8OOUB4coQ+w==
X-Google-Smtp-Source: ABdhPJx4McoCI8WB5bWkF4lzbkFeniHShfPLIy/+6wroEm9J1r+GerL+u3Q5SnyVOVf600TXaul0oA==
X-Received: by 2002:a50:e84d:: with SMTP id k13mr2773137edn.154.1607532346235;
        Wed, 09 Dec 2020 08:45:46 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:45 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 01/18] RDMA/rtrs: Extend ibtrs_cq_qp_create
Date:   Wed,  9 Dec 2020 17:45:25 +0100
Message-Id: <20201209164542.61387-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rtrs does not have same limit for both max_send_wr and max_recv_wr,
To allow client and server set different values, export in a separate
parameter for rtrs_cq_qp_create.

Also fix the type accordingly, u32 should be used instead of u16.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  4 ++--
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  5 +++--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c |  5 +++--
 drivers/infiniband/ulp/rtrs/rtrs.c     | 14 ++++++++------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 67f86c405a26..719254fc83a1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1511,7 +1511,7 @@ static void destroy_con(struct rtrs_clt_con *con)
 static int create_con_cq_qp(struct rtrs_clt_con *con)
 {
 	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
-	u16 wr_queue_size;
+	u32 wr_queue_size;
 	int err, cq_vector;
 	struct rtrs_msg_rkey_rsp *rsp;
 
@@ -1573,7 +1573,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 	cq_vector = con->cpu % sess->s.dev->ib_dev->num_comp_vectors;
 	err = rtrs_cq_qp_create(&sess->s, &con->c, sess->max_send_sge,
 				 cq_vector, wr_queue_size, wr_queue_size,
-				 IB_POLL_SOFTIRQ);
+				 wr_queue_size, IB_POLL_SOFTIRQ);
 	/*
 	 * In case of error we do not bother to clean previous allocations,
 	 * since destroy_con_cq_qp() must be called.
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 3f2918671dbe..d5621e6fad1b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -303,8 +303,9 @@ int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
 				   struct ib_send_wr *head);
 
 int rtrs_cq_qp_create(struct rtrs_sess *rtrs_sess, struct rtrs_con *con,
-		      u32 max_send_sge, int cq_vector, u16 cq_size,
-		      u16 wr_queue_size, enum ib_poll_context poll_ctx);
+		      u32 max_send_sge, int cq_vector, int cq_size,
+		      u32 max_send_wr, u32 max_recv_wr,
+		      enum ib_poll_context poll_ctx);
 void rtrs_cq_qp_destroy(struct rtrs_con *con);
 
 void rtrs_init_hb(struct rtrs_sess *sess, struct ib_cqe *cqe,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index c42fd470c4eb..ed4628f032bb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1586,7 +1586,7 @@ static int create_con(struct rtrs_srv_sess *sess,
 	struct rtrs_sess *s = &sess->s;
 	struct rtrs_srv_con *con;
 
-	u16 cq_size, wr_queue_size;
+	u32 cq_size, wr_queue_size;
 	int err, cq_vector;
 
 	con = kzalloc(sizeof(*con), GFP_KERNEL);
@@ -1630,7 +1630,8 @@ static int create_con(struct rtrs_srv_sess *sess,
 
 	/* TODO: SOFTIRQ can be faster, but be careful with softirq context */
 	err = rtrs_cq_qp_create(&sess->s, &con->c, 1, cq_vector, cq_size,
-				 wr_queue_size, IB_POLL_WORKQUEUE);
+				 wr_queue_size, wr_queue_size,
+				 IB_POLL_WORKQUEUE);
 	if (err) {
 		rtrs_err(s, "rtrs_cq_qp_create(), err: %d\n", err);
 		goto free_con;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 2e3a849e0a77..df52427f1710 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -231,14 +231,14 @@ static int create_cq(struct rtrs_con *con, int cq_vector, u16 cq_size,
 }
 
 static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
-		     u16 wr_queue_size, u32 max_sge)
+		     u32 max_send_wr, u32 max_recv_wr, u32 max_sge)
 {
 	struct ib_qp_init_attr init_attr = {NULL};
 	struct rdma_cm_id *cm_id = con->cm_id;
 	int ret;
 
-	init_attr.cap.max_send_wr = wr_queue_size;
-	init_attr.cap.max_recv_wr = wr_queue_size;
+	init_attr.cap.max_send_wr = max_send_wr;
+	init_attr.cap.max_recv_wr = max_recv_wr;
 	init_attr.cap.max_recv_sge = 1;
 	init_attr.event_handler = qp_event_handler;
 	init_attr.qp_context = con;
@@ -260,8 +260,9 @@ static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
 }
 
 int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
-		       u32 max_send_sge, int cq_vector, u16 cq_size,
-		       u16 wr_queue_size, enum ib_poll_context poll_ctx)
+		       u32 max_send_sge, int cq_vector, int cq_size,
+		       u32 max_send_wr, u32 max_recv_wr,
+		       enum ib_poll_context poll_ctx)
 {
 	int err;
 
@@ -269,7 +270,8 @@ int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
 	if (err)
 		return err;
 
-	err = create_qp(con, sess->dev->ib_pd, wr_queue_size, max_send_sge);
+	err = create_qp(con, sess->dev->ib_pd, max_send_wr, max_recv_wr,
+			max_send_sge);
 	if (err) {
 		ib_free_cq(con->cq);
 		con->cq = NULL;
-- 
2.25.1

