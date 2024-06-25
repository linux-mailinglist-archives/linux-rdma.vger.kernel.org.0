Return-Path: <linux-rdma+bounces-3479-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A33916F77
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 19:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565CB2823E8
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 17:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B840216F0F3;
	Tue, 25 Jun 2024 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BiKv/tSE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02392135A69;
	Tue, 25 Jun 2024 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337348; cv=fail; b=kVWtjSR17Bs2hGrgPIT6ft05sT09GmTjz11McnxjieNtVqeK/XN+zZVH6A5JOVkYuCIsVmg7U2Q1B/k/6xJUezjv4142tiJfk2vSie3W/BpYF/D6BFzlTHmxxBTfeVoZxZjXVJBKjNAV1rpkp5+zkVZUWO0/cHxlrSESQMUMMlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337348; c=relaxed/simple;
	bh=9fUjHu6h6VBWObQbJOPs3U4LDOTz4LVeP72y1JqXF8c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Ux9kvPQ0FNwtFdAlw6Sevh5MlrYxvfgcXO5ITWYslhvdcTh2zapp2LCIen7c7nKYkkXr1tfFcpTM6z88FB2aI2eGPWqqb6jTcYYnoqUp8uJfBDWEykAG+cCK9+dQHjvGetjkwCIclmWLwycpdOyKZcL7zlmVsSrFEhsvqbcMWIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BiKv/tSE; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP4X7CDHKVdANvYtVDqIYmRMJTk9ROsyX/VXfjME177uyoSN06ZLR8RqdI/8Meq7SgKNq69djwaX4tfF1AK0pNHB+n/HJS3FHgLyvUTeWJdWt91cmgy3BaayEKWxoWnaYE+iXmQyjtolY+QfzY5HU+zov3F6DTFx3/0Ov59g5UJw+piDbU0hnQmu8yQVN+6l/mTTMA8c9WOiRa1475zE/j+N+t0GViPYvcM91fmKwGJ689nwmcnv+Z1mms+it0U+HEGRBtBkc6Wbxi0gZUPPzPzTvw7mUeBB26mj7w+E0bOQl+5GrUjfQcB7LZHTiBFQVvK6diVt8sD2oEKkotjonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knuPWhS/yG0oypA8MX9zOb4g430+XVhjSFW6KORYfGA=;
 b=SlJ6OwLGqEETDh0dbvp7kkOwR06DXwrMRh1Ax/EsSogvXF3h9KGkJES+IEg8qbgBLA49S2UBiqzxts2eu0CPqrx1AXsyIjK+KOzxOCzJM9/MLl06VpvSAEDH3ljFp5Of0eqXuP+HWO7II+fpR96yjFS9xSu/hHTMML2D/39uZ7Wrt943MDiMFv0HCyjH5D1SSxZ8ZpfrdOZImrPyhGsObyXlKoCS5n2mrCDO3H7JkQrO3nw0lxsJ7IgiZxweGkrjxANQAiTdPJTNKw2g7CbFEu6ZJBr7qIgnDATA5qPru/2ZktiqFPrgFP9iRCXI/yttaQO/XDDzwpWKsePkUtJf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knuPWhS/yG0oypA8MX9zOb4g430+XVhjSFW6KORYfGA=;
 b=BiKv/tSEH5gTsdmd23OXqayPtYKDlxpGYKhYHLxih9z710z7SLXEvma+vwrC4AjFiwwywYjKrw1gg/pyOBYjwaXd8YjNl/w99Ch1t8N1ubbDE+0cgMstJ0IQ9L/A/vGZb/I2RVHdJ4busv+4jE9umRa7uUPGEbuVMWTQKQQ+HRAave1TgDrvvNDolQrhg0osnD6q1Mxg4gJwGLLThbmolz8qIhhYcJhLKOYx2AvQ6TZJrIfoWdCC3Psht0vROSd/0eypS2+kk2mhba4q8Go2uL6+k1Vio/QTZ4qdxiLXwYUqlUJEQgqev4355bcdHesmVLcSne3s2z+7dHWU1bznjw==
Received: from BN0PR02CA0052.namprd02.prod.outlook.com (2603:10b6:408:e5::27)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 17:42:23 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::e8) by BN0PR02CA0052.outlook.office365.com
 (2603:10b6:408:e5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 17:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.0 via Frontend Transport; Tue, 25 Jun 2024 17:42:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 10:42:00 -0700
Received: from [172.27.21.62] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 10:41:56 -0700
Message-ID: <8d83145d-7eb4-4c12-97b7-799a0236f7bd@nvidia.com>
Date: Tue, 25 Jun 2024 20:41:55 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
From: Shay Drori <shayd@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240618150902.345881-1-shayd@nvidia.com>
 <20240618150902.345881-2-shayd@nvidia.com>
 <2024061849-cupped-throwback-4fee@gregkh>
 <21f7e9b8-00aa-4e1f-a769-9606834a234b@nvidia.com>
 <2024061903-brutishly-hamper-af47@gregkh>
 <38bba039-aa2e-42fc-aae1-26d131cf081b@nvidia.com>
Content-Language: en-US
In-Reply-To: <38bba039-aa2e-42fc-aae1-26d131cf081b@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CYYPR12MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ba4d56-4e89-4d88-31ee-08dc953e2b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzdDWUljek9VZWJ4ZHlWeTlRSitBVnJJaWhOY0k2QUxUcktiOWozOTZwZFgx?=
 =?utf-8?B?WnorQThWanllOUNhU1Bsa2lPOEhXU3VDK0dSVWtHbnRhV0ZHVVFjZnQvQ3JX?=
 =?utf-8?B?Q2N4aWdrL3JzR2lTanlxVW0vS0ZhbjRpYmV0bEpORUpOTE12Ujh0RXVZVDVy?=
 =?utf-8?B?U0V6WjR0elJBZXNpQi9tOWpYampYSXhPeFUzUXR4UG5yT2h6VWpFdytobzNH?=
 =?utf-8?B?b3VuWklwVDVrRThYWUhiRHovaVh0SlpmZlkvU1h6a1FrcmVSQURMbXlhUW1l?=
 =?utf-8?B?eFJsUTBndlJsU0V2amZCYXQxTjgyclk5NDRKbzRwL3U2NlFLNmlRSnp4Wk1v?=
 =?utf-8?B?WW1TbDNyZ1BaS2YxTWRtYkp1d2VnaFNvMWMwR0VidGtQQ0cvTVFzSVZDTG9W?=
 =?utf-8?B?K2hSc1JMMG1tdEVoM0JPakRmT25VTU5TNU9tbmYvNEhaK2hwQjhzQTFDdW8y?=
 =?utf-8?B?cmZPREtxb2ZWK0UxYmlVQTlVQTdPSWIyZGIxU1hXcnVrcklkV0dVUG9aMUpw?=
 =?utf-8?B?eEd3VWJ2d2I0dERvK3JhYVZsdzhCUjJPZFNCRVpMdExUcXZ1Tm1NOTRTN24y?=
 =?utf-8?B?b1N4Mk1tbU53ekd2MnJaVXhJQ2xCVGg3SUdDNVFGZ0ZmMVFHblFNdWFicGZG?=
 =?utf-8?B?SThnMEFoYVBwSy9TeUxYNU9VR2ZqdkVyM3ZHZElXMUtNRVhtRzVQSzQ4T2lZ?=
 =?utf-8?B?MUN2VVNFL2ZCb0dEWGZBS0pjdW56STJLUjFrMUV6d2ZqNVlQRUlxRkNqejBW?=
 =?utf-8?B?OHRPRHM3VVNXRE9leGFrS2ROcFJURnB1Mmx5YkR4TzRpTFUxVlRUVGZxL0hG?=
 =?utf-8?B?bWVDVm5na2VpVWFOVjdNTjRiai9XUHpLeUJXZzBFdWlGeCtZTHo0aW5mYnR1?=
 =?utf-8?B?VG8xM2FjdUVpczZOMWI5dGJUSHhCeUwwTlc2YWk4cGVJcjVCd29SNWhvUUVU?=
 =?utf-8?B?Y21UWGlPMTN1Y0FRNzNuMGNUanJVWGt6SXdCcmxrS0EwY0VDNVVrTDYwUTQw?=
 =?utf-8?B?Vllwb2pRWmt2R215eTNLNEJjQVp0Zm1jL2ljQ1R6V3JYR1pHUXRBWktQcWpi?=
 =?utf-8?B?ajduTnVBQzQ1Qmlndm0rSEQ3Y090UDNUNktwcTNvSkwydUhEL2tMQW44Ykd6?=
 =?utf-8?B?ejhQdGwraCtiWnRLZis4TVlPR0ZQejVZeTRYR24rM1ArcXNUSndpSzZtT0Mv?=
 =?utf-8?B?OW4zSGVKY0tuOVIyVCtXNzM0NXFtdjY4L1R3TkI4OEhDZmVBQjc4OVpaQTRp?=
 =?utf-8?B?cTQvbno2WFNiRHZmMHhqMGF0WUFsbnBZZ2tqSkxFNVRvTnZEdEhrTkpFQ0E1?=
 =?utf-8?B?aytXTlV3M0xMc01nTkk2TmxxdG9SWklKcXp6eHR2QXZKN09CMUhHOWwyT3do?=
 =?utf-8?B?REU3SFdFWjJSOHBpVGhPZytLb2VjZU52V0ptYjhuV2Y2eEduVDJTeXFRRXVm?=
 =?utf-8?B?R0tyWTlWY1ROdVIrUUJUbGdwR1JLYVA1b09ESXBzV21QcUVDTVovMUhUdzla?=
 =?utf-8?B?OHgzYmlHRzRteXlLVXpaV3JaVHZkQmtXUElEZ3dZcVZXTy9oczBlb29RYTlI?=
 =?utf-8?B?SldMWjBjV2loZHF4cHpsU0NsSC9qWjRhb1V0S2tHeDRoak11K3JMSlp0enFB?=
 =?utf-8?B?ckFSa3cvTThXMVpTSnZVVEYvb0tORkhOWmNIdERhS05VZkN6T3NjNXNIcmpI?=
 =?utf-8?B?RHRLTHlKUzdIdk1GUm5nVkRhQnRPUlJMcjJZTEtydGtJb3QyYzI1dlRaK1pQ?=
 =?utf-8?B?WmVQU0RPZG5ROXRpeTFLNTd6ZlJKZnBsSytreWNZbEFuZzBvM3hNRWRHaHpm?=
 =?utf-8?B?YmN3VzROb0IzQkRZVTg4bTZ3Ym9jYmZiL3psMlVHeHNKcTZLN0FRejZqNzFY?=
 =?utf-8?B?a1RnaC9iRVpuWkFBUDF5RjM2bXUvTWRhRTZ5ZW0ydHpUS2JPUVRscVZtUDd3?=
 =?utf-8?Q?ef0AzT/36AT6cgBeupDtxYomFk2MLVxq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 17:42:22.7610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ba4d56-4e89-4d88-31ee-08dc953e2b79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653

Hi Greg

On 20/06/2024 8:47, Shay Drori wrote:
>>>>>         u32 id;
>>>>> +     u8 dir_exists:1;
>>>>
>>>> I don't think this is needed, but if it really is, just use a bool.
>>>
>>>
>>> If you know of an API that query whether a specific group is exists on
>>> some device, can you please share it with me?
>>> I came out empty when I looked for one 🙁
>>
>> Normally sysfs groups are NOT created this way at all.  Oh wait, they
>> can be now, why not use the new feature where a group is created by the
>> core but only exposed if an attribute is added there?
>>
>> Will that work here?  See commit d87c295f599c ("sysfs: Introduce a
>> mechanism to hide static attribute_groups") for details.  That should
>> solve the issue of trying to figure out if the directory is present or
>> not logic.
> 
> 
> thank for the suggestion:)
> will give it a shoot


I tried using the commit you mentioned.
the commit introduce is_visible callback, which being called when a 
group is added to the system.

Hence, auxiliary driver needs to know early when using the static group.
To know if to use this static group, the mlx5 driver needs to pass the flag.
But the whole point was to avoid passing that flag.

Do you suggest passing the flag in __auxiliary_device_add() and use it 
to is_visible trick?

thanks

