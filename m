Return-Path: <linux-rdma+bounces-8788-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E53A6783B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 16:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EE51899526
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC420F089;
	Tue, 18 Mar 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eTf8n5fx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C7620E03F;
	Tue, 18 Mar 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312751; cv=none; b=V1sz6JroVVXlPzfpE9YQWzDJHU22RdvckI3fiJxySuFJmJFasZDABE3pAegl+raaEIq3X9zod9wuKePiqDPA0JaOuIprrnGDxoYisj7SD64A+B7ONpDVb0tWBjAAbvUgh4bN8RU6nI1YIB3n5yQuUjSeYEp4//cVx5W786viSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312751; c=relaxed/simple;
	bh=G3qzHwCmOV0YzzZzIXl/8sASrZePdPn9dzk2Af2K+Vc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s3HE8uzE8kP3JfjhYf+bWNrblIQQYwWeB0Gw9NDbWNRPXl5UtkKWmGEPQDdG0ex8wr271o5JZR0bPP+anAsFHe5hS3M/bLKsc9g/AmwLNQRk4D3fea0IZZiYV14QAeSOf2zthFS3KiNT3l85XyePd+iXqpuJ/Feof8qZ+tlMICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eTf8n5fx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id AAD562025361; Tue, 18 Mar 2025 08:45:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAD562025361
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742312744;
	bh=KV26GsMfB8TYD+o5OXfCnU8R78scm1WOKnt7Se6xZyo=;
	h=From:To:Cc:Subject:Date:From;
	b=eTf8n5fxajYkxoKk383UgNtfoNSymT/wzc7JVbjyBksj2i7suhxqIoTrz+dtBBaYN
	 ZzAhlTp1cs0LTgbYMEXCnRo74OH9n83QOjKRTALJKXtq1ezwaFveepO+1KRXNdsA/b
	 N4AVjrQSpu3EUEhFgL4sSXEflxz9ugqOU0whdXP0=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 1/1] RDMA/mana_ib: Fix integer overflow during queue creation
Date: Tue, 18 Mar 2025 08:45:44 -0700
Message-Id: <1742312744-14370-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Check queue size during CQ creation for users to prevent
overflow of u32.

Fixes: bec127e45d9f ("RDMA/mana_ib: create kernel-level CQs")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
v2: Only check the size of user CQs

 drivers/infiniband/hw/mana/cq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 5c325ef..0fc4e26 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -39,7 +39,8 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 		is_rnic_cq = !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
 
-		if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) {
+		if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
+		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
 			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
 			return -EINVAL;
 		}
-- 
2.43.0


