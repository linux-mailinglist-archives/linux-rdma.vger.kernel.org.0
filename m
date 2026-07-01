Return-Path: <linux-rdma+bounces-22624-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZbhBKYnERGpb0goAu9opvQ
	(envelope-from <linux-rdma+bounces-22624-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:40:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 758176EAC3C
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:40:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=m1i3r72e;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22624-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22624-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B815630624CE
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 07:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0036A3C196F;
	Wed,  1 Jul 2026 07:36:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B6E3C1400;
	Wed,  1 Jul 2026 07:36:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891380; cv=fail; b=pfYrkxNsn2quz5FjuL/ifbuWZGGDz2yJ3/WVYn0BaLUGCOgC9diJvehWLocRqvHK3BSjrLB6f5P8OPgTRurdv9i3BtuIUgVbRspJaE9KQA6wGulahz8qy3VgxUySSjjcymCkRoddmQJbebGEdbHDKdufqUYr0TT1qt9pLoEjRdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891380; c=relaxed/simple;
	bh=NOFOEDjnrrv+RlKLNLXCpfY9L78P2u6TA+03+WRY1PU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijsu6pLhoguQzmt5lD74Ub5l9QVUOyaqF5sHwUZa3IG/+VEXWamIXguSFjtSxbZDorSR0RK1Wn4Sb6M4q+2c6q8AorEl5kU9Uk17nRrPA5JL5CKf4Wen1bqy9KJysmsOcWfQKkEf3gm/ziOMfbk95kqndPJ4fijedc4g78gBehM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m1i3r72e; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBZmtAwEdQvsb+jyqFDZCz5wt8cMOf/KFzLLIz+Jh0LydAxk8SrJEDcI2u2oRjqLR50qC9UvfsNxAkF6ZCtpxkyp0U3wcsg79b4bAvGuSWNJyGqtBxZwjMKHSGEyFAgpNIoNrqsElZ8gaNZe4q3GarNk50n2sPRLcR69BqLmKfjMj+MHibvUzlRiGsXvus+VYWJEeI9agDqRLYSzrdiXY8sl0T1qU7945Dp0TdAmkFn26lWgfvvfowpgPc92azvG+m6jlKxKTiSz/Qo4lyBoDyB3+sHzPN3TYRinNq4H7kP46NAilTue9Ttw3TMbGFnW3NZb7fSmhMRTp+QxjQEYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FX0nF7IBVtQB/aJLNh9XN2HqHt34OLEuNQvqpwAB4xQ=;
 b=JvSR2I+1vPIEY7PXSMINDBsXUQPJO+/LL0pyNW5Eg7WV9qSVwUpIe+2T8ZPjSOPz5AmFeX5R47/NGKlhIiDyQhPPVTYBuCtHUPeIyqAmhX3gaWZ4LZL0LIl3DezXuoPDXjvmYn1MisUEnxwHHZA+o2jbgTlFfl1naBsNR1rI5JzTiue0rfTGovp2gMf6KFbny7rcs6Q933901doJpq7ruZ4+40AU6hKSVZcF4GxpblMH8HqJyLch3oHnTh9rJsE66BK9GZIEi9qZDHduI9AnuYcAmg7140jB1extfMtJxvXcyNENwRhtPPjweDLlvv1WhCmqAh+L4Zs4WlgC5+gHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX0nF7IBVtQB/aJLNh9XN2HqHt34OLEuNQvqpwAB4xQ=;
 b=m1i3r72evMhmubne9v3bICZQp1+ua+6+5FslDc8bXBnHdD5zXJgqJ/+uWRoijwx43hcVvWVyd0qCG32KsPI/pJQsJmIi+eLwnlN675hTd8y+oBsk4wmon6xzI7z2yQ87WTql+rQinp6tl+RtbYgD0M8R5EpoaLvDrDfjYOxXG3/YkQgyW+/0oQjTcrw7kSVKPwISBbo4yv+gl5pVkSkbZuWh6kFCgH6ESuD5O4ooc2+wEEVwcxsct4337j1h9IZHI8vlV88Ae6ya1lhtSSs4oUsp+no4bJ4SXaUhhaqiIpMkxDZOHFuSJwDvKybS+o+x2SDi3iesTxqHKdXZeZAAdg==
Received: from BL1PR13CA0341.namprd13.prod.outlook.com (2603:10b6:208:2c6::16)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:36:07 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::a6) by BL1PR13CA0341.outlook.office365.com
 (2603:10b6:208:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 07:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 07:36:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:35:16 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:35:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 00:35:05 -0700
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
Subject: [PATCH net-next V10 11/14] net/mlx5: qos: Remove qos domains and use shd
Date: Wed, 1 Jul 2026 10:32:51 +0300
Message-ID: <20260701073254.754518-12-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 45206b27-09e2-4a77-e998-08ded74369e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|22082099003|18002099003|5023799004|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	IA0h0R7/YLP3HZUgzVblCt8seOJmwi52Sj+GeH/jTUm1tUCMHYejWNpgQo7rZ8xeEFtz7bRhc4CI2y5un0K4Apd4sqKlDQdHQ9do7doPRsYgFDtjgY7o+Zg/jii6S7xRAwj0t+RJ3vBcP9j4gj+2HLk96H9w/ptGONOwzq/53VaBBxWvRlm1g2FS/ZDLLrvJK2ze3LG5lNygyocmxS3EhRhwFUF/TaKIOzaVOqTfBreXBnAcoZ180oKr4mJ3D30OByFmWE8mE74Iv5l/4OMHL2opi1FRpzP3AvyEVtpeIeOfQ7JiFqG6WsyW1JWWseNDQCnkKTELPCbXI8TohOuLi2NJOsqA/Qa7OHYa0NYl+mgjchpN4GyM3sZT9SA1nylN6sjQ+ke9inLKxU9P6nAgRG8MNIMDoZsL/QYV9uW/Ac72OrZC0linm6SPegT6ao3568Ye75LdCGrv3CPLoZOHJc6fGRW2Hknx8fsa/ljGtZAJEJYe9/3TZ/SXSfhck+3vnnPmYUjmolHnurm9XRcre0GytAusc5zwiAvAKnSy9hGIcDDAIbdpChRhPg351AIwzIq7Mnj6aypDHORFGPYckyfcO4gnbTAjSnvzMo87y1x+xvFBPgJ52KiKDkfpzCe37j7levJQs+jWVrk4nPWMckxbnzrq1ksvqzDmOIETh9k58gHvU/GP7RuIV8DInVCzxCNmipE21+QEJF6OBMR5Iw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bdADGuCn0QpRHVJ27yHLh3llRtTRzMi86Htd0VyWClDUuT4Fm/Xq1CtpJtrRqKXNPe81VmraEhVu9ZMKRUNr9D6KL5CTFKpj4tlEUPaHiM/LYeS9kK3Ae+XnAsSLehChLvnnkrwz/qzaKmw0K0YF3MlpvFpdC3XYWC2JjQ/P/pd11kqFXRYhKcDf245ctAj2RSEDsU1zeJayEDvBjWESGfkYtUVxQadOv8PCO3Slgs9VAeVbFc7VW7UwMWSxiYiHV5UXJwdib9NvMbV9h3j4XqAEBgqO7Z9Fo0mC/S0aPxJ1m8f/WrsXCIQFCE2VF8ZkaSxRlFty0De4r2/OMDi3RWSrjnPbCoGGHXTgHquop8sdc/rkGKTho5+RYBqt5UNX4ilccfzMXupQ8S3ouPL/mjPlSF5ZfGfu17ZPfsEtOzorTqTZHPYxRP4+YAEPLIub
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:36:06.8996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45206b27-09e2-4a77-e998-08ded74369e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
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
	TAGGED_FROM(0.00)[bounces-22624-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 758176EAC3C

From: Cosmin Ratiu <cratiu@nvidia.com>

E-Switch QoS domains were added with the intention of eventually
implementing shared qos domains to support cross-esw scheduling in the
previous approach ([1]), but they are no longer necessary in the new
approach.

Remove QoS domains and switch to using the shd lock for protecting
against concurrent QoS modifications.
Enable the supported_cross_device_rate_nodes devlink ops attribute so
that all calls originating from devlink rate acquire the shd lock. Only
the additional entry points into QoS need to acquire the shd lock.

The wrinkle is that since shd can be NULL (e.g. on older HW without
serial number available), there needs to be a fallback locking
mechanism. The devlink instance lock cannot be used, as some code paths
into QoS (get, set & modify vport rate) happen with RTNL held, and the
existing devlink -> RTNL order prevents devlink lock usage there.

The other two options are either esw->state_lock or a new lock as
fallback when shd is NULL. This patch adds esw->state_lock, which
implies:

- 3 new lock/unlock helper pairs to acquire/release the missing lock:
  - esw_qos_{,un}lock: acquire/release esw->state_lock when shd is NULL.
  - esw_qos_shd_{,un}lock: when esw->state_lock is already held.
  - esw_qos_devlink_{,un}lock: when shd is already held.
- esw_assert_qos_lock_held now asserts esw->state_lock is held when shd
  is NULL.

Use the corresponding lock/unlock function in all places where either
shd or state_lock would need to be acquired.

Document all of this trickery next to esw_assert_qos_lock_held.

Enabling supported_cross_device_rate_nodes now is safe, because
mlx5_esw_qos_vport_update_parent rejects cross-esw parent updates.
This will change in the next patch.

[1]
https://lore.kernel.org/netdev/20250213180134.323929-1-tariqt@nvidia.com/

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 245 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   8 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  13 +-
 5 files changed, 120 insertions(+), 150 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index c31e05529fc4..b9026cc64383 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -383,6 +383,7 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.rate_node_del = mlx5_esw_devlink_rate_node_del,
 	.rate_leaf_parent_set = mlx5_esw_devlink_rate_leaf_parent_set,
 	.rate_node_parent_set = mlx5_esw_devlink_rate_node_parent_set,
+	.supported_cross_device_rate_nodes = true,
 #endif
 #ifdef CONFIG_MLX5_SF_MANAGER
 	.port_new = mlx5_devlink_sf_port_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 49c8ec0dac9a..80a28596349b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -11,53 +11,6 @@
 /* Minimum supported BW share value by the HW is 1 Mbit/sec */
 #define MLX5_MIN_BW_SHARE 1
 
-/* Holds rate nodes associated with an E-Switch. */
-struct mlx5_qos_domain {
-	/* Serializes access to all qos changes in the qos domain. */
-	struct mutex lock;
-};
-
-static void esw_qos_lock(struct mlx5_eswitch *esw)
-{
-	mutex_lock(&esw->qos.domain->lock);
-}
-
-static void esw_qos_unlock(struct mlx5_eswitch *esw)
-{
-	mutex_unlock(&esw->qos.domain->lock);
-}
-
-static void esw_assert_qos_lock_held(struct mlx5_eswitch *esw)
-{
-	lockdep_assert_held(&esw->qos.domain->lock);
-}
-
-static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
-{
-	struct mlx5_qos_domain *qos_domain;
-
-	qos_domain = kzalloc_obj(*qos_domain);
-	if (!qos_domain)
-		return NULL;
-
-	mutex_init(&qos_domain->lock);
-
-	return qos_domain;
-}
-
-static int esw_qos_domain_init(struct mlx5_eswitch *esw)
-{
-	esw->qos.domain = esw_qos_domain_alloc();
-
-	return esw->qos.domain ? 0 : -ENOMEM;
-}
-
-static void esw_qos_domain_release(struct mlx5_eswitch *esw)
-{
-	kfree(esw->qos.domain);
-	esw->qos.domain = NULL;
-}
-
 enum sched_node_type {
 	SCHED_NODE_TYPE_ROOT,
 	SCHED_NODE_TYPE_VPORTS_TSAR,
@@ -104,6 +57,65 @@ struct mlx5_esw_sched_node {
 	u32 tc_bw[DEVLINK_RATE_TCS_MAX];
 };
 
+/* Locking notes:
+ * QoS changes are normally protected by the shd lock. But on older HW shd
+ * might not be created at all, so there needs to be a fallback serialization
+ * mechanism. This is esw->state_lock.
+ * Callers into QoS hold a combination of RTNL, devlink instance lock and
+ * esw->state_lock. Devlink rate ops additionally hold the shd lock if it
+ * exists.
+ * - VF rate ops use esw_qos_lock/esw_qos_unlock.
+ * - callers with esw->state_lock held use esw_qos_shd_lock/esw_qos_shd_unlock.
+ * - devlink callers use esw_qos_devlink_lock/esw_qos_devlink_unlock.
+ */
+static void esw_assert_qos_lock_held(struct mlx5_core_dev *dev)
+{
+	if (dev->shd)
+		devl_assert_locked(dev->shd);
+	else
+		lockdep_assert_held(&dev->priv.eswitch->state_lock);
+}
+
+static void esw_qos_lock(struct mlx5_core_dev *dev)
+{
+	if (dev->shd)
+		devl_lock(dev->shd);
+	else
+		mutex_lock(&dev->priv.eswitch->state_lock);
+}
+
+static void esw_qos_unlock(struct mlx5_core_dev *dev)
+{
+	if (dev->shd)
+		devl_unlock(dev->shd);
+	else
+		mutex_unlock(&dev->priv.eswitch->state_lock);
+}
+
+static void esw_qos_shd_lock(struct mlx5_core_dev *dev)
+{
+	if (dev->shd)
+		devl_lock(dev->shd);
+}
+
+static void esw_qos_shd_unlock(struct mlx5_core_dev *dev)
+{
+	if (dev->shd)
+		devl_unlock(dev->shd);
+}
+
+static void esw_qos_devlink_lock(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		mutex_lock(&dev->priv.eswitch->state_lock);
+}
+
+static void esw_qos_devlink_unlock(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		mutex_unlock(&dev->priv.eswitch->state_lock);
+}
+
 static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
 {
 	int num_tcs = mlx5_max_tc(dev) + 1;
@@ -700,7 +712,7 @@ esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct netlink_ext_ac
 	struct mlx5_esw_sched_node *node;
 	int err;
 
-	esw_assert_qos_lock_held(esw);
+	esw_assert_qos_lock_held(esw->dev);
 	if (!MLX5_CAP_QOS(esw->dev, log_esw_max_sched_depth))
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -771,7 +783,7 @@ static int esw_qos_get(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
 	int err = 0;
 
-	esw_assert_qos_lock_held(esw);
+	esw_assert_qos_lock_held(esw->dev);
 	if (!refcount_inc_not_zero(&esw->qos.refcnt)) {
 		/* esw_qos_create() set refcount to 1 only on success.
 		 * No need to decrement on failure.
@@ -784,7 +796,7 @@ static int esw_qos_get(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 
 static void esw_qos_put(struct mlx5_eswitch *esw)
 {
-	esw_assert_qos_lock_held(esw);
+	esw_assert_qos_lock_held(esw->dev);
 	if (refcount_dec_and_test(&esw->qos.refcnt))
 		esw_qos_destroy(esw);
 }
@@ -940,7 +952,7 @@ esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
 		}
 	}
 
-	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+	esw_assert_qos_lock_held(vport->dev);
 
 	if (type == SCHED_NODE_TYPE_RATE_LIMITER)
 		err = esw_qos_create_rate_limit_element(vport_node, extack);
@@ -1038,7 +1050,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	int err;
 
-	esw_assert_qos_lock_held(vport_node->esw);
+	esw_assert_qos_lock_held(vport->dev);
 
 	esw_qos_node_set_parent(vport_node, parent);
 	if (type == SCHED_NODE_TYPE_VPORT)
@@ -1064,7 +1076,7 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	struct mlx5_esw_sched_node *sched_node;
 	int err;
 
-	esw_assert_qos_lock_held(esw);
+	esw_assert_qos_lock_held(vport->dev);
 	err = esw_qos_get(esw, extack);
 	if (err)
 		return err;
@@ -1093,15 +1105,13 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 
 static void mlx5_esw_qos_vport_disable_locked(struct mlx5_vport *vport)
 {
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-
-	esw_assert_qos_lock_held(esw);
+	esw_assert_qos_lock_held(vport->dev);
 	if (!vport->qos.sched_node)
 		return;
 
 	esw_qos_vport_disable(vport, NULL);
 	mlx5_esw_qos_vport_qos_free(vport);
-	esw_qos_put(esw);
+	esw_qos_put(vport->dev->priv.eswitch);
 }
 
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
@@ -1109,9 +1119,9 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 
 	lockdep_assert_held(&esw->state_lock);
-	esw_qos_lock(esw);
+	esw_qos_shd_lock(vport->dev);
 	mlx5_esw_qos_vport_disable_locked(vport);
-	esw_qos_unlock(esw);
+	esw_qos_shd_unlock(vport->dev);
 }
 
 static int mlx5_esw_qos_set_vport_max_rate(struct mlx5_vport *vport, u32 max_rate,
@@ -1119,7 +1129,7 @@ static int mlx5_esw_qos_set_vport_max_rate(struct mlx5_vport *vport, u32 max_rat
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 
-	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+	esw_assert_qos_lock_held(vport->dev);
 
 	if (!vport_node)
 		return mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, NULL, max_rate, 0,
@@ -1134,7 +1144,7 @@ static int mlx5_esw_qos_set_vport_min_rate(struct mlx5_vport *vport, u32 min_rat
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 
-	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+	esw_assert_qos_lock_held(vport->dev);
 
 	if (!vport_node)
 		return mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, NULL, 0, min_rate,
@@ -1147,29 +1157,27 @@ static int mlx5_esw_qos_set_vport_min_rate(struct mlx5_vport *vport, u32 min_rat
 
 int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *vport, u32 max_rate, u32 min_rate)
 {
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err;
 
-	esw_qos_lock(esw);
+	esw_qos_lock(vport->dev);
 	err = mlx5_esw_qos_set_vport_min_rate(vport, min_rate, NULL);
 	if (!err)
 		err = mlx5_esw_qos_set_vport_max_rate(vport, max_rate, NULL);
-	esw_qos_unlock(esw);
+	esw_qos_unlock(vport->dev);
 	return err;
 }
 
 bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *min_rate)
 {
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	bool enabled;
 
-	esw_qos_lock(esw);
+	esw_qos_shd_lock(vport->dev);
 	enabled = !!vport->qos.sched_node;
 	if (enabled) {
 		*max_rate = vport->qos.sched_node->max_rate;
 		*min_rate = vport->qos.sched_node->min_rate;
 	}
-	esw_qos_unlock(esw);
+	esw_qos_shd_unlock(vport->dev);
 	return enabled;
 }
 
@@ -1205,7 +1213,7 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	u32 curr_tc_bw[DEVLINK_RATE_TCS_MAX] = {0};
 	int err;
 
-	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+	esw_assert_qos_lock_held(vport->dev);
 	if (curr_type == type && curr_parent == parent)
 		return 0;
 
@@ -1235,11 +1243,10 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
 				       struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_sched_node *curr_parent;
 	enum sched_node_type type;
 
-	esw_assert_qos_lock_held(esw);
+	esw_assert_qos_lock_held(vport->dev);
 	curr_parent = vport->qos.sched_node->parent;
 	if (curr_parent == parent)
 		return 0;
@@ -1503,9 +1510,9 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 			return err;
 	}
 
-	esw_qos_lock(esw);
+	esw_qos_lock(vport->dev);
 	err = mlx5_esw_qos_set_vport_max_rate(vport, rate_mbps, NULL);
-	esw_qos_unlock(esw);
+	esw_qos_unlock(vport->dev);
 
 	return err;
 }
@@ -1582,7 +1589,7 @@ static void esw_vport_qos_prune_empty(struct mlx5_vport *vport)
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 
-	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+	esw_assert_qos_lock_held(vport->dev);
 	if (!vport_node)
 		return;
 
@@ -1594,44 +1601,26 @@ static void esw_vport_qos_prune_empty(struct mlx5_vport *vport)
 	mlx5_esw_qos_vport_disable_locked(vport);
 }
 
-int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
-{
-	if (esw->qos.domain)
-		return 0;  /* Nothing to change. */
-
-	return esw_qos_domain_init(esw);
-}
-
-void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw)
-{
-	if (esw->qos.domain)
-		esw_qos_domain_release(esw);
-}
-
 /* Eswitch devlink rate API */
 
 int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport = priv;
-	struct mlx5_eswitch *esw;
 	int err;
 
-	esw = vport->dev->priv.eswitch;
-	if (!mlx5_esw_allowed(esw))
+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
 		return -EPERM;
 
 	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_share", &tx_share, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
+	esw_qos_devlink_lock(vport->dev);
 	err = mlx5_esw_qos_set_vport_min_rate(vport, tx_share, extack);
-	if (err)
-		goto out;
-	esw_vport_qos_prune_empty(vport);
-out:
-	esw_qos_unlock(esw);
+	if (!err)
+		esw_vport_qos_prune_empty(vport);
+	esw_qos_devlink_unlock(vport->dev);
 	return err;
 }
 
@@ -1639,24 +1628,20 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 					  u64 tx_max, struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport = priv;
-	struct mlx5_eswitch *esw;
 	int err;
 
-	esw = vport->dev->priv.eswitch;
-	if (!mlx5_esw_allowed(esw))
+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
 		return -EPERM;
 
 	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_max", &tx_max, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
+	esw_qos_devlink_lock(vport->dev);
 	err = mlx5_esw_qos_set_vport_max_rate(vport, tx_max, extack);
-	if (err)
-		goto out;
-	esw_vport_qos_prune_empty(vport);
-out:
-	esw_qos_unlock(esw);
+	if (!err)
+		esw_vport_qos_prune_empty(vport);
+	esw_qos_devlink_unlock(vport->dev);
 	return err;
 }
 
@@ -1667,16 +1652,14 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 {
 	struct mlx5_esw_sched_node *vport_node;
 	struct mlx5_vport *vport = priv;
-	struct mlx5_eswitch *esw;
 	bool disable;
 	int err = 0;
 
-	esw = vport->dev->priv.eswitch;
-	if (!mlx5_esw_allowed(esw))
+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
 		return -EPERM;
 
 	disable = esw_qos_tc_bw_disabled(tc_bw);
-	esw_qos_lock(esw);
+	esw_qos_devlink_lock(vport->dev);
 
 	if (!esw_qos_vport_validate_unsupported_tc_bw(vport, tc_bw)) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -1710,7 +1693,7 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 	if (!err)
 		esw_qos_set_tc_arbiter_bw_shares(vport_node, tc_bw, extack);
 unlock:
-	esw_qos_unlock(esw);
+	esw_qos_devlink_unlock(vport->dev);
 	return err;
 }
 
@@ -1720,18 +1703,17 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
 					 struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *node = priv;
-	struct mlx5_eswitch *esw = node->esw;
 	bool disable;
 	int err;
 
-	if (!esw_qos_validate_unsupported_tc_bw(esw, tc_bw)) {
+	if (!esw_qos_validate_unsupported_tc_bw(node->esw, tc_bw)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "E-Switch traffic classes number is not supported");
 		return -EOPNOTSUPP;
 	}
 
 	disable = esw_qos_tc_bw_disabled(tc_bw);
-	esw_qos_lock(esw);
+	esw_qos_devlink_lock(node->esw->dev);
 	if (disable) {
 		err = esw_qos_node_disable_tc_arbitration(node, extack);
 		goto unlock;
@@ -1741,7 +1723,7 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
 	if (!err)
 		esw_qos_set_tc_arbiter_bw_shares(node, tc_bw, extack);
 unlock:
-	esw_qos_unlock(esw);
+	esw_qos_devlink_unlock(node->esw->dev);
 	return err;
 }
 
@@ -1756,9 +1738,9 @@ int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
+	esw_qos_devlink_lock(esw->dev);
 	err = esw_qos_set_node_min_rate(node, tx_share, extack);
-	esw_qos_unlock(esw);
+	esw_qos_devlink_unlock(esw->dev);
 	return err;
 }
 
@@ -1773,9 +1755,9 @@ int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
+	esw_qos_devlink_lock(esw->dev);
 	err = esw_qos_sched_elem_config(node, tx_max, node->bw_share, extack);
-	esw_qos_unlock(esw);
+	esw_qos_devlink_unlock(esw->dev);
 	return err;
 }
 
@@ -1790,7 +1772,7 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 	if (IS_ERR(esw))
 		return PTR_ERR(esw);
 
-	esw_qos_lock(esw);
+	esw_qos_devlink_lock(esw->dev);
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Rate node creation supported only in switchdev mode");
@@ -1803,10 +1785,9 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 		err = PTR_ERR(node);
 		goto unlock;
 	}
-
 	*priv = node;
 unlock:
-	esw_qos_unlock(esw);
+	esw_qos_devlink_unlock(esw->dev);
 	return err;
 }
 
@@ -1816,10 +1797,11 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	struct mlx5_esw_sched_node *node = priv;
 	struct mlx5_eswitch *esw = node->esw;
 
-	esw_qos_lock(esw);
+	esw_qos_devlink_lock(esw->dev);
 	__esw_qos_destroy_node(node, extack);
 	esw_qos_put(esw);
-	esw_qos_unlock(esw);
+	esw_qos_devlink_unlock(esw->dev);
+
 	return 0;
 }
 
@@ -1836,7 +1818,6 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 		return -EOPNOTSUPP;
 	}
 
-	esw_qos_lock(esw);
 	if (!vport->qos.sched_node && parent) {
 		enum sched_node_type type;
 
@@ -1849,7 +1830,7 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 						  parent ? : esw->qos.root,
 						  extack);
 	}
-	esw_qos_unlock(esw);
+
 	return err;
 }
 
@@ -1862,14 +1843,11 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 	struct mlx5_vport *vport = priv;
 	int err;
 
+	esw_qos_devlink_lock(vport->dev);
 	err = mlx5_esw_qos_vport_update_parent(vport, node, extack);
-	if (!err) {
-		struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-
-		esw_qos_lock(esw);
+	if (!err)
 		esw_vport_qos_prune_empty(vport);
-		esw_qos_unlock(esw);
-	}
+	esw_qos_devlink_unlock(vport->dev);
 
 	return err;
 }
@@ -1996,7 +1974,7 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
-	esw_qos_lock(esw);
+	esw_qos_devlink_lock(esw->dev);
 	curr_parent = node->parent;
 	if (!parent)
 		parent = esw->qos.root;
@@ -2019,8 +1997,7 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 	esw_qos_normalize_min_rate(parent, extack);
 
 out:
-	esw_qos_unlock(esw);
-
+	esw_qos_devlink_unlock(esw->dev);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 0a50982b0e27..f275e850d2c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -6,9 +6,6 @@
 
 #ifdef CONFIG_MLX5_ESWITCH
 
-int mlx5_esw_qos_init(struct mlx5_eswitch *esw);
-void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw);
-
 int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *evport, u32 max_rate, u32 min_rate);
 bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *min_rate);
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index b67f15a8f766..b6e2c153b4f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1885,10 +1885,6 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 	MLX5_NB_INIT(&esw->nb, eswitch_vport_event, NIC_VPORT_CHANGE);
 	mlx5_eq_notifier_register(esw->dev, &esw->nb);
 
-	err = mlx5_esw_qos_init(esw);
-	if (err)
-		goto err_esw_init;
-
 	if (esw->mode == MLX5_ESWITCH_LEGACY) {
 		err = esw_legacy_enable(esw);
 	} else {
@@ -2555,9 +2551,6 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		goto reps_err;
 
 	esw->mode = MLX5_ESWITCH_LEGACY;
-	err = mlx5_esw_qos_init(esw);
-	if (err)
-		goto reps_err;
 
 	mutex_init(&esw->offloads.encap_tbl_lock);
 	hash_init(esw->offloads.encap_tbl);
@@ -2612,7 +2605,6 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 
 	mlx5_eswitch_invalidate_wq(esw);
 	destroy_workqueue(esw->work_queue);
-	mlx5_esw_qos_cleanup(esw);
 	WARN_ON(refcount_read(&esw->qos.refcnt));
 	mutex_destroy(&esw->state_lock);
 	WARN_ON(!xa_empty(&esw->offloads.vhca_map));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 10c4eacd43b4..c655f6e8da1c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -234,8 +234,10 @@ struct mlx5_vport {
 
 	struct mlx5_vport_info  info;
 
-	/* Protected with the E-Switch qos domain lock. The Vport QoS can
-	 * either be disabled (sched_node is NULL) or in one of three states:
+	/* Protected by either the shared devlink (dev->shd) lock or by
+	 * esw->state_lock. See esw_assert_qos_lock_held() for more details.
+	 * The Vport QoS can either be disabled (sched_node is NULL) or in one
+	 * of three states:
 	 * 1. Regular QoS (sched_node is a vport node).
 	 * 2. TC QoS enabled on the vport (sched_node is a TC arbiter).
 	 * 3. TC QoS enabled on the vport's parent node
@@ -382,7 +384,6 @@ enum {
 };
 
 struct dentry;
-struct mlx5_qos_domain;
 
 struct mlx5_eswitch {
 	struct mlx5_core_dev    *dev;
@@ -411,11 +412,13 @@ struct mlx5_eswitch {
 	atomic64_t user_count;
 	wait_queue_head_t work_queue_wait;
 
-	/* Protected with the E-Switch qos domain lock. */
+	/* QoS changes are serialized by either the shared devlink (dev->shd)
+	 * lock or by esw->state_lock. See esw_assert_qos_lock_held() for more
+	 * details.
+	 */
 	struct {
 		/* Initially 0, meaning no QoS users and QoS is disabled. */
 		refcount_t refcnt;
-		struct mlx5_qos_domain *domain;
 		/* The root node of the hierarchy. */
 		struct mlx5_esw_sched_node *root;
 	} qos;
-- 
2.44.0


