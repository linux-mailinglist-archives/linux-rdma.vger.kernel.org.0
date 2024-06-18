Return-Path: <linux-rdma+bounces-3283-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D66D90DAE6
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 19:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C60B2541F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C61145353;
	Tue, 18 Jun 2024 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kejlq/3o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n1ZLiXVb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1892139DD;
	Tue, 18 Jun 2024 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732697; cv=fail; b=Rt92rT3mCHV4qKZIswtvubGQ8AievDc11xwAwzLjQcNMSMxd8/cUBCWtSF5mcIB6hyjSFQpYyV3/DOARAr5Kp64BUvd7RNrof5eXBmK46XcnCGjq9qbsGPYO7s3RLk1i+OkvytuBJLnAxAkTrJlKTX41k/ni3pXSY5hUucCCagw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732697; c=relaxed/simple;
	bh=Lfi9hg0lJHV/88lwLV3OTLLcLJnRwstMmH0MmzXIZG8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h5zNzgfZTjcxbISdcPeL/XYznjiZABbC5ovHFJAi8G+yerhhDmlRJzzZdGY7C1Ge8tnXnQwK6n12IbglyZr9KeeO9gb80QOJtf6k2Ssq1N7c44bxybLpw68laP3S1C6zzcX6afm0DKSupzpeMPvbECEe8+HdtYyLGmxLf1MJUH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kejlq/3o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n1ZLiXVb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IFrSSc025888;
	Tue, 18 Jun 2024 17:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=cY/414gl0kXBOa62msjFV4gWXxmUbQwZOKCY5PW4S6o=; b=
	kejlq/3ovHoqaW8TGA8MvbwZbvaSX1y1AYN/mhI8kYBphkU1pskM60k9Cm1/bK8U
	AAq+L/DEN7FOhkS5d1rydW3+jQwZViIvVGePYTLXA+eONMts/0KOcMbGILPDvNSl
	ISyorP8zkum62rkU97kVeP6xzYVtYF+EJAIMGxVFEAmn/+ZUu61OQNtSwTfbqZmB
	o5VeaqTx0IieDGt/A4D1QQ2/LssdErq5sDOKt+MJ4VvjMU3YtpcKPDDcrBz+MyM8
	jERQwPu2QFJNtT+F57VMiEf63gXQofMoFs2/SAhF8fTKUa1mhM5oLFvdKnEQ1P/v
	K4H43wmladHK7EhgemQglQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2u8nf2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 17:44:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IHGiYN034523;
	Tue, 18 Jun 2024 17:44:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1der6uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 17:44:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpt5mHjAnJwteI7Zyy60WHKV1OolKfKI2XEE8Q9Rq63OV2XDFC/YXUom5JB56vbTVPesufyQg61TKx3hzhbQ9kFM5LufPDCsCusuq0CESNZ2EUVyxU/K5B38cOeSuBH94zvXc9WzHpFUkehbqPQP6GDId8UjJiovIH1ODzU08o86d7hY5TAvqQRQFOkxG+dCjHKUHmbgmXbzZw8sugP90720h9O9t3/CxgENAoiI/NPZjoCuX6wmOdYyx9BoOi95j3CQpbQ/QY2iZIq+vrX97u4vScTcIhPFduwmlruj9PaYf/RVAJglDoGhct+8XjOGNww15Y5dJr9ymEpiSjeCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cY/414gl0kXBOa62msjFV4gWXxmUbQwZOKCY5PW4S6o=;
 b=LiriMzak1hfrjqFVeTLDBbtzJn/3SxN501OrmSHAMXIQvFgNeNah39TKLY4qEkyno/fmMQyVH4Y8q/3PBnQtyQuoNzy8Mgl5gym0SIokq+GiMt7F1XVYDkMzWaiM/prlDoxnoI65vKcPj3iPjQuyLhqFJM4AuSz4TmxRHa4xoB5ewjlc8VjKwGqQVFNYdmY//pN2hwfs5xrfqmRpvLCEWbcTiWCuJEBNmDj9XcTZ7Jwy59av5BGOjkVu1V/kzDmE/uXqq2dLB4e3U0CK7EN51oZLO3h8sU9wYeE33dfhYtzsswJ1ic5PnbICLUsxUX1FZUDHKE7UEDu/D2qXJp7boA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY/414gl0kXBOa62msjFV4gWXxmUbQwZOKCY5PW4S6o=;
 b=n1ZLiXVbp3kmYYNY4Vm2gfM3Z0q79K7SLamsByE6WmANXjGA8niBfwr952BYoLJEu38M883YHBmVThBkvJAWxloz/3OIMxj4oSTwejEGqQPS4+aS5CzuQKIkKK7v8g3jNieekvffatuusutl6QQ9+MVkGRgK5tFljqQnNIuHUps=
Received: from DM4PR10MB6111.namprd10.prod.outlook.com (2603:10b6:8:bf::9) by
 DS0PR10MB7956.namprd10.prod.outlook.com (2603:10b6:8:1bb::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 17:44:45 +0000
Received: from DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777]) by DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 17:44:45 +0000
Message-ID: <032ba44f-1552-45bc-a68c-c848bf6da784@oracle.com>
Date: Tue, 18 Jun 2024 23:14:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/mlx5 : Reclaim max 50K pages at once
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, saeedm@mellanox.com, davem@davemloft.net
References: <20240614080135.122656-1-anand.a.khoje@oracle.com>
 <20240616154415.GA57288@unreal>
Content-Language: en-US
From: Anand Khoje <anand.a.khoje@oracle.com>
In-Reply-To: <20240616154415.GA57288@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::36) To DM4PR10MB6111.namprd10.prod.outlook.com
 (2603:10b6:8:bf::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6111:EE_|DS0PR10MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 3935b9db-cd1d-4151-cc83-08dc8fbe5739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UFZwZHk2YmpuRVNRNDNoUkIzeGZqNFFIbGl1RzZkVzhtbnZUdDQyM2xXNUFw?=
 =?utf-8?B?aXY1UTNIZE5vcXd2dGsvdWhQYWJRUmNocU5HTFNkSkdwaDhvK2hja0tSdEs2?=
 =?utf-8?B?QWFoakxBWSs4d1phNTN4d09nU1F4d3VLa1VYWVFab3JWQk56RE53QU8ya1BH?=
 =?utf-8?B?Q0M5SG53WnhUejVCZVZOTFpQaDBSQjlkemU2MmlXNWtzbWk5bW01QnJoLzJw?=
 =?utf-8?B?T29OdS8xcDhoRzVuOHRxa3k2by95UGovMDVRcjlVdUFkcVQ4ZHNTczJaU1h2?=
 =?utf-8?B?Yzd6UlEzUjFsejBEQjQrcE81bXYrTFJublVST2NkUzV2aFZSTXBmdUdwMUpi?=
 =?utf-8?B?SVJTbEowZlJGeWxuMFd5NnRhZy9raFRwc09QdjFlMi9wM2FsRXpvUVAydDFS?=
 =?utf-8?B?ZUtnRkFjVHg2RTh3emw1ZE9UYUpxRElMdEFZajZBZzR3eTRmZ0RZQWdneTZF?=
 =?utf-8?B?OFR6UDhvb2dJdTdCajBHUU9oT2JpOGVOVVBoaEJIR3c2QmxJQnVaRHU5d0Qz?=
 =?utf-8?B?V0lQMHd0Rno5OG5JcFFBVkdNeDFsSW9Fc01ZM1VIaExNaUpnTHFYa0RabHFV?=
 =?utf-8?B?TEZ1b2l0bFM2RzY1T0lKSFpBaVpnRWpQak1VdzhTcmE1R1kyVi9odXRkZkVP?=
 =?utf-8?B?ZmRxOHpQQUtEc1Z6NUxKSG9TdGhKNk5nQ3h1OWhoalozOTMwaHF2TlJNU3Bn?=
 =?utf-8?B?RkRwVDBXMGsxSDRsNWdoQkpkOG90YVU1WlNTZDVNMFB4V1FrY1NTQWk0ZldJ?=
 =?utf-8?B?S0JBYVZWRTJPbnBCRkE4aC84QzdCSGFTWFhSQy9KWEx3bkp0TEc4L2xQTU1X?=
 =?utf-8?B?QzY0MnFGWk5tTUROelNVZWF0ZjhReHh4eEdmbTArMnVGUjZkN1dZRXNTVDUw?=
 =?utf-8?B?bTZONDdaZEFoZlVaUTUweGpjdmhuQ2Z4SEFZckdDUXNXSmNiNU5Jdy9JbWR3?=
 =?utf-8?B?Z2xYcXpQZ2J1Ny82a09hNTNwamxmUlZZZVNxV3Q5aFgrY1Y1QWZIaFdRM05D?=
 =?utf-8?B?UGZUdHhrVnRIRGdyVXA3Wm82WVpJdHpvQVVEZTdmMnJFUXR3elBwZWNPOW5L?=
 =?utf-8?B?dmxTbWg4R3ZPTjI2Tyt3aDdNcUVtcEs2SjJTMVd5MHQ1RkZ0eklGQzFRUjZZ?=
 =?utf-8?B?VFJKWnAyQVhNd0drREthdHZ2UGxHMkVzdU96cEx6ZHY2L2xiSXBzaTdZdUxy?=
 =?utf-8?B?enhDWW1TU1E2Mm13TGVLeGgrVTFNSXM0QVJPbGVJNTlPQ0tOZG1yZTVENlpE?=
 =?utf-8?B?QzhiaGJBeUhYQzhUVzRmUzdKRlJ2cUhWUFV3eDVKeUFONm5rNGcwZ2ljTnZ6?=
 =?utf-8?B?d3FtTWFNOUFsMStWdVdwUml0R1RsT0xMcThXVFBuNzNoaEhDMkNlTFEwczNS?=
 =?utf-8?B?TTlqTUg0K2U3RkFlZWt5dUJTaGVnYTI3MjlveEpmbkx4WCsrdjZlL2hXUnNC?=
 =?utf-8?B?QnRrQllPQmh4QVdnTExlQU0ydm5uOE5TZzBBdERtREZ3SXMydHNmTVFiRjlq?=
 =?utf-8?B?a3ZXS2w2MTZJbkd3TUdCOVZzbHNXMXNTR0NuWG9CZ3lJcnR5RUNXSmhIbGFN?=
 =?utf-8?B?MENiL09la3RndzFQc1MzOEtHc1RuR2o4N0Z0ditCTXFJY3cxa2FqS2hSSUNs?=
 =?utf-8?B?YTlVeFA2UUd2QVhqeEJBcHRwVXNnciswRmhUTno4TzJuMkhsZXlvNmxCVC9Z?=
 =?utf-8?B?UmM4WWZMVlh4Nm1ncEF1ZHQ0WDB4RWxsdno0VmZvVFM0V2ZuMW5WOHhTRk1C?=
 =?utf-8?Q?8CItlnTX1XepbKWRFBKMIUvOOrZueqGg5knEMO/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6111.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXdXV0VIY3pZTE56bEVlRFhDWUJGb1dWU1dhZGdmdENYUGVYSW93b1V5V0cz?=
 =?utf-8?B?MjZCWVB1SjI4OEhHbk5NWUh5NUVtRDZ1NDZlUzN6alpweTI4OUYyNzMwdzZQ?=
 =?utf-8?B?THpyZVJSbFpXeXdJQXMra1d2TWpLVE00SGZkOXczOFRFaGlZcGdIdmpHL0tz?=
 =?utf-8?B?d3BqbXJjZlBGQ1JHVzdyQ1F0eXRJakEzYXZNNzhMQ09iOTFpSyszZlEvOTBa?=
 =?utf-8?B?Qmt0R28rc2xwcUhWb1d1TWl2UlA0YXpkdDIxNmVZMnZ5NzU2dnZTYjIrblNn?=
 =?utf-8?B?eGkvdmpDanRQZEJqWVhwSzJIVDIzdGNqNzRBUjd3QWlwV0IzOUZ2Z1lNeHdi?=
 =?utf-8?B?T09Yazk1eVl3Y1hJSWNLaVdqQ24rb251NmVBck5Hd2UxdVpKQ1dFZnZQc0ps?=
 =?utf-8?B?Y0tuYkU4b3BiZ3ArRzQ0UHlJL1BxcEdZNWRORG5SbHpFM3pRSWZabEMzbkVU?=
 =?utf-8?B?WEw2cUpYQ1E0cWZZUTZubEVCUXpnOUdaTHpaSHg4bDVRdTE0Vm1ZZHBTNVhx?=
 =?utf-8?B?U3hVYlcreXdYbTQzaEwyV1BMZ3pZRTVXalZPVHlWRk5zUExESE0zUExGMncw?=
 =?utf-8?B?V1JZZ25IQnRjUGRmQ2hVclRjVnc4UkN2V0l0UWYwaWI2Mm5xeTljVFZ0WXVs?=
 =?utf-8?B?Z0pJMHQ1QlZwRWJIMEwzd0xBUlpyWjEvOG5icTRyUjNRL05DbEw1Sy9zYS9u?=
 =?utf-8?B?TmhHcVEyeGxoM2hvaHorOTZGR01rNHVXaW9wWkxwc2UycUgybEN5QnMwS3U1?=
 =?utf-8?B?cXF0WHF2M1lOVTV1TWRKVFdXUXlEczF0Q2MvT2pIZy80ZWRacmI0WkY3SnEz?=
 =?utf-8?B?S0E2WG1EQ1h0T0w2ZEV3TVB3YVErT2VEazdMOUFOMC81Qmt4amlDZEVvWFVH?=
 =?utf-8?B?WmYyNm1qOVdwdVpjVVhxTUtNRnNxeGZlWU5BRHZyN0pCK3lrajhEOHN3SHBD?=
 =?utf-8?B?OWw4UTNnYktuWlQ1NDFxeENPMFg5cFFDL1V0OTNVV2lUamIwdUl4WW5pZFJ4?=
 =?utf-8?B?Zm8ySjJWdUc3R0ZXK2l3NEwwNWVjYjY4K2hXa3NzVVJoajFDS0M1Y0s0NFNy?=
 =?utf-8?B?R3JyTG1jOFB5UmErZndOcjVsWG84UFB5VmNReXhreXlsODJWOGV5QkV0d3RU?=
 =?utf-8?B?Ty81VWlwSUhEU0wybllzeDZMMHhEak9iQjdwazBQbTNUNDV4ek9vQ1BDcy9R?=
 =?utf-8?B?cGdzNlZheHc1ZW9oSVhNTUFFcFVRUXhGbnVxNzVScnFlbDc3aHBHVmg0K3kz?=
 =?utf-8?B?YzhlSHhnRis2T2hEbWJ2UTRVczNmOW9vaTdZUXZOOTVGd3lvMEJTYzZpNFNV?=
 =?utf-8?B?S245ZnJNSWR5SFJqM2NiVG9iMkdNTXEwbXJnV05qZjBBdk5ZY0JKV2hPQmxq?=
 =?utf-8?B?QkwzZFpKVWx5bzhOalo3TU05RG1TZG5YTlo3endaR3FLVzZ0L1VpMG1EaDdM?=
 =?utf-8?B?cU95YmttU3QvQnlwUlV6bFhRazhEcDcwYnRhR1VGOVpkbk9DVFVpM2F5R2tW?=
 =?utf-8?B?RlJIQWQwbGdSYnJWb0VTdWUyL3RMM2ZrRktSY1krOWg0M293Q08wUUhkV1pJ?=
 =?utf-8?B?ZnVuOHhQeDZldm9jUGpROUdqb3p3QU9KYnJ0WGsweGhCOUJyRjZvUXE0NCtY?=
 =?utf-8?B?WHlTa3VlajNPeWV1SThMb3c3ekk1VDdRaTFKUTErUkV1N0RLaGd0REZMY3JP?=
 =?utf-8?B?SHo3RmpRV3Q4UGdRSzRUalFNekxtU1VrR2JpWG5GK0xSZGxFTzZnL010TXdY?=
 =?utf-8?B?YjNTZE8wRzZQbVZzZ2FjUkJ1NTJyYmd6cWJSY2RFUGYxZU5ON2l2blE1MlVp?=
 =?utf-8?B?WnBQbXp2YUlVNndqSDg4TVRGb2tpV0d6ZTRMYzJ3dUVLcDJ1ODZPeWNUYW9w?=
 =?utf-8?B?UTdiaGliSnFGR0dkRTJoNS9pWkF4eHdGNGphRVJHM0VZSmlmbnE1MUlmOGpY?=
 =?utf-8?B?KzhWZjZSMExrMnVhOGtacU01djh2TXRuZU00blM1eHNoV2lVTjV1WkZ6Unda?=
 =?utf-8?B?MzVuZXJESFI2YkZvMzU2d2tSckptZ0N3azd0MmtNSXROc1dxNHZLbzQxUWdN?=
 =?utf-8?B?Q2YxTk5yOWJvOHVOTFBaSC8vNkZVMHNENVFNYXYyVGNuajY1RDduZjFFa3h6?=
 =?utf-8?B?anFrbmM1bEFmOGN6b2p6WG15QVROSmlWYWR3TzZBRDVjSVBWakpEOXlMTVZS?=
 =?utf-8?B?M0xNV0d2TXRabHZwTUZWWFJCOHMxbmtkYlNLTVJucW8rUWZHQXNDNmh0WEht?=
 =?utf-8?B?OUl6VUJiWWVtMkl0ZHNrMFNTT3RnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	O+pKyUgD75j+eeAK1TnuYQZoRmKiIR7oyYn8sCJb3bILEvVbWV13mZtLz3sB1XntKIv3qmijOecYSWW1LltZRtSg6s8m1SrE0y7k07+PEpgeNGHfdWEd0NgmHdyyRuuxYCwmQ0ibXN24sRY6aBy37b0dC6L0eQaGm++KZCfntoikF6ORppvwtZ+bOGCqCykA3IZsBOhKPW6qwAMZItdBpu3BHlVQC5pPDdNaNPaJ5yjWtnABGVMtBkCKDNGM0aP880aHtj/Zw2+xTirm4+3ycpdPAnqPiGP1uqC/tGagnbCPC7GZh/ahBxBZLn8MGFELEayPt5JokiX2YxnF4i7bgYoJGDIt5Hha188Jt9BGwXNCuwVxG3xEvAll1x+QMbxxk7ixoI70O08J+wiRs+c3nZwvYghzH5BEcngonSYPPAZBQjEvXh7s/nF+NwFsiD/fWcCbRrq7WnLNa8dRlu7lHMsCHU9ZscWK1bdaDsE5GZv0q+6s+imWwboSOqjEkPsQy7Dt1ujPwyLY3ZAlNXBG4CVly4q0wArI6EbOThQR0rU0AmByggkX5bxSKy9WFfRL1x+TFciRftL+zu33FoBWrM75IZ5sQIljwuGtGNMZQ5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3935b9db-cd1d-4151-cc83-08dc8fbe5739
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6111.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 17:44:45.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFP6GN40s11hqP33y0XeA+cOl2ezvbfYzjis3qm2HsjCnSnQ6CedIp6opTrga1Z0KTzIZCo7xmzKZbWp6r65/9Gcz1sXA4rYDB+hIyjgTYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180131
X-Proofpoint-GUID: X6e6ekE4fxKsaECxq_OgOgOSUUjAXsyD
X-Proofpoint-ORIG-GUID: X6e6ekE4fxKsaECxq_OgOgOSUUjAXsyD


On 6/16/24 21:14, Leon Romanovsky wrote:
> On Fri, Jun 14, 2024 at 01:31:35PM +0530, Anand Khoje wrote:
>> In non FLR context, at times CX-5 requests release of ~8 million FW pages.
>> This needs humongous number of cmd mailboxes, which to be released once
>> the pages are reclaimed. Release of humongous number of cmd mailboxes is
>> consuming cpu time running into many seconds. Which with non preemptible
>> kernels is leading to critical process starving on that cpu’s RQ.
>> To alleviate this, this change restricts the total number of pages
>> a worker will try to reclaim maximum 50K pages in one go.
>> The limit 50K is aligned with the current firmware capacity/limit of
>> releasing 50K pages at once per MLX5_CMD_OP_MANAGE_PAGES + MLX5_PAGES_TAKE
>> device command.
>>
>> Our tests have shown significant benefit of this change in terms of
>> time consumed by dma_pool_free().
>> During a test where an event was raised by HCA
>> to release 1.3 Million pages, following observations were made:
>>
>> - Without this change:
>> Number of mailbox messages allocated was around 20K, to accommodate
>> the DMA addresses of 1.3 million pages.
>> The average time spent by dma_pool_free() to free the DMA pool is between
>> 16 usec to 32 usec.
>>             value  ------------- Distribution ------------- count
>>               256 |                                         0
>>               512 |@                                        287
>>              1024 |@@@                                      1332
>>              2048 |@                                        656
>>              4096 |@@@@@                                    2599
>>              8192 |@@@@@@@@@@                               4755
>>             16384 |@@@@@@@@@@@@@@@                          7545
>>             32768 |@@@@@                                    2501
>>             65536 |                                         0
>>
>> - With this change:
>> Number of mailbox messages allocated was around 800; this was to
>> accommodate DMA addresses of only 50K pages.
>> The average time spent by dma_pool_free() to free the DMA pool in this case
>> lies between 1 usec to 2 usec.
>>             value  ------------- Distribution ------------- count
>>               256 |                                         0
>>               512 |@@@@@@@@@@@@@@@@@@                       346
>>              1024 |@@@@@@@@@@@@@@@@@@@@@@                   435
>>              2048 |                                         0
>>              4096 |                                         0
>>              8192 |                                         1
>>             16384 |                                         0
>>
>> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
>> ---
>> Changes in v3:
>>     - Shifted the logic to function req_pages_handler() as per
>>       Leon's suggestion.
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
> The title has extra space:
> "net/mlx5 : Reclaim max 50K pages at once" -> "net/mlx5: Reclaim max 50K pages at once"
>
> But the code looks good to me.
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Hi Leon,

Thanks for providing the R-B. Should I send a v4 with the fix for the 
extra space issue?

-Anand


