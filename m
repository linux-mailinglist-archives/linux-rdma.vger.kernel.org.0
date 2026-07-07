Return-Path: <linux-rdma+bounces-22819-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5NZ4G8/6TGq+swEAu9opvQ
	(envelope-from <linux-rdma+bounces-22819-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:10:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A7071BB4A
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:10:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=PDYnk0F8;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22819-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22819-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4139A301F78A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4A414A3A;
	Tue,  7 Jul 2026 13:10:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C33FAE1F;
	Tue,  7 Jul 2026 13:10:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429827; cv=fail; b=QwvAIoQMExUjmwPJVgt3Wgb3vhj4fJjmQxmuGcb8HnxWX72ELYozcxcH2eEpx0cbY5iaieehhQTFuzw0icLReH/5orqPXKDZSlsERS9/aaV+viJ2StwHx2raUQ80MQJ/rxwDuei1dUJ+Hx/vTJwPVKESw85UaDb3DsSQG0QvW08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429827; c=relaxed/simple;
	bh=D+jb6wgrD/0Up8aJEVL0/ctirL+YAP3DVKWW8tFPY3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J6uY4Q9BbNB0NrClOCjlv8AjJa4/Av/YWir+nIoILknDH3o6N6Ck+eev3dWpuKRlhkBS+h6uJ2hTaPg4entWOdNrbV4kcDTiCgqoky77TL/3qbYSTI2Cl10ubD9SZS3J58BKMKZrkg1JsZtcZMC7CKWjZ3em1vghlaDwbQYVTN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PDYnk0F8; arc=fail smtp.client-ip=40.107.209.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdWZdbUDuvIXTE4kj7S57VJvr3Tz6kcVskbfKtfSWCUGMEb2JB8LwwTH4TrxdhfKzH7st4Xt1DQE7j3Nw7tGjQZh8RUZg0I/4YVs22HtO4werkvce8XaoDslwfw8ZBnRtTPDdA4EMKNqpMw50v9Zs20kZrJ88dRvDgRRFuBrQPC8HYgB4azZxIfC1SdrX82NodzgrU4KZ0hxgnrnPghaRQd+o97xpM9kW5923NK3o1AZtAheL+bKTwvxVYq3lm+H0Mj0vrkXA3AjUhFOMlGkcpqiGgd8UIF1iL3oO8MWoMlI44JOur8gZc+an/FdiVsRUuVAGxTS3VZU0gkLzy5O2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IVYvjZ6yjo2nLdJ809NdEj4paria9viyH07HTHmhJ0=;
 b=eRy5eql1vv6eTLRz5FKQOp/KFD6t+fJoF/XmvjBX6ML6qhiPtXrDvKF4W2LXy8UdCFbsW+Byq9MFDeWLyfL7hT17tYMqFNI4JGQKyCJ15ibk14tuWJ7q9EzB/L62k/a6DqGbI1p6d/014B76GDIP9siPGxBmMhDugxM9c18cDrB6/4hPGv8EzrcP+v/bscdag6Nibh5mePjdru2mQMxQGKwu0ZjDnfqUdwzLOHHPgq0xoPjZGMKXaOBszKu8dlJx8paDYC7qI1rjnqlMsyuBK7woY9VPfFvhRGFxuWkkAf1d5bFJkGo74XjiEpRGxEOVGJqoDRZ2kZsCmGT5tvP2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IVYvjZ6yjo2nLdJ809NdEj4paria9viyH07HTHmhJ0=;
 b=PDYnk0F8zPXUB5BKHpCVRi8ImhtVj/05KnA+U9xWG1td0Afqao53OIb+AQoGwZNHtP+WzCcm85E3M7o0v+Jmi2R8euziQXaAzxZuIJWD49Zw0UX7alDvWIoClQ6sDAoFRce/JRB0tX4Kp/zH0OQ9HrFa/4LpTHH4/2Q9fGuXdmGaqWATq2xM1KRB4F+6EwRe7RbSb3r5zXviee96XJv9UGZ2DEKUdmfvmi94no8gMIUu9WmVT8ox7RFIQDXoRSy6WHkSTQVb8Hsc/J596EVkqc1SzzjWPq+euXa0+f00oCvqWa/gEiI0FVEIAkU25k/insQY6+0w3IHaoOGDQvl4vg==
Received: from CH0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::9) by
 CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Tue, 7 Jul 2026 13:10:23 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::71) by CH0P220CA0013.outlook.office365.com
 (2603:10b6:610:ef::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend
 Transport; Tue, 7 Jul 2026 13:10:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:10:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:06 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:09:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Boris Pismenny
	<borisp@nvidia.com>, Chris Mi <cmi@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Stanislav Fomichev <sdf.kernel@gmail.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 00/15] net/mlx5e: PSP cleanups and improvements
Date: Tue, 7 Jul 2026 16:08:43 +0300
Message-ID: <20260707130858.969928-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 8302caac-5ad5-4ebf-c750-08dedc291a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|23010399003|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	BvWu5BuYCNT6AJPbROhKYEdOSXhbUcsgdL+sBNhQQIMlzj3aR6769UKWbArxT8mh46RI0yzockr0WIn7mkJ26X2+86/HwOR075ba4O1sNZzMpiqrZd69JcK//WVSoSC5nB4k/KoCDGTwt6VS2wGozF9ZmHRWbQl5ZmeZYmPPoZwuObNTDBMVOHepS1IhVYdTKCVkaARrmfZLdKm5FQPreHc/4l2ffeEHCtvaItbWsm9PSu4STjbkje0Nz9AqgznFbIRAVGIFpkc52uDbOKgq+93UfnmpHNIEzYuCeGLWPFnJ3/cso9gXuxlZCaSNQsUXcWordtbDAHPWMEmCFo87w4XHqDf2cEnvjOQkbVOjXZB08juaoNRQ8WjqwoMdvBA0y7FeC8F9KOw/nijRNh++l8taYWDjZshOMS8ITPpkcl8bQ8jPyhkIbLwppHnGQOLrYOgiRd99fTC3Y/ZYSDhbuuVtcyNx8pGpk9fgOjtjJjhstpGbKPVY8NLng4h5biPEF+UPtompMjxqte03WrTHx8rH0IED+FYWfTB3CgnoStUZiRXPXiNboubmMSpzdHrXo5o8/LnztX29DFroxYd/ExOmviyn+5lZJMTiI4VLE90DpyhEgvVkIoj09YNCjFwRJcv69NdwBeLhMMeUCBgiulvc4kH8YipXiCnzf0DX6MCKRL/YJolMOHdmITTDgRPgM4hWmRsn4JSHcY8CYn4MIA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(23010399003)(6133799003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wo4TzEVCEgu5h+GBs7j3utQru7UxYxBJVTv9XYX3LI59W/df0QGQh8849yOfv/u+F0UXu+/JWLoXBGPMQJhzFi0SBMiAexPFSUH3Q2jFDg+fM/Kvx6FUCw1YsYCHI7T720H9m4gxsR2aHyJl1KiXrjHM/xzs8C4eAaoeDrnAYmjrcOIo/lfuJtcADs8wPKJ/D/VWX72PwfMVrWe4ZTQd7t7G5Z0sD9YaZ92qN7efCbredP/QARQLeY1jGZqvzIr2r/bU+BXWUyOZVgnvJ2xZIMkTBlfGCSS18aJTNXYJIx3MteDZAb99aBC8nERpDq1CA0BEdyDkXmhxtEt288loUGEOo6i4KJNkEQF+OED3db55HiTlpnqoPBK8BPlU/gRyCpkZA/8KOsUUOH/haiT9e7e2UkyjNSxCdt0ptK5uBQYf9Q0gJayfm5MeFyH9+Sr/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:10:22.0035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8302caac-5ad5-4ebf-c750-08dedc291a05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22819-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nvidia.com,gmail.com,kernel.org,vger.kernel.org,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4A7071BB4A

Hi,

This series by Cosmin refactors mlx5 PSP support in preparation for
HW-GRO support.
There are almost no functionality changes in all but the last two
patches, which address a long-standing TODO in mlx5e_psp_set_config().

Regards,
Tariq

Cosmin Ratiu (15):
  net/mlx5e: psp: Rename the saved psp_dev to 'psd'
  net/mlx5e: psp: Remove PSP steering mutexes
  net/mlx5e: psp: Remove unneeded ref counting for PSP steering
  net/mlx5e: psp: Merge rx_err rule add/delete with ft create/delete
  net/mlx5e: psp: Use helpers for steering object manipulation
  net/mlx5e: psp: Factor out drop rule creation code
  net/mlx5e: psp: Remove unused PSP syndrome copy action
  net/mlx5e: psp: Rename and consolidate steering functions
  net/mlx5e: psp: Adjust rx_check FT size and use a drop_group
  net/mlx5e: psp: Add an RX steering table
  net/mlx5e: psp: Use a single rx_check table
  net/mlx5e: psp: Flatten steering structures
  net/mlx5e: psp: Make PSP steering config dynamic
  net/mlx5e: Return errors from profile->enable
  net/mlx5e: psp: Report PSP dev registration errors

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |    7 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |   19 +-
 .../mellanox/mlx5/core/en_accel/psp.c         | 1007 ++++++++---------
 .../mellanox/mlx5/core/en_accel/psp.h         |   18 +-
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    |   13 +-
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h    |    3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   23 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |    8 +-
 9 files changed, 516 insertions(+), 584 deletions(-)


base-commit: 31816fc5d9acf8cdf226cdd0dc296e8cf15cc033
-- 
2.44.0


