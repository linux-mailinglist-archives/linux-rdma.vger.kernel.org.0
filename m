Return-Path: <linux-rdma+bounces-2264-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26D08BBF4D
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 07:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DF41C20D2D
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 05:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFF41869;
	Sun,  5 May 2024 05:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tx+tlLRB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551717FF;
	Sun,  5 May 2024 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714886184; cv=fail; b=rliMZm8y0UApN82artnXuM9CA6VpGRkMkhE1QQ0VsZsKK4rVd3Gfn1jjcc2sVItQqcpdTrANeES276VzZxfAAc6kkN/A7oVBWbZ1Yy4W9g7FVc9rBT21RvLjXA0Yisp00HoGEr9Ax7aysvlI5VoGjZQe2sa2oK1bivoAEY9/RIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714886184; c=relaxed/simple;
	bh=1Fha+yPdC2f+SCknvyAttVjl1nFbeO0hgyc1s/3AIIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VZEYJal+U68qTZX5GSdplZ9jMtf99rzhWgjWTv35p+U7Q/YOdQzAHAE5yRgHGV1RsiE6/0KgsQXjKnn2ZQsXlB4xVC86h2m9gk3VXo4X+X2MJlA7HODjiWI3bVmoGLHe/X/fTulbDTsYAA44/D5/hNNnFhVc+YxoIaHEn6Y5H5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tx+tlLRB; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbyzpF3u7F3U3udcyc5IydfKJS9DzPGsRiKRJGGR3s9Em9P6wca7N2GxsKDgNzV0qhn1FAE9xZo1PttA1mwrwUG8quHhB/uvtsjvgD1pSNQ6pK8wt6Fh1ARgJihISSB/uN9qAMAkZhU5n5Xc/RwE0TZKRCZaolI1B/pKknulkSsVKvARBzfTmPxnHfTuGRGepxhrdxUhB4gklbd5T1w9j5YpcmcyClexD/mFDq+yKpBnsbek4tafPxIVC728+gKzFUHxlJPvGv7eaVy6D9KXez5JDaLTim8+NtYY8iExRYwU6niLfioPA1uKto9NO2ZPomIkXxKxR38weDeFacqGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgKP6SGJPyLJUoZuQ5UYd2dRIwTUYgpgXARULqKm7Ks=;
 b=Z8oKPK3gpj+g2Rrd6rljURFgb6pMM4hFI6MiYDX1oSUZJ4DmGPmo/Z+YDTwjgWhCKVxFESS/j0xBSZEQVDwqpJSWvRa4je6sUY9/BTMJrFzj0JiPAqeKQsLP+ll6jtt5KCTTNOy0uEnOCjoCT6xzWDacL499uKUr4v7MzPBrzKpseBmZCDhScW5GhD/Tb9x1H5gzfEepbs0Jb+Wq5zAId3rAXRq5eCJPUzT8sF83VivSdtYMkxeqhg4gER24HRKS7YsTEq8C5RQRnQNdk7cgUtfpAup7sDoyp0FyYaMWvnCqoDn51/qJV/mbrJqWDbqRfNLws6GxkbzXMICN+5WQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgKP6SGJPyLJUoZuQ5UYd2dRIwTUYgpgXARULqKm7Ks=;
 b=Tx+tlLRBdz9lCfUMAMZ3XYaeHcrIKK5+gMrYci0BNI9PKhiRXHjgNOIqFVqPWqWYnQ8+HgQTocOSDaPPDiSmQIUMg4iauu9QPu3atG2fNrdbhXp3/Orfls6cUOdH8Kf+9Pf85HGjelOIW18hzjuLkBILxSyldWCThhv1glldAAB5ymJ6HZNGjQ6DxnLJiFQvTAfALTD5WdC/HyNjt4k77nA/XZxAQq89RxBUL7Vreaz9nPDsFrHI/fWjmiqLz9MlSuLFymjTgXux0x71F5CgnYhpZP/gHw0wZJkufT/E3oUqitJ+AEb0tWWHJ3tj15UKMUk9GNXqN4f/lJ7VDdgcRw==
Received: from MN2PR12CA0026.namprd12.prod.outlook.com (2603:10b6:208:a8::39)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 05:16:19 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::21) by MN2PR12CA0026.outlook.office365.com
 (2603:10b6:208:a8::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39 via Frontend
 Transport; Sun, 5 May 2024 05:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Sun, 5 May 2024 05:16:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 4 May 2024
 22:16:07 -0700
Received: from [172.27.21.57] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 4 May 2024
 22:16:03 -0700
Message-ID: <5d41f0c9-fda2-4ede-b21d-4d4b6751925b@nvidia.com>
Date: Sun, 5 May 2024 08:16:00 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] driver core: auxiliary bus: show auxiliary device
 IRQs
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>, <rafael@kernel.org>, <ira.weiny@intel.com>,
	<linux-rdma@vger.kernel.org>, <leon@kernel.org>, <tariqt@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
References: <20240503043104.381938-1-shayd@nvidia.com>
 <20240503043104.381938-2-shayd@nvidia.com> <20240504175024.GI2279@kernel.org>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20240504175024.GI2279@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: e34d0e1c-e5f8-4f42-1d63-08dc6cc27ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2UwdnJPdXpkdE5TVDJjOEZ5SVR1dkJXK2FKRnQzcGNFMnVmT2lLWWtXZWk5?=
 =?utf-8?B?MmhYQzQxRFBtRmZnQVBSbDU2TXdhUEY3c2s5WFg3UUpwR0UwaldwQmcrUzJh?=
 =?utf-8?B?SENZZno5WUxrZVpxeFZVcFdlVE1qSWRXZjBVZ2l5ZFNoaUhubDJ0aWZhbnhK?=
 =?utf-8?B?SFhYK1B0bFpSbnh3SS9iRnppaXMrUFduN0VucDZiZTRWR1VQblNxd1hValA3?=
 =?utf-8?B?SXEvWjE2c0lIZDJZR2x4aTdyUWs2bVZyallaLzVzeW1VdnlCMGxCQlhYUlZY?=
 =?utf-8?B?Slozc0J4Y0t6MTRDZFBMOEVGai92K0pDTTVxQ2pFTW5rZ2pocWdxeURhQzcx?=
 =?utf-8?B?UitnZU9lelFWU1B3MzZGa0VQUTZjUEg5eHRRc3BGcTYycDRqUnBRTWtHMnVy?=
 =?utf-8?B?R1g5UWRHV0xUNFhkcitCWTJnZmJCSnd6MWwxOVJLL2NGY21ocnp6VGkwOEFR?=
 =?utf-8?B?emZKR2wzTnRaZTdQK09mWGFIaTF3bXJ3MzJYNmE1amROTURuWmNFclllRmhV?=
 =?utf-8?B?ZkFDVFlNOXIxbExLMFpmTmJHTDEvdmdMTmtZeERReEpTVHRhcmNEc2pHdSs0?=
 =?utf-8?B?cVpOZmd3M0NmZmpaV1dlTmFFVmlEK3V0Q3NpYkI4K3d2ZzlQY0ZqTnJIeFp2?=
 =?utf-8?B?ME9UT2ZjSlVCSUYxeVNRUWpkVjJwMnBhZTZZZ1BGY3lHd0RoUlZHcUY3YlN0?=
 =?utf-8?B?dGxPQUZyRm9kaU1mQjZybUIyMWpJZ1JrWHpoYXpVdEZFUFh6dUg5N3pRcTZQ?=
 =?utf-8?B?Nnd0WDV6UDF6Y3c5S0VPZ0k2UXNZQXlCQXltVGlONzJhUE55bTB6Um1CUDdP?=
 =?utf-8?B?ckp2MXNFU0FNdCtERTdKZ20rT2RKaTNXaVNZcGNWQW9RUjRnYk5mclNaT3Uv?=
 =?utf-8?B?bUZUemY5T1BrZUdnb1NmK3lJcXppeWtJUUtIOGJycEdIbC9FQURqMDRaYkt6?=
 =?utf-8?B?M0hwMnFWTzlDUE5oRjdvRXRSeTZ1dHlmYlhFWGJTMTFlYVFkQkNTQjRQZjQ0?=
 =?utf-8?B?Ti9PaVRkR2ZORmNqcjAwdGdjMlRpanhORXZGSWQzY0h5TGpuazRJSTZXVXJ3?=
 =?utf-8?B?c0hDa3kwUWE5RGFteGtCTGUwZ1kvUkR0ZHBzdkU2VkxvWXVxbk5nK09zQ3pp?=
 =?utf-8?B?bDRGdnVLUW5KQzNkaDRqSnZKa0JGVXVnZmhYU2kwK3RXY0JmaDh2WlFiQThH?=
 =?utf-8?B?UG96czFiMlBlRmZpa21lQ3NBTGsvQ25xUWpJNmVOTy9la2ttK1A0V1RiM29i?=
 =?utf-8?B?WWFVQUFCRVVUQmRHVTMzOWUyNHpCV0VOc3dpSG9vZkVVMkN0WG5sU1I0cEJw?=
 =?utf-8?B?blZ4UWQvQ2oyVWdibGNqYjNDbWZydnRmcDNQUkx3TWwyOG1DQ1l2OGpOdWQr?=
 =?utf-8?B?WEVZQWNrNFVBTjRCR2t6VDgrOFF2N1pKVnoyWU9ucVN5dHZEU0xWRW1pNUlP?=
 =?utf-8?B?U3BwUDhaeUVjZ1dzeStCQysyejBHdEhkb3NLdFVRVUhRSzlaTmMvcmlxYm00?=
 =?utf-8?B?Zjl1WEJkQitBa3YyanU1czBRWmNHZ0JwS0NDQ2F1RzRUMnI1ODhsNUlxT3Rr?=
 =?utf-8?B?c0lSemVBZzg5VEVvb2xXSUJOWXg1MkZZS1JhU2hLcW5KUW4rN1JNODhKTCtZ?=
 =?utf-8?B?VFZOazNIVmcva2o5b21qVHcwRFJlNW1pblBIOHdmZTdrRmhtbS9CampBODdZ?=
 =?utf-8?B?ZWs0OHZTOGs3c3AzRmJqTk1mTUtiMVp5UU9tb2JVUzFDY1E1b1FSL2FvdUE1?=
 =?utf-8?B?YmtYQWdaSzZXdGhNZk1XUWZxa2lWZzYxcHVkdGxOT3VYZ1pxY25GRUxJQ0My?=
 =?utf-8?B?dkh0NlIwVzRNQ29aQ3ZsdzRwOU9BLzhubUxBMG9tdWF6SFZJZzRDSDZuOUlB?=
 =?utf-8?Q?1ADQkNBSWEx5g?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 05:16:18.3973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34d0e1c-e5f8-4f42-1d63-08dc6cc27ec4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147



On 04/05/2024 20:50, Simon Horman wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, May 03, 2024 at 07:31:03AM +0300, Shay Drory wrote:
>> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
>> and virtual functions are anchored on the PCI bus;  the irq information
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
>> 50  51  52  53  54  55  56  57  58
>> $ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
>> exclusive
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Shay Drory <shayd@nvidia.com>
> 
> ...
> 
>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> 
> ...
> 
>> +static int auxiliary_irq_create(int irq)
>> +{
>> +     refcount_t *ref;
>> +     int ret = 0;
>> +
>> +     mutex_lock(&irqs_lock);
>> +     ref = xa_load(&irqs, irq);
>> +     if (ref && refcount_inc_not_zero(ref))
>> +             goto out;
>> +
>> +     ref = kzalloc(sizeof(ref), GFP_KERNEL);
> 
> Hi Shay,
> 
> Should this be sizeof(*ref) ?

yes, will fix in v2

> 
> Flagged by Coccinelle.
> 
>> +     if (!ref) {
>> +             ret = -ENOMEM;
>> +             goto out;
>> +     }
>> +
>> +     refcount_set(ref, 1);
>> +     ret = xa_insert(&irqs, irq, ref, GFP_KERNEL);
>> +     if (ret)
>> +             kfree(ref);
>> +
>> +out:
>> +     mutex_unlock(&irqs_lock);
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
> 
> It would be nice to include a Return section to this kernel doc.
> 
> Flagged by ./scripts/kernel-doc -none -Wall

will add in v2

> 
>> + */
>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
> 
> ...

