Return-Path: <linux-rdma+bounces-15290-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C1CF10A2
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 14:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C66F3001607
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288B30DED4;
	Sun,  4 Jan 2026 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfS7AG/J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB330DD25;
	Sun,  4 Jan 2026 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767534736; cv=none; b=FswRiCoEOATTTHPkDG33SiyY8LsDTZk8clPbdYVR/oz++JEaLKGCYZqHr4PI8sg7z2VI4unP9cs1p1sjo1515pq5V0EQjcGKiqqjsnC2CGM81X5CohWoeE5zkxnmdhBMsv1PTBYIcQ4hyixf2oR4kQz/cH9hL4lERL2eIyeDUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767534736; c=relaxed/simple;
	bh=clihBJLIvyZKpn1Xh11ErRq8CsnV0HHf40gSe8OjgzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDPUEgENiZR676SwpSOznfFQFJs5W5Duentvpyuj9JXF2NFiSWWQ8LDFcLsMzjg/4DGeKOjHCoNjlSr+ffEqPPlzD9v9DcQ5a6pB+i8KAhafwh4HlUrZJM30MjmjTTBy5G6Kdvn4r3pkKnZ8vUINi457pFWvmZzsjAosxBhMGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfS7AG/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CE6C4CEF7;
	Sun,  4 Jan 2026 13:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767534734;
	bh=clihBJLIvyZKpn1Xh11ErRq8CsnV0HHf40gSe8OjgzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kfS7AG/JaAUBkXLtXtm7stDt1Of+1OCfLxi13Naaa24qRnlkqOM7oLS4H5OOkACPI
	 zJ4f13yI6aLUUKew0HOhsQeQnM4w8D8w5AO9ki+w/OtzoY/2KXp1XQNGwI9PSLOkdW
	 /VIzfF0+4cJaK3lh6KhJTPWQcagTFky2tBtA5k12pMEWv3kAwatOPhqDsOS7BywFKo
	 v3t/W2XY9vpgUoAarA1hLoOyJDcfCYY6QrisZ+byXZmx0IijwKBGMduBXru3ydHfkn
	 A3dDFfxk2MOkJtvuyphVARCmivZhsC+g9s9W+KRAzvMDfqrrG3jMe161GedU21TBkt
	 Cxx8Mg441e45g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 5/6] RDMA/qedr: Remove unused defines
Date: Sun,  4 Jan 2026 15:51:37 +0200
Message-ID: <20260104-ib-core-misc-v1-5-00367f77f3a8@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
References: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Perform basic cleanup by removing unused defines from qedr.h.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/qedr/qedr.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
index db9ef3e1eb97..a6c9a4d9ab93 100644
--- a/drivers/infiniband/hw/qedr/qedr.h
+++ b/drivers/infiniband/hw/qedr/qedr.h
@@ -53,11 +53,8 @@
 		 DP_NAME(dev) ? DP_NAME(dev) : "", ## __VA_ARGS__)
 
 #define QEDR_MSG_INIT "INIT"
-#define QEDR_MSG_MISC "MISC"
 #define QEDR_MSG_CQ   "  CQ"
 #define QEDR_MSG_MR   "  MR"
-#define QEDR_MSG_RQ   "  RQ"
-#define QEDR_MSG_SQ   "  SQ"
 #define QEDR_MSG_QP   "  QP"
 #define QEDR_MSG_SRQ  " SRQ"
 #define QEDR_MSG_GSI  " GSI"
@@ -65,7 +62,6 @@
 
 #define QEDR_CQ_MAGIC_NUMBER	(0x11223344)
 
-#define FW_PAGE_SIZE		(RDMA_RING_PAGE_SIZE)
 #define FW_PAGE_SHIFT		(12)
 
 struct qedr_dev;
@@ -178,24 +174,18 @@ struct qedr_dev {
 	u8 user_dpm_enabled;
 };
 
-#define QEDR_MAX_SQ_PBL			(0x8000)
 #define QEDR_MAX_SQ_PBL_ENTRIES		(0x10000 / sizeof(void *))
 #define QEDR_SQE_ELEMENT_SIZE		(sizeof(struct rdma_sq_sge))
 #define QEDR_MAX_SQE_ELEMENTS_PER_SQE	(ROCE_REQ_MAX_SINGLE_SQ_WQE_SIZE / \
 					 QEDR_SQE_ELEMENT_SIZE)
-#define QEDR_MAX_SQE_ELEMENTS_PER_PAGE	((RDMA_RING_PAGE_SIZE) / \
-					 QEDR_SQE_ELEMENT_SIZE)
 #define QEDR_MAX_SQE			((QEDR_MAX_SQ_PBL_ENTRIES) *\
 					 (RDMA_RING_PAGE_SIZE) / \
 					 (QEDR_SQE_ELEMENT_SIZE) /\
 					 (QEDR_MAX_SQE_ELEMENTS_PER_SQE))
 /* RQ */
-#define QEDR_MAX_RQ_PBL			(0x2000)
 #define QEDR_MAX_RQ_PBL_ENTRIES		(0x10000 / sizeof(void *))
 #define QEDR_RQE_ELEMENT_SIZE		(sizeof(struct rdma_rq_sge))
 #define QEDR_MAX_RQE_ELEMENTS_PER_RQE	(RDMA_MAX_SGE_PER_RQ_WQE)
-#define QEDR_MAX_RQE_ELEMENTS_PER_PAGE	((RDMA_RING_PAGE_SIZE) / \
-					 QEDR_RQE_ELEMENT_SIZE)
 #define QEDR_MAX_RQE			((QEDR_MAX_RQ_PBL_ENTRIES) *\
 					 (RDMA_RING_PAGE_SIZE) / \
 					 (QEDR_RQE_ELEMENT_SIZE) /\
@@ -210,12 +200,8 @@ struct qedr_dev {
 
 #define QEDR_ROCE_MAX_CNQ_SIZE		(0x4000)
 
-#define QEDR_MAX_PORT			(1)
 #define QEDR_PORT			(1)
 
-#define QEDR_UVERBS(CMD_NAME) (1ull << IB_USER_VERBS_CMD_##CMD_NAME)
-
-#define QEDR_ROCE_PKEY_MAX 1
 #define QEDR_ROCE_PKEY_TABLE_LEN 1
 #define QEDR_ROCE_PKEY_DEFAULT 0xffff
 
@@ -336,12 +322,6 @@ struct qedr_qp_hwq_info {
 	union db_prod32 iwarp_db2_data;
 };
 
-#define QEDR_INC_SW_IDX(p_info, index)					\
-	do {								\
-		p_info->index = (p_info->index + 1) &			\
-				qed_chain_get_capacity(p_info->pbl)	\
-	} while (0)
-
 struct qedr_srq_hwq_info {
 	u32 max_sges;
 	u32 max_wr;

-- 
2.52.0


