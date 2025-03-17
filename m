Return-Path: <linux-rdma+bounces-8762-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC9CA661DB
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 23:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F04189AF61
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 22:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F506204851;
	Mon, 17 Mar 2025 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dUgE/HYc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CFC1EB5F0;
	Mon, 17 Mar 2025 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251222; cv=fail; b=W3yGD4g+bpQS0RpO3KzruzU53CFdtGQdH5PxwOaOjRaCdy7UPRPUkT1sO37To2TzTkfVPpwyE+3BMhJDTQW1MpBPOka9TSBFDcBeC0lqPTvjKZceQccGtvrOop+Bdnb4N8YPCJP84TSMIjs4pnsen8k5UkBTG8eQQZYl+8zZTOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251222; c=relaxed/simple;
	bh=sAKtzyHMWpmQuzndQcVKOgMFu6RCnyiXIVzyaplIHRg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ee/+FGcuzrysrt1v/wwpnX5/di9rGJOUOsyDQe61cY0MEo/Bt5X3uT+H39282qMSiWHJCvAdvCpRGcqd1UVeanqz1Z4HBVcGfyyoA8CNFVwIhz5fQl4etEb8RUfFD2FzkxQdc2Pl941G6GAVV3oChCD1MglY++khwAdO1KR9/gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dUgE/HYc; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZHIQ4nwShwbRggiion6PyXHuaQkdZt92PLFGfYmCrBXxJFfLtm8ODHGuRgbToRUvKuBNs+dnPZ1AOhYpig0VS2FCRz5RS9HZiND7WZAlDZNOTURCpNIsJ3oiKyritm2YD1cE9D3lK5tYuQordYmYtzsEK5YkC4KADWui0M2AsGytiV/Dwsk474OAWZSWn2dxoA1iw9luzBfm0JkEPVKIro5pSoj3GnjJQRGKAmIucGTmFLYUdkAAodkAx33jzfyUPzag8GxCbeKBtjjBnq2LLGNhkCbathHmRifb511tVm4h4CjinJ61+aSzpjJWAwyKdG6scq/FkCXJ/S0h9vzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPJFBWBvS+oBvmfwmTlYB+fXrx//OfqiAB1frl44fyw=;
 b=etonyY1ThjUalpzm4eRtGiX1BgMt/X501JGqJD61vqxRHqv6JXfLsHUEdIYprBaDLv0hVMMDGYEHCKImtH6fV9gCp3qVXJV9C+l7JuPp38zKE/iYSxzNwC61SThJEDeMkWa6mWCAhYRhaceG0B+O67pTHaVH9gfNYwLpGEPT68yV/pTM0Xn5fAhDWual8kbEQuai0EvOkavocaWywrGC52/bi6bQZt9jX9+J71KAvR529Up3ghQlytpQCzEV7yR8D1sAjKFK7BbBhacnZgqqoyQSE01x8jcpeDC4LUFO8rZGUyRRzpXRngTq9shSdtNWnO87+T3NcSN4Ror6XvlPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPJFBWBvS+oBvmfwmTlYB+fXrx//OfqiAB1frl44fyw=;
 b=dUgE/HYchlVUoE1wegCSz3YTwAlRf/cX9NaRetM3f9UFnKkbcdq7m8znorfsDw3OfMAnU28OIzgTyVBfMN7NSXEjOGsDzu5aOvlLE27pfIOLGaRqRPUjzhw55E3oPDOoSOPJPRJSsk/5kySHNB299t6O3ZgsxIDLUwMysiUzJoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 22:40:16 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:40:16 +0000
Message-ID: <be93d39e-a24c-440e-ae17-27c285ce2077@amd.com>
Date: Mon, 17 Mar 2025 15:40:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] pds_fwctl: initial driver framework
To: Dave Jiang <dave.jiang@intel.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
 jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com
Cc: brett.creeley@amd.com
References: <20250307185329.35034-1-shannon.nelson@amd.com>
 <20250307185329.35034-5-shannon.nelson@amd.com>
 <d1c78d12-854f-48e7-a588-4e6cf0991156@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <d1c78d12-854f-48e7-a588-4e6cf0991156@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:408:ea::8) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac1baf2-d973-4f88-2c59-08dd65a4b042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1hhdEM1Q295M2JWV3lLZXY1ZS8rTjV5dzhLMFFteVpTcG9OejhpTXZYMXJP?=
 =?utf-8?B?MGViNjhoYkhPREpJWFoxQzZKekd6TGZHdkR1WFJoYjNzS21id1hrMEVRTGFK?=
 =?utf-8?B?dFBTVHVZd1Qrck9STEhEME9QaEpORS9CVWcxd1R2L2NzN1NaZzA3ODcrUTY5?=
 =?utf-8?B?Q08zYnk5TjdzbWMyeU4zU1QyUmZTT1ZheHVGVU5saTFFeEZySGw2TTdWd0JM?=
 =?utf-8?B?eTE5R0xBdGtLd0VxOFA0eWRkMlNlQm00cTdkVE0weW83WjJOM1FjbXE0T2VX?=
 =?utf-8?B?T1h4dllUaTZyNzlmcEE5Q3VHZ1cvdjZXbTJnVXBZempKbHl3eVJNYUh4WGRk?=
 =?utf-8?B?eGxNTzNQOTV2OVdqL0NneHdmQUpKaE1vYmdUODkvODFxQ0FFZzFOVmxvUzNS?=
 =?utf-8?B?dmdKd2FNb1dXLy9nRlNTNFBRVzJaYUNIZlMyQmp0anhNbnJEVTFvbHUyZVlj?=
 =?utf-8?B?R28reEpxc3R4M2E4ZXFBUGhPeXdZSHNta2dwTzJOV0JiOU1YY1JxVjVlc21x?=
 =?utf-8?B?YnR0eG5Kdm9RejVsdzUwdVhadU5mbnRMY0Y5ZjM3T1ZtQ1FkaUJsbS9kV2Z3?=
 =?utf-8?B?UmhORXZLbUgvbENBRnA2bWhKcTZ5aVdGdTB4dXhSMkdWR1NtUnp4dkQzeWVt?=
 =?utf-8?B?S1RVeEhuMlZPL3pPL1NaaXhVME1FOHJoajU4YzNiR3NiNXNLbTBlVllHUFBv?=
 =?utf-8?B?eUFRU3FGbCtvTEg5MWtiVktpZSt6NzRQQUx4S2ZUalhFV3pCRXlTNXNNNUYz?=
 =?utf-8?B?WUhraDdyV2ZyRVhVM2I5dTZjaHYwcGFUdXFsOTNjZHRXZXlMRDY4eVhVZEdF?=
 =?utf-8?B?dFQyMVMyem5TenBJSkM0cU4ySlpIeUtpWGpUSDJJazJmb0lxQ1J0THhNWXdS?=
 =?utf-8?B?YTRjaFFCRDlCZXlTaFMvU3ZHSmd6cXBJeHpqK21MVFRETVBHamhBTkMxNTYy?=
 =?utf-8?B?dXNBd2xkZ3NQUjVMUmNqV2RHeTRCVlprb3pmUnFhV01tbjE4WUk0alN4d09I?=
 =?utf-8?B?SUgyU3VibUgxUmVMTDVEQ2VCL3AyVjFsbDh2ZDE1bDczeHkxU0hTUlJtU2ha?=
 =?utf-8?B?cnNEV1A0dVRtdURnL1pnYU9XTko0RWphNDVaTVhudnluOXJ0TGRRQm9QdzNy?=
 =?utf-8?B?K0xKaktxekF1R1NQS3B5eFBFY05pMWVBUDJRSStuczJ5amhHY3BGSGdoY1NC?=
 =?utf-8?B?MTY3RlRSQTNSSThjQ0dPdUZzR1R2MVBtWmpkZ2psNVJ3U2dGcmpROVNLQ3lh?=
 =?utf-8?B?dVVVdXhuQ0wzMjl2MGZXY3lpRHNZTXZQcWJDUkoyRlAvVnUza0Vnc2lxR2V1?=
 =?utf-8?B?Zlh6RExnV1lzeFVSNUhBUjBXSXVabThFUDF6MUxqWVI1S2pwS25Va0orM2U5?=
 =?utf-8?B?U2JUUHk4TUlOWks0TXFKdThnSE5mSnZYWWtzSTJGNDUvWmRvZjNxdGEvZURu?=
 =?utf-8?B?OFAvUC8xUm9ObWZrbkVKYldxR2FoVkROZ0NyeDNPcTBIZ0lIL3ZwNmJaQkl3?=
 =?utf-8?B?WEJIaDJSZEs2Ym5JbENuVFlEZUFQTUVxL1N2Qm5YNmY5cFZnNkluOUxta3Ir?=
 =?utf-8?B?RFZSQlUwMnFRVitJQjdjN3lPTzhwd0pLSzFLMEFXNXdOYWhBbTJhamVabzdv?=
 =?utf-8?B?ekoxK3VncXJzVUFhQjFFb21iR3RtblNkWC9nUUFkVkxkQXFLM2l1eXE1M21P?=
 =?utf-8?B?MS9yUjByVzlieW4wbGFDdkRkZDFGZnRUczdFUUordzhrVm00djdzWFNndWVo?=
 =?utf-8?B?NWhYb3d0cGJJYzdtOHp1Um5kL0hPQ1ZrR0lXQ0FtWkY3WlNoK2x4OWZxOUhU?=
 =?utf-8?B?L3BVTmthOG1zZVVFSFpTZWgwWGtOZjdLSjNaZXFJVlhuME1VSTZPNERJQkEy?=
 =?utf-8?B?ak1GZEJjZGd6WVAwRGNscG12VExtMkdPMDJIRXk0TXI1MFkwTHAvb2pUdFJi?=
 =?utf-8?Q?7hKBJtK/qeQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGNYL0E0VlVUR0xiU3NqdnJFQ0JTRmw0QWNzaFIrZ2N4VTdWeW9YQ2tYWFRp?=
 =?utf-8?B?SGxpR1VqdFF4dTFXb2svcWlIWEx6NGRpOENKa3BPTGRjTm9vVTZWamVNRmhL?=
 =?utf-8?B?ZkpnZmt0aFhZODVyOGlaenVsd09SZ1lJU1dpREs4L015RkFDZWFyeUUreUlp?=
 =?utf-8?B?dFpHdDcrbmEySEpSeXNPTFNjd2NFNXBvdXRqQ1Rod3Rhc3V0S2lXRUJJU096?=
 =?utf-8?B?SFUwUk5iOWtGZHZ1WXFTb01XRXVUVkJ1SzVQM1VxZ0Z5ZWRGSHVSWHhTcDcy?=
 =?utf-8?B?c2IxTWpsdm1HTk50NXlsYlV3SnFYZmRqVnVwU2FHbHJyRWQxdUNOQmp0azEx?=
 =?utf-8?B?V3VqZlFWeU9xa25YeVplbGdLOE1oNjY0S1c1WFN6MU5mK1RkK2JTazVnelRO?=
 =?utf-8?B?U1lBZHNuQlhhY3FqamQ5bXBBZ0ZWb1VUTFQ0SVBFMENQclNOL2p6QjBrK2dp?=
 =?utf-8?B?N2RXRTl4U2NDUHkza25IdnVja1ZsVVloR3dDci9EQmNWNFBaM0JsUVlTSHhF?=
 =?utf-8?B?UzVKTCtFV2RZdzIvNHRZNlpVbHJjNHdhTlZsYjd1TFZ6ZmltSjdsVitOR042?=
 =?utf-8?B?bm5CUUc4SzlhYlhmTzkwL2hURXFLZmhIbXUvSTBJWnQ1cjYwQXRNTjViMmNR?=
 =?utf-8?B?eGNzT3p2YW0raXl0VS9oV2RIUWtjQU02bHNibnRybTd0V0VDUDFQVXlEUU5a?=
 =?utf-8?B?YTk2dkl4dG4zK1JXZ1EzTHhjcWxHd1psVGRhdUpwazVFbnJnTFNEQmFycG5p?=
 =?utf-8?B?UkRpaEFpNXJKUVFWMXJxaTdYV1BiQTdmZXhWajR6cnhxbzcyZ3J2S2kzME0z?=
 =?utf-8?B?bDZCTjl4b2ZyRkNBc1E4Uy94OWgyVUlUU0oxakJyb2E2ZFVvNWJGdzRNTnY3?=
 =?utf-8?B?Y3F6TW8vNXRRTHBMR2JkdGFtTmlFMHRGMXNVYWpublpkM09aK3poRyt2Wmxz?=
 =?utf-8?B?eGNvbnV1d2ZnTWJ4d0ttWVBUNFZzYld5NDdWMTFNa0lxOXZRZktCcDRGOHdm?=
 =?utf-8?B?Vmc0Ynl2QmRobjZNNW9jY1RkOS8rZm12b2g4MUZmekJHK2JlaGdCSzlqa3F1?=
 =?utf-8?B?TEcxd01sRWhtM1BmRUVQUGZpUmpiZS9XMkhSU0hJVmZSNVdneEJHcDhJRng4?=
 =?utf-8?B?bThIWG9XQnJiOTV5Nk1qUXRCL1FOZ1Q3R21yeGQ0UkNYcUlWeFdLcFVSemdT?=
 =?utf-8?B?NlNTWjUvVUNoN2FqM3o4c2tpenZUMSt0Z2F1aHdGZHhhQS9FRVR5MEtjek9U?=
 =?utf-8?B?V0hJMU1uMm93UUxTMUlpblEwZlZuQVY0cmRvNko2WTBzZFM2Ylo0VXNDZHFV?=
 =?utf-8?B?aHdKb21ZajBTRlEzd1o1N2JoL0hxQUJxUDZNTFVXRmlyaVhOcnpyVTlXVWlN?=
 =?utf-8?B?RlhkS1psb1JsWkI3ZUw3WXQzakgvQVVmeWhsSFNrZWxTcEJEMzVtV0dLSVZV?=
 =?utf-8?B?Mk1BSnBUNzNVSXVqOUcvSmU1dDhxNDRSd3pDRmdhb1VnMXNKSU9sTEFIdlFI?=
 =?utf-8?B?ZHdiM1pQWVUrZ0QwcU5rMjI1Zm03MVpXWCs3c2J0MUxTR1Ayc0JTZks0TDhK?=
 =?utf-8?B?YmludVNFSy9Vc3A5ZWRqcEdzWlQ2bFlCUzl5eithS0drY1dmTnBxT2hCR2dN?=
 =?utf-8?B?SmIwb0c2ZGVndlpIbU9KeVo4N2hJL0l0R2ZOcVFlYXlVUFlEWEIrNnVvTXZS?=
 =?utf-8?B?R0lsdVFHblI3ejdCZG1iNFc2dG1TQWlhSnZubmhaY3N2SGxNS0dsWEk2alJq?=
 =?utf-8?B?dll4RnJYUDFSQVExVFM3bENSSDNKT3hNTHljTjg4TXV3ZTd3OHFvV0FVVnZV?=
 =?utf-8?B?azROdVdTZkIxU2N0OWNRanJzcStoMkEvSkNoQUZwTUVsUTVYcEZmZTM2dFJz?=
 =?utf-8?B?TXhUNFYvZDdLYXJLZG0yeGJZd3dCMnBPNGVRZlZ0TTVWQ1FEZUx0Tk5BTmp0?=
 =?utf-8?B?dksrV1hvMlNkSEEyTC9RNU01Vlo3cU03amQwQmY0RGtrSEZTOUtEWVdGWE4y?=
 =?utf-8?B?eFAyS1FzeDVPVlZiK2RSblRCendjbmRtL2ZmVklrR05pcTQrQ2JPcUNjTFQ1?=
 =?utf-8?B?dDI0dElrVEJiaFRrejRHYlJ1NXpxdHFmbVlMYjc4MGZYaUZMbFdVRXdCUitv?=
 =?utf-8?Q?D4RJw1P+cFnfnAxIWGdXDkpBx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac1baf2-d973-4f88-2c59-08dd65a4b042
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 22:40:16.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mT6kHxvatDdpR1ZKMlhe1W3CmVblycz+zhXYZ/WHx8OAqMxEImHkoYOUA0oPvLmtGFkEDkLrMaV+W4Hb729JfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551

On 3/10/2025 11:28 AM, Dave Jiang wrote:
> 
> On 3/7/25 11:53 AM, Shannon Nelson wrote:
>> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
>> devices.  This sets up a simple auxiliary_bus driver that registers
>> with fwctl subsystem.  It expects that a pds_core device has set up
>> the auxiliary_device pds_core.fwctl
>>
>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> minor comment below.
>> ---
>>   MAINTAINERS                    |   7 ++
>>   drivers/fwctl/Kconfig          |  10 ++
>>   drivers/fwctl/Makefile         |   1 +
>>   drivers/fwctl/pds/Makefile     |   4 +
>>   drivers/fwctl/pds/main.c       | 169 +++++++++++++++++++++++++++++++++
>>   include/linux/pds/pds_adminq.h |  83 ++++++++++++++++
>>   include/uapi/fwctl/fwctl.h     |   1 +
>>   include/uapi/fwctl/pds.h       |  26 +++++
>>   8 files changed, 301 insertions(+)
>>   create mode 100644 drivers/fwctl/pds/Makefile
>>   create mode 100644 drivers/fwctl/pds/main.c
>>   create mode 100644 include/uapi/fwctl/pds.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3381e41dcf37..c63fd76a3684 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9576,6 +9576,13 @@ L:     linux-kernel@vger.kernel.org
>>   S:   Maintained
>>   F:   drivers/fwctl/mlx5/
>>
>> +FWCTL PDS DRIVER
>> +M:   Brett Creeley <brett.creeley@amd.com>
>> +R:   Shannon Nelson <shannon.nelson@amd.com>
>> +L:   linux-kernel@vger.kernel.org
>> +S:   Maintained
>> +F:   drivers/fwctl/pds/
>> +
>>   GALAXYCORE GC0308 CAMERA SENSOR DRIVER
>>   M:   Sebastian Reichel <sre@kernel.org>
>>   L:   linux-media@vger.kernel.org
>> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
>> index f802cf5d4951..b5583b12a011 100644
>> --- a/drivers/fwctl/Kconfig
>> +++ b/drivers/fwctl/Kconfig
>> @@ -19,5 +19,15 @@ config FWCTL_MLX5
>>          This will allow configuration and debug tools to work out of the box on
>>          mainstream kernel.
>>
>> +       If you don't know what to do here, say N.
>> +
>> +config FWCTL_PDS
>> +     tristate "AMD/Pensando pds fwctl driver"
>> +     depends on PDS_CORE
>> +     help
>> +       The pds_fwctl driver provides an fwctl interface for a user process
>> +       to access the debug and configuration information of the AMD/Pensando
>> +       DSC hardware family.
>> +
>>          If you don't know what to do here, say N.
>>   endif
>> diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
>> index 1c535f694d7f..c093b5f661d6 100644
>> --- a/drivers/fwctl/Makefile
>> +++ b/drivers/fwctl/Makefile
>> @@ -1,5 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-$(CONFIG_FWCTL) += fwctl.o
>>   obj-$(CONFIG_FWCTL_MLX5) += mlx5/
>> +obj-$(CONFIG_FWCTL_PDS) += pds/
>>
>>   fwctl-y += main.o
>> diff --git a/drivers/fwctl/pds/Makefile b/drivers/fwctl/pds/Makefile
>> new file mode 100644
>> index 000000000000..cc2317c07be1
>> --- /dev/null
>> +++ b/drivers/fwctl/pds/Makefile
>> @@ -0,0 +1,4 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_FWCTL_PDS) += pds_fwctl.o
>> +
>> +pds_fwctl-y += main.o
>> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
>> new file mode 100644
>> index 000000000000..27942315a602
>> --- /dev/null
>> +++ b/drivers/fwctl/pds/main.c
>> @@ -0,0 +1,169 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright(c) Advanced Micro Devices, Inc */
>> +
>> +#include <linux/module.h>
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/pci.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include <uapi/fwctl/fwctl.h>
>> +#include <uapi/fwctl/pds.h>
>> +#include <linux/fwctl.h>
>> +
>> +#include <linux/pds/pds_common.h>
>> +#include <linux/pds/pds_core_if.h>
>> +#include <linux/pds/pds_adminq.h>
>> +#include <linux/pds/pds_auxbus.h>
>> +
>> +struct pdsfc_uctx {
>> +     struct fwctl_uctx uctx;
>> +     u32 uctx_caps;
>> +};
>> +
>> +struct pdsfc_dev {
>> +     struct fwctl_device fwctl;
>> +     struct pds_auxiliary_dev *padev;
>> +     u32 caps;
>> +     struct pds_fwctl_ident ident;
>> +};
>> +
>> +static int pdsfc_open_uctx(struct fwctl_uctx *uctx)
>> +{
>> +     struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
>> +     struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
>> +
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
>> +static int pdsfc_identify(struct pdsfc_dev *pdsfc)
>> +{
>> +     struct device *dev = &pdsfc->fwctl.dev;
>> +     union pds_core_adminq_comp comp = {0};
>> +     union pds_core_adminq_cmd cmd;
>> +     struct pds_fwctl_ident *ident;
>> +     dma_addr_t ident_pa;
>> +     int err;
>> +
>> +     ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
>> +     err = dma_mapping_error(dev->parent, ident_pa);
>> +     if (err) {
>> +             dev_err(dev, "Failed to map ident buffer\n");
>> +             return err;
>> +     }
>> +
>> +     cmd = (union pds_core_adminq_cmd) {
>> +             .fwctl_ident = {
>> +                     .opcode = PDS_FWCTL_CMD_IDENT,
>> +                     .version = 0,
>> +                     .len = cpu_to_le32(sizeof(*ident)),
>> +                     .ident_pa = cpu_to_le64(ident_pa),
>> +             }
>> +     };
>> +
>> +     err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
>> +     if (err)
>> +             dev_err(dev, "Failed to send adminq cmd opcode: %u err: %d\n",
>> +                     cmd.fwctl_ident.opcode, err);
>> +     else
>> +             pdsfc->ident = *ident;
>> +
>> +     dma_free_coherent(dev->parent, sizeof(*ident), ident, ident_pa);
>> +
>> +     return err;
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
>> +     struct pds_auxiliary_dev *padev =
>> +                     container_of(adev, struct pds_auxiliary_dev, aux_dev);
>> +     struct device *dev = &adev->dev;
>> +     struct pdsfc_dev *pdsfc;
>> +     int err;
>> +
>> +     pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
>> +                                struct pdsfc_dev, fwctl);
>> +     if (!pdsfc)
>> +             return dev_err_probe(dev, -ENOMEM, "Failed to allocate fwctl device struct\n");
>> +     pdsfc->padev = padev;
>> +
>> +     err = pdsfc_identify(pdsfc);
>> +     if (err) {
>> +             fwctl_put(&pdsfc->fwctl);
>> +             return dev_err_probe(dev, err, "Failed to identify device\n");
>> +     }
>> +
>> +     err = fwctl_register(&pdsfc->fwctl);
>> +     if (err) {
>> +             fwctl_put(&pdsfc->fwctl);
>> +             return dev_err_probe(dev, err, "Failed to register device\n");
>> +     }
>> +
>> +     auxiliary_set_drvdata(adev, pdsfc);
>> +
>> +     return 0;
>> +}
>> +
>> +static void pdsfc_remove(struct auxiliary_device *adev)
>> +{
>> +     struct pdsfc_dev *pdsfc = auxiliary_get_drvdata(adev);
>> +
>> +     fwctl_unregister(&pdsfc->fwctl);
>> +     fwctl_put(&pdsfc->fwctl);
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
>> +MODULE_IMPORT_NS("FWCTL");
>> +MODULE_DESCRIPTION("pds fwctl driver");
>> +MODULE_AUTHOR("Shannon Nelson <shannon.nelson@amd.com>");
>> +MODULE_AUTHOR("Brett Creeley <brett.creeley@amd.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
>> index 4b4e9a98b37b..22c6d77b3dcb 100644
>> --- a/include/linux/pds/pds_adminq.h
>> +++ b/include/linux/pds/pds_adminq.h
>> @@ -1179,6 +1179,84 @@ struct pds_lm_host_vf_status_cmd {
>>        u8     status;
>>   };
>>
>> +enum pds_fwctl_cmd_opcode {
>> +     PDS_FWCTL_CMD_IDENT = 70,
>> +};
>> +
>> +/**
>> + * struct pds_fwctl_cmd - Firmware control command structure
>> + * @opcode: Opcode
>> + * @rsvd:   Reserved
>> + * @ep:     Endpoint identifier
>> + * @op:     Operation identifier
>> + */
>> +struct pds_fwctl_cmd {
>> +     u8     opcode;
>> +     u8     rsvd[3];
>> +     __le32 ep;
>> +     __le32 op;
>> +} __packed;
>> +
>> +/**
>> + * struct pds_fwctl_comp - Firmware control completion structure
>> + * @status:     Status of the firmware control operation
>> + * @rsvd:       Reserved
>> + * @comp_index: Completion index in little-endian format
>> + * @rsvd2:      Reserved
>> + * @color:      Color bit indicating the state of the completion
>> + */
>> +struct pds_fwctl_comp {
>> +     u8     status;
>> +     u8     rsvd;
>> +     __le16 comp_index;
>> +     u8     rsvd2[11];
>> +     u8     color;
>> +} __packed;
>> +
>> +/**
>> + * struct pds_fwctl_ident_cmd - Firmware control identification command structure
>> + * @opcode:   Operation code for the command
>> + * @rsvd:     Reserved
>> + * @version:  Interface version
>> + * @rsvd2:    Reserved
>> + * @len:      Length of the identification data
>> + * @ident_pa: Physical address of the identification data
>> + */
>> +struct pds_fwctl_ident_cmd {
>> +     u8     opcode;
>> +     u8     rsvd;
>> +     u8     version;
>> +     u8     rsvd2;
>> +     __le32 len;
>> +     __le64 ident_pa;
>> +} __packed;
>> +
>> +/* future feature bits here
>> + * enum pds_fwctl_features {
>> + * };
>> + * (compilers don't like empty enums)
>> + */
>> +
>> +/**
>> + * struct pds_fwctl_ident - Firmware control identification structure
>> + * @features:    Supported features (enum pds_fwctl_features)
>> + * @version:     Interface version
>> + * @rsvd:        Reserved
>> + * @max_req_sz:  Maximum request size
>> + * @max_resp_sz: Maximum response size
>> + * @max_req_sg_elems:  Maximum number of request SGs
>> + * @max_resp_sg_elems: Maximum number of response SGs
>> + */
>> +struct pds_fwctl_ident {
>> +     __le64 features;
>> +     u8     version;
>> +     u8     rsvd[3];
>> +     __le32 max_req_sz;
>> +     __le32 max_resp_sz;
>> +     u8     max_req_sg_elems;
>> +     u8     max_resp_sg_elems;
>> +} __packed;
>> +
>>   union pds_core_adminq_cmd {
>>        u8     opcode;
>>        u8     bytes[64];
>> @@ -1216,6 +1294,9 @@ union pds_core_adminq_cmd {
>>        struct pds_lm_dirty_enable_cmd    lm_dirty_enable;
>>        struct pds_lm_dirty_disable_cmd   lm_dirty_disable;
>>        struct pds_lm_dirty_seq_ack_cmd   lm_dirty_seq_ack;
>> +
>> +     struct pds_fwctl_cmd              fwctl;
>> +     struct pds_fwctl_ident_cmd        fwctl_ident;
>>   };
>>
>>   union pds_core_adminq_comp {
>> @@ -1243,6 +1324,8 @@ union pds_core_adminq_comp {
>>
>>        struct pds_lm_state_size_comp     lm_state_size;
>>        struct pds_lm_dirty_status_comp   lm_dirty_status;
>> +
>> +     struct pds_fwctl_comp             fwctl;
>>   };
>>
>>   #ifndef __CHECKER__
>> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
>> index c2d5abc5a726..716ac0eee42d 100644
>> --- a/include/uapi/fwctl/fwctl.h
>> +++ b/include/uapi/fwctl/fwctl.h
>> @@ -44,6 +44,7 @@ enum fwctl_device_type {
>>        FWCTL_DEVICE_TYPE_ERROR = 0,
>>        FWCTL_DEVICE_TYPE_MLX5 = 1,
>>        FWCTL_DEVICE_TYPE_CXL = 2,
>> +     FWCTL_DEVICE_TYPE_PDS = 4,
>>   };
>>
>>   /**
>> diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
>> new file mode 100644
>> index 000000000000..558e030b7583
>> --- /dev/null
>> +++ b/include/uapi/fwctl/pds.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/* Copyright(c) Advanced Micro Devices, Inc */
>> +
>> +/*
>> + * fwctl interface info for pds_fwctl
>> + */
>> +
>> +#ifndef _UAPI_FWCTL_PDS_H_
>> +#define _UAPI_FWCTL_PDS_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/*
>> + * struct fwctl_info_pds
>> + *
>> + * Return basic information about the FW interface available.
>> + */
> 
> Please use proper kdoc formatting for the comment block.

Will do, thanks,
sln

> 
>> +struct fwctl_info_pds {
>> +     __u32 uctx_caps;
>> +};
>> +
>> +enum pds_fwctl_capabilities {
>> +     PDS_FWCTL_QUERY_CAP = 0,
>> +     PDS_FWCTL_SEND_CAP,
>> +};
>> +#endif /* _UAPI_FWCTL_PDS_H_ */
> 


