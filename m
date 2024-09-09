Return-Path: <linux-rdma+bounces-4818-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B6970EB5
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 08:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69861C21E2D
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 06:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB331AD9E9;
	Mon,  9 Sep 2024 06:59:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15D1AD5C1;
	Mon,  9 Sep 2024 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865168; cv=none; b=BPoTKG6fjFGbbA1oj2y63/3lkMuPL+OgaQfv1M+7MkJHb0W2akNjU/s/iAyQYqRfXlUzjFrOSOtUctLVvHnDLdc81bBNHpIJ5LrizV2fHF/Z3cJCcefRVY/UaGV23zfDcWSoknmq0Z9JfxUUXV7WKj2lZOcu93cjxQdCHZbj48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865168; c=relaxed/simple;
	bh=rD4KS31Xa1Mlk3Os2AhVULhgkeLY5lQSq0L6ElwF6pA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OG9Rx3lL+fHQx/PBTfs9py6QFd9L7dRJ9GeeQbnVqpQJd1srNjas6+BM3mribbuLgwt22RNTwUWEA2k06qAdt/vnjHykR7KOpkjjgZ9IwlUd4zzlwC8WufHvX61hi7hZV/dM788Tnpi+sKq17hIoK07Gs3BpJ7b2UUDm2AG3dxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X2Hk80fjRz2Dbxx;
	Mon,  9 Sep 2024 14:58:56 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id A1F38140134;
	Mon,  9 Sep 2024 14:59:22 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Sep 2024 14:59:22 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next] RDMA/hns: Fix restricted __le16 degrades to integer issue
Date: Mon, 9 Sep 2024 14:53:31 +0800
Message-ID: <20240909065331.3950268-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
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

Fix sparse warnings: restricted __le16 degrades to integer.

Fixes: 5a87279591a1 ("RDMA/hns: Support hns HW stats")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409080508.g4mNSLwy-lkp@intel.com/
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 621b057fb9da..78a18608f4c5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1681,8 +1681,8 @@ static int hns_roce_hw_v2_query_counter(struct hns_roce_dev *hr_dev,
 
 	for (i = 0; i < HNS_ROCE_HW_CNT_TOTAL && i < *num_counters; i++) {
 		bd_idx = i / CNT_PER_DESC;
-		if (!(desc[bd_idx].flag & HNS_ROCE_CMD_FLAG_NEXT) &&
-		    bd_idx != HNS_ROCE_HW_CNT_TOTAL / CNT_PER_DESC)
+		if (bd_idx != HNS_ROCE_HW_CNT_TOTAL / CNT_PER_DESC &&
+		    !(desc[bd_idx].flag & cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT)))
 			break;
 
 		cnt_data = (__le64 *)&desc[bd_idx].data[0];
-- 
2.33.0


