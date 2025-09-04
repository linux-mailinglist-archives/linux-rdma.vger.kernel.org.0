Return-Path: <linux-rdma+bounces-13102-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBA2B449E2
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 00:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 027537B7ED1
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 22:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46912F069B;
	Thu,  4 Sep 2025 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rk3r6zWQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pto+aaMK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF132EFD88;
	Thu,  4 Sep 2025 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025834; cv=fail; b=skP3rzzQd1uxVUiWkEkIQFX2ea6BnhOW8voYI9BwYdB88T2SjMI08s418KygF1leIF3gQYvS6c6AVykt3E2h/wlOJO7ZEOSLE6KCWU3kL3DsT+7yv1iIcozyofoOQEjz9+jFCKoWK+Hu1umv3GN678CAeq68+bz/crYt86TKCeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025834; c=relaxed/simple;
	bh=0D/9VXahAUkAPYoSqXF4/Lz13Fv1nmWRn28/gdGOFFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OmNR5VyDA6W1xlw8V+9X5XuUDwWapPgwrsSvjMVGTHg0iDn05oxUN8PZTqdsacIpXEK0yNtIQonDmp9CiMch4kwNX1RqkCcw3/1Z4tS0za+NvdUv1rGl/BArp7Jcs0Q7dhiP5/m4GE5yZX1yDuG1C+NmSpFAd0gqXeWDqBvqY0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rk3r6zWQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pto+aaMK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584LBlS1022977;
	Thu, 4 Sep 2025 22:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0D/9VXahAUkAPYoSqXF4/Lz13Fv1nmWRn28/gdGOFFg=; b=
	Rk3r6zWQVaz8uPkEQwPHQ5bdfW2yz+x5LD8HRaNvC0df6qaj9z7bsMB/EQJP29Zw
	BMInpbzaoYW8CBRl/2MUysxdFBUfb7BuUrNMEoTg08OV0JUlFbLX51Vy2Pmy11KS
	EmD3A9o9DHrd+u6dS4UBsCIlfKT/GJvc9DaWYUC/1l00QAhB9A1lC0Z5P2zoyxSW
	KpHHzwZ3WsUauLtFvucYOEebe+6If1SBrPHix+clTZsWG8E3qqZHyStEdlSfyq0k
	aIIItnOITH5NTYo9vOMBRvQGE1cEB+4/ydE/GPEfhJKwIXeecLXNltGKsKjRmUv9
	lQj5QijcE4BDShn7/xoGiw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yhbarahn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 22:43:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584LaSXn032527;
	Thu, 4 Sep 2025 22:43:44 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrjg4u3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 22:43:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lylkt9O/kNcuo//pBMyBH4e2JJKrCPR2KmUjRGQKKhp6L+9LjGkp/XgykPkHz7KmrTHT550EDjov2b1/F4v5r3gZYe7cnSL5L//VrPoypD7S0AUK9olbeHLA+x90JL1sbdm5jmKt8zACgDUgReDEZCNNJxMNSulWxhVraDC0FmAWAPEgaDsKvQn2T1hnlPlVIvmfL9FbiEVmNx6Yxkrp/Bym9Zc63xopgkI1FZw+Z+xQeGa23TagSlPM3Wy+CM9QD0l0Y1XLSlbWwLXvJd1FWtQwXMi98gGH1qpNpjcvdOkz0pAlJQCpYta6zXDZmh0kj7/GgjOPl1+jCj5mfn5New==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D/9VXahAUkAPYoSqXF4/Lz13Fv1nmWRn28/gdGOFFg=;
 b=wqR+bTnxhLH4HhF5bBKgbwL7/eb7jEvqMRtg993rr48uwGeQftrm22GEUN1w2103Vf1lKEfUyU10pKdDNmvf+jUMwMfri1ttciCbVDUUiAKeE9UjTPOwiI/Y7npuSyqah7Xr+uUkXQszqcAMPfKQDsvSISHWgOKcrGpe/78musa4ij4bsKXaiRq5SC0nXTLVEMl1LipmCeUa/nC3/LXmaHtmQA/Hbfwx7PHDp0fP8jnb6tiCGTfOG0oXzMuymdjBES2FDob/fzCr/ra4tCMgVn0JsJZ2RNzQftlqudnMse9jGvGqtbXniG7wAFr+mFzBz/uOVrYKgxg6cevSfld5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D/9VXahAUkAPYoSqXF4/Lz13Fv1nmWRn28/gdGOFFg=;
 b=Pto+aaMK02w/Utnrbbm5by45wCfvJ8zmeOtkDonpuBliEp7PElnEeR/OaCzXcXJQ++YvNvqSRNuC+z8HVIfAvxkxAtd1J7Z9IAKWIsY/B9xuvkjUnFBQ0zdg18BfS3jCyIswBGt619OwmZ8LnGJYAgRn3/zLERWIPAms1qpuhFM=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 CH0PR10MB7497.namprd10.prod.outlook.com (2603:10b6:610:18b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 22:43:42 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 22:43:42 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        Haakon Bugge
	<haakon.bugge@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] rds: ib: Remove unused extern definition
Thread-Topic: [PATCH net-next v3] rds: ib: Remove unused extern definition
Thread-Index: AQHcHazCKrihF176AUS8Nurpy9VsgLSDn14A
Date: Thu, 4 Sep 2025 22:43:41 +0000
Message-ID: <4fa2f7bd9f9fd0d908e6a5ffee19bfd7dc6bde1b.camel@oracle.com>
References: <20250904150105.3954918-1-haakon.bugge@oracle.com>
In-Reply-To: <20250904150105.3954918-1-haakon.bugge@oracle.com>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|CH0PR10MB7497:EE_
x-ms-office365-filtering-correlation-id: 06594392-0c9f-4843-ef99-08ddec047f7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UzdaVFBESTk3K2pCYjhsZ1BhZkIzQWRtVmhyY0pOM3JOUUIzc3poSXR6VldM?=
 =?utf-8?B?RXhTNmpudGlnUEw1VlpyaUJuZ1FUem93S3d3R2VHYnhGQ09hb1VDMHA2UlND?=
 =?utf-8?B?bC9nTDgvaXovUlNQYXFLUS9FYTFYYXRYQ2RFcktyc1I4cGtLZXZkcWI4VXli?=
 =?utf-8?B?U1hkaGxwcXJrei9pM2FzZlRjaWlOSndwSHRQbmR4d3Y1WFh2NEV0aDUzbGVn?=
 =?utf-8?B?cnRYbHZxWGd1ZjZ6RHdiWU1VMmlnU1RlZit3VG9ieGFtZ0dVeEdsSkZ1OWd5?=
 =?utf-8?B?cXJNK0ZXb0lYN2c1UFZDVGpiaVJkck9xRUErK3JQNTFGS2tsWm9SNFk0Q0tu?=
 =?utf-8?B?NGx3SlpSa05CNG0xYTFBVVRkem9HakQyU0VEOHJVM0RPTFd6TlRPMmZqUWxy?=
 =?utf-8?B?MFJ2b21mWC9WaHI0b0xmM3V6djF1bzdCODJNeXVLZGJDcm1sWjIzdEtHaHVZ?=
 =?utf-8?B?bHBjZzNWdTZzeE9zTFlpaVJXZ2NkNmJqOWlEc0dYdFhxY0tnTXFUakJwMC9i?=
 =?utf-8?B?UVoxNXlJaUlYdnMxcXRFQkt1Z2hYS2ZFaE9DWHU2NVRSZzFHbG1VdWl4ZVQ0?=
 =?utf-8?B?OWUxQm9sVDkzczVNdXJ0amphZ094M0N6WjJjQTZVaDZrSEtDS0Z1TnRiU2M1?=
 =?utf-8?B?YzBlZXRydFFHeWdDSm9hTVEvdUFlOFNjSFpKODNLTUQzLy9vVFN3NlYrR3R4?=
 =?utf-8?B?aEdTUitKM2Q4ZWgveTFwTXNnSFpqem5DOTFtZ0FmN3dvZHovOUVJWFFzY0Vs?=
 =?utf-8?B?dEp2VFVKS1BqblBBckFlb3hvN2JHN3NVNVdNd1lxbDEwb3djM3VSQXpCWDZU?=
 =?utf-8?B?Z1pBTU9tWWJHQWNERHFCdi8zVC9DQzhYUTJBbzhvT2syV0lsY3JRQmg1YkpY?=
 =?utf-8?B?M2ozYWlOcFMyS0dWMk10c2thVnc0ZUF4RW14cWFVcTYxSUc1TFVKV04xRFV4?=
 =?utf-8?B?dlYvdThzOEx1YzdVdGd0T005YVJGSWZkSjFrbGtXaWRwRVRoWW0yWXpiRENo?=
 =?utf-8?B?NXREY1BqS3BEMlVoVEVKVGJQUUVuclNLRnNKbklvNStBMDBaWER1eUVwek1U?=
 =?utf-8?B?Zm1HeTY5ZDM0TWMwVE51bGdlY1NZaEQ5R2pLQnlzcUxJMTgrenp6SGJBNUNm?=
 =?utf-8?B?QWxodTlwNDZmMTVKb2ZlU0NXKy9VVVZXTysxeFNNS1V2Y0d5YjdnZ2hFQjBp?=
 =?utf-8?B?b1hORVdUTzJlMWJwVEFMVlFraktsOUJNaSthVCtpQlQxRU43SzR4dGxOMGt1?=
 =?utf-8?B?UGxLb0lBdllCbk1DdGJFVXFad0FuZ1RaelpHa3pBYTUrZ2RwS0JjSXVIdTFi?=
 =?utf-8?B?Nmg3aDhCTzZEWkFWSjlHRDFPVHZpa3RiQytlM1l0djRCNi9JYm5ES1M4WnBw?=
 =?utf-8?B?R2dCR0hhclE1SjRFTGtNMHg3RCs5Yy8vRkh0TFdzZG5VUWVFclNXVGxDYkV5?=
 =?utf-8?B?QzgrVmtsS2x1U1AzS2dacG1Dam13N3FrTktZcVlUaXM5eXU1Y1FueXg4NlEw?=
 =?utf-8?B?M3FkZlh1QS9WRHdwemZxQUNuVG1sVHYrMDFaandpVnlid0J5U2EyOXo5UVhz?=
 =?utf-8?B?MFN0OGRGZDJEeXovTStLN24rcGJFTnEvVW0zUGtKMy9tVWY3UGZ3RS9mdU5a?=
 =?utf-8?B?WVBQSDFIbklPWXNHUTdLeE9ySXBuQUVOOXlsNXdXbzlPZTdCbjZ2eFl1REw5?=
 =?utf-8?B?eXRnMWpmU0JpQlhWSThOQ1Nac09UZzFOek1CdnBtM25WODRDZSszRWltZzh1?=
 =?utf-8?B?czkybnJ5S0Q1MzlRQ3I5OTNMcTZuK1NQbzkwTDZrK2E3K0Q5eEhERThkMVBs?=
 =?utf-8?B?ZlJhREJITFFvdnczS3FWeStSMUFXb0ZzNHlVSkkraFdJd3NsZzArd3d6aUV3?=
 =?utf-8?B?cjNySnlQbHNtdVlWNEFzTlNjd0kyVHkvcnVoS0hZY0pjbVJPbWlxa1JWdmtT?=
 =?utf-8?B?TFVKNEFxeFhpNDhnbS80YWM2aGFTenNPVW51SVg4Zm5YWmhLWmVyMFhEY0U1?=
 =?utf-8?B?aTFucExyZXJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TENzYnFONFNyK3VKbk01WFdKU2xZa0pXeVJtZ3dpTjVPU3FqZGVKRHJZVUtR?=
 =?utf-8?B?eU9yUEhJWkFpZzVaN292Mnd4Q0FGUXVIaENEYzFqUjFOK2RFbzg1R3ZWZVQ5?=
 =?utf-8?B?S2FZVzRaMTM2bW9oQ1pJZ3Boc2FDcTVBcGNOdW90TjJ0VUZzaVFScTQ3Y3I1?=
 =?utf-8?B?Y09SNEtleDR6RHpSNW9RRCtmQWhmeDk4b2xSaXdSQllWVXNYb2FqOGdYTFFj?=
 =?utf-8?B?eUYwendPWWV3UjdNUE42aFEzbVREeHRnbkIxeHlOcW9GZG1kSXllZ0xzVmFj?=
 =?utf-8?B?ZGxudkxiQ2FTVkl3ZnQ1UVZkeW0xakZYUW8vTlZwQkVYZFlvMVdUOWdpcEpp?=
 =?utf-8?B?dUkzOVQrcmJSM1hVQzhUbURvcnV2RzY5Z1lPM3ZYNEdtaHZnazRzMnY1OG83?=
 =?utf-8?B?NzdWZjJ1dXFJd1hKcUx1ZGJ0MUdvT0VCTHpaZCtMVmxCU1pEcHJQUWx4T0tL?=
 =?utf-8?B?bXdlUlViamU1bVg5N3gvNTA0V0VBR1dYdFpFRlVXVGRFRi9FYTFmaEU5QTU4?=
 =?utf-8?B?ajlNL0Q5R2lxNWJ0cHZZZjc5R1pNc2hnTFlDOHUrY0FGKzJKdUtTZWl5aDJt?=
 =?utf-8?B?RkFMZTY1RUtqeXMydWhCNW5JMnBwc1kzaUlDT0I1ZE5yUFBTcUh4M2FQSnRR?=
 =?utf-8?B?Wi9sVWZCRERMaldOMWVSeWd1SytZSFBXK2phVnVLY0lUZ2VNWW1NTWdwU2VB?=
 =?utf-8?B?K1VoSStvVWoyaWNhaWY0OGZvQVlRMXh2b1U1aU5iWE0wcVZYc1ljazlGTjdy?=
 =?utf-8?B?ZXMwNmp0bWsra093bGZDdFpxYW9DMWZzaTV2Y1BhRjIrVURYMnNNM0MxT1F2?=
 =?utf-8?B?T1VmbFMxZWg1NFdGUWVWUzRJOUZ2KzN0cUZyRUw2emxnYWtsZVpBRjcyR2g3?=
 =?utf-8?B?cjZmcFQ2ZXZHbnl6amJvUGdKOXhEZVJZM0tGcVVIVFFrSW1pNk44MGZyYVlo?=
 =?utf-8?B?cDVsU1JPUUNsdDR6N1M4N1lPaVF6YXFuV0xrUnRTVGprbXorWkJtc0J1eWFI?=
 =?utf-8?B?MmpGRXgwejV1YkxmdFUzZlZQbVE5aGVhVDlXVmNPVFRBS2VkUXRzczA0dWNO?=
 =?utf-8?B?MTB6VDcxMi9VTDdEeEFaaXRRbVpaanhpaHZZSEcxZ0dSeVlwd1B1OGZOanNq?=
 =?utf-8?B?MTExVk1IN05pMU45cU5tVjdrQVBadmNaaWRVb0dYcUlqWnJIUmpFSHJab2x3?=
 =?utf-8?B?cHVocDdMRjJwaVhBK0p5b1p5USthRjRMRWpHQi9ZTEdJQzQ4ejd5aEpKaXhP?=
 =?utf-8?B?d3hjY2taRWtXRGZ6V2N0bjhIS3JwZCt5cmhHNHhHY1dybWVZRWxvV1VEZVc1?=
 =?utf-8?B?bUV5Z0wya0s0cDBjbk9LZE12SHh6cWRJRHNFdkxjcFdvQW5rNytsV1phZE8z?=
 =?utf-8?B?QWtKcmgxb29qb09sRjJ1UkhUeWRnNkdaTExYa0tUeHRwWXY2NEdudzg1NHd0?=
 =?utf-8?B?MW5Eb1h1TEhHamhYSC9tdnI5NHFtaVoyaGVTK1p6dW50eDFDRGJtUE5lUlE3?=
 =?utf-8?B?b0dCYXk3R01tejZnWnljUzR1NnZ6NGlZTnJqa2VRTEJsVFdsN2FFU1ZmZDha?=
 =?utf-8?B?QURNWi9YOURuR1QyYXFmVjdKNURWR3pMaWN3NkQyanhObXA1bVVhRjhLYTEv?=
 =?utf-8?B?eXI0QmJzY0dzS1Z4M3lKOERTYjdHaTJ1cWFxaVUrbjVLenkyYndCNExvMEtL?=
 =?utf-8?B?dVg5UU1VUXlwM1Z0bURWS2diaVVjeVFrbHdxaDVFV1V6am9kNE40cmFEMU91?=
 =?utf-8?B?RnQydGFHdExBVFRUZng2TWtFR1Flc01Ia0J1UlVNalpla0p3OHkyZUVLZVdh?=
 =?utf-8?B?SEg5NW5MNlpCdFlqVjFTVkZzQk0rVHU2YkdMeE9yZjZkN3JYSmx3dUFIR2xz?=
 =?utf-8?B?UkVtTm45akdKbEpXdVUwTXFhU2xEYVlHaTlCcTR5ZTI2N1Zyc3YwNU9HY1Bm?=
 =?utf-8?B?MEFDMDk4SnIxTU1ZNWpvZTFWTXFlREt6aUpWVEcrU2VtaWl3LzlTWlRYNGFX?=
 =?utf-8?B?anY1aDJISkFiMy9UclFrWVhuNkxRbjZNZURrdUw5VVlkSEhWVXczdGlnZVZn?=
 =?utf-8?B?dmMvdVpVS2NtOVBHN1B1dEV4SzRXUzFHd0pRYjBhclpJWG1HNWVCcmM4ZFp2?=
 =?utf-8?B?ZjlvUDRzQ1lrN05FVTRIZXlaczZELzBqWXVjNjNXVHlnc2paTmhqZm9zNU55?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAADA5D576B0FC4CB3858D7DE4C09EBC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DEr5e95Wr1ZO6ZLvEbPGOZtXnNsnVWyBhj3/r8rPWgLVyD8mPmcWGJq+pe0QsaAPMN5i+jOJmaKJMlGlgPgYiCM5tAohyZxAvxqU9+mjRetMbv5f97C/OXAKktke8k2+u3Ssqvf92eopGqgvVmFyX89t1o6YJou9Z0NYWk3OloceC6xIy60+rRgsse1aou5HgN1E8ihTJjV+5CdHZcaMdltSZy7RK7gITERbg/WO8xIwXiQoXETDSYWmuhKx4isZnucU5Zx3F81SgMyqYDBkxoXaq8MqE266VTO1J62SCr/BOclrMwdns2bHbcAa0G2v12cGP+/v+x7MjDK7SKkDIq4HGk/g3dS5U3OqwXPEbYg9uMgMkZcKfph1GA2AxNGOVOjRRhBiKPPlvzLxYw8i+LpgSSdxHgE6K7t2shsgNATvynUcFfobpxF/+ZxubX299/zr0DgpsssB1e0cZb3x3SYu697oiM0nvEWXKEtMTHFj2imJMbQqZECstkYMZVfQGB/Hx+ILR/n45uTRSjq+zmtfkydc0k8M8GwUfPKBcyRVlSAkvrXfVfnmp32ezBnzUw32h9OZ5gsAZH0R0QHc7rv0/Em63aAvhJfLilQZaFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06594392-0c9f-4843-ef99-08ddec047f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 22:43:41.9037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /UqPo4GqPp4js0x/sNO1Rc++zIvkpb+tfTTTXiaP2ZG/n1XY7gEJzRZIYgIW0/fabRR2+bEEYrGo8LQumqFNzw0E1nXfZkkdqs8pX5EFyeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509040224
X-Proofpoint-GUID: qWdteDubuBPWAOCfFX81iODYCPE3weIh
X-Proofpoint-ORIG-GUID: qWdteDubuBPWAOCfFX81iODYCPE3weIh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE5NSBTYWx0ZWRfX493tJaZmYz7l
 HKHujfOz7dlmRVHdNfKnrLxQw4Xzubn91+c9jX5t7bDCiO+DFNnvno7eS1jfIcFKf4E79dVYlwD
 0upsc46fPVHrpoRMaspPtMsPl0R/C7ijte5J03dkz5nrPHi/6eDRh7lHB9FtVpnSp2gicAd4dqe
 qPEZ6R7GUATubCK5lmZxup7Ikwie7lsnHJmzwvVoqDoDzemNrjFLRCTGchiu/dBwNPk9Udi2jBt
 IfLuIS4JSXVCykr/R5i+x8fQYnpJ4d8Apvmdwjnpw6OypWVDZ1O70PQvX5s8hW8wSBbetGCa3XB
 GUudRp2O69eSruNzuz+yNvvp644SLYvcZKEV7zxFbQ1ptdW17+rfzb4UHepluUw4uXrDr+fSWFx
 2LzVBYG3iKWYMQFATB1CvC/hC0ObYg==
X-Authority-Analysis: v=2.4 cv=WKJ/XmsR c=1 sm=1 tr=0 ts=68ba1622 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=KwJhsrxoU_kzPiH7baUA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12069

T24gVGh1LCAyMDI1LTA5LTA0IGF0IDE3OjAxICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+
IEluIHRoZSBvbGQgZGF5cywgUkRTIHVzZWQgRk1SIChGYXN0IE1lbW9yeSBSZWdpc3RyYXRpb24p
IHRvIHJlZ2lzdGVyDQo+IElCIE1ScyB0byBiZSB1c2VkIGJ5IFJETUEuIEEgbmV3ZXIgYW5kIGJl
dHRlciB2ZXJicyBiYXNlZA0KPiByZWdpc3RyYXRpb24vZGUtcmVnaXN0cmF0aW9uIG1ldGhvZCBj
YWxsZWQgRlJXUiAoRmFzdCBSZWdpc3RyYXRpb24NCj4gV29yayBSZXF1ZXN0KSB3YXMgYWRkZWQg
dG8gUkRTIGJ5IGNvbW1pdCAxNjU5MTg1ZmI0ZDAgKCJSRFM6IElCOg0KPiBTdXBwb3J0IEZhc3Ry
ZWcgTVIgKEZSTVIpIG1lbW9yeSByZWdpc3RyYXRpb24gbW9kZSIpIGluIDIwMTYuDQo+IA0KPiBE
ZXRlY3Rpb24gYW5kIGVuYWJsZW1lbnQgb2YgRlJXUiB3YXMgZG9uZSBpbiBjb21taXQgMmNiMjkx
MmQ2NTYzDQo+ICgiUkRTOiBJQjogYWRkIEZhc3RyZWcgTVIgKEZSTVIpIGRldGVjdGlvbiBzdXBw
b3J0IikuIEJ1dCBzYWlkIGNvbW1pdA0KPiBhZGRlZCBhbiBleHRlcm4gYm9vbCBwcmVmZXJfZnJt
ciwgd2hpY2ggd2FzIG5vdCB1c2VkIGJ5IHNhaWQgY29tbWl0IC0NCj4gbm9yIHVzZWQgYnkgbGF0
ZXIgY29tbWl0cy4gSGVuY2UsIHJlbW92ZSBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEjDpWtv
biBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+IA0KPiAtLS0NCkhpIEjDpWtvbiwN
Cg0KSnVzdCBvbmUgbml0IHdpdGggdGhlIGNoYW5nZSBsb2cgaW5kZW50YXRpb24gaGVyZS4gwqBW
ZXJzaW9uIG51bWJlcmluZyBpcyB0eXBpY2FsbHkgbGVmdC1hbGlnbmVkLCB1bmxlc3MgeW91IG1l
YW50IHRvDQpoYXZlIGEgaGVhZGVyIG9mIHNvcnRzIHRvIGp1c3RpZnkgdGhlIGxldmVsIGluZGVu
dGF0aW9uLiAgT3RoZXJ3aXNlIGp1c3QgYnJpbmcgdGhlIHYyIC0+IHYzOiAvIHYxIC0+IHYyOiBs
aW5lcyBmbHVzaA0KbGVmdC4NCg0KQ29udGVudC13aXNlIHRoaXMgcGF0Y2ggbG9va3MgZmluZSB0
byBtZS4gIFdpdGggdGhlIGluZGVudCBuaXQgZml4ZWQsIHlvdSBjYW4gYWRkIG15IHJ2YjoNClJl
dmlld2VkLWJ5OiBBbGxpc29uIEhlbmRlcnNvbiA8YWxsaXNvbi5oZW5kZXJzb25Ab3JhY2xlLmNv
bT4NCg0KVGhhbmsgeW91IQ0KDQpBbGxpc29uDQoNCj4gDQo+IAl2MiAtPiB2MzoNCj4gCSAgICAg
ICogQXMgcGVyIEpha3ViJ3MgcmVxdWVzdCwgcmVtb3ZlZCBDYzogYW5kIEZpeGVzOiB0YWdzDQo+
IAkgICAgICAqIFN1YmplY3QgdG8gbmV0LW5leHQgKGluc3RlYWQgb2YgbmV0KQ0KPiANCj4gCXYx
IC0+IHYyOg0KPiAJICAgICAgKiBBZGRlZCBjb21taXQgbWVzc2FnZQ0KPiAJICAgICAgKiBBZGRl
ZCBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gIG5ldC9yZHMvaWJfbXIuaCB8
IDEgLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9uZXQvcmRzL2liX21yLmggYi9uZXQvcmRzL2liX21yLmgNCj4gaW5kZXggZWE1ZTlhZWU0OTU5
ZS4uNTg4NGRlOGM2ZjQ1YiAxMDA2NDQNCj4gLS0tIGEvbmV0L3Jkcy9pYl9tci5oDQo+ICsrKyBi
L25ldC9yZHMvaWJfbXIuaA0KPiBAQCAtMTA4LDcgKzEwOCw2IEBAIHN0cnVjdCByZHNfaWJfbXJf
cG9vbCB7DQo+ICB9Ow0KPiAgDQo+ICBleHRlcm4gc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKnJk
c19pYl9tcl93cTsNCj4gLWV4dGVybiBib29sIHByZWZlcl9mcm1yOw0KPiAgDQo+ICBzdHJ1Y3Qg
cmRzX2liX21yX3Bvb2wgKnJkc19pYl9jcmVhdGVfbXJfcG9vbChzdHJ1Y3QgcmRzX2liX2Rldmlj
ZSAqcmRzX2RldiwNCj4gIAkJCQkJICAgICBpbnQgbnBhZ2VzKTsNCg==

