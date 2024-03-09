Return-Path: <linux-rdma+bounces-1351-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31C876E4D
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Mar 2024 01:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F07B2231D
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Mar 2024 00:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F82DA34;
	Sat,  9 Mar 2024 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cUyKvVhM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mxCPplN5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262E7FA;
	Sat,  9 Mar 2024 00:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709945731; cv=fail; b=odk/o4S+PtmpuCzJ6E3eRct01f5pGeWhXyNrZde3V6IOkI0upqd99boR8kaeFOymIMrOJEIQasuF31JP0MTsnw7uDBE3TeDTTas3xXVHwpWiZxm0yZvd1ReQxbh5wU4z1vavWcfwv54KnWO8mla3XtcJBZNvtCi4B6ffiDHPa0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709945731; c=relaxed/simple;
	bh=opDraYD7d6cxcwVbpgBcZuVZ4DEQs/jCwBoaXNu6MhQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VTgHiaygpMI0Spr3rRmbCw2R50+wBBgw3JMHsUsvJHAPOWhxYP/7fO4OKJN1I/cTrkyZTy6cCiJJuM0MQqReZ52cgFGmXFCift8Uziyv/q3BgdF3e8y6ff8oDx5MiZc9+FjkLWlG0WkySw34DflawrhU6zAd5MD2EZlgt1EX9tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cUyKvVhM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mxCPplN5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428Laalo006730;
	Sat, 9 Mar 2024 00:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2VEIQuNvqT6UMxLO2sfibZoWaRvBpo4wkD1g9JatyMg=;
 b=cUyKvVhM+J/8aX5Y/d6j3CSsAdCjScNHUOAyBp2DFmWJ/NLF8PJdDfZIigt8DSpVPJyn
 OZ1T5D3loNbWJPqQdfVVJmuOiItyYwGrSLQtnmqp5oWmF33E+gHo7V4NCGkydPkFiLoP
 cJ1PaNPHMHZPDqrmxg8Xxx9/aKykLsUL6gf6+7Ya2DtJ/N6Ln7Do3hBSsbBD/D5JU3k/
 FqNM2FvI/dO3Y0HnBBtJ+apJcXNReFkMmlCHuMYARG5GCvFobj1f7bUKztaZo6Mpt1jZ
 q8v3XDheJlnt5ZMUbCycC2EShHSc1XDEDJ90zpAPKbc46OXUtO+z7b214rBJr9ci8Qe1 0Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktheqxdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Mar 2024 00:55:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42908GOJ027521;
	Sat, 9 Mar 2024 00:55:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktje413g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Mar 2024 00:55:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fC6qZfuxalcKt3iUMZm3GuHIk5wx2nFqccGwWtujUdnJg5Wp8VPj/hu7L3pNBZz/wFrbGv2/kztm0VZ2GClDsgnXu96CxJB4ECcR1v+ykpu87GFEAwj/F7elcVjry7dZ67850RcyybLevCfka0oEzO1z7UZJvwn6xCsWD7UJfGQ3G3L2LFwhJzlImb0Gt2YKrviHj8RuV4CFvuJ941FsHCBlByWOVhfMagyOrjeuzb4vdKPoFQslazvmlazGRXDF2LFnedOfbtsyohTH7OyTP7taqZ3uNKw5DY+PUd/b1UdSXrJAWe30772FeCtsL+jyAU88UsqdK2vensZOMFQ7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VEIQuNvqT6UMxLO2sfibZoWaRvBpo4wkD1g9JatyMg=;
 b=jMf/Yt7eWsNJHFLFmeTPyg1ThJ0t952Jp0y87ssx7x42jiWAH77FjUc/To2cBg8RqpB6dgS4ANaGsW322jtV46DctjlA4Nt1CPENEu8X49Gd5K3HrE0H9NYZmrmqR4ngeAtzAp/nQn84R2TN9RRP0AG+Y2s1oZsw6ucH1/lFqRM+77O2fCcYEtBn5yJiPnQQUY0a4d74ClJZQkIRbRLiajiQhd5JTyj1v9JtvcZPmE/KjMq3vwGQe8vs6gUifgbU2o/MQF7S1kNgskuGV4VRGtWmvJgSkr/kS05v1SXu41QuzV792KBkrBzffCStSBZYpN8y6NmZ/UPxtI+lqO3Yaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VEIQuNvqT6UMxLO2sfibZoWaRvBpo4wkD1g9JatyMg=;
 b=mxCPplN5X9GO7eOnc/tqIMOsAMa9XMxsCz2BJbH8ZitKdR1Jd2nU+DIUguvUhAseGy9CVaEK8ull9A4+1MfQiSbt+nXZG//pm5OGuuk+OHkEnLVYOd+2AwHX3lFqdw2wnreSxobpxVG+0WS39YhaLTW7B1jZFWGYldYJGdqK4xc=
Received: from CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12)
 by PH7PR10MB7851.namprd10.prod.outlook.com (2603:10b6:510:30d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Sat, 9 Mar
 2024 00:55:17 +0000
Received: from CY5PR10MB6216.namprd10.prod.outlook.com
 ([fe80::34e:f5ab:6420:ca75]) by CY5PR10MB6216.namprd10.prod.outlook.com
 ([fe80::34e:f5ab:6420:ca75%6]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 00:55:17 +0000
Message-ID: <1bb40d6c-a542-437d-8e81-9ae834bc079a@oracle.com>
Date: Fri, 8 Mar 2024 16:55:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/cm: add timeout to cm_destroy_id wait
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rama.nichanamatlu@oracle.com
References: <20240308005553.440065-1-manjunath.b.patil@oracle.com>
 <20240308141852.GR9225@ziepe.ca>
From: Manjunath Patil <manjunath.b.patil@oracle.com>
In-Reply-To: <20240308141852.GR9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:208:a8::40) To CY5PR10MB6216.namprd10.prod.outlook.com
 (2603:10b6:930:43::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6216:EE_|PH7PR10MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c82840-b523-4355-68e0-08dc3fd39630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5kkZfGhVYOz819tQDK9LgxyKoXII3UC3dCV7ge4qDbQGLywzkbu5BNfbtYbp2wihzjuZ5/mw/0WUPgzJMolQIHKJlEV/GBcgmPArymopA6OZw9g31bEx8b+4UYayQq8UfjNkFq9N/2/SxG1vSJpgWCLZnL/MZkKMsEZwFcXKGK6o5ojDZDLZ1ivY2gjXec82OZddBnbr8pP6qepMnLPtiE2frrdXE4JZMyK6nHV8ZRKOsYWQWaidYVf9azIL3HJjrEjb2FZ5o+3jPS7sfqzIIrbSAO9lkP3HbhgtFU7FlPD7Nlw3PbBJWKLqmveCzBWyjdE7AAOvzl7HoPUXyaPbDipWOt7cPy9U4etyx5b/4D+qbyU/Zk475m0sd6RjXEcLYWG3VrJN0444Xgzx03WuClfzZqWfSjhhEkGNEvm9s1xeGsJMhrDQTfSyOYyrAvwoSqhN3sB35OgDSANahIar/uVQPkHieZQVDW5vIHPHru6AIXY91EPEt1yIfdOD7YpwOtL6b+hb3Zy593epkVnsunmYlUXO6K0LKFUw0tX7eHgLidmdOeHcs9l9Ut9UTFBh3UTQtNguVhk8RaLlOBzuFbhcz2ezRND002I4IhQ8wu+MbTnDzltieoJohjKZa9hLHVeTMS0sS6NsoeML/sX2rC+5zUm31OHOZDgSpqOXacI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6216.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NTNMTWk2c2VDSmdwa3daUWFVaE1Uckg3ZzhrRStIZDhGR2NQL0kyTlVYblNI?=
 =?utf-8?B?NXJBUDFEZmt5ZExlcG5uTSsxRmQyb1hoZ1RXcmVFTzdMT3luTFQycWkxTm9O?=
 =?utf-8?B?UzJuMGJXNmRtWWk3T0dzQllCUTZjb25YYmh3ODdERkNzYnQzWWtuNkZRblhv?=
 =?utf-8?B?N29nUXlsc01HYTlEeXhZOFhXZEVkQnBTYVVRM0xGT3BSVmhQZHZYSDNUWUp6?=
 =?utf-8?B?eFd3WWJKempGM1RWWVFTOUk0eUdhSHJuTnZkWXVONWdJRzMzWFR2WnRNOG45?=
 =?utf-8?B?RXc3bm9tS2ZhTjRXaUFaMFJYRlhwU1kyVzhKQlB2U1R0c0ZzeGlDM2wvdGxV?=
 =?utf-8?B?cE9Jc2Vzb24xRTZVaFo2bGUvaGVJZjM2aFBSSERlSjZMcktyUExKZHhQYUtU?=
 =?utf-8?B?WlNRY1NCbkJCSmVBZXJBMm43TklrZ1lpTUN1YVlTWDB1Z3dXclVkdWxNR3pU?=
 =?utf-8?B?NEx6UmUvNk5UT0l5ekhicUxpSVpHdEpHdXBidVdUQitvaTNPOGpGV3NLUTlG?=
 =?utf-8?B?QzdSbTYrSFFLRlhkUExjc3U1MHZnWmFoYUZDeWdwRjVuS2l4TWZsU0t0dFhp?=
 =?utf-8?B?WldMdjZXOGdrRm1WSjZWNUlXOUZtbGlJU2RZVzlFdHNZWFphUjErNHBhL1Iy?=
 =?utf-8?B?VUlEY0ZjYlRZVHVXM2NwVGhMU0tldU9SaWtKck1oc1J0Vzl4T2FVYkZGZDU0?=
 =?utf-8?B?WlFYVGNZSW5sa3NmMnh6UXVtUjJ5WGNYS3VpYk5uRXJOUlJSemhqNlJpU0JQ?=
 =?utf-8?B?eC9jNXFZVyt4dkJBYVh6Wk9zU0hZUkVlYTNSQ2IyRGdMRkVZL1B3OTIxSHNz?=
 =?utf-8?B?ckE3WStvbm05RVUwWHVBODUxYllVT2xzd2JPaDB5aGk3T1JqbUx5VHFOS0VH?=
 =?utf-8?B?ZXBpV0hiS3UxMFVDay8vRjA3WDdocEtyMVl6SlVwYW9xLzlic2FnZUdreHlC?=
 =?utf-8?B?aCtLMXVBQXp2cnp2cmlHaElaRGJkNkJkRWpmdTh0MW1RdmlIOWUxckVhM0xw?=
 =?utf-8?B?WFFIZmxsKzRzOHMxYk13T0pGMUl5YlV4VVdMWTJPWlJqdFNIVitFVUZSSHgr?=
 =?utf-8?B?aS9WWWRTKzR0QjBnSFVTYzlxbFl4NzhGL2VlZk1rcUVFTzh6ejJzOUFPVHdX?=
 =?utf-8?B?ZURMQ1N5cUVINFhsUkdiNDhvakJoWXp1VmNrU1grSFdUUFlCNCt4RTEvMWI1?=
 =?utf-8?B?V2NLb3R6K1ZvTmNHRXgvQVlGRkM5cEplaUdjSlc0QXVUT2xqdzU0NHE3ZThZ?=
 =?utf-8?B?OVQ1dUZxRFdIanh0aVl0S2c0RlRuZzRTVVNvMllJa0FSNjkvNEVvMTA5ZXBm?=
 =?utf-8?B?M3ZQNk5kZXpleEFMU0I2bTlBTFFta1dPcldXSk9xenRsZzRheG9CdnNVYXR1?=
 =?utf-8?B?ZGZYSDhZSVI0WWdoVm5rTU50S1kzR2hob2tiV3ZPd2dTTjlMd1FPNTBlaGY2?=
 =?utf-8?B?WHhidTBkWnppcndCNkhlRktyMVJSTkRnT2ZGcWVOVk9Uc0dJaDkxaFI5OThO?=
 =?utf-8?B?ZWZEZ2h4bUZhREFrSTRkWFV1RVFCRE4zbzY1MGVuTjkrOVAyVTJKYVc2aGd6?=
 =?utf-8?B?UkQwVEhyQ0tTMDlMaFA2VnIzYlBtLzFGbWJjOVZqZ0xrS1M5N2FTNUttY1Bp?=
 =?utf-8?B?WXRnSGh2QSs1MmIrUE01dTRlcmRTYis0Y1FWRXF6blRTTlhiRWYyZGszZHRk?=
 =?utf-8?B?MXBXUnFHRlVIZnNSK25zdkNYdDBxWjhZKzZnSjdNcHg0VGFuYXpaVXNJQk9Q?=
 =?utf-8?B?cTFla3JKTGFsZGY2MEF3WUxCM3lveVVOSHBDSTJtNTAxdkloWllFYmNCQVBL?=
 =?utf-8?B?Z3RLN0xQeGdXYkIrOVZRb1RCZkV4Smowa0hmMjZ0QVplbE9VV3BVeVdIblUr?=
 =?utf-8?B?dEpPaWtacGV1U2NKRHVTWlJSd1MzNTZMdVpiaGdYWW5BMFcvalBXa0cvOGww?=
 =?utf-8?B?eXdQaC8rOW5seUd6eXE2TkpzN21FNHBYVlB0S3gxcWlxMHpaWlVuSVF5NFh4?=
 =?utf-8?B?b1Job2JWSFVKYlBobGNqYUxSSVB5bjJvSC9NL2tnSGI3a1RIeDRtNmJWTnZI?=
 =?utf-8?B?L08wcXptR05RRlM4OGV6dC9SYmI2NS9xRHk3eWJCbjZEVDZkMSswakljWmdp?=
 =?utf-8?B?R0RMMkNSSjdUVU1aaU9uZmRqak82NlAyMmVlSWc4ZFJ3VVU0cy95alJ0Nkt2?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iGJRGWBeoFJni5HrOtfS1zjLMMZLRoN0f5plHPyMYW3sK0Wjx9dBTwxzroAXth1d4qafK12LI14f0vONeNho+2pvvCJx7E5gJ3pJdLr5t+mLvKh8Gxg6n9bztcY6egUKIe9WXlwApN3idwHDm9VSdTxU9fYhvBL/dJO+jKjKZCRPvMWKXgT06lnEIAhfPnd4m4G8QfELcGZ5MnVMmUxyGRUeNrQthV6C8s5Z1tQRnnDVstvW3qmMvgKP7GMIR12HRJLF/IYsFsK5rbF2Y+nw5pbuEGRkwGmWzPOy/VgNqUG3HxxP9WssXkaMwylgxiHYqcuIcQr2UWf/1FPExuezIhLqOjrLJM40H2zsT2mpRbIzRimzH5GdcHFd9tBLD4luyrzimNMc5/oNQIPuQ6oU4Wyf5N8NVzQ53XNMfnhjuJ7e5xGWoU4cspOX94rSLmR2VNXxb81in064Ow0RUPu0OnvrwMQE3RY8Bsqw3zZOBcv5mOVVfUsTO5bW2pyjS31o5dZyohWzKspiuk1GWAfDv9hNKJ3YrN9vZJQsoRjCCYexvrcrkXo9xplofNzn3UGM/2cRVgsWADkzRe15gcSYI4hNjiJH8ZZoOlgwh9IjwVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c82840-b523-4355-68e0-08dc3fd39630
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6216.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 00:55:17.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1R2NDilWeF0w9leoZHOgOW6NfEWFkvZ89OANYaXGqpsSEIIGvItZUv+FT1lAylRjYlB9W+1WnsHP3Vlr3kSWn8t9ympAcWLSgcWAfpHA7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403090006
X-Proofpoint-ORIG-GUID: NA56oA6den0DXuCkD0pK8sP8vqTkdfMm
X-Proofpoint-GUID: NA56oA6den0DXuCkD0pK8sP8vqTkdfMm

On 3/8/24 6:18 AM, Jason Gunthorpe wrote:
> On Thu, Mar 07, 2024 at 04:55:53PM -0800, Manjunath Patil wrote:
>> Add timeout to cm_destroy_id, so that userspace can trigger any data
>> collection that would help in analyzing the cause of delay in destroying
>> the cm_id.
>>
>> New noinline function helps dtrace/ebpf programs to hook on to it.
>> Existing functionality isn't changed except triggering a probe-able new
>> function at every timeout interval.
>>
>> We have seen cases where CM messages stuck with MAD layer (either due to
>> software bug or faulty HCA), leading to cm_id getting stuck in the
>> following call stack. This patch helps in resolving such issues faster.
>>
>> kernel: ... INFO: task XXXX:56778 blocked for more than 120 seconds.
>> ...
>> 	Call Trace:
>> 	__schedule+0x2bc/0x895
>> 	schedule+0x36/0x7c
>> 	schedule_timeout+0x1f6/0x31f
>>   	? __slab_free+0x19c/0x2ba
>> 	wait_for_completion+0x12b/0x18a
>> 	? wake_up_q+0x80/0x73
>> 	cm_destroy_id+0x345/0x610 [ib_cm]
>> 	ib_destroy_cm_id+0x10/0x20 [ib_cm]
>> 	rdma_destroy_id+0xa8/0x300 [rdma_cm]
>> 	ucma_destroy_id+0x13e/0x190 [rdma_ucm]
>> 	ucma_write+0xe0/0x160 [rdma_ucm]
>> 	__vfs_write+0x3a/0x16d
>> 	vfs_write+0xb2/0x1a1
>> 	? syscall_trace_enter+0x1ce/0x2b8
>> 	SyS_write+0x5c/0xd3
>> 	do_syscall_64+0x79/0x1b9
>> 	entry_SYSCALL_64_after_hwframe+0x16d/0x0
>>
>> Orabug: 36280065
>>
>> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
>> ---
>>   drivers/infiniband/core/cm.c | 20 +++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
>> index ff58058aeadc..00a16b08c7e2 100644
>> --- a/drivers/infiniband/core/cm.c
>> +++ b/drivers/infiniband/core/cm.c
>> @@ -34,6 +34,7 @@ MODULE_AUTHOR("Sean Hefty");
>>   MODULE_DESCRIPTION("InfiniBand CM");
>>   MODULE_LICENSE("Dual BSD/GPL");
>>   
>> +static unsigned long cm_destroy_id_wait_timeout_sec = 10;
> 
> Don't need this to be a variable, just make it a #define
sure. I will send v3 with this change.
> 
>>   static const char * const ibcm_rej_reason_strs[] = {
>>   	[IB_CM_REJ_NO_QP]			= "no QP",
>>   	[IB_CM_REJ_NO_EEC]			= "no EEC",
>> @@ -1025,10 +1026,20 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
>>   	}
>>   }
>>   
>> +static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id)
>> +{
>> +	struct cm_id_private *cm_id_priv;
>> +
>> +	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
>> +	pr_err("%s: cm_id=%p timed out. state=%d refcnt=%d\n", __func__,
>> +	       cm_id, cm_id->state, refcount_read(&cm_id_priv->refcount));
>> +}
> 
> WARN_ON? Is the backtrace valuable?
No. I would prefer just pr_err to avoid noise if there are multiple cm_ids are stuck due to any lower layer issue.

Thank you for your feedback.

-Manjunath
> 
> Jason

