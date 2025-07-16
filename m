Return-Path: <linux-rdma+bounces-12212-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FC7B06F25
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 09:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38715061F6
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C8528C5C1;
	Wed, 16 Jul 2025 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upu4IN/9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498C2528F7;
	Wed, 16 Jul 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651537; cv=fail; b=nGIipbSBOQ+gTXNzfeUdsSXJu60DrfQOcwK+2fJQgdD1y8Jy8Im3W8nR+6UTvJvQLeisXzjBLsuuiS3z0GYINKWkEt9DUlKi+6vkOgM2kQ9d8gjBm2dAQskt9jpOOd3kW48tsbiLwVm/825bFuG/ySOymXEOvj9QlVlVvngeAnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651537; c=relaxed/simple;
	bh=SdEz9vyDgU9BZJuWE4hT2OAt3FoM6GFXUaWpEUf4xY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A9daftWuudoigjJszxrOo09Cw7wH53buAz3sZ7WG+dKt21ArLo72/RI3+15leUhNtIsyZgZiUPUxRgM8/gzfkQb9UDa0Hk5rMLzXUlhRxOhcV6k5lt8G2Z9Elb8VByOp1cxTYGwaYqtkKa4GNMqHDL2+DlLCv+eIGUR7iCfRaAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upu4IN/9; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7fkpk7awmq4440rSDODqQAWTQterczkR3vHDoCUzuHgm5PYORVeVZCPiX2xC6XoMw9u5daCAFC1y/iYJEm12pI+XmFHgJZo4KQzaj3/p97p0fPnGN2xkOvangYtzD+LEWGQFwpa/1J6l3V5Yd/e6ZsP/jrip/+8Yv8GyXq+ZzsGIwbdUBbVH5wlkfC1DzF5H2f8WfGbg7tkL4yxl++bQBDDDa99Jssza830TKZ+nXZLbyJgJ0Hs8ccWDHSzb1SFztHa+aDOLwgDprOQR6GFVgyZmoVQbaOMI1otBs6vi/1n5Yl/sBeIMULpnwB/H8ZL1gH9fGF0abtz5iOysws2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1qI2VXp6wLjay3nNaWNEr5+nI22SWfnhBvCr3HkW0s=;
 b=jqO+nluU4jMrs3t5IaspyFZstnMuuUqNd7CmcBHnF/p1ZvOq0N8hCgE1LuEl8A7+i3Z1sH0WbCwDNAfx/xBR0RSY8K4LRKu3H5cctxM2n6K2OoyCEtf6C+0Oh/kc0vSz3eM6fFFYF8Q/5RGTSBT5JhzwTRzdOEItQND0nOyAeCG9CS31Pj7Q+7P3Ww5BgDr4g/FIfzCM8b5xT6i8KmveqAIPPAlMyruRTiue6lyWHsuJ10exhLD571diTGDoluIt1MG6esjMYzw/mFJoHlf4nJgSP8hcNnnhouy29PbIZv4LIgKw+AJM46E8cp6r9Ud5ZlVG9NXfoXMVOmsGUZDNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1qI2VXp6wLjay3nNaWNEr5+nI22SWfnhBvCr3HkW0s=;
 b=upu4IN/9x4PYx8Jzdma/mDk6kFV5rqiqlLifgetMtimIV7vkymn3wT+SySHzoFqunjUtLoMsgws52IRlCPa9T0FDnDlYYGM1SrYICEqIYIIko5cg3Wpg/fq6qH0OQmMR2LDIgQkLORH+IW1RR3JAteItj31o6xFloY2mkTY5DtCCNyjE4IFuYNFdDMTs8FXtv++Ofrcyf4OfFoCAJNgS8MMd/AzspByZJ/W9pr9HZfZrbDkE4tZLLmC7APU4+VfR6henwKnkd4pU3abvkWoOr0qB+UwunFCFfjnUL3shkOHqtjWg6NZqJX5T+csxghW2tGRMY9GePuwjJms9YJb99A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:38:51 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 07:38:51 +0000
Message-ID: <d1ab8d54-e524-4b83-bc1d-3f89e47b6237@nvidia.com>
Date: Wed, 16 Jul 2025 10:38:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5: Correctly set gso_size when LRO is used
To: cpaasch@openai.com, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fe6b3d-48a2-44a6-e5c9-08ddc43bcec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUh3Q1hzdjNVVDlFTzI0Wjd5U1ZjNG5wZkZ3WTVmc3kxRlhMVmI0UVJiMGUw?=
 =?utf-8?B?eDcvbFZRZEFMOFN5OThRV0JyaktBYjE5cEVNcyt6L2UzSGQ4U3RLbzJlMHRy?=
 =?utf-8?B?ekwwdTczSmh4Mjk0QmljRVY1TzV3ZTU0SFd3a1ZsVzhqak9qaTIxMnN3REZp?=
 =?utf-8?B?T2ZjR1VDcFpIUjA3WDRYVzdtRmdTZEFKS3YyS0FIMDM1Y3hnWXpGS094SlM3?=
 =?utf-8?B?THNybFVmR2luQzFiWFZmSnR4c0J6L3k4MWdUK0tKNHRPcFNQSWNMVVNLd0cz?=
 =?utf-8?B?MDNIeXJUVlNGOUUxZ1pFUFIzbWRIM3g2cWp5Wmk3Mm0vUExMbVVNcXFGYWxX?=
 =?utf-8?B?MUJkTElxeXZYR1dTMk9zR1RKbGJ3MFM3aGJpcURLNUE2UE5vN0R1MGE1RXAw?=
 =?utf-8?B?cytuUlFadE15Y1FtTXVuSytENnNmT0dNZXN5KytmUElXaG1BUlV6QkRENm9X?=
 =?utf-8?B?RmVrZHpvbmRNUjh4bWNuT3d5ZTVjVDVCQWRydnpjVmFGVzFkdFBrT0VWQTla?=
 =?utf-8?B?SlBhSjFNVWdHemhWbEZnWk4wOXd2YzZTcEhWNk5pY2JRYTBBQWdjMVEydTVq?=
 =?utf-8?B?VDJJTVBOb3krQjFmcjdtNnE3QjFSTmkzU1Y2ejFwK3lZdnhCdFA0Z3NMbldF?=
 =?utf-8?B?d1RmQW0xZjdtUG1BcmVXYkhNR3MyWlFMaDdETmNldlJ2TmpOcUpqQU5lRXRv?=
 =?utf-8?B?OGsrNWpPMC80b2xhL2ZrZlYxMFd5eDV1Zzl6VFRNWkVyY1hoNU1lVWNoTTcz?=
 =?utf-8?B?c1FqL0VZakhOTDRVVVh0WmFFUTdPZXhDb0lTSjU0MEQveEU5bzFDaHNxdTJu?=
 =?utf-8?B?ZXhvMllOb1JuSys1ZDBQV2pJQmxZeHdVOEFWcXNQLyt2aURwMlkybGVBN3pt?=
 =?utf-8?B?UHovM0hIcWcyWVU4dkRyVmtGYmVwWEJWZ3p0c2I4Q0g4OEZnc2Q0dXZ2ZHBY?=
 =?utf-8?B?MXJrSGpBTzQ1dVQ4MEFGb2dLOWVNZk1vMFhDUC94VjZyaWhuMnFCMlc0aUFQ?=
 =?utf-8?B?eGNXWEs1M2N0NUJaUUlvZTJ5Yk1JaVI3aktCL1M5NnBDTWREaFQ2c0ZxWFky?=
 =?utf-8?B?bkwwUGxIcEprSmJvVGEvUVFiS210M2MzbW9ub3l5bnpPODZ3YTZxbDhtMDNS?=
 =?utf-8?B?Y3M4cUVwWkZjNnBnQjArMEpHdjMwbWNZVHROT2lJcUl5cmNIbUd3dUg0ZkIy?=
 =?utf-8?B?QWUwbDBIN2hINjNMc3R5bWE2RVpkRjE1NUZNWjYwWm1CQjNVaWxCTS9JWVkv?=
 =?utf-8?B?OERGam5OTm1oRU1FcmxOL2pnclNhZ21qVFpMS082c3RXOVYzREtENU9jQ3B4?=
 =?utf-8?B?V0wxWmwya1FHZjh5SDFCbjZueEI2VkQ4dmxNZHpYL28xTm1CVEx4ZDJKcWRS?=
 =?utf-8?B?OENZZ2ZIYlN0Y1dYVDdRODV2K3JWUnYxeDJCSG5QY0laNlZFcllldTArSmJ6?=
 =?utf-8?B?OFgrTFFzekRlRjRFMjgybDVSLzFZU2VRVEdob3ZGcVpvR2pPeXQ5a3EwNnNK?=
 =?utf-8?B?TDFLVVo2WmtJeEx5UFNWWXFnaXh2a0l1dUtGV2J0YnpnUzdta2R3MHBJTnJv?=
 =?utf-8?B?OG1kbWZJSjBCUlVXNXF1WmN3OXJFb2RabUxhQ1g3VlBkS004cHV1R2hnekVi?=
 =?utf-8?B?Y2lIVlNmalkzMzVKQW9qZXhZM05aVVowckU1UUMwdllaNWZnZXRPeWRZSnlG?=
 =?utf-8?B?TXplTjVwaW5HQkxRVk9FZnZEVXhyOTFSU1p6Z2tNeXlPeHE3Rmw4N05MaEN6?=
 =?utf-8?B?TEpBQm52SU10RDhvaVMzOUE1R1B1RTRyaERYaGVYQjFENndzengwR2hwdXJi?=
 =?utf-8?B?aXozbnN0dGFEL2U2NXJaTU5SbG9KVkM0VXVKaGo3dDV6ejMyaEFNUnBWNFg4?=
 =?utf-8?B?YTVBMGxWcER5QW53S3NCQ2VTYnpOYy9DVEFuVkJGQTVLN2VXbGNnTWNDUmEy?=
 =?utf-8?B?OHltcmNmTmROVlorQnphYkk1cm93RHVnaWtkWGc5WDFSaDZpNXhpWXVoa045?=
 =?utf-8?B?UHgrSHZiNVpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU1TaEdyU3NkYzZMKzk4VkJSa3dUR2tRclVDSUt4dVpWdjhrcnhBNU41UDVI?=
 =?utf-8?B?aXBFT1U5MnZIQVJtMC9MWnNRUDhHcHRHSWxDOEFTOE1TUkR0YWt3RVlyRXJN?=
 =?utf-8?B?SHJ6azg5eDFDQ0l3TGxkRDNlbTNSdU95VndKTUV1Rm55YXhPVGlTbG5tWVp3?=
 =?utf-8?B?UVNOaUZCTjU2Qm8wanNXTzFpSUhuc1puVUdJdzZGdFUzVk5QcnhZTFNjcEJh?=
 =?utf-8?B?QnFpeGZGaFVpN1Z1U2E1OE1jTWJxMnFvcWpPeG9jQmxBeXM1UmY3d2EyMzN6?=
 =?utf-8?B?U1I5QUY4eFVkOGFQOW8rSXNXSnFqcGMyam82WWcrYXNSdlFablJVZE5JTDln?=
 =?utf-8?B?bVl1dHYxOEU1a3dxNzkyaCsyRWxYTnpQT0lLRm5YYlIrMjBXcGczK0p1cDA0?=
 =?utf-8?B?cXphUkdRb0ttWjZLK2tSdE5qZkJ1M2RVZlFsWHRpMWZqL2l3bmF3S0JVcVMy?=
 =?utf-8?B?L0Z5aFNXRzZ6alQ0SjM5NjltbGliZHozZUp5R2duK2lwejBhR1liN0VOY3Ru?=
 =?utf-8?B?em5PMlVYWnhLQzNTTGxkWnZJY0hxNm5YaXpIWnpSNUlNUmY2cGIzb3dOdFhV?=
 =?utf-8?B?UkFTRXVHdVJKZHNmZVpWNjRZNkp4eWh3VDRWM1F0aCtVTFltVGhXZlQvNHdw?=
 =?utf-8?B?cE0wdS9vMGlJSjJuUXg0NHZiZ2tIOWtYSitJNkIvUGIrNmRWZy9paWk4ekha?=
 =?utf-8?B?aG9lZkVkRHZxRGNVd2J1TjNuWkU3c3c2TDBpbVlLVDd2alQyWG9MTnladE05?=
 =?utf-8?B?WDJDZzZrR0RjZ1NwQllJQjU3TXBqdzlocnNsM1FCTSsyTTdPSE0zTVc1RExh?=
 =?utf-8?B?VEpwKzc4Q3NyY0lUeVlOdUkrK29YWmdrL1BzOWVuWWF6U0NsdTdKSzM5OVRZ?=
 =?utf-8?B?T04zKy9hVTQ4cUJIY2xRMmtYK3pwZWRHTWlnRUtjdDlMYWUyWHYzV2dNZm05?=
 =?utf-8?B?Q1F2b0RQeWdwQmlCbFNTSzhpS0lNTHBIK0Zld21ySzlHQ1ZINlgvTnVzR0N6?=
 =?utf-8?B?bXZuRUU0eEZTMnhoVitvVGt2YnJaS21iUzhaMSs4dHYwMnlHRjJWc3pTUlRZ?=
 =?utf-8?B?Q1RDZEZsMEV1VUplcElIRThoUTJSNEx2My8zMU9oelljS3dBb21PZllnU3dE?=
 =?utf-8?B?dnQ0b1VxK1NzRTVMVkZrVjNmdkVrcWFZcVBlbTdtWDRRZUYxZDlPZXVjV3pI?=
 =?utf-8?B?cWJHS1NlRHRFRUpDVXY5dlZTVVhBcG5xZU9mNDdzQkkwaHNHdFkxL0ttWjkz?=
 =?utf-8?B?OTB6TzVzR25sazdyK0YzUERQNmtTOG9CRThSbmx0THdjUmxFbGE2T0pjaFJw?=
 =?utf-8?B?ZFlMb2p0NWh0NlNkZTFheXM2VVNwdVdxUUFNby9wakxPSHBGbVBCNWRtc1Vi?=
 =?utf-8?B?SnBNZ05pRUU2R0pJVml4QmI2RktOQ1lrbUNpeVhBTENlcEVHNUlQYXhtNGM5?=
 =?utf-8?B?QVFKRlFNYlI3YUNSSFpkOE90b05JbDNOQXM1eVVQd3JMRFd3b0o4NmJyMWVW?=
 =?utf-8?B?cTg5UW9kOVpBTFVGdXZsTHUxTjZrUXlLL3FqR0Q3eDRhUWRTQXdVcklQODhk?=
 =?utf-8?B?ZkMvUFoxMEh6dXJPK1ZFOXh3UmdBeDB4RENWb3Z1L2t2NE9oZ0taWUovaHRH?=
 =?utf-8?B?VGNVcEgyQ1Z3VGVXYnRyYm1IR2gxaDU3bVlIanJDY3UrZFhnSDd3MWdVOHc0?=
 =?utf-8?B?MnVxbTVZNEplQXE4Y3prYjVNSSt0dHRhMTlOdW9yNm4yV2NWYUR5MlJ4R3FW?=
 =?utf-8?B?MDJzME13Vk1qUGhTMFpkWWR6aUhuaTFhenppekpEV2loZ21sQXNHaHkvZWdq?=
 =?utf-8?B?SlVEeHFlRm14cnZlQU90SVA2c0hoQUN0L0JrVTVrZCtrdnhDZXd3WmRBWWtT?=
 =?utf-8?B?enhJdS9GZm1MYU5EUzdqTnlkWEM2dEUzK1FyZExtdldrSWhCUlhrNTlDMXph?=
 =?utf-8?B?bHBCS2lkNDJkOU13dkxmOWU0S1dxaUJvL3VnS2xIbnhHZ0t6dDBOV1JsaDNW?=
 =?utf-8?B?WkZMbnNoaVgyMTc4cjQyc3FHSjZqSUhTVU0xNHZjNnEyNjdmc2I1Z05IU29P?=
 =?utf-8?B?NUxldzI0d2JEVnFjU0dSbHJJK1VLeFcvcTNvWWhGQjhBTUtEZHNUbU42UndD?=
 =?utf-8?Q?jngFCATNZO/hmIWPk+4btbvtA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fe6b3d-48a2-44a6-e5c9-08ddc43bcec8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:38:51.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhw3zuBbbbqzaQ8miQEhjd73hsHohn2r2fnUxDlsqFRE53oxvf6z9fBv1vW0AE7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

On 15/07/2025 23:20, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> gso_size is expected by the networking stack to be the size of the
> payload (thus, not including ethernet/IP/TCP-headers). However, cqe_bcnt
> is the full sized frame (including the headers). Dividing cqe_bcnt by
> lro_num_seg will then give incorrect results.
> 
> For example, running a bpftrace higher up in the TCP-stack
> (tcp_event_data_recv), we commonly have gso_size set to 1450 or 1451 even
> though in reality the payload was only 1448 bytes.
> 
> This can have unintended consequences:
> - In tcp_measure_rcv_mss() len will be for example 1450, but. rcv_mss
> will be 1448 (because tp->advmss is 1448). Thus, we will always
> recompute scaling_ratio each time an LRO-packet is received.
> - In tcp_gro_receive(), it will interfere with the decision whether or
> not to flush and thus potentially result in less gro'ed packets.
> 
> So, we need to discount the protocol headers from cqe_bcnt so we can
> actually divide the payload by lro_num_seg to get the real gso_size.
> 
> v2:
>  - Use "(unsigned char *)tcp + tcp->doff * 4 - skb->data)" to compute header-len
>    (Tariq Toukan <tariqt@nvidia.com>)
>  - Improve commit-message (Gal Pressman <gal@nvidia.com>)

This usually comes after the --- so it's not part of the commit message.

> 
> Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>

Reviewed-by: Gal Pressman <gal@nvidia.com>

