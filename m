Return-Path: <linux-rdma+bounces-16590-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBsXKAqqhGk14QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16590-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:32:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D38F40A1
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C922304030A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0F407572;
	Thu,  5 Feb 2026 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cdlxnKDi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11DE3F23B3;
	Thu,  5 Feb 2026 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301883; cv=fail; b=NvicH8WXBWl8B5dvYZFeg9qkftuPNDvrEPB9cQ3rF3NuCi1EsKMDy6RsoXCRQSmpWCik/kFTKpSq3PJzY2HRn/lZpdKJJhBpxVl03Ck8aVYAhrgdk0HuA/gQOPVIXodAPLzsAt1eTJ/k2ACZWrhzzlWL7k13sIrBfFjZvU6k1SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301883; c=relaxed/simple;
	bh=ThkJnhF/oLDpOOMyBxFcotE+7Xl8XrqClLzhSPwLHNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOH/jt3BYZYRnbWh3/sybCNthm3Y9kWJbadymw8XAH98cnDGxjNlQqtqndh8dmRCi6yBfVtcnJpUBpsEzMzdhOE79icTyHeJF0eIfwQceG9c9UklBA4TkTcS1UD/+fkqoa37xrom4E9hhaRK1W1mcp7anQtLll9HFlYzOcsJ6kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cdlxnKDi; arc=fail smtp.client-ip=52.101.193.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doLO//JpvHS4pHnSxs0PU4BKfptcdVm54tdMVoRUqU46IsU+OoCp9JVVIqN1/lefUPziwSolC/Glpg/GfBgOOrpkkTuc4oIHkrp7BhiXVCQQ4PT5YLtMeKtcDhGu0sjptovIAmxKU30nktzqMHOITf1pQx0D3PYgsruYSMwQEIKBD0p8pNsbj3yJKZVvrI7axm7uWfhHkta1BOzDHTkVvaxiaNprAQ703h9vMaErpRa9VkItn/g90FGRQEF3+rB1hVMp2EsR0PJDgJ96VyMRurktHu5d71q38OfOga7Zyd78Ei2itLr7GkYbbZ3PiQqqL2slxFHl4dtVJKFn3slKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUGdfs9Kb8OXUcEpv95Of19l/c2kNeeIofKor8Yh49E=;
 b=y5PlHrvKpnQZREUZhFndBLDdmXgCfOqrzxneY2sYqTjjouXrJzYDE0p5KET8gWVrIinYnQJptMW/KhOhSDxnZqoK9xUp1YQVrh0XIpcj+DttF+3BblUPwZyCnJ1OT65KFiqRgIA/NAWG9gNbN0Z36CCeo3KWeUSQ0PPAtFTQ3ZdSkjKcXa0umCMWaA4buoU1SOyHtdd6Ptp35IWb1EUFVyp3T1tz/vug3ZqgSBnrx9kRqS4gr3Jxxn+iiVJnyNmdysAo96S0C6Zq/TsloaHp7nh+RHSdIA7OuNNTkrWztOX5cZPjTiLs2D4DxNs8Xa+fsHRTL5HK0Q+x8Uz1jDytfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUGdfs9Kb8OXUcEpv95Of19l/c2kNeeIofKor8Yh49E=;
 b=cdlxnKDi9StB6JXsRp46WlbexD/snbE4PB8mjhh9BOmlOqc6uwcKtx70XiikHkBipAe7ns5VGRWp8wq9U9J/ONUnblorO0NXm9WARpomMR3mvkl/BzP+lINputsPOH67aWtSj5/MCo4U1CKeJKFRE22BBQ+ou9kqoGLXTIhPe+5PBrrMj8XYMXn1+8S4ATKrfzzzPVZnNMXKidfqKn4y+vnh7RMuUYlRj3i/OiBxR1d6d6Wi46M6BEgfh+q3l7wFUcrg0C2NP4VBmu6nsAUaZK38EJsmoNez+fQjXpSCwC+UwzNMLYFd0ilY2DvXA7EIWuwko3hDFMYFFdnmAUMfqg==
Received: from BN9PR03CA0701.namprd03.prod.outlook.com (2603:10b6:408:ef::16)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 14:31:18 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::6b) by BN9PR03CA0701.outlook.office365.com
 (2603:10b6:408:ef::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Thu,
 5 Feb 2026 14:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 5 Feb 2026 14:31:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 06:30:57 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 06:30:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 06:30:52 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>
Subject: [PATCH net-next V2 3/7] devlink: Add port resource netlink command
Date: Thu, 5 Feb 2026 16:28:29 +0200
Message-ID: <20260205142833.1727929-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260205142833.1727929-1-tariqt@nvidia.com>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: b8741a1b-fc04-4a4f-f0bb-08de64c339f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kPIGXRTjP83CTh0iaRnd1Qlgr7UxBZEcOZ+eTKwYRLOFZS3wUE0ckr4DzVYk?=
 =?us-ascii?Q?DVFnb/YldVjcPM6pp/8VogmrsFeqeTwiBLsRrPhyMEuvKycWskRcQgtGF9CC?=
 =?us-ascii?Q?Zs84VI1QboMDhR5G805z7Wv3ZFo+vqn57PfE88bRWhzSxszeQwtMllFmCmeK?=
 =?us-ascii?Q?3B9pXaCm3WA2vKxqo/kOY04ziLQYwPq/Fw9th+OCOAQP4BSYMa7HqtYWaWGu?=
 =?us-ascii?Q?yPJ9HgxVD7eVBxFP8MCXxiW5KH3i54xzsR6zsc4MpCOVgVMs0TW5kC+MUHeU?=
 =?us-ascii?Q?H7qNK6HUtWCd8sWe0dnaqVmLQDhGYlw2ILqXQCFqK2vjsJx7wqXx3OhXwkMY?=
 =?us-ascii?Q?zpnem9cd0NFWz/KEXXwuez7vwX6x9yIQ0Z8FdTNgQwHirdOxpUvlCpAHJCUX?=
 =?us-ascii?Q?/S3uly8WipD/O/z5b57TCTHj9LiwdtyR9zBbwv4kAV7HBGaoq1N1TscC8Dba?=
 =?us-ascii?Q?3zE6KbQsr220oI15kd20mg/5ZFrnQI/2Cryd+/5oiNd1M2Zkad40dFIWOM9o?=
 =?us-ascii?Q?4SQ3dLZZTOlZHZgXetv7PCaVqfkt/hj5NVRJKF0LKwjyH9e/TdzD4keg0rlU?=
 =?us-ascii?Q?GEyRsyp1Uybx7RivXaAYXTiQvMAa+/e08G8pkvJ2qaxJKp5c+7PnU8arnPJu?=
 =?us-ascii?Q?xcyldlliQ0PR4k3RhJ4Wumxeg3qw9I32THaZZmNBbWU+EfiFgWOnqfsGno3j?=
 =?us-ascii?Q?DCcrSwaUd4v8eOKegV3Pd2ZkeKs7Krxl8RTTCgNX+WeHhd+ZWNnz7F7QKBLM?=
 =?us-ascii?Q?I5ogH8h2ldEmnjAM+asVm9kvPSRL0kE2CQ82lJoitGACiadHyE5fiIhHXjs3?=
 =?us-ascii?Q?5FESCPAnF5+9qULSXAf6sQS1O9uNuBGlZNPGZPy1HKwalEgx3LlUoxiM0S/i?=
 =?us-ascii?Q?h6h1+iBN75TED9xe6L/UgjIx3/UkORjH3DV+zkBIXer9cWTt5/gychm5xiiH?=
 =?us-ascii?Q?Wppu1ZKsanqFKMO0icg0wvjUgBIx8PJMgA6Ep1yBXdUHs1d6jP3yE6fs1G3E?=
 =?us-ascii?Q?+Orxkp5dNg5Kww5SyBzmm+Ls2Ymj9LRzfHGbBvrQ4mrXVuGMkgG8PMg8Z6t2?=
 =?us-ascii?Q?y4QfyytdPsdEGqHfE5adGUj0fPPvx2WTLgNo6twDFp+7BNtm58yKfmtY+bEN?=
 =?us-ascii?Q?p9wI1TX4Z6D0IETcm+UQyFqJVK1LDpWpFVBQnVG+85W8YCdFgp6Tzd+Ljha5?=
 =?us-ascii?Q?PcmNnqMzDIgoswYacguAAZhFDTNWep8xkHoyL4igBpCghLlLi22fzl2AzmtM?=
 =?us-ascii?Q?M/jb09N3kP1Oxn+Kr/dttmBlMMVIg1itiYUNZPVXuzDyfbbTbUUqXApeNg3D?=
 =?us-ascii?Q?68QfV038p4VUaSD6bGwqjvC81DLKpMeat6IcuJOLAV/r7E5U/6Fc1CpRFeRJ?=
 =?us-ascii?Q?eY+PKRBqstbNlxrlyMt1aVsj25KFFwrUJV3mIxAbP/+MvjrAwYqlFPw1iPOX?=
 =?us-ascii?Q?k6pSt+5Ra4qf1PsQ0hUfgdPmzuQcvrLn8lIvXU0xDXoGOPoz1S6LaL6hqVw5?=
 =?us-ascii?Q?2bwFXq7nF9Y44YmSNxttgqbDo7lUjh49wV0bgJ2mXnizPEcpT463cyVEmP44?=
 =?us-ascii?Q?UUvwQy5W54EOejECQKCKaY8nTJCoVbdstJkWmfgHmwJdycvi0P95MfLuDsqu?=
 =?us-ascii?Q?uvO6SdX/ZJXaPZh7g9ybb5i13jTM/ViH6w783gsCPAcFyBiPUqKUEhUQxt00?=
 =?us-ascii?Q?mbQmmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yVc3WaPRc61J1cbBvx07TuS/+ZV4tzpcvzASUiaFiSesEohX6E69rZhRy4x3NKbAOy92T76jDLYSrcw9kKlkwc1oT6iZnB/HdgrSNeHUSXUFCs2EvdBzQWqrE+xZ4ubhYq4482rhkKwDa83JtukPwizikTnc8FK2sDGbrnFBTYEXUFvmy7cMk+PGactgLqxnz2tB5tJpc1mO7QvnqlbnEBQz1rA2GIVVYymFuzgK7pNKGaeAH20IoyabFs8iO5YCHE+PCfzSdJEkvlb9sJ3aUyf4doM/puCeyALk9c33VONWN8gqIIIpiiTAb0EE9qKTKcOgRgwIgcLtmQ/s7bLMESU10xQ1nMot2v+9RjG0O2W2EoSzvjl1QjICJsPqjc7fCv2BBHpuO7aqlXlwVLoQ6BsGU8LjBh9gOE0HFaCXojlRmBFxWIBxHTbYjyTIhaOb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:31:18.5430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8741a1b-fc04-4a4f-f0bb-08de64c339f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16590-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 55D38F40A1
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Add support for userspace to query resources registered on devlink
ports, allowing drivers to expose per-port resource limits and usage.

Example output:

  $ devlink port resource show
  pci/0000:03:00.0/196608:
    name max_SFs size 20 unit entry
  pci/0000:03:00.1/262144:
    name max_SFs size 20 unit entry

  $ devlink port resource show pci/0000:03:00.0/196608
  pci/0000:03:00.0/196608:
    name max_SFs size 20 unit entry

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml |  23 ++++++
 include/uapi/linux/devlink.h             |   3 +
 net/devlink/netlink.c                    |   2 +-
 net/devlink/netlink_gen.c                |  32 ++++++-
 net/devlink/netlink_gen.h                |   6 +-
 net/devlink/resource.c                   | 101 +++++++++++++++++++++++
 6 files changed, 164 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 837112da6738..0290db1b8393 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2336,3 +2336,26 @@ operations:
             - bus-name
             - dev-name
             - port-index
+
+    -
+      name: port-resource-get
+      doc: Get port resources.
+      attribute-set: devlink
+      dont-validate: [strict]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          value: 85
+          attributes: *port-id-attrs
+        reply: &port-resource-get-reply
+          value: 85
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
+            - resource-list
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *port-resource-get-reply
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e7d6b6d13470..1cabd1f6cba0 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -141,6 +141,9 @@ enum devlink_command {
 
 	DEVLINK_CMD_NOTIFY_FILTER_SET,
 
+	DEVLINK_CMD_PORT_RESOURCE_GET,	/* can dump */
+	DEVLINK_CMD_PORT_RESOURCE_SET,
+
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..c78c31779622 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -367,7 +367,7 @@ struct genl_family devlink_nl_family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.split_ops	= devlink_nl_ops,
 	.n_split_ops	= ARRAY_SIZE(devlink_nl_ops),
-	.resv_start_op	= DEVLINK_CMD_SELFTESTS_RUN + 1,
+	.resv_start_op	= DEVLINK_CMD_PORT_RESOURCE_GET + 1,
 	.mcgrps		= devlink_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(devlink_nl_mcgrps),
 	.sock_priv_size		= sizeof(struct devlink_nl_sock_priv),
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f4c61c2b4f22..692d7862183a 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -604,8 +604,21 @@ static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
+/* DEVLINK_CMD_PORT_RESOURCE_GET - do */
+static const struct nla_policy devlink_port_resource_get_do_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
+};
+
+/* DEVLINK_CMD_PORT_RESOURCE_GET - dump */
+static const struct nla_policy devlink_port_resource_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* Ops table for devlink */
-const struct genl_split_ops devlink_nl_ops[74] = {
+const struct genl_split_ops devlink_nl_ops[76] = {
 	{
 		.cmd		= DEVLINK_CMD_GET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
@@ -1284,4 +1297,21 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DEVLINK_CMD_PORT_RESOURCE_GET,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.pre_doit	= devlink_nl_pre_doit_port,
+		.doit		= devlink_nl_port_resource_get_doit,
+		.post_doit	= devlink_nl_post_doit,
+		.policy		= devlink_port_resource_get_do_nl_policy,
+		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DEVLINK_CMD_PORT_RESOURCE_GET,
+		.dumpit		= devlink_nl_port_resource_get_dumpit,
+		.policy		= devlink_port_resource_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
 };
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 2817d53a0eba..204a665d2fd2 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -18,7 +18,7 @@ extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
-extern const struct genl_split_ops devlink_nl_ops[74];
+extern const struct genl_split_ops devlink_nl_ops[76];
 
 int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
@@ -146,5 +146,9 @@ int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
 int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 				      struct genl_info *info);
+int devlink_nl_port_resource_get_doit(struct sk_buff *skb,
+				      struct genl_info *info);
+int devlink_nl_port_resource_get_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb);
 
 #endif /* _LINUX_DEVLINK_GEN_H */
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 1b06a1f408fa..42ad7c96a740 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -227,6 +227,7 @@ static int devlink_resource_fill(struct genl_info *info,
 				 struct list_head *resource_list,
 				 enum devlink_command cmd, int flags)
 {
+	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_resource *resource;
 	struct nlattr *resources_attr;
@@ -257,6 +258,10 @@ static int devlink_resource_fill(struct genl_info *info,
 	if (devlink_nl_put_handle(skb, devlink))
 		goto nla_put_failure;
 
+	if (devlink_port && nla_put_u32(skb, DEVLINK_ATTR_PORT_INDEX,
+					devlink_port->index))
+		goto nla_put_failure;
+
 	resources_attr = nla_nest_start_noflag(skb,
 					       DEVLINK_ATTR_RESOURCE_LIST);
 	if (!resources_attr)
@@ -576,3 +581,99 @@ void devl_port_resources_unregister(struct devlink_port *devlink_port)
 				    &devlink_port->resource_list);
 }
 EXPORT_SYMBOL_GPL(devl_port_resources_unregister);
+
+static int devlink_nl_port_resource_fill(struct sk_buff *msg,
+					 struct devlink_port *devlink_port,
+					 enum devlink_command cmd,
+					 u32 portid, u32 seq, int flags)
+{
+	struct devlink *devlink = devlink_port->devlink;
+	struct devlink_resource *resource;
+	struct nlattr *resources_attr;
+	void *hdr;
+
+	if (list_empty(&devlink_port->resource_list))
+		return 0;
+
+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, devlink_port->index))
+		goto nla_put_failure;
+
+	resources_attr = nla_nest_start_noflag(msg, DEVLINK_ATTR_RESOURCE_LIST);
+	if (!resources_attr)
+		goto nla_put_failure;
+
+	list_for_each_entry(resource, &devlink_port->resource_list, list) {
+		if (devlink_resource_put(devlink, msg, resource)) {
+			nla_nest_cancel(msg, resources_attr);
+			goto nla_put_failure;
+		}
+	}
+	nla_nest_end(msg, resources_attr);
+	genlmsg_end(msg, hdr);
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+int devlink_nl_port_resource_get_doit(struct sk_buff *skb,
+				      struct genl_info *info)
+{
+	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct sk_buff *msg;
+	int err;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	err = devlink_nl_port_resource_fill(msg, devlink_port,
+					    DEVLINK_CMD_PORT_RESOURCE_GET,
+					    info->snd_portid, info->snd_seq, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
+
+	return genlmsg_reply(msg, info);
+}
+
+static int
+devlink_nl_port_resource_get_dump_one(struct sk_buff *msg,
+				      struct devlink *devlink,
+				      struct netlink_callback *cb, int flags)
+{
+	enum devlink_command cmd = DEVLINK_CMD_PORT_RESOURCE_GET;
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct devlink_port *devlink_port;
+	unsigned long port_index;
+	int err;
+
+	xa_for_each_start(&devlink->ports, port_index, devlink_port,
+			  state->idx) {
+		err = devlink_nl_port_resource_fill(msg, devlink_port,
+						    cmd,
+						    NETLINK_CB(cb->skb).portid,
+						    cb->nlh->nlmsg_seq, flags);
+		if (err) {
+			state->idx = port_index;
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+int devlink_nl_port_resource_get_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb,
+				 devlink_nl_port_resource_get_dump_one);
+}
-- 
2.44.0


