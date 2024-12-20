Return-Path: <linux-rdma+bounces-6671-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA449F8C36
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 06:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E7D1896831
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 05:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0389417ADF8;
	Fri, 20 Dec 2024 05:59:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4B2594AC;
	Fri, 20 Dec 2024 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674383; cv=none; b=tQ2XxP42KVerAJDwhLt0ZycwSBpvslaQ1vaqqTrkLv5qtlTwq4pfqCZeBXzpqmr2LGjM/bc9raFxyY90C6p6qdKMEOHjnmQ8j2VpSPn25M/Zjs3TWo5JiJ8Sa21D6eYbRoHKTJ4IlHoOtZ9fPB9bd/4ZopPe5Ylfmpxym/lJzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674383; c=relaxed/simple;
	bh=K5MJ4OVe9rhdWruX8SJ1zXTjl2xJD5GnZhQHzd52ScE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2C/ocpo7wkxKQ3U2QHdmzOoFS3xOonuEeC4kjv1bJ31ZTXB7Xsv5srzAwH0Yr2qpT37xEIJ/jpfR9enZqXVY9tgaj6dnsAVV8SRUo+bkjALjFQJhXZNwY8NyAM8xbWEN7w8l2siYSwTYuPintE8rq+i8QFJhCyolPzm1htEVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YDxb14czkzjL4F;
	Fri, 20 Dec 2024 13:59:57 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id D82F3140202;
	Fri, 20 Dec 2024 13:59:38 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Dec 2024 13:59:38 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH for-rc 2/4] RDMA/hns: Fix accessing invalid dip_ctx during destroying QP
Date: Fri, 20 Dec 2024 13:52:47 +0800
Message-ID: <20241220055249.146943-3-huangjunxian6@hisilicon.com>
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

If it fails to modify QP to RTR, dip_ctx will not be attached. And
during detroying QP, the invalid dip_ctx pointer will be accessed.

Fixes: faa62440a577 ("RDMA/hns: Fix different dgids mapping to the same dip_idx")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 697b17cca02e..6dddadb90e02 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5619,6 +5619,9 @@ static void put_dip_ctx_idx(struct hns_roce_dev *hr_dev,
 {
 	struct hns_roce_dip *hr_dip = hr_qp->dip;
 
+	if (!hr_dip)
+		return;
+
 	xa_lock(&hr_dev->qp_table.dip_xa);
 
 	hr_dip->qp_cnt--;
-- 
2.33.0


