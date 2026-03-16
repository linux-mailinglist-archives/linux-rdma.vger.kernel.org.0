Return-Path: <linux-rdma+bounces-18204-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDFZOy9PuGlHbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18204-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:42:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 889DC29F2B0
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7799C302B1B8
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365C03E3DB1;
	Mon, 16 Mar 2026 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ufcf3msb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC7D3E4C9D
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686476; cv=none; b=QGB+AP0d2arqXnzcumvLKLVrDcyOnbTmJrovsBDW+VZ/jqpmGfJREoKn7sM+Z3C1UzjWkaREhq/ayo2h2t1WJrijPuYj+RzDNiz5PF32F3z62c3AZM0NgzLL0VAaPP2oen7lLLO0OghxRkIJQCILcmn4Lwk8DsorsHt6IMYy00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686476; c=relaxed/simple;
	bh=wBLju+wWulDHlkOug6Cw3hTEbArb3Lq1MJ+cbr61FbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWDJqPJw2pMww6Qj7NqWVBZyFJJkt8DxBTHdDyITiw/1hJTvparu10v+sjKF+wBbd7Wsu6N0pm9aGv1V6apDtbJGYr3ydVAD7XlOeaIiCeIuNuL2HmSjYUEqzfIa8yoy+RO/l3e+PxPJLb676UTU8obI+gAGbUebo5LydhNR9jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ufcf3msb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773686472; x=1805222472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wBLju+wWulDHlkOug6Cw3hTEbArb3Lq1MJ+cbr61FbE=;
  b=Ufcf3msba7IaRSYsCmbgvMpSQYgVIU9kheWGcxaTqg7mfu5mT9b/jzkk
   wwJEujl6LGjIJ/P+ernIMPW0KpQ+sOxIiGYt5Tkm6b8/qw5msjzOYet01
   73o5t8k2cppiUZ5OfYSxFsDARLkBAJl1kmO3L5ly3g1ZOo+ezfd64oYnw
   cMrXIWMT3bBRhIxZk/bCymikdvhiVigZRcmrJFx19EYs8MdurmkiHeDJu
   2zzpyROfTGJLSjOO+FSXHI4lsrB9YuDRcO11/N/WE2UfSd4zcLokuDqH9
   8L2ace/5K6oFGevOWYFe6i5kDBX5khw9OT2hIwYvcJ/y0491LoYiFtpWQ
   g==;
X-CSE-ConnectionGUID: lOSIlrusTl6qjdKAtmrQFg==
X-CSE-MsgGUID: zGTyrNYiTymRAOiIN2pkZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86067637"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86067637"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:55 -0700
X-CSE-ConnectionGUID: P9KhtMiIR7KznQdYYFeiQg==
X-CSE-MsgGUID: OILuMkWSRa+ntVueU7NMGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252520451"
Received: from soc-pf51ragt.clients.intel.com ([10.122.184.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:53 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	Jacob Moroni <jmoroni@google.com>
Subject: [for-next 12/12] RDMA/irdma: Add support for GEN4 hardware
Date: Mon, 16 Mar 2026 13:39:49 -0500
Message-ID: <20260316183949.261-13-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
References: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18204-lists,linux-rdma=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:?];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tatyana.e.nikolova@intel.com,linux-rdma@vger.kernel.org];
	DMARC_DNSFAIL(0.00)[intel.com : SPF/DKIM temp error,none];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_SPAM(0.00)[0.951];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	R_DKIM_TEMPFAIL(0.00)[intel.com:s=Intel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 889DC29F2B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jacob Moroni <jmoroni@google.com>

GEN4 hardware is similar to GEN3 and requires only a few special cases.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c       |  1 +
 drivers/infiniband/hw/irdma/hw.c         | 14 ++++++++++----
 drivers/infiniband/hw/irdma/ig3rdma_hw.c |  1 -
 drivers/infiniband/hw/irdma/irdma.h      |  1 +
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 13820f1a48a4..335ae3c82e17 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -6465,6 +6465,7 @@ static inline void irdma_sc_init_hw(struct irdma_sc_dev *dev)
 		icrdma_init_hw(dev);
 		break;
 	case IRDMA_GEN_3:
+	case IRDMA_GEN_4:
 		ig3rdma_init_hw(dev);
 		break;
 	}
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 10eb21213cf9..c587872a430d 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1082,6 +1082,7 @@ static int irdma_create_cqp(struct irdma_pci_f *rf)
 		cqp_init_info.hw_maj_ver = IRDMA_CQPHC_HW_MAJVER_GEN_2;
 		break;
 	case IRDMA_GEN_3:
+	case IRDMA_GEN_4:
 		cqp_init_info.hw_maj_ver = IRDMA_CQPHC_HW_MAJVER_GEN_3;
 		cqp_init_info.ts_override = 1;
 		break;
@@ -1508,7 +1509,7 @@ static int irdma_create_aeq(struct irdma_pci_f *rf)
 		   hmc_info->hmc_obj[IRDMA_HMC_IW_CQ].cnt;
 	aeq_size = min(aeq_size, dev->hw_attrs.max_hw_aeq_size);
 	/* GEN_3 does not support virtual AEQ. Cap at max Kernel alloc size */
-	if (rf->rdma_ver == IRDMA_GEN_3)
+	if (rf->rdma_ver >= IRDMA_GEN_3)
 		aeq_size = min(aeq_size, (u32)((PAGE_SIZE << MAX_PAGE_ORDER) /
 			       sizeof(struct irdma_sc_aeqe)));
 	aeq->mem.size = ALIGN(sizeof(struct irdma_sc_aeqe) * aeq_size,
@@ -1518,7 +1519,7 @@ static int irdma_create_aeq(struct irdma_pci_f *rf)
 					 GFP_KERNEL | __GFP_NOWARN);
 	if (aeq->mem.va)
 		goto skip_virt_aeq;
-	else if (rf->rdma_ver == IRDMA_GEN_3)
+	else if (rf->rdma_ver >= IRDMA_GEN_3)
 		return -ENOMEM;
 
 	/* physically mapped aeq failed. setup virtual aeq */
@@ -2192,8 +2193,13 @@ u32 irdma_initialize_hw_rsrc(struct irdma_pci_f *rf)
 	set_bit(2, rf->allocated_pds);
 
 	INIT_LIST_HEAD(&rf->mc_qht_list.list);
-	/* stag index mask has a minimum of 14 bits */
-	mrdrvbits = 24 - max(get_count_order(rf->max_mr), 14);
+
+	if (rf->rdma_ver >= IRDMA_GEN_4)
+		mrdrvbits = 24 - max(get_count_order(rf->max_mr), 16);
+	else
+		/* stag index mask has a minimum of 14 bits */
+		mrdrvbits = 24 - max(get_count_order(rf->max_mr), 14);
+
 	rf->mr_stagmask = ~(((1 << mrdrvbits) - 1) << (32 - mrdrvbits));
 
 	return 0;
diff --git a/drivers/infiniband/hw/irdma/ig3rdma_hw.c b/drivers/infiniband/hw/irdma/ig3rdma_hw.c
index 2e8bb475e22a..f0361675c2de 100644
--- a/drivers/infiniband/hw/irdma/ig3rdma_hw.c
+++ b/drivers/infiniband/hw/irdma/ig3rdma_hw.c
@@ -113,7 +113,6 @@ void ig3rdma_init_hw(struct irdma_sc_dev *dev)
 	dev->irq_ops = &ig3rdma_irq_ops;
 	dev->hw_stats_map = ig3rdma_hw_stat_map;
 
-	dev->hw_attrs.uk_attrs.hw_rev = IRDMA_GEN_3;
 	dev->hw_attrs.uk_attrs.max_hw_wq_frags = IG3RDMA_MAX_WQ_FRAGMENT_COUNT;
 	dev->hw_attrs.uk_attrs.max_hw_read_sges = IG3RDMA_MAX_SGE_RD;
 	dev->hw_attrs.uk_attrs.max_hw_sq_chunk = IRDMA_MAX_QUANTA_PER_WR;
diff --git a/drivers/infiniband/hw/irdma/irdma.h b/drivers/infiniband/hw/irdma/irdma.h
index ff938a01d70c..b5ce515f4ee8 100644
--- a/drivers/infiniband/hw/irdma/irdma.h
+++ b/drivers/infiniband/hw/irdma/irdma.h
@@ -119,6 +119,7 @@ enum irdma_vers {
 	IRDMA_GEN_1,
 	IRDMA_GEN_2,
 	IRDMA_GEN_3,
+	IRDMA_GEN_4,
 	IRDMA_GEN_NEXT,
 	IRDMA_GEN_MAX = IRDMA_GEN_NEXT-1
 };
-- 
2.31.1


