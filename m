Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27B537147C
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhECLtT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhECLtR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D95AC06174A
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y7so7366313ejj.9
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6EI52IIlNI4w1Nlt/vfdZD9cdsfvEGqc5T/50OPfZE=;
        b=FnoLLnB9Q0QeycX82/UAcNew5Bs5UCU2dsVOQgKHQOGLaX/6I0R3VAfZVtaJOOaQFm
         A9RA92e4LN+rYvkfPJho5vydRz2RwFSoNm7Fwb5H8oHQvUIw9Id2dm/9Gjj+P/IEDEze
         ID6ANeEldcFQP4iHK0xtyQ8ptvdlpZuMR3xZtQOEPJaRs0tqM7RDg3dJYO9pvQLa2OE6
         LE95+RPTiJ/GTlSIEGAL8Qy8NIOlcpxhpXmuy0bKcqKRDffyXdeOrcYnZJxoaNseZ948
         alJmwSHVm7eW1N7FBzdMO22mwZVxPiv8NgbsOiq2keF93TILIdibo8fQTLGR2a7R8Iwt
         MNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6EI52IIlNI4w1Nlt/vfdZD9cdsfvEGqc5T/50OPfZE=;
        b=iqMmAd8OTK3DFMfbIqJpmAtiG8Z4JsCjFD2fVA/uUStWkE+4G/mQWMlmlJgihVYYs+
         sz3mMmt3OywBUQ8G5pt9vy6QHhYYyULJbrPHNBsTVVadEXmcRCyg/HY8JGE9HS+IAVsw
         Bli9/JtRUjNsxs9tYQ8C81Ms/QQU/W0Xcm5osjwqn6v+g1q/zaRiRh9j1hr0/5KIK9Ei
         888Xmg9sgMfCiUvXUr/h27BjBxnq4Zrmt1HVoKji59HILSY/Mo3RpCHhCPvXudYNwpza
         3CGCwEzosdO2nweqmEgV2PihtoC9O8ELkY/PiIAS1AaBh2oDFdYAH2JH88o9NJFKpQW8
         Myeg==
X-Gm-Message-State: AOAM533KEBxzJF4//L/yI2wYstCZk1VgwVMu7s5wbwu43Y4cGr+pAfay
        LpSrvmo8PzAoHulzBIIJ78oF4yxzJud4yw==
X-Google-Smtp-Source: ABdhPJwN1JROtBko1a3rW6NqcAWFhhS3ccXtU+H3Tw1pzZkwc/lX7Svd9tj4d6Kpxxk1jQA8e8GWCg==
X-Received: by 2002:a17:906:3111:: with SMTP id 17mr15931235ejx.403.1620042501959;
        Mon, 03 May 2021 04:48:21 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:21 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 01/20] RDMA/rtrs-srv: Kill reject_w_econnreset label
Date:   Mon,  3 May 2021 13:47:59 +0200
Message-Id: <20210503114818.288896-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
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

