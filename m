Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD59D3A41C0
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 14:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhFKMMj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 08:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhFKMMg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Jun 2021 08:12:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C35BC0617AF
        for <linux-rdma@vger.kernel.org>; Fri, 11 Jun 2021 05:10:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id f5so31833731eds.0
        for <linux-rdma@vger.kernel.org>; Fri, 11 Jun 2021 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDchXq1U7bxiKpYRoM1OPck9C6cBNIdyhJ33mP+Q4lE=;
        b=VJnMZFPdr6RSLzUigf6FB+dK+CTa+INedTkyhilssu2qmb/a+m+o3XfvYV24OVuaEF
         6EIgtQj6fcI9CS1mRY28WzgKseR8CDLkDVPaVepV3uNpSoSsn4fr6yYa9SKe12Na5Im0
         1iJjg1QFYjeK47PzzdxCMOz+rEkUXB52hQDAge0mF5CJN/hBa9qaCmJVnKoSk0U+mxs6
         926q0/2gbgNkhh4LaGl43OtzY8fsai1QRogNhR8siifcinlcxfNlvtLk7Xl4hqZHAJZ4
         uc8Zz727In/rDlsnL0uV9lUMaN6YMumT1DXfrtlTccft3skPNhzQeUb/hjBA3tIsoAoM
         ys7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDchXq1U7bxiKpYRoM1OPck9C6cBNIdyhJ33mP+Q4lE=;
        b=rhmB16BO6lUIuc5fFPzsHtQ1vAWl3je6hAoEQrSPlWqoIjWmmFvWr/TeJrfQdDklNZ
         XUnfjxV8yuWkr/sEN1VygiYtX+i0DUsOJ7ZspvpHDpxz5CkuqRJ5fo4npvgrsGRcW0Fy
         1IK8GwLDL+ACZYA1yrL8227hSSjMolhfMB/ClLnoojK0yBF3IvGx6vCI/VgHMyxg0ysN
         UQ7hTZvv+fijCdn9GDlURmf49nFHVgF7hLcKCwayznV3tOmexw9xuhykxomTybc7IFI8
         9fNfshXqMrODIXce1IRBW4gZ3eyXHVQjWQfnV9b989Wwr7axr8vZSWOw/L8W7U08D6Es
         9/lg==
X-Gm-Message-State: AOAM530Bbgs5bWdRXvwGrJKVATivltzv3q3icYaAwB4iWJxHTokx6Ng7
        FS+3MDmdAYSBvsXOVGWf4ijOLAN/AguKNQ==
X-Google-Smtp-Source: ABdhPJzCRUMaTlR1T41xFfvWZIvYoLBr0j4PnsJcSXi4rrip6gXNhA1OrPpDhsgxGU0JjAQG3mnUdA==
X-Received: by 2002:aa7:d558:: with SMTP id u24mr3344780edr.331.1623413436833;
        Fri, 11 Jun 2021 05:10:36 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4954:2e00:fd6f:fc71:2689:4a7a])
        by smtp.gmail.com with ESMTPSA id n11sm2084116ejg.43.2021.06.11.05.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 05:10:36 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 1/5] RDMA/rtrs-srv: Set minimal max_send_wr and max_recv_wr
Date:   Fri, 11 Jun 2021 14:10:30 +0200
Message-Id: <20210611121034.48837-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210611121034.48837-1-jinpu.wang@ionos.com>
References: <20210611121034.48837-1-jinpu.wang@ionos.com>
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

