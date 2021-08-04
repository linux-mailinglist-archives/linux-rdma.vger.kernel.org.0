Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629433E018B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 14:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbhHDNAB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Aug 2021 09:00:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12445 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbhHDNAB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Aug 2021 09:00:01 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GfsDr2dv3zckpk;
        Wed,  4 Aug 2021 20:56:12 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 20:59:46 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 4 Aug
 2021 20:59:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <liangwenpeng@huawei.com>, <liweihang@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>, <chenglang@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/hns: Fix return in hns_roce_rereg_user_mr()
Date:   Wed, 4 Aug 2021 20:59:39 +0800
Message-ID: <20210804125939.20516-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If re-registering an MR in hns_roce_rereg_user_mr(), we should
return NULL instead of pass 0 to ERR_PTR.

Fixes: 4e9fc1dae2a9 ("RDMA/hns: Optimize the MR registration process")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 006c84bb3f9f..7089ac780291 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -352,7 +352,9 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 free_cmd_mbox:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 
-	return ERR_PTR(ret);
+	if (ret)
+		return ERR_PTR(ret);
+	return NULL;
 }
 
 int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
-- 
2.17.1

