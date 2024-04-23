Return-Path: <linux-rdma+bounces-2031-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 924A58AF81E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 22:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BF51F2284E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15067142E7B;
	Tue, 23 Apr 2024 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csfrQAf9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03E433A0;
	Tue, 23 Apr 2024 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904989; cv=none; b=cemYkn9jJYgLg1XrF5Ib/bHVJNZqHULlS8rSiKThbIsT+AtbePIxudZwCh7/h37+Tz8hBT1e8JFsWc/bnrC1e4mK5JYnPKgyV3w6DEzBfvRyc5pjGPjpd9CCoaLY6/JN4Z91EQyU5/+vNqu84J3cPUBcmDrLevVqqg+PdFsxY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904989; c=relaxed/simple;
	bh=9d8kgnS+GuFxNleqgThQ2tyzjOU0Gs4O6lFQMRb9NNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n4mUdNwnvPEUS9/caCyczCkD/ceAADEy1L1dVHrDEtDOD9gQb1Qz/sqdyBvAQg0qkzWyUjGMOxWSHdYBABsSj3lR+Wn+uiqkdtZC81xmxEkJj0i2Bu4C6XoBKK5EkabRZwe8wd7v08V6H9wjkpX8OTIHnQiGIir1xtEU3QaXAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csfrQAf9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713904988; x=1745440988;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9d8kgnS+GuFxNleqgThQ2tyzjOU0Gs4O6lFQMRb9NNY=;
  b=csfrQAf9k7OcsTZb8ePuVFfL2HHvtTRGERCTzjAx4tq8gz5XRiKaJ7bz
   Posg4I1KCNF2cB0U0pfpCnUDGm5t4UFZbL8xEpM1ho+zrwXRDCl4iHCf9
   z64v5hUmLRbuRx7zb3q6tjG7QLerE/boAKwDz8q5NtX7jbJcGichQeByD
   f/+AKLVpRKjzJWwhBvE5xrDTQB5PI/mnon34T3TLUe1D+QMM578rKa0ov
   tt03BlOSa0rAVNRgFaGgrKgQO1qS9X6saZuamb5Axv2OLtR6Ca9GfEysc
   lM1JH2/D527zKxirNtzkY+DsFaCUdwsi4/unHDVYJIABJhcGD2mNZ4zx5
   g==;
X-CSE-ConnectionGUID: 6+iThrn2RoSs5kQ5q02ApA==
X-CSE-MsgGUID: bLy5zUWHRae1KzfZTNmDoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9340574"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9340574"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:43:08 -0700
X-CSE-ConnectionGUID: spfHzm6QQnCATeoPmfdY5w==
X-CSE-MsgGUID: CVcwAEDzS8SdURosSGWeDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24521216"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 23 Apr 2024 13:43:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5AFC6192; Tue, 23 Apr 2024 23:43:04 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] RDMA/mana_ib: Fix compilation error
Date: Tue, 23 Apr 2024 23:42:58 +0300
Message-ID: <20240423204258.3669706-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compilation with CONFIG_WERROR=y is broken:

.../hw/mana/device.c:88:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
	if (!upper_ndev) {
	    ^~~~~~~~~~~

Fix this by assigning the ret to -ENODEV in respective condition.

Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/infiniband/hw/mana/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index fca4d0d85c64..4c45f8681e7f 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -88,6 +88,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	if (!upper_ndev) {
 		rcu_read_unlock();
 		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
+		ret = -ENODEV;
 		goto free_ib_device;
 	}
 	ether_addr_copy(mac_addr, upper_ndev->dev_addr);
-- 
2.43.0.rc1.1336.g36b5255a03ac


