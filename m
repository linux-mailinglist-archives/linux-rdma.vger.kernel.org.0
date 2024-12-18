Return-Path: <linux-rdma+bounces-6619-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEFD9F6007
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2024 09:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9CC1895C26
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2024 08:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB4218872D;
	Wed, 18 Dec 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j8yWG+dB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2115990C;
	Wed, 18 Dec 2024 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510143; cv=fail; b=FD9FHE3ll6Ql/6YkmZ8sy1QrUnpiESVKgvunzQ4i4YWU4j6s7e2+3xOFdbzYlREtHvfkEFAZwYcxr7hxj+Ldg6P2pv7oHbYdY3ehDumC5W7ErcXn5/+x1fm9wqo17ZjjcnU9EHxxz/f+uJfOzm008WEv9TAN+htZbwzkmz8yvJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510143; c=relaxed/simple;
	bh=HDvKL/aXQYkd3N0lOOwQXUM2xK1ZT3sU4qNOL+So6Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UfA6Y5sX7olntvseQoffrlLwln+NIjtnPIuUYprnJDcexvCBN9XVDjerSkLkCTYNya9heV4a6CaSGvJAgmjs5wGB1mvVaTZu8a8wySTQx5cHNHdfS1TfkyiaIMt9gzUujyJ/GRLYZW5puPPWoLB0jgtyhyKmbE51MxlHOndYdu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j8yWG+dB; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKdBDvRjdUUnztWVR4HBORUnWgySQX96SIiURPiXCJ1Px9Qa8Y7+dvkBYUAds6mwsOIU7vAVtAlvVuTxet5+dOTrOkb4lIucrrHP98jyMn6p9jJZ1Vo+xxjQehd5GrfFyK35EgKJUbDkrLvrtdKp+0XZ+jbD6BeK07tWmNL4IaVQdyUtTLwqZSTZpLgUxrijqwfprtbbQGLjr9+NZ1j308teW8F6yFzLFK7/pSbo6CYVlvvr71LdulzKXEXBX4zrzXwfi7IaVh+NxS/sWL9EX08WvuEQOX9yyRflHDxvrx47DEulGCNshY2S3q709Ar97OBkBpTlob6Ys0rzsfSg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PwhY6IBV4PGQsV+4wu0uhJNNfwUe0gnixzSi2kBlw4=;
 b=TanRIMu1A+NP1u8j674ftVFOkXTYGxiHwB8z4Hq5TLcwFjGIU/AtrENoJ6Ys/DK7k9ROQsFiZBHdVREL0ZeWHSNKCmnfouJnAr67E/kkdXG6XuzvlFU4faBpNne535cCRMsuYtoWKYbx1hqwRYagtmq2uUNMH72qWXzxKrldjZqtojxPJwAHI1yMUMnQK67HAWK99W9YmVbKhZlgbexg1dLFSxIV/5Ay7Yk79qjn8Ty0B6wVifPLozCheGzuJU/XgDq71FcPNKQ9Ux2WeeY/fiXKifICGmDHt3XQFR8fQa0wudniDwbwftOgZtgTgAFRUyGGchrYcPPyJnzuCl+eMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PwhY6IBV4PGQsV+4wu0uhJNNfwUe0gnixzSi2kBlw4=;
 b=j8yWG+dB7TheOFSrfAh+EkLVly+/VfvrXakczn3GTbxb9Gue+QTFsMpnveX04fIWlyW3JuEXZHgIEuHlPo8nUrXeXl/7WBkZKpLH9NecShmhHakD5pG7yu/bvmo8XzWMJPegzVbKUZjt7Jxm0OX+0kaNRezHm13NIq4P9o+NkjSI6JaCjK7d3zbdWF3ObKbqCXKcrsoWG7AtvJgeqaUEzF99A6ajN5QawBGlLNsWR2gWogRP3ygiOZGHRvbWEKZ0ZxMDR/PWFSy38aQh8dEFLt7ocjFLPBU9U4/rrWaUCDkRGGPLwRi/ufoklw+HigpSRbI4uMcCnOlr8dAo3HbdPg==
Received: from BN8PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:94::39)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Wed, 18 Dec 2024 08:22:18 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:408:94:cafe::f8) by BN8PR03CA0026.outlook.office365.com
 (2603:10b6:408:94::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Wed,
 18 Dec 2024 08:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 08:22:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 00:22:03 -0800
Received: from [172.27.61.22] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 00:21:53 -0800
Message-ID: <101cfa96-ee51-4a68-a11c-4f1c93f7c79c@nvidia.com>
Date: Wed, 18 Dec 2024 10:21:51 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/12] net/mlx5: fs, add mlx5_fs_pool API
To: Kees Cook <kees@kernel.org>, <morbo@google.com>, <qing.zhao@oracle.com>
CC: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<linux-hardening@vger.kernel.org>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-6-tariqt@nvidia.com>
 <20241212172355.GE73795@kernel.org>
 <70b3a7b5-abd3-4db4-8415-e0467a565847@nvidia.com>
 <202412172115.C7FDE7BA@keescook>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <202412172115.C7FDE7BA@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cce2ada-6666-4b21-3727-08dd1f3d162c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXhQaW5uS0cxRU5ORU84MkRWeXFocGxIU1BZMlVIRFRhdFFxNjRRanNoVGs0?=
 =?utf-8?B?M0dyQkU1TGk5RDRVaE9CYTVXQzFLZitLckJIaytPNHFEWXFhY01INml4Ri9Q?=
 =?utf-8?B?ZWVuQlZiU1hmeC94d2dMTGc2c0dPRmNCM0dWSnhoT3BQTUdsdldpKytzaUNM?=
 =?utf-8?B?Vml5akJjZE5ENkh4dGZ1M0ZSSGlweG9GcFl3SVQwbFpzY0p1S2MwODQzeUxS?=
 =?utf-8?B?SllxM2hRWExTMXppNy9MUUp0akk5YTJWRHYvVHVjaUNQOGVkS0ZzbklNNHN2?=
 =?utf-8?B?WXpkR2FYZHpiNlJmTStySmJEY1M4MGtzd3c4Sk5obnFURFVlU3QrSFRhVWZB?=
 =?utf-8?B?VFVQcWNmRVI2cUl0WUdacUhGUC9wcG55emxKSVFTYXBWdWpPWGc3NDFVUlRy?=
 =?utf-8?B?WUlkaHBpTDVtWnh2NllWVTQxSnFzY3ZUVGNUSEhtbm1ZMTg1MnJ4SGdoR2Ez?=
 =?utf-8?B?QmYwWHNjNlZpa0VhUXBQVUlndVpMK2ZUZ1gwOEVYMGVRL2V3b0ZIUG1VVVBS?=
 =?utf-8?B?QlZLVVV0RGwxN2tBaVN6QWhPVnJLYUM5Q0phblBHMUE3Rys3RDlMaFRUZDJI?=
 =?utf-8?B?WEUwNENoQ0hmMWRaQzlLVjREZXlhVlZqQmpNeHFkOGdUcHoxclFqNDBLenZD?=
 =?utf-8?B?VGFTUHpET2dZdVh3djZrR0EwYXhOUmg1eUw5L2ZsYXhGWVV6MHQ4Y2p2d2ho?=
 =?utf-8?B?TjNaWVVYV3ljRVQ3ZlJTTUtrbW5LVG9weHB4d1VONGRZdnExS1hJdHViWjFU?=
 =?utf-8?B?MlpsRHhpcFlXNWg5V3lyMlorS1ZYZXQxczFudXRQbXUrV2lSOC9XZjJmNDlY?=
 =?utf-8?B?N2tYME1XQ3l4TmxXRXYvS2dJWXFqYmJWSkQvWVlDRE9GK2R2aE1rWm5uSlVT?=
 =?utf-8?B?L0p0UGFZYWw0cS92MDJZd0NKeENSV3g5MGhOejNOMlduVEZvL3E3SWx6T2VW?=
 =?utf-8?B?VVJMZGxTUUhOa1UwUU05TVYvZWwvYnpMZjlYYVBObnU2NkNzTElhQ3ExT3hm?=
 =?utf-8?B?Uzc0NDRVUUQvSW5uV1B3YUhlajhEeFVMUzFSQ1d0aGd1WnZJOVJNMW0zQ1l4?=
 =?utf-8?B?WVRwMlZYRm1ONTQrcDFtY3FVeEVNQ0UycmgvRUt6VkhzVWkzVURNcWt5T1Nq?=
 =?utf-8?B?L2IydUpva3FRdEZ2dnFtbXFCcGh0a1plOGQ4R2U1MEhlLzkzaXNsOW1USUpW?=
 =?utf-8?B?OFRyYmZmdTlKbDYvZDlRRmxIQUNlanM3dzNCT1R1akJVbTJGbzUvVVFoN2s5?=
 =?utf-8?B?THRhbzhRL2k4K3RWb1V0ZFBSNzZtWFNua2pNT0diU0RScExyTU5DY21OTmE1?=
 =?utf-8?B?cTFwWnpMMUI3TE1pNFo0TVFadm1kSWFUNlpBZG5zajlVVDhDcU9YSlBJTWxM?=
 =?utf-8?B?bUMyZ1ZDaHc1N0orZXJRaTJlcW4vLzZoTHNxc1RvSkswNUZuOFN1cytwd3Q1?=
 =?utf-8?B?VUY5VE1Od0MxR0dHR2VzZ1dSR3dLQTNJS00xOVBybkdGWWNyQzQ5VTJhbkRD?=
 =?utf-8?B?U1NLek5iWUJwc2wwbjM0VFZqL2RkS1RtRktPZkRaNXBERlJ6Tm9JOHlHQTB5?=
 =?utf-8?B?ZnpEaXB5RHVWMmpEZWd1SnBPVU1Zcml2MTlGVmxmUlVzRlU5d29xNTV4bDJG?=
 =?utf-8?B?a2xRN3JEc3lhYWlhdGR4K0ljVW0rM1pvK2RKZXh6ejRkTHlzUTZjZWNIVmMw?=
 =?utf-8?B?M0hLYUsyRWduY2VuU1A0SVhlVjlDUXV0dy8xSEhzbHpadDZ3RG1LQ2hnM1Fp?=
 =?utf-8?B?VjdRUjZYR3hBa3lWZDZmbTc1TDlCWERNQzJ0WHZtcjFQY0pjYUNmZXBVS2hF?=
 =?utf-8?B?dEFoNjF1dDBGU1k2OXpXb1UvUXlZVDVRSCtHelUwbzdwYWpUcTVYdC9UWjRS?=
 =?utf-8?B?RlkydzcxZ25nQUp2VGZRd0Ryd1U4ejBGbVFma0dPZkNzVnRGejNaWUNBSmE5?=
 =?utf-8?B?bU1JRkx4K21XVjdabTNpa2NDTlQveU5DOWh0czI2K3RicVNnQ3RWL1kwZHhM?=
 =?utf-8?B?OVRIbGxZaFh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 08:22:17.9909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cce2ada-6666-4b21-3727-08dd1f3d162c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117



On 12/18/2024 7:22 AM, Kees Cook wrote:
> 
> On Sun, Dec 15, 2024 at 03:39:11PM +0200, Moshe Shemesh wrote:
>>
>>
>> On 12/12/2024 7:23 PM, Simon Horman wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, Dec 11, 2024 at 03:42:16PM +0200, Tariq Toukan wrote:
>>>> From: Moshe Shemesh <moshe@nvidia.com>
>>>>
>>>> Refactor fc_pool API to create generic fs_pool API, as HW steering has
>>>> more flow steering elements which can take advantage of the same pool of
>>>> bulks API. Change fs_counters code to use the fs_pool API.
>>>>
>>>> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
>>>> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>>>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>>
>>> ...
>>>
>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
>>>
>>> ...
>>>
>>>> @@ -447,11 +437,9 @@ void mlx5_fc_update_sampling_interval(struct mlx5_core_dev *dev,
>>>>    /* Flow counter bluks */
>>>>
>>>>    struct mlx5_fc_bulk {
>>>> -     struct list_head pool_list;
>>>> +     struct mlx5_fs_bulk fs_bulk;
>>>>         u32 base_id;
>>>> -     int bulk_len;
>>>> -     unsigned long *bitmask;
>>>> -     struct mlx5_fc fcs[] __counted_by(bulk_len);
>>>> +     struct mlx5_fc fcs[] __counted_by(fs_bulk.bulk_len);
>>>>    };
>>>
>>> Unfortunately it seems that clang-19 doesn't know how to handle
>>> __counted_by() when used like this:
>>>
>>> drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c:442:36: error: 'counted_by' argument must be a simple declaration reference
>>>     442 |         struct mlx5_fc fcs[] __counted_by(fs_bulk.bulk_len);
>>
>> Thanks Simon, from code perspective, bulk_len should be now in the inner
>> struct fs_bulk.
>>
>> Keen Cook, is that going to be supported in the future? for now I will just
>> remove __counted_by() from this struct.
> 
> I am expecting this will be supported in the future, yes, but there isn't
> an ETA for it yet. Neither GCC 15 nor Clang are currently supporting
> sub-struct members -- the counted_by member needs to be at the same
> "level" in the struct as the annotated flexible array.
> 
> Is it possible to move "base_id" above "fs_bulk" and move "fcs" into
> the of end struct mlx5_fs_bulk?
> 

fcs is specific for mlx5_fc_bulk and so can't be part of fs_bulk.
In follow up patches for hws feature I am using mlx5_fs_bulk in other 
type of bulks, fcs is specific for mlx5_fc_bulk.
Unfortunately, I don't see a nice way to have bulk_len and fcs on the 
same struct.

> -Kees
> 
> --
> Kees Cook

