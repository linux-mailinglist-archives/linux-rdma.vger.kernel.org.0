Return-Path: <linux-rdma+bounces-14268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E92CC3703F
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 18:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D990B625FA4
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC7A2D372A;
	Wed,  5 Nov 2025 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkwdLKtc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE22F363B
	for <linux-rdma@vger.kernel.org>; Wed,  5 Nov 2025 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360131; cv=none; b=Cp8K3D2IwQEqWFiYu1bgVgWSL8WxTSlrngUlolYUhDlBvFnRiaKIhIPm8Rsuy0A2ZitD4FvUbwhf/6K5eWZAHZGedwrl01EJdAwPYut0wHJ2IafCHz9qzXcn+eKbyvraXbcVdTaqBPthoCVdhFJJr0sDpJqNimCbtx00JBFfQ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360131; c=relaxed/simple;
	bh=WQfqRVfgmWc+p8PPo9xv1iASkNc9dNEVmAinjRg9Tos=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LiRIQik3nqKwJr/MmZOCEam16N7P7aq6pRaAI4gmjOdhbCBz16+DiRycznBGCyHq6guoqt5rHGS3iJba681tQo8NNqhXHrTROPOxzBn84OjUuvs6hPEDyjUWUUnuxscPU3BxGogIR3XIrYseInlr+TYHqW7eQKCbT+SGEHZzelE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkwdLKtc; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8a6fc271d46so1872190285a.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Nov 2025 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762360129; x=1762964929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P5HCVBcnDjS5M9edL1K0Rz/GhfyfILdAzkDYMg+1V6Y=;
        b=vkwdLKtcbioK2fp1DwOCMC5HlUz2gO8WOyXm21kMjSbsnDZQQl2UOBX5BwHqNazibC
         LutwUZ9zwXmJhoEXOBmHSg5HXh/HF9U5K76s69QgmDX6t5cs8h/vQJUcI7qqAIqNUcge
         rf8voNxdzoPMDmXnlmed2+BT5hUl+3QVAce7PW6JO83mpOYMJe1/EpzMB2s7xsiSNIDc
         Euieq7PHKVVOJAbpoRJaZFn9k7HOVwvlhz0BYgkzhyKkC0NFyz++0Z/6T0tIeF4a4Zvx
         CEdTpWzHUdQdK2WLuOcOL/JWLhNihGeZ/TjHEo881LZmdd8/oM+ztNMM+SI1gQetD5Ii
         XGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360129; x=1762964929;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5HCVBcnDjS5M9edL1K0Rz/GhfyfILdAzkDYMg+1V6Y=;
        b=htaoEue1vO9B2JqcMAmE+QJIZmd0iMG92ClFmeAB9cLVqARKJCF7clHAbtesBeHLN4
         14PSbH7rr/AnSQicXpVmw/aZ6WDDu8F7ujniejcJqkFGy82R9OK8KdpwIXrcrvC8CEKB
         KeFMldfJPiS1fOhWbhtc05y9fIWpJyJyCp7LqjD0DoL4a42i7Nm7uyEAswsHCnvwmr48
         bO3ugXP3qibp5I+ZBxAFGR663QQ+IkfTeWTuVRUMb6mttbeN5G8W1z9NFTGOyWqOK9Lu
         LJZ37Fi0s2OxHH+bFg+B7tUO17+z6n7qkaxSNK/wqKSx/KSt6BsK6yoKN5zXdUyYQyal
         C9FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHrevWHQ1BR6ROEJP/o0l8UTaeZZBsxah0ZSQMm5vnGNiViG416tsmQzI6GqxYMC+i2utbnHCnv8zW@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzbp6BupgRnkNnwHvhQIekZ+1c3DaTF+DLztGUyfyx+0rfD1V
	bxMOkbH6x6rUD7k+dscPIHRp538u7wKrlEvlxX2TXpgvCL2TshKtpB4AEnJ2ZjOhhaStaQexfdG
	QxyNyQpZGYQ==
X-Google-Smtp-Source: AGHT+IEsjxu/KvvX0SaH8YwM/ZIMyMuC8ZX4u6GgIXYesneQasqIubbB9a2IObEgq1BjNQo8J258rdpuYCrl
X-Received: from qknpq6.prod.google.com ([2002:a05:620a:84c6:b0:8ad:bacf:b219])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:45a7:b0:89f:679e:751a
 with SMTP id af79cd13be357-8b220af7212mr470457685a.84.1762360128889; Wed, 05
 Nov 2025 08:28:48 -0800 (PST)
Date: Wed,  5 Nov 2025 16:28:41 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <20251105162841.31786-1-jmoroni@google.com>
Subject: [PATCH rdma-next] RDMA/irdma: Remove unused CQ registry
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"

The CQ registry was never actually used (ceq->reg_cq was always NULL),
so remove the dead code.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/ctrl.c | 101 +----------------------------
 drivers/infiniband/hw/irdma/puda.c |  19 +-----
 drivers/infiniband/hw/irdma/type.h |   5 --
 3 files changed, 3 insertions(+), 122 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 4ef1c29032f7..57bf6815e71e 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -2943,8 +2943,6 @@ static int irdma_sc_cq_create(struct irdma_sc_cq *cq, u64 scratch,
 	__le64 *wqe;
 	struct irdma_sc_cqp *cqp;
 	u64 hdr;
-	struct irdma_sc_ceq *ceq;
-	int ret_code = 0;
 
 	cqp = cq->dev->cqp;
 	if (cq->cq_uk.cq_id >= cqp->dev->hmc_info->hmc_obj[IRDMA_HMC_IW_CQ].max_cnt)
@@ -2953,19 +2951,9 @@ static int irdma_sc_cq_create(struct irdma_sc_cq *cq, u64 scratch,
 	if (cq->ceq_id >= cq->dev->hmc_fpm_misc.max_ceqs)
 		return -EINVAL;
 
-	ceq = cq->dev->ceq[cq->ceq_id];
-	if (ceq && ceq->reg_cq)
-		ret_code = irdma_sc_add_cq_ctx(ceq, cq);
-
-	if (ret_code)
-		return ret_code;
-
 	wqe = irdma_sc_cqp_get_next_send_wqe(cqp, scratch);
-	if (!wqe) {
-		if (ceq && ceq->reg_cq)
-			irdma_sc_remove_cq_ctx(ceq, cq);
+	if (!wqe)
 		return -ENOMEM;
-	}
 
 	set_64bit_val(wqe, 0, cq->cq_uk.cq_size);
 	set_64bit_val(wqe, 8, (uintptr_t)cq >> 1);
@@ -3018,17 +3006,12 @@ int irdma_sc_cq_destroy(struct irdma_sc_cq *cq, u64 scratch, bool post_sq)
 	struct irdma_sc_cqp *cqp;
 	__le64 *wqe;
 	u64 hdr;
-	struct irdma_sc_ceq *ceq;
 
 	cqp = cq->dev->cqp;
 	wqe = irdma_sc_cqp_get_next_send_wqe(cqp, scratch);
 	if (!wqe)
 		return -ENOMEM;
 
-	ceq = cq->dev->ceq[cq->ceq_id];
-	if (ceq && ceq->reg_cq)
-		irdma_sc_remove_cq_ctx(ceq, cq);
-
 	set_64bit_val(wqe, 0, cq->cq_uk.cq_size);
 	set_64bit_val(wqe, 8, (uintptr_t)cq >> 1);
 	set_64bit_val(wqe, 40, cq->shadow_area_pa);
@@ -3601,71 +3584,6 @@ static int irdma_sc_parse_fpm_query_buf(struct irdma_sc_dev *dev, __le64 *buf,
 	return 0;
 }
 
-/**
- * irdma_sc_find_reg_cq - find cq ctx index
- * @ceq: ceq sc structure
- * @cq: cq sc structure
- */
-static u32 irdma_sc_find_reg_cq(struct irdma_sc_ceq *ceq,
-				struct irdma_sc_cq *cq)
-{
-	u32 i;
-
-	for (i = 0; i < ceq->reg_cq_size; i++) {
-		if (cq == ceq->reg_cq[i])
-			return i;
-	}
-
-	return IRDMA_INVALID_CQ_IDX;
-}
-
-/**
- * irdma_sc_add_cq_ctx - add cq ctx tracking for ceq
- * @ceq: ceq sc structure
- * @cq: cq sc structure
- */
-int irdma_sc_add_cq_ctx(struct irdma_sc_ceq *ceq, struct irdma_sc_cq *cq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ceq->req_cq_lock, flags);
-
-	if (ceq->reg_cq_size == ceq->elem_cnt) {
-		spin_unlock_irqrestore(&ceq->req_cq_lock, flags);
-		return -ENOMEM;
-	}
-
-	ceq->reg_cq[ceq->reg_cq_size++] = cq;
-
-	spin_unlock_irqrestore(&ceq->req_cq_lock, flags);
-
-	return 0;
-}
-
-/**
- * irdma_sc_remove_cq_ctx - remove cq ctx tracking for ceq
- * @ceq: ceq sc structure
- * @cq: cq sc structure
- */
-void irdma_sc_remove_cq_ctx(struct irdma_sc_ceq *ceq, struct irdma_sc_cq *cq)
-{
-	unsigned long flags;
-	u32 cq_ctx_idx;
-
-	spin_lock_irqsave(&ceq->req_cq_lock, flags);
-	cq_ctx_idx = irdma_sc_find_reg_cq(ceq, cq);
-	if (cq_ctx_idx == IRDMA_INVALID_CQ_IDX)
-		goto exit;
-
-	ceq->reg_cq_size--;
-	if (cq_ctx_idx != ceq->reg_cq_size)
-		ceq->reg_cq[cq_ctx_idx] = ceq->reg_cq[ceq->reg_cq_size];
-	ceq->reg_cq[ceq->reg_cq_size] = NULL;
-
-exit:
-	spin_unlock_irqrestore(&ceq->req_cq_lock, flags);
-}
-
 /**
  * irdma_sc_cqp_init - Initialize buffers for a control Queue Pair
  * @cqp: IWARP control queue pair pointer
@@ -4387,9 +4305,6 @@ int irdma_sc_ceq_init(struct irdma_sc_ceq *ceq,
 	ceq->ceq_elem_pa = info->ceqe_pa;
 	ceq->virtual_map = info->virtual_map;
 	ceq->itr_no_expire = info->itr_no_expire;
-	ceq->reg_cq = info->reg_cq;
-	ceq->reg_cq_size = 0;
-	spin_lock_init(&ceq->req_cq_lock);
 	ceq->pbl_chunk_size = (ceq->virtual_map ? info->pbl_chunk_size : 0);
 	ceq->first_pm_pbl_idx = (ceq->virtual_map ? info->first_pm_pbl_idx : 0);
 	ceq->pbl_list = (ceq->virtual_map ? info->pbl_list : NULL);
@@ -4472,9 +4387,6 @@ int irdma_sc_cceq_destroy_done(struct irdma_sc_ceq *ceq)
 {
 	struct irdma_sc_cqp *cqp;
 
-	if (ceq->reg_cq)
-		irdma_sc_remove_cq_ctx(ceq, ceq->dev->ccq);
-
 	cqp = ceq->dev->cqp;
 	cqp->process_cqp_sds = irdma_update_sds_noccq;
 
@@ -4493,11 +4405,6 @@ int irdma_sc_cceq_create(struct irdma_sc_ceq *ceq, u64 scratch)
 	struct irdma_sc_dev *dev = ceq->dev;
 
 	dev->ccq->vsi_idx = ceq->vsi_idx;
-	if (ceq->reg_cq) {
-		ret_code = irdma_sc_add_cq_ctx(ceq, ceq->dev->ccq);
-		if (ret_code)
-			return ret_code;
-	}
 
 	ret_code = irdma_sc_ceq_create(ceq, scratch, true);
 	if (!ret_code)
@@ -4562,7 +4469,6 @@ void *irdma_sc_process_ceq(struct irdma_sc_dev *dev, struct irdma_sc_ceq *ceq)
 	struct irdma_sc_cq *temp_cq;
 	u8 polarity;
 	u32 cq_idx;
-	unsigned long flags;
 
 	do {
 		cq_idx = 0;
@@ -4583,11 +4489,6 @@ void *irdma_sc_process_ceq(struct irdma_sc_dev *dev, struct irdma_sc_ceq *ceq)
 		}
 
 		cq = temp_cq;
-		if (ceq->reg_cq) {
-			spin_lock_irqsave(&ceq->req_cq_lock, flags);
-			cq_idx = irdma_sc_find_reg_cq(ceq, cq);
-			spin_unlock_irqrestore(&ceq->req_cq_lock, flags);
-		}
 
 		IRDMA_RING_MOVE_TAIL(ceq->ceq_ring);
 		if (!IRDMA_RING_CURRENT_TAIL(ceq->ceq_ring))
diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 694e5a9ed15d..3c29e2289322 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -726,7 +726,6 @@ static int irdma_puda_cq_wqe(struct irdma_sc_dev *dev, struct irdma_sc_cq *cq)
 	struct irdma_sc_cqp *cqp;
 	u64 hdr;
 	struct irdma_ccq_cqe_info compl_info;
-	int status = 0;
 
 	cqp = dev->cqp;
 	wqe = irdma_sc_cqp_get_next_send_wqe(cqp, 0);
@@ -756,16 +755,8 @@ static int irdma_puda_cq_wqe(struct irdma_sc_dev *dev, struct irdma_sc_cq *cq)
 	print_hex_dump_debug("PUDA: PUDA CREATE CQ", DUMP_PREFIX_OFFSET, 16,
 			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
 	irdma_sc_cqp_post_sq(dev->cqp);
-	status = irdma_sc_poll_for_cqp_op_done(dev->cqp, IRDMA_CQP_OP_CREATE_CQ,
-					       &compl_info);
-	if (!status) {
-		struct irdma_sc_ceq *ceq = dev->ceq[0];
-
-		if (ceq && ceq->reg_cq)
-			status = irdma_sc_add_cq_ctx(ceq, cq);
-	}
-
-	return status;
+	return irdma_sc_poll_for_cqp_op_done(dev->cqp, IRDMA_CQP_OP_CREATE_CQ,
+					     &compl_info);
 }
 
 /**
@@ -897,23 +888,17 @@ void irdma_puda_dele_rsrc(struct irdma_sc_vsi *vsi, enum puda_rsrc_type type,
 	struct irdma_puda_buf *buf = NULL;
 	struct irdma_puda_buf *nextbuf = NULL;
 	struct irdma_virt_mem *vmem;
-	struct irdma_sc_ceq *ceq;
 
-	ceq = vsi->dev->ceq[0];
 	switch (type) {
 	case IRDMA_PUDA_RSRC_TYPE_ILQ:
 		rsrc = vsi->ilq;
 		vmem = &vsi->ilq_mem;
 		vsi->ilq = NULL;
-		if (ceq && ceq->reg_cq)
-			irdma_sc_remove_cq_ctx(ceq, &rsrc->cq);
 		break;
 	case IRDMA_PUDA_RSRC_TYPE_IEQ:
 		rsrc = vsi->ieq;
 		vmem = &vsi->ieq_mem;
 		vsi->ieq = NULL;
-		if (ceq && ceq->reg_cq)
-			irdma_sc_remove_cq_ctx(ceq, &rsrc->cq);
 		break;
 	default:
 		ibdev_dbg(to_ibdev(dev), "PUDA: error resource type = 0x%x\n",
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index c1b8f81ea283..cab4896640a1 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -492,9 +492,6 @@ struct irdma_sc_ceq {
 	u32 first_pm_pbl_idx;
 	u8 polarity;
 	u16 vsi_idx;
-	struct irdma_sc_cq **reg_cq;
-	u32 reg_cq_size;
-	spinlock_t req_cq_lock; /* protect access to reg_cq array */
 	bool virtual_map:1;
 	bool tph_en:1;
 	bool itr_no_expire:1;
@@ -894,8 +891,6 @@ struct irdma_ceq_init_info {
 	u8 tph_val;
 	u16 vsi_idx;
 	u32 first_pm_pbl_idx;
-	struct irdma_sc_cq **reg_cq;
-	u32 reg_cq_idx;
 };
 
 struct irdma_aeq_init_info {
-- 
2.51.2.997.g839fc31de9-goog


