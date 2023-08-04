Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F85B76F7D3
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 04:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjHDC0M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Aug 2023 22:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjHDC0M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Aug 2023 22:26:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F49A3
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 19:26:10 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RH8cx6rf1zNm7S;
        Fri,  4 Aug 2023 10:22:41 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.111) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 10:26:08 +0800
From:   Xiang Yang <xiangyang3@huawei.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <yishaih@mellanox.com>,
        <raeds@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, <xiangyang3@huawei.com>
Subject: [PATCH -next] IB/uverbs: fix an potential error pointer dereference
Date:   Fri, 4 Aug 2023 10:25:25 +0800
Message-ID: <20230804022525.1916766-1-xiangyang3@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.111]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Smatch reports the warning below:
drivers/infiniband/core/uverbs_std_types_counters.c:110
ib_uverbs_handler_UVERBS_METHOD_COUNTERS_READ() error: 'uattr'
dereferencing possible ERR_PTR()

the return value of uattr maybe ERR_PTR(-ENOENT), fix this by checking
the value of uattr before using it.

Fixes: ebb6796bd397 ("IB/uverbs: Add read counters support")
Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
---
 drivers/infiniband/core/uverbs_std_types_counters.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_counters.c b/drivers/infiniband/core/uverbs_std_types_counters.c
index 999da9c79866..381aa5797641 100644
--- a/drivers/infiniband/core/uverbs_std_types_counters.c
+++ b/drivers/infiniband/core/uverbs_std_types_counters.c
@@ -107,6 +107,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_READ)(
 		return ret;
 
 	uattr = uverbs_attr_get(attrs, UVERBS_ATTR_READ_COUNTERS_BUFF);
+	if (IS_ERR(uattr))
+		return PTR_ERR(uattr);
 	read_attr.ncounters = uattr->ptr_attr.len / sizeof(u64);
 	read_attr.counters_buff = uverbs_zalloc(
 		attrs, array_size(read_attr.ncounters, sizeof(u64)));
-- 
2.34.1

