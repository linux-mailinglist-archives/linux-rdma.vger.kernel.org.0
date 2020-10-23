Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8A296A75
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375772AbgJWHoD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375769AbgJWHoD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:44:03 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E079C0613D2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z5so1043052ejw.7
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hge50L29ZsVgErfWWa2RPsI6x8iu3oUMD6GehXNGpLI=;
        b=JH4EZey2njRcJ865np/Ukxo40mhCSsU1h0DA0dIwBnryeYRQSEEiDhNnu3gez98/jb
         HAGK789iW2F69m1XkIE2TPf1vw8dpwjL9RIEKBl2STjVh+eTcxfieC3DhBcIFQyJyBhF
         HAKzEI0//gvlcc9Z3qDZwJ1L6TDj50+w6JvivULT3To+X6Q7DaQACBDD2FhlUdLPO/qs
         Xzl0V8tkIBch0ZU1h/lAI9+/u63m9PYDZ1OLs0qC/cG+7jYMrVg36M48hN0vbWMKWJBi
         vmADp0fo84u6i5IsPeYp2IBJ5jDFDO1FKDWms916URHTmNqKaafm3xGNWynjtBD9CFTU
         a6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hge50L29ZsVgErfWWa2RPsI6x8iu3oUMD6GehXNGpLI=;
        b=gWmZB5rsVn1xjh3ZCdViOrNqPj3F09snw3PR1Xe6hDJj0Ie2wh7LtdGZNW9uQj7JW7
         0QdVBqp8r0FRksaYHFDQqrdv99/avznWIP5C8KEfHieJoYwRrnjy3o7faUGsYGChS4me
         +cgAAdyLPQi5Z6E9B4bmDrqqKQn3YlWDtMxpERJ42gyz9eQLMC22SXXEcarK/e8NK8ul
         45nfmhsza9WU76y+FRmDtP+ayLspBomX90NSYGbfc6tmgxveGlGV6gc7qzlZQ0gG5idR
         F/l1y6W8Rs0ReZyPcV0c9V1FEw7QVHCQ0t2rVAlvlCCs9pdU+kn7W+aqAwylfUb9xCA+
         idtg==
X-Gm-Message-State: AOAM533aNy2oZU4sebVI/I+g/cobLpvnukuBZkc5CLCGaheNsXlvf2dq
        6K1SyVKAbMSJmciIk/P247NHpCbrBTvF1w==
X-Google-Smtp-Source: ABdhPJzbnqcbDNw0mJb3SA/nuB0TpkEbYSMp4o6rlrsgQ597TG0khTc5CjhYaQ8z31+WyQFRoihcog==
X-Received: by 2002:a17:907:70cb:: with SMTP id yk11mr755408ejb.122.1603439041550;
        Fri, 23 Oct 2020 00:44:01 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:44:01 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 07/12] RDMA/rtrs: remove unnecessary argument dir of rtrs_iu_free
Date:   Fri, 23 Oct 2020 09:43:48 +0200
Message-Id: <20201023074353.21946-8-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

The direction of DMA operation is already in the rtrs_iu

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 ++++++--------
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  3 +--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 14 ++++++--------
 drivers/infiniband/ulp/rtrs/rtrs.c     |  9 ++++-----
 4 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index ffca004625bb..4e5da834034a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1236,8 +1236,7 @@ static void free_sess_reqs(struct rtrs_clt_sess *sess)
 		if (req->mr)
 			ib_dereg_mr(req->mr);
 		kfree(req->sge);
-		rtrs_iu_free(req->iu, DMA_TO_DEVICE,
-			      sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(req->iu, sess->s.dev->ib_dev, 1);
 	}
 	kfree(sess->reqs);
 	sess->reqs = NULL;
@@ -1599,8 +1598,7 @@ static void destroy_con_cq_qp(struct rtrs_clt_con *con)
 	lockdep_assert_held(&con->con_mutex);
 	rtrs_cq_qp_destroy(&con->c);
 	if (con->rsp_ius) {
-		rtrs_iu_free(con->rsp_ius, DMA_FROM_DEVICE,
-			      sess->s.dev->ib_dev, con->queue_size);
+		rtrs_iu_free(con->rsp_ius, sess->s.dev->ib_dev, con->queue_size);
 		con->rsp_ius = NULL;
 		con->queue_size = 0;
 	}
@@ -2245,7 +2243,7 @@ static void rtrs_clt_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_iu *iu;
 
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
-	rtrs_iu_free(iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
+	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		rtrs_err(sess->clt, "Sess info request send failed: %s\n",
@@ -2374,7 +2372,7 @@ static void rtrs_clt_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 
 out:
 	rtrs_clt_update_wc_stats(con);
-	rtrs_iu_free(iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
+	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 	rtrs_clt_change_state(sess, state);
 }
 
@@ -2436,9 +2434,9 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 
 out:
 	if (tx_iu)
-		rtrs_iu_free(tx_iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(tx_iu, sess->s.dev->ib_dev, 1);
 	if (rx_iu)
-		rtrs_iu_free(rx_iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(rx_iu, sess->s.dev->ib_dev, 1);
 	if (unlikely(err))
 		/* If we've never taken async path because of malloc problems */
 		rtrs_clt_change_state(sess, RTRS_CLT_CONNECTING_ERR);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index b8e43dc4d95a..3f2918671dbe 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -287,8 +287,7 @@ struct rtrs_msg_rdma_hdr {
 struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t t,
 			      struct ib_device *dev, enum dma_data_direction,
 			      void (*done)(struct ib_cq *cq, struct ib_wc *wc));
-void rtrs_iu_free(struct rtrs_iu *iu, enum dma_data_direction dir,
-		  struct ib_device *dev, u32 queue_size);
+void rtrs_iu_free(struct rtrs_iu *iu, struct ib_device *dev, u32 queue_size);
 int rtrs_iu_post_recv(struct rtrs_con *con, struct rtrs_iu *iu);
 int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
 		      struct ib_send_wr *head);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 1cb778aff3c5..42ee3bf7dc52 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -577,8 +577,7 @@ static void unmap_cont_bufs(struct rtrs_srv_sess *sess)
 		struct rtrs_srv_mr *srv_mr;
 
 		srv_mr = &sess->mrs[i];
-		rtrs_iu_free(srv_mr->iu, DMA_TO_DEVICE,
-			      sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(srv_mr->iu, sess->s.dev->ib_dev, 1);
 		ib_dereg_mr(srv_mr->mr);
 		ib_dma_unmap_sg(sess->s.dev->ib_dev, srv_mr->sgt.sgl,
 				srv_mr->sgt.nents, DMA_BIDIRECTIONAL);
@@ -682,8 +681,7 @@ static int map_cont_bufs(struct rtrs_srv_sess *sess)
 			sgt = &srv_mr->sgt;
 			mr = srv_mr->mr;
 free_iu:
-			rtrs_iu_free(srv_mr->iu, DMA_TO_DEVICE,
-				      sess->s.dev->ib_dev, 1);
+			rtrs_iu_free(srv_mr->iu, sess->s.dev->ib_dev, 1);
 dereg_mr:
 			ib_dereg_mr(mr);
 unmap_sg:
@@ -735,7 +733,7 @@ static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_iu *iu;
 
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
-	rtrs_iu_free(iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
+	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		rtrs_err(s, "Sess info response send failed: %s\n",
@@ -861,7 +859,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	if (unlikely(err)) {
 		rtrs_err(s, "rtrs_iu_post_send(), err: %d\n", err);
 iu_free:
-		rtrs_iu_free(tx_iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(tx_iu, sess->s.dev->ib_dev, 1);
 	}
 rwr_free:
 	kfree(rwr);
@@ -906,7 +904,7 @@ static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 		goto close;
 
 out:
-	rtrs_iu_free(iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
+	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 	return;
 close:
 	close_sess(sess);
@@ -929,7 +927,7 @@ static int post_recv_info_req(struct rtrs_srv_con *con)
 	err = rtrs_iu_post_recv(&con->c, rx_iu);
 	if (unlikely(err)) {
 		rtrs_err(s, "rtrs_iu_post_recv(), err: %d\n", err);
-		rtrs_iu_free(rx_iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(rx_iu, sess->s.dev->ib_dev, 1);
 		return err;
 	}
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index ff1093d6e4bc..48f648f573b6 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -31,6 +31,7 @@ struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
 		return NULL;
 	for (i = 0; i < queue_size; i++) {
 		iu = &ius[i];
+		iu->direction = dir;
 		iu->buf = kzalloc(size, gfp_mask);
 		if (!iu->buf)
 			goto err;
@@ -41,17 +42,15 @@ struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
 
 		iu->cqe.done  = done;
 		iu->size      = size;
-		iu->direction = dir;
 	}
 	return ius;
 err:
-	rtrs_iu_free(ius, dir, dma_dev, i);
+	rtrs_iu_free(ius, dma_dev, i);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(rtrs_iu_alloc);
 
-void rtrs_iu_free(struct rtrs_iu *ius, enum dma_data_direction dir,
-		   struct ib_device *ibdev, u32 queue_size)
+void rtrs_iu_free(struct rtrs_iu *ius, struct ib_device *ibdev, u32 queue_size)
 {
 	struct rtrs_iu *iu;
 	int i;
@@ -61,7 +60,7 @@ void rtrs_iu_free(struct rtrs_iu *ius, enum dma_data_direction dir,
 
 	for (i = 0; i < queue_size; i++) {
 		iu = &ius[i];
-		ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, dir);
+		ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, iu->direction);
 		kfree(iu->buf);
 	}
 	kfree(ius);
-- 
2.25.1

