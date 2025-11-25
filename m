Return-Path: <linux-rdma+bounces-14740-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA03BC83244
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 03:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4402C34301F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 02:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CDD1C84D7;
	Tue, 25 Nov 2025 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNCHzkUV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8A18DB2A
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039298; cv=none; b=hp7fkcI7NYrPssgarDf9k49nISa6w7f1MBCkN7UJwAsIGoM8MRofDaZWrft98VL1XWmc7vFceMjb/JN3EWp2/8oKfVAsmk15e4G7mB7yIx32aLXHSUzFUimC+eWOtp4Z4tF/ZuxiHtNMcuvg8ltfzH+TS77E3SPWJH5Ga/vsB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039298; c=relaxed/simple;
	bh=IM/SZuKn9uwC+C4YDv0EaCQJL3bq2RtC3/NZaBknJo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPzvVoV8+MlOF3tJCUPy1JjO9TSqYPoNHV3oLc58ZdVwnizKqYp4zGf7AQHs6THcFmuc8Y6jO9xH8Sx3cNb5fQyfi+9Jy3rrEoiwjWdzL+4UMKiOiRTKM5+RKpTrOj9/v5aEBsSQgZhDAXhA3N7FpIMbSYtdxWa0f05mZmFYiHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNCHzkUV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764039296; x=1795575296;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IM/SZuKn9uwC+C4YDv0EaCQJL3bq2RtC3/NZaBknJo8=;
  b=nNCHzkUVsGe08smO4U6LYiUfMz6Wrv/CsbKr0RhJUt3q6n/i76NlrgOJ
   CYCQInptD0bKwzqa2QrDAX+suL/Umwm2uC8yDDyKKnjo9WKTdWrOse5nf
   rrqUNGP9wQFRBEDkpzdygPp4XgauJ/Txji27yd06Q5K07Gn9RWvHdqXoj
   RklifIp5agWE/lNg4nCXqVYiLnfHApfsBJ6dB1Kf/CN/HKqVpoJDqVJ6i
   6csJ7/ouzEQznYPFjGR2fTH0/ZpWPPPfypqNgdid6Z8Cb9FotR1GsEi1v
   GwzEJWAfVBV0HSxAsY1kkHhNw3lYQgFp8fgAJ3x7XRV8Wko1w87kmIHIB
   w==;
X-CSE-ConnectionGUID: RxoPjMoiT6qf/+XEFXtPGg==
X-CSE-MsgGUID: HXgVLpYwQ62skGxQ+C193Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65942177"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="65942177"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:56 -0800
X-CSE-ConnectionGUID: fzLoJ+rBR4GFhiW7fDiXHg==
X-CSE-MsgGUID: VnkzoCOaQ9uLrKigmluUkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="196800259"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:55 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	jmoroni@google.com
Subject: [PATCH 0/9] RDMA/irdma: A few fixes related to GEN3 Support
Date: Mon, 24 Nov 2025 20:53:41 -0600
Message-ID: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes a few fixes found after the addition of GEN3 Support.

Anil Samal (1):
  RDMA/irdma: Add missing mutex destroy

Jacob Moroni (3):
  RDMA/irdma: Do not directly rely on IB_PD_UNSAFE_GLOBAL_RKEY
  RDMA/irdma: Do not set IBK_LOCAL_DMA_LKEY for GEN3+
  RDMA/irdma: Remove doorbell elision logic

Jijun Wang (1):
  RDMA/irdma: Fix SRQ shadow area address initialization

Krzysztof Czurylo (3):
  RDMA/irdma: Fix data race in irdma_sc_ccq_arm
  RDMA/irdma: Fix data race in irdma_free_pble
  RDMA/irdma: Fix SIGBUS in AEQ destroy

Tatyana Nikolova (1):
  RDMA/irdma: Add a missing kfree of struct irdma_pci_f for GEN2

 drivers/infiniband/hw/irdma/cm.c         |  2 +-
 drivers/infiniband/hw/irdma/ctrl.c       |  6 ++++-
 drivers/infiniband/hw/irdma/icrdma_if.c  |  6 ++++-
 drivers/infiniband/hw/irdma/ig3rdma_if.c |  4 +++
 drivers/infiniband/hw/irdma/main.h       |  2 +-
 drivers/infiniband/hw/irdma/pble.c       |  6 +++--
 drivers/infiniband/hw/irdma/puda.c       |  1 -
 drivers/infiniband/hw/irdma/uk.c         | 31 ++----------------------
 drivers/infiniband/hw/irdma/user.h       |  1 -
 drivers/infiniband/hw/irdma/verbs.c      | 24 ++++++++++--------
 drivers/infiniband/hw/irdma/verbs.h      |  3 ++-
 11 files changed, 38 insertions(+), 48 deletions(-)

-- 
2.31.1


