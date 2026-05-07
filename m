Return-Path: <linux-rdma+bounces-20177-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMTAFq7N/GlhTwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20177-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 19:36:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EECC74ECF19
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 19:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF9253013AA0
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E1F3AD513;
	Thu,  7 May 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hFifLVZa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B543DA48;
	Thu,  7 May 2026 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175331; cv=fail; b=st5x3WwZieLkPrjctWdLr67IgIL505QedDReRPxvmPMInsX+XFrk50pecBY7NOBaXe8hlJI5tKy4heMDdPqG0P2cPna9GQdVXigyO/hKyQaqnLf2e4Z/cL84fJuas3Z3pn+Y3BJDl5nMmlPn/Ze+Y54n3wkoU+Ae1YQwxoa9a7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175331; c=relaxed/simple;
	bh=BEBSzg6u2DgWJoOewwdzlTsV0RThKV+DeXu4rRg0+ek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hql6nDWwoYvZgiT/mQEShkae12WPUz4hj3GeFHdEtD2pdHhXre/uSP6WUd4KmNsoBHCJh1c/PyHUYixPiUW6fRA74AuLQYiCsijN6dENpp6retypSZelr1CmJM4u/NHz75e9RrV0SZEHh0RSdE2PUJHd5zo2Gk02J+ohQ2hOmag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hFifLVZa; arc=fail smtp.client-ip=52.101.46.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vak4IhIubeAc0phvYcQVpTh/5g7lE2yTr+czig1z4Q8U9Sx8U4fcG9p/zOOGJbEF50ainrQIuDBRSp/zteOfayhWjbO1h8cjyYQekYxS7BU7eK+8oNaY5LsKx5/NZLcQOeF/UblE6G4nEfykjcyFAhZOR0RrwFZzIcfsiOvcCV1PAra4NOelkyFZI4NC4jcGBCOp0RjkKEEbPIlwjsohcZkJVbuvlDSIxjJolDSMF9RTwTig9xUpprbBKSpvgW/14xuZMsjalemWm0R1ntspF8cRo9OaJ/gvq1TYT7ts7ZkH1vpcBMbn/tMdm8slUXxYT1iFNEfUwcgtFs9cMs7rsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLHbSiUtgBfZ7uiEqY7Gc5zELbAEtYh+j7+eLKhYTBU=;
 b=afhVDbRZKwXwWIlHQOVHnfbgTWrXS8XNvSMnNVeCEqyt31DPq8zmcMs+dlnMjGlqjCBOdUW67/+1lw+NGU/uEBvHp7/GRGnqIgYwTLfYbR+ZhOLqI+qM95cqm6GesJHGvhyOJslxY5I7924WTnOiFXIE5iO8DbRux8YdJwRVdI87uWQuhKgrntFf+sjTJwQskwRnlklo1e/HA2js7/i33dHHUv63Jz/PvQvQ0ybiBbIwvGWgBxE8CH4u2AcNiGngzCi0YaJgTnoxxJD3rbKa3eFsZKjjpLoby/AX8rH/Xr78Nc7HRq0tPU/abP9mMwvoGPDJKT8ashsKL+XNXXPMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=openai.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLHbSiUtgBfZ7uiEqY7Gc5zELbAEtYh+j7+eLKhYTBU=;
 b=hFifLVZay1lstV4xnEIg4AXTwW+aFZOlT5iFq4bNuP0VqINATrycZE5W30xc06m7RCdHeTT5feHUWXK3xYn7YnHG59+b8GjbZvkkCwEWRZFlyeKgDH6vJQ7hPheePiFYiREU8pvJHVc6dY01gi4m14TcRtKyzxbCGoNciDhv/cPkc7uSZatFzC2X8Io0Zsa1UdwlhWSMqBVtcIpMtG223R/v3veHUgbZIuGEiBz2MBHKW6iaGQe6W4SX4SfIWz/anU9JXA6CPmafOnzs6OgPL7N6e/x3MN2WfyKzQUWBJMGuNGeuto6SX/Yt0x5tqzm/WcU4hFVRdWl7ukN+B9PwAQ==
Received: from SA1PR04CA0011.namprd04.prod.outlook.com (2603:10b6:806:2ce::18)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 17:35:24 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::4a) by SA1PR04CA0011.outlook.office365.com
 (2603:10b6:806:2ce::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Thu,
 7 May 2026 17:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 17:35:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 10:35:07 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 10:35:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 7 May
 2026 10:35:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Christoph Paasch <cpaasch@openai.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Kees Cook <kees@kernel.org>, Alex Vesker
	<valex@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 0/3] net/mlx5: Steering misc enhancements
Date: Thu, 7 May 2026 20:34:40 +0300
Message-ID: <20260507173443.320465-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: bad69345-79de-4152-5716-08deac5f054f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qjGrbn3/uGe2mGJ2xmOZ1M4mdKEYFoEiH/eGY0vthz8m37j89bTYVYpOuyGl4Fgsc5Pv8H1LCMxsUASnt5rzjcnqbfTo5T01W1NzjfcTnvKgvVQAi/U3HQH3p0PyRmc8A4/Q04feRjEIKaKxQEDzHHQXuOPii2PCjRZIc25530xWN3T7DPDr2GMAfMtwUjjonnZv9yTMgXrfJBL/WncNosqA3325m4RWznsDjz5M78DzS1oC0+0CN6ClDAWN+30K5izFE9OgdcKYQYJHXJBneVe3l7hTGf+JFTwlQz7CMru/3jYW6XnqF+5sJMnSJMvkjzb6baj2IQ76JNSOUnWiV4Dlwzj9oAmrNBEpfysnGKx53wp86t16PpBFotJWmJ9QjnVGvFXw3l96tKgaytZj0NP1vnY3Lpbqj2Gl8APJR3GWUMbLMbGFQiyRqYL2aKGzOhXe1/sAri35GX0trOtisAC8VTcjc2FjL5Sr1gm7TLzJc9JCq33MBnRK5ujQpImpmuIB29BolNNzEweZ7sMAsXlAAq0f0x82f8kHu7Nc+AIItNOJ32R8M4sgjXRnYew0cnvS0pNdHaVPLzSJfjxydUq+8XB/hydZeRveX751Pji60JsSnYqAKRHEGT9SS4/a4WBljwiIHWTxZ+f37Aes+BMa4DVXCAOVK90a8geXoTOgePfB+Da/G3ITIELX9ttSPH89SWtQdi3nQERsGFhzRVAZEZik955nUJ1PJJQGeac=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QGTgho58avXXj3zoSxVX4j7vjB/d2Nae8iQTXEFSnWU59iKiyaG+0CryP9iVgSDv6KEF5q412MfaBNdMBaYZEz5RPoY4+uvvJv44Vq8RbyyBvNPoOhDaw8uWOj8z0jbEuwSRwlBg5meQOvN45qt2jTJsCqM6wtfG26Mf2mp6OmQ9xgKR5hgjEopTXihCTW26Fmn1cvhyZrpNTy7tMWfKhfgchEsk/6eYIoMxF52GP3YybuKJ4FSgHS8zjFuHoT3wVnS8M0vzpcLTuZgNdD71TGUiu26lP8zW3CDEDlSNs9zov0FnLp7KG2PPu+He3AQ59GNnglMVHk6axo0MA2YArt8ayPMmvADjyVQ++lrej842Z7CGRMgyDkTaKDN8BU5HPB9fQNVjvV417nsUef+JurkLBTWW9FWTnXXGBUuEQuozaQ/Q2yYinWDoT4wzZrTg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 17:35:24.3077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad69345-79de-4152-5716-08deac5f054f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
X-Rspamd-Queue-Id: EECC74ECF19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20177-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

This small series by Yevgeny contains a few steering enhancements /
cleanups.

Regards,
Tariq

Yevgeny Kliteynik (3):
  net/mlx5: HWS, Check if device is down while polling for completion
  net/mlx5: HWS, Handle destroying table that has a miss table
  net/mlx5: DR, Remove unused field of struct mlx5dr_matcher_rx_tx

 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c   | 12 ++++++++++++
 .../ethernet/mellanox/mlx5/core/steering/hws/table.c |  3 +++
 .../mellanox/mlx5/core/steering/sws/dr_types.h       |  1 -
 3 files changed, 15 insertions(+), 1 deletion(-)


base-commit: dacf281771a9aed1a723b196120a0de8637910b9
-- 
2.44.0


