Return-Path: <linux-rdma+bounces-3192-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E38D190A609
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 08:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0B61F23C1D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 06:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82254186289;
	Mon, 17 Jun 2024 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YZZcubmJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F3579D3;
	Mon, 17 Jun 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718606335; cv=fail; b=mUsu2fIZC4xWKXM+JPalJuZZ5TlvHo2hZxlPrfFsu769mDVM5R7NH7MRu72/BOmtRvixhCM4Ysa5oPtiuSKvdgNNsg3jR6KLiZrNf9cCA63y4qchZ3EtbMcaNCSPIoOxCCHewgOXtAcc6GmyOBXPLN/Qr5eoak5ROwVAmZQ74KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718606335; c=relaxed/simple;
	bh=t2NxDjbNNw7zNJWsexuSynp43M3ehLX4DabGM9XhHeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=exczH4LzWOJMlEBLwUloUk+lj5QmKJaQPUx2B2OKicWwkB43eXbEJXj35TcCXn83JtBQjPt+WgdGZ1r+gCVkkGMlVSWPRoLv8IC2WnSX9O2S+C0ewwcT95E3qbEa1V5YecBh12oDE8IbyIEAb4xsm4nVel2xVap0F+rLA7ldFrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YZZcubmJ; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZlzd3wARkbesOg9M57FQ9lqvlTSqbKKymJH6LnIj5DrJ6Tom+OHFx7yGXFlT597fmIIsggxwKhxwPFgNPlzYhE6kfL+N6qgokcySlIxiu1mOE7LMmKnyrA/eZMf9Q3DmjeIliMnoHqYgvklGFKF+7VQjtTKVkOXJU0r8wBfMm8jeaSDjMc/dXB3eP564WwYJeeNXJQjTewX92avHr3sI3SzUNNrRIz09UsExVwX2DJATq7nq+Cyb9sWCyuDAAHb1mQKbeBu3bTBjpjIsllXYLO2y/vk4RaOs8oFPOaIkqAjCbot0mHIMk4p9N5EJ1POLv3h1dJ5BOOEV4qUClsXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJTA83fTpwMI30hRkZennCzPhvw6MeSOVN9sZ+/QcW0=;
 b=Cpi9j21dHxqN3Aau5PET2+8qIAwnBe3rQEUS5RU62V0qkQhl//VafNYstwnMnkQtumsh51oRNCgKqPSPf6OK+HhMUYBXAy6aanjjTuc6MlUbsdN1yz7eemy0bF5vI5RulEwz5mVI3CIIy8relqxaNhzJO+bA9NYHabetGSHSKXBIQ7DH5yFQr9tM5WCWdHTKyYEUnL77ay/2LckjXQWuvw6ENZuUeohyIBd1W6OO3p8NJYKOrUTXBcAnuz3JFYZLG/aF78/mWAO9D0+nSaH1qi5cXOb78Gptt1PDk+LLtXHfBgs91tsQBgolIoyRzmewFWbJUueon895i3v3KYhOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJTA83fTpwMI30hRkZennCzPhvw6MeSOVN9sZ+/QcW0=;
 b=YZZcubmJdrfbVr6Re9/WuIaco4tegZqzSIyH0+WuPbtYaPxNt85VIwkSYmtVb27+V0LDnOipn8jqMGfBtqwvTc3VDFjn+RykoeR0NuVVmEq+kNEuKL7T+wged9HV42BUIIZL1MSdptzsOrVyV15XtMe71cmkvAkouzaNN0gYKdTuURbgtVZV5mXzMrMEjLyHyeMfPM/K9kS3sF9rsPnnOpgOlE+e7PE/oslhRHU8FTAFEN2KMfLuM5lf6ALitoe0KBCgeKGufb2YiLut6D69/LbA31VsbI00tqwT+G3KRIyl2u/5ZOCs30JVPA3dC3sLoMga62KZZYIcmPnDTUUKfQ==
Received: from SJ0PR13CA0115.namprd13.prod.outlook.com (2603:10b6:a03:2c5::30)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 06:38:50 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::29) by SJ0PR13CA0115.outlook.office365.com
 (2603:10b6:a03:2c5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Mon, 17 Jun 2024 06:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 06:38:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Jun
 2024 23:38:38 -0700
Received: from [172.27.63.78] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Jun
 2024 23:38:33 -0700
Message-ID: <42af42b6-ccdd-4d0d-8e5a-306c74f330f4@nvidia.com>
Date: Mon, 17 Jun 2024 09:38:30 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Greg KH <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240613161912.300785-1-shayd@nvidia.com>
 <20240613161912.300785-2-shayd@nvidia.com>
 <2024061306-from-equal-e2fc@gregkh>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <2024061306-from-equal-e2fc@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 96bc1c20-5b50-4a87-20e9-08dc8e9825a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VldrZWV5L2hic0I3N2tqN0w4Sm04VDFpUHVDR0hsdHo1eU8xWERNeDF1eHRz?=
 =?utf-8?B?aEdadk1GM0R0VWZwWFFDZGRjQ1B1QVh4YkF6SzlLSGw5bnNxL1N6bVMyaE1N?=
 =?utf-8?B?UVo0azV0a05xYlVPNnc0OVRvR2RQTkhSdkNzNEtYTUMyRm9XdXdFSmJNVkpF?=
 =?utf-8?B?M3N6QVdvbDU4TXFlWlBIakM4dGp0UFRwYjVVdkpKQ3lSVFBoQ0FKQWxhdVdI?=
 =?utf-8?B?N1k4WXNiY1Jqay8xWGdXcmp4WTUzUVMvTHoxTitSRWFzazRYNU1PY3g1ZjlJ?=
 =?utf-8?B?a3RBbE9LV3crd01DU3AvcFVYUnllQ3pONXliOUhGVUo0dkN4eGdVYTdJNDAv?=
 =?utf-8?B?NXNTN0F6aUJrVUVCOXR6N2tUOWlNaTU0TDNNbE11OVIxbjM1dDh6OXJwcHk3?=
 =?utf-8?B?UjlWcmJ0a1c3NkovdVhlbDBBTFFtb2JDZHE4NHI0QkRtT0RXdllTL0RkUXJS?=
 =?utf-8?B?aGJBcGV1UVp4OStwUDhjWjl2UWJxbnIzMFdzYXBNV2IxeHhaZXM3WVlpUkow?=
 =?utf-8?B?OUh2V3dpTnN4bEZ1SnFKRkxwejFzRFpJRW9NdVhqcUJFSFgyMWZsUFRnd0tJ?=
 =?utf-8?B?T2NaSEQwb1RKdW4rQ2RveUR0UWJZUFh5elVObTJJelY4UVkrY2pzMjRKSnYz?=
 =?utf-8?B?Y1dUNGtjZEErTmdXTFZ1d3VYNGdrT1JDNDVpNWg3QkZaMHZLSStiZmRkMVRW?=
 =?utf-8?B?YTFxNXBJQ2F1aW5aVkgxQ0RzbDg4Z1RIQWhURW14TXl0aUNJVE1UTWtEcHZ6?=
 =?utf-8?B?MTRVS1JrWGxCcVVueVBIU2pQL012Tm1scGE5NENmTmpoejFVVW9yenB0TVd1?=
 =?utf-8?B?MlkyU1kxdHNEZ3gxSXFBcnpDbnc2TGdYMW5aMDJ1aloxemdOY1cwanVITUF2?=
 =?utf-8?B?M1VnOW5LS2NmNG45d0pOZjkxSnZzQzJxSXdqaFQ3QjFaQjlVQ2Q4dTBWdGFF?=
 =?utf-8?B?QnRYSmVKSFdHdDB5NDY0dmE4anNJdVRSTXdvVGF1KzFNdUNRZTBiSzlvV0kv?=
 =?utf-8?B?S0p3bGswaTk1c2k5bVk5cHJOYkpyeERxeXVFTWNxZFNQTVhwN3NPalBUZlBk?=
 =?utf-8?B?bkU5UTBuZWN4OFRndVFiRlhwbzR6Q0xHTHp2VVkxY2tPdHZldDRIcVlhMzI1?=
 =?utf-8?B?c1B3TmFSN3A1Z1gxOTA0ZHR2cHM2WjJ3ZzJwNlk5Z2k4eTlWcjBNY2V2dXRt?=
 =?utf-8?B?aG9pc3I3VlZBa0dYcm5Kd1dYQ0RieC9CMzAyVzF4TlNIN2dxVnJxUHFCNng3?=
 =?utf-8?B?cmF2UGhPSDljNGxvQ2UycTJXeWovTDA5MVlhc0NKQlpyUmViaVlBVWNZYjNU?=
 =?utf-8?B?WGVPV2REcDZQTWNiVyt5QVNaM0JJTlJoa09wKytFSnJBNFFMN2VURkp0Zmsr?=
 =?utf-8?B?MEltY0JpdVFkZkdiVm1SSm5jdXJZdVBWQngrV09sbFpEZDM2bllPSFdHaVRG?=
 =?utf-8?B?aGw3OFBLaWRXNXQzclpMVEVBWjh2RDNJNFhvQWxSZ2U0VHh0YmxxbmV2N3JX?=
 =?utf-8?B?Z3hrMGVDLzdob3ZRTnd5ZFE0K250TVh5cGdxNmlhbVh4Vk53MnIzUHY5dW1O?=
 =?utf-8?B?YUh6SmhNdlJMUlB6V0YvbndkVFdab2xOdmxsN0greXBsc1R0S0hXSGo3RmRt?=
 =?utf-8?B?Y2wwek5IVm1xN0p4TUNoYm9xQVVMOG9BTTJFQjFob2pOeXh1Ymx2WHhqZEpX?=
 =?utf-8?B?djhVbC9YN3hVcWF0azdiV0dpd1ZKWjU2OHVpR0krdzRZVGVxd0l2K1JsNGNm?=
 =?utf-8?B?Y1BReXdVMlo1VlJ3Sk82K05sNlNCR2pMZzNIcWFydkhzcXltZzZ4eXRIWjVk?=
 =?utf-8?B?NWlWbDNmaEdMYWhIeHFzT2NaeFNrNk5mUzJNMXRGYjh1clZqZTdPL2J0MHhO?=
 =?utf-8?B?MlNDRmdHNWxROUhERy83a0QwaUI4M2dOWE13SkcyS1dIaFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 06:38:49.7625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bc1c20-5b50-4a87-20e9-08dc8e9825a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413



On 13/06/2024 19:33, Greg KH wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Jun 13, 2024 at 07:19:11PM +0300, Shay Drory wrote:
>> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
>> and virtual functions are anchored on the PCI bus. The irq information
>> of each such function is visible to users via sysfs directory "msi_irqs"
>> containing files for each irq entry. However, for PCI SFs such
>> information is unavailable. Due to this users have no visibility on IRQs
>> used by the SFs.
>> Secondly, an SF can be multi function device supporting rdma, netdevice
>> and more. Without irq information at the bus level, the user is unable
>> to view or use the affinity of the SF IRQs.
>>
>> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
>> for supporting auxiliary devices, containing file for each irq entry.
>>
>> For example:
>> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
>> 50  51  52  53  54  55  56  57  58
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Shay Drory <shayd@nvidia.com>
>>
>> ---
>> v5-v6:
>> - removed concept of shared and exclusive and hence global xarray (Greg)
>> v4-v5:
>> - restore global mutex and replace refcount_t with simple integer (Greg)
>> v3->4:
>> - remove global mutex (Przemek)
>> v2->v3:
>> - fix function declaration in case SYSFS isn't defined
>> v1->v2:
>> - move #ifdefs from drivers/base/auxiliary.c to
>>    include/linux/auxiliary_bus.h (Greg)
>> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
>> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
>> - Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
>> - Fix auxiliary_irq_mode_show doc (kernel test boot)
>> ---
>>   Documentation/ABI/testing/sysfs-bus-auxiliary |  7 ++
>>   drivers/base/auxiliary.c                      | 96 ++++++++++++++++++-
>>   include/linux/auxiliary_bus.h                 | 24 ++++-
>>   3 files changed, 124 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
>> new file mode 100644
>> index 000000000000..e8752c2354bc
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
>> @@ -0,0 +1,7 @@
>> +What:                /sys/bus/auxiliary/devices/.../irqs/
>> +Date:                April, 2024
>> +Contact:     Shay Drory <shayd@nvidia.com>
>> +Description:
>> +             The /sys/devices/.../irqs directory contains a variable set of
>> +             files, with each file is named as irq number similar to PCI PF
>> +             or VF's irq number located in msi_irqs directory.
>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> index d3a2c40c2f12..fcd7dbf20f88 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -158,6 +158,94 @@
>>    *   };
>>    */
>>
>> +#ifdef CONFIG_SYSFS
> 
> People really build boxes without sysfs?  Ok :(
> 
> But if so, why not move this to a whole new file?  That would make it
> simpler to maintain.

sounds good. Will move them to new sysfs.c

> 
>> +struct auxiliary_irq_info {
>> +     struct device_attribute sysfs_attr;
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
>> +static const struct attribute_group *auxiliary_irqs_groups[] = {
>> +     &auxiliary_irqs_group,
>> +     NULL
>> +};
>> +
>> +/**
>> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>> + * @irq: The associated interrupt number.
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
>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +     if (!info)
>> +             return -ENOMEM;
>> +
>> +     sysfs_attr_init(&info->sysfs_attr.attr);
>> +     info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
>> +     if (!info->sysfs_attr.attr.name) {
>> +             ret = -ENOMEM;
>> +             goto name_err;
>> +     }
>> +
>> +     ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
>> +     if (ret)
>> +             goto auxdev_xa_err;
>> +
>> +     ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
>> +                                   auxiliary_irqs_group.name);
> 
> Dynamic attributes are rough, because:

Your response after "because" is missing.
Can you please elaborate?

> 
> 
>> +     if (ret)
>> +             goto sysfs_add_err;
>> +
>> +     return 0;
>> +
>> +sysfs_add_err:
>> +     xa_erase(&auxdev->irqs, irq);
>> +auxdev_xa_err:
>> +     kfree(info->sysfs_attr.attr.name);
>> +name_err:
>> +     kfree(info);
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
>> +
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
>> +     sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
>> +                                  auxiliary_irqs_group.name);
>> +     xa_erase(&auxdev->irqs, irq);
>> +     kfree(info->sysfs_attr.attr.name);
>> +     kfree(info);
>> +}
>> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
> 
> What is forcing you to remove the irqs after a device is removed from
> the system?

We are removing the irqs _before_ removing the device.
Irqs removal is following the exact mirror of add flow.

> 
> Why not just remove them all automatically?  Why would you ever want to
> remove them after they were added, will they ever actually change over
> the lifespan of a device?

IRQs of the SFs are allocated and removed when the resources are
created.
for example, devlink reload flow that re-initialize the whole device by
releasing and re-allocating new set of IRQs.
Certain driver internal health recovery flow can also trigger similar
re-initialize.

> 
>>   int auxiliary_device_init(struct auxiliary_device *auxdev);
>> -int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname);
>> -#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME)
>> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
>> +                        bool irqs_sysfs_enable);
>> +#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME, false)
>> +#define auxiliary_device_add_with_irqs(auxdev) \
>> +     __auxiliary_device_add(auxdev, KBUILD_MODNAME, true)
> 
> Ick, no, that way lies madness.
> 
> Just keep the original function:
>          auxiliary_device_add()
> as is.
> 
> Then, if someone DOES call auxiliary_device_sysfs_irq_add() then add the
> irq directory and file as needed then.
> 
> That way no "norml" paths are messed up and over time, we don't keep
> having an explosion of combinations of function calls to create an aux
> device (as we all know, this is NOT going to be the last feature ever
> added to them...)

Thanks for the suggestion, will change in next version.

> 
> thanks,
> 
> greg k-h

