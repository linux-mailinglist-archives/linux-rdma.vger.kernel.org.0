Return-Path: <linux-rdma+bounces-4290-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE16494D3CE
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 17:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57D228493E
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21E8195809;
	Fri,  9 Aug 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="Y56/tEa0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2097.outbound.protection.outlook.com [40.107.244.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA188CA64;
	Fri,  9 Aug 2024 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218119; cv=fail; b=b8k/wHAKN726Wvqv8d10PGlZ4sujBYZXsZDyvMJi5a2AS6GjfBWX3oUOyzIwulgBfe56Lg+sMHL55HTmzhkQAgdOOydUP3Ejp435rezyrUPqBL5bEnKcLCSqnBCIBgRa8tGhyerSymw6/BT+nFnSM/RbNpUIDCvgWGbeZ/MntOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218119; c=relaxed/simple;
	bh=M9mUCsvTqPZDISg+6twQDHA1Gz7iJ9Flrn64p15dOdo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GNg5rF55Vwbvs7usNeHUbERs0ePKhQghKrhye9/g8nd6H7l8t3mj16E1UMhl0xv4DjMRz32gQV9ET6mgvOXbF4oP2J3Qu/LXj9vxr99kNV+3N5rho6NF9XIBYCOQlg0QSNzPn+CPFAHQeoiLkYKY/DyjOypE9ELFsKf030bGpQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=Y56/tEa0; arc=fail smtp.client-ip=40.107.244.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg1IhoHkQJISY5TorHQUyoelkqI+zDrWHGe7nX5SM2tjHg+Fj2kBusa46lK/pWgo+8c0nXHGBf/gCnHyF/cTUvCh7TTkrvETTICXgMD6MjURaCft9jLZu/4fUYth4wSFldsHuC6m3BO1DBmUcRjrzXzhg+9a1iyXccAYk4Z0vLz8ihEUYDp12Do+WbG2aHkWHNMKWCJ8szFjoEZfVTt8MFww5u4PT5eQilvLMpZBrzlY8OSFDCg6QreFKF5doy4lQlxHM/EDOYC0F1Mx95tfoL3KGI3ZI5QqscrhW1MRs2iZPbcIBpc9r9YFlbkx6OMz4EDSQcpov6SNJDkqdQoQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC00QCPFfvhcb4qWy9qtulBu3TVn+Bi7Y2Htp5GADTA=;
 b=bqn9gRpKEIEJ4f1w5EIQWG/kRih8iVAUkDKAw/AOKIVLcQrDlLZjOEj5u8wts5vozQgUsOwp1ugoTcNougQ86LzNBBTELSjNfx/NR2fix7IcLCyw99pYnAfuJgq0QHyn58ndlWNiLwd8bLZNB8wZYuklFb0gk5dRRWODL3S5Bb9nIrBqRm4v8+HYrWL9LvTm+Jv/A1aPfLEz78JtMmnGNKaJUkie3BgJxS3vKEGgtlDDM4q9aJtk3sSNKq3Pi0Cb08w0Zz83ZyvaXRQtx8h3IJVsmNcnGsZGpmdoofEHvF/u1G+5PEesqVl0Oyp/SboTLJJcU8Jj8SGzJDy0MgBVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC00QCPFfvhcb4qWy9qtulBu3TVn+Bi7Y2Htp5GADTA=;
 b=Y56/tEa0KCYPCYnDTtEKH7Ra1QcvOvPXBqdmoiEFh3AA4Bb+1/B09/7ZM/IvfuMuPBUOegv0WijCwSf77ALKc7dErIQ3M84gMHiG7nB0SbIwat8T3fCWMSk9u4NnvplMj/JqbCG0x3LZzz7LEBPF4iXDN2UZGBVRArrVdG9h44o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from PH7PR19MB6828.namprd19.prod.outlook.com (2603:10b6:510:1ba::20)
 by DS0PR19MB7838.namprd19.prod.outlook.com (2603:10b6:8:12a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 9 Aug
 2024 15:41:54 +0000
Received: from PH7PR19MB6828.namprd19.prod.outlook.com
 ([fe80::69c8:bdb9:b882:b849]) by PH7PR19MB6828.namprd19.prod.outlook.com
 ([fe80::69c8:bdb9:b882:b849%3]) with mapi id 15.20.7849.015; Fri, 9 Aug 2024
 15:41:54 +0000
Message-ID: <a9468d88-c2e9-431c-a2bc-847ce9743729@eideticom.com>
Date: Fri, 9 Aug 2024 09:41:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] kernfs: add a WARN_ON_ONCE if ->close is set
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Artemy Kovalyov <artemyko@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 David Sloan <david.sloan@eideticom.com>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-2-martin.oliveira@eideticom.com>
 <2024080933-jazz-supernova-9f3a@gregkh>
Content-Language: en-US
From: Martin Oliveira <martin.oliveira@eideticom.com>
In-Reply-To: <2024080933-jazz-supernova-9f3a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:303:b6::18) To PH7PR19MB6828.namprd19.prod.outlook.com
 (2603:10b6:510:1ba::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR19MB6828:EE_|DS0PR19MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f223de2-012a-4b5d-8945-08dcb889cb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z28rOXE2SlE3ejNCcnhoTDhNUklUM1hpRzF2MUo1SnJQTHVlVE1DRGFOc3lu?=
 =?utf-8?B?RnZwSnZWZ0VPQ2x4QlFGT09xakpNUlc5Z2cxWHVMUFpFa1dSRFVJUDlxOWoy?=
 =?utf-8?B?cWE4OFo0SEpRbFFtaVErY05HcWtJZTlFYlNrelBUbzd0ZHp2Yzl4VjcvbWE5?=
 =?utf-8?B?OVFIWC8wQ1ZmWEplYlJCeW5oUGxDbHZjZmgxMEFhWjFaOXNwV0s3YzRiZTBu?=
 =?utf-8?B?UGRxUzdKMmxEMWcyOFJhQ1h5UXU4SXJJelViUUpPWUN6VXBtdGZRZ0VBUk1y?=
 =?utf-8?B?dDUxTHAzNnBFM1R2d1VNelMxQXkwbnJadUtEd2thOUgwbHlNWmdLOEYxdVhF?=
 =?utf-8?B?MnV3K292TEJyakNXeW5UODhOWUdaOXhoZ2duMzFUZnJqL3BBdkN6Q2ErN3Fu?=
 =?utf-8?B?Q2ZPVUFqa205Rkllb0ZwR0VabDJvSnduVzZQd0U2S2FjTG1VaHlNcm5sUDhO?=
 =?utf-8?B?OGI0Y24zNy9WM1B1K1I3eS95bDVzT0Y2ZFNUT29sL25vdm1hSzE0L0RkRXdp?=
 =?utf-8?B?cWZ4MTlNZUZUMVFRSVhXYlZDR1FMSTlnRmcvditWZW0xMTVQZHoyL1pQbzlh?=
 =?utf-8?B?S083L1drU2xzZEVQcW1zTktSRVBqSmlScFpGeldjOUtRamdrUHkrYzlVa2pV?=
 =?utf-8?B?R1cyRGxGYjBNMlNrbHR4Y2FJMUkwbSttcWhYWE1sZmJkU2RXMmd5OWtueUc1?=
 =?utf-8?B?MEpLeGxTOHM5YVQ2UE9PQkYrdVBRV21FS2x0bVdzdElwZGJVRVpmVGhUSi9X?=
 =?utf-8?B?TCs1SjY3ZThnbjRPczVXUkU2dkJJTXJwaS9nVDh2b3Y4a2c2djE5YkZpclgw?=
 =?utf-8?B?UmY2RmM2b056aXQ4ZkFHNjcwZFlJUU82N21SS1B2UDBEMG1xallQQUlDZGlo?=
 =?utf-8?B?dEZhUDJDdVBTcHV2TkZUa1BRRTdqc0ZQQXRNL2ZQYjBSWHV3UEtpeFVDMkh2?=
 =?utf-8?B?OWIwa3BXcG9yMEZkYStnY1hadWxXSnRsNnNKU3Q2c3NiaUlEaDVtQVlBVVBx?=
 =?utf-8?B?eUJlMEhHbW5GUWlxWjRPYUFxREZxU3VSL0MrR1FicVcxU1FGbXpRSWd2WVRR?=
 =?utf-8?B?aEpEOXpaUUZZMG4yRXZxeVJRRnZxRjRuRnBiL3NoMy9mQm80NXJ3WURjUEk5?=
 =?utf-8?B?QUlkQmJGcGVUdEFLRTlpeGg0eXBKTTBDbEExMnlZVWltRW96WlBqTnBWMGZp?=
 =?utf-8?B?VXNPTVZyeVNoOE5mcEFrWHZKbUhZcUdraklJbldYdE5Ta1Y4VDR1MHBTWm5s?=
 =?utf-8?B?S085ZWVTS1RLbUZ4eitMNnByN0Z2SXdkQkpuK1REdlk2Yk80TlJEdmwzRVAz?=
 =?utf-8?B?NVBxOXUyWkNtdmsrWS9wMHc0czJKTEVlWmF3R3NEcHYvQWRiZTcwVGRqZDBS?=
 =?utf-8?B?eXp6Q0U2ekx0MnFlNkUvM1NTT0Q0UjE5WGRadmpDbnZESnh6a0xQWEZ1cTZJ?=
 =?utf-8?B?dmplTVVFaWlKWXVuUld5VXA0SzU4a01lUzFVRDhVcnFzaU1ra3pwNTZZbWxT?=
 =?utf-8?B?TjM2L3E5RVlUZGFTYlNuaHk5UlUzTEZrYVRJY1R3Tjg0RVpxVHNWby8yT1ZH?=
 =?utf-8?B?Z1FHOURHQ2g4KzhpZEZ6VzNRc2VoWnZ2cjJycUM4VXcvZ2F6VW40aThqdnpN?=
 =?utf-8?B?ZVluU2dnc3lPaTUxY3o2dk1iNnFHVzhQZ0pkMFp3Y21pc2lrNEoyRlZ3QU05?=
 =?utf-8?B?ODhjVXcwTWpnL05Ic092T1pucjd0VGtaUkJ2NUNCZXhxVm1tdncxUTdXSFBn?=
 =?utf-8?B?bjdIbGNQbTZNTUd5UzJLaDJjYVRWR3VXREtiZ1VidkJwTFJhcDhwMyt0SDJM?=
 =?utf-8?B?Njk1VTJpOWtmV1FBZll4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB6828.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkVxM2lHVVA3dmxkaGw5MnVEVnZiRUdUVy9QQzhIVDdaL2JkS05aVktCVTZ4?=
 =?utf-8?B?ZGRhV2g3amZ1SExPRTlZUmZnS25Ma3U1dzJNZFdQUVZhSXkwd3I0Mmh2LzQ1?=
 =?utf-8?B?KytJbzk3d3VkY2dxcUpsMDI1TTBheVEwZ0tXekRMV01DNUpZR2p6VkxDbk1C?=
 =?utf-8?B?MnZSNytHcUdiRzdWdTdBUW12S2ZGcXNVZUVJWm5IMFFlTjAzNmJWbHIwd2oy?=
 =?utf-8?B?MWg4SVNZcndrUlVzaTZhN3FHQ0FzbUFtK2l3b1hvcGgyR2tiM0xYelMyYVNP?=
 =?utf-8?B?V0tYak9JaU1wRmR0RzJEZS9iVkxUZ3kxTjVFb1dPdDd5WkpsTitaSldlMVI3?=
 =?utf-8?B?TjdTa3ZMOG9aQWVWbUprWksxeGREREc0NXErc0g1aXNQQlVaaE1SZEE4clhP?=
 =?utf-8?B?SWN0S2hFcjRONGFiRmw2dStNRmN0dnRRWDF3YzRXUTdSQm1Ga0FKZ3NOWi9M?=
 =?utf-8?B?K2xqdk5uME1XVW1BOVZrczJLYm0wbVdpbXBFVi9SUHNmWm00c1IwUDFBUUZm?=
 =?utf-8?B?dW8yclFYbXhNbVBFOWs4Smt3clI5c0cyMHNXWUh3aGRPZmw0czZTN0l3Y29i?=
 =?utf-8?B?MGIrR3RyRVdveGV1R3dlNjZZZFA0dUJPOW1wcitJUXlqMVNZMEN1QUJwTit2?=
 =?utf-8?B?U3NHVlVnNnRCdDM1U2JLczJOd2M1b0VicGE4alN6U0o3eGRuVUE1dEdPcDBV?=
 =?utf-8?B?aklzcjFoRXNjNUZxMXgvQS9PcVUzYUMxcEZYaHZyRjBjMTRVc1EvUDAxdTg0?=
 =?utf-8?B?SUZSbWFsdk10VG81cFRhZjZUdG1leXdRK04yV3VzMmZRbEZnN0NiQ3doZTVq?=
 =?utf-8?B?UjVST1ZZaDdRMWJRc0UrcEZ5NEJDMDhLaEpjRnVzdDFUQ0RtSTlTR3I5ajdw?=
 =?utf-8?B?K0JRRGYrYkdIb2s3d0RCYXgrUHZGalQra2h5OWFrK3hxMXR0WitsejRLQlky?=
 =?utf-8?B?ZVdaYk1OdHltSlVUU3hCcVBORUZJNUdGZGwxK3FMaDl2MnBGTDgvOGhRS0Fs?=
 =?utf-8?B?RDlpdnpVUUhaazNRWG5NdmVpNkRNbllhK3lwRTFOcnZqc09YK3cxanJBUGtr?=
 =?utf-8?B?NGRweVN6QTZJU3MwR0daSmMzWG5EeCtQU3JmWVJucDc2VEZ4cFZ6RDRuS053?=
 =?utf-8?B?eFFNLzRNbWZhZC9yTnNzS01ETmpUcGcwbUNpZU1YVnlhRDdyUFJmaitveDdM?=
 =?utf-8?B?bWdpR2lIRXVyYXNJLzBYdVBXMWlNaGNRbk9zQkoxUU43WHdzY290YWVKemJR?=
 =?utf-8?B?VTM4bUd2OWJKa0pVRm5VU0F4SURic1Q5TndEK00wc2ZWUk9ra2dydTloRXlp?=
 =?utf-8?B?bkl5c3BZdm15T1c4QUs3bGhYVlNXbEVxWDlMbzJ5R05oRWZMKzVtMEdoVTl3?=
 =?utf-8?B?Z3M3WTNvRnFhZzFEUUQ1L1pBSE9JdlNQeHJsdnlpQ0JLdCttYkExU05FTll6?=
 =?utf-8?B?TjFhNSthT2NSN1dZaHBTajJrQk9CNnY5cWhEMkxnMnExVkt2WXBGWkpRNFln?=
 =?utf-8?B?OVJRWVdWNlhvNDdxT0o0QVJrMGhieGQ5clU5a2pKaUQ3WTYrMm5GdDBqWWhT?=
 =?utf-8?B?VTh6SXhJalBZZEVnZFFxd1AxbEkyUTJZemYydkxvQjNJVFczM080Mm9IQ1B4?=
 =?utf-8?B?aTd5N0VLS0I3alFFdWZMV3dkS0hGTXhabjA2bXJIVUhteXNvY01qNHdaUG5J?=
 =?utf-8?B?bCtma3ZOUytMQUdBZlRUYWJMNDVGNlZMSWl1UXpBVENXK0ZyeHhWMzg0bWYw?=
 =?utf-8?B?Ujh5WTZWMjRiQmRvNmFsckg5K0ZGbzlKZE1ZTUd0VFY5Z2M0ZGxqOVMrdHdG?=
 =?utf-8?B?ZUgvQVVaT011NUN3ZzdmMGYzMW9jL3krN3RmVFAwdTVwdTQzSHlBRG5pVkhw?=
 =?utf-8?B?bndjVVVrVkc0bTBwSldUQm56Zml6Z0I3eUxhNENBcTF6TmZubUtkdjVBMDkr?=
 =?utf-8?B?UTdkQnBheVhPMzhPNmZ4SGVtV0dUQ1JwOTdnTDFNNDZGU3JUUEgydmoyUmtP?=
 =?utf-8?B?V1hRekJIKzJkYU43QTNIekZSSU9nT3lPT2pTU2hMb0pOTldBbmFhNUJReVBZ?=
 =?utf-8?B?ay9QQldXbHVMRXdTelE3aVdWOURMQWkvK3JYL2ZqWDk1Zzdac252OFJHajFu?=
 =?utf-8?B?c0tpTEpNZ1BHeHNaU0EzemttcHVPMG5ZT3Q2cUwwRTBUSXEydDlIelh6d2pk?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f223de2-012a-4b5d-8945-08dcb889cb4a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB6828.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 15:41:54.2097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TA+FpnnAdoe9ZzrUCTtRZ/8JuiaSk9sL6r4rBgKlnjeZgwifJFSxdoa5dYvdNEzCYwR1KJDJFQHWk2P3yEWE4OGhwwn7yy0Hunqbtjyqok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7838

On 2024-08-08 23:37, Greg Kroah-Hartman wrote:
>> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
>> index 8502ef68459b..72cc51dcf870 100644
>> --- a/fs/kernfs/file.c
>> +++ b/fs/kernfs/file.c
>> @@ -479,7 +479,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
>>        * It is not possible to successfully wrap close.
>>        * So error if someone is trying to use close.
>>        */
>> -     if (vma->vm_ops && vma->vm_ops->close)
>> +     if (WARN_ON_ONCE(vma->vm_ops && vma->vm_ops->close))
> 
> So you just rebooted a machine that hits this, loosing data everywhere.
> Not nice :(

Well, apologies for that, but there's no way to know what every single machine
out there is doing...

However if this machine is using ->close when that's clearly marked as
unsupported then shouldn't we fix that?

