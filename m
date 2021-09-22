Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7113B4149C3
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbhIVMzP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 08:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhIVMzP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 08:55:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB5FC061574
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w29so6437515wra.8
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1QtuaSx1IRGfCpES7GFcGPcaoZguarMvSswnYe+X4c=;
        b=VGiOq2CjGYzvVZzPzguwmSnLvJXZK9afLG9bTcyh2ye1Ye+pHVY5YqiJDC+WHCZT7z
         WZK9wEuhkXnoN9ih1tKsXiKhy3F5QQhV7pK14/WCSGaH3Uwv05NXTPWpp3gTqFUyOIjM
         WzX0nbSRtEE5gpMQ90DIbGyZBpmLT1+Rn2uLHmySNPqJuCz4Q8aojbPUtzWsfVDhkQz4
         iZ09FWrza/+4PBuEA8S+yUtuoN95/Mgc9BF1w4eViImFc2RdYBvJ7d5+7wN4G0VgDWNQ
         yfj2j/Wimex5JweZ1zgIlKa+EAnrbg+TvU8EgMskGDtMVGNZTjYsoVBI9UQMbNTSeNpy
         hpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1QtuaSx1IRGfCpES7GFcGPcaoZguarMvSswnYe+X4c=;
        b=60+at0NBuTe+kzGg9PuSJrbrn3zg6aaZHuNNFv9kLRH8aqj0W4xzOKPHCBfkW/gKYF
         QF6vU3H97od6eXqre9DR5FOdzmYEWcGv1V8ry4P24fmNCO09kq7zgY3nrWcgUUTVEiIi
         6aKmiug2TiCNVd31G+a30D5u0ZaoAu10oy704MYGbhlyz+pSzX9efWmq819tv8HJB5bE
         nE5I82XRq8CQwzyLL8Zt5tfsGOgnkHngX5nU08DXU4pDQ6Y/W3LcCGY1i11pDCnA4V1X
         KThFdU+HqkjuX7MSpf2KY7ZGw4JrZXzy6gGRaLyXSasxl+lOmJBINJLljvD4g4TjZ6GS
         drTA==
X-Gm-Message-State: AOAM532PlzbhMu2l+lEH3SWFCNcSTiavkvDFVAxwSrLfBTWKkkeruAFK
        bcj9h1V8fvGndsYZqQ7DzwGFCtBsS+jWLw==
X-Google-Smtp-Source: ABdhPJw0rE5wYyvU2auninJO9NipKfEJZpazuCzx1iar87d4Y5JLAh/AHz2fnjfXKsSCtIobtVI4ZQ==
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr10084701wmg.115.1632315223900;
        Wed, 22 Sep 2021 05:53:43 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:40a5:9868:5a83:f3b9])
        by smtp.gmail.com with ESMTPSA id j20sm2173685wrb.5.2021.09.22.05.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:53:43 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 4/7] RDMA/rtrs: Replace duplicate check with is_pollqueue helper
Date:   Wed, 22 Sep 2021 14:53:30 +0200
Message-Id: <20210922125333.351454-5-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922125333.351454-1-haris.iqbal@ionos.com>
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

if (con->cid >= con->sess->irq_con_num) check can be replaced with
a is_pollqueue helper.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 9bc323490ce3..ac83cd97f838 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -222,13 +222,18 @@ static void qp_event_handler(struct ib_event *ev, void *ctx)
 	}
 }
 
+static bool is_pollqueue(struct rtrs_con *con)
+{
+	return con->cid >= con->sess->irq_con_num;
+}
+
 static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
 		     enum ib_poll_context poll_ctx)
 {
 	struct rdma_cm_id *cm_id = con->cm_id;
 	struct ib_cq *cq;
 
-	if (con->cid >= con->sess->irq_con_num)
+	if (is_pollqueue(con))
 		cq = ib_alloc_cq(cm_id->device, con, nr_cqe, cq_vector,
 				 poll_ctx);
 	else
@@ -288,7 +293,7 @@ int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
 	err = create_qp(con, sess->dev->ib_pd, max_send_wr, max_recv_wr,
 			max_send_sge);
 	if (err) {
-		if (con->cid >= con->sess->irq_con_num)
+		if (is_pollqueue(con))
 			ib_free_cq(con->cq);
 		else
 			ib_cq_pool_put(con->cq, con->nr_cqe);
@@ -308,7 +313,7 @@ void rtrs_cq_qp_destroy(struct rtrs_con *con)
 		con->qp = NULL;
 	}
 	if (con->cq) {
-		if (con->cid >= con->sess->irq_con_num)
+		if (is_pollqueue(con))
 			ib_free_cq(con->cq);
 		else
 			ib_cq_pool_put(con->cq, con->nr_cqe);
-- 
2.25.1

