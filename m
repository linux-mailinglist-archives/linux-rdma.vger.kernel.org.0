Return-Path: <linux-rdma+bounces-12952-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 702F9B3868E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 17:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065311BA1726
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58D62797B7;
	Wed, 27 Aug 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGv7VT/M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616132248B0
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308398; cv=none; b=KQhvbucGFAexS3lHhah0M2Idfz22VsRbUc8eB+C3mppdw+7MXgzjNpAWnSKqbhEbYi9/qLFV9e/1d+suwW+nymnElJ4O0fshGLcp1Rz/r57yzMdudl2jC3qZgkRKxuUiAzZIPExcCgmma9eIbsTlO21wiv+5cB/OjIO42CJpFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308398; c=relaxed/simple;
	bh=Z+hCXWx3Vderj6wCt+Nyh2CYh1hrLjbHEA7U7vwr8X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCC4b+47CL8HeJGTpS17CJIoNXh93GQBkz0yfKLZOZf0aC8NqOlBmDRcIsFKuFaJouYHbNh12yPAI4hXlF8Kq/ZVAzLytbuKpdObly1j0TO8O1b1YWECXM0GipKUZclwjHjs6H2n3F6IdHIPvlhl6kwD6fcJVR/Rm3TjTb9MTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGv7VT/M; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756308396; x=1787844396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z+hCXWx3Vderj6wCt+Nyh2CYh1hrLjbHEA7U7vwr8X8=;
  b=LGv7VT/MaOzrALiSsJ10b25VFVb33yURqOc/iH3/InujYaLRJxX2psx/
   ds78dGkLXA4Jr0DAU9I9pAYfhBDXgvg+1VgUCoq5XUUFTIMRCsIXW2S7u
   maLJcEVXvs+J4xcRtOwe/aAOYgZdSyl0MEqs89dascY+5MJM15o6LlZO8
   9t5MP48r0kBPA5Zd97Hb3UhHDs5RX/Kj3ZF2Ukq8Q7uut5B+YaHSV5lq+
   dd2d+ffOrl4Pe8SkS0gXa2C7BUm7qmZ1K0LTUGmojq2jhP+IEAWTfX0Im
   H0y2ceJetwoxW1JAuKIcv0TQ8avJ49h2Elt9zv9/zjb9DsGor2SihupqT
   A==;
X-CSE-ConnectionGUID: 1MR1oTpRTo2amw6eWDekRg==
X-CSE-MsgGUID: KYDq3pHATU2wC8NzQzmwwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76162746"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76162746"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:36 -0700
X-CSE-ConnectionGUID: CkgG2FUMTUGUVBY4wDiW1A==
X-CSE-MsgGUID: ZqeluxccRsKJsJAi8f8/KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174206759"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:33 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 00/16] Add RDMA support for Intel IPU E2000 in irdma
Date: Wed, 27 Aug 2025 10:25:29 -0500
Message-ID: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tatyana Nikolova-Gross <tatyana.e.nikolova@intel.com>

This irdma patch series is the last part of the staged submission introducing
RDMA RoCEv2 support for the IPU E2000 line of products, referred to as GEN3.

To support RDMA GEN3 devices, the irdma driver uses common functions and
definitions implemented by the Intel Inter-Driver Communication (IIDC) interface
and driver specific IIDC functionality exported by the idpf driver. This
interface is already in use between ice and irdma.

The IPU model can host one or more logical network endpoints called vPorts per
PCI function that are flexibly associated with a physical port or an internal
communication port. irdma exposes a verbs device per vPort.

The irdma driver communicates with the device Control Plane (CP) to discover
device capabilities and perform privileged operations through an RDMA-specific
messaging interface built atop the Infrastructure Data-Plane Function (IDPF)
mailbox and virtchannel protocol [1].

Other features as it pertains to GEN3 devices include:
* Host Memory Cache (HMC) resource initialization based on FW capability
* Shared Receive Queue (SRQ) Support
* Atomic Operations Support 
* Completion Queue Element (CQE) Error and Flush Handling
* 64-byte CQEs Support
* Type2 Memory Windows and Timestamping Support

These patches are split from the submission
"Add RDMA support for Intel IPU E2000 (GEN3)" [2].
The patches have been tested on a range of hosts and platforms with a variety
of general RDMA applications which include standalone verbs (rping, perftest, etc.),
storage and HPC applications.

Changelog:

Changes since split:
* Use exported symbols instead of device ops struct
* Move ice/idpf specific functionality to icrdma_/ig3rdma_* files
* Adapt to the renamed IIDC structs/functions iidc_*
* Use iidc_priv struct to access core driver specific info
* Remove push mode support for GEN3

At [4]:
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

Patch series at [3] includes only idpf changes.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
[2] https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/
[3] https://lore.kernel.org/all/20240824031924.421-1-tatyana.e.nikolova@intel.com/
[4] https://lore.kernel.org/all/20250207194931.1569-1-tatyana.e.nikolova@intel.com/

Christopher Bednarz (1):
  RDMA/irdma: Discover and set up GEN3 hardware register layout

Faisal Latif (2):
  RDMA/irdma: Add SRQ support
  RDMA/irdma: Add Atomic Operations support

Krzysztof Czurylo (2):
  RDMA/irdma: Add GEN3 CQP support with deferred completions
  RDMA/irdma: Add GEN3 HW statistics support

Mustafa Ismail (3):
  RDMA/irdma: Refactor GEN2 auxiliary driver
  RDMA/irdma: Add GEN3 core driver support
  RDMA/irdma: Introduce GEN3 vPort driver support

Shiraz Saleem (6):
  RDMA/irdma: Add GEN3 support for AEQ and CEQ
  RDMA/irdma: Add GEN3 virtual QP1 support
  RDMA/irdma: Extend QP context programming for GEN3
  RDMA/irdma: Support 64-byte CQEs and GEN3 CQE opcode decoding
  RDMA/irdma: Restrict Memory Window and CQE Timestamping to GEN3
  RDMA/irdma: Extend CQE Error and Flush Handling for GEN3 Devices

Tatyana Nikolova (1):
  RDMA/irdma: Update Kconfig

Vinoth Kumar Chandra Mohan (1):
  RDMA/irdma: Add support for V2 HMC resource management scheme

 drivers/infiniband/hw/irdma/Kconfig      |    7 +-
 drivers/infiniband/hw/irdma/Makefile     |    4 +
 drivers/infiniband/hw/irdma/ctrl.c       | 1468 ++++++++++++++++++++--
 drivers/infiniband/hw/irdma/defs.h       |  264 ++--
 drivers/infiniband/hw/irdma/hmc.c        |   18 +-
 drivers/infiniband/hw/irdma/hmc.h        |   19 +-
 drivers/infiniband/hw/irdma/hw.c         |  363 +++---
 drivers/infiniband/hw/irdma/i40iw_hw.c   |    2 +
 drivers/infiniband/hw/irdma/i40iw_hw.h   |    2 +
 drivers/infiniband/hw/irdma/i40iw_if.c   |    3 +
 drivers/infiniband/hw/irdma/icrdma_hw.c  |    3 +
 drivers/infiniband/hw/irdma/icrdma_hw.h  |    5 +-
 drivers/infiniband/hw/irdma/icrdma_if.c  |  343 +++++
 drivers/infiniband/hw/irdma/ig3rdma_hw.c |  170 +++
 drivers/infiniband/hw/irdma/ig3rdma_hw.h |   32 +
 drivers/infiniband/hw/irdma/ig3rdma_if.c |  232 ++++
 drivers/infiniband/hw/irdma/irdma.h      |   22 +-
 drivers/infiniband/hw/irdma/main.c       |  371 ++----
 drivers/infiniband/hw/irdma/main.h       |   35 +-
 drivers/infiniband/hw/irdma/pble.c       |   20 +-
 drivers/infiniband/hw/irdma/protos.h     |    1 +
 drivers/infiniband/hw/irdma/puda.h       |    4 +-
 drivers/infiniband/hw/irdma/type.h       |  221 +++-
 drivers/infiniband/hw/irdma/uda_d.h      |    5 +-
 drivers/infiniband/hw/irdma/uk.c         |  303 ++++-
 drivers/infiniband/hw/irdma/user.h       |  267 +++-
 drivers/infiniband/hw/irdma/utils.c      |  112 +-
 drivers/infiniband/hw/irdma/verbs.c      |  825 ++++++++++--
 drivers/infiniband/hw/irdma/verbs.h      |   44 +
 drivers/infiniband/hw/irdma/virtchnl.c   |  618 +++++++++
 drivers/infiniband/hw/irdma/virtchnl.h   |  176 +++
 include/uapi/rdma/irdma-abi.h            |   16 +-
 32 files changed, 5120 insertions(+), 855 deletions(-)
 create mode 100644 drivers/infiniband/hw/irdma/icrdma_if.c
 create mode 100644 drivers/infiniband/hw/irdma/ig3rdma_hw.c
 create mode 100644 drivers/infiniband/hw/irdma/ig3rdma_hw.h
 create mode 100644 drivers/infiniband/hw/irdma/ig3rdma_if.c
 create mode 100644 drivers/infiniband/hw/irdma/virtchnl.c
 create mode 100644 drivers/infiniband/hw/irdma/virtchnl.h

-- 
2.42.0


