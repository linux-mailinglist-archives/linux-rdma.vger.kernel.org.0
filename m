Return-Path: <linux-rdma+bounces-14556-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C93C66353
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FE6B4EE4DC
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401BF34CFD5;
	Mon, 17 Nov 2025 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6j0aEY1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D6F34C820
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413692; cv=none; b=LEI1KFyCAO2YCyZa5Wb1XCEpvTCoFKlEN8Wzar5DGh+o6DyCZt8V0MmAy6kdRp5e2pRvi3oZHrPcosnIc4nkr4yaXEZz1ibfznA7f0LN/julpYGS/E2Fs13CZ56OZcmTznrONVwNiy3tZknbaCyhcupyg9jUR/AWWSTLPEFfLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413692; c=relaxed/simple;
	bh=hI94EcriNeBKNp7SWraO89b7knXFIcBL97n3YfiS9r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxDdKwBR3vqYexbCQipPTO9mPbQcNfwrjvsIZjAiojbky4eJLrsxk7Uqr7+vpdJVlt8RRHLIEvHbKZeSSATQ82jcI31qBCadXGOg03i40jzz5/Wp2spWUIxKG74Kwe0lKVamyuAnxZGMfZ4u19RaullM6ayvYo/JjyGCvmEHed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6j0aEY1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763413690; x=1794949690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hI94EcriNeBKNp7SWraO89b7knXFIcBL97n3YfiS9r4=;
  b=d6j0aEY17v/U9JQBY1TbvnlJJmD1W1fiUzXQ8e1nBkDANZJBKDE8ZpGh
   /7a2wUCk1QE66KitkmM896f6VHzMs/FER5h2LiWPXIQZJmqeAT7Gy9/em
   JOWRVh8RGaLdOG+kaPdn9GgvgeNT2NAhxa32hQocYog+Gn6vWULVIp5GY
   0Q+nnFYe8lqFJDt8Cr2T1LfSu5eEXFZC9P8LWqMR/hVTr263TCr2xooM2
   XA17Lfb/niwlC/pwVYAog0ToQbabH7TghCfv33SU0CkiceMx6rmwyxV3J
   o+CACbSr3DZ+XPyvN6cktu5yOgYxtgeQHhmYSoX9qgKSem2zrG1iKw/hb
   w==;
X-CSE-ConnectionGUID: /lWXjTd4TyWAqerBRJ8+NA==
X-CSE-MsgGUID: oANNqbGnQzWlWcZ63Womxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="83051118"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="83051118"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:09 -0800
X-CSE-ConnectionGUID: vmIFrP4KTuiIlxXTStIx5A==
X-CSE-MsgGUID: TVeTYg6USaWvzkIO6ADNuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190583649"
Received: from soc-pf51ragt.clients.intel.com ([10.122.185.21])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:09 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [PATCH] RDMA/irdma: Fix data race in irdma_free_pble
Date: Mon, 17 Nov 2025 15:07:50 -0600
Message-ID: <20251117210756.723-2-tatyana.e.nikolova@intel.com>
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

- Protects pble_rsrc counters with mutex to prevent data race.

- Fixes the following data race in irdma_free_pble reported by KCSAN:

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


