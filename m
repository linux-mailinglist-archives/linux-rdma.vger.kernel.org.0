Return-Path: <linux-rdma+bounces-12906-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AFEB34781
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9021886DE6
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF86288C39;
	Mon, 25 Aug 2025 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="IYKe36c0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2107.outbound.protection.outlook.com [40.107.95.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F82D9499
	for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139680; cv=fail; b=lBYh8EtBzfbnj5Ll6zY12CaB53pOuSOHDWURIwyOJkNl38yxyJtEiyxjqJ+ya+sBTohwbEeRDKA/LAwOSF1nTpxZkVx21nHYZr0MvpbGnM2B0sCxWaaZCi/ZAkgvtNYboFgqGvXNPo15t1rptp85j8W9ZF2+vjhJmpP/LCqyaq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139680; c=relaxed/simple;
	bh=iu93Kox9Y3OPyvpkAvrBdSDd00CrOtvcKMhzgd9muTw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VhvsZM+LruuuCP8htC1Z2j33h7/iKbI5tXNAnn/5BLmRwOc3vbB242e2eNPYCMO/FBK4EkHYihsThb82jCVp3QOmmMu3sV+MBDziPOR0m+g2wMibHDLwTEw92uCM+1Z9ZKNBSsp759Uv2rv+4uK0lki5CvfVi7HvMkmTk1szSSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=IYKe36c0; arc=fail smtp.client-ip=40.107.95.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8kGyjbalWssIQEUFOcEIEDNYUlEx2wk/kioHIsCTFwBGYtOgbk+dx21O2lXKDjpmRgnca8kyoSdlAR3vOJc26eC55nG6/qvf4VqgWFwqMfXY02FAOvfVcAaPdLI1+rBjuoaa4TCWzK+AumpyKKcEywyYEsl6JoNz2s6Psb8eYWkvQhk5y8m/NsEL+N5qUtyjvsmadEuMQr9S4fP0fYWwik8uf5yUB8dYvRofoAHca784+rC7NLvymYR7NF/Grc/1YAZ8JRQRPLZQb7MW2sfxYL7N/he4Lbdm1Myi0Mbna5nKDKuU0ruY2QB7D6+IerhZM0/L0E83WTVOsRHObQmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn+p/bxytm5sl9brYKSFJJxpvrlq74vBY4RVO9A8dwg=;
 b=UUJAMMs1OpFQuTUDTfyYm0n2QizlcwIwPDJFtAasbWkw7xHojCAkheAw+Ar11iCpa3/klgE+HtfLp0HsgRDHmL6qXHZTOS9m0NZMk7ZPjVfyaAVh8/iyEo0WQIyW/qX/+M7gAd5ogdjaYoUC/4fURE66xVPc9TGfcSHrtEJND/nt2DLDqHaLXuzbUWqxWT/tz1fjk3xcq/4GG8c/nKEK1LYCveUIc5oSIqXW2N/oKQFmE6BGIeT/812dPBuTGqPDlxCV/vCg+4xX2xvUZnZwRE8Rfq3jv7BsrOC6a1SnbO5fllsuBn2GD0sy+IkVDoLHMmMs/lraMh5VspAVP8WxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn+p/bxytm5sl9brYKSFJJxpvrlq74vBY4RVO9A8dwg=;
 b=IYKe36c0RjL0WnZEmL+qKjp2UKTqTh0H30jI04tOjgCc7vdJW8eLgPKUg+aYg0+QWVJu14vLVKNc0iPANnOpdq5uVKZVESp9UK3SuYOZUVc7FsMkgLqrbzh8l36AYcwuXIJgGzVhpJ05JXmCthClCZf2h+j9k9pyridq1D24wI8iCN3+E/aD4z7hEz76TYmH8cQ4eb8uinmLOkrG6FBbo/oWqcjwVG050k39AL8IGyirLutfYfIsjxVrnuNjLbQlGFDX3SpL1WZFzKBay8Gl2QS7+8isvPr2jYRgX6PdMVtDdnP6Jd3YHlx45koSfK7l1h/TzSwNrgPrFz2KUfpZjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 SA3PR01MB8450.prod.exchangelabs.com (2603:10b6:806:382::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Mon, 25 Aug 2025 16:34:35 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 16:34:35 +0000
Message-ID: <acaa0427-67b4-426e-aa59-3665d64277e4@cornelisnetworks.com>
Date: Mon, 25 Aug 2025 12:34:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 10/23] RDMA/hfi2: Add in HW register access
 support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: leon@kernel.org, Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129743814.1859400.4253022820082459886.stgit@awdrv-04.cornelisnetworks.com>
 <20250825144200.GA2070157@nvidia.com>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20250825144200.GA2070157@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:408:f6::17) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|SA3PR01MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: b3118b6b-d95e-47b0-eb8c-08dde3f54706
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejg3MVhycGhaNVBHZUJ1UFBDS0VHV3RWNGwxRkR0Wm9RakZWcEduNG9XSWlk?=
 =?utf-8?B?YlNQb1F5bzQ2Z2VveHBpWVZGVWhlemRaczUrYXloYUFwT1ZJb2U1enNzalNV?=
 =?utf-8?B?QkJvdHhXOE5wWkhjVDBoZEdnaFFLRENFV3lJa3lkL1hvbXJtNG8rSXhWSHhy?=
 =?utf-8?B?S2tpZjE4NWNpSkpoY014YldNbEkyOUQxRHE0OXNIM2xkV01BaGJJdERQVVV2?=
 =?utf-8?B?WTV0UHBUbS9LZXFxVGhvTkF0dHVDWG1WUGJCVTRhUkoxU2JXZllaT1dyZ0Nn?=
 =?utf-8?B?ZWxRMmEwU1pYWXV6YVpYbjA5ZE42NGxWMFN4UjVzbENFdXd2VURQVkpXazFR?=
 =?utf-8?B?VTF2MFF4TXN3NndtQm8xQkhibmZLU21PaXh5aDIxa0NOVUdSRVdxTDF1eTVY?=
 =?utf-8?B?bytkWGE3a05YVGxqL0ZFd0VucjJYTHhiK1BEc2R2RmRjTkhQbjRMeEYyOVZF?=
 =?utf-8?B?TjFWdURmdWxWbUZBUXNxU3FWRWFoTXZoeFNGQTlYQnFTV3hCejJjSlBIbU9O?=
 =?utf-8?B?UFAxbW1jQTVRVHJVSnA3ZmFsWHlNTFNITXBVd1VGTm9QaTBvRFczVlBNb1NK?=
 =?utf-8?B?OVNKNlpCUjRNcHlyVktqNDNvenc2RGd2cG1RRHFwWTVFSFk2dmJaWFd2UVRp?=
 =?utf-8?B?SndSblNRWTF6VWd4cmRNd3BNM25tZjhGSXM4ZU1BY3pUbmM4M085dlRrWnZS?=
 =?utf-8?B?UGxDWXBZcUdWVVVrL2x1TStmanBsSmtSZnU3UExQbGc4QjFYZjlPWkpMcW1F?=
 =?utf-8?B?SHlBMDYvdVBNeHhjeFI1N0ozQlhRQ00wVWU1M1UzRHZDYUlyQm40ZFJ0NTV0?=
 =?utf-8?B?UFF3Mmh3bkthTHNRajhyTTBkS2tCQmxMbmRPak40Zk1QVlBic3VmY2pBNlRG?=
 =?utf-8?B?c0pKYjdYSGI5Uk1MTFo1L1V1RFB2L3FpQ3dXRjMxV1pHZXpFY05IUXZpaWYw?=
 =?utf-8?B?WGhKUnd2aHNjWE5rRDFNZ05pRS9zTWtKczFHVjRnOXNFS1VKeWFkeFRBUEpr?=
 =?utf-8?B?SWZhOWY4dzAzdVYraVgzdFVudmdVRkhVYWNnWmVFc0Qzekx1MEJUK0lEZVpD?=
 =?utf-8?B?OUUxWENtS3pmSmE2NUQ3Zm1rczJmSEg3NFBJdDdFOXJ5VkhPeFlOVG9rbE5r?=
 =?utf-8?B?bUV1aWxIdHdkR0hrVXJJdVBEbTJrbTJDZlZyS29obmFNaHYwU2tHVFVnOUdx?=
 =?utf-8?B?d3hxSEx6NXVGSGNXNUpTZW9SdGtUS2dRUTNyVTIzNmJqQmV4QzZLNlIrMENE?=
 =?utf-8?B?U1JraVBHWXdNVXV2NlppVWpSWEpWZCsvUk9ubmpxNnNZTlYrN2hKNE9lam9u?=
 =?utf-8?B?NHk4c3Q1ZnE2SElONXhKOUxPK0MxMXlzS1VZczA2L0w2Q3BvU1FWaTBTczMx?=
 =?utf-8?B?YXEwNWJBY1NQZEs4Qy9hazdUT25BY2VFOUovUGJjSFJodC9QZU52SFVzZGNz?=
 =?utf-8?B?Q0J1SzI0dXArcGc2c1Vtblk5ZERNdnhvVkpDaWdoNGpnYkVnZXByYWRKeEtu?=
 =?utf-8?B?VXpRUXpOTG5jYnBkY1RhQ3NwZ0RhSjZJMHZQcngzSDdFMndOcXU5ajlGU1Nx?=
 =?utf-8?B?S3ZmSnJFdXBtU2pydnVnOHU0SWxONWd4ZzJsVnFVZnU3YmorcUlrTEF6V1R1?=
 =?utf-8?B?OVVmeXhVWEF1eWI3MDgvNWtnbnhKcmN4cGVWcG0wU1JzRGZyazBQZUw0bzR0?=
 =?utf-8?B?anJuS2cvMzJyVGdUaGFYL0ppWW16RGhuL1BaM0dhTk9aVUVFaGJTY2lCcUpn?=
 =?utf-8?B?MlF2OUY3QlRmOW0zR0dBT1k5TlY3bUZ3clBydHYxcGNQRjBWREk0YXdkT1g5?=
 =?utf-8?B?bFYzQVY3MmJwVFZ6SFdBVEVzeEs4WWYxbmhVWG9qaEVtVzRuSFVZa1NkM2Yv?=
 =?utf-8?B?UjBlR0tKcnBPR0xVYitHN1ozbHlpRzdQUXBLNjV1U2pCd1NKemdEaTZSNHhB?=
 =?utf-8?Q?M2I5TUlKOHU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU1ZK0l6OC9SUlJTbUpQTFNHVERxNHhpdFp1MFVpZzhodW9wU2JDaTZBUFNB?=
 =?utf-8?B?RVR5WlNhQ0ViZ3NtQlJMYXh1RVoxYTJhYUNseDZ1M0tFaW5QQzVhZGVFWkVY?=
 =?utf-8?B?cFNLc0JmalovK2NIZWp1Tk1nUXJZbC93enU5NFE4WVNxSmp4ajVsSWlXRTJD?=
 =?utf-8?B?bVY3ZDBMenNpMnJiRHZUU0JqV1VZNTd1MjgxOFpqMHlnTGpmMDBKempONVBR?=
 =?utf-8?B?czNhVGpXV2pwb2NYaC9MeEc3TWdkS25oNDJxRjVWNmVTUks1WXUyS1o3V0Z1?=
 =?utf-8?B?bHlrR2ZFUW00alczc0hjcjRZaWhMM2FGSWFEaXFzR09hQktwa2ZQZ0pvQVhV?=
 =?utf-8?B?QUhOSTltT2gvOTFTOGlTN1J4SFUrbzZCVlNuYTcwNlp2M0Y3UUhCRUVOOWVz?=
 =?utf-8?B?K0oxOFR5VWR4YXBJMUhjcGFFUTVnU1B5SktFd3B6T3ZRNnRXQjZ0bkVFQ2Ew?=
 =?utf-8?B?ZVlocmdIaGcyQkNHQWpaSUlDL095c1NzdVVKaEg2dnIzRXZLOHVOUEZOQmNB?=
 =?utf-8?B?VmdXZ2dmbk1aY1h3aWEreVBtMUJHMGNCV2VMYWd3T0xLUDJTZHBTeVhYMHpn?=
 =?utf-8?B?blZiVkpEN0lwZE0rVXNSTlNGQnFvK1puSllhMlNHS2tHZVhkY2orNlhpZlpD?=
 =?utf-8?B?QjAvdjU3ekxWNWgyVWI4bEtRY2piaG5IODk3c1hWYlU4VGRKbWk3QWdCd0Rn?=
 =?utf-8?B?VmRkKzRkQVpLS1F4TlYwOEs2TzY4bXF0ZzBNN3dWYTVRaHRGUUphY3k5MWVS?=
 =?utf-8?B?b3FhZDBVRE93RTRwYTNRWFJJZFdid2NSVTBJSXdQUVl4dVZMSkRMVTNLei9m?=
 =?utf-8?B?VWVNdFdyUkJ3M3RKMGYxQnltNEFMUDNCckFETUFJTDhmcjJxRkpSaUtERFFw?=
 =?utf-8?B?S21IYjgydVQ4WkJwQ1krTXBOWE90aFhzaEk0ZVpYNDJOK2J2aFVFT2Z0M2Fv?=
 =?utf-8?B?VmJkdzAxR1dXMStuOU9xREpyWTRkaDZETWU3Y3lIdmlsUG80cGRNU2d3c3ky?=
 =?utf-8?B?dlVOMHNaMGNkbEhwaEN1aHo1cnV3clF4MVhFbEZWQkFJV3F6Ym1qZkllQzFo?=
 =?utf-8?B?eVY2SVM4NG4za2Jha2ovU25hVEtEOEljNklNYjJSVDJZSVQ1c1R5TWxYd0JO?=
 =?utf-8?B?ZFFOVmY4dU9XOTJ5Nmhta2M5MHBJdlpXaExOTEJNY1BTSkNnSVUzWXNIenNY?=
 =?utf-8?B?VkVMRHlYYU04cnpvTDRtbTgySS84cVlxaWtWMzh1NGdaTW5KcFFpKzJKMkRC?=
 =?utf-8?B?QmUyZUNMc2k1UTB2clpoWlh0L2NBcVlvUVpPZHRiUktkbXlDd2w3SEcxU3BL?=
 =?utf-8?B?ZGFmQTZZRG9ZMkR3WU90VGNEYVcxNEJCVmQ4Q1lDT2I0WkludzZEZ0x3UFRr?=
 =?utf-8?B?TnlXb25Dc3h0U0hjMFd3eFZlVGtCdHdRY29IK1NNR0d3Z2VYOEFSK1ZFQU90?=
 =?utf-8?B?TllxeVZ6azVJNTh5NkR5SnpvWDdHdkxnd2E1Q2FvRGJTNVh6bHNsVy90UDlO?=
 =?utf-8?B?OWFlVzdqa05Ub3hVeUxCV1ovc2F6REJDcmpDNC9vMzdnRDdyNjJsNURjWiti?=
 =?utf-8?B?TTVFNU5XTkJHck9Md0hmVWZBUTZFNUFoQ05lQm8vUFZadFNWT2UwRFhvZGQ0?=
 =?utf-8?B?dTNKM1gzTFZxWkplVTRQK1htLzlWakFDRUZGdEYyK0wwQ0JjRHRkcXZrL0h4?=
 =?utf-8?B?Y3JES2NJNEp0NlUxYitadUE4d05oM2hBTXMwMXd5QlA0RXFGL1k1cjNnYzho?=
 =?utf-8?B?Qitpc1FzZ0dqNitLcUlwTmllUXBLWlgxVU9KcERmRUNvencvM2Rob1NLeWFo?=
 =?utf-8?B?QWt0RmZrWnlJRzhVQks2T2tLeTRsTko5RzdkQ2RxU0NkbElkWldvMmxOUFds?=
 =?utf-8?B?WnF0UkUyQVN0Z0w3NDZqZWtOdDNKUm8wTFYxM0svdmNoMjR0eEl1UGdWWE9Y?=
 =?utf-8?B?ZFNOc3RVUThnZ1B4T1gxWWJsaVpjenBBajdjR2FreW94STB6aGlKS0s4OU8z?=
 =?utf-8?B?VFlUVlpIODdzQlFaUTN0VUl2Z3V1QkZsMENjYkFoWElCckFxdjVuOXZZUmZI?=
 =?utf-8?B?Mm5YMjhlZDVoaDd5Q1RTdVpuSzFUUUVBWFFLbGNCWjlwOTRDV1dzQ08vWStG?=
 =?utf-8?B?NExieGlOd21DNnR4VEZTZ3pHMjk2aUg4K21QT0Nla3ovZkxEQzBTY3VTNW5L?=
 =?utf-8?Q?zj5tBJF8s4BtPaHtjGDzTng=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3118b6b-d95e-47b0-eb8c-08dde3f54706
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 16:34:35.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MH0dHEecLAYPBvfgf4D99aLrb544LJVK8vTaDExIe4PSTK41z8FuxwWchQSe6NM1Z4lgdR/+4/7tzEmGnxKnP3Qnc7Kpv0nBN34TqrNRR6nJ+9fNGWRt24SPTHUYza2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8450

On 8/25/25 10:42 AM, Jason Gunthorpe wrote:
> On Mon, Jun 30, 2025 at 11:30:38AM -0400, Dennis Dalessandro wrote:
> 
>> +void jkr_handle_link_bounce(struct work_struct *work)
>> +{
>> +	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
>> +							link_bounce_work);
>> +	struct hfi2_devdata *dd = ppd->dd;
>> +
>> +	dd_dev_warn(dd, "%s: TODO for JKR\n", __func__);
>> +}
> 
> I noticed a couple of these TODOs, they should all be cleaned up

Will do, and take care of the other issues you pointed out too. Will try to get
a v2 out this week.

Thanks

-Denny

