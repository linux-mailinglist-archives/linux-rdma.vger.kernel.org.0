Return-Path: <linux-rdma+bounces-19136-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VLgyMLMU12k1KwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19136-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 04:53:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 808873C5BF4
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 04:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E552C304A853
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 02:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7D636EA98;
	Thu,  9 Apr 2026 02:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="in2veTug"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF0E37189A;
	Thu,  9 Apr 2026 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703086; cv=none; b=EEjrRP1rzz2ofUWHsTNXEQMTzGpXeQWIPjLp0lmEA+y+OkLpDTttJo/mvxC26MAH050ilxIIHt1RrJfrLNcBLz+5badOB9sy35mJfG8zqOzVPfRhCOSquiyP4pGFuR5q5ctX5mt/ThX8zpbyVSK2BfVJHWz9SAmIurtdlN2hBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703086; c=relaxed/simple;
	bh=V3c39Bzan/cnfF5DQ4Up51R2u9sZEVWnXiDfpWzquLY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XjGJBUmEKY/0WetVXwx+NL4GlItdUM1T4S2lSUc5K673YTBERB77Ua5S07v1v+I/93rvwirIj/jPz0x5CbbERJKXxpCNDlhwFnF0H50GMU3ffev22Fe9EKKaxLBxr+riz5yHNPlOUCNkyz+9l1HGmsi76BVhyGHB2gdAwCXPN8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=in2veTug; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638Gn2a13663028;
	Wed, 8 Apr 2026 19:51:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=xyClrOVlUkr8maUBqiflIeD
	hLIlfzfRFe43eFq9WtKM=; b=in2veTugi67MSnot6LUP0MH9JcFYCbPe4gAoD2K
	ns99+I3nU3ryEcb1IqTcFdF/VsCv06qogWGLEpEY1mkSJLfQsDRUrVMjXYxe57bs
	0E+WpIpJamyZetLOOSEfInPy98jVv7m1lgEa+R8cJOPwhT/LYCP4lwAs7A5bmWYZ
	/IZwi+lCLvh8bsbBsRADLmKJc9IvmTzhJ1KBoq/yqzRXfPX2+F49Qev82XNfh5U/
	cHLKb5wo6nd0gfSL98L7VFG4IgavjEnQ0U49ClOIC+w+Xso9iIw0Si69Z5j0Sd0l
	fPd8cuRyBb8w8wj/9m+Day4SoXBjQUuU4H0x9qDTfd9puXg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ddtb31e2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 19:51:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Apr 2026 19:51:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Apr 2026 19:51:07 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 6F57F3F7055;
	Wed,  8 Apr 2026 19:51:01 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
CC: <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <donald.hunter@gmail.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
        <mbloch@nvidia.com>, <dtatulea@nvidia.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v11 net-next 0/7] octeontx2-af: npc: Enhancements.
Date: Thu, 9 Apr 2026 08:20:48 +0530
Message-ID: <20260409025055.1664053-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=K7wS2SWI c=1 sm=1 tr=0 ts=69d7141c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=F3GfQixlnA_JdfTOFKwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAyNCBTYWx0ZWRfX4yP2pW2ecP+k
 FLLLozDdRq9NqTLjlRP46IPh7XtHSMpT6+CVTGi0HZ1t4Npw1kif7cGbMncOGTUieS6/jUQJpqf
 tZartJblL2/a9fwHP68sKNcsZJRMc2rLW/HWtFkyxuE55OdFHUv1ilRFww8FZew8a5vJhHc+u5D
 2NercPg1BdmcsA1rOPKKRalmsG5ziqk7icPxn9FZ04SNp5m6I7c62T04558ZerPE2yuyCza/Rdx
 9/OsSyFGWTgHw17pur3lBV5nLR1SVc1dQJ5bjYrOqlzqfcLZ0x8xb5RpMaof/mCNEVSxLm1IHSr
 aIIJOJY5YwNGrvqNWNd2msqY9aVjbeHdQyLwodVjex4HjiLLCJtne2xAlAAgog/bQBFXutOSb8/
 wJvNYxRcXXRvOI0+Qr8w6ypOLjGiO2fHpzhJsAAaYqJ108Z/Y0qXVqymQSIHDA8meHTvcYRHLz1
 ZdZQJAetZlJQrGqH5hQ==
X-Proofpoint-GUID: BG0uoosMAwZfJO-oLRY9OTCQtmbzP5lx
X-Proofpoint-ORIG-GUID: BG0uoosMAwZfJO-oLRY9OTCQtmbzP5lx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19136-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 808873C5BF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series extends Marvell octeontx2-af support for CN20K NPC (MCAM
debuggability, allocation policy, default-rule lifetime, and optional KPU
profiles from firmware files), adds a devlink mechanism for multi-value
parameters, and adjusts devlink param netlink helpers and mlx5 so stack
usage stays within -Wframe-larger-than limits once union
devlink_param_value grows.

Patch 1 improves CN20K MCAM visibility in debugfs: mcam_layout marks
enabled entries, dstats reports per-entry hit deltas, and mismatch lists
enabled entries without a PF mapping. MCAM enable state is tracked in a
bitmap updated from the CN20K enable path.

Patch 2 heap-allocates the temporary devlink param value array in
mlx5e_pcie_cong_get_thresh_config() so a larger union devlink_param_value
does not overflow the stack (patches 3-4).

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

Patch 6 ties default MCAM entries (broadcast, multicast, promisc, ucast)
to NIX LF alloc/free on CN20K, adds NIX_LF_DONT_FREE_DFT_IDXS for kernel
PF suspend-style teardown, and adjusts free-all and default-entry paths so
default rules are not freed as ordinary user rules.

Patch 7 allows loading a custom KPU profile from /lib/firmware/kpu via
module parameter kpu_profile on non-CN20K paths, with cam2/ptype support
and shared helpers for firmware-sourced vs filesystem-sourced profiles;
CN20K continues to use its existing custom KPU apply path.

The mlx5 change sits immediately before the devlink patches so the series
applies cleanly and stays warning-free when built incrementally;
pass-by-pointer precedes the U64 array type so helpers are not copying an
even larger union by value.

Ratheesh Kannoth (6):
  octeontx2-af: npc: cn20k: debugfs enhancements
  net/mlx5e: heap-allocate devlink param values
  devlink: Change function syntax.
  octeontx2-af: npc: cn20k: add subbank search order control
  octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM
    entries
  octeontx2-af: npc: Support for custom KPU profile from filesystem

Saeed Mahameed (1):
  devlink: Implement devlink param multi attribute nested data values

 Documentation/netlink/specs/devlink.yaml      |   4 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 126 +++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 272 +++++++--
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  10 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  17 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  12 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  92 ++-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  69 ++-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 571 ++++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |  17 +
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   4 +-
 .../mellanox/mlx5/core/en/pcie_cong_event.c   |  11 +-
 include/net/devlink.h                         |   8 +
 include/uapi/linux/devlink.h                  |   1 +
 net/devlink/netlink_gen.c                     |   2 +
 net/devlink/param.c                           | 117 +++-
 18 files changed, 1077 insertions(+), 258 deletions(-)

--

v10 -> v11:
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

