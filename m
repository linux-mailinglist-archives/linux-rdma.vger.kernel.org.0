Return-Path: <linux-rdma+bounces-4807-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C8D970109
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2024 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121881C21D10
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2024 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA414EC5D;
	Sat,  7 Sep 2024 08:52:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0142A96
	for <linux-rdma@vger.kernel.org>; Sat,  7 Sep 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725699134; cv=none; b=PoIusher4qFm4fAQTy4RDVkXBdOnqQJM2SLPC+A6P/y5ULr1vM1UiY+0ffPeMO0YnHU30Ah32rnyTVKAuocvDACm1ZcZ9KNKs4Dvj4bmms/dOvTAvxUshvkAPHIiuIirAHgHWVbivwPmOoCaEbarBSUG9ktg1h2bngss5f2Dvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725699134; c=relaxed/simple;
	bh=tv8JkkqEenfIpM9Qe1CCNMWLR78abuK5d+rpQPZ81o8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pw8ExZk7DkYJNUj5PPlCu7ksV83YZB4uP6ykSeirqu5/Yt3Trpe9p9SKJh329R3slv1kOSoDe3ToZhqz+wNqIiwPYQbHiEQta/7xlouKnSb4WD8mY+zHM5GzYmxD4FEoWuZJ6tJwfUUcUtccx5mZ/D7JoacbE1okDM70P+50f5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X16K73gxMz1j899;
	Sat,  7 Sep 2024 16:51:39 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 69F9B18001B;
	Sat,  7 Sep 2024 16:52:03 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 7 Sep
 2024 16:52:02 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <sagi@grimberg.me>, <mgurtovoy@nvidia.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<dennis.dalessandro@cornelisnetworks.com>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH 1/2] IB/iser: Remove unused declaration in heder file
Date: Sat, 7 Sep 2024 16:38:21 +0800
Message-ID: <20240907083822.100942-2-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907083822.100942-1-zhangzekun11@huawei.com>
References: <20240907083822.100942-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)

The definition of iser_finalize_rdma_unaligned_sg() has been removed
since commit dd0107a08996 ("IB/iser: set block queue_virt_boundary").
Let's remove the unused declaration in header file.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 68429a5f796d..1d7ac24c4c00 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -507,10 +507,6 @@ void iser_task_rdma_finalize(struct iscsi_iser_task *task);
 
 void iser_free_rx_descriptors(struct iser_conn *iser_conn);
 
-void iser_finalize_rdma_unaligned_sg(struct iscsi_iser_task *iser_task,
-				     struct iser_data_buf *mem,
-				     enum iser_data_dir cmd_dir);
-
 int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
 			 enum iser_data_dir dir,
 			 bool all_imm);
-- 
2.17.1


