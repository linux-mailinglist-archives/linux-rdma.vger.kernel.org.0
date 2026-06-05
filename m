Return-Path: <linux-rdma+bounces-21867-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id adxWFrERI2pWhgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21867-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:13:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED33C64A76C
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:13:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=UQpZ0Ios;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21867-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21867-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C792302D0C1
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 18:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F73955C2;
	Fri,  5 Jun 2026 18:11:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F3383C94;
	Fri,  5 Jun 2026 18:11:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683096; cv=fail; b=tl6Dx1S2CG8RuCkgWa0I8e3nX9Y9MMWaVIAiuBOWFDkVK3zzTbYxwC0k07R8ex8ytnC6TAn09ve90/cz6+DBD8H+DyUKLc0ht5RglkVSxRUHnh/af2mNXUc3rd/LwUGvYNTTGy7K2Vw9G/GLtgt2aMu6d2rTTxxI0gzpurR0eLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683096; c=relaxed/simple;
	bh=nm7x9ced9yIj3nXwNd69WS7p0FYoLxp7fH23WEpxfm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvtYmZckS4AFphOxfdpBa8YnSeqJZQHkUTfH/FmXePvYXA/fEZq29PXDyXh5fsvUeTAIN3eX2ny/YbgCvxFDoT162S3xZO4jDSiAple/o+IojkNLXA7EP7+j9+nH330iYvuL8husICljRvC9cks4HyIdflF5i5+GKy9krDn+Wt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UQpZ0Ios; arc=fail smtp.client-ip=52.101.43.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERGCWVmaOfu4GhWG5fa2GyhZTcHfON7kxx0vTh8KGMG3LduzULtvmQtMLN4zBLZffESrKJuC/iEhBCbPRVGCEVMOf1blLyrcWHy7hWjTE4vkRMuUhVNdfDXhlelv9aC5avAw+RtBTms8/4kE10hVWqZqZoPvT35EWmah7uxd5E+9HUpIpIsOiPqIxU4IGGh75s7IaQo3V82zu0nyCNBXOCp62/wKrjx0iXJNF08lCTZHHm/YHJqOuitp2QLeYBKanUVyQ9YuiEbSNrqkd6fH+U4LmVg268rIJ9OMUVv5xhRbqu0t6vy9xyZ6TmMiLPRZ+hr9nA5x8GlnbG7ZVgSQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD0m/7A/DPGe3D8CCm3xi2pedqxzRC+YCS48sK6qaT8=;
 b=LsvN47wwU9ukIljGO/za/kFx77Ub0v32Qgn/TA/WRYFMiCSqrXbU2r3aW0cl977S/wNOCsQS62jaoQnHcVeLpuhpvNNZxae9SxithuHUKEob6FDkgTa9yh3VrVkXZ/HEeMrw8tGePrcsYnsHQHOyr3/6tfab0CgNbqNxuyI06lDX7yQ9XpwKfKV7mD1L2+KHl9i7O1WU+ZjrdHFT00fY6LlRV94sV0unkRq6pz12I0YdfUv1ZLm/etRq4UC43evtnDPTlgkuZ8tFTKjsh77gSjz2aTPSAalt7QpkVntKyTEo+qw9KV7vw0ZMNkRF78pDSnf2LH57Who6KUNzyct16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD0m/7A/DPGe3D8CCm3xi2pedqxzRC+YCS48sK6qaT8=;
 b=UQpZ0IosZA2FMwCvo4JrCzCQzw4zNeMXUpnqr8ApAc70FUQcVGzN4dBY25GkyrhmRR0MdNB76jEKBcZoI40KjMaMyxYan1AJV1f30j7EWbfzoXx5aeF8fxckvdkxoiN9yvR7ZP6nOcECGhu1fJDNRGvVE619jxn25xZlHebPVZJW+M5xtWrnIZ/rr2zGxX0/Nw2Fbcn4zL2PjVTG03oZ0SA6K3Bsrk/BwdgGjlqxL3uD/SdrnoZSZJnTI3eSlvXIhhuKzjRQ2/NBqXG5rLciT76obIf/h3eh61adJmCpsyoKX8mgsvMarVI8b9c3i94Q0EFUd+aGhVcZYV8lM8psJA==
Received: from CY5PR10CA0024.namprd10.prod.outlook.com (2603:10b6:930:1c::24)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 18:11:27 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:930:1c:cafe::f) by CY5PR10CA0024.outlook.office365.com
 (2603:10b6:930:1c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 18:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 18:11:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 11:11:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Jun 2026 11:11:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Jun 2026 11:10:59 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
	<sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Borislav Petkov (AMD)"
	<bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Petr Mladek
	<pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Vlastimil Babka <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Kees
 Cook" <kees@kernel.org>, Marco Elver <elver@google.com>, Eric Biggers
	<ebiggers@kernel.org>, Li RongQing <lirongqing@baidu.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Shay Drori
	<shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net-next V3 3/7] net/mlx5: Clear FW reset-in-progress bit before reload
Date: Fri, 5 Jun 2026 21:10:26 +0300
Message-ID: <20260605181030.3486619-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605181030.3486619-1-mbloch@nvidia.com>
References: <20260605181030.3486619-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 184666b3-1b1c-480b-82c8-08dec32ddca0
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	dgw641jGrcVG083PM9yUjyg/+JhEFdyXZQJSUpdxWznGZVHBpVGAoNF9OQ65hVpu1Po6kIuC8ttRCWYJNa3dTTkm8smfYTzHtYwgMnqHBXgkk4Xo2i3hr35VJqF3NqWprUnNACHDkEXMS1XCLvt7ycxBKZePyLUOd6vNv8enOrftBkPfX87mAj+JS2nrhd97Dmn+wKnPWgyfhLlgSOKlYSK8AvXkAqxKcBifXENWWeV4mSvdO+vHT+d7jXto4UBSw4XPsU/d/QkFlHBn8tbC/UnUTTmZcyfjNGlD0pRTPZDl+zBncpndz7OCtiuk9xPRj7jiSFoLC9UYXcvzGwfw7AcbnWmYAMwRt+L9ybJqfstBysMCUyiVrkfPkqh596aDUozauo3nYql8sGrp3plOei50iIxhxX20V7R2zrz9PT4NRDfGvY2WfpIaumoCHPpByLmGX7Ga7uXeFct9/HhqvFaQFDQGTya5Z5HEyhbbbEFpzEX4b3OZlSYyS7vbi4ErRalm48If6o/twBsDUHjxbX91pKJUkj/sUfoJfxjX/UUagqItb+fyhk4UFcYNTe2+GNGeQLouu1rZFGGvTXeP7ShZPENGhklV0H4mF0K9Wi+nHjFTtp3nHvW2ZOVgwusyv1+OjLMoClqzWxQZ+5B70izh+PvarlCudVZ/eYIUcgbjbUCKXwpPGfPKJRw+UK4yYZh+CDPuPQL3voYblxktr/I93syrH7C4GkXLFKYUIkc=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+hBe/BMcAnm50+4GrXpMSocY5vjH6y7Yy/Cc2QGeso/kuIq6qy0MSo2F2AGxXnArWI2tqw7TfwgaY0Ep6Pk6vTSzVgPFCjtrmJYW1yuDtfrCoslRXzgcZYp8EQXeYPP1g4axAnCC8loplleLjbJlmVNzqNEQTqeCKE7kBenJAadMTWe5cpF20wpUcYLvdcLWfRNmPe5peKyxP/mgwu+29pL23tA0J7i6J03UhlYZbAJ0z9Qy7ZScGF1YRUqpDuIOceRicX2OYIR3hYNuWo1XjQdYUmCfRgX7Ez8foDw2F7WpJyusN2NZLwtealyYga2zoemrcDTNJ21Dnbos141Cfup+Piq86SP0qQDYExu6peC3rj3qW+tsczLHjwkvxrNMw6J334RjRY1Pph2Q4Rp3yB/cuaqAMs6Z6+/WDPlKOARyUj9sLdzNMqbVZ+6P4T96
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:11:27.3644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 184666b3-1b1c-480b-82c8-08dec32ddca0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[43];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:peterz@infradead.org,m:dave.hansen@linux.intel.com,m:vbabka@kernel.org,m:brauner@kernel.org,m:tj@kernel.org,m:feng.tang@linux.alibaba.com,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:shayd@nvidia.com,m:moshe@nvidia.com,m:andrew@lunn.ch,s:l
 ists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21867-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,alien8.de,linux-foundation.org,infradead.org,suse.com,linux.intel.com,linux.alibaba.com,google.com,baidu.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED33C64A76C

mlx5 sets MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS when acknowledging a sync
reset request. This bit blocks devlink reload and other devlink operations
while the firmware reset is running, but it was kept set until after the
driver reload finished.

Clear the reset-in-progress bit once the reset unload flow is done and PCI
access is back, before reloading the device. For a reset initiated through
devlink, clear it before completing the reload waiter. For a reset reported
through an asynchronous firmware event, keep the unload flow outside
devl_lock, then take devl_lock before clearing the bit and reloading
through the devl-locked load helper.

Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 28 +++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 07440c58713a..7283e5b49eed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -238,24 +238,30 @@ static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 	struct devlink *devlink = priv_to_devlink(dev);
+	int err;
 
 	/* if this is the driver that initiated the fw reset, devlink completed the reload */
 	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags)) {
+		clear_bit(MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS,
+			  &fw_reset->reset_flags);
 		complete(&fw_reset->done);
-	} else {
-		mlx5_sync_reset_unload_flow(dev, false);
-		if (mlx5_health_wait_pci_up(dev))
-			mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
-		else
-			mlx5_load_one(dev, true);
-		devl_lock(devlink);
-		devlink_remote_reload_actions_performed(devlink, 0,
-							BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
-							BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE));
-		devl_unlock(devlink);
+		return;
 	}
 
+	mlx5_sync_reset_unload_flow(dev, false);
+	err = mlx5_health_wait_pci_up(dev);
+
+	devl_lock(devlink);
 	clear_bit(MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS, &fw_reset->reset_flags);
+	if (err)
+		mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
+	else
+		mlx5_load_one_devl_locked(dev, true);
+
+	devlink_remote_reload_actions_performed(devlink, 0,
+						BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
+						BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE));
+	devl_unlock(devlink);
 }
 
 static void mlx5_stop_sync_reset_poll(struct mlx5_core_dev *dev)
-- 
2.34.1


