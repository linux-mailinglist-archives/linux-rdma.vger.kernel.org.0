Return-Path: <linux-rdma+bounces-4530-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF31C95DAD1
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F216F1C2132F
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B651F22309;
	Sat, 24 Aug 2024 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDEu4C7D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202FF4ED;
	Sat, 24 Aug 2024 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469640; cv=none; b=JQvkzP0LBrESArvlYA7cTZuk8wN5tqqXvl+xm3/auhwWnm+20Q2Y/4NXgrwInpFbpYT4LCV5ogLlyLm3leUCtxZPKSAy86xe9SnZY6WoxuoqaY0tiYGOeUEdW33tD+bB775b1f6QyCRcyFtX+38TmhCo89eT023eLlaMdcTfI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469640; c=relaxed/simple;
	bh=F0LFJdoNxPbJyZbb7obafeISqOlPqQPWAn8D6OQSznc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YTp1kf1MDfHn70WG6Y9MkzCfMMd0oo+WxxZgeu42lItYpCftrd4m/h759oWQjtEy8oInAccA9Z0s5JZLYXPa3kZM9vGQkEemmlJqERll80neFsnOfOTMGEbKPJiWEfaVGgVBgcLqOfLirGR02Y9NQfJviDVPJXvTljI+r95yiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDEu4C7D; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724469638; x=1756005638;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F0LFJdoNxPbJyZbb7obafeISqOlPqQPWAn8D6OQSznc=;
  b=CDEu4C7Dt7iCErlFlfsRpOKml2KFMXZw6uLiXViBLbKllqBU1GR9gcCJ
   TetN2c2JvOJk21s4STjsKBsiichCVU0NqsffrpTsEbATEUxAIom/71ran
   pvHpqOBtgw1MZiKCnF694gzAqcwJbiPENyeKkIFaNRcu+txIT5yLqgrva
   p2b4L6+ZTsC4I4KsleChK+oghcmQnaMqQ5CCKs2E9XR8KRjPGg8hchwKB
   os6vks+eDDvrVEB85caw6yuUa/l6t8Egjh+BeoXDl/TaZcY+fDA/OM7+6
   cwBbK5zsUQyvxhgLzqX8jvhZWbexUIH3kYjdeHoUeNqK5n/67eqvvLMts
   A==;
X-CSE-ConnectionGUID: SV1WNzqFQKyWT0JC7COYuw==
X-CSE-MsgGUID: UaysDrDLTlay6EcVxAO8qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13187765"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13187765"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:38 -0700
X-CSE-ConnectionGUID: S/U4hBA+TNKWiq8BckeW1w==
X-CSE-MsgGUID: Dvs74okgTBeVh6WJNoahoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99492066"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.36.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:37 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC v2 00/25] Add RDMA support for Intel IPU E2000 (GEN3) 
Date: Fri, 23 Aug 2024 22:18:59 -0500
Message-Id: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC patch series introduces RDMA RoCEv2 support for the Intel Infrastructure Processing Unit (IPU) E2000 line of products, referred to as GEN3 in the irdma provider. It supports both physical and virtual functions. The irdma driver communicates with the device Control Plane (CP) to discover capabilities and perform privileged operations through an RDMA-specific messaging interface built atop the Infrastructure Data-Plane Function (IDPF) mailbox and virtchannel protocol [1][2].

To support RDMA for E2000 product, the idpf driver requires the use of the Inter-Driver Communication (IDC) interface which is currently already in use between ice and irdma. With a second consumer, the IDC is generalized to support multiple consumers and ice, idpf and irdma are adapted to the new IDC definitions [2].

The IPU model can host one or more logical network endpoints called vPorts per PCI function that are flexibly associated with a physical port or an internal communication port. irdma exposes a verbs device per vPort.

Other key highlights of this series as it pertains to GEN3 device include:

- MMIO learning, RDMA capability negotiation and RDMA vectors discovery between idpf and CP
- PCI core device level RDMA resource initialization via a GEN3 core auxiliary driver
- Shared Receive Queue (SRQ) Support
- Atomic Operations Support
- Completion Queue Element (CQE) Error and Flush Handling
- Push Page Support

V2 series includes only idpf changes:

- RDMA vector number adjustment
- Fix unplugging vport auxiliary device twice
- General cleanup and minor improvements in patch #9 "idpf: implement get lan mmio memory regions"

Feedback regarding any aspect of the series is highly welcome, but the series is submitted as an RFC specifically to get feedback around the IDC and RDMA virtual channel private interface to CP.

Additionally, this series is currently based on the rdma-next tree [3] and includes netdev patches for review purposes.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
[2] https://github.com/oasis-tcs/idpf-specification/blob/main/idpf_specification.md
[3] commit ec7ad6530909 ("RDMA/mlx5: Introduce GET_DATA_DIRECT_SYSFS_PATH ioctl")

Christopher Bednarz (1):
  RDMA/irdma: Discover and set up GEN3 hardware register layout

Dave Ertman (1):
  iidc/ice/irdma: Update IDC to support multiple consumers

Faisal Latif (2):
  RDMA/irdma: Add SRQ support
  RDMA/irdma: Add Atomic Operations support

Jay Bhat (1):
  RDMA/irdma: Add Push Page Support for GEN3

Joshua Hay (8):
  idpf: use reserved rdma vectors from control plane
  idpf: implement core rdma auxiliary dev create, init, and destroy
  idpf: prevent deadlock with irdma get link settings
  idpf: implement rdma vport auxiliary dev create, init, and destroy
  idpf: implement remaining idc rdma core callbacks and handlers
  idpf: use actual mbx receive payload length
  idpf: implement idc vport aux driver mtu change handler
  idpf: implement get lan mmio memory regions

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

 drivers/infiniband/hw/irdma/Kconfig           |    7 +-
 drivers/infiniband/hw/irdma/Makefile          |    4 +
 drivers/infiniband/hw/irdma/ctrl.c            | 1312 +++++++++++++++--
 drivers/infiniband/hw/irdma/defs.h            |  243 +--
 drivers/infiniband/hw/irdma/hmc.c             |   18 +-
 drivers/infiniband/hw/irdma/hmc.h             |   19 +-
 drivers/infiniband/hw/irdma/hw.c              |  349 +++--
 drivers/infiniband/hw/irdma/i40iw_hw.c        |    2 +
 drivers/infiniband/hw/irdma/i40iw_hw.h        |    2 +
 drivers/infiniband/hw/irdma/i40iw_if.c        |    3 +
 drivers/infiniband/hw/irdma/icrdma_hw.c       |    3 +
 drivers/infiniband/hw/irdma/icrdma_hw.h       |    5 +-
 drivers/infiniband/hw/irdma/icrdma_if.c       |  267 ++++
 drivers/infiniband/hw/irdma/ig3rdma_hw.c      |  173 +++
 drivers/infiniband/hw/irdma/ig3rdma_hw.h      |   29 +
 drivers/infiniband/hw/irdma/ig3rdma_if.c      |  279 ++++
 drivers/infiniband/hw/irdma/irdma.h           |   21 +-
 drivers/infiniband/hw/irdma/main.c            |  323 +---
 drivers/infiniband/hw/irdma/main.h            |   40 +-
 drivers/infiniband/hw/irdma/osdep.h           |    4 +-
 drivers/infiniband/hw/irdma/pble.c            |   20 +-
 drivers/infiniband/hw/irdma/protos.h          |    1 +
 drivers/infiniband/hw/irdma/type.h            |  227 ++-
 drivers/infiniband/hw/irdma/uda_d.h           |    5 +-
 drivers/infiniband/hw/irdma/uk.c              |  303 +++-
 drivers/infiniband/hw/irdma/user.h            |  268 +++-
 drivers/infiniband/hw/irdma/utils.c           |  155 +-
 drivers/infiniband/hw/irdma/verbs.c           |  911 ++++++++++--
 drivers/infiniband/hw/irdma/verbs.h           |   51 +
 drivers/infiniband/hw/irdma/virtchnl.c        |  654 ++++++++
 drivers/infiniband/hw/irdma/virtchnl.h        |  189 +++
 .../net/ethernet/intel/ice/devlink/devlink.c  |   41 +-
 drivers/net/ethernet/intel/ice/ice.h          |    6 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   46 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |    4 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |    8 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      |  245 +--
 drivers/net/ethernet/intel/ice/ice_idc_int.h  |    5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   18 +-
 drivers/net/ethernet/intel/idpf/Makefile      |    1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  103 +-
 .../net/ethernet/intel/idpf/idpf_controlq.c   |   14 +-
 .../net/ethernet/intel/idpf/idpf_controlq.h   |   15 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   46 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   17 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c    |  478 ++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   95 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   32 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h    |    8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   42 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  190 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |    3 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |   51 +-
 include/linux/net/intel/idc_rdma.h            |  138 ++
 include/linux/net/intel/iidc.h                |  107 --
 include/linux/net/intel/iidc_rdma.h           |   61 +
 include/uapi/rdma/irdma-abi.h                 |   17 +-
 58 files changed, 6564 insertions(+), 1115 deletions(-)
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
2.42.0


