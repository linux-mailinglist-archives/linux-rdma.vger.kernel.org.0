Return-Path: <linux-rdma+bounces-8628-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BEBA5E7A4
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 23:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C35D18998C1
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A64C1F03C5;
	Wed, 12 Mar 2025 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xm42qwVD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00E8282F1;
	Wed, 12 Mar 2025 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741819749; cv=fail; b=KdZi5sjgPIOpHqDPjwXtjBM8W7T/hYcg92kW8kKDLGay/hMwaab8pltLEi5G18cyxa9mcSRlyssCiTxznUSVlDs8LF//jSn7OKddKT39Xuf1fStdW9nE3vSHdflm1Ml+bHIYXMqGCcJWA1oF/IwyhRGDGA5B7IcERpiipWcbXM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741819749; c=relaxed/simple;
	bh=zAJhUfLcnU7patrS49i3sDp1Hw2xuLMq9/CLYbnrpag=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PqNLzpC29x68NSlkUoa8vVcMaWnayCMINpupxp/NUZxqdVm7oomHFOlU5rg+8lMG8AlS1e6m4PDBcoh6D735d72j9ayrWovmIrM5YO4cAgpkyRwgrJ7mJFpyaTFgiXjbJCimTTkKYkW5ZoRWOLha43+R74T+twlRE4gHZGbKMRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xm42qwVD; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741819746; x=1773355746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zAJhUfLcnU7patrS49i3sDp1Hw2xuLMq9/CLYbnrpag=;
  b=Xm42qwVDQm7a4O94T+rmv1Og9nv/1DwQWLZMClN/zoT6fckaSfY5difC
   4ZK9DyoM1GH8lYxNW2KFN+ZTSOMyRzHIKkHj6vQWcvm7r/YB7cX4neWOB
   6OuJlFXXuuemJzUG9VtWVIHT3ivkP/yzSKfyxDAMA9j8INcrkIDg6Aocp
   4PImqZLswKCRNCdmG++IicyMdHYs21GezcXBJu5J4eyd4Z0UWXkgvx2ME
   6rtJitAjReToCq7N9ppY3Zr02TUQWkKcDMtYVtG6baLEvKKjoJ5X0tjzp
   sWn/Lt/r6uU58uR3w66pilO57FKHOVUfLhpi9QSJiPgLJnQJfzrbJaRtX
   Q==;
X-CSE-ConnectionGUID: u3vHE784RCWbKjlGQ6hvlg==
X-CSE-MsgGUID: zS+BahNTQvCRto/jzskTtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43102227"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="43102227"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:49:05 -0700
X-CSE-ConnectionGUID: 3O6bXKl6Rz2TLvx7WflePw==
X-CSE-MsgGUID: 3NoPh5gsRu2TtGzGVXPPLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="151599877"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:49:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 15:49:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 15:49:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 15:49:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmNSiiliX82hQGugrzQMpvux1oswKO3nK/BLlZOQ0FoaygW7WP2SSLTGoQo2G5EdKVw0qT9OyDGL0uJklO47sLj5k1S3Vnld2ZLwJmGFX34mnt7Odt1Z1tPP6pjA3qfX6qgxP/air2dzuTQdxwke/h4rmQu3iXA/H0bSOL5qMnMyUxBNYIFZRQCORJcxmGozA8IgHRq4QrBqz/pyW5FhvCP9Ksx+O2rfj88Zs/RlGRG1sYjgvavRgEtex0PSr+qcjllYno/QGpx27XbLffit/Y2QfB8G2QVWke6Fyg6G45DPAvmBEo6lk+Uda2O0UvmSkS64uHQD2trXttdf4q6X8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqP1kS6DKHQU8NTwdl17rpT5uhQUkDUMXhK00e2Zcjk=;
 b=yn0g3+sLkLzmkV/hq/yGKIHGmUZ4uIMat8qZ2w7LReagjK+1MhlOJTmWn58DGl6UZ3mZ+LV7KO94gAyHUGNsJo9YvNRRuedi8eF1pQ5XNNA28ghFCsx0sK6O2HMUerqwsZDCFZJQV/MlHG0/kLSN8enYxrr99VM0TY+nuoc8yUmEtMZBuKGv6XcURwuVcVXOJctIxMSmo26LdxCuEYUBJgr2p5ezVJNkbGVBQuJEe6v7ZhUqDiXXEJhUFHhZS7Fp4oi11yaVIxeuMADMOGi+A+LAVJFFMjA9PImCrzUtTx7/Dw13PjilhKnkasosdbxDvjglJarzR6H8yTCKgGl/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5283.namprd11.prod.outlook.com (2603:10b6:610:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 22:48:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:48:57 +0000
Message-ID: <9c09dc9b-f007-4494-988f-9157720feef7@intel.com>
Date: Wed, 12 Mar 2025 15:48:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net/mlx5: fs, add API for sharing HWS action
 by refcount
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1741543663-22123-1-git-send-email-tariqt@nvidia.com>
 <1741543663-22123-2-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <1741543663-22123-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 5183fef0-6902-454b-1647-08dd61b812e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U04yOENyRjhsZ3Z2dXdPMG02ZFptOWE0YUxlazN0MVg2Z05hYW1aRjMzVnIx?=
 =?utf-8?B?cXRFQ0NseE44dFNpalBFWmcwaW5zb0cycFhFeWxUYThpSUpqVFIrMEpobUZW?=
 =?utf-8?B?aXc5c0Nrdi9kc01tZnBjUmFtcWNBcXB5bUowMXJPaE5rdnVsb3U0cmJNQVJq?=
 =?utf-8?B?ZWZhSC9uUnBCMXBiMkYzK01QeXY3WlI1ZE8wM1R6dFdVVXEvKzE3ajJjUmJJ?=
 =?utf-8?B?NVVXNnI1bjZoQnlPY1lENkV5YjZsWXBkazVDUnVhdUh6NHB2VUxZR3dVakNt?=
 =?utf-8?B?M2NhN3lqaGFwZEg3MkhmQ2VobjlaZE5XVXBDeElZVGRzSWt2NU90Smc4YUx1?=
 =?utf-8?B?OHBpK3BMaHdSNFVySUYxOXJmRzlSQjl3VDZveFNEOEJDc2VCNTZONWEvTHdE?=
 =?utf-8?B?MHFpQzc4R25KZXRtR0V3R3NEbi9KK3M2UmFXT011SVpUV0ZVamh0VU5aZW9H?=
 =?utf-8?B?T09uY2hSMFFacjhYR1AwbEJlbWU2UVRSU1dmOWdwU0xlcTV1MDZYcDNPSjdU?=
 =?utf-8?B?MjR6WTR2UXFqZENTa0w4WUVDQzAzbUIvbmRyYkk2YUNoK1BMNE1kQmxodEdh?=
 =?utf-8?B?OFVpQlJWMURKQ0pmcVE5elZMU042MUYrKzZwellWd2czYXc5cDlKb1hiOUJy?=
 =?utf-8?B?ZDdtSzR4WFVpREpuMUVLL1FLTXdwbzhrbloxSGkrWmRTblBBZlprQWdNcTUr?=
 =?utf-8?B?NHo0blMrYXh3TEhUSnltSFk1QkZ0Mzk0UE5hR2lyUmFkUy95UVZrWGZSbTFZ?=
 =?utf-8?B?NGxXSVRSVmVqVVV1clRpR2Z0bWFtMFN1L0pYVThubWxMSzR0THBDN2h1NTdU?=
 =?utf-8?B?d0liOXgwbGVIU3Z6dzlyK1R3OGJCbURrZThCR1ByUWx0MG5vc3lYeWZVaE1O?=
 =?utf-8?B?TXN1THlRVStNOTV4a0NQYjd2RXdjKytsaDNQa0ZVOU1tVlFlMkw3WTU0NzhU?=
 =?utf-8?B?bnN2eGhoaVYyTnRtc3FSZWN6dHloOU54ZmdkenRjY2dFaEY3YVhjOVY0U1Nz?=
 =?utf-8?B?cTY1RENrc2xCOTlGcDJVNnlzUmRxb2s4b01Cc0xGTisycUVtV1A2NCtETnNW?=
 =?utf-8?B?ak85UE4zV0c4OXdhM0t3cHZkQktwdGFjZFlrTSs1MWpVNXRvVGJCa0FDRWRZ?=
 =?utf-8?B?eURBZTNsbnB3N2hqREVmdnFQU3JKa3FUUEVUSkhYWlhVUG0xdGNzZ2VsL3Jx?=
 =?utf-8?B?anZBSE13MUJyQ0huWms5K09oQk4rZzZjdjBhMTVzelI3eldyOVd5dzh3TkdN?=
 =?utf-8?B?YXU3RDh5aXJxOVU4N1JDSXlGbXAwR0FNUEQ2b21xWG1zOWFPZXN4VmhzSWZQ?=
 =?utf-8?B?bUczaEFLYUlxTXh0ZDNOdWFQdGpxWGFyaTFsZytIRVUrbTEvMzRONC9nZWtO?=
 =?utf-8?B?d1hhNWttMzBIZEkrdFNiOVJMZTB6VmJ2aGdiT0FrZ0FGNGlUWFZ1NGs2UGZ4?=
 =?utf-8?B?alczTU1qMEZuSUpWcldEZmFLeFJXaEFBYk92cG1Pa3FHRS9MZGo1bXJrVkpC?=
 =?utf-8?B?d041VWRyMmw5em56MFJMMmtRQ3c5Y1A3cERRQWZ1ZkVNSWozbGlmTlBpTzdG?=
 =?utf-8?B?OEw2ejF1ZHEyRDltWVVuU2J4TDU1UGgrVHpGU0RaaDRzZ3diSzg2SlBOZkRB?=
 =?utf-8?B?S1dRYk53NzN2dGFSd1RheUJLOWVXZG1BeXZHUTVpSEJ2RTAzZGZRMHNMR2hz?=
 =?utf-8?B?d0RpYXlmUnYrZmpNcG5oSVJjNHYzOFdGTmhTNExYQW9HdDRvcnM2bXVGYzdP?=
 =?utf-8?B?Sk1FVGcyYzR6cGp3aU5qSC8vK2FZYjUzYlR4UjlhUnQ0aENmMGxoY1JNM2Zw?=
 =?utf-8?B?UXN6ZzNGYTd3RHhyallncDYyb05uNU5TOHNjN1V3dHlQVlBnRW9WcW5CSCti?=
 =?utf-8?Q?7QZeMeR88cpQ7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWtGeXhLWjNGSENnTTZvZXRsTnhyYW5GZEkySXhaZGdmUGxTdlRSSDl3b0Vx?=
 =?utf-8?B?ZDBzRHNLVWJneE5TTml4MHdRN0luaGF0NkpYL0p2cGJCWnM5V0Zjenpyb3R1?=
 =?utf-8?B?eGpGMkRVd1hVVTVOZ0t0Y01XYjVjamtqcy8vRktaTlpPSnU2NnppYTVXY0Fj?=
 =?utf-8?B?Uy8wcWhtODk1VzJ5ejVaaXdZRTNHeE83NDVEemw2NGRhYS9Pc3FMWFQ1N1A0?=
 =?utf-8?B?K2xWLzl0NXFIaTMzZEFIRVBxRmtiNWw2SFRUbUhGcVFWTjNiM0ZCdy9zTGp2?=
 =?utf-8?B?VWVsd0FUTTJDQXMyS0JMeTVMRW8rYlZjNXpuem45ZzBQQWIvQzJTZWVoZzBC?=
 =?utf-8?B?M1VoL3VlVzFuM201OXpwNVduNDBFaG42LytxSGlsZDlaTkJaMi9HMi9haFhD?=
 =?utf-8?B?WGh2VHRmZ2NlN0dwTVNTU0lJaWlnNm1kOU4vYUlWaUlyNVQrRXMvVUhwelRk?=
 =?utf-8?B?V2tINk1BWEs4MFdycEk3dW85OTZ6NHpsSHlDRTRwSmNCdjc1K1k1WkQwTXNT?=
 =?utf-8?B?NFR4MHFJZEpTc3ZBWFZHREFFQzdLZm9kT3ZiZjRIbGtnRUhCaFY5Wm1tWnM2?=
 =?utf-8?B?ME12Sy8xdFFSdmF3bDFUcEp0UzhMVUZYaWhHcFhsekl6bGNDdFRpMzRkQTRj?=
 =?utf-8?B?ZGtCM3owVXVkd0VVTXNCN21WK2REQnR1OStUQllleFROOHVSV2FIdTlQcmtt?=
 =?utf-8?B?ZkR3MDJiZkUzUmx1WUpmNGUySWZsZjI4QnYvYXRybERLdUVuTGNkeTZCdUJW?=
 =?utf-8?B?S1RqWFZqYVlFc20yYkpYOWIzdUN3UmdhTWN1ODJ0NFJjWWhMaFVia3NBcHJF?=
 =?utf-8?B?SEFwNVhpTnBCU3VONSthNWZWWFRQbU9qRVRRZTVxeS9ublVwQXY1L1AwNFZ3?=
 =?utf-8?B?RTBoKzBFbXlnb2RGdXM0OEpFUVR4TWJ4QXYvQ2RPOGJyZGt2cjU3TXlkcWJs?=
 =?utf-8?B?c0t4U25samtxYkNnNTd0aU5XV0ZUek9mdlZvK0pDUGtTd29IdGwydDZFZE5C?=
 =?utf-8?B?MW42VWNCaFN2Mnl6WGVBYVNCMHJhT2sva3ZRcWdIQm5zMk1OWVcrWDlqc0M0?=
 =?utf-8?B?RzRFZnZHUXkvMzRSWWZXbFl3eFlueFF3cGZrcGQ2aHMrMW03QUJqTXV2NGxt?=
 =?utf-8?B?RjNpdUIxNnYvTnA4dXNGVndqZklWVGQ2YjREeGgvYW8xTHFsSkpuZDlsUnB4?=
 =?utf-8?B?NWNvN0pBSVpXK05BR2tRS2NvNUFyTjNzWHNzSnFFSXBCbG1PMEVrRS9lRnZF?=
 =?utf-8?B?QXJ3VGxpQmVUNjdIYm9qUkJld3NLOC8rL2t6MnNGMDdhQU9VZE96NUNKTnNG?=
 =?utf-8?B?ZGZqcTNkQmIyRklhY01LYlNCQUR2Y09sSk9OOEVaZURIWjFNNzdBNVYrUWI1?=
 =?utf-8?B?V0dROXJqMWhEWTVpd3g5amQzUGZndlZlcTc2NGZHTG15K08wb3Roa0QvR00x?=
 =?utf-8?B?WS9IWHQySTJpN2lkUldUME8rdlRqSmNiNDJNVkliUm9IZUZmbHV5cGFhSU9W?=
 =?utf-8?B?dFB2c1UzNFVua0wwTGJ0TjNETk5CNHlxRW5oWm10SkY1cE1PbmhTSVhqT0hG?=
 =?utf-8?B?bVRyV3RXdUk5cytaeDBsQTFCUlBrK1hyS21oeFRYOGJ6T2RVeHZ3TVhDR0d6?=
 =?utf-8?B?QS9WZVdIbVRGSnE1UHBqQkxIMFlWK1FUK0RpcWNNNkljZVJuVEpZZlRvd1Mx?=
 =?utf-8?B?SWV0VlpSS1dEWXVEL3ZDTms1S1FhdloxaktTT3hmMHFMcU9zVFJ1ZGJaMGc4?=
 =?utf-8?B?UzdBaFFBN09Fcm51bDlHY2MvTG13eWlNVGJQVUxLd05Ia2QvNFdyaExML2E0?=
 =?utf-8?B?UGRERFVQVnNrSDNyemhyS3pyLzFvOVRvdHJFRG5Id1RoWk5INHVqRmR4cWVr?=
 =?utf-8?B?R1g4L0pwZ2xCRjVRTkFDU2lURTRRM2hvTmN4S3RmbWlqUlhYWVlRdUEzNWNM?=
 =?utf-8?B?ckFmanVFeW5GaFYzZ1pzWmw5V2srMGFMUHhtMkh5KzdXdk16Zitid3VqVzZN?=
 =?utf-8?B?dWhXM1RhQ3dwUVk4WEFnYmg2YXFCekorNkVqMWc1M3JsR1IxQlE4clU4OWhh?=
 =?utf-8?B?aURDV0xwN3MrTXhhL00ydzVBZXhTVDdhZXo5K3QwMXNXRHU2MUhtQnQvU29t?=
 =?utf-8?B?Tm5GVTNtU1RDNTFpWEk5U1FYTUdjVWZsUTIyem05RVNKTVcyWVlnUHFYakMv?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5183fef0-6902-454b-1647-08dd61b812e6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:48:57.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCTjlWn6I/OkqPLxsLyIWaxEJPmxA5U0SznLCLuFjwBVEgBQgIWnHlCPB41DZIbtg5iwx2QpquRJBR3gRYUA7hCBy0AWiwAnraAaaRG3EbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5283
X-OriginatorOrg: intel.com



On 3/9/2025 11:07 AM, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Counters HWS actions are shared using refcount, to create action on
> demand by flow steering rule and destroy only when no rules are using
> the action. The method is extensible to other HWS action types, such as
> flow meter and sampler actions, in the downstream patches.
> 
> Add an API to facilitate the reuse of get/put logic for HWS actions
> shared by refcount.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

