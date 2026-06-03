Return-Path: <linux-rdma+bounces-21709-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pkc3FvOCIGog4gAAu9opvQ
	(envelope-from <linux-rdma+bounces-21709-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:39:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CBA63AEA8
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:39:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=A7eOxpHX;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21709-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21709-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FAC03064723
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 19:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A6348C3EE;
	Wed,  3 Jun 2026 19:34:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1148BD55;
	Wed,  3 Jun 2026 19:34:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515245; cv=fail; b=prga3C90wYMNatoOk1+grPXAe3hJ3psg+W5porrj7XIhKjfM+UJVz/48w6/gRlkOomfXN5ISTu9QmIWzZ1ab+x+nHtctxyyS3j1cEONUEQBX36pYPa+rAFBEx/5PyRFFbRhZwyQcBRRQfgBUdisCxht9acq33O8rM5rxHAct8qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515245; c=relaxed/simple;
	bh=nm7x9ced9yIj3nXwNd69WS7p0FYoLxp7fH23WEpxfm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sK3zib9EAszjOUtJapaAg/FpnWUdd3FL/arawiIWPgI3HsI7qs/qe8bzIJkwobVZsvIjrfxwXydF7TaWOQZbokPmYSVuTQlXOJq8oWMr8b6pCm0e0KKbiUH4dIGpGvQAQCNwOgp6DFEvm5ky+nRC6Z2EtNmgA+Gh0mSUt7qHvuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A7eOxpHX; arc=fail smtp.client-ip=40.107.201.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QL2t2BBfZS0MgQ3MEJDHzcWTjLxuUifHP23xXDzrpTCKX7kEqp5cFAlmfFW7acwTIuFONJaT7XAFvOag8cmcoay/iunq1DmJAHjpZoQ26fu4EiEBWfaM3EgCKoq1UwBsDJO2ftGnDp+ycNlgq5VVk/3CB6juL0mbbCMo7aau+d5Mx6Tyr08hnszs9JoF8pX6NngTdTFAYJi6HrBiYtlIDh8gLiWczkEfsTLd/WnpGywd2A5N/MCx+xA6R/1jRPWkouLkFGjyIIcGBkSfRJZGPkyEICkJ6cae8G4Dah6SP6Tt0rFGoowsBvs34xRRB+wGHrp8L9niIbuMP6bRvv6PRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD0m/7A/DPGe3D8CCm3xi2pedqxzRC+YCS48sK6qaT8=;
 b=mIESZt7nWw7GoR99s73o7oXk0MN6oM91uihgFsnHn6H62HKliHBbIrKCjJ+kKiPJNofnJshPi2FRjdeecdT11x9Dpg+gUC1iIbZkeF9Uw49Zqsn4XRvLfxJBIalQu5HOze93jOV7K3G/F5Hmi8QUftALH3u9xtZrtz4TeuzenQqcyNiRTAcNdF1kdB+3SOqpo/xM21oGjCRVKmL919ShqMkGjLzJbjL2JK7f49OSEaGiLTbGCAd1cc6Jw+ltp4grb312CVzA1FXiaRG3fSj4XOBXLaGMRouUQ5QJLHJCl8LFxxm05NCDojL0jBWA5tCUnpFLjBTAILYgdnGjxhMAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD0m/7A/DPGe3D8CCm3xi2pedqxzRC+YCS48sK6qaT8=;
 b=A7eOxpHX8ablJQsfuqrzsR/hTF+rCRfgfOkqHYC29syRJDuf3/ykXtdsLsZ12ZrIGBXTmReBE7q7yySQXjTgP4zD4ANXxfjXdTJCnIMtD1hW712dTsEgfeXV+7htpgTMU6RbKe7zxdlp/GqLkqpapwEmuHo3xFvaAkmOFYjlCy62mPqpntLtx43v6qRDZumREcmFnwEewyX65SVUJVbpBY5jQwt8apYyBV4EetG3XMHGcRRBfwtim5jfWmkACqbt5HZsmfiQLPpxg4yQ6Txs67pxMRk6YB5EsSxi8UKU4WVu/zJBjuHLbIcPWvmMQpyxzETp+wiX1F+DjNFWBx3vKA==
Received: from BN9PR03CA0170.namprd03.prod.outlook.com (2603:10b6:408:f4::25)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 3 Jun 2026
 19:33:58 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::43) by BN9PR03CA0170.outlook.office365.com
 (2603:10b6:408:f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 19:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 19:33:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 12:33:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 3 Jun 2026 12:33:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Jun 2026 12:33:29 -0700
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
	<rdunlap@infradead.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, Tejun Heo
	<tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Eric Biggers <ebiggers@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Ethan
 Nelson-Moore" <enelsonmoore@gmail.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Shay Drori <shayd@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net-next V2 3/7] net/mlx5: Clear FW reset-in-progress bit before reload
Date: Wed, 3 Jun 2026 22:32:55 +0300
Message-ID: <20260603193259.3412464-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603193259.3412464-1-mbloch@nvidia.com>
References: <20260603193259.3412464-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bcd1249-a4e8-4abc-8f96-08dec1a70eaa
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Aa1OvWNHdR4LoHDLHLkNdFi/KlaSktWAGoSxTVhUWoeDfhPEHBMk4bLB6EQYPEmX8DbJNMy1s8VvLSYoPoPz8SGqG5GoyQsN9uag+pi8NhCjVYBbAFvgbWiso1YFiDOHc2hGhWnDz0fu2/YFA2EtG1CqgkUZslFF+8olCKUV9Y6WU43uZm91GRDdClu98FEKAZWa93Rxj1oBQiv/lMVGEBySbOlKWRMAWndEzn40JP5A+YkS/MjOCCpm++nxuB0ilAgLzyOmX9KCenpnkane2q72xyOudyWohX85eQwkGiJTscno2g6iV34Xrw/nJ+JQ4arzVq/Rel2mXqS5dyaOAU2LOPqZpYXgWseAbFVVOwjsmpOGR3koDtf3MiXhLHNX5KrJI/9zu3+46f8f47ruDWo+uYqGhtOnRVRlxlx983iaYgG50jYi7spdmLtNDqxnlSqxt0qkdT6X2rdeudixdsR/XWRqllFCAavHmPennqk46c7uwKvScNUFI50QjjITpQXRbAAaER9DM5ubgE5O3Bcw0IFxRRjFtgXRucORCP6/Q28tgVpXsL+2Jg7wM62F3BGXpb4Rm2MqZMP9Nbo4RMbHU1E+/mDxTPuxpYBBjWjSH5pRxXZeKDHNKv4YG7QfXPCO4nLvBKU8oZKatKB+kt8Ype2LTYBHYG2N1OPDH1TEoabnXPpJghw0c0Q/wjCZN5TFerEg4wCMBj7ZJXKVZxBJKvf/KjGJHzfNBhlBiV8=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dv48wowCYw8osnjMJo6u5wXGI5n+FKsFQcy5VmGQzmHI0DCIXI4nOZCzZc20mIVeLkbOowwFFs8cpVJdHv6gJM97gMwl5aA6NbXbB9GYPVuSj4WIZwI1hsKGWJc/IPW/PZqEON5gYPF7cYKd1aUIOTQ8B4YOpXpHVgfVdLVJiMhkmPsNDVmhr/Dx1lhRBHnmTxyLrC294ZpydNziIE4yPFPmWLfyw8Ni4WdVX7lNG3gf6EDdLf61FTLBiJYaZSEaRRS+Vni35MiP6Thdj4H6TETc62kX8YHopNA2GzoZA/1CAcXKuGfSSzh6spxpUus7wy/T4m6suHybeo7KI2d9CQz41SCozxB1UJtFKAEUgJdTX3PSPIVl0bX4rsENhuTvZcSVwKJfaj+CKoECXVsgnDFL3u0IGgu42p0iT7vMTERm3lfsk0Wuf2+4QAZ34wH8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 19:33:58.1356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcd1249-a4e8-4abc-8f96-08dec1a70eaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[43];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:peterz@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:tj@kernel.org,m:vbabka@kernel.org,m:feng.tang@linux.alibaba.com,m:dave.hansen@linux.intel.com,m:brauner@kernel.org,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:shayd@nvidia.com,m:moshe@nvidia.com,m:andrew@lunn.ch,s:l
 ists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21709-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,alien8.de,linux-foundation.org,infradead.org,suse.com,linux.alibaba.com,linux.intel.com,google.com,baidu.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3CBA63AEA8

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


