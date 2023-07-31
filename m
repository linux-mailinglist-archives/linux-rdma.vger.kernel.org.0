Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446C0768C6A
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 08:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjGaG40 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 02:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGaG40 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 02:56:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094B5C7
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jul 2023 23:56:22 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RDpph6hM2ztRhQ;
        Mon, 31 Jul 2023 14:53:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 14:56:20 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] RDMA/mthca: remove many unnecessary NULL values
Date:   Mon, 31 Jul 2023 14:55:43 +0800
Message-ID: <20230731065543.2285928-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ther are many pointers assigned first, which need not to be initialized, so
remove the NULL assignment.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/infiniband/hw/mthca/mthca_provider.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index c46df53f26cf..e1325f2927d6 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -53,8 +53,8 @@
 static int mthca_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 			      struct ib_udata *uhw)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 	struct mthca_dev *mdev = to_mdev(ibdev);
 
@@ -121,8 +121,8 @@ static int mthca_query_device(struct ib_device *ibdev, struct ib_device_attr *pr
 static int mthca_query_port(struct ib_device *ibdev,
 			    u32 port, struct ib_port_attr *props)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 
 	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
@@ -217,8 +217,8 @@ static int mthca_modify_port(struct ib_device *ibdev,
 static int mthca_query_pkey(struct ib_device *ibdev,
 			    u32 port, u16 index, u16 *pkey)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 
 	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
@@ -246,8 +246,8 @@ static int mthca_query_pkey(struct ib_device *ibdev,
 static int mthca_query_gid(struct ib_device *ibdev, u32 port,
 			   int index, union ib_gid *gid)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 
 	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
@@ -989,8 +989,8 @@ static const struct attribute_group mthca_attr_group = {
 
 static int mthca_init_node_data(struct mthca_dev *dev)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 
 	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
-- 
2.34.1

