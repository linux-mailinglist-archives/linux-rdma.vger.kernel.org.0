Return-Path: <linux-rdma+bounces-6748-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A349FC9D1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 09:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021061883577
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB811CF5EC;
	Thu, 26 Dec 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FbESPMC1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9E161328
	for <linux-rdma@vger.kernel.org>; Thu, 26 Dec 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735202517; cv=none; b=nk3zqulWjZ3GpExpdllYVNvBvqxtlZbRYpMJd+cWrDwMFZLvy+EJwXsPMvgu9TJBR0Nom3Q3TZWJMqpeoX6sY8n7fdzDvyudeOirhCx2sTu5p08dcsXQZxmwjwko5Wrke3oa+FXZHQMdQQCoXfj9ln8gIvcyqNb6dXOjZDPBZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735202517; c=relaxed/simple;
	bh=Ezubpt231Btr+fecc9VWRwRHR2/CrIrjqWPqAwrXcwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJSNFrJ97NXzqbdgGOlCubURSEGaR7qDX8OSgDcrOPmf5f1vpb9VRxfviJ5slwHVNOuWPzSY38NqIs7GsqIG7asjPYouHTUIJs7Ien63ijccFzwZxpT0/QNlic+Fyf/n4065iGAkW1It9PRVR/oEr8YwmsLUs/gxWbIDlxDX8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FbESPMC1; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735202507; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KuG8dEuhZu9n5tOs74H0f6agC0wxmCSkVPCgY/rj5gA=;
	b=FbESPMC1lB9ph8S0KUngxme537IoES9TFbX0dLi01kXO9hU7uy8tUJWlFrdwGomZgT4a4cd939/HHsjs2nYPPBjQVOfZ44QhGKmEpuiBr3duqqsY0JcCjQ74HOwSEKrOgraHAOFkn5DyriF8l1mSPPfAwc9aQY+78TYgu9ag7U0=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WMHh289_1735202506 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Dec 2024 16:41:46 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next 4/4] RDMA/erdma: Support create_ah/destroy_ah in non-sleepable contexts
Date: Thu, 26 Dec 2024 16:41:11 +0800
Message-ID: <20241226084141.74823-5-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241226084141.74823-1-boshiyu@linux.alibaba.com>
References: <20241226084141.74823-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RDMA CM module might invoke erdma_create_ah() or erdma_destroy_ah()
in a non-sleepable context. Both of these functions will call the
erdma_post_cmd_wait(), which can potentially sleep and occasionally lead
to a hard lockup. Therefore, post the create_ah and destroy_ah commands in
polling mode if the RDMA_CREATE_AH_SLEEPABLE and RDMA_DESTROY_AH_SLEEPABLE
flags are not set, respectively.

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 73ec59dcf43e..3511189a4248 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -2223,7 +2223,7 @@ int erdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	erdma_set_av_cfg(&req.av_cfg, &ah->av);
 
 	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
-				  true);
+				  init_attr->flags & RDMA_CREATE_AH_SLEEPABLE);
 	if (ret) {
 		erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_AH], ah->ahn);
 		return ret;
@@ -2247,7 +2247,7 @@ int erdma_destroy_ah(struct ib_ah *ibah, u32 flags)
 	req.ahn = ah->ahn;
 
 	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL,
-				  true);
+				  flags & RDMA_DESTROY_AH_SLEEPABLE);
 	if (ret)
 		return ret;
 
-- 
2.46.0


