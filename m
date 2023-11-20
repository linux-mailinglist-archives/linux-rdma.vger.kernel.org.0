Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287767F17A0
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 16:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjKTPl5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 10:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjKTPlz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 10:41:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6899A9F
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:52 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso20193175e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700494911; x=1701099711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kman/xJLhAuMy1tRZL/AJpioG6x/J/gCqlqLwwKfHac=;
        b=cXu7qcyvxc/5no1zkhLlzljxCHfbm7vYODoPJwkiCJndSlLq1fhyDMpqSGOc6h7Qfy
         ruUOjrTPDgwqcG1ayWoBa0gvhjDJK2wf5Xohjp3fGLCF0WstK7hKKPaxo4TI8Ketmqhn
         X+sKv8VLMU4iDm/zrB6TAz5oqUszrQhSIlQE/y8WURUFa9eA7kcIDqUO35rDDbOQKTw2
         GluC1U3oZ7RXn1x42HEE0k+Surr3XMY9hsNxrsNJSztkVW6ORsVdyUr7eWW+l/4Y+yIh
         AAtuRS83Ot9Ufz5KQnbMPMsPs9VzdNqYofo/fSnO/j4/gVdQjnf8gQBLHK9a9rTp4AfC
         k4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494911; x=1701099711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kman/xJLhAuMy1tRZL/AJpioG6x/J/gCqlqLwwKfHac=;
        b=TT1OL+rANqfX3zVnTpj/eauXYbdG1D5VJCCsj5Cgl+OOKO58joxUsPwXbrjATfC6/e
         lGpe/EANX4wwCEW2VPRttpAJ9w2ocU6iEjWNRleFGBQWL4fEOKGik0TUfEwAQsqrFOxY
         akC7VaHMyYzvkM6CHGlqB+AhEmr3hKe5KDMxzDuipUP21aI/sx9+t1ezViILqEYZ9R0Y
         D7mmbLGJNOp7SIeKSSM02LfjmGOijt1lWS2GjdzmX5VGU7i0G+g0UWfPlO3FetVK/MO5
         lrSkPSqFnYvoPr1Ro825b5L+tJcWckYwWg7iZmY9YPudTAjmWhdIrgXld5EHYdtebANq
         HeOQ==
X-Gm-Message-State: AOJu0Yxfj0zB+vHddiAGQXavMIhq0VhGT78Pja6BbVFWvbxwfNpCL1uq
        Z3yg6VtFOYpuFBX9wZnTr8takFfgZkbK9habKi0=
X-Google-Smtp-Source: AGHT+IGS6a587outT8UWxXdlxQp0vB8516WPMvMt5pHJ/Lqa15e/kXbGr5ofgqprLTfKwePF4v+A+g==
X-Received: by 2002:a05:6000:156c:b0:32d:9fc9:d14a with SMTP id 12-20020a056000156c00b0032d9fc9d14amr8388396wrz.12.1700494910889;
        Mon, 20 Nov 2023 07:41:50 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net (p200300f00f4ce2a470fb6777c650c5ae.dip0.t-ipconnect.de. [2003:f0:f4c:e2a4:70fb:6777:c650:c5ae])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d66c6000000b0031c52e81490sm11611461wrw.72.2023.11.20.07.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:41:50 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 3/9] RDMA/rtrs-srv: Check return values while processing info request
Date:   Mon, 20 Nov 2023 16:41:40 +0100
Message-Id: <20231120154146.920486-4-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231120154146.920486-1-haris.iqbal@ionos.com>
References: <20231120154146.920486-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

While processing info request, it could so happen that the srv_path goes
to CLOSING state, cause of any of the error events from RDMA. That state
change should be picked up while trying to change the state in
process_info_req, by checking the return value. In case the state change
call in process_info_req fails, we fail the processing.

We should also check the return value for rtrs_srv_path_up, since it
sends a link event to the client above, and the client can fail for any
reason.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index ab4200041fd3..4be0e5b132d4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -710,20 +710,23 @@ static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 	WARN_ON(wc->opcode != IB_WC_SEND);
 }
 
-static void rtrs_srv_path_up(struct rtrs_srv_path *srv_path)
+static int rtrs_srv_path_up(struct rtrs_srv_path *srv_path)
 {
 	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_srv_ctx *ctx = srv->ctx;
-	int up;
+	int up, ret = 0;
 
 	mutex_lock(&srv->paths_ev_mutex);
 	up = ++srv->paths_up;
 	if (up == 1)
-		ctx->ops.link_ev(srv, RTRS_SRV_LINK_EV_CONNECTED, NULL);
+		ret = ctx->ops.link_ev(srv, RTRS_SRV_LINK_EV_CONNECTED, NULL);
 	mutex_unlock(&srv->paths_ev_mutex);
 
 	/* Mark session as established */
-	srv_path->established = true;
+	if (!ret)
+		srv_path->established = true;
+
+	return ret;
 }
 
 static void rtrs_srv_path_down(struct rtrs_srv_path *srv_path)
@@ -852,7 +855,12 @@ static int process_info_req(struct rtrs_srv_con *con,
 		goto iu_free;
 	kobject_get(&srv_path->kobj);
 	get_device(&srv_path->srv->dev);
-	rtrs_srv_change_state(srv_path, RTRS_SRV_CONNECTED);
+	err = rtrs_srv_change_state(srv_path, RTRS_SRV_CONNECTED);
+	if (!err) {
+		rtrs_err(s, "rtrs_srv_change_state(), err: %d\n", err);
+		goto iu_free;
+	}
+
 	rtrs_srv_start_hb(srv_path);
 
 	/*
@@ -861,7 +869,11 @@ static int process_info_req(struct rtrs_srv_con *con,
 	 * all connections are successfully established.  Thus, simply notify
 	 * listener with a proper event if we are the first path.
 	 */
-	rtrs_srv_path_up(srv_path);
+	err = rtrs_srv_path_up(srv_path);
+	if (err) {
+		rtrs_err(s, "rtrs_srv_path_up(), err: %d\n", err);
+		goto iu_free;
+	}
 
 	ib_dma_sync_single_for_device(srv_path->s.dev->ib_dev,
 				      tx_iu->dma_addr,
-- 
2.25.1

