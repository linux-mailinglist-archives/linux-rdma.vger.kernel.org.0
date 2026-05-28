Return-Path: <linux-rdma+bounces-21454-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMG8CDaOGGptlAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21454-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:49:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB895F6BBC
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E1BA301E6CD
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DE032695F;
	Thu, 28 May 2026 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VyeFSOCw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38031A045;
	Thu, 28 May 2026 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994159; cv=fail; b=hju6Lgm0nJ8RgPvs83rxJ9JhvFPND3ayZlNy66qK45/TIwoCFoxw4PJpb5EJy+Noe91Qgl+u7xRLbUNhfA0iNRsGfH1fsuhDYu4NMgNcmfxzZb7pySreH34JvjHuXIv7MPJWRIrn1XHBytV5f/Sdyu9BlviqsFmcbY/s0OpfwnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994159; c=relaxed/simple;
	bh=llvEEZE96M7mkkQs122WLYpJxiHHEi8BCs/4Di2znPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kZLNQqJI+xAPlk7CPj4luOpADbO0zUosuSbwlF12uM66jdMbzdJSi5N1b+UUmuqq2r3ILeUHofxCn4eY/U+yz4xFFaUeeS8/ds/p+/adVH5gY395I2RMR/NPc+kZrujekNsvSxr1Fm8BlZA5OLsjOdHX4VL+JrXljTJg/Pi9kcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VyeFSOCw; arc=fail smtp.client-ip=40.93.195.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XakqwEJ0J8yoyUPtO6g5OCoEgOISygqMvkXxPZvd5C7WEV0haRYrGeyHlNZLfxHpKGbZSfpESGx/y0WM2bWhFJ9Bu/0fr6QGmL6G5sb9/VLYxjEQ/rfwh6Ba9KmQ4lPlPRdb+hQR8SpXWwQ2rHa+e7QW6GfnkDmZIwp89AbvIJ5PPVXtpRpylCcryZEmDjasTUuERYK2+nmeVFVGE1nAoW5qayzBurX/UuOAtSNTNtwEEgoWykAoajTSgv0iauXfP8QoqkRMJGIxIRaOB5H+8H+UWUrRGNrsGwlzAI/hlusLQr0qEVE9etsboLfbxs/klGihonj4kcZex+HeqQ2g8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+616yMvSoNI+NhfDYS2Xxfur086R9hQGzczpUXYyR0=;
 b=Y+sypJdp5+SeBNaeQEc8nLr71xsRdaT+xWDJb1VFN//K0qGleqp+tIL/3uoatrUjEiqpNvdaPSYBE4sT5DSIqVLlMm2BZsj6W7F994PoDw2wT7MdhLUVaJzdpT7PNKBQPAHQ4S35a4YPf5mtiN1KXmvVVJz7jorgmYlqrdgc+DIlxYo7vO7eQ86X3q3NXzFWfJmcXYm9MY0Y7YIfgH9bdcV0HWtke6JhO9dZenlAcQGi5BoqgIHgp95QSusuCYsbtYvdHZ7gBQcl3Fv8UmVNW0Vp9s+Y1yxH2v09TMYQHlJmxmghVomvhfdVj6TfLYXMXT7/aHbROybJuWsvJL8yCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+616yMvSoNI+NhfDYS2Xxfur086R9hQGzczpUXYyR0=;
 b=VyeFSOCwjpr/6NRucoQFMxlZtNBIUExX53HUbOaw8h6HRSwbgUhr5jaPiMOSXzaIYytZnk+VMj0ltwTNXOuw7jiKOJHruKogEoBZFDEmVOTDCBcVbpjdL651ViX4I7joLnGzQM0YHlQyPE7VpY7lIXjC7UxT14F5OFFTia3xDQ4rjDOqLqo++tEpRIYEhWz6aEVbNrIiO+lNCZDroUAj5IraGjoGoVQ91m/iQ2mRLC+U23iBjq3zVtctK3Z7kRFe7B1ADwWh32VqGsNF45e6+CONpNlLZVcxfumvjopd1uIYnJYOkc5vyEssSVurN6I3RFDXV+5OSoFeI6TWpgdmOg==
Received: from MW4PR04CA0186.namprd04.prod.outlook.com (2603:10b6:303:86::11)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 18:49:12 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com (2603:10b6:303:86::4)
 by MW4PR04CA0186.outlook.office365.com (2603:10b6:303:86::11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13
 via Frontend Transport; Thu, 28 May 2026 18:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 18:49:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:48:52 -0700
Received: from [10.125.202.189] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:48:44 -0700
Message-ID: <f9543e58-e5d4-49af-ba50-09ae6656153a@nvidia.com>
Date: Thu, 28 May 2026 21:48:42 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/13] net/mlx5: E-Switch, move devcom init from
 TC to eswitch layer
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
 <20260527125427.385976-4-tariqt@nvidia.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260527125427.385976-4-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: d090ba6f-8bb7-4333-be77-08debce9cf24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9EhksblvuPrVRs2StY4I5ZdwYMUiFpbKqASq8VRYPcJQuWR8TES9MUkx/8qTESiTxaosRDA2FK3eiMxQcvqu5AiSJVrs4r6UUAQlOc9Uc+7vi+LjZ8cc7gYHLbA71V095lJbzGYjj4rXQV1kYlUTugNw/fwn1Rm6nAyMRdRAt5BO4e4eAUhw8AU89/B2MlTg6IqnVMBqLfbvvD04c+EQ9XM3Cw4uuPJi6Z/E+5HEvMAvXRyFP3neGtVbGr73pqX0RnP9wynvnOoPH5oJYz4Gf/dwm59iY7Pi0FfNZRvZLOjPN7gL4YjluIkHtmleqLmrFnvriI3z2gUIGXXoarqSCeth86yvwuitX5ENPnADCb74FC6ueYwY8TYZKPJIzQeIx813dQAzg5hcTXkjMwK8+nmaaKyltylc3B/mLFTeRQntAAkv1AzKVumZoH0sKQOQbvy6K7vePENiCycZSE30j5k20Lct1ED076T/OVCmEgI+bF/3l66WnIfgXvX1sZjc61finqh6e/U7vxvnBoRIr28XNIVv9EchIQUBJxzjkgTxj6LEcPjas6BUdPv3O0/ottpBUEgYVcZb+3eBcf5BgfBHHMuSbCwYpGrOY0TGsr68LozbcrbieKvCqbdONlQ6eXfutzIUU58KU5BHiGmJgo0wMwfW+7O8btCiqbb6eEXgabJOoGJeqek0QQ4zeYPFhkpebXW1ck9m3rsDp5ZyDx/O/74qdCrmVGh0EC3VWiI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uacKHzDEMMiMJVuDzeJk+NG3ruY9kfip6/iIl/PdDfNwU/oONiYvKlMETNE1iBVjguG7XTRXZDIkQ9cCXtyOmtqESJD//Jnj5iplIzIbD30pIHex5Vh4VWkudXsOdwuIcYQKbPJl789KXqQgMRGNU0dWyyvGGKWsnwhX+ROsE/EQFwlTVb0agZ8Yg9sxGoBIvY1S4xux7SfEOOf0hdFr3NuKqlqkWrrQQV0x9AAKEdJB5FUZz0mLvIfw5TioVUvdY9ppoIzKmIcPBQn8+nFYO+A3Kh1LPRNjrV16qwH/AVPqX8u/UqAqf1Yb3Rq6DSnbv6vb3xou3hk23STlgiyXxM0H8JQ84Lrz0VzmuFNdXbbY2p4gh8mMzyh1BfgloyYecJBUE3833XvDCvWW94fSj7q6bl0u547F2peYXYnWx07ALgANvy7TSYxy9caNKoeD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:49:12.0930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d090ba6f-8bb7-4333-be77-08debce9cf24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21454-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6DB895F6BBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 27/05/2026 15:54, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Move the E-swtich devcom component management from TC layer to ESW
> layer.
> 
> This refactoring places devcom lifecycle management at the appropriate
> layer and prepares for SD LAG which needs devcom registration
> independent of the TC/representor initialization.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 20 -------------------
>   .../mellanox/mlx5/core/eswitch_offloads.c     |  6 ++++++
>   2 files changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index a9001d1c902f..3846c16c3138 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -5394,8 +5394,6 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
>   {
>   	const size_t sz_enc_opts = sizeof(struct tunnel_match_enc_opts);
>   	u8 mapping_id[MLX5_SW_IMAGE_GUID_MAX_BYTES];
> -	struct mlx5_devcom_match_attr attr = {};
> -	struct netdev_phys_item_id ppid;
>   	struct mlx5e_rep_priv *rpriv;
>   	struct mapping_ctx *mapping;
>   	struct mlx5_eswitch *esw;
> @@ -5456,14 +5454,6 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
>   		goto err_action_counter;
>   	}
>   
> -	err = netif_get_port_parent_id(priv->netdev, &ppid, false);
> -	if (!err) {
> -		memcpy(&attr.key.buf, &ppid.id, ppid.id_len);
> -		attr.flags = MLX5_DEVCOM_MATCH_FLAGS_NS;
> -		attr.net = mlx5_core_net(esw->dev);
> -		mlx5_esw_offloads_devcom_init(esw, &attr);
> -	}
> -
>   	return 0;
>   
>   err_action_counter:
> @@ -5484,16 +5474,6 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
>   
>   void mlx5e_tc_esw_cleanup(struct mlx5_rep_uplink_priv *uplink_priv)
>   {
> -	struct mlx5e_rep_priv *rpriv;
> -	struct mlx5_eswitch *esw;
> -	struct mlx5e_priv *priv;
> -
> -	rpriv = container_of(uplink_priv, struct mlx5e_rep_priv, uplink_priv);
> -	priv = netdev_priv(rpriv->netdev);
> -	esw = priv->mdev->priv.eswitch;
> -
> -	mlx5_esw_offloads_devcom_cleanup(esw);
> -
>   	mlx5e_tc_tun_cleanup(uplink_priv->encap);
>   
>   	mapping_destroy(uplink_priv->tunnel_enc_opts_mapping);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index 189be11c4c39..d9683d3ea0e7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -3866,6 +3866,7 @@ bool mlx5_esw_offloads_controller_valid(const struct mlx5_eswitch *esw, u32 cont
>   int esw_offloads_enable(struct mlx5_eswitch *esw)
>   {
>   	u8 mapping_id[MLX5_SW_IMAGE_GUID_MAX_BYTES];
> +	struct mlx5_devcom_match_attr attr = {};
>   	struct mapping_ctx *reg_c0_obj_pool;
>   	struct mlx5_vport *vport;
>   	unsigned long i;
> @@ -3926,6 +3927,10 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
>   	if (err)
>   		goto err_vports;
>   
> +	memcpy(attr.key.buf, mapping_id, id_len);
> +	attr.flags = MLX5_DEVCOM_MATCH_FLAGS_NS;
> +	attr.net = mlx5_core_net(esw->dev);
> +	mlx5_esw_offloads_devcom_init(esw, &attr);
Sashiko.dev says:
"Does this code introduce a race condition by registering the VF representor
netdevices before the devcom component is initialized?
Because mlx5_eswitch_enable_pf_vf_vports() was called just before this 
block,
it registers the representor netdevices and emits RTM_NEWLINK events.
Userspace tools can then start asynchronously configuring the interfaces.
If userspace attempts to add a TC rule requiring peer flow programming (like
multipath or LAG) before mlx5_esw_offloads_devcom_init() completes, the 
driver
will attempt to access esw->devcom while it is still NULL. Functions like
mlx5_devcom_for_each_peer_begin() will return false, causing the TC rule
addition to fail with -ENODEV."

if devcom is NULL, is_peer_flow_needed() will return false, and
mlx5e_add_fdb_flow() will return success.


Sashiko.dev says:
"Can this unconditional devcom component initialization cause incorrect
pairing of independent devices if the system image GUID is unavailable?
Previously, netif_get_port_parent_id() would fail and safely bypass devcom
registration if the device lacked a valid hardware GUID. Now,
mlx5_query_nic_sw_system_image_guid() is called earlier in this function
and populates mapping_id and id_len.
If the device lacks a valid hardware GUID (id_len == 0), attr.key.buf will
remain filled with zeros (due to the struct initialization). Unconditionally
registering the devcom component via mlx5_esw_offloads_devcom_init()
with this all-zero key could cause multiple independent devices on the
same host to falsely pair with each other."

mlx5_query_nic_sw_system_image_guid() can only fail with -ENOMEM or
on a FW command error. In both cases mlx5 would have failed earlier
and never reached mlx5_esw_offloads_devcom_init().

>   	return 0;
>   
>   err_vports:
> @@ -3970,6 +3975,7 @@ static int esw_offloads_stop(struct mlx5_eswitch *esw,
>   
>   void esw_offloads_disable(struct mlx5_eswitch *esw)
>   {
> +	mlx5_esw_offloads_devcom_cleanup(esw);
>   	mlx5_eswitch_disable_pf_vf_vports(esw);
>   	mlx5_esw_offloads_rep_unload(esw, MLX5_VPORT_UPLINK);
>   	esw_set_passing_vport_metadata(esw, false);


