Return-Path: <linux-rdma+bounces-7553-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903B7A2CD3B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 20:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B903ABB99
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 19:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA651DDC1D;
	Fri,  7 Feb 2025 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yt5bs7o+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793219DF44;
	Fri,  7 Feb 2025 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957844; cv=none; b=odijXGLe1EzguBmjsVMyD7Hs2BJm95zL8JRXnrWXLbpBUNF4kTV0dSODaqmqaVqIqAyR2PLasNGbi5gZNL5FXcNH50t1ncWhsF3ndNFOesRw/Q2pMdbLTOuov1eoGdz+fNEfiWXT26U7Akn4rVWzssSceUhGcT3b/mGqIwMsno4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957844; c=relaxed/simple;
	bh=3dPLWcm3trr1v1dHML2fW2YF991UkfljjaavizRX1fY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S3EdMTzOAXMMtH6UaI1Xw31sNBfJbxs9KuCDP+x6F+scoHwuWc72dgOyXBJlXOD5bc+tHfcFSvDkkAuz1xDoKbWiIryngWIKlAU6D6e6HMp3HpOWFE5MIdWtOj0kXA5VTnkQNq3RuzAW099ZF1P95MjNWXyiysvcZNyTTmYgS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yt5bs7o+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738957843; x=1770493843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3dPLWcm3trr1v1dHML2fW2YF991UkfljjaavizRX1fY=;
  b=Yt5bs7o+9gHDynd/fB0X3GIbtiDv8P/l7o4WGy5TbKTHyIou0nPpnNDf
   vrZZ9ZSOXC5tb4JyhoKMh89vaLtXS5pbLKpMzs6VU5v5rqQ379keKlfE6
   tnp9imGGycRoZGOCmOCueUFNU5WTwswVJmZ4ynsq2Gf1RrsD1OY8WKAEK
   L1o+6bJVGMUZ3TTJ4Y3cxdjuLJy4K4lPfYk2clBJAGQNjFeVjXtSJTdm5
   i6Y+X+ReWswB+jSm1dt9gGIWeDzTOf9LjRoQBW3o+mMhHrvlMsTv29PGr
   JuLxIGqcwGm0N4/E3gpnoGShE4uF2KNLeffwg4jF9oBl9wsUhhzLJq3nm
   g==;
X-CSE-ConnectionGUID: XCSdai/4RyiZwYfcCKvZrw==
X-CSE-MsgGUID: HLLs3ippQuy1QcO0hLT4vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42451870"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42451870"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:36 -0800
X-CSE-ConnectionGUID: Z9ou9cdtSQGA1zsr9tyQog==
X-CSE-MsgGUID: L9noZQ7ZS8+Xm9MR0PfrSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112238328"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.81.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:35 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [rdma v3 24/24] RDMA/irdma: Update Kconfig
Date: Fri,  7 Feb 2025 13:49:31 -0600
Message-Id: <20250207194931.1569-25-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
References: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiraz Saleem <shiraz.saleem@intel.com>

Update Kconfig to add dependency on idpf module. Additionally, add
IPU E2000 to list of devices supported.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/Kconfig b/drivers/infiniband/hw/irdma/Kconfig
index b6f9c41bca51..f6b39f3a726e 100644
--- a/drivers/infiniband/hw/irdma/Kconfig
+++ b/drivers/infiniband/hw/irdma/Kconfig
@@ -4,9 +4,10 @@ config INFINIBAND_IRDMA
 	depends on INET
 	depends on IPV6 || !IPV6
 	depends on PCI
-	depends on ICE && I40E
+	depends on (IDPF || ICE) && I40E
 	select GENERIC_ALLOCATOR
 	select AUXILIARY_BUS
 	help
-	  This is an Intel(R) Ethernet Protocol Driver for RDMA driver
-	  that support E810 (iWARP/RoCE) and X722 (iWARP) network devices.
+	  This is an Intel(R) Ethernet Protocol Driver for RDMA that
+	  support IPU E2000 (RoCEv2), E810 (iWARP/RoCE) and X722 (iWARP)
+	  network devices.
-- 
2.37.3


