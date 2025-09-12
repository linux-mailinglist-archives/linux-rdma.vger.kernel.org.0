Return-Path: <linux-rdma+bounces-13302-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEBBB54152
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 05:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E3716C05D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 03:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057F9275872;
	Fri, 12 Sep 2025 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tu/QdC9t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zAGlEVJY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF225C821;
	Fri, 12 Sep 2025 03:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757649432; cv=fail; b=KNEComM5ZSfLisQ6coB3qmFEQRpTcR6LO3yOPUqQeJ/OCXKFfSFeVgQs0HELbRfZipVj5jI7WEyUA6XMIHsgD24fhOL8H6IF1M3zy+Fp/cHXI6Ut037VdS+4++bemZf6NMbXBXoNr9Y9pGLF0IMwWURGBl9CXAzzqauLcxoxask=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757649432; c=relaxed/simple;
	bh=/6dXzTE/9e5Se9qogABLP6z9V3R4JGXCK/5glgu3c+g=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fr0ysVIUg0ZDLSMOohrBikatFFZjXMFziaSfxAGddb2SkwFLAv/BxKGc4Of6cWAjyrML49TiRZ15VHfiClbmWRvdEwS1jTZfkU/E1zkYr2gdk0MGNFc8jlHXu43HUGsBKKgyEmJ2QASTpUwSDQ1X0eCIKhpp83gZ9kGbW7JQO5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tu/QdC9t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zAGlEVJY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1tlTS008462;
	Fri, 12 Sep 2025 03:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BD0ycK4aWVrYyyh63XyCgwiMeSLxuEhpJHOt6/9FqOI=; b=
	Tu/QdC9ti05qb4QtjqSe09KgHx0zQeHQBFEGwYfoCFf/YNXKvTqp/70Hye/WWg2/
	p1lro7YYlo+kfa+lZO1DwW2vEd6YqIo3bRPiyjCx3wNzKxTJ6RVuPQdwI2WOF22j
	F3PVWbrmL/XOJ14/YHpdvsTuHA1XkJZwICtd+aJsB9FvYWrZ6L9J0PHUAhHxv1sl
	FKXpS4+Q5OhqzOihomLzb9ZQSpVX2onRdEiJVOLROuH32yZyxUKYMxn3YbEM60dY
	8/cXKXzBKU6PR9+o+nEdMQeU9sawWmXgU1RNPR4HIGiRtNMwR0YYqnVLO8BJJ/S5
	1ow0zjvWYCWLrdOTGKXPrg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2yeyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 03:56:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C281Yn038858;
	Fri, 12 Sep 2025 03:56:49 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bddavvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 03:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DE1iCeQAJhCjxXxhqgW5A5QKRTbFfJrcra90v9ztkq2Mc7ITi0c/VhCR8fMNkvbM9pTQr/ZlTkvQ8kJq2jnVKZtj02rFJe3WQGo2TgoUJtMVqCkYxr2muaHITSjTed/fn83IhOnuekErGRFyweetk2Vy68GJTet64Ug6/c5CKFWEMBK0259IVsJYXk9t9WbyxN3GL2+iKilh36JPNEwqDEy9vBDDuZjVT3RqVq3rvx1LI3IE/9R3juBi5/yPR3to491ssl9b6dOerXIf/BwFI2XPtEY/pElTSXy8k11tYa/nStEEaL/BF6Y+A7IsjypE0iZngSXvjbq10+ET7h46+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD0ycK4aWVrYyyh63XyCgwiMeSLxuEhpJHOt6/9FqOI=;
 b=lsAnsO8FTwFhPSsAMIc3xydWEmNa0AjaLAxKW5YxtAqMdXwaQhv1el56xG5dS+q921e4HFbnJLuJ23/ziVvrC5VLGlNVAjdqUhtoM0DVTugAIbbaPNCdtV5PE0cdGNGQ/HcQDFSQ3wAL2Tz2VzIB+x/gxzwtpmONJL4Nnzz2IfyW8IXTO9Mum1FIDNwNdO6TWKPHfM2EJ3BDRt9pW8M/4wA5vpm8ZhtR2w2hRJt7jsG7SpDAV6OJyNc8Zu+foen4zQhWfjNBlxebGxS9kispuYWl0TgAcmTF9P+xtbhlKytJwfkCkD4FPsdkAXOR0JDfSjaotKGXQ3yhE2yNRnRkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD0ycK4aWVrYyyh63XyCgwiMeSLxuEhpJHOt6/9FqOI=;
 b=zAGlEVJYdXqePHwriVZ7SgAyJBK0dwCds05n9v5ANWWRNIxG3XbhpGxjhMxNL3QjA5M8P/DHVofiZYPH6IBA1AY4FvmZL6hddNM72Q0WgBGtMgx7owmm7y4aNiN2KOTYbDayyQbv5NKvYOTgKXBFq3ccN5xaY82XZmdycUN2yUg=
Received: from CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22)
 by CH3PR10MB7395.namprd10.prod.outlook.com (2603:10b6:610:147::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 03:56:45 +0000
Received: from CY5PR10MB6069.namprd10.prod.outlook.com
 ([fe80::143d:f348:965c:d15c]) by CY5PR10MB6069.namprd10.prod.outlook.com
 ([fe80::143d:f348:965c:d15c%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 03:56:43 +0000
Message-ID: <81c62cf9-8583-46ec-b6d7-48a8c9c92fcb@oracle.com>
Date: Fri, 12 Sep 2025 09:26:28 +0530
User-Agent: Mozilla Thunderbird
From: Pradyumn Rahar <pradyumn.rahar@oracle.com>
Subject: Re: [PATCH net 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
To: Jacob Keller <jacob.e.keller@intel.com>,
        Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "leon@kernel.org"
 <leon@kernel.org>,
        "tariqt@nvidia.com" <tariqt@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com"
 <pabeni@redhat.com>,
        "shayd@nvidia.com" <shayd@nvidia.com>,
        "elic@nvidia.com" <elic@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
        Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
        Qing Huang <qing.huang@oracle.com>
References: <1eda4785-6e3e-4660-ac04-62e474133d71@oracle.com>
 <9022a20f-47a7-47f2-9d87-b242cf75b55a@intel.com>
Content-Language: en-US
In-Reply-To: <9022a20f-47a7-47f2-9d87-b242cf75b55a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To CY5PR10MB6069.namprd10.prod.outlook.com
 (2603:10b6:930:3b::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6069:EE_|CH3PR10MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c917cf5-c112-41aa-86f7-08ddf1b0628d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGtNNHFNVnp6THptUTVsR05VZWVUNG5Ra09mTXFoMG10RThhVG1WczlBbzAy?=
 =?utf-8?B?TGhpUVNiR3hVUXJBTWlYbmlIR2xWbXlQb25vWXJCbkRhcWJDdjBOYzVWbWlq?=
 =?utf-8?B?Vjk1MXVIbkU1NGpuRUJzTWtiTUl6bWVjUzluci9WQUpSa29NZkM1QWlzZ2RJ?=
 =?utf-8?B?NVloUThTek1yOG5QSUxaUEx5V3Y1SDlWVU5RVStDZE9BclNwWU1GbGwrZVhC?=
 =?utf-8?B?SG9DUVZhNGpQeWQ0aW9FcVR3bzVteSs1emZIOGdrZlozWERQOWU0TUlMamxa?=
 =?utf-8?B?SEFhV2dKOWFNWStaeHU1Tit5RSthV3JVM2FBb2JVenNvTzJtbWtEWGlIR3BW?=
 =?utf-8?B?bVBlazMzVzcxbkphU0RlS1FBdUdtN29HajZYZEVXblMyeTArK1FVTk9MdmIw?=
 =?utf-8?B?a3Rueno1ejArR0ZMVlVrTCtiOG1oZU5rQmFYTGVQT25FVURNNWNObjVDSTdz?=
 =?utf-8?B?Y2tjUXMvemFYS3FIMUlEdFJETlhudjE0YTF1V2Z5cVR1KytYcVpFbjErall5?=
 =?utf-8?B?MURkYmhWOG16bFliNkZQWDBrQ1d3WlpJSXpvN1BrRjRpRytBMDRGVEFTakp1?=
 =?utf-8?B?cVF3NUJDTFh6QnFjWVgxd2JzM3R3S1U1QUwvSXEzWnQ1aUF2UlQwY2V5MU40?=
 =?utf-8?B?UTBqUld0Vi9oSkVtNmJsMEJIcTJMZU1wQ083eWpHQUZudEhvdXVlM2JyOTM5?=
 =?utf-8?B?aVVETjQ1WHAzMmUxSDFlc0pWT040ZkZxOXhPdHJzSGhOU1NMUjhhMWdBNHdr?=
 =?utf-8?B?NWRXd1d5UVhJTDFYUlZFL2xveXpMUER1UkhYYTJxZHRveHVUYTlrTnNwcm9S?=
 =?utf-8?B?L0V3RnFSYUNOMmE1cmxVNUJRNGYwaGhtM1RNZ1M4T2VwcmozUS9EbUFkaUE4?=
 =?utf-8?B?czJJT3JYR1RIUjdVdzFpb1VjVXlsQU1PSUxvREN0eEw5Q2Z1b0kveUxzUFhY?=
 =?utf-8?B?WlJDcGsvVUpSZzlic3I2K0JJTkErZ1NiKzRPTURDMGltOVNnSS8vM3R0aDc2?=
 =?utf-8?B?WjRFTVo0bmVQWmpQU2tuR3c4cUJGWGg2K3VUeGdNK1dRQXhvTU40T1UrK1Fx?=
 =?utf-8?B?T0swcnE2ellYN2tuVmNhck85M08wUzFnYTRiRlh5K2U1YTRCRWJ1eWdQbVhV?=
 =?utf-8?B?RHVnanlaVU9HbW1qczhySjluZ1dxcE9ZelZqQktsM0JUMmt5aU5wa0Jtb3JT?=
 =?utf-8?B?WkhONlcvcmNidE5DeWJIWWJ4Q1hSUW0zMXN5OFBDTG1vRm5zUUFBZ3ZkZGo0?=
 =?utf-8?B?MjFQZW1CWnQrYXJMbkp6bmxDQTZaUnpGMUpQUjQxOU1CcStoZTJVaFY0ejNh?=
 =?utf-8?B?UjMvZk9hT2Y3VVA3cjBlNk82MVgwakc1dFRLY1lSOWl6cGQ2WkZ1WFBwcUYw?=
 =?utf-8?B?ZWJCQnBJRENFK29rcmxHL0h6d3MxVU96YkNKWjQ5MElLaTlwcXFlNGhHa0Vy?=
 =?utf-8?B?TEwvUnY2YmFGdE4reXQwaXlYR2prMURCRlVSdkR4QWNEM1R0Z2FtWEVsNjM4?=
 =?utf-8?B?YXQxRVpCWjk3OVkva00zbE1iSFRadmdVTkhLSjJRU1Fmdk9FRUhKR1NQenFI?=
 =?utf-8?B?T05rYm5WWnY4ajZKS0tVWFc5SWdhQXF1c0lyblpvMVRYZUhma3FVQlR5UDlW?=
 =?utf-8?B?eEVjZzA3a1dNd3BZOHd6ODlKckl4VW5BSGRXaGp5dHBDZ01qeHJpeGNjNkZD?=
 =?utf-8?B?Yi9ORTZqVkhkd0l5NEdaYWIyY2JRdXpVVFRiU1l1RHpnd0lJV29MUElQV08x?=
 =?utf-8?B?dFIweVkxVTREZmk3K3dOWmMzVUtTWHl3Zmpia013LzhqcmNSUUxhR3dLNGVC?=
 =?utf-8?B?MDJPWlBPREFDS0c3WG1UVDZuSGdDMFBMalZMQ2lCd1RmbVdkQ1FaSERrUkJ6?=
 =?utf-8?B?YTVQVCt1UmN1WTQ0aWkwZGtIekJMN0N0U2VtUzdxS29QK2MyZTZmVE1qaEpN?=
 =?utf-8?Q?Np3F4D9QoFc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6069.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2ovMHVmc3pCM1hQMXlyWml2bng1YkVmMTZ4aVdoZGxpSG1ES0lYYWJjYnEz?=
 =?utf-8?B?QXhnOVQzZ0U1VmFvY3NYZStvS0pSNEwrakVVWlczeDFwSmVCclQvWkYzeDU2?=
 =?utf-8?B?aDd0YWZoQW01bGNoWTlkNE91eStzU2xndDhOSXR4dG95SkZOSzgwVXFVMHFr?=
 =?utf-8?B?c0t5bzlBZ1JETFBiamVsa29BWVl3Zk5tVkhvNW1KVkQxQm9NMll1ZzFRdkE3?=
 =?utf-8?B?bVRLM0ZRajdBeHByelRGdzBNWEFwdFEzWFUvKytOb0VlcGZVZ0hXaThJcTl4?=
 =?utf-8?B?MUJFL0tpbXJ1bjJ6RGVNZFdyTU1SZURrck8yK242QlZURmVDV3NhbzVFKzZV?=
 =?utf-8?B?NXZaS1FORGRtMllSUHZLMWJHWFE2MnZGVGZ0Y2M0aGRzS3JLY2NFSEdQVnNm?=
 =?utf-8?B?MzVnb3ZuQlVWcFk0dEU1SFpQUkRqV2tNL1VHMjltWCs4ejN5V2VJMCs0cVJY?=
 =?utf-8?B?c1J0UGExdlpvZGRKNHc3Sm1sY2pmaHV1UnNaZlJOY25kQmJPSzRHY09ORWs3?=
 =?utf-8?B?cVZBNVk1czVuZjI1cE01QTMvYU5QdEl4ckRHaUlxSmttUWhSMWVJV2ZoZ2lX?=
 =?utf-8?B?b0FjaDZhSmVJdTd2WXd5aXVqeWxqbk44YlBsbGJCdjNYdk8rUXZDNUY1QzZq?=
 =?utf-8?B?MWZGUlUzUXlaR0ZkankxUVozRlZPR0dUSFFlN1VFWlJMOVRmR2ZOcnhKcHZU?=
 =?utf-8?B?VlFBbTkxVW4ra21jL3grQ2xnOGhDa1c4NXgwR0dpaU9ITXp5RThvYXFhQW80?=
 =?utf-8?B?Z2s2dXFjUlM1WXdEWkJELzB5REcrZlMvV2VRSDBSSUpUQ29ZeUdab2JrQmJq?=
 =?utf-8?B?bDhMNStTcDE4YnVITm0wU3ZDNzZQTEUzbXVnUE9iMHdyTVFrQmF3VmdoWHd0?=
 =?utf-8?B?R0pNT0ROOUZpL2RiaWlvUHF0cWFZMjhmd0oyNFI5YnpoSi9DNWM0eHN6V0hU?=
 =?utf-8?B?eVVKajFpT3ZWT3R3Q3dmc05kWFZFdkVxSzVCUU9WOEwzTFprMHdweWtXNVds?=
 =?utf-8?B?OXJZWDBWcnJOcy9wY2MzTnZTbkpJczZFQzZZUTZhVlhGV1NKSi9pNWpoeVA3?=
 =?utf-8?B?RlZVYnArcUNJVWQxTDRMaXh5VFVxMnE4TXhGUWp2WmFvVk1va3hOYnhpZlJG?=
 =?utf-8?B?Vm54TFlqSUxLeUJMakRoeldFekV4Uzh0UmNkL2ltcFBza3JPbWFnNFQ0WUYw?=
 =?utf-8?B?dDlNRi9qdHBlWkxLbzVKWi93emx5azFURy9nMEpnMWtuQ0R6SUloV3BXTnFQ?=
 =?utf-8?B?dVR0SnRIR1BkMjN1YkVwK2Y3Z3RLQnpJSzZRRXFFYmMzWmZLb3RjM2tUNll1?=
 =?utf-8?B?eEpMYjNBb0c0d2EzdFZ1ZWlFQ0FoNm52eGlDZklwNXpybXU2Um1WSE9QQnFK?=
 =?utf-8?B?VGNTMHZiSlZHSTF1VXNzdmR2MTdkV1B1ZGdVWFc1S21JU2FYREN0SkNpeXdz?=
 =?utf-8?B?eWE3Sml0cm9MaVpVWW1kWHVpbGlGbXlzaTFWWWNBMWVEUlZzbHJJdFp4MnBj?=
 =?utf-8?B?cUhjVVkxa04vV1VKNGhiZWt0M0ZoSHVpV3luYVV1K2xwSlV3VGZqUGtSS1dl?=
 =?utf-8?B?MjhjLzdQZzA2bkFNaFFPTVQ3NVBUN1hWcWxoaXpQNUdua0d0WUFLb1pXb29a?=
 =?utf-8?B?Z0tSVE9CUUJSUXFHdTRNOHhBbzdBbEdSTVFYVVcrbVJwSjFGOGI2a1hYNk1u?=
 =?utf-8?B?ODRQSnRoeStFb0VZeVhHbE01YWJ3QVpEWTlobzFWOTFUZy82Mng4SG90RVJl?=
 =?utf-8?B?VVBpeVRZR2JFS2VBbHg0Y1lTZmJ4dllhSWpDMnkxRnBUMTdjMFlPV09UL2k5?=
 =?utf-8?B?NEcvWUtnUFlvdWpDRnFZVDk1UG9QK0hDYjh1OU1TUlpLVEdzQ0dSTEs5ZEZJ?=
 =?utf-8?B?K2tQU2RvYzlaOFhlTTFsT0NrMnNqam43V1J6a0doL2dtSHpBeVYvalFCT09J?=
 =?utf-8?B?eFpSQ0pJQU9KRnZvZnQzSTk2UkM1UGYreWsydmx5dDdXcGl4dnlQYkRNYWRl?=
 =?utf-8?B?MytxUnZOMldFQ0pZSjJ1c1k1WnJUTDJQUnI0NnlIN2tBc295SEFZU050Mk42?=
 =?utf-8?B?ekFUaEhTRXdzNWlYQXY2RGx3ditTQmExWS80MENaeFVoMXgzd1oxbXNZVURS?=
 =?utf-8?B?bG5DdWlsSzVwUi9rWTFZVFlkcnJrbW00b3RTNEdXTnNpVXhDZ3NOTU1PY2tv?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q+p3wpP5YVsUZP2uv6XUov2XrE8TyH0MHvDn2bIaDc1o1RiOpYfA+/VD6YUQaYtpuNmkCSEPgpK4DAniM1fIeJEOatCxr8WaZwbUbIqoKUcLuJUWnexvdiCkLI14kD4EUKM9s9+KZ224kzHE6/1xbS+W6GLan8jGzKPpe/K8yG75cKAiBgo9qUbB0Cn6QOw5sCsZANYIY+UmTQpOmm84DPPMkROG4SBvqg4w3c0Ch0r66ifqTB2Y64a2LRUYVyimNh27ryS7nbI9UD6UYE80MIGQWi4rjdTNdoXmkVjlJuNuTo8bmsJWr+ed3ddVCeVDDO5NkjvGSp6mNex0DKQF5EGdPq+qHKVMQZ1hKMl+igOhw5YnK1k2ZmcZNJOiGyQjpSiMA3I5+U+d2UbvBXCrxKg674bsSmvWMXmhe5QSsH9n6yoDRg3pqHntHMcJlT4klCWTKnkYR0ZmLaAfKX+yha6LXfd3hDFySWr+p+174Yu4woQEpqPmaccsTXtoitNXQbGXNdKe61ULi9o+4oHCZ6FbMW1uKrHua8ycvgguGBDHAETt9/gHS86YZiXLqKrxeziXi/oB6lPeKBt+f2LoPr/D0BqcVoyCH6+4lDrLWUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c917cf5-c112-41aa-86f7-08ddf1b0628d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6069.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 03:56:43.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7yP++zgg7G5lk6TdiegRADxRNF4v1bS42W6rjCW0pIi97xOmTmdnnNTMXfV4z+nqIzNmNFcUhzdLi/yLkVplCbavx2hDYacVFq8B+lmZ2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120035
X-Proofpoint-GUID: B3a8l6Ny8J34CUZCFtPsajmO8sAr9gEc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX1Uyrkjc1jBqp
 nvEwnDA6QKVu4g9apsKl4JgVZAlQ8x0lUr1hh6jaNDwq18OyV9SohJrEas4oP5ZA1sS3xjx8NMC
 m9bsNH2q+B4mzMGyLkMJQ+hssCET0YE+7URxeA6Sv7QdF2MgHLJ7EGt1tjvvlCqk8mRIGPfts/w
 6LKAehqjhc6M8DSp2zVZrjYKGP6OwiyTvOMKLci3ASZXZIS0BusZ0pfMnY8S+yhDWI2bT9iuoFH
 ttWqyXCuFbp9qcpPlNuF8BctM/YTIb2bDRQYcBEjwkqziEpUjNjnzvS/3lOEZQ1zGvujHJczZm7
 +eeeNAGywf0BSqq+iTm66MOpvPFFSIYu9Z5wc8F/01ZQEZrOic3//IbiBELk5/+d1mUoHpg8ka9
 sDX/RWI+6JXRoeZm9iWEqYuqgHKR2g==
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c39a02 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=o2t7t-9uB7ZXtTONCy8A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12083
X-Proofpoint-ORIG-GUID: B3a8l6Ny8J34CUZCFtPsajmO8sAr9gEc

On 02-07-2025 23:28, Jacob Keller wrote:
> On 6/26/2025 11:50 PM, Mohith Kumar Thummaluru wrote:
>> The mlx5_irq_alloc() function can inadvertently free the entire rmap
>> and end up in a crash[1] when the other threads tries to access this,
>> when request_irq() fails due to exhausted IRQ vectors. This commit
>> modifies the cleanup to remove only the specific IRQ mapping that was
>> just added.
>>
>> This prevents removal of other valid mappings and ensures precise
>> cleanup of the failed IRQ allocation's associated glue object.
>>
>> Note: This error is observed when both fwctl and rds configs are enabled.
>>
> FWIW, figured i should add it here:
>
> Reviewed-by: Jacob Keller<jacob.e.keller@intel.com>
Hi, this patch has been reviewed but hasn't been applied, could you 
please look into it?

