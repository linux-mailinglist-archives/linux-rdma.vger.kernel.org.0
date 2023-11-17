Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BC27EED3C
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Nov 2023 09:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjKQIKc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Nov 2023 03:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345717AbjKQIKa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Nov 2023 03:10:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC8D63;
        Fri, 17 Nov 2023 00:10:26 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SWqHn31qbzsR4n;
        Fri, 17 Nov 2023 16:07:01 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 17 Nov 2023 16:10:23 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <tangchengchang@huawei.com>
Subject: [PATCH for-rc] MAINTAINERS: Add Chengchang Tang as Hisilicon RoCE maintainer
Date:   Fri, 17 Nov 2023 16:06:57 +0800
Message-ID: <20231117080657.1844316-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500006.china.huawei.com (7.221.188.68)
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

Add Chengchang Tang as Hisilicon RoCE maintainer.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..5e93f355c786 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9628,6 +9628,7 @@ F:	drivers/crypto/hisilicon/sgl.c
 F:	include/linux/hisi_acc_qm.h
 
 HISILICON ROCE DRIVER
+M:	Chengchang Tang <tangchengchang@huawei.com>
 M:	Junxian Huang <huangjunxian6@hisilicon.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
-- 
2.30.0

