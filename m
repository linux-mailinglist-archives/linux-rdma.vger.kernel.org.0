Return-Path: <linux-rdma+bounces-849-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B057D844D42
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 00:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26A31C234A9
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 23:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40F13A8D6;
	Wed, 31 Jan 2024 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4OZfEWR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D039AE0
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744651; cv=none; b=Csc3KX3SUet725qH6FWUN53fozcT7TSt0CNKUtTYX+SL1Vk5BEIgSaiK5bO2U+fmvbMuh+L1YKzh+dqISIZnPFGPkqbwVwkL1wsz5+RrIfuRxRL06adYed2pQXPTN1D36t8KjgtBtXvlTvn8p1JSuG/RpkjLFdjzZIUP+dOpAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744651; c=relaxed/simple;
	bh=eov5V1lYIiHTfKIu0TKGa4DEC26FvzffHjtMgEjzhpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YpWXZdCVjVXH4uKnnpF4CtsbSJxgVeJv/pmSgZvD4p1boFjtw1426GJ/e5RyQFjpo5a8ASwp562hDw9xKSN2v2se3MUgGJ6au1Z+J/iV/UslmCGcNPDIm6qj60nOfKiAzMqcFqILzq0fuQYAVomEFdnsdB4L7UinVwBgKgx1L5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4OZfEWR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706744650; x=1738280650;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eov5V1lYIiHTfKIu0TKGa4DEC26FvzffHjtMgEjzhpQ=;
  b=M4OZfEWRtPDnaaA6EsI3/QDLdSvfF75WIMEQsSM4UVrffPRs33VWhrAD
   oWOrl0IRgkYdajTHi45qxcRJtk+UNd7LWVRrir4tqyDz3o+15TXyMvTzO
   D3vLQYAbo7DiXUn/S7UEt59GMcw1zxCM6kjhaJ+yxgvLcDgRMRaWJXYDW
   6oerdmCYyzc+dpsk0Y1hIXQgmA6sca4tJ7UjknQQ1RKP/MTL1IVuReJRA
   E2jFYccD9o3jtgSNDWtnY3chPxgig1+wxOez3JErzTTfxOnrLTNXFzLtc
   q/+JxLk5YkifyYfPa778hZfLK82f53MSt/fa71wIVuPjbg02cbTfY+ZBL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10395253"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10395253"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:44:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4209374"
Received: from unknown (HELO SD8036..) ([10.232.218.36])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:44:09 -0800
From: Sindhu Devale <sindhu.devale@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	sindhu.devale@intel.com,
	Mustafa Ismail <mustafa.ismail@intel.com>
Subject: [PATCH rdma-next] RDMA/irdma: Remove duplicate assignment
Date: Wed, 31 Jan 2024 17:39:53 -0600
Message-ID: <20240131233953.400483-1-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mustafa Ismail <mustafa.ismail@intel.com>

Remove the unneeded assignment of the qp_num which is already
set in irdma_create_qp().

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index b5eb8d421988..44b03bc061fa 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -719,7 +719,6 @@ static int irdma_setup_kmode_qp(struct irdma_device *iwdev,
 		info->rq_pa + (ukinfo->rq_depth * IRDMA_QP_WQE_MIN_SIZE);
 	ukinfo->sq_size = ukinfo->sq_depth >> ukinfo->sq_shift;
 	ukinfo->rq_size = ukinfo->rq_depth >> ukinfo->rq_shift;
-	ukinfo->qp_id = iwqp->ibqp.qp_num;
 
 	iwqp->max_send_wr = (ukinfo->sq_depth - IRDMA_SQ_RSVD) >> ukinfo->sq_shift;
 	iwqp->max_recv_wr = (ukinfo->rq_depth - IRDMA_RQ_RSVD) >> ukinfo->rq_shift;
@@ -942,7 +941,7 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	iwqp->host_ctx.size = IRDMA_QP_CTX_SIZE;
 
 	init_info.pd = &iwpd->sc_pd;
-	init_info.qp_uk_init_info.qp_id = iwqp->ibqp.qp_num;
+	init_info.qp_uk_init_info.qp_id = qp_num;
 	if (!rdma_protocol_roce(&iwdev->ibdev, 1))
 		init_info.qp_uk_init_info.first_sq_wq = 1;
 	iwqp->ctx_info.qp_compl_ctx = (uintptr_t)qp;
-- 
2.42.0


