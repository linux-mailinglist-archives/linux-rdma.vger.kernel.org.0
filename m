Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A2238280F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhEQJUm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbhEQJUf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D325BC061756
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b25so8132152eju.5
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6EI52IIlNI4w1Nlt/vfdZD9cdsfvEGqc5T/50OPfZE=;
        b=HCMS7Is0fRrk3ofF1gCAKqFFwG6vXMZbxfLH4FJx5Tpi3GGSoKbeeuW3ziHB19iJvM
         yzIIauDtn1gkZnctiPJnt9kwNJuhlx3GdjXkt9GmNPW3R5MxsHLyciKc5F/Caq6R08aM
         4ZDipFKwb1FqMy/Tb21PYYdChzZomc9KWWH5/S/XW/bR71m4ge7MiUmhT12Gb3jAGcTQ
         gxFyGSh7Q85hjOf1vNbHBDBCwvhTn5AdG2Xeuu0l1mwzinhpTENPxvh50wcqwqPAJmr2
         DUOEbJM7GDS2tJ/z6AdmpGjm8Pg1fpAuRQQ56rpAeNlIqZr5HvpVUa62f3dbfhvuYpkv
         PhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6EI52IIlNI4w1Nlt/vfdZD9cdsfvEGqc5T/50OPfZE=;
        b=kjL/WsqZoIiaxsKwxokCYJRDdzwrVTCjV5CxCa4BMTTi9oqFxQbDil3sM/NND4GuSv
         jFkxd/tBM/befMn+inmybNPMkh5Zq1K4/QJiBFgbDP8XmRSpuAt2t+db85YeXzo5ldXl
         MUMl8Q4lV03QQSEalW/8L9EVDAQXK5CivbyTSm2X48gNejeYaXLXN3kXzcKDwMmSLDOY
         2Gh135/FiRdTr+8VkBe0DbKRvzlawrs2+sDT7vmH2mwJuAgtwqRZu09AdjQlNShVu2iJ
         0n1yug/+GrgsEf+c1agsUVeRG3Xj37PvCAJqBf4jU5eXZmtm2bEe88id2J4SrNBBxSzQ
         gCSg==
X-Gm-Message-State: AOAM532eyI+0c2GMLwchDKJJIrgSb0dPWOhtHpIxfygL7sVoZjqFyRVm
        UvSGD6ZvVipWhsLaMP/9WaLjCU1R0UIM7A==
X-Google-Smtp-Source: ABdhPJxr8fWjPr5wSFW0rELfg9iGrnjK8U3kGOhtaFsL5sK41rRsB8A/74Xe1s8oTM9+iOBJ2QI56A==
X-Received: by 2002:a17:906:bb0e:: with SMTP id jz14mr60487620ejb.285.1621243156468;
        Mon, 17 May 2021 02:19:16 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:16 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 01/19] RDMA/rtrs-srv: Kill reject_w_econnreset label
Date:   Mon, 17 May 2021 11:18:25 +0200
Message-Id: <20210517091844.260810-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
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
index 740cafffb7ef..3d09d01e34b4 100644
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

