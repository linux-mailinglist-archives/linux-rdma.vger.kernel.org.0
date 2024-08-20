Return-Path: <linux-rdma+bounces-4429-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D196E957E88
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 08:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029971C2425D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 06:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34D018E353;
	Tue, 20 Aug 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RhLPHSjk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E818E346;
	Tue, 20 Aug 2024 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136066; cv=fail; b=NOjlUfqHPYIH8xdxenx3Aja7hAb+DSX4o8X66EaScGQf2lAnIV74CvC1xJ8NGr6e3dAVxidou1qsrKAEjzm9K1nKZ4f8fgwxQhSFpOMQqzedocSQHsplLak/kWqSrvV7YmbiOkIPxXNQKi3spDMr+tXQGvMbFVRz5Blv1ZHC9/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136066; c=relaxed/simple;
	bh=DLK/MzeKWLy0xE8930rmiXpAk5M3nwTzfO15zYq3k3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uyFJtkGaigfiH5SruUNauoM+3b8PL0IS4cqta1A98mZhX1yBBMjeQgSOXk7PEK4zpOBoQWnDQJLP7iI1mVdJEtUyPHY1rqWhzeeMe1gzUYJJZsE5/9yNaEcJ2T5BA8zdrxrmr5wBepe1BLXRQ/SflG8CotzgdMjZ1tx4priIla8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RhLPHSjk; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfdOAp/CNDqs8ORJtI39wJ9iCHLd2zLbnBr9y6B0+NUmCpD2Obvg9HpOdmfOjsI5bGiawa3XcE0o3oIReJA4ul/jsafb45df/Kd74eGG9wQR6c8mF/+7OqwdO5ptpF79sNoUC37OJkSo9v/1rIJwCC3DVmR7pNw24IXT/R/WA8jEG0OTofVuYbt9Hzqrz/UB1AlNpHd8TcE7+y4bnSnpvbmxBLDWQuRe9Rb9mdE6EODQ8Jeubr7PsTn2NLzlgpGYDlaHGlKwUyKdZxB1zqqlYbC42HbAHlWvp0ZbUt5OMX6aJukBHwQXbNn7QM3U8eGpPqOKqkBhG4XR+lp/mWrnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+sa1Fj418OtDHTvakyCTIRchb14cYWIZq7vVdPcekw=;
 b=U07CzB9QrnZFfTg7A56Th/m+zT+dY8JO2jogC4KdOBYNiNyOgiHGbORCGmPxu7MX7UXhRcUFYybMP/53IyrMM00j/W+sRrwluQBz5RKVCblEYdfRpAwixdfKSKwsg5kHW3NqKh9mrbZD7tMxnaMdXEOjSNHgrTbdhptltlV0d5uswgQ0DaMbriGXNizyjHpIf9z/eyunZbU9hjzy1y1qHKd6/m6uxxrQb/gg4UMjK4M86Y3r1crWPd1QV1lIOl5RxJUmpSh8utityT8iY71DXpMkXuPIciTJW6mDeTpxQ1Aes8bt6r28+AVZ/TxMfhFHxzNWkZncHzVVlWWeKo+HzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=fastly.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+sa1Fj418OtDHTvakyCTIRchb14cYWIZq7vVdPcekw=;
 b=RhLPHSjkpHcSURip2y1EXcz3IejDuHIykYKmZVYl3Es1u26t5ju4x7vxwCy4zUCwyjW/oRV7u5559MRFASL6EbSRIC5YAhZ9JWQIIuON+0WgoiY2gpn0rufQJid4C1CmsOcfIA7Szz9y/DhpzmJDUbRhsif5NWgII+WLmJhgpi17VTeYJZlwF8WjDA0ClMKyQZSNtHHnVw/qq4u66Q+XIfSWaLwDYaYetWxOx+r7W4Gjl3IGPeZnjjP0INwV6JKcvNe8AoZjAXdetWd2AJwDy5ibW8bF+070/rdX2tLx6pigi5EseBZ4C2IETEsae82ZzdDwCxx+OhSPGZIBE/RwXA==
Received: from BN9PR03CA0489.namprd03.prod.outlook.com (2603:10b6:408:130::14)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 06:40:58 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::b0) by BN9PR03CA0489.outlook.office365.com
 (2603:10b6:408:130::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 20 Aug 2024 06:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 06:40:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 23:40:42 -0700
Received: from [172.27.33.146] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 23:40:34 -0700
Message-ID: <fe5c6b4b-6c78-402b-b454-837e3760c668@nvidia.com>
Date: Tue, 20 Aug 2024 09:40:31 +0300
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
	Yishai Hadas <yishaih@nvidia.com>, Ziwei Xiao <ziweixiao@google.com>, "Thomas
 Gleixner" <tglx@linutronix.de>
References: <20240812145633.52911-1-jdamato@fastly.com>
 <20240813171710.599d3f01@kernel.org> <ZrxZaHGDTO3ohHFH@LQ3V64L9R2.home>
 <ZryfGDU9wHE0IrvZ@LQ3V64L9R2.home> <20240814080915.005cb9ac@kernel.org>
 <ZrzLEZs01KVkvBjw@LQ3V64L9R2>
 <701eb84c-8d26-4945-8af3-55a70e05b09c@nvidia.com>
 <ZrzxBAWwA7EuRB24@LQ3V64L9R2> <20240814172046.7753a62c@kernel.org>
 <Zr3XA-VIE_pAu_k0@LQ3V64L9R2>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <Zr3XA-VIE_pAu_k0@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc624ee-417b-44db-a092-08dcc0e30c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amlXZURueWpQSjM4ZTVGMkpQTGkxc252ZTBUOEp2bXFmbEF2UERUakdkZWxJ?=
 =?utf-8?B?RUpQRWU1cjk2dzJObDhTNkZ1MUU1K2ZCZWN1Q3J4U0llZnQ1ejRxR0REZG5h?=
 =?utf-8?B?cmpPQnRVbVRmbzNmYTErYTBQV1VtdVN0Y1d2d21OV21PNUkxdi9hbENpbUdv?=
 =?utf-8?B?dXVYQm9DS0E1ZWVLUTdIQ09hUytCSDdVOXlwMkZHdHFVSUZiK2h6VC9Rdks0?=
 =?utf-8?B?MSsrcktVTG9jOVFmeXNaQVpkWHZQNVNxR0dLcE42bXdveFJMUVpjeGR5ZXpi?=
 =?utf-8?B?MDFQbDV6SG1vcXU3VzZnR29SL0I0WGRTdUx3ZC9KQ3hSajExTy9LV3FGelJL?=
 =?utf-8?B?elJmRXNkb3hDeWdSU2o4b0ErSVR2Z0htVEVUVGVCc2pRYmdxMk40UFJLdkxH?=
 =?utf-8?B?VVE1ZlA1T1dvTEFvcHA0NU12NmhTVlVxOUs1bG5lRXJuUFNVVkIrbjE5Njk0?=
 =?utf-8?B?RmFNRTdlVE1BY01VbFlFcm9EalF0MDBLY0dCQkpFSmdtODNIYWM4NjdmZEFX?=
 =?utf-8?B?c0RVQU51dldqL214TzNGVXhYWGtsUGpmWnBQeVNXdzhrdXpuZXpLVEQ1UzQv?=
 =?utf-8?B?cy9XSVQra2FqU3VVQVlZRS9qcnQ5VERxYjNXUlNWem14TUNEOG40RGpsRzRt?=
 =?utf-8?B?ZVVoNk5tMGs1QndZSkd0Q3IrTlQrTHNpdEduVHR5Y3JuekZTdnBlQlJKVGNM?=
 =?utf-8?B?b1M3QjdFV3JwK1AzZS9ZQUZMM1h5eXY3bll3UUQwNlNoeGZudGFrbjJVRFpC?=
 =?utf-8?B?YzVoa2ZUVFpHU2NmRXc3QVNqK1NrM2RjNERqaVdNSVFMMDZEMlA4aHNkYmxq?=
 =?utf-8?B?Y1EyYk1TZU9ybnFxb2s1bzk2d2lwR2ExOTVIQjdaWlp2NHRiYkFXOE14bGpj?=
 =?utf-8?B?L3Nhc21UQ0pjUUlRRml0dXZZa3RPOFZpdS9MYW80aTNzUEI5emlOOXVhMmVX?=
 =?utf-8?B?YUtQSDZPbS9ncjArbGxUSE1KblFQNVdidDJ3SmVWVnpBQXNXNUoxdXp3cUt5?=
 =?utf-8?B?OGlUK2tBQW9vVUFLcFlOak9sVy93bVN6L3c1T1JibGhFZ0VRNCtIbVdQdDRX?=
 =?utf-8?B?ZnczUThPUUVqcUNzREVsZGRBbU05S2VWOWxRSHZJMFdyM1JiVEJadktzR2l3?=
 =?utf-8?B?ekNQbFQvZmgxTmtRZHZRWVBaMFpIVW81WlpiQUVqNEEvUXd2Z05JOXd1K2Fh?=
 =?utf-8?B?cGVOeUk1UkFSVEpBL3orUUV2bVl5MlduS0M2WUVCUmxyUEVxdGpuL0Y4V2pv?=
 =?utf-8?B?QURDejJzTlFPTnBzK3ZhL1Brd0xtWnQ1Qk9SMW9HQTh2SFBGTkxPUWI2VzU2?=
 =?utf-8?B?T3d0a0hoam1Ud1NIMVNld2MrcFNFYkZ0MlQ1ZTVrT0F5TkN0TllSR2lwR0RB?=
 =?utf-8?B?Tmx1MlBzZkxmK0t3ZVFtY0RuNEpRT2s0cWNnTmZlZUFhMnV2RXN5WWJRYXVN?=
 =?utf-8?B?V25PVGV1UVAwK2ZQUDNqd2FyQTFRVGRoTTlCM0R3Y0RITmNpTGZLODlyTGNu?=
 =?utf-8?B?Vzl1bENvbnRtNk51aVRMVENlNHlLcGpMRmV4elMzVzY5akxHS0J4VEpiRnVL?=
 =?utf-8?B?QkgvSVlvSjgrQ3dtWWhETmYxQU9JalhCZ0M1SFlDMkoySFVhd2JQbXd4czZF?=
 =?utf-8?B?U3ZlZWwxeE5zTHU0WlUreDRsZkpnV0JPTVlOMUQxdFFCbmNUMDJpczBpU0Vz?=
 =?utf-8?B?eGRiMVk4aXNpMVZLSGcyY2p1Nm1HU24ycVJrYmZKSU5wZUVQVEVXTHFXb1Vr?=
 =?utf-8?B?eU1ieWJ4VmlyTTRGcHI1YXBQSFJyLy9KMEJrMFp0Mm9VdlNkd2ZMQjRIQmhC?=
 =?utf-8?B?cUtsR2MramJZdDZJbFU2UHNvL2NzdGVja01xWi8yWklGSUxyc1ZyMDA2OVAw?=
 =?utf-8?B?WTZjK3lMWEJoNmNzVzR6bGtDbldqZ2VLVC9ZalhaZ2V0bDh1a3NWRFB4b2R1?=
 =?utf-8?Q?8aYD7IxrpBbK4ZMgWIlVdr4vUS+CRIAC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 06:40:57.8191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc624ee-417b-44db-a092-08dcc0e30c89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630



On 15/08/2024 13:22, Joe Damato wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Aug 14, 2024 at 05:20:46PM -0700, Jakub Kicinski wrote:
>> On Wed, 14 Aug 2024 19:01:40 +0100 Joe Damato wrote:
>>> If it is, then the only option is to have the drivers pass in their
>>> IRQ affinity masks, as Stanislav suggested, to avoid adding that
>>> call to the hot path.
>>>
>>> If not, then the IRQ from napi_struct can be used and the affinity
>>> mask can be generated on every napi poll. i40e/gve/iavf would need
>>> calls to netif_napi_set_irq to set the IRQ mapping, which seems to
>>> be straightforward.
>>
>> It's a bit sad to have the generic solution blocked.
>> cpu_rmap_update() is exported. Maybe we can call it from our notifier?
>> rmap lives in struct net_device
> 
> I agree on the sadness. I will take a look today.
> 
> I guess if we were being really ambitious, we'd try to move ARFS
> stuff into the core (as RSS was moved into the core).


Sorry for the late reply. Maybe we can modify affinity notifier infra to
support more than a single notifier per IRQ.
@Thomas, do you know why only a single notifier per IRQ is supported?

