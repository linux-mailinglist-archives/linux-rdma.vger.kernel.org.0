Return-Path: <linux-rdma+bounces-11802-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EDEAEFB08
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 15:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62BE169404
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E72274B37;
	Tue,  1 Jul 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="FpGhhZHn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2098.outbound.protection.outlook.com [40.107.236.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE6827584C
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377453; cv=fail; b=qJrW/3u8DP1YeGAmAEHACxRqP2vNJ8tIwCChc0yjRiVnQk4GQk0htOvyqmr9PgruzJ5f1Wfe3mw1JXH0C/n2qLaGHpirAjzXqqyjvmkVwSNoz1LF/MABnXthon8LUucGl0bhVEOWeBAKjHdZKfWSJ1YhbHz8fJngAj2+eOQbQoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377453; c=relaxed/simple;
	bh=oIU02fRIbFM1U0QUizrOtbl7fWjsnT+104W+clG3daA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GE7pTUtcPOLXGRVi3K2nDmUxHZgf6Mtt/WVOLi71OE8z7dcizCdAQw7xcP1xkBTghriWABrQ4Luk3FEHAaCrXd1fMaw7Lk7Lz7XfO4C6aje5GLoIIyldnHNqsESwoEKiPRhY7JvK9Y7GSYRVfCAaEk+ToLIWhUTfTnVfM7TCUEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=FpGhhZHn; arc=fail smtp.client-ip=40.107.236.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2w7iCpXDX9MdV0HwMF+KyIarOiih8QK+GqJRg70a7HDjgQtliW7jgU1/yem7T1Keh4Ui6zA1FG4v/dbObauL7S2fUhx5FBvvfYMlJHUJ7SsGYCVIe2QNrOkbskMHsCsqpUBlBU9RjK7MWaSJv4O1Ea3yIE20vINc5wbEc4tU8wc71MhckrZK0kuh2VEKISLv52vzd+1wu2BU7FrLlM4g12A7b9cIFi8c+b866EcVfnlFpvGWpcwFu95+thzPVyf8Z1/LwW3lZ5RJwEIwH0BU/zvOB9RRmctUcWXoUtggUfeVfC9DrjhCgy6THDmKHxGfGqFqnKjtSFiPrBbkz/6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhvpq6Yzuq/ivTZ3rPs6IYoQt3S0XBIQWeSTZmdXCUA=;
 b=WcZO+AwsKga+9fFWrMsdvlwfyzAx7Mum3gwc0zYAPPNpl29gA5NSqeupgkVYQRz+j5eYElIGGK6ZkbMdX2v7BNEOpn6pYuos1/eXdafTYKKWX05/sqY+anY9BTwWKPnluSSVFkN2PV32vqLN8o1oTGEh4xM49V5PPQNHXUHUgfSkWX6kHLVkewnCi/30xZmbQ471hrSu++TdK1lDcD9Cdz0jpqfb6fBtoDtG+MWF/3Wpn6KMlHxJx8BkqDKC3RJLTTo0f4Pw6iGJI92AfyIj/sgcU7coNRC4OGyhB9ZgkrS4pSeeGZ8KqWMRDv+irRfk5+IMkLuswWEkq53B1d4LtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhvpq6Yzuq/ivTZ3rPs6IYoQt3S0XBIQWeSTZmdXCUA=;
 b=FpGhhZHnqkfZqLdMk1jEqUMV+2vRQJXwG/mBg+B4vv77asU43W5nT9YT+HGXK1XQTuqTvMvCDcBtHVV8Z97AqaTJjVjfJQbCeLNaz4/k+PCaOH6CVnjs/8Uz9ns2ssNnNaHQL9/4INHqDEnNUFe4wu20G3oYQYXW7vjalY89bJLMFAcG20pPKnIck6nqw/YV+E41mfIzlcfzx6ge/WJy5SYF0m73JsOnUn1NXxCl8vJMboCgvHlUj+uWaZ5FXHEKYQcMI0fGNB6h6tHe7pBn4slICWPsUXNvJzGrsz+BMkwETf5Ceu8zceK9FlrbpH6KmwK7FSJHP8zKfaCC7l/1uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 CO6PR01MB7482.prod.exchangelabs.com (2603:10b6:303:142::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.29; Tue, 1 Jul 2025 13:44:08 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%4]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 13:44:08 +0000
Message-ID: <5dbcf9f6-cfe5-42f5-880d-d0fd7e8bcb3c@cornelisnetworks.com>
Date: Tue, 1 Jul 2025 09:44:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 06/23] RDMA/hfi1: Remove opa_vnic
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129741787.1859400.7033099190800356659.stgit@awdrv-04.cornelisnetworks.com>
 <20250701123853.GD6278@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20250701123853.GD6278@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0379.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::24) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|CO6PR01MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0bf124-b443-4697-57f2-08ddb8a55a1e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDNRRml4WEdPeTNYYS84Um9WT3dyaUI1S1dMNVRFTXN4UGw0RklZTlFtZ1pv?=
 =?utf-8?B?NW5OUmt2b0svYWIzbkd2bjVSUTQ4cTFNb1lhalpaV2RIRnk1WlE2VDN5T2Uv?=
 =?utf-8?B?VUZWKzdocGV0R2JvV0xOeFRXeUlxVUp3NzFIc2NNZ2FNQ2loaklKeFd0enE3?=
 =?utf-8?B?bTFIVnNublc0Wmw3aFUxTHl6OS9HOS9TYTkvakZPRUF2Zy8wVWN5Ujg1Ry9Y?=
 =?utf-8?B?Z2M2SGhvdi92OFFkRW9vdUQ1VDVpVkJEd2JjNm14anEyRlpVN3Vadlk4UE5S?=
 =?utf-8?B?dEFiN0t5RytRTmgxaXo4cm04ZFc2T09HVUdPV1FTeWxmb215UE9TVk1QZXRY?=
 =?utf-8?B?OXdpT1ZaSnErbHNkeTZGdFRXNVlHQ0FOTVJBaTdLOFFKZWFPaWs3ZldNNitY?=
 =?utf-8?B?YWxhUG5GYVc4cThCcWhsakpqWVhlemZCcmZscVVYQUMxSDAwVDc0VnRadGVn?=
 =?utf-8?B?ZTFLMy9UWFpkM0lhT0I4WU1yanFobG9JbkYwdW45TURSeU9zc3N3RWI0V2ly?=
 =?utf-8?B?MlU4cDhUVEg0SEpKbXd4ai9udU8xN3hRemQ5cEVGZ1NNcU55S0gvdlVCcEJu?=
 =?utf-8?B?OVBobkplZjR2Rm00V0lNOTFFMGQwV3lEcmZSNyt3Q3B3MFNUZkRnUzB6UmFj?=
 =?utf-8?B?MCtwc2wyYUloSmRPRkQwRFdxVUMrMUF0Z0gxc0s3ejRhc3BYdW9raExWSG0z?=
 =?utf-8?B?ZWNwbUZ5emFuMTJFdUlCZ0RUVUxmbkJqblgvK3h2WllrZk1hK3N5VStHUFIw?=
 =?utf-8?B?azA4bkRZalRoYWhRMWt6aG02TktKTy9YOHJ2VHNUVjhOYjRXMDRXWUtVNFVl?=
 =?utf-8?B?am56SnQ2aEc0VUM4aFdxWHZpQTNIcFRwZHFFQVJXeFArWXlXeUc0ZmNLaXhl?=
 =?utf-8?B?M2pYSnFValNseVU2ZWhwRTVGZWV6dlF4MWM0QUp3YXU1bGxDbTFCN3M3RGpR?=
 =?utf-8?B?QkNPOWFCRE5VR29icXRGcVI2VW9JSGZoUWdyeEVNRm9QWnlrblVMTUZqYjgw?=
 =?utf-8?B?S3orbktNbGZ5RHRhS29xRFJKZUZTWThDbExRSytCSlpabDUwV2lBTHljVTBa?=
 =?utf-8?B?a1BPMjd0SU95T3NJSXlNVnRWTUdoVEE4d21YLzIzdlVRTzkrUEZmSm9OV2lp?=
 =?utf-8?B?TCt6ajgvSDZBcWJHd3cvdldNWVZOcTFuamxvMmFmclVwek0zWGRWRy9RYlZS?=
 =?utf-8?B?T0pWQ3pZYUZHVzNVV1QzN21JZUJjSGZPN01TNjlPQ1FTVkZ0S3JrY3hxOFVR?=
 =?utf-8?B?UDljdGw5dEhzWGp5YlloUnBQWGxHNmFxVDZyYmM2UmtDbndMaTRtT3hhSTVM?=
 =?utf-8?B?dnhtWE5xZUlBV2ZrZThZMjd1TGNwNWhBUVVMcDMzbktId2V4RTU4d1ZGd05a?=
 =?utf-8?B?bnhGamxHclMrQVVtL3lZQXhnWnhxNUxPaUZxNHc0bVBIaUdNMWdRQVZkYkI3?=
 =?utf-8?B?TENlTG55L3A3K1A1KzZVcWNqL05pc29PL0ducW5SVXljNXFrdWJYQ1hyRmFi?=
 =?utf-8?B?TXo1SHl5V09ySmFTQlF5ZFpqRXNPVkhzQzZBYzk5bWRsUStReHQ4OFJjYjJI?=
 =?utf-8?B?STA4N0xOVjF5eHlmaXo5VlgydlRzVmhVNG5yS0tkaVdhQW5kOFVhYVY2dDd1?=
 =?utf-8?B?MWw5MkNhQTJzZzd2TWduZkFxdmZNR1VLREp6VCszMmxZLzdSYzBzS0JwMmM1?=
 =?utf-8?B?OURwZkZrTkpuN0hkV20rbytoWkJ2MnJUdlhGaEYyYmlsVmpJamk2eWZqMDht?=
 =?utf-8?B?SFRiZG9QWldBZVZkcm9neW16OUlPcVVRUklyeDNTZDlDaENVdXFhWmdUek1p?=
 =?utf-8?B?a0xRN2xSU0pzZVp5cklEN0ppWUFqQy9CaGZSemh2V2dEYUFxU0tTdXFrZjR0?=
 =?utf-8?B?TXRaeksxYlRmWkdRbTlOWW92Ukt5TmZ3OS93RllwSlRxRnUrVDRDNHY5Z0Mv?=
 =?utf-8?Q?lNx8uTdMEIQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SndML2ViblMrK2JtWlE2REFHWGIvZm9HcU56NnhjbmZ0bXBUakF4UjBRRFk4?=
 =?utf-8?B?Y2JJRmIxNmxHNW44L2gzVnR0R3FKcks1VjdoOFZsK2UydlFyeTczMG5KLzZy?=
 =?utf-8?B?ejZqU2dLQ1BRZFZocWxXNEVWalZ6NUM0NW12ZmF0SE41M0tGcCsvdnZVdTBr?=
 =?utf-8?B?Tm1QQW5jNHY0bFN4NXVBK0pwYW8vWTNrOGc3ZVdPNmdlR1hLVHQwaGthUjlx?=
 =?utf-8?B?ZU5ieFhMeWgvUk9aOXYyWnh5RGFvYzNRZlF6T1U4aWF2b0RneU4vVHk0dnR5?=
 =?utf-8?B?QkhLZUY4YnpwZjAwNXAxUmtyQmV6ZHhpSC9LRnZWWXJCL205T1Ztc2xxUllC?=
 =?utf-8?B?amNBbTEzSWlpU3IvcWxSeUFtcVprRWk5bW5OWExaQ3VHZTVQb2VIcC96cWR3?=
 =?utf-8?B?YVl3SEFqbHZzWDBKbGxYUjhEUVFSdVo1SVQ0U0RXSzhoclZpWHNQZ0Z1WFBy?=
 =?utf-8?B?M1hrQ3dxbWRBekNzUkduYzFhbTVBWEdSSWUyR0NMWTdPQndRWHBucGwvS2l3?=
 =?utf-8?B?Q3RKMlpZakN2YWdJUzB4U1ZnVWxzNnJrRzBWM3g4SWVjSXlrVTFkekJvNE5H?=
 =?utf-8?B?YmJxR3E1d0RxWTZVYTBzNm12QTdpS0FubE00aVNULzE0Qzc5Nk1zRmJ1V0VZ?=
 =?utf-8?B?RUFqci9wMTJSMHNBTElZSjQwZE5IcDZqa0FNT3lvcVhCMUtycldBNWVUTmFr?=
 =?utf-8?B?THhwa2NRS010QnM2dmlISUszdVFBYmJZMHJTUnFlSHFLak5UNFFydzMyd2JP?=
 =?utf-8?B?WVd6eTFJSVh2WWlBcjBaWHlXMGZQVUhCVWlxcThSbDFJRkhuRFBLYytDYWRs?=
 =?utf-8?B?UENKTnBLaXZIbzRhYUhTWmkyZVFsTnVnbjJQTWJXajZIM0NiQjFaNS8zN3BC?=
 =?utf-8?B?Q3dJREVqRzlSb09nMmNvZEF2NVp2c1N5K2ZvanJCVnBLSDNSMU95UmI3Zytj?=
 =?utf-8?B?R3NhS3d1R2dId00waVR1NkFzSkFjWkNqUnZEdWdPRDJqLzV4Z0RVSXZTanZU?=
 =?utf-8?B?NjdkSlgwOEp0NlF4UXYrbzFJNzRnQi82TXAvSWtmM21JcitiUjJIYWRmMUNi?=
 =?utf-8?B?SktFQ0ZmZ1lsaXhIeVZXbDVYM0ZxbTQrUXUzbXVhVHZnNjZleXk0Y2JlKzRT?=
 =?utf-8?B?bWk2UG85a0l0cVNuTmZ2dUJpeXRibnJvczlUaDhCcUhrNFZ2dnViRjhvS3Bz?=
 =?utf-8?B?MlZLRWo5eDhiN0F5R25XWkJkTkpnWW9CdFp4STRFN1FFQlNFYUY0ZFl0NUJ4?=
 =?utf-8?B?dU53d055dktOVjVvcDluZ3FEUHJOWWMvbTFtRnQxWTdZZTdKY20xYVpKRWFu?=
 =?utf-8?B?aGVUVTNXdnVjbjlYT1M1QjBkbXF4dWNwZCtsZ1dFelB5TWFnc2NuNXBmMHhv?=
 =?utf-8?B?eUJLa3A4YUxBTGxuRW16VEVhMDNlenBaWGQ5OFB5VDRSZ3U0VmxaNUV2amlP?=
 =?utf-8?B?NUxxeWthbEV1R0xaREVWT0ZraTRNMTdlNTBxYWIwYk1KV0JpbU9TbWtraWF1?=
 =?utf-8?B?WlQ1eGpQU3M5czVCUG9qM1RYQm5PK0V4VlZDSXMvTmV4aThWeExLWWMvL0Zp?=
 =?utf-8?B?Z21ocnhlaFVsTnhBbE1qdTZRUCtEQUR0Ym1Cc1hTNWl2WmpuenpQUzRIWmNO?=
 =?utf-8?B?THg4Uktxbnk0WDZZNzZCSDRjYjB0ZStSdWpxMUdCbVhjS1I0NUNKeFBSY2xx?=
 =?utf-8?B?NGFhQ3orTDRYYnNWZHR5WGl5VDFHQ0hrZnBQaGtUbC9XamVKbGM0U3JWb1hF?=
 =?utf-8?B?REFHM1VQb3gyekxDZUpIRy9WMWxMMms4STVBUC9XOGNIaU1NQUlKbnpKQmN4?=
 =?utf-8?B?WWpsY0thY0dpeTYxazZ2WURHcjZtUFRGVkEwenRpTDBncC96czVKczN6L1ZV?=
 =?utf-8?B?a2lrOGlFTlhJWVhIRTQyK2pVN1FWTk03dzJJSFVqdHlnb21XRCthcXhnTjNV?=
 =?utf-8?B?Z09PSUtwOHFlTWRoa2NPUzY3TFMzdEFyVTRwYnhUQWh1eFlFTTZZYmJmQm0r?=
 =?utf-8?B?RDl3Tk9lOHlMZHVvVW9zbDJKVHVTNCtQSXBDandBZndESVpEOGZKSGcvbVl0?=
 =?utf-8?B?a21iZXBaajc0L3o0T1RWVzZPNjAyTDNLMnhXZU5LK0cvcjFBVzg2RzNpZXp1?=
 =?utf-8?B?NnZmK2tsRjlPUFc4OVhaMFQvdVBOSFN6VXpsWld6Mk9WQjk2UjJlcHRMOWY1?=
 =?utf-8?Q?D3E+2qlKkBmvOcPFVslC48A=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0bf124-b443-4697-57f2-08ddb8a55a1e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:44:08.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9II0HDN9zSM4ufnG2797dTkm7AjlMGlynemNPv8cfHaGKsGLWYxOKUfetYuL7jnaBcNxWjpQK4LmZm7y2tZtHJwz7NslEHTv1huQriqGMEu4W4rx1ieKHiwsSyl4tn/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7482

On 7/1/25 8:38 AM, Leon Romanovsky wrote:
> On Mon, Jun 30, 2025 at 11:30:17AM -0400, Dennis Dalessandro wrote:
>> OPA Vnic has been abandoned and left to rot. Time to excise.
>>
>> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>> ---
>>  Documentation/infiniband/opa_vnic.rst              |  159 ---
>>  .../translations/zh_CN/infiniband/opa_vnic.rst     |  156 ---
>>  MAINTAINERS                                        |    6 
>>  drivers/infiniband/Kconfig                         |    2 
>>  drivers/infiniband/hw/hfi1/Makefile                |    4 
>>  drivers/infiniband/hw/hfi1/aspm.c                  |    2 
>>  drivers/infiniband/hw/hfi1/chip.c                  |   54 -
>>  drivers/infiniband/hw/hfi1/chip.h                  |    2 
>>  drivers/infiniband/hw/hfi1/driver.c                |   13 
>>  drivers/infiniband/hw/hfi1/hfi.h                   |   20 
>>  drivers/infiniband/hw/hfi1/init.c                  |    4 
>>  drivers/infiniband/hw/hfi1/mad.c                   |    1 
>>  drivers/infiniband/hw/hfi1/msix.c                  |    4 
>>  drivers/infiniband/hw/hfi1/netdev.h                |    8 
>>  drivers/infiniband/hw/hfi1/netdev_rx.c             |    3 
>>  drivers/infiniband/hw/hfi1/verbs.c                 |    2 
>>  drivers/infiniband/hw/hfi1/vnic.h                  |  126 --
>>  drivers/infiniband/hw/hfi1/vnic_main.c             |  615 ------------
>>  drivers/infiniband/hw/hfi1/vnic_sdma.c             |  282 -----
>>  drivers/infiniband/ulp/Makefile                    |    1 
>>  drivers/infiniband/ulp/opa_vnic/Kconfig            |    9 
>>  drivers/infiniband/ulp/opa_vnic/Makefile           |    9 
>>  drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c   |  513 ----------
>>  drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h   |  524 ----------
>>  drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c |  183 ---
>>  .../infiniband/ulp/opa_vnic/opa_vnic_internal.h    |  329 ------
>>  drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c  |  400 --------
>>  drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c    | 1056 --------------------
>>  .../infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c  |  390 -------
>>  29 files changed, 20 insertions(+), 4857 deletions(-)
>>  delete mode 100644 Documentation/infiniband/opa_vnic.rst
>>  delete mode 100644 Documentation/translations/zh_CN/infiniband/opa_vnic.rst
>>  delete mode 100644 drivers/infiniband/hw/hfi1/vnic.h
>>  delete mode 100644 drivers/infiniband/hw/hfi1/vnic_main.c
>>  delete mode 100644 drivers/infiniband/hw/hfi1/vnic_sdma.c
>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/Kconfig
>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/Makefile
>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c
>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
> 
> It is not complete, after applying the patch:
> ➜  kernel git:(wip/leon-for-next) git grep -c -i opa_vnic 
> Documentation/driver-api/infiniband.rst:4
> Documentation/infiniband/index.rst:1
> Documentation/translations/zh_CN/infiniband/index.rst:1
> include/rdma/ib_verbs.h:2
> include/rdma/opa_vnic.h:24

Ah! Will get rid of those in the next iteration.

-Denny

