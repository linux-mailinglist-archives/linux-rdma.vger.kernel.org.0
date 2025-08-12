Return-Path: <linux-rdma+bounces-12679-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13063B21EA3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 08:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A0C7A9A15
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 06:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02B629A30D;
	Tue, 12 Aug 2025 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L+8uib5Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZmxrhJmc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE2286420;
	Tue, 12 Aug 2025 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981747; cv=fail; b=FmcUw64q4C99aIX6UVecrC6yqM64VGDMrj+vdlG2JMaO2MM4krZjTbYhD7qHLd3K6WFD9apbVQdCskuprcy5R3KtNE5sMg2SHCtEN26mv8KxlYJUeTevoNfHli++QsbzaD7xdGDd6eGwN1Q+20ZAdk2/Xj9yTqS3XFesb9z5dyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981747; c=relaxed/simple;
	bh=hq05hmc0Pob8N/NLKwLwxTuW52PGSkGR/FSAMqwb5Ac=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PbFqxS5HB7VreHBxdXNnTC1oBM3xARR7St1i0AR4hi3I5Ok4Ye3NP7KJSn32h/nfpZh8WRw2KqOYZjKY8JqnScexRp7Wu2cAAOczLmZJsbhzQKriQwY91QI6TwfqVANoESTbiqVAdq9upM5RnQ7C/v0PkPAIC8d4PDlYiozjMcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L+8uib5Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZmxrhJmc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5uMVR015884;
	Tue, 12 Aug 2025 06:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hq05hmc0Pob8N/NLKwLwxTuW52PGSkGR/FSAMqwb5Ac=; b=
	L+8uib5Ylx3uMLtWclZ0g3TuPudj5S6rpxPx3k/AL7tUrgsK9S7203v4ckE7mTSA
	xqGDOX/rhSbPjpTEbQSBZTUQV3tGiSHxZ5b/uZb9l3Wysu2lqTA8D8N520k1wiVh
	2Z3TE+PByFsIloXr+Ik3OaMQ0QcjWpcYC1Ghkzy/8C0gxgD8CToUmtDSkNcac5XN
	DsrQGQCK46Pmh/oF8NEYqwCSmcmYZA8oKRrE4a0ZKgRSCBhm+yZXQOBUUCFmb2pj
	VdrVVwQh8yfPy1xeR0Gk9Q+iFrvi0u+dwzjKyLUzW0GpSz6QC4xUDznjEmE4b4tu
	RvNFaAb3WiGeGvXWrVJL/g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv40w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 06:55:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5AAxk006338;
	Tue, 12 Aug 2025 06:55:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs9chc5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 06:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7dhf+KkA2uXG1vJzMbkiJk6f0R4djQ4DvSjKBnlkUgRAwqnQtUa1SB0rKoLn6TL+EkIK4B3hkE2RczKvBWTmRBgFcb95cDSyeOPHJU7aEs9CCScPY2xN0mTi2smyYnBK8kFcTS0jMrOdD75fLtMBDZs/iaaXemmPhPcQ04gbtIWuxpz+k7+jPqA9ERi7vZ1PnQbD7fOf7kkOMUekEs/u5FI8NiIWtIqkTWl+OTO71MBZAPrVfJ/XwA12ED8vr7RHfb8T7VMyfQrDz1nyDR8ncxA7rql8/goiM7wxyeOp34CpR9JT5CtQ9NsNMa8vWcKFj3JgC/rk7oFCIQ77nOCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq05hmc0Pob8N/NLKwLwxTuW52PGSkGR/FSAMqwb5Ac=;
 b=oq0/bXOU+ZL5LsnJFQ9r84loj3Zfwwr67bhhEaPky/n1+gdYXMnwvmuKXjmONEiAVHprfA1zvMxwSjkGmZCgaiWkqKPB9YxvlhFkQbey0Jl9pozAbVaTi8th9juNlAAqbHTfwWzSuX+Rd98/iQrP89zudRUMy4TAVYL3BlSGSykNfwJRri+nE0vuOplDClPLeYT+raR5z73Wug3vrsrP+HKbNmBsk4zcVuWOo6BT1258O1DZ8uAiOCqkfV+ZiQbJslZqJHtOkaE3rPQgjzRYf+jWs5jFDKtVZk3MMxNS7R6OMWgomJ6z0CSjCZR8hnBHYtekWt7GlJJ4oCSCBT+QBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq05hmc0Pob8N/NLKwLwxTuW52PGSkGR/FSAMqwb5Ac=;
 b=ZmxrhJmc3t450zY9FOOFcxkehvcObLitL71pHjLjdZBz4rNCA0wXWFE2llHok48BlCuka93NvsaV40Gng6HM1Bg5O0aXEhXgEmVJjQnWCqFn666umJqvqyqz4xGBxBRW9QkyEbqvSoSJUo3wJVQb/f4WhGk0kbpvugacM7TWC5k=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 06:55:32 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%7]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 06:55:32 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rongqianfeng@vivo.com" <rongqianfeng@vivo.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH 2/3] RDS: remove redundant __GFP_NOWARN
Thread-Topic: [PATCH 2/3] RDS: remove redundant __GFP_NOWARN
Thread-Index: AQHcCcibOdutCy07EkiAn+XDDGWdyrRel5kA
Date: Tue, 12 Aug 2025 06:54:56 +0000
Message-ID: <112c31733efe7db786a37cad9113c7292b7c1bdd.camel@oracle.com>
References: <20250810072944.438574-1-rongqianfeng@vivo.com>
	 <20250810072944.438574-3-rongqianfeng@vivo.com>
In-Reply-To: <20250810072944.438574-3-rongqianfeng@vivo.com>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|CH3PR10MB6715:EE_
x-ms-office365-filtering-correlation-id: 74ca1b6f-8d1f-45a0-7888-08ddd96d25fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmtNYU5RcVZyaE9ub2l5Njk2cllWTGswY053OTJNL0hlT2ZWdmJEdmVHTDhU?=
 =?utf-8?B?WnBBdUVqbzZ4NkpOVkpEbHJRb0NqYWF4WXF0M1NVMk9LdEplTnBxTnN6d3Zw?=
 =?utf-8?B?cTR3bWQwSC9zeDhWR1ZRN1F4UFhLaVRhc3pjU1l2MXM0S0FUTUxTeFg4VGRt?=
 =?utf-8?B?RG1rSFNhLzRpZk9vK1RNczBYTHZGVHF6VTVmY0JtN2RMaDJaK0owSnU3R3NL?=
 =?utf-8?B?clFVYWx6Rk11a3UwVlA3Zi8vSFFyMklIc3lYdSswSlB3TzE2RkgyTGNuRURT?=
 =?utf-8?B?M0VydERHRFF1c3NDWGN5ajVCQVV5d2l3L0R6T3ZCUmhyU1JTRkE4YW91ajFR?=
 =?utf-8?B?Q3grUUlJTU9POTltc3c4TmVxUjM1SkRWTVd5WjgwTzV3M1hoUVhGY053TkZn?=
 =?utf-8?B?RDVUMUhRUFFqeUxLMGxML0k4YVVtckZmWmhuQ0FKRXNJUUtwQlNrcXBFSU1Y?=
 =?utf-8?B?WkN4eVh3amdEYlhMc3VBUVFMMjc3YWtVNDR5M3hnbm0vYjZndER3K1pnT3Zh?=
 =?utf-8?B?dFBLNE9ianhPazNTQklHQ2l3dXdYNEZSZlcwZE9yejZHMGpodlVPdS9sUVh6?=
 =?utf-8?B?Sm9keDl2Zm1pb1ZIMDM2Rnp3bkFuQjMvRXlxY3pGWDNlWnZGaEtmNlZjcHNM?=
 =?utf-8?B?d1U0Y0RSeDVCYk5iTHdpbDJUUHFNRm16ZHR6eEF0RHJuNnlrYWdYcTRsbjBY?=
 =?utf-8?B?ajZnT0FENEdxZEptdHJYRzdwTHgvRGRlNjRIa3RZeVJndUdDblBxL284dWF1?=
 =?utf-8?B?cGtGdWtRYWdJVktTeTZHankvNzRQQ1NpdDRPZ0dEc0w1K2MyZFFWN0xtUHRz?=
 =?utf-8?B?ZzU0UTcwOGxtUmlXeDhyd1ZEMjl2c0pObTBiQWtsUFFHNEZsTVZhZEVpY1gy?=
 =?utf-8?B?V0M1djZnY2dyckZCMkVZamFhbGNVeFpJMTlsYXNuSXlCWkJDaEtKUEJxbmpF?=
 =?utf-8?B?TnVMKzZaRFJ3OVhvQWNra3N3MHZNSzFybVJGMXdDUy82RGxkd1RBQStrVnd1?=
 =?utf-8?B?Qm8rdkxyV0R5ZlBQU0RRcWh0ejBmRWVHYTFXRGhlL25jcSs2NGVvYjRSbVR2?=
 =?utf-8?B?U1M5WE9FUUsrdzR0QWE4R2M4YUZoSW9mT3ZJZG5jTkpEKzlURU5vU2hNWXF6?=
 =?utf-8?B?bGpjdTh1Vkx6b3hTQWlrcFNDVlhZY3lzV1ZzMkU1ZFJHNXBHVk9TVFloOFZk?=
 =?utf-8?B?VTVLV0JHOWpRU21uYWkzRm1SRUJva0MvZ0FCUDFzZTFmdVdmelVOYWdyQXB5?=
 =?utf-8?B?ZzVsSUcvNGF5aGRuQXpadVVWZ3QrcDRZMEJZNDhpZk9rUmlQd05JdWowdGcw?=
 =?utf-8?B?NVRVWExvLzVtbms3dGJ0V0pOSVRhNk9lTnJUd3NIWlZ0TXN1U2ZMa3ZaYUFv?=
 =?utf-8?B?M0YxY1c0U1pEZ1lEQytwbDZGZlhxaGJ5emgwamJEV3FNVGk1TFREYW1TU3Nv?=
 =?utf-8?B?aXdHcE1COUxaVVh2WE5ldDlyMkdLb2RKSDRuNzZkOFJSdFR4bVdBSEhGTERk?=
 =?utf-8?B?Ky9oenQxeElDT3l0eHRMVC9ObDhlbHI4blpxUkJERjdzWWR1Z3VFMWVOc3ZN?=
 =?utf-8?B?aThxSHFDcWt0ZWdnWnFMTkVNamEyOHhkY0RacmxnYWNRWmxFV3BCNThqUzlt?=
 =?utf-8?B?WnFsZVd4RytPejl6KytpME9oVk1yVGsxSVUvMWduMTRMZEQwMjN6Yys2b04w?=
 =?utf-8?B?U081TnR5SVFRNUhFd3V5ZXB0eHV2RC9VY0pVTDBWckpIVWNYbnpiUmxxcEFq?=
 =?utf-8?B?Q0dJZ1NUVFAvVEdMZnk0VFh3ZG5LVlJGTDJWcThzWGYzN1FKcWJIU3BWZzZh?=
 =?utf-8?B?dlkwMWl3b0lBb3REZEZabitkeExrMHJtaGJuU3RRQ3dPOWg1NGNZNm9xd2ly?=
 =?utf-8?B?Z2RuNjdhVVVORjVrVEhmaGtGTnFVd2hORU84K2YybW1OM3pmdW5xd1ZiU2xr?=
 =?utf-8?B?Y3EzZUN4bWg1RTF6N3dackRNdkFuMmJ1cCtNdktWS0VwUVI1enp4U1BxbllJ?=
 =?utf-8?Q?ip2BOU2ahKuWRMYTfwGFDfoT5bW9dQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTh3SlZwaERnNkZTdDRTS1B0ZGo1TTlKY294ek5RK1FURWRFaGFDbHpOaEtS?=
 =?utf-8?B?ZFc3RUpZclFid1YrY3RhNFNiVW5mNjBaRTVZS2dScFNoNFpoc25KZVBBdXp1?=
 =?utf-8?B?dGJXa2FBeTVJTWxCZlNVekk1SzNXTFJTM2dqeTFrQmNPY3ZjSW1WNG1aVXRT?=
 =?utf-8?B?LzlZald4c3Y1N1c4N29MTS94RjhWbFA1UWhLZzRmTU41VHh1TkVJeW1BaVZE?=
 =?utf-8?B?OW1NaGtsUklUVmNUSUJSVTJaQTkzWG1FK0tqMEkvcTlBK2U2UzU0a0M3aG83?=
 =?utf-8?B?OUVyU0NvZis1VGt5ZDFEdDhOSWRHQ0dORXJPTmQ0MUxqTXg0Z3FRWmV2RGNB?=
 =?utf-8?B?VHpERWtCeVZLZWFUY1VDbGZINkNaMXhmQWxxSVViRFM4YjdLVHk2S2ZVT3h6?=
 =?utf-8?B?QVVjTER5TWxiU3BMbWtBN3QxS2VPUmZqbCtTaGpyck5yUXV4VktIOWJHU2FL?=
 =?utf-8?B?blBZQjJHeVlGNVhnWWtwdGdjLzNHUk9UdEhmK3laZ3I1MXdIV1VwZ3dkMmhi?=
 =?utf-8?B?VTJaV2hhdm56Ym52bjdFbWJKL1p3bytRUUlnWmR2TUZSOGx4RzR6akxERFVv?=
 =?utf-8?B?WjAvcTluSkRTczJvU0dXdTRSSkEzSWN1UGVlaXk2RGJjOU5RejBTVVNLVnlS?=
 =?utf-8?B?KzRVZE04VWY4aUUvVGUvVTZidy84QXh3U0hselVYcUkySlZBUUlIWk9aMGxu?=
 =?utf-8?B?dk5xeHA0aXUwWkF0TVJJRDhvdmhpZFRLSTRUQzZUd1h3VlQ1Qm9WSDhrbDNu?=
 =?utf-8?B?dXUwTVA2YWd5UmprVWM2YmRIZzRFckcxVlp4Tnl6RTVLYXJ4RjhoMk11S28w?=
 =?utf-8?B?UWQ1c3VFVEVGaDVlUkFuaXkrejdyZ3M4L0V1TjQ0aHNnVHNUK0IvRW1EdEth?=
 =?utf-8?B?b3FEaHYzUnVhVk9oZHVnb0tLL0FyWWdmTUxKc2sxUUw2UitQeXBqTUtBc1JM?=
 =?utf-8?B?KzlhRmJhQjN1VGltVzNYdjB5K2pLSktMdjV4N2ZnMmR5SkZxQ0RnL0xoYUN5?=
 =?utf-8?B?QTROYUJtMFRmeFJLQUt0RjNPVGExZHhaeGhnNHpmY1FydzRSR1ZBNmx6NUVo?=
 =?utf-8?B?cTNrdFRMUWNQTGhUNmVjU0YvNVphZDhjZWpINVI3WHhYamlFNCtrVm5mckp1?=
 =?utf-8?B?a2dHOU91MDdmU0FiWTJIaTdGUmFLZXo0aVFSOXIzM1VGdXVrSDVYU2VQUUFu?=
 =?utf-8?B?Y3MxVkErVXJPTU9rWmUyWmV4WDB2WHJqbGhFVGc0NTVpR29NTEhOS2RXOXN1?=
 =?utf-8?B?UkpHRGNJakZOOU1XTDhQa2JsZUQ2NU8wL3gxNTdNZFlKbHdyYkFoWGQxNk8y?=
 =?utf-8?B?aWMwRXIxcjZQeExsY3hVd09Odms3UXRDOVUwbyt4dk1DT29uakV5TDRHNWRZ?=
 =?utf-8?B?VFduMVBVWWx1QkYwMHh5dzR1Wmora1VkcVZ5TTh4SnRpdE9td3FSZWo4OG16?=
 =?utf-8?B?cWdlUm5vSEZPdGFFcjJSallmdTZCcCtWVFVYeGd3UEdKLzNtdXFxYitGZ1h6?=
 =?utf-8?B?ZFdENllXVml5ZXdHZzErdmgzN2FxZTgxckZob3dMVnlBMmgwamJ0Ujlpb2hI?=
 =?utf-8?B?L1FDcXRwclNlWGVBcW1kU0dFSjNPQXVWUVJINDR4b0IxbWtKbWdNYWM3ZGty?=
 =?utf-8?B?OE5WSE9GaDJ2ci84RG0rMjU4aW04emR5aFZCdHovUE1pbWxnK0k5bmdKM2xX?=
 =?utf-8?B?RGNjc0RQYkRLZ2k3VkRzRDFPVnpkbDQxNS9BLzhwTVVxOTQ5RGVzdlNxT3hS?=
 =?utf-8?B?T3lwTjZzUEl5VzMvSkUxT0hYblJGZ2p6VzNTSWtJWUNha21rUkdNZk9nR2hH?=
 =?utf-8?B?bnlvYXN4SlpKRUFCSUg2V0lybHlTQmpudTNyWlRqVUM5bVlHUVdYMjR5Wmdj?=
 =?utf-8?B?Y1cwWVdDQVgrOU03elRZYklsV2NtdGtIT0lCNkZGcWRya2t5eCtPM2puYkNL?=
 =?utf-8?B?TlM2WmNKZUQ0a3VMT0xOZlRvOEFoK1RNTnpJNW51ZzBOaDZuN2VJVHZueUt0?=
 =?utf-8?B?NTM3QUdYMkZyT0ZOZmZLbnpFUmwvMDI1TlFZOFdycitybGVVbXRyY2ZzY2k5?=
 =?utf-8?B?ZVlHSDdOZWovMmlQTUxtN0ZvcDN6SEx4eXdPNnN2SHF0eHo1Z2NrVWFIRFRy?=
 =?utf-8?B?NFNqeG9ySEFaeEdCbCttZTBkT05kM2MrZ1lwUWh3N3RPUG9WMDBvcGJMc1ps?=
 =?utf-8?Q?T10LH2bevVzU7GKs9lPcfNU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD870E5DFB501F498010EEEF35451379@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GTFm5lITkkwj7oiQ2Akbyftu9Opjo5qq5lLh20sC30upfbzLlHjtJI8oKj9r5M0Cmf+mB0xgnTijwDUIZdXOrq+2FI4neOwtwtM/CZ/lL4/rehPjZSV4SSebs4rpF2a/CDtXJmJf4HRXC63K1vtKpmaheK8hFtaDKZXAsWZtm/ioYTP3YdWXq57LgcNJr1rOqMDxVeUQyd4OIhl0yS2JvPFWWZdE3E2ODQDK4OgejwnSiVovp3vLgZqzBCy+WBtFFBKpzy6N/BrVpYpoi9oh5nZIhQaE9IiWMbC+q1ZSyQZ6rfFdq+g2/MCOCcWByB1jh5aDQ2ZJ/OWiR14jaxbAF1KYIsdeV4bnWZp+eMluD/DvhpJ1yj0L2fybNn/za284MhQSvTbv1dHqtGdiUC0LIFVrgwUbcDuKfRjqpKhXAL6G4BNaN3fwRtp0Xv4dZBEed8kuHvTxW6SkYoSwfYivfR54lM9FpIG7z/tLMUYw3hVK0AjjfkgC1RZtC816Ye8Pux4yNdD+SdWOWcEb/BIzX3YMVP09KrzuDXgK1Rwxn9paTn4G8ENrPvxRJT1B3gMy9VQDUSH9vIuCw0B+vy4McG24N17PAS5ZVRvmxPFgZa4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ca1b6f-8d1f-45a0-7888-08ddd96d25fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 06:54:56.8011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1pC2JrLYEn0lRnIC2uJuUseaN8YHaebfoaKclnm9pioZlPQRnb2v4iSn8LU9QPUTCVN3PQjsyIBYRHDKWPYqhKtypsqFxN1iisD18PPkDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120064
X-Proofpoint-GUID: kVDIk9PvzwqVfNHz57GhmX09Uf3e5uRQ
X-Proofpoint-ORIG-GUID: kVDIk9PvzwqVfNHz57GhmX09Uf3e5uRQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDA2NCBTYWx0ZWRfX7zX7v5g7QWqy
 aVXNaW1a0PuEX/T1bTagVMQTmXw5VLPRdmaMfbjFJAeyjOKLZapgH6Tz3JJaC0Xkpc/usduUszv
 g5SwX1MF+iUdGLzM3Fa0djRD9SaFgvBGeWGiarmep8Gtt5eUcEkno07YlCxzczt/nkWY1LpEbf2
 E00Kj9M92kGprHLb51+X7iy8JA2IYVdlKY1jeXH26+nOFZidgV90O/Au5es+afGjXcZ3V6GamqK
 FNzN8JGqhMihf4/1ZTjfqSRYfWuBe0BqNmreQdDFEMoPu9AZz953d6C6QOHnZ6XZRlxYSvPpLHE
 wXbSRd8CGRLv8JlE9StnD290R90YtrdWVefww9onxJ0Wop3i9zS6Ou6NCWOFqYYUZuFFIJtrke/
 giUVNlymzCl85IuI6BVGZsPvyyEDoGO78fl9fQ9zK4TNOGzTL1I1ft7q0tTWfTpI+i6LihNM
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689ae568 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=1WtWmnkvAAAA:8 a=yPCof4ZbAAAA:8 a=EJ9x7rn9y0WBZkFUasMA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13600

T24gU3VuLCAyMDI1LTA4LTEwIGF0IDE1OjI5ICswODAwLCBRaWFuZmVuZyBSb25nIHdyb3RlOg0K
PiBHRlBfTk9XQUlUIGFscmVhZHkgaW5jbHVkZXMgX19HRlBfTk9XQVJOLCBzbyBsZXQncyByZW1v
dmUgdGhlIHJlZHVuZGFudA0KPiBfX0dGUF9OT1dBUk4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBR
aWFuZmVuZyBSb25nIDxyb25ncWlhbmZlbmdAdml2by5jb20+DQpMb29rcyBwcmV0dHkgc3RyYWln
aHQgZm9yd2FyZCB0byBtZS4gIFRoYW5rcyBRaWFuZmVuZy4NCg0KUmV2aWV3ZWQtYnk6IEFsbGlz
b24gSGVuZGVyc29uIDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPg0KPiAtLS0NCj4gIG5l
dC9yZHMvaWJfcmVjdi5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy9pYl9yZWN2LmMgYi9u
ZXQvcmRzL2liX3JlY3YuYw0KPiBpbmRleCBlNTNiN2YyNjZiZDcuLjQyNDhkZmE4MTZlYiAxMDA2
NDQNCj4gLS0tIGEvbmV0L3Jkcy9pYl9yZWN2LmMNCj4gKysrIGIvbmV0L3Jkcy9pYl9yZWN2LmMN
Cj4gQEAgLTEwMzQsNyArMTAzNCw3IEBAIHZvaWQgcmRzX2liX3JlY3ZfY3FlX2hhbmRsZXIoc3Ry
dWN0IHJkc19pYl9jb25uZWN0aW9uICppYywNCj4gIAkJcmRzX2liX3N0YXRzX2luYyhzX2liX3J4
X3JpbmdfZW1wdHkpOw0KPiAgDQo+ICAJaWYgKHJkc19pYl9yaW5nX2xvdygmaWMtPmlfcmVjdl9y
aW5nKSkgew0KPiAtCQlyZHNfaWJfcmVjdl9yZWZpbGwoY29ubiwgMCwgR0ZQX05PV0FJVCB8IF9f
R0ZQX05PV0FSTik7DQo+ICsJCXJkc19pYl9yZWN2X3JlZmlsbChjb25uLCAwLCBHRlBfTk9XQUlU
KTsNCj4gIAkJcmRzX2liX3N0YXRzX2luYyhzX2liX3J4X3JlZmlsbF9mcm9tX2NxKTsNCj4gIAl9
DQo+ICB9DQoNCg==

