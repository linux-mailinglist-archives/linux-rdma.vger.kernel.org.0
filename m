Return-Path: <linux-rdma+bounces-3843-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D9492F4B4
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 06:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484711C21A1B
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 04:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B1C1429A;
	Fri, 12 Jul 2024 04:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rp9yzc+N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0Ku3Hplo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C6EADA;
	Fri, 12 Jul 2024 04:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720759738; cv=fail; b=j9F5nBcSnzUE6+QlgIrpEA67iGy1ZAVAMG12hY5i8qfgzJLUHUBbF3hhJ/jPK9nfNyKpiJlOatjOQUy5LNmpqy/07q8nVJnM80bXIxXe3smFz9D8kfdHx+lPBhy2qWc1ZjXgELZtYBFnAq/VFZbXs8jVs9X0nAVSJ67aqI8ddrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720759738; c=relaxed/simple;
	bh=2VnbhJM5xO7/0g2itUcjKbd+gP+VR96ypkSg9zXkpwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qp/4Vlaqxbej4FwqHQkmvHrJzvN8viU2j9i+lGpqYOFQoHfyV/R/M9dN9Yr80qwYCjT9qYmy4YZqQCIY3IjOD6v2vqWvFxL+6wiyX5qPNJx+7sFfANLuBNRSpAI21Y9E7N72rQKUydok59vvdMVFlHt++F/iudVvRX9Qo4A/6oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rp9yzc+N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0Ku3Hplo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C1BVel002395;
	Fri, 12 Jul 2024 04:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=wu5L7MhJY9wmyKF8vZ/9m26EhXtjiLd6E5Lx+/gLTdk=; b=
	Rp9yzc+NhvK1OTRqOJedeUnjQzFjVZiczD9TpDog5L49TRb3uSAA3x/9rMQtJLiD
	M9DnUXq2CbmTYwceSd87/+J/Au4BfNmZyef5qm28fyXExaHn39982dzjmTdeE15t
	47VQj4mRMV6aovJDhT3ob3ulebQU6lHSU7Uoh8AFOS69qe4vzVlbCZwiJRte1OgX
	KZ5XB44KtKuHieZeQd8AQ4tmOw0ZJhsIrgj8lrN1co6m8sD6Jlya5C7HPJJiwewu
	Ecjg9pWPeo7CPlYLqZKuSnD7ZUR+GBNVOdXZ+s5ziHs8G6391f/USh24qSvbUlRG
	/sdXwR9gq+z/Q0coWTOjow==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybu7hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 04:48:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46C21VpD022608;
	Fri, 12 Jul 2024 04:48:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3b65f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 04:48:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGEolYMf1YXGuGJ48LQKTOkLxCAEsT/PLbcScz8pXJRObK/SgO31Ns5fO/8kQga8irXKVzOb/urtfsX+hFs/5NmzHPJiNkSeV8oaMSc9tA60HlQmhiAgWrIxTtQ7j56E7mekWz612iFdMIzDD+CksbGOoLXoxjl9NoS3E3QbfLSWcoN+wZeHyEkAUIqV6uPnFDZIB2dyKjWlvqkiIin58BR56Th/5asy/PSqtcZ5io4Pi8dDIaJH/wq7A0BDJrWD2r7QG03XmC1sYFtInQrJRN+bWgDJSiCqSISmDxXzqhhTFWv2ReCWQjU3CVwDqxCHU3LT5T66XLojhDIHLJlwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu5L7MhJY9wmyKF8vZ/9m26EhXtjiLd6E5Lx+/gLTdk=;
 b=vS44JmdhBo21kKWduo80HIQHqGN2Lqpg+VZpc8XL1gmI6swFGvbSmfVQzXjFSWkXpxf5I40oqu3bDi16R+ePZAzTUrIeQ0aVQ25xzpxDXyB6EmX0L8GUUbJ1U5+Tg9RnepVx4Em5rk/d+rBqgvBIe84ZN7qrO4P6BGj3bXe5I/aWx5fat9EL3OZHzzW1YhQLNie3uWYl/FHtvHTKWUqA/YQAk3sQht7cLVPPMUu+h8CIsLMSZTHvDDhTR2KteC+ozWJIbBJxkKdTA7IMjPh69JBdCHq9PMt428zHZyhcnC+gcBIPlFhaoExI//ULMohIDgxznmUaDpWDH6KxyVwA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu5L7MhJY9wmyKF8vZ/9m26EhXtjiLd6E5Lx+/gLTdk=;
 b=0Ku3HplofB7KHWEjKdLOS6q9vBPuWKdmPOxh4HEQo8Igw/lAX/CsfCauVRZdWbMFzbfVFTxSSVmXvK7MCM9CV0TbDwFZWaAVIY2b3816t7fe1b1aWCyfnoEY05td3s0fnabnk8CmLAXyYSquRnzxWwYzWFBBhqrUEUfNKNTYHJ8=
Received: from DM4PR10MB6111.namprd10.prod.outlook.com (2603:10b6:8:bf::9) by
 PH0PR10MB4807.namprd10.prod.outlook.com (2603:10b6:510:3f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.23; Fri, 12 Jul 2024 04:48:41 +0000
Received: from DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777]) by DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 04:48:40 +0000
Message-ID: <c8d99dba-89e9-4bf2-b436-f1a29cd573bb@oracle.com>
Date: Fri, 12 Jul 2024 10:18:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Reclaim max 50K pages at once
To: Saeed Mahameed <saeed@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, saeedm@mellanox.com, leon@kernel.org,
        tariqt@nvidia.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, davem@davemloft.net, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com
References: <20240711151322.158274-1-anand.a.khoje@oracle.com>
 <ZpCI0mGJaNDFjMno@x130>
Content-Language: en-US
From: Anand Khoje <anand.a.khoje@oracle.com>
In-Reply-To: <ZpCI0mGJaNDFjMno@x130>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::18) To DM4PR10MB6111.namprd10.prod.outlook.com
 (2603:10b6:8:bf::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6111:EE_|PH0PR10MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 0042f713-82e1-48cf-be9b-08dca22de64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dEh5NjY2N09Ub1VGS24yMkZGMms0N0VzYkcrOElsQ2NXVmdKeHhhQzBRTXBK?=
 =?utf-8?B?am1QYVlwVFdVVENwcEExNVFDZlZ1VVQ1aVNRcVBIaDZ2UWxHVjJjMU9QVVlx?=
 =?utf-8?B?RGhZWXRaM3VWSHN2K3VXM1BZVjA4NmhtclhNRkhLWUFHRVBVUFlPdVVWVWxz?=
 =?utf-8?B?TSt5cnlSV24ycE9MbDdZTnNDSnE4cnhjY2JSL0szNzY4VUNLKytvS2l4OTVP?=
 =?utf-8?B?RFdqdjVKUTFMZTV3bEpaN2FrcVNVVnRTWDUwNWlEM3g5WEhWc1B3M1VOV3RW?=
 =?utf-8?B?T3JCbWJUSmI4SHRQUk4rd2hxRHJIaDdEeFpuU1dMck0yV2hIZm11Vk5YQUVp?=
 =?utf-8?B?bzRIenhvdXBSd0ZtUlZEVFBoZXptLzJZZGxvZ1dRRmtBbnBGR1lEUEgrSzFh?=
 =?utf-8?B?SDlRTURoR01sNE5TSklkMmUrVzF3SldNazZYVXpDSG95alBIc3NMQ1hBd3ZU?=
 =?utf-8?B?SGE5eGZIM0paL1lhK0k3MlhxYXNpVytWMXByeUsydWlpWSt3U0VtV0V5R2RR?=
 =?utf-8?B?d1VvTlRtdEdubmFMMzVFU1lTMlR3OVZveU1CVVpJZFlWcGdJcGM2anl4U0xB?=
 =?utf-8?B?ZDFWclJmWU05cUwwNnV0RWN2blE3VGwvN0x5d29ZRUNKbngzdjEvQ3pIWDlN?=
 =?utf-8?B?NS83aVp0aVJOa2tNV2xwNEZIdS83aHRIbkFmTnU1dU9HOFY4M1BxVTRqNzNJ?=
 =?utf-8?B?S0FBd3lwNXA2VnJWL0E1Z3JkV2hNb0ZrblJpVWpHYlFVUlVkRHpRaUV6OUJz?=
 =?utf-8?B?WmRBVnkyYkJORnQ2QkNYR09yTDlSUjhpbmJDYXhUbE5BQURTQThyNWMzdVVm?=
 =?utf-8?B?SGozSE0xNkt6SFB5SEc2K2NrRmMrSHRlUmlxejhUU1ZtaElDQkw1UjdSR0o4?=
 =?utf-8?B?eFBnQVRuVlRhNlZ6UlJpRFE0NnlaSzRyT2dheDFFSDRVc1ZTa2xxR2hqUmpz?=
 =?utf-8?B?Y0JsUHFDRExCVFlEa2RMT1d1eDRYYmdlZ2wyU3BPa1BvSUQ5N0FCeGRKYUxH?=
 =?utf-8?B?VHh3Kzc1eFdXZFdhcHA2WnlFUDUzVFVtNEFKandCeXMyYWNmdjhsRk1uSFVl?=
 =?utf-8?B?eXVaVFF2UytVTjY2bjRxSFJDRTdNUWFkU01PRGtWTWNubHgrdlQ2QjlFRTRr?=
 =?utf-8?B?UWlkcDYwV3ZVYzAvM3FGOE1CRDE1bmxTL2Z2SjRQdVZwYU5hL2pXL25RcHlh?=
 =?utf-8?B?dzdGRUtUaUZWM2NYNG5ZREZVZEZxRDNZOStHai82S3ExNDhBUE14ZERYNXAz?=
 =?utf-8?B?bHRxdy9GbXFjM0lCbUhHTTdSZGtRZnNMZW9qVU9YZ0Y5aGdOZ01PaU5sTFo4?=
 =?utf-8?B?eWZTVXJTMythRjgyVTFzcDVMZ0JrUEtVUmtDN3RndjlSZUR5Vk5hNkt1M09S?=
 =?utf-8?B?L1dlRGtvSG1WYlZrOFZvL3ZObzFNN1ZJc3BmYXpsYXNZTXQyVEtsdGU0MEJs?=
 =?utf-8?B?MHBqNlFsNkZMWmtxZU1BRWZWVXgrSGJaUnoxUElER0VIcVY4ZUN1RmZKLzYv?=
 =?utf-8?B?ck11NzNPbnh2MjFPSUZzUVlJaDMzSlpsVVlyUFpMMnc4VVF6dGE1SEVmcHE1?=
 =?utf-8?B?aVR1VlFhOWtNYkpMdDB6T085VmlpajhnN3B3dXNFckxJWFFEbjlBeUNtMnA4?=
 =?utf-8?B?cVN5bkNqc2FldXZEWXR2dlhTVFExQmZQa09wT3V5T3BZOW5vUEFZOStGd3Mx?=
 =?utf-8?B?N1Jhb0NNL3J0YklETWFTQTV4aDBkUlR3Z3FOSlRsSzdVcUNGMUlqYkxLai8y?=
 =?utf-8?B?NjFKUms1SFc5M3R3QlVleDh3amtTOUF2bXduak1nQWo3WFBKSmhaY1RGTWFk?=
 =?utf-8?B?bnJoeGZRVHpnaGlKc0dRUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6111.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0cvVXNxYnBuekVWdmdsVzg4eEpRNFh1c3JZa3BhN3Vud2RBaWRkaG43Z252?=
 =?utf-8?B?OThydXArMjF4STN0Y2kvdWxubHBISGRTQ2I3WGIraktmb095OWYwZzdaRVpE?=
 =?utf-8?B?V3R6Q3laOGdpa1FaTEc0MlJwaTd4T2E3S2NtMFp1QnQvcXlMdWx1WTBvM3ZS?=
 =?utf-8?B?WnUwSmpjS2h6NTBHM1V4UE9vWHA1QllDb1NYZXdReHNDS3RyaE1aMWdKNWdR?=
 =?utf-8?B?TGVka3ZTbTV2VGFtV1d3UVRBd1NQQXVoZGd0aHhYdm5tOGlZcHpSYURzNFJj?=
 =?utf-8?B?MW40WGFKWjZhUGZQL3BITmpaVnIrd0hQUFlsRnJzZVBWNjFwcEdlZmMyK0h3?=
 =?utf-8?B?WUg0RC9HNHBhd1NRRFRzOTRiQjdnVDhPT0Y1bHdKWk1LL0Z4b3pxVFkrVWJs?=
 =?utf-8?B?eWdTVTQ5V1NsNHlMNkxveFVQUk5YQVl3M2pQVGZkNGl3dTZpRkhKbFVOcjZn?=
 =?utf-8?B?ZG9SWm5iMnBNY3c4Qmw1cFBDUGc4Snc4VEJNcG9KK3c1WUxYV1VReHpmWHlH?=
 =?utf-8?B?SGpUelJHWGhDUXJ3TUQ1U0Zkb3hiclgzRWkrODNockJIVnVMODVxdEQ4YURM?=
 =?utf-8?B?dmhYUFlwZzFra3hQbHlYdGxMUGlxSVVOVVRlYUVGOXlLL1JBdElOS28zcTFF?=
 =?utf-8?B?aU1uS2t4bTBBWFl2MldXc3hQenNlRUJvQ2FWM2ZzY1pBRVJHZlhVb1lSdzdR?=
 =?utf-8?B?bG9WVWVYTnF4VjJwZnR2WWpLYnQrVG1ISDlYTlBScmpTc01QTkJHMlVYQW4r?=
 =?utf-8?B?aTA0bThSSGNqa2VpMzFWbEsvSFJUbFB6aXJnS1RlSmU2OFB2S1VReFFXSUZG?=
 =?utf-8?B?M2dsZXVNK0tXUXNNazBvMGJXd1F3RUZRblpWVEFhWStHSzBSME5uT09iRjAr?=
 =?utf-8?B?V3gzWEZrbDVLeXROTzdscGEvZjRSTXMxNXdYUWZWUzg5em5RS0ZSTUhNSDRQ?=
 =?utf-8?B?Q1htdzF1YW5YUXNrK0gvY1RSR1h0WEEwYzVZMVJHUDIyVC9PekkraS9FVHFV?=
 =?utf-8?B?cEdraWFnRnJSc3laL0lvaTZ1TytBSVhmTEJORnZpa1o2ZnFNUnVnRmh4Ynls?=
 =?utf-8?B?QVY3aFZsQytpUjRQSUxuamtUaGo5bXZhQVdiRlFlNGFmK3dQRXVDcDlrV2Z0?=
 =?utf-8?B?M1REOUhLbkpoQVcxYlBFMnByZkZWNllaYjFsY3A4MjF6Y3ZZTy92MjJFTjBl?=
 =?utf-8?B?anJ2V3JiUGdGbWhBQXRTallPbldoTEptYTdKS3UyQjVVMzU2NUd2ZDdta013?=
 =?utf-8?B?R01sKzBoRHAyMVRoK3NaRDVza2czRTRBQTdiZmkya1dvREJRL0xheWFML3Fy?=
 =?utf-8?B?VGw5QjZUMmZVbFN2K2ZLUmd0Z0JYU3hDMGxGWGJXOHI0NVFMS29YMk5ndlVM?=
 =?utf-8?B?Z0lWY3ZHM29wdWZxZkFTbERHUzV3VnNqcHkyWjd5MFJubyt6L0d0WlNxYWhY?=
 =?utf-8?B?Lzd6WFZVbkZ0YldVR3lEUDhkUlJxL2l1Y3RpeUQyK1FIa1M3VWxtY0g2VktI?=
 =?utf-8?B?c1ZLV052YUJkWVlZMFFiVkE0OHBmS1ZuN0IvRXg3ZVFLOEQxTVFMbGJNZVRj?=
 =?utf-8?B?aG9PdkxEYkttTXhxRTE4bHhCWVpEOHpYT0MzMGdza1V1UkpiZXpzN1RiVjMx?=
 =?utf-8?B?QUt1VUlEK3gxb3Q2a21leWlKczJPVEErTW0reXVSejYzTlovZ3k1OGVVTDRo?=
 =?utf-8?B?aWFzZXI0SGN5L2twbWNyZU1Kb0haMlVjY0U5Q2N3M01VY3hWYk9hdnU3dUJ0?=
 =?utf-8?B?cFZVcUJob0RvZUlrQm5VeDc1TG02S0NMa0d2WXp5cUtpSjY4TDk0blRjd254?=
 =?utf-8?B?VGNHUVRJY1oxSk1JSjUxZHZlVS9VcmhackhxcDU4bEMzQkxXZmdCTlhZY3VF?=
 =?utf-8?B?amZSRFJ6d1BxendERU5vRHQ5eWVEb2JsQ25WYTBTRzNNaEFDYTVCWTVNTXhU?=
 =?utf-8?B?blhQZ2ZjTi9rK2FzY0NJcTYxUm55aG5GYlhHZ3ljOUp6NU4rOE41Tm5wd3Bx?=
 =?utf-8?B?Zld1K0Q1cDU1N0ZzQWx2bTlXRHpFZjBwQzBvcHRzdWZtbFdzdGU0cmtheXIx?=
 =?utf-8?B?WHpFQXVEVXVUZEF3dVBUb0JBSTFlZVN2d1NNeThCSTEzQXR5cnEzbFhjWEpP?=
 =?utf-8?B?bGpqeWdKQVhEbVp0M2xjdjFWQ2EzT0M3Z3gyN29jQ2hOSVBMNWtQdDBMODlr?=
 =?utf-8?B?MjVvOEo3QlVpenhwRjdJNGNPQmZMdUpjeGhDODBZV2FwVk9VWGowbnZzckFr?=
 =?utf-8?B?VUNOL2Q2SmNkOXFMTWUzWXBmMWxnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sv2tO7faqqh/bj7R+QFGXVyurdkRTrODBzv86UhuBciXou78WbX2CF60xgNw/BgkT2jwap6JQ0tVvw6aggRNxRhZ1HXiC32dhLc7mKMVklv6JeiOkelDen453Kk4EdKOJD6t6l022CUolYWh9aG/3glJYKwproM6weew6nVwHG3XFwm0sSDlVMeZ+qVaWaxfeFteDac6rgRs61Q/xx0wS0ekW3PIUTqn3H1GYxoCT4gsXjslP60zuY0xgmTTgqVlqsveU0HsEDYsKoVPjUQpfD3OApBkt3VPduMcC/Qb0cbYq7vJi3RrFcykevf91Y65ucYowhZGAQextYCByAETDXM5U/d2TLbEONZl5AxG9esrBW/8BJTay2couLmpv2wMaQY9T8MLuPnTRi8CJk75RU0xd6yzOnZxqA0SxtgZR5At6Xzqxmn5oJGXhyOIhUiidBIkKoOu8TumGXP1T6FW+WGsxU6N11CqnkybLVcWqLECRd7ew4N8r0bOSkpCjflu/kF9cpqMkQWZXD48OlSLPAwYR6P2Gy0nmN7o11imUQYnwpbuRJVoUdopt/xxyDr+Syu2ngRs4gnGPPtcgO7e0uVZlDCHhu8XlvHM5KtzxUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0042f713-82e1-48cf-be9b-08dca22de64c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6111.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 04:48:40.3388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciSSDFDQQr/gAEHBDrjlAYus6qnjKWhEU4+ZYaQTAn9x9FTpPuF3YHvU4hr5Z5I9DjVuFwqggmtwRfu/6K/f+ZOMtW2T4MkUXZ0jc8CVGIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_02,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120032
X-Proofpoint-GUID: vCqg8isnbyZqbP_j493Ap7iVUWL0euCw
X-Proofpoint-ORIG-GUID: vCqg8isnbyZqbP_j493Ap7iVUWL0euCw


On 7/12/24 07:07, Saeed Mahameed wrote:
> On 11 Jul 20:43, Anand Khoje wrote:
>> In non FLR context, at times CX-5 requests release of ~8 million FW 
>> pages.
>> This needs humongous number of cmd mailboxes, which to be released once
>> the pages are reclaimed. Release of humongous number of cmd mailboxes is
>> consuming cpu time running into many seconds. Which with non preemptible
>> kernels is leading to critical process starving on that cpu’s RQ.
>> To alleviate this, this change restricts the total number of pages
>> a worker will try to reclaim maximum 50K pages in one go.
>> The limit 50K is aligned with the current firmware capacity/limit of
>> releasing 50K pages at once per MLX5_CMD_OP_MANAGE_PAGES + 
>> MLX5_PAGES_TAKE
>> device command.
>
> Where do you see this FW limit? currently we don't have it in the driver,
> the driver requests from FW to reclaim exactly as many pages as the FW
> already sent in the initial event. It is up to the FW to decide how many
> pages out of those it actually release to the driver.
>
Hi Saeed,

We have a confirmation from Vendor i.e. nVidia that the current limit of 
maximum pages firmware will release is 50K.

>>
>> Our tests have shown significant benefit of this change in terms of
>> time consumed by dma_pool_free().
>> During a test where an event was raised by HCA
>> to release 1.3 Million pages, following observations were made:
>>
>> - Without this change:
>> Number of mailbox messages allocated was around 20K, to accommodate
>> the DMA addresses of 1.3 million pages.
>> The average time spent by dma_pool_free() to free the DMA pool is 
>> between
>> 16 usec to 32 usec.
>>           value  ------------- Distribution ------------- count
>>             256 |                                         0
>>             512 |@                                        287
>>            1024 |@@@                                      1332
>>            2048 |@                                        656
>>            4096 |@@@@@                                    2599
>>            8192 |@@@@@@@@@@                               4755
>>           16384 |@@@@@@@@@@@@@@@                          7545
>>           32768 |@@@@@                                    2501
>>           65536 |                                         0
>>
>> - With this change:
>> Number of mailbox messages allocated was around 800; this was to
>> accommodate DMA addresses of only 50K pages.
>> The average time spent by dma_pool_free() to free the DMA pool in 
>> this case
>> lies between 1 usec to 2 usec.
>>           value  ------------- Distribution ------------- count
>>             256 |                                         0
>>             512 |@@@@@@@@@@@@@@@@@@                       346
>>            1024 |@@@@@@@@@@@@@@@@@@@@@@                   435
>>            2048 |                                         0
>>            4096 |                                         0
>>            8192 |                                         1
>>           16384 |                                         0
>>
>
> Sounds like you only release 50k pages out of the 1.3M! what happens 
> to the
> rest? eventually we need to release them and waiting for driver unload
> isn't an option.
>
> My theory here of what happened before the patch:
> 1. FW: event to request to release 1.3M;
> 2. driver: prepare a FW command to release 1.3M, send it to FW with 1.3M;
> 3. FW: release 50K;
> 4. goto 1;
>
> After the patch:
> 1. FW: event to request to release 1.3M;
> 2. driver: prepare a FW command to release 50k**, send it to FW with 
> 50k*;
> 3. FW: release 50K; Driver didn't ask for more. no event required.
> 4. Done;
>
> After your patch it seems like there 1.25M pages that are lingering in FW
> ownership with no use.
>
We have tested this case, here are our observations:

1. FW: event to request to release 1.3M;
2. driver: prepare a FW command to release 50k**, send it to FW with 50k*;
3. FW: release 50K; Driver didn't ask for more. no event required.
4. goto 1 with 1.25M request to release in a new EQE.

It goes on till fw releases all pages from its ownership.

I hope that answers your doubt.

Thanks,

Anand

>> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>> drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 16 
>> +++++++++++++++-
>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c 
>> b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> index d894a88..972e8e9 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> @@ -608,6 +608,11 @@ enum {
>>     RELEASE_ALL_PAGES_MASK = 0x4000,
>> };
>>
>> +/* This limit is based on the capability of the firmware as it 
>> cannot release
>> + * more than 50000 back to the host in one go.
>> + */
>> +#define MAX_RECLAIM_NPAGES (-50000)
>> +
>> static int req_pages_handler(struct notifier_block *nb,
>>                  unsigned long type, void *data)
>> {
>> @@ -639,7 +644,16 @@ static int req_pages_handler(struct 
>> notifier_block *nb,
>>
>>     req->dev = dev;
>>     req->func_id = func_id;
>> -    req->npages = npages;
>> +
>> +    /* npages > 0 means HCA asking host to allocate/give pages,
>> +     * npages < 0 means HCA asking host to reclaim back the pages 
>> allocated.
>> +     * Here we are restricting the maximum number of pages that can be
>> +     * reclaimed to be MAX_RECLAIM_NPAGES. Note that 
>> MAX_RECLAIM_NPAGES is
>> +     * a negative value.
>> +     * Since MAX_RECLAIM is negative, we are using max() to restrict
>> +     * req->npages (and not min ()).
>> +     */
>> +    req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
>>     req->ec_function = ec_function;
>>     req->release_all = release_all;
>>     INIT_WORK(&req->work, pages_work_handler);
>> -- 
>> 1.8.3.1
>>
>>

