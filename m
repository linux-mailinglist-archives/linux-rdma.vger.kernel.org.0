Return-Path: <linux-rdma+bounces-4512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ED095CA2D
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 12:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A14D1C2476B
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F631885B3;
	Fri, 23 Aug 2024 10:11:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522D187337;
	Fri, 23 Aug 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407871; cv=none; b=DvLXFLwmX60Asj3QOqVISYpAgbIOM2FbiFxpis/s3m8ZZUKVZGBG2kJ8YDke/SAJrBWnKfmHzJshqkntCqGp8qh/IZdqF+psHIu0m6pX/JKrawedIe4YLWNw4lyHAzSaGqteKxnZfVG6niy9fcQrlHg+I7Dj2Wiwa1D9yjqKTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407871; c=relaxed/simple;
	bh=5zkOIEQA6/ejpQIpp3Ve+QGZ/LWSGkz8iMJTZvI0ANA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSiSm0hd9xgTKuJJFRWPcXXyfHbuNZP/XcAaYHYpMCQRZhwmHl9jcnjEGguiRjW1TfI512Uyl113h3JHMugNIE0aKbaJIe97xsTduyn3pbqDg6iEqi9KD3QDYBY722P42acyBUmv/tQjR6qATMfPJrb3NSRAha8iJoYMMSqlszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WqwhG6tbWzQqQM;
	Fri, 23 Aug 2024 18:06:22 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 36C8D140137;
	Fri, 23 Aug 2024 18:11:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 18:11:06 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <dennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bvanassche@acm.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 3/4] RDMA/mlx4: Simplify an alloc_ordered_workqueue() invocation
Date: Fri, 23 Aug 2024 18:18:39 +0800
Message-ID: <20240823101840.515398-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823101840.515398-1-ruanjinjie@huawei.com>
References: <20240823101840.515398-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Let alloc_ordered_workqueue() format the workqueue name instead of calling
snprintf() explicitly.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/infiniband/hw/mlx4/alias_GUID.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 9a439569ffcf..d7327735b8d0 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -829,7 +829,6 @@ void mlx4_ib_destroy_alias_guid_service(struct mlx4_ib_dev *dev)
 
 int mlx4_ib_init_alias_guid_service(struct mlx4_ib_dev *dev)
 {
-	char alias_wq_name[22];
 	int ret = 0;
 	int i, j;
 	union ib_gid gid;
@@ -875,9 +874,8 @@ int mlx4_ib_init_alias_guid_service(struct mlx4_ib_dev *dev)
 		dev->sriov.alias_guid.ports_guid[i].parent = &dev->sriov.alias_guid;
 		dev->sriov.alias_guid.ports_guid[i].port  = i;
 
-		snprintf(alias_wq_name, sizeof alias_wq_name, "alias_guid%d", i);
 		dev->sriov.alias_guid.ports_guid[i].wq =
-			alloc_ordered_workqueue(alias_wq_name, WQ_MEM_RECLAIM);
+			alloc_ordered_workqueue("alias_guid%d", WQ_MEM_RECLAIM, i);
 		if (!dev->sriov.alias_guid.ports_guid[i].wq) {
 			ret = -ENOMEM;
 			goto err_thread;
-- 
2.34.1


