Return-Path: <linux-rdma+bounces-11533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 644D7AE3899
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 10:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1134F1894BD0
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 08:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A66E22DF8B;
	Mon, 23 Jun 2025 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dAd8JwYp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kE6tSI0b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592D1F4CB3;
	Mon, 23 Jun 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750667863; cv=fail; b=lg6q5SwauUyq9Bfr5zy3LkN+RuJx6tWzNPIA4lTB5KfQzxdIcdu+VUgyhBK7yxZIBlimuzn7PWSSkSPGlVrdmOxLftJkH2T2I1Wxl1Ngw8w5r5Tj4yCUeT5zV/LFy2R/RCy7VRShMZpUWuEuX0QpJTPzcCIli76xDpufCxIK6ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750667863; c=relaxed/simple;
	bh=Hr6KkaDFExYGurxyFmGJVrn0zW8RPOOlBm9oujUJudA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ec18/x6OCk+K+nYVMWJnPyR9n2iboIFXC+QQ5vKRVG8E808F+eagwyh570ddIe7bEGABSpZn1laUL4M5Hifk01nxrR4b2TfzS0VH+Ud3aCq9GFZlTqgN46rDrHIVZQxsvXiJZXL/t15r38jrDZdDs5/KcUQJF7Y+Jx4D22nCUjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dAd8JwYp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kE6tSI0b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N7tjHB003209;
	Mon, 23 Jun 2025 08:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AILeD6NA13JK7DEnSqRJXYjaSvMhsDJ0jvYGi70Sj88=; b=
	dAd8JwYpu2DjHUZcKk0YzDb4p293foM+Ef2WqJXkTUbjAX1zyJFjjOPJrUxB+p/C
	vQ6JGGQC8ydnun9ErNTe6eshUoo8F3ya7whKUaQGzSXxjzh8U8wyX9+T9409beZy
	Xg13UkWpUvfPHCLNHD/PA/be2hFxSH2V+fz8z5LV6zXZ0x0NXXWNww4sgyYGEnhW
	r84PjWeIIaYs599Be1JR8nQDUeUUv1C8gFA5wy50IrMBTQ6niIv9aN5NJTvEUeVY
	2kyXncjHnJz8tlHuDk8eREEqnLAEVqIp+TEWC43U8CxPmwvP+vkwTPm8V6CwSALy
	NvCx0x9UJEJb+k8yZvJZig==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8y276j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 08:37:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N7AsQ6026181;
	Mon, 23 Jun 2025 08:37:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvujmgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 08:37:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFaUH9l4jIAAYjS5k1rNJDtFhpWebnMe1wVAz5bXK5chn5jYXgh3mglgMEeiDD8RP25KDlrPejdW/GKz2tmi1wUruuAeGBOFAybDiorAWkYb2bnftu8RLj690xtqZmWmdp8PJxWuRLJdP9mjLr+zs82EKrlDXUVvZ3pUH/1URGjf0k7FEXGWeUbU9rQhMfhHwFka2E4zhndPEnVdkrSATinxguwbh1Kp49JtF2v/5y3rda2t0m4RKySiD3BYphByhbC+qwTTq/z0wvDh4ePN7Jy8AjFpyAuvA0NNnHu1k99tGzSu+cdgoZ1ji9cRUpSlMLKs5BzrgUKLOKJk+7jXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AILeD6NA13JK7DEnSqRJXYjaSvMhsDJ0jvYGi70Sj88=;
 b=N8UsPoRSgqGl7eGDpsE4Eg3YH1W9GBYsXIaHKAC8XhngACtBdhkRKg+GpcdbA6ZtWHR5BY+3etLONcWJoP1NB9uZajvalOL9tJYxwlIYX78Dama3dThYwCXfS3OLMRUnA+o6yvAfYvYUkCaEAL+kazHcHYJ1wibNtFgo55N1+LVcBdThiqCiB5TYN7h0dFowubcfOgVtLHB8nj6GQCDVOpsNPxXesYWV5MhiZukZutPzMhtpjaHfJ1Eq47g4eaXt6ibbJuueghCBkFojVSz7R28hF7HZNWKoCflryZgrNu6KKTb3ZpEXfpPcLIJRHyImutzDtLtxycwtafY5fmUh5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AILeD6NA13JK7DEnSqRJXYjaSvMhsDJ0jvYGi70Sj88=;
 b=kE6tSI0bGw53sSNQEWdfhpgYCPSNbbSBdjMy52D4Is2iVNty5DW1Mk2eVzmjp3rNYwGy2+/YKWP9mmAlYysgjLOS3VyjwZe7WiB2UX4cQnUfmtOxjXjenbUNXz/+91A7MgyttF1cyWKov2XKDomQOBjwJoGoSXX7tl/t1HGCqvg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6152.namprd10.prod.outlook.com (2603:10b6:8:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 08:37:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8857.022; Mon, 23 Jun 2025
 08:37:14 +0000
Message-ID: <447ba437-9742-4686-b159-bc2086c9b814@oracle.com>
Date: Mon, 23 Jun 2025 09:37:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scsi: enforce unlimited max_segment_size when
 virt_boundary_mask is set
To: Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Laurence Oberman <loberman@redhat.com>, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20250623080326.48714-1-hch@lst.de>
 <20250623080326.48714-3-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250623080326.48714-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0124.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 0794ba62-ff74-478c-c072-08ddb2312786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0p4Z3lDUVZ1NHAyRlIzdVBpQ0dNUlNBbXlsR01qbC8zOE5Say90R3pUb1dC?=
 =?utf-8?B?R00reEVkR0ZaL0dNdVg3dnJHMWhXNWtjb3BiZ0hpS2hrUXlIcHBjZTErbm5U?=
 =?utf-8?B?YTFiaTErUnhuS1FKN2FnRDVrclRFM3lLK3NzTlZwK2s3d24ram9nVkE5eU05?=
 =?utf-8?B?VUo5L2h6V09TeTRYT2hJdVNZNkRmS1lTRDNJZXo1VVNyQklYMWRBdWJXRXgr?=
 =?utf-8?B?YmRoM2VjYnF1VVBBaUtUYzk3REhBUkJyNXBYUEVDU2hkMS9FditHOTdiRWQx?=
 =?utf-8?B?K243MkxmVU82YlVaOHZ4VFI4c1pPdWhPNFJvT2J6bjdvcmcra2pybDJ3a0xi?=
 =?utf-8?B?clNFZUNWZ21mbjM4bFVzaXlBVTI0S2tDQUJYMVFDZVRqcnR4L3NlcklCcW9t?=
 =?utf-8?B?eUpDeGRhWnNTMFlJT2dNRWFOZ3RoN0Y2QkJuODNUdm9sK3BuamRTZzdHMHJn?=
 =?utf-8?B?d0laREZSdll6SlpUUWhNa0ZJV2dnWkhNZzNqRm0zMGlYNmdGSThkT0ZzTTho?=
 =?utf-8?B?WkZOSWNKaG1XK0d5b3pHd3Z3RnVDMXYzbVNPejVmdFhnRnZGT3VoNGhEY1ZN?=
 =?utf-8?B?UmJCWkxFMHU4SndqdmV2TmpqZitRVFQ3WG52TWhGVzhpL1FVcnBHVEFidUJn?=
 =?utf-8?B?MTJZTmpkYk15N25uVHptVSsxbjJxRmh5Y09OZlV6ZXpBZmlZdGhnc1hnVWJR?=
 =?utf-8?B?dUVndWMrR2dpV1pnN2Ewc3JXeEFZYUJWNnhmRjNLelJYc2F3Nm5vV0xPRVJM?=
 =?utf-8?B?WkxqMGdrUFVLVEtydFFoOEwwT3l3UzlTVFlJUkdnaklOOTdpckV0QkU3Z0p0?=
 =?utf-8?B?RnFBMDc3eHh2ZDlPbmdkbVJHQTJsK014R3llUkVhOUpOR1dnM0tSblhaZ0VS?=
 =?utf-8?B?VmpXOEtQRnBOR3AwWm9XN3hmR0Rvam1TN3lpdVZ1TnZ5RlZyU1IzaXl3N1B5?=
 =?utf-8?B?VUNjVGNPNEFJQ0ZpVEk1Q1RtbjhjaXYzQzY0RFFoMFVkNUVjTjlUSVFqYkVi?=
 =?utf-8?B?KzAvaXJ5MnBtQ1kwdEd3c2xIZkVzKzV4NHFXYURuakpRL1N6TmlVcHNxUlZi?=
 =?utf-8?B?WUo0M2tXaE0yRFpzY3c0czRZYjBTdVl3elhyb2xBU1lvWGRsb091ZFlZNDcz?=
 =?utf-8?B?WXFaNENQNEdENStxSTFiMjB5aU02eDk4NU93SDZmQTBpS0k4KzlGZ2ZJRXVl?=
 =?utf-8?B?RFdIc1dRUWpxdTZ0QnJVTVZuclJiOGRPUzJGMDVESUs5VzZXNUZkYjZ1M2FL?=
 =?utf-8?B?MXNsTHRSUFdLWHltdmxQcHhEYWZjUFovRFZsVHkvd0h6ZThoK2ZLZVViQU5M?=
 =?utf-8?B?QW10TW5tbm5IMEtxREZEN2RUMjFCYVhSU2hTdUgzbkdTRTZuM2RYWHhSZ3RB?=
 =?utf-8?B?TVlPVGdBbkorRkhwelBFMk5BcEFnQ2FvSkF5MkRKaVJtVUtHbTFUcENFSnQr?=
 =?utf-8?B?QzdTOW81Q2RZWXNBV3dLWnRSVU5KRVpLOUoreW41WmlwSHVQUTRLUTEyd1Zt?=
 =?utf-8?B?c2s2WWdYTDlnalRhbEZWckVmODFxQXBoOTc5NTRCM3dZOGZ5K0lqS1VXNHJu?=
 =?utf-8?B?ZWdkUTdWNnZBRVNxMTRPdVpjMmpJLzluOVRoTTNKQ0V3b3RXMWlYbVZrZi9q?=
 =?utf-8?B?K09GZzlUaTdQUk9Bc3NLOWgwU1RuMk84OGlldUpqcHBmZnYzS25jM0U4ZFdM?=
 =?utf-8?B?dHZ3YjR4WG9FUlJlSDZZakVDUlhHQUFjOEZheGt6V2d4bEFRdGdwUGlmaW13?=
 =?utf-8?B?c2xic0VBSlYyOVRkZHhhK2k5RCtoY0RQamJwTlMvMXBwQmlNaWMwa091NWlq?=
 =?utf-8?B?NWNVeUF0Y3oweXJyV3hhVVZibXUzWGdZWXZ2c2N0a040RVUxNWNLUWxRTStG?=
 =?utf-8?B?TkRFcjFpcVNPeTE3QVJzWmZ3dnd1bmVGaHZ4SUFOMzB6bW5RblFVa0JyL1Mv?=
 =?utf-8?Q?4GwhU5uISHk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1VMbzBvNmc0c0hUaSs1NENqSWtvRlB1aWozcE9ZTVA1eXdoakxwWUxvUHRi?=
 =?utf-8?B?Wm1xOGFwNHZUS2VpWUZrR3E0VENvSEwva2Uyd000YzdkRURhV1JiRitBSjZO?=
 =?utf-8?B?d3VmQ3hINTNoczRhblpHYkdNSi9BMVlaR3hCYUQ1ZVo1T2Z4NStLZm1wUE5u?=
 =?utf-8?B?a1lZQlM0U0lIZzNQVTlyZzZrTEJRS1U1d3lWc0tyWmJrbFRub2kyaHFZOHVY?=
 =?utf-8?B?azBQUERYelB6OXFNNlRURWc5NmhGQ2ZDVGN1U3lEc2xJSzdTdnd5QTBDdjdp?=
 =?utf-8?B?bjBOcDN2aVZ4ZVJVY3ViUTdCOFdlWlBFd0lzdjN6QUE4UzJwcGdpZ0VhUjNz?=
 =?utf-8?B?RjRmcTZzS2xEdTlwV2dzd1I3MVVwR0U1M0hUVGtmK3lScTd2L0pmQlNoSnFB?=
 =?utf-8?B?bkJ6NUh1MmNxYmJxYmZXNWpaY2FhL2tpTVA0QWdrU0JlSTJNWEt2bEtNVG9n?=
 =?utf-8?B?L0xtcjVQazdzMm5RSnk4RnhQRzR0TVRHN0cybWdRVENZTTF4Zm4rRktsRE4y?=
 =?utf-8?B?WExETEZXdGxrOC81KzN2R2xWUWJCRWx0SjZKVFo1R3VJb3hOOUZ5VEg1M2J4?=
 =?utf-8?B?aU10dGpBd2pqMUR6eFpEcUhuZzlOdHFwS3RDdGtBSWtLb2s2MXIrRVFNZ0ps?=
 =?utf-8?B?cXhrY3lvYUd2K1hlL2dPQytxbzNLUllqSXRHR0IyRWxTcnhUdWlhMm9WOGYx?=
 =?utf-8?B?WGRId0hraGdZVDRZTkdTdG9EcVY1dGJybWFNejVMdGlVK0dhVkNJNzFFajQy?=
 =?utf-8?B?azBoeFpYOVU0M3RDV0VnTEF1MU11LytQYXRIQ0ZnbWNURmVXTWkyK01tcFlv?=
 =?utf-8?B?enBkMW1lM2dOMTVra0lVbG9rMzNaVFFKVU9ZanNLREtKa0FOc2NLSi9Wd1I5?=
 =?utf-8?B?QTNrcUxVM2dYTEl2czdORncwQTZlck5QcXBsdDNKREorNWVHaDYrS2lhRjU2?=
 =?utf-8?B?ak52eDFPREZMWE5QUjV6dkl2MURoZVZTeElhbWxzcWZINEMvb3ZPQmhaSkFH?=
 =?utf-8?B?U0V2ajkxcHJad1lYRGh4cnQyRWxpSk8ySlNqYlpMUUNzYUNlSTE3a1h4UUJY?=
 =?utf-8?B?THpwWkZOa24zVDlMcC9XbFM4UGVsMllER2FrTFgxZHRNRENtT0l4ZmxkUGgv?=
 =?utf-8?B?bmNOSHZUamFxbk8zQU1kbjNtZG9KQ0Qvc2lZeitvT0gwU3BuL25sVWh5WTVK?=
 =?utf-8?B?VVJiODdTRC9NRm9VUVhhR2dJRUlOMllvZ0NjTWJqWnlPQmpYNU1rakkrdTRQ?=
 =?utf-8?B?TnV5V3p6TDRTa1NVWkc0ZFBXSk4ySWkxa3cwRUF2Z3JzQkJXaFBsekg4TUxM?=
 =?utf-8?B?YVRnWUE5cXNoYWVyWkhBRll4QUY2cGlZT0M0MGc2ZXJMUFA1c0Fvc29JZzV1?=
 =?utf-8?B?bU83eVgzT05mOTZNbDZGREhpeUFRTTR6KzdYemNZaUc0RkkyME1CSThHRVB5?=
 =?utf-8?B?U2IwQW52UFlDZUdqa2ZLWFpxM09jdEh5THMraWxNTUUycWVzczV6NzkyZkts?=
 =?utf-8?B?TWxCdC8xNGYrbFp4MHpacHl2VmUrMmZqMDFrb1kzY0s0VEtpQUdUek9zc0lt?=
 =?utf-8?B?WmVERThTRVhhTjdQSThEa0pTbDUxZXZWK2txbFNjdUdtc1hvd1J3OC9uMGQ2?=
 =?utf-8?B?dmh0U245ai9pUG44U1hEeS9hbmZNT0dPK3MrS01yVWtJUWpGUk9yRmFpTnI5?=
 =?utf-8?B?dXE4WWpqUGMybEpZNXNxTFVHSWZQd0VQMWU0djR5dTJzV25kWG4wNy8xeUh4?=
 =?utf-8?B?dWVCeDFYUUFQek1xemExNVYrdWZpS1R3aTE3cUFqWnBzb3pvRGU1RlhsTTI5?=
 =?utf-8?B?UllRMVQ3SUt1MXg3cXoweUFDY3hVZnZURGxsS2llejVKN3BYU3JIZ01ISUJB?=
 =?utf-8?B?Z0VOcTQ0eUkwdFU4QVBRZWl0dzFXN3phVWtETzlZNXEvVWgreExNSU1ZUmpO?=
 =?utf-8?B?aVFOWjZZbjhxU01BUGFhbVNUR3hCaCsxU29OWDdiWUl3QWI1SENSOFl5aW5a?=
 =?utf-8?B?UVcvdVI0WlZNZnNiR3EvTWlrc1FiVVBwRTFkK2VXd0V4VVVXcjhGblN0SGJK?=
 =?utf-8?B?cWVQRzYrNGlPT3ZnVlhKM2tNYmZNU3UyY2JzcG52bEd3VEpQcEdxV2RDcDZF?=
 =?utf-8?Q?80/2z5aChIDe9tln4sTh1vr38?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pTIiaAntJKrnrXgKqIsmQ74/TCzbp+i/T/CSt7wIwBTBsBJv+/+MN2/cunh7zLA6bQ6HNZqzCv8M7WaJnH7PW8JB/ebRR7fb9n33ymi/T5pC+YUu58vEkVsd8qFMyF7YLNtauJbmEmxkUV/BGZi3YVt0FpRLq9c/nQeVoMQqIWExpo5hntHhJiObFTkXv0AP/S4n8eEogVl/ZhfLPfHLF+phRZNPnLePHUKkGWRSxXBd7M/2/EHtLrDLq8qac0GFvd+D2lrqxvJ3CjjC+ALYSz7S8ROaFTe9f5cQcFAzW6xdLZK5DJcVUDmbJimT6zf+ZtWQVGtpinxePHoXr5mB/NSlAhwvTDHK8iNQCrFG6dOS6lGwXQMsPRogtEMHtfvKnBaL1haAr3QxeWwUocYoQAlSqmI/wrlhnNP1SfV+x2QYy7pMsWinjo14bANmJPVe+s4xAYb8iF9Kaz8wJ0U6N+SWIjeNYh9c262E2ElCBjGICNZNcriWwAkjAPJ3QYWIBeulQSLFjWNvwhG9u6aRVgMkK3EfqAmdGwaDwO4uvJmXjQSyFPEtbQ2ZACK2MO7hVrmROBqwGgc9Yk9bHz8NTpbmdQOFbg3LlP5DwtallVQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0794ba62-ff74-478c-c072-08ddb2312786
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 08:37:14.5069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqF4dZQfU+HNV7AZHvoIRU3AqCJVs96KZOUX1BLYSD4IEnsz20/yVi1kMdQCcEliiTT64QJpGp2yOAU4r/HIzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230050
X-Proofpoint-ORIG-GUID: kHSEwYOfbgPOe0mFVNDvVhB5coWzdioC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1MCBTYWx0ZWRfX+mykrtAL23gm qT/1PM+g0ex6Qd7IeC/8w3ltoFG01M2xowIOZIMSWQ1I4YJrPoX78Pgaso/025y0IOgypMvVa9Y Q34f5f6DfYiWu/xQNn0t/Z2umWQXXVZ9Yw9sxO7KkByEdoXvWPER8fu1A20nzKC8CZ32fgkp2g8
 cfXMJmu9mX06f3EU1+filUuPLD6C5IFOI0QITR7sHvSulirZr/mWAjJ8ygFz4wd2XMPmxrbNeQv wU3fCBszKvzvZRSenPDfNFnzlT0Q5Qa448Z7oyCxOv7XhkwAYlHnZMbjZXZEpEssdZEXSsfHEq+ dtsigcxt0JfKwfvwTHvWJNdV0zSRJ1+EGZk/S1iZDbTz7J5TX3/HnoUaVHwXNRSRUFMIGFN+Mza
 DN+XB+hiKNJhI5vlakbLdRLHsM0m9dfzF3taBJeN2zoR8+7Va0mP89ejVInQrNncMDIAJJTH
X-Proofpoint-GUID: kHSEwYOfbgPOe0mFVNDvVhB5coWzdioC
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=6859123e b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=R3EMDY-R3WB0tekgzK4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714

On 23/06/2025 09:02, Christoph Hellwig wrote:
> The virt_boundary_mask limit requires an unlimited max_segment_size for
> bio splitting to not corrupt data.  Historically, the block layer tried
> to validate this, although the check was half-hearted until the addition
> of the atomic queue limits API.  The full blown check than triggered
> issues with stacked devices incorrectly inheriting limits such as the
> virt boundary and got disabled in commit b561ea56a264 ("block: allow
> device to have both virt_boundary_mask and max segment size") instead of
> fixing the issue properly.
> 
> Ensure that the SCSI mid layer doesn't set the default low
> max_segment_size limit for this case, and check for invalid
> max_segment_size values in the host template, similar to the original
> block layer check given that SCSI devices can't be stacked.
> 
> This fixes reported data corruption on storvsc, although as far as I can
> tell storvsc always failed to properly set the max_segment_size limit as
> the SCSI APIs historically applied that when setting up the host, while
> storvsc only set the virt_boundary_mask when configuring the scsi_device.
> 
> Fixes: 81988a0e6b03 ("storvsc: get rid of bounce buffer")
> Fixes: b561ea56a264 ("block: allow device to have both virt_boundary_mask and max segment size")
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Regardless of nitpicking of coding style, FWIW:

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/scsi/hosts.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index e021f1106bea..6ca7be197dfe 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -473,10 +473,19 @@ struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, int priv
>   	else
>   		shost->max_sectors = SCSI_DEFAULT_MAX_SECTORS;
>   
> -	if (sht->max_segment_size)
> -		shost->max_segment_size = sht->max_segment_size;
> -	else
> -		shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> +	if (sht->virt_boundary_mask)
> +		shost->virt_boundary_mask = sht->virt_boundary_mask;

nit: you could just always set shost->virt_boundary_mask = 
sht->virt_boundary_mask

> +
> +	if (shost->virt_boundary_mask) {

Or combine into a single if-else statement.

> +		WARN_ON_ONCE(sht->max_segment_size &&
> +			     sht->max_segment_size != UINT_MAX);
> +		shost->max_segment_size = UINT_MAX;
> +	} else {

else if might be nicer, by maybe not as (I think) {} should be used and 
that is not pretty for single line statements.

> +		if (sht->max_segment_size)
 > +			shost->max_segment_size = sht->max_segment_size;> +		else
> +			shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> +	}
>   
>   	/* 32-byte (dword) is a common minimum for HBAs. */
>   	if (sht->dma_alignment)
> @@ -492,9 +501,6 @@ struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, int priv
>   	else
>   		shost->dma_boundary = 0xffffffff;
>   
> -	if (sht->virt_boundary_mask)
> -		shost->virt_boundary_mask = sht->virt_boundary_mask;
> -
>   	device_initialize(&shost->shost_gendev);
>   	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
>   	shost->shost_gendev.bus = &scsi_bus_type;


