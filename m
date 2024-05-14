Return-Path: <linux-rdma+bounces-2480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD9B8C5AFC
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 20:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F1C1C21A4B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 18:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064FB180A85;
	Tue, 14 May 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GByo43t0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JlEeMnBm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5E180A6D;
	Tue, 14 May 2024 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710826; cv=fail; b=TNQSR4kKmkxv3C6xR6DeW2Hwh25B7Fek7kfC8HmtPUeaIXtZ5ZCms1xvXiY58Aa7Bj1AhdaxY+GSDi6wLoE1hN+DMfioQrXCdqTOYwEks7VOGlCf8lOZmlLtMBEtPDIWU0/40b+tX5tQ+81LkZsO9cuh309O44jOfa/Jywa0RjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710826; c=relaxed/simple;
	bh=LAUEXNK2SG6acpQg5chNOkpWgSXoc1gsPFRR19ldhiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EawnxB6og3G5PuLswPVh0dvRLzUB5sGgI1eUB3GNS28P0+0ZZZ22etELwG7ZQA+iJULrj9LTCtWYN1jchlW8m8CyabYdH0vswps/IpvdNGF2U17dwOaJkgXNiVE5k1IIM4m4h++BTdRcTSYpeme09RreK91PMeyxeXGRTht8JT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GByo43t0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JlEeMnBm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44ECgD9V010770;
	Tue, 14 May 2024 18:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LAUEXNK2SG6acpQg5chNOkpWgSXoc1gsPFRR19ldhiU=;
 b=GByo43t0p9bn8Ka6Gw6DVuzHlmL5VErT8/a1O9qoaDD9Xz2/wSoi3cfVXCKBbi6/nG/I
 TeWgMRf0h+N1goZxAEpaVsoigMmknVZ9vwd6NeQO9I/wtVhls5yMOiTXjtF75VnxtKAo
 7SpNT0xuUOA/OqhsvJke8pwkEbFL/WH83bZWJeLRzx2uVpKGUJTZlgjCkFLQMbwwLc7O
 J1fvSt0sXZgNrzHHWd482VeWon8IYgP3rVrgmoKjWLtRH2M9WCb9TUlFNVxFmYc+Wpbh
 KR6SWNx8SftGwvDcnpeaRiOOG9ss+GcksmeXMQsTEqp/vl7K5Fw+F/XC5ErYPaD0CujG jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4rt7fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 18:20:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44EH19m9038288;
	Tue, 14 May 2024 18:20:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24pwfa0n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 18:20:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7ONIkr/tL2XKDFPvK9uUdDu2iRj8wf+0NXiGRN8nrU/08PvSo3/IJn2rI/N0YprCDRv6Hnwdb5/nRslgou1pfJ52iE63WVJ9O5bLij7aFyaXk1JQ2BBIY5MwT4bVdGnTYt/lb7OsjaGcPky+thnUjIpITsPimtzH0EIMYApDw/FYgW6w10JoYwwm/TjU1NsaQgTqZyqUI9FMBMHNvGt/gOZrBQ9Mju7bYACl7IRtGwv1cr/70sKz0KZTeatswVf6I4wXu+P1ONgi84fDrG/bQf2xXDCx/+6tErpjQMdIAt8Zj3InqQXzMkPuYkWQ8QTpJk0yPIaUFRVZIVcfbyRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAUEXNK2SG6acpQg5chNOkpWgSXoc1gsPFRR19ldhiU=;
 b=Qnj+xbh4hmvpUR0lQlBx6jBhmclNyhOeIFLpfF4KSKLViN5bY2rH2O/GKuZJSH8gE26ZghlhlkBVGY3cRocWoOJGKJZk4OJHI8zDpkiS0oqFoCt0JudNbn8bqs/4EQaxC24AjxPV8AW0IQ7kfL3RwexE7FfILe4MAsyMGRfw1erkuKTSoR97Lx/Kn9UTgJp4etWekAILrU+VQLtE4RVwzcS4swhwRkfVUX2AbcOGaC1As2e4Tuzr8CQwi7lFIi9EanS4+C0YhP/xjEGBocoXucwdBcIC6cSVNUP0ZqNZtu3dh2UlswZXX2MENH4oVEYQaUqNISe0P+ANpEfWpQreFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAUEXNK2SG6acpQg5chNOkpWgSXoc1gsPFRR19ldhiU=;
 b=JlEeMnBmvv6H8Gt6fSeLMIALLxJIbXAVkK4KQ0hsbo2J3cuMJWjy8H/iVOxDRx+a8p+D4ONaBqpAJ5Za9j2WvOql9FoA1LRXRBggZEVl5lOvWzr/7z283LsFhjnH9h1CRNcODruSw746kufdjh0i7kBBUWIWDkGDVRzog22iefw=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 18:19:57 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 18:19:53 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: OFED mailing list <linux-rdma@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Leon Romanovsky
	<leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
        Tariq Toukan
	<tariqt@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan
	<jiangshanlai@gmail.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Mark Zhang
	<markzhang@nvidia.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Shiraz
 Saleem <shiraz.saleem@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH 0/6] rds: rdma: Add ability to force GFP_NOIO
Thread-Topic: [PATCH 0/6] rds: rdma: Add ability to force GFP_NOIO
Thread-Index: AQHapTSoAznTybBSbUOmaFlIKGsN0bGVyRcAgAFDEIA=
Date: Tue, 14 May 2024 18:19:53 +0000
Message-ID: <72BE64EC-3CB8-469C-85CB-F97671C0E867@oracle.com>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
 <ZkKcOogJpI0PU2l3@ziepe.ca>
In-Reply-To: <ZkKcOogJpI0PU2l3@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|DS7PR10MB6000:EE_
x-ms-office365-filtering-correlation-id: 386c7f23-53c2-4e41-ee2f-08dc74427360
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?clQrWCtkQk1aVVZWQ3NYNE53ZFFHalA3UTVHSVhTc1krZXZzRTZJamowWGhO?=
 =?utf-8?B?TThRZENWTE9VeUxmSElWMng3bUc4Vy9vd2NqaGM1SlBScFFqNlNEZ2kxS1Rl?=
 =?utf-8?B?NE9MY3BXUXcyQmNXbkJzbmZ0dXRpUmFSL1ltOTFtdm84cUw1UCs5YjZRbmM1?=
 =?utf-8?B?L3phNFp0disxT2tCb1dtYUdnRWUwL3ZsdE5RUGZrUThjRkdZdjY0RDRONFlL?=
 =?utf-8?B?MWZXUW01ZjZnT3lQMlF2eCtSVWx6U3dydlpqRjNad2NwWUFKNDZiTjIvSExm?=
 =?utf-8?B?TGx3ZVZxNG1nWmovT2JzdytuN0h3SjNOaHBjMmlpQVExOS9qcDdpVjFBb29i?=
 =?utf-8?B?YncweTlOR3QvMXJ2a0F1aDdYckRGZW1iYkUwVnl4dDBpY0JkM21icUpOS0wz?=
 =?utf-8?B?Y0QzOVFZMmN0UnM4NlUzVGNFZWZzMWlhV2xFVFhBclkrRExRME5LWmNsSjV4?=
 =?utf-8?B?dkduSHhxS1hIRTVDWTN1M2NNWkV6VmJBb2Fma0pybDFFV1J1T09RM1ZNYnhD?=
 =?utf-8?B?Ni8yMjVhSFVCczNuWUI2cnJJdklRU0pKR21WajIwaFBGWDcyamlJQ0Z2blI2?=
 =?utf-8?B?N3B4VDRzWDZHcFcvNGl2NFhTaGlhd0VFREg5Y3BjVTRCVVFmOG4yNjdMaXhy?=
 =?utf-8?B?dlZqWkZsdVJpc1pHdmI5NE56b3NKUEJxbThkS0ZvL0R4TG80a2preGY5aVQ5?=
 =?utf-8?B?TmNUYjRFSDFRK3VINFlWN2JwYXNmOUhGbWV4T1l6eE5FN0FlREdjbElaYTFK?=
 =?utf-8?B?dFRCdVhVdC9IQUFhaHNUQXdUYUMycFlQZS83OHAyNlFjVWNzVUE2b09makJM?=
 =?utf-8?B?Ym1zeEgyRzdKc2plK3FaOEdFMkJSZE90RTE3cC94a1kvcVNaZ2o5VzRVeXgw?=
 =?utf-8?B?cGhpTGE2NmxKekJRaDdjSW9UdGZmZXZvSWlXNFJYbVFSNmZYOS8vakliN1Ny?=
 =?utf-8?B?OXNKbEIvbGZpam1MMGpsUG1GTnNrNGZFNzN1SDIrK09aKzVYOEM4QUxucWla?=
 =?utf-8?B?UXpxMUZOdzdqZXVwRHVaUHR0L1FjajRUb1grdkU0QUdrbHhqL2dZMnhMOWVv?=
 =?utf-8?B?SjJqMXFoVVQxclpvV3VsS3hUN0ozNTJRclhzcUkyTGw1L01xNlYzZm1yNGto?=
 =?utf-8?B?ellJMVBBNFp2VHdrQ0xvTTBSdnZVeGpYbkZaOEFMcHVsMFZmeUdHd215NGpv?=
 =?utf-8?B?eDNLT0ZtREdEc0pVTldtYTByYW5RODUrOXJZS2MwdFMxN0M1dFkwZTNTVDJy?=
 =?utf-8?B?OENVcjlvQlhyYS9IbDhBK0JhcGUxbVJYbDhyaUFROEVIbjU5Qk1lT1lyOFI0?=
 =?utf-8?B?VGdEU0l6WmdnNDhWQzQ5TWNPa3poaGI2aEt2ZklKZDVud1lJM3NLU25Bb2hx?=
 =?utf-8?B?eFYxMmRIMTdMZXozVnNnSFZmRExSRWZ4UWsrV0VUbUFNTW5oVWJydmsyVnh1?=
 =?utf-8?B?OFFGQmx0bnFVeFhaWEpsem1jZEhTM3RHYVdsa1ovZGh6T053dUNGWmUzWHJN?=
 =?utf-8?B?cjF3YTBRbkJPMzNXeS9vVGE4YnZlNkU4ekQ2QnhKV1Z6R0FkdzNHaGVkNXNm?=
 =?utf-8?B?eW14RUp5Ym1KU1E4Um5ncmJYVnlheUkwNFZXUDBjc3BtcFROS25hSS85b2lU?=
 =?utf-8?B?NW1kTWJSTjdDT2d0MFoxQmtrRjhBVmRvU1gwTmhOUFRndEo1Z25OUm9xSHFX?=
 =?utf-8?B?eTl4dUFsamhISGp5Y2tLaTA2UlFvWUU3bW5yTTh6Mjd0UFhWeWVheG5PdC8y?=
 =?utf-8?B?NGZ4SmxTK3pwM3FTQklqaVFNaTVCc2RmcktZbituUiszMHI4Um9MWDZxOVNa?=
 =?utf-8?B?WGpFbUUyZmxzUFB2WkVyZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZWU0clQrZzVEKzJ1VlFjV2wrTDBBUUdNOU8vWUE5YTg1RDE0ODI1bWdCVjRx?=
 =?utf-8?B?QjBWNmZzbXBEc3R6SGdIRVNoRG5ZbEYwdDAwanRSbjZSWUxUeTV3TVN1WlhL?=
 =?utf-8?B?MnB1eHRSU1lST0srU3pGZDVzeW9tNk9UQk1DYk1lelEyT3QySFBpRktYV0xu?=
 =?utf-8?B?NTVRa1Jlak5QbUdsY1ZQc0ZaZ21taHdGbnJKenBvMEpGZmNuRmZzUm5ya0Vo?=
 =?utf-8?B?Y3BqWUc3OWM1OWtzMGJzZDJ0VXBaekdxZ012aDJwZFJxSU9sZjVsNUhncWx5?=
 =?utf-8?B?ekNlVDBiNks2a3RtaHB0ZXZjVFp4N1RueXFBd3NYdVlkZmdhZ1V0WDk3VVkv?=
 =?utf-8?B?emVsOFF2eDAvSEpCdHNhbUhteFdGc3VFbW5uYmlUaCtKZkt4blR4NGlEQVJm?=
 =?utf-8?B?TmVzNEpvS2JkaFBzcjRUSzFWZGJCYXkzT24yNThiOXhUcitxVEFEY2hZL3lJ?=
 =?utf-8?B?TmJ2blFkV3M5RXlCd2c0TlBCYXFKV091cDk0RDFTTUJhS25yZ2dKVnUyOXpL?=
 =?utf-8?B?aEgwRFJuWHJLR2xlKzIzajV1ajM4akNYT28xTHQrRVM0NWtKNDFNZWJhZ2tD?=
 =?utf-8?B?aFR1eVVrU0E3VjhpTkpvSWNQMThpSjVrTjZNK0UzV3ZSZzJkbUZvQSs2a0pp?=
 =?utf-8?B?bkxhWHNhaWpRcTBFN3VicktqdGFnbzlsNzBUckZNYm4vOWQyeXdzM2ZhVlR6?=
 =?utf-8?B?SCtMVm1KS2FsMkltK0NnTXNUdng2ek93RHcvOEhQQmZyOVVLd0M2ZlYvSjRC?=
 =?utf-8?B?cWZiWm9KcUMrTVFzRG9LZzVBcFRvTlB5Tjg0Q2JPTTBUWlpNVkJDUCsrWWI3?=
 =?utf-8?B?NXpuM0l0NjlZOFhUeFpyZ043T0d2alFFczdXYVNzdG9wMzhDQXhudU1nUzZ1?=
 =?utf-8?B?UHlYbVg2OUJtbTBTMDV2UWxhMTR5TEhFKzdWN3RacWtEaTRHbzFHVUJ4dlJ0?=
 =?utf-8?B?bUsxWDkvK3lSTUN5c0ZWakFJbk13SXFOa3RFcFVkUWlObURPUTB5ZEtnbzhm?=
 =?utf-8?B?WDY4d1lJMUNoMFBPNEVHaHZXQTkrcEdBZlhET0ptQ0d0UXFaYmFBSkFqNGV0?=
 =?utf-8?B?WnBORE5FZlkzVFBoTXpieWR1cmUxMlpTMi9VOGpRb0N6S3gzdnZMY0dGZ3JR?=
 =?utf-8?B?Umt0N29UdEVBZUo5RVFkeHIxWE03TThxUkpUcnRucVFvRFpjTWE5WlRFRHpH?=
 =?utf-8?B?eWUzVitQbHpEc29sRitrNVJiSGl5VHFtSlRmQmlzSE5zTU9nb2MzYkNjbU9M?=
 =?utf-8?B?UkVuMEp3NFpJZnZPeFBQQXFGektHWHlNTWM3THZxTEVwRmpNcy9aOUd2bWhQ?=
 =?utf-8?B?THlhRC93QjBhMittNm05N2tCWFdLSEhCT2FmTGhtc0ZmWEFCWUUvLzh2M3dR?=
 =?utf-8?B?WThhMHNBVDdvQ0lPQ3hTUGJpZDllZm5MWEVwQTI1VG9tR3JRYkhwTVdFR0Vz?=
 =?utf-8?B?cng3YUVMU3pCQWEwL3A5Q2lSMHRzRTBZRzhaTDZ4dG83dzJ0TFlWajBncHY0?=
 =?utf-8?B?S0h1Z0FIZ2JueVBsL1RTaFdqZFpnd2tzcnpIeFF2cXFVdFNCVkhnSGYvcEs4?=
 =?utf-8?B?QWlZZ2F0SmpteDVDaVkzZWNocUxVQ1Bkd1pScFJiVUQxU2JPa2k2M2tNRUlG?=
 =?utf-8?B?ZXRVSmdwbmxMVndRellmcmpuVzVtSzJRMjhPamRYMnpjN2FkZXZVWm9kUU9R?=
 =?utf-8?B?bzhpbTg1Rk5DOEVDbU9EYVBsMzNBVi93K1I4U0REczRBUnZaR05ZaW9vZlpl?=
 =?utf-8?B?SzYzNmdTcEZRVklmaHhCQkV3TFBwNDRWMklON01sUHZrU2loTjVnajYydkNh?=
 =?utf-8?B?SmlzV0U2T2NXOW1idkpjaFRTWVE0VDAydGNTcnpLV095TlBRQ2ZZZHBhbDdo?=
 =?utf-8?B?SG1ONkUzcE8rNUFOMXk5WVc0Wk5DQnFJWEhUWUJDS3pPRnRYc0FJUi9NbXd0?=
 =?utf-8?B?Ykd3SGx3am5NYlFZVjR2cDdRMGh3TFJQbzVwbTg3NGZPc2JRNTRsR1pKR00y?=
 =?utf-8?B?ZEd5ZkFsRUovSXJpVW5wMzBhd1pObGZKUTdXdjlPYkhZOHRrTnlXVVFSdFZl?=
 =?utf-8?B?M25idHBkT2FnRVNyZktMbHVYYXlhSVB2QnR6ZVhIMGVxOVVvWllZcCtSL2Rk?=
 =?utf-8?B?QTgyT0Z6K2tSNm94dVVMcW1kZ0NPZm9jbTlYRmN4UWFFNlk2T2JneVliRTR1?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <886A0A63AEAD4744BE8350ED1668B064@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MaSo8u6JMF6RzS6xwGiId5TRgkv9lP1a+AIVZgpSE+7UOIoJsI+tlqj0SQy/GSP4oq0uIakaxJt9uZpYzJ0Ty51mnCdnJx0n1oPtH/r7GCq6+pJxoEc/EarQHwynF5EXnA4W0rdPb/1CFuGdqW7PFoB8SenvNle0zKcXuX6RvFwOlUOjNpuUSeR2enMFaRZZUchCUSZdQ2kWzRZRmdvEZAeboOoD2nG55eWvHVRh5BYQ2v8DwtOO6ATNR6/OacXtTh3w1UcVVI2k3LCECQRHgNcvx0OjYhKcc1Plzat5awlJ4otyFkfRIxkVGcUR/e36UIpJJ/g6Vq/GGzf9Kf1wv6Z0Y1dZGBKU7e8y4I0M0sE32+BANNLYiOJKDwqSPj1W7w2CVE+JstH236KJU7nuKTJlyOpJfYlFahW7ukJpddePjouMnKsPT+4nOyQ1nqwm86oV5bHjEvB14MgI0XIgqmTtS0sfJQzlJsjrZ7uCpDlzvMuN3ufq6iLMXrmHCfjfi8FOH/wMGH2hVLfeob+N/67clO02Bqkz5tbtkYYlGi6oR8+UZEkE9KyveDQ7gSLAFE+rbBLJxzHxPThQboPLEHqrsVE3l+nhnjQC20PpgRA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386c7f23-53c2-4e41-ee2f-08dc74427360
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 18:19:53.1679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCeeBse9qfq6yyPuwRIQge/OftEO0MNbGroVX8gQd8PCzKNmwEWMVUSB4tmyF2l4FQJSmVTMnNndj35CV15m5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_10,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405140130
X-Proofpoint-GUID: hob5dq5wVX6llG4M73k7vcTJSAFEoBr2
X-Proofpoint-ORIG-GUID: hob5dq5wVX6llG4M73k7vcTJSAFEoBr2

SGkgSmFzb24sDQoNCg0KPiBPbiAxNCBNYXkgMjAyNCwgYXQgMDE6MDMsIEphc29uIEd1bnRob3Jw
ZSA8amdnQHppZXBlLmNhPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgTWF5IDEzLCAyMDI0IGF0IDAy
OjUzOjQwUE0gKzAyMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IFRoaXMgc2VyaWVzIGVuYWJs
ZXMgUkRTIGFuZCB0aGUgUkRNQSBzdGFjayB0byBiZSB1c2VkIGFzIGEgYmxvY2sgSS9PDQo+PiBk
ZXZpY2UuIFRoaXMgdG8gc3VwcG9ydCBhIGZpbGVzeXN0ZW0gb24gdG9wIG9mIGEgcmF3IGJsb2Nr
IGRldmljZQ0KPj4gd2hpY2ggdXNlcyBSRFMgYW5kIHRoZSBSRE1BIHN0YWNrIGFzIHRoZSBuZXR3
b3JrIHRyYW5zcG9ydCBsYXllci4NCj4+IA0KPj4gVW5kZXIgaW50ZW5zZSBtZW1vcnkgcHJlc3N1
cmUsIHdlIGdldCBtZW1vcnkgcmVjbGFpbXMuIEFzc3VtZSB0aGUNCj4+IGZpbGVzeXN0ZW0gcmVj
bGFpbXMgbWVtb3J5LCBnb2VzIHRvIHRoZSByYXcgYmxvY2sgZGV2aWNlLCB3aGljaCBjYWxscw0K
Pj4gaW50byBSRFMsIHdoaWNoIGNhbGxzIHRoZSBSRE1BIHN0YWNrLiBOb3csIGlmIHJlZ3VsYXIg
R0ZQX0tFUk5FTA0KPj4gYWxsb2NhdGlvbnMgaW4gUkRTIG9yIHRoZSBSRE1BIHN0YWNrIHJlcXVp
cmUgcmVjbGFpbXMgdG8gYmUgZnVsZmlsbGVkLA0KPj4gd2UgZW5kIHVwIGluIGEgY2lyY3VsYXIg
ZGVwZW5kZW5jeS4NCj4+IA0KPj4gV2UgYnJlYWsgdGhpcyBjaXJjdWxhciBkZXBlbmRlbmN5IGJ5
Og0KPj4gDQo+PiAxLiBGb3JjZSBhbGwgYWxsb2NhdGlvbnMgaW4gUkRTIGFuZCB0aGUgcmVsZXZh
bnQgUkRNQSBzdGFjayB0byB1c2UNCj4+ICAgR0ZQX05PSU8sIGJ5IG1lYW5zIG9mIGEgcGFyZW50
aGV0aWMgdXNlIG9mDQo+PiAgIG1lbWFsbG9jX25vaW9fe3NhdmUscmVzdG9yZX0gb24gYWxsIHJl
bGV2YW50IGVudHJ5IHBvaW50cy4NCj4gDQo+IEkgZGlkbid0IHNlZSBhbiBvYnZpb3VzIGV4cGxh
bmF0aW9uIHdoeSBlYWNoIG9mIHRoZXNlIGNoYW5nZXMgd2FzDQo+IG5lY2Vzc2FyeS4gSSBleHBl
Y3RlZCB0aGlzOg0KPiANCj4+IDIuIE1ha2Ugc3VyZSB3b3JrLXF1ZXVlcyBpbmhlcml0cyBjdXJy
ZW50LT5mbGFncw0KPj4gICB3cnQuIFBGX01FTUFMTE9DX3tOT0lPLE5PRlN9LCBzdWNoIHRoYXQg
d29yayBleGVjdXRlZCBvbiB0aGUNCj4+ICAgd29yay1xdWV1ZSBpbmhlcml0cyB0aGUgc2FtZSBm
bGFnKHMpLg0KDQpXaGVuIHRoZSBtb2R1bGVzIGluaXRpYWxpemUsIGl0IGRvZXMgbm90IGhlbHAg
dG8gaGF2ZSAyLiwgdW5sZXNzIFBGX01FTUFMTE9DX05PSU8gaXMgc2V0IGluIGN1cnJlbnQtPmZs
YWdzLiBUaGF0IGlzIG1vc3QgcHJvYmFibHkgbm90IHNldCwgZS5nLiBjb25zaWRlcmluZyBtb2Rw
cm9iZS4gVGhhdCBpcyB3aHkgd2UgaGF2ZSB0aGVzZSBzdGVwcyBpbiBhbGwgdGhlIGZpdmUgbW9k
dWxlcy4gRHVyaW5nIG1vZHVsZSBpbml0aWFsaXphdGlvbiwgd29yayBxdWV1ZXMgYXJlIGFsbG9j
YXRlZCBpbiBhbGwgbWVudGlvbmVkIG1vZHVsZXMuIFRoZXJlZm9yZSwgdGhlIG1vZHVsZSBpbml0
aWFsaXphdGlvbiBmdW5jdGlvbnMgbmVlZCB0aGUgcGFyYW50aGV0aWMgdXNlIG9mIG1lbWFsbG9j
X25vaW9fe3NhdmUscmVzdG9yZX0uDQoNCj4gVG8gYnJvYWRseSBjYXB0dXJlIGV2ZXJ5dGhpbmcg
YW5kIHVuZGVyc3Rvb2QgdGhpcyB3YXMgdGhlIGdlbmVyYWwgcGxhbg0KPiBmcm9tIHRoZSBNTSBz
aWRlIGluc3RlYWQgb2YgZGlyZWN0IGFubm90YXRpb24/DQo+IA0KPiBTbywgY2FuIHlvdSBleHBs
YWluIGluIGVhY2ggY2FzZSB3aHkgaXQgbmVlZHMgYW4gZXhwbGljaXQgY2hhbmdlPw0KDQpJIGhv
cGUgbXkgY29tbWVudCBhYm92ZSBleHBsYWlucyB0aGlzLg0KDQo+IEFuZCBmdXJ0aGVyLCBpcyB0
aGVyZSBhbnkgdmFsaWRhdGlvbiBvZiB0aGlzPyBUaGVyZSBpcyBzb21lIGxvY2tkZXANCj4gdHJh
Y2tpbmcgb2YgcmVjbGFpbSwgSSBmZWVsIGxpa2UgaXQgc2hvdWxkIGJlIG1vcmUgcm9idXN0bHkg
aG9va2VkIHVwDQo+IGluIFJETUEgaWYgd2UgZXhwZWN0IHRoaXMgdG8gcmVhbGx5IHdvcmsuLg0K
DQpPcmFjbGUgaXMgYWJvdXQgdG8gbGF1bmNoIGEgcHJvZHVjdCB1c2luZyB0aGlzIHNlcmllcywg
c28gdGhlIHRlY2huaXF1ZXMgdXNlZCBoYXZlIGJlZW4gdGhvcm91Z2hseSB2YWxpZGF0ZWQsIGFs
bHRob3VnaCBvbiBhbiBvbGRlciBrZXJuZWwgdmVyc2lvbi4NCg0KDQpUaHhzLCBIw6Vrb24NCg0K

