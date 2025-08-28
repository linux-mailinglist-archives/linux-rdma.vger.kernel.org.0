Return-Path: <linux-rdma+bounces-12981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6D4B3A1F3
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 16:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F28188955C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AE4245016;
	Thu, 28 Aug 2025 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NTExrReQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oQjxqlSq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189561F5834
	for <linux-rdma@vger.kernel.org>; Thu, 28 Aug 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391525; cv=fail; b=fUbLm2ss4oXxfZhQK1wLwkdpdwRy0MU/UdTANL1T4L6ghzJMAosvNdOMaCaZNMdt9SGgbOhuwrkdRyu0yV7x4LZWP2w7dPV+9vUJ6yPxHKXmoUbewbsqagNzBppmueFDZ/9dsZreWp0Hoxu+L+hyz5X0AuT7ijuH7OOhFgYW7lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391525; c=relaxed/simple;
	bh=elVUtsP9FcPNCr+vSrBXOlZr2IyOz6Fov+frNYc3O2k=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=i+zTqzVQ8yzeYPnyIFcM7XIJaON6K9ihF+CwqFiEx1rFnAdFHMh3NFswAIYAnFNxwUuLA8vrK63bNql0H9QQmmXRPwhNnG4OZstassq32l/Lb5ArcZzNpLtZ7F7xvQQoT6DAmlaI+y0Gbz+U+mO4bWxj1LytNjs2YNRIe4+6wKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NTExrReQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oQjxqlSq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEN5U7029823
	for <linux-rdma@vger.kernel.org>; Thu, 28 Aug 2025 14:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=4SnRXGGMTa2ndUeP
	vwzjyIpmmme7d1OqzknUEe7bSYo=; b=NTExrReQe41btkTfkveraRMKqPqWovTN
	MM9n+vJISfD1K8maf9nZ+aKOT3rXGXQkJ3/VVJB4iN8kMUIVQDkywFHpaExnO0X8
	I0qlMtGv8w2E75uF80ROK/7JpAec+ToWsSZOS3eKboXbFsfHIg60abqlvAgMYC9y
	xoq3X1/aAOdKmQ45KMS65TYQQnQPJ9rLMJMaf7422u51Zs4cuQFqi/NMpsqdqGTi
	QMEKq+KfGPMaF+tXLiyM4pRocGPEx4mud69m0zxzZafXMbSm9vu1i8ExDNM2r12V
	cP0ZpT8dksV/Is9PXKmwTBQVRV+MeWZKI6716bXKiA/XvA4VYtq/OA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt8t84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-rdma@vger.kernel.org>; Thu, 28 Aug 2025 14:32:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SDnR6J018954
	for <linux-rdma@vger.kernel.org>; Thu, 28 Aug 2025 14:32:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43c2dgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-rdma@vger.kernel.org>; Thu, 28 Aug 2025 14:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=db4DdajSekBvJ1B9I8PLXUamyoN14G/12BucwgdvzeKZ8NJmskPUOgtDIoW0DHT/zX7MCdMS1ZxjWyPnJNQce5lyJYoKzSggGrxR3JN/t9fGvQ25HdjdQ6JyaiR34lVLYiy3eJkzmg7P6j5qexUfkN0URqeZcFmd+/UM8/NwxU5HJ92hcqzJAUFh80lRRw4iZo+Lt0gylF0DZwtW+el7QYPINgMOojSBI+KPqXNWUithlCVh/6duadaJDSN7D0AZiwxc3jQ63eCxL9lBhOPZR7QpE0Sq6wZVgBjm1g+V48anHQEZ4PzUY8eoet3jKmffBL9Fx5v5BesySGvYbORLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SnRXGGMTa2ndUePvwzjyIpmmme7d1OqzknUEe7bSYo=;
 b=wEoY7f7lA96B1IereKrZ4TNbMy37+7q2m7TCuJQNk034dackvEepJiLODXXClrbVIa2J5NmEF7/T4UDjes5B7+3hwRtoVZHzCSfq0JR6Yj4gxzVXtRKA5i6wV8cmzMVH/7JLlmOdiRMC/Az8Q+c/dGSVx/G9fJhPLC83rz9X9qqcsFHHVq0LAaySYvjyR5ddtEMp+l6cEMm6Xr+anqkNFZJclT/HWFgpvtuXcUDmXfamz5rvgCNNMgXsV05+4AW44xrfHrIbYWlV4z1vNStc51xoOpti7NizwJmcRA8CglJcV1Zzv8AJXOo/JBF45cVamkvOW88sqR9zBXhvReSROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SnRXGGMTa2ndUePvwzjyIpmmme7d1OqzknUEe7bSYo=;
 b=oQjxqlSqcJWE2hSySiZOcize5pcxfO1BwtxbjPHwaztRvW4doJe603He2w6LTi0H7S5+5k33ViiIReiaXon1GbTzhl6AeHqrxpaxtqcKijDWXb/mIkRmHgpPXJc6tdvDzTHTDHSBLWjeSDS0BhDKEnffxszwawUaQJ4sr+gF/lo=
Received: from SJ2PR10MB7620.namprd10.prod.outlook.com (2603:10b6:a03:53f::5)
 by IA1PR10MB7385.namprd10.prod.outlook.com (2603:10b6:208:42f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 14:31:54 +0000
Received: from SJ2PR10MB7620.namprd10.prod.outlook.com
 ([fe80::1941:6deb:1ee7:a578]) by SJ2PR10MB7620.namprd10.prod.outlook.com
 ([fe80::1941:6deb:1ee7:a578%4]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 14:31:54 +0000
Message-ID: <1e5a6494-91fd-40a3-abaf-a614bc3f0e2a@oracle.com>
Date: Thu, 28 Aug 2025 10:31:51 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-rdma@vger.kernel.org
From: Mark Haywood <mark.haywood@oracle.com>
Subject: cmtime changes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::7) To SJ2PR10MB7620.namprd10.prod.outlook.com
 (2603:10b6:a03:53f::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7620:EE_|IA1PR10MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: 7743e893-b0c4-4777-bcf9-08dde63fa284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHhVWTQ0ZTBMUTliUnNtUEM0dkJ4Z3RZMGV0RE1WN2o1TnI4dUtoWkdmS2dl?=
 =?utf-8?B?TCtDdHZrN3NJWXlXRWw3bU5oc0RKbFM3S0R4VjFTRHpUNndkcC9OeC9jVGEy?=
 =?utf-8?B?QW1QNElXYnlQQWMvTmd0UlgwQ2l0cDZyNzd6eDZLbGxSZXVOeUxMVFBHNGMz?=
 =?utf-8?B?Yzd4amI4Y2R6bnRwK3dpQVF3K1QzZVNDbk4xYzFwcXpsK1A2WHZ6T3R6ZzM0?=
 =?utf-8?B?YUw5NVdSMUJsY0NGWUlHRk9Da0lIZlFqR2dlYjBkZUZDVnAzaHoxSkRZZjdv?=
 =?utf-8?B?bmtGckcvSjRqU3o0MUw1bzBMU29FZEhBSGFHbFRNNWR6Vy9BRlpWRXNZYWxt?=
 =?utf-8?B?cFQ2ZkFrOW1WVXRpVlpXN0xJY0QxUWhWMm1TM1p4VXZaR0ZYK3cvSCsyY1pm?=
 =?utf-8?B?TEFoTWhpSjJ3bkc3MlY1QlAyakNjRm0yRnFUWnE4SENmUXovYlFsM0JQL0E3?=
 =?utf-8?B?cDdNMW13ZEhnNFhtZG5sTEVVTGsyVklMY3EwL2ppV01VdURlTXF0SzcvOUpu?=
 =?utf-8?B?Wm1WcEFCUXRNY1h5TUVKNjU3dDhscDBjU0laTTRSRDlLZ1BlOU5YWWdGTFFU?=
 =?utf-8?B?Q2o3OU1iOURRSUhYbWZVaUVHbklweEhLRXg1MUx4a3Q4WmNyUUZyOHVBbGsx?=
 =?utf-8?B?S2N4OWppUVgwMUNIN0Zsb2lkeEFtRHF1K1g1cUZFUm1GV0VXY3NGdU12ZHVp?=
 =?utf-8?B?S0VCL3BHeTVvV1F4eW5mWGJTeUpXdkJteHRWdHVuRVMvQkRVamFiOUF2MTJX?=
 =?utf-8?B?dEo1Q0RPdWNJUk92RjhrUkQ0UXp0amFrVTZlQ0lYU3Ixb1ovK3hzZU9DR3Jm?=
 =?utf-8?B?bm5QNllOdC9abEMxQm9HWmJJY2tueGYvS2V2ai9OVnE0RCt0aW1HR2RQUzRw?=
 =?utf-8?B?dXV6N1dieW1CU0V1UnB6bUIrQ3ZjSTVsVHk3ZmZWMDJqM1VPUzJwNUVNWUxN?=
 =?utf-8?B?NGVRQkxBMnpnTHlFSm1QYVdneUVVeW8wejl3elJGd2lwTUw3TStKRjROckdh?=
 =?utf-8?B?bm5jS3gyWTdNWG1ST3JrNnZmNndzajkzeWo3cG9yM2RQSC83aDNjcHJtSE1S?=
 =?utf-8?B?TEJ0OHdOcWxlV1p2QjVVNGI4bCtITEdVa01iRlZieVZzYi9kc0lpcGh0THYv?=
 =?utf-8?B?MkZFV2NMcDVIUzZwYWh1SDBXSHcva29wYjJYS29pYVZnOVcxMmRiaUM5dmIr?=
 =?utf-8?B?VzlDL1JGUlUvdzI3L2xoaTVrTHBzcG5tSnc5T2x4UU5NVGttenBKS3VUOVhw?=
 =?utf-8?B?VitnenhwcFA2RXlLZXFLTHNiNTJIOUxRMVpId2pCRDkxSjhEQ1Y0MUNldEVz?=
 =?utf-8?B?MTZiVHdIdHJ5R3grSlMyK1RaTEFYaGdsMW94UEltdGFGZ3VZSHJ5dU5qcWVr?=
 =?utf-8?B?SUxiRWpDc00wT3d3dkJCeTE5K2FLN1F1ZFFxKzZRSEZEM3BKeExVaXpUTW1m?=
 =?utf-8?B?MTlnWUl3bHIxRThTcEdCWE9CYkNZSmFDTTJTK0I4QjkwOUNLcTIzNDM4Wkxj?=
 =?utf-8?B?NFB0MHBRT3NqVnozOCtjV3pZbG9CUGJHSVFvNkthWnF2WWZ4eFN3TjJab3NF?=
 =?utf-8?B?Z25URE4vNTd3TkwzMm1mR2RzNDg1ZlY1ZWJkc3BVb2hoWnhTTUV2blE2V1hy?=
 =?utf-8?B?ajJ2SGkxcURET0Zhd0x2UnVpdUgyK3dYRi9henRQUjQ4bklpNmhKTjNXYVdJ?=
 =?utf-8?B?WURFMytUcjVPTkk2b0h1Q1J1NlkvRnFXemJ0TzF0eXpiTmxocm0wbmFXNm1x?=
 =?utf-8?B?SkxlV2plcitQWTljQUNWc3RPS3ZoQzhkdG82bjlDYUp1b3hNVlEyM1pmdWRw?=
 =?utf-8?B?MnVTSGN6R0xTVXcwWmxjNHFkamtMUUNzRS9NM0kwaW9jSDdId3l0TlpCTlRN?=
 =?utf-8?B?TWpvbzdqMUIwVk4xaW9NNnBzQjRaV1NsT1lJVTNBNnAzQ0REYm5UNTkzOHFP?=
 =?utf-8?Q?WDgAyMmU4Ag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7620.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajJUaFBOU2p6VUt4SW5Rd01yQ0M1QnFiUkZoSDVoTXY3M3ZDOURRckR2Qm1m?=
 =?utf-8?B?OEczQkt4aGFnM2d1cmg4OFAxZERHYXg2R2UvLzBqMjlkaFRQMTVUVW5iSmU0?=
 =?utf-8?B?NWluY1FWaDJ4TDR4Um5jUElaM2IwZWZsZ0l4dCt0dWM3bXdFNmhQU2RPRC92?=
 =?utf-8?B?NlVvNS9kT0k4Y2FTYnFESFNTWjJwL21lcjA0NGdJalFQOWdqcFdtcW9EWXJt?=
 =?utf-8?B?cC9XcGd3Ty81TzlCK0EyQkdwNTdWQXlwS1NuSTNDNXUwSWFPSFhaTUJDdklx?=
 =?utf-8?B?cjY1YTUrTDNuUldMaCswajRFYWRzdkJsUWpVNTZVb3BRR2RXc2hSWWNwWEJl?=
 =?utf-8?B?ejRHMDZVUVFNU0Q3T2JMeW5zRk5MbmZYK25ZTEdGbHB5YkpDanpyYVlwQUFt?=
 =?utf-8?B?bVZGRTdvS0pkbVEvdjRSdUN2WnNJaWtLajdma0tKMWh1S0JYeHVYYzFMVk9p?=
 =?utf-8?B?QkM2SVo3V1E5c0lIMlRPUzlLdzIyZnRZdHlFejd1Q3YyOUJtbFJFa2RZRGRO?=
 =?utf-8?B?ZkdjUUpiVTRDVFN6MzNtUTA3RHd0WnMzdDRDWjB6REFCem10Y1VkcVRjeUZx?=
 =?utf-8?B?WjFIcGJGZ0Z3Sjd4VFJZMlUyRTlWcWxNT3RjRWdWL3dTbUxPRHR3VllGcjJK?=
 =?utf-8?B?SUQrQW1QaDdrZGptQlNETmtuOVFQRDhIalBFcUhKUWp1QlE4ankwRnBHUDAy?=
 =?utf-8?B?ZG5qUVJ3RnZXSW1yRDBzUlRQcCtzL0syTDF2eGtWekVPNEhCeWZlbUZQMnN0?=
 =?utf-8?B?bmJrZXZ3Tmx3SUV6eHFmZHN0SVp1TzB1ZnJ2NE5DcFNpMjdhZjB0MkxvWTNK?=
 =?utf-8?B?TGlVWlJCUE9sMUZkM2d6MWY2Y01PQ1NKQVdvOXZPT1FIRTh6dFFiUGcxSjVi?=
 =?utf-8?B?c3FUbUN0dGVHTnE2S2tCY2h4dklMTEEzbTdaKzFUQzNPNjZKRVVnSFhnTmxL?=
 =?utf-8?B?bkpZallNK2hlNnVnV3g2UUJtRXErbCsrT1V5OFVjbk5GZVQ1TlE3ckJBRGRQ?=
 =?utf-8?B?K0JQMnF6WmpqZFpWR2FXWU9KVDlrbmVWdnNacm5WYnZVYlRnYWpMcEQwbmcw?=
 =?utf-8?B?ejRRZVFzMW9XK1FBSlI3MVB4dUxmUUpneDZRL1BpVGZ3QnQ0UmxGencvMlpk?=
 =?utf-8?B?bURwWjhOK1lTanNiRUpacmJyVXZqdzRNOWdlZ0N0Vm1zSEFSdGlPNE16bG5O?=
 =?utf-8?B?RWdEWUV0T3pyOS9UZUVPUlZ1NjhQaHRVZTNzdVJDNDV5d1R4a25KZEFjM2RX?=
 =?utf-8?B?dVlhRWkvWm5DSy9lZGZyOG90OWc4NXY5Z1VqY2lpTC9HeGlkRUlBcDZqTng0?=
 =?utf-8?B?OUR2VG5HbmlvWlZtSCtXMDlDREdrNW82dVVZelFDNDQ4Q0hrK0o0RUxMQ2N5?=
 =?utf-8?B?cTF4b2ZVSXRKL3VvUFQ0S0dMQjZDTjhWNnlmTU93WGYrWWxLNUlyb0RFMVZT?=
 =?utf-8?B?NkpVbUJBZlE2alRialR1cWI1N1V6azRMNzlzOGxRV2lJUlViYW1FZllaU2ty?=
 =?utf-8?B?ZzFWZDJ6L045c2E5MW9EVVpjZDNJQzNHcm92NDk4QmtoY0VFM0tqRGNhUWUv?=
 =?utf-8?B?cmRlaXVIUWp5Z3NHaC8zcWZCdFcvR3pzTTdDWVB3cjVFUCs0SDRLcnZjeTZI?=
 =?utf-8?B?cit6RmZPaUVjcnYyeDNRamp2NFArd213dXUzVWlHbW9Yek1GRjVVUG1nUVA0?=
 =?utf-8?B?MlpsWm1UcGZlRnBpMmoxZFRoL0d4Z1dzZFNqSHRmdEdXMElyOGZhL1l1NmpS?=
 =?utf-8?B?L3hRU2ltTlF0S2hiSHRsN2RYVWNibHhOa21taWtoYlhzcy8wbkN6RjdlRXpG?=
 =?utf-8?B?TEVxNGdhNVQyQUpBdGRwT3A5N095eE9wZXRWTVhES3JXczhQTGJOVXE4T3V3?=
 =?utf-8?B?WEsyN0RjMTNWQ01qMlJ6NGM0eVgvYThUL012SDNjb3p0ZFByYVgrUHE4cUlP?=
 =?utf-8?B?aVBWSnpxN3VmNG93MXQyc2NtbjczZm90YVNxWkgrYWNvZk5GS1RJWmVPVlNu?=
 =?utf-8?B?TnhMQ0hQTkRuUEp6dDFmeklwQ25VWk1HR093YkVUUTRRWm10dENUN0cyaTBt?=
 =?utf-8?B?Zms2UllRT3FsaTJoaS9BOFlCWTg2ZWI1eFNGaVk2UUpWenB6dmFqc2pQOWtU?=
 =?utf-8?B?ZEpNQVRoaVBHclJYNkJRaXBGMGM3c21YdG1SQk1ReDFtc29neEEzSURuK0M5?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MAgDps5zADKZQTo5oWknbvhqs/32ioSmwrqnXImty/l51/jCfmHn42lMBx+H2JXkmk/bML78F29v7c1El9/ANGYdIOShA8LnrCjDbp8GtQi4u0wvj9Asul6bKofeWfHvRP3v//r/fGc7/jOA85RQwd9QA1wP3vNfKjrmerWra/GB8+dp6tDSaVQ8Hw82DBkxKGMIIGzd8FVtELOo8QbGiIaaQrtjAaVahMU7qOnJyCtGdAF29KegCTZj69AIwuxY1yTqMoM6xRPxssLMVRfFoSCKCKbEVlyTtveySgNpL2HsLFuUE7RORMJ6aITPebAX64IbpwxEZ4eqkRYeonCewSC2afsW3vloo/2EUW0LzECR5lggNfQUa8bdvXp4a8XTu6kJmDSFlg0YiY8RfH5uD8KLE1eew51w+aX0/2R17K6SNRM04w3Wm9iRaKiBrZNcvrQPCSeJudkaVg8fTwJpH+i7SM4j+H4WbkYwleLo5of8d2daJ9omPSzQbU0CNQL2QGx4Nbcc/i/NCiItDu4ik70MZN+75lCIukI8nYGYQsoYbOhqKuiVU7FxSPXTX8fi3IrUTwRktWb0yI3EyvwFQ3rZ1UOsJoUXWPzrNly86Ik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7743e893-b0c4-4777-bcf9-08dde63fa284
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7620.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 14:31:54.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZhP+l+BFYrLCCKNqKRvtM7YCHDWpbCwgMa716ityYFspc6UU94Si8Hcw6m9SWCz9bBTdheK8ETokgNk0KIL/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=682 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280121
X-Proofpoint-ORIG-GUID: Q1__FLu7eoOXnzynKUnFl9cl2V6CKe_j
X-Proofpoint-GUID: Q1__FLu7eoOXnzynKUnFl9cl2V6CKe_j
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68b06862 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=NJf5A3QnYsBlZFehf0YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfX7P7u/1HxBLEK
 RKMgbmqznCmmr1eWXuqZFMO1ymf5hl+g9vjh426xdeuYH6hpI2AI47VP909/d+JA/LNkUUEVcOp
 UF5qMndtrPHorsvHKMdzVg5n/JipwNZeKenxajV6Qx+2xxtEKUMVhA0B+HsBF5hIbZLIkR3AEJB
 WxScR5ExNRxR6n3hkDmATJwMGzKjIMbPVqN3sXAe+P/TScK3KprkntVCEoxH3ItkTf90HRnaXL6
 T0LMY1lM+QwJC2qMdb98VQeTprCexWTH2GVb9r30B5OqeNPZxhFRsrkvap6Tf/l7DSFCTVcSUWC
 45zlNtvL3uyKv8YUp01KXfnYV0JRVANuLwJTxbGHZhLoiLG8mBqDDJ4EI4PIet86nkj/sDNShj+
 jVZWKOza

Three patches to librdmacm/examples/cmtime.c last month significantly 
changed cmtime usage:

93bf54a43de2 librdmacm/cmtime: Bind to named interface
67879d9f22b7 librdmacm/cmtime: Support mesh based connection testing
0892dd7700f4 librdmacm/cmtime: Accept connections from multiple clients

I didn't see may update(s) to librdmacm/man/cmtime.1. Was this an 
oversight or is an update coming?

