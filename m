Return-Path: <linux-rdma+bounces-12868-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F210DB30AA6
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 03:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCF734E2EC6
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 01:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908919D884;
	Fri, 22 Aug 2025 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pUKK7AM4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oaoG9nEI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1B57C9F;
	Fri, 22 Aug 2025 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825067; cv=fail; b=uCr8i90/yQRGjIXfLrdMfiZxEp6ITOIa/bEGa1+3G1KZorB3WePbrX7tOzgvvoYeU5wyydSGQl6x+n6ash9JyASRylPEL5FDnFY3/9VHysavJBemuCxdokBTTdlFU33o1RznSCoWhTjS9ImRi44Ffsk8C0NY5SJ8T4UqfzzvizA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825067; c=relaxed/simple;
	bh=MKC1jF0k5nlmzTmZ5nYBfqFFShUYdsp8TteoPvzPmiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DG9yyazjk4FgIWrmh6dI79Jy+brYYhQoe89hakaWKp2BjFu5O8FDGNzoD8qUYW+bGXpLfIeFoFUKvwBOMKXccvgYwdot96AlQVmVvDzXQ+JmD21LYqYKVoIIh9ILxRQbzbCyi5uDQ6qBUAjciqbr5uWyrTaIi906hk7dzMYbtU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pUKK7AM4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oaoG9nEI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M0DWKs022591;
	Fri, 22 Aug 2025 01:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MKC1jF0k5nlmzTmZ5nYBfqFFShUYdsp8TteoPvzPmiU=; b=
	pUKK7AM41AJ5IvJuSPDsPMTBkMLH2LCFXMJYKesV+q3sHDGK9iFnMTrZkhwHFVuw
	ve33lrzbqDBNpp2DaII9FkCHlJQ3M3uFCHm1zdyt34ZvODA2alJmu18+/a6lOkjX
	hNLb8f+BEEw6ojrRfjKEZvnFNSY2kQ8HPPAwFXAXIt6O5EDF5iaBcw4iEH4Tz4Pz
	J3C5kqi5SJ4/VGskZ8wMKxYZPjXpdg92b3pt2s6I7MhQXjimWMuOcI0eBUKqkqUP
	t200u7LDaJIJKznXLqLR+APhoS2xs39Yc17Nz4f30CdH0im6tE++om5l1DkpVD6G
	fJl7pET4ZN5S5L6hNngGdw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48pa268cm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 01:10:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LMgC50007279;
	Fri, 22 Aug 2025 00:56:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3ssf9w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 00:56:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpHW0kITRXgRgSJvXZ0r5jh7ntiXsbZTKm9rAttrwYahpjnvrcAyLzWKKiXiiK4P8gmXv5ogzpYx0hSe8b1isYALaOslHuxH5+OUlvC5VR4Qfnq1DpPqR5sOu0HK5c2asabsyyNBFeXDmYpdZ3zKxRltBp4lrPrkgKyqkzs3u/yVO2NPwfTzfbH8UKcjwCC+4rSolIyEptQ5N/Ibug5jPXacf2MWlGqoxCthwqSJUEtDVJsnGEY66TXRmC88HP8fWTH3fK+uk2PG3d8trU8yS3kb6mtFgWZ6+Oi6MLFt8E+FVZz/E+qYiK8BKkPp/L4IG+ZLfH97KNNeVaJ2uUpsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKC1jF0k5nlmzTmZ5nYBfqFFShUYdsp8TteoPvzPmiU=;
 b=vRjHfhDqhm0bv2MV4hgNhP/EVtnfCnGGp5nT/gDcfWgSA4VFQUhfrlVYRCBTO4jVEiTsqtPVc6xw+V5q3NEfzjY96Yp1fN+LmUHkZa8wGPsrKBVvXxIjS15sEhZFOETmgXs9QDhChSgXpX6if2PPFoWQkwT12u5Y/zWy+YDNbd3ki0D7hN6i+9K2gHvHkGuCYxiNvE73zKhlXyKctPVkUm0wuyjQQBquyo9X7RZF1tqxdZSM5IXwh1eacjngp51bOOWEMP/Ivt6okbL+0Ew8W2Wk8wKzAwyqqeJnotAs54JtmDSXNm9J2QXdcSjsF2uZjupEvOZcPEUnrrsB1eYTTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKC1jF0k5nlmzTmZ5nYBfqFFShUYdsp8TteoPvzPmiU=;
 b=oaoG9nEIVBkp57E9uzzBMrzgoGZ5+wz80YnXcBrAfGX2hqIKdHGbCT4ShuDt9QC+chfaCcM2M3fCaYU5KmNv3RBPu3ZRL/3akBYkGjNKz3akyhyHTK/QRbGZf81vwt//J6ZsawWCa9WwWDyJ6i1v2NFI7Qkb3uDSYP9oKVfpH4c=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 IA3PR10MB8613.namprd10.prod.outlook.com (2603:10b6:208:577::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.15; Fri, 22 Aug 2025 00:56:25 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%7]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 00:56:25 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        "ujwal.kundur@gmail.com"
	<ujwal.kundur@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/4] rds: Fix endianness annotation for
 RDS_MPATH_HASH
Thread-Topic: [PATCH net-next v2 3/4] rds: Fix endianness annotation for
 RDS_MPATH_HASH
Thread-Index: AQHcEfvRjQDZxhzh4Ua6Q0FpQ1PSCbRt2zGA
Date: Fri, 22 Aug 2025 00:56:24 +0000
Message-ID: <35c7c1aad491504a4da79aee079ce7a4743a5778.camel@oracle.com>
References: <20250820175550.498-1-ujwal.kundur@gmail.com>
	 <20250820175550.498-4-ujwal.kundur@gmail.com>
In-Reply-To: <20250820175550.498-4-ujwal.kundur@gmail.com>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|IA3PR10MB8613:EE_
x-ms-office365-filtering-correlation-id: 23755883-166c-49a3-5633-08dde116b807
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHM3aFY4VXU3S0t1T1FyR2UwMFF3aHVJZUREeU9pS3RUREVKaFlqYlc1Sjlz?=
 =?utf-8?B?Y1hFbzRKRFNCMWlxa05OQ3prNGJvZUZZQ0Z2cDc2blpTS3RiQ0dXayszTVJ2?=
 =?utf-8?B?L0U0eVBsZDdISHVGSFpJU0IwelZ0aHNKdm5QWlhJUGs3a3pQazBqNUpMR3ND?=
 =?utf-8?B?NTBwTTdoWk1JM2NUOHluRFlVR3ROa3Y2eXRxZTErRmZ3alhZejdkUE44KzBj?=
 =?utf-8?B?MEJUSzcvQlhsUTJPcTJSbDRwTnEvQXBJOG1WSUhZV2FybjFwZE1pV29naEZu?=
 =?utf-8?B?d0RVdlNMdUJ2OGVXeFdRRDhZanZ4bUZHUHZaSjRtOVlIdFNrbzRpbzBoMmtU?=
 =?utf-8?B?OGRkNytBSHJZYmJvL0NlMHd4S3dvZjZwNGhud0R3NkdKV0RvaU0zb21VeGtz?=
 =?utf-8?B?NkRVZEMxS3JHengyejEwZlRXZXV6Mkg4T092OU8zZTJ4blFKbGJSNHlDTUxZ?=
 =?utf-8?B?ZTQrVGZicDJpRGUwR1EwZ1YrK3NnbWl3bWp1SUtMN1ZQVzFzNlZEUTJEcnNh?=
 =?utf-8?B?T2hnUDhMVk5RdUVEMU05T0kzMENQWS80eTFvN1dpRkNDQjl0WXVoSllaZnZN?=
 =?utf-8?B?YWFac0U2aGpKdXZpcHYxTjdMU1ZjT1M0eGRmdlk5bGNxclFnVnFxeDVodkZS?=
 =?utf-8?B?L1d1ZnFMallSTm5DQ2dQemR6UmJXNTBsdy9UZmFyZWdMZmdtbHZXb0ttSngw?=
 =?utf-8?B?L2o5VGV1RjQ3V2RaMkUwMmMrRFc5Vm1lS0Vrd2ZmNE9IaVVSam9xSSs3NUFR?=
 =?utf-8?B?L0xHYzhmazN0cmlKN2JiWFhNZS9tYm5BSVExUGxRNk5Mb1RzeThWSWtGYktN?=
 =?utf-8?B?WUlaTjl5WitUY2ZlVFRsV2ZmS3N0RjEvNmY1MnlVNmptSTRsZVM1L1ZrV0pZ?=
 =?utf-8?B?THhEcnlabXd6YmZ6STBhaSt2bUIwTi9nWjh6c2lrQnMyYUxVa1l0UXZkekxa?=
 =?utf-8?B?ajhPM2RYNXhSNFdhWG5CaVIvR2doSXZ2NDRHMm9LYXd1K1Y5UVg4eS9jR2dP?=
 =?utf-8?B?cGk0NGg2YXBMVkdyZkZOYzZERzdMSmw0YmV1em9adkE3cmlGWXpucDZvSWs3?=
 =?utf-8?B?VFZ0V09Nci8wZysyb0dXVGx4MEEyQ0RHYVBtTnN2OWN4amRacHlXVGh5bzZQ?=
 =?utf-8?B?cGxYYTAxeHpYM0Z0N3JVb05TdUc1U0g4ZlVGenFHOXNQdGQzano4L016T2xT?=
 =?utf-8?B?WTJmU2Z1RGJGRWxMWmk0Mm8yUnVCa2NlSlYxakcyQ3hkZUY3L1czRGhMdDN1?=
 =?utf-8?B?V2VvSHFTZXBOZksyaml0c0gyWThEL29xSVNqeXJxUzFHUndEOUEzUTlZRTdi?=
 =?utf-8?B?S095b0NOY1dremM1dlRlK2VIRVlzM3piOHVXWUVZRVIvSWF6N2JQUzc4UFdT?=
 =?utf-8?B?amg2LzJFb2FrL1g5RDJ1SzR6L3NLeE4zUEh3NWovdGpWaW1QY0ZsSTVHQUEx?=
 =?utf-8?B?STVtWkplK0FLQUJqNTNKMU05M2pGNVNTTHlTa0FoMWVDRHJSYWdXRjk4eU03?=
 =?utf-8?B?QnJNdVlnK2lETEpLM215TzYvMnhPWDJwM1VZUnMrMVRqK29lU2tHVk56Rmxm?=
 =?utf-8?B?dHZEZFljNXJpMU9nK3pZV28ycTlzcnRta1YxTUNSTW9XL3FIdDZEdm9lNC9x?=
 =?utf-8?B?S3FZWkx5M2hJc1Q5UmxqeDU4MjRwOThlRVRKL1pCT2k2MEpXZ1RGY08waWp5?=
 =?utf-8?B?Z1ZuV00wT2RtYSs2L3RtRHF2NlFFR2U1NzdpL2xwdDBqbElkVGZ4NVZqYXIw?=
 =?utf-8?B?UTVOQThMSnBWeGxEeEUva2FaREp2U2JZSUI4Zk5MRExhdkNyc1ovMXYxYVRC?=
 =?utf-8?B?ekc4MklKZzNocmt1bU5MVFd4MENVMTMzd2lxcnA5UUFpcmhBWEgrUHhpTXdF?=
 =?utf-8?B?Q2U0b242dGNmMlBJZ0tUbDZmYmJyM2I2RGhSK2ZUN1ZIclN4UjFmTHJBV0FZ?=
 =?utf-8?B?bEI2bHNnMk9xeVlqT3VPbG8yS1ZKL0NkYTZUWEVFSUJuL2plNEtkT2FCb1pp?=
 =?utf-8?B?Y24vaW1ueTZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzBRd3d4VHFwUHdIa2ZmZFE1Y0lJT0twSkhncDRIeXdqM0lYOWlqbktTVnNi?=
 =?utf-8?B?cVYrNkswTWc1OWNXTTZBcmUrWEhhbTh2UU4yTW5Db1EvY295b1NiMGZzN0kx?=
 =?utf-8?B?UXpxM3VFelIwRXA5eUlMZm0zVEQ4QW5rYnlQRVFhL1BlUE9Mckl4RTlObWkz?=
 =?utf-8?B?bm43UFp3ZENnQ2VLdmNEbzUvWlkxN1ozeGM3OWxFc21CUFdseUtGR0FSWSt1?=
 =?utf-8?B?VWlBNEhIajhyUDVneTh0Y1h2SEJmY28zU1NDYTNQM2hBWGJlenFZUGNYQm9Y?=
 =?utf-8?B?RGZUdjRTNlg4bm1zU3RpM3dlVkRBS1NadXNod3FhMjRGcEVNNi9PT0hPZ3Mv?=
 =?utf-8?B?dFZLZXpKVlVJRXBVMXlzQ24ydk5zVm1reE04enJocHhFNmUxaHE2cm1lWnJV?=
 =?utf-8?B?T0RralEvWTRCOXBGcnpzeEdWUHNDSnZaQTNEYkpVMkZwaGthVDN4L2lTS1ND?=
 =?utf-8?B?RlNPZXFwY21PSHBrRC8rbG9LTkVDbXYyQTkvai9pQjYxUG5KZ05rN2p1VDhz?=
 =?utf-8?B?eFdXUkdXS0dyZktYZytxYnQ1VDlpeFZiMXd1NHgyb0JMNGdHL3dXNW1RU3pV?=
 =?utf-8?B?NzVwVWthQjlMbEtnSTNzSnUycWdOTlJyRE9jT2RrbjZIeWhQdjFrQ3B1RnZP?=
 =?utf-8?B?MHhpRGl6aDFXK1FQMmFYRUpXckd2TXh3dm05OFJhWU55Z0pGbEpDRjJ4c1V6?=
 =?utf-8?B?S3hEMmlNcFpUM21VQTFVTU1lQk45UWVXT3hIbG9TaEZJMC9rZGkwMWVwRmhY?=
 =?utf-8?B?RmUyYXUxZGdvNkdQdlNrajFLKzQvaXRRMktsWW5DbEpyZnRjdjFQNVNvQkdk?=
 =?utf-8?B?S0hWNlZ1dkJ5NEJRT1VmSlEyVExqSlp0akZOVFpMSjh0ajBMcXIzOHBoREtG?=
 =?utf-8?B?U2xuTXBnWTFWT3diTkFRMG5rLzdGbjJ4SEdJaDE0dDBMZjJBN3Y2OURMMjZn?=
 =?utf-8?B?Z1UrSjNxMlNCOU4xWXVXOTJoQWUxSkpnaFVoQTF5TzNrRXlKRGJDazRUSTNr?=
 =?utf-8?B?WGt4a2JCckFwMUlreDZxbGpIOXFBRXlxVUZHclR4WFZlWDZ5ZkFFT3Mwenln?=
 =?utf-8?B?QVF3cmg2MUc5eTg5dDhMYVVWNUZ5LzFKRWJBbnZPRUR1N3JDcjN5dnBzeEVN?=
 =?utf-8?B?R3czTWJyUkQ0Zy9TVXIwSGwyZGRUdHdiLzZhZHBmV1I2ODhwNnllVnBwQTZ5?=
 =?utf-8?B?ZTB0R29Ua2t2aXVkVjdXWjdyS2NITnFaYlozWWFKR0llTTh1STMrTy9EYzBF?=
 =?utf-8?B?dmFleG1aT2tRQm1JNjFXSCtKVE5Qd0llK3FrR3pFb0h3Q3dWQU9CYkJnS3Y3?=
 =?utf-8?B?aVNmZjZOOWJORGdBdjN3bXJrMEdvbS9wc3ZSSW96ZitkbEV6emVQYWJwcURw?=
 =?utf-8?B?ZjkrVFlxLzF1bVB0YXVRZE9UdmZCYzB4N0p4V0E3L3Z3UmczZllmQndFS3d0?=
 =?utf-8?B?TnJvdXpJZzUxeTZEb2g0MTdZVkg3c1Q1T2JTd3lCQVB3WGxrWjRJV3pWWjJS?=
 =?utf-8?B?aGtvZVVNNjZGOG5rUEh4YW1oYkV0ZlN1WjJJaUVXUkpwcERpcmxZRGR2ZkdV?=
 =?utf-8?B?bFV6U2ovcXNZeWV1WXJodWV1TTN4Y0xiamxnMytWRmxRRzI3WVE1ZUhWNmsv?=
 =?utf-8?B?eUcxS2FRbUNhMThiYTlRbVJCUTZqMStOMlVNN1E1aHU5RnBFYUpwL0dzMFJO?=
 =?utf-8?B?WHozY2N4WkowWWNXN1BZemJZbm9kNnFVRFZGby95c1VLTUFsUnExZ0RMWkZK?=
 =?utf-8?B?alJlb1lRc3dxWFFvcjR3WGFYTmV0MEd6SmhidFgwdUJQdWJyaE5YZHYvajFp?=
 =?utf-8?B?dXczVGlRdDZyNmRkbTVobUd5R1owOThJTmlESXlJbURNRlVzSGQwSDlIMTdt?=
 =?utf-8?B?N282U1dvL0xJZmVCaGtUTDBsdnBSdnhhYmhJSmxWc2s5RnVGeDJKUHRqL1Y5?=
 =?utf-8?B?ekllTE5xd2s1TGxVZFFyVlhOMFAxVDUxdjg4aU9HbzN0NEdrSERWV3l0ZUs5?=
 =?utf-8?B?TndZbGpJSmVRbFlRUC8ycTRVNHZDTjZ5TG5zUEFtVFVUaG9XMFFObkltWnJC?=
 =?utf-8?B?dExrRHpXbjdTMmYvZnVmVmc3a0VqVmRtYUd1VklUZk1oZHhqZzFVM0VJdEhJ?=
 =?utf-8?B?UTl5RERDT3FKN1A1YS9mVnIvNE1vTVBWaW5jQ1d1STZraElVamF1cEYrZXZ2?=
 =?utf-8?Q?7vkXO8O+4TmIgMjyPDfTGBk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06604418897FF04EBCAC88192E406589@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dpwZQxeFmUtEQs8WL+pIYne2M529nKiYvH94S/Y9Ec+/AB43lbj/nmYr6B5RuBGMLVEGwRqgQH1eUjETaXdXa1qYZKYuqb7v36xhWsMIjCqVxNrgXNDh15rKfjMKo0sZNjt3Xjs9/D8pvf0SJ2T2ip+lNxOSwv0vcCFzOZKUJ4dSKFIIYfBfhWVNM69YG1igvEsHAc67Uoju0hM5cc0v05negjTyPJXxkWAYsbhtbqN0du6ECzqc+XTKTelSUoU9PnzwYULYOroeL+kn9rbkecqvMtgHK7VgSo5niKe6oe08rdLfNbYuf/VJlHbpn4ruHtQQNvYfaGciv5yRMqhasuWTYZRUs3ShZMvmbOs9vPDUGRukRUs3ar6/IdTcMufYQQphr6v4tbDFHVro+GZ+Xq25Q5p8NM2n8dDMgoBObVAJ60mAP8/4LJuyvNyzNtKRcskGws9vqL69vfh4pa5V8DPmP2hRwoT6j1OaVmV+qYc87iD20dLhhllSiSPKm2XX60TWq6cIRNWDuonkrpJJiJ0P58LV/49622Lp6Orpcft53zGDk9z1uqwZ/BIKeduIozlhUTzqKgAAH3TaSIomn4Cvr6CEeny1mSaHb8G6Jbk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23755883-166c-49a3-5633-08dde116b807
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 00:56:24.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ObJhXbnG16+l5A+u2euw/7Sig+x6zkvqeCmTmWHEIBrfoEppDj3MuY5t+quqYePtqiE41sk78RsI/RowllyYv/OJdnyO6fXjeC50Z7xSTUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508220007
X-Authority-Analysis: v=2.4 cv=ZPiOWX7b c=1 sm=1 tr=0 ts=68a7c3a0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=3KNrY1-qwzzuqne4ubsA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: CMha_DisKq9yNAOfuE-ns0dqVkz3JNu1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE2OCBTYWx0ZWRfX+qLFPqg7QsHi
 LWsmcgza45VYlehM+8RY/t/TnBWgo47GGXdHAgZR7TNpD/zxWgqPVhWRn2rbfpI8Dp9tTrcRiAJ
 Z90VUioJhHNlmKcj3LusoMMOLu+SUgEe1iR00bxLLHXGEyId3uk9HWM0MO/YdXi3J6fyXqqVZ5o
 8SzTNGyqvkQxu7pfKJBFAwJf3lKwdkFHabyq0N2EoGLnsTHuPFt+gqSfDxqGyCZX3IK558D1Yfj
 yudEOr93RcM/+lzyunpDUmTav7Q4LfLh6XKaS7YP6VRDxlOgjcydnB4xfL+S+ryJPrFhMqYkMfg
 bfuPYdTViRaAWy4Un+GaOwUJ0+Tay4bjlJOYvrRbZ0ot+5fuAZJCasbS7gfNvBHdHpRT3IRtWma
 4E4P3MyO4YCrHokRXLxEchq9VpX1dA==
X-Proofpoint-ORIG-GUID: CMha_DisKq9yNAOfuE-ns0dqVkz3JNu1

T24gV2VkLCAyMDI1LTA4LTIwIGF0IDIzOjI1ICswNTMwLCBVandhbCBLdW5kdXIgd3JvdGU6DQo+
IGpoYXNoXzF3b3JkIGFjY2VwdHMgaG9zdCBlbmRpYW4gaW5wdXRzIHdoaWxlIHJzX2JvdW5kX3Bv
cnQgaXMgYSBiZTE2DQo+IHZhbHVlIChzb2NrYWRkcl9pbjYuc2luNl9wb3J0KS4gVXNlIG50b2hz
KCkgZm9yIGNvbnNpc3RlbmN5Lg0KPiANCj4gRmxhZ2dlZCBieSBTcGFyc2UuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBVandhbCBLdW5kdXIgPHVqd2FsLmt1bmR1ckBnbWFpbC5jb20+DQpUaGlzIGxv
b2tzIGZpbmUuICBUaGFuayB5b3UhDQpSZXZpZXdlZC1ieTogQWxsaXNvbiBIZW5kZXJzb24gPGFs
bGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQoNCj4gLS0tDQo+ICBuZXQvcmRzL3Jkcy5oIHwg
MiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy9yZHMuaCBiL25ldC9yZHMvcmRzLmgNCj4gaW5kZXgg
ZGMzNjAyNTJjNTE1Li41YjFjMDcyZTJlN2YgMTAwNjQ0DQo+IC0tLSBhL25ldC9yZHMvcmRzLmgN
Cj4gKysrIGIvbmV0L3Jkcy9yZHMuaA0KPiBAQCAtOTMsNyArOTMsNyBAQCBlbnVtIHsNCj4gIA0K
PiAgLyogTWF4IG51bWJlciBvZiBtdWx0aXBhdGhzIHBlciBSRFMgY29ubmVjdGlvbi4gTXVzdCBi
ZSBhIHBvd2VyIG9mIDIgKi8NCj4gICNkZWZpbmUJUkRTX01QQVRIX1dPUktFUlMJOA0KPiAtI2Rl
ZmluZQlSRFNfTVBBVEhfSEFTSChycywgbikgKGpoYXNoXzF3b3JkKChycyktPnJzX2JvdW5kX3Bv
cnQsIFwNCj4gKyNkZWZpbmUJUkRTX01QQVRIX0hBU0gocnMsIG4pIChqaGFzaF8xd29yZChudG9o
cygocnMpLT5yc19ib3VuZF9wb3J0KSwgXA0KPiAgCQkJICAgICAgIChycyktPnJzX2hhc2hfaW5p
dHZhbCkgJiAoKG4pIC0gMSkpDQo+ICANCj4gICNkZWZpbmUgSVNfQ0FOT05JQ0FMKGxhZGRyLCBm
YWRkcikgKGh0b25sKGxhZGRyKSA8IGh0b25sKGZhZGRyKSkNCg0K

