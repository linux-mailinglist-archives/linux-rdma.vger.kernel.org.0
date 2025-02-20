Return-Path: <linux-rdma+bounces-7903-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3120A3E432
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 19:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8828E3B9496
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB70263886;
	Thu, 20 Feb 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zaxv8/cH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZZ//hUh6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C601262D3F;
	Thu, 20 Feb 2025 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077378; cv=fail; b=GEOTx3HI8NYi+T3J/lY7VaKy0LH95+fNG21JhaGS8NIc/uh/eop/J1V8/RhS1P0YzZtSiVYrKnYkWHL4tAkhEub+qfno9/du2ibn+qu5EjlLD5e6GlUKxYFbPgXmcbe6jMQs8RbExQV27PgSJ+VcjuQtdnplbagIamBAPc790Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077378; c=relaxed/simple;
	bh=YzSHL61H/K+MxkRElpok8tUZIFZYcekod1QdhwtwtQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o1bs3o4zBn4n7hENW2pvR300MKeSbqarXs4yD5XmpbR9jdWf/MH6+muUYG4h3Xqj/5p2pS7sTvAeJyEZp4IvvZw0gUBstBPSE5aQfdzYy7Dgp55dXXgX1OpZjaSsbIKGGZp/izR3BOZONjmM8Xi9FjQwsR/xCUP/xVXvlB8ZTuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zaxv8/cH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZZ//hUh6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMdaA012647;
	Thu, 20 Feb 2025 18:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YzSHL61H/K+MxkRElpok8tUZIFZYcekod1QdhwtwtQ8=; b=
	Zaxv8/cHmzBiSXFfG/5w7Crb7v6dIawFuNSvgibcCiqDpKl0hYdSetIQPExdS+PU
	K3mhWb1yWDiikfLi7pRZhiJLFrwsUzin338kIHaY7rioeH0SPTQaGU3sSAbaBkih
	4vbV3oA63hMCJWoe/uXwfB4A4XmwauFhUuSpm4ystBvsVKbNz5hscPM4Jho2MzYG
	IlnnB8MiBOwDKebv8Weklee1BG/j4YoDbKX5t0pBDYTRyHbypxch40gXNhdmyKt4
	1uzqx0iT9UHnAKrEiLyakuVQ6EIpzKS6TQj5UaSVY+O2sN4k3Y1nVLbEKMV4yrFB
	FmtHKdtMLM02ZCz9F7mm9g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nmt0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:49:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KI28Wj026196;
	Thu, 20 Feb 2025 18:49:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0squag3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EufKKOZeVl1sRnTzBs9Y1L0zyyQKtKa55P+piATyFXQSNP+NPF0lh7mME4BlYj2YDDJ4/gG/q/wGtDHWUKAzI5knuEI1UzCeY9FmgHYwluQLJ6yKHE2ak1MPZBQ1aK1WG63g+76Y6Kjr0j3vvaMao/P12FRFWXKjjWk+9BJYWXXFRzQ/tC+Oi/+R1kDh4tclYDcZCIeRUEfGJhDuTChM3TrEM++uhxjH2HfhZOY7Mxw4emoIz8SJ7ZBfj+RjOH/vIklLSMaQJfKcHebxtZAeuiq0zEOfGQaxpXvOXZ8H9ggc/RXNnHUgoj6UUlXjokmpvFZIeCGytFgZMADq3JeKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzSHL61H/K+MxkRElpok8tUZIFZYcekod1QdhwtwtQ8=;
 b=RXTUst+Ykzw5RiJJnzBP4cKvGj6lgrnHp5MEDEADPNeai4P93sPd8bHNqsYOTF7/vPCPbewBJmQ/LRbo+Z/Y3I/0SUcaJYun3lirGgannQS2C9boaWLOdXklrG+1aMa3v15kc3aQ2W5XE+nlYWQcrnuu0eRY7mlqL4w1EVSP4NdFQVetqeYm+hPK35EWZgVF6wwfW8mDxNK/e1nGeBmeYqbYqmTcbvkywaOUl/a1MGIOiYCxW0CAvGriziutfx1836MuUkMzHvkwft6eJEGvqzq1qj+E332RLIN9nYrFbkK2CYLmUuUVtswYv/nqriyYH9b39946idMcRoxcq+mv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzSHL61H/K+MxkRElpok8tUZIFZYcekod1QdhwtwtQ8=;
 b=ZZ//hUh6wWkKiNPeHSTJY/E5fT0WeOrl5omB2ESnODgVh1kF+iZk/IHGIyEn4D2BCFAM7VjzW5jrCD+OlhNw+KXKJ243+Q1uBIY/JTE7Bzqy6wTMG5sSs4DGVGOihGSVyU+3Edo9gEZT+ixjVTBITpZ+f4X6df7kTEZxXfxBZWA=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA2PR10MB4620.namprd10.prod.outlook.com (2603:10b6:806:fb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 18:49:17 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 18:49:17 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net/rds: Replace deprecated strncpy() with
 strscpy_pad()
Thread-Topic: [PATCH net-next] net/rds: Replace deprecated strncpy() with
 strscpy_pad()
Thread-Index: AQHbgyBo0OVtXvhkZkCSOVkY1YXPZLNQfm2AgAALmgA=
Date: Thu, 20 Feb 2025 18:49:16 +0000
Message-ID: <b2ca154f7fca1c66e8c54075d90e6a2ace1a9a14.camel@oracle.com>
References: <20250219224730.73093-2-thorsten.blum@linux.dev>
	 <ab3b748710ad7155df8477646706e8ae05c36321.camel@oracle.com>
In-Reply-To: <ab3b748710ad7155df8477646706e8ae05c36321.camel@oracle.com>
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
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SA2PR10MB4620:EE_
x-ms-office365-filtering-correlation-id: 95e66295-0d52-4af5-434a-08dd51df4724
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmo1WWRkSkwwekVzRlBGUzdqNGJIOEo2Z2FzUGp3bUF2NnYvVmFaUkJUamxi?=
 =?utf-8?B?OFFoaFZEVmJKWE5GZDFBcmR6bEFlQnE0VEVPeDl5K0ZQSnptYmdUdlBrd3ZJ?=
 =?utf-8?B?YlNTUnF0WXh0Yk9iNDlKNDNyRmNrNHhaSzFTV2M3QlN1VjNZMENSY0tNdy9k?=
 =?utf-8?B?RG05QTYrZnI1aDZ1aCthQWRwVGtLOFh0VG1UVi9iRHpRK1RNa2VvS2xabkFM?=
 =?utf-8?B?OVlhd3pYdEJJSnJ2VjhrdjluTXIrcE4rOTlyUDVORTVVR081eHFMZ1hBZlZ2?=
 =?utf-8?B?MDA5UzExTEYrY0dDajRkQkJPajZ2WDkwNm5GcFkvNk14SkNsbWxGNUk2NTN4?=
 =?utf-8?B?anlQd3o5RnpRWU0rWGZGZmhNWkdiRkN4K1Zpcm5kazRYMGdCbDN0bi9lVFZj?=
 =?utf-8?B?aDZveHhicVBqbHpUWnRzNlhKaHU0cHk1RmdHT21JV0g5eW4xaEJqTmI0ampL?=
 =?utf-8?B?NXplcGVKQUErUW1uWEJrS3g4VXIyalZYTk5mTlJFSzFQRzFFcmVKUTBtMEFJ?=
 =?utf-8?B?TnExWnJod2xuUytyKzZCbTdRVm5XRzkxcWpBQkR1clBnbWliZWF4dlBIWnpV?=
 =?utf-8?B?d2ljeFo4Q21jZ3JFaFh3enkwSGgvbityQXNjMEVnaDM1bVpzOGhHeU45OTB3?=
 =?utf-8?B?a2J6bDJQTDc0VEtpL2pyVFUrUktzWitaVnB3TnZIakRPbzFMRmk5TEkzNmE2?=
 =?utf-8?B?ME11bEVQZkJITCtZY0xocnZ0UjFSRnAvdERMRFVpV0htOUUwSVAyY3BqME9t?=
 =?utf-8?B?K21rb0tuUXZkWXFTNnRzVU10Z1BrWFJBekJ1cDFDZ1F6RzBtOFlUSCswbmFr?=
 =?utf-8?B?M0tCK3NTL3pxRjJTNTY4YjQvU0I4Qm1QN0tOcDNGaDFVN29qdStQblNhZUVu?=
 =?utf-8?B?VzdCdFNkeGo2azR6VnFHT3FBSDY0bkl1UWFJcE5ubDZsZDZ1Ukl0Q0FlTGFB?=
 =?utf-8?B?VndNSmoyZTkrQ2hTZ1JoSndlTEc0ZFVUZlBRVVVsMmpOdkUyaE0wZjlZS0tL?=
 =?utf-8?B?ZzdoVFdDNnpXL1p0ZEdXVVJLc0Q2ZHE3NE9YMk5jV080VmpRalZIYjdKV3po?=
 =?utf-8?B?a3hDeVllcWhBM3pWbzQrZUlncHVURHpERksrU3MzY1RrUUdNWXNIM3JpMlBZ?=
 =?utf-8?B?TGFxNVNkR1JYVHNCcXRkOFhmNEE1RlRXU2ZycSt3bGVmRjlhbzRaOHU3WkxU?=
 =?utf-8?B?OTV6UUNFYldrSmIzYk5QV28xSStlOTRDNHhVaEd2M2wwL285RHl4U0VONHpj?=
 =?utf-8?B?NGk0TzBnYW00T1B0VldSUEFJTC8wb3hnaDFPMjVUOXBaSitkQjAwZnV4UWth?=
 =?utf-8?B?RFoyVGhTVWVNZU1GNG44YklDRFI0L0xNTENSTUs4ZHFmUWxkWStvTXVXVFZu?=
 =?utf-8?B?K2VjT3ljWEdNQVF6S3BsaGxmZENiSUI1RVdjNHB5WWNZM3BOT0JpVklnMlRI?=
 =?utf-8?B?VGxjS0N0NmVIZGlSMlViSHRpcFloNW5XMDZHb21ZMUFKOTh3L0kxYWx2T2pY?=
 =?utf-8?B?V3dwUWJnUnRPeit5bFZBbVVGdTBTNFhUQjJrbEtHSmlaeCtIb0REQVpmOUh0?=
 =?utf-8?B?bHEzaU1KSzd1eks4YVRzbWgrdDh0UDhZUGNEZVo3TWpQOS9NOUFDWExkSmNH?=
 =?utf-8?B?Rks4dE5XeCsvOHluNTV5dXhJNlRGL3htYVM3c3B6Y1pTc2dlQ0VrVGlYZDBL?=
 =?utf-8?B?bUNJVUpDZ3dkUkNzM2c5ZkVLTExSc2NLa0NWRjdnamF3Z3FWVWkxaGJvZlhH?=
 =?utf-8?B?SjB6OHJyMWkzVVBhdGcvb2MvRlpWSnk4dWFUVmc4V29hZTl3WkZWYjA1eU51?=
 =?utf-8?B?WWFOU3psekxIU3BSYWhLRUdWcmtGdktrMFBscmVsWWV5aWdKdndmUFJQczJx?=
 =?utf-8?B?VWJRN3lxZVlNaHhHS1BnQmp3MzZqK0hla05mdkFsWHFWeWJiZlNIK3ExNTMw?=
 =?utf-8?Q?6UdPC4sYVmaYpkUvavyxWH2GMPl0CqcE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFVBSFpuVTBjWll2THJ3SnlzUjlCRkMxMjVTYTVOdjlpcEJWRzgxdmZHeTlX?=
 =?utf-8?B?NndhWW9mNTFmclRmY0tjYkFxRjhjQ2d4Tllid2UybE5yaVJWdkpVMXExdVVL?=
 =?utf-8?B?dXJFZ3ExZEp5cG5ZQm9vcHoydS96dWswMDc0VFdycnNtZUUvSHNYby9IT3Bx?=
 =?utf-8?B?K1R3MkR6MngwVFdSazVGd3Y2elkxcUNFSnZHdmlYbmZTN05pUjhoazVYLzR5?=
 =?utf-8?B?SUxhT1ZsMktDL3MrbktyeitwcnIySG9lOUI0Y3IwMlY3WHZvd1c4M3U3WGVM?=
 =?utf-8?B?eGNRV0YzUXhkVmJkVUFMZXliVGNHZzlqZmJzMklZaWFBRFkxK0s4RlRRakpX?=
 =?utf-8?B?Sm5ORkMrcU82NjduL0lIcU9iM0NjK3dsTkZZZzFrTzlxTk9YRGR4bUR4MmJR?=
 =?utf-8?B?dm9ZNSt6TVM1VVd0Ni9JWkNyYmJzTG9hNmVxZ01HOVBWM2VmL0JEeVZzcGYv?=
 =?utf-8?B?R3U2YmtRUXpVaUdPQU1BVUZYMFhRdVVDN1A0TUtFTDhiTUltcDNYdDZRRWRR?=
 =?utf-8?B?bWE4SVVKWWFua0NwQ3lTc0h6blpqTHdVNVNBSkw0RjRUemtmVU40UU81M3Jw?=
 =?utf-8?B?S1RsM2IvaS9WUVprUTJMZjhYYUtZTVl5V2hLenQ1OHYvSVp1MDF0Vi9ZOHAw?=
 =?utf-8?B?SDVTbTRZbG9GUDIzTEFaK3kyODF5RGl4Qm9rTlEzaUxiYlFUaTY1bkZ4YzFE?=
 =?utf-8?B?SkRjcVV5c0RFYmoyb0pMUUJkSjhUOHZrU2FwR09KNnFwRVp0WmlZOFk1eEdX?=
 =?utf-8?B?QVAydjVmdUphVjFGdVBRSTBPUWJNa05hbjEzaG5MbnZMTEdkZ3Jaa25GNXcv?=
 =?utf-8?B?VklvR0plbnZCY01Oam5FNmpBdlVSc1daWHJ0NkdiUkhIWmdIMFhYS3Ewb2Q1?=
 =?utf-8?B?VjdCWmtIL1FnTGF5a0x5eUdHcTM5REVFa1FZRmloUG1YMWJkUCtzcE1YZUI0?=
 =?utf-8?B?b2RpZWZoSmt5VVh5NW5qNTFjeHEydVFNb2Vzc3U4dWhPdkdxMjBFaEs4OGNs?=
 =?utf-8?B?NVNlNjR1NUJvMmRqT01hN0VPQm00K3N1RDk4OUFtNlRuVC9uUU1qQk9SbDhI?=
 =?utf-8?B?SmlMUmIvVTVxVDArZDNsSHh2R3JDOEpsb05YdXI0enNoS1pkVTRCQ1pWbE9N?=
 =?utf-8?B?YUV1blBkK2RJZWN1bTVPMXBNNXByMGJEUDhZcStTekdBWTBaN1FCN25EMjRG?=
 =?utf-8?B?blhxVDVkQ2RCSHFhSm9SaEZFUDhaWG9BVmlhOWhnYUdpY0Yyd2JZOFVUeUtx?=
 =?utf-8?B?ampSakw0c25FVTBGU3VhbG9MMjZHZ1p4UjN1VVVqaG0wN0NHNnlLaUQzUDAx?=
 =?utf-8?B?di9TWWRDVGU2dHRtR3YyNXFIcGF2bDUrZTUvTEVBRUg1c3VibG1XQ2EwWmFa?=
 =?utf-8?B?UG42WUpEZis5enA3ZGdZQlFtREhlamVZL1ZzYkdJVU8wNE5WQzRqM3pFMVdC?=
 =?utf-8?B?Y3pZV1d3OWlnNURxRHFzUHFhT3BYNGNHOXcvaWZTci80V0RRQTRpaVBvTGRu?=
 =?utf-8?B?SUpYMkNFdlZiM0pVS0U1Nk1TaXh1UE55NVJ4S2V6T2VLN2Z5QjZXNnE0b3NV?=
 =?utf-8?B?VHZkVzllL1N4a3pFdzlDSTBPOHZGWk12TGZJamtwOERnRTV3NnBnNktpdEhS?=
 =?utf-8?B?MDcxOS9NTlIvWUxZQjFZQS9YdWNhU3BsMTRnWlRicWJUWjVxSHc1UVBrdGdj?=
 =?utf-8?B?eExlNlBwUWRDdFdzSmJpSCtUVU5qTGZyaXFwZ29GeDZrMitOVmVibm9TcTRq?=
 =?utf-8?B?MEd3cHhGcUVMbVZiKzI5RzdkZDR0SFcwdjZNMGxtNEVGZEQ5Z2ZNRmdvQnhQ?=
 =?utf-8?B?U0FBSXYyeXJpQktOTDhxT3BDeHpKdmZ5c0N4QlplSTZUaTM0bnIwanJTWUdX?=
 =?utf-8?B?MmN5enNKTmlBcm1WdndSR1dPcW5SNEhhYVN4YVFwUjAyc0xGcklYSnYySW9x?=
 =?utf-8?B?MVg2WjVBYVhHdTIzQmc2VU5ROEVWdHJGSTdTaUxvdjQxZndOd3M4cW1sOEph?=
 =?utf-8?B?MmF3Z3cxTVdjSkxuYmlVYmRNQzRvS0xDSFVDd3JSZ2tYRzlPUzRkKzNkcVkz?=
 =?utf-8?B?dUVhSU93MXlkb3hyblEybG9EM251UlZ1czkyTnQ2ZDQ1TlBxOUVhR3ZudDU2?=
 =?utf-8?B?TDZNa3NybFpCellidy9TODlVQ1dhM1B2L1V6R0ZOOE5FbGNLbzJkVlNXakEy?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <475901E3AA41BA43A0A5269A2461CC6E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I5TpoufnnQgmBRXqtaFI9BnRt06Vdwo0MAt7jY8FOKhYpRs1xM39yRuucdSfuCvYaPBSgdJzvGdErbT9PZ1dTTZLrm1txcNRUm2YSMhe4QsHWWl04uc6Ulu5JQaQUX6hQp5l2DlmgbwY/+ZK8Ck8YGFjOoTIS0O45ouDCu0irBJnriwWYuUZWmbW8lKwrCDV4nqx7+Yfl7y65Dt3ZuA6WAH2RSZpO7b2jj3w0Akqpnngp0OHmzTxhOvDoLLJDAokY4zJdr9x6wZRxkUEIN6WPW4WUE92iLNznSaJs5PRIAjpkooLv7PI8Vz1i3h09va3OJQziFzLuTNFoY6AwFT8DYVBXi855QP6v4hRik9soLkweOBuOFPT9X5fhVwMEtCGgNN7TgQuCntG4u448hYVDbyBB49IDfCTKT8JF6YR1dGOxc3MwS875+kAryzd+f6Y/aThi2YoJonEDZrjl02iNorrB+6Gcis15E43iYxMH/QnERHwCg9Mw0czv3vR8PKctwz/Yjb3UBy+YTSgaDXfC6FF5vzonvTTXIHO9/xpWbZ8jmhJ63EyThEx4wmGWhLKy4pC54Lip/6M+Yzwk7d3kxOVU5NlbO9ElFyes12KTsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e66295-0d52-4af5-434a-08dd51df4724
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 18:49:16.9379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGF9N21mQPSTeH2AEEv21KOZk6TI/+UvThLRtSfK2ANoeWBb10ecVgx7mJKBxJmcj/5JpSuKuxFfBt0pI+BnGhvGdFxeahi9P4KG0IDhsJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502200129
X-Proofpoint-ORIG-GUID: CVkFvZybIFDA-FCqRj1XyTOfNiqz03au
X-Proofpoint-GUID: CVkFvZybIFDA-FCqRj1XyTOfNiqz03au

T24gVGh1LCAyMDI1LTAyLTIwIGF0IDExOjA3IC0wNzAwLCBBbGxpc29uIEhlbmRlcnNvbiB3cm90
ZToNCj4gT24gV2VkLCAyMDI1LTAyLTE5IGF0IDIzOjQ3ICswMTAwLCBUaG9yc3RlbiBCbHVtIHdy
b3RlOg0KPiA+IHN0cm5jcHkoKSBpcyBkZXByZWNhdGVkIGZvciBOVUwtdGVybWluYXRlZCBkZXN0
aW5hdGlvbiBidWZmZXJzLiBVc2UNCj4gPiBzdHJzY3B5X3BhZCgpIGluc3RlYWQgYW5kIHJlbW92
ZSB0aGUgbWFudWFsIE5VTC10ZXJtaW5hdGlvbi4NCj4gPiANCj4gPiBDb21waWxlLXRlc3RlZCBv
bmx5Lg0KDQpJIHdlbnQgYWhlYWQgYW5kIHRlc3RlZCB0aGlzIGZvciB5b3UsIGFuZCBpdCBsb29r
cyBmaW5lLiAgU28sIHlvdSBjYW4gZ28gYWhlYWQgYW5kIHJlbW92ZSB0aGUgIkNvbXBpbGVkLXRl
c3RlZCBvbmx5IiBhbmQNCmFkZDoNClRlc3RlZC1ieTogQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlz
b24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQoNClRoYW5rIHlvdSENCkFsbGlzb24NCj4gPiANCj4g
PiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL0tT
UFAvbGludXgvaXNzdWVzLzkwX187ISFBQ1dWNU45TTJSVjk5aFEhTXBxTUFtajZJSXl1N1ZqNGRk
ZkVHSmxKWTRyVnJKTF9nOGV0T1FzSEM3cGRqWk83N1A3YU9xSmU4X0pURndCelo2dGNpVURyYmIy
Q2pYV0pNamRFTUpHdHBvZUJmSFU4cXckIA0KPiA+IENjOiBsaW51eC1oYXJkZW5pbmdAdmdlci5r
ZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTogVGhvcnN0ZW4gQmx1bSA8dGhvcnN0ZW4uYmx1
bUBsaW51eC5kZXY+DQo+ID4gLS0tDQo+ID4gIG5ldC9yZHMvc3RhdHMuYyB8IDMgKy0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy9zdGF0cy5jIGIvbmV0L3Jkcy9zdGF0cy5jDQo+ID4gaW5k
ZXggOWU4N2RhNDNjMDA0Li5jYjJlM2QyY2RmNzMgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3Jkcy9z
dGF0cy5jDQo+ID4gKysrIGIvbmV0L3Jkcy9zdGF0cy5jDQo+ID4gQEAgLTg5LDggKzg5LDcgQEAg
dm9pZCByZHNfc3RhdHNfaW5mb19jb3B5KHN0cnVjdCByZHNfaW5mb19pdGVyYXRvciAqaXRlciwN
Cj4gPiAgDQo+ID4gIAlmb3IgKGkgPSAwOyBpIDwgbnI7IGkrKykgew0KPiA+ICAJCUJVR19PTihz
dHJsZW4obmFtZXNbaV0pID49IHNpemVvZihjdHIubmFtZSkpOw0KPiA+IC0JCXN0cm5jcHkoY3Ry
Lm5hbWUsIG5hbWVzW2ldLCBzaXplb2YoY3RyLm5hbWUpIC0gMSk7DQo+ID4gLQkJY3RyLm5hbWVb
c2l6ZW9mKGN0ci5uYW1lKSAtIDFdID0gJ1wwJzsNCj4gPiArCQlzdHJzY3B5X3BhZChjdHIubmFt
ZSwgbmFtZXNbaV0pOw0KPiA+ICAJCWN0ci52YWx1ZSA9IHZhbHVlc1tpXTsNCj4gPiAgDQo+IExv
b2tzIG9rIHRvIG1lLiAgVGhhbmtzIFRob3JzdGVuIQ0KPiBSZXZpZXdlZC1ieTogQWxsaXNvbiBI
ZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQo+IA0KPiA+ICAJCXJkc19p
bmZvX2NvcHkoaXRlciwgJmN0ciwgc2l6ZW9mKGN0cikpOw0KPiANCg0K

