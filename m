Return-Path: <linux-rdma+bounces-14741-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF94EC83247
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 03:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D163AE1D0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 02:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17421DF246;
	Tue, 25 Nov 2025 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXBZtFLF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CD819FA93
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039299; cv=none; b=fUXV0Z/gZ4GQsFNG8cUiqLFQtPwdwKqeBVu8YnoQgrd/+JtcnO+IWDC99rbqnq7mvkiGJVJxL1NOQvZcgTTJXqd0Rs+kvD5XypMPgSjCnNHsb+YYeWfO9YlSNUYs6Rhs+s8zkm3jcXIE/cYUcqM9M943NiksXrzSY6f8ICe6FhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039299; c=relaxed/simple;
	bh=FOoKkEyzWprjzM/KYorX9Bwd6GJ/FQw9ocE2TV6Bam0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKibNU0fNijUJTlnftGJx4dH8rPWVbgUn1O+oPEPcLdwFYO1urx8MtGGOK8G+J0UGhlDhdnkojJL7RMS6IMe4yBwszzb//NNlH59hQDsNCp+aSePrulGg9hA+vqSM63Uu1YWadJMobRhvpcEgoTwLmfqV3eRtQ8GSSZOk+7yvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXBZtFLF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764039298; x=1795575298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FOoKkEyzWprjzM/KYorX9Bwd6GJ/FQw9ocE2TV6Bam0=;
  b=hXBZtFLFurib/cONgzeK3q3s6wuWAhQc8Ocbf3KNQXLAGKHXt94cShLr
   9xoNuQhfDckyDKQSAZOkWkLmD9gLJsqFfS6FqBJNTzKAfV6wUEw5prYRn
   Nz6zVC/4Si2xbzgUdUmNjxfGEjnPSfmfXdx9PBAJaEzUw+hfleGwVEQkV
   jt5RYltdK2gol45GSI7jgSDayinBLWYus7McZ3POrXDFTlYy55LrftgAx
   sKbmrdpXsvDb2kkxKS6ExTYcNIJn4Dj57Cnv8zWvh3NfBB05elhIUFBFU
   nlY9+EmJHAFGcK1uEIORWVtQZhSRxTFlmkwxFhCQ6rqkkXOadicpXBI6a
   A==;
X-CSE-ConnectionGUID: Aj6xuOY2SkOHqDWX3wa4PA==
X-CSE-MsgGUID: uFEvZKYLRtywMpq7fiDzFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65942183"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="65942183"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:56 -0800
X-CSE-ConnectionGUID: akTIL1GSQDassOJvbCEczw==
X-CSE-MsgGUID: q70hgXjVTCOSacfFaZiqIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="196800264"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:56 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	jmoroni@google.com
Subject: [PATCH 1/9] RDMA/irdma: Fix data race in irdma_sc_ccq_arm
Date: Mon, 24 Nov 2025 20:53:42 -0600
Message-ID: <20251125025350.180-2-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
References: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>

Adds a lock around irdma_sc_ccq_arm body to prevent inter-thread data race.
Fixes data race in irdma_sc_ccq_arm() reported by KCSAN:

BUG: KCSAN: data-race in irdma_sc_ccq_arm [irdma] / irdma_sc_ccq_arm [irdma]

read to 0xffff9d51b4034220 of 8 bytes by task 255 on cpu 11:
 irdma_sc_ccq_arm+0x36/0xd0 [irdma]
 irdma_cqp_ce_handler+0x300/0x310 [irdma]
 cqp_compl_worker+0x2a/0x40 [irdma]
 process_one_work+0x402/0x7e0
 worker_thread+0xb3/0x6d0
 kthread+0x178/0x1a0
 ret_from_fork+0x2c/0x50

write to 0xffff9d51b4034220 of 8 bytes by task 89 on cpu 3:
 irdma_sc_ccq_arm+0x7e/0xd0 [irdma]
 irdma_cqp_ce_handler+0x300/0x310 [irdma]
 irdma_wait_event+0xd4/0x3e0 [irdma]
 irdma_handle_cqp_op+0xa5/0x220 [irdma]
 irdma_hw_flush_wqes+0xb1/0x300 [irdma]
 irdma_flush_wqes+0x22e/0x3a0 [irdma]
 irdma_cm_disconn_true+0x4c7/0x5d0 [irdma]
 irdma_disconnect_worker+0x35/0x50 [irdma]
 process_one_work+0x402/0x7e0
 worker_thread+0xb3/0x6d0
 kthread+0x178/0x1a0
 ret_from_fork+0x2c/0x50

value changed: 0x0000000000024000 -> 0x0000000000034000

Fixes: 3f49d6842569 ("RDMA/irdma: Implement HW Admin Queue OPs")
Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 57bf6815e71e..c17b1c14dfe2 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -3868,11 +3868,13 @@ int irdma_sc_cqp_destroy(struct irdma_sc_cqp *cqp)
  */
 void irdma_sc_ccq_arm(struct irdma_sc_cq *ccq)
 {
+	unsigned long flags;
 	u64 temp_val;
 	u16 sw_cq_sel;
 	u8 arm_next_se;
 	u8 arm_seq_num;
 
+	spin_lock_irqsave(&ccq->dev->cqp_lock, flags);
 	get_64bit_val(ccq->cq_uk.shadow_area, 32, &temp_val);
 	sw_cq_sel = (u16)FIELD_GET(IRDMA_CQ_DBSA_SW_CQ_SELECT, temp_val);
 	arm_next_se = (u8)FIELD_GET(IRDMA_CQ_DBSA_ARM_NEXT_SE, temp_val);
@@ -3883,6 +3885,7 @@ void irdma_sc_ccq_arm(struct irdma_sc_cq *ccq)
 		   FIELD_PREP(IRDMA_CQ_DBSA_ARM_NEXT_SE, arm_next_se) |
 		   FIELD_PREP(IRDMA_CQ_DBSA_ARM_NEXT, 1);
 	set_64bit_val(ccq->cq_uk.shadow_area, 32, temp_val);
+	spin_unlock_irqrestore(&ccq->dev->cqp_lock, flags);
 
 	dma_wmb(); /* make sure shadow area is updated before arming */
 
-- 
2.31.1


