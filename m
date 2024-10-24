Return-Path: <linux-rdma+bounces-5501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D79AE548
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 14:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A151F23687
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159DF17DFE4;
	Thu, 24 Oct 2024 12:46:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F01B6CFD;
	Thu, 24 Oct 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773984; cv=none; b=PuhKtlhLDW4Dc4lOuLycMTX8ihfJNdfW+xeul6Tkszpi+V7qbKICaMN71AMDoWShHLR+otl21L1bIotT/hN6CdnA8D6KDBRy64OEbLfyMYDhMicp9LLPTeReTkWJGuMedROqy8+xm1Sbjj2bTgtDwqJySmCvjSAsrCIzc2mlc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773984; c=relaxed/simple;
	bh=lC/oF7TbHcuydV/GiaJHI3ne/ovWQsgOfqiMjKpctX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OThYV8gcwhOpeHClXcXpre9dWwKbCX1DW/mY90cdezBonUKKXSQrJMEbLP9gUSoZpLIjYVt3y93H7NmcbE43jiGzAZ0W4Av+5E3S4gS86rSf0dAYq0R4d5VQ/dPaV1I1g8CwmcGG76jvYPDoMhUpa7BxDqSSmjWmRsPbrm5lvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XZ5JK4mLtz1yn3y;
	Thu, 24 Oct 2024 20:46:25 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D3B51400CA;
	Thu, 24 Oct 2024 20:46:18 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 20:46:17 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH v2 for-rc 3/5] RDMA/hns: Modify debugfs name
Date: Thu, 24 Oct 2024 20:39:58 +0800
Message-ID: <20241024124000.2931869-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
References: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


