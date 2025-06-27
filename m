Return-Path: <linux-rdma+bounces-11715-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F205AAEAF37
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 08:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FDF1BC6A81
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 06:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E930217705;
	Fri, 27 Jun 2025 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jtU8gaKA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GrIUmMP5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B818E750;
	Fri, 27 Jun 2025 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007084; cv=fail; b=fHfRcV1cAfhAwXqzxBtBwhfwNFtbbEe0OwZ3aOC8/gDfpOt8Ek2Ha24HybTNy36mCD7z0K+cXzs6/PKsugGPk0MYQ66Arn5HkVCf2BZpvgSTNbdORQozZmOLDffY6jnuas5ZODO/dLE+GAu/hnYKfkjFkzIBb3A3b0Mdwlyz8DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007084; c=relaxed/simple;
	bh=XEmR4Xsttp9FtUTg8iMOW2vIs+tZ3gpzMoLJv9DQRLk=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=NG6PyhHppluHKRVjD+2/KdtsWYGebsyf0w/6r+HqChHghRXJXT2DF4subLtSTsxYbI3Zz+q2m3re09LxtOEEmO2dqCLThGsoBKZ5kVckFY3tjsBaxIVZVt6LcGfJkDQYMe0a/xgmISTYjjUbCUr2YoqtuiQvLmMoNCqioxDQq+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jtU8gaKA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GrIUmMP5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R6Qrno001151;
	Fri, 27 Jun 2025 06:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=HR1dyNLyfu5ndXdW
	pcyrYWqcGEEPf/Y3/9YBWguQxbg=; b=jtU8gaKABAsUZqlj6xqqo2sm+9kvTEME
	TosZ/A7THNH9Hbtw2WVl4NExhTgfDo/00civxa9NI2BstiXgiKGshF/PB3IX2m+p
	yBj6CGxAIeV9kK4a+9FCAZUp31gIfU/ZoAKBP9gT9j2u0jrzRFmY2fGZlKvycIok
	11im4V048uFVK6YL/WU5W3CNYEnhwX8KQe+dmVqXpUkYEIHzWLXjelXKLbO0fPys
	9Rf8XINs8yWpw6Ac/DYMSjnkIqUhHgH6QjHctvaK8ofkv8WUfAL3btqgjGVPb9eS
	OawyEK9AwnmpUP33Seof+R2WDL4jxXQJB7h7o4CMHNPWiDnHq1BhiQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5t93x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 06:51:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55R5thBQ017876;
	Fri, 27 Jun 2025 06:50:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehw0yr2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 06:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRRlbqqw3G+6o6wsIFCNlyOqNIFph1T/f9JuwDtmxR9def+Esf0UwKDN/Jnd7vy4xb7zrwpWVT8OLzaiiPilgJ8fxDryDvpmbUd3SLECfp/NSRnkIyxLZW76kNJHK56Q5hOVdkAFEUdUUL3d7c+PZBToqfifnZLFkycLLuJpoITupVA2AmVJOtd1AeRF0MliOXMYwQG1cAbb2Fi2dOCG9l0piIJPvCWoE5UFi0rp8CEzbYmMJ3ZMji7B3gp5oBbuAhMi6D1C/2bWmKZU86VHp86OKYm22e0KTuzOAY5JCi3n5BtPZ18DDaCThdMZE3ndw5r8/sHD3aTK6qyjDj9enw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HR1dyNLyfu5ndXdWpcyrYWqcGEEPf/Y3/9YBWguQxbg=;
 b=IppRW5b/ugtaMjFGRfRWC1LppJPzIm/b6cCkBnAV3D4rnb++Hd+A2Lj2mc0iVQyap5UoRIwoAD5EHm+zCm+JtghW+Kaa+PUnQOrCskJM1p5s0iBg+FF3TWgpqz7RsF2AlKtJISwE7nymfgjqNic4a9G0H/tI2JGiml0YbFt2tM9GOxBMm/J4rMTx/HbV7fpW+Rdgb1Woe6xoh1GVgc4ck3rZY7Sex1UgcIDEfR2SfdQhj+0m4ifK1YrwnDzyAAWdt290vTBjayvmbIqYiY+Om3O/lkgrfyM9VgkPQI6SrY0EIsaS5z01kSOGBFnc53Xop30qgQbFwYBNPEZHJfLJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HR1dyNLyfu5ndXdWpcyrYWqcGEEPf/Y3/9YBWguQxbg=;
 b=GrIUmMP5A3Q/DeCXYXgDjKeBEBrJ+eZLROZwPfl07oLEAroKh5WW2ZM93arFCQqM9v1/uNH/EhVR0Chj/jGzH42DumYqwyQnHtEIOUcL9e09ZOt69z54aG1JUpGG50KmOhWn4sYETGm3vV8ka4I3Va2M95B9zZvP/H2YJOL2Rqs=
Received: from DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) by
 CH0PR10MB5049.namprd10.prod.outlook.com (2603:10b6:610:c4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.23; Fri, 27 Jun 2025 06:50:52 +0000
Received: from DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::c672:69bf:51cb:db92]) by DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::c672:69bf:51cb:db92%5]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 06:50:51 +0000
Message-ID: <1eda4785-6e3e-4660-ac04-62e474133d71@oracle.com>
Date: Fri, 27 Jun 2025 12:20:36 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "saeedm@nvidia.com" <saeedm@nvidia.com>,
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
        "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
        "shayd@nvidia.com" <shayd@nvidia.com>,
        "elic@nvidia.com" <elic@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
        Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
        Qing Huang <qing.huang@oracle.com>
From: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>
Subject: [PATCH net 1/1] net/mlx5: Clean up only new IRQ glue on request_irq()
 failure
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0112.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::7) To DS0PR10MB6056.namprd10.prod.outlook.com
 (2603:10b6:8:cb::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6056:EE_|CH0PR10MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 06735cc5-289b-4964-a930-08ddb546f4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXBLaGNpalpobEZTeXBjU1FxK3gxN0k4U2xkN2hBeU1KWng4SUU1dFN1d2cr?=
 =?utf-8?B?L3N3N1ZPOWo2UTg5d00zaUpFZ2hpblJIOFovcjRqNU9KN2lBd0xuQ1VFd0RO?=
 =?utf-8?B?VGM5VXkvbS9ZR01XSWp2V0dPeUppYkp2bzJPN2FqK1ZlRm45cm9sZi9VN3hW?=
 =?utf-8?B?eko2U1M2Sk9qeE1zRUhzZlMrZ0tyc0R0NkxQb2VsTURPT3VlcWhTYnBCaHpU?=
 =?utf-8?B?YnNpQXQvZGwvWUxrWkpIRnZmdk5qWWdCSzAyZFFpV1crRS9iTUtsaTI0c25W?=
 =?utf-8?B?K1Y5YVkxZURUK21saE1vL25Hc3NPVGNVOXZqdTIxM3JiNjIxcjEyQlFWbFhp?=
 =?utf-8?B?TzFJOE9UYkFZMERpcy93SzFBbTh0Q0I3TjZUTUhKNU5ZNTliUHpVUWcvQkg1?=
 =?utf-8?B?L243K05rekRndzdXREhHdjAzUThtMnJYQkJxVS9OREYwU0tSSStHaktOME9r?=
 =?utf-8?B?WVU5NUNvR2x2cmpYVk44dFhZZjFycVhmRitEeWY0R1JaMlBkR3F4UUhoMnNH?=
 =?utf-8?B?MzJGQmp1dWJnaVp1MGowRDdleFNlem4xeVY2OTVxTFN4RjI5eWJMa3diVVhq?=
 =?utf-8?B?Z0ppUjZHeWQ1RHRRcFFhUzc2bitMYll2TW41d281L29iQUI2RGwrcWJVc1hK?=
 =?utf-8?B?RVBvV0UydnhHWVEydStONXJEZGpHbVM5SFU3b1d5OTNZM292VjVBdzhCRkk1?=
 =?utf-8?B?Y051VytUYTh0MEl5M1Y1S3I2bEVJUmk5cXZOalRvUmllQ2E2ZlhMYk5IVVFS?=
 =?utf-8?B?eWFTc0JPZVkvSWEvVUczZ2p0YWR0SkdxbFQ4ZnlJaElFYW5vYXB0bGxWbC9H?=
 =?utf-8?B?NEMyRk1yYUNWVFpVNVBvY3FmTmVoSHFaT3lGVVdXYXpnRlhybllKeFlMTXcz?=
 =?utf-8?B?RGtVaXJPYU9qL2sxOWhYdjgzYlZDUE1kNDlNemkxckp2TGpqV25kMFdDQ2ox?=
 =?utf-8?B?MDZ3VHdWSXBGZmlLZ0pYWnczajhQclE0eHlkMm1lQlNDR1R2VGl0b0cwTXgr?=
 =?utf-8?B?SFJEOXZydHNXTWlhTzVkWGJTQU5sZDA3ellFVThsOGZSbm1VU3ZicFVkQk85?=
 =?utf-8?B?OWZ5YWFDcXZGbU9zeFhoN1hINHEyMGhhYjR0cVdKOVlyZklsNUpGV1dQTnhX?=
 =?utf-8?B?YzdUdmt3bklyUjZLOElyT3RaMFgvZnFRUnlhYkUrd21qNEM1T3ZCWjZkbnAw?=
 =?utf-8?B?S3pzS0JpcW0vbmxxYWJFelNsQTV5cUdITjBacitCSVJiWnRzTWFSck1HN3Rp?=
 =?utf-8?B?YjJGT2pFeWVQZklRMTZUS0V1Q3VPRGxaWmR5SlllYS95ZHkrSXpRc0VYR2p1?=
 =?utf-8?B?Y094WkZQUkRQV0ZlWXBqQS9CREhMdFBqdVo2WFBwNitWYXNjb0hNcnprZ3k1?=
 =?utf-8?B?Q1kraDVLSExFbHZMSFZ0cDk4WUsyWmdLNytOazBZYWs2Wkd2cEhZcGJKcFFH?=
 =?utf-8?B?dGxmMWRMMEhKTmJCbHdkZHdwN2hJODVNYTR6UDBPcFRKcUJaQVg1cUFxakR3?=
 =?utf-8?B?WVhnSkE3TXVFT0Ewc0lBdzVGdVZTRXZFZ3pUaFl2NEN4SmdmZ0FKU2ZXZE5p?=
 =?utf-8?B?NzdJOWdYQU9jVG9vYmZHWXNIVFZuakdONVk5RmV5SnQrMWpkaWdaVk1XQktL?=
 =?utf-8?B?N243blhucy9sYkU5ZHRmZ0ZuUDJURHQrRzlXRDA3SVNUWDhZeFVieS9rUTF6?=
 =?utf-8?B?ZTFzSHRqU25KL0FxNTZhZkpNSjkyRWtZcFJrTGo3ekNYTDQ3eGU3Nmd3MDh2?=
 =?utf-8?B?NE84NEZMeC9YT0JqQUVHQ0VrdHBxN2h1OER6dUlnRG9TdzlLeWFOTWk5Y3NX?=
 =?utf-8?B?alFHZEI1TGgzUFRmOEkxS1ptZE9LWnJLUk1rMWhhemhwbnlUSFBhZzJyN1pT?=
 =?utf-8?B?aGN4NmIrdG03YkZKdVlJTldtWEc2VU9aT2JuekQ4ek9CVGxuRS9lODN0Z2hw?=
 =?utf-8?Q?2E7tPx4cxpk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6056.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW0wTUE4clBwc1h0dkdheVdMWnQ5RFRFaERhcTBVRnMzSVJxN3FvYXg4ZXlN?=
 =?utf-8?B?bzRtZ0pQUkozVEpvTytVeS9MaTJsNmwyemRrWkFmZExEa3lWU09taDVZZ0VG?=
 =?utf-8?B?VWp0bzAvcG5qMStYcnBpSXg1RmhtTWhRc1JkcU1qWDhxb2k3UFB5bytPQzhW?=
 =?utf-8?B?OWY0VjNkSVYvTk1VVWxNNUZqdGN1djRjVUIzY0dLMmhSckNicFZPdnBXNlpa?=
 =?utf-8?B?RTNiUFl3NVc2NWZuSFJxVE5iM20xNzA0ZmEwV2VSellQdWowR3pCUTBtdWpC?=
 =?utf-8?B?NkxQRDdoeDFvNnNKSE9PL1paYlBiQXNwcjJyektaVUhSOFZuV2FNY2hmVzQ0?=
 =?utf-8?B?V25YWi9MSUFOOHRZUlMzbWZtaGlRc0N6WTR6bXFzd3B6ZlQwL3BHdHlQRGw4?=
 =?utf-8?B?aHJuSVhWc1RqbGhDOWQvMWhaTzVOU3dOeFdvTWJHbERCTGlIRXdITUt3QXRu?=
 =?utf-8?B?T2Q2eWI3UFhGZm1DRThNTy9zanc0MW1XSnhmYWI4dzRhNDBJT1J3Y1M2ZUdk?=
 =?utf-8?B?aHpnaWd1enBKNkRmQzlINmtHTmNyT1djNE5wOE5UWisydHRDYnRPRUpTNTdx?=
 =?utf-8?B?TUhHOGVQZjlFOThURnFvZldQODRrcWtZZUZqaC90UDU5S3F3VHFTZFJ0L09p?=
 =?utf-8?B?amVSWUxWQWg3eUhDOGFwUzBsYmVlVXdLdUlWOGkyWFdDZnNUMzhxa3pTZGcr?=
 =?utf-8?B?ZzhPTDkrSDRCeFpsWUIzWTdkUUVTU2RIR25sQ0QxQzNaL0xReTNJMWYxUWlk?=
 =?utf-8?B?dVRwZ1N1U3p2R05hS2xlVjUrcUhhL1Q3bVlhek5TTC9QNjdVeXRMTjVodU1x?=
 =?utf-8?B?enV0alg0amVieHNUUTUwYWk2L1ZXNklDVXQ0RzVLWFlUZXdyUGExU1h2S0Zn?=
 =?utf-8?B?L0NRa0tacEFZSFJsYm1PNlJhS1c5ZnpqclZMWEhadmhOb0M0Q2FkSFZQWXVM?=
 =?utf-8?B?aWozRW1VMmhLN05Lek1sdkNYYk50YlB1WjhoRGM5M1A2eFgvckVpYXRtM0k5?=
 =?utf-8?B?WU91Y0dsczU1ZVNVM090M1p6OWVqRXhXcnRQL1AyZ2cxbzRocGJ3ZkRRMmwy?=
 =?utf-8?B?Yi9DclZtcGNtMm5GTUNmamhpa3hGUkhDWVNFRDNwNFd3cGtDWXdISnVXUmMw?=
 =?utf-8?B?dEFINXdyVXRhR3RaMnVFa2t6MVZsTTYrUSt0WmZ2RDNUcWVpQVM5SFFVbCta?=
 =?utf-8?B?dE94NlFRQ1dpWkorb0J2dHRYZlZLRXRJNW14UDk3bnZESUVNMFFFMm1WUUVJ?=
 =?utf-8?B?a0hwZW1tVDFUdEEzdWlHYlFZeUNEdkhzQ2IvdEx2VTQvUHdGZFZEY0dhZjRM?=
 =?utf-8?B?bFRMQ2lMc1pRSjhFWncraG1zZW9KZDM0K0xXZUU5UVVpbzZNODlFSzZ3a3lW?=
 =?utf-8?B?QjN4a3ZLdlFDRVRPM3FZeFhKalVHYVMwczRVaGQyN0Fnd0tMYUFvMjFaSXBr?=
 =?utf-8?B?TWR6VG52Z1JlbjZhRk1ia2xNVG8rU0JGUWhJQ0FKdVpSRWV1eTR0ckJ1VmZC?=
 =?utf-8?B?MEZweGhxanpoR2cwSnlXaFZpY0Q2d3JFWm1KTmpkK2JJTk4vMzhmbUpBNXp5?=
 =?utf-8?B?TFFGbklkNTNYR21jN2dvNnVQN3dZNnBobkJSRUFEWk5pNXJ1OWZpWGwwaHZj?=
 =?utf-8?B?bU5udnlQd1FKRDdlcHM1eVRkTEhwUXZ5b1o3MmlaUXpnS3VIOWhia011UUlm?=
 =?utf-8?B?cGpZK0ZiSzZ2WTFLQ1pHUWlkNXp5SEd3ckJXOFBqelF5MUg0Y3BFZmU4QmVC?=
 =?utf-8?B?NVFOWDJ2MmRHMVllWTJFVWpPTjU2QXE4b1pkMUV5RUVYQlVqb2VTYnJ4cHNU?=
 =?utf-8?B?TGtpOFpON1VIVDZFMVNVQTRuUStwb0pCdDBJYUZMd3VJTCtkN3FtYXpoWG4r?=
 =?utf-8?B?QVF5enE3Y2Q5SzFrU1Q5L3ozQXlod1NUeWxxS0wyOEZ2TFM4d2N5U0ZWbXVD?=
 =?utf-8?B?Q3JPQkFjQVl2UG5udzJQWE1wQjJZTTNmYmFSdW9CYWtRdzF4V203RjF0enBO?=
 =?utf-8?B?WGxOcFE2cDRrYmNQZ0tTWmVROGtOdE5hS3RvUE0rbTZ5NnRyYkk2bExEa3hO?=
 =?utf-8?B?UjVhb2Z5ZG9QVzZPM0lPeG9nMFA0empGNm15TkdsRzEybEtKNWNwYzBGMnRM?=
 =?utf-8?B?ckVBMWNhZSsxKzJNdzEvTTcvMitIMndHYUdPVm5hd3BMeFBja1lSb0dRZnFG?=
 =?utf-8?Q?+mvF31eEtkuVEuCTMK+k6AM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rsQkw3O3O8t4h86wuPHfTNjuahACUvfJV3GThNXMFd2DcykPN6DEIXKulFQO6H8jWwgDMMzZf36MYg2eSUpqgRpeAiu3P2y49uxJaGQeybqbxd7EpHLY2FX3lFOintKTpjxJRVam2lH7XDiJBiuRl0/Tzy5Cned+DAQDk9wrnn58YKbNF5CBnazKo+c6AsG+5Kc3SIpvO+xdaEgHDgLIxM0MgoSv6t2HOobBktIWFH9C8fPggfR7S+IuT7+s8t32NGLIc8ir9vCgo3nk4rmOXmu1EPGrgl+NFc4t1v7v8OAXjywsl4f0oXIb+RLY3dOrW5ACRMtXwSj8PL8yZel5meTMMdQTtYNs9Ekvsi6mp3gw2hxMW2JR+JYegvoC+pQxHk2bKFGpjMBwCEZr/cqtYcrtu/iURo4hxjdcDpW3+QedorAU7yUXzIage3hZi303MbScJLVn1J8RUt1TjIZB08WA85WgJB2ZKirKPaQjSdCmfvr5Rd6U61RnJ0/fRhQApSm9kqCR+3HuGjOGToch9vQhBxXsIRo4dBBSOC+tQVv1idv1UBpJrcKjcQnVKNHO++Dv0sPAiaEUx1V5UrYpyqahjutYpGvpoYay/nLHHag=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06735cc5-289b-4964-a930-08ddb546f4cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6056.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 06:50:51.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eh8Z0ry3SdO9V2ue9/uesumKLwCmoAJsjxU4JBA8EUUQqdJIZNU6rRVCe56OuOiFw2kTwiX2yFU4cnh1/kO/Ewtwea+CZu1HFXCciv0VOIGudI3YfrqnmeqNusG9N2sg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_02,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506270053
X-Proofpoint-GUID: 44eiBQKpkWd2u6EAlB_f3TBJl9K4g5Xq
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685e3f5d b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=ZYKq80_RobotJUz1yaYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14723
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA1NCBTYWx0ZWRfX9wMRAcu2cwgl gEEU0r7eFI5LWQn4hEFyaWGUi2eDP2tOsFfqJJ23u0/8ru+0Lshwxqq5NmZzeCoeLY54wKpYveu w+YsrxHyO4d0mKWpjuhbaJUDtBYJey4CUrerOv/EhQgiDHLr9pQa16cvAOZvW/P3pHDEGBGb3hD
 xlNiHgCHt0H45FsYkr7ZdNKI9J5SPV/Pj+W+OxXIhwmM1VmydBMqbep7H2xn7QQKywp3wYcZ033 vB/0j7qLVJUMzNZnuLJWQKUMDwllViAo2XYBCrjxhTYQ6lLh6Cgqm7kJFGHACF3WiwvjT8xurI5 wRK6ylICyLm0nh6ksBz5y1FAWr2qotfpl2/eMrBTKfpKFP5s9fHgWUYH3KARU/unJeQ4C5C9I9Q
 uOQW2Iwo76RC3nkVJ7aSNt2kbALsJef6OWj93boovTTvMxu1/Yac4mbxgIDap5dr6z7P5aS6
X-Proofpoint-ORIG-GUID: 44eiBQKpkWd2u6EAlB_f3TBJl9K4g5Xq

The mlx5_irq_alloc() function can inadvertently free the entire rmap
and end up in a crash[1] when the other threads tries to access this,
when request_irq() fails due to exhausted IRQ vectors. This commit
modifies the cleanup to remove only the specific IRQ mapping that was
just added.

This prevents removal of other valid mappings and ensures precise
cleanup of the failed IRQ allocation's associated glue object.

Note: This error is observed when both fwctl and rds configs are enabled.

[1]
mlx5_core 0000:05:00.0: Successfully registered panic handler for port 1
mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to 
request irq. err = -28
infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while 
trying to test write-combining support
mlx5_core 0000:05:00.0: Successfully unregistered panic handler for port 1
mlx5_core 0000:06:00.0: Successfully registered panic handler for port 1
mlx5_core 0000:06:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to 
request irq. err = -28
infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while 
trying to test write-combining support
mlx5_core 0000:06:00.0: Successfully unregistered panic handler for port 1
mlx5_core 0000:03:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to 
request irq. err = -28
mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to 
request irq. err = -28
general protection fault, probably for non-canonical address 
0xe277a58fde16f291: 0000 [#1] SMP NOPTI

RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
Call Trace:
   <TASK>
   ? show_trace_log_lvl+0x1d6/0x2f9
   ? show_trace_log_lvl+0x1d6/0x2f9
   ? mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
   ? __die_body.cold+0x8/0xa
   ? die_addr+0x39/0x53
   ? exc_general_protection+0x1c4/0x3e9
   ? dev_vprintk_emit+0x5f/0x90
   ? asm_exc_general_protection+0x22/0x27
   ? free_irq_cpu_rmap+0x23/0x7d
   mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
   irq_pool_request_vector+0x7d/0x90 [mlx5_core]
   mlx5_irq_request+0x2e/0xe0 [mlx5_core]
   mlx5_irq_request_vector+0xad/0xf7 [mlx5_core]
   comp_irq_request_pci+0x64/0xf0 [mlx5_core]
   create_comp_eq+0x71/0x385 [mlx5_core]
   ? mlx5e_open_xdpsq+0x11c/0x230 [mlx5_core]
   mlx5_comp_eqn_get+0x72/0x90 [mlx5_core]
   ? xas_load+0x8/0x91
   mlx5_comp_irqn_get+0x40/0x90 [mlx5_core]
   mlx5e_open_channel+0x7d/0x3c7 [mlx5_core]
   mlx5e_open_channels+0xad/0x250 [mlx5_core]
   mlx5e_open_locked+0x3e/0x110 [mlx5_core]
   mlx5e_open+0x23/0x70 [mlx5_core]
   __dev_open+0xf1/0x1a5
   __dev_change_flags+0x1e1/0x249
   dev_change_flags+0x21/0x5c
   do_setlink+0x28b/0xcc4
   ? __nla_parse+0x22/0x3d
   ? inet6_validate_link_af+0x6b/0x108
   ? cpumask_next+0x1f/0x35
   ? __snmp6_fill_stats64.constprop.0+0x66/0x107
   ? __nla_validate_parse+0x48/0x1e6
   __rtnl_newlink+0x5ff/0xa57
   ? kmem_cache_alloc_trace+0x164/0x2ce
   rtnl_newlink+0x44/0x6e
   rtnetlink_rcv_msg+0x2bb/0x362
   ? __netlink_sendskb+0x4c/0x6c
   ? netlink_unicast+0x28f/0x2ce
   ? rtnl_calcit.isra.0+0x150/0x146
   netlink_rcv_skb+0x5f/0x112
   netlink_unicast+0x213/0x2ce
   netlink_sendmsg+0x24f/0x4d9
   __sock_sendmsg+0x65/0x6a
   ____sys_sendmsg+0x28f/0x2c9
   ? import_iovec+0x17/0x2b
   ___sys_sendmsg+0x97/0xe0
   __sys_sendmsg+0x81/0xd8
   do_syscall_64+0x35/0x87
   entry_SYSCALL_64_after_hwframe+0x6e/0x0
RIP: 0033:0x7fc328603727
Code: c3 66 90 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 0b ed 
ff ff 44 89 e2 48 89 ee 89 df 41 89 c0 b8 2e 00 00 00 0f 05 <48> 3d 00 
f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 44 ed ff ff 48
RSP: 002b:00007ffe8eb3f1a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fc328603727
RDX: 0000000000000000 RSI: 00007ffe8eb3f1f0 RDI: 000000000000000d
RBP: 00007ffe8eb3f1f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffe8eb3f3c8 R15: 00007ffe8eb3f3bc
   </TASK>
---[ end trace f43ce73c3c2b13a2 ]---
RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
Code: 0f 1f 80 00 00 00 00 48 85 ff 74 6b 55 48 89 fd 53 66 83 7f 06 00 
74 24 31 db 48 8b 55 08 0f b7 c3 48 8b 04 c2 48 85 c0 74 09 <8b> 38 31 
f6 e8 c4 0a b8 ff 83 c3 01 66 3b 5d 06 72 de b8 ff ff ff
RSP: 0018:ff384881640eaca0 EFLAGS: 00010282
RAX: e277a58fde16f291 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ff2335e2e20b3600 RSI: 0000000000000000 RDI: ff2335e2e20b3400
RBP: ff2335e2e20b3400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000ffffffe4 R12: ff384881640ead88
R13: ff2335c3760751e0 R14: ff2335e2e1672200 R15: ff2335c3760751f8
FS:  00007fc32ac22480(0000) GS:ff2335e2d6e00000(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f651ab54000 CR3: 00000029f1206003 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0x1dc00000 from 0xffffffff81000000 (relocation range: 
0xffffffff80000000-0xffffffffbfffffff)
kvm-guest: disable async PF for cpu 0


Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
Signed-off-by: Mohith Kumar 
Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
Tested-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
Reviewed-by: Moshe Shemesh<moshe@nvidia.com>
---
   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 3 +--
   1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c 
b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 40024cfa3099..822e92ed2d45 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -325,8 +325,7 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool 
*pool, int i,
   err_req_irq:
   #ifdef CONFIG_RFS_ACCEL
       if (i && rmap && *rmap) {
-        free_irq_cpu_rmap(*rmap);
-        *rmap = NULL;
+        irq_cpu_rmap_remove(*rmap, irq->map.virq);
       }
   err_irq_rmap:
   #endif
-- 
2.43.5




