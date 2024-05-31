Return-Path: <linux-rdma+bounces-2725-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ABE8D59AF
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 06:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF23B21E96
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 04:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7047477F08;
	Fri, 31 May 2024 04:51:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DF424B4A;
	Fri, 31 May 2024 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717131117; cv=fail; b=QTYhDIhaZL/AN8/e22h6mtYRF65sqqUvZgh5bTreLk+JWzD7bAzOxMkfEsoz7pAu15vBXIUk09TYmObdgVIz8bd35/Bsu9HVNjZufmUEiFtwappKeed4Dyrk/GCwDGTiH87WsogHeoTQ+wwLga+GdH6x8wYGmvHHkbZrhkdDxvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717131117; c=relaxed/simple;
	bh=L17uKc6IgsIYiTD2NcOMrSTYiBL3FeZL47+FcY6pboY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XI2jF6vF9vyxPvrNaOSZN317Mu41dbeZACD6rZ7IJ82F67ABWdeRfiDPD3uLoSy9YFURzGuUcUa2Gqf7YYglGYbaZLmvfXKtwuCjtYhqhqIziA0RbqnKd6eTtCR7F0WuvSAm9BzAlyyr6jtuUpH+iy7aBAvaiu360VY+kNCzHTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V3NTcP018500;
	Fri, 31 May 2024 04:51:50 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DBtBpVz1IN/1R8FGk8EnUEzEb/l3o6SDZrFzkovYU/xM=3D;_b?=
 =?UTF-8?Q?=3Dbk+j2Yp2G5NgtuNu8azfl8mJpwOkQmf55uNizChk1X4+uCErVNXIg29SDu7S?=
 =?UTF-8?Q?hrYCauzo_j+7pW2gamkoevKYRl5W9lJGxkra7mt++apuq43zz4yo2/Lp8Aypta7?=
 =?UTF-8?Q?+O7SOZ6QnLVJY/_e+AbmMKKC23rp1Mdv3QdSH/2h11GgRQGZn7yRl+hbtXGdsLq?=
 =?UTF-8?Q?r7vmapmc32W56fJC7sFc_pINXHBl2K7Lhfs+xQ+3EyoS/o7iTQ68skeeY1zDkZi?=
 =?UTF-8?Q?f133i86IbhxSGGalatDvmWiL9+_gGK8bfYEiKXZ1nu5OUPbWNvion1hBYdRVrBS?=
 =?UTF-8?Q?8PqVf7AEpn+45KShXixjhoMNP/Sf1vZm_Cw=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j8a8hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 04:51:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44V1e7U7026568;
	Fri, 31 May 2024 04:51:49 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc509dknm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 04:51:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oINVlQ6gY5qUG1sS0zwRfXJcFf7/nOak5rweNaI5rZXz8MIKRSH85AlUYbLm2LV3XhN9lvDBjNxxfvDhXFOP0tI/Wl54+uAbGA1S/tOE2cntffhry79Ai+jZ/9hzZ8Wu7V8iJ9u0g94rRLF7JXiUvQm/Kgl/iwFV/j/8uKljhe/o8rc6aLA9vmeB0sFM5gMyMh0XulRa6xPOQVqs3MGU2XOBbY3JEbQLWjqBpD1Oboi3IFJ9323mLdT2s+Yz61CgTlPkFj/fTW02qvjZvcT3opAXWk2eOeLvxlCinvQJuAoNmGRFFvoctp8f7t1dyrFRnJm013VBP862ysaFVkPGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtBpVz1IN/1R8FGk8EnUEzEb/l3o6SDZrFzkovYU/xM=;
 b=DHX0S7jeVZhRYPJtFz4TLX5j2JR0CVkf7OyRfLWeFh8YZoQyRB88MWujAOmLp7cG8Mp89rNtqdy1vStZvAUdW/v2AOJV6hbB6ie8D15Q2slBBIy7RwAogA4/C1ihA+NgMzdJHi2dVFcMbUrUMBXQsnToMKz4Pt7MBb5ovnCrxvymG4A9RQaP+9IqUsNvDwmHfFo+JwtcU5/zfs7QQc/HKicqQY5o03xaXR3feOcHO37NxNM+wp4ibBObTe7tkoSAj1XequOQzwTMndKmjbi9K5IoYtfZTHCZzkw8AlEVNyJ3COb/QMo9K9WCFiKVxESl63jpZHprxGeXdPKJnWBSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtBpVz1IN/1R8FGk8EnUEzEb/l3o6SDZrFzkovYU/xM=;
 b=Ug6ViZ+kuctLqzqju9whPY8KBr5jBDuRVgcExKSki2+lj5QeJFYcTrLt7388q7IzEfJVQg0Qva7Z6JOhaSbfWNUXHgQD4+E10b1zrX+HAR0GPAUrSaLRVkgFrYdbBxEKL8eA4Fd8rPsmfrkk+JQbYpYZhgng0YvNoWUIJ/xXnT8=
Received: from DM4PR10MB6111.namprd10.prod.outlook.com (2603:10b6:8:bf::9) by
 CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.22; Fri, 31 May 2024 04:51:47 +0000
Received: from DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777]) by DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777%4]) with mapi id 15.20.7633.017; Fri, 31 May 2024
 04:51:47 +0000
Message-ID: <f6d81694-c321-470e-8b53-dcdf24d67c9b@oracle.com>
Date: Fri, 31 May 2024 10:21:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] RDMA/mlx5: Release CPU for other processes in
 mlx5_free_cmd_msg()
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240522033256.11960-1-anand.a.khoje@oracle.com>
 <20240522033256.11960-2-anand.a.khoje@oracle.com>
 <20240530171440.GE3884@unreal>
Content-Language: en-US
From: Anand Khoje <anand.a.khoje@oracle.com>
In-Reply-To: <20240530171440.GE3884@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To DM4PR10MB6111.namprd10.prod.outlook.com
 (2603:10b6:8:bf::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6111:EE_|CO1PR10MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9e1b07-a7bb-4fdc-8513-08dc812d6045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZkwvMzlKZXJzS0QvRXR3cHd3L205dmJUNXdRMncwTG1JRWxnUzJvZ1I3V3Iz?=
 =?utf-8?B?WjVXWDNqejlTL2N4ZVVvUlB3alBOT1E0UFdiZW9oTDNxemh6WFVFN3BQK0pL?=
 =?utf-8?B?TmF5OTM3YmVnVWpRWXVPd002VTB2V1d3aFhXVi9tTjJTSmxYdkVnUW9QODVj?=
 =?utf-8?B?MEVhSnBQbHNCWnVqL0Uwc1ZHeWZCTVcvRWluVjdjOXBNUHA4c05uSE5UWW1X?=
 =?utf-8?B?UXRtN0NDdzZiay9tN3FCR2NaYWx5VmVDMnN6dzl6SXJBL3ZkMitEOTVNMi9w?=
 =?utf-8?B?Yzh2S0VuQ0pqK0FOY1RWV2QrQjRCNTJqQS90NCtGQ1BoczIreEp4eGpFL0V3?=
 =?utf-8?B?WWY1NXVkSmVVNHZHRWp1QWxqN2pHR0trVTJoTHMxeW05WU1FODY2em0zWVl6?=
 =?utf-8?B?S2M1YmRwK3Mwd05CdWdMU0gwZWd0elFCaVRXeVVjb3pHbm1CQ2hSdVRzTVlw?=
 =?utf-8?B?OTVuaWd0enhvekNuMGRsRFhGQllpZ25EVTRNcmJHcWdiUStqd2RoektTa0Fl?=
 =?utf-8?B?NU04c3ZsVkRFdk5TMVVPeTByVVNCektLb1BrNHZ6TzBVVWFGdmIwRkJrM0g5?=
 =?utf-8?B?T3lCOG1tM05BMlcvQ2FFaEpvZ0ZWcXNRU0RpQUdVaVZtcGlrN3lOcVZSL0Q5?=
 =?utf-8?B?QzR5WUt4eHdZNEtGWXdZb1VFT29QY29jZERtSzR5YyttZ1lVcVpZS3dEKytX?=
 =?utf-8?B?RFhLV1NrU1dlcnRrbVJ4bC9LbXpJMUVRaU5qUHV3UDYwSUVqaU1KRE4xUnhG?=
 =?utf-8?B?SEZxRVF4cWxKUGR1NmF5c3M4YjVSMVR0dHlnamh1SVVSRmg3SEFhRnhiN2dK?=
 =?utf-8?B?TGQrMllxb05VZmxIMlNzYXYxWmJMTkl4K2ZWWTQ0VTIwbWgvbDNEa2g2Qkh2?=
 =?utf-8?B?VG4ySVBxOTZleDNIUmlwREcxVHp1MVN1T3p0bWxwWGE2VmIyKzdoNHo5TnRP?=
 =?utf-8?B?TWplTFYvMG1HdkcrcnJmblpBc09KTU9hL0JDQUdCOUQ3Wk1yY2RKY3NtOUpj?=
 =?utf-8?B?Tkp2dis2bnBWT1BWNlN6MGVtWVhWanhhdlo0SkhhY2tmRUtkaHJDTUlMV3Y0?=
 =?utf-8?B?ZmdmdDc4MHAvVDRxRXBXSFhPaWhlU1B3aVFjbExPamdwZEpCMHZNZGxyOWRl?=
 =?utf-8?B?Mm5mTGttSzlwUC9xaVh0eFRud0p5UERXaHIxYjZUZ1JaSXY0eVJnbEJFblZz?=
 =?utf-8?B?dXVycUhRaEtkWTFwRzlKWTNHZkdhaHZVdEs4WSsydXN3eDFXTkFXY052ZE1a?=
 =?utf-8?B?UjhMbnpNd3R3QVJYT0VPbDFRblIvSVRwdW95Y1JMVVgzNTFZQ20zV2YwcDRQ?=
 =?utf-8?B?eEJjTGhlNjg5QWZ2WXpOMjZzZHAwbjF2d1V5bnl3MVpwV1kyNUQ0dnVQT3Jp?=
 =?utf-8?B?Ulc0QzU5NDhuQnVJbFZEY0tCOWs1aGhWUEkzUlpwai8yOWNselUveG8xLzd1?=
 =?utf-8?B?QzBpN25KUGI5U1VrRkNXdEJRZmdXT3FWS2VpR0NubG5SdWRMVkJwOWI2QTJJ?=
 =?utf-8?B?aXNLSDRSQllQK1RldncwRHNzWDJ5enBSOS8vbGtZdXFUTi83aG1Cd1hjaEd6?=
 =?utf-8?B?cWdYOG1wdnFFeEZabkkrb3VmQ2p6ZXhnd3NML2c3UVpGZGN0aHgyL3JTSit0?=
 =?utf-8?B?SDNPbUlINFFydUJ0NStZWCtCNmJZSzVPVE9ReGlpMldLV1RxV25ZUmpVQ0FF?=
 =?utf-8?B?dWE4TW40aE4wNXQ5OGJpcHlKTjFFTWc1RkROeERQQ3pLSW9WZDhVOFN3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6111.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cjR4ZG1pQlcxN1UvSDhvdUdLVmRLV0k5NkIrZlRIVEpNMGViVS9GUndjK2ly?=
 =?utf-8?B?UmNGNCthYXRadmk0bGZocVQ2Wm5abGZ1Yy8yamlLN0RncGhuREtlZTRyZGdY?=
 =?utf-8?B?RE8rVG94MmN2dUFNTEtaRExJK2l5RnYvQ1VHZWRGTVBSYyszUFdEZ1VUN1M1?=
 =?utf-8?B?cmZrWGZmendMbnF2NmljcGFUWk1heS9PVWxrRnZtNnJJZUhkcDBYUFJ2ZjBn?=
 =?utf-8?B?U1VuMCtCYWloNTVFeFFUZ0VnTjhveHRhdkNSU2FTM0R0WTFlV0dnRnYvUk4z?=
 =?utf-8?B?alZWVWEzM0szRk1MVkhiS0h4NWNzRVc0L0NRQUMvanM3OHdhMG8xSi9adXV1?=
 =?utf-8?B?eXlIdDJYUVI2TGRMd0RnUDM2VmtSNFhHWDd6YU1iaWRjSW93ajJKaUI4UjBW?=
 =?utf-8?B?eXFNWk9iN1ZmekhZUDRUbElua2hNQjJ3cGdneTNWdHBCbEZieG5LR0hOQ05N?=
 =?utf-8?B?NEdMWi9helBjSDJSSHR3clJwM21xWHJXTkpJSTNUc245ejhWMkxWckVjQ0ZC?=
 =?utf-8?B?VHg5Y3BnK3Y4OGZLMzZkb2NmbXo1TjQ1M2dsK2dlSERrYzl2VHNicCtKQjcy?=
 =?utf-8?B?cEdhdmtiQVhPWkNzZklXTGZJWDdlSmMrZ0ZFYkJsSHNrTWFJNUpCRFNsVGJJ?=
 =?utf-8?B?SVV0UEFUK2xLdlExNjcrN1ZadE5zZHdlTGlYNjdSMUp6eVE3TzZCSlBKcW5R?=
 =?utf-8?B?NEQ0TFgvbk9hKytJeHBwYWlrais1MTI1UThhakFsZWdLbnhBcEY2M1EzaHpQ?=
 =?utf-8?B?N2ZoYXdyU3lFcktkNXFnZFlrS2d5UjBQWFFDMnFFeUErVE5DaW5UeldsYzRz?=
 =?utf-8?B?Q3VFYXNEZmdIeCtSNm91QXdLYnc4UWRNVGY0M21aNHVzUzdOYXp5aTdZaFoz?=
 =?utf-8?B?Nkc1UkN2OE4xWEFSajJGUTF2ODdjTFJqYlBrRXMyWWpyd2tpN2VZdEd0d0c4?=
 =?utf-8?B?a1BDaTZGQTJOdG50bUFiRkk3RkRvbEhRc0pyRW5IbE1Tc0tnbGdONUlHeHBM?=
 =?utf-8?B?ayt2UFljVEpicEFuazBicis0akhZck1LWkQrZnZQQjdUTkhRckl3eW5MSmlE?=
 =?utf-8?B?RGtYZG5EZ25Hd0t0QkloSzd2dmhYMS9GSm52MHBPT3FNUjNXUUN1bDk1Ukxy?=
 =?utf-8?B?SHNIeVVTdW9TTVZBM05RWUZ5L1BUMkJwa3cvUVJZeGwzUHN5UlF4b0lpRjBV?=
 =?utf-8?B?UlNpa3hMODRPUmNBeldJdVpMOGNJVFJlNUx0RGJiUjhpQURsSk9lcUpnZVND?=
 =?utf-8?B?UDNVK09BVkNYY3RyOHBZQ1M1YlY5ajJqMkRVR1R4NkMwdVRGVFpXK2Njd3hK?=
 =?utf-8?B?TzFFcEZTT3NqUWRFMFRrRW9XOHJZeS9JYnhQYUFUVStvS2NDZW9WZmtPNWtm?=
 =?utf-8?B?WnlHUWdHS0ZaS1hnOTlkN0hBMEJ6dHhJSzdUd3QyeTJvYjR3K0crY1lNcTRn?=
 =?utf-8?B?bG5NVStDS01JbjZCTzVvSHdWQnpER1ZhYjdoenV0bFZrUDlkcENzcE1lL09B?=
 =?utf-8?B?Zm5IYi9wUGZMcno0d2NrRURsaE4yOXd0YlZrZjRJWDQveEkvb0RyMXRlZURJ?=
 =?utf-8?B?TUZWYzduV1FyYmwzeWVJSC9iSTNtcnhReEcyZjhXcE9TTXNwTzZMaTMrOWcr?=
 =?utf-8?B?Wk13emlEdGpDRUM5ZlA1emJ5NkRyMVc5ZVBpMlE5TW53UHNBaTV4ZDZ4TTNM?=
 =?utf-8?B?OTk1M0tHS3pvOHgvU0tqeFQ0bENER0VVczN3d0JnUGFRamUvemp4ZFlDcDZv?=
 =?utf-8?B?T3VZdW9oYnZUWVNBTVhlSzhCRlFmUjR0aDhJUTR5dEs3Sjl0Zm5ZeTJuRTlT?=
 =?utf-8?B?clRxSmMyQWFsWVJLaktjM1hmWTYwLzNBTGgyanFLQmlsV2lzWHNGUyt0UTh0?=
 =?utf-8?B?cGhLeFVhYUFObUp0Q0J6bGVWZ0ZzWVdYVnZTS3ZBUEJnbS9HR1ZlTG5wTWxP?=
 =?utf-8?B?ZjRGUXNTK1VvbmxCelVoRHFoaW1rdlUrZzNFWUxLWHp1OVl3M1I3cWU0RWhZ?=
 =?utf-8?B?QnpEbVpYQlFwL0Y5UmZYbXliNjJ2ZFh5N3kySHNoRHFGOTNZKzVBbkVRWWwy?=
 =?utf-8?B?WHplZ3V0THF5cnJiZWFGc2M4bW9xYzI4a1RIZlRPb0FYNFlrSHIzZ09aV3ps?=
 =?utf-8?B?a1l0alZGVEhtUDJ1LzFleG1XWkdsaGIwYjdyWStsbzBkVGZjbmVKZXZ5ZEJv?=
 =?utf-8?B?WWxRVUhZK0hoVEs0WWtuditQMFBadUliK0lLNCt3T3VTYm1oZEJPbXphNUhp?=
 =?utf-8?B?RzVYaFcxNzQrbkdTekQyc1c5SUxBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	J23+T1DfQZzzj+F1Uof3KS80HPyfXAk0pxB+reHwr15mNpwfE7nFbffi6yVnOhidTteSChNIL9vlXKUGDb5I1YLDOr8RxcTKLWb+sNLA3wJO+6+cPCImq6mqoWPevmWDcCdvyi/cDSv+rT3jfY9l7/n0OZlNO+N7wJ6x9UMxlbqKK4pey1ZhaS66GuWWbnJwDlR1JsQ/SP5TA2YXkGlhZ7M2qvF1u6p4+R/NxgGKijWnKe1EWkO+Sp+BV7DzhwNw7Wu0eLz2zNXNVJWDICwUSCS87kE5s8FjwZETvhrm45lAwUhgnEuJNMl+UqFmxmRmddAPSrqo6uzPxZlBlerhIeZAtQB2cN1W7tidgZHQ4MKxDHEmII+T7tuKB2Vt9PVFT17st/JdJOYB69evYMsrryCT6nPytLNfE2U5fed1jD2RJgvLnpdtC8HnI5/27DkjEnKUydvRL2fb2mL7dpNoQLkiyk8yznwADaZ48dtg3BGE3hGG4mcdetEwXhXHJuPLufnji/vg/14WitpSZSwct8IPHqD+bCCohvxezCJ1zpo+sd14RJfsKUFgN58QQwhzdq9Q6iSRDaQ9npYhkKOfWiJZbPiuQupVkL4roer6ByE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9e1b07-a7bb-4fdc-8513-08dc812d6045
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6111.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 04:51:47.1519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oN+vlg1haJGA5Qd9xX4A/ZBfRp745/d1BeD250Az7Et0DzAoc4gtlTd3RfLWzRrK4J0s5BF7xI8UiT0fWodr4/sYVhDo00XHcvCv6Vn/vDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_02,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310035
X-Proofpoint-ORIG-GUID: zRG_wEvuBRZTIh19rR4SUxGwQXEgj55Q
X-Proofpoint-GUID: zRG_wEvuBRZTIh19rR4SUxGwQXEgj55Q


On 5/30/24 22:44, Leon Romanovsky wrote:
> On Wed, May 22, 2024 at 09:02:56AM +0530, Anand Khoje wrote:
>> In non FLR context, at times CX-5 requests release of ~8 million device pages.
>> This needs humongous number of cmd mailboxes, which to be released once
>> the pages are reclaimed. Release of humongous number of cmd mailboxes
>> consuming cpu time running into many secs, with non preemptable kernels
>> is leading to critical process starving on that cpu’s RQ. To alleviate
>> this, this patch relinquishes cpu periodically but conditionally.
>>
>> Orabug: 36275016
>>
>> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
>> index 9c21bce..9fbf25d 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
>> @@ -1336,16 +1336,23 @@ static struct mlx5_cmd_msg *mlx5_alloc_cmd_msg(struct mlx5_core_dev *dev,
>>   	return ERR_PTR(err);
>>   }
>>   
>> +#define RESCHED_MSEC 2
>>   static void mlx5_free_cmd_msg(struct mlx5_core_dev *dev,
>>   			      struct mlx5_cmd_msg *msg)
>>   {
>>   	struct mlx5_cmd_mailbox *head = msg->next;
>>   	struct mlx5_cmd_mailbox *next;
>> +	unsigned long start_time = jiffies;
>>   
>>   	while (head) {
>>   		next = head->next;
>>   		free_cmd_box(dev, head);
> Did you consider to make this function asynchronous and parallel?
>
> Thanks

Hi Leon,

Thanks for reviewing this patch.

Here, all page related methods 
give_pages/reclaim_pages/release_all_pages are executed in a worker 
thread through pages_work_handler().

Doesn't that mean it is already asynchronous?

When the worker thread, in this case it is processing reclaim_pages(), 
is taking a long time - it is starving other processes on the processor 
that it is running on. Oracle UEK being a non-preemptible kernel, these 
other processes that are getting starved do not get CPU until the worker 
relinquishes the CPU. This applies to even processes that are time 
critical and high priority. These processes when starved of CPU for a 
long time, trigger a kernel panic.

Hence, this patch implements a time based relinquish of CPU using 
cond_resched().

Shay Dori, had a suggestion to tune the time (which we have made 2 
msec), to reduce too frequent context switching and find a balance in 
processing of these mailbox objects. I am presently running some tests 
on the basis of this suggestion.

Thanks,

Anand

>>   		head = next;
>> +		if (time_after(jiffies, start_time + msecs_to_jiffies(RESCHED_MSEC))) {
>> +			mlx5_core_warn_rl(dev, "Spent more than %d msecs, yielding CPU\n", RESCHED_MSEC);
>> +			cond_resched();
>> +			start_time = jiffies;
>> +		}
>>   	}
>>   	kfree(msg);
>>   }
>> -- 
>> 1.8.3.1
>>
>>

