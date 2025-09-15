Return-Path: <linux-rdma+bounces-13345-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F17B56DB7
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 03:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01283B3473
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 01:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8151E5206;
	Mon, 15 Sep 2025 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hFWX2RUC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEEA1A314B;
	Mon, 15 Sep 2025 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757898052; cv=fail; b=cHi69YPv6d3RCjd7KYP7T0NdPleE0crmjK0owHuGG8H4EevS8gcpNoAknO7g3m8UKzurr9ralq1w3zBm9bwv6H36SE/qxcP9MUgm3hoSbN3f8XxsRmdmjvJ9jDSOVbjzaE3qvCE/ZQFj3uQTi4CkSoMOw9dD0fmfy2FBr7VmJeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757898052; c=relaxed/simple;
	bh=ci2A0T6M+VAC30+lEey5Fd+wg3GsTlOo2EdgbLYcSCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DdW4UbmxnXMc6GK+FLAYps3GEYzpMer2PSJ+YcwW/EKV2xkNtsprxcNGZwml4g900SQTO8FL+fFweyEBP+LH4FbQ5zRqMf2GEd9rWjBGIqfGAyk1Oyy1k07U8g7ql0zdbd31YgER320tTh4q0cWVyfda4xzY8NDUmZiTCZuUm4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hFWX2RUC; arc=fail smtp.client-ip=40.107.102.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIub8S+Cc1J1lcbzc2Twxb5/41G1yH4Bdzw+ckQ9oXRlhTEFMiNerT/f4zI1vu0bRttk/fdnVWU/Q8paUpcPOLbRMK12I3V4EVNfn8fmtw3+vHYUF/moMiYTEOQlPBvIb4dRuA9xSBWcZaKGDv2k94nVhmrYGWt0JF5LcPAZmN7iKETy8cX7AM+KjkX6f0y/jJgApzN8GxhZ3+0zbWnEKzJDTOCXpAdhyInyI7ZlMUaxWXsy+ntr7imGMu8162uLRwlwu5wviFqJSy0BHozLuE3i7ZS1ZV89fq7l1Qs/Xihy3s6eKNntGyecFV4IHpANsB9xsCRPy95b6y/DEseMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdcjZDJRhJOhjgrPhLXqedoLxaprUCbRpShMKMcNTQ4=;
 b=KOI18wSWRiiPfvKMfImu2j+XxuPiup/mjbQ6F9LB1s2KjzO31foqvlUfgSUd4m7i1EzxlBsVEJyhqjjDA3AdD5Bj7ZpYc2qP3L/KqVVpYRn34AUrl1VTRY4ZiUhEIV6syDdA/0xGT1dehOA4FkSVj5qaYVf9hUaofz8sTSq1VR3WT+Wuqvi0QyvAikcgPQxOZPDi0EyH9qJ23I7mrKEAcbKZhN+6m9O1Q/ZTWSQtlTSPTCUNKYeGskl+X6sGRJsa77WEak2knrQA8qMGFx6yYVNcnu3Uw/ZDDge/3OPk4lBasgpIZM8tBtRZK4cYOo53ksPc2Oy08HGVG0Vcs3De4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdcjZDJRhJOhjgrPhLXqedoLxaprUCbRpShMKMcNTQ4=;
 b=hFWX2RUCO2ap4ImGABsZZyhpjPs1z6rJaqfX1pg3iOVEqU1B+Ta4s5yJowDWIJA6IQTmWta/8nHu6UMFuAlpm751YdWloQs1DH441Dt7NBzYvvWbjmGuNGQmt12/8nwf1wWYjmMsa7NvPdCS3rZ6EVVePrDbRzZvuzfQwBrvfNc6e0c+IC0bpxQ7/b6AKgb7IyhhmexybUvzc18cWdd24O/RhV9IJ3BNSnU4zRzDrqoNe+vOKUCx8VdnEP5vx4bATDOVzeBOXCAXXvQrXzi5/xqpspQf0CqmlYjtmO//lWixiAjEC83Yl0lKAGgC5RyW9IkLjh/+cghv9vo6GnJ+bg==
Received: from CH0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:610:e7::8)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 01:00:46 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::3f) by CH0PR03CA0213.outlook.office365.com
 (2603:10b6:610:e7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 01:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 01:00:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 14 Sep
 2025 18:00:25 -0700
Received: from [172.29.225.228] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 14 Sep
 2025 18:00:22 -0700
Message-ID: <573a5647-5161-4c4c-bf1f-bc66e8df14a5@nvidia.com>
Date: Mon, 15 Sep 2025 08:59:24 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net/mlx5e: Harden uplink netdev access against
 device unbind
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
 <1757326026-536849-2-git-send-email-tariqt@nvidia.com>
 <20250909182350.3ab98b64@kernel.org>
 <cc776b20-7fc0-4889-be27-29d6fcb3d3ad@nvidia.com>
 <20250910174519.2ec85ac2@kernel.org>
 <9bbac284-48b8-4377-85f9-9dd3c60410cf@nvidia.com>
 <dbabdfb6-e6cc-40a4-97ee-fcfd29371e8e@intel.com>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <dbabdfb6-e6cc-40a4-97ee-fcfd29371e8e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a8a7a7-7ce9-466c-0c44-08ddf3f34dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk9yV0hCdVlGdnNpYS9NTEtyVzNaN3JMeXR3UVdHd2ZnZWRtTDlrdVJ3V2Y0?=
 =?utf-8?B?SFF5K09tM0pUOHJxU0YrNXNPOW5YS2lLTFMrdzc2c1l2SXZyNEVFWUJNSzkx?=
 =?utf-8?B?aGk4bGlIOW1yV2NQNi9NNlNySGpJaE9FVkRMc0MvTGhaRG5PT0hNQy9XUVJ6?=
 =?utf-8?B?S3FuamF2WU9OSUk4WnM5cEoybytlWmNLaDVwZWJLd3UvY2lIZGluSlRzVXZx?=
 =?utf-8?B?QUUyTlRwWXRqSlBua2d0MXBmVXlCVkIwS3U5VmdZM3ZaNXRhQ21OUUN0b0p6?=
 =?utf-8?B?dStneGg4b3JITTJwVjZCSDE5Umo5SXp1RjQ2VlovYyt5M25lcmRjeWxqRVdI?=
 =?utf-8?B?UWZlalY4akZhSkFoQ0xYV3dvVzNNdkd2NkhUOEk4c29PSFJVNGh3bWdVcE16?=
 =?utf-8?B?cFFPMUhMY0dGSnpBVmM0RFBMY3FUbisvVUE0V3lITjljbUJucVRwYzJCaGVZ?=
 =?utf-8?B?aHRaS0F5SnJzVXBtdjdzbE5XWGxjcFBvWW41aFJOaEI5OXBHMStZSEJ6UHc3?=
 =?utf-8?B?ZElnTmoya1NPbkZxQVFRZlU4cDFtMUgyOUNCVUZub0JFazlBMkZXTG1PYjhT?=
 =?utf-8?B?Z0Y5ckFtMlIyWG1uTHlKTlJXN09uSUFiMlpWUHBQRExiSzNCUzRPbHloazA0?=
 =?utf-8?B?NnRrSTlCRFdGdjhEdDRISUxZdlJ1VGx5a0dtQ3huMkJpcEV1N2JiUUh5aTIz?=
 =?utf-8?B?bndFOTJPZjFSTEhJVmlxVnRsaGZnZ0owOVQxWU5HNnY4VEJSOERjTWtZR09W?=
 =?utf-8?B?UG0zMlB0MkRreXhORjZNMjVlSTY2dDRreGhmZXc1TkE0T3Y5Q2NsWDRQeWx1?=
 =?utf-8?B?WTNVUDV2Z0x6UkFickNITjhZaEMvYVdwQXFEclp2c1FQKzdEMm1SL0JvMlZh?=
 =?utf-8?B?MEFJUWhwZVB6amNEbHpub0E1QTE5SUhVYThkdVBOdVJ0OXhOVUNjdUd2K2E5?=
 =?utf-8?B?WW1IZVR0bGl5N1dZT093TURkNFI5Q0FQbVp2RnVVa1NZK1hFK0JkclFrMjlX?=
 =?utf-8?B?K1BFRk9MYzFidS9kendVMzlxSUF3bEtwajg5ZGI4c3l0SStRTXEybDlRYm1q?=
 =?utf-8?B?SVIzM1FodERHdzhaM0ZwYit2UEhFQlR3MDdCc2hGR3hNSnNySndRK2N6c0NX?=
 =?utf-8?B?ZVllMUJScTdtUGsrQ2Q3eFBkb050RVdBU3pCeFdUMThDUFNLM0Uya29GQWhl?=
 =?utf-8?B?M2FFeGhURjdCSEUxYXJGTjdzc1JCUUR3SVZRQkpGemR3eHk1dyt5aEdJbDdV?=
 =?utf-8?B?SmgrQzdwc3dveEpabno1UXU1SWpDalEyN01TNkpqZksxRDRzV05acml2OGhp?=
 =?utf-8?B?RzdMRWw0RitSLzFVWXhsamE5eGJBNTVoSlhsMUJOa2JUTXV3cEExQ25hN3JR?=
 =?utf-8?B?dmZOMmRQc1R0a0NsazRXZkdOdU51ODRHUk5ZaWR3d0lWZmQ3dzlxL3NjajF0?=
 =?utf-8?B?eUJkK1FRMWxObkVmaStTeGJBRGtQWmFRVUpaUk1GMFMxQm1BVHBJWU5aVExz?=
 =?utf-8?B?VkRqQ2lGVFVPOU1kb0FNSnYrbGVObGFsRzU5REtrT2wxdWxSNlF2SVlNQXU0?=
 =?utf-8?B?U05Gc0pnSmEzN2ZUMFY5QmhHdjhRVkxmcDBRTVlQQ21tOVJkMlJUb2kyV2Nn?=
 =?utf-8?B?T3J2dlBlV3J2N2wvWDZnaUo0N2FBeDdTRDA3eUlwZ0pZNFJIdU4zMnpsZFJR?=
 =?utf-8?B?cTlUVllmZmI3aGRnVEhpOFM3d2xUcU5nRFBzUzlrb0F6SmF1L0JwODcwY1NC?=
 =?utf-8?B?VnlQTmp6UW0wNE5qeW0xamZxRjFDVkp1QU1QdWhyYVdtQWdXOUNUK2hkZzNH?=
 =?utf-8?B?WnNsU2IzWWsvaUxVempjZ3dwWmN5QnNPZ3V0Qm9pZDN3N0xoc3FBWTVPaXJj?=
 =?utf-8?B?V1J6Z1ZmSks3eVhXRWFjdGhNN1JUMXNZUFJWQTVzMm5zcFU5cXZRclpvQXl0?=
 =?utf-8?B?T3ZGbE5pbWFCWW43VWcxU1hFT0tGWXlJeS9HSEpVbEFRZkRZMkU2NFR0ei9R?=
 =?utf-8?B?UjQxSXFFZkZLVzJnTHJRaFN5dUN5TDdPSlRGampSM2pPdVVjV2JpTm1UMVk1?=
 =?utf-8?B?WUxnOWdkYmNSKy9VcDFvd0xiTy9MNkxFT1RGQT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 01:00:46.2530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a8a7a7-7ce9-466c-0c44-08ddf3f34dca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749



On 9/12/2025 7:07 PM, Przemek Kitszel wrote:
> On 9/11/25 09:09, Jianbo Liu wrote:
>>
>>
>> On 9/11/2025 8:45 AM, Jakub Kicinski wrote:
>>> On Wed, 10 Sep 2025 11:23:09 +0800 Jianbo Liu wrote:
>>>> On 9/10/2025 9:23 AM, Jakub Kicinski wrote:
>>>>> On Mon, 8 Sep 2025 13:07:04 +0300 Tariq Toukan wrote:
>>>>>> +    struct net_device *netdev = mlx5_uplink_netdev_get(dev);
>>>>>> +    struct mlx5e_priv *priv;
>>>>>> +    int err;
>>>>>> +
>>>>>> +    if (!netdev)
>>>>>> +        return 0;
>>>>>
>>>>> Please don't call in variable init functions which require cleanup
>>>>> or error checking.
>>>>
>>>> But in this function, a NULL return from mlx5_uplink_netdev_get is a
>>>> valid condition where it should simply return 0. No cleanup or error
>>>> check is needed.
>>>
>>> You have to check if it succeeded, and if so, you need to clean up
>>> later. Do no hide meaningful code in variable init.
>>
>> My focus was on the NULL case, but I see now that the real issue is 
>> ensuring the corresponding cleanup (_put) happens on the successful 
>> path. Hiding the _get call in the initializer makes that less clear.
>>
>> I will refactor the code to follow the correct pattern, like this:
>>
>> struct net_device *netdev;
>>
>> netdev = mlx5_uplink_netdev_get(dev);
>> if (!netdev)
>>      return 0;
>>
>> Thank you for the explanation.
>>
> 
> that would be much better, and make it obvious that there is
> matched get() and put() calls
> 
> would be also great to minify stacktrace
> https://www.kernel.org/doc/html/latest/process/submitting- 
> patches.html#backtraces-in-commit-messages
> 

Got it. I'll minify the stack trace. Thanks for the tip.


