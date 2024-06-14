Return-Path: <linux-rdma+bounces-3147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ACD908332
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 07:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267132839E3
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 05:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5BF147C87;
	Fri, 14 Jun 2024 05:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n+BsDAJA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HsY+Hvjy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53521474BE;
	Fri, 14 Jun 2024 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718341908; cv=fail; b=GUSPHaI6APEXhJcBDF0jsswNCnFMvS0Ud3kRkTUmgjTVrFlBq9glIN4D52wVeCPtMtW0/8jTqIBrhyx4NogGlawPQWtQPZklQxuybiG6S67jHF6RkwpoWmc5HJbTIKAgx51tElIQEVq8AaTyH7V75Q2RZn1I8yzzvZDRaUdxoGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718341908; c=relaxed/simple;
	bh=8yWUK7GYvYp9v5fyc+JAdGMN7WNXGIV3bvqg5amXk2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=clp3D6D4A2aPDEgVHYT/waaaz6rTU1HM9PsL3Q1GGeiZY7C0JpAqHMMUvaR0fa7I8gIcsDAxRDZkWWmVVDrhc13rh5fcR3zhUVQEg7Np92sUj7n+WzjfWsJMltzkDhEy7m2kLMLz0u8DHGxRvBvuuwHuhRrYDvvcdXen5E5WBrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n+BsDAJA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HsY+Hvjy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1fTJI022999;
	Fri, 14 Jun 2024 05:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=xP9KNNhC174OwHMstiTMS6gyLhSm8Quz7uOQln5jdNU=; b=
	n+BsDAJAmN/o5MlUYb1eGFruD/O4ps6/sDMSoJVje9KEPjgwXyElxF9eZaj1cO/O
	p2YZyOk7B78jpW1iFmsQ8ZzYdGvFJRzI0/3QrjFa0UyMpnrDWkZNKKa5DDDDlAFG
	ryDSpYW0DBJsi6wTYtc1lmyg+XpRRiGNNug2nN1smjyS8f7Fs5FuzisMIOhnJGa+
	ld+YeutWVhkTpwYrUXGwzY/Tr0MvWM8td/3waJBkofKv9c3k7qA4qareD9jLJJ96
	f+AI+THWKe4cp2PWqqxT327XsH9+5EkxiVbhxjTIUNpDKPya5AuwXLXpsXlsuD8t
	k+T5kvf1tW9HQ20QG16v5Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7fttsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 05:11:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45E4HDcM027065;
	Fri, 14 Jun 2024 05:11:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdx7f5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 05:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbpQDIjMlne0ubNP5eTgWNWixYQf2IpQreWlrgrbIq9Qe+oHv6fcQ8B+0bsGSIyLDqtEZ09qTS3svobYDdkJlZ75tpbs5WePKHcxKH6bf0D6xs5l8glpWVqv5XefAlzszoOcfUOFy0RG91xqWJ9lmF1Sl8uABy+3b330BB/sru/UTzLtI4KytC0gf29KZuNZUbTvSp43gnBGDbMbo8wJNnS4KZafxKBwFRgdUWsV0XIq5nE2LYGuNQbO8TXZtF4kfIXMltpbSZit3fJAsk2jGcnJy4yo+aES+WMAKuTw2YKbPEHiXsNCZ4V8T3V4C0N4naoO6L4Gh65/no7lQX12Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP9KNNhC174OwHMstiTMS6gyLhSm8Quz7uOQln5jdNU=;
 b=LfvrsM4EOCoxksDsZopIWvY4g8F9PBqr5mzjBGOFZ3KC15FkNMepKa8fNlXzE1dTnbQ1xouREkH3vyzIInosgdhI7ZablTmv5X1oxmpNv7ayI2f29hrfiWxYwS5QXpYu5tZMOi8m2qCOuEUcjh3rt0kWvm8H3zwLuEf4FFHCoRzv02vHgQJaw/aFPY39mPMWdVz3mOulg9RefA4yLdYJ3xcTxBtCASPqqxTCHSZRNMJWA3tNtAe0eQzo27AG75t3SCedDovFVKmYRgVHUANvZ8xc26D54Gl81fOjcgCxO6Rn41aNvBUGXBvOqwkJ87sBrJYGTLWA2WpqkGuRYzG7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP9KNNhC174OwHMstiTMS6gyLhSm8Quz7uOQln5jdNU=;
 b=HsY+HvjyG9ibVQlXzXuT3yYIiamczMNkS4ZV7reI56LY+0mZNTEBvb7KWRsSlpVIimuYMdSviH8FIytHPma1V79oO7KQ8p5flZapYAzGy2arAnAPNHgfjSjO/pQXLII0O3RLUEIqwgH3DPU/4BJSQl9Sc6gtmBxqNjH+A2CRuXw=
Received: from DM4PR10MB6111.namprd10.prod.outlook.com (2603:10b6:8:bf::9) by
 SA6PR10MB8206.namprd10.prod.outlook.com (2603:10b6:806:441::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.24; Fri, 14 Jun 2024 05:11:39 +0000
Received: from DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777]) by DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:11:39 +0000
Message-ID: <af05925c-cf5c-49fe-96f7-7841024cef7e@oracle.com>
Date: Fri, 14 Jun 2024 10:41:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/mlx5 : Reclaim max 50K pages at once
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com
References: <20240613121252.93315-1-anand.a.khoje@oracle.com>
 <20240613190309.GI4966@unreal>
Content-Language: en-US
From: Anand Khoje <anand.a.khoje@oracle.com>
In-Reply-To: <20240613190309.GI4966@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To DM4PR10MB6111.namprd10.prod.outlook.com
 (2603:10b6:8:bf::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6111:EE_|SA6PR10MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 1499c4a3-7bc4-4475-9448-08dc8c3078e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHBjRTJZSUNuSW9ZQjdTek1NQzNOOUpzUHhMN0hnV2JybmkwRWlWZ1NDUXhk?=
 =?utf-8?B?dmVBU2N3SldKZXR1aE1QWnFqZ1RRRmxnYlZzL052S2FxRkNYWnNGamRtZjN0?=
 =?utf-8?B?QWhSYVlnOGdvNktFL3VNNlJVT2xEUlJZNmt5NkxpOTlXVU5Qc0pybUZ4ZmFt?=
 =?utf-8?B?clUxUkRvUUoreC95L0pWa0s3aGg4QWRzOFU4MXBlQjRydHUrVEhjSnlDNGRz?=
 =?utf-8?B?OWp4aFRCZ1pwQVVQcGpyTEg3NFBYcU9USEFIdHU5RWJINnE2WWpDTTRXMjJP?=
 =?utf-8?B?dWVzaXFnelM5WU1FZmtKd2hGVFdLYVpPejBIU2cvRWdSVStJTHJaRXJIUkov?=
 =?utf-8?B?SlpHTmVwUXBzeVFqMjhmTEJqZjI0UjhkbHU0REY0N2MwQ3lSM3NzdzIwSzRH?=
 =?utf-8?B?RGNmbEhLUGZkdmV2MXU0cExiWVlUVGQwbHp0RGVieHRYdk9zYlFWY0NlRG5q?=
 =?utf-8?B?Z293SGNFZ3NUd0Z0SnRUcHJYZkU3dHJlZU5DMDVFQmJuczVzUldlajY5d3F3?=
 =?utf-8?B?aW9VSE1UaXBsMzM0UmNFdnhVUTA1UlZmRStkVTJOUEVyWlVTSTNKKzJ2NHNl?=
 =?utf-8?B?U2pEM3RhM2NtaWJPVzRUREltZFc2ZGd4UnVhdUFnVVNOdHZGdVR0UmIyQk45?=
 =?utf-8?B?Q0pVN1haMVR6ZU1EYmF6eFR4Y0ZMOHFKU2NTRGVrU05FM3BmVHFaR3pscTlJ?=
 =?utf-8?B?bXNWc1JjNUtHQzVlMUhNTkRTaFNHeDgxckI4VHJmeUY1NzBuMVNoL3lxMVdP?=
 =?utf-8?B?SzBMcVBMdFpyaWdmQThLcWdZSGhOVG9LUkhuNXhwb2NybUhDK1YzUFA4a2Mr?=
 =?utf-8?B?TFZaQm9iQnNzVWNXWW9iM1JmcG5iVWNpZzVPWHQvVzU0Mi9HbnB2OVNjTXQ2?=
 =?utf-8?B?NllHTUliOGYwc2NkZks0SXJidEZ4WWIxZjkzNGh1N1BBcnViVjhEZmpvQ0t0?=
 =?utf-8?B?MmxaWGJ0VGRkSEIzY1JsbTFydVIzWkhTblJjd2tpVEpXTzJ6Y3J4Uk1LMWMx?=
 =?utf-8?B?bFpkdS9kTDN1Q09ZKzI2TlBySklCU21OckdNeVpib1UvZ0pJQWptWEExM2s0?=
 =?utf-8?B?d3VQV2NGTnJENEtBODEvMkpHMXQvWk40Rks3dDMzSG5aejFwTEdzZjczcXhp?=
 =?utf-8?B?NnJNOHd0cHZ0bVRFdEtWekxMOCtWS0lpZDVSakNXZ1NtOHR0TkN4YmxnbVAy?=
 =?utf-8?B?M0JZbWtGVFQxeWd4akEyZVNxSCsyTTBZcVZmY3VMQkg2SCtDaEpjRlhEMnk3?=
 =?utf-8?B?clBxSytJOVp1Tlg5RjJ2ZTNLbTVGL3dFS2xnOEppZm5OZVliMzBtNFU2SThu?=
 =?utf-8?B?SENSNVRONTV6cUVBaVRxUW84a1FTbFlBaFF0ZjNUUXl1aGVDMlp4SE5tY01v?=
 =?utf-8?B?bEhwWXcrQkxPTkFHdzE1L3hsVDhrY1ozUHNiWXgwMDdVSXBXL3E2RmY1SGIw?=
 =?utf-8?B?ZnR5Z3FLbGordXlzT1lETSt1YUNQYWJhVDBUL2l6a0wyWEh6c01sb2ZLYnkw?=
 =?utf-8?B?SHZRTUpjWE5OVUZFVzJRZkFnc1R1eXFMTTY2SzlYTlZUOGFmZm1uZlhHTStr?=
 =?utf-8?B?TzVaRGMvdWR4am0wd1k2SnJqRldqVWFQaHBaTmYzZ0NXSEJVcGx6RzFRN1NV?=
 =?utf-8?B?cG5zZElCZElSSmllTnFJTk5oTE1VR0M1c2RDZkkvWWlFQXVXbXFpRWhNcjJ5?=
 =?utf-8?B?THZrQUpiR21yckhNTFhJdTJsZmdoZmJsc3YzUlNtSTViYWd4QmNxNXh5cTlv?=
 =?utf-8?Q?dVzQUx1/Q7TQURHBfdwaa7Oe5FHcKtryVBYoDi5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6111.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjhaRUhoSzV0b2tSRlM1VUtGRngxUnp1V2N1ek5zN0JJTE9kYVk2TFRHV0Fl?=
 =?utf-8?B?ei9RMVF6TnJTYU1DclFBQXh1UTJQT2dDcktFMkpUcFRnOS9aekwyUVpqcFF4?=
 =?utf-8?B?aFR5SitkZXFrekNndUZDajBjK3dZMzRMRXRyeU12UHAxTkF4d1ZBMkRmUjBs?=
 =?utf-8?B?Q1NnV1JDNU9TeHFDRWpmbGZCSmk0YWlDYmYxT3hHMWdLMCtqTHh0QWJMR1RN?=
 =?utf-8?B?RTRIYkFJNFg4UHlvSVlSOWZoZnBidm9QVENiSVcrSmxROE04L3ZlQWZucHNp?=
 =?utf-8?B?ZXdxNVA1Ym0zSDRHRUJKYUJpbE8rSkg1L3l2MzkxbTdrZmZlNCtob3lDbkJ0?=
 =?utf-8?B?K2w5ZVNTcGsrV3hLNnBTemxYbVhyekc4SzMzQ0Z2VjNwaStSTkYvN0VZK1cy?=
 =?utf-8?B?enhuMlRoaEJHeWlLellkVXE5WXdxUFhLSTA2Q0RnTjFLVXFmc29FV2lWTG1J?=
 =?utf-8?B?NWkzRndZWllzenduWTVIZ0dkc3E2R2FTblJwYlVkaG1xb3E4dThCMXFQbHAy?=
 =?utf-8?B?L1BYb3kyR0ZFeGllZmpDNUFVTi9wMzJOeGpkQ0RVMGhyZEQ3MXV6WXJ2emNE?=
 =?utf-8?B?Z2EyZzQ0SklUQ0NmZjNhaGZtTG5RZ0NNMldZTE9FT09yRE9Bc0dkSHRnMCtv?=
 =?utf-8?B?aElvUGcyeGlpQ3R2RDBoVkh6dys1ckswcG1hTG1uazVNbmxZN084WlZIOWVv?=
 =?utf-8?B?TGtzN0V1bk5OR012dEY0cGZTVGFPSHIyclFRS08wNi80dmh0Mng2dmVzaVJs?=
 =?utf-8?B?a0lmZzNhdnh3aFRTaTZ1d0FSQStWdklPVEZBTUxpVEtHaDdNbnlZNjVKbGtj?=
 =?utf-8?B?VW50VmRoVkk3U2FjMDNMU0lCU3A1S2hTakxZRTRXNk5xaDJtUE50SDQ1dEFr?=
 =?utf-8?B?VDZOMWhIa1BoL0EwNHdSeDlrUEZiYkt4elpscm02b01xZ0NFWDh3Ti9DSnZ6?=
 =?utf-8?B?VnNDWFFRaXpLaFZ3Tk04c1pLcW5hT3czWi9lUkxaNkxhTXg3Nll0ZmhKdzZN?=
 =?utf-8?B?QSs3NDBKSmo4UUdlTng3L3BXY2t6c1dYZGdxMUtoL2pJNU5iT0NyZjB0NUx1?=
 =?utf-8?B?VDMrdS9XWmNDS2JoNi9tRWVOQ1FJbjdmWXJwSTRZaGRGa1ZDZDk2eW53b1oz?=
 =?utf-8?B?OHJUdi9admphZXh5NzY4b1NZS25jVjBGU2RlWmdxQm9wamx4MnFyT3g4TXNv?=
 =?utf-8?B?N3QxQWdjeW1GdEV5UmRvOFUwUWwyYlFxZm1VWkk4M3ZwYjlCOWg3bTFJTFUy?=
 =?utf-8?B?YkNTREFkT25uaUlpRkk4Y1lTMjY0WmU2d2M0b1dBREpsRTVGODdEbWRSMEkw?=
 =?utf-8?B?ZGlqekpPdjNPcUt5TlZZWUh4MkRsZWgzVU5SU2lqN1RyV2ZGT0Yybnp2NDdD?=
 =?utf-8?B?NjF6LzNBUE5BNVJ3UDk3cVZLY2tBTm5UZjIvWi84RzkybUFBWmZQNDlmZE9z?=
 =?utf-8?B?RGhoaHV2L0wwNHlvMTBEaHZFbDFodWtpdWxHWXppMXJEUjJaVGY2cStuYkUy?=
 =?utf-8?B?Z3V6MmdDR0poM1V4N29pM0g5RUJuMXkvanRNSm1zcFZXTEV5ejh6SWRFVEZ1?=
 =?utf-8?B?c1pjMmdWclJrMWlQZTdhNFNyYzlUWFd0K2ljZHJxNlEzU1VxQVBCeW9IRDBP?=
 =?utf-8?B?Z3k2aDJOWXhHeERiYTFNSlNUR1F2aUhMazU3MlVSNWhsZzh4ZW16ZFJqbUd6?=
 =?utf-8?B?enU0OXpqZTZoTmhqQVR0Tk9qSkpQa05QWW9zOEdRQXpnZjF1UnNjUjJ5K3ZE?=
 =?utf-8?B?OUdUb3BSVitQemh4TnZ0NURxSTNCWXArUEFQVzRCdkhxT25SRXc5WFpzdWRw?=
 =?utf-8?B?Ly9oM3dCTm80YTR2N0loNUVUdlRQL3MwcTRBbE5HS0l3a240RHF0OWxLWGtW?=
 =?utf-8?B?MUFwMEtoQURCMmVnQno2R2xsVHhzRXRYOTlya3ExalVKRmU3QzBBdDNMcnBu?=
 =?utf-8?B?RGhqc3lRcmNoenBPLzJCSWJDN3ZCSkt3ZTl0aWhCeWVDdEp4TzU4OW5wTzY0?=
 =?utf-8?B?TUJkWTdjMGhLakRpd3JSSXdpc3JMKy9taGpKN0ZmbzlZWlN0MEpEbWJxU1l4?=
 =?utf-8?B?K1Q0UUJJYytMNjhOdXVLUHN3NXRmdEJJYUFFT1k0dGZ6ZGlITTRJcVoxbE1i?=
 =?utf-8?B?VWcyZEVSS2M1QUpLUm16cXE3Z2F4SWkvV3VkOFNHU29qV1hXQmxWYlBFTU9z?=
 =?utf-8?B?M1dTYnJMOXlPRHJ4M2psVnUzc0t4ZzNiY3dsc0lRekdLV21ISDA1L0p4V1Zr?=
 =?utf-8?B?VUpFUTRaR0Zqd2l6eTVoODFwdHZBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lt4q65QsTV17zmycT8DsBWpkewZxZ28NMBv51Rtt2ZuaprJHzSP3/oEjWGGv5VclbYchgrboQ4q/cMmFQiVbC5Dkk2QmwM3v7xk2bUtNLmQJNt8nwMlPNrZA44IpmuxQjnR/EvVAyuGf3LqEVNOhLohnSflzON6dcpzbG/x3w6gIJaQ9arwERP8+c4H6kiWb+Xj38n2HR5Lf/2fi6FejgTXSWc7PqnqP/JGOnRZPz23OTzTYq3QvpuhkpIJ/QJTpZ3lRFODJONTGtN9FgmMMPfYg5MGOXTls0YPKNgVk+Oy4pDbCoMOtqIFcOoqsdHBTvBvT9Nx0a9lkoQumTzBw2KSJLarMGdN3A706Ls2vUUZZ9j2zxJFsOkHzpeXo1tYCd7BJU35h6w5O4XHL2oUksWO1dEkbyKSlAnY+mV2FybZuuX4ljCCKRbIfVKTviaeW80Cq79cer1vqDlceKajZPD+sq3qJLM9CKWdnuEhl9BNFKv7mNQv3dRT4NsXxwPD2nrQWqMbsCW7HzetxYAt5giTWyVi/3V18olrJs7MzyI52r2xouCh3E0h8llYz+N3EAyIaYEHaLDYhjPByRljvCVygnPXpl/z99ay/t91OBZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1499c4a3-7bc4-4475-9448-08dc8c3078e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6111.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 05:11:39.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqDZvNwmR7eGq2y/5rOUFypYDTlPCOTZqBe+XOGzFikW1i4rw7xsbtLKwefKRSLGCXeamlsV8spqsTgbzRd+txHSTs7EdXfckmfotsbsaxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140032
X-Proofpoint-GUID: GsY4XdDsukz-90ehp1ttKZYftwxK8UOA
X-Proofpoint-ORIG-GUID: GsY4XdDsukz-90ehp1ttKZYftwxK8UOA


On 6/14/24 00:33, Leon Romanovsky wrote:
> On Thu, Jun 13, 2024 at 05:42:52PM +0530, Anand Khoje wrote:
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
>> Changes in v2:
>>   - In v1, CPUs were yielded if more than 2 msec are spent in
>>     mlx5_free_cmd_msg(). The approach to limit the time spent is changed
>>     in this version.
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> index 1b38397..b1cf97d 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> @@ -482,12 +482,16 @@ static int reclaim_pages(struct mlx5_core_dev *dev, u32 func_id, int npages,
>>   	return err;
>>   }
>>   
>> +#define MAX_RECLAIM_NPAGES -50000
>>   static void pages_work_handler(struct work_struct *work)
>>   {
>>   	struct mlx5_pages_req *req = container_of(work, struct mlx5_pages_req, work);
>>   	struct mlx5_core_dev *dev = req->dev;
>>   	int err = 0;
>>   
>> +	if (req->npages < MAX_RECLAIM_NPAGES)
>> +		req->npages = MAX_RECLAIM_NPAGES;
> I like this change more than previous variant with yield.
> Regarding the patch:
> 1. Please limit the number of pages in req_pages_handler() and not int pages_work_handler().
> 2. Patch title should be "net/mlx5: Reclaim max 50K pages at once" and not "RDMA...".
> 3. You should run get_maintainer.pl script to find the right maintainers and add them to the TO or CC list.
>
> And I still think that you will get better performance by parallelizing the reclaim process.
>
> Thanks

Hi Leon,

Thanks for the comments. I will make the changes and resend a v3.

-Anand

>> +
>>   	if (req->release_all)
>>   		release_all_pages(dev, req->func_id, req->ec_function);
>>   	else if (req->npages < 0)
>> -- 
>> 1.8.3.1
>>
>>

