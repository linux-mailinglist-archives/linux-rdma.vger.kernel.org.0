Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7AC3984BC
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 10:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhFBI74 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 04:59:56 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6136 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhFBI7y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Jun 2021 04:59:54 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fw2t53V2NzYpxk;
        Wed,  2 Jun 2021 16:55:25 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:58:09 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:58:09 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH RESEND v2 for-next 1/7] RDMA/hns: Fix potential compile warnings on hr_reg_write()
Date:   Wed, 2 Jun 2021 16:57:39 +0800
Message-ID: <1622624265-44796-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622624265-44796-1-git-send-email-liweihang@huawei.com>
References: <1622624265-44796-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

