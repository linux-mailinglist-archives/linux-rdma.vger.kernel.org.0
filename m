Return-Path: <linux-rdma+bounces-9007-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8D9A7312A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 12:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0C43A4102
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA0F213E72;
	Thu, 27 Mar 2025 11:53:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C385B2139CF
	for <linux-rdma@vger.kernel.org>; Thu, 27 Mar 2025 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076418; cv=none; b=AliL/gbcG0LCwWLxu5XLoLe8xxqyxrDs4RNO/UqL82ULIo+Iqz5F/IpUEO+HHbW6tKqLcaGpsb8tchqknIT9uAa6IPR1F9cg/OABtLjdw2L0pDZ3Wb7e0UbBOHkJNIncwbgtyPK9EHA2bBFhIX9Ru3j0IfqPGb6k/Rax0q3Ljmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076418; c=relaxed/simple;
	bh=65xv5XUT6PnPTHq7wEpscmJSLe72WsijdObcJCMvPUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/q5JiqXqRub+wnPzWI+3xx44TZyZYwIsovNnnORsa8hdn0FvLdhQ4K2firIK6hHbrUcNVBabF+mNYturPXi2UrmpM3PObPlMpLmzrq/ebOaRR4ahB8FZCDGIYHDFm1X4EfQ3XIyGfmk2vVzYDP0vAfxRpabM1Tjfoaf/sNCMiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZNhp90XWpz1FNH9;
	Thu, 27 Mar 2025 19:51:45 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id D9AF91402CD;
	Thu, 27 Mar 2025 19:53:32 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Mar 2025 19:53:32 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 1/2] RDMA/hns: Remove unused parameters
Date: Thu, 27 Mar 2025 19:47:23 +0800
Message-ID: <20250327114724.3454268-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250327114724.3454268-1-huangjunxian6@hisilicon.com>
References: <20250327114724.3454268-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

Remove unused parameters.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index dded339802b3..b024cdac8ff6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4270,8 +4270,7 @@ static inline int get_pdn(struct ib_pd *ib_pd)
 }
 
 static void modify_qp_reset_to_init(struct ib_qp *ibqp,
-				    struct hns_roce_v2_qp_context *context,
-				    struct hns_roce_v2_qp_context *qpc_mask)
+				    struct hns_roce_v2_qp_context *context)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
@@ -5090,7 +5089,7 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		memset(qpc_mask, 0, hr_dev->caps.qpc_sz);
-		modify_qp_reset_to_init(ibqp, context, qpc_mask);
+		modify_qp_reset_to_init(ibqp, context);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
 		modify_qp_init_to_init(ibqp, context, qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
-- 
2.33.0


