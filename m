Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952AD296A70
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375763AbgJWHoA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374512AbgJWHn7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:43:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC46C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:43:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t25so1013227ejd.13
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T64CeVHz2c2Fu8Ot+IkGyFuzsWlnfqfpHdTmtUIvzdQ=;
        b=UXPqOAK3jZz/tURbCkKvEjOrkgQ+mf3rDiFTh+czpvt43Sv+sSekIsEsGcb03H0SV+
         h00ok5JcscwJXud4QldLt5ChPwG1zI4oupevmINzoEJtLcXf91hxAIMeIJ4CXLxT2KTu
         3TzCFll21b989FNHcBgfhi6i3epl/fSq7n0F/BD5H2UNCRzdc0YYzdINMinTRmAYsm1v
         BDCUWCJVPefh+dE6OmccFtM8ViJJ8NfyEAPD467PSk95ExTFBJhe8w8eBNAlkA3D5Slo
         G+ybGLyWG+JxS1LMno9yqsa6PmgpUW+b1JhFjK6Expcm5gftKj/hQ6ivJIVBndPwII0b
         8PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T64CeVHz2c2Fu8Ot+IkGyFuzsWlnfqfpHdTmtUIvzdQ=;
        b=iBpbrlxrGSXUiV7ZbqAEippIuj398QIHy8q1CDB+36Gzck4Y/NM2awlSyIuKKVctla
         0yvsLVhmlm6WNVYlAULfxZhhlECr9uRklSBoD49ZZa8TZNEIk0Bd6aQ+HjIK67iaIbma
         GEVxh/8EnVydKcQ0RsWTNxu2zuSfV+tnPmqwa0kcIFDgMG8f7vMj9pZXJFiUN9tH51wh
         ZyBbp+Y+e04NawRWi+8XGK3XjkqQLAsy/Xt/qQFS6ZdsUglChUdggoul1YJdSi/x5t7b
         /50OhzzHbrMvgn1sH22XCRa9xxVqRkn/8cOTXCOAV7qUdFjyrs9/4X9w9Tg/muvNRIUp
         NXZQ==
X-Gm-Message-State: AOAM532OcnUDODMy/a74F73kmxTWkGzj2oYP8fgghJ3L7i9UYlQT7Bnr
        6WV8lexFKEzGgFiQwI4rZC6b9K+zBbLPtg==
X-Google-Smtp-Source: ABdhPJy3SCFbQ1cupHAtVQxHS7IDlBPvysvpSx/22xQDeqCfWCKbOGv75bUsvVSOPyAJnAFx+fyDVw==
X-Received: by 2002:a17:907:43c0:: with SMTP id ok24mr716043ejb.385.1603439037779;
        Fri, 23 Oct 2020 00:43:57 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:43:57 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 03/12] RDMA/rtrs-clt: avoid run destroy_con_cq_qp/create_con_cq_qp in parallel
Date:   Fri, 23 Oct 2020 09:43:44 +0200
Message-Id: <20201023074353.21946-4-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It could happen two kworkers race with each other:

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

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
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

