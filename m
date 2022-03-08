Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53974D1AAF
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347370AbiCHOiV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 09:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347436AbiCHOiU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 09:38:20 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A5C4C40A;
        Tue,  8 Mar 2022 06:37:23 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646750242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FncVsovFL5slAyR2J5b5luWiIjJ5omNLF9G25/PYeW4=;
        b=s5TQUSv/KNr178Fexdux12asMEkIrzvEep0jbREsHrcKu4Ftm8AYQc65Sp+8hDc+ncerte
        by0LiXsP8+1to7IxBaz+OEiWxa1Nogulkg6BcrCVMeBrV05NxWSn7A8kpmGzncucItayue
        iKYXyPOlFpnUgidBeHbPVzcM9Ysn8zM=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     jgg@nvidia.com, selvin.xavier@broadcom.com, galpress@amazon.com,
        sleybo@amazon.com, liangwenpeng@huawei.com, liweihang@huawei.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        leonro@nvidia.com, dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH for-next 3/9] RDMA/efa: get rid of create_user_ah
Date:   Tue,  8 Mar 2022 22:37:05 +0800
Message-Id: <20220308143705.3403496-1-yajun.deng@linux.dev>
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

There is no create_user_ah in ib_device_ops, remove it.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/infiniband/hw/efa/efa_main.c  | 2 +-
 drivers/infiniband/hw/efa/efa_verbs.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 94b94cca4870..b2f3832cd305 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -361,7 +361,7 @@ static const struct ib_device_ops efa_dev_ops = {
 	.alloc_ucontext = efa_alloc_ucontext,
 	.create_cq = efa_create_cq,
 	.create_qp = efa_create_qp,
-	.create_user_ah = efa_create_ah,
+	.create_ah = efa_create_ah,
 	.dealloc_pd = efa_dealloc_pd,
 	.dealloc_ucontext = efa_dealloc_ucontext,
 	.dereg_mr = efa_dereg_mr,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index ecfe70eb5efb..44269eb18780 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1959,6 +1959,11 @@ int efa_create_ah(struct ib_ah *ibah,
 	struct efa_ah *ah = to_eah(ibah);
 	int err;
 
+	if (!udata) {
+		err = -EOPNOTSUPP;
+		goto err_out;
+	}
+
 	if (!(init_attr->flags & RDMA_CREATE_AH_SLEEPABLE)) {
 		ibdev_dbg(&dev->ibdev,
 			  "Create address handle is not supported in atomic context\n");
-- 
2.25.1

