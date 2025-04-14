Return-Path: <linux-rdma+bounces-9434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40A0A8903A
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 01:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCFC3B1187
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 23:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7E81FA272;
	Mon, 14 Apr 2025 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mD46xeOc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78911F5616
	for <linux-rdma@vger.kernel.org>; Mon, 14 Apr 2025 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744674237; cv=none; b=kGxW2QxB/0+lkX+usk14DtQrgGXRoV7+eqrtxF4W+W0qgsykuQY1/pmanRU5GQwnmYa2G8BD5/iZgaHynJqmNet7zVy3TrGG71JlCBpqDpy+odsknLX3reSJRjyAz6CE8eE/OOZKXFYSk3t5i2oYCHM77M2i1GZhxehAbCeIC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744674237; c=relaxed/simple;
	bh=RmpGJtKq2jCQjyf920xVrCoprltAsMHmH0FotKyACzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCfJhpzOxmbAupZF2JOi5uYqzV/gfDF7ixPe5XuyRyLuluePpZSFixNI1lrr/JNnZgbuMWkD+PrLxl9Wwh2syZlgP0FMO4YIBwgpFI+tqEKbvyPudOmjR0+/w5/RQlrUT+KBraSofIezwmjL4kEzp8Iw3IOYjzLavBx8eqR9y7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mD46xeOc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744674235; x=1776210235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RmpGJtKq2jCQjyf920xVrCoprltAsMHmH0FotKyACzI=;
  b=mD46xeOcQbM26lU/BWg6Cuk00HZg5FoSajWl8MrZsGW/fOBMdV0GRlm8
   6pP8/HcsHtYqsJdiRgghGSkIYFjULQk0H77VRHd3dUtlEHxT9NHT7Lek+
   0tq6AJDatplhiytvsI8jY1/0C2I6zxzEjT1TkllZ7vC7UMIEDS3YszacJ
   ETYA2OQ/EKiwFdPAu0ZJZbiK6ybzzcsCmF4n3ytuKE243KkJzTRCW30JT
   lZ694UYt2OWgGaW/yCTGoKaUwIlKtfwoz+vV7c/6M/K0IIDDjo98uTuTl
   bYG4N6TOsFgR7r6MQvgWMyhyoGSVCmNWAZuNNdy3/1wbJDD/MIHx5gNMb
   Q==;
X-CSE-ConnectionGUID: jTdqrKklTD6o5ud/p/4dGg==
X-CSE-MsgGUID: QgFvw6O0R3Os2FskPo40Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46074091"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46074091"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 16:43:53 -0700
X-CSE-ConnectionGUID: b5HqgqpTSLCdC5b+oZfyvg==
X-CSE-MsgGUID: h9ZXBrMdSIePP6MSP/lVWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="153135583"
Received: from bnkannan-mobl1.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.114.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 16:43:52 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH for-rc 2/2] ice, irdma: fix an off by one in error handling code
Date: Mon, 14 Apr 2025 18:42:31 -0500
Message-ID: <20250414234231.523-2-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250414234231.523-1-tatyana.e.nikolova@intel.com>
References: <20250414234231.523-1-tatyana.e.nikolova@intel.com>
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
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index d10fd16dcec3..7599e31b5743 100644
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
2.31.1


