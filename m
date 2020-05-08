Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F97E1CA77B
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2020 11:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgEHJq0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 May 2020 05:46:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727076AbgEHJq0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 May 2020 05:46:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A589A50C01045808A361;
        Fri,  8 May 2020 17:46:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 17:46:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 7/9] RDMA/hns: Remove redundant memcpy()
Date:   Fri, 8 May 2020 17:45:57 +0800
Message-ID: <1588931159-56875-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
References: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

srq_context is a local variables and is only used to get some fields from
buffer of mailbox. It's meaningless to copy mailbox's buffer's contents
back to it.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 61c6bb3..d137abc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5044,8 +5044,6 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 	attr->max_wr = srq->wqe_cnt - 1;
 	attr->max_sge = srq->max_gs;
 
-	memcpy(srq_context, mailbox->buf, sizeof(*srq_context));
-
 out:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	return ret;
-- 
2.8.1

