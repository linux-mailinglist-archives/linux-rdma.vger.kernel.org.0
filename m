Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C1462BB86
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 12:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbiKPLYk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 06:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbiKPLYZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 06:24:25 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929365F45
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 03:14:21 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668597260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3yhW/NTQ895k440jT3bFIVaH6OV39q2OKSv28QeG1tc=;
        b=suP5mbepCBB5vkTmHEDVzUjeaxZ2M6XNzwUy98rv1wvK5PCItfleynh18TVZC6q8qgHPFJ
        dQPDK902cR2mSnr9TRPQ+oVXbrs/zrmnpTBUE5Z9kzuH8+TV1BdNzOKQs9bH+rDj+759cX
        fZ0XGQ3QImPEuqSfRNNoBURBSJj74zg=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 1/8] RDMA/rtrs-srv: Refactor rtrs_srv_rdma_cm_handler
Date:   Wed, 16 Nov 2022 19:13:53 +0800
Message-Id: <20221116111400.7203-2-guoqing.jiang@linux.dev>
In-Reply-To: <20221116111400.7203-1-guoqing.jiang@linux.dev>
References: <20221116111400.7203-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The RDMA_CM_EVENT_CONNECT_REQUEST is quite different to other types,
let's checking it separately at the beginning of routine, then we can
avoid the identation accordingly.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 22d7ba05e9fe..5fe3699cb8ff 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1950,22 +1950,21 @@ static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
 {
 	struct rtrs_srv_path *srv_path = NULL;
 	struct rtrs_path *s = NULL;
+	struct rtrs_con *c = NULL;
 
-	if (ev->event != RDMA_CM_EVENT_CONNECT_REQUEST) {
-		struct rtrs_con *c = cm_id->context;
-
-		s = c->path;
-		srv_path = to_srv_path(s);
-	}
-
-	switch (ev->event) {
-	case RDMA_CM_EVENT_CONNECT_REQUEST:
+	if (ev->event == RDMA_CM_EVENT_CONNECT_REQUEST)
 		/*
 		 * In case of error cma.c will destroy cm_id,
 		 * see cma_process_remove()
 		 */
 		return rtrs_rdma_connect(cm_id, ev->param.conn.private_data,
 					  ev->param.conn.private_data_len);
+
+	c = cm_id->context;
+	s = c->path;
+	srv_path = to_srv_path(s);
+
+	switch (ev->event) {
 	case RDMA_CM_EVENT_ESTABLISHED:
 		/* Nothing here */
 		break;
-- 
2.31.1

