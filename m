Return-Path: <linux-rdma+bounces-10586-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2B7AC19DD
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 03:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF1EA20E6E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 01:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEAA1F9F47;
	Fri, 23 May 2025 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XgtncdMP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9282F24;
	Fri, 23 May 2025 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747965557; cv=fail; b=WxUcWEIPm9IR/5+6Ej3eY7CNXHa838QoajVJaCN2qCPdukjmKexwKfeYBdozIs3bMH1qbENzKxOqYmfSt6+A4SB/GWVM8wFsPGQGl2VkNaLO5vp1xguX3zNLewGtL7AOjABFHhAldvBf9cI3viVZ8dBHe4pbZbFO/vlguN3h59M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747965557; c=relaxed/simple;
	bh=7D55gtgcNGLMAD9oQwSG77HmjgHOfeBHHkqQ55NwBS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RM3Csx+E7nxT2iW162Cl067gTEThh+Oz4MHfxIL1JY5cHU1t4qHJ1CYqtmtNoBeLnxBA9F6kvnJLvnW/bkRz0JMeNmaeR5olxGUKWrW5gt7aZDJB5sF/d03YnnYws4UD5gTqLO+6E+DxmdEnNgkgQOfWwqlGkoDs5FDwfDmC+pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XgtncdMP; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm8ej2Erfnbyzk0mWGXGjNDW4OK8b9IBHN2uiHfJ1h8VUSXW8Yf/Nk3Fi5OZDnBrdZmtKUKwpEeTDwRLCQbYaH/KhFtoco73d6pRjNPzucTsTO5vkPI95YprwSHOkt8TuRndyQt7hVf1avWSL7/KlOPZL3NNjisvMTGFiZts5qmmdkvKL3sQOc+qLMbCKHjHDlz2RziaeIeH9tPasKo/dBs343DW7ukzFQsASDoeDhP2wpdeXZAnJH0GLxmK0O6rWbVWWUUGKeawRJLagh22QZbp5hlz8e4UcvBO0Wr+u3krV5Ng0h0GWMrCe3ZFQUa7OltdAtHVyno8OmcnZsWHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jg1Jo/1eSjCWJkFNEVAt/YgZ2WapDMhykPCUGd9NvI=;
 b=J/xwyHi4x3XBHrAFx/yv9AkCoc+bCf7ehgnySqNwwBd9jHtQ4W6+E/o6iNsUSoDC9xFdN5TrY5ZLyYCwFFfFqQyE2ZJ/JMVbdvs2rh7e/l3/ZiDtHzOn/KhZOA0nrlyjno7716s8Vx0i7V/yEppV3nJH+Dd9onC+rbdiEU+VaxA0GNuyr/6XaZkN/kBpTIknsM2Bi1xyDO37Q1RfxWP7/2mmfTJSCf/oPTfnghs8UqN/dSIV3b/t6PFGVwgVLpLwAJeTUOeYtRYwr0fxg70hXF0OTjnjjVnX9VWobvoDvxQHHHt+tPbTnAvsJV6Qf6dTd/W6UunKYfkPjSzTvp20UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jg1Jo/1eSjCWJkFNEVAt/YgZ2WapDMhykPCUGd9NvI=;
 b=XgtncdMPwnpW8bj1a3QHHEWB8JqYoh3gSp/pS4WmPiGaZlOdqDhuY0+83ieHAVk4kVS5bUsUdLtc586xWg55U140d/9x8pDnoOPwec5iHWOy21Lupea+KbokOqZXE8jFs4YezLDaJouQVM8FdeBBaR7rP1727kcyOvCrIV4h2WaUepM3sJK4rsi0T3RUQ2GyuksfyTPQZpkh4DF7Wn14tHzKXFY7iPNy6ms50gbfD3TjOGrfCJZtDEqo1Z6IqDEqqkFxG4EtE6ZGys9oBjWE0qrgeMaH9lMDgNaawB0ml/6BOTsMFkVcN/VMOOtz5jGH0I6ZE/TbXP/doVESMoKq8g==
Received: from BY5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:1d0::15)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 01:59:12 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::f3) by BY5PR04CA0005.outlook.office365.com
 (2603:10b6:a03:1d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Fri,
 23 May 2025 01:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 23 May 2025 01:59:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 18:59:01 -0700
Received: from [10.19.161.220] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 18:58:57 -0700
Message-ID: <1a8cb838-d487-4c56-8dfa-8179f305de02@nvidia.com>
Date: Fri, 23 May 2025 09:58:57 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net/mlx5e: Fix leak of Geneve TLV option object
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
References: <1747895286-1075233-1-git-send-email-tariqt@nvidia.com>
 <1747895286-1075233-3-git-send-email-tariqt@nvidia.com>
 <20250522191651.GL365796@horms.kernel.org>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <20250522191651.GL365796@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: db273a6c-e0c4-47dd-c720-08dd999d6979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHB1WFp1ckFtd2lTTEtkUi8wRW5XOVhEdFNreHFUZXlxOEZMdHlNUXhNNjhC?=
 =?utf-8?B?QzdVQ05vUW9KbmJSVVJ3aGZobjZHaDZLTnNwcWxzS0JiaTg4KzZYak1KVHdO?=
 =?utf-8?B?eFBIbUZTQkR0ZmE4SWlXbGcwdnhBMGJScnFpeFhwdWs4UlRxaXhuM1lWTmFZ?=
 =?utf-8?B?SmdDMEwwRDQ3bVVNblBEMSsxSlVxcVNuQnR0ZkpHN3NnWjg4S3BiR2VaTnNS?=
 =?utf-8?B?QlN1akFTbGMvejJORGIrTDVYV245c1ViQUFIcFpQOUpKY01BRXNKR1UyUEJE?=
 =?utf-8?B?NmlaSHN0UG5MU1FTbHVTRUhsOXU0Z21jSEV1aFZVemNCN0sxNithSWFKd0hZ?=
 =?utf-8?B?WFM3bDE3bHZoOE9VNWluRHhVQVFwaktlUmE0NE9Mb2gzMFV5aXRPekhYdFpn?=
 =?utf-8?B?dFR2dG9TeVZ0ZUZtTHI0RmR2SlJmcVAxd29LZFB0WXNERHN5MXZ6UncwU0J1?=
 =?utf-8?B?TXZaclR0WkxSSFZZbXFlNnBsc2RzVkVvMVZ3eVRNcm4xQVh3OWEvTVMyd3FZ?=
 =?utf-8?B?b09mUjdCUFplYjJnZ0UwTFFyQW9Tand5NTMwa20reDBxRmszVWpYdEJjbGhk?=
 =?utf-8?B?dHdQM1VVSWVzRGRhU2dGSGg1NTlUb21SbjhoaTlVTkUyaURDVzZRcWhpcWlq?=
 =?utf-8?B?OWM1T3NQY1Y0ekRUWnZjS0x5ZlVCNXJhUms0cGtwbE1DcTljZmhwdGpDaCsy?=
 =?utf-8?B?Z3pJUjZaL0lzcnkveHYzNHZPZ3BncC9VaUp3OTZDc0YvK3RZbFE1ZVRITGFn?=
 =?utf-8?B?TEducmR0K2V2Z2tKVVJYb0dCRjNTNGJGa0doVUJVRnM5M1B2eVhac3FVSEo1?=
 =?utf-8?B?bzM1VmdEaFFtVjNCcXMyT0poSW5RUC9kVUdiUDdrcWJzbUw3T0M0aS83RUE3?=
 =?utf-8?B?dW1sL0dwV3l5SWM0MjdEMkg3K05PWTV4d1k0bDVoR1RpbXBzbXRzY3JZbTRB?=
 =?utf-8?B?SnowL0I5MWZ6ci9Yb05LTHhhNHlTT2RwMnR4RmRiRG5MbmE1WWxONDFJRHg5?=
 =?utf-8?B?NmxaNEdYcE5FQmExRmVSTXZtbDJNT0ptR1hGUmM4ZDVIUFBRTWNjN2pYZG5v?=
 =?utf-8?B?eHZrWUNCaWRUMEpwL09VcnBjUWFRa1RFQkdxdStlNDFoMWZxT0d0VXZRUkI4?=
 =?utf-8?B?MmlYQ0RibGJkSFFRR00vc1pBRU4vOUFOc0xLOWpIQm1wVXVhektWVzRmVG9J?=
 =?utf-8?B?V1BYd055RnRNaXJDQXpscnZicm5jbi9seTJEUFEvanNvVWp0ek90OFpIRS9x?=
 =?utf-8?B?Y0JCcjZwcE1wKzJnL21aOUIwQlpXK0RpM0tqSHR2Q2lrbkFzaUdzMUJoQlZa?=
 =?utf-8?B?bXdVVzJKcWs3ZzdMTm13SWhzRDgrWFpEYXR0RjZxQzN6UjVqSHExQStnbVln?=
 =?utf-8?B?MG4zc1NzRDZ2QTFaL05yb01ubHI2WUYwdER4MW1sYXdQS2xtYW5Gem55b2s0?=
 =?utf-8?B?Ky9lb0ZBWTM5TUxIN0dUU2FxQ2N6T2FSNGJ6M2M1aWxMTk1IbldoRFZnaVk3?=
 =?utf-8?B?SWlONlVPL2lSWUtlOGhQZHNVdnhYNVFpSGhqVk42SHVHZitOaFdQNXZpOEth?=
 =?utf-8?B?SkZFMnVPYVVERjNidC9HUjNFY0VlNTN2RVJMbFJkV3RQcmUvZkkyT2YxL3Rs?=
 =?utf-8?B?Qi9YRU9YdTZPWFlEaDRtb1dKQURYNzgxUHVOSk5mUFFjblRYcitkdE94R1BS?=
 =?utf-8?B?V202dC9Oc3ZyTDE0YjlENkFOWnFDSmV6NWhGUWRRd1J0dFZ4WnpYd0syVVZQ?=
 =?utf-8?B?VWRBNXc4QmlnQWU3SFJUeTNhc0FTS3NtSmZLWDV1R0RyREE3RUJSekMvNDk4?=
 =?utf-8?B?R2ExWTNsVTk2NFdWL1crMlQ0SFlXSTIyeXcxamE4b1pDTWUzdUdQUTZHVGEz?=
 =?utf-8?B?cUVyUE90SVZiZXBmUkdrWmFUSUMzejBHL2puaE92QjB3bVNuMnVXT2U2eDhL?=
 =?utf-8?B?YXBvcktxRUZCY3k1UDdmeWYzYmEvbzMyMk1wZi96c1hlRHhVNzlxWXY1c0pm?=
 =?utf-8?B?ZU5TK243MGxYS0NGWmVraWMxdVBxQ3lSbTVKVGdKczIvNmpDbjQ4ZFowVXU3?=
 =?utf-8?Q?vJeRAz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 01:59:11.3541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db273a6c-e0c4-47dd-c720-08dd999d6979
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274



On 5/23/2025 3:16 AM, Simon Horman wrote:
> On Thu, May 22, 2025 at 09:28:06AM +0300, Tariq Toukan wrote:
>> From: Jianbo Liu <jianbol@nvidia.com>
>>
>> Previously, a unique tunnel id was added for the matching on TC
>> non-zero chains, to support inner header rewrite with goto action.
>> Later, it was used to support VF tunnel offload for vxlan, then for
>> Geneve and GRE. To support VF tunnel, a temporary mlx5_flow_spec is
>> used to parse tunnel options. For Geneve, if there is TLV option, a
>> object is created, or refcnt is added if already exists. But the
>> temporary mlx5_flow_spec is directly freed after parsing, which causes
>> the leak because no information regarding the object is saved in
>> flow's mlx5_flow_spec, which is used to free the object when deleting
>> the flow.
>>
>> To fix the leak, call mlx5_geneve_tlv_option_del() before free the
>> temporary spec if it has TLV object.
>>
>> Fixes: 521933cdc4aa ("net/mlx5e: Support Geneve and GRE with VF tunnel offload")
>> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
>> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>> index f1d908f61134..b9c1d7f8f05c 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>> @@ -2028,9 +2028,8 @@ mlx5e_tc_add_fdb_flow(struct mlx5e_priv *priv,
>>   	return err;
>>   }
>>   
>> -static bool mlx5_flow_has_geneve_opt(struct mlx5e_tc_flow *flow)
>> +static bool mlx5_flow_has_geneve_opt(struct mlx5_flow_spec *spec)
>>   {
>> -	struct mlx5_flow_spec *spec = &flow->attr->parse_attr->spec;
>>   	void *headers_v = MLX5_ADDR_OF(fte_match_param,
>>   				       spec->match_value,
>>   				       misc_parameters_3);
>> @@ -2069,7 +2068,7 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
>>   	}
>>   	complete_all(&flow->del_hw_done);
>>   
>> -	if (mlx5_flow_has_geneve_opt(flow))
>> +	if (mlx5_flow_has_geneve_opt(&attr->parse_attr->spec))
>>   		mlx5_geneve_tlv_option_del(priv->mdev->geneve);
>>   
>>   	if (flow->decap_route)
> 
> Hi,
> 
> The lines leading up to the hung below are:
> 
> 	      err = mlx5e_tc_tun_parse(filter_dev, priv, tmp_spec, f, match_level);
>                if (err) {
>                          kvfree(tmp_spec);
>                          NL_SET_ERR_MSG_MOD(extack, "Failed to parse tunnel attributes");
>                          netdev_warn(priv->netdev, "Failed to parse tunnel attributes");
> 
> I am wondering if the same resource leak described in the patch description
> can occur if mlx5e_tc_tun_parse() fails after it successfully calls
> tunnel->parse_tunnel().
> 

Yes, I missed that. I will fix in next version.

Thanks!
Jianbo

>> @@ -2580,6 +2579,8 @@ static int parse_tunnel_attr(struct mlx5e_priv *priv,
>>   			return err;
>>   		}
>>   		err = mlx5e_tc_set_attr_rx_tun(flow, tmp_spec);
>> +		if (mlx5_flow_has_geneve_opt(tmp_spec))
>> +			mlx5_geneve_tlv_option_del(priv->mdev->geneve);
>>   		kvfree(tmp_spec);
>>   		if (err)
>>   			return err;
>> -- 
>> 2.31.1
>>
>>


