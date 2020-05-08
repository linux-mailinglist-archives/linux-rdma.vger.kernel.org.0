Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D2B1CA778
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2020 11:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEHJqX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 May 2020 05:46:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726950AbgEHJqX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 May 2020 05:46:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B558B3FC4477D0247AC0;
        Fri,  8 May 2020 17:46:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 17:46:11 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 5/9] RDMA/hns: Fix error with to_hr_hem_entries_count()
Date:   Fri, 8 May 2020 17:45:55 +0800
Message-ID: <1588931159-56875-6-git-send-email-liweihang@huawei.com>
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

For ilog2(x), if x is 0 and not a constant variable, it will return -1. And
there will be an error as below:

hns3 0000:7d:00.0 hns_0: Local work queue 0x8 catast error, sub_event type is: 2

So modify to_hr_hem_entries_shift() to return 0 if conut is 0.

Fixes: 54d6638765b0 ("RDMA/hns: Optimize WQE buffer size calculating process")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 5cac14d..5564773 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1111,6 +1111,9 @@ static inline u32 to_hr_hem_entries_count(u32 count, u32 buf_shift)
 
 static inline u32 to_hr_hem_entries_shift(u32 count, u32 buf_shift)
 {
+	if (!count)
+		return 0;
+
 	return ilog2(to_hr_hem_entries_count(count, buf_shift));
 }
 
-- 
2.8.1

