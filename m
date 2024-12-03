Return-Path: <linux-rdma+bounces-6183-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CB39E0FA2
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 01:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF1F28376D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 00:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0D41FDA;
	Tue,  3 Dec 2024 00:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VdPaLIbO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4135410E3;
	Tue,  3 Dec 2024 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185530; cv=fail; b=EzCjFCBo4+Jo9XfoP3SrmAwvlxI62hhqrqI7P4toLDbx+kfaH3+bTQLW8Yew6LIXK3gAj7/F1r5R3BZwEtAAq5c0YXEWgolddqVCDVuWwGlnZ5W5OgFmmsNEXBW0As4GSn4yZiAsH72zkQfzW2wQNNaIfKjTBwtDxUurNmoL9Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185530; c=relaxed/simple;
	bh=cEEPpdw36R6zJB4MzPGquQ3Hkmf7cAtW9jHlgbb4syA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gSy16xiYp18KrnL4dbOZa9OtdM4e7vtXCc+zkSX94LKWetJ+j7GVbb+UrUx9zSjmkSC6NqGbnb5rLCXTs3sCnywDBwNryYWyg7owIfKKzzt25U2akPlCobYaoDhRJzitnIbxYTSW2whpiU+NREaflbO3DYYdGnFeSQgPusvSdmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VdPaLIbO; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCB4JWYyF0pvjirZMR1d1NDq0MSP3nFd7NShBcfsYYjwyDbXfnfbLvczwqN5FUgO9UVx0Fm634VBMvNmxuw3H1HswU0DELaXl/DEhsK6lixyDT0K77fEmgWKoi3ZSEtZSbqpt+HnnF4rszAJDEHRDu27NKYdxRCPtmw9GOxu/bF1eDoabn20BPxMUfpvQ8YaQB1TOSHemvhMWIUkfmO9ujQOvJYhKHVco9TnH464gkCBv4AvfdqxCDBL1CNJIfPMOoLL8rW8P0GcH5HZredSs1ICMfkt02ZaV4t71W/CkiO2LQ0DT9x9uIdcHrvqaccfHp/8L6MWPp/zFqBLs7tR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY7IwyLvj5euE2GyiKwi72uMciVntv7+B+/5iMNzQho=;
 b=V53ZeeuvtBAL74u0FJDdwMtZgbfIZwCA/Ugin+8X+Cnw2v5a0v9aaroiGzQSceOPGfu2ukIL5fw/GK9pgRZVVycNLC96mr8g2ebwCaN3cW66fnvbwiGqZ7jUxM0CKsc13AryaS3W4rV2by1ka/i1KjZx3fBKCf2g7zJfp+bV3ypnxnxGB4L1F0M5xPgL4cd/OVdhDoff5PKTnq/4dD05+04/IMrFuayAA4/Lkvzp5ziuBXoZHoM5Lb2lldaxjnzs9dnSZssI2cN4J3mJ9yhqy0tL5cMM7ldTufSJ7mXnmioChOemCOTHvdDbJH879DzqkWRZzmOHFGG3iY8pb31QHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY7IwyLvj5euE2GyiKwi72uMciVntv7+B+/5iMNzQho=;
 b=VdPaLIbOIOWQGxutapro+6yQrUsK9aTsxHAVmcUTJg2ID18BiwF6uXUfZfxQ8wZDQ3DMu/5ify5LR4xRrka8D206tk1CHtoYTDovNiTeUEYLguGpuvrT2tfam4K8Wq5nioCuvsms+zUcwGkargY/s0ZGYR1A4HPZpod6zxfUn1TEIk5p6TAl0J+tRxiM04NCKgOBQXu+slugo+zlwhXocUdaVP3pV0GCSHP7/Cwpqvb/v4sw0jckqj2WJxoaZPKO6ZzJX9BACmtyMEt7lOdkhKJHZGkt+G+pTuNeRrDUrYqFiX0YnvhcEfxq8kZKcYSL+4P8hZaKZmzvRJIUBll/HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 00:25:24 +0000
Received: from IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43]) by IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 00:25:24 +0000
Message-ID: <b356f75e-91a2-49e9-81f6-413745e9c33f@nvidia.com>
Date: Tue, 3 Dec 2024 02:25:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: DR, prevent potential error pointer
 dereference
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0042.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::7)
 To IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7722:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d55ae8-f472-4a6e-b85c-08dd1330fa79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L29HUmI1WXhaL2UrcWZPdGdJaG5qT0Q5T3I3SWNZZ21sM1JmZnhlODhHQkNt?=
 =?utf-8?B?N1d4QklGUFpDK1pwczI0eGlSZ0c0WXFOODFGR2ZWb1Z2MkVnTnlPTEhRbnlr?=
 =?utf-8?B?N1c2MGlKVytZMWhsaXJFK0NMR0VaWm1HV0FTUzc0N0JZN0RFRkM4QVJ4L09o?=
 =?utf-8?B?V0JDSnB3Z3dCd2dBbFNzQXJlVHpOcE5jSm1KaXZmeTMwb2Z1cTRPeTFXUldS?=
 =?utf-8?B?VGR0c01wTEUwUmNCSmhTbWZSeTlDbXlqODNyUlk4UGsyNWNDRHBtc1V2SFk4?=
 =?utf-8?B?c2ovSEtWbS9rWUFvSjRXT0YyWWhTRDFwblpsSTJPUzhlYW5pM2FIeVBKYzNH?=
 =?utf-8?B?cGZzTmt0Z0VRTHpkVWZMNlo3N0hNZno5Mng3dS9EVkNJcVFKYVpTVzhhM3lL?=
 =?utf-8?B?R3QxdllnOUxFTS9hejF6R3A1QmQ4WXpJdi9MeGpRSzJLT3lvcHNNMmR5TjV1?=
 =?utf-8?B?VFBveVRmQ2lrZjgzWEVMWUVCK2dQcVNuSnAvRWhsQm12dGN5cURSNEVJd3dw?=
 =?utf-8?B?RURwWCtPNFNaTVJ6MzBhU0xxckpyd1VHWUU1S1pnZk0rMU5BRXd2dy8zOUJV?=
 =?utf-8?B?RThVNTY0WXJNVXJjRFlBeDFtODhmaHNHUitzSTFNYzI0ZHUwbHZSYXlzenpS?=
 =?utf-8?B?anZOK21wRFNzdDg3SEFsVStISTVNVkNlUFRXeEdnR0dHYTY1b3ZydGFoZnNF?=
 =?utf-8?B?SEljZ0cxd2w2bjNzZTlRVDNKaVRlZmlvMGtuL09Wa2JpT1dOemppZXhBeFFN?=
 =?utf-8?B?dTdmcEtKWTN2dm5vb0xpTEluM2lYZGNpejFscHNmOVA4T1QvNm54Vi9QQ3Bj?=
 =?utf-8?B?eFpvWUF6VGVIbWh5bE9hdEdVLy9scDVpalg3eEFMODFqekF5NjhJNitCMmVk?=
 =?utf-8?B?UTlYYVpBQmFNYlBiYnpabzN6cjYzQmphbzUxNkVUckk5TG9ZeHl4Nk9IYXJ0?=
 =?utf-8?B?N1NqZ1J6am9XSGg3amRCVysvc1Vadk4wWWhiYXlWcDFnNUZqY0tMejJaeE1D?=
 =?utf-8?B?SzRNVmdHMnp3dHpzV3JlOWxlUHBvRjdUaHUrSkV1dlpNMFhUdXAvbGRzL0l6?=
 =?utf-8?B?ck9wWkFqcERaa2Y3a2FTKzA1OWd3MWVmUitzOVhrRnp3eGVPQ1lGOGJjN3JK?=
 =?utf-8?B?ZXhnalZ3VFdZd3hrU0VVWmpnMmowWGptR0tHMW55QmpXby82aEF6dWtTNUxE?=
 =?utf-8?B?K0l3L284akl4UUxGeTMwWlNRdG96WU9oTThDVEQzRnFnQkk1M3ZaZ1hFSStY?=
 =?utf-8?B?UUJNV1F2UUxQa1JuaWRTYkhJVHA4MlA4aWJTRXlTdy95bXRsWGJ2K1k3bUxs?=
 =?utf-8?B?SXVPa2JRZzgrRjVveWlSSW5LR2s2MFZldUQ0bW93RnB1OWNjSGtFQzVVendW?=
 =?utf-8?B?ZXNuRDdnV0U4NXhueDhLOXhiN3JMalYyckJZa2NYRUt2dzErUDlwZnlLdW52?=
 =?utf-8?B?ZTVZSHlpR0JiWjN1MzNmbkVKRysxcmR1bzhZcGttM2o1cVBGbUc0TlhXRmpi?=
 =?utf-8?B?b1FqWmFjTjhHTGlyejdRTU5FZ3dPY2pYczVNejlsMUpxOXV1WDVsNnpSOFgr?=
 =?utf-8?B?Vm4zbHROS09oVW4xWUpSVmZVcWlNU1VmUDRQbUs2UThHVm5IMzRBekdNaW9G?=
 =?utf-8?B?cURnWU5aekNKYWNkaXZuNXZqaDVBUEVYZGtpdjNja2JoYWJ1LzJpVXVpakNI?=
 =?utf-8?B?bk5IcTFDQUIxZFJuNDBXdzNFRW5Relc1cTBuUE5uZ240VXdzMDVJV3pHZThi?=
 =?utf-8?B?YXVWMG1XaEV3THpyUkJTOVQwdnZsYTc5YWpCQXd0K294eVEzTVc1Yk5na3Vz?=
 =?utf-8?B?U1hXSWtUK0RTU2M5ekx5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjM5V3VWbTFIdTZKOVlRb2JpY015QUNod1dpQVBtVTFobXBpMzFyc1JkK1F3?=
 =?utf-8?B?dzhwK3N2N2F0eDR1cmNCRnc1dCs0bFdaTnNZNHBvYWhNbXJhNDlYU0x1NmU4?=
 =?utf-8?B?QzRYVDI3SkpLZE9GcVRCTXpweUthYUFlNmVxTkk4b1R4SGV4RlU0RVBadUc5?=
 =?utf-8?B?eGtnR2UwcDNlenh0SDc2TGE3M2dpTlZNbWxuaWhyOE1obU10RkdQY1V3M1o2?=
 =?utf-8?B?aG94UjVhakNYNmFGdGloZ0ZtSkphamgxVDF2bit1dFE4bVY5VmFzd3dyMGFm?=
 =?utf-8?B?SGJ5SG9lbWg3SGkxZGpKM29JMkkyK0d6UTdBU2FSN3kydzFVQTg5VDBaYWdx?=
 =?utf-8?B?N21jaEJ0Q3BnbHdjU0lDNURBTTB2YWRIdkx1Q3owejdKMTQybkZ5c2VVOEE1?=
 =?utf-8?B?ZzkyaE5QazYyTmVBTXpzT21OcmVSQm50YThrUDJ4TVE2Q3pwMHdqbDZHL0dE?=
 =?utf-8?B?T21lNmNKeU5vNjJSN2s2RnBVMVRJZnJzMDVDRDBvMVIrSnVpd3JHcHR0QUpJ?=
 =?utf-8?B?dVZhTVJhbTZWVUdMZUhOWGhSZ0E4MkNsWXIvTDBqTWpRelZFWDkwTWVsZmxv?=
 =?utf-8?B?Yi9PTGI4VkJBc0FSd0lQd1JEajcyYkJXOXlTcVR0WVJGenhlcExIcjQ5Umt5?=
 =?utf-8?B?VTd2bjF2VDkvSzlrQjVnbkdUL3pDdFJDRytSRkxwUE9SVDYxQXZqSlBGNmp0?=
 =?utf-8?B?VVNNQjc3WWx0QUZUVzlPTERxdng4bmh5bmRWajR1U1J5ZzBPOFdFZVpDSkNJ?=
 =?utf-8?B?U05mWDc2VWV0RU90UGZ4K011VUVINnVHVWJ6Q3Vmc0hCNy9mcElqKzNHUURT?=
 =?utf-8?B?aGthbnh0U3BPeUdXYjlIV2lBZXF3VTRDcmZNa0dHbXNUZ2hFaFUwSEg4eWFv?=
 =?utf-8?B?U3pJbm1xeUJPaTRKbk0yK29JUVN4M3QzVDVDQTQ3V2oxdFZQYytabHNJcHZu?=
 =?utf-8?B?ZDlMMDlFVlVsOU16Ni9sN2crL3h2NmJQVGladzhsUWpuK2Zia2xaVmhZRFU1?=
 =?utf-8?B?M2ZGVjVUOE9TQzkxdk5CWlVzVXJPR2NxQnVUYWVMVDc4VGFhUmJCWFY4Z2s0?=
 =?utf-8?B?V3ZYOUJIM280bHRvV3kxT2lZdXc4Yld6WkFuTU9uMlZsNlFPZVpOTjBqSUYz?=
 =?utf-8?B?R1dpejVZdXUrMHJQMkE2T3hrL2puMW1UaGJGRldzYnA5Z0hIVkx3Y1lhaUsr?=
 =?utf-8?B?dzYvY2NFaEV4NzIrMWlWUWMvSlF5VVY2RTNWdVhyMCthNDZsRHh3UlR5dkEx?=
 =?utf-8?B?clZBR3NXcG9jaDdWckZ6Vk85Q1lGeGU5ZVFpQnpqdmxvYWp5WlpKay9Fdldt?=
 =?utf-8?B?d01mK0oyWDdtcyszS1p6Sjl1K3Y0Zm9NdzN6Y0RScWIzR2lMTFBQaHNIWE1o?=
 =?utf-8?B?WG5kdm1kQ1dUOFhPY0I1RThOaEtLZGtWMWhPUDJpQklKallUZll6WFp6c3kv?=
 =?utf-8?B?Z093SzNaaVZLanRXTWE4N1dnV0NKOFNndndqb1h2WFZiRWpBZFVnNHl3WjRX?=
 =?utf-8?B?blFtcE16dERPUDNXV3NjL2E1UXVvSXU3Z3B2dzU4NUZoanZ5QjhpWFlrOWxQ?=
 =?utf-8?B?bDdiYkw0VUVuVEVSRlRNVTh0WE1kUXZ0U20wWjZoN2VDdm9sVytGNFpZTG54?=
 =?utf-8?B?cnk2dFJXNkNXQlNVcHBOdENvc2poclBaNUxna2c2T0dlaFdGVTdCM2dTSDIx?=
 =?utf-8?B?MXhTV0ZPbGt3c1I5bUYrZHdBdmE3RW5LSjVHMmRQdXd2OTROSnZkcGJQTHQy?=
 =?utf-8?B?WUwxMW9wakZkNzl3dGF1eVRPQnA1MW4wMDNOM3VFdmdkOHpyZHRyT3NHL3Uz?=
 =?utf-8?B?YlFjSWpGWTNiVmtLODlXK1lzNFBUa0ZheUdrRk84dk9ES2tYbXo3Q1R1OHJD?=
 =?utf-8?B?aEN2WEVvVWpXVkFWRlBiSWJYeDR2N2Zra2g1djBtUm9STU8xdFJheU5HNDFw?=
 =?utf-8?B?dmwvNndEMXFxek56cW1Rell6RFh6SkRkeTRrcUpiemxiTmRXVEpQQ0MwTTdP?=
 =?utf-8?B?ZnEyZUR0b3E5Z3RMR0ZvcUVzeWhDYVQ1eGdadHIybFRqSHlOWHdGT0prUlY4?=
 =?utf-8?B?MXdTaWtpVTVZU2dSSWNFNmNrTnQ3QXlGcE5TY1dnQUx0b25xOUJ5aGV4Rkc0?=
 =?utf-8?Q?HYSEZRg3ETST1IEg+5glvngcr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d55ae8-f472-4a6e-b85c-08dd1330fa79
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 00:25:24.0768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auB7S37keU8DEv3PP3XaBHNj4zR995XQifo+ydKuxpgrK3t8naEOH4JVUNNOaHOzR/bwXsl3kNkHii3vFUjw3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300

On 30-Nov-24 12:01, Dan Carpenter wrote:
> The dr_domain_add_vport_cap() function genereally returns NULL on error
> but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
> and if it's and -ENOMEM then the error pointer is propogated back and
> eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().
> 
> Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c    | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> index 3d74109f8230..a379e8358f82 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> @@ -297,6 +297,8 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
>   	if (ret) {
>   		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
>   		kvfree(vport_caps);
> +		if (ret != -EBUSY)
> +			return NULL;
>   		return ERR_PTR(ret);
>   	}
>   

Thanks Dan,

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>

