Return-Path: <linux-rdma+bounces-14558-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A658FC66347
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7BE735B1DD
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA4434D39C;
	Mon, 17 Nov 2025 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ci9BzHVF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8A34CFC4
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413693; cv=none; b=YfL5ohqOeHT2LG8z+t44J5x0O63ZggL1pu1X1rnDPXJKdB14P/rV3JcpEJBWyyFXVJvju5IdA/GwF4akKG3jlrIrHzTnMj/uCCj87wj1Ey+GQuLQaOanDFgDSIljJ0Id7yWgsvWBNRne6V5LahYIB808pVe7NIAkOMnJ80zbp6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413693; c=relaxed/simple;
	bh=iv9rlN/QpYFFHSEsNp01G1BtajXj7gbF2GpvbwKLFrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2wU07z1I1FeDBZ+b6+z5ybBR33wwy21TBY4ilcDdgdeV6gD7NzeGArR1tm7vKCLyFoSqs/dJJ9FWF6wKfn6q94Cye3sW0tz20LNTXSTtEezfWq5Lwjmfs+i54wnOi79GgXVD5ETVswjS0SsPswNE/TwA7+YVf+iwTlpH7X7uak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ci9BzHVF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763413692; x=1794949692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iv9rlN/QpYFFHSEsNp01G1BtajXj7gbF2GpvbwKLFrA=;
  b=Ci9BzHVFnGosl3WHjXF4MYgNI5iI72W+RcbdbVv2f/8eGCbyfpUKpd+0
   C1JHfDGwhlaGxPEjTDLQe9wgcmwMUHod/QOQRqxE/hx9xNe1HgbFc4TSt
   g1cmj/sRWVD2sAIiQ5LsLknQo0UMoIuwb8u3b3b9cuV86MVnuJ14m+KN5
   70MoHhGbksT3r+Cxf6QWYFPQ3CdFGZgyDFaWGo0hEkaScwCqajxQpoNdJ
   Up32vsYZYyPQfrIU9gxalSrwe+fpHNIQx6RGlP2lXck0HJVEETiLvmnuz
   or2rxTbjWp6fQsoKktNRTBoh2dRxmUjSaxR9wTawgcYslaVZ6yRRR/8W7
   A==;
X-CSE-ConnectionGUID: WqHDdRpES/iZgdUNTriUwA==
X-CSE-MsgGUID: wGLqZX/+TYyjlXUJy5pY5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="83051125"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="83051125"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:10 -0800
X-CSE-ConnectionGUID: boFbk8KwQL6MeIApvz/dlg==
X-CSE-MsgGUID: vcRvzEdIQISR4q0OQ056yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190583656"
Received: from soc-pf51ragt.clients.intel.com ([10.122.185.21])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:10 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [PATCH] RDMA/irdma: Fix SIGBUS in AEQ destroy
Date: Mon, 17 Nov 2025 15:07:52 -0600
Message-ID: <20251117210756.723-4-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251117210756.723-1-tatyana.e.nikolova@intel.com>
References: <20251117210756.723-1-tatyana.e.nikolova@intel.com>
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

Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index efe7882b0230..3a8f1a88f2a7 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -4624,7 +4624,8 @@ static int irdma_sc_aeq_destroy(struct irdma_sc_aeq *aeq, u64 scratch,
 	u64 hdr;
 
 	dev = aeq->dev;
-	if (dev->privileged)
+
+	if (dev->hw_attrs.uk_attrs.hw_rev <= IRDMA_GEN_2)
 		writel(0, dev->hw_regs[IRDMA_PFINT_AEQCTL]);
 
 	cqp = dev->cqp;
-- 
2.31.1


