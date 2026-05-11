Return-Path: <linux-rdma+bounces-20341-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC/gJNNPAWq+UgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20341-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:41:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0797507B42
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52BC9300DDF2
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 03:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA7E37CD3E;
	Mon, 11 May 2026 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IzpdtJ1m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD8373BFB;
	Mon, 11 May 2026 03:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778470803; cv=none; b=jlCkad70iw+2owXExImU6JdEmAbW7kZpZgAM4V+VFWJMdO8tpzuHd9PU6W5ph7L+TnPrl9TRFVRpaiVNXmIA9TWk4Na9X5o/wJf2hQkKxU9sPPvw/r1z/ct7HEngleKRjD9XObCBFAYZs/QgzoD1LX2jm5mC3p/pNfHL7XODPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778470803; c=relaxed/simple;
	bh=K5sTpLkyuQTd6O0GFPhyVzlvdAfBILO0s5Ox3JuSfXA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u23EQ0NjEW5GMkE/FHoUbmJ1aYu22e9N0T+XgIyHxR+UfjUHbnCe8HGdozwF5y05W0RZLT96IN/3MUMHWMsOrZQHNi29etu0ZaBPafvINY3WVczR2SdJOAgYQixC4w6DkgAKz3r5J/3bC9apgCbJV5AFZok73Eu6b+kImBM8Ynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IzpdtJ1m; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AN05A52527619;
	Sun, 10 May 2026 20:39:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=WgoWlk0xucA9Ae4mtVj0RO/
	8F/uPjhS4rWh4am5Be/k=; b=IzpdtJ1mnSuMRCw/P2T6ubYwSUwqtICF4WJ5JIh
	upyX+LyUXkx16i6o9zmApYtd/1PY7Ep0oQ8E2lzejWcC3K/u5ZUe4YDFlHThZhjk
	+guCSauILRHCPkLu9sD9EWLwqVh0JBMIFD86PHGsN5H61yImf7GCyOiXdkOFINoD
	NQQ/xEvl2Rn6jlEsli8dFmWIrFxyMtEHh6lCr+NWtItEi55k6Plo5FKemZeZoTIT
	SX35BC4jVaIN2FufwopKe8EjKpRgZ6qmDH1OrnXOgsKvd2hIe9gVgilpe/ts4ki0
	rJ5UrG7LWCBhsHXqKUh8PHslfyLtRlauSKGhF6TcaM91kAA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e24ejaxuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 20:39:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 10 May 2026 20:39:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 10 May 2026 20:39:39 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 013803F708D;
	Sun, 10 May 2026 20:39:30 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <oss-drivers@corigine.com>
CC: <akiyano@amazon.com>, <andrew+netdev@lunn.ch>,
        <anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
        <brett.creeley@amd.com>, <darinzon@amazon.com>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
        <idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <leon@kernel.org>, <mbloch@nvidia.com>,
        <michael.chan@broadcom.com>, <pabeni@redhat.com>,
        <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
        <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
        <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
        <vadim.fedorenko@linux.dev>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v13 net-next 0/9] octeontx2-af: npc: Enhancements.
Date: Mon, 11 May 2026 09:09:14 +0530
Message-ID: <20260511033923.1301976-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=c5qbhx9l c=1 sm=1 tr=0 ts=6a014f7d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=1rdZWFfAsYpIarNArpIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: gr4dMvPT2pn0yEUlC34eUsUwkaFnA-UK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAzNiBTYWx0ZWRfXxOFUGU+UR3q8
 0G4RZDTjzZ9dFnxUdlG/jyiqlnB8cWT4tOifs4rV4CC8x44Yw3SyjtAWxcW2DTjzLXh36AqDsyV
 0+EIvW7Dc2AM4TUMtwdvlelCepqJIIsRM6j5paK9cFhEqmccJBTfzSjPh7UJgxBKJxFpR7UfoWi
 YUP8S0oJMq9iGdUdPTcJ81lc0tz5M9upx2aLTkMSutjo6GS1cVslxKwUHsFqQ00rreFuQprz4o6
 wOfhdeumme4AbmPiFXls8E+/8pSJTGhYpVQT7KsugyIWgaKWcx58J6W7z7GfSpJx/P2M0iDAXpR
 Nz9lHs8dhTUmo8U+NXtRR1NsOg0gWvyJDF3181pB9uXXhbwsk6xDtkBVDq0ZV6x8fNheu20Oble
 yupe8gtsM3ukggKrUpZ0FVSvEZiY5EqWre9E/vdpMwi9QbRql4nA+eoWAR6H5+mTQnfrm8tqUrM
 O/da+DI00zxRTjJI5Qw==
X-Proofpoint-GUID: gr4dMvPT2pn0yEUlC34eUsUwkaFnA-UK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: F0797507B42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20341-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

This series extends Marvell octeontx2-af support for CN20K NPC (MCAM
debuggability, allocation policy, default-rule lifetime, optional KPU
profiles from firmware files, X2/X4 MCAM keyword handling in flows and
defaults, and dynamic CN20K NPC private state), adds a devlink mechanism
for multi-value parameters, and adjusts devlink param netlink helpers
and mlx5 so stack usage stays within -Wframe-larger-than limits once union
devlink_param_value grows.

Patch 1 improves CN20K MCAM visibility in debugfs: mcam_layout marks
enabled entries, dstats reports per-entry hit deltas, and mismatch lists
enabled entries without a PF mapping. MCAM enable state is tracked in a
bitmap updated from the CN20K enable path.

Patch 2 reduces stack usage in mlx5e_pcie_cong_get_thresh_config() by
reusing a single union devlink_param_value across four
devl_param_driverinit_value_get() calls (instead of union devlink_param_value
val[4] on the stack) and assigning each vu16 into mlx5e_pcie_cong_thresh,
so the helper stays under the frame-size warning limit as the union grows
(patches 3-4).

Patch 3 changes devlink_nl_param_value_put() and
devlink_nl_param_value_fill_one() to pass union devlink_param_value by
pointer instead of by value. Passing two copies of the union by value in
the param netlink path consumes over 500 bytes of argument stack and risks
CONFIG_FRAME_WARN as the union grows beyond its historical size (patch 4).

Patch 4 (Saeed) introduces DEVLINK_PARAM_TYPE_U64_ARRAY and nested
DEVLINK_ATTR_PARAM_VALUE_DATA attributes so drivers and user space can
exchange bounded u64 arrays; YAML, uapi, and netlink validation are
updated.

Patch 5 adds a runtime devlink parameter srch_order to reorder CN20K
subbank search during MCAM allocation.

Patch 6 ties default MCAM entries to NIX LF alloc/free on CN20K, adds
NIX_LF_DONT_FREE_DFT_IDXS for PF teardown paths that must not drop default
NPC indexes while the driver still owns state, and tightens nix_lf_alloc
error propagation.

Patch 7 allows loading a custom KPU profile from /lib/firmware/kpu via
module parameter kpu_profile, with cam2 / ptype_mask wiring and helpers
that share firmware-sourced vs filesystem-sourced profile layouts.

Patch 8 makes default-rule allocation, AF flow install, and PF-side RSS,
defaults, and ethtool flows respect the active CN20K MCAM keyword width
(X2 vs X4), including X4 reference-index masking and -EOPNOTSUPP when a
flow needs X4 keys on an X2-only profile.

Patch 9 replaces file-scope npc_priv and static dstats with allocation
sized from discovered bank/subbank geometry, threads npc_priv_get()
through CN20K NPC paths, and allocates dstats via devm_kzalloc for the
debugfs helper.

The mlx5 change sits immediately before the devlink patches so the series
applies cleanly and stays warning-free when built incrementally;
pass-by-pointer precedes the U64 array type so helpers are not copying an
even larger union by value. The CN20K patches keep srch_order ahead of
NIX LF coordination, KPU-from-filesystem, X2/X4 handling, and the npc_priv
refactor that touches the same files heavily.

Ratheesh Kannoth (8):
  octeontx2-af: npc: cn20k: debugfs enhancements
  net/mlx5e: Reduce stack use reading PCIe congestion thresholds
  devlink: pass param values by pointer
  octeontx2-af: npc: cn20k: add subbank search order control
  octeontx2: cn20k: Coordinate default rules with NIX LF lifecycle
  octeontx2-af: npc: Support for custom KPU profile from filesystem
  octeontx2: cn20k: Respect NPC MCAM X2/X4 profile in flows and DFT
    alloc
  octeontx2-af: npc: cn20k: Allocate npc_priv and dstats dynamically.

Saeed Mahameed (1):
  devlink: Implement devlink param multi attribute nested data values

 Documentation/netlink/specs/devlink.yaml           |   4 +
 drivers/dpll/zl3073x/devlink.c                     |   6 +-
 drivers/net/ethernet/amazon/ena/ena_devlink.c      |   8 +-
 drivers/net/ethernet/amd/pds_core/core.h           |   2 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |   6 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |  30 +-
 .../ethernet/marvell/octeontx2/af/cn20k/debugfs.c  |  16 +-
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c  | 542 ++++++++++++---------
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.h  |   6 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   1 +
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |  17 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |  12 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    | 114 ++++-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  69 ++-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    | 486 ++++++++++++++----
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.h    |  17 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |  12 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |   4 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |  48 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   6 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |  14 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |  72 +--
 .../mellanox/mlx5/core/en/pcie_cong_event.c        |  45 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/lib/nv_param.c |  12 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c         |   8 +-
 drivers/net/ethernet/netronome/nfp/devlink_param.c |   6 +-
 drivers/net/netdevsim/dev.c                        |   4 +-
 include/net/devlink.h                              |  12 +-
 include/uapi/linux/devlink.h                       |   1 +
 net/devlink/netlink_gen.c                          |   2 +
 net/devlink/param.c                                | 120 +++--
 35 files changed, 1175 insertions(+), 536 deletions(-)

--

v12 -> v13: Addressed David Laight comments
	https://lore.kernel.org/netdev/20260508034912.4082520-1-rkannoth@marvell.com/

v11 -> v12: Addressed Paolo,Jiri comments.
	https://lore.kernel.org/netdev/20260409025055.1664053-1-rkannoth@marvell.com/
	Added one patch which was rejected by simon in net
	(as it was kind of enhancement rather than a bug)
	Added one more patch- which allocates two variables from heap.

v10 -> v11: Addressed Paolo comments.
	https://lore.kernel.org/netdev/20260403025533.6250-1-rkannoth@marvell.com/

v9 -> v10: Addressed Paolo comments
	https://lore.kernel.org/netdev/
	20260330053105.2722453-1-rkannoth@marvell.com/

v8 -> v9: Addressed Simon comments
	https://lore.kernel.org/netdev/
	20260325072159.1126964-1-rkannoth@marvell.com/

v7 -> v8: Addressed Simon comments
	https://lore.kernel.org/netdev/
	20260323035110.3908741-1-rkannoth@marvell.com/T/#t

v6 -> v7: Addressed Simon comments
	https://lore.kernel.org/netdev/20260320165432.98832-1-horms@kernel.org/

v5 -> v6: Addressed Jakub,Jiri comments
	https://lore.kernel.org/netdev/
	20260317045623.250187-1-rkannoth@marvell.com/

v4 -> v5: Addressed Jakub comments
	https://lore.kernel.org/netdev/
	20260312022754.2029595-6-rkannoth@marvell.com/

v3 -> v4: Addressed Simon comments
	https://lore.kernel.org/netdev/abDeXLpMMxp7G1v3@rkannoth-OptiPlex-7090/#t

v2 -> v3: Addressed Simon comments.
	https://lore.kernel.org/netdev/
	20260304043032.3661647-1-rkannoth@marvell.com/

v1 -> v2: Addressed Jakub comments.
	https://lore.kernel.org/netdev/
	20260302085803.2449828-1-rkannoth@marvell.com/#t

2.43.0

