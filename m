Return-Path: <linux-rdma+bounces-846-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659A1844D61
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 00:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4D0B2174A
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63803B190;
	Wed, 31 Jan 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbeckFxL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2392D39FE9
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744585; cv=none; b=G07SFc8cFqSNDYHsVNY2kJFwHcLVRVrErltwUQxsay86ynjfu8flJyHoASlVVPZi4NX/ETj18zyc/5zydULoMmixVuGsuF0c0zLyOFCFYzuuFGKKwCEuVgBpg7mEmzYCN6+sAwiHIjY7eUgMIaUVs818aFTyeB6Qj4wlrtumns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744585; c=relaxed/simple;
	bh=Oj5aizfZnYsxSt+rBl1W51krahFL3hMOPoariyTjknU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2fII8Nl2S1EqRPo4dQ1XIK3E/dTv69DxaPGbHcgydqQC8LamZzqpKDkmBaVxnksiAH20ZOGRZZiD0ulN56Nw7K6kcqvfNsfB7/+/gRuHP06v7oYnyxaBODzzL3UKlhTC1V75M1M+z6x5VpfQM/mxzLSbsdaWXp01vulD5vwaeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbeckFxL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706744584; x=1738280584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oj5aizfZnYsxSt+rBl1W51krahFL3hMOPoariyTjknU=;
  b=jbeckFxLkZZOc7xAJ0m4ICdWqCmrei6zLmDNhB0BLHT/Y8NaQd4Wx0wz
   eoqgYXHNL5iTHDa9SdqHC7//qm4Gc6GRok+z/RrzpNsbYYjLmaeuYIFCb
   E9kTTM3S1NUdJyiq4WSIJmyNOwUenDcJxIhV6zSikyFxiE1bIaFHBegk1
   gRawGTF6S4FXspTDC75nclgEIz50ouRzDz3FbGWRy7NJphUWAmX3l9qj2
   Sjjc/+5YqoyAlCLmm2G0xoRtguXFswkmBDu8gZzXTCEEKq/P14HX3VKIa
   W5/MnIwFeK9bszEdrCPW4OOmJDNFmUVvi3tnLc+D+tzZkxQU0PIngecRT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22260035"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="22260035"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:43:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4338985"
Received: from unknown (HELO SD8036..) ([10.232.218.36])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:43:03 -0800
From: Sindhu Devale <sindhu.devale@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	sindhu.devale@intel.com,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc 2/4] RDMA/irdma: Validate max_send_wr and max_recv_wr
Date: Wed, 31 Jan 2024 17:38:47 -0600
Message-ID: <20240131233849.400285-3-sindhu.devale@intel.com>
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

From: Shiraz Saleem <shiraz.saleem@intel.com>

Validate that max_send_wr and max_recv_wr is within the
supported range.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Change-Id: I2fc8b10292b641fddd20b36986a9dae90a93f4be
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index b5eb8d421988..cb828e3da478 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -839,7 +839,9 @@ static int irdma_validate_qp_attrs(struct ib_qp_init_attr *init_attr,
 
 	if (init_attr->cap.max_inline_data > uk_attrs->max_hw_inline ||
 	    init_attr->cap.max_send_sge > uk_attrs->max_hw_wq_frags ||
-	    init_attr->cap.max_recv_sge > uk_attrs->max_hw_wq_frags)
+	    init_attr->cap.max_recv_sge > uk_attrs->max_hw_wq_frags ||
+	    init_attr->cap.max_send_wr > uk_attrs->max_hw_wq_quanta ||
+	    init_attr->cap.max_recv_wr > uk_attrs->max_hw_rq_quanta)
 		return -EINVAL;
 
 	if (rdma_protocol_roce(&iwdev->ibdev, 1)) {
-- 
2.42.0


