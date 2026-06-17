Return-Path: <linux-rdma+bounces-22325-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U66YMgvOMmq95gUAu9opvQ
	(envelope-from <linux-rdma+bounces-22325-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 18:40:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2F869B704
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 18:40:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=sa+b31pJ;
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=BBwNIpUJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22325-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22325-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DED9324ED9E
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544544B8DDE;
	Wed, 17 Jun 2026 16:29:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDBE4A1393;
	Wed, 17 Jun 2026 16:29:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713759; cv=fail; b=CiWFP2o4XHhKBUGFBtosNPemk7nihVD0r2MGZxpCELeQKhzJADaR25EJWc52HZ9IdSl68wff935jkdbavZy+0Vq+bSnyHhvIzy3pSwzVyKxhHbEGyBMpWfNtw55PNxbHfMgacOQTC1Yyuje+hmVL9thGBs0pqf2nhotH7Lk7q60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713759; c=relaxed/simple;
	bh=2cSTIfQmrQAC65cC9F7XYlrYstvrhhqk9snA0mb8BXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VRSGIExqJgX1kV3PhWNTca4nfONWdcBrbsIEPgLP9TCEjVD9BZBJ/gv7Vg1077gCzAVypjWZ9Z0mDTImvwI4wT5Jk3X9vpL3hk0+V7ZeOkY25mI0dhMhAokMaXxsZ+fHgrjq2yv8iI+RkaAVILVGfrId3qpnisF4uhSSe3il65k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sa+b31pJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BBwNIpUJ; arc=fail smtp.client-ip=205.220.165.32
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEsBLp2480845;
	Wed, 17 Jun 2026 16:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cjnBCcU7EAqgmGFZBwFak0X1cC56dlQ3bIwPlJAgcjw=; b=
	sa+b31pJ6wTUsQPCoGh6Y+hxrxAl0v7vIAp8XdWtQUIwtt/xTzfnpWU8CQkaNagb
	npfDPxCtoWTgJfSudUry42LzTq5jeKPsGuLK5qRGHKFbl2/e2mcBdGTaUur9r01e
	RVV/AI1JtDqa7GVxGecvEuC9Tkhz+i78XJj49Kf0eCCITJ4rOYXhtB8Wq8I/se8M
	OxrUXyMeHFRoZ/vAopsvmS761002rr63hT4T814b7JaAu6pMqK46DNZggicjMy3s
	z9ZQYGQVyqdPbr0da/bjh4pw38c3luduD8HQIwbGlyUYBSp3KP0TaUoJzW/b06ID
	aJCRzdRe98bJDmcEtZSzHQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eueg2h9da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 16:29:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65HGSa54015382;
	Wed, 17 Jun 2026 16:28:59 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4eudvbq06g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 16:28:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLDD8zxeaVj8paJkxHRbCvqMbjs4A7nTAn3/Td4l9YiJWNCEhAXu6tmHR0tzIlzoouCfv51EsEzZpZhJlCVxSyOP4tRAVbZrlZn0T+bziE7O4VL8ghSCHnM2XWTLdEuxaFYbnbd/DV5NpdQIIT3JH7ipE4FIfzruh8xm7M6PEeEb+uOKZCvvuBdXLLm3izu+pO/+qafV3oKY/X0ms9l9nxheZrFD8q5i8+ide7Om4u8j1QT+yY6iqpLsXpMGAsGyrQtl/MiluxzRYaWPODELRCM3XN56ThnxoX3Ay2uiO7TKI/Alt8/IRgHq7jATx7CXdhlY28PeY28aiMTzCSUx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjnBCcU7EAqgmGFZBwFak0X1cC56dlQ3bIwPlJAgcjw=;
 b=yVWfVEjqaj2w1Fx5OKoQM8dJEYOvWvAV8to7XHKYo7XyWfZoQ/7avY/BH1DRVzumzCG9a43wkk/lGNMxeRUPSdZOijY5wf14Ru8UWeFddz2yrtbSd6ewN2SkpDBaSFGJEhB27W/c+m3SgwUf2ATYp3/vcEOpmxcjPZpE6XyRjMAvVJrEOeVR7Ue4m9e3RJFvKwJxL+qBlmx9M48j/iWVgbW7YqPvXiYVpibr05TXRjYIabDXcRH7WH85whNdL51IvGDfn59ST8QRE2Hk6ie7xPdaHfMMjaV4uGPmF0C0sqZnhLkolHzLfJur3o0X3zdFmyAFqJhWKvuGYR7sygmCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjnBCcU7EAqgmGFZBwFak0X1cC56dlQ3bIwPlJAgcjw=;
 b=BBwNIpUJA1LUHGGuLblOAPt/2+auF5wnASlaHMLyb9PmuTGEJ1XQ/hCW4wv9XKtRVDaDhzWGcFYoCZ7q0ZCU8pScrhU7nJusCoR8kh9x70QNoOLFkTHkEBUy0AUB6EsiCtdsh0hPj47RKKzk/sWO0IH78haHlYFEy+lkB0rUfEk=
Received: from LV3PR10MB7796.namprd10.prod.outlook.com (2603:10b6:408:1ae::6)
 by LV8PR10MB7800.namprd10.prod.outlook.com (2603:10b6:408:1f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 16:28:55 +0000
Received: from LV3PR10MB7796.namprd10.prod.outlook.com
 ([fe80::a30e:ee88:c7b4:c0d8]) by LV3PR10MB7796.namprd10.prod.outlook.com
 ([fe80::a30e:ee88:c7b4:c0d8%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 16:28:55 +0000
Message-ID: <381053a1-170e-49f9-bd33-c5ecf6015504@oracle.com>
Date: Wed, 17 Jun 2026 09:28:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Use sender devcom for MPV master-up
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260610173915.4053423-1-manjunath.b.patil@oracle.com>
Content-Language: en-US
From: manjunath.b.patil@oracle.com
In-Reply-To: <20260610173915.4053423-1-manjunath.b.patil@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH1PEPF000132E5.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::25) To LV3PR10MB7796.namprd10.prod.outlook.com
 (2603:10b6:408:1ae::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7796:EE_|LV8PR10MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 3684076a-34b6-4eb7-bc71-08decc8d8658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GEpPau292yi4Dt61YG7L6jmuKF05MJi6Zg7ZDhk+c6R4Nz3VIaoCOlm//LlQOmd4bcKbIVR9S4EPQO5Kn0KmyJCuIdPIRU9aX/BIFPC7PoVMm2z8C/MZoTA7yJMorvNXicjQWqeFiy0EHa5wwjf+RpsGlFuXlH2h6YVRugdUybbKBnACI/RUuk/XTcMVnctk54qWdKsLBEKcGe0AWEeOFV1bH8JPty3RE3XndiRLlR89AzU/a+VwhMMM1N+mBTjBEznBdyaSXmt9PWKjD/jRcqsITAZrOkf93jfGLYscUpieBfDSmkBSR8YunVH0giQeP1osKcJZr8yJbPd05/PunsFYvRTuKegISPFenoJq2Exg/8K96Qe5w9V7m6YfkfEIsPW6n2CM+HA2DFSQpc9FhWC4uxTr+S0qx2msLx7vUKE9slXShA2BuTGp5Jyuv0KA6KiCTksUpXiZMCN/pdAYCK1QPtQRcrNNO/9kMV9t1bUZ+SKQ6w0RJWR5p5wO/+EKXq9iiYvjZ2MHZRXHpn1cLSKmVwIteYinHeA6JGd8jjr3oJb0rEE7Gm6tvpKE2UebGnm/9nH83e/ZyrTMOb6Vdjf5Qe25HUeq5kcDs2kwyI5yfbN74w/dCpTtHZRiHGDU2Xn8go+yNTjIkw9Z3iec+vClgT7hPqgLLi9e3FQWVRLmXk4bA8vI5fiheeL4SddB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7796.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW5qZllaeitqQVhzNHUrcXVCQk11U2xvdGpTUm15MVFGcDF5clVKR0YzaXlt?=
 =?utf-8?B?Z2k4NUFlS2llNUpKSlpKcEtaR3gvZEI5c20vaEZjZW9US2hWNG0zMTcvRmVD?=
 =?utf-8?B?TTI1eHRiNGZ1cjV4bEJLeFZiVkxsbWQ5VU5STFpMbUhzdGpwaTZUR1pzWmhD?=
 =?utf-8?B?NG9FQUxTUlVWVlROdVhxaEYxbG1EQ0U4Q0VMZFVMbDF2VEd0a01uazE3T1Uz?=
 =?utf-8?B?ckc1SzZBTE1vSTdsbzIzTm4vOTJVTHdNZnZMeWN5UWdhYkxUQWE5QW16ZEVE?=
 =?utf-8?B?V0VDMk9QbUxzVVNEalRkcEJNZHRSaUFqMW9rSFd2WFE3SDdqcUh4akxPNG9u?=
 =?utf-8?B?YXJhbmE5ZG1ldEwrVFNHVEJmdktIdWxmbG1GVXN0RzNSMTRLcG4zU2E2RUV3?=
 =?utf-8?B?N0JqMzRLeWNaQTdnNm9uN0NKM2I0alFDTG9sc3RZNGxpZWo2a3d0cVMvK3Ur?=
 =?utf-8?B?NjJyTWVXOWdqejdGd1NiT01uOU4xV1FVQjMzYmlKU3k5K2NGNDF1azVrUW8x?=
 =?utf-8?B?bE9VRm1QUFVKYmU3MmlDc1NGN3BWeEZUa2tHYkFYU3FWbGFUMnBNMlgwOEt1?=
 =?utf-8?B?YkppZzZKd0Jzb014RDdMWmk1RjVzWWVyTzUvYzdZY2dCV1VFeDlIbDIzM1hh?=
 =?utf-8?B?cHF6ZXNMMTBQMXpWS3FZVEdkWUFkaytRZGs0a0lyUURwMHpjODlhL3VzVktp?=
 =?utf-8?B?TnhLZXNtdG9BWjUwOVd2SmFrVFpPclFUYlBvQmdyOGdpUWErTFRyT0JJOElE?=
 =?utf-8?B?aHdTNW5yc3V1WGRBNHVwd09mZDdaT21TQy92ZU5LalJSZ0laeXZTaU1uMFNt?=
 =?utf-8?B?S1BVL0xEd2craTA4L1ZvalZNaVg4MVhpSEc2RnVHbC8vZWVJdTBYUGJkTnk0?=
 =?utf-8?B?VFh6RzI5SDRpRktMVWtpWHVPSzZjV3E1NjA4TWVIa2NVcldCM0hzN3pQNjd3?=
 =?utf-8?B?UC8wdmdkQjZsMlJ2eVA3T0tKRDFQeTJieXltblNtRjJ3VFJtOFF4ay9sQTlz?=
 =?utf-8?B?QStNUjBWVGdEM210VmxmVWhuVmhKc2VqdkhNZXZBMGNYYkRrMWMycUQrNEtL?=
 =?utf-8?B?SFp6cVV4WVhsK041MVgzUFVTNW1qNlZxbTNqNTcvNUt6S21MS1hCSzVsMUtB?=
 =?utf-8?B?cms4Z2g5cEtUaGpLNGdEdnU1bW5oWHJmbXNMYWZOL2M2NG0wL1h6NExVVkxD?=
 =?utf-8?B?WE9WK1E3REZDczNMaXQrR0VvQ0djbFFLOFFROElqbkRMR1Q0N0VEY01MZVE2?=
 =?utf-8?B?VkttRkVFcUd2NTN3bUpyZER2U3MybjJuQ0h0Q21HbXJpeXpMWW9FSy9zd28v?=
 =?utf-8?B?eXArOFBWaUQ2SkZCL2ovVjRhQlNabzhML0s4VDZ6NEllS0wvRmUxUGNNV0V5?=
 =?utf-8?B?dFVVbGpPOU5mazUvVUJyM1pwR0RITVdIMGQzeVNRNHZOQkF6aUtBdVcrdzEy?=
 =?utf-8?B?VmJiTFcwSERGbWZZMjZudmJrODJoanorS2NaUG1IQTIybkp4Zk94R01tQ1ky?=
 =?utf-8?B?UzE4V0VNZ0ROTHJBQTNibTVtdWhRZzRXeW1GQUFzSkZMd25WblRwQWRaQmtI?=
 =?utf-8?B?TVZJd2JYQnAzelZTZDdqQXE0YXlNMVQ3L0pScTRDY3I4eVlLSDZ5Q2puZndt?=
 =?utf-8?B?TWV6RXl0Y0RabFZFTHlodW9VRmNPVDJUQmd1K25oUm1QZmtXQXFqclU3T2x5?=
 =?utf-8?B?eXJtUFhRWjZOTGJsR21wNHNFYzdmc3ArY3NPTVRNUTVzbHBteTRsdGRRVER1?=
 =?utf-8?B?OUovNWxrdmxlWURpSHRkTDZFcUJGYWU4UW5vTjhzRWJJRFZmdC9qdk5Rekt4?=
 =?utf-8?B?cjhkWitncGVRTXNFRG5VM0tSaDVCUzF1RjhHQ0pDcnoxTXpwaGZJenp3cXow?=
 =?utf-8?B?MHNRRFNYYnRSeWJWRlBMbmRVYTBuTWpHanQ1bjVndXovYTNFYmJCeXVSWmRO?=
 =?utf-8?B?dVUrSDQvVGs5NWFuUFZXOEcyckJJc2ppc3M2SGNnSDQ1a3d2U2FOMXpYSWd5?=
 =?utf-8?B?bzJ1L09mRUhsSTZKVUpOL1h0RUJseGpkMjAzRHl2dWpHV0hhb0VNcjQyWGdW?=
 =?utf-8?B?MVBqSjJDWTd2a0J1d3hpb0h6c2FxT0pLL1YvWk15aVpzVUQrUlNRbmdUektF?=
 =?utf-8?B?WUgycHZBRjVXQU8vUVZaRjU2ZmFqQmZRVGM0ZlFTK2N4U1UvcERDdW9XOEds?=
 =?utf-8?B?SGQrMkJCUndxMk9CRHBiQVYrcEdEblJFNGt3ajFPU1g3eXJFaEpmTmwvK1F0?=
 =?utf-8?B?MHUvdmFod1Z4V2dkLzF6b01WZWkrR3BVNks4aGo0Kzg3Q2haN1lQQ01DVFhv?=
 =?utf-8?B?djlKT094T2hsT2k0RDhML2RLMUdDM1V1aCtqc3kzMCs0bUlJM0dTRFFDc1Rq?=
 =?utf-8?Q?hdWjbvgfjnRZxX6k=3D?=
X-Exchange-RoutingPolicyChecked:
	DfkOPqvCwSm2P+nG95V8C7NYQWxkh7f+pJwaddKit6r5WhgbqE4yp8c5bV2OjChUwKMeMPjgI2iZm+Q/GOx6ox7G16t3gLxX+5AgLd3GUF9ge3PGmOxeme1TMsXCdRoVqHlm0fT7kO6qgrnJ27VI7MIJn2LVBfKdLmyi6QPK2m53Tp/iPXLrKPib30d3eOEjqveL2vis9K2THxEf2qGmTgw3Z3a/JUr8htxbhg1CGC8qD3WWf41/Pym13qm9LxPfHtb0Fa2zs1jeb8+awxnBr642u2c4rgOtZ04iVzY9cDIyMg88XwpDHQ5DL0/nZIxmh2UqHofMvAvWCD7hrj1aBA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TEWN+mS7MoKPoEbHO6ZiIjmxKja3Gq8ecWIRaiMzJFSbrwYhTRSIopqTfMF6/fnzS0aD4Ym2+v6AHflCL2jb5xLaD2lA7cKKzngzmuyVtvTcfJ3gGDKKbx3dW5iLBojN56cRgcpMTLVBf4Ut504TDJ7zUj8xCkLQm1Kr2PTGaO5IZt4HjAmKoyLWKXToo+5etbewA0s3zhsQsIk0Iy+FoQd3XLdWfEV0v2Q5cg3kVJ0j6qHfty5OFigUDmsUn8Y7or2tmoRhO6Y60j6Vr8v2DNdPx91x71cCIF4/5DQxJmZYvnYL6ku3cho/Q68XUc65n3RT4vyb4TSXprNsLzjNn0ygNv69+gMgl8lfjuMn4L1RlcCYuqQK5KM/XxOuiWq2Ggd6fT3Iq0ii0bgo6KjEOdJ2ZEhtyKrlzuuTzpmeoXfWkMtyO96UjFE5UgV6pqPadZ+I2RRG+Nx0FQD8AjeOoElTbLV0p2qT1rVtTbmA9A/CFqdsM5NGaeS+eDUHlDndIvBjd5pdn5kV8UFnm2wWjhcUyQD+7tncFXh/sI+F9mMUerhBiezuEQFdyZnYJsySl5uZunfhSMjf1I8ErJ0XxfaJ2KxwbhM89TtrrpgLOJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3684076a-34b6-4eb7-bc71-08decc8d8658
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7796.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 16:28:55.1267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQxihK9JPuoNwQmmN29/TOdA2dO9DN+6FvUYAS22gpqLzjxmVkIbWFcqryjtKoF+gkEug8jtw87JvuGRje24HYptR8vsCRifXTPW4vEkh7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606150000
 definitions=main-2606170158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1OCBTYWx0ZWRfX/4d7JArjVLEO
 4xXFI2iYxVqU5PraeUclsqLYKi988wRgXBAia+6k8pD2ewsE8Parn+Kr8vx3WLelE4UGzWw+tzB
 N19PH2CqrN9YpCeq9AloKsySFmzL0IvXLSYekIG1ijUqbmVHnFiomCEYnn0PLZFlsy/rwp2yjEB
 JZltUHkZZYZ2Y9LUxJr6KZ1dbpm3vFT/uW4bbNUs5zKXSBuvVvYDTaVFt7Bg2SLBnkrUpvBwC7x
 mE4ZqsncA6jSI8PiWy/HiTtPrsU99w7cLi5h3K3rOZGFeZ+KNjsDLUmZtNyr2j9ljTtxszXd6a0
 9CHHSNReZbouPlMfq4TSilukc7vyVIPUs0cj96/y7gf0/aKsOt4sbdv6FDxkL+fwIsHetkNwWNI
 pG3VVVE784UZl1YwVTlVJaLN96FXk5dB6WHroHeLjVHLA5SQtlPK9LgizJYBTVtBnmREO32f3ma
 /vr57AEBRModuiUC8U3v6SIQEu8kRqQpXv2RzxZM=
X-Proofpoint-GUID: 4UOrwqVLWPGVv__ngMH-Ip0A5jpVZGeZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1OCBTYWx0ZWRfX9ztjNMfwwPhz
 G7S8AB4VrM3gTxpPuOm7Jmp3IQ1/Al/IUhhpdT1P+Ce5gOoJqPhOvEl5Os3z3vcd6OzXR0fik5P
 gcjxjQBoqmg4CkQNFBFjBZKqtbNz19s6fvB8sjFK5u2UfDvNIbX3
X-Proofpoint-ORIG-GUID: 4UOrwqVLWPGVv__ngMH-Ip0A5jpVZGeZ
X-Authority-Analysis: v=2.4 cv=UY1hjqSN c=1 sm=1 tr=0 ts=6a32cb4c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=mFMaEtM4fb1k09oPAg8A:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22325-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:phaddad@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:email,oracle.com:mid,oracle.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B2F869B704


On 6/10/26 10:39 AM, Manjunath Patil wrote:
> After PCIe DPC recovery, mlx5 reloads the affected functions and
> replays multiport affiliation events. In the reported failure, the
> first relevant device error was:
> 
>    pcieport 0000:10:01.1: DPC: containment event
>    pcieport 0000:10:01.1: PCIe Bus Error: severity=Uncorrected (Fatal)
>    pcieport 0000:10:01.1:    [ 5] SDES                   (First)
> 
> mlx5 recovered the PCI functions and resumed 0000:11:00.1. During
> that resume, RDMA multiport binding replayed
> MLX5_DRIVER_EVENT_AFFILIATION_DONE and mlx5e sent
> MPV_DEVCOM_MASTER_UP. The host then panicked with:
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000010
>    RIP: mlx5_devcom_comp_set_ready+0x5/0x40 [mlx5_core]
>    RDI: 0000000000000000
> 
> Call trace included:
> 
>    mlx5_devcom_comp_set_ready
>    mlx5e_devcom_event_mpv
>    mlx5_devcom_send_event
>    mlx5_ib_bind_slave_port
>    mlx5r_mp_probe
>    mlx5_pci_resume
> 
> MPV devcom registration publishes mlx5e private data to the component
> peer list before mlx5e_devcom_init_mpv() stores the returned component
> device in priv->devcom. A concurrent master-up event can therefore
> reach a peer whose private data is visible but whose priv->devcom
> backpointer is still NULL.
> 
> MPV_DEVCOM_MASTER_UP already carries the sender/master mlx5e private
> data as event_data. The ready bit is stored on the shared devcom
> component, not on an individual peer. Use the sender devcom when
> marking the MPV component ready.
> 
> This preserves the readiness transition while avoiding a NULL
> dereference of the peer devcom pointer during affiliation replay after
> PCI error recovery.
> 
> Fixes: bf11485f8419 ("net/mlx5: Register mlx5e priv to devcom in MPV mode")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> Cc: stable@vger.kernel.org # 6.7+
> ---
Ping!

-Manjunath
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 8f2b3abe0092..f7ff20b97e8c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -211,11 +211,14 @@ static void mlx5e_disable_async_events(struct mlx5e_priv *priv)
>   
>   static int mlx5e_devcom_event_mpv(int event, void *my_data, void *event_data)
>   {
> -	struct mlx5e_priv *slave_priv = my_data;
> +	struct mlx5e_priv *master_priv = event_data;
>   
>   	switch (event) {
>   	case MPV_DEVCOM_MASTER_UP:
> -		mlx5_devcom_comp_set_ready(slave_priv->devcom, true);
> +		if (!master_priv || !master_priv->devcom)
> +			return -EINVAL;
> +
> +		mlx5_devcom_comp_set_ready(master_priv->devcom, true);
>   		break;
>   	case MPV_DEVCOM_MASTER_DOWN:
>   		/* no need for comp set ready false since we unregister after


