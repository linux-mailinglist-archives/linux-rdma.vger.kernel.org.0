Return-Path: <linux-rdma+bounces-9008-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA46A7312B
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 12:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3458C3BBC35
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1EB2139CF;
	Thu, 27 Mar 2025 11:53:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BEF2135B4
	for <linux-rdma@vger.kernel.org>; Thu, 27 Mar 2025 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076420; cv=none; b=rmemfbHq/EWlS4SS6uWUbb0dSINAVkKJW+owmuJuhmb2sJW3NEUbl97m+CV00kSbrUnm4fJKsOnFa7P4v5/jZYg/raB5odpj2Atmz6RGXABGecQvQyPhxjWuvWOBOmp/AjNm42SKAlqJraCVllAFazWW87/a/iSdFxnkzjt4R5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076420; c=relaxed/simple;
	bh=fTqzXDLZJIeZvM+CAFuvAI2ri64ibmNVnvnVijHK7BI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byUr6Ekg8bEhZP17FOBiWGRe0VAPJeebLvka0PNRagzI273FEr6jZ/KVqtivxmYml0hgfz9Wp3JO1hn/UdBq0i6k4inHFHYeeYiUQ0fsXs+RHOnesHtRKjNk4uUsiWX/yHMHjU6KszquqoaBY9uRTpOsM3ZN+xXkBY4Xq0x6vP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZNhqn0DVXz13LT4;
	Thu, 27 Mar 2025 19:53:09 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 2970D1800B4;
	Thu, 27 Mar 2025 19:53:33 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Mar 2025 19:53:32 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 2/2] RDMA/hns: Fix wrong maximum DMA segment size
Date: Thu, 27 Mar 2025 19:47:24 +0800
Message-ID: <20250327114724.3454268-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250327114724.3454268-1-huangjunxian6@hisilicon.com>
References: <20250327114724.3454268-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

Set maximum DMA segment size to 2G instead of UINT_MAX due to HW limit.

Fixes: e0477b34d9d1 ("RDMA: Explicitly pass in the dma_device to ib_register_device")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index ae24c81c9812..18a78f577c1b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -763,7 +763,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		if (ret)
 			return ret;
 	}
-	dma_set_max_seg_size(dev, UINT_MAX);
+	dma_set_max_seg_size(dev, SZ_2G);
 	ret = ib_register_device(ib_dev, "hns_%d", dev);
 	if (ret) {
 		dev_err(dev, "ib_register_device failed!\n");
-- 
2.33.0


