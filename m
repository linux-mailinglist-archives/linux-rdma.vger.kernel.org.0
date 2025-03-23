Return-Path: <linux-rdma+bounces-8904-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4868BA6CDD1
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Mar 2025 04:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BE3188CA24
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Mar 2025 03:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D221F4633;
	Sun, 23 Mar 2025 03:23:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AE1C8604;
	Sun, 23 Mar 2025 03:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742700228; cv=none; b=Ql7uHZ5BqTW03ruDARJvww0GzMMq9ESyrNGcHj6+OHu8//O96Q9ddHJIey8o6aynogU6JhZP37TmZqh8nNKe9bmdoRxXK77O97Oa5BWbWhmWblOs6krdg9NEh6AlJRtoQUkRbZPp+BNeIeHlVEsm5KknwFfd1jfo3FuMmRJZcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742700228; c=relaxed/simple;
	bh=dM5rBeVJLlUGtD4m318JJVMBVAVkApyitEpqvLYGLhE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OAYEoDiN7dG222jihMamu3sGxWNoh0WK13CIaHkLqJU5jB7oHtF2EeDzl5LHNjP3gzH/vOfFWXR2dwc2uEhc1mDWB8sEVksUCDSv8zDEyic8QTw+Fd+qHgkTKbcIM+eSrAni9TLJ2EaxUPidmrt4cgO8uQyGpaOm6ngQgANgQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZL1jL6lPJz1d0gl;
	Sun, 23 Mar 2025 11:23:18 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A48D14035E;
	Sun, 23 Mar 2025 11:23:37 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 23 Mar
 2025 11:23:36 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <benve@cisco.com>, <neescoba@cisco.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <liyuyu6@huawei.com>, <umalhi@cisco.com>,
	<roland@purestorage.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/usnic: Fix passing zero to PTR_ERR in usnic_ib_pci_probe()
Date: Sun, 23 Mar 2025 11:34:14 +0800
Message-ID: <20250323033414.1716788-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

drivers/infiniband/hw/usnic/usnic_ib_main.c:590
 usnic_ib_pci_probe() warn: passing zero to 'PTR_ERR'

Use err code in usnic_err() to fix this.

Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index 4ddcd5860e0f..e40370f9ff25 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -587,9 +587,9 @@ static int usnic_ib_pci_probe(struct pci_dev *pdev,
 
 	pf = usnic_ib_discover_pf(vf->vnic);
 	if (IS_ERR_OR_NULL(pf)) {
-		usnic_err("Failed to discover pf of vnic %s with err%ld\n",
-				pci_name(pdev), PTR_ERR(pf));
 		err = pf ? PTR_ERR(pf) : -EFAULT;
+		usnic_err("Failed to discover pf of vnic %s with err%d\n",
+				pci_name(pdev), err);
 		goto out_clean_vnic;
 	}
 
-- 
2.34.1


