Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145BB3918D1
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 15:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhEZNbZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 09:31:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6717 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhEZNbZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 09:31:25 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FqsCp3kmBzncTW;
        Wed, 26 May 2021 21:26:14 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 21:29:51 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 21:29:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/core: use DEVICE_ATTR_RO macro
Date:   Wed, 26 May 2021 21:29:49 +0800
Message-ID: <20210526132949.20184-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/core/ucma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 1f198c180aa1..74144e513dc7 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1830,13 +1830,13 @@ static struct ib_client rdma_cma_client = {
 };
 MODULE_ALIAS_RDMA_CLIENT("rdma_cm");
 
-static ssize_t show_abi_version(struct device *dev,
+static ssize_t abi_version_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
 	return sysfs_emit(buf, "%d\n", RDMA_USER_CM_ABI_VERSION);
 }
-static DEVICE_ATTR(abi_version, S_IRUGO, show_abi_version, NULL);
+static DEVICE_ATTR_RO(abi_version);
 
 static int __init ucma_init(void)
 {
-- 
2.17.1

