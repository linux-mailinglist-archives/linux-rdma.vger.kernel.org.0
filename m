Return-Path: <linux-rdma+bounces-11012-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8582ACEB90
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 10:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B943AB049
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 08:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46A4204C36;
	Thu,  5 Jun 2025 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZNlaKBMP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B119D8AC;
	Thu,  5 Jun 2025 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111312; cv=fail; b=XfPWhjLWdfMF8oVwYf5wn/LPClGEkn0sVBRjml8Iv6aeA2+E0QiiSKeWGDJHCFPO3Q/3d90jf0TPTbT34Z6IaTQNPysB102RAEr+NARtUfAb7gFFylAWOtDOMtPMeM90KK89fyaAnaf6M/5E6+QrxU4LnGyfAyiUJHa94WlQZhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111312; c=relaxed/simple;
	bh=ZxpXuqoYtTcXh9Kpif/BSCGTiBD5iTFdoby58JepUf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o5LW4vA7m60zhiQxV7eg3F+q6GauH5CRHxEzartiNWWolTiOuZ8FtF9RCsorq8FrE+RoT1nucfWzzFTEC++kpIVOkW0Skt9eKVqarUiy+pMA2bQEfWvCCa3kBPGp44jEvPEOx/JhbM6qQ0kl/Sf23TtWQrrj+1BYxCiVbjBjqbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZNlaKBMP; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbLkMj6fHcw4EzC7ONEWQx+vZfo2LtKNNExWzjHFBJVJXvZhdrhU0dhqZgmLE+NxqxQ78LrkYSevan9uZdOb0VBR4rZzui+cXcKGvFtCvsWlD+vleD+VDM9/r5eD5DMSMY0rlPtlqq2thvJ/X8jEqTQHoY444lFU0+atbixWxcG45Mcoz0wEI1b2Auql3f46sN1LfIUHVeEAVaNQ785hxqlF4tVh8VQQohdj8JCq6n3514gTICl5CGQA9aeLXXy28Wbt/EwVuJvhgsTnqH1nKMZ0dT5fOJ7papFmZ4HSvSyURSLqKh798b6ZQ4u5TCi/HivgtBAlXo9WkDO73lq/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dULvnWEPrY2DPIKLC3kjozI4Holn+3hnQBJIVNSGUE=;
 b=kTibtrWfMliB+tUkw4F1QW3dZ1/++j5pEEPuJhxGhMnCJJCJoCorLjYcenQr/6rRf67HBcEhy0acsj7aPnwCqTb2leA1f2qyZUnZ78LkRB3dgy8S+1LtgLb/Xf5FjTUPzQQBS89vn9UfNS9KJJ2jit2EAbDh0a1UBwoqNfpSrnjue0NEqRSmwUW5jcOBNz7bt6eXJg4r9viV9GAIr28CamgS1S1wL1p36/rU8rGyHwKb0jyhW7JW9OJ3J3x3a1Nvh21xEyxvwPZ5eiTNZ4Cvuv6Y8vtVhA5fDmotUQsS8MqnZ3CM8uKK4OXjVKwdmAS75X67R0JQYxk7qmuqrAP5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dULvnWEPrY2DPIKLC3kjozI4Holn+3hnQBJIVNSGUE=;
 b=ZNlaKBMPe+QTdNSkeRWxWDaZgQBouyuw0PLVqfoleAlIW0wPBvgSaJ4Xq78WkAtcRl/dUUTlB+nqou+N4VLvBxUU4Yi2PzXj5MK8Q3jnmRpgQFwHPq4flcLigtcaMkkZ4ud3POXmUMPjrjGexBcaVmsZMpn0SLmYiCCZOmRXwS0Nno1waxOa9gUbDq73jiEK7fy5ORPVE/mUOwuEjfXNPjukpbSGY2fMU1hTX6FCuPxRHhbXtl+8CfDDQMQJVMuofZLrFDetXx6yHseBJvaN8oZDGV/hVruoZ8hgIZAYjKCNLlMX5/gV5PrnoMt9fMnmhz8itkYIn1v8mCqhrz74TA==
Received: from PH8P221CA0033.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::10)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 08:15:08 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:346:cafe::93) by PH8P221CA0033.outlook.office365.com
 (2603:10b6:510:346::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Thu,
 5 Jun 2025 08:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 08:15:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Jun 2025
 01:14:50 -0700
Received: from [172.27.33.54] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 5 Jun
 2025 01:14:47 -0700
Message-ID: <7a8e85ea-7ce3-4da4-bb0b-819fe9f7d54b@nvidia.com>
Date: Thu, 5 Jun 2025 11:14:46 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/mlx5: Flag state up only after cmdif is ready
To: =?UTF-8?B?6LW15pmo5YWJ?= <zhaochenguang@kylinos.cn>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: netdev <netdev@vger.kernel.org>, linux-rdma <linux-rdma@vger.kernel.org>
References: <1l92ogj6wlz-1l96i9zg23c@nsmail7.0.0--kylin--1>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <1l92ogj6wlz-1l96i9zg23c@nsmail7.0.0--kylin--1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CH1PR12MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb8413a-f56e-4017-3efb-08dda40914cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V25yeDFqMVJwSHhmRkVVaDV4bzEwYklMNDIxSGRybDA5d29NaFVmcDBjajhU?=
 =?utf-8?B?VnMydUFNUmFVUFFmeHNIM0taa2dGL2VNZkt4cXJ4aWZBYTRKZDJZRXJ2eGp6?=
 =?utf-8?B?dDllUyswbTRRTm9ScGRqY0ZZRk8vbkVES0hRSmF2MjB1M3ZZVnFMcXhyNzU0?=
 =?utf-8?B?cy9kTmw1ek5URmg5eFErWklNMHMraTlFaWFVTlZLaHAvNG1oMXgzck9EUTQ2?=
 =?utf-8?B?U01JRFNyR2FTcTdqczVFL0d6T2ovcjdja2RzVEtJcDh3dVNCU2hBak1VWEZ3?=
 =?utf-8?B?d1NiK0J2cHRNbjBMdTcwZUVPRncwcHZxV3JVaEVNQS9kKzZseXExd04vcGhh?=
 =?utf-8?B?WFRXZlFHalRZU0t0UUFDVzN4NmNyR1R6cmUwajBpN0hlWUVvNG9LLzc0WU1p?=
 =?utf-8?B?SjU0VGI3cVByNHA4THhhc1dHOHVIZVJxaUdDUjdMOXlpajFrVHh6cmlrc0Mz?=
 =?utf-8?B?aGx5OGlhMUVsNENSNG93NUFHQ00zQWZUQ3FzSlJjQmltWDd6T0JiL0xqNHdt?=
 =?utf-8?B?MFZtZTV6TUsxVDFwcEJ0d2ZCa1NNU2gwNW5sYkQ5TUFHM0xtRFRkR2UyMk9U?=
 =?utf-8?B?S3NPa0RGNnBYQnJkMTdNVE93OUp3YkZ2eGhzRDVwN2Z1dkJSdnh1Z0RJSFhm?=
 =?utf-8?B?NVFlRUgzdTE0TDVCT3JhMTM4MDFtSlI0WVRLWmxHcEFWd080OGlkdUU3am1R?=
 =?utf-8?B?S2NKTFJsNGlWVFU3YzhQdjRTSFlVcm8xQ2ZFS09POFlKUnhwVFhET0Uzb3dq?=
 =?utf-8?B?OVk2cks3MWpTUUxvcDZvTk5TVTF5cUY4NnJnZEJqV0VUYzExdm5aYWlhdzRm?=
 =?utf-8?B?a2ZYam9uV3g1aGJsNkZ4a21rK254ZGptS3pMSUdpVnpIZ01td29ieDBwT1lm?=
 =?utf-8?B?b2pNQnJPdzFFNXZ3ZVZrRURjZ1l2c0o5OVpzbE94SzdkUStqcUF6MlZVQUFF?=
 =?utf-8?B?bGFYMjJVQ1ZGbUljYm5DUUVodE1KTGdia3UzVEI4WmZyTzNFVklHWVI4WjhX?=
 =?utf-8?B?Rnp1Q0MzODRaRWdTNzFJanJXMXFFNVRUdHB4UEhKdGt3RGpsdjV0ck0zOEFj?=
 =?utf-8?B?UTM1N0dWcklISTF3MlpaMmh0Q1laTjA1b2pXWEdvTmh3dHV6NTYvOHMrWFgx?=
 =?utf-8?B?V0lNbGtHWHVqcEwwZlU2Q1NaR3RjVTRXWmExeFA4Rlg1bUZ6M1U4Y1NxZU9R?=
 =?utf-8?B?bGp5a1BqME1IWjc5NFkvb2l6TExqakRibGtvUlNzcVB3NWdkYmhGLyttbng5?=
 =?utf-8?B?V3NkOG5HVVhBalNOcXc3OFI3STRPcVBuYUd3dTZMN1FPN2FDalR2U0hjaHZ6?=
 =?utf-8?B?dmx1dTdaRUhsN2xJOXBqam80WmpqcHBxazZQeEcyNHZBYktQV3ZlMDI4aFVC?=
 =?utf-8?B?cjNjOTlPcERiY29lYi9lYTg4NFIzQ2lKQnlJdkttbzk1QVhieUpZdVBTTFZr?=
 =?utf-8?B?NmFpOU9qbkswZ212NjJoTFRaYkYxcExyb2V3MURwcVJ0cmJ2TlJ1cm43UzVm?=
 =?utf-8?B?TWtzRnFmSDZMZ2xQSFRGd3pmNVlaaVo5M09XcTViQWZCUEdBUFJodk9Lbkty?=
 =?utf-8?B?S3VTanRCbVhyczBjYTZ4SXVPV0pJaklUTG55Uk9Ba0ZXOEMvR2ZVVkdFUGZt?=
 =?utf-8?B?UnBRaG9uWUZianVxMG1YODhtaCtqYXBjUjhPTDh6cTVQUVlCb2ZVZlF2OWdv?=
 =?utf-8?B?cWFKZ25BdHkwK3pCbzFDUlc2TVA3VDRrSmRPdm1WZXppMGlrUGhJakZFN21Q?=
 =?utf-8?B?QlNmbDZuQWpYSFVzOEZERjVoZWdYOEVqQllTcFBYMTRJT3ptcjVNM3ZYc21x?=
 =?utf-8?B?T3QwNlRyb0dHZTZPUW8zN0JJOFlwWjR6ZlRFWGlRNjBacWhjUG4wblQ4cWFC?=
 =?utf-8?B?RGpSVHJOdTlIWnJ0MGNBTjI5T2h4c0VxSDlyUFA2cGczeXFNRXRSeVJ5bjRI?=
 =?utf-8?B?NkVRZDgwWmxUYmxyOXhkSlpIcms0NmxJMGV6VGk0c2pVNTJlNnZYLzlZbFM3?=
 =?utf-8?B?cDFvNE93cmExM0oyWmk2dnJTaDU0bEJjY21YbDFzMlNJZEEzR3hDL2NueThY?=
 =?utf-8?Q?JhixQ1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 08:15:06.5820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb8413a-f56e-4017-3efb-08dda40914cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621



On 6/4/2025 6:07 AM, 赵晨光 wrote:
> 
> The trace points to cmdif, that's why we better handle it there.
> I couldn't reproduce it using the scripts above, what is the
> reproduction frequency ? can you send me the whole log of reproduction ?
> See the attachment for all logs.
> Thanks!

Thanks for the logs and the data.

As I see, this is a reproduction on old OFED 4.7-3.2.9 driver, while on 
new upstream driver we have mlx5_cmdif_state checked in cmd_exec() which 
means to avoid such trace by setting mlx5_cmdif_state down on 
mlx5_function_teardown() and up only after mlx5_cmd_enable() which do 
create_msg_cache(). You can also check on latest OFED and if issue 
reproduced there, please take it with Nvidia support. If you have 
reproduction on latest upstream kernel driver, please send the 
reproduction log and we can continue here till resolved upstream.



