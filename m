Return-Path: <linux-rdma+bounces-20771-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEMfBVgOB2oLrAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20771-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 14:15:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC7954F494
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 14:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BCD130D198A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD75481220;
	Fri, 15 May 2026 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IeZ6kBXM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B42F480341;
	Fri, 15 May 2026 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846385; cv=fail; b=IsPNJT0TKrdSV5HAJJPswxmSMwdreoI+gF/jeGz5SAQfss57xuZTxXLmyVzfBnum36FbvLU3JTz6EetDntu4mE7nNjggSahJClJTBXDWvZYQ42X2gF2+r4S9vD/ThI8TdZ+FHnRLuJeRdzui66YGsM9Ok0Fu64aKRvn60ylCBFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846385; c=relaxed/simple;
	bh=nP6fgBNmdi497U+VRtT35OaY2EaVSNnbRDNttg3HBfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GhCQsqhz40IhUq6J48Jt5Hgj0aeiyEcWt8d8T51VwBs2XThNlQip2drlxClJ2lMS+awVeEfo0VUPLqEwatdbeM4tPL0xbDKRjWqhehv6eatZNti5KU3Wg+IB7vnYk45t3D1JC0lVP/VL9PIgoGkzt+5jvahmGEYvz+NcUuVnkBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IeZ6kBXM; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DklaTh9tpGxU736TOv5gytabggvGsEb68mDGCN4aKSpKe5817yJzZHS+wc/MguaQ9HzTk4dOnd6NMRtSbumyOpJzr6VtWLVTEQEzqkhif2L5ayuRDus/ucKVaGOH3ZvIvu8OFEFLIkOLxCMHPvAkw5+joE+YD74/8svZfZaBEt5IBSTCGMA5BynjJLp9RTwV0cC6WRRbr6usSqzFECVJEH5lUrzKJR5JWHj3xyGWjnpDmbUD2HTDyaPIsp+3u6arNmeWpLYG6LwXVT5PSOSyScCcDE3hDofjD/OBCjOrTpaVdEXc+frSWx40avRsmjCNCXhQm4jHNi9cH9p2UmeRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpXfgFPkfFCR5HrATfwkbEHvc9Eh7GSdzPEEfYIVBWc=;
 b=w1+Ba8GU247wP/nlJSyEhHwnUM8EtY2WH2ntkWPZYBFyJk2CVm72qo9+haHFAo0TYAw3N0zhoQJXhO+GRXOqGVgdnX3nHfH35unz0WmdeEPescHi8QgTaQiFyMHdmnyl1XqoIk7O5x293NCzUaiJXkG5/rKUHCRgnOtFacAoNM6+vyqwUEiNjF3r8+znFwsn5i9nAbx8mxCmqDQDpfRwX5BxsOCJBj1aJyDgB2yH54s68VqzM/WPWrG+CaHkAf9jhWDFcw5Y++DNftxERFsEGlb8807A7X46aOH/QLvBMLxX/bvR2aFMyaiTlTJFCuZRc7hB849FfMPkIciaK8UBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpXfgFPkfFCR5HrATfwkbEHvc9Eh7GSdzPEEfYIVBWc=;
 b=IeZ6kBXMOnvq9aAGfpt5O1S7JQ0lqej3pRR8qSjQny/Av1phf6fFi8ENve+A8hBmUwAaflQgxZTBD3bUgy5KXwm4raIOYZ6LP3KrASt4wOO4jDqcyLR7uVFjIZFnakm11ewSztUU+ZqNR6fnUD8TAZvFanRZL+gpf5NcdCeDjJmwYqPVbjqNFwVhNn0b4Fayr4Vrf4GEHf/bi9sTrvvS9POdueYhasBvj4TIPFfPGPZSVMHZex1T2sx+gCgYJcq4dJa8Ck/xQmVoCizC7ZUMMuUXqBaxs9wboDjvUUK46gh4VWOSRdnStsb8s1e6LAAtRO65hT4WQu3fiNBBvuLkNQ==
Received: from MN2PR15CA0065.namprd15.prod.outlook.com (2603:10b6:208:237::34)
 by IA1PR12MB9468.namprd12.prod.outlook.com (2603:10b6:208:596::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 11:59:38 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::dc) by MN2PR15CA0065.outlook.office365.com
 (2603:10b6:208:237::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Fri,
 15 May 2026 11:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Fri, 15 May 2026 11:59:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 04:59:21 -0700
Received: from [10.125.206.85] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 04:59:16 -0700
Message-ID: <d287f657-1f73-4178-8f9b-190ef7e855e5@nvidia.com>
Date: Fri, 15 May 2026 14:59:09 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/8] net/mlx5: Use v1 response layout for
 query_esw_functions
To: Simon Horman <horms@kernel.org>, <tariqt@nvidia.com>
CC: <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <mbloch@nvidia.com>, <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gal@nvidia.com>, <dtatulea@nvidia.com>
References: <20260510053448.326823-3-tariqt@nvidia.com>
 <20260514191801.12494-2-horms@kernel.org>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260514191801.12494-2-horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|IA1PR12MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: 45985f2a-1f00-49e9-33c8-08deb27970c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|7416014|13003099007|22082099003|18002099003|56012099003|3023799003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	FrlBWBi5DuGGEr5RXDMATRSuvi1HdcTqTjcF+Ch2J3pfc+Rx8XjXZvwvg2M0eJ7X0965scTuFTs7T1kipSvd9fzKg0oyiQW5bV2pg61Ikp/dSDHlNEPeSe7L4PJWNdyZPKyb5NYNR/iqp8f9D4Vhy8TYYLOLEUkXuqA1VImgD8Mx+9PReinrqc0UYNlMCT5lQ3gi5+Y5f9tm+czBeOg0Py7K4o/c0W2KhDsScpqRmhMsYEFzCi/UfaeWOElXRcQJ6QU0PSLzVEt/fEZHtxBtfTtBPkPlpMqHQZ2mGD8ouVPYGgTv0wIiFBPro6ZaxB1JD8CKjSUtGKFThN0N5UoU//Daw+mZxIdn8Bbyo5B2RVcqZFUmd6VzkHMxVP7T+L5HvEQ+1T7YapsyuHaf9q2e70Obv0QCGDz4jln9UcFszceNHpPNVASRPwhPjOBOfVfwFkRfNmeC9eG7UAZdoGn4ZGc+l2avqGjYIJXYC9L6/gROV0uqIN3p0f+Cten8icYisSnq4Ecn3sBsMXO2XSWGd1MSukpy3EZSOL6GYgra+AAaVBmZtsBdBiofX0cCFDM+HaVk2/LMfcl20ehqt4X9EAwADHjebWbd0mElQE2ASlNfJOy7/T5f+13F2vsOi3PKn4zvH/0d5uO77jenJiXMau60GphBBRCsigt8PAGipiN76xy1aAJ5lgt/ge0+dlva
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(7416014)(13003099007)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8x49kfxDgj0+1pgPfNnTZJvckqENrbF5OrTWRye+Mr3LVpnoeiqu2wXoKWD3rkzFg2NbGNWk/lC6PPsfrT4vnFNXOgSrM2pdZMT5Yv1dZKFUIOy7ThKpGMJKhRoIR3maNIw6Gpy4DoRYSNrxrT+Wbh7E0ej2oyPecy1l7EFmsbcfCQZNHk9ua7n7DSo7vXA6F6CbTADX0Yj+mUPhRV4kc7YZAqmMTNiSKYZtaXp13+tZL3JUm4qsCENoxcCrhEg+rKfKHp5BO7FzVW8mCaOU/atNEa97XphJZjcSnMiaDWFv7sZPYlRQkG7T4SnQeU4ocegESFQyj3r59hiJNKXqTMR0oHpQA26KUfwsx2jKB3YWVZFbDL5QhEuoDJO4JzK2lnhE6WiI7mCROsaPLRCXGqWQj4XWieWXPBEXkvyzoIaHOx866I0Z0/R4DmefPgvI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 11:59:38.3867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45985f2a-1f00-49e9-33c8-08deb27970c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9468
X-Rspamd-Queue-Id: 8DC7954F494
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
	TAGGED_FROM(0.00)[bounces-20771-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moshe@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action



On 5/14/2026 10:18 PM, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net/mlx5: Use v1 response layout for query_esw_functions
> 
> This patch teaches mlx5_esw_query_functions() to use the v1 response
> layout (MLX5_QUERY_ESW_FUNC_OP_MOD_LAYOUT_V1) when the firmware
> advertises query_host_net_function_v1, allocates the output buffer
> based on query_host_net_function_num_max, and adds a parser for the
> new network_function_params layout in mlx5_esw_get_host_pf_info().
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>> index 861e79ddb489..8b62dde7eb70 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> 
> [ ... ]
> 
>> @@ -1100,12 +1133,55 @@ mlx5_esw_host_pf_from_host_params(const void *entry)
>>        };
>>   }
>>
>> -struct mlx5_esw_pf_info mlx5_esw_get_host_pf_info(const u32 *out)
>> +static struct mlx5_esw_pf_info
>> +mlx5_esw_host_pf_from_net_func_params(const u8 *entry, int num_entries)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < num_entries; i++) {
>> +             int pf_type, state;
>> +
>> +             pf_type = MLX5_GET(network_function_params, entry, pci_pf_type);
>> +             if (pf_type != MLX5_PCI_PF_TYPE_EXTERNAL_HOST_PF) {
>> +                     entry += MLX5_UN_SZ_BYTES(net_function_params);
>> +                     continue;
>> +             }
>> +
>> +             state = MLX5_GET(network_function_params, entry, vhca_state);
>> +
>> +             return (struct mlx5_esw_pf_info) {
>> +                     .pf_disabled = state != MLX5_VHCA_STATE_IN_USE,
> 
> [Medium]
> The commit message says "this change does not introduce new
> functionality," but the legacy parser reads an explicit firmware
> host_pf_disabled bit while the v1 parser derives pf_disabled from a
> multi-valued vhca_state enum:
> 
>    .pf_disabled = state != MLX5_VHCA_STATE_IN_USE,
> 
> Is this mapping intended to be exactly equivalent to the legacy
> host_pf_disabled bit across all five vhca_state values
> (INVALID/ALLOCATED/ACTIVE/IN_USE/TEARDOWN_REQUEST)?
> 
> The same vhca_state value is interpreted differently elsewhere in
> mlx5 for SFs. mlx5_sf_to_devlink_opstate() in
> drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c reports:
> 
>      case MLX5_VHCA_STATE_IN_USE:
>      case MLX5_VHCA_STATE_TEARDOWN_REQUEST:
>              return DEVLINK_PORT_FN_OPSTATE_ATTACHED;
>      case MLX5_VHCA_STATE_INVALID:
>      case MLX5_VHCA_STATE_ALLOCATED:
>      case MLX5_VHCA_STATE_ACTIVE:
>      default:
>              return DEVLINK_PORT_FN_OPSTATE_DETACHED;
> 
> so SFs in TEARDOWN_REQUEST are reported as ATTACHED, while a host
> PF in TEARDOWN_REQUEST would now end up as pf_disabled = true and
> therefore DETACHED via mlx5_devlink_pf_port_fn_state_get():

PFs do not use the state TEARDOWN_REQUEST.
Once the ECPF sets the PF disbale_hca, it is down and can't be used till 
ECPF does PF enable_hca.
So state != MLX5_VHCA_STATE_IN_USE is the equivalent to the legacy 
host_pf_disabled.

> 
>> +                     .num_of_vfs = MLX5_GET(network_function_params,
>> +                                            entry, pci_num_vfs),
>> +                     .total_vfs = MLX5_GET(network_function_params,
>> +                                           entry, pci_total_vfs),
>> +                     .host_number = MLX5_GET(network_function_params,
>> +                                             entry, host_number),
>> +             };
>> +     }
> 
> [Medium]
> pf_disabled also feeds esw_vfs_changed_event_handler(), which skips
> VF reload when it is true:
> 
>> @@ -3716,7 +3716,7 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
> [ ... ]
>> -     host_pf_info = mlx5_esw_get_host_pf_info(out);
>> +     host_pf_info = mlx5_esw_get_host_pf_info(esw->dev, out);
>>        new_num_vfs = host_pf_info.num_of_vfs;
>>
>>        if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_info.pf_disabled)
> 
> Could the commit message spell out the firmware/PRM mapping between
> the legacy host_pf_disabled bit and the vhca_state enum so it is
> clear that ACTIVE, ALLOCATED and TEARDOWN_REQUEST really should be
> treated as disabled here?

Yes, I can add explanation on that in commit message.

> 
> Would it also be worth aligning with mlx5_sf_to_devlink_opstate()
> (at least for TEARDOWN_REQUEST) so the devlink opstate reported via
> mlx5_devlink_pf_port_fn_state_get() stays consistent between SFs and
> host PFs on v1-capable firmware?

Same answer as first comment above.



