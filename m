Return-Path: <linux-rdma+bounces-4792-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498AC96EFCA
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36861F25817
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 09:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D721C9DF6;
	Fri,  6 Sep 2024 09:40:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FDD14A60F;
	Fri,  6 Sep 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615641; cv=none; b=a4PvMWEntk9VH7qH9aVxqzvHFlToASWVP+BUcv2IwbYemZecr6wyNxjuzfkSBgiTD+DV2c8B8FnfAvnzQ7ZEPcG3e/lEKJ2NDzCg6G1AsmIgyRggPBGwoYgWwQ78bKUWV6RVo7QfTRic73yIgbLV5nDH5D2xMjNu138KkwLCRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615641; c=relaxed/simple;
	bh=88eYLhqhc3IkUrTMeuf8p9h3jjMPgX0Pz9/Q6zNVBJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXOFYmdqP1uHPEvgXym3Vnnk+7omDmkYagvlLnwr3NYZMGvpaeNbcw5L6IaOIutmXw+Ma/+H37yKUsJTzDTMzSjKIH5bRzbWrs9SvhB4mq95/oIrDeGzIzicsHdzpBcZoIyZzGM0FnaHo6FFIKP8Ar5eeen/4Oe1BrUupZXcZ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X0WRK2bQwzyRZN;
	Fri,  6 Sep 2024 17:39:57 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 8934E1800FE;
	Fri,  6 Sep 2024 17:40:37 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 17:40:37 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 7/9] RDMA/hns: Fix 1bit-ECC recovery address in non-4K OS
Date: Fri, 6 Sep 2024 17:34:42 +0800
Message-ID: <20240906093444.3571619-8-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
References: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

The 1bit-ECC recovery address read from HW only contain bits 64:12, so
it should be fixed left-shifted 12 bits when used.

Currently, the driver will shift the address left by PAGE_SHIFT when
used, which is wrong in non-4K OS.

Fixes: 2de949abd6a5 ("RDMA/hns: Recover 1bit-ECC error of RAM on chip")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 74bab07c10e5..085461713fa9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6288,7 +6288,7 @@ static u64 fmea_get_ram_res_addr(u32 res_type, __le64 *data)
 	    res_type == ECC_RESOURCE_SCCC)
 		return le64_to_cpu(*data);
 
-	return le64_to_cpu(*data) << PAGE_SHIFT;
+	return le64_to_cpu(*data) << HNS_HW_PAGE_SHIFT;
 }
 
 static int fmea_recover_others(struct hns_roce_dev *hr_dev, u32 res_type,
-- 
2.33.0


