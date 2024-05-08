Return-Path: <linux-rdma+bounces-2343-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 940768BFC1E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 13:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F0AB20AE9
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 11:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7081ABF;
	Wed,  8 May 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OPtzflLF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED62426AFF;
	Wed,  8 May 2024 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168017; cv=fail; b=VLCnrs/Dkv4BeUm22yI6Pd+kpGpTvnvGI0dFzVLF5T8JG4IyyXRA9w9EYLWFkYtWFKbK+pWIBM5MlsvTQMvAwAOVAf14kY44waXwTQ/wg6124J6kaMmBmP18Ru2y0HHcgWEk1AdZh4S5J25Ef8xN5oJKMj/W6sn1r9BzyZkpZn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168017; c=relaxed/simple;
	bh=HLqk1HBxTA3WUYwQ+Q1SmZ6YIPY5e0mxMHpPHxdzsss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HBqQNDTbfs2FagOolYVbd7ts9ZJE+aRzBZeRdqQmn0No0j26Ysof4df9q9raSJXz4ZL3tdb5MacapBqjA/c8Lx33kLf8aJoOL4yIEBDty1h3uZH+7TNposzakp3BoO9nEVvq87OOsh3tK4qHWgXmnbqWdvqL+gqtQSjqzkxNCnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OPtzflLF; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOzQXsdgxY5QbCgxVEvxF9Wi5JyxS4tTTNKZoTFmMiMjYwQ0Tz13vdGXm14Wv4GfLOxiRCY6A89mlQNzfIrX3i/7sCQhx0fPRjpuJPBVzSBLBRLQIchc+C0qSNtxBRL2FZIlEKG3T+1mVmsppfXKzBtt/pIXBx/g6uc4Ufs6RQBU0suJyqA5snvXxKv5CRVWqstou/mQDgSGGfSSyzFrewd1K+KNYN5gyk+2NJxYMNYXznlPS/t5bhWpZ85YPIUADs9WmJ6S9x+GI/fW0/IWAPjfBSCmfOLllEy3t0zYV4DH/JY0+uHCTSQ13CMk/wsgokFwmfxA33ko5EUh8XZzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ePdzOyvzPfU37ZnhOGtngZR0M8euaPvndjzTJpxAqc=;
 b=ZkpOAGVZ2h3DNAjT4Gm5XDtiQteGP9LbkHxCysogsOLgvgscbhZbj4mtdLiMeHIiNr0Aml2DbjXneewF3+/k4jtmEj0xtj3fKA0eeZ5pfIjVTxpLa/td7zw0Ny5FAsO+uiQWdYlriBKToMaCiM+AefhdfhZ2CcKgyoNu0RKTNwfwuGncndH7/9qVyJu6gwkQk59XkxoIZRODZQenp/iX4RqOhUcPgJrE9FnSMpMNIj/PonGLKlg41Egc6N4H4tN5SGg59uiXa9nAEtmQ80DZaJLzlIFDR+mjyipKrFLXpMQR86YH1dARIy+oM5CAuPqBaAKhsyXFuuAOpCYXCr0yrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ePdzOyvzPfU37ZnhOGtngZR0M8euaPvndjzTJpxAqc=;
 b=OPtzflLFCqsHvvLxNNQADIT68eMVOgqvroyhstpFhBkDUlozXQt5cS8aNpsguzLt0S4gdBRBw+IPWtxf/RdPTo1Beayg/LJ8UKtMZ+HWGjVusk3XpE14z8dDs5jzQlrT6ecSi3WEuMzHaCqNl8RJ9oIO18sEdfgliLzOKql+zcRIWqAOdnlLSkeX+ane5FtPcCgBHVqOOGHCnBd3KRwC3UThVnuaq9PzMAleKGbp6lUHEPm+d0vIsuCMhIoPdpUO5CVuqwCWHbfpoNgqsZzF6cJ9YDU8nnN+Pj1BPHYeFJ/1oBNaVIuUznFdRjdtVW3xZN+ZbieBPY9r374987JY3Q==
Received: from MN2PR17CA0026.namprd17.prod.outlook.com (2603:10b6:208:15e::39)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 11:33:31 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::7c) by MN2PR17CA0026.outlook.office365.com
 (2603:10b6:208:15e::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Wed, 8 May 2024 11:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 11:33:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 04:33:18 -0700
Received: from [172.27.34.221] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 04:33:12 -0700
Message-ID: <fa46ce9f-75f8-49af-8fb7-37b1e698f349@nvidia.com>
Date: Wed, 8 May 2024 14:33:05 +0300
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
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <6da0b4eb-717b-4810-951c-b59edf32e422@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f2b41b-8691-4aa8-f46a-08dc6f52b02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXVkYnRUMGxHc3F1dU1qamliYVFIbnJuU0dQeHpkN1E0VDE0MXZNb2x3dXNO?=
 =?utf-8?B?Nm9RaFhFQTI5c2pyaVFhVVNTd011S2x6d1Z4OUh5ZEVGUExkWkE2U1VSTEtK?=
 =?utf-8?B?c2cxSmR3S1dUWm51Nk5RMEE4aFdQaXBLMDJFeUw5eXJpc3lyNWMydWZzUmN1?=
 =?utf-8?B?YmJHSE9meVQwWXd0Skd4dzJKbCtHWDhzb0RGYXNzVDc4TWRML3ZoWFFteFNM?=
 =?utf-8?B?TE1uRTlvZ3l0NWV1VWdZYlR6NU02Y00xdWEzdHEvRVhwVWl2M2pOV2NzRWxE?=
 =?utf-8?B?VXBKczVzM21WZHZ0QnNpWlBFMGk2M0RZcXAybFFHNE5UdFo5ZEVIZFlhblBz?=
 =?utf-8?B?cCtaTTV0dDR3YXQwUEMrNDVreE0zejArTkV3bUM2Z1Ivc1p4bVoyOEJHRXlC?=
 =?utf-8?B?MnBXUzBCOTB0b2hkSk9qZkFIdkxaOVp0enVvZzE2aUZ0MTllVUJGd0dVT05y?=
 =?utf-8?B?SGEzNm9uNU9wbWYzUjNMTUROZW1DTzl2dUJvc0trN3ZyMkFHcEJxRVJBQzJt?=
 =?utf-8?B?MzMyVjNldFplZ1VFZytaa3o2QjdIVlVZdWlReWNHYmdoeUFldTlHZDRITk5h?=
 =?utf-8?B?TjFNa1NQR0FyelFXeFBWL3dKSHFFSlRnSDJUU0hkdUh2VWh1MG9WcktmK3cw?=
 =?utf-8?B?dEFsSy9sYUNxOCt0dmJldE5mTENTT1lwUUdzOUs3dzh2SDhWdjJwb1Rpd2Fx?=
 =?utf-8?B?QWthemRhRU5ER2ZnRC9ZTVAvOGs1NFFialVoZDRYVGVwaTA3N0ZOb1FQTmtu?=
 =?utf-8?B?eVQ3Y0RRMXBlSVluWW1TS0p4VXBDZGUzT3NJOE1RSzV0ajVHUVJpVXB3d2pQ?=
 =?utf-8?B?d2JmRGNwc0dlZ3B5RndxZjNNY2tGcDZETTF2emlvZllnQXlxRHhRSGRsL0o2?=
 =?utf-8?B?UEVJeUdqUFlqYUhJTnhVc3ZGcTQ5RkdNTkVtdG9jcGJKTlcrdFB0TG5LWm90?=
 =?utf-8?B?Kzl0U0xiVVRHcmxFT1ZlMXNDRXgxeE9tdlE1TzlMRmZjTFMzZjhYbWtxaG1a?=
 =?utf-8?B?UERQblUyZCtDSHZTRDQ3MzRXL0Y3WnpXQ29VdUd5WVA3RHhOTXpnSklYQUxW?=
 =?utf-8?B?WDFjMHZFNDJyckx1dmlWZXRzeU9DVjhaV1FXOVhBNCsyaFVmUVc5ZGZKWTRx?=
 =?utf-8?B?QXg0aTVHeURxNmNWUTlBRFczcHFWVEIrR2VTUElLaUkrZ1ZpSGthNXI2ejVs?=
 =?utf-8?B?VXZpSWNSWnd3Y2RxakJQSVR6TDhQaDk1RUVpN3ZPS3luM2d2S0l1K0JGQk9m?=
 =?utf-8?B?aExMYUhPWlc3ZUJ0OXNPMGZsbGtQVjF1VXlFUzZjSHlVNUxlaElYekZKUFlQ?=
 =?utf-8?B?TllBMUhnd1I4N2o2d1hFRzZDbCszVDFMUnBCWXRaUWdTYXVUMjBaRWxJQlk5?=
 =?utf-8?B?eUNQQ1RVOTY1NnpOb2dtSjNkdjFHcHlhMVBFVjBkaDAzckYxT3NFOUF4UmNi?=
 =?utf-8?B?OGNEb2pkQzlLMUtKMlVzU1RJcmlHRUFFQklDYTJEM05YMDFVZExRZ29pdVJ5?=
 =?utf-8?B?VFVpYjJJaC9OK05EM09CeU9QZ0U1WGJ5VkRGMG00ZXN4UW4xMVptUlg1SmZ1?=
 =?utf-8?B?RTZPczYvbzlFY28ydDNJNDlIUWI0WEtEUmNjcC9yaSs1MVFQbDR6WVQrTnRP?=
 =?utf-8?B?RG1QanFYcm9oU1Z1aFRmeTUwbDhNa3c0M1g3cnVtNkFSWWdOM1M4SDhBaDBH?=
 =?utf-8?B?OE0rbGFSR2h2RTJRRHo2SkxaaWZwYThZN2NsZDluQ3hKY3FDMnh2cWVnSlVR?=
 =?utf-8?B?VS8wdGx3SHhVS2RwejVBemt5N1dMOVZzQTJmTHBmdzlYdDduTjFidmdhTlRZ?=
 =?utf-8?B?eVRkSDZLbFVEZGtObE1QVFhHczlQeVBVY3MyRERsa3MrQVlZNFFPK1Y4Q3R6?=
 =?utf-8?Q?nWOhGzp/yeuQA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 11:33:31.1474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f2b41b-8691-4aa8-f46a-08dc6f52b02c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667



On 08/05/2024 12:34, Przemek Kitszel wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 5/8/24 06:04, Shay Drory wrote:
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
>> v2->v3:
>> - fix function declaration in case SYSFS isn't defined (Parav)
>> - convert auxdev->groups array with auxiliary_irqs_groups (Przemek)
>> v1->v2:
>> - move #ifdefs from drivers/base/auxiliary.c to
>>    include/linux/auxiliary_bus.h (Greg)
>> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
>> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
>> - Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
>> - Fix auxiliary_irq_mode_show doc (kernel test boot)
>> ---
>>   Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
>>   drivers/base/auxiliary.c                      | 171 +++++++++++++++++-
>>   include/linux/auxiliary_bus.h                 |  24 ++-
>>   3 files changed, 206 insertions(+), 3 deletions(-)
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
>> index d3a2c40c2f12..6293c6707e1e 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -158,6 +158,169 @@
>>    *  };
>>    */
>>
>> +#ifdef CONFIG_SYSFS
>> +/* Xarray of irqs to determine if irq is exclusive or shared. */
>> +static DEFINE_XARRAY(irqs);
>> +/* Protects insertions into the irtqs xarray. */
>> +static DEFINE_MUTEX(irqs_lock);
> 
> sorry for not catching it earlier, you don't need a separate lock,
> xarray provides one, please see below [1], [2]
> 
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
>> +static const struct attribute_group *auxiliary_irqs_groups[2] = {
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
>> +
>> +     if (refcount_read(xa_load(&irqs, info->irq)) > 1)
> 
> I didn't checked if it is possible with current implementation, but
> please imagine a scenario where user open()'s sysfs file, then triggers
> operation to remove irq (to call auxiliary_irq_destroy()), and only then
> read()'s sysfs contents, what results in nullptr dereference (xa_load()
> returning NULL). Splitting the code into two if statements would resolve
> this issue.

the first function in auxiliary_irq_destroy() is removing the sysfs.
I don't see how after that user can read() the sysfs...

> 
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
> 
> [1] xa_lock() instead ...
> 
>> +     ref = xa_load(&irqs, irq);
>> +     if (ref && refcount_inc_not_zero(ref))
>> +             goto out;
> 
> `&& refcount_inc_not_zero()` here means: leak memory and wreak havoc on
> saturation, instead the logic should be:
>         if (ref) {
>                 refcount_inc(ref);
>                 goto out;
>         }
> 
> anyway allocating under a lock taken is not the best idea in general,
> although xarray API somehow encourages this - 

> alternative is to
> preallocate and free when not used, or some lock dance that will be easy
> to get wrong - and that's the raison d'etre of xa_reserve() :)

I don't understand what you picture here?
xa_reserve() can drop the lock while allocating the xa_entry, so how it 
will help?

> 
>> +
>> +     ref = kzalloc(sizeof(*ref), GFP_KERNEL);
>> +     if (!ref) {
>> +             ret = -ENOMEM;
>> +             goto out;
>> +     }
>> +
>> +     refcount_set(ref, 1);
>> +     ret = xa_insert(&irqs, irq, ref, GFP_KERNEL);
> 
> [2] ... then __xa_insert() here

__xa_insert() can drop the lock as well...

> 
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
>> +     if (WARN_ON(!info))
>> +             return;
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
>> @@ -295,6 +458,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
>>    * __auxiliary_device_add - add an auxiliary bus device
>>    * @auxdev: auxiliary bus device to add to the bus
>>    * @modname: name of the parent device's driver module
>> + * @irqs_sysfs_enable: whether to enable IRQs sysfs
>>    *
>>    * This is the third step in the three-step process to register an
>>    * auxiliary_device.
>> @@ -310,7 +474,8 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
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
>> @@ -325,6 +490,10 @@ int __auxiliary_device_add(struct 
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

