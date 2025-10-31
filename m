Return-Path: <linux-rdma+bounces-14156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B509DC22F78
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 03:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8267B4E2256
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 02:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047EB2741CD;
	Fri, 31 Oct 2025 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlTrP49Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509112749C4
	for <linux-rdma@vger.kernel.org>; Fri, 31 Oct 2025 02:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877089; cv=none; b=GDium3tCA42RO2hzxIEYckKJtwN2uc9+ugDIrGAhHnyIgbJhb9wPcZmiYz3Dx1Wb94/2z2BFiwxe/jDdr/I+8ALObC/HqEx80pLRyWX4tJ24RtWWgfD9VbmOFopWI1898ENLlq2aphaEBPr5r3Pqx7PKDB43IXP0a2UeNPldsdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877089; c=relaxed/simple;
	bh=wD2bMmgXO5sVr/bS7AChoo7QbTPz8atN5YS8Gjv5MSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wf39cWnoMsq0BaJWaBTit0Tcxjcfipd3ldZGXwkK5HMCBzZ1ionnHyG8Frc8/Y13r5RTMznst/jfMX6kngYtYJfy5QbOlFo4QsvOsHSnWwmC6gD80S2dNtUA/t7ncN0dB9bcnsvXYMHoLGGdYRgrzCh2lQn/Bc9JFlLxbCYTy54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlTrP49Z; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761877089; x=1793413089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wD2bMmgXO5sVr/bS7AChoo7QbTPz8atN5YS8Gjv5MSg=;
  b=hlTrP49ZvSPXcNLP2AcYfwR+QRVPQ9UvmNmJPwKMQk5NUbno0XXcLYLf
   aYkSa1VBxkNU+13zKr+YcVdyJTXkMFQPlimSsMqpvY1F8pC0xPlJkAKx5
   XKakSI8i4taE9yXHj308+KYOQhvz7MVdVZCG0KFkX+BWvg4Mluuu8hWJC
   n8fTAWN94xmQSRqbEBIZyVBWaUYpBFv996d22lqhTfccNdEMY6w0lWs7A
   u/y9PPWszygWBm0VsvmtinzVmKJlUiq8Olw+0wOhRtvpCj+QEX7BDfvZh
   8bBWoNshfoB/IcklXGlpsKTKDIUEC1uY9d8xevHglj1o5TEb+kwoLZYET
   g==;
X-CSE-ConnectionGUID: Qz4831mmRS+iJwnSSNVoMw==
X-CSE-MsgGUID: EP3MeWW8TayELQVgWylcew==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64182220"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64182220"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:07 -0700
X-CSE-ConnectionGUID: bgITJ/UZRaG389hzZkEOlQ==
X-CSE-MsgGUID: Z+9yM6ZNT3yX4wfWutrX8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="216950187"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:06 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	krzysztof.czurylo@intel.com,
	Jay Bhat <jay.bhat@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH] RDMA/irdma: Fix vf_id size to u16 to avoid overflow
Date: Thu, 30 Oct 2025 21:17:25 -0500
Message-ID: <20251031021726.1003-6-tatyana.e.nikolova@intel.com>
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

Correctly size the vf_id to u16 to avoid overflow.

Signed-off-by: Jay Bhat <jay.bhat@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 4ae77cdde9dc..c1b8f81ea283 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -706,7 +706,7 @@ struct irdma_sc_dev {
 	u32 vchnl_ver;
 	u16 num_vfs;
 	u16 hmc_fn_id;
-	u8 vf_id;
+	u16 vf_id;
 	bool privileged:1;
 	bool vchnl_up:1;
 	bool ceq_valid:1;
-- 
2.31.1


