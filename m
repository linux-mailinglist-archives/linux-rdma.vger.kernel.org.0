Return-Path: <linux-rdma+bounces-17218-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGIBMJFUoGlLiQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17218-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:11:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 261131A7436
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1EBB31D2BA5
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E039A7EE;
	Thu, 26 Feb 2026 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P3K2vVIp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9339C653;
	Thu, 26 Feb 2026 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113967; cv=fail; b=T2bQx9bhBEGietm6wzSQrIAm4GAsRe9auODW72lHbencG3Yd+5XJar17YNzA78tUGpILXa/OVo+xPH+Js+QLGUVI/GszLR1Mam8T7xMJvWKCIOzHFXVWQIFze0LKEaj6UrwM3HcnFVm78Amr6khrcBtKw16gryEqcL88kj+GPg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113967; c=relaxed/simple;
	bh=2vUE/sSw/zpm5rsZ5iuEKTC1FGjwM6JrqUiBPOGYGxc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=LsmjaB3xHpnktodPty0yBxrCwpV7THGQNOYDgErUK9VzU1XI5eX3V+AWcpo/V5MvyFmn+rchkn77dtdT7QHr/umhKLc5b85RiVMtRBsmCFZv+zp/f74aFT68eFIOHcZArzwX6oFVTkMZCJoHN73MXHnyY/KGQNqtaxbJOk3sbd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P3K2vVIp; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWmsVdXW80DocbS7olJltn3zJTIU3KSsm8+p67mBHs5B2n32HObLzU4a0nkE1T9VpVE8tsGMEpy8o0ddQtbQnuTuSiVmfBRkNlP2ek/t2FJYL7OxkKjmjKDwzHyjvROeYsovRDC6vWN6eLrraPESv7n7DVRPCq7TX1G1rDO/nfcR1qqi49idi4G2zgMZzBr6SzI/9FZ2w8S6mRKYK02VleMqhY3MOFXGNqXgKlhUmerRwKVYKKaCR1pDSoFprFp1JSt7el8THIFzJM9F/2j635ApWugTDdgWYu5rMA12/mHpqRYAKFZQX/TEpfcn3cwp1ITz8/OUF6cZ7Nn1TgCjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shobShaWk4h2RPRSN9el9LrjkQnVXsSTbbX9nqIoc7o=;
 b=OIuvtAnQmFuCaQBylUH2nrr/n0fvgFAMFhOz0gAnSkPD5604KrzaIQYOWZSIltHEpyfJyhsPZZW8492cs9dvcK5uhiUPeJQfIWYZkkh1h1P1E8Ofvw0VI6QyapmAbd+6vVK5geGBf14WzgeUYfL7s5UjDLtWK+TyjtvKE8OqK8Tjyaxi29TCgR6YHpk6mTu0V6qkXhSiCmrSb2qL3gXGuCdDNw3/d0yA+Nu5ihA2mvvs4yuOchqB3NVnvTAy1dKkLZ7iS5+xT6FdE0c7a/yXl+Mot0nLXoLtF6rOaeM5oLcjQIBEyyNUCmur/tBS6U14zJjsW/groox6jVnIvUChLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shobShaWk4h2RPRSN9el9LrjkQnVXsSTbbX9nqIoc7o=;
 b=P3K2vVIpNFJ9AMPoRBnNA1QaH48YEcpwWQft447nUehoZRcvXjkjLhItBxs1Qtn3eA+JqoyVfiVYYm7ioYGl8fKiisFDfh9K4RI6FupEa28pfsBHqsBSmLJAmlFL9cQTydlisteJCv8xZks/tAonzYT5M2MZCHQE1Iv1pN2wXYh6+27BE0RZnQR32Jo9PIVfZ7O+M7Av2kktmWvLnif0SxLnrCNuCIiV7w4CcD7zU7bDYs2zQIwe8yuu8na/SMSN9Lr1eHwrDz4gAdFZoxiI9yOpCXDCWnsvPNx8NpYk3FTrHRX2EA62X+nj8KtoQ1t32hE3+blotGbI+mvnWd68dg==
Received: from MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22) by
 IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 13:52:39 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::13) by MN2PR01CA0053.outlook.office365.com
 (2603:10b6:208:23f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 13:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:52:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:52:23 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Feb 2026 05:52:23 -0800
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 05:52:19 -0800
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next v4 00/11] RDMA/core: Introduce FRMR pools
 infrastructure
Date: Thu, 26 Feb 2026 15:52:05 +0200
Message-ID: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAZQoGkC/23N3wrCIBQG8FcJrzP8M4d21XtEhNNjE9ocOmQx9
 u6JEDHq5sDHOb/vrChB9JDQ+bCiCNknH8YSmuMBmV6PD8DelowYYYJS2mIXh3ifQngm7CTjxgi
 QWkhUwBTB+aWWXVG0g8YjLDO6lVXv0xziq77JtB78a8wUEyyg40Y6YZRpLmP21uuTCUPtyexrG
 WM7y4p1pNVKGa0Flz+Wf2xLythZXmwnGyLAKgud3tlt2968qGfFKAEAAA==
X-Change-ID: 20251116-frmr_pools-f823cc5e8a58
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Chiara Meiohas <cmeiohas@nvidia.com>, "Yishai
 Hadas" <yishaih@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113939; l=6425;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=2vUE/sSw/zpm5rsZ5iuEKTC1FGjwM6JrqUiBPOGYGxc=;
 b=m9rd1DlGIHo0GKaBWDfD/0if4XIo+AwT+m/yR77lTnKxVUMvoAnbQqPkprp4pQdu7SoGc9+sh
 z5bD7EA6x6rD6kjfSoec0tOHxSS6BjMnfF32VTavD8eyI6iCop24MeA
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: b84dcfee-3c63-4244-887f-08de753e4df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	UlfQvOk0HWYnHJ6eRE50b/k3yYLHtnN96uvvfsbAj7jXgT8jDnn6mzVC4z8co7JGUVmehcN5ZwXZ3pK+Qx0tpyN5934GrEVCpgklFUGEEkws285vxnpYMga6xUcuurJzSb5wt13wTcbagFtYERMVxT0nZZEvNIyIT9ell/NPq9JOfKjhqbvFozGXA7eyZVJ9SEQCNhoXBEeUnRs0K66LtQpTITGDkfSw/w1m5Xs++xm5f2G6ZdoVJQ3B6NJo/jYbcCVKDKn8mmS2/pq9rw7jnQMDm+eRiPfGFT8dk67foOU+R85qds5tIs4BpOMLJpAHbPHrfuhtFxN9h+08t2HgEjfrJPRCKCWYnPl5LuyxthHV+3MALXh6SYJVDS0yZMhXNQlxhldyp/pc/jKrpv+dYvEdNeOYbwZk80gJ3SvUPu5d22v1w/pa5N84tro9HqdVOZ/QZ/Yz51apJZVe0ldqooXQIbTtkCzKC0qOtsyDE7eimcwOuC9tMT1JBsTO/Kw5HddZCFJFXJTQhy94T/2JXSuRp72OGSpCCHGI6ymh8z/0mRHOh2R+cY6IauuoMynIFRbMOzcesAyeGxv/Xci5DBFMv2q4FflBJqgbKkEY1GnrY949k2h79AvZ5v9z6T4+WBKQvx1Yqeudrz2zhxxZCwRqHebLgXqE03JbZM7AuXlbygeGaGbuOx/T+FhS1sR9JcFzFUeSU2iCwfAmrRfzUSevO6YQuPkzQhvY7qr2d3T9Xjs22csH6e5iQIS7y5mTOyuYmaIeVPPCor29Hqf83aBc/3T4L2MxpZTMoKnxgq57pf1HsgwAaE5sbuT+vnzfACC1FqE2YIVQPXo2NXXr6BY+tlMs7npRKaedRxekSp4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QUpzWlxMzamXkkOg0APstP4lIqa23R0+Cv1Cikdg2JiCgE1FmRKYrmjcs6aZD0DaBj3Kipk8hyw7MtjMfGyBskCUGl5FslV+1QtJKJUA9T1h++EphAR8SWf1PVYC2CwWu0atO7HkbY9hEuoue6OwxM6ety8VzojVGjc7gSPTGodIMS4oSM7m0jYbhGN+feAC4gYF+O1gqu18zICdEJVntPD8PHhfZMr152xYbZuzYI8dLxoPXmfHJw1jqoulBxq9gnP4hauUybE9fI0vonvkkx/k0qhZhiJXGtCpxcKX2CusdKjPcG6JEQedB/P2qGaJQESgpyMkqIi7i4oBGTt+iu12Ysg9unk7DHJgfipyQXY5ADN4LGPkBUtpSXlnFBCY+JHmsjmUuqdnEn/i3gInvsaWi5F6ZQbppIsJKWd28dhsiR4Ptuj3EWdF3nq1MYgL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:52:38.7779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b84dcfee-3c63-4244-887f-08de753e4df5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17218-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 261131A7436
X-Rspamd-Action: no action

From Michael:

This patch series introduces a new FRMR (Fast Registration Memory Region)
pool infrastructure for the RDMA core subsystem. The goal is to provide
efficient management and allow reuse of MRs (Memory Regions) for RDMA
device drivers.

Background
==========

Memory registration and deregistration can be a significant bottleneck in
RDMA applications that need to register memory regions dynamically in
their data path or must re-register memory on application restart.
Repeatedly allocating and freeing these resources introduces overhead,
particularly in high-throughput or latency-sensitive environments where
memory regions are frequently cycled. Notably, the mlx5_ib driver has
already adopted memory registration reuse mechanisms and has demonstrated
notable performance improvements as a result.

FRMR pools will store handles of the reusable objects, giving drivers
the flexibility to choose what to store (e.g: pointers or indexes).
Device driver integration requires the ability to modify the hardware
objects underlying MRs when reusing FRMR handles, allowing the update
of pre-allocated handles to fit the parameters of requested MR
registrations. The FRMR pools manage memory region handles with respect
to attributes that cannot be changed after allocation such as access flags,
ATS capabilities, vendor keys, and DMA block size so each pool is uniquely
characterized by these non-modifiable attributes.
This ensures compatibility and correctness while allowing drivers
flexibility in managing other aspects of the MR lifecycle.

Solution Overview
=================

This patch series introduces a centralized, per-device FRMR pooling
infrastructure that provides:

1. Pool Organization: Uses an RB-tree to organize pools by FRMR
   characteristics (ATS support, access flags, vendor-specific keys,
   and DMA block count). This allows efficient lookup and reuse of
   compatible FRMR handles.

2. Dynamic Allocation: Pools grow dynamically on demand when no cached
   handles are available, ensuring optimal memory usage without
   sacrificing performance.

3. Aging Mechanism: Implements an aging system. Unused handles are
   gradually moved to the freed after a configurable aging period
   (default: 60 seconds), preventing memory bloat during idle periods.

4. Pinned Handles: Supports pinning a minimum number of handles per
   pool to maintain performance for latency-sensitive workloads, avoiding
   allocation overhead on critical paths.

5. Driver Flexibility: Provides a callback-based interface
   (ib_frmr_pool_ops) that allows drivers to implement their own FRMR
   creation/destruction logic while leveraging the common pooling
   infrastructure.

API
===

The infrastructure exposes the following APIs:

- ib_frmr_pools_init(): Initialize FRMR pools for a device
- ib_frmr_pools_cleanup(): Clean up all pools for a device
- ib_frmr_pool_pop(): Get an FRMR handle from the pool
- ib_frmr_pool_push(): Return an FRMR handle to the pool
- ib_frmr_pools_set_aging_period(): Configure aging period
- ib_frmr_pools_set_pinned(): Set minimum pinned handles per pool

mlx5_ib
=======

The partial control and visability we had only over the 'persistent'
cache entries through debugfs is replaced by the netlink FRMR API that
allows showing and setting properties of all available pools.
This series also changes the default behavior MR cache had for PFs
(Physical Functions) by dropping the pre-allocation of MKEYs that was
costing 100MB of memory per PF and slowing down the loading and
unloading of the driver.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Changes in v4:
- Rebased onto current master, adapting to kzalloc_obj().
- Fixed potential NULL dereference in ib_frmr_pools_cleanup() when
  frmr_pools is uninitialized.
- Link to v3: https://lore.kernel.org/r/20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com

Changes in v3:
- Use rbtree helpers for pool find and find_add operations.
- Use cmp_int() for pool key comparison.
- Make key comparison inline.
- Link to v2: https://lore.kernel.org/r/20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com

Changes in v2:
- Fix stack size warning in netlink set_pinned flow.
- Add commit to move async command context init and cleanup out of MR
  cache logic.
- Add enforcement of access flags in set_pinned flow and enforce used
  bits in vendor specific fields to ensure old kernels fail if any
  unknown parameter is passed.
- Add an option to expose kernel-internal pools through netlink.
- Link to v1: https://lore.kernel.org/r/20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com

---
Chiara Meiohas (1):
      RDMA/mlx5: Move device async_ctx initialization

Michael Guralnik (10):
      IB/core: Introduce FRMR pools
      RDMA/core: Add aging to FRMR pools
      RDMA/core: Add FRMR pools statistics
      RDMA/core: Add pinned handles to FRMR pools
      RDMA/mlx5: Switch from MR cache to FRMR pools
      net/mlx5: Drop MR cache related code
      RDMA/nldev: Add command to get FRMR pools
      RDMA/core: Add netlink command to modify FRMR aging
      RDMA/nldev: Add command to set pinned FRMR handles
      RDMA/nldev: Expose kernel-internal FRMR pools in netlink

 drivers/infiniband/core/Makefile               |    2 +-
 drivers/infiniband/core/frmr_pools.c           |  547 +++++++++++
 drivers/infiniband/core/frmr_pools.h           |   63 ++
 drivers/infiniband/core/nldev.c                |  286 ++++++
 drivers/infiniband/hw/mlx5/main.c              |   10 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h           |   86 +-
 drivers/infiniband/hw/mlx5/mr.c                | 1144 ++++--------------------
 drivers/infiniband/hw/mlx5/odp.c               |   19 -
 drivers/infiniband/hw/mlx5/umr.h               |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c |   67 +-
 include/linux/mlx5/driver.h                    |   11 -
 include/rdma/frmr_pools.h                      |   39 +
 include/rdma/ib_verbs.h                        |    8 +
 include/uapi/rdma/rdma_netlink.h               |   22 +
 14 files changed, 1161 insertions(+), 1144 deletions(-)
---
base-commit: f4d0ec0aa20d49f09dc01d82894ce80d72de0560
change-id: 20251116-frmr_pools-f823cc5e8a58

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


