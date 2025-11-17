Return-Path: <linux-rdma+bounces-14562-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E56C6635C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D40C44EEF41
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C3534D3BA;
	Mon, 17 Nov 2025 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+u4Z1Wh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8F634D39A
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413695; cv=none; b=ruumZ7/DogOebf7QerKM3KlD810cKbKiJxWRFI86xnYszNFcAJg9AwO9i9hacWvKfiDpGCFHW1XFBmrkdmDasQIIV+ORX/EvM6b8mZFN+8GRMBOC3HimthLN/IWtM/8qv/miO8NfBRg+oI7QeElKc/37a8/4juh0fibHh95hzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413695; c=relaxed/simple;
	bh=3NbfB5n4RM5Mtw6z45rb+hWtZ/toVy0xiw3wf/vpTrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAU5ewSdpH2byCDciv5a9GPzlE8ne2Y1xGm6VtYGDdzmwCfC1RP4Cq5NxUUzqcu6F8FAvawkicJFuXmJL4wxMH3mjQZlVwXV59YRD3tUmtEQTeWqs01iyNB/KE/lfBkWKV+TSQOQEggRiMqI3caW4s7uvnnyeo9ImrKPFotXe70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+u4Z1Wh; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763413694; x=1794949694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3NbfB5n4RM5Mtw6z45rb+hWtZ/toVy0xiw3wf/vpTrY=;
  b=m+u4Z1WhIqL4lKkczfY5fc7Fco8wTMNatoHEvdbQbnAOF1ATSllrxhOw
   UpbjduJAu2epI2h054o84HMGqA+W0I82WTPMuGQIKnan7bwf0sjSa4vUx
   +gtl9ho+Ba6LsUy9xDiIa8xYA72mBoNsZPhQMAJ7/erUvSdsuYKnfhJXU
   eXL6A+VijTUngLueAMY41gk5FB+BcFtNVZa9s5/QsYZSqDi7n9jCj4+QA
   pqG/VuIIBh74h+KZa2Mf4KHmfoCXmec/67Yd93GrY0V3SXFTewwJV6D7u
   6/a3YWX70tYw7TOifxFnrGAbLCuOwj8eqFBFcc1OQVsx3FeHFxuVZt86p
   A==;
X-CSE-ConnectionGUID: tFX5dzYMT1uuGz/F/NGBFg==
X-CSE-MsgGUID: ujhj+fFzTyemVH0qXzQmew==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="83051136"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="83051136"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:12 -0800
X-CSE-ConnectionGUID: 72RUw/HZRbK3AVZUNBXXSg==
X-CSE-MsgGUID: 7oBB/2K8Qb2GLqwXtkCOag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190583666"
Received: from soc-pf51ragt.clients.intel.com ([10.122.185.21])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:12 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	Jacob Moroni <jmoroni@google.com>
Subject: [PATCH 2/2] RDMA/irdma: Do not set IBK_LOCAL_DMA_LKEY for GEN3+
Date: Mon, 17 Nov 2025 15:07:55 -0600
Message-ID: <20251117210756.723-7-tatyana.e.nikolova@intel.com>
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

From: Jacob Moroni <jmoroni@google.com>

The GEN3 hardware does not appear to support IBK_LOCAL_DMA_LKEY. Attempts
to use it will result in an AE.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index ec792fda2b6b..4c15699e94b0 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -27,7 +27,8 @@ static int irdma_query_device(struct ib_device *ibdev,
 			irdma_fw_minor_ver(&rf->sc_dev);
 	props->device_cap_flags = IB_DEVICE_MEM_WINDOW |
 				  IB_DEVICE_MEM_MGT_EXTENSIONS;
-	props->kernel_cap_flags = IBK_LOCAL_DMA_LKEY;
+	if (hw_attrs->uk_attrs.hw_rev < IRDMA_GEN_3)
+		props->kernel_cap_flags = IBK_LOCAL_DMA_LKEY;
 	props->vendor_id = pcidev->vendor;
 	props->vendor_part_id = pcidev->device;
 
-- 
2.31.1


