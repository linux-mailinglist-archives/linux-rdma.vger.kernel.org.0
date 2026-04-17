Return-Path: <linux-rdma+bounces-19417-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABTRKdJm4mmT5gAAu9opvQ
	(envelope-from <linux-rdma+bounces-19417-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 18:58:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A6041D62C
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5143C3067C98
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AEE30AAA6;
	Fri, 17 Apr 2026 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dmsTJDaN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0RVhLaO/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0442628D;
	Fri, 17 Apr 2026 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444889; cv=fail; b=oFRKww2rdpg2h93J/5jS5XXYF/IwLDm76j2DptihgCXAJYuyfvhkgl07q5fMjCEiM/3vIlDOHEjXoYV9vp8h+W9E/ZF0tkUD29drcCwY4MsmEIPyCJM3g7LgOJhwnQ+TR1SEkwQnsqs8BlX9tEoXaDMpGiIBYINuquO/chKC1QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444889; c=relaxed/simple;
	bh=EIGcXaICJfK639zVSg+sae6OHmvd4DrjsRlmCWBdi8c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HpIkWyBB+mhv6GogC8pMKfkIBWng8mm0j6J+Q5epnS6cxnctRlfypoWzq5tyRIsODFnoqzANpsilGWRPFdN7Utk9c16Xo1yl7OZfO1aPVssS3Mnb3V2FLWV3Li+iH6+4r5qxHt6R1GV6IfhvQSDO6tN3dAfdtlz3s9VBz5KJuWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dmsTJDaN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0RVhLaO/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HCJ99O3333884;
	Fri, 17 Apr 2026 16:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EPO/Kh85UhsCY6LETNPV60E3h/LlZusNXuMldTT5Bd4=; b=
	dmsTJDaNyW92Wi1feRzs4uFk0v81dTYXLOUDlKq5X920zvm7Qevy0jgpoGu+7m8z
	5IOAecEP6jQX2Rg+d9Bdzq3Jrtuvv/OR7Kx/VxPfuLu+ja4h/rm2ym9wgNHHwSBW
	cUDvKAkTr1t0/BCoN9fa5qvoZRrBDCcPUd3waAM/KiNx6vxtlVO35MeTTxwr6wjd
	FyO9tuXwzyPdfPeYbXqGn4GkwE+S8hgWXb/dvlyYhhZzhPMrgwFSHt7IXl1MlZjO
	YOejozRKwFt722FzbLXmyfUaJlD3pX5dZpPS/Sy4je7dsKOcy50lVCAPZU6pqZ5v
	0cxe9LJn/hxemWr1GQsfew==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qj68s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 16:54:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63HGsR0M022060;
	Fri, 17 Apr 2026 16:54:32 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nr1axc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 16:54:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZljExaGIeuwN3PE0EhLvFNN96e1ABWjEbm+yOTo3vjFK4O2FIGcHUi/KwMFUbwXD2RmDD5mBnk9A+BkW7GBVpIBAVOnP8T1If9UYiomRERM2cc1E0kPzihnbz8TjrdFKc996QO3kOwjlUaMEUarXxKmvYmI0ihxLp/DoDd8VFcNRQD6bJQ6cXatBl+mDSxUlECYYGlj5I3ysQFbCuRV2IvE4eT++b1fJXzLLtO89t7UP7vxQttk8qQY7cZGXp4z2cgVneXpyT8lc7OJOV21qQ+Jnqn1dpvoE0lv0qVl8AirkTRqjGuCCXv8zpYRnmk705TSQITo7Um5BBsfykWcbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPO/Kh85UhsCY6LETNPV60E3h/LlZusNXuMldTT5Bd4=;
 b=Ke4JAE9xmU21IQHO883joowPYYLWvcqUc7GiwayyisFbITm0+TPxocuPry/mjF1nDHi1u+vKDZk3iCydSxMvDXRVFZcDtgCjVDDjGsOJNMxMsD6XArpyelprnieZgk1g2zbea1lX/5iHBi3vXwDiGf8Q/TvMW/8j/B6oIHruk9fpvbuphBznRjklP9+YEi04Ih8vmfvbycGxVal/BAUZbvpkmvBBPMGeItq7sKrMQB06djaRQK+8w6CCPut506VMTr8nPQmAi8UD9Hfu9do6VxLxPHA45aV3wiw350ODRfaHOXfahsBBsxo8sbFFYJkNAkcvIQfoIWxHPDaK0Ci6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPO/Kh85UhsCY6LETNPV60E3h/LlZusNXuMldTT5Bd4=;
 b=0RVhLaO/+7SMI/qlqQeDFz4HJFy1AxxsdfjLUQp513oPmXaXKDmmJl9JEvI02ttvQSWP3dRjvDKOq6uWRVlWdWpd3u0HsUrufQ42COSJNz8zYiQn1bEf0xOai5Xf+QQ34SHG2O3/puTAWtYp1o3j01bxIRIQf2/O+aKNoW5Rx9w=
Received: from PH3PPFD88A49DCD.namprd10.prod.outlook.com
 (2603:10b6:518:1::7c9) by PH0PR10MB7027.namprd10.prod.outlook.com
 (2603:10b6:510:280::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 16:53:58 +0000
Received: from PH3PPFD88A49DCD.namprd10.prod.outlook.com
 ([fe80::bc8b:3c62:9c11:f95b]) by PH3PPFD88A49DCD.namprd10.prod.outlook.com
 ([fe80::bc8b:3c62:9c11:f95b%6]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 16:53:57 +0000
Message-ID: <feddd108-998d-4514-aa51-75e3cc0f3cb9@oracle.com>
Date: Fri, 17 Apr 2026 09:53:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rds: zero per-item info buffer before handing it to
 visitors
To: Michael Bommarito <michael.bommarito@gmail.com>,
        Allison Henderson <achender@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20260417141916.494761-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Sharath Srinivasan <sharath.srinivasan@oracle.com>
In-Reply-To: <20260417141916.494761-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH5P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::9) To PH3PPFD88A49DCD.namprd10.prod.outlook.com
 (2603:10b6:518:1::7c9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFD88A49DCD:EE_|PH0PR10MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 12aaa086-b106-4e1d-186b-08de9ca1e9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TRsZ6FQxiU3c49KZo42RbUV8oJaiooLZlm0rAkjgzTUf8N+yH0Rwba5GOo000eTyoPIFctY8drCtc5YeJINlbjV/QoQ+5tjbFcQf+/KRfaoKnCMNV1fVm7tyMomUxRdNMfbI7+HVlsBlOD8TB1q8tFzcOMMQxu/iqsqzWHiP6ztk/cb78U0TdHyI+k5spi/0BjxnB3Mcp7QOsLgu/IydO2meQTHbQhHjo3UoCNjOsCnNXqSz1+4yLhIgY0B4lz3gYVCzKOlQwld0xOJqP3RwA+uUSnFomgEAj6dyU3T/E8Rz1DGDW+86pYTM5Vw6x7XxqEsMbez9LzCzs5YslzBSC8nxNe8oRqqsgmEM/IWQItbewyyK6wmtkryUtNwSD9WjzqyWMQWd1iPjowI4Q2KPR/9/8ah2XIqWTIuFxa/0P4RxFmIjDT7kiRM86U1VYejbuyPsybKwd2P7GnRzAew38WkhzW3WHA27nWHPvK0xGKb9JjT+C/SBeurdtf3d7fcydlxqyDIG+nI5VL1pJpP70V9pMPCfPaHLnpzFZMSng6gizlYEhvoqJC8pRcL06Yb0SO6wCi/0TBeIWBe4gfYXbhftGi79Y4ZOpqyjqJjEpzu7oH+1mPdkncsjGoUUqLzJX1u+MllDGRDiFWbIGP1+DT61jQIF7oW15+1uMAaRrmDvtY7GbKVRBhUI7CYOwGih+eZDc3uOezRaI31mI8uGrd2eevJvNUZFkhDpj9FegjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFD88A49DCD.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHhMdW54RGNuNnFhWkVXL1Q5T0p5K0c5ZDdwb0pTaDlzREVMc1ZNNlZzMHpZ?=
 =?utf-8?B?Qk5oaG5oZ3RwK09DbFVkNW9uY3dBTllkakp5Y3JpT3Q2RmloRklvTUFDRTM2?=
 =?utf-8?B?WUdQb1hYb3h5TFU3SWJVZU1RU2RhY3pHOE9jUHZzNU9wb01WbDR5KzVsWWRu?=
 =?utf-8?B?Vlk3cUlOWVdLQ0RRSDFmeWV1cVU2YnpyRmdqYzFwV05pK2NPdnYxT0I2OEFS?=
 =?utf-8?B?MmpMR1VWdTVFOUJockNFa0hoUkhXQ0RjUmhrT25YelY4MTVic3l2T2JqOFl1?=
 =?utf-8?B?Zk9xRHN2Rk1HQmxRWUhXcGZ4R3ZxZCtQUGpxaFJuVEtyRDBFK0xETldUczdj?=
 =?utf-8?B?akcwemhpRkRtUFZvVHhkNHhDRDhTZ0taZDNHSzVvelZRLzltaUtRZ2VYMHlx?=
 =?utf-8?B?cktaM3Z1cVV1TWVtRWRpa3dLVG96aTRLK2tyVzFoTFp5emhiT1dNUlNuM0ZS?=
 =?utf-8?B?dTRRai9BanRodm9zWlJBZ1JENUdVZ2VSSmlFU1k5bW5wYThZV0QwU1NiWi9x?=
 =?utf-8?B?cHZSZGRxUVZ3R2wzYklGSTI3R25GWU9RSHNIZUdLTkQvZzM5VjVpVnJTa3F6?=
 =?utf-8?B?WlBvcGJJdHpzaDUzR09VZ3lOWEFoL0dJbFV3eG42YStBem4yYXcyT1BaRk1q?=
 =?utf-8?B?TGZ5YVNSRmZSQjM3Y0h6RGJqRjRCZlpYMnVGL2FsRHJuejJabHFMZ04wOTM0?=
 =?utf-8?B?ZVdjcXNtV0ZVTHZSSTVNK3JKZ3BpajFPc2ZJSGRaYjVJTzlxYjRpL3hGU1Jp?=
 =?utf-8?B?blZ4ODY5ZDVzSFVFMDA0ZWVraGdpbjAwaThRVDA5UlFsbzZ4OHJiMWh5YzdV?=
 =?utf-8?B?d0s0K2F4NC9PWktOdkQ1OWR2eTV6QURRNm8yR1VCc1RNRDN5ME9JWllZOThG?=
 =?utf-8?B?dTBGQzVWb3hRMXFLSGZBVitNUjZWTWJGVkl2YWtVSnA2bXdPcVpWM0Qrbjc3?=
 =?utf-8?B?OFR4NmNkbEcveU1xdDZaOXZ1dEMvZzBlZXo0WWhZYllRZmU2Snc2eFM2aUlK?=
 =?utf-8?B?UHZMUmNOUkJIT3Y3Y3hWR2tXOWlVZEhzSzJoREtzaDdUazV1M3FlcThGcDM4?=
 =?utf-8?B?YzdqZWh6MTl5WWI2THkxOG9rd1JVRDd1aFUweFNPYlY4eXFDUUJwaTM4YVFT?=
 =?utf-8?B?dnRCajY4TDlZNEJBeGwyV0tZNnU3ZzJTRUNiaXFqenNCRXQrQWVEcVloV0ZB?=
 =?utf-8?B?OVFSdE9MYSt0cTA4dzIzcC9aU3AwRkdvWEZKaFdabXlWOEFDNlVMRWErRncr?=
 =?utf-8?B?aGpyQ3kwZ3hOVkdXQ0JhQWFrL2lxOW9BWFNqU3JScHo5SGJsZWlITXZPSmli?=
 =?utf-8?B?WVlNUFdKSFVuVUpHd3pra0xpNVZWdlI4YVdaeDRHdTRVemUrampCelcyaVNs?=
 =?utf-8?B?ZFVzMzhJZDJYeFBoZkZHSjBXR3o3cWJBMEp0ZTl0a3hRYkNaaXRvUUVjamVU?=
 =?utf-8?B?aDRRVXhCcDJmaURwMVBjWi9CaTNhekUrQ3hRc1k3RmxiRGxpVDROSS9LTEZw?=
 =?utf-8?B?OTk5N3FxQzFBNGxnaWdQOHVxS1U5WFA0THBTZXBXdWNVeHV6bGZkSkx2VGc2?=
 =?utf-8?B?UktsWGFqd1NlWDYxVENBNlRjZzAwRXI5OU5rRUZwaHpzdWtKZUI1VjVQVFhH?=
 =?utf-8?B?MENvY1pPWnZTSGx4Z2VHQ3BSMWs4Q2UwZlZUbFFDVXBoYUthTE5MY0VPM1gy?=
 =?utf-8?B?MmhaVmhibnlTYVhCWERRYkZmcmpNVkhSc3RkTGdWRWI3eG1OTEJRZ013Tjl3?=
 =?utf-8?B?U0U5bFhDYnZKSVdGOWNvc3A4SHRjTlVGTGcwcGk0eGVtRERrVmVRc0xmQkZl?=
 =?utf-8?B?YkJJVjFrRDFwdFBDaFV1WGZEeTRvdGxzOUVybnl0Mm1SbUZicjBYaCs2TDBs?=
 =?utf-8?B?b0IyUkN6ZmFkc2ZXWjgzNnJiV29LcWtEd1NxMGNXU044Nm1hTmpwWmpjQXdC?=
 =?utf-8?B?T0tHYTQvMU83SUcyQUpnenRHQ3hrWDQ1VlpiNDVCR2ZuYUlnZThCRVBHZlNo?=
 =?utf-8?B?NmI3WHZQbVdEL0hEYUFMNUg3RTZqVXRDTFlXN1IzTGIweURFbWpsWHFvd1Y0?=
 =?utf-8?B?bHJGODZjVHBweHlSZldsR2pQRTRCMW8reUNnRGNseFppeDlnYU80SHRJRTRC?=
 =?utf-8?B?VzIxUWFtUDRsYmozWHdQRk9nRzhReDQ4YXQvbDZDbmo3UEZSbHpNayttM2xh?=
 =?utf-8?B?bGdtRzNjV01pUm4yNGVFbjhBb0lJRld6Z3ZFTDZ5eWRSWnRXaG9EanJ2N2I2?=
 =?utf-8?B?Y0JFMDFHWFlxcnh0VVQ3ckNYRHU2c1l2RFdqcTdmMGRyd0pTWmxPRUViZm41?=
 =?utf-8?B?TUgraU53bW9pMnEzMEtrSjdxcm9SRmlaOFhrM1ZlWnlvRm01cmJrWUVKdzJu?=
 =?utf-8?Q?wBuleNssd2SioCyA=3D?=
X-Exchange-RoutingPolicyChecked:
	b7YPuezQF/swtLYeng96BqDp9Jk9DNSLXKpiBQYpOEjBs+9HNPIFmSreW3FOdDUTTpUeTkmDiUR1/nnLU8Yyp5VXUjjrbvZnX7WObVB6dl5HNg0NlSQQh7M/Edraml9SMTpQ2rq+jNKATVlDAoz5fcOxqBKEYWM29OXKefZYo6DVvfqjnsz4I6wed+2cE3OOH5oH5fWPkxXEvWjyZ5RXauEeda7qz5rfjpzluT2zJ2ElRx0zfm9F71vP4vhve79SocuEsgbIVeF3jE7ScCsQHL2sM05Fx7QhntjxQZvwSi8a1eG0N05hnz94WJ7hd9ZxHywFdHYZYa+vxghKkksciw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GqyxR1kdDhcpYxG5MhYGhRPLZUAOy3rbhqKKBkvFvel3shsJbrvyeJy1RLjy8XcSPau6Ttn+DAmS2a0cvi9eRDMFNAceKqzWRLzeoYP0y9/SBNsaxdisElk7kwV4EKKO67X9ZGQt3LxdApoyuWuKPO9bw2hBhGnXr9wulshUW04T8ZrvD/naBzChRXIJbrIgD49MXNqt+W8w2RByt3fYeEu5uXDUDlvzd1/sJjFEwTgeDgVrlLj3u6wxTW1SoHbNPzqLUfyP3rMkDR74NsffY+lGddojbM8H+FR+51LLq7u7QeZz5aFw6T18oFJbcUuTrPedyCChQt7rWnyYVBQuJPp+9/39Ui6ZUS112b2VyACBduYUDQ5CstUJ44Yxa6m81C1eJCnRi6+uNYUsFP/E1oOyiWA16Rq8qZN6Ix1vAUs7uX0lJeB8ftgZ3Dpj14kkQbyJPXwjXkybv95EK8oVcmcUdh/q3KfqF5drqaY9YkdNmh3nNVSF2xHdSob6NKtef/SPUmIqd3coIJcpXp4yFmbXJxVZPxVAbCKExGM4sVRXF0NyKaNV+HxvIN+4dx1fde5IhNQRGx9xiG3NNo1hStE6WRDa8AyL8IJib1yr9TY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aaa086-b106-4e1d-186b-08de9ca1e9a5
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFD88A49DCD.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 16:53:57.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHHUOaoz5pu9wm0ghV/zBW9BupTiBIm8kVhkjujQ+OhjYp17qqm/8Vf6XJLkth4TlfHHVARs4BCSbFLbcWiiFzy5KYgn0lgAJkS1iY6rgPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604170170
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE3MCBTYWx0ZWRfXwUHrnEFIidiI
 igAC77r1Zc2hplqedZz9LGXwSW64gKbn6x3RplL/nazQYOk7413NPX33xOxapcrHo7FkB7iXiSV
 yl1O+4v4KZ6ftHghs1Z1BslL1SnkkYH4iEByuGNZCWdx38pZ25D9XWEsqwIrBhDJr0HXm333Tfh
 P2nygSDGztLdrd1KelKLaRCKrKXzXNSWLMtCLG9t7V/vJChf+ospYGQP8utMV95LR5StmcGc0Pk
 zd5D+zLl85RGAUKN9/2F7xOmyHMpKF/zC0N0zkmoKG1xdj+skOHDqUgb8BMdSImUKPEZU3VOEBV
 voiSfWj7mBWZ+V8yMdlt7hZV5oq9wX8d8qwBX/JNAS3lsztfFC0CiUy74z11yPal3LFKIAYSLEi
 m8bDIW00DRSCjPlxWUqSAVdvpca+umy664tGRJ1mVGVZ/p7fQlTmoaA9yUL7uOEsWW8PfXp24Qn
 1P+8hS1gJrFpRcz2RdWGeBh/1tblpFBJGOzW60iQ=
X-Proofpoint-GUID: zw-87A9rIgKcRmxzbk13tuEUpSUQBTLG
X-Authority-Analysis: v=2.4 cv=V49NF+ni c=1 sm=1 tr=0 ts=69e265c9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=IGy2Jv0T9ZIs4tJZkWwA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12292
X-Proofpoint-ORIG-GUID: zw-87A9rIgKcRmxzbk13tuEUpSUQBTLG
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19417-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sharath.srinivasan@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 28A6041D62C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 2026-04-17 7:19 a.m., Michael Bommarito wrote:
> Yet another from my "clanker."  This only applies to people who
> don't use CONFIG_INIT_STACK_ALL_ZERO, but I presume that's
> still enough people that it's worth backporting since it can
> be chained through leaked addresses to defeat KASLR.
> 
> rds_for_each_conn_info() and rds_walk_conn_path_info() both hand a
> caller-allocated on-stack u64 buffer to a per-connection visitor and
> then copy the full item_len bytes back to user space via
> rds_info_copy() regardless of how much of the buffer the visitor
> actually wrote.
> 
> rds_ib_conn_info_visitor() and rds6_ib_conn_info_visitor() only
> write a subset of their output struct when the underlying
> rds_connection is not in state RDS_CONN_UP (src/dst addr, tos, sl
> and the two GIDs via explicit memsets).  Several u32 fields
> (max_send_wr, max_recv_wr, max_send_sge, rdma_mr_max, rdma_mr_size,
> cache_allocs) and the 2-byte alignment hole between sl and
> cache_allocs remain as whatever stack contents preceded the visitor
> call and are then memcpy_to_user()'d out to user space.
> 
> struct rds_info_rdma_connection and struct rds6_info_rdma_connection
> are the only rds_info_* structs in include/uapi/linux/rds.h that are
> not marked __attribute__((packed)), so they have a real alignment
> hole.  The other info visitors (rds_conn_info_visitor,
> rds6_conn_info_visitor, rds_tcp_tc_info, ...) write all fields of
> their packed output struct today and are not known to be vulnerable,
> but a future visitor that adds a conditional write-path would have
> the same bug.
> 
> Reproduction on a kernel built without CONFIG_INIT_STACK_ALL_ZERO=y:
> a local unprivileged user opens AF_RDS, sets SO_RDS_TRANSPORT=IB,
> binds to a local address on an RDMA-capable netdev (rxe soft-RoCE on
> any netdev is sufficient), sendto()'s any peer on the same subnet
> (fails cleanly but installs an rds_connection in the global hash in
> RDS_CONN_CONNECTING), then calls getsockopt(SOL_RDS,
> RDS_INFO_IB_CONNECTIONS).  The returned 68-byte item contains 26
> bytes of stack garbage including kernel text/data pointers:
> 
>     0..7   0a 63 00 01 0a 63 00 02     src=10.99.0.1 dst=10.99.0.2
>     8..39  00 ...                      gids (memset-zeroed)
>     40..47 e0 92 a3 81 ff ff ff ff     kernel pointer (max_send_wr)
>     48..55 7f 37 b5 81 ff ff ff ff     kernel pointer (rdma_mr_max)
>     56..59 01 00 08 00                 rdma_mr_size (garbage)
>     60..61 00 00                       tos, sl
>     62..63 00 00                       alignment padding
>     64..67 18 00 00 00                 cache_allocs (garbage)
> 
> Fix by zeroing the per-item buffer in both rds_for_each_conn_info()
> and rds_walk_conn_path_info() before invoking the visitor.  This
> covers the IPv4/IPv6 IB visitors and hardens all current and future
> visitors against the same class of bug.
> 
> No functional change for visitors that fully populate their output.
> 
> Fixes: ec16227e1414 ("RDS/IB: Infiniband transport")

LGTM. Reviewed-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>

Thanks,
Sharath

> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>  net/rds/connection.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index 412441aaa298..c10b7ed06c49 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -701,6 +701,13 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
>  	     i++, head++) {
>  		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
>  
> +			/* Zero the per-item buffer before handing it to the
> +			 * visitor so any field the visitor does not write -
> +			 * including implicit alignment padding - cannot leak
> +			 * stack contents to user space via rds_info_copy().
> +			 */
> +			memset(buffer, 0, item_len);
> +
>  			/* XXX no c_lock usage.. */
>  			if (!visitor(conn, buffer))
>  				continue;
> @@ -750,6 +757,13 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
>  			 */
>  			cp = conn->c_path;
>  
> +			/* Zero the per-item buffer for the same reason as
> +			 * rds_for_each_conn_info(): any byte the visitor
> +			 * does not write (including alignment padding) must
> +			 * not leak stack contents via rds_info_copy().
> +			 */
> +			memset(buffer, 0, item_len);
> +
>  			/* XXX no cp_lock usage.. */
>  			if (!visitor(cp, buffer))
>  				continue;


