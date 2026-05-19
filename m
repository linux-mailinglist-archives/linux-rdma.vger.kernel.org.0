Return-Path: <linux-rdma+bounces-20987-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMNqBauKDGo1iwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20987-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 18:07:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 684C8581F29
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 18:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 396223157925
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79276371D10;
	Tue, 19 May 2026 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O80NOxY1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7E33A9FE;
	Tue, 19 May 2026 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205836; cv=fail; b=OVxkph5jJObKrJBal3Uzwgq0HLbEvnalLPuM8mT5Ch5wfwJsc/yMq2fA8WJIdN+7ahJeip/76NB0Cs9BC8f1LUgK20vrL3PJRjYe6gzrq4eRtIvFRIO2kiWCXcxzNYjGum8+cCGwhoJQGsgZch6Aab/DVgiqm9a7pcBLMtwrWUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205836; c=relaxed/simple;
	bh=iWIHShihCdiR+VDMPZe86G60MP0QhKRgopNFQqlSzxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T63wKSW1ofSNVD84g+Jr1ngwi1/ZRwpUndc/ytkibd4CTmKaRij4mSdNeVDM+lSrEYQAbBEFZklsl/B6Cv346Y1yTNqF63CnmUKLB+5ZtY8/ceG1vQ7yKSL6e3f9NgvU7kfUj4CPMD6iZCiZMc+sRtXMxz0tGS8yzLz9gjzAu2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O80NOxY1; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4FNnDgdrgGUqiTJoEdQA5XF5QJD1GZShsDlIWyPqqxcDb3bfBfdgppvoxl324g0b0asDlnbs1O3JGmabxFKC8qnkqwdg3jkhW19LyUjz8s5OXuRgMM27Pxb3F41SJ4Sr0MXaUA3jXJWkLzg8OyqrVnJyVIiUqH5P7gODpaYU904L70Kdn1FhHkLuU1DGZHcjHV9cCh2Wzb040NcsxLvHncAe0+yQblNTTW6a9mNQq0tRVtRuTr4y6WEbkdQw17zAKjqlul9Aswu453p2tuJS93Pv+dUSfuqprXe47bmyeSP/3dnOcz9Av0B0bltZDmryJjTegfZjaNrPwQ75bk0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkIXyLuc+NumBxqPFLdaLgJHUnV/o+l10rJjwuo+ESA=;
 b=k749J5poMJusjMUPLfZmyMZtaNewlNvizTtt63B9Ta9relyWZLTvh295HYg6puU9P29pzB+PSD23vpn2IPfQgrM4wfke6Fhczz7wrEsHOLOTFVOGssZP42AJ4bu+8rqDQrSerJwC907WKOBo+FYJSEgvBRlWDjhEmsjO0nhp8ksy4IHxv8gF4XdznGbS0lh7SRb4H0QJ7OK9NOMUrUaOZCjvNwELxVfi0ypvb1emk8B+bZzE9kLPx/cV6PylPYr6r4ht5IeQwy6UnCNopAtsG4b97/vlVismAENKYRsBVKfUi/uRuNiBqrKIJAGnDodMlzJfP2hnhfqv+4qwK5/fQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkIXyLuc+NumBxqPFLdaLgJHUnV/o+l10rJjwuo+ESA=;
 b=O80NOxY1FowRUYvZVcPakIR+PHTyFdQWnl7oUMB5DVrPvE1hdGMQp3uprPNl6XHQ0OsayRh3888+VxSnDXmvmfcihUI+VcFynhSPDlgON/okrDmbkKuyHtiJMb8XfF5oNpNPrOSWWgPM/t/XylI+6ekTcmL/qmv7id8ukgwgDnCtcYsvWpdlx/CpAz9DkRAwad8dJ1TfDuVfKuaie+moB+1kUeMQfksjyIWXLOCbc5PldVq8ksGnUdXmSn5J44keW0DNR9fMuTDOpgs7nhXXAviuZGZk2VLOBAaLrQ6kAli5KHCSxEcc/MbQdCwxMg3TxWIymMgmffjaPd3OUnmWhg==
Received: from MN0P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::31)
 by LV5PR12MB9803.namprd12.prod.outlook.com (2603:10b6:408:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 15:50:31 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::6a) by MN0P222CA0026.outlook.office365.com
 (2603:10b6:208:531::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 15:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 15:50:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 08:50:07 -0700
Received: from [10.221.212.38] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 08:50:03 -0700
Message-ID: <55bc6475-b24b-41a3-8e71-3196236fe627@nvidia.com>
Date: Tue, 19 May 2026 18:50:00 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 4/8] net/mlx5: Switch vport HCA cap helpers to
 kvzalloc
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
References: <20260518071356.345723-1-tariqt@nvidia.com>
 <20260518071356.345723-5-tariqt@nvidia.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260518071356.345723-5-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|LV5PR12MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b37934-d54c-4a91-4f9e-08deb5be5af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700016|4143699003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Q6ZOSBx/R7O8v8lHvmurWDUsU9GaEzpUAPSnBwooQxORVpos9beD/pW7OlmEa0xukGhS9yzgBP1stEzZDsAXDfm6u51MRsTUH+XDmRPxMeXFdjDKTcHx0dN+iaFCvtWq+jSmoz7UhF4IQ3Ct0PAkRdFjYuw/vegprPYrRnneVxLHMMj+XNhV0T+MvC1kbtzFMCUTWFfpeeO2LP+HsdSLE9O66luD7/XVQ1HjNDr2Po/wauycqBLR7eMemK1+NgXFc9BuvHWKQbj4XlJOAzy6g0qn/tS1fgysG6Q6zXh9Dc7Je+ZUyMohC3L2O28amy2eC8GpZnQYJ1o0iqKQ3uxXtGWGYyfyRnJCrAuaFXcFjrA67424ikBndwdPuXtErrMMi2C+ElClw2xn9ZMu+8sJhLMVIPNpzCDWZBvzlAsJE4E0ibWw2xs/jwRuhYQ4+r1eMqK9Ztc/5CnSKTg1EuSI+54EFFSeAYTitEm8M3i6+VgzcflUPisKcPz6ZeKmcjBcgefBU2b10baVImJGKLx04y+GpRfKtjmNdzCRLI8+W9Z8VyvN2jIKDnuUXi0R93Y/9+8n9Odl5x52Pk3afl8uPBvEtIv3dPfRG13kDvRX89ib6wM2b2bHXoxEapJWLJQk2vBXeZ+YI6tVqbVMaa66zV6hnQU59Y09I4YrKttq3HwcJ97taBNvxZp4ci4zQW3pBczfiGHOMGb1X6BB4DYME6R2aWxR2SDsC8aeKdEHZxA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700016)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vXgDW5mhbGSENTmSBcu+NUIVNtWJRMpHOIHHsvJpXvtA/ryI1sheSdcbyQZp7lFKct/bxZR9hhUmo7syQXopkHQYW5JthqueMXaoZ0xyxJtJ7vxaBQXfOrpJasPgz77Z3PimjuivTlT7iOYkrcs0kx53xKKz7W8+JaPnKxG8nJX1iUfIO+yz2LR3QFkGZEZzpjj3cnC4uESQFKdPpGo8V8wStOW5FQ9i5sy9NgW9yEYEf6RSqMvckjHfUjyJzv4QUVSuaavkbdFwZrl9zrQ16P9rRFr/gCvAls72ulps6wJ+UMEKI9RaEgNlIVg6XHB/CPP6HvdIuh7I0WBsZ5fc3pvyiA0H0Wncg36oUUYmjeZTGx+rDF9sV4AkZGcPoL55IMvGC8RAdz1p2bLtsTrY6qrq9ORskN3mom8odbdwcxU1w2zfu9HPZEUAX2DUm+cT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:50:30.5648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b37934-d54c-4a91-4f9e-08deb5be5af3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9803
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20987-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moshe@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 684C8581F29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/18/2026 10:13 AM, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> mlx5_vport_set_other_func_cap() and mlx5_vport_get_vhca_id() allocate
> command buffers that embed the HCA capability union, exceeding 4KiB.
> Use kvzalloc/kvfree so the allocation can fall back to vmalloc when
> contiguous memory is scarce.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/vport.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> index 4effe37fd455..f8e6b1ab7c5c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> @@ -1336,7 +1336,7 @@ int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id)
>   	if (mlx5_esw_vport_vhca_id(dev->priv.eswitch, vport, vhca_id))
>   		return 0;
>   
> -	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
> +	query_ctx = kvzalloc(query_out_sz, GFP_KERNEL);
>   	if (!query_ctx)
>   		return -ENOMEM;

Sashiko.dev says:
"
The commit message notes that these structures exceed 4KiB and are 
vulnerable to allocation failures under memory fragmentation. Are there 
other allocations of these same structures that were missed?
For instance, mlx5_core_get_caps_mode() in main.c allocates 
query_hca_cap_out with kzalloc(). Since this is on the initialization 
path for every mlx5 device (including dynamically created SR-IOV VFs), 
could this fail under fragmentation and prevent VF creation?
Other locations that still appear to use kzalloc() for these >4KiB 
structures include devlink configuration paths like 
mlx5_devlink_port_fn_migratable_set() and 
mlx5_devlink_port_fn_roce_set() in eswitch_offloads.c and eswitch.c.
Should these be converted to kvzalloc() as well to prevent similar 
allocation failures?
"

As it says, there are more places in the driver, this patch handles it 
for the vport. I will send cleanup patches for others.

>   
> @@ -1348,7 +1348,7 @@ int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id)
>   	*vhca_id = MLX5_GET(cmd_hca_cap, hca_caps, vhca_id);
>   
>   out_free:
> -	kfree(query_ctx);
> +	kvfree(query_ctx);
>   	return err;
>   }
>   EXPORT_SYMBOL_GPL(mlx5_vport_get_vhca_id);
> @@ -1363,7 +1363,7 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
>   	void *set_ctx;
>   	int ret;
>   
> -	set_ctx = kzalloc(set_sz, GFP_KERNEL);
> +	set_ctx = kvzalloc(set_sz, GFP_KERNEL);
>   	if (!set_ctx)
>   		return -ENOMEM;
>   
> @@ -1392,6 +1392,6 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
>   	MLX5_SET(set_hca_cap_in, set_ctx, function_id, function_id);
>   	ret = mlx5_cmd_exec_in(dev, set_hca_cap, set_ctx);
>   
> -	kfree(set_ctx);
> +	kvfree(set_ctx);
>   	return ret;
>   }


