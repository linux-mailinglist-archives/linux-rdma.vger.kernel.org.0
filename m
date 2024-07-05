Return-Path: <linux-rdma+bounces-3669-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191179284AB
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 11:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A34C1C24AAD
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8840C146D6B;
	Fri,  5 Jul 2024 09:05:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A4146D5A;
	Fri,  5 Jul 2024 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170327; cv=none; b=DXA60PdAvKyQFZuBPDBujgdBHE2GiTIOFJW3+0UJz53zc1+6PQFxL5Gs+a8FU7ecree9t4DEsQ1Q6HRm/6diujoSKV9URTm8RQAj3Ug1ZvUvqGMZIKGiMHXoOQ8xSesNtNVWmsdQWyrpYf8qVpwQsXwtQ1yJzMlYjIBTkcHx0KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170327; c=relaxed/simple;
	bh=ET6fbH7khney2LVeXs2CeEJBGBxJBPar5us8nTGHBH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZe5XoanwjzMA+EvM+UVy6MNq4OkbAoRUIkcANd54CrUFk1V24kAHi31KeKzRmGSbmjbbjIJoZt19BtgkbKlPTl01+gihAWxZEhay7+v9Vb05rtom0PZjXCagriiNkzwG/NSrWT/dNuzVwY5vSU+ZM5+3rE935JI3CTcwOmASU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WFnc45msXzdgRF;
	Fri,  5 Jul 2024 17:03:16 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id D1AC8180087;
	Fri,  5 Jul 2024 17:04:54 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jul 2024 17:04:54 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 8/9] RDMA/hns: Fix insufficient extend DB for VFs.
Date: Fri, 5 Jul 2024 16:59:36 +0800
Message-ID: <20240705085937.1644229-9-huangjunxian6@hisilicon.com>
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

From: Chengchang Tang <tangchengchang@huawei.com>

VFs and its PF will share the memory of the extend DB. Currently,
the number of extend DB allocated by driver is only enough for PF.
This leads to a probability of DB loss and some other problems in
scenarios where both PF and VFs use a large number of QPs.

Fixes: 6b63597d3540 ("RDMA/hns: Add TSQ link table support")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6cdeafef800a..1d72c8d47ae7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2468,14 +2468,16 @@ static int set_llm_cfg_to_hw(struct hns_roce_dev *hr_dev,
 static struct hns_roce_link_table *
 alloc_link_table_buf(struct hns_roce_dev *hr_dev)
 {
+	u16 total_sl = hr_dev->caps.sl_num * hr_dev->func_num;
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_link_table *link_tbl;
 	u32 pg_shift, size, min_size;
 
 	link_tbl = &priv->ext_llm;
 	pg_shift = hr_dev->caps.llm_buf_pg_sz + PAGE_SHIFT;
-	size = hr_dev->caps.num_qps * HNS_ROCE_V2_EXT_LLM_ENTRY_SZ;
-	min_size = HNS_ROCE_EXT_LLM_MIN_PAGES(hr_dev->caps.sl_num) << pg_shift;
+	size = hr_dev->caps.num_qps * hr_dev->func_num *
+	       HNS_ROCE_V2_EXT_LLM_ENTRY_SZ;
+	min_size = HNS_ROCE_EXT_LLM_MIN_PAGES(total_sl) << pg_shift;
 
 	/* Alloc data table */
 	size = max(size, min_size);
-- 
2.33.0


