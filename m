Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60913382812
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhEQJUn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbhEQJUf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4AFC061760
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id et19so1043124ejc.4
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nzWg2WdxSRFvsIuV0pZDFdY4JIfzwTgd0gPbycE6Cw8=;
        b=GWsFowwnpd6LCGkPXIaIjhxSKqPavOwndO5QTuSqQGhk9AIl7Mr0hKhjVHRd5MztrZ
         IH7UvO/PppsZDxhJbJIQ2yHxkcxNAnjM4vpplzNV24KB48OehCb5/5Tcv3dwdqzhfmeX
         P/1V3hkSWkMGNBrfF7K9dePGNL8e4DFR/s+KCETVsk+obyw/ptP4WY7+kCC+b2dZGXNp
         4wXndBxXhpScvgqu0Im7lKW4PzAOZ9YQCcyK4xhK9F8oiadF+8fo0Mk+5KdVOmZvSAZn
         E+clihQBEPiIceG9g5GGEpVIwG+LMDdA7D2QBxdeVuby++kH2+KXriaKAlWLuryYSjgC
         +BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nzWg2WdxSRFvsIuV0pZDFdY4JIfzwTgd0gPbycE6Cw8=;
        b=S2xmq16orp+VeQKifiox7nu1qZhpdJp/ORDCj2fQ4LOVrkfMFFFG/Xs6/A6uwEMtzw
         TqmKuG2SWIYCw45c3zpRBk6tAwCpec84IE+d6yhdpbKFooL7C9YTMrfPbHWETYjmaSeA
         zO6J/X1GjzTkAA8fIVre1UtYFizlgSd24ilnzom9aV6pdqSpYCHhSTrUfZY/tUoPpJcX
         qcXpR5vb+KVEoAXu+oGqWrXqo2P2kWC0RsDOMIkAmujLUO1Mp7pxYF96SL+hgXliZXj3
         9EMsFd8XJp5QRi8s5LmxKnAxLGfGjYbkwg1neXaCghD6Y1J6163EXDnh7xOW3YNtFfRU
         ovZg==
X-Gm-Message-State: AOAM5336swR7BFHTLsOoy3tAon8IwMz2vIVFWchojISTvV692EoX4t+d
        /Yvt1wOyhT/PebcDaHcCxqQLcPZRwbKR2Q==
X-Google-Smtp-Source: ABdhPJzuCfqu5oesW0f67r6+D72WjZMUd01OIf1Wkk6G4e2rHPg9hClgcj4iwCg+NF37XMfG1A8DPg==
X-Received: by 2002:a17:906:5786:: with SMTP id k6mr24473322ejq.198.1621243157866;
        Mon, 17 May 2021 02:19:17 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:17 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 03/19] RDMA/rtrs-srv: Add error messages for cases when failing RDMA connection
Date:   Mon, 17 May 2021 11:18:27 +0200
Message-Id: <20210517091844.260810-4-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

It was difficult to find out why it failed to establish RDMA
connection. This patch adds some messages to show which function
has failed why.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 3d09d01e34b4..df17dd4c1e28 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1356,8 +1356,10 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 	 * If this request is not the first connection request from the
 	 * client for this session then fail and return error.
 	 */
-	if (!first_conn)
+	if (!first_conn) {
+		pr_err("Error: Not the first connection request for this session\n");
 		return ERR_PTR(-ENXIO);
+	}
 
 	/* need to allocate a new srv */
 	srv = kzalloc(sizeof(*srv), GFP_KERNEL);
@@ -1812,6 +1814,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
 	if (IS_ERR(srv)) {
 		err = PTR_ERR(srv);
+		pr_err("get_or_create_srv(), error %d\n", err);
 		goto reject_w_err;
 	}
 	mutex_lock(&srv->paths_mutex);
@@ -1850,11 +1853,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 			mutex_unlock(&srv->paths_mutex);
 			put_srv(srv);
 			err = PTR_ERR(sess);
+			pr_err("RTRS server session allocation failed: %d\n", err);
 			goto reject_w_err;
 		}
 	}
 	err = create_con(sess, cm_id, cid);
 	if (err) {
+		rtrs_err((&sess->s), "create_con(), error %d\n", err);
 		(void)rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since session has other connections we follow normal way
@@ -1865,6 +1870,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	}
 	err = rtrs_rdma_do_accept(sess, cm_id);
 	if (err) {
+		rtrs_err((&sess->s), "rtrs_rdma_do_accept(), error %d\n", err);
 		(void)rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since current connection was successfully added to the
-- 
2.25.1

