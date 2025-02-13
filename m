Return-Path: <linux-rdma+bounces-7715-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07B2A33CC6
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 11:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0E618870EF
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 10:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E07E20B815;
	Thu, 13 Feb 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OT8GtHAo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A7201006;
	Thu, 13 Feb 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442845; cv=fail; b=K1cRUJ4sE0hrr1fhxYznb4b09b4B9/U7hjWe3L3LnXE+ujlE2ulmQzbbR5oOy1G+QhMJ/HLCyzs3xf1lla2GBKy7t68Nv6fGKwMduiA1ViWELtbqfSn/NCLC9lRVwMAdTBK1/967raPZXvZBzBIPpMcpyfFBBENYgeWB5NbmFJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442845; c=relaxed/simple;
	bh=wqmSsevL2WAtVmHgPy3Rdb+GMBPE/k1QEhOrkcjUDJU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hM49HHqI6pqPNNa9S87Cv62+NLo1YzFYiA07woL2ci90HmMkp1DUvhlMXoiXXd1qqHsjbRChUjgTSETNR/zlvuRIJ0V0Cqc2Pl40y2HF4zoZv7/4wp2SmHrAKalDgRKkXH4/oy9jGMDxqev0FFWcmmxRMc7JO41G4FBQfHBVpW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OT8GtHAo; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739442843; x=1770978843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wqmSsevL2WAtVmHgPy3Rdb+GMBPE/k1QEhOrkcjUDJU=;
  b=OT8GtHAoeVAdyf223M1PmLctvPTYQGHhtnqnp0iHUcGlSdU8YsKVy5mH
   rYEjOVl5Iv6JyruKJLn3w3rukDvACGR3ktAvshfbdNeaw7PgHhOFBS94q
   R4gIZ92zEp2ZVYpvZu13DBVsemejW/sd7dOwhallHVP6JO59n8lbds1Q7
   Hlb6OIb0VEO219z/42wkIO3qgqUpfppjAvUDbdN6OUNIMPZRifPylGVm4
   JXTS/7PMvrmQ85gv9SVdn8PzB1eI1rtC6gM9ZrlJ17rcfqvuDltJeUFka
   UuXG9OAl/ij7Bz6Qy3kUqF3nUydKu7K7gYi5p75hC7ZnoFKmIujrOjZPl
   Q==;
X-CSE-ConnectionGUID: SZPiOJ0eQpKsDj+6pWU78w==
X-CSE-MsgGUID: lS8zbPu/TcyS0mSSK+GqsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40259524"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40259524"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:34:03 -0800
X-CSE-ConnectionGUID: jgTwdAmGQgKtLYexeiFD9Q==
X-CSE-MsgGUID: OXe87Jw2Rv2d/DyclZVcjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113635507"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 02:34:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 02:34:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 02:34:01 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 02:34:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyMFjS5VGimppWizGL8zmKZmdhEjiZCETKYE7jirQjZZ+iumTRac1sn9BIgudZz0F5sdh25tAKr5YhsVJpQNSf3AkDeTmUT6hnVqn8fGD5wlTSXFCGb78wGnykR9IjIftASn+y7mnyiXAjxM7Klyq3w65InqpW4O9L8GqXGYheBnYFImAK0/V6JXbFyW3A7szYxxneOt1/9aCAJsXjN5oiYCrmjintkkoOd4ZbxgERcmfHEAbRyIX8oXyL/rc+TMAC4N2ZmTg8+ioQs4g/sfrrsq0v/rNMb7LsTp3pNPPtxoUn0ifVLXLkkr62fCL6sfn95p9FxpGqxJM/hAgpnSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBIdljD4dPuHFIXUgrONbH5ai3m3kPOHqaCfPdN0etg=;
 b=LAehEudkyMTkGaUo0WdoBCO2ZXJCdCzDdL2TndjC8O9/Tv8J7BZ8/7g2mPXN4U1SS3Ix25KJJgfiofjhc8m4z3u/1knBlS4gQn+IHtvWMH9UqwXFsLQ0lPK+SraZQQuJ7c/JFCli/wlEFj8KS1ZSDoktbdYzFfeMoV8UV6htSrdj09s9a7E5/Z+P/qbaKWrsQ9YpprUBby5gtboySoMAyZZa4hvafSjZ9ayfyjB6cvgF8VwcCeWSoWwpvT+LKj1Vs5MAIHvz3rexB5CRIHmcWDepWLnwdaPO45tvWrI5hAaGBryUbnXDDAY7x4PRnH+jlAqQWIt6/pGvbOHkMP307Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by MN2PR11MB4536.namprd11.prod.outlook.com (2603:10b6:208:26a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 10:33:32 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 10:33:32 +0000
Message-ID: <2807e16d-5770-4aa5-98ff-2285a7ea11ec@intel.com>
Date: Thu, 13 Feb 2025 11:33:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net/mlx5: Prefix temperature event bitmap
 with '0x' for clarity
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Shahar Shitrit <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250213094641.226501-1-tariqt@nvidia.com>
 <20250213094641.226501-3-tariqt@nvidia.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250213094641.226501-3-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|MN2PR11MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: fdebaa4c-7a18-4b3c-9acd-08dd4c19dd0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2V1aFpkMFB0THl5cUZSZ3pLbTFSMlBFeUY1eHk5bXNORExQWkZFQWJwVll2?=
 =?utf-8?B?QnFXaFNKWk9IUnRXa2NjZkI2NEwxMFNLd090d09ja09IRHNoWHlucWJnWVd4?=
 =?utf-8?B?cStzUE1ZUTRncHVzd2NTU0lVR1lIa1NIQ0pGNExDVSs3WFhTVXJMNzQvd0pv?=
 =?utf-8?B?WFFtRGNGQ3Y2dDZyanFEWk5IT1pIVnpuNHc5VlJScDhJbTZEaHIzVllMUkZo?=
 =?utf-8?B?cVB3TmJoUEtuRm1Ham1yYWZYSVdlSXVQcmFQQ0lsRUFTMmwwM3F0bFROb3Bi?=
 =?utf-8?B?WmFyQmNtS1NtL1RZWnVIVnBNODROSHRhSzl3MFZDb29KRGsyNlZUdDYyU01D?=
 =?utf-8?B?aUN4VGFOOUxRU3lFdEtyclNkL1dHOXZCZU9TbXNlbE9FV0ZtRjhzUTdFV1Zw?=
 =?utf-8?B?N2tHZXpNU0dhQUpoSm1qdC9ubDNhbXRmOHVNYjJHZ2J6QU0zTE9mdXNaeFNZ?=
 =?utf-8?B?YUY0dFFyVnpmeHRtUTNSNlBvU3FQOEhHNnJ6SlFscUtoM1ZGVG9vTHBwbUhO?=
 =?utf-8?B?Q2p3NnRkMzUyazNkdjIraWhxOWxyYWFLaU03ZTQxRUZxMnFtdmRqakducjhz?=
 =?utf-8?B?TDV2MENYY2t1SVovM0F3aUx0YXpPU1BKN3d1S0t3czRWMXpPVXN5SGxRYjB4?=
 =?utf-8?B?S0RIUlhXaFkvaWJhRDNGb2NXY3MvV2g5T2hBZlp2aXRsMFpURlZnM05YSDVP?=
 =?utf-8?B?QmxnbTY5YjFpV1F1ZU5qVE05dXc3WTNsV1huOFZjNEw4bEJBZmpiY01WQWdu?=
 =?utf-8?B?WjB0UE41aEdpdDRVNWh2T21kclRYNTZBQjZ0ZnNkY24yUHI5bmpIaEZGZEpI?=
 =?utf-8?B?WFM3eHRITitEanVzaHNCaVQ0ZnF0NW9iYXVPdnpKblMzaEsyZFNwZlA1ckd3?=
 =?utf-8?B?SU5uU0lUU1VaMEdhSXdsWmhIRVhkSWxrRVpTS3Z2cnU2Z1JiblJSV3FjSWND?=
 =?utf-8?B?ejRQa2FlY0VTSG42U21ueUpIYTA4MkdoN0VTSi9XWTZlMXVXNnBGMzIwaUtM?=
 =?utf-8?B?eWQxek4zRWZOc01qbWp6REtZYkVFZzVvOE10d285dUJTb3RRREVtZk9SdGZG?=
 =?utf-8?B?UjRZVEJmUDdtMmNyUG44bjVoNERZUzVRcGNiWFU2eDFQWkNLUmtPQmh1emQz?=
 =?utf-8?B?SUNjdSt6MmdRR21ocUpLS1ZSM2Z4WXNBVGJkaXNTTkVSOEwrS1VRaFhKUjBE?=
 =?utf-8?B?cFUxaytiU1UxMU5LNURxM3hhV1JoZjJ6Q1NaSG5BelgreFdYeHZXYjVuS3A3?=
 =?utf-8?B?NHVlTzdTUGtUUXRTcUZDR0Z5Nm84ZVIyaUFtMm9nUG1oL3JQcmNTcUhuNEpl?=
 =?utf-8?B?NlNiYWk1VElrWTQzL0g0eEQvYXZBVHV1STVkaWlMNjdqUVg0eUtRSkNhRFFx?=
 =?utf-8?B?enY5a2hoZ3oxUkk1ZmQxNjByRWZsZDFweU9aLy9kVXo2OGJpUlBiSWJPVko0?=
 =?utf-8?B?OVp5bUFPQ1dIRXNPTUFXZGtaSTI3VjdTN3dmc01ZRkJUSVBwZmpyd2FMcUs2?=
 =?utf-8?B?Um0xaFI1WlAwNnR1bXFEVVlXTWhFYXk4VC9XcjY3NGcrQXJIaWhvWDU3U2tJ?=
 =?utf-8?B?UnVZNmhrbkhDM25DRHdUMW4ramdmM2Y0SVhhTUtOaW1XSlE4Z2tzcHZnbC9G?=
 =?utf-8?B?VmF1NzZGbThxU05vd24zYXJVVkljNGpXL0F3UUdJY1YycnA3azVmZXJYMWNH?=
 =?utf-8?B?bnRUQkpVTzk2TzczeU5PcGRVUjRWWFVhY0Q4RGo4bTBhMytaRlUrbFlpUXZX?=
 =?utf-8?B?T1ZROVBwK0ZCTWFINm1yN1hlMzc2ZjA3b0ZYNXpYTWVDOGdPUFcxUFVyci9r?=
 =?utf-8?B?eFI5R0RkSzBOTEw1OE5ncTdSR0FFVlNEZ3lqUkdUK1pNbWFoWnl0emRlT0d1?=
 =?utf-8?Q?JwMs5z+XqatRk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy9oY04vcWhQYlAwcFplcVNKVTBnZ3VNOFVxVnZzd2FqRVEzYjNoNWRlWUxE?=
 =?utf-8?B?ZTIvSlVQanhSTE04UDV5Ty9xdWR0ejNndnZod2JlUVJSQjBTLzB4SlBSNVBh?=
 =?utf-8?B?NXhBUklGOXAya0dpVVZPL01HdmVIWk5JQnZyV3VRQzUxU2dWVWlPN3hKNjFU?=
 =?utf-8?B?REMwOFRBekFzeUx2TW9hcThGaVl5MHg2WlMvWG1vbk1qRnF1VGlrNEhKaW1j?=
 =?utf-8?B?TnNMNVZKRGh1dzJ0ZzBxUjZYT2FYWFB3NThaczhqZHBmdW5pVzA1c2lpVkQ0?=
 =?utf-8?B?bGFPaFJQaWhvWlRNUnR4NmppTDZ4T0IzZ0xpVzVBUTZXWDdwTGUzZHhqaU1K?=
 =?utf-8?B?Zm9aRnJPRkNpbXFyQTZ1R2VwUXZDM0ZTcGtxTUhGSXRvWmVQdTR5MnNaNWxy?=
 =?utf-8?B?aHA3bDJGN04zZEhMaHNVY2ZyUUZoYjduem93NlpUb0RRRm5CNVF6bjVEOEc1?=
 =?utf-8?B?N2pwd1cxQlZ1MXdhejN2YWdNTjd4czhockRxMjB0eUtBTWtEMTJYYythRVpS?=
 =?utf-8?B?WmMxQlVUWGFhWm5ucWtVUkd0VkFXMi9wYUZyY3dVVWFZelJJVmhOempDOUk0?=
 =?utf-8?B?aUVXZFJxMTVlVk93dkF6dW1HazR6dFgvZXBOck53WUN3WGpMVXkwUU9mcFU3?=
 =?utf-8?B?a3EvSG5rYTkvMWtJL1dDZU45WldwUmIwVkRsYnd6NUtvZFluUUZiR0RLMHhq?=
 =?utf-8?B?d1NHZUZvYThnaTUvMnhLUTUwcFFEZEFUeVpLYjN5N1hIRFJ2WUVWZFAwaURR?=
 =?utf-8?B?YzZTeHYwR3JyQ1ViOC9XWDd1WEZHclk0eFI5blRSamRQWFFCQjJlblJtZDYw?=
 =?utf-8?B?Q0NsYUp6SVYvUUtzOVBYMnRYdVVxVEVyM3d5QkRoQm9KUVpZRW5RUWpBRVh0?=
 =?utf-8?B?L1hZOCszN0syT2hYMXFLcGFwWWY5a3dWSVhrK2dZWTQxc0FXb2ExZzk2RmVX?=
 =?utf-8?B?M3FlTVI5Nk14THJ1bTFPdld6VHIvWGFnN29jVHpDMlhFL1lkaGlNNzdTV3Y3?=
 =?utf-8?B?di9IVlY0bWkzaHdEczlCTUU4UWdnT1BqblJzSG53bzhrQlI5WHVEbXl6OFZo?=
 =?utf-8?B?TXVxZzBINmNYVGhHb3ZNalllRXdNY3hDQzNFSDJrZmtSN2tjSWVzU1BMSEdr?=
 =?utf-8?B?eUtvN0EvZjREMm1iRTRKTEFUMTlib0RQLzd4bzl4cUxtZkcwVFFmQWFaQ1Ba?=
 =?utf-8?B?TGJuNERmRkFTaHgzd2pmZVQ3NnRmemlscndtbTNCaHg0N2JhSXlQTWRma0ph?=
 =?utf-8?B?M1krcTV3Z0hTNDlJNUpSb3dwNlVCZEpUNzIyNVdMQkphWHVYOGRDcWRXckNY?=
 =?utf-8?B?ZHJORmtTVWloY1gzZC9MWFRwOVMvQ29Qd3E0bUdFYkttQUp2WDIrZ2Fkb1Jp?=
 =?utf-8?B?S3ZveWx1Y2c0QUxHTUNoODlxNkJiWUN1SXpqQ09VQ3FiMFBVaGFmZThmM3J6?=
 =?utf-8?B?ZXB5VE12bnR1d3g1YjZmQmQ0ZjV3RmVqdTliM1l2Umh4T0luamQ1eS8yMEp0?=
 =?utf-8?B?anZiREtzeW5wWEp6a0Z1YnFsbjNwbUFRMzFONERlSHQxd3BnN28zb3NZZERJ?=
 =?utf-8?B?Z1dsQkdmQURaQmorUU44ek5TSWIyNTM3VllQTWZ5WlV4eVg3ZnpHT1k3Y2t0?=
 =?utf-8?B?UU5USS82SFI2Y3V6cjc0clZRQXlPamM1bnQvZkxWemVXY2RyU2t1ZnR4bHdJ?=
 =?utf-8?B?Z2tQeU1UcFRjUXUyK2UvQkpoYkhwNzRQeHpxV2M5Z3ZlakhSWHJnQThKU2hq?=
 =?utf-8?B?dURlUWgvejhvYkt0UU5KcmVWWjIrNUl5N3ZsbDgrU1pvSFhiYmNMSzlKOXZv?=
 =?utf-8?B?eXVhaVR2b05MZXFlMnFydytBL3lnTjAwZTZNNG9wNnRadDlaV05PQ3dFWHgy?=
 =?utf-8?B?dmJPeHlHUWppUW5KRE1kY3MxV2tjdVprVllnUWpTeUtXZlNvRnlCOHJ0Rmkx?=
 =?utf-8?B?eUc2MzBGOHRTVFpnTldlQ1Qwb21MZzRlNkFpT1lGeTRpQmhodDQ4eVdGaDRn?=
 =?utf-8?B?QkZVem9iUGRSZndNOTJZL2xWb2paYTZkUlVNZE00NkVKeGVSZkowWnpldS9Y?=
 =?utf-8?B?RkZGUmFKaHBxekVocWdOYmdlNUVCZXY1UDBOV1UrOEFQaXhoR0xFYzlKNnlx?=
 =?utf-8?B?cCtIdTlTYU1qV0pjMWdOcHRvM0RLZmlkZm1ZS3pmVFBzZkR5Q2l6bWR2ckZG?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdebaa4c-7a18-4b3c-9acd-08dd4c19dd0b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 10:33:32.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mkZzqxz5UiE7PIgTP6i36mz/ZsQKuO42s00+U726j9+coWnQ58Y5PUcg5CgUQrSo3bSm8KXCg/gAhbCNCJ4awKfscKTKPHdA8tx50lGpEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4536
X-OriginatorOrg: intel.com



On 2/13/2025 10:46 AM, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> Prepend '0x' to the sensor bitmap in the warning message to clearly
> indicate that the bitmap is in hexadecimal format.
> 
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/events.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
> index e8beb6289d01..a661aa522a9a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
> @@ -167,7 +167,7 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
>   
>   	if (net_ratelimit())
>   		mlx5_core_warn(events->dev,
> -			       "High temperature on sensors with bit set %llx %llx",
> +			       "High temperature on sensors with bit set %#llx %#llx",
>   			       value_msb, value_lsb);
>   
>   	return NOTIFY_OK;

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

