Return-Path: <linux-rdma+bounces-14743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89CBC8324D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 03:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BADA3AE1D0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 02:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF2D1E2614;
	Tue, 25 Nov 2025 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjiTxzFB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAEF1D9A5F
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039300; cv=none; b=nV3BD2FbV8B7dpfJgxWGFdWurbMAeU1uhG5zJ2ZsdQLyIs4FW3sb7V3+5lEm3GmxPKPy4g45cFWJwG4YPtSbt70ifeBj4k5KvlQju3euihgFgzWbsP9MKNplmGUcq9xNYjDfQxXi3Ln5DyBUIefDE7GhDsCOExpu/AOiVCgfmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039300; c=relaxed/simple;
	bh=RSStAWhQ+vifsUpAayzCYxnW3g7dpLugdR1p4N+epG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D751j2Zlnfv1AvPVMU7is+xSULkIaVxr6zAzdBLHtv8mILfpYN3IlFJBa4QCCv7aDYpzhDHPQHl4O9LcvrX38uVpkmfGZdtM4BPZolBfuJ3Yu+UwfwLx0rM3MhSqu9okT7jD5pKVKarfRwTiR4uF+H75GPLNkjB7XjVd40YcuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjiTxzFB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764039299; x=1795575299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RSStAWhQ+vifsUpAayzCYxnW3g7dpLugdR1p4N+epG8=;
  b=RjiTxzFBPV4+3czl9evdZ2Tc/o6U+PJvcwx+2PwbP+JOX/oGVDe1Z1o2
   IsFneuVz/KKnVzzQFQkfJrCwTeOEu3+rMQyxF/MqTymsOFZMP/TgiySv7
   ad1XbZQS42hSRFH1a7DfpNyzF3/bwwHu/CarRn6heOH+OqC0uJi7xCzKl
   jbtJXe+I9RgYRWoQTrBT+Iq91HMbS9771/0Yfw6ef+LEPNF7xS1hE2F86
   ae0Cn3HU3j18st0w4OQYE7ES9MskgsRTD6upvSyRnXv9ho+d08Cav5CSI
   5BeGT9VMWN+Y3R/izs3OmadLYhAECqZl91ILiupVi196uXMfLalDb5Cwy
   g==;
X-CSE-ConnectionGUID: GOzYhURSS/mYQXxv6YkDJA==
X-CSE-MsgGUID: sFZIN0rQSYiWeFhLelN0Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65942197"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="65942197"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:57 -0800
X-CSE-ConnectionGUID: cy1X+cQLRnKLUdBpni8tKg==
X-CSE-MsgGUID: jXp119YNTii0biGTDwEGsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="196800281"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:57 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	jmoroni@google.com
Subject: [PATCH 3/9] RDMA/irdma: Add a missing kfree of struct irdma_pci_f for GEN2
Date: Mon, 24 Nov 2025 20:53:44 -0600
Message-ID: <20251125025350.180-4-tatyana.e.nikolova@intel.com>
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

During a refactor of the irdma GEN2 code, the kfree of the irdma_pci_f struct
in icrdma_remove(), which was originally introduced upstream as part of
commit 80f2ab46c2ee ("irdma: free iwdev->rf after removing MSI-X")
was accidentally removed.

Fixes: 0c2b80cac96e ("RDMA/irdma: Refactor GEN2 auxiliary driver")
Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/icrdma_if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/icrdma_if.c b/drivers/infiniband/hw/irdma/icrdma_if.c
index 27b191f61caf..5d3fd118e4f8 100644
--- a/drivers/infiniband/hw/irdma/icrdma_if.c
+++ b/drivers/infiniband/hw/irdma/icrdma_if.c
@@ -320,6 +320,8 @@ static void icrdma_remove(struct auxiliary_device *aux_dev)
 	irdma_ib_unregister_device(iwdev);
 	icrdma_deinit_interrupts(iwdev->rf, cdev_info);
 
+	kfree(iwdev->rf);
+
 	pr_debug("INIT: Gen[%d] func[%d] device remove success\n",
 		 rdma_ver, PCI_FUNC(cdev_info->pdev->devfn));
 }
-- 
2.31.1


