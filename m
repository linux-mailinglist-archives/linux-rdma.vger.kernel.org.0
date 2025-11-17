Return-Path: <linux-rdma+bounces-14555-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F61C66344
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D02D5295AC
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C2334CFC6;
	Mon, 17 Nov 2025 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDNOKZau"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F348313260
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413691; cv=none; b=fHeW3rOS16kgC1Aosq4cb9oEwGKlP4WLDw6W41AXHXnaMalBG6QNfEZcR7U6/8lDYfk61Mtg5tv6/O0Xra7kAXSMSc+m0VBhQ4LFxZDd/UFDftaC9QQ7OLjeh7Kzx1QQTZhaaGFUtQyKsXBf2HoAfUPqofZ8dkYMl/QIDHj6OU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413691; c=relaxed/simple;
	bh=wedHMt13S9MQVO7b81b4KTF4dJC4nNza6bWfY5UeaPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HOm3IAW7XnRN3yJ5IB9zvWy3rNAOjHHcCu2xbFtybHMjZIo9mAaqYyuCQOwwmXGO46HfV6Wpvt5l0bvxeGyzRhN27Y1IG0SJEmV1sgzHQJVVDc3fVTNgXjpVhJzCPEDUXlC8H91FuMqbfn46SemcP7gjUjZ8EtVZMV3ekvXkB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDNOKZau; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763413690; x=1794949690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wedHMt13S9MQVO7b81b4KTF4dJC4nNza6bWfY5UeaPs=;
  b=DDNOKZaunBnbGV+7AyiW95c7xvQs//fMDm5fnwVyCwvnRtPzNgaauYCY
   CLLhRSZvevH9J9gnJJ3Clzw+7HU7mF09245CrZrDVP6Ja9R5BPm1E5OMa
   2RjfxGXVhXnw5wyiGMPYbN/JmUijf0hNfi71lVpn2pHrjK2ognZXp0XxJ
   b7+C/m1E1gUjrKdbRjoOg0Jeu5Y2oDUP3WSH8aVjB0m7VqhIKj2SILjJH
   djEFKC5gkfqx+BrbIsUKEI6DasOlWSklx3sgdt8otFRzeVVWAs+1IkjQp
   QCtOjW3MHkm/SxjGrp4WJLtS2vNDsKJBmzFvzqKziD1fwF8xMdt6BJxn2
   A==;
X-CSE-ConnectionGUID: YokINPwQS/CcPQw2i6CHZQ==
X-CSE-MsgGUID: S+rLPSHjRyOPjluTOlr2oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="83051115"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="83051115"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:09 -0800
X-CSE-ConnectionGUID: r+Oc9tGDSPaOFdYhAaJOFw==
X-CSE-MsgGUID: nJOv1P5ZTPKf8VPDuwBcpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190583646"
Received: from soc-pf51ragt.clients.intel.com ([10.122.185.21])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:08 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [PATCH] RDMA/irdma: Fix data race in irdma_sc_ccq_arm
Date: Mon, 17 Nov 2025 15:07:49 -0600
Message-ID: <20251117210756.723-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>

- Adds a lock around irdma_sc_ccq_arm body to prevent inter-thread
  data race.

- Fixes data race in irdma_sc_ccq_arm() reported by KCSAN:

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


