Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79A31083C
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 10:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhBEJrN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 04:47:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12845 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhBEJpF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 04:45:05 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DX9Q96Dbgz7hVf;
        Fri,  5 Feb 2021 17:40:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:41:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 04/12] RDMA/hns: Disable RQ inline by default
Date:   Fri, 5 Feb 2021 17:39:26 +0800
Message-ID: <1612517974-31867-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
References: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

This feature should only be enabled by querying capability from firmware.

Fixes: ba6bb7e97421 ("RDMA/hns: Add interfaces to get pf capabilities from firmware")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f0691f4..3ba6783 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1949,7 +1949,6 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 
 	caps->flags		= HNS_ROCE_CAP_FLAG_REREG_MR |
 				  HNS_ROCE_CAP_FLAG_ROCE_V1_V2 |
-				  HNS_ROCE_CAP_FLAG_RQ_INLINE |
 				  HNS_ROCE_CAP_FLAG_RECORD_DB |
 				  HNS_ROCE_CAP_FLAG_SQ_RECORD_DB;
 
-- 
2.8.1

