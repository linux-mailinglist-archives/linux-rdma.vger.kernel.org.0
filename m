Return-Path: <linux-rdma+bounces-13275-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC8AB533C4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 15:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA757AFE7B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D3B32F75F;
	Thu, 11 Sep 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pscWxgso";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bq/HRM2P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAEF326D5D;
	Thu, 11 Sep 2025 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597179; cv=fail; b=GDfUPShe6mYbIehxpVgkCkcxyRHXc1ytQLBQrXqaZv14CngX0+wkzXIdH4FLNiQPwW96G5OFX5yk6yfNXVBYOD4lx7HUhrzFuSG8jHPVBN5tbOjaJqwvDaigrn8gWA8ihMrbVlh1/+sbMTazvgeCF1Q2+bpqxQ2UuvmzJRZzJnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597179; c=relaxed/simple;
	bh=g8g3xwLb90d86XJHFaWbHFIArKCdKHkpIAmQBKE3B7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TJdljygeUJ7iZ3784c9w0kQ0YZArRFjKHAnVYLB7quHag+aakOTpDKT5qV7Issc5gSyQ4mfkFH7ZppyXxdXun//GH9DM/yXFFpxf7T3kJleYmSbBepxkI/vPRR6agI7BQq/Jj9p3hvaQqvjQpcJd5Ue54Sa/QdBUvV1J2aDKAK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pscWxgso; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bq/HRM2P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDI28b023625;
	Thu, 11 Sep 2025 13:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=g8g3xwLb90d86XJHFaWbHFIArKCdKHkpIAmQBKE3B7c=; b=
	pscWxgsoHzGAIOAGa4d1DRVxA78fSlZN7yeJIfyx8m+Ok1sDuVFQuQlrpI0Qg2oP
	VVsRwsawIWHxyi19uUd1OPAkFM6MmSn5aBXi/jnAqfBnYZQBl1vMQeqevnOTMiw4
	VkQULCN+sFjN6oVUfpp3ZIx4WPKcwQeI3O8ganPeKfs+Qs1ufqseN65HLNu82PtX
	HeeoAdpxdEZfPXYH9+3OvNZHpGmpcRnaXPVVJMdWhM4IcMCUvOQWMQO/q2Ig3fxj
	G25i4H/qNCaTiJZz6ox3lSJ0WWLFHHQHQV1cp0SMAFYHgmMkLGVJhgtgMqo8ICMJ
	QDcf4dvmYjdgi2IZn5C1nw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shx59x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 13:26:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BCqhkY002823;
	Thu, 11 Sep 2025 13:26:07 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdjyrbh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 13:26:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1QJS2QwbROMtQbUB8bfsPuEXbqVAF262kulWk/VGnHPlzaCeEuFz3Ev0qLMd70+ztSQLNwxuKJZMMSGkAeo7QFJJZeppi0KdutmsV9++6Xw8pcyB6fcSnYwOUzl+jeMGoZLr75R2edB/LY9v7TZCCeakWXZQcLbQcmMPcbCi7oHWxM4D0m0+xOl4vUOA6sRGA17dbg4hlRSWjncXO9FBg+M9+nUiFF2omOqskPQZznd67XgXWeR19btpmmb953hfPfcskbKccIXNsNKI2KHDcwDlu4UpbR7iMn8p6cglYjJIGRbdaWqrHgWXUP6UZ073XHVxFuYnYsZB5LDS6mP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8g3xwLb90d86XJHFaWbHFIArKCdKHkpIAmQBKE3B7c=;
 b=c1C28TX9cSqeLCotlLNNo/oRWXq2uEDl+2mzbhmcEDq2SJDryyQ4VKIOFDlPFiSv7mwCUAVRBd81GrB4DCqmIceh6LxHJmRd/9EwyuDNSQ1kBJDuCNCopAj2W3CH7d5Ah4nvgf389hmBn0DHWNdi5d4aYj9xdoefq+OGTgxqViNWoCvp/io/fl+6/epsy+fNe7ymAEUj2eMlbNrnb/ANGRkZlxMImh4g9vZZLQ0eQxZVWsM3x7wXm0y2qZbGHdHfG72+kU4WAAgMsNlRlFaFVYSQ1rFjshzHbWuSOJaPLeENUJt1sbdtG7E8eYED6F49nIpUaLsLfvgi3GzKUtP4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8g3xwLb90d86XJHFaWbHFIArKCdKHkpIAmQBKE3B7c=;
 b=Bq/HRM2PT/rKx5XWBXvBizVOZnsUS49diunhuPYs592kn5lEK1ApkiM9HeJPZbb5cRWmd3cXVPCv9iX978Bg1c2bpoJSrCnjLIDaQe2D1OqmEVRUmTYguU/j47LIzVndWtVw1+SlAroEDWOYlUdRTCbU5guLxmJDDFK6g0haOy4=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by PH3PPF1F3678C2B.namprd10.prod.outlook.com (2603:10b6:518:1::78e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 13:26:03 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 13:26:03 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>
CC: "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] rds: ib: Increment i_fastreg_wrs before bailing
 out
Thread-Topic: [PATCH net v3] rds: ib: Increment i_fastreg_wrs before bailing
 out
Thread-Index: AQHcIkLG4foeTWmLpEGroRy1hD0WErSMwi2AgAE4f4A=
Date: Thu, 11 Sep 2025 13:26:03 +0000
Message-ID: <1BC1161D-3835-4856-B171-850073C0B6F7@oracle.com>
References: <20250910110501.350238-1-haakon.bugge@oracle.com>
 <89100bace9824884215eb7641e144b8ee8835985.camel@oracle.com>
In-Reply-To: <89100bace9824884215eb7641e144b8ee8835985.camel@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|PH3PPF1F3678C2B:EE_
x-ms-office365-filtering-correlation-id: 315187f4-e8bd-4dea-c231-08ddf136c1a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aE5GajVCVWZDMWNxWEIyR3pveUg2RThhaW5lalJYSWh2akliL2tsUFdwd1JK?=
 =?utf-8?B?QzRLK1NQR2FybVV2akJuS3RHTWh5ei9UVG5JN2xSeUdzV3NKT0FpUmMxWUNC?=
 =?utf-8?B?NmVObHFpRmMwVzUyd3FjWWtCdmIwMXAwV3N2ZzlNcFBmMG9HVzUyTUhsM1Rs?=
 =?utf-8?B?eTZiRGJYZlJIbWxVaDhIRzk5TDRUZSt5V0FUUzhFZmVYNEJ0L1BVak9LbjZq?=
 =?utf-8?B?ZUhjUlFDSjdNL0g4c0FBMlE4ajVsRW9WKyt3ZStRK0U5MU5NdVZvUWVZWFV5?=
 =?utf-8?B?RXE2WGR1QUpKZXdoZVgvTUc1elptT3lVVFRJWVpYNkl2M0hUdmxoMVJWL0ZT?=
 =?utf-8?B?cXEwclVERnorQ2YzYVgrMThiMnBZTDBZLzJxMm5uTjZYN1hoMWt1RFluOGZH?=
 =?utf-8?B?WGllNUttUm9hWDMrZ0RYNXFGTVBJTERvUXROTldEU05lWE85VjNDNlRVR1Ir?=
 =?utf-8?B?RnVzL3hXMmhWdHR4U0swUjA0bnN0VWhXM2xOUUpXWE5zbEh4b240VWd1TFpZ?=
 =?utf-8?B?d01SMU9aTVBvOHhLblpncTRJQi9tWTFvN09odVp6NW04WTNRQTVUMFJWSTFs?=
 =?utf-8?B?OTYvMzVKMncvOWw1UGZ1Rm11QUZaaTV2VWZBNjBlZXJXeVJBNy95MitlZlZ3?=
 =?utf-8?B?SldGOExJWVQ0bXBWdDdhQmVtRW5oY29qSHFQK3J6UTE0bWJpMFdScjd6TVdr?=
 =?utf-8?B?YnJ4d3RQdlozOGhiRXpnUndpTFZmU2cyY1doZkFpYjVkNzNGUVlQWm92bWJJ?=
 =?utf-8?B?c1l5QlVnMS9mYUN2YlJsTUo2YWl0R0tua2IyakhyTENMRXhnSlFqUmttejBF?=
 =?utf-8?B?Q1pXN096NysyNW9ibVc4K2t5eFdrY0x0OU5ldlJTM1gzSGgvK01QQ2Q3YzAw?=
 =?utf-8?B?ZFByL05VVVRIN1FOOXhia3VRRGwxbEIwTDczc2NOTE5rd0QxWm5ycmtNTnVG?=
 =?utf-8?B?ck05MnBuM2NwdlV0REw4cG1hUEFXajRrN3hXT2RzNE9RRkNYOFdwcjNhaGdH?=
 =?utf-8?B?Z0c0aWx4blQrWjRKUFRqU01iakNqaUtja2lNRmNCZFZnSmU0bjVCTGMvdGVs?=
 =?utf-8?B?NUxHQVpweVlRMnNmdDhpbjMwbVR6czVYYzA1UDBMR1JHdDIvQmMxRTBEZXZp?=
 =?utf-8?B?VzN6VTU1QzMxWjVPZzV2MVBXSkJFb2J4MzV1ekdJQ05mN3VzajBGeWl2SWlx?=
 =?utf-8?B?VGVmYmRGaWxraFBmaXU4OW50eFJvY2pnWDNYckFicVZuL0F0Q3c4ckUrbGFC?=
 =?utf-8?B?SzNwOC9wS3dWc3B0cW83N1NXdStYSVluOGVMQU5zcFRRbFI2UUhtZjI5ZlVF?=
 =?utf-8?B?a1JjbG4yQnVIYmhOVzhQM2RwZHhBdXJ6a1ZoaUJDLzdLZktocnlHUGZPUzRJ?=
 =?utf-8?B?Q1FFU0xUSTg4ZzJUUlhScy81OGgvWWw5M0Y3QVRuQXJyb3hMaW4zK3hVNnRR?=
 =?utf-8?B?SEhsa0J2WGdXNUhBSlU2aGhieWFnWVlsUnNWRmwvZEUzZU1Zb0E5K1czT1pT?=
 =?utf-8?B?SGllaUFka2lwU0xlQ2REajVyZmMxQS8zSjZYdDJDMWtLbjZqTURoYW1ISzZn?=
 =?utf-8?B?eTVYMEx1VVZDK3E1UHRYUDNKZHplZ3E3TlF5cCtMRDNYRjRPS1JhSUFvTE1S?=
 =?utf-8?B?STZKR1dsdGJHTFp6SDlxcmtIZ3Uzdk95dmZCazBqVWtlcnRpNVg0RWx2ZXRl?=
 =?utf-8?B?YTRuc3g5UWI4ekY5ajJ4NHY5SUlWM3hJNHVkdkVNUXZwQjBVdStjZFZXZkpT?=
 =?utf-8?B?c1NtcFFCOVZMTzM1TmFSdVF0WFp6dXdIR281cFo0UlRRT1Q0RElRaFVBa3lX?=
 =?utf-8?B?c25JYTRhbnIrVHBuTS9xdlVWdU1SOUxSN1ZDSUl0b3BYYUhodWtoeFJmeFNL?=
 =?utf-8?B?d2R0VUQ4cGlkZThJcjZnVXNucXdHQTlNL2pRc1o2U0NkcmxNN016L2orSHZt?=
 =?utf-8?B?c3E0NG9pYXN6QkhHNFl1TDI1ajU2YUNpQ01ZNzgvME9JRWszZ25RRmIzZU41?=
 =?utf-8?Q?sSVz9Pa1B+jNJAkqVc6aD1r1AnWEDQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1VFN3l0UlNTbGMrOFprRjUrdTRKek9lTTBKWGczb2dGb3FsckNuMHBaYzFC?=
 =?utf-8?B?WUZpS0ovNmExWm1TTlhlQlJERGF4MEw0anpGVVJWN1ZiR2dwTWk3Y2wzaDRV?=
 =?utf-8?B?dWlyR1FTeERsWjR3VUdaSE1zTDhjQjhLSGNqMkdESk03UHpOdzlHVGtYRWRl?=
 =?utf-8?B?dUFuMGdHSitRcnhkbmxrME5XNnZkajY5UndBc3pNSzZyVDZpOHNiZTdIbTk0?=
 =?utf-8?B?VjBYTlh3QTVmM2RmTTMwY0FkeFZ6OU5iTFhtdVdsM3hFQkpTTUZHc1pRdkY4?=
 =?utf-8?B?b1ZmVlUyZDRGRzIwRlpBUnZXZmEraXNXWGpSUUplZTdFUnc2SEhYWW9RYkNG?=
 =?utf-8?B?b0QwNTFNWXczOXZmNnNYY0NWNUFWVTlwM2JVNDhOZFRaZDlQOW8xSk9SVUdB?=
 =?utf-8?B?UEFRY2p1RzhtUGNwWVN2bU0zb3J1TTA4Sm9KS3hxd0d3a1JrYklDRkExd2ky?=
 =?utf-8?B?NjBGNS9zSkNUNWRwM004VCtIdkQvSUY2Q1B1RDdzVDV4dXdYV3hNaTBSbHpq?=
 =?utf-8?B?eHhhc2NBN0R4Um14dU5VSmdwbk1sa3ZZUmE0Uk4rcDVhS2F3cDBxQ3JZSVFJ?=
 =?utf-8?B?NDdydkFFd2djRHUwelJuOWNETnltTEx1TzcrN2d1d25zY3dRK0RCUm9SdFN0?=
 =?utf-8?B?enJUWllTVmpDdThmcTFrTWFMa3drNE81VDhKT3FJd2t6b2JWaTJFQjhXdnU1?=
 =?utf-8?B?bklRTmw5V2VQV0RqK29nNE9hUlBTSGZwU2lGbnBVNElBWWtRVTJxVnM2YTl3?=
 =?utf-8?B?MFRBdllaRk8vdTA5cjZ0aGFXa2lnUkZDOHJySk8xZWxISXkwaWEvVXUxbnB1?=
 =?utf-8?B?MDRwRzdvMm0wWVR3M01tb0I4eDMyZktxUmI0cW90ZmdHTFY1a3o1djFBMm5W?=
 =?utf-8?B?b3gwd2lwVkJPZktSZFRDSFdDYnNZNmY0cy9VdjNGWlNtd0ZKR1ZJWjU3Zm16?=
 =?utf-8?B?S0Q0eThsOUVZdFJVVGpsazV1VmQrV2tUUkJSd3VYTTFVSHBKVFMwb3RmNkRZ?=
 =?utf-8?B?ODhRdFVkREhkejVhNUh6NTNFM1dCOEJwRHlNV0hSNXlObnVHVEliNGZLRDBN?=
 =?utf-8?B?dS9Hc083UEJYT2l2bkNTWTBCWkJYUXlBQmU5K09sNnBaZTR6cis0NlhCeDBM?=
 =?utf-8?B?OFhZVG8xbE41T1BBeXhidXFGSzBQNEgrb2hUR0pXMm80Z2xuNDcxQTVjSi9m?=
 =?utf-8?B?UGVzNDNZRkVwdmVvOEtXOUJSQmJ4SGNCVWVLNDZmaHFsM3duYWpmY2xFK08x?=
 =?utf-8?B?ZDhtelNwV2Rkdkkra2pMMjBVdFE5WHhxZU1IT1BIUkVrbVZjUE12bWE5NDBt?=
 =?utf-8?B?NzJMZ2MvaFh2YXNWYjhUUGdqYTVmQlFGd2FhUVVLZlZpSmhzSG84VzRKVE1L?=
 =?utf-8?B?TytyYVdnc3hMTjU4SktRQ2s5Q1o1dDNSa0dwMURnalljR1gvMEowN1VwelRo?=
 =?utf-8?B?SlhqSlNzU2k4aGhkM2tyWXhCamp5eHBQVzN6NEJ6eVh1VE9kdHp4dUVhbmZO?=
 =?utf-8?B?b2lJSWYzU0FqbFlVQnc2dWwxc2JkWVJ3d0ZIaUQrZnJ4RnVRUjFFdGd3R1Rp?=
 =?utf-8?B?MkRGT01QQi9DTklsN1ZKWVFLUG1XNEhjRjYyRGpUVk1yeUdEaUozK0lEai9K?=
 =?utf-8?B?UTFkODhGd3ZZUHlQdWZjM3ozYkcxNit3WHgvZ2dmUkhZazF4emhJTnlLdDBt?=
 =?utf-8?B?QUlkSENINlZrd1ZONExHaXVwUkpvci9FKzB1Ymd3cUZxME8wbFlyeTZPbkI5?=
 =?utf-8?B?clV2QThENEU3bUZxbWMrcGw1RDd0OWIyazdyYUJVTEJ1M2F2L3FtREtZZG9a?=
 =?utf-8?B?ZGNlS3JBbjJpTnp6c2JVWUFEN1IvRjMwblNkdW5GSnhOWWpVTnZGMXBwbVJV?=
 =?utf-8?B?Q2hOZnBkaVlnRDhrV3BURjBTZ09FUk1nZ2dIMXZFTnhnOEFnRDdZdEl1MVZz?=
 =?utf-8?B?WjJiU3N4TlJYZlkybkZzSk1ZYXJsR1Awclg4V2pzOEVjc05IRmJ3VW40anVN?=
 =?utf-8?B?bWhtUjJQTUtrZ0lETHhFTElWeXVnd0h5UmptcVlDQjBTN2dPZytnMVhQbnFE?=
 =?utf-8?B?YXQ2Q0lvWmg4N2pMSFk3ZnNrZnpaRjFLTVozZnRMZmdpenAxTmRKWmljcmJk?=
 =?utf-8?B?QW8vOWZ5Qk8zMlpFRXpqc0RJeGdkVGthVHRKK2tnYnA5elNacGJ2dldiVG9S?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F06A5BA99761D41A531A4334A141B61@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lOHuTizfEdVPFDBRCF2/vs7nESP7E6yiER9GeEs2abwwFSFA3PZkOn6EZI46yhhiq6+JB+S7q7Q1YrXp6vkdy1miEzSzetcWElwCfwLwcIsTCghqwchWYrE532i0e2+vBHwJZj9oYeB1qvi1ebHgAJkMSzk+wm5/+N2ru3f4ZLMI961XKV9VWQYJ/2m1hyKj+TafH2h47WZwk+TC3HYdFQNrkxPkOSk3uBdAa1S3TPmq+WMzHBpkQ2g3+n14b55bi0rzM5CMJ+sZUZ7MYjX6LWjDWqSMUvZe57zfoAsW021CdTtxON02rkcsBPXNCN8mIStk9nZ+PPVwBGXCJchpQiGxmpVyAmEdBFQLCa9TicStfe63zrE/sJCXobF1DAViHLjE+fXxE6Fbe/JyToCsWpOs6gwr/6EBfsn5QIXcwtUWc/5bGjwEJk2npATWDoA42zg1j7to1n4aUIyu4WBNW9TGhrmT4rHO/i1cE09BG45xYKeEHdWh/KQ31lBiL5dn8aoTifybq1mp4hgh/P0lhza9vJ7fllGGH8HW+LdafW8axKxnoVFkAtHVKhP76P/DZnS4yHral8unKA3vy6hKp3IAwbvAuj2uEEBQcsIoiL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315187f4-e8bd-4dea-c231-08ddf136c1a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 13:26:03.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rx68nnRbETD2fyj6wdEnvFj21ZlLKHzU67+Ufi9pLq3ugCdxnak3NgVreNUNaUWQ9MWJpG0qg9yO/r48O4V2ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1F3678C2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110120
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c2cdf0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=LqPkzjTwwpd3qrDgYTIA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX1cZzW8QBKMLX
 6m4kem5nb+/TBNP+qTEJLqnVsbFd/ob0dIhxELO7P83Dap9xk4x8wnxXrhO/0b9NH/sEPdxEJV0
 gbcepKUxGdzVdqG4llBCo5p64EZ5wOFykCqD/l1O9Hi29x3gLuwgfyPi/Yu7KXYjq5fpkk+wxPq
 BR+PFhoJBH5YDrZAyJzuHHv90MjHFQLOBzeJQYNw2wLQGg15EsCCQtqSxG2NvBF4IEyALYc4eEn
 KySu0vO9TYwtTBAca0hIdUCb8eeC1ZhjM0AgGjJHCBF7gZlfYgVQA5xC0OFmBOpC/0vLtXknuOi
 Ft64njF0FvvAUYpTJ6LFb5rhpscMdtJ6TpU/P04S6zx4ZJcaXphSPKo3oBDent9JpAHD+BU29OQ
 IzbIEAaNh2a3m4MqvuOm5K5PbYUTSg==
X-Proofpoint-GUID: zNKLs0g_t__oB7BoZN9DcXxum0PZ_1OH
X-Proofpoint-ORIG-GUID: zNKLs0g_t__oB7BoZN9DcXxum0PZ_1OH

SGkgQWxsaXNvbiwNCg0KDQo+IE9uIDEwIFNlcCAyMDI1LCBhdCAyMDo0NywgQWxsaXNvbiBIZW5k
ZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gT24gV2Vk
LCAyMDI1LTA5LTEwIGF0IDEzOjA0ICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+PiBXZSBu
ZWVkIHRvIGluY3JlbWVudCBpX2Zhc3RyZWdfd3JzIGJlZm9yZSB3ZSBiYWlsIG91dCBmcm9tDQo+
PiByZHNfaWJfcG9zdF9yZWdfZnJtcigpLg0KPj4gDQo+PiBXZSBoYXZlIGEgZml4ZWQgYnVkZ2V0
IG9mIGhvdyBtYW55IEZSV1Igb3BlcmF0aW9ucyB0aGF0IGNhbiBiZQ0KPj4gb3V0c3RhbmRpbmcg
dXNpbmcgdGhlIGRlZGljYXRlZCBRUCB1c2VkIGZvciBtZW1vcnkgcmVnaXN0cmF0aW9ucyBhbmQN
Cj4+IGRlLXJlZ2lzdHJhdGlvbnMuIFRoaXMgYnVkZ2V0IGlzIGVuZm9yY2VkIGJ5IHRoZSBhdG9t
aWNfdA0KPj4gaV9mYXN0cmVnX3dycy4gSWYgd2UgYmFpbCBvdXQgZWFybHkgaW4gcmRzX2liX3Bv
c3RfcmVnX2ZybXIoKSwgd2Ugd2lsbA0KPj4gImxlYWsiIHRoZSBwb3NzaWJpbGl0eSBvZiBwb3N0
aW5nIGFuIEZSV1Igb3BlcmF0aW9uLCBhbmQgaWYgdGhhdA0KPj4gYWNjdW11bGF0ZXMsIG5vIEZS
V1Igb3BlcmF0aW9uIGNhbiBiZSBjYXJyaWVkIG91dC4NCj4gSGkgSMOla29uLA0KPiANCj4gVGhp
cyBzb3VuZHMgbXVjaCBjbGVhcmVyLCB0aGFuayB5b3UhDQo+IA0KPj4gDQo+PiBGaXhlczogMTY1
OTE4NWZiNGQwICgiUkRTOiBJQjogU3VwcG9ydCBGYXN0cmVnIE1SIChGUk1SKSBtZW1vcnkgcmVn
aXN0cmF0aW9uIG1vZGUiKQ0KPj4gRml4ZXM6IDNhMjg4NmNjYTcwMyAoIm5ldC9yZHM6IEtlZXAg
dHJhY2sgb2YgYW5kIHdhaXQgZm9yIEZSV1Igc2VnbWVudHMgaW4gdXNlIHVwb24gc2h1dGRvd24i
KQ0KPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IFNpZ25lZC1vZmYtYnk6IEjDpWtv
biBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+PiANCj4+IC0tLQ0KPj4gDQo+PiB2
MiAtPiB2MzoNCj4+ICAgKiBBbWVuZGVkIGNvbW1pdCBtZXNzYWdlDQo+PiAgICogUmVtb3ZlZCBp
bmRlbnRhdGlvbiBvZiB0aGlzIHNlY3Rpb24NCj4+ICAgKiBGaXhpbmcgZXJyb3IgcGF0aCBmcm9t
IGliX3Bvc3Rfc2VuZCgpDQo+PiANCj4+IHYxIC0+IHYyOiBBZGRlZCBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZw0KPj4gLS0tDQo+PiBuZXQvcmRzL2liX2ZybXIuYyB8IDIwICsrKysrKysrKysr
Ky0tLS0tLS0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL25ldC9yZHMvaWJfZnJtci5jIGIvbmV0L3Jkcy9p
Yl9mcm1yLmMNCj4+IGluZGV4IDI4YzFiMDAyMjE3ODAuLjM5NWE5OWI1YTY1Y2EgMTAwNjQ0DQo+
PiAtLS0gYS9uZXQvcmRzL2liX2ZybXIuYw0KPj4gKysrIGIvbmV0L3Jkcy9pYl9mcm1yLmMNCj4+
IEBAIC0xMzMsMTIgKzEzMywxNSBAQCBzdGF0aWMgaW50IHJkc19pYl9wb3N0X3JlZ19mcm1yKHN0
cnVjdCByZHNfaWJfbXIgKmlibXIpDQo+PiANCj4+IHJldCA9IGliX21hcF9tcl9zZ196YnZhKGZy
bXItPm1yLCBpYm1yLT5zZywgaWJtci0+c2dfZG1hX2xlbiwNCj4+ICZvZmYsIFBBR0VfU0laRSk7
DQo+PiAtIGlmICh1bmxpa2VseShyZXQgIT0gaWJtci0+c2dfZG1hX2xlbikpDQo+PiAtIHJldHVy
biByZXQgPCAwID8gcmV0IDogLUVJTlZBTDsNCj4+ICsgaWYgKHVubGlrZWx5KHJldCAhPSBpYm1y
LT5zZ19kbWFfbGVuKSkgew0KPj4gKyByZXQgPSByZXQgPCAwID8gcmV0IDogLUVJTlZBTDsNCj4+
ICsgZ290byBvdXRfaW5jOw0KPj4gKyB9DQo+PiANCj4+IC0gaWYgKGNtcHhjaGcoJmZybXItPmZy
X3N0YXRlLA0KPj4gLSAgICAgRlJNUl9JU19GUkVFLCBGUk1SX0lTX0lOVVNFKSAhPSBGUk1SX0lT
X0ZSRUUpDQo+PiAtIHJldHVybiAtRUJVU1k7DQo+PiArIGlmIChjbXB4Y2hnKCZmcm1yLT5mcl9z
dGF0ZSwgRlJNUl9JU19GUkVFLCBGUk1SX0lTX0lOVVNFKSAhPSBGUk1SX0lTX0ZSRUUpIHsNCj4+
ICsgcmV0ID0gLUVCVVNZOw0KPj4gKyBnb3RvIG91dF9pbmM7DQo+PiArIH0NCj4+IA0KPj4gYXRv
bWljX2luYygmaWJtci0+aWMtPmlfZmFzdHJlZ19pbnVzZV9jb3VudCk7DQo+PiANCj4+IEBAIC0x
NjYsMTEgKzE2OSwxMCBAQCBzdGF0aWMgaW50IHJkc19pYl9wb3N0X3JlZ19mcm1yKHN0cnVjdCBy
ZHNfaWJfbXIgKmlibXIpDQo+PiAvKiBGYWlsdXJlIGhlcmUgY2FuIGJlIGJlY2F1c2Ugb2YgLUVO
T01FTSBhcyB3ZWxsICovDQo+PiByZHNfdHJhbnNpdGlvbl9mcndyX3N0YXRlKGlibXIsIEZSTVJf
SVNfSU5VU0UsIEZSTVJfSVNfU1RBTEUpOw0KPj4gDQo+PiAtIGF0b21pY19pbmMoJmlibXItPmlj
LT5pX2Zhc3RyZWdfd3JzKTsNCj4+IGlmIChwcmludGtfcmF0ZWxpbWl0KCkpDQo+PiBwcl93YXJu
KCJSRFMvSUI6ICVzIHJldHVybmVkIGVycm9yKCVkKVxuIiwNCj4+IF9fZnVuY19fLCByZXQpOw0K
Pj4gLSBnb3RvIG91dDsNCj4gSnVzdCBvbmUgbml0OiAgVGhpcyB3YXMgdGhlIG9ubHkgcGxhY2Ug
dGhlIG91dCBsYWJlbCB3YXMgdXNlZCBpc250IGl0PyAgSWYgc28sIGxldHMgZ28gYWhlYWQgYW5k
IGNsZWFyIGl0IG91dC4gIA0KDQpUaGF0IGlzIGluZGVlZCB0cnVlIQ0KDQo+IA0KPj4gKyBnb3Rv
IG91dF9pbmM7DQo+PiB9DQo+PiANCj4+IC8qIFdhaXQgZm9yIHRoZSByZWdpc3RyYXRpb24gdG8g
Y29tcGxldGUgaW4gb3JkZXIgdG8gcHJldmVudCBhbiBpbnZhbGlkDQo+PiBAQCAtMTc4LDkgKzE4
MCwxMSBAQCBzdGF0aWMgaW50IHJkc19pYl9wb3N0X3JlZ19mcm1yKHN0cnVjdCByZHNfaWJfbXIg
KmlibXIpDQo+PiAgKiBiZWluZyBhY2Nlc3NlZCB3aGlsZSByZWdpc3RyYXRpb24gaXMgc3RpbGwg
cGVuZGluZy4NCj4+ICAqLw0KPj4gd2FpdF9ldmVudChmcm1yLT5mcl9yZWdfZG9uZSwgIWZybXIt
PmZyX3JlZyk7DQo+PiAtDQo+PiBvdXQ6DQo+IFdpdGggdGhhdCBmaXhlZCwgeW91IGNhbiBnbyBh
aGVhZCBhbmQgYWRkIG15IHJ2YjoNCj4gUmV2aWV3ZWQtYnk6IEFsbGlzb24gSGVuZGVyc29uIDxh
bGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPg0KDQpXaWxsIGRvLCB0aGFua3MgZm9yIHRoZSBy
LWIhDQoNCg0KSMOla29uDQoNCj4gDQo+IFRoYW5rIHlvdSENCj4gDQo+PiArIHJldHVybiByZXQ7
DQo+PiANCj4+ICtvdXRfaW5jOg0KPj4gKyBhdG9taWNfaW5jKCZpYm1yLT5pYy0+aV9mYXN0cmVn
X3dycyk7DQo+PiByZXR1cm4gcmV0Ow0KPj4gfQ0KDQoNCg==

