Return-Path: <linux-rdma+bounces-18235-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFt2ORIKuWk/ngEAu9opvQ
	(envelope-from <linux-rdma+bounces-18235-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 09:00:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C312A530A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 09:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C075030518F4
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 07:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF763939BD;
	Tue, 17 Mar 2026 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pGtlYbXV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB84F3932C6;
	Tue, 17 Mar 2026 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734377; cv=fail; b=Z8qdBm9sohxJ77uhgxgChT1tMhJ5OTVG5PEbEW6BufhgXu2odW6Bvz8KNMouxHG0801fVAriOrmtXaystq9ktZU2y077lLKrN5ewsAs723aPd1AEI7xJx1ZMcWi13jPr1zLBwmxZw17ECQ81IKiFvhuTnctxKD04WfR02LE8wy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734377; c=relaxed/simple;
	bh=Rbn/z8XxxUH1REiZXrZ/Tnkc+p0853c4QlkM3H/72XA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QckqaZ+iAH7HEvkoHtUTF6e9onGcvI6Lhk0KglWw4vaDSegRNXdnpNmMC8PPR+JWoSJX9rQ0C0v/KxZRG0XVqsvw8B/5FCRVptKP5XdeNhwqi0ppHusD59I5QKuduikqCITPo5CJKezm4ounp3FNW4QUCofjnF+v9mhz2gcf+/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pGtlYbXV; arc=fail smtp.client-ip=52.101.85.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDjdxilAEgBT8qrF0laQg1u6Y2hwkfZ3c8bpHYSYwqmKFBP6yNNyiPt0ov72FfDRV8D5DYnL5c39QYTmxOzVZMRReUaGb8AdItOAtqr1DBLYwVIA1uI3v4vZl955Xo2RrbJgpkILPrqdfv2Yv45ji8zdYv85LWFRsahshYxPNoAnfBtQZGdRTAiByAyItGxhXY5VygTVT85QJTTUWSWyyTP3Kaxd1kvbfLcXnliJEjDER67TEOHGByUVQLQmMqBDjwEes74ASB8LAdjZuc0Duw4O0YRb8Ugg9BxT6MSOj8O+5V9tlKTPTkrch+eyNO8Ln0+FLlJdDcZUUeDrCLW6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN24VXenLRj7hunqIILaWBJcW8RYOBKAM8aVTIupxbQ=;
 b=FnQuO8XarE/7n6Uc9nA/b5pG2k9bia2vdvDTY20ac67kP//31B5VKtzzyQipd/0fd8nOyi+W4EnZ5zeK9z8hEwzDJlos3ykePrgSuc6WFGJeHTCni9odI/6D2V/4hwEF52/aqYlg/Xnwl6uX0ROMKWBycsKnpFMlrDoivrp6+JJPqK1/MFQEiXnn1ESmCqH/qwf1Nc12Mx6t+qhjVBLvDI7wUe+3nnPLbT1f/Us2jzk3dUowI2+9FfLtvSxbglCA1g1MymnUUEVjalGKsZu1S7eKGHQlLRD4O/hpLGHWCXl3A2++T5Y1zdraaQzPS/qPDqBoyqs7LnK0Arq/8ueIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN24VXenLRj7hunqIILaWBJcW8RYOBKAM8aVTIupxbQ=;
 b=pGtlYbXVerM0Xc84Ea4HkOZKGbWPP4uahguloZe5E0Ybc68tHFjOA/Sk2fy82jek4R2+Jzx1Thj4Q17MTHonkW/Q1DYy0N72dZ32HAKAagQ8qjyFVRvQ4oqF07oG2GBigMEcnxknwAXWRYA0R2vj8cL22kTKUMQ0V41cy37CqyMSeXbvyt5fvVgaVSl/oK3aFER4/Jd2gziMZmV9rLOCLaOFizBhzVzEyDV6N0r+tLvcENn03LQWbhjfbu7AYH8WMb3PpI7NWpHsqj4f25CxG2MnVGBWI9//GUQ4Azt/i0yF/O7g/VaMT0uG3b2oQWdvsD8ZISGrKdCizaL5h+zhLQ==
Received: from SJ0PR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:334::23)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 07:59:30 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::fd) by SJ0PR05CA0108.outlook.office365.com
 (2603:10b6:a03:334::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 07:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 07:59:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:59:16 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:59:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 17
 Mar 2026 00:59:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [pull-request] mlx5-next updates 2026-03-17
Date: Tue, 17 Mar 2026 09:58:44 +0200
Message-ID: <20260317075844.12066-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d39652-51af-48fd-ef1f-08de83fb1e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RqwfJeMMrUQaLjqzaZXDK6Ie+T+oDFJcQMhHcP2I+CElqBApNRzV9qoH461Gz4jlXNuIsSlRwWuWu2IRQiWgj6XBcPUn/sMyethccoh94YffW9Hm++LDcPeIgcxK+AXWg1IeO67apEbrlWuB7tOD/F6yJsnT/odqp7vwuJePmQcBWJK6sdxhMjNSirAny/t9Q/QXGTey1e+pEnIiLNBcpG9noU4gvO1XSJTPGhNS8PTDTbCn/jtavSRQUAw6q0PE/YCk9WEMpJHzYx4wac6wW6cx6HsKgJ7h2j3plcyXlnPvC4rxpRu0J5PjlHZO92wGmfitoafAVJJg9GZJPv0bZX0fnPWJ8urWmVm9QxXEVX/gc6L/HWrU+OKmGzBk9BLsf7QE9nxT5QJYtyDrp5On2gDXSXponIRZgi1EjlGDP2WExo0/AgjX3V2ZJweFmAbLjDuttJmsSnTUJ8g11gI1Me+oODdvu4PJP0NpsxstdzxUze+dkbL2ApnRCPk6wJuwBrL3Muj6Gb6hJRkbVzvvZ38MNrkrHw9ddneZy1WMKQ8ugTpX2uj/kYih7VEHvFbTa6Uu22AFevaHVKlacrpTrkZE5vkn1Ra6Stc/TOX1GtXtGoEZ4xiW7AtgLvPzzV+qsrcHtuDkjca4kiDXltAIKb19luPrV4gzaQCuDXVWSieD5LXbYfWXnZKm5DK0s0AnPMOaIZYsBtBnfLlTo8Y+e/IDLZv+Ac80rLBNbiBUALQdVQr30Tfp+xPy3HIYZR6DL7I0oNAt/4vQ/8UrW9l1dg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gjcOE2RvjTkPLcSqH9Re/rkt7NVRNS6yucHkNpDIrosKhgfpsqKpaFa1sBY211lpsGA1KUWNdaLeoJVLpeWvc9OXWnU3ptGBuFtGYtfqNMH0GK3YHK1YRjyZYPl49VT3uNON3iMOy2uV3V4JawLlde8u7H2b0OO4GBbJ6zlRZRfnOPVsTFFoxrjYDspVM1gXs69KOqvI2CG4H5SQnMfJuT2J2dM9WoaqRvE9+SpyXNJTxjeVf2oyy5vJKcIZwRpK6ezSANgdafwQt09qM91OULrmeQZmbXZ7plBe78j6S1CLgJoGwpCGnkPHXPyrTxGER50cg5COHmRrPYpiJvCJim6bg2q+XZ18JewzLnfar+MUjx1gN8KJ4bPygJPW2OI3Ap+5pR+dr6huObJczlI+C5sbFBoRBck+tvwnTKmwBYeRMTrJsUuZ8xbo6gPP18K1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:59:30.3921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d39652-51af-48fd-ef1f-08de83fb1e76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18235-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 96C312A530A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

The following pull-request contains common mlx5 updates
for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------
The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to 4dd2115f43594da5271a1aa34fde6719b4259047:

  net/mlx5: Expose MLX5_UMR_ALIGN definition (2026-03-16 16:23:00 -0400)

----------------------------------------------------------------
Alexei Lazar (1):
      net/mlx5: Add IFC bits for shared headroom pool PBMC support

Maher Sanalla (2):
      net/mlx5: Add TLP emulation device capabilities
      net/mlx5: Expose TLP emulation capabilities

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

 drivers/infiniband/hw/mlx5/ib_rep.c                |  24 +-
 drivers/infiniband/hw/mlx5/main.c                  |  21 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   1 -
 drivers/infiniband/hw/mlx5/mr.c                    |   1 -
 .../mellanox/mlx5/core/diag/fs_tracepoint.c        |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  14 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 103 +++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |   6 +
 .../net/ethernet/mellanox/mlx5/core/lag/debugfs.c  |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  | 684 +++++++++++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |  49 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c   |  20 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |  15 +-
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |  28 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   1 +
 include/linux/mlx5/device.h                        |  10 +
 include/linux/mlx5/fs.h                            |  10 +-
 include/linux/mlx5/lag.h                           |  21 +
 include/linux/mlx5/mlx5_ifc.h                      |  49 +-
 23 files changed, 888 insertions(+), 209 deletions(-)
 create mode 100644 include/linux/mlx5/lag.h

