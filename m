Return-Path: <linux-rdma+bounces-8104-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C01A4540A
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 04:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86254173E43
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 03:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255122A814;
	Wed, 26 Feb 2025 03:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lpr8h+Wn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5410825A2D3
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 03:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540939; cv=none; b=r1t7SgMK3fk8URX3Rvh930CRfY9eCZGOABR1Ax00GcAqTM85awvhewVZjaFchEWYbshXhPy+J+PoIjLL9Wiqf8bMOCV2B/mLcuCGQGhBKesImNEwX45+bqiSKXqQh3tVhUOtP0jKm0jg1B6G+82zyGww02xNktFhWokJOZTSS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540939; c=relaxed/simple;
	bh=5Zi8aCuYqoBMpMJoAQuFe9XXnBo6JhN7c628hykREwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kp0ba/zyx5L2w2Qz8rcOcTl0kWZk76Zi5zlZ+YCS6BREu0Zdizuekmp1JCNdH1tvRRYqcuBis1YzwG230kilr0IR4HOP0LeE+4+ob3BAfq3QFqM7FpW6lf3FNu4AtafG31XOujdD/CiutGndGdZaCiDPFq8mumIW8t1p+AqwEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lpr8h+Wn; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740540935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aMgncgwo54ntG1eJYN0oZGDokP7lPxw8+ChbEuj9iIM=;
	b=Lpr8h+WnNYDIG4HdnllKV3E0lgpbpQs1aW/OXWe15MAsng5FIUrz3w723U9Fk01CehEygC
	8j5xGq8uqTMPjSILNMSR6Sd3Q/ZvpUxSvsj8oXm9O4uTG7Z6mh5SxQ5zL7JPMpIcxpz9dA
	LS9UFkc48QJpbe3liCp9EQ0pfLsGLGc=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	Parav Pandit <parav@mellanox.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: RDMA: explicitly enumerate ib_device attribute groups
Date: Wed, 26 Feb 2025 03:35:25 +0000
Message-ID: <20250226033526.2769817-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Explicitly enumerate ib_device's attribute groups.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Maher Sanalla <msanalla@nvidia.com>
Cc: Parav Pandit <parav@mellanox.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/infiniband/core/device.c |  4 ++--
 include/rdma/ib_verbs.h          | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 0ded91f056f3..8dea307addf1 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1404,8 +1404,8 @@ int ib_register_device(struct ib_device *device, const char *name,
 		return ret;
 	}
 
-	device->groups[0] = &ib_dev_attr_group;
-	device->groups[1] = device->ops.device_group;
+	device->groups[IB_ATTR_GROUP_DEV_ATTR] = &ib_dev_attr_group;
+	device->groups[IB_ATTR_GROUP_DRIVER_ATTR] = device->ops.device_group;
 	ret = ib_setup_device_attrs(device);
 	if (ret)
 		goto cache_cleanup;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b59bf30de430..9c4c4238e6fc 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2728,6 +2728,13 @@ struct ib_core_device {
 	struct ib_device *owner; /* reach back to owner ib_device */
 };
 
+enum ib_device_attr_group {
+	IB_ATTR_GROUP_DEV_ATTR = 0,	/* Device attributes */
+	IB_ATTR_GROUP_DRIVER_ATTR = 1,	/* Driver-provided attributes */
+	IB_ATTR_GROUP_HW_STATS = 2,	/* hw_stats */
+	IB_ATTR_GROUP_LAST,		/* NULL pointer terminating array */
+};
+
 struct rdma_restrack_root;
 struct ib_device {
 	/* Do not access @dma_device directly from ULP nor from HW drivers. */
@@ -2761,12 +2768,7 @@ struct ib_device {
 		struct ib_core_device	coredev;
 	};
 
-	/* First group is for device attributes,
-	 * Second group is for driver provided attributes (optional).
-	 * Third group is for the hw_stats
-	 * It is a NULL terminated array.
-	 */
-	const struct attribute_group	*groups[4];
+	const struct attribute_group	*groups[IB_ATTR_GROUP_LAST + 1];
 
 	u64			     uverbs_cmd_mask;
 
-- 
2.48.1.658.g4767266eb4-goog


