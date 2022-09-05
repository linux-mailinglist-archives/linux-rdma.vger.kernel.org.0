Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8B5AC8DA
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Sep 2022 04:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiIECi5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Sep 2022 22:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIECi4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Sep 2022 22:38:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FC62BB06
        for <linux-rdma@vger.kernel.org>; Sun,  4 Sep 2022 19:38:55 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MLXfB0vmFzWfPS;
        Mon,  5 Sep 2022 10:34:26 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 10:38:53 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 10:38:53 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next] MAINTAINERS: Update maintainers of HiSilicon RoCE
Date:   Mon, 5 Sep 2022 10:38:15 +0800
Message-ID: <20220905023815.1477684-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Weihang has moved to work in other technical areas, and Haoyue will
maintain this module instead of him.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..6b26f4d5a1c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9205,8 +9205,8 @@ F:	Documentation/ABI/testing/debugfs-hisi-zip
 F:	drivers/crypto/hisilicon/zip/
 
 HISILICON ROCE DRIVER
+M:	Haoyue Xu <xuhaoyue1@hisilicon.com>
 M:	Wenpeng Liang <liangwenpeng@huawei.com>
-M:	Weihang Li <liweihang@huawei.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
-- 
2.30.0

