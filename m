Return-Path: <linux-rdma+bounces-2658-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDA8D2D3E
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 08:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92141F232B9
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 06:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B8C15F417;
	Wed, 29 May 2024 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YnXSEi97"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427E38DE8;
	Wed, 29 May 2024 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964196; cv=fail; b=dehB8pDyTjnmQk9qmLjbjC9rUDKlBvsIHw5QxX1qJW8GDkZw7c69ncgIhKj+B/+7skn+2gYFYSif+Mu8Z9caVy1Gf4wMYkmO8n35Pa2F7sZInQjnEo8dNxzzkTTQxnZUZaQHDYv/oG0zFPOVmCazlCoSlOsBcC1kutv9pLR/C8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964196; c=relaxed/simple;
	bh=DJwUDeHgJWPcgfBwos4wYzRNAt3GPli5b/7KRZ9aCwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CauBff/WOK/hf+3A6MeoT2HBrsJDn5lX0diVPgr1GZmbnK9mPob1+3rIkjLYd2EiYm+z+W7E+c6EGVqXByh4Ey9O3Fkn9886yTqWxNkxmCecuOxRIaNvzN1xYoFUMLLl+YOcIhE5gVxoiD1yUB7sJpjPHijW7AkCCNkrz7FQrps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YnXSEi97; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc4wE3wr799QnoYctJZ2rcQGRuAm+OKqWi9v4iFMYykh7h+22zs7iOASiXNBiT4kQKglWtl016TMWOINgjZYFlJQH9UeDteolk/XSqfS5yk+oD/R4F2jmRd9KM5Zq0acnGpEz4qmEFsMOlVP0+YPfYCDY3zTVD8kYMpnvd2oaWf9Q2RGEND7xs5oY/4UdEPDL2f/rwakdYHNjP/S5XM4wXcaeZ6jGKrOX5JVKBSjVfPlKipEEMd2W8EYPKikOm/UF35/OMTkfanqSCIHyg87koUOz4DbnTzpe7aIc1al8IltbovZX7vMqcrHvXR9AQHzjgNy7HfzUstGh6NBFh3APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj8GlagQW3WP/8dV3P+7uixsS2KLt766MjlzBRI+cfI=;
 b=Gf7XKF1SOS0lPbEuu9n1p1yTvaF1XNlmLKlaXowVv0omEt2Ucuq8itJQHEI3PGmTn9NInMavGJ1knmv/fQn6h15sOmBoOvGoII5jnqj98AGevaT7iriLBjVz/Nw+Dsb2FmcvQRi2SgG3JfWYV/Ed57mTGAk7q/EtR471sb1CLuUtuDtHQNG6aDA/4rXp7MqkmwgvPIcJ+cJ/k2pJHgNs6zlMr6ZR6xdpBjj5nD0Sk5UIR2/mH58nPuMBVCKKck6gNaZjI1WT3malh3PPekLfel2mMXr/HuZECoMPV79AK0Q8MnHo34U3U1BFN3jwq1zSzUtMjNTW7FOuqR4ypRd25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj8GlagQW3WP/8dV3P+7uixsS2KLt766MjlzBRI+cfI=;
 b=YnXSEi97eCKNRza04ni3/8+l3wZwDJr7RGuI9gS6RJr4f6pwtixpLCt4rw4LrGp/m+JLi0iudYjhqrzg01G0G/K4SpOHbexrIl6gDMbgHrs5k6wiMP3yKNykpcCnPkmr+bed0GYR3XKBVWo74sHkqR3VacW6PmSyJUrlRrEQZAqaY4+vZUCfPVTnZytJqZ8Alvik1AsG261MajjzijZDT2VI9bzvHS4LGEBy7S8Cul3S1Cykto/fzS6CkC5te0H5ozhKDBCG1J3dIBwUiMenxfexQ/o8IHH13a7Rn6Gl4isPuAvqwYS2gMc/PCmHimyb1MN7eipcqRqI5ocJqKoEKQ==
Received: from BY3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:254::24)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 06:29:52 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::24) by BY3PR05CA0019.outlook.office365.com
 (2603:10b6:a03:254::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17 via Frontend
 Transport; Wed, 29 May 2024 06:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 06:29:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 23:29:40 -0700
Received: from [172.27.34.245] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 23:29:35 -0700
Message-ID: <49c0676c-0b23-4df4-aa3c-d13e578e28f1@nvidia.com>
Date: Wed, 29 May 2024 09:29:33 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Greg KH <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240528091144.112829-1-shayd@nvidia.com>
 <20240528091144.112829-2-shayd@nvidia.com>
 <2024052829-pretended-dad-ac9b@gregkh>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <2024052829-pretended-dad-ac9b@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be0dbff-d019-4c87-bade-08dc7fa8bf58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REtXazBwd1lXL1JCV2NBYXlWUWhoM0RnZGFOSFZ5YmV4MXpGY0lHU0swdXZo?=
 =?utf-8?B?Zm54eTV2UXJ3Rkg0cytIYSt5WmNEUC85TVNicWIrVUc5Q0szek4yOGd3Q2Fs?=
 =?utf-8?B?aE5PL3hUU0pIcHB6UzJLS1U2aTc4dWZaWVRtK1F3eTY4TGJWL004dTlXaTNm?=
 =?utf-8?B?OVJ6VDhhQW9CdnZha2ZVRE43RVJLbnZHejNkYUtjU25PaCtuRnptR0d3eE9O?=
 =?utf-8?B?cC9sMnd4dWlnSXlQMkR3cUFLdCtocWMzaGRnYkl5ZFhOWGh0Um1CYjhqRjVk?=
 =?utf-8?B?eXpTZUoya3hkNGlDZ1RqajVvcTNseVZGQmlwTG1ZUzd3VHF1NWtwb3pHRVlP?=
 =?utf-8?B?K0pDWkQ2S1dVbmxDYjFWYUlVdU92UVZ2UUtkN2JheE9CL290Z3dPdEF1N0RH?=
 =?utf-8?B?TUh4b0FUcXR0SEJwYnJlSFI4RkFId3NjenExaE1LNldkYUlHeGRWWjRRZkp2?=
 =?utf-8?B?Q0JSQ1czclVqa012VVJEYm0zN2gvU0l2MUNFVzlsYnJsRysyZ2JGc2ZiZHZM?=
 =?utf-8?B?VC8wazNYVFJ1OHlpNmt6bWxXYmF0Q1FLU2drOTN6dmo2aUE2MDA5dit4Y1I5?=
 =?utf-8?B?cjZMMG43cGltajA3Tm82amVKU2lQYThiUis3UHJPTVFSZEk0NkgxR3J0TXNm?=
 =?utf-8?B?R2ZBNUcrUnpLK1o1Tmx6UUxTN2NSb0dUTVdlbDAzVk43K3lvM2ozNlRuaFhp?=
 =?utf-8?B?ZTZXYitEaDc4eUpqcm9XaUc2cjlpM05KTVNINmVuM0tiYURpNmdnU1AwM0tL?=
 =?utf-8?B?Z1RwUTZndzFSTDcrSkhEQ3l5Zm5BUVN4R1RFK3FwRFZVV00yVHg1dGlDdEwr?=
 =?utf-8?B?TmFyTXhHNCtIdCtQeGE4MUwzKzFjU0FEb3ROMXlLRHk0bGkxOUtYTEI4djlu?=
 =?utf-8?B?ak50Q3dvbi9ybWNqYzJIMHpPeVh0bzF3SnVmS1pycDhrQjVOMmJpend2UUhK?=
 =?utf-8?B?bHlsNlA3ckZzTVgrckVTbDNLK0MrZ0FhcGNTUmRpRC9kbFh6eHlIQ1pkNEdu?=
 =?utf-8?B?clBsd1JqWVF0NjVIVS8rSXFkeVcxTlVVQXdZQTNYUW1wVUVQSkJOM0RDTy9j?=
 =?utf-8?B?Y3ZNUG5WTUMzbW1SSnh0TmxicnVFWDhsSFVaSk9PRi9HbmpSWDkrT01JbTdw?=
 =?utf-8?B?ZkNFYk5BeEdpMmpFSlFQVTg1Yzh6N3BJSGwwNTNRdllqamg3MGRIaHYvZm5F?=
 =?utf-8?B?Si9KUVJEc0Vwa3dDRzViQm1qYjRNbUt0cEwvY1VET0MxQUFmclZXd05ZMWxw?=
 =?utf-8?B?NUdaVS8zaThjMjVRSXFYN3RxN0F4SE02Y2RzRGhSNlRmWm9hZVppU2RTYlk1?=
 =?utf-8?B?YnNPOU53L3A2ME5UbDhXSWFleXdrOFFrUTdsaEd4cFRzMkJpMnRoMkdSZjFB?=
 =?utf-8?B?Vkg5RUdwZDZTd2dBY0lMbGgvN1dJMVNON0ttbDIwWUhaYWZBY20rTURJdVVI?=
 =?utf-8?B?UXhFU24ySDM1KzdlbjUvbXVlbFlPMEQ5eEFyL0dBSm1tSmUvMXFkTjhWSC9k?=
 =?utf-8?B?bDM2MVZaRUFEbHFSSnRrSE5MOHFvdEpYclk4U2U0VFFheG4rL2I5S2VjaHNK?=
 =?utf-8?B?VW14M1R4ZTUvNlRIbm5maDhKOTdXOTVtaUlHcGxkbmNsYi9naERaQ0ZHeDNN?=
 =?utf-8?B?WWtEZWtCcVVtOCt1dkJqT1FiVXJ0TW9BYkYwZzRwMWtOU2JmMDZNbXJqT01o?=
 =?utf-8?B?YnJiSU5lY0J1L01FeWhiZUllVUowQVUwMDVURFFnQyt5RVIxczBwRFE1c0hK?=
 =?utf-8?B?SWF4ZHNkRmZnU2xDbUxsSGxKQVp2bFJLSHdVdE5RV1M1WjlNQWpMMXc2QWhm?=
 =?utf-8?B?SGhIMEMxUVNsckRNUUIvRmFFOG5MMXR4bndNazBaYzFaWWNLS1NOUDQ4V1Na?=
 =?utf-8?Q?rpWpyZ/DSDKjD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:29:52.0951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be0dbff-d019-4c87-bade-08dc7fa8bf58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121



On 28/05/2024 21:00, Greg KH wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, May 28, 2024 at 12:11:43PM +0300, Shay Drory wrote:
>> +#ifdef CONFIG_SYSFS
>> +/* Xarray of irqs to determine if irq is exclusive or shared. */
>> +static DEFINE_XARRAY(irqs);
>> +/* Protects insertions into the irqs xarray. */
>> +static DEFINE_MUTEX(irqs_lock);
> 
> You access the irq xarray without grabbing the lock in places :(
> 
> But again, I fail to see why the xarray is needed at all, why isn't the
> needed information here:
> 
>> +struct auxiliary_irq_info {
>> +     struct device_attribute sysfs_attr;
>> +     int irq;
>> +};
> 
> Right there^ should contain everything you need, NOT a global array and
> lock at all.


1) one xarray is per aux device that indicates which IRQs irqs are used
by this device. this xarray is holding the info above.
2) second xarray is global that tracks if irq share between multiple aux
devices or exclusive to aux device.


> 
>> +/* Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
>> + * shared or exclusive.
> 
> Why are you using networking comment style here?  :)

correct, will fix in next version

> 
>> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
>> index de21d9d24a95..760fadb26620 100644
>> --- a/include/linux/auxiliary_bus.h
>> +++ b/include/linux/auxiliary_bus.h
>> @@ -58,6 +58,7 @@
>>    *       in
>>    * @name: Match name found by the auxiliary device driver,
>>    * @id: unique identitier if multiple devices of the same name are exported,
>> + * @irqs: irqs xarray contains irq indices which are used by the device,
>>    *
>>    * An auxiliary_device represents a part of its parent device's functionality.
>>    * It is given a name that, combined with the registering drivers
>> @@ -138,6 +139,7 @@
>>   struct auxiliary_device {
>>        struct device dev;
>>        const char *name;
>> +     struct xarray irqs;
> 
> wait, why is an xarray added here too?  That feels wrong, or odd, or
> something as you seem to have multiple xarrays here when it feels like
> you need none.
> 

please look the answer above

> confused,
> 
> greg k-h

