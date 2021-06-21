Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591F33AE2E8
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 07:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUFz7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 01:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFUFz7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 01:55:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206CBC061574
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:53:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id nd37so26745490ejc.3
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xYxafjIVzXlJl3fOIPh2Q21Yf9Gy3QZdGmgKJuNrasI=;
        b=c8+EaB5XoaF2t9H67Eyct3ssYwEEek4voJF5dp4vkrEMQBiBg+v3xFCYLeLUaM2Mfj
         tJAJcNXAg8/icFFCDh/FSJ1KQQqY2fsZilBbdRWghy4xayGA7rAVA5tEpgELCuX6NnKb
         4Mw2MBvCal9PbBcekG5lpJjjY4AM0qX0Lz0oTrH+kH4TlyXIyqNGQfc5+z49NFjF1ADf
         LGOWfWrA32nZkVUxn4moxnRfNVMzkl6oUBUrwz9lvk+aYWBzxjRVQrhgvjRAghuIUdny
         5lGZiMXKDEF5uGSF8X5BffbttioJsXZG34MjYCcxt4jL3cUs52qHXWtSNCWuxoKOBrDs
         /LQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xYxafjIVzXlJl3fOIPh2Q21Yf9Gy3QZdGmgKJuNrasI=;
        b=Lu35Rjym8xCW4VZ++QREbH25yc/gTrGGlomJUeAh3zmiNkcKV1nAyTeNGIiEkuevy8
         bWOtpEcte4HLa6MJzjtkS3fhLuBiTNds91+pJpXbXGh0Qxc+96heW6NCPgHqnyW4w0ap
         /sGqGLc07tWgIW6LIkCKvLoedC/QTm4nixNI8eeahAhcm/UYWtI3AjiWYkPNzKf+xqFG
         TzcxhMzwNqE1pCsaHawzcVfeWmh3mBpCd54SDx/tmrzpvkfyvFaxkSyQQca2FP606sNH
         AyyhIn1hXW9K591bh3F3HOx5hAO7GmRSw1BZNkFixSdoH9fQL0TN3Cp7Znu9JHHltX0Q
         hQAw==
X-Gm-Message-State: AOAM530euTwCzeL+0bI9bGQWoPI8B2jQJO60v9mku+UoXcuP/dcBwzFp
        /ZEbwkUTGRwSQ2UpQ5WwBTjaRyYyXdCLOg==
X-Google-Smtp-Source: ABdhPJzqP0kW9F1CQRsK/OE2YRbNdD/w+yVTAmacpHy/+JoFttL2RS+cfi9UUveGRu3quXlAS51EjA==
X-Received: by 2002:a17:907:c02:: with SMTP id ga2mr22800168ejc.215.1624254823630;
        Sun, 20 Jun 2021 22:53:43 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49f3:be00:dc22:f90e:1d6c:a47])
        by smtp.gmail.com with ESMTPSA id i18sm1919617edc.7.2021.06.20.22.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 22:53:43 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Jack Wang <jinpu.wang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH resend for-next 1/5] RDMA/rtrs: Introduce head/tail wr
Date:   Mon, 21 Jun 2021 07:53:36 +0200
Message-Id: <20210621055340.11789-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621055340.11789-1-jinpu.wang@ionos.com>
References: <20210621055340.11789-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Introduce tail wr, we can send as the last wr, we want to send the local
invalidate wr after rdma wr in later patch.

While at it, also fix coding style issue.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 16 ++++++++-------
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  3 ++-
 drivers/infiniband/ulp/rtrs/rtrs.c     | 28 +++++++++++++++-----------
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 125e0bead262..6b078e0df1fd 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -480,7 +480,7 @@ static int rtrs_post_send_rdma(struct rtrs_clt_con *con,
 
 	return rtrs_iu_post_rdma_write_imm(&con->c, req->iu, &sge, 1,
 					    rbuf->rkey, rbuf->addr + off,
-					    imm, flags, wr);
+					    imm, flags, wr, NULL);
 }
 
 static void process_io_rsp(struct rtrs_clt_sess *sess, u32 msg_id,
@@ -999,9 +999,10 @@ rtrs_clt_get_copy_req(struct rtrs_clt_sess *alive_sess,
 }
 
 static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
-				    struct rtrs_clt_io_req *req,
-				    struct rtrs_rbuf *rbuf,
-				    u32 size, u32 imm)
+				   struct rtrs_clt_io_req *req,
+				   struct rtrs_rbuf *rbuf,
+				   u32 size, u32 imm, struct ib_send_wr *wr,
+				   struct ib_send_wr *tail)
 {
 	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
 	struct ib_sge *sge = req->sge;
@@ -1009,6 +1010,7 @@ static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
 	struct scatterlist *sg;
 	size_t num_sge;
 	int i;
+	struct ib_send_wr *ptail = NULL;
 
 	for_each_sg(req->sglist, sg, req->sg_cnt, i) {
 		sge[i].addr   = sg_dma_address(sg);
@@ -1033,7 +1035,7 @@ static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
 
 	return rtrs_iu_post_rdma_write_imm(&con->c, req->iu, sge, num_sge,
 					    rbuf->rkey, rbuf->addr, imm,
-					    flags, NULL);
+					    flags, wr, ptail);
 }
 
 static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
@@ -1081,8 +1083,8 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 	rtrs_clt_update_all_stats(req, WRITE);
 
 	ret = rtrs_post_rdma_write_sg(req->con, req, rbuf,
-				       req->usr_len + sizeof(*msg),
-				       imm);
+				      req->usr_len + sizeof(*msg),
+				      imm, NULL, NULL);
 	if (unlikely(ret)) {
 		rtrs_err_rl(s,
 			    "Write request failed: error=%d path=%s [%s:%u]\n",
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 76cca2058f6f..36f184a3b676 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -305,7 +305,8 @@ int rtrs_iu_post_rdma_write_imm(struct rtrs_con *con, struct rtrs_iu *iu,
 				struct ib_sge *sge, unsigned int num_sge,
 				u32 rkey, u64 rdma_addr, u32 imm_data,
 				enum ib_send_flags flags,
-				struct ib_send_wr *head);
+				struct ib_send_wr *head,
+				struct ib_send_wr *tail);
 
 int rtrs_post_recv_empty(struct rtrs_con *con, struct ib_cqe *cqe);
 int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 08e1f7d82c95..61919ebd92b2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -105,18 +105,21 @@ int rtrs_post_recv_empty(struct rtrs_con *con, struct ib_cqe *cqe)
 EXPORT_SYMBOL_GPL(rtrs_post_recv_empty);
 
 static int rtrs_post_send(struct ib_qp *qp, struct ib_send_wr *head,
-			     struct ib_send_wr *wr)
+			  struct ib_send_wr *wr, struct ib_send_wr *tail)
 {
 	if (head) {
-		struct ib_send_wr *tail = head;
+		struct ib_send_wr *next = head;
 
-		while (tail->next)
-			tail = tail->next;
-		tail->next = wr;
+		while (next->next)
+			next = next->next;
+		next->next = wr;
 	} else {
 		head = wr;
 	}
 
+	if (tail)
+		wr->next = tail;
+
 	return ib_post_send(qp, head, NULL);
 }
 
@@ -142,15 +145,16 @@ int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
 		.send_flags = IB_SEND_SIGNALED,
 	};
 
-	return rtrs_post_send(con->qp, head, &wr);
+	return rtrs_post_send(con->qp, head, &wr, NULL);
 }
 EXPORT_SYMBOL_GPL(rtrs_iu_post_send);
 
 int rtrs_iu_post_rdma_write_imm(struct rtrs_con *con, struct rtrs_iu *iu,
-				 struct ib_sge *sge, unsigned int num_sge,
-				 u32 rkey, u64 rdma_addr, u32 imm_data,
-				 enum ib_send_flags flags,
-				 struct ib_send_wr *head)
+				struct ib_sge *sge, unsigned int num_sge,
+				u32 rkey, u64 rdma_addr, u32 imm_data,
+				enum ib_send_flags flags,
+				struct ib_send_wr *head,
+				struct ib_send_wr *tail)
 {
 	struct ib_rdma_wr wr;
 	int i;
@@ -174,7 +178,7 @@ int rtrs_iu_post_rdma_write_imm(struct rtrs_con *con, struct rtrs_iu *iu,
 		if (WARN_ON(sge[i].length == 0))
 			return -EINVAL;
 
-	return rtrs_post_send(con->qp, head, &wr.wr);
+	return rtrs_post_send(con->qp, head, &wr.wr, tail);
 }
 EXPORT_SYMBOL_GPL(rtrs_iu_post_rdma_write_imm);
 
@@ -191,7 +195,7 @@ int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
 		.wr.ex.imm_data	= cpu_to_be32(imm_data),
 	};
 
-	return rtrs_post_send(con->qp, head, &wr.wr);
+	return rtrs_post_send(con->qp, head, &wr.wr, NULL);
 }
 EXPORT_SYMBOL_GPL(rtrs_post_rdma_write_imm_empty);
 
-- 
2.25.1

