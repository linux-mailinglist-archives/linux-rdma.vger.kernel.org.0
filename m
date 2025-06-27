Return-Path: <linux-rdma+bounces-11714-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9047BAEAF1E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 08:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAB51894923
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 06:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3510215062;
	Fri, 27 Jun 2025 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B2GdJICV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LRsYDStG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B822F3E;
	Fri, 27 Jun 2025 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751006648; cv=fail; b=Iay8Bh72/ljgpeGHp+DwOoauueALEF+la6hDakARQfZtzJpcLIRPTmODNu2VI8PaV2oARBoAx3zWwmcMJGx8Cp9rrumat8K+QRuGJnj+ngLgq6M42CJiWFaIy6LWZHoMAgHr74TFJ5EB8i3zE9JMF//4aRMVOICElrpHpFfe0DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751006648; c=relaxed/simple;
	bh=CXLza+5NUXXPDiN1tGya7rgcZd6Urr4M8QNQD/cjnf4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dWD8h3gdtOG3dTQbix1YTI5Y6rvGPFohYEQ47VXAP0tFvqpYikCHrXBa+T73jv+ZMfcMf67NLhl5Hcz5PDbTebX7LF/eVFlUvZLw+0ctRF6LveZ1Gvf/mB8beOFOe23CVbtGMrllHN+jciwOleNQ0Afz+YlICkSbqZ9yKSuJ538=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B2GdJICV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LRsYDStG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R6Qi74010496;
	Fri, 27 Jun 2025 06:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1HDEtQGxLPPORysvTb3HZkcf4opk8o+FNHYnnVhRcwo=; b=
	B2GdJICVW4A0q1DJINHCZ4ZraO84Y/OvvkQiJbiLXp3XEcUCLkEkdc91EFyynfuo
	mQRFGIZih0YVWPzjGbrnva+BeMB2sOPerO5GtJpl8148KlcOxUj0he/dnIZmL4F/
	jxJdeIBVHblXGYoRZ50jo2owCHlB29ryys8aUv2GTtYn0MWGG5rFlAMAeGS7JokX
	3tNOOzAO15D8OKgCCpVFNnhckLYzpDVYfO1x/m+B1bK+ILVHOmwmg/AwVUJcmHSw
	/Jzxeko90u7JqxIWktkCbacCl8s26TM0NKROcOnYkdyEZPGHF11f+fug/XpNMVs5
	FmRrJ4n4PKyhOMimVyZYhw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1j32b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 06:43:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55R5vukF013330;
	Fri, 27 Jun 2025 06:43:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehr8eppe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 06:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEufu/vhP04t0MUVeNL/ny2+1cAaMuNELVIgoxuXXvKpA2Hj4iJkoSA2vhL2KWG9aRb1jvRNn7zobXIaB6eAF/lXhp6MB/QR+SgsGUnxXdxKmZ17NDqvoncL4UbAdZ20kUi0RlUJGDmDJTKF/XO+6pSo0T8W48NRnOOcC+OniHA64vA0NhBDf3NiuiAv2y9wS9ocddIDK4b9RhdxK69uMXKD3hkuThQgNKyoXkRF4HiwtFob/YnvFqvjPmvolVxAD4w9OQkKu4gyjepGmCHQddu3b9rLBxn0xSyEYsfa069uQDFUhoEUB6lYjiQCkJummQdf+l27BOnWo1dhWNgvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HDEtQGxLPPORysvTb3HZkcf4opk8o+FNHYnnVhRcwo=;
 b=EtzfaqozTe5pCqUhiWXpCNB2aRJ5keUpnqIxea0Mk+gE++aAWQ8liJqiz/OiXPHjYvFKtXjSsgiMWWeaodOnVSj4pi9OoQLicFEx15nQoSk4AkhBZRXLvideAvU0za2ROo54qFhRAImrKIqrC7UpPvpFd6dtJn/Hlm0O93Y46CQGtyJu5V+z9DXWITwz+AiL8RMhqBSC135g4vh7tuy6bMjwteAgfjwGFCrVk1Aswj9RBf0fcP00nTrfgUqpUrVIZ2XaBM8u5Aru9gi1/5LwgxtbdP00uCJuMgQ+IigfPPLesFR7/Cjf5NNJvkCxt5VbSh0Rt4nOmoHmrnq9iXHaVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HDEtQGxLPPORysvTb3HZkcf4opk8o+FNHYnnVhRcwo=;
 b=LRsYDStGO2HkRwx2UqPiGN4156OROBLqi58sXQMAADTSBtWMZbqlMtPgdHFAd+AFxN+YYwcfYD8hPZbkaJjzW5YmGUIVISmNN/Xwu/2945iXCB7ceYTS4NOkUH0lrb78eRMW0wurcPLhTTt5GeeoNlV4U7MdaHqVbXM+HrVVtVU=
Received: from DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) by
 CH0PR10MB5049.namprd10.prod.outlook.com (2603:10b6:610:c4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.23; Fri, 27 Jun 2025 06:43:42 +0000
Received: from DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::c672:69bf:51cb:db92]) by DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::c672:69bf:51cb:db92%5]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 06:43:42 +0000
Message-ID: <d6851f08-e7ce-42d8-a154-412c8403e97c@oracle.com>
Date: Fri, 27 Jun 2025 12:13:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next 1/1] net/mlx5: Clean up only new IRQ glue
 on request_irq() failure
To: Mark Bloch <mbloch@nvidia.com>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "tariqt@nvidia.com"
 <tariqt@nvidia.com>,
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
        Anand Khoje <anand.a.khoje@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
        Qing Huang <qing.huang@oracle.com>
References: <f4e25a98-5d50-4c9b-b891-c4ac042debd9@oracle.com>
 <2fc66048-36be-408d-a79f-0393ce2b4040@nvidia.com>
Content-Language: en-US
From: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>
In-Reply-To: <2fc66048-36be-408d-a79f-0393ce2b4040@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0098.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::7) To DS0PR10MB6056.namprd10.prod.outlook.com
 (2603:10b6:8:cb::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6056:EE_|CH0PR10MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: eb48dde3-10b8-40de-bd54-08ddb545f4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TC8yUEZOdzlyYUxUbFNxZHFIQTlqL25ONGVBSnhSL05jSDNhWWJMS2pRampv?=
 =?utf-8?B?eWVpckMzVGpWTk1PRnhXdG5JWFYraDVyTHVGYlVrNEV6Nlo3ejZoWEdQa293?=
 =?utf-8?B?T0JWZzJLVjZCR0J0WUtrdlNxaTZ2c0xTamliRy8xZjFZbGY3cm1YWDZ2VUNv?=
 =?utf-8?B?LzhPZ1Juc2JlV0tyMnlHck5MUmRIL2tKajJzWHdrV0VxbmEzRUFmWDFwaDVP?=
 =?utf-8?B?bmZSRWk5MGU5U05hSjlDYkNWbVB3MEVOcStLYXc4RmZIQ3RaT0EzSTRqV01o?=
 =?utf-8?B?eis5UkUyaFB5ZGhhemVXUStTdmxjUHY3QXRERUJ3blp2YzUzNEx3MGJvZUQz?=
 =?utf-8?B?eHdreFlCQ3h0cmlTZUdFM0FibjdIUWhZZWdDcVFKc1owRjQwVGVIV0VDZWJm?=
 =?utf-8?B?TU1qTExlNTE2bWFnYW1JcndPYnFLQ2t6OS9ydlh2UzY0bTVLQUtMdXNsMTQ3?=
 =?utf-8?B?UWJkcVJOcUJLeDRmcm53UVB1aGc1UHI1YlBLWVgrMnhIZ2RDdGVYMjAzVmVo?=
 =?utf-8?B?MWFXTkg4VWIzWHhmYklBekRJS1YxK1ZuWVN2U2NIZWJTWXhVd1hVSjI5ZUI4?=
 =?utf-8?B?STNVT3FVL09Gczdnc2cza0xibWYwdjBIdjF0UExicURaeUR0N2pUK2wvbWo5?=
 =?utf-8?B?VmhNcGpQMDcrQU8wOTRPeWZ4TUdydEFBVkFRNzMyb0MrWW9OWE5oVFVES2Mw?=
 =?utf-8?B?NTZSVzhnSldTY1JWOTJiT2VQc3U3TnhYc3dOd0pxc2g5dDROWnVqMVRoR0E4?=
 =?utf-8?B?Rk80cThJV0tFWlA5RTB2NWgyYStLUVJrQkpmUURWOXR6TTlXZTNQK1lLamx3?=
 =?utf-8?B?K2Y1d3V3ajZjRkx2ald2WnRIZUVjZHNHOTd2VWNMb1Y0aUlySWgrRkNBOVNl?=
 =?utf-8?B?cHdOV3Q0K3dtRjV6NHJwTk5XeVFhVXlpNEEvaHVwNzlFZzg3WG4zbXp0K3J6?=
 =?utf-8?B?c2hTZWNiK2gwUlllUm5lZ09mckNLTFp6bGh2ZmNsSVdWQUU2K3hMN2JjeVM4?=
 =?utf-8?B?ZFBoQ2dQNzk0bVBHOElmdjZWd2dUYjhPVUpxZEtFTEJFV3VXbXlSWWwvTm5J?=
 =?utf-8?B?SzFMT284UzQ5eFYydGNheGd6Rjg5M1BtZkxOaVZodTJ1LzVTbWdCUDNiNExa?=
 =?utf-8?B?TFRLSnUwVGthc1ZPWlpsd3pqTkJKdWVIWWtCMkVOWUlnTVQzUnNFWFowSG5Q?=
 =?utf-8?B?cnU2YldaRHVVTElvSmtub2tSRldZUGdBSjdIT25kaEtDVXNOS2w0VkE0RDJw?=
 =?utf-8?B?WVZSYlJ1TVFRRGNSeWM4RTY1VzE5aWxvMHhmb2ltTTdiV2tXQXFHRFh2ckYy?=
 =?utf-8?B?YjF6UmlJOVpjaElEQUFzYkNvUHRTL2h5MzdqRXEwNTlodVc2UUpjRG95MFNu?=
 =?utf-8?B?ZzgwaEViaWZYYTc5aHFsVFRpa0RjUE9hREQ0SkVhTEtDN0d5QTJpM2JDeTFw?=
 =?utf-8?B?cXBCb2ZOUWJib0Z5cmdrTzFyazR1dCtlSmVCVlJ3NUhLblEvWlBHTE1ZbVU3?=
 =?utf-8?B?TkU2RkVOUEp4RDIraHVvc0Z1VlZxK2RzK1ZJaVlzVHNvSEc1TVhZWERnUFg5?=
 =?utf-8?B?aTkrSmM4eGdYZHFzeVBkdkpocmFmWW9jUS9zSG1VdmNocEd5VHoxVEd6NnM4?=
 =?utf-8?B?RWJXL2RvN1o3RG5Ud2dXVnhSeXVaU0tkaG5nc2o4OEpBb054TFROY1hZWHNV?=
 =?utf-8?B?emRjVjl4M2Z5d1VjdE1SRUVCMGRrQitOS3hkY0NKWXcySGdkbXlwOGN4eFJM?=
 =?utf-8?B?YWFJL1BmaVlKVHhUQnVJanRpbVY4ZFY4cmJ2NE1NcnZCTVc1VzFGdDFncXBC?=
 =?utf-8?B?RDNPaVBmS21vWmt4WEIzSzRVdGtvR0FuZ2Rlc2dmZXZvUWpRamFlSysyZHNv?=
 =?utf-8?B?Zi9yVUltMnFRT0FNaTN3c0lhVjExQklHM1FuMWNxTXcyb1ZpNkdGUEkwWHJM?=
 =?utf-8?Q?nHzJCUZuC+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6056.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0lpV2tDSVhZb2FLQXhLL1hZeU9ma0hmUkVoU1Zxaks1c2pZbHZkaUF6TWhE?=
 =?utf-8?B?Tkk0MjlGK0lWV0xpNW83NmxYd1cra3F1TC9zMFZPcm12a3IxblV2aU04SlU1?=
 =?utf-8?B?U1A2ajhhUXp6UmhoWHFjOGoyekMxbTR6OTV4TWtibG45UGk3TGlwenM2UkI2?=
 =?utf-8?B?ZG40eE1oRmlnY3NNWTNaR0I3QnoyVm4xa3pnZnBhWXRoeGc2WEF3d1YwekdF?=
 =?utf-8?B?Y0pOOXpqZWlCVmkyekJuNHVuMGtNUHYrWGpMdGtmVFlZY2JBZnVyN3hsc254?=
 =?utf-8?B?aVRZa0R5SXlmcnhNRU1qZnJZZWRHMkdLWDdJZml1ejNqU3lLQ2tFMUpISmho?=
 =?utf-8?B?OEZLdkJtUHJxK3pCd2FWZEt6ckQ4VWNRZlFMa1Y2ZENMUHBpL3lGYm4vcER4?=
 =?utf-8?B?aEVwZUJ0V2V3Y3BXY25oVTZHakRHRXM0SXJCS2JsSUhCaCt1NDR5MG9vMWZU?=
 =?utf-8?B?OFNLYncyQlQ4a20yV3lYZllEMVlKRnc4cGcyVnlKRU9WNnNWc2Fvc2JoTUlZ?=
 =?utf-8?B?cFRqa21ENXVVYWtZUmxUQnkra3E4eHdOaFRjN3AxZVZHbkRCZitrSTBqZy9Z?=
 =?utf-8?B?Ui9rdm9yVGNkYTVqMUdYQ0ZYMnJtMzZqS0tyLzVUaFZBays1VFNPNkxWRmxS?=
 =?utf-8?B?MlYxYThMZFFMNGtacUplTmh5SnRydjcvd2dSRmQxelVpbVZ5VnNmK1hhLzM5?=
 =?utf-8?B?M0JvN0lybDdWS1IvUldyN3FlZXRlU2ZEdkxuSVE1NlFuS1UySThRNlNlTEpu?=
 =?utf-8?B?U2VkT1Z0MEx6L2FmejNSTjVITnBTRDZBRVBYZmhKRlNXNWZLWXRRMmlGR3ly?=
 =?utf-8?B?VGFPbisrUkxvd1FMc2RTUDdaTjh2YnZQSDVwVDJNM1JpTEpDbGdIZTFuc1ZO?=
 =?utf-8?B?VXFlN2lWVFFOMzdRakFTMjZ4SEc1ZFBzc1B1V1UweGUwcFpFdkR6V1FRTndv?=
 =?utf-8?B?STF4UkRPdUVnZUhCaGNwbEZCcGdVTTdQdGpaSWRCcGVINTJSRkFuZmFFQ2Zw?=
 =?utf-8?B?MWVWdU1TSk56T0pKRUM4SUZ6MHlISFRGaDVLTVIreTVIMUU5WHRpZG1Mb3ZY?=
 =?utf-8?B?OEg5UWw2NG0ra09RWDhrQUtFUVA2cFA4MU1RU3ZGTkIySVlOazFaeWdhemhZ?=
 =?utf-8?B?c3RrSUgwUFFFZjZCS1Y5dFY2NHhFS3Job1VBZzl0dEJzSm12elMzUGZhbjQ1?=
 =?utf-8?B?VisrRFVtT2RqQnpXbnh4UlB2eUtLYTV3YSs3bDM2UkVvRXV6ZC8wbXB6N2xF?=
 =?utf-8?B?L3lqNVVYc2t2YlZSTTJNVE4zSnFuc09hNHJ0VkxNZ2Z1dm9IaW1yQVBORXE3?=
 =?utf-8?B?cWc4Mk5CcmxqQWt1K2FlWmdWYlpTVnR1c1ZKZlJmejF6ei8zcXRkSDNmNnZv?=
 =?utf-8?B?RFYycG5GUTFzRjJ6S2tHeEg2UGhBWEwyYW8wSTluTE9XZkRtUmpzdG5ZNTls?=
 =?utf-8?B?MU00c0xzdWN4ZkFKUmhQQnZFRTVLTzJMM0VDRXN0bWF2bVkrOFUySWNpRWJT?=
 =?utf-8?B?QmtYN3lBSURzVURDeEdtb0Q1UXhpeEZHMkVldFl2UDBJZUFJeFZwdEVuVm5E?=
 =?utf-8?B?U0IyOFkya1BhVmlhdXNydHZPdzhZRTVuNGROT1pwQm1TZzRYWVpNb1NVY25B?=
 =?utf-8?B?MXYvMmhjclJMd3pFRnloNVFkRUlGUVRFbU1LckVOYXlEWkM1MkdQanM5TXRs?=
 =?utf-8?B?TUg0eWsvYlEvZWdzbmMwd0V5bW9SczFNdE1ROGpXaUw0YVFVaXhHdTd5STJm?=
 =?utf-8?B?dHJuTm9wOUxxSU1zc2VoOURLWHlUMGhaR1ZPZ2xRUHlHM1hJcHNXd01qZ2pE?=
 =?utf-8?B?Y3JRcDlXYmtDeDd1OTZ5UlJDMUdLTFRVQ2FnMlVVd09zNTB4eEp0VG50R2FU?=
 =?utf-8?B?ZUxuTGtKZXdSVHVQUHFlNVhxOHpHcUhlTlpCNlRGNkxpcjBQV2ExZVNGUE5H?=
 =?utf-8?B?MkI5T1k5RmNETUVWNTM0R0RLUmZxNW5NQ0NHcnFsTUtoRGhDYm5jWWZJSUdr?=
 =?utf-8?B?dUlCTnNRUU5rcEYyTFh5andWajVHOXVCSHFSUlJ5L1paVXpCcjlVcGFpdVRw?=
 =?utf-8?B?V0NscGRmVFJlTDhTQVZTb2NKVGlYSzd0dVdCZXJEQVdxbkg3clErNHNMVGF1?=
 =?utf-8?B?eDZOc2RCWVp3VUJLTXFBN2U5MUhseXU5WGI5VkRuKzc0TTREaVdIeWhFdzZj?=
 =?utf-8?Q?86reuVOOJQ38DKjWmy5QId8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Uvmnqaa4Km2eABekAavz79ZG7MTCcYuaWJeIuD4W1CTsbdiHXYZHxZcYXb+jtM6GtIgfMJl0MV1yVA/E5FY36DO1JqvMDfTdMa9alyK6Ka3FzPbsMSUzxtwZ7nJe2qkKFZzTCrVar2Sw4SkpoUWbOlpBCsT4WP3TRlAQnEVCB1Dv+dgkvw/ER+7uGIRrnORoDC0LXYYu/u2VhEv4XLmYCmSsbn1fS069rbp/AsmIjjWo51KcTvySPQ9E2+HD2uNZGT4v81pEJAXxVobn4rRU5Bg0lYBgXLUTpmuZfXxLGSheVPb8X2p/9a8iF/ZIL2cmTveE5m/szSm0QvYZVB94GKGMDeRJt59vUKi05T3hvcbkbSeHzAFeNssIJ/2hg6zlsTRB4YtC6I403nqbopfAQfA5MK/m241dWhPLQ4qgaoLPk53VAMPCi68GeifRo5ZYMyIHIwnHN0enUX164Kucd3hrPTN6bj9fDWoEQggurNFUQhLAIL4xwdiMVmAo63In93Y3/32XDMm+J9ZWJks3l17vBKBQ1wOxORzVLr48FdqSjW37KbSlNgpywV2lLbu+Y+kmOGDmciG1l6TzL4ZbWO00l2msMo4QAdKPUWpNOcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb48dde3-10b8-40de-bd54-08ddb545f4ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6056.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 06:43:42.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXSN8kxtZuYbiXJTp7YpHaRTu+q4eJQfFsy2U2WcdEP8cP5qA/4vvL2GPcMENAd13z61NOsqelKeGxVH7EFPhH7qiE4cmSCBsIiZTjE9Ugj+NYD8G7xYQ3udVfoceEja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_02,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506270053
X-Proofpoint-GUID: rFOcwx5YchNatraZqFpJTi5gXpGN2N0g
X-Proofpoint-ORIG-GUID: rFOcwx5YchNatraZqFpJTi5gXpGN2N0g
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685e3da2 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=TbZIRYrO5KEnX34w4v8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA1MiBTYWx0ZWRfXyOMWKb1aPMxy JSn8Mr9xA83vz5ViL3r9WlkVQO8HGz6ShvTTqWZsq0MmlMwGpM+iRE4tHJimdSd5KTJAoSDDujM c1tJCt8DohNwvsRhp1CuK3rft60LnP6lgpoVOVdnfYIykIT7rvmrjw1wkBR3dYCVCYOhEXhcDEm
 Qm8NjsTl70VDDRu8VAowic7KtyliSOkgWhuVUcv9FSezSHzvMs4zOdabTO99c+eOb87IAOWCGBV /GMzidPoLLd8p6u+raipbFjjEyVU1DxwunVeFPkURMlF6duNX4uYhuGphb05gCzIi54Z43yTOk1 uY+Pou2VIqzNkvlpT+tNbY83yUbtRH+h2S3r3Dy7Qw6KdIl+GZzUlWntK137+SR5aJEF5XKf8/K
 c15I6RPaiiTOyn0CGfnPi4Anv0evqVFGilyvTXgPABddnx2FfIFUqmTdefHjWg83a3TwLaVP


On 26/06/25 5:28 pm, Mark Bloch wrote:
>
> On 26/06/2025 9:04, Mohith Kumar Thummaluru wrote:
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
> Please target net and not net-next.
>
> Mark

Thanks, Mark. Let me do that.

- Mohith.

>> [1]
>> mlx5_core 0000:05:00.0: Successfully registered panic handler for port 1
>> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to request irq. err = -28
>> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while trying to test write-combining support
>> mlx5_core 0000:05:00.0: Successfully unregistered panic handler for port 1
>> mlx5_core 0000:06:00.0: Successfully registered panic handler for port 1
>> mlx5_core 0000:06:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to request irq. err = -28
>> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while trying to test write-combining support
>> mlx5_core 0000:06:00.0: Successfully unregistered panic handler for port 1
>> mlx5_core 0000:03:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to request irq. err = -28
>> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to request irq. err = -28
>> general protection fault, probably for non-canonical address 0xe277a58fde16f291: 0000 [#1] SMP NOPTI
>>
>> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
>> Call Trace:
>>    <TASK>
>>    ? show_trace_log_lvl+0x1d6/0x2f9
>>    ? show_trace_log_lvl+0x1d6/0x2f9
>>    ? mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>>    ? __die_body.cold+0x8/0xa
>>    ? die_addr+0x39/0x53
>>    ? exc_general_protection+0x1c4/0x3e9
>>    ? dev_vprintk_emit+0x5f/0x90
>>    ? asm_exc_general_protection+0x22/0x27
>>    ? free_irq_cpu_rmap+0x23/0x7d
>>    mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>>    irq_pool_request_vector+0x7d/0x90 [mlx5_core]
>>    mlx5_irq_request+0x2e/0xe0 [mlx5_core]
>>    mlx5_irq_request_vector+0xad/0xf7 [mlx5_core]
>>    comp_irq_request_pci+0x64/0xf0 [mlx5_core]
>>    create_comp_eq+0x71/0x385 [mlx5_core]
>>    ? mlx5e_open_xdpsq+0x11c/0x230 [mlx5_core]
>>    mlx5_comp_eqn_get+0x72/0x90 [mlx5_core]
>>    ? xas_load+0x8/0x91
>>    mlx5_comp_irqn_get+0x40/0x90 [mlx5_core]
>>    mlx5e_open_channel+0x7d/0x3c7 [mlx5_core]
>>    mlx5e_open_channels+0xad/0x250 [mlx5_core]
>>    mlx5e_open_locked+0x3e/0x110 [mlx5_core]
>>    mlx5e_open+0x23/0x70 [mlx5_core]
>>    __dev_open+0xf1/0x1a5
>>    __dev_change_flags+0x1e1/0x249
>>    dev_change_flags+0x21/0x5c
>>    do_setlink+0x28b/0xcc4
>>    ? __nla_parse+0x22/0x3d
>>    ? inet6_validate_link_af+0x6b/0x108
>>    ? cpumask_next+0x1f/0x35
>>    ? __snmp6_fill_stats64.constprop.0+0x66/0x107
>>    ? __nla_validate_parse+0x48/0x1e6
>>    __rtnl_newlink+0x5ff/0xa57
>>    ? kmem_cache_alloc_trace+0x164/0x2ce
>>    rtnl_newlink+0x44/0x6e
>>    rtnetlink_rcv_msg+0x2bb/0x362
>>    ? __netlink_sendskb+0x4c/0x6c
>>    ? netlink_unicast+0x28f/0x2ce
>>    ? rtnl_calcit.isra.0+0x150/0x146
>>    netlink_rcv_skb+0x5f/0x112
>>    netlink_unicast+0x213/0x2ce
>>    netlink_sendmsg+0x24f/0x4d9
>>    __sock_sendmsg+0x65/0x6a
>>    ____sys_sendmsg+0x28f/0x2c9
>>    ? import_iovec+0x17/0x2b
>>    ___sys_sendmsg+0x97/0xe0
>>    __sys_sendmsg+0x81/0xd8
>>    do_syscall_64+0x35/0x87
>>    entry_SYSCALL_64_after_hwframe+0x6e/0x0
>> RIP: 0033:0x7fc328603727
>> Code: c3 66 90 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 0b ed ff ff 44 89 e2 48 89 ee 89 df 41 89 c0 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 44 ed ff ff 48
>> RSP: 002b:00007ffe8eb3f1a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fc328603727
>> RDX: 0000000000000000 RSI: 00007ffe8eb3f1f0 RDI: 000000000000000d
>> RBP: 00007ffe8eb3f1f0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
>> R13: 0000000000000000 R14: 00007ffe8eb3f3c8 R15: 00007ffe8eb3f3bc
>>    </TASK>
>> ---[ end trace f43ce73c3c2b13a2 ]---
>> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
>> Code: 0f 1f 80 00 00 00 00 48 85 ff 74 6b 55 48 89 fd 53 66 83 7f 06 00 74 24 31 db 48 8b 55 08 0f b7 c3 48 8b 04 c2 48 85 c0 74 09 <8b> 38 31 f6 e8 c4 0a b8 ff 83 c3 01 66 3b 5d 06 72 de b8 ff ff ff
>> RSP: 0018:ff384881640eaca0 EFLAGS: 00010282
>> RAX: e277a58fde16f291 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: ff2335e2e20b3600 RSI: 0000000000000000 RDI: ff2335e2e20b3400
>> RBP: ff2335e2e20b3400 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 00000000ffffffe4 R12: ff384881640ead88
>> R13: ff2335c3760751e0 R14: ff2335e2e1672200 R15: ff2335c3760751f8
>> FS:  00007fc32ac22480(0000) GS:ff2335e2d6e00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f651ab54000 CR3: 00000029f1206003 CR4: 0000000000771ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> PKRU: 55555554
>> Kernel panic - not syncing: Fatal exception
>> Kernel Offset: 0x1dc00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> kvm-guest: disable async PF for cpu 0
>>
>>
>> Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
>> Signed-off-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
>> Tested-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
>> Reviewed-by: Moshe Shemesh<moshe@nvidia.com>
>> ---
>>    drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 3 +--
>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>> index 40024cfa3099..822e92ed2d45 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>> @@ -325,8 +325,7 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
>>    err_req_irq:
>>    #ifdef CONFIG_RFS_ACCEL
>>        if (i && rmap && *rmap) {
>> -        free_irq_cpu_rmap(*rmap);
>> -        *rmap = NULL;
>> +        irq_cpu_rmap_remove(*rmap, irq->map.virq);
>>        }
>>    err_irq_rmap:
>>    #endif

