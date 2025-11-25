Return-Path: <linux-rdma+bounces-14749-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E63DDC8325F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 03:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1E0A3473BF
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 02:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127C51F30AD;
	Tue, 25 Nov 2025 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8Oqlolt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB461EA7CE
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 02:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039303; cv=none; b=ll17l2U5eiY2JfF3SKZ51Z0gF/camw1G1cSTcmtEtHGTpp+WkfMDtOHMJnKHs3t1bVTCorI9Rt5vAHJ/D0OQQYNx+y9qjnPEZ48uOkX9NOYk060wkTSwlWKlcv8N6YcNjlg9WYPaKr7gAmVfmzShKl1iwhRpe7pmmC4KrRQzSvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039303; c=relaxed/simple;
	bh=ntkEM9NaaqWqAr9FwjteLuokYkGVxmwercLDEnTp2mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caa5km5xjon9qtENdRgBmC12eJEntAjo69bBbXdaRtyCGMkafKtNLXGDYaNRaZCxWERmQlZ7FcDuK3B2PCsVJFvgKOMQvr6IMfyfgxnEXb9t4XHk7a1SkkPxWxVR6lDTvIp00NRHpW4E3NtZEQfpOKlzQ3culRA60agg56CLq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8Oqlolt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764039302; x=1795575302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ntkEM9NaaqWqAr9FwjteLuokYkGVxmwercLDEnTp2mY=;
  b=f8Oqlolt8ZJ/f5H4C53EkM37H4YvOQBYBFEsO62LKjzdRcA7FaC4Yg9/
   mUY8f5ZMEG0BUcLhKI4klyMQ0Rh6CDWBsOk9TtluwYekPrLOE6+Hpp80W
   2+d/QQ0u/IHguuFtIWtnH+gVNrOXQTYU57gzVVe1MBf5Vmwl3DPDhvj8K
   4465XFbJzhCP//QHBfxUy4+lv1UZ911KOuZ/hP4r1fKjQuKj+gy+BmAn7
   8E2Z9NVumq+6f3749KdpAkc1J6BRF50iaIK3QjEtmTVB9WAA54JBeGcfb
   UMuwOm3Lccw7HiNjmTbyQ/Hs84dZ4MvQC+KGZIFXf0j0HjBFWzSUpTOqU
   g==;
X-CSE-ConnectionGUID: BE58QQ6ER/yQRnNhq5Vjdw==
X-CSE-MsgGUID: 7sNJ9iFxSGSdB4ly8yqrgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65942232"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="65942232"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:55:01 -0800
X-CSE-ConnectionGUID: +SqgT7+3SJu+r6kDGrdGCg==
X-CSE-MsgGUID: gdyEhalSQByTYnygGxJ9Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="196800329"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:55:01 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	jmoroni@google.com,
	Jijun Wang <jijun.wang@intel.com>
Subject: [PATCH 9/9] RDMA/irdma: Fix SRQ shadow area address initialization
Date: Mon, 24 Nov 2025 20:53:50 -0600
Message-ID: <20251125025350.180-10-tatyana.e.nikolova@intel.com>
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

From: Jijun Wang <jijun.wang@intel.com>

Fix SRQ shadow area address initialization.

Fixes: 563e1feb5f6e ("RDMA/irdma: Add SRQ support")
Signed-off-by: Jijun Wang <jijun.wang@intel.com>
Signed-off-by: Jay Bhat <jay.bhat@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8ff63fc55507..00c51bb88c4c 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2311,8 +2311,8 @@ static int irdma_setup_kmode_srq(struct irdma_device *iwdev,
 	ukinfo->srq_size = depth >> shift;
 	ukinfo->shadow_area = mem->va + ring_size;
 
-	info->shadow_area_pa = info->srq_pa + ring_size;
 	info->srq_pa = mem->pa;
+	info->shadow_area_pa = info->srq_pa + ring_size;
 
 	return 0;
 }
-- 
2.31.1


