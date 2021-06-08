Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF4539F512
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 13:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhFHLhe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFHLhc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 07:37:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE968C061574
        for <linux-rdma@vger.kernel.org>; Tue,  8 Jun 2021 04:35:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id he7so12642011ejc.13
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WXjLdfJV/3Gom+3eZIJ83Y2LOor3DLtq98kWLaTPV60=;
        b=UVON4Ly5gY8+mJe9sJMiqLLClxtn4OAUK0lBhL9tY85iRYM9C8HE/zIOQHLH66BghR
         uevS0KFn4rHrB03U5Ad9WuNj2KLhGchx5WOGhNs/PRjtnC6Lv48yhqYMYBLfXbvgKl7P
         E9TfFqpc6ey+uC0EtmNIS306ZCqUVJ982dIz6MeV5EbeC+f8VUNwRpiJ1/dMyufyKzpg
         JklXUxY18Hti4tYgngDs4D/CE1F34PfdKwnGJlpvA8R8B0TfuftGfH9xi/Nk/Gu5qrk7
         MBjsdyePNrXI/KzjF12YSOgOa09ZOmeuhBPnLcr26gEyKP1E/LEHqKdKCTz0csgQRPA4
         TdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXjLdfJV/3Gom+3eZIJ83Y2LOor3DLtq98kWLaTPV60=;
        b=MU3CV/nEEtzfzOdOJZuB1FCjpeNfEteEkXwsMaYXUs6ucfhfv5y4lLWVbX57MZ2F1Q
         synyOfIdkkNGOlAoq2k5wLPgT5Q6cVGHeZMKYj3HPEeKsrj73OXbTcLfN67r444GiHrm
         3Xs113R9Rz8NP528VHWW6/CWSpCG5GKCgPcy6C3T+JujvGTPUeYyC9JL3EMK9g184JCW
         BbZ2Ob3evA/SQEyjdVLRuuGterhF6dVYThUOeCsv9F3OnSjkM0rcLw4fJ6pd0hla3PKH
         fFVYtUOxaddqAjA0zvsJojlT/LxXrgi+uZosB8N6KPfx/XyWH21h5gsX1eFOYX4mjCdp
         F4CQ==
X-Gm-Message-State: AOAM531Xac0BL2Ft8ojuZtVQRZr23fh6Z1d7uAfSrJ/pqLqgoLdb04/u
        l3ZJgEiw3t9b8n9q/mwJbguPQKZQQGaN/w==
X-Google-Smtp-Source: ABdhPJwrBjb3+HWMtTr1DZcSdeGRgbSMii1GnP7S9Dp6AsUnkTf9K3SRNX6OtUcAzDIKbZa86YOu3w==
X-Received: by 2002:a17:906:5049:: with SMTP id e9mr22532037ejk.30.1623152138089;
        Tue, 08 Jun 2021 04:35:38 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4943:5b00:2927:a608:b264:d770])
        by smtp.gmail.com with ESMTPSA id c7sm7675480ejs.26.2021.06.08.04.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:35:37 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        axboe@kernel.dk, Jack Wang <jinpu.wang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 1/5] RDMA/rtrs: Introduce head/tail wr
Date:   Tue,  8 Jun 2021 13:35:32 +0200
Message-Id: <20210608113536.42965-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608113536.42965-1-jinpu.wang@ionos.com>
References: <20210608113536.42965-1-jinpu.wang@ionos.com>
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
index 67ff5bf9bfa8..5ec02f78be3f 100644
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

