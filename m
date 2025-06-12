Return-Path: <linux-rdma+bounces-11279-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B10AD7E01
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 00:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AE03B3379
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 22:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8612DCBF5;
	Thu, 12 Jun 2025 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFxyi2ax"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81D2F4325;
	Thu, 12 Jun 2025 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749765620; cv=none; b=liKs4AhQJFuw9dSTWN66U3NFkVyotyKBQbDI3BhVFiKn7KJpCJ6sVH1ZILrTolIc67a7YKEvvNdMUpgztl/yqf/OpqzqI25Oq0IVzYTMYrWJSWhn9tJdZJks6mPA06Jv0p1PWq0VesqeRqLcwcWRqPdlMJgjcs5SMRGe+bfS/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749765620; c=relaxed/simple;
	bh=Yn9phey9bqAiHFmyBz3Povli4APEk34jXJQdbpqV9lI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgUDJUQxvDqwqJa+eqS0KhE9KV3925/Des/fN7SEpbDQRecGnGAnK6CjatW6kbhWj3EvYpiQbxDSlp0SrtTK9wmjprTGiUTfnBTI5QtE/H55gZg5LPdtLPA7uCMe9I+WIYrHsWFsdT+bwfA3xeszC+HCP3C0cxWdCmRZ7kDTWi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFxyi2ax; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749765618; x=1781301618;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yn9phey9bqAiHFmyBz3Povli4APEk34jXJQdbpqV9lI=;
  b=DFxyi2axob3Q/gA7nR1U4pBZdH8vd1TRdRSrL+p0LRHwy4JdS23dzNpR
   xkgmRBkeKSD43f1h0zqetIjaICrymBbmE8vPhMlT2OZHW+u5np8P6th3h
   H2GqgUq9E/TjwNPcJ9oJAkZJlLVheGfbOwdEP8qQ8m9a/pK3ZNO1TfYbn
   x+K/l2C4LKrf4Rig2VqbG9Hbu4hditD19+NkT4Vm/DzSwDSiCns++KZVs
   zqHnTP/ZVAdIiYH3LRZDKwkq8SEP4VDNAoMHNakaPtMwojJAYgn8Jg6h0
   OiXabcusQhBMv9nD2gFdSRiQzGt+L9Rm49hhmWTgqPR5BQwwggXSqUdhe
   g==;
X-CSE-ConnectionGUID: VyIQe9TdQaesZHqFweY5QA==
X-CSE-MsgGUID: /cqkiSsrS6GQ1gwALKbMEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51078251"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="51078251"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 15:00:18 -0700
X-CSE-ConnectionGUID: 8tBik7dNRJa+BRcL0p5WIA==
X-CSE-MsgGUID: moOzaooKQvmuuFAUHnY+FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148004195"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 15:00:17 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jgg@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [iwl-next v2 0/6] Add RDMA support for Intel IPU E2000 in idpf
Date: Thu, 12 Jun 2025 16:59:56 -0500
Message-ID: <20250612220002.1120-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This idpf patch series is the second part of the staged submission
for introducing RDMA RoCEv2 support for the IPU E2000 line of products,
referred to as GEN3.

To support RDMA GEN3 devices, the idpf driver uses
common definitions of the IIDC interface and implements
specific device functionality in iidc_rdma_idpf.h.

The IPU model can host one or more logical network endpoints called
vPorts per PCI function that are flexibly associated with a physical
port or an internal communication port.

Other features as it pertains to GEN3 devices include:
* MMIO learning
* RDMA capability negotiation
* RDMA vectors discovery between idpf and control plane

These patches are split from the submission
"Add RDMA support for Intel IPU E2000 (GEN3)" [1]
and are based on 6.16-rc1. A shared pull request for net-next and
rdma-next will be sent following review.

Changelog:

v2:
* Minor improvements like variable rename, logging,
remove a redundant variable, etc.
* A couple of cdev_info fixes to properly free it in
error path and not to dereference it before NULL check.

Changes since split (v1) at [4]:
* Replace core dev_ops with exported symbols
* Align with new header split scheme (iidc_rdma.h common header
and iidc_rdma_idpf.h specific header)
* Align with new naming scheme (idc_rdma -> iidc_rdma)
* The idpf patches are submitted separately from the ice and
irdma changes.

At [3]:
* Reduce required minimum RDMA vectors to 2

At [2]:
* RDMA vector number adjustment
* Fix unplugging vport auxiliary device twice
* General cleanup and minor improvements

[1] https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/
[2] https://lore.kernel.org/all/20240824031924.421-1-tatyana.e.nikolova@intel.com/
[3] https://lore.kernel.org/all/20250207194931.1569-1-tatyana.e.nikolova@intel.com/
[4] https://lore.kernel.org/all/20250523170435.668-1-tatyana.e.nikolova@intel.com/ 

Joshua Hay (6):
  idpf: use reserved RDMA vectors from control plane
  idpf: implement core RDMA auxiliary dev create, init, and destroy
  idpf: implement RDMA vport auxiliary dev create, init, and destroy
  idpf: implement remaining IDC RDMA core callbacks and handlers
  idpf: implement IDC vport aux driver MTU change handler
  idpf: implement get LAN MMIO memory regions

 drivers/net/ethernet/intel/idpf/Makefile      |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        | 117 ++++-
 .../net/ethernet/intel/idpf/idpf_controlq.c   |  14 +-
 .../net/ethernet/intel/idpf/idpf_controlq.h   |  19 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  49 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c    | 497 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 102 +++-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  32 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h    |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  45 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 190 ++++++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   3 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  42 +-
 include/linux/net/intel/iidc_rdma_idpf.h      |  55 ++
 15 files changed, 1102 insertions(+), 73 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_idc.c
 create mode 100644 include/linux/net/intel/iidc_rdma_idpf.h

-- 
2.31.1


