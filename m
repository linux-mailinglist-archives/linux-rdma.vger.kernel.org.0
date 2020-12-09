Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D690D2D4718
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgLIQr3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbgLIQrW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:22 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF525C0611CD
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:46:05 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id v22so2277682edt.9
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6GRiAcnxnxyNYL2OZv9ru2Lq+clQj5bUxW2kCmsckao=;
        b=NEmcQroOuxQoZr/ULQ0KLg7/3GqIyI0gZYxL73DTTklC9yeKUKif8/551qlXr49dnu
         YRZASS2rJLxKFlpxozO3teYdum8yAHUNyIsh+J2QlZIM8GF+n5PhvnxM8KM/PO/G0lto
         Dgo3+djOffgCBlzlSKsjodeHQCoo/cYJDUWnMx3ndJfb3gnnckNum+iwzWb/1Ol6kpX8
         ipzLlMT9+5DQ7assW/hiT29gFFRGvyBY4tljlVKzoj2SYBcBbaN3XH3wx9PeWwMcDopH
         ZaKrrFvPBI7dtDkyGys4Pgg7HWlE3S1VKE874XfereBqghB/sxbe03mcQ1KQF1hCz62D
         FhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GRiAcnxnxyNYL2OZv9ru2Lq+clQj5bUxW2kCmsckao=;
        b=ZzAh28ylnd8NYwz2LNKcdhlENSlygUqxXEVEIO8oLMmPUPDriyfUA12owN0F1bEzH/
         PRkRg6N6aLuTJXcJpZvDEqwppegfiJKPnLzsFMgkinzP+D7Ld+QJNjvllR0Ipo2HGb0t
         I/MQUKTl1cXaJiFCbD371UJS0QAeWNjMxS0+NfG07iBd7qQxTyshZuwhQajO+Ff03sLF
         84/ln/Phrn1tD/gZh/N++xqtgM2cYGOfYy5hRBtx+FY/vVl5p9jPpdLaP5t22b3LsnG8
         5+x2quTpSV7sGZ2K2Jz6tXISrlgZEE52eVpmMAmYCMB47ZjZ5y2RwpOPcS3Aos8nei2/
         WQ7A==
X-Gm-Message-State: AOAM533aWezLXOcGmC6Nncqf+nrjurot14Ziifj/EeFGIuIrKpxpHb5M
        HavHHWi/CZSBCa9k009HiTuJYlrb/GmeXA==
X-Google-Smtp-Source: ABdhPJz2ytA0BVAjvHJaQJg/iojrkQery+XdDJ0fK4Ce5Db1OZcwybudAJm4pMpEX6FM8b6nroTP9g==
X-Received: by 2002:a50:c19a:: with SMTP id m26mr2813358edf.302.1607532364161;
        Wed, 09 Dec 2020 08:46:04 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:46:03 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 16/18] RDMA/rtrs-clt: Use bitmask to check sess->flags
Date:   Wed,  9 Dec 2020 17:45:40 +0100
Message-Id: <20201209164542.61387-17-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We may want to add new flags, so it's better to use bitmask to check flags.

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

