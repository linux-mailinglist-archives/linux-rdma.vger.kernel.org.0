Return-Path: <linux-rdma+bounces-10426-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04213ABC8FA
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 23:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BD44A15A2
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 21:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DE91E3DE8;
	Mon, 19 May 2025 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UJZyfhyb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SKL4KUj6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661CD2FF;
	Mon, 19 May 2025 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689389; cv=fail; b=n5GYTqmgxy4136wK7PmcTmUxOE9r7KUjV0orPyPd+0QsPcLhmjV5T8irmpYjXKjcnnG7rkKwRfX0l3jbR4lhkAWB573P9TP0DQQpegLx1JgwRI6sF8TDbWXpKeYyDFw+TMeVhK4wmPyLDeWEftEUaaRqhsFbCdaeQa01/H2IAFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689389; c=relaxed/simple;
	bh=6dQI3NPHAo9H0FhYWNsE1+ohX18QK/VHYt01fYT5iGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHz4cDCmd7uI0336a2GFYOZqLJ6PUMIsbxdTW7/k0izO5p4OjowTHEqgtd2kS1cjcpdbDpp7KB8eJddPs+qEc4+Bm+Pq0RtRfbMQRP3Zv8tq9Rs+KUmAkE0yZS/O8m7r4YxnYBMaDuXGIq99CJPwcqhEgEWc/2K85EnqCOX+VrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UJZyfhyb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SKL4KUj6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMufb028893;
	Mon, 19 May 2025 21:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6dQI3NPHAo9H0FhYWNsE1+ohX18QK/VHYt01fYT5iGw=; b=
	UJZyfhybzD6GtfQRWlhM7+ix56dQpPQpTKJAjeNbD+uwHLVLJ81RQPVkcN9Mg9pT
	mnCmX5VzeFOGOf74JsaFSzgH8CAyqLQ7d3S5WVYVPt0CEXRuGgHt5FszbqAapUUG
	DfzoSOerocB3BbMHKxM59BAVf3sUQ7MSwh0qE4rOIJ87LxRjT8svM/9B+fVUZall
	0Rhq/AK6RJGNBW89rjTl21m7qNQ/WF4aWVQzoG4/0tEsK3afKXu4jEFsFiXImE3o
	Nu4mnGj2c+nHatLGYfmfLOLzXJhh6KlSy7PwZtIk1QfUwcKBGjvFaFsewz875Cjf
	+FjPzbycmEQR5rMEFW98Fw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjbcuxmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 21:16:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JKnM7o000857;
	Mon, 19 May 2025 21:16:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw77e6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 21:16:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwYskFIHOW5mN8aw1TRVVyXiqon+iBy21iuJyg+iRcHoCq/JmMrPisEbV9XO7M80Z1XheCmi8o6pz07xJeFma+HGyRD2KtAaatDRegQC63wSme24kywrYDposNW3cNdcilcj0pzdGta2o1RiAQPtc3zRBG6OR9BpMOM2muCGS4N2cMlZPoogv3tUeY/TDpiDfyrOrbKof/Wbz7EtfhG3LVd5+ZWs6I1vhP2RUZzx3mpIG30m+HgkcEL86x/HQKhHSEONvtk+UQQ+lGJEHA2TGF4hhaAmIKSCc2mK3zJCBI3d+wICEKhi7mx1fy693whMYAwEMPuaNBsnFv9YAkWHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dQI3NPHAo9H0FhYWNsE1+ohX18QK/VHYt01fYT5iGw=;
 b=ct46jHFU7JydKqPIlrbWzDkDziOpSEfbSMdt/h7QfsYdEn562D4HWyo7E+Y1iZh7LGjOGT9OvUPicEGrhg5Oc+vWqg/x8hJIo5z+d+++znfU9ful0nKOvumoC4yDL0eNheplnhNUoxFSOsbyMGr8qyaBPmLZDgUPjPgEMEZHQJgEvVpZkv8R4Fg7c7k8+EkYZ5PEZ/wTO7lknGnIfzu9fb4ED0yuYSMYWLQydsiz3b96Tkyg/kx1hhJDqk86Tldi07vtSRCrozxKTWVKcZzXF1j1US1aFEg6PoWIlgCZnuQ7AdABK6d5ugrNzZd85HpDL6ahk8V4FESc6OUuv678Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dQI3NPHAo9H0FhYWNsE1+ohX18QK/VHYt01fYT5iGw=;
 b=SKL4KUj66js/nI976BgTkb/3OLf2FA2eey/QfNjBbGuUbtWzvFsJy2WH0RbO5sas0QLYI0fBwRcMFv6PIJB5FzUYFVXZd7Eb5Ju4XRE1k4bcRn7ojgBED4CXTjo8QDzc2DP/rFKDRPUcKyqviF+UJhME1JkyLftD2p6T4OYy9Nw=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 IA3PR10MB8300.namprd10.prod.outlook.com (2603:10b6:208:582::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.31; Mon, 19 May 2025 21:16:00 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%4]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 21:16:00 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
        "goralbaris@gmail.com" <goralbaris@gmail.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "shankari.ak0208@gmail.com"
	<shankari.ak0208@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 net-next: rds] replace strncpy with strscpy_pad
Thread-Topic: [PATCH v4 net-next: rds] replace strncpy with strscpy_pad
Thread-Index: AQHbyLzrJoRQ+USDl0mXUvNS/RtzQrPadPMA
Date: Mon, 19 May 2025 21:15:59 +0000
Message-ID: <43d0274b9e2d45f2dd81a4b8e74a6cfd247db5c0.camel@oracle.com>
References: <aCrXQtrGMIntkcZs@mev-dev.igk.intel.com>
	 <20250519125151.24618-1-goralbaris@gmail.com>
In-Reply-To: <20250519125151.24618-1-goralbaris@gmail.com>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|IA3PR10MB8300:EE_
x-ms-office365-filtering-correlation-id: b399d399-101b-4f12-eaa6-08dd971a5aaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dDNPdUZENDBTWlRUQWtocUpJY1FQaHNES3lURmdyT1FZaks1WlBQY3hWY25l?=
 =?utf-8?B?Y0dLbGRyaDcrTlRXQXZRS2RpKzdjd2kxa1A3SkdSeUtOWjM2UWQ3OEt0SmtZ?=
 =?utf-8?B?ajZzaUVMRTUrN0FydmJjUEkrZmRCczdTT0RKRTVrdGczUzZjcnZhaS9tdjMr?=
 =?utf-8?B?bHlyRk5uc3Vncks4UCtWNjZzWUZESVdoaE50RVZLTm1xTDh2WUdLOXYrSk15?=
 =?utf-8?B?WEZ3a1VFanZoVDlSSWZ0UFVMdG1DYmFPYWViSS9lSXoxaExUVGhaZWVaYmVP?=
 =?utf-8?B?YWFUU2hQbGtDRXBCeElhYURLUjZCblJJZmwyK0o0VUFYczVSNnMzTmw4NUhU?=
 =?utf-8?B?NTJFa2xHL3JtcGRJTHpJM2pWYjh5aUFITjZBTEs3VjYrRmRyRHplTUVWUkVr?=
 =?utf-8?B?RnBmWDg1QXdsczdYbUlZVW0yeXR5dkQra0cxYTJab0FJdGlydWV2QVgyVWh0?=
 =?utf-8?B?cDNUS0lSa2dTSGN5ZE9xUk1zN3ljRkJmcGJ0Q2FuMFJBQzlNK2luSE03Rlox?=
 =?utf-8?B?MUtrdkIvQWFrb0FmTThQTUVYOVl2SEF3UDU4eUlLYSs2andUc3pEMUdnb1No?=
 =?utf-8?B?R04zMENDTjN3SEE1K2pMTWY4ejczNDVzQmZ6dHNzUUYwZmhnQTF4ZHE4WVcr?=
 =?utf-8?B?M1pZc3dOTWJLMndzWWg2Z3Y0Skhycy9JRDJwOGp5eCtqMVVOVExpczJIYkVM?=
 =?utf-8?B?RWxvcy9aUVJRWHp3QmlEWHJGSDM5bWVHUDI5Z01rZ3JuaWJwdno0NHJWUm9r?=
 =?utf-8?B?QWlqRzFjcjUwWGIwL1ZUZHRnN0JQYzMwUy84aVRid2VSRG1QRlZ5d2hsY2hz?=
 =?utf-8?B?N09rN0h3TU5SVFZHSXErNHhJRnVSVzVvbzRLVVVYdFZ6V0FuZFIzTS9xVHZ2?=
 =?utf-8?B?RktvU3d6ZkNYQVFQTWlNUW9hSWorTHRXSGtmU1ozVWNYUW9hNXBiQlBuaVVJ?=
 =?utf-8?B?L3NrcXhiZS9US2pjSktjeTF3OFhGN2c5aW5RZzVjZVNBVnM2TjF2YWU1SWpF?=
 =?utf-8?B?SWYyOVpQNGtDemFaZmpaM3c3WXY0VXQxakNlMVlZanZrdE5mNDNSSE12V1J3?=
 =?utf-8?B?Y3AwRnNRVHRBOWJFdDNMeXU1cURSb0NWR0p3dk9BcTVMTHVncDZ1SWs3WWVJ?=
 =?utf-8?B?bEN3Rzc4bVJML3VpTHJJcjlsRmJRSWM1bnhqSGYxODdBeFZsVjY2Q3E2cTlR?=
 =?utf-8?B?THpxMDVQdGR3cDd6NUYyaDFwMlRDZS8zMXlLbi9BRnNWaHRnK01sZ3RSMEFq?=
 =?utf-8?B?YWFQamQ2TitlWmlGMDJXUjlrS1k3OUhOTm1tL3M0V2Jmd21FdkNqR0lJVTUr?=
 =?utf-8?B?SGdMa3pERndVdWI2eUk0TUprWm1TN1ZqaTFudmlTajJkOHFzWUJrcUJ2T0lj?=
 =?utf-8?B?QlZUejJESGtaY05TMk4ramJET3BpWGdHMnV6SjBsbTRhdVgwR3lGOFNSN2c5?=
 =?utf-8?B?OEw1Q0MzOG1QYTJ4VmRmZUZlK0JSMzQxT2RQeFAvZGNpWWJNbUVKSlRZcnpL?=
 =?utf-8?B?d0g2UmtHMWcvdUtCQXowTGhZRE56SWZQUHNudVNFS2Ztcll6YmhKOHV2WEZX?=
 =?utf-8?B?TFhRTWZlTVNrbUR6SHhXbUNpZkdwWWVRRXZJS0dwcmdhemRwSXdiczk4Ry91?=
 =?utf-8?B?aW1CU293MUJLWG1ZU0pZeGVrTVprR1dCaytlNzBkNm5HNTA1eVNXSzNxTkZO?=
 =?utf-8?B?VG1yTjNXSGZrV05pRVB0M2RkTFViRUl6bFFOcUxRVDN6YWZKN09na0Q4Vk42?=
 =?utf-8?B?MWhHb2l4TUdWMzRuSjRRdFc2dVowNWw3VjNmMnhJVkxleURCUzFrM1Y4ZlNP?=
 =?utf-8?B?NHo0MWhaMU44Mm9Mb2UyYmhsOElnWGhPUHozRjVZVXllb0RwYUxWRFNhc2RQ?=
 =?utf-8?B?dUhCbTF0Vm1KNVJqSm4wZWYzZGVmQTdtMkJCblZYb0ZPT21pdFJNMTNtaDdl?=
 =?utf-8?B?V1Z3VmFUczMyTDZHUVFBZzIwdllNeDdFcDBkTDVQR3Qrc1FCSDRpRzRPTUV2?=
 =?utf-8?B?RG5TeWtOVS9nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDFPV2Z3YVFFbis2ZUVwUGhrVy82YUk3VGtvOW1kQU03WEpIdXFVZmF4OXpr?=
 =?utf-8?B?Y1BtWmxtbWVLRWh6QjVwZDhCb3BnMmVvQXAyNzRYN0laUitzZVV4OUV6a0gw?=
 =?utf-8?B?ODh4cU9wMG8wUlVZSk5pZitRcUxCWEVubHNUMTNXSm9FME9IU1ZEQ0ladTNh?=
 =?utf-8?B?OWtuVWtrYk01NmtBR212SUE1Y0swZnNmbzNvckRiclZROXVEOUtqVTNXN21y?=
 =?utf-8?B?RGt2UHJuZ0YzYkZaWWorejBJd1BMdUpKVVI5N29YakY0SXJ0dGNZQ0lvb0la?=
 =?utf-8?B?aDJRTkUzSlMzQlY2RUw2TExWTHVNS3Z3U1pJRmlsa01IaDVFaC8vTjFWSTUr?=
 =?utf-8?B?NmZkUHBVdWVvMGZldUJFTlNndkFpREtnRnd1bmpJOXNJcWRubFFXaDVXNGVm?=
 =?utf-8?B?dU16b0t1NHNvQ0d4MHlaU2VWK0VQbGFLZ2I5d3c4clI5SnoyY3F5bkU1em5Y?=
 =?utf-8?B?MVFtSkdZNzBYZjd4WnNhRmllOVRtZzd2Rlg5YWR2bHV6M2IwRzRJNWxlQ0VT?=
 =?utf-8?B?Um1xcUNhZTQrc2dORHlDYnBJM1ltOUtxQzYwbXhEWWUram9TOFJmVGtMc2c1?=
 =?utf-8?B?VGMvLzc2VTNtNitNYmlad3V4Mnp4WHdrUC8xRm83RHM4aUdOMEdXbkxoeDRP?=
 =?utf-8?B?SU92MUk0MGhYS2R1WDVqNHZsNnlZOGxLNnZENjQ3NStseERCRi8xdFltRm83?=
 =?utf-8?B?Z2RjWnJBaDlRNDBsdlpqWmxtUmhySmFuWStsVkNjbE9uNU0rcHEzVHBjQW1F?=
 =?utf-8?B?V0dZY1NXdXdmZ1RVRGFacjhGVGFIalRUVEpOY01RSG1OTkFXZXhUVWhIU08y?=
 =?utf-8?B?aTRLbGxYYjBNakVlSmJiRXFvK0pyMndEWU5iZGZGYTVKMVZhTkVvclhVRnF5?=
 =?utf-8?B?TEJJNHl1VC9kaDQ5VTFaV1JlNExvOXAvTXl0WTUrQmI3TmhrZU54S3lyNktU?=
 =?utf-8?B?bTFPMXJHZmhGT0JQb0FjajQxSlpibTZvVlM5ZS9aam5KTzJCSDA3dmxWUGJT?=
 =?utf-8?B?T29sREE4dUdVbzBrdWhBOVVXaUY3Y1pwZmwzVE1hTjZlejJ1THlBM3djM2F3?=
 =?utf-8?B?OXlUbitOaHppNGJZT1E0QW1WbERpdE1Lbk85ampsN3ArdlIrMW56aTJlL1NZ?=
 =?utf-8?B?NWxoS1MzR3RKVHlaMjNRemdIOGJMMjhzNkk5RmZQM3FqZEZUOHJKTForNFB1?=
 =?utf-8?B?c0pvcUdyQUFOYWQ2MDRldzRJNVlHankrWit3dmhrV2I3c3J4RTA0R0lMNHZC?=
 =?utf-8?B?eFJYaUhlaEtpVGppYWJWMEpMd3VNdWhhVzNQQ2JRakc1OGJpVFRmVFF6UEJz?=
 =?utf-8?B?dXdZVTVlczNyWGdLMEl4UzdaVFk4VFJJNnUyTWtvbEE3cHEwQzBoYVJSVyt1?=
 =?utf-8?B?UldiNzgyalVtUklGbXF3b0tlUE1uZGR5T2l1WHBETzVNeVlYd3U2MWd1YWhS?=
 =?utf-8?B?VnlTNlNnbkxjcXpQeEFFOUdKQ3BUR1VVRG5aNVhBMEVZV3VPbHhXT0lnZE5h?=
 =?utf-8?B?Ti9rcXJWRkV2VVV3MklJK2EyanhtV0lZMmZvNkN2WVVaNU1JbHBzb3hDdUZl?=
 =?utf-8?B?UllKZnZMdHFvRkZHblFyZGJaK2tMZ21wWHVxemNVWmJDWDl0SUlDV2pjSXhB?=
 =?utf-8?B?VWRjNkhFcm9YRmx2RkR1aVRzdlZjK2VRclhuSmdFckdlVk5nV3VRcDJVSjJn?=
 =?utf-8?B?Kysra2hUTFdGMzY1dGRNK2xkcWhuNUFVblViVGpadlRvMkFmemxYVFZxYyt0?=
 =?utf-8?B?QUwybzA4ZS94Q01Cak5OZ0k3ODZYa292a3dVYUUzV1pHT2Y4Mlg3QzhMUU9P?=
 =?utf-8?B?cE4wWlBLUHphVzZDdEJNRkIwVGh5TnFCUDFGdWR4RjhSenhaSFRsbklzbTdG?=
 =?utf-8?B?TzJoRlZUZW1PQ1hGTUI0VDFIeUs5U2lmeDBuMmorSUFqM0VhVTVCeU1CZmFn?=
 =?utf-8?B?c1VkM05OSUtER0RRUDB6SElXek1MODdndmF1REVxZTdFbkVFSUZOYWVIZGE4?=
 =?utf-8?B?dnE0dWVabHNBRW50blFQZ0ZJTll1TEdER3dYUXNwNGNsOEVManNXeHFLWVZR?=
 =?utf-8?B?aUEwRjRDYzB2dThlbDhhTUhKcWFYcXlvMCtSMmFjK1VMWGNtaWdYdkphNUp2?=
 =?utf-8?B?Z1VncE9RRXJhR3JBMlBhK3JvdXNPcWVEaGUvOUdrT3FXenVEL3EycGpTekxm?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A186CCDD44D6C4438D60E025A1CC7F16@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k4JZan+mH7qLXF3x0j4gBMc8IBv/CA7fcQpSQxgcX68QNNfvKz+nqG+w8QdNQUG51vZwCSH1rXijSMejx4ivxFeYd0wFzJsshnp/rIuDv2dX6EEtFGcv2sq4sqvFzRoP3oWDJHzw++LzhL0bJnHJj4i4ru97bCZBYBBS03TvB3IICVGarCWtvv/uD/D7D2KDYUVviwI5Gx5WExEo2UFRrYuazfstA0XDqMUUMlsPHh/irL1TkIpDnIGR76/iw6pDLNrcvpyERfqxyZf0++7JgvwFih4D4kqz+YjnBqoIQYImDeIyairNwY952lWpXUjZw4rvYilBcAEYtQuBseX5kts+NTnLg80rVuqgtCAVInVgZ5CjAjaRaNEuW1TZYL/yQTrwcB1qLzJZtGzlhFKN4PDhBDmc/JfhhOTzQ5ao7V93cEUKjpf4dg2DHmydovDsKeGpUboA4mqXnAQa5N84SrXR2bsfbjO2nJG9j9KBSU64fJXB17ge0AcVzq52D+zXETtD1EYDgQ3/i08AwFaXQe+QM/DD3pnKd1U6WTCY9XQt5t7PVR2hX7h2YZ5tdh7mh4I7AJ840PYpiUQJHp7y1ngTNevXkPCRR14zY3Y9aag=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b399d399-101b-4f12-eaa6-08dd971a5aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 21:16:00.2103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lssx3IqbdXDi589SyunA8tNWzO70bwGh77ZduhAnVcfeE9loFEbzA7zIlAVM0PcMuQu8g42zlsRjbgBnmeGxg4cWANfLjzLAPJZLhmBw2f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190197
X-Authority-Analysis: v=2.4 cv=ec09f6EH c=1 sm=1 tr=0 ts=682b9f95 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=jtA1FCoBBHDSyEzX1tAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-GUID: Q4xibdD3ZJqLVLowqz0WAACnVcNUgL_V
X-Proofpoint-ORIG-GUID: Q4xibdD3ZJqLVLowqz0WAACnVcNUgL_V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE5NyBTYWx0ZWRfX0D90G5+dPsOw 5Eu5VcdZOu9ESrVaAlf9nO8tJvXiPjWvwzKHzOD09XJbUEjv+1JUHi1aWTDxrLCPC5diel08UBe 1XnupWOuXWnHEPF4aq2EHSHkiUEuMGSTpVvIpDLknUFbYXr7EoGCJS4A2fCTGOKt2IOm0geyDfu
 x2iwIAKRB4z7BhGkwPd+Htn2GJugbPywqBR2Ri16K6MpYk4kPuP+ICHMjEsVPewq8cTEWpjGc/+ AYu+Om8ruJaBdVMewZ8vjcbHBDoERt2iQCL+EYMvoBjyp8WjUUifDV3yifF7195/D5/Wtq3GEdZ K0M9WS9hYSKCyOJuSHYPAb21x5eQIHeXaUGc6Dcz3v7dpt5vvzWrtg/GWBKhTzDa21OfaNzqpNT
 BrqijmC1WjSq42Cnkhodz/adDn6LOT+fTOBKbRP1gV3DZKBXOiYCFVLOmbaVjSR5OKqNOF85

T24gTW9uLCAyMDI1LTA1LTE5IGF0IDE1OjUxICswMzAwLCBCYXJpcyBDYW4gR29yYWwgd3JvdGU6
DQo+IFRoZSBzdHJuY3B5KCkgZnVuY3Rpb24gaXMgYWN0aXZlbHkgZGFuZ2Vyb3VzIHRvIHVzZSBz
aW5jZSBpdCBtYXkgbm90DQo+IE5VTEwtdGVybWluYXRlIHRoZSBkZXN0aW5hdGlvbiBzdHJpbmcs
IHJlc3VsdGluZyBpbiBwb3RlbnRpYWwgbWVtb3J5Lg0KSXQgbG9va3MgbGlrZSB3ZSBsb3N0IHRo
ZSBsYXN0IHBhcnQgb2YgdGhpcyBwaHJhc2U/IEkgdGhpbmsgeW91IG1lYW50IHRvIHF1b3RlIHRo
ZSBsaW5rOiAiLi4ucG90ZW50aWFsIG1lbW9yeSBjb250ZW50DQpleHBvc3VyZXMsIHVuYm91bmRl
ZCByZWFkcywgb3IgY3Jhc2hlcy4iDQoNCk90aGVyIHRoYW4gdGhhdCBJIHRoaW5rIGl0IGxvb2tz
IG9rLiAgVGhhbmtzIQ0KQWxsaXNvbg0KDQo+IExpbms6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2dpdGh1Yi5jb20vS1NQUC9saW51eC9pc3N1ZXMvOTBfXzshIUFDV1Y1TjlN
MlJWOTloUSFKYTVhVmo5dTV2RHBlQnNpTVdJR0Z2R2hWekNiY2otZ1VPUzlxSWJRX1FEVkF5X0dV
OUU0eWxfeUNqellKNjF1RWZ1bzM2OHp2OGJZNXZzbUI5eXhSLTdoJCANCj4gDQo+IEluIGFkZGl0
aW9uLCBzdHJzY3B5X3BhZCBpcyBtb3JlIGFwcHJvcHJpYXRlIGJlY2F1c2UgaXQgYWxzbyB6ZXJv
LWZpbGxzDQo+IGFueSByZW1haW5pbmcgc3BhY2UgaW4gdGhlIGRlc3RpbmF0aW9uIGlmIHRoZSBz
b3VyY2UgaXMgc2hvcnRlciB0aGFuDQo+IHRoZSBwcm92aWRlZCBidWZmZXIgc2l6ZS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEJhcmlzIENhbiBHb3JhbCA8Z29yYWxiYXJpc0BnbWFpbC5jb20+DQo+
IC0tLQ0KPiAgbmV0L3Jkcy9jb25uZWN0aW9uLmMgfCA2ICsrLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9u
ZXQvcmRzL2Nvbm5lY3Rpb24uYyBiL25ldC9yZHMvY29ubmVjdGlvbi5jDQo+IGluZGV4IGM3NDlj
NTUyNWI0MC4uZDYyZjQ4NmFiMjlmIDEwMDY0NA0KPiAtLS0gYS9uZXQvcmRzL2Nvbm5lY3Rpb24u
Yw0KPiArKysgYi9uZXQvcmRzL2Nvbm5lY3Rpb24uYw0KPiBAQCAtNzQ5LDggKzc0OSw3IEBAIHN0
YXRpYyBpbnQgcmRzX2Nvbm5faW5mb192aXNpdG9yKHN0cnVjdCByZHNfY29ubl9wYXRoICpjcCwg
dm9pZCAqYnVmZmVyKQ0KPiAgCWNpbmZvLT5sYWRkciA9IGNvbm4tPmNfbGFkZHIuczZfYWRkcjMy
WzNdOw0KPiAgCWNpbmZvLT5mYWRkciA9IGNvbm4tPmNfZmFkZHIuczZfYWRkcjMyWzNdOw0KPiAg
CWNpbmZvLT50b3MgPSBjb25uLT5jX3RvczsNCj4gLQlzdHJuY3B5KGNpbmZvLT50cmFuc3BvcnQs
IGNvbm4tPmNfdHJhbnMtPnRfbmFtZSwNCj4gLQkJc2l6ZW9mKGNpbmZvLT50cmFuc3BvcnQpKTsN
Cj4gKwlzdHJzY3B5X3BhZChjaW5mby0+dHJhbnNwb3J0LCBjb25uLT5jX3RyYW5zLT50X25hbWUp
Ow0KPiAgCWNpbmZvLT5mbGFncyA9IDA7DQo+ICANCj4gIAlyZHNfY29ubl9pbmZvX3NldChjaW5m
by0+ZmxhZ3MsIHRlc3RfYml0KFJEU19JTl9YTUlULCAmY3AtPmNwX2ZsYWdzKSwNCj4gQEAgLTc3
NSw4ICs3NzQsNyBAQCBzdGF0aWMgaW50IHJkczZfY29ubl9pbmZvX3Zpc2l0b3Ioc3RydWN0IHJk
c19jb25uX3BhdGggKmNwLCB2b2lkICpidWZmZXIpDQo+ICAJY2luZm82LT5uZXh0X3J4X3NlcSA9
IGNwLT5jcF9uZXh0X3J4X3NlcTsNCj4gIAljaW5mbzYtPmxhZGRyID0gY29ubi0+Y19sYWRkcjsN
Cj4gIAljaW5mbzYtPmZhZGRyID0gY29ubi0+Y19mYWRkcjsNCj4gLQlzdHJuY3B5KGNpbmZvNi0+
dHJhbnNwb3J0LCBjb25uLT5jX3RyYW5zLT50X25hbWUsDQo+IC0JCXNpemVvZihjaW5mbzYtPnRy
YW5zcG9ydCkpOw0KPiArCXN0cnNjcHlfcGFkKGNpbmZvNi0+dHJhbnNwb3J0LCBjb25uLT5jX3Ry
YW5zLT50X25hbWUpOw0KPiAgCWNpbmZvNi0+ZmxhZ3MgPSAwOw0KPiAgDQo+ICAJcmRzX2Nvbm5f
aW5mb19zZXQoY2luZm82LT5mbGFncywgdGVzdF9iaXQoUkRTX0lOX1hNSVQsICZjcC0+Y3BfZmxh
Z3MpLA0KDQo=

