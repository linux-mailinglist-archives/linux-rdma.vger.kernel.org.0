Return-Path: <linux-rdma+bounces-5917-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F989C3958
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2024 09:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16761F22133
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2024 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A77315099D;
	Mon, 11 Nov 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b7CBKf5y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE520B22;
	Mon, 11 Nov 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312111; cv=fail; b=qOMETFVnhJVWql556nkdkKS1PvmocfcIEaTwk7StnYpVZNLTxuEqYtVx6PMlIBhiVXYMQ7QCCdJq+1SvBcxnI251niu2RcXp6V8YNYmoT14CP/eqH6i1XKjDfXwxads3GCQ4SWutZQVDy/FAT7fveJ4/ujf5jzPvNjScgLRJmwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312111; c=relaxed/simple;
	bh=07vR1p9yMLdRP37g2LpLqdAlDCtVrpB1g6i82Ex7osY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L6thgatphzW51cI+j1fUoRhT6437H21NYm16nstpIMtaAo2h2NZlGFgFL1qGTK/EaAEIsU2s9vDwJc5YBXYeUGZVrAraCVzPpr+Bz2XN0SvqJyNIgU19lP3AIGL2SwuV9OmPBZJRGiFM0J7+qU8vSpSuULOP6UsOQux8xQNqapY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b7CBKf5y; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxBe2AUbayOs4fxxTc0++7WFfd8VoSKZDW6/AqYN5rs2k/IbRFoP+fxCryrhtnlPy1AOydnDgDH439tHQDkSrcUlZc2ZjbJbO7ovGhXcWnBpb3caS7mhyU1juQmra3yn/beZmiSmzEhXvzyFFqkj4suLyWtQNXv6LMlA39ldhpXKCVp6zIGu6DqK5EvHqeOndfZ3goob0bhv2VaHL4rARZXoMkgRsoAKCEXFBRlXexwpAn8kCK1YlK8GzQj3iwtYFMDW/O8zdi9HV2zZJB6ZctV3ZuZW0d1jANZiYivn2BmakFp571ai+/oe92FQe5iqW1gnNv03lRsFmQZ1aSE8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0nvGWlmhg8ZPcJTbQm3qjoYm9Lm86lpPoBh1tlOQi4=;
 b=CdkqsoPEgzS/+P7SeL588M3OMaNzadYxb5YQoFqX6HnySOyhe6vbDL93HsGCuo2Wjss3i/W8/A/yfRGBUY1jC7IizBSODT8Z+UXSuaZg957WPjjff3Hg4T95912servczs6CId9tYkLYYWz3YX6DJZRG7P746ymYCfJZPQxsAKOnFHEkKnJ1k6l/28G/5vEIHtI7H7YKpTq21gmtfFekG9Y/po7OZtCG2sLGZJYJAUXl3rUH+6nq3/zn9nrRn1TGKt57nxN1jXGiO8+vPYzGbGhsG7bHXlz5Oip2ipXeboiwqOk9Xz5LBlWYYC0hdicKyqzHHC8XFT4FswHIk+d6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0nvGWlmhg8ZPcJTbQm3qjoYm9Lm86lpPoBh1tlOQi4=;
 b=b7CBKf5yyjdeDMRy2C5BISB4lG+3zqBIQyAx3j/MG2yhh0ztpIHQ8NNUzJl3RpwtXtPCMmqpzRWLPX89ZbbzwdXvIXkv45dszdydc/4sVp2ux8uDXvYSNZckHQi1CH8YRUGSEX0oEaNRXwZF6Ev5g0yjLPvs1kb+h0Sp26El7hc0ktm64Cto4tgTN+wdT5Bo6AMI+2I2bozlkxpjQtfe8nbMWC3hciTUqeKkvYWSl3kfxSf1qUb+WC5FUMr6LvfzZOk+jYL4nvDD9764cONmWqnEqkS+YW43U3HSP4il9cFQzxEtA4imQVZlxLwFeVKNBYp5/DOKdQ3iNjedMHNPvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 08:01:46 +0000
Received: from SA1PR12MB8858.namprd12.prod.outlook.com
 ([fe80::3a95:d815:e0c0:f62f]) by SA1PR12MB8858.namprd12.prod.outlook.com
 ([fe80::3a95:d815:e0c0:f62f%5]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 08:01:46 +0000
Message-ID: <f4eb75be-fefc-4a8d-96af-ea99472a54cf@nvidia.com>
Date: Mon, 11 Nov 2024 10:01:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2-next 1/5] rdma: Add support for rdma monitor
To: David Ahern <dsahern@gmail.com>, Chiara Meiohas <cmeioahs@nvidia.com>,
 leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com,
 stephen@networkplumber.org, Mark Bloch <mbloch@nvidia.com>
References: <20241107080248.2028680-1-cmeioahs@nvidia.com>
 <20241107080248.2028680-2-cmeioahs@nvidia.com>
 <d40cc960-f12e-4177-83d5-b573de41ed4c@gmail.com>
Content-Language: en-US
From: Chiara Meiohas <cmeiohas@nvidia.com>
In-Reply-To: <d40cc960-f12e-4177-83d5-b573de41ed4c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To SA1PR12MB8858.namprd12.prod.outlook.com
 (2603:10b6:806:385::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8858:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0a2444-a09a-48fa-0e00-08dd02271655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWdPRGF0SmlsMVZXU3o5U2pDcGtDeVZYLytVWkhGQ21yWGIxWGhEdU82RFAx?=
 =?utf-8?B?b2ZCQXBHeDd4NWpWMUxmcVd2OGlacFVyU0xTaWsyTXFiSG1GYzZiWkI0cmJI?=
 =?utf-8?B?LzZBTm5hK1ZwRG8vWjV5TDhsL1Eza0pBaDUrT1FCdXYzdXhMZjlDaTcweFI0?=
 =?utf-8?B?VTY1bWttY3JpSnJGYldsdWpEdkZ4RkhrN284YlU1VlkxOVRoQUFKMmt1QXZW?=
 =?utf-8?B?UGxsNUxPa080Ullib0FIUU4xcDJNRURvaVNyc3YxYUtraUozUmtLYU1tczJK?=
 =?utf-8?B?ZWNRZVV6WDFlbjE1bXdVTnN6R2FXRzZHelZrY01VdVkyUzMrZm1VUTN2VXlP?=
 =?utf-8?B?ek1mNGFZWXJnVnhHSVBDSm1MVlpScDhSS1VBMklpUTloTTNqYi9nazUyaU42?=
 =?utf-8?B?bWwvVlJwR3lUSUdXYWFPSmx6WmVGMkpOU3Q4VFhHTkkwM2pNNWEyZitzbjhr?=
 =?utf-8?B?UmpnbUIxTXFBbW12TVF0R1VQczMxeDFuc2hvKy9uL0t6TUxIM3RnMjBvamtG?=
 =?utf-8?B?SThJNzdFMnhBVEtmUVpVNHZ5ajZ1QUZqdWVPY0s1TDBDbW1uWUZrTjNobXhS?=
 =?utf-8?B?bVVuNEN2K2dySGJrM2dQa0dmODFydCtGai9lVGVlRmlOMDJScTVqRzhMVFk3?=
 =?utf-8?B?RzJWUUFVK0JjbmpuSGVPU0RUSUlJa3o4MlZmMzdpMDkva3hJN0tMYk1scVRw?=
 =?utf-8?B?M1M2NXh2N0xFdGJGdndWUEJVSmFHZyt2azA3c3lFUXhHTzVSMjl2MEl0OFV0?=
 =?utf-8?B?K3pHT2N1VUlnSVphd3c4WDRBbm5ITHg3RFNvTGpWeUh6NTVxTDBKZlVGWjNv?=
 =?utf-8?B?bUJ1UEFrcjh0OGdmMVA1UktvKzNCeGRLNUtIYUdXNGM2OW1mRmF1SVB1bzJP?=
 =?utf-8?B?Q0pBbGxSM2RadnBrT096UGQ5VlB5dnhYWnJ2VUNzMnJJK0xlTXkrYjlHQkFP?=
 =?utf-8?B?dHpBb3hwTWQ5N2UwazVJaVdtY3pJNXRKWUpxT0pyTWFtZ3FyUnlTVjNqVk5P?=
 =?utf-8?B?amZBTjRadE0yMVI5ZEpQaG5hSnRzZ3BUSzNtSHAxeDkrMHVKYzZNNzNXaHFW?=
 =?utf-8?B?NlhUQmt0cDc2MDRDUjNOems1NWNXVjY2dTlQWjA1OVR6Qml0T1JrZTRSRjVP?=
 =?utf-8?B?NmV0Q0JOZWdyL00xNmdOOStJWVdCa3lYbkUyR0c3QkFVVDJpUk5Xanc0dWRC?=
 =?utf-8?B?Y1ZGaHBFZVV3OHpVd21xWC9lVVo2aEdYV3FKeURhb0tsSXNvSWF6TitSQWVi?=
 =?utf-8?B?YjFNZzlTRmQzdHJCa2MzNFpaV254b2lNZ3BJZHBaVUVKanQ1T0E2cXgyMzYz?=
 =?utf-8?B?VTc3Y2ZFUWFvVlBsVS9CMnRzZjB4QnJsSDNVMzhwUmJWZFNKR3lrRzBmUU5z?=
 =?utf-8?B?U0hINm05RUNKZ3ZJdXJ4Ujh0TjFja0VvU0ZDMUJmbk1FV1VURFowMndsVC9s?=
 =?utf-8?B?d1Zyd052Rkxab1IrYjZJR2lkeDZRNysxTDlMWmFxdEVnZGVlVHhEMFBhR25E?=
 =?utf-8?B?SWgxZTd1SGhXdTc3dTZJKzYrTGxYUlYvVkFxQWdwaTc0T2l6a25HTWhJRTAw?=
 =?utf-8?B?blB2YmR2bTZtYmJIS1F1L0FHcHlIelpWS3JudVpxRXBndW05cUwzcWMydmZU?=
 =?utf-8?B?WjI1a0d1NzROQ3hKSldzVkQ3UVhqYURUL3pDRzQwVmV3NjNlQXgvWDcyRjNY?=
 =?utf-8?B?R2dNMWtTb3M3U3RES0c4RXBYNEx2dUhldmt4OUhMQXJ2Mmo1anZjZDZmRjVX?=
 =?utf-8?Q?olqlywEQhQGlWDHJhQdnGSW3uSqjYu5dQAA0EHo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjcwYktrUDdKUWF3V2E5VGFoMmNhMTRwVDFjaFkyMlkvazBCbjZoZGl5cSsy?=
 =?utf-8?B?ZEZoR2RyMC9ObU5zSG15OENIWXRhZlQzVmQrQ21ycHQweHJ4ZTNrVzgxUWY0?=
 =?utf-8?B?MTh5dm40cTVDd1lyMlZBS1Q1cHgzSzh5amNvWDZRR3JHRGlBZ1ZWTkNvR2l1?=
 =?utf-8?B?bStMdFd5MUYvNW5KUlorT1EyT3VnY2JGM3VwMUsyVEZWQWNVNmFkNVlneXI3?=
 =?utf-8?B?dWMxd3R4aUtjemJ5bWJpZWhqYSs4V3pYMFd0WlJaWFNVRXFaTDcvNG9Nbmwv?=
 =?utf-8?B?Qlg1Y29TRjNQOGdVVXAwU1E4c21aUWZ1aURHbnFEdDZDYko1dmcvWWxVeFRk?=
 =?utf-8?B?NHE1Snpwa0RiUUdSdVQrZTJMbFU2R21QWksyQ01mWUkzb2ozUGRLeWhYNC9x?=
 =?utf-8?B?S1d4RWNtMTIrRElZWHF1M2tZSUVaMDY1L0EzTVlKcVArSzF3R1kyem1kMFd5?=
 =?utf-8?B?MUJ1TE9uak1JcVBheXltTms4VlhadDFvcnJGYXJTemFwNXhwZDFUNDV5Ynd4?=
 =?utf-8?B?SzY4M1NUSEFqTHozZlhhdkhzZmJ2aFlJL2ViNExybUN5WkxaUWgwbFMrSzhm?=
 =?utf-8?B?RXc3cjNBQWxaN0ZaWmErbmxYQk9QdzRlcnM3Q0Z1ejcxcUhnUndTa25vZGdr?=
 =?utf-8?B?cTJsc0tmQ2REUmtVL2pTbW1tbUhMWTV1enN3OHVGRmU0QVYxUE5rcDFSWS96?=
 =?utf-8?B?VVJOQW5ocVJ6SVFzc1pvbXdOeTRiM3BSelhkbUtqZTVlWE8zM2dGMEJlT3dI?=
 =?utf-8?B?MHlla0NTN3ZFUlNuQzFtVGZxTXMrMUZHOXpxK0VHSWNnNzNYeTI5Nm8veVlW?=
 =?utf-8?B?eGZHM3U4YXFFdWZKRXBCM1NsbWNycjFpWjVJK0xuT1djTEwzNXVndjV6NlM0?=
 =?utf-8?B?My93Vi9DQ1NOckRoOVFOeityTU5rb0prSnlxVUh3eTRiUGhrMnkwY1JjZDVz?=
 =?utf-8?B?SHdKVTBRUC9GVWlqTDlYLzhWSThvKzRqVm8rOENsQnBlR09kRnpNRHRyM1Yx?=
 =?utf-8?B?RzNXU053RVdXOHpXaVprT3RCNEh0RG5NSVhib1lzNGFTY2RrVHdUTmpkUTNJ?=
 =?utf-8?B?aVc4MGVhQzdkSDFzVEx2cXhPalp6NzAwZkY4aHd2K1hNNWgrM3ZRcDk4ek1H?=
 =?utf-8?B?ZmhKTTNWMFF3UFZFSGl6SG5HMXhZTjloSldzZysza1c4eUJlTUYwVnN3WFZ3?=
 =?utf-8?B?aDNFQW5CNU9OOE11Yzl1UktXNTFla3lKRStteGRtVk1JVm43WExQVmxKaDBh?=
 =?utf-8?B?Q0dLV0xmZkxWK2Jqc0thOFhiQ0V0dXhVeVlwMC8za0VkVjJWSmdzODhIUXN0?=
 =?utf-8?B?dzlycUUvQnFyY05PK01mc0xmeXZ3RnBLRWdpUG9DbmxaK0lFL0VDTzNFKzVB?=
 =?utf-8?B?dGlQbjg1dURIejdLNkRsNG51R0hwOXNjdUx3K2t1QzdxeGtIV1hyR3hNNjFM?=
 =?utf-8?B?UHgvbFEvUzZ3M1kzRytxYUUwMEpRUjRqcFJSRlVORkxXUTA5TDFWRjNtNnJm?=
 =?utf-8?B?OVNUQWtKVUs0QjJzVkF4TXpUM1ZzSEJYV3dBb2RFMndGRFA0WlBaMDlXY0Vw?=
 =?utf-8?B?WFhXRitxa2tPSkF4NW9raTNYcEtjZW5YOGRtcy94WGV6T0pIbGo1WkVsc1Fk?=
 =?utf-8?B?Q1IxaE1Fbjhzek50U2luZVVSVGQrNkVPdCtkbmJkVldOKzQxQ1JRY3RTWDdI?=
 =?utf-8?B?Z25QVEpRdVRuQjJVcWE3Z1ZTM3dHUXdtbDBuNU9CU3NPUFNJTGgveWJ3VU15?=
 =?utf-8?B?YkxBUnJKVDFONU16Y0kvREt6YnlTeWtNNzR2U1UyUkJydjN5WVE4aG9WQVUx?=
 =?utf-8?B?Yjhld0RrQW9iWXk5a0IwaG5JdU02MEdBWkdLdFVVdzl1WGllRmlpNEFXYnN0?=
 =?utf-8?B?VEFFeHBoanBlV1VBQi9ZM2lySnh4My9WUEF2SHVwdTNvRW9NQXFjS3E4UlNE?=
 =?utf-8?B?enRhRlFEcjJlVkkwY3QwZndGUE82ZGY2bFBVZ0ZBTkNwa2tHMEJVZ2NlQzFJ?=
 =?utf-8?B?UDZBVE5XeDVibGszSkVIK2hkVkVsTmllbkV3ejR3ZU5BSkZYZlVwbThRYmRs?=
 =?utf-8?B?ZCszTGVmTzZ5RzJLQkF2THNETS9xV1dvblIyUjJiTFFEUFpSRlB3OTUyK2RI?=
 =?utf-8?Q?cQ9fyOk9CGX20giWGPRtKpOyc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0a2444-a09a-48fa-0e00-08dd02271655
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 08:01:46.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KP4kQq8vtgaLKnyFPR8iO8kIheIJTEXFTTZo0/tUEIhHtQe5NKlejfoy0+iQGzA5414AldVqjPooEJvhq0HSQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315

On 09/11/2024 19:34, David Ahern wrote:

> On 11/7/24 1:02 AM, Chiara Meiohas wrote:
>> diff --git a/rdma/monitor.c b/rdma/monitor.c
>> new file mode 100644
>> index 00000000..0a2d3053
>> --- /dev/null
>> +++ b/rdma/monitor.c
>> @@ -0,0 +1,169 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +/*
>> + * monitor.c	RDMA tool
>> + * Authors:     Chiara Meiohas <cmeiohas@nvidia.com>
>> + */
>> +
>> +#include "rdma.h"
>> +
>> +/* Global utils flags */
>> +extern int json;
> use include utils.h instead
>
>> +
>> +static void mon_print_event_type(struct nlattr **tb)
>> +{
>> +	static const char *const event_types_str[] = {
>> +		"[REGISTER]",
>> +		"[UNREGISTER]",
>> +		"[NETDEV_ATTACH]",
>> +		"[NETDEV_DETACH]",
>> +	};
>> +	enum rdma_nl_notify_event_type etype;
>> +	static char unknown_type[32];
> why static?
>
>> +
>> +	if (!tb[RDMA_NLDEV_ATTR_EVENT_TYPE])
>> +		return;
>> +
>> +	etype = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_EVENT_TYPE]);
>> +	if (etype < ARRAY_SIZE(event_types_str)) {
>> +		print_string(PRINT_ANY, "event_type", "%s\t",
>> +			     event_types_str[etype]);
>> +	} else {
>> +		snprintf(unknown_type, sizeof(unknown_type), "[UNKNOWN 0x%02x]", etype);
> wrap at about 80 columns; in this case etype should go on the next line

I'll prepare the v3 patch with these changes.

Additionally, in the case where rdma monitor is not supported (rdma sys returns
"monitor off"), it will return an error instead of looping.

Thanks,
Chiara

