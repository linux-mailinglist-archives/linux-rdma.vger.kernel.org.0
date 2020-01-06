Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006A3131220
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 13:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAFMZL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 07:25:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbgAFMZL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 07:25:11 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A41AF42A58455032A4F0;
        Mon,  6 Jan 2020 20:25:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 Jan 2020 20:24:58 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/7] RDMA/hns: Remove unused function hns_roce_init_eq_table()
Date:   Mon, 6 Jan 2020 20:21:11 +0800
Message-ID: <1578313276-29080-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1578313276-29080-1-git-send-email-liweihang@huawei.com>
References: <1578313276-29080-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

hns_roce_init_eq_table() is an unused function that only retains its
declaration in driver.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 5617434..5f1d1b3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1133,7 +1133,6 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 
 int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
-int hns_roce_init_eq_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_cq_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_srq_table(struct hns_roce_dev *hr_dev);
-- 
2.8.1

