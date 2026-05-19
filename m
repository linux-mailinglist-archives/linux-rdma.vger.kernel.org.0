Return-Path: <linux-rdma+bounces-20988-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE2DFyaKDGo1iwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20988-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 18:04:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF64581EC6
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 18:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C04153076512
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3483546D0;
	Tue, 19 May 2026 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VmdGfOKb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC93AFD0A;
	Tue, 19 May 2026 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206116; cv=fail; b=eVQhQnu/e0kuMUTGfxMIQGNKsPhJ6GUhQzYIJs6fKdv5kB0iMteb9eWQMa6ZXPmchX3TIS9t1G7t6S5RYh/d7SniGjn3twuu489TkiAqA3hH9ACYu0IYWAYmjNMWtgZf+sD24D9haXASkjP9hybFIhEXrqiPI0Uv9YuDyblETs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206116; c=relaxed/simple;
	bh=2YSgVF0SdQvgcI8lroshx4uigq8OOQOGRLp3jZQx5yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mklCq9ENw2TxN/kwiEt1deg1uDoGcfWfnbr6Fmq33d5Z10czid/P07FaUJihdAZ5kPEENGS4OhCQXjZZWgMGE/l2k2uR+AakhBR57hx2OsAesEeV4A0GLoaxl3JW66wPMbxWIqgbx2DjcPKYJOW42IWgN/8/6MVRy6YUOGxpStU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VmdGfOKb; arc=fail smtp.client-ip=52.101.48.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maxAZPT7PaUoLK9o/XCf2c54ZllY7hOqCWLQ+uOruIRt2GQFX65RHN8bibfjk1ZwmLMmm1mHHBTOJAuH5csR+EiCWfUau5kgUoMWUP45R5uQahzqCCOWDdANUsppba9OXmD9D5rtXDshHN5ojoJmFMEDorIoacJELBmApJ/SehPHytCDf6a5Jx+1VSuTA5wZD0pSbA7nBg4xLNi63ytp+S+O/0u66IdZeFdwM9N1iOBz3ghqwP+bsiFZ74IPTpyfSmPiELttm6jIjxrFM4Ensn27/k3KhPg57DQFrs7TO66kAFRCd9WnRImim7xsY/STuut0n37o8FmjkNf2RnUYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACz2KjThz6aLhAJb6lob2VLZrxIMNt/6tn0okyl/kjI=;
 b=PZPbKrvpYMjFEdqbakJwIxd9lI+/rpKYvgpBmf3Iw5dS5RaAeSNWh8b3OSgghfj8JoI5jzxeRrGRLyjTd3sWysHIGzJlivP2wCmaRb0X0oMQz+Ms4lic5M6o3MEBJoXyUzRFKOaWW6oyKt9GLFjoUhqqBS35bqSTdC5of18PwrdH3dXvJ+Acjj+iw19fhKhvxViCfqf1NEUzAbRIJHFdwLfFzjEe8Z/Izd0Cp4CHpLyfoYivm2jYxWgns8nADY/X8m9a83c3jnBot6YA/jZ0dVIufq9o1hoAUIC9a11fXvYK85NCoOQ7YUuzjkpVWTDWGQpS62Cbn70V9nL1TkcR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACz2KjThz6aLhAJb6lob2VLZrxIMNt/6tn0okyl/kjI=;
 b=VmdGfOKbnlnq7Yyxp62YQbg3Za3XiYRgX+yCyt547eLrzqY+hNJLqB0QriX3V8cVQqeEtmJEUHTSsC6kQ/5Af7FEnhTI6NQS2Lun1PtlLhfbuw6SHeaPZtxOJct8kEOxf76TOC2yOta7wOPrZMfgc3/AzXGhlMrqKiDDFnHMnDNMtj9qFgl54FnolDj1XTUTiFJEPV075S7Kx1TxSM0HacKUpjaq4Vtm6GkkXXfBIXuzsFpoq7xKvyyJGogjCKOCql4vgyi4UBi45OYkTWrBt0UTkZ0S9dXyiiqKAIY24E7jvtXAgyUclLODzlSx2A3s40rjzuL9hxZ9Xc/pmQJrJg==
Received: from SJ0PR03CA0122.namprd03.prod.outlook.com (2603:10b6:a03:33c::7)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 15:55:09 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::5) by SJ0PR03CA0122.outlook.office365.com
 (2603:10b6:a03:33c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 15:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 15:55:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 08:54:48 -0700
Received: from [10.221.212.38] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 08:54:43 -0700
Message-ID: <224f77b0-245c-46ec-b4d2-67055337e819@nvidia.com>
Date: Tue, 19 May 2026 18:54:41 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 3/8] net/mlx5: Use mlx5_eswitch_is_vf_vport()
 for IPsec VF checks
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
References: <20260518071356.345723-1-tariqt@nvidia.com>
 <20260518071356.345723-4-tariqt@nvidia.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260518071356.345723-4-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: c35fbb28-c235-4260-2710-08deb5bf0142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|4143699003|18002099003|11063799006|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Z7BW9rOAHlZadSFilVF0EGO/Q+/a8k8f/9/fkXwY1ADc+1PRoxs1n1+LsB3DV+BD+L5O4lxb0G9aH2t81ar1/HvXdIcaAWhYNAr0TMsK5RsfIHFnldx6ZfTbU8qkOJFxlIl8ctnMfiQGF7WoyKhnaIsTm1eCuMFeFoLxEi+gOgdlmR+mU84xHk7miHHVXvzy609o010KhRwn16pqJ5S0ES22MMjXBeq0tKHf2adV85lzTwDKJzlFA9s/J6/72c5F6P/pM2Dfq9L4UdniXnF2eevw/PILMUfoVI+4xkTEh/3+eelGriyWCnijXMoa3IuK2bZXr57eNEhVZQkAkifZA+dEIN0SsEjnZb5aVP42zhNQrJbhnT3Lz02Iclc6WP/21QoC+seLlZ4SoO0QphEhT1NxEbPLAj1UITLzz1bY/Xjcr112f9SWkRJuUapN/RbAqMEW6QfV8Ho1SGb+Td4xAZCZpu39lNTCYrJEUlrhBIEefozCzgeXfNOi3RBpWDmCnZ/M20qNQ01HCjWUResKR+bGRetokOKvT+iPsQKWqSa8zxyUHnjRLwC0T32N7L4+h08HcyFRx/SNwoVYz5mnhrT4dlI9XJButHpItOFYz5L9izSSxehie35BM/XwGYUaTc4ChrfB09nFBL7WbKHwpv59kDgiZyopFNCIQF3oEL/gxMdHk2He6Z4S5srPMYajC/r1fcFJvvcxgJ0GncvfzwfeWuycawSlFUtDsJMSoOo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(4143699003)(18002099003)(11063799006)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YwCg/4L4ItKHBpcHKxLJBF4aTB4YODoWeimINM4Ud8Q4RJOCGwKUHSpbVha8uLH3WBsmBV7QRIScs0iW6LYvEG5xd6hO8yGfAqup2P04nuUFn27iE9JcB4Gjc+X1NMeyfl18esrBTL9uaq7BpEEw+fRqafs8c/WihhiO+eyrb4yQHRHdYCw+zlS63CNuxiXBl+Mrlr2oZiH7RcKXVepHwG46iWAkcM1WNVnYSZSZ6ApqaShhcTeZhjuN91NLUrsO014iseI42geacwb93YYvQxEsCwn0hZgeP7zSGW5ORptvYdFZYmIiwQhL+D1Lg30EsEN6kocuNioNERwsEsCkm6AG9EXGpsTDyhCiHm5Y4Ex3cNkTKTz4rrokizGxiMNBydyLCbgVoQTBkZmgJzfeSyNpDdC6qRapQe5GrER+4Q4xMaZ9ZZCsi5a97YA1nhCo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:55:09.7262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c35fbb28-c235-4260-2710-08deb5bf0142
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20988-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,nvidia.com:mid,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moshe@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: EBF64581EC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/18/2026 10:13 AM, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> IPsec eswitch offload operations and the enabled_ipsec_vf_count counter
> are intended for VF vports only. Replace the MLX5_VPORT_HOST_PF checks
> with mlx5_eswitch_is_vf_vport() to properly identify VF vports, as
> preparation for adding another type of PF vports.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c | 2 +-
>   drivers/net/ethernet/mellanox/mlx5/core/eswitch.c   | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
> index 4811b60ea430..b830ccd91e62 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
> @@ -209,7 +209,7 @@ static int esw_ipsec_vf_offload_set_bytype(struct mlx5_eswitch *esw, struct mlx5
>   	struct mlx5_core_dev *dev = esw->dev;
>   	int err;
>   
> -	if (vport->vport == MLX5_VPORT_HOST_PF)
> +	if (!mlx5_eswitch_is_vf_vport(esw, vport->vport))
>   		return -EOPNOTSUPP;
>   
>   	if (type == MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD) {
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index 8b62dde7eb70..9a7de7c9a667 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> @@ -958,7 +958,7 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
>   	/* Sync with current vport context */
>   	vport->enabled_events = enabled_events;
>   	vport->enabled = true;
> -	if (vport->vport != MLX5_VPORT_HOST_PF &&
> +	if (mlx5_eswitch_is_vf_vport(esw, vport_num) &&
>   	    (vport->info.ipsec_crypto_enabled || vport->info.ipsec_packet_enabled))
>   		esw->enabled_ipsec_vf_count++;
>   

Sashiko.dev says:
" This isn't a regression introduced by this patch, but is it possible 
for enabled_ipsec_vf_count to leak in the error path?"

As it says, pre-existing bug, not related to this patch change.
I will have a separate patch to fix that.

> @@ -1020,7 +1020,7 @@ void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
>   		mlx5_esw_vport_vhca_id_unmap(esw, vport);
>   	}
>   
> -	if (vport->vport != MLX5_VPORT_HOST_PF &&
> +	if (mlx5_eswitch_is_vf_vport(esw, vport_num) &&
>   	    (vport->info.ipsec_crypto_enabled || vport->info.ipsec_packet_enabled))
>   		esw->enabled_ipsec_vf_count--;
>   

Sashiko.dev says:
" This isn't a regression introduced by this patch, but does this logic
handle the case where both crypto and packet offloads are enabled on a
single VF via devlink? "
	
Same here.

