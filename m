Return-Path: <linux-rdma+bounces-13255-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A96B52062
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 20:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B0A1BC2B2C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7208F329F19;
	Wed, 10 Sep 2025 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qvxJZCGa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YMVF4Rx1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC88253B56;
	Wed, 10 Sep 2025 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530060; cv=fail; b=YT+HETXjV++Xqxf6zMgKX0kLjAyGUa/CDhdr1d0R2SWhMY0azpEjWvepguZCcLpkUIZYlXuRtBzOd8FboQNVwO0KX7PDXoT8gl04ckNRyMCthyk/wLyddiwLtH/4ildYK23BUTBKBM7DctIejwu/bwYyHBKMwbIAhLsNfzibFhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530060; c=relaxed/simple;
	bh=G3CgOiGOojHaRFIrK38zG0KXZYLfX2/w4Anbhxrb6vY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d0UEOONaQXkL93VuWyZq/aqdV8Avax9gvdWINy+Z7/YB4EnCr7ax+0ADLgYGEW/MmJFXHVlBCvhDV2R8UzrvpajLTvVnBhvzCFSF46gotgDIYB+ECjIwB3lGqXf6v5MFUBmbqcV74kwYCrB6ra1iFxkPnHZ1mQtXN3ryps6dlio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qvxJZCGa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YMVF4Rx1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfi47005177;
	Wed, 10 Sep 2025 18:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=G3CgOiGOojHaRFIrK38zG0KXZYLfX2/w4Anbhxrb6vY=; b=
	qvxJZCGaBXvjhjmEqN/Ro6x3huJ86VRwEIr+xPhdt/AWmo9j4r9HE9VA5skO/fOa
	y75S0EMFTVLru/+GWkDzzjLuqsK+DciX5Ye09aOHprAlhDgK26CpqMZZ4UaY9PZD
	6T8ZmtTLQ9xn9jHuMuE6eObVpXdpzl2iV4+xdXj7hEvRP+CIkH/dTkfg1PO62ZBa
	GU8XCWUmvWnrXoT4wWzQRNT2mNa3t5zLVSnPtBp4jGpjxIP5uCH01qM8JmCqnoSK
	zqKV2NgzVvAmmzokOZRZQSVvVwnXjbxO7TrRfBaeEvcN0rR4SZpChGRr/dpr2hpo
	8Ns971okwNfj6PqC6bKzDw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226svtux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 18:47:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AILoxH026140;
	Wed, 10 Sep 2025 18:47:29 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdbe76e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 18:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHuCfL1lpBJC3iYfOkIRjtCPwXD+UTzKpMjbdy+h5vm16XxeIYnGgIMsEd5qcDDPwfSQK2SyNa0AIXQasrinzPFezwJd6xzb4KO80cv6qX6PDWbqjkI0h92yB2UG8t+FhGQjbW2P0ca7+f8bZRp3IX2Q3gkMkAveNtpcufbVdE7jhKgxO/fx8Z5lj9cBTVfeqlP2T3ezbQTsowv2ivDhHw3XrBTHBfraFNs94S4NG73KMRpoJk9Knk3/SM/XQDX0KePRSnI4EbgmX4zQSbi285trX0ANCGOg9arm++H3RTj9bwD8OLT+YaEV0BabXquIi1ePG8OuREMF6GoKL7tN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3CgOiGOojHaRFIrK38zG0KXZYLfX2/w4Anbhxrb6vY=;
 b=eeRAoqTAXclIWVnnodittt6aK323DhzuvK4qz1zi4jOCq4Z25GgN12eB/VQyo+azj5tcfvht3Qbq5IjUzU50e0IjaErPYRDOzKS7McITihUGT61+tH8afxKASeyRXFNJMmr516KvBzTcqsagIu/TA+DbstTOJ4dDckm7X3BQlLGaZu2tT05rqOq2wyNkGDChA+QiTFZvPwe9gcO+0guG44UDtiCk26B4FK9Me/WY/4wb6HniKj3DU6KNvqhABrTG+jzlCFmqRhljhzny53BIeUOuatWskBVupYW7+JOQkjwAyErs5IcLrFiEaCE2fswS+VvZ/t+nMLGgVQx3OcTKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3CgOiGOojHaRFIrK38zG0KXZYLfX2/w4Anbhxrb6vY=;
 b=YMVF4Rx1P64HDutCUACmXWD1Rdwwnr/sRsOulye6dUpR2DHq5fPpYlUfyQOTG2FbPsP1Na+exSfchQK5v+ahkruAGWnJaKNbs12I35/jEniR1nH1sGuD9TAVBqt4f4kMaUu41iP9pP6Xhzo/Oaz6QjqXHubSLQxTg/Rj3oB83Nc=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 MW4PR10MB5810.namprd10.prod.outlook.com (2603:10b6:303:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 18:47:25 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 18:47:25 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        Haakon Bugge
	<haakon.bugge@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] rds: ib: Increment i_fastreg_wrs before bailing
 out
Thread-Topic: [PATCH net v3] rds: ib: Increment i_fastreg_wrs before bailing
 out
Thread-Index: AQHcIkLGcGkqy28XZkqqVOSDeprDs7SMwiwA
Date: Wed, 10 Sep 2025 18:47:25 +0000
Message-ID: <89100bace9824884215eb7641e144b8ee8835985.camel@oracle.com>
References: <20250910110501.350238-1-haakon.bugge@oracle.com>
In-Reply-To: <20250910110501.350238-1-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHUBBMB
 CgA+AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAmiSe
 HYFCQkpljAACgkQyD6kYDBH6bOHnAv8C3/OEAAJtZcvJ7OVhwzq0Qq60hWPXFBf5dCEtPxiXTJQHk
 SDl0ShPJ6LW1WzRSnaPl/qVSAqM1/xDxRe6xk0gpSsSPc27pcMryJ5NHPZF8lfDY80bYcGvi1rIdy
 KD0/HUmh6+ccB6FVBtWTYuA5PAlVOvwvo3uJ6aQiGPwcGO48jZnIBth96uqLIyOF+UFBvpDj6qbfF
 WlJ8ejX8lmC7XiY8ZKYZOFfI7BRTQxrmsJS2M+3kRTmGgsb6bbPhaIVNn68Su6/JSE85BvuJshZT0
 BmNdWOwui6NbXrHgyee0brVKbngCfE4+RZIzleoydbHP2GnBtaF2okhnUWS/pNKsOYBa3k8IXdygc
 CbiXmjs3fIf+8HIm0Vzmgjbi5auS4d+tB+8M22/HWdxmdAB0sHUFMtC8weYpVxvnpGAsPvy166nR5
 YpVdigugCZkaObALjkJzNXGcC4fuHcqZ2LVHh9FsjyQaemcj8Y6jlm4xUXgyiz7hkTNsWJZDUz5kV
 axLm
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|MW4PR10MB5810:EE_
x-ms-office365-filtering-correlation-id: d25681ac-aa91-4c87-8330-08ddf09a7c22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NHRuRGhTYjR3T3MrTml3ZzY4NVJYUHBCSkl6ZmFPc240TXRmdmozMkJSUnkw?=
 =?utf-8?B?REluZEdLZGo3OVJDZ1FteTM5MHA3ZVN6SytVdGhzM3M1VHhHTU1UeXJ6MTBT?=
 =?utf-8?B?UHhScUtKNWJ0V3RIRkJlYjhyTUlzald5QjFWbS9hR2d3OXg1YkZPY0tBak1t?=
 =?utf-8?B?MXl1ZXZHRkh4WGhZdCtOZnlqZ3JHdTQzVHJ6TG9IK3VHU0h1S05LaGQrZkZI?=
 =?utf-8?B?ZUp5SzlGRGpRL09pa3hYeWt2dTRKckU3Q21YSnZmNFMwTEx1QUxGQzROenBv?=
 =?utf-8?B?R3UzUkdOQ2lXV1RUMnB3SXhhWnZwV0NhYlFXTlhicXo5NEVjUWJ3bnRZRFV5?=
 =?utf-8?B?Q2gzNC9NSWlsNWJMR085SWUrNzhEVm5kS3VSdkdHeWY3OXhuQXFQM29KRjFQ?=
 =?utf-8?B?dzBLd0t2cWp0TGx2OFc1cnh3eUViZklyQnd5ZzRSbUNuemZaRk5VV1cxa2I0?=
 =?utf-8?B?S2UzdXozTkFNZ3NzSTdxRGtnZGsyZXJQdVlMZ3J1bFg4VHU2UVFISU1lYUxE?=
 =?utf-8?B?azJtNlA4NldWNzJvblVPMVdaUnJKcDJWZ1BQNGVvQittVmRTODF1cG1xVFhD?=
 =?utf-8?B?aEdPUDBTeW5Gc1hYMStuL0tHTnh2NHVtOTZmc3dmMTFUMGZsYk1TT3pEeExG?=
 =?utf-8?B?SElnT1E2Sy96T1NPcjFiaFJlMjRlQVZnTHBLUFpuQ2NFUFFFaGFBMnFKK0FH?=
 =?utf-8?B?eDZVYlVIcVVYNHlMdUVGeHkyVE1lUDZnanZpRjV4Y0JVTkcvWndxbDhRL0Jj?=
 =?utf-8?B?ZTRJQlhGWUk4ZXErL0ROcFVCNXpJRXNkOWE0UFFlQ090M1R4MXdIL0RYVjRj?=
 =?utf-8?B?ZjFJclhjVmVPMHhDTjl5TmwwZnRPZDFiZW1ZSGZYZmVnU1NqYlJ3OUo0a1py?=
 =?utf-8?B?blQ1b2Z1bWJxeW1MeHJpcEdvbWxFWGp2Tzc4UmRrc3Z3TG53UzUyWUJDbnE1?=
 =?utf-8?B?SWxiRjVXSHlUcDdSODk0eGhBT3J2UVNVWW9wRlp2ZGNvdkF0N3U0ZDhnZ09K?=
 =?utf-8?B?V2VuRlRpVHVYbk40TzhLZDdCcHdJVjlaSHV0M1Bld1RKajRpZlYvRjhxVk1O?=
 =?utf-8?B?VExwakI3UEFJNVRVQmpZWlNPZzVicloxZHQ0VXNtRC9TTlRld2lhM1VNQkhn?=
 =?utf-8?B?VjkwS1gyaWZ1S3BLTEtScGJnZ0luaFhLSk9nQjdvcEh0eWZhRDBmcUUxUU1D?=
 =?utf-8?B?b1haS3FjUzdBUXZyc1lrbVRUYnhMRm5TR1JodVMwVlFXNmdSazdoZFhSOFd1?=
 =?utf-8?B?Ym9jOUc3bzZyVXFnWUt4MEpMa2xXM1kvVDBTeGdYbWJUejJyUmFhYXJnTy8x?=
 =?utf-8?B?U1pFYi8wNlpzaGtxT2sxSmdkTFIveDUrNmpudGFUU0wzcWJxTTUxTWZRbmRD?=
 =?utf-8?B?SUdFM2RDS01hZ2Q3VGZlWEJFdjcrOEVLNDRaUUxWTFk5WHEyU1FOaXBlRm1V?=
 =?utf-8?B?bm43U2gyS3pXaHZHVGZRb3VrbzRHSDFyZEZYckE2Yjkrall3WmptQzArYmFS?=
 =?utf-8?B?WGcxOFpKa1RaQ0lWSnZZeVlVUUFDZzM2MVBockFqeVVoekRwa2JDUzdUMWRT?=
 =?utf-8?B?c0MzWFJqU2hONk51QTd1N1ZyUG9sM1Jra3JJbTAvclRCSktYU0w0MGR1UFVG?=
 =?utf-8?B?WE1tUnpIR1dKOU9YRGl2VlNRb1lhNDVzZ1pVM0NTN0dWT3ZhM1hLcmR2NEg3?=
 =?utf-8?B?bE4wdTVlaytvTzFVNzRRenNTcTNMMFZWa0s2cUNuUW9XU2lrSmZNT1hhTFZZ?=
 =?utf-8?B?ZEc5S0RKSmJ4NWFaZzkxWjlBQ0haZTdUNUQwWVFMbEg0Wmp5Ui9NYUw0bTFj?=
 =?utf-8?B?WEN2NldlaGt2TDlMeEdJUFBDeEFaUzhQNmtFOUlOQm9OZEpsbEd3TTZmR1FO?=
 =?utf-8?B?TFJrRUxpVVlabXBWMy9oWnNTSHFvL2RzcExWdEl1c3ZEVWp1TjJLV3oxZSs4?=
 =?utf-8?B?c1hld2dMdHg5Ry8xaXMrRUhINFBTY1VWRGsyK2FFR3FxR0VwZ0pGTHRLczkz?=
 =?utf-8?Q?5O/ZSrJmihCG6UE6imh3aTxffT7Jh8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTZlWFYrd0xUUmQzbUNrb252djAwcjNsbHFISk00OFF5c0s4aVlkWml4VTlx?=
 =?utf-8?B?TWtqOUhidWFqNHBXRVZzOFdTMWRyODBYKzBMR2ZFZGFaOFlJc0s0Mlh6Ym9N?=
 =?utf-8?B?Y2Jab2l6aGl4eXN1RTAxZHVjazZNT0xPbkNHdlRyRnhMWW1MckhRblp6Tzlw?=
 =?utf-8?B?eGt0WnExOUJqVU4wMTU0dnRmYis5WnM2K2RxQ1YvVjJmRWwzZXl6VVJJYXBO?=
 =?utf-8?B?YnZjRDNkcUFuN2hnRXZDZUJISmxBWURRZmtWN3ZpemZYLzRCa2M0YjlRMG5U?=
 =?utf-8?B?K2lwLzZwOFF2MzFnbDN2MkZiMitESzcrbEM4SG9hNVZRN2ZVcmRxTVZBamRu?=
 =?utf-8?B?TkROT0Njb1R1Z0h3dzB2SUVQM1N2VWQ2eHJDOTl1K2Yxc2dEUmlnaFh2L05X?=
 =?utf-8?B?SVptRFRhcml5VVl1ZUl4T3FBOWc0UHgyTWJaeW56Z0ZaU3dUZWlQUXFNckpH?=
 =?utf-8?B?eFhGaFBUdTAxR1BYc0Z1Y29LOFRwZDFKUlo1QmJmSDByZUw0T0hOZTlBVERQ?=
 =?utf-8?B?WG1HcWp4akpOaHRZbUVrL3I1dHo2cGJKaVRTeEZUNmVsRHVvQ052OGU3cE56?=
 =?utf-8?B?Y0FUL3JvdTAxcDdIS3dyK1JITXJzdk5URkt4NWZpNlFIVy9UTVR4OWxuS0JX?=
 =?utf-8?B?Q2drR1crTVlHTjNqdnJGeUYwbmVqYVlPd242L3d5cXR5WXNOL3BLL2oyQWhy?=
 =?utf-8?B?bmVaUjUvUDdUTk5rUWVzODBWclhBSGhjcE1aOUIyUzR6QU9SbnBCWHJldHIx?=
 =?utf-8?B?MFI4WnJiNDd5bFNMUFRzZ3hIemhkZFpJZnZFSkttM2JuYlNMakFQeGEwY2pt?=
 =?utf-8?B?RUtiRmZNQmVSSDk3T0J6YlRmcmYvM2RHbDJxa09EWW1lcDV2dEpnQ1dBM1pZ?=
 =?utf-8?B?ZTVhUTZ1VGt3b05HNEw2bmpuU1ZDMDVqU1RMNzF0OEdRV29Fc2ZHTUtjcEZw?=
 =?utf-8?B?dzZIMWUzR3grcGZrNEJiLy9SdjZxd0tiTTlSNm82Q0NUYm5IdHQ5T1ljanRZ?=
 =?utf-8?B?NEV1cmFpdHNFTDBVR0RReFdhWGlGV1ZXeFU1Si9rZGl3d05RZ0JxRlZZalZm?=
 =?utf-8?B?OVdCN1F2T1NCQVJBU2NORDhwU0paclplc1hkd1hqYkwycXN5eFV4bUc3KzVD?=
 =?utf-8?B?Tm1xN1FDQURQdUk5QmV3L0xkSjVYMVJKNHlhNG1KMStpSWEvRUN0OERLeW9B?=
 =?utf-8?B?NDZNUk96UFBJTkJNOHAyWGFQMXFpMTh1WU82MFdSYnNEK0NQcStQemx2UE1Z?=
 =?utf-8?B?MG16TjI4VEFBRm10UDA2Z3NFcGd0VlhQQTJRbU5nUlNmdGtaQ1lhQUNONC81?=
 =?utf-8?B?dFhOdFBVOGtBKzg5ZFcvQ0dSUFVaWTVNVXQrUStZUTVBbmdzUTJmSmZqOGFC?=
 =?utf-8?B?MnR3RFVoL3JKWlpVZGhjU0paeXl2TVhLK0tyVitLNkI1ME5BR0NYKzlKbE8x?=
 =?utf-8?B?dS9uZ2RYdkxMSnpjR3kwSlRqQVUxdGdHN0ZyN1ZWS2owTXpQc3REQ0UwLzlx?=
 =?utf-8?B?NkNpN2sxVU5seXZkbm8ySGp6Y0NGMW03WDFaY2o5aDl4NHJ4OE8welU4K1BK?=
 =?utf-8?B?QmhzOGNXZnJVeHlkSHBnUnlOUjBONi9FNTF4ZGRtUG9mTDZJTlNiZURMSnlv?=
 =?utf-8?B?cG83WjNIcUtBWjhYNFdFdXU4UWt1RmRJZXJya3g0V3lITUhGdnRrTzVzaG03?=
 =?utf-8?B?Skl2ZXRleGNscTZQd3ArTE1vYmZmalFHYXFIT04wR1ZRWHRVMlFzZDMxRitO?=
 =?utf-8?B?OUFzREFOYklVeGQ0THA3dzhkUkExekJMcDlheFhrUWltdEpIZmtJYnhSRGNB?=
 =?utf-8?B?M2xLQXdMYkZIa1pPUzd1SFh5Unk3WStxeTllOVQvZWhNc2ZsOFNwOVdGanNj?=
 =?utf-8?B?KytaS1JXOTcvSitRZmFUQjNiOXB0VDRPdW1Tdlh2YTFMUDR1Z3JhM3BUeExC?=
 =?utf-8?B?UnAwVEVDTXo3RzU2YS9XVkNiMmxoamhUM2ZYRnFXejlEUVZWVlM0cEM1ZWQ5?=
 =?utf-8?B?Zm1GajRpbkRLcW9mQlZLSEJRa0dIdTRQUFNoZ1JoWnIwUkJmQkZpQjBML2ZP?=
 =?utf-8?B?MCt3M29OS2hUc1lKV0dhZS85SUU1QktGc3pZdEcvWjRNVlJmSFJiQlBkbW1V?=
 =?utf-8?B?TU9jem1CdExtdmJVSEJVVVFhQ3crU2VyOTdkbDRpQWdWQjRsUGtjWU04cG5T?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1166CDD5A99DF4F9E624FD27F2C25CE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mYZDrfzOiBYxNny50luU4h7oLAr12kg93sv0SCL+8Cgj9aq5rYQMvXrhZaC+lJaZQ9QRx1/Y7DkLIdUREmM6nkFNv2CfiGvjrn+kN0fLWhm7P6a0iMqpG6p/vJH6QlcdiUwoBbQ/HkdX6uMTwdTHEZwrkQAB0+dSHxws6PikXS5cjS3cZyKzbAGqRmMp12PwOuexQA7qxAYoV6bJdIko8OD6bvKP/AAUosCyHwHh8j34/JPPtXNQsy2hYxEjaCnS6vdcKlJE5C+F0wXmoA4DhZUlxrYizJZZ8sSeYHrLSbhh9Gjg0AA8xY/ywV34cgyBekluyCyINz4lZ75qNgHNzLH4NLLy+UgGwf6y+REee0JQ4dtIZNcI8Tr0NGPXKbqfWQKNjZ6+7vrj39y+GiF0Ijn5udMzqsMwRGnwd9M+NTBjt3Ww85t6VPgrdc8ibNAzDbF522OboGnSxjmqN0BlUPY1YwsUPjsqcvsKGe3kFHgfVbqWE3NU6CiA2Y3WdUGcZsW2Z0efXWsVfIlYXnjgwRqw3Uk2Nz3hu7D0tBIxnhbNihYHACQJfLesPTsZHZUYWACeC5kHA/tdiWCi4M1T07zS6V5So251lvhcNaaEM1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25681ac-aa91-4c87-8330-08ddf09a7c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 18:47:25.4265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bcz/3jR/7ybfqZtWzb0oYRR9zG4LJBAmqoozh5YnEKSkH2ZJRw5HbFV0xs5+2sexNE7ClO5O7u97HHYvx+NKlLpB9rI1CU3iSU4liUyIbs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100174
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c1c7c1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=5vqf0W9iEM5KR6XJ1U4A:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: _Mk2oxK-dQIBUBL-m7-UNiZAzv252Rbh
X-Proofpoint-GUID: _Mk2oxK-dQIBUBL-m7-UNiZAzv252Rbh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX5JH0ywIo4k/N
 jcwO+ec0xgSdHK2toi/BFBpZSQdl3Y230awWznfLH83VcS7MLblJuypok3xERmzWa0IYBBZSNpk
 XzUwIyzLtrRB7TPFoIQwUxK5SYOPUuJAMHWYUaJWioo+wxN/LHUMdnee/flrx6Na6heof0kS8uq
 Is1ixcXzDJnr3ac29+qWb5f6B6yNk4LV/h08OPkVCvwC0QLNxtpIpalxftLrKe3+ChTZEHwm0p4
 oDyxeo+UI6pWjfoUKiWBt9jkgEDd3Q0jm3OUUMUGDJxufxXf9Ya5rmAD6yuKc8gXqRlMI+AghaW
 cbYHTfza4u0fRE61ttxmQ1hFs6+mh/5alroI5vrvLoAPDPzBv4cX5uqr9Y4/OxvfQrEa1yMrMlF
 jg+X2zgAXSh8fD7n1WH4srqheDnc1Q==

T24gV2VkLCAyMDI1LTA5LTEwIGF0IDEzOjA0ICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+
IFdlIG5lZWQgdG8gaW5jcmVtZW50IGlfZmFzdHJlZ193cnMgYmVmb3JlIHdlIGJhaWwgb3V0IGZy
b20NCj4gcmRzX2liX3Bvc3RfcmVnX2ZybXIoKS4NCj4gDQo+IFdlIGhhdmUgYSBmaXhlZCBidWRn
ZXQgb2YgaG93IG1hbnkgRlJXUiBvcGVyYXRpb25zIHRoYXQgY2FuIGJlDQo+IG91dHN0YW5kaW5n
IHVzaW5nIHRoZSBkZWRpY2F0ZWQgUVAgdXNlZCBmb3IgbWVtb3J5IHJlZ2lzdHJhdGlvbnMgYW5k
DQo+IGRlLXJlZ2lzdHJhdGlvbnMuIFRoaXMgYnVkZ2V0IGlzIGVuZm9yY2VkIGJ5IHRoZSBhdG9t
aWNfdA0KPiBpX2Zhc3RyZWdfd3JzLiBJZiB3ZSBiYWlsIG91dCBlYXJseSBpbiByZHNfaWJfcG9z
dF9yZWdfZnJtcigpLCB3ZSB3aWxsDQo+ICJsZWFrIiB0aGUgcG9zc2liaWxpdHkgb2YgcG9zdGlu
ZyBhbiBGUldSIG9wZXJhdGlvbiwgYW5kIGlmIHRoYXQNCj4gYWNjdW11bGF0ZXMsIG5vIEZSV1Ig
b3BlcmF0aW9uIGNhbiBiZSBjYXJyaWVkIG91dC4NCkhpIEjDpWtvbiwNCg0KVGhpcyBzb3VuZHMg
bXVjaCBjbGVhcmVyLCB0aGFuayB5b3UhDQoNCj4gDQo+IEZpeGVzOiAxNjU5MTg1ZmI0ZDAgKCJS
RFM6IElCOiBTdXBwb3J0IEZhc3RyZWcgTVIgKEZSTVIpIG1lbW9yeSByZWdpc3RyYXRpb24gbW9k
ZSIpDQo+IEZpeGVzOiAzYTI4ODZjY2E3MDMgKCJuZXQvcmRzOiBLZWVwIHRyYWNrIG9mIGFuZCB3
YWl0IGZvciBGUldSIHNlZ21lbnRzIGluIHVzZSB1cG9uIHNodXRkb3duIikNCj4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24u
YnVnZ2VAb3JhY2xlLmNvbT4NCj4gDQo+IC0tLQ0KPiANCj4gdjIgLT4gdjM6DQo+ICAgICogQW1l
bmRlZCBjb21taXQgbWVzc2FnZQ0KPiAgICAqIFJlbW92ZWQgaW5kZW50YXRpb24gb2YgdGhpcyBz
ZWN0aW9uDQo+ICAgICogRml4aW5nIGVycm9yIHBhdGggZnJvbSBpYl9wb3N0X3NlbmQoKQ0KPiAN
Cj4gdjEgLT4gdjI6IEFkZGVkIENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAg
bmV0L3Jkcy9pYl9mcm1yLmMgfCAyMCArKysrKysrKysrKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvbmV0L3Jkcy9pYl9mcm1yLmMgYi9uZXQvcmRzL2liX2ZybXIuYw0KPiBpbmRleCAyOGMxYjAw
MjIxNzgwLi4zOTVhOTliNWE2NWNhIDEwMDY0NA0KPiAtLS0gYS9uZXQvcmRzL2liX2ZybXIuYw0K
PiArKysgYi9uZXQvcmRzL2liX2ZybXIuYw0KPiBAQCAtMTMzLDEyICsxMzMsMTUgQEAgc3RhdGlj
IGludCByZHNfaWJfcG9zdF9yZWdfZnJtcihzdHJ1Y3QgcmRzX2liX21yICppYm1yKQ0KPiAgDQo+
ICAJcmV0ID0gaWJfbWFwX21yX3NnX3pidmEoZnJtci0+bXIsIGlibXItPnNnLCBpYm1yLT5zZ19k
bWFfbGVuLA0KPiAgCQkJCSZvZmYsIFBBR0VfU0laRSk7DQo+IC0JaWYgKHVubGlrZWx5KHJldCAh
PSBpYm1yLT5zZ19kbWFfbGVuKSkNCj4gLQkJcmV0dXJuIHJldCA8IDAgPyByZXQgOiAtRUlOVkFM
Ow0KPiArCWlmICh1bmxpa2VseShyZXQgIT0gaWJtci0+c2dfZG1hX2xlbikpIHsNCj4gKwkJcmV0
ID0gcmV0IDwgMCA/IHJldCA6IC1FSU5WQUw7DQo+ICsJCWdvdG8gb3V0X2luYzsNCj4gKwl9DQo+
ICANCj4gLQlpZiAoY21weGNoZygmZnJtci0+ZnJfc3RhdGUsDQo+IC0JCSAgICBGUk1SX0lTX0ZS
RUUsIEZSTVJfSVNfSU5VU0UpICE9IEZSTVJfSVNfRlJFRSkNCj4gLQkJcmV0dXJuIC1FQlVTWTsN
Cj4gKwlpZiAoY21weGNoZygmZnJtci0+ZnJfc3RhdGUsIEZSTVJfSVNfRlJFRSwgRlJNUl9JU19J
TlVTRSkgIT0gRlJNUl9JU19GUkVFKSB7DQo+ICsJCXJldCA9IC1FQlVTWTsNCj4gKwkJZ290byBv
dXRfaW5jOw0KPiArCX0NCj4gIA0KPiAgCWF0b21pY19pbmMoJmlibXItPmljLT5pX2Zhc3RyZWdf
aW51c2VfY291bnQpOw0KPiAgDQo+IEBAIC0xNjYsMTEgKzE2OSwxMCBAQCBzdGF0aWMgaW50IHJk
c19pYl9wb3N0X3JlZ19mcm1yKHN0cnVjdCByZHNfaWJfbXIgKmlibXIpDQo+ICAJCS8qIEZhaWx1
cmUgaGVyZSBjYW4gYmUgYmVjYXVzZSBvZiAtRU5PTUVNIGFzIHdlbGwgKi8NCj4gIAkJcmRzX3Ry
YW5zaXRpb25fZnJ3cl9zdGF0ZShpYm1yLCBGUk1SX0lTX0lOVVNFLCBGUk1SX0lTX1NUQUxFKTsN
Cj4gIA0KPiAtCQlhdG9taWNfaW5jKCZpYm1yLT5pYy0+aV9mYXN0cmVnX3dycyk7DQo+ICAJCWlm
IChwcmludGtfcmF0ZWxpbWl0KCkpDQo+ICAJCQlwcl93YXJuKCJSRFMvSUI6ICVzIHJldHVybmVk
IGVycm9yKCVkKVxuIiwNCj4gIAkJCQlfX2Z1bmNfXywgcmV0KTsNCj4gLQkJZ290byBvdXQ7DQpK
dXN0IG9uZSBuaXQ6ICBUaGlzIHdhcyB0aGUgb25seSBwbGFjZSB0aGUgb3V0IGxhYmVsIHdhcyB1
c2VkIGlzbnQgaXQ/ICBJZiBzbywgbGV0cyBnbyBhaGVhZCBhbmQgY2xlYXIgaXQgb3V0LiAgDQoN
Cj4gKwkJZ290byBvdXRfaW5jOw0KPiAgCX0NCj4gIA0KPiAgCS8qIFdhaXQgZm9yIHRoZSByZWdp
c3RyYXRpb24gdG8gY29tcGxldGUgaW4gb3JkZXIgdG8gcHJldmVudCBhbiBpbnZhbGlkDQo+IEBA
IC0xNzgsOSArMTgwLDExIEBAIHN0YXRpYyBpbnQgcmRzX2liX3Bvc3RfcmVnX2ZybXIoc3RydWN0
IHJkc19pYl9tciAqaWJtcikNCj4gIAkgKiBiZWluZyBhY2Nlc3NlZCB3aGlsZSByZWdpc3RyYXRp
b24gaXMgc3RpbGwgcGVuZGluZy4NCj4gIAkgKi8NCj4gIAl3YWl0X2V2ZW50KGZybXItPmZyX3Jl
Z19kb25lLCAhZnJtci0+ZnJfcmVnKTsNCj4gLQ0KPiAgb3V0Og0KV2l0aCB0aGF0IGZpeGVkLCB5
b3UgY2FuIGdvIGFoZWFkIGFuZCBhZGQgbXkgcnZiOg0KUmV2aWV3ZWQtYnk6IEFsbGlzb24gSGVu
ZGVyc29uIDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPg0KDQpUaGFuayB5b3UhDQoNCj4g
KwlyZXR1cm4gcmV0Ow0KPiAgDQo+ICtvdXRfaW5jOg0KPiArCWF0b21pY19pbmMoJmlibXItPmlj
LT5pX2Zhc3RyZWdfd3JzKTsNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQoNCg==

