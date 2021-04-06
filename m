Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3C354EF7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 10:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbhDFItF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 04:49:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16344 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhDFItF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 04:49:05 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FF1NP5pJ1z9wfh;
        Tue,  6 Apr 2021 16:46:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 16:48:45 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/core: Make the wc status prompt message clearer
Date:   Tue, 6 Apr 2021 16:46:12 +0800
Message-ID: <1617698772-13871-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

Local invalidate is also a kind of memory management operation, not only
memory bind operation. Furthermore, as invalidate operations include local
and remote, add prefix to the prompt message to make it clearer.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index c576e2b..9370926 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -96,10 +96,10 @@ static const char * const wc_statuses[] = {
 	[IB_WC_LOC_EEC_OP_ERR]		= "local EE context operation error",
 	[IB_WC_LOC_PROT_ERR]		= "local protection error",
 	[IB_WC_WR_FLUSH_ERR]		= "WR flushed",
-	[IB_WC_MW_BIND_ERR]		= "memory management operation error",
+	[IB_WC_MW_BIND_ERR]		= "memory bind operation error",
 	[IB_WC_BAD_RESP_ERR]		= "bad response error",
 	[IB_WC_LOC_ACCESS_ERR]		= "local access error",
-	[IB_WC_REM_INV_REQ_ERR]		= "invalid request error",
+	[IB_WC_REM_INV_REQ_ERR]		= "remote invalid request error",
 	[IB_WC_REM_ACCESS_ERR]		= "remote access error",
 	[IB_WC_REM_OP_ERR]		= "remote operation error",
 	[IB_WC_RETRY_EXC_ERR]		= "transport retry counter exceeded",
-- 
2.8.1

