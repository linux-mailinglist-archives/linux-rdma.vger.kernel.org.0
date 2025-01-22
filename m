Return-Path: <linux-rdma+bounces-7178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDEFA191B4
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 13:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D5A7A4968
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 12:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC19212B2B;
	Wed, 22 Jan 2025 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bxxhm1BY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92E192D7E;
	Wed, 22 Jan 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550148; cv=fail; b=AOd8kOXvXJpV/ozA6hVQB7NsdFpqdHE9PnBrWN2t6Ox0CB5X9pK4k0UEIcODudJU5ctVanuF5TJ8jwkYMtNikX+XJnxY2cL275pwU7LD/3qVj6b2UlMt96+jfhvvRocpG6ywhtd4epcci427O3Bjtro5pFIG+/6tXkLu/jh01B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550148; c=relaxed/simple;
	bh=7Iel27OiizBEKkGJkAGCiZr9uzgIDwHi1yK/1fhsDC0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bF/arh6MSc1+UhPgo1oQZ46j4xpvyzMewb4gK0JxRCrIaxLKGtsWme7Vp8WNjDYaSpA4xYazJtArxL6S5u72yMWWXcpsCBt8laRNQQ17D6y2R//BXpJ2eTbRkl7Pst5FyRxlZ6v8M0roaAVHlP/8m+Z1naIt0OegBTUHVCMkibk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bxxhm1BY; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRyxmbvc+eAySKVg75zd5pS9TR6l6G5waI6SEqj3Jw0GCgd7ZWv0u0dFu5N43O/rnsDw2onJmDLet0aHyPwjWS8K1Z4IojsVHKchw9gel/w2ORG0FcAnM0C9VHBcMvyjNtykZua0ocBP4taLKYXRBEUBZzc99rwmkeZVpTAAbzhgCVUof+6avICeVbs7zEZGKM7PCcejppjgt6Xk2DZaVTk3CSbqnk6HED0GZYMV/PGZCBmEq6YsvrbQIY5eIEzNvc+ryATOFRQDFcvY89SAesQuO0ruFqrcuYYrWlCtQc5x0ffZkSV24E/Zi0eOHs6pDAvmUZ8GneAR9J0xPVO0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro7iv0w0bRsPS/L+yyL8zpHCQOHwgm03u6VBu91KLNw=;
 b=k6eDKLGw8JipHCz3E0JARFQPsXUrr3xzinXf7Rp8//m5eB4D4nGjjRL+v02LYeCrVjEBTIRH6rTyPYDUQqrzoS2swW/Pya44szObXUv84hcZMWLYTVCpytLztSmti6dnfSrDKPc6SFg0BA17aJRF1kSl5MoNtR1q6Be0KMCX5ccH1ywktvtFF8hWU0FMrmEtjWvdaINGg9T6lsnekZFSOkQHKzMzft9u5kK/Bjo8FeCSK1Uki1x6xup9ctuGoaOXTwkpjzvQUG5zhkz2ZXMyV1WNf6GHXjttuCHUFagNC0zgA4ruPHRyrCl8C6wuzc4cSAOQRZiDLPXjeLAhK23+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro7iv0w0bRsPS/L+yyL8zpHCQOHwgm03u6VBu91KLNw=;
 b=bxxhm1BY31482h/m+i0OTHchptBI+wc711YseX84v84gcdsbX0/VDoLiQSi0J9oARpjion/4l9fxcFoCJbuZrMuFDK/IZ+GkBvICxpQy8NXWFUZqaRuc15zQ6/IRxsDzXl4UhXmPy8GpVMpMN3jm363aAAsuoWvPVKhSVmyhhn+Siw8ZF3h+gt0gZMqi9x5ynjb/eYDYyJliS+dw/Wnp8PKp650m4uRvOFPmcfyqzt8RI6ygAcS/PfA0UhJU8emNkgdkENZqoxQqfyqFHAhDjhAbjGJxOtE0GuomxGVanStpxEALFbeqYYDiWIFry6Ajkeaxedj1ovok2MB/UdFTBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 12:49:04 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 12:49:04 +0000
Message-ID: <8dbc731c-2cff-4995-b579-badfc32584a1@nvidia.com>
Date: Wed, 22 Jan 2025 14:48:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
From: Carolina Jubran <cjubran@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
 <20241204220931.254964-8-tariqt@nvidia.com>
 <20241206181056.3d323c0e@kernel.org>
 <89652b98-65a8-4a97-a2e2-6c36acf7c663@gmail.com>
 <20241209132734.2039dead@kernel.org>
 <1e886aaf-e1eb-4f1a-b7ef-f63b350a3320@nvidia.com>
 <20250120101447.1711b641@kernel.org>
 <a76be788-a0ae-456a-9450-686e03209e84@nvidia.com>
Content-Language: en-US
In-Reply-To: <a76be788-a0ae-456a-9450-686e03209e84@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::9) To SN7PR12MB7129.namprd12.prod.outlook.com
 (2603:10b6:806:2a1::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 96554904-f783-43c5-f404-08dd3ae32654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzU3ZExpOGczVzhrcFZRdnA2dzAxbUVhdklrTDV2NFJvcFdNTGtVSlpNU3Bs?=
 =?utf-8?B?bldJcjY1TjYxWEVNbmxaK04wcktyT3JHbWZaNkFhSmNFMzBVQUF5OGFNVXhh?=
 =?utf-8?B?akZvRGU3MklnQlRycDFaR3FxNlVZUlF0MGZNKzFwN3BlNE9Zdjl3dVpQM0NF?=
 =?utf-8?B?M002WkJvWnhpQ1QrUU9KWnVJb09LL1JLWnlvSGtNdWNkREg0SWVKbUc0cG8v?=
 =?utf-8?B?elVKUUF3eHZkeGU2R0VkSkpwMzc4VFhLMTZWU2pWNUZhdkY1a2taZ0ZYUDda?=
 =?utf-8?B?RUF6R25hbm5CbzFtOWZRVFJaUkdSR0JJMzVFWWNOenRqZEF0MVhsODVUK2hx?=
 =?utf-8?B?VzgxZUNJYnA5SVpOUXhMODd6MGhVTHlPN1FDNFE0YWwwZUt6aC9KNVdUQ1NL?=
 =?utf-8?B?SmhPemNFQVdUclVlelRhTXlqYVB0c3RUMktyN3BpZHZCWHhwZlozME1peDRi?=
 =?utf-8?B?akRicERmbzlKYTVGOUlPQURsVEZ4akZmaU16VkREUlB4NHhML1MxUFdmY1k4?=
 =?utf-8?B?RGZleDlOT1BmVFNEZk1pRm5ndjRhTGRySzVnSmhVaENrek00VXBnSXNHd3RC?=
 =?utf-8?B?cVhlUVJ4V3NHT25ZSjF6REdRTGp6YmI3aGdrNWNUek9DYWczU1MxUVVFOE9t?=
 =?utf-8?B?SUdUd0JieXpoZXE3d1FibGV0ZUhNN29NOUZDYzZyVmJtU0pRQm9COEl5TXR1?=
 =?utf-8?B?eFRlQVlGbkNpZHBLMFFPeTBuRENpdHdSMFJuMCtSM1ZYMGVYeE5oRGx3THNS?=
 =?utf-8?B?Tkhsd2VwSlBUdEFVSGZxNTR1QjRqT3dXNmtsMFdjUEMvd25jNXpla3c5Y3pw?=
 =?utf-8?B?TGxpa3ptOGYxTFZtTGZEVWJsMjROdXhGU0x1bFQ0RUpOL3djZWljSGFiK0xt?=
 =?utf-8?B?aTJFa0tEc3EwejAzeDRkaXBzait1MHBobHhRdFgwVHlITDVCbzl6eHZNQnpx?=
 =?utf-8?B?MDgydVlUMnFHV3JuMzhXWDhBWHo1OG04K0ZnWGRsSC8rQ29zZCtndC9WZG9n?=
 =?utf-8?B?SFZ3dVNPZEF6aWlhL1ZmSlhpcjJnNksxZDRqclBEa1hZV2xFdmhYUk95T1U0?=
 =?utf-8?B?aUdSNjNWcFhWRXVENFBodzVUdlRoZGhybHk4S3h4bVRzNEd3ak03VHFBVWps?=
 =?utf-8?B?ZlhVZEo5bC9kRC9kaWUyNkdQUHkwbTJyNUloTmlzRWh0MmVmTFM3cTcyM3pn?=
 =?utf-8?B?d3Zrb3pXUEVGSG9JcWlhY0VzSVc0Tkx3bnBEZ3EyMTY2ZVdBRnNtWGVFbEJG?=
 =?utf-8?B?bG1XMWl2WE5uK0pKSS92S2lVUXphWi9iVkRIaEN1dDNvVVFwUnRGNEZFNzVV?=
 =?utf-8?B?UzJ5ZHpQbWVBb1Ira3Z3MnltcUpMMkNUY05DL04wWkNaSXhqNkZ5b0hZaElB?=
 =?utf-8?B?L1VrTk5PTzB4Zk85TkJLZXNDejhvUldlV1hESEo2Z290WDF0QjhPd2FTNjRM?=
 =?utf-8?B?K2dMNlJtL3pLRjhGSEFVMDJ4VldYdlVYc2dFclR0RDdWMUZTU3hUdmNuOHRB?=
 =?utf-8?B?c0RQVmtDSHRaYUFnWmdaam5kNjlPU3NhaURJeEp2L0ZRWUlPb2oxVjRwUVZa?=
 =?utf-8?B?dllSL2oxZ0xXKzZlUVJGTUFDaG5idk10NDZnSmZoOU5HZ21wbkRqbnQvYmFm?=
 =?utf-8?B?ZEkyb0N1a2tkT2hsbmZkamYrb1RpNG9salBLUW1JdlkwZy9lWFRYN2lORGNT?=
 =?utf-8?B?SWRvaGI3MVdvdzc0WXNadEFwT0l2V3ZXZ0pwUFJBNUhmbjdTdXpXdHhaMlZS?=
 =?utf-8?B?MHZJVmV2cFl6MGZINktFcXp4R1hVM0FIelpnTlJSaEw2blpNUWpCSW9QM0Fh?=
 =?utf-8?B?UGVpZkZMNnltMms5RzQ0cWg3Lzd5Y2diQURtWWkySkZxYVZCTHpBMFB5bjRN?=
 =?utf-8?Q?1haoduGdc9fpT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1ZOb24zQng1UHNQblgzTVZuRVNuMi8rc1lVWkNLb0UzUENqSGM0YmVoTmhp?=
 =?utf-8?B?UVpCeEFDUHNEellZSXlZQ3M2bWJYRWJZKysxaXNiQXpERWdZdFM4QXN4T0hX?=
 =?utf-8?B?MmFmUmhPdm5uYjZFMTBFNHBZVUNMVUpBdlB1c2JMQUdqYWdJTUJmWlFROGR5?=
 =?utf-8?B?bnVPV3dFcjRMWWt1eDgrTGc4UHo5V1VEdTk4OGI0M1BlVGNnRzBYLzk5TUli?=
 =?utf-8?B?QjVMYldSWHoveUxHUVlLY2xqYTRQaGpxcFRoY2lrMjVkb2NCczJqcE5lbVJZ?=
 =?utf-8?B?RzdtWFhYcmtjU2xvRndVY3oySjBFVU5PT29QaHdLb0JZL2pEL3BITG1odk9H?=
 =?utf-8?B?M29ZR1dDRU4vTEV2RTZJekRiWlFQMDlMWVNhdGZlTTFlRnl1TUtNekE5c0kz?=
 =?utf-8?B?RjlVaXNaSi9QNmlkQSs0cklnODlzK0VjVjdiVWtISlFYdDNNWFlINGtvZzQw?=
 =?utf-8?B?UWRIRVB2SDdjeHgyN0w4SlN5cU10ejh6TlFZT2tCUG0xdUZFQnVPV3Q5R29O?=
 =?utf-8?B?bks5VDFxSjdTWGhVZ3hsL243MTNSd1l0cWJmOXUwdFJqVklxVEhXWEtGUEcr?=
 =?utf-8?B?MCtmdFF0RTJ3UjM1UVZtNmFvK21OM0FWeDZuaDdUYzM3WGZ0cVhEcjJaekcy?=
 =?utf-8?B?SUlpc0N2dTZ4Z3F5dkR5MzIzWjQvay9ZOVdqSFZPb1YyWnRlSW50TXBCelRv?=
 =?utf-8?B?VFhvZGlIYzdrM2JPWHUxNVgxWG1laXBsZExRVzBtZFNmVmw5aUwxL2t1NDJ0?=
 =?utf-8?B?aFNSN292WUh3UUNhenRFT2hlRGdDMTJYL0pJbGtoSnpNTVlubVdZQTBnTjJk?=
 =?utf-8?B?cFNvSVlCRGtEL3hxZnVnN1k3YzhCMUxzSXhUL2N2ZDZQOGw2WmxGMGJWY1Bv?=
 =?utf-8?B?aWNOcUhQSVdmWHQ4R0p5cFpaRlpKYmNMZ2F6eHlES1d6UDlYMURITi9vM0pv?=
 =?utf-8?B?RUxqQ2NYWHU3c0Z1cGhDa05lV0J1S3dVZG5NbTdlRGhGci81RzdvS2F6U2Vy?=
 =?utf-8?B?ZCtzL2FkUEsxQVUvZ0Z6ZWNNZXBKbXZqSmRJOEJrQXdpQTNsNTZNeXFRb0tV?=
 =?utf-8?B?anNYNGY3Y2IxSFR2TDRJdU1ubjJKcnZaeGZQVnhTZ0pMbWRSdGppOUFtTStx?=
 =?utf-8?B?aVdiYXVObDhGZEFVWFI1UWE3YTcvNXZvUEUreE9aVHI5aTZBdnlwZER1Q2N0?=
 =?utf-8?B?Nzk4WVBmNk5TdzdabFl6SDhBdklkalBLcGYrdkhuOTZEbElEUEFFV3JNeEVj?=
 =?utf-8?B?dTczOVNJNFZmTGltUzFldjg5dnU2NXVEWk51THJqenpLV1V5M1VUSGMyT2sy?=
 =?utf-8?B?cjVSU09FRDU0OEg1UzVZd1JOOWM2MXdZd1lSbnZMQ1RraWhsTldJWnBQYUo2?=
 =?utf-8?B?d1YzZ04zRnlsbnhzUjVmWHlSWllheDlobmJKVHdZSG9mOE01eEFsNjJuZVZx?=
 =?utf-8?B?QWcxZUpKbVJ3bkF5TUZHSnp6VlZ0bUtuK3pQS0xKc2NqbCtsK0NGZEFWWWF6?=
 =?utf-8?B?blBzSGhkUVVmc0RRM0tpRHhLdW5xajYvREFiWSszdE9LUEIvRlZ3K0F0VExi?=
 =?utf-8?B?L1gwMlJYV0dESXg4bUx6SUhZbXRxMStHMW9jS2pmTStnb0w1ay9qUzlvTFRC?=
 =?utf-8?B?VTg1ekw4T2FEMVcxbUJSenNETGhuOVQ2dTd0WHJ3ajNVb29BRVpNL2VHQmd2?=
 =?utf-8?B?Y09STnd5eWV6MEVFUkUyckcya1d6YTNjdjM4aFUxRnpEVFIrbGxBZFVsbkpt?=
 =?utf-8?B?aENCSW40eWk2Z3c5UWtBV2l2T2RUK21SbmhHUnF4SVZLd0NtODYvZWNiNTd6?=
 =?utf-8?B?aW1xblZGWkVwNVh5NUxOREw0bFpkSENDRzhUWXozV3l0NVJ6bExSNnZ1eUF3?=
 =?utf-8?B?b3BwUFZ1aTZybzRhcU5tenN6MXpGcmh4dDFaMEZzbHorQXdCY0Zma3lOcExW?=
 =?utf-8?B?SzhKcE5EMWRITHl0V3NPZ3JDM3REclNuNkdXRUVXeWhIQ1FXa252akc3cUtr?=
 =?utf-8?B?blFXbEdXb2swVVFBbk5Pc2p5TFFGdGI3em51U0h1MERxcWJITEVSd0hIdkp3?=
 =?utf-8?B?VVN2elhvRHVmN3BLVjdOTE85bVpSZCtjZ20yNVIyR09VczdzYS9oRDNDY0lt?=
 =?utf-8?Q?EZJaQGMNKWAnBfKNayaNXpK9C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96554904-f783-43c5-f404-08dd3ae32654
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 12:49:04.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcsElyHhjOQHMytWIY49SRXWRn99l1cok290AmtKE15d94ZQG16aQ4E3HxDOh2mJJM7WS7+FjVtOJ93wDETEaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650



On 21/01/2025 14:36, Carolina Jubran wrote:
> 
> 
> On 20/01/2025 20:14, Jakub Kicinski wrote:
>> On Mon, 20 Jan 2025 13:55:58 +0200 Carolina Jubran wrote:
>>> On 09/12/2024 23:27, Jakub Kicinski wrote:
>>>> On Mon, 9 Dec 2024 23:03:04 +0200 Tariq Toukan wrote:
>>>>> If we enforce by policy we need to use the constant 7, not the macro
>>>>> IEEE_8021QAZ_MAX_TCS-1.
>>>>> I'll keep it.
>>>>
>>>> The spec should support using "foreign constants"
>>>> Off the top of my head - you can define the ieee-8021qaz-max-tcs 
>>>> contant
>>>> as if you were defining a devlink constant, then add a header:
>>>> attribute. This will tell C codegen to include that header instead of
>>>> generating the definition.
>>>
>>> Hi Jakub,
>>>
>>> I tried implementing this as you suggested, but it seems that the only
>>> supported definition types are ['const', 'enum', 'flags', 'struct'],
>>> while the max value in checks only accepts patterns matching
>>> ^[su](8|16|32|64)-(min|max)$.
>>>
>>>   From what I see, it doesn’t currently support using a const value for
>>> the max or min checks. Let me know if I’m missing something or if
>>> there’s an alternative way to achieve this.
>>
>> Ah, I thought we already implemented this, sorry.
>> Can you try the two patches from the top of this branch?
>>
>> https://github.com/kuba-moo/linux/tree/ynl-limits
> 
> Yes, it worked after applying the pattern changes to the
> genetlink-legacy.yaml , as devlink uses it.
> 
> Thank you!
> 
> Carolina
> 

Since this worked and the devlink patch now depends on it, would it be 
possible to include the top two patches
https://github.com/kuba-moo/linux/tree/ynl-limits in the next submission 
of the devlink and mlx5 patches?

Thanks!
Carolina

