Return-Path: <linux-rdma+bounces-18563-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLpDIvyDwmkAegQAu9opvQ
	(envelope-from <linux-rdma+bounces-18563-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:30:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF03083F6
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC3C9304A5B0
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 12:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40363F661F;
	Tue, 24 Mar 2026 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hFk0r4Ad"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2193A3E7D;
	Tue, 24 Mar 2026 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355389; cv=fail; b=jILi9hgIToddijiWmv/FsZ/zBLcLTtOxyKofe0Pe96AZZKQd5zS+/4TxFHpBQUvR7Rke4VuQrsJ1pilbLG2pYCq01kNFuaA7CFEH+yP6u9MjxTRF4tPBjAkQQT6XMLof0+UM2FtL+gTc4R5gPmT9PBdnJvtzed/3eMrDHyLAr7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355389; c=relaxed/simple;
	bh=W3iiBRqApcvKKT61nMulP1V41BY3T6YjT51BUEW/SKs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZsMabpLxlaql7/RKqsV9/EgJ3L0lOlMldGyVopFYVSDKqtGo5hJMzf6rGelNJI4kR60WGsys48Gvx4D0GcuIEvhe32DlO/eYxHGmGaP321Pz0h8oo1G/+2u6HEtHYfwUfNsVty9eQgYAQuZFt1YWnVOcsSHZx5BS5q30rI4jfhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hFk0r4Ad; arc=fail smtp.client-ip=52.101.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+salFawhLf+L35X7kfghL8xPfNK6aWqU1x4hAAM4v/L6cen9hsGJkB1EuVmHMu3hk8H327/pp3vwJ+HUsr2kZPvEbc54NKzdZCzBnggCZg+kc1kFkCPhyQbOt79LbfxGoZBgvyLjK6m9BK5KZwAT92gofZ1qOlPgB2SxlbEvOyb6OL1AvMJ5BmczT8NO8jT91OufchjvxCmdvjnSWC3Oc0/TGwP8hIeXdfosCyXSydrcXtKuxR8Ofi1DyHbhAN+A2P/3GV7PNL2sXxcrmrFfXqMFLunT4i47Pggf8RuJWJNiss0E0aOdN7m69e2AR3um3Wp17OgJQI3XkukMN8cNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hzm6ahfr9llfHQLnpVIBJPDvVgnTFkG6UPeR3lJsYTw=;
 b=hZzpYpOAJQJ2eEF2ogrsDosdxvU0ynonwhnc2PuRmUZk/Pe5gKjIQBMMy0aAay+y8S17fiiPhB62RRAr2G/WMM+Yv+aSvPc/vlKJAe/qSM9aoXhp9iePVVh1TlNJ+8f60d8o8JBuB86e4Op/Bf8doaNrE3W+gIwgyY12VB+nBSoM4GUjEj21+h6lj2t1GN1wku7xFF0ZnstmKHpV73zYmPajy9pDjQ4JilLBCVTEzqnC0U3r2WWLNo6c+8kamQZ21Bl5K5SuXxEwueOY4Hhp7DUUeZyYWzY/Of/rSJ+iU8h5s15JaxyYQn488vzmqiG6LP9OzbW2FNaFEMxn4miSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hzm6ahfr9llfHQLnpVIBJPDvVgnTFkG6UPeR3lJsYTw=;
 b=hFk0r4AdmLGl6MWtTOT2WIvCKJZpAbBY6OCtWOaIljLmxyFIEs+k5u8AB7OhAYd3T6e/Olo9wsryXSziUoEMZDqFApzDLnBlXplewCrhMMN2lXUVW1bBTh5CDN+KW2ekvAoWoU2pPnErpz6jcLFVdJZGdCYj/fNy+3ZxjrK4Itu1ju9lPwvJymPllOqRUuMylfLZ3mdQ/HbUrk1l1Td1SQlmDnVRMAZnd9zfINae6hteAs5yxzzXuz0u3AEncJ7KoFxKrQZs9n1rycs+oR9ufgD2jQ9EpgWSNxsi1vAvIyBSASEaSpXtW0z6blX36KlkcpHagvcry731FdPR9yYwrg==
Received: from CH2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:610:54::31)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Tue, 24 Mar
 2026 12:29:40 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::89) by CH2PR11CA0021.outlook.office365.com
 (2603:10b6:610:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend
 Transport; Tue, 24 Mar 2026 12:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:29:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:29:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:29:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Mar 2026 05:29:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Shay
 Drory" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next V8 00/14] devlink and mlx5: Support cross-function rate scheduling
Date: Tue, 24 Mar 2026 14:28:34 +0200
Message-ID: <20260324122848.36731-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 59da01b7-3c30-41da-2dcd-08de89a104c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|7416014|30052699003|1800799024|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7eAbH01oLHt5OfSKVXCJBfkJGdit2FkWn23Mqz3BGJYzdB5GK7OafQoskpHo9ZpbVPmMgNpsLKVdeFYembPqtS+QcDZw72LO8mcvXCqOdkOEwEtXc6AkzDEB6kPji7iZoF5JLyEcpqHo852eLIZGtXcrX3Vo+jAUpbE2jffg8Y+VSIepWCrLL1ZitYsWjE/016FX6coQu/myVG7ZOPL/mRO2xO/VRoMSGmkRQC/ivozFJq/wKUreKyyDLoISJcFz3IRsYZsUKuMM1KarlBo4PDl1unVt1til7Yn1v3qfgsrS6y2sREz8J5i3DfgrbGnsYxwCewkKSo9uFFWZ9uLIRqD3TpwgmWOrg+CCJ1cntyd4ODAFUqwWyc9OgIXVF4SBxB97GwMhEMbmtvitpQenHkcbJPyVPwuM75Z0TkbDlAkiUwVj66Y8VhZx2Rk6jXOt6U4VNhanUUSzWlvhyv0ne4GMKA/OANdJRLuJ6Oed5DNkXIew8U7bPdWSKaaRpHngrX7Cs3tRsu6SuCbfuS9AA2AF5zKggvlThv6JVgTBxzE4IxYYAVx5bNAYPBr6Qa5iU8R/Z2KLAz4QwgLmY1Sg5emolZ9/2qTA8UMuMyEY18+JbZ/hEeuLkVngmfiAOkVj1xw/FO35Cpnvgpsf3RfxxChLeQk9D8EX1I5MfW+XLxDWQILoi1A3iZtUGDFNjg35dcJrhHLMtjRLHbRyN7mZcpib4iS5zJfjQ4NCERJ1jEDDYsCaY8FVzjr/pBKegdunPEHcLFe66jOz6Fyeo4pL2Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(7416014)(30052699003)(1800799024)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YX+FiIPH/vSmy7fCpn52EPVbLNGY9nn6YKoFTTZZrH57NdEFwnAQXZdRrg+YELj/aaCp3E+EBMEcnhwYWQdy1G6xPQkN7kkXcnXItrH9WJ6ZbMA/I6OxnDMzWo5k0vJBRTnwMbpVXXa/r9TauAR7uNyEYJhr1leE6pndISggWJmBdjBxxxIvANqWz997bSKoflbwxWLhI1ukHkC5gOnjFhZyVUo5UWtqwofCAHH8LfS/Z4bSf5Aqwg6r2CWBb1FXKJy5b3nZ8uj+eJrm3ypvGAcpi+76DtsTlC/xhXJBj3yfXEdA4TXh4nkE6LCKGcRGYHi0IYazZqpRUIV1PtGPABOQx3yLV/w2grDkEH7SW95+6sLi+aA8pESPuG3JmRI8VljvswSsQ3I5F22H3Xpt5hdSrCOP6+4FvtRBoprqc/ex97Dqof9lu32ruamgPzXZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:29:39.4085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59da01b7-3c30-41da-2dcd-08de89a104c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,google.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18563-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 16DF03083F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series by Cosmin adds support for cross-function rate scheduling in
devlink and mlx5.
See detailed explanation by Cosmin below [0].

Regards,
Tariq

[0]
devlink objects support rate management for TX scheduling, which
involves maintaining a tree of rate nodes that corresponds to TX
schedulers in hardware. 'man devlink-rate' has the full details.

The tree of rate nodes is maintained per devlink object, protected by
the devlink lock.

There exists hardware capable of instantiating TX scheduling trees
spanning multiple functions of the same physical device (and thus
devlink objects) and therefore the current API and locking scheme is
insufficient.

This patch series changes the devlink rate implementation and API to
allow supporting such hardware and managing TX scheduling trees across
multiple functions of a physical device.

Modeling this requires having devlink rate nodes with parents in other
devlink objects. A naive approach that relies on the current
one-lock-per-devlink model is impossible, as it would require in some
cases acquiring multiple devlink locks in the correct order.

The solution proposed in this patch series makes use of the recently
introduced shared devlink instance [1] to manage rate hierarchy changes
across multiple functions.

V1 of this patch series was sent a long time ago [2], using a different
approach of storing rates in a shared rate domain with special locking
rules. This new approach uses standard devlink instances and nesting.

The first part of the series adds support to devlink rates for
maintaining the rate tree across multiple functions.

The second part changes the mlx5 implementation to make use of this (and
cleans up remnants of the previous approach, involving rate domains).

The neat part about using the shared devlink object is that it works for
SFs as well, which are already nested in their parent PF instances. So
with this series, complex scheduling trees spanning multiple SFs across
multiple PFs of the same NIC can now be supported.

Patches:

devlink rate changes for cross-device TX scheduling:
devlink: Add helpers to lock nested-in instances
devlink: Migrate from info->user_ptr to info->ctx
devlink: Decouple rate storage from associated devlink object
devlink: Add parent dev to devlink API
devlink: Allow parent dev for rate-set and rate-new
devlink: Allow rate node parents from other devlinks

mlx5 support for cross-device TX scheduling:
net/mlx5: qos: Use mlx5_lag_query_bond_speed to query LAG speed
net/mlx5: qos: Expose a function to clear a vport's parent
net/mlx5: qos: Model the root node in the scheduling hierarchy
net/mlx5: qos: Remove qos domains and use shd lock
net/mlx5: qos: Support cross-device tx scheduling
selftests: drv-net: Add test for cross-esw rate scheduling
net/mlx5: Document devlink rates

[1] https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us/T/#u
[2] https://lore.kernel.org/netdev/20250213180134.323929-1-tariqt@nvidia.com/

V8:
- Link to V7: https://lore.kernel.org/all/20260128112544.1661250-1-tariqt@nvidia.com/
- 2 patches accepted in v7, so they're gone from the series.
- Jiri's devlink changes sent as a separate series [1].
- added a hw selftest for cross-esw devlink rates.
- migrated devlink from info->user_ptr to info->ctx.
- simplified LAG speed locking in qos.c.
- found and fixed a qos cleanup bug.
- new patch simplifying parent handling in qos.c
- removed unnecessary exports for devl_rate_{,un}lock

Cosmin Ratiu (14):
  devlink: Update nested instance locking comment
  devlink: Add helpers to lock nested-in instances
  devlink: Migrate from info->user_ptr to info->ctx
  devlink: Decouple rate storage from associated devlink object
  devlink: Add parent dev to devlink API
  devlink: Allow parent dev for rate-set and rate-new
  devlink: Allow rate node parents from other devlinks
  net/mlx5: qos: Use mlx5_lag_query_bond_speed to query LAG speed
  net/mlx5: qos: Expose a function to clear a vport's parent
  net/mlx5: qos: Model the root node in the scheduling hierarchy
  net/mlx5: qos: Remove qos domains and use shd lock
  net/mlx5: qos: Support cross-device tx scheduling
  selftests: drv-net: Add test for cross-esw rate scheduling
  net/mlx5: Document devlink rates

 Documentation/netlink/specs/devlink.yaml      |  24 +-
 .../networking/devlink/devlink-port.rst       |   2 +
 Documentation/networking/devlink/index.rst    |   4 +-
 Documentation/networking/devlink/mlx5.rst     |  33 ++
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 524 +++++++-----------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   8 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  15 +-
 include/net/devlink.h                         |   5 +
 include/uapi/linux/devlink.h                  |   2 +
 net/devlink/core.c                            |  42 ++
 net/devlink/dev.c                             |  16 +-
 net/devlink/devl_internal.h                   |  19 +
 net/devlink/dpipe.c                           |  14 +-
 net/devlink/health.c                          |  12 +-
 net/devlink/linecard.c                        |   4 +-
 net/devlink/netlink.c                         |  82 ++-
 net/devlink/netlink_gen.c                     |  24 +-
 net/devlink/netlink_gen.h                     |   8 +
 net/devlink/param.c                           |   4 +-
 net/devlink/port.c                            |  18 +-
 net/devlink/rate.c                            | 290 ++++++++--
 net/devlink/region.c                          |   6 +-
 net/devlink/resource.c                        |   6 +-
 net/devlink/sb.c                              |  22 +-
 net/devlink/trap.c                            |  12 +-
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/devlink_rate_cross_esw.py  | 300 ++++++++++
 30 files changed, 1028 insertions(+), 475 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py


base-commit: b50a48b65cb0c955728894b24ba5ecc3cd4b8c7d
-- 
2.44.0


