Return-Path: <linux-rdma+bounces-14742-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90773C8324A
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 03:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551253AE262
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 02:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2161E0DD8;
	Tue, 25 Nov 2025 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzcDvwA/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578D1BBBE5
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039300; cv=none; b=jZAZPCXB6fI2aXMk4t9aHmws5eoSoqd1vFCfeqVpiRvYNCzAHfmDRyyHd5/4nhumfWBrfJw7H/j+/hPErZ8MUlOrtJkUFJM/Y9ybvqo21DTEu4iAcxujJ/uEYGUix+aGnZSV9ZLgPINYshENw8xxpQ9QEv2wMmzXpckXxsJnIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039300; c=relaxed/simple;
	bh=PNx18so8kQK7ekeSiwcsWjViTVoCIt0lYSZ1ZAsNluA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lt4kfiLg5l0SKjT0zHieQ2VONrxtU9Acs5D2bXQuzpzi2pdTVJ2oC644OmR5b9xkN8pDaP3MxDIDuAAh9VBw6xffGIQtP0obGU/IInHWfmuWS3DCu0T8vp86C414ssvMaEBoX+FL+eYC8CcqSKQh6ZBL1IBN3ipBeWsmntQRdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzcDvwA/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764039298; x=1795575298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PNx18so8kQK7ekeSiwcsWjViTVoCIt0lYSZ1ZAsNluA=;
  b=FzcDvwA/dyGZunY6TCn1XYqVLw4igtnr7jiaH8GslIJPPePraXgqhFvZ
   +C/1c5Ml9Nhoc2hWRBxD343VvD3uxS8m0nn/+cPd5T1ebknosQNFy70Or
   6D5tbwy411vOLuLBheYzochX4f7YYZx64NI0S8g1xXmV5qd5Df9vUK/4t
   isNFlppGNvhHUbLHYBvOPEXH7Ai/g7mKWroMVuVFRuBkjvvfjt+g4Zx6T
   Ige3pvGNxbGQxqg9ByEUbpunyOPB0CnAssdZVoynEXotZCajQhBl0btBT
   84X9HkpUtctIEUt1G85qGEBZp1uIbuxhkYeYtuaidORU2QCEGs7U5V4pX
   A==;
X-CSE-ConnectionGUID: 41QdtaA0ReWBKoxvyqXyqA==
X-CSE-MsgGUID: wBXovbiPQVSY//U6y93hHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65942190"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="65942190"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:57 -0800
X-CSE-ConnectionGUID: j483kkb1QMKmpw1MIxsDJg==
X-CSE-MsgGUID: w0MKWdCER4qa1nbvNPQ9GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="196800270"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:56 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	jmoroni@google.com
Subject: [PATCH 2/9] RDMA/irdma: Fix data race in irdma_free_pble
Date: Mon, 24 Nov 2025 20:53:43 -0600
Message-ID: <20251125025350.180-3-tatyana.e.nikolova@intel.com>
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

Protects pble_rsrc counters with mutex to prevent data race.
Fixes the following data race in irdma_free_pble reported by KCSAN:

BUG: KCSAN: data-race in irdma_free_pble [irdma] / irdma_free_pble [irdma]

write to 0xffff91430baa0078 of 8 bytes by task 16956 on cpu 5:
 irdma_free_pble+0x3b/0xb0 [irdma]
 irdma_dereg_mr+0x108/0x110 [irdma]
 ib_dereg_mr_user+0x74/0x160 [ib_core]
 uverbs_free_mr+0x26/0x30 [ib_uverbs]
 destroy_hw_idr_uobject+0x4a/0x90 [ib_uverbs]
 uverbs_destroy_uobject+0x7b/0x330 [ib_uverbs]
 uobj_destroy+0x61/0xb0 [ib_uverbs]
 ib_uverbs_run_method+0x1f2/0x380 [ib_uverbs]
 ib_uverbs_cmd_verbs+0x365/0x440 [ib_uverbs]
 ib_uverbs_ioctl+0x111/0x190 [ib_uverbs]
 __x64_sys_ioctl+0xc9/0x100
 do_syscall_64+0x44/0xa0
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

read to 0xffff91430baa0078 of 8 bytes by task 16953 on cpu 2:
 irdma_free_pble+0x23/0xb0 [irdma]
 irdma_dereg_mr+0x108/0x110 [irdma]
 ib_dereg_mr_user+0x74/0x160 [ib_core]
 uverbs_free_mr+0x26/0x30 [ib_uverbs]
 destroy_hw_idr_uobject+0x4a/0x90 [ib_uverbs]
 uverbs_destroy_uobject+0x7b/0x330 [ib_uverbs]
 uobj_destroy+0x61/0xb0 [ib_uverbs]
 ib_uverbs_run_method+0x1f2/0x380 [ib_uverbs]
 ib_uverbs_cmd_verbs+0x365/0x440 [ib_uverbs]
 ib_uverbs_ioctl+0x111/0x190 [ib_uverbs]
 __x64_sys_ioctl+0xc9/0x100
 do_syscall_64+0x44/0xa0
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

value changed: 0x0000000000005a62 -> 0x0000000000005a68

Fixes: e8c4dbc2fcac ("RDMA/irdma: Add PBLE resource manager")
Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/pble.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/pble.c b/drivers/infiniband/hw/irdma/pble.c
index 3091f9345f12..4a20ec891059 100644
--- a/drivers/infiniband/hw/irdma/pble.c
+++ b/drivers/infiniband/hw/irdma/pble.c
@@ -506,12 +506,14 @@ int irdma_get_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 void irdma_free_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 		     struct irdma_pble_alloc *palloc)
 {
-	pble_rsrc->freedpbles += palloc->total_cnt;
-
 	if (palloc->level == PBLE_LEVEL_2)
 		free_lvl2(pble_rsrc, palloc);
 	else
 		irdma_prm_return_pbles(&pble_rsrc->pinfo,
 				       &palloc->level1.chunkinfo);
+
+	mutex_lock(&pble_rsrc->pble_mutex_lock);
+	pble_rsrc->freedpbles += palloc->total_cnt;
 	pble_rsrc->stats_alloc_freed++;
+	mutex_unlock(&pble_rsrc->pble_mutex_lock);
 }
-- 
2.31.1


