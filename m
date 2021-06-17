Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676B53AADA4
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 09:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhFQHeb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 03:34:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4954 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFQHea (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Jun 2021 03:34:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5DFg0Llyz6y7h;
        Thu, 17 Jun 2021 15:29:11 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 15:32:21 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 15:32:21 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v3 for-next 1/8] RDMA/hns: Use temporary variables to fix warning about hr_reg_write()
Date:   Thu, 17 Jun 2021 15:31:44 +0800
Message-ID: <1623915111-43630-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623915111-43630-1-git-send-email-liweihang@huawei.com>
References: <1623915111-43630-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Fix complains from sparse about "dubious: x & !y" when calling
hr_reg_write(ctx, field, !!val).

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_common.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index 3a5658f..eb2d670 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -79,9 +79,10 @@
 
 #define _hr_reg_write(ptr, field_type, field_h, field_l, val)                  \
 	({                                                                     \
+		u32 _val = val;                                                \
 		_hr_reg_clear(ptr, field_type, field_h, field_l);              \
 		*((__le32 *)ptr + (field_h) / 32) |= cpu_to_le32(FIELD_PREP(   \
-			GENMASK((field_h) % 32, (field_l) % 32), val));        \
+			GENMASK((field_h) % 32, (field_l) % 32), _val));       \
 	})
 
 #define hr_reg_write(ptr, field, val) _hr_reg_write(ptr, field, val)
-- 
2.7.4

