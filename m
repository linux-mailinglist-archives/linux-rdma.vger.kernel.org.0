Return-Path: <linux-rdma+bounces-4938-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5F2978024
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968CE1F22216
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E771DA318;
	Fri, 13 Sep 2024 12:36:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54FA1DA0F7;
	Fri, 13 Sep 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230961; cv=none; b=laNcSWFzM9Yr6rjqZKVxWhlFGatauQOOnWuK40NGPYwtdlxKljaUv5ZGFaWzn6YJ8inMAXxjqzkXPiRRRm7X5jT9BXcKbLYY5PoSfCJnBW31w7f+6Q0C2zakBgmmq2lByo+0/j9J42iBrXv1wwETSpgs03Sb3umspioUeE47cLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230961; c=relaxed/simple;
	bh=RKJVRbU/YeLVaz5xn1kS06BHeX6wi6KEvhyLFydcRP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrMYlrnlurVa8ynJApUyFBlmkzrN6Xw6+2cjyQ/jcZ9LEnABD+71Zpf92p0RGiFrLPFkaRZNNYq+f0viDPnvZosjwi6rE7RqjvorXUVjF+ENVfkbYDq/wtOlml9RGHaWTqb2yzRpvr+YIRD2F0y9PbUyAgDSkLNuYgYeKUvmtF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X4v0P2SYlz1SB0B;
	Fri, 13 Sep 2024 20:35:17 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id E73B1140360;
	Fri, 13 Sep 2024 20:35:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Sep 2024 20:35:49 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v5 for-next 2/2] RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset
Date: Fri, 13 Sep 2024 20:29:55 +0800
Message-ID: <20240913122955.1283597-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240913122955.1283597-1-huangjunxian6@hisilicon.com>
References: <20240913122955.1283597-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

When HW is being reset, userspace should not ring doorbell otherwise
it may lead to abnormal consequence such as RAS.

Disassociate mmap pages for all uctx to prevent userspace from ringing
doorbell to HW. Since all resources will be destroyed during HW reset,
no new mmap is allowed after HW reset is completed.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 9 +++++++++
 drivers/infiniband/hw/hns/hns_roce_main.c  | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 24e906b9d3ae..4e374b2da101 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -7017,6 +7017,12 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 
 	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
 }
+
+static void hns_roce_v2_reset_notify_user(struct hns_roce_dev *hr_dev)
+{
+	rdma_user_mmap_disassociate(&hr_dev->ib_dev);
+}
+
 static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 {
 	struct hns_roce_dev *hr_dev;
@@ -7035,6 +7041,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 
 	hr_dev->active = false;
 	hr_dev->dis_db = true;
+
+	hns_roce_v2_reset_notify_user(hr_dev);
+
 	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
 
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 4cb0af733587..49315f39361d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -466,6 +466,11 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
 	pgprot_t prot;
 	int ret;
 
+	if (hr_dev->dis_db) {
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MMAP_ERR_CNT]);
+		return -EPERM;
+	}
+
 	rdma_entry = rdma_user_mmap_entry_get_pgoff(uctx, vma->vm_pgoff);
 	if (!rdma_entry) {
 		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MMAP_ERR_CNT]);
-- 
2.33.0


