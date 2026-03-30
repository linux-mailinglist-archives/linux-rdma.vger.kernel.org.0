Return-Path: <linux-rdma+bounces-18775-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKQ1DGQLymmL4gUAu9opvQ
	(envelope-from <linux-rdma+bounces-18775-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 07:34:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C194D355988
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 07:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B685303DD17
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 05:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33931E854;
	Mon, 30 Mar 2026 05:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="j2OSyIBA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5B237E31E;
	Mon, 30 Mar 2026 05:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848724; cv=none; b=ce+gqd7m4UHTJmEX19APbclhQUdYgEUK9a2Ptu+nkY7eCB+zi+4pBqIY1uFH5U1CRKnuvPBDkjdCPDOKmfqbzja+8rxS7g+m2BZo9VAK1R2G1q8RhSveSEY5hhRHEQUii+CxFDEyFV7v+Tn3ehwWDmkmnYz1NjU+1JKiho/6ZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848724; c=relaxed/simple;
	bh=AaK4KvRkyuGNIx0jc7ZYNo5IO0Z7vOXrAQtywxEzheM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e+4Eq9fJpPY6JxHzFl/WoCGo4s2fgLDdGuob74T4p0A6O4qTmUUdad2QhHeQFTHbTCbe988Hq4nntq9vRodcgN31/4tfZ6eaZJkkrZ0eXY1h3fTEb1+Cm5hBfmRg1ltmEt2wNY9VboC47nKLm7VIxA7qbc+CJVzEcGu/DGYa1VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=j2OSyIBA; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TNXE4C260885;
	Sun, 29 Mar 2026 22:31:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=e9gRS3Lu47lHcZeO6D3XS3W
	6YQngVOiTajVudI9WIbU=; b=j2OSyIBAjjYGIrQJZ3bt5/n+aujCA3Z1IhKWFe7
	oncqlB4MBs5W8zNoJv0VcWP+fVyp8pdscbXfhw1sWYALw2BZ7SNbb5HJsKPpV/SG
	EXLgldASdH8ofmBLmawSGnBqOxdi+eNECPgJvn7W87nQkD1LpRSfnPTi0w1BMLoO
	45Ly2zZfIPodP73WcC4HJMgsiiVNqIONlKcK65ipeXpWNgnJTRHLvjom3dGd3PVe
	PBHXu6IHabKaNWlqqOzx+VcQbesA1LyNYZOYlH0ooUJv/6OMLGMMYrZeRw6nf6bN
	epeNBZSBPJZM5X6czTIAUhyvS9mjatRJd8MnxnZLpdZZAPA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d6cbjtxky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 22:31:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Mar 2026 22:31:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 29 Mar 2026 22:31:40 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 0F66D3F706F;
	Sun, 29 Mar 2026 22:31:33 -0700 (PDT)
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
Subject: [PATCH v9 net-next 0/6] octeontx2-af: npc: Enhancements.
Date: Mon, 30 Mar 2026 11:00:59 +0530
Message-ID: <20260330053105.2722453-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA0MCBTYWx0ZWRfX0X47boP64uNk
 EqIwJJRgqARjRUY0wjOycRJxuLh/gsCpvwhBSGE3MT54z5uBGsf4/Khy5/UrCEyVFOiyfdreNXH
 Nuc/v0PhR3Nhc1zOS3yiplf0U6dqXygc/T1NmvQVpdFqMToOnmtH3xWtWMCPjX536XkVkAEuq1m
 0c4G0isZTJHXwNjL+Bs2HtIFHKuQjnECnLQEMJQVsM5cMgOsEsMbKjbzhBViYVgauXakPUfUU4b
 pZtNMui0aqFHtTSkTh6S4OPeP1OhaqPVMhF1lLFTPbJla8/1PY7P9ZziBMZVkgUOKUekFaxcEr3
 Wmy3JPJiquVId+YJsGNWpa7UGQqqa61SnoGOf1nBNX+1GQvS5LrGHS/mxUxcr/nME1m7KcXPMUf
 Jzlr0J0Tzrc6uwPt0yKoA2HBrHSPHqLt7kn90HAmHtRYV0/H/BZzwIH6atnVFdduWXSVCyRxlhE
 rqMlTtStTXFvd2dpDHg==
X-Proofpoint-GUID: rIvAaNnvVZR6Wje_WhtXR3EuSNKs5K2b
X-Authority-Analysis: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=69ca0abd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=F3GfQixlnA_JdfTOFKwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: rIvAaNnvVZR6Wje_WhtXR3EuSNKs5K2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-18775-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C194D355988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series extends Marvell octeontx2-af support for CN20K NPC (MCAM
debuggability, allocation policy, default-rule lifetime, and optional
KPU profiles from firmware files) and adds a devlink mechanism for
multi-value parameters, with a small mlx5 follow-up to keep stack usage
within -Wframe-larger-than limits once union devlink_param_value grows.

Patch 1 improves CN20K MCAM visibility in debugfs: mcam_layout marks
enabled entries, dstats reports per-entry hit deltas, and mismatch lists
enabled entries without a PF mapping. MCAM enable state is tracked in a
bitmap updated from the CN20K enable path.

Patch 2 heap-allocates the temporary devlink param value array in
mlx5e_pcie_cong_get_thresh_config() so a larger union devlink_param_value
does not overflow the stack (patch 3).

Patch 3 (Saeed) introduces DEVLINK_PARAM_TYPE_U64_ARRAY and nested
DEVLINK_ATTR_PARAM_VALUE_DATA attributes so drivers and user space can
exchange bounded u64 arrays; devlink_nl_param_fill() moves large locals
to the heap as well.

Patch 4 adds a runtime devlink parameter npc_srch_order (U64 array) to
reorder CN20K subbank search during MCAM allocation.

Patch 5 ties default MCAM entries (broadcast, multicast, promisc, ucast)
to NIX LF alloc/free on CN20K, adds NIX_LF_DONT_FREE_DFT_IDXS for kernel
PF suspend-style teardown, and adjusts free-all and default-entry paths
so default rules are not freed as ordinary user rules.

Patch 6 allows loading a custom KPU profile from /lib/firmware/kpu via
module parameter kpu_profile on non-CN20K paths, with cam2/ptype support
and shared helpers for firmware-sourced vs filesystem-sourced profiles;
CN20K continues to use its existing custom KPU apply path.

The mlx5 change is placed immediately before the devlink union growth
so the series applies cleanly and stays warning-free when built
incrementally.

Ratheesh Kannoth (5):
  octeontx2-af: npc: cn20k: debugfs enhancements
  net/mlx5e: heap-allocate devlink param values
  octeontx2-af: npc: cn20k: add subbank search order control
  octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM
    entries
  octeontx2-af: npc: Support for custom KPU profile from filesystem

Saeed Mahameed (1):
  devlink: Implement devlink param multi attribute nested data values

 Documentation/netlink/specs/devlink.yaml      |   4 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 126 ++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 255 +++++++--
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  10 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  17 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   6 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  92 +++-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  16 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 521 ++++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |  17 +
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   6 +-
 .../mellanox/mlx5/core/en/pcie_cong_event.c   |  11 +-
 include/net/devlink.h                         |   8 +
 include/uapi/linux/devlink.h                  |   1 +
 net/devlink/netlink_gen.c                     |   2 +
 net/devlink/param.c                           |  91 ++-
 18 files changed, 979 insertions(+), 206 deletions(-)

--

v8 -> v9: Addressed Simon comments
	https://lore.kernel.org/netdev/20260325072159.1126964-1-rkannoth@marvell.com/

v7 -> v8: Addressed Simon comments
	https://lore.kernel.org/netdev/20260323035110.3908741-1-rkannoth@marvell.com/T/#t

v6 -> v7: Addressed Simon comments
	https://lore.kernel.org/netdev/20260320165432.98832-1-horms@kernel.org/

v5 -> v6: Addressed Jakub,Jiri comments
	https://lore.kernel.org/netdev/20260317045623.250187-1-rkannoth@marvell.com/

v4 -> v5: Addressed Jakub comments
	https://lore.kernel.org/netdev/20260312022754.2029595-6-rkannoth@marvell.com/

v3 -> v4: Addressed Simon comments
	https://lore.kernel.org/netdev/abDeXLpMMxp7G1v3@rkannoth-OptiPlex-7090/#t

v2 -> v3: Addressed Simon comments.
	https://lore.kernel.org/netdev/20260304043032.3661647-1-rkannoth@marvell.com/
v1 -> v2: Addressed Jakub comments.
	https://lore.kernel.org/netdev/20260302085803.2449828-1-rkannoth@marvell.com/#t

2.43.0

