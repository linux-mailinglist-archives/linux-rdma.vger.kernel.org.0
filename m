Return-Path: <linux-rdma+bounces-11622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E59FAE7E6B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 12:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4755188CE30
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125682820D5;
	Wed, 25 Jun 2025 10:03:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DD729ACD3;
	Wed, 25 Jun 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845811; cv=none; b=bsyPxOlqXSRfHcMuy6WXchy60CdNvySOoh5e9f7SAfCRGeCsxkmpQNLt8F969g5OT3l0K0VdAXEB+ROwSyhiYLu32KeKWezmGTZ/zsuIGnfr7JqtgwqhNOKAbRBuqFB+cqsRFQpuMBeUGxzxRbXnCqlNJvIhC5QLLruMzjcP33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845811; c=relaxed/simple;
	bh=nfWwkftoY3bVlk7D0XPjKP4CoRfg54mIhI5hMgyfgRw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O3tCTP8gx2WO3tYdS/w/2PLagmMiktEQzAUSmF7HnjQxXH384AuXSzWo+4tJSmvcEyQGxEQSALHJPO/0Ris/i3DQ3D8aPmz2WZ/UoyFjbyCWg6sUeDypmPxxsL/mwuZK7clvcrs/+RC2mCJgrljGovZsYZRmiw7u0fDWrUE/g3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bRy5m5RQ7z2BdX1;
	Wed, 25 Jun 2025 18:01:48 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FCE5140279;
	Wed, 25 Jun 2025 18:03:25 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Jun
 2025 18:03:24 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net/mlx5e: Cleanup error handle in mlx5e_tc_sample_init()
Date: Wed, 25 Jun 2025 18:20:47 +0800
Message-ID: <20250625102047.483300-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

post_act is initialized in mlx5e_tc_post_act_init(), which never return
NULL. And if it is invalid, no need to alloc tc_psample mem.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc/sample.c   | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
index 5db239cae814..1b083afbe1bc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
@@ -619,26 +619,30 @@ mlx5e_tc_sample_init(struct mlx5_eswitch *esw, struct mlx5e_post_act *post_act)
 	struct mlx5e_tc_psample *tc_psample;
 	int err;
 
-	tc_psample = kzalloc(sizeof(*tc_psample), GFP_KERNEL);
-	if (!tc_psample)
-		return ERR_PTR(-ENOMEM);
-	if (IS_ERR_OR_NULL(post_act)) {
+	if (IS_ERR(post_act)) {
 		err = PTR_ERR(post_act);
 		goto err_post_act;
 	}
+
+	tc_psample = kzalloc(sizeof(*tc_psample), GFP_KERNEL);
+	if (!tc_psample) {
+		err = -ENOMEM;
+		goto err_post_act;
+	}
 	tc_psample->post_act = post_act;
 	tc_psample->esw = esw;
 	err = sampler_termtbl_create(tc_psample);
 	if (err)
-		goto err_post_act;
+		goto err_create;
 
 	mutex_init(&tc_psample->ht_lock);
 	mutex_init(&tc_psample->restore_lock);
 
 	return tc_psample;
 
-err_post_act:
+err_create:
 	kfree(tc_psample);
+err_post_act:
 	return ERR_PTR(err);
 }
 
-- 
2.34.1


