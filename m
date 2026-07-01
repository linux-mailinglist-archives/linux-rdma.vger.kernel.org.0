Return-Path: <linux-rdma+bounces-22621-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OIAeFNvDRGob0goAu9opvQ
	(envelope-from <linux-rdma+bounces-22621-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:38:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C36EAB85
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:38:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=aEquHVbp;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22621-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22621-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F91B3073706
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB82E3C10AA;
	Wed,  1 Jul 2026 07:35:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDFF2798EA;
	Wed,  1 Jul 2026 07:35:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891340; cv=fail; b=MlL9Qsiv30SB+NzIoLM/HO2+5tmQcKbwg4v3Kosxuy2qN9jVl6PE3TDoYHDMZC6l0VAzvo5ZW1azMiMpcKFklIrdjFTGmgJzAgDe8feQt/hwESYEXm2SBWCvDfHk3CvkjlFrC/ElDbtPtVC63MSla8wbeqP+OrPhXz/1tVloRVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891340; c=relaxed/simple;
	bh=ii+YroficNx0hMR+Io/DrsJIQHIDSQjALKkDcv3feyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1dPUFtcUKD6aXBMj8jJHmyR7ESr7GQ+ugujTRQbB7YHAYGeA6leWqKyXpLJwDBIXH2AilLyorEhYuaFKl7Y00ysqibRyMHz/NTjLAAkXNLgmO2ECNVGMebfEqJeEAn6Tqg8Gc6nkl98qXjFGLiOVxoxClAiTDF7cztivTWdoOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aEquHVbp; arc=fail smtp.client-ip=52.101.52.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3VANZQtzVFt6UOton6u5Fkor2a3LV6hMZERB2GmCwrMpCYjQCBSr/jl8qHFyt/qNp5/89JVMS8f3//n/R+dJJZ9AIwhr78Ei3UvolQZavg/XUi3dXFlUHfirb/O3K+uTmz/x+HgDjElgiAAh5X1DnenK3/zE5eSwAhyNX3XMn4/ZG8plXLykMTt9WO3Mc9Lp1IegrMv0j0vJImuFvbCjMnqKfjSaZfT9gFuJfr30Cg/HMxzR1KeOhKYg2KEz68+yciDFb5ma+oUWds9zw99Q7tHT48YbFiMCGyFbvdjU9UwXxJl5X9xWwhret9tpyys2iavZVxFYt7O2U7GYaKGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VssKR3DAxtrqDdNd6czQlfd/4Px9dNP/mA2N80UXEgM=;
 b=CQt2/waneZanD6wQ4IXAmWxNFHYR9mhBH+2z4q0VlfJGTXQTvS54QZQWmgRoQUV+Y5Mgvofgq+F4VUAB0Jms3EEGazadxwOb8avxYH/Hb1tHBP3Cwe1NjIHL5lmYhMXUU+Xq0vDoR6ClQKERO7LO1hRdQxGx2oyfSXZWcX6JSUrrCWbBOABgwBdse6YLuALNcYHLFVCtNPQUqPUkBmMvSE0Li5m01oDBuRl43TFjwdLocjJzBSbPWI3aZ7QL9plIpuemLTr6F3Ns9LAC4AYVaMZ4bKR2weH3Hq8xp5cgRBJL/URe4ijMGoEPF50x/qC9yJ4tiMT8U5HjAr/TiQIJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VssKR3DAxtrqDdNd6czQlfd/4Px9dNP/mA2N80UXEgM=;
 b=aEquHVbpki+i4g78o/QMAjgnfZ/PhWlLhmkF1BeFiMT8eQ5BsXQEV/5PkE1h6rzXyPubLogrfnaIWLKQw1SZxwMOXQ9G0e5Q1ouicQh+s3VheZO7kpLeinqjDj9Q8DemtaVNcBD911DIBwT0z1y4fsjxQOvvKUCTR3ER3qTyZ44vi1XG3GqTlFmC4FVidTcMYIJERdiZa5X4CehWsWXQNfK+Dy/ybLg6PGtzvCA1ZCvNDoCQa6zxCP3KKSFb8L5LyISFRJa6lvp0DT4JGK/ciS8xZkVtNFLfqTYSjCmugV/Ie3xM9kQYwGzaRhit1eVrvzO7ORn843HC2NQLjVhLhA==
Received: from DS7PR07CA0009.namprd07.prod.outlook.com (2603:10b6:5:3af::9) by
 CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Wed, 1 Jul 2026 07:35:25 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::5c) by DS7PR07CA0009.outlook.office365.com
 (2603:10b6:5:3af::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 07:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 07:35:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:35:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:35:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 00:34:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Adithya Jayachandran <ajayachandra@nvidia.com>, Bobby Eshleman
	<bobbyeshleman@meta.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, Daniel Jurgens
	<danielj@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, David Wei
	<dw@davidwei.uk>, Donald Hunter <donald.hunter@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Joe Damato <joe@dama.to>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ratheesh Kannoth
	<rkannoth@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Shay Drori <shayd@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Simon Horman
	<horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Tariq Toukan
	<tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V10 10/14] net/mlx5: qos: Model the root node in the scheduling hierarchy
Date: Wed, 1 Jul 2026 10:32:50 +0300
Message-ID: <20260701073254.754518-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260701073254.754518-1-tariqt@nvidia.com>
References: <20260701073254.754518-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 724d6dad-e5b2-479f-ba6c-08ded74350e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rw3d15FRyGzwZNIu/GZ5qiYynsrHOGHf95sq/edPA2x04ClVRqxVaeFP+rRgkhXtqnClHaexs/JcHddK+CxsiIPQRls73vGNcHXSzmOAk+vtL9iIkHpLHI8KwnjVS1KLEREqIkdxJcgR4FVohfB7KnGVg+7rVt7iq0izvPzuOgtfbk2xdfxDyc0ehMcpcdFHPPTl6/FWCfs7P3EM4XYKegWi1x8Y1CtSytvsCSF0bKtoDXq6dMBpS7wY2AudYABW/gRxt6RDf3AbpVEOgX7MUy1aPHWS0558dvDQmSjMQIcEcvwRcOYGs0b1Dr/TH7iLTvbnBYVCr5hG0phL56pmehbJ0bXA6PvN1DRfpKJn4m6pSX8fzg4h78HHLCNoIOGZ0hp1kGmZ+QYxSuVGPQ71PTgxftOE9UnhT58Ur4IDlDXkcE+KoX/Y07YGou/bufOqx7sIjc21TBz/H1cuxmCyyTY3afVyAGeLGdAme0yqq3nPKHdB5VKsfqNkyXMWPjreqqirA0t7K15q7EcmBNTj7WCclhWyjZpTs3dwWatrg+nD2mM8Inz5xrs5v7IW0DoYUYHeiVvdDDV50xcQ8afNaUrXHChGxO+hcGND0XAdhCdtRBLGqSIpVhJxSC1NyxZ6GuganB0c4jcyoapYJgSNnV1WulxEgm5MfePUjlWxl7BeQ9ZZHUhGyr5FhhrNS09Yz01IakUys98sfZcczuHbwQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pURg1vfq9nQ9KmsCxBumRgmtQ4+S0hzn1rvzCvVnj13gN+n5fEgwMd/8skxolQ/7QIlNFe81uyCRV4+Iwld4sSd1yKBlJrp4LwXR469NnwBwAuC5Zh9eaMoMUEA2LM9D4F64LfsmXPvnJXcal5y4vsce3gIGxADTt0Y+U6LbzLla5L+7Yu8zojFjtRf0EWlKuMosiWru8CKxT+Ab4fu8d8YCcWFGYg8nCMOvtWhCjfnTUlSEf6H/4z/f2GACRgUYvrwQXIfYEaJlkHjP0kWpD7V+5e3DMRbdUbzBrt7SQF6vq+FmfdrTYMpNJJmQAIye9hSrhkQ8yOYd2Pb94z1HLtgV4oMQdCM2n9ztnJPsfIJjumzFc14VUB1sjc4TdOMMgh2iUHjm3+Ix7aVHgrEKWS0wERRfb3f6vhpvSp3mAYN/viANf7ObkHzMKWG9SSEl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:35:25.0819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 724d6dad-e5b2-479f-ba6c-08ded74350e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:bobbyeshleman@meta.com,m:cjubran@nvidia.com,m:cratiu@nvidia.com,m:daniel@iogearbox.net,m:danielj@nvidia.com,m:daniel.zahka@gmail.com,m:dw@davidwei.uk,m:donald.hunter@gmail.com,m:dtatulea@nvidia.com,m:jiri@nvidia.com,m:jiri@resnulli.us,m:joe@dama.to,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:saeedm@nvidia.com,m:shshitrit@nvidia.com,m:shayd@nvidia.com,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:sdf@fomichev.me,m:tariqt@nvidia.com,m:willemb@google.com,m:gal@nvidia.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:donaldhunter@gmail.co
 m,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22621-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,meta.com,iogearbox.net,gmail.com,davidwei.uk,resnulli.us,dama.to,lwn.net,kernel.org,vger.kernel.org,marvell.com,linuxfoundation.org,fomichev.me,google.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD0C36EAB85

From: Cosmin Ratiu <cratiu@nvidia.com>

In commit [1] the concept of the root node in the qos hierarchy was
removed due to a bug with how tx_share worked. The side effect is that
in many places, there are now corner cases related to parent handling.
However, since that change, support for tc_bw was added and now, with
upcoming cross-esw support, the code is about to become even more
complicated, increasing the number of such corner cases.

Bring back the concept of the root node, to which all esw vports and
nodes are connected to. This benefits multiple operations which can
assume there's always a valid parent and don't have to do ternary
gymnastics to determine the correct esw to talk to.

As side effect, there's no longer a need to store the groups in the
qos domain, since normalization can simply iterate over all children of
the root node. Normalization gets simplified as a result.

There should be no functionality changes as a result of this change.

[1] commit 330f0f6713a3 ("net/mlx5: Remove default QoS group and attach
vports directly to root TSAR")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 206 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   3 +-
 2 files changed, 89 insertions(+), 120 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 204f47c99142..49c8ec0dac9a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -15,8 +15,6 @@
 struct mlx5_qos_domain {
 	/* Serializes access to all qos changes in the qos domain. */
 	struct mutex lock;
-	/* List of all mlx5_esw_sched_nodes. */
-	struct list_head nodes;
 };
 
 static void esw_qos_lock(struct mlx5_eswitch *esw)
@@ -43,7 +41,6 @@ static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
 		return NULL;
 
 	mutex_init(&qos_domain->lock);
-	INIT_LIST_HEAD(&qos_domain->nodes);
 
 	return qos_domain;
 }
@@ -62,6 +59,7 @@ static void esw_qos_domain_release(struct mlx5_eswitch *esw)
 }
 
 enum sched_node_type {
+	SCHED_NODE_TYPE_ROOT,
 	SCHED_NODE_TYPE_VPORTS_TSAR,
 	SCHED_NODE_TYPE_VPORT,
 	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
@@ -106,18 +104,6 @@ struct mlx5_esw_sched_node {
 	u32 tc_bw[DEVLINK_RATE_TCS_MAX];
 };
 
-static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *node)
-{
-	if (!node->parent) {
-		/* Root children are assigned a depth level of 2. */
-		node->level = 2;
-		list_add_tail(&node->entry, &node->esw->qos.domain->nodes);
-	} else {
-		node->level = node->parent->level + 1;
-		list_add_tail(&node->entry, &node->parent->children);
-	}
-}
-
 static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
 {
 	int num_tcs = mlx5_max_tc(dev) + 1;
@@ -125,14 +111,14 @@ static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
 	return num_tcs < DEVLINK_RATE_TCS_MAX ? num_tcs : DEVLINK_RATE_TCS_MAX;
 }
 
-static void
-esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_node *parent)
+static void esw_qos_node_set_parent(struct mlx5_esw_sched_node *node,
+				    struct mlx5_esw_sched_node *parent)
 {
-	list_del_init(&node->entry);
 	node->parent = parent;
-	if (parent)
-		node->esw = parent->esw;
-	esw_qos_node_attach_to_parent(node);
+	node->esw = parent->esw;
+	node->level = parent->level + 1;
+	list_del(&node->entry);
+	list_add_tail(&node->entry, &parent->children);
 }
 
 static void esw_qos_nodes_set_parent(struct list_head *nodes,
@@ -321,22 +307,19 @@ static int esw_qos_create_rate_limit_element(struct mlx5_esw_sched_node *node,
 	return esw_qos_node_create_sched_element(node, sched_ctx, extack);
 }
 
-static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
-					      struct mlx5_esw_sched_node *parent)
+static u32
+esw_qos_calculate_min_rate_divider(struct mlx5_esw_sched_node *parent)
 {
-	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
-	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
+	u32 fw_max_bw_share = MLX5_CAP_QOS(parent->esw->dev, max_tsar_bw_share);
 	struct mlx5_esw_sched_node *node;
 	u32 max_guarantee = 0;
 
 	/* Find max min_rate across all nodes.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
-	list_for_each_entry(node, nodes, entry) {
-		if (node->esw == esw && node->ix != esw->qos.root_tsar_ix &&
-		    node->min_rate > max_guarantee)
+	list_for_each_entry(node, &parent->children, entry)
+		if (node->min_rate > max_guarantee)
 			max_guarantee = node->min_rate;
-	}
 
 	if (max_guarantee)
 		return max_t(u32, max_guarantee / fw_max_bw_share, 1);
@@ -368,18 +351,13 @@ static void esw_qos_update_sched_node_bw_share(struct mlx5_esw_sched_node *node,
 	esw_qos_sched_elem_config(node, node->max_rate, bw_share, extack);
 }
 
-static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
-				       struct mlx5_esw_sched_node *parent,
+static void esw_qos_normalize_min_rate(struct mlx5_esw_sched_node *parent,
 				       struct netlink_ext_ack *extack)
 {
-	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
-	u32 divider = esw_qos_calculate_min_rate_divider(esw, parent);
+	u32 divider = esw_qos_calculate_min_rate_divider(parent);
 	struct mlx5_esw_sched_node *node;
 
-	list_for_each_entry(node, nodes, entry) {
-		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
-			continue;
-
+	list_for_each_entry(node, &parent->children, entry) {
 		/* Vports TC TSARs don't have a minimum rate configured,
 		 * so there's no need to update the bw_share on them.
 		 */
@@ -391,7 +369,7 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
 		if (list_empty(&node->children))
 			continue;
 
-		esw_qos_normalize_min_rate(node->esw, node, extack);
+		esw_qos_normalize_min_rate(node, extack);
 	}
 }
 
@@ -412,14 +390,11 @@ static u32 esw_qos_calculate_tc_bw_divider(u32 *tc_bw)
 static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 				     u32 min_rate, struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw = node->esw;
-
 	if (min_rate == node->min_rate)
 		return 0;
 
 	node->min_rate = min_rate;
-	esw_qos_normalize_min_rate(esw, node->parent, extack);
-
+	esw_qos_normalize_min_rate(node->parent, extack);
 	return 0;
 }
 
@@ -472,8 +447,7 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
 	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
-	MLX5_SET(scheduling_context, sched_ctx, parent_element_id,
-		 parent ? parent->ix : vport_node->esw->qos.root_tsar_ix);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw,
 		 vport_node->max_rate);
 
@@ -513,7 +487,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 }
 
 static struct mlx5_esw_sched_node *
-__esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
+__esw_qos_alloc_node(u32 tsar_ix, enum sched_node_type type,
 		     struct mlx5_esw_sched_node *parent)
 {
 	struct mlx5_esw_sched_node *node;
@@ -522,20 +496,12 @@ __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type
 	if (!node)
 		return NULL;
 
-	node->esw = esw;
 	node->ix = tsar_ix;
 	node->type = type;
-	node->parent = parent;
 	INIT_LIST_HEAD(&node->children);
-	esw_qos_node_attach_to_parent(node);
-	if (!parent) {
-		/* The caller is responsible for inserting the node into the
-		 * parent list if necessary. This function can also be used with
-		 * a NULL parent, which doesn't necessarily indicate that it
-		 * refers to the root scheduling element.
-		 */
-		list_del_init(&node->entry);
-	}
+	INIT_LIST_HEAD(&node->entry);
+	if (parent)
+		esw_qos_node_set_parent(node, parent);
 
 	return node;
 }
@@ -570,7 +536,7 @@ static int esw_qos_create_vports_tc_node(struct mlx5_esw_sched_node *parent,
 					  SCHEDULING_HIERARCHY_E_SWITCH))
 		return -EOPNOTSUPP;
 
-	vports_tc_node = __esw_qos_alloc_node(parent->esw, 0,
+	vports_tc_node = __esw_qos_alloc_node(0,
 					      SCHED_NODE_TYPE_VPORTS_TC_TSAR,
 					      parent);
 	if (!vports_tc_node) {
@@ -665,7 +631,6 @@ static int esw_qos_create_tc_arbiter_sched_elem(
 		struct netlink_ext_ack *extack)
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
-	u32 tsar_parent_ix;
 	void *attr;
 
 	if (!mlx5_qos_tsar_type_supported(tc_arbiter_node->esw->dev,
@@ -678,10 +643,8 @@ static int esw_qos_create_tc_arbiter_sched_elem(
 
 	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
 	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_TC_ARB);
-	tsar_parent_ix = tc_arbiter_node->parent ? tc_arbiter_node->parent->ix :
-			 tc_arbiter_node->esw->qos.root_tsar_ix;
 	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
-		 tsar_parent_ix);
+		 tc_arbiter_node->parent->ix);
 	MLX5_SET(scheduling_context, tsar_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
 	MLX5_SET(scheduling_context, tsar_ctx, max_average_bw,
@@ -694,37 +657,36 @@ static int esw_qos_create_tc_arbiter_sched_elem(
 }
 
 static struct mlx5_esw_sched_node *
-__esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
+__esw_qos_create_vports_sched_node(struct mlx5_esw_sched_node *parent,
 				   struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *node;
-	u32 tsar_ix;
 	int err;
+	u32 ix;
 
-	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, 0,
-					     0, &tsar_ix);
+	err = esw_qos_create_node_sched_elem(parent->esw->dev, parent->ix, 0, 0,
+					     &ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for node failed");
 		return ERR_PTR(err);
 	}
 
-	node = __esw_qos_alloc_node(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
+	node = __esw_qos_alloc_node(ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
 	if (!node) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc node failed");
 		err = -ENOMEM;
 		goto err_alloc_node;
 	}
 
-	list_add_tail(&node->entry, &esw->qos.domain->nodes);
-	esw_qos_normalize_min_rate(esw, NULL, extack);
-	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
+	esw_qos_normalize_min_rate(parent, extack);
+	trace_mlx5_esw_node_qos_create(parent->esw->dev, node, node->ix);
 
 	return node;
 
 err_alloc_node:
-	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
+	if (mlx5_destroy_scheduling_element_cmd(parent->esw->dev,
 						SCHEDULING_HIERARCHY_E_SWITCH,
-						tsar_ix))
+						ix))
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for node failed");
 	return ERR_PTR(err);
 }
@@ -746,7 +708,7 @@ esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct netlink_ext_ac
 	if (err)
 		return ERR_PTR(err);
 
-	node = __esw_qos_create_vports_sched_node(esw, NULL, extack);
+	node = __esw_qos_create_vports_sched_node(esw->qos.root, extack);
 	if (IS_ERR(node))
 		esw_qos_put(esw);
 
@@ -762,38 +724,47 @@ static void __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netl
 
 	trace_mlx5_esw_node_qos_destroy(esw->dev, node, node->ix);
 	esw_qos_destroy_node(node, extack);
-	esw_qos_normalize_min_rate(esw, NULL, extack);
+	esw_qos_normalize_min_rate(esw->qos.root, extack);
 }
 
 static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = esw->dev;
+	struct mlx5_esw_sched_node *root;
+	u32 root_ix;
 	int err;
 
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	err = esw_qos_create_node_sched_elem(esw->dev, 0, 0, 0,
-					     &esw->qos.root_tsar_ix);
+	err = esw_qos_create_node_sched_elem(esw->dev, 0, 0, 0, &root_ix);
 	if (err) {
 		esw_warn(dev, "E-Switch create root TSAR failed (%d)\n", err);
 		return err;
 	}
 
+	root = __esw_qos_alloc_node(root_ix, SCHED_NODE_TYPE_ROOT, NULL);
+	if (!root) {
+		esw_warn(dev, "E-Switch create root node failed\n");
+		err = -ENOMEM;
+		goto out_err;
+	}
+	root->esw = esw;
+	root->level = 1;
+	esw->qos.root = root;
 	refcount_set(&esw->qos.refcnt, 1);
 
 	return 0;
+out_err:
+	mlx5_destroy_scheduling_element_cmd(dev, SCHEDULING_HIERARCHY_E_SWITCH,
+					    root_ix);
+	return err;
 }
 
 static void esw_qos_destroy(struct mlx5_eswitch *esw)
 {
-	int err;
-
-	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
-						  SCHEDULING_HIERARCHY_E_SWITCH,
-						  esw->qos.root_tsar_ix);
-	if (err)
-		esw_warn(esw->dev, "E-Switch destroy root TSAR failed (%d)\n", err);
+	esw_qos_destroy_node(esw->qos.root, NULL);
+	esw->qos.root = NULL;
 }
 
 static int esw_qos_get(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
@@ -866,8 +837,7 @@ esw_qos_create_vport_tc_sched_node(struct mlx5_vport *vport,
 	u8 tc = vports_tc_node->tc;
 	int err;
 
-	vport_tc_node = __esw_qos_alloc_node(vport_node->esw, 0,
-					     SCHED_NODE_TYPE_VPORT_TC,
+	vport_tc_node = __esw_qos_alloc_node(0, SCHED_NODE_TYPE_VPORT_TC,
 					     vports_tc_node);
 	if (!vport_tc_node)
 		return -ENOMEM;
@@ -959,7 +929,7 @@ esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
 		/* Increase the parent's level by 2 to account for both the
 		 * TC arbiter and the vports TC scheduling element.
 		 */
-		new_level = (parent ? parent->level : 2) + 2;
+		new_level = parent->level + 2;
 		max_level = 1 << MLX5_CAP_QOS(vport_node->esw->dev,
 					      log_esw_max_sched_depth);
 		if (new_level > max_level) {
@@ -997,7 +967,7 @@ esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
 err_sched_nodes:
 	if (type == SCHED_NODE_TYPE_RATE_LIMITER) {
 		esw_qos_node_destroy_sched_element(vport_node, NULL);
-		esw_qos_node_attach_to_parent(vport_node);
+		esw_qos_node_set_parent(vport_node, vport_node->parent);
 	} else {
 		esw_qos_tc_arbiter_scheduling_teardown(vport_node, NULL);
 	}
@@ -1055,7 +1025,7 @@ static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_a
 	vport_node->bw_share = 0;
 	memset(vport_node->tc_bw, 0, sizeof(vport_node->tc_bw));
 	list_del_init(&vport_node->entry);
-	esw_qos_normalize_min_rate(vport_node->esw, vport_node->parent, extack);
+	esw_qos_normalize_min_rate(vport_node->parent, extack);
 
 	trace_mlx5_esw_vport_qos_destroy(vport_node->esw->dev, vport);
 }
@@ -1068,7 +1038,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	int err;
 
-	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+	esw_assert_qos_lock_held(vport_node->esw);
 
 	esw_qos_node_set_parent(vport_node, parent);
 	if (type == SCHED_NODE_TYPE_VPORT)
@@ -1079,7 +1049,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 		return err;
 
 	vport_node->type = type;
-	esw_qos_normalize_min_rate(vport_node->esw, parent, extack);
+	esw_qos_normalize_min_rate(parent, extack);
 	trace_mlx5_esw_vport_qos_create(vport->dev, vport, vport_node->max_rate,
 					vport_node->bw_share);
 
@@ -1092,7 +1062,6 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_sched_node *sched_node;
-	struct mlx5_eswitch *parent_esw;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
@@ -1100,14 +1069,13 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	if (err)
 		return err;
 
-	parent_esw = parent ? parent->esw : esw;
-	sched_node = __esw_qos_alloc_node(parent_esw, 0, type, parent);
+	if (!parent)
+		parent = esw->qos.root;
+	sched_node = __esw_qos_alloc_node(0, type, parent);
 	if (!sched_node) {
 		esw_qos_put(esw);
 		return -ENOMEM;
 	}
-	if (!parent)
-		list_add_tail(&sched_node->entry, &esw->qos.domain->nodes);
 
 	sched_node->max_rate = max_rate;
 	sched_node->min_rate = min_rate;
@@ -1279,10 +1247,9 @@ static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw
 	/* Set vport QoS type based on parent node type if different from
 	 * default QoS; otherwise, use the vport's current QoS type.
 	 */
-	if (parent && parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+	if (parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
 		type = SCHED_NODE_TYPE_RATE_LIMITER;
-	else if (curr_parent &&
-		 curr_parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+	else if (curr_parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
 		type = SCHED_NODE_TYPE_VPORT;
 	else
 		type = vport->qos.sched_node->type;
@@ -1311,11 +1278,9 @@ static int esw_qos_switch_tc_arbiter_node_to_vports(
 	struct mlx5_esw_sched_node *node,
 	struct netlink_ext_ack *extack)
 {
-	u32 parent_tsar_ix = node->parent ?
-			     node->parent->ix : node->esw->qos.root_tsar_ix;
 	int err;
 
-	err = esw_qos_create_node_sched_elem(node->esw->dev, parent_tsar_ix,
+	err = esw_qos_create_node_sched_elem(node->esw->dev, node->parent->ix,
 					     node->max_rate, node->bw_share,
 					     &node->ix);
 	if (err) {
@@ -1370,8 +1335,8 @@ esw_qos_move_node(struct mlx5_esw_sched_node *curr_node)
 {
 	struct mlx5_esw_sched_node *new_node;
 
-	new_node = __esw_qos_alloc_node(curr_node->esw, curr_node->ix,
-					curr_node->type, NULL);
+	new_node = __esw_qos_alloc_node(curr_node->ix, curr_node->type,
+					curr_node->parent);
 	if (!new_node)
 		return ERR_PTR(-ENOMEM);
 
@@ -1595,9 +1560,8 @@ static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport,
 						     u32 *tc_bw)
 {
 	struct mlx5_esw_sched_node *node = vport->qos.sched_node;
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-
-	esw = (node && node->parent) ? node->parent->esw : esw;
+	struct mlx5_eswitch *esw = node ?
+		node->parent->esw : vport->dev->priv.eswitch;
 
 	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
 }
@@ -1622,8 +1586,9 @@ static void esw_vport_qos_prune_empty(struct mlx5_vport *vport)
 	if (!vport_node)
 		return;
 
-	if (vport_node->parent || vport_node->max_rate ||
-	    vport_node->min_rate || !esw_qos_tc_bw_disabled(vport_node->tc_bw))
+	if (vport_node->parent != vport_node->esw->qos.root ||
+	    vport_node->max_rate || vport_node->min_rate ||
+	    !esw_qos_tc_bw_disabled(vport_node->tc_bw))
 		return;
 
 	mlx5_esw_qos_vport_disable_locked(vport);
@@ -1880,7 +1845,9 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 		err = mlx5_esw_qos_vport_enable(vport, type, parent, 0, 0,
 						extack);
 	} else if (vport->qos.sched_node) {
-		err = esw_qos_vport_update_parent(vport, parent, extack);
+		err = esw_qos_vport_update_parent(vport,
+						  parent ? : esw->qos.root,
+						  extack);
 	}
 	esw_qos_unlock(esw);
 	return err;
@@ -1928,7 +1895,7 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 {
 	u8 new_level, max_level;
 
-	if (parent && parent->esw != node->esw) {
+	if (parent->esw != node->esw) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Cannot assign node to another E-Switch");
 		return -EOPNOTSUPP;
@@ -1940,13 +1907,13 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 		return -EOPNOTSUPP;
 	}
 
-	if (parent && parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+	if (parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Cannot attach a node to a parent with TC bandwidth configured");
 		return -EOPNOTSUPP;
 	}
 
-	new_level = parent ? parent->level + 1 : 2;
+	new_level = parent->level + 1;
 	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
 		/* Increase by one to account for the vports TC scheduling
 		 * element.
@@ -1997,14 +1964,12 @@ static int esw_qos_vports_node_update_parent(struct mlx5_esw_sched_node *node,
 {
 	struct mlx5_esw_sched_node *curr_parent = node->parent;
 	struct mlx5_eswitch *esw = node->esw;
-	u32 parent_ix;
 	int err;
 
-	parent_ix = parent ? parent->ix : node->esw->qos.root_tsar_ix;
 	mlx5_destroy_scheduling_element_cmd(esw->dev,
 					    SCHEDULING_HIERARCHY_E_SWITCH,
 					    node->ix);
-	err = esw_qos_create_node_sched_elem(esw->dev, parent_ix,
+	err = esw_qos_create_node_sched_elem(esw->dev, parent->ix,
 					     node->max_rate, 0, &node->ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -2031,12 +1996,15 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
+	esw_qos_lock(esw);
+	curr_parent = node->parent;
+	if (!parent)
+		parent = esw->qos.root;
+
 	err = mlx5_esw_qos_node_validate_set_parent(node, parent, extack);
 	if (err)
-		return err;
+		goto out;
 
-	esw_qos_lock(esw);
-	curr_parent = node->parent;
 	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
 		err = esw_qos_tc_arbiter_node_update_parent(node, parent,
 							    extack);
@@ -2047,8 +2015,8 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 	if (err)
 		goto out;
 
-	esw_qos_normalize_min_rate(esw, curr_parent, extack);
-	esw_qos_normalize_min_rate(esw, parent, extack);
+	esw_qos_normalize_min_rate(curr_parent, extack);
+	esw_qos_normalize_min_rate(parent, extack);
 
 out:
 	esw_qos_unlock(esw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 140343f2b913..10c4eacd43b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -415,8 +415,9 @@ struct mlx5_eswitch {
 	struct {
 		/* Initially 0, meaning no QoS users and QoS is disabled. */
 		refcount_t refcnt;
-		u32 root_tsar_ix;
 		struct mlx5_qos_domain *domain;
+		/* The root node of the hierarchy. */
+		struct mlx5_esw_sched_node *root;
 	} qos;
 
 	struct mlx5_esw_bridge_offloads *br_offloads;
-- 
2.44.0


