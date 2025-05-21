Return-Path: <linux-rdma+bounces-10502-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC832ABFD1B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 20:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4A54E3EF2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 18:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C659228ECE4;
	Wed, 21 May 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sDB4MUso";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NahX7Ep6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0121ADA0
	for <linux-rdma@vger.kernel.org>; Wed, 21 May 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853977; cv=fail; b=gRPYVpcSm7aRWh6TCV9cJx+2/BT+VrsdpcLCDBVAWvgbylNVOYGdaoygcDjJjYYAJ7iZozQRBo+pCQ6EFute9avslArdSMd+Vx4Vo923LIxqWDef0ZoZy6bzcyDqk1oP2dCI1gEE4izczjbTnQhM94ykwkUOoGQcK7mtZz2xmGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853977; c=relaxed/simple;
	bh=36zpFe/kP71uzLA/QvEu4BnZ3g05Vz9ndcCWB8vLxzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QW2lIB/7pHPdMupkJQj7m5wbHDle849QtgvwrTYmIobztvbMRc/u2Ni2eMRK7f8hbLZa60WBVnI6soXsTM15UBeQQjlGdlVdyqhDN8mTLx7+4876IVqyOAj3Phg48eRf+kK5IHQncqlwC7UGcUlZ7jzZD94b4BYqNIt4xQ8778M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sDB4MUso; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NahX7Ep6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LI5IpK005282;
	Wed, 21 May 2025 18:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wf3r4Axjt/0DCBo56zQ66DBJ6/gWAH0HvufTtUJ5+8s=; b=
	sDB4MUsoTUGpYpgzo2P6Rv7I2c5MMW8pCTIaWIIJQH052Ptgntq6LLGNgGOqsXjp
	1N0h4/jZZ4FYi00+6wzSigxjmYCfWzXrpDwTbdpfKT1bsVysBe9lOs/roiGLPaNd
	7PKNdET+FBelmYBm6HmwGxA69mJ/13tqxEKlDStcO6CszosqjswiFWRJAU8MWPup
	5wGwiXyEBiL4Ji65Kaw8xxGMiVDbZ5vN8SQYXxYy2atHJHUWoU4+eZDhs2buPOPQ
	zoloeH/64DWR7F7ljRRTNDU+k5K0r4K7t82WcecjPl8ZnE7k7AJFqTHZgtbbjrJs
	FNioxxq8cuXYIQEPqlUPrQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46skm6g3uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:59:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LIYk79020328;
	Wed, 21 May 2025 18:59:29 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rweu8jjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:59:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P06vH1qAwvinl9MXplB886Mm4quW9W48eKDlynKSTc3uqvrdrF9pN4d0Lyw+Rv6Eu4CUuuHWD+VHoO/t9jISI/hhhONExzfjB6JDILDdh6ucz3t/d+tvKvSYxX+yuUf79lQo3Njr5qSD3p4ISw6xqIzbzpd2Fj9Zqi7u50efRAfdYXr52S+VrTbp1ybJK0QrkwyqpT1UJr1kIv9Ymqf582GsS6odXEinfKzJfmrLAGIbcTFf5JVdfqRBHgr5tuvOEjyeidPZNYxOWBDGbnI/clLL1DCDjw/uwuYopVE5/Q4JYAD2+maRcjhV9Inv6zBcPpOwes5K5D3gjBX/XZrxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf3r4Axjt/0DCBo56zQ66DBJ6/gWAH0HvufTtUJ5+8s=;
 b=n9Ey4o/T7P1lwPjBHMiMw1xj2XA7fA8LRYhi3Pq95YnttOEm0gk6bKGULM67j8jNOvQtp4DUUDZ38cRLJx/+euyKJcZQSVmANPfy+irdAznPAfAgz1J/PSR8qqOwIVHOS2RNVzb8psW5KKA4jPrw+2p3Y6w2Z4SfNAw0trHDWdn3LlgeVekcQ0qVPgaLo2htoBmDEr3NeC42Kli/fT2sg9zFLAzIXebmZ/Cw0Xtgos3a2yZZP6VAaqWLIl03KgKVYewmfbUP1iba0C+AN2NXD13pKGTypcpK25p2UATTjh2MOD5mOwm8QZpXlycxP5ANW+v+C3BNhMQ0ln/UnEVQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf3r4Axjt/0DCBo56zQ66DBJ6/gWAH0HvufTtUJ5+8s=;
 b=NahX7Ep6R9xd4TzG+Oawo4qWlmx8Za/Du5CeMHTtH39Y7MsCGvDkNJCqRaQy+drVM+CwLhoyLpMkLPGfWxUgs2DrNmyIMitv9oRmtubiEAZBp1N+UOVQ7C2RbRS29IrszmHBFR6/tTi+dDknpxK5fwHofB+3sthiiV+YeDsaRns=
Received: from SJ2PR10MB6962.namprd10.prod.outlook.com (2603:10b6:a03:4d1::13)
 by DM4PR10MB6135.namprd10.prod.outlook.com (2603:10b6:8:b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Wed, 21 May 2025 18:59:26 +0000
Received: from SJ2PR10MB6962.namprd10.prod.outlook.com
 ([fe80::c588:aef6:a2e5:9ccb]) by SJ2PR10MB6962.namprd10.prod.outlook.com
 ([fe80::c588:aef6:a2e5:9ccb%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:59:26 +0000
Message-ID: <0f005949-cf9b-403f-afcb-95be492a8e49@oracle.com>
Date: Wed, 21 May 2025 11:59:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-rc] RDMA/cma: Fix hang when cma_netevent_callback
 fails to queue_work
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Jack Morgenstein <jackm@nvidia.com>, Feng Liu <feliu@nvidia.com>,
        =?UTF-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>,
        linux-rdma@vger.kernel.org, Patrisious Haddad <phaddad@nvidia.com>,
        Vlad Dumitrescu <vdumitrescu@nvidia.com>
References: <4f3640b501e48d0166f312a64fdadf72b059bd04.1747827103.git.leon@kernel.org>
Content-Language: en-US
From: Sharath Srinivasan <sharath.srinivasan@oracle.com>
In-Reply-To: <4f3640b501e48d0166f312a64fdadf72b059bd04.1747827103.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:23a::11) To SJ2PR10MB6962.namprd10.prod.outlook.com
 (2603:10b6:a03:4d1::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB6962:EE_|DM4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: ef75238d-be4b-41ee-1507-08dd98999b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T01pMDg3UDN2K3AzeFdHRG1KdERYbFNYUVU0VlE4Y1Z4eHpHWGg3MjhBbG1H?=
 =?utf-8?B?VGJCeXU4b0xjTUZqVGtTYkN1cmttZWNVK1AvUWd1QjNPSEViQmFvYkh4d1FH?=
 =?utf-8?B?M2cxV2h4N28yZ0c4RkxzMUh3eTVOOVRzVHdyUGdHUnZJUjZWY3FGRHlUZkNm?=
 =?utf-8?B?MDYwemtYZFhxNlJtWjB3WUp6bmhhamtncVl4YjR1Smg0UXRZWlFTVGEwWmJ5?=
 =?utf-8?B?U1RpYzlCcWh3Rkp2MDQ5dzB6SUY0OHZXVVllMU1rMXAzMFRkQWg4V1FHVi9K?=
 =?utf-8?B?eU0wem5Tc3BXR21WQTd1dmtmcytScTloRnQzT3c3NEYyclNPQVVpVWFIOEQ1?=
 =?utf-8?B?S1B1TnowR2ZoLzltVjlIMHIwODZ6MUdBOTJBUlJQYStXdk45UFdQUitHaWFW?=
 =?utf-8?B?TzJTcmtVVUZJVngyZEdzWHRvL2VwU3gvUDgxbkh4Y01ORUs2VVVIa1R6eHgy?=
 =?utf-8?B?ZlVuRG11U0l5cDFTQitxTGloci9sODRRVUUyU2FpT081U05lMDc2eU4xNXk5?=
 =?utf-8?B?TjdKd2NkU2p4MGVHS1k0TWRvNFBmdU14YlFwYTRWVFVvMnk0Ujk5WmVnNXh3?=
 =?utf-8?B?Nkw5MnF3aExjcDJJRDlaRERUZmYvSlZQNG9FTnZnUG9YRnYxV1pOajJ1cHJx?=
 =?utf-8?B?NmN5RzY4VmdFUDFrYnFUeGFMcjMrQWZ6Z09CVjBmNERXTk00cVNMNVZJcHlr?=
 =?utf-8?B?ZjNTOTZJZ01wcGh0OVVIREJvS01INWl5VWs5ZEkwZHovWWdVQWVsdndwcGxj?=
 =?utf-8?B?UVFzOWNneElPWTRMMk1xdFp4YUNrQWJtY2JJTVVBdWRJKzhTWnRPTHpvNlNh?=
 =?utf-8?B?ZXBtdFI5a1pYNGR5ZUY4dkZLTlFYaE9PaVB1WlJXNDFDU3FiZDVUUEovbElh?=
 =?utf-8?B?UU0zbEtMSjVWUk5GTy92UGhXaTRZVUQvc0pOdmVyZDM3cldLM1c4elRqRnJk?=
 =?utf-8?B?Ukl5d0VxemVtUzVRQTlYU3ZkNTE2UUVGMWhEbmxCVytCQXJTU2tQb1VyaXBQ?=
 =?utf-8?B?WjczVUlnY0kwSEN2WS9XSTFuWHVSNVpEOTBLcy90MUhIWEY5WWlxNHl3Vk1z?=
 =?utf-8?B?ZlJJWmFzdDZzSGdEVEhsSUtkcW1Ra2ZEQ2Voang4c0czUFhscU0wbExrZzlY?=
 =?utf-8?B?bnF5cGJxWURBZUpnSDZTODNBZ1ZCVFdST2hvUDNPUVkzZEtOMUk4cXFXRUc1?=
 =?utf-8?B?UlhTT3d0cUt2emtYaUYzbGxyZVQvcGxQV0RxREpINVlhcGxmYU5GWFhSYmk1?=
 =?utf-8?B?c01oWkJCZHplT2NCakF0cmxLMlF6WnN5VnE1MnpVOXIwelNqcGtFZXNucVUy?=
 =?utf-8?B?bXlnNnRVNEVQS29KUXRXd3h0RllzYnpsSGdNUjNLakFNR0Ftb3VERHRGd3JS?=
 =?utf-8?B?OU5QSWVkZnhiTURhUkV0YnZ1RzNrdWtqK3hqWUpHYXdpUzhkdUFKVTc4aDFD?=
 =?utf-8?B?S2I3aU9kUUZTZCtsRlJPMHlJeFlETG9rVDQ4NHdodVg1MjlFZk9FR1ZhM1R5?=
 =?utf-8?B?Qkhnei9hWnc4Tyt0WEN6c1JBeDR3NFJtNC80d2NtdVdnaUhzTWxpWll2MGZN?=
 =?utf-8?B?WW5IRUppbmttaCtOQlNUY3B3cFZkRHJvRVk3RnA5YklUL1h1bFlHTGVJeFZX?=
 =?utf-8?B?RWlTMktqQVZmS2N5RHRHdFM1UUNFcDIwZEQ4NlAzckhqcXI5RFB5cU0ycHFF?=
 =?utf-8?B?enBHOWJlTUNEYzNMb3VOMmYrQ1FWS3lJL0lLYkk0WTBCOHVuWHlkeWU4UzVw?=
 =?utf-8?B?Vi96b0QyditraGlVTXpYd001MTZrM05ER1FEcHBDa29sNE41aEJISU9kYjA5?=
 =?utf-8?B?ZjZXYXV4UlFDVHh5dFNGMXpKazBPNm5JcUVyc1ZEM3Zwekd6Qy9LcWxCVSs2?=
 =?utf-8?B?SWkrWm0yNGFHcXRaMnZhd3ZvdkJ2UUhKaG8ySE8rUEpzdUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB6962.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUhxcEd6THY4S1o0VGFQRGp6d3liQTI2OUxMcGt4UDdxRHd0T0hJQndHSGt5?=
 =?utf-8?B?aFdRNHlQeEQxcE1ib2xVOWU1M2VFNW95SmIwUzJtaU0rVVdWaENVQi9LZU9V?=
 =?utf-8?B?WkJDZ0ZDdE50QkFwT0l0ajZKRGdjOTIxbTNOL3JybTVWUHV2OFJGUm9PUlgw?=
 =?utf-8?B?UXpRbmkrZEw2NU9yNmNGVHZUL05xajl4dWlHeUdiVE9PQ0lIQlN5MHFma0hY?=
 =?utf-8?B?dEZyOWlhQXZFN1BwT1JoRzdydWhiZkRCRFdCWW1INy92RUxoQTFwR3k0Qnps?=
 =?utf-8?B?QjZ4YTlzcHRMZmRQb1p6SFM2TUtpclQ0R1J6UHRlcHJESi9QdHJLZEVNQ2Zo?=
 =?utf-8?B?a29lWk5vTTRkMnVkdG5DVFdVVlVrSGIyb1JaUFhIVFcxRXZCZGQ0cTFPeUhk?=
 =?utf-8?B?MCtQQTViMUJlQnpUWUJ6MjRYZVdzdW9qbmdYWUNiZmhPTURCU244dnpmaUsr?=
 =?utf-8?B?SHJrZDhlUytEbUdPT2VYeHQrTlhXb1lDNTA3eVBjOTNQR2U3dXBJTmRqaFZN?=
 =?utf-8?B?elBDYnV4djFSaFB1NjR5Uk1VVkhvWXlaaUhrMjE0NHkrNFhNLy9BR2NZV0l6?=
 =?utf-8?B?cDZXSVlvWVBqY3p2RktZSUdacnRZblR4OEF0TnFoY0Y5NEpab2FtdjM0TkNh?=
 =?utf-8?B?OGFuQ2w4OTZnTDBOeDUyZ2dlbGIzMFVOaTYzbkw0M1oyL2RPT1lndHcrSjRM?=
 =?utf-8?B?QzMyN1RmQTcrVU1QU3l6eUcyUnlQVmp1VHFYbEVhOUgwNit1VzdGTGczSjZL?=
 =?utf-8?B?dERsbGZhSDRXWmx4VGt5VHl6L3lTRFQ1aStETGJOMlFabStlQW1MUUQ5UUtI?=
 =?utf-8?B?YlM5VUVVRW4rRCtlVVpSLzR4V3MrbU1BTW0yeWp3RE1rRlZmRWpQL1BCWnYx?=
 =?utf-8?B?WGN4NkFxYlJ6MWJ2R3BaeFVHMG1lM3ZCYVBLeVBDT0lUWjlvVnE4aDIxVDBk?=
 =?utf-8?B?VlNBNXJiVXlsVVdVeExNRVl4alZpSnZ3aXorTzdMcDJxeGltdDZxR1F0MG5x?=
 =?utf-8?B?Vm5WalZ2bjViS0hmUXZaQTdUTGdpREd0RGdMRmFFamo0TXc5Y0lXejJwWDVy?=
 =?utf-8?B?L0w4SWpQeDY0Mi9CNWdGVXlZanNUUjI4OUp5VGQxdUIvb1RNZ2hPUFhTcGVl?=
 =?utf-8?B?ZVo1aCtiWDhzVkZKMXYrN1l5VFdqb2N1K094M0ZPeFovUDh1eTFmU0FmUEVY?=
 =?utf-8?B?Q0Nka0M4SjFmTnNCNHVOREZwSW9tUG5wTWx0NHkycjc1K3FkaUdhdFlHMXlo?=
 =?utf-8?B?NWxTN3VuVkVHbFZBeGVweDdPc3J4cnQ0bFlDUExxRVRGYmhGUWFuUDl2WFV0?=
 =?utf-8?B?K0Rjam14bUFob1VXdk92SHVCeXNRTG1HYlBvSFcwRngxSWpnYzBuTXlzaHho?=
 =?utf-8?B?Yy9odTFVS2s2THJUNUFWNnJIeWY2K1g2bGhNblB6cmJoOFRzMHlqUnNJVmhE?=
 =?utf-8?B?OE9wVWtVT1JDcDVTZXZ6SWNZV2diZ2FjbGc3SmtDYVVFZ285RjVuaG9IU2hw?=
 =?utf-8?B?aWRxOW14OG5LeUY3SzZUWUFuc2hvTmF4QWlLRXNpRlBrWm5EMUZoZXJGTCtq?=
 =?utf-8?B?SjlBTStVOEhNRHJVbDBrRjgrVWlGN0JtMU5vRUluSFRjdlZDWmpLVWVwN1VD?=
 =?utf-8?B?MThTdnEybmc0VVJadi95N3FkdDRwTTFoK3lLdEs0U1FUKy9vVkJWN2lMYTdt?=
 =?utf-8?B?R3ROUzJvL0JzQitPU1NGZ1NnNERTOXowOXp1OElhV3lhdENjWllpY1NpWkhy?=
 =?utf-8?B?akZ1U2hSZkdvemRUNGc0MW81YUhCVll6ZE4wSTBmc21BV05tNjNoblBhditK?=
 =?utf-8?B?czJ6dnhZUURSbDNoaXd2SVozdEcxVndrOG5oOEJnMmJNWXN3d01iNnFtV3pQ?=
 =?utf-8?B?MUx1WWdWUjZXLzlLMkI5R3JZQlJBQWpGeE1uR2t5ekZZT2NkYnJkU2JnQmwv?=
 =?utf-8?B?YTNyaE5tRzdBWlN3K2JOejgwUmNmZ2lWTHQycHplZ2xIWW8yNkU0V0x2N016?=
 =?utf-8?B?aVNtNWxxS1pYSWVIN2pwREZlTFJMWU80d3NIV25LVnkyR1VEeVdrTlRzUHNJ?=
 =?utf-8?B?em9DSDFpVEttSUI3bEh3Y0lJQU9QK2Vvc2pwMFFybzBOOU5WbDQyZ29HbXNJ?=
 =?utf-8?B?SHovNHhXWTJUZXI5RlpMUm91M29OaWhCK2U3Z3UxeURrM1FWZFhsSDNraGFi?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RBwbGLkmHuIoxmvTGoMD3FWzSj4bVFRe2vauJYUeCbjr7ybUhbbm8vqn4JH9cY86KNMxPtIoAiXH8dQIB8QbK5TAZ6IHOqyCD5Q/FnPlBaDx2be3ofQF0cEb0olUb7DxGpPgXuXpbBJyMTYZg7iEm3VApR8rx1GpKf+8CATNAFqh/tc/IPf8SFf2kHPBf4vRubfm5cc7Jh8SU9Rn5PId2wOToidfwUn5ILyzJP8ogaYq3Wmubhh0xMY02V+b4GYDL2D6EcC6G2EL4CEKTEYkaarc7XQ2YwB2SPJ5E15Go7XGv3IpERhX9LQxEHmL/d1uHonVC8iZ1WKqsDPtzx7IXT7/R//rcyBH2dpqWu3kf43coDoKl8P+NoEaj05tKqvXBqe9XFU4jTvSFPkCoPQswZf4r9jCk8+foKCJmAf90rNgd/PxlJtDEv3mPXTzN6tnXvLvqwkRIHXfjM8PJv2UpRGjt+po2wUP0XpfPCAZMCqxBWR81zNJOOUaRskHuZ5FKwtHRdn3F6NyxB0Dvh11qa/MCfyKUdpn0+7kfg9FnHWY64Q37/rl2B3yNnzvGNnwKkWusSW1qZLl2nKs0e+eYKdNLvwe9x8M3nDJCKeff40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef75238d-be4b-41ee-1507-08dd98999b94
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB6962.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:59:26.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8c2KC5LdKKLdo+tBd4hH1LQOwRYXH6zEBEKAgAfP9oMfc/Zroep7UYlgfkoqarZ09xJGKBijPCJPRH3fUy89VaB8y/bzcHR43Ev6yngUbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210188
X-Authority-Analysis: v=2.4 cv=Ls2Symdc c=1 sm=1 tr=0 ts=682e2292 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=RvV94qMjs56_TlnNdOwA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-GUID: 1FD-bcpInILv7K-ti0VdQmCV6uBSsT4v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE4OCBTYWx0ZWRfX9BvsaZuN9BvJ freI1vTNbuCGHWwFIgiDkDzvpf98Nutlp/YWc0K5iW3xXEFlYgoHary2MUriyczhD+B+Dg0TSLe QO2fSjFBSbLYGGmj3RPhWxX/amWGezJ+7G1GKmqpZ6G5PX0pkQ/Scbv41wTP+CoUxItV6kNPEgT
 7uwPz6jGSEy2kFv40uv3qat0BuugaYdidbrgCppZWiTN9EXdOeQOncBlsPRnM3UDRLJgm7QF68D L6gSy9uAZjVDhBZXNBCzTPwG02RWl5Ja3EL2DzqKLg4D0aF7Z+9XJxRe7bWEzbhiMUBwTy5a9YO ibtZQnBJe82XGXO/Rb4p0H/CpOAldUhJZXH+YhaSg6wyef1UcmQpGPQDQz/nPeZm0/2rMrduoCD
 icnsiGnzuuRha7EhD8kjs0DX9VxmPqWaiMs42grZzAdiOuJAgq2IdKovFyTQw9zusgsKAbMH
X-Proofpoint-ORIG-GUID: 1FD-bcpInILv7K-ti0VdQmCV6uBSsT4v


On 2025-05-21 4:36 a.m., Leon Romanovsky wrote:
> From: Jack Morgenstein <jackm@nvidia.com>
> 
> The cited commit fixed a crash when cma_netevent_callback was called for
> a cma_id while work on that id from a previous call had not yet started.
> The work item was re-initialized in the second call, which corrupted the
> work item currently in the work queue.
> 
> However, it left a problem when queue_work fails (because the item is
> still pending in the work queue from a previous call). In this case,
> cma_id_put (which is called in the work handler) is therefore not
> called. This results in a userspace process hang (zombie process).
> 
> Fix this by calling cma_id_put() if queue_work fails.
> 
> Fixes: 45f5dcdd0497 ("RDMA/cma: Fix workqueue crash in cma_netevent_work_handler")

IMO the above Fixes: tag should point to the commit that introduced the line:
"queue_work(cma_wq, &current_id->id.net_work);"

i.e. Fixes: 925d046e7e52 ("RDMA/core: Add a netevent notifier to cma")

and not another bug fix (45f5dcdd0497) which did not introduce the problem being described in this patch (a missing cma_id_put() when queue_work() fails).

Otherwise the fix looks good to me:
Reviewed-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>

Thanks,
Sharath

> Signed-off-by: Jack Morgenstein <jackm@nvidia.com>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index ab31eefa916b3..274cfbd5aaba7 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -5245,7 +5245,8 @@ static int cma_netevent_callback(struct notifier_block *self,
>  			   neigh->ha, ETH_ALEN))
>  			continue;
>  		cma_id_get(current_id);
> -		queue_work(cma_wq, &current_id->id.net_work);
> +		if (!queue_work(cma_wq, &current_id->id.net_work))
> +			cma_id_put(current_id);
>  	}
>  out:
>  	spin_unlock_irqrestore(&id_table_lock, flags);


