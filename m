Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C253941C1
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhE1LcF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbhE1LcD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BDAC061760
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id j9so4464069edt.6
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TYLHgeQhszM+/bQ2SSL6k+onPJ3gWhitmIrOhi+s9K8=;
        b=jNTsuYURtKJSgPRUkYLxdqT0n6nJqG2KkYAjm+lsQ1Ka2vyN3u1JbSSHjFRVGuJ5Ck
         eFgT1b+0X7dgM1jcx+0Tz4fu/qeMMVfkO2DCuMx/LeInxtY4jnZQ4uDulYAa8mV26Wqr
         TC/TfhQCbgAXmVclGmen/+zGNxbH1GDjbMg5RNpDM8hph1I4zxyPuoHmbth+H2dLzJuk
         xRH1ysRl0Di+fNdT8/lX5pWlu9zNOP09S2ISOJW+OACGlNssFR3yszGGS9D9RsNMVT1w
         LgA2SSQwXH96U/cINob5OqNfffR25gUArIvVTFR1BLPyTvPRmppObdqf1smSe1o+nfT4
         PVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TYLHgeQhszM+/bQ2SSL6k+onPJ3gWhitmIrOhi+s9K8=;
        b=V1+ExaVd267vxELbx0dbRtqzMjU8Dsw5Z4KEzACjjtGzAAsvM9seQwl+ADoXNPh1/1
         g/XIcmk+x/HakTSQzYrL3j2cjzHv65mZ+JNquMJ/yOtVGDCyVX23LG008RQ2gKD62U+8
         G1W0jWwzUhEcqIWpXyf+RGOxGi5jDx9ZfqaOs3SiWB6lqsOvr8mHgw1irTX+bdm0L1zN
         INHPtN33F/4G5B+a7CC9OFERz5OWU2kzf8Po/a32SOydOxFXL0EMxUaUtEM2OTUa0c16
         M7Ht3wthcRNcN4Enne1Bd2OIV5mY6EjFOatpYwHMRWumDhDJrOCV39eGl60fCeuoEIjp
         R6cA==
X-Gm-Message-State: AOAM533rpgXmIjHNwmSnhVH9fG0RFuLHxkHZ/EPIa+t36r/kWiUb9AGS
        oRstytlXKN1Vc/jI7lPeoregOV57bNWYEw==
X-Google-Smtp-Source: ABdhPJzIr8UyoQLr8EvbsGa0KLNg3jTfr8svu4K9uHFaCaHbKQlIvF9oFkygvJDdrLr6A2QP4Hnyew==
X-Received: by 2002:a05:6402:684:: with SMTP id f4mr9622036edy.25.1622201420639;
        Fri, 28 May 2021 04:30:20 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:20 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 01/20] RDMA/rtrs-srv: Kill reject_w_econnreset label
Date:   Fri, 28 May 2021 13:29:59 +0200
Message-Id: <20210528113018.52290-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

We can goto reject_w_err label after initialize err with -ECONNRESET.

Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 0fa116cabc44..cf3283acc8e8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1780,33 +1780,33 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 
 	u16 version, con_num, cid;
 	u16 recon_cnt;
-	int err;
+	int err = -ECONNRESET;
 
 	if (len < sizeof(*msg)) {
 		pr_err("Invalid RTRS connection request\n");
-		goto reject_w_econnreset;
+		goto reject_w_err;
 	}
 	if (le16_to_cpu(msg->magic) != RTRS_MAGIC) {
 		pr_err("Invalid RTRS magic\n");
-		goto reject_w_econnreset;
+		goto reject_w_err;
 	}
 	version = le16_to_cpu(msg->version);
 	if (version >> 8 != RTRS_PROTO_VER_MAJOR) {
 		pr_err("Unsupported major RTRS version: %d, expected %d\n",
 		       version >> 8, RTRS_PROTO_VER_MAJOR);
-		goto reject_w_econnreset;
+		goto reject_w_err;
 	}
 	con_num = le16_to_cpu(msg->cid_num);
 	if (con_num > 4096) {
 		/* Sanity check */
 		pr_err("Too many connections requested: %d\n", con_num);
-		goto reject_w_econnreset;
+		goto reject_w_err;
 	}
 	cid = le16_to_cpu(msg->cid);
 	if (cid >= con_num) {
 		/* Sanity check */
 		pr_err("Incorrect cid: %d >= %d\n", cid, con_num);
-		goto reject_w_econnreset;
+		goto reject_w_err;
 	}
 	recon_cnt = le16_to_cpu(msg->recon_cnt);
 	srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
@@ -1826,7 +1826,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 			rtrs_err(s, "Session in wrong state: %s\n",
 				  rtrs_srv_state_str(sess->state));
 			mutex_unlock(&srv->paths_mutex);
-			goto reject_w_econnreset;
+			goto reject_w_err;
 		}
 		/*
 		 * Sanity checks
@@ -1835,13 +1835,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 			rtrs_err(s, "Incorrect request: %d, %d\n",
 				  cid, con_num);
 			mutex_unlock(&srv->paths_mutex);
-			goto reject_w_econnreset;
+			goto reject_w_err;
 		}
 		if (s->con[cid]) {
 			rtrs_err(s, "Connection already exists: %d\n",
 				  cid);
 			mutex_unlock(&srv->paths_mutex);
-			goto reject_w_econnreset;
+			goto reject_w_err;
 		}
 	} else {
 		sess = __alloc_sess(srv, cm_id, con_num, recon_cnt,
@@ -1882,9 +1882,6 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 reject_w_err:
 	return rtrs_rdma_do_reject(cm_id, err);
 
-reject_w_econnreset:
-	return rtrs_rdma_do_reject(cm_id, -ECONNRESET);
-
 close_and_return_err:
 	mutex_unlock(&srv->paths_mutex);
 	close_sess(sess);
-- 
2.25.1

