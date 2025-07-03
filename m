Return-Path: <linux-rdma+bounces-11862-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A79AF72A5
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 13:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F119716F72A
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23F42E3AFD;
	Thu,  3 Jul 2025 11:39:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C861B299930
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542752; cv=none; b=S+82jFqbevoRy3fE9FUR+fuds/oN4gslHIzHZLO3muD/27U91x5aAaAAqUCkAzsyb/7QJOLJLF1eJnVtkm2rDdKgMR6mJvWr3L1N0mkYnlfsSjLYoPjkw10clpFI7t5mMFyi7BjbxnsaUeQggJ/cKMYsUSPJKvwqYj0gUPE4t5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542752; c=relaxed/simple;
	bh=x+y8TIPkyXqJBxBKdu+kU/m8hCOaBHhyrh5tFvHt1Cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaN8ZDVOes1mVt/U07U/IDkq4/GO8srF2s7GZDRKxABRdRQaKLggKr3e1NOXpImLDo3a/jZV65EZ7m5MR8yYUgdF7Cy1fMiMrs6309rXLtv1i3PIsCX+uvdX5Bs/XdIJhAAPhWHsBwT4V23r6AI1Ga5CcdQqJSmRzWTTof+6Zuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bXvqS4vsSz1R8g0;
	Thu,  3 Jul 2025 19:36:36 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 334BE1A0188;
	Thu,  3 Jul 2025 19:39:08 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 19:39:07 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 4/6] RDMA/hns: Fix accessing uninitialized resources
Date: Thu, 3 Jul 2025 19:39:03 +0800
Message-ID: <20250703113905.3597124-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250703113905.3597124-1-huangjunxian6@hisilicon.com>
References: <20250703113905.3597124-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100018.china.huawei.com (7.202.181.17)

hr_dev->pgdir_list and hr_dev->pgdir_mutex won't be initialized if
CQ/QP record db are not enabled, but they are also needed when using
SRQ with SRQ record db enabled. Simplified the logic by always
initailizing the reosurces.

Fixes: c9813b0b9992 ("RDMA/hns: Support SRQ record doorbell")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 427dd700cddc..d50f36f8a110 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -937,10 +937,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 static void hns_roce_teardown_hca(struct hns_roce_dev *hr_dev)
 {
 	hns_roce_cleanup_bitmap(hr_dev);
-
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
-	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
-		mutex_destroy(&hr_dev->pgdir_mutex);
+	mutex_destroy(&hr_dev->pgdir_mutex);
 }
 
 /**
@@ -958,11 +955,8 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 	INIT_LIST_HEAD(&hr_dev->qp_list);
 	spin_lock_init(&hr_dev->qp_list_lock);
 
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
-	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) {
-		INIT_LIST_HEAD(&hr_dev->pgdir_list);
-		mutex_init(&hr_dev->pgdir_mutex);
-	}
+	INIT_LIST_HEAD(&hr_dev->pgdir_list);
+	mutex_init(&hr_dev->pgdir_mutex);
 
 	hns_roce_init_uar_table(hr_dev);
 
@@ -994,9 +988,7 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 err_uar_table_free:
 	ida_destroy(&hr_dev->uar_ida.ida);
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
-	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
-		mutex_destroy(&hr_dev->pgdir_mutex);
+	mutex_destroy(&hr_dev->pgdir_mutex);
 
 	return ret;
 }
-- 
2.33.0


