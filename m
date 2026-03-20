Return-Path: <linux-rdma+bounces-18424-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMOQN5m5vGnQ2QIAu9opvQ
	(envelope-from <linux-rdma+bounces-18424-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 04:06:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D84052D54FB
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 04:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 534E9301BD78
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 03:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889A32DC332;
	Fri, 20 Mar 2026 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QeyoH6DH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="krIN86FY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2C2701B8;
	Fri, 20 Mar 2026 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773975940; cv=fail; b=mH+NX4oa1Fu30iaFwBGNgkL/A7q7vAWUOGiZmH0ewbyaein+QonCkRJPYn+S9dRzlq/jZbfdK5cetCSS+GtUo+TBw2YynEg049UvsWe0HulepYgCtf1LPwdOgJuqk78umVIltcnXokG5bqFxXMm0Asdh8Mg1icNSI22+ci1x2EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773975940; c=relaxed/simple;
	bh=u1NmgV1sMuv8KVrfNdgfqfmvaRXSYUEYY+v0iOB/nYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W50r7KV/scFkjnCcWvO4vM3fVvrh+QA8g9bfHUOx55LTUEi3SMW/SknaQ0szB6mX1O1EBAiIjK25OyJ8LtPapP2aQQw0bJJPygdqHptYlVNkkTdiY6d9K99nuYCilW/Ll9a8UjJCYmwA8hsHuj5uX+YukCHLuFAspOb6wn03fUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QeyoH6DH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=krIN86FY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K1RsSE1810732;
	Fri, 20 Mar 2026 03:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=u1NmgV1sMuv8KVrfNdgfqfmvaRXSYUEYY+v0iOB/nYQ=; b=
	QeyoH6DHTKJJQbxPEfctETbhbiIWvo0V8AMbVQUfVMVm5PECv+aShIPzqynJqPNZ
	3kubHcShbetyrYq4UDAmu2qY3xlukptmKeHrxSe3QCEFN+x/b1HV9uK47pv4klfh
	1jSSd27qR5Z8CE0CQumSfgbVP2GfY0gxzhhQUpW+lk/eJIgj/y+ypJZA5wppo2QZ
	eIgEyxG1mqzlVl7GZenNkK5Qki64m6cq8YCF9D3Mo+CVtMUGON+0iVVHV+YADt8Y
	7yDh1TdWZ9+/nSD9CLrY2AWvMe3LA564F6+mHYfd+A0CqFciWgWTgJ/ZK/fvk8ee
	v1p0/dmPfIZibcb4r6E91A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07rh0ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 03:05:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JNRAjl002900;
	Fri, 20 Mar 2026 03:05:26 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4qybfu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 03:05:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8MAO2wi3N3zU11iha8b5gNE7PUyLAAFGzYjLHe/o0JRp5HXRvnuSj64ZSQqHNmCuPLSJtpb0R9MYE32fGwz/Fc2WDMxQzvzom0v9hJDfYwqrcn4F5Ajzsr2PUjlH6ZTxNqV+uz095LY5PW66XumPaoMJqrtaX63htIjlPPtt7r3UnweDGxLX9H6UH1um2CB69HpJflAyJZ7GVFq8IBzr9rtez0Wl/9BuOI81U8lUogvuI6gmZsPMe+Ep5JMSWXG//biSrWbRTn07Pb0GrnybJb48Q2enEiqCZTFPKGT7ttCCmCYxPeYS3NUAJ0EGmLoZcRJCBzVQPLAfDjS7S5Pxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1NmgV1sMuv8KVrfNdgfqfmvaRXSYUEYY+v0iOB/nYQ=;
 b=hvf3BvnW7/QMgoEJwwCfyoPRMliM8zIxtEG/eEoK7x80wkNud25fruzYHDqywIlr5mbHtrRYXHMTqIObdWXDV20TzifyREE6qoqOpZOA1MMS5jnwUj4Z44KbEGs9rbVeyym07YVse7kVcLQmHw15NGr4NbMpm/qWNUP/RT83ib3Ep7A2Uql2TFWZ+ZSlDUBVj5N0riFnduGaRqg2Tpr1sx6W3hPWTV9g4oNeD5FDdLYUniUAG2fODeyhHKN9K2qSvwUH54KTBQmn97qZO5ia0+O7NXr+rY6USyCgYVwNfkl0fmy3+AXEGUwsnDsYbVlr4rLMqEy8k1cFgha31qlz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1NmgV1sMuv8KVrfNdgfqfmvaRXSYUEYY+v0iOB/nYQ=;
 b=krIN86FYslF9uTbdqauYusfzbxXYUtFlkP0vsw+JdBfTErcY55lUK96rhMRW+UpOiTqWxj3VnM+6HTcR4zztVaOx4ypLCbJeGwPt1KpWDUiysk791ZCkYHvQ+8DeWbmjAd0ek2xBoMfUA2ifjj5YAbphkjJ3xTUkpKKlIqUhfGI=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 03:05:23 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 03:05:23 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        "achender@kernel.org"
	<achender@kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [net-next,v2,2/2] selftests: rds: Add -c config option to
 rds/config.sh
Thread-Topic: [net-next,v2,2/2] selftests: rds: Add -c config option to
 rds/config.sh
Thread-Index: AQHct9zsEsrE2BMr20u8QHKoGih1+LW2vQyA
Date: Fri, 20 Mar 2026 03:05:22 +0000
Message-ID: <f0cf57ea9a139ea9af7556442304f8b70d416c16.camel@oracle.com>
References: <20260319004618.2577324-3-achender@kernel.org>
	 <20260319201329.1059998-1-horms@kernel.org>
In-Reply-To: <20260319201329.1059998-1-horms@kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|PH7PR10MB7056:EE_
x-ms-office365-filtering-correlation-id: 0348be17-a277-4569-f5bf-08de862d8722
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 dVm/OMdDptXE77ku0fI4k6iLkSYm1dFDT02r5j/NcDxBL43FKgjeGjEmDDT7/+BokUOcEZbTZVZPRSMxKc7gK+gMWm//ThJYwjfSqY7dAO4UvBvvLAZTYH9jQdUHbKPucBA0WtGuFIR/CQnhsQaKDFUOmhbQ+WWrw0Blou6hUU81r8f73vycaVb6xHp/GmRBxmV4ejZLsbGU8f8Hr6ZZj49CDh1JZi2Jjoyba75DAIfz877IJa0CDMd7TbRr9cJMNmqe3yyMbUvzel1uetbXUBFpR5qVFNgLOdvhfzoL+apSVvKI/3OxP2nw3/Wb7zDy0sYOHd71OVWlXO63gH2pDkjQAWsASm+G5GoPVnif/qNStHq0HeCRklX3Gd6G0OnduBmebPm3jmjMYHGsqJAdHCeLlWjwBIPgK6uwP57sWM6NoC84qCeL4rVUARdCODjqkFztA2+v/sgT1afeBx6JGQRyDGY0fa4Ftnoh3vnKsVrKmYgKlA57e3mmCwhmOH7wyoIr9vUtYkSv2M3nQx5wWYUoDna4abpJx5Ag33n/isws0j4SYAbSF+wIC8qgMqzz0Iab1y73GYh7dkUzPg3kIW07uuf/MtgIc9obzqjTkkZOra0hhPbACJr0JJyytawM32NIMSkf0+SgLVNyLA96660hpUHVksR71CM+mrmf88mZ3UbMqUhRnZDjFbOIgRiGY2v+C6qIbP18lZjZTsnmwa7M2OPpomxfezd427pQgVFAlfvB561QJOABqHCKdT2g
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTcyTndvV3EycDN0UzN1eVRLYkNFNHZQZVJRSENrMHlYb3FMNlAvSEw4TWsr?=
 =?utf-8?B?dFlaeGZIQWwrbElRaUovdkRvNXprTGpsWVRaQ2x1QkVnRkRyY0picFdkRjAy?=
 =?utf-8?B?NjJsVm5ybEc5ZU4zeUZ4bFRnMjk0RHVWSmhmK1ZoMmNWS2dQMmgrWkROWkVX?=
 =?utf-8?B?RFVheVY2VmVVVnQ2Y204UlJ4c2xQK2xtOTJXK0RkNVYrUEgxRHFjVmVTcE83?=
 =?utf-8?B?Ynl3WlpjOGE1SkhyWk1MYXErWWhZYTBjNTJJQ3Q0d2dpOFR5MmpDVkRlaENk?=
 =?utf-8?B?MVBHaHZBVERXSG9qcCt4aHhFMGhFQ1o3UmxkZEUzcUQrVjRncmFra0toeHpl?=
 =?utf-8?B?N3JMSzhJeXRBQitQZm55UW1aYU16Sjl6blNMeXlYME04eGVUTktoa3BFTUtQ?=
 =?utf-8?B?OVptUS9CREhGNmh4UzhsWXVINjN5bFBqbHdhbTNWVkhZRkdidysvMTVScGd4?=
 =?utf-8?B?eFhaWWlPUTU0d3NxNUlUUmR1akQ3M3Q3R0lHOWRZZ0pyNmloNVB5SEdSS3J0?=
 =?utf-8?B?L1JpUzRMdzNHakJBQURFbWJWUE9IdzZHaVVkaGhNTzRTZzZwSDB4Q1R6T1Rz?=
 =?utf-8?B?Yzc1N1JRQWs0ZHBFUURGeFFnRnEzM1l1SDdFMEJudEsvRmM0cW9JOXJFR2pM?=
 =?utf-8?B?SXNoTXFzUWEyUVYvaTB3SmdEV2NlK20xU2tQcG5hTnBWL3EvRDNDMHJ5M3hB?=
 =?utf-8?B?ZXY1VHVKN0g1dEMwWnJQVTBnNlhKRE9pbThIZGFSWGNPbGFUeUZOU3NiYWpJ?=
 =?utf-8?B?Z1JqSTBxTXYxc1ZGQlEwSG12MUFhVWNmSTZkWTVWYWhlaDRaVEUwUXU1amVs?=
 =?utf-8?B?emlrT3JaY3BpeVlsenZ4anJtaWtTRFRMYk9zYlU0bVhCa1JmbHNSVHhINHhH?=
 =?utf-8?B?a3JCNktidjNnYS9rZEJPVFdBZzlCTEpsTWpZSlJZMEtsR2lLalU5SUs4MmVE?=
 =?utf-8?B?TWhHNXhJa2JyTjVOeEF6TWJSYklnWFdMVjlsWmRQSVhXckN2VlBVQTJEa1JF?=
 =?utf-8?B?TWFmWE8vNjBvN0xCK2dmKytId1EyakxkSXpENTFhYlhqSmF0RzVrQVFEaXk4?=
 =?utf-8?B?TjRSUTlTL1V5dWkrMUwyMm9VcldPdzA4REtsSzQxR2FKQWl6UDBnOTFUdHp5?=
 =?utf-8?B?SU1JandUK3ZQeEVKWndSQmJ0ZVphd3lOdjFIZjBYUndrMWVmL09zeGgwVFZw?=
 =?utf-8?B?L3RzaE94RytCdEpTS0hscmEvb002YlNyNXNQdmlMT0U5WEt4ZDVwV09rZE14?=
 =?utf-8?B?emE1S3B2K2E4S0JKTUtUQTJoU0JCU0VFQUdMRllRbGthMVM3ZlFGSFZ5N3N6?=
 =?utf-8?B?cDV0VDVGT2F4aWlRZ1lGZzBzdnZwL0ViblV4aE1zN1dwc2I0WEYzd1FpbThS?=
 =?utf-8?B?VjloUWhSZlZ6enpQYjVWWlZ5YjlBZ1RQcHBQTkEwQUtXaTdPUkVnbEFFQ3N1?=
 =?utf-8?B?amtxRlUyRUtpRE5mYzNzZlpiY1R1Y1VrVmZoUUd2c09JRUdVaDlBNjhZSFEr?=
 =?utf-8?B?TDFUYWJXWU1EU1U0N09LSjd0akRDaDdmM1NMOU00QWlWcStPVkozZERkbGZS?=
 =?utf-8?B?VnRwMVRDVVdBVi9XZzJyZG1qQXNmVmRTYU9kUFY4VDhKMmVhR09rd2M2VU85?=
 =?utf-8?B?K2pYSVU2RUNRVU9Jc2tIRTFtV1lOV0ZmSFdGWm9SeGEwWWM1d2FCdTh1ejZ2?=
 =?utf-8?B?cTVrRzE3RUI4dDg1MllwclFwOFExQ0JGeHdsRENoN1Z2ejI4eGpHb09OTGJy?=
 =?utf-8?B?alJ0WmdGTyt1S2l2QzRlbVczdkpKRlJqT1FubzlRWEdKYUdETEl1NVZNZllD?=
 =?utf-8?B?VEY1L2tjTDZqQUw3K2tCNlBNZ2JqRHU0U0NzbnRZL01KcXNlUng1RmlTV2cx?=
 =?utf-8?B?b1NhK3gzVFZ5SkxoWUJaU3lFNk5pY2lUN0JiK3hlSU1NWjhPMWxkeVdkTmdW?=
 =?utf-8?B?NVN3TTN6N3MyUjJ2QjVGMXNrV0lOci9wSTFLOUNLNmJwb0dsNzJoZmtjY0Ji?=
 =?utf-8?B?N090UG1Id05wbEwvemdJZmZrS2R1Vk9Ha2swWlV0YzUybmNuVHhRcWl6S0hm?=
 =?utf-8?B?NEZZQnNSZFZHa0Q5QUtLZlFRWXZBV2M1TVZETTdDenVZV1RJa1BKQUpVYUU0?=
 =?utf-8?B?dVhsdlF6YmRpNkR4MGhJZGpFVkVHY1MvdFZGUm1JL3FDblgrdVBFSFltejBp?=
 =?utf-8?B?TUUzYTFIWmhqb0hjWTMxNnJVWUIwZ0FjT1h4OVk5ai9IU0R1VnhDZHE5ZFAw?=
 =?utf-8?B?MVNBT2lBS2xGdnM1dm55d0V6RENYS3lWdThlVGNEb2J4Ni9UL1ZOSzF0WGMv?=
 =?utf-8?B?T3R4OUMxeFQ3Y2IwMlVRS2hOejVaR1M0bDQ0QmR3L29tWjFYMFRFemkzOXBH?=
 =?utf-8?Q?A8+GU4siENDqfy24=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B78AB44B17011B48BF62F33A0D043FC7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kquLUzgZcfVndBV4HFhxAifiqvTH2AdKv+5Gr4TRsex8gkHPOoqkLoSCfBL0jo6nbmJSjMeKMyEL64pv4P0x3F9WVw3xkuD1fc26vxiWa40/Ts41We9dtpeFeRug2PRDaThoiGY8A9qr+3loAM4ITE7oypGF+34l75xMQh9brwko1DWauLS0vKi43Cr2apAERbKaj02z1gK6EKLM8D3ZIAuSQ2qPsCNP8fIQSalCnt1Othhgp7QIu+3WZg1YPhZWEmY1bWJ7vXRitoUh0uCK0qSyf9TMJh5OnwRCgv0t1A3ALkjUvXA8C8xx31HQVOx5+dxsvV0MD1CdNWdPJ5pFHQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YtmuqwnphLk+XRnlU1luaNYvPAHZiQ4oFsJhEMZkY2I+AlvDQxLsOvGXDQWnG3P43Pf/mYfkf+X7DrAp24PtPqGvs6so8EluhTCjfs30+scClxV0GlUagjy7RtT86gz/0yivR2npQ2OwruZ38N9wCVtMSkFyXzixOAUmmE2mL8f2BEwpto4gZU3gZgdfbWdC2qynRhM6pejtDOl4iwBrBdPVLMYG3R+IWe1w5k7qQbDSdu6HCH/YqOXrc0DGHaabrSMlzdy/mjYMhhYl/bDYyO4mysErHydH3WZgfqwRWWC/V5iAFenA1tQU3vZr9xOq0+gP17JRpv8QSD+gUMDIEG6CZFXF/J5OZl8+xPh2LrngHlYpGW1FWd4lOSc/mMjaylPC4mykECaglrDSXtilZrVGHX4D+r2CIUFGBMqlKGh0MH/kFHC4dQT+1xhODm5ZzLnJqoGD4hsUdTtKJsXIdhLzyaBri86Cb/vqyW5+JUkMSzev2cd7yvtc0dZB4KmBZ3YPshzUFiVTAcN/xZV8ubRPRfCkckoTW5VlEtG6+1dANfTIxbRLqhVONrapal5PMSOHaQP4RI2gd1oDq8twSCPQhS65U0wdyV5VFCVgOVo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0348be17-a277-4569-f5bf-08de862d8722
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 03:05:23.1329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rtcy6TRi4qRskrEh0gmjCX4qh4i0kCYnzMNJ4Judg9Rb8OmdpMHytEVPwtrAUe1k4apVfiiOi0eGo+5H0SvFSSe5QWY5BkEgaInSAQmGqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200021
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69bcb977 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22
 a=9R54UkLUAAAA:8 a=WPVpRamwweJFsCoS8EEA:9 a=QEXdDO2ut3YA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 cc=ntf awl=host:12272
X-Proofpoint-ORIG-GUID: SrHvWIyGqUoTWm2aFyOOJpabCTRnUgZ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDAyMSBTYWx0ZWRfX8zp6DavhE6a/
 Q4HjPzK/JBjW4fsp4wXmkRt5o8yOvXo8vyRGN2JDHQA08uuT6lAg+8jhaER5ArYOCQwL/LkVn9j
 /SHhjklwVK983d8ZYqhz0lYD/19MQU9CwH8S4RBXGuNg10tDAhume10p6hTMFFpAqGPkLXRM7ve
 jU2tqIAxajdXy8cEmEmPjp1BX6WSDTpNFnebSSmr40i6oY3GNKQZ3QELnT4h0t+rl/lGU9+tfgO
 4PtWdvartJpt2pK5WeByolAEfQQSj08crX9BnmyTeObj+6IMcS6UwF8XbtgMNFYowP8MFZdaTYf
 Efd1Vhyv4zWmrjwwHS02FcpHgcs/iNnlAeazER+JwqNLOtKw2ieYhKVP6r5ILRlGCGeLg5DkcJp
 oeUQ9iepDng0PXAjIdZiNS9GNzVduG910skBmgNS9q8q4fQdPIN/ZTlueoR9NT0gvBuvL8wUU0e
 2WibvBNLeLpJ/rovURYzl+owwn/NVY6XUFq38Kro=
X-Proofpoint-GUID: SrHvWIyGqUoTWm2aFyOOJpabCTRnUgZ8
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18424-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D84052D54FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTAzLTE5IGF0IDIwOjEzICswMDAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IFRoaXMgaXMgYW4gQUktZ2VuZXJhdGVkIHJldmlldyBvZiB5b3VyIHBhdGNoLiBUaGUgaHVtYW4g
c2VuZGluZyB0aGlzDQo+IGVtYWlsIGhhcyBjb25zaWRlcmVkIHRoZSBBSSByZXZpZXcgdmFsaWQs
IG9yIGF0IGxlYXN0IHBsYXVzaWJsZS4NCkFscmlnaHR5LCBJIHdpbGwgdXBkYXRlIHRoZSBSRUFE
TUUuICBUaGFuayB5b3UhDQoNCkFsbGlzb24NCg0KPiANCj4gRm9yIGxvY2FsIHJlcHJvZHVjdGlv
biBzdGVwcyBzZWUgaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbmV0ZGV2LWFp
LmJvdHMubGludXguZGV2L2FpLWxvY2FsLmh0bWxfXzshIUFDV1Y1TjlNMlJWOTloUSFOd3k0aVBT
ZFJBUDdCNWRwV3VjUEl1cERWMnR4dDBxSktnbUhiWFZQZGlCZzNNdUQ0cjlvZEp2Ymc4VldEZjg0
c1Etb2o4UDh5ZURIUE5oNW5WVSQgDQo+IC0tLQ0KPiBzZWxmdGVzdHM6IHJkczogQWRkIC1jIGNv
bmZpZyBvcHRpb24gdG8gcmRzL2NvbmZpZy5zaA0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3
IC1jIGZsYWcgdG8gY29uZmlnLnNoIHRoYXQgZW5hYmxlcyBjYWxsZXJzIHRvIHNwZWNpZnkNCj4g
dGhlIGZpbGUgcGF0aCBvZiB0aGUgY29uZmlnIHRoZXkgd291bGQgbGlrZSB0byB1cGRhdGUuIElm
IG5vIGNvbmZpZyBpcw0KPiBzcGVjaWZpZWQsIHRoZSBkZWZhdWx0IHdpbGwgYmUgdGhlIC5jb25m
aWcgb2YgdGhlIGN1cnJlbnQgZGlyZWN0b3J5Lg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9jb25maWcuc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9uZXQvcmRzL2NvbmZpZy5zaA0KPiA+IGluZGV4IDc5MWM4ZGJlMTA5NS4uZTdhNjE5ZDdj
ZmYwIDEwMDc1NQ0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvY29u
ZmlnLnNoDQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9jb25maWcu
c2gNCj4gPiBAQCAtNiwxNSArNiwyMCBAQCBzZXQgLXUNCj4gPiAgc2V0IC14DQo+ID4gDQo+ID4g
IHVuc2V0IEtCVUlMRF9PVVRQVVQNCj4gPiArQ09ORl9GSUxFPSIiDQo+ID4gK0ZMQUdTPSIiDQo+
ID4gDQo+ID4gIEdFTkVSQVRFX0dDT1ZfUkVQT1JUPTANCj4gPiAtd2hpbGUgZ2V0b3B0cyAiZyIg
b3B0OyBkbw0KPiA+ICt3aGlsZSBnZXRvcHRzICJnYzoiIG9wdDsgZG8NCj4gPiAgICBjYXNlICR7
b3B0fSBpbg0KPiA+ICAgICAgZykNCj4gPiAgICAgICAgR0VORVJBVEVfR0NPVl9SRVBPUlQ9MQ0K
PiA+ICAgICAgICA7Ow0KPiA+ICsgICAgYykNCj4gPiArICAgICAgQ09ORl9GSUxFPSRPUFRBUkcN
Cj4gPiArICAgICAgOzsNCj4gPiAgICAgIDopDQo+ID4gLSAgICAgIGVjaG8gIlVTQUdFOiBjb25m
aWcuc2ggWy1nXSINCj4gPiArICAgICAgZWNobyAiVVNBR0U6IGNvbmZpZy5zaCBbLWddIFstYyBj
b25maWddIg0KPiA+ICAgICAgICBleGl0IDENCj4gPiAgICAgICAgOzsNCj4gPiAgICAgID8pDQo+
ID4gQEAgLTI0LDMwICsyOSwzMiBAQCB3aGlsZSBnZXRvcHRzICJnIiBvcHQ7IGRvDQo+ID4gICAg
ZXNhYw0KPiA+ICBkb25lDQo+ID4gDQo+ID4gLUNPTkZfRklMRT0idG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbmV0L2NvbmZpZyINCj4gPiAraWYgW1sgIiRDT05GX0ZJTEUiICE9ICIiIF1dOyB0aGVu
DQo+ID4gKwlGTEFHUz0iLS1maWxlICRDT05GX0ZJTEUiDQo+ID4gK2ZpDQo+IA0KPiBUaGlzIGNo
YW5nZXMgdGhlIGRlZmF1bHQgYmVoYXZpb3IgLSBjb25maWcuc2ggbm93IG1vZGlmaWVzIC5jb25m
aWcgaW4gdGhlDQo+IGN1cnJlbnQgZGlyZWN0b3J5IHdoZW4gbm8gLWMgb3B0aW9uIGlzIHByb3Zp
ZGVkLCBidXQgdGhlIFJFQURNRS50eHQgd2Fzbid0DQo+IHVwZGF0ZWQuIExvb2tpbmcgYXQgUkVB
RE1FLnR4dDoNCj4gDQo+ICAgICAjIENyZWF0ZSBhIHN1aXRhYmxlIGdjb3YgZW5hYmxlZCAuY29u
ZmlnDQo+ICAgICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcmRzL2NvbmZpZy5zaCAtZw0K
PiANCj4gICAgICMgQWx0ZXJuYXRseSBjcmVhdGUgYSBnY292IGRpc2FibGVkIC5jb25maWcNCj4g
ICAgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvY29uZmlnLnNoDQo+IA0KPiAgICAg
IyBidWlsZCB0aGUga2VybmVsDQo+ICAgICB2bmcgLS1idWlsZCAgLS1jb25maWcgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbmV0L2NvbmZpZw0KPiANCj4gV29uJ3QgdGhpcyB3b3JrZmxvdyBicmVh
az8gVGhlIG9sZCBjb25maWcuc2ggbW9kaWZpZWQNCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bmV0L2NvbmZpZywgYnV0IHRoZSBuZXcgdmVyc2lvbiBtb2RpZmllcyAuY29uZmlnLg0KPiBXaGVu
IGZvbGxvd2luZyB0aGUgUkVBRE1FLCBjb25maWcuc2ggbm93IG1vZGlmaWVzIC5jb25maWcsIGJ1
dCB2bmcgYnVpbGRzDQo+IHVzaW5nIHRoZSB1bm1vZGlmaWVkIHRvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL25ldC9jb25maWcsIHNvIHRoZSBrZXJuZWwNCj4gd291bGQgYmUgYnVpbHQgd2l0aCBpbmNv
cnJlY3QgY29uZmlndXJhdGlvbiAoQ09ORklHX1JEUywgQ09ORklHX1JEU19UQ1AsDQo+IENPTkZJ
R19ORVRfTlMsIENPTkZJR19WRVRILCBDT05GSUdfTkVUX1NDSF9ORVRFTSBtYXkgbm90IGJlIHBy
b3Blcmx5DQo+IGVuYWJsZWQsIGFuZCBDT05GSUdfTU9EVUxFUyBtYXkgbm90IGJlIGRpc2FibGVk
KS4NCj4gDQo+IFNob3VsZCB0aGUgUkVBRE1FIGV4YW1wbGVzIGJlIHVwZGF0ZWQgdG8gZWl0aGVy
IHVzZQ0KPiAiLWMgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L2NvbmZpZyIgb3IgYWRqdXN0
IHRoZSB2bmcgY29tbWFuZCB0byB1c2UNCj4gIi5jb25maWciPw0KPiANCj4gQWx0ZXJuYXRpdmVs
eSwgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHksIHRoZSBkZWZhdWx0IGNvdWxkIHJlbWFpbg0K
PiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvY29uZmlnIGFuZCByZXF1aXJlICItYyAuY29u
ZmlnIiBmb3IgdGhlIG5ldw0KPiBiZWhhdmlvci4NCj4gDQo+ID4gDQo+ID4gICMgbm8gbW9kdWxl
cw0KPiA+IC1zY3JpcHRzL2NvbmZpZyAtLWZpbGUgIiRDT05GX0ZJTEUiIC0tZGlzYWJsZSBDT05G
SUdfTU9EVUxFUw0KPiA+ICtzY3JpcHRzL2NvbmZpZyAkRkxBR1MgLS1kaXNhYmxlIENPTkZJR19N
T0RVTEVTDQo+IA0KPiBbIC4uLiBdDQoNCg==

