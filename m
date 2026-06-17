Return-Path: <linux-rdma+bounces-22301-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t1dPIf4/Mmr7xQUAu9opvQ
	(envelope-from <linux-rdma+bounces-22301-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 08:34:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2994B696DFC
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 08:34:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="n/8rl3Gg";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22301-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22301-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08DDF308E05B
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 06:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35B3AFD01;
	Wed, 17 Jun 2026 06:32:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591A93612FB;
	Wed, 17 Jun 2026 06:32:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781677976; cv=fail; b=TIf2/7VGvOsW0qiNQLIEq4JMz/5oZftTkek8J7MI1Q0xGwN43+QuRmYSGX9B0hS2FppAtECBZ0BJHSFangp/QOkqLdKHtFkeo3kWNxpYkTl7xRmeXeuEf3bZnHZ1Z12LwFddagOqAiOsZ8uO7gz3lEcz+oKH4ytQr5/0iv0DZ6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781677976; c=relaxed/simple;
	bh=g1d8CPuCg6M9C1vappZBmjcNWbFGaWU2+UFqE4CYmsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJMWYy1KZqAq1NUu56WD4BmJIbz+8mujzBFUFBt54k7At/c2MgMEyoZd6xKpJGfVv3BhVNBK8lLf6NYOLptRk9fo5J0T+5koiDe0KTnQ1Ej3aa4Hz3zVy99YP7XWhZtRX5ipgG6pOMkgg9qMX7N08XcB10aWVf+Gr49m+eIMNDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n/8rl3Gg; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0A4lI4Blsc5/zkYlXnZO/9YVnwK3BBFr+IakYWjswUW0H/jKwbaqkvbqCo4Bm8DFDSp+1wf93YhjUPwKQEO6SU3RArcgqPEOgvRXhiSk85HNvs4VpBUrjteoO33odu4g0OokYL9Mu7u4mD6Y1lIXon5uGZPO3DLmE3vIZ6iNmif/Wv3hVZUd1isllMJYkkLzKkryl0duQat36tQsJ+SDPM+4U/VCJT5gwfau/z4+eWWF5ukrI5MniBX7u4nXjuLnV3C7BIDLoXVzSZg2YhWW7mbL9ETd0FgBNRCGDdZYofp7XE3rj5cMbNQSA8UaQK7GB4LxddM+ElF9uy7RTWRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amgFCk9FVw4xfZjefvi/KYq52y0FUEAGLLab+dFaVsU=;
 b=dvmg8UVIgQah5nxMcNcgmdBQY0lFFB3quJlO6QIq+Zoy9PtO6OQUV7+9F+6GlajIgym6xX0SbOOTWvUksbwESpEUQZv5God9FW5ULdn0VPYvUQnhimPmHLGghx8F9CkLSrX9uYRHevAMpyWjBLis98eP790bTdXdiEwg7x8j4xSboyfKM0ij7mhbQ/YFMNqLO+cxi0rnMic5MOKuoQkuP1Z/yyMmVup+7DhG6dYyuAvorS1W4/Y7Tx00QhqnC6AKKMA7GJSvcAEuNf8kjs+uWFJJqS6+1OrlJVOajmdpLt/adpgGyKYuHVicRbpIBT2R4XecvVK0p4+EPSkGuiDQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amgFCk9FVw4xfZjefvi/KYq52y0FUEAGLLab+dFaVsU=;
 b=n/8rl3Gg4uj5wfzo0ctirrLfy8H9A2WrMQ3FevzJv4ZpFRKfJyRJxazkS0SwDdao9y9IAmvfnM3fTz9zSQw0oLoUfr1cuvBDj92sJSDVaNJBJLhst3C2k8wKzERZ/Vp+bZ8sCURcGMbISJnnTNyyuvq3E0fbZ9/slGi8QMWOyMVs4rFvHcuT3+l1/n9QP42DWcGMb1Q2b++R0UNesc9xcV1Tbtrkgb2yYvJ7j2Wj+Ard+JZ7ZZRFbSgWBTgIZFp+VRni17iqQmK6sJqTqlcKnSKoe91LOmorUqUHxhUS4k5eRTqx0htToCtCRBZO3VJm04peDkXCuqjg9usHX81Ikg==
Received: from SJ0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:a03:2c2::9)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 06:32:50 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::9b) by SJ0PR13CA0034.outlook.office365.com
 (2603:10b6:a03:2c2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 06:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 06:32:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 23:32:40 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 23:32:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 16
 Jun 2026 23:32:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Rongwei Liu
	<rongweil@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5e: TC, skip peer flow cleanup when LAG seq is unavailable
Date: Wed, 17 Jun 2026 09:32:04 +0300
Message-ID: <20260617063204.547427-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260617063204.547427-1-tariqt@nvidia.com>
References: <20260617063204.547427-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 430a1900-6024-4b9c-aa5d-08decc3a410b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|7416014|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	CzPITqmIGE6+gLwqDiYsl+TMQbIy2kMkZYyO3JsyNLkuY+Cb1fBo/gpv/odzqgtEU37AFN1FI22vYmu6ZSZm1PzwONU3OLTo+j2KGIqG5tu8IzTFlQU3bPVtwlHXNxXC3YLq+8hS0wDlI2d0ufJMm7DdPHDrkHwYxXotZnAtu+Wo4KBSj8a6IQlwnC+/9qmJBSjfJxFUtMXSL1l42lWtsddOuJeispt2XFVQiYXWAbU1F8X22gIHn6RBB7F8hPs+1gQETZrwML+RUCNqBds+sYgLOFLKGRbtuHoxVgJFnj2J8VW+pHJlrkFfKh3CUvhEPpFN9axQDQ/8XLDvsp+oOLAK1Ov1UWoCq2pj0VjB5Egw7TA1LIzCKRchV9Pr6+bnKAPvi8AvEZ2aYPYztFQK7gskwfy7T4InqcpRfzwyNihmPhwJDLKYA7jW89V8g+M0u4GmHIvmZVGCNvAnrefu313W/fGvJLpFgxOVOU0PTZ8XHOWXH9kH+RXiEI1B6xfkuZvr1xc8PGHonuIa2FaWlgW5l2qsypl1j2iCd7zj9pX5H+zZ2xc8puQ3mr8ghlhaNeJdX/lSx3cMJrEcS20U+n8LeZC6BEHjHY14hM+8DLSREqSxmf/bn3OtOyzCr58CnxlkDP16FSSLE5UmW51GINo+ydEdqOPI7HSp3bCPEcLKRhVlY1eKvLE9LoaZqdXSCuBo7Ktri2T6F91m57AaGDbNtn9yDENJKH6PJ939kI4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(7416014)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ysV7aI4tOOrWjYlP90h1UfcI4EepFTFn4NtG0U0FOwSKT+Uye+NjBOGWIVjIMiRqRBREpg+i1FVNCp8D3YRKxwKmiXvj+FlVorPY9QShMvhbjqCxeUkIsizCWSAH+xMvJSbTDHkb5aGvxUzDRExHvpL8KXaPsv+r7bWZNbbPaumYxzV9OEKVgMtSVpMyySGoI6lxvS7PeKM7nij7ILR+1pFp5IBGvkL5UTZdI8FdU3UqDyl/xC9cHZf6CTsaCcB7GgzPAZJiL9YHAsQqEH7IkkBzoIqRXCs+S8eIoVvLGNaaKiLXPHwsmeRQtfkJJ4I3SDXY2anpjuDT/2WtRWqZzv9Y/QyronmRgt/HCzEqsXkXhJF2Ns68+Njvr1/ZwDyNBbfpkkZqIa8r6lAIcV5iNFcEJ7NFqY0qP4k0ybey4V3mSD2D9cAzYa9RQp4VfKdE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:32:50.3054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430a1900-6024-4b9c-aa5d-08decc3a410b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426
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
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22301-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:phaddad@nvidia.com,m:parav@nvidia.com,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:rongweil@nvidia.com,m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2994B696DFC

From: Shay Drory <shayd@nvidia.com>

mlx5_lag_get_dev_seq() will return error when the peer isn't in the LAG
or when no device is marked as master. Result bad memory access and kernel
crash[1].

Hence, skip the peer when lookup fails.

Note: In case there are peer flows, they are cleaned before LAG cleared
the master mark.

[1]
RIP: 0010:mlx5e_tc_del_fdb_peers_flow+0x3d/0x350 [mlx5_core]
Call Trace:
 <TASK>
 mlx5e_tc_clean_fdb_peer_flows+0xc1/0x130 [mlx5_core]
 mlx5_esw_offloads_unpair+0x3a/0x400 [mlx5_core]
 mlx5_esw_offloads_devcom_event+0xee/0x360 [mlx5_core]
 mlx5_devcom_send_event+0x7a/0x140 [mlx5_core]
 mlx5_esw_offloads_devcom_cleanup+0x2f/0x90 [mlx5_core]
 mlx5e_tc_esw_cleanup+0x28/0xf0 [mlx5_core]
 mlx5e_rep_tc_cleanup+0x19/0x30 [mlx5_core]
 mlx5e_cleanup_uplink_rep_tx+0x36/0x40 [mlx5_core]
 mlx5e_cleanup_rep_tx+0x55/0x60 [mlx5_core]
 mlx5e_detach_netdev+0x96/0xf0 [mlx5_core]
 mlx5e_netdev_change_profile+0x5b/0x120 [mlx5_core]
 mlx5e_netdev_attach_nic_profile+0x1b/0x30 [mlx5_core]
 mlx5e_vport_rep_unload+0xdd/0x110 [mlx5_core]
 __esw_offloads_unload_rep+0x81/0xb0 [mlx5_core]
 mlx5_eswitch_unregister_vport_reps+0x1d7/0x220 [mlx5_core]
 mlx5e_rep_remove+0x22/0x30 [mlx5_core]
 device_release_driver_internal+0x194/0x1f0
 bus_remove_device+0xe8/0x1b0
 device_del+0x159/0x3c0
 mlx5_rescan_drivers_locked+0xbc/0x2d0 [mlx5_core]
 mlx5_unregister_device+0x54/0x80 [mlx5_core]
 mlx5_uninit_one+0x73/0x130 [mlx5_core]
 remove_one+0x78/0xe0 [mlx5_core]
 pci_device_remove+0x39/0xa0

Fixes: 971b28accc09 ("net/mlx5: LAG, replace mlx5_get_dev_index with LAG sequence number")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index a9001d1c902f..c6e6534a5e23 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2155,6 +2155,9 @@ static void mlx5e_tc_del_fdb_peers_flow(struct mlx5e_tc_flow *flow)
 	devcom = flow->priv->mdev->priv.eswitch->devcom;
 	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
 		i = mlx5_lag_get_dev_seq(peer_esw->dev);
+		if (i < 0)
+			continue;
+
 		mlx5e_tc_del_fdb_peer_flow(flow, i);
 	}
 }
@@ -5526,6 +5529,9 @@ void mlx5e_tc_clean_fdb_peer_flows(struct mlx5_eswitch *esw)
 
 	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
 		i = mlx5_lag_get_dev_seq(peer_esw->dev);
+		if (i < 0)
+			continue;
+
 		list_for_each_entry_safe(flow, tmp, &esw->offloads.peer_flows[i], peer[i])
 			mlx5e_tc_del_fdb_peers_flow(flow);
 	}
-- 
2.44.0


