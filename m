Return-Path: <linux-rdma+bounces-14158-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A593DC22F81
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 03:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01DF24ECE44
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 02:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF60277CB0;
	Fri, 31 Oct 2025 02:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPwS2ejX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793332773D2
	for <linux-rdma@vger.kernel.org>; Fri, 31 Oct 2025 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877092; cv=none; b=gGDg5tivB/6W4WkZ2HIR9trdbroQMd7tGk0L9OYdYQKbWA+K8pOzxEi2m+RIETUHqj8yZbG5LM2VhR2lBOwUlnNrHv8AOmHrI7S+oh8KJstWR7eUx0zw3lFOxaqITeHxrQ4jO1NJKrVxR4S9qcmdJPHJ4kxCUNO007/i1485D9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877092; c=relaxed/simple;
	bh=QA1iUIu8e1U+8cRaewz1AhrO1eD4giTr691jfynlwy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWZjtXp97qcRnidQ9hI2qfvAjobd+lUfprj9oIh2ROQa6chvtmEaq0epmzkdNbCxa2FWo5SUevt4LL6FpZ1/EA8HuMREpfRy+Jkejk65xraEunsYlOcVR5TT3povbgMpgrYVFAs8nj58rTJeVgFaryQYqUbZUd3vsRkkFRo8VlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPwS2ejX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761877091; x=1793413091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QA1iUIu8e1U+8cRaewz1AhrO1eD4giTr691jfynlwy4=;
  b=UPwS2ejXVRat2+hNYc14jz7oTelCnZ9EOcyusxkaXAFSW+K0kmF9e8c/
   AbXn/Cngu3waKBuw1aHOqI6glQrB9y812X2nGWMiHMEUTfr3/dafhsAQi
   LZabSl2oViqxHIN64nmGpHQGeK2S8YY1qV31hteSjzUMiXrX5JXfgkEFZ
   C2QXHdrqLU1cYjLxwOg2vo+K32e6tUxyQlfy1MCTCPBKm8ggOlnAKIkWN
   ZQWSPX5hxw/9U49c7EeX7A0tkg4P0VnboJWCtTd+2uLGpcSj6pYt5cQ0B
   gnYPzPpGFX7ccXt/MnUHyfMCqCvU4UarbzssZMXVzWFU7x/9/Z8gN4Er6
   w==;
X-CSE-ConnectionGUID: C0Z6x5y5TdGiE6bFzcC3PQ==
X-CSE-MsgGUID: YUiHEX2NQ0CJErxDZgAoeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64182221"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64182221"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:08 -0700
X-CSE-ConnectionGUID: 7KXwrDEZSx6rw1R6ohHIlQ==
X-CSE-MsgGUID: 3PNKhLVDTc6EUA9+y/0sEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="216950190"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:07 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	krzysztof.czurylo@intel.com,
	Jay Bhat <jay.bhat@intel.com>,
	Jacob Moroni <jmoroni@google.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH] RDMA/irdma: Take a lock before moving SRQ tail in poll_cq
Date: Thu, 30 Oct 2025 21:17:26 -0500
Message-ID: <20251031021726.1003-7-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251031021726.1003-1-tatyana.e.nikolova@intel.com>
References: <20251031021726.1003-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jay Bhat <jay.bhat@intel.com>

Need to take an SRQ lock in poll_cq before moving SRQ tail.

Signed-off-by: Jay Bhat <jay.bhat@intel.com>
Reviewed-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/uk.c    | 5 +++++
 drivers/infiniband/hw/irdma/user.h  | 1 +
 drivers/infiniband/hw/irdma/verbs.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index a006e7365f4d..8a463b3d4c83 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1309,6 +1309,8 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 	info->op_type = (u8)FIELD_GET(IRDMACQ_OP, qword3);
 
 	if (info->q_type == IRDMA_CQE_QTYPE_RQ && is_srq) {
+		unsigned long flags;
+
 		srq = qp->srq_uk;
 
 		get_64bit_val(cqe, 8, &info->wr_id);
@@ -1321,8 +1323,11 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 		} else {
 			info->stag_invalid_set = false;
 		}
+		spin_lock_irqsave(srq->lock, flags);
 		IRDMA_RING_MOVE_TAIL(srq->srq_ring);
+		spin_unlock_irqrestore(srq->lock, flags);
 		pring = &srq->srq_ring;
+
 	} else if (info->q_type == IRDMA_CQE_QTYPE_RQ && !is_srq) {
 		u32 array_idx;
 
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 6c29fa04e821..3a27cce3c3db 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -466,6 +466,7 @@ struct irdma_srq_uk {
 	u8 wqe_size;
 	u8 wqe_size_multiplier;
 	u8 deferred_flag;
+	spinlock_t *lock;
 };
 
 struct irdma_srq_uk_init_info {
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f49b3f38726a..98946dd2c544 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2389,6 +2389,7 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
 	info.vsi = &iwdev->vsi;
 	info.pd = &iwpd->sc_pd;
 
+	iwsrq->sc_srq.srq_uk.lock = &iwsrq->lock;
 	err_code = irdma_sc_srq_init(&iwsrq->sc_srq, &info);
 	if (err_code)
 		goto free_dmem;
-- 
2.31.1


