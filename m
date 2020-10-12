Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7219F28B5E3
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbgJLNSW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388135AbgJLNSW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA57C0613D1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cq12so16902844edb.2
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UiUFAeadu17toubshf2hcLBFxF9ODfT8eqY9HxjBaiM=;
        b=YwOqiZBhqUro+C6EDsek32boxSo4oCYTYwg4mPTABJT/z8lFSYaWjaff4CsszFaDHr
         BO+VxbPoEQhDmxP1MEZ0AQ5zGFoOaLWvoXcraxPfUq2FSnx1T5D2XQq8/g7qZet5iEsm
         HQGhwUrMXgROPw47pMrjKJbu6H/dzGbQ5vPEAwbWXJHaFEafru0k5g63NAROOYtZs6MI
         b5/2F9Pa3fevy9+xcLu/JIwpRt7dEE+037nbIJFgPCKq1HqUagQpvdAP/V1Hvxv2mNKF
         gs9gRwajCF5rmA5jJlBwuU4cHTDQBp6hWy7DEdzVtekANGNcHAL9n+h6yICfWpjL/KkN
         mS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UiUFAeadu17toubshf2hcLBFxF9ODfT8eqY9HxjBaiM=;
        b=uG552BQxsLShotdgTgBleEbe6ei1Zp5dFjCkXTIuUEbjZnLc2rWavAVvVpvG2xS/Zt
         EHDAddtbfi0N9CXj0YN/NyIxDFcoKeMf/kuz7AFHBn/n4nJNwUXHt+IpFQZhBKivCEn5
         9t+etigXGXMhtx829qhpRHhiAIk3O1x9Z+zyWj9kDLj3Dzx8xrM0r3Whnaj3S4CKkPHM
         xgikke1E0GteW7xVjQLROt8eXl9OgHmM/XivLsjrlFfcyqQQjOoKYKGPT+8bofP6lTD3
         cp/Jr3vwBL9SqZD6dMjlH9FGieF8Ygq2vjVd64rWhZ2zVyvfl8EDw/p4WLsz/PlDucgY
         UI4Q==
X-Gm-Message-State: AOAM533QS4tx5DO59KVlW/QhVYvJiiU48Lf1OyDGnYJIwuDDyfkqcQkV
        NNBFB8b9cssTIVmryQehoM6OJB4F9SGSHw==
X-Google-Smtp-Source: ABdhPJyhSfebnC3atsXGQcWyEn/FSGmwnmM6XlTz6ck1De8YauvojSP/jUp0fMaxY2ryynYjurlfYg==
X-Received: by 2002:a50:d654:: with SMTP id c20mr2911731edj.54.1602508700030;
        Mon, 12 Oct 2020 06:18:20 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:19 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 04/13] RDMA/rtrs-clt: remove unnecessary dev_ref of rtrs_sess
Date:   Mon, 12 Oct 2020 15:18:05 +0200
Message-Id: <20201012131814.121096-5-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

dev_ref of rtrs_sess is used for counting connections sharing
the rtrs_ib_dev object. But rtrs_ib_dev has its own reference counter.
We can use rtrs_ib_dev_get/put.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 35 +++++++++++---------------
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 -
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 4677e8ed29ae..b1c0c1400c8a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1523,6 +1523,19 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 	struct rtrs_msg_rkey_rsp *rsp;
 
 	lockdep_assert_held(&con->con_mutex);
+	/*
+	 * The whole session uses device from user connection.
+	 * Be careful not to close user connection before ib dev
+	 * is gracefully put.
+	 */
+	sess->s.dev = rtrs_ib_dev_find_or_add(con->c.cm_id->device,
+					      &dev_pd);
+	if (!sess->s.dev) {
+		rtrs_wrn(sess->clt,
+			 "rtrs_ib_dev_find_get_or_add(): no memory\n");
+		return -ENOMEM;
+	}
+
 	if (con->c.cid == 0) {
 		/*
 		 * One completion for each receive and two for each send
@@ -1531,23 +1544,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		 * in case qp gets into error state
 		 */
 		wr_queue_size = SERVICE_CON_QUEUE_DEPTH * 3 + 2;
-		/* We must be the first here */
-		if (WARN_ON(sess->s.dev))
-			return -EINVAL;
 
-		/*
-		 * The whole session uses device from user connection.
-		 * Be careful not to close user connection before ib dev
-		 * is gracefully put.
-		 */
-		sess->s.dev = rtrs_ib_dev_find_or_add(con->c.cm_id->device,
-						       &dev_pd);
-		if (!sess->s.dev) {
-			rtrs_wrn(sess->clt,
-				  "rtrs_ib_dev_find_get_or_add(): no memory\n");
-			return -ENOMEM;
-		}
-		sess->s.dev_ref = 1;
 		query_fast_reg_mode(sess);
 	} else {
 		/*
@@ -1560,8 +1557,6 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		if (WARN_ON(!sess->queue_depth))
 			return -EINVAL;
 
-		/* Shared between connections */
-		sess->s.dev_ref++;
 		wr_queue_size =
 			min_t(int, sess->s.dev->ib_dev->attrs.max_qp_wr,
 			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
@@ -1604,10 +1599,8 @@ static void destroy_con_cq_qp(struct rtrs_clt_con *con)
 		con->rsp_ius = NULL;
 		con->queue_size = 0;
 	}
-	if (sess->s.dev_ref && !--sess->s.dev_ref) {
-		rtrs_ib_dev_put(sess->s.dev);
+	if (rtrs_ib_dev_put(sess->s.dev))
 		sess->s.dev = NULL;
-	}
 }
 
 static void stop_cm(struct rtrs_clt_con *con)
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 0a93c87ef92b..287ff78921c7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -103,7 +103,6 @@ struct rtrs_sess {
 	unsigned int		con_num;
 	unsigned int		recon_cnt;
 	struct rtrs_ib_dev	*dev;
-	int			dev_ref;
 	struct ib_cqe		*hb_cqe;
 	void			(*hb_err_handler)(struct rtrs_con *con);
 	struct workqueue_struct *hb_wq;
-- 
2.25.1

