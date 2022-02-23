Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFC74C0D96
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 08:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbiBWHtv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 02:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiBWHtv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 02:49:51 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A506A01B;
        Tue, 22 Feb 2022 23:49:23 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645602560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AfLl29j9pxoXzsF/4goqq4OFc6lMYvayP+m2j0mAsuk=;
        b=oZbqfOmjien0cojAiqZXwb1gbgYS85kkzLGs2/uV3QgdO6n4Vjw3JO6vwcFR6gZpXhq63M
        3EpgkoGI7WEmYgNl3iwXhEO8lcox6FacJVq4pLrm404j3FLnPeEFqi02udFuZ3FSdfB2oO
        hmYtEvInn45FFOaFfTP1HJNOxA+Rxmo=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH for-next] RDMA/core: Remove unnecessary statements
Date:   Wed, 23 Feb 2022 15:49:01 +0800
Message-Id: <20220223074901.201506-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rdma_zalloc_drv_obj() in __ib_alloc_pd() would zero pd, it unnecessary
add NULL to the object in struct pd.

The uverbs_free_pd() already return busy if pd->usecnt is true, there is
no need to add a warning.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/infiniband/core/verbs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e821dc94a43e..03bc9d34c13d 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -268,8 +268,6 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 		return ERR_PTR(-ENOMEM);
 
 	pd->device = device;
-	pd->uobject = NULL;
-	pd->__internal_mr = NULL;
 	atomic_set(&pd->usecnt, 0);
 	pd->flags = flags;
 
@@ -341,11 +339,6 @@ int ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
 		pd->__internal_mr = NULL;
 	}
 
-	/* uverbs manipulates usecnt with proper locking, while the kabi
-	 * requires the caller to guarantee we can't race here.
-	 */
-	WARN_ON(atomic_read(&pd->usecnt));
-
 	ret = pd->device->ops.dealloc_pd(pd, udata);
 	if (ret)
 		return ret;
-- 
2.25.1

