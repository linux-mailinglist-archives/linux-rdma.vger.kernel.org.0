Return-Path: <linux-rdma+bounces-5060-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A1998414C
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 10:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C62846E0
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 08:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0137015382E;
	Tue, 24 Sep 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hc9HOJdO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x7tAwUoX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0641527AC;
	Tue, 24 Sep 2024 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168384; cv=fail; b=KdmtSjDL9cZb/+RIH3dmKrPmAGMb/MIX5q+YZMmzIjHKgquczc1JPwYNOgtl6mW1HILMHQk6BCrEItaAygRN4KmFCflgb6zFC0y/KIuy2gkjmb9la5qaJCqY0YojbPsXcim9orzwc58HuiSgiaKlBltQpnMLFOzCBEB7vXu4VA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168384; c=relaxed/simple;
	bh=lzqnCYr9sEDuiIDsO7+lFUphfil8tDiDEznIVzYw0ww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JLQ7dcVLSrdtUo0JNYXWGbDftOx0hsa31cBB1K5xfpPlKEyPoHUbeSLfwRJMzFlBTmUBwHTaIqiPU0HsUDGWK6ewuP+He8N/aS3j3894YMaI2pDChPn50Zmegv8/Gmyk06fpH5Z2hJ097YIci/P6k7lGI6NexpziHhyGp6WET3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hc9HOJdO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x7tAwUoX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O1MWj5008684;
	Tue, 24 Sep 2024 08:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=lzqnCYr9sEDuiIDsO7+lFUphfil8tDiDEznIVzYw0
	ww=; b=Hc9HOJdOxyiMRcjo2KkgCJopxfaYbr52iiVSirb1Gsf8AkSQlDWK9IXA7
	QhBsWJ+/z400ISdAYGHcr+eYQEnGVy6rY4ylmx3Sg7bCEvLZq0fGYuSgibERH7eL
	ybdcA6bf0RF9M2sTPzQXz9apqeD0A08rg0OLBswCNdImDYH6t+4UUuZ4GeYI3uaB
	qVe5u76hpxWbFi7/Ft1TK1Uo3sukQG+FlyE0DyoJx/QsDgn68YpCC0HKa2etJMJu
	I+v+yvlCCWGC083geq/62hbu0P+tgaRPH45qeypxrumXw9ZVWSAw+76uP/uRcPvB
	kk2apBKIkE1oqnlULMDv7RDO0EsTA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp6ccdx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 08:59:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48O8JFlE029621;
	Tue, 24 Sep 2024 08:59:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk8wu2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 08:59:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSNJEuv9qH/paQFuz0Al2WQCLjYZXBKnmss2lBFsh8zSpAlCKohOSN0/qeXeo4QltN0B7gQxmCTLgn6o6ofDoljJzqjsSuMLwqf0cGRBo8CWS5qZKd3OfwD4z28Ox6+liwPLyt5nP8yqrcncXm4O/YMzWY6FofTnXtV6yBuYUgJBLJ3EKmljjesJEmQivACKG7cGniyix5wYpYeWrgL8NFL48yaDIXrv0tZhQkcXW9ikIfELSu8p27DzA+Xm7S8tC6F9aoCLhlzMOzYChxo39VoStGhDBZQbsUhBsBISvsPpoYI8zViuhS0ILGPJC/gB6Ah4zdpUKsqSd716HGpmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzqnCYr9sEDuiIDsO7+lFUphfil8tDiDEznIVzYw0ww=;
 b=RhwIGFYHz7x3qlQBbsmGV2f0e+/x5TmBpBQ73CyPhwGSQmXjEXLEsPzxUSO9BSIW/Yns8jUpaRGro+hgtCtE2g1f8L1UJJ+kF8DgaWbHGRMMbA/yaM0IYl8zd2af6Kx0zdNgdob1LEIPUKkYi/f+9NMnaWduYhdYo8CEvLWq9nbu4Jmv//g8j93wRf0wnlLKRleqDoPmSHd+XBFVVwDlBeOUjoNfkzGLMWbQ/FeAl8x2eZQy3GI6riavJdxb/YMpvHghbDob2j9L8RKc1v67gxeLvjr6Th9jpt4rYTg7Na7tKDj9x8mulDq+gZYY1DkyT5xmroSQf7DENI3xixDKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzqnCYr9sEDuiIDsO7+lFUphfil8tDiDEznIVzYw0ww=;
 b=x7tAwUoX6oiEMKSp4HpA0HCBeaSsdBSVL5iKMgnXWP9q/rBC5f4lqmVnxsoORU4sL5RpReVO4na7zh/0c+pHlRRaIIe+x3pRoM24hFtV35xNkFPwOrvLykp41P97/gOUccLMQ0P2BHeHQcRu1YRMDg4iCRxeWqRqqA7XXk2a9MY=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by BL3PR10MB6091.namprd10.prod.outlook.com (2603:10b6:208:3b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Tue, 24 Sep
 2024 08:59:16 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%4]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 08:59:16 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Allison
 Henderson <allison.henderson@oracle.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Thread-Topic: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Thread-Index: AQHbCp7A0vkWwunDUUiiivGPdE4MvbJgbooAgABEjgCABdbqgIAAIMSA
Date: Tue, 24 Sep 2024 08:59:16 +0000
Message-ID: <3B6A8BD9-76C0-464E-847D-615C93BBDCB9@oracle.com>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
 <Zu191hsvJmvBlJ4J@infradead.org> <ZvJj3butL8FYeXpi@infradead.org>
In-Reply-To: <ZvJj3butL8FYeXpi@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|BL3PR10MB6091:EE_
x-ms-office365-filtering-correlation-id: 71aec284-2609-4b92-0ada-08dcdc772b26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGNLZlJWaEx0Uk5UYU5pR3pQcXRqcWh2Q0ZHQjhqSGdEMTEzN25GSmhaNHFr?=
 =?utf-8?B?YUNsRytpcE1TVjZFU05EejB5RXBqNGFrS3BiYTU0NlVtT3BHRkVqQURCNFVr?=
 =?utf-8?B?b05kT09iY2lnb0llSGRzWW9sUTV3UXlNaCt6TkQyc3NkZC9vSGZhUEdJTlBu?=
 =?utf-8?B?NlVuQU1UbW9reUljOWdGMmV0YVFrUGg5WW5iOUFvYnJuejRzUFVZQ2owWlJm?=
 =?utf-8?B?dDRGUXUwMVBYS3dna0k5NXptR0U3UHY2VTlIV2d1MXc1b3lxakEzOXliazRW?=
 =?utf-8?B?cXNFNzVQOTA4aGJJQmRrSGtabld2MWp1V0ptY1IwWjlLREtJQkpKVGdVOE43?=
 =?utf-8?B?a01yNjlRTlNaTHRFSUY3R0lmRFJzek52UzRZQ0pzWU40WkZSUzJFTW4zQWo4?=
 =?utf-8?B?aSs3RW9uWWluUDRJNE01RkNvdHVYdGpoVHpVRytUVnJlRE9mODYvVkJOZ2NX?=
 =?utf-8?B?NHVreFl2WEdBNjBueWlHWnNnWnlzUzNTMCt6TWpLM2tqMG9ZenVSUVZYMDFi?=
 =?utf-8?B?MDZHMzc5MFNRRDZmdHFsYTJkMDhZQlRiM25iMzFrbmxUdHY1VGVDQjdxNFR2?=
 =?utf-8?B?bEs5TC9ObFlpTnNRaVQ1L1M3ZjE5Myt3Z0JVcTdtV2FadVg5NzFQOGpNNHJo?=
 =?utf-8?B?S3lBL3FyTmpHTHJDUzY0Tm1SY2VIQkZlTXZ2NjhXckp1VXV2MHltdFZpamdJ?=
 =?utf-8?B?K0swWjhMS3RoU01KYWppNWVYVTNhMEVWZzQxYStLMDNQQlZYY1JUMDRqTUsx?=
 =?utf-8?B?RGx3QWxMdzFyNjRjaHhOUUZHMFk0T3pWL3JWYW94RlhDbzRNbzl5QkJ3QldY?=
 =?utf-8?B?cjUxYXZEa1BjYXNoS2xWVW1EZm5GeC8yaDJjSDk4MEtGWTNieXdrTlVtcUpV?=
 =?utf-8?B?bStrekZyV2syUTJ6dzZ5VlNSZitpMFlPRzgrVFZkd0RCZGRJeE04TE5GNE5i?=
 =?utf-8?B?c0ticS9iK1gzdnpsU1RIWkhDWGRSUjBpOWdITkQxRHRDU25RaWxyajFrVDc1?=
 =?utf-8?B?MlE4bmNEbHU3STNpOHMzb2tvbjloVUJmV05UOHI0WnlFeGk4Wlh1ZUY1dkhZ?=
 =?utf-8?B?eGI3Ym4yUFQ3Si94L2F0R0xBWDF1cXFUdGlYNm9STVkvYm11Znp0VU1xSXp0?=
 =?utf-8?B?VXdVank3ZzJnTFQzb2EyTkRpbXE1a1ZtSWlOYWFRdkJQUWlFclZReW5qWGNN?=
 =?utf-8?B?U3c2akVPcWs3ckZ1WDZJMG5kb3dHZHVKTkx1REtMaUhRYjlkb2E5UFFZWVg3?=
 =?utf-8?B?bWQwSzN2KzI3clZoNis0VlI0WFhxcURVbkhNSHVkTUxQS1lJa1lOY2o1UC91?=
 =?utf-8?B?dkQyWlpCWTNpU0pPUjRRUWgxZ0xWSnd3aGRsM0RDOHRyVFhKekZlYWVFempJ?=
 =?utf-8?B?UXFXVVBnVlU5eVpqRS9FcVErM2pYS0oycW4xcXE3Z0hUTVNZZGxKTTgvZ1R0?=
 =?utf-8?B?ZTJ3ZHZQS0xwa1FBK2toQnB0MzJiS3FLNWkzNWttcUcxRXpGT3FMeUUxZGJh?=
 =?utf-8?B?ckVLeXNnZ29hbDNFK0pwamFCUVJseXlJRHhVVVlzOXVpc01jcDYyNUg0OWJl?=
 =?utf-8?B?WnFJNktiU0pYOTI3OUVSTUl1ejEwWXVZeHRzc3k3OHVYdGp4VFhwVThUMlNq?=
 =?utf-8?B?THBFK0QrLzNRb21jNXBiUkNLQkRtZnBVblgrbFpCYU9YUHVkUkpFYTYya2NK?=
 =?utf-8?B?TkhLOEhtcmlycVhZeWsxbDhzYkV2UUdjcmNXZldaTjRlSU4xSTJjUExSTUx2?=
 =?utf-8?B?bEdHMTdiVDRMdFRHdzY3dDlVanoyUVdaK1RqNkZIV0lZR0Q0TldZQVJ0ZUk3?=
 =?utf-8?B?TFBaSktHQnNWN0MxQlFhOFVFekR3eE8xS2pFQUJMaThIcHJHRlZwVEVDeDZD?=
 =?utf-8?B?Y25jeGRUU2hsUU5mR2MwVVpaVmFwMzNwVEpoV3JTR3NXR1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlZiaUwrRXJ6bmNXMzlYdGxYZWIrUWNMTVh2UmxETUJud1V5SkJyLzJkUzUy?=
 =?utf-8?B?Y243TEhnaVExbkdxempHSUNqRWhNUEU4WW9GNElJWmxtRHpWUGROUjlWR0xs?=
 =?utf-8?B?ZklVOVRXSEhFQTZMbXBUYUdyOVcxR1ZIMTl3YjhDL0l6RytBdDhQRWFDamJh?=
 =?utf-8?B?NVhSWEVrYUJKTmNpNWc4OWlScmhHOUQ3ZmFmVUNWczdYSUNERVJHb290SHJ3?=
 =?utf-8?B?ZXBsdkdvc1hYUXV0cnhqWlB1MHI2QnorMjNGN3VWVG1rNU90am9DNTJ2cVNy?=
 =?utf-8?B?bnJzeWpYSXJaUDBQaGI3eVUzQUxER3YrSWZJM1VTT3lGSEN1eG44SmtkU09T?=
 =?utf-8?B?dmRKSUg1a3QrdVFWbU1KTEFKSC9Ua1ZCR0tDM1JPb3JESjE0ZkxYNm5TaHZi?=
 =?utf-8?B?c2cyTTl4SHo2TmZKU2xIYk56K2lXbS9XMVNQSVUxNVZFYU9pWEQvKy9Vbmda?=
 =?utf-8?B?Vit5ZWdIV1pialFSYTE1eWV2VWRsWlRhaERQaFUwMGhicWZsQkhadEVkZGRx?=
 =?utf-8?B?SDR4YlFmaGtWL2x6OWRFSmovME9wMWZOaE9pTHU3eHlBY0s2TE95VExFaUN3?=
 =?utf-8?B?cW05YjJoWkVURElkd08xUkdKenJsWTNvNjh5ejljNXN1OE9LdFB1OTZqVzlZ?=
 =?utf-8?B?VFBzK25MWUxaNENTL2tpYXVOam9mdjZOcUpSbFNDTFhrVEF5eUU4TVFvUlFu?=
 =?utf-8?B?OGtZa1RCbGh5bkJtUTFxWVlvcjcvTkFwMlFLV25FWTNZL0RIN2gyY2NaSWJt?=
 =?utf-8?B?alc0dmVQNVNVUFJWZVRXRnBDZWlPYUxGN3c5eFhNK3BRaTkvdm1Gb01xQ1hU?=
 =?utf-8?B?ejlPTUlkUzQ3U00ra0NISEZjZVZ3QUsxd3Nkc0hSSmpkU1RZSlhrZU5wcVY5?=
 =?utf-8?B?VmtuMHV0ZnNSYWdTKzBsMlBaNGVQN0dLOW0ybk14bTg3Q2JrcVg1SnV3Y1VW?=
 =?utf-8?B?eW9jVVpHUnJ2UWNVa2pKNmZ5MFRsV0lXSEs2YWpQNS9NdGh5TUl5UC9wWGtG?=
 =?utf-8?B?WXZ3b3FIR0Iram1EdnNKek1FZXZqbXdJdDE5bklybGJIRjE2NXREZUdUa2hE?=
 =?utf-8?B?aWxnc1ZxcWJxcG01a0p5d1luR0lmc0JvcEsvRzhCcWhhYldZRmtZZkkzcnhH?=
 =?utf-8?B?SXFKUzFJOFJ0eHgvS1VaU1JsK2VMN3NGVndmSWpHWXpmT1pVWFJxZWdlUHBh?=
 =?utf-8?B?Wm9OSGxLY2xnekpsMWJmVUttaDZlUUM4YS9tbDhNdDIxb29MVFE1eU1QekJZ?=
 =?utf-8?B?Tk5EUWh2ZW0ybENrbU1nckdBV3Y5TW1pQ0Vwdm5oUUszS2MvYzZnQ0d5NVdI?=
 =?utf-8?B?azhaRVEvZEEzbnpqZ2hWR2h1RW1JZjA4VjZwZkJDclJyRjlBUjJWUXNqdlp2?=
 =?utf-8?B?RGxaYmdDWXUremQza3JQb3cvaEFSb2cvYjE2c3RuL3RLK1drd0pobGFkblVB?=
 =?utf-8?B?T29HOGxDNGJyUGlocmFMZTc1UVZSaU4zbzZIZjVncXhycDFrUFgxWE53d2F1?=
 =?utf-8?B?K3VPR0I5Nit6VG9Ra2x6cmZhajBHTnVWNVFzU0N5cU5BODhvdmlEb1pTSkVN?=
 =?utf-8?B?bG1KME81Mjl4VzVSa3lyQndhNlF3OWcrd25WbTVzclNFakpRckUrMERrNWhl?=
 =?utf-8?B?MUgyeTR1RjFUamU5dWh2TEEwcU5ZZW44TUtkS3VlZHdMeGhJdnltNThXT083?=
 =?utf-8?B?bFJzazdZTElFVlRRZEszSzVkZDFqa1hqU3NwUThEblNqYkhFZDBFb0E4L1Z2?=
 =?utf-8?B?R3MxdTM5ME9QbmZ5blIrbFI2dE12U2dnRFBxMmF0cGM2RU9uNkVXSzZCYnhv?=
 =?utf-8?B?Ulg1UmUrWDIyTDhJSnQ0cXlsQVhrTzdJUExWMVpJcGpjOGYrU1ZIcTFNUkds?=
 =?utf-8?B?OXVJY2xISkpWOEFSczRaRWQwSEJoZE10N2xrb1V1N3ZpZE9yRDFaSnlGcWJh?=
 =?utf-8?B?eDhTWnIzQVo4RmtlVVI3V05QRDlpa2pvTkF6Um41dzJzbjQ5N2JaN0dsbkc3?=
 =?utf-8?B?ZU52UnByTDk2KzFLcHllUFZiWWNxTlNtQTlzb21uTU4wUWNvQ1lpK0lhWDhj?=
 =?utf-8?B?cTR5T09sV0ZwcjZvek9RNUU1bU1MZ3lxMDhHYjJjeTFuM3NaaTAxQXJpM29D?=
 =?utf-8?B?eEVmNG04bnByclRGazdqZFRMU1BKSUlwNERybkNwWThYc3JyV2dBRnRjWjB0?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15F90E54D9714A4D8DFB9589F8AD637B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Xeg0ay68hhnNyldVvqyaETVQwetEQurQnULfAUhpjB22hjTep8Kt27T7RuQw5lBy0+u7PfFAcbDf2icMOMmzZdytGs488bY5XnhfZTzezsR6ZBw5p4THy/2XKpBKh4RTFXv6cTeH09TlmmfFHe7KqdKsd/XjI3zfxnjiwdgdlh7awc8W0/ZwpBzJMgUUXRYj8e3YWX/7iKQ/dSMi/g9KLNwMjWtNVpKPU9VeVK1YJEOmPejCc37uOoNRtQyFftjEHQ6PrhxYbxlMYEemGdjb8OMgU/6VUZjAgJoEu2LVwQZj7GXpR2EUjaOKBh3EGB3j8D0MrAJ4tzRNl2h5RPGDrEDPUnht3CrdMKdNy/aUnqBQCCHc4L/4K4nNxL/+PrV4beI/ojWVh7PedFqIVaj2LOO+bb5OneE7zgq54xOQl5FhR8FnbPLURruZDqKP8yq9PuEVL4WN0o/qYSTh90+F1bZO621/f35WQ8yB/2zuIWDhIWHU80E8vqqvQrSyYZwcp0RzxjmB0wvnrC819NHD5qtlzEQ3AQ68vqipQ1SGYV6bb44m+binAgOSLn/uONKew+izH/IMd+FHWtmJ8nAUkksQ+df3viLM48LU4emKlw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aec284-2609-4b92-0ada-08dcdc772b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 08:59:16.2511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahitdgR184aMAgfB1+J5sijQzjN//z2virX0lMZrSNZCezsz74hp7gIwYgDo2BdyuWOMmUMq+d6mhXf1TmXoEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=894
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240062
X-Proofpoint-GUID: G5J5EtFrKAzXMLRHN0oyfjlX64GATc0W
X-Proofpoint-ORIG-GUID: G5J5EtFrKAzXMLRHN0oyfjlX64GATc0W

DQoNCj4gT24gMjQgU2VwIDIwMjQsIGF0IDA5OjAxLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBTZXAgMjAsIDIwMjQgYXQgMDY6NTE6
MThBTSAtMDcwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBPbiBGcmksIFNlcCAyMCwg
MjAyNCBhdCAwOTo0NjowNkFNICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+Pj4+IEkgd291
bGQgbXVjaCBwcmVmZXIgaWYgeW91IGNvdWxkIG1vdmUgUkRTIG9mZiB0aGF0IGhvcnJpYmxlIEFQ
SSBmaW5hbGx5DQo+Pj4+IGluc3RlYWQgb2YgaW52ZXN0aW5nIG1vcmUgZWZmb3J0IGludG8gaXQg
YW5kIG1ha2luZyBpdCBtb3JlIGNvbXBsaWNhdGVkLg0KPj4+IA0KPj4+IGliX2FsbG9jX2NxKCkg
YW5kIGZhbWlseSBkb2VzIG5vdCBzdXBwb3J0IGFybWluZyB0aGUgQ1Egd2l0aCB0aGUgSUJfQ1Ff
U09MSUNJVEVEIGZsYWcsIHdoaWNoIFJEUyB1c2VzLg0KPj4gDQo+PiBUaGVuIHdvcmsgb24gc3Vw
cG9ydGluZyBpdC4gIFJEUyBhbmQgU01DIGFyZSB0aGUgb25seSB1c2Vycywgc28gb25lDQo+PiBv
ZiB0aGUgbWFpbnRhaW5lcnMgbmVlZHMgdG8gZHJpdmUgaXQuDQo+IA0KPiBJIHRvb2sgYSBxdWlj
ayBsb29rIGF0IHdoYXQgaXQgd291bGQgdGFrZSwgYW5kIGFkZGluZyBJQl9DUV9TT0xJQ0lURUQN
Cj4gc3VwcG9ydCB0byB0aGUgY3EgQVBJIGxvb2tzIHByZXR0eSB0cml2aWFsLCB5b3UnbGwganVz
dCBuZWVkIHRvIHBhc3MNCj4gaXQgdG8gaWJfY3FfcG9vbF9nZXQgYnkgYWRkaW5nIGEgbmV3IGFy
Z3VtZW50IGFuZCB0aGUgcGFzcyBpdA0KPiBkb3duIHRvIF9faWJfYWxsb2NfY3EuICBTbyB5ZXMs
IHBsZWFzZSBnZXQgc3RhcnRlZCBhdCBtb3ZpbmcgUkRTIG91dA0KPiBvZiB0aGUgc3RvbmUgYWdl
Lg0KDQpBZ3JlZS4gSSdsbCB3b3JrIG9uIHRoYXQuIEkgYW0gYWxzbyBpbmNsaW5lZCB0byBpbXBy
b3ZlIGl0IGJ5IGhhdmluZyBkZXNpZ25hdGVkIENQVXMgd2hlcmUgdGhlIHdvcmtlciB0aHJlYWRz
IHBvbGxpbmcgdGhlIENRcyBleGVjdXRlLCBhcyB0aGF0IG9mdGVuIGltcHJvdmVzIGNhY2hlIGhp
dCByYXRlcy4gQnV0IHRoYXQgd2lsbCBjb21lIGFzIGFub3RoZXIgY29tbWl0Lg0KDQoNClRoeHMs
IEjDpWtvbg0KDQo=

