Return-Path: <linux-rdma+bounces-8759-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DA8A66185
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 23:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBDD1886AF2
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 22:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2CF204C39;
	Mon, 17 Mar 2025 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h9kEHX5F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F8156F4A;
	Mon, 17 Mar 2025 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250296; cv=fail; b=BvGw875vENxec1b4k2Sk4lfy7hADKmWtZ7HqU0v9h9JlR5K9evzJ9qakwFmvR0q1JeaPjsI7QNw/xDcZ7lmZlDoqqfNb/SC0qZZ9lJtW4ZSU1pzaz17kPlhHwxGToV46koHErhY+67QLQRqYWFUw824iiPDLr1dQCcOn29//aso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250296; c=relaxed/simple;
	bh=OsQqmFZ9lEuX4huKTKoc8MVLQstCVLq25WGY02eLH+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UETqioT0/ZVYHOEbxMzaFCVusc9j4JbqShxJo3+ZzAjaOiATPJLEDsCFF/6UViV56QOw3oZB+9rK0fjPO7+7frRv4cHXtnkzeTlzyc6ULUtR6z0yvLF/eMg9mEzFXXZLeoAw92eybm+SxyicpQMPzyd9WCdZq5CL4e7K0VL/xGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h9kEHX5F; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsJECBKfRmVtaacndOjFvfCLhX4y/M6Lltmdw/wH8mfWDseBSsUs9yAQcXPI5AV9teIrNXvmQjq6YhEwKwr7sIM2jJ53b/V51R+zvMQMHeLFoKQ9IcuAxz1AhxYWueynXpUaGTwh/IqKTSHJdYynQC83nW+gGHI98lTY0nwIUE2BG42Y0HdzgaqbSxmCX+8g5/rZ1JiHML/4SCBija8Z3mZCtGswrsUxzdTT+bOjJV9cwm5ag9/BcK9EAU/FcqkIQVeu3Ihx5BtQbhM/81XviT6oP3g11pNDKZr0bo7Jb3pd0GYADnHrTsKZO8Ebo/Ac0RbmLiTrLPYxUCU2k8Zg9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7m2UTaXF5nijElJxP6isDbgdhYVIDVxiysc+80OB2k=;
 b=NU0/4+oPvHiFtxVAPFOwZwadY1ACIjUWNU8CCPuMuSIqrNzN3s5oUKfN4nI/UXJ/PYjpj4Jh2ArH2rj9Uu7NMy8kzc69rJogxfbQXriiH8UdqM1OAcWhfJ/NV78rd11Dob5z2L6uVdy3AeGwmGSOMUeB9s/nzX73MrXVMfTAkUPvmCq9RdRmK+fKG7VcjIntzK88XwldkVgyAJqkVKa4ZwhpZIz3arKSKcBl+SSDEz4BxYSlSuciCq7QrE4gh195CjS0lZPK0q9lZDEGKI2NNvXn5lJLC9ZU+JJfv9d5PcmW4lNK0jYQNE118nzJXonnrSZiyt32MMbsiWx3ICK8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7m2UTaXF5nijElJxP6isDbgdhYVIDVxiysc+80OB2k=;
 b=h9kEHX5Fr6LdxV79ByMf8F/ltguQkYmkHCnna6yfyDoIATtUWxr0+W4Xgt2maZUQBHhS3PIQw+5KIiA9udz+J+ygHYGlO9JTpRbuQwi9EXJHiKXZOLwG+Wx+W5NoM4ZavQo0nCTTxK0o+1g45cJuYCbodcMHPG3x0oJgEVfP9co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 22:24:50 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:24:50 +0000
Message-ID: <90aefca2-1799-4232-9db5-8d708f1e5f20@amd.com>
Date: Mon, 17 Mar 2025 15:24:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] pds_fwctl: add rpc and query support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dave.jiang@intel.com,
 dsahern@kernel.org, gregkh@linuxfoundation.org, hch@infradead.org,
 itayavr@nvidia.com, jiri@nvidia.com, Jonathan.Cameron@huawei.com,
 kuba@kernel.org, lbloch@nvidia.com, leonro@nvidia.com,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, brett.creeley@amd.com
References: <20250307185329.35034-1-shannon.nelson@amd.com>
 <20250307185329.35034-6-shannon.nelson@amd.com>
 <20250307233811.GZ354511@nvidia.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250307233811.GZ354511@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:303:b4::10) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc6e25c-e3da-4d58-f651-08dd65a2884c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjhNUUxMWkp4S2JQa0tIVzRSZGFCYzVlK093dmllRkxPb0doTmxvckxIK1Vp?=
 =?utf-8?B?NzNDaEJpNWY1WlUxaW90VGthZWt3Q3R0eEhjVHB5RzY4VjB4enZTeFlkUW5r?=
 =?utf-8?B?WGNzdVk1NCthVGkxZG9MWWliK0NyT2RwazRWelN3T0hZRWJUVzk5RVNBdDB1?=
 =?utf-8?B?MVZwK0J3ckVuZkY1Y2c4S3JyUzJzUFl3WHZ5SStRaE9yTHlrQnY3QUc1RU94?=
 =?utf-8?B?anJXckMzY1U2clE3Z2tINnZuaFpFV1pGSG02N0xFOEpSRG1VNmRQTEtrVHVt?=
 =?utf-8?B?NGdPaXdTTWMzdzdSMXlEenNmQktPNThwTWpScS80QVdQUzl1a2JNMkJ5cWVp?=
 =?utf-8?B?MzZSUHZkZHIvbERtcnNDZXVua0J3VUxVTkJ4YkJCS3RKVDlJWlNIeGovSHd0?=
 =?utf-8?B?WWtLYlV2dUNPcW9JbTJmcERnNDRYK1VDTVhTM21JclFEUFlLa29JaisrZXVC?=
 =?utf-8?B?Zzd5QmlsZURMRmFDM056bXoxYlgvRnZqYk9XNGxwdHV5MWZZK0xORlFlcWxX?=
 =?utf-8?B?TlNzcU0wc1RkckFqY3FQNnJoM2R1ZE5MamVJU3R2Z0xuYlBCTDFVako0anJx?=
 =?utf-8?B?cCtla2c5T2VZVHRnM1dpbVR0RURTZ01DOXpud05nTm5XMWxQc3ppdFJnc2xC?=
 =?utf-8?B?QU56bTA1clJScDROZkRLR1p1WkkvRi9UNTk2OURrN1dkZ0QzZS9sZTJWalBQ?=
 =?utf-8?B?RmZjTmRRSkp4TURIbEZnMUdxR0szSU1RckYxVDk3bnphWmViemxMcGNtWU9P?=
 =?utf-8?B?SDM0MkR3VjVPZnhWS25NODJsRjNsZnpvTVduZGFoWGhsREkvVWxlUjBFN0hB?=
 =?utf-8?B?SWhMd3AvcStieXRhNjE3L0RxMEZUcFNreHVjTm9aRE0yY3pKYTRwNWJrOXc2?=
 =?utf-8?B?anpBYjdrMGpGZTc5TlZENU9TbjhsTlh6QXZac1QwcEU4WkJJRjhWK1ZIRUY1?=
 =?utf-8?B?TFgrQ3BCRU1xMFBTd2x6c2xHUW4rSWsrTFlVbkNLbXk0M3RVcVJFYkhnMVkr?=
 =?utf-8?B?Tml4RmdqbkRvZ2NkT1RZUko3am9kcjhZbHlTODNDVlhlcU1lRXVUWElhYSt4?=
 =?utf-8?B?RnhIeDJiV29VQkpYQXNPVHpOdWJSUUZWN3FkUzJ4cXZTdW5Zclp5RnptZ21r?=
 =?utf-8?B?VGNqMkREY0pOV1BwNytXMW1FaVQwSkdKaFRnanROU3RDTEd3dHF5YzZjSHJp?=
 =?utf-8?B?OHF4VFBjOEE1RW9sMTRzZ3NSa2lxMlBpSkZJUVB3UEdHcnVDN1ZCekVIQ0ha?=
 =?utf-8?B?V04zR3I4K2JUcHpkMGNackJneGd3TjRNV0Evd2JKRlgxN0xZWjRiR0JMTmhF?=
 =?utf-8?B?WVFEREZscG5PNG1NYlM4MVRIVjRONHE5ZVFEeU5NYnA1WWRVUitrRVRrQStr?=
 =?utf-8?B?ZWZ6UVE2UUN6dUZzYWNQaFpMeWVYYjJHeFdnMVR5MXBIWk5MaUQxUXdjVkZO?=
 =?utf-8?B?TUFHKzdvSXA2TDdQendVa3pjNlJNT0Z4VWtkeGtqOUlVWlkwMER1VjZPOFpZ?=
 =?utf-8?B?QVhnVUFsNHRSQUhTMVdnaVFsTzFBTHRLTmdGNU1UNHJ1NDc1MndTY2plckpQ?=
 =?utf-8?B?Y3FueXdNaDRaSmR0aWxrSTMzejVHL0tBeHM5cU5nenFJamRVMW9TenQ2WGRn?=
 =?utf-8?B?dXZsOFk2eGh3SDJvUnkyR0ZOSFIycGo2N01OWThiei95QW5JQmJxTUpWMmNC?=
 =?utf-8?B?M3NwU3JiMjJsOTBSUDNHS0sxbTFyRWxaT2RSMmMwWVY1T2J0WkZkSmwzTi8y?=
 =?utf-8?B?Z282OGJZSFlLeXRvazBQcUx4ZnRZNUtRNDJKRjAybFZub1JRenY0anpualB4?=
 =?utf-8?B?VFR0U2tDdEJIWWVPdGdiSXJZcnc2Wk81eHBDN3daZEdQSzBydTdvMGNpOURr?=
 =?utf-8?Q?Xg2mJ/6VoGsAB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3I5R1hXc29mZjgvMkMvRGNQVjVSQzRGZU03eFFrQzhKVUFCZ3F6VWRxUHRy?=
 =?utf-8?B?VmZkMUFudGxrSldNYlhWTHR3Q1lqeHNmVmEvZE1RSEYwNWppMWpncXp6STBK?=
 =?utf-8?B?N3grWFlCT05pdTJSSHRGMTg2aFpoQXVodGg3RlNPRERNTzZtTjNXNUErWEY0?=
 =?utf-8?B?TFdaMmo4MkdwdzB4ZnVWeFdQY1BiYnpFOUk3VHBjS0xYbm1mK1V1MlNTSElS?=
 =?utf-8?B?WUY1OHI0R2JQR0dzcVRtYzVJdWFBWFFheElsamduMkhLa1pRakdnVmF4OUkr?=
 =?utf-8?B?VUNQalJjZVhvcjZBeVE5RDlqQ3ptZjJQUDRncmxNRWZRRGFvMmNGdElpRnNr?=
 =?utf-8?B?SUNlSmlralRONXozMmhiUDJYL1pSS0xKWDNvQ0F2cXExNXZaamUyVEVNK3Nj?=
 =?utf-8?B?bHFmUWNGVm93OVh5L1pMOU5HRW9wZUpQelRneTg0TTlmZlV2c1Y4VGFCQXho?=
 =?utf-8?B?dDlRZ2htem85b3FjcVBNNi9JYjNJSlMvWHhaMlJBSGQzZ2VjRjYyS1Y2KzZD?=
 =?utf-8?B?RUlqRmRZRXdyajhOMjdXeGExUGp3ZThXdUtYbmdNWXlyakppcnhiYkR4TGpV?=
 =?utf-8?B?MHo4azQ5U2pWamZRRmVBYmZWa1RleVlPVXBuL3RxSmlqWTBFdE0wc0RkY2lk?=
 =?utf-8?B?ZzJnK0RUYTBENzBZd0liNWk4SW9lQUg3UHlFeWxLNnp3a2FzUUJCUTFiY2Y1?=
 =?utf-8?B?U0dtSHNyMW9DOUJWOVZWNjQrUk04MjZVSy9hSTBDNG1BWERSUlYxRGxSQis3?=
 =?utf-8?B?bktSTHNMUm5XdmFsSkFINEVuWkYrbjJQVnBEdEtBanRxWG16T2lUSW4yQ05W?=
 =?utf-8?B?aHNscWxZU2VPRGxHUUFBV0wrNmsyWDdZcytORjdEQ25nbmxyOElMcGNHTytW?=
 =?utf-8?B?Qkkwa2dtVStIMjdnVTRvZUlvbTVuUGV4Wis3Y3V5cWNvQ0srUWF2dWRCR1ZX?=
 =?utf-8?B?NDErcCsxUkh6WmtadCtLRGt2c1U5RXFGN09RU0pXdW5yZEpiVEJwc3NQd1Zn?=
 =?utf-8?B?blQzQzZZdnBENXZHTU44U1NkbHpvTmN5V05ucWhoSFhOUzNGVlRIbEdZT1Bs?=
 =?utf-8?B?R3huMUsxZENRWkRDU2dwR0Vha0ovem9FYVlDUFp6anByNm80N2xMMG5MOE9s?=
 =?utf-8?B?QWNmK1hPMXdBUjNpOUNjUEo2UHhJY09WVTRWMWN2RGRBVXgvZkt4REFITndP?=
 =?utf-8?B?QVc3Vk9TMTd4WDBKNld4NjBxRjZvZHA2alp5THB3MHNUWUpYWjgzL1Jwc29s?=
 =?utf-8?B?S0JRTk0rMHo0cmFiM09HL2pobTA1bk1TQ0xWZFVpaU1KbnYxWUxsOHNKTmcr?=
 =?utf-8?B?L0xHbVcvYUJPMGJEcHJSTlBESGRueGx6cFRsWVZOMkwxYXo5c2daN1I2VFlk?=
 =?utf-8?B?TVNiTHdrOWZVUDRUQUFveDdoK29uRFZPc1dhSzZEMTM1c0E3OTRhZkVKUmU3?=
 =?utf-8?B?KzV0T2RYRHkrZzU4Y0xSNWJYTzJCYldleG54UDY1bnY2cmdkUTVYRHV1V3Iw?=
 =?utf-8?B?MEU0c3NXNWtKOHZFV3UyZ0hLUGxhelAwTDQ2VHNXSFFydzJpK01kVHpTclZx?=
 =?utf-8?B?ck5mQ01DaGZtcWlkMEJTWlVZcVpLejdFOXBhTW9YTkNhNlZlY2ltdTE0VGZq?=
 =?utf-8?B?Z01DNytwbEVXWGtqcGJWR0xOdGNQN3lTcEVOcEZDQThZakZzVHgvTXhyRW5D?=
 =?utf-8?B?V2FGaXUyZTBWc1NMa0l0dDZYLzk3ZlhVME1FVmNwaytVOWoxM2dzb2RXQ2x2?=
 =?utf-8?B?MVZBWFM0ajEzQjYzSUY1ekJRVXpxNEQzMzVlWlpnN2pqMmNTbGZGbTRFR2lS?=
 =?utf-8?B?cGFOS1VJWSt6bDVwWlB2a05WR09UUWFSWWZTbmJ5RVViazFodUptalQ2VjBC?=
 =?utf-8?B?SEh5VklvQmtVaU5CNFlVZFdDTlZydHZlajZlZmZxckJLZDZ1ZlI2TDBLcjVn?=
 =?utf-8?B?Sk5UbE5iTWNWUWhjZU9wRCt6Ym55dEdYWXc5V2hsd3RqZXVsY3hHaElycXNV?=
 =?utf-8?B?Y2NaWGl5WkZhVXpEaFJNM1dNTG5WR1pNZUdvV252dkJjdUkvSlNBOHJldWVm?=
 =?utf-8?B?Nm5WUjF3U2ZCTm1ZZ0NTY05rQnI5bkNWOXg3WWFaNW9IY0VTVTIvemlWYWRF?=
 =?utf-8?Q?NThhkGxNvXc05CFDseII2Fip4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc6e25c-e3da-4d58-f651-08dd65a2884c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 22:24:50.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiQjJWhukBeF1PIOnPjEMK9dfrb25tps4Wp7pBV0TR1IGRZEgkBOfbXg76NkNH0AGQyR8b26ztkpc7B5uIqaZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642

On 3/7/2025 3:38 PM, Jason Gunthorpe wrote:
> 
> On Fri, Mar 07, 2025 at 10:53:28AM -0800, Shannon Nelson wrote:
> 
>> +#define PDS_FWCTL_RPC_OPCODE_GET_CMD(op)  FIELD_GET(PDS_FWCTL_RPC_OPCODE_CMD_MASK, op)
>> +#define PDS_FWCTL_RPC_OPCODE_GET_VER(op)  FIELD_GET(PDS_FWCTL_RPC_OPCODE_VER_MASK, op)
> 
> ../drivers/fwctl/pds/main.c:302:7: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    302 |                 if (PDS_FWCTL_RPC_OPCODE_CMP(rpc->in.op, op_entry[i].id)) {
> 
> Add:
> 
> #include <linux/bitfield.h>
> 
> Jason

Odd that I didn't run into that... perhaps a .config difference.
Sure, I can add that.

sln

