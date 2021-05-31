Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367CC395B04
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhEaNBf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 09:01:35 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3351 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhEaNBb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 May 2021 09:01:31 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FtwJl4drFz67RM;
        Mon, 31 May 2021 20:56:07 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 20:59:50 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 31 May 2021 20:59:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 1/7] RDMA/hns: Fix potential compile warnings on hr_reg_write()
Date:   Mon, 31 May 2021 20:59:28 +0800
Message-ID: <1622465974-20415-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622465974-20415-1-git-send-email-liweihang@huawei.com>
References: <1622465974-20415-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

GCC may reports an running time assert error when a value calculated from
ib_mtu_enum_to_int() is using as 'val' in FIELD_PREDP:

include/linux/compiler_types.h:328:38: error: call to
'__compiletime_assert_1524' declared with attribute error: FIELD_PREP:
value too large for the field

But actually this error will still exists even if the driver can ensure
that ib_mtu_enum_to_int() returns a legal value. So add a mask in
hr_reg_write() to avoid above warning.

Also fix complains from sparse about "dubious: x & !y" when
hr_reg_write(ctx, field, !!val)，Use temporary variables to avoid this.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_common.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index 3a5658f..dc7a9fe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -79,9 +79,11 @@
 
 #define _hr_reg_write(ptr, field_type, field_h, field_l, val)                  \
 	({                                                                     \
+		u32 _val = val;                                                \
 		_hr_reg_clear(ptr, field_type, field_h, field_l);              \
-		*((__le32 *)ptr + (field_h) / 32) |= cpu_to_le32(FIELD_PREP(   \
-			GENMASK((field_h) % 32, (field_l) % 32), val));        \
+		*((__le32 *)ptr + (field_h) / 32) |= cpu_to_le32(              \
+			FIELD_PREP(GENMASK((field_h) % 32, (field_l) % 32),    \
+				   _val & GENMASK((field_h) - (field_l), 0))); \
 	})
 
 #define hr_reg_write(ptr, field, val) _hr_reg_write(ptr, field, val)
-- 
2.7.4

