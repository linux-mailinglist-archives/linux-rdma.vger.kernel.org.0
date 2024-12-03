Return-Path: <linux-rdma+bounces-6202-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E489E1E9A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 15:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF340163AE0
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 14:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171B81F4277;
	Tue,  3 Dec 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4bTc6kw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432E1F130A;
	Tue,  3 Dec 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234631; cv=fail; b=YsZmrOa/cPgxqy+lHJHyr5tqxPpC1crhN52aBAmPQpe3Wzi+VWMC17Ys7xxq62NtYpWAzMhBXgPvv3Wgtm/FnH0B2LI70rvba0LSEpVntbgb9KnvQ0qTb0nvHVVuzckrUINVo1xo+oDJ8HW1PIHJCg99H5qj4iIfnDh3qMsQ288=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234631; c=relaxed/simple;
	bh=MpXL99JeVNO6tvIuSFPXa6O1iBxbcRQ8KH+NgKYnmfE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ueqkKoMmPVOWPAt4r4uSan/aHKMKdIwa7Ho3FqzjUNSdxrQ/mY/nlwIGp0IvPOAvFeGGxXmh75SMqR/qRK83CBginSMoNlF/aUgLT/z5D1Z0L7CxNajlLBcfLxfF7Ysv5EUbQuOBv7jYa6dyYT1qxZS2eCaZodHJrGtSW1x1NiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4bTc6kw; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733234630; x=1764770630;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MpXL99JeVNO6tvIuSFPXa6O1iBxbcRQ8KH+NgKYnmfE=;
  b=U4bTc6kwI/3yNEZAHSzctDKh1RKpdCyUtFWsRx/qPyvpr75IA0wS5EQ4
   gIKIGeIWaixh9J16zbE7mUWvCjirE/C5DK9TRi5jzsACZ5ULbM+ML/PDo
   MiYwlDDullXkctMl3ReZi3JsHFfOOjytONsFkkbWXWemBVuDrojy92RLu
   NWOGaucvrxioRYungmZqDdbhlkjvosYYEeCDcmMJtfoPQsz+giSXJwsZY
   cHaLX1jdOkmvSJZSFO/RvhPoK7CWUxkVODmkC7Tk/W6cZCP/cc+iD/u53
   NpYURhF2704M6OIfHBUwo38Y+G70fNk1XzUQfTRn516fR0XObSidiyG+E
   w==;
X-CSE-ConnectionGUID: tTlyF72FTl2xBAbLC+sjRA==
X-CSE-MsgGUID: jZnHDZgOR5mFHgEHNeeTEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37104187"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="37104187"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 06:03:49 -0800
X-CSE-ConnectionGUID: QxVic9dzS0GnaYcdylOofA==
X-CSE-MsgGUID: uJzHR5qdQMyR8K7Mr20DvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93777187"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 06:03:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 06:03:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 06:03:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 06:03:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huZnaIhY6DnrfhbOghEX8Iy440h1hdpB5qzooZiZt6hZFgTdir6cvsLyfTwTIbEj9n0jGANjYSmTGivO80GSn8KljnicDg1vputxxMzr9pGphvEoOzh6OSQauQADGI+99dApt5E5Fp/CFBN5ZHnYdCkfavjyoCIdiIWrC5SVBhEIBe2dOpbDJyj1hgo0th0LHMpNS/P+uoVIkHFyhCm++r3LmOzE/g/OTCOhSEAdTFEuwbGQLJH2Wpp+VxwIfgM5THeobMV1rKxpsmeqEMiopLxDHM0uP495UMmCC+0swX7sPibK3gKZXAHSNzMN7sID84QwzwCjUjZtvTAbkF3tbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8c8sDCMQ2yVVwxV5MCphcWGM47n/gCLm8srg9feQsY=;
 b=Cdaq3b0Km3qh0ggLJIhb5FV34uQVvtuyEmrZHxviGXmnyP1KGobCP2CrkDd0wugWAchTLZtKJjxI23SKQ3/1NojzpEp3LfShDTI0qm2fuP5GcGFdx9z0CCXDNOqS4WRjKMABf20MBRczN9lUgm46I8T0IRITLtMa6L1km/mhg8ayg74BvToDlplk1M7T4gZ0tRVkDWD0DOe+5xVMobCSgRrtMAh94YIoHUhSU5xFWWVPRoRlsLwjHCziYkhI1n7DDpqMiYw9/gafRhwatN6wDi8tJZkIjaTBDe2EGTX2xseclNt6d+7iYf4qIvp0ykVwMRSbMPtEyvdMOFQWZZpFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by BL1PR11MB5318.namprd11.prod.outlook.com (2603:10b6:208:312::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:03:45 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:03:45 +0000
Message-ID: <2ce19a4c-be46-409e-95b7-49a7a0fce3ed@intel.com>
Date: Tue, 3 Dec 2024 15:03:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next] RDMA/mlx5: Enforce same type port association
 for multiport RoCE
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Patrisious Haddad <phaddad@nvidia.com>, Daniel Jurgens
	<danielj@mellanox.com>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>, Parav Pandit
	<parav@mellanox.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
References: <88699500f690dff1c1852c1ddb71f8a1cc8b956e.1733233480.git.leonro@nvidia.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <88699500f690dff1c1852c1ddb71f8a1cc8b956e.1733233480.git.leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0186.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::7) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|BL1PR11MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: a423aa42-6861-44b8-4937-08dd13a34d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlVxT0Zxa01lNUgzNmVKalF3d0VsRVJlVmduQ3Q1bkV1cXVTSVZMaHpsRGNO?=
 =?utf-8?B?Z25zT0dlSTU0RmZvVTFWMGI4OTNUUXFkbmE2bGZ0RHdQRDdRVHlQOWMwL1NP?=
 =?utf-8?B?M0N2YW53ZnArVzRaWHRRVmtkSGpvQVNRcm4zTDZpcTdvNGxkQUtmbW5RNW1z?=
 =?utf-8?B?VzllSGJDamFoVExRVzh4MXJRMFduNDI3U0ZNbjhoQXBQWnNPZWp6c2pHMWxV?=
 =?utf-8?B?bGFycVlIbVJlR08zdVYvRVFLdGd1QWI3dXJ4M2dpNEtFelNCWWVMd01oMzY5?=
 =?utf-8?B?b1BSbjVtR25vcHFWN0R3aHBvQUJDQ3JBRGZTQWE0SHdndUlXQ2JUclJ2Y2lM?=
 =?utf-8?B?ek9LaWdZdE1hd3d0YmEvRlR3MTRJNDh2RkpTZGdWS242NlpQTFo4V2RaM0J1?=
 =?utf-8?B?SjZHMk0wRXdpcllXUDhSL1hyc0gySm9JUkRMamM0VHQ0a3V2bXBWcDVQeUE0?=
 =?utf-8?B?cVR3V0FSZFZZSDlxNEh3YmVxdVAranhqVmVqQWRjTEIvTGpJSWNUWnRHOHBm?=
 =?utf-8?B?MWptVEtZditMUUQvSjRVSnF6bmNEdHRHbml4R3pMMHNqK1ZoQ24yaTVzY3F2?=
 =?utf-8?B?dExyVG55OVV2cFc5TDk3STJxTWZnbmZERDdHcnBWVXBmR24zTUk3NHlEUnRQ?=
 =?utf-8?B?ZGNUWS9QTzZiWHNaSHlXQVNpYmU2aW5XZ0tVMXljLzEyK0xZV01TZGRGOC80?=
 =?utf-8?B?ZWdkcVV4eXdqcCtNRURlN01ZZEV5cVh5ZEUvMmFnOEswSTI5dzh2NlhJODdv?=
 =?utf-8?B?SXk1OHdkN01EUGgxRVVEMmpabFVCRVJSblJGbkIzcmF0ZkVLVmluei9RUzhq?=
 =?utf-8?B?QXpxRVg3b2g0d1paYVZxNW9CRHkwZFF1UzJubFNNM2R3RUxGcTVlU3ZlbHRF?=
 =?utf-8?B?OGJWRmlQOWZrczVZblNNMmI1bVRiUzYzZFNibFZmTnNsOHFKRjhCTlpTUU1x?=
 =?utf-8?B?RWEvZWpuaHhNaCtiU2M2dGdsRVoxQTMwSC8vcEhoUHVTN0VvY1ZrVFUvWlc5?=
 =?utf-8?B?REZtRFY1V1ZkWmNvb0x5TTdwSUV1WENGMDhhYUFaRkc2Q25zRGMvMEVhSjVP?=
 =?utf-8?B?bHg2QjZ5Qms1cXFyRXVCWC9Xc0p5czdVWURKZFJrS05IUlJZUmswTWVhRTJG?=
 =?utf-8?B?Y3J4TjFQSngrU0NZcFZHOS8zMnh2WUExRzlnRW5NT1duR1F6aGhUcVdVYVlY?=
 =?utf-8?B?U1BQSTZKKzZ2MWtSQlhOTkI0Sk9TU0VyMG5XbXFHWCtza01wSXNFZkY1bjU2?=
 =?utf-8?B?NGczZzJQbnVpcEJOTFBRMjNvMzM1eW1lQVZkaDdDdnZuL3p3bUh1UGdKRTgz?=
 =?utf-8?B?QjFsdlg1amF0ckIyM29WVnlPTUpES3E0UHRHS2VoVkFxM2lCUkdOd21oaWhj?=
 =?utf-8?B?SG93TEVsQ1UrSXlsaWkwMkhTdDd3YTdiMDdNOU5jdDgyNGNXZ1NHcnZEbHVD?=
 =?utf-8?B?MDhqa2I2VStJRW9LZVhUeEMyQWxjMXFUaisvK25MVzN1d2tQdzR5Y2pSSEtW?=
 =?utf-8?B?eVhZZC91NzB1alI4NHJHTjZWdXRDV0Z5bmJQdVUrZHJZeTg3ZnVJL1hNWm1E?=
 =?utf-8?B?bmhvb0dCd3d5akhHUTEzZ0hRR2JQWTRwY242ejBoRHZ4MzJyTHoyV3pCVjJF?=
 =?utf-8?B?UTRZSlF0WTAwdVlnR1lBZ1BKdkF0NW9lMXdBa2FsQ2dFWVBvQmd1cjQxWHBS?=
 =?utf-8?B?Z2EzaEFLamxqTldNR09YWm5lTnNxNHB4V0ZMUk5aN1dKdlJXUm8xK1R6Mi9L?=
 =?utf-8?B?U3luNFRSYzhYNVdyNWdnemx1dDZHQnJPbjFidU15RHduRkc4Rzg3dEdOSjZK?=
 =?utf-8?B?RXRva1ZnVmZnV1Vna05CZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3lRSmVzK0RiSDAvMWpCZGZLVzJmMjZ0NlA2UC8rMWRBQTQwUzJyM3BjQ21D?=
 =?utf-8?B?b1NxT1F6NmRqY3VmMngwdUFHL3dieDd1SXVWVGZkMU5rMGlhaXgvODRiRjc2?=
 =?utf-8?B?ZHE4Z1Q2ZC9NNWJTVCtEMWtic1pFSXE3cUdsQjgwOHNkK3ZzdDJmUjhZbFBv?=
 =?utf-8?B?dXM1SENWUGhTWEUrZGtUWE9kWllwb1B0Rm85V0J1TEdwcjN4cE5mUVJGVmwv?=
 =?utf-8?B?NW9MUjZ1cVc3UDVEbFN4a3c5T244NERQU2xPOTF2M2QxVHNzNnRrRWp5NFda?=
 =?utf-8?B?UDVVWWNSaDVjTkdSbDk4NDEyY1NmUmlhVktKOXJtaytiRGVOL0JBNlprTU1L?=
 =?utf-8?B?NGxWQWsvTFZYalA5KzJIbDd5VFlTT0hQRzZIMHJKcW40dEtCU2ZjM0pVdnJD?=
 =?utf-8?B?ZjhFRnpocTF2Q0hndUNNTUZxcGZweHNsZ0taUUY2bmtNV0FUNnJEUzFlQzVC?=
 =?utf-8?B?QjVQOHFVcUFhSHJ4M2VDTUxWaUcxS2tBV3NIN2NTUE5OZ0J2QjJCN3AxeWpL?=
 =?utf-8?B?bWFndUsxK0wxclNWQmsvVHM1OHNCcU9wTGZic25xYmFXcUR3dlJsWkIvYXUv?=
 =?utf-8?B?T1J2ZjI0cE42bHMxL0xaVW9vQndpdUlQR25hQnRWZ3hWc0hGZ2FsSU9jSTM5?=
 =?utf-8?B?Z3loZC9nNVVNN0dKcDJFdVQydGJ2ei9wZmNqQkNmM3orTlFRajZEZGo0R3Uy?=
 =?utf-8?B?VEh5R2dXL3JRTlFPMWxhYXFnQWJrQ2UyelB3Q1FOZjJnZkdOSzBRTHhvMmha?=
 =?utf-8?B?YXczNXVzVld0RHZzbGtWZHBFMUJUczZuUmM3QXEzUnRFdm5jaWN4bk8vdmNj?=
 =?utf-8?B?dGhkbGNRbXNEUDR3MUZEWExuV1BRZVdobUZtWEZTOFAwT0NPM1RJNUxaRVd3?=
 =?utf-8?B?QmdBRjB3SXZ4dEkrOTFzQUdBZFlKOFU2MlpzYmx6dmxqTGdidS9JZE1zNUlZ?=
 =?utf-8?B?dXRETGsreXUwS05IUjFOeTVTTHQ1eWtJa1VpUnFKbm95eE1PNWtHQUI0UWdu?=
 =?utf-8?B?a1laLzR1QkVVdHVNVFJadkk5WXJXSkVwVGZoKzM3Y016TmRoOGR2N3k2NWM2?=
 =?utf-8?B?T3BEODZGSWpmYVNFL3JGUXE3T3FDLzRwUlgyK08zcTRHaENFejJkM292VHJQ?=
 =?utf-8?B?aTJlV0p4dnhiM0VYeHA3cVQ1WEJHdms0M0N0SWdVZld6QWk3ZnhEbWJvNUFN?=
 =?utf-8?B?ZnAvQjl5YVF6eUpJU0I1Um9QOVU5cUF2MjBSSHl6S0lFeldjc3pUUzhQK2hE?=
 =?utf-8?B?VjJqeDlaTDJFQ2kwclNSU0IwNE5BTzhpalArTk5XMFVEdWdkZTNtdVVKWisz?=
 =?utf-8?B?Q3RHMFpuWnUwRmo1alBOeE1keHhWMHdkZU5pWDNvRUJzanl3U0h5VmJ3ZmN1?=
 =?utf-8?B?dHJOalR2Ymk0ZGRhcGY1M1lPVnpIVUlUR2NHeHFEZXJxZEZTSGZEcnlMZGdy?=
 =?utf-8?B?MU1BZUxQUmxXVkxXdzBhWXFhcHdGQmFIVjdpR05oMjhXNGpmSS9Rck9DdG1Z?=
 =?utf-8?B?aFJHRHBsTC9hK1lHRjZ0Skwvdy9LTXZteDBDNmFBTEtkMG5jYmRScU8wTHNP?=
 =?utf-8?B?bFFvTEtYRnl2RUlGRmRMK2VsK0Q4cVRqMlU1c1ZJMk5NbVBQZG40TEIzVUxX?=
 =?utf-8?B?eGZKVXhyQ08yU05PNjdwMDlzVmtFV0hodm5PY2s0aElZcEp1TS96bU82QzhF?=
 =?utf-8?B?aWNSWDdHZUQyaWV2S1VocVNNS0VSZEZoY1l5UkVsdUt6ekhmTjVydmJwMWc0?=
 =?utf-8?B?Mjh5QlkvMTc1eGw1OHVIM2JTN3ZTa0FXVVNUYzZiLzRxSWplc29mQlJIT1lw?=
 =?utf-8?B?U2drekw2MlhpRHczTE5MSVN3VUtmWDFDdDNWUmhLWHc5Sk1aL1FFYlA1VEtm?=
 =?utf-8?B?UHB6Z0xQZmtuSG9LalBSaTV5czJSbU5wYllSd1czTjZRTndQSjFVUEhXRzB1?=
 =?utf-8?B?MHdQMnlLMkMxYXFKNFFWelg1RnpvRFFkV04xN0NTNFpMQy9nd0RZUkRIT3hi?=
 =?utf-8?B?YnBGTjBuTEVtczgwckFKTnMvbnh0eDN6ZVZmd3JIdkNoTjlGVkl1ejZ1Ynd5?=
 =?utf-8?B?ZzEzOWlFdCtEWGowMklIcHNuZTQ0dkxYVXV6Tm0ybGpPckszVjdEcCtuM2ZN?=
 =?utf-8?B?OWxpVlNlc2prbVZsWGJ3Rnd1cFZjRkNHQmdmTmtXMXkwWllmZ0sxRDVuVGRS?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a423aa42-6861-44b8-4937-08dd13a34d2d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:03:45.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nkXFPaRKxRwvbfZKjaj4MxrAfeWgxnN9PZ4zabJ9ZugRkOWcTrDV6ozbz7P9UzbhJ4pniTHMHAZXHN6OMJGjs4aLNcQmg3O6lDAMwRcAP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5318
X-OriginatorOrg: intel.com



On 12/3/2024 2:45 PM, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Different core device types such as PFs and VFs shouldn't be affiliated
> together since they have different capabilities, fix that by enforcing
> type check before doing the affiliation.
> 
> Fixes: 32f69e4be269 ("{net, IB}/mlx5: Manage port association for multiport RoCE")
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/infiniband/hw/mlx5/main.c | 6 ++++--
>   include/linux/mlx5/driver.h       | 6 ++++++
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index bc7930d0c564..c2314797afc9 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -3639,7 +3639,8 @@ static int mlx5_ib_init_multiport_master(struct mlx5_ib_dev *dev)
>   		list_for_each_entry(mpi, &mlx5_ib_unaffiliated_port_list,
>   				    list) {
>   			if (dev->sys_image_guid == mpi->sys_image_guid &&
> -			    (mlx5_core_native_port_num(mpi->mdev) - 1) == i) {
> +			    (mlx5_core_native_port_num(mpi->mdev) - 1) == i &&
> +			    mlx5_core_same_coredev_type(dev->mdev, mpi->mdev)) {
>   				bound = mlx5_ib_bind_slave_port(dev, mpi);
>   			}
>   
> @@ -4785,7 +4786,8 @@ static int mlx5r_mp_probe(struct auxiliary_device *adev,
>   
>   	mutex_lock(&mlx5_ib_multiport_mutex);
>   	list_for_each_entry(dev, &mlx5_ib_dev_list, ib_dev_list) {
> -		if (dev->sys_image_guid == mpi->sys_image_guid)
> +		if (dev->sys_image_guid == mpi->sys_image_guid &&
> +		    mlx5_core_same_coredev_type(dev->mdev, mpi->mdev))
>   			bound = mlx5_ib_bind_slave_port(dev, mpi);
>   
>   		if (bound) {
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index fc7e6153b73d..4f9e6f6dbaab 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -1202,6 +1202,12 @@ static inline bool mlx5_core_is_vf(const struct mlx5_core_dev *dev)
>   	return dev->coredev_type == MLX5_COREDEV_VF;
>   }
>   
> +static inline bool mlx5_core_same_coredev_type(const struct mlx5_core_dev *dev1,
> +					       const struct mlx5_core_dev *dev2)
> +{
> +	return dev1->coredev_type == dev2->coredev_type;
> +}
> +
>   static inline bool mlx5_core_is_ecpf(const struct mlx5_core_dev *dev)
>   {
>   	return dev->caps.embedded_cpu;

Hmmm.. Looks good to me

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>


