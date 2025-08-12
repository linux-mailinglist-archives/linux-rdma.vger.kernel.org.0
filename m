Return-Path: <linux-rdma+bounces-12680-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D309B226B7
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 14:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3852A7755
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AE41A8412;
	Tue, 12 Aug 2025 12:26:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E32218A6DF
	for <linux-rdma@vger.kernel.org>; Tue, 12 Aug 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001577; cv=none; b=KtnnNDDL/y1Rfq18+egKyHarci9b9PJxMt4wHQ3AP5A0GF3zWwRlk+15cWHrP3pdK6T+21s71udf2GhQLzZ0bHh0VE+PT17kIdrvuf69kzFJifYktJgSmiWkWZqnRw3h9tWvISdq0sAJ/ffUGYJWT7BLOB8aDnbnyI13KwIHHoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001577; c=relaxed/simple;
	bh=H3Ao9YbYsRkQdRDxwu9Stla57jMewVU3ru+XYhd0Ewo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HeQEbIAiT4y4YSU3I0aGIkQAKvum+9Kyvti5pBWLfgrg+zlypHmjS9TFBSaAqKgNDevSHJOBBkLv6FVhWkWq26Z/Lq5XSoKyID2+/lbHpya3h4JHlSl19zTJzvSBa3FMe6LemIBc54yuz7WTMxcaOuX3Zfk4Vq/WgiwaWN1y20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c1Vy85HG6z13MyT;
	Tue, 12 Aug 2025 20:22:40 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id C2EED18007F;
	Tue, 12 Aug 2025 20:26:03 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 20:26:03 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Fix dip entries leak on devices newer than hip09
Date: Tue, 12 Aug 2025 20:26:02 +0800
Message-ID: <20250812122602.3524602-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100018.china.huawei.com (7.202.181.17)

DIP algorithm is also supported on devices newer than hip09, so free
dip entries too.

Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fa8747656f25..8c6b53f5b0a8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3022,7 +3022,7 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 	if (!hr_dev->is_vf)
 		hns_roce_free_link_table(hr_dev);
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP09)
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
 		free_dip_entry(hr_dev);
 }
 
-- 
2.33.0


