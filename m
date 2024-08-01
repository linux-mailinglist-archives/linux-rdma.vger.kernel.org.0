Return-Path: <linux-rdma+bounces-4145-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0499445DD
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 09:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823221F2180C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC69157490;
	Thu,  1 Aug 2024 07:49:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3C1EB4A2;
	Thu,  1 Aug 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498596; cv=none; b=UyNsEhbqyQKzUOLhhw9sNnQxF+AfTDq4HB95u7hcXzXCY1g4WC2VxRLObu8dYKEbX7ix0gBN69NfgL77+4+haRTBS+42ZleUH8K84+zQ+Qees06QP0gx0d7J6Lm6lBTL7M/LII6wGZ9bANZYngcL5k5JFUaQvFD/KvPmEpKLv48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498596; c=relaxed/simple;
	bh=bq+4/0cw8Gb20yjCGjpMMO9FWyT0uGeevUV8NESf4b0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TNwpfP7/uoYCY+YU6ECtNbbaFjKr2POBVWg+FBpJXr/FZ6/wGPT93o0I2SvHmNNLDFLNgyjOAFC9DO+HTxjC4qq3YQrVVFfE2vUVA7wUURBpQ1O2HrfJ+QWHuZMHl7UKKAk+Z3J0LuskabL+rQjKZge4/xF8W7Ggi98ufb7Vm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WZLhX5Q7Tz1L99f;
	Thu,  1 Aug 2024 15:49:32 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 38152140384;
	Thu,  1 Aug 2024 15:49:45 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 1 Aug 2024 15:49:44 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <bvanassche@acm.org>,
	<nab@risingtidesystems.com>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<target-devel@vger.kernel.org>
Subject: [PATCH for-rc] RDMA/srpt: Fix UAF when srpt_add_one() failed
Date: Thu, 1 Aug 2024 15:44:15 +0800
Message-ID: <20240801074415.1033323-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Currently cancel_work_sync() is not called when srpt_refresh_port()
failed in srpt_add_one(). There is a probability that sdev has been
freed while the previously initiated sport->work is still running,
leading to a UAF as the log below:

[  T880] ib_srpt MAD registration failed for hns_1-1.
[  T880] ib_srpt srpt_add_one(hns_1) failed.
[  T376] Unable to handle kernel paging request at virtual address 0000000000010008
...
[  T376] Workqueue: events srpt_refresh_port_work [ib_srpt]
...
[  T376] Call trace:
[  T376]  srpt_refresh_port+0x94/0x264 [ib_srpt]
[  T376]  srpt_refresh_port_work+0x1c/0x2c [ib_srpt]
[  T376]  process_one_work+0x1d8/0x4cc
[  T376]  worker_thread+0x158/0x410
[  T376]  kthread+0x108/0x13c
[  T376]  ret_from_fork+0x10/0x18

Add cancel_work_sync() to the exception branch to fix this UAF.

Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 9632afbd727b..244e5c115bf7 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3148,8 +3148,8 @@ static int srpt_add_one(struct ib_device *device)
 {
 	struct srpt_device *sdev;
 	struct srpt_port *sport;
+	u32 i, j;
 	int ret;
-	u32 i;
 
 	pr_debug("device = %p\n", device);
 
@@ -3226,7 +3226,6 @@ static int srpt_add_one(struct ib_device *device)
 		if (ret) {
 			pr_err("MAD registration failed for %s-%d.\n",
 			       dev_name(&sdev->device->dev), i);
-			i--;
 			goto err_port;
 		}
 	}
@@ -3241,6 +3240,8 @@ static int srpt_add_one(struct ib_device *device)
 	return 0;
 
 err_port:
+	for (j = i, i--; j > 0; j--)
+		cancel_work_sync(&sdev->port[j - 1].work);
 	srpt_unregister_mad_agent(sdev, i);
 err_cm:
 	if (sdev->cm_id)
-- 
2.33.0


