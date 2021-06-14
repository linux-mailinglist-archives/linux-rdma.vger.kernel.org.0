Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8473A5EC5
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jun 2021 11:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhFNJFo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Jun 2021 05:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhFNJFn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Jun 2021 05:05:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E23C061574
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jun 2021 02:03:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id og14so15423165ejc.5
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jun 2021 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecJdDWCLZdqRRH5zcH4heHVXHsxA6MaHJTTe6+QsOfE=;
        b=BmfKz5wW+dYk+HkplfJcIYED5kFDqbP39J96E28ldfS884AnRb+ID7NyEJmTwOAsIG
         1HwhhAipPxGF3pJ8t380Y0xuZQyc3QwJmMQ4F8oVT8/Z2efyrlYbE6sQ8vWyuXzAoxHK
         ZxdaIOCbcBKjXcMoZbAUPEDKpA61NJbWHYlNC/cyKbcGgliGT6sLsXNpQoIh00+wEviA
         RMJWmu8vbX3eAUYeNuxLuyyVw4E0l1Kl7QfJxzysnqRo7xrk5/7UXu1ShZdHp9n9tMuf
         twPgMB25fe3sj2/vF3fqYHCt6w2hEtlm6lZOwFiiyjokTU6AZND8VMjJW2PAywXDf8QN
         wktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecJdDWCLZdqRRH5zcH4heHVXHsxA6MaHJTTe6+QsOfE=;
        b=q6oYBqsebmaj71IJHVeB/JlvHzEMx2Hj4XC3AkM/6v2ndfr1GmUOuwk5ojgxWrllx1
         LOK3daqbXFVuV+mvAYxTro714HY0lfPAQBQiHmZG/Zy+ouip3po6Zy3Lj5m38gWfd5ey
         ss1MRDqqXS1sSZFf1WIgbtZ7zr29uTWQpM7xpJtwIErmFvJIzrIoTz3AGZnjZLa+ouv7
         Oa425EcA8PH6ax/vWX3UfJPr3t3mYcJPfVxk+pHEbBwCIO1LnGpr2uzSYqzXYwaGD7E9
         3gR/6GYRr3/MAnN9/CF0gRNN2i7UVytO4WRXnGgPh0DLpKNcrVRswab3dQRRYWI4szyp
         +3Og==
X-Gm-Message-State: AOAM5306yHrshO1JnqHGHD/AgqLIdzJHJjVWt5wHeDhFw2tvFCm8Mtac
        ld41zPqVuHku1k7sWdiIG6h3ys+1msw2Gw==
X-Google-Smtp-Source: ABdhPJwlh+i4RRkb2v2R0hNcC1vcEOcleoeOQIL+slPQp9xNRim1k+8dyZMQ1nm21TtMp0zJx4AKYw==
X-Received: by 2002:a17:906:1986:: with SMTP id g6mr14154283ejd.265.1623661419635;
        Mon, 14 Jun 2021 02:03:39 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4960:8600:dc5e:964f:b034:cb7d])
        by smtp.gmail.com with ESMTPSA id qq26sm6764355ejb.6.2021.06.14.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 02:03:39 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCHv3 for-next 1/5] RDMA/rtrs-srv: Set minimal max_send_wr and max_recv_wr
Date:   Mon, 14 Jun 2021 11:03:33 +0200
Message-Id: <20210614090337.29557-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614090337.29557-1-jinpu.wang@ionos.com>
References: <20210614090337.29557-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Currently rtrs when create_qp use a coarse numbers (bigger in general),
which leads to hardware create more resources which only waste memory
with no benefits.

For max_send_wr, we don't really need alway max_qp_wr size when creating
qp, reduce it to cq_size.

For max_recv_wr,  cq_size is enough.

With the patch when sess_queue_depth=128, per session (2 paths)
memory consumption reduced from 188 MB to 65MB

When always_invalidate is enabled, we need send more wr,
so treat it special.

Fixes: 9cb837480424e ("RDMA/rtrs: server: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 38 +++++++++++++++++---------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 5639b29b8b02..04ec3080e9b5 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1634,7 +1634,7 @@ static int create_con(struct rtrs_srv_sess *sess,
 	struct rtrs_sess *s = &sess->s;
 	struct rtrs_srv_con *con;
 
-	u32 cq_size, wr_queue_size;
+	u32 cq_size, max_send_wr, max_recv_wr, wr_limit;
 	int err, cq_vector;
 
 	con = kzalloc(sizeof(*con), GFP_KERNEL);
@@ -1655,30 +1655,42 @@ static int create_con(struct rtrs_srv_sess *sess,
 		 * All receive and all send (each requiring invalidate)
 		 * + 2 for drain and heartbeat
 		 */
-		wr_queue_size = SERVICE_CON_QUEUE_DEPTH * 3 + 2;
-		cq_size = wr_queue_size;
+		max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
+		max_recv_wr = SERVICE_CON_QUEUE_DEPTH + 2;
+		cq_size = max_send_wr + max_recv_wr;
 	} else {
-		/*
-		 * If we have all receive requests posted and
-		 * all write requests posted and each read request
-		 * requires an invalidate request + drain
-		 * and qp gets into error state.
-		 */
-		cq_size = srv->queue_depth * 3 + 1;
 		/*
 		 * In theory we might have queue_depth * 32
 		 * outstanding requests if an unsafe global key is used
 		 * and we have queue_depth read requests each consisting
 		 * of 32 different addresses. div 3 for mlx5.
 		 */
-		wr_queue_size = sess->s.dev->ib_dev->attrs.max_qp_wr / 3;
+		wr_limit = sess->s.dev->ib_dev->attrs.max_qp_wr / 3;
+		/* when always_invlaidate enalbed, we need linv+rinv+mr+imm */
+		if (always_invalidate)
+			max_send_wr =
+				min_t(int, wr_limit,
+				      srv->queue_depth * (1 + 4) + 1);
+		else
+			max_send_wr =
+				min_t(int, wr_limit,
+				      srv->queue_depth * (1 + 2) + 1);
+
+		max_recv_wr = srv->queue_depth + 1;
+		/*
+		 * If we have all receive requests posted and
+		 * all write requests posted and each read request
+		 * requires an invalidate request + drain
+		 * and qp gets into error state.
+		 */
+		cq_size = max_send_wr + max_recv_wr;
 	}
-	atomic_set(&con->sq_wr_avail, wr_queue_size);
+	atomic_set(&con->sq_wr_avail, max_send_wr);
 	cq_vector = rtrs_srv_get_next_cq_vector(sess);
 
 	/* TODO: SOFTIRQ can be faster, but be careful with softirq context */
 	err = rtrs_cq_qp_create(&sess->s, &con->c, 1, cq_vector, cq_size,
-				 wr_queue_size, wr_queue_size,
+				 max_send_wr, max_recv_wr,
 				 IB_POLL_WORKQUEUE);
 	if (err) {
 		rtrs_err(s, "rtrs_cq_qp_create(), err: %d\n", err);
-- 
2.25.1

