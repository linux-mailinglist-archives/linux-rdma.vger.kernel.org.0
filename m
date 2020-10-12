Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF12328B5E4
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbgJLNSW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbgJLNSW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:22 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D962C0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:20 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lw21so23121562ejb.6
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zbcIR1//2G15w7P9phTD1z0NMWxAtwrzBqycVb8EBrU=;
        b=YCou1t+bwu02dPB0ZWRLVrq6EmdwYpQt2OOGJh4WfFQ2ha/IsCo5VVnpycCRD0vDE7
         5U4BxaFCfD5FC8VBNheJoKejZ0ongFjBQalgx4UPSm1VZlomc2519d9w/ZxQPbkyajWp
         SexAce5yPyro1h8nYReuRhPm2Rczm1kPs2UcTqZC6jdvu7yl9Xz5Tp+0CBTjEUFLOpb1
         RT08+dwub1TyrQkgTsoUHVgL7UGBRHaGXjaaXzs6HCc2cwNuNm9fgL+zq4i8BgbI8oZ1
         sWJ2KjkNFDDtJq8vRa0Tg1sWkFqMx3gnpBKX812Op2ZFOfGfV3DbBHHFLkz0WZbncpck
         rP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zbcIR1//2G15w7P9phTD1z0NMWxAtwrzBqycVb8EBrU=;
        b=mI+Fww3NU5qa8Xod4CPS/RfMkBTAGwtujq3T/0diN3eAc0l0WgdzNbw+gyN9ON9SbC
         JwAP3AOWx22wJd4Jt3V3DNGspyd+j7tE6Ieui0Ms/njUIVAYPjJYPv8rsbwziuDEGeno
         DgbNVFO06kBtYDDp6S+HW2ch++2g5PSm9F0quP0Mwfq/5CrUPlHNLB1J6m2PkPf3Fcm1
         H5mkj8+DYl1zguqySo+nR/1fUSQjY7cFd7IBwkhW+iK1bxHFl7PS8ffyRUQ2q+mmr8HZ
         enFW2E4CzGnqvqKaHEV5A0jv7hFPsiBvy/6QAy476pslqpF8UrmjIVV54cf5DH8XQe0z
         vTZw==
X-Gm-Message-State: AOAM533pnE2zOCJucgD1/SUOz8HzML9ql65hfGkRkWJIJb/zHnGeacas
        Zi0jE79YpYeN/X7ygmtfb1Uqa9Ey5JqCdA==
X-Google-Smtp-Source: ABdhPJy+ODlUNussBRbG75XJmDDxKQ28YiyGXlyS8dp6+xWmte648afwnJNqNkmcnAVcW91sWeJFRA==
X-Received: by 2002:a17:906:4b57:: with SMTP id j23mr7817641ejv.338.1602508699001;
        Mon, 12 Oct 2020 06:18:19 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:18 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Subject: [PATCH for-next 03/13] RDMA/rtrs-clt: avoid run destroy_con_cq_qp/create_con_cq_qp in parallel
Date:   Mon, 12 Oct 2020 15:18:04 +0200
Message-Id: <20201012131814.121096-4-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For redmine #54314, too kworker.

    addr_resolver kworker           reconnect kworker
    rtrs_clt_rdma_cm_handler
    rtrs_rdma_addr_resolved
    create_con_cq_qp: s.dev_ref++
    "s.dev_ref is 1"
                                    wait in create_cm fails with TIMEOUT
                                    destroy_con_cq_qp: --s.dev_ref
                                    "s.dev_ref is 0"
                                    destroy_con_cq_qp: sess->s.dev = NULL
     rtrs_cq_qp_create -> create_qp(con, sess->dev->ib_pd...)
    sess->dev is NULL, panic.

To fix the problem using mutex to serialize create_con_cq_qp
and destroy_con_cq_qp.

redmine: https://redmine.pb.local/issues/54314

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 15 +++++++++++++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index fb840b152b37..4677e8ed29ae 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1499,6 +1499,7 @@ static int create_con(struct rtrs_clt_sess *sess, unsigned int cid)
 	con->c.cid = cid;
 	con->c.sess = &sess->s;
 	atomic_set(&con->io_cnt, 0);
+	mutex_init(&con->con_mutex);
 
 	sess->s.con[cid] = &con->c;
 
@@ -1510,6 +1511,7 @@ static void destroy_con(struct rtrs_clt_con *con)
 	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
 
 	sess->s.con[con->c.cid] = NULL;
+	mutex_destroy(&con->con_mutex);
 	kfree(con);
 }
 
@@ -1520,6 +1522,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 	int err, cq_vector;
 	struct rtrs_msg_rkey_rsp *rsp;
 
+	lockdep_assert_held(&con->con_mutex);
 	if (con->c.cid == 0) {
 		/*
 		 * One completion for each receive and two for each send
@@ -1593,7 +1596,7 @@ static void destroy_con_cq_qp(struct rtrs_clt_con *con)
 	 * Be careful here: destroy_con_cq_qp() can be called even
 	 * create_con_cq_qp() failed, see comments there.
 	 */
-
+	lockdep_assert_held(&con->con_mutex);
 	rtrs_cq_qp_destroy(&con->c);
 	if (con->rsp_ius) {
 		rtrs_iu_free(con->rsp_ius, DMA_FROM_DEVICE,
@@ -1625,7 +1628,9 @@ static int rtrs_rdma_addr_resolved(struct rtrs_clt_con *con)
 	struct rtrs_sess *s = con->c.sess;
 	int err;
 
+	mutex_lock(&con->con_mutex);
 	err = create_con_cq_qp(con);
+	mutex_unlock(&con->con_mutex);
 	if (err) {
 		rtrs_err(s, "create_con_cq_qp(), err: %d\n", err);
 		return err;
@@ -1938,8 +1943,9 @@ static int create_cm(struct rtrs_clt_con *con)
 
 errr:
 	stop_cm(con);
-	/* Is safe to call destroy if cq_qp is not inited */
+	mutex_lock(&con->con_mutex);
 	destroy_con_cq_qp(con);
+	mutex_unlock(&con->con_mutex);
 destroy_cm:
 	destroy_cm(con);
 
@@ -2046,7 +2052,9 @@ static void rtrs_clt_stop_and_destroy_conns(struct rtrs_clt_sess *sess)
 		if (!sess->s.con[cid])
 			break;
 		con = to_clt_con(sess->s.con[cid]);
+		mutex_lock(&con->con_mutex);
 		destroy_con_cq_qp(con);
+		mutex_unlock(&con->con_mutex);
 		destroy_cm(con);
 		destroy_con(con);
 	}
@@ -2213,7 +2221,10 @@ static int init_conns(struct rtrs_clt_sess *sess)
 		struct rtrs_clt_con *con = to_clt_con(sess->s.con[cid]);
 
 		stop_cm(con);
+
+		mutex_lock(&con->con_mutex);
 		destroy_con_cq_qp(con);
+		mutex_unlock(&con->con_mutex);
 		destroy_cm(con);
 		destroy_con(con);
 	}
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 167acd3c90fc..b8dbd701b3cb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -72,6 +72,7 @@ struct rtrs_clt_con {
 	struct rtrs_iu		*rsp_ius;
 	u32			queue_size;
 	unsigned int		cpu;
+	struct mutex		con_mutex;
 	atomic_t		io_cnt;
 	int			cm_err;
 };
-- 
2.25.1

