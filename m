Return-Path: <linux-rdma+bounces-14155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C0C22F75
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 03:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F06D64EAF4E
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 02:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AA3271A9A;
	Fri, 31 Oct 2025 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjJQ55TN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA43272E63
	for <linux-rdma@vger.kernel.org>; Fri, 31 Oct 2025 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877089; cv=none; b=EBrdpkusgx43Y1Ni17YvfOvdko2oQd6GKlI3e23tGuM13CNT7xcTBzStYWrwRtESKXX0RTblfrWduVUfV3BDQgj7VeRPXqoCwGb24XaVKJW6qk4phu/d0RZ1aQjG5nvmMfripZKsXeASDPijzz2Py/h1gC07Gu3OR0NKYDLxXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877089; c=relaxed/simple;
	bh=IY5gy1yTgS1pHhgP7sS0aUpe7XpdnREwX52RCvtJsbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzoRtulFQDyh3QnYwNJ92NukxD7c32iV4k7GHVyxj3Ff7A7P3vRJYq/pni+1s698rlJBypdIiiRR5iF9K4Odx3lS3Dp4/Z4jpDDH5h3M+KxYWyUv5ye5mXKVgo+Xf2PPj3qGvG3X9gonEmD03K9NVM8SBC+7WKgyffmEqL7IypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjJQ55TN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761877088; x=1793413088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IY5gy1yTgS1pHhgP7sS0aUpe7XpdnREwX52RCvtJsbQ=;
  b=VjJQ55TN5h6RqzG9ohVtFRPdgxaPW0FSL3iGbLn8CnsUMjlZG8e7ClgK
   EJ2Jt7pyjpE4o3L65fvPM08LQLi7rYM733Egj6NePDSCWvqbww/pvQ74o
   WZkSNPixbYNXtIahmnL0TuXA1O3PoweNWGwKSo5EDW1yoF17H/d7aNih+
   caUOfwGekdfVLkXs7Aa+bl38yAY+M+xeAKNLWRbFzTxOAwl5m/PDGqYiz
   nP8UsNARwUUoGtR7jeXgPLAsSnRxWy0I0MiUC1ptxxTfF0GGUHvivwae2
   XhefWVh5d4yDqkkc5UsKBRmwm+AWv2xFST0J3EP+r/+ovVK+yCTdIof13
   A==;
X-CSE-ConnectionGUID: OxFqskauRPSyeHMcdgkU5Q==
X-CSE-MsgGUID: M7PgDOBlTXq7wU7c/AL3qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64182219"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64182219"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:07 -0700
X-CSE-ConnectionGUID: vSDXLvWxTN68XtEztuelTw==
X-CSE-MsgGUID: N/l42i/1Ra22blmZznZY1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="216950183"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:06 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	krzysztof.czurylo@intel.com,
	Jay Bhat <jay.bhat@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH] RDMA/irdma: Silently consume unsignaled completions
Date: Thu, 30 Oct 2025 21:17:24 -0500
Message-ID: <20251031021726.1003-5-tatyana.e.nikolova@intel.com>
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

From: Jay Bhat <jay.bhat@intel.com>

In case we get an unsignaled error completion, we silently consume the CQE by
pretending the QP does not exist. Without this, bookkeeping for signaled
completions does not work correctly.

Signed-off-by: Jay Bhat <jay.bhat@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/uk.c   | 5 +++++
 drivers/infiniband/hw/irdma/user.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 54011bffe075..a006e7365f4d 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -194,6 +194,7 @@ __le64 *irdma_qp_get_next_send_wqe(struct irdma_qp_uk *qp, u32 *wqe_idx,
 	qp->sq_wrtrk_array[*wqe_idx].wrid = info->wr_id;
 	qp->sq_wrtrk_array[*wqe_idx].wr_len = total_size;
 	qp->sq_wrtrk_array[*wqe_idx].quanta = quanta;
+	qp->sq_wrtrk_array[*wqe_idx].signaled = info->signaled;
 
 	return wqe;
 }
@@ -1376,6 +1377,10 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 			info->wr_id = qp->sq_wrtrk_array[wqe_idx].wrid;
 			if (!info->comp_status)
 				info->bytes_xfered = qp->sq_wrtrk_array[wqe_idx].wr_len;
+			if (!qp->sq_wrtrk_array[wqe_idx].signaled) {
+				ret_code = -EFAULT;
+				goto exit;
+			}
 			info->op_type = (u8)FIELD_GET(IRDMACQ_OP, qword3);
 			IRDMA_RING_SET_TAIL(qp->sq_ring,
 					    wqe_idx + qp->sq_wrtrk_array[wqe_idx].quanta);
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 81ae738b63ed..6c29fa04e821 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -483,7 +483,8 @@ struct irdma_sq_uk_wr_trk_info {
 	u64 wrid;
 	u32 wr_len;
 	u16 quanta;
-	u8 reserved[2];
+	u8 signaled;
+	u8 reserved[1];
 };
 
 struct irdma_qp_quanta {
-- 
2.31.1


