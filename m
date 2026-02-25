Return-Path: <linux-rdma+bounces-17138-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMGiDI9mnmmLVAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17138-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 04:03:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B551F19117D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 04:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF5B63071BD5
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 03:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CA0265298;
	Wed, 25 Feb 2026 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HTE7ePHY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CtXQgtix"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4D199FD3;
	Wed, 25 Feb 2026 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988616; cv=fail; b=tSaSagCsSgznZN2WyhP5ENLtFGuOOHYDmA0vBzeP+TIGlF7UNKLVmFu2/Yc4pe9Fet7gpzOMz9f83knlkfCgNp6kgm8JgX2Ibe07M8TqP85EGmFKIe8oYg6pBPFACUp9dz43mEekylYnga/QqLg1Ky2/LDz7DmHNCxo86n0KciU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988616; c=relaxed/simple;
	bh=QIr5pq7smm/2F+z71VAisc2EefDIO5FPj8JGmCgA57M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bstVt12CaEjduSVCqG3KaANee89rwK7LdC7pAvbVWIiOBTFKBFDh/VV9GmrjeqVzjTPusmNQJMcIJd67PE7ijOzRTKldoxeymhha83NZlfHSgapYSFK/u9MyrU+qPYc1f6Bg8N6AM5b3xilHQWBYNn/52AYhom+cGVqiVgDsoVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HTE7ePHY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CtXQgtix; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OIvdQM372361;
	Wed, 25 Feb 2026 03:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QIr5pq7smm/2F+z71VAisc2EefDIO5FPj8JGmCgA57M=; b=
	HTE7ePHY0/Idcv9azQLyqvnkG5HGoFYIEzUXWRaNLyCBbHDNowxme+Ad+UfqXmWS
	eTwqDXMcDJ6lK3uxbOYhxEeT+VrzJrcEboWAA1tWWV/VQxcVT6syAUMis7GHxOU2
	BcoSS7p7x//wG+hHKDGkYsVahy4Y0B1HOsfoSPr3iAaETogPRHvDtmsREsW3YODK
	pNBOmBq6qE3mjacGtV9aDXRMQ30W4b7MDLiugucIr+PAIn39+VS1Cjy1WeAoIdNW
	3xq5/wtv1bx0Sf14aUIzfplkBgV50+VS0XDBrVUOUCqjlrNhg7lFfn+9IUfHJ3DU
	mxIN0zLTcAjf8N2Gn0aV/Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5wbxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 03:03:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61P2q57R038495;
	Wed, 25 Feb 2026 03:03:16 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35ms80q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 03:03:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjRDdEQ6n/tlEoSn564caoTL+8UuYamYsEmSQTtJ5c4v3P36sT7llCJzbesbRIj9n5et2WaDZearrGV6DVKY6mzfbJ6np5QOGDSn4bMrqQmdPW4DAL4ocREyPFJJa7G5Pyyjo4t0WQlVJnssRZVrOkAwAo9c3QS58tgSyTDHR+e8TsuM1i/oiaxZIjMzpKetwiaMQfLz5crDXAjQIGOl4aKHJdjP0LctDgCloLoVM1z+8aJ2koHLkuxDV/HVQA9M72uJk81lEeehID9DRkUQYalqjKIPSiKGDXjZdtrcBde4gNhJthbhuXlftnDAFHRHJuqLBIW7rpxvUtqugVmWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIr5pq7smm/2F+z71VAisc2EefDIO5FPj8JGmCgA57M=;
 b=MiQRHq0oBTTIufWmUueGvV/zEOW4n3uOrklvKk107iMG+0pacULWSIJ/q6K9I9mjkBC6scCgYmAkHqyVrV5a7fS/Va4fk0ZLD+alPPZIWDEZvZAlK/7chcSdxcgyBabVQVY7+7o9ekG3SqFPeQgmWuUSwiLn9uMQAkxhw5vjW/ArVHlhgeYGaJa5C/2fFHIqUHYMO3MSNxx2/wyZX0LyoD1F7N7Qxy7FxVT9hkyERFTSrg6KPd2c/En+BWYCAavVSPzzumLgUJeKHTi0+85m2wik8o9bqBj+TlUvbw8Dq70ZO5tEdc3f33IllSEQ7TLByifb+ZI3SMKKNlytY+ivJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIr5pq7smm/2F+z71VAisc2EefDIO5FPj8JGmCgA57M=;
 b=CtXQgtixJ2cdp+rCDMp5Nq6hFcI+Qm+NH8uTLW/CV09lZIO+jcd/Fw5QqH2lRQUY8rwvwOUTkRXfCdGxTg5JibaRhnPEVlbiTY842PFsm/EdBBubYkcXb+KLml4R9lB8JPtNnhDN72ATHsmnffCvQ+zRK0g7t9FoWordHCgfLOs=
Received: from IA1PR10MB7417.namprd10.prod.outlook.com (2603:10b6:208:448::15)
 by CH3PR10MB7188.namprd10.prod.outlook.com (2603:10b6:610:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 03:03:10 +0000
Received: from IA1PR10MB7417.namprd10.prod.outlook.com
 ([fe80::bd36:8593:7913:ee59]) by IA1PR10MB7417.namprd10.prod.outlook.com
 ([fe80::bd36:8593:7913:ee59%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 03:03:10 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kexinsun@smail.nju.edu.cn" <kexinsun@smail.nju.edu.cn>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yunbolyu@smu.edu.sg" <yunbolyu@smu.edu.sg>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "ratnadiraw@smu.edu.sg" <ratnadiraw@smu.edu.sg>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "julia.lawall@inria.fr" <julia.lawall@inria.fr>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "xutong.ma@inria.fr" <xutong.ma@inria.fr>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] rds: update outdated comment
Thread-Topic: [PATCH] rds: update outdated comment
Thread-Index: AQHcpTJ9hyX4t2f7JUm4TPWvzrgo/7WSvCWA
Date: Wed, 25 Feb 2026 03:03:10 +0000
Message-ID: <2e555525ab0bcec255c9c73a8457ba4a9466ee6e.camel@oracle.com>
References: <20260224020720.1174-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260224020720.1174-1-kexinsun@smail.nju.edu.cn>
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
x-ms-traffictypediagnostic: IA1PR10MB7417:EE_|CH3PR10MB7188:EE_
x-ms-office365-filtering-correlation-id: a90776f5-cbb2-4bc7-2f71-08de741a687e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlUyZm9tVUFSdFM4SlI0eW1Vdlk0bVZCREVYOElLbFdxWWk1dlozSUxzTEhN?=
 =?utf-8?B?VVg5STkxWS9jL0hJT2VwRVBPeEJrcTQ2Y0RKS3lMREJSWkVtQkhHTGh6bVJZ?=
 =?utf-8?B?eWcwUW1QeUUwTXFYZ2pLU1I3M2kxcGxxZkxmUHhvZktaczVmZWRwYlN6cHFN?=
 =?utf-8?B?RWxCdk5BQzZkS0FpTlFsSjdmb2ZraVVlVHZpNEtWbVZoaFNlWHNoYk9IRGxn?=
 =?utf-8?B?RFBQNkp1WTBlTFRlUXRKTllxZ0x4aE9xL1NhOEF2TWkvQ09PcFlZOThnN1Q1?=
 =?utf-8?B?OXh5R1lPcGZud2xsbDBtajlSbGZhYWRJR1ZNejNQY3hUdzhKUHlVZU9LNk5u?=
 =?utf-8?B?L1dXTDgrRVhLNTZxNUw0ZVljMFZBNEt5NGhSWUU5SFYyMUl3aElBeWdobk04?=
 =?utf-8?B?ZEVxQVdXVTNTS0tOMWNIOFgwekhvWFZNSDZCODlFT3htVWs2TXV2dko5anQy?=
 =?utf-8?B?WUNwQlIxNFJENDVQdTdVaExCNlZiWGNUem1nazhqT1ZHNExwUkVSWS8vVWNC?=
 =?utf-8?B?RU1uaXRiRkFBR2Zwdkx0aVprdzlQZXpyelNYZkhzYnlxY3lmZUVYN2hEWXd3?=
 =?utf-8?B?TXlCVmwrbXdrWTVDNmlxVk5IUyttOStYM1RoZDNUcU9RVWdvNG9ETnh1L1RB?=
 =?utf-8?B?QStmNVhsb3d6ZllKWjBRNEx1Lzh2ZE16bjhCWXFxYi9qMm1oQWlhL3ltTDVT?=
 =?utf-8?B?YU96VjV6dUt5WHM4Zjh2OEZ4OFhUclFqdnpnUE5ic1p4TG9pQUhzYzl0dDZ4?=
 =?utf-8?B?UmlKWmRYVnRCSE1NZXdOazNuOXZaZVBRUXNUUnJtbDJoOEhzdlZjMUhPeFF0?=
 =?utf-8?B?Q2NCcUhiZ1ZQOE5PaTB6RzJYR3EyNDBucnlZVjhoWDRDdXNpM2lvOGd0NEJ3?=
 =?utf-8?B?aW0wYzhvaGNTZndCS0ZSUG9GZXVtVXJxMHB4SlhaTm14VUR1dUZ2WE5XMnFT?=
 =?utf-8?B?NU5naDV0WTRZQWVJdWdGTlBYZndzTGhxRk5vRDBoTTM2TmRldU1GMWJvL0Jw?=
 =?utf-8?B?bE5aTDZBbTJZVXNzaXlMQk5JS2g2aHVLTStlQUdCbk5ERDJXSUtRd2s1WGlo?=
 =?utf-8?B?Qnh3Z2NUcWd5TVJxcHV2Y1pTRCtldWNNQktiRjdmajVSL01nalZFNGU0V3Jz?=
 =?utf-8?B?VVp6RkgyMUZ5c0JhRXo2aFBvM3RqUFhrd1pEZGJ3cjVDcGc0MGNCcmFaWUFm?=
 =?utf-8?B?dWtUeDJqNGNRUTFFWDhFdHhkeEtCVll5by9yL2srQ0ZvbElkaUNKc0FrMlFN?=
 =?utf-8?B?bENFQUFPU1ZOWDZSdmdKMndpOGxjVUNBUHNyWUhBOXBEU0ljc2ZzbTJvalU3?=
 =?utf-8?B?UUJxc3ArV05RT0FnZHUxRmJZVW9xTEhQc1hiRFFUZ1RnWUlMcHNlSkx4VXV6?=
 =?utf-8?B?cWl0RDEwM0NTdWFQSTZIV1liWUpUdG5xdDM5VXdCZ2lJTytkdjVYWC9pTnRn?=
 =?utf-8?B?R25odTBXRzMzK1RHWExadjVyVTNlRW5DSXJSRGpRY05ZNGdYZlBmTElOUU1U?=
 =?utf-8?B?UkdVdVkrUW9zWGJLcWV0UStxL3h4YTZkOUlaMFV2bXBkVkJiZ3czNG5wNC9L?=
 =?utf-8?B?eVJoVnUxZUcyZ0FWWWg0eUZLNHVNOWNoenR6MlUyTjZlL3p5dFhvY1pkQ21j?=
 =?utf-8?B?c1JrTmFtekd3TmdLWjUwZEFhZ2dpaU1hNmhhRmhVSGt0NE9zRmx1MW8yeDJj?=
 =?utf-8?B?Vy9MZFltU0N5YTQ0MUxBYmNjR3NqSkQyQUg4dUtraGxRWFRmQWlmZHBvbDZF?=
 =?utf-8?B?ZzhjaWRaTEg2ZldFd2ZaVnYwUmZxbmE3M1lQcFBjMWd3eVhza3hzeEhTU1ky?=
 =?utf-8?B?UDF6ZHVBNkcxTDNBcU94WEp0TjdBSXU4QUhqb1JMQkY3dSt2VTI4NFZaemxn?=
 =?utf-8?B?ejc0cmYyK2N3MzBrbTd1VmU0dUN2ZjRWT0VkN2VmOGsvdW8yL003bEFMZHhS?=
 =?utf-8?B?N25qTExUdG5NMWpjU0sweWYycUEwdFRGUGNFZGhqVndqQzg0ek5BNUxhS2ZX?=
 =?utf-8?B?UVRIcFZpTUtUekZCdThVNXJ0QXM1WVRDRnRmNUw2MVBIQnM2OHVhSUd5L1VO?=
 =?utf-8?B?N2psVHFPV3ZjZWQ3enRNeUFYM2wxcTlFeDdKdWFhYjh1OXlrcVBVSnE4UGl3?=
 =?utf-8?B?RGgvR0RoRVFFNnl3bk9zSlo1RDN6VTdKOCtzUExTSjR6T3JFb3BnSldLTkFj?=
 =?utf-8?Q?FmAC6n9avNYFQFo7KL5dhPE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7417.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGpjSm1Odmp2OGdraWZBL2QycVpnQlJzMUt5ZjJoNDZKZ0QrdFpVL3FZRHJ5?=
 =?utf-8?B?YS9aVWhJczhNeXNvcFZZVVp0SmNVT2k5bGs1ZFU2VXNXa0hmVExyYVJEMVUx?=
 =?utf-8?B?V1I2ZGl1cCtDdUx4c1d6THh5eGFYV29nK3hFU3paaDNKZEg3WVpvOGJvMm1V?=
 =?utf-8?B?WG8xLzczeHBORUdTbzhXUGFvZStQSm9rNk94blNLTk9Id252WTNvYlloaUlk?=
 =?utf-8?B?eWFnZEVWSzBrUWNUOHgraUJlaktJQUJNRHlRc3lXdzAxbkZWVWlEU05uVVcw?=
 =?utf-8?B?VkhXNFcxQUhCTkxwcmJjUW1ObVJsNW1xZFE3R2tSa013Um9QT2tGbU42ODNn?=
 =?utf-8?B?SXozTmlLVHBHN3YzUVJJZXpjWUFGb2J2NlNLU0dhWWIyUENzb29WRFBQZVZs?=
 =?utf-8?B?U0h5eHFQVVBDL3VhcEF5eThacS9jRGltUEo4ang4MzFkT0dmdDEwRnQ0Nkty?=
 =?utf-8?B?cGo0dGNmaEtMUnRDRTVQTSt6L1hZeEQ3WDdOYTVVM0g5ZHYyd0ZBL1ZZQ1cw?=
 =?utf-8?B?Qk1FS2xCTDlDWllSTWluVkJLdnkxeUpDS1ZQZ2ZxbEhFRC95L05XVThNU3ls?=
 =?utf-8?B?Um9wVitmZWt5ckJNUE1iYXgzK0F4bTV4Y25vcEpobUNpSUN2Zk4xWE9IMkNO?=
 =?utf-8?B?SGkwbGlKdi9XcEZhN2xGdDRud01YcFdWajhJbTYwUXNBKzhRaDlJY2ZwREJX?=
 =?utf-8?B?YW05czFRMXF3QWFHclNwMVpzMHcrZ0JQb3dETEZqcHhxQ3NqcE52Y1JleDV3?=
 =?utf-8?B?S1Izd1g3VGY4WUxVWlZLU1gzM1MwT1hZYzR4Y2ZFN0FrbUJTQkt5d2ZrUERZ?=
 =?utf-8?B?eit5T1o5V3VFZmVJaWRNRnVwQjJFdXNDdk1neEtmcjdIQzJ0RE9qZzlTQ2F5?=
 =?utf-8?B?aFo5WlpPc0ZtY3R6TllRcVZ2eFV0Q2twTGovODgyQjFKbGNJTW0rOGpXTW1w?=
 =?utf-8?B?bno4WUhtN1l6aExHc294WE1sTnNZN3ZEbUVBQVZYSEpROWtrOGJxdmJldWZ3?=
 =?utf-8?B?SVEyR1hsTnl5RVV1QnR4aFFLbm1DUmR1Z05rd1RKMWlORlNGQ2hMaWliYWxU?=
 =?utf-8?B?RjM5N1IzS0pXTjcrVXVMWlVmZXB5UHNlbEZYSlArejhGelJRNXlLYVUxTUlX?=
 =?utf-8?B?UkhKYlpNdnMrK285amVSVktFVVVNalcxNi9GMjVpZUh3S0xFandqUWVsZFVU?=
 =?utf-8?B?SkpsaTcyRnR6Zi84WWNRQXNxTjJEWEFYWUlsZFBXU0k0TW5Kb0FMcTRXeXB0?=
 =?utf-8?B?cW82emZLWFdUdng3VnU1VzRSeS9ZVWpzNXVFYXk3OFoya3RZL0k0bEttMkFF?=
 =?utf-8?B?bXp3alJXUUdVUWp0WWYvS1JNRExwRllPMDJqbnBLeUFDa1J5SG5TZ3F6NWlQ?=
 =?utf-8?B?dERGZUQvYXYzbXdpem42RXZJTlpiblkrcit2QktpdE1DNHBVSDJQRVcxTmhH?=
 =?utf-8?B?WXE1NjdUZkdjeWNyY245QWVJcldtR2dseGdjdkJJTnJ5Z0FrVHp3K282YkYy?=
 =?utf-8?B?dEJ1akxuVDVzMk1OSUhUZjZhQktiS0gzajJYL2pNcHBBbytDellrZXNBRTRo?=
 =?utf-8?B?Q2pwMFZJYTVTMkV4UGxOTCtPenp6ckFiRUNyb3pOMlYvM0w0Wm1rMEl1YlZl?=
 =?utf-8?B?K3IyRXdYbnArRDQ5WlhVRnVUR1ZpVnlvUUNuVkh5MllOckJabkUxa3M3L0tj?=
 =?utf-8?B?RnIvZyt5K05oV1NwOXdjR2xKKzFhVDFKMXBVckpKdTl0MVh3dE5yVXB1eHJ3?=
 =?utf-8?B?aHZNWTNaMnpWWnhpcC9CaFFOQ1laeXNUbmNpSStraWwvaVlIZzZqUzVoTDYw?=
 =?utf-8?B?SGZyQ0MvRWtjanJrUlhrT1B5VUtSd3lBRFRLd0k2K2tRcFUwTjR5Zk1JZTQ0?=
 =?utf-8?B?d1ZBUndzK29NR0FmTGZlQ0JwZk5jak9KakNVRk14a0R2cExvZ3NkeTlydzYv?=
 =?utf-8?B?Z2cwV2wraUZOckplZ2xrQWV0TktDSU1yWElJWlhwNmFQcXJ2OEYxWTBITjZm?=
 =?utf-8?B?NEJRMXRFS1JCUkFPalpBV0NrdHV2R0lqenB6STEzY3gra2hNSkFNdHhzRHNT?=
 =?utf-8?B?SStBODEvNDBFV0FTYjNSaE1HNTVycUZ1aVorMUloUWtnSWhnN3NFYXl5czdu?=
 =?utf-8?B?WG5LZnc4NG95U3MvVEpqMTZkcXJlTFUxSkZvYjMzSG1OODNWYm1ZWld4dkw0?=
 =?utf-8?B?WTFhSGtFL3RoVEFRdFJVYkNCdG5MTUE0anR0b1hrMktxZnRPT1ppV2V0bW9M?=
 =?utf-8?B?UFNLZGhvQzJBN1BnOUYyRWdka01WdktWSVRUaUwyU2wvcklUYzVIYnpVYWpO?=
 =?utf-8?B?aW13aTJaV1Z1djdZZmhwZDAvRE5DdmozZjFkVlhSM0d3ZmJVbHZYN21oMjhP?=
 =?utf-8?Q?ly/virCHd6zcs8Vc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEA762ED8E6C5642A91F95FD7EB2FF39@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YswRez8qhC3d5QNqNabL07PTTDF7kf9yKLxBs+502hREvEduvGohnmtI+u4GolphfiAlqeDd5/5SL/ow/CH84LeDB64qxPrVxnp6ZQX5OaDUqtHckXVA8yp/B0P1czizBQBsSJwR1rogPd7nJE67Y2gB3mL7p9AKc14TZLPdhkX8Khmhu6ZMlUy8uJAlIGnsqnyIBb1jEXUQmQXWM/RNflh0k7BcuVAGqVsYR6urBonIEDb+ujmw47q9gB3S+qyRsngXpA0GUVoTTY3p8/lVlBzaCUI/RT67zCCzXtzsTXdo41MnvbAZJ6DncuJjUW33XZT7Zo6w+QuAovE+oLXOYPrX4Wx57M1jU1vR9gK5Ql7HaPekdDoeEJHt6QVIQOpbr4+kl8P2s6efHThBor5/bdKcdI+D1pXTq89ywm9VdsgtKQe8O2yPLlTyrnTe4Ui4mqRNxVYVaN7wwFtLA/g4FZmvrh+hNBUjuj8/7C2ido4g1n+41mZy7+jZQNoHyESzESxnw6BIYaXbb7/jzwVglROAYG0Mao2Udz7l8I3VClhb/Y18UacBMrWcM9SdKMRu5r+7ODUMHn4DRx4BWLUpShpTHvIN16zr25BOzgFhW+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7417.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90776f5-cbb2-4bc7-2f71-08de741a687e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 03:03:10.3548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4Odnw4WIqM2AHpTIF3VI+OrqsiXBlnI8TgUA79NrMNp4LZFTbgsl2o0PUdnWYoEq2MM4hngzdc094grVTIt3i6YvGyXZwb7EafQe9dNkTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250025
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDAyNSBTYWx0ZWRfXxvIDpEFxh4SA
 xbtdDyhDiE+6i1mYdsCPV/JCnC9ls19cUAA0wA09qBcbdwbhJH6pKpCHP8gCYa5ERi9oj3v763K
 XQtO23x4Uey6RXr1NMwGDaEOG0/4BAfeOqj5Io9HOCwpm46ZkjorfNAsmOYLG+CZGFKW4xUBIAw
 4iqOW19OOa+rXtn6tNklXICzsfH+1i3619S7Q1pc6jTkkDIKjCl3G/+Uc/BkBqLJYuoZXhuqiIh
 jQYN1+mI60v3g7/RMce97ihyHU+Xa0rMqcceoAKi/iTPUCgqWEDkfbwqu9VO0Iri5yzBKhqzkPs
 FaNZCbiuLdAYBSZQktWYehg7SgtkzFh3byjAqBCRJVHfeinpypOycR2tsV5bBzvT7FIhJ8D8xF2
 HyVYUeiPi4+DOX8r6VKD4PMQC9zRJeikhtc8YI6675mYp5QCv7htI983Q/oSWFni50iacL95Kqe
 PZAhM8P71ly7B66FXBfAKydUN7hJhyZs31ykyOFU=
X-Proofpoint-GUID: 4KIjoNB3CsuA5rA5I7pYuewLKmL3T7MO
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=699e6675 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=gRKHd0CzUnqA5vk5bOYA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12261
X-Proofpoint-ORIG-GUID: 4KIjoNB3CsuA5rA5I7pYuewLKmL3T7MO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17138-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B551F19117D
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTI0IGF0IDEwOjA3ICswODAwLCBrZXhpbnN1biB3cm90ZToNCj4gVGhl
IGZ1bmN0aW9uIHJkc19zZW5kX3Jlc2V0KCkgd2FzIHN1YnN1bWVkIGJ5IHJkc19zZW5kX3BhdGhf
cmVzZXQoKQ0KPiBieSBjb21taXQgZDc2OWVmODFkNWI1ICgiUkRTOiBVcGRhdGUgcmRzX2Nvbm5f
c2h1dGRvd24gdG8gd29yayB3aXRoDQo+IHJkc19jb25uX3BhdGgiKS4gIFVwZGF0ZSB0aGUgY29t
bWVudCBhY2NvcmRpbmdseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGtleGluc3VuIDxrZXhpbnN1
bkBzbWFpbC5uanUuZWR1LmNuPg0KPiAtLS0NCj4gIG5ldC9yZHMvc2VuZC5jIHwgMiArLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvbmV0L3Jkcy9zZW5kLmMgYi9uZXQvcmRzL3NlbmQuYw0KPiBpbmRleCBhMTAzOWU0
MjJhMzguLmQ4YjE0ZmY5ZDM2NiAxMDA2NDQNCj4gLS0tIGEvbmV0L3Jkcy9zZW5kLmMNCj4gKysr
IGIvbmV0L3Jkcy9zZW5kLmMNCj4gQEAgLTI4NCw3ICsyODQsNyBAQCBpbnQgcmRzX3NlbmRfeG1p
dChzdHJ1Y3QgcmRzX2Nvbm5fcGF0aCAqY3ApDQo+ICAJCSAqDQo+ICAJCSAqIGNwX3htaXRfcm0g
aG9sZHMgYSByZWYgd2hpbGUgd2UncmUgc2VuZGluZyB0aGlzIG1lc3NhZ2UgZG93bg0KPiAgCQkg
KiB0aGUgY29ubmVjdGlvbi4gIFdlIGNhbiB1c2UgdGhpcyByZWYgd2hpbGUgaG9sZGluZyB0aGUN
Cj4gLQkJICogc2VuZF9zZW0uLiByZHNfc2VuZF9yZXNldCgpIGlzIHNlcmlhbGl6ZWQgd2l0aCBp
dC4NCj4gKwkJICogc2VuZF9zZW0uLiByZHNfc2VuZF9wYXRoX3Jlc2V0KCkgaXMgc2VyaWFsaXpl
ZCB3aXRoIGl0Lg0KPiAgCQkgKi8NCj4gIAkJaWYgKCFybSkgew0KPiAgCQkJdW5zaWduZWQgaW50
IGxlbjsNCg0KSGkga2V4aW5zdW4sDQoNClRoYW5rcyBmb3IgdGhlIGNhdGNoLiAgSnVzdCBvbmUg
c21hbGwgbml0OiAgWW91ciBwYXRjaCBzaG91bGQgc3BlY2lmeSB0aGXCoHRhcmdldA0KYnJhbmNo
LCB2ZXJzaW9uIGFuZCBjb21wb25lbnQgbGlrZSB0aGlzOg0KDQpbUEFUQ0ggbmV0LW5leHQgdjJd
IG5ldC9yZHM6IHVwZGF0ZSBvdXRkYXRlZCBjb21tZW50IGluIHJkc19zZW5kX3htaXQNCg0KT3Ro
ZXIgdGhhbiB0aGF0LCB0aGlzIHBhdGNoIGxvb2tzIHByZXR0eSBzdHJhaWdodCBmb3J3YXJkLiAg
VGhhbmsgeW91IQ0KDQpBbGxpc29uDQo=

