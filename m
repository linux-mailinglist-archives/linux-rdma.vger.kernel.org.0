Return-Path: <linux-rdma+bounces-16046-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GtkJHNYeGkNpgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16046-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 07:17:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBC49054A
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 07:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 268C1300AC96
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 06:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D332A3C9;
	Tue, 27 Jan 2026 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aBgYVemz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t4J4hHMq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FF11FDE01;
	Tue, 27 Jan 2026 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494635; cv=fail; b=XgargOIn8gZIGTUbzqx6Qmxqe42sIYj5uhfAa+PWEI4QTQCNcu3PL1DYyAn+5YICnH1Hwb6X7LCbp7yOSDnOfSo/FQbnMZkuuePy/gcAUkrm+QJcR8H7kBmj7dc8sR4wj5yWYoCtP/1aOaD/02AUiyNYqzBoUg1wwE6DfhHGw4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494635; c=relaxed/simple;
	bh=CxOAwzXzc9ElmHmn0LPRyTLPHJry7g2lA1FxH3JjcQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FiywRM0bGu9U8wZRKEKCSr4fpNIvVQtdqhvQIQAUjMdaCVgLo+RH1gnBMdGf2XyaxhLzXhdKXuRrZUhd6BF1USh69pftbUH0V3AnZ0ySdIRbA0sooVEb49UpOaBX10jdcPMWhAU57ty+TX/ZWvXavH0DkBw/d49Th4rzycl1tIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aBgYVemz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t4J4hHMq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QM9YcN4124073;
	Tue, 27 Jan 2026 06:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CxOAwzXzc9ElmHmn0LPRyTLPHJry7g2lA1FxH3JjcQk=; b=
	aBgYVemzVF55MJdV5oV4n+jMwk5DIq/+zaoGyv3BgPC27fNl9ZgNMfVRvCgoH0Y2
	SRoBk35pU+oHCct7YoaF7sC5t7Va7vO9gCw0znVzkBaIPT2qdfROgLcbfjhXQQd7
	JNpkIEoDinUhqkf7WEyBq9UbCiFw6Du0SQ2ei4+hKJlIE1RRN0qi/GkiqzhdrutB
	oWBtOIkixOCFMoGBP+reG+h/L9OeOQ7TvHiyPnQ0k8+q0ScuB5UItpXAvWRRVHbN
	j1TrdkDewhIw06WHz2qRCAK0rzRnK5BreXcbm0d1uvUCC4XHt4OlMmA4QF6SxaFk
	KUzgc39no0J8r3sQS9sHBA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvpmrbeeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 06:17:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60R4dodM036031;
	Tue, 27 Jan 2026 06:17:02 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhn7phv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 06:17:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNyZDTbwBfQJ4Lm57QzOqiU9vQ4SZkWx0t7PK+qfBZpAR7zScf0LYigH3LU7EwSFzcPzJ/1WeDWtyo28nh1ow6Yu1A+1Vw19sOLs5CKmzOAGlUiN95fo9NNF0oNZhOLGzbg0t1CzjRIySvBHGGx/r7gvWYenPwhkByhRU2Gq+NC8Y0fTgYR4vqzmK7uaZGUxJdyQurLjK6sBrhrYixv6jcioc1AYhJKkUZo84Z4HMNYlMHieJE700D2AjS2Tx8/peRNbxOEXy37Ovu+tUQb5+w8Yqmz9pgX7xgwqiBLlk9MISyzsc//Bol4KSe6Y0HNLkjipMDkpvxrqjAb9L93wvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxOAwzXzc9ElmHmn0LPRyTLPHJry7g2lA1FxH3JjcQk=;
 b=gpE0SMvX67IAcIQr41bnpxA7LoYaTFMXyS7rosEi9T+q44EOBbfoQdWjYWKcBxdfB5W+y/CXntbRew1OVy1dZhxtHWiMA0a5ROCRmBt/zIslAtGOrHgY9UGQHk+4keMyCd252cR/G7o4AoI2xKq17uCNVivjzkmt6t7ZtmjFh5S7fBRrIjMUVPzYlLwSxCvhooXceP1TY55A5wAmP0uKaXQgKe+9kdSrRhddhWd4Kvlfh2KBA/DX0FUgc39aeS4gTQYcdcNiriSRxP+vjxUJ1NiMkjCQnk5WDYlyuxG84rmFGEw0L8MdEs7nhYS/2DsBZ/PlWIx1YU8OKJxyheSuTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxOAwzXzc9ElmHmn0LPRyTLPHJry7g2lA1FxH3JjcQk=;
 b=t4J4hHMq3tsps23DueOPhkZZpgfTxqE6YJ7G7O8fmfWemytKJIPyUhwFnyFubj2R8waP0vCNO11fzKcP1ht04TXF7YAqejlhQSmwF/TM+Btkp5kUGx3o8Go2ivCCEandKHEsx5Ol+PAmvVNy9i2Fw1jI+kUu5usYxirfSYqjzng=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 PH0PR10MB6958.namprd10.prod.outlook.com (2603:10b6:510:28c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Tue, 27 Jan 2026 06:16:58 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 06:16:58 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        "achender@kernel.org"
	<achender@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [net-next,v1,1/7] net/rds: new extension header: rdma bytes
Thread-Topic: [net-next,v1,1/7] net/rds: new extension header: rdma bytes
Thread-Index: AQHcjuuyWVhJKLd6/0KE9eBwgW1t5rVlizqA
Date: Tue, 27 Jan 2026 06:16:57 +0000
Message-ID: <34fa8edd2fffdb76cab7a3c64d9694eaa717a97f.camel@oracle.com>
References: <20260125070651.207042-2-achender@kernel.org>
	 <20260126174620.1393182-1-horms@kernel.org>
In-Reply-To: <20260126174620.1393182-1-horms@kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|PH0PR10MB6958:EE_
x-ms-office365-filtering-correlation-id: e4f974a4-b2d5-494b-71b3-08de5d6bad57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmxpVUVlaTl4UUNFbElUbVVmTGduMEdYbnBRRXBqTU80aEJoR0lVSHFRelNo?=
 =?utf-8?B?Lzg5ZXJVclZGZDNTYUw1NlAwL1ppMkpoUk1NWkkzbVNCZ1MxcDhpOXR6cVlO?=
 =?utf-8?B?U2dYQkpneDdrallMKzFzVTluZDFOeENjZFd1a3NkYlZPUFhYdlNoV09MT1FH?=
 =?utf-8?B?N2t0a3luemVaY20rcHE2NFZmNzlpZHBTUVFrcXV1VlVRSWx6ck5wZCtjRGRi?=
 =?utf-8?B?TnhJeEtkRzdZQzZnNVhRRWdnTHF3QVl6bWNtbExNK1Z0enVkSGRKQlhnU1Rw?=
 =?utf-8?B?dmNURVgwUGJleTlzRklnT0QrSWRNNVM0K2QrN0x5WTFvak1jdlpIQXoxNDBM?=
 =?utf-8?B?cjZvZDVXT0dYRXJYUzdDa0IvRHN0ODlTdmJVY1FnRHFDdWMrMm5XcjBmbDla?=
 =?utf-8?B?Zll3K1lrZjRKcXVnVkNwVHpySFVDSVV2ZmV0c1h4Y2RRb1NRaFcwSUJkWUFk?=
 =?utf-8?B?Qk5ORzJBc0pLaS9HenNwcDVVcXBpeEZQbWUrbmVlbnFWRjFydDArdHpob2tu?=
 =?utf-8?B?OU1kQ1MwUngvS1ZoWml2enc1K2htTWh3OUg1ZUtGVjRsRUhVSFJEc1pmQzBu?=
 =?utf-8?B?ODFmUDBpVktnN08rcFEvR1FXbW1IVE5OTktKb2ZqN0NLbUxoVnRSekh6T2Fm?=
 =?utf-8?B?bys4b2Z1cHNReFJ5L3dsSTFhWGcybXJLL0I0eE52NVNsMVE1WEU4MHJCdjF4?=
 =?utf-8?B?a1FLbnBueVpzMTZqT2NWZnhGdWRHMzhabzJpenA4TDRhMFRjaW8zRnZoTXNQ?=
 =?utf-8?B?QzNMMWJyL2NHVDJwUkJDb2FwYnczWnV5YlpZeXdOK0ZHYVc5ZU1jMDBTdk5T?=
 =?utf-8?B?a2xnUHJ1cENXQkM0KzY4eGN2b3B2YUFGVTFLRmJDOHRkYldySTlGeUgxaHd2?=
 =?utf-8?B?RXBEdzY3NEp4SE1FK0pMbEgrUXhBVnQyVzhpcXpqOFJkcloyeWRXTmQ0em1r?=
 =?utf-8?B?M3orVmFRMW1TaCtSR2pWYStQNGZ6Wkk1czdBY1BVb3lUcmRlWnpYcjM1NSs0?=
 =?utf-8?B?YmNvR08yc2IweXg4dG10d0xwamI1dnVMSzFhR1ZwalFTZ2JWYjl6bGwwdmlk?=
 =?utf-8?B?L3I2MG1qMTdMVVdld1pZWmZaWms4M2hKSXNPcmpaYTcrdVczY2gzYmtEaXVG?=
 =?utf-8?B?a29XQ3VPbTdKR2xMa3BEbnh0YXRGbVFUemhjSWFDUCtEVmVzWDBKR0w2OHVU?=
 =?utf-8?B?eUtXYThySlB1b0tQSW90cHA2WmFzOU1lb3g5czRLS3pEd2poVzNpWUR2UjNt?=
 =?utf-8?B?eWUvUyt2YWlsNFNsYzFuRUs1SHV1Rk94VitLSGd3SlBSWmphdzc5Qy9JZkJU?=
 =?utf-8?B?dWRFZEo0V2xNUHR3ZTNPbDI1NngvTmE1OEpDazNKMEtwcXlTY3NIVHlTU2kr?=
 =?utf-8?B?N1RqQWNGUlA5T3l4b2svRGxXZ0tMajZTRlE1eE9qRGJmejlkbG84Kzhsajkz?=
 =?utf-8?B?YU9Sd09kSDdGMGJ1V1I5ZnU4RmVUOTYxc2REV2VZU0g4Rmh2UlR1UzBQQlBO?=
 =?utf-8?B?L3FYTTV4MlRVcUhndFdpeXE4ZHhxc1pUYkNxRGIzN21HLzBSUlZ1U0hiMitO?=
 =?utf-8?B?STFHZXdNVHJyOUhsSVozcEpxeHVEZWhpcGFza256TjV2UUliY0RnaWJMMk51?=
 =?utf-8?B?d1NIMHNQdDF1MnNlLzZIajZzc2tWdzlRSzEyMFdPajNGci9vcDJkU2xPUjda?=
 =?utf-8?B?T0xZYnlodC9ldm1iMUl4bFZsbTFuekZ0bGxpQXhsK2xRL3dXM09pRGlCeVBZ?=
 =?utf-8?B?TkVkZi9jVEdiU2tTL1ZqRkkzYjZPVDI4cDMvRGxOdTdDb2x1TXplblUzNjhr?=
 =?utf-8?B?UmVGUDk0R2VWZzU4UUxIenh5R2RDOTRUVzY4RXBrQ2xkNUVSQ25iM1FWRFRx?=
 =?utf-8?B?aElWK0JRWjhDWVB5d2ljVnJWWUFZV1p6dTROam5vU3BWLzg0Y3NxNDFET3FJ?=
 =?utf-8?B?WlRmVmNpbDN3anFTZlpvelZ3eFN1WElxMkNDOVczTkFLUEk4S1hjQ0RlbU03?=
 =?utf-8?B?WDlUNGpoTE40ejVseVpCdU9UcmlwcFFzYkdHdG1xQkEwTWoxSmNzTWZuZStY?=
 =?utf-8?B?cmRHOGI4SnpsRGk0dU95cVBHRUxEMEMzZXp6SHVFVGhXUmtqYklMYmdYSUJa?=
 =?utf-8?B?VURuSUdGMXNic3FTTk04SkV3VGZXY29BN3JpZ3lxSUs0MzhaNEQyZVFDQjgw?=
 =?utf-8?Q?CNlYIdHfOuKzYEp8G4OfCa8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGtwKzY5TnQvd1lsZk5namFIeE5mNU1YK3NORE52dkp3L20rZEZsT053Mnpr?=
 =?utf-8?B?cTlML3BUb2kyY2JoU1pndUFlZnpPZzdwc1YvZmtrcTdtemVjVzQ2aXFrZFV6?=
 =?utf-8?B?cURyMi9VMWpXaXBIeTh6Z2xqeitwWHJYbmdvZFlIaXU4eVBGMmpxeXlTODBS?=
 =?utf-8?B?S1VUMHlIdC9sTkU4T1QrM0tVU1lka3dyZEExM3QzdG00QzFCTExNK1pzb1Ra?=
 =?utf-8?B?a3IwajZZV1dZUDBhL3VOa0dJbFpmV2xiZU90bHBsSHZRQUUyb1Zhd1ZBNnlT?=
 =?utf-8?B?dGdDU3puSmZZOG9vaDN1cnR5Ykp6RG44OHZ6WGpyYzVpSmh4amVlN2xxWGNK?=
 =?utf-8?B?dnhqeXBKTWhsWCsvUDJZL2Z3VHJ3cldMYVlQakVGYno3eDNnUjE3Vzc0T05H?=
 =?utf-8?B?SVoya3NFNmJIWUZIQkR3a2lpbVZ6UGtweVUwbVpPK1plZlgxbm9lalFOcm54?=
 =?utf-8?B?VnVhQXRhL25YbldCZnQwSkd3ckd6Y09lVGFYZWxvSUJIbDZKaVFzZ1M5V3Bq?=
 =?utf-8?B?RXNRN2ZCRzJOTkJRZlVtUldqbXVPaGorSEx2Y0ZPSHV2VStLaHNKc2s4T0tX?=
 =?utf-8?B?THVuTmh6MVVrdUw5eFJxM1E0Z2VLSWZuSGNSMDRXVXhQczhIOU1telJuSzlv?=
 =?utf-8?B?dWJtd1g4a01iSGFXNE1MRDhycXhwc0p3TVBJNGxhSytrM1R1MHQyenQxRGxE?=
 =?utf-8?B?Y0RxbFB3akR1VEttck1kekxTTkhLNGlINTJGdytwV2dTQWR6RUJkajdUc1l6?=
 =?utf-8?B?SEc3UHhtVVFZdlovZStFZFlDQm45R0d1RFJRcE9rWm9ibjEwOEJNV2hPbGoz?=
 =?utf-8?B?M2piK3NRNGtqcmx0KzZrMWFZVno3WElQd3Y4Z2RVWWFyTVFuOWRsbEFwUDNo?=
 =?utf-8?B?YVdBMU9pQ2IxZ0hnNXNTY2xSUlZHTVJUZ0x6ZGlucDg1UWdBTWhFM2dlcjFu?=
 =?utf-8?B?MTdWaERET1QyaERCd3VqeUVEdmpSYU5ReW1CM2hxSGExTHZBQXhsVHFpaThZ?=
 =?utf-8?B?TjZiRXRpREdvS1pWbDNaZFVHeGVWcWJIbUxmYmVlVWFFaUNNejR6alRVSjVH?=
 =?utf-8?B?azB3OEM1N3lmaWRtdndQZHA0M2w1VkJtWG1PVk9FSkVQMU16Y3o0UndpcSs1?=
 =?utf-8?B?WjFBNUpkdXVXQU9raDBrejNYayt2b2xES0ZNU1VXREJOcVJYQjluZDRiQmJW?=
 =?utf-8?B?OXhxa2VCU3NsUDlwTUlSMTZqTUhrZDRzL1YvY2hFeGV2V3E1bUR2bUdUTEF4?=
 =?utf-8?B?TVN1ZU1kTkFiZzR4a01hWlhQa0FaaDRLRE9Ga1k1N0ZiWGVmMkpHS0FDcUxh?=
 =?utf-8?B?YURjOExmajZ0aEFNOWZSTWlTQmRzMGxOMEhDd1pLSlRLaXRLRUwyYzB1ZDEz?=
 =?utf-8?B?T0o2WDU0N1JxdXAzQ1RRMEMvOTNhZEZVMUo0TmdMRUFnZi9tZGtnc2tVeGxx?=
 =?utf-8?B?K2Z5ck5oZEk1VUVuMzMxazdCLytsWFhhaHkvU0NOcUNpYS92bElvVjcrbVNl?=
 =?utf-8?B?ZUFOWm1IZk44SDk3cVlTbitkQ3MwQmRSeWZlYTJXRnFxbTlZeVphWFlHY1No?=
 =?utf-8?B?WUhrNktBd3J0dTNoN3hOWHQzVzh6Z3Y0VDVBa1ViZGl2RFJEaXhzZ3NlcUJG?=
 =?utf-8?B?NnlqRTYxa0NlTGdaZUsySlkxMGkzb2dCa1JoMlBpMDNNa0FMK3dnODdkUWxX?=
 =?utf-8?B?Z1J4ZDZpWk0zWFlwWXF5dklCdXpRSDZSbk10SU5od1hBeERzMG9mdnB5dndh?=
 =?utf-8?B?dGJZbkRqTUJ4eTRIVGwzbjV0TnhmZXFWeXZFa0JmQlZ2ampMeERnR2JKNVFs?=
 =?utf-8?B?V2lYMC9qd3VRV1N0Rlk2NmMyZFBhdVFkQU1vQWk0cEtIR2gvc3owUU5UbXZk?=
 =?utf-8?B?V1lkRFZ4VmdHRnpLN2laL0I4OTA2MTZqcHI3Y2JBdUZJdHhBWkttb1paanJ5?=
 =?utf-8?B?alhrT3ZuYWxDdTI3N3E2WkVnaW1KNEhqT0F1RHlCOWJ4WG44UHF4TG9CVHF4?=
 =?utf-8?B?WjNCcWt2TkM0aTRXRHFiZlRUTFNSUG5CazJRM0JoRk41QU54c1hiV2NrUHZy?=
 =?utf-8?B?L05NcUJSTkNtOTI4L3FhcHN5UDdmWWJDblNad1EyRmdsQjIySUx4Y0xqNU9N?=
 =?utf-8?B?b2FoMFJ4NEdsV3Z6MFJkV3pGZnpycHA1czlRL2ZKV0U2aWFSU0ZqYTdRL1VB?=
 =?utf-8?B?N3RIbDh3WURjT25zSE83aWtEaFBCczQ2Q1RzNm5NaCt0cFdwUTRCSEdwNFRz?=
 =?utf-8?B?TFlMUXQ0ZUJRYnpnN25BNThBSStlM0RyejUxU2x5NWJvZ1AvWWlQeW51ZzIw?=
 =?utf-8?B?NEh5WklENHdSNUQ2S2JxbERqand5VlQraGlhamdsT1IyK2NhSzM1a0sxTWpU?=
 =?utf-8?Q?wgEKFxQC3EPg/YRg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAA40D0255A08849A137BB7D152CBA8F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ms8+Wk25ALyQmqqJBsTBNJfpPcw1Tg5twKxIz2WiPPoUiUFi6Mo2UKEEHZbynv9tZUIjiFcI364CQXnb2Bff748m5/r/fmPLWBwqbtzRy6zRcgQYdq9d+OfuIR95v/AhsoGCiYy7uQsxDbV/Vr0vddXPyHCI8VqCr2LMXytE2HLFn9Rmh6vYjt+FLcKnkCuc0Ff1W76I3MZpUqq96pGaB4zt3TIXXEOpojdi8C3bzXKbxN/FQVEF4lwk/AfIkWFiB9o0YbRWKBARy0nx0+nqTFq/aEWP2pZ0Z+7zfKyOmjvN8EOXW/l4EoVHO1yn0p+ktyxim9MQPTsjxZ6ui62RpIpsTT5ipYuVBFkNRNJeOf6ju8II0O+OMmNFqxkNV/ZaUd+pNyDqPc76X9fIGR6WtIJ5vJe+6I6XOmDrPUGnLMBFedkPOaSWUFKOQ/yQh2U0ReuqarbDPoyjpQP1kjfcBRNbO4AmdsAjH6mR98Lu5LH/HEcEZIlnfFpAkz0Bz+uUYtXhXhPKky1MpVcGYrWZoYR6AQhAA1sY6HphoAMFkK55NopYfcOQZu/ZCZm/eYIot5ffCw4FUYWuYIot+j7cQ2OllL/cWZImvVrhg5czVkI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f974a4-b2d5-494b-71b3-08de5d6bad57
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 06:16:58.3983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPTDuIF1xiWQTo8BTdVkwgy3lJU8oke2KB6TPaTNpJGcPUZzP6aNfY1I/XSdsvj6JjdjZzNvqmIKWmkR6zmaW+rgF0XKGyjLLS5PeuUr5EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270049
X-Authority-Analysis: v=2.4 cv=Q//fIo2a c=1 sm=1 tr=0 ts=6978585f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9R54UkLUAAAA:8 a=jj8NaLq3QUrsBYST6nQA:9
 a=QEXdDO2ut3YA:10 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22 cc=ntf
 awl=host:12104
X-Proofpoint-ORIG-GUID: xZ9bKKcoV6u7iyo1VpNkgSfM2kG_xdU4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA1MCBTYWx0ZWRfX8Fj9VN2kk3H3
 JYn3c1TS5RQfG112pTQ3IQRfITZYTp/jlWGIUKgqR0shWhSUJ6dYPBRjPurtaDFVJ6lGJnW6aDt
 QREqhSJVkOMfnzGb3+QlK/O2AvH/UyonJQEepCCTwUBV65Y7hab0SYUfsb/E4BUdv55NC+3+voU
 5m0VCkfaLPMZRpn65P9oYNN3Xv0SNMMiCTeLRETOAZJnQGUV0xiG9ZDK/g2f/LSW5nCnRcssfS0
 FPBRdGPfdZ3C6bavbhcm2s5pTpd0yoMys/nvZYZUV6kAoQetbjQoqvqpHz2CR0wGhvrJZAEcKYB
 4zIhPZ9WdD/RKhkvsXm9zGH46zoDuAQOjMHs7a+z3jNcBKmy337AWbznN1O2EeqUAjoLZcXsAIp
 moahTgnsB2njlXpcZa/r4812MSJy0i/79C+3QWyH0+IitCFxoG2bq4ZezuMsyktlw9DF+DphVJE
 EQd5OwCmV9LwwDuiMhWYpSgKsRpbaYTMgWfClhyM=
X-Proofpoint-GUID: xZ9bKKcoV6u7iyo1VpNkgSfM2kG_xdU4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[urldefense.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16046-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3BBC49054A
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAxLTI2IGF0IDE3OjQ2ICswMDAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IFRoaXMgaXMgYW4gQUktZ2VuZXJhdGVkIHJldmlldyBvZiB5b3VyIHBhdGNoLiBUaGUgaHVtYW4g
c2VuZGluZyB0aGlzDQo+IGVtYWlsIGhhcyBjb25zaWRlcmVkIHRoZSBBSSByZXZpZXcgdmFsaWQs
IG9yIGF0IGxlYXN0IHBsYXVzaWJsZS4NCj4gDQo+IEZvciBsb2NhbCByZXByb2R1Y3Rpb24gc3Rl
cHMgc2VlIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL25ldGRldi1haS5ib3Rz
LmxpbnV4LmRldi9haS1sb2NhbC5odG1sX187ISFBQ1dWNU45TTJSVjk5aFEhTVB1UWQ4VVpPdTdO
ZWMwRm1TSnVPT19UcHRwdG9SX19iSnV3UzgzcTMwUEMzTWV5RjRpVUY0Q0d0NDZidkVmUW9tRXVk
Ti1FOWJWTXRWTzA1dFUkIA0KPiANCj4gDQpPayBJJ3ZlIGdvdCB0aGUgcmVwcm9kdWNlciB3b3Jr
aW5nLCBJJ2xsIHBvc3QgYW4gdXBkYXRlIHdoZW4gSSBnZXQgaXQgcmVzb2x2ZWQuDQoNClRoYW5r
cyBmb3IgdGhlIHJldmlld3MhDQpBbGxpc29uDQoNCj4gLS0tDQo+IG5ldC9yZHM6IG5ldyBleHRl
bnNpb24gaGVhZGVyOiByZG1hIGJ5dGVzDQo+IA0KPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSBu
ZXcgZXh0ZW5zaW9uIGhlYWRlciB0eXBlIFJEU19FWFRIRFJfUkRNQV9CWVRFUw0KPiB0byBhbGxv
dyBSRE1BIGluaXRpYXRvcnMgdG8gZXhjaGFuZ2UgYnl0ZSBjb3VudHMgd2l0aCB0aGVpciB0YXJn
ZXRzIGZvcg0KPiBzdGF0aXN0aWNzIGFuZCBwb2xpY3kgcHVycG9zZXMuIEl0IGFsc28gZXhwYW5k
cyByZHNfbWVzc2FnZV9hZGRfZXh0ZW5zaW9uKCkNCj4gdG8gc3VwcG9ydCBtdWx0aXBsZSBleHRl
bnNpb25zIHBlciBtZXNzYWdlLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy9yZHMuaCBi
L25ldC9yZHMvcmRzLmgNCj4gPiBpbmRleCA4YTU0OWZlNjg3YWMuLmNhZGZkN2VjMGJhOSAxMDA2
NDQNCj4gPiAtLS0gYS9uZXQvcmRzL3Jkcy5oDQo+ID4gKysrIGIvbmV0L3Jkcy9yZHMuaA0KPiAN
Cj4gWyAuLi4gXQ0KPiANCj4gPiBAQCAtMjU4LDYgKzI1OSwxOSBAQCBzdHJ1Y3QgcmRzX2V4dF9o
ZWFkZXJfcmRtYV9kZXN0IHsNCj4gPiAgCV9fYmUzMgkJCWhfcmRtYV9vZmZzZXQ7DQo+ID4gIH07
DQo+ID4gDQo+ID4gKy8qDQo+ID4gKyAqIFRoaXMgZXh0ZW5zaW9uIGhlYWRlciB0ZWxscyB0aGUg
cGVlciBhYm91dCBkZWxpdmVyZWQgUkRNQSBieXRlIGNvdW50Lg0KPiA+ICsgKi8NCj4gPiArI2Rl
ZmluZSBSRFNfRVhUSERSX1JETUFfQllURVMJNA0KPiA+ICsNCj4gPiArc3RydWN0IHJkc19leHRf
aGVhZGVyX3JkbWFfYnl0ZXMgew0KPiA+ICsJX19iZTMyCQloX3JkbWFfYnl0ZXM7CS8qIGJ5dGUg
Y291bnQgKi8NCj4gPiArCXU4CQloX3JmbGFnczsJLyogZGlyZWN0aW9uIG9mIFJETUEsIHdyaXRl
IG9yIHJlYWQgKi8NCj4gPiArfTsNCj4gDQo+IFRoaXMgc3RydWN0IGhhcyA1IGJ5dGVzIG9mIGFj
dHVhbCBkYXRhIGJ1dCBzaXplb2YoKSB3aWxsIHJldHVybiA4IGJ5dGVzDQo+IGR1ZSB0byBhbGln
bm1lbnQgcGFkZGluZy4gVGhlIDMgcGFkZGluZyBieXRlcyBhZnRlciBoX3JmbGFncyBhcmUgbm90
DQo+IGluaXRpYWxpemVkIHdoZW4gdGhpcyBzdHJ1Y3QgaXMgdXNlZCBpbiByZHNfaWJfeG1pdCgp
LiBTaW5jZQ0KPiByZHNfbWVzc2FnZV9hZGRfZXh0ZW5zaW9uKCkgY29waWVzIHNpemVvZihzdHJ1
Y3QpIGJ5dGVzIHZpYSBtZW1jcHkoKSwNCj4gdGhvc2UgdW5pbml0aWFsaXplZCBwYWRkaW5nIGJ5
dGVzIGdldCB0cmFuc21pdHRlZCB0byB0aGUgcGVlci4NCj4gDQo+IFNob3VsZCB0aGlzIHN0cnVj
dCBiZSBtYXJrZWQgX19wYWNrZWQsIG9yIHNob3VsZCB0aGUgZGVjbGFyYXRpb24gaW4NCj4gcmRz
X2liX3htaXQoKSB1c2UgYSB6ZXJvaW5nIGluaXRpYWxpemVyIGxpa2UgPSB7fSB0byBhdm9pZCBs
ZWFraW5nDQo+IGtlcm5lbCBzdGFjayBjb250ZW50cyBvdmVyIHRoZSBuZXR3b3JrPw0KPiANCj4g
PiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy9pYl9zZW5kLmMgYi9uZXQvcmRzL2liX3NlbmQuYw0KPiA+
IGluZGV4IGY5ZDI4ZGRkMTY4ZC4uODI4MmZmNjFiMGIzIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9y
ZHMvaWJfc2VuZC5jDQo+ID4gKysrIGIvbmV0L3Jkcy9pYl9zZW5kLmMNCj4gPiBAQCAtNTc4LDEw
ICs1NzgsMjcgQEAgaW50IHJkc19pYl94bWl0KHN0cnVjdCByZHNfY29ubmVjdGlvbiAqY29ubiwg
c3RydWN0IHJkc19tZXNzYWdlICpybSwNCj4gPiAgCQkgKiB1c2VkIGJ5IHRoZSBwZWVyIHRvIHJl
bGVhc2UgdXNlLW9uY2UgUkRNQSBNUnMuICovDQo+ID4gIAkJaWYgKHJtLT5yZG1hLm9wX2FjdGl2
ZSkgew0KPiA+ICAJCQlzdHJ1Y3QgcmRzX2V4dF9oZWFkZXJfcmRtYSBleHRfaGRyOw0KPiA+ICsJ
CQlzdHJ1Y3QgcmRzX2V4dF9oZWFkZXJfcmRtYV9ieXRlcyByZG1hX2J5dGVzX2V4dF9oZHI7DQo+
ID4gDQo+ID4gIAkJCWV4dF9oZHIuaF9yZG1hX3JrZXkgPSBjcHVfdG9fYmUzMihybS0+cmRtYS5v
cF9ya2V5KTsNCj4gPiAgCQkJcmRzX21lc3NhZ2VfYWRkX2V4dGVuc2lvbigmcm0tPm1faW5jLmlf
aGRyLA0KPiA+IC0JCQkJCVJEU19FWFRIRFJfUkRNQSwgJmV4dF9oZHIsIHNpemVvZihleHRfaGRy
KSk7DQo+ID4gKwkJCQkJCSAgUkRTX0VYVEhEUl9SRE1BLCAmZXh0X2hkcik7DQo+ID4gKw0KPiA+
ICsJCQkvKiBwcmVwYXJlIHRoZSByZG1hIGJ5dGVzIGV4dCBoZWFkZXIgKi8NCj4gPiArCQkJcmRt
YV9ieXRlc19leHRfaGRyLmhfcmZsYWdzID0gcm0tPnJkbWEub3Bfd3JpdGUgPw0KPiA+ICsJCQkJ
UkRTX0ZMQUdfUkRNQV9XUl9CWVRFUyA6IFJEU19GTEFHX1JETUFfUkRfQllURVM7DQo+ID4gKwkJ
CXJkbWFfYnl0ZXNfZXh0X2hkci5oX3JkbWFfYnl0ZXMgPQ0KPiA+ICsJCQkJY3B1X3RvX2JlMzIo
cm0tPnJkbWEub3BfYnl0ZXMpOw0KPiANCj4gSGVyZSByZG1hX2J5dGVzX2V4dF9oZHIgaXMgZGVj
bGFyZWQgb24gdGhlIHN0YWNrIHdpdGhvdXQgaW5pdGlhbGl6YXRpb24uDQo+IE9ubHkgaF9yZmxh
Z3MgYW5kIGhfcmRtYV9ieXRlcyBhcmUgYXNzaWduZWQsIGxlYXZpbmcgdGhlIDMgcGFkZGluZyBi
eXRlcw0KPiB1bmluaXRpYWxpemVkLiBXaGVuIHJkc19tZXNzYWdlX2FkZF9leHRlbnNpb24oKSBj
YWxscyBtZW1jcHkoKSB3aXRoDQo+IGxlbiA9IHNpemVvZihzdHJ1Y3QgcmRzX2V4dF9oZWFkZXJf
cmRtYV9ieXRlcykgPSA4LCB0aG9zZSB1bmluaXRpYWxpemVkDQo+IGJ5dGVzIGFyZSBjb3BpZWQg
aW50byB0aGUgaGVhZGVyIGFuZCBzZW50IHRvIHRoZSBwZWVyLg0KPiANCj4gWyAuLi4gXQ0KDQo=

