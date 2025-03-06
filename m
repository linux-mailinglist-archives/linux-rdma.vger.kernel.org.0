Return-Path: <linux-rdma+bounces-8394-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1053DA5402F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 02:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4308E3AA0D9
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 01:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7118B484;
	Thu,  6 Mar 2025 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xmpNkY/y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B070126C10;
	Thu,  6 Mar 2025 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226156; cv=fail; b=uxK8aJ9Kll7OHSflGOCkFggm/c7AoztVzRYo5AwuRr7f8D1p9ykwmgrKEx0dvdVMSFhZedNkrK1q5arBR9tCiFKD+jYCNsP+O24is9SKC847DLt275xGefSoxpDMHjx0LrAcAdwUacVYrrG7SANIjPNAiEx6FDLhhPRYtbUeJHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226156; c=relaxed/simple;
	bh=QkqIehiqON33IHwgE76SepegxSGiEe9Glonyuk4zSac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ODgH63vWXYj2eYI2i57nhwJ1c7r4KqJheg3jmcPtL2b665ogHiAlH828jSNiXITOTUytW6L/fqUz/g95QJDNDj3ffWMyg3yqDzxoTWau3OvEOZTp2WTuRUPTBogs9JVzfMlEr6ZFuWh809GN1ZI9G/0vzmucU1kw5/UKc0hcTUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xmpNkY/y; arc=fail smtp.client-ip=40.107.100.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cm298UbMQbH/SBuQOQxyamoY4zyjxICevc8A/AmSyTVKeVyfps3NJYAREmsa42/g5WnHQRA9bLCwmbMASLwltGQuRTRYq2XLNeNFplRMFr7dJ+kFjKmGOIwrGjeGP3oAkPYZz4OExTifpteRJPvWUSaJy34N6MPXDF6WMo+4CwMPrXijAtO0mS8hYwc68iE8NF0n5WaRq0g0w/D9yAUyK8rz2IKTTwh6kbMjnyHlI7LIw8oGoj8RjUl2FRC0G5NmZ3ulD9uWSpmQBjw40+9xH/7+s3XhkxmBXXIgLPaXHgbFHjqYgdOtfh6eEeqeCug6dHBXGHnizZxaNuhgIt+8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mam6j2+mGZbTX0/HGdjAsQQA0KHMhaTiIk8bdIyGyRE=;
 b=XW57AR1tXpylpPy+kQ9dWOgoBvPhyG+PvQvLRfpZK3QOkz1mrIr/UIcd94b9yssT+V+Mv2cWsuIShu4yzi4MtaOoN/X/aOs/Nb1aBnJAnKYzQNUdBhyLsl5P8+cfRwx3cB2Dj9IMHFaP/EPXbM5JIS1Tv/4LkXMEE1Bd2hM0Jdkoly0d5bE3S4sbHQh8JTvg4Yy+ql29YyF96qmasDvZNh3yPSu378YdCq9fn7b3jlxtjE+uGvQ3Q6HgJ9SF/h4Egk8HnqPYCByej0gR5QMtwQ5yAAdNVxmLsUoI89A2vjhy3xTQaMbgKHu+A694taF7Ykp/9ilwRMCAfNO4wcDJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mam6j2+mGZbTX0/HGdjAsQQA0KHMhaTiIk8bdIyGyRE=;
 b=xmpNkY/y28k7i1LIOrrAdfWeQOsOv6a/O4VCpAFWEY1tLNF42zQcu/BXPKdOS6mdKXCVVybbD0QgTwa9NOl+p9teFbNzfycQiswzoP4DqiDY/i06XcaVKiMQfqwqk68z5b+4aqA5aT0IicCO4hBsphNh83Oe2tipj/BqSXdHPaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 01:55:48 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 01:55:48 +0000
Message-ID: <a7050314-bcb3-4ec1-98f6-334019222235@amd.com>
Date: Wed, 5 Mar 2025 17:55:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] pds_fwctl: add rpc and query support
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gregkh@linuxfoundation.org,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com,
 brett.creeley@amd.com
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-6-shannon.nelson@amd.com>
 <20250304170808.0000451d@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250304170808.0000451d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:510:324::17) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d40903-d616-43c7-f6f0-08dd5c520430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlB1bEhlM3V0aTBXb3hZb0MzZHB2a3M2SitxV2pjMjJ6M211QXVWM050MWJj?=
 =?utf-8?B?anBqaTY5UGdrMU9RaFVlVGsrTlVSTmY5UERMNWtiU3c1dmh2TTVsd3BnN1Fn?=
 =?utf-8?B?RG1BVnhSaUdkT3Nrdk9rdjBzYWZHTUVlVlFHUVJPUjdHaDdkYlc0V045ZjZ5?=
 =?utf-8?B?UHdySmg0WmU0TUVlaHgvcVhndlFxZktEOUpna09iUGltalppVWROUndWeW5V?=
 =?utf-8?B?UGFKT0FUNUowZ2RXZWJKVzFKYjBmbmxyQklGTTR5L24ycUp4V1BNajBRZDBZ?=
 =?utf-8?B?YWMvMmVWVG42UVdmNmNFZEtCb0xGV0RqL1M5azg4YjVaLzM5ZjBiWVNFMWZW?=
 =?utf-8?B?bng5cW55NjR6RDVEWTh5dU5iVUFIYUlZNTB4NG5IcEhtdHpxaCs4TThpRlVU?=
 =?utf-8?B?SGxoT21abzY3TmJUMURtL2lKOEJ4V3lWVzJ4SzZ5ZmJSOEFEaUZXMS9qd3cx?=
 =?utf-8?B?SWw4aFlkTkhUT1dyQTNWcXpQTGdCaEFCSkVTUnFsY00zV0dPYjlEbnR0R0pB?=
 =?utf-8?B?eFhWc1c1Z1pDTlV5cmZWQStXc3RNWjBSelFDb1NWYnZnaGtiSDJkS21SWVZ1?=
 =?utf-8?B?VmllRGV2M0FabGlXL1RBZTRRZ0hLV2V5N1NtamdaMTJacVM4Q2ZTRDIwL1By?=
 =?utf-8?B?Q2ZjUWRjejhVcUpVVFgwNlRDWWJTNzVRZmVzeXNPUlBoMnEvTnZGeWl6aVl3?=
 =?utf-8?B?b0Rjbkh0Y2dkQU85MGdSeEZZZjlEbWRNVGxaZFdaR05JbVNkZGdGQ0xiKzY1?=
 =?utf-8?B?RVVLTjdMNHZCY3l2Vm9RM052bzhZKzZIUGdwZUh1K0RxdGUxaENFcENZY3RO?=
 =?utf-8?B?cUp1OHkrVHZSMWswT3RlbjdWRE1Uc1Q0bjJCUEhtYlRjUDJ4RFVoYkVpSHlQ?=
 =?utf-8?B?VjladUd2YWlpdzJ1VlNVR3YrSDI1cDRsdlFveWlUYXpxK3U0MnR3TzFLNThp?=
 =?utf-8?B?bnVsdEJWTzI2bHFIY3A1OFBDd0dLd0w0aXI4SHhqQnR1b2dyQ3FaVmgyRU9R?=
 =?utf-8?B?QkN5dXU2MjRGYlRCaEtFYnovQk5KajJWZWxmY2tLbXl3L2ZncnMyWVJXTUVX?=
 =?utf-8?B?QlhQUm5lWi9icnlwemJNek9jcS9WVkpDc3pzRFRqb3J3V3ZnejEvYThkaE8x?=
 =?utf-8?B?VUFRanh2dk43TFhDdkxBUTVIN3JKUkNNMkhadUxVK1FhQXYwWjhXemsrWVFD?=
 =?utf-8?B?LzB5eWZnU0M4WW95NjBCTERLcVZVQUZXdFBpWlFRdVNBV3J6eHpPS3hSNVpS?=
 =?utf-8?B?U2I2dDJmQStLUUpvZHowTFh6eTZkQzNieStpY2ZQVk5FaWpaMUZ0RUJKWGZZ?=
 =?utf-8?B?VWNmU285Tm02ZkZhUS9OdFJDbUpsOUJEb2JzWGRYODN4YTZ5a05qZzhKcW52?=
 =?utf-8?B?Sy9Wa2QrdkZlRXNRa0F3RWxuV2k4akFYeWR5TUtHNXd4WnpuOU9pNEpQOHJy?=
 =?utf-8?B?TmRTc1ljczhiMS81YThYeVo2bUh2SEF5RmpzV0hjS3Bkbll0TU9OZTcxMEpX?=
 =?utf-8?B?Vm9CT2NMa1EzOXdYN2MwSjdVd0REeTN1bHlKQlgrQVhDOGdTYzdud0NsMEVp?=
 =?utf-8?B?b0M3S05nc2ZWdzE2Y0hHMUVvNy93ZEpKYmV5My9YWE5DVHdDU2lSR2t4YUxt?=
 =?utf-8?B?ZnV6ckFBYitQU1dwK3p5aFUwc092YzNtNjFwTU9RVmgvZlE1T0VkZG5ERVRs?=
 =?utf-8?B?WHM2d3FjYVZPaUxtUHBmRS9nNnMzTXJZRHl4ZDJRQyt1T25xSzVITEZuRk55?=
 =?utf-8?B?LzlHVjBCZC8rYUZOU0lQZ1M4Y2lBUHR6ZU5FS3A4a2VSbElTQ05xU1dTbitz?=
 =?utf-8?B?UGtRdWx4ejlraEx1L0Njdy9NWWxmU2YvZlRtWUZ6WW0xUDB6Qk45UTFUTU1h?=
 =?utf-8?Q?+ZjMO7WFaPkD0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHVyUlY1eGs2SDU1L1FSenhvZEhhYnpLMHgvQUV1M0h6TkZXQlMvZE9Kdmd6?=
 =?utf-8?B?UEtlTngzdW1RUTVVTzhIWElsNmtySXo4OU5SSWNuVUUwV01sZVFSMjllQzhh?=
 =?utf-8?B?U3ZYMXVVUzRsSzFldUdwT3ZSRjF2Z3hpQmJLei9PdDVGZ2IvdEhHOGtHQVpT?=
 =?utf-8?B?Z3VVTFArcnJzeDJFSHg5bWNwb09ScmJqSEtJNFdUc2g0QUhWdFQrQldLS0Zx?=
 =?utf-8?B?WDFlQktTMVdQeFpCODAyVG1uNUtIaTRMTTJiZ2VVWng1L0NlaE5XMHhBOFhk?=
 =?utf-8?B?MzJVdVMrRnRHSm90bUdqa0oyYmFtbGpsQW5EN0Z3d3VyclUxWTJzdDNkTGJt?=
 =?utf-8?B?cExxaFpLOUVuYWtwcVBIVk5PbTNod2YydmVCM3NlSHVOMjNtQXhIMkd4TFIy?=
 =?utf-8?B?Q09IWVIzdks5V1Y4UUtqU1k0UGhXQ0F6TEZJam1qMFJDTU1mRFliTkU0dzdr?=
 =?utf-8?B?ejVUYXlkQXo3YmNIUzVsNzlKUlg5cGk3NXVJZWpjN0lSVHB1Tk1zOHprd0Nt?=
 =?utf-8?B?YnQyQmxIbE9oRVlmT1Y5a1NrRU1WSzhVVTNJT2pBVkxaUWdQRyt0VGJ1VTNn?=
 =?utf-8?B?L084dlI2WFB3NEJVdTNobHY4eG9mMlNubnNJTzhVTjNmYWlXeGNOdjRHWTlG?=
 =?utf-8?B?Zm5LVW5TRjdudWlLTExxaHlzWFlFcXJHSDgzU04xdFFCQzc1YXJUZlNIazly?=
 =?utf-8?B?ZzZLaFNVS2VJSE5ValY1UC91b3prMUJ4VWxDU3Jyb2FOMkJ2Z3ljL2Q0OG9W?=
 =?utf-8?B?V2pURXpaUG1aL0hXem1XL1UwUG5sTXJZMWJlNTJkTVlVUkdaTHFOb1JpVnlS?=
 =?utf-8?B?YzYrNE5jamxwZXJYMVAweHhIRlpBanVMQkdseTNxdjh1MmVMRG9LNVNGNnRG?=
 =?utf-8?B?YWlqSkJmdjNqVCttL3JLcEFXb2x4bk5ycFFtYmt2bHlNaitRdld0cEppWFp0?=
 =?utf-8?B?ZzhsN2NkT1lNNko0S2ovY3puMVNSK2JvWWZRMHhzRTh1cGxMcjlReEdhNElt?=
 =?utf-8?B?eGlmaVZ6STdxZmprTi9xOWJoSHdES3VUTE42QVhqeTlSOUdxWDVJVzcxRWtS?=
 =?utf-8?B?djJmeVlmYnl3bnBqN1oxNHpsOXFQaUpJb2FrV0FzSEJEUDVnWm9VWGVUaUM3?=
 =?utf-8?B?dEFJVERnL0hpMVA5cS8zTmVuc2ROcy9wVWRkMGFjTXZKSmNOZlVoVDJRZ3JM?=
 =?utf-8?B?YlRyUDFxUDNobVdIQms3MkdJdFhKZ3RvcWt5NDNBUStIM3lZY2l2aXpORm02?=
 =?utf-8?B?a05jTFFnNHUzam1SU0NHdFp2YnNhcW92N3lvVG9TT0hUVHJmUVl5WW9EejFK?=
 =?utf-8?B?UWFiWDdKVW9QZWlhVEo4YXRTNjdBYUV6V0xkTFU3SVE1K2xOUnV0aFlhYVgw?=
 =?utf-8?B?QjA3a1RVWUtYZ215OVRPd2NYYzBTSi9hMGE0MXhMbW9hcXVmbVUxSlltdkFk?=
 =?utf-8?B?M1QrakYzNlkxeEdEWnozVkpzR3RzeFV5ai9BdGxic013VHlIQnhhMnprTDBQ?=
 =?utf-8?B?enVMUVMwb05VcWR0enZ6c3lTamdpL1VJZ0NrT3NCYk1XVFhGVncrV1VsUE0y?=
 =?utf-8?B?U1lnZ2g0cmRqRzFGcU9PR1NkbzN2TzFSK29laWQ3cFFlYUpZMFcyMFM3NENW?=
 =?utf-8?B?MEJ3VUpGZWRKQkF2MFRodXhQajloQUJyaHVOS1BYTmJZVGxRTWsxMzM0SVg5?=
 =?utf-8?B?dXNYYWxYQkFRNHcwem5BZWtJTHdtVWpNekQ3d3pDTUJnNHVRRGFmaHk4anNB?=
 =?utf-8?B?UU82ekVNSDBWNzhuamt4b0JKNERKS1F1NTQrYVhncEdSVW0wNWNoL1VYajhP?=
 =?utf-8?B?YTJpNk0vTGFhMDJuRzNCbGtuM1NoY2dHNGxTYlJCSUxibEgvaVVDbm1ZK2hH?=
 =?utf-8?B?cFZwSjBVdU91NmZ3R1NEVWpmWDgrYzBoTmpxODhZRWh5ZnhWUC8vazg1U3Uw?=
 =?utf-8?B?WHdVMWlWQUs5by82SFNRTlppWElYL0l4MjZTSE1TV1pJOVNULy9PcGEzZ0Zr?=
 =?utf-8?B?eGRYVm5mdFMwOEFVbkhmU0RhUHpYZStqS3U5TUFuV3V6NWZ4ZnpnWENmS3I5?=
 =?utf-8?B?cUx5bHhYY0I4a0V0eW90ZUdxUmdqT2pzM1hlZG91NHlBUzVLRjljakwwQnVL?=
 =?utf-8?Q?hkNVL4KUdcPgbzWuXyf/CVfw4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d40903-d616-43c7-f6f0-08dd5c520430
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 01:55:48.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+4HMr+GiQLwrMnjBr0B9VouQB6gh/hpK5SiMb1hkWOIy1aeqzFWwORSNFJDUQUQhzQvd/I3Cbxg6HYYjJkLwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783

On 3/4/2025 1:08 AM, Jonathan Cameron wrote:
> On Fri, 28 Feb 2025 17:35:53 -0800
> Shannon Nelson <shannon.nelson@amd.com> wrote:
> 
>> From: Brett Creeley <brett.creeley@amd.com>
>>
>> The pds_fwctl driver doesn't know what RPC operations are available
>> in the firmware, so also doesn't know what scope they might have.  The
>> userland utility supplies the firmware "endpoint" and "operation" id values
>> and this driver queries the firmware for endpoints and their available
>> operations.  The operation descriptions include the scope information
>> which the driver uses for scope testing.
>>
>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Hi
> 
> A few minor suggestions inline,
> 
> Jonathan
> 
> 
> 
> 
>> +static int pdsfc_validate_rpc(struct pdsfc_dev *pdsfc,
>> +                           struct fwctl_rpc_pds *rpc,
>> +                           enum fwctl_rpc_scope scope)
>> +{
>> +     struct pds_fwctl_query_data_operation *op_entry;
>> +     struct pdsfc_rpc_endpoint_info *ep_info = NULL;
>> +     struct device *dev = &pdsfc->fwctl.dev;
>> +     int i;
>> +
>> +     /* validate rpc in_len & out_len based
>> +      * on ident.max_req_sz & max_resp_sz
>> +      */
>> +     if (rpc->in.len > pdsfc->ident.max_req_sz) {
>> +             dev_err(dev, "Invalid request size %u, max %u\n",
>> +                     rpc->in.len, pdsfc->ident.max_req_sz);
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (rpc->out.len > pdsfc->ident.max_resp_sz) {
>> +             dev_err(dev, "Invalid response size %u, max %u\n",
>> +                     rpc->out.len, pdsfc->ident.max_resp_sz);
>> +             return -EINVAL;
>> +     }
>> +
>> +     for (i = 0; i < pdsfc->endpoints->num_entries; i++) {
>> +             if (pdsfc->endpoint_info[i].endpoint == rpc->in.ep) {
>> +                     ep_info = &pdsfc->endpoint_info[i];
>> +                     break;
>> +             }
>> +     }
>> +     if (!ep_info) {
>> +             dev_err(dev, "Invalid endpoint %d\n", rpc->in.ep);
>> +             return -EINVAL;
>> +     }
>> +
>> +     /* query and cache this endpoint's operations */
>> +     mutex_lock(&ep_info->lock);
>> +     if (!ep_info->operations) {
>> +             ep_info->operations = pdsfc_get_operations(pdsfc,
>> +                                                        &ep_info->operations_pa,
>> +                                                        rpc->in.ep);
>> +             if (!ep_info->operations) {
>> +                     mutex_unlock(&ep_info->lock);
>> +                     dev_err(dev, "Failed to allocate operations list\n");
>> +                     return -ENOMEM;
>> +             }
>> +     }
>> +     mutex_unlock(&ep_info->lock);
>> +
>> +     /* reject unsupported and/or out of scope commands */
>> +     op_entry = (struct pds_fwctl_query_data_operation *)ep_info->operations->entries;
>> +     for (i = 0; i < ep_info->operations->num_entries; i++) {
>> +             if (PDS_FWCTL_RPC_OPCODE_CMP(rpc->in.op, op_entry[i].id)) {
>> +                     if (scope < op_entry[i].scope)
>> +                             return -EPERM;
>> +                     return 0;
>> +             }
>> +     }
>> +
>> +     dev_err(dev, "Invalid operation %d for endpoint %d\n", rpc->in.op, rpc->in.ep);
> 
> Perhaps a little noisy as I think userspace can trigger this easily.  dev_dbg()
> might be better.  -EINVAL should be all userspace needs under most circumstances.

Sure

> 
>> +
>> +     return -EINVAL;
>> +}
>> +
>>   static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>>                          void *in, size_t in_len, size_t *out_len)
>>   {
>> -     return NULL;
>> +     struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
>> +     struct fwctl_rpc_pds *rpc = (struct fwctl_rpc_pds *)in;
> 
> in is a void * and the C spec always allows implicit conversion for those
> so no cast here.

Will fix

> 
>> +     struct device *dev = &uctx->fwctl->dev;
>> +     union pds_core_adminq_comp comp = {0};
>> +     dma_addr_t out_payload_dma_addr = 0;
>> +     dma_addr_t in_payload_dma_addr = 0;
>> +     union pds_core_adminq_cmd cmd;
>> +     void *out_payload = NULL;
>> +     void *in_payload = NULL;
>> +     void *out = NULL;
>> +     int err;
>> +
>> +     err = pdsfc_validate_rpc(pdsfc, rpc, scope);
>> +     if (err) {
>> +             dev_err(dev, "Invalid RPC request\n");
>> +             return ERR_PTR(err);
>> +     }
>> +
>> +     if (rpc->in.len > 0) {
>> +             in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
>> +             if (!in_payload) {
>> +                     dev_err(dev, "Failed to allocate in_payload\n");
>> +                     out = ERR_PTR(-ENOMEM);
>> +                     goto done;
>> +             }
>> +
>> +             if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
>> +                                rpc->in.len)) {
>> +                     dev_err(dev, "Failed to copy in_payload from user\n");
>> +                     out = ERR_PTR(-EFAULT);
>> +                     goto done;
>> +             }
>> +
>> +             in_payload_dma_addr = dma_map_single(dev->parent, in_payload,
>> +                                                  rpc->in.len, DMA_TO_DEVICE);
>> +             err = dma_mapping_error(dev->parent, in_payload_dma_addr);
>> +             if (err) {
>> +                     dev_err(dev, "Failed to map in_payload\n");
>> +                     in_payload_dma_addr = 0;
> 
> See below for comment on ordering and why ideally this zero setting should
> not be needed in error path.  Really small point though!
> 
>> +                     out = ERR_PTR(err);
>> +                     goto done;
>> +             }
>> +     }
>> +
>> +     if (rpc->out.len > 0) {
>> +             out_payload = kzalloc(rpc->out.len, GFP_KERNEL);
>> +             if (!out_payload) {
>> +                     dev_err(dev, "Failed to allocate out_payload\n");
>> +                     out = ERR_PTR(-ENOMEM);
>> +                     goto done;
>> +             }
>> +
>> +             out_payload_dma_addr = dma_map_single(dev->parent, out_payload,
>> +                                                   rpc->out.len, DMA_FROM_DEVICE);
>> +             err = dma_mapping_error(dev->parent, out_payload_dma_addr);
>> +             if (err) {
>> +                     dev_err(dev, "Failed to map out_payload\n");
>> +                     out_payload_dma_addr = 0;
> 
> As above. Slight ordering tweaks and more labels would avoid need
> to zero this on error as we would never use it again.
> 
>> +                     out = ERR_PTR(err);
>> +                     goto done;
>> +             }
>> +     }
>> +
>> +     cmd = (union pds_core_adminq_cmd) {
>> +             .fwctl_rpc = {
>> +                     .opcode = PDS_FWCTL_CMD_RPC,
>> +                     .flags = PDS_FWCTL_RPC_IND_REQ | PDS_FWCTL_RPC_IND_RESP,
>> +                     .ep = cpu_to_le32(rpc->in.ep),
>> +                     .op = cpu_to_le32(rpc->in.op),
>> +                     .req_pa = cpu_to_le64(in_payload_dma_addr),
>> +                     .req_sz = cpu_to_le32(rpc->in.len),
>> +                     .resp_pa = cpu_to_le64(out_payload_dma_addr),
>> +                     .resp_sz = cpu_to_le32(rpc->out.len),
>> +             }
>> +     };
>> +
>> +     err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
>> +     if (err) {
>> +             dev_err(dev, "%s: ep %d op %x req_pa %llx req_sz %d req_sg %d resp_pa %llx resp_sz %d resp_sg %d err %d\n",
>> +                     __func__, rpc->in.ep, rpc->in.op,
>> +                     cmd.fwctl_rpc.req_pa, cmd.fwctl_rpc.req_sz, cmd.fwctl_rpc.req_sg_elems,
>> +                     cmd.fwctl_rpc.resp_pa, cmd.fwctl_rpc.resp_sz, cmd.fwctl_rpc.resp_sg_elems,
>> +                     err);
>> +             out = ERR_PTR(err);
>> +             goto done;
>> +     }
>> +
>> +     dynamic_hex_dump("out ", DUMP_PREFIX_OFFSET, 16, 1, out_payload, rpc->out.len, true);
>> +
>> +     if (copy_to_user(u64_to_user_ptr(rpc->out.payload), out_payload, rpc->out.len)) {
>> +             dev_err(dev, "Failed to copy out_payload to user\n");
>> +             out = ERR_PTR(-EFAULT);
>> +             goto done;
>> +     }
>> +
>> +     rpc->out.retval = le32_to_cpu(comp.fwctl_rpc.err);
>> +     *out_len = in_len;
>> +     out = in;
>> +
>> +done:
>> +     if (in_payload_dma_addr)
>> +             dma_unmap_single(dev->parent, in_payload_dma_addr,
>> +                              rpc->in.len, DMA_TO_DEVICE);
>> +
>> +     if (out_payload_dma_addr)
> 
> Can we do these in reverse order of the setup path?
> It obviously makes limited difference in practice.
> With them in strict reverse order you could avoid need to
> zero out_payload_dma_addr and similar in error paths by
> using multiple labels.

Yeah, I'll reorder this with a couple more labels.

> 
>> +             dma_unmap_single(dev->parent, out_payload_dma_addr,
>> +                              rpc->out.len, DMA_FROM_DEVICE);
>> +
>> +     kfree(in_payload);
>> +     kfree(out_payload);
>> +
>> +     return out;
> 
> At least some cases are simplified if you do
>          if (err)
>                  return ERR_PTR(err);
> 
>          return in;
> 
> and handle all errors via err integer until here.
>>   }
> 
>>   static const struct auxiliary_device_id pdsfc_id_table[] = {
>> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
>> index ae6886ebc841..03bca2d27de0 100644
>> --- a/include/linux/pds/pds_adminq.h
>> +++ b/include/linux/pds/pds_adminq.h
> 
>> +/**
>> + * struct pds_fwctl_query_data - query data structure
>> + * @version:     Version of the query data structure
>> + * @rsvd:        Word boundary padding
>> + * @num_entries: Number of entries in the union
>> + * @entries:     Array of query data entries, depending on the entity type.
>> + */
>> +struct pds_fwctl_query_data {
>> +     u8      version;
>> +     u8      rsvd[3];
>> +     __le32  num_entries;
>> +     uint8_t entries[];
> 
> __counted_by_le() probably a nice to have here.

Yes.


> 
> 
>> +} __packed;
> 
>> +/**
>> + * struct pds_sg_elem - Transmit scatter-gather (SG) descriptor element
>> + * @addr:    DMA address of SG element data buffer
>> + * @len:     Length of SG element data buffer, in bytes
>> + * @rsvd:    Word boundary padding
>> + */
>> +struct pds_sg_elem {
>> +     __le64 addr;
>> +     __le32 len;
>> +     __le16 rsvd[2];
> 
> __le32 rsvd; ?  Or stick to u8 only.

I'll use u8

> 
> 
>> +} __packed;
>> +
>> +/**
>> + * struct pds_fwctl_rpc_comp - Completion of a firmware control RPC.
>> + * @status:     Status of the command
>> + * @rsvd:       Word boundary padding
>> + * @comp_index: Completion index of the command
>> + * @err:        Error code, if any, from the RPC.
> 
> Odd mix of full stop and not.  Make it more consistent.

Sure


> 
>> + * @resp_sz:    Size of the response.
>> + * @rsvd2:      Word boundary padding
> 
> words changing size in one structure?  Just stick to "Reserved" for
> the docs. Never any reason to explicitly talk about 'why' things
> are reserved.

Sure

Thanks,
sln

> 
>> + * @color:      Color bit indicating the state of the completion.
>> + */
>> +struct pds_fwctl_rpc_comp {
>> +     u8     status;
>> +     u8     rsvd;
>> +     __le16 comp_index;
>> +     __le32 err;
>> +     __le32 resp_sz;
>> +     u8     rsvd2[3];
>> +     u8     color;
>> +} __packed;
>> +
>>   union pds_core_adminq_cmd {
>>        u8     opcode;
>>        u8     bytes[64];
>> @@ -1291,6 +1474,8 @@ union pds_core_adminq_cmd {
>>
>>        struct pds_fwctl_cmd              fwctl;
>>        struct pds_fwctl_ident_cmd        fwctl_ident;
>> +     struct pds_fwctl_rpc_cmd          fwctl_rpc;
>> +     struct pds_fwctl_query_cmd        fwctl_query;
>>   };
>>
>>   union pds_core_adminq_comp {
>> @@ -1320,6 +1505,8 @@ union pds_core_adminq_comp {
>>        struct pds_lm_dirty_status_comp   lm_dirty_status;
>>
>>        struct pds_fwctl_comp             fwctl;
>> +     struct pds_fwctl_rpc_comp         fwctl_rpc;
>> +     struct pds_fwctl_query_comp       fwctl_query;
>>   };
>>
>>   #ifndef __CHECKER__
>> diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
>> index a01b032cbdb1..da6cd2d1c6fa 100644
>> --- a/include/uapi/fwctl/pds.h
>> +++ b/include/uapi/fwctl/pds.h
>> @@ -24,4 +24,20 @@ enum pds_fwctl_capabilities {
>>        PDS_FWCTL_QUERY_CAP = 0,
>>        PDS_FWCTL_SEND_CAP,
>>   };
>> +
>> +struct fwctl_rpc_pds {
>> +     struct {
>> +             __u32 op;
>> +             __u32 ep;
>> +             __u32 rsvd;
>> +             __u32 len;
>> +             __u64 payload;
>> +     } in;
>> +     struct {
>> +             __u32 retval;
>> +             __u32 rsvd[2];
>> +             __u32 len;
>> +             __u64 payload;
>> +     } out;
>> +};
>>   #endif /* _UAPI_FWCTL_PDS_H_ */
> 


