Return-Path: <linux-rdma+bounces-848-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA770844D3F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 00:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710AF290A93
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 23:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DCF3A8CB;
	Wed, 31 Jan 2024 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlUTuOPb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08E3A8ED
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744586; cv=none; b=QbRuhb879mpP0DyYzAMMjlVZ84+oRPEBGH7xVhUh6ZuzqyniW8WYfx6wbxkkKGFGjyImBkl2mvSX/MObhtPNAXJv37mdgLqK9/NdCF0gZKmeQmjV42yw6gWtb3fQOFdDDldjvVu738JfUx4V3K7rzypFIss8uh9d1f0szh7zaNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744586; c=relaxed/simple;
	bh=mZTdSU/kYCqtNHLHgL4sibxzjJWig1ln3S0QICmtKN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XflEXz5Qlfoics5fKiaCL1zxbhQkcjg/wXOKeQs1d5UkblSkZ68nB/hPEQzw9S8bKEFEYswazOYITG193Zuc8WigA7ciV30imt508fOO9MWr2KW/HVPY17h1/FUfCGYW2c1ao5el/OxxInS8P9FTTuPaXdqo2QyiS/k77Bb2sAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlUTuOPb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706744585; x=1738280585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mZTdSU/kYCqtNHLHgL4sibxzjJWig1ln3S0QICmtKN0=;
  b=IlUTuOPb+tDuf1FuUuxEqfnmEMxWJNRH0XMCYso7fD10xb6cOqYyqBQs
   whIQhSeQxHCccsGOU39ISbEMbZjWvfeTXPHWwMnrSW8udX1Qz0opQeFrY
   nfxMfrUKNLe/dcUYYnMTedN0/ZUirsZNzbW3moUGk8XNJa6RRvFgtmmqe
   gesvd87E3PA4nZoLFj3xByNWMZtEKDjGec25HDSzHy52ZUJI9S+tz//uu
   AOpxk+hqqvBg2Yfzciik0dsnLcPLLBxAq5AkEMPlZ04q4wF9v3nyI/BT1
   9q21saqPKALsgo3c2+bU7QCgwY2K+TSBs2S9iyyN8zikfewLW0Hh7ioj4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22260042"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="22260042"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:43:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4338994"
Received: from unknown (HELO SD8036..) ([10.232.218.36])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:43:04 -0800
From: Sindhu Devale <sindhu.devale@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	sindhu.devale@intel.com,
	Mustafa Ismail <mustafa.ismail@intel.com>
Subject: [PATCH rdma-rc 4/4] RDMA/irdma: Add AE for too many RNRS
Date: Wed, 31 Jan 2024 17:38:49 -0600
Message-ID: <20240131233849.400285-5-sindhu.devale@intel.com>
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

Add IRDMA_AE_LLP_TOO_MANY_RNRS to the list of AE's processed
as an abnormal asyncronous event.

Fixes: b48c24c ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@gmail.com>
---
 drivers/infiniband/hw/irdma/defs.h | 1 +
 drivers/infiniband/hw/irdma/hw.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index 8fb752f2eda2..2cb4b96db721 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -346,6 +346,7 @@ enum irdma_cqp_op_type {
 #define IRDMA_AE_LLP_TOO_MANY_KEEPALIVE_RETRIES				0x050b
 #define IRDMA_AE_LLP_DOUBT_REACHABILITY					0x050c
 #define IRDMA_AE_LLP_CONNECTION_ESTABLISHED				0x050e
+#define IRDMA_AE_LLP_TOO_MANY_RNRS					0x050f
 #define IRDMA_AE_RESOURCE_EXHAUSTION					0x0520
 #define IRDMA_AE_RESET_SENT						0x0601
 #define IRDMA_AE_TERMINATE_SENT						0x0602
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 2f8d18d8be3b..ad50b77282f8 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -387,6 +387,7 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 		case IRDMA_AE_LLP_TOO_MANY_RETRIES:
 		case IRDMA_AE_LCE_QP_CATASTROPHIC:
 		case IRDMA_AE_LCE_FUNCTION_CATASTROPHIC:
+		case IRDMA_AE_LLP_TOO_MANY_RNRS:
 		case IRDMA_AE_LCE_CQ_CATASTROPHIC:
 		case IRDMA_AE_UDA_XMIT_DGRAM_TOO_LONG:
 		default:
-- 
2.42.0


