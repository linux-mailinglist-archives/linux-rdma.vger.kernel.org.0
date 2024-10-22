Return-Path: <linux-rdma+bounces-5477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42669AA100
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 13:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2E71F236EF
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9927419D898;
	Tue, 22 Oct 2024 11:16:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F519D070;
	Tue, 22 Oct 2024 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595801; cv=none; b=pzBYAq8DsAdBipzwU+OBNSb6o4YkbhzposwWchf7xC+D3mcDcgG3JShZ5uQ67BwUYfR51C8xtqM8hHfee0MLqydZB5JYpxKF+kPFKgnnH07nDVWJu9Cbaw4sbb/W8TXEjsleS1yACmb7YzXwOfDJKdUA5pNPT9ImLEMDoRj56rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595801; c=relaxed/simple;
	bh=lC/oF7TbHcuydV/GiaJHI3ne/ovWQsgOfqiMjKpctX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjIz3idwZYyOXcvzm5PZFKoFhiuqeVU4wKfqYNlonXr0L6BdEq4rbn986PqtVX5kQ4M1pQp3ADexwsDDq7tfbBl5veQVrnYxC7diHN3Byswo4COv1bP5ndJ4NRh6w4soD/tSAJnBRckJb6/96CX01morCe1opR5CWakyn2idLp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XXqMn3R9JzyTcR;
	Tue, 22 Oct 2024 19:15:01 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id E48B6140159;
	Tue, 22 Oct 2024 19:16:31 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Oct 2024 19:16:31 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH for-rc 3/5] RDMA/hns: Modify debugfs name
Date: Tue, 22 Oct 2024 19:10:15 +0800
Message-ID: <20241022111017.946170-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241022111017.946170-1-huangjunxian6@hisilicon.com>
References: <20241022111017.946170-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Yuyu Li <liyuyu6@huawei.com>

The sub-directory of hns_roce debugfs is named after the device's
kernel name currently, but it will be inconvenient to use when
the device is renamed.

Modify the name to pci name as users can always easily find the
correspondence between an RDMA device and its pci name.

Fixes: eb7854d63db5 ("RDMA/hns: Support SW stats with debugfs")
Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
index e8febb40f645..b869cdc54118 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
@@ -5,6 +5,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/pci.h>
 
 #include "hns_roce_device.h"
 
@@ -86,7 +87,7 @@ void hns_roce_register_debugfs(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_dev_debugfs *dbgfs = &hr_dev->dbgfs;
 
-	dbgfs->root = debugfs_create_dir(dev_name(&hr_dev->ib_dev.dev),
+	dbgfs->root = debugfs_create_dir(pci_name(hr_dev->pci_dev),
 					 hns_roce_dbgfs_root);
 
 	create_sw_stat_debugfs(hr_dev, dbgfs->root);
-- 
2.33.0


