Return-Path: <linux-rdma+bounces-12964-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F087B386A6
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 17:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31055200F8C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F913292918;
	Wed, 27 Aug 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBCqOX48"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D90287511
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308424; cv=none; b=SM4upUKmiw+B/qZN+dLmUROq8+XI4bydW+hHnEr3ZzK/lRfEZqdix18PZKxA2tqZuo7YLBzfweVw2cV2ziWMtaouuCr2/rRZRbdV9JnrdsAvjqATU4USjEIRpbg/X7ELg/QLYyHDphWwcn2R/PF+/9NMtg1truHFtGY1qo5VzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308424; c=relaxed/simple;
	bh=ELsk3f7kxHzBCiRA4cf/KOXUZkucqeGHtp61Q+djDnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEON1seTvbeGhHCPqJxtWbL7U5i1knvDUgbYilRBIoi8oj2QVo3f2Xmm033uJTZmDO1d3KiTwZZmFZt16bsIzlWueWhVwrozdO4l/sX+obWPEpHzFJi5fm5WM0YEUuh6fwo+fdLnWWqN/4LkNZmqcO9iZwU2DBE1TwJc8thPEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBCqOX48; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756308423; x=1787844423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ELsk3f7kxHzBCiRA4cf/KOXUZkucqeGHtp61Q+djDnM=;
  b=eBCqOX48rusd/8RExSquMLTABfuTjHcvLt3k0AyfGha5pS78/lZAbXTL
   3C10QeGYYNHooBcJ7uuaQg+w/EImy+LMKEaqXdhdOahS3GhimRyz4e/aB
   wOi7BZT8poW3JEf9vMM0/GYz4nhjfoPL8IPwW13xm/8YSJnl/f8plhZW6
   PYlPS92ko715Z/seYQGjaD1f+rEh92Goe/MlBuI9X3WTF5bOuliLyfr4y
   UY8+20qLHXZjFaUDn04AwE/iutqQngZQXrAmpbmcJo453QAu65Rsdkc2t
   g7T4iu0bTh4P7jikddIASnZvDUN8JuruRnsqzTUaVVeww0Q5lhWr5Oymu
   w==;
X-CSE-ConnectionGUID: 9jGaI1BtShGdkGZ9z89hGg==
X-CSE-MsgGUID: NbD+K6MDRrquyJ+1bA/7DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76162808"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76162808"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:44 -0700
X-CSE-ConnectionGUID: JJvZ/mYsQreKg2JMAly1fw==
X-CSE-MsgGUID: ehmhGxh7SjWnvElJzBChdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174206881"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:43 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 16/16] RDMA/irdma: Update Kconfig
Date: Wed, 27 Aug 2025 10:25:45 -0500
Message-ID: <20250827152545.2056-17-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
References: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update Kconfig to add dependency on idpf module and
add IPU E2000 to the list of supported devices.

Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/Kconfig b/drivers/infiniband/hw/irdma/Kconfig
index 5f49a58590ed..0bd7e3fca1fb 100644
--- a/drivers/infiniband/hw/irdma/Kconfig
+++ b/drivers/infiniband/hw/irdma/Kconfig
@@ -4,10 +4,11 @@ config INFINIBAND_IRDMA
 	depends on INET
 	depends on IPV6 || !IPV6
 	depends on PCI
-	depends on ICE && I40E
+	depends on IDPF && ICE && I40E
 	select GENERIC_ALLOCATOR
 	select AUXILIARY_BUS
 	select CRC32
 	help
-	  This is an Intel(R) Ethernet Protocol Driver for RDMA driver
-	  that support E810 (iWARP/RoCE) and X722 (iWARP) network devices.
+	  This is an Intel(R) Ethernet Protocol Driver for RDMA that
+	  supports IPU E2000 (RoCEv2), E810 (iWARP/RoCEv2) and X722 (iWARP)
+	  network devices.
-- 
2.42.0


