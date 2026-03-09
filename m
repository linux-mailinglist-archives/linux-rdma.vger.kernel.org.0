Return-Path: <linux-rdma+bounces-17754-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAI6HYSUrmnRGQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17754-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:36:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 051B02363C5
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8D543037406
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCB837A4AE;
	Mon,  9 Mar 2026 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHt7mUcN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C4E2727F3;
	Mon,  9 Mar 2026 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048914; cv=fail; b=LmO3S5E3OMdKnyXp2GmxqSlQqXcgcblAL7UB4vNpqMTUHmp1A37SoUYQqVX2cC4q0/7rwcC5WaFHgY/dZKdgoP46ckgfd3RDo82rQQ9lkzxs/cqWuLVEKJnFZ/8e82fJ1i6eRLDkPr0sHHC0boTBPUdi41wHxV6FbRqiQfA6aq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048914; c=relaxed/simple;
	bh=n+9T8F8XENw6nVfa4QHE83qxXieH8oxguW/NLLPUgIk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMm8dGzcHDwFFcBq4a2PWcRMd7kr5OzKE39/SX4kRZKgdP4Nj8byquYGPzxoyHhaWv5zaHLtBLhMBSHm0GIloszYeArS/FE3Pg5ykP+PB/QVVTkL5K3i84+0dZXTIjYA06tyJgzEYrTAoY4aT5wYKzHyQe9kOV8C/HTvoUI+J5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fHt7mUcN; arc=fail smtp.client-ip=52.101.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOeP0UcjXzEDAAt9/Bq8T8338h1rTOVSa638gdzZjuwz9DMwPIsgy3+EHKxZjrvga1alCzsbyp3DAuzrfMjAwnl5eCNaYg9RGzGLW+0b+4qrQOpxUqLW+7RFLf4VpZLI8cHvrCy6DhXpvzw+nQHJ1+Bko9TVgKyD5V9XGUwgQrzLytwxdxoW0G/w5hQ7Ea2L3V7EXeaPaJyDKHiU9eVV+l89nCYCvF10b9YjbcC0IxDS+ZefFFCoHb06FaYsQ3r8MvvI1tyE14xuLPZWHLXvntZDzJIlLmkqn/sqaA1VsIJZ2SLRAgH0NS8m8OMK7vxGgXJWDW9Ih6hPjdf32YTRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUll3tgzhD6Ex8XuM39I+VfntcR3Ia+JfjmfestOjo0=;
 b=mqaDyOxYD5Ne7D3U2XUOlYPSyxp+mih9LrI1iKt6ZAwdMLZa2F7TQk79BRt2EnLFv3adaNNPUeaYw3eXd7zMPolcZW94mxZMwlh+mM+ZHEtJFSIR+JhP0lAYH5guwGAxOqHO4gizjPaLDQoLRsfHzXW2kYuNplIGbiW4TxBv2MmxvxSxRLbDSBYnAl8N4jVkep0E6/qSkTI+Cg3e6NiQceY0rl+Vg/JPxZiXCI/s2wI3clrJwdsZGL1XSpHLYiqtcEAwo3Xns8UebtmYukwyHNY9jTKyAVwiHEdywke9zaoJLBBlUiKmdW1eHBdmr+X1xONURIUIcG0zLVq5sDRvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUll3tgzhD6Ex8XuM39I+VfntcR3Ia+JfjmfestOjo0=;
 b=fHt7mUcN042FCrsv3Lzb/KODFsJzhqz/la43lUXDyvBesEgVczscwBISvsPB5BjtEcqOppF9LLb9AmEhIK/HQGI0fXNcHSIO12Y3hYDxdnMnXQr1rMpF08SL3D8ywGPsIt6X8IyNk3yq/IZ9U66FWcTouE1TtTN/ycKiIExCKbWAdyF69rmwGjezBb0SdNUvSPqIaj3dWBlGkf6YnhOx3ZCEJPcRSZ9KWagykZ9E1IAk/jZdULyRUpkkNklQ90vn74MrIfHT7i66s41tFWKMJIUj3NElcSyB7xZBXTJ5abKTlZs816fs/Ykr5RfFQCJaEWIIVX9+W9QoPa9TNloutw==
Received: from BYAPR21CA0011.namprd21.prod.outlook.com (2603:10b6:a03:114::21)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Mon, 9 Mar 2026 09:35:08 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::fe) by BYAPR21CA0011.outlook.office365.com
 (2603:10b6:a03:114::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.6 via Frontend Transport; Mon, 9
 Mar 2026 09:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:35:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:34:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 02:34:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 02:34:46 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next V2 0/9] mlx5-next updates 2026-03-09
Date: Mon, 9 Mar 2026 11:34:26 +0200
Message-ID: <20260309093435.1850724-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 81642054-2399-470e-a6bf-08de7dbf26d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|13003099007;
X-Microsoft-Antispam-Message-Info:
	nUlJB6mDXeW0LTNZgi1Hxgj+xdB1+6n9Ub93aswjqT09Q7HAyYcmivIE24AygEPZ/qXAGT6I4/VbUKGQTaYZ/iAJMruSxH3n0aqywmH4bWldBBzf9JoZJfkJhvLUtaCZrQ7N+B1DxvkxC4Sfwk10QkSQM7fzcEnidn8RVbanp3Jg/ES7Ftd4YsFH9Ig2JjMOXjZKC/DZbsqiTvL5FUJ25LkzcZi7y9SjWu7qoKrTBZ/voRxwYUJfX/iGxFB/UgxWOHPPe1UBo0CenwXL6B+vF6tGPs9SidDUagcauZ+KbUNxzPouML3RiCHY3N21Bd9U+DDNoa24t4q+TQikmJ1plcbhTXxp9o9WqXJtawhj3wZEqSnhiiu+uVVPpv6KrmcMZogIuVcX3QQiXNOck8szxQdkGO0yR0hZDdT3+/h1mbKrTUpDp1gb1VzeTQhyEnA+uGqRbuRiIsnqyyosNjpDRyVzvYst39BoS1+BMSRd60YCduwDx+J4mTt10Kt0DKXwFRMjDbRYG2F3ZjqU4sP3SdLk3VaKwybtbBMG2lC4vedW4G/HjEpOLw7NNw9lcgRNB2RfJnMMk60pTRc3c8bkpenkNu6rYv5KzzN9I+SbEu70WjnhKCdn5IO6qPi55XgIMYYq/855sbNAfNCMAsJSduAycheyjUJuMhyo1aLc52qx2vTckaT80Y9tCInn/x0TdO5rx4chzIpBWvrGnPuvDUIc0/e6NlqcsypOpb1IUyugFVS8+dgrz0KRaAzCo3CM2deWQmRyqDs4mz3crBXNhQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QrWsgYWG+NzicArIWs89nh2/qF7117KIXcEe4mTOeH/QZO3nfGuR2+YQ1GQYb6NBvGx/niAIGkcgNYTJ52d/lyxlhTSi6ST5dc4V6t3pFqsgSXqU0vSApOS2Ax21f1vF/wF02MTx7hVnYfVF+7ZNBMl2VJWYLIGs0TMw/oo3VEqgZsZ9g1aFjmtXDLatuqAfuQeKGgArLYxNP01P9C9LqV/GMENaWmgM8PSz9M3J+nzSsZEMrpkKonfsPMuwSDYuI70CPXY5O10ufSR13+zSjXTWi45HfvF5OUdc7dfWQ8XoEC+8D0h2w5MqLK922GWgnJLepHWsPS47ZhFu6K84mE50S8BBI7FgRIoX9m3qaufjPFbQSHr0d0JgHLt97tEjhDD/UVgLEGOLy3vU1yr0Lp1HGao42NXMnZAwKJgQDiaY0yB+DOi/UU7q97xNCidi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:35:07.5992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81642054-2399-470e-a6bf-08de7dbf26d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
X-Rspamd-Queue-Id: 051B02363C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17754-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

This series contains mlx5 shared updates as preparation for upcoming
features.

First patch by Alex contains IFC changes as preparation for an upcoming
feature.
Last patch does definition movement to expose a HW constant so it could
be used later also by core and Eth drivers.

Patches 2 to 8 by Shay introduce mlx5 infrastructure for SD switchdev
and LAG support.
Detailed description by Shay below.

Regards,
Tariq

This series adds shared infrastructure to enable Socket Direct (SD)
single-netdev switchdev transition and LAG support in subsequent patches.

Currently, LAG is not supported in Socket Direct configurations, and
BlueField-3/4 utilizing SD for North-South traffic operates with two
distinct eSwitches per physical port. This forces the use of separate
IPs and MAC addresses for each NUMA node, complicating network
configuration and requiring firmware to handle MPFS with different
inner and outer packets for communication.

The goal is to expose a single external IP address (single MAC address)
per physical port while maintaining SD's bandwidth and latency benefits.
This means having a single eswitch per physical port managing all
physical ports via merged eswitch with multiple vports. This enables
single FDB creation which will result in a single RDMA device to be used by
DOCA/HWS/OVS.

To achieve this, the LAG infrastructure needs changes since the current
implementation assumes a fixed mapping between device indices and LAG
ports, which breaks with SD's multi-device-per-port model.

This series prepares the groundwork by:

1. Adding IFC bits for silent mode query and VHCA RX destination type,
   needed for SD device coordination and cross-VHCA traffic steering.

2. Converting the LAG pf array to xarray and using xa_alloc for dynamic
   index management. This decouples LAG indexing from physical device
   indices, allowing flexible device membership.

3. Convert peer_miss_rule array to xarray, key with vhca_id.

4. Introducing LAG variant of device index helpers that produce unique
   identifiers even when multiple devices share the same physical port.

5. Adding VHCA RX flow destination support for steering traffic to a
   specific VHCA's receive path.

6. Moving LAG demux table ownership to the LAG layer with APIs for
   SW-only LAG modes where firmware cannot create the demux table.

A follow-up series will build on this infrastructure to implement:
- SD single-netdev switchdev mode transition with shared FDB
  corresponded to the SD group.
- LAG support enabling bonding of SD groups

Since the follow-up series is large (~20 patches), the shared code
between RDMA and net is sent in advance to avoid overloading the
shared branch tree.

V2:
- Add one more patch #9.
- Use kvfree() instead of kfree() in mlx5_esw_lag_demux_rule_create()
- Fix a condition check to > instead of >= in
  mlx5_ib_set_vport_rep().
- Fix author of patch #4.
- Link to V1: https://lore.kernel.org/all/20260308065559.1837449-1-tariqt@nvidia.com/

Alexei Lazar (1):
  net/mlx5: Add IFC bits for shared headroom pool PBMC support

Shay Drory (7):
  net/mlx5: Add silent mode set/query and VHCA RX IFC bits
  net/mlx5: LAG, replace pf array with xarray
  net/mlx5: LAG, use xa_alloc to manage LAG device indices
  net/mlx5: E-switch, modify peer miss rule index to vhca_id
  net/mlx5: LAG, replace mlx5_get_dev_index with LAG sequence number
  net/mlx5: Add VHCA RX flow destination support for FW steering
  {net/RDMA}/mlx5: Add LAG demux table API and vport demux rules

Tariq Toukan (1):
  net/mlx5: Expose MLX5_UMR_ALIGN definition

 drivers/infiniband/hw/mlx5/ib_rep.c           |  24 +-
 drivers/infiniband/hw/mlx5/main.c             |  21 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   1 -
 drivers/infiniband/hw/mlx5/mr.c               |   1 -
 .../mellanox/mlx5/core/diag/fs_tracepoint.c   |   3 +
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   9 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  14 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 103 ++-
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  17 +-
 .../ethernet/mellanox/mlx5/core/lag/debugfs.c |   3 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 684 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  49 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mp.c  |  20 +-
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  15 +-
 .../mellanox/mlx5/core/lag/port_sel.c         |  28 +-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |   2 +-
 include/linux/mlx5/device.h                   |   1 +
 include/linux/mlx5/fs.h                       |  10 +-
 include/linux/mlx5/lag.h                      |  21 +
 include/linux/mlx5/mlx5_ifc.h                 |  26 +-
 21 files changed, 850 insertions(+), 208 deletions(-)
 create mode 100644 include/linux/mlx5/lag.h


base-commit: 385a06f74ff7a03e3fb0b15fb87cfeb052d75073
-- 
2.44.0


