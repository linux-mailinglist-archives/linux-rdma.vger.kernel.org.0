Return-Path: <linux-rdma+bounces-9462-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 655DCA8AE00
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 04:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B380F1901F3A
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 02:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1B1624DD;
	Wed, 16 Apr 2025 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcxlQSuu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4222F11;
	Wed, 16 Apr 2025 02:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769773; cv=none; b=clVtiN8ar0MtTd5UFBcIziwvA24vW6KGNz9n0dNltE6vKIOw/HecKTQ6/SpZL2ugjOmYQ356g58cHmJ7Fur5byzzHPPGo2VdkXHadkT9eixCTFNsjC45w7AEggLscQjvfdGKOaFa+5tDveMLvM5Bo7UB1m4CX3/4SOKh9w9D8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769773; c=relaxed/simple;
	bh=igbLN6YEauLxV1FxrClG0VZk6wS5aG4GlZD9dd2WrU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ui9o8ySrsc3MF/15Uql6j3OW3TnLBSyeni93zYz7Cahtoy44yO5b1NzyhdKQ+n2BXxZmwV4A0spLQVuOQBbGbUdqZWLyBlej094zGBRz17mwizhohiWDDxRYBJ+4ArRpok7EMlCdwgP7oQ01tkGeu6nUznUfGFnRAHqrpl5MCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcxlQSuu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744769772; x=1776305772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=igbLN6YEauLxV1FxrClG0VZk6wS5aG4GlZD9dd2WrU8=;
  b=YcxlQSuu1c/5OQo9kwUZh3X3NKxBym4tHPQoXMXgQl6dt9S+nrYxKa61
   HnIS8ovqarZvalLxIZkTs8gEDdJeOI/AUVRpsZtHDBp50rHENSJS0rRJf
   BlfnxoDp+IGJAMZktPjia5A3DyU1wc2eH6Kla0IuvtME/nQque2wIHdvj
   0qdZrJZhxYKQGTCCMT4S2fb8J/Pq7X6xhpwf2QFK8syUTfs3lXfXYHUQU
   P2kxUQABIcb45e4QA7lic6Yu6y0En4X3CGpWsZJa4SmgUB/Lke3vAf1a0
   DvAGhRtOGm+F/7RwK/zpwDVbgkThg5XXJTWRN3GSTDC6RH4FBr+6JFslX
   Q==;
X-CSE-ConnectionGUID: r564wF8mR7KprvsgK1204A==
X-CSE-MsgGUID: 8IvmXdO6RBmaKcWMkHQ5aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50125551"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="50125551"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 19:16:11 -0700
X-CSE-ConnectionGUID: x/ISpcDZRkiwnOOAhxYGEw==
X-CSE-MsgGUID: p4m+Hoz5TmWraD5vmKhY2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130605788"
Received: from bnkannan-mobl1.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.114.218])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 19:16:11 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [iwl-next v5 0/5] Refactor to prepare for Intel IPU E2000 (GEN3)
Date: Tue, 15 Apr 2025 21:15:44 -0500
Message-ID: <20250416021549.606-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To align with review comments, the patch series [v1] introducing RDMA
RoCEv2 support for the Intel Infrastructure Processing Unit (IPU) E2000
line of products is going to be submitted in three parts:

1. Modify ice to use specific and common IIDC definitions and
   pass a core device info to irdma.

2. Add RDMA support to idpf and modify idpf to use specific and
   common IIDC definitions and pass a core device info to irdma.

3. Add RDMA RoCEv2 support for the E2000 products, referred to as
   GEN3 to irdma.

This first part is a 5 patch series based on the original
"iidc/ice/irdma: Update IDC to support multiple consumers" patch
to allow for multiple CORE PCI drivers, using the auxbus.

Patches:
1) Move header file to new name for clarity and replace ice
   specific DSCP define with a kernel equivalent one in irdma
2) Unify naming convention
3) Separate header file into common and driver specific info
4) Replace ice specific DSCP define with a kernel equivalent
   one in ice
5) Implement core device info struct and update drivers to use it

This patch series is based on v6.15-rc1.

Changelog:

V4 to V5 changes:

- Use exported symbols instead of a device ops struct
- Rename the IDC header file iidc.h to iidc_rdma.h
- Move ice specific functionality to iidc_rdma_ice.h
- Use iidc_* naming convention
- Replace ice specific DSCP define with a kernel equivalent one

V3 to V4 changes:

- Split up the patch series [v3] into three parts and
  send out independently the ice/iidc related changes patch -
  "iidc/ice/irdma: Update IDC to support multiple consumers" 

[v4] https://lore.kernel.org/all/20250225050428.2166-1-tatyana.e.nikolova@intel.com/
[v3] https://lore.kernel.org/all/20250207194931.1569-1-tatyana.e.nikolova@intel.com/
[v2] https://lore.kernel.org/all/20240824031924.421-1-tatyana.e.nikolova@intel.com/
[v1] https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/

Dave Ertman (4):
  iidc/ice/irdma: Rename IDC header file
  iidc/ice/irdma: Rename to iidc_* convention
  iidc/ice/irdma: Break iidc.h into two headers
  iidc/ice/irdma: Update IDC to support multiple consumers

Tatyana Nikolova (1):
  ice: Replace ice specific DSCP mapping num with a kernel define

 MAINTAINERS                                   |   2 +-
 drivers/infiniband/hw/irdma/main.c            | 125 ++++++-----
 drivers/infiniband/hw/irdma/main.h            |   3 +-
 drivers/infiniband/hw/irdma/osdep.h           |   2 +-
 drivers/infiniband/hw/irdma/type.h            |   4 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  45 +++-
 drivers/net/ethernet/intel/ice/ice.h          |   6 +-
 drivers/net/ethernet/intel/ice/ice_dcb.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  47 +++-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   9 +
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   8 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      | 204 +++++++++++-------
 drivers/net/ethernet/intel/ice/ice_idc_int.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  18 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +-
 include/linux/net/intel/iidc.h                | 109 ----------
 include/linux/net/intel/iidc_rdma.h           |  68 ++++++
 include/linux/net/intel/iidc_rdma_ice.h       |  70 ++++++
 19 files changed, 449 insertions(+), 288 deletions(-)
 delete mode 100644 include/linux/net/intel/iidc.h
 create mode 100644 include/linux/net/intel/iidc_rdma.h
 create mode 100644 include/linux/net/intel/iidc_rdma_ice.h

-- 
2.37.3


