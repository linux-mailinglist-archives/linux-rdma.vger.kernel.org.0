Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E2039F394
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 12:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhFHKcg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 06:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFHKcg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 06:32:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7106BC061574
        for <linux-rdma@vger.kernel.org>; Tue,  8 Jun 2021 03:30:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w21so23833978edv.3
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDchXq1U7bxiKpYRoM1OPck9C6cBNIdyhJ33mP+Q4lE=;
        b=imspxvFrZM66F+NifpzUVKaXl+sX9q85pxPZP5pXLwWf4VAqST45kJBL2FtBFb6hgz
         Yyz0UKW5ws1r97VDeUrAdnbjCQeM9ZmoocfJS0Qb4SPnUFEHCzIOa6ScYS+lISSpuCMM
         d7NLhuNlWvL75jRuQ0Sf3/pHn1EWm8nQT2amr0V3oeWKOvERqFbkru4rsHmWQ/PjUdjm
         yCRVVUajilgM1EfcH1pDsjXwln6GLK1K+xmpuafnUAw9QkmDj0U95Wh8LhwD8prMLSAw
         pRzJOx/q6dJ7xTdGHkA1ARr6T1+PBkqOHBmk7lY+16fGjO6aEeUoD9DAJ4M1GRZvosvU
         vGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDchXq1U7bxiKpYRoM1OPck9C6cBNIdyhJ33mP+Q4lE=;
        b=RTnE6w8+tIBF9UawVxISSx6vbsyi99kS4ydNEeS5YRwzzoFXMiXdBvvHn42Xp23Iyp
         MoZMh82VnMlLcKi+cOjBlLTYfd6jSzTlHOmDAiKMRgIxGGsolH/uJE6y6IwKDrWrfsEZ
         v1gBmardkbI0NxOQphZTrhyIEJUtL/cei/Z9MLgBXirjWwSeEeXM8RDQeKnLnT6xDBWc
         HmK11mpBrvQAGCGiuRCQTennjv+NH5INpeqlIQ0X27sG92uc/0BwrNmR8dFLgLi4nh2Q
         w4OzPD0sxHpm432QWoR+0vGhQPk0x8s9V9+kuzgMjaiFaUFhDeJ5XE6l3F+CilwB5J9d
         85AA==
X-Gm-Message-State: AOAM532NgYoFcW2Pcvry94B9fCUZIMn11o/OO2F86wlDFd8cB5612WWp
        FaQyIxQdeq6WbJ2roQ1Tbu7MIPTSMJjhBA==
X-Google-Smtp-Source: ABdhPJwjkFIVHt2dURwgjpyKC1Jksxke5fAqETFQvk7G00pZW/iooVh9/sAc/egJtC1a0HK8gWnv8w==
X-Received: by 2002:a50:ee05:: with SMTP id g5mr4857785eds.73.1623148241891;
        Tue, 08 Jun 2021 03:30:41 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4943:5b00:2927:a608:b264:d770])
        by smtp.gmail.com with ESMTPSA id dy19sm8634400edb.68.2021.06.08.03.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:30:41 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 1/4] RDMA/rtrs-srv: Set minimal max_send_wr and max_recv_wr
Date:   Tue,  8 Jun 2021 12:30:36 +0200
Message-Id: <20210608103039.39080-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608103039.39080-1-jinpu.wang@ionos.com>
References: <20210608103039.39080-1-jinpu.wang@ionos.com>
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

