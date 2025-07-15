Return-Path: <linux-rdma+bounces-12183-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6054BB054E6
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 10:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866DC3A71A3
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1EE274FD7;
	Tue, 15 Jul 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qjNd4Mzu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231C2C3274
	for <linux-rdma@vger.kernel.org>; Tue, 15 Jul 2025 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568217; cv=fail; b=qoCjTUTms7UlZg3hQ3i7DL1ZdczhBuvcYSklabSrVACN9+iwfmDgbRoa7Eby3HSD5jiZNNQivP/7D/ReCYnF/p7iifAhNAueD/xNxP0s6nNT9qcMPhLB7vIykJPqFfxIwzrDp445EGC5X4N7u+QaxU6D+FU6iatyIYWfEmSG1gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568217; c=relaxed/simple;
	bh=CDDambANfz2cnOKSOx1fZNhzeUqlwj5KDNWwH1ygNDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JsJIsDxKOAp7YDiMgjt0sf+rXEWqZrLEkQyO4cBag7RdtqrqOlm147iF4aOrqBbq/i2mmkkjPFtQpvri5/Xz+3h7YMpdzaJ3SuvMZ9kXmR59AKTmP6nxKeS9qGrfdMKz7EnL4B756WAN4NamHsc1T8huxIWkWxxhaxMEI/r8grk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qjNd4Mzu; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z32wTjosChJiNgt9TAQx4XDKvFWp9lSvG1FsZFkdS5qV7BfntfyeOdmxkJpt2ycIfAnbfDX0ZoJ6IkNrzwgf6AlKtWAtMEQ1psHtrXV/Q+tB8QJPPo2JCUmMD8/+Vvep32Jhpao5R67Y2wor5NFsfaaTwZzTZjnUKBPuAIAxa4/Eb7njCyEibRwdiw9cyT+foKyWhYu/XZ0j0HEVbqKSf4EqucAZM1P20MFZa89FXf9DVaiMM0lsTIGoiNbY96/SGW51gv6At3Af4KdMUTELtqqfkWF7VH2NuD3plKw/i1HvmEEjrh6C14O/5O1l4RNN2f5HfTRfiMAXEW/ZIOyxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ByOhqzSBF9vmKQvaf2RSUg1O4ndtdUfKC2QeujlUCU=;
 b=UozlBGvmBa0iEwsFx29fvVSiiBWi8Ya79lFHOxiH6v74zvC3EhIkzvm8XM2Ox7L7KzConvaKPNRySziDKtHl54SMVdYmZ8VlC+ANLRCW1uFVTNL22+4BGYr11yAa9KKrBAusIXZbbZUBi9jRx5iu5WJ+2YaWIevynOzPZAaac/bLJ7gQ/Pez7+Mvn3FiR2N/hbIeLUff+u+OZebWAMPiJp5VWLmfDBRmzKn00uDLMfetTCDeCTQB3URnTduPTWK4iGd5U0BAU2UfE6Iq+/WN3ZMCjvQbICSN6DlRC7o4lE4U0tPamvkLPzMnPiT9sLcP7eZ5pho7s+WBI6W2N1ayHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ByOhqzSBF9vmKQvaf2RSUg1O4ndtdUfKC2QeujlUCU=;
 b=qjNd4MzuzZlkl6TEtMZPpDqp2Pl7G2pzQGDIbG24fSQo2bIpLR3fI2hetEerrOd0w0Zk4yrcDEzEO+a8rwYiUJ2Y83gUwDC9NlGJKiPdEjZmNbpmdANC0/sFL7dNgJpDUf+5Qtc2k2pCzgThASFoynYGwM8IpJJT7YXMVgVI+HryGzLL4CWJNm6mvfCMDb5Bq2IN4bkAMkS1UZL5OByBC9wVZagjFTBdAtNTn+tYKfMkOzqHNshJ2C5NZSkrsRJbtKfWzLrlvoaiIFJN3p0tpYiXONPIKV96RFn4Uj1FRi1ej1+MJ0Tz2rCQmD+KY/zJIIk4ZD+aS1I0iBAB77FXaw==
Received: from SA0PR11CA0143.namprd11.prod.outlook.com (2603:10b6:806:131::28)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 08:30:13 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::97) by SA0PR11CA0143.outlook.office365.com
 (2603:10b6:806:131::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 08:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 08:30:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 01:30:01 -0700
Received: from [172.27.50.128] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 01:29:59 -0700
Message-ID: <4e97c30e-0fc7-43e9-9faa-7194f6f0e759@nvidia.com>
Date: Tue, 15 Jul 2025 11:29:57 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v1 5/8] RDMA/core: Introduce a DMAH object and
 its alloc/free APIs
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Edward Srouji <edwards@nvidia.com>, <linux-rdma@vger.kernel.org>
References: <cover.1752388126.git.leon@kernel.org>
 <b1ff9b142f785a52009b288567bf4e15dd34ecb8.1752388126.git.leon@kernel.org>
 <20250714163951.GG2067380@nvidia.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20250714163951.GG2067380@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e515f7a-3ad5-4170-a8c8-08ddc379d178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXFPeXpTa0FhMVltTkFJdTB3K2NBVkNWdmpVcHIwMU1pNGpRSE5RZHpmamxh?=
 =?utf-8?B?YnNWNHZMOUpxeVhmRjU1aW1IejJKMmExT2g2aU95cGZjd2lodmhZYmI4aVF4?=
 =?utf-8?B?Zm14UlZRcmVHdDE2RmkzQVZpUXFmcVpMNHR0c05MQWtFYzlTVDlCSjdGc1d1?=
 =?utf-8?B?RUNORDkwcktCdmpoT2FuUFdsYVVGcnRLZVpnb2dJRnJVYmt2NVJCNkk1bVhk?=
 =?utf-8?B?VGpoWmJpVDFMOUVyNE1XSXZuQlI1cnRNRHIvMlNBYmNRRkhwN3JOL2h0TkhP?=
 =?utf-8?B?enhBZ0xLRVl0Skp1ZVN1VVNTUFdxNkhFQ3VJYXd0REY1RmI0VTE0UlFrUnhW?=
 =?utf-8?B?cnU1L0ZtQXhUdCsvSmw3VlJnZFdPenV4OUNhdGJHa1pqTzdUV0syL2lqNDlY?=
 =?utf-8?B?N2VHb1l1OW5UMFVqQk5KeWJuTzQzWUlDcE02cS9odnVMR3c2cVdQQkJBUmx4?=
 =?utf-8?B?bVYxQVVNU2xHQ1pyOWFUY2k5ejgxdVNJaTdwWFhsRndqQWxydlQ5OUNwYzZU?=
 =?utf-8?B?aEpEd3IyTnJiYUNMSFp5SFUzcGt3Vm1rMkl4OXFabnphY2hBNE1VeVpVQ1Ft?=
 =?utf-8?B?NkdjaGRFV1dHREdmNERPcWs3UWduNi9QYXYwcnQ0bkhPcGVDWjEvbEZRY2dX?=
 =?utf-8?B?Tms3V2hDeHNLT3h6Z0JZN080WTR3MnlybEhWNlhIemEySXFHTnBIR0JSaGdT?=
 =?utf-8?B?UCtIZjRtWkNhNi9HaDRzeXBXd2hydDBxUmFEc2hIbGtPampHZHphM2U1UFlR?=
 =?utf-8?B?K1RjL1diUjRyVVAwbUZhTWY4SjhLaGtmVjRldnE2b2NieWNHWUorUkpVTS9m?=
 =?utf-8?B?WnpNZWlrUlZUbWYreGFDZklRNkJodW5RWmdLYUhLTC83Mm5UNHROYVpNbS9M?=
 =?utf-8?B?c3UwS2xmZkJmb0txMzFJYkIxeC9FSjhuOXcwM2t4cXAycjVuMFNud3E2MjdU?=
 =?utf-8?B?QmIyRjl5ckJhTzRiSTVKS1JmTW1JWVl2L05vLy9GS1FaT1JLaWpGbE0wOVc1?=
 =?utf-8?B?ci9QQUI2dkFsc2dFcmt0V0NDVGRGYkhqWUhJblJZVmlPaHA5dUJUSUkyVCtn?=
 =?utf-8?B?MGEyZFkxU083R0N0ZkdiR1B0a1lLVmJJQXVKVElpa3B2YmNmczlaWm15YVpX?=
 =?utf-8?B?cHpmdHZNODF3WHMxS241UENLNldxV1BYemJlYVc3enVoenZFT3UyWURaMVZN?=
 =?utf-8?B?SDRRSDQ2SHFPN3lSWnpLbmgwUFNkcEs2SGluS1ZXZ01vLzMveFZleEtiTzN2?=
 =?utf-8?B?MzVwYnprZ1lhTVlVYTJVdVI3eTJON1FtZ3RyTEhTeEEvcVgvaFpvUEIya1JR?=
 =?utf-8?B?TXNEd2ZBZDFtdWkzb2Uzd1l5Zlc5M1pwd0JLa01iR2J2SkcreEQwRkplVitm?=
 =?utf-8?B?LzdvZ0lpODBNbFRQQkpnWktkc05Ha21Dc0lPRWFVM29tM3RHcnQ4UXFDeGxp?=
 =?utf-8?B?ZTE1dlJvcjYrdUxvUi9KWFBLSlBreGxHenZFdGphOVFMUU43ZVp2RDBDT2ZT?=
 =?utf-8?B?REF0RmREL0o2OHNSM2lTRzIwQVFZYXE5anMvdHpZanlLcHl3Mko4eHpCUmhX?=
 =?utf-8?B?Q041MzNoQ1kyaXdqcSttT0QxSnRyNGw5TnVLbnNIOUVpbkZMT2RicEtaQ3A4?=
 =?utf-8?B?OTB5bnFCeGtLM3J0bE5kR1M5UEZlUDRwYUplWkI3clFmUmRSY3Z2RTNRNUVm?=
 =?utf-8?B?QURzM2Jqek5vLzVYNThqZzJpMVR4UEFOdlE1NzRiSURzUnJrWmsxWUJ3N0Vv?=
 =?utf-8?B?REpjelE0SS92aURweTZ0OEdJSDBUcFN3U3BlcTVvNXRhK0pWWFR4ODJjcWov?=
 =?utf-8?B?bFkwV3FJTVV0SEk2alZYSTZSbDVGZlY0T2Y5MDZnb0VXSm01bFovSTFtM21j?=
 =?utf-8?B?MzExd0NqZzl4aWlNVzhTaE00M1ozRVdqdE41Mml2b3VwQUdjQjBIa0doZjgz?=
 =?utf-8?B?NDBSZzgyajJOZnNlUWg3aWRsQklSTVlxWkdLZ0NyWFk3T2J3V1RnT2h0N2tl?=
 =?utf-8?B?QUtqelBqMmlvc2ZQd3d1NVp2VmYzQlJrOE9DaktZampab1A4VXd6Z0JJNTNw?=
 =?utf-8?Q?vCnmty?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:30:12.7699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e515f7a-3ad5-4170-a8c8-08ddc379d178
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644

On 14/07/2025 19:39, Jason Gunthorpe wrote:
>> +struct ib_dmah {
>> +	struct ib_device *device;
>> +	u32 cpu_id;
>> +	enum tph_mem_type mem_type;
>> +	u8 ph;
>> +	struct ib_uobject *uobject;
>> +
>> +	u8 valid_fields; /* use IB_DMAH_XXX_EXISTS */
>> +	atomic_t usecnt;
>> +
>> +	/*
>> +	 * Implementation details of the RDMA core, don't use in drivers:
>> +	 */
>> +	struct rdma_restrack_entry res;
>> +};
> 
> Also this struct shouldn't have so much padding inside it
> 

Right

The below is a better compact version.

struct ib_dmah {
	struct ib_device *device;
	struct ib_uobject *uobject;
	struct rdma_restrack_entry res;

	u32 cpu_id;
	enum tph_mem_type mem_type;
	atomic_t usecnt;

	u8 ph;
	u8 valid_fields;
}

Yishai

