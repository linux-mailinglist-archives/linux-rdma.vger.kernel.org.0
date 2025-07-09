Return-Path: <linux-rdma+bounces-12000-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08157AFE2DA
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 10:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC825560558
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B109C27E07E;
	Wed,  9 Jul 2025 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVN8KMgu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307227AC45;
	Wed,  9 Jul 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050291; cv=none; b=UhOn4Mzw/tjhwJi3CYIrnwtPR+gRpUF0v4BXdUi5VqaVkxfQTUNTKFJJQPBFfP1SzCVwLsc4DpcVTKaut/+b7pyN0nPvdnTooIfpeIYR2AWg2aIuAKouN9wfCyqY7pv4kP75lLKKy9jLFj59UHnGlguNyZCRyvDXe4yFZ5OM6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050291; c=relaxed/simple;
	bh=pGyYIv6daCmou5xv4fwBlOVNjf+rn4iim5q/PHImEdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1gpP+7N1g0s3064k5Ed5Hm/pvfLU3soHyYb2J5U54pHooBSJPQtnmKVf3XUnqFjEahVTXT/bXEj2wUpoGquTxmKEw5z9vk+3Kx2v4YKrHyV36CGycQkpsgItPBffZB/+JT+kmDrPzpETOiiU5RvfTSNtMKwxbNiVXFgfD2/zpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVN8KMgu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752050290; x=1783586290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pGyYIv6daCmou5xv4fwBlOVNjf+rn4iim5q/PHImEdA=;
  b=TVN8KMguJ9wNwA9ThvjHa7VLYM+9PX2JCtI7xbYsnhOEawqaGiDz2fut
   jW/FiHNQUU3gZOXwxUm9pn1whb3ilKlQKyrEV8Jv/q38KuQwDzRjDH1oE
   k0j4+dXEDgmzmST16yDNnNjgZExbn4JlM8wBwp8Nq+S6uBYYThTgl3jFp
   UwI/1/Ikx0R2IAJJGetl3bKJRWn/PopPhOBzAJJc7fJ6qmZwZcU4Vap5d
   n8Yo5zhUGEsj+ZZITVb2BbemTxI+HnE/3eKi6d/3iCFkALq91TmMAHucL
   39CDsWO5L3ZfwRVyfkgL5u8BDDqsmlMHmaD7Em789QttWmu7FBvuKF5P0
   A==;
X-CSE-ConnectionGUID: WJmCh4XBTx+/jgMc08nByA==
X-CSE-MsgGUID: +1HNKk8CTG++crEpA2EClw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54159888"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54159888"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:38:05 -0700
X-CSE-ConnectionGUID: RHa09Dw8SbiQm1diB87Rsw==
X-CSE-MsgGUID: dYPAEBpbSp+36T6d7Vib8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155138224"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 09 Jul 2025 01:38:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8C99A1B7; Wed, 09 Jul 2025 11:37:59 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v2 1/1] net/mlx5: Don't use "proxy" headers
Date: Wed,  9 Jul 2025 11:37:41 +0300
Message-ID: <20250709083757.181265-1-andriy.shevchenko@linux.intel.com>
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

v2: fixed a few compilation issues in some cases (LKP)

 drivers/infiniband/hw/mlx5/mlx5_ib.h          | 17 ++++---
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   | 12 +++--
 include/linux/mlx5/driver.h                   | 47 ++++++++++++-------
 3 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index a012e24d3afe..3e8c8ddda045 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -7,20 +7,23 @@
 #ifndef MLX5_IB_H
 #define MLX5_IB_H
 
-#include <linux/kernel.h>
+#include <linux/mempool.h>
 #include <linux/sched.h>
-#include <rdma/ib_verbs.h>
-#include <rdma/ib_umem.h>
+#include <linux/types.h>
+
 #include <rdma/ib_smi.h>
-#include <linux/mlx5/driver.h>
+#include <rdma/ib_umem.h>
+#include <rdma/ib_user_verbs.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/uverbs_ioctl.h>
+
 #include <linux/mlx5/cq.h>
+#include <linux/mlx5/driver.h>
 #include <linux/mlx5/fs.h>
 #include <linux/mlx5/qp.h>
-#include <linux/types.h>
 #include <linux/mlx5/transobj.h>
-#include <rdma/ib_user_verbs.h>
+
 #include <rdma/mlx5-abi.h>
-#include <rdma/uverbs_ioctl.h>
 #include <rdma/mlx5_user_ioctl_cmds.h>
 #include <rdma/mlx5_user_ioctl_verbs.h>
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 2e02bdea8361..0b2dd9eab6a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -33,14 +33,18 @@
 #ifndef __MLX5_CORE_H__
 #define __MLX5_CORE_H__
 
-#include <linux/types.h>
+#include <linux/firmware.h>
+#include <linux/if_link.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/if_link.h>
-#include <linux/firmware.h>
+#include <linux/types.h>
+
+#include <net/devlink.h>
+
 #include <linux/mlx5/cq.h>
-#include <linux/mlx5/fs.h>
 #include <linux/mlx5/driver.h>
+#include <linux/mlx5/fs.h>
+
 #include "lib/devcom.h"
 
 extern uint mlx5_core_debug_mask;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 3475d33c75f4..54b82d55deb6 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -33,28 +33,40 @@
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
+#include <net/devlink.h>
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
 
@@ -243,6 +255,7 @@ struct mlx5_cmd_first {
 	__be32		data[4];
 };
 
+struct cmd_msg_cache;
 struct mlx5_cmd_msg {
 	struct list_head		list;
 	struct cmd_msg_cache	       *parent;
-- 
2.47.2


