Return-Path: <linux-rdma+bounces-14744-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA31EC83250
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 03:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4717C34735D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 02:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471481E5207;
	Tue, 25 Nov 2025 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQVF5BER"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDB81DED63
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039301; cv=none; b=peQdqXNx4gCd2PT4mx/dYBL8KxFenXHCnF0Ne/3eyNW2/kPbWbSnOfaF/Rsp9VSsdM81ZsMb2ezLL9/kXwdA/s+SWqDUnCCGZnuOEqe4gBmHR8z3qDDRvscuwgbJ08GzmubyZSYMnPhDQUaGuwqMUMqeyKREWuSHsTD5JjoWr1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039301; c=relaxed/simple;
	bh=LpArdlsVbPvi/lSEOFmd4Dybw7cEUTmaLAqnDvChIqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPLgXyYi2WgZT1fVmCrTtOlMrPR3mYVUgUMfFZxq0BceU4L2cOohNEmwRISwgg8xQIdFSfEROyAyI3g46Jy2fq++sjImR1HZzh0Of4smavJIfJ3rRrx43nAGL0U8XBnawSZ4tf6zw9aW44LE/mNo79aYk5ruSRha11wHm6BbK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQVF5BER; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764039299; x=1795575299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LpArdlsVbPvi/lSEOFmd4Dybw7cEUTmaLAqnDvChIqI=;
  b=MQVF5BERIrTGA6yEHuOHIHXu4eMPezHtHCfXK7Rizmgf49iv56JR/Q3/
   7hL+LN91s07/FWKLQqoZjRwQuXaGlVpnQcgMF1kzhajRptrMQ067F4xsX
   Z5OPh5vRtcMDbbjtvnwqYfF4Z4iGVGz9tVhOaVAjnvfLlTdOoVir0GEqy
   ztnDJKwj69DFM/WbJrZl6PFYjl0PSaYdOivGXk631eQ8eB97kPdbomdSp
   AeLW0ccKsaeScWYiPTi5OVqF00Q8S8FRzHr7fzC0Z25t1tR10fDDn30TN
   KOILHXgyD+n5DoBjqaHVqe4HOAk2oBoZVXhWcECqcPO8XGk+RnbfP12Mq
   Q==;
X-CSE-ConnectionGUID: 1cACQoSMRRCg3Z9mzSLC2Q==
X-CSE-MsgGUID: a1mK+lwISHmdXXB9DaUx9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65942203"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="65942203"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:58 -0800
X-CSE-ConnectionGUID: ogirlUiRSrWTQSkq0Ak8Cg==
X-CSE-MsgGUID: nUgPoRXaQ1CH4jCo1Go86g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="196800291"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:58 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	jmoroni@google.com
Subject: [PATCH 4/9] RDMA/irdma: Fix SIGBUS in AEQ destroy
Date: Mon, 24 Nov 2025 20:53:45 -0600
Message-ID: <20251125025350.180-5-tatyana.e.nikolova@intel.com>
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

Removes write to IRDMA_PFINT_AEQCTL register prior to destroying AEQ,
as this register does not exist in GEN3+ hardware and this kind of IRQ
configuration is no longer required.

Fixes: b800e82feba7 ("RDMA/irdma: Add GEN3 support for AEQ and CEQ")
Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index c17b1c14dfe2..ce5cf89c463c 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -4635,7 +4635,8 @@ static int irdma_sc_aeq_destroy(struct irdma_sc_aeq *aeq, u64 scratch,
 	u64 hdr;
 
 	dev = aeq->dev;
-	if (dev->privileged)
+
+	if (dev->hw_attrs.uk_attrs.hw_rev <= IRDMA_GEN_2)
 		writel(0, dev->hw_regs[IRDMA_PFINT_AEQCTL]);
 
 	cqp = dev->cqp;
-- 
2.31.1


