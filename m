Return-Path: <linux-rdma+bounces-14871-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18433C9F6BC
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Dec 2025 16:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 671473000B4F
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Dec 2025 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A75328B73;
	Wed,  3 Dec 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JghMureU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD915186E40;
	Wed,  3 Dec 2025 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774917; cv=fail; b=fT2nV8v6+4NsS1ZwkZXnRiU8uMDsdsvoikJ52L5titMqVqfXzWP9W60piYKbCmH9a7q6yXhfXLQDjXkC4N36e+VBKiyZSQaMkdc9MPD2BPKAWjSRRRTTrXMBpoWaahpJ5QZznsyK6APS+CqjGRjIk0DvX7KNRS7KuGJk3gmWuHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774917; c=relaxed/simple;
	bh=DjqqyoD4D65cpIFYU7bW878Oa6zII0lT1xADulPHCbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n+KHh7VQeMCltHu7t0NcirDbP4GMwhWSJpFZNbgvUD1NDvbsoWsFZ8QJPCBC1SNC+j6Xijt3RkyEIsCVA+B0t5wwm/ufDJJLCBfesyBG3rmLr2hnWcGN/dnOMkVhyGssnmPIz7e2eh7LvBN7e9Iv0JJ8e79fzX9xLWk7K7JfEW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JghMureU; arc=fail smtp.client-ip=52.101.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xi7Bmc4jKPDdGJlxvqfryY2DNt5c/UnUcBCSX/aG+J9VYBBrZb1e7B3yZvjJlDLzHj2dPe42Wsn10M4RIxl5TdqiovcLsRFMh2g4coVQTJ1mNnZ7Yn3n3q5thtLNrdtgRVvouwAfLzs0RXSi5+OAVcoFgsfaLxGM/PKCma/7HeFDInFEMehdlSOpaSZtLWegm6KihSiUSev1+N+/w4RIvGob5W+VM6feQermNznFCVzePUMaJp3ZWgMQLAcasn+ywIXcDBJX0tYafb3mLo2lYkEEDqDYJ/8y/jClfbZK+O2ujIQoHBOU3xKELYPWhB9W9p0Fscc5Lx1VUFftYBzxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jIMCnE0wLc8PmLuUzpvMZEGoV8UBPctCqq4B+QiwA0=;
 b=X732Qa20jj3uDlJyClhTQMnNZM4vPDxC2rTXLboktdYut9502S01KpJTsRDmAz1L0floRUcLctMnKNz7kpsf387Vmc2CXD37/xqD9WnbRH+HHBN8GxjvjDCmqztuA2VhPet/iHJVYcT3LEordk3Y6vMDePEJkF4/RpbvCW08g4yN6KUsVPLGB2HIGLfVOH2AS9lW2kdym0Am+5y/Jo9Ncu65SXVVbLC0508mTEAlWhWeU/owg9M76vL+/K5MNz4FnAi2K3B4OZSk0HJXWBYC63PS2mqpiq6UYjqfVz2P1m+26csKO4dxrC+NGt9sWGR5CKmH8ml1tWb26WDfv3S/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jIMCnE0wLc8PmLuUzpvMZEGoV8UBPctCqq4B+QiwA0=;
 b=JghMureU5GmLILUEkIpW1KVK428WT9AbMxJN1zsjPkhXC1CUBzK/h2XsydhF76s5gWzKo8XRYsstleHCl0nMHYyjoNwoDXon4WqDfYx3L/Zl585oznikidnTKYtyBoKODfWlGzXH2F2YYjMiGtPQRLlLb5qt1FNqBGiagp/dzG/HqnvuY5GmGDhTW8tKq/wVc8OFBq5Yy5jZyY1aHTkZRPCBa0BDbofqv70MBzNnVRD/oeayPomFYhvIZTdAT4SrQotTyz4VsGu9NAoFG/vrZEgwwVp1kntzH9xTDAfj6RGXUTt0TtCddu5jSnPjcMi3Y954rLTHO91mGXhnblcR/Q==
Received: from SA9PR13CA0148.namprd13.prod.outlook.com (2603:10b6:806:27::33)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 15:15:08 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::4e) by SA9PR13CA0148.outlook.office365.com
 (2603:10b6:806:27::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Wed, 3
 Dec 2025 15:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 15:15:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Dec
 2025 07:14:47 -0800
Received: from [10.242.1.82] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Dec
 2025 07:14:41 -0800
Message-ID: <7ae1ae03-b62d-4c49-9718-f01ac8713872@nvidia.com>
Date: Wed, 3 Dec 2025 17:14:34 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fix double unregister of HCA_PORTS
 component
To: Gerd Bayer <gbayer@linux.ibm.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Drory
	<shayd@nvidia.com>, Simon Horman <horms@kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	"Niklas Schnelle" <schnelle@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SA1PR12MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0c957e-7e21-4277-d64c-08de327ebf40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXRmL0E3cXEwSEtRTlNZdVdneXgxWVRWb2l0WUd6am9ocTlLNWw2THRJMHRu?=
 =?utf-8?B?MVJnMHhVS1dNdGlzUXVqeThQQmNYUUFmTGxLeERBTkpBUmlJaGs2dnM1dlZv?=
 =?utf-8?B?VlM4YVBEUmFtaklNcVBsWGJPSVFNVUd4WmduajF1bEJlQ21hZjQrcVV0WmZO?=
 =?utf-8?B?TUhHamFKc3hvRHFES0lYWlI2b3Y5bWJQZWtVV2dBbWM0UC9RL2JndU14Tm5t?=
 =?utf-8?B?aFBhU0RuNm56NURnbHBrVHpUT2hGdHNGaFY1TFJ0dWM3RmVyZ05xZzNYTjhh?=
 =?utf-8?B?YmJZRnpwNnRxL1hJemR1SGRid0I2MHF6eU1MdnVWVjJKdnU5eXJQR1E2NVM3?=
 =?utf-8?B?Rjc4RE5iZGZtY0lNZm4ySkdNYkJWRjJwNy9aaUdlKzBxN0Z3THVjNUxuNk0y?=
 =?utf-8?B?LzlLSnlwQ2NBd215cTlJdmsrSXl1SGFqZENucTlHaWFTRmF1MkxOZFBtSStq?=
 =?utf-8?B?di9qN3A5eXNTSGhkRHY3LytSLzVNdDQwVEwwa1ZVUU52RUV5VVdPcStZSWZY?=
 =?utf-8?B?UGVub0lhR0VGcjVienlvQWxrV0FtWEhwRHVpZE04dnRocmo3UlJmcXZlL25M?=
 =?utf-8?B?cHdqUXM2Ym9qN3Vaa3FoQ0N2dXNud2Z4bThJdC9aSnRUOEw4SG4vamtUSExo?=
 =?utf-8?B?dWtoakdBczdGTFlQVmdLcjA2bEo0NmVWL3RlaW56em9NNnRscEN0WXlSeENm?=
 =?utf-8?B?ZWNmdlFlUlJRb0VyTVNuWXhPdkw4VWcvaDVjeUpSVUNUc1lwa1FHMU9jWkg3?=
 =?utf-8?B?dW82c1dGV3Q1WnpaeXNoNjRZOFlPTFBmc1ppZG84aHpLQi9reUwwOU1SL1dr?=
 =?utf-8?B?L09pZTJPeHFpTHVaTi9kcDJuU0E5TWZKcG00eWI0L0Izei8xSmpTZG1SbVJI?=
 =?utf-8?B?eFZmOFNWQlB6RXQyLyt1SFFDbkdkRGNKWXB2dG5aM2xnTTF3dWhxai9OYjdm?=
 =?utf-8?B?TVhvZFVwaTVHVFg3azhwWkJqQlQvRHo5b1UrcW1wMnd1WjdBNi8wUjNtZlBZ?=
 =?utf-8?B?Qk4vTk5hYityaWREb2pwN3VhalQ3WnNUQ094ekFqdUI0WFNZeVZVeVZydW0z?=
 =?utf-8?B?ZkU5aXRYUU9VRCtiVGRNUnBBdDVKM1c1M0dNRDNmTy95K3hRRmdQcTVjM3p4?=
 =?utf-8?B?SVBtS2dQNDZQSURPeElCVDF0KzU0YnZTQXdHUGpVT1dzNTZxNGNtamhnMlM5?=
 =?utf-8?B?dlpLWnkxM1BxWHVrR2RJeHpHa1VFVmh5bU5FTUVvWlVuZGNLVHMyZWZrblQv?=
 =?utf-8?B?V0U1dHdEWGk0cTlYUDVNaDBVMy94MnZGaWdDRDBYV2xpQjVyZWMxYW1QMVNi?=
 =?utf-8?B?c25lakhPT2REMTRFbEl0QUQvajNGeEhQZnBtTThrUktBcm1OM0l3ZE9KZVBC?=
 =?utf-8?B?SzQvdmNocjN2eTcvQ29tQWFacHhzcmtZL2dwWkI3RFJrMFNMZ3NmZVVhMGp1?=
 =?utf-8?B?RXpnK21SSlVwL2s3Q0lUek13dDFuMDZOazlmM3FGMEw3MVJJQ0FYWSs5QjRq?=
 =?utf-8?B?aDdHR29qWVFRNTJRYzZxY2UwTXhBZDlPTFVoSndCVXhYcjV6bDgvWVFZWWJU?=
 =?utf-8?B?VVZCUCtIOVV2bXRaOEpBbzJubThNSEpVc05Dcmg0YVdRbk5DZWJKeVdtVkF3?=
 =?utf-8?B?bHJiODJVQmN0dVlVazBHYmQ4clFZM3NVZERvNWNHTXdWMitSMFZCclE5RUJZ?=
 =?utf-8?B?RFZMQU1SRmpTSnIzcG1PdVhqTkF0VnpFbytQdmhYRjlFSElHSWxONjErQWll?=
 =?utf-8?B?U016bkdIYXYySFlFZ0cvcDdLVUthN1o2dWxYQ3RMdFVpQ1hmbzdOaDZTbWtk?=
 =?utf-8?B?OTd1Q0RQV3dpaWlvQ01PejFBbzd5UGxkbllQNXNHWnozOXVkSUtGays3MzJV?=
 =?utf-8?B?Y3RlaDJ4NDdSaGN0VlJYa1o5OGxsRE9nZUVOMjFOMkx0MUxEUlB3cWltejEr?=
 =?utf-8?B?NGZOMll3VDBxVGU4UXJzbnVyOEJKVXNvODVDdGdMemV1YVJ4M2lZN24yZzBx?=
 =?utf-8?B?Sno3cExhS05vdys4eFVhZWZtSGNtR2ZTSzN3WTNFVXJidnFzdnEveGlrbDJW?=
 =?utf-8?B?K1haMlpqTFJFc0ZJNmh0R3lBUlFPYnlwaURkY1N4U3JLakdHRlNUaEpvWXhO?=
 =?utf-8?B?cXdvQ0xaNmFFWG1Vc21WWDZuWFY1cG03ZjZ1TXE4TDFGbE5BeUpiQ055R0Rn?=
 =?utf-8?B?RGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 15:15:08.7171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0c957e-7e21-4277-d64c-08de327ebf40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101



On 12/2/2025 1:12 PM, Gerd Bayer wrote:
> Clear hca_devcom_comp in device's private data after unregistering it in
> LAG teardown. Otherwise a slightly lagging second pass through
> mlx5_unload_one() might try to unregister it again and trip over
> use-after-free.
> 
> On s390 almost all PCI level recovery events trigger two passes through
> mxl5_unload_one() - one through the poll_health() method and one through
> mlx5_pci_err_detected() as callback from generic PCI error recovery.
> While testing PCI error recovery paths with more kernel debug features
> enabled, this issue reproducibly led to kernel panics with the following
> call chain:
> 
>   Unable to handle kernel pointer dereference in virtual kernel address space
>   Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803 ESOP-2 FSI
>   Fault in home space mode while using kernel ASCE.
>   AS:00000000705c4007 R3:0000000000000024
>   Oops: 0038 ilc:3 [#1]SMP
> 
>   CPU: 14 UID: 0 PID: 156 Comm: kmcheck Kdump: loaded Not tainted
>        6.18.0-20251130.rc7.git0.16131a59cab1.300.fc43.s390x+debug #1 PREEMPT
> 
>   Krnl PSW : 0404e00180000000 0000020fc86aa1dc (__lock_acquire+0x5c/0x15f0)
>              R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>   Krnl GPRS: 0000000000000000 0000020f00000001 6b6b6b6b6b6b6c33 0000000000000000
>              0000000000000000 0000000000000000 0000000000000001 0000000000000000
>              0000000000000000 0000020fca28b820 0000000000000000 0000010a1ced8100
>              0000010a1ced8100 0000020fc9775068 0000018fce14f8b8 0000018fce14f7f8
>   Krnl Code: 0000020fc86aa1cc: e3b003400004        lg      %r11,832
>              0000020fc86aa1d2: a7840211           brc     8,0000020fc86aa5f4
>             *0000020fc86aa1d6: c09000df0b25       larl    %r9,0000020fca28b820
>             >0000020fc86aa1dc: d50790002000       clc     0(8,%r9),0(%r2)
>              0000020fc86aa1e2: a7840209           brc     8,0000020fc86aa5f4
>              0000020fc86aa1e6: c0e001100401       larl    %r14,0000020fca8aa9e8
>              0000020fc86aa1ec: c01000e25a00       larl    %r1,0000020fca2f55ec
>              0000020fc86aa1f2: a7eb00e8           aghi    %r14,232
> 
>   Call Trace:
>    __lock_acquire+0x5c/0x15f0
>    lock_acquire.part.0+0xf8/0x270
>    lock_acquire+0xb0/0x1b0
>    down_write+0x5a/0x250
>    mlx5_detach_device+0x42/0x110 [mlx5_core]
>    mlx5_unload_one_devl_locked+0x50/0xc0 [mlx5_core]
>    mlx5_unload_one+0x42/0x60 [mlx5_core]
>    mlx5_pci_err_detected+0x94/0x150 [mlx5_core]
>    zpci_event_attempt_error_recovery+0xcc/0x388
> 
> Fixes: 5a977b5833b7 ("net/mlx5: Lag, move devcom registration to LAG layer")
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

Reviewed-by: Moshe Shemesh <moshe@nvidia.com>> ---
> Hi Shay et al,
> 
> while checking for potential regressions by Lukas Wunner's recent work
> on pci_save/restore_state() for the recoverability of mlx5 functions I
> consistently hit this bug. (Bjorn has queued this up for 6.19, according
> to [0] and [1])
> 
> Apparently, the issue is unrelated to Lukas' work but can be reproduced
> with master. It appears to be timing-sensitive, since it shows up only
> when I use s390's debug_defconfig, but I think needs fixing anyhow, as
> timing can change for other reasons, too.

Hi Gerd,
  I stepped on this bug recently too, without s390 and was about to 
submit same fix :) So as you wrote it is unrelated to Lukas' patches and 
this fix is correct.

> 
> I've spotted two additional places where the devcom reference is not
> cleared after calling mlx5_devcom_unregister_component() in
> drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c that I have not
> addressed with a patch, since I'm unclear about how to test these
> paths.

As for the other cases, we had the patch 664f76be38a1 ("net/mlx5: Fix 
IPsec cleanup over MPV device") and two other cases on shared clock and 
SD but I don't see any flow the shared clock or SD can fail, 
specifically mlx5_sd_cleanup() checks sd pointer at beginning of the 
function and nullify it right after sd_unregister() that free devcom.

Thanks,
Moshe.>
> Thanks,
> Gerd
> 
> [0] https://lore.kernel.org/all/cover.1760274044.git.lukas@wunner.de/
> [1] https://lore.kernel.org/linux-pci/cover.1763483367.git.lukas@wunner.de/
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index 3db0387bf6dcb727a65df9d0253f242554af06db..8ec04a5f434dd4f717d6d556649fcc2a584db847 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1413,6 +1413,7 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
>   static void mlx5_lag_unregister_hca_devcom_comp(struct mlx5_core_dev *dev)
>   {
>   	mlx5_devcom_unregister_component(dev->priv.hca_devcom_comp);
> +	dev->priv.hca_devcom_comp = NULL;
>   }
>   
>   static int mlx5_lag_register_hca_devcom_comp(struct mlx5_core_dev *dev)
> 
> ---
> base-commit: 4a26e7032d7d57c998598c08a034872d6f0d3945
> change-id: 20251202-fix_lag-6a59b39a0b3c
> 
> Best regards,


