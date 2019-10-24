Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA860E3386
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 15:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbfJXNKm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 09:10:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38348 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730867AbfJXNKl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 09:10:41 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iNcss-0001Q3-Oz; Thu, 24 Oct 2019 13:10:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Tao Tian <tiantao6@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yangyang Li <liyangyang20@huawei.com>,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/hns: fix memory leak on 'context' on error return path
Date:   Thu, 24 Oct 2019 14:10:34 +0100
Message-Id: <20191024131034.19989-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently, the error return path when the call to function
dev->dfx->query_cqc_info fails will leak object 'context'. Fix this
by making the error return path via 'err' return return codes rather
than -EMSGSIZE, set ret appropriately for all error return paths and
for the memory leak now return via 'err' with -EINVAL rather than
just returning without freeing context.

Addresses-Coverity: ("Resource leak")
Fixes: e1c9a0dc2939 ("RDMA/hns: Dump detailed driver-specific CQ")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index a0d608ec81c1..7e4a91dd7329 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -94,15 +94,21 @@ static int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
 		return -ENOMEM;
 
 	ret = hr_dev->dfx->query_cqc_info(hr_dev, hr_cq->cqn, (int *)context);
-	if (ret)
-		return -EINVAL;
+	if (ret) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
-	if (!table_attr)
+	if (!table_attr) {
+		ret = -EMSGSIZE;
 		goto err;
+	}
 
-	if (hns_roce_fill_cq(msg, context))
+	if (hns_roce_fill_cq(msg, context)) {
+		ret = -EMSGSIZE;
 		goto err_cancel_table;
+	}
 
 	nla_nest_end(msg, table_attr);
 	kfree(context);
@@ -113,7 +119,7 @@ static int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
 	nla_nest_cancel(msg, table_attr);
 err:
 	kfree(context);
-	return -EMSGSIZE;
+	return ret;
 }
 
 int hns_roce_fill_res_entry(struct sk_buff *msg,
-- 
2.20.1

