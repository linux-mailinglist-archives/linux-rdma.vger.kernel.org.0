Return-Path: <linux-rdma+bounces-7530-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EBAA2CD0E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 20:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB3316B1D1
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 19:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051FD198823;
	Fri,  7 Feb 2025 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IiawNioQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524F23C8CB;
	Fri,  7 Feb 2025 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957823; cv=none; b=qaHwzWDFauuodfEKLoyyNZW6O6iiRuafMI4hnV73i4oQDPObkjgHY0+ceQv+MSkCXwYp6lylW878AeWICIuDt/yaLAS61/l0T9LdVO1WLPx6SBZvsDpTMzrEQn1PT9otWr0LDrmhajHDjBqMxumezs4H/rGnWmkTJpMnv4ST/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957823; c=relaxed/simple;
	bh=GtGlxqXv+tsjAO8Caeb7ywfrHU4twoF3PXGRm0Pnm1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IsTD5g1kUL4FqhD+wtxIbj3LnTpX5+Jkt6JqJkj+tHtRRPhUeLjkExMfThYaLEJcT22ByIY2it4cBsco3NReVw1wmlpLgpBxnzr5hFU+xnKGyaDWxyHfwL+JkvzHIP7/QBQqD7JtJQogA7NSxVAFqHvZtOVWIzQmUZpzYQcwLS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiawNioQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738957821; x=1770493821;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GtGlxqXv+tsjAO8Caeb7ywfrHU4twoF3PXGRm0Pnm1k=;
  b=IiawNioQ0LfuvwQ3GGQqEcd7VndGduxUV46bs2LuJZM2KYJ3twUEd3pr
   iWeWDu47xDzZig75Hf5z5YTzceLGXpneKkHxcuasLOdEjy3mc7zxY3vpH
   4NCYvsuQwmaYyrI36+tLCwwUG5FGMVcaCP+BDQYzlBHhVg5v+yumb7TM3
   EUEV+i/PDzN+RYLtjRo6PA7z0TEX9lBivO/Clty/MZDSRWCo2qPlVyA99
   5jKg0p5J6A7NWtRMLiVZ2RVFTcb0pIWD0A7fVrWDlTV69dMVNaPYEY5v4
   6GQV++pYGoYjwEeqC+4ZDciWAC3UgnSTGwkSnnvOzMCIlsm2KwfD3xsR0
   Q==;
X-CSE-ConnectionGUID: fQ5fnDIpQzycG7tdKE2c5Q==
X-CSE-MsgGUID: 18zzEp5uRX6ZB6ZZsoo2iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42451736"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42451736"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:20 -0800
X-CSE-ConnectionGUID: 34C0oul1Q0mQnLtRAAtGdw==
X-CSE-MsgGUID: MzrsVY2MScq5uEMwMK5a5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112238093"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.81.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:20 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [iwl-next,rdma v3 00/24] Add RDMA support for Intel IPU E2000 (GEN3)
Date: Fri,  7 Feb 2025 13:49:07 -0600
Message-Id: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is based on 6.14-rc1 and includes both netdev and RDMA
patches for ease of review. It can also be viewed here [1]. A shared pull
request will be sent for patches 1-7 following review.

The patch series introduces RDMA RoCEv2 support for the Intel Infrastructure
Processing Unit (IPU) E2000 line of products, referred to as GEN3 in the
irdma provider.  It supports both physical and virtual functions.
The irdma driver communicates with the device Control Plane (CP) to
discover capabilities and perform privileged operations through an
RDMA-specific messaging interface built atop the Infrastructure
Data-Plane Function (IDPF) mailbox and virtchannel protocol [2].

To support RDMA for E2000 product, the idpf driver requires the use of
the Inter-Driver Communication (IDC) interface which is currently already
in use between ice and irdma. With a second consumer, the IDC is
generalized to support multiple consumers and ice, idpf and irdma
are adapted to the IDC definitions.

The IPU model can host one or more logical network endpoints called vPorts
per PCI function that are flexibly associated with a physical port or an
internal communication port. irdma exposes a verbs device per vPort.

Other key highlights of this series as it pertains to GEN3 device include:

MMIO learning, RDMA capability negotiation and RDMA vectors
discovery between idpf and CP
PCI core device level RDMA resource initialization via
a GEN3 core auxiliary driver
Shared Receive Queue (SRQ) Support
Atomic Operations Support (Compare and Swap and Fetch and Add)
Completion Queue Element (CQE) Error and Flush Handling
Push Page Support

Changelog:

V3 series irdma changes:
* Move the call to get RDMA features just after CQP is created,
otherwise the feature flags are not defined before used.
* Move the check for supported atomic operations after reading
the RDMA feature info to correctly enable atomics.
* Round up to power of two the resource size for Read Responses and
Transmit Queue elements.
* Do not use the Work Queue element index passed in the Asynchronous Event
info to get SRQ context, because it is incorrect.
* Fix detection of Completion Queue (CQ) empty when 64-byte CQ elements
are enabled.
* Minor improvements and cleanup.

V3 series idpf changes:
* Reduce required minimum RDMA vectors to 2.

V2 RFC series includes only idpf changes:

* RDMA vector number adjustment
* Fix unplugging vport auxiliary device twice
* General cleanup and minor improvements

V2 RFC series is at https://lwn.net/Articles/987141/.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/linux.git/log/?h=idpf-rdma
[2] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c

Christopher Bednarz (1):
  RDMA/irdma: Discover and set up GEN3 hardware register layout

Dave Ertman (1):
  iidc/ice/irdma: Update IDC to support multiple consumers

Faisal Latif (2):
  RDMA/irdma: Add SRQ support
  RDMA/irdma: Add Atomic Operations support

Jay Bhat (1):
  RDMA/irdma: Add Push Page Support for GEN3

Joshua Hay (6):
  idpf: use reserved RDMA vectors from control plane
  idpf: implement core RDMA auxiliary dev create, init, and destroy
  idpf: implement RDMA vport auxiliary dev create, init, and destroy
  idpf: implement remaining IDC RDMA core callbacks and handlers
  idpf: implement IDC vport aux driver MTU change handler
  idpf: implement get LAN mmio memory regions

Krzysztof Czurylo (2):
  RDMA/irdma: Add GEN3 CQP support with deferred completions
  RDMA/irdma: Add GEN3 HW statistics support

Mustafa Ismail (3):
  RDMA/irdma: Refactor GEN2 auxiliary driver
  RDMA/irdma: Add GEN3 core driver support
  RDMA/irdma: Introduce GEN3 vPort driver support

Shiraz Saleem (7):
  RDMA/irdma: Add GEN3 support for AEQ and CEQ
  RDMA/irdma: Add GEN3 virtual QP1 support
  RDMA/irdma: Extend QP context programming for GEN3
  RDMA/irdma: Support 64-byte CQEs and GEN3 CQE opcode decoding
  RDMA/irdma: Restrict Memory Window and CQE Timestamping to GEN3
  RDMA/irdma: Extend CQE Error and Flush Handling for GEN3 Devices
  RDMA/irdma: Update Kconfig

Vinoth Kumar Chandra Mohan (1):
  RDMA/irdma: Add support for V2 HMC resource management scheme

 drivers/infiniband/hw/irdma/Kconfig           |    7 +-
 drivers/infiniband/hw/irdma/Makefile          |    4 +
 drivers/infiniband/hw/irdma/ctrl.c            | 1469 +++++++++++++++--
 drivers/infiniband/hw/irdma/defs.h            |  266 +--
 drivers/infiniband/hw/irdma/hmc.c             |   18 +-
 drivers/infiniband/hw/irdma/hmc.h             |   19 +-
 drivers/infiniband/hw/irdma/hw.c              |  357 ++--
 drivers/infiniband/hw/irdma/i40iw_hw.c        |    2 +
 drivers/infiniband/hw/irdma/i40iw_hw.h        |    2 +
 drivers/infiniband/hw/irdma/i40iw_if.c        |    3 +
 drivers/infiniband/hw/irdma/icrdma_hw.c       |    3 +
 drivers/infiniband/hw/irdma/icrdma_hw.h       |    5 +-
 drivers/infiniband/hw/irdma/icrdma_if.c       |  267 +++
 drivers/infiniband/hw/irdma/ig3rdma_hw.c      |  170 ++
 drivers/infiniband/hw/irdma/ig3rdma_hw.h      |   29 +
 drivers/infiniband/hw/irdma/ig3rdma_if.c      |  279 ++++
 drivers/infiniband/hw/irdma/irdma.h           |   23 +-
 drivers/infiniband/hw/irdma/main.c            |  323 +---
 drivers/infiniband/hw/irdma/main.h            |   42 +-
 drivers/infiniband/hw/irdma/osdep.h           |    4 +-
 drivers/infiniband/hw/irdma/pble.c            |   20 +-
 drivers/infiniband/hw/irdma/protos.h          |    1 +
 drivers/infiniband/hw/irdma/puda.h            |    4 +-
 drivers/infiniband/hw/irdma/type.h            |  224 ++-
 drivers/infiniband/hw/irdma/uda_d.h           |    5 +-
 drivers/infiniband/hw/irdma/uk.c              |  303 +++-
 drivers/infiniband/hw/irdma/user.h            |  268 ++-
 drivers/infiniband/hw/irdma/utils.c           |  133 +-
 drivers/infiniband/hw/irdma/verbs.c           |  873 ++++++++--
 drivers/infiniband/hw/irdma/verbs.h           |   47 +
 drivers/infiniband/hw/irdma/virtchnl.c        |  656 ++++++++
 drivers/infiniband/hw/irdma/virtchnl.h        |  189 +++
 .../net/ethernet/intel/ice/devlink/devlink.c  |   40 +-
 drivers/net/ethernet/intel/ice/ice.h          |    6 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   46 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |    4 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |    8 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      |  255 ++-
 drivers/net/ethernet/intel/ice/ice_idc_int.h  |    5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   18 +-
 drivers/net/ethernet/intel/idpf/Makefile      |    1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  114 +-
 .../net/ethernet/intel/idpf/idpf_controlq.c   |   14 +-
 .../net/ethernet/intel/idpf/idpf_controlq.h   |   15 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   48 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c    |  490 ++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   93 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   32 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h    |    8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   44 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  189 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |    3 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |   52 +-
 include/linux/net/intel/idc_rdma.h            |  138 ++
 include/linux/net/intel/iidc.h                |  107 --
 include/linux/net/intel/iidc_rdma.h           |   67 +
 include/uapi/rdma/irdma-abi.h                 |   17 +-
 58 files changed, 6693 insertions(+), 1137 deletions(-)
 create mode 100644 drivers/infiniband/hw/irdma/icrdma_if.c
 create mode 100644 drivers/infiniband/hw/irdma/ig3rdma_hw.c
 create mode 100644 drivers/infiniband/hw/irdma/ig3rdma_hw.h
 create mode 100644 drivers/infiniband/hw/irdma/ig3rdma_if.c
 create mode 100644 drivers/infiniband/hw/irdma/virtchnl.c
 create mode 100644 drivers/infiniband/hw/irdma/virtchnl.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_idc.c
 create mode 100644 include/linux/net/intel/idc_rdma.h
 delete mode 100644 include/linux/net/intel/iidc.h
 create mode 100644 include/linux/net/intel/iidc_rdma.h

-- 
2.37.3


