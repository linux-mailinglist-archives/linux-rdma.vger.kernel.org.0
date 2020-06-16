Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D331FA576
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 03:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgFPBPZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jun 2020 21:15:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6327 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbgFPBPZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jun 2020 21:15:25 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E3EE5EBAA934826ECE6D;
        Tue, 16 Jun 2020 09:15:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 09:15:13 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <bvanassche@acm.org>, <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH v2] IB/srpt: Remove WARN_ON from srpt_cm_req_recv
Date:   Tue, 16 Jun 2020 09:17:15 +0800
Message-ID: <20200616011715.140197-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's easy to show that sdev and req are always valid,
so we remove unnecessary WARN_ON.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index ef7fcd3..0fa65c6 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2156,9 +2156,6 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 
 	WARN_ON_ONCE(irqs_disabled());
 
-	if (WARN_ON(!sdev || !req))
-		return -EINVAL;
-
 	it_iu_len = be32_to_cpu(req->req_it_iu_len);
 
 	pr_info("Received SRP_LOGIN_REQ with i_port_id %pI6, t_port_id %pI6 and it_iu_len %d on port %d (guid=%pI6); pkey %#04x\n",
-- 
1.8.3.1

