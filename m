Return-Path: <linux-rdma+bounces-21332-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDNZEw4IFmpNhAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21332-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 22:52:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6355DC7A5
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 22:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05EAD3038D3C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 20:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3D03BFACE;
	Tue, 26 May 2026 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTkUmwwG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490D26C3BD;
	Tue, 26 May 2026 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828743; cv=none; b=ubAmbn8+C2CrDdyxKcI8fCmG+AaC4yWQegJGpVg4m4Das8dm2le8/kS901RUttpC30yLvB6Jgx0BZI2WcoD5UgBTRRKR88fy4LI4uj8nxPBjqM6kfZJK6ewQhSZpOdnFK/nfshZcQ6d756PNCTZ7KiKIjgV0u78hwJa6mbMIDHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828743; c=relaxed/simple;
	bh=pUMFUf2AirRQMw6D/5aLUZC+SZEqAJxv2FmS5MDqvII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9MV5M5lPwrVMa6aC9jiZhUJq6pZyXatr61GLIZxVmkt8Y1m/JCWXQ6EoZ3v/ibCCC3Mg37GJq9h127rJ8hhbSykdmG1K8uM4sJg+XiZeXg6sSDGYUbh5FTkes2g9onofIKXWwgF5Gkt4ml0SP9Xqv3Nl6y8gMFilEKUROKdfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTkUmwwG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779828742; x=1811364742;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pUMFUf2AirRQMw6D/5aLUZC+SZEqAJxv2FmS5MDqvII=;
  b=gTkUmwwGdRtdb55UIGf74ztYEv+l38DsiY61XToooat5g1DM0D8aJD/J
   VTqrgIzikAXsYhf6Xn9APH32d4vOfwMeoeg0TbPYjGodvBcp4LBH9/yDs
   idrP6HqZPJ2501t622/f6KHVQ1w+30LOY/3qQZ+hC8U4ge41whDoYCwEx
   FzuSpP7DNjC+1vOcop+cvPsxL1RtgTB2Ei41UbbvQYoppBUaDTxk8jBaF
   y3wbe8NNk0Udc8XiuYhHhrHPainUYaPM5SOvUcS+Td6oLqdcLD5+vw5j9
   HpFmBRNlQKPFEcLW8ukbbIFxv5LLPdqSIspmuxycg1/NV+yKhyVCShJ9v
   w==;
X-CSE-ConnectionGUID: weCAtnswQKeyiViMPH10hQ==
X-CSE-MsgGUID: MmhgHwCnQn+e3fID98jpjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="68179626"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="68179626"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 13:52:22 -0700
X-CSE-ConnectionGUID: pUDKfhfgRRauAkCGuQ8YBw==
X-CSE-MsgGUID: rKMv/p0VStK9grXx82p3Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="280151486"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 13:52:21 -0700
Received: from ray2.jf.intel.com (unknown [10.24.81.183])
	by smtp.ostc.intel.com (Postfix) with ESMTP id 5ED9D6362;
	Tue, 26 May 2026 13:52:21 -0700 (PDT)
From: Dave Hansen <dave.hansen@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Remove bouncing Intel RDMA ethernet protocol maintainer
Date: Tue, 26 May 2026 13:51:40 -0700
Message-ID: <20260526205140.32714-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21332-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@linux.intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:dkim,linux.intel.com:mid,ziepe.ca:email]
X-Rspamd-Queue-Id: 8A6355DC7A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The email for Krzysztof Czurylo is bouncing. Remove the entry.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b423b7a918e41..ac9a298b811e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12900,7 +12900,6 @@ F:	include/linux/avf/virtchnl.h
 F:	include/linux/net/intel/*/
 
 INTEL ETHERNET PROTOCOL DRIVER FOR RDMA
-M:	Krzysztof Czurylo <krzysztof.czurylo@intel.com>
 M:	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-- 
2.43.0


