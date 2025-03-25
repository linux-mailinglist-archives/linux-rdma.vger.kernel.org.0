Return-Path: <linux-rdma+bounces-8930-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45365A70274
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 14:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210F8845A6A
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7980025A632;
	Tue, 25 Mar 2025 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gsg2NNTF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3425A648;
	Tue, 25 Mar 2025 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908955; cv=fail; b=in32RJcdXYI4fjDr+eM+nbKppe13QIOPUsmIy+ST6Kp8/5eSMP4Ufkcpl1i/4HIO41Mj9YqZ8UkwqgM3wdUrjbNsQ3++h4JEWqOWfWdk8Q+ApFMOUHCZa0Bs0LzEapAsIyDL8rODEm/xmQnAI9lPuR2+RMjmefqjaK4HlB24c0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908955; c=relaxed/simple;
	bh=TRfa0gFtofiNtjc7Q/sqH4xf2AJ/uHalkfV+3g96l0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MMZPRVkCspJxWjtuvD8wyyBSkfAF5Ukm7SygjY5oEzzIfJUBDmuBoTnbwOH/kPvlAdqSAsQRFZ68Mg85fzK+G04022ND9JCaJBrT/Fai5b9TN5uQJNGjebveahS3BgB9vXBz/NTsomKPvvO1yklqcdBfeAZLpoBkigMGHmI+76I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gsg2NNTF; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PAHpSl024024;
	Tue, 25 Mar 2025 13:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TRfa0g
	FtofiNtjc7Q/sqH4xf2AJ/uHalkfV+3g96l0c=; b=Gsg2NNTFxYA1v+Pc3yLPSx
	m6SucrGrmfLOyPraZNcmzHohMB9JEUieK9KSe9O8L0ZmTcoIfzk1gjDT5Nt68zPn
	UfJLi1lUSKcI/6cMno+EhddGRO2M9xp9lwquFr94A9X1VNc5UuA0wL237S11H+hF
	UR9fOwMirQssyza85pWpktBcQXlysFCPOe1HaxldAMyxdWbF5qqlEee+8M1t/Gjx
	4pvlmDpcFWeerQXvnsr5S4n/VJd5x0ftCNBPRpD+UqDvHcqTt1i0Z6H4Mc1kgBsM
	JIp3VtW2A4TrBve/aet+NFpyRUdiSPhiEJ1rAmnCGTZlErfraAysJjnWZZv8Ha3Q
	==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekyusyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 13:22:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kc9UBvD4uWynf+OkqdK9gmGY02mOhkbtJ24vvyWl9YvOau6QxfNfjIQmNdVAzUadMAy1wX7uMK6UJzz/xuJniq/nyPSnskZhkVgmIvwWWZ1ekFhppsCXbJz2MXn3UyDe69HDHU8AENeQB/bum7ISOsdo96IirMjZcefB1BvO/c86WM3Y0AA35O9+Mf+17lVDRxkEwAwijDrOUaMwFVNZhnpvxFGmxkiVx1TyLToEfWAagAZ6iGlgQD3m9pqhCNw3AYqK56u7rBcvrMPt4WNS5JlyqhVfqPPnQ84dsUB4xZ0Zr1wgetH1j6z3MaXtf97kQ4Yh/Bq+OzugSJ6Bb4BHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRfa0gFtofiNtjc7Q/sqH4xf2AJ/uHalkfV+3g96l0c=;
 b=cSl4drTIXrfKyqmbIoCIqM3nPl3AfdJc7WLBrZd4Z2hYEaHy+NKb04zzJztTi8T2oPrvCJJFnFvG2fXN9M0X02RM1Z6OhL5opmPJKjdBXmaukzSuKLRGASzkNSdp8Z71AdEq+s6h+UmNp4teyuAlGZugYR2f7E57j/mnbZYjy6YsZ6qlA5HJCmxPDDe3mLucaQn3F5rx7zvoRjY7Zou6I1RTOPnelno5qmxhba0hf3k6XqZx2Iluzu/IUYaL+wNn0L7+BKq1/fv3D8XCX8M2TV9FsOn13+5J9O+rDRc2wlynIRWnyAwGSwUOVtgsod09aEAYr2xeLXhmoyAEMYe8Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by MW5PR15MB5148.namprd15.prod.outlook.com (2603:10b6:303:193::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 13:22:04 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 13:22:04 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Sean Hefty <shefty@nvidia.com>, Roland Dreier <roland@enfabrica.net>,
        Jason Gunthorpe <jgg@nvidia.com>
CC: Nikolay Aleksandrov <nikolay@enfabrica.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
        "alex.badea@keysight.com" <alex.badea@keysight.com>,
        "eric.davis@broadcom.com" <eric.davis@broadcom.com>,
        "rip.sohan@amd.com"
	<rip.sohan@amd.com>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "winston.liu@keysight.com" <winston.liu@keysight.com>,
        "dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
        Kamal Heib
	<kheib@redhat.com>,
        "parth.v.parikh@keysight.com"
	<parth.v.parikh@keysight.com>,
        Dave Miller <davem@redhat.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
        "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>,
        "welch@hpe.com" <welch@hpe.com>,
        "rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
        "kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index: AQHbnQOuA0vptNDDbkq8DItdNXWk2bOD1Q7A
Date: Tue, 25 Mar 2025 13:22:04 +0000
Message-ID:
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
In-Reply-To:
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|MW5PR15MB5148:EE_
x-ms-office365-filtering-correlation-id: 6ffcfb5b-54be-4b82-c492-08dd6ba008f0
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YS9vekw2dzZHRFI3ZmpWQy8wekpFVS94dFJLSUdyUjhuOCsrUktEMXN5dzRj?=
 =?utf-8?B?SlcrNi9nR2xTc21odXdhRzFKSTVCVHU3VzFNMDBNbHFOamc2MGZWMms1L2Rx?=
 =?utf-8?B?YUpFWmhKcmk3U3RxRHAwVXR6MzRFSWhEbk45L3VaTmovTXFBbHp0djNFdEVw?=
 =?utf-8?B?VUFXa2gyZXNuUitlUFU3ZFFVSHpuRDVSVUNzNkVoU1hIZ1JVWXdRWWFyTlpp?=
 =?utf-8?B?SGs4M2RaMGw4T3ZMdFhCTjErTGFXTVUxbXpUaFYwb0t3bm9oRHJoY2wyQnpQ?=
 =?utf-8?B?VkY5MzNDazBRYmNUQ3FLMUZ1bTBhZnFOMmp6ZzdnTHlrZ2lkNmdIdWo0M2Iz?=
 =?utf-8?B?MmFBSE1xeVRFKzg5OURrREJrS2ZiWkdGVmFoZHJ5cHQvSDQ3WFhwK0JmRFFN?=
 =?utf-8?B?d04vOTVINHBOd1NtS1N3OVBjalFvVzRWZVRWWEhuNDVHLzFycS9aVzFRZ05Z?=
 =?utf-8?B?TXF0WTcyWkVObkxVUVJwemtqUWU5NG9vWHEyN2VCUzFuUDFVTTduM2ZmRU4w?=
 =?utf-8?B?R1doWnZ2b3ZuVWk1MWF2bllFSWdQeTB4U2pLRnEyMnNrQ3BMNXBwK2VhVHdv?=
 =?utf-8?B?UTEzNWRiUmNYbTIrOTFpeEhHT1hlU1JEb1R0WTZDS0IxNU15V0IzOWhKcW85?=
 =?utf-8?B?SVFzSlgyUlJrbUhtLzc3V3JJbzlVZ2Y4NHNtb3lXRlhSV1RtVm0wTVptUmk3?=
 =?utf-8?B?SVBUNk1PVlVUVlRJYWtzTFU2VmJhZTR1QkhscmI3dk01MmxmUmV0RXdCVzJl?=
 =?utf-8?B?TjZlZ2luY1EvT1NMcnQ0Mk5rdkRGNENXNkVtNkpsUnovcklaN0t4MVRQUHdH?=
 =?utf-8?B?YXIxK0tDcjBoZFB5WWZObjdEZmh4eWh6NTRWNWtlWmh3MjdGRG1EN3FvSHRC?=
 =?utf-8?B?SWZNZlBFeUJSOXJoT2MydDRYeUJ5ZFdaalFEbThNbnAyU1owRWc0T012T1M0?=
 =?utf-8?B?MTF0S2kxZWVCbWxyUUJiUW9CdmU4U3NZaDVTYkE2eHFBWjIyNDlYL0F1UEpU?=
 =?utf-8?B?K1YzbzZueVowZldFeHBiUGRaVHprbURxV1VZNEtRNjQyem4xT1JQSWYzemUr?=
 =?utf-8?B?bDM1Y0dkQjVxcEpmUmxTb1F4TWRucjQxT3Era1JWYW5QV3hXRGxTY3IvcVRE?=
 =?utf-8?B?elpmMks5Z0ozTzVuWVoxY1lEN0NaZ2s5TEVyemhVbUhkVGw2WlJ3cDRKZUNE?=
 =?utf-8?B?ZXpEZDVvTTNwdE9vQ2pSNUlBYWxYY0lxUFM2WkMzc2RKS01SeVZHTForUDUx?=
 =?utf-8?B?QWZKR1RqVTZUaStidTZJNmNpQzJSSjZOUFg4MzY3YlBicDNWbkxUTVFlRnl2?=
 =?utf-8?B?dTk2ZlU5NGpWZ09vVWtvcHNIU1pNYTlmREVMNXJ2QUNLcVJBZGZSWlpLZExK?=
 =?utf-8?B?ckFvN1pyVklXU2JqZjd6bE1wMlFFMVNUQkJJaWlrM3o3OVp3dEVKZThjcTFN?=
 =?utf-8?B?RHlQZmVWNk1UZUxrYmZ3WG10MkJhV1g4TGVqQ25XNHJyVnlOR0NvUTdKOWVK?=
 =?utf-8?B?SitFNS8xNHppQkdCL09qTzRoOVZuN3F3TDJxVVJzZk1vdzJXZHVtSXBhUXh2?=
 =?utf-8?B?UC9mWUpVaXZyOE9ZNWdzZkJmMitmQnpUL0NCSTFnbnN6UTY0WnRVOTlmeCtw?=
 =?utf-8?B?dmtTQW5jOFNVRmFBTDVpWUhOQ2pUVHZUQWlvWGxIcE9tODJmVE5sMjJjQXZq?=
 =?utf-8?B?bzM5OXdWeHZWQ3puM0l6V3p4aUlRTENSVDVzdjE2cWw3cE5mQ3AvWjI5K2ZC?=
 =?utf-8?B?RDA2MGtCYlAxSGZBK0dpNVBScVhMMWdvZUhjbmIreDNpZTdTSkU5NGdRTTVo?=
 =?utf-8?B?ME9JaVErVmgyZXdBQTdSM2dMeENtWUdoTEJhdi9xZEhudWtGZGZaS2dpaDFK?=
 =?utf-8?B?MWVjVVV3RDJ1MUtyT1V6VDFrdmRteWNYNk9tTDFzZTMvSUVmZjF3MC9Qd1k4?=
 =?utf-8?Q?QbLpgQib4X/RZgtm58SbnYkp0A4g5jWs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXg1dFlGQXFRdkNLZktwSkJyUXlRNE9MV1huU0JXdmNZb0YwRktKZWM0WWNj?=
 =?utf-8?B?czVFT2xVWGtXMHVMdWhmVVJtclIxSTJxT1VJUW1NRGFoNVptdXFPRGl1UXNH?=
 =?utf-8?B?a040MUFJQ2owY3dEbi9vMWYrbzBBeEk5YmR0aUdqMzZkb3JDbWRSRDJEWVB3?=
 =?utf-8?B?RWF5NEhHby9Cb3JQWnp1dk05a1pUWHNYQW13a0wwZkdudnJ6clQrdTlQUzA4?=
 =?utf-8?B?czZGcUttczR3REJweVF5Zk5pTW9PRlpDMEZBRmpCU1J2K25zQU1IcVFGMnFK?=
 =?utf-8?B?eEFRNy9sMmJYRHhCdTVhenZRMnZDVnFJY2VMekJoTHVNWUdLVkluK0pIbjBW?=
 =?utf-8?B?cUQ2UkppdjFldk9Yd3dHV2xjUGh1TTBZNVEzd09NYmdPR1RqQ3A1R2liUFlX?=
 =?utf-8?B?TU85aVVhR1VVSzhLa3RXMHlBWXI1TzVNUjRqTThZVzk0dFRZeGtWVkNJdnVj?=
 =?utf-8?B?SWlzdS8zbnpFQWJNSDRRcG1YbGY0M3ZBR1I2SXVQZXdaRmxPQW5KbFlNRnhB?=
 =?utf-8?B?Ri9UZG9zWmx2R3dzME4wVGsrR01GNHdRVlh4U1AxOHN2VEhVY3RBd0RnTjY4?=
 =?utf-8?B?SGtQSkZvUzVyVGJoNjdHSkw5NGR0Q01ZWHlWUkhIN0hySW5vZjFCelZ6aHJV?=
 =?utf-8?B?UHYrZHhiWEhEcEdFRWdwVU1jQ1NycXdnV3VINjVPeVFBL3MwUHF3dFB5a1Yw?=
 =?utf-8?B?cGhGZ1BSQ3ZsMnJkUmFYVVhJcXV1OThoa2E2T1lkT1Q3eC94NS8vZzc2dDJq?=
 =?utf-8?B?Wmk3SW56ZklYN0dkdDdBL0djTDdjVUxoQ1gzczBsdzFVR2FyK3FQMUxlbi8v?=
 =?utf-8?B?Z2xVWnZ1TGhVbDVPWmZTQ3ZRK21OV0ZXSkZLUWVvbVlmdGJjZlBNeTRRNUg2?=
 =?utf-8?B?MWFwb04vSVZFZGlmVi9KL1NxeHI3WGNzWVVmajVWYUlIZWdYZ3dLVmJQWmFM?=
 =?utf-8?B?ZVZvRFo4cDJVN3ZVakJMei9hclIwR0NzV2VnQk9FMFFVanI3VDhRNFBtLzFE?=
 =?utf-8?B?RFZibmRraG11OERrclNEZEY2VWRETHR5NitCUnRqTjd0dUNBOW1WMDJaSWJ2?=
 =?utf-8?B?K3NxRURmQWkxR1J2QnorOG1xdkRudjV2N3ZxNlFVZkEwbGE2WE1JczZkZUt4?=
 =?utf-8?B?R0RNZlkvK1U2QkNCa3VyRUpxVlgyYnJPL1IrT0dxVTFjRVVuM2wyQk5aUmNW?=
 =?utf-8?B?c1F5Y1N0OFBnK2ppQk9jMjlBZjZTdkpxc2lycVVDSXNiZTZjRkg0cGtTSk9u?=
 =?utf-8?B?WWtlTVNRaTlJUi8xMWUrQzM4ZzZmNlE2UXludktuQlp5L2s0bTQrcTI1T2JO?=
 =?utf-8?B?M0gwYmY5TGhIN1JQam9jVVNJM3Y2YkhuTDJzWGNJS2V2L29oZWdqSndJMjZB?=
 =?utf-8?B?Z3BxKyt2dkl6dHZlVVdiRmVzZ2I0U1hFYzhZQTRidGdUb2pmd29MTTVnSS9D?=
 =?utf-8?B?QndqZmZLcTZyd1NXd2xIcGRzOFU1MkJDODZ4azZTK2ZWcGhGb0UzUzhDeTN0?=
 =?utf-8?B?QUVIUExDRW9xS0hENVVTVjY4TzRCaWI3TzV5NWFzMnRaVVpscWJpRmREVWJB?=
 =?utf-8?B?cTE2MW9ac282QmdjQ3lMZmRxNzYybGppZzdoVFlJT1VLLzNEb1NjNUlLbkww?=
 =?utf-8?B?dm14d0ZJREFuSjdabmR4YXJOeExEbDdCTS9jSU0xRTlRUi80d2FPb0k5WUhz?=
 =?utf-8?B?SmZYRi9rbmUyQ1MxcklObUNtZ1VqTnhZNlh6TnhKREs2Vzkzd2V1T0pMdzRB?=
 =?utf-8?B?VjQyVHJ6L3RSSFpTcWNVcktoY3M2K3QzR2dZMWc0Mk13cVJzUG1TZEkrWVRD?=
 =?utf-8?B?b3RMdno0YzEzcWNDNFJabXNDYXNrOVhMVUJhQVZrYzNFT0MzVzM0Nlh2WmIw?=
 =?utf-8?B?UEo4Nm9HQklFOHZHNkh5cnVUdXl4VnlJNmFMZk9RellQWGJuRDR1ZXA0aTdT?=
 =?utf-8?B?SEJIQXpNSzA2d0VicU1RVCt1MlV3Y3RZc3Qxdkx6emtYV2Y4ZDdHUGZOb3Zl?=
 =?utf-8?B?b2M3RHdNZmQ0K2RTNU5jeFdNdzQwSys5N0FRcHdBa1lBMUtsVWg3RmJXZWxX?=
 =?utf-8?B?VmZsUUV0U0ZkWUFRNitTSGN1dDVZS1BLTDliVjRzbXVVV3hRTWo2d0Z6YzU3?=
 =?utf-8?B?a1VNeE82MVVBR25GSURVRHRqa0dmcWVpQlFUN0szT3MyV3lWK3JPbXNuZ3li?=
 =?utf-8?Q?t4cnYF7yeZQy8rCzokR7q0k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffcfb5b-54be-4b82-c492-08dd6ba008f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 13:22:04.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KD47XR8eO50OYM8DhHDzuspkzsjA1S1CsqSg6vRpmKaJH6gf42FLnvc5L70ocKpvZLY6lXYYWtFFhX4qUlhbWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5148
X-Proofpoint-ORIG-GUID: t2lmr_jgfZa8A-HldtVllb7vWLJx3djt
X-Proofpoint-GUID: t2lmr_jgfZa8A-HldtVllb7vWLJx3djt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_05,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250091

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2VhbiBIZWZ0eSA8c2hl
ZnR5QG52aWRpYS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjQsIDIwMjUgMTA6MjggUE0N
Cj4gVG86IFJvbGFuZCBEcmVpZXIgPHJvbGFuZEBlbmZhYnJpY2EubmV0PjsgSmFzb24gR3VudGhv
cnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gQ2M6IE5pa29sYXkgQWxla3NhbmRyb3YgPG5pa29sYXlA
ZW5mYWJyaWNhLm5ldD47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IHNocmlqZWV0QGVuZmFi
cmljYS5uZXQ7IGFsZXguYmFkZWFAa2V5c2lnaHQuY29tOyBlcmljLmRhdmlzQGJyb2FkY29tLmNv
bTsNCj4gcmlwLnNvaGFuQGFtZC5jb207IGRzYWhlcm5Aa2VybmVsLm9yZzsgQmVybmFyZCBNZXR6
bGVyDQo+IDxCTVRAenVyaWNoLmlibS5jb20+OyB3aW5zdG9uLmxpdUBrZXlzaWdodC5jb207DQo+
IGRhbi5taWhhaWxlc2N1QGtleXNpZ2h0LmNvbTsgS2FtYWwgSGVpYiA8a2hlaWJAcmVkaGF0LmNv
bT47DQo+IHBhcnRoLnYucGFyaWtoQGtleXNpZ2h0LmNvbTsgRGF2ZSBNaWxsZXIgPGRhdmVtQHJl
ZGhhdC5jb20+Ow0KPiBpYW4uemllbWJhQGhwZS5jb207IGFuZHJldy50YXVmZXJuZXJAY29ybmVs
aXNuZXR3b3Jrcy5jb207IHdlbGNoQGhwZS5jb207DQo+IHJha2hhaGFyaS5iaHVuaWFAa2V5c2ln
aHQuY29tOyBraW5nc2h1ay5tYW5kYWxAa2V5c2lnaHQuY29tOyBsaW51eC0NCj4gcmRtYUB2Z2Vy
Lmtlcm5lbC5vcmc7IGt1YmFAa2VybmVsLm9yZzsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQu
Y29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJFOiBbUkZDIFBBVENIIDAwLzEzXSBVbHRyYSBF
dGhlcm5ldCBkcml2ZXINCj4gaW50cm9kdWN0aW9uDQo+IA0KPiA+IEkgdGhpbmsgdGhlIG5ldGxp
bmsgQVBJIGFuZCBqb2IgaGFuZGxpbmcgb3ZlcmFsbCBpcyB0aGUgYXJlYSB3aGVyZSB0aGUNCj4g
bW9zdA0KPiA+IGRpc2N1c3Npb24gaXMgcHJvYmFibHkgcmVxdWlyZWQuIFVFIGlzIHNvbWV3aGF0
IG5vdmVsIGluIGVsZXZhdGluZyB0aGUNCj4gY29uY2VwdA0KPiA+IG9mIGEgImpvYiIgdG8gYSBz
dGFuZGFyZCBvYmplY3Qgd2l0aCBzcGVjaWZpYyBwcm9wZXJ0aWVzIHRoYXQgZGV0ZXJtaW5lDQo+
IHRoZQ0KPiA+IHZhbHVlcyBpbiBwYWNrZXQgaGVhZGVycy4gQnV0IEknbSBvcGVuIHRvIG1ha2lu
ZyAiam9iIiBhIHRvcC1sZXZlbCBSRE1BDQo+ID4gb2JqZWN0Li4uIEkgZ3Vlc3MgdGhlIGlkZWEg
d291bGQgYmUgdG8gZGVmaW5lIGFuIGludGVyZmFjZSBmb3IgY3JlYXRpbmcgYQ0KPiBuZXcNCj4g
PiB0eXBlIG9mICJqb2IgRkQiIHdpdGggYSBzdGFuZGFyZCBBQkkgZm9yIHNldHRpbmcgcHJvcGVy
dGllcz8NCj4gDQo+IEkgdmlldyBhIGpvYiBhcyBzY29wZWQgYnkgYSBuZXR3b3JrIGFkZHJlc3Ms
IHZlcnN1cyBhIHN5c3RlbSBnbG9iYWwgb2JqZWN0Lg0KPiBTbywgSSB3YXMgbG9va2luZyBhdCBh
IHBlciBkZXZpY2Ugc2NvcGUsIHRob3VnaCBJIGd1ZXNzIGEgcGVyIHBvcnQgKHNpbWlsYXINCj4g
dG8gYSBwa2V5KSBpcyBhbHNvIHBvc3NpYmxlLiAgTXkgcmVhc29uaW5nIHdhcyB0aGF0IGEgZGV2
aWNlIF9tYXlfIG5lZWQgdG8NCj4gYWxsb2NhdGUgc29tZSBwZXIgam9iIHJlc291cmNlLiAgUGVy
IGRldmljZSBqb2Igb2JqZWN0cyBjb3VsZCBiZSBjb25maWd1cmVkDQo+IHRvIGhhdmUgdGhlIHNh
bWUgJ2pvYiBhZGRyZXNzJywgZm9yIGFuIGluZGlyZWN0IGFzc29jaWF0aW9uLg0KPiANCg0KDQpJ
ZiBJIHVuZGVyc3RhbmQgVUVDJ3Mgam9iIHNlbWFudGljcyBjb3JyZWN0bHksIHRoZW4gdGhlIGxv
Y2FsIHNjb3BlDQpvZiBhIGpvYiBtYXkgc3BhbiBtdWx0aXBsZSBsb2NhbCBwb3J0cyBmcm9tIG11
bHRpcGxlIGxvY2FsIGRldmljZXMuDQpJdCB3b3VsZCBvZiBjb3Vyc2UgdHJhbnNsYXRlIGludG8g
ZGV2aWNlIHNwZWNpZmljIHJlc2VydmF0aW9ucy4NCg0KPiBJIGNvbnNpZGVyZWQgdXNpbmcgYW4g
ZmQgdG8gc2hhcmUgYSBqb2Igb2JqZWN0IGJldHdlZW4gcHJvY2Vzc2VzOyBob3dldmVyLA0KPiBz
aGFyaW5nIHdhcyByZXN0cmljdGVkIHBlciBkZXZpY2UuDQo+IA0KPiBJIGJlbGlldmUgYSBqb2Ig
bWF5IGJlIGFzc29jaWF0ZWQgd2l0aCBvdGhlciBzZWN1cml0eSBvYmplY3RzIChlLmcuDQo+IGVu
Y3J5cHRpb24pIHdoaWNoIG1heSBhbHNvIG5lZWQgcGVyIGRldmljZSBhbGxvY2F0aW9ucyBhbmQg
c3RhdGUgdHJhY2tpbmcuDQo+IA0KPiAtIFNlYW4NCg==

