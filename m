Return-Path: <linux-rdma+bounces-8990-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD42A7203E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 21:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1614E172BBC
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 20:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1751825E445;
	Wed, 26 Mar 2025 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XypZgX7h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B2tLqfAE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767D1F4717;
	Wed, 26 Mar 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022430; cv=fail; b=Fb+ZnSGI75xJYDBtlp5luHzrz3MW0HG+9aX9orhVAQ67VNQP/ucQzTt1ygNg5Nk518s+fPkKtu5GwPgyv1iSdgtREkb3spdYKH9xw2Y41z+Paj8pDs44RSi6WG1cGUMeVcn6hcgKcyEey+WX9UvogeVoT+RY4m45xmpxzT7a5s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022430; c=relaxed/simple;
	bh=UV6tYY12KMWpLNotmdQQ4fDbRXzsj9pAs7IN4apq6F4=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=bJUpUEdWKLqwiV1mTYPYskopmgCEr2Ab6SdS7AH0rYX8rby2pumet6vM0vRkjXGbWB/DakkR3yHEQjp9orAYpx/Z+igQzAgFaqefuZJ2h7DkAiyksy7RfWuIeg4A6FEpQxEqa8aTWpknsNr0MPxx/N5i+zi1mnotOYXf6oujVXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XypZgX7h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B2tLqfAE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QK0ZNm011405;
	Wed, 26 Mar 2025 20:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=qVgvQ+tB1l4Um7i+
	OoFPlBSE3k7lwqGkhx3h6FiF7X4=; b=XypZgX7heDBTVedAhg9kjB9FJ71nxKtD
	JtvO7TWCCPmwOoyUJNxzgyDxHrkr75zMPRjEDdCh1jOgbVzktmiJFIZI/Ab5X2Az
	2lPJ1+utnmFSN0yfIg57CepNSF5rUUoU9VJsIicYBDcs0pzHotId64GCQaUemfcm
	YgNat4GhNmKaWixmVoZjUfVNomgyzoXMU7kmdRtS19G8dhglSyE0zhdB9FjM8rAq
	ZA4QNXFGtA92FO6gjD1DRHHQTJDkC3J+SkU1kU2R/iUFcIigp/0esF1EcWVQa3uu
	UBy4MSjZ7r2kegCjFcS6SK+kac51YxbC6R6Kloiuej40zSmlmQRPnw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn872dpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 20:53:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52QKcL6w029514;
	Wed, 26 Mar 2025 20:53:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjc2ww25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 20:53:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz3Hs7VCii2BJjGjP9GDpGVHv1WeK4FgqSOOEgJ+ycBdDcdygLGYXnAq022IHEbjAQyNeR2TOgT5fcOHQYZBWaiVGzLYO1TR8QYmdHrgyC8ii8e5/X1oUtewCbRqQVK/to/Ehqfy6duVM+qPP6DsKjmoNpfMObqVfMrRxH/rAH9d0UGBetMYKgXdgLb4Qw67W+8EEquBVKlqRJZek5npPAX3lgaioAo2H1t9bf+irKgKjdSOq9je7FrUeud0F+UkPDyWWZxxHboU1IhhLay+dF4IODkc1KilKECq8C1oWJYvZgNAWT1z0rGNOQpTSyOeOLwidauiYpEGSUP97wBFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVgvQ+tB1l4Um7i+OoFPlBSE3k7lwqGkhx3h6FiF7X4=;
 b=xHfSZYLkFr4IB2q4sFDkgOEvVVFnH2HiN/5+gr2kPLy4nmfjg314Fr86vOP+6W/qGKzGxsJZ55LccsvBUlfyhgRmky6kezcMMeUJqNx0O9Tk4nPghKUX35FWYjvPMCCQZ4ZR0emMw/1G1RbRU+FRbZfWnYZcxHOnOkwpdZEFCiYl0fHvwqRPlzHpkRtARyhLq3JvKXvpQDUTRXtnThLrJuq4ngE+q26kaQ1rZXzFxi6sem46j3L2vbF+1lEn1t7YqQKIYLb/l9U0FSWeNpc6qnZ67YG8NPW1zK5f5oNu7e2FlPB4MliC3iYWtKkUxIuPYQfmyRjWpGSXrQNLSLRMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVgvQ+tB1l4Um7i+OoFPlBSE3k7lwqGkhx3h6FiF7X4=;
 b=B2tLqfAEaegj1KYLfDaaQk+rswECVIdW82zGDTf3pDupZvrvCcM9d/s9P0WL8y+GGd9IuQUjkrfRQ/jSLs6pn/jWXkAI7IIUOZ02F8rTD5qTwTNir4ynT5wOwYOJTuel6xt6muKXJGmRGir6jgcGqrV6VCqGlFaWzS79/9qNvwQ=
Received: from SJ2PR10MB6962.namprd10.prod.outlook.com (2603:10b6:a03:4d1::13)
 by PH3PPFAE1A1621A.namprd10.prod.outlook.com (2603:10b6:518:1::7bd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 20:53:41 +0000
Received: from SJ2PR10MB6962.namprd10.prod.outlook.com
 ([fe80::c588:aef6:a2e5:9ccb]) by SJ2PR10MB6962.namprd10.prod.outlook.com
 ([fe80::c588:aef6:a2e5:9ccb%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 20:53:41 +0000
Message-ID: <01d53331-4b88-48bc-9266-f8862d75b156@oracle.com>
Date: Wed, 26 Mar 2025 13:53:36 -0700
User-Agent: Mozilla Thunderbird
From: Sharath Srinivasan <sharath.srinivasan@oracle.com>
Subject: [PATCH] RDMA/cma: Fix workqueue crash in cma_netevent_work_handler
To: leon@kernel.org, jgg@ziepe.ca, phaddad@nvidia.com, markzhang@nvidia.com
Content-Language: en-US
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, haakon.bugge@oracle.com,
        aron.silverton@oracle.com, sharath.srinivasan@oracle.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0949.namprd03.prod.outlook.com
 (2603:10b6:408:108::24) To SJ2PR10MB6962.namprd10.prod.outlook.com
 (2603:10b6:a03:4d1::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB6962:EE_|PH3PPFAE1A1621A:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f48791b-76fa-4d6b-d376-08dd6ca84a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnYrVGo1M09nVEhUV3gwTnprNG9tNGNPaldwZTVzV2ZMb0FITG1DSGV3Vjls?=
 =?utf-8?B?Mml5QVU1dEh5LzU3a1JwTC9WcFlOUVFzbXJ0N01BaTlMS0tJeFZFZUxVYWZK?=
 =?utf-8?B?dWNDaHBtK2ltQ3puOVRRUjVhZTcwb1JPeVVYaXg2bWlqT1VoT01qZ3MzMWl2?=
 =?utf-8?B?N0d6UVVYeWQwYnBLNjcyUFRpbkpsM2tZWGtQZW96NWhFMFNlVHNHVnRBQldq?=
 =?utf-8?B?UW1KZEdlZWhKRTBoVzZQRzBlZ0hSNGJVOWJEMHJWdDlVck83RVlmSVZIaEpy?=
 =?utf-8?B?bjBRaFErU2hwbFk4aERQYlFIVGt5d08xVldKdnJtdjFvd0h1UGJLUHVCb2hs?=
 =?utf-8?B?T3IvNWphVzlRQ0ZaVFFqVm4rWkxySGJYVmFBd21VcmF1MTdhcGVaTk5aVTBs?=
 =?utf-8?B?ZjhhckhUdG8xclVDVFNMdEZEZ1AyWnZEbnZOcU1vSWU0OThNOFFZSDFzVVF0?=
 =?utf-8?B?dkxMNlNBNDgzTjBYdDMzcm8zUTErWUJwZ0RyZ2l4bGFqaGJtL2M3bDA2RnRX?=
 =?utf-8?B?T2NmRHdxN0RRL2VyZ3cvM1BsQVczMWdCMXdDSGpYTHYzcGhlbmI1VzVWdUo3?=
 =?utf-8?B?dlQ5OWR5RkNCQVpSMG80QStWa3NpWEZTdFNjQ0lqZUdJZlVFZEw1a0doL0lF?=
 =?utf-8?B?NGZNemJPbHByelNDV1lTbHp6WVFlallNUU5WQXc3V3NMUUVqcnViTythY0RJ?=
 =?utf-8?B?dTA0WHRUWUhnMDBYTHZBc1FWaGhXRjB3NkZxWnJiRUt3QW8zTnJvTGdQOEsv?=
 =?utf-8?B?MTFRcTRHWmRKR1orMy9FMjlrRXd0Q1AvQ0ZVWVBXelNWR0x0dFZKTkRjZ3JJ?=
 =?utf-8?B?VmtKWTdWZmROOSt5cUJFVlhiZ0lZTkIyQndxc3kwekpxaDZ4cnozUlFYbkd2?=
 =?utf-8?B?QVR1N1Bvenh4WnJBMm00NkFqSC8xbmdGSTZnUWRtWFNiTHMwYTBNM0FaQjd2?=
 =?utf-8?B?b3BBTkhQZjNHb1k1b1B0SEpoTEtpeDY2MG95aTQwQWppRmhYSmxPZ25rVktJ?=
 =?utf-8?B?VnlTYncwTmJlTFk5SnZLTFc2M0x5QTNHKzBOYUtGRHpNU291dEV6RFl6cWZW?=
 =?utf-8?B?cWZuMCtvamhIUlRKUmlvTHRVRS9yNFhLNktPUkVBZlZ1V1hzYURtZlROamxh?=
 =?utf-8?B?K1dGQWp0bnZkZFg2eWdMVEgvWTJ1eFhscS9hUmNQeTY4dnJwV0g5Ry9SSzBJ?=
 =?utf-8?B?aDdzZGpWMWhLM1U0aVpzcE5xQm5LT1JKOVhRS0V2YktGQkNVUVloblV3cTMx?=
 =?utf-8?B?cVBHV204aXNJME5JaWNqREc2elVqOWJsVzdyTnBhWjNLcFg1YkQ2ejZTbUF6?=
 =?utf-8?B?L1J0N3lZcmdEZlphS1ZGQ1hnaGR3UmhFM0JWYXluN3l3U2J6MVZ4TndLeFg5?=
 =?utf-8?B?am9rK2gvOVdFMVVUUVZ4eWRkdXVPRXlzb1VXUUZaa0JUb3lQRnlwNG5GcDdB?=
 =?utf-8?B?RFplaytLM1RTVFVkaHZQb2ZqVmJrZFVTYXAvTll4Yk1XeDNZT2F1d201eFVR?=
 =?utf-8?B?cUZETi9jZTVtWGduMEEzSmY1MmNzNXJPNGljWHdTTTZlemQ2VEJicE9mRVNw?=
 =?utf-8?B?Q2toYjhQblZ6MlR2OU1QRWpPbVdBOERHeEN4bGQ3NTB3MEhtQkpaTkV6OEdw?=
 =?utf-8?B?aHpCVUlSRGpNaitjbWp3aWVadklBQSs2TXEvME1oNGZyaDJ3RE16aE9QcUp5?=
 =?utf-8?B?MkE4YnlSWkZwbnY0SDRKVXRrVXAydVlVanpDMmlyTFNmcm1XakN5b2k0NFRQ?=
 =?utf-8?B?VG9xWFFBbFVZVHc2NHQ4RXY4M2p3c01DMXVZbTI3THpIL1NiY1lkbjBoTzFt?=
 =?utf-8?B?SWh6bWpraHZteGNqN25HQmNMeG92UHFlNmxQaCtacW8vS3cycU1TWU9NRVMw?=
 =?utf-8?Q?fx93s06N/9ckG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB6962.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkZld1o2c2N2TWFYM01Bdkt0WVpKbkMyUk5TOEFXN2lHYVNveVlpT01oeCtV?=
 =?utf-8?B?UWpLbDBZVytRNDZiYUNjeERnT2ZDN0VvQ0tYd3lxenVFS0VPQTlEdVI5RHhj?=
 =?utf-8?B?WWMvaGJnWEM3cmtSd1BlMWNvRU9VTHVjc1AwY29IZVlyeHNpU1htSTdrRzVy?=
 =?utf-8?B?dFhiN013VmEraHBMbWdYK09KdytrbDdqQkFGV2U2bDVBQXNVVVhjcGVKZXor?=
 =?utf-8?B?bytFVkR1TitDeGtmcFIxbk9VVUY4VlZIZnlNRjRBUzFSbnZLMml1ZkViK2hh?=
 =?utf-8?B?b2tJeGwzbHZpWEpRZWd6YUwyQWowaEpDQzN6aGo0Y0VSL3puVyttM21STnli?=
 =?utf-8?B?U3lOM3ZqZGNLSjltbUp2SzJSVWtiM1NIRUV3a0NIcXlWUnJQOWZ6YkxVNDVa?=
 =?utf-8?B?ZXMyTlZGMDdIUjFLZy8rd1hJcytXSVNZM0hhU0VQOXdnaFlrODVYYnhaM2Ix?=
 =?utf-8?B?aVBERmk4VS9VdWFHKzYvRytpS0ppeHlXSGZMQnRMR25FSC96YlI0L25Fd2VQ?=
 =?utf-8?B?WGZPQk1NdnEyamtLemFnUXlmdGlJaUZjNTVjc0F2cC9ES3paN2Riakhja1Qr?=
 =?utf-8?B?UXJEMXpZRlFaNWV5MEFoem5vRzZjck55ZkRyMER2V0htNlJhQUdsczAyWW5U?=
 =?utf-8?B?M0NNUTZaQjhzMWo4bFRwdWJ3eC9JUklFaXFzSzVnN2l1d1d6M3BFcDBjUitu?=
 =?utf-8?B?WjZRelJsbXhBeDVKQ3VhNDF4UWtxNVN3MndCSnVNMm9ha1FwOERIbUhoaWdF?=
 =?utf-8?B?emhzMGZuVkQ1eFEzSUNTdERvelN3WkhaMUUxQk9tdkdZTWlCZ05vc0l6a2x1?=
 =?utf-8?B?YXE2YjQ1V1lSaVdWY0dVZ2p5ZlhkNUNOcFVPOHcwUFY3NXhOYjRFdUtvWmlw?=
 =?utf-8?B?WTQ5UUwreU9iU0JBUTFkcEx5Z2VYUUM5UjFqT3pXd1NOanNTcHBzQkVaaFJ6?=
 =?utf-8?B?d3dJQWdJQjJxemJVTzVEdkl0WnJRM1czZkpDME8xSEprVGhKdWpJcVZ2enZP?=
 =?utf-8?B?YTVCU25TZEczcmpxZWZQZHc3UXhFdk9JSG91aEl0OGl4SUdLRFkxNENpYm5z?=
 =?utf-8?B?eVFyY0ZDTUpuYkNiWTNhVjkxeEhjSmx4cDdLM2NpM2hxd1pZSlRxZ0lQYTE0?=
 =?utf-8?B?eEJhQnVaVnZHL3RrRzNCalRoVjdreHllRi84WHZqa2RrYk1ibVlZdk8yczhM?=
 =?utf-8?B?RzFGVk5zd1RQTW1Qa2Q0YjVKdERIT0VicElUVE81VW54bHJhd1djeXpHcDBR?=
 =?utf-8?B?SHdDdy8yMXVxNC9rM25yT1ltK1hJTjdhbjM0R0ZrSUFGdm5rYUZjdDFXU3k5?=
 =?utf-8?B?bzNOUXNOZGdGNDZHVVJpMENiNGdsNzdTRTVoSSt6cDJzazJsZzN1bnNTQ1Jx?=
 =?utf-8?B?dnJ5cU1BWTN2R050bWplT1Y5dFFBeVdVcmlFdDFLTmloZTNKdlVZaklqQk11?=
 =?utf-8?B?Z201S1hNRnBlSXVVZ3VRVUdJTDNDelYvcXBxK1JjdDJQYnFWM0hEQmpxTEMz?=
 =?utf-8?B?OXRONVJ6SWZBaThrTm5YSGphako0NWdncGZDdlNmZTlvdlZZektmeFdHNUQ0?=
 =?utf-8?B?UmhpWlV5TXBsZnZCR1NGS3Z2WDRnMWkwWGlmWlFzeW1mdDQwSlJpR1p0S1dI?=
 =?utf-8?B?YytZTWs1Z2NGTUpxc0hXTWxnZ1BJMHp5M0xNQW1NUWU3dWZkenBlVktlbzgv?=
 =?utf-8?B?MEhtYTBudTlpMUVlQU1HUkVQUm56U1BjbW9RUlQ0L2J1VG52cFVQeFZDV0RE?=
 =?utf-8?B?SlpWNVR1ZWthNCthUTgrR1ViWW5RSUtISGFTcmNlSjN0Z1czN1c1TkVVNmUr?=
 =?utf-8?B?djBKYlhYYjRqdXdPbVVmbHRKZHh3WUVLR3V5N2ZiNTFmSnRuZkU5Z0FlVUxx?=
 =?utf-8?B?UDFiMXNIbFl2VS9zejVKZlEvUm5yZUdpbnlGdGV1a25TL3RUREtjR05DWkti?=
 =?utf-8?B?WXNwVkplaW9VNFZQREVGMGlqTGtDcnowRXBCa3dCdWQ0YWNhMHpGeE14WEs1?=
 =?utf-8?B?MGlkVUk1MnozT3JOanQ0TE9oTDNFWFozQUpFZ1RwMXo1SXNLTFdLYzlwQXFh?=
 =?utf-8?B?STJyZmI1elJrcDBJSFZnc3JGNlZoQmlpYUJHZ3Y1ZiszYTNUVEM2MndtbWZJ?=
 =?utf-8?B?bktGZWtnK2RMam15TmR0VnpaMWpDdVY1dHp4YzBUTkZvYjlWYkVqYVBTQW1R?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L0l8azIGdwO3Nvdgqz/+e+z8rKlupqG5prp+NCraeAQSaBvEMsad0EKnMsQwSilxxGD980AQOustq2jEcPdSgwSyUZcBTciBgIHvifUg/lSLdMGlHzb0BpsvLxa7aGb0p4YU0i1O+LUIkIPun8yYsPaJMLV+/ENIudQvHy04arlhElrtU3NQiJY+5dg3+XUTT6gBBoGBQTYqLjQTAqXUf3oF9AqvMSOmu45HQ1FsdFIAZFMtdJbEMqzeyJLbTNhDu+0LHM0cm0JmpcdGqKrXAEBzHF2rik01QhcWZrJZDI1cF4ZpJw7B066IZDK9CK4fL6P2zkGnp+hOfeWbqoz2hGU7V7nq5o/81iIOkm4S0TqsoEgBOY/Moq2ZELy6ZOYysuYoWJ5OuzcJ0ZTGK9+PtVB6QjS38nqEX5kWkOKvquxGlbapMkn+H1BUKIu5E+YRnpODzctRaNbxEj9Egx27S4piDEb5hJfcl9doiCvh0klZrpW7oUZRXR9Olvi6IWR2XqNQxYQL2cVoj4KopushfGI7efNCJVWpsfM0tOpArNR7Okcv0zD221rJX9BzrINh6oa/t1U4Q9T774jlx21dCKBV8CCFk9cVWWwhj2KuZAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f48791b-76fa-4d6b-d376-08dd6ca84a0f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB6962.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 20:53:41.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlgA/9fWdjxJk17sitKoB2J1C40e1JcB/hyGcw5mgpBj2a1hZIv8oO+rLrAPg2HqwNCgvcEGjgynUDaTZDvCD/R2M0PRTNS7824LQNXJn5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAE1A1621A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260128
X-Proofpoint-GUID: SjZPVgsUD0gWDxOCHy9cjXySAPKtOoSq
X-Proofpoint-ORIG-GUID: SjZPVgsUD0gWDxOCHy9cjXySAPKtOoSq

struct rdma_cm_id has member "struct work_struct net_work"
that is reused for enqueuing cma_netevent_work_handler()s
onto cma_wq.

Below crash[1] can occur if more than one call to
cma_netevent_callback() occurs in quick succession,
which further enqueues cma_netevent_work_handler()s for the
same rdma_cm_id, overwriting any previously queued work-item(s)
that was just scheduled to run i.e. there is no guarantee
the queued work item may run between two successive calls
to cma_netevent_callback() and the 2nd INIT_WORK would overwrite
the 1st work item (for the same rdma_cm_id), despite grabbing
id_table_lock during enqueue.

Also drgn analysis [2] indicates the work item was likely overwritten.

Fix this by moving the INIT_WORK() to __rdma_create_id(),
so that it doesn't race with any existing queue_work() or
its worker thread.

[1] Trimmed crash stack:
=============================================
BUG: kernel NULL pointer dereference, address: 0000000000000008
kworker/u256:6 ... 6.12.0-0...
Workqueue:  cma_netevent_work_handler [rdma_cm] (rdma_cm)
RIP: 0010:process_one_work+0xba/0x31a
Call Trace:
 worker_thread+0x266/0x3a0
 kthread+0xcf/0x100
 ret_from_fork+0x31/0x50
 ret_from_fork_asm+0x1a/0x30
=============================================

[2] drgn crash analysis:

>>> trace = prog.crashed_thread().stack_trace()
>>> trace
(0)  crash_setup_regs (./arch/x86/include/asm/kexec.h:111:15)
(1)  __crash_kexec (kernel/crash_core.c:122:4)
(2)  panic (kernel/panic.c:399:3)
(3)  oops_end (arch/x86/kernel/dumpstack.c:382:3)
...
(8)  process_one_work (kernel/workqueue.c:3168:2)
(9)  process_scheduled_works (kernel/workqueue.c:3310:3)
(10) worker_thread (kernel/workqueue.c:3391:4)
(11) kthread (kernel/kthread.c:389:9)

Line workqueue.c:3168 for this kernel version is in process_one_work():
3168	strscpy(worker->desc, pwq->wq->name, WORKER_DESC_LEN);

>>> trace[8]["work"]
*(struct work_struct *)0xffff92577d0a21d8 = {
	.data = (atomic_long_t){
		.counter = (s64)536870912,    <=== Note
	},
	.entry = (struct list_head){
		.next = (struct list_head *)0xffff924d075924c0,
		.prev = (struct list_head *)0xffff924d075924c0,
	},
	.func = (work_func_t)cma_netevent_work_handler+0x0 = 0xffffffffc2cec280,
}

Suspicion is that pwq is NULL:
>>> trace[8]["pwq"]
(struct pool_workqueue *)<absent>

In process_one_work(), pwq is assigned from:
struct pool_workqueue *pwq = get_work_pwq(work);

and get_work_pwq() is:
static struct pool_workqueue *get_work_pwq(struct work_struct *work)
{
 	unsigned long data = atomic_long_read(&work->data);

 	if (data & WORK_STRUCT_PWQ)
 		return work_struct_pwq(data);
 	else
 		return NULL;
}

WORK_STRUCT_PWQ is 0x4:
>>> print(repr(prog['WORK_STRUCT_PWQ']))
Object(prog, 'enum work_flags', value=4)

But work->data is 536870912 which is 0x20000000.
So, get_work_pwq() returns NULL and we crash in process_one_work():
3168	strscpy(worker->desc, pwq->wq->name, WORKER_DESC_LEN);
=============================================

Fixes: 925d046e7e52 ("RDMA/core: Add a netevent notifier to cma")
Co-developed-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>
---
 drivers/infiniband/core/cma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 91db10515d74..176d0b3e4488 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -72,6 +72,8 @@ static const char * const cma_events[] = {
 static void cma_iboe_set_mgid(struct sockaddr *addr, union ib_gid *mgid,
 			      enum ib_gid_type gid_type);
 
+static void cma_netevent_work_handler(struct work_struct *_work);
+
 const char *__attribute_const__ rdma_event_msg(enum rdma_cm_event_type event)
 {
 	size_t index = event;
@@ -1033,6 +1035,7 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
 	get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
 	id_priv->id.route.addr.dev_addr.net = get_net(net);
 	id_priv->seq_num &= 0x00ffffff;
+	INIT_WORK(&id_priv->id.net_work, cma_netevent_work_handler);
 
 	rdma_restrack_new(&id_priv->res, RDMA_RESTRACK_CM_ID);
 	if (parent)
@@ -5227,7 +5230,6 @@ static int cma_netevent_callback(struct notifier_block *self,
 		if (!memcmp(current_id->id.route.addr.dev_addr.dst_dev_addr,
 			   neigh->ha, ETH_ALEN))
 			continue;
-		INIT_WORK(&current_id->id.net_work, cma_netevent_work_handler);
 		cma_id_get(current_id);
 		queue_work(cma_wq, &current_id->id.net_work);
 	}
-- 
2.39.5 (Apple Git-154)


