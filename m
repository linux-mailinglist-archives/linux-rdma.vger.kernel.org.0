Return-Path: <linux-rdma+bounces-16982-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPksHg0+lWmgNgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16982-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 05:20:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C96152F65
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 05:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B58283034A18
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 04:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8C92ECE91;
	Wed, 18 Feb 2026 04:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H9pVJRP1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OJo55mJF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF2923EAB4;
	Wed, 18 Feb 2026 04:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388421; cv=fail; b=qyyzIy7nq/HTd2/XUKMunYtfQEhrW6sz7S+hAStKQH2XBG8QssyzG/yG0Lr/8DQEhNLPMQX6j+/SYgDbdYYA/gPrO9LFsbh8rIiNPm8EnKjumgzBHRfrBor7yaNTlvcdN2Kxre8cBD6ukoYRw5dAke9qcTdC3oXY/k8XfDPBcMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388421; c=relaxed/simple;
	bh=WhjttRH2FAAF/eX/1//vPEpOZvZ2Xdnnn7DlbmgeYOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l0KUnbo5xyN0HBowTlDfTWNG1KH53yiFKeW3Iz74Ckw7m+AdbYwDx7PcazAID+eHhgtjAJfO+ewHmEY1Vx7VXcUsLH8/yVyUskEU49vavzbaP7jFPuLryq/y2Umuv5CnSkIj8MDZB/FweTRpkvbkRmoLsGaFQaiu41sENPfyhG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H9pVJRP1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OJo55mJF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HGNUbh495460;
	Wed, 18 Feb 2026 04:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WhjttRH2FAAF/eX/1//vPEpOZvZ2Xdnnn7DlbmgeYOs=; b=
	H9pVJRP1rnSPJd8FIlqq9dd5V9SiJDwelTWG/xLUOr2suuc2bMZJu58WZ24bahR1
	ocI+zFxfpZIrhAL2sKjslP5/FbpeiGPG6OEf2iWL+eVSAAS5UE4kxL1TG46UjBOp
	qb4HPPyYIaaqpTrD81Bc6dqZzjDylfwl2y5HCSsm81iPEfbg39lgrTfLC4uC4S4X
	05XeesVNl+9Ng64PWU95dL1qqmH8Jf/tOItybxnkw9UUz7FOAglD7/4SUPAyllno
	BXM/XRUoIoQrGXGy3LccZeJzsosNYapv8LjAW4ZOIQfv7yCKTSOoD0yXvT1yY+fT
	Y8X6rpbBKmUvgAgFAgwqcg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj6mct63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 04:19:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61I2RFxb015031;
	Wed, 18 Feb 2026 04:19:50 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb22uaej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 04:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8smOe/kCmAZHwrYM9TUqnUIqBcEpJnxNeHLg1IPxIyDw+3orS9UDFRm/CXC1zMD1jWQOfc2j3LeiNhJcYQ/Q2Ts/O2zrnCyGGGFYnNJ2PCFaB4sEWdGLyxS7bnwwJLGL1j/qNaeh8iGlfSQM3BDNciFORqE0T4990S/QIDCwH0SwRpfRDkI/dPjDv7luajk/i/eg5x1E+3hHREzsrZ+xL1kELnoDT7a0PR9QgrtV95s6Wc7INcSp6oUYww1tPtYgHGL5PMaAhdoWosCxVyKc7J2NrgoiaNgB1WPHX6JFJf55346IL55J7QBqgU//XCxK2lykfgxltpBS5p+5WaEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhjttRH2FAAF/eX/1//vPEpOZvZ2Xdnnn7DlbmgeYOs=;
 b=ekw2ociW6SaDLl0MXNKla+ADEC6shZEnTz4VqD4l+EVAuNO/CE4E+8W5djVas0FEhAcouabGUXnMZtDhtv/ATWNXXNPLpuC7pfg+VVXLFm2SsGB1/sbGq0nRMOiaeERdzRokn/o4k4qXtOt+SE4voy+Tin9ngbY/CodBpBfP20QvCbY60kk9HVNRwVqfHn2jEioXbNiRnle6Iv8OfYuRf/gC+cUBjHqQXPmu+4O+Z+kD1Yw9TcSwVjlsUrLJCwN9ksgvvkKUif4VfTBKkmojSShpEDyETb7/gx3uuU3Vmp9QY6sAQO6dz04itEYt5a+TDKHKU0wwtvhUbNuvvgyglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhjttRH2FAAF/eX/1//vPEpOZvZ2Xdnnn7DlbmgeYOs=;
 b=OJo55mJFGcgRp4twjf6WlaBkDoVhNL09SaR+k9MufExX5Bs+JZ+v9W0FlAlxDSDMhJkTXz2zFPCxJCsRv78WofBmgO+o8+erKeRhVIIjBEfSrH2BkDQO2FaP8KR15ETK45Km1VqAFfqRU/MgHViOMGayoJRRYclGr2y5PlGM+so=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 MW5PR10MB5715.namprd10.prod.outlook.com (2603:10b6:303:19c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 04:19:42 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 04:19:42 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "tabreztalks@gmail.com" <tabreztalks@gmail.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "charmitro@posteo.net" <charmitro@posteo.net>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com"
	<syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        Gerd Rausch
	<gerd.rausch@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net v2] rds: tcp: fix uninit-value in __inet_bind
Thread-Topic: [PATCH net v2] rds: tcp: fix uninit-value in __inet_bind
Thread-Index: AQHcoBUCFUVeusE9406R183898kVY7WH23CA
Date: Wed, 18 Feb 2026 04:19:42 +0000
Message-ID: <0adadf1fae088e15a3929c0b1badce66204db45d.camel@oracle.com>
References: <20260217135350.33641-1-tabreztalks@gmail.com>
In-Reply-To: <20260217135350.33641-1-tabreztalks@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|MW5PR10MB5715:EE_
x-ms-office365-filtering-correlation-id: 48a2a7b3-84dd-4bbb-fc4f-08de6ea4f0a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cW03MWNwVEhSbDNjMm9lVWZLS2plTUNnazg0RjFDTlZBTzlsOFdWNEJIL2ZB?=
 =?utf-8?B?QzA1RmFCY2RSNWVHdXg3bU9QRk1XeVBtOUh1Z1pqZkNzdDVwNXdqbldsNWtn?=
 =?utf-8?B?YVh6aVFhYTdjejlCYjhCTW9pbEhhRHUva3AwSnk2RFNyYnhyeTFJQlNHcmpt?=
 =?utf-8?B?NlFrcDhHSXZ3dXgrSm5Od3dqTituTUFhVDBKR1pmUHA3RU1MVWlxdTFFYkRo?=
 =?utf-8?B?THBqQnUwcWt1R0FTM0I4NnFEM29DZFc0eStRemh4SE1lcklrUVBIRkUxeWRq?=
 =?utf-8?B?L1MzeEVaUkhCU0dKWnJoeWF0NzZNQi9WRFJBQzY0N3NUWlN4QktkV3B1NUVm?=
 =?utf-8?B?d1V6M0tpb2hNaVBqT2Fadkdkb3NmOGxxYmdFeHVKdklSZDl3bXhXUC9NYUNT?=
 =?utf-8?B?M2sxeEl4Y1lXRklleENKOTY0bXJObUl4SlIzblhMUUFKSjNSMkhwY0hMTy9m?=
 =?utf-8?B?ZlQwTGZyVHRHaDVINGtGMTBjR0FVRXJDd2hrNXNWYmIvV0haTEdNa0NYajNP?=
 =?utf-8?B?NlAxQWNtTVhXOEtqMGs3cVR6bzNudjlJSjZkSkovOFZZVEFaK213NmhmU0M0?=
 =?utf-8?B?Q01UWG1Pb080RWdWbDlDK3ZJK0dLK0pzdDlzOStCcE5KYklpd25NQ1FreHZk?=
 =?utf-8?B?L3ZBY2h0VzhRbS9YZjRudWtwQ0VpM3hYd3habzZjWHJBaDUyMDdLMTJ4RHNU?=
 =?utf-8?B?R2ZFcDVPc0o0SzJQcVV0RjFrZy91S3F4UnRLMVZheUlYTXZienExb0pxWXJa?=
 =?utf-8?B?WnBCNVZHQ09wZmlUemYzMEhBL1IzSDFaTEVUbjcrNDAxN3JmSE10VmdsOUk3?=
 =?utf-8?B?MGp5dU5LWFV6K0JsL3RKVGtNUGIvTkNRdXBPdnlhSVdDVVZsNDVUbHBhcWNw?=
 =?utf-8?B?aXlJekE0N05RYlVEQUdHblNibEhnenJUcWRyRzEwUndzaFNBQ3VvZm5RSEo0?=
 =?utf-8?B?TktLQ2pEMWJDR1V4WjRKSW5pTW1nNG5IYXFRWXI2RFMxVmxkVHlwQ3lqVzUy?=
 =?utf-8?B?V3EyT1JHZDBxNlRUOUw1S1FEMW1YZEYvaFNSM0pZR0FGU1N3ZzAvckRnRWxt?=
 =?utf-8?B?NUlERElsTWZIWnZXMXZtVWpyeG5WSTcrV0Z1LzhxQUZvRk04aWVQS3JJTFBB?=
 =?utf-8?B?WSsrZmtHWEFmTUdDdFYvRkVVd3pWdVpUR2l5dFdpL0JFZU1OVlNDRDFZTlpv?=
 =?utf-8?B?MnI1MXpYK0QvcVVoZlBtczJJbW9HbnpEenRNMHcvSkc5UUUwWEhwMkpZeGJO?=
 =?utf-8?B?a2FJV2M0V2FodDY3RlVLMGhNdnlEdjhoelFqbHlzUGZFU2NwTk42UWtScU45?=
 =?utf-8?B?OThvL0ZnbDBkb2J3WFJnWGJsSzNSbW9pU1YxS2R3T1dkNEZOdnBTZnBpUkpH?=
 =?utf-8?B?MG0ySkE5Zzljd25uWUdmMUN6bVJGUEJsWTJPVU9UYzlEb2t4Szg4RUZWL2Rh?=
 =?utf-8?B?MGhqWlh0U05KMzNjV09ldmZXVEZoZWdNaHpIWGhjK2VMWkhGY0E5clE2b2pW?=
 =?utf-8?B?cXhKU1RFblZyWTRiUWVmSi9GZ1R1MHpQSENKNXRiZUprR0tLMTZJSGZJK0Nx?=
 =?utf-8?B?UEhCVXhSa3h2bnMxZ004SDN0YkFsWGdhZG0vaTRnc3djMi92dmkwcEhkQSs5?=
 =?utf-8?B?SldSb3BSNlYrdXM1d2kwTVd6MkgyRFpUTG5UQVBjNlZWRG9jQ2s3SGRXRXZM?=
 =?utf-8?B?Z2RDb3lQVSt6VjRVWjhtTW03b2VsdXdCNDhyU3pGeVBtek5KVWE4RDQ1d2lk?=
 =?utf-8?B?ZzFaMGNQUFdiRE1IWEhUMlRJSnBBTmYxUVNMVHBLcjFuL3E5SUFJcGN5dVZY?=
 =?utf-8?B?b3BXbnJoaGJRZ25zVVMzQW5sREZMaEI2dEJ3aVdJVnZrU3FoVTVES2ppTFJt?=
 =?utf-8?B?d2JHOHEvYTVNZVp4QThUNUZOMGFhbDcrV2I4Z0tWRkFBRnhEZ3lQL0RWL3hu?=
 =?utf-8?B?U2N5aHh1TmZ4WTlCVWtib2d5bm0rVGZtVnJyWFprU1NKcmEwK0VVOVMxS1N0?=
 =?utf-8?B?QjNMNlJ4ZjJLS29Xc1M0bzNMS0tOQmFtcE5mbmR3VEUvSDJ0eWtqMmZDYWNM?=
 =?utf-8?B?RjNFNWpRMWF1QUZITTNtelZOOEV0VFhSQm5TQnRzT21ha3F4bGJHVmM4TVpi?=
 =?utf-8?Q?IjItZLRLLLVJFlbq1Ka/UnnI6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTUwN1hXdE5wbW5zV24rK1JZemhiSHZEWDlIU3p2ejdIM0RBb3hacWc0UldN?=
 =?utf-8?B?WE1JUXA1YU1KVUJZbmxtN1FtN0w0NXdua25CVk5ZSVF4YnU0bU9ITmQvZ3Ji?=
 =?utf-8?B?ZVNtcVdselZjd0VDeFYreVhQZ1h0QXhJRnpHVlV5YktDeDY1NFRrTVYyTTNF?=
 =?utf-8?B?YjFaYjI5NTB1c2JlK1MxdGxDaHVmUmowK1gwRHMrNStsOGlMc1QwOU1XbGVK?=
 =?utf-8?B?Zm1ab3pqRVczK1dqS1ZCQ254UVNXd1Bqc015UVVTcG4yZnphcHJYUE9RWGdL?=
 =?utf-8?B?MnBiOEhZc1hsaGdUR0YzbUdRVU9pYkJONlA5SGs0VTl2QXlwWUMyNEczbFpo?=
 =?utf-8?B?YzN2Y0xDekR5clp1NFBvaHllV2k1TVoxSjVrNGtuamFzRk50a3RjMnUxVmsv?=
 =?utf-8?B?dmJ1YWpTdVlaTzg2NjRZYWlrU3BtcVpzK3ozQjR1Z2hYRUNZQVd1cDRhdE9Q?=
 =?utf-8?B?SWRxYXh0SjNBL2w2UllLcGlkZGprcnB2Vkt0aElXK0hCSDJrN2Z1YnVoVldi?=
 =?utf-8?B?NmxkNUhualQ4VEQ4dG5Cd0FoMDViY2lqekxDYTlVRXgrejQ0MmlJdFl0WGlK?=
 =?utf-8?B?YlU0aytqcmhwYkVGcDNnbU9hTzA0T0hNbHNhNFB5WTROVVlVMVBGYjZBSGtY?=
 =?utf-8?B?ZkU4UjlINFlBR0tpam4xdmNYYXhUU2s2MEZQS2w2V0R5Y2tOWjJoeTFLYWs1?=
 =?utf-8?B?TGZTelZUM25OOFJWM2ZCS3Y5U0ZibTlDcVpzSmhGb0lMNVE5V3dBbnBjU0Vo?=
 =?utf-8?B?S2g0eDlwYnJ5WndXbXlSbmJJdDVmOFMxTjBVSU52N0dTaHRCOTZBM3ptT0RQ?=
 =?utf-8?B?VUF2MGNrd0sxZXBiTmVjRFRuaE40YmowNTBXZU5PTlVSd3dmOXVMZ3FlTndo?=
 =?utf-8?B?SS96YUhCTVV4TDNJQm9kRytiUDhQaThsVlU4M3hNaVRMUFdFQU0yL3RlcmRa?=
 =?utf-8?B?RVlsUXF5L2J0RmVCL2NUejZjYVcrWHVabXpFT005emx3YnJPTHBuMXBESjMr?=
 =?utf-8?B?WjkrdUhYOVlCelorcUxRNnJCbnhlUnVTRC9lM2VvNVZranBSdHZ0QUVISVpa?=
 =?utf-8?B?Z2o0QlluNVRkZmZQMXZPZm5lempRNGdhL3FDSmlCS2pocUZlaUxHS0JjK1Zz?=
 =?utf-8?B?dzduR2lRVDY1RXovOHZGbWdMbTA0OHZrd0RBQ3BqTG9pbklWV2tiYzdPT21j?=
 =?utf-8?B?UWFXZVZQWjh6dzlqUWFzM09uNVA5M21pZkdlN216VXY5cXRVc0Q5VHhsME82?=
 =?utf-8?B?SVIxUVB4cVo3bkdDZGpFVGYwajMzTUd1bFF4YWxxZkIyTHg0aWE3bzdOcUo1?=
 =?utf-8?B?c1pRay9vZlQxM3JyZXRmaVd0RjNiODFwK20za0t2NDhkUmoxZzBSZHhKY2dz?=
 =?utf-8?B?U1NUYzh1WWZ6SzRUS3huWkp1ZkN6Wm1yOGxpVW4yVldIQUFrbU1BOEVJcTMr?=
 =?utf-8?B?UnArREloUDVzNWYyZHNKd1JQS0pyZ3piREZpMlMxRHJQeFhhTlFaaGRicmt4?=
 =?utf-8?B?SjBGQ092L2UxUFh4SWpub1pzaVVESTNOUi9tSmxjNkdQcDlaTEIvbEwrd0ZP?=
 =?utf-8?B?YUJpZWxXVitobVF6VDN0dVlSR290cjVEOHZzbEF6eXdDRHE4NkpOb3pFVnJx?=
 =?utf-8?B?c010NVVzNGQxZW1aVUZ0cC9JTjluMGo2dWxiZVdXSmdLUkFaTVcrZ0kxVUlu?=
 =?utf-8?B?NkdvNnE4Q2R0NGRBZlR2WFYxeVVHbW9qYWhnUU56eTg3QkZtK2ZMVDhyL3pj?=
 =?utf-8?B?SldmajV2UDhEWk0yMXdpV3hhM3dENHA1aUo5TVFLdWtScFZUekZFWUpXVUpJ?=
 =?utf-8?B?M2RRYnV2blkwVFZBS09rZFhWYXhPY0M2bEFiMnY0a0FEM1FTN0FNMnh6ejg4?=
 =?utf-8?B?UTM1OHQ1R1VkNW5wbWt0d0hFUUIvTjBMZ0dWK1RUR1RhbEZTSFFoaG9yQllY?=
 =?utf-8?B?bEExR2xLQWdsbm56TmZsZWEwZUVpQjE1clUyRVpZTU9jQktyYmNvcndtMjYv?=
 =?utf-8?B?Mno0SVpQZDZwSFd0MGlmRTFtOEFMdDk5aldIWFNibGp1NDh2VU9CWEtOeVE2?=
 =?utf-8?B?QTVnMnYwb3p2MkdyZThNTS9KUGw2UU1BQW9JTEhuTVFnK1BLYmlWWTN1d201?=
 =?utf-8?B?cElLMkRVYTgwVjFGSmxlUklwVGZMZFNGSm5vc2ZLS3pvN0ROc25oM1pxWlkz?=
 =?utf-8?B?OUY1Q0NscW5IdW43dnMxZUIwb09HS1dSdkw3OXdoSEE3b2VudEJIN2tDVzNw?=
 =?utf-8?B?QzNvcXFiUXM4d1NMOGRTRC96cTFLWEc1QnZjSXBwaW1BLzRBVytyM05xTTZB?=
 =?utf-8?B?dGZUUWNxckFaL2V6VXZGQ0QrbkM1OXhKYWFrYlJvVlYxQSswcmU3SVJvaCtM?=
 =?utf-8?Q?E2bhf/HDwvH0aCmA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43CD6DE4EE86754DB14652455817A42C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NSfh/2um5dB8OClaxVEXOwaszJWcMjZJjT5UPXszWHY0V/AgTsK8kFZIK9aohud4mG228Qxh7WFFYtkwNh916i+9Ejr2DzJ7JEhiVNL7wMhRQKcHADYMelnDgElr8xNKxkLBbOjGV5etcKM8UnQaWLKPL0gUZTtg4ERf8ZRVusghOuhBsgNUP0J/3AWM/Je6ukT4Ox+7emZlvRSCzKmJosgV4YCXCd1I33lwv9kQO7/DFsrYCsnoj/ccK9tJmnw4YLBAG5hWtkyvN42ylqu/GPadkvvU0AQZl7HhdMXCgHTHc9lWzLEveNXETqZ3Sy2Gc6CL8n+o/SKDhgQxx4225MTVJP9CCyz7KII9E4fqxljptdsiiS0Di0VW8kSzquoW0aoaUv7tukMPLK2/+Mn6kWq/UwoYclL0ikY7MNdlX74+Zen1/FXz8rXWWhPRTZfVORO5LFNYJoS35f/lGdRJ08MH80oYc7zUlAe/74OzetNFLbrCy3NkOJ3SzrXIYMLAC41lX+CS4pHNMjEkI9VR/bXC3QWh13tYSTx1K9U95DvbEUlA5CQ5ZRHwbAb+evlhJ78ZJ70Q9qebLxCTl5+iPE6sYN2zJVi1LzrW4/7b/JQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a2a7b3-84dd-4bbb-fc4f-08de6ea4f0a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 04:19:42.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5ZAxwUrhbXIfKNuh9ThD4dBeqAoxsxUbI9z9k6kLQBmbwzjZR59eM7xzj3e60bEWdKL05WR1/4Zbk1TjGY4WRRLEwoQkQeAYvVLNOHJkQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602180035
X-Proofpoint-GUID: K3_8-oLPxNru9j3J_oiF7jggFmFFON8z
X-Proofpoint-ORIG-GUID: K3_8-oLPxNru9j3J_oiF7jggFmFFON8z
X-Authority-Analysis: v=2.4 cv=JO82csKb c=1 sm=1 tr=0 ts=69953de7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=xdtkT-d_jD0fx6FHEaMA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDAzNSBTYWx0ZWRfX7EZVC/QOcw8r
 o9Xz2cw0vL3JgIDWPezinyoR03ZoZR+OBVdmvOsst5lIN8+XW4ZauEbu2CKp0lZRg4KtlgCtXfL
 lAa4LtljkyI8rTAbRrMOKdoJEgHj/PO0XLR5LewteWUnUOe81IGrhIABaivj38d3xtpr5Bhg4vH
 rQapK4jJdbsGTWW9NZ9pFoLjVot0O46K4myqmuBYOKsSu3Wtbb7TjV/UDegFLxZbFHuvk3ohEPo
 8u19PmXqnjiN8xyhEXxftMo38mrqku2ZLuy2JrNotBTHVSrPHSMHb2pAr8uU3ufh6Mwt50xZBl+
 9Mgppi5CWWEqCoW8VRV6GgTg03lobZsL6l0Ayf5oxfWnhlaT6uEdIQBN6lYHNaChH/xx+WqHgLm
 BPoMLXekAKiZ/UweuRzbVsoZJcYcMMvdnHlWkuyeTSuoaZUu/yQUnMZR9rJELVxOHL8HQn2m6kt
 wJj77YBWEr1gTaapJtA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-16982-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,urldefense.com:url];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,aae646f09192f72a68dc];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E6C96152F65
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTE3IGF0IDE5OjIzICswNTMwLCBUYWJyZXogQWhtZWQgd3JvdGU6DQo+
IEtNU0FOIHJlcG9ydGVkIGFuIHVuaW5pdC12YWx1ZSBhY2Nlc3MgaW4gX19pbmV0X2JpbmQoKSB3
aGVuIGJpbmRpbmcNCj4gYW4gUkRTIFRDUCBzb2NrZXQuDQo+IA0KPiBUaGUgdW5pbml0aWFsaXpl
ZCBtZW1vcnkgb3JpZ2luYXRlcyBmcm9tIHJkc190Y3BfY29ubl9hbGxvYygpLA0KPiB3aGljaCB1
c2VzIGttZW1fY2FjaGVfYWxsb2MoKSB0byBhbGxvY2F0ZSB0aGUgcmRzX3RjcF9jb25uZWN0aW9u
IHN0cnVjdHVyZS4NCj4gDQo+IFNwZWNpZmljYWxseSwgdGhlIGZpZWxkICd0X2NsaWVudF9wb3J0
X2dyb3VwJyBpcyBpbmNyZW1lbnRlZCBpbg0KPiByZHNfdGNwX2Nvbm5fcGF0aF9jb25uZWN0KCkg
d2l0aG91dCBiZWluZyBpbml0aWFsaXplZCBmaXJzdDoNCj4gDQo+ICAgICBpZiAoKyt0Yy0+dF9j
bGllbnRfcG9ydF9ncm91cCA+PSBwb3J0X2dyb3VwcykNCj4gDQo+IFNpbmNlIGttZW1fY2FjaGVf
YWxsb2MoKSBkb2VzIG5vdCB6ZXJvIHRoZSBtZW1vcnksIHRoaXMgZmllbGQgY29udGFpbnMNCj4g
Z2FyYmFnZSwgbGVhZGluZyB0byB0aGUgS01TQU4gcmVwb3J0Lg0KPiANCj4gRml4IHRoaXMgYnkg
dXNpbmcga21lbV9jYWNoZV96YWxsb2MoKSB0byBlbnN1cmUgdGhlIHN0cnVjdHVyZSBpcw0KPiB6
ZXJvLWluaXRpYWxpemVkIHVwb24gYWxsb2NhdGlvbi4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBzeXpi
b3QrYWFlNjQ2ZjA5MTkyZjcyYTY4ZGNAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiBDbG9z
ZXM6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3N5emthbGxlci5hcHBzcG90
LmNvbS9idWc/ZXh0aWQ9YWFlNjQ2ZjA5MTkyZjcyYTY4ZGNfXzshIUFDV1Y1TjlNMlJWOTloUSFL
enpqaHFhYmhDMmR5X0FPbVJLNFFIRjNGSUx6R1IyRnhQbEJGVU9ZNmJqTnF3R052dnRnblpYaG5h
YjNuLTdiNzloUmhFa0NCeTg2WnB6dHMxZHpMckhnV2ckIA0KPiBUZXN0ZWQtYnk6IHN5emJvdCth
YWU2NDZmMDkxOTJmNzJhNjhkY0BzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQo+IEZpeGVzOiBh
MjBhNjk5MjU1OGYgKCJuZXQvcmRzOiBFbmNvZGUgY3BfaW5kZXggaW4gVENQIHNvdXJjZSBwb3J0
IikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRhYnJleiBBaG1lZCA8dGFicmV6dGFsa3NAZ21haWwu
Y29tPg0KVGhpcyBsb29rcyBnb29kIHRvIG1lLiAgVGhhbmtzIFRhYnJlei4NCg0KUmV2aWV3ZWQt
Ynk6IEFsbGlzb24gSGVuZGVyc29uIDxhY2hlbmRlckBrZXJuZWwub3JnPg0KDQo+IC0tLQ0KPiB2
MjoNCj4gIC0gVXBkYXRlZCBGaXhlcyB0YWcgdG8gcG9pbnQgdG8gY29tbWl0IGEyMGE2OTkyNTU4
ZiBhcyByZXF1ZXN0ZWQgYnkNCj4gICAgQ2hhcmFsYW1wb3MgTWl0cm9kaW1hcyBhbmQgQWxsaXNv
biBIZW5kZXJzb24uDQo+ICAtIEV4cGxpY2l0bHkgbWVudGlvbmVkICd0X2NsaWVudF9wb3J0X2dy
b3VwJyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ICAtIEZpeGVkIGxpbmUgd3JhcHBpbmcgdG8g
YmUgdW5kZXIgNzUgY2hhcmFjdGVycy4gDQo+IA0KPiAgbmV0L3Jkcy90Y3AuYyB8IDIgKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL25ldC9yZHMvdGNwLmMgYi9uZXQvcmRzL3RjcC5jDQo+IGluZGV4IDQ1NDg0YTkz
ZDc1Zi4uMDRmMzEwMjU1NjkyIDEwMDY0NA0KPiAtLS0gYS9uZXQvcmRzL3RjcC5jDQo+ICsrKyBi
L25ldC9yZHMvdGNwLmMNCj4gQEAgLTM3Myw3ICszNzMsNyBAQCBzdGF0aWMgaW50IHJkc190Y3Bf
Y29ubl9hbGxvYyhzdHJ1Y3QgcmRzX2Nvbm5lY3Rpb24gKmNvbm4sIGdmcF90IGdmcCkNCj4gIAlp
bnQgcmV0ID0gMDsNCj4gIA0KPiAgCWZvciAoaSA9IDA7IGkgPCBSRFNfTVBBVEhfV09SS0VSUzsg
aSsrKSB7DQo+IC0JCXRjID0ga21lbV9jYWNoZV9hbGxvYyhyZHNfdGNwX2Nvbm5fc2xhYiwgZ2Zw
KTsNCj4gKwkJdGMgPSBrbWVtX2NhY2hlX3phbGxvYyhyZHNfdGNwX2Nvbm5fc2xhYiwgZ2ZwKTsN
Cj4gIAkJaWYgKCF0Yykgew0KPiAgCQkJcmV0ID0gLUVOT01FTTsNCj4gIAkJCWdvdG8gZmFpbDsN
Cg0K

