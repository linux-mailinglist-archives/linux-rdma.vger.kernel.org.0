Return-Path: <linux-rdma+bounces-11631-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3254CAE86D6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 16:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEF23B0FDA
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6399526A0A6;
	Wed, 25 Jun 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RYl0N0tq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946626A08D;
	Wed, 25 Jun 2025 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862542; cv=fail; b=mMOKaEryfdh4WsWTMeaeraNFzIVsLmjZT/sVTv8ijPnSYaDzoJaem6jBW2bJIduA+QY893lhzRRQjUcscAudowE4mRmYE9AMIOna/3iPrO2wE7kOBE8zNDsXzjjGXc15dpmqSLLgYjeNVdWQH2H+7UUlU5t3vck/oDS6S19jNww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862542; c=relaxed/simple;
	bh=QZVcrcUoDJNjoY/qTxDgnblqXgEeZDvBQnXE/5sy7M4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcF/rrY6aJM+aRvZTkek/enfaX8DzmNVY0wSHkTK/7FUxU2KorfZKlR1WIZcW+kKxj4SI/EoGvKh0dQAGVekOdkVEjLSGkmtnWBeFAO80biUTOrYcsYKB/HFJZdhs/glt2wgOLwPlZvz7i3HlByVk7wxwag2UKnQkPM9KvTt/Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RYl0N0tq; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujYtLUVWBIwPMRF8u2wNePXcEiQ6pAl5OkQ6b5kO4DrfIBMiu4ecDp1OafRRIVcfSf0xQDWCWwHHY3ds5ip+RWqxlQHCPrrtyKfPXYkf5tqFrSRi/3TiW3kOfd0G1D1izyeuTizd3JBqnKtT4oDovMzzwW6TlzlNBgmxe3Ww0xvShg5ifvxT3wSUakChIfSl83MjnX9FeCHjBgkbjRNJfsva7/A3uAFx8UMYNmntmVxdki9Z9kXBKeYdeCcxVKA5K3MBakAAbMWjRqBda7yBE3K+hHj2ltFcJ+z7V3dHacncfjCBAHoxbtvlgxffSlEWzrUW0F8T9FBrGn1IeBNNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFwD7vsk7nhie8oDe2UrDyDEXZkj4AjZcZwYs7KHhlM=;
 b=wlP6iBtBUmDQqsLOZVpW2BHHtEqJcLyO7BVyjUAt/FUd4IQc8dLz64a/LWaddSqYEFpzxoJ4TmZ8Vfr0C4iB5OkS4KzU3SrVK9dE5OGQ1V7GckpyDP+mRjW/N0gQnVgaJ8YBEqfluOLy2PUG5+6g9cldT57UR3B3rDK6vsffooSJSZhxrs+LnabTvAWps/fDehzKOYBJgcplpC7b/NB82PgDq6cQCPVddzMC84qqlI7yXhuiF7cmTE3n0OLe8Mz/Cod+VHULD5Q5KizX+NduDIwtZtqC0jkV+oTw/Ucm7YgeIfs6VqEvolMVX7a0H35l8e6rmUNjR40b2VWTMveR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFwD7vsk7nhie8oDe2UrDyDEXZkj4AjZcZwYs7KHhlM=;
 b=RYl0N0tqFpdf+siYYpb83194k9HW53f8+mnVJRyiCrqJNsWRovyd7xS6aE5THQFWNHqie5yF1fBx/JpYv3dg/xX85zewtA6f/P/ef/45iDZT6LUHR67/tEOjHVFwSEuBoLOURRFl158e0WjynbzdBZwT0fD1+BQerZlhdb/yzRmJtWrfkpQZxdAaG+dM6Xr+9sqB32B6h1vwJ64bX9Ya0vhKRuYGka82vF10XZ1hhhjwwdGKGPXzOEO27gBFavgjTacSazzPlIhlq/1OnAXqmzUPwHFNTGYfGSsihcwRDc1Tvbj+HOJcbayLvnM1RTMxP8Zzid/Q8BoGvHVuCC/GhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:42:17 +0000
Received: from IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43]) by IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:42:17 +0000
Message-ID: <403db5b1-1464-4dbc-ae88-9b60cf139e27@nvidia.com>
Date: Wed, 25 Jun 2025 17:42:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/8] net/mlx5: HWS, Refactor and export rule
 skip logic
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, moshe@nvidia.com,
 Vlad Dogaru <vdogaru@nvidia.com>
References: <20250622172226.4174-1-mbloch@nvidia.com>
 <20250622172226.4174-4-mbloch@nvidia.com>
 <20250624183832.GF1562@horms.kernel.org>
 <dff4ea02-4adc-4044-a18a-ee884abc0053@nvidia.com>
 <20250624174524.62bc82e6@kernel.org>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <20250624174524.62bc82e6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To IA0PR12MB7722.namprd12.prod.outlook.com
 (2603:10b6:208:432::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7722:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: c24c2fba-3957-4f4f-e305-08ddb3f67b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c21rNnNTZTBmOFlxRW1uWGw3bXIvM0F2R3BqWGZ6NkEyY3hUY2pxbWhBbTU5?=
 =?utf-8?B?cnhKVS9WVWpWNldNYk03WEhCcDhYMWRiNS93cldOc2liaHdPTXpOc1Z6a0JS?=
 =?utf-8?B?SDArbEI1VTk1T3YzV2djMHJMb0FoNjRkd0xSMkVHQWRjZU1WclAyMGsvSi9X?=
 =?utf-8?B?bGxtaFZsTFFZLzhvKzg4MnJVQTJQM3h4OEJLTmU1K1dudEtCTnF1RElNbDgx?=
 =?utf-8?B?SHE1cnNDNUY5L243c21jb1NuOTUvZ1lTUHBCZlM4SnB1NHp1Nk1KRklvamF1?=
 =?utf-8?B?M1BDb1l0UjNnWWdUMTVPNDN5LzhHYXIvUGV1WVNscGthcGFvOERYbWxTWklV?=
 =?utf-8?B?bmVuM2Jia3JIazhWb2x1Vnp5L2ZJUjNuTFh4VDdLYm1oSkEzWjZsSDZtWmNj?=
 =?utf-8?B?VlQ3V1BkY1FyakY1N0dzN3NEVlQ4czhwejd2Q1hmUDJKS2RyTEdTclJTazNV?=
 =?utf-8?B?VHJTNzliWGdzVlpwY01yeDg3dlM0eDRPVnk2VHZWemVsMEtqL0I1RVBlZFFs?=
 =?utf-8?B?SnYzd0dtUzNVOGhIeE5ubDVWQ2ZkRUxsU2M5SXBNazhiVDNUaWtEYVEwd29w?=
 =?utf-8?B?SDI5RDV3UkRwRFhKRGs5emRPSlc1OXFmV2M5TTU5NHVTdG1aT1F1ZThzdVVB?=
 =?utf-8?B?Um12WVFIYUVWeUlQWGZGT0U2Sk44cFVaMUgzcjNGazl5SGIxZzZkbUdxdzhR?=
 =?utf-8?B?TE5ScHdJb2pEMGlrWkxVVnVzMDdCNDFmZUhDZGxQUXNCVVlJS2h5UUtIMHY2?=
 =?utf-8?B?VHEweHhBYnBuT1Y4THJJWEFRR01EZ0hmbTlDK05NVjNTbWgrWWcxcit6Tm1L?=
 =?utf-8?B?L1BpKzZmQjl4TCt1b1ExaTZkSDUvTTV4Rk9RcmFnQW42S3VwdDJBWEFaaStY?=
 =?utf-8?B?elZvbkNvZ3kyRW1oRXFZMEFZbnFFWGZ1d3luc3JpRXlOWEg0eUdpVmt1V2t6?=
 =?utf-8?B?TWJpbUdmaENEOE12aCsreUM1Tm5GZmpQZi9XWDV3Y3IzVXgzdHVXMW9JL2dx?=
 =?utf-8?B?L1NWNk54c0NaNEkwS0QvRFZEaFpjcmVNVXpoWmZ1M0tzTEg3djBHWXdPVWND?=
 =?utf-8?B?ZGtSZm9NRno5dU9LQ0o3dWVqOGlqbkwrOUdtRWdnZWRpd0VETmtXUENVYk8v?=
 =?utf-8?B?ejd5RG44eGoxL3BqUklESWFoclltMzRseEd1REpROFVOODE2MVlTamUxSzVI?=
 =?utf-8?B?VWRrdHJXZFpMSGZlQU1jYlpMamhtNTRvZkFRdEZFY0JHUDQ4bEVOV2laSWNj?=
 =?utf-8?B?V013SjVxeU9WdHJ6aGI5RVl5N3JDMDBTTDN1cXhOM0VxRmd4emZERVhyUU01?=
 =?utf-8?B?ZDloWEtxdWE5VW9Ud2FwQk5mOWtZZWpjZDNDWHowMndzWk1BeUFDR0Z5OSti?=
 =?utf-8?B?UTRIMFJBUXdZWkZ3OUZHL2dzYWNQdFdKQmlXMFZOa3M1cGc4SFErbnRhT1hB?=
 =?utf-8?B?VVpobHFqcStyL2h2ZkU3NDhHVGpoQUxHcVM1VmZGckxpMXBmelFSellOMVpr?=
 =?utf-8?B?VnJGU1JuQTZac0JoWnJmYUxzSWxxN01zTzl4Z0Nnc3dtZFBxWG1VQW4zNk5v?=
 =?utf-8?B?SkFNZ3lZZHVnZnlKRjlOblJTVzNueDhKYzlSYzRpaWhYNEhBeXVydUtFZ1lu?=
 =?utf-8?B?VzlmMzJueFRuNUtQTGEvcmR6UGMxRE1idUNwSWtKSnBFVmNqUjg2OVU4VW40?=
 =?utf-8?B?aSswc1oyV1orcFFBaFJLTXpRVmthVjBieW9SMzRlRG9jQyszWDJvYXV3cy9D?=
 =?utf-8?B?c0pQY0FCOXd3MmZsKzVCNUQ2NDZURDZGRXRzaXFURFpnQXZpaEl3WVdvdEYy?=
 =?utf-8?B?T0FwaDZoanE3Smd1K01TYSszRVV3eGtwTzJYUnhLTmNYY2o5eGQ5SUp1WFA2?=
 =?utf-8?B?VzIwdTA0MUo2Z2hsdXpTS3RKTWMyRUc1V2FIYVVwZ1c2VnlJdDJxcVRWVkVj?=
 =?utf-8?Q?h4R4aCylHA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmhzVVc2S0VDT011UU9xRkZROCs2NnZJVHVJZS8valA3aFFHR281R0ZyNVND?=
 =?utf-8?B?ZE5nK0piRU9LNEpteVc4bFo4d3FsQzFqYVU5Lys4bFBQbXVZczRIM05DbGZr?=
 =?utf-8?B?bVNuSmhTTjJIYXhkNU5LYUVYWlFEWjFhQ2E1eDRhcVIyeVl6MDZZQU1PSkk2?=
 =?utf-8?B?M3ArMDJKTGhrZ3BVSTg0RmpXVW9iZmhqc285Nkl6TVJlU3IrWFJUN1U2azNY?=
 =?utf-8?B?S0s2TTBsazUvdGhGaUJzMm1Ob2RZd1VzZW42YUFCTVpEZ1lybGdyZ1F5d2h3?=
 =?utf-8?B?QS83VWZiSFVNb3RNOWJXOW80WDdNUXgxRkFzaW9xUGFpdWlVczlCRUxGZ2cv?=
 =?utf-8?B?dEs3ejdsK1ZXdjdvRUJ3TG5jZWYxYWtrdXZ1QjgyM1F5c1RRVFQ3VVB2WWg2?=
 =?utf-8?B?a2s2WGlnZ3dmckxHUDZyUnVXRE9WMkphS3BNay83SEF4bVNhVWp2ZkxRdFZF?=
 =?utf-8?B?UVhwWnljblpIYi9FNWd6eG94WCtqU1FoYjdmbkY1azFCS3h1L05TbjQ2aHp6?=
 =?utf-8?B?T0tZeWIyanNRM1hIT0JjamRIUjQ2dFRQQVhrVytvSkFyYjArOXpXSUFiVGFy?=
 =?utf-8?B?eTFDNE9FZlk2QzMweW5BY1pqcDlLUEt3eTMwSyt5blRndU9pd2FiaHNPRHlE?=
 =?utf-8?B?WVNmTm5zZTZHVlZlME81a0pac3kwYnoxUjB5VzhGbU9GRnZ0YllZRzRramJS?=
 =?utf-8?B?UjNtelpBdktNcWg1bEhWU1AwaStZcEFCVVBDaWJwKzNRczQyNlEvSE85M3VC?=
 =?utf-8?B?cUVoeG85cGZUVlNmUDVGdGpkdU1RampyazAwNGVkMk1Cay9pcytlcmU3cGZZ?=
 =?utf-8?B?dlF3MkFreDdMbWFMSGd2dFpydkljYWF1YnhaQktFeDE1ZFZ4NmxrYTZGZjNo?=
 =?utf-8?B?b3hXVVMrUkVJNU4yc01VVEJsQXl0aGFWMG9kaWJGV1dSQTYrSE44MnNMWGM2?=
 =?utf-8?B?aFhaZmIyRk80QndNR0dud0s1UkFMa21TS1B4bUlnSk9GWHd1dCsyRU9OcE9U?=
 =?utf-8?B?ci9VZGttbERIbGNiYzhxMDhWdWVFbDgxcUUxSVJGVUpYWjh2N2xvdkoxNVBu?=
 =?utf-8?B?cHdpbUN6bWdPUkMvUTU3OFBLcXp4M1E4SHBFa0E3ZmFvV3NJcFVlTXVPbWN3?=
 =?utf-8?B?ZXZuOUFMWFpkb0x4QXZzTy9oQW9RZXRsL2ZzZG90aTBabkM0TzJFZUdaa1A5?=
 =?utf-8?B?ZFF5bGVOL0Y1V3BCbkU1S3Q1MFovN25KOGkyUDBjVkdkRURNbDdFKzdad0JV?=
 =?utf-8?B?NFhLSEx1Wml3UGMxZ1dOVm9DM0dLdjJMYWpzNUxwMk5KZFUzTVBpTTlXTXFi?=
 =?utf-8?B?ZVJiR1ZhWTZFajJNRXV2eEtFTndnRnBZdW8wZ1hPb0dnblhncGxqUSs0aU9v?=
 =?utf-8?B?YW1yVkhPV24rZHNhcXhDSTVnVkpwSWR3bjhJcnlOZzFFZlVzY1MvWEVkTmtN?=
 =?utf-8?B?MWQ0eFBvaDJ2bkxGMndPMVVjOHd1QUQyaDI1eXlVZnZjZFdOd0wrWnhsSEYr?=
 =?utf-8?B?cUxPUitnTXFSaUcxQUNjU3NiMmdsMWlhbk5rWkhVV3IzZ1dkYkNvK1h1dVZv?=
 =?utf-8?B?V2VwejBRckI2TkhaTjEzMEowaEVNMXpqZXI4UmxuTUN5OVI1TEg3ZHFnT2JO?=
 =?utf-8?B?Uk5qeFBSOVNyUnd4a2hnOWw0VVNvN1N5dmt0dWxIckZWUTVpWkdVWHVxcFBM?=
 =?utf-8?B?dDFRWHQrQm1oWlFXSTJFb2JZNkFoeTlRWHZSTDgwbmwxMWlnVEJYTEtiZnBh?=
 =?utf-8?B?RWtGQUpBa0I4UDR0VHAzYldsbXduVHFnaGIydnhEQWVrTFMybmpxVXowNjNK?=
 =?utf-8?B?Q1Fkd01Zam9vcWFwbWgwOHhXVmxMS0lhbUcvY1pMR1hQTnN0UzNOWnNSMGlW?=
 =?utf-8?B?bkR3QXFLVjdLNElLRmkvaXphVUEyZnlqZmVQKzVDclRQTU5uRUVVMXdJRkV1?=
 =?utf-8?B?OVp6MnhrR3RlVWNxOEU0VGdDRzZ5N2FJdVZYd0hHcFJxZnlHWjhuaDdqSW4x?=
 =?utf-8?B?SGNWek5VcmplcUMxb2U4TDlDZ0pTK1MvNWFIS2g1bkVkck1HZmNpUDdISWNj?=
 =?utf-8?B?bXl4QkN4aWYzQ0UzQnlySVdUMHcvOFQ2T0x5YktwVU00RVQyUnAxWWRON3lq?=
 =?utf-8?Q?JnUrALkudDLe5LXgv+fNrD5m0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24c2fba-3957-4f4f-e305-08ddb3f67b35
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 14:42:16.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jf0DcKPRb/jhX82Uqlf5lEhuiSakciPLWX+U7nTNVJRpSKjSG3RZQOPrOZ3xSp9Vzmfx81oUN1V/10RnbSe0cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928

On 25-Jun-25 03:45, Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 03:35:52 +0300 Yevgeny Kliteynik wrote:
>>>> The bwc layer will use `mlx5hws_rule_skip` to keep track of numbers of
>>>> RX and TX rules individually, so export this function for future usage.
>>>>
>>>> While we're in there, reduce nesting by adding a couple of early return
>>>> statements.
>>>
>>> I'm all for reducing nesting. But this patch has two distinct changes.
>>> Please consider splitting it into two patches.
>>
>> Not sure I'd send the refactor thing alone - it isn't worth the effort
>> IMHO... But since I'm already in here - sure, will sent it in a separate
>> patch.
> 
> FWIW having a function which returns void but with 2 output parameters
> is in itself a bit awkward. I'd personally return a 2 bit bitmask of
> which mode is enabled. But there's no accounting for taste.

Indeed, it's a matter of taste.
I see that it's kind of a style in this area of the code ¯\_(ツ)_/¯
There are more somewhat similar cases, and I'd like to be aligned
with the existing style.

