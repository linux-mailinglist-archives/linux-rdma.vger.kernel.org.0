Return-Path: <linux-rdma+bounces-9282-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4A3A818EC
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 00:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEA817738D
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 22:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A79C255244;
	Tue,  8 Apr 2025 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K/zZOQgs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GZBrkDgu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A01EB3D;
	Tue,  8 Apr 2025 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152343; cv=fail; b=L8pMpGhrM1ORK3rpQIUCxctZyd3NCFHqZ6nmdc0EJJMQFdyHoHK579yvrSXj8ntbl0Pmbu5Ne2LvCbKKmRuyxRmAM2OMoUXSPjMoDxaSvSv3/EbLVPr8CFrTwJTTlMNm/UkUh6P4guzWy5J57Qmk3kEHDa2Wdh8AoHpKaQfe40Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152343; c=relaxed/simple;
	bh=6XzBQqNvyp/cGaROY4dxDMI9azXjh8pK/oRsDURDC08=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gwiznGqRNZxE39XaZjkkNwOJXeBSdNRIg9Q0FuLoKKS+nKTRXiZ/lRMuNe+bDqJE+PpnfY35HoQPGL/ps5LM/24QvQWT++0e18eDa1+rEC5UyVVzvu3DjbIwZ0SIJclNwaX7Ocelm7zB3JsYe/Ba508q3gRB0Qp86eGQIf5Hiy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K/zZOQgs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GZBrkDgu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538LA3cd027457;
	Tue, 8 Apr 2025 22:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6XzBQqNvyp/cGaROY4dxDMI9azXjh8pK/oRsDURDC08=; b=
	K/zZOQgs/IrSkeGPulvIMiLVpK/ph1Zrkf9mS1f4WNSN2Ro7r4kLoYinVYoWsHBN
	MbGV826C1Q2SXeO58w5Nn1Xurqm9z6HkSQpoH0uL9SjW3HU3sWwEFGYEf+mt1QXV
	6Atg/PRL9vFf1yn2Y78mxakLYSTI+JeDbO04BGjdAvK+vcSMQB3CTDKYzu60g/z7
	g1eYOj11wE2xGTZmF/2Z2SYZfORdPPo1AIiwe5/SL9a3pJPbl2kRTfJDSOeJsEsy
	IzDRdpMwamGkwci2EDUITYSBfreSc9Wi2GoQY8aH5MD6BpCw/oQyPlxRjjFEPd4m
	IYkTx0nBqyoELnEkfwngjw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45ttxcww96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 22:45:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538Mc3BK023775;
	Tue, 8 Apr 2025 22:45:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyg9d6e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 22:45:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IppS7OqW0KB/3o/wOOQ2TVfnVyyblfrrET8QYHmhXsbipU3Pj0fS+99okNa7KeqfPyc5XYf2srUwkUorJJBK0tlyBnPhaebe3eokW55SdkJPtCu6NK1QLAKNjgc3nuwfHcynJJ/3W51GZvFFWgk4Sd4L19ZkiE3qE8BQNPzdQMaeCuhjkj+/4H6VOe0cmV8Ohf/nSwoy4xYcjIlbfrHV4hyaBogWXw6vYVKika6L5vgyfN6wi10mjsErnZMDw1uAHL9QdvUatdj+88NoBMYefB6id1P/N9mk1zVRuPo7J2DRew+rj3zAL2ZRlgual1NC1GJYGvwbo257dvsCMV/xYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XzBQqNvyp/cGaROY4dxDMI9azXjh8pK/oRsDURDC08=;
 b=g1OlDSsiWWkTnT50IQrd1rfw1mkdSQU+InPoNAioG6oc+u7UtsfVPWTnHstZD0k9xt7a0QE5xqkVVSXjZaHGvL80n/20wmS9EfrKxIVfNNxFU9qD1lJUeU5KA5EVD9Osj0vNeCtQ6YPPD5CMJgzQHlsEOC1PQRB/zNpCpmrrjjmWZutM5gnidNj8jk8C8/PK6D3jO6c75GfGUHPQIYGc8WMYo3k2EQG15nUD7Mj9Zv+hETjRSEIPR5mmUhaUbLnCYpJb9L5/MhwAWwMPyC4un/GNXs6HEjx73Q8dV02YmUaqYp8HnL/+11sY3n3NZzqS0OY0OM8X9DWIL5vK5Y3x3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XzBQqNvyp/cGaROY4dxDMI9azXjh8pK/oRsDURDC08=;
 b=GZBrkDguSf6TKzfpwmYN4XQuQMZx3fwph36dH+ZBC7EaV1UeZYsnosx1aBvyZGWs6lX0EnvH1JhY2hEqNLAXceOYMuOJ82iNcip2kQdjJjyHAb2j6T6yoTIi6LvqMigCOXXcQ7eJAWtswHw6fHsgqricoTXrFuV0W5CEU6c//Hk=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CH3PR10MB7645.namprd10.prod.outlook.com (2603:10b6:610:17a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Tue, 8 Apr
 2025 22:45:24 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 22:45:24 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "shannon.nelson@amd.com" <shannon.nelson@amd.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "pranav.tyagi03@gmail.com"
	<pranav.tyagi03@gmail.com>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: rds: replace strncpy with memcpy
Thread-Topic: [PATCH] net: rds: replace strncpy with memcpy
Thread-Index: AQHbqL5dCOhRbEtAt0m3wK1CibaiR7OaRfoAgAAYWoA=
Date: Tue, 8 Apr 2025 22:45:24 +0000
Message-ID: <32b8d4635b8f15cce3ae898cc480616428bc93ba.camel@oracle.com>
References: <20250408194153.6570-1-pranav.tyagi03@gmail.com>
	 <c7dbeaf7-ab93-4b4f-904c-99d42a83a83d@amd.com>
In-Reply-To: <c7dbeaf7-ab93-4b4f-904c-99d42a83a83d@amd.com>
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
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHOBBMB
 CgA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAme1o
 KoACgkQyD6kYDBH6bO6PQv/S0JX125/DVO+mI3GXj00Bsbb5XD+tPUwo7qtMfSg5X80mG6GKao9hL
 ZP22dNlYdQJidNRoVew3pYLKLFcsm1qbiLHBbNVSynGaJuLDbC5sqfsGDmSBrLznefRW+XcKfyvCC
 sG2/fomT4Dnc+8n2XkDYN40ptOTy5/HyVHZzC9aocoXKVGegPwhnz70la3oZfzCKR3tY2Pt368xyx
 jbUOCHx41RHNGBKDyqmzcOKKxK2y8S69k1X+Cx/z+647qaTgEZjGCNvVfQj+DpIef/w6x+y3DoACY
 CfI3lEyFKX6yOy/enjqRXnqz7IXXjVJrLlDvIAApEm0yT25dTIjOegvr0H6y3wJqz10jbjmIKkHRX
 oltd2lIXs2VL419qFAgYIItuBFQ3XpKKMvnO45Nbey1zXF8upDw0s9r9rNDykG7Am2LDUi7CQtKeq
 p9Hjoueq8wWOsPDIzZ5LeRanH/UNYEzYt+MilFukg9btNGoxDCo9rwipAHMx6VGgNER6bVDER
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CH3PR10MB7645:EE_
x-ms-office365-filtering-correlation-id: 8daccfd8-635f-474d-4e08-08dd76ef0ccf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzVkaXlSeVJQRzJWbk8xcTNpQTlidVFWQ09EQzJ5WVBuc2hWbjhmb3huRnVT?=
 =?utf-8?B?TjZmemFBejRGOGhtMlBrK3dNZzZzWU1OUFNNVUhVSXJ1WnJuQURPWXppTnFO?=
 =?utf-8?B?clViQy9xL3pYOGtMdHVlSmMxanRqc3VrTFkyQUtiY25sM3doZHB2Y0YzcGt1?=
 =?utf-8?B?TzczYzZBZ2NmOXN1OXpXWVlEMG1rUVppWDdwbC9wMmJXYnJxUE4zZWh2U3FI?=
 =?utf-8?B?aFFhYllZRmhyTGlaeVRHS2JZZGhaTHlac2x0U1VBM2tmZ3d3UmRrVDZrWDdI?=
 =?utf-8?B?UGZvYkxRbFhrYWJhNDdURC9QeDNHQVhXR3FkQzB0Sm5kait3VkZCS21PTEtJ?=
 =?utf-8?B?NlpTSnpGb2gzRHFYUDJNQWlUSElqbUZPc0VnTmF0SC9yK0JVOHNIQlVNZkZW?=
 =?utf-8?B?dGJtRUk5M1Z0UFdSSmorcGVTdU5reENDUnlHMG50WWU5am5vcEkwZXBFMWdo?=
 =?utf-8?B?dGUvMFR6bC95VE5BRzM2MWVKWUJaaXhEdmtzd1dHTXNZL2MrV2N6aEl1M1RH?=
 =?utf-8?B?MFprZ1JjMVRQb1UyNDd2QkhxSlJ6UFhtREhhWFVxZkU3eDdudGVlMjNkRWQ4?=
 =?utf-8?B?UVlYdW1UNkZ5UkhHM045ZTY1TXA2TllxMGdxNzVlcXk1Mml2b0Z3MmF5MXNC?=
 =?utf-8?B?Z3lDK055ZmxiMEJYNXF3bitENlJKZHZ0VWpDN1VNUHVPVVBUL2dCZnZjTWJh?=
 =?utf-8?B?b2l0a3N0cmVPSHdabzRHL1pqSHFuOUpTSjlmSmE4Z0F0SURkeS9kdW4xY3NX?=
 =?utf-8?B?UWdSaWNicUhSRzNPYW1kbWwrZEc1eWxTNWxJS25iKzVXclFRampwQzNmVDVu?=
 =?utf-8?B?TysvUFM2cTRDN240MzdGRVlXenVNT0poL3h5NTAxUEpJQzQwTTJHK0JMbC91?=
 =?utf-8?B?OU5FQkVpdFRuRzlDbktYUE44ZTFIaHdENEh3L0cxSTZKR2F6RGNBVlp3Q0xM?=
 =?utf-8?B?NGRBNkQxSUxjQUU3L1QyNU5ZUEowNi95c0tMZldiM1JCYndoK0VxU205MFY5?=
 =?utf-8?B?NERtVHZZOUZaTTEyakZRMzlLTDI3SlY3YnlwMWtWWEdNK29mUldzTDc2amd6?=
 =?utf-8?B?RnFPRFhFUEZDYWhpUDZpK1RvYk1WWGJPZ1cxVUVYTzBvL0VnWWVVTXhzYWxN?=
 =?utf-8?B?UE5xWEptaXdoZDdsYjd0Q2xReE1qWFVqQWlSYjZjWTB3T3BtVTFtRVk4OEdQ?=
 =?utf-8?B?VktiY1RCZWZxOUdDcXVPb1dLUFU0dHZDd3FxOE84bENQRjl1VHpRK3dOK3NH?=
 =?utf-8?B?RVFNQUc2Z0JQa2thT2E1clpaNWYzYTBKMkY3L1ZaaGlxeThSTXZ6OVdIV2dz?=
 =?utf-8?B?SWlodTZKUFZod0FnWVlBd2I0TkRNeEt6UzRUbkhXUFl1VDY0UUcvSEhsbEo2?=
 =?utf-8?B?OHp5ekF6RmNqN0tuU3hkUWxkVTl2dVhVcFU2bTRYMk1oZnJqdGhPSjJ6WnpZ?=
 =?utf-8?B?NnBKbGxRTG1oSENVMERkbFpwV2xjTUJKOFVjL3VRSEdFTE9KdnFYTnV2TStw?=
 =?utf-8?B?bExhUTRXTDVhSmpIQ2FPS2d6bGtUNnRkMHhZUXZMOE1xT2hPc0RjcGpwZ0Jt?=
 =?utf-8?B?anlWamhTd09qQXFCczZaeFY0bXRISDZDWVhPdVZSVFRBS3VacDBBM29HUWpj?=
 =?utf-8?B?QXdaZzhhcVdWK2dxMHlnVU1UZHVyZ04yVnc1OXYyMTJMOUo2ZFZEbTVRZ3BH?=
 =?utf-8?B?cTdhR2QzRU5lYnZoTjkwT3FBYS81YndWWHZhMXpOcithRFcyM1dPUTBUT0V3?=
 =?utf-8?B?d2V4T3dKUnp6SkRKZ3RrUUlyYTN6UnF1clJteVdBYWVMTlk5a3ZyeEU5TUUw?=
 =?utf-8?B?elZYcVFDZk1XYzlCa2pnOTk0R09oTTRGY2lWb2U5THFhZDZvRTJzVWpkSzFW?=
 =?utf-8?B?NlFXaitqZW05YWFLOWs3VExRVGJFZWZlcG5lM1dBVStBOHVYM0FzMHdONld4?=
 =?utf-8?Q?k7LsbOsw8p9x/NRlBjnGz/SKeu9+rwBO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djNCU3ZHSlNYSkg3YWJHV2J1VnZjK0NmaW5BOUxEbVZUdHVDNkdHSG1GRzNv?=
 =?utf-8?B?SkRsUDREbnZmVnR4RFVoMzFISy9iSkpVdTlOUHVhbGFUY2hVS0p1ZzFKNlRQ?=
 =?utf-8?B?Z3A4TDVpNzlVKzRhYm92SWRSQmVNcy9qVFZFSkhGVG5yUmoyV3hBQjhSY011?=
 =?utf-8?B?T0diN2UyT09MUE0wOTNRVE4rUTFKOWVqS0JReHhrcUdpNkQ1TEpPa3FibGdI?=
 =?utf-8?B?bUttbVdQZFMwakZjVzJJZ3k0dzhiZ0FpOGdkc0c4cXVqQ24vcm5URE1zdlVt?=
 =?utf-8?B?RzRyKzRWelBER2JDZXFFZUlBSjhwVlVBT1hydnNqWll6QVMwN2x0M2FWZlRi?=
 =?utf-8?B?T0FOdHd4N3dpRk5RMUJrUndLNEVIa205SnJ4dk5waUMvajN4Z0hyZHBIVGxx?=
 =?utf-8?B?Z0ZDZmpaaXNJdEk1YjJ3aW85UFBIQ2ZjU3Ard1VFTU12ZzZ3N3dabnZuQTRE?=
 =?utf-8?B?N3MyQmNycDg1MnN0aTFlc3RTdXN3MUx0Y3pLZGFMZi9vanB3NHVpTzNPL0xE?=
 =?utf-8?B?NWNKR3hzL01QejdvZ1VnQzJsMXcxR09keUJWdEE5OGtFK0VTNnFGaGJkUzA4?=
 =?utf-8?B?azZ6WDExYlo2M0d0Z2FNQXEwY3B0OWdZZE9XZWlrQ2dwL01qN0dSalU1NVU2?=
 =?utf-8?B?SGh4OGJmaVRZc1E0U1BwZEdYcDZsNzY5MVdYMGd6WVljck5MaVNSM2dGSU9E?=
 =?utf-8?B?Zk9xRUhJcmFhZFoyZ0JoQzg0dm5XbHArZ2RvcWQ4OEloSlJNbVp1MU5qdkZG?=
 =?utf-8?B?V3o2SlV0SndQa0JTVjBCam9idGswUmhzTGErUTREOCs2cGFsQjEvc3VUVFB2?=
 =?utf-8?B?R2pMV0JRcWwvd2o1UFU2ZnkveEdKUlhVUW9qNzd0Rlh2ZzNlZTlHOXBIZFFL?=
 =?utf-8?B?OExqbEFQdEdVb0ltTGRUVjBUSnBjNEZ2UmxqTHRzRDZxY2hhcDlaRzUweGcy?=
 =?utf-8?B?RkdDVERmZXgwK2lHaFZNS2JMbGZ1YThqQkJhL3ZSNWltZnJXRmZDK3IyL2Vi?=
 =?utf-8?B?dnZERW5kU2h4bm9lMGRDVElQVXA4SHlXVUZmb1FIM1lYZHNwbmdqWHJpT21T?=
 =?utf-8?B?Z0JqVlhNa1ZlRjBBVmVGQzMvdVN4TGNzemlXNHRoZDh6K0xUVFZseTBBQ0x4?=
 =?utf-8?B?NFBWZ2xjWlFqWHdSU0VOaGJ6OThkUlpsNTdUUWk4dHRKTlh3S21YN050WGJk?=
 =?utf-8?B?WStHZWtFTk14WEpSWjBzekNCS04yY08vY3lzNEUrQXpRakF3Y0IreExVMTVE?=
 =?utf-8?B?YSs2ODhlMFhvdWZoRndLcEVyZjNHdVRIc05TQmZnVkRXbFFwaGY3OXpZR1lI?=
 =?utf-8?B?VnpmNVluQ1JMVzlSMFg5MUFBUTg1cjNwa1VwSmpWd2t0MGpMVHJwclYyMVhx?=
 =?utf-8?B?SkhvS3JFWEZpUDF6VCtmU21lWGFKb3F4T0xRRHI2TFpNUVZaV0VpWnhUamZo?=
 =?utf-8?B?UnNUY2M5YzZGb3JVM1A4S2F1clBFSUE3Y1YrQjdFOC9pQzcvSGlXMS9CYUVa?=
 =?utf-8?B?b1htNWh3MU9hU2Jtd2Y2TEUwY29zeWVSTmtOQ3pmRnFyV0lzeFh6Mm1nQkdY?=
 =?utf-8?B?djB3a25UOFFlVWw3YmpGdHpVNSt4UjlYU3djak8yNURoTG42djA5NU44NnVH?=
 =?utf-8?B?USt1dTBDcy9iNjVmcnByQlZlamNRaE4vRjIxRzI4ODN0WFhEVlN2ZmtENXN1?=
 =?utf-8?B?VEFNUVhRclVzS0tjN21rcjlwbmp4TkxKWmhoc3BlUER0cHBRbEVGZ0QxTFFU?=
 =?utf-8?B?Rm8yVjRZRnpaajB3Nm50NG5FK1FveUNnMVlwOS9DSmFuL1FJbkV5WU1PRk9y?=
 =?utf-8?B?RmVDb0Fxenl2VkpuWUZXdE0xbXpPV0JXS0JmWmxUaWV5ODk4NWluWjZYdkd6?=
 =?utf-8?B?blNNcjJtK3BFemU5TWVUQ0RsU0MrQkFpL2ovaWswUTMzUXgrSnhUK2IxRXFo?=
 =?utf-8?B?M2plS1ZJNFk3UDF2NElhTWFZR1ZSaExXTEJuVlp4Z3dEa1RXVm1jYTBkSEJW?=
 =?utf-8?B?U1VlZ2xwdDZ4RE9nd2Y5THBkQTRnSUI5eE5wa0MrZ1RhN20vRVd4bGI2aHlI?=
 =?utf-8?B?RDZiWUtzNHJVQitWUFNqNU1FTHlxLzNiUmM3MUtBbDhGb3FlQzJsOGYzaGRZ?=
 =?utf-8?B?ZC9vQisxVHhGdkY2QTZYUEF5ZlBYdVJIRW56MERCZHpLMDhkK1BKazJhbytz?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26A2D2B793935B4B903FFA18F4C5EA4D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W0Mv0UMpbmjmXVMSLPa6nWmMCs9Z80euOmdw8InuDgSBazFvrz6vnZpXTfATt3fBHJmlPHan7DM/aelKQ5PigqMxgApcF8GaRwSZaPJId8d04PLe67DMRezaJVEb5O0309ni3xeQZcVfQTAzfu4v9i+51W8Fb44YErwKlxitJMFaIQR7w/Wree2h7OX0ShrFiekiQgIUjTWa28/njukXW8lUoJ+grMvpuSrt3LD7A7FJa0NKK4c1dlKHlcfqcb9F3kf5HXutQsAu6A3yYnLRRQQx4QiL1j2zZJ0VlQkl0+OZZw15GwyZJwrM9BABAbmr5ZJ/YgrDiM+ouklOCRTrR7YsKz9rwxKlBEcdcM2DU6feu58EdtkGAyCKJfvBE1JcBKJj3rn4d7+M3yrWRRnVxCx0Nzhp94EP02sAfcVsF5Tk1d5sZFOGN5PaqbkB1Y6bWF2RCNASs99arcea38yWTWV/TRKFs+n1b4uZjIoIjYdx52uyy+SO/RwCWEnRnJKq22Pvz1jp23Hc9nbRpozK0u2y60YNPupLhxvlZjJ60pR4U3mkNzg2k2y11syjC5rFO4WRZR0y4kJComJIpBFcm/05FGC3jisx4rH8WLVSD9M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8daccfd8-635f-474d-4e08-08dd76ef0ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 22:45:24.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUMDYjQo2VO76bi4v/NBo+sxGYnkwOpulsvJvozxAiGamjmXhAUfe7XWhIPKsiFbAUlmSBjc5tCjQDm0qDd5Oupblc2cjHrE08PRDjHXVhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_09,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080156
X-Proofpoint-GUID: wMkVlxZ0KnRKQg1Evqhe6fW1ho6xDGIH
X-Proofpoint-ORIG-GUID: wMkVlxZ0KnRKQg1Evqhe6fW1ho6xDGIH

T24gVHVlLCAyMDI1LTA0LTA4IGF0IDE0OjE4IC0wNzAwLCBOZWxzb24sIFNoYW5ub24gd3JvdGU6
DQo+IE9uIDQvOC8yMDI1IDEyOjQxIFBNLCBQcmFuYXYgVHlhZ2kgd3JvdGU6DQo+ID4gDQo+ID4g
UmVwbGFjZSBkZXByZWNhdGVkIHN0cm5jcHkoKSBmdW5jdGlvbiB3aXRoIG1lbWNweSgpDQo+IA0K
PiBJIHN1c3BlY3QgdGhhdCBzdHJ0b21lbSgpIGlzIGEgYmV0dGVyIGFuc3dlciBoZXJlIHRoYW4g
YSByYXcgbWVtY3B5KCkgLSANCj4gaXQgYWxyZWFkeSBoYXMgYWxsIHRoZSBzdHJubGVuKCkgYW5k
IG1pbigpIHN0dWZmIGJha2VkIGludG8gaXQsIGFsb25nIA0KPiB3aXRoIHNvbWUgb3RoZXIgY29t
cGlsZS10aW1lIGNoZWNraW5nLg0KPiANCj4gPiBhcyB0aGUgZGVzdGluYXRpb24gYnVmZmVyIGlz
IGxlbmd0aCBib3VuZGVkDQo+ID4gYW5kIG5vdCByZXF1aXJlZCB0byBiZSBOVUwtdGVybWluYXRl
ZA0KPiANCj4gQXJlIHlvdSBzdXJlIHRoYXQgbnVsbC10ZXJtaW5hdGlvbiBpcyBub3QgcmVxdWly
ZWQ/ICBJJ20gbm90IGZhbWlsaWFyIA0KPiB3aXRoIHRoaXMgYml0IG9mIGNvZGUsIGJ1dCB0aGUg
ZGVmaW5pdGlvbnMgb2YgYm90aCBvZiB0aGUgLnRyYW5zcG9ydFtdIA0KPiBmaWVsZHMgZG8gc2F5
IC8qIG51bGwgdGVybSBhc2NpaSAqLw0KPiANCj4gc2xuDQo+IA0KDQpIaSBhbGwsDQoNCkl0IGFw
cGVhcnMgdGhhdCB0aGUgdHJhbnNwb3J0IG5hbWVzIGFyZSBudWxsLXRlcm1pbmF0ZWQuIExvb2tp
bmcgYXQgcmRzX2liX3RyYW5zcG9ydCwgcmRzX3RjcF90cmFuc3BvcnQsIGFuZA0KcmRzX2xvb3Bf
dHJhbnNwb3J0LCB0aGUgdF9uYW1lIG1lbWJlciBpcyBpbml0aWFsaXplZCB0byAiaW5maW5pYmFu
ZCIsICJ0Y3AiLCBvciAibG9vcCIsIHJlc3BlY3RpdmVseeKAlCB3aGljaCBpbmNsdWRlIHRoZQ0K
bnVsbCB0ZXJtaW5hdG9yLiBHaXZlbiB0aGF0LCBJIHRoaW5rIHN0cnNjcHkgc2VlbXMgdG8gYmUg
dGhlIGFwcHJvcHJpYXRlIGZ1bmN0aW9uIHRvIHVzZSBoZXJlLg0KDQpIb3dldmVyLCBpdCBsb29r
cyBsaWtlIEJhcmlzIGhhcyBhbHJlYWR5IHN1Ym1pdHRlZCBhIHNpbWlsYXIgcGF0Y2ggeWVzdGVy
ZGF5LCBhbmQgdW5mb3J0dW5hdGVseSwgd2UgY2FuJ3QgYWNjZXB0IGJvdGguDQpUaGF0IHNhaWQs
IHRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgY29udHJpYnV0aW9u4oCUd2UgcmVhbGx5IGFw
cHJlY2lhdGUgaXQhIPCfmIoNCg0KQWxsaXNvbg0KDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
UHJhbmF2IFR5YWdpIDxwcmFuYXYudHlhZ2kwM0BnbWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gICBu
ZXQvcmRzL2Nvbm5lY3Rpb24uYyB8IDYgKystLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQv
cmRzL2Nvbm5lY3Rpb24uYyBiL25ldC9yZHMvY29ubmVjdGlvbi5jDQo+ID4gaW5kZXggYzc0OWM1
NTI1YjQwLi4zNzE4YzNlZGIzMmUgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3Jkcy9jb25uZWN0aW9u
LmMNCj4gPiArKysgYi9uZXQvcmRzL2Nvbm5lY3Rpb24uYw0KPiA+IEBAIC03NDksOCArNzQ5LDcg
QEAgc3RhdGljIGludCByZHNfY29ubl9pbmZvX3Zpc2l0b3Ioc3RydWN0IHJkc19jb25uX3BhdGgg
KmNwLCB2b2lkICpidWZmZXIpDQo+ID4gICAgICAgICAgY2luZm8tPmxhZGRyID0gY29ubi0+Y19s
YWRkci5zNl9hZGRyMzJbM107DQo+ID4gICAgICAgICAgY2luZm8tPmZhZGRyID0gY29ubi0+Y19m
YWRkci5zNl9hZGRyMzJbM107DQo+ID4gICAgICAgICAgY2luZm8tPnRvcyA9IGNvbm4tPmNfdG9z
Ow0KPiA+IC0gICAgICAgc3RybmNweShjaW5mby0+dHJhbnNwb3J0LCBjb25uLT5jX3RyYW5zLT50
X25hbWUsDQo+ID4gLSAgICAgICAgICAgICAgIHNpemVvZihjaW5mby0+dHJhbnNwb3J0KSk7DQo+
ID4gKyAgICAgICBtZW1jcHkoY2luZm8tPnRyYW5zcG9ydCwgY29ubi0+Y190cmFucy0+dF9uYW1l
LCBtaW4oc2l6ZW9mKGNpbmZvLT50cmFuc3BvcnQpLCBzdHJubGVuKGNvbm4tPmNfdHJhbnMtPnRf
bmFtZSwgc2l6ZW9mKGNpbmZvLT50cmFuc3BvcnQpKSkpOw0KPiA+ICAgICAgICAgIGNpbmZvLT5m
bGFncyA9IDA7DQo+ID4gDQo+ID4gICAgICAgICAgcmRzX2Nvbm5faW5mb19zZXQoY2luZm8tPmZs
YWdzLCB0ZXN0X2JpdChSRFNfSU5fWE1JVCwgJmNwLT5jcF9mbGFncyksDQo+ID4gQEAgLTc3NSw4
ICs3NzQsNyBAQCBzdGF0aWMgaW50IHJkczZfY29ubl9pbmZvX3Zpc2l0b3Ioc3RydWN0IHJkc19j
b25uX3BhdGggKmNwLCB2b2lkICpidWZmZXIpDQo+ID4gICAgICAgICAgY2luZm82LT5uZXh0X3J4
X3NlcSA9IGNwLT5jcF9uZXh0X3J4X3NlcTsNCj4gPiAgICAgICAgICBjaW5mbzYtPmxhZGRyID0g
Y29ubi0+Y19sYWRkcjsNCj4gPiAgICAgICAgICBjaW5mbzYtPmZhZGRyID0gY29ubi0+Y19mYWRk
cjsNCj4gPiAtICAgICAgIHN0cm5jcHkoY2luZm82LT50cmFuc3BvcnQsIGNvbm4tPmNfdHJhbnMt
PnRfbmFtZSwNCj4gPiAtICAgICAgICAgICAgICAgc2l6ZW9mKGNpbmZvNi0+dHJhbnNwb3J0KSk7
DQo+ID4gKyAgICAgICBtZW1jcHkoY2luZm82LT50cmFuc3BvcnQsIGNvbm4tPmNfdHJhbnMtPnRf
bmFtZSwgbWluKHNpemVvZihjaW5mbzYtPnRyYW5zcG9ydCksIHN0cm5sZW4oY29ubi0+Y190cmFu
cy0+dF9uYW1lLCBzaXplb2YoY2luZm82LT50cmFuc3BvcnQpKSkpOw0KPiA+ICAgICAgICAgIGNp
bmZvNi0+ZmxhZ3MgPSAwOw0KPiA+IA0KPiA+ICAgICAgICAgIHJkc19jb25uX2luZm9fc2V0KGNp
bmZvNi0+ZmxhZ3MsIHRlc3RfYml0KFJEU19JTl9YTUlULCAmY3AtPmNwX2ZsYWdzKSwNCj4gPiAt
LQ0KPiA+IDIuNDkuMA0KPiA+IA0KPiA+IA0KPiANCj4gDQoNCg==

