Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1E25E8AA1
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Sep 2022 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiIXJSn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Sep 2022 05:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIXJSm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Sep 2022 05:18:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27058127C87;
        Sat, 24 Sep 2022 02:18:41 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MZNd02hVTz1P6sW;
        Sat, 24 Sep 2022 17:14:28 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 17:18:38 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <dennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] IB/rdmavt: Add __init/__exit annotations to module init/exit funcs
Date:   Sat, 24 Sep 2022 17:14:57 +0800
Message-ID: <20220924091457.52446-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add missing __init/__exit annotations to module init/exit funcs.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/infiniband/sw/rdmavt/vt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 59481ae39505..d61f8de7f21c 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -15,7 +15,7 @@
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("RDMA Verbs Transport Library");
 
-static int rvt_init(void)
+static int __init rvt_init(void)
 {
 	int ret = rvt_driver_cq_init();
 
@@ -26,7 +26,7 @@ static int rvt_init(void)
 }
 module_init(rvt_init);
 
-static void rvt_cleanup(void)
+static void __exit rvt_cleanup(void)
 {
 	rvt_cq_exit();
 }
-- 
2.17.1

