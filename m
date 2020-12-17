Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F74F2DD2D1
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgLQOUA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgLQOT7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:19:59 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E2EC0617A7
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id n26so38076441eju.6
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5W1ywusO6gzyPssMkp8rV1kV/3FoZ1vU82I0QG9hg9k=;
        b=jK3u0VNKylkngCgrEA8HEaDmF4zZsasg6CmOK6oMS+jZMb/TwSGJ+FfUldbo1vnKgP
         JfmaRq7esW8kH9/kO9uZhiQ1aL/zRDcRI0VZoLSIsY1KRbIEDeFRE209YAIHH0UsGLi5
         k1E6m1sU1PMct3J2lvJKRc9KjX/4mUzP1fnoG9szTRFKadhgfc84qd9L2YA4hh20gZBD
         W873Mbhgoj6xQi68++CmHHEcZMeeSCrIr020/LakLROhqS+d5E3S7Lj5tTeCWTUr9ZF0
         AFTdF82JpWJbxUp1hHL9XusTXTiN+I5ZRAxL/eB60TPBd0t3GSvbrL1r9w3nOFi8Qkvw
         UctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5W1ywusO6gzyPssMkp8rV1kV/3FoZ1vU82I0QG9hg9k=;
        b=JHhxDSnm2hC6BXYlIe1CurguXMFETk27tqeLtNmvRm0dGksSbRouv2tx73kC+ueJTr
         B4XTW3UMnlsVnGjFFAHCsKO7sLGq7WKpTYEHxHdcPpkYiRorCvWuOYM8McrERVoxGhuN
         larLiCcPntjn2mbvq7+B65f2NwfEz7JQRCLA9qrXFL1yzAnVdPbe9nGFNlG06MPfmkee
         QeIqAADkxT4o9dHwd0mJjzJCSJLRE8BkM7ntCVWQUIi8s7GpWQxub0aMkvazi4D86+3A
         dFxnTHFnDpk148honsLYhVUwa8ba5zYhPGIlwIb24P4uac1S+ktBV6hr+2m7ZMNokNtC
         SZLA==
X-Gm-Message-State: AOAM530svSgdGZkk43EXRUBBvtoVT2hm+rmEu/WrpwckuLHHlw9pl4RM
        Ske8BQZ1tP9TSSl7LDJicwt9lWDHT8SE4g==
X-Google-Smtp-Source: ABdhPJzK4x1x9K+6Sn2QQfGqT6WZ8MgtdPdT8uSvJcR777vM21n68vOmqYciRJ6NbmZoPIYJk9cDuw==
X-Received: by 2002:a17:906:fa82:: with SMTP id lt2mr35511415ejb.322.1608214757852;
        Thu, 17 Dec 2020 06:19:17 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:17 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCHv2 for-next 01/19] RDMA/rtrs: Extend ibtrs_cq_qp_create
Date:   Thu, 17 Dec 2020 15:18:57 +0100
Message-Id: <20201217141915.56989-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rtrs does not have same limit for both max_send_wr and max_recv_wr,
To allow client and server set different values, export in a separate
parameter for rtrs_cq_qp_create.

Also fix the type accordingly, u32 should be used instead of u16.

Fixes: c0894b3ea69d ("RDMA/rtrs: core: lib functions shared between client and server modules")
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

