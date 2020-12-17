Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BFA2DD2DF
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgLQOUz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQOUz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:55 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B8AC0611BB
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:33 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id g20so38140022ejb.1
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVqdZVRi5hPWUiDXaKzaAVmLh/FfF7hda4xCmPJXXmA=;
        b=HPbVUVghXTZPm2B5Er3aPBYbe+qBmbusjeJm+HYAFtLuBa3YXin6KjdZoZpWZOnjLE
         b1lQoWAS9rabeAd/UEbWEN3PRn13odq1A4EkF0JxhhD1lAIyFkxGGSbcPuXVxFd86Qkc
         XU5xgeGd/Upobi8oF0MMmgny0YNM40IDTIbGTfrL1Od2MCbBGLtDdB8cRc5D6Ha2w5wf
         cc/mez6OfGK9GBjmG/Yp6p+BrQIr8XiKxh245XdM7p/Od1ajpQhJiBCtivPxcOuU1vT1
         le9+bg5/kcifvJyZYRaU6Sk7sDs0rWVpPztz/g0HfesNuPeMVnl1YiFE5fnKGodro1r5
         m15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVqdZVRi5hPWUiDXaKzaAVmLh/FfF7hda4xCmPJXXmA=;
        b=UaDAGV7l0opvdZ1SdRizfXmCjm/oOH9X5Ddr5iO9cW1/vVTkEUkGfPQ2ItZJvxfB8v
         7dNLEaYLZuflM50/yiPpdtR8SrDpQjJkVd17t0K2c6dzM3kgIMEsCZPeEl12M84YsNSs
         dOulRdly1vHkYTCYamsZIyn0QMBwY8hctBg0Am0B1lP1EcP4mGJv+HfHyyO7d2bCjBVL
         uaTeu/l8XVI0jUpNMSL3Lg2G2G1EAhUW+kqC3GCUTmAHP/OsLG4RWqt1QstWV94ntpyO
         GzAkGQhs4pSSvcX+YgsTiVH73Hel57CCSnv2D4d64EvRQzrn0GPHN+dVbavcATF5dAjY
         HPNw==
X-Gm-Message-State: AOAM533Grrim+qpd/B3k8vn56IzNlP4VywqHEm3w5ubnlTrXl+oX48Eu
        bAcrghpFy8flvurAj8l4I0i4jmipblAkVg==
X-Google-Smtp-Source: ABdhPJyMPZ41tSL3VTpY6xdyl98fePpOq0DofRNbAAa1QukDkc+vnhVIiSbtqa/XjchqJrLZAEyKxg==
X-Received: by 2002:a17:906:e15:: with SMTP id l21mr35659172eji.509.1608214771816;
        Thu, 17 Dec 2020 06:19:31 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:31 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 16/19] RDMA/rtrs-clt: Use bitmask to check sess->flags
Date:   Thu, 17 Dec 2020 15:19:12 +0100
Message-Id: <20201217141915.56989-17-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We may want to add new flags, so it's better to use bitmask to check flags.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 2053bf99418a..7644c3f627ca 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -494,7 +494,7 @@ static void rtrs_clt_recv_done(struct rtrs_clt_con *con, struct ib_wc *wc)
 	int err;
 	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
 
-	WARN_ON(sess->flags != RTRS_MSG_NEW_RKEY_F);
+	WARN_ON((sess->flags & RTRS_MSG_NEW_RKEY_F) == 0);
 	iu = container_of(wc->wr_cqe, struct rtrs_iu,
 			  cqe);
 	err = rtrs_iu_post_recv(&con->c, iu);
@@ -514,7 +514,7 @@ static void rtrs_clt_rkey_rsp_done(struct rtrs_clt_con *con, struct ib_wc *wc)
 	u32 buf_id;
 	int err;
 
-	WARN_ON(sess->flags != RTRS_MSG_NEW_RKEY_F);
+	WARN_ON((sess->flags & RTRS_MSG_NEW_RKEY_F) == 0);
 
 	iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
 
@@ -621,12 +621,12 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		} else if (imm_type == RTRS_HB_MSG_IMM) {
 			WARN_ON(con->c.cid);
 			rtrs_send_hb_ack(&sess->s);
-			if (sess->flags == RTRS_MSG_NEW_RKEY_F)
+			if (sess->flags & RTRS_MSG_NEW_RKEY_F)
 				return  rtrs_clt_recv_done(con, wc);
 		} else if (imm_type == RTRS_HB_ACK_IMM) {
 			WARN_ON(con->c.cid);
 			sess->s.hb_missed_cnt = 0;
-			if (sess->flags == RTRS_MSG_NEW_RKEY_F)
+			if (sess->flags & RTRS_MSG_NEW_RKEY_F)
 				return  rtrs_clt_recv_done(con, wc);
 		} else {
 			rtrs_wrn(con->c.sess, "Unknown IMM type %u\n",
@@ -654,7 +654,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		WARN_ON(!(wc->wc_flags & IB_WC_WITH_INVALIDATE ||
 			  wc->wc_flags & IB_WC_WITH_IMM));
 		WARN_ON(wc->wr_cqe->done != rtrs_clt_rdma_done);
-		if (sess->flags == RTRS_MSG_NEW_RKEY_F) {
+		if (sess->flags & RTRS_MSG_NEW_RKEY_F) {
 			if (wc->wc_flags & IB_WC_WITH_INVALIDATE)
 				return  rtrs_clt_recv_done(con, wc);
 
@@ -679,7 +679,7 @@ static int post_recv_io(struct rtrs_clt_con *con, size_t q_size)
 	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
 
 	for (i = 0; i < q_size; i++) {
-		if (sess->flags == RTRS_MSG_NEW_RKEY_F) {
+		if (sess->flags & RTRS_MSG_NEW_RKEY_F) {
 			struct rtrs_iu *iu = &con->rsp_ius[i];
 
 			err = rtrs_iu_post_recv(&con->c, iu);
@@ -1563,7 +1563,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 			      sess->queue_depth * 3 + 1);
 	}
 	/* alloc iu to recv new rkey reply when server reports flags set */
-	if (sess->flags == RTRS_MSG_NEW_RKEY_F || con->c.cid == 0) {
+	if (sess->flags & RTRS_MSG_NEW_RKEY_F || con->c.cid == 0) {
 		con->rsp_ius = rtrs_iu_alloc(max_recv_wr, sizeof(*rsp),
 					      GFP_KERNEL, sess->s.dev->ib_dev,
 					      DMA_FROM_DEVICE,
-- 
2.25.1

