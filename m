Return-Path: <linux-rdma+bounces-7817-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E88A3AB86
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 23:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B05F3A3467
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC631D61B9;
	Tue, 18 Feb 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GfUja3nV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F4A1ACEC7;
	Tue, 18 Feb 2025 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917152; cv=fail; b=ZGfhh9ybaJcvQ+TVwaemj7CoZmPWtnZKb3snxP1tlTX6wvPtA0Zn1U9bLcmQ0AEY3X0lcjjk/IdLYS8h1lCiM6KDEHiMVrf8dfI0TKhWN7DZB6DiamDnl+4+WHLfPfuOJPJ8Hm4vDQNSHOn593nZ0tF2eQIOEGaFcX4SN9FD1Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917152; c=relaxed/simple;
	bh=Lx1JE8jszC4Zbp3bdVJuP/mV6wRytLcNNqbZqr6PgzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RBXZXmjESivB6nlk0TSnfD6BPFVE+j0xx2wirDfS7vXSYaPSpZBp9hSQLrpPMjc1WlKmLM3gIQhhVrtqk3pRp9DUSLqaFoXdK7/z+LNFMzc4Mck/HJdCMP5AW9XwaZeXZnte5rIk0/3waidugeqvY/ZYLFX01qyYr+wPwX34RM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GfUja3nV; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkdRUjOb1sVHquMNG/nfBoIZeLAlEBBWvNJMIg+eWtqLrLFvDWMW99c/p63j5oS28/FTQS2wSHvK52QtLL5ufsCPKNqTJvIviMGR09Mani3KDcvGLyIt1ryteO48afoy+JKscdLr8QSi13+2yufq4GPECERyjzA2rhWI5fq4UfDruw5rDmkn2khvUQBj1AKnjYAuxYnsjKH3F22HvMbV9uooY10QPtfas15IXFqUJXXrpCS/TrOhWp6YOUIErJ5waw0Uyd0yALm0v+2F1TU7pMyzG4G9A00XIftuELRiWTDfsbZjttYYMLpMaxos5BO1IhrrF7FICAxmPQgTdATuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bObldyRfQLFWwwVmG0q+4xKGpNO5bSo5HS1bMUC+zk=;
 b=BZOOaDS5WRAktLwG4u4VD7YfoWk++u/g63NbMtHq2G4HlBVpUB+cHxs5uUsircvztxLOYamCPmNh97ZhojC9D5Wg7nvPAWGio/1e91640jQhWQiRdHLa78BtCU5ot7ZustRV/cmHaS7jMVLDDDGfxBFeQ1rmUwpY3EP0jG0QkwRwlvKaT7YvMUbJxDWBmAtgH4Uq2r16LPugmbKzVLOX612S9KXKzpeU8Si/sc5F2f+NgECrDvwRiRv2A/7v+3CQ0tdhMkkyAZDrDfVXEE2Sfm6bsLBSqh7ox25Chfx1Cj/K9U0mdy54lDOkbkwmosZ0V1PhvO2EdQNQaQYHyfuTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bObldyRfQLFWwwVmG0q+4xKGpNO5bSo5HS1bMUC+zk=;
 b=GfUja3nV+Y16yZOozkHXO4+Kh+DtIDXsutJtM1zr36+gdUr7LMNnohGQ6yqftAxtuIirEqDDKsxhShow5xRRQulbuUgHdLal/Ft/ztoTbSReBP1fAR5NoxemMnaMER4HxZm4kzPmwoWOZ/eKNg14aLRg6BbW4hKUW1+gDj2ggmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 22:19:06 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 22:19:06 +0000
Message-ID: <39ec35d0-56a2-4473-a67d-9a6727c61693@amd.com>
Date: Tue, 18 Feb 2025 14:19:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 3/5] pds_fwctl: initial driver framework
To: Leon Romanovsky <leonro@nvidia.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gospo@broadcom.com,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com,
 Jonathan.Cameron@huawei.com, kuba@kernel.org, lbloch@nvidia.com,
 saeedm@nvidia.com, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-4-shannon.nelson@amd.com>
 <20250218195132.GB53094@unreal>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250218195132.GB53094@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: b81a28ea-80ff-422d-44b3-08dd506a41de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFJDaGpzM1RZcTF2SVdHNURXQzF3YnRGdVI2WTVsRWduc0VXNlJ4VTE5bHBq?=
 =?utf-8?B?bXRVdjhoRFBGZW1HYU5lNk5aNDlqbU5pV3N1NlNxNkhJeWVQaWJrS3BPRk9v?=
 =?utf-8?B?QmNJb2pYTk1MYldmQTZOeVBxbWxqSW9CUUNMSmd1OENKckxpSFQwblpDZ0FS?=
 =?utf-8?B?MGdyY0FONjJ4MEg0V3FPNHNPeVJGTmZjdCsrenhvaGVHVU5tb2U5VXVpbzIy?=
 =?utf-8?B?Mjl0MlRSbGh5a01wbUozaUVuZUZ6bkRXcHZkSWVPUDZITDNDWi9rbitnQ2cv?=
 =?utf-8?B?R3J5T2dEUncvZEpZRWNRTll4WGNkZHVaN2kvbDBzUXlZeVBNelRGSFlwL0lO?=
 =?utf-8?B?YncxdThKdGt6K3VzUVRmUnRnbmcyaXNyS0krYXJjWGs2SHVrZ05sczFackJW?=
 =?utf-8?B?dEIyWjAzVzZUUVQycjZUWEpxNU5vRi8vbTBzbnQ3T0FVVnJjbjNEaWRDMW1a?=
 =?utf-8?B?aHlJU1k0ajBrdkltRmlHYVI0cHBlNGFmQnUwbDk3dzBHNmNhWldmSk1KcllD?=
 =?utf-8?B?VkFkRldIRGRKcFEydmZ5ZkhjaTV2TEpJWTFQaVJmV0h4TzA3QUlIekVaMytH?=
 =?utf-8?B?WlVsbGltZnU0UWozSDVXY1lJRVVBZXFHQVMzR01TUUg4ME5BY0hrWm0rSkJv?=
 =?utf-8?B?bE43RDNYRXUxVzA2MVA3THViK3p6cm45SWRyV0xtNGFydCtyVFZlSTVWSklN?=
 =?utf-8?B?c0lYRktEMDhtM2RXZjh4WmNPOUpoV2cxOFpLZzFFSmU0cThIcVJUK3FpdGF1?=
 =?utf-8?B?TXJsb2thZG1IY0xyV1JVc285d1orMGlqbnFQMzR6UTdQY0taWmhUZlBsNWJm?=
 =?utf-8?B?RDF6a3Mya1VaOVRMazFXTHlQVzh0ZHEyRHhJSWFBYm8vcWZqcUFmUGVGeHd4?=
 =?utf-8?B?WGRhWEtqblBzWkpzTDdzd1RLbU1VaXAvbityMDJFYWlCMzdXVW5ISVFHaG83?=
 =?utf-8?B?ZHdFdVIveVBZUlJBRWlQcTF3RGlYVGVJT3JCT1ZPaE1aVG9rYzBMVVUvaDhB?=
 =?utf-8?B?NFZZbWNqZUtKR2lQTm11UU1iS09oRnhVUUdqMFVXQjdXZ2JsVXFXZnovVzRU?=
 =?utf-8?B?R040WVJPcEg1dXlJWGR5RmRaSytkKzM5dlNZTkJlREhzNjRlTk1oVmlIenNI?=
 =?utf-8?B?bFlybzE0U1BrREhEVnBVc2NzaFJsVnc3Y1h2SE1KRERXUHY3RzVuQ1VON3R1?=
 =?utf-8?B?VW4yK3pvc0ZpN1YxenNSOXhpLzNLOVRTQVpiUXl2MDdqejhnTTVWWjVOWkpl?=
 =?utf-8?B?RkNpYndWb2ZMWmNFQ3IzRWY5aFZINHFBU3lpVitPUGpkbitwZlZFbS9uY2VT?=
 =?utf-8?B?dVRuK2tjcHN3cDR3SE45Y1BLY2Z4aGZTZ2F1SXozaWhYeC9kbDRralVSVDYr?=
 =?utf-8?B?K1dnMmNyRDc1T3kvSmtRNGJLSExlL3E1WXBibUE4R3RJM0Jwb3VmS0VSMkNi?=
 =?utf-8?B?RnJTSlhUTzh4bU9EYnJ1VWpaUDM5Q24wbFlScUZUdnkvK0FkcUhTd3poN2J5?=
 =?utf-8?B?SzdZUDVtbVE5S3NkTVF3a2I4YUdoWHppdHpaUndPS1hWQXJDaFJwSUhlYldV?=
 =?utf-8?B?cm9yVGhBdHdBaDRRWXZuTnlpMlZ0TFFmWmQ1TEdibHh3emhiSFEwOVg4RG1m?=
 =?utf-8?B?V2hicjE5dnhueDl0TFk4VDNvOU1GYXRKOHBEOVA4N1NuZ1EzMGlnb0p3Q3Fu?=
 =?utf-8?B?NWdmdjg1TEJpRmtjd1cvdXNBa2dpbFNIUU5rc1VxNzM2R0puUUZlZlk1TVVt?=
 =?utf-8?B?RzRCNjM2TEpkUWtnU0EveCtlWjZsa3hjazNMVGJqWEpPNEorRXl0TkpWazRX?=
 =?utf-8?B?VW0zeFBCdFpySThSVVM1U3dOYXhvUE5zL1RIV3BwUkJ0RWRuR2ZhS0orb0Rl?=
 =?utf-8?Q?7DbvM2tGgU22S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDIxMS8rZUhsaFM3NkFWUWtkYk9RRytDRng0YVl6NC9sWXY0Wjg4RGRweHpq?=
 =?utf-8?B?VEhqbmlYTGQrZzNnSXcyQ1lPcFV3cmFCSUlLempKRllPRFNhOUFtS0NQR1lk?=
 =?utf-8?B?ekt1Y3p2R0dxZlNTN3djQlZWeFNUTU5TMnB2WStUZTFZOUthcmlDSGgvZWhE?=
 =?utf-8?B?QXVpb2NDckwxVE90d0Jkblc3QmdaTGVvM2xkTnk1QnFSQ1Q2SjZpbENKYTFC?=
 =?utf-8?B?MURyV2o5SFpkZnNpZFVNaVdLaTdEdndQWVNTWm92ZzFlVlZiTkVhM1JvMjg3?=
 =?utf-8?B?N0Q2UjNDOVBXN2ZZZlJ0WE1LK0p5ZFlmTDZ6U2FCdlpIU3pFaGVqWVJYQXkz?=
 =?utf-8?B?QWlWeHNwWjFuZHJEbGo0NTlkejZOSjI0U0RraGxxWmJlZjQ0NWJNYTRMTjFN?=
 =?utf-8?B?eXV2YzhyWWhFQmlhSWNEQ2hXajl0QkY3VEFWWjR5TDN0S2Z1YzFrVmw2aDZK?=
 =?utf-8?B?QjliMkEwRlJGTmZPNDE2K1RJUGlvU0tqdm9ONEtCV2V4dFZYMTNxaWRyWWpk?=
 =?utf-8?B?WXdSakFJSWxPcEd2NzJadlM2cVN4U3VPNkNaemZNZkVIRjZtSHZqN1lqK2hs?=
 =?utf-8?B?M2xidVdrSGlTUXFlQlRHTkdxSHl4V3lDNE1PVGI3cHVIRVlLODRQWEFSc25q?=
 =?utf-8?B?TTZuUWZidnRLQStVRTRicG9PQTRxWXhnL2wzOWE3bVJIUnlja2p6bkZ5RzRv?=
 =?utf-8?B?QzVrTGNXa2x0aXh0R1p0T3dsbS8xQWovbkZkZ3VBdWJhbkFZRTduVzl4V0ZJ?=
 =?utf-8?B?SVR1bC9MWC96azIrek5BQkY2bnlUeFp0UG40c3BzY0hDTjk2SWk3bWJTZWd4?=
 =?utf-8?B?czFBS25hZnFYcWF1UnorY0ZVd0NEWE00OUd4MUxzRkhDUXRhU3hpSktLaHpP?=
 =?utf-8?B?VlViSWpxTDRFODlIQno5S0lkNC9PUStmdERiaDVhb0RET2lYMlBDVjVITVNJ?=
 =?utf-8?B?cGNmRllidU9ReW5qc0xIbFM0cmY4Y3R6cHBWdE9rSW5TNUt2N1JtYUZzQ1Zs?=
 =?utf-8?B?K3RxSUFDNVdsQ24rMkM3YXM4YWdCM09ObHZDUzdweitKMC96b3QvbmpqWXRw?=
 =?utf-8?B?UVZkQ005SnVHUDc5VmdRV2FqK0lZcUMrTzQzajhtRmswNGpjeTg4UEFMQ3pW?=
 =?utf-8?B?VlF4N2lXOG43UEVaUFkvYi91ZDg2ZmFGamFnZTBMeDN3RDlkQjFIalRCT1kx?=
 =?utf-8?B?MjVnNlJydEVpMVNlWE1EcCsrMDV0OHdwYndzeklYU1FCL3ZRUnhOQWxURG5k?=
 =?utf-8?B?b1g5YjIraktmVGFtZzNuSllOUjhrWXB5MkVJSm9MUXAyL0wzOTZaTkM2Tnpp?=
 =?utf-8?B?aGtlbnR6RzM4VStyTS9mbkpNZnpCZTVqVzFrUnl4M1NtS2hkWkwwZkMyL0Fy?=
 =?utf-8?B?QzFVZGhhaFJhMXNmUHpNRWx6OXdIQ0tBai83SEJMZHZ1clpvbU0vMWxDNkt1?=
 =?utf-8?B?emx5U1FIekFQQ1pPMllYS1NsazdyR2duV2dxVWpoZnlVOHZxUjN5K2hHNjY3?=
 =?utf-8?B?em1pR2FRc2VtMGh5NzQrYnNoaTU4TVFQdlhnU0E3NWI2NVZMVE11NGVVdThv?=
 =?utf-8?B?aXZubWVDMDZpRTlERlNsbjMyK1dDajNtQ1Q4b2RqRGZRVHFHUXAzM296dEw4?=
 =?utf-8?B?WFUrc2greDl6cE05eGRVQ1RYZ0pOSzIzMGx2L1VndjdlS0owdm1abFQ2b2ZJ?=
 =?utf-8?B?b2txUmJ3VjFRd3JScGRydXdibjRkZ0JwR3Zrc2FzcS9iNDUySEgyZHdrdVFx?=
 =?utf-8?B?Zkt3Ry9rRWc3dnY2cTdpRXlDRnh6djc5QlRESjkxYjlsS2hBNXpEY0NBQVZW?=
 =?utf-8?B?L0NLR3VwN2NVWUpkaWNlVlRqV3RuOXdHK296NXJYdE5pcnZETERTak9VOVpS?=
 =?utf-8?B?SkZhbXZGeEIwUGhhcGdrZThxdDlsbGdHUzZlVnVYcC85ZHRHZlpGNDF1ODVG?=
 =?utf-8?B?SkdWaHpaN1J6S3A2UWVZY281M05BZGlzVFp1T2RNUy93WENlRC8vRW05NGdv?=
 =?utf-8?B?bXc3OFRuTU9FVzJYWGpOcEp3V2V5S0dBMkJxV2M4UHpBMlQyeTRMcGVnbEMr?=
 =?utf-8?B?N2dPK0tHbWNhNXRySkNFRWpSOU9Kam5FeTllSmdyOXVkZUZWbElCWXl4MDBk?=
 =?utf-8?Q?4blP2Ir9ZMDNXZ95rd74ow4CT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81a28ea-80ff-422d-44b3-08dd506a41de
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 22:19:06.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hcq6u9kNo4VtPKzi1mqZ9rwhnr7WEWQjOlc4aE3HKmjxJoRYJgF6XH14r9Ab7DEBOuwlm6uAgvq36EjR1E8GxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773

On 2/18/2025 11:51 AM, Leon Romanovsky wrote:
> 
> On Tue, Feb 11, 2025 at 03:48:52PM -0800, Shannon Nelson wrote:
>> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
>> devices.  This sets up a simple auxiliary_bus driver that registers
>> with fwctl subsystem.  It expects that a pds_core device has set up
>> the auxiliary_device pds_core.fwctl
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   MAINTAINERS                    |   7 ++
>>   drivers/fwctl/Kconfig          |  10 ++
>>   drivers/fwctl/Makefile         |   1 +
>>   drivers/fwctl/pds/Makefile     |   4 +
>>   drivers/fwctl/pds/main.c       | 195 +++++++++++++++++++++++++++++++++
>>   include/linux/pds/pds_adminq.h |  77 +++++++++++++
>>   include/uapi/fwctl/fwctl.h     |   1 +
>>   include/uapi/fwctl/pds.h       |  27 +++++
>>   8 files changed, 322 insertions(+)
>>   create mode 100644 drivers/fwctl/pds/Makefile
>>   create mode 100644 drivers/fwctl/pds/main.c
>>   create mode 100644 include/uapi/fwctl/pds.h
> 
> <...>
> 
>> +static int pdsfc_open_uctx(struct fwctl_uctx *uctx)
>> +{
>> +     struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
>> +     struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
>> +     struct device *dev = &uctx->fwctl->dev;
>> +
>> +     dev_dbg(dev, "%s: caps = 0x%04x\n", __func__, pdsfc->caps);
> 
> This driver is too noisy and has too many debug/err prints.

Yes, still being worked on, but also we used dbp prints to keep the 
noise to a minimum.  Most of these will disappear as we move out of RFC 
mode.

> 
>> +     pdsfc_uctx->uctx_caps = pdsfc->caps;
>> +
>> +     return 0;
>> +}
>> +
>> +static void pdsfc_close_uctx(struct fwctl_uctx *uctx)
>> +{
>> +}
>> +
>> +static void *pdsfc_info(struct fwctl_uctx *uctx, size_t *length)
>> +{
>> +     struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
>> +     struct fwctl_info_pds *info;
>> +
>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +     if (!info)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     info->uctx_caps = pdsfc_uctx->uctx_caps;
>> +
>> +     return info;
>> +}
>> +
>> +static void pdsfc_free_ident(struct pdsfc_dev *pdsfc)
>> +{
>> +     struct device *dev = &pdsfc->fwctl.dev;
>> +
>> +     if (pdsfc->ident) {
> 
> It is not kernel style, which is success oriented.
> If (!pdsfc->ident)
>     return;
> 
> However I don't know how can this happen. You shouldn't call to pdsfc_free_ident
> if ident wasn't set.

This will change as we rework the ident handling to simply cache it and 
immediately drop the DMA linkage as suggested by an earlier review.

> 
>> +             dma_free_coherent(dev, sizeof(*pdsfc->ident),
>> +                               pdsfc->ident, pdsfc->ident_pa);
>> +             pdsfc->ident = NULL;
> 
> Please don't assign NULL to pointers if they are not reused.
> 
>> +             pdsfc->ident_pa = DMA_MAPPING_ERROR;
> 
> Same.
> 
>> +     }
>> +}
>> +
>> +static int pdsfc_identify(struct pdsfc_dev *pdsfc)
>> +{
>> +     struct device *dev = &pdsfc->fwctl.dev;
>> +     union pds_core_adminq_comp comp = {0};
>> +     union pds_core_adminq_cmd cmd = {0};
>> +     struct pds_fwctl_ident *ident;
>> +     dma_addr_t ident_pa;
>> +     int err = 0;
> 
> There is no need to assign 0 to err.
> 
>> +
>> +     ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
>> +     err = dma_mapping_error(dev->parent, ident_pa);
>> +     if (err) {
>> +             dev_err(dev, "Failed to map ident\n");
> 
> This is one of the examples of such extra prints.
> 
>> +             return err;
>> +     }
>> +
>> +     cmd.fwctl_ident.opcode = PDS_FWCTL_CMD_IDENT;
>> +     cmd.fwctl_ident.version = 0;
> 
> How will you manage this version field?

Since there is only version 0 at this point, there is not much to 
manage.  I wanted to explicitly show the setting to version 0, but maybe 
that can be assumed by the basic struct init.

> 
>> +     cmd.fwctl_ident.len = cpu_to_le32(sizeof(*ident));
>> +     cmd.fwctl_ident.ident_pa = cpu_to_le64(ident_pa);
>> +
>> +     err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
>> +     if (err) {
>> +             dma_free_coherent(dev->parent, PAGE_SIZE, ident, ident_pa);
>> +             dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
>> +                     cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
>> +             return err;
>> +     }
>> +
>> +     pdsfc->ident = ident;
>> +     pdsfc->ident_pa = ident_pa;
>> +
>> +     dev_dbg(dev, "ident: version %u max_req_sz %u max_resp_sz %u max_req_sg_elems %u max_resp_sg_elems %u\n",
>> +             ident->version, ident->max_req_sz, ident->max_resp_sz,
>> +             ident->max_req_sg_elems, ident->max_resp_sg_elems);
>> +
>> +     return 0;
>> +}
>> +
>> +static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>> +                       void *in, size_t in_len, size_t *out_len)
>> +{
>> +     return NULL;
>> +}
>> +
>> +static const struct fwctl_ops pdsfc_ops = {
>> +     .device_type = FWCTL_DEVICE_TYPE_PDS,
>> +     .uctx_size = sizeof(struct pdsfc_uctx),
>> +     .open_uctx = pdsfc_open_uctx,
>> +     .close_uctx = pdsfc_close_uctx,
>> +     .info = pdsfc_info,
>> +     .fw_rpc = pdsfc_fw_rpc,
>> +};
>> +
>> +static int pdsfc_probe(struct auxiliary_device *adev,
>> +                    const struct auxiliary_device_id *id)
>> +{
>> +     struct pdsfc_dev *pdsfc __free(pdsfc_dev);
>> +     struct pds_auxiliary_dev *padev;
>> +     struct device *dev = &adev->dev;
>> +     int err = 0;
>> +
>> +     padev = container_of(adev, struct pds_auxiliary_dev, aux_dev);
>> +     pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
>> +                                struct pdsfc_dev, fwctl);
>> +     if (!pdsfc) {
>> +             dev_err(dev, "Failed to allocate fwctl device struct\n");
>> +             return -ENOMEM;
>> +     }
>> +     pdsfc->padev = padev;
>> +
>> +     err = pdsfc_identify(pdsfc);
>> +     if (err) {
>> +             dev_err(dev, "Failed to identify device, err %d\n", err);
>> +             return err;
>> +     }
>> +
>> +     err = fwctl_register(&pdsfc->fwctl);
>> +     if (err) {
>> +             dev_err(dev, "Failed to register device, err %d\n", err);
>> +             return err;
>> +     }
>> +
>> +     auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
>> +
>> +     return 0;
>> +
>> +free_ident:
>> +     pdsfc_free_ident(pdsfc);
>> +     return err;
>> +}
>> +
>> +static void pdsfc_remove(struct auxiliary_device *adev)
>> +{
>> +     struct pdsfc_dev *pdsfc  __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
>> +
>> +     fwctl_unregister(&pdsfc->fwctl);
>> +     pdsfc_free_ident(pdsfc);
>> +}
>> +
>> +static const struct auxiliary_device_id pdsfc_id_table[] = {
>> +     {.name = PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_FWCTL_STR },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(auxiliary, pdsfc_id_table);
>> +
>> +static struct auxiliary_driver pdsfc_driver = {
>> +     .name = "pds_fwctl",
>> +     .probe = pdsfc_probe,
>> +     .remove = pdsfc_remove,
>> +     .id_table = pdsfc_id_table,
>> +};
>> +
>> +module_auxiliary_driver(pdsfc_driver);
>> +
>> +MODULE_IMPORT_NS(FWCTL);
>> +MODULE_DESCRIPTION("pds fwctl driver");
>> +MODULE_AUTHOR("Shannon Nelson <shannon.nelson@amd.com>");
>> +MODULE_AUTHOR("Brett Creeley <brett.creeley@amd.com>");
>> +MODULE_LICENSE("Dual BSD/GPL");
>> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
>> index 4b4e9a98b37b..7fc353b63353 100644
>> --- a/include/linux/pds/pds_adminq.h
>> +++ b/include/linux/pds/pds_adminq.h
>> @@ -1179,6 +1179,78 @@ struct pds_lm_host_vf_status_cmd {
>>        u8     status;
>>   };
>>
>> +enum pds_fwctl_cmd_opcode {
>> +     PDS_FWCTL_CMD_IDENT             = 70,
> 
> Please try to avoid from vertical space alignment. It doesn't survive
> time and at some point you will need to reformat it, which will cause
> to churn and harm backporting/stable without any reason.

Yeah, that was inherited from earlier work not necessary here.

> 
> Thanks

Thanks for your time amd comments,
sln



