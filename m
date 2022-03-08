Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641844D1AC4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 15:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347586AbiCHOl3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 09:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347582AbiCHOkv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 09:40:51 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42D3982F;
        Tue,  8 Mar 2022 06:39:43 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646750382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nrecQuGy98C6aO1aAvkycpK/3V7th2fksfqvlD2lDHM=;
        b=J92QyKD1O7Vm5lxGW5Vz1xLACwP4kpNqwb0qV7u1WqWMc/pikwgUmar7mwhoN05Iy5CgjX
        Qi1AcQLjZ7q4xebVhRWhxolfbqL8u65aCTQftwXn518dLIHwGhE62yrVwuSr9pYv37bXHe
        uZYWwJvWdkV0wCNhC3nQOYNL9JJzoZY=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     jgg@nvidia.com, selvin.xavier@broadcom.com, galpress@amazon.com,
        sleybo@amazon.com, liangwenpeng@huawei.com, liweihang@huawei.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        leonro@nvidia.com, dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH for-next 7/9] RDMA/ocrdma: get rid of create_user_ah
Date:   Tue,  8 Mar 2022 22:39:26 +0800
Message-Id: <20220308143926.3405604-1-yajun.deng@linux.dev>
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
 drivers/infiniband/hw/ocrdma/ocrdma_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index 5d4b3bc16493..9eac2b04b445 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -140,7 +140,6 @@ static const struct ib_device_ops ocrdma_dev_ops = {
 	.create_ah = ocrdma_create_ah,
 	.create_cq = ocrdma_create_cq,
 	.create_qp = ocrdma_create_qp,
-	.create_user_ah = ocrdma_create_ah,
 	.dealloc_pd = ocrdma_dealloc_pd,
 	.dealloc_ucontext = ocrdma_dealloc_ucontext,
 	.dereg_mr = ocrdma_dereg_mr,
-- 
2.25.1

