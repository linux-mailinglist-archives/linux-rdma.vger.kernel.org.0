Return-Path: <linux-rdma+bounces-3573-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B2E91D786
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 07:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CBE928667A
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 05:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3462BB04;
	Mon,  1 Jul 2024 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aRuNvwee";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r2qG93Ft"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628F5482CD;
	Mon,  1 Jul 2024 05:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719812446; cv=fail; b=FFocOY2H4nGEEzFX1HLQ6RprWo/oAlQMafErpFXRX5WpT9swFF1b+9o/OXceGygYs6IKDVmqL9bUZu7FqOy0EuElYRCpPfAOqwkcL7rnNcMelW0vDkGDr7hbPAMt9ChzNDleS+XXYki2I3pmI4Sx/OWahYr9IhlNFfAly8TP140=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719812446; c=relaxed/simple;
	bh=BZ+7uqAFJNBVo+r1dcjfF+CUwUtaSxcIPqV2V+NvmyU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VhvxSRaDApiXir67m8QCP8N8HZumkkWhNSNVW/n/IpSmHEY5yN08IF2kL9ierVUmiv+ixv+A1qGyUq2f/VQEkAuwbsKsfTqVszffPMpPH07eQcshfTU/mGMpPsEYxOD5+i62t2yj0D3RKEGd8xbq5yhY1MQv6T2OKPYZRa16FQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aRuNvwee; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r2qG93Ft; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ULe2mX027046;
	Mon, 1 Jul 2024 05:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=WzgDdvgF851838XFl5E8DGmpdvUgI/Ms0zVKsIvyGis=; b=
	aRuNvweeHKMhy8JbjZnfgNb+G0CsrD8B37RomRG5tJ9c4nkMKEOyKn+dbxHgC0pF
	juo7Qr1wlkunXkWMpeEHRr13EIeT+8C1ZQgnga6m5Kjxe3OfW7SxZmv9gs9Bnf+3
	1TxXz+ICeLKzirfk1vOtPDJCzuE27KwtAZgr91rWX4s1DeSjO9Mvo9/w+kKNTulI
	eS9Tu5ehyPjsxw2x0DYpzF8u/K391mf59/0Q6ICDmSkAGVjh7HSdf20m7AfcHCo5
	v+tFWw8xhiXStkWBkOvtHMb4EA3GMotzzd++v+XoSdqOONUXKViwCZPdLprMuKox
	MsRHQAg2atZFD/FwmXEZcw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296asvjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 05:40:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4615HwSN026309;
	Mon, 1 Jul 2024 05:40:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qc1k6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 05:40:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8++KduIOGunvaOlQU8lJA7921npYtfFR7mhLrPQg9J0D3B+G0B6QekXkkB8YLdMbaSjTa8z1lrGfJWEfuHCOH4eaX5NZGZqIeZwmN6gxn2LqwRb+5WMg9omVjIQM8ZuCpcHa9uJMqAbiTKbxJvCv7xlO8oceZUow3lznbnYY2iV8lXiT6KknOY7RcpNNnxoopAQlYfC1dCkoylOKuqBTjzWvC+6CgvJNCZ77r8rcfIFUeqNVzCqpo2/JzK36cvFkW6a7P7BDzd49ESXBRz5wB0JCzT9HlY6suSlPdEZY+4vPXPKWXPrvB3ugmzwrzfJwV2LXFrKOF3fGvnW7kCFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzgDdvgF851838XFl5E8DGmpdvUgI/Ms0zVKsIvyGis=;
 b=XnWbaF+EY7Zr9UtapuX1wwLsuX4pRHp4d9is/5QrCyYxVc1dAFIOz6hc88R+vmum7MF2/MOM58nHZS9crVxerUrSMWujRmdfAt4yM18gFHJHW8QTD9aKO2VnRHTdFhmK9gk8xR+sdhvjDIj41hYAYqrfYh9oRu0O0GWuyilJ6d5dy80Dfkr2vRH0Vje0OACsK/oTSZlCLvQzFA1KtTg0UKNH0H1Hth1e6BAcJZRMxvG/bDBIzw0/4WMZzyr4EN8Hqx5fLeRwyVcZY8odRAgvaelsNOZz3uFperQpJAzIAwzI/BT79Zx9KSgqCd9hj8mz8LCiuhZ8dROdbrvO7m8+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzgDdvgF851838XFl5E8DGmpdvUgI/Ms0zVKsIvyGis=;
 b=r2qG93FtNDQi4GmM8FkOGpW24SG0M1eubCR6II6zIGgLFc2J3MU9QaHeO2pJohP/xq4T3GviGTyGmIQxBCQKORnOqMyAkmtTxIYtfZQ0oORZtgEn/snLzhVP6hPr0S3b5ppcjGhDU/1QBvsYwMPQ9NoUpDniuLpTeXTOZDpC8Rc=
Received: from PH7PR10MB6108.namprd10.prod.outlook.com (2603:10b6:510:1f8::6)
 by DM4PR10MB5990.namprd10.prod.outlook.com (2603:10b6:8:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 05:40:24 +0000
Received: from PH7PR10MB6108.namprd10.prod.outlook.com
 ([fe80::e919:811:d952:4a3c]) by PH7PR10MB6108.namprd10.prod.outlook.com
 ([fe80::e919:811:d952:4a3c%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 05:40:22 +0000
Message-ID: <ccfaa2ad-5e36-471c-b989-a79ea04b3950@oracle.com>
Date: Mon, 1 Jul 2024 11:09:09 +0530
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
X-ClientProxiedBy: PN2PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::18) To DM4PR10MB6111.namprd10.prod.outlook.com
 (2603:10b6:8:bf::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6108:EE_|DM4PR10MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: f76708c6-08ca-44e3-0476-08dc999045c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ckI1U3ZDaTIxS3grMGNrVVZtVnJtQXBBYnBqdkcrRXpGL1ViMjlzeXpwekdq?=
 =?utf-8?B?VEV1bWFxTGRhdmJ6Qm1iNVZaQ3BKR1ppT3hPS1ZSZlZ3K1IvT3RQNC9acTdl?=
 =?utf-8?B?NDNLNFVpTWdLOG41SUlZNHpLT21MNnRnRWZVNFJpRERhRTl0cWxwOHp4ZTFO?=
 =?utf-8?B?TC9JcWdkenZ4Mmc4ZTBPVkJnWDFuMy92MHZ2SEppWWtnYllNVUtPcnpUdXc5?=
 =?utf-8?B?MFBrdXVhN1NlVGh1dkxmUS8wNXhldnlXQXpQd1RkYzVVbW5ZbHBSNDMvM3pW?=
 =?utf-8?B?QWRSV3MzdFpNbm9BUDc2VkN1cExna2ZQWnpXakd2UDNUYXllbDBJZlM2TWdU?=
 =?utf-8?B?SGJnV01pMFFNY0ZRSFg1UFY1MTZhdDJzWHRqRTNsZTIzSmt5SjdHcDJXSW95?=
 =?utf-8?B?TENjMTI1OVE1djVzTnlsanlHQk9ZdTlTV2lyTVA0eGN4WDFQaFBZVU9iK3gr?=
 =?utf-8?B?YjVhOHFDRlhvMDZjaGVabVQzcVhUcHBGb3Rma2VnWTEvVTBxWmpGa00rVWtF?=
 =?utf-8?B?dTZheEdYVlZ3VDlhY2czQmlRNlIrRDJVMjU3ZDJDRWxKYUowUTlEcTNXZTIy?=
 =?utf-8?B?OFFndXZhbGowY1MyYzE0OTVtWG51UFhRR0E2d3k0eTI3dVVDQUQwa2dyZXli?=
 =?utf-8?B?cmZTUEpsdEJTZG5xcURzTHRtTG4yWVg4d1QvYi9mVmVRQUJEaXBGZXFUUU1H?=
 =?utf-8?B?SWZsS3UrVFRrbmVKUWVsR3NVNVJHQ09PclhUekQxaTJMZU9qcjRDR21qRk5R?=
 =?utf-8?B?bGRaa2ZTYkRRZ0cxallGY2oybjdaeGNnTnR3S2FWcnVOczlYTStnTnN5WG1L?=
 =?utf-8?B?UmZxSmRhRk5MT0wwcDBSK0xSWklkZDFncGZobURlSkV0SG13Yy81MDVUaW1Z?=
 =?utf-8?B?Q2RvQVZtMVFXN2hJbm04YWNyQ2VtOTFBRFhUdHNzSlVMMlkzcDFZcHBZN3Uv?=
 =?utf-8?B?VVhDcU9kQmxNUW1ZcmdFZmlIVzdCckEveE1VcUJZNURQeUlFQmpiRThCRlBY?=
 =?utf-8?B?d0txRDBaN1VnVk82M0hzOHJORlBSbmlHZ211Zng2bnZ2b00xWjV5WDkvRVVt?=
 =?utf-8?B?RWRzdjYrZmpuM2RuSUl5a1E4aTFJcnh5RlEyYjRYZVZvODBWZktwcDNiU1NP?=
 =?utf-8?B?V3VlVjl4VVY2bmVkZ3pEU0k4OTluZFhCMmk1SzA4OHFCTm50MGtOYllySndi?=
 =?utf-8?B?YjlWRy9UM1BIM01nWWE3anQ4cjBEcHlsQUg5emx5aXh5ZkIxZ3RsTDBGQWZj?=
 =?utf-8?B?R1RKQlk2d2s1RWo1NktsUlRHL21ZeTdpY2M1b0I3dm1DbkxOZTd2THhwd1Fl?=
 =?utf-8?B?VHVJT0xKeGl6RkY1UWJyVCtKc09NdWZNQkR2MTdob1N2RWptOXZiUkJuNXp1?=
 =?utf-8?B?RmFuZnRPb3l3d05uTWZTVTRGdG9ySWVPWEFxUWFrMzNHeU95ZzhWMm9wR3hr?=
 =?utf-8?B?ZE5iMXJRQmdzMzd6RE9aVStXc2NhUS9Ld0dFeVhDQmp1SjFHSU53SHA4NGky?=
 =?utf-8?B?b2dHSG1jYmIrZTVQQm5vMnZIb25pdFgvaXFLbUVWaVJySEg2MGtvNmxCejNo?=
 =?utf-8?B?ZTlkOXJyZmZoSFExQmN5ODgxc0VZbmF1Q0pLdGlINHk0S1F0TFF3a29MZEta?=
 =?utf-8?B?WUFZS0o1dHdQQUxacXBqcXZTZVczWUhZdTV3L0xsZksvV1pPMzk0VFI0ZlV0?=
 =?utf-8?B?ZzNFNitDbThXZUhtZDhHVW5WTTlYcFB6RkxxWG5sU09ubVVBaGRJTHJyMENX?=
 =?utf-8?B?TU8vUC9ZR2w1N2pIMmgxN2pMbXNiR0NNYmxLeldkdDE3T3lzNjl5ZFJXdHFW?=
 =?utf-8?B?dHUyNkFWb3Q1NVhlTjFSUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6108.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UUN6Uk8zRzZCakxOZUJ2b2doMDlFMGZNRXhWVVVoNjQ5ZlVxUURVT01sWUhY?=
 =?utf-8?B?dzZlNnhPbTdkTlUwR2dpYWEvQlBKdXJOV1R4QTU0R2l6QTZ5Q05CdG13SGRn?=
 =?utf-8?B?S2RwNTZPZ212N1h1ZDZvdlVFazV3QWtyN2J2Z0t5ekxIOGM5dTFjT1hEdVJw?=
 =?utf-8?B?RDdPa3JoY09xTFZDcDE0Y0VmOUttK1d6YXgvYVRIZDRFOU42emIyYVVlZGFB?=
 =?utf-8?B?ZHdlQnpQR1hiZzVnZmJrMzE1VHU2Y1dwTEkzYjFiTlRMOWRWYVZsNXZtMGlR?=
 =?utf-8?B?ZUxXVEhNTHE2d0c4NkFGSXFUN3BKKzBDU0JvTnVtS0Jxa0tteG1kMnNPNGRs?=
 =?utf-8?B?NkJsWk1FVUx2ZG84UFJtY1h3cUVBUkxqKzM4cWxudExaNC9LdFRYNHJVNDRk?=
 =?utf-8?B?ZnRrSHJ0Q08zVWk2c2JlQWx4c3hXdlRUMXp1cUNYaHRtZHJaamN0aTZKV2Rx?=
 =?utf-8?B?bW4xUmJ4ZWQ2eldvMEVUYWVzcmFnYldyU0d2UndyMjVVTk5kTzFoUmE1YWZQ?=
 =?utf-8?B?MHlhUnA0TzUzL2dEcFlxOVpwWGtEd0w2ekN5U09XbS9tOE5XRTRuMGFiV3hs?=
 =?utf-8?B?UVd1bW9vRGJYOGNuT0t2Mm9mYTlBNHh0d244aDZGL0VjVjRtRlg3RllUS2RY?=
 =?utf-8?B?aEM5Z2ppYXpUTkUza0Z3aDBaZWVzdmVNSVJTNHV1U0gxMHMwN3ovRm5JL3FG?=
 =?utf-8?B?ZUp0REhERUNXTTBVQXEraVhXU0lheFJqUjlUU2t5Z2JmVzFkSXZrQXJKZXpR?=
 =?utf-8?B?OWN5VW9tSlRwUGtSUlFSQmVQellkbzBFRnBQZldhdmZnY3ZadTBmbXJCZEg4?=
 =?utf-8?B?azF1K0hYOXhJcXJSc1NpaTdULzNzYnhIY21TU0xZa3VBTDBsaUpDRHVEQmRl?=
 =?utf-8?B?eXI5MEhwVVRFRjJ1OW5JSTArNCtPU0xIWnZ0RkpsZHVRaUF4ZGo0aVR2Ti9N?=
 =?utf-8?B?TWZRREdEVW1WWjVrWXBoSHRJN0c4RmVVVnVGa28rSU4vamRYZFE3eFBaN1Fu?=
 =?utf-8?B?RTQyQTBWRlRmWE50R2RGdkVHYk5zclEzaUR0MEZNYVVqM2VOcHhWZzRycTJB?=
 =?utf-8?B?Q3FnQUY1VkgwUEVaV1Q0QkVYTXZpZ3FEcWRXYzEza21rc0NhMzI2WTU4THo1?=
 =?utf-8?B?ajg5ZkRBRE1QTHFmalNyK1hvcGM1UGp3TkhYVW5STjEyeGVvcHA4azFDVFYv?=
 =?utf-8?B?a3p1MXdPM0RsOTNIc1MrQi9BK1A5RnRhZ253RHR2dENmZldYTURUMFRmWDJz?=
 =?utf-8?B?a0FZczFlaEcrR2h2Z01odnY4Zlo5d3hnd2ltYUlRUnc2bUVvWUVmbnMvdmJw?=
 =?utf-8?B?WTlDODVzMjcwZE9pNllQUXY3ejdpQVNCRW9RQ2dISFBHYjhDdkhNWTg4SlFx?=
 =?utf-8?B?dFJ6b1Z6aG5YbzFGZXFQOHRLSVR1eHorbXgzMjlSL2xjcjEydmE0V3BHaDY1?=
 =?utf-8?B?ZmRlK2pZYWtnQTlKRGZOdEtJeTZXb3M0VVlkNXNFZ3krZ1RFVzJ5UEFKSkF3?=
 =?utf-8?B?UUNTc0VDMTI2aDFsTjFYSzhsaVI2aVhJWXhHMEJiUVFDeVVRbVgrVXduYTl3?=
 =?utf-8?B?QUtvKzJxVWVoYktxOUJzdVRYSTV1Vjk4V3c2NW54b3cweExVcmR5bkd4USti?=
 =?utf-8?B?WUtvaDZjbWN5R0ptQWRDNU14alFBSnBIaUpJR21XTkpOWGYrUjNTYktYQTdO?=
 =?utf-8?B?TlE1RkZsbDdOVjFEdFNXSkx6VGxRYkY5bWVZcmJYSzR0NEpZeXljeXJQcGhE?=
 =?utf-8?B?ZjhrZFVVQlVlc2tKdDZTdGxnT05tVkZIVE1OVCs3YS9oNGdoMG5OcVQzdzlv?=
 =?utf-8?B?QmswNDFRTjFYZXMzNlpycXBEMFFBdTU0Q3FYVm5IcVRUT25taGxpNGdaM25O?=
 =?utf-8?B?MXRYNEk4a1BEVnNvMEd5T2RCVzhQZS94Szh2aTVwSzZ1aDE2dGNMYW05NnpC?=
 =?utf-8?B?MEoyQmp0RDdMM3o1aDQ2QU83SE9QUUhYUGd1OWZub0FacTRzM1l1b1Y0ODlW?=
 =?utf-8?B?cGJPVjVjQlpRSkdxSGo2a0U2YTNpYXM1R1NCQXVSQUZVRStmMGU3aU5kbkJm?=
 =?utf-8?B?V0JEb01MeUppN1UwMWlJVGZEMEQ0cHZsUTU5SnJjTlBYOEhvbk1rVEJGQmE1?=
 =?utf-8?B?VUp3Umt2bkowcmI4NmhqUURUdFJIaDl0NTlFeG5oRjZaLy9sVjMyUlc2bFA1?=
 =?utf-8?B?Si91QkdaSW52ZmVOcHNBalRPQW5qMU1vV3A4QkNGQ0I2VExVNnZEQXFjNWZn?=
 =?utf-8?B?aDdOVnA1V2NpSkx3N2luajlNaXRRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cNOHwTYhD6ns36TOqHRVzchlepUkw+4+IFz9Tr0WoQDAv5/qUU/I04lny98nSYcOSdB4j5rvVsvdGaYpkkSwycCluFHDImCrelr3fNymvikPqGGqvSmWUI3w6RxTFjttBwKAcYZQztVPXDqe2t9RKEQH4X6CD0HxUd/8uGyD4lxdeo67oAFCi49cvnfiBO4/mhFK4mQBxF2AHqBURTpcNBb2ra+7Ux0TWbBskzSkyKf/1pFsGgIry7+gMJnKRYpdFvFHMHRlXhrSUTtKb5sY3amC3CIk05bxtib4IPOVR0wfupxSMGeikLXHFLZbw/5c0dvrH9oxOYT6HDMZsPoKq/n59XFKXiyLIbSVok6zQMElz941xEDGMJAU/TUquuBFxHGthTHuS6flSHXM4/EvB0VkQ5hkuEez/AGCUAlbj4rswBtWoiPLD5LN5jPeex6LMzr+wvpcmbFoRJdGzh+HjFqG4TorOpbdMkEa9R3UNwHVwQJNoCSaCwsO/UoQ2I2bpQVPN1nTTu1BmbAwaF4S4kh/ZkJG+N9h6DZ6EVwnE52Q6VvHsSygL/ZRVm8wAduv2AiCekIktrDCPBUd4a0nlV7Xf43kGReoOSOh5sqsH6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76708c6-08ca-44e3-0476-08dc999045c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6111.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 05:40:22.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhVRGmDvLbYd3OcOgOrzozMyQC3wkXJRINUPzWlNqHzLNSb2Kvt7yLpIplwVBBDhjeHw016f7ZnuPDQcis66HZ4+q0be/q6bcEjPIQ8Gm8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_04,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407010041
X-Proofpoint-GUID: MXzWTjvj2XwDK8co0sf49mS6JAe75AjG
X-Proofpoint-ORIG-GUID: MXzWTjvj2XwDK8co0sf49mS6JAe75AjG


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

