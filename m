Return-Path: <linux-rdma+bounces-8495-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51343A57CA2
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 19:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7EC7A6DFA
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B49E1E25F7;
	Sat,  8 Mar 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tuj3+/w4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3601DE2AA;
	Sat,  8 Mar 2025 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741457193; cv=fail; b=S60nsU0nuhSLGcLbruOkLzucjkR0RclKFmbIozkat7Ukc9cdrNiUb83kUo4ihqeObEG6GbKulUXxs60s2OFqlF3uEOz/ruwJkdpzfoHf5ulrRfT4qxBf81CngidqHCbuWg0HwEnk4GBshGmgykYftZ56ImpYdiGKhKTZ14ZCgIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741457193; c=relaxed/simple;
	bh=tet0mrLOE43Yv6Zabb94f2b0+v113wzaAaRJp1BHEY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oZ8f/HnKavNYcHqyJPOO42/wt0/f5anKSOyrgOVOjoXrsxpRWhiquUElpLVRd8ZeH9ehcMIWgrncjhnvVMO0iaksR+i45bL+LABgAnFzW6Ha7pKeX1Bj6/iuhgZm6Q7PNiguIt+9y/uBwY8x1yJamSBL0LypCHQs4aal6BtL3Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tuj3+/w4; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUVKyWNh+YSfXSp1kfhKRBQ9REoe5FuofbPjECoR2TUi2Qrf73Y0jpFNfMTSuJ8woDU/dkB3jDa3Di5r5s/RTBEnPvVz1gx/HSgi7ZZGJjlPswiAyKgDd6Hkqprdon/IgZdPublg2N37d7x1r18saviu8BpfnsMzAzrLSnrRR90Ylz0wwYVsDkgb7OyZqW4HjAQnML6vF6D1irlLqy13NcFh4ThaXG0TuBr+iHsl72qaBafU4fZ9vFrBaX1TAkA2QMSltND/magCKZXOMa0eONf2YQAYMLWf5jTdW+n4LIllSn4HH/ysDzmTuyNzTtbZ58XjQuXkFmUHV55JGx84Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1medgm5reqhvzPIuzfqZ1D+yg5lK4XtPffDVdRzmps=;
 b=MPEsBrYAPy1PWBhQx76s55mcSbrrIZG71qfMvIJpxUk3KHWU6PoURvM26fc7tBGCePrXlEz4QOW7SYoxAZKmwccGHqIIqsD3s6B2LxfGMro+Y6hnIZ+l5kohyJvrDvG/b47kAy56X0Bq5U6OwDOThHxmIEXVbJtBDV/OwQo9xr07FKI3TnYFiA/1Ol+dk9ufNqHJBVgu7uTC2lPtYN1p+jdrKqAhH/M32jg7EO6b6CYzUzYYJ0rHPkhA9OjyYO7e1cl4zxPTjw9S6CZLf5A/22eWpis+JtR7IQFNDG0PUw2pqdOxb2LzogqJRmcsZ5RgI0rPZRp5++eTvfC9k+uKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1medgm5reqhvzPIuzfqZ1D+yg5lK4XtPffDVdRzmps=;
 b=tuj3+/w41AvVnhe/MQbtR+tDyQ2z7eF7Ur9Ijt59v0TgyDCkHncTIHH2Y0+dsJf+LX2vOF+Y+IWPuigctEVjLlYv9q2tzxAxFlrmTsdYhff8rUEMNTiQ1D48OhmZJez7tUg0OW9A/FbIR+JBaUoq+zOBazp57vLhHd29mUGDXZneoauLCqDvcTP01P1aFMUXuAkBJrkOxf+O5h9StB7jWmsnwNY/1BOodyuug5vCJypxqlJUU7c0p+n2USAWU/bOLP3SobDhh5ss0g3Lew2AGpt6nFPtzv+h5e0QLrsUYEAd6fO9nwSQUsXmqd2q04ez445gcNs1VaNiTkxj3Y6ObQ==
Received: from DM6PR02CA0106.namprd02.prod.outlook.com (2603:10b6:5:1f4::47)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.24; Sat, 8 Mar
 2025 18:06:27 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::b0) by DM6PR02CA0106.outlook.office365.com
 (2603:10b6:5:1f4::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Sat,
 8 Mar 2025 18:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Sat, 8 Mar 2025 18:06:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Mar 2025
 10:06:17 -0800
Received: from sw-mtx-036.mtx.nbulabs.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 8 Mar 2025 10:06:17 -0800
From: Parav Pandit <parav@nvidia.com>
To: <linux-rdma@vger.kernel.org>, <linux-security-module@vger.kernel.org>
CC: <ebiederm@xmission.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH] RDMA/uverbs: Fix CAP_NET_RAW check for flow create in user namespace
Date: Sat, 8 Mar 2025 20:06:02 +0200
Message-ID: <20250308180602.129663-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3850c7-63f4-4a0a-9c11-08dd5e6bf223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/bHy3rqE9qKP9HB/i0gfJmLBbPSREE2mCidNkAc5YxXSToOuz8+nJTI812On?=
 =?us-ascii?Q?7VNn5dDUsIixKn/c7Uba8Dj3h+XkeDAUK0AP9MDCXG1wRAJqcaL50gXqw9uF?=
 =?us-ascii?Q?u5uZjMMKnjD9+TrzN9bQh5VYfs4BwDrwdHasSgdyG07PbJIVv1fkWklbeF4j?=
 =?us-ascii?Q?J9NPSVSV/aulu8HuHWQ7AnTWpZDhGPS4vEGYkeXwAChcv1RiD7mTOX4pU2Mz?=
 =?us-ascii?Q?pJbnO16hwFYH6p0EobzAyjs2HMX5jgP1Q7HnSe1yoaUXm5GGMiZqNqV+YnHK?=
 =?us-ascii?Q?kZsiwUIrTXjY6WEa0cpUduunMJpSGS7eYHeN9NGWO2Lrcmzeq7VOGl2RdlES?=
 =?us-ascii?Q?VWoiLYFiz6dMMPhRvd5OLwRuxl5S/IkgZ0j4deQAf9rEAuBxVCbmN0UavmiL?=
 =?us-ascii?Q?WuOmL5kKjYXt/kz3lWsvkN9wdk+ofuLKiQGynvMkrEp+WPe0CcjsD+4wS9ee?=
 =?us-ascii?Q?yL0fxm0OYH/9fNcboLsFrEXX6IaG7z8sCx9g00rDEw4yBevANbffsGCB9yul?=
 =?us-ascii?Q?+Z9zr5ItY0HqbT+ecMUheFd8cIsnIvelcGdi2CPvi1/T1wXy3kHFNZNQtj3k?=
 =?us-ascii?Q?sGOokD5reMig4HMwoTQYGH2ccHfNA+btOlXPlj7bd8WN1dH5jBFHyu8vfWhJ?=
 =?us-ascii?Q?8M2Zt5tmUDAuWsIFxNGUqSXvaEgPOngTVmONg9nF6EPkE3xa30PNbS1CfiLk?=
 =?us-ascii?Q?5zPmK3b3OhxdFmALdDk7Z4wIAtpvJRpu+qVwI2z2gxpGKjI50VMVLun7Krlx?=
 =?us-ascii?Q?2TYkJcXw5a9Uk8zpwp7n/jcD5g+eG6+RGsYv6A5toljrkqbKltKXZRxbprEg?=
 =?us-ascii?Q?HfSUlxC9Sf7f1E/91ondl7Vx0LUJQWUdNIOqXjpoqdM3qEoxyL3b/vszbaiX?=
 =?us-ascii?Q?7p93toG8t5Mj0z0UzLfuL9L1gEE2Q/j+3bCswPOggya0bHEKIjj/97JI093O?=
 =?us-ascii?Q?cej51/aLHm0SyUZZzqWwWFEjV/pTv+Q0rqnQDS93wty/Rhb7JpkiMu1eKPL1?=
 =?us-ascii?Q?94zGc4AfcSKIOqvI9wNVdjxWCYYN4lMlJZeTT1/1hji05Q/JFoD0ZF7E0slg?=
 =?us-ascii?Q?9E/ulu3ekwgPFlIgmXcbMPiL00Ww7uYWOvhUQBPtp4r5VBxCrZcxN5hoUwp7?=
 =?us-ascii?Q?YhlXO/KJgQRMRgRGsWZUtM9ua7c7Pa4pfucRpEJuRJr2EANf+anCzg/zf3LH?=
 =?us-ascii?Q?rcRA/sYjzU449NQEndLOomDvXaLko2aGef6VyUuh+4d2ctJG/8z46O9izCUj?=
 =?us-ascii?Q?tcOhetsAHCwbJ9ZW1npU0auryjIv2HKVXPrBJqXgs0VVAi7AMDUMs35P7x1n?=
 =?us-ascii?Q?D3o8GLa+9IuNdrrT/8QiYWYxHAimLk6LouCMD/uirWCaRiYXuh6kmuodUeMl?=
 =?us-ascii?Q?G3B9Wi6vTyZburUVRGLleaJujjkuLW6zCMfjyT8ZWw+Rf+TboB1yznSbdCLW?=
 =?us-ascii?Q?eyFZID+7koInR71pA4ofBtPjM9BQLw8t8doYogw3fldbbcrGILSUwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2025 18:06:27.1847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3850c7-63f4-4a0a-9c11-08dd5e6bf223
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

A process running in a non-init user namespace possesses the
CAP_NET_RAW capability. However, the patch cited in the fixes
tag checks the capability in the default init user namespace.
Because of this, when the process was started by Podman in a
non-default user namespace, the flow creation failed.

Fix this issue by checking the CAP_NET_RAW networking capability
in the owner user namespace that created the network namespace.

This change is similar to the following cited patches.

commit 5e1fccc0bfac ("net: Allow userns root control of the core of the network stack.")
commit 52e804c6dfaa ("net: Allow userns root to control ipv4")
commit 59cd7377660a ("net: openvswitch: allow conntrack in non-initial user namespace")
commit 0a3deb11858a ("fs: Allow listmount() in foreign mount namespace")
commit dd7cb142f467 ("fs: relax permissions for listmount()")

Fixes: c938a616aadb ("IB/core: Add raw packet QP type")
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
I would like to have feedback from the LSM experts to make sure this
fix is correct. Given the widespread usage of the capable() call,
it makes me wonder if the patch right.

Secondly, I wasn't able to determine which primary namespace (such as
mount or IPC, etc.) to consider for the CAP_IPC_LOCK capability.
(not directly related to this patch, but as concept)
---
 drivers/infiniband/core/uverbs_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 5ad14c39d48c..8d6615f390f5 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3198,7 +3198,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	if (cmd.comp_mask)
 		return -EINVAL;
 
-	if (!capable(CAP_NET_RAW))
+	if (!ns_capable(current->nsproxy->net_ns->user_ns, CAP_NET_RAW))
 		return -EPERM;
 
 	if (cmd.flow_attr.flags >= IB_FLOW_ATTR_FLAGS_RESERVED)
-- 
2.26.2


