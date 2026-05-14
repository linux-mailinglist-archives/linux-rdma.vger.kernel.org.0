Return-Path: <linux-rdma+bounces-20684-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEgXCuGtBWrkZgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20684-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:11:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9346B540D38
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E233B3020FD5
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81C3AE1A2;
	Thu, 14 May 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0PWv/zP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9180357D03;
	Thu, 14 May 2026 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757080; cv=fail; b=iPdMybuAVVKuSAWU7yWUOBtDPt1sgyKKRGk9ZnKuEZyJHtO3rZ11xA63iCF68HdVQsAH3bYaZkxAjKxGluBUU2pWZBZfYvTTZXvtMcoRzykc8TIZsvWJUxw6wEe/cNukOseHWAnTpyxtivISw9lwIq8W9fo3v7jc95oIEKzW1qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757080; c=relaxed/simple;
	bh=HKqodaFdS5LML5X5GhYqnwNAwz/m/hMbjkBwNvhOjEI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KpF+rcIlmEFT0FhLUREaqxc6eNiA1irbYqDf6M0coLGBmBhNktCA4etwXqx/z7sl63WTqqrKSzE/KIVciThkHtv6TgmTi4oDvUGRIfeMBxOjvuuRQ8Gs1Hot+cQLWkr5Y3GqfYjxLiW4iJ3hy14TPf2dWwv4im6fc6/3k+5Ts6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0PWv/zP; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkarbKSX8UBRwUGJ1wq/Ji0I9srgk38tBomUeCqfciEivBReeucL1W4bXtu2xCWRKsrJX/eyCqIG5gDsYtOBQT/La8qD2dgjSKehf04UizahQ4qEmu4QfNxRimeOoXK/eeoe2jLrNG60zIcEyh43HTD3lGB/QlESO4F/BrrnKZ/qbUn0blPMVgi6cNE/eHp8GkEBXxKpVsDJVjRSiwCPLCwI/tikKHVi8RgYuN7wunFRSVxLPD13rJmW3edmfe7km6GUiO+YVJ0pMdCriZwwsVblnOPOXMTjAq7z8jidT2Zzrdhg11XaNtUpzkwNBPhMnsMu95VNXK6CGFZuCOfnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49sgA6YMf7HVnEzQNrMm6TPQCz1bIe1u4LcfDyjf9lo=;
 b=FQ1+EkZlDwNS1qRyMy6GHBBZgUQx6aGstDdbVAhpeKM3neAyAnnw0V1hy92TKktbGZ6GobkEfE78WvT6IEnZA7JpSod13CagD430pythvZTwvYK0kyGPN5gWPUdEVPMywRwUr3h1oKFsmAcoRwSLqfHPGHLiNixwedJT++JpiLXgOyyHx/ZWc6Fpp2eMS9YfpcFTHfJ1Q6bisQ/Apc1Zvrx1mLIiUnJ6zb6bSMCDjqm3xyTI1MyZInvwaD2bZH93aCoEfvAvwmvKuU6I01LQKumQ7AcuyuOf4VOsJJ7iG4iemS6FD6dtbdQNSYq73GR1KEOVpPckkDX4eiD23SoplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49sgA6YMf7HVnEzQNrMm6TPQCz1bIe1u4LcfDyjf9lo=;
 b=c0PWv/zPkTI8WYTjhUnJPZ11807L5xXEB3HMCeMS/3JX2rFoYt0i3418gSe6IyWHiH7OtCUdtA0X3MH7pQz0eq+pAiikgtqmfguy4oIT5ytkMfdag+Ws4mvmlGwESjamCD5KcLXidFy/rKwgAzYiHiP5Abg1atr39a5b2VHC0GXk9H6hucaZq5Y4MPccUooRG55nu2V1kVGhpjgl+uYsw/tCL7J/mZFWMWS0UoH1PAusoytQfmloZDmmodrdLTaNIqYIFwJfoveW4QZR8Vu/XFngaP6/Js8k7JrVjMAp19td+xSPkb8qmc25CHMIjRs/Zcb8GtISg7EiSoz5j8Y87A==
Received: from SJ0PR03CA0080.namprd03.prod.outlook.com (2603:10b6:a03:331::25)
 by IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 11:11:13 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::1c) by SJ0PR03CA0080.outlook.office365.com
 (2603:10b6:a03:331::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 11:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 11:11:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 04:10:57 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 14 May 2026 04:10:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 14 May 2026 04:10:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Shahar Shitrit <shshitrit@nvidia.com>, William Tu
	<witu@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>, Kees Cook
	<kees@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 0/2] net/mlx5e: simplify and optimize napi poll flow
Date: Thu, 14 May 2026 14:10:36 +0300
Message-ID: <20260514111038.338251-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: dc18b5b9-be79-4b87-c100-08deb1a98280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	TSQJ/YLYkf+Z/J0Yb57fFa30U3YoEbk9A3MxKGYpcLi1Hmwz6f1+6JxzV+liaSc415XtMDcWE1VIbz8NDrDh9KUT414kqVpNHbG0XwYyAtbIIq2FWHLJXgXRUbIPasCVGaOAhWJO9gm/Uo4nEcxRj50ceNGTFGg/4OmE/YhpH37kaM0W0IAGO2pWzNid1o8WD14A58Ab4EORgA84QlOCLJ2rpPC5lILQQFxFcg9+dDuJ1qMBdLs2D/G+GwM86+n26WTbfqrnygd0gdxU2ZZ33nLm3mKys875FCeTu8LD5wN4CBIbw3WGfxvNySL/TMP/o8RFMcEJimRXoRX29AJS+DhW1AjB0oX0f1JPtP0jMeZDDwyjujxBjLjOtAi3uWQvC03t+nYAv/2P7T3BZeg6+Hz8rYigW/yQjuA8kY0CLv6UBqc4DIxwGWobb22e91nHMUeZfFU+cBEQii/zgs6lg8ZF09u8C2jzyUxd0zifL/8Zq9zwEX+WF0pJBNo7SjEIkl8PyYg3EO8k0cRtX57gQOvmLCbrUF0JGWL9nvHVyiSGb2TFeOoEegl0L29PgCyY0nHOGVh95pyGT2W9rO950Kx6m6b9s+3LaOQlka1vRr23q4s6B3Ye2QT+4teKUcmloSknGBd/ysqfJ+QeUy+lCnLey6RHLwlhF7cpCV4YFObi5VZiT3lwXqOjhvUXgOpnaUH+KD5mQOz3z8xk2xN8GoFdp7dZLZBKYB5U+TtEf9Q=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tzxfzNOyfeW5oXKKJNL3UsVfrXWGCfj57PE0FdBSF2EADIJ7ql6Hv4dIv/UGo0owMoiRn5rg6vT5ccSfdG1RXnOHnBACGJGBILooCsaafzgbfTPJdw1AOEhxXt5EWz1/H68lt6FL215uIr8pfY/4LiMSGiEtzvO4RtoK2WBk9xMs+oBz0i101DHfke7wWzPmurIIToP//lvWspPphuRJ0J8kmFPl2ODyXxo7V2FM50auxjl8gEbZauY6xzke37aotRknxV9BRZivI/AqzeZySqlMB5fBSjsAmKhq0pRc8MEqyFm+hQFpXbL+vXrJpkKCqeQIU7YZhiI9dqwqam5epKdsuywrTgZAkuqfjKkJ9ceUVBGZhqqQIZSh4d+bbsfrYcmqRi7s6iNHV5S9+LPpZd0JCwK8NilxBDgBtw5pdFkvhqVy8LGDjjwGmvOKRTvk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:11:12.9981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc18b5b9-be79-4b87-c100-08deb1a98280
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908
X-Rspamd-Queue-Id: 9346B540D38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,queasysnail.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20684-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

This series simplifies the mlx5e napi poll flow and reduces branching in
hot paths by leveraging existing dependencies between channel features.

Patch 1 avoids passing the full channel object to kTLS RX code paths
when only the async ICOSQ is needed, and slightly optimizes the common
flow in the pending resync handling logic.

Patch 2 further reduces branches in napi poll by relying on established
feature dependencies between XDP, async ICOSQ, XSK, and kTLS RX state.

Regards,
Tariq

Tariq Toukan (2):
  net/mlx5e: Reduce branches in napi poll
  net/mlx5e: Let kTLS RX get async ICOSQ param in napi poll

 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  5 +--
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h   | 12 +++----
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c | 35 ++++++++++---------
 3 files changed, 25 insertions(+), 27 deletions(-)


base-commit: 18dc8e6d15d7a30888beec46a1e01ca0f98508fa
-- 
2.44.0


