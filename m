Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6C3C43DA
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 08:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhGLGKq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 02:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhGLGKq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jul 2021 02:10:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03439C0613E8
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 23:07:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h18-20020a05600c3512b029020e4ceb9588so13603308wmq.5
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 23:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VInWHDB2M54SAf2pi/ohFQ/fjdS46jXhiC35qkGExsU=;
        b=SCOCwk1BoDZevRcBQGb8oTeXcN4KFAhYFcUWZX1sCejSWdc/GrXTnTOeaxcfgsL/ao
         6Ikau/SCURt0VlMTdg6jH5Roa41O7hFy1bkAOR2UkZCv5h0yWLHJaIfIExmxTAfXjIqr
         ZNMKyJyS+cz4oV8bzvhfJXo/tVykL/71HpSUioXdcpo/nvdND6IqI3tuEdYFFJmt+qZt
         mlA5qK9u9EcGhD74qCDepCdQ0Cg7fttgJ3GjADjL+vtKzGqhllYzNc5F2gNvB5N19ipE
         4Wd2/dw2FIxgDQY0AXFID7PZNdyFMIgrt9mktPfED33YDU9h48CY/k/uNRU2kSsbVgiD
         fm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VInWHDB2M54SAf2pi/ohFQ/fjdS46jXhiC35qkGExsU=;
        b=R6rovbkdQC7ndcR+44Quxmrt77nU3+MKZHj0hLv+tlcPW+oBPdMx/WBlkf9Rfg3K9g
         047xOJ5FfiYoFAt7Tu4dT502YzGyxFbKY9nknlghcMmGwkj6n9hiDSfHlhB3P47VMW2E
         a/+cogo/pfDn3Ml1cZkkjxfOgE5mjgYj0Lkav9kIh8vaeIIc1bWW4ZKvX9VN/xcFBzOb
         hMWMOto5AAIO8yT/a+TCC5sidZg0d4vfvGwO2SXrmZFpNB/Kzusry0dDIptmdqbXGDzv
         /2K5IgTWpsosMdz7L4KA5mtJwExpbXQLbQdFdeacjphGJTcxvMcpeLfwTClrGFhcNCG+
         0v8g==
X-Gm-Message-State: AOAM532XCYG2kb2fZYpA9M+uIjRz38VZVmIZ2ZFKC4R13TzeYAIWf7ck
        M4iA+KVuuJE59rpJlZpsviG8qv6xtyPcmA==
X-Google-Smtp-Source: ABdhPJz3ikkHnnMztBw4qqixovFnev5cFOZvNOqHbhHr7F1cWGN60i659MHma5FR84Sbpi6sPrG0bw==
X-Received: by 2002:a05:600c:1c1f:: with SMTP id j31mr600321wms.132.1626070076477;
        Sun, 11 Jul 2021 23:07:56 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49bc:8600:895c:e529:e1b8:7823])
        by smtp.gmail.com with ESMTPSA id s17sm13344245wrv.2.2021.07.11.23.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 23:07:56 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-rc 6/6] RDMA/rtrs: Move sq_wr_avail to rtrs_con
Date:   Mon, 12 Jul 2021 08:07:50 +0200
Message-Id: <20210712060750.16494-7-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210712060750.16494-1-jinpu.wang@ionos.com>
References: <20210712060750.16494-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to account HB for sq_wr_avail properly,
move sq_wr_avail from rtrs_srv_con to rtrs_con.

Although rtrs-clt do not care sq_wr_avail, but still init it
to max_send_wr.

Fixes: b38041d50add ("RDMA/rtrs: Do not signal for heatbeat")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 ++++----
 drivers/infiniband/ulp/rtrs/rtrs-srv.h | 1 -
 drivers/infiniband/ulp/rtrs/rtrs.c     | 1 +
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index f023676e05e4..ece3205531b8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1680,6 +1680,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 			      sess->queue_depth * 3 + 1);
 		max_send_sge = 2;
 	}
+	atomic_set(&con->c.sq_wr_avail, max_send_wr);
 	cq_num = max_send_wr + max_recv_wr;
 	/* alloc iu to recv new rkey reply when server reports flags set */
 	if (sess->flags & RTRS_MSG_NEW_RKEY_F || con->c.cid == 0) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 76581ebaed1d..d12ddfa50747 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -97,6 +97,7 @@ struct rtrs_con {
 	unsigned int		cid;
 	int                     nr_cqe;
 	atomic_t		wr_cnt;
+	atomic_t		sq_wr_avail;
 };
 
 struct rtrs_sess {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 44ed15f38896..cd9a4ccf4c28 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -507,11 +507,11 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 		ib_update_fast_reg_key(mr->mr, ib_inc_rkey(mr->mr->rkey));
 	}
 	if (unlikely(atomic_sub_return(1,
-				       &con->sq_wr_avail) < 0)) {
+				       &con->c.sq_wr_avail) < 0)) {
 		rtrs_err(s, "IB send queue full: sess=%s cid=%d\n",
 			 kobject_name(&sess->kobj),
 			 con->c.cid);
-		atomic_add(1, &con->sq_wr_avail);
+		atomic_add(1, &con->c.sq_wr_avail);
 		spin_lock(&con->rsp_wr_wait_lock);
 		list_add_tail(&id->wait_list, &con->rsp_wr_wait_list);
 		spin_unlock(&con->rsp_wr_wait_lock);
@@ -1268,7 +1268,7 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		 * post_send() RDMA write completions of IO reqs (read/write)
 		 * and hb.
 		 */
-		atomic_add(s->signal_interval, &con->sq_wr_avail);
+		atomic_add(s->signal_interval, &con->c.sq_wr_avail);
 
 		if (unlikely(!list_empty_careful(&con->rsp_wr_wait_list)))
 			rtrs_rdma_process_wr_wait_list(con);
@@ -1680,7 +1680,7 @@ static int create_con(struct rtrs_srv_sess *sess,
 		 */
 	}
 	cq_num = max_send_wr + max_recv_wr;
-	atomic_set(&con->sq_wr_avail, max_send_wr);
+	atomic_set(&con->c.sq_wr_avail, max_send_wr);
 	cq_vector = rtrs_srv_get_next_cq_vector(sess);
 
 	/* TODO: SOFTIRQ can be faster, but be careful with softirq context */
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 6785c3b6363e..e81774f5acd3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -42,7 +42,6 @@ struct rtrs_srv_stats {
 
 struct rtrs_srv_con {
 	struct rtrs_con		c;
-	atomic_t		sq_wr_avail;
 	struct list_head	rsp_wr_wait_list;
 	spinlock_t		rsp_wr_wait_lock;
 };
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index b56dc5b82db0..ca542e477d38 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -191,6 +191,7 @@ static int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con,
 	struct rtrs_sess *sess = con->sess;
 	enum ib_send_flags sflags;
 
+	atomic_dec_if_positive(&con->sq_wr_avail);
 	sflags = (atomic_inc_return(&con->wr_cnt) % sess->signal_interval) ?
 		0 : IB_SEND_SIGNALED;
 
-- 
2.25.1

