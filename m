Return-Path: <linux-rdma+bounces-11932-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE144AFB967
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 19:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6CDD17114D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5362E7F09;
	Mon,  7 Jul 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN0yqhSr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127C22DF9E;
	Mon,  7 Jul 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907845; cv=none; b=HMAHBR2LawWUW4LZYMz2hCwsOsbRPrIbxQStLk9YWWKUGMGU/litwKKUFV5NZg9UUoVHtej6vKy0VfANQ7B2S1chnxohnOS0Rdg7oqyfFYVZC2BIDTN3HgsIlAX6aXpTmCcToi/fBVeKi0gCBFNpw39+XGNINfawRkQu/a0NdlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907845; c=relaxed/simple;
	bh=fXVvzF15bpWsezX3Z1LLweb0HAZMkiYNVmMTks27JOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BFPsiMaON6H/uPkVBXMcwg2uwG/JcfthCout1+ZBekGlHozkU2WGd3wIUikv8qXh/JxALO99cqi4HqGvuV8+FoGs3IJe90PeKyRSjF0+pdEXEylNE6GPhRovEBtsmk0LrQKdLQ1DWAwV2T84NIAFDIuuHGiyIlX/pk94ykxN+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN0yqhSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B4DC4CEF4;
	Mon,  7 Jul 2025 17:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751907844;
	bh=fXVvzF15bpWsezX3Z1LLweb0HAZMkiYNVmMTks27JOA=;
	h=From:To:Cc:Subject:Date:From;
	b=SN0yqhSrz2l8O207ABkdKZPGwlSQ14EjGxfB2RhwB7V0asUw3kRPHe0tjKtdmtQIA
	 T3TRdJ6L58m/3ld/A0Hn5bt/oOICnvalzoLbdzrS8anRnYG1uxhRtrsbam8XAecPSj
	 4Xeru1/kl4xM9pEjjnvSs1PZVSeKvSVexHBPMFuGBGwUUiFPr+D6RQoHpXkpaJqKKR
	 TeYu1WSTX+/tXdYvrI7JA0HlBHJn4Wfs6cq0+uj2EfokV+595mr8R9L03JoViqGgmY
	 bLry+n5A+gdHRaTznSPSZop3ygbR7pfwcpgc3G/efE/PZFBp5v0Kk4lttHQWGql/8a
	 7LV5s82MarlFQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Christian Benvenuti <benve@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Edward Srouji <edwards@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Nelson Escobar <neescoba@cisco.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 0/8] RDMA support for DMA handle
Date: Mon,  7 Jul 2025 20:03:00 +0300
Message-ID: <cover.1751907231.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From Yishai,

This patch series introduces a new DMA Handle (DMAH) object, along with
corresponding APIs for its allocation and deallocation.

The DMAH object encapsulates attributes relevant for DMA transactions.

While initially intended to support TLP Processing Hints (TPH) [1], the
design is extensible to accommodate future features such as PCI
multipath for DMA, PCI UIO configurations, traffic class selection, and
more.

Additionally, we introduce a new ioctl method on the MR object:
UVERBS_METHOD_REG_MR.

This method consolidates multiple reg_mr variants under a single
user-space ioctl interface, supporting: ibv_reg_mr(), ibv_reg_mr_iova(),
ibv_reg_mr_iova2() and ibv_reg_dmabuf_mr(). It also enables passing a
DMA handle as part of the registration process.

Throughout the patch series, the following DMAH-related stuff can also
be observed in the IB layer:

- Association with a CPU ID and its memory type, for use with Steering
  Tags [2].

- Inclusion of Processing Hints (PH) data for TPH functionality [3].

- Enforces security by ensuring that only tasks allowed to run on a
  given CPU may request a DMA handle for it.

- Reference counting for DMAH life cycle management and safe usage
  across memory regions.

mlx5 driver implementation:
--------------------------
The series includes implementation of the above functionality in the
mlx5 driver.

In mlx5_core:
- Enables TPH over PCIe when both firmware and OS support it.

- Manages Steering Tags and corresponding indices by writing tag values
  to the PCI configuration space.

- Exposes APIs to upper layers (e.g., mlx5_ib) to enable the PCIe TPH
  functionality.

In mlx5_ib:
- Adds full support for DMAH operations.

- Utilizes mlx5_core's Steering Tag APIs to derive tag indices from input.

- Stores the resulting index in a mlx5_dmah structure for use during
  MKEY creation with a DMA handle.

- Adds support for allowing MKEYs to be created in conjunction with DMA
  handles.

Additional details are provided in the commit messages.

[1] Background, from PCIe specification 6.2.
TLP Processing Hints (TPH)
--------------------------
TLP Processing Hints is an optional feature that provides hints in
Request TLP headers to facilitate optimized processing of Requests that
target Memory Space.  These Processing Hints enable the system hardware
(e.g., the Root Complex and/ or Endpoints) to optimize platform
resources such as system and memory interconnect on a per TLP basis.
Steering Tags are system-specific values used to identify a processing
resource that a Requester explicitly targets. System software discovers
and identifies TPH capabilities to determine the Steering Tag allocation
for each Function that supports TPH

[2] Steering Tags
Functions that intend to target a TLP towards a specific processing
resource such as a host processor or system cache hierarchy require
topological information of the target cache (e.g., which host cache).
Steering Tags are system-specific values that provide information about
the host or cache structure in the system cache hierarchy. These values
are used to associate processing elements within the platform with the
processing of Requests.

[3] Processing Hints
The Requester provides hints to the Root Complex or other targets about
the intended use of data and data structures by the host and/or device.
The hints are provided by the Requester, which has knowledge of upcoming
Request patterns, and which the Completer would not be able to deduce
autonomously (with good accuracy)

Yishai
    
Yishai Hadas (8):
  pci/tph: Expose pcie_tph_get_st_table_size()
  net/mlx5: Expose IFC bits for TPH
  net/mlx5: Add support for device steering tag
  IB/core: Add UVERBS_METHOD_REG_MR on the MR object
  RDMA/core: Introduce a DMAH object and its alloc/free APIs
  RDMA/mlx5: Add DMAH object support
  IB: Extend UVERBS_METHOD_REG_MR to get DMAH
  RDMA/mlx5: Add DMAH support for reg_user_mr/reg_user_dmabuf_mr

 drivers/infiniband/core/Makefile              |   1 +
 drivers/infiniband/core/device.c              |   3 +
 drivers/infiniband/core/rdma_core.h           |   1 +
 drivers/infiniband/core/restrack.c            |   2 +
 drivers/infiniband/core/uverbs_cmd.c          |   2 +-
 .../infiniband/core/uverbs_std_types_dmah.c   | 151 ++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_mr.c | 170 +++++++++++++++++-
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 drivers/infiniband/core/verbs.c               |   5 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |   8 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |   2 +
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |   1 +
 drivers/infiniband/hw/cxgb4/mem.c             |   6 +-
 drivers/infiniband/hw/efa/efa.h               |   2 +
 drivers/infiniband/hw/efa/efa_verbs.c         |   8 +
 drivers/infiniband/hw/erdma/erdma_verbs.c     |   6 +-
 drivers/infiniband/hw/erdma/erdma_verbs.h     |   3 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |   1 +
 drivers/infiniband/hw/hns/hns_roce_mr.c       |   4 +
 drivers/infiniband/hw/irdma/verbs.c           |   9 +
 drivers/infiniband/hw/mana/mana_ib.h          |   2 +
 drivers/infiniband/hw/mana/mr.c               |   8 +
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |   1 +
 drivers/infiniband/hw/mlx4/mr.c               |   4 +
 drivers/infiniband/hw/mlx5/Makefile           |   1 +
 drivers/infiniband/hw/mlx5/devx.c             |   4 +
 drivers/infiniband/hw/mlx5/dmah.c             |  54 ++++++
 drivers/infiniband/hw/mlx5/dmah.h             |  23 +++
 drivers/infiniband/hw/mlx5/main.c             |   5 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   7 +
 drivers/infiniband/hw/mlx5/mr.c               | 103 +++++++++--
 drivers/infiniband/hw/mlx5/odp.c              |   1 +
 drivers/infiniband/hw/mthca/mthca_provider.c  |   6 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |   6 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |   3 +-
 drivers/infiniband/hw/qedr/verbs.c            |   6 +-
 drivers/infiniband/hw/qedr/verbs.h            |   3 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |   4 +
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |   1 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c  |   5 +
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |   1 +
 drivers/infiniband/sw/rdmavt/mr.c             |   5 +
 drivers/infiniband/sw/rdmavt/mr.h             |   1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c         |   4 +
 drivers/infiniband/sw/siw/siw_verbs.c         |   7 +-
 drivers/infiniband/sw/siw/siw_verbs.h         |   3 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 162 +++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/main.c    |   2 +
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   9 +
 drivers/pci/tph.c                             |  11 +-
 include/linux/mlx5/driver.h                   |  20 +++
 include/linux/mlx5/mlx5_ifc.h                 |  14 +-
 include/linux/pci-tph.h                       |   1 +
 include/rdma/ib_verbs.h                       |  31 ++++
 include/rdma/restrack.h                       |   4 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  32 ++++
 57 files changed, 905 insertions(+), 40 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_dmah.c
 create mode 100644 drivers/infiniband/hw/mlx5/dmah.c
 create mode 100644 drivers/infiniband/hw/mlx5/dmah.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c

-- 
2.50.0


