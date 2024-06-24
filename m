Return-Path: <linux-rdma+bounces-3443-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD80F9152D9
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 17:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFA01F230EA
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B819D08D;
	Mon, 24 Jun 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HBD+BIWp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vsr7CK4p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6026554276;
	Mon, 24 Jun 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244184; cv=fail; b=UsJfYLgsJveW3A+0+hqhV7QJdcxPxPXyrRbHrmaT9x/Jhig/sk0yiLJ6SngMd1fjinPyLTFcZZarM/DgJ+KwUgHbhuwtKj6ezSsQmqqel9dctrV4s8rqcyJehSbi3e5y5NQUpmswPUoNwTpY0Loa2VESZHzphyUr2WrBaLRb2p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244184; c=relaxed/simple;
	bh=0Bm15QplNLT0z4YvNQT5zLeG+dV3raSkIoqliEH6YJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f3pjH0itLmzqceloaVMQAbnm18DmTzJufwv98mkelRz4IxVqZb4i4HdwVnqpVKME9DrFNMGWrLKs0IcxM2cGdP8Ol8OZdFbhgLF6LN6dgio3Yk+T4GO5MdBkRyXjjO3cU4/8kHXLn1GjHe1OxSX/raCjLGTcHXB+JaHrV3I8/Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HBD+BIWp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vsr7CK4p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OEtPqm006299;
	Mon, 24 Jun 2024 15:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=zXtskTeRgC3l9g678R9NkLErDP6Wms1Ics+nDkvjJF8=; b=
	HBD+BIWpQ+JybiWiJJDFlUOYmFKGEise2fq9Hzig2NSo1geZePdVIQNJG+60hD/P
	AVruJqHFULyYjbRIsCLozRIGbxhh/PCoxwSVL+bjRb26XDt/hixJO1umqAvyJIKI
	M0RQ+Ur5BVgfcF8CTD8KXrfQY62frTdIrn1MM50x6uj6AnWVR4YBw711RWE9jwJm
	pM4/JJUCUsH2qARwn+cKl3USwpdhVltrP/TgEww74q+oEC7uoFN+T5x8b9OozNi1
	+JDSERVEydpj42bVUPRKStDHqEUh5hRTJz8ysX4qEHpxuBSUoNLD9FRVLK4mN9YO
	x4Plask448qD1nXkOAhH4w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5styby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 15:49:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OEeO1c017797;
	Mon, 24 Jun 2024 15:49:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2649ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 15:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQQxxx8yYMmu1e2Q+nLFBrMwttZIIn2wlELsHjPRtm4Sb/+SlMUHVYQv/xEftB5zJP/pJMP2Kc9akK+9EW8HbpcVvM0o2nNEn5acRlyLfLRr9B7NOEISTiIeyULctZNTrU0BHdDR5xjf53Exby5XjHORtQpeTmlyD3PLw6S0l81W/7ucO5LeCJizQnvAUuwoNcNe9+qIoTCsNeqTGTXn6GJPLwZA+1QjNkGci7kbjM0dhkZsVcUBf51EmQ/2M6YjmcOjhDrlBz1uTj2Lmn3b+LOge02DR63622UiJJTVRBNNvUzf0T5BZIgBgJ6PKm6kYA0AnUuC++ROtmoROG2HNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXtskTeRgC3l9g678R9NkLErDP6Wms1Ics+nDkvjJF8=;
 b=CnmPuHH9WRinp/9egAVWBwggZJgGbC3ZGfL4dG0IGQBGBAaSdG0B8ksQmw0tX9nROlWg8zZfSsv5J6qlgQMC0WNht1o2L7qEXk6pwWy7sGCHveytIJgw6EOOpPL7DE5swqgOd41ROx+lxDD7/oQ4G7kQs8BmXHED/CmLpLs4scz0mdDH3Hxay8MGabLG6GBp043WwiB9tkad4MEMg3tD6pXMVNHGxzWBsXhISySIJxlOWvWUD6Iva4r5P/GTaYpe/SUfXtrMPqV8y12O4eiBd5qjDUlP8yFdeZ3l+5q0PJqfgf6OUcFRsSsogeBEnsaHgnC+ep2nGdBwIEIJh5sy0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXtskTeRgC3l9g678R9NkLErDP6Wms1Ics+nDkvjJF8=;
 b=Vsr7CK4pcbc7+mpwDcwkCIZ28f/neeF4KrdgBDf6e17dR4wlmm4iRXHFky0gvQaAhcCz7JqTrrEU+I7g08n3TJ4TAq/LbdUU4TSSN0X2RxC/0Kk1lD1PxDP/cMbWzKKtFOtJQIg0jRqtUgFDj8s/iKpD4Y/5j/DsVNDL4Dh0GSU=
Received: from DM4PR10MB6111.namprd10.prod.outlook.com (2603:10b6:8:bf::9) by
 SA2PR10MB4492.namprd10.prod.outlook.com (2603:10b6:806:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 15:49:23 +0000
Received: from DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777]) by DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:49:23 +0000
Message-ID: <cd7650a6-e474-4a39-94e4-fa04af47949b@oracle.com>
Date: Mon, 24 Jun 2024 21:18:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net/mlx5: Reclaim max 50K pages at once
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, saeedm@mellanox.com, tariqt@nvidia.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net
References: <20240619132827.51306-1-anand.a.khoje@oracle.com>
 <20240624095757.GD29266@unreal>
Content-Language: en-US
From: Anand Khoje <anand.a.khoje@oracle.com>
In-Reply-To: <20240624095757.GD29266@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::21) To DM4PR10MB6111.namprd10.prod.outlook.com
 (2603:10b6:8:bf::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6111:EE_|SA2PR10MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 42865cba-1838-4cb4-5997-08dc946537b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Qk50a1J5RUdrYlAvZ2VxSTZQN3F1Sk5rcWdZSVMwZ0M4MzRWdE9iY0E4MGta?=
 =?utf-8?B?bElTbW9rQUhKK0JBVnJTdXFGL1BKMVdHUUN4bnJmMlBrSzd5UVg2Qy9EQldV?=
 =?utf-8?B?QmZnVTNlVmRBVjhoWTN5bHRkTk5qYWVZcDRpSTNCMlhEQUJGRGU3UE8xODBt?=
 =?utf-8?B?V29EeVdyMkdBMnhiNGJOZjRUS0dHaWlKajl2MGZhdFVnNFc1aDlPNE85WEdQ?=
 =?utf-8?B?OUFWY25qcmZscjd6VWN5dCtsZnBTNlJCNDU4TEVGQ3lNNWs0R1FZOWxtczhF?=
 =?utf-8?B?QkFpM3hqZnRyMFkrVjg0NVEyQ1BTU2JxZUVQVkgwQVdycUlrazhOUkxnZE5K?=
 =?utf-8?B?V2hWOXdJUjhsWEEyOEYwK0MzRWJEOHVxcW9qVmdCcEExNVJ2KzdvTDdRcGVM?=
 =?utf-8?B?dVFwNC8vcjB4eDljZ3B5SzBuWkdLRktFamtLZjNWM0I0N3FTcGdJQUxMREVm?=
 =?utf-8?B?eXRmQVA2dEJLZWJsOHBKdTV2WUw3aGUvcHNBZUl1Y0Qzc1VlZkF1MEpmbFdh?=
 =?utf-8?B?bXdjMjA5bW1lOEpRZXBVMWxPQUlTQ1FUQk1QbjRCdHRESDJoakJQMWtqR3V6?=
 =?utf-8?B?Z0FHbFFZR3EzNWw5bCtHbDk5OG5FZFhiMk5pSm15MGwrdWtFSlFCV0tMOHAr?=
 =?utf-8?B?MXgyZDNWNHdwcFBickY3VzZOU1E4WXlxMlRnNEFqbzBDdVNNSndrb1hLL1pS?=
 =?utf-8?B?WFNNNlpRUE9rT1hYMEgvd0M1dGVpc1RkY0pMeEx2NHlPRlFnTjNTTEFUaVg3?=
 =?utf-8?B?V1FqdFZDbkpHVFV4MXBBRCtqeTFHck1lWEh3TU5CYWdaVkl4S1IvY2ZZWkhU?=
 =?utf-8?B?YUFQQmlLMWM1UzJieGNLdzlVZFZncUJmcERSOXQ3aVVZWXF0eGVXZkVwdi9y?=
 =?utf-8?B?TEdqREo3cGxyOHBWUjljMC9FZ0Q2NkpjTFZ4cXYxckI5UUNkNEFBRDBROFk0?=
 =?utf-8?B?S1p4LzExQndxWWNWN2llRVhHZklaL1oxSzBmWTVkRENpbTBTalZXVys3M2Rq?=
 =?utf-8?B?U2drWXlWM0crQmJrc25sWFhJV3ZVUlY1NHBURlVna2hJazVYOTVJeHVUL3Vm?=
 =?utf-8?B?NStaTGs5MHlXL2RGOVlPMHBXbFdMY3BPUzh2UWRXbGtoSEY3OW5KMWU2TzlZ?=
 =?utf-8?B?cUlCWjJDM0FDbzR3ekFrQzNmZkU0c29zcjN6YTVsaHFSejkxaEljMEZFNnZz?=
 =?utf-8?B?R0Q3b1YySUFBN09aTjErMDYvSmRTOC8rWWwzT1dKYVJFZ2FaOFRUSE55aklj?=
 =?utf-8?B?eHI0UnhqRDV0QlhjQTlVSVE1T1dqdGlqeGRBK0lNb0ZBcloyMUdIdVdHcGFT?=
 =?utf-8?B?elZWbXo3b3FkaFFPT3ViK0lJSk1SN051OWVmSmxxSXZiK0lvYzVlc0pLaWNF?=
 =?utf-8?B?VkhJaXV2dmZsUTBWT2szeFVEdHVQUlVBUHp4WlhkdTlwT1pubWtqa0hPL09S?=
 =?utf-8?B?NFlQYnh5Wjc4NklNU3JSR01GWkI3VHZYU0NRKzRtYUxLeGkvbDhsWlNEL3hr?=
 =?utf-8?B?KzM5K081Tk83SDBmMGhqS2JiRTNlYURBU2ZxMk9KakRWOUs5SUtQY3MzSmlL?=
 =?utf-8?B?OFBhLzROV0cwMEt5Sjh6TDEzcFdCcU5SbEp1SzVWTkczaG5tQnJod1Uzbmpa?=
 =?utf-8?B?OVczSkVuY0tRRWV0QkF1cnpodUdzNGwyUFcvRGR0SFN4MGxqcGovWU1GMGxR?=
 =?utf-8?B?L2hVL0lrYjNCZnpURDdGM2NhU3VMalNscGRJZ0lZSEtvazZ6RElRTDBsaUpE?=
 =?utf-8?Q?F1ogEPhoEh5KVGjvfKaPQhfgyl29N5/17lg5Tjs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6111.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T1h0cGszdit0dm5DUDFtaTRnMzVBOU5EdmcwRmlLRUNablI0TGNhcHYwUDJW?=
 =?utf-8?B?VlJlajhWTTdmOWZuQlp3dFVIMU5JRHNLVkw5SFYyT2svSkwxZWh0VkRFQTVy?=
 =?utf-8?B?T29PR1d1TUZOOWQ3NzBITm5ScTE4N3BJbUJkUkhwRU1qVnFqU3JERm1hL2tp?=
 =?utf-8?B?cGtTTGhSdFNYYXlmUW5lK2NlTzRjWGJhcFpwMHNwaktiZUZVNVhEZm1ldktU?=
 =?utf-8?B?aVAvTFNiZDA3UEp2eUtzVHM4a0xwMlY5cFplbDQ0ZUJza1cwVFlJaUxqMVFa?=
 =?utf-8?B?ZFVzemQzK09na01UbzU0WFh5cUZ3UWl3cWtmRVNLaWoyODdoN2huODFlbHpL?=
 =?utf-8?B?cGpYWVlWSFZiakZaQnkwZHV6WXh3eHFacExrL1lXbHhEZldyeFJ3bkdJYXht?=
 =?utf-8?B?Z0Y0S3NsYytHUGFIejY4c3RFcmsxUVliVHV5NFAwVElQTy9aWVhiSHRiRW5n?=
 =?utf-8?B?bFM3SXo0N0huTmFNb3pNdUZQblV4M09TbHdqWGNJNEFwQzJpUG9nSTJOL3NH?=
 =?utf-8?B?a1Rmd0pTNnZsL1VMNVl5Z3VHU0pmRmp1VnBhdUxCYU9NaXNuaENUQ2xBQXg4?=
 =?utf-8?B?VFBhMTJvS2VCU1dIWkUySnBwaXBIWDFzZUhYaW9vc3M1UU9TYno4V3JrN0Rx?=
 =?utf-8?B?NHFEbmdEek5IKzJtSU5INFA1MlRpa0FlUWZQNkFMOXUvMjN6dGZuNCtaVnpY?=
 =?utf-8?B?TlJkU1FTeFpnZU1XS25zYStFQzVuWmlYTHVWdlJSbkF3TDdnQ3ZGMTgvU1lF?=
 =?utf-8?B?NWNzOUpldHZtRXArclFNall1dzRsdFRnZkJqWmJnZkFDUmN2Qms5RWRENFdF?=
 =?utf-8?B?MFJ4R0UrZUVDM2ZVSHZBa2ljd0pPbWw5STZaTmQ1VkhzRGcvVllFanAwZDRK?=
 =?utf-8?B?ZGJsZE42Z0RpVFR0TDArN3NkWTY2TmRabnNaZjFCcEwwMVFwNUMrbXRkOVF0?=
 =?utf-8?B?ZWtwUUhVTy9hN0h6UlZaUTljWTVoQ21IRVRFa0NxQVBJSEhkejRaaUU4aTQv?=
 =?utf-8?B?YVc0QkFFampxN1FjVmZ1ZlB3WUFhT21iYTdWV0tleFEvdFhrYTJvdzZ3b3kw?=
 =?utf-8?B?c3VxaVhSNlBoWUpxM2ZHb1l4Q1UwcmZvY2FkT1p5clhrYVQ3bG85ZmFTTHpZ?=
 =?utf-8?B?UWVtRUtydjlkTWFYeGFneVlWbzBrN3ZQRXdoMEg5dHpTQk9HVVNsc1dHQVkx?=
 =?utf-8?B?ZEw5dDBMSUd6VEVYYU9idEp2SjlIdVRVU0JDSXRtZ0g3T0hoK0tORExrZTlu?=
 =?utf-8?B?UFdOZVl4Wk5Td05oVTQzUDh1YUw5UnY0YnJXQlJSTWpiWjJhUWFrZzg3bFJW?=
 =?utf-8?B?TWdXbmtWakdwVjVYSTlNclJwQjVSaCtINUhCeEhYUldBSlhZZWFMUlBHWHVl?=
 =?utf-8?B?NjlvTkJFVmlZMVhTOEg2bEorRU4yb3lab2hlZ2wvejcvWmpFOEhTbFVyS2dH?=
 =?utf-8?B?dWdqYW1SZFNLTUxlUkx1R01XWGNhTUZZbUU1NGcrTkpZZllRWnowWEd0TXBW?=
 =?utf-8?B?Yi8yUEpFZzFVUEw3YVo1Qll1dWhMNlVnUWdJVHZ6VDA4Ny9nTnI3NmZoN282?=
 =?utf-8?B?MndyTGpUQVdBT3AwOCt6YW03bUdoSk5pQnl4b0lTc2dZMFZIZGtOZUVYMEVv?=
 =?utf-8?B?RTdBVnhLQWdONlhSL2piQ2gxa0IvRk9TOUMxdW5TME44V2VKVlNWRFBKMFI0?=
 =?utf-8?B?cjlSRUtLT0taMWIzdEtuWEFJTUUzc1F1TngxN2dkd3NUaTVpWWN2VVpLNzVy?=
 =?utf-8?B?N3A1ZisyWmo4Qldqd0lOQTJMS3gyeGxUVHV3ckdDdlEydGVHVFRIamN3V3Bu?=
 =?utf-8?B?OXdsNkk5NFhNWHVWTlhSMUFMSFRQWmhSdEtWa2x6c2pKeHVtSlk2dDNENmJ2?=
 =?utf-8?B?RmJZaEMvVUxYY0E1WXVOQjMwY2QyUG9yLzVINFdKVklUVzFMa2t4c01jZjBo?=
 =?utf-8?B?YUFkZHFsUm1GQ1JNdG5oOUVlVDFXTHoxY0FGWEdETGxETFQ4QkY5Y2NIelpw?=
 =?utf-8?B?VnRsa1F3OVVvZTI5U3BKSXBSUVJxdTg0Tmcyb3R4R1ovK212WjBXckIzN00z?=
 =?utf-8?B?LzdpeERneXlPbENOdVRJRDA3QkxzcjR4akIvZktFalI4bzNJTDV6T3ZyWFJP?=
 =?utf-8?B?YkFIcXlhMEZrOGhURUN3djg3bnpubklmMHB2YlRmN2NIb1ZucGh2cCsxWmRR?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZRjyvUUQizD9REOMcIlLMfAulPdwgwG/MrJJxcUWEwQL764ymFqrxlz75YumdPWE+lqDxctN6JZtauuF71DZ2l+Iv+5kEywFkhxNyblf6aKxDMkX1S4iWV+2qlQl9YMa4XNjJKAwVTPKyvWnTvExhSAw9Y3c+1yb4yxjjbLNEGgH8ctdDotP1HMRNJP9hih9/VECe8vmbYBxfWE84k6a1AzQ9qXUAAKjMpYjUiTqaNT5uzYfk6PVTNvrblKsKUlL/RqucdVjfNAw3JaqykvSegp00wKAaMgqaEpeZlsIvk6seaynu01bUKUy/U9TDudX3/+8q7jpGoP79+++1uvkxEH+nrGJmy23j+6BbxrLh5BVs602x83AN/BmY3wrXJzPWCdKwThAeHnTovcweZ0/Fgi4ef6LcHD3uaP7+11AAIzBm5ZSNhs80UQ/3pA2q7V/Dw7EcvsttYppSDkfc7ddmMrn7Zp9+O5BBSI+etsHTA+xQCMkSm3qVhLwNRgFLIUrw8vF3M/BnAyr9src5uBNOYGaCx2C1HwRBUtnuLmnNUTNOLf6XZDXt7xYm7leU86dhNMJiSce/U4/Ef3/F+xhEydlJDEBEh3g1Hzkt9Oi0V8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42865cba-1838-4cb4-5997-08dc946537b7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6111.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:49:23.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +t3vVeJaS+7BvK+TFeCq3JBXi+fb0oWfdwC9ZpGp4q7XXAldz/HYa6wjK9HIUZeO2lKPFLK5W7UQExlXfg0LETqoYEFkpGiifr+uij6yr6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_12,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406240126
X-Proofpoint-GUID: hABoQ1StT9l7Vu3BXl7eS7aT8Yh5grt7
X-Proofpoint-ORIG-GUID: hABoQ1StT9l7Vu3BXl7eS7aT8Yh5grt7


On 6/24/24 15:27, Leon Romanovsky wrote:
> On Wed, Jun 19, 2024 at 06:58:27PM +0530, Anand Khoje wrote:
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
>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>> ---
>> Changes in v4:
>>    - Fixed a nit in patch subject.
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> index dcf58ef..06eee3a 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> @@ -608,6 +608,7 @@ enum {
>>   	RELEASE_ALL_PAGES_MASK = 0x4000,
>>   };
>>   
>> +#define MAX_RECLAIM_NPAGES -50000
>>   static int req_pages_handler(struct notifier_block *nb,
>>   			     unsigned long type, void *data)
>>   {
>> @@ -639,9 +640,13 @@ static int req_pages_handler(struct notifier_block *nb,
>>   
>>   	req->dev = dev;
>>   	req->func_id = func_id;
>> -	req->npages = npages;
>>   	req->ec_function = ec_function;
>>   	req->release_all = release_all;
>> +	if (npages < MAX_RECLAIM_NPAGES)
>> +		req->npages = MAX_RECLAIM_NPAGES;
>> +	else
>> +		req->npages = npages;
>> +
> BTW, this can be written as:
> 	req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
>
> Thanks
>
Hi Leon,

Thanks for the suggestion. I have sent a v5 with this change.

-Anand

>>   	INIT_WORK(&req->work, pages_work_handler);
>>   	queue_work(dev->priv.pg_wq, &req->work);
>>   	return NOTIFY_OK;
>> -- 
>> 1.8.3.1
>>

