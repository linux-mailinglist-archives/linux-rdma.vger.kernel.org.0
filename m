Return-Path: <linux-rdma+bounces-844-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A7E844D3C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 00:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B59B1C2087D
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 23:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B63A1CC;
	Wed, 31 Jan 2024 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHNyVIFQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545AF3CF41
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744584; cv=none; b=jpPApkFSfEojjCF5V0D/7BNsu+LCopA8q9XRrVTDAMomtEA662rj8+kN92k2vsqxokV4AnfkPRHppMnQ3va2AB4KoUXg3V3krzAusAsfZz4CSF6fUbFJGsWwCprwPM6hem97dBDmnghvUKhNn9fyZRGm2MVa9xXw9UZDH3iOfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744584; c=relaxed/simple;
	bh=WHtv42L7S/t7hAYz+SPhiKWl7AU4BzxOlY9wUeRbEsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhFesbo1kEqjMuiN4xg3sjFRSqwRSkJ/X850rs5tasLbHY0T5yXefgxu9mjqSgYBFL84h4y3QAhcBp8SQipG1uEgDcdHJoMyJIXFR9orkFQiMmg6JojuX4LzZRRF8QkbXvBBFkDROjHTmiMIYg7AEgPzSOvynwCUuAZyCbAWM9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHNyVIFQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706744582; x=1738280582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WHtv42L7S/t7hAYz+SPhiKWl7AU4BzxOlY9wUeRbEsM=;
  b=IHNyVIFQ7bCTinK0WST6iGW1CJgzUST+DZMpSTl5b0BNwnOK9RMBYpca
   TqCOjkhbWfpa6jAK1upVkJM8I4vDRjxp0udiReoGVtOx0W5gZ3hfnF7uM
   hdlH3SH7jm3ZqZTNuTZh/7RNJN4l+gU4GJ/U6fAnBHaATQDnu914y9fyz
   BIWl0V91wtJIAkF75kFgoPro61U/C1ZOrZz5IvsWpJrA5vpDIu3qrLvGU
   D1hbEZ6Ur5ArqkjgP0prf+dXPPPFoW0lNVpMkobo27k+gHWtO2bu7/4Q2
   8Sgl+uM43lzIbSfufEmppAKS+o5JidStHDA7+H8XTNPQzZwGGVOK1mWh8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22260026"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="22260026"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:43:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4338977"
Received: from unknown (HELO SD8036..) ([10.232.218.36])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:43:02 -0800
From: Sindhu Devale <sindhu.devale@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	sindhu.devale@intel.com
Subject: [PATCH rdma-rc 0/4] *** irdma 6.8 rc fixes ***
Date: Wed, 31 Jan 2024 17:38:45 -0600
Message-ID: <20240131233849.400285-1-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small set of fixes for the irdma driver.

Mike Marciniszyn (1):
  RDMA/irdma: Fix KASAN issue with tasklet

Mustafa Ismail (2):
  RDMA/irdma: Set the CQ read threshold for GEN 1
  RDMA/irdma: Add AE for too many RNRS

Shiraz Saleem (1):
  RDMA/irdma: Validate max_send_wr and max_recv_wr

 drivers/infiniband/hw/irdma/defs.h  | 1 +
 drivers/infiniband/hw/irdma/hw.c    | 8 ++++++++
 drivers/infiniband/hw/irdma/verbs.c | 9 +++++----
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.42.0


