Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1944CB518
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Mar 2022 03:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiCCCnj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Mar 2022 21:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiCCCni (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Mar 2022 21:43:38 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358B311C23;
        Wed,  2 Mar 2022 18:42:53 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646275371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T2DBq1T9P8xVlTmIkAaGvH0gMt3oU3lKJwnNun+3nHw=;
        b=AQuA4J371fF5tOg9mTeetwNCbnOxzKEgn1T+EzqGD5SHZosw71F/7YUEkCP7pqRtIaGo1x
        lH99nc/DxIjstCdU5KyVgsIscLMWNjgdFYT68F5UUIqfV4iyDFLsi279wD9qQ3K5m69Nw6
        biCvnAN0wUqTmYZn7eZDrRHJisdNdTE=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH for-next] RDMA/core: Fix ib_qp_usecnt_dec() called when error
Date:   Thu,  3 Mar 2022 10:42:32 +0800
Message-Id: <20220303024232.2847388-1-yajun.deng@linux.dev>
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

ib_destroy_qp() would called by ib_create_qp_user() if error, the former
contains ib_qp_usecnt_dec(), but ib_qp_usecnt_inc() was not called before.

So move ib_qp_usecnt_inc() into create_qp().

Fixes: d2b10794fc13 ("RDMA/core: Create clean QP creations interface for uverbs")
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/infiniband/core/uverbs_cmd.c          | 1 -
 drivers/infiniband/core/uverbs_std_types_qp.c | 1 -
 drivers/infiniband/core/verbs.c               | 3 +--
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 6b6393176b3c..4437f834c0a7 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1437,7 +1437,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		ret = PTR_ERR(qp);
 		goto err_put;
 	}
-	ib_qp_usecnt_inc(qp);
 
 	obj->uevent.uobject.object = qp;
 	obj->uevent.event_file = READ_ONCE(attrs->ufile->default_async_file);
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index dd1075466f61..75353e09c6fe 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -254,7 +254,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 		ret = PTR_ERR(qp);
 		goto err_put;
 	}
-	ib_qp_usecnt_inc(qp);
 
 	if (attr.qp_type == IB_QPT_XRC_TGT) {
 		obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index a9819c40a140..bc9a83f1ca2d 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1245,6 +1245,7 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	if (ret)
 		goto err_security;
 
+	ib_qp_usecnt_inc(qp);
 	rdma_restrack_add(&qp->res);
 	return qp;
 
@@ -1345,8 +1346,6 @@ struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,
 	if (IS_ERR(qp))
 		return qp;
 
-	ib_qp_usecnt_inc(qp);
-
 	if (qp_init_attr->cap.max_rdma_ctxs) {
 		ret = rdma_rw_init_mrs(qp, qp_init_attr);
 		if (ret)
-- 
2.25.1

