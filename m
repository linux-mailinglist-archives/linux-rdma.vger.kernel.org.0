Return-Path: <linux-rdma+bounces-9308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C040CA82CAB
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 18:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7793D44353E
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B241D5ADE;
	Wed,  9 Apr 2025 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AUJ8lvkN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rhp0oobU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392326FA78;
	Wed,  9 Apr 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216788; cv=fail; b=dp/sI8n0RZLyy54FEyAuArLVDSBTsiaZ8zB0ptihtgjC5f+6fXmDBjhaW3Oi3m+CApKfu2Nt0AsLcloM/8XrJSUGw/FpquNLoHBq8yuPr2YZyDXNzvAnmjWDo9lFkTuR74QCSbZyaI0rJYARQ3ZnR4pzooxPaJaljRSk4tjEPVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216788; c=relaxed/simple;
	bh=8NVMQIPsyrZzkw4ujUcqzZGwktQbWWj9BN9WxK4I3iQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pkp+a8IgJnqOmiSsV5PE1jnR3HEVJN3AXyiV6V3uhPTGMoNdl2Oksb/uKLPQplKmfGoHDgU8cKyTjcz7omAJaoZTqvYaJp59n2S/+aXh5kWlQqrjO7p0IC1NZ3AwrvfvPjruRd3IopspcTQ5Lly/x2r+8ouWukuWY26r2DC/jHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AUJ8lvkN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rhp0oobU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539GMs4T007577;
	Wed, 9 Apr 2025 16:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sQnRPZiG8RL7eCOK/RefSdwgWFEeFOGVTime/n6nCqU=; b=
	AUJ8lvkNr1j01nsQKFfeU8EpiyHyEBhRJMektZtOFV/w0rY5PuvEGHdLd8p3fzHH
	+xy3zOncN/n+G8On2I6sp29G0ge3UsBm1ZY8RXfyBxQ53U6mHrk/VQ4k8hlZKmSe
	ERRShD8I5wsrrWuf6XsccdeD5tTp0xEm3Z+zkEdGhKQcNWFRNLYrovjuT2JhQFh0
	zYKERMeLT1ahkSHbEmzLQZ90cZuabGHRqJJcVkaBW4Gu1roGoiwUC3TjYpum5cub
	P7VHow2iZC58IjDLLloDpXLeWh041kRmsghhsGg7r4qllnMqbrpdw6Jgd3MvT1Uk
	gagmRozyzkKumuo4FhHSzg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tua2ymu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 16:39:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539Fjw6f013717;
	Wed, 9 Apr 2025 16:39:41 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011030.outbound.protection.outlook.com [40.93.14.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyhc2v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 16:39:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaWr4RJPSxqJmq/cMNzWiVJ44yn8Q3iXOJVcCzkUaChJq0hEQpos3Kg715ZuYQaqhQlNvjqaNTBxntYLWMss6CRyKcfKoyn1RwN9R3oIIkkGzLwGiSxSZZ2C0BzKsCyXyv+dHeFI/t8kTBmhsiHCGw44I1hHFFbf5/oqGztXFjKdMbjgsxV5i/VnrwjZgbJ+0D5/Hjzb1npuczFiODfJzmjPf4PTWg4wBe5y4MvTdMCg2pPfuIwjJeO4nRB7vQF6CTfSX+lK7yOa309yntLmCsQQ6HoZyzOqfWapN7u8UGeMhWw+QVju1j2XsPEbgGUmEV/qcRLfuAlmXHU3PSxVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQnRPZiG8RL7eCOK/RefSdwgWFEeFOGVTime/n6nCqU=;
 b=C4toWAU/j1cWM3w1ziQiOOrBrIQPXO1pcj2uGzqCldE7JeR9u6yUGsX6Ko3FrijlNvPHIv8f356LkHCohuu7xtWPRUUILXI9RTfWznciQeZrEhkBY+iqAjdpBgEfFrkiq4SVwbyQRgxC9lMDRL38WqiY9FnqCFhw2RJhKiyDoUJPo22ywQS30u5BC4zfbp+plqssUlcbLHjZee25fmP07l71AjXw67rOWoWdFeLIinDycguU62M7tqhWf/hpPJe+qxSqzAmoDHQn5lM60cjmw/p0vHnaNsy5tptohCm5n+LE53nlsXodlWiwsFh2MOBpYSip9jy2zQ4i4l730nZsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQnRPZiG8RL7eCOK/RefSdwgWFEeFOGVTime/n6nCqU=;
 b=Rhp0oobUsoOWavRuk/nwtUVUyzICH21dFR7h8Mu77sOAzK4fKl+HlJNNnOK2TgFtcaM4IHNx6KVStbGzoHLVnR5312PPrzeZSHNFuNAfMClw+Hnu+TbxpTdRV7HRsi29qA4qNHM1vl6a5dMoeO8efc8aLWlSXyuVVKQrB8eVya4=
Received: from SJ2PR10MB6962.namprd10.prod.outlook.com (2603:10b6:a03:4d1::13)
 by BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 16:39:38 +0000
Received: from SJ2PR10MB6962.namprd10.prod.outlook.com
 ([fe80::c588:aef6:a2e5:9ccb]) by SJ2PR10MB6962.namprd10.prod.outlook.com
 ([fe80::c588:aef6:a2e5:9ccb%4]) with mapi id 15.20.8606.035; Wed, 9 Apr 2025
 16:39:38 +0000
Message-ID: <e147d7c5-1acf-495c-8d42-298b025b7a00@oracle.com>
Date: Wed, 9 Apr 2025 09:39:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/cma: Fix workqueue crash in
 cma_netevent_work_handler
To: Leon Romanovsky <leon@kernel.org>, jgg@ziepe.ca, phaddad@nvidia.com,
        markzhang@nvidia.com
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, haakon.bugge@oracle.com,
        aron.silverton@oracle.com
References: <bf0082f9-5b25-4593-92c6-d130aa8ba439@oracle.com>
 <174419763484.373763.12978802764991350026.b4-ty@kernel.org>
Content-Language: en-US
From: Sharath Srinivasan <sharath.srinivasan@oracle.com>
In-Reply-To: <174419763484.373763.12978802764991350026.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0077.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::17) To SJ2PR10MB6962.namprd10.prod.outlook.com
 (2603:10b6:a03:4d1::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB6962:EE_|BN0PR10MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: dca59aa0-618d-4833-800c-08dd77851df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STRSL3FweStFSjZyNE15Z09PaDhRRG01RElqOHN1c0lzZXpVaWNiMHJQcnFu?=
 =?utf-8?B?ZnRYRnRrRXJXVVNJeXZKRkV3dHp0L0dybWEzdzNacjNuY01Najh4dkZER2x2?=
 =?utf-8?B?R0gyN1duVE1DaklEZU5LV1lWeXkrR0tIc29mNytIUVNoQytFdFUyV2d0ZERC?=
 =?utf-8?B?NUZSSnFSM3dqbWluQ1Fpc2JkNzZlRENoODJtRW5YYWtEQXpFN09TVUM1QW9l?=
 =?utf-8?B?dkh1dnRSOUJGdlpSS0k4OWhORW9UNjNUNUtYclZrMFN1S0VleDZMQ2dDMS9i?=
 =?utf-8?B?S1RNeitYN0hpUGNidHVPM09jMFk1QVZldGoxaE92TVV0RzRKb3NaVjVwQ2lZ?=
 =?utf-8?B?OS9tVldMZUVoUENjMTgvUWZhT0hVcTEvSE1OMXRLRDVXVXg0QmtJTUpYYWRE?=
 =?utf-8?B?b0plK2pOR2hOSDRGSEdhUDkxaW0zUkpPQ2tDbldPQ1dFd3d1dWdJWVlReGhW?=
 =?utf-8?B?ak1zdmxuWW5XU25QZE85WXRMUkZZOEF6RzlKaDAvcEZ6c2pTMlJ4MzI3WUFW?=
 =?utf-8?B?bkh2OWU4VkhxQXhnUDRlclJROVJPT2FSbnpYWHdySU9ueUxxd3g0UE9CVWRV?=
 =?utf-8?B?M2w3RDJYbU9UZE9MMG42SDhEc3ZNcVY5ckFYVlh5dXZBdnFwL3FpM0w0cVNJ?=
 =?utf-8?B?R2NwMmp1eWg2T01YdE83ZG5wZXI1aUtzL3hqZXZOWG9pNUlTNzdYUlF6SkJy?=
 =?utf-8?B?MHJvTEp5ZXRsK0t2L1I0WWp1L3Nwb3VhWEVQMDlwdXovT3ZzWENDdng5UEY4?=
 =?utf-8?B?WlJyYUd1aHp2d0VVQ3pSb1FhWWh6bEtlOXdER2dVV1VkNnJ5dS94cnFlV1dC?=
 =?utf-8?B?WDdwUTQrVG5jZHhZc2NsWW1Sa0k5SEpaczgxbGtHVFVyaWhFV3ppaE9LMlRs?=
 =?utf-8?B?cGNXb3FObkpxTkhkbk5TbDVKV3FuVUwrb3dBVlFTbFdZMDgvR2dWdldqU3R6?=
 =?utf-8?B?US9GZTR5c05NZ2VIbldIaWZ1S0lsUlVWRElVZ3B0R0l6UVdHQmxBWUZHVzdL?=
 =?utf-8?B?eFJpWTNKbi9IYzhldnFTamR3bVM3RFVhQUpzWkU2TUJEejZRalo2QTJtL202?=
 =?utf-8?B?WTN2TEhFYTZJbjg5bTQ0TUVTQ2dsZURKYUMxMmN0ZHB4V3JucDlRaEFobjRL?=
 =?utf-8?B?RVFZT3ExcHpMb1ZoNnpFYUtJOVZwQkt3c1dYTDhGNkxBUFl4UGduM2x2UzlT?=
 =?utf-8?B?OXdvSm9CZldid3ZnOTBKM3lGMTRqKzV4a1FrVmxmTVZYUnFVYnFsbndSYWRT?=
 =?utf-8?B?cGVLNUI4bzZNUFY2a0ZqUGVpOC95WFlUeG1XM3VENVZCQ05DeVpCN1pzbE4z?=
 =?utf-8?B?MHJRTmtkV1BZUmxlYk5VNzNsdnZwcFhrWlEyTzVZTzJsWlB2ajIyaGpYbVhV?=
 =?utf-8?B?NWY3QW8reHhOV0Fyd0RSZFlMQldKNVZTOVVhbVpTSzdOOWZRb2pLaDlXdnBW?=
 =?utf-8?B?ejBBL3hqZnZJbDFuTFRLWXI4SkxwT2ozbWJrSkQxQ1ZRRC8zUHhTMXB4ODhZ?=
 =?utf-8?B?a0dKMWQ0Z2Z3Y20rV0lTRkRURGRwUDFqeE9yQVNTbFYzalhkZUk0b21yazdD?=
 =?utf-8?B?L3g0eVR5ZzZJaDFIelJWWnlyRm14WEhnK3BIS0g5M05wbWNUdXpGTWxGMXdu?=
 =?utf-8?B?ZXZlaVdXeUJEaG1BKzcvK0VsQzlFRU5mRGVZUnBPdHROVjJBOVkvNmNzbTUw?=
 =?utf-8?B?c21CN1FVV0N5RnBvNHFuT0cxdTQzR0kvdklCNjdMazMxVUZxUDNQZGtrNzVl?=
 =?utf-8?B?MkJLUzREY0Y4MThEdzJ0SmlvQ2lNS29TN21NRmE5aTJwOG5vd0pxSE1nS05W?=
 =?utf-8?B?WGNGd2dSM0xTZ2UwTkYyN0xoTy9SQVAwTkdTUTdaNi9HRUkxNDYzd3ZzdnIr?=
 =?utf-8?Q?NxoQVImUYyG48?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB6962.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1l5QndWTHB2djVBUy9ubHB6Nit5TUJpeWZEMHpwWFZiaVptVzRIeHRVb2Zt?=
 =?utf-8?B?UTZLdjVnN01pZ1ZvM2dWOE1TVy9iQmF5VGQ2dWJNZkQ0UlpWcForNFYvY0ph?=
 =?utf-8?B?QlZGUzl4bHB6d0xmSFE5bS9hRldKVzZDQjQ3dG1zWnByS1Q4OUEzYkl4TFVG?=
 =?utf-8?B?RlpBbFBoVWduWWVZTXE3YzFpSHpyTjJIdTdwSEcrRW1aM3FvYWNiVVpjOGhn?=
 =?utf-8?B?amdVL3VObFNOWTBzWjdOd1dDL1FYT01DZVBkeE5FQTNWdmdMaGJUM0ZlejVt?=
 =?utf-8?B?VGhOU1NWUlBXcWgrRzBXZmRLWlVpZjVaSy9YWFJaMWQ2OVp3MU1ZR2l0dldG?=
 =?utf-8?B?alNneTkwUE5zNnJJWnl3YmJsZDhTR2o5RW1DYmlwSWprYWVWUnJoaVl1OVFv?=
 =?utf-8?B?aXpZR1JENEpCOEk1ZVRiMU1pQWI0eWpsZURuTkdyOGVXRVc1TC9mOGJvVHl5?=
 =?utf-8?B?NVBLTjFGaGhDTjdWbEYrbHhERzVSUDV3WVhZRmFTdFpWOWdDS2w3UnBxb2Y4?=
 =?utf-8?B?VW9nOWdRU1JMalBJMURVN3BHVmNuSDdkK1d5aUU5MVVjeVdhdjR4MTdEYkg2?=
 =?utf-8?B?eGJKQ3RSZDRlbDhoS2Z0SUFBRXlTRGVCNDZqR3VoZ0wyYTh4M2VoYmZDL3dp?=
 =?utf-8?B?RUtYQklkNDh3aHZBSExQMnpTY0dDUjBsUDdUdGtwTnF1ZDZheFdvWkZBUUlj?=
 =?utf-8?B?bUhDTUMyVFg1YzkwY1lrVEFLR1F0WXFMTHlna2lBRkRuREtPaXJtR3JQNVRi?=
 =?utf-8?B?a3MzaTM0K2YrV0dyVFNjZTFVMm1HakY5Q3k1RnRxdlZ0UVVJWTJVTk42ait4?=
 =?utf-8?B?dVhjaWVNMHlzM3l6SFhMcVZUKzZBenM3d1dMaDdYSmQ5RFVjbVU3bW81QnFa?=
 =?utf-8?B?Um41VE01QkNvT3VZMWZpREQrRHpXYW1DazhjMm0ya09vejZIUVppblIzTjJ3?=
 =?utf-8?B?RkIvOUxQQ3IwWXVMRUxuQWhLSUlOUlVOa2w3V2FSRGQ4T0RaK3dJMHA1WGN2?=
 =?utf-8?B?NHByeXhXMmJsdkZCQjNoTW50VTUxb0tQM3daYnc1dy96SU9QbXRzOXhkRFY4?=
 =?utf-8?B?WGpHTWlRT0NmVElFLy81UlJuWjdleDd0bVZvaTVXYkZSODJZZlRMSGd0c1hV?=
 =?utf-8?B?RE8raHgrdjdGQUYwK055V3FUNXU0dmhlRjkzMitpWS9XWGdTclNlTUM3Zitx?=
 =?utf-8?B?WkFDakVQT3l3Yk5jdTk1VWhhNGNKYmV5dmVvSjFYZnVONERGdklTb3BUSTkr?=
 =?utf-8?B?M0dMR2FOcElYQlU3S3BJVHJhbnBremNaVmNYaXNUVTA1SkJLSGIwOFphWCtN?=
 =?utf-8?B?WWMwZWJQalR5K2RZZ2ZOR21Ndk9TVitQaUNFWThLRVpoNHZIbDdDMUM1S09E?=
 =?utf-8?B?ZjcvMnR3ZitCMHdGcTJxSjNhWUxaVDNQRHM1UVIrNWxOQ1VUajlqcGlFQnBP?=
 =?utf-8?B?VGtwU2xwUUloZkVBYnV6SGlYbTJKNmJpdFRTTEJBZU9SSjJPL1hYRlZobGd2?=
 =?utf-8?B?czk4a0Rxc3FkT0JudU9ZbE5wZjdBcFAvWklUWE1XenprVFhIanBId3AxVVgy?=
 =?utf-8?B?WUFXUC85T1l4bkRNQ0JndTdPcGw4djltWDBCclV1UFhreHpMUmh1MW16MXJq?=
 =?utf-8?B?b2hOdEozZEhjL3pTWkRyV29ySmhkQmpyOTlTek5tUXhXMDRLOEFnWERHeG1q?=
 =?utf-8?B?dytWNEdBaTZxNFpvMjhlUnU0b1M4TnBlZERmWG9veHRjSjlCVW5SU25yZ0oy?=
 =?utf-8?B?c2IySDhEdXFGa0tCWGJKMDZwZGFGTUt6UTJJTUZqSEdmNk4rQjJxc3kxcnJF?=
 =?utf-8?B?VGZiNW5PU0gxZEhXcW45emFPY3NrcUpPNUxsRFBoRGFEalZseDNJaTBqenJQ?=
 =?utf-8?B?QlJEd2NFUWE2cjZDeURaMXBTNkY5RzZ0VzlHWjNuejFrcG9MOFljN0dUbG5N?=
 =?utf-8?B?WG9EdTBYNW1UWjE5cnE4U1dlNTRLa0t6S2ZpejVHUjJkZnVqeFVJaFBTMGtV?=
 =?utf-8?B?MGsrSVg3WU5wWjlIVXVCM3lCN0g3VmlTeDBNaXFLTFdZYSs2aFBHSzYzaGVz?=
 =?utf-8?B?aUpvSGpwZWovRDB3Y3pYeGJSYnVvbEhxcnNHNU5VZkNIZFZOeWxoU2I4TmRW?=
 =?utf-8?B?Q3EzcXFoWTlxS1ZHYi8rU1lCVlhRdDhkaE15c3VyRDJpK1NnRGl3MHNETUJM?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3GZiGVQE4YgRyufLBFg8xS+hl87YtmEnt+dNFACcaTWYKqj7ogRffOXKHi5KEMUJKMf/Lvp5qSqVSaMCHKe4CxDj0tPkH9AdhJLOwJt5UcfWBDS4N66/UFZYLjfAExNkLJgDvvDvS/9FkTSgNDJaThZ+Sm/K4aNmnqLk2V+tOur2CQXpWkdtQPKqd7Tfo2hXFiBdH6DxKRdPYRTjwrJNkvXGJRZZFmUqDjn5Z7hYFiT/BVY6cM/d0PIPobj8jvW3f79eRIP5/Qn8KutK8I6j+N6QpDB6h6wt1SEKeCvnDx3vY7hdJZK4ZaWXa5is1Jl9MHofWsXXzpEdpnyj4yCvQ9dGU68Rrf6Aaf2v2bzlE04HTdHlZskMrFxfPP8kRD3wAiOSk5LDkrsDkV93BatzpGjaMYxtOl4ag9OzoPCWlZRqdR4Gq9KK5b/SPJ49iY5mw3K2WnKeNPppsS/9UtceqatFIb7vNQwJB+5+Zs2SwtPebB8Yw2miAbWQj6WOhhAOPLOyx/FoAGhtlyyGQXk+D7GpbOIEDU429os+7CcEsuySpys3A9wwje9n1GTsPJgwIJnfkMwtUI4Ni6j40tzQRS8keYkAc429AJGXGqRUxqk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca59aa0-618d-4833-800c-08dd77851df3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB6962.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 16:39:37.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCvZz4Ghunmm1ixn00zyKWs5GXzqmBreim+KRAhhRjqupzpMiaN3wjYbF5qJJpsWP+rm1lUk0Q9dggeU2HW7i9VSMjwONEGP2NSL9e9ipOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090107
X-Proofpoint-GUID: U3wR13U1hWwzRfPAbEuzlpKXGkFQvzl2
X-Proofpoint-ORIG-GUID: U3wR13U1hWwzRfPAbEuzlpKXGkFQvzl2



On 2025-04-09 4:20 a.m., Leon Romanovsky wrote:
> 
> On Wed, 26 Mar 2025 14:05:32 -0700, Sharath Srinivasan wrote:
>> struct rdma_cm_id has member "struct work_struct net_work"
>> that is reused for enqueuing cma_netevent_work_handler()s
>> onto cma_wq.
>>
>> Below crash[1] can occur if more than one call to
>> cma_netevent_callback() occurs in quick succession,
>> which further enqueues cma_netevent_work_handler()s for the
>> same rdma_cm_id, overwriting any previously queued work-item(s)
>> that was just scheduled to run i.e. there is no guarantee
>> the queued work item may run between two successive calls
>> to cma_netevent_callback() and the 2nd INIT_WORK would overwrite
>> the 1st work item (for the same rdma_cm_id), despite grabbing
>> id_table_lock during enqueue.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] RDMA/cma: Fix workqueue crash in cma_netevent_work_handler
>       https://urldefense.com/v3/__https://git.kernel.org/rdma/rdma/c/052996ebc39e3e__;!!ACWV5N9M2RV99hQ!LLGepcc45JwMb6s1VnxWb4Y2hyAGH7AZaE1BoDtVREqdciSOHOIlKiu4RvKD9bL5NYAEtIMG6oVL2cU7PQ$ 
> 
> Best regards,

Thank you, Leon and Patrisious!

Best Regards,
Sharath


