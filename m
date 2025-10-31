Return-Path: <linux-rdma+bounces-14152-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A40C22F6C
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 03:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526CC3BB6E5
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 02:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8D271451;
	Fri, 31 Oct 2025 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZFkXiji"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576526E71E
	for <linux-rdma@vger.kernel.org>; Fri, 31 Oct 2025 02:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877086; cv=none; b=c/SdRiZ1jZ7e7NdyqaRgysLkKjJk7Y5a6KcHxbhfueGwqcFe3gnpZmExsnrj0PnzLCfoAoTcJVez1yojxDqCpjLmkQxF+ic+mnwPx4DFCexfwmudsrqN+JXWZCLe5zwoPzOKmUvqHkxWi6QIXHKArtXo9CEu9jLBfQFzOQx4qs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877086; c=relaxed/simple;
	bh=GP5jeYagdaUB5fgJolMmSKuRNWMTILZrfoHgQAEcUlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGrQq30aDge4jK5BMRRBcNbv9uTX2eGsHxS8sCqDj3b9ssfZlq4hcM/ejwyAxwHKtGzVDr91W/mSe9M4hLS9nisbCqPEvlHR4YByEBglKFArjtyBht+FJDzLLA+HUo4AeGa8PCFbmU/6CKQEOiZuy59a0rLWrEcm/UPtpWaTB2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZFkXiji; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761877085; x=1793413085;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GP5jeYagdaUB5fgJolMmSKuRNWMTILZrfoHgQAEcUlM=;
  b=RZFkXijiDok0AIq/aPNyEEBqhIH6WJQvM6HNwJtJo/9v/lpcpofUYO+9
   t0a1PP78IQozrpTrEJCyHV8uQWzjdqMLkNJB5CZcIhF+hTQfYqcP255DM
   2DEewh3OJG5qctjipRin68c66ZaZZn5/HlM1/PZCuXk3E5XF2o8huMotn
   RxWWPDdWdBOgA4ILUyXQbuOm7f+JKTHXCDxcL3oBBn7CPlyTb9YZ12XCL
   In68CugbLE5da7bJ9ryaGOs2bsas/k1B3ea17JfR4g/cZH2Vc8jRzGl/i
   hLx0ef/+HMNuNwdBexTcQXP8wh1BvHPOLCkYIcryxDPpwAoS7dh3LAQqW
   Q==;
X-CSE-ConnectionGUID: m3mPCouERKWIewLacAfDwA==
X-CSE-MsgGUID: VdshcDfZR1GCtayL+buOMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64182213"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64182213"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:05 -0700
X-CSE-ConnectionGUID: F+vKeZULSfaZaGIcp5jNCQ==
X-CSE-MsgGUID: D+XGt75PTI2wFyie4NRa2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="216950164"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:03 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	krzysztof.czurylo@intel.com,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH] MAINTAINERS: Update irdma maintainers
Date: Thu, 30 Oct 2025 21:17:20 -0500
Message-ID: <20251031021726.1003-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>

Adds Krzysztof Czurylo as co-maintainer for irdma driver.

Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..8861469749e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12515,6 +12515,7 @@ F:	include/linux/avf/virtchnl.h
 F:	include/linux/net/intel/*/
 
 INTEL ETHERNET PROTOCOL DRIVER FOR RDMA
+M:	Krzysztof Czurylo <krzysztof.czurylo@intel.com>
 M:	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-- 
2.31.1


