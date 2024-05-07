Return-Path: <linux-rdma+bounces-2326-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16D8BEAB6
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 19:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B43285378
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 17:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A99B16C854;
	Tue,  7 May 2024 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fcj0C4lV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17714D2A5;
	Tue,  7 May 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103790; cv=fail; b=gABxLTcOKUi1jHpjrAUK7iOAHJrXBnPYjldFtoMDp4fOXDyUn7iTaKaMOMMSU/ORiFgs6wbhrMbiJN2ooPvPAdrx+rX+7A4P1/Scg4HWN68PYIKcuVctzOUJLITjyXsKihEyaSh7gd6WHyqwCk3raysqHjkZ+iO5wel6vETYgvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103790; c=relaxed/simple;
	bh=DXSkfWTNuSNCYQDtzHkB/t8deoZbWcut/cABFvmm6UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q8T6NLwt5dFQoiKMD0OX7AU1kLzMpy8aGWEAbjT0RFnzS5nnhQxjpBV6qyQhoLzxmg1mQQd4+6vQ8mmiRw2ZpQAHwVho0dS1qVDqZE4J/1uk7adYmxePs9k/v1Pd+BFntGRqlBZ922/3bQVnaP5ZG20jkkWZid3vkczWGaUyHzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fcj0C4lV; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jilwpyL1VOCNf7teIt4tcuR1Wvo6EwtWWyjzV6mkzIVNsdn/q2eIcKyY4pqa530uFsyu6ZmwNXDVmlyMxsZILELUwtijSqxXALi6cNfrvXSytIUtBtxmpgpVJZjxMebSQI41dcQ2jqFXCcEILmo0BIYRc4DgcHg8sMxl+TYlJJddXUTfEnWKRFL+ey0qtsqhA2/JZlupbM6aMrKW2Q7+kMUpQ0uxKjE95DJSch8h0lYSNY9VLrTtqiM94oH5ibFmRje2yh1WrVn51Pd4E+R/vKg/4G0hJxs+a4VzhKZsv3TAhvMsmXb8YlXtIw2zoGAFQmWttUuGz+ZtaeimlfTk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24X06JWGVsPAf2Rvs0/LP+/6h8tn5ZrvruRTndSh0Zc=;
 b=J41f8s0gMOb80VXjP6NT6z7Ki6S994cQRSInMGWt2jjjIWtkWuQb7BOGz42AVrUw5udF9n2uDC7aYVEbp386PH7u9juvJoJ7fa07r1mfCub5hquMknXnNImnjg//uoVgF7/gJjIUEPlB32iDrVcmy2lXhhNSxJy1kVopmPPWPS2UO4Oct0VWaGbdaxuDGJqkFp4UtUaKzY0IB3oxuswH1Zkm6drWtTDmNovUvW6Dg9PFokhKv3QU+Xna37y3AUzoVLby3I1VelBNbQf/vU4ZP9wpdHcVXp0UA3VSJLtOHSFPZzG0k+wVf6ZCZkr6cq0KSDM6gNCU22p1hl3Kyp3hOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24X06JWGVsPAf2Rvs0/LP+/6h8tn5ZrvruRTndSh0Zc=;
 b=Fcj0C4lVL7p6h2h6hb7qX8FPBdzyU2Q7kPcInrfX4kGn1tj9iI/wfa2rpssiQXiNj1EzHWfmHqfTTgSe0d3m3lscxOIq5yiVUaVYcbUwvB70tvICZfZ5vESmXvfPm1yfjHAiTBlqOpAJAicnXYbWN1JlbYQqbDLdXsVCydrZB2EiyqyT1HfYi1ICyFYvZi/8CET/HRwHdm6fL7tauB24wpKuD4H/QKQdA6PI6MdjxvexCMYItZJgox+/S8lf9cE/ecE+5EtrgIIXJAQEION3zfXf4x3g1cjwYzeJUjyK4RNBBvI9l6llu1wSLtosMUBAtLojGcbxlC0IjUFQ58ixCQ==
Received: from PA7P264CA0097.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:348::15)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 17:43:02 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10a6:102:348:cafe::8e) by PA7P264CA0097.outlook.office365.com
 (2603:10a6:102:348::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Tue, 7 May 2024 17:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 17:43:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 10:42:31 -0700
Received: from [172.27.34.221] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 10:42:26 -0700
Message-ID: <383f72bc-cf04-4ca6-bfd8-4647781a81dd@nvidia.com>
Date: Tue, 7 May 2024 20:42:23 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240505145318.398135-1-shayd@nvidia.com>
 <20240505145318.398135-2-shayd@nvidia.com>
 <14f913ce-d041-4960-9379-886a0c7fc106@intel.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <14f913ce-d041-4960-9379-886a0c7fc106@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db1f112-4514-4af1-0893-08dc6ebd2387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1g0UTc5WVdOR0QwRXB1bVRoeFNNVE05Tlpoc3VNVS9oUTRLY3J4SnM3ZGZj?=
 =?utf-8?B?SmJ3by82eE83SXpaYXZKcG93NVpTUVhRdHdNNm5WRkIrV2NscjFwbXhLT1NR?=
 =?utf-8?B?MlN3QzRISk9HY21nMHF0Zmlob1E3b3NqQ1dQcnVXVXZFSklISWltMFRzWXhz?=
 =?utf-8?B?VlZhMmlDcS9BdmxVMHZ0OHpEK0R5ZTlQMlEwOElYeGEvUjNCZk5lNE5BbHEr?=
 =?utf-8?B?TSt4TDQ5SkwxUUlFSklNQ0x1b3V1WnEyZ2VvUGtiL3AzeDRUbEx6MUtlODFJ?=
 =?utf-8?B?SXlrb2VFM1RhTTFQZWljZjdXVDF3UmhvcVNqYW5vQVdidHdSMDlCZnNHNGlQ?=
 =?utf-8?B?ZzdoZDdwQlVqWE9ibGhkZVBNTzVJSU1JVFZlcjgwZzY1WkJMTEI4bzJkK0FQ?=
 =?utf-8?B?M1o2TWdXWktwdFJwaHVOb0pYNGIrbXdFZTByTXQxazdtc0lFVWU1bzI1MDNB?=
 =?utf-8?B?dVFXSnZsaU11UVk3RHFQVldmWVlUZFlZYmMwK3IrbUhmbWJTTW9RdDE5SlJx?=
 =?utf-8?B?RzR0WEVWZHNFVnhsVURoU21VTnRCYWduREhnejV5aGdHYUxUMUJCVzZFUUtx?=
 =?utf-8?B?ZzNFNnNielEyUDl6Rit3amZ5MUJ5eG5XMEdNYUpGYTduZGZiTG1sZGVlNU9y?=
 =?utf-8?B?bUU1OUZhTE56TjNiNzcxVUlYcFUvSExNVVQrZEpUVUhMWlovTEMzNTFYK3Q3?=
 =?utf-8?B?b0RISE1lbmUxQXdqYXdudEdwR3ZDeG5Pa1Z2R3E2QUZoUVBHWjI0ZVRyUUVy?=
 =?utf-8?B?eFBaWEZObVp1allDT3VFY0UrN0J2NUsyUlcrdWtmeXNQYmtlSm1PNVRXblVs?=
 =?utf-8?B?TnlqZm9ETEFaTHlFbzFvamNSSDJia05GRXBVbFJScXExOEJQbFhWeTdoNU9X?=
 =?utf-8?B?L0tNeDFvd3I5V0JGSnMwbGRrbzR6Q3V0cWhqc1RNKzZCNFlDQUcxRGtFTlh4?=
 =?utf-8?B?anlGZWMwVVEvUDMrL0xsZ3M0ODBWdHdmS0w5QWxMRyt6SmtoUHQweXpvMTda?=
 =?utf-8?B?dnllSTExMUlpRjlXbUlVd1QySjhrZmExU0tNeXQwRlBXdmRMeGUzRTdvYXpa?=
 =?utf-8?B?cmJVeEt4b2hwdnZWcHVaM1ZFVHZkdE5IaWdRZ0hIZ1RSQkMwaHdRdGRLbHM3?=
 =?utf-8?B?NUg5Q3U5ZURzUStTd0k4bktEYU5LeGlXcnhoOWpQM2tqM3h6RFlHTDcrZzBT?=
 =?utf-8?B?RDBmbXZuaUhNSmpkSzlzWGRSK3FGdG5Pby9iMmtoZDVXZ1ZkeWpPT1R4LzhK?=
 =?utf-8?B?MzYwYWNpUmJRNTBGMVNSNll1eFE4blhETkIyVjByOExVZXpqZVhSRWtYeFly?=
 =?utf-8?B?dVBkMFBlS3ZzaldSc1JCLytEd1phYmdHVmhYM2hCakJsRGhIVXVRTW55ZlVB?=
 =?utf-8?B?MFduakM0Mko3Y0Z2VGR5aTdCZTJXSkJsdzZjWStENGtBS0NDd01TWERma3Mz?=
 =?utf-8?B?WmxrZzU4NllLeTlSUm53K2tZMmpxWjg2Mlh3RlFEMUNrRDI3WlZVVlh2MVpw?=
 =?utf-8?B?Q0tRNERPN0l2c2NVQStxbzdTT01iRjEvbjZTbE5vUEF3WVZkOXUwK01XQWdx?=
 =?utf-8?B?OXcyaU55Z1ZjVTdZZFd5THdKWTVOUHFLeEhZTDd3Q3NSVXcySkVQbDIzNktD?=
 =?utf-8?B?TExDcFR4N1FCZHhESkRNMjJUZkRYQUIzY2FUaDVoT29ieml1MTR0cmJJajF4?=
 =?utf-8?B?TzVMdENlejRydEFSQWVtalBKdjA5UGVjUWxQUG5za09iZjNGUlRobGtGV0hp?=
 =?utf-8?B?U0V1OUZac0E1L09UWU1CbVBQRExuN2o0b0lsMWR5MzdNS1lzT2dCT05GalRX?=
 =?utf-8?B?dDZ5Vk1RS0Y0dnZObjBoajdhbXlZZGtsTnpING5CdjlocHh6dDJCOGgwQ2gv?=
 =?utf-8?Q?QbPmujN606UWY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 17:43:00.2287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db1f112-4514-4af1-0893-08dc6ebd2387
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671



On 07/05/2024 11:12, Przemek Kitszel wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 5/5/24 16:53, Shay Drory wrote:
>> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
>> and virtual functions are anchored on the PCI bus;  the irq information
>> of each such function is visible to users via sysfs directory "msi_irqs"
>> containing file for each irq entry. However, for PCI SFs such information
>> is unavailable. Due to this users have no visibility on IRQs used by the
>> SFs.
>> Secondly, an SF is a multi function device supporting rdma, netdevice
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
>> v1->v2:
>> - move #ifdefs from drivers/base/auxiliary.c to
>>    include/linux/auxiliary_bus.h (Greg)
>> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
>> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
>> - Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
>> - Fix auxiliary_irq_mode_show doc (kernel test boot)
>> ---
>>   Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
>>   drivers/base/auxiliary.c                      | 167 +++++++++++++++++-
>>   include/linux/auxiliary_bus.h                 |  20 ++-
>>   3 files changed, 198 insertions(+), 3 deletions(-)
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
>> index d3a2c40c2f12..43d12a147f1f 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -158,6 +158,164 @@
>>    *  };
>>    */
>>
>> +#ifdef CONFIG_SYSFS
>> +/* Xarray of irqs to determine if irq is exclusive or shared. */
>> +static DEFINE_XARRAY(irqs);
>> +/* Protects insertions into the irtqs xarray. */
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
>> +
>> +     if (refcount_read(xa_load(&irqs, info->irq)) > 1)
>> +             return sysfs_emit(buf, "%s\n", "shared");
>> +     else
>> +             return sysfs_emit(buf, "%s\n", "exclusive");
>> +}
>> +
>> +static void auxiliary_irq_destroy(int irq)
>> +{
>> +     refcount_t *ref;
>> +
>> +     xa_lock(&irqs);
>> +     ref = xa_load(&irqs, irq);
>> +     if (refcount_dec_and_test(ref)) {
>> +             __xa_erase(&irqs, irq);
>> +             kfree(ref);
>> +     }
>> +     xa_unlock(&irqs);
>> +}
>> +
>> +static int auxiliary_irq_create(int irq)
>> +{
>> +     refcount_t *ref;
>> +     int ret = 0;
>> +
>> +     mutex_lock(&irqs_lock);
>> +     ref = xa_load(&irqs, irq);
>> +     if (ref && refcount_inc_not_zero(ref))
>> +             goto out;
>> +
>> +     ref = kzalloc(sizeof(*ref), GFP_KERNEL);
>> +     if (!ref) {
>> +             ret = -ENOMEM;
>> +             goto out;
>> +     }
>> +
>> +     refcount_set(ref, 1);
>> +     ret = xa_insert(&irqs, irq, ref, GFP_KERNEL);
>> +     if (ret)
>> +             kfree(ref);
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
> 
> s/received/registered/?

I used received on purpose. as mention in the commit message: "the PCI 
SFs sometimes share the IRQs with peer SFs." This means some SFs won't 
register the IRQ.

> 
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
> 
> (not an issue, just a question)
> do you need to select IRQ to remove? ...

yes. in order to keep a symetry between add and remove flows.

> 
>> +{
>> +     struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
>> +     struct device *dev = &auxdev->dev;
>> +
>> +     if (WARN_ON(!info))
>> +             return;
>> +
>> +     sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
>> +                                  auxiliary_irqs_group.name);
> 
> ... because there is an option to remove whole group at once
> 
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
>> @@ -295,6 +453,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
>>    * __auxiliary_device_add - add an auxiliary bus device
>>    * @auxdev: auxiliary bus device to add to the bus
>>    * @modname: name of the parent device's driver module
>> + * @irqs_sysfs_enable: whether to enable IRQs sysfs
>>    *
>>    * This is the third step in the three-step process to register an
>>    * auxiliary_device.
>> @@ -310,7 +469,8 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
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
>> @@ -325,6 +485,11 @@ int __auxiliary_device_add(struct 
>> auxiliary_device *auxdev, const char *modname)
>>               dev_err(dev, "auxiliary device dev_set_name failed: 
>> %d\n", ret);
>>               return ret;
>>       }
>> +     if (irqs_sysfs_enable) {
>> +             auxdev->groups[0] = &auxiliary_irqs_group;
> 
> I would remove this array ...
> 
>> +             xa_init(&auxdev->irqs);
>> +             dev->groups = auxdev->groups;
> 
> ... and use &auxiliary_irqs_group directly here
> (you will need to change it to 2 elem array though)

thanks. will change in v3.

> 
>> +     }
>>
>>       ret = device_add(dev);
>>       if (ret)
>> diff --git a/include/linux/auxiliary_bus.h 
>> b/include/linux/auxiliary_bus.h
>> index de21d9d24a95..fe2c438c0217 100644
>> --- a/include/linux/auxiliary_bus.h
>> +++ b/include/linux/auxiliary_bus.h
>> @@ -58,6 +58,9 @@
>>    *       in
>>    * @name: Match name found by the auxiliary device driver,
>>    * @id: unique identitier if multiple devices of the same name are 
>> exported,
>> + * @irqs: irqs xarray contains irq indices which are used by the device,
>> + * @groups: first group is for irqs sysfs directory; it is a NULL 
>> terminated
>> + *          array,
>>    *
>>    * An auxiliary_device represents a part of its parent device's 
>> functionality.
>>    * It is given a name that, combined with the registering drivers
>> @@ -138,6 +141,8 @@
>>   struct auxiliary_device {
>>       struct device dev;
>>       const char *name;
>> +     struct xarray irqs;
>> +     const struct attribute_group *groups[2];
>>       u32 id;
>>   };
>>
>> @@ -209,8 +214,19 @@ static inline struct auxiliary_driver 
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
>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device 
>> *auxdev, int irq);
>> +#else /* CONFIG_SYSFS */
>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, 
>> int irq) {return 0; }
>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device 
>> *auxdev, int irq) {}
>> +#endif
>>
>>   static inline void auxiliary_device_uninit(struct auxiliary_device 
>> *auxdev)
>>   {
> 

