Return-Path: <linux-rdma+bounces-2422-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A9E8C3555
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 09:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354ABB20F36
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 07:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9814B125D5;
	Sun, 12 May 2024 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TL+YSMlF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A1125C1;
	Sun, 12 May 2024 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715498799; cv=fail; b=Dq/O+9HOyqSsQErqngM2+ASZoKRCTQRcGzzyOPWCdaRbztDmEWGwXqz6dOQE1hVwSc144DAvFf8xisTveMXGnksH7F2MY8PLr5LrQVH+r+nApSLzcFLEwI7fe2BzM1cJNX04Pt/Ydo6t8uA+bYX68BsI4AMe5J1tfH2CJrrIkhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715498799; c=relaxed/simple;
	bh=Ul9Y+SDNvPSBiRJkcj9y0dtmREH22VhWec47e+CvLss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cY9/5n1vu4nPznxZ71ysV0dY87v7FK/KrXL4TWxx3gXGQtoGwXQHaEim6Dprv8b7bdARdrxyTlIP1OgHwnqBtCeZgivafZw8c7wS08X4MqrBXk6sK025tXCprJLPy8hHB0gxmde4wZoqECtjxkXKxDnLM39B+TKH1WxbNadzEfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TL+YSMlF; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr6uE9WvabXtrA6hxPiV/BGauhDn3GUod4tjKHeweo+cm+YuFH6HnJXmm1IwHAF/5fz6lemb+VyNPIitS+R3M4KwHa9k6MobgnwDcrl4tQEpbR2aoMXz2l6RjrmmshF4kgY86T3hta6VW9Dr+9+aP6W0jpO6csioqWOUNt+/S/Cq1jVoWcT6UT+OsWclbA+siqAUDna84ncVI+OgMUBtfL/+W9BGq34iQQRyARUlYvtI8G+u2MQb+dTftTwIJ3iHY7+5QnLUx+co7qXixZ5aqhrUNxCjPYmysbTGgrkea0+2+cGHxuBwbPaDXedbl7VI/5nYM1nhppvFCxXxQOfddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Jgtnqj1TRXQgynRWgyvzFtG4T6mw5JiBuCJQIsPHGk=;
 b=ilpVkISN4mRbxL7RhzgI4D39N4WxQ2lysBYg/V9ewFPfEtnvCBKj7OjljC2GXlfQL5V1JLuXQOFjrbPmuKZPkoRV0t6T6TNXosSjFO8vpLi5J00m1LUw0KGOa2fsyCmcA9Rjs5+2bigVEstxdfYn/ep05Hhdiq3MGE+4VLusBR/+DRPCNj0914ouA3SVhyW/L//zu/MkbeubZzXkwOmBg5kKW97e/qZwkva0TAg86PnKIzrBiA+4bj4rnX5Dn4/Qufh1dretxXEfxz1J+iDoJ2CkFWHzBXSHtn4OcgmJckEOr7dzbxv427tCJwFvw3QM/zyLxmhTb9sJwIsaYHzxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Jgtnqj1TRXQgynRWgyvzFtG4T6mw5JiBuCJQIsPHGk=;
 b=TL+YSMlFp6ErA0xbjeYPKM63O0hZFmkxmrTfqQFY63ipz7Ax/CkKObQ36hDkv/6qM18uMSo4m2L0ofDyDrJh9GhHJr89y1aYIXlToOzUtDJ7/mEPfddCd70/Ctv7he0LXjYpW9R4Mq5vNW6UzbFZnZB7ajnKJIbLaYnWWYsxXAZKRZzrowWaKOIUXhw+Dq7yFuZS/gNVA/JRNUPQiajszthGTSyoz4Lor8bCbA8NXmQs3KnZBpjyg045h7QmaBDCObtLHwSgqwbuxjVGB2s+yjqQZEAtc/Pg0cker4V51r5QEBqAyqdYQTYuGOpZ0rLE2C0QFLqg8NttHP19Cpdqsg==
Received: from PH0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::12)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Sun, 12 May
 2024 07:26:33 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::b3) by PH0P220CA0003.outlook.office365.com
 (2603:10b6:510:d3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Sun, 12 May 2024 07:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Sun, 12 May 2024 07:26:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 00:26:28 -0700
Received: from [172.27.19.54] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 00:26:23 -0700
Message-ID: <0ab29049-4635-4018-8e11-bffddbd437d5@nvidia.com>
Date: Sun, 12 May 2024 10:26:21 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240508040453.602230-1-shayd@nvidia.com>
 <20240508040453.602230-2-shayd@nvidia.com>
 <6da0b4eb-717b-4810-951c-b59edf32e422@intel.com>
 <fa46ce9f-75f8-49af-8fb7-37b1e698f349@nvidia.com>
 <abfa794a-e129-414a-bb5e-815eeb13131e@intel.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <abfa794a-e129-414a-bb5e-815eeb13131e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: d651b0b2-c544-4e90-22ba-08dc7254d9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXdmVFpMNmVYcFY2UGt4Zmo3NFRadlF0VXpxZm5oQ2F5WHpLR0dBWVBZMnJN?=
 =?utf-8?B?NHZnbHBCWWNjZ05weExyZWtoVTREM2xBS2FTWnFQNXYvcTFyZW84R3ZYRUZ6?=
 =?utf-8?B?bWdJK1Q0ZzRNZ0dCNFduQzUwZlpncHpYT29EY3JGaFlzVkRzKzQ0RHRLbW9E?=
 =?utf-8?B?Q2I5cHRybjRqMnJEMmVERDVDbWJvb1BoWU43cTBvZDZrL3lPcmtGNng3S3RI?=
 =?utf-8?B?NHFhWGJJTVpiUGdEQ0pObmJOMExDWFN0OHArVUdaUWZ2aXhGd0dyYkNDTk9Y?=
 =?utf-8?B?bHRBQnpydlFIUjc0dnc5ei9ZQlFaV3JkRDdmSFBRczUrT3Y5NkxXSTVCWEx6?=
 =?utf-8?B?cGdtTXZXa3RpK3VDSkltSzlML3Nzcm51aW1Xdm5UdkgzS09McXVtZ2xzSDJs?=
 =?utf-8?B?L2NZTDJQaGJJTVJPN2JtcFdvTWhPZXIzQUVqdUVSY0VDeWQwQ2xZcmpiUDF3?=
 =?utf-8?B?QThYOHhVU1lxdjEzQlVTbjdlR3pvcXZ2NlIrK1pRS2JwcHZkY0tleU12UVls?=
 =?utf-8?B?M2YwbUVJK0pXaS8yYjZXNFNxeFBQQTRxNldZTk9BeDAxcnVXVElJbXhZKzNR?=
 =?utf-8?B?MG9vdXpGdjkrVWhCN1h5YkJCdXBsN011TWpwL3JrK2NTNkhlMWFmWDZQeDAw?=
 =?utf-8?B?NjZMMkhBeUtybTI4bHlvUktPWjFQSDEvZXlRWmt4MEJ2clBpUjZ0bXV6OG45?=
 =?utf-8?B?T0VLM012SjdXQnR4RHB4S1laM25MVjF3SzQzUkJ6WkNvMTdwYmc1em1BbHdi?=
 =?utf-8?B?d1JlTzREVFp2MUdXQkQyRGxFSUhkTThDMkI5UEtTZHBDQS9zc2k5TklUckJi?=
 =?utf-8?B?cmNBZDBmeDhUSDN2YkFDNjRuaGtpUVMyL1JoYXNRQ2NGL1I2NjFWdlViLzZT?=
 =?utf-8?B?TmZOZElMeExGbzlxb2ZocmRkaWJtS1crdTYzS2ZPeEpLSkJ2VU1kWHEvVlNN?=
 =?utf-8?B?QnZ3aytVcDBuWFM1eDk3ZDRvQzJoRmM1dXhWUWpyY3BiaUswTmluQStnTitL?=
 =?utf-8?B?YkJHZU1lNG8yOFdaVVUyakphaTRvUEFKemoyUGtYUW5NVmM4YWpjK3Fkd2Ry?=
 =?utf-8?B?TW1TZ2tra0JQZmdCczhvQUQ1K0pmN3RJYkNRUXN4MEtyRjYyMFAydjF3dklN?=
 =?utf-8?B?TXZaZ2ZrUHdKZHh4eXEyRXBraEMxYnJHSldpSnZnMk91RURIcENrb3FJYlRy?=
 =?utf-8?B?UkdEbTF2blFscUg5L1B6T2JISVRzQnNBVFB1MTJBVGJmWTZLUjdIU2Z3Tm9Q?=
 =?utf-8?B?OUZDblNseHhXM1VHeDMveGp1VE5kWXRTRzZkRTJRdzhEN200U3YxQ3NGanJW?=
 =?utf-8?B?Q1FZTHMzb0hKMmVmTUk1K0xzb3JqZEZtbjI0T0pocHZUaWxqMDk2TDhBQW1x?=
 =?utf-8?B?bkZucmp5Z0lqcTkza3MyZlhrWk8rMmpQelEvUlhxTENYM05XMDZ6OTgyOXNj?=
 =?utf-8?B?d0xJQ1FZNE1FYVpTZVR2RU1BRG5FWDNtbXI1RGd2M1NmSHl6OGRDWVZRWEFV?=
 =?utf-8?B?WnhsZTFNWWNJSVBJa21UbSsvSnNOOHp3TlM3OG03NWtOZXNkdjVjVEp4bEZ6?=
 =?utf-8?B?dmRwblFLTWl0Um1rL0Mxa2t4Yk9XdTdyM0JObnU3NWRMT0NkcW9qTWkwU3NW?=
 =?utf-8?B?Wkd5YlBMMEtESFVuMEVUalA1OUYwbkJ1a2dva1NCWlJLNFFRRnhhVWNCb0lq?=
 =?utf-8?B?UmhDeEN1YVZSZnRCWWtmb1oxUGhLWjYwdGZNTUxBQ2dMcUEvN0FROWFxLzVw?=
 =?utf-8?B?Mk9sTnp5by94STNPMWs4dFpzYkJVTzlaNFpBOTgyQTVFeS8wMWZ5R09mYXZM?=
 =?utf-8?B?Y0RUeW9QZ2lIUDVqQm1XS3RDS205b0lKeVFqMXVEY3ZUU3ZVUlBFa2xxSjFY?=
 =?utf-8?Q?c7lpb6oxPKvf2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 07:26:33.2331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d651b0b2-c544-4e90-22ba-08dc7254d9a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962



On 10/05/2024 16:07, Przemek Kitszel wrote:
> External email: Use caution opening links or attachments
> 
> 
> please not that v4+ is already being discussed
> 
> On 5/8/24 13:33, Shay Drori wrote:
>> On 08/05/2024 12:34, Przemek Kitszel wrote:
> 
> // ...
> 
>>>> +
>>>> +/* Auxiliary devices can share IRQs. Expose to user whether the
>>>> provided IRQ is
>>>> + * shared or exclusive.
>>>> + */
>>>> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
>>>> +                                    struct device_attribute *attr,
>>>> char *buf)
>>>> +{
>>>> +     struct auxiliary_irq_info *info =
>>>> +             container_of(attr, struct auxiliary_irq_info, 
>>>> sysfs_attr);
>>>> +
>>>> +     if (refcount_read(xa_load(&irqs, info->irq)) > 1)
>>>
>>> I didn't checked if it is possible with current implementation, but
>>> please imagine a scenario where user open()'s sysfs file, then triggers
>>> operation to remove irq (to call auxiliary_irq_destroy()), and only then
>>> read()'s sysfs contents, what results in nullptr dereference (xa_load()
>>> returning NULL). Splitting the code into two if statements would resolve
>>> this issue.
>>
>> the first function in auxiliary_irq_destroy() is removing the sysfs.
>> I don't see how after that user can read() the sysfs...
> 
> Let me illustrate, but with my running kernel instead of your series:
> # strace cat /sys/class/net/enp0s31f6/duplex 2>&1 | grep -e open -e read
> yields (among others):
> openat(AT_FDCWD, "/sys/class/net/enp0s31f6/duplex", O_RDONLY) = 3
> read(3, "full\n", 131072)               = 5
> 
> And now imagine that other, concurrent user app or any HW event triggers
> this IRQ removal (resulting with xarray entry removed (!), likely sysfs
> attr refcount dropped to 0 [A], so new open()s will be declined, but
> that is irrelevant).
> My assumption is that, until close()d, user is free to call read() on
> fd received from openat(), but it's possible that xa_load() would return
> NULL (because of [A] above).
> 
>>
>>>
>>>> +             return sysfs_emit(buf, "%s\n", "shared");
>>>> +     else
>>>> +             return sysfs_emit(buf, "%s\n", "exclusive");
>>>> +}
>>>> +
>>>> +static void auxiliary_irq_destroy(int irq)
>>>> +{
>>>> +     refcount_t *ref;
>>>> +
>>>> +     xa_lock(&irqs);
>>>> +     ref = xa_load(&irqs, irq);
>>>> +     if (refcount_dec_and_test(ref)) {
>>>> +             __xa_erase(&irqs, irq);
>>>> +             kfree(ref);
>>>> +     }
>>>> +     xa_unlock(&irqs);
>>>> +}
>>>> +
>>>> +static int auxiliary_irq_create(int irq)
>>>> +{
>>>> +     refcount_t *ref;
>>>> +     int ret = 0;
>>>> +
>>>> +     mutex_lock(&irqs_lock);
>>>
>>> [1] xa_lock() instead ...
>>>
>>>> +     ref = xa_load(&irqs, irq);
>>>> +     if (ref && refcount_inc_not_zero(ref))
>>>> +             goto out;
>>>
>>> `&& refcount_inc_not_zero()` here means: leak memory and wreak havoc on
>>> saturation, instead the logic should be:
>>>         if (ref) {
>>>                 refcount_inc(ref);
>>>                 goto out;
>>>         }
>>>
> 
> 
> <digression>
> 
>>> anyway allocating under a lock taken is not the best idea in general,
>>> although xarray API somehow encourages this -
>>
>>> alternative is to
>>> preallocate and free when not used, or some lock dance that will be easy
>>> to get wrong - and that's the raison d'etre of xa_reserve() :)
>>
>> I don't understand what you picture here?
> 
> Here I was digressing, sorry for not marking it clearly as that.
> IMO xarray API need an extension to make this and similar use case
> easier to code right. I will CC you ofc.
> </digression>
> 
>> xa_reserve() can drop the lock while allocating the xa_entry, so how it
>> will help?
>>
>>>
>>>> +
>>>> +     ref = kzalloc(sizeof(*ref), GFP_KERNEL);
>>>> +     if (!ref) {
>>>> +             ret = -ENOMEM;
>>>> +             goto out;
>>>> +     }
>>>> +
>>>> +     refcount_set(ref, 1);
>>>> +     ret = xa_insert(&irqs, irq, ref, GFP_KERNEL);
>>>
>>> [2] ... then __xa_insert() here
>>
>> __xa_insert() can drop the lock as well...
> 
> Thank you for pointing it to me.
> 
> Let's move future discussion on this series to your newer submissions.

thanks for the quick reviews :)
lets continue in the v4 series.

> 
> // ...

