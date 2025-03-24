Return-Path: <linux-rdma+bounces-8916-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE29A6DA00
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 13:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C063A7A6E
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 12:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C51C25E81A;
	Mon, 24 Mar 2025 12:21:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95AE25C71A;
	Mon, 24 Mar 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818894; cv=none; b=BELr3xQYdQxIfGfj/CMPBr4DWeOLTrigoiHW4QcMmIJBtOGokTRmYW/dOP5a/nvS4Z1rjIeWhYDX0RUxiUuFbZu5fYeDtb2tBmJ/GwEeOqLs+vZ2PaAZYFLkud43KBKt522YWTJ0MR29KAY7N+1G2BO/UbrOIytow5uhtV2FXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818894; c=relaxed/simple;
	bh=xcH93BuTXSeThzyCLhWwh/pd26QAyseEOfRU8T9s1V4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TRrp9HCPDRGcH0MxF0PYlGxH1STR7LaZGjJBftpi98+Cna7bneJpEMtbHlqeFpreuOq3oI481tG+KFq47zhWzKP1YWLlJdRSztPoFEmUA9tngwAY0KphXTWz1BCL+JziouCkvn/pjTcTc0Y9jbcLHEebDj/dUMWWYpZqPH8gFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZLsYb5kZPz2PVXn;
	Mon, 24 Mar 2025 20:19:31 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AFA8180044;
	Mon, 24 Mar 2025 20:21:18 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 24 Mar
 2025 20:21:17 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <benve@cisco.com>, <neescoba@cisco.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <liyuyu6@huawei.com>, <roland@purestorage.com>,
	<umalhi@cisco.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <yanjun.zhu@linux.dev>
Subject: [PATCH v2 -next] RDMA/usnic: Fix passing zero to PTR_ERR in usnic_ib_pci_probe()
Date: Mon, 24 Mar 2025 20:31:32 +0800
Message-ID: <20250324123132.2392077-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

drivers/infiniband/hw/usnic/usnic_ib_main.c:590
 usnic_ib_pci_probe() warn: passing zero to 'PTR_ERR'

Make usnic_ib_device_add() return NULL on fail path, also remove
useless NULL check for usnic_ib_discover_pf()

Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
v2: remove useless null check for usnic_ib_discover_pf
---
 drivers/infiniband/hw/usnic/usnic_ib_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index 4ddcd5860e0f..11eca39b73a9 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -397,7 +397,7 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 	if (!us_ibdev) {
 		usnic_err("Device %s context alloc failed\n",
 				netdev_name(pci_get_drvdata(dev)));
-		return ERR_PTR(-EFAULT);
+		return NULL;
 	}
 
 	us_ibdev->ufdev = usnic_fwd_dev_alloc(dev);
@@ -517,8 +517,8 @@ static struct usnic_ib_dev *usnic_ib_discover_pf(struct usnic_vnic *vnic)
 	}
 
 	us_ibdev = usnic_ib_device_add(parent_pci);
-	if (IS_ERR_OR_NULL(us_ibdev)) {
-		us_ibdev = us_ibdev ? us_ibdev : ERR_PTR(-EFAULT);
+	if (!us_ibdev) {
+		us_ibdev = ERR_PTR(-EFAULT);
 		goto out;
 	}
 
@@ -586,10 +586,10 @@ static int usnic_ib_pci_probe(struct pci_dev *pdev,
 	}
 
 	pf = usnic_ib_discover_pf(vf->vnic);
-	if (IS_ERR_OR_NULL(pf)) {
-		usnic_err("Failed to discover pf of vnic %s with err%ld\n",
-				pci_name(pdev), PTR_ERR(pf));
-		err = pf ? PTR_ERR(pf) : -EFAULT;
+	if (IS_ERR(pf)) {
+		err = PTR_ERR(pf);
+		usnic_err("Failed to discover pf of vnic %s with err%d\n",
+				pci_name(pdev), err);
 		goto out_clean_vnic;
 	}
 
-- 
2.34.1


