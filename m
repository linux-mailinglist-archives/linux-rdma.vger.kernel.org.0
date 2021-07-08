Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E91A3BF89F
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jul 2021 13:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhGHLCs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jul 2021 07:02:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14039 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhGHLCs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jul 2021 07:02:48 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GLCsY2CXVzZnrk;
        Thu,  8 Jul 2021 18:56:49 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 8 Jul 2021 18:59:58 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 8 Jul 2021 18:59:57 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next] MAINTAINERS: Update maintainers of HiSilicon RoCE
Date:   Thu, 8 Jul 2021 18:59:18 +0800
Message-ID: <1625741958-51363-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Lijun has moved to work in other technical areas, and Wenpeng will maintain
this modules instead of him.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f77ed8d..2bc56d8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8249,7 +8249,7 @@ F:	drivers/crypto/hisilicon/sgl.c
 F:	drivers/crypto/hisilicon/zip/
 
 HISILICON ROCE DRIVER
-M:	Lijun Ou <oulijun@huawei.com>
+M:	Wenpeng Liang <liangwenpeng@huawei.com>
 M:	Weihang Li <liweihang@huawei.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
-- 
2.7.4

