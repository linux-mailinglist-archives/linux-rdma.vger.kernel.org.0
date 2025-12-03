Return-Path: <linux-rdma+bounces-14872-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF66C9F6E9
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Dec 2025 16:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6A4930139AD
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Dec 2025 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680132C936;
	Wed,  3 Dec 2025 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fPOFiZ9i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77800381C4;
	Wed,  3 Dec 2025 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775134; cv=fail; b=DO4TvTqeK+XKon5TULqdPp7UG687DGRC6a/p3G01gBHZhkrgq6qJ3YPgpJmHtlnPrFgfv5c/mPqU5usov7fc/CEJh4rE/A0BwPTYHbnPBMS8UEZqcrwee8zuITfmnkGB78/1rWqbwFXeNQBWTAl/x/m5PHbcs4uc76OtlldQI58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775134; c=relaxed/simple;
	bh=eiO3Yw6oouFjK1NhmrMbAHUt5yeWvCTZ0i7CCZqII8A=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MPvp/59ygesSD+ZJ50XpZ5IY7deRXky5Pmgg6qwBVVI88iDFTsmD8nRJMR1+v1axNNGJV8k4Ei7/yrFjaHxOAD8Gwu9Iycc+gxL12T7RFWOwJMRP7eNbrqz27qO2zTu8dqWS3aYq7UNbanQ0GWgM+3ZtePHUOjxJBHtyE9ANpDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fPOFiZ9i; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTPopb8V6PglXYopZfd+ZrSMDuHDUFaHlbKKsFu9PXN8uczA+mP7IRlZqX/VczeQA3a9+cu69QDGX5RejuuMBrbdDDrLU4+kJFYSW96StOPQcs9di4FJ5etieB3xeRrOg9E6/jvIvPWA3OlmNapT4xhD7ndNpaWatSXFdksYycFjId54qsH9xAlx3g0eadWEsNLJBEeM2gT6xPDwdlj1E2cPpExWf83Q3wSF/gcLD/rKkv/hxVJwjQ7SKu2IPC+oeRo7s4GCC7/Aq6vUZdFSVfhmm1fHMOCqntjMZRNK100RHr7NVK2jGm+uICDAdpptG8xoKWWOS7tlTuz6nFawqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ky+IXrgEvsne4eARC2iyXfvBQxEDoWuCVTQL71Gsts=;
 b=xwPgr1GcdPu+Jy1n6wHcyGqaOQzT3o0h6c56TVf0Jf8KQEk3Lrt9a7DtpS8Ms0Rd3rNUvm5lMh5y6McYNSDBWaG40WePceq90zVTncZxWTrmNkECruG5/NohX9JWRvva52P/sAyC8A0JxD8BBE955G7qSwHTdNSzePdGiDu1PAsrHW8jcAZe5Quzv2/+xqsa8EUhXmFIPEioIT88QuuqBNDGnmMEtr7FyON+5Pr17Rj1NVjzgGp1hJEc9t5DsePyYXuvx6ZAX0JT1NlZppylwQ3i+AujoyMXPurljbQd3xCPRO1AXdNUGLOOhlW5hYOcjr+WFcM0SAlQbOcFWCjvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ky+IXrgEvsne4eARC2iyXfvBQxEDoWuCVTQL71Gsts=;
 b=fPOFiZ9iW0eoDiSlOyw1FGn0WIzRTYI+aMwW61B/+SkEyS4BSg5h/eEBcQNSuGNyfL1tV9G4n1VV0r1n07n4aTaltfBQ2p2bDPIKqeejSjf06aEt4sxFOitJvOjdztGF1JCF29mpZr7cLw/CQTcIBzb9gFWz2SbrVDqyEZZp/XU4FOY1ee/jeJVyPvzEkxqOom1R3CzwGkCa4dq0Hte4fiXTOwHo5V67zB4Bf3dGp/9h/fR56WrvoXjjjDxTkPoUXfcHNC0KEXPBVIp7VqrjLH6ifDqy+xaWfKd3IM60mhcO0szC2vUJQ6G1DTNpqsTNbtHHhJYjpQnNK1+mjd+p9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 15:18:48 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 15:18:48 +0000
Date: Wed, 3 Dec 2025 11:18:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20251203151847.GA1224837@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="woCtgOTkQvIXHsUO"
Content-Disposition: inline
X-ClientProxiedBy: BN9PR03CA0470.namprd03.prod.outlook.com
 (2603:10b6:408:139::25) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: b1706a1a-435c-44a6-cfe5-08de327f41f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWFWSGRkMVdnUXAxSXRZUVVxVnFaOTlNejdid3dqeUhrTEdiNkZ2UkptZ3hm?=
 =?utf-8?B?eXNlQ0FUYm5SVyt3WkhHamQ0dlBNaUFjdzNvaEk0U2pBc2JaZzl6ZytWcWJC?=
 =?utf-8?B?b2k3amwveVlQdHBLa3NnWDNmSXZ4ekYvTXowU0JPQWtMK1oyMTVaYXlaYURq?=
 =?utf-8?B?Mk1lK0FxN29Cb2s0Nnl2U0w5d0IzZ1NnczlVVjJjNStaSkhlUERZckRLcXZi?=
 =?utf-8?B?WWRjT0d3aG5vd1BoUUQ5eDY4ci9EZ3JoWW8waFQ1QlE2ZnpXazQxSXA0M3BO?=
 =?utf-8?B?UXlxRDE3ejkxVGVsaFl1aVpBbFpoSlZMamhDK3VkdWJZUFZCalRYd1dzMnpx?=
 =?utf-8?B?aU1SRUgvSEVaVWhrS203WjgxWVg5b0RsN1dRWFN0TlZTWlFTdkFDZmdaci9K?=
 =?utf-8?B?UFB6WnF1RnZpbWRQc2ZBc2lTMktteFR4eFd1WDRncVZFczVjTkhid0U0ZWNH?=
 =?utf-8?B?R1NVeGg3U2tBaFNUREVYazNsMGpZdGEwc3dzVXVWb2pRYmtaRlR2YmtEV2ZQ?=
 =?utf-8?B?T0dIUU1INmZUUlpjdzduLzYrQUJWNXd1ejBHSnZ6elJIMHptUmZGWjhBK0JZ?=
 =?utf-8?B?eVJKbUNRaU9oL1B1eEtoZjNZd1ZnRWFicUJad1A2MDA1UmxWQ3FzR2cxTWtI?=
 =?utf-8?B?QnI3VUdzZ2diQUk3YXlMK2tTU3RDTTMzbU04ajRZRVZjRHVYTW9iRW9PQ0xD?=
 =?utf-8?B?V0diNjJJN2c0OGhZek5SNXFtVXFlSGdGalBkYmxUTExzbGRYZUJSUGlGa2lv?=
 =?utf-8?B?alFFSy9MclFwSVJKemxabzBhcUxicjZrY2FrOEN3cGFoS3JpWTVGMVp3aGJj?=
 =?utf-8?B?cTIyL1JyeEhTU0xRbXRHdVlKVnNhN0lvOHliUEcxRjhxaDd4dS8yVTh3WVg4?=
 =?utf-8?B?Wk4yU0xNb2JiMjZlb3Vva0NKMnhiWmtCSW1waFlrRkZsVk1Qd20yQXdJK3dQ?=
 =?utf-8?B?TmE5YzM2cDdyRDA1emFjZ0IyczZYcEtOcE1hNXRONk1iZlhiT0pLRGlFNFB4?=
 =?utf-8?B?cm84VFEzckRrTXBINlZwdk44aCtycmFOYUwraXZ3WW1PRCtKWE5TNHRmMmNZ?=
 =?utf-8?B?YnVIMXBXckxWMk45bTlnRHhEa056ZDZJM3RLK3RUc3JvcGJ5dXk2TzBrbU94?=
 =?utf-8?B?T0g4U05xVzViWlVJQ0lnOGhNNEJMbjF6RlFWWVIyYUdpVXkyaXdjQnU2SjRU?=
 =?utf-8?B?RmRFdWdVYVFsMXRraTRFU0NlclJzZzdacU9lZGF4ZTVzZ1dXMzRQMDV2bmxi?=
 =?utf-8?B?b1kyWG91a1REUWhnd0tJdU5yYU11THJrT3Q0Y1VUbm91OWcwdWVjZDZSbWF6?=
 =?utf-8?B?Rk96dDc5eng1T21sS0grL1VkZGR4cUVtb3ZPTTd3cGpIckJsK2dwUExsV3Ur?=
 =?utf-8?B?Sm5DUTFodkZaRWhtQUM4c2RnTHRCL1p2OFkyWUFDdG1zRWg0V045aDJGSE5r?=
 =?utf-8?B?QllPL3VTZnNmdHRPTzkvcHRhMzJ0T2o5UnhYRGZJbUh6cHNNbktKWkVvK3hk?=
 =?utf-8?B?bzFxaEhyMndoQ2l3cXlZN0ttWWxxRjl0ZDFjUDRtOHFEMk5DUTVNbFoxMm8v?=
 =?utf-8?B?Tks0ay91S00rQTlNSzc4NHY0NXlzY0gwT2tCYitGajNnTEpkVGRwcnVtU1Nv?=
 =?utf-8?B?cGZKZUhObHJDWnhHaXBGTi9Vd0RaQUlDa1daZi9ScU1LaENrQjN0MG5yd1dN?=
 =?utf-8?B?RUlrNWRmNDVocHVCNkZmUi9CeUJVaDJXeGJ3SGZKUWhLOGpqTW1wbWdZdVlB?=
 =?utf-8?B?T0Q5Z3J2Z3BESGxBZDZLZFhmOVNlWXV4cU41WEZDRVIrdUJZSGdFYXNWOGEx?=
 =?utf-8?B?dUY3dW9NM1BuK1UweSt1OFd0c3Jybk11Q1VlMWtJRGY3UjRKUHB6b3pIMU9h?=
 =?utf-8?B?MmJiUHBqd3ZSUVZnSm96dnZEM0JnRWdqUURHQmVaa2FhSkUxdDM0S3lsa0hQ?=
 =?utf-8?Q?k5cqYDnC5hMu/OwFutxXn/2KM+L6Cm/F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUd3bzRiL3dzcXNJOUd6UThIYVoxZ0I4TGg2bXlKL2ZJQzBoWTVlK2FjcGdi?=
 =?utf-8?B?Mmh3T1hkS24rWDVGeFV2bHhYQkY4N0tVQ3RsRTZDQXYrS3g4dmZQQklWQ0p0?=
 =?utf-8?B?dVVjQTVlOVB3WXIydFljbi9YZ1RDdkpJdmNwdm80NTVjUVd3YmplbG9NRDRH?=
 =?utf-8?B?MUZ0OGpCN2JiMG5uNlErQ0x1RlBQUXdqYkxBNjJ1WjdacEkyQVRvRHRKajBv?=
 =?utf-8?B?VCt2Y1VHQXVqbTNka3Y4MDlhVDB5c0xha2NKb1NDaEFieHNnMFY2YjFFV0ZU?=
 =?utf-8?B?YVFtanZDcDNpc2hJc1dkcnB0cWZKQzluOXVVNGxORndJcklLSFNWL2cvWmd4?=
 =?utf-8?B?ZG45cGNPN1UrcUVVQjRPdHB0cWMyczBZY3R0MXRlaC82c0RPdHJnM0tzL1RW?=
 =?utf-8?B?dy80Znp6NHNzOWh4bUxMMldkNGNBaTdLQTJUZkJxaGhHdFBxb0gydUVwYXpC?=
 =?utf-8?B?djZoalY3TDM3UXcreEpBMVJ6VUp6M0lZMDhzeFZBall1OU4zQ3BxR2ZjYzNT?=
 =?utf-8?B?dXFMMmJ3NEUxV0RUSmlrOHA5L1hjQUo5akwvUEswaHdLNkYrMXo2RURDa0dn?=
 =?utf-8?B?UlJHM0Q0MUVmWEhsNnFNWmdobkMrU2Jic0FjRzNZRnM0T2xSeGJMcDBnZ3Jy?=
 =?utf-8?B?M1I5S1NSTFNVbC8yK1k2UDFUUE1rMitwMnBRdWtNKzlXSmJmcjBWbzV4ZXNn?=
 =?utf-8?B?dkRXeGszOG5SbmM5c2swVkwzVVJSSXZjTU5EaDlHaHVIVTNzdG1RT2NWTTVx?=
 =?utf-8?B?bjdkbktlWldHQUV4Tis4QlR6dm95VjFINHpFTlNtTFdnd29BQWRaUTNsZGdH?=
 =?utf-8?B?K0JvUlIxZWZJY2wvYURjY3g3NnZJVXFJYVNrTC93b1lwUWF4QnR5dDhwZVAw?=
 =?utf-8?B?WDZ1dWxRaTEySVJZL2QzNEt0VnFSK3hTNDRHbGRiSUVFcmZxVE16ajFwQ3BD?=
 =?utf-8?B?Y0dHdVpsRUtDRU5lZndlK3dSdW1JUXpzdUZma0JPeUxWby9RM1RVQUxjdk8y?=
 =?utf-8?B?eVNUbTVMWms5SEI2VVQzVEQ3czByYmV2ZWVibThwRHVrNm9YN3RuZE0zUVg0?=
 =?utf-8?B?V3V3cmM0SnlValcrTmpWNTFZWUhDSmwxV3NKQU0wVVh0UEM1U2FtekxUTHUz?=
 =?utf-8?B?aHdPajU0ZUkvUGxoNFZWeVhzMmI1TVRhaXNZR2FrKzV0dm50dUJZZ2RzdFJS?=
 =?utf-8?B?WTJNME4vQWRtZmlGMmFxK2Z0QW11RFJTaENaVmd2NWozMmx0a2JOc2FmR3dr?=
 =?utf-8?B?cWw4TDQwNWFSeXplektoN210UXI1ZlVPb1Y1Yk9iNUZsaFF0N1NpU1VmT0RZ?=
 =?utf-8?B?c2dMOGdkZVdlQnFRY0F1a2huTldHT3QyVEVONDVVT0kxeldiY0h0QzdxVEJC?=
 =?utf-8?B?ZTZ5a0haRTNuSGJUQzhrQWoxK2J0VVdPUUIrWFovRGk0VmxmdHUzdkRhd2pw?=
 =?utf-8?B?cjlldHc4cHRxZ2w1VUdUYW9WUnN1NGw2RTdBc2FpcEU2VDliM1hkWXJEZ0Nm?=
 =?utf-8?B?K0FTbk9DQmN4ZS9JeUIvYmJmVTd0cUxlNmFWWnJlQ2hIMzVYUFJxOTFLcHYv?=
 =?utf-8?B?MXZ0RUxKN2pnYThHUDcrUm9kaXUwemFRdFRJNWNZUmdLV25NU2FUQmRqcytu?=
 =?utf-8?B?ZDhWNjJ6bzZ2T3NYekxBM2w1S3kzTTV1SFVONzVOeWlUendTTjhnZjd0TDEz?=
 =?utf-8?B?Y3dJTGN4cVpudFg0Z0t4c2ZRNjA0WU83M2JwRXVxeTJlYndpSTE3dWdsbkE5?=
 =?utf-8?B?NWF0YThXeEo0Rm5zUEtzakZFTU1HUWJqa1Y2UUJzWEdjeDdyWnZkSjNPaWtl?=
 =?utf-8?B?bXNEUFNlS29kREtmektlMXV4cENvc2ROTU5oTjRkU3JuT2NacGJUbnFjVVMy?=
 =?utf-8?B?cHc3WUM5azQ3K3JXUEQ4TkErcmtBV0FWVXlkOHdDdUtBTnF6cGllbHZIMHJ0?=
 =?utf-8?B?VEpXK1lWTmgyWlczaXd1ejdoMmZFaGd3Z3JuWk9HR3d5RWpZcGFLYkhtUzJC?=
 =?utf-8?B?ZTBXVFBwYVFxSnRWZjNVVklQeThySlJKT2k1Q05ER1JhZkpqY0pTQ0dBVU1F?=
 =?utf-8?B?WDZZdzFPNS9mTDkxWTVnMm10YTN4dUE2UzN5WEVLNERUTWo3NC9sWGFRUmZD?=
 =?utf-8?Q?tBx8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1706a1a-435c-44a6-cfe5-08de327f41f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 15:18:48.3896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DP7vZhVtotmLXBmNhM0EMj3BX6UU1mtmLiMGUnTxSXsxCg8N3TwFbISXPC6A/m0F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038

--woCtgOTkQvIXHsUO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

This PR has another new RDMA driver "bng_en" for latest generation
Broadcom NICs. There might be one more new driver still to come.

Otherwise it is a fairly quite cycle.

Thanks,
Jason

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 80a85a771deb113cfe2e295fb9e84467a43ebfe4:

  RDMA/rxe: reclassify sockets in order to avoid false positives from lockd=
ep (2025-11-27 07:10:02 -0500)

----------------------------------------------------------------
RDMA v6.19 merge window pull request

- Minor driver bug fixes and updates to cxgb4, rxe, rdmavt, bnxt_re, mlx5

- Many bug fix patches for irdma

- WQ_PERCPU annotations and system_dfl_wq changes

- Improved mlx5 support for "other eswitches" and multiple PFs

- 1600Gbps link speed reporting support. Four Digits Now!

- New driver bng_en for latest generation Broadcom NICs

- Bonding support for hns

- Adjust mlx5's hmm based ODP to work with the very large address space
  created by the new 5 level paging default on x86

- Lockdep fixups in rxe and siw

----------------------------------------------------------------
Adithya Jayachandran (1):
      {rdma,net}/mlx5: Query vports mac address from device

Alok Tiwari (1):
      RDMA/cxgb4: fix typo in write_pbl() debug message

Anil Samal (1):
      RDMA/irdma: Add missing mutex destroy

Colin Ian King (1):
      RDMA/rxe: Remove redundant assignment to variable page_offset

H=C3=A5kon Bugge (1):
      RDMA/cm: Base cm_id destruction timeout on CMA values

Jacob Moroni (5):
      RDMA/irdma: Enforce local fence for LOCAL_INV WRs
      RDMA/irdma: Remove unused CQ registry
      RDMA/irdma: Do not directly rely on IB_PD_UNSAFE_GLOBAL_RKEY
      RDMA/irdma: Do not set IBK_LOCAL_DMA_LKEY for GEN3+
      RDMA/irdma: Remove doorbell elision logic

Jay Bhat (4):
      RDMA/irdma: Initialize cqp_cmds_info to prevent resource leaks
      RDMA/irdma: Silently consume unsignaled completions
      RDMA/irdma: CQ size and shadow update changes for GEN3
      RDMA/irdma: Take a lock before moving SRQ tail in poll_cq

Jijun Wang (1):
      RDMA/irdma: Fix SRQ shadow area address initialization

Junxian Huang (8):
      RDMA/hns: Add helpers to obtain netdev and bus_num from hr_dev
      RDMA/hns: Initialize bonding resources
      RDMA/hns: Add bonding event handler
      RDMA/hns: Add bonding cmds
      RDMA/hns: Implement bonding init/uninit process
      RDMA/hns: Add delayed work for bonding
      RDMA/hns: Support link state reporting for bond
      RDMA/hns: Support reset recovery for bond

Kalesh AP (3):
      RDMA/bnxt_re: Add a debugfs entry for CQE coalescing tuning
      RDMA/restrack: Fix typos in the comments
      RDMA/bnxt_re: Fix wrong check for CQ coalesc support

Krzysztof Czurylo (3):
      RDMA/irdma: Fix data race in irdma_sc_ccq_arm
      RDMA/irdma: Fix data race in irdma_free_pble
      RDMA/irdma: Fix SIGBUS in AEQ destroy

Leon Romanovsky (3):
      Add other eswitch support
      Expose definition for 1600Gbps link mode
      RDMA/bng_re: Remove prefetch instruction

Li RongQing (2):
      RDMA/core: Prevent soft lockup during large user memory region cleanup
      RDMA/core: Reduce cond_resched() frequency in __ib_umem_release

Ma Ke (1):
      RDMA/rtrs: server: Fix error handling in get_or_create_srv

Maher Sanalla (2):
      RDMA/core: Add new IB rate for XDR (8x) support
      RDMA/mlx5: Add support for 1600_8x lane speed

Marco Crivellari (7):
      RDMA/core: RDMA/mlx5: replace use of system_unbound_wq with system_df=
l_wq
      RDMA/core: WQ_PERCPU added to alloc_workqueue users
      hfi1: WQ_PERCPU added to alloc_workqueue users
      RDMA/mlx4: WQ_PERCPU added to alloc_workqueue users
      IB/rdmavt: WQ_PERCPU added to alloc_workqueue users
      IB/iser: add WQ_PERCPU to alloc_workqueue users
      IB/isert: add WQ_PERCPU to alloc_workqueue users

Patrisious Haddad (7):
      net/mlx5: Add OTHER_ESWITCH HW capabilities
      net/mlx5: fs, Add other_eswitch support for steering tables
      net/mlx5: fs, set non default device per namespace
      RDMA/mlx5: Change default device for LAG slaves in RDMA TRANSPORT nam=
espaces
      RDMA/mlx5: Add other_eswitch support for devx destruction
      RDMA/mlx5: Refactor _get_prio() function
      RDMA/mlx5: Add other eswitch support to userspace tables

Randy Dunlap (3):
      RDMA/uverbs: fix some kernel-doc warnings
      IB/rdmavt: rdmavt_qp.h: clean up kernel-doc comments
      RDMA/cm: Correct typedef and bad line warnings

Selvin Xavier (2):
      RDMA/bnxt_re: Fix the inline size for GenP7 devices
      RDMA/bnxt_re: Pass correct flag for dma mr creation

Siva Reddy Kallam (7):
      RDMA/bng_re: Add Auxiliary interface
      RDMA/bng_re: Register and get the resources from bnge driver
      RDMA/bng_re: Allocate required memory resources for Firmware channel
      RDMA/bng_re: Add infrastructure for enabling Firmware channel
      RDMA/bng_re: Enable Firmware channel and query device attributes
      RDMA/bng_re: Add basic debugfs infrastructure
      RDMA/bng_re: Initialize the Firmware and Hardware

Stefan Metzmacher (3):
      RDMA/core: let rdma_connect_locked() call lockdep_assert_held(&id_pri=
v->handler_mutex)
      RDMA/siw: reclassify sockets in order to avoid false positives from l=
ockdep
      RDMA/rxe: reclassify sockets in order to avoid false positives from l=
ockdep

Tariq Toukan (1):
      net/mlx5: Expose definition for 1600Gbps link mode

Tatyana Nikolova (1):
      RDMA/irdma: Add a missing kfree of struct irdma_pci_f for GEN2

Tuo Li (1):
      RDMA/irdma: Remove redundant NULL check of udata in irdma_create_user=
_ah()

Vikas Gupta (1):
      bng_en: Add RoCE aux device support

Yishai Hadas (3):
      PCI/TPH: Expose pcie_tph_get_st_table_loc()
      net/mlx5: Add direct ST mode support for RDMA
      IB/mlx5: Reduce IMR KSM size when 5-level paging is enabled

Zhu Yanjun (1):
      RDMA/rxe: Fix null deref on srq->rq.queue after resize failure

 MAINTAINERS                                        |    7 +
 drivers/infiniband/Kconfig                         |    1 +
 drivers/infiniband/core/cm.c                       |    9 +-
 drivers/infiniband/core/cma.c                      |    2 +
 drivers/infiniband/core/device.c                   |    4 +-
 drivers/infiniband/core/restrack.c                 |    4 +-
 drivers/infiniband/core/ucma.c                     |    2 +-
 drivers/infiniband/core/umem.c                     |    8 +-
 drivers/infiniband/core/verbs.c                    |    3 +
 drivers/infiniband/hw/Makefile                     |    1 +
 drivers/infiniband/hw/bng_re/Kconfig               |   10 +
 drivers/infiniband/hw/bng_re/Makefile              |    8 +
 drivers/infiniband/hw/bng_re/bng_debugfs.c         |   39 +
 drivers/infiniband/hw/bng_re/bng_debugfs.h         |   12 +
 drivers/infiniband/hw/bng_re/bng_dev.c             |  534 +++++++++++
 drivers/infiniband/hw/bng_re/bng_fw.c              |  767 +++++++++++++++
 drivers/infiniband/hw/bng_re/bng_fw.h              |  211 ++++
 drivers/infiniband/hw/bng_re/bng_re.h              |   85 ++
 drivers/infiniband/hw/bng_re/bng_res.c             |  279 ++++++
 drivers/infiniband/hw/bng_re/bng_res.h             |  215 +++++
 drivers/infiniband/hw/bng_re/bng_sp.c              |  131 +++
 drivers/infiniband/hw/bng_re/bng_sp.h              |   47 +
 drivers/infiniband/hw/bng_re/bng_tlv.h             |  128 +++
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |    2 +
 drivers/infiniband/hw/bnxt_re/debugfs.c            |  128 +++
 drivers/infiniband/hw/bnxt_re/debugfs.h            |   19 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |    8 +-
 drivers/infiniband/hw/bnxt_re/main.c               |    1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |    3 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |    1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |    8 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |    2 +-
 drivers/infiniband/hw/cxgb4/mem.c                  |    2 +-
 drivers/infiniband/hw/hfi1/init.c                  |    4 +-
 drivers/infiniband/hw/hfi1/opfn.c                  |    4 +-
 drivers/infiniband/hw/hns/Makefile                 |    4 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c            |    1 -
 drivers/infiniband/hw/hns/hns_roce_bond.c          | 1012 ++++++++++++++++=
++++
 drivers/infiniband/hw/hns/hns_roce_bond.h          |   95 ++
 drivers/infiniband/hw/hns/hns_roce_device.h        |   16 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  141 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   20 +
 drivers/infiniband/hw/hns/hns_roce_main.c          |  185 +++-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |    1 -
 drivers/infiniband/hw/hns/hns_roce_qp.c            |    5 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |    1 -
 drivers/infiniband/hw/irdma/cm.c                   |    2 +-
 drivers/infiniband/hw/irdma/ctrl.c                 |  107 +--
 drivers/infiniband/hw/irdma/hw.c                   |    3 -
 drivers/infiniband/hw/irdma/icrdma_if.c            |    6 +-
 drivers/infiniband/hw/irdma/ig3rdma_if.c           |    4 +
 drivers/infiniband/hw/irdma/main.h                 |    3 +-
 drivers/infiniband/hw/irdma/pble.c                 |    6 +-
 drivers/infiniband/hw/irdma/puda.c                 |   20 +-
 drivers/infiniband/hw/irdma/type.h                 |    5 -
 drivers/infiniband/hw/irdma/uk.c                   |   67 +-
 drivers/infiniband/hw/irdma/user.h                 |    6 +-
 drivers/infiniband/hw/irdma/utils.c                |   58 +-
 drivers/infiniband/hw/irdma/verbs.c                |   49 +-
 drivers/infiniband/hw/irdma/verbs.h                |    3 +-
 drivers/infiniband/hw/mlx4/cm.c                    |    2 +-
 drivers/infiniband/hw/mlx5/devx.c                  |   14 +
 drivers/infiniband/hw/mlx5/fs.c                    |   65 +-
 drivers/infiniband/hw/mlx5/ib_rep.c                |   74 +-
 drivers/infiniband/hw/mlx5/main.c                  |    6 +-
 drivers/infiniband/hw/mlx5/odp.c                   |   93 +-
 drivers/infiniband/hw/mlx5/qp.c                    |    5 +-
 drivers/infiniband/sw/rdmavt/cq.c                  |    3 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |    1 -
 drivers/infiniband/sw/rxe/rxe_net.c                |   49 +
 drivers/infiniband/sw/rxe/rxe_odp.c                |    1 -
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   49 +
 drivers/infiniband/sw/rxe/rxe_srq.c                |    7 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |   51 +
 drivers/infiniband/ulp/iser/iscsi_iser.c           |    2 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |    2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |    2 +-
 drivers/net/ethernet/broadcom/bnge/Makefile        |    3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h          |   10 +
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c     |  258 +++++
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.h     |   84 ++
 drivers/net/ethernet/broadcom/bnge/bnge_core.c     |   18 +-
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c     |   40 +
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h     |    2 +
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c     |   12 +
 drivers/net/ethernet/broadcom/bnge/bnge_resc.h     |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   20 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   31 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   74 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |   19 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c   |   29 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |   24 +-
 drivers/pci/tph.c                                  |   16 +-
 include/linux/mlx5/fs.h                            |   24 +
 include/linux/mlx5/mlx5_ifc.h                      |   47 +-
 include/linux/mlx5/port.h                          |    1 +
 include/linux/mlx5/vport.h                         |    3 +-
 include/linux/pci-tph.h                            |    1 +
 include/rdma/ib_cm.h                               |    4 +-
 include/rdma/ib_verbs.h                            |  100 +-
 include/rdma/rdmavt_qp.h                           |   70 +-
 102 files changed, 5280 insertions(+), 549 deletions(-)
 create mode 100644 drivers/infiniband/hw/bng_re/Kconfig
 create mode 100644 drivers/infiniband/hw/bng_re/Makefile
 create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_dev.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_re.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_res.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_res.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_tlv.h
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_bond.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_bond.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.h

--woCtgOTkQvIXHsUO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaTBU1QAKCRCFwuHvBreF
YU/xAQCg8hAUbkYL4Pps4vL+kqaprEWEtJpjAQ6FViyebvGznAD+Ms84ZljnQdAM
sn5MdjDRG4p13D6Kpa2exFOi0HjEPAE=
=VjbF
-----END PGP SIGNATURE-----

--woCtgOTkQvIXHsUO--

