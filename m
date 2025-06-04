Return-Path: <linux-rdma+bounces-10975-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF4ACDB72
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 11:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6477A1553
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 09:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECDF28CF7B;
	Wed,  4 Jun 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tVHgN+iE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB54283159
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030824; cv=fail; b=LOUU/QCtXlAN4Y36gqc2bi76WsEuIpt4UB+gJ8WlcbrQXST65+2o1oZPQr/ZQpWR2u50b4Ne9tRthyXPjwpwn6Idpti7bCbVbTExl60QnGp4IfUb+vyRzm0jEQRfi8ZTVuQdv+3SBKbVkTiOqy6UocNDg2gpcVOvGJ7EDtOFWBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030824; c=relaxed/simple;
	bh=80fMxhA7xoqYpvS60kvozw0QyST0OXuzwrU4HM4S5Sc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LbcSkx1KzZrpVOuNx1EQ4CP/LdZ4HmQyEZU0CzRqwl+c5+dtxe+RJMtKJraDcSwprHG/EV35FcbNl4uI5ec9v1aRfho8WDLrZPnvhcrTcH30AGE5YR6mIE84qwIVRd3XuPbUAy+Ubk0VFbdH0DHZn4BZiSixdM6tONcizcPaawE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tVHgN+iE; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLVL1LrT8EDK625defqtj+MmXrPFO4S5DrEtJeWEgrUfqk2TAEoF928RkSffZ3MsuYRS1Cw+BPLCpToPWpii82qZ7rc4RyMraLGQ1zDUJ+BaZ6ScuAwjAm3JZy5WVJgEyoXc0POPwleM9sIsevVTFB0TRvsaskWkyGnWkpRSN59yX70WulreZ7PkcW3APXoAhIcA5Tk9qqRiBg4S3ABTbQ/bjW5BeWjscJmQZ3m8yvDrjn+cuAE+cJtWKr6nWMHl786FYucG0aYIL6JNHutsxcqIBGV7aTMSqdBzqZHMIEhUyV6+zExY4tkzWNfWWD1siGsUBwHT4rR2uepeMiZKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ek7dShOOfvwSH9EOZmO77xG3WrymccRgrWzyS97Kh/Q=;
 b=koX/HNUQqqhuC78KhSd31QAobyTk46b8LX/d2mA+yCdrrUo3e5IicU60AzdGrQtEbMSkTfBjsmV8ZidSKbMl+Pxk7iD4JC4yj6Q4PCiqjri93k/HTDh2Ycaxigq46gVmHh1ZBCn59DwRr+POn3L+ogAw/8IMPgMpzu6BbNrMTL3sKfw+EPeXZseb3lwrjCsDgn0l1aaEKCUTCXX/lCflrwgV9IHYzA5qkYmSydfRdGG8hINKcyiptLowUWtz6mThdFOruTLn/Zisg58t3OxAoizp0+Ob13jEm2vtYAVDSPQy9zccX127wSV0F+d7ivHQ3vB+DJqnsDUPHFTuTPt2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek7dShOOfvwSH9EOZmO77xG3WrymccRgrWzyS97Kh/Q=;
 b=tVHgN+iEz1geut7m4BSKo/wN+8M7gcxVAIUiZ0+b+dMGNrVFI6Uy9kAOlvHqfdiVXVlWTBZKtPEFKhCnCPxCwbWdHBbbvOGtGv0c4rwjASc5llkZe88qeuHOYvJrFC2PsYxMdTpxr341iDVPb4jLqgS+H7J084L82+mpi2UPP1vanv8u3jk9z1zVm3Oj04jLPQ9GNlrsIcdYTPj/vNQjIoJJZKwZZLeEY5OIEjD67WqJ3UtDadVnFCY69iPTnCUiAb5oqe42VA80nfbi0tTgawSn0j9Yt4XKIXjHqGfCp0k2CVVNGJzhcpUEm+cGp3F8HChMuJ1PdDQn+kazHExvng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CY1PR12MB9581.namprd12.prod.outlook.com (2603:10b6:930:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 09:53:41 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 09:53:41 +0000
Message-ID: <826d8306-ef04-4797-9bd6-e4eba9bfea23@nvidia.com>
Date: Wed, 4 Jun 2025 12:53:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] infiniband: iser: remove the unnecessary var
To: lijun <lijun01@kylinos.cn>, sagi@grimberg.me, jgg@ziepe.ca,
 leon@kernel.org, linux-rdma@vger.kernel.org
References: <7ddad30c33cace54cf409f0d27bcb38881b796c9.camel@kylinos.cn>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <7ddad30c33cace54cf409f0d27bcb38881b796c9.camel@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|CY1PR12MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d477a3-537c-4d6b-1a50-08dda34daf75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTJiQTFSTnh0RjdTeXpHVUZpT2VaYVEyOWwrS3pNbXB6clFmT1NqSUExQjFk?=
 =?utf-8?B?QitFQ2dVRVFqeHYrbTNONmJycU5QdDFHdUc3ZkRzcldrRnNpcXYvK3lPR0hI?=
 =?utf-8?B?NW4zcEs0NzdQc3ladzJiOXJSVElSNmxHU1U3TGZoVVUzZGJmbEhTVDlncGNo?=
 =?utf-8?B?Y01NMFFTZC9uMS9iNk9SeUtJbmNoNmdsSUY3MG9Jb0hmQWExUUhnN3JJZmxF?=
 =?utf-8?B?bElld1MxSXptazR5cjdNUHJ5TkVHNXN6bkhVRjZpeHdkV3ZGT3hobXVLVG1I?=
 =?utf-8?B?QjE4Q1ZIdXVNNW9vUTlaQkV6N2ZCY0lGRTFnRVhYRzJqL3MvSnV0blNpWi90?=
 =?utf-8?B?ZHFjQ1h6UzdWcFFTV082emhYZDcvZktiWnlsVXVVM0ZFdUhJVStjVGl2YTJk?=
 =?utf-8?B?U2NYdmwwNFBjVmpFemd2WGVDVUlJNkdUSjVwYllQNGZ3NzY4UTArYUtnbWxX?=
 =?utf-8?B?NzNFK2lCbUdlUUJvczBSRDRPUThHU0prc3BLenZxcmFNU2xqY3duUFZ2RUxk?=
 =?utf-8?B?UDVzdzZLclN6LytqYmpRdEptYkYxWUlQMml2aW1JclNPblhZcEFCc1JuYU5p?=
 =?utf-8?B?L0JnM2xxUW1CejRsdTJOdDYrQTdFUnhsVUdoVDA0L0wrWTgyUS9iTkFnZ3VH?=
 =?utf-8?B?dlcyclpQbFJydi9TamlvOGRLaTI2dy9CU3pLM2ZOdC9TN085ZEdSYlJZYXdt?=
 =?utf-8?B?Z1A0cVFkTHJBNUtsNTRLREpQaTlmZGc1c0dYOEppZ2ZWZk5DK1BFYjFzbFRB?=
 =?utf-8?B?TE95d25BZXc2SWpFQTEvOHhUUnRDaWhIY3hISXppblVrNzlOL2NPNDZLaFk2?=
 =?utf-8?B?S3AxVnY3KzM1WlVjd1Q3SGgxa1BNcm1XZFpyTGVmUkI0dzVzcDJpQ1BtZ01C?=
 =?utf-8?B?RUdFdC9qMW41eG9keDZtVjFVTnRnTGV0YTRmRCtUU1VOMWU4Y2pZVEwzZmNI?=
 =?utf-8?B?cnZwSGhUVjhrekpVTjh3ZjluZGVjV0ZrVm5URXYrejJMTmYxeDFrbDdpWWV5?=
 =?utf-8?B?YzAwWXJrSFM0R0s0UEhaaDE4RmJjbU1uQkpvVGdWa0N2Z1ZIdElrVUR0K2Zx?=
 =?utf-8?B?ZGpnL2hZdjNJQmcraEYvTDNJb2JkaXVkdEVsY1YrWjBzVnpmNk1Bck9lSjRa?=
 =?utf-8?B?WFhSNnpkSElvN2VzR2RRMVY3Y3hYVkJMN1RncXVBMTB4ZU4vWTdlaDRkT3BM?=
 =?utf-8?B?QnIzUXBHMDA0N0dQQjVUWUJYbmxaMEQ5L2NjZnV5U1NwMTAvbzZ3OWdVK3lt?=
 =?utf-8?B?WG94QytQQjgvQnIrRlJnM1cyQUVXN3pkUVF6TkJRVHd4ZHRQa0tYWDN3UXlN?=
 =?utf-8?B?K3FqMFhBYkNmOEV6dmdYVWNPOTR0SU56NEJucnZ3b3BBQjRBT1dzTU1kSW9u?=
 =?utf-8?B?MWhVMWdVQVZIRUtySS9FVm10R3RISlhnRXR2TTRUNnZsS09WZXpYK0loeVUy?=
 =?utf-8?B?NnVJOGVDTDlxb3B2cXlMM1JkbTFmMzNDVmVHM0hxSzRXTXdXVDJUcmZaNjhE?=
 =?utf-8?B?bmh5WWFWbUdJWWxnaSsxUnhqeEJ5ekxaQkdlMi9DWGZaSEc5dW5DUUdkcjdz?=
 =?utf-8?B?YUYwVWNVMDNYR1FrN3VUcTN0dE1YVmpEc0pIeXRIeW0zZGpRZjluOUJ4NGVS?=
 =?utf-8?B?NnVFYkVxRlFnTWprcTNtRjZJQ1lZY0pxUEpvTktreURvdU9ocC8rZWNXb1dY?=
 =?utf-8?B?TlJMRFZqbnRhcGlSK1g5RHMrQTh4d2VRS2pQYU8vblJnR3RkNzNyK0FqU00w?=
 =?utf-8?B?TDd3MndhUEp3M1VjNzkzS3E3ejdvdUpJdVAxdjZvMi9CTUlZNUpRNm0yS2xR?=
 =?utf-8?B?ejd6MGR4OVY2R1kvL25PZDFkQmlGMkZkR1poNXFKUVhqa0lZRlc4RGFhdUwx?=
 =?utf-8?B?aFdIZkc0YVo5SzdIc0RzTmNXSVdOTEZBSEY5M0YybVVyRU4zRHlhME96WXo3?=
 =?utf-8?Q?hN/CjhuviRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEx5UzJsQ1RjVHduYnZ5ZGxFcEd4ZloyQnQyaWhEWG5LWWsyWTMzWDExdUw2?=
 =?utf-8?B?OG03M2dCL252c2tZNEZwSDN5c1RkU2luNVZNcGNXbHpuWXdLYzNIZ0hOY0FP?=
 =?utf-8?B?VXgyL3VvQUNqZDhJdWhZNXZCRjdKcHRKWEk1Y1R5UTdMalJHNk5PaEkyajFj?=
 =?utf-8?B?MUZmbVBBNmRFcytZL3dyay9YYTArSVFHclJIYlJqMTFJN0VROUxpWlZqKzRs?=
 =?utf-8?B?eDlOUnphZ0FLdmg3UEJXZjd5c2orZGxEVDNUMGdlRkhUd3I4NXQvWm5Fb1lP?=
 =?utf-8?B?Q3JpcnRtd1BtQWR6cFpxL0V1dlcyS25QNnlXUWkzVHN1WGJRRDhNUTFudmMv?=
 =?utf-8?B?TEVZWGgxakQrbFlCRWdZYmlFY0dTaGdyRGVIWFJDNElwaUU0ZldwRml5VUh6?=
 =?utf-8?B?MGYveFZhaGRhcTBPYWt0TFdaM1VXRkF6T0FqVERWRkw5eS9KYStMTWlmTFFJ?=
 =?utf-8?B?aVhhVmtRaHgvMWtScjFmQXFLRExYTkZhNDkxWFRYMGd3M01ORTVDRGF1YXZj?=
 =?utf-8?B?RERidk5SMGt6TldFbmhCQ2w3aVRLdW1Gbno0aFIwOWIzV2htdk45d0tiOWVz?=
 =?utf-8?B?bGx4ZlhtM1dqdkFLWWc3WGVQT3FOZHc4OGloUC80MTEySGRkeVRvR05Wb3dP?=
 =?utf-8?B?Q1AvcXFYUzBHcXY2QUJ5MTZMWUFrNktxUUpGS0tJc0NHRDAzZmRBNDE0K1c4?=
 =?utf-8?B?K3Q5QW5MOXJNZGxFUjVsUUF4UjFFRHduNmFiOExvSURTbW5EOXBwTTl5VmxC?=
 =?utf-8?B?NGFPK0dGOExyRGlLK2x5ODZkS3JCOXljSVJqSyszUkg0S3BtbUhIWGZnOWw2?=
 =?utf-8?B?NWhnV3h6bW9xV3d6OWw1UGVrTCtHNGtrZmQ3YU5qTWE5ak1EY1pDZ3JlTkc1?=
 =?utf-8?B?TnRzVkhQTmRIK09tZk42L1FPbklnZUVLS01sMXlid2VpUytnNWZ4M09UUWhX?=
 =?utf-8?B?VElkbXMxTVdFaFZMcTdlRDdnUzl0RUZPL3dEbDdIc1pwUHUrdnVYeGVlUGxD?=
 =?utf-8?B?S3ppZEg4MW5vNGEwZXRubVlFbVQ2dW9ZMU95RWNsU0QybzlRZ3FzbHI3c3Mz?=
 =?utf-8?B?YitJMU1CbWo1UTZOejgwZnpSSHIveDBkZzMxR3IxZVBTVnZ4TnFYQ3JOcGtP?=
 =?utf-8?B?cVRhYjBiNlpyUUs0dUMySmllb2dDTjVXQnYxaStZVk84RFhyMjZFQTE4ek9U?=
 =?utf-8?B?bm10V0pnUTNiYzRJNWt3N1lTYlovMkJpQjZBaVVtSXVOWDR2bWZpeWJkWXBQ?=
 =?utf-8?B?ZVoxNmVlenlhbzVGdkZMaEVxSkpJUmwxK3BWaGZQRHJrdGsrSGh2TUxjUmJ5?=
 =?utf-8?B?b004Sm5ZbkRmYm5GSm1NZDQ0NXc3Ukh0encxbXQ1blRyNUYyT1ZWNDh1ZTJh?=
 =?utf-8?B?Si9qNk5VdzcvSnFDMUc5Rmlqa1duS2lVcjF0TFVYdG5aVWs4M3ZxZUh2RzNz?=
 =?utf-8?B?eHZzRjVjaW1JYmNTZVRManp6TW9KeHlQaFRqN0c1MVc2RlQ0QlNYZkdwRUVh?=
 =?utf-8?B?V0ROc25JWXYwWDRpVDUrWDZIbFJDaG92dHRFMHNBSFZLSVlvZ2Y1eXN2VVRD?=
 =?utf-8?B?cllVUUVhTFJYUEloaG1TSEVQZURGbUY3YktoOFBDc1VHMG56Mytmc0JyRDJn?=
 =?utf-8?B?bEVFWUMwRTIvN1VqaUNKQXlETDNxS1BUY1Y5djNBTHoxL3BuN0xDeWtVN1B4?=
 =?utf-8?B?YkZwL1BOMDgwU1M0YldRbHRqdTVBdFZlZVVMeTFReEJUbUVSK1B3bmgyZmZ6?=
 =?utf-8?B?SFhpTmtzbUx3TTRpYk9STi8rSzlZOFR4bmNzS1VEakF2SDVhRFFBTnVKeld1?=
 =?utf-8?B?aThwSlZKampJTE1aQ01ZdnBBZ2FodGJRRS8rOVlPd1hZcy9CakNBcFJqRjdS?=
 =?utf-8?B?WXRrSDVZUXFjMGZKT1d5WFRnbThLUnE3Zyt2dHdMREJPVEo2L3AzUmQvYXVy?=
 =?utf-8?B?NzA4N0JkRG9hY2doUHRLc0d5azBvUUwyNDhlN3cwazVOMXA1SlhGQWVLYy8z?=
 =?utf-8?B?bVNaOEJWdDBoMlJzeGlpK3l5YnVWZWFvSnJqMC9aTWtGenBpQmFBTm40MEtm?=
 =?utf-8?B?VWFhQVo1MSswMStWRElXRVVqbHNESG5lQUlFZnFWTlJ5cGZJS3ZqUWNTOURh?=
 =?utf-8?Q?73oiUZR2dnpox72gWo03vuWw6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d477a3-537c-4d6b-1a50-08dda34daf75
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:53:41.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUAyZvPT709c9fQvoOfcDcTzni/sCeHjszI9HwDu+B9n7aU7jWMPofJWfKEBZDrRUEg15p1pd+EWC/RTUFYH5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9581


On 04/06/2025 12:12, lijun wrote:
>  From c1129a053b33e6f85be3d7a26bf0dbb9bac64949 Mon Sep 17 00:00:00 2001
> From: Li Jun <lijun01@kylinos.cn>
> Date: Wed, 4 Jun 2025 16:45:10 +0800

seems like something is wrong with your mailer.

try using "git send-mail"


> Subject: [PATCH] infiniband: iser: remove the unnecessary var

IB/iser: remove unnecessary local variable


>
> In iscsi_iser_mtask_xmit, may return iser_send_control(conn, task)
> directly,so del 'error'.

The 'error' variable is no longer needed, as iscsi_iser_mtask_xmit can 
return the result of iser_send_control(conn, task) directly.


>
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>   drivers/infiniband/ulp/iser/iscsi_iser.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-
> )
>                                                    
>
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c
> b/drivers/infiniband/ulp/iser/iscsi_iser.c
> index a5be6f1ba12b..2e3c0516ce8f 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> @@ -267,19 +267,15 @@ static int iscsi_iser_task_init(struct iscsi_task
> *task)
>   static int iscsi_iser_mtask_xmit(struct iscsi_conn *conn,
>                   struct iscsi_task *task)
>   {
> -   int error = 0;
> -
>      iser_dbg("mtask xmit [cid %d itt 0x%x]\n", conn->id, task->itt);
>
> -   error = iser_send_control(conn, task);
> -
>      /* since iser xmits control with zero copy, tasks can not be
> recycled
>       * right after sending them.
>       * The recycling scheme is based on whether a response is expected
>       * - if yes, the task is recycled at iscsi_complete_pdu
>       * - if no,  the task is recycled at iser_snd_completion
>       */
> -   return error;
> +   return iser_send_control(conn, task);
>   }
>
>   static int iscsi_iser_task_xmit_unsol_data(struct iscsi_conn *conn,

change looks good to me, please fix the above in v2.

Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>


