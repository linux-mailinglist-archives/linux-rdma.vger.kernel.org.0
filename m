Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D7B62D7DE
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 11:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbiKQKTz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 05:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQKTy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 05:19:54 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EBE4D5ED
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 02:19:53 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668680392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gf9TGH48gi5+F2aG/qy2ERJx4yy3NJDEGxJp59z7+QI=;
        b=CLzjAL4CfNg5mI1FjxAEFPxGZImGkejJAYhLwhKl/9yjfBGm2l3SajnFUvkmHBd4o1N/Q2
        M35Q0PBYsYCMV4fpTGHvVWm6yxSX3bbyAP5QP+nqAQf5Mt49TMcBCbbveEA8LdPjl7apIH
        sg5sD2wWO/dSXtunc5jMKuIvw28T+ZA=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 1/8] RDMA/rtrs-srv: Refactor rtrs_srv_rdma_cm_handler
Date:   Thu, 17 Nov 2022 18:19:38 +0800
Message-Id: <20221117101945.6317-2-guoqing.jiang@linux.dev>
In-Reply-To: <20221117101945.6317-1-guoqing.jiang@linux.dev>
References: <20221117101945.6317-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The RDMA_CM_EVENT_CONNECT_REQUEST is quite different to other types,
let's check it separately at the beginning of routine, then we can
avoid the indentation accordingly.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
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

