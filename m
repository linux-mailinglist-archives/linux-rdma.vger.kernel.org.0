Return-Path: <linux-rdma+bounces-2659-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6324D8D2DB8
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 08:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C28284F47
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 06:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E421607AA;
	Wed, 29 May 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6ugVCtS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32A273DC;
	Wed, 29 May 2024 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965935; cv=fail; b=ky/sMYqd6eMN32J9nXcFutuKNWVQA4MWbqxa9pd8LhrApvFDoqeO2CewfrytuC6gFSiSkrmyGXc+6HnO4y0XCZW7REgoIT6JBJRYIKl2SBqp4LD140JJH0bghG09tKDQu+B6LkXYA1gLBppFDnZdy+7Ua533i7JDzXXe2giUQ+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965935; c=relaxed/simple;
	bh=7bExyWVGW1tvNV9GYtEGEVOyqpXK1iHfLHYKW26N7d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iP6sNdKEi7NxjjqVpIYShVkDHBHKUX6+zKavou2Gcn1DOI9VS31NUSUzDNbyhp2yFBrOceEYVBWwGNa1mAVVu9BcLAEwS1GEPBG//bgeNG8HN/Z+Mh8oS80sqbaRBmmC+ba9gaBCTRJa+HXS8Y6D6dXpVs169ZqUEcxnnH1iHDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X6ugVCtS; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kn83ZIpct+bCU5tkeP7twQTS1CDWU/jtYKjPFUaDatnZ8SqGSkNXecWWsDl1A1fvfJbYEhVUb/Ss6aHNGAhDMLH9UZAo03k7GSTu1UrJWcSiYRiwZ0Xi6A6S/3r8qMOBdzkGf9/p3wkBwfE+sWWvk7q5692HWUUI1TTlteE3aOAAXPUjxXBP8KiH6TpppJW32lvAvye0RLkaB/Znsr/sl5ovrML+9a7e9RHv2Wbw8MQUwlN4ZTDhEU551vDLNfCfVS7Cu4fmI4SIJVOgRxmoWS8D/UmHnOLtrRI8/RfNGndIUXkaKBT6oLc5JZHEYc0kN6x1z1Vw8B3oe+vi+V7/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSK/R3XPsXO5NTNZSanu3NEcK6L+jbwJXzUTpoWr0nA=;
 b=EOqqfdfhIZshPETGMTSJAuvqXKV/7W+WQH5VyjgFaHOa3faeSY/Sz8U8Y3sHBLtVxJYxYrEinIQ9BHSUOLN9jYfrU4sx3VyHW9sh5WyQdnbRmxFTFrokibY8zsoNlY0X7CmBVnRjCe/SSS1fawT2j+AA9Zu40ybpJnksKDPhLRDXm/dzSyErc1TBNw7jgWoEIjA3Qixa8QHK6jxeVrkQe8uOaGQprlxKEERbC0qGEfgTx+kZXEPcgAJpvBcNompf0hTWWoPBus/uJJ/Zw1uCDa0Z9QBCrh5zpQJG6yaHoWolqjK/hTbppDKKRGaG5pjqZCNk5Ljv3ZPsauQdGX0a5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSK/R3XPsXO5NTNZSanu3NEcK6L+jbwJXzUTpoWr0nA=;
 b=X6ugVCtS84LHJAwS2j1ZnKZaIpaodwokTY5zo+9IDUjyvc//ZMLkw+O6DZKVs0xMH7Vq0tgPYhzSTOxsvJnKn482sUun4hRFsWqwGr4Bibxv+d5FMtVfp+KsEtlHKRgDcGmJIlz9yvfs2pJxiaX+lrRIUZKAy3D0O90b43G668GgNrdTtU9Maur1aPlh6zo1WNPebx02MWrkJBCCOnVp1R6smM51MCMT4xs1LLRPlG86jkJI7361Ldi5vgfuChjjw7EnoW3JQejgwObBNcyss8A1lbcszpTbgZgkYTTZXfjr171DUAYsnL9Jt2Rs7KORTPjiejkLV6ec3ZhIDk64UQ==
Received: from PH0PR07CA0053.namprd07.prod.outlook.com (2603:10b6:510:e::28)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 06:58:47 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::df) by PH0PR07CA0053.outlook.office365.com
 (2603:10b6:510:e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Wed, 29 May 2024 06:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 06:58:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 23:58:32 -0700
Received: from [172.27.34.245] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 23:58:27 -0700
Message-ID: <e6b0a89b-a369-410a-9cf8-f9beabed6501@nvidia.com>
Date: Wed, 29 May 2024 09:58:25 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<gregkh@linuxfoundation.org>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <david.m.ertman@intel.com>,
	<linux-rdma@vger.kernel.org>, <leon@kernel.org>, <tariqt@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
References: <20240528091144.112829-1-shayd@nvidia.com>
 <20240528091144.112829-2-shayd@nvidia.com>
 <8b8a42af-afe4-4b53-b946-f60e10affc2f@intel.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <8b8a42af-afe4-4b53-b946-f60e10affc2f@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 77af7afe-18d3-43b0-e00d-08dc7facc9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|7416005|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ky9PaE4yVXErSytwS25GYmdDQ2J0Z2RROTdjRm40VjRJNUhCVXV3cVpCSWlD?=
 =?utf-8?B?SldNNWdDREdNMDZwakk1Umt1V0liVmkwYjJuWHlmRUJ1REJXWE5KRGNKbnU1?=
 =?utf-8?B?dWRyK2ZRQmhGRTE4VHR3Mi9nbzdXSkVlMHliRUJsUzZjYnBVclhpcFJsY3VW?=
 =?utf-8?B?U2hoREp3dFRwMllTYWJsS0dUL2JPNkU4VnRiWWNrTTdOd1RjL3ZOREwvY2pk?=
 =?utf-8?B?biswL1FPN08zQWlMS2pkZEF6TWdzN2lQTUgwUkNKaEs0WmpUMnBPNzBXa3Az?=
 =?utf-8?B?MEppMEFMRTZscDdwS3VvcW1BMHpCRk5xRlVSSncyOEI3QklDWU5qMnZqRWNU?=
 =?utf-8?B?bjJ0T0lzQXFtWGFKdURCNW1FcEVQS01EUngvakdya1JyMmx6MzQxTmFJSzB6?=
 =?utf-8?B?VjBTTzhqb0xaNlYrbnZlSVE5Y2RCYXVCTTFOL1JpZC8xWnJ0VUJ5TDJYSnpB?=
 =?utf-8?B?SE5tQzdrTnhNbHMxaEsvSkNmS3lRelBCdWhmK0wxSEl2QTFWYkVUNUd5eU5n?=
 =?utf-8?B?b3grWExRZ1VZTGNtMGViT1ViWDVUSGdnbFBHWDVsWWdUU3RMbmRBZTk3d3dI?=
 =?utf-8?B?bjl0aTVidHdmcFpOazBBSDVpWkR0N2FGUGU5U0k5ZmY5aklYNUJLNnZuSUZB?=
 =?utf-8?B?MDk4dmxFdjkvVGtwZGhlRzBaUHF5dkd0bHpBL1dRUjRkUFFlNW40ellJNi8r?=
 =?utf-8?B?bkhKb1JyTnlxTUsvNkc3VGRUNEU3VDFYVmxzdnhaOEFOQk92SEFCRW1tWG9P?=
 =?utf-8?B?cUNRUTFVa2NGQ0R4SkN0VExWaFNXTWszZVFXYmJRdWFKU1VHTDZwcWZZMzA3?=
 =?utf-8?B?UzlQMnM0bytKMXdVeTJBQVY0WTVrc2xocHJrc0R6blBqeS9XTldtY3hlN0dw?=
 =?utf-8?B?MmxhWkIwNjNzV1hsVlhBa2hIL1F2aE0xdVRMT0NubW8wQ2lOcjk3aWxiT1pC?=
 =?utf-8?B?Qng0bVl1VVoxejdGeC85SUd2WEZDT0dOM1cyOUNXakhWbWU1bS9aZ2FHbTNP?=
 =?utf-8?B?RVRNalIvd1hsNk14bFVBa00xQmtCUFN2WlJERy9sYXJ6MDhnWDBDZ3dUcmlG?=
 =?utf-8?B?U1NuUjZkTk5zbU1sMllXL1FyaTFLTkIxTGtISTJUYkxRNmROMm9WdGVNeUdr?=
 =?utf-8?B?TFlmUDRmR0xsZ1dkRUFXSkpuWlR2RzltbjNPOUZIanFrUktNdTlXUlJHRWtr?=
 =?utf-8?B?WjBBbmYraXl4bVNncHNoL3ZqVTFYY3BvRjhIVXB6VTZWTGZYbklWR2lnSTQ1?=
 =?utf-8?B?MHpEYlExNXpTdHhwS3lTQW5uOW56eFZDNThPcEx4dFBqVEhlOS9RV3BtVDZI?=
 =?utf-8?B?aWMyVVZHcllrckF5LzFMczJsQTF0QkhLWVR1TElESm8wNEJ5TW5oUUVLaGho?=
 =?utf-8?B?WE16UHB2K3NxbEVudjBldG5saDVtY1pXb2N3b1JsL1lrYjRNVWlwMmNOK2ky?=
 =?utf-8?B?aW10eTNYWERSWlFMZE5DUHpNalJZa0tsMS9sQitsRnNlUFlMVGhNWENVK0Jv?=
 =?utf-8?B?ZnZuRzhyVWFVQ0REMDZYMmlZNHZKWkpEZkF6a2VOaFc0ekErdnpvUExBTjh5?=
 =?utf-8?B?RnoydGZBOE9xYVJ1aUJ6SlVncFF2YThXc1RlUWxjb1VTSlNMWWdvUHIyY2lQ?=
 =?utf-8?B?a2FEamF6QXRuOCtOWFlPWjVvWGpmNEphbDFtTlFGQVVyOFhOaE1SNmJ3am5J?=
 =?utf-8?B?WXhXeHVQTllOUkt4RFVURWZDdjZjWHBTZ2ZXeThRTVBlSlBtZFRPeEJoSHhK?=
 =?utf-8?B?T2o0OWJnZGg2Tzd1WGNWRFNFdE1uTGJJNXJvWkJjS3oxTkdISUVOT2pKS3Fk?=
 =?utf-8?B?MjI3aythUWRrS0xPNVdGTzZ0bXE0N3BFcVM0enV2bDNJNEJEOHZTMXhaRDJM?=
 =?utf-8?Q?snmo8HESqCa0O?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:58:47.2751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77af7afe-18d3-43b0-e00d-08dc7facc9a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340



On 28/05/2024 17:43, Przemek Kitszel wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 5/28/24 11:11, Shay Drory wrote:
>> Some PCI subfunctions (SF) are anchored on the auxiliary bus. PCI
>> physical and virtual functions are anchored on the PCI bus. The irq
>> information of each such function is visible to users via sysfs
>> directory "msi_irqs" containing file for each irq entry. However, for
>> PCI SFs such information is unavailable. Due to this users have no
>> visibility on IRQs used by the SFs.
>> Secondly, an SF can be multi function device supporting rdma, netdevice
>> and more. Without irq information at the bus level, the user is unable
>> to view or use the affinity of the SF IRQs.
>>
>> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
>> for supporting auxiliary devices, containing file for each irq entry.
>>
>> Additionally, the PCI SFs sometimes share the IRQs with peer SFs. This
>> information is also not available to the users. To overcome this
>> limitation, each irq sysfs entry shows if irq is exclusive or shared.
>>
>> For example:
>> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
>> 50  51  52  53  54  55  56  57  58
>> $ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
>> exclusive
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Shay Drory <shayd@nvidia.com>
>>
>> ---
>> v4-v5:
>> - restore global mutex and replace refcount_t with simple integer (Greg)
>> v3->4:
>> - remove global mutex (Przemek)
>> v2->v3:
>> - fix function declaration in case SYSFS isn't defined
>> v1->v2:
>> - move #ifdefs from drivers/base/auxiliary.c to
>>    include/linux/auxiliary_bus.h (Greg)
>> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
>> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
>> - Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
>> - Fix auxiliary_irq_mode_show doc (kernel test boot)
>> ---
>>   Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
>>   drivers/base/auxiliary.c                      | 165 +++++++++++++++++-
>>   include/linux/auxiliary_bus.h                 |  24 ++-
>>   3 files changed, 200 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary 
>> b/Documentation/ABI/testing/sysfs-bus-auxiliary
>> new file mode 100644
>> index 000000000000..3b8299d49d9e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
>> @@ -0,0 +1,14 @@
>> +What:                /sys/bus/auxiliary/devices/.../irqs/
>> +Date:                April, 2024
>> +Contact:     Shay Drory <shayd@nvidia.com>
>> +Description:
>> +             The /sys/devices/.../irqs directory contains a variable 
>> set of
>> +             files, with each file is named as irq number similar to 
>> PCI PF
>> +             or VF's irq number located in msi_irqs directory.
>> +
>> +What:                /sys/bus/auxiliary/devices/.../irqs/<N>
>> +Date:                April, 2024
>> +Contact:     Shay Drory <shayd@nvidia.com>
>> +Description:
>> +             auxiliary devices can share IRQs. This attribute 
>> indicates if
>> +             the irq is shared with other SFs or exclusively used by 
>> the SF.
>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> index d3a2c40c2f12..579d755dcbee 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -158,6 +158,163 @@
>>    *  };
>>    */
>>
>> +#ifdef CONFIG_SYSFS
>> +/* Xarray of irqs to determine if irq is exclusive or shared. */
>> +static DEFINE_XARRAY(irqs);
>> +/* Protects insertions into the irqs xarray. */
>> +static DEFINE_MUTEX(irqs_lock);
>> +
>> +struct auxiliary_irq_info {
>> +     struct device_attribute sysfs_attr;
>> +     int irq;
>> +};
>> +
>> +static struct attribute *auxiliary_irq_attrs[] = {
>> +     NULL
>> +};
>> +
>> +static const struct attribute_group auxiliary_irqs_group = {
>> +     .name = "irqs",
>> +     .attrs = auxiliary_irq_attrs,
>> +};
>> +
>> +static const struct attribute_group *auxiliary_irqs_groups[] = {
>> +     &auxiliary_irqs_group,
>> +     NULL
>> +};
>> +
>> +/* Auxiliary devices can share IRQs. Expose to user whether the 
>> provided IRQ is
>> + * shared or exclusive.
>> + */
>> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
>> +                                    struct device_attribute *attr, 
>> char *buf)
>> +{
>> +     struct auxiliary_irq_info *info =
>> +             container_of(attr, struct auxiliary_irq_info, sysfs_attr);
>> +     int ref = xa_to_value(xa_load(&irqs, info->irq));
> 
> just a note that you forgot to take the global lock here

correct, will fix in next version

> 
>> +
>> +     if (!ref)
>> +             return -ENOENT;
>> +     if (ref > 1)
>> +             return sysfs_emit(buf, "%s\n", "shared");
>> +     else
>> +             return sysfs_emit(buf, "%s\n", "exclusive");
>> +}
>> +
>> +static void auxiliary_irq_destroy(int irq)
>> +{
>> +     int ref;
>> +
>> +     mutex_lock(&irqs_lock);
>> +     ref = xa_to_value(xa_load(&irqs, irq));
>> +     if (!(--ref))
>> +             xa_erase(&irqs, irq);
> 
> Global lock makes it indeed simpler to support xa_erase()-on-zero.
> There are simple solutions without erasing zero elements (you could
> have non-allocating store), but let's say we are leaving "the simplest"
> room then :)
> 
>> +     else
>> +             xa_store(&irqs, irq, xa_mk_value(ref), GFP_KERNEL);
>> +     mutex_unlock(&irqs_lock);
>> +}
>> +
>> +static int auxiliary_irq_create(int irq)
>> +{
>> +     int ret = 0;
>> +     int ref;
>> +
>> +     mutex_lock(&irqs_lock);
>> +     ref = xa_to_value(xa_load(&irqs, irq));
>> +     if (ref) {
>> +             ref++;
>> +             xa_store(&irqs, irq, xa_mk_value(ref), GFP_KERNEL);
>> +             goto out;
>> +     }
>> +
>> +     ret = xa_insert(&irqs, irq, xa_mk_value(1), GFP_KERNEL);
> 
> make code simpler by one common variant of ref++ & store

Nice :)
will change in next version.

> 
>> +
>> +out:
>> +     mutex_unlock(&irqs_lock);
>> +     return ret;
>> +}
>> +
>> +/**
>> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>> + * @irq: The associated Linux interrupt number.
>> + *
>> + * This function should be called after auxiliary device have 
>> successfully
>> + * received the irq.
>> + *
>> + * Return: zero on success or an error code on failure.
>> + */
>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, 
>> int irq)
>> +{
>> +     struct device *dev = &auxdev->dev;
>> +     struct auxiliary_irq_info *info;
>> +     int ret;
>> +
>> +     ret = auxiliary_irq_create(irq);
>> +     if (ret)
>> +             return ret;
>> +
>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +     if (!info) {
>> +             ret = -ENOMEM;
>> +             goto info_err;
>> +     }
>> +
>> +     sysfs_attr_init(&info->sysfs_attr.attr);
>> +     info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
>> +     if (!info->sysfs_attr.attr.name) {
>> +             ret = -ENOMEM;
>> +             goto name_err;
>> +     }
>> +     info->irq = irq;
>> +     info->sysfs_attr.attr.mode = 0444;
>> +     info->sysfs_attr.show = auxiliary_irq_mode_show;
>> +
>> +     ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
>> +     if (ret)
>> +             goto auxdev_xa_err;
>> +
>> +     ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
>> +                                   auxiliary_irqs_group.name);
>> +     if (ret)
>> +             goto sysfs_add_err;
>> +
>> +     return 0;
>> +
>> +sysfs_add_err:
>> +     xa_erase(&auxdev->irqs, irq);
>> +auxdev_xa_err:
>> +     kfree(info->sysfs_attr.attr.name);
>> +name_err:
>> +     kfree(info);
>> +info_err:
>> +     auxiliary_irq_destroy(irq);
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
>> +
>> +/**
>> + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the 
>> given IRQ
>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>> + * @irq: the IRQ to remove.
>> + *
>> + * This function should be called to remove an IRQ sysfs entry.
>> + */
>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device 
>> *auxdev, int irq)
>> +{
>> +     struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
>> +     struct device *dev = &auxdev->dev;
>> +
>> +     sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
>> +                                  auxiliary_irqs_group.name);
>> +     xa_erase(&auxdev->irqs, irq);
>> +     kfree(info->sysfs_attr.attr.name);
>> +     kfree(info);
>> +     auxiliary_irq_destroy(irq);
>> +}
>> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
>> +#endif
>> +
>>   static const struct auxiliary_device_id *auxiliary_match_id(const 
>> struct auxiliary_device_id *id,
>>                                                           const struct 
>> auxiliary_device *auxdev)
>>   {
>> @@ -295,6 +452,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
>>    * __auxiliary_device_add - add an auxiliary bus device
>>    * @auxdev: auxiliary bus device to add to the bus
>>    * @modname: name of the parent device's driver module
>> + * @irqs_sysfs_enable: whether to enable IRQs sysfs
>>    *
>>    * This is the third step in the three-step process to register an
>>    * auxiliary_device.
>> @@ -310,7 +468,8 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
>>    * parameter.  Only if a user requires a custom name would this 
>> version be
>>    * called directly.
>>    */
>> -int __auxiliary_device_add(struct auxiliary_device *auxdev, const 
>> char *modname)
>> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const 
>> char *modname,
>> +                        bool irqs_sysfs_enable)
>>   {
>>       struct device *dev = &auxdev->dev;
>>       int ret;
>> @@ -325,6 +484,10 @@ int __auxiliary_device_add(struct 
>> auxiliary_device *auxdev, const char *modname)
>>               dev_err(dev, "auxiliary device dev_set_name failed: 
>> %d\n", ret);
>>               return ret;
>>       }
>> +     if (irqs_sysfs_enable) {
>> +             dev->groups = auxiliary_irqs_groups;
>> +             xa_init(&auxdev->irqs);
>> +     }
>>
>>       ret = device_add(dev);
>>       if (ret)
>> diff --git a/include/linux/auxiliary_bus.h 
>> b/include/linux/auxiliary_bus.h
>> index de21d9d24a95..760fadb26620 100644
>> --- a/include/linux/auxiliary_bus.h
>> +++ b/include/linux/auxiliary_bus.h
>> @@ -58,6 +58,7 @@
>>    *       in
>>    * @name: Match name found by the auxiliary device driver,
>>    * @id: unique identitier if multiple devices of the same name are 
>> exported,
>> + * @irqs: irqs xarray contains irq indices which are used by the device,
>>    *
>>    * An auxiliary_device represents a part of its parent device's 
>> functionality.
>>    * It is given a name that, combined with the registering drivers
>> @@ -138,6 +139,7 @@
>>   struct auxiliary_device {
>>       struct device dev;
>>       const char *name;
>> +     struct xarray irqs;
>>       u32 id;
>>   };
>>
>> @@ -209,8 +211,26 @@ static inline struct auxiliary_driver 
>> *to_auxiliary_drv(struct device_driver *dr
>>   }
>>
>>   int auxiliary_device_init(struct auxiliary_device *auxdev);
>> -int __auxiliary_device_add(struct auxiliary_device *auxdev, const 
>> char *modname);
>> -#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, 
>> KBUILD_MODNAME)
>> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const 
>> char *modname,
>> +                        bool irqs_sysfs_enable);
>> +#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, 
>> KBUILD_MODNAME, false)
>> +#define auxiliary_device_add_with_irqs(auxdev) \
>> +     __auxiliary_device_add(auxdev, KBUILD_MODNAME, true)
>> +
>> +#ifdef CONFIG_SYSFS
>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, 
>> int irq);
>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev,
>> +                                    int irq);
>> +#else /* CONFIG_SYSFS */
>> +static inline int
>> +auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
>> +{
>> +     return 0;
>> +}
>> +
>> +static inline void
>> +auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, 
>> int irq) {}
>> +#endif
>>
>>   static inline void auxiliary_device_uninit(struct auxiliary_device 
>> *auxdev)
>>   {
> 

