Return-Path: <linux-rdma+bounces-3830-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F144B92ECB8
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 18:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4B91F225E7
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714E016D313;
	Thu, 11 Jul 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="khMGCCbD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F716CD39;
	Thu, 11 Jul 2024 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715378; cv=fail; b=V8TahJGLdIINNa/PpvKf69MPNWdSaC/GWe8r1flvHveoGRl+R248UET8L4K1bAlKTD3nQkadKM4U+KtfqvhSoKh5PTRORjM/ZvHUkfglX1W/NkVfLTWBu+4HCNHZFkBVGYov2OlrGLUp1D7+rrj23FQfTtdXz0gRad7tIVpuiis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715378; c=relaxed/simple;
	bh=e1MScWFzLT2KW91VMQBjHLiEZQP27FZJ5+NzTvzd/J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cmPage3R7tXy2kE1kNd6aC0TV9AX8fHtN6erQJmQKzqKJBSxFY/POCB0izJWbiu/gldjJrrS2oskGzPVifghbUGZ/7XB73JeofohwBncrz6b/qTbkodPfRLh7mqm1Fh/V8AdE37z+RO1+Jlv+h5JfIoMGCZIhH/xIwHZ1p6X3FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=khMGCCbD; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8WMf7h1IiaSOycWpa3hILeN5bkbfpJc3iEHOSRKV79CWcgH82yvsvQ/w66Kijis/0xObRdlwjxk3f17uN5J+SpNOteehif9W0NKn8Rom1Pkz7RIsu3J8NvP5FLcdafMAOqnWrD5UyxF2+VlUmM2GYBF2JC/CXAkL1GBRci1517fTrqz7lQV3T8mpanQJkLI2swTGnpLY289gamGbrxAPye5IfwjGfMF5YvW5iTY9x+Opjugn281FJj11HT31LL9vqNl6+u0Ygqu93XSx61bdyhA1Orb26lNVDf43aaoyaxItQtHUJYAhYuzew44XE7qS22ceUEHyACnoE32/efPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdA0mhTXLZnGHOJOBXWD5Q1PppE3u7ACdzRj8kSTKPk=;
 b=bGcmaOmqs5w+vL5nVLZAgR/Am85lL7n2iMAw3w+gFqVHRyFfcrcADVxX+PFSKFRzBbRnvBs9dlEhUb4LqVYUqWVVEVFgyfF6Gv9srdOOvOIQWLmWQjNlYVlIlE3HvJN1ZzeYOHzecXGcXce9E8OCgRyJ89p7X3GNEE+/HrRsZ5Et0YZN8KKp+gSdCHYQJ7Kmls2V7cl55lwsTS5NKnuQw7RNXsvV7Za0D5E279UY4qvfh5YKZxWnxRkhqhxAKSKNdnHKH2syHfgE3kuKeayvMuz/olw7Nm3fseLBZq1SAJxy+W3L9mrB2v9BDj02t+9t14XT8YrP9E8Qes5PQpdj3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdA0mhTXLZnGHOJOBXWD5Q1PppE3u7ACdzRj8kSTKPk=;
 b=khMGCCbDPmSprqhljyBPKnDzfhBmcYcONdGNiIScmLNOCibNmhC7nSkmNs88R6jK7gd95ioTtb4rY8wDCy4g6Kb28Cr+WDvGp3XfldB/vGHBu+VtTQ5WF/bPl5QI8pIbUdVNgRhUtNcONwb4Z+a3+4dfrOesWYU3aCkac4IAEv3iH7wIGOJCTX3uKHa0c3s4Raeoo8U1nJgRHT8bZ8Bir0Xj7NqF+CM/gZ+FC+OsqSWEQNN8YMJ8HB3s4r36/fDuO9EUOoRMCigrjEwRTAee60XdL1pZ1DFN67rBT9JufINJ0suGTQqJaJkhoUUSRC1KEBGyOSphHSCt1Cgt5Va0eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Thu, 11 Jul
 2024 16:29:30 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 16:29:30 +0000
Date: Thu, 11 Jul 2024 13:29:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240711162927.GG1482543@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <20240711135030.GD1482543@nvidia.com>
 <3ea7076089590e1d2bed139c256dbc077ecd6984.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ea7076089590e1d2bed139c256dbc077ecd6984.camel@HansenPartnership.com>
X-ClientProxiedBy: MN2PR20CA0046.namprd20.prod.outlook.com
 (2603:10b6:208:235::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 7621c9d0-b18f-4d06-eec8-08dca1c6a3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjFHbTRhYkcyUmd3SjRLMUhBZ3lERmZqSVI5alh6b2tiYmpEQU1iWmswOVRK?=
 =?utf-8?B?aTg3bGh0MDhRcGJqMkFKVG9hM0V6TXl5eEhMSjRuMlpwY0M5ai95Z1hJc3Za?=
 =?utf-8?B?ZGo2TU9LZmlNMmJWdFlYUmwrWjBEVGFLT2trZGI0SllwYWJndzhucEx0Skhm?=
 =?utf-8?B?cm0vSi9XeHc3U1h5QUpaVGhsZmdBWmNiVkI0Mng4aXAveDFyNjU4d0dpLzkw?=
 =?utf-8?B?SnA5ckpBL2xEdFZ1M0dlTkNDSE9TaHRQTDV2bGxjZDU1WWxhdGhJcnZYL1Zk?=
 =?utf-8?B?L1htMU16blBaZThMaVJXcThuYXM3RERzQzJiWHNZZGxPWHBUYjRLcFZxYUdZ?=
 =?utf-8?B?OGw3VTJvTS9lbU9ndWJRc0kzakZLMVF3UWh5dlQ5a3grbFN5Y2QwZDJhamtS?=
 =?utf-8?B?OFQ2TXJCeUlrdHVGbWVOMkVRU1c0bmZMSGluay81V0NWRllQK3VZaVplZE9j?=
 =?utf-8?B?SFQxelN0Ri9uL1A5b0Z0SzJkd2xXcGRWbThhdHI4MGhOSU43NnY3OVRxYVla?=
 =?utf-8?B?UEs0UkxmWjVqT2R3ZjI3TmgvaUlkUGNNNnA0TlpraERwK2c4dUptKy82QnBu?=
 =?utf-8?B?dnVodU5KMys2cm9YRnJENkt3alNjY0VJOGdJSUx4ZGVEbWdweTdNTTU5ZitF?=
 =?utf-8?B?VjVFOHk1Q0FTK1hSa1ZxMXF1blQ0LzkvWDN4ZlE1MEhvK3NKYXhNSGxnY2U3?=
 =?utf-8?B?RUloNUNYT25iRFJ1d0hlYlZPUEtPUDZuUU9EcDdQd241QmVKL1A5NjVaZkNa?=
 =?utf-8?B?dlFMd1Y1dFJrQ0pVZU9IUUJYMW5KZUZjeDZudnpCbGJsYUJQOWlZV1FiTTcv?=
 =?utf-8?B?emJzcXBaWXpyak53VmhUS2Qyckx2QnQ4KzQyTDVacWpSVkNFdUZzVVBlZ29u?=
 =?utf-8?B?VEVidW9GVys5WHB2ckFENW4yUXVabVhOZzZFWXlYWStLM1pMeXFQeVU1OXZX?=
 =?utf-8?B?YW02SERURytXSWY5OERGZWxIVlhjVVhuR09vQlZ1cEN5NGRlbHZja05TNlRH?=
 =?utf-8?B?bU5IVDRuNnI3OUFXbmVvOUhXSzJHclFqQjFGYWdNaitaK0VWSTFMSW85OEhG?=
 =?utf-8?B?cmYwaFpVQmFFdUwwUkhSS1Q3bkFDa29GRWpzOTJPeUhGRFhRRC9Hb1dndWk0?=
 =?utf-8?B?SEN2eTkxV3dGMjY0M05hOEtyT0Vod0E5NHVqVlFFNnovaENYS1N3NndRRWc5?=
 =?utf-8?B?VVRxOVIxT2ZpUXpVeVNJcEljQSsyaFA1RXNxNEZpRVZXck5zY1Y0YTNzeDFs?=
 =?utf-8?B?SXNrMGxSbWNEajhsNmh6T0YxcjVnVXlBSmUycHJiUWxwemhXR01mTVhhbkVQ?=
 =?utf-8?B?dytHM2NtSjhKY0MzMlNkalZOdnBTbkllbkcyL2swYXI0QXpJekVqUFlOUy9F?=
 =?utf-8?B?QVdtSEptRXlLWDZodkVhOVlBTXdGTVNSU3NUS2xaSG5XcXJMM1o4Q2VLVnF6?=
 =?utf-8?B?WUhNVDg5ZU1jbVlOUGQ5SUlTNlQ4K29YdGNjYTcvZzQwT1J5R1ByK25ZT2xB?=
 =?utf-8?B?Y2VKN084V0lmWjloT1ZETHRmRmVFWExMUU9CVDY1R3I3ZkQrWDVLLzRLVFZJ?=
 =?utf-8?B?MVZsb2VmUGJzMjNZamtSaFAvaUZZZUJTNnZuMng4bmxFYWdDMWp5S2FIaXZ0?=
 =?utf-8?B?RUVVOXcrYmkxYlFQbGdOdnoyTWh3NTFQQkc0NlA1OGNCT0FyZExiaTdWakhC?=
 =?utf-8?B?bGlka2V5RUxDdnAwaWhKbk44WjR0WGZoVy95a1pHV0tqUDJWNE1DQnFBTHZH?=
 =?utf-8?B?UHZSOUNoM1M0d2FrMC9HUHlnOXNTZTFkS2VLRFowdDl3a2RFY3hhMWpFMzV3?=
 =?utf-8?B?RjV0WXpkZmtsTFljUE05dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVVocHVrdmtBVGY1Y1d3cnRLWEhzckhhRWRaVGxTb1R3Qk9XbUJGblAyMjVK?=
 =?utf-8?B?cUVFVGtjYm1HdzZrMXRzNmZwRDVwUy83NG43WldJU2t0Z2MwVGFNcXBWcnpQ?=
 =?utf-8?B?bm9jdE1RZUY5Vll3MU9TMVFma20zYnJHZThNSGswaEtaeXVTYnllbExqazRs?=
 =?utf-8?B?WXVkdnJTWGZ1LzcvWjM4Ykdtdk45YXdCZHB0K0tZa0VvdjNqdEpHRVltaHRK?=
 =?utf-8?B?bFZhc0NvQjkwTzFOaEZlVWNlZS93WktCZ0EvZE4ybm9ZREY0U3NIM0IwWWJq?=
 =?utf-8?B?ajMwZ2JUTTZua0V3d1FtQWRPeW8vU3F3bGVMa2toVzhkWEhyVmJNTmhYUDdU?=
 =?utf-8?B?WmhLR2kzWnZtWDBvam81eVJha29ZVFpCcG81WXdoT2NNdHg3enFFdC9MNnJB?=
 =?utf-8?B?c2p5cEIwbEI2ZUNQNTl4VDlYUENjMzlOT1NNRlZXckxjd0l1RjVFbGhMeUZS?=
 =?utf-8?B?Z2Q3eW9tQS8rbnFIM0FWdjUyeWYxOEpjejNxbjBSbzBObjlBcWJvZUdLekt2?=
 =?utf-8?B?ZXM2OTVRMGhTWGxybEIyZGNpTTBiQTk5aHcxbXVkTFA2RCtLbzVSY2pBcUlG?=
 =?utf-8?B?Mk9IVGp5OHNsV09BMHNCNjdYSnlyZ0pZejBCN0l3aU1udDA1SkgrcVdJWmVQ?=
 =?utf-8?B?Vy8wWmFIcWVIMTNXMEN6Zkx3eTR3aldqZzI1SDRaeWVIMHNHKzVrMkJ1cmUz?=
 =?utf-8?B?ZHh6Q29UOXowRTlsTnV0UWtXbnZIdEFmNVRrSEdCaW9kMHRSSGx1TE1LcDFq?=
 =?utf-8?B?UjU1VGJMeW93WHdoamZ3WW5yaVRLWnBSdnRaZXVEeVo2dWh3Y0lwNkxYbFRL?=
 =?utf-8?B?WldaYisrOGNYc09VMXREbTN3NWxtMEQ3R2tOY1B4SmNHQUlqQmhXZm1mTXM4?=
 =?utf-8?B?VVFEUFV3VFBGaFk3cEpmOEJYdDBoTTJpSE9tSy84Sm51T0praUdNWnowWjh5?=
 =?utf-8?B?b1RyR2ZNdFZzbFNsY3YwNzJoblpodEZzVVdkOEpteWs3Ti90ZW82NE5zN2Iw?=
 =?utf-8?B?MldPVUJzVmM3MEhBYitaMVRnK1VrQllFVVUzaVVVRVBLcng2aWYvZW13Rlpn?=
 =?utf-8?B?WVN1TjBhK0ljb3IxOXY4QU9kczJQaW5iUG1BY3ZXRWhQMmlrY08yQlQyUm1V?=
 =?utf-8?B?VU9LR3JYRkpXdTNFSEZ6V043QmlKWHlIbGw0Rlp6SmZsWnlEd1NlZDdtcVlD?=
 =?utf-8?B?M0pGenNZWEJkeTZpYTBUZ20vK2hOeVdrQWcrdms3RG9kaWZ0NDJraGpjK1dF?=
 =?utf-8?B?SUw5T2tVbitHOEFwMFdwTXRYNmZpLzRQREpKM0pmcDVmamF6ZFo0ZHJEMlVv?=
 =?utf-8?B?QTZpYWxVZ1J3S0cxbDlhV2x6Z3NZWUJjaVA3WHM1dUU0VElvTDJCaVhBSkln?=
 =?utf-8?B?NHVEbWU3OVMwcmxGTzNIT25JdzZXck9va005T0IyTGtKT2ZnWVlLMVRKbnhh?=
 =?utf-8?B?MkF6YkJ3QlhqYmZtZGRjZFpQMytlK2Z6V2M4NkJCbERzQVhvVEhqK2puT3VZ?=
 =?utf-8?B?OTZJZTBXMzlkNWRHYTlzVkRRZTdqWkk5aUk5SEJiS0dtV20zbWJrZXNNclBR?=
 =?utf-8?B?cnhYQmkyakFpOGVZOXNHNFNFZmp1blk1M3lScmpObDdEdExBRlRjd2dLZDhW?=
 =?utf-8?B?ZTJiQVluMnRiR0p5d3ptZG9qM0FOK2g1OTdFSEdZbEhCVmFVRkhEVnBqQmRW?=
 =?utf-8?B?dDJBNmZ4QmJ1VklvaUFSWmphZGI5VzNkSklXTTUrbHpHUWllUkNOaEtVYm9z?=
 =?utf-8?B?UTNlRXFwNGcvYUtXbmhVQ2p1ZTY0ZXM3eWdodmVEVG5BUlRiQW5tNk5GbURz?=
 =?utf-8?B?RENTMnlHUVZhWlAxTmxTWWUvdERzMFgzZGQwVVBVeXRjREJKenRBRzN3U2Nv?=
 =?utf-8?B?bUlNSmlwSmlFanEzTHFNQzg2MHQvVFpDWEVpL0xXQlBIWVZNTDRvRkJub2N5?=
 =?utf-8?B?QTFxaVhDYVBFeWpjSERVM1ZXVU5UMlhtTmtPSFEvRFU4QW5EU1Q4b25YQU8v?=
 =?utf-8?B?S25YMWtndHhYaWM1K05zZlhyZkQvWlRkRVJuemVxTUtKTWIvVG5MN1pGMFRH?=
 =?utf-8?B?Sk1zK05JckRwUlVJN2pBSmtaRUtlaDltME5wM2ZHeml3N2tpdHYxS1JiZ3Jj?=
 =?utf-8?Q?5oueIoexEA54z0M8NT5pTdwxJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7621c9d0-b18f-4d06-eec8-08dca1c6a3c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:29:30.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzaPIQ0KBVRi+MR3TG4BJ+RdbnpJ0FrQFBB9PwEznFzzoSG+Reyhmm8COrJfXIsf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074

On Thu, Jul 11, 2024 at 08:16:55AM -0700, James Bottomley wrote:

> > > What all of the prior pass through's taught us is that if the use
> > > case is big enough it will get pulled into the kernel and the
> > > kernel will usually manage it better (DB users).  If it remains a
> > > niche use case it will likely remain out of the kernel, but we
> > > won't be hurt by it (NVME KV protocol) and sometimes it doesn't
> > > really matter and the device manufacturers will sort it out on
> > > their own (USB tokens).
> > 
> > I don't see it as being linked to big enough use case at all.
> 
> 'it' being fwctl?  

Sorry I ment "it" as "if the use case is big enough it will get pulled
into the kernel"

> I'm in the camp that doesn't squash a novel proposal because the kernel
> should be controlling it.  I'm confident that if the use case becomes
> big enough the kernel will likely do it in the end.

Yes, I agree as well. If there is technical excellence to draw
someting into the kernel then it will definitely happen regardless if
other options are available.

> > While DPDK shows the opposite, userspace is the technically better
> > option. This is now shown at scale. DPDK is not some niche. A big
> > chunk of internet traffic is going through DPDKs, especially for
> > mobile. Many ORAN solutions include DPDK on Linux.
> 
> ORAN being Open Radio Access Network?  

Yes

> But that's a case in point: the kernel doesn't have a LTE stack or
> APN handling for networking.

That isn't really the main point of ORAN, a native LTE stack is
interesting separately but is a different problem space than ORAN.

ORAN is about doing all the complex maths for RF signal processing in
software disaggregated from the antennae hardware, in realtime. It is
some bonkers combination of >= 100G networking and hard realtime
packet processing with incredible math using dedicated accelerator HW.

> I don't disagree: there are many novel protocols and other use cases
> that will never make it into the kernel simply because they won't get
> the adoption;

My point is that prefering userspace/kernel isn't about NOVEL, it is
about technical excellence.

DPDK running a >= 100G NIC with extensive HW packet processing
offloads is technically excellent at doing proprietary traffic
processing work in mobile and cloud networks.

We are already running these DPDK things at near perfect performance
with minimal integration hurdles, there is not a lot of room to
actually be *better* with an in-kernel alternative.

This is what I mean, technically good displaces technically bad, it
has nothing to do with kernel=good userspace=bad.

The design of DPDK, with reduced kernel involvment, is a technically
correct approach to achiving it's goal, and it's goal is legitimate.

To expand a bit, Mellanox has supported both paths for a long time, a
lot of work has been done to improve the netstack and mlx5 to give
matching performance compared to DPDK in some use cases. Yet, I think
the market has spoken and DPDK seems to have much more popularity in
some very big verticals.

Yes, using DPDK carries a heavy development cost and people should
avoid it if they don't see a 5-10x improvment, IMHO.

Jason

