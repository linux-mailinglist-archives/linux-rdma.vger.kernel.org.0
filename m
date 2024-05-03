Return-Path: <linux-rdma+bounces-2233-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EE98BA6EE
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 08:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B10D1F21DC9
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 06:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2C4139CFC;
	Fri,  3 May 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BTcEjwri"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1278712B89;
	Fri,  3 May 2024 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717137; cv=fail; b=dcKfyNZpUu39pT6OSDu4YRNaRESKQ+c1jLn1HmQNm6xhK++I2dyjcRtU+34PEwZs3Y+qs0IF60704IJKdZ7GTd0LPQe4zrj5QN+3U+2k+nKr3f6OHFDwtIchcHTnPrfPruMpAv+9SKg5Q8EeBRu7N4swTKD33vVIe2Y8nM6S1pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717137; c=relaxed/simple;
	bh=NOlRR6uUvzWoDcjK5PedkKHItxgCiQu7iagVCSYnkpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l4T/2FbUZEyExZlgJa7khTcvKUyLhfHKB0C/qBVR7SXf4LCXEZyCSxH05GlRzAgCUZB+N5VlTh+tkTULSiAv0PBqkuvb2IXwcvnKQnO8XwmWqfovuTGCoD3PLpY5QD3sP3ukjTDd3DEbqn7J+1LSqpntwStJyV1ftHgcruRELQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BTcEjwri; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxPQyer7fZGh5of/s1dQnsVEQfGTBNHEgvwO06eE2EbmuZqHs3B356/kjERnhJ0QkdZMZYgShie6H/xyTuTr36X8uhPXjK9yoQgSS5exMrUb8ywK2O/m1EIONpXtocrnXvqKrOQ5Td51uIanmudZC0EioKwKhpQTvnO56uZNiJtdGanIVDWeqY4hEnv3DDR1kcDQmj/KOmew5uL48lzCEW7MtsKajlfLtWSQsjgIe1k6p6hBTJZ7bKNNuWCBtX8WEpwZ7zKL8a3+gJeEdTQod+8lvTFDYwRu+nutD4Hc0hP+9j4k9LsL1Cf14Mf5T63VDhb0SjzGvisRMGwSPCgLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2LIASi1h1Aadcs3XGslYOCXXBQd15Pq9n8arrP3tyg=;
 b=I67Fr6uatuM6m/Q7YHYv9yPt19VZqih4yTw34KbRFaRhhXpRF1xhJZYTNF3oChdne62NR+J7itDGc22mulNZYhO0bmvhm1P2jFfvFQrEl1IVxluPDFTzdFRWYOQ5pyyYzeEJPprOpkbV+uBcFoTuLGKI3tn/V9umV7sQslhE8MSA/C4Ko2CmdWYw8+cDjW8DKf1NPtQDukz5nQ8gcr95LFXvfcxBqv/eLPSAJbVgPrOIuIR/KmKh4hUeBkhzlcJrQuLb1j8xyANa/cIv3H2LOPx8SJOATjGyAMbpNTxe9hTeB23RGoO132Klm8rMNSP0GxcFfbRwEmXhfZz452H19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2LIASi1h1Aadcs3XGslYOCXXBQd15Pq9n8arrP3tyg=;
 b=BTcEjwrizQeGxxRpKM3HDlMlxxXDdeX3VQsl3OPKqr8U6jMhOrEwxkdpZq5dV1sbXcplLj9Sjec5le5uh+4mBE62f5r2fmXWbWvMBYx87jW+UfhED/4T7HgqZXQI9t6M3K3SPrS2kGlGfLdOSQVxUXwtEtoUfzX1dgcFH+muJE+SHsY37zh8XrU/4/uqArqiIlSEa9qZef6nlByyhSTyyN8vjnc9y14pz7rFlk4JgCNLyuJNqQHoC/Sc5mHez5hv9yCwRm/w8PbbFm8owiPeslNHRF2GrvAejl5ZxO9duk6yt6TtDpGWBqy9BRJP6GXOexGBnuecDFS3E1fhjIr/nw==
Received: from SN7PR04CA0190.namprd04.prod.outlook.com (2603:10b6:806:126::15)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 06:18:52 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::25) by SN7PR04CA0190.outlook.office365.com
 (2603:10b6:806:126::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Fri, 3 May 2024 06:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 06:18:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 23:18:32 -0700
Received: from [172.27.49.78] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 23:18:27 -0700
Message-ID: <16183432-f46d-4f3e-af0e-524678445136@nvidia.com>
Date: Fri, 3 May 2024 09:18:26 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] driver core: auxiliary bus: show auxiliary device
 IRQs
To: Greg KH <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240503043104.381938-1-shayd@nvidia.com>
 <20240503043104.381938-2-shayd@nvidia.com>
 <2024050313-next-fried-4360@gregkh>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <2024050313-next-fried-4360@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0824e8-6f4e-4ef2-774c-08dc6b38e70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1AyUnZBV3RaZUF4MjNodER3VldmZG4rQXQrTy9TOWVwdmZmNTNxT0NGQTBV?=
 =?utf-8?B?T2ZXcG5zeTM3TnRMbU1PVzJYOWRRZmZYNU44REhiYXhyUzgvOGsyaHRYVW1P?=
 =?utf-8?B?K0UzenVEUGZaVGZZYVdkbDZFM3ZiVnJudnZBOVZPU05LZnVoeU9hZmdjcDl5?=
 =?utf-8?B?Y0JicGlHRGlNZWRVQS9LdzJFeXhQTXhJY0dZV29taDU0akNvVXh0OU1yUVVY?=
 =?utf-8?B?Ui9uVXJZSnI5cWUxS2E4cXRtSDJYUnBpdjkxNDFSMktOaU84ZGlCc2c1MWhy?=
 =?utf-8?B?QWFjM3JzRzhhT3U3bzV4VlRDVUFVOG5qSjhtN0dFbHl6Q3ptT1ptTXV2QXR6?=
 =?utf-8?B?OVE4TjRMd0luTGRQU2lXMzR0WmQ5WnFvdlgxRFY1c0dTV2xBaTlmUzU1Q0Fl?=
 =?utf-8?B?YTJIbVNoaFJWdTYydWdHT0QrVml3aUU3MlZKaUpmMENNZ0NRcVlIWCt1ZUNJ?=
 =?utf-8?B?bzBlbWFIWFEvWTByUVp1bXNiQ2hSTzVjOVJ3cW9nYm51ZmR1bHBBeXdpbnZ5?=
 =?utf-8?B?U0dtZFU2SVlCK0dsemhCNFhabGxpcFNPNURZSzc0WkR4NXVtNGVTV21ZSEFS?=
 =?utf-8?B?UnhCWThLUW9mY21uVjhaT3BWcXc4bkhNUWZha1FMalZUdkNjbEFKTEs4bitk?=
 =?utf-8?B?QnM3Tk1uaHdYVkxFN0VSeWtLZVhtZEsrbmREL2hRR0EvYVJLOXF2R3NobUN5?=
 =?utf-8?B?dlA2UU85YTRJVTF4SnoyZnR6R3J3Y2pLZVN0MXluc21JQXNURGZPOGhIR0xM?=
 =?utf-8?B?Q1loV09UeDZPRHZyZEFGaVh2QS9ENmsrUS82Z2tlSEI2cjg3dTBRVXRZc1lt?=
 =?utf-8?B?Z2JaTVJNRjdCV00zNGh4NDM2ZUJlYUVHTjNlNVhoYUxBNDhlaE9EY0F0N3VM?=
 =?utf-8?B?dVp2Ulg1b3FZRTBQZEt6T1VLRXVlK0pqaFkrN1BvdlFZeUdOYmloYUpHTWJ5?=
 =?utf-8?B?cTJncStLUnRNRVlON0dtT1ZKRndkekpNdmtHTGZxOGdTaHlHT0pYWExheDVT?=
 =?utf-8?B?V0FOY2FGbElPRTF2SGpKQXJERys3TTBYWlhiZmRITS9UUCt2aE9NR0gxQkNq?=
 =?utf-8?B?TnR3SVJlNzUzY2ZHaUlCdGdmcHFBelp1U3VXTU55TnhoZzl1TER4WTE5L1RD?=
 =?utf-8?B?clRraEhEakluaFgzTjh5NHVEUXIwNHNyNFUwZWY2dTZjZUpuL2JScVJpRFg0?=
 =?utf-8?B?RFh1SFMrOVVjQ3BNbkRUWFNyU2lOc2ZmMWVyZmt4dkh2czJPMjhUR1Jib0VO?=
 =?utf-8?B?cHZ4Z014YW05eFRId1B2ZzNNVjZNV2VRUVd0eHRYNnpySUpzdFN5NHMzb1Vl?=
 =?utf-8?B?ZHFBTVJOYjNFVzNxOTNtaHd4Q1BEaWZKd1RPYmdaVVJ1OFk1MFJhdEVGbDdq?=
 =?utf-8?B?VXg4WVZzVHQ3dUpTZXE5MlRVb2doUmxsUERQSXpIUnBIZGRwVFFMVmNqcEN1?=
 =?utf-8?B?RHAzYkNrYXhCTjVjdmQrZ2IrSHo3bVNrL2hTL0QvRFV0cVU2NDZsOGh5ZlJL?=
 =?utf-8?B?SG0vT0RTK2NxTFNmOTJrQk1iZU1mMXRxRDVwdjhSWUVzYTQrM09oazRnejlj?=
 =?utf-8?B?WDd0c1RVNTl0RWdwekRDNUlUUkRtSUMvOURYa1VVTUFhQ2Z6UTZGZ2xOVDg5?=
 =?utf-8?B?eUpWUGRscU1SelJFQkMyTVlWUVZTV005ek9xRUQyWW1TZHAwMHBlQkFHSFRE?=
 =?utf-8?B?bTI4cWxPVStRNmFGM1ZrMlF0aFNmY1VibnNxZXB5UzRuU01MR3d0NjRqRCsx?=
 =?utf-8?B?ZmUrZXdxUTdtYlFoYnRwUDJlbmlvSjRwZjhEWkZFSGgwNk1jd3BIbHBNVjc2?=
 =?utf-8?B?UFNDdGdsZVVNU3F6T0J0by96S0IwWnBQcm1rNGJvUGZERDlEcnF1eExDZVp5?=
 =?utf-8?Q?k8NBWYDoB54ya?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 06:18:51.7146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0824e8-6f4e-4ef2-774c-08dc6b38e70b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363



On 03/05/2024 8:10, Greg KH wrote:
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
> 
> Not all the world (i.e. not all auxbus users) are PCI devices, right?

Right. auxiliary users are PCI sfs and other devices.

> So what happens for non-PCI devices?

The sysfs extension is optional, i.e. only for PCI SFs the sysfs irq 
information is optionally exposed.
Rest of the other users just continue as is without sysfs functionality.


> 
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Shay Drory <shayd@nvidia.com>
>> ---
>>   Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
>>   drivers/base/auxiliary.c                      | 170 +++++++++++++++++-
>>   include/linux/auxiliary_bus.h                 |  15 +-
>>   3 files changed, 196 insertions(+), 3 deletions(-)
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
>> +
>> +What:                /sys/bus/auxiliary/devices/.../irqs/<N>
>> +Date:                April, 2024
>> +Contact:     Shay Drory <shayd@nvidia.com>
>> +Description:
>> +             auxiliary devices can share IRQs. This attribute indicates if
>> +             the irq is shared with other SFs or exclusively used by the SF.
>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> index d3a2c40c2f12..5c0efa2081b8 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -158,6 +158,167 @@
>>    *   };
>>    */
>>
>> +#ifdef CONFIG_SYSFS
>> +/* Xarray of irqs to determine if irq is exclusive or shared. */
>> +static DEFINE_XARRAY(irqs);
>> +/* Protects insertions into the irtqs xarray. */
>> +static DEFINE_MUTEX(irqs_lock);
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
>> +/**
>> + * Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
>> + * shared or exclusive.
>> + */
>> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
>> +                                    struct device_attribute *attr, char *buf)
>> +{
>> +     struct auxiliary_irq_info *info =
>> +             container_of(attr, struct auxiliary_irq_info, sysfs_attr);
>> +
>> +     if (refcount_read(xa_load(&irqs, info->irq)) > 1)
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
>> +     refcount_t *ref;
>> +     int ret = 0;
>> +
>> +     mutex_lock(&irqs_lock);
>> +     ref = xa_load(&irqs, irq);
>> +     if (ref && refcount_inc_not_zero(ref))
>> +             goto out;
>> +
>> +     ref = kzalloc(sizeof(ref), GFP_KERNEL);
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
>> +info_err:
>> +     auxiliary_irq_destroy(irq);
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL(auxiliary_device_sysfs_irq_add);
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
>> +     if (WARN_ON(!info))
>> +             return;
>> +
>> +     sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
>> +                                  auxiliary_irqs_group.name);
>> +     xa_erase(&auxdev->irqs, irq);
>> +     kfree(info->sysfs_attr.attr.name);
>> +     kfree(info);
>> +     auxiliary_irq_destroy(irq);
>> +}
>> +EXPORT_SYMBOL(auxiliary_device_sysfs_irq_remove);
> 
> Any reason this isn't EXPORT_SYMBOL_GPL() like the rest of this file?
> Same for the other export.

missed that, will fix in v2

> 
>> +#else /* CONFIG_SYSFS */
>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq) {return 0; }
>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
>> +#endif
> 
> Shouldn't the #ifdef stuff be in a .h file?  Why .c?

missed that, will fix in v2

> 
> And again, why do you think that all aux devices have irqs?

like I mention above, this is optional.
I missed to explain this in the cover letter, I will add it to v2.

> 
> thanks,
> 
> greg k-h

