Return-Path: <linux-rdma+bounces-11545-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD80AE4604
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 16:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E1316BEEC
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 14:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B58143748;
	Mon, 23 Jun 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sV/9hJt+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BgBB7Lyo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9E76410;
	Mon, 23 Jun 2025 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687443; cv=fail; b=gqd8hxgGrQG2zzLwEMknzX2L28hJdgZaBagwRmACxrcG9y76A5Hb4baCxBOjEF7Hpq1QF6BwTDPtdAR0KJl6YNf7q08BhcQ7O/hsfcjZ2MvvumOnzmSMwLaCCoIgeOmRK1VbJ4B5rttR0mnF64io7kmwpNjmQkwntEQZYlcZNM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687443; c=relaxed/simple;
	bh=/EP/uDnYR4AvG0tCQ1Efhk6vZLFR2+a/dUXsoqRpYXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NUykEBbd6/BURzqDVW6fJbeElQB3/5M6Wwwx/8XSjgdy3o1ZmcaRDuA7UvA9wj8ofuY7BlaeeftYdSRl7o/7cx7wxl84s1HDGdaJFp3wZgcGSLuBIifxd5J8dW3XJOuKO7sMcGR0i1mnPDB+i6i38IoBAv8poVnvF0eFgAodvLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sV/9hJt+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BgBB7Lyo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCicmh015679;
	Mon, 23 Jun 2025 14:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nr50k1z28RZ7HcMvVh8KG9ApCtYdWicThehU3NVCfsw=; b=
	sV/9hJt+FoHPDRbqYjvfPI/e2G/+Os1PrBRH2z0VRbkBi+sZlstRwj/WiEDSh9iG
	spkCSgZdkJVPzlGrap66kI4ea9GMUuwGPUm+ybecfQc5F2roYVt4BuO7M4/bHGu9
	HQ0Wi2gjdsQfBRUS8oVBl3jpByOE2v2j3Kx1Sc8pXb7oH63/ftDtwUAlY1ruU9vv
	/BAL882jUjqh56ltHEM6KYM3SzU+CXvz89kSq34GWVz0xKQA6YGn3eL2JcMtYMrZ
	2dOPVFo7KZowzYEsk7m+KcCsenLrFxEM3+MW+BjiDAKjeVFnnGOlIKpU0s+W663r
	PO4pvy1z0yX2Ms4vvSr66Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8y2shv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 14:03:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NDQJwo026079;
	Mon, 23 Jun 2025 14:03:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvuvgr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 14:03:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge5HCZzb2UUWxJAEj5Q+qzjA2zLx5wJfPCEvJKW9rXx0C21h9MhUtbrnVvDp5pPFlDlTlWDJ6zUsFFFd9yTVy8WiTXLq9ygxSg6jariDZTwjGxEQ+QdjnBZdkI63F9rajCcGzX/5js9L51vN79+kQMh0MftNpkKzT86al1piuT5ITApoEsIzx1tPU9Um1J0xfoMBZ4e4mzrSN12+4onkSlPaZPRzJUG1r/fJQWlisMD9lpCXTxDrvQ19QhngWScsp7yWS7nvh32lbE/Yr//o0H2sDqNgtjDXKYJloJuOGlM4ud1malYg5RdQcTY1hC8zMUGW+ddht62S5J1BOdMGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nr50k1z28RZ7HcMvVh8KG9ApCtYdWicThehU3NVCfsw=;
 b=mejpooyCg85/axB/cP1j4NV5qSIOXGCTYnUpsg0XDDPAChXTLGwbQi8IuFuh2ZllHE7hHk0iuWLMKnRcgK7RUQUj51ub2BMDpVc7aiRL0IQKoAFtb+YG85CyAZxrUXOvwxHkvUKYKukNv7Vfkh1IiGCSHIEYqRWbxeRNA5hbcRsuGFckxYySdJH3u+Ur+H/7vuIEVtyk+XfMb3oUekQ/Gkzvq3Iv4wGgrKfvWBcQW+uEBHbQowcF7PboX7970GsW9n4qdN8C2+GetCxX7SYLqGxzDGZJ0KH1idHOPBLJI5+pHv7RBH5C+iO1yRNeAK9O/hDkL2NWeHI3ZzG5vNnMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nr50k1z28RZ7HcMvVh8KG9ApCtYdWicThehU3NVCfsw=;
 b=BgBB7Lyo3kBmQ6FNwsKz3cJoET8oQtRtm1Fnn5VDJJ3rSeB8aYPNGs634ECbtmhFN2yz8rBA+d+Vgj8msl/NEFBceGJnpzNZbxYrNRQi6N6Ol+2ac2iS2jfn1RI3UL0ZSt4xdUFZ5T2pfA0P7RDYzLDiEEe/X8j4BKgGPcb35R8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6828.namprd10.prod.outlook.com (2603:10b6:930:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 14:03:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8857.022; Mon, 23 Jun 2025
 14:03:31 +0000
Message-ID: <63895c91-47d3-400b-a32a-093342b95cca@oracle.com>
Date: Mon, 23 Jun 2025 15:03:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scsi: enforce unlimited max_segment_size when
 virt_boundary_mask is set
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Laurence Oberman <loberman@redhat.com>, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20250623080326.48714-1-hch@lst.de>
 <20250623080326.48714-3-hch@lst.de>
 <447ba437-9742-4686-b159-bc2086c9b814@oracle.com>
 <20250623133542.GA27271@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250623133542.GA27271@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0681.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c446df-5f20-477d-ed37-08ddb25ebc20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVQrSkJibmRzbEIyZmpmOXVkS2F3SCs5MjhDUDZaS2QwMVBTbjQ5NjRSTWts?=
 =?utf-8?B?RlhIWmhZM1JzZWRETkZ0QURLY0liYXJhREM4WEtYUTRGWXZVbzRLUm1yZUpB?=
 =?utf-8?B?V1dkQ2luL3plV0ZoVU1BUjRFbVYzVkFsaEFPWnBCaUpGNjVkSnc0T09HK0pw?=
 =?utf-8?B?NlFqTUVCYWNNVmJDa25QU3Y5L2RNcFpYL2R3cC9seExpR3ozbi9lRXQ5MTFI?=
 =?utf-8?B?dGd4RTNFalRlbGFJWWRyeis2THZKUC94cGxlTUhGV0U1bi9veHdIOHNTUXZL?=
 =?utf-8?B?cnFMMG1selpRR29qbHV0OWRONjZMeGg1ZGZaakJFTE82bGFRb3JqbDByMHY3?=
 =?utf-8?B?SFFnUTRLcmlubktuaEprT0JyMjZsZHR0eG9IWFVBK1Njek9NWDFBNXlJblBN?=
 =?utf-8?B?TzdwSEdPU1hCQkZ1YllIUjNrR3VpYzJzaitnVXBNM25YeGQ2MmhKUFFjMWth?=
 =?utf-8?B?Ylgyak9ncW83TmkwOTBDTVREUWNOVVV2WUxDTURKc2FkOEpqMHVING1objZF?=
 =?utf-8?B?ZFBTN2dYVzNaWkNUaDJWd0R4N0FmRFZZQjZtd2x2MGNJbG91MXZlR2NRa3hU?=
 =?utf-8?B?R1pBalJ0UjlWaWwzMktMcmt6WGxIK3ZZWTRFUUtsNS90ZWhadExkUFVmNEZi?=
 =?utf-8?B?RUNWRHZvdnEzcTUxT3kwdXRlSVc0eTRqWmJLaEJETlo0Wm5VWDdNRFZJSncx?=
 =?utf-8?B?RXZzNURxVUxIZTFaSGNBQk1Ia1lKa1U0ZmJlbzY1dzI0a1hsZlQ2cXJCQ01J?=
 =?utf-8?B?WjJTZlFVOVdSaVgrZ09LUDR2TmNtRGVNNWVrRUhYTGN2Q0U2bzcrb1pDdEw3?=
 =?utf-8?B?Q3FHbGVZelY5YzBPMGpaWkZ6ZVhJSFc1Q29RUjM5WEVKZkVEbHhLN2h6QXdM?=
 =?utf-8?B?YUVQbWdiSUFHOG1uNEZ1OG9uV2xYbG50ZmFhQUltK2pMRnJBWXk0RVMyYVFr?=
 =?utf-8?B?cS9nNlErTEtiQnByb0pTNDVuMitzOFMxSnVNR0dsUktic1lIMTRJbGw5VS85?=
 =?utf-8?B?SVhqVUd2RkdZNUVwYXdmeUpQQkhZdHhTRWFyZExTMmJnOGVjTTBySjVhNW4x?=
 =?utf-8?B?cE1CcHp2NkdBM2FTSGZDMjlBZGVRVjcrbUFhMFQxMWVWVUxwOGErZGhwZ21u?=
 =?utf-8?B?aGZhU0s1bS9yWjFrbGI3czdyblR3UEx6dzBuT2JXZjI5RTQ3SVlPcm5PNE1M?=
 =?utf-8?B?MEtnTnRNZXZnSGhmM2lmd0VCMHZ6emxRSTlweFFvMVF2aXh2SEs3amtEdmd2?=
 =?utf-8?B?UlptWXZ2Yy9taGVPamE4RVAzNExRZ3BJTnVIcjk4ZThoRFNIdjFRcWUrNEUy?=
 =?utf-8?B?NU1MeDlPSTd4UnF3c2p2eTM5WjVBeHFZSXRGSkp1RVhQUDB2SG1MZFFiaHh0?=
 =?utf-8?B?TTdRVGg2UExTWnVRdVJnZnRudHdnM3ZqdnluenBFZWpkTStyRHduanpuQ2tT?=
 =?utf-8?B?VklxaEE1MTlNallNcG12ZlkrRWJtaCsxV3BKQXBMaEN2bnBNN0pjaFpENkNs?=
 =?utf-8?B?anpJU2pFRzRJQTNtU0hxeGt3QWhBR1UzZmR0VytMcHY5K3FML0tpWWcrYmd2?=
 =?utf-8?B?RGF5Vnl5bHBCVktESnNmd053dUtQVWk3WHdkWEZSalVHUE9BaFpaUUdjbkFa?=
 =?utf-8?B?amM3N1pGdnJWbnZTQW1NOE1NWHQvRTVGV3NUR2Z2KzFqMmR3SERUU3NyMmd3?=
 =?utf-8?B?Uy9VMzV1SmtnMStYbkgycVZMK1hXQnAyaU5yZ2puVHpyMkZQME54ZXJPaFBL?=
 =?utf-8?B?YW0ra3lxNFJ4dVdHZUpiYkpuL0N0Rm9YZU0wdGxQRENNbXQ5QUJNTjJvQStj?=
 =?utf-8?B?Kyt1cFdjaGFid1l2eTh5Qm0ycUxKRno2ZjNUclZVaVdaWjVXZCtmaCtsbmRE?=
 =?utf-8?B?QnBkUG5HcTdBTXh6NE1OSEM1Q1lXa3hCeHZLdkNiK1o1Vnc1MHMybGx3eTd2?=
 =?utf-8?Q?wdCk6duS74g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R042Q1JxNDVZeWYyN1pvSlcrek5tNXRycHNTK3FWVWoxZDloYUJYbEpnWjZh?=
 =?utf-8?B?VlVlSEJ6Q0p6UnY3VG5nOXBmOWkzZTh5aTJtRGpqbW96d0NzUVdJZVQzR2wv?=
 =?utf-8?B?a1NuYWZzcitkVUdPSnlJbWVYSFJRZytFNHRWTENDWTQ3NmZoTTZObWJ5OWFz?=
 =?utf-8?B?b1FGT1Vxd3FqbkF4L09WTTlOQ0s5Y1VSZi91VDAySE1QTyt6Y1IwV1JXdTNn?=
 =?utf-8?B?OHlaQnhNblA5cHpackJvVVFvbmNGUitHcUN0alk0UDg3RlJ4VE1lQldqY282?=
 =?utf-8?B?VFJxOXppS0ZZU2t5TEtCcktHVTJRbDliYnVtRWJiR3Bpb1dGZ3h4Rk8xV3Vh?=
 =?utf-8?B?aGhoWUw2L0E0cERWeXBZbjdEQ2FIa2pNYzNSZWt3VSt6eEUyV2tkampHVnFr?=
 =?utf-8?B?RW1aQ1NJM0RhbSt3bWt2eUtwd25SV3FkaHpFRWIwZldPVGlJNHA4UzNiSjI2?=
 =?utf-8?B?VlRTdTdyaE0xSlpOWXQwOGNhU216citWb0JDQlRPY3diOVlXK2tPY1IwS3NU?=
 =?utf-8?B?VTNNenlZOWIwRnYzbmQ1WFZ5TVdUYWdVNnNoQldwOUJUYVhGMVlXMmtkRFVH?=
 =?utf-8?B?ZEkwSTdRdk04UWxSYThVK05wVTNZQUp3dVdENGVsSHY5cFZMZ2R3TmtIUUV4?=
 =?utf-8?B?N0grR3JJMHZnUVVnZlpWci9JYnNWTGE0TWJwZ3IydG9DelZFQVJXcmozT2hY?=
 =?utf-8?B?YXQ2cXFMZmlvWVNGMFBJMU9FcHhKME5WTTk5RDVQbDVzUWVsR0h0dEliaGJ1?=
 =?utf-8?B?M3hBMUdmdEN0RHFLaHgwY1NnY09lSy96V1VkcmJibTVUTDE0cm1vR0g5bFpn?=
 =?utf-8?B?RnFYK2ZlOUJZN2lXbUU0Q3k1emJwTVJiYmhoUENsaWthMGVJelZCK01NMzdx?=
 =?utf-8?B?QnhoWlBNdnVPUVpFK29BVWp2NENnU2JEZWw5VEhDZVZ4ZG1iNnJibDZuS0dO?=
 =?utf-8?B?QklKeTZDL2NGZTRnYVBWMkdvNE5zRGR1YTFMeG5uRm9uL2lCUGJOdHJzcGEx?=
 =?utf-8?B?OEFIOXg5aVZkblFrNmlENzFFMSttM0htUFFMcTY5UUhZaG5lc0hKOEl0N1FO?=
 =?utf-8?B?YjFES0pzTEFWaXR6NjFydGdzWkVyWU1EZ0dhTy9VTGw5TVFjSnJpakVmNTlp?=
 =?utf-8?B?YlcwTXd1VlFJK2c1eGpXNjQvQ2FMenZ0N3Vhd2xIUGpaUG9sQkpZQ1hHUHgz?=
 =?utf-8?B?TGdiZVp2UmR6SmF1UlJSVTdYUVdpdDVaVTh1bjZoVXV4S2JGakswczNxQjds?=
 =?utf-8?B?cmtJWmh0U3JGV2srbC9ta3ZpczI4Q1BORUZMMEhDdXhOb1RHbE9UMnp2RGxz?=
 =?utf-8?B?eWJ0V2xmbEJ3dHVZWDhIcHBRUmhMdEVMcldXdDRkclNYTHhVVzJkaTVCRVRM?=
 =?utf-8?B?cnp5RWNzQXVraG9HblQ1YmNBanJNUVpaUWhsVEI0QmpPNC9IY09wTFQ5VkdY?=
 =?utf-8?B?L2w1dUc2eFN0Z3phQW1vaDRrWDdYZEI5d3c4Q2pIRFMvd0JsZVVhY2tJL2xL?=
 =?utf-8?B?blBoQnFQbjg0Mzc4dUNsSk9lZCticzY1cXkzUXNJWEdCS3J3SmhIcGE3ckN3?=
 =?utf-8?B?SlN4aXZnTmdWRlQwSUhxQjJRQTJ3TVpFTGk1S1lsV1h4eTUyYjMyRHNaT3Jl?=
 =?utf-8?B?TksvclcxbDBsbVZWaUR5MGRiVTViOWZITmRZajBuamhLQ0hRdk9ueVc5SUIx?=
 =?utf-8?B?R0ZlaHh4Q3dhem5UdERrQk1VdEpabnJsVU9GR3BwRjhlVkhDZnN4R1NNVkVZ?=
 =?utf-8?B?TG5INzlwanhBUkFRUE5SM24rMC96RzJwQmlxMVJWSDVjbmE1NU5zTGFWSmJn?=
 =?utf-8?B?cncyWGtIMzMxaURGTFQ5alU3dkNXQTJXWEtOQ0prbkZUeDlEZDkrbkp3Y09D?=
 =?utf-8?B?ZUhGOEpYajQxVWpiUVA0bjdkRHh1YkhUb1NuWE9PT2JJY0d1WjMzOGRxcy9r?=
 =?utf-8?B?bDFLWGF0Zk41UXZjMHhRY2dQdnVZb0ZsRmZ2SjQzYm00Qk5tdzYxVzkyRENx?=
 =?utf-8?B?S2J6SlArN2ozTVJxMFBNa01EalZaRk5KK0FMbFY0QkQrNGFMdmNQQlZlaFE2?=
 =?utf-8?B?ZnZYNkpqbWdxOExKb0RyZlpiMDRpTmRFVGtjVlBWbGkwQlh6SEVTaXBMa1ND?=
 =?utf-8?B?Mnc1MEhaMnpISFN4L0h3aWlyL3VnQ1hlamxQQTd1aHlrUUt2MFNUa2RHaDhT?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gNwlwBz9qxrArzvvnJyGLX4PzwSRHxVJwuAMbxRdqduKFR4S9NI2BaJgWS1wLMhkc+iNOuZOo/xB2gtu0aURHAWNdXaJ+4eiyehi7+mQW7oFw/n+BPtQkgqq4DIgVnXiLMvVAsXUefT4ogCBI3aOZ/baiZgZmeCcowOajbU9U0m3PV9VZonbK+VaDrOivgndAxXvXNtbFb0gG5nC4DVopIQ5k2p299EAPs4jroZMuXKN+pOUpgZ3jKTbtt5cGAX+88KXv4rGqGEIkKR+9jL6simmGjEIY7Fotdmn8pLhfBnMgZ/mTqWBAptKJTQO22mesrXYhco3dEpDat5l2aXOZgoeZ6rIN1q+eSK1soAnqh+OnF+lRr7quI3cIbE1mrzPtzxvTVDOoOl91JFEyg8Zhe/LEExaZ0fsEHQLEtEcWIKP7ovqWVFuP3+sqHNWTglFMY0owO4X3AA/VI34gMpxNEXE6jSQMUsyOqJextqq1lI87xiIk8KokNfBKO0gCv/TAQo/3GMyYNq6x82kqeDZv9gvuI6Zc146OzXGVZfkv6hJvgK1RPgAQu/yCCcFPgvcquu4vx8xHh9GX8wa+D0wDLdkuxj34kg7o15dHMaJpm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c446df-5f20-477d-ed37-08ddb25ebc20
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:03:31.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzYo/EWW3uMEf57exYrhZ9sP8W/VFkrCSAOSv7srZI2H3CemNYfCzz0hHsrXDHlgicwSm5yyNMCxqcgFmOB1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230083
X-Proofpoint-ORIG-GUID: Xyt1IOw8coi5LOh7fq5kPLssAOpgXD0r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MyBTYWx0ZWRfX3ifgCy3aEF+4 2pY8rrFxckoCvRnbCqlVvv9sbLzw6dzInSoTR9Lz/1oeXgLQKNfT1DGzw1QDGCVvsSo7hgWH+Ex 8AifXtGaCxsBJr/B4cjKoxx2Hc2ahB/4lz8hAX+O9p9MmMZp/i4xhCxrjZgGA9f7rZAq7lzbPuT
 gYSUWI//LQMBBYU/7A2oLolTxYMiowm71xGsuIt2ZkfYWCWsKCGmfildGg+JcRBeNA4hDo8eSFt MvxZZFkQ1rUsYOkcVrLj1gXQF0lDokAGuveMr8rX5OcjD7oLJ7CNOUbk0AP05kRA+yHnWHREukZ KTdqMgYXFh3kQYnM92Y3UkGXX2ejovmX3x3atQTfZtviDCsFBgUNZP64Md7hB87IseasAiFd9Rg
 Zw+diGCB/44WNNX3yN8TxV5NboDEO6oIlsDg9ZlygAgpbCv/72Slk0owy0FXyWRQAeWDPx3+
X-Proofpoint-GUID: Xyt1IOw8coi5LOh7fq5kPLssAOpgXD0r
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=68595eb8 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=PIF5vnn56OvaLCbs25oA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714

On 23/06/2025 14:35, Christoph Hellwig wrote:
> On Mon, Jun 23, 2025 at 09:37:10AM +0100, John Garry wrote:
>>> -	else
>>> -		shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
>>> +	if (sht->virt_boundary_mask)
>>> +		shost->virt_boundary_mask = sht->virt_boundary_mask;
>> nit: you could just always set shost->virt_boundary_mask =
>> sht->virt_boundary_mask
> I could, but it would change behavior and break drivers.  The SCSI
> midlayer allows overriding the template provided values in the host
> itself after allocating and before adding it.  For the
> virt_boundary_mask that features is used by iser and srp.

Since shost is zero-init'ed, I did not think that my suggestion for this 
minor simplification in scsi_host_alloc() logically changes anything.


