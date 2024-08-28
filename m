Return-Path: <linux-rdma+bounces-4609-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1C99622FC
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 11:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768EB280402
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 09:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE0415D5AB;
	Wed, 28 Aug 2024 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IcNLy/JI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2315A849
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836089; cv=none; b=tMHK8neVGYPqSJLM31JQqqsAx8pO+89CMbPZJtIpqLFdcvNt4BKBXXSw8tuGU2p+/stjOZjcUmEKLLBVVrGVQ8nBfiGvbVA305GKS60zajjqPcUreAKGr4vTKFu7915fGpOGbwWaFTu/tfjFxHWVsccSH4cHCeZfpDUn9YlhXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836089; c=relaxed/simple;
	bh=L221gx8TMVtgUhpzyJXv+niB3Ixc62z7WLWBuVAmB1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X5ZueKu+Qohjv74u4qTxRlWuJEQbOP1K/UCLJO+iw2vDYDS2MAUlRr5AAmr7QDisk2gYGsPv0JXFuOwPMcr+fDNlAMfNZXJK5hiv9QZO3xfbp92n86YDO3XgNybgCdxsR2QpBmn+FAtorQYV/x7aOJb/Q1knZbFqML1ZbLBPb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IcNLy/JI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201e64607a5so46399695ad.2
        for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 02:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724836087; x=1725440887; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66WM3UKiAkh51wtV1SpgB1n6RvJTxOU2qjO0gblS3oo=;
        b=IcNLy/JIaZ19JHX8NFI79RWE2Ury0VmysoNOqH+fA6EfqoPHVJzJzWwE0JWE4xBCEu
         cVfh58s7cLI00uPbgNihx10vAXwD10FG3jhUxF5yx5EikE0GQZoWtrIEELhHSgRLGbZT
         ecQO2hgyBcKZ79LSyl5/n6GNuuAVm9BWLMxks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724836087; x=1725440887;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66WM3UKiAkh51wtV1SpgB1n6RvJTxOU2qjO0gblS3oo=;
        b=mr6U1KIxAogu5idjBaLAIE7GIaCFCKpjwOWOal17haD4uIN7sny80hulADn+aFvPNi
         YOiNFf7TrTRJpkBeAqJ6yyvClH4odgwkXfo92VnQ/opoxktK6vijgQ1oILB20aipVqUG
         62B+TJS/+AsO2WFNiD1ceSkdQYw9V1VMCVGqwI2a0V44KwjDRrQLg1Gz957NL1tTONFo
         /ouD8iRKCIoClHNCMWtqEQdvR6IzwZASN3NUi3WcOSxZ8dcB5lhVUMBDGrXuXDJDdv6O
         gyB/+Pqpj4H1MwVZs8tSBPlpvi+uIwoMR7Mc8Dmu9FqE9V7pX3lUOZjX/e9mLQVrYpYn
         M4bw==
X-Gm-Message-State: AOJu0Yyu7HzdBkzEaUCmoKVeEH4/w63wwjNKUqS6rCRtSUokUq9dsSt8
	nX7wVD3E5FRdSptAmUN7GThAeb4k7MSKnsKzvI37UGZbYT5J6OxU4w6zUqXm/SwsXq6DumwneWI
	=
X-Google-Smtp-Source: AGHT+IFzqO7LK6pYcLctX/3uO4i76V9uNkV+F+lP+OSAEKGRvnbermMHYO1eiYLTVpiiddNOsOMssw==
X-Received: by 2002:a17:902:ce92:b0:202:359:9f66 with SMTP id d9443c01a7336-2039e4fbbc8mr230095795ad.54.1724836087165;
        Wed, 28 Aug 2024 02:08:07 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609dddsm94735955ad.196.2024.08.28.02.08.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 02:08:06 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	chandramohan.akula@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/3] RDMA/bnxt_re: Refactor the BNXT_RE_METHOD_GET_TOGGLE_MEM method
Date: Wed, 28 Aug 2024 01:47:11 -0700
Message-Id: <1724834832-10600-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1724834832-10600-1-git-send-email-selvin.xavier@broadcom.com>
References: <1724834832-10600-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Refactor the code in this function to have common code.
This is used in subsequent patches.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 43a68e7..1e76093 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4494,12 +4494,12 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 	struct bnxt_re_ucontext *uctx;
 	struct ib_ucontext *ib_uctx;
 	struct bnxt_re_dev *rdev;
+	u32 length = PAGE_SIZE;
 	struct bnxt_re_cq *cq;
 	u64 mem_offset;
+	u32 offset = 0;
 	u64 addr = 0;
-	u32 length;
-	u32 offset;
-	u32 cq_id;
+	u32 res_id;
 	int err;
 
 	ib_uctx = ib_uverbs_get_ucontext(attrs);
@@ -4512,21 +4512,17 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 
 	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
 	rdev = uctx->rdev;
+	err = uverbs_copy_from(&res_id, attrs, BNXT_RE_TOGGLE_MEM_RES_ID);
+	if (err)
+		return err;
 
 	switch (res_type) {
 	case BNXT_RE_CQ_TOGGLE_MEM:
-		err = uverbs_copy_from(&cq_id, attrs, BNXT_RE_TOGGLE_MEM_RES_ID);
-		if (err)
-			return err;
-
-		cq = bnxt_re_search_for_cq(rdev, cq_id);
+		cq = bnxt_re_search_for_cq(rdev, res_id);
 		if (!cq)
 			return -EINVAL;
 
-		length = PAGE_SIZE;
 		addr = (u64)cq->uctx_cq_page;
-		mmap_flag = BNXT_RE_MMAP_TOGGLE_PAGE;
-		offset = 0;
 		break;
 	case BNXT_RE_SRQ_TOGGLE_MEM:
 		break;
-- 
2.5.5


