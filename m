Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAD6626D34
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Nov 2022 02:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiKMBIn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Nov 2022 20:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiKMBIm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Nov 2022 20:08:42 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736A4F10
        for <linux-rdma@vger.kernel.org>; Sat, 12 Nov 2022 17:08:41 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668301720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sg+KPCtBI0xZlYnxlcYJguRQpWMDLjEmZ9vkTuUnmeM=;
        b=H3BO5yCZQc1PgmvvGkFDe/F8on27WKv3RVOJ6mLdxnFbiIvkUM5WLDZi4Mnx0LCYl309qc
        Un5JBMVOLGd0LwjwacOo4HbOvW+PZTxVO89K2QP7xlZ8H2RBh8JgVRCBRc1sCt+CML6MOT
        NV27oDji05Ra/pFM/q7SCnnCH9WvA3s=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH RFC 02/12] RDMA/rtrs-srv: Refactor rtrs_srv_rdma_cm_handler
Date:   Sun, 13 Nov 2022 09:08:13 +0800
Message-Id: <20221113010823.6436-3-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-1-guoqing.jiang@linux.dev>
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
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
let's checking it separately at the beginning of routine, then we can
avoid the identation accordingly.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 79504aaef0cc..2cc8b423bcaa 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1948,24 +1948,19 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
 				     struct rdma_cm_event *ev)
 {
-	struct rtrs_srv_path *srv_path = NULL;
-	struct rtrs_path *s = NULL;
-
-	if (ev->event != RDMA_CM_EVENT_CONNECT_REQUEST) {
-		struct rtrs_con *c = cm_id->context;
-
-		s = c->path;
-		srv_path = to_srv_path(s);
-	}
+	struct rtrs_con *c = cm_id->context;
+	struct rtrs_path *s = c->path;
+	struct rtrs_srv_path *srv_path = to_srv_path(s);
 
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
+	switch (ev->event) {
 	case RDMA_CM_EVENT_ESTABLISHED:
 		/* Nothing here */
 		break;
-- 
2.31.1

