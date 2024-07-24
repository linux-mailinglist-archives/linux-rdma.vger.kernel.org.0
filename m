Return-Path: <linux-rdma+bounces-3949-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FED993B97B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8A51C218CD
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39A11428E0;
	Wed, 24 Jul 2024 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJO6CFMa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1955B13BC3E
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864437; cv=none; b=VOciOLuOBFiGa19cybe6dlgy30WGZTUCLNBh1Ykl+0a5CEKjjCqLCkolwElZOvwfTNd1K/i1MYJy/HgjoinQEecq2gWcDF70XHPedbhstqlOP9YrAc00EEPPdLuyS+qtDcAMWFMixuefJJocTqKED5Aazmir1wRLXRYr8ENORAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864437; c=relaxed/simple;
	bh=CUhqptdLx6oYDSTGTEzh3mU8QkQ/74JYDAhbD9FyuAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=awg+JtWneMazQIOQyY7fWIWiYcY+lF0XdpKl5wUPQTy8fJCEoMyrf5qzvrLyHa6xOB2fcVnF/uLkrYJgdEUr1rIMw2N52AdZJMDoBnZxRmuzL8yQaDROE78Nl+R4vTfEnmn0O88+N8TIOjMiyw4Uiouo1gIWEVOXb1gfgF7aF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJO6CFMa; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864435; x=1753400435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CUhqptdLx6oYDSTGTEzh3mU8QkQ/74JYDAhbD9FyuAo=;
  b=SJO6CFMaGi9RlhnFs6jujGTaComkd4ZiJFmR61m8kAg07apYYRoES3xY
   FRHYYTrBl3ElCXVeQuFvpH5sI8tdEI7nHgGKU3i96raasH9I0n6MK/hnq
   vwJx7MfLatYyuyi08jPGWaB+w6n076W4vrjT9vqQWih4PVCSLFWvrKPKI
   gnL8hAFI9DFPuF41qdbuAImIaSYOqlVuxeObY13Qjktw5ps1SHF2QCT0a
   YAnb6ScFAhXmjXiAt0t0hwiDhJU2ThBFQ6hKY1FMG4hjoXlHqL6FdI0I1
   5FZg1FxhQxfvSL4O8UyewYJRAFhltd6PfHGjB2wp0S7Fafa/zzauRlMqo
   Q==;
X-CSE-ConnectionGUID: L19Oh6T5T4y0rxC/EHb4aQ==
X-CSE-MsgGUID: KcIJcy/nQRSigmxWNYWG9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999731"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999731"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:34 -0700
X-CSE-ConnectionGUID: yd4dTRQpSQa2kLgb1BqxGg==
X-CSE-MsgGUID: Ny1es9PARz2VgmBIEcjbfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52425982"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:33 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 00/25] Cover Letter
Date: Wed, 24 Jul 2024 18:38:52 -0500
Message-Id: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
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

Feedback regarding any aspect of the series is highly welcome, but the series is submitted as an RFC specifically to get feedback around the IDC and RDMA virtual channel private interface to CP.

Additionally, this series is currently based on the rdma-next tree [3] and includes netdev patches for review purposes.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
[2] https://github.com/oasis-tcs/idpf-specification/blob/main/idpf_specification.md
[3] commit 346d2fc606a8 ("RDMA/efa: Add EFA 0xefa3 PCI ID")

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

 drivers/infiniband/hw/irdma/Kconfig              |    7 +-
 drivers/infiniband/hw/irdma/Makefile             |    4 +
 drivers/infiniband/hw/irdma/ctrl.c               | 1312 ++++++++++++++++++++--
 drivers/infiniband/hw/irdma/defs.h               |  243 ++--
 drivers/infiniband/hw/irdma/hmc.c                |   18 +-
 drivers/infiniband/hw/irdma/hmc.h                |   19 +-
 drivers/infiniband/hw/irdma/hw.c                 |  349 +++---
 drivers/infiniband/hw/irdma/i40iw_hw.c           |    2 +
 drivers/infiniband/hw/irdma/i40iw_hw.h           |    2 +
 drivers/infiniband/hw/irdma/i40iw_if.c           |    3 +
 drivers/infiniband/hw/irdma/icrdma_hw.c          |    3 +
 drivers/infiniband/hw/irdma/icrdma_hw.h          |    5 +-
 drivers/infiniband/hw/irdma/icrdma_if.c          |  267 +++++
 drivers/infiniband/hw/irdma/ig3rdma_hw.c         |  173 +++
 drivers/infiniband/hw/irdma/ig3rdma_hw.h         |   29 +
 drivers/infiniband/hw/irdma/ig3rdma_if.c         |  279 +++++
 drivers/infiniband/hw/irdma/irdma.h              |   21 +-
 drivers/infiniband/hw/irdma/main.c               |  323 ++----
 drivers/infiniband/hw/irdma/main.h               |   40 +-
 drivers/infiniband/hw/irdma/osdep.h              |    4 +-
 drivers/infiniband/hw/irdma/pble.c               |   20 +-
 drivers/infiniband/hw/irdma/protos.h             |    1 +
 drivers/infiniband/hw/irdma/type.h               |  227 +++-
 drivers/infiniband/hw/irdma/uda_d.h              |    5 +-
 drivers/infiniband/hw/irdma/uk.c                 |  303 ++++-
 drivers/infiniband/hw/irdma/user.h               |  268 ++++-
 drivers/infiniband/hw/irdma/utils.c              |  155 ++-
 drivers/infiniband/hw/irdma/verbs.c              |  911 +++++++++++++--
 drivers/infiniband/hw/irdma/verbs.h              |   51 +
 drivers/infiniband/hw/irdma/virtchnl.c           |  654 +++++++++++
 drivers/infiniband/hw/irdma/virtchnl.h           |  189 ++++
 drivers/net/ethernet/intel/ice/devlink/devlink.c |   41 +-
 drivers/net/ethernet/intel/ice/ice.h             |    6 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c     |   46 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h     |    4 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c     |    8 +-
 drivers/net/ethernet/intel/ice/ice_idc.c         |  245 ++--
 drivers/net/ethernet/intel/ice/ice_idc_int.h     |    5 +-
 drivers/net/ethernet/intel/ice/ice_main.c        |   18 +-
 drivers/net/ethernet/intel/idpf/Makefile         |    1 +
 drivers/net/ethernet/intel/idpf/idpf.h           |  104 +-
 drivers/net/ethernet/intel/idpf/idpf_controlq.h  |   13 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c       |   46 +-
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c   |   17 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c       |  474 ++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c       |   89 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c      |   36 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h       |    8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h      |    1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c    |   42 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c  |  201 +++-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h  |    3 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h      |   51 +-
 include/linux/net/intel/idc_rdma.h               |  138 +++
 include/linux/net/intel/iidc.h                   |  107 --
 include/linux/net/intel/iidc_rdma.h              |   61 +
 include/uapi/rdma/irdma-abi.h                    |   17 +-
 57 files changed, 6562 insertions(+), 1107 deletions(-)
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
1.8.3.1


