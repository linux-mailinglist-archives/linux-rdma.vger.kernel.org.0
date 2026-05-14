Return-Path: <linux-rdma+bounces-20652-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP3DNhprBWo+WwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20652-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:26:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AAC53E46B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2596D301C783
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E133C2BA7;
	Thu, 14 May 2026 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fI9ba2nz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41133F5B9;
	Thu, 14 May 2026 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778739992; cv=none; b=SyC5TGhREWWdq4lXr3HdxczNibda/8UA9ykeR03CmJM4fwnogeq0CGZ7KE/GJJDDynwFER84Xv4SbV4KiVbtPZm77LkvZM2gHstIDMeDGtMIshMAKW5L1F4yPWfI57X4GEFY0/cdkML0Fq1tP0TBgtisFqE1ry+01zCRebI0SnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778739992; c=relaxed/simple;
	bh=IUjSWSafV35IhpQoPVYxuAvf2ly63CGQEjxIiWr5CHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KwqxkFe+xLWr0EzunCfUNJQ27uZilqh9CXv1/wczWdzZ6BsgIilXKfbW0eXvRtgLDt2JAO/pj0Sl2ga6kbCmhj48xZzpl+92Q5XIrxKzFfQv4qCPv732wPhS8bDNkA0KfzE91StVNMluvrXrtXpLUCLs8Ze3SbF/Zn3QAlGhmLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fI9ba2nz; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E2AbxC2549951;
	Wed, 13 May 2026 23:25:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=hMysuiiOXHeVxvCsF4wMs5z
	3zV6v1S8Py2HULIEjojY=; b=fI9ba2nzn2uz/jbzDIS0tld8KCBEQhVE9L1MfyL
	I0CvLcOp5Hmfqu0ZCiHc4r6ZZp2eMtqmnmDyiJIXGjdMLIW6LaA9bivQxIDyoj3L
	h3Xpd7fN44ks05vrfEPAxx6JVl4F6eNR83pCgTUQJACZZNEGVw+/56HMw/yL8+hc
	wZokvm3GfC7mU82IV8t/5wg11+5D1s5l0GxY8Uds0r8sv28u597jK5qKiray8Ku4
	zCfH3hmmlQ1XzxVFfV35a7BZsVIc895lmMZKzVo8YDbKN1xQY4fS3pUegL1aFqyn
	rNb8icLB307X9fx7eNYpGsB91ZFuF+si6V1f7FgyyJq7v9g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e45ybe48q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 23:25:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 May 2026 23:25:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 13 May 2026 23:25:56 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 00B605B693F;
	Wed, 13 May 2026 23:25:47 -0700 (PDT)
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
Subject: [PATCH v14 net-next 0/9] octeontx2-af: npc: Enhancements.
Date: Thu, 14 May 2026 11:55:28 +0530
Message-ID: <20260514062537.3813802-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WAW26jAu9giEhNXil23YmcBI_uVHdS5a
X-Proofpoint-ORIG-GUID: WAW26jAu9giEhNXil23YmcBI_uVHdS5a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2MCBTYWx0ZWRfX+2UMNs1bndDn
 kGPeZV23cap2MV0VBJ/rcdf7DxuCQGgtzoYhUesBTIN7y7pevjEPTQ/UZ87qaO2+X6aKBQV+PNp
 Uvlc6RFB2cob3TE/VtpL1IhRKBfZlCon2d8TftAnS8mO+jlnHZEK8JfkaOYuWoRf4tp+Nw9/m/a
 tcZVCRtqhVyBcx5MuGEsFICUAbL/yFBG1QVOT7Rs/OJ5YDINq6AXEHihgPdPqY1YuZsCDeuzauT
 8qvhPjrJmiPiAx+ltklHhhmIh6npFc364ojDhNoLGiFwtqAnV/tDailHi9G/IGdPuwUgUJx7Xzp
 USt9cO+sXwtkSvmjYa9tjdNjANvy5o06DTnxdAdSwtF+DFAkw7JB+21IrH/LPfbBQfdO1EiD3Ex
 G9FK4q3qmrb0gQV2KcvPa2eIAzsLVwdh1S7Wj5siIBIhDxZGS0kNFPjUtoriaaSuOaJhpB2Tvj/
 tkNXbK/kdWSZt4eAq/Q==
X-Authority-Analysis: v=2.4 cv=ZtTd7d7G c=1 sm=1 tr=0 ts=6a056af5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=1rdZWFfAsYpIarNArpIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: C6AAC53E46B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20652-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
devl_param_driverinit_value_get() calls (instead of
union devlink_param_value val[4] on the stack) and assigning each vu16
into mlx5e_pcie_cong_thresh,
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

v13 -> v14: Addressed sashiko comments.
	I had to revert Jiri comment in v11 as sashiko was complaining about
	leaking kernel memory to userspace.

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

