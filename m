Return-Path: <linux-rdma+bounces-4830-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687BB97194A
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 14:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C7B282087
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3211B81B5;
	Mon,  9 Sep 2024 12:27:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C661B81A9
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884878; cv=none; b=EfuCgh9JGhoIT8bE3BSEFZUR3Fjfeh2geIZv5O8PEo2dGh/A4HhXRCsKQ3df0PtAfm/RwRnSHXGDeSri3XeU4hTyE5gtj443QlELJ1oJvQUK/qLKbTW9LBhUkAgiGJmZMBeX27SURmAGeppSaf5pDSjOMOC8XBP9x3U5oHN2Yuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884878; c=relaxed/simple;
	bh=U67fD7oqSboq/ThAsyG98N+RlqW1dWPNox+ugjIzqEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/N3znd0IrHPj089rv0fPsPsZUOhXnky37cwv32qyYlVrdPskBN6a1TBOh7rpFB3K2Wsv4frWeuiIHvCqEUcyNKv9vmaZIodo0YQk+BHL/zMAGcj4W/AF0ysYzyDgkT5j3KaQNTpPl4J/ejCw6a+xeV+qNrYNYqE1t7Ic20h++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X2R1d45M3z20nkY;
	Mon,  9 Sep 2024 20:27:49 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 699851A016C;
	Mon,  9 Sep 2024 20:27:53 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 20:27:52 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <sagi@grimberg.me>, <mgurtovoy@nvidia.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<dennis.dalessandro@cornelisnetworks.com>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH v2 1/2] IB/iser: Remove unused declaration in header file
Date: Mon, 9 Sep 2024 20:14:07 +0800
Message-ID: <20240909121408.80079-2-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240909121408.80079-1-zhangzekun11@huawei.com>
References: <20240909121408.80079-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)

The definition of iser_finalize_rdma_unaligned_sg() has been removed
since commit dd0107a08996 ("IB/iser: set block queue_virt_boundary").
Let's remove the unused declaration in header file.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
v2: Fix the spelling error in patch subject

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


