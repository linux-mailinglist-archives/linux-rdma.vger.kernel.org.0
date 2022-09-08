Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7D15B1926
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 11:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiIHJqg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiIHJqg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 05:46:36 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37686DFF59
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 02:46:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662630390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pV6cah5MPcKW6FiG9nJCnF+4Nu40L28H0Kf2R4PqQ+8=;
        b=mFBYsM0wHDbpSA3blBcYFlH8Fo+AlNDtUo5qziMfu+WVZDvfUmXfxzfdu+WpYjUHuuX1dP
        tUFbCSfXcHgnAOdy/qBYjNgvB9V8503fUppA84AWfD/KqogcBducdmgZ9A2oAx5QqMa3iM
        7Yx23pjYgA5/QDPBrIwJCgQJpp0g6jA=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: [PATCH V2 2/3] RDMA/rtrs-clt: Break the loop once one path is connected
Date:   Thu,  8 Sep 2022 17:45:47 +0800
Message-Id: <20220908094548.4115-3-guoqing.jiang@linux.dev>
In-Reply-To: <20220908094548.4115-1-guoqing.jiang@linux.dev>
References: <20220908094548.4115-1-guoqing.jiang@linux.dev>
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

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
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

