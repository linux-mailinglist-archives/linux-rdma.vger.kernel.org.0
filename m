Return-Path: <linux-rdma+bounces-15278-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 184FCCF0AB3
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 07:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9C18300DA41
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 06:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB482DF701;
	Sun,  4 Jan 2026 06:41:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519F2D8365
	for <linux-rdma@vger.kernel.org>; Sun,  4 Jan 2026 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767508864; cv=none; b=T2oE993lWddUmGehJim+Dcng3dG/1sniycRdxvgIUrw1hXQkFK+kOTxYyQBeL50yJ5k0uJunhbKKv3kgFUunoXwDIMUxvi09MVDScPIhaOEpaGoX/pRN2JuItQcLAy+r60V7Xia9LSI27v7QIzEL+ZuzlZODc+iLRQswevXw0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767508864; c=relaxed/simple;
	bh=3vz7yTBh2Njzf49y/weeNiO4b+NQEh4S4Hi+hbSjpJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQ4jLLFM5RBXL8xoGASaSjbJrlhi1aHJM7R/dLYdtKS6lV+4C5vf+p8XsmlxhRF5N7BElPkvzJmF8bhX2eANVcz+M8nkVM9mGVlXlR96ZT5K9jNTzi6eT25AUqvUNySky3oQOzqDZHjy+08nIzzJ5DJXRkz8kFQSA5hIZwLqHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dkSRD755jzmV6n;
	Sun,  4 Jan 2026 14:37:44 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 253A2406A9;
	Sun,  4 Jan 2026 14:40:59 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 4 Jan 2026 14:40:58 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 2/4] RDMA/hns: Return actual error code instead of fixed EINVAL
Date: Sun, 4 Jan 2026 14:40:55 +0800
Message-ID: <20260104064057.1582216-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260104064057.1582216-1-huangjunxian6@hisilicon.com>
References: <20260104064057.1582216-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)

query_cqc() and query_mpt() may return various error codes in
different cases. Return actual error code instead of fixed EINVAL.

Fixes: f2b070f36d1b ("RDMA/hns: Support CQ's restrack raw ops for hns driver")
Fixes: 3d67e7e236ad ("RDMA/hns: Support MR's restrack raw ops for hns driver")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 230187dda6a0..085791cc617c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -51,7 +51,7 @@ int hns_roce_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ib_cq)
 
 	ret = hr_dev->hw->query_cqc(hr_dev, hr_cq->cqn, &context);
 	if (ret)
-		return -EINVAL;
+		return ret;
 
 	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, sizeof(context), &context);
 
@@ -177,7 +177,7 @@ int hns_roce_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ib_mr)
 
 	ret = hr_dev->hw->query_mpt(hr_dev, hr_mr->key, &context);
 	if (ret)
-		return -EINVAL;
+		return ret;
 
 	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, sizeof(context), &context);
 
-- 
2.33.0


