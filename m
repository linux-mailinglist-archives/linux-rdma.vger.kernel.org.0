Return-Path: <linux-rdma+bounces-15280-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB58CF0AB9
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 07:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4C493017668
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 06:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5B42E040D;
	Sun,  4 Jan 2026 06:41:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52222D876A
	for <linux-rdma@vger.kernel.org>; Sun,  4 Jan 2026 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767508865; cv=none; b=ApLcmuYT7JIMhpNR3wLrJx5/goQ5wVwSHH0FhwRHLjT4c9TJYew4o6v949mfLbNTgTHTtML8zH305EYrdHK2TQjzO209kG+v3oL5XqlPY2jCbDOrRDsKSC64C/UcjPPWD4A72WpmAlleaT7cFZF/pYCYHoj6hTzPVEN5szP11v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767508865; c=relaxed/simple;
	bh=sN34eVXzxvgyaYGUVLpETPmC3bEvOXX+xBpHH/YjzVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNVlScsSBP40ZRoxEkqeqo4HQCGMSztDGEKUm+I1IweNgtcDpJD50lZ24uhMRC0R9UgBE9yo4MyzD5e5KyjNyi6NDWojrjZfUou+EuDsmMYXkKo83x3mTuprLGlXRa9T5NqBGuz0DRzuZ9TRQjG+TeAFDUFkk1h6vheZswAgCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dkSRF4D2mzmV6n;
	Sun,  4 Jan 2026 14:37:45 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id BA2DB40538;
	Sun,  4 Jan 2026 14:40:59 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 4 Jan 2026 14:40:59 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 4/4] RDMA/hns: Notify ULP of remaining soft-WCs during reset
Date: Sun, 4 Jan 2026 14:40:57 +0800
Message-ID: <20260104064057.1582216-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260104064057.1582216-1-huangjunxian6@hisilicon.com>
References: <20260104064057.1582216-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

During a reset, software-generated WCs cannot be reported via
interrupts. This may cause the ULP to miss some WCs.

To avoid this, add check in the CQ arm process: if a hardware reset
has occurred and there are still unreported soft-WCs, notify the ULP
to handle the remaining WCs, thereby preventing any loss of completions.

Fixes: 626903e9355b ("RDMA/hns: Add support for reporting wc as software mode")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1f37d74b466b..a2ae4f33e459 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3739,6 +3739,23 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 		     HNS_ROCE_V2_CQ_DEFAULT_INTERVAL);
 }
 
+static bool left_sw_wc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
+{
+	struct hns_roce_qp *hr_qp;
+
+	list_for_each_entry(hr_qp, &hr_cq->sq_list, sq_node) {
+		if (hr_qp->sq.head != hr_qp->sq.tail)
+			return true;
+	}
+
+	list_for_each_entry(hr_qp, &hr_cq->rq_list, rq_node) {
+		if (hr_qp->rq.head != hr_qp->rq.tail)
+			return true;
+	}
+
+	return false;
+}
+
 static int hns_roce_v2_req_notify_cq(struct ib_cq *ibcq,
 				     enum ib_cq_notify_flags flags)
 {
@@ -3747,6 +3764,12 @@ static int hns_roce_v2_req_notify_cq(struct ib_cq *ibcq,
 	struct hns_roce_v2_db cq_db = {};
 	u32 notify_flag;
 
+	if (hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN) {
+		if ((flags & IB_CQ_REPORT_MISSED_EVENTS) &&
+		    left_sw_wc(hr_dev, hr_cq))
+			return 1;
+		return 0;
+	}
 	/*
 	 * flags = 0, then notify_flag : next
 	 * flags = 1, then notify flag : solocited
-- 
2.33.0


