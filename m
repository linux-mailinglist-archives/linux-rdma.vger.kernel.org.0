Return-Path: <linux-rdma+bounces-21544-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKywIyweHGr0JwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21544-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:40:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2AC615CB8
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23B0E301C126
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6A53769F0;
	Sun, 31 May 2026 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dLcYTQyG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57311231842;
	Sun, 31 May 2026 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227621; cv=fail; b=nMJ93wefc2wAU8suZgxDisuGQhXU2RMxVV6vOmdJMpwF2Y4ZY2GbxBMyHU8KnSNLPmscxxyAeYxvIBVm/SAIMiAtKGHfiWy5qnArKT5+Rb4jRkF6PNDnkhuiADjYIAItWfPvsAwpADg9WdyJTCd/Y4HGp6x0jR2jsIZiXGhhoLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227621; c=relaxed/simple;
	bh=97IaxtHFQPJNIkkRiQ0HRmSs3EgtnPneWJ6aCcK2zIw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s7IxS0vnQW32bvQghQHEnPhKdpkwEKda61UlcAmqHN2WDvE9b1Dfu8UIrjD6rsDp83qqamxtG/Yk1+k75ZEgRYvTzxOorXMOXUvSS+ztm4NM3MrhmYHmGrT/wye8Kk7ENvhFyeiAMZjzsYIKC6MpER+93xUeeDAq0BWC1+zUvqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dLcYTQyG; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2hpbb8Y3Ofzo8yLGiMc6r/KRhK7s1tQCXs6cYzzvm1EwlA+0/TFSGt/IJhTOGFR0YICkEvvcNsjVjioyT0Brduk2r8jHOFALbMjyQbkZ9sIi82FkmxDI+cZqI5JqUgt+mz7Q/auzq9hh7B47fcMOBSG0OtG4Q0u+vYFPteFV6a+IP+UHXekZfdy/rrCMVI+NiLlJhUjEHjAgM/CagepD4t/MRTLyRLkKi/wrSdKw0MEPKWMGo1RzhXeDt3Det6DIA1IZPMYu40rWCjDAxKJwBGaLk73//DOU+8+kKav68KZvwER1JY1YWaSQXQXNwA7RQD1v5iQWRWGbBEZkPw4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e85c83zhUaNBLmRcvphJkmycdhMfZhr57cDcWDR8wA0=;
 b=o49+4Pdty07EKVKco6cgKtD/Kv/J1lukUeMMo+TTANrp0d+ZVd5WRLy13uSiX+Si/hLvGT7ANDcJlABZLy8EyaWdnaBlh84unlaRKGtocsaF7jtSN67hz1Y5qoXPSnm3T1M1Ai3BFPdTjJW1y1fheBaFsRJKjSfLf6OwLhc2O6gn7FhdxssAVmpxjw+GKEDUjdYt4arbpmHHrJQQiEjtJUevHxBTgkUR6YTqmoikftPEgUJwkF1u2aEgSwKVUt57InzOBrEtDyJ6O/SX3JjxhDUu0WsdB+5kWY1IWRjsYunDcUoupH1//GQwMyslqzAZUYJ87HHeGgVcbFMt3HCz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e85c83zhUaNBLmRcvphJkmycdhMfZhr57cDcWDR8wA0=;
 b=dLcYTQyGtYu4GzOkfdUpTZ7ndfKFLPfc3gwC/YPqc5WcTFfgH90nUWTbdGFQJO/008TIPWyVOsvX1J9xZAD6SmWBsZtCNEtacghS4ACtOrOVFC1/cDrCdr5Y4GxZZ64IJ2ZK25jHaBGSd87llLeCIFwCOTOK0IbMZ00mIJwtQGJJO3C1pE2bPs5hU33eAkVznkch7xglNInwDqLEfvnHQxk0YFi9ybHV64ymwgS9NyjuZzhQ/tmydLGK8+8nHJAGn6qNkY8YV2/QBzBzZON3Cmz6kMVIiLvZrE8fQAkrxNTPEdyePlRJOc2bEUrODDWM5uNce6L3c/jQ14RZhRFTYA==
Received: from BL1PR13CA0444.namprd13.prod.outlook.com (2603:10b6:208:2c3::29)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Sun, 31 May
 2026 11:40:13 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::18) by BL1PR13CA0444.outlook.office365.com
 (2603:10b6:208:2c3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Sun, 31
 May 2026 11:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sun, 31 May 2026 11:40:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:40:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:40:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:39:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH net-next V2 00/13] net/mlx5: Add switchdev mode support for Socket Direct single netdev, part 1/2
Date: Sun, 31 May 2026 14:39:40 +0300
Message-ID: <20260531113954.395443-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5ab83e-6d22-407c-32d1-08debf0960db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|13003099007|3023799007|11063799006|6133799003|5023799004|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	BVtYIJh9hNhbVDMuhIhXZrx2Rg86Hj8LSrJyTXphWCdz1EgE6n6VqRaBFFqHARp506mdene6nXivdyjvffQsKod2lTVD37zawXss0dAWCnVgzTUUoNioSrWZs5Mnk436z9E2R2M52sG1Tpax5kQUTCPYIfEoHKpI3sV6aasi3O70RbQCLuqsSMuevWTiSBzuk2bAOG60apAvBqPY8WuRRF3gfHpbCLPdE7Hb3kBp9twh9FfoTXz8EWpycK34xm1uJVpaXzrd5MJSGUvizVYQO4pkZN3Z//9ME8kAgkW7uFkTid6ViqQcJQ97OO8f0Z0Q4/ztX0zV/sMeqUcTjeFXCZZ3yGnEEOJxQIcJPJaqA45dw+o3HyN3gF5SHFV6Lk+4VCwFnkQLIo0r829R8hK4inDH+92RIy0J+jWRC5Ajs0GHL1wh/FkvAKMPyqkBY94INJJY454a4dPsv0aF2VsHimstPzy1fbtRlSaOr09b5d+fMMQyl/BMVuomph6oY6ynFgCvPLfNQA7m9EEZ9k37noWvMSFTHB8v2ji4uOUR60Ym4pV73q410vo0/GYPZU/sO5UjxOrS8zdx3x9pA8bOq+diEPg1Nxz4SSWIyNkaomQXLKmhWzcp9F8IMaBi47iEC5mXqmVRzxwpp4UbE94wTf30BnXWTnJNFikBrGNGyd6edQrE+mQq20pGvaQCW4wtbBBfgadBwZZdKbqBknZQj4WJbM176SUlXuU6gIxD+B81dGSz+Y4YYiqJXnPm3hGu
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(13003099007)(3023799007)(11063799006)(6133799003)(5023799004)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aiO/zVPcCgSslskiQslZ48uAVNZu4Vdp3kN7JKOU3+2Tv8gNatiIlBxIG8A4LXJ/4i0KSOhN5yqPrSSEky+mpFjCBFvikhcLcohiWvpGy+XKJAynC+QaKVaa1/B1nGh5fnA8lGORV6ZPPTEjGO5hbqJxFJd9cNoBurlqUjlMZZIA6YLkKFKVDqXlVcLNyF3j/SA0a2LKUL29ajPzedXeJP79C4Iiq1THupgTon3B46X88yaGt5Wnnai+8CT4B+uW81VCeNpRPmcaETJ7RaR4JnHLlsl3c76cY/dGrWBVMbBI0lKZdtf+x0i5G19bpvLgM75RegbPS2tk4NacHbsGQs7jv+SrNWjUz4sEBiVHi+R9n4IP4Q6qArB9Lx1lCKSOKfgsiSlR+5PsS3Y9mLuGf8UwrWcXgcJdN/Lateg3NYjDzc/xAY7GYqX/oyk3vAPu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:40:13.1792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5ab83e-6d22-407c-32d1-08debf0960db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21544-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0C2AC615CB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series enables Socket Direct single netdev to operate in switchdev
mode with shared FDB. See detailed feature description by Shay below.

Regards,
Tariq


This series enables Socket Direct single netdev to operate in switchdev
mode with shared FDB. SD single netdev combines multiple PCI functions
behind a single netdev interface. To support switchdev offloads, these
functions must participate in virtual LAG (shared FDB).

Design

Rather than introducing a separate LAG instance for SD, this series
integrates SD secondary devices into the existing LAG structure
(priv.lag) created at probe time. Each lag_func entry carries a
group_id field that identifies its SD group membership (0 means not
part of any SD group). An xarray mark (XA_MARK_PORT) distinguishes
physical port entries from SD secondaries, enabling a single unified
iterator that filters by group:

  - MLX5_LAG_FILTER_PORTS: iterate port-level entries only (existing
    behavior, used by bonding, FW LAG commands, v2p_map)
  - MLX5_LAG_FILTER_ALL: iterate all devices including SD secondaries
    (used by MPESW shared FDB across all devices)
  - specific group_id: iterate only devices in that SD group (used by
    per-group SD shared FDB operations)

Existing callers use mlx5_ldev_for_each() which maps to
MLX5_LAG_FILTER_PORTS, preserving current behavior for non-SD
configurations.

Lifecycle and ownership

The SD LAG lifecycle is tied to the SD group, not to bonding events:

1. At PCI probe, mlx5_lag_add_mdev() creates the LAG structure
   (priv.lag) for each LAG-capable PF. e.g.: SD primary devices

2. During mlx5_sd_init(), after the SD group is fully formed (primary
   and secondaries paired), sd_lag_init() registers the secondary
   devices into the primary's existing priv.lag by calling
   mlx5_ldev_add_mdev() with the SD group_id. The primary's lag_func
   also gets its group_id set. No separate LAG instance is created.

3. After all the devices in SD group transition to switchdev,
   mlx5_lag_shared_fdb_create() is invoked with the group_id to create
   a software-only shared FDB scoped to that SD group. This sets
   sd_fdb_active on all lag_func entries in the group. No FW LAG
   commands are issued since SD devices share the same physical port.

4. If MPESW (multi-port eswitch) is enabled on top of SD groups, the
   per-group SD shared FDB is torn down first, then MPESW shared FDB is
   created spanning all devices (ports + SD secondaries) using
   MLX5_LAG_FILTER_ALL. On MPESW disable, per-group SD shared FDB is
   restored.

5. On SD teardown (mlx5_sd_cleanup or device unbind), sd_lag_cleanup()
   removes secondaries from priv.lag and clears the primary's group_id.
   The LAG structure itself is not destroyed.

The sd_fdb_active flag is set on all lag_func entries in a group (not
just the primary), so any device can detect the SD shared FDB state
during lag_disable_change teardown without needing to look up peer
entries.

SD shared FDB is a pure software construct -- unlike regular LAG modes
(ROCE, SRIOV, MPESW), it does not issue FW create_lag/destroy_lag
commands. The software vport LAG for SD is implemented via eswitch
egress ACL bounce rules, managed by the IB layer through
mlx5_eth_lag_init(). And the software LAG demux is implemented via
steering rules that utilize new destination, VHCA_RX.

Patches

Infrastructure (patches 1, 5-6):
  - Factor out shared FDB code into a dedicated file
  - Extend lag_func with group_id and sd_fdb_active fields;
    add XA_MARK_PORT and unified iterator with group_id filter
  - Extend shared FDB API with group_id parameter

E-Switch preparation (patches 2-3):
  - Align eswitch disable sequence ordering
  - Move devcom init from TC to eswitch layer

SD group management (patches 4, 7-9):
  - Replace peer count check with direct peer lookup
  - Register SD secondaries in the existing LAG at SD init time
  - Block RoCE and VF LAG for SD devices
  - Block multipath LAG for SD devices

Switchdev integration (patch 10):
  - Keep netdev resources local in switchdev mode

Steering (patches 11-12):
  - Track peer flow slots with bitmap for selective peer flow deletion
  - Enable TC flow steering for SD LAG

Enablement (patch 13):
  - Verify unique vhca_id count for cross-VHCA RQT

V2:
- Fix kdoc warning in mlx5_lag_shared_fdb_create()

V1:
https://lore.kernel.org/all/20260527125427.385976-1-tariqt@nvidia.com/

Shay Drory (13):
  net/mlx5: LAG, factor out shared FDB code into dedicated file
  net/mlx5: E-Switch, align disable sequence with switchdev-to-legacy
    transition
  net/mlx5: E-Switch, move devcom init from TC to eswitch layer
  net/mlx5: LAG, replace peer count check with direct peer lookup
  net/mlx5: LAG, prepare for SD device integration
  net/mlx5: LAG, extend shared FDB API with group_id filter
  net/mlx5: SD, introduce Socket Direct LAG
  net/mlx5: LAG, block RoCE and VF LAG for SD devices
  net/mlx5: LAG, block multipath LAG for SD devices
  net/mlx5: SD, keep netdev resources on same PF in switchdev mode
  net/mlx5e: TC, track peer flow slots with bitmap
  net/mlx5e: TC, enable steering for SD LAG
  net/mlx5e: Verify unique vhca_id count instead of range

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/rqt.c  |  27 +-
 .../ethernet/mellanox/mlx5/core/en/tc_priv.h  |   7 +
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  83 ++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  11 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  26 ++
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 429 ++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h | 100 +++-
 .../net/ethernet/mellanox/mlx5/core/lag/mp.c  |   4 +
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  28 +-
 .../mellanox/mlx5/core/lag/shared_fdb.c       | 235 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 227 +++++++--
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  23 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   3 +-
 14 files changed, 916 insertions(+), 289 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c


base-commit: 8415598365503ced2e3d019491b0a2756c85c494
-- 
2.44.0


