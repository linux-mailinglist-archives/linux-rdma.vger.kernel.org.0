Return-Path: <linux-rdma+bounces-15857-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNDQONYZcWmodQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15857-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 19:24:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6835B397
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 19:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46D3280A7FF
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74FB3793A1;
	Wed, 21 Jan 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PMPm28i4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K91KD46c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305238A288;
	Wed, 21 Jan 2026 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017839; cv=fail; b=XTqpmLehFsV2DzwrO5fqr4FL5qptYxQZkpWMUYQMHs6XWkOBckW7oVlSaqi2Hp92PHYoxI1yVMWY3A2p9ruaVc8NH9rL5BKy2hZcU3RRJY+/0an6r/hjKWBR3mXqiRZwA3oU+qJxjsbb1iJJR/50BX9NH0Cipv77CTZmcu0s5Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017839; c=relaxed/simple;
	bh=oZrnuCOv//64/A8DECtGY2qQvLtx0B/LD6jElKmaCBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGRxj+NQcSFWXBrn7mc9wl2trBdQWOCvipkIApkeMj7VvwcMLyRwum0ePh1/+LhTC8YDZj+3JKB1wRkwft8If/XADmHsnvJ/pEf6baOf2+/mYTRiOwCfZ481iphaPbUnKaJm4lodKwSuQPcfDjs92JFjeDpWSISKZOUqbFfm1lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PMPm28i4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K91KD46c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LEvG163028845;
	Wed, 21 Jan 2026 17:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oZrnuCOv//64/A8DECtGY2qQvLtx0B/LD6jElKmaCBw=; b=
	PMPm28i4UBesAdCPZbk+a9QFPnbd22cSXMX+uRpkoLnD7aRo4Tr16KDFRGSUHhbr
	mlxUPI/lTcEmIt755MjkGWNjvPePOzAfEtTT77CALSrt7RcbBVLoRGdrzUddOyoF
	oGqoGNFxLHTN1buNLvacSRRR/cUXaP7NDC4kVuP/qKcRusompAq+sl0M8fJVC5vn
	XHjai3AecJol/zHf2JwM1yW/lSMmGrxE3ZUT0JMIRPbSajKeJSrHTWcdrO0bCpR2
	XLOE9Bc93swg1dko9P5zfCXi3JNUehYsQBcWEmTxvYm21vTOK8JGu5NG+9+SNAkG
	8tBIeGjDdQEaolZCMKHCGg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vxbhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 17:50:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60LGgNLo008362;
	Wed, 21 Jan 2026 17:50:24 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vbm6b8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 17:50:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogJMUgepj+LfELaFR3ZmqfoNG1Rt4tzbRnm4ulWsPYbiomZBmm5eik3hXv32GhnxmmOGZUEB5uVX/l8KSrWB++r93ad/lUZ75s3m/kpgUZiGMCfLRoUNVDKBt7fExXpJ1qitcBySlZFF/qQaBJRE9hznmQXwo2P07TEZesOKJsrLkvwWgtadsWXMJCRYWwpWz7KGVTt20FtWBpH2W9/TJTa74HJh1hqg+yTf/m8ISghQCrJVwnzcK+8kGre2qWH1mdT0PIC6yY+v/um7gyumHU3tK7neBJ9w82Zfknsx3bJzOn8qhVGBjjF9E1LaYIpAZt+cSXgjQIFG2mSHS9z89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZrnuCOv//64/A8DECtGY2qQvLtx0B/LD6jElKmaCBw=;
 b=O87SCQETL0jh+EaX8UvAtH+ChhPr+UJJ5jEfkj+0/DubMm0k5HPSyBKf14Ho4sm/o8wTngDeLox1icB+wYoFElLeGiBCXdelbkeUni9sVZa/As731qxct82HgGL3PnpXtACWJPxPAunjlLjsjllOR+5EH+ujwgUismhBiFcG2GQPzJZbNq/Wb+RlvdVpKQMx52mjUzd5JrXoBEo+i6iLYX47yqmPjonblf9LwNoLxnFLGr9ZzNV2nMg/lBQ08zk+oBtdakTVIXfkJIA+DcbpmbiLZloF4FXCk2cAmwlOxYhvQDCIr3A6iDNgfS2MhPkp118e0612bIGbzZIF2hKYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZrnuCOv//64/A8DECtGY2qQvLtx0B/LD6jElKmaCBw=;
 b=K91KD46cy+ZC/Vj4MHDULSbmn9N8KHm7+dKwZHh9YHih/9L1uPYmcYupsqtDypKsUNhnCmQRBpCq2Q8VJl4mdZnNkChhxyzrxoebRaQw9TRVgcZIrKIdWaHgDX6HBcAV6RbqvvA4r6o1eT7TAbBLghdDWPpcWVl3tJR9YHHYWgc=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 DM4PR10MB5944.namprd10.prod.outlook.com (2603:10b6:8:aa::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Wed, 21 Jan 2026 17:50:20 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 17:50:19 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>,
        "achender@kernel.org"
	<achender@kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 0/3] net/rds: RDS-TCP bug fix collection,
 subset 2: lock contention, state machine bugs, message drops
Thread-Topic: [PATCH net-next v1 0/3] net/rds: RDS-TCP bug fix collection,
 subset 2: lock contention, state machine bugs, message drops
Thread-Index: AQHciCUNKWoUq50qKUWSkuJ8Z8r0W7Vb9lmAgAD2K4A=
Date: Wed, 21 Jan 2026 17:50:19 +0000
Message-ID: <83b05fbb38b2610b77d665850662a6f8c594f8cf.camel@oracle.com>
References: <20260118024911.1203224-1-achender@kernel.org>
	 <20260120190913.20a16e15@kernel.org>
In-Reply-To: <20260120190913.20a16e15@kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|DM4PR10MB5944:EE_
x-ms-office365-filtering-correlation-id: b836a238-6a63-4f8d-2a2c-08de59158b24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NW9HdTJKOGlYdjFXeDkrbzVua1JKMnF6dlZ5aTdkSDJMeFovMG9XZS9ucFZG?=
 =?utf-8?B?SUlmZThuZUkyc3haTWxkYjFvZHR5R2ltM1QwcWg5RmN1bU1LOVBobVFHSUtz?=
 =?utf-8?B?ZThFWWtaR3FRekt3VDN2bTRWVUpzQWx2OTg3TGVGR0lGTStGSzFIcldtYkpW?=
 =?utf-8?B?K2gyc1FXM1lPS1ZPd1E2VkxwWWMvQUpzbmhIOHJ3ak1mUGtJSG9hWmR4VDRQ?=
 =?utf-8?B?R3owNW4xU3B2SVlOMGFla0lBUW1kSXJmQkFKTEtYMHhvRC9mSVduZkhlRy9a?=
 =?utf-8?B?Z2lTbVk2L3ZaSUMvZG9zc2w0T1NUYnNUY2FJamtZRjNCWlpxVElhZTlXa2la?=
 =?utf-8?B?Mm1TOFhLUTFTbmY1dHZmNFdBMmh2T3lva2FnbEcrZlJYaWI1bjhyR0xWd0NE?=
 =?utf-8?B?bHZHNlhHNDY4RzdQYlZnc2hFRmVtcWFxU2NjNmhpN0grQUlBek9aaGp2c0RX?=
 =?utf-8?B?VGxDSUs0NG9KRm9jbHIwUDRxN3lDb05tVUY4TVZkLzB4QllOdWkyM09BcTcw?=
 =?utf-8?B?NUc4R0hMcnBIaFlkaUJnZ1MxRDE1VXR2a3RDSENVc3FUblJ6UHl3ZU5VSW43?=
 =?utf-8?B?N2QxRVRSMzUzTUVVa1FLd3NiTmJYMml6TGFwL2EzdGJISExMdTRCRTM4U3M3?=
 =?utf-8?B?RnY5UDJXRmFQSHNBamlaQUdvNU5jRlczSkRuQW9Ed3Fsb2xSeERBVllCNVRq?=
 =?utf-8?B?MnliOG83a25FSEUzenNMWmxRUU9wWXUrL1BoWlJQTFZvWE1IS1l0bzc5aFBz?=
 =?utf-8?B?OVZ4RUJQRVBsbDFMYjhpaW51QVBZWDRHc1hQTCs1bGNuYTA4cUt6SWZEYWdX?=
 =?utf-8?B?Q3dGdnYvenVWKytrYWladzhzNUJ3dklKMEtmZHdkaEVKSWFWLzY4OE4zV1RM?=
 =?utf-8?B?OHFGZU1tR2cwajltVmwxM0s1TUpqVXEwWTlrT2lvMWFwZW1oSEVtczhsbmdY?=
 =?utf-8?B?bW5KZzM3WTJyNFlTNmVBcnFMenlOL3I4TjJraTF5ZURnMkIrbksxZnNRb3Y0?=
 =?utf-8?B?K04zZzlIOU9vTDBGTFpZaTE3R3A4UGRHcGV1U0F2aVdpUHFXaXhEeUM2cDZ0?=
 =?utf-8?B?RmlQckxTNTdUVkg0S3pYSjQ4Vk1pd3h3Z3RFcFcxUTJUZUo3bnVIQzRwY0tu?=
 =?utf-8?B?ODQ5Y3pXUlUrUGxWVk5DMUdVZmtHcXlyZ25LMm9jZVZNalNRY0U1OTRmV0hn?=
 =?utf-8?B?VXFYNTFES3liSTZ5MkJpWTVoLzI2OGRySk1CaGxJdTRiU0NvWWNlS3ROa2Qx?=
 =?utf-8?B?bHdyTXhqQ2F3aDJ0TVhxcEFGWUlSVEtuekJzMlVOUDlSQTlYVGlOZnNEdE4r?=
 =?utf-8?B?akk5UURicUR5VldYWnliTWM4M0cxNmxuMGJ2YzZDWVVqUTd2Z0dtOXRQSHVY?=
 =?utf-8?B?RDhqNVZuWGI4aDYrOEpmM24yTzcrYlNOTkxEV3NCc2FEU2VUbDcxVm94Tmlt?=
 =?utf-8?B?Z21rc0Ixb2VUZVdaWE9IVkwxTnVnZTlsWSsvbHB2WEozVHBLdlZvZE13b0FI?=
 =?utf-8?B?OVZiTFpEUVN1SDIySk1HL0pZOVlhTmRqNUxZMHlsZW1iaHkvUks5MldmS1li?=
 =?utf-8?B?SW5sY0x4T2RMZTVNMHVOQlc4ODQ3dXdYaGtkdUlxa0dac0lpYzJKdW9HTUpH?=
 =?utf-8?B?YkhsTE9RUmZ5YnVKVVZYRUZ6M2c0bWl2a05qb2EwZW1oYjNPQitVR1N4aFBl?=
 =?utf-8?B?RFY1bnpsdWlNWHA0eWs5QXVoMFk3b3g3THI5SEJSK2Q5dUdFR2lmU1J0N0la?=
 =?utf-8?B?dWRsdXI4Njg3ckZUSGExdkFEem0yWm1wQ2lrdllqc0tqbktRRDBWVnlWbHpJ?=
 =?utf-8?B?djZIY096WFBHZUNjckhIM3hiV2hZQi8xc2xkem03TFZ6QWxGU1cyVy9tUmNY?=
 =?utf-8?B?aW9YWHp6YjhPTVdMcGMrRHR6b0srd01FUlBqVUxEeit3Z1dmbXhYTUwwQmM3?=
 =?utf-8?B?ZG1RR0RNWWl1djF0R3VzcC90b1lMeXAwTjNlVTFZVlF5VXVCM0tlUWpNS0J2?=
 =?utf-8?B?cTA2MFF0SEhFNUtBSjVRSTJaS2JJdEEyYnNtQkE2aDhWWE1XcStJckl0aDR5?=
 =?utf-8?B?a01jMlQ0NzNrY2NFRmw2Y243WHVxcW1QK1NWTWFEWTNjdFNTYi9vS25XajVF?=
 =?utf-8?B?aXVBOGcvZ2NWbmw1RXdDOFgyT2tZajF0ekxjOWh4MElhbDdzanc1N1djN3NY?=
 =?utf-8?Q?z3VxJb2YWj8HyDKB7CItYMo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tm1BTWpYNFYyN1BTWjhPL0R1K25aeXhoMHZueDlzbDdmY0t5VkRjaHFodDNL?=
 =?utf-8?B?akxrRVhhMytkYkczeFZwMTVTMVlnTlpsaEIybG1XMENwVkY2Ni83ZHJZdmlZ?=
 =?utf-8?B?eXZkbm13SXY0Q29Falhhak5MZ3JmcVFDSFB3bGJRM1NoVTBuQ214SGhEaWND?=
 =?utf-8?B?YXJBWGkycVh2YU1EYmtMb2pITFZ6ZUFqNzNLbHFRbjFIOXYzQnNHQ3J3TGFr?=
 =?utf-8?B?dTdKbE5IQW1ja3RFWUJsNXpoQ01yaTdYaytGNW50ck9vQXUvUVFaYnRlVDBm?=
 =?utf-8?B?WE1FVHpzeW8xWDEwYzFJZmZ0S284SXJNek10T3BmdXVNMzJhdVpUVXE2UEIw?=
 =?utf-8?B?d05PQUlJVVF0VmUrdzhESjZQSWNqTUJTbjdrT25GSVFrVENtUFZWRmc2WEQw?=
 =?utf-8?B?MFpHYVdVQ3BHZnB5ZmdHOHVQTXlxcUZMc2NjZlNpaXMzaFliRlFHcmFBYkVl?=
 =?utf-8?B?ellVK0xNTWJ3VkZIcUhLMDkxeStYUnhUQ0tiT0JPbkRva0dsQ1dMTWZFeGgr?=
 =?utf-8?B?aHFUOG9COEdhOXhWbTNyejBnbUFuQjUzalRKV0NZWDl6eGhYc2lvU0VIU29r?=
 =?utf-8?B?aWhLemg2dmtoVzhGRlh6S1pGbEM2UWt5ZFBhMllTR3RnKzhuZXJVUE1BQ2ZH?=
 =?utf-8?B?WE1ZeUJlMTB5Vm44MkJyY2J2S1N5am9ESXl4eTR5MWdIKzJXbUdsaDdMbFNn?=
 =?utf-8?B?Wi9sUC9OL2R3dEh1UXljRDVBTlFuSDJSUUtTZE9WNVRNc0Fmb1lHaE83MVlS?=
 =?utf-8?B?RVJxbGIyYjhqTEY0ejhjZlAya1hyYkZDeWo5eksxNDh1RkprM1dSNlRRcUxG?=
 =?utf-8?B?SVFYdFJhQTlmRjBYbFpsVkgweHpKT2xPV083TmE0U0pzNnY4SUJMNTg1RjVQ?=
 =?utf-8?B?ZTdub1BHdmlpT0pMR2ZyM2tnMU5rN1B2V1JFVjQ2T0g4bzZydk1EYVBOc0Mw?=
 =?utf-8?B?YWFuOXpONDBzemMrTWVMd29RMVF5UWhYYnNsK2ROeDlFcmtnYUl1eW5NWDJq?=
 =?utf-8?B?cGc2WjVqVlVxaytmamw0Ry9YR211OXg4ekhQZHU2cjFOSktPbmVaTE9UaU5H?=
 =?utf-8?B?VHQrY1JJenVETXNZbmZPem5NMzBIVkV2SFRtcFpjN2srRGZQbzNrWlZnWUhB?=
 =?utf-8?B?TWpTbnFTbTJweGFxcmFab2d6aE03VWRSRkF3K1gwMW5Wek9YL2lvSnJMYUVi?=
 =?utf-8?B?S0VVc3Y4cnZKWW9qZzF6TGZSVTdpY3hFdmhzVXp4ZkZ2SzhYZE5Zd0p2VmNn?=
 =?utf-8?B?cmNuRFFhQlZQUjUxSWpyaVAvQ2pjdG9pMWFySWhJdHZ2anlzYUFXM29OYk04?=
 =?utf-8?B?clFaYW84ZVU3Vnp0ODVyTURIQWkzd1FMZWt1TVh5bE5HMFZjdnhBSjFSRXpX?=
 =?utf-8?B?dHFKa2tJMU1pTmZjWW1Sd3IxalZBMEJXOWY0dEF6Ykk3OHdLb2l6KzJvTjAw?=
 =?utf-8?B?dS9NaENyaUpubjJhT0xPb3BTSGRTN3ZQeDBYanpEbTZLRFhBQ296VmkxSG5R?=
 =?utf-8?B?a2EvNjNHQXplRmJWZUFpMFdqekpJcGd2RGJYNnpUNktDSnVESXc0dmtQczhF?=
 =?utf-8?B?QklhejlpRjNMdUtRZjJhUGJnZGZuc3oyNlVZQlR0RzFvOWNXRW9aZU1Jc05S?=
 =?utf-8?B?dzdXd2tYTlhPMnREeHVqOXlzcS8vcllPSXkwbG5raGh0WTZ3S0EvZUpLdVl6?=
 =?utf-8?B?OXdMdVVET2hwbWYzQnNUSitrM2NKQUNCdCs0dy8reWhGQ2JyUzZSbGhOTUEw?=
 =?utf-8?B?VWdnU2tZT3ZBMHdiY0RsODBORHdMclI2VHZYSVRldGI1UHdzSjJxL3lBSHdP?=
 =?utf-8?B?SmpTMTBNMUwvbHBHMUJRL3RESU15UnpGOXdaTXMxR3o0ZlY3dUxMeldrNjdL?=
 =?utf-8?B?M1NBd2VWQ1d1MzRMUFVIY3ZsY1c0a3JvR1NHRk1ldW90UEk5SHRZck9RZWJQ?=
 =?utf-8?B?U0c3RkMzYURJeWFZT2RzTHJxL3pJOUFKV2puaXlkSllxcXl0L3o0MlZnbEI1?=
 =?utf-8?B?QnowWms4dWxabklPbTZsY0orWnZ4VUVUZlR2WWMrL0FQRE5WV2tacDZmTjdy?=
 =?utf-8?B?Uk03TDBIamVoZXFUZzlFblJNdGRveEtTODB3NHoxQWl1eTgrRG92VGtodTlx?=
 =?utf-8?B?Q1E1RTdHajQrNVpRZHdvRXBHaVFrMUFFMVlpNmZ4dnRYZFMrT0NVTzIvVkhP?=
 =?utf-8?B?b2FUV090cjRwOGVPVFEzbXUydWxJSkFBWklzTTlXMWtnZUFqU21YS25mTDlI?=
 =?utf-8?B?L2FVZm92THdwRmhzN3NHVFJiSmw5ZVZVdCtwZ2Q5VTdNem1YUzNnTHZIMXFR?=
 =?utf-8?B?UzNWRkt3a2pMQm5hWVFLVGRhdVdvL0lPQ0Q3SVFhYUN6am9aTGs3Z0RHbDBJ?=
 =?utf-8?Q?+8DuvDBM4c9B2WJ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3CD8F556913CD4988046A3EBC092F73@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	54rBv7bqayZ5AoJSK28ovQARshy33u1yIs2PYI4uJZncIl9+TlrksKtkC+cCIQsme3gNAsRO0FllR6tw60O+9LKfSNbFTdPgevgkTIFqW4oCOsn/73rvEywwe2tSaeb7FUlkSYubuej9+zW6w8VPfL0YP4GTZb2T1B62fYRjay1po2tPWH3pTUo20Xrfins+emUKjz0wHRxFKXuVqUvA1MJcpY1VQJWj8fww1J5qt+EC/jpAGlGlsJr64vMdu8Hn1j7liRT43MMwj42UdRaHPTJpm6smwsvobVPwi+R6qCHKwK9qFp1y7Yf6IWpKrsmVw2re4+AKSVAOPRaNvJwZCUUlQTmE4CHIH+QQSld2DXz2F4SrUvTzhdNHQO7z9arkNtWTGjShjNaIng0uwJmIx0BQeATbqcILS6ZNwq3hL5vc9i14PoWgRiirnySeisn4v9NSOE/XmM2MMCHw/qNjVE9ojm/OxwLO8fWszRDa9Jy5R7dqFCH6CBXzoGyhBbuDvtDlLjhS0z2OKFKDWF7WAH9Pd9pd+amlBRU4jCg9LMfuh6dMJjVgDHZE4zhbeMKNYHkv8hoWRPWbVKkw4wXvnBYRxkaCNHBablY0oQ9uEEE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b836a238-6a63-4f8d-2a2c-08de59158b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 17:50:19.5639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wu0Gjf/YdPGE8yz7twK4TAACwfvSl+T6L/xk7zhT0nEYuaAGerLaQv0gIYts9+c8SkuBYsZEQznYxlemS3SUd4HRm8jeKrldcBXC70KgaBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5944
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601210150
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=697111e0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9H1DK0361B21q2DoH20A:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10
X-Proofpoint-GUID: r1GB36GNHoD6svJhdmbW8BxnY4aouHRr
X-Proofpoint-ORIG-GUID: r1GB36GNHoD6svJhdmbW8BxnY4aouHRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE1MCBTYWx0ZWRfX//5IiZVa6+tC
 O/w2VOtRhe5FKuPs8tdXFvVOoZ6TKUUfhfY2cNok78HBC4wGN/4XTA3nGPSZ4Y75veDwYUETexx
 9S0ap6I7xfMSwnYfD3bswDMQeVRQ/N61FpjgKy0vvxHZAqqpnhgKKGx+40lWjMjdjJgzV49kGHc
 kmyJQ7tNprBdryTLqWJpzFpfrWpv73DPoLh6hxPCFQaE0xCYVESr8jH0684w6THbV/LbW6at7Zz
 djPjjl9VTwpDnqKvVkBtzFykdz2d/d4Q9qdKDpR7zLNC0G3/fNr67EyjMJMvdyN4A680x/scwJK
 wDSI+es3nFA/wMlib2LpnAS9u5xCW7VjIScGvf6orf8WbCVuJGIfSUis2iV3PKmNfJbzzaLx5Mw
 v0UO+ah+Ao1B5T/yjrF4yvHahrfnXxgEqgiZFyfDkTTtXaxqoy9GHxAVvAPcUvga2TkbgDQmM2W
 XltHGtnvHS7AgQHlvIw==
X-Spamd-Result: default: False [1.14 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15857-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oracle.onmicrosoft.com:dkim,oracle.com:mid,oracle.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8C6835B397
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAxLTIwIGF0IDE5OjA5IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gU2F0LCAxNyBKYW4gMjAyNiAxOTo0OTowOCAtMDcwMCBBbGxpc29uIEhlbmRlcnNvbiB3
cm90ZToNCj4gPiBuZXQvcmRzOiBSRFMtVENQIGJ1ZyBmaXggY29sbGVjdGlvbiwgc3Vic2V0IDI6
IGxvY2sgY29udGVudGlvbiwgc3RhdGUgbWFjaGluZSBidWdzLCBtZXNzYWdlIGRyb3BzDQo+IA0K
PiBJZiB0aGVzZSBhcmUgYnVnIGZpeGVzIHRoZXkgbXVzdCBoYXZlIEZpeGVzIHRhZ3MgYW5kIHRh
cmdldCBuZXQuDQo+IElmIHRoZXkgYXJlIHJlc2lsaWVuY3kgaW1wcm92ZW1lbnRzIHBsZWFzZSBk
b24ndCBjYWxsIHRoZW0gYnVnDQo+IGZpeGVzIGFuZCByZW1vdmUgdGhlIEZpeGVzIHRhZyBvbiBw
YXRjaCAyLg0KDQpIaSBKYWt1YiwNCg0KU3VyZSwgSSB3aWxsIGRyb3AgdGhlICJidWcgZml4ZXMi
IGxhbmd1YWdlIGFuZCByZW1vdmUgdGhlIEZpeGVzIHRhZyBmcm9tIHBhdGNoIDIuIEFsc28sIHdl
IG5vdGljZWQgYSBwb3RlbnRpYWwgcmFjZSBpbg0KcGF0Y2ggMSwgc28gSSdtIGdvaW5nIHRvIGhv
bGQgb2ZmIG9uIHRoYXQgcGF0Y2ggZm9yIG5vdy4gSWYgdGhhdCBzb3VuZHMgZ29vZCwgSSdsbCBz
ZW5kIHYyICB3aXRoIHRob3NlIGNoYW5nZXMuDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MhDQpB
bGxpc29uDQo=

