Return-Path: <linux-rdma+bounces-3672-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDF39284B1
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 11:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE781C24D8F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 09:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2861474BA;
	Fri,  5 Jul 2024 09:05:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55E4146A67;
	Fri,  5 Jul 2024 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170337; cv=none; b=mm2sjj5qlLRFxkfel7bhwhxk+h5xwlKDHMCBugIon8XEY6j72R6hHdCRCeCgkcNbM9yHcTottsB9muSKhMqctIRimebgwaI70g8CREwNC7MaxzxPyTmWTkFA+/qa5FxXYDCTXyTBq3Mbfhnx4L6KYMRzHCfRicwIzZ4FY2CPpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170337; c=relaxed/simple;
	bh=r4V9fXf6zCFxgeoElygKnz+GBYuxeAVTUBF/lj/7LI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aelPO+iJrMCmXjClivi8bOFgemVKRn5+x6itOGTs5SLgcKkdLTlrBjRh/vQISQFCQQ6QtbqoOIW+ayQeJLoOKkljuTxqg+AHg9J8Z/b6fESQVvo7YTT/4uOtmiQakNbYb6+aLOP3AlCpdtNV7nfoN902S4pAa7SOReO7KB9Ausw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WFnYV4sbHzQkQj;
	Fri,  5 Jul 2024 17:01:02 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id E64FE14107F;
	Fri,  5 Jul 2024 17:04:52 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jul 2024 17:04:52 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 2/9] RDMA/hns: Fix a long wait for cmdq event during reset
Date: Fri, 5 Jul 2024 16:59:30 +0800
Message-ID: <20240705085937.1644229-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
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

From: wenglianfa <wenglianfa@huawei.com>

During reset, cmdq events won't be reported, leading to a long and
unnecessary wait. Notify all the cmdqs to stop waiting at the beginning
of reset.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a5d746a5cc68..ff135df1a761 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6977,6 +6977,21 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 
 	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
 }
+
+static void hns_roce_v2_reset_notify_cmd(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
+	int i;
+
+	if (!hr_dev->cmd_mod)
+		return;
+
+	for (i = 0; i < hr_cmd->max_cmds; i++) {
+		hr_cmd->context[i].result = -EBUSY;
+		complete(&hr_cmd->context[i].done);
+	}
+}
+
 static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 {
 	struct hns_roce_dev *hr_dev;
@@ -6997,6 +7012,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 	hr_dev->dis_db = true;
 	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
 
+	/* Complete the CMDQ event in advance during the reset. */
+	hns_roce_v2_reset_notify_cmd(hr_dev);
+
 	return 0;
 }
 
-- 
2.33.0


