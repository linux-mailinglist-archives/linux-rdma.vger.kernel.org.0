Return-Path: <linux-rdma+bounces-14366-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0709C47F1A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 17:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E292A4F2FC2
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E39127B34F;
	Mon, 10 Nov 2025 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="G4emcSMz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094EA27CCF0;
	Mon, 10 Nov 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792004; cv=none; b=azw6JGnlIADf/Tx4fi9F35aJqI91dkv70RidnMRYyhHYX8SsL+LVAxALwxfMMcFf+CPWorfii+Q2tOWndNP5DT+2awi89igxwcua6cj8nwdf5++6V8WkJzmqeED+Hjkki5l9EluWZg4/G6HT3ReRFfvnkDNqxB2RnI+Ecubb2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792004; c=relaxed/simple;
	bh=l9tmfd0rp5qgb9QMApKAnen6MaSQx17eHVFH7HQ9NCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+OIXXB4pzvhUoJL3mP6a4avk2xP+PZj7cPTXez3A9/PWx3yugae7Ky1cnYJ7wT8eGDRnrWOrtxisa8NNcmBdMWCGqirLPf1vhjhqMtDImLu8+ackKGXyJDW1DQsNN/45Lyp1Vq+EeOTKHdYk3Ni0KEBUacT6eeIljzV5DQ9m0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=G4emcSMz; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2911376bb;
	Tue, 11 Nov 2025 00:26:31 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: mkalderon@marvell.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] qedr: Fix double free in qedr_alloc_pbl_tbl()
Date: Mon, 10 Nov 2025 16:26:27 +0000
Message-Id: <20251110162627.1191740-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a6e97264403a1kunm38b22ea2a8aeec
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGEIaVh9LQx4aGE5OQhoeSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=G4emcSMzFEsBlG1JW9hv7/gUDwrJTV1S10sFm80NsGonCem3fcBbBouLMCZ12ZpQn2ZVerR86z1cqhD6K6XxrcARiB7RgdZcyfZ8IkoFA3aaZCBmGsYJ3tsx3+AyeFxuKMu5MPGt9wTmiX9wUCTXVr+9F3yChmCPmnAdc2QvVXI=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=22qPbUecrqTAZyrcLvyRtF4f3JORTPdaXHFdwIit2A4=;
	h=date:mime-version:subject:message-id:from;

In the error path of qedr_alloc_pbl_tbl(), a loop calls
dma_free_coherent() to release previously allocated PBL pages.
However, after the loop, qedr_free_pbl() is called, which attempts
to free the same pages again, resulting in a double-free.

The qedr_free_pbl() function checks if the page pointer is NULL before
freeing. Fix this by setting pbl_table[i].va to NULL after it is freed
in the error-handling loop, thus preventing the subsequent double-free.

Fixes: a7efd7773e31b ("qedr: Add support for PD,PKEY and CQ verbs")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/infiniband/hw/qedr/verbs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index ab9bf0922979..2dd005a97688 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -561,9 +561,11 @@ static struct qedr_pbl *qedr_alloc_pbl_tbl(struct qedr_dev *dev,
 	return pbl_table;
 
 err:
-	for (i--; i >= 0; i--)
+	for (i--; i >= 0; i--) {
 		dma_free_coherent(&pdev->dev, pbl_info->pbl_size,
 				  pbl_table[i].va, pbl_table[i].pa);
+		pbl_table[i].va = NULL;
+	}
 
 	qedr_free_pbl(dev, pbl_info, pbl_table);
 
-- 
2.34.1


