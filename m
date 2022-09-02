Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75005AAC3B
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Sep 2022 12:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiIBKTi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Sep 2022 06:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiIBKTh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Sep 2022 06:19:37 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1887EBCC35
        for <linux-rdma@vger.kernel.org>; Fri,  2 Sep 2022 03:19:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662113974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vUSyIFg9a3K3+PN74r8GA8+FaOI27j/HISy2qs/Q+yQ=;
        b=HOJ65uX6mntMYbJGLEr+ELO+gN5KJ9DWNx2zqMo/Es0tsiLhNZgviYSvQKn18tRkdbra9C
        d779BHm9c/8CwUsQkq7oi53777gZogSc6Vd+U4ddmSAmQP+j85C4H1fXyHw/ck2vedI65+
        wdDSTNpxwREfrhutQoRI1FeKP6y3Jrw=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 2/3] RDMA/rtrs-clt: Break the loop once one path is connected
Date:   Fri,  2 Sep 2022 18:19:21 +0800
Message-Id: <20220902101922.26273-3-guoqing.jiang@linux.dev>
In-Reply-To: <20220902101922.26273-1-guoqing.jiang@linux.dev>
References: <20220902101922.26273-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No need to iterate all paths after find one connected path.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 5219bb10777a..c29eccdb4fd2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -54,7 +54,10 @@ static inline bool rtrs_clt_is_connected(const struct rtrs_clt_sess *clt)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(clt_path, &clt->paths_list, s.entry)
-		connected |= READ_ONCE(clt_path->state) == RTRS_CLT_CONNECTED;
+		if (READ_ONCE(clt_path->state) == RTRS_CLT_CONNECTED) {
+			connected = true;
+			break;
+		}
 	rcu_read_unlock();
 
 	return connected;
-- 
2.31.1

