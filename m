Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBF24D1AA7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 15:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbiCHOgm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 09:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiCHOgm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 09:36:42 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7104BB99;
        Tue,  8 Mar 2022 06:35:45 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646750144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K+gPg5UuA7PpD8H5hDSnfJkUjha4YZo9/JSYwD1T5kk=;
        b=HkEjno3eAS+rCKh7mx6Xn44t5niRh10RKVmXK4Zlswm5cTwVJfzHwKnGWfX/ubtKkbgNmr
        sVihQUQ+1bOdBkjZ+kt0q6Pags/8zTUU0x2FKr8i+vBSspq3MfBfASPCcdJWmoGv/SG7DR
        TgOxP3oqi8hA/1Z9uMg/g9/G7Sh1OOo=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     jgg@nvidia.com, selvin.xavier@broadcom.com, galpress@amazon.com,
        sleybo@amazon.com, liangwenpeng@huawei.com, liweihang@huawei.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        leonro@nvidia.com, dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH for-next 1/9] RDMA/core: get rid of create_user_ah
Date:   Tue,  8 Mar 2022 22:35:29 +0800
Message-Id: <20220308143529.3402101-1-yajun.deng@linux.dev>
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

The two members create_user_ah and create_ah in struct ib_device_ops
are very similar. we can use create_ah for all case. so get rid of
create_user_ah.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/infiniband/core/device.c     | 1 -
 drivers/infiniband/core/uverbs_cmd.c | 2 +-
 drivers/infiniband/core/verbs.c      | 7 ++-----
 include/rdma/ib_verbs.h              | 2 --
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a311df07b1bd..9a473d855b3a 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2617,7 +2617,6 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, create_qp);
 	SET_DEVICE_OP(dev_ops, create_rwq_ind_table);
 	SET_DEVICE_OP(dev_ops, create_srq);
-	SET_DEVICE_OP(dev_ops, create_user_ah);
 	SET_DEVICE_OP(dev_ops, create_wq);
 	SET_DEVICE_OP(dev_ops, dealloc_dm);
 	SET_DEVICE_OP(dev_ops, dealloc_driver);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 4437f834c0a7..fb0733e233f9 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3724,7 +3724,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
 			IB_USER_VERBS_CMD_DESTROY_AH,
 			ib_uverbs_destroy_ah,
 			UAPI_DEF_WRITE_I(struct ib_uverbs_destroy_ah)),
-		UAPI_DEF_OBJ_NEEDS_FN(create_user_ah),
+		UAPI_DEF_OBJ_NEEDS_FN(create_ah),
 		UAPI_DEF_OBJ_NEEDS_FN(destroy_ah)),
 
 	DECLARE_UVERBS_OBJECT(
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bc9a83f1ca2d..5471f13a2443 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -510,7 +510,7 @@ static struct ib_ah *_rdma_create_ah(struct ib_pd *pd,
 
 	might_sleep_if(flags & RDMA_CREATE_AH_SLEEPABLE);
 
-	if (!udata && !device->ops.create_ah)
+	if (!device->ops.create_ah)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	ah = rdma_zalloc_drv_obj_gfp(
@@ -527,10 +527,7 @@ static struct ib_ah *_rdma_create_ah(struct ib_pd *pd,
 	init_attr.flags = flags;
 	init_attr.xmit_slave = xmit_slave;
 
-	if (udata)
-		ret = device->ops.create_user_ah(ah, &init_attr, udata);
-	else
-		ret = device->ops.create_ah(ah, &init_attr, NULL);
+	ret = device->ops.create_ah(ah, &init_attr, udata);
 	if (ret) {
 		kfree(ah);
 		return ERR_PTR(ret);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 69d883f7fb41..8e4ded24494c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2428,8 +2428,6 @@ struct ib_device_ops {
 	int (*dealloc_pd)(struct ib_pd *pd, struct ib_udata *udata);
 	int (*create_ah)(struct ib_ah *ah, struct rdma_ah_init_attr *attr,
 			 struct ib_udata *udata);
-	int (*create_user_ah)(struct ib_ah *ah, struct rdma_ah_init_attr *attr,
-			      struct ib_udata *udata);
 	int (*modify_ah)(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
 	int (*query_ah)(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
 	int (*destroy_ah)(struct ib_ah *ah, u32 flags);
-- 
2.25.1

