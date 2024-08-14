Return-Path: <linux-rdma+bounces-4370-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF45951F70
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 18:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09CA4B2A152
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373341B9B23;
	Wed, 14 Aug 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z1DJhtt0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFD1B5835;
	Wed, 14 Aug 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651459; cv=fail; b=WayUq90VDZ8XGGyQBU31rVr1qB+hLekSZC4TslXfnPg4Bg5eWkkBb18xgu5ok4TaOmSZfsyvabw16qawWoA01zXSp3yt7YwQzGbuJEg7wLbqCPHaGmzG9/hOSXweX++8/PxHTQy9gkgz7YXBNzCep1UU20k4Lrq19+7cwUYNYKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651459; c=relaxed/simple;
	bh=fRVHSbhQM+ClU1MdczCZAFCcU9Vb+DIaWjh7nvSp1g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ODPuwFfIec8+DuHyeC2UU8I03Pdz3MoliJMgso+Q2XtOm9UCChy9Bwmnbeq+nG1LIC4rblGNz/H3er571AhT8n9UXfSKJh07SZsPkUddOGx9FBqj7/bV6ciB88QAO/gYkKxIB0EB7Z5oyjFAKbfkY656Mna2z3EBzYFh9T3cQGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z1DJhtt0; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IS6AHPOXPKstOXqSxCG07pYOZtndY5OsTtmI1yg4yQW8Ass6mTjxuLhe2T2TO+tbq462jI0favrpG8aiYp+suSMYMpfasSaNhQzHeY/tNm1LKJPMcb+J/XMDHM6IKF4oZ/02MQ+57yxZe0DiYsvtz1DmoOo70Rd8o7csExxv46Aj03xgVldqg9v5rD4eTc6ZXlX5kLECzFEc8vWMGy+4UXmictSSpW/IG5fzOXnV+3KK+ujZR3rfjaMt0WBtv83rDZQq3cpA9ZwJ7y+LWwNUQ2W5/kq3tuQBGbRv/R/Cg74QEVXiXpqalmI0437uDQD9nQq3sIT5NkEJiBwkELz2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g6ZkFxiDilMIdjET+eGxNP94BY4egpyIylll/I5g6o=;
 b=w4Z48CQdY6BSkvMxZbsj24tuYnKr93i0FnK8ISQkLisR/wwxkne9vQ9QyJ8mwm55/h8KKR5c+rUeUKhdNqW9avlth7/lXp2GmY78L9hZvPMqAsDWhGdLqCN91UBpBOI67a7QJqY9ryC2eRkdy3JMS/oIt4x/E4HW9Xl8fW7ptpbHX8fTVjoIl7i24EmD18z/Jboc5AHwMOMkfJ2tFJ8EfK2xw3aR1VsIJ5PupGQYpKARNiLqx6T12hf9V1FvrzKoIlHHk75i0/P38nfL7OaJudHAiMXmu/hcjRxop77oRBhcvzFO59u+qAMAzo7ZlRWOqB4icO9iJHv/PkTGLtt+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=fastly.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g6ZkFxiDilMIdjET+eGxNP94BY4egpyIylll/I5g6o=;
 b=Z1DJhtt0AISHx4PLdw8PfrZAhnCKWqxrgkjXR3pSLLnNTxQMZvP0X+qr/149s4qlf3UC0D+Bjq2DDcdOpC+/5MFmEor1gl1u8sFj6JLKUGa2KNaZN/+KJWEu6Cam1dSdxK/ILJ6vtsBJ6qgYGQPFBuGKbarOqYHaxzNayZTAV9mg2W4yTayu6ZRw9n5KsVEgTSXc4/JddjZfqmqCeH+WAZdmUAinH3oLiYh3DEZj5Q2OAAi1uMFMt0FAkQY4WNrBmbLmWcyCzn5X6soPB0r4XKOm5yrzvWImyBWQz0U3tKfI0XthWc2LCp+aXVymYWbCfuMJi9FPfpy3ibpW/60aOg==
Received: from PH7PR02CA0023.namprd02.prod.outlook.com (2603:10b6:510:33d::30)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 16:04:13 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::df) by PH7PR02CA0023.outlook.office365.com
 (2603:10b6:510:33d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Wed, 14 Aug 2024 16:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 14 Aug 2024 16:04:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 09:03:52 -0700
Received: from [172.27.60.82] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 09:03:44 -0700
Message-ID: <701eb84c-8d26-4945-8af3-55a70e05b09c@nvidia.com>
Date: Wed, 14 Aug 2024 19:03:35 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/6] Cleanup IRQ affinity checks in several drivers
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Harshitha
 Ramamurthy" <hramamurthy@google.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, Jeroen de Borst <jeroendb@google.com>,
	Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:MELLANOX MLX4 core VPI driver"
	<linux-rdma@vger.kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shailend Chand <shailend@google.com>, Tariq Toukan <tariqt@nvidia.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, Willem de Bruijn <willemb@google.com>,
	Yishai Hadas <yishaih@nvidia.com>, Ziwei Xiao <ziweixiao@google.com>
References: <20240812145633.52911-1-jdamato@fastly.com>
 <20240813171710.599d3f01@kernel.org> <ZrxZaHGDTO3ohHFH@LQ3V64L9R2.home>
 <ZryfGDU9wHE0IrvZ@LQ3V64L9R2.home> <20240814080915.005cb9ac@kernel.org>
 <ZrzLEZs01KVkvBjw@LQ3V64L9R2>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <ZrzLEZs01KVkvBjw@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 91bf65d5-f81c-44a4-941b-08dcbc7abd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVp2aHYwOFpXZmVvZ2ZDQTRMQWNuYWQxUnlaTFk2a1dtenkzVjdVbG5OWEhL?=
 =?utf-8?B?NGVUWkRESGRLL2t0TXAyYVlyTnlrOXRVQi9vN1F3QVh1V3p1OERrL2FFM3Zm?=
 =?utf-8?B?R2VVd3piNXkrZHFqcC9YOGJndHcwTjVpaVhDRzNubEEvRTRQS3l0ejRzK1RW?=
 =?utf-8?B?aDlwdnAvVi81NjFqMG5SV3JicmhkWjFaQmVNbGZyQ3VMbWdrRFJXUWY5MTA4?=
 =?utf-8?B?UmNVT0NXcXNGMCtKQzVQaWJjZVp3THh0cndpU09DRlkxYXFhcVN1ZUJxRWtT?=
 =?utf-8?B?RUJmSXVwUVI0YUlTSjNBYVpEZ1dIbXJtNEpCWWZtSnk2b2VXd3Y1eTRuVXVF?=
 =?utf-8?B?djl2d0VYVVB3WjZ2NlltWFVEd0cyL0d1Qy8yRHA4ZUlOWDUzcEpLWGV6dzJl?=
 =?utf-8?B?Ukd4ZlVYODkxUnduQ1BiaXlxM1g4Y3drRjhxOWZtZlBPdDZaTEJIR3NjRThI?=
 =?utf-8?B?YkJERWFqZmx5MjM1TTVwRE5jcUpNVUdobU56Y25tWlp3dVpNL0pyU0J0U1cz?=
 =?utf-8?B?R2JtejdNUVQxRWkwOEtmUll6cjVPOXcyNHEvUTBQUzI0aDdkY0JEcHlzWkcv?=
 =?utf-8?B?enFtYjFGL3JBTGx4a2t6cko3cmFMMUVPamRsMlNZc2QvbldpTlZhRTFMYVVj?=
 =?utf-8?B?VWVoWlY1M0ZYZTlPYTdsMlNxbzBpMXFFQm5ORFdIcXl0NzNLa2tPMGNUMW1R?=
 =?utf-8?B?U1puVVhLOXo5QUNTNDIvQ0VneVNqekpNWW1qME1lWTRQT29seTZMU2ZWeGoy?=
 =?utf-8?B?NTRRL2Z1R0VFVEFhZ0FFZE9BODQ2OGZaaWdGRkhqRHNpSXF4Q3pJT2kwb1c1?=
 =?utf-8?B?dCtwVDVhL3RiWCtiZ25KeFVPVnRrNzQvS1hzbmFTK3RlK0wzWlcweFFTc1dt?=
 =?utf-8?B?L0tqcmVtMm9ITjFPRXZFTlp5azEyeUwyVll6enlEWVR6WnhkRHZhRmFYSWl1?=
 =?utf-8?B?Qk1FVm1kS1RJRnRmb2lkb3oyc2ZNNkUzWVgxWmU0dDJValNFd1lBdXVXRHZw?=
 =?utf-8?B?bnZCZUNacGNhWnlnREI0UEF4Y2JpVlY5Q3R4NlMyRFFOalgySC80ZjA4OGo2?=
 =?utf-8?B?cFRjODMxMzlnbFNsMXZ4Skszd2luOXhVdEUxOGJZQi9jYS9XWUVrU20vTnlW?=
 =?utf-8?B?bnFtQy9qTVRxcVg5R1hrL1NkL09GVWJEYU1nNktjczVtRmpIR0VOWGYra0li?=
 =?utf-8?B?OUpDZmZvOE52d3dsdjRPNGlFTWZTRDVqQW8wWWFEWHMrNDNiVkg4bXM1S2py?=
 =?utf-8?B?Q0pML2hnZ2UxRTlIdURrQ25JSWdCaWllcW1kekJyME9UWVBSRWRoRi9lVUh5?=
 =?utf-8?B?bWJCdmYzWG1VaUp4SHlYTzhHdGxxUlBiajdYYXF5dzlWOHhIZXdvTnRNYll2?=
 =?utf-8?B?QXRoUkR0VW9LVysvcE14d3hTaFJkem1HTTlYeEF3NW1UbnBoM3pKVWJVTG9B?=
 =?utf-8?B?RzE5N0ZTV1d3OE9wTUJiUEF1bUJnajg5UTE1SnJrT2tFMHBoZThicU5QL0pX?=
 =?utf-8?B?Q1FwTmVId1VlSFpuUVdRVHhlbEJnUWM0ODhsai80bzNhZk45TWVuNVpidW5a?=
 =?utf-8?B?ZmFVaE53K1pKbzZobTZJTmRpSk9MbzUxcktmZkxvSXhwbi8rV1g4aHR2NUZW?=
 =?utf-8?B?OGRpV0FPd09YWGo4QzBGSlB1VWdVUTFSKzlUbVJ1TFBSZm5TcDg0TEdEd2hO?=
 =?utf-8?B?amRIcjNQMnZQaXAzNWZVSjFJYUU0Ykx2S1J1TExoMk5IMStZQTNYdWQ2di9S?=
 =?utf-8?B?azdpbHJWZFN5RVpaTTk1UzFpMy9wTUdIcUg0ZElnMTRncERLYUw1SE5iTERU?=
 =?utf-8?B?OS9iT3ZseTZLMGVjd3pUejN3S3RObUhmU0ZmRFlidDB4cmIvM3IwTThMYjZz?=
 =?utf-8?B?dGRuaHRQSkZMM0Y4M2xVai9UaGo1VTljbGVWN2ovS3NGUzg3amRFcmk3a0Fq?=
 =?utf-8?B?cDBHcmhnem5TYXFuMnRHUm9QWEJRUkk4bU95akxiS0lqMDQxUmhjc01DSEZ6?=
 =?utf-8?B?K1p0QUJVUEFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 16:04:13.0318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bf65d5-f81c-44a4-941b-08dcbc7abd8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621



On 14/08/2024 18:19, Joe Damato wrote:
> On Wed, Aug 14, 2024 at 08:09:15AM -0700, Jakub Kicinski wrote:
>> On Wed, 14 Aug 2024 13:12:08 +0100 Joe Damato wrote:
>>> Actually... how about a slightly different approach, which caches
>>> the affinity mask in the core?
>>
>> I was gonna say :)
>>
>>>    0. Extend napi struct to have a struct cpumask * field
>>>
>>>    1. extend netif_napi_set_irq to:
>>>      a. store the IRQ number in the napi struct (as you suggested)
>>>      b. call irq_get_effective_affinity_mask to store the mask in the
>>>         napi struct
>>>      c. set up generic affinity_notify.notify and
>>>         affinity_notify.release callbacks to update the in core mask
>>>         when it changes
>>
>> This part I'm not an export on.

several net drivers (mlx5, mlx4, ice, ena and more) are using a feature
called ARFS (rmap)[1], and this feature is using the affinity notifier
mechanism.
Also, affinity notifier infra is supporting only a single notifier per
IRQ.

Hence, your suggestion (1.c) will break the ARFS feature.

[1] see irq_cpu_rmap_add()

>>
>>>    2. add napi_affinity_no_change which now takes a napi_struct
>>>
>>>    3. cleanup all 5 drivers:
>>>      a. add calls to netif_napi_set_irq for all 5 (I think no RTNL
>>>         is needed, so I think this would be straight forward?)
>>>      b. remove all affinity_mask caching code in 4 of 5 drivers
>>>      c. update all 5 drivers to call napi_affinity_no_change in poll
>>>
>>> Then ... anyone who adds support for netif_napi_set_irq to their
>>> driver in the future gets automatic support in-core for
>>> caching/updating of the mask? And in the future netdev-genl could
>>> dump the mask since its in-core?
>>>
>>> I'll mess around with that locally to see how it looks, but let me
>>> know if that sounds like a better overall approach.
> 
> I ended up going with the approach laid out above; moving the IRQ
> affinity mask updating code into the core (which adds that ability
> to gve/mlx4/mlx5... it seems mlx4/5 cached but didn't have notifiers
> setup to update the cached copy?)


maybe This is probably due to what I wrote above..


> and adding calls to
> netif_napi_set_irq in i40e/iavf and deleting their custom notifier
> code.
> 
> It's almost ready for rfcv2; I think this approach is probably
> better ?
> 
>> Could we even handle this directly as part of __napi_poll(),
>> once the driver gives core all of the relevant pieces of information ?
> 
> I had been thinking the same thing, too, but it seems like at least
> one driver (mlx5) counts the number of affinity changes to export as
> a stat, so moving all of this to core would break that.
> 
> So, I may avoid attempting that for this series.
> 
> I'm still messing around with this but will send an rfcv2 in a bit.
> 

