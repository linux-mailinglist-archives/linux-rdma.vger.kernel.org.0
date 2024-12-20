Return-Path: <linux-rdma+bounces-6672-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2909F8C38
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 07:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193181895E70
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 06:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9357918A6B8;
	Fri, 20 Dec 2024 05:59:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82327DA7F;
	Fri, 20 Dec 2024 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674384; cv=none; b=ra0yALPXckgDTrkXuHlpC8yLV2e9CokTllbvhV2D5lCnUCDGsihPCnRVQG+q8qAkdRjxWdtCoNghrTJpoZFfGk3HbZM3Z+5XynJQ1MDJfp29hDtcGVekugFSguFWYL2unRclOIO9DF//YT9UZlJgNh0v56YUMc7uMP6MGkrd1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674384; c=relaxed/simple;
	bh=5KxMCM9rLUqnNglOnpDGlmTe2qd7F+0OmQDKfa9LYnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNbY1Z1Up7ZXmQlzUya5vRXHXK7MyCQk8gtE+YqJsx5bOX8CEgmosroKlzFhsnA6fu3bLhHb20dEgRUXBYmcMn3qgZTLoipH5KL4QGroDFUgGNPBQSezD1JFCeoOwMmUOOE6zqpPQiebSg4phLTTtcv70kT4CkhE48YLkD8nuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YDxWd4k7Bz1T7Dd;
	Fri, 20 Dec 2024 13:57:01 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C6AC1A016C;
	Fri, 20 Dec 2024 13:59:39 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Dec 2024 13:59:38 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH for-rc 3/4] RDMA/hns: Fix warning storm caused by invalid input in IO path
Date: Fri, 20 Dec 2024 13:52:48 +0800
Message-ID: <20241220055249.146943-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241220055249.146943-1-huangjunxian6@hisilicon.com>
References: <20241220055249.146943-1-huangjunxian6@hisilicon.com>
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

WARN_ON() is called in the IO path. And it could lead to a warning
storm. Use WARN_ON_ONCE() instead of WARN_ON().

Fixes: 12542f1de179 ("RDMA/hns: Refactor process about opcode in post_send()")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6dddadb90e02..d0469d27c63c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -468,7 +468,7 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	valid_num_sge = calc_wr_sge_num(wr, &msg_len);
 
 	ret = set_ud_opcode(ud_sq_wqe, wr);
-	if (WARN_ON(ret))
+	if (WARN_ON_ONCE(ret))
 		return ret;
 
 	ud_sq_wqe->msg_len = cpu_to_le32(msg_len);
@@ -572,7 +572,7 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 	rc_sq_wqe->msg_len = cpu_to_le32(msg_len);
 
 	ret = set_rc_opcode(hr_dev, rc_sq_wqe, wr);
-	if (WARN_ON(ret))
+	if (WARN_ON_ONCE(ret))
 		return ret;
 
 	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_SO,
-- 
2.33.0


