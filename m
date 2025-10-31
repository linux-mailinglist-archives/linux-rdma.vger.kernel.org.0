Return-Path: <linux-rdma+bounces-14154-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AECDC22F72
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 03:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 258BD4EAE47
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 02:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D33E273D73;
	Fri, 31 Oct 2025 02:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyAa//GT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9895F1ADFFB
	for <linux-rdma@vger.kernel.org>; Fri, 31 Oct 2025 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877088; cv=none; b=JyxogLs52Zk8O3PtpQ3hAmADEFNxLyki8J9GpVNObsF6Vzhrd0Zxb2ddFSZ7P/eBilBWhpPZZPf6nWsAdYlfHQfLkh2+i2sBzen4tBiiAeyyXYcpC3gCfRC6LXwQbBp7h0kmyeafSIblpK5rsrF1JLMYf8Q1S98G/mOGkj7JMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877088; c=relaxed/simple;
	bh=PFwYGBiRkSMFw6jZ1/l4CJk4nJC3fzbPrY+7YwHcSt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exZBvjbMjXnS51wjjVj2ERDszs5w6rfEK9zPbrad6gxjqttTMl2DlsvnDyjPDDxospcmWfpSiybUZsIRe77Wd+S5khUVy5aMoI+IZyR9Y/wdH9IRIWbRJfBoGQ/VPlDww27SjAKaTePircT+afqBijZsjfghbVFTXKvOHE6wS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyAa//GT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761877087; x=1793413087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PFwYGBiRkSMFw6jZ1/l4CJk4nJC3fzbPrY+7YwHcSt0=;
  b=RyAa//GT05L3dxYlbltCcLGgVBDq3BnPyr6Wlq/aOYUcRhZI0tHDadFo
   inlrPqKNzb4o4UsEhHqci9UKfE48daf4qf33p+5EhLwGpOqhgo3WCRaIz
   vqAKQ6951HfMQ4e/aMPJH3HzoC1wyrA1nDbu9Bvd+PDPyee2PgnP3eg7Q
   085qWsFT+BfRpL20WSpiP9IHwvpVcBbZ2uUpxdsy4EPJGelF+WpTjb1FZ
   nbJcUnd42Uh9+/EQ3zsNLfzPGFW2jwQ9/fBLVlUWpXp6GgvKLQWhE8zZF
   YqM4BYhHXTueOcoCh6dmJKjLVo8wS1bI6dL9xwQS7Ys3+sTs/uRQYdMI2
   w==;
X-CSE-ConnectionGUID: jcp336sCQOOUudvb176Q/w==
X-CSE-MsgGUID: 3Cdaa6XBScaamlATcxtFig==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64182215"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64182215"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:06 -0700
X-CSE-ConnectionGUID: I88Px+foTTaS193uffd+EA==
X-CSE-MsgGUID: u8KV6TU+RX+E0Ci8XlgHgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="216950173"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:04 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	krzysztof.czurylo@intel.com,
	Jacob Moroni <jmoroni@google.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH] RDMA/irdma: Enforce local fence for LOCAL_INV WRs
Date: Thu, 30 Oct 2025 21:17:22 -0500
Message-ID: <20251031021726.1003-3-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251031021726.1003-1-tatyana.e.nikolova@intel.com>
References: <20251031021726.1003-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Moroni <jmoroni@google.com>

Enforce local fence for LOCAL_INV WRs to
avoid spurious FASTREG_VALID_MKEY async events
during heavy invalidation/registration activity.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8a6dd3abec40..9804deba513d 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4073,7 +4073,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
 			break;
 		case IB_WR_LOCAL_INV:
 			info.op_type = IRDMA_OP_TYPE_INV_STAG;
-			info.local_fence = info.read_fence;
+			info.local_fence = true;
 			info.op.inv_local_stag.target_stag = ib_wr->ex.invalidate_rkey;
 			err = irdma_uk_stag_local_invalidate(ukqp, &info, true);
 			break;
-- 
2.31.1


