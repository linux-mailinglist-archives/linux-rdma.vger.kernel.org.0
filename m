Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818E17D7BE
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 10:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfHAIdk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 04:33:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730643AbfHAIdk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 04:33:40 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 35C3EDD34DE153662464;
        Thu,  1 Aug 2019 16:33:23 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 1 Aug 2019 16:33:13 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next 05/13] RDMA/hns: Clean up unnecessary initial assignment
Date:   Thu, 1 Aug 2019 16:29:06 +0800
Message-ID: <1564648154-123172-6-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564648154-123172-1-git-send-email-oulijun@huawei.com>
References: <1564648154-123172-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Here remove some unncessary initialization for some valiables.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 455b08c..88e96c1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -239,7 +239,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_v2_db sq_db;
 	struct ib_qp_attr attr;
-	unsigned int sge_ind = 0;
+	unsigned int sge_ind ;
 	unsigned int owner_bit;
 	unsigned long flags;
 	unsigned int ind;
@@ -4291,7 +4291,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	struct hns_roce_v2_qp_context *context;
 	struct hns_roce_v2_qp_context *qpc_mask;
 	struct device *dev = hr_dev->dev;
-	int ret = -EINVAL;
+	int ret;
 
 	context = kcalloc(2, sizeof(*context), GFP_ATOMIC);
 	if (!context)
-- 
1.9.1

