Return-Path: <linux-rdma+bounces-14866-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC68C9D35C
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Dec 2025 23:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2C9D349C8D
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Dec 2025 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE402F9DAA;
	Tue,  2 Dec 2025 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E8JQZYwk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jWGnfSCX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAFE2F90E9;
	Tue,  2 Dec 2025 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714505; cv=fail; b=BezYgpYbVeY8jpgLqwafpttmhZRUqvOLTZeT7UqJwWig2yhTx0YA44ewZGR+ZXErhOwBLBXL5hvRExrFVbrGC+gfQPBFEeMk60K/GZdXzUJvuVeQvLzHEBMA4dVPntRhm85DhL4KvJ14jKGUzXEQCrhlwz0xVPJFCeRWGYgMKfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714505; c=relaxed/simple;
	bh=qDsruRT1Z0rwXOVfPLQKh1ldIE3onhJ/zmLOd4Z/P3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NVQE5NoRZEtULTqgaZVtWiEba1B5c/IrVsMJJv+iCy+uk/52yytObcDOliVFqaY6cQSobvjywQOCwiktiEGeVOOHHr6MwIdqnPKQmuA35gUeVvcqIw31ha+z7WOVzCEkXDWJ0hOUV53skY8LoqX3twzoLJBbDx5VeOznFdtMwgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E8JQZYwk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jWGnfSCX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2LCSho1084374;
	Tue, 2 Dec 2025 22:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qDsruRT1Z0rwXOVfPLQKh1ldIE3onhJ/zmLOd4Z/P3I=; b=
	E8JQZYwki64pM3XhIy/Jaugc1JiowMe28u+a/qiNX7ePdKaUTAizYVcnBY1dmDmz
	PS79R4dNRP18lLP/OyoY/6q/uQRNTSwjEBhPFnGHVBThJCMMgoS80fpOybg0+/YQ
	hNa9+jrE01592GujluBG9W87xHQOmmtt3aVJAlKSqkiFx2YN2CZ+JxRu7KIRZRqt
	lZkbeAtZgJwjOGeHJJJ21YM96amgRJEEc16nAfsLtE1QPAIXDQZIgsDRW37Zwb6L
	Lm4OoZBG09ELt7vuCaL1EEpaGtofgQ1bNAu7vV03+NCf6PhhEcGLDMeodIIDv7hL
	q4WkMbQHYO80dIbqb7IOmw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7wnc3tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 22:28:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2KxvcD011885;
	Tue, 2 Dec 2025 22:28:16 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9ky6mr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 22:28:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWXke/IT7IHfQGZ0FWsKFDDRkZiBYxi8tAw1CdD1jdn3hCTnJFrFw1wI9un39HFEiElo1M3m99sFoAxnb7/ozil93VWXLZAsM4M0nf56s90+zSwGx3kKbMd6jeXDM3ktMGheq2pSbIn6I8dEMOohlVUf7ehStc8GeQMRHaXLdT46D5qeyoIvIrOfxh2CfoCtrPNMPkDeJUSrIMfLmuxX4/O53b5YpO/JQjMBDCY/AreYTrLTM72F4LhiVqbnFjHysNlDPOftifGtHS98mLi3VKbta+8DH9E4jAeVw/GRLNRapNKvgsNHrlvL8/qpYZ47ULKqjXhIvIQdsoCOP95MSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDsruRT1Z0rwXOVfPLQKh1ldIE3onhJ/zmLOd4Z/P3I=;
 b=CRFxDe5G2x6aN9FY+pYGYN3zTmLVgH7FRVyHZYByrjNPgh9KFeP74vI6U8DUCdI3gSLH62vbWR/ro6If3ZOB8VINWrC2tK8rXzvkHywiFhjQQEhLX/it3R48zCDOqqUod9MDjUJ6ME0sgL80TV6o1PmoCo4fypWU7tkgbaNTcqXLqYG3yvCtK2vQqupZ535E9r3PjKBEJ/N7f/ATsp+HiLUKCALzSxjIJJjpBH1+QKUayxbaivAY/VwMbzyu7pfpQqjCR6kfkKcJBfSkK8y0JPaD+F4JilAPprzGKGD2qtxa5c646J1AcGNBdMOGwJtSXxhmnA8A8gohhSzNw5cecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDsruRT1Z0rwXOVfPLQKh1ldIE3onhJ/zmLOd4Z/P3I=;
 b=jWGnfSCXQjSn85ljD7C+u3b9LZOJxBD2XwIJo/uZ9IuAa2V2nMvu9fzjo1FXMcPke1mFTj+9hvg3HOACAWIzT7/bT+kGn45rs85o9WkoPNZ+tAfLchl/Xj3NuyrHPi4/YFPmfnV16deJWIvR5aCYuzf2tNGhM3I2jDS+1aGCAUs=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 DM4PR10MB6208.namprd10.prod.outlook.com (2603:10b6:8:8d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Tue, 2 Dec 2025 22:28:13 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 22:28:13 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        "achender@kernel.org"
	<achender@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/2] net/rds: Give each connection path its
 own workqueue
Thread-Topic: [PATCH net-next v3 2/2] net/rds: Give each connection path its
 own workqueue
Thread-Index: AQHcYok6zjFbg9YQ4ECfO9V/rgU/TLUOdnaAgAB6WgA=
Date: Tue, 2 Dec 2025 22:28:13 +0000
Message-ID: <64266e0ab45a37ce050b154269574d113137f9d6.camel@oracle.com>
References: <20251201061036.48865-1-achender@kernel.org>
	 <20251201061036.48865-3-achender@kernel.org>
	 <aS8BWWQDiDMjxpGZ@horms.kernel.org>
In-Reply-To: <aS8BWWQDiDMjxpGZ@horms.kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|DM4PR10MB6208:EE_
x-ms-office365-filtering-correlation-id: 345bbbfd-9734-41d8-b5df-08de31f214f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RHFYMjNYR3dFOCs4UytOMjk2MFB3VTFybklqa29sTURGZmNIN2E2RVcwL3hk?=
 =?utf-8?B?L3YwTXIwcUluY08yZnJNMnpGTnA4aWF3V011NmllWVF0SVJnQzF6WTZkdjVM?=
 =?utf-8?B?M2Npa1ZwWFladndhSGQxZVVXYjdobDFEVkhqZVpKMUtjRmtXQU1sWlBkc2Jh?=
 =?utf-8?B?cXV2TWFraFJuaWE4ZnZHeDNXVEszNlJjYmJLM0pTM1dCSjhzcWNEbVY0OEdh?=
 =?utf-8?B?UVJtSG02U0tnODlhamJJK3RUQnpwTEtQWDZoY3VDeW43UzMzb05RR2FrOUtE?=
 =?utf-8?B?U08zekx4ckFuVWpBYmhIbSs4b1l0QUhPamNBbjVhWDN5QjI0cnkzb29BYnMr?=
 =?utf-8?B?cXlKU1V5WjR2OFdtMUhuZ0RHamRVVEFzaWpEWVF3N2d4bisrcTJBVzl5QUU2?=
 =?utf-8?B?Smx3N1dHeW5vSncyUDRNeTBLcGxKbkl6VllYTTNzVHU5S3JOUnQzZmFHSzcw?=
 =?utf-8?B?S1ozcXZoeWpiMkFTRFlhRTVaWlhtUXp2U3dSdHdWdG42MVNCRVJ3WXM0UVNy?=
 =?utf-8?B?b1JKMUtITGttakd0Q0toUUZDRGZWaFU1alUzbzdkUSt6UTEyeGEwRytuZmFw?=
 =?utf-8?B?TEZtczdENG0rTVI0K0czS3VzKzk4VWpjaHlpTUs0dXB4MXU5UU1yR2hpeEtP?=
 =?utf-8?B?NGVmWmh6SktHNlhNNnJVcE9la25SR1dhdjBUOHh3U0QxS0NTV01ld2dBZkdV?=
 =?utf-8?B?UUpaWXRybXc3d1NETTA5Y09zVzNiOTFKeGt5QUk1b2ZRcEdqcHpnV3hudkpY?=
 =?utf-8?B?cjZ2MGoyZGFOYU50Mk1RbkNGNFU2YlBiNVZLbUJkYmhMaDdYYmx2RTNTeito?=
 =?utf-8?B?c2hUaTV4VHlDbGlBakNkK3RKTTJrbkxkV1pjWm5keWRVSnRZVE1aajRidFFI?=
 =?utf-8?B?Vm1zTTQxYUpENEJRL0YxcC9QZ0pGMVV3WGxobFcwbzFlbmZVL1VEZ2FTc1JK?=
 =?utf-8?B?aHVzNFIrZlNyYkVDVFVSd3VaUUQwM09HdGQ2VWFLV1ZCNkhlQ2tITEVUZ1Nl?=
 =?utf-8?B?L0hxZzdWWjdLallnYlpjVEt0OE9DeTB3cWdlLzZNV2hYWnozZ3VWS05VRmJE?=
 =?utf-8?B?OHgrQlZyMTdDbUFIYTlhK3JJV2xWZHByb0VvWU4zMlZMSlZhMDkrSlBBb2tI?=
 =?utf-8?B?ZmhzVllaclJvYk9TQ3RBYXRhbUpBamh3T0xUZWZ4MDh2c083Zkx2S0V4eUlk?=
 =?utf-8?B?Q2tsUjZPdmRscnc2L3N2dkdnYk9iUHozZXVLTkJJSnB2QmR6N1BMc3NpZkFL?=
 =?utf-8?B?SStpenN5QmRwblFnVUhVNzNHYkZYeWF5UHpHNzUwc3JmZzYxaVduSGRGRjFm?=
 =?utf-8?B?aUFQTzAxUHd3Y2FzaGxNK0JqUDk3TUpvNTMxK3lrY29JZTh1MDlId2MvVkd1?=
 =?utf-8?B?VkJwaUtKN1J3UmFVQWRaRUFnR2hRQU9CMWF4U2VrR1F6dEFUUnhvNkM5Q21N?=
 =?utf-8?B?aVgvd3dwUklPb2F6YVlBWXZHNTgxc0hseDFWak9lNWZpTk8xdGFQTGhKMHpm?=
 =?utf-8?B?bTM3TDVINlNlOHQvUDZBaXN6RDNSdzc4UlBzNWphZWVoWWEzZUlnZmVuV2RR?=
 =?utf-8?B?THp0TW9FaG9VK1VqeEY1a1h3K3NWb0l5NisxTVRxd3JPd1dPMWJsbm9wZUky?=
 =?utf-8?B?M0hhczNMZlFtb05hWWx4bjdpUWFnRWtJNm5tZWlzN3p0cGs1aVhWNnFoS0VQ?=
 =?utf-8?B?RFBIZUFHMUNCbm1nQ3poVTh6R2xmZ1lOZTQvUmFWSHhOWDFYbldNRTk3RWNl?=
 =?utf-8?B?ODRQdU5QZGpBY2hJY2hDYzVpYnJLMkZxM1AzYUR6V0VEYlVBQjNXODkvU1Fj?=
 =?utf-8?B?RnQyR09jNndsVDFGNGlkeWpjbVQvSnFmd2pIaTNtYmlBWDdZUUVwM0FhVEp2?=
 =?utf-8?B?dk1SUks0bkFkblE5MStucjhLZDQvK2swUlBUbkYya2dNSVpqWk5VUHMxVVVh?=
 =?utf-8?B?UVJaTUtGRXhzT3g5YzNNUkZkOEg0MERXYjBPRDFyL2VCQmNKT1JYcGIraVBu?=
 =?utf-8?B?a01MWTVpM0hnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekh5dWVvQWJMM2RpV1VGWHhpWWxoaXdVb3Z0SWFsaFdOamlxcFdRRDFWNHIr?=
 =?utf-8?B?U0F4cERKSWIrdDI1dEoyTW44SnR2Uk1uVFBsMzgremg0amw4b3BURFJzZXFU?=
 =?utf-8?B?M0ExamQ0ZWxCL1pJaU5oWVhMazE4WVR1Y25xVXFmNVFaR1Vtdno1TG9UTy85?=
 =?utf-8?B?K0xZUWh4TkhDZ3VwUElWSGFodUNJa0xOLzJZMW9iRUgycDZwcGtIZ2JNUTBv?=
 =?utf-8?B?ZldqN2k5U2xDb2FIcmM1OU94YWY4SCtKNEdma25HRjNzY0F6eUFuZmszTTln?=
 =?utf-8?B?Z053QlhUL2JnNzRSOHdQVkVKYVV0VFpuN2tIUzJKUk9WaTUyaW9CQjBPbDFI?=
 =?utf-8?B?VitlU0xxb2J1OEs2aHFraUE1YUZWZlptRW1aOVZ0ekk2aHRDdHlMWExvbFM4?=
 =?utf-8?B?dzltb2JMRWVjRS9QS3ZwOGUwa2lHakRGYUFUZkVzenF6M29WeThLcEJXbWEz?=
 =?utf-8?B?cFFlSHFlSThYQytGT3l6ZE9md3NNemVUMjRXZGpCNzBvdVI1eHpIWEdqaFBB?=
 =?utf-8?B?am1id0RQRjBPTityVTV1dDlpOVVWUXJmdjBiL0N4bTMxSlhkUWZrMlNoTnQ1?=
 =?utf-8?B?LzhidmtGRmRhdVdwaEpLQUpUY0Y3ZW05QXBmeFlSVUVndE9hUmVVR1VaNGRW?=
 =?utf-8?B?eG1QR04zZjdwNUVOcnR0SCthbmJUZ05xR1NDMWxPUXQ1ZlBRazdQUHdMR3pT?=
 =?utf-8?B?V2pGMVE1VUhsSzhBQnYyTzkyK0FLZ2xhYmt6eTVEVFlZaWkyVEN0UWZ1anNN?=
 =?utf-8?B?K0tRQUFkU2JrZWMyM2RRd3NLUmRWLzBkSnhLRHVuUVN4UXY1aUdYbjdVSjB6?=
 =?utf-8?B?U1RDMHVkWUtxZVN1bFQ2S3ZtZDNsWVpLU3A4Z0JUN2RmclJNK0pKOTRXaDln?=
 =?utf-8?B?bUVEQVg2RUNid3JJa01FaFNMYlNXMXBvWmYxOG80eFFjcVVxSk1PYXFaTWVB?=
 =?utf-8?B?ZURNbDY2enZpYklsL2VUUytHUGJLNU9pcEEyYVpnMXN3QVFNQUpYbGZxaTlu?=
 =?utf-8?B?ZmZ0cndXVnZhUHN4emkydFlCdTl4cXBnVElSOW1jYWVub0s1ZFJnMnN6LzBP?=
 =?utf-8?B?VkppM09iQ25UOFByU0VMYkM4T2ZKUndXVnZWcHdDalVkMzVuWHRRT201ZDl4?=
 =?utf-8?B?U1hEdkthUkdtMmZPUGtvNWJ3cWxFZFA3UDN3bUk3dktNUlcrODF0VHo2SkFV?=
 =?utf-8?B?NGdMTmd1V2Z2S2IxOGkvQyt4MmNyZkhOYzF0VXB0QlhuV1preE5zTzVoL3Fi?=
 =?utf-8?B?UExIR1pLci9jUGNWOEI5ZE5VMUxuR2FrdVpHVElYRGNuSFBxSStyUVFXVHZo?=
 =?utf-8?B?ZDRzZnIxWTN6YW1nenl6RkF3L3VtUDdWQ1Z6QTFqaE5KdU9sUTNOeXFJYWcx?=
 =?utf-8?B?MjBrUU5yakNLb0kzSTRvK0ptYjdJTG9RQWx5d204cHNmVExKajFXK2h5UHdv?=
 =?utf-8?B?MEUxVWphUHdVOGtRbk84Z3lCbHNNZWNoUXhaa0R3UE81WldtNnlTUlk0VXZO?=
 =?utf-8?B?UUc0Yk14ak1DWUJRVGkwUEo4am8wWFlZeU9TdmdQSEl1NGZXeGFIaERXYm1J?=
 =?utf-8?B?YTNSVFNvYWZmUU1YYVRwUlU2cGhoQkttQ0RtS2crRWhQVndNODhWVWlnaTNs?=
 =?utf-8?B?M3RjVWNiWEw5NGdVeDJQekNqTm9SZ0Q1SEo2VUdQeWlpNXdlTDdpNlZUTkNC?=
 =?utf-8?B?WDdkMS9TaVEwVUpxRjlORE9oTzI1cjhjbzVpWTBPSWRmYm5kOEVBZ0VlTm1O?=
 =?utf-8?B?M05UeFJnZ1R6VHBHVmFLa05sUXVpd3NHeFpBMW1YbW1wai8vOFU2OWYybUph?=
 =?utf-8?B?RVkyVzlpMVZraXlBTkNMNUdSMzlBbWVPUzhETkZWWTd4TW42Nk56Q2V4dWtx?=
 =?utf-8?B?dmFlTGZHS3BLTTdzYlFPdUZQRWxJaDhiSDE2dWpxS2JCNDVkZ2ZOUFovTlpl?=
 =?utf-8?B?NjgvQzVmNXZkUkRiRjBReU0rVmJjay9OakplRVh2dlo4UjNmRUs1UVhTRTB3?=
 =?utf-8?B?SG11a0hIOHVwcmR6QVBSTHBwWi9jN3pKbHhEUlBYMGpuYlJLQi92VGhqOCtT?=
 =?utf-8?B?Z0JvOXJuYWZLcC8xMmdpVWsxdTUzdjRMVHhRT2lxeFhQYTJXWElqUkZNSHpN?=
 =?utf-8?B?V2JRcGNqTGdaTHQyNEJLY2NRbG0vYVRMNVdHWXU4MnFxbkRuVFFHNVAwRVJT?=
 =?utf-8?Q?WH9OBeVWZ1aww46YoDzN+ck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41B21D0444569E45B71E1669053ABE9C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dvQ4ZrMhZoFCSah2r9gMeoE+ye63ILnfaAxDfOdjqtv6Uwvu53ySgiU+gA7ZLNdb2zYcWlr3nhvS7DJOMSPLEgaGHOSXa8j79TG/A9xyf0aKoBw1JeAZzHqEZpTRe0DxvfUKwZIyQWMk6E/RmCWzaLL44mVK+E98d2BRzwNNbIKMM6qbiu6IvLxPUbamySG1s8p8BJnXt8FO4GT8P9p0UyTrQm1/ECsFy73LB4mESpA72gO6eZJoauI03HgDXn2PMHFITszHCC/N8dhT6qUsMmFbO3JnQaIckKQURyTd580u9lklStqGpcg5Aie8NaVBBiv74U//g4zksjUYzWS/cwrIl6UaWJEnVBc0Y137hGrFN4zh9/Y+rtnhxSMfq4QMJYdPvHtBuuPXvhY0s+JZcPn/1VMPsiQ3JpKaGVojJStvy/bKhSG5PA/czPZU/AzmkLotqVjA2jA0McuN9DjmNsG+KsimlwrT9YKlgfB6aUBBuc/8nSl3SlaWzkR9dhSXLSzilYdhKdGpUwBLlVK77VU6jUqTJ6potMVcn+3IvYBocUYbYJr/oODQnay1Nzrpy+eTjzaqTcio+l/fYlnv2wCUQ/752wH7PZf+7W1x+vI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345bbbfd-9734-41d8-b5df-08de31f214f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 22:28:13.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yLNynorArzml4bXVMmGYfVpb9uBRk41OEosrclTpJ5cskkiKvsVydA6bgcZ9BDoJS3SwD6/mmVHJDYLTK1cmiALqDvQ4mTth0cqVSFCnalI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=891 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512020177
X-Proofpoint-GUID: 6pTw9a2M7T_rSE_PUtKXZsaUt9jXVRwQ
X-Proofpoint-ORIG-GUID: 6pTw9a2M7T_rSE_PUtKXZsaUt9jXVRwQ
X-Authority-Analysis: v=2.4 cv=SbX6t/Ru c=1 sm=1 tr=0 ts=692f6801 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8
 a=e7GO9_hy4MSE438vdjcA:9 a=QEXdDO2ut3YA:10 a=5hNPEnYuNAgA:10
 a=eQqmG7SDXQUA:10 a=z7FDjJ6tKMcA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 cc=ntf
 awl=host:12099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE3NyBTYWx0ZWRfXx3I2/9wLDCwx
 y0dIDDIg88944Lqk43R8IYpAjbpuGyHQPK0565a5ilU6QjtriCXSkOVDM0XfSPapBcn/dVbnM2U
 J30BdGAG7qt8LxZ2htBMwKSdML9dt1DYVej+scdAsvMgPy3ExrOEAroDG7WoK8q0vrpMXE+eRVt
 mSf/w3mcRFvKxVXo2Utn+xQIXNfS77qiHzrD6Y4CVh/Q1/LMtoDx126bjDb/xKQB9PwldbfWYVM
 c0pHvr4x6FH6v1gdBzYf3N8yk59+nCIEBgH+fTZUbnQMdMW8dNOWbfAzNis7npwwBMEoUIGTQN7
 oMKtJH4etcBXqcoUA5ad7y4eDntvCpKsJmbVqk1TbB+B8V+XfD0Ee3lNzRKma/BG+bNLniiS4Wd
 cMsbtuq0FW7pWDVEKXhtodnFH9X6EvHsaiky6HphECMHBtYVNRw=

T24gVHVlLCAyMDI1LTEyLTAyIGF0IDE1OjEwICswMDAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IE9uIFN1biwgTm92IDMwLCAyMDI1IGF0IDExOjEwOjM2UE0gLTA3MDAsIEFsbGlzb24gSGVuZGVy
c29uIHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQvcmRzL2Nvbm5l
Y3Rpb24uYyBiL25ldC9yZHMvY29ubmVjdGlvbi5jDQo+ID4gaW5kZXggZGM3MzIzNzA3ZjQ1MC4u
Y2ZlNmI1MGRiOGE2ZiAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvcmRzL2Nvbm5lY3Rpb24uYw0KPiA+
ICsrKyBiL25ldC9yZHMvY29ubmVjdGlvbi5jDQo+ID4gQEAgLTI2OSw3ICsyNjksMTEgQEAgc3Rh
dGljIHN0cnVjdCByZHNfY29ubmVjdGlvbiAqX19yZHNfY29ubl9jcmVhdGUoc3RydWN0IG5ldCAq
bmV0LA0KPiA+ICAJCV9fcmRzX2Nvbm5fcGF0aF9pbml0KGNvbm4sICZjb25uLT5jX3BhdGhbaV0s
DQo+ID4gIAkJCQkgICAgIGlzX291dGdvaW5nKTsNCj4gPiAgCQljb25uLT5jX3BhdGhbaV0uY3Bf
aW5kZXggPSBpOw0KPiA+IC0JCWNvbm4tPmNfcGF0aFtpXS5jcF93cSA9IHJkc193cTsNCj4gPiAr
CQljb25uLT5jX3BhdGhbaV0uY3Bfd3EgPQ0KPiA+ICsJCQlhbGxvY19vcmRlcmVkX3dvcmtxdWV1
ZSgia3Jkc19jcF93cSMlbHUvJWQiLCAwLA0KPiA+ICsJCQkJCQlyZHNfY29ubl9jb3VudCwgaSk7
DQo+ID4gKwkJaWYgKCFjb25uLT5jX3BhdGhbaV0uY3Bfd3EpDQo+ID4gKwkJCWNvbm4tPmNfcGF0
aFtpXS5jcF93cSA9IHJkc193cTsNCj4gPiAgCX0NCj4gPiAgCXJjdV9yZWFkX2xvY2soKTsNCj4g
PiAgCWlmIChyZHNfZGVzdHJveV9wZW5kaW5nKGNvbm4pKQ0KPiANCj4gSGkgQWxsaXNvbiwNCj4g
DQo+IFRoZSBjb2RlIGZvbGxvd2luZyB0aGUgaHVuayBhYm92ZSBsb29rcyBsaWtlIHRoaXM6DQo+
IA0KPiAJCXJldCA9IC1FTkVURE9XTjsNCj4gCWVsc2UNCj4gCQlyZXQgPSB0cmFucy0+Y29ubl9h
bGxvYyhjb25uLCBHRlBfQVRPTUlDKTsNCj4gCWlmIChyZXQpIHsNCj4gCQlyY3VfcmVhZF91bmxv
Y2soKTsNCj4gCQlrZnJlZShjb25uLT5jX3BhdGgpOw0KPiAJCWttZW1fY2FjaGVfZnJlZShyZHNf
Y29ubl9zbGFiLCBjb25uKTsNCj4gCQljb25uID0gRVJSX1BUUihyZXQpOw0KPiAJCWdvdG8gb3V0
Ow0KPiAJfQ0KPiANCj4gVGhlcmUgYXJlIG5vIG1vcmUgZXJyb3IgcGF0aHMgdGhhdCBmcmVlIHJl
c291cmNlcyBpbiB0aGUgcmVtYWluZGVyIG9mDQo+IHRoZSBmdW5jdGlvbi4gQW5kIHRoZSBvdXQg
bGFiZWwgc2ltcGx5IHJldHVybnMgY29ubi4NCj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhlIG9yZGVy
ZWQgd29ya3F1ZXVlIGFsbG9jYXRpb24gYWRkZWQgYnkgdGhpcyBwYXRjaA0KPiB3aWxsIGJlIGxl
YWtlZCBpZiB3ZSByZWFjaCB0aGUgZXJyb3IgY29uZGl0aW9uIGFib3ZlLg0KPiANCj4gRmxhZ2dl
ZCBieSBDb2RlIFNwZWxsIHdpdGggcmV2aWV3IHByb21wdHMuDQo+IA0KPiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9uZXRkZXYtYWkuYm90cy5saW51eC5kZXYvYWktcmV2aWV3
Lmh0bWw/aWQ9ODlhNWQxNWItY2Q4Yy00NDAzLTgxZmYtODU3N2RjMDA2OWE2KnBhdGNoLTFfXztJ
dyEhQUNXVjVOOU0yUlY5OWhRIUtuUHFpc1BQNlhmbVY1RjZMSkpBcmlfZjQta1RDS3FEY0hFNElX
eFp4TmpMdTVoRUNzSG9sbkZrZWxMcnl6bFFMOVdNbDRZWlZ1ZnRIS0UxUmpNJCANCj4gDQpIaSBT
aW1vbiwNCg0KWWVzLCBJIG5vdGljZWQgdGhlIHBhdGNoIHdvcmsgd2FybmluZy4gIEkgd2lsbCBm
aXggdGhlIGVycm9yIHBhdGggYW5kIHJlcG9zdCBpbiBhIGNvdXBsZSB3ZWVrcy4gIFRoYW5rIHlv
dSENCg0KQWxsaXNvbg0KDQo+IC4uLg0KPiANCj4gQWxzbywgcGxlYXNlIG5vdGUgdGhhdCBuZXQt
bmV4dCBpcyBjdXJyZW50bHkgY2xvc2VkIGZvciB0aGUgbWVyZ2Ugd2luZG93Lg0KPiBTbyB0aGUg
dXN1YWwgZ3VpZGFuY2UgYWJvdXQgdGhhdCBhcHBsaWVzOg0KPiANCj4gIyMgRm9ybSBsZXR0ZXIg
LSBuZXQtbmV4dC1jbG9zZWQNCj4gDQo+IFRoZSBtZXJnZSB3aW5kb3cgZm9yIHY2LjE5IGhhcyBi
ZWd1biBhbmQgdGhlcmVmb3JlIG5ldC1uZXh0IGlzIGNsb3NlZA0KPiBmb3IgbmV3IGRyaXZlcnMs
IGZlYXR1cmVzLCBjb2RlIHJlZmFjdG9yaW5nIGFuZCBvcHRpbWl6YXRpb25zLiBXZSBhcmUNCj4g
Y3VycmVudGx5IGFjY2VwdGluZyBidWcgZml4ZXMgb25seS4NCj4gDQo+IFBsZWFzZSByZXBvc3Qg
d2hlbiBuZXQtbmV4dCByZW9wZW5zIGFmdGVyIDE1dGggRGVjZW1iZXIuDQo+IA0KPiBSRkMgcGF0
Y2hlcyBzZW50IGZvciByZXZpZXcgb25seSBhcmUgb2J2aW91c2x5IHdlbGNvbWUgYXQgYW55IHRp
bWUuDQo+IA0KPiBTZWU6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3d3dy5r
ZXJuZWwub3JnL2RvYy9odG1sL25leHQvcHJvY2Vzcy9tYWludGFpbmVyLW5ldGRldi5odG1sKmRl
dmVsb3BtZW50LWN5Y2xlX187SXchIUFDV1Y1TjlNMlJWOTloUSFLblBxaXNQUDZYZm1WNUY2TEpK
QXJpX2Y0LWtUQ0txRGNIRTRJV3haeE5qTHU1aEVDc0hvbG5Ga2VsTHJ5emxRTDlXTWw0WVpWdWZ0
MTFZUlAzQSQgDQo+IA0KDQo=

