Return-Path: <linux-rdma+bounces-22218-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8kwmEhXbLmqT4wQAu9opvQ
	(envelope-from <linux-rdma+bounces-22218-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 18:47:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E118681941
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 18:47:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=bIQeIS4R;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22218-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22218-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3C31300BD4F
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6723C4567;
	Sun, 14 Jun 2026 16:45:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C528136F;
	Sun, 14 Jun 2026 16:45:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455517; cv=fail; b=CH+L0Xd85coFgQuCyY6ZrGA+z+uWiJf5hG1UOdn7T8AUlif0VvQDVT4/jV6Yq8jcEq5lZ1RMR+slgbUpTugz6UAlnPgcYE2YlGvQpUc5GpP86TrZ4Gnc/NBt30D0XHCFsW8aA5JYxwOwzN4UgLZG/TcZDnobU8KCVXLfH44FKTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455517; c=relaxed/simple;
	bh=VvtfxuOeV/2hobEMI0n00ZjXXhOssSjMxiap7487MmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tR4m7A2pmdYBesOm/MEIybuNiBKs6NYvcbP4SMg2TOx7lIVl+KRE1ZJ79Jym+TpIxV9DZHmkQgmKWQPOmjPjxO62T/uYJNfnKzxay+xPIupyOLEnqDkMFwoZ343ceiCqTnifo9EZvSSmcSHLayCcsUzr40x1KPdkGGeDTdhLgIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bIQeIS4R; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMT+mGUqYfTw+i/aM0RD4GD8IdvI1Mnk7AWE7fXgrjDykyEU+IYJ6c/13QqsFEtc6V0lR2wzm+Nm6mEPCam9OvtN/dVIveIjcwfJQ/lda23Fwt0UwkAOVQjyNwcp6RYdchyky+3Bu3E0fiVJpukU1ZMM18lEMknqTpxNiTbOeol7FrUfpp8u9vYmEYuUQQl3W7sHEni2Ev8CGw/wp1k82ZBEJi/muwuqpKczF7Y4uHQsBY0q7JHwy6qiEtPzrkDSFeEf3mPywb+3aU4sjJG5EAFljInd5POmGZj+vjUYHLHfDuzw+FNoPBl2tKjfNgS2Ex3ylbnIvtTTKbjtT0Cnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIUtR485tTWaj9rB8SfpYkteIOO3epK+3yNJLBXz+4g=;
 b=kcpafvLW8FqBdiBbB6N1vYJ2ycciQho7Zy1pZPicy2T9VTlweuIS8IT3o3sc40Vv5f6jyJgLTOCTrqKQi5p/ltssaEcjP87vjRLZ7e1bKyy87EqimMxHfP8Z0DCOWJpML1TM0G2lFGJkvNpHhYIVkh6oto5nD4DpUuIVk0/Z6gPPehu1pgxIR6JJNROu4XCckHaT0EfgdbJZJKYL+zt4mESGXzYrsRz2jnnhgfnLImumy8Tc0OOQJajzGO+0WTsEAB3FrfCMYH+XFrJZCitjWeCJgDB3+F61hrvJhf7gUvoymXtT6EpD+G5wqCcc/+1cjkiegY6CRRt7iC6pqFrQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIUtR485tTWaj9rB8SfpYkteIOO3epK+3yNJLBXz+4g=;
 b=bIQeIS4RYjSi/lXWkGOuA4/AXxBENGw5QH9+NgHIxppC8EOxLQAnz77wFx1ff/KrkSlwpLBBDX81XuPzvAo3wCG156zQasBi1rmgQWjMtdKhZ6V6Jm07HE5c2sD92jKeSkfBODhvKtxRqOsGIXUZnsVo3bPi1viI16gdCfZ9Ta0+FScPnlx1gY/fPHGOr4ARNtNseuKOf6nmOJMBGdC1Il7b2s1W+KFhiT3d8fGgW6HTEZLvPUHmkx6nc2/C+Yz6mdHG5ktjHM6Ifhk/exGYgkuUA88uF70zxGdJPiiz9BvRkwY26X8eCAqu0UvClyKLhuiGxU49SvmoO77fA0A/BQ==
Received: from BY3PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:39a::9)
 by DS5PPF2FA070BDF.namprd12.prod.outlook.com (2603:10b6:f:fc00::649) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 16:45:08 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::15) by BY3PR03CA0004.outlook.office365.com
 (2603:10b6:a03:39a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Sun,
 14 Jun 2026 16:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 16:45:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Jun
 2026 09:45:00 -0700
Received: from [10.221.208.116] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Jun
 2026 09:44:52 -0700
Message-ID: <a8d5f189-5268-4af8-aa1b-d90a14e6260e@nvidia.com>
Date: Sun, 14 Jun 2026 19:44:49 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 14/15] net/mlx5: SD, defer vport metadata init
 until SD is ready
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
 <20260612113904.537595-15-tariqt@nvidia.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260612113904.537595-15-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DS5PPF2FA070BDF:EE_
X-MS-Office365-Filtering-Correlation-Id: 97675acf-0138-4830-16eb-08deca344b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	I7tFpzbKhF8lSyPxYSIcNkrbB403ihcxNs6byRKIlKJasFm1xzBgEp/3M0Qic8pERX5ckgG2C6ym1zgrgrMXncLbcQqGDA/GzEJTUkylU+XRFF8MibhrpgxjLacHS55y5kseo4OPRqA2NqTxTbHm2RiYTOy3/tJaEiSkjN0hjgPjTTsQj3tk99HLO/v9OIBkcUBEgJ+O2pxkcL1gIkcy5DwJkxCbZdb6P/TQimM0dEvu1i/Mx0Vn+0HwTvg72rs2dnbaCnzCcTG0t2Ibz7BiVMG/bvLqX2cZKU4Nq72BREFkQNbqgrP1pDXnFSKbXB+02Rb+VEjSUphSeS4V6gB2adAKS30ntvYlPNDXH59Jnwvn/moKUpk4WunMY4QkHSA+oaE3OdqGzm06ItaDH4vGGzx4OA+APxHPoj7y8G9hfpGKbnba8G4+Zv0PGSgX+pMgkjId0c7qQRTadg73Bfe0TCFVL0EPk6dS2OCCYaWQsns7Z4GWpoc60KC+/Mb9uTkdFh+EkT3BbuONLVZjQmX6GcM+etsfZvNKXhv7hE4L9fF2pULs1Oo6zyn89Mlh5J9g8C42/71r98rURDrPkmsQrgYajYlxDb0JsRARt9sEWb+XpXsZtRPlQPDv56IXawlqhFoaqBwFSDvrZ2OTd/m4/7Cs+vMlQZHWiatxJNRJqBvvQAi276FU+2XMR3iszIqzJXv5k5lFO/n/Daej+WaU4TWAZQ65QuPdG1CFCqiF+VQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IBAU1Ey+c2PvWPA6HH2lGIg01Zx0KBkE/ZTPHnSDcu3fjNq587KOv7mThyoa19RZCt5S94okfE545z4dq7DFk3ZyAFoLiyJ/H2KRggCGdOZb99a/j6SVypavpzl0pn3mb8uT2oHQkBDAcoca27EJxZeIlcBIHhZ5msDk7odIsUD4JDJHkhUuNk0nSCHwzoWQwFbvvMCtZZt7S3DPodf3glvupVswHtmbt6rnHuvGLKj6TrzDCldEnlp5xstW3D8HanKsfBDD+8xSWfd6kVZJ2fyio6vYQbHi1j1gkHMLzGr2VGnSXqoWfRyDZsQpc+M6DYtNoh3nMg2bKmS0j7GTJMC4tZkkQllOGJyWz62mYChAyvgQ5XwcJTGOc4scRvD6qodC6dWyKPFkr85+XKcKrMtLjU54oy/l++IPfZdPCGkTl0CUfiU8wCZQE5ju/Lmw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 16:45:07.8370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97675acf-0138-4830-16eb-08deca344b0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22218-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sashiko.dev:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E118681941



On 12/06/2026 14:39, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Allow SD devices to transition to switchdev before the SD group is
> fully up. Metadata allocation requires the SD group to be ready, so
> defer it from esw_offloads_enable() until SD shared-FDB activation.
> 
> Add mlx5_esw_offloads_init_deferred_metadata() which allocates per-vport
> metadata and refreshes the ingress ACLs that were previously programmed
> with metadata=0. The helper is idempotent and can be called multiple
> times.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/eswitch.h |  1 +
>   .../mellanox/mlx5/core/eswitch_offloads.c     | 79 ++++++++++++++++++-
>   .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 16 ++++
>   3 files changed, 93 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index b2b3150f1f04..fea72b1dedab 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -440,6 +440,7 @@ struct mlx5_eswitch {
>   
>   void esw_offloads_disable(struct mlx5_eswitch *esw);
>   int esw_offloads_enable(struct mlx5_eswitch *esw);
> +int mlx5_esw_offloads_init_deferred_metadata(struct mlx5_eswitch *esw);
>   void esw_offloads_cleanup(struct mlx5_eswitch *esw);
>   int esw_offloads_init(struct mlx5_eswitch *esw);
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index 4dc190a4e7b2..8fa7e633451c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -3675,6 +3675,7 @@ static void esw_offloads_vport_metadata_cleanup(struct mlx5_eswitch *esw,
>   
>   	WARN_ON(vport->metadata != vport->default_metadata);
>   	mlx5_esw_match_metadata_free(esw, vport->default_metadata);
> +	vport->default_metadata = 0;
>   }
>   
>   static void esw_offloads_metadata_uninit(struct mlx5_eswitch *esw)
> @@ -3711,6 +3712,73 @@ static int esw_offloads_metadata_init(struct mlx5_eswitch *esw)
>   	return err;
>   }
>   
> +/* Deferred metadata init for SD devices: allocate vport metadata and
> + * refresh the ingress ACL for every vport whose ACL was created with
> + * metadata=0 in esw_create_offloads_acl_tables() / esw_vport_setup().
> + *
> + * No Rep is loaded at this point ==> no Rep net-dev exists, so no need
> + * to take rtnl lock.
> + *
> + * Safe to call multiple times - subsequent calls are no-ops.
> + */
> +int mlx5_esw_offloads_init_deferred_metadata(struct mlx5_eswitch *esw)
> +{
> +	struct mlx5_vport *manager, *vport;
> +	unsigned long i;
> +	int err;
> +
> +	if (!mlx5_eswitch_vport_match_metadata_enabled(esw))
> +		return 0;
> +
> +	manager = mlx5_eswitch_get_vport(esw, esw->manager_vport);
> +	if (IS_ERR(manager))
> +		return PTR_ERR(manager);
> +
> +	/* Sanity check: skip if metadata was already initialized */
> +	if (manager->default_metadata)
> +		return 0;
> +
> +	err = esw_offloads_metadata_init(esw);

sashiko.dev says:

Does unconditionally allocating new metadata here overwrite any dynamically
assigned vport metadata?

[SD] No. no REPs are loaded until SD LAG is created, so user can't do
any REPs bonding

> +	if (err)
> +		return err;
> +
> +	mutex_lock(&esw->state_lock);
> +	/* Manager vport doesn't have a rep/netdev loaded but its ingress ACL
> +	 * was programmed with metadata=0 - refresh it explicitly.
> +	 */
> +	err = mlx5_esw_acl_ingress_vport_metadata_update(esw,
> +							 esw->manager_vport,
> +							 0);
> +	if (err)
> +		goto err_acl;
> +
> +	/* UPLINK is never marked enabled but its ACL is programmed in
> +	 * esw_create_offloads_acl_tables(); refresh it explicitly.
> +	 */
> +	err = mlx5_esw_acl_ingress_vport_metadata_update(esw, MLX5_VPORT_UPLINK,
> +							 0);

sashiko.dev says:
Is the rtnl_lock required during these deferred ACL updates?
The code comment assumes no representor netdev exists at this point. 
However,
for the primary SD device, representor netdevs were loaded and exposed to
user-space much earlier when its switchdev transition completed.

[SD] same as above, no REPs net-dev exists at this point

> +	if (err)
> +		goto err_acl;
> +
> +	mlx5_esw_for_each_vport(esw, i, vport) {
> +		if (!vport || !vport->enabled)
> +			continue;
> +		err = mlx5_esw_acl_ingress_vport_metadata_update(esw,
> +								 vport->vport,
> +								 0);
> +		if (err)
> +			goto err_acl;
> +	}
> +
> +	mutex_unlock(&esw->state_lock);
> +	return 0;
> +
> +err_acl:
> +	esw_offloads_metadata_uninit(esw);
> +	mutex_unlock(&esw->state_lock);
> +	return err;
> +}
> +
>   int
>   esw_vport_create_offloads_acl_tables(struct mlx5_eswitch *esw,
>   				     struct mlx5_vport *vport)
> @@ -4072,9 +4140,14 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
>   	if (err)
>   		goto err_roce;
>   
> -	err = esw_offloads_metadata_init(esw);
> -	if (err)
> -		goto err_metadata;
> +	/* SD devices defer metadata init until SD is ready and
> +	 * mlx5_sd_pf_num_get() can return the correct pf_num.
> +	 */
> +	if (!mlx5_get_sd(esw->dev)) {
> +		err = esw_offloads_metadata_init(esw);

sashiko.dev says:
Does skipping metadata initialization here prematurely expose representors
with uninitialized metadata?
esw_offloads_enable() skips metadata initialization for SD devices, leaving
vport->metadata = 0. Later in this function, representor netdevs are loaded
and exposed to userspace, which allows userspace to add TC rules matching
metadata=0 before the metadata is actually initialized.

[SD] same as above

> +		if (err)
> +			goto err_metadata;
> +	}
>   
>   	err = esw_set_passing_vport_metadata(esw, true);
>   	if (err)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> index b35795bac098..2fcccd329eb5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> @@ -992,6 +992,7 @@ static bool mlx5_sd_all_paired(struct mlx5_core_dev *primary)
>   static void mlx5_sd_activate_shared_fdb(struct mlx5_core_dev *primary)
>   {
>   	struct mlx5_sd *sd = mlx5_get_sd(primary);
> +	struct mlx5_core_dev *pos;
>   	struct mlx5_lag *ldev;
>   	struct lag_func *pf;
>   	int err;
> @@ -1024,6 +1025,21 @@ static void mlx5_sd_activate_shared_fdb(struct mlx5_core_dev *primary)
>   		goto unlock;
>   	}
>   
> +	/* Initialize vport metadata for all group devices. This is deferred
> +	 * from esw_offloads_enable() because mlx5_sd_pf_num_get() requires
> +	 * the SD group to be ready.
> +	 */
> +	mlx5_sd_for_each_dev(i, primary, pos) {
> +		struct mlx5_eswitch *esw = pos->priv.eswitch;
> +
> +		err = mlx5_esw_offloads_init_deferred_metadata(esw);
> +		if (err) {
> +			sd_warn(primary, "Failed to init metadata for %s: %d\n",
> +				dev_name(pos->device), err);
> +			goto unlock;
> +		}
> +	}
> +
>   	err = mlx5_lag_shared_fdb_create(ldev, NULL, 0, sd->group_id);
>   	if (err)
>   		sd_warn(primary, "Failed to create shared FDB: %d\n", err);


