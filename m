Return-Path: <linux-rdma+bounces-21748-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7jI5AN1mIWp1FwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21748-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:51:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB2D63F966
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:51:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=fECU9GCx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21748-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21748-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A98E3110804
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046B429811;
	Thu,  4 Jun 2026 11:45:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B042EECE;
	Thu,  4 Jun 2026 11:45:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573550; cv=fail; b=iPX0LigXnNd0cXLa7P+ZXFNpsRWf+YlJ9d++fQBlmscNAQ0PN8M7TWvZgaLKSEJpM+Ah9l1ebrWBRsEb70ja5RO/nO6RxJzksR+KZpTyxj9DuniKraPtSaJTpnZBz6clRDKisaM6ri9+9GNjFXDyEoUcyDNMIlD91cA5QG1cmew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573550; c=relaxed/simple;
	bh=yLYYisQDo1DI3tOiIFDd/dLQPwKhv0gdti02NLOTW8A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L3WChlgM0wcAH62iKPe2FhFjm/0fuaHOtowLdNE8VwRdtydHtyd9dEqMFF24/Sx0U1nSXhCLnyPyb+RoM6zJx13QNullSFvXoEVGlaS0iX0F9cIZTe6/E1m3AWoZVxk6BwD743oeCA2WXh9t8bnVfrPmPOadvu7TZUVi+hDdqaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fECU9GCx; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+C2UXzNSsWsfC83fdCYrf4lGYd2nH+UTYBuKpbqlrmcwnW+blShQf0oc6jpkehOj0BTVcIcc6X6hnnDwMy4TP4x3xnaP/5Gc3584q0WPAqPVS7cJ2rgBzAbG6qjDLsW/HMZng1de/6/CXNG4C+bFcOyB1ZR4mGJVPMi6mJnQmDyx0UfVikQtt8d6XNhgwboe6uZce6LAU8k2oOeMZvyQp7at011SFxvX3B57QnOxAWEQiPEXX04XuiZblHa7BdRnRu/ZaDwduTQ9AI+544qVKWUzkvqIZrWR+qbjrS9jo0c6gR49S+/pwqfHJpO0d669nFncWjbZgWY2psKJaiZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IrlcNBpRW3/5678EPqCZLryw2AyHPCVgx5s6Op+m7E=;
 b=tIcNSBxhl13ks3Lz62/Ou8wU0icdYenii3cdXUZNSD69dX0GFgEj2zTbs6FOV0XGvdhzDCRvcVKFHgzPuulwrEKdWG/l9gp+De1+3t1So7fHXbUJwgpGD0AG+z1OCoB8UDcCPqUPxwJWu1BxC7sbfT3gGvTvlvx1AZTJVpYDRW+9i5W/6licOwnmhPcr4FTaj5xyZKnpmSvcps/4lUOAVbg8cS82cvIBl3LJvXUShnHyRCG7VmDBNrxcaSwqEjH5/cf6XX95jz7wOgNkr2T3WU+T3YCL/w4morsZNtQPdRmaBpOzF28/Lg795XCbCElg6MyJmXDwVzncrPWO6T3shA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IrlcNBpRW3/5678EPqCZLryw2AyHPCVgx5s6Op+m7E=;
 b=fECU9GCxGvmgpraUk/VSeIYxWusUWKvOqKbYPFXX+7BYlxr8yuMLDxU1zQkLx+TBw/4yleMIV6EMGa4VUvdzcPAxYMPuysX3jne86Ym0ubOgTElYPhGsl64HbUnYM2wEKKdHYNq0girAy+JN2SSGFs3FqtrGxSoQxVf1HrjUDDqga/5u/Ghz15ewwYumZ7kptC+pwk7IRQB+35+NXNeI+SBLuJZicRSmM4UX2LyGgiQSnv38NQl0MWPTyPNpSjK7B3d3ZZ5oV5L7UZTHZ9AfssWSBLm4u9ZCKlZUjHdxj7iaVAwBB6JsXdWA7pTLlncDdiNGXobpgY6yiHXD/HxhIw==
Received: from BN9PR03CA0079.namprd03.prod.outlook.com (2603:10b6:408:fc::24)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:45:39 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::10) by BN9PR03CA0079.outlook.office365.com
 (2603:10b6:408:fc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 11:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:45:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:45:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:45:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:45:24 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 00/15] net/mlx5: Add switchdev mode support for Socket Direct single netdev, part 2/2
Date: Thu, 4 Jun 2026 14:44:40 +0300
Message-ID: <20260604114455.434711-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: ba87e9fb-64c0-40e3-d33f-08dec22ecccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|3023799007|13003099007|5023799004|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/vIjeuGS1+bW3Sde4SVJC1+JcEboAVE7Pfqzux59bcrneTfoqd2o9YqQOdpequ9x9YvOsD1SX2Ew4O1ipr2kwIcgPu8/4rAPfCTh022V0XrwxFIGlKG0/RugeQc6Jm/kbt0BMmCjviOYjhB+mhQaCUawmWE1zuVEsgzrebwHoyEPKl+X4zbDBXu5DurKvPgd59Xh0bPw53vZXLuq8bcKDwD3+qgdQRPJLZajrh12PI4PXyXxdugdVvq4d2y/gwznTVZ3lFzXLIhldDrjz8TtXHiJm3b9Os7ZoIxLWWYFWHvtxV8gs+h7LudxVq1Xfh+ogZjxK6Sw4/V22+bGrhqtUHG9dTpmjU6log74dJMQ69G2y82FuK351vFkgmuLnuH6TeoA/2N8A2cqB68NRlQdOdgU32GwtG/LYBHsIPZ1YQHQVowBd7Spwb9mqohc3O5lfW2lKKVZyLzTNYVemodf8WhrnU5awNnHELazDpjD7ntMAQozb6UYyHhkpamj8HrTk3GE2fiz+zgL3aDP+38OR77Je3FoqUweaLDQJSaIUFuxvWWOFBIUaoF1rNREOgeU591x4iRMt/byltV0BmaHzs7J05qQvo3q1RWuOWA4RrfqDedngICoskYIyFKdelUGAxhYkClOI0dYcxCEHGS42q81DpAb6DRV2Lpntz/3jeagVyrYIEUseDn7DOSEuZPmluzwGEU4SaCsum9ftBGsptC5F0QBLHqazCDRR2DGjkI=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(3023799007)(13003099007)(5023799004)(56012099006)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JYefXOG18MtY/q6CqSDdUsO1cdFVejq+n41ib06hkH9tANLLXyJXl8HbEeZkn7v7/3zZvHyYWoYbm7kiWhV6EjtG3ODFiyZGjQ4elOfLhJLyUMEQgH/hkZoxmMIG5eyZ5EJxR2v31g8EPuoN9iIk7ZnPUuvQnO7cC5EGofziEnLoKjxvLbquaTBIxxcJensiQLvFIPkH4h7L1DkPR/ix8B7jjvLPmmSjBcPbojLjhImv98jlhFREDGBDo1IJYQAd0BVYapbQACt4yDGGD+CKYvY4RZF/PlUlDJmmIQE/exWd9BPoBMCbGurEGvpwZ3+baG6WJRpG2qe9mlz5y7t4ib/8pEKEML/PY9NxqAkl8LEsrs7BxJMNyazfp5QNISn29FrI1xA1UURbzMDc6jES6Ix3Bh7JKsWmZA0ocjirQEM4aS3P3y9lBumw4UMiYtvv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:45:39.1595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba87e9fb-64c0-40e3-d33f-08dec22ecccd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21748-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FB2D63F966

Hi,

This is part 2. Find part 1 here:
https://lore.kernel.org/all/20260531113954.395443-1-tariqt@nvidia.com/

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

E-Switch preparation (patch 1):
  - Skip uplink IB rep load for SD secondary devices

Devcom support (patches 2-3):
  - Expose locked variant of send_event
  - Add DEVCOM_CANT_FAIL for non-rollback events

SD core hardening (patches 4-6):
  - Make primary/secondary role determination more robust
  - Add L2 table silent mode query support
  - Expand vport metadata for SD secondary devices

SD switchdev transition (patches 7-8):
  - Support switchdev mode transition with shared FDB
  - Notify SD on eswitch disable

LAG integration (patches 9-12):
  - Store demux resources per master lag_func
  - Disable both regular and SD LAG on lag_disable_change
  - Introduce software vport LAG implementation
  - Add MPESW over SD LAG support

Deferred init (patches 13-14):
  - Defer rep load while SD LAG is not active
  - Defer vport metadata init until SD is ready

Enablement (patch 15):
  - Enable SD over ECPF and allow switchdev transition

Notes about a few items from an internal Sashiko review:
- commit "net/mlx5: SD, support switchdev mode transition with shared FDB"

> Because mlx5_sd_eswitch_mode_set() returns void, does ignoring this
> error
> leave the secondary device in an inconsistent state?
> If TX root reconfiguration fails, the execution aborts via goto unlock,
> but mlx5_devlink_eswitch_mode_set() will still report a successful
> transition to userspace.

[SD] This is by design-any SD switchdev related operations are best
effort.

- commit "net/mlx5: LAG, store demux resources per master lag_func":
> Can this lockless lookup lead to a use-after-free if the master device
> is
> removed concurrently?
> mlx5_lag_dev_get_master_pf() internally uses mlx5_lag_pf(), which
> performs a
> lockless xa_load() from ldev->pfs. If the master device is unbound or
> hot-removed concurrently, mlx5_ldev_remove_mdev() will remove the
> master's
> lag_func from the XArray and immediately free it using a synchronous
> kfree(pf).
> Since this path doesn't appear to hold ldev->lock or an overarching lock
> that
> protects the master device's lag_func lifecycle, could a race like this
> occur?
> CPU 1 (Adding rule)
> master_pf = mlx5_lag_dev_get_master_pf(ldev, vport_dev);
> CPU 2 (Master removal)
> mlx5_ldev_remove_mdev()
>    xa_erase(&ldev->pfs, idx);
>    kfree(pf);
> CPU 1 (Resumes)
> if (xa_load(&master_pf->lag_demux_rules, index))
> Previously, these resources were stored directly in struct mlx5_lag
> (ldev),
> which is refcounted and remains alive as long as any device in the LAG
> (including the secondary device) still references it.

[SD] no, before ldev is removed, the IB device is destroyed, and with
it the demux rules, group and table.

- commit "net/mlx5: LAG, introduce software vport LAG implementation"
> Does this code safely handle shared ACLs?
> The esw_slave_egress_create_resources() function correctly reuses an
> existing
> vport->egress.acl if one is present. However, this teardown function
> unconditionally destroys both vport->egress.offloads.bounce_grp and
> vport->egress.acl without checking if the bounce_rules xarray is empty.
> In contrast, esw_unset_master_egress_rule() handles this safely:
> if (xa_empty(&vport->egress.offloads.bounce_rules)) {
>            esw_acl_egress_ofld_cleanup(vport);
>            xa_destroy(&vport->egress.offloads.bounce_rules);
>
> }
> Could this unconditional destruction tear down an ACL that is still
> being actively used by other features, potentially leading to a
> use-after-free when other subsystems attempt to access their flow rules?

[SD] this is an ACL with a single rule, so it is ok.

- commit "net/mlx5: LAG, add MPESW over SD LAG support"
> Does this code introduce a use-after-free when iterating over ldev->pfs?
> In the concurrent LAG teardown path, elements are removed from the
> XArray and synchronously freed via kfree(pf) (not kfree_rcu()),
> protected only by ldev->lock.  Since xa_for_each() (used in
> mlx5_lag_pf_by_dev()) only holds the RCU read lock internally while
> retrieving the element and releases it before the loop body, calling
> this function locklessly could dereference freed memory when accessing
> Pf->idx.

[SD] this API caller assume dev is a valid device not in teardown flow.
If this break, the caller is broken as well.

> Can this call create an invalid global FDB or perform destructive
> redundant operations?
> Unlike mlx5_mpesw_teardown_sd_fdb() which filters PFs by checking if
> (!pf->sd_fdb_active), this loop iterates unconditionally.
> For non-SD ports, pf->group_id is 0, which instructs
> mlx5_lag_shared_fdb_create() to create a global shared FDB covering the
> entire LAG (MLX5_LAG_FILTER_ALL), resulting in a broken global LAG
> activation.
> Additionally, for SD groups containing multiple PFs, the first call
> creates the FDB, but subsequent calls for other PFs in the same group
> will re-execute the creation process, improperly attempting to recreate
> the already active FDB.

[SD] no, the iterator is running only over the PORT devices and for each
SD group there is only one such device, and when NIC is SD, all its PFs
(devices) are SD.

- commit "net/mlx5: E-Switch, defer rep load while SD LAG is not active"
> Does this rely on the InfiniBand representor probe to trigger the reload
> of the ethernet representors once the SD LAG becomes active?
> If the kernel is built without CONFIG_MLX5_INFINIBAND or if the ib-rep
> fails to probe, the ib-rep driver is never registered. Consequently, the
> mlx5_eswitch_reload_reps work is never queued.
> Since there is no explicit call to reload REP_ETH anywhere in the
> activation path, would the ethernet representors for the VF/SFs remain
> permanently unloaded? This seems like it would leave the vport
> representors completely non-functional for ethernet-only deployments.

[SD] This code isn't relevant if IB rep device doesn't probed.

- commit "net/mlx5: SD, defer vport metadata init until SD is ready"
> Does this operation need to hold pos->priv.eswitch->mode_lock?
> If this runs concurrently with a devlink command changing the peer
> device's mode back to legacy, esw_offloads_disable() could tear down the
> ACL tables and free offloads objects while this locklessly accesses and
> modifies metadata and ACLs. Could this lead to a Use-After-Free?

[SD] it won't. Peer E-switch and it vports are destroyed only after SD
is cleanup. Switching to legacy don't destroy resources used in
meta_date_init().


Shay Drory (15):
  net/mlx5: E-Switch, skip uplink IB rep load for SD secondary devices
  net/mlx5: devcom, expose locked variant of send_event
  net/mlx5: devcom, add DEVCOM_CANT_FAIL for non-rollback events
  net/mlx5: SD, make primary/secondary role determination more robust
  net/mlx5: SD, add L2 table silent mode query support
  net/mlx5: SD, expend vport metadata for SD secondary devices
  net/mlx5: SD, support switchdev mode transition with shared FDB
  net/mlx5: E-Switch, notify SD on eswitch disable
  net/mlx5: LAG, store demux resources per master lag_func
  net/mlx5: LAG, disable both regular and SD LAG on lag_disable_change
  net/mlx5: LAG, introduce software vport LAG implementation
  net/mlx5: LAG, add MPESW over SD LAG support
  net/mlx5: E-Switch, defer rep load while SD LAG is not active
  net/mlx5: SD, defer vport metadata init until SD is ready
  net/mlx5: SD, enable SD over ECPF and allow switchdev transition

 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   1 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   5 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 250 ++++++++++-
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |  21 +
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.h  |   2 +
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 175 ++++++--
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  29 +-
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  95 ++++-
 .../ethernet/mellanox/mlx5/core/lag/mpesw.h   |   4 +
 .../mellanox/mlx5/core/lag/shared_fdb.c       |  74 +++-
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  |  36 +-
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |   5 +
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 402 +++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |   8 +
 14 files changed, 985 insertions(+), 122 deletions(-)


base-commit: c1c3d01e3a9038d3e8f497e773e1f7b5d6b8212a
-- 
2.44.0


