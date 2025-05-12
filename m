Return-Path: <linux-rdma+bounces-10285-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E3AB2F08
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 07:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AE93B0689
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 05:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899E52550A1;
	Mon, 12 May 2025 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B13CrC9p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pH6NnWmq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26A1E2606;
	Mon, 12 May 2025 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747027817; cv=fail; b=ahTQ7Q3R9Qqmi4B/6ipZq6pUWLzw+P+yCPEEnfB6RsHln+3WFUqdrihVRgmsrhtw3trSCQP1sP9KlWCOWEoTKwyKqKZ73b7PgNcdyoGZWLvXqNrgxeVIpWr7i/n9/61J54T/3mS4n3LWmiPwRJ+DEPCMlfrsFabUtZsuxRFlwfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747027817; c=relaxed/simple;
	bh=BQTO3gLm97W6UO4W/umYWIh8A0m8rgLe232/G2WvWFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/wd3n0CUpJeJG95k+aXOjjp1rYv3g2wE59ku8iASl55OUq2Pd7NYFk0Mi1xR2lvD4rcrKbjivW+bmBbm4sAJ8Oa57HuXOj6cC72ITPOBjIFpL4QR790Ms8qtZwddh09YtS5wZJr9W9tTx3BD9dp9S0+HqraJh6wX5M8Y0t3iqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B13CrC9p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pH6NnWmq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C3Zx2q024053;
	Mon, 12 May 2025 05:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IEoT7L+TDB4wghMWhRr0zB8E4YA2U5uJ6/3AF+dR7vY=; b=
	B13CrC9pCmSXP/XzqKP6wv3DQnz1S2RBlIIq43yJoy5g7ql/BIAAq7ET1GkePPe8
	h7whjkMAjcCv0fH4QY5wHuz+Dq8nU9zBVFrcQm7GtErJkPZE/A2FIT4LFBv/xNdJ
	FSOlwhoDN+U+8QWS0LLTAfMPDwAPuJXpVXDj9MQtRoffmDAcmo0OMPy057RmPR3I
	WNN6vK7cZ/4wSXfwcBBhryOhTE51IjzcN92AbkMdiUUMVh76iF22dQ14/pHxdqUO
	qfKRvgZwahC9oP0YaqtMz7DPQILa9mtxu5fHgcg94KFDIqipN6Qfq7F1936M1XV1
	egq2++EA6uYQiiOEb4cz7g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d29pb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 05:29:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54C2clXj036207;
	Mon, 12 May 2025 05:29:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw86ybme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 05:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arM60kvJP26nNQm8ViKyGzg9D7NnJNBMTlM5MZkFNa1wv5HbW0Gfv2XDPHLNjW9jbAz5lgzb9XNl2600ETqM/9NLpDBKO6xtLtPT+h3B51zFnzzT/0a1/n8KN8BgxA4wXm1dbXiuLyWD895T0XCzGs/zggyaGiLJVzxzuAW0FF8tN3jS/8pNe4eoGo/vFdv9obn7rKIq3+0Mt+uD+ePxNNWdeMYR4aXJJxXPTw0iXGqj00Tbv4mpJCJtkqvEHuNgk2DI1qNMMqe39w75yma0bUWzOjQXDma5Oqs1JYnVW4H8Us45HMRWu8Gx7XKnbh+WD4jlu0W2t3WC52CxYD8giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEoT7L+TDB4wghMWhRr0zB8E4YA2U5uJ6/3AF+dR7vY=;
 b=yTZIAhUmIiM6faXDEe+MfYOCvTbVNmubL+StnMN+tN7kby+CLKxCkJiORCVATTee2SBcKEOP4VAguNQqhHKBxUAmDdba1SpKAVgOATf/qpC/5H0zeb6ScvxMvXaG+CQKRrGnniYgsyQ7vxt3/FlYritDYbm4bhAixNmONL+jTQsfTnGvE88/drVRbM8Yzd/LJJWKbp/P51XHNahPQ3dGNgNG/m1pMeBJrnLqLGAnEs/deh0OPQ6nBlvWzle1qJHnUv5NUMHOB1WMmjdwBGeEmrZNWyIItgIazRtncPoMgrR261P73HCJtpaypv+f8u20BvHa6XzLxIo2aRowvVa1LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEoT7L+TDB4wghMWhRr0zB8E4YA2U5uJ6/3AF+dR7vY=;
 b=pH6NnWmqiOfRD7j5vRZss8+iUmVgFoWnS/kQIQp0WAgxVgN2XtZqKZOkuHag8Q0ewdmTZzxL+snw22AiwM2XvzAlvQJXu8PMY1u9nvV/qVJ32ld1DdbcROjmG6mLx6JPD++gb8KvdaRlevmHy8zvIg0lB8VZCJoIeFs1+IupEhQ=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MW4PR10MB5864.namprd10.prod.outlook.com (2603:10b6:303:18f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Mon, 12 May
 2025 05:29:53 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Mon, 12 May 2025
 05:29:52 +0000
Message-ID: <01f27ba0-6239-4195-beda-bc3fea1a30cf@oracle.com>
Date: Mon, 12 May 2025 10:59:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v4 4/4] net: mana: Add support for auxiliary
 device servicing events
To: Konstantin Taranov <kotaranov@linux.microsoft.com>,
        kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com,
        kys@microsoft.com, edumazet@google.com, kuba@kernel.org,
        davem@davemloft.net, decui@microsoft.com, wei.liu@kernel.org,
        longli@microsoft.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <1746633545-17653-1-git-send-email-kotaranov@linux.microsoft.com>
 <1746633545-17653-5-git-send-email-kotaranov@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <1746633545-17653-5-git-send-email-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR12CA0035.namprd12.prod.outlook.com
 (2603:10b6:408:60::48) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MW4PR10MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7afb9d-10f7-403f-fc38-08dd9116055d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTErNmtTMlBNc2F4bHExMTZVcU9NUUxjYXhybEJvdGZzU29RZ2o2eVpGYXdY?=
 =?utf-8?B?RVh0RXRCZDBJd0tvbDBvYlNCRis5eTAySk5WOEsvWTR1bmxLbW1ZUWU1VFpJ?=
 =?utf-8?B?S0p5SENiUFRMam1yZ0tESmt6UC9JWHl4T0FlWGFHNm1NN01CaWE5KytFdzQw?=
 =?utf-8?B?M2hkOHdVUVloMGh6NlIxa0dtMEZtYXY2S3gyYlRZQThXbitVRTZnSGlJeDEv?=
 =?utf-8?B?VVVuMXJIUyt1SXc3UlBRRng5Sm1meWdlOG9GT252aVZBbkNIbFNxNkR4cktP?=
 =?utf-8?B?dVg2UmhTV01WYU9SdE5IaVhkZzUrM0dzOEpjR2VnV0VoZVd3SzZKZkxpajds?=
 =?utf-8?B?NlcyUnhUeGhyUGU5WDJxM2RDajZTcng4eE5EQ1Z4dm1jQW1zLy81NlBGRlJl?=
 =?utf-8?B?MkdCNGNwQ1BoZk9pQjc2Q0JQZXRCQ24vWWtPUzIwK3p0ektCblBwSmhsd1dQ?=
 =?utf-8?B?aTQxc2w1MW5hRWR0TkloUkx0TFk1cWRNTUZNSGRVbFdrWnZ3RkRLYUNSVyt4?=
 =?utf-8?B?dFd5emZpU2o4bjYxR05sazZPaHV6S1BFdDVZd2VGSWZrbHJndVVBbXdzc1BZ?=
 =?utf-8?B?eHBxb2R2cnBJMUtCNlRQcWZVamlKYVVKTHFGU2hxZUZZRm94dmN6Sng3cDkv?=
 =?utf-8?B?TEhSTmZubjY5c2NBTXJnS3BreGZDb3JWQUZLU0hoV0dzckhldzVVM3dWL0du?=
 =?utf-8?B?ZVZpQ0ZGb1VMcXpxVlZjVmtNVU5EUmI0bWpXdHIwYWJtUTdCQ0VXc0FTR0V4?=
 =?utf-8?B?OWhDdkNQNk9FWUgyM2RGb25MaW1FV3VNZWFYREFiR3BtZkVUdkJCYkFIRnJv?=
 =?utf-8?B?Y1luSi9EN05qOGNlV1JBeW1MQm14WitxeDZlZzg5NXdRMTFtQmQ2OEp5dUQ5?=
 =?utf-8?B?bXEza1FOcjEwTXEvbllJRmdLbVdDM2JPZ1VPdWh1MWVnMVRWTTJyUEkvUzhF?=
 =?utf-8?B?c01leS9sTEtaeDVmS2N5emJxOWYxa0xtcnhiQkxxOFgxY29YUlZLbmFGM2FG?=
 =?utf-8?B?OVRsMUFtL2tnNHdWTGUzc3ZUZmM5RlRMZmhJQUI2TGtFd0hSZkQ3ZEZxKzds?=
 =?utf-8?B?dFZ5Q0RDTy9qeTlrSGZjQlpPUTRyRWJMRGlYSUNXZzhYMjlTVjJuWlIvcXIz?=
 =?utf-8?B?L3ViRFJPdTFCa3VBWWx3MmV1RmFwRmdPSHdTWm5wQXJORUp6dUljRktvQTdn?=
 =?utf-8?B?RmxMc2NubVZmL1ZBc2k3OTVvQTJGZVRmeHpPNVpDd0NUamxVRmpuYllnSFYv?=
 =?utf-8?B?bVNKcDlQTnE3OGNveGNOK05VM08zb3BpejYwR2k2Y1ZnRU8rQXdMdkM0NDBw?=
 =?utf-8?B?elFTRGtFaHgyKytGOWpCNXEwQnBXTCtCaVhuQStsQktKd1dhYU1TZkRGWGxI?=
 =?utf-8?B?K3hITlBTRkpHTkNVb1Rlbm9uemorZGNoZjdQQXR2ajNVUzEwYTBzemYwQ3Q0?=
 =?utf-8?B?NE11VmpZbVhtTHpyOG8xZ0xjVmNwSU9LNDU2TXJuNTRtWE5WcE9sa0UzcVo3?=
 =?utf-8?B?SGxIQ2wrZkNYZmxMbE9uQkdZaDQ0VkJvbWYxWUJZVXdjTHN6U1Z5WDMyZGFx?=
 =?utf-8?B?MFZTVVdoVXVxNElHUVR4WnJDRWxGUWhaMDNyL2h0VzJCWXJSOWs3MXVWRVV1?=
 =?utf-8?B?S3c2cTRvVzJMVWtCWit3c0lFZW93UDcwdGZqLzkzMGZRVWxXSUR4dFM1K3U4?=
 =?utf-8?B?dWNnZUcxMkF5TTNWS2hMVWVLUklUdDBJdkhBRUxmVDZqVmRscFZWdktNaVRQ?=
 =?utf-8?B?SEtSbWlkNjBWZTA3bTVPalA4NkQwWjNWSXUwd1NuWnAwNGUrYmhwaFU4Q1Vw?=
 =?utf-8?B?Yjdqa3k3a3ZLL29nSjBJeFRycVAwR3dKUjUwUVlmRkl5R3dMeElXV0VzNGVv?=
 =?utf-8?B?QjFIbHovdGNUUkJLdTdOVFFXemI4RTl6V1BxMmpjKzNUcklWUDkxdmt4ZkJj?=
 =?utf-8?B?WnZML0g0M1NkbnZ2OCs2Z1B4eUVnVExnZmtUdlRYSlR3SWpRWkpkQVFKNytz?=
 =?utf-8?B?UnIxY1IveTBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1doekxJNktoUkp3S2w0bE5jUm9UQzFkdGVxaWxnL0lKaDM2bTgxR0NiNGRG?=
 =?utf-8?B?eitHbFU3djRTQ29wMVVyb0FsNDJZZVk5dXRwUmNJSG5UTW1iQUF1Q3N5RllP?=
 =?utf-8?B?LzBzMktxVGhHTVZMSUtoQ05ZdnZKeENkUVgxN1RGS2xQQm9saFd6V0hZR1Nm?=
 =?utf-8?B?Q2VGWkl0czRjcnlyWVNMOWF4bndPdGR4WWw2aE9Kdy9lNEVuclNWTVdPV0tw?=
 =?utf-8?B?V3RqNXdGS0FoKzlleTJVSjZ6TkhHZUNTdjhadDVFL1o3aVplalVod2Zrc05i?=
 =?utf-8?B?RUxKL3ljKzVrVkl6OWZyaXBBa3cyVWZZVTdpd05GeHBsTE5WRUtma3RyS3M4?=
 =?utf-8?B?QUwvaU45YnJFSnVUdVhBbk9pOXNmZUJJNzBUZVI1Rm0zOGt3QkFkbUdCSXlu?=
 =?utf-8?B?VnZkWldxdWVPTmV1eXBkcG5teXpSSldNTVQ0cWphN21JazZzek9kOC9jVWdz?=
 =?utf-8?B?bUVjdElaM3JBM053VGpyTmdrR20xY2JUelg5citqRTZuVk54dXAxRmxSUTRN?=
 =?utf-8?B?Nmh5NnF5dXdiTG9nbkRFY2cwNS93UHhsV3ZHcHFwUGVrMTRicWhuRURFMHQz?=
 =?utf-8?B?TWRsaDc1a3Y3N2RlZFkwdmxXZkQyc2dHbG4zOXBPWnhtejRpeEFSYk5SNjVE?=
 =?utf-8?B?c2wvZENnV0FGaFZveTBVTk91UlNlVjlFTFhodEsvM1hhV2lvV2NHZEZRQ003?=
 =?utf-8?B?cTN6d2M1VHk0Wlp1b2pBMHc1YWhINk9xRUt5bzlYeXhvWXJxaktUNitRdHhu?=
 =?utf-8?B?RFpYbzRzOFVyeEJDV2NBT2N4ejljdEo0bEt4SmgwclZTRDRSc2NXNlFTaTRN?=
 =?utf-8?B?dHVlbUlPY2ZHcU9lVHY0dk5QMDNESnJVQUl3ZzJVV1piN0FVYWF2bkxPUXFv?=
 =?utf-8?B?WENQdk1ib2xES3Avd2pCY295cVlyNkxsUDJoclJKa2I2U2xnNGlKdUNMNzd5?=
 =?utf-8?B?T1NoeC9BakVYRXhrWW5pV2E4TC9qYTdMYVUwbHZpWms0SWM0WlA4VWNmc0V4?=
 =?utf-8?B?WFdzSnF5bGpYRm51Y25tOStRMExVUXhLKzhwQmVaaDllWmZRVUxJQ0tVYUVH?=
 =?utf-8?B?QmJDMlBvaC9oNnNrNEM4STg1ZGhnUWQ4eGFyWTZIYlhGakw5Tjd0Wi83V1dW?=
 =?utf-8?B?U0JYS1dBeVJJSzZuRDdYRjkxWXZFUmVDS2xUaUxpVG5rUndwNVY3WXhaakRG?=
 =?utf-8?B?MEtwWUhjTGF6SkJIZUk5akdYK1MwRldJS09iTHpNMWZtZGpsNFpNaGx6YWFL?=
 =?utf-8?B?RVljWDlWTCtZZm1HTU53NEFYWSt4ZWphZEt4WWMrUkFVVUo2M1B0UHRkeVBv?=
 =?utf-8?B?eUdRRHA3Zng4bzdwVG5xcnhmZXVuWlFPTFhKRFQ0L1lmbWNoMlJkKys0WU5h?=
 =?utf-8?B?SWgvZXNDaDI4cEJpRnhhYUNZd2IrbmVCblZSc29nSFpGSWFVZUxySFRrTzdL?=
 =?utf-8?B?L2FWb0Jpb2dMQ29lYXIrR1RmQ0F3dDZyeXowU25wMHFLS0VrZVpYMnk0M2JL?=
 =?utf-8?B?TUZNbmVadVlIeHN3TDhGSjhCb3B4UTdtWG1XQ0hlZGlMZGdCVFh6eEk5ZUty?=
 =?utf-8?B?UDJsRG1oZFU4OWd0V2YvYVA2dW5iSVZwSmxJcXM5Q3E3T0JEU3BzNlZvcThM?=
 =?utf-8?B?d1poVTNnVWVFaU5hOXFsTXNneHAyQXZPSHZXWEhvTUVPZVlvUTlia2J4OGtR?=
 =?utf-8?B?QkY2eTA5WWtzbGJ1ZFdrRGpkdFc4Ti9zelB0TzU4Vld5RXZwY1JKdlhuRWdY?=
 =?utf-8?B?c0owSTVRSm5tQkpWajN1RS9pNGJmUXp1UmVmc0JXUFkrUmRzY3hOOGtsaXU5?=
 =?utf-8?B?L0hTcFl3ZHBQQmRhWTNQMHdObWM2ZUF6ZXdUeXc4ZUQxUkJFbitHbmM0bDN0?=
 =?utf-8?B?ZVJSQm9rMVNkSWF6VjY0YU9NM2JBQXRPNEZ6ZkdNQU4vR0hZWjg1RWFHelM4?=
 =?utf-8?B?RW5iTThRbEpjQThSMTJWNW9MTTcraVlqQnlmQ2svTGFxWi9Bc3ExN1NnVVpP?=
 =?utf-8?B?MVdiYmNVcmFjTmcvNkNDVS9XK2N2YkkyOS96ekFTRm00ZmZ5NHRjWk50dCs4?=
 =?utf-8?B?eDR5WVMrL0JCa3BEM2ovbnJzRFVpUFJWQWR3clFQcTZkdWRxaE5QWUtNa0VX?=
 =?utf-8?B?aDVPemdqdWZsTmR2eFh5V3o1NUhESUNtaktzMURrU2JqSWVaR0VLMm84SUZR?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a6QYbCZaPYEz2p2QIfuGhl27kwg7tgA6CAJppRQs8Ghv3e2u0gfK1/5TKbp1x6PqzxHhiaf/9aHu5jhz2yA0YK40TMNgp3EfpSe/XuJqBmEak9PteDThz2qn8UaCvwrq6RlVELK0OXmYCMOEQacPk7qZVDinlzYQ18QHEu+IpRf8l0o1SzwHAkAP1DRFxN3GUcvHB2EkdjJpqmFexb5cD2XjNWRAW97Ce9WORghQC2MGjqmxR8ZKxUi+sTYoxUimnr/lm6Y05quDu/1VBwgxpJ43BE//LzFSVb3mvBUqX6sknhBkrNNGr+1jE7BXuzzbR1K/svJ4VQ7Wut0e7cgCGr+z3hKhbUaY3+b6MsMsFbDPR4H53tVJtEy03v3H7mSdNXuDxrM6ayTemHY9Bzsrel4sH/Eh1WDfQiXajYq0gWMsZdTYrEafUW3+TY/4DnolNtbnJEs9JM6b7Zuk40BYm3sOBC11C2mev2LIIwUWLRAgfyXg9GNEU42/RfHFQYER0S532wpmhWYxwl51XWzxa6NuBg8WtjJpzGsrQubQm3RYWG5pfg2svyxoU6Lv39hwYHCyh2/zcn8c3qo19RxDDOlrBnMW3ATcIC9khu5bJdA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7afb9d-10f7-403f-fc38-08dd9116055d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 05:29:52.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NB5eVqJf82s28Ddqo25tdZJTq3XmuE61/YB8QTICdq8+FD4c4xkmxQRig7FFNPLSFBHD2i9rWVOiH1QZT8UYq2IrfzrXnibPW5Fss95Bwl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_02,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120056
X-Proofpoint-ORIG-GUID: akWinQOD10Z2CqZrB_6Dh-6f7ULWRHtk
X-Proofpoint-GUID: akWinQOD10Z2CqZrB_6Dh-6f7ULWRHtk
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=68218754 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yMhMjlubAAAA:8 a=pFXj9o0QJveA5nBsKLAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA1NiBTYWx0ZWRfXyeFaxtiqYNRi VGcGmUB6Qq6npZj/1oST6M0tezpva9RcWPLhzlFVCNzN+Gbbf9PTGkg0hw4AVh/+rNL6cj2KkRw IjcVcEEqXHW5KkWoGwCVwezReU+PrYpla4U5N8rtKpSjnoASTbK2EwxFFX6o3/iL/rQWZBGwt/4
 nE3UX3+4/1DI1It8UsJ7puajaXDiAyOCZ/x98qNa06gqaOUpmVGkA7b9GYjVN0M3R1gWvZ1ktMr dlj8U4TH8DIsbwBaRMXJ4QFHWyEvn3hSzyPzSaC6UTS0bvjrrInUgrMUj6uFh/m/ht7WdBMwx2z HonGfgb8F2ZAn2sD+tHH0a5bgPvlDPcvKoQhV6zKhoPpXfuxp87AM7hKbr9fK4bpyyuREPLqeIa
 T+9FbMpNSmrsV+x7RAzk2+DNIb7auIhB/igh7LrfGr3LZrKGEYkQAtOkCwLdhOtu9Em96ET3



On 07-05-2025 21:29, Konstantin Taranov wrote:
> From: Shiraz Saleem <shirazsaleem@microsoft.com>
> 
> Handle soc servcing events which require the rdma auxiliary device resources to

typo servcing ->servicing

> be cleaned up during a suspend, and re-initialized during a resume.
> 
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>   .../net/ethernet/microsoft/mana/gdma_main.c   | 11 ++-
>   .../net/ethernet/microsoft/mana/hw_channel.c  | 20 ++++++
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 69 +++++++++++++++++++
>   include/net/mana/gdma.h                       | 19 +++++
>   include/net/mana/hw_channel.h                 |  9 +++
>   5 files changed, 127 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 59e7814..3504507 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -391,6 +391,7 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
>   	case GDMA_EQE_HWC_INIT_EQ_ID_DB:
>   	case GDMA_EQE_HWC_INIT_DATA:
>   	case GDMA_EQE_HWC_INIT_DONE:
> +	case GDMA_EQE_HWC_SOC_SERVICE:
>   	case GDMA_EQE_RNIC_QP_FATAL:
>   		if (!eq->eq.callback)
>   			break;
> @@ -1468,10 +1469,14 @@ static int mana_gd_setup(struct pci_dev *pdev)
>   	mana_gd_init_registers(pdev);
>   	mana_smc_init(&gc->shm_channel, gc->dev, gc->shm_base);
>   
> +	gc->service_wq = alloc_ordered_workqueue("gdma_service_wq", 0);
> +	if (!gc->service_wq)
> +		return -ENOMEM;
> +
>   	err = mana_gd_setup_irqs(pdev);
>   	if (err) {
>   		dev_err(gc->dev, "Failed to setup IRQs: %d\n", err);
> -		return err;
> +		goto free_workqueue;
>   	}
>   
>   	err = mana_hwc_create_channel(gc);
> @@ -1497,6 +1502,8 @@ destroy_hwc:
>   	mana_hwc_destroy_channel(gc);
>   remove_irq:
>   	mana_gd_remove_irqs(pdev);
> +free_workqueue:
> +	destroy_workqueue(gc->service_wq);
>   	dev_err(&pdev->dev, "%s failed (error %d)\n", __func__, err);
>   	return err;
>   }
> @@ -1508,6 +1515,8 @@ static void mana_gd_cleanup(struct pci_dev *pdev)
>   	mana_hwc_destroy_channel(gc);
>   
>   	mana_gd_remove_irqs(pdev);
> +
> +	destroy_workqueue(gc->service_wq);
>   	dev_dbg(&pdev->dev, "mana gdma cleanup successful\n");
>   }
>   
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index 1ba4960..60f6bc1 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -112,11 +112,13 @@ out:
>   static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
>   					struct gdma_event *event)
>   {
> +	union hwc_init_soc_service_type service_data;
>   	struct hw_channel_context *hwc = ctx;
>   	struct gdma_dev *gd = hwc->gdma_dev;
>   	union hwc_init_type_data type_data;
>   	union hwc_init_eq_id_db eq_db;
>   	u32 type, val;
> +	int ret;
>   
>   	switch (event->type) {
>   	case GDMA_EQE_HWC_INIT_EQ_ID_DB:
> @@ -199,7 +201,25 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
>   		}
>   
>   		break;
> +	case GDMA_EQE_HWC_SOC_SERVICE:
> +		service_data.as_uint32 = event->details[0];
> +		type = service_data.type;
> +		val = service_data.value;

what is use of val?

>   
> +		switch (type) {
> +		case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
> +		case GDMA_SERVICE_TYPE_RDMA_RESUME:
> +			ret = mana_rdma_service_event(gd->gdma_context, type);
> +			if (ret)
> +				dev_err(hwc->dev, "Failed to schedule adev service event: %d\n",
> +					ret);
> +			break;
> +		default:
> +			dev_warn(hwc->dev, "Received unknown SOC service type %u\n", type);
> +			break;
> +		}
> +
> +		break;
>   	default:
>   		dev_warn(hwc->dev, "Received unknown gdma event %u\n", event->type);
>   		/* Ignore unknown events, which should never happen. */
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 2013d0e..39e01e2 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2992,6 +2992,70 @@ idx_fail:
>   	return ret;
>   }
>   
> +static void mana_handle_rdma_servicing(struct work_struct *work)

this name does not sound clearer and more aligned with typical naming 
conventions.
Since it is an RDMA service event handler, it could be named to 
mana_rdma_service_handle. What are your thoughts on this?"

> +{
> +	struct mana_service_work *serv_work =
> +		container_of(work, struct mana_service_work, work);
> +	struct gdma_dev *gd = serv_work->gdma_dev;
> +	struct device *dev = gd->gdma_context->dev;
> +	int ret;
> +
> +	if (READ_ONCE(gd->rdma_teardown))
> +		goto out;
> +
> +	switch (serv_work->event) {
> +	case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
> +		if (!gd->adev || gd->is_suspended)
> +			break;
> +
> +		remove_adev(gd);
> +		gd->is_suspended = true;
> +		break;
> +
> +	case GDMA_SERVICE_TYPE_RDMA_RESUME:
> +		if (!gd->is_suspended)
> +			break;
> +
> +		ret = add_adev(gd, "rdma");
> +		if (ret)
> +			dev_err(dev, "Failed to add adev on resume: %d\n", ret);
> +		else
> +			gd->is_suspended = false;
> +		break;
> +
> +	default:
> +		dev_warn(dev, "unknown adev service event %u\n",
> +			 serv_work->event);
> +		break;
> +	}
> +
> +out:
> +	kfree(serv_work);
> +}
> +
> +int mana_rdma_service_event(struct gdma_context *gc, enum gdma_service_type event)
> +{
> +	struct gdma_dev *gd = &gc->mana_ib;
> +	struct mana_service_work *serv_work;
> +
> +	if (gd->dev_id.type != GDMA_DEVICE_MANA_IB) {
> +		/* RDMA device is not detected on pci */
> +		return 0;
> +	}
> +
> +	serv_work = kzalloc(sizeof(*serv_work), GFP_ATOMIC);
> +	if (!serv_work)
> +		return -ENOMEM;
> +
> +	serv_work->event = event;
> +	serv_work->gdma_dev = gd;
> +
> +	INIT_WORK(&serv_work->work, mana_handle_rdma_servicing);
> +	queue_work(gc->service_wq, &serv_work->work);
> +
> +	return 0;
> +}
> +
>   int mana_probe(struct gdma_dev *gd, bool resuming)
>   {
>   	struct gdma_context *gc = gd->gdma_context;
> @@ -3172,11 +3236,16 @@ int mana_rdma_probe(struct gdma_dev *gd)
>   
>   void mana_rdma_remove(struct gdma_dev *gd)
>   {
> +	struct gdma_context *gc = gd->gdma_context;
> +
>   	if (gd->dev_id.type != GDMA_DEVICE_MANA_IB) {
>   		/* RDMA device is not detected on pci */
>   		return;
>   	}
>   
> +	WRITE_ONCE(gd->rdma_teardown, true);
> +	flush_workqueue(gc->service_wq);
> +
>   	if (gd->adev)
>   		remove_adev(gd);
>   
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index ffa9820..3ce56a8 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -60,6 +60,7 @@ enum gdma_eqe_type {
>   	GDMA_EQE_HWC_INIT_DONE		= 131,
>   	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
>   	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
> +	GDMA_EQE_HWC_SOC_SERVICE	= 134,
>   	GDMA_EQE_RNIC_QP_FATAL		= 176,
>   };
>   
> @@ -70,6 +71,18 @@ enum {
>   	GDMA_DEVICE_MANA_IB	= 3,
>   };
>   
> +enum gdma_service_type {
> +	GDMA_SERVICE_TYPE_NONE		= 0,
> +	GDMA_SERVICE_TYPE_RDMA_SUSPEND	= 1,
> +	GDMA_SERVICE_TYPE_RDMA_RESUME	= 2,
> +};
> +
> +struct mana_service_work {
> +	struct work_struct work;
> +	struct gdma_dev *gdma_dev;
> +	enum gdma_service_type event;
> +};
> +
>   struct gdma_resource {
>   	/* Protect the bitmap */
>   	spinlock_t lock;
> @@ -224,6 +237,8 @@ struct gdma_dev {
>   	void *driver_data;
>   
>   	struct auxiliary_device *adev;
> +	bool is_suspended;
> +	bool rdma_teardown;
>   };
>   
>   /* MANA_PAGE_SIZE is the DMA unit */
> @@ -409,6 +424,8 @@ struct gdma_context {
>   	struct gdma_dev		mana_ib;
>   
>   	u64 pf_cap_flags1;
> +
> +	struct workqueue_struct *service_wq;
>   };

Thanks,
Alok


