Return-Path: <linux-rdma+bounces-20172-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIxGMVWy/GnlSgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20172-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:40:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCE24EB3A0
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4711A3015A41
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A188F3FCB35;
	Thu,  7 May 2026 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IXrmBlK+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53F40DFC2;
	Thu,  7 May 2026 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168396; cv=fail; b=DvYFpTlvBU7pROPqiofuJ+B1yZOWxxvSJ9W+mrASdNNJhxo0Z/44ZZ+NunISrU5L4EvDwmF1grq5Sp8zUPyiT6Z5p9pU/9Tl3WNub1qM1ys6wUrmS8rZ7FoW6zWxI89AkbGkp3M3FZ8lSD4fQ+X3OSNL+67p4FTMw9872ZptvPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168396; c=relaxed/simple;
	bh=uwCcUzlSo1dWQS69zPDY7locWep7NcJ2GPQRqGctIqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VQ55fCqInOhSw6GHmRJc63343/NemYoFANM9G8IHS4TMWm9gDS27l2qPd6JeN0lzy7yoB34yb51QmFq48PQi/fGt+m5zl/09pgG0pTg/x4RCGK3DdhUTCPywO56Lb72SI+eVbyKe0MK7ZiFsZCInJV9MJ11wx2gdJC/yMBUKN1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IXrmBlK+; arc=fail smtp.client-ip=40.93.198.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7QTuDzVLXd/1Hh+RfPRBbmsKfW/ulyNiLl82MU2ERMr80ucY+S6vWhp/pLI26bCEAtmEVnUFi4PXaDiUmoyJD4g4DSx38AUHtQqPu97Z7WTqNOSwlfZXBi95E5W8UzjqJSpPMAyGnVQNWPDZUemj0lx/q/C752pT3xf4siutlneHcx0+IpnRHOP37K+aG56kHk21SYh0oyd34kn/MIPUooHb5kExtA6LuQUxXvsXwye6LJuAL5S4ixFNshUJDCtjRHAi9hi1IfkEqdC6gExwCwAAvvBgEWCcdTokPrln2iaQdCcs9S3ve7H4q6MpOm/tNWrnqM7SftTt1X0X75hqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g/F/Rt8MW9me8jBxxiF6R6TqSktaAUtWVajoa75kOg=;
 b=QwbY5/7wV/FDe9SG+U3WWgiGweVNvciL5epp51b82GflO/9dB2nmPvhTlm/MG2MxxghyRDoxoxsoExQCtv9dLaeLe1wm+ZPNMsS2kujOhO4t3gZ47yr5Aa6R1zuYOKckim6s6RlbmF0eEIRbtlF34sF7GNegnrD5ct/jF9lvJ8+XkE1Dinfh7PpNVg2uU/sG9Komm+UBKRCpJEtfLBldW2n1Atci1R24CR7pPPySStXH21BBaL94xPvGhooy+Dz7h87xxBvHCNAdzDYT7TvD6bFUrplLqfHvob5A6NHBxlrwtAq7rGsnKAAFD5pBYAJR1XP0T9BT7HWJJlfw7//R7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g/F/Rt8MW9me8jBxxiF6R6TqSktaAUtWVajoa75kOg=;
 b=IXrmBlK+wvzzTSJ2pRzTDqUjfzlT9qVFHzFI16JF/MWdv+tB2NEHO2Eo6CO9EJ0liPMi5LRz/tCPUL1h0WCnmQ/4rsU9ZpSeAwxL9UD6u9oWj2ekkMcJwP67YXtHyobAqqUhzYyRYKGa4hoIsZS9cVipUzMxwobb9IQdZO6qBSZoRbQBb4IqdoDC0+Du/k4RadGuwcYlczvdDD+kQhh+D0SQoL5Ni12dPR1xk9Qx56ix2b1Gga5t4aoMmLhDsVnP4qrwCzalxyUW0VUM4u4u4yjnIrpK8lRBUFtawApXk9R8KYsu0XPBPSEwqRPWGHwmTlAMu4ujO0tovm7Le45I6g==
Received: from SJ0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:2c0::24)
 by CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 15:39:40 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::5a) by SJ0PR13CA0019.outlook.office365.com
 (2603:10b6:a03:2c0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.9 via Frontend Transport; Thu, 7
 May 2026 15:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:39:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 08:39:12 -0700
Received: from [10.242.157.67] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 08:39:07 -0700
Message-ID: <b9ec4ca2-2bbd-4b2a-bff1-99501738c9eb@nvidia.com>
Date: Thu, 7 May 2026 18:39:04 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 3/3] net/mlx5: Add VHCA_ID page management
 mode support
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <20260506133239.276237-1-tariqt@nvidia.com>
 <20260506133239.276237-4-tariqt@nvidia.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260506133239.276237-4-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CY3PR12MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcf3ea4-983b-40af-475b-08deac4eda40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZaoEHcefAFZGPWRyxOywcMKUpTOA5ZXbSi6eZtLE6n5/hm6YmO7+YVtG3SU461x0RLj+1Ef5BrH9lu+/p60Fg7VZj4IVfKcRQOVSoXHiGb2FEiceLsIDODrj/HPCIU2LNXQdOM28Tbhsv/XgVr8PgUUCwiMatMoA45s+U7QWXyvJ8JrjTUETJcFNiTR+VaKapTxWTzHZXxMhF1RcacSQcJV2qd+yE5TUvfSXpu3ALOB8JMRqtUwdTV5M1/CbqqIHZcUVxy+pzEYjsJbJJpztuQq7GvDCkoprRP4fUCI/YlShSFFeMPbDv46lcg3Gl0e04BlG4+hwoRjT3PRgC4gdGRL3r5Zgdavduw1nLc0Stn7fELWA1GpXPguctNzcXm9McCv4hKzaInY/0WGQoergapv3CWMIuBeChn8ZHpbKN94RKNxZHuIHbz3YusLjeTz+Z3lAyk5F+tg3s1DL/jVvXUYrYH88kwHUxbKHLbezuuzmsn5gD1fZfoWm0fIZPfV0MwfyiUPc6PIIwJ31nIKxj7MzgYnRsWdTPbbLY82P16KQxAuF0j12bL3S4eof5OU/2nlJiIZovHHnO2bT/qXYirJwIukiq1hQg1OBVQ/h5xxKFPPYwSPn45xN+FxHD5xJcEk8VOJxm+JjDVomOysDLZsjPOUnckgeXD5J1O+jd5Tcqw/Q4PKtUVPuYVHpPwmpMpxalBbHpyEtZlKTAmyFQM5GD9yeEa9SZrRAoqCrjUI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(3023799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HcgWweKMEgTNKkTN24zS12dV22n2AiRe5B4snLRQPU+2XgUSTbX/bohjf27gN/OngxQ1Aem1RCke/e8UwtluM8E3JXt/yedKoZRGv6zuAkXGNJbeVs0aAnNFkfKRnlVmDhBz1S/W1uks2boBUM4bmwQ+zCnEqudLPf6TpfDz+Mc4ztc1h6i4tODoHsYGHf9i5eAYRHMLH/nPNqakC9mrZyijk+CayQWAnx2Va2QF9hqbhU2HTowCqcxSpJMJVnd50XvVhbXwGCSSR/Fpn+rjJuu/mtwjp7W5wZlQP1qaxqGyGuaZnSTEglZPHKWFRsu6kH5lV5htbQTWdqlS9dae8zV5WobFKG1GpWXUD76ScoxCE62Wpvz954UsB1oEx4wlJZKxSiO5rzMhI4BkipuVKfAg1lqhBSlZefspJ7ZnU4uv7ztVzoizg8Qt2r5MQn8U
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:39:40.1982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcf3ea4-983b-40af-475b-08deac4eda40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677
X-Rspamd-Queue-Id: 3CCE24EB3A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-20172-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moshe@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action



On 5/6/2026 4:32 PM, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Add support for VHCA_ID-based page management mode. When the device
> firmware advertises the icm_mng_function_id_mode capability with
> MLX5_ID_MODE_FUNCTION_VHCA_ID, page management operations between the
> driver and firmware may use vhca_id instead of function_id as the
> effective function identifier, and the ec_function field is ignored.
> 
> Update page management commands to conditionally set ec_function field
> only in FUNC_ID mode. Boot page allocation always uses FUNC_ID mode
> semantics for backward compatibility, as the capability bit is only
> available after set_hca_cap(). If after set_hca_cap() VHCA_ID mode was
> set, modify the tracking of the boot pages in page_root_xa to use
> vhca_id too.
> 
> Add mlx5_esw_vhca_id_to_func_type() to resolve the function type in
> VHCA_ID mode, enabling per-type debugfs counters. Use a dedicated
> vhca_type_map xarray, to provide lockless lookup. Store the resolved
> type on each fw_page at allocation time so reclaim and release paths
> read it directly without any lookup.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Akiva Goldberger <agoldberger@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/eswitch.c |  45 +++-
>   .../net/ethernet/mellanox/mlx5/core/eswitch.h |   8 +
>   .../net/ethernet/mellanox/mlx5/core/main.c    |   3 +
>   .../ethernet/mellanox/mlx5/core/pagealloc.c   | 250 +++++++++++++-----
>   include/linux/mlx5/driver.h                   |   7 +
>   5 files changed, 251 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index e0eafcf0c52a..125129ef43e3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> @@ -852,6 +852,38 @@ bool mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
>   	return true;
>   }
>   
> +static enum mlx5_func_type
> +esw_vport_to_func_type(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
> +{
> +	u16 vport_num = vport->vport;
> +
> +	if (vport_num == MLX5_VPORT_HOST_PF)
> +		return MLX5_HOST_PF;
> +	if (xa_get_mark(&esw->vports, vport_num, MLX5_ESW_VPT_SF))
> +		return MLX5_SF;
> +	if (xa_get_mark(&esw->vports, vport_num, MLX5_ESW_VPT_VF))
> +		return MLX5_VF;
> +	return MLX5_EC_VF;
> +}
> +
> +u16 mlx5_esw_vhca_id_to_func_type(struct mlx5_core_dev *dev, u16 vhca_id)
> +{
> +	struct mlx5_eswitch *esw = dev->priv.eswitch;
> +	void *entry;
> +
> +	if (vhca_id == MLX5_CAP_GEN(dev, vhca_id))
> +		return MLX5_SELF;
> +
> +	if (!esw)
> +		return MLX5_FUNC_TYPE_NONE;
> +
> +	entry = xa_load(&esw->vhca_type_map, vhca_id);
> +	if (entry)
> +		return xa_to_value(entry);
> +
> +	return MLX5_FUNC_TYPE_NONE;
> +}
> +
>   static int esw_vport_setup(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
>   {
>   	bool vst_mode_steering = esw_vst_mode_is_steering(esw);
> @@ -942,6 +974,11 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
>   		ret = mlx5_esw_vport_vhca_id_map(esw, vport);
>   		if (ret)
>   			goto err_vhca_mapping;
> +		ret = xa_insert(&esw->vhca_type_map, vport->vhca_id,
> +				xa_mk_value(esw_vport_to_func_type(esw, vport)),
> +				GFP_KERNEL);
> +		if (ret)
> +			goto err_type_map;

Sashiko says:
"
If xa_insert() fails here, the error path goes to err_type_map but does
not appear to revert vport->enabled or the increment of
esw->enabled_ipsec_vf_count that occurred earlier in the function.
Since esw->enabled_vports is only incremented on success, could this leave
the vport in an inconsistent state? A later call to
mlx5_esw_vport_disable() might see vport->enabled as true and decrement
esw->enabled_vports, potentially causing an integer underflow.
"

The same inconsistency existed before this patch with the 
err_vhca_mapping path for the mlx5_esw_vport_vhca_id_map() failure.
So it will be addressed in a separate fix patch.

- Moshe

>   	}
>   
>   	esw_vport_change_handle_locked(vport);
> @@ -952,6 +989,8 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
>   	mutex_unlock(&esw->state_lock);
>   	return ret;
>   
> +err_type_map:
> +	mlx5_esw_vport_vhca_id_unmap(esw, vport);
>   err_vhca_mapping:
>   	esw_vport_cleanup(esw, vport);
>   	mutex_unlock(&esw->state_lock);
> @@ -976,8 +1015,10 @@ void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
>   		arm_vport_context_events_cmd(esw->dev, vport_num, 0);
>   
>   	if (!mlx5_esw_is_manager_vport(esw, vport_num) &&
> -	    MLX5_CAP_GEN(esw->dev, vport_group_manager))
> +	    MLX5_CAP_GEN(esw->dev, vport_group_manager)) {
> +		xa_erase(&esw->vhca_type_map, vport->vhca_id);
>   		mlx5_esw_vport_vhca_id_unmap(esw, vport);
> +	}
>   
>   	if (vport->vport != MLX5_VPORT_HOST_PF &&
>   	    (vport->info.ipsec_crypto_enabled || vport->info.ipsec_packet_enabled))
> @@ -2084,6 +2125,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
>   	atomic64_set(&esw->offloads.num_flows, 0);
>   	ida_init(&esw->offloads.vport_metadata_ida);
>   	xa_init_flags(&esw->offloads.vhca_map, XA_FLAGS_ALLOC);
> +	xa_init(&esw->vhca_type_map);
>   	mutex_init(&esw->state_lock);
>   	init_rwsem(&esw->mode_lock);
>   	refcount_set(&esw->qos.refcnt, 0);
> @@ -2133,6 +2175,7 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
>   	mutex_destroy(&esw->state_lock);
>   	WARN_ON(!xa_empty(&esw->offloads.vhca_map));
>   	xa_destroy(&esw->offloads.vhca_map);
> +	xa_destroy(&esw->vhca_type_map);
>   	ida_destroy(&esw->offloads.vport_metadata_ida);
>   	mlx5e_mod_hdr_tbl_destroy(&esw->offloads.mod_hdr);
>   	mutex_destroy(&esw->offloads.encap_tbl_lock);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index 2fd601bd102f..b06d097824ad 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -373,6 +373,7 @@ struct mlx5_eswitch {
>   	struct dentry *debugfs_root;
>   	struct workqueue_struct *work_queue;
>   	struct xarray vports;
> +	struct xarray vhca_type_map;
>   	u32 flags;
>   	int                     total_vports;
>   	int                     enabled_vports;
> @@ -863,6 +864,7 @@ void mlx5_esw_vport_vhca_id_unmap(struct mlx5_eswitch *esw,
>   				  struct mlx5_vport *vport);
>   int mlx5_eswitch_vhca_id_to_vport(struct mlx5_eswitch *esw, u16 vhca_id, u16 *vport_num);
>   bool mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id);
> +u16 mlx5_esw_vhca_id_to_func_type(struct mlx5_core_dev *dev, u16 vhca_id);
>   
>   void mlx5_esw_offloads_rep_remove(struct mlx5_eswitch *esw,
>   				  const struct mlx5_vport *vport);
> @@ -1034,6 +1036,12 @@ mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
>   	return false;
>   }
>   
> +static inline u16
> +mlx5_esw_vhca_id_to_func_type(struct mlx5_core_dev *dev, u16 vhca_id)
> +{
> +	return MLX5_FUNC_TYPE_NONE;
> +}
> +
>   static inline void
>   mlx5_eswitch_safe_aux_devs_remove(struct mlx5_core_dev *dev) {}
>   static inline struct mlx5_flow_handle *
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 0c1c906b60fa..296c5223cf61 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -597,6 +597,9 @@ static int handle_hca_cap(struct mlx5_core_dev *dev, void *set_ctx)
>   	if (MLX5_CAP_GEN_MAX(dev, release_all_pages))
>   		MLX5_SET(cmd_hca_cap, set_hca_cap, release_all_pages, 1);
>   
> +	if (MLX5_CAP_GEN_MAX(dev, icm_mng_function_id_mode))
> +		MLX5_SET(cmd_hca_cap, set_hca_cap, icm_mng_function_id_mode, 1);
> +
>   	if (MLX5_CAP_GEN_MAX(dev, mkey_by_name))
>   		MLX5_SET(cmd_hca_cap, set_hca_cap, mkey_by_name, 1);
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> index 77ffa31cc505..ce2f7fa9bd48 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> @@ -38,6 +38,7 @@
>   #include "mlx5_core.h"
>   #include "lib/eq.h"
>   #include "lib/tout.h"
> +#include "eswitch.h"
>   
>   enum {
>   	MLX5_PAGES_CANT_GIVE	= 0,
> @@ -59,6 +60,7 @@ struct fw_page {
>   	u64			addr;
>   	struct page	       *page;
>   	u32			function;
> +	u16			func_type;
>   	unsigned long		bitmask;
>   	struct list_head	list;
>   	unsigned int free_count;
> @@ -69,9 +71,24 @@ enum {
>   	MLX5_NUM_4K_IN_PAGE		= PAGE_SIZE / MLX5_ADAPTER_PAGE_SIZE,
>   };
>   
> -static u32 get_function(u16 func_id, bool ec_function)
> +static bool mlx5_page_mgt_mode_is_vhca_id(const struct mlx5_core_dev *dev)
>   {
> -	return (u32)func_id | (ec_function << 16);
> +	return dev->priv.page_mgt_mode == MLX5_PAGE_MGT_MODE_VHCA_ID;
> +}
> +
> +static void mlx5_page_mgt_mode_set(struct mlx5_core_dev *dev,
> +				   enum mlx5_page_mgt_mode mode)
> +{
> +	dev->priv.page_mgt_mode = mode;
> +}
> +
> +static u32 get_function_key(struct mlx5_core_dev *dev, u16 func_vhca_id,
> +			    bool ec_function)
> +{
> +	if (mlx5_page_mgt_mode_is_vhca_id(dev))
> +		return (u32)func_vhca_id;
> +
> +	return (u32)func_vhca_id | (ec_function << 16);
>   }
>   
>   static u16 func_id_to_type(struct mlx5_core_dev *dev, u16 func_id, bool ec_function)
> @@ -89,12 +106,21 @@ static u16 func_id_to_type(struct mlx5_core_dev *dev, u16 func_id, bool ec_funct
>   	return MLX5_SF;
>   }
>   
> +static u16 func_vhca_id_to_type(struct mlx5_core_dev *dev, u16 func_vhca_id,
> +				bool ec_function)
> +{
> +	if (mlx5_page_mgt_mode_is_vhca_id(dev))
> +		return mlx5_esw_vhca_id_to_func_type(dev, func_vhca_id);
> +
> +	return func_id_to_type(dev, func_vhca_id, ec_function);
> +}
> +
>   static u32 mlx5_get_ec_function(u32 function)
>   {
>   	return function >> 16;
>   }
>   
> -static u32 mlx5_get_func_id(u32 function)
> +static u32 mlx5_get_func_vhca_id(u32 function)
>   {
>   	return function & 0xffff;
>   }
> @@ -123,7 +149,8 @@ static struct rb_root *page_root_per_function(struct mlx5_core_dev *dev, u32 fun
>   	return root;
>   }
>   
> -static int insert_page(struct mlx5_core_dev *dev, u64 addr, struct page *page, u32 function)
> +static int insert_page(struct mlx5_core_dev *dev, u64 addr, struct page *page,
> +		       u32 function, u16 func_type)
>   {
>   	struct rb_node *parent = NULL;
>   	struct rb_root *root;
> @@ -156,6 +183,7 @@ static int insert_page(struct mlx5_core_dev *dev, u64 addr, struct page *page, u
>   	nfp->addr = addr;
>   	nfp->page = page;
>   	nfp->function = function;
> +	nfp->func_type = func_type;
>   	nfp->free_count = MLX5_NUM_4K_IN_PAGE;
>   	for (i = 0; i < MLX5_NUM_4K_IN_PAGE; i++)
>   		set_bit(i, &nfp->bitmask);
> @@ -196,7 +224,7 @@ static struct fw_page *find_fw_page(struct mlx5_core_dev *dev, u64 addr,
>   	return result;
>   }
>   
> -static int mlx5_cmd_query_pages(struct mlx5_core_dev *dev, u16 *func_id,
> +static int mlx5_cmd_query_pages(struct mlx5_core_dev *dev, u16 *func_vhca_id,
>   				s32 *npages, int boot)
>   {
>   	u32 out[MLX5_ST_SZ_DW(query_pages_out)] = {};
> @@ -207,14 +235,20 @@ static int mlx5_cmd_query_pages(struct mlx5_core_dev *dev, u16 *func_id,
>   	MLX5_SET(query_pages_in, in, op_mod, boot ?
>   		 MLX5_QUERY_PAGES_IN_OP_MOD_BOOT_PAGES :
>   		 MLX5_QUERY_PAGES_IN_OP_MOD_INIT_PAGES);
> -	MLX5_SET(query_pages_in, in, embedded_cpu_function, mlx5_core_is_ecpf(dev));
> +
> +	if (mlx5_page_mgt_mode_is_vhca_id(dev))
> +		MLX5_SET(query_pages_in, in, function_id,
> +			 MLX5_CAP_GEN(dev, vhca_id));
> +	else
> +		MLX5_SET(query_pages_in, in, embedded_cpu_function,
> +			 mlx5_core_is_ecpf(dev));
>   
>   	err = mlx5_cmd_exec_inout(dev, query_pages, in, out);
>   	if (err)
>   		return err;
>   
>   	*npages = MLX5_GET(query_pages_out, out, num_pages);
> -	*func_id = MLX5_GET(query_pages_out, out, function_id);
> +	*func_vhca_id = MLX5_GET(query_pages_out, out, function_id);
>   
>   	return err;
>   }
> @@ -245,6 +279,10 @@ static int alloc_4k(struct mlx5_core_dev *dev, u64 *addr, u32 function)
>   	if (!fp->free_count)
>   		list_del(&fp->list);
>   
> +	if (fp->func_type != MLX5_FUNC_TYPE_NONE)
> +		dev->priv.page_counters[fp->func_type]++;
> +	dev->priv.fw_pages++;
> +
>   	*addr = fp->addr + n * MLX5_ADAPTER_PAGE_SIZE;
>   
>   	return 0;
> @@ -280,6 +318,11 @@ static void free_4k(struct mlx5_core_dev *dev, u64 addr, u32 function)
>   		mlx5_core_warn_rl(dev, "page not found\n");
>   		return;
>   	}
> +
> +	if (fwp->func_type != MLX5_FUNC_TYPE_NONE)
> +		dev->priv.page_counters[fwp->func_type]--;
> +	dev->priv.fw_pages--;
> +
>   	n = (addr & ~MLX5_U64_4K_PAGE_MASK) >> MLX5_ADAPTER_PAGE_SHIFT;
>   	fwp->free_count++;
>   	set_bit(n, &fwp->bitmask);
> @@ -289,7 +332,8 @@ static void free_4k(struct mlx5_core_dev *dev, u64 addr, u32 function)
>   		list_add(&fwp->list, &dev->priv.free_list);
>   }
>   
> -static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
> +static int alloc_system_page(struct mlx5_core_dev *dev, u32 function,
> +			     u16 func_type)
>   {
>   	struct device *device = mlx5_core_dma_dev(dev);
>   	int nid = dev->priv.numa_node;
> @@ -317,7 +361,7 @@ static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
>   		goto map;
>   	}
>   
> -	err = insert_page(dev, addr, page, function);
> +	err = insert_page(dev, addr, page, function, func_type);
>   	if (err) {
>   		mlx5_core_err(dev, "failed to track allocated page\n");
>   		dma_unmap_page(device, addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
> @@ -334,7 +378,7 @@ static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
>   	return err;
>   }
>   
> -static void page_notify_fail(struct mlx5_core_dev *dev, u16 func_id,
> +static void page_notify_fail(struct mlx5_core_dev *dev, u16 func_vhca_id,
>   			     bool ec_function)
>   {
>   	u32 in[MLX5_ST_SZ_DW(manage_pages_in)] = {};
> @@ -342,19 +386,23 @@ static void page_notify_fail(struct mlx5_core_dev *dev, u16 func_id,
>   
>   	MLX5_SET(manage_pages_in, in, opcode, MLX5_CMD_OP_MANAGE_PAGES);
>   	MLX5_SET(manage_pages_in, in, op_mod, MLX5_PAGES_CANT_GIVE);
> -	MLX5_SET(manage_pages_in, in, function_id, func_id);
> -	MLX5_SET(manage_pages_in, in, embedded_cpu_function, ec_function);
> +	MLX5_SET(manage_pages_in, in, function_id, func_vhca_id);
> +
> +	if (!mlx5_page_mgt_mode_is_vhca_id(dev))
> +		MLX5_SET(manage_pages_in, in, embedded_cpu_function,
> +			 ec_function);
>   
>   	err = mlx5_cmd_exec_in(dev, manage_pages, in);
>   	if (err)
> -		mlx5_core_warn(dev, "page notify failed func_id(%d) err(%d)\n",
> -			       func_id, err);
> +		mlx5_core_warn(dev,
> +			       "page notify failed func_vhca_id(%d) err(%d)\n",
> +			       func_vhca_id, err);
>   }
>   
> -static int give_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
> +static int give_pages(struct mlx5_core_dev *dev, u16 func_vhca_id, int npages,
>   		      int event, bool ec_function)
>   {
> -	u32 function = get_function(func_id, ec_function);
> +	u32 function = get_function_key(dev, func_vhca_id, ec_function);
>   	u32 out[MLX5_ST_SZ_DW(manage_pages_out)] = {0};
>   	int inlen = MLX5_ST_SZ_BYTES(manage_pages_in);
>   	int notify_fail = event;
> @@ -364,6 +412,8 @@ static int give_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
>   	u32 *in;
>   	int i;
>   
> +	func_type = func_vhca_id_to_type(dev, func_vhca_id, ec_function);
> +
>   	inlen += npages * MLX5_FLD_SZ_BYTES(manage_pages_in, pas[0]);
>   	in = kvzalloc(inlen, GFP_KERNEL);
>   	if (!in) {
> @@ -377,7 +427,8 @@ static int give_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
>   		err = alloc_4k(dev, &addr, function);
>   		if (err) {
>   			if (err == -ENOMEM)
> -				err = alloc_system_page(dev, function);
> +				err = alloc_system_page(dev, function,
> +							func_type);
>   			if (err) {
>   				dev->priv.fw_pages_alloc_failed += (npages - i);
>   				goto out_4k;
> @@ -390,9 +441,12 @@ static int give_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
>   
>   	MLX5_SET(manage_pages_in, in, opcode, MLX5_CMD_OP_MANAGE_PAGES);
>   	MLX5_SET(manage_pages_in, in, op_mod, MLX5_PAGES_GIVE);
> -	MLX5_SET(manage_pages_in, in, function_id, func_id);
> +	MLX5_SET(manage_pages_in, in, function_id, func_vhca_id);
>   	MLX5_SET(manage_pages_in, in, input_num_entries, npages);
> -	MLX5_SET(manage_pages_in, in, embedded_cpu_function, ec_function);
> +
> +	if (!mlx5_page_mgt_mode_is_vhca_id(dev))
> +		MLX5_SET(manage_pages_in, in, embedded_cpu_function,
> +			 ec_function);
>   
>   	err = mlx5_cmd_do(dev, in, inlen, out, sizeof(out));
>   	if (err == -EREMOTEIO) {
> @@ -405,17 +459,15 @@ static int give_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
>   	}
>   	err = mlx5_cmd_check(dev, err, in, out);
>   	if (err) {
> -		mlx5_core_warn(dev, "func_id 0x%x, npages %d, err %d\n",
> -			       func_id, npages, err);
> +		mlx5_core_warn(dev, "func_vhca_id 0x%x, npages %d, err %d\n",
> +			       func_vhca_id, npages, err);
>   		goto out_dropped;
>   	}
>   
> -	func_type = func_id_to_type(dev, func_id, ec_function);
> -	dev->priv.page_counters[func_type] += npages;
> -	dev->priv.fw_pages += npages;
> -
> -	mlx5_core_dbg(dev, "npages %d, ec_function %d, func_id 0x%x, err %d\n",
> -		      npages, ec_function, func_id, err);
> +	mlx5_core_dbg(dev,
> +		      "npages %d, ec_function %d, func 0x%x, mode %d, err %d\n",
> +		      npages, ec_function, func_vhca_id,
> +		      mlx5_page_mgt_mode_is_vhca_id(dev), err);
>   
>   	kvfree(in);
>   	return 0;
> @@ -428,18 +480,17 @@ static int give_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
>   out_free:
>   	kvfree(in);
>   	if (notify_fail)
> -		page_notify_fail(dev, func_id, ec_function);
> +		page_notify_fail(dev, func_vhca_id, ec_function);
>   	return err;
>   }
>   
> -static void release_all_pages(struct mlx5_core_dev *dev, u16 func_id,
> +static void release_all_pages(struct mlx5_core_dev *dev, u16 func_vhca_id,
>   			      bool ec_function)
>   {
> -	u32 function = get_function(func_id, ec_function);
> +	u32 function = get_function_key(dev, func_vhca_id, ec_function);
>   	struct rb_root *root;
>   	struct rb_node *p;
>   	int npages = 0;
> -	u16 func_type;
>   
>   	root = xa_load(&dev->priv.page_root_xa, function);
>   	if (WARN_ON_ONCE(!root))
> @@ -448,18 +499,20 @@ static void release_all_pages(struct mlx5_core_dev *dev, u16 func_id,
>   	p = rb_first(root);
>   	while (p) {
>   		struct fw_page *fwp = rb_entry(p, struct fw_page, rb_node);
> +		int used = MLX5_NUM_4K_IN_PAGE - fwp->free_count;
>   
>   		p = rb_next(p);
> -		npages += (MLX5_NUM_4K_IN_PAGE - fwp->free_count);
> +		npages += used;
> +		if (fwp->func_type != MLX5_FUNC_TYPE_NONE)
> +			dev->priv.page_counters[fwp->func_type] -= used;
>   		free_fwp(dev, fwp, fwp->free_count);
>   	}
>   
> -	func_type = func_id_to_type(dev, func_id, ec_function);
> -	dev->priv.page_counters[func_type] -= npages;
>   	dev->priv.fw_pages -= npages;
>   
> -	mlx5_core_dbg(dev, "npages %d, ec_function %d, func_id 0x%x\n",
> -		      npages, ec_function, func_id);
> +	mlx5_core_dbg(dev, "npages %d, ec_function %d, func 0x%x, mode %d\n",
> +		      npages, ec_function, func_vhca_id,
> +		      mlx5_page_mgt_mode_is_vhca_id(dev));
>   }
>   
>   static u32 fwp_fill_manage_pages_out(struct fw_page *fwp, u32 *out, u32 index,
> @@ -487,7 +540,7 @@ static int reclaim_pages_cmd(struct mlx5_core_dev *dev,
>   	struct fw_page *fwp;
>   	struct rb_node *p;
>   	bool ec_function;
> -	u32 func_id;
> +	u32 func_vhca_id;
>   	u32 npages;
>   	u32 i = 0;
>   	int err;
> @@ -499,10 +552,11 @@ static int reclaim_pages_cmd(struct mlx5_core_dev *dev,
>   
>   	/* No hard feelings, we want our pages back! */
>   	npages = MLX5_GET(manage_pages_in, in, input_num_entries);
> -	func_id = MLX5_GET(manage_pages_in, in, function_id);
> +	func_vhca_id = MLX5_GET(manage_pages_in, in, function_id);
>   	ec_function = MLX5_GET(manage_pages_in, in, embedded_cpu_function);
>   
> -	root = xa_load(&dev->priv.page_root_xa, get_function(func_id, ec_function));
> +	root = xa_load(&dev->priv.page_root_xa,
> +		       get_function_key(dev, func_vhca_id, ec_function));
>   	if (WARN_ON_ONCE(!root))
>   		return -EEXIST;
>   
> @@ -518,14 +572,14 @@ static int reclaim_pages_cmd(struct mlx5_core_dev *dev,
>   	return 0;
>   }
>   
> -static int reclaim_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
> -			 int *nclaimed, bool event, bool ec_function)
> +static int reclaim_pages(struct mlx5_core_dev *dev, u16 func_vhca_id,
> +			 int npages, int *nclaimed, bool event,
> +			 bool ec_function)
>   {
> -	u32 function = get_function(func_id, ec_function);
> +	u32 function = get_function_key(dev, func_vhca_id, ec_function);
>   	int outlen = MLX5_ST_SZ_BYTES(manage_pages_out);
>   	u32 in[MLX5_ST_SZ_DW(manage_pages_in)] = {};
>   	int num_claimed;
> -	u16 func_type;
>   	u32 *out;
>   	int err;
>   	int i;
> @@ -540,12 +594,16 @@ static int reclaim_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
>   
>   	MLX5_SET(manage_pages_in, in, opcode, MLX5_CMD_OP_MANAGE_PAGES);
>   	MLX5_SET(manage_pages_in, in, op_mod, MLX5_PAGES_TAKE);
> -	MLX5_SET(manage_pages_in, in, function_id, func_id);
> +	MLX5_SET(manage_pages_in, in, function_id, func_vhca_id);
>   	MLX5_SET(manage_pages_in, in, input_num_entries, npages);
> -	MLX5_SET(manage_pages_in, in, embedded_cpu_function, ec_function);
>   
> -	mlx5_core_dbg(dev, "func 0x%x, npages %d, outlen %d\n",
> -		      func_id, npages, outlen);
> +	if (!mlx5_page_mgt_mode_is_vhca_id(dev))
> +		MLX5_SET(manage_pages_in, in, embedded_cpu_function,
> +			 ec_function);
> +
> +	mlx5_core_dbg(dev, "func 0x%x, npages %d, outlen %d mode %d\n",
> +		      func_vhca_id, npages, outlen,
> +		      mlx5_page_mgt_mode_is_vhca_id(dev));
>   	err = reclaim_pages_cmd(dev, in, sizeof(in), out, outlen);
>   	if (err) {
>   		npages = MLX5_GET(manage_pages_in, in, input_num_entries);
> @@ -577,10 +635,6 @@ static int reclaim_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
>   	if (nclaimed)
>   		*nclaimed = num_claimed;
>   
> -	func_type = func_id_to_type(dev, func_id, ec_function);
> -	dev->priv.page_counters[func_type] -= num_claimed;
> -	dev->priv.fw_pages -= num_claimed;
> -
>   out_free:
>   	kvfree(out);
>   	return err;
> @@ -658,30 +712,102 @@ static int req_pages_handler(struct notifier_block *nb,
>   	 * req->npages (and not min ()).
>   	 */
>   	req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
> -	req->ec_function = ec_function;
> +	if (!mlx5_page_mgt_mode_is_vhca_id(dev))
> +		req->ec_function = ec_function;
>   	req->release_all = release_all;
>   	INIT_WORK(&req->work, pages_work_handler);
>   	queue_work(dev->priv.pg_wq, &req->work);
>   	return NOTIFY_OK;
>   }
>   
> +/*
> + * After set_hca_cap(), the second satisfy_startup_pages(dev, 0) may see
> + * VHCA_ID mode. If page_root_xa already has the PF entry from the first
> + * (boot) call under FUNC_ID keys 0 or (ec_function << 16), migrate that
> + * entry to the device vhca_id key so lookups use VHCA_ID semantics.
> + */
> +static int mlx5_pagealloc_migrate_pf_to_vhca_id(struct mlx5_core_dev *dev)
> +{
> +	u32 vhca_id_key, old_key;
> +	struct rb_root *root;
> +	struct fw_page *fwp;
> +	struct rb_node *p;
> +	bool ec_function;
> +	int err;
> +
> +	if (xa_empty(&dev->priv.page_root_xa))
> +		return 0;
> +
> +	vhca_id_key = MLX5_CAP_GEN(dev, vhca_id);
> +	ec_function = mlx5_core_is_ecpf(dev);
> +
> +	old_key = ec_function ? (1U << 16) : 0;
> +	root = xa_load(&dev->priv.page_root_xa, old_key);
> +	if (!root)
> +		return 0;
> +
> +	if (old_key == vhca_id_key)
> +		return 0;
> +
> +	err = xa_insert(&dev->priv.page_root_xa, vhca_id_key, root, GFP_KERNEL);
> +	if (err) {
> +		mlx5_core_warn(dev,
> +			       "failed to migrate page root key 0x%x to vhca_id 0x%x\n",
> +			       old_key, vhca_id_key);
> +		return err;
> +	}
> +
> +	for (p = rb_first(root); p; p = rb_next(p)) {
> +		fwp = rb_entry(p, struct fw_page, rb_node);
> +		fwp->function = vhca_id_key;
> +	}
> +
> +	xa_erase(&dev->priv.page_root_xa, old_key);
> +
> +	return 0;
> +}
> +
>   int mlx5_satisfy_startup_pages(struct mlx5_core_dev *dev, int boot)
>   {
> -	u16 func_id;
> +	bool ec_function = false;
> +	u16 func_vhca_id;
>   	s32 npages;
>   	int err;
>   
> -	err = mlx5_cmd_query_pages(dev, &func_id, &npages, boot);
> +	/* Boot pages are requested before set_hca_cap(), so the capability
> +	 * is not negotiated yet; use FUNC_ID mode for backward compatibility.
> +	 * Init pages are requested after set_hca_cap(), which unconditionally
> +	 * enables CAP_GEN_MAX. Current caps are not re-queried at this point,
> +	 * so check CAP_GEN_MAX directly.
> +	 */
> +	if (boot) {
> +		mlx5_page_mgt_mode_set(dev, MLX5_PAGE_MGT_MODE_FUNC_ID);
> +	} else {
> +		if (MLX5_CAP_GEN_MAX(dev, icm_mng_function_id_mode) ==
> +		    MLX5_ID_MODE_FUNCTION_VHCA_ID) {
> +			err = mlx5_pagealloc_migrate_pf_to_vhca_id(dev);
> +			if (err)
> +				return err;
> +			mlx5_page_mgt_mode_set(dev, MLX5_PAGE_MGT_MODE_VHCA_ID);
> +		}
> +	}
> +
> +	err = mlx5_cmd_query_pages(dev, &func_vhca_id, &npages, boot);
>   	if (err)
>   		return err;
>   
> -	mlx5_core_dbg(dev, "requested %d %s pages for func_id 0x%x\n",
> -		      npages, boot ? "boot" : "init", func_id);
> +	mlx5_core_dbg(dev,
> +		      "requested %d %s pages for func_vhca_id 0x%x\n",
> +		      npages, boot ? "boot" : "init", func_vhca_id);
>   
>   	if (!npages)
>   		return 0;
>   
> -	return give_pages(dev, func_id, npages, 0, mlx5_core_is_ecpf(dev));
> +	/* In VHCA_ID mode, ec_function remains false (not used). */
> +	if (!mlx5_page_mgt_mode_is_vhca_id(dev))
> +		ec_function = mlx5_core_is_ecpf(dev);
> +
> +	return give_pages(dev, func_vhca_id, npages, 0, ec_function);
>   }
>   
>   enum {
> @@ -709,15 +835,17 @@ static int mlx5_reclaim_root_pages(struct mlx5_core_dev *dev,
>   
>   	while (!RB_EMPTY_ROOT(root)) {
>   		u32 ec_function = mlx5_get_ec_function(function);
> -		u32 function_id = mlx5_get_func_id(function);
> +		u32 func_vhca_id = mlx5_get_func_vhca_id(function);
>   		int nclaimed;
>   		int err;
>   
> -		err = reclaim_pages(dev, function_id, optimal_reclaimed_pages(),
> +		err = reclaim_pages(dev, func_vhca_id,
> +				    optimal_reclaimed_pages(),
>   				    &nclaimed, false, ec_function);
>   		if (err) {
> -			mlx5_core_warn(dev, "reclaim_pages err (%d) func_id=0x%x ec_func=0x%x\n",
> -				       err, function_id, ec_function);
> +			mlx5_core_warn(dev,
> +				       "reclaim_pages err (%d) func_vhca_id=0x%x ec_func=0x%x\n",
> +				       err, func_vhca_id, ec_function);
>   			return err;
>   		}
>   
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index d1751c5d01c7..8b4d384125d1 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -558,6 +558,12 @@ enum mlx5_func_type {
>   	MLX5_HOST_PF,
>   	MLX5_EC_VF,
>   	MLX5_FUNC_TYPE_NUM,
> +	MLX5_FUNC_TYPE_NONE = MLX5_FUNC_TYPE_NUM,
> +};
> +
> +enum mlx5_page_mgt_mode {
> +	MLX5_PAGE_MGT_MODE_FUNC_ID,
> +	MLX5_PAGE_MGT_MODE_VHCA_ID,
>   };
>   
>   struct mlx5_frag_buf_node_pools;
> @@ -578,6 +584,7 @@ struct mlx5_priv {
>   	u32			fw_pages_alloc_failed;
>   	u32			give_pages_dropped;
>   	u32			reclaim_pages_discard;
> +	enum mlx5_page_mgt_mode	page_mgt_mode;
>   
>   	struct mlx5_core_health health;
>   	struct list_head	traps;


