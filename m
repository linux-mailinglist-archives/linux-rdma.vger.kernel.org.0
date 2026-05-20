Return-Path: <linux-rdma+bounces-21021-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPwCAXhNDWoNvwUAu9opvQ
	(envelope-from <linux-rdma+bounces-21021-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 07:58:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C0C587F4D
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 07:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E4DA3026ED8
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 05:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A0236BCF2;
	Wed, 20 May 2026 05:58:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC632F9DA1
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256690; cv=none; b=UYnwj+tMDPKvQLfRpIPaiaUNFyvYYm06NZx+kHgwUK9H1EttDWXQDIz3w5D47xv54J+dkdDu4Nbfm9JXjbr3Vdq1MtyYM0dH0XX7snbooSl+StNrfOgqE005jvkz1+7ea2UTv+bgeUItLVDY9Xx5aETIK37R4gpYQTKRzQ0sIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256690; c=relaxed/simple;
	bh=6Ai732mE2pv5ezabuWduadsxPOKmatScKI//XvBycP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffXcm/oUA+0DeKNLaqh4Cp1pQDiQbStPRK/vme9lGtWzgjSzAnuuBGmXOKO6uxmfniTPCR9o7kEmYa0miZeLigMdIm0w8qNt8+yDn4LkgMiN2JT+Hv6GqC/nwLG0JdQBDrt3sXX/5tkPrNEiY55lkroR4BMsMFsXDdzM/eOjAe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gL0xw0LJfzcb0T;
	Wed, 20 May 2026 13:50:28 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id C84A240577;
	Wed, 20 May 2026 13:58:01 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 20 May 2026 13:58:01 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 3/3] RDMA/hns: Fix log flood after cmd_mbox failure
Date: Wed, 20 May 2026 13:57:59 +0800
Message-ID: <20260520055759.2354037-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260520055759.2354037-1-huangjunxian6@hisilicon.com>
References: <20260520055759.2354037-1-huangjunxian6@hisilicon.com>
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
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21021-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hisilicon.com:mid,hisilicon.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: 29C0C587F4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lianfa Weng <wenglianfa@huawei.com>

hns_roce_cmd_mbox() is the command interface between driver and
hardware. When hardware is abnormal, the unlimited error printings
after hns_roce_cmd_mbox() failure will cause log flood and even
system crash.

Replace ibdev_err() and ibdev_warn() with their ratelimited versions
in the error handling path after hns_roce_cmd_mbox() (and its wrappers
hns_roce_create_hw_ctx/hns_roce_destroy_hw_ctx) fails.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Lianfa Weng <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c    |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 18 +++++++++---------
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_srq.c   |  2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 24de651f735e..1dd0efb5620d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -174,9 +174,9 @@ static int hns_roce_create_cqc(struct hns_roce_dev *hr_dev,
 	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_CQC,
 				     hr_cq->cqn);
 	if (ret)
-		ibdev_err(ibdev,
-			  "failed to send create cmd for CQ(0x%lx), ret = %d.\n",
-			  hr_cq->cqn, ret);
+		ibdev_err_ratelimited(ibdev,
+				      "failed to send create cmd for CQ(0x%lx), ret = %d.\n",
+				      hr_cq->cqn, ret);
 
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4afd7d6ae3ca..332a4816f2ca 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6193,9 +6193,9 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 					HNS_ROCE_CMD_MODIFY_SRQC, srq->srqn);
 		hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 		if (ret)
-			ibdev_err(&hr_dev->ib_dev,
-				  "failed to handle cmd of modifying SRQ, ret = %d.\n",
-				  ret);
+			ibdev_err_ratelimited(&hr_dev->ib_dev,
+					      "failed to handle cmd of modifying SRQ, ret = %d.\n",
+					      ret);
 	}
 
 out:
@@ -6221,9 +6221,9 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma,
 				HNS_ROCE_CMD_QUERY_SRQC, srq->srqn);
 	if (ret) {
-		ibdev_err(&hr_dev->ib_dev,
-			  "failed to process cmd of querying SRQ, ret = %d.\n",
-			  ret);
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to process cmd of querying SRQ, ret = %d.\n",
+				      ret);
 		goto out;
 	}
 
@@ -6329,9 +6329,9 @@ static int hns_roce_v2_query_mpt(struct hns_roce_dev *hr_dev, u32 key,
 	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_MPT,
 				key_to_hw_index(key));
 	if (ret) {
-		ibdev_err(&hr_dev->ib_dev,
-			  "failed to process cmd when querying MPT, ret = %d.\n",
-			  ret);
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to process cmd when querying MPT, ret = %d.\n",
+				      ret);
 		goto err_mailbox;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 896af1828a38..e8a9e7d8f267 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -173,7 +173,7 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_MPT,
 				     mtpt_idx & (hr_dev->caps.num_mtpts - 1));
 	if (ret) {
-		dev_err(dev, "failed to create mpt, ret = %d.\n", ret);
+		dev_err_ratelimited(dev, "failed to create mpt, ret = %d.\n", ret);
 		goto err_page;
 	}
 
@@ -315,7 +315,7 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 	ret = hns_roce_destroy_hw_ctx(hr_dev, HNS_ROCE_CMD_DESTROY_MPT,
 				      mtpt_idx);
 	if (ret)
-		ibdev_warn(ib_dev, "failed to destroy MPT, ret = %d.\n", ret);
+		ibdev_warn_ratelimited(ib_dev, "failed to destroy MPT, ret = %d.\n", ret);
 
 	mr->enabled = 0;
 	mr->iova = virt_addr;
@@ -346,7 +346,7 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_MPT,
 				     mtpt_idx);
 	if (ret) {
-		ibdev_err(ib_dev, "failed to create MPT, ret = %d.\n", ret);
+		ibdev_err_ratelimited(ib_dev, "failed to create MPT, ret = %d.\n", ret);
 		goto free_cmd_mbox;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 8644c3916367..00552a08f21a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -103,7 +103,7 @@ static int hns_roce_create_srqc(struct hns_roce_dev *hr_dev,
 	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_SRQ,
 				     srq->srqn);
 	if (ret)
-		ibdev_err(ibdev, "failed to config SRQC, ret = %d.\n", ret);
+		ibdev_err_ratelimited(ibdev, "failed to config SRQC, ret = %d.\n", ret);
 
 err_mbox:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
-- 
2.33.0


