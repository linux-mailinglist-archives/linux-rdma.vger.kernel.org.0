Return-Path: <linux-rdma+bounces-2424-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A799F8C3559
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 09:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502B91F212D3
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 07:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FB813FF6;
	Sun, 12 May 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GfWwy9kW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A81B64B;
	Sun, 12 May 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715499029; cv=fail; b=SclkVJ/caJuSslF4wFOWnGKOcLIzZ2Wpdjc+QDrJrnmno0lG8tF2rklwKc9gmYbGPFULTTIhde47k7aEJnm7kpZ95MUzixB8VPmQFppBvMVymMHop7GmDQorXTmaq+kb/J3bMIoSPQL96hBYgXdjeHatWqljH/p2t2HWnFfaJYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715499029; c=relaxed/simple;
	bh=qLg1P6pXP1J5LX43pYanvsUkDsn7lh7ev2wDrFm/TzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qxs+5to/et4nR64EUjEoVGaGvgPJH2jDCp7g2Y8DMCpUTLvF2DnddvxgpKHYPGP3uTzEeDzmfwMijgXsf4DnDT57fgFnhacWor0E5kCSxxwj9xiKYIf99kdBkfGoVBboxW0Qx3CbHQwwlSUqWPJswcZfqVvOLP2+Wc4YaNoelVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GfWwy9kW; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT83Q6nfR14tl9AwsB4hU5w5HW/D14am6eQZF9Xb9Wuu/RWoRg0xeBE+pzwgocfMTvPvMrUk0QrQL0pLMep5Kx/0jfUdeEt4sYlKxf/N2qb0pAucESSnycNYuC8fSO/SkogZdfllxYbdYJwSt4mnA1xfB/6GKyxWj1FQ5FO8IWhjz4Lg/8znPB9jJnnM/S3uFsWetFPXeoMwLs6GjOorN6J5+CtZMim2D4q/CqMOLvdAWmRAPjTJFGQhNtcSJsr209kV38dPpjh/pjnYewhJ+L7j+ztHjs6I1lEDmkI6CQ/llyPdHq+79xqB0ANyHe9KoxTFq2/5pkGQH9Lku3nilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyZ78J9rUkDsVwpWZAryMD5rc609w2NZBxPZX133Vqc=;
 b=MqhMrvHhZBIpV5zLu5yFWxH776irIc4cfleKM0M1oRh20FenJftx9BKiCf73KPHWA2CUNcfwWv38ET4JCYky/glp7EJPIZRIGXezipPE6Y9bRnlRCcmSQScQGDUWu2KU4x5Ms3NCCUZtFlpyTB0Zn18Jw606gvf4b0HkkYlsuOKGsXJwk/5ARruk+xX+qUvL8IyX1hh4Xl8D4aMkEcmdEUjkpseGbndnkdhsAJ5T3OLbRCppC+fUz05lD/tm4Osqapm7m6YoTnlqGYqHqGUnPEgLVrk/bUyfkygQodv+3Mry0zAJpyQUqhfC58ofFHSK184K/aC20EtYTzjAqNzCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyZ78J9rUkDsVwpWZAryMD5rc609w2NZBxPZX133Vqc=;
 b=GfWwy9kWJtoMv7HxeEHbo9sgZDZRvmJPXCxS2bCHTrw/fFIXxCWAAzRZfJQWDpS5YMdXZ2z0QC/7hhQppl33ELeSa2dZrn0mJnHHSwYsFL9UPakxj8dvnM68KDQiPBC3S+7oM8CE41GE9hb2tdwn2rT3V27yUp63eNZEGjtJgOf/eW46vBMWlyH/PHKCIsQSXsnN1uHBRh3kHFBwncB3yjuT54TX430nECjl4nzC1hpzTTOZxWeHBvLnNrs8T9ZyY2C1C8EOlqq2Yv2u0AlS9LGhX64Gyto/pW+1Q2jp41ObKblYHB5gzsAJKLvGJ6uyh1IvWRe4/xVOSx7LZpwM/Q==
Received: from PH3PEPF000040A8.namprd05.prod.outlook.com (2603:10b6:518:1::4a)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 07:30:24 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2a01:111:f403:c801::1) by PH3PEPF000040A8.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.21 via Frontend
 Transport; Sun, 12 May 2024 07:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Sun, 12 May 2024 07:30:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 00:30:10 -0700
Received: from [172.27.19.54] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 00:30:05 -0700
Message-ID: <b3baab48-647e-4ba2-9d0a-fcef64984e56@nvidia.com>
Date: Sun, 12 May 2024 10:30:02 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Greg KH <gregkh@linuxfoundation.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240509091411.627775-1-shayd@nvidia.com>
 <20240509091411.627775-2-shayd@nvidia.com>
 <2024051056-encrypt-divided-30d2@gregkh>
 <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com>
 <2024051038-compare-canon-4161@gregkh>
 <ae6e151e-0c34-4ff8-a9f7-40e4cbdb9dee@intel.com>
 <2024051114-gladly-feline-4302@gregkh>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <2024051114-gladly-feline-4302@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c3a69d-8ad8-4f89-331c-08dc7255635a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0FBZWhsNEJOenQwYnRnQ2VHOXJxWTdkYmVHS24zNXc4SW8yR3ZCa2Q2MEdj?=
 =?utf-8?B?ZXBra1llUTg0VGt3Y0E2S0YyMVVZbGRnMlhWOFdYNFNpWFAxb1ViT21nRitm?=
 =?utf-8?B?aFY1Z25ySlpSVnh3YjNBM0grSm9kVS9Mdld0alpZakNTNHNDaTN0cGJGVzlr?=
 =?utf-8?B?ejRtZVl4S20yV0o4SW9rb0I3ckJZMGNoSzMrdnFUTEdBRkxlRENqZktROU9G?=
 =?utf-8?B?dGF4L3c3WXhXeW80RmdCSkhCYzk0b3liN1ZYSHp0S1B1K3J5TWFvTm13SjdK?=
 =?utf-8?B?OG54Sm5NTTNybVNaQkREcEdQZDFDakxxUFBqVnI1NXZtNlBjVUJ0OXk1U2p0?=
 =?utf-8?B?MTVFUmptOEdraWVWQ2I1YnJrQXNmdVhRTkNSQXlOOFFyM2Z3akFqTjlDdzdN?=
 =?utf-8?B?NFh2Sk9vR29tbnZXR3VCOVltZDVsV205NjBUdEY5T3pzaGFvR0t5Yk9RVXJR?=
 =?utf-8?B?S0kzaGhlN2pOZmFLUWV1bVF0ZXF0bkx5OElDaE1aendFMkhOWDc4NlU2WEsr?=
 =?utf-8?B?cHZ6T0lIZ290SWUvSUJUWWJUZ3J0M3drTVhPMmtsL2lBc3I5bmtOVHZ1YUUr?=
 =?utf-8?B?TEdxdlVjUWc4T1VOVUdYdWNqTUkzUDdJUEF2QUluVWViY3lEODZ4WnZVamps?=
 =?utf-8?B?Q1FTdVJQQjBoUXBTVHBkWDBESXBKei9WZmoyTTY1YThOZ2Q5bmRYdWZCVnQ2?=
 =?utf-8?B?MEN0ek5pSFlWNThQQ1Y4YVVTaFlieVp4cFhsRDFkU2QvNFJ0VkZhcnk0ZkNi?=
 =?utf-8?B?dWgwdjFYZlVKMUliQ1l2OE5USDMyemxCdVBPQTYwWmdRRDc0RVJnbVpYMTZP?=
 =?utf-8?B?dGQ5cEk3Sll5aG1vV0t5S2lRS1FNZ2wrTVA0NXY3aGlKTGVVdVl5ajBKalhy?=
 =?utf-8?B?S0tQTUlhbEdLUHl0QzRJclIzbjFWMC96dzcwZTRJTHU5RWN2N05NMVBJZ0F4?=
 =?utf-8?B?bHZNNCt4NmZQZmY2bEp1T0MvNWFkK0tiUTVubDBlSENHNVhQbnEzVm1HNE4w?=
 =?utf-8?B?SURxanNEUlg3VFJ6WFBQVUMvd2pNQ1pJU0NtQ2VDUCsvcS9KVkNqYWY4aHJi?=
 =?utf-8?B?M29ZUkt0eTZJWFIxcG9oaDF0RlJjaU5LODljRGlNRWkzbmNxSjhkM1BNRmdX?=
 =?utf-8?B?aXc4MXQzUjU2KzFDR200SWVkdWlvS0Z0Vlg0ZGd1Sk5uUTNMQ1pNQzhhNVdq?=
 =?utf-8?B?RmZySER0dkJTY3A0Rm1SRXpYTmxNdnFNdXRQbENNV21ZcW41Z2JYUUUxYmtn?=
 =?utf-8?B?ZlAzN3hZZGw1dmhDUlByRHVKMit6aUVMQlkyK2c2RjNJeWpPcFc3UEl6KzUz?=
 =?utf-8?B?Vm1FcXBMbUJ4WFc3Q0VPbExFdlVOZTdhYk5YWEdhR2o2Q0ZDOWJFZGpNaGk3?=
 =?utf-8?B?ZkZXUkRWRWVFY0Y0K0xEVEtkZ292dXZjbmlqSHlXbEdpeGMwaVdqWEVmUWtr?=
 =?utf-8?B?ZWRjWG5uRnkrNW4xSnlNL05pWFk3U0RoeFhsUkx6QVlHcFJuRy92R3dZeG9Z?=
 =?utf-8?B?ekEzU1c3R3E4T1YzL2UwVFoxUUtRUU4vbXpZVWJTcE5uZVNpR1I0aytGTG1W?=
 =?utf-8?B?QjA4bFVocFVDVEd3aGZLc0VOcjZGRlFIcitCcG1weS9iTnRBVDFSdVVjcE5r?=
 =?utf-8?B?dG9yNUw1dEhQWTdaR083NzNQTWdEazVSdnFNU2kwcGdwOUExUjBXSnlBTk00?=
 =?utf-8?B?aC9lcVNtOTAxdk5TU3dUQ212dzJteG42L3o4ZFVmRFlsSmxLZE1YdDNseDBC?=
 =?utf-8?B?dUdVdkRjWDhWL1AvcnFtKzlzSHRYbkg0U01xNzF5NkZTY1BwTStGR0RnK1Zu?=
 =?utf-8?B?QllXWUl5NmxCT053bjREMnJmWkIzRHJ0YnZnbkhhUlZrdDh0czZMampjSWlY?=
 =?utf-8?Q?QOb1Z9vu/WWWN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 07:30:24.2847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c3a69d-8ad8-4f89-331c-08dc7255635a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227



On 11/05/2024 10:44, Greg KH wrote:
> On Fri, May 10, 2024 at 04:01:01PM +0200, Przemek Kitszel wrote:
>> On 5/10/24 15:07, Greg KH wrote:
>>> On Fri, May 10, 2024 at 02:54:49PM +0200, Przemek Kitszel wrote:
>>>>>> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
>>>>>> +				       struct device_attribute *attr, char *buf)
>>>>>> +{
>>>>>> +	struct auxiliary_irq_info *info =
>>>>>> +		container_of(attr, struct auxiliary_irq_info, sysfs_attr);
>>>>>> +
>>>>>> +	if (refcount_read(xa_load(&irqs, info->irq)) > 1)
>>>>>
>>>>> refcount combined with xa?  That feels wrong, why is refcount used for
>>>>> this at all?
>>>>
>>>> Not long ago I commented on similar usage for ice driver,
>>>> ~"since you are locking anyway this could be a plain counter",
>>>> and author replied
>>>> ~"additional semantics (like saturation) of refcount make me feel warm
>>>> and fuzzy" (sorry if misquoting too much).
>>>> That convinced me back then, so I kept quiet about that here.
>>>
>>> But why is this being incremented / decremented at all?  What is that
>>> for?
>>
>> [global]
>> This is just a counter, it is used to tell if given IRQ is shared or
>> exclusive. Hence there is a global xarray for that.
>> And my argument is for this case precisely.
>>
>> [other]
>> There is also a separate xarray for each auxdev (IIRC) which is used as
>> generic dynamic container [that stores sysfs attrs], any other would
>> work (with different characteristics), but I see no problems with
>> picking xarray here.
> 
> Again, why is an xarray needed, why isn't this part of the auxdevice
> structure to start with?

If I understand you correctly, you are referring to the xarray of the
auxdevice (not the global one).
If so, instead of xarray what can be used by the auxdevice?

> 
> thanks,
> 
> greg k-h
> 

