Return-Path: <linux-rdma+bounces-8384-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18363A50E3C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 22:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3649C16A734
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 21:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F34E265CAD;
	Wed,  5 Mar 2025 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wgh+wyVe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D3265626;
	Wed,  5 Mar 2025 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211890; cv=none; b=kwXcoOaY7snzjgrNo90Lw/SdFeY9EGa3JiMt1IG1q3e0RYL7/GI0MXV5TxEvtaA+TBDwxaxMXMZi2DJtlcY724Itbz6LJ+CzuLpC9UZL+cpEiWpxTvQlZTWhMKiJO2mBcqL4T3pMNq+7BY8n5CHmaOmYBoAlB4SSmr4R8612nH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211890; c=relaxed/simple;
	bh=p6yLNxB6AEQQRxBA+8RH4XuP3uDaZMNLWaAcrErt+6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxELlYWAMwwU8AVHiGbXu7s+D5I8fUIZ64EF5rhLwORlKIKcGMFOxIJlgnBgN8NMzwx2LrqjOAiPcwN1iTIWWkSQed8aWXtVl9do5hshYbCL4PbSqQZ82QxVk1qJSfrr1Yt4PQfIyAkebz42FNz3wes1D0L2h/AQ6OfgrACRP9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wgh+wyVe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741211889; x=1772747889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p6yLNxB6AEQQRxBA+8RH4XuP3uDaZMNLWaAcrErt+6M=;
  b=Wgh+wyVeKqZhjRs+5LWVLs0qjxC1I7xIubI6h+V59ueu6D44OVNj9m10
   JVWboXK/kVVkZVMdd2Xo8S+SyYQj2TpoW8t+sHRUhPX0XUnCbkYcjzmbj
   N8cRj3Mok+ylrkg3BHHpr5tJhXwXF/zyv5NLnqpKoXS1R0jzT0hoSZ9A8
   Lp9/0Mi9shM1EcXr+trEtm4Es99L3+GqS7AXWkutuHclHpaAGqtwops2R
   7XaIbKDYxIZnJXLUYpO8Ah30FYrjIgquOOnuNTfovhBmF66M9Ns0m05+I
   TbveX4s3+gJsej8MXJ8KtMgN6sbRO+htL//Ywg55Af4SZIkffl+6c2uMn
   w==;
X-CSE-ConnectionGUID: /Lu1r38CT9O9HXPaUz7NAg==
X-CSE-MsgGUID: BqLo6NOOTZGzeoaNzyxeKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29782156"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="29782156"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 13:58:06 -0800
X-CSE-ConnectionGUID: N43XDm/pThuzAeDELzNDcA==
X-CSE-MsgGUID: v2JHils4R0eoSuaclvrYHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118741661"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2025 13:58:05 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jacob.e.keller@intel.com,
	tatyana.e.nikolova@intel.com,
	leon@kernel.org,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next 1/2] ice, irdma: fix an off by one in error handling code
Date: Wed,  5 Mar 2025 13:57:52 -0800
Message-ID: <20250305215756.1519390-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305215756.1519390-1-anthony.l.nguyen@intel.com>
References: <20250305215756.1519390-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

If we don't allocate the MIN number of IRQs then we need to free what
we have and return -ENOMEM.  The problem is this loop is off by one
so it frees an entry that wasn't allocated and it doesn't free the
first entry where i == 0.

Fixes: 3e0d3cb3fbe0 ("ice, irdma: move interrupts code to irdma")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/infiniband/hw/irdma/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 1ee8969595d3..5fc081ca8905 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -221,7 +221,7 @@ static int irdma_init_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
 			break;
 
 	if (i < IRDMA_MIN_MSIX) {
-		for (; i > 0; i--)
+		while (--i >= 0)
 			ice_free_rdma_qvector(pf, &rf->msix_entries[i]);
 
 		kfree(rf->msix_entries);
-- 
2.47.1


