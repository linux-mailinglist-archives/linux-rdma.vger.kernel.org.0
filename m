Return-Path: <linux-rdma+bounces-11860-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFCCAF729C
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 13:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A007ADE8F
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 11:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2152E2EF3;
	Thu,  3 Jul 2025 11:39:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344527584E
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542752; cv=none; b=MIFJlEszeLH5rUcdpauj59yoAXCA/GaGfenadkGWQ2+Pyqo2LW0gbI2iyRCagHikshk4Mujgu++6RAkaiCfXYScFes0XeW3PVIAvJ3A5AzqbzR/I9LiWlX7AzS9RBnaW8OpWmYJeeoFslQ3AXEb7i6mBd0ELgvgONO7AR5S/5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542752; c=relaxed/simple;
	bh=zqC6u/tO68w6gEZcYs3+Fckro0gSUzrVcAASQmcqLXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5B7x05gwrNIopy0GhXylZvKkmw4KuFzZsESsyiEd1HTfEQ4mPpPlY8xssnYlFrNtoP3EH49ardjr3MpCu5OJu3hBkRzBOTr7IaPkpIL0EsdrFnfUl+5s+WKhu0F4pVRnDWLCdeLN4kQXBSqf07+EvCdLy+mbm64uWSFwFxYfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bXvqS20PGz13Mhj;
	Thu,  3 Jul 2025 19:36:36 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 699C6180B64;
	Thu,  3 Jul 2025 19:39:07 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 19:39:06 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 2/6] RDMA/hns: Fix HW configurations not cleared in error flow
Date: Thu, 3 Jul 2025 19:39:01 +0800
Message-ID: <20250703113905.3597124-3-huangjunxian6@hisilicon.com>
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

From: wenglianfa <wenglianfa@huawei.com>

hns_roce_clear_extdb_list_info() will eventually do some HW
configurations through FW, and they need to be cleared by
calling hns_roce_function_clear() when the initialization
fails.

Fixes: 7e78dd816e45 ("RDMA/hns: Clear extended doorbell info before using")
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 602c5a4c682a..4f2dbc3ffb31 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3001,7 +3001,7 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 
 	ret = get_hem_table(hr_dev);
 	if (ret)
-		goto err_clear_extdb_failed;
+		goto err_get_hem_table_failed;
 
 	if (hr_dev->is_vf)
 		return 0;
@@ -3016,6 +3016,8 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 
 err_llm_init_failed:
 	put_hem_table(hr_dev);
+err_get_hem_table_failed:
+	hns_roce_function_clear(hr_dev);
 err_clear_extdb_failed:
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
 		free_mr_exit(hr_dev);
-- 
2.33.0


