Return-Path: <linux-rdma+bounces-19792-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKzjCnR482mt4AEAu9opvQ
	(envelope-from <linux-rdma+bounces-19792-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 17:42:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196534A5014
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 17:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8309C3009FB1
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9DE31A570;
	Thu, 30 Apr 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="g0w/Cj9M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD463B9
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563552; cv=fail; b=FBcEUVSTCDtab8nWE8NLJ8AJt6DQyyngR5EQIkvIr/pN5KI2YvKX3MQONjezt+Wi36d3oC06cFTwxsaxtiMoluaH3b7/ZCePb9SOX/427RWC7yrau0w4kAhm7NbzllGlD2FgTutGZPt9siJRmH7/MF3JgqKIzhbHC8hnx9lMy70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563552; c=relaxed/simple;
	bh=BG3tN6rkbgQYJFERAq1v8F7hc29nkyvTMlmV+PoORFU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QO8A94iQu3FJuXc7VQL+Yvy0biZyimmX9J5EF0N6Kcs3pSME9aLpdSWFkN79mEg/3WbTfHzgI52uVSgnEpu21YeOz83DWKPdbtEBhRSTaD6Fi91ARm7WDzSnZuTQXuZ0G14Upt2slbgGgO0nkpwQ3IlBr5Fu6y3JlL6EmJZUwOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=g0w/Cj9M; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UFWpHv2063906;
	Thu, 30 Apr 2026 15:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=BG3tN6rkbgQYJFERAq1v8F7hc2
	9nkyvTMlmV+PoORFU=; b=g0w/Cj9McX6gBjFoNr8+qY0vwIFFgbw/k9Tj1djEYZ
	fGjTm+Mr6WM/Jjxq2hbl63BRU5H3t4e1jyvi5sCZ6inKuJRiSfzPpvpffd7S4uBM
	NkZLZ/XtnE4QuRnZS/1y+6dhip8kZwan0Y8doHJ/341AffKpK4uc5vkNiveK247t
	oaGoRbDsMSi6EYj6UkxxyrjVgwnArvUxNQTKjjJRde/zkjJYgTn+6Q6pwum5OhSN
	BerABsiaVSF3vJkLc8mIztGlIrRc/p0kCEHhMDg5unVOuIlOnIWvlRZG4Pf40rUF
	kMfpTymoJNlWx/sbj3FIFHKJ0YTKO0AuVZbQnnP77hdg==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4dv473vrsq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 15:38:59 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 1D6E28164C0;
	Thu, 30 Apr 2026 15:38:59 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 30 Apr 2026 03:38:58 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 30 Apr 2026 03:38:58 -1200
Received: from DM5PR08CU004.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 15:38:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7kVwlNxb1cYQmAdI1mTMJZ+T2z/+zMoM5VsmxWmfcmXy6U0F0jIVu4ETwVuaaVYZv+loEfatL7TKVTX5j8/2wv8CCjd6Ckl17GUpfY3eU0xulnSxcy45gckLvx381/r1aRVDEt1sMkq0bF57V2eJOMxPdV8wJ+AV7fEOmu/zOnS90NmTwEdtz/o2UMLh1QnrV4jD/17UCsUR/RfOoQ7MzN1OrnLFdFlR+iqOpyZJwB/p7vf2r0OHde3W0EgUFGz9F2UEkR78/t2xH7SZBYONdTN7NWveO2QJwRR/h9fIaaTSotimVNXrh5E9FjYZG3kaU2W/NviFb8n2JYaTfLANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG3tN6rkbgQYJFERAq1v8F7hc29nkyvTMlmV+PoORFU=;
 b=AKUjvKmsXBkYrUACJ+Zwmh/3vzimAnRVpgG6Ib9S/roTc8YPqYKj/2sZE8YmW5gSNsFAlHoQYOPcIA+7X64X/TRTjzzzx7Qi0DZm+E8DhSb3R+VyUGIYdHzYe6IILTXS+wQvX8/VTplKBFGRxL/Oax+EopnoEdZEjEi+tN2vvM+X1fcOdDtK7VPpq+VsuhBqUTkP/s9WC3A0RYG540DjoEdJBotxbVSAE3my46RJ5xBf7zjl/wsinpWECXFU1C+Tsz/UAH513e0sBXcuajyYSsLIuhuuAE1O+jec9jXyjbQ7nstWbCHK8/3SYWs1iEvp2N+2EhSEHXV4E22ewXbUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:225::20)
 by LV3PR84MB3699.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:21a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.5; Thu, 30 Apr
 2026 15:38:56 +0000
Received: from DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d136:e75e:53c5:73d8]) by DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d136:e75e:53c5:73d8%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 15:38:56 +0000
Message-ID: <79f353ff-23a4-4aa4-ac61-9cd7cf276c79@hpe.com>
Date: Thu, 30 Apr 2026 09:38:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 1/5] RDMA/core: Add Completion Counters
 support
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Michael Margolin <mrgolin@amazon.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>, <matua@amazon.com>,
        <gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
References: <20260416212327.18191-1-mrgolin@amazon.com>
 <20260416212327.18191-2-mrgolin@amazon.com>
 <2bfaa4cc-8e4f-43ad-a483-36ac1ae3caea@hpe.com>
 <20260430014922.GF3225388@nvidia.com>
Content-Language: en-US
From: Doug Ledford <doug.ledford@hpe.com>
Organization: Hewlett Packard Enterprise
In-Reply-To: <20260430014922.GF3225388@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0szboiStgcDd881UGccqaq9c"
X-ClientProxiedBy: CY5PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:930:14::30) To DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:8:225::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR84MB3970:EE_|LV3PR84MB3699:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d3bf98-0c35-4985-7013-08dea6ce9752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: li467Vheu3ThA1ZAkTwafVBHLXHtD/jvrcvURfmwkxSMtkGTUnsV8e9FenGthR4V7S/6n261cUzjn/5dEwp6LtKAPHfgtIaq8SZzX0bcSGBSkynoCUbpFu54QPrSvh4rWuEp62kObNCdqZ/7JxE+ObQLdrK9CihsmF/NACtrLuXdv1zZtemLXX6adtKqQg/bI5TYSpPbBR48J2nRS7MbRT4AcI9mNFs3AECGdDQdK0tKkDM44s/mW6FFQBuB1ptotts8a4oTs8U/zEZtNRAkvs9vR1W+iUx8yjHBS61vGNi/Tn5NV9snFn2bB8DQ1wEhL3MvAmM/GrMBUr0kVYVVTZy/8TY072RuXWWP1c6oqvbMIlDXhDMJ95pPuOSwbSbvhr7Cz6bVUvgYO4RII4pKcsAuA4DUEHK7d5T99rYHRRFkgp06MMQcFleScK++sNxxe7lOmJx8FM0jDezs4A9kMRC3FbG48lpmJljAlcPM9GlOm3jPShnzJycgIP8WKXuvHz+ufWPqLNNpqw/Gf/8DoQ9w5twPTgbRcIljDg+O3lSnsRS1asgHBprMdBA/P/Tt3OYWATz6UV2F21yd1ZVzTgbONExhhM42Q46T9s43ll+945mVRHqH6wqDPVzy6Pqa/aBYy3Wm5PqxbYr3t7fE9k/Tp6VkOHAmjE7feIPpWiiAG2OJ7TSTRO3RA5RmqW1IMP9Ik0uc6skTVmr8mPED2WFhsHKUDmKpnJRhcDfzUGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjB4TlNkZ0ZKVURuMUNvS0Q1L09xUFhMd3p0R0R2LzVRRWRkNFE5M21qdzB4?=
 =?utf-8?B?anVuZ0pQRXF0cDBPaWlSWUxXUzg5d2pOVVduNEg4QThOendmT21WNXAwZ0Nv?=
 =?utf-8?B?VHVhbWVFRkR5VjN3emZrV2VoaW9sOWRzMWZQT1RvR2t3RFJIN2pjRUdQeWp5?=
 =?utf-8?B?alRrYlVOSG1RUXpvL21VUnNJUk54bm5DWlNqTE9ZYnI5aFo5R1Z2UlgzVGlP?=
 =?utf-8?B?Z3VJMTRHNFpvRFdZUXN4cFloS0hPbUt0bkdwNVZIL2U0WnhqRm1HMVpWdkYz?=
 =?utf-8?B?ekNmUmd0TFdhbTBRSThVTVhGang4S1ZIYUxKSmtkOWQ4bGh5YithZXl5WExV?=
 =?utf-8?B?OVVML1d2RTFOL1pLTVZyeHhMek9lV1VKT1dZbEViYzBocnlSMWNKSGdWMkty?=
 =?utf-8?B?UFdpc0Fsa1dTYjFzR1RuUTRiNVhCbzNnbzNaVWFGckkzQm05SWwydzIrTUpn?=
 =?utf-8?B?RXJIYXk4eWsrSTAyTWZiWnBsTytNSE9mWmVWRGsyL21zMWlEcGtpYnJOa0lj?=
 =?utf-8?B?UThjc0xSY3V6cVdxRUFpS2ZtM0NhTFB1SW92SHRmNHZwU3NPUzltbkp0MzNp?=
 =?utf-8?B?TEpQUHBnTXJtc2ROZWlZTjVZY1YvUUZzeCs3RWJPbG1lSTJZUzNhSmpQUDZQ?=
 =?utf-8?B?Zk5RVWd0TkZNVCs1YVVmVXU5TFNzQ202R3laeXlMV0x5bERYQk01OWZnaWdF?=
 =?utf-8?B?NWI4Z2J0aFg1bkI5UzBSRnRIL1F3aWNnOTVOcXU2dzZRS0pqdWpsMlAwOUNx?=
 =?utf-8?B?VjUrLzVLOEg4dHhQZUNoZkVpdGlsS0V4OGtCSVdkWWhvODVVMDRPQnI2Rnls?=
 =?utf-8?B?Sks1djJHWTd5TzhubnhwUUtjM3E4elF5SFR0Y3pOK2g5djhPOEMyTXYxK2lX?=
 =?utf-8?B?SjlCZjZSVmZtODM3YVNCdHh3MUtCb05mY2t1MlVObVVxaVVxMDRqMURtVUpK?=
 =?utf-8?B?cC84MVNXT2dvYzZUU2lYTWVybjF4Z096MTlrYWZ5c0JpV3pDKzdVcXVnUVBs?=
 =?utf-8?B?THZFTlJreXNnL0ltTXVVOU4zbEhlQVJLMFhHbVpxQzJnK29qUkV2ZENmZTNS?=
 =?utf-8?B?YlRXSnVsOW53cmsxZDMvSFE3NHJDZFZzc1dKb0RUaDE4L0wrYmE3Q3oxMXMw?=
 =?utf-8?B?bU9FVitGeXhGaU9MMS90VmNyb0pUQk5qTmZFL3lOTlJ6TlZCMWpNeHhxMWZ2?=
 =?utf-8?B?YmoyZisrbzQ2R29EMDlkbjJMMXNuRGNqcTQrTTR2dEwvU2NrRFVjdTdQT2hT?=
 =?utf-8?B?cE51NnZ5czRpQkJFdE9YSTcwNzhYUmZRMDFzNUx6bm9VQm12Q3hoMnQrK1FF?=
 =?utf-8?B?Q0k4TDhpbklLdzIvMHV1cnVHaFJ2QXZLMnVuNU9JRUVWbHl3UC9DRXRPYlhq?=
 =?utf-8?B?NG1SeGN5S1hBQUdIS09hTndZZG9ucFRLMjcxa0gzZkFOOVRadmxhcFhWNjFv?=
 =?utf-8?B?amZvcWRsenFsdHpEVEttbGVCVFlHUUl5dG5VWW91YUZZUUVSN0FrUm11L3pH?=
 =?utf-8?B?SGVUTE5kUHpKeXBoUEliZklpTW5xV3h3Q1g4VjBZVk1WUVJnUGNHeHcxYVlr?=
 =?utf-8?B?c014ZnNlcXBFbXc1b0N5SS8zTlhibHZlSDZ3a1JqUTZxUk1Ubjc4Y3J2aTc5?=
 =?utf-8?B?ejlOK2xCc29xMDQ3VEllWHE5NWxkZHlvMVpDSVJIZVgwQVVKTk90SVBudWkx?=
 =?utf-8?B?Z0ZTc1ArNVQ0R01WeXZVWGZRSFlPQ0dSNVVvTnNuZU9RQXVoNXlSZTRRazFu?=
 =?utf-8?B?ZktLRHU4amw3K0lVZm5WcmR1eG9uYlBwbytvR0pFWFpEWGxneEFRQnFNTndG?=
 =?utf-8?B?Tm1SRW1icEZaNkNkNEZaOVZDOEJHS2NoNk0vWjBiRStwUEZKVnY4by9Ddkxz?=
 =?utf-8?B?QlAvTWJUS2xqNkFGKzNCOVYrMHlZbkVDOGF2Ny9YbGdtVXJOMkVwalBYZVA0?=
 =?utf-8?B?TXYxL0UrQTlGVmxLbnh4QkxXNlpoeVoxd08vUjN2MnZ4c3FiYmh2VzFSQlJ5?=
 =?utf-8?B?cnR1VURab1JxVVB2RENxQnFEZzYvd1FTcjVEM1VJb3ViMFlsTDFZUlVhVEgv?=
 =?utf-8?B?VkMxeGxIR0VlMTlqVkl6ZVNXRGluRitKQzk3T2FibjdRbGZ2OWt5SzVVSGJ0?=
 =?utf-8?B?cHV0d3VuZWlZTTJ6MDE4Wk90U1BiWktiaHhZaHhFVHNQcFBET2J4TmI4WnhL?=
 =?utf-8?B?UURwd0lVWDdnUEUyblptK3BGQVdEOXhuNFAzaUdPZm0wOXNBWmpWVFpWL0lo?=
 =?utf-8?B?YnN2VkVHZlpRcEdOdUNWQTV6T2djZDdiM2VjK05HeVAzZTdybEhmODloOTB5?=
 =?utf-8?B?eFFXYUVPYkN3NU9kc0U3TXNqUEp4d2hpRytUcG9nOWx0N3o0ZDJhdz09?=
X-Exchange-RoutingPolicyChecked: SRfIMmtDyaNPnXIitootOYibR/2yvvab9jUm6g109hF3iHfkKl65l+mfi+2bt8cfNynTZOuHFI9RiOYLz6DhMgHMsAe6pbb55l3Gy1AZszog/igCOrhZU9gmnPEFCcb+msm1MxmUX7EtToQGGh5h4CAiPehFuLuazHd6N0BHVbu6yAbDGAz7pgiGhCpDnhf6c6CoVgiJAdUnbgbQ6tEFMjzC8nXE5mUxQbjzQdbx6Pnu3QfCcHrBsWq1yg6Kr2+arw1fOJhC1b8y2Amu3GBLvaSX2Kg/2rpwiKBibbKwvcnKU1uv52SgTjxJIFKfqMYoLym0tEQkISOdD4GXvGIIrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d3bf98-0c35-4985-7013-08dea6ce9752
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 15:38:56.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEGI57d596/f5J6wl7z+s12kymel+RotPURfaiCyDfYI36B+Hu1Z7zgQhFZTsSLEgqbGCaJhUYkAkvJ8M9HwfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3699
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2MCBTYWx0ZWRfX5b61xGn1jO6t
 lHblFWbCz5Fmj1JCdfKmfZno2UBRhwKomCBokgVDYqLI6edy1dcUtvA96jOt6LVta3pDgOq2s2x
 4LPqlYI6OsUMJjgSnZv+InLCiznZtZLY6JhVKIcx0K9Xuq9HSYWYY1UcSRoYjD731C/wdKbsTZt
 +NgmTRksg9U2Ai0PAX5UZ20a14QHkrP0PR2USzkiPNwQTmbNEyiiQvnD6/EZl4LDjTtczfSg8b2
 VlhUZst+swm+feTV17gLzyf+euDM+vnt0Y2qNTNnVK0CU8aOGzOVAo4MjqDXp4Awdpes0BsHzEZ
 E+MO+OI8BXT1Bl01ps/3IETn/HGNvT5iAvr8Xa/0ir+OrhtEywP2LDPjy+tnRoEx1dyXSGKptxe
 rRKj23rnEOGlQ3ijl7ssQZHyITsukEUz1icx0JqbcbahxgXTbPgaI8f/gT/kNFsJT5tIq17JvVS
 sfL0yovL1LRbTKmEmww==
X-Authority-Analysis: v=2.4 cv=NMjlPU6g c=1 sm=1 tr=0 ts=69f37794 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22
 a=MvuuwTCpAAAA:8 a=SOcOhGbPVSlzdLwpTSgA:9 a=QEXdDO2ut3YA:10
 a=4eQYGmlYOGrjALJbu88A:9 a=FfaGCDsud1wA:10
X-Proofpoint-GUID: 2WuN1OzvL_32Dr_MwBjEqp-FXLhCOAHU
X-Proofpoint-ORIG-GUID: 2WuN1OzvL_32Dr_MwBjEqp-FXLhCOAHU
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300160
X-Rspamd-Queue-Id: 196534A5014
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19792-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:email,hpe.com:dkim,hpe.com:mid];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doug.ledford@hpe.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]

--------------0szboiStgcDd881UGccqaq9c
Content-Type: multipart/mixed; boundary="------------6sv0E1033RZIRgqGl0xPLAv6";
 protected-headers="v1"
Message-ID: <79f353ff-23a4-4aa4-ac61-9cd7cf276c79@hpe.com>
Date: Thu, 30 Apr 2026 09:38:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 1/5] RDMA/core: Add Completion Counters
 support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Margolin <mrgolin@amazon.com>, leon@kernel.org,
 linux-rdma@vger.kernel.org, sleybo@amazon.com, matua@amazon.com,
 gal.pressman@linux.dev, Yonatan Nachum <ynachum@amazon.com>
References: <20260416212327.18191-1-mrgolin@amazon.com>
 <20260416212327.18191-2-mrgolin@amazon.com>
 <2bfaa4cc-8e4f-43ad-a483-36ac1ae3caea@hpe.com>
 <20260430014922.GF3225388@nvidia.com>
Content-Language: en-US
From: Doug Ledford <doug.ledford@hpe.com>
Organization: Hewlett Packard Enterprise
In-Reply-To: <20260430014922.GF3225388@nvidia.com>

--------------6sv0E1033RZIRgqGl0xPLAv6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8yOS8yNiA4OjQ5IFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFdlZCwg
QXByIDI5LCAyMDI2IGF0IDA2OjUwOjU0UE0gLTA2MDAsIERvdWcgTGVkZm9yZCB3cm90ZToN
Cj4+IDEpIE1ha2UgcXAgYXR0YWNobWVudCBvcHRpb25hbA0KPj4gMikgRXh0ZW5kIGNyZWF0
ZSB2ZXJiIHRvIGRpZmZlcmVudGlhdGUgYmV0d2VlbiBvbi1jYXJkIGNvdW50ZXIgd2l0aCB1
bWVtDQo+PiB0YXJnZXQgYW5kIGluLXVtZW0gY291bnRlcg0KPj4gMykgRXh0ZW5kIGNyZWF0
ZSB2ZXJiIHRvIHBhc3MgaW4gb3B0aW9uYWwgdHJpZ2dlciBvciB3YWl0IGNhcGFiaWxpdHkg
dG8NCj4+IHBlcmZvcm0gbGltaXRlZCB1bWVtIHVwZGF0ZXMgYmFzZWQgdXBvbiBwYXNzZWQg
aW4gb3B0aW9uDQo+PiA0KSBNb2RpZnkgcmVhZCBvcGVyYXRpb24gc28gdGhhdCBpdCBjYW4g
ZWl0aGVyIHJldHVybiB0aGUgdmFsdWUgZGlyZWN0bHkgb3INCj4+IGp1c3QgdHJpZ2dlciBh
biBhc3luYyB1cGRhdGUgb2YgYSBidWZmZXIgYmFja2VkIGNvdW50ZXIgKGVzcGVjaWFsbHkg
dXNlZnVsDQo+PiBpZiB0aGUgdW1lbSBjb3VudGVyIGlzIG9uIGEgR1BVLCBpcyBzZXQgZm9y
IGEgdHJpZ2dlcmVkIHVwZGF0ZSwgYW5kIHlvdSBqdXN0DQo+PiB3YW50IHRvIGZvcmNlIGFu
IGltbWVkaWF0ZSBhc3luYyB1cGRhdGUpDQo+IA0KPiBBZnRlciBhbGwgdGhhdCBpcyBpdCBz
dGlsbCBhICJjb21wbGV0aW9uIiBjb3VudGVyPyBJdCBzZWVtcyBsaWtlIGl0IGlzDQo+IGNv
dW50aW5nIHNvbWV0aGluZyBlbHNlIHRoYW4gYSBzaG9ydGN1dCB0byBwb2xsaW5nIGEgQ1E/
DQo+IA0KPiBKYXNvbg0KPiANCg0KRGVwZW5kcyBvbiB5b3VyIGRlZmluaXRpb24gb2YgImNv
bXBsZXRpb24gY291bnRlciIuICBJZiwgYnkgY29tcGxldGlvbiwgDQp5b3UgZGVmaW5lIGl0
IG5hcnJvd2x5IGFzIG9ubHkgcXVldWUgcGFpciBvcHMgY29tcGxldGVkLCB0aGVuIG5vLiAg
QnV0LCANCmdpdmVuIHRoYXQgb3VyIGhhcmR3YXJlIGFuZCB0aGUgZnV0dXJlIFVFVCBoYXJk
d2FyZSB3aWxsIGJvdGggYmUgc2VuZGluZyANCnRvIG1hbnksIG1hbnkgZGVzdGluYXRpb25z
IHZpYSBhIHNpbmdsZSBzZW5kIFEgb24gYSBzaW5nbGUgUVAsIGp1c3QgDQpjb3VudGluZyB0
aGUgUVAgY29tcGxldGlvbnMgaXMgYWxtb3N0IHVzZWxlc3MgZm9yIHVzLiAgV2UgbmVlZCAN
CmNvbXBsZXRpb25zIGNvdW50ZWQgdG8gYSBzcGVjaWZpYyBvdGhlciBmYWJyaWMgZW5kIHBv
aW50LCBhbmQgYWdncmVnYXRlIA0KY291bnRlcnMgd29uJ3QgaGVscCB1cyB3aXRoIHRoYXQu
ICBTbywgZnJvbSBvdXIgcGVyc3BlY3RpdmUsIHllcyBpdCdzIA0Kc3RpbGwgYSBjb21wbGV0
aW9uIGNvdW50ZXIsIGl0J3MganVzdCB0aWVkIHRvIGEgZGlmZmVyZW50IGVsZW1lbnQgZm9y
IA0KcHJhY3RpY2FsIHB1cnBvc2VzLg0KDQotLSANCkRvdWcgTGVkZm9yZCA8ZG91Zy5sZWRm
b3JkQGhwZS5jb20+DQogICAgIEdQRyBLZXlJRDogQjgyNkEzMzMwRTU3MkZERA0KICAgICBL
ZXkgZmluZ2VycHJpbnQgPSBBRTZCIDFCREEgMTIyQiAyM0I0IDI2NUIgIDEyNzQgQjgyNiBB
MzMzIDBFNTcgMkZERA0K

--------------6sv0E1033RZIRgqGl0xPLAv6--

--------------0szboiStgcDd881UGccqaq9c
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAmnzd48FAwAAAAAACgkQuCajMw5XL91f
HA//fZCZpDs2EbO0nQMLUvCNbh/D4qn+YUq8Wb3h3dzgVEFAxG+sfelo1ZV/bPXAFHP0afy4Kf4k
F/yqbzCRWVfulXoE4mFPMGTJx/AUZT+YrSNbQVarg30nE9Ulc1T9FEy5OnrpdhweE+T5yVV+Xmp2
s3vaceOp52/0otx2IgLFoxLK+EdAqdjGz+pmvV4Hh25mlbJ8Vu5wrRie1Qs9n01Lc5COaVD+3mCy
mPJrAC+EzF1UPL1y6WnYPlYM/RzlLxzn+kRePBBicUDWwerli6hlTpfuu6TxIZih9/VzQj12c90K
GKakRECsHK/Bbw+qws7UsIoTSqeMx5OP1M/HjMGaPc+xRqhcJ3nRQ4kC0yq+06SJrR5NFuHcCePH
YwNp0bjIKYcB+5dWn1NqC02W3+5Wv2bJBY09QQdxhAC0EpCe27DSr7YfUQ1pSKZYriPKUR63J/Jq
vdm62Dw39nmEl7fQpqU9o2vKfuWMORAYDEc60CTlxppSSefKQVF6Qi3OBfxKwpNBGrQ/iVFBjPYy
0lk3iF/SQzeY4r16LYBLOmLcZNaH9yEU3ElXqcDXu/DBccfpzHHUny9eCFNXBiolBfrnT9nzltJH
NnFzw34xLPr+BRfbBPNY8HuMF2r/aspwydoYUjpLEzSgp+Ev1wantcYF9Ixclbq7gQdcSZd+Yl6G
Vtw=
=FTzn
-----END PGP SIGNATURE-----

--------------0szboiStgcDd881UGccqaq9c--

