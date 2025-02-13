Return-Path: <linux-rdma+bounces-7757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FD2A35208
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 00:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1C23A97FC
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 23:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFB822D78F;
	Thu, 13 Feb 2025 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uVcMXPfs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3E211A3E;
	Thu, 13 Feb 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739488431; cv=fail; b=aovc5oFyb24u2RSAPwvMl79e2b4dhTLkSor0BgMIo75uFp2tlgLAQAK3irHeG0+IQPVk6sFLxiIxTul8VDoABV5Lt/2CZDFhEIOAoyHAONSbr6aRxuR62QgGR4fRNWqQRLnuPC07AfRCbnWsWf/PBLlU4k60KPXKQ0cCUbDkEDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739488431; c=relaxed/simple;
	bh=aEkIFcw2slhB9QJU505kF8i3aCuMsVODKLOngxoUd+A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EJF5R0naEn+B+I5ieCHeOzEG92BTe7FEsoMjqWBIQK341Z/ppFDeitTSQrK9yBXwBRIYiVvH9CdENBXfeXTqHHC/5579O4CJ6cxne8Nh99z5NivycaHmYC3Ca6ObLWN3MWaau9RMC6SajrHOG31PD9mKgaUA+o33vn876DmFdNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uVcMXPfs; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCTK3kQBtapyCvbTG2o3ye9+wW7h7jUj3ktdDNQcCb6KXxW85JJv7Vukdae7WizvDJPgbs5+a2OW8WDXsbuCRkgC+FynthcXmsXW/17dh0WpFr3ow0Aue+lqJ4ux1HjGVbhHwtoI1FcA/IWTswQFNtPZEQdC/V0qYvDmSnVNcwh/nHo/KW/YZpWGdFHApAks/2O9GDpv8463vYbWqDFPXZ/LqGEb/Qb0ndI5/vLGsDJHaIAdh3LYvpleGUYC+nixJpfNVWuQVSGiociNPSq4hx/KE2BFDHkYQG8UGBXlrsxPAitdNkARUGqPHIkyCdwJ8doG/2x3phx0omxjmfb94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N6ZplIbeWpVtmtyzUIV4KNUgUS+LUDiA9KZe8Z3KaY=;
 b=vYFnQ2CGyJtMNG22l/f2tCSO6imJ6YTkqN/h+JYOASi4UDIhVYjkRuP8Lum0ow3hB7ftQtbQ449rkleRbySSfmcvA8cjuJKspp4J/bGLQW9bbA6YTe5eN5y3gSe6OJslvaBL1thatWIXJ+LmMC24gVZDoIvTI09vruvoxFaiz9a+51c+jPCkZ+rqF4c8ovDyMcZmqEyfHizWISgkBdtyKKN4bjX9iUQbhB0zd+Roe+IZZhUE0+Vc6M3AcCsIcFF+cGyjKCnaIm3oGpuBCBFUhyUVngTxORUS4HoUx5EI+3E5zpfYezCPpgzBrxOZ6ZLisSLxJjYXyPHcLKvHTgDrYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8N6ZplIbeWpVtmtyzUIV4KNUgUS+LUDiA9KZe8Z3KaY=;
 b=uVcMXPfsS2TaeBQyGg7MN/DPZ03BxhYYOqP6Eby3/CShhpmK1lEzPJYOczQDc4mRXr5ntUJqEc2uEkOrWt1A0mW83tDy9lBynRl7xIWbNKpVsRrTvpTKHwPCZaG2hIR9rP652jb8Imk9b0jdLeDKTG4TVqh1XgR8pr5at589mJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.14; Thu, 13 Feb 2025 23:13:45 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 23:13:45 +0000
Message-ID: <d0523e2f-dadb-46d3-88eb-2e9ea6682845@amd.com>
Date: Thu, 13 Feb 2025 15:13:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 4/5] pds_fwctl: add rpc and query support
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gospo@broadcom.com,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, saeedm@nvidia.com,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-5-shannon.nelson@amd.com>
 <20250212124700.00005f62@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250212124700.00005f62@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 270df1b2-45b8-4614-ea49-08dd4c841055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTJ3YzhQU3JCTXBBcjBIWVMxdWlheWw0WWVjK2sxTWdpYXZVd3RMWkhTK2pM?=
 =?utf-8?B?TWJOS2F5dXNFTlZuSG5HcUlIMmEvckxGQjZmbXdqTXlyUzZmM3VGRkJ3MXhn?=
 =?utf-8?B?MnR6MmtOWXZDeVQwbWEvSzVtdlVldWxLV0NUbytvaXJRdGg4Skh1NnR1MnIy?=
 =?utf-8?B?NmYyQlRNQnhTNTJucUh0OEZYL2QzQWlpcTBNZE9Ea1VRbUYvZWRyYUdMZ2ZB?=
 =?utf-8?B?YzZIa3J5YUhyWGZrSld0d1VVeEJweW5pbGNuTnRjZjQ2VE9LdytPWENMVERk?=
 =?utf-8?B?Ky9NVEQzZzVuMWpSVGJIZVJOVmlLa2FpWkZqcnlqem00NEsrU1lYZ0J6Nk5O?=
 =?utf-8?B?cDIvaHhmSm45QnE2cTVEdmo1VC80Qm9BcmI0c2w1dHk3ZllpUmpWQ0FNQlFa?=
 =?utf-8?B?Nmo5aC95L1dIakJKYjRwYnpxOFFQVTZ5WUxKSm1pWHFYQzArMUpKdzNGNVd1?=
 =?utf-8?B?SWRrS1FORjBIR2kxWTBtOEtlRkRvRUNEWXB4MHhzNFUvV2NUUVJXYjJ6ait1?=
 =?utf-8?B?TWUvRnVQY1NEM29VM3Jyc01NMjhacUFwYk9BblgrQlE4SGFtQm53RjFSTDNP?=
 =?utf-8?B?OE0wZzVXR2F5MTZ2QS8rb25Mb3hrcXdXdXdWRmQ5TlFISDV2dnhBREhBMmVp?=
 =?utf-8?B?NHJBMTNDbi9xVzF4ektKejFLc2svaVBsTy9FTEhnZCtzcUJ3SVlONkFnT3Vk?=
 =?utf-8?B?eEVBNFZhSGxydFJYbVRRbHRnNXB5MGRPbjVNVElPZ2htaTJ4ZlBVSUU4Q1Np?=
 =?utf-8?B?bXEwTzYrM3kwWVdUV0hOQS9xQlVXa1Y4NkQyWGN5VDdVM29NczQ1UGZXdG5x?=
 =?utf-8?B?YVVCcjNteGcwUG5tU2t5RE9oOGFZalUzdkt0Q21PM0lTbXRoQUp6dmdVUm5E?=
 =?utf-8?B?VFJqL0FRR2RtMVQzdTlaQ0c4SlZ5d2IzZFR2SVVHZ0dSWFpxaG5RNC94a1Vn?=
 =?utf-8?B?R21QWXNaUEhqWWdaM0NvdDRIeG1rM3VWQzZnYVc1WGFRdVFmT0cvaVp3UFND?=
 =?utf-8?B?amRvK3pKT2daODFQZ3o4ODMwRGJqRXprdTFxYzhJVGJkcnltNlpBZmM5Q0Rk?=
 =?utf-8?B?MnZuVFpHZnF1cExYcFFtcWtKSkwzVDJOOFVHRVExdytPaVMzVzVaUk44L016?=
 =?utf-8?B?Y2owVHhnYlJPK2xlOXdQNEMwVlZ1ZmxYajRId3lZNDNJQ2M4WDNVc3NsZDJT?=
 =?utf-8?B?Sm4yMmQwTk9kNW5lSmdXbjc2K1FaU29NZzVRN2lyT3g3OHZPMU9adVVLWmlJ?=
 =?utf-8?B?N0RrZEJGUUk1QXh2UExBeDdmTWxscmFyR3JFZUV3Z3JZVXNPaEh3SEIvS2Y1?=
 =?utf-8?B?cWFiSjg1djFoUDEzMkp6Ynd6WEV3ZlhWN1Azd2FtRGtaNzE4RjZpRDArZzdT?=
 =?utf-8?B?b1g4dUwvVnBJclVhT0tGMWJlN0U1enZhVjZ2enRHUngvVG40dVRBQlRnWFM2?=
 =?utf-8?B?RWZsb3dsckFlN1RpRHc0ZlUwTDk5alQrd2twWURvQTlqZkV3ZmluOEpoeXJy?=
 =?utf-8?B?bzBSYzRVRE5VUXRyWVJIbmRTVzA1dmVJdnp1alplSUE4MDRLNTNpYm5tNjZp?=
 =?utf-8?B?QW1iQ1JDZmw4YzlESUFIR0NkWDFBYmFxelRxakRFZ2l5WXlzVk5jcC82VFIx?=
 =?utf-8?B?dkVyTWNvZHVXMW14cmwzS2U2UGZHWFZhS0VOUlM2MkxxRWo5cWZZNTc0WG00?=
 =?utf-8?B?YTljV3puRVRURW5IQ2hVSUV4V3NNa21Jb2pyYUM4ckdwUGIzVjgwOWV3cFpm?=
 =?utf-8?B?UDFUWWJmbTM0UVJQQ0JIZlJSOXBmcDlXZG85cUNVbXN6VytqMVJuYTlWc1JD?=
 =?utf-8?B?N2ZmQWJaTk5DeE5XL01rZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG82cktoUXRsUkVsVzBwY3lyblBMcGpRdDVnNE50WGp4Y0pYcUJwaEhqRzFP?=
 =?utf-8?B?L3lMZFVRUm5QaWVTRXEvcXVaTWlFRmZxK0I1N29GckM2ZlQxOVRQQklYcUVC?=
 =?utf-8?B?SlJzdnB1dHcxMlNvWjd3NjZCYVVGNERmdzBDU1U3WmpjSlVCMWtwc1ljV3lh?=
 =?utf-8?B?Q3R1UTl4SW5XdWtSaUVsZEhCamNhaW44dXY3RWEwcExqZGlyN2lhMEhyWFA3?=
 =?utf-8?B?UkQ0cDkxUXZVQU1HNVNmVjFEUU8yTnpSMytpbEFqeVlqcVczS2dzcEh6ZU8w?=
 =?utf-8?B?RjR4bDBMdFVrbnU2RngxdVpQMWw3TFhKaHdISTdXODlLY1dSd3VjU3o1Wjdp?=
 =?utf-8?B?T3c3VEdJdEc4eU14M3JYTEYvbGJFMEc5ZzZFQ1NuRFFZTDZDQW5wSEtBbS9m?=
 =?utf-8?B?M3YzZUZMeWhRdXBqd003M1BmWTVpT0VUc1F2RFBldHY5bnBXZkZpMlFHWlZo?=
 =?utf-8?B?akd4aGtZcWxKeDNXYXQzNFBXaUZLOEdFbUpmMXVWNUlndjgvWFpsekNIMDBD?=
 =?utf-8?B?bmFxUmF5OUpsWTYrellzYWhrbENabWJmUkczR3dvU1o3SlJ5ZloyQ2VwcmR4?=
 =?utf-8?B?ZjRPS0dKUWNhbTAza3NRcmY0R1FoNmNVdFA1UFZwelJndjB1MHpITHkwTlg2?=
 =?utf-8?B?NzVid3B4WUM3THNDaEhJOXd3OWMvbERSNVY4OFp5bUJ5S3RlZHgrWTV2VUkv?=
 =?utf-8?B?K000enNXMU5FTENjQ0RnTFQxN3RtUi9TcVIrUnUvLzMxdlRGNHkxdlZBb0t1?=
 =?utf-8?B?bmlqcUxnSHRoNStsNkN3aEh6NXlhalg5V09pcUU0LzdmbkxvdjBUYnUyMkVQ?=
 =?utf-8?B?Vm85Nm0xZGlXK1g5YTBSOU9aci95bUtpTk1MbDEvNDJGR2gwZk1SN0xuM282?=
 =?utf-8?B?eXMxVzJ2eTlKUGNwTWlTTUdZRjk1WHJHeUM2WFExbUduVyt4WVMwamJlWVlz?=
 =?utf-8?B?U2xPTC92MUlmV2Y4aHV5QWFvRTJTdFNoZUhEU0F3UVM0Y0JMS1VlZERXS1Rq?=
 =?utf-8?B?UmhldjQvL1ZPVGJvTjBXdC8yVjViZDFIRFkrVDNIWTE2WEJyWW0rdmsrL2kw?=
 =?utf-8?B?ZTJVS2thaXFIdkVaU3VqZ0NycGRENmlyQ21FUnlUMloyK2w3TlhBNWxTbHc3?=
 =?utf-8?B?dmJjY3k0WEpoMFZ2NjNTcU9VVzMwWFlNZmZKQ2NGTzNJT0JWQlduNVNlZ0l2?=
 =?utf-8?B?cW43amJnVmkyd2c2bkZOeS96QUJ5dkd5MEFiOFVEQ0tBelZHWGdoRmVPZk1w?=
 =?utf-8?B?b3ZjVFpyYTZ6enJVL0dJQ2U2dGRwL3E5Y1AyWk5FNW1EK1ZSQ1E1S0hFby9S?=
 =?utf-8?B?VG5PQSswL3R2ZUpKUGtVSzFjeFZXS0swdDNrVUQyZ0tFTi9KWUVsR1RRTFVs?=
 =?utf-8?B?SkZSR3NESWg1bXZtRjJvUnA2STB3QWV5MGNPOFJSbFRIVHBFMkFtOEJ5bVZy?=
 =?utf-8?B?bDY0SkR2dTk2Q0NPU2FGWEdTMVEwYWc5ZzlPL1YxVUpZa2FDTkV6NDBEU2Y2?=
 =?utf-8?B?RDB5MGNRRC9nVHVyem5MTnVEN0ZpaVNIV3lRWVdlYXM1akNFT1JRaDg0c0Jv?=
 =?utf-8?B?N1VTa252WUZQYUdvN1pOa3VoOEJ2NzhUVlB1V3BTK1dQTnB3ZlJ4eTRQN251?=
 =?utf-8?B?Sks0d0JNVGJMd3pGdUpZakZsckpoZ2VQbm52KzA0OE1IVnJuN2JuQjI5b2lY?=
 =?utf-8?B?VHdGUms0azFKUGE2cm1SdG5uM3lnMWd2WFNrNHB4dWU2WGJMOFVhblJOVytM?=
 =?utf-8?B?T3hvVlkvQSt5ejk0eHJHMUJhRWlqQjFEYWhkTzJ4Q01TV3BQdkcybUFGN2dP?=
 =?utf-8?B?b1FVK2U3TkJXblpIVHZyZlJ0TXExdWxmSkh3aXN6NmlrMVA4UDR0M0t6V2Zu?=
 =?utf-8?B?ZE82LzUrSTExVGpWUTM2UWtpUlViWjUrMzVPYmYwQ3Q5V3FhRkMyZ1F3b0FN?=
 =?utf-8?B?dFdiNVU5dVZmWnRuRzhFa1RrcUxyVWsrbEdEUnJOYUpCMC9PdUhqakUrTS84?=
 =?utf-8?B?QW5MS2h4SFEycFZhZEM0bk9lek1xNXVsSDRINWlLY0J2VnkxUnlSZUowQ3JC?=
 =?utf-8?B?RkN5Q24yc0FPazloNGZzRkxIa0VJQTZBRzhGYnJocUY2eHd5Zi94ZG9QdEZY?=
 =?utf-8?Q?5MPrefXG64ZY0tt9ioThr2Hmm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270df1b2-45b8-4614-ea49-08dd4c841055
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 23:13:45.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YO6Jtpd3z2O0nfaQIlC6VxRYjedF1594bYO2gQ9aoMYvUZEY9CFF024lq1VxmGoSEje/76ROT5sRUJV/aUsemg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

On 2/12/2025 4:47 AM, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 15:48:53 -0800
> Shannon Nelson <shannon.nelson@amd.com> wrote:
> 
>> From: Brett Creeley <brett.creeley@amd.com>
>>
>> The pds_fwctl driver doesn't know what RPC operations are available
>> in the firmware, so also doesn't know what scope they might have.  The
>> userland utility supplies the firmware "endpoint" and "operation" id values
>> and this driver queries the firmware for endpoints and their available
>> operations.  The operation descriptions include the scope information
>> which the driver uses for scope testing.
>>
>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Various comments inline.  I haven't looked closely at the actual interface
> yet though as running out of time today.
> 
> Jonathan
> 
>> ---
>>   drivers/fwctl/pds/main.c       | 369 ++++++++++++++++++++++++++++++++-
>>   include/linux/pds/pds_adminq.h | 187 +++++++++++++++++
>>   include/uapi/fwctl/pds.h       |  16 ++
>>   3 files changed, 569 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
>> index 24979fe0deea..b60a66ef1fac 100644
>> --- a/drivers/fwctl/pds/main.c
>> +++ b/drivers/fwctl/pds/main.c
>> @@ -15,12 +15,22 @@
>>   #include <linux/pds/pds_adminq.h>
>>   #include <linux/pds/pds_auxbus.h>
>>
>> +DEFINE_FREE(kfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T));
>> +DEFINE_FREE(kvfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T));
> 
> I'm lost. These look same as the ones in slab.h for kfree and kvfree
> which already handle error pointers.  Maybe based on an old kernel?
> 
>> +static struct pds_fwctl_query_data *pdsfc_get_operations(struct pdsfc_dev *pdsfc,
>> +                                                      dma_addr_t *pa, u32 ep)
>> +{
>> +     struct pds_fwctl_query_data_operation *entries = NULL;
> 
> Always set before use so don't initialize here.

Sure.

> 
>> +     struct device *dev = &pdsfc->fwctl.dev;
>> +     union pds_core_adminq_comp comp = {0};
>> +     union pds_core_adminq_cmd cmd = {0};
>> +     struct pds_fwctl_query_data *data;
>> +     dma_addr_t data_pa;
>> +     int err;
>> +     int i;
>> +
>> +     /* Query the operations list for the given endpoint */
>> +     data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, GFP_KERNEL);
>> +     err = dma_mapping_error(dev->parent, data_pa);
>> +     if (err) {
>> +             dev_err(dev, "Failed to map operations list\n");
>> +             return ERR_PTR(err);
>> +     }
>> +
>> +     cmd.fwctl_query.opcode = PDS_FWCTL_CMD_QUERY;
>> +     cmd.fwctl_query.entity = PDS_FWCTL_RPC_ENDPOINT;
>> +     cmd.fwctl_query.version = 0;
>> +     cmd.fwctl_query.query_data_buf_len = cpu_to_le32(PAGE_SIZE);
>> +     cmd.fwctl_query.query_data_buf_pa = cpu_to_le64(data_pa);
>> +     cmd.fwctl_query.ep = cpu_to_le32(ep);
>> +
>> +     err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
>> +     if (err) {
>> +             dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
>> +                     cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
>> +             dma_free_coherent(dev->parent, PAGE_SIZE, data, data_pa);
>> +             return ERR_PTR(err);
>> +     }
>> +
>> +     *pa = data_pa;
>> +
>> +     entries = (struct pds_fwctl_query_data_operation *)data->entries;
>> +     dev_dbg(dev, "num_entries %d\n", data->num_entries);
>> +     for (i = 0; i < data->num_entries; i++)
>> +             dev_dbg(dev, "endpoint %d operation: id %x scope %d\n",
>> +                     ep, entries[i].id, entries[i].scope);
>> +
>> +     return data;
>> +}
> 
>> +
>>   static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>>                          void *in, size_t in_len, size_t *out_len)
>>   {
>> -     return NULL;
>> +     struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
>> +     struct fwctl_rpc_pds *rpc = (struct fwctl_rpc_pds *)in;
> In is a void * so never any need to cast it to another pointer type.
> 
>> +     void *out_payload __free(kfree_errptr) = NULL;
> 
> Similar comment on style for these following documentation in cleanup.h
> That is tricky in this case but you can at least declare them and set
> them NULL just before they are conditionally assigned.

I'll look at these.

> 
>> +     void *in_payload __free(kfree_errptr) = NULL;
>> +     struct device *dev = &uctx->fwctl->dev;
>> +     union pds_core_adminq_comp comp = {0};
>> +     dma_addr_t out_payload_dma_addr = 0;
>> +     union pds_core_adminq_cmd cmd = {0};
>> +     dma_addr_t in_payload_dma_addr = 0;
>> +     void *out = NULL;
>> +     int err;
>> +
>> +     err = pdsfc_validate_rpc(pdsfc, rpc, scope);
>> +     if (err) {
>> +             dev_err(dev, "Invalid RPC request\n");
>> +             return ERR_PTR(err);
>> +     }
>> +
>> +     if (rpc->in.len > 0) {
>> +             in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
>> +             if (!in_payload) {
>> +                     dev_err(dev, "Failed to allocate in_payload\n");
>> +                     out = ERR_PTR(-ENOMEM);
>> +                     goto done;
> 
> As before avoid the gotos mixed with free.
> Easiest might be a little helper function for this setup of
> the input buffer and one for the output buffer.
> Probably not combined with __free that isn't giving much advantage
> here anyway.
> 
> For this particular one can just return the error anyway as
> nothing to do.

Thanks

> 
>> +             }
>> +
>> +             if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
>> +                                rpc->in.len)) {
>> +                     dev_err(dev, "Failed to copy in_payload from user\n");
>> +                     out = ERR_PTR(-EFAULT);
>> +                     goto done;
>> +             }
>> +
>> +             in_payload_dma_addr = dma_map_single(dev->parent, in_payload,
>> +                                                  rpc->in.len, DMA_TO_DEVICE);
>> +             err = dma_mapping_error(dev->parent, in_payload_dma_addr);
>> +             if (err) {
>> +                     dev_err(dev, "Failed to map in_payload\n");
>> +                     out = ERR_PTR(err);
>> +                     goto done;
>> +             }
>> +     }
>> +
>> +     if (rpc->out.len > 0) {
>> +             out_payload = kzalloc(rpc->out.len, GFP_KERNEL);
>> +             if (!out_payload) {
>> +                     dev_err(dev, "Failed to allocate out_payload\n");
>> +                     out = ERR_PTR(-ENOMEM);
>> +                     goto done;
>> +             }
>> +
>> +             out_payload_dma_addr = dma_map_single(dev->parent, out_payload,
>> +                                                   rpc->out.len, DMA_FROM_DEVICE);
>> +             err = dma_mapping_error(dev->parent, out_payload_dma_addr);
>> +             if (err) {
>> +                     dev_err(dev, "Failed to map out_payload\n");
>> +                     out = ERR_PTR(err);
>> +                     goto done;
>> +             }
>> +     }
>> +
>> +     cmd.fwctl_rpc.opcode = PDS_FWCTL_CMD_RPC;
>> +     cmd.fwctl_rpc.flags = PDS_FWCTL_RPC_IND_REQ | PDS_FWCTL_RPC_IND_RESP;
>> +     cmd.fwctl_rpc.ep = cpu_to_le32(rpc->in.ep);
>> +     cmd.fwctl_rpc.op = cpu_to_le32(rpc->in.op);
>> +     cmd.fwctl_rpc.req_pa = cpu_to_le64(in_payload_dma_addr);
>> +     cmd.fwctl_rpc.req_sz = cpu_to_le32(rpc->in.len);
>> +     cmd.fwctl_rpc.resp_pa = cpu_to_le64(out_payload_dma_addr);
>> +     cmd.fwctl_rpc.resp_sz = cpu_to_le32(rpc->out.len);
>> +
>> +     dev_dbg(dev, "%s: ep %d op %x req_pa %llx req_sz %d req_sg %d resp_pa %llx resp_sz %d resp_sg %d\n",
>> +             __func__, rpc->in.ep, rpc->in.op,
>> +             cmd.fwctl_rpc.req_pa, cmd.fwctl_rpc.req_sz, cmd.fwctl_rpc.req_sg_elems,
>> +             cmd.fwctl_rpc.resp_pa, cmd.fwctl_rpc.resp_sz, cmd.fwctl_rpc.resp_sg_elems);
>> +
>> +     dynamic_hex_dump("in ", DUMP_PREFIX_OFFSET, 16, 1, in_payload, rpc->in.len, true);
>> +
>> +     err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
>> +     if (err) {
>> +             dev_err(dev, "%s: ep %d op %x req_pa %llx req_sz %d req_sg %d resp_pa %llx resp_sz %d resp_sg %d err %d\n",
>> +                     __func__, rpc->in.ep, rpc->in.op,
>> +                     cmd.fwctl_rpc.req_pa, cmd.fwctl_rpc.req_sz, cmd.fwctl_rpc.req_sg_elems,
>> +                     cmd.fwctl_rpc.resp_pa, cmd.fwctl_rpc.resp_sz, cmd.fwctl_rpc.resp_sg_elems,
>> +                     err);
>> +             out = ERR_PTR(err);
>> +             goto done;
>> +     }
>> +
>> +     dynamic_hex_dump("out ", DUMP_PREFIX_OFFSET, 16, 1, out_payload, rpc->out.len, true);
>> +
>> +     dev_dbg(dev, "%s: status %d comp_index %d err %d resp_sz %d color %d\n",
>> +             __func__, comp.fwctl_rpc.status, comp.fwctl_rpc.comp_index,
>> +             comp.fwctl_rpc.err, comp.fwctl_rpc.resp_sz,
>> +             comp.fwctl_rpc.color);
>> +
>> +     if (copy_to_user(u64_to_user_ptr(rpc->out.payload), out_payload, rpc->out.len)) {
>> +             dev_err(dev, "Failed to copy out_payload to user\n");
>> +             out = ERR_PTR(-EFAULT);
>> +             goto done;
>> +     }
>> +
>> +     rpc->out.retval = le32_to_cpu(comp.fwctl_rpc.err);
>> +     *out_len = in_len;
>> +     out = in;
>> +
>> +done:
>> +     if (in_payload_dma_addr)
>> +             dma_unmap_single(dev->parent, in_payload_dma_addr,
>> +                              rpc->in.len, DMA_TO_DEVICE);
>> +
>> +     if (out_payload_dma_addr)
>> +             dma_unmap_single(dev->parent, out_payload_dma_addr,
>> +                              rpc->out.len, DMA_FROM_DEVICE);
>> +
>> +     return out;
>>   }
>>
>>   static const struct fwctl_ops pdsfc_ops = {
>> @@ -150,16 +504,23 @@ static int pdsfc_probe(struct auxiliary_device *adev,
>>                return err;
>>        }
>>
>> +     err = pdsfc_init_endpoints(pdsfc);
>> +     if (err) {
>> +             dev_err(dev, "Failed to init endpoints, err %d\n", err);
>> +             goto free_ident;
>> +     }
>> +
>>        err = fwctl_register(&pdsfc->fwctl);
>>        if (err) {
>>                dev_err(dev, "Failed to register device, err %d\n", err);
>> -             return err;
>> +             goto free_endpoints;
> 
> Mixing the __free() magic and gotos is 'probably' ok in this case
> but high risk.
> 
> https://elixir.bootlin.com/linux/v6.13.1/source/include/linux/cleanup.h#L135
> Makes a fairly strong statement on this.  I'd suggest either figuring
> out a code reorg that avoids need for gotos or stopping using __free in this
> function.  This looks like similar question to earlier one of
> why are these cached as opposed to done inside open/close callbacks
> for specific RPC calls?

Thanks.

> 
>>        }
>> -
> 
> Noise that shouldn't be here.

I'll clean the earlier patch

> 
>>        auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
>>
>>        return 0;
>>
>> +free_endpoints:
>> +     pdsfc_free_endpoints(pdsfc);
>>   free_ident:
>>        pdsfc_free_ident(pdsfc);
>>        return err;
>> @@ -170,6 +531,8 @@ static void pdsfc_remove(struct auxiliary_device *adev)
>>        struct pdsfc_dev *pdsfc  __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
>>
>>        fwctl_unregister(&pdsfc->fwctl);
>> +     pdsfc_free_operations(pdsfc);
>> +     pdsfc_free_endpoints(pdsfc);
>>        pdsfc_free_ident(pdsfc);
>>   }
> 
> 
> 
>> +/**
>> + * struct pds_fwctl_query_data - query data structure
>> + * @version:     Version of the query data structure
>> + * @rsvd:        Word boundary padding
>> + * @num_entries: Number of entries in the union
>> + * @entries:     Array of query data entries, depending on the entity type.
>> + */
>> +struct pds_fwctl_query_data {
>> +     u8      version;
>> +     u8      rsvd[3];
>> +     __le32  num_entries;
>> +     uint8_t entries[];
> __counted_by_le(num_entries)
> probably appropriate here.

I like the counted_by() stuff, but because this interface file is used 
with FW built in a different environment, I've been hesitant to add it 
in to these obvious places.  I'll see if I can add a little macro magic 
to that environment to allow the added syntax sugar.

>> +} __packed;
>> +
> 
>> +/**
>> + * struct pds_sg_elem - Transmit scatter-gather (SG) descriptor element
>> + * @addr:    DMA address of SG element data buffer
>> + * @len:     Length of SG element data buffer, in bytes
>> + * @rsvd:    Word boundary padding
>> + */
>> +struct pds_sg_elem {
>> +     __le64 addr;
>> +     __le32 len;
>> +     __le16 rsvd[2];
> 
> Why not an __le32?
> It's reserved and naturally aligned so who cares on type ;)

I think this is a leftover from earlier implementation changes, but 
doesn't make too much difference.

sln

> 
>> +} __packed;
> 


