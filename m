Return-Path: <linux-rdma+bounces-845-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D8844D3D
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 00:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31601C221CF
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 23:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABA13A8C3;
	Wed, 31 Jan 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaBIjnBK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58A3CF43
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744585; cv=none; b=Y9noTjky8cWy57KkCTZC4s23dpCXw/CGG7uJis8ZZBmGb/GGL1tGzNvU2z7+iFW8XeGrsArnLw6FQc2FzfdocK6OF04oPOu8ZcHqWFS6Jg3D3WmB6N7MEwmrejOgrSngLN6OMLf9nR1r2ogcBACg0y67Xw3oV9C366zUoOzEC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744585; c=relaxed/simple;
	bh=3+KUkc5rCNvg5bEXqAAcAnceiheOCLVdL6vE8ILXUPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kITdz0AuNtNK9tdo5vP/00Io8ami+39SbXOSu1fd7BeS9cQPU4gB4WWS+dW6kgXM/vOUaa/jvD5wACTPSO6B5OHFzb/LEYEvDncpKUZWJ9RaIqtbn425CHEMmEPL3kqfVWS6MltUUY4Ppj1lLNRF0C4s4t9CdEGNM8yN8zKJwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TaBIjnBK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706744583; x=1738280583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3+KUkc5rCNvg5bEXqAAcAnceiheOCLVdL6vE8ILXUPE=;
  b=TaBIjnBKZDneTtmGHhKgvSNpckqvw8I4mf6NvwumAcu8ltpZsfpyZ4BA
   4aJ9i7nnQB4JX+u+XneSrA/lnBwnlXaM8Snla6X5LX421r7zSjMg5tgaV
   jVxp5M6EfpZoSxnXTRp5ZfaY/SB0BPbEz7UySPlRnb+WBdmUf/6XP4YiF
   sv26gYGZ4phzrK3Du6zQqtluehNh/Y8fH0mn4DagnKgsBFKI7bEY50Rff
   yVA4E161yC9fQFUNWDgyKY8b1qMnVbiJhjYYPJEt8zkDOcEnnRsRVLv2J
   9kdtwWoonQhMa3z42I//7tk+Vq3SViHiPgbS6zxUg14OifQJTrVL2B0M6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22260032"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="22260032"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:43:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4338980"
Received: from unknown (HELO SD8036..) ([10.232.218.36])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:43:02 -0800
From: Sindhu Devale <sindhu.devale@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	sindhu.devale@intel.com,
	Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: [PATCH rdma-rc 1/4] RDMA/irdma: Fix KASAN issue with tasklet
Date: Wed, 31 Jan 2024 17:38:46 -0600
Message-ID: <20240131233849.400285-2-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240131233849.400285-1-sindhu.devale@intel.com>
References: <20240131233849.400285-1-sindhu.devale@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

KASAN testing revealed the following issue assocated with freeing an IRQ.

[50006.466686] Call Trace:
[50006.466691]  <IRQ>
[50006.489538]  dump_stack+0x5c/0x80
[50006.493475]  print_address_description.constprop.6+0x1a/0x150
[50006.499872]  ? irdma_sc_process_ceq+0x483/0x790 [irdma]
[50006.505742]  ? irdma_sc_process_ceq+0x483/0x790 [irdma]
[50006.511644]  kasan_report.cold.11+0x7f/0x118
[50006.516572]  ? irdma_sc_process_ceq+0x483/0x790 [irdma]
[50006.522473]  irdma_sc_process_ceq+0x483/0x790 [irdma]
[50006.528232]  irdma_process_ceq+0xb2/0x400 [irdma]
[50006.533601]  ? irdma_hw_flush_wqes_callback+0x370/0x370 [irdma]
[50006.540298]  irdma_ceq_dpc+0x44/0x100 [irdma]
[50006.545306]  tasklet_action_common.isra.14+0x148/0x2c0
[50006.551096]  __do_softirq+0x1d0/0xaf8
[50006.555396]  irq_exit_rcu+0x219/0x260
[50006.559670]  irq_exit+0xa/0x20
[50006.563320]  smp_apic_timer_interrupt+0x1bf/0x690
[50006.568645]  apic_timer_interrupt+0xf/0x20
[50006.573341]  </IRQ>

The issue is that a tasklet could be pending on another core racing
the delete of the irq.

Fix by insuring any scheduled tasklet is killed after deleting the
irq.

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index bd4b2b896444..2f8d18d8be3b 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -570,6 +570,13 @@ static void irdma_destroy_irq(struct irdma_pci_f *rf,
 	dev->irq_ops->irdma_dis_irq(dev, msix_vec->idx);
 	irq_update_affinity_hint(msix_vec->irq, NULL);
 	free_irq(msix_vec->irq, dev_id);
+	if (rf == dev_id) {
+		tasklet_kill(&rf->dpc_tasklet);
+	} else {
+		struct irdma_ceq *iwceq = (struct irdma_ceq *)dev_id;
+
+		tasklet_kill(&iwceq->dpc_tasklet);
+	}
 }
 
 /**
-- 
2.42.0


