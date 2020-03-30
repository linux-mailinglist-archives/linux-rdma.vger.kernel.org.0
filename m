Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7A197A4E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2020 13:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgC3LDM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 07:03:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729739AbgC3LDM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Mar 2020 07:03:12 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E0DFFE931822773FA77A;
        Mon, 30 Mar 2020 19:03:06 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 19:02:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <selvin.xavier@broadcom.com>, <devesh.sharma@broadcom.com>,
        <somnath.kotur@broadcom.com>, <sriharsha.basavapatna@broadcom.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/bnxt_re: make bnxt_re_ib_init static
Date:   Mon, 30 Mar 2020 19:02:19 +0800
Message-ID: <20200330110219.24448-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix sparse warning:

drivers/infiniband/hw/bnxt_re/main.c:1313:5:
 warning: symbol 'bnxt_re_ib_init' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 4a8fb1ad74a8..b12fbc857f94 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1310,7 +1310,7 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 		le16_to_cpu(resp.hwrm_intf_patch);
 }
 
-int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
+static int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
 {
 	int rc = 0;
 	u32 event;
-- 
2.17.1


