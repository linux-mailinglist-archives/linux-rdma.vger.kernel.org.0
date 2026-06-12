Return-Path: <linux-rdma+bounces-22158-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vK9NBw3wK2pmIAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22158-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:39:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6952C679056
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:39:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="o0Wk/lU0";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22158-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22158-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18E7E3091544
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379FF378833;
	Fri, 12 Jun 2026 11:39:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035DD337BBD;
	Fri, 12 Jun 2026 11:39:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264388; cv=fail; b=q8xy+msIKB766Ykom6snJYFfwFdCBZ0XPC6FUifCHXGWXCM5XyA+0CP0PsyqkcHV7IRX5fNEjBJoxLEKK89yN5WmmrdURl9MhXbwUBJT0NFaX9ckWgySRNg1R1/LmT1/UZy3PlVWbN6qhNG9P0E9/cvJGRfFG2Utz7RCIMMKPh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264388; c=relaxed/simple;
	bh=biUVYJ0tBx1+LN7uH7wyqgwm7xf9tF5BanvmD+UcnZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e+1JPtjZ6ABv9DUTjFpoxj9U2EOActyhvYUKB3tccU29s7nZDsN2J5G5gSP0ytVQuHVt5wjkOcJF3ySR/lUZAnc8Pf2HKequsxGWunpo6itXydeqUvvEBZ4z2mFenhL02q1+sCp4JX0qnhtHe4zLkonzlHv1f/8CTPvC7IFlj7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o0Wk/lU0; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZOwBE8Aem6YgaViH69WkCPxUy5S6sf7t3i/AlfaL58+CK5T4FJBj8dFf6g0z7tcC3lIuyBArZELpSE6afsyot4Kstb2eYV5rtIONQqAK9pRFLHC3rvqJTi29gNib2fLFIWiE26kwKGe+y406UylVPm0C7y1M8zWRmmb2QE6UPgyB27hc3HwZYSAbjYuFvUBZPQVy1RyABnWguYRtLqpVMQ6tf4tQLuUpydGbBHHHX8f6xd7KKhX4UMVQ3EbnRU2/wS7Dtv2YxGh+Y4C6EPblc1zfjwBbGZA+J+xHyyI5vyLeOyh1yjiwun12zXhJFp57JmzRTjh/0iddEo3IIoNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZgqgqBiYH3V13ZU04qVH6TFyAUezw2aOvO924SVC2c=;
 b=Yt3Q4LZ5ytxFyymyc2/8U81w7Qjbi9mbHkZuSNr5E8Fdh8/r0lM9bQdrG3bwegF9wCAGwN9EfG5GvXo2yOW3HtAd0WlSN0c+2xDCO/OPJFP2eAAB5749zvcpAdDVhgIjbtcQQuO8n5Sx/7LVGdD0uLQEc6didNDcbC5ok+IgZ8iAfQX+u7+EYnM1GNNJvqpmJsyoWGo5WbnbzRY1QORQYUw0eAAVq8K7rv/sXCdfKPyX8a+7khVzSKVGDd+HVQq4uHRiuPhvsvtuEfEX2SuT0pAV9yqG6vU4/scV+n+4Ql0NAiwnvKBq7opBIowdclWt3lbNNV7ucT9zLC8Ir6foNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZgqgqBiYH3V13ZU04qVH6TFyAUezw2aOvO924SVC2c=;
 b=o0Wk/lU0db3RwiqnGHiUur4dCmu4KV7/kuUPQXWLfpnfjSqrluU1z0vWMUdL/BuqnRjfRdi4xcObPscNXVCN8M661OCsOMX6aPKuGpla7u4923pBJ+ZV2GRsligRicQwVUnt0AoUBvwgFU/yZMJo/mu5v0j+7dczGw14LNtPF+A+qKG+oSnGfxpENw52uUYGwjGPr7Rkwh0NaHcGif8xyOD1C8hsaywIgHFxftN5cvfnkFLp8yrXhiQA8sNDTLmaoLl9DZzsEnBIROa9pu3fF6WBnrV7oK/151yH02Fyg9iwCnyqNsZPHeF7ff/iLr4UmexhGimnf6xnyaYU5s83Sw==
Received: from SA9PR13CA0158.namprd13.prod.outlook.com (2603:10b6:806:28::13)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:39:38 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::f) by SA9PR13CA0158.outlook.office365.com
 (2603:10b6:806:28::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Fri,
 12 Jun 2026 11:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 11:39:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:39:24 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:39:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:39:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V3 00/15] net/mlx5: Add switchdev mode support for Socket Direct single netdev, part 2/2
Date: Fri, 12 Jun 2026 14:38:49 +0300
Message-ID: <20260612113904.537595-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 13768f62-9773-4d91-ab49-08dec8774904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|18002099003|13003099007|6133799003|11063799006|56012099006|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info:
	Tq66Hak631tHyz0rQr0Iog5TAeDCoToyZcE2ptQlGrEPg7iY0oeXiknad4tFoydXEcIoUquf3/fbDe6HwZhozkNOu857RrlK8zCPgapasQYuoh04p2t9gLt1mpgTS+Gk9FlivvPnXk5bp5Q/fWcf7xYPBW4zUyZC0SBtfWZeaNeZUitdDYAZZCbHVUyXUtUOOLSOyXpciKikl5gOi3pHFWRGrB0ZaCo7gq/O0gO13Gk/LLBScAdYWSaU7whVfpH32s51iTDFzQrUTjrBuyJ0+Xy2fFYqD2jzzos2G7d5qXtvqUGlY/YgBYsb+hz9zHPxlRHKVQNkfnUyIkuSZUbmfBIUxpJL0Pd5fqXXy+hns0J8isj+IGWRyaF0nun+dLXTUjuqWS5B/XrxGfOvGeRciFGDs2ggd6nqx3O5+Z7XjGh0tOQ1y2KeQs4BWJqD9FaYezQ1LGhRuFH/IS42fD4TMK534rAXD1pvA6yNAEKRZ2khqc8f9qzpulQtuYOB5b161nfpgs7oz2KGFCO41QpVMegzbsClxRciKAkZ2mZcWTTgNJTAOwlZMn2bUuVXvTxGHXENMfzZRv8oKhXMYSuNzlHAAiCwQAEY+8yCFXdbf90A6irN2zAMvFB04o5TNafl0Vr4TV4UkmXTKK2NrNko/I/UkKAPNLuKs2yMPMI0Mt4e/+P0aqjqxPhAjWXafo6Re1oVxT+3Q43btH5bCqbX+3Pb0an8xe6/xjZdo56EJR5Ybp0J/US2EoBNRa1BIIjU
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(13003099007)(6133799003)(11063799006)(56012099006)(5023799004)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WRPQqQZ0qs9k5T0we82qykwxvgAoaTL+GX5s3UXFUmFoOd0XdUO0EuqKaXnKvtAgJIXXSvs4o6EqxKgMln1Wyl1ErajC3mP2JwyUjDI7+YJinhPi2tgZf25VMhBKP0reYuCAo97ZSbzmlngrWe2gtE1tpvG3APhPVoCJuuw9MPJyz3zWlxBzUFEXN8BvVcnvSc8LH7y8G06kjR6SvYsHi7fmw7PsMmrk8g7LxcjbirBT50NPIT2yEBUOD3HL/+S/8fbov8jDmRJXZGXMd8k3BQGt+jIUf8otUDDOxS31Rk+fTqnrcSNIqJB+0FyFRaF5ZHZAu5ILscbwvg2lxpLJ66ZPhpnIrchRuTGYd/90St18HCNTv3kX1kPOG+b4hbUEq575jtyahVE40cUmxmHhNVU/dZpHgMKc0+F2cELuLCEzk2lhUDNrzy6mF1Pd5VLL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:39:38.3425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13768f62-9773-4d91-ab49-08dec8774904
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22158-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,Nvidia.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6952C679056

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
  - Tie rep load/unload to SD LAG state
  - Defer vport metadata init until SD is ready

Enablement (patch 15):
  - Enable SD over ECPF and allow switchdev transition

V3:
- Patch 4: Mark sd_devcom as ready only if
  next_secondary_idx + 1 == sd->host_buses.
- Patch 7: Set tx_root_silent explicitly in sd_cmd_set_secondary().
- Patch 13: Expand this patch to completely tie rep load/unload to SD
  LAG state.
- Patch 14: Take esw->state_lock when refreshing vports ACL.

V2:
https://lore.kernel.org/all/20260608135547.482825-1-tariqt@nvidia.com/

V1:
https://lore.kernel.org/all/20260604114455.434711-1-tariqt@nvidia.com/

Sashiko comments from both runs on the ML, and the internal run here:

- commit "net/mlx5: SD, make primary/secondary role determination more
  robust"

> + sd->primary = true;
> + err = mlx5_devcom_locked_send_event(devcom, SD_PRIMARY_SET,
> +    SD_PRIMARY_SET, dev);

sashiko.dev says:

What happens during failure rollback if a subsequent peer fails during
registration?
SD_PRIMARY_SET is passed as both the forward event and the rollback
event.  If the event handler fails for a peer, the devcom rollback loop
invokes sd_handle_primary_set() again for the previously successful
peers.
Since the handler receives the exact same arguments and logic, does it
unconditionally repeat the assignment peer_sd->primary_dev = dev instead
of clearing the state?
If sd_register() subsequently returns an error and the device unbinds
and frees the dev structure, does this leave the successfully processed
peers with dangling primary_dev pointers referencing the freed device?

[SD] on broadcast failure sd_register goes to err_devcom_unreg
(sd.c:566) and never sets the comp ready. Every reader of primary_dev
gates on mlx5_devcom_comp_is_ready() (sd.c:66), so the stale pointer is
written and but never dereferenced. sd_register returns failure, so all
is ok - no fix needed.

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
- this note was on sashiko.dev as well.

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
- this note was on sashiko.dev as well

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

> +static u32 mlx5_lag_dev_group_id(struct mlx5_core_dev *dev)
> +{
> +     struct mlx5_lag *ldev = mlx5_lag_dev(dev);
> +     struct lag_func *pf;
> +     int i;
> +
> +     if (!ldev)
> +             return 0;
> +
> +     mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
> +             pf = mlx5_lag_pf(ldev, i);
> +             if (pf->dev == dev)
> +                     return pf->sd_fdb_active ? pf->group_id : 0;
> +     }
> +     return 0;
> +}

sashiko.dev says:

In mlx5_lag_shared_fdb_destroy(), pf->sd_fdb_active is set to false for
the target group before calling mlx5_lag_reload_ib_reps_from_locked() to
unload the IB representors.
During the IB unload process, mlx5_eth_lag_cleanup() calls
mlx5_cmd_destroy_vport_lag(), which queries mlx5_lag_dev_group_id().
Since sd_fdb_active was already cleared, will mlx5_lag_dev_group_id()
evaluate to 0 here?
If it does, there might be a risk that mlx5_cmd_destroy_vport_lag() will
pass 0 to mlx5_lag_destroy_vport_lag(), which treats 0 as
MLX5_LAG_FILTER_ALL and unconditionally destroys the manager vports'
egress ACLs for all independent SD groups on the device.

[SD] sd_fdb_active is cleared after, not before, the IB unload.
mlx5_lag_remove_devices_filter() is removing the IB rep, and The
mlx5_lag_reload_ib_reps_from_locked() call at the end of
mlx5_lag_shared_fdb_destroy() is the re-add path, not an unload.

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

> +static void mlx5_mpesw_restore_sd_fdb(struct mlx5_lag *ldev)
> +{
> +     struct lag_func *pf;
> +     int err, i;
> +
> +     mlx5_ldev_for_each(i, 0, ldev) {
> +             pf = mlx5_lag_pf(ldev, i);
> +             err = mlx5_lag_shared_fdb_create(ldev, NULL, 0,
> pf->group_id);

sashiko.dev says:

Does this accidentally activate global FW LAG for non-SD ports?
This loop unconditionally calls mlx5_lag_shared_fdb_create() using
pf->group_id. For standalone non-SD ports, pf->group_id is 0.
Inside mlx5_lag_shared_fdb_create(), passing group_id = 0 sets the
filter to MLX5_LAG_FILTER_ALL, which bypasses the SD-specific single-FDB
path and incorrectly triggers a full global LAG activation via
mlx5_activate_lag().
Should there be a check for pf->group_id != 0 or pf->sd_fdb_active here,
similar to the check in mlx5_mpesw_teardown_sd_fdb()?

[SD] pf->sd_fdb_active is false here by definition-we are re-creating
it.  And this API is already gated by pf->group_id check.  When MPESW is
destroyed, all PFs have group ID (if this is SD NIC)

- commit "net/mlx5: SD, defer vport metadata init until SD is ready"

> +err_acl:
> +   esw_offloads_metadata_uninit(esw);
> +   return err;
sashiko.dev says:

If a vport update fails, this jumps to err_acl and calls
esw_offloads_metadata_uninit().
Looking at esw_offloads_metadata_uninit(), it frees the default_metadata
IDAs and zeros vport->default_metadata:
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:esw_offloads_vport_metadata_cleanup() {
    ...
    mlx5_esw_match_metadata_free(esw, vport->default_metadata);
    vport->default_metadata = 0;
}
However, it does not reset vport->metadata or revert the hardware ACL
rules for the vports that were already successfully updated.
Will this leave the successfully updated vports with hardware rules
actively matching against freed IDAs? If these IDAs are reallocated
later, could multiple vports share the same metadata tag and cause
packet misdirection?

[SD] no rep is loaded until SD shared fdb is created.
No reps -> no traffic -> the stale HW rules / freed IDAs can't misdirect
anything.

- commit "Tie rep load/unload to SD LAG state",
was "net/mlx5: E-Switch, defer rep load while SD LAG is not active"

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
 .../mellanox/mlx5/core/eswitch_offloads.c     | 275 +++++++++++-
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |  21 +
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.h  |   2 +
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 179 ++++++--
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  29 +-
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  95 +++-
 .../ethernet/mellanox/mlx5/core/lag/mpesw.h   |   4 +
 .../mellanox/mlx5/core/lag/shared_fdb.c       |  74 +++-
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  |  36 +-
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |   5 +
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 406 +++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |   8 +
 14 files changed, 1018 insertions(+), 122 deletions(-)


base-commit: 5855479abc796c3b5d7b2f2ca147d68fc56cae1f
-- 
2.44.0


