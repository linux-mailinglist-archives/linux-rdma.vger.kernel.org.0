Return-Path: <linux-rdma+bounces-11687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA716AEA3AE
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 18:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A601C24801
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F509202F83;
	Thu, 26 Jun 2025 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFHA4Az3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A14F405F7;
	Thu, 26 Jun 2025 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750956316; cv=none; b=leA2V6px5tXduP4hrc6QQX45IhfgkzHbKBoRpAzK8dXa95jE1tZsYgu/myfIDERuXQUabIMfGAisBDnDcV4onBaIz3l+wdOHk+UXyNkro9xi9h3QVzDJiShLJwGZbYoVA+WnmmvbtYjNGBEPK0EAg7GYgVuEBAX4u/3BpnrHdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750956316; c=relaxed/simple;
	bh=52tMnreW8uelOqocxxeVtuaIXYhaUzlqD6oKmCy37xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jb1R4hlyVdAnbWNz1BcsETZXLh0cg3B+BUm5qxBPvDL37Deq5TXe3PIt5mbambEguONcOBol/hiJUWIuNuV9J8gEzfFanj8wwMnhxZVUohOi+3G69OaaBD8mndXmeOfEnsLwAJytn3t4oDzmi3B43ikT5nW44BLVMZq8z5qVJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFHA4Az3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750956314; x=1782492314;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=52tMnreW8uelOqocxxeVtuaIXYhaUzlqD6oKmCy37xA=;
  b=BFHA4Az3NGm0izz4IOLtmTc4hrqzh0KtmnmgakMALLSyrGre6tzxDTbd
   dHqJE2gCu09TWn3zpm8PpbgPxtxZrPdZOKp2DDnQfqIRsE5zOpVkFCkRI
   RP5YP1h5IPfK9cmpKQ/ussGiRIxVXtEcm+d8fFd2P3Mat8fBGSgd1+j8y
   EiyUxymBlNQmanl+O5LH9ZKf4Uf4erhg1E9J02WApkhWJzDyH5MEFYFJR
   RdzeThUepT7mwnGhK+bxURAdLvDoBIPnb/cqly++p4kIv74OAihatr4XM
   l5rX6b+hoxDiB9Ro61NgoTcYcG4FN+7eEifg58oD/1BkO7rJat+PjWB38
   Q==;
X-CSE-ConnectionGUID: 0bHRnXx3TMGL7CI87oRgPA==
X-CSE-MsgGUID: 0x8s+rQPT3eQdqKMBP1iWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="64616473"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="64616473"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:45:14 -0700
X-CSE-ConnectionGUID: Xd7pQarPSgOgwvcrAXpOIg==
X-CSE-MsgGUID: 3IBmPZz2TEi2ZqTV/SNSnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="152079578"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 26 Jun 2025 09:45:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 59AA82AD; Thu, 26 Jun 2025 19:45:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] net/mlx5: Don't use "proxy" headers
Date: Thu, 26 Jun 2025 19:45:09 +0300
Message-ID: <20250626164509.327410-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Note that kernel.h is discouraged to be included as it's written
at the top of that file.

While doing that, sort headers alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/mlx5/driver.h | 45 +++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index e6ba8f4f4bd1..2a2d9cead9b3 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -33,28 +33,38 @@
 #ifndef MLX5_DRIVER_H
 #define MLX5_DRIVER_H
 
-#include <linux/kernel.h>
-#include <linux/completion.h>
-#include <linux/pci.h>
-#include <linux/irq.h>
-#include <linux/spinlock_types.h>
-#include <linux/semaphore.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/xarray.h>
-#include <linux/workqueue.h>
-#include <linux/mempool.h>
-#include <linux/interrupt.h>
-#include <linux/notifier.h>
-#include <linux/refcount.h>
 #include <linux/auxiliary_bus.h>
-#include <linux/mutex.h>
+#include <linux/completion.h>
+#include <linux/idr.h>
+#include <linux/io.h>
+#include <linux/kref.h>
+#include <linux/lockdep_types.h>
+#include <linux/minmax.h>
+#include <linux/mutex_types.h>
+#include <linux/notifier.h>
+#include <linux/pci.h>
+#include <linux/printk.h>
+#include <linux/refcount.h>
+#include <linux/semaphore.h>
+#include <linux/spinlock_types.h>
+#include <linux/timer_types.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
+
+#include <rdma/ib_verbs.h>
+
+#include <asm/page.h>
 
 #include <linux/mlx5/device.h>
 #include <linux/mlx5/doorbell.h>
 #include <linux/mlx5/eq.h>
-#include <linux/timecounter.h>
-#include <net/devlink.h>
+
+struct dentry;
+struct device;
+struct dma_pool;
+struct net_device;
+struct pci_dev;
 
 #define MLX5_ADEV_NAME "mlx5_core"
 
@@ -243,6 +253,7 @@ struct mlx5_cmd_first {
 	__be32		data[4];
 };
 
+struct cmd_msg_cache;
 struct mlx5_cmd_msg {
 	struct list_head		list;
 	struct cmd_msg_cache	       *parent;
-- 
2.47.2


