Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495E328B5E6
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbgJLNSZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbgJLNSY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:24 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887FC0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:23 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e22so23151689ejr.4
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7scqcEtmQZ8SzGjSa1/wFmxibIMwLYiYBJN18Xc/RhA=;
        b=LY3WD/2xEw6Uj4Kec7epkqlsoxmo6u7tCEA0GvobneGOs0gRIM+STos3JDQSLbQD2R
         FAfduqB780TqR9edDHk4XvslFKG4M4UfH58kNwuERQhZHOk3n+TqUfHml9xdXRAmEHQI
         P/QnG9pzdL3eUQVuHLwHfo34+1PslsgAOvxvth6lkXk+QwgXaZt7GuY6nOlvuSlgB/H7
         RPH19dK694AlZ0rro4OxJJGk3dCAPfRW22e8Ie5tk73kIaWhblRTVVhrOHSqTP8EcFks
         KA8BOAL0GySq/NY85IP2MHfXwSHnsYUm0HdOVMJEYSHimL1P2e2UcCy+0C1VQZL/cIKR
         A/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7scqcEtmQZ8SzGjSa1/wFmxibIMwLYiYBJN18Xc/RhA=;
        b=IlyqhUwFWOMwTt5YuVRThe9ncfhqD4PdUl8Ei89y6xwYQua4uoYpnpeWdf12H9Keqn
         eOyAw/2PpEYpDlMLfDnXIZQP8N8pYQyRqgHIeROpjc1o/3MqnEDJlvb8DVV5bvX5CPcj
         g3qYuwE9ib709rnGh5ZupZBH6j4/r2206INdziY5dPp4SWGxAgO/PwSsG8kaTnBnbVsQ
         PDfksr/TLkhR6aRyonF1FWknFTDTfQ2DMbST28hXpUhlBMi/CbG4z4u4aaZSpbGe5jyY
         TT8yf8XaAKr6auF5ykf8/XRtlscf5J2IT4iyAMyFkx7gAnisGTozBOw9n3rJzkuMaS1+
         /bqA==
X-Gm-Message-State: AOAM533Ze/wJ9wHIWxepPRrudYay9YQiiQPKm7R1dLVDf1KRtEWAsprW
        tKEmF2zfpFIvK0o7QoRJ9oUV89l8gr/uSg==
X-Google-Smtp-Source: ABdhPJzAs1j3TB4Oe54jeLaxZcux0VjzdgDUH+ConNqYYluKVON4XWiplxf47p8S1ELMRN4Ylo37Qw==
X-Received: by 2002:a17:907:1042:: with SMTP id oy2mr27048687ejb.64.1602508701915;
        Mon, 12 Oct 2020 06:18:21 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:21 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 06/13] RDMA/rtrs: remove unnecessary argument dir of rtrs_iu_free
Date:   Mon, 12 Oct 2020 15:18:07 +0200
Message-Id: <20201012131814.121096-7-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
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
index b1c0c1400c8a..6507cfb960d4 100644
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
@@ -1594,8 +1593,7 @@ static void destroy_con_cq_qp(struct rtrs_clt_con *con)
 	lockdep_assert_held(&con->con_mutex);
 	rtrs_cq_qp_destroy(&con->c);
 	if (con->rsp_ius) {
-		rtrs_iu_free(con->rsp_ius, DMA_FROM_DEVICE,
-			      sess->s.dev->ib_dev, con->queue_size);
+		rtrs_iu_free(con->rsp_ius, sess->s.dev->ib_dev, con->queue_size);
 		con->rsp_ius = NULL;
 		con->queue_size = 0;
 	}
@@ -2238,7 +2236,7 @@ static void rtrs_clt_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_iu *iu;
 
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
-	rtrs_iu_free(iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
+	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		rtrs_err(sess->clt, "Sess info request send failed: %s\n",
@@ -2367,7 +2365,7 @@ static void rtrs_clt_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 
 out:
 	rtrs_clt_update_wc_stats(con);
-	rtrs_iu_free(iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
+	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 	rtrs_clt_change_state(sess, state);
 }
 
@@ -2429,9 +2427,9 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 
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
index 7821ac4e827b..f49b04c69d59 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -286,8 +286,7 @@ struct rtrs_msg_rdma_hdr {
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
index 28f6414dfa3d..d85a55851446 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -575,8 +575,7 @@ static void unmap_cont_bufs(struct rtrs_srv_sess *sess)
 		struct rtrs_srv_mr *srv_mr;
 
 		srv_mr = &sess->mrs[i];
-		rtrs_iu_free(srv_mr->iu, DMA_TO_DEVICE,
-			      sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(srv_mr->iu, sess->s.dev->ib_dev, 1);
 		ib_dereg_mr(srv_mr->mr);
 		ib_dma_unmap_sg(sess->s.dev->ib_dev, srv_mr->sgt.sgl,
 				srv_mr->sgt.nents, DMA_BIDIRECTIONAL);
@@ -680,8 +679,7 @@ static int map_cont_bufs(struct rtrs_srv_sess *sess)
 			sgt = &srv_mr->sgt;
 			mr = srv_mr->mr;
 free_iu:
-			rtrs_iu_free(srv_mr->iu, DMA_TO_DEVICE,
-				      sess->s.dev->ib_dev, 1);
+			rtrs_iu_free(srv_mr->iu, sess->s.dev->ib_dev, 1);
 dereg_mr:
 			ib_dereg_mr(mr);
 unmap_sg:
@@ -733,7 +731,7 @@ static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_iu *iu;
 
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
-	rtrs_iu_free(iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
+	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		rtrs_err(s, "Sess info response send failed: %s\n",
@@ -859,7 +857,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	if (unlikely(err)) {
 		rtrs_err(s, "rtrs_iu_post_send(), err: %d\n", err);
 iu_free:
-		rtrs_iu_free(tx_iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
+		rtrs_iu_free(tx_iu, sess->s.dev->ib_dev, 1);
 	}
 rwr_free:
 	kfree(rwr);
@@ -904,7 +902,7 @@ static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 		goto close;
 
 out:
-	rtrs_iu_free(iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
+	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
 	return;
 close:
 	close_sess(sess);
@@ -927,7 +925,7 @@ static int post_recv_info_req(struct rtrs_srv_con *con)
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

