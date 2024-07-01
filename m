Return-Path: <linux-rdma+bounces-3574-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399A991D790
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 07:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37DE1F22BBE
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 05:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE2039855;
	Mon,  1 Jul 2024 05:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IHTheDbm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="unh3QTyA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01A2BB04;
	Mon,  1 Jul 2024 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719812503; cv=fail; b=Rnuw6FxE7sYki4qrP0qM2BRJOoXVDsTFWfTw/jOWDzEzTw1AjN9DIfo+e3gXrrDM6A4c1iYe5N+7bT7TsAgtEr2PjnpUet4IyaWZQ8cgmFkCvE05QZw/25OA63/ZAZvweJs4Y8VGYqn68Q1QMiLrZcV3EbwbxytQfLSizmB71Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719812503; c=relaxed/simple;
	bh=BZ+7uqAFJNBVo+r1dcjfF+CUwUtaSxcIPqV2V+NvmyU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V8iARkl7PQd2mrNvH7lZLhuA8XAZve1+IuxZWzTmOc6WwJec+td7UpQqrzasrVjWZPI8gHzql3SCt4oFpGFxE5scFMhoQ2ZZvey1QQ74VtPYZXgvAMIQ+7b2TuT41/7vodCRETAE+EG8bIH+Lb5kdHrY0ZIy6cWUFIc+ixRfs8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IHTheDbm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=unh3QTyA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UNlW8o008814;
	Mon, 1 Jul 2024 05:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=WzgDdvgF851838XFl5E8DGmpdvUgI/Ms0zVKsIvyGis=; b=
	IHTheDbmDx2FKmc7j6SXNnGWXc8MKAoNePcf30g1ODlDHjvPFI8hrnvFX8UOFK2c
	C/Eb3QsH9iRH6xQfFzZvvo46KjBBdw/zOnH+vMvb2R+B0dTZIGbcU/RgqhfUz56h
	hd5OrrvcTGRTLOBXeIlQQxf/mnckPBHUO9dgvF1QtH2KcRaCWeofgYjO9MkzNd5D
	zcETo5ekt67E7SRxmHD/tdRujZvFsfegBpWyAlFF8SnCvGAi3md9m/WqKKEEupeU
	rXGrmSugsOBMPnO1VHM/l07fET6tqDE2FvSUsoDnl+YT8RteqjgrBtJbDwtH1nGZ
	C59H5653uNbnDsNWUM4NMA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a591txu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 05:41:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4613DgRU022844;
	Mon, 1 Jul 2024 05:41:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q5shft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 05:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9J97jnBcH+fRen4nT/6iy30imOYzK3RJAZkxLy7K8c43dVO4WiTmce73nR3hKeFfyKMFsWEYsyHWqsQWW1VT8gycGQw645GyXi72HkAFIKB3JshNaoNAB8Dp5iqD/mLRkrWssCACf4IvfxZBDoj0SazfLFFFWEVxp6dcOfeIGyuVoClLgK3MZnFMEIJCKSARI8SYz7kvWoYon2+3g+DL7DUNDymmc0JsqOazlUHXX7DaySLBA/eJPAWgNOJExqvL2cppWseJpmqdHx3GyH6f6UL32yu/yIjYBORtOcj96LwANZUKDAO4DvyXueH10xEpUJFZMvNbj7qufAJVmARtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzgDdvgF851838XFl5E8DGmpdvUgI/Ms0zVKsIvyGis=;
 b=O5tZqN4M653mLJySr+ERVotJS00DzL0eBobAzJ+Rm4WXHu6dphl1d7c3c23ZqJ3U49L9ii4pMo3Jueg9Qp1/EAQXFGUMvpL5cJMg+yW68yjDpBaIzZchZK81BCuEuYR4E5MK1V7fJt3+fAFYffG1wNI7TIott1BAmX3NIY5aAWFjjXdhZHuqxna4AQIRkY37FQeUsv7GyxJkj/EwLl2hbYmKkvuynxINaaqwfDp9xDdTkYnkqgBIXnkPryVCUT8bl2inBAgfCQLcQ2Fxo9JX7yereM1yzh8PfGvIoOLRXIJ1DBl61FYg/watlEtPBkiyFfru7OCiNNWx9398a8DIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzgDdvgF851838XFl5E8DGmpdvUgI/Ms0zVKsIvyGis=;
 b=unh3QTyAjlDQJRlKKyturntK3zOoDA24FUMcB7AeTV4KkyfSz5Bnozm+DeEkR9VYCDbPC3BxSEgkcc3+tcODQPkqw2EyVgn2zObgyFMV/NJzZq9m2jVJTPzCtJVEsvfHfWF5X0XEynH3rF8DfwJF++9WW9MRit1TQWp2j1S/87s=
Received: from PH7PR10MB6108.namprd10.prod.outlook.com (2603:10b6:510:1f8::6)
 by DM4PR10MB5990.namprd10.prod.outlook.com (2603:10b6:8:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 05:41:25 +0000
Received: from PH7PR10MB6108.namprd10.prod.outlook.com
 ([fe80::e919:811:d952:4a3c]) by PH7PR10MB6108.namprd10.prod.outlook.com
 ([fe80::e919:811:d952:4a3c%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 05:41:25 +0000
Message-ID: <2673153f-3330-4a02-8bf0-ee1727715381@oracle.com>
Date: Mon, 1 Jul 2024 11:10:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] net/mlx5: Reclaim max 50K pages at once
To: David Laight <David.Laight@ACULAB.COM>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "saeedm@mellanox.com" <saeedm@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "tariqt@nvidia.com"
 <tariqt@nvidia.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com"
 <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>
References: <20240624153321.29834-1-anand.a.khoje@oracle.com>
 <0b926745-f2c9-4313-a874-4b7e059b8d64@intel.com>
 <1f9868a7-a336-4a79-bc51-d29461295444@oracle.com>
 <666c79de2adf4959bd167f3f1c45e1fc@AcuMS.aculab.com>
Content-Language: en-US
From: Anand Khoje <anand.a.khoje@oracle.com>
In-Reply-To: <666c79de2adf4959bd167f3f1c45e1fc@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0244.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::13) To DM4PR10MB6111.namprd10.prod.outlook.com
 (2603:10b6:8:bf::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6108:EE_|DM4PR10MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8150b4-ecc5-4dee-dd77-08dc99906a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cStTRlF1MXB0ZHluZDI0ZG0vU3N6YTE2a3J1TkxBMFVJL0Y4Nnk2eXU1czNM?=
 =?utf-8?B?VXJmYzd2TzNvRjdYU25UaUtNTzVJc1BHR29pdmlUUVRMejhOS2tNek9kU25O?=
 =?utf-8?B?MkgwWmlSMzhSbnRZemJwVnc1L1RSV0tEY3o5ejVjRXF2TUNpRzRub0RGdnB0?=
 =?utf-8?B?OWx0MDYvNk5INmxobHJlWUpycE5SbUZ3ZHc1MGpNRFV6cVMrcG5DZnQ0aVV1?=
 =?utf-8?B?NDhWSlQxUVZsY202aDEzcjFiTlV1VWx6OFpaQktwdURTUURib1VVdHRsQmYw?=
 =?utf-8?B?VEtuVTdLSVlZWWFITitYUmdSeW0vOWsrb1cyL3FObmpOL25DV212RkxPZTVI?=
 =?utf-8?B?T3dGak0wazh3SmNFNUY3QXRoUWN5U2FPUTFBRmN3enluMUdwTW83aEJWa2Jw?=
 =?utf-8?B?bVJRVTQvYkM4cTdKK1FjbGJTVXpOclVYWmxtaDdrNVhuVXZtd0p1OE5haTli?=
 =?utf-8?B?bVFsNGgyekFYd28vVHRxQnppaFVEYi8zc1lwd0ZjK3d3cTMyL01JYjZZbTlB?=
 =?utf-8?B?UzVnejhEbmpDdGpzVzZTMXdYR0NSMGZ6S0JzWW9CeVdyaHQ5OU5MMjhWdXNW?=
 =?utf-8?B?c0ExcVQwOUNnMG5qWkc4b1lIWEZNZ2ZtYVpZU1dzQjYveTNubnVKOXI3MjhQ?=
 =?utf-8?B?SlB5cVQ1bFhMelFTT2lNUWVKZWd2N290cml3S3N0QWhQRXVab0NyanQ4UEpk?=
 =?utf-8?B?WW1JSE9JazZ3R0drWHFuQ0lXZFM3TngwajFIb1FVc25EWktRdTFmOW9QTVNE?=
 =?utf-8?B?TWZNdElzUlFCcy8zbUh2ZzZIWnVGVEYxMUVTRHVqUVFINzd2cEQ2aW84UGZS?=
 =?utf-8?B?M0JDNjVCN0JxUGY5SEdvYWU4NGNPY1g5Y1djcnJvRG5NYktCbnpYbkJUTktk?=
 =?utf-8?B?ckFLR1ZaZFdHZ0lGOFUvVEt1WWJpc2Y1L2M4V0Fwa1M2cFE2YnJiK3dNV2pr?=
 =?utf-8?B?amFNUVBJU0pmSjZaR0ZkWWQzV0gyaGQ3MFlRYW9jdG91L1VVQkxwUlp5RjFz?=
 =?utf-8?B?S0RoTWdsMTZkNFVYYUFPWlQ0RzdJM0VxZS9IRWFQSzJlVWo2U3pWNTFZU01T?=
 =?utf-8?B?dkRVejlLOEFrWTNiRmZ5N0duWW01YVZkOXg5OXZaTTVXZUlCa0U0OXpjQXFU?=
 =?utf-8?B?dmJNSm05cWVXUTBSbVd0SjEvYXlyVjN3aDROK2RQOVlvdXdRRFZ4eGZsVnJ5?=
 =?utf-8?B?d1NYWkNaM1FZcVRXUjdaamtMU2ZUYUhkUUhCYVpqR0IyYlh1eUF4VVVaem9P?=
 =?utf-8?B?dG1BaU9ISEJNbGRiVC9Ibm1rT3JNZHV3RE82QkczdkZoY0MxMVNFazlWVDAx?=
 =?utf-8?B?Y01STHNGWE10UkgxVWprQ1VrZFpyNnR6MmtiMG8yaXExY0tBdmVkdjNDY3Rn?=
 =?utf-8?B?ZWRjNlA5emhoTU42bHBJa0swSzZZRE5KaWpVejFiYWl1Ui9VNkZIUHBhVXJo?=
 =?utf-8?B?MW5aZ1NxaGlxSDhiMUpVRGducG9GSDd1Q3FzZXUwRmNzWmw0WVg3Z3hIelRi?=
 =?utf-8?B?TmY2MTVxU2IyNGJQTkJRY040U0FXT1BWbnFwZzZMZ1lIRlNxdnhlRHpqSnl0?=
 =?utf-8?B?bFhQb3F4NEs1Smhha1ExbUh2Wk1uNnNNWjBDcy96UlFZb05hTktjUzdNQS9T?=
 =?utf-8?B?SVErb1pONFFKV0EwbVUvZVgxVG9qZnFOMnBHTHBxZWJmWHIrMzNCbVNUaWl5?=
 =?utf-8?B?SGhDdlp0eitqMVFrcWIxQmJWYWVKR1VNWlJuNXluZU9qcVl3ZC9FT3BDdDcr?=
 =?utf-8?B?cWNiTFRxOHdDczR3U0ZxTEVKd1ArSHhVMThmdHRxdGdzK3dZUisxaXBNdVhI?=
 =?utf-8?B?M2ZlT3hReVFGY0E4REVsdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6108.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1lRVVRRODI4OU92aUVCYXlMR0ppV2hJWkpkcExMaG9pekt4L1gvcHA2aHBZ?=
 =?utf-8?B?eVlZWTdHT1hjV1NVc0VEY1IrMnJEbUx1UWdpdEdTbFNMNTBsMjZBTENYZW1L?=
 =?utf-8?B?cm4rby9UeFpPYlRESHkreXROMG1OY3Vvd2FBVXBGWXlaUGlFK0djM0xkQnI2?=
 =?utf-8?B?bU82bTFVQ2xXU280eVdwNlhDMCswY2hCK0d4TEM0Lzk1SHdUNW5TTXdMZHQy?=
 =?utf-8?B?OFQraWJ6YTllNGlSbTlaYVJ4dVlpWVVqYytsWVhOVGo4S3lsMjhwdHpoYVA5?=
 =?utf-8?B?T2xmYUUyaDl1cGRkR3hSQnlkZDN3Y0E0RnlmT2laL0J2MWVxbDI0d0xpczYy?=
 =?utf-8?B?OExMTkxmMUNXaHlSMzNkaU54WkNSc0c2V2VDcTBRd2IrZXJNQVlHRkNnUmov?=
 =?utf-8?B?MGtsT3RxeWVGT2Zkc0M2NnRJQUpIVDJKWGtDWVBhSG5EMjdLekVVUmJSbURE?=
 =?utf-8?B?QjhrK25NcFg5dDlkQmkxc1NWcHdYMFY3TVphNHQ1cTVMVStqWnZMa1BicW5y?=
 =?utf-8?B?aXVVYnBrUVlsWUNJaHRERWVLV3hFN0ZXRTh3ZWRmMDRrYTQ1UWxFTHBqTDh6?=
 =?utf-8?B?ZGJMSzcwU1I3SXd1b3V6VlVQam4rQkI0MW1sV1hMcXd1blJpTUJEMlE2SjJ5?=
 =?utf-8?B?Wm43MkVjSnZEcm1LR2E3em5XYW1kTzc2U1J1c2ZXaENzUlJHY0oxWDhYVmxS?=
 =?utf-8?B?bnZpQkxiMmsxWTRxbzFKMm1Hem16dXNqMVNLV003NE5LMklsU2l5WmpsRy9N?=
 =?utf-8?B?RmMrbkJSQndhZzBJeG9MRk1HcUFFYmxNQmV1K2t1dXpFV0liYU5FeEpPWmZX?=
 =?utf-8?B?eWJVeG42dVhERFQxeU9Hb3JaQThzbmV4OEF5THpHd29HMDdLeVFzRU5kL1RZ?=
 =?utf-8?B?N1Y1bnRweEpSdk5Nb1FFaWRqRlo4cTR3VUNGeFE1dGF1SDBjL0oza1d6MEhI?=
 =?utf-8?B?L0ptNERvcldzQ0NiUWJsQlRId0NqTUNGVFZLSERmcEUrUXo5K1ZBU0U1OVFh?=
 =?utf-8?B?Njk2MStWSWh6SmVSODYxQUMvdTAxd2J2aFBKRzdZUy94b3FaS2FGQmJJSnVT?=
 =?utf-8?B?UE8rbDVJdURmMkY3b0Rsb2lDZzVjSHNZTkxPWmVYY2lrYTE4SU5aSWkwYis5?=
 =?utf-8?B?MDRRSCtTekhrV280ZG8yUllLdm95c0ZPSUYxTXFNZWZjRVhoM2xjM0w3Mm5Y?=
 =?utf-8?B?VXVGOEJzek5wZkI2OVV1WXZ2R05oVkxCN3ZYNUVHdTNpUkJnTkhSSEZ0NnA4?=
 =?utf-8?B?RTVUUGJvOFcwa2UrUWpzZ1hDVXdYRGZZN2V6RVlKbllNT2QvT0J5MGl1Q0x2?=
 =?utf-8?B?S2FtdFRGN2VSKzhvWENXTWl4a1lBVWtMWmJuL1lCZDNRREFITER5aUJMcTI0?=
 =?utf-8?B?YTJ5RkJuVUtzS2paaURXbjZWUUUwbTJ5Y3BTNTFWMTVwZmFERkZNcjJtMmVs?=
 =?utf-8?B?SWVtMlZkckZxV09jVlg0ZkVLY3JlZnNIWE54VE1TakVXTkZtQkFjM3dhcUNj?=
 =?utf-8?B?d1VoTGp1UDJLcnZNNjlhRk5aVFNNaUdLTnN0RkJWNFhsY0U1OWplNUpQZGxB?=
 =?utf-8?B?VWlYWkVzb3FvSk9pdlo2NVJOU0lzalV2eUdYQWQ1MGV1RG90TzZ2ZkFORUJ5?=
 =?utf-8?B?Sk9jN0FZZVhvVndYc09TclI1bnlES1NCMFFoWHJqei9GV0c1c3VtdDdOOVd2?=
 =?utf-8?B?LytabTh6S1ZqcUg5YXFMUk5yS0VvMHQ2MElwWjFJVFE3MGlyaE9XWXNoNFU5?=
 =?utf-8?B?eTRwSVhLWEU4dVkrNlU1ODVwZ0MrajlQbVQzcUZZeXBpQzJRK0VReXROUUFC?=
 =?utf-8?B?RnczREhuUGNCb1JZV2hUWHJoU1YzNElvaGVvTkRxdk1TY0pVR2ZFWXAxeW1Y?=
 =?utf-8?B?L1pOQWh3dnV6Znc4ekk3YXdXQjExbFkra2RjNG5VaXMweHJON0hzQUprSWZC?=
 =?utf-8?B?YS9qTkcvL1Nkd0lsdlUzcnhzRTZsb2JpRWRxNDAzRGZ5OEZEV0JJU1dORmF3?=
 =?utf-8?B?ck1VTzh3WXBQckI2Ni94Z2U5Y1FTeEtjanVnaitsK0FncW9tdW9kWjIrS2F3?=
 =?utf-8?B?ZTZ4WjZSUEczcVRtYzl1NzZsV1ZhTGRKWHpoUytWTVBiZ2FQUW85TkZzZXZp?=
 =?utf-8?B?MG9CZFc0NGJCMlE3N0d2RCtHUmN3S2ROdHhtcDN6Rkd5UXB0Z2VRWEdVWVpI?=
 =?utf-8?B?N3pZc25aZzB5OWJQeTIzWmJNNFBEZCtiZFlFOXZXUUMwZlFJNUhhdGJFQXdt?=
 =?utf-8?B?WTN6eFpGbEIrazJvby93S1JlaXRnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1PRZe0xRDdLZ+Bm16j1acTAjp4mHPl+w8pN9mSjZ+ZrI3SvZagX26zauKDZSdHRv3/h7BfGzX4BY8Ph6BdF5/MxGsb0UfaFNN2En7GuieteyCM5rfnvZMxGPPckwWM3+sCRC7aIiyzT57zmfnF2PnCPSk7U1SD+nu1bPuuqhXIEgoI/BR6SavkWjSdw200j5XudLlzfut8JplfWvMSAAgKq6UxQJriiOSyg3FDwiVgTtC2sNhpYbEQLvo5XIz/xxZrPntqPuCxRmu95j2jGp83nGyJ+2iZaeFnO3gcdUlReoikcPhrnAf0QBmx73FIUUtqNVnrE9CAueXDHlNn3BtgFnrZcANwXU/r9eM0dzKhk0I1qZC3P5ZRg20Mf8B0+lWd5+3MxB9bMV5Pz9mrL3+WBwNl5JydJGi2W5XG8Beedu7RHP2c4BTv8rHuIuF966ANFFJp+WI52+f22q/lPnepHGN1cBY4C0u+gcXtN9J4D8wBoRTaUIEIXUtg5oLgqVXAVL6/WlZuAd31nO7LjxBz9+jaiS77f8P/lSdRCyDvgn/hGoJGJDCKdDjiEFOztimOWgpAmWIEITyjQxbLWrmepGTLE50ISRpUtjAPuwswk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8150b4-ecc5-4dee-dd77-08dc99906a20
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6111.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 05:41:25.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rO/bzzUG5nMX2S4W0jVP0iNUpKProuS7dKWIfPScIGy6FPxEPxf51C4+/CKoXNZ2azI04I6bxhAvq69vqxzy9tqEuVop0SZsW6jCP5qzzjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_04,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407010041
X-Proofpoint-GUID: nE1RqYPQj1WQK4Od-dfTIh4dhidftymL
X-Proofpoint-ORIG-GUID: nE1RqYPQj1WQK4Od-dfTIh4dhidftymL


On 6/28/24 21:14, David Laight wrote:
> ...
>> The way Mellanox ConnectX5 driver handles 'release of allocated pages
>> from HCA' or 'allocation of pages to HCA', is by sending an event to the
>> host. This event will have number of pages in it. If the number is
>> positive, that indicates HCA is requesting that number of pages to be
>> allocated. And if that number is negative, it is the HCA indicating that
>> that number of pages can be reclaimed by the host.
> A one line comment would do.
> Possibly even negating the be32toh() result?
>
>> In this patch we are restricting the maximum number of pages that can be
>> reclaimed to be 50000 (effectively this would be -50000 as it is
>> reclaim). This limit is based on the capability of the firmware as it
>> cannot release more than 50000 back to the host in one go.
> Hang on, why are you soft limiting it to the hard limit?
> I thought the problem was that releasing a lot of pages took a long
> time and 'stuffed' other time-critical tasks.
>
> The only way to resolve that would seem to be to defer the actual freeing
> to a low (or at least normal user) priority thread.
> You would definitely want to get out of 'softint' context.
> (Which is out of napi unless forced to be threaded - and that only really
> works if you force the threads under the RT scheduler.)
>
> 	David

Hi David,

The issue here is, when Mellanox device sends a huge number of pages 
back to the host to reclaim, the host allocates a certain number of 
mailbox messages mlx5_cmd_mailbox to accommodate the DMA addresses of 
the memory to be reclaimed. The freeing of these mailbox messages is 
time consuming (not the freeing of actual pages).

Now, the limit of the FW is that presently, it frees upto 50000 pages. 
This limit can increase in future firmware versions. We are limiting 
this in the driver because we see optimal results with this limit during 
our tests. The results indicated that the time consumed while freeing of 
mailbox messages stayed 2 usec on average - which is tolerable and would 
not need running this thread in a different (low priority) context.

Thanks,

Anand

> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

