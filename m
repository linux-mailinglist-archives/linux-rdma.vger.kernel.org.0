Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78A26F8FA2
	for <lists+linux-rdma@lfdr.de>; Sat,  6 May 2023 09:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjEFHIG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 May 2023 03:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjEFHIF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 May 2023 03:08:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C11F11563
        for <linux-rdma@vger.kernel.org>; Sat,  6 May 2023 00:08:03 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QCz6S6t9fzTk6V;
        Sat,  6 May 2023 15:03:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 6 May 2023 15:08:00 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-next] MAINTAINERS: Update maintainers of HiSilicon RoCE
Date:   Sat, 6 May 2023 15:06:04 +0800
Message-ID: <20230506070604.2982542-1-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wenpeng has moved to other technical areas, and Junxian will
take over his responsibilities in maintaining this module.

Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8ebab595b2a..dc6edb2511c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9294,7 +9294,7 @@ F:	drivers/crypto/hisilicon/zip/
 
 HISILICON ROCE DRIVER
 M:	Haoyue Xu <xuhaoyue1@hisilicon.com>
-M:	Wenpeng Liang <liangwenpeng@huawei.com>
+M:	Junxian Huang <huangjunxian6@hisilicon.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
-- 
2.30.0

