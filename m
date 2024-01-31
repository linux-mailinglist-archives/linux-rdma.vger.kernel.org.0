Return-Path: <linux-rdma+bounces-847-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C5C844D3E
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 00:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E634290A4A
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 23:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994E91E48B;
	Wed, 31 Jan 2024 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AH8VR3tW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3BB3A8CB
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744586; cv=none; b=rovFbmsV7Y4ZyQqESzE007ylocwaxwVYb7unbf8GWThUh+qzTLrubVh1vUbp0FfwG9Tvgt4cPM69xdVxcohKWl7XXQTuYkjaXHV+J994DYRCXoH84Mt7o0lKKdGx7XuzLxjvcZFATSBo2CzabRzU/oaYvDX3kiMh7AUjyGZlmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744586; c=relaxed/simple;
	bh=5ronuqEq7LM+9fodu/40dH5JPKYbWIaePM1e0d5T+HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwMYMi5zPbSBtKX6CC1Hk6a+PnpLLvpVXVMtRbLnu68eWrAryEt7Un4ff10GGteYXT+C8sZho6IBQmFwKuqAZGs8bJQd08AJfPKm2z0XQ22dZ2EmPFfR11eat76W/A8xG7Kg35WnEQqpQASmqqg0b0Ftg+91oN9bEM7/qRNjjW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AH8VR3tW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706744585; x=1738280585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ronuqEq7LM+9fodu/40dH5JPKYbWIaePM1e0d5T+HM=;
  b=AH8VR3tWWsFx5FuukCQhUYpBoeoixTZ1LfSvU54t8rhKoI6PHinrLpCW
   ZvvzgAqdarC24slDlt/CbV2ALe7+GbX2RfZISRkShExB3Rj9K+jcxaxDn
   JTW5kd+MYA9/yNrulQIzuD18bQYr7iquw4OIcDrOASRyd2c4kOyrGpheZ
   fs5TtHqnLDDxqVKrzvWAMXbU119cCxGDGuRjoSyhVM8UTvLLUerBKmqLT
   +46UHOh1B1xx5WfVLbSPVUfzmWoe0eOTw3eoSIZVnTbZEBf+ILlTWvY/8
   P+Chn2xHcoeVTyBbV6Nzpi7Vx6IZwHScB69XT+kGZx+GSPsO+624VtPrS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22260039"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="22260039"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:43:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4338991"
Received: from unknown (HELO SD8036..) ([10.232.218.36])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:43:03 -0800
From: Sindhu Devale <sindhu.devale@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	sindhu.devale@intel.com,
	Mustafa Ismail <mustafa.ismail@intel.com>
Subject: [PATCH rdma-rc 3/4] RDMA/irdma: Set the CQ read threshold for GEN 1
Date: Wed, 31 Jan 2024 17:38:48 -0600
Message-ID: <20240131233849.400285-4-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240131233849.400285-1-sindhu.devale@intel.com>
References: <20240131233849.400285-1-sindhu.devale@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mustafa Ismail <mustafa.ismail@intel.com>

The CQ shadow read threshold is currently not set for GEN 2.
This could cause an invalid CQ overflow condition, so remove
the GEN check that exclused GEN 1.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index cb828e3da478..0b046c061742 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2186,9 +2186,8 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 		info.cq_base_pa = iwcq->kmem.pa;
 	}
 
-	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
-		info.shadow_read_threshold = min(info.cq_uk_init_info.cq_size / 2,
-						 (u32)IRDMA_MAX_CQ_READ_THRESH);
+	info.shadow_read_threshold = min(info.cq_uk_init_info.cq_size / 2,
+					 (u32)IRDMA_MAX_CQ_READ_THRESH);
 
 	if (irdma_sc_cq_init(cq, &info)) {
 		ibdev_dbg(&iwdev->ibdev, "VERBS: init cq fail\n");
-- 
2.42.0


