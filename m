Return-Path: <linux-rdma+bounces-14680-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A6BC7C04C
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Nov 2025 01:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C24853655C5
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Nov 2025 00:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA949202F71;
	Sat, 22 Nov 2025 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VCT7LPCg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IavsS3J2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71529CEB;
	Sat, 22 Nov 2025 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763771779; cv=fail; b=g2tFS4qxylsZHfjevxPpFsFnCpPbTXkyET77xhk7owoxWf+1yTJABuFnokJ8XCXyfZXADPqdl8atPMWI4HplyBGfHZPrLrHSREvknhchH79bzqaaTnoaSfeLS31Vv/bnSRkHIqeHk61yGP6vuNbymiwuDV0bOD3ZtvpY2EayZ1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763771779; c=relaxed/simple;
	bh=SZiM6YwI+jxD7aUuJl/79rnrK8X12JLXgnzBqaoA6/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cEAbaHcXxlg3j8wCUQfYHLzV0ErWgOhCpuC7+d6tGXKIrbub8W5SvXIn5pfK6Vr41ZfOGifSytzNavKf0NFxJ/YYy+qjClglmB9uzHHyyjIYTcaAiw8TA7XgZkj7WHCB7cex7b7arAC5vfTP2w903W7NW6i6KmFs4UWl0Xhp8TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VCT7LPCg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IavsS3J2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALMgSeJ019680;
	Sat, 22 Nov 2025 00:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SZiM6YwI+jxD7aUuJl/79rnrK8X12JLXgnzBqaoA6/k=; b=
	VCT7LPCggQ+lITsLrdpQn+HP3G4qWC3tc89HK+kttusYwtI9fmEKie7XsQFOzca5
	UTA15m7fqt6HSyiqPwGX7QI/abmla1jSAIzbKESlDLGyx0vL+Sdl+p2qRlZGitot
	QSbnzVxMHcBDfFTbns5ksMdGxHxX9cdhxh4xUhQK21ck7VFHfouVUIeljYjjdkrN
	/exC9iBjuv92hjlaRVLxuGlJ78EBo9CU9YpoOi+yw5Kl7NuaJ2ZT6ekYbvIZqv/9
	EcP4MlXPszsHoH7BDSFX8NilzNFqd0sps3CQXvKDbvCYPO3kk4rancePX+FXSGRA
	uigwVa5SlyvZo8aErack4w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej90d2r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Nov 2025 00:36:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALNWcNr002526;
	Sat, 22 Nov 2025 00:36:10 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefye9de2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Nov 2025 00:36:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIHfjvGLas3x9hr4d6BFHSutcfw6lC/vVKz44OVGbFuND47RZzSWUQdVb6Vmo1FeXTOghUwo4fIfiqzWqMTEIdXFpr58re8yHupuJyPbXhYGBNjME4CaQWpjG0l7elublDTw7A5CgfoYi3vVqCF3LZ1RAqLaedHagmvLcrVyviL5kfi74/ZFi4ORauEQgCcKkTKH3FD3m7xmor4wpg6ABzIUknsD9ZYht4CCkwwXQlwNzJs2+NAqko33YV9pyABAYKqZbNcmrxVbloL/6oEiWBPo+DJPPSpGA6KxxWmqHC/XfPRMohbcCpisobsmnfNj463zxUW59Z/znwSXSC7Huw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZiM6YwI+jxD7aUuJl/79rnrK8X12JLXgnzBqaoA6/k=;
 b=mgQkPqYcvbjdMRmEutmTn5oC0M8TqjG7J/6eqmuTLC9OfkxEuDuMrjd04BeWeaRbdjh1o7BzGObozzK8/uw+pdKEyWwgkvpZqVjMcROw6U5SUjAS8mu9aaSBAbbFEtRHDgD64H5Yihpr2tF2sSHcel7sZSsv4mbv5Pz+SW4MKgL//xLeiuS4ugxHhzlTiIna8AyOHzpqT4bQIgP65pIeTuWkn0PzgYBKLHL73eO8RVK7s9bCBb4XubSgX+xYCiMr0b0+Yly1rlxzmXvSpQDk0xGaJ1oOiNAu5lpemfIc9GuDhvmhhWmEDnsjMLLj0sOpo0O7VHippSEeAn9hGZsFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZiM6YwI+jxD7aUuJl/79rnrK8X12JLXgnzBqaoA6/k=;
 b=IavsS3J2Fw0IbpMfPmlEj5sx2d4jOLm5DB7SsjdmN+UrHWuFr1Ped8+qI0oQukK5VFgMQZJ+te2afqvSHxkBL9y/nJuGJGBL85LXkBQqjKcXM5RE7rLXJedHUm54ZqWdnYgBWcFr31Sl1Y3ZaEavOHHlIRS8CVepz6r5YsugOPU=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 CO1PR10MB4499.namprd10.prod.outlook.com (2603:10b6:303:6d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.21; Sat, 22 Nov 2025 00:36:05 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9343.009; Sat, 22 Nov 2025
 00:36:05 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "achender@kernel.org" <achender@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] net/rds: Give each connection its own
 workqueue
Thread-Topic: [PATCH net-next v2 2/2] net/rds: Give each connection its own
 workqueue
Thread-Index: AQHcWAAWdfuWP4i+gUqCgxBZ1sUrlrT7ZRuAgAJ63AA=
Date: Sat, 22 Nov 2025 00:36:05 +0000
Message-ID: <350dba377281866c153b95b4a03c8b6c998b5d8f.camel@oracle.com>
References: <20251117202338.324838-1-achender@kernel.org>
	 <20251117202338.324838-3-achender@kernel.org>
	 <98bbac96-99df-46de-9066-2f8315c17eb7@redhat.com>
In-Reply-To: <98bbac96-99df-46de-9066-2f8315c17eb7@redhat.com>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|CO1PR10MB4499:EE_
x-ms-office365-filtering-correlation-id: 571e6915-94df-4089-419b-08de295f1f4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VU9ySGlJcnFUTVBZYys3cm9XMWltR25ldmxCOTRVS2wycU1wajNyR3Ara0R0?=
 =?utf-8?B?WWJjY3V4bjM0ZXRtTEU1WDdzazgrMTFsV0FTUEcwM1J1eHlNREZTTHhjWXAz?=
 =?utf-8?B?ZHcyOCt4R0dXV3c3OVdwZGRFam9qWGgraU1WS2lTeUpjMEttaGFWNHV2eDFK?=
 =?utf-8?B?TlV4dE9RcFB5VEtCQlpnTnJVaFBNVHI5RzFCcFVTYmg3Qks3aURUdHF0d2Iy?=
 =?utf-8?B?b21LT0p0TnZmb1pXNmNqaEVpdlFrTjBNb0JFSVIycXVKQUdlekF1ZUZDQ2JH?=
 =?utf-8?B?bEx5Z2hBOXNVR0hWNzdwWFA4a1NXVzF2dmlUL2VvZlRtMDNaZ1pLRldnUnJx?=
 =?utf-8?B?NTJRdUtnSUJ2T0NQVS9EL09zOHhhdzNrbmRRNEQ5cWVGdUE0SDJ5ZEh6QmhD?=
 =?utf-8?B?dWN2V3VTQmlEOWdOalN3NTk1dXJZVXFuOFJzVFpRdUtxVW05dG5IaVZwOGV6?=
 =?utf-8?B?WXVLQXV6cmpzdUdBWUQ1MUN5TzhPRDB1ZVdieFJHcTVqOHFGUFBzZHVQbUlu?=
 =?utf-8?B?WkF5ekE2T1FuczduMlFxWFVMdHZLejdVaStleG5ZQ3JEQ095UCtkbW5yU2ow?=
 =?utf-8?B?c1lqdC83bkpFMTI2V0xGZWd4M0lhNWZQMEpuMTRNVU9TSVl4cGhSL0Y0ekxs?=
 =?utf-8?B?eVVzM3YwbnF6bE11K1JVM1lMdllrSCtiQjZIcUNjRm1COU03LzQxd3EyZ0lT?=
 =?utf-8?B?cGx0R3Fla2lWSzNNOTFpbUQzM1dGNklQalVxcU9rSkJGbDQ4ZjZDM21wc3Z3?=
 =?utf-8?B?bURDd2V1QlBMTENFRCt6azVNYnlBTjRCdHZxVUFyeWV2RUFqS3llR0d3Skdv?=
 =?utf-8?B?VURFVU0yUTIzZkFITXo3RDlUTVJXdG5SS2RjQmxVaDVuOHpUdW5zK0k3dXZq?=
 =?utf-8?B?Mmp0V2x4ekxTRkZoZi9DVnZ3cWlMVWQ0OVFKd3JkWnZoV2hLQkhaeXMzOWpZ?=
 =?utf-8?B?dzYwenNKREVFZzA2TUFYTWV4YnMyVytUd1M0UUw3YVhwNUdnYTlJT0ZPK2wr?=
 =?utf-8?B?bXJVaDVraTVkMjhScWl3UWdDbE9jZjVLWExIRzZ4MjQ1bHVyeCtROFRxS2c5?=
 =?utf-8?B?S0lQZUlzbWdmM3JEdVVCcWI0eTBpNXJ3SXFrTGVkbVNEa0daVUkvOW92UWtS?=
 =?utf-8?B?WDRDSVNLYklObng2OEtxNEhEMlJocnlhNlVsNVRIbHlxR29zNTQ0WHpqOEY2?=
 =?utf-8?B?bW1JRGIrTVU5S1BDWE95d2hWeFM0VkhpNmFJTmNacW9vUE1jMXNVc3BBbG5K?=
 =?utf-8?B?TC9RdVp0T0U0VXlGYklrOUlmWHR5aStsditwZkVHajFheDlOWkNobXVsa3Jj?=
 =?utf-8?B?Qi9DdmkyYmJZQllXaGxJeTQzam44TG5Ga3Z0OGlqVjJ3VGJxditNR3lTWCtn?=
 =?utf-8?B?eTRLc2k3cm5sa1UrTG90UFE5K0pCcjR5Y0NyWXZ3MVJzMXVjc3hwUkR4YWNG?=
 =?utf-8?B?Kzd2a1Byd2VJMUZSb0NjcytERXVLVjk4SzBFRXhET1hZUkloYW1xVzhXb1Ux?=
 =?utf-8?B?TnM0b3pnT3R0aFJzSVROZmM0S0FOeXN0TVhacG5xcGNWWGw2VjRwU1h5bW96?=
 =?utf-8?B?Q3U5a0xMLzVoSXRtZk5jdjNpRE5oRTE0cmk4S0JPT0tDNHZZQ0JLQm1KVzRq?=
 =?utf-8?B?RE82aGYvM3ZlMUlJZHdCTW5mUFRRMklIZWRQRElqUjl1NVRjSGM0dHE1dmNH?=
 =?utf-8?B?OFdxOU55RjdkUnpPK0JtdVd6ZDhxdDE3NTFQUWRlcTgyOS9HVy9hQXJLUFNS?=
 =?utf-8?B?SDNCZEM2TGtKVGhWRlV1YnRobDJtOVUxd3lLV3paczNzdUhndTFKVHVwdDN0?=
 =?utf-8?B?OHNoZXMyZ01oaUdqazZTMThVTEFpNmwwNEh4MmlJMmt4Y1BDbXVKZHFRd2FN?=
 =?utf-8?B?S1BJck9SQnpiNW1MUnNSYTN4WkZ0QTM3Z0t2em1PN0NiTHZxV2RZbkRGeStm?=
 =?utf-8?B?SGlhT1VtNldUZDhMK2Vva3FyZS9ybjkxVDdpMnlVeGVYbXlsUE56eFN1Y1N2?=
 =?utf-8?B?RmhEUytwTS9RNFhBdFJHOUsrcU1rcjd2NmNVMzNBOUppQ1VUWlBqdk9YaEdi?=
 =?utf-8?Q?JLkTC7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RU05cXZnT2ZCeEduRmcza3lkTlZJYTJlQThabEYzQlk5b1MzdlhqK3RwOFlq?=
 =?utf-8?B?bEk3TjR4Nk13MUFnRXczNE1yZ1pPdFFzWDVKT2ttYkVkNnY0b3V5QTRFWC9u?=
 =?utf-8?B?WGd5UERFSU1PQXdVSHJ0ZmxDamVaVk0wc0I0TDBuSC9USG5VTnVLeFp0dkgr?=
 =?utf-8?B?dFA2bS92cEdHQXRMYkFPTUpJaERZcy93L2NCd25KZUhqOFkxY3JBdDJFcDNK?=
 =?utf-8?B?NHNaTWJHUXd0cDRPcXA1OTVCQXVrS2tBTWJ6QlpaUzFZUFc1cXBvWFdSWThJ?=
 =?utf-8?B?VkNWT1JhSWQ1T1VPMzZvS3M3cGxJcFRqdzNmZzlJRis3Tzh2cmlFdDBRTzNq?=
 =?utf-8?B?aGJLSVR6OWFURStIdVUwVURBd2szK2IwOGNVeDZTVzZta2swZmxhVTd2QWsy?=
 =?utf-8?B?NERrRzdMME9zVytFcldJTk94blU4cG1ZcmxSbGYwVklyYmEwaC9EYVNBYVBV?=
 =?utf-8?B?VktOaWRHNjVBSm1ua3Z1bXhsbjc3UXpvUzhBeno2MnBYWkhzd043bGdjV2pr?=
 =?utf-8?B?RGFwVzEyam5VYVhyY3Z2cWU5enV6ZjdnQm9abS9CbVkxd0NSWmFkeGM3b0c4?=
 =?utf-8?B?MTBHUUxGYW5SNnhoVXVrSDhNVGdhODVCMGVjQXVjdGQ3ZUwwcGNCd2g4Rnht?=
 =?utf-8?B?V2Y0OFRGMElBRndkTXlpRWNBWGlsdjB4UGN0RVJOdE5DUStKbWxuVm4yWVRG?=
 =?utf-8?B?aUhNRnVaVFpRc2lZUjNJUFUyTnZobUpOLytmNURsaUhxb2NxWHJRcnBHREpK?=
 =?utf-8?B?ZENyVnhYbWN5cTYrS0xxREdrSHd0RDg5RHZlaDFhazhJWlRYdUVubW1TSzBC?=
 =?utf-8?B?aU5ZS1RKcVFFWXc3dXZyZzczQVY2M3dUQlRnVmx1WENnNHBoVk4vQ0dnRFB1?=
 =?utf-8?B?OThIRFMwRy9VVjlCKzV6TW1JNkhBWDV3QUlod1VWZTdIbU5HS2t3cDJRYWly?=
 =?utf-8?B?NjVBcEFsYXNBdXh0UkM4UWIwSVdHYUtReGgyNmhKTlkxK0hGMDRiWkFubzBt?=
 =?utf-8?B?cWJmWGY4bm41VDJkZHN2Yy9jMEFBOWFDajNWK3NMYy9lQW5VR2x1bmhlbDZa?=
 =?utf-8?B?dkpIRHRFOUxUMXd3MlFqSk9WOWF1Vk9XUE5acGpJZGVhNExyMU5tQTg4UFQ1?=
 =?utf-8?B?dW5WZ1MvWVk2UzVSQzdtNnpSSHVzOFpMZjRTMFcyUmlkVHR2QTh5a0s5K0VW?=
 =?utf-8?B?ZHFFditQb0svMEhtSXdHN0R3VzNiRUlMVkZRV1EzRXpqWDFlbW9sMFMwR2pJ?=
 =?utf-8?B?bUNhTXdXOGViMzNIZGhsWU9hc3BjVWxSUFBUQndYUzZiaVlTSFFVT0NXeERO?=
 =?utf-8?B?QVJmMHZWNDRyY1lseFVDVTFYWFVqVDVFSlJTaEo1OXBxakNXcXBRNTgrZjBJ?=
 =?utf-8?B?NHJrbXBHWVpFZXBRdmF1bmxWSjFKN21XU0JQcDdOL2FQeS9XRTRRVCtnQ200?=
 =?utf-8?B?c2RIeWhFa2V2ZmlZSFV1VUxZeHhUaFVUWkhySUx2OHJ4cWpJaGNueTV2dXVm?=
 =?utf-8?B?YWRHQmZHaUdXZy9zQkpMOFRVYVYzQ0wySTB0TFkvbTFUS3NEcUdtQUxJZnVZ?=
 =?utf-8?B?ejRITWxKQWk1NmZ1TUxWZkg5MkFxMmM3ZzJ6ZzNDK0xZVTlzUWpKMFI4YXBr?=
 =?utf-8?B?VVN0NUlsUmFRMDRzTWVwRHJhMzZuMnh6eWxYZDZ5REVldzJrbExsLzNlL21I?=
 =?utf-8?B?WHlLTTA0b0p5eVRpSTI1SHJ1djgxOFF4WVFLcldyRUFQMnBXdzRBcU9PdGhi?=
 =?utf-8?B?WUU2ZU1oaHhubGZiN0o4c01PdStndyszL2RVZGlhSE9wOFRSVmNqSXlDZXg5?=
 =?utf-8?B?VW40Nnh6dzZzRFI3YnFYVEhkLzB3SlBCTW9FcU1tQkJNWUl2MEljQXFZTDdK?=
 =?utf-8?B?RjFXRnpReURKN3BPNDR5cjJiVXoxT3RwTmJzYjFqd0pKV3FmOER0bVg2MEFt?=
 =?utf-8?B?eS9aOHZqR0tkeEZnTmdFR0dEbzNZa1FHNlpPcW9xVDFTc2dMOC9QMzU5WGwy?=
 =?utf-8?B?eG1uT3E5SUlYMHVYbnoySWxhWUhMdm9SYnhpVVVKWDUzTVRxTTNmV0RoRHF6?=
 =?utf-8?B?djhHemtmSXduVDQ3ellac1FWZ2k0Nmt1cVhGa1FaNXh0eWpyYitlQ3FZaDV5?=
 =?utf-8?B?eFNRNmU4TTVNcDlRR0t3b3lpbWxqSk9XcUk2bWJ3cFU5bERGN2xwSFA0SVE3?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FCD8840B1D9D04FA04E98821718CEEE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9sv3yJxTPJU+q3CtFEhJdjE3Pqn78E2myRszyjo0MmIOtlsTK4hbXAmUKa8JKUnrmceisdWk/xd/wU7HyzlTV+1D/YAYhOrvZy0GkwSrVvzC/9LCAApv11bxREk28w8vwnwRARo5yAv36THvSl2v/kpYu12wp8/Xo/d/fAlqASVh/nnP19ieg1ESdA8RtYamn4InusXD1Ly7V09/J1kLm1VSHo83NqHaaAVHbjmg4lYQQu3iUCbchpbuCK2ZzfjHDsXXx9eARJhunOP8M0JDgVY8ydeTYGMdIR1A8SjoQ45PHRIrv9O6KKMarnViMWl/qU3l99ivPVm4htOhQ5m+1RhHf2R4fGAGRLFyPnKuAW8eK5wh6Z8FcbS5jP/LwU03hv1wUTgl7okR4V9NyRkQr2SVTHVaHlGH+u8PRF0yzRR1MLxiJK8MdtI2yRFKXV5g8hoB0ywFuiOJSphRtE7rs03qKNCs+QwCAx5OyYj9pgaFCzCijZfHGh6Ua+XF85UrYdjL8d7AZ6Ev9SCA3tmf3TTdBajj39GPsZzMzjUgrlTWSOesLaxbpyXv0k581cFN0qfpSUSQwO4Su90JpdZ0jlKhreutsyK2AAZSMZqbzu0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571e6915-94df-4089-419b-08de295f1f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2025 00:36:05.6417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGGxHjU2wlqsIlTCw3wHVyMol01HmuOCoYh7m4k1U/sacptjSt8Yu2s0NZzXRkCJXOD7JDU6Tih/mXiFFsF/P6JQLPI4X58Kr+BhIpH+XTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4499
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_07,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511220002
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=6921057b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=1p3WHXq7tv6ns4FCKBIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hSzv_Pw9rp6FHoCmqrGGG0NfDvU9a2QT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX/eu6BcUozMkc
 XH5CfxALx9iToyIXll5CisXB6UQs24QoeWLGIh5uhDLzShdyNY4drKlS0gMFAO9GcnXmr9CWeTw
 rKtZLImOUX45Jg3cfsRx9ugWxR4xLYor5ZCXVc+89XAd5LJXwlvP8ZeL19EZScCpMSQKi1EFhHh
 wkCueixoLpImpqFEzzU1Xq85kDuShujXqJNuoDG9q4zC6887FMauvBbkx2KPky4IBmbe9RUBjBj
 7tmm7ouA61+0dkeH4eUYSGld/q2M7NzpqpoIyo4haL7eAr/WtO69x1w6MWE1FLkd1/AsRy4hrt9
 QhRjBYGh2TjATE06qFrynjzGmDmVba/med2oWCQwtnpVg75XcQhBY3evLXe17QbFqrEVbGCwvGx
 hVgckxEzAQjAMFDkmJdInEQB+C5fhQ==
X-Proofpoint-GUID: hSzv_Pw9rp6FHoCmqrGGG0NfDvU9a2QT

T24gVGh1LCAyMDI1LTExLTIwIGF0IDExOjQzICswMTAwLCBQYW9sbyBBYmVuaSB3cm90ZToNCj4g
T24gMTEvMTcvMjUgOToyMyBQTSwgQWxsaXNvbiBIZW5kZXJzb24gd3JvdGU6DQo+ID4gRnJvbTog
QWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQo+ID4gDQo+
ID4gUkRTIHdhcyB3cml0dGVuIHRvIHJlcXVpcmUgb3JkZXJlZCB3b3JrcXVldWVzIGZvciAiY3At
PmNwX3dxIjoNCj4gPiBXb3JrIGlzIGV4ZWN1dGVkIGluIHRoZSBvcmRlciBzY2hlZHVsZWQsIG9u
ZSBpdGVtIGF0IGEgdGltZS4NCj4gPiANCj4gPiBJZiB0aGVzZSB3b3JrcXVldWVzIGFyZSBzaGFy
ZWQgYWNyb3NzIGNvbm5lY3Rpb25zLA0KPiA+IHRoZW4gd29yayBleGVjdXRlZCBvbiBiZWhhbGYg
b2Ygb25lIGNvbm5lY3Rpb24gYmxvY2tzIHdvcmsNCj4gPiBzY2hlZHVsZWQgZm9yIGEgZGlmZmVy
ZW50IGFuZCB1bnJlbGF0ZWQgY29ubmVjdGlvbi4NCj4gPiANCj4gPiBMdWNraWx5IHdlIGRvbid0
IG5lZWQgdG8gc2hhcmUgdGhlc2Ugd29ya3F1ZXVlcy4NCj4gPiBXaGlsZSBpdCBvYnZpb3VzbHkg
bWFrZXMgc2Vuc2UgdG8gbGltaXQgdGhlIG51bWJlciBvZg0KPiA+IHdvcmtlcnMgKHByb2Nlc3Nl
cykgdGhhdCBvdWdodCB0byBiZSBhbGxvY2F0ZWQgb24gYSBzeXN0ZW0sDQo+ID4gYSB3b3JrcXVl
dWUgdGhhdCBkb2Vzbid0IGhhdmUgYSByZXNjdWUgd29ya2VyIGF0dGFjaGVkLA0KPiA+IGhhcyBh
IHRpbnkgZm9vdHByaW50IGNvbXBhcmVkIHRvIHRoZSBjb25uZWN0aW9uIGFzIGEgd2hvbGU6DQo+
ID4gQSB3b3JrcXVldWUgY29zdHMgfjkwMCBieXRlcywgaW5jbHVkaW5nIHRoZSB3b3JrcXVldWVf
c3RydWN0LA0KPiA+IHBvb2xfd29ya3F1ZXVlLCB3b3JrcXVldWVfYXR0cnMsIHdxX25vZGVfbnJf
YWN0aXZlIGFuZCB0aGUNCj4gPiBub2RlX25yX2FjdGl2ZSBmbGV4IGFycmF5LiAgV2hpbGUgYW4g
UkRTL0lCIGNvbm5lY3Rpb24NCj4gPiB0b3RhbHMgb25seSB+NSBNQnl0ZXMuDQo+IA0KPiBUaGUg
YWJvdmUgYWNjb3VudGluZyBzdGlsbCBsb29rcyBpbmNvcnJlY3QgdG8gbWUuIEFGQUlDUw0KPiBw
b29sX3dvcmtxdWV1ZS9jcHVfcHdxIGlzIGEgcGVyIENQVSBkYXRhLiBPbiByZWNlbnQgaG9zdHMg
aXQgd2lsbA0KPiByZXF1aXJlIDY0SyBvciBtb3JlLg0KDQoNCkkgdGhpbmsgdGhhdCdzIHRydWUg
b2YgYm91bmRlZCBxdWV1ZXMsIGJ1dCBmb3IgdW5ib3VuZGVkIHF1ZXVlcyB3aXRoIG9ubHkgb25l
IHdvcmtlciwgaXQgc2hvdWxkIGp1c3QgYmUgb25lPyAgSWYgd2UgbG9vaw0KYXQgdGhpcyBjYWxs
IHN0YWNrOiBfX3Jkc19jb25uX2NyZWF0ZSAtPiBfX2FsbG9jX3dvcmtxdWV1ZSAtPiBhbGxvY19h
bmRfbGlua19wd3FzIA0KDQpXZSBzZWUgdGhpcyBpbiBhbGxvY19hbmRfbGlua19wd3FzOiANCg0K
c3RhdGljIGludCBhbGxvY19hbmRfbGlua19wd3FzKHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICp3
cSkNCnsNCglpZiAoISh3cS0+ZmxhZ3MgJiBXUV9VTkJPVU5EKSkgew0KDQoJLi4uIHBlciBjcHUg
cXVldWVzIGFsbG9jYXRlZCBoZXJlLi4uDQoNCglyZXR1cm4gMDsNCgl9DQoNCiAgICAgICAgaWYg
KHdxLT5mbGFncyAmIF9fV1FfT1JERVJFRCkgew0KICAgICAgICAgICAgICAgIHN0cnVjdCBwb29s
X3dvcmtxdWV1ZSAqZGZsX3B3cTsNCg0KICAgICAgICAgICAgICAgIHJldCA9IGFwcGx5X3dvcmtx
dWV1ZV9hdHRyc19sb2NrZWQod3EsIG9yZGVyZWRfd3FfYXR0cnNbaGlnaHByaV0pOw0KICAgICAg
ICAgICAgICAgIC8qIHRoZXJlIHNob3VsZCBvbmx5IGJlIHNpbmdsZSBwd3EgZm9yIG9yZGVyaW5n
IGd1YXJhbnRlZSAqLw0KICAgICAgICAgICAgICAgIGRmbF9wd3EgPSByY3VfYWNjZXNzX3BvaW50
ZXIod3EtPmRmbF9wd3EpOw0KICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgIC4uLg0K
ICAgICAgICB9DQogICAgICAgIC4uLi4NCn0NCg0KSSBqdXN0IHJlYWxpemVkIGluIG15IGxhc3Qg
cmVzcG9uc2UgSSBtZW50aW9uZWQgdGhlIGttZW1fY2FjaGVfYWxsb2Nfbm9kZSBjYWxsIGluIHRo
aXMgZnVuY3Rpb24sIGJ1dCB0aGF0IGFwcGVhcnMgaW4gdGhlDQohKHdxLT5mbGFncyAmIFdRX1VO
Qk9VTkQpIGNvZGUgcGF0aCwgd2hpY2ggaXMgbm90IGNvcnJlY3QgaW4gb3VyIGNhc2UuICBTbyBh
cG9sb2dpZXMgZm9yIHRoZSBjb25mdXNpb24gdGhlcmUuICBXZSBzaG91bGQNCmVuZCB1cCBpbiB0
aGUgX19XUV9PUkRFUkVEIHBhdGggc2luY2UgdGhlIGFsbG9jX29yZGVyZWRfd29ya3F1ZXVlIHNl
dHMgICJXUV9VTkJPVU5EIHwgX19XUV9PUkRFUkVEIi4gwqANCg0KVGhlbiBpbiBhcHBseV93b3Jr
cXVldWVfYXR0cnNfbG9ja2VkIC0+IGFwcGx5X3dxYXR0cnNfY29tbWl0LCB3ZSBoYXZlOg0KY3R4
LT5kZmxfcHdxID0gaW5zdGFsbF91bmJvdW5kX3B3cShjdHgtPndxLCAtMSwgY3R4LT5kZmxfcHdx
KTsNCg0KVGhlIC0xIGlzIHRoZSBjcHUgcGFyYW1ldGVyLiBBbmQgY3B1IDwgMCB3aWxsIGFzc2ln
biB0aGUgZGVmYXVsdCBwb29sX3dvcmtxdWV1ZSBmb3IgdW5ib3VuZGVkIHF1ZXVlcyAoZGZsX3B3
cSkuIA0KDQpMZXQgbWUga25vdyBpZiB0aGlzIGhlbHBzIG9yIGlmIHRoZXJlJ3MgYSBkaWZmZXJl
bnQgY29kZSBwYXRoIHlvdSdyZSBzZWVpbmcgdGhhdCBJJ3ZlIG1pc3NlZD8gDQoNCj4gQWxzbyBp
dCBsb29rcyBsaWtlIGl0IHdvdWxkIGEgV1EgcGVyIHBhdGgsIHVwIHRvIDggV1FzIHBlciBjb25u
ZWN0aW9uLg0KWWVzIHRoYXQncyB0cnVlLCBpdCBzaG91bGQgc2F5ICJjb25uZWN0aW9uIHBhdGgs
IiBub3QganVzdCAiY29ubmVjdGlvbiIuICBTbyBpbiB0aGUgdGV4dCBhYm92ZSwgaG93IGFib3V0
Og0KDQoNCiJBIHdvcmtxdWV1ZSBjb3N0cyB+OTAwIGJ5dGVzLCBpbmNsdWRpbmcgdGhlIHdvcmtx
dWV1ZV9zdHJ1Y3QsDQpwb29sX3dvcmtxdWV1ZSwgd29ya3F1ZXVlX2F0dHJzLCB3cV9ub2RlX25y
X2FjdGl2ZSBhbmQgdGhlDQpub2RlX25yX2FjdGl2ZSBmbGV4IGFycmF5LiAgRWFjaCBjb25uZWN0
aW9uIGNhbiBoYXZlIHVwIHRvIDjCoA0KKFJEU19NUEFUSF9XT1JLRVJTKSBwYXRocyBmb3IgYSB3
b3JzdCBjYXNlIG9mwqB+NyBLQnl0ZXMgcGVywqANCmNvbm5lY3Rpb24uICBXaGlsZSBhbiBSRFMv
SULCoGNvbm5lY3Rpb24gdG90YWxzIG9ubHkgfjUgTUJ5dGVzLiINCg0KTGV0IG1lIGtub3cgaWYg
dGhhdCBzb3VuZHMgb2ssIG9yIGlmIHlvdSB0aGluayB0aGVyZSBzaG91bGQgYmUNCm1vcmUgZGV0
YWlsIGluIHRoZSBicmVhayBkb3duPw0KDQpXZSBjYW4gYWxzbyByZW5hbWUgdGhlIHBhdGNoIHRv
ICJHaXZlIGVhY2ggY29ubmVjdGlvbiBwYXRoIGl0cyBvd24gd29ya3F1ZXVlIg0KDQo+ID4gU28g
d2UncmUgZ2V0dGluZyBhIHNpZ25maWNhbnQgcGVyZm9ybWFuY2UgZ2Fpbg0KPiA+ICg5MCUgb2Yg
Y29ubmVjdGlvbnMgZmFpbCBvdmVyIHVuZGVyIDMgc2Vjb25kcyB2cy4gNDAlKQ0KPiA+IGZvciBh
IGxlc3MgdGhhbiAwLjAyJSBvdmVyaGVhZC4NCj4gPiANCj4gPiBSRFMgZG9lc24ndCBldmVuIGJl
bmVmaXQgZnJvbSB0aGUgYWRkaXRpb25hbCByZXNjdWUgd29ya2VyczoNCj4gPiBvZiBhbGwgdGhl
IHJlYXNvbnMgdGhhdCBSRFMgYmxvY2tzIHdvcmtlcnMsIGFsbG9jYXRpb24gdW5kZXINCj4gPiBt
ZW1vcnkgcHJlc3N1ZSBpcyB0aGUgbGVhc3Qgb2Ygb3VyIGNvbmNlcm5zLiBBbmQgZXZlbiBpZiBS
RFMNCj4gPiB3YXMgc3RhbGxpbmcgZHVlIHRvIHRoZSBtZW1vcnktcmVjbGFpbSBwcm9jZXNzLCB0
aGUgd29yaw0KPiA+IGV4ZWN1dGVkIGJ5IHRoZSByZXNjdWUgd29ya2VycyBhcmUgaGlnaGx5IHVu
bGlrZWx5IHRvIGZyZWUgdXANCj4gPiBhbnkgbWVtb3J5LiBJZiBhbnl0aGluZywgdGhleSBtaWdo
dCB0cnkgdG8gYWxsb2NhdGUgZXZlbiBtb3JlLg0KPiA+IA0KPiA+IEJ5IGdpdmluZyBlYWNoIGNv
bm5lY3Rpb24gaXRzIG93biB3b3JrcXVldWVzLCB3ZSBhbGxvdyBSRFMNCkFuZCBoZXJlLCBob3cg
YWJvdXQ6DQoNCiJCeSBnaXZpbmcgZWFjaCBjb25uZWN0aW9uIHBhdGggaXRzIG93biB3b3JrcXVl
dWUsIC4uLiINCg0KPw0KDQo+ID4gdG8gYmV0dGVyIHV0aWxpemUgdGhlIHVuYm91bmQgd29ya2Vy
cyB0aGF0IHRoZSBzeXN0ZW0NCj4gPiBoYXMgYXZhaWxhYmxlLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNvbWFzdW5kYXJhbSBLcmlzaG5hc2FteSA8c29tYXN1bmRhcmFtLmtyaXNobmFzYW15
QG9yYWNsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlz
b24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQo+ID4gLS0tDQo+ID4gIG5ldC9yZHMvY29ubmVjdGlv
bi5jIHwgMTMgKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQvcmRzL2Nvbm5l
Y3Rpb24uYyBiL25ldC9yZHMvY29ubmVjdGlvbi5jDQo+ID4gaW5kZXggZGM3MzIzNzA3ZjQ1MC4u
ZGNiNTU0ZTEwNTMxZiAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvcmRzL2Nvbm5lY3Rpb24uYw0KPiA+
ICsrKyBiL25ldC9yZHMvY29ubmVjdGlvbi5jDQo+ID4gQEAgLTI2OSw3ICsyNjksMTUgQEAgc3Rh
dGljIHN0cnVjdCByZHNfY29ubmVjdGlvbiAqX19yZHNfY29ubl9jcmVhdGUoc3RydWN0IG5ldCAq
bmV0LA0KPiA+ICAJCV9fcmRzX2Nvbm5fcGF0aF9pbml0KGNvbm4sICZjb25uLT5jX3BhdGhbaV0s
DQo+ID4gIAkJCQkgICAgIGlzX291dGdvaW5nKTsNCj4gPiAgCQljb25uLT5jX3BhdGhbaV0uY3Bf
aW5kZXggPSBpOw0KPiA+IC0JCWNvbm4tPmNfcGF0aFtpXS5jcF93cSA9IHJkc193cTsNCj4gPiAr
CQljb25uLT5jX3BhdGhbaV0uY3Bfd3EgPSBhbGxvY19vcmRlcmVkX3dvcmtxdWV1ZSgNCj4gPiAr
CQkJCQkJImtyZHNfY3Bfd3EjJWx1LyVkIiwgMCwNCj4gPiArCQkJCQkJcmRzX2Nvbm5fY291bnQs
IGkpOw0KPiBUaGlzIGhhcyBhIHJlYXNvbmFibGUgY2hhbmNlIG9mIGZhaWx1cmUgdW5kZXIgbWVt
b3J5IHByZXNzdXJlLCB3aGF0DQo+IGFib3V0IGZhbGxpbmcgYmFjayB0byByZHNfd3EgdXNhZ2Ug
aW5zdGVhZCBvZiBzaHV0dGluZyBkb3duIHRoZQ0KPiBjb25uZWN0aW9uIGVudGlyZWx5Pw0KU3Vy
ZSwgd2UgY2FuIGFkZCBpdCBhcyBhIGZhbGwgYmFjaywgaXQganVzdCBtZWFucyB0aGVyZSB3aWxs
IGJlIGEgbGl0dGxlIGV4dHJhIGhhbmRsaW5nIGluIHJkc19jb25uX3BhdGhfZGVzdHJveSB0byBt
YWtlDQpzdXJlIHdlIGRvbid0IHRlYXIgZG93biByZHNfd3EuICANCg0KSSBob3BlIHRoaXMgaGFz
IGhlbHBlZCBzb21lPyBMZXQgbWUga25vdyB3aGF0IHlvdSB0aGluayBvciBpZiB5b3UgdGhpbmsg
dGhlIHF1ZXVlIGFjY291bnRpbmcgbmVlZHMgbW9yZSBkaWdnaW5nLiAgVGhhbmtzDQpmb3IgdGhl
IHJldmlld3MhDQoNCkFsbGlzb24NCg0KPiANCj4gL1ANCj4gDQoNCg==

