Return-Path: <linux-rdma+bounces-12198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89776B0635F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 17:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34204E1245
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F88266B41;
	Tue, 15 Jul 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JLkl8lCN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F221DE8A3
	for <linux-rdma@vger.kernel.org>; Tue, 15 Jul 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594343; cv=fail; b=h/JF1cGnGCY5Q4TKYCk13IoZTw8bKjG9DON/gtlULNh/AS/c8rBkJ1sFdpFjsi6X0xEXMGoX0kwbNVIxVeq2JYAu+aOb7Dd6X/7gz8Z2lSh1Ru3ZpbIuSKiLhgWlG6jc1QOz1jt+XysRID+iXSNyT2OxExA4IxN5lUBnxjkau1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594343; c=relaxed/simple;
	bh=nB7IJWgnNwQ0x0m9hq+Bf2OUAdcso9Tm903DqALNOlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WyR4HF8wyvQZt80rH2r7Gv8jk7PKTdLFdUu+KMgtzw8A4DUWdAx1Y5Snph6AkK3UpIFQdFS42jbi9McGf1c+v0X0tmBcEIMLrgA3t8cspbzF0cVOHUR9P1XVs5ZQo0kYB1I9Pycio0Pyw2pz0TxOD2XOA84339J5yKfG7rHX1vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JLkl8lCN; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRNns8DKzzebmYStVnLdS+8MHstkGnT/SuggkOektzkx5gCCppv1Zn6u38CXW7lcpaO/FQGKOjuVcTczkHv3Doq6QzGsqLL0cz6aAzPresluSU7JrdUXZ5dSgaHVbeAhytOuS0W5QKaqrqnIG8oUKpqU2eScKqoz889abMR0WU+22vX97gnlvLuasPnvkLe5YEJAdq4f90gP85OSvAtdh2+aHVl3CxOqLvZ87hjv2jC89EBKWHDDpzlkndFvikcrC4Tzx8t1uw//qp3X3/qf6xYNRGC570WUVF2MyDWbpX8P8e8BJvXIVT9nq08QPEiI7LgqkNssMELqJUuIvqGqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kC4Ns/x0PcHHMskjvAoIaICnvwoxweJf48cfSpyRV8=;
 b=GjXz0jtw5VOOCdeWc5sGueZ4RwPXEwUkn5Qr0DbwWx74kFFbqjPihqDFN3A+E5glNHEyuilBuqM0fYsHAtUcLngLjc7WtXXHwDE80yPlvJ+b13gRMdEVt08xmDamyz+unNKKV738CCf0AVCtPfezgDtdIY9md0m9LlzObsgrhT0zRtGduFklM7qMUUfCF6dXMnfl8vXl3Nwe9g/RVJKG8eaN7CksWUdUpU74TMdv1zYpdjl2WRqeTjyBEYPrFTJuHEMXI7DZa2zpBJQ8xZ35MLjkxmOtK2lPIoQEI5qRH0Y5FYPIiTUest3yYsKmhjNseWlFZuH9Z3Y/2RAlIjQdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kC4Ns/x0PcHHMskjvAoIaICnvwoxweJf48cfSpyRV8=;
 b=JLkl8lCNawxCC2s9LzyQKr58hssQtaB3A2Udl8QcjZD/DLvRdGzBSb2cn369ius8HQzIA8RlXb9wRcKifcnYBZorQLYvEu8Sp6zTwnKPYsrbXzvfRKPImT7rAZm+s8NhmojYDF9TbaqGxwUdhfmS8nhuCczRFXPWY9KyhF8rgP90JVM8npP7pPh6S0M/6QFwULIoFmdVRW8UdkAgvbSeSb18r7gM4rps2G1IMqImzl31/aSVC2AOb5MiGaD+cFHQhX7I3uyAHW5om9zIrSIBU8gqHUrHBuybCQ+amN17Sy8w0m+SLVzvmALWSaVScIDgqpZlllhy0ez9eDwcOnNQxQ==
Received: from SA1PR02CA0011.namprd02.prod.outlook.com (2603:10b6:806:2cf::28)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 15:45:39 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::6d) by SA1PR02CA0011.outlook.office365.com
 (2603:10b6:806:2cf::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Tue,
 15 Jul 2025 15:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 15:45:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 08:45:22 -0700
Received: from [172.27.54.228] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 08:45:20 -0700
Message-ID: <b573af0d-72e2-4416-949b-ff2fcbe9d2cf@nvidia.com>
Date: Tue, 15 Jul 2025 18:45:18 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v1 5/8] RDMA/core: Introduce a DMAH object and
 its alloc/free APIs
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, Edward Srouji <edwards@nvidia.com>,
	<linux-rdma@vger.kernel.org>
References: <cover.1752388126.git.leon@kernel.org>
 <b1ff9b142f785a52009b288567bf4e15dd34ecb8.1752388126.git.leon@kernel.org>
 <20250714163925.GF2067380@nvidia.com>
 <01b087d1-8710-4111-8ba0-b942f77a8b0e@nvidia.com>
 <20250715125311.GL2067380@nvidia.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20250715125311.GL2067380@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e69d36-9e56-4ac2-c8b4-08ddc3b6a603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFBkT1IvQ3RqWG8weFJtQVVBSU5SL1JVaURUbG9ycUtQRURXdUQ2Qnh6WGJm?=
 =?utf-8?B?RTVVTFZlRTlRS3lhdlhFRXBvbk5SYWdib3NTU2lqc2djMGVxcHBXZGRCNmNL?=
 =?utf-8?B?QzlCWitsdGRoTEdIejg4UGtHbHIya2dBdllJLzBMS2k5cUZzZFZGYTFWdnl2?=
 =?utf-8?B?bFdnTHhVbnRMNUo1UENGYlZBTVU1eU93MXduVFlMU0VCN1VhSDFzTXlVZCt6?=
 =?utf-8?B?aGV3WXBxOGJpdW1SRkxSMEt6VlRzM0dFNFhQMHZ0N2tUV21BSHd4eUFzdFQ0?=
 =?utf-8?B?Ynl5bzMzTHF5UHRITU56NndkV1hFZDliV3poYmdhVTNqSllFVHVCd0p0SzEz?=
 =?utf-8?B?U1BPelNPYXl3L0kvckZEck9zZFNqZmw0ZTdmd1ZkcnJwZ21STjBzajh0SkZX?=
 =?utf-8?B?U2xScC9GQWtuVVo0UHJodDg4YVAzck93b0UrWTJrMzJGbkV1SWN2dC94eUxh?=
 =?utf-8?B?c3FzRlA5NFBtL3VLeFhHN0JJMmRMSGpDKzVlL0hxRFQ0bkUzekRKUWJVSFJP?=
 =?utf-8?B?QU12clB5Y0o5Y3dQeCtDSnBjSXJFdFhKbXlJMW1JNm1qSGR6RllkcWpUN3h3?=
 =?utf-8?B?SUs5TjhnMkFnYVhERk9OL2NzMmhSTE00UVhETU0wVXlPQWNEaDVLdStDNEVy?=
 =?utf-8?B?WEMyNlErMm5NWnBveG9sTzVEaWJ3YUFtYXVnakNUZTRxYVAxQ0NVR1pyV3ZP?=
 =?utf-8?B?VjBqdDJJbG14MnV3MlNzeUNnbjY0VlFZWFJKZnBKTWcvZk9vMUFDS2dOSzBv?=
 =?utf-8?B?L3VMNE9Ga2E5ZHJmQ0hWa1c4UmJ5bXU2S1piazY5VVFMZVZlQkczMTVGSnhn?=
 =?utf-8?B?QnVoQUVwM00rYWxGRDBhV1FMUzlVd2dheGdDWHNjRUdocGtXaUx0dWVBbW9O?=
 =?utf-8?B?eDNydHpXNVRJRm1UTlh5ZVJWem9FWkNHbEhCMTVyZWZFcnp0bWpuZ2swc1lD?=
 =?utf-8?B?K2M3TGZUUEFjYWt1OHdRQUF0enFuQlc1TCt5OTZlMjNhVWgxdTNZYVBrYmRh?=
 =?utf-8?B?WGxGNXQzVGRSVjJWeGY1QzZVRlZzSmczbTBxa0h1dFQ0VkhoQ3Q2OUJrMGFQ?=
 =?utf-8?B?aHQ0QkdDRnRaRHl3Z3BOakpLOGIvMFZBZms4NXYwM0JWN0RyRk44WmE0aThW?=
 =?utf-8?B?dzJFQkduZDFsNUdIU1dRTnZBZS9MQ3BBamxJN3lUWjUyQldOc2QxeVRRVlVL?=
 =?utf-8?B?RlhSUUl4STJjRG9tMllJTUpaQm8xT2gyZnRPYXJZd1VKVGtGdWZNVjlpQkVx?=
 =?utf-8?B?YStlUndzKzNmeVlUT1NhbS9LNHVqWk4zcTJEWDc2cFJNN3JLZXBMcCtWVWwv?=
 =?utf-8?B?aVpRaUhWb0FVZmNEbmZiblo2TE1FbmU4dmNtM2YzSUFDZ1FjaFkvNDdwY0RX?=
 =?utf-8?B?bStrRWZ1aHpuL1VxSkdYalV3bFZSUHd1cHE1VjJwU1A3ZGV3WDhmeU9GUnU1?=
 =?utf-8?B?Vkk5MjdiZ1plZExNMHhpazc2MVhMaGNsc2x6SzFEcC9hNGcwQXNLNEVCQjlU?=
 =?utf-8?B?dm9rTHU0cmNkdmhZZ255RXZkRzdjbDM5STdHQ1NHUWdMRWVQYWcvZ210cThr?=
 =?utf-8?B?aTVSRjVGY0FyV0dGMEZ6c0czajdWQnJ0dlRmcGxMSWxTOFZldFVDMWdGY3pO?=
 =?utf-8?B?Q2dwZGMrQ1FvZEFaR3ZYcGNqSDUrSVFJc0kyekRHUWF3VXVrRkk3dlNtclNm?=
 =?utf-8?B?ZlFKci94R0VNZVltTS9UYUpYTmJTREJ6QVlkaVV1ZSsvQ012bVhZeDlPSC9t?=
 =?utf-8?B?Z012bXVvdENETkRxWUg2OWtidVdlMDMwZHR3SDRFM3JEMDlrYmtaZ0lPVUty?=
 =?utf-8?B?dzRoTklYOWJtVmN6bXVZMHJ5QmkxSGhOWFhTMTBlUHIwdmpzbThYaHdVZ3lO?=
 =?utf-8?B?KzNwb20wd2NUUWRIUkMzVTU4UkxaY1NzMnc4dC9TdWpWdkgvL1NGSkx0NmYr?=
 =?utf-8?B?aU1DaUU2KzlHZmlWaHJEbkVuRnIwSkF2ZlBsSkJ0Z1BNMTF0dFJ1blBJSytQ?=
 =?utf-8?B?cjNUak1QMitkd1RWZ0NGNnd6ZjRNR21LS2NyK2FTWnE4c3R3ekhIUWNSdndZ?=
 =?utf-8?Q?zU1jaA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 15:45:39.1698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e69d36-9e56-4ac2-c8b4-08ddc3b6a603
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

On 15/07/2025 15:53, Jason Gunthorpe wrote:
> On Tue, Jul 15, 2025 at 11:21:14AM +0300, Yishai Hadas wrote:
>> On 14/07/2025 19:39, Jason Gunthorpe wrote:
>>> On Sun, Jul 13, 2025 at 09:37:26AM +0300, Leon Romanovsky wrote:
>>>> +static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC)(
>>>> +	struct uverbs_attr_bundle *attrs)
>>>> +{
>>>> +	struct ib_uobject *uobj =
>>>> +		uverbs_attr_get(attrs, UVERBS_ATTR_ALLOC_DMAH_HANDLE)
>>>> +			->obj_attr.uobject;
>>>> +	struct ib_device *ib_dev = attrs->context->device;
>>>> +	struct ib_dmah *dmah;
>>>> +	int ret;
>>>> +
>>>> +	if (!ib_dev->ops.alloc_dmah || !ib_dev->ops.dealloc_dmah)
>>>> +		return -EOPNOTSUPP;
>>>
>>> This shouldn't be needed, use UAPI_DEF_OBJ_NEEDS_FN() instead.
>>
>> We already have UAPI_DEF_OBJ_NEEDS_FN(dealloc_dmah) below, so the check for
>> !ib_dev->ops.dealloc_dmah can be dropped.
> 
> Fix both

OK

The below chunk will let us drop both.

@@ -143,6 +140,7 @@ DECLARE_UVERBS_NAMED_OBJECT(UVERBS_OBJECT_DMAH,

  const struct uapi_definition uverbs_def_obj_dmah[] = {
         UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_DMAH,
-       UAPI_DEF_OBJ_NEEDS_FN(dealloc_dmah)),
+       UAPI_DEF_OBJ_NEEDS_FN(dealloc_dmah),
+       UAPI_DEF_OBJ_NEEDS_FN(alloc_dmah)),
         {}
  };


>>>> +DECLARE_UVERBS_NAMED_OBJECT(UVERBS_OBJECT_DMAH,
>>>> +			    UVERBS_TYPE_ALLOC_IDR(uverbs_free_dmah),
>>>> +			    &UVERBS_METHOD(UVERBS_METHOD_DMAH_ALLOC),
>>>> +			    &UVERBS_METHOD(UVERBS_METHOD_DMAH_FREE));
>>>> +
>>>> +const struct uapi_definition uverbs_def_obj_dmah[] = {
>>>> +	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_DMAH,
>>>> +				      UAPI_DEF_OBJ_NEEDS_FN(dealloc_dmah)),
>>>> +	{}
>>>
>>> I think it should be on the NAMED_OBJECT in this case, like AH:
>>>
>>> 	DECLARE_UVERBS_OBJECT(
>>> 		UVERBS_OBJECT_AH,
>>> [..]
>>> 		UAPI_DEF_OBJ_NEEDS_FN(create_user_ah),
>>> 		UAPI_DEF_OBJ_NEEDS_FN(destroy_ah)),
>>>
>>
>> The NAMED_OBJECT doesn't support UAPI_DEF_OBJ_NEEDS_FN.
> 
> Hmm, really? I don't remember.
> 

However, it can be achieved by the above chunk, being part of
struct uapi_definition uverbs_def_obj_dmah[] = {...}

Yishai

