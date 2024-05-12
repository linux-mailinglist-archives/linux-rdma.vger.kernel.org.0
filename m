Return-Path: <linux-rdma+bounces-2423-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77CF8C3556
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 09:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062C21C209F5
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 07:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDF4134BD;
	Sun, 12 May 2024 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xx8mAPtb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A063D6A;
	Sun, 12 May 2024 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715498876; cv=fail; b=bMlgpDArHgWiJgQwVBn0+P23g2CiNuWAZUMBGrTAwsuLfkbdE+eAykiu6pdBmstK+CcQCGqQQJBR221Aahg5dxdhVFTjYUL0TS3F+bTaTdNDJUGpkDjuQI29+6FgSttjq0/u+d6aSqx18yzCxr/r/fwSwDg60IgMmpG9uuJ+OtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715498876; c=relaxed/simple;
	bh=pG3sNRaad/TjqbZfa1URvMXKcPv6nFuqpvxdzx86AnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LGmMTQIrhMFgPeunUttTTMToOI2NRxaJiPRm+6or4ieu4UYwUnsXQ/2X7afeZX26M1DsEQAFnUoHUykpkqHSY3Jx+EmG0drWfqWbSP2UX1ORqjsab2Q0QceaxPN1fux7R5+9nA4MwKNYQZIuOU+zaa5I1Zf75RoreOCkHTojxrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xx8mAPtb; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFsXXdWXk6IuUioDb2che4JtEwLRQiux/pVSHyWrkoGqyVehSaFpSI7/o2kfxd/G9BdR5oxJKJDuu6hMFIvl9iEHQAxbWZ0A5iCHOfv09Vf+MxBCsWbAbJ37eGSR65Cz10pGgZT9gIsLZg3fgOmXT3cayIDGs6mzYmPZ5q5f30/8P07vgVs/t7cLPB/CfxynzuwEKFulSnpUL0CEqn0qDaN7VjGtB+E/xWDMabqyUu/KL5ACyVQz4hJ8L1/Z6f2hAPXl0OeUCa95k3n055Bd9jlzKImGGMnwHaw60MOoqDf5zDZNa5SArQeDbzATmB5asdoEaBd2G+yBG1O0BE+3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeWg2vpkbIUom2j5YP2f6mWNpLkJv0RZBXFpW9hb5HE=;
 b=bmLsN10T6HmQe392jf4CwJmU0807prufJkDKckLU3AjKNT15o/I741pe56C3EJAFFo8NcP78XWZiUaYaU1Ef2PaJkSDGOWq1NqhFqR+W3Rxg7xDWyydT8SAz1WoqNpLdUpk9AztGTuKf6/8gLKH7NBW6xKU5MX4W7hxSgDBQUsUtNrHmFjDhcY5v8ZVmqptvIny3+5ZgzrLYmZbGpOUxNVosFAfhuiqQhEFEcin0gN5psmPUOMVPaM1dACRBYr5uqjNT9Qu4Mqdx/OCQkF8uIMUMFuFqSOejJQ3Oh1cDpLaj88hD7lO3MzzzIF/yA59Jd7cyzx28fDQZivniU1oHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeWg2vpkbIUom2j5YP2f6mWNpLkJv0RZBXFpW9hb5HE=;
 b=Xx8mAPtbeFLt+qK549XJFimTFvj5XCV2aIC185jYcoFdyUO9LrggWNDSxLHXuPvCP90jf880khs1NbvNiaa+KGIoEnSeGpwPsOB42GmR/ObAuntG9EKUS0aU5lYSL6BZ+TeSNelIxlUMBQOmmcnOKMvIxsRdSB2tnHzSMpfmN/ygqdXtYk8q4PgfqX5BoILnz6wL+NJqcBvI0JO6mI4/5bE0Cr81iUKQur7Nni8yEH9MRs1fGWepCx4FUrjUsMrnyTfsqNZt8V3aEI5zQTwRXYDS5wBMuWj3/SVyr2upd0Yiz0gI+ZEwZWiRYnidBzwGOvsxJgEYeaWOfrCK1zxDoA==
Received: from PH0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::12)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Sun, 12 May
 2024 07:27:49 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::ca) by PH0P220CA0003.outlook.office365.com
 (2603:10b6:510:d3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Sun, 12 May 2024 07:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Sun, 12 May 2024 07:27:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 00:27:35 -0700
Received: from [172.27.19.54] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 00:27:31 -0700
Message-ID: <e59b1006-7458-4363-b283-67c19742d166@nvidia.com>
Date: Sun, 12 May 2024 10:27:28 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Greg KH <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240509091411.627775-1-shayd@nvidia.com>
 <20240509091411.627775-2-shayd@nvidia.com>
 <2024051056-encrypt-divided-30d2@gregkh>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <2024051056-encrypt-divided-30d2@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: a96aace3-7c9c-4b46-a39f-08dc725506a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTA3N1cyL3NlT21mWUJoa3ExSXlFWm1nWWZ1RUQ5YVluRXVvSEtabUU4T24w?=
 =?utf-8?B?bUhkTzFnVHdWYm5DUHoyOFo4TjNmUURTNytJNE45bUFnUmJzUG9vSVVBd1lm?=
 =?utf-8?B?U3RPY0xUN3JsYU9rbEFvL0M2WmV4UzZNRHVwdzVGZ1U3RG9HR1g5OGppamNZ?=
 =?utf-8?B?UXd2TGdhQWdsVTFsNFk5bTNmS1N3VnFOcEprZ3pZWEpveWJDTzQ5MURrK2Yr?=
 =?utf-8?B?bUp3SDZUK0c2R05mRHNGcTVWblJRUi8rbXkzSFY5MytPcGpVZGIvd1FJdStC?=
 =?utf-8?B?dStXVWkwcytEQjA4UkpUaHFOK1JyK1RlT3ZlTy9obGZweHNKQ2pyaXlSYzNn?=
 =?utf-8?B?dXlYaWdOSm1Wc3B2VHpJQmJLZnRsREFLSUd3eDJDd2dSN2lDRm1FSnlWM3Ux?=
 =?utf-8?B?WFJVa3ZEWGNpSzI3UnBUKzcrdTJLV2puQWNwMFNsL1NhTkZ1bGR3Z1kxeTdY?=
 =?utf-8?B?aVhHNW8xR3VNZXNXOXpKNG51SHpXNWhDKy9QN2NERTFxbUd3ZjgyNjhwTmRr?=
 =?utf-8?B?VFdmYzl2WUZBSWhYaGpuWGd0Q3VhampjMC9scFQwL0NwVDlLWUNhZmdYdURy?=
 =?utf-8?B?Y3hJTVhjUDkxN29MNDQ3OVhlYnQxd3Rzd1pGUk9HaHVYY0dPcWxZV3psWGxz?=
 =?utf-8?B?TUV2SC94WU5JTGxvOGxybnd5Nm00c1FuMlNUQ0JHUmd3dmdBL2xZWmE0d1NB?=
 =?utf-8?B?YSt0MjdpK1lrU3d0ZmtvaGhyQ3BKK3lBYmdpTzV5TDl6WDFNa0hmemY0RlN6?=
 =?utf-8?B?UnhyZnZZVFVKM3JMNm1hc2htT2NEUWIrUW9BTlBmYnhpM0pyd1l6Q1NYT2hY?=
 =?utf-8?B?Z3lBbkpJcGd2RzFKckZqVmNDdmVwVFNXNGh3a2Z5aWR0ZjVrT001UTI1bzRJ?=
 =?utf-8?B?eW16M25WOVFoNjQ0bGtxTXNMcUVjREV6KytwYkRmTGFLeHBuODhnSWZpY0pi?=
 =?utf-8?B?bkpJODVPZitTQnZxZkNrWFlvRTVPSmpYaDhzVEdHWFlYRHgzYTYzL0xmWncr?=
 =?utf-8?B?UVJiUjd6TmtnNlNpL3J2OXljS2FkTmJObHAxSFJqdzZ1Y1dOTmxYeC9PdDRm?=
 =?utf-8?B?WXF0STdIVDMvRzN6U2NKTHYzN0VTaG0rUmhjdkdoS2pSWVl2MkxvUjQvVmJK?=
 =?utf-8?B?WjZBMWwzQ0QrQUZ5Vkd3VDZHUkQ4V2FmbnU3cU1nTlY3TkFFRW4vaW15aEd1?=
 =?utf-8?B?WkFzMFArdlRPRzloeG1OaCtSOG9KWFl3MGwvWk1ZWHJNM2JUWHNrbkhlQlRV?=
 =?utf-8?B?ZFpFQWlKUWNoYm1zRC90akpCWnZkWXRmUG1IczNJanVUeHdYWU5pNzNHTzlE?=
 =?utf-8?B?MkFkYnI5Z2hqS1d4bEtZbktEWlJTZmJzdmFRSGJzNmxxcG91YjlmOHRuSHR0?=
 =?utf-8?B?SWNuTzJkN3lndWRXT2o2WnZLSUZWYVdBU0hXaTJuK0lHS2JYeVlhRzN1UEFN?=
 =?utf-8?B?bHllK2VRVDhJczdCWTQwMDY0eUV2aWp0WW9ELy8xTk1wSjJiZWpxRG9QcUtP?=
 =?utf-8?B?Y2UwYTFVU1FReGZVN05EQVg2Vm9McjdIS0d4T0dzc0cwRlFhQUFDSnVmRlJu?=
 =?utf-8?B?RW9sclhpOU9IZE8vU2pyeElhL08wc21tZXUrNkMvOG1vZGhpWEgrQld4TTNH?=
 =?utf-8?B?NWcxeU8rRm5GQ1hvZGtpK2JYRmR2cFA3MitiSDRid3pkWjExQTEvaDF4YVRo?=
 =?utf-8?B?K0paMFY5L3plZEJVTzlhZUJvNStZdWd0V3RtVTZES25nVUZoWmE4SzRUbWF1?=
 =?utf-8?B?b0tjSWFLUDNXNXhzb29mUFpsbmE4RVZiS1J5RWN1eCs1M0M2SURvNHNTUCtT?=
 =?utf-8?B?d2lhek13UmtZME5tS29FWU9ydFpoTk1iYlFXZTZ0NVZ0QUFaNXBTaUlBMmpq?=
 =?utf-8?Q?5DnlCgflR8XD3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 07:27:48.7339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a96aace3-7c9c-4b46-a39f-08dc725506a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625



On 10/05/2024 11:15, Greg KH wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, May 09, 2024 at 12:14:10PM +0300, Shay Drory wrote:
>> PCI subfunctions (SF) are anchored on the auxiliary bus.
> 
> "Some PCI subfunctions can be on the auxiliary bus"
> 
> Or maybe "Sometimes the auxiliary bus interface is used for PCI
> subfunctions."
> 
> Either way, the text here as-is is not correct as that is not how the
> auxbus code is always used, sorry.

you are right, the suggested text is better, I will fix in next version.

> 
>> PCI physical
>> and virtual functions are anchored on the PCI bus;  the irq information
> 
> Odd use of ';'?  And an extra ' '?

correct, will change to '.'. and remove the extra ' '.

> 
>> of each such function is visible to users via sysfs directory "msi_irqs"
>> containing file for each irq entry. However, for PCI SFs such information
>> is unavailable. Due to this users have no visibility on IRQs used by the
>> SFs.
> 
> Not even in /proc/irq/ ?
> 

mlx5 PCI SFs doesn't have IRQ of their own. mlx5 PF provide IRQs to mlx5
SFs to use. the /proc/irq/ show the IRQ of the PF device. there is no
vendor agnostic way to identify an IRQ of a device, using /proc/irq .
we rule out an option to add a new sysfs to the /proc/irq for a very
norrow use case of SFs.
In additon, we rule out the usage of IRQ name, since these PCI SFs might
share IRQs between peer SFs, as written bellow.

>> Secondly, an SF is a multi function device supporting rdma, netdevice
> 
> Not "is", it should be "can be"  Not all the world is your crazy
> hardware :)

correct, will change in next version

> 
>> and more. Without irq information at the bus level, the user is unable
>> to view or use the affinity of the SF IRQs.
> 
> How would affinity be relevent here?  You are just allowing them to be
> viewed, not set.

correct, affinity setting is already controlled via /proc/irq. the
motivation here is to show the mapping between PCI SFs and IRQs like PCI
PF/VF and IRQs.

> 
>> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
>> for supporting auxiliary devices, containing file for each irq entry.
>>
>> Additionally, the PCI SFs sometimes share the IRQs with peer SFs. This
>> information is also not available to the users. To overcome this
>> limitation, each irq sysfs entry shows if irq is exclusive or shared.
>>
>> For example:
>> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
>> 50  51  52  53  54  55  56  57  58
>> $ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
>> exclusive
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Shay Drory <shayd@nvidia.com>
>>
>> ---
>> v3->4:
>> - remove global mutex (Przemek)
>> v2->v3:
>> - fix function declaration in case SYSFS isn't defined (Parav)
>> - convert auxdev->groups array with auxiliary_irqs_groups (Przemek)
>> v1->v2:
>> - move #ifdefs from drivers/base/auxiliary.c to
>>    include/linux/auxiliary_bus.h (Greg)
>> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
>> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
>> - Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
>> - Fix auxiliary_irq_mode_show doc (kernel test boot)
>> ---
>>   Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
>>   drivers/base/auxiliary.c                      | 178 +++++++++++++++++-
>>   include/linux/auxiliary_bus.h                 |  24 ++-
>>   3 files changed, 213 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
>> new file mode 100644
>> index 000000000000..3b8299d49d9e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
>> @@ -0,0 +1,14 @@
>> +What:                /sys/bus/auxiliary/devices/.../irqs/
>> +Date:                April, 2024
>> +Contact:     Shay Drory <shayd@nvidia.com>
>> +Description:
>> +             The /sys/devices/.../irqs directory contains a variable set of
>> +             files, with each file is named as irq number similar to PCI PF
>> +             or VF's irq number located in msi_irqs directory.
> 
> So this can be msi irqs?  Or not msi irqs?  How do we know?

PCI PF/VF showing IRQ type (msi/msix) for each IRQ is lot of
duplication, probably because of the history. As per PCI spec at a given
time, only msi or msix can be enabled, don't both, and this is visible
through the PCI capabilities.
showing msix is not usefull for PCI SFs.

> 
> 
>> +
>> +What:                /sys/bus/auxiliary/devices/.../irqs/<N>
>> +Date:                April, 2024
>> +Contact:     Shay Drory <shayd@nvidia.com>
>> +Description:
>> +             auxiliary devices can share IRQs. This attribute indicates if
>> +             the irq is shared with other SFs or exclusively used by the SF.
>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> index d3a2c40c2f12..def02f5f1220 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -158,6 +158,176 @@
>>    *   };
>>    */
>>
>> +#ifdef CONFIG_SYSFS
>> +/* Xarray of irqs to determine if irq is exclusive or shared. */
>> +static DEFINE_XARRAY(irqs);
>> +
>> +struct auxiliary_irq_info {
>> +     struct device_attribute sysfs_attr;
>> +     int irq;
>> +};
>> +
>> +static struct attribute *auxiliary_irq_attrs[] = {
>> +     NULL
>> +};
>> +
>> +static const struct attribute_group auxiliary_irqs_group = {
>> +     .name = "irqs",
>> +     .attrs = auxiliary_irq_attrs,
>> +};
>> +
>> +static const struct attribute_group *auxiliary_irqs_groups[2] = {
> 
> Why list the array size?

correct, will drop in next version.

> 
>> +     &auxiliary_irqs_group,
>> +     NULL
>> +};
>> +
>> +/* Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
>> + * shared or exclusive.
>> + */
>> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
>> +                                    struct device_attribute *attr, char *buf)
>> +{
>> +     struct auxiliary_irq_info *info =
>> +             container_of(attr, struct auxiliary_irq_info, sysfs_attr);
>> +
>> +     if (refcount_read(xa_load(&irqs, info->irq)) > 1)
> 
> refcount combined with xa?  That feels wrong,

correct, will split in next version.

> why is refcount used for this at all?
> 
>> +             return sysfs_emit(buf, "%s\n", "shared");
>> +     else
>> +             return sysfs_emit(buf, "%s\n", "exclusive");
>> +}
>> +
>> +static void auxiliary_irq_destroy(int irq)
>> +{
>> +     refcount_t *ref;
>> +
>> +     xa_lock(&irqs);
>> +     ref = xa_load(&irqs, irq);
>> +     if (refcount_dec_and_test(ref)) {
>> +             __xa_erase(&irqs, irq);
>> +             kfree(ref);
>> +     }
>> +     xa_unlock(&irqs);
>> +}
>> +
>> +static int auxiliary_irq_create(int irq)
>> +{
>> +     refcount_t *new_ref = kzalloc(sizeof(*new_ref), GFP_KERNEL);
>> +     refcount_t *ref;
>> +     int ret = 0;
>> +
>> +     if (!new_ref)
>> +             return -ENOMEM;
>> +
>> +     xa_lock(&irqs);
>> +     ref = xa_load(&irqs, irq);
>> +     if (ref) {
>> +             kfree(new_ref);
>> +             refcount_inc(ref);
> 
> Why do you need to use refcounts for these?  What does that help out
> with?

please see my answer bellow

> 
>> +             goto out;
>> +     }
>> +
>> +     refcount_set(new_ref, 1);
>> +     ref = __xa_cmpxchg(&irqs, irq, NULL, new_ref, GFP_KERNEL);
>> +     if (ref) {
>> +             kfree(new_ref);
>> +             if (xa_is_err(ref)) {
>> +                     ret = xa_err(ref);
>> +                     goto out;
>> +             }
>> +
>> +             /* Another thread beat us to creating the enrtry. */
>> +             refcount_inc(ref);
> 
> How can that happen?  Why not just use a normal simple lock for all of
> this so you don't have to mess with refcounts at all?  This is not
> performance-relevent code at all, but yet with a refcount you cause
> almost the same issues that a normal lock would have, plus the increased
> complexity of all of the surrounding code (like this, and the crazy
> __xa_cmpxchg() call)
> 
> Make this simple please.

There was a global mutex, will restore it and will replace the refcount
with a simple counter.

> 
> 
>> +     }
>> +
>> +out:
>> +     xa_unlock(&irqs);
>> +     return ret;
>> +}
>> +
>> +/**
>> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>> + * @irq: The associated Linux interrupt number.
>> + *
>> + * This function should be called after auxiliary device have successfully
>> + * received the irq.
>> + *
>> + * Return: zero on success or an error code on failure.
>> + */
>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
>> +{
>> +     struct device *dev = &auxdev->dev;
>> +     struct auxiliary_irq_info *info;
>> +     int ret;
>> +
>> +     ret = auxiliary_irq_create(irq);
>> +     if (ret)
>> +             return ret;
>> +
>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +     if (!info) {
>> +             ret = -ENOMEM;
>> +             goto info_err;
>> +     }
>> +
>> +     sysfs_attr_init(&info->sysfs_attr.attr);
>> +     info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
>> +     if (!info->sysfs_attr.attr.name) {
>> +             ret = -ENOMEM;
>> +             goto name_err;
>> +     }
>> +     info->irq = irq;
>> +     info->sysfs_attr.attr.mode = 0444;
>> +     info->sysfs_attr.show = auxiliary_irq_mode_show;
>> +
>> +     ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
>> +     if (ret)
>> +             goto auxdev_xa_err;
>> +
>> +     ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
>> +                                   auxiliary_irqs_group.name);
> 
> Adding dynamic sysfs attributes like this means that you normally just
> raced with userspace and lost.  How are you ensuring that you did not
> just do that?

I am not sure I understand, but the IRQs and their sysfs are added
dynamically during SF probe. so user interested in the mapping will
probe the SF before using the sysfs.
is this answering your question?

> 
>> +/**
>> + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>> + * @irq: the IRQ to remove.
>> + *
>> + * This function should be called to remove an IRQ sysfs entry.
>> + */
>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
>> +{
>> +     struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
>> +     struct device *dev = &auxdev->dev;
>> +
>> +     if (WARN_ON(!info))
> 
> How can this ever happen?  If not, don't check for it please.  If it can
> happen, properly handle it and move on, don't reboot the box.

correct, This cannot happen, I will drop it.

> 
> thanks,
> 
> greg k-h

