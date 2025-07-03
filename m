Return-Path: <linux-rdma+bounces-11863-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA380AF72A6
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 13:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703C9170090
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596A2E3B18;
	Thu,  3 Jul 2025 11:39:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CAD2874E1
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542753; cv=none; b=OsBNNkm8pgEVD/hN5hqh7Ar36HtNohaBbQYZTGYRoiP4NNbg8phVBMDXAWZSkxNiERApluq6Caa9iR7h7Mux1DDVSxeNIakKqGX9GHazmxFgYHoLyu+aDJT8WxY/2NknmbExAJRUiDonLEcctV0j/IxP86TbdWkAxPk98KhA1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542753; c=relaxed/simple;
	bh=9obxsBG+3Fl55aDK1e56d1viuxd3ly3Ok1Lghw7RSCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiKLwCDn9bfunx2lbuH3u5/a0tmZDtoG9xNm4R8esedWObH9K7JUUw3VkBfa50gxhHSjUIaFSUKp2ybPCwWDBw7vWXpp8oH2eTqxgT1r/cP79L+tdKBDm4tHgEbGuI5gIj3ykOvGjqnc97LyBYnew/S+8fEhl2/XfnLCNNadgwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bXvnK5zKRzWfxS;
	Thu,  3 Jul 2025 19:34:45 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id ED0B7180482;
	Thu,  3 Jul 2025 19:39:08 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 19:39:08 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 6/6] RDMA/hns: Fix -Wframe-larger-than issue
Date: Thu, 3 Jul 2025 19:39:05 +0800
Message-ID: <20250703113905.3597124-7-huangjunxian6@hisilicon.com>
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

Fix -Wframe-larger-than issue by allocating memory for qpc struct
with kzalloc() instead of using stack memory.

Fixes: 606bf89e98ef ("RDMA/hns: Refactor for hns_roce_v2_modify_qp function")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506240032.CSgIyFct-lkp@intel.com/
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f15eb6204959..103aea0f51a8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5349,11 +5349,10 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
-	struct hns_roce_v2_qp_context ctx[2];
-	struct hns_roce_v2_qp_context *context = ctx;
-	struct hns_roce_v2_qp_context *qpc_mask = ctx + 1;
+	struct hns_roce_v2_qp_context *context;
+	struct hns_roce_v2_qp_context *qpc_mask;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	int ret;
+	int ret = -ENOMEM;
 
 	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
 		return -EOPNOTSUPP;
@@ -5364,7 +5363,11 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	 * we should set all bits of the relevant fields in context mask to
 	 * 0 at the same time, else set them to 0x1.
 	 */
-	memset(context, 0, hr_dev->caps.qpc_sz);
+	context = kvzalloc(sizeof(*context), GFP_KERNEL);
+	qpc_mask = kvzalloc(sizeof(*qpc_mask), GFP_KERNEL);
+	if (!context || !qpc_mask)
+		goto out;
+
 	memset(qpc_mask, 0xff, hr_dev->caps.qpc_sz);
 
 	ret = hns_roce_v2_set_abs_fields(ibqp, attr, attr_mask, cur_state,
@@ -5406,6 +5409,8 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 		clear_qp(hr_qp);
 
 out:
+	kvfree(qpc_mask);
+	kvfree(context);
 	return ret;
 }
 
-- 
2.33.0


