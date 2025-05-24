Return-Path: <linux-rdma+bounces-10659-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EA6AC2D5E
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 07:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D681BA7552
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 05:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A111AC88B;
	Sat, 24 May 2025 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HFPCPPJy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sw0F2yqf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34C19CC28;
	Sat, 24 May 2025 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748063354; cv=fail; b=OBHk4bexK5RDhAEeULwrIIVRGdGaHWusijdBnFbLW1RFndEGpX53fYsLEAOjgIWq+SCDBkmBx8xYhdg3hhKwNrtUcnpOJqg7IZQSeAWDG0SeH8LXcfbDd4rVccm0cZ151C01Lu/JY087hlUEQtNiZx+Itbw1BNTTR4yqVdQ8334=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748063354; c=relaxed/simple;
	bh=bpuNbW4PfEL+aL7EtCU1PrMTu9XSqADIlhosou5n9a0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dz8B49Jpfd9fXYA2PZFRu6yG4VkTW5l3HXDOqm4GJiECVRw7EG1d9/UgBfYNcZJOIcfDJ8Mel+V+v21tkzrdObDAitSUGqU1G3GKP/pbEoo6+8Tl9eW/6raViTISpXMII4kFwlgWb0d02o/inw1WudR0ELRP9mKeWdmturA4dYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HFPCPPJy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sw0F2yqf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54O4qL5A030113;
	Sat, 24 May 2025 05:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bpuNbW4PfEL+aL7EtCU1PrMTu9XSqADIlhosou5n9a0=; b=
	HFPCPPJyx8AuxIoohIPFOw75rjtdcrqj6sLE/j8QedcsE3Qiwk6t7jC5nK6Q7Vf6
	yFLz56kUGQSMl8Mc8i3q5jp9SGMZuYtEbHbgQEJGjgVeEvS1HfPTz0nU/++PbztU
	+uac9pGg+GEeM8LoNKUT2jx6W3IJmO/ee71n9EG0nzRgTqhpvcfukxTpHyBZCisJ
	H/ND73xnxc9RH8qlO0qTH5giKVvHChWcGpgCeGB4olSE/8vlDCDF53EevgsVbmeU
	hUf4g+SIs5O6yRngahLqOrJk+AkRZonbnskbPjfILwSebAc/IvNW3dI2rWJZ443Z
	bpRyy5h41CZog2bawKZ5qA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46u6bt01gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 05:08:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54O1XkgX035766;
	Sat, 24 May 2025 05:08:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j73tv3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 05:08:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXBWG+w19YtcQGzB2bR6cumeekab3hUfU6GL24d3T8WcuIu+8MdaNYJj/UaNlDtLSKWDMeImSs7NHFaaegCAiSlI8R/MO3cVXq/mEpCvZD7naR9MUYPbjJvzLFhvGfg3TzSqw0xzpiarfJYD4nGhkvsJh4R+Qp/Gq+Q59t2UrgMhD9azwiwLvCPUo6W9yc3nQqbmgOZu7/RVZBT6BXVmy+MIwT4/2Iv0VwaSopJNocWHpFnL8+yIpYiPUbXVGOq5QcCXeR4Gu04xeHjyGy+gG5cusH8/nrly5ewBCxmYA5ipt9C4gybK+l5ISV2inrWQKqnb78LB5PskQKfg7Oi3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpuNbW4PfEL+aL7EtCU1PrMTu9XSqADIlhosou5n9a0=;
 b=CG4iwj/2aVJvHHqLnkIgeEyBSd39CKH0YhYcS98ip33kefc3cVZols2tXXHty/8zF4WZZjImZy1LRoiyBUrVf1NN01bVFlqrvhopovV113GCu4s3DRwOfaqk28hd85ceLYjwjfuTVhk+dWZGap0d8Lbkgn0V+qHvF24Lp5Jn8dWK8vlqgDnXRurhRp3zcASKvUaeNVGccLd50qfmLfmbv0B1USNjfP7E0PDrxxDSliKpQflFxkIjCgBN9lmXRxE6Q5nwV6/PuqoLy/P9YRoqKmndpoJ2aKUrKHuPaiDQMQb8edUk1AkjYipe0o59xpmCALXXWb5HrkOpEXe1TRdtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpuNbW4PfEL+aL7EtCU1PrMTu9XSqADIlhosou5n9a0=;
 b=sw0F2yqfUikwm5/2IAtd2r7ZDBq7MEOlNDwq2rpjD+yQBLVdTID0lTxX7ObSEmok3vem4Z1xdzKz517HmBW1qHJvCQIc/kR+GEevTw/PVX+gk/cTDoOfJOl7WQyeobPP0/SxMvq9mswTFFBFF6U4TTM13dc2jsQBixOzEXiZKEU=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 DM4PR10MB6062.namprd10.prod.outlook.com (2603:10b6:8:b7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Sat, 24 May 2025 05:08:52 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%5]) with mapi id 15.20.8746.032; Sat, 24 May 2025
 05:08:52 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "corbet@lwn.net" <corbet@lwn.net>,
        "rdunlap@infradead.org"
	<rdunlap@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        ALOK
 TIWARI <alok.a.tiwari@oracle.com>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Darren
 Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH] Doc: networking: Fix various typos in rds.rst
Thread-Topic: [PATCH] Doc: networking: Fix various typos in rds.rst
Thread-Index: AQHbyu1Un5L+xaTrP0uCDkc1gbw3SbPe0A0AgAJt+IA=
Date: Sat, 24 May 2025 05:08:52 +0000
Message-ID: <a02628a953ac89a53861e03839aa4732f4b8d226.camel@oracle.com>
References: <20250522074413.3634446-1-alok.a.tiwari@oracle.com>
	 <0a9c4d5a-a84c-420c-a781-84b18e90d34a@infradead.org>
In-Reply-To: <0a9c4d5a-a84c-420c-a781-84b18e90d34a@infradead.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|DM4PR10MB6062:EE_
x-ms-office365-filtering-correlation-id: 4059799f-7c6d-48cd-3447-08dd9a811398
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWdxVzFZaDFnS3VJUkNCUlNUY0x1Sy9wZ0hZNzk2QUREWHRSMjJFZWZqNG9C?=
 =?utf-8?B?QXlEU0lJTmFHNU1lUlNnekhXUU9SSnI5K3ZTSDY4TGlMS0ZpSHZIRlRDWXBh?=
 =?utf-8?B?Q0ljWFhBYmxIMzJFSUtYNlBGVWJ2dzhIWlF1YnFhV0JFemxubzRGY1hCU1Fj?=
 =?utf-8?B?R2FHK2tHVE1FM0FSbDhDb2w2RGovdkV5N0ZaRGdRK0hvWXRsbU1iT3NWUXZm?=
 =?utf-8?B?bHJUbjNRMThDM1NzNVVXdm1oaHZJTkJtY25QUG8xU01sajVjeEhSQXJZekVI?=
 =?utf-8?B?eFVQV29QRkZJTVZZYXJkeDZsMjhKTWhnRlFXUE5GY3l6ZmM0TXkwVENxc2pq?=
 =?utf-8?B?RXR1cFNKZlArUDJ0aHRaMUdCUXNDK2NlaXhXMTVrOTN6dmduYVVmalJKNG83?=
 =?utf-8?B?d1BiUDlHNG4vLytYZURab2Z5ZlBqYjFDazMzZnpuZzhrU0Rpeld1NkZrZlFl?=
 =?utf-8?B?MzZQNEJSelk1RklDSFBTblphWS9PUXhIU0xQekh1TXFvejBaaDd2OXJ6ak9n?=
 =?utf-8?B?Q0I4dW5ISWpERmJ1VGM0M2JFQVd3SkVGKy9FdlpzbXhRMXl1UUhmSk13WmVo?=
 =?utf-8?B?L3ZpWi9sbzFHRlNUbFFTQ3R6YWJaVE1nM29heitaT0RDZHBvYU1aSFovTlFy?=
 =?utf-8?B?UklWNm5RZ1cyNlZGQUdmczA0bVNjMXYvK093MWo1b09JVkY2Nm0zaGJTTS9V?=
 =?utf-8?B?ZFJBZFR1enlSUjE2bzBVOGxUSStBYkZpR1VGWVBYRkRZZW1MbkxTQUJMc1kv?=
 =?utf-8?B?eHg2Y2J2SVNXL2hJWVdDV08vQkhKZ3UxVGFPN0RoNkQ3VktqTjNtUUJSVW9Y?=
 =?utf-8?B?ZjJNVXRXZlZZcTdHU2hOVDR5QkdESzB3d2xFQjdZYVArYmozQ0l4ck9Rd2VT?=
 =?utf-8?B?aXZLWllZN1B4QitYQmlSN2lBVmtPNG5MSHFMWW9YaENjdStSVHBPU2dCNVNK?=
 =?utf-8?B?ZERnc1NYTDIrakwyZDB6K2R6UG5seHhyZ2x3RmxyTWE5cWY4R1FTakVKWGdk?=
 =?utf-8?B?N3BDVXFsR0o1VWlVdHJ3NWI4NElKVXRCWmUvZzlHaHEzM2NTV0xOSm12VXRB?=
 =?utf-8?B?NUVrSkNBOUZYejdQY2pMVnVjb2RwVHpOR3lCUk5ZZFNpa2hOQWFPSzNENjgw?=
 =?utf-8?B?c09vWTlwNU1zbFFmZDBTMVd1NnhtdG5zRDFZdVlMeU9ta202RXVQSzI0L3Fl?=
 =?utf-8?B?U1l5bnlvMHdaL01qYXE1b3RIVjhtaGs3U1hLR0ZiRTZGMGN0SDFFMW9jakVO?=
 =?utf-8?B?N25XRldlbUF5TGN3anpKb0xWVXQ1WGhwSnhFT0lUV3lSWWpHL3FNUXZsWDVj?=
 =?utf-8?B?a3hkU0lON1hxdnBkK3NYOWxNNWh0Z2tkckRDUnRuN3owTWtFY2cwNjhiRElt?=
 =?utf-8?B?dkJ1MVFON0p0bHgrOHQyMFB1NEYvelRxdGdkbngxeWVZL1RGRW9GOTBtcGt1?=
 =?utf-8?B?akJqNjEwUEJCa0tiQ3pZV01MQ04wK1B4b1VEb1gzZExqa1praXo5WCtQQVp5?=
 =?utf-8?B?bFJjZnJlS0FTUEViNkI3K25jRmVzV1huT0ZqcHFkUzNSMHZLRU9kNE1tekln?=
 =?utf-8?B?YUZGVExZMDYwVmtmTjFNWHlzMUM5RHVHSkwwS0FXRmJLLytNTTc4VzVXTSt1?=
 =?utf-8?B?TTV0dGQ2S0VrYzRIb2FtQnV0T1dnWWE3TTBkZGJna1NBUnZkdmZ6eUJWUjc5?=
 =?utf-8?B?NzF4U0JRb0ZpUGRtMHhVNnZlbVUrd0g3cytvVFpUSjhVb1FNTnpBT0Z1Titz?=
 =?utf-8?B?SzFOeGFEV01hckFKZ01ocE9QWlVkZTlRTUNhamdTMjV5MFIxdCtHeU9TdmI5?=
 =?utf-8?B?MWFvalE5cG1GV3VoQTU0ZTBNTEIxa0ZPbDgwTlZWUkxCNlc4dTA0Vkx5L2ZY?=
 =?utf-8?B?VkltZDVEWHk5aTNCOVVjMnk2QnpjRG1hTlNQdnZOWmRSak13YW15aVJ6S2Ni?=
 =?utf-8?B?Ti8xeWxBVjV6aVdsSTJSZTlaRUkyaHdxRlhkV2o1cWFwVTh3UkpnVEc0U3dr?=
 =?utf-8?Q?JYacaa3XT59hxotpi1Vs+d5V5rb7+4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmlvZHU1Ujdxb2MxUVdjamMyb25TL1RhSFRQaFk0cHp0RHovODF5QXZmVi9U?=
 =?utf-8?B?OC9vTUFldnVNdnZlM2YwZEJsVkU0UlhwRGNIUlFjdDFkUDMyeUd5OXRZclR1?=
 =?utf-8?B?VjJXM0NsNFU1dmdtNVBQTTdFZ004MUM3SzNkYmNGbXVqOVNGWVZ4dnduVy9Q?=
 =?utf-8?B?d2hvQXA2MmVXdkJVejh1TElVc0FIUWV0ekRvbWZGS0oxQlFRNHBTT0ZCREhh?=
 =?utf-8?B?Z0ZEeGg3V3RnM0dGWXIxaklaWExKZ0MxQnJSOVpOZjBHc3IwUUJaYTNSZkNQ?=
 =?utf-8?B?MGRDTVpuU0hBMC9wc2tYNGlOTUVoZDZIUzhzUWVlMzUvUzlIUVRveXg3UitE?=
 =?utf-8?B?R1Nvc3owZi9jM3RVeTN5NGc0ZVlWcUNHUFEzWnNUUFJtQjluQnpoNEVKVGxR?=
 =?utf-8?B?S21oOUZNVjMyRkt4NGVkeVZPUHF2dnoxQXVXOVdtLzFMRU9ZMFk3dTZmZG0x?=
 =?utf-8?B?SFlwY1B4a3hsWGJ5ZW5pZFkvdjRqUlpXNE1aNitKR0xZS2Z3UTFaTVd4Ym9h?=
 =?utf-8?B?by9lRFcrdTMxSHF1cXhPUnJNeHNDaVVVWGVMb25XNktEYjVpaHBUZ2pYVXlD?=
 =?utf-8?B?ZGpjcmEreXdFdVJMeUQ5Vk5UbWt3b0piczF4RWpxKzFvT0xJd3hERy84K2da?=
 =?utf-8?B?dEtpdzlvRHZSZUFMVWQwVVdYUnpHTGxKcFJRZWpDSW1XSzhoRklyRHVsZVF3?=
 =?utf-8?B?OE1TSnlBZnNLTWFNbGV1anBWS09ja3ltdVFmekdiQ3d5Sy9QNy9lVDNIZUVp?=
 =?utf-8?B?TVFTM2NINUx4Y2lFNXdNbTJXdThUSXhtQis2TlN5SGNXNTduNG5nb3h5ZkIw?=
 =?utf-8?B?OTFRTFk4WFlReFNWVzB4dU5oMS9JS1ZzcUVvNlBPWDVHeGpnSXpUNDVGYXlq?=
 =?utf-8?B?RWpFanRLN1R1UVBSU29sOTdabndxK3pGZ0ZlSmF5TFVDaU41ZWxqc1h5dE42?=
 =?utf-8?B?Q0ZIZDdzMmxtRm1WU2hocG9NUUZPMDZvbWIrWXdCWjYzaUZBMEpMVXFIOEZX?=
 =?utf-8?B?cVIxcHpibUNmWGZTZzBhcm55N21udGJnOXpmQ1k4ZU9VYXVRUWpzam9uQWwz?=
 =?utf-8?B?d1llMGpkOFhMajg3TVVqL3hWQTlPQmo0SXp6VXI0YWpkQzNnTEg4STZFOWJE?=
 =?utf-8?B?azVESElVNzJvYTRNS3hOMVQwTnMwN3NYWTE5WU91NE02a29xbkV0UncvVU9Q?=
 =?utf-8?B?dWg1akQwSldZZHhPaElJZHh4QVhoV3hSajRxRU9BdWJUY0VGSzZOd1VjWHhk?=
 =?utf-8?B?KzZ6U0tGOG5nazNxd3A2VWJ1eHJSMEJPejVvMWNIU3BzWEoweGg1YnV0MUxX?=
 =?utf-8?B?SVJaL2ZFcUpkYU9pOTZTbWs0dVd1NnhVemFLN1E3WUlPdTExb2tSUzFSVGZN?=
 =?utf-8?B?bmVEeHNsQ1pOVTJlTnYwdHZPTEYyTjExWHV5eEJ3YmlyMTVoaGo1QnBReFVW?=
 =?utf-8?B?N1VpRzdtYmMzRFNXWGVKZ3ROOVlJWVAwQWNuUVNjcFdOOG03L2lleW91UFVx?=
 =?utf-8?B?WFpza3lpYTVXajZyWFlncjhwYjNmT1pqSmdGQmVTejFMNndLaTIwY2gxZDd3?=
 =?utf-8?B?bkNIMDkwNFlpVjZ1OE55TkEzNDFnN09QelhlN3RuT2hQNkFtR3RTUFduOXYx?=
 =?utf-8?B?SjNWaDdUSE9CNTNQYzIxTGpOMThybDRMWG9VMmtOczVOOUJGTklSUG1PZzVh?=
 =?utf-8?B?SDJKZ2tlang4MDZPRXN3SEplUXNjejFmdXZBQVlyaXNzTTRoOTYwSE5Sd2ta?=
 =?utf-8?B?RXNOajQvR0hmMDA5M0lJSGtFVmdXa0xJelVOVzlPQ2pjSmJPYWEvV3ZkMnBy?=
 =?utf-8?B?clViSVFzMDlyM0RwOGgrTXM0c01QMWRVMHA2QzdrQXhSTy9JdnQ3d2ZxMU5v?=
 =?utf-8?B?S1NBQ3hWOGduZHNJZVdubmFVa3grazdDK2NJcFZuZ0pMMkJrMk9VUWJkOWZJ?=
 =?utf-8?B?QWpDR25OclU4UVVMaHdVSVFwbHZ2WkRxVGhsK0lyWHpjNnlJajY3RW5jRk5p?=
 =?utf-8?B?R0tobElPNTJDYU12N2NMR1FNZjNRUGhUSlNlWGYzZUN4OHlkRkZzOWUxOVlm?=
 =?utf-8?B?ODdTbnNmcUl1MW0wRnJnd1k5V2pOOWtoaituOW1RZDViNHA2dEwwOXdUNzR0?=
 =?utf-8?B?MUsxL25TeTZlREkyT0VRb3hGbDFQbFo4MTRPT3ZSZEZMbEFjUmFWZisxMStI?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <585693AE73A2C44C97527AC71637C48B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2lzuiQ/V+aWhEIasGXAmVEsL3G+ZNjXhegNS5Yz+aCx7wycNpX5tp0l0/wVF8szb2Y2EmbgjV+owz7WiWVyDPqOHYEZdgPffxP9ObiMVRXF3UTs24YMpEARjSRUXeCXnURE7zKx2H8Ru0wlnajl8DOFvh6Zo7JuOR3sf9Fkvd9/oRtFhmno8GhlIoHTdETNKMhYU3RgPPEefvp0o0o8MwAl7j2GXikmER4WgGNX3D/JSt0eTT2qVI/ZZZWHL4mFbKW0WWd+J65l7r5/i6OVqqCpduBdxyTSTOtQq4KmO4tkr0pbt8mjLwWknDymd+MhNzkNosSdPcY69pq7jT/vVg7JeYQOFqvyRdTXJ1L2MJNC6hf6Znd4ZE60nhrgSSp5knR9HJ80NH6Iq6jHA7OsRNssDGprWRxIunk0D2rN1K33PFY5QeWpDQ39DDAiwYXbDNzF3gmh4MW+Y6KC9pVenjt64FXJe1b+Rv8L6PpKretmzkHD5djUE0Mrc6UFeCZl9DA0Nb20Nsv6hOMiLKo4UdDjvZX//1E03FSYjU0MPYXLi3H+o9Oh0lNFgTLDNiNSW2tFT1X8Jq8QQ5FRJfN2HwXylkjy3A8qe88E3DC46WF0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4059799f-7c6d-48cd-3447-08dd9a811398
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2025 05:08:52.6438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zt/iDXAZsPcqkQYNluQgnHB2ce5acKlG5HtTat+ci2WpIEWQh+wlEYd1CY6z/98RMUeAEDr+TrCgKFopguskyyg56Q1H1Hr5jCucqfIBrqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6062
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-24_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505240045
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI0MDA0NiBTYWx0ZWRfX35hN+6Jqr28T 7jHSW63r0JNokRUX+kUNtkVWDDPQBEtXDnvRyLMFbUkb6tS3dxslvItTObzSAdVjCqlbu8w2q/t iG09FhRm4indOogLdnhPhQg/4hnzQb6YpMInQYMGEOd7YhEvFZQ7ZoowhN33xCW+C+78TEjg5sQ
 yo/05g98++KQpm81pCsGBPLvK3fYV+ogokXJAp1u5+7dn4ScmLG/8NiXy1XbyzOs6lBqEYJXCWN 4kfntiHf4e86cUp8nzYHgzU5NB/MtO4JiYrzrTlVkncGtSPBj7C+CfeYOM3SLoB3LLeyGdIyjCy /oRwKCVK4J5sPrCIa7ItZn4NyPk/pD3fTJEix+6lYRSm4PM6pyT3wRWhmUJrG4OcJr9FZlgyU4o
 Ln1FZyp99+YhhAsnpS4cn2EhxpnAYKfPNS+C1oulkxPdzV9GqWjcTN7q4gOiUAOAV8JRm39i
X-Proofpoint-GUID: CalXfDTAw7BoenORVNb6ZthWhT47plr7
X-Authority-Analysis: v=2.4 cv=ONwn3TaB c=1 sm=1 tr=0 ts=68315469 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8 a=TOyhxNOTIIkXWnypop0A:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: CalXfDTAw7BoenORVNb6ZthWhT47plr7

T24gVGh1LCAyMDI1LTA1LTIyIGF0IDA5OjAyIC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IA0KPiBPbiA1LzIyLzI1IDEyOjQzIEFNLCBBbG9rIFRpd2FyaSB3cm90ZToNCj4gPiBDb3JyZWN0
ZWQgInNhZ2VzIiB0byAibWVzc2FnZXMiIGluIHRoZSBiaXRtYXAgYWxsb2NhdGlvbiBkZXNjcmlw
dGlvbi4NCj4gPiBGaXhlZCAiY29tcGV0ZWQiIHRvICJjb21wbGV0ZWQiIGluIHRoZSByZWN2IHBh
dGggZGF0YWdyYW0gaGFuZGxpbmcgc2VjdGlvbi4NCj4gPiBDb3JyZWN0ZWQgInByaXZhdGVlIiB0
byAicHJpdmF0ZSIgaW4gdGhlIG11bHRpcGF0aCBSRFMgc2VjdGlvbi4NCj4gPiBGaXhlZCAibXV0
bGlwYXRoIiB0byAibXVsdGlwYXRoIiBpbiB0aGUgdHJhbnNwb3J0IGNhcGFiaWxpdGllcyBkZXNj
cmlwdGlvbi4NCj4gPiANCj4gPiBUaGVzZSBjaGFuZ2VzIGltcHJvdmUgZG9jdW1lbnRhdGlvbiBj
bGFyaXR5IGFuZCBtYWludGFpbiBjb25zaXN0ZW5jeS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBbG9rIFRpd2FyaSA8YWxvay5hLnRpd2FyaUBvcmFjbGUuY29tPg0KPiANCj4gQWNrZWQtYnk6
IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiANCj4gVGhhbmtzLg0KPiAN
Ckxvb2tzIGdvb2QgdG8gbWUuICBUaGFuayBBbG9rIQ0KUmV2aWV3ZWQtYnk6IEFsbGlzb24gSGVu
ZGVyc29uIDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPg0KDQo+ID4gLS0tDQo+ID4gIERv
Y3VtZW50YXRpb24vbmV0d29ya2luZy9yZHMucnN0IHwgOCArKysrLS0tLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiANCg0K

