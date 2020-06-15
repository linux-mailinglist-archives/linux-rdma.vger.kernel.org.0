Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590D51F92CB
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2020 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgFOJJF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jun 2020 05:09:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5891 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728411AbgFOJJE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jun 2020 05:09:04 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E0CBB22AA912C8934AB8;
        Mon, 15 Jun 2020 17:09:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 15 Jun 2020 17:08:53 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <bvanassche@acm.org>, <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] IB/srpt: Fix a potential null pointer dereference
Date:   Mon, 15 Jun 2020 17:12:20 +0800
Message-ID: <20200615091220.6439-1-jingxiangfeng@huawei.com>
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

In srpt_cm_req_recv(), it is possible that sdev is NULL,
so we should test sdev before using it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 98552749d71c..72053254bf84 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2143,7 +2143,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 			    const struct srp_login_req *req,
 			    const char *src_addr)
 {
-	struct srpt_port *sport = &sdev->port[port_num - 1];
+	struct srpt_port *sport;
 	struct srpt_nexus *nexus;
 	struct srp_login_rsp *rsp = NULL;
 	struct srp_login_rej *rej = NULL;
@@ -2162,6 +2162,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	if (WARN_ON(!sdev || !req))
 		return -EINVAL;
 
+	sport = &sdev->port[port_num - 1];
 	it_iu_len = be32_to_cpu(req->req_it_iu_len);
 
 	pr_info("Received SRP_LOGIN_REQ with i_port_id %pI6, t_port_id %pI6 and it_iu_len %d on port %d (guid=%pI6); pkey %#04x\n",
-- 
2.17.1

