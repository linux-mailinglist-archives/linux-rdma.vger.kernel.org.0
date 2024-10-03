Return-Path: <linux-rdma+bounces-5200-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1840C98F9B8
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 00:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF582834D3
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78821C9EBE;
	Thu,  3 Oct 2024 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eYmrx1r3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q1xfkIoL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B881C1AC7;
	Thu,  3 Oct 2024 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993787; cv=fail; b=VxIrY8SlnG0hkQKudADzyr7RTJg5Pf+OJd0mWEqb9/zJLZmQA1urOG6UbCoc3wxy937TONH80mcaq8PRSCFc9dg04lZ885IUUAGdbxVkkVzrsi7TuLsnt5WLFsRGBu31cK89p6F6vvCh3Zzeq+J/L+5Z4k2JAa9H1QClBR+VFRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993787; c=relaxed/simple;
	bh=cABuRBL9SGXpN8hSzXrMXalt0gC24sa+klw0scaqiZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oDDd6NQ4Epl11b6Eer6UV8jhw28E2QIAovVUL1M00mYc8Tf7Oy3FxSVXsZo7HhkcakSlML+VEXeqfM9jzmkjValRtatnTK/7aE1zlnnD7cFY4cu3SDvdCgOqUaZ0nij2hKtql9XY6Ho/AfZi01MDSiggGDnRU0MdQLBIQGuLyY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eYmrx1r3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q1xfkIoL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493JknQe016080;
	Thu, 3 Oct 2024 22:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=cABuRBL9SGXpN8hSzXrMXalt0gC24sa+klw0scaqi
	ZU=; b=eYmrx1r3wy0N2N2fx2xk+vGb/UCkMmdasNrE7/moca4RDkxpd3g8TAbuw
	RjLHOodQaXzWQTwvb8xmowF/UpMtA7wHspzcgHLUknRAWqi7VepdE41Yw7lmNCBk
	QOaCfElSXPSxM8S/vJdmyYGtUvDdIquVG0i+sNtmdWlokLk2XrE5wbMdkymStpJW
	NxVFwG8JJvTBUlF2gCZV85mQeSwacIYFzAMzo/bv5dOWk/Et5cBqKuN1p3KYZ7EL
	tcBK+fSQpsqyMJfxxo398i29b4qvghQffH2xCc0bZwvcGHnzZ/chnndpI6QGWf/u
	cpo2xHKglB+HVnP4gMmOGtq6k3BDA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204b0fwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 22:16:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493LakCL026236;
	Thu, 3 Oct 2024 22:16:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42205515e0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 22:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeBYcvacFElQ6xXBfn2rMYigUhCXb939Ih+3WfiTfN2TdsV4FEMBmvml7jc6mkUSE/QRCwqiJnZlko3u5j6Z9IiVeBJnIMOw0LGAVUap5BIJsnIYu0V7/4rotMSRx5rqgOAbRw+GezhAuUkC2P+rKCX+Ho22cWS4PW77SABx+eZRWTtm+lJ9T4tz0sS6uWQ7WQGYx9U9+uDTBSm2q6c8OG/oKt470cIGIhxhb34ZoKHUnd04AmZ5RBaH8DKQCZiRgIcTgDHoa9gdsns0lNhOj7u0xg1SFOZKsVaLr+l+TuA18Ij831HRJQJjN+kwtMxy9spwelGHe9QwG2XaaS9GFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cABuRBL9SGXpN8hSzXrMXalt0gC24sa+klw0scaqiZU=;
 b=r/CYZIOL+kVWMNXXjBlM+ZCq5WcSFnEIMsi8v2lfeCGwVfJCC81S/iN6Nq6R/y+1y2YWakYKl/CaIk2uYpz1ZoNMa6KtzJOQRqhZZcrLmeFogDiGWtJaM/jkqXPlbUJJNEkIC4TYTn0qxNKgjDhacAemHPszpGt9aE5dBIZ0/eiWqlASjPIp2z+DjLTH+1MVJ3RT3qYGKwEiKFnO9WJIsbwR1aaon3+m7zjhIQ7ewA2wv9xpYw/U5ADCtyejNLF2kNcTAkmOHvWS84PAegfH1ycqWmGa7/BkxqYlw0hbJ15h6Z8c9gcQmnp4iAbYhoKHYzb7rwd+epMLRhNg0KsUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cABuRBL9SGXpN8hSzXrMXalt0gC24sa+klw0scaqiZU=;
 b=Q1xfkIoLVHq25698z5nHF16QKPEsHizXLZETTlH6YjmbyyN5cKGiJC9hm9d76AHh4glldbGds2w3s6Y78VoXBfSzJ4xCiw4rTps0ylpsPQAFw2ZPmhOjGSHAQNNr7HuVccUAHlo2VtYAX1vUVqoA24Nkf8RlBxKwEvuxa8+G0BM=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SN7PR10MB6594.namprd10.prod.outlook.com (2603:10b6:806:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 22:16:10 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 22:16:10 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH] selftests: rds: Remove include.sh when make clean
Thread-Topic: [PATCH] selftests: rds: Remove include.sh when make clean
Thread-Index: AQHbEKhmx0MyLhlBiEuqOvlfZKXhqbJ1omGA
Date: Thu, 3 Oct 2024 22:16:10 +0000
Message-ID: <8a8b9f978a6d45341edeaf793a9518f800b42955.camel@oracle.com>
References: <20240927044923.12814-1-zhangjiao2@cmss.chinamobile.com>
In-Reply-To: <20240927044923.12814-1-zhangjiao2@cmss.chinamobile.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SN7PR10MB6594:EE_
x-ms-office365-filtering-correlation-id: edebe93e-e0f1-4965-ae46-08dce3f8fc19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VlpodlBFUXFwenZVc0F3eS8veVJkZTZmOU9RTTZkZGJmTW5IWU9MVlE4OFgw?=
 =?utf-8?B?UDhQSWQ5czV3TW0rNzhxQTF5TG1TenFRS0RPS0pKNk1oclpZTWZ0c2FRc2Zs?=
 =?utf-8?B?aUZFL2JPYVJCcEdOSWhDSEdCZ2lGUHJ6NWs2WCtXaHBBSFY0Z3ROL0QxSnpl?=
 =?utf-8?B?dE5na2tBbHhCUDcvbndmRVMrTHJoRHFGN3F6MlAyM0lBaDlvNG9NbWpac0d6?=
 =?utf-8?B?WUF0U05jdVJyQy9rL2xsQkQyRUtDVWZ3SVdQTHZ1cGhZdTZPWExzQ0ZDcDlM?=
 =?utf-8?B?OE5HSThKdWYrdkZMSit5a1lWQkNTLzlJRDhzOHV6RkNtd0FtQ1pqcE5iYVZJ?=
 =?utf-8?B?WVFrbklUbjYxaXA4b0VFTTJCdWVianF6RWVpazlRbEVFeXROdzB0M1NNemFs?=
 =?utf-8?B?YjJVbVY2L2xkV0tPSXJDaDBSQURVNm9IUEhueTlDMUx5TzdrUHVyNk9QeFIz?=
 =?utf-8?B?b2dDVTlMZzkzdTNRYmtQUzN4NFNCbG0xSGRzN1dCaTVEaU13UERHdkFIMW1M?=
 =?utf-8?B?R2RCWFpTM3NCQW9Da1NTd1g5UCtBeE84QjBUeHpXMTd6bDhkbVlSdTdYQmlE?=
 =?utf-8?B?WS9TNVcvMDNNVFNoY1ZtcHNZSTZkWDVrSFQ3bTh4V0VhVTlkQmNxSldlaUZw?=
 =?utf-8?B?dDNmYkVDZjRUaVNsUlBhV1J1MmR3M0pidGZWYVllaHBHQkhoanNGRVNucHBh?=
 =?utf-8?B?NWFGRk1MOTNLeUgxRk92VVM2STRDREZ2NEUrY1U2Z0xEYW5nN2g0V3lLczNO?=
 =?utf-8?B?Y0xGWmtWN1d4eEYwWHJaZ1VZcFgwV25Lb3VESXRYWFdmMXQ5NkFFRW1Wc3Nq?=
 =?utf-8?B?MFhVWHE2d01aZnZBUlV6bWxsNitkRTBOZDlKYVN2YXI4UmVFZ2FqR3NuWE5D?=
 =?utf-8?B?YmNkSnRwVVlDZzJuMmdSeEVpT3A3UVpieXYyaEZ5MzNrQnRxMCsvKzBQWHcx?=
 =?utf-8?B?WmNMR0hmcloxOVA4V3JvOCswd3R5SjVSdWxDanpnelI2a1N3V3hBQlNxMXJt?=
 =?utf-8?B?YU9pVmwyVjdlL2x4YlF4REpya2lEVkNYVXBqT3MzUWYycDdKOXRlNEVONXhK?=
 =?utf-8?B?ZHFFS3NqVEt6U2dhMXIwQ0tJZFhadnhBOHA3dWIzVGlPWU1ZVTJDek05c0Zq?=
 =?utf-8?B?OTJRa3dGT09hdTRuS051bUc0em9UVXpPVUFaV3Y0dnMyWHNycU94SlJxSkVa?=
 =?utf-8?B?cW50RXFtT0lwOGdZNm1HK3BRRU1BVDhtMnVac3d3Y0xjc2pyNllaMm84Rzlq?=
 =?utf-8?B?MGZBZXFSOHFacnpiVTJRdjhJdWdlQThPczR2cDVkN2hEcklGcFdRdHF3SHpV?=
 =?utf-8?B?OFovNklIa3ZPbmN2N3phck92SkRoY3lSYnVia3c1RVdYbXVtYkZmU0lRQnR3?=
 =?utf-8?B?WE14azZIWVh5MnZNSHlQM092UklUUkZVSzRiT2gwcHVsaWNrSG9QSUVLekVq?=
 =?utf-8?B?Nkllc29GTVNBMVpucnRtMzRjand5UHdDUUtlVG1yMzJmT0haUThlUG1IcnNw?=
 =?utf-8?B?MWw4Z0RtTElYcW93L01xSllZWjNya2VRTnZiT1RFNVg1ajR3T2V5ZUtBUk9V?=
 =?utf-8?B?Z21temg3TkdURTVqZHZ1ZEtyQ0QxZUkrMVdBL0tzeXZHZUw2dHhWaFZVbjhu?=
 =?utf-8?B?SmpSZnJQSUk3UCtnNHZaM1BkZDBKSCtPOElXQk42S3Ztd1hmRzRhcWNlQzVX?=
 =?utf-8?B?YklES0ZvWTlCOG1yWDlZcE54Zi9BczlrY2t6cmlVaXZZanFwU1NORlk1K2Ra?=
 =?utf-8?B?Mnd5T3p1SW0wSUpVTmd0L1Q3M3ByN1N0RitzeDdzaUNPSnVpZTlVazBXbXFH?=
 =?utf-8?B?QnFZY1FlL0s5RllTdXdWUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjI2bHh4NXNvUTNZaFRqc3pkMzRKSUpabWliRWYzOHdreHFvcmNrdTVJR2RG?=
 =?utf-8?B?cXpSMWsrbCtpN05PTXNNa1pCRFY5c2lLZVNNT2JRY0dhYnR6c2xHcGE5Qk1V?=
 =?utf-8?B?WVUyWStQZ1ZFUzBsTGVhYUwrZS9qZnBoSUk2Q1YwOWZNRjdpa3lKTFRJL3dq?=
 =?utf-8?B?RERuckJoN25LdGdxSHEzTFh2a0MvNGsreWd6YiswS2VrRkNXa3FlRTh1dE5Z?=
 =?utf-8?B?QldCWmdlM1VEVEw3NFJ4cEYwTDFZeTR5SUREUlNHZ0hZb0FjMTlIU2szOSs4?=
 =?utf-8?B?azhGMzdycThyQWxDTWV3bCtHc3VuQWZieXJ6ZWowUVZoNFI5MEF3anlVUk15?=
 =?utf-8?B?cDRyT21KcXNOTkp4d0xCbVc1bHJFVmVWNytZTytYYWJEMnlZcjdKcG9MT0xh?=
 =?utf-8?B?elh2NnBXM3FXcjdHOWVzSlNpRDlwQUFlaldLRzE2MllXV1N4c3pHL1RrVUV5?=
 =?utf-8?B?SkVEekRVRjdCQjViVEk0UDZ6a29uUE1iK3VZTDFXem1mRGdJS292amNmcGdu?=
 =?utf-8?B?bmtMSVRVb2hCNUhoQk94c3pzSFFveHovNXQwTFNGbUZFYVRzbFQ3b1V4RHc5?=
 =?utf-8?B?NEZ1aGJuV3FRVXA5T09OaVRVRXJ2QUNTOFljdzZJVlI2THZzR3dlK1pqSDFX?=
 =?utf-8?B?dnM3Q0hYR0Qza3FaQ2UyR1JTaW82M0paSmN6VGptczB5WE5DdmhPVzl5ZVR2?=
 =?utf-8?B?NDFBSmh1NU1iWlhoOUl5QjNtTERlMEk4bUQyZVExdmp1bmUrNi9XVUhTOVpl?=
 =?utf-8?B?amluUWtDQyszQTkxU1A2VjhzR0VwQlRqRCttM2VhMlRnRnNsc3huS1hZejJY?=
 =?utf-8?B?bk14dTlEMDVmSHBXTjkrNlMwRGVQWUg3R0d1UEMyRDMxTmZCQU5QdEdxWWdZ?=
 =?utf-8?B?K2FCVDJqcWpjZWw3NTc4d3A0ckphMUdGSVhhcmVYU0h1U0RXdk1tOVlHK1JP?=
 =?utf-8?B?QkRVWkUvSVNaZWViZTAwNGxidlRLbVE4MUtvM3dzTW1HQ1FZKzVjT3VrZVlG?=
 =?utf-8?B?VnljNXB4Qjg4WGVIVU1zdjZ2QU9RTVJ2d2xWbzNibWdNdGJUaFhVUFNnTVVq?=
 =?utf-8?B?MFFWa1VtNmFqMk5yUndVNUdMT2xXVllZeUlzbThMbzJvU0xNLy9LS09haGlF?=
 =?utf-8?B?eXRRVFJIU0I0cVZPTUo3ZzcrWGdzK1d5cjdUOU1JQzVSWnRGNm1DM09HQ3ZY?=
 =?utf-8?B?eHFqeEJSdE13amRiRjd4UU1EY3ptQ2ZRcTk3bExRUEZndU1GdGRpYUlFRHVr?=
 =?utf-8?B?dklFREtqU2M2MVVhaFppaG9oRzBPcW5GTWhWUUZIZEpYZkhDWFpId2lNL2ZE?=
 =?utf-8?B?S0hMb1M5RFJJaTZtd0wyY2ZvakQ3WVFBMkhYRFlNUStuTlZoVWFFSWdHK2Mr?=
 =?utf-8?B?MzFNSWpYeHR1ZFQvSDgyK0RBQUc5M0JBT2JaQWpsYTl6VFBEZHpkMGJFYm1l?=
 =?utf-8?B?ZEloWlFOM1dvV2hxc1BtL29LWVdZNmJ5MmliV3V5cngwK2tiajRxWUxjbTlQ?=
 =?utf-8?B?Vzl2WFlyQ2NyTk44dmtMWjIzbVZEOURlalJZYloxVnlZUWhOdE9SSW1ualhm?=
 =?utf-8?B?ZXVVZWlWZkZ6UzZNcG9GRHZEbkIrV0loQUVuVGVGN2Nud1dOZU9nd2crZjFw?=
 =?utf-8?B?Zkh3ZlpPYndvRldIbDZ6S0FodmduMTJLUmpPVjRBTWtQT0I3WnluWVBnS3pO?=
 =?utf-8?B?LzlOMXBiV3l1M2gxcEdXbGt0YmsrS0FveXZJS0xUMm1kOEtjZ0FRREsvYVBV?=
 =?utf-8?B?Vk45UXY5Q2l1UjRjWHhocVBYdmMwL0p0SlBOdXI1RThVV2VBQndOZkcxVDVM?=
 =?utf-8?B?bzd2cHNVeDl3NC9WUUVRQitYeXkwclBrdEJSdGxCdUFnMUtFOVY3dWI5b3pV?=
 =?utf-8?B?czhWa25OZUVVVDUxR3F3MUdTVVlJbEk3cTBLNkhWbnhGZEVNeUkwNlRvalNZ?=
 =?utf-8?B?d3ZEY2lwYzJhUVZuV1pyVEUrUWJJWUlVRnErMWFPTU5hZGRBQ082TlEvWkc4?=
 =?utf-8?B?TWxjcmJ4bTMyeDFsdFZoT2QxcGE0cFBKQVdTYWNLd0dxR25LS2tZaERIVFBv?=
 =?utf-8?B?RXpVMFdjM25FaUZkNTUxWVVDQVNUMm9aV2xlU2Vla0NiYkhvWUpnbGV6YU9R?=
 =?utf-8?B?VW9Od1pyVTBncmFSWHo1cjBVQzF2Q3hKZC9rYmkxeUk2TUgvZUthVnE0TC9P?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99C91C59D0EAAC458453CB62C97909FF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hC1bnCX9WTubqFBORA2Ihc7/6uoCocIo/FvQPqKI+D8bgwUafBYmoLnWXEnQ8W15nD3znlBVQNzCk3sbBzA3m6APXwh72d/skljtcIZwYm77KqMVZ1UuPdAVw29s4yEbvW5hUpx/MNoqxz7NNHcntayc7hKTWCCH39rHG/n+fqyX3lJ4cAQ3Xd9whlayZdaTm5vaMsoQEQJl6qDDEJFz2tB+l+VqqB0ot34Fj5XFw8EAfOIURvmDkVz/2/gbeOgv+M3F5YxOrwquHESv8nxp7j79+41BJYQqI/ozV2Iql21rE848LfYn0I6dZGufIDX2KVB1tfXUed45+HzJ9uNZzXX6uiiRb88K0ovsg9CGvBM9kanfkXh/ieqimv6WwkCgkF01NPvoYguNaN/lfepVVIszO1t4qpv4wcktXvGAM2jLCofaRSWWKJIQIxnFDLZpZAQSE4XqKNiZnWozEMpIU5dlp6CVXgpQwi6WlDuFbY+Z93M5AzdD4/F5twslNng1kFHkSH6MBqtQgkAzo3881nRRSIQHpPl60OX4MB9OwL2CYcMg38WRLW4Pek33Jf8A9vdi4i+eJKO9l6abspjKPzLxomx7/l65L1E7A6pJDJg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edebe93e-e0f1-4965-ae46-08dce3f8fc19
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 22:16:10.0369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Se3KcQe9VkPw0RHFeT8VMAgUu6k296UVm0lSDeqmu+ZO33oDjlf2fWvPy3kFCTNyG0LUZnXVc6N7rZkvMPyEBMDE1hD3Fy3JkIpVboY3Rhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_19,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410030158
X-Proofpoint-ORIG-GUID: s1z6fwBbvvRKtjp9VDuWjm2LNb4_G33l
X-Proofpoint-GUID: s1z6fwBbvvRKtjp9VDuWjm2LNb4_G33l

T24gRnJpLCAyMDI0LTA5LTI3IGF0IDEyOjQ5ICswODAwLCB6aGFuZ2ppYW8yIHdyb3RlOg0KPiBG
cm9tOiB6aGFuZyBqaWFvIDx6aGFuZ2ppYW8yQGNtc3MuY2hpbmFtb2JpbGUuY29tPg0KPiANCj4g
UmVtb3ZlIGluY2x1ZGUuc2ggd2hlbiBtYWtlIGNsZWFuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiB6
aGFuZyBqaWFvIDx6aGFuZ2ppYW8yQGNtc3MuY2hpbmFtb2JpbGUuY29tPg0KDQpIaSBaaGFuZywN
Cg0KVGhhbmtzIGZvciB0aGUgcGF0Y2gsIGJ1dCBpdCBsb29rcyBsaWtlIEphdmllciBzdWJtaXR0
ZWQgdGhlIHNhbWUgZml4DQphcm91bmQgdGhlIHNhbWUgdGltZS4gwqANCg0KaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXJkbWEvcGF0Y2gvMjAyNDA5MjQtc2VsZnRl
c3RzLWdpdGlnbm9yZS12MS0yLTk3NTVhYzg4MzM4OEBnbWFpbC5jb20vDQpJJ3ZlIGFscmVhZHkg
Z2l2ZW4gdGhlIHJ2YiB0aGUgb3RoZXIgdmVyc2lvbiwgYnV0IHRoYW5rIHlvdSBmb3INCmNhdGNo
aW5nIHRoaXMgYW55d2F5IQ0KDQpBbGxpc29uDQoNCj4gLS0tDQo+IMKgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvbmV0L3Jkcy9NYWtlZmlsZSB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9uZXQvcmRzL01ha2VmaWxlDQo+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvbmV0L3Jkcy9NYWtlZmlsZQ0KPiBpbmRleCBkYTk3MTRiYzdhYWQuLjBiNjk3NjY5ZWE1MSAx
MDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9NYWtlZmlsZQ0K
PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcmRzL01ha2VmaWxlDQo+IEBAIC03
LDYgKzcsNiBAQCBURVNUX1BST0dTIDo9IHJ1bi5zaCBcDQo+IMKgwqDCoMKgwqDCoMKgwqBpbmNs
dWRlLnNoIFwNCj4gwqDCoMKgwqDCoMKgwqDCoHRlc3QucHkNCj4gwqANCj4gLUVYVFJBX0NMRUFO
IDo9IC90bXAvcmRzX2xvZ3MNCj4gK0VYVFJBX0NMRUFOIDo9IC90bXAvcmRzX2xvZ3MgaW5jbHVk
ZS5zaA0KPiDCoA0KPiDCoGluY2x1ZGUgLi4vLi4vbGliLm1rDQoNCg==

