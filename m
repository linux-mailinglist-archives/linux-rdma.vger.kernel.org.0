Return-Path: <linux-rdma+bounces-7411-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904D4A27F47
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 00:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BDA161D88
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 23:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5921C183;
	Tue,  4 Feb 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSlZ1tga"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602852163BA;
	Tue,  4 Feb 2025 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710465; cv=fail; b=NzYxW4Lh9lLSAHUkOsYQXineTDw3FbnaF/gnCTDubzBG/2o7u0tz6hpeAysrOiAU4HSY89jeCLjZXfkL7qWPga3pT1lKSfNAUIsUnQ8AtD0ppGG8VDiArqPWGJc7B6lnmi3ayNmVQUA/sBIm7+ZHn13cpENgFieQK0nXjtWFKxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710465; c=relaxed/simple;
	bh=+OIgekXuxWGAzekEP4QVqI6mHjBLv4H8eDy4duv9chk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h7QAJvtj2U/Fi45q/K5RPMNTQLcLQmP9zBW/bZN62DxCNfgTnqMBz0TOrOwTJwokQVfJ36P9247NHLZNvoopWQDHmmpHPNarc3cYhayxMeIz6StbinC/EJMl+VIj8D5l0dJujhSV6QScWZYuwLwXibOwxzpFgAPyckG9VAcpFZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSlZ1tga; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738710464; x=1770246464;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+OIgekXuxWGAzekEP4QVqI6mHjBLv4H8eDy4duv9chk=;
  b=OSlZ1tgaTH87sKh6Vjj3HmENawy9JArOU5I/NyeTzaeSP4RFGTqO9shk
   KIawB0Z/NIMOBhKmOpt17gcfQAnj0oNaAwkDXKdKNMYqvT5uWgxEqi9e0
   I2VuUSQZExRX6SCS2so/9iqlH7R+gE6wyR1bMuC84GN5TCxEATpONUUaV
   ZDPnQh+jOah6sp27gHuR2boGdQKU4uSVC7+kLXt+oJW+lO9mTzZrno6zB
   cTNQXgMYcs0y1x0uGRj/yg/xzHAqyKOQmFYMa5Mw3AZVMtH83IUFcHqng
   kyKcFcAV92iiG0ECxDDtY8rMOSGbEt11CryTbqYuZ+SxAEQpg6kyg51Vt
   Q==;
X-CSE-ConnectionGUID: ECc+QKpoSDKWRd/41wh/Sg==
X-CSE-MsgGUID: Raul6+jMSNqxCaAKoTDhYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="26861863"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="26861863"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 15:07:42 -0800
X-CSE-ConnectionGUID: S41Eo2FCRNOp5BLVdTMTYw==
X-CSE-MsgGUID: 5zA93rV5SVirnMDLid2Rbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="111308807"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 15:07:41 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 15:07:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 15:07:41 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 15:07:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApQDHXvbP4Pnj8Vn4WrjofDDz+YV82N9LTfQjBlRTZl4q4RlM3x+dVTw4/S4yExem9KHzXHEy3AcPbMjWgVUC5/ggqlTtu6ccKH6fs40xhxdErZKG/XxYYSQ9WGV/shMfHDpI6DsQ789Liwz3Vl/K8MgiolTyR1WWiECfE+wVQE/abJubN3AXu29LWWrW56iQrcbUBYmNrBRrrA8WF5HMo+cOatwIFt9IyFvznXih9gypt1Qrpa0po3Epx+i5vkD46B8g8Pf2ddwkEiqTgK7dfA2EJLWZdGXgdWD1u7OUGZK3/y60i9GB5/0WJrcW1ZpFD1QKsj+stcgmfkqjah/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itDx6tQ+Niy2hIyNPnhDgck2BEw0A6aVfweMTdDG9yo=;
 b=Gy8RVD6eVv3O/CdL5yvzGtBpUL+wgHIaRyC0BAFMVYoQqxYfvvRCeBNCv7u3LfjxSv2fRW1gYzBGHp2zr2SBbJ9x55ykIUfbtlipaPWqAVA3G6xqwtUE1uBL9jEXRAaKNDuic2nq8iGTCKmVaFCveKciB4XoGXhp/XnST7guc3SWVT6yA0lZgjDuobs4FSXPPyAkEOKTu0RP59puhJa6OTMXk5kI78j4ZTZOV97tOkCMV/zNiBkZEpgb7kfkT1Nx7zCuBOSigEgD4SQ81hUWgvhNTCsRtakB8gMx76DhwOVJcnxv3ve//Y/gxolEcjsCGBzIuLL7g6liNtf7FqDy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by LV2PR11MB6022.namprd11.prod.outlook.com (2603:10b6:408:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Tue, 4 Feb
 2025 23:07:36 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%7]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 23:07:36 +0000
Message-ID: <037b3bea-b312-4e49-8f1a-207f237091f8@intel.com>
Date: Tue, 4 Feb 2025 15:07:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9][pull request] ice: managing MSI-X in driver
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<michal.swiatkowski@linux.intel.com>, <sridhar.samudrala@intel.com>,
	<jacob.e.keller@intel.com>, <pio.raczynski@gmail.com>,
	<konrad.knitter@intel.com>, <marcin.szycik@intel.com>,
	<nex.sw.ncis.nat.hpm.dev@intel.com>, <przemyslaw.kitszel@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <David.Laight@ACULAB.COM>,
	<pmenzel@molgen.mpg.de>, <mschmidt@redhat.com>,
	<tatyana.e.nikolova@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Leon
 Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
References: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
 <20250204144252.686a466e@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250204144252.686a466e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|LV2PR11MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: c953e8fb-8e6c-44e1-3593-08dd4570b6e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODhyNUIvV09mbzZGVzNyS2JpblBLQ3Z2VEhOZzZMb3BwN1ZDZTdFa2F4Mzdk?=
 =?utf-8?B?MjBKWGd5Rmhoc0N1L1diL25RK1FvbGdnL1BKK21uWitWc1crQk01M2FyOUlG?=
 =?utf-8?B?MGtYa2gzWE02bHNtRVMwaWdkeTNkREx2L0MxdjhwZzJmQk1JVmJvTEVwWWN5?=
 =?utf-8?B?UHlqejJnK0x5cEprVXFRajNoM25uUFJFODZnaXQ5N2psWWdOUnd4eUF2QWJv?=
 =?utf-8?B?UmQ4eEdFOUFJcVZrd0F3TDdsc1lsbUQvckNuNzBkRkNDZ0szMG1rSlJQbmZ2?=
 =?utf-8?B?T3VRb0Y3NkdnZWVFNGpWWWs2emdJaWFjLzJjbWQ5Y1V6Y2xoMHR3Slh0ekp5?=
 =?utf-8?B?d3NWSEl4S091TElhZ25DcGRESzliR0NwSlNJOW1xdkFzVkRkVHhRV0FyVlQv?=
 =?utf-8?B?MG5qVjQ0cGVFM1lJQXVKUDVQZWc3SENtREQrRjlpZmRRZTJ3WWtnTU9TbEti?=
 =?utf-8?B?c0tsK1Q3MUtNcGNUUHBEZkJ0S3RyVzhPb0gydHZOZTFSVUxnWnlweGJ5WktJ?=
 =?utf-8?B?NHJhS25kakphQ1NlaFE0bE0xV2hRQjRXUk5rRUhuVmVLelZ3Znk2bStBOU9k?=
 =?utf-8?B?VmJTSExpUnBhbUZXMDN3aW9NYzUyeHFzUmJyVTVtbTQ2RytqYWlMem5tTlFr?=
 =?utf-8?B?aEJzUmd4bTVnMVpPdTJGOGYvcDVRK3QzSEE4OTNMb3c4dEVPaW5uakF1VEJi?=
 =?utf-8?B?MjVRZzVtYmdMVmFwcmhmN2pjMjM2K093UlkyOWlmTE9LWXFSdTN1YW1RM21U?=
 =?utf-8?B?ZmxoVWM5Wjc5MmRIblhqMXhoWWw2aFFCR2lPcEV3TGoxOFFKMElQMU1jWkZ1?=
 =?utf-8?B?RjliVS85MGMxZEEydWpKZ2k4aGM3Y3VIOFNMeURSbndKM2ZxNmIxaDB5L05j?=
 =?utf-8?B?S0FMaVBsazdvWHJoeUl3UzkwUnVvKzJ2VDVUZitNbXFkNzlMeFZsOVNGTkY4?=
 =?utf-8?B?dGpjdVRmTEcwN1ZaZ1RhQnBQdHk2RW9TT3oxaDNOSDVkWDZGdnVLUWtjSWFL?=
 =?utf-8?B?aVNlaDgvcm9abmwzZFhGc29KQWtnWnMvYkFNMklxTFFLMXVZWk5PKzFiZXFv?=
 =?utf-8?B?eXUvRGFINXVUbHJOSFoxdmhoOTJxOVJQTmZ4WEtRVmdJelFUYzY0MFVDK3hh?=
 =?utf-8?B?SUxGaEFNa2Z0ZDNYaHg1bVdNdkJ1TzV0UkZrNXRrbmZmMzJjQVIxd0dtS3M3?=
 =?utf-8?B?S25xOEdnRnpkNkFxc0tPK1V0anJjQ1FPOGZPQ2pBbkNuYXhCUU02VnFFdkRq?=
 =?utf-8?B?Qk4wZ2FGL0dPbXpGb09VMGNZajNncWpYc0hoMm9NcnJkVXhtL2pmUkFiVEtV?=
 =?utf-8?B?NWUrRWlmSXZXNkRZUENyeGtMeFlSa3VsVFo3c0NwbmlkQ3Mwek1veHlkS0Jy?=
 =?utf-8?B?V2FuejE2U1laZnJYMHFhRDF4aTJ4M0JSbmJRNUdEOXRaK2daekpuZTFJV3ZT?=
 =?utf-8?B?aXlOWEZDWnVEelFWYmhpNWZPNzhhUWVBSUI2eWNsbDNMYzhQNE1YYW5kbUg1?=
 =?utf-8?B?WFhxbHFQejhucEY1QjRpSXU3cEJOTFcrcVpvZ3FmUHlPR2FiQzZieWpEaXFK?=
 =?utf-8?B?TG5aQTJCMVJXL3NackFBV1ZyQnVibnhyZk44QldjVkY2eTlKYW9MSkJLTHNG?=
 =?utf-8?B?SmpBVFRlWlJTdkI1NE81Sjd6T09HVEIxcTJYSW5yOFVhd24reCt4S2haZjRt?=
 =?utf-8?B?VHdRL2dDbTJrZ0MvSGpPM0hLRHlyNTY2Y04xM3lQcTZIUFFtUHdDV0lXWTkr?=
 =?utf-8?B?WWhaaUVaWDZ3MUwwVmJsc2FGRzc2UjlKeDZkWVU3ZFlqT2krVUN0eVdOSit1?=
 =?utf-8?B?TFZUeGhQVGtEdnIwc2hnVjBBVGQ1N1RjT3l1d2hhMGxDeHhTbkNtS2dpd3VW?=
 =?utf-8?Q?svArV1MeZ/bSJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFAwQkxvelErTWVJRTZVVVo3enFva1RPY1AzQkViS2poblhKYzVzV2xESkJW?=
 =?utf-8?B?Vm1LT3FvR3dMcUxhQ3ZpL2pVb0VTNGg5Uk0ySVlWQUJkdy9FRWRKclB2UjFs?=
 =?utf-8?B?QjNGblUwd0JzM1ppY0xJancxN2hHRFdiVjhFUzZTNDl1Ukd4dmxrMEJTVnAx?=
 =?utf-8?B?UFNGMkJIdkt0VklTN2VhaThpTFZQMzlrUTE5bitjV0lHUUZtTlZsQjBWNUFS?=
 =?utf-8?B?UTRsSWkweWE3N3hubmoxZTVhcFFBOFFoYW5Oa0hRMitwMWwwMGFXU2JmVXcw?=
 =?utf-8?B?Y01qVXplUzd6TTBkczRPTXJUWDNvWG9vcjY1V3hQOGt5NVZMZHE5OHpKNFN1?=
 =?utf-8?B?clF2bytFYVV1Q24rZkRVWGNOa2U3Zmt6ZDJtTFR0ZUlXSDR6bEZNY2VLTHdq?=
 =?utf-8?B?d0xBV0x2K2FtYXdJSC9Gb293c2JYU2NYbFNFamRCcE5QdDI4YjBlaHBsUmlL?=
 =?utf-8?B?ZjFWV0pFV3Z4M0dPSzFNd1pldHZheFY0cWZUU3ozWDJWbWJTVGk5ZUFJSmlK?=
 =?utf-8?B?MGZISEpKYWhaSkdyS1FsYmdxTk9HbWV5RGlTN3ZHQkNDOWdpN21UWGFIc1A1?=
 =?utf-8?B?ajdydHJUWStBbDR4azNTUlRhVkhvSHpRaUlhYTRpQmpmY1dIR09hZkVZT21D?=
 =?utf-8?B?cG5SeXNwRlBGT2t4d3JIYlcrWnF1aTZwQllxVHd1VnY1d0ttMTlWM3RIUjU4?=
 =?utf-8?B?emFvVnk3blYrT3lMelFZN243a2UyVm03Slc5NCsrL0g1NU1yVU5HclRQRjFP?=
 =?utf-8?B?ak94YXpyMng1b2Jld0RUY2RuRTArNFRHSGhWNWQ3MmlyY2t5azI5RHBLVWN1?=
 =?utf-8?B?eHZXWnZWUld4M1JnUjlBSFB1ZFNDclJqbDdrVTJydXZ5OU5rMUxma21sZW13?=
 =?utf-8?B?SStPMWFhMnZDQmxoTWNXUWp4RlNDUUZJU0xGM0VwS3ltQ3FVZWl4cHJKN1o3?=
 =?utf-8?B?TXFjbEt4U0JISHBrUjRDbllsSFVJVjdhdlJBMThscURSY0tmcTR2NG45VFcw?=
 =?utf-8?B?UWV6SXhiODNYMEJmSGtHNkcySlJabUFTalFmVnBHZHUyRzlWY09wRGlCcUNl?=
 =?utf-8?B?VmozaDg1MkpNUEVJdDBQUGI1QkxDQ1REaVltY0FZWTIxNnZ2ZmNyVXQxMnEz?=
 =?utf-8?B?UGN6bytDSk9pQWZxS0tjOWRWSnpBR2Y2NUcrT2k4UGdGZnhCakVDTTk0N3oy?=
 =?utf-8?B?SG5ab3M1ZEZqRGxRTmVzNk1HRkZ5ekJSMkxSQVRkUVZGUTBHaTJ2YlpNeDk3?=
 =?utf-8?B?SkQ3TW15YkRJYWZrdnFxd2JLakJFTlNWeW91UUxmWU1FOERaNS9pSVdXYmNY?=
 =?utf-8?B?MGpXaHZLV2xKUFJ6ZVdJVlRuT3JSQTczNGFheTJnZE9SakNaMEVucEIzbnAy?=
 =?utf-8?B?OTd0clZLNWxRaG5oZEtQNFJFeE9iWTlwY3FVUW9raWE5S2grcjdSZ09oMVlq?=
 =?utf-8?B?UHRHaEhDVUUyNkdlSGpKNWlwcVdkMGlveHB4aVZKYmhpc0pBODlOVlI2NFlU?=
 =?utf-8?B?TXlEZlEvYS81a200bHVUcFNNY2F3UXJscElXVEE3blBzaEF0VU1OUmprWHVz?=
 =?utf-8?B?a0FJNHRCU0hiRFFLWU94THlsQ0tjendyYkRRbXBJOTliVGlKK2FtN2dkRXJV?=
 =?utf-8?B?RkhlZzdaVmozYW0zUlg2WCtzajY4K0NjY0pEUElBMnUrd0l2eFdJMGNxVXFi?=
 =?utf-8?B?M1ZzMURkc1NyQmtTaEUzMGJrUXJiZHlsem5aTHNudGcwalN1amhLRHlPc1Bq?=
 =?utf-8?B?a0NKMXBEWmNwK3VZZEFOUkVRaUtLVTB0WkZ2MnJubm50YTFnd0VKWTd0V1NO?=
 =?utf-8?B?NDRpVjg1enBmamluVHN6cjBEU3AxRHhDMUM1VlViUWVEaEdOQzFrdTRpdHVw?=
 =?utf-8?B?clJycmhXbHBrNU1sS0p1c214eXFtSTBjWUxGT3pKWlhrSFM2RlBIRDBDSVJk?=
 =?utf-8?B?d0JKUUFJK1I1WGM5KzZaSUUvVjFkajZESktpNlVrdGZLTGt0OStNQlpmUUZV?=
 =?utf-8?B?b0hWdXFCakFzRFBYb0RsMUlPUmJMbFlHdUNTVC9TWW9TNWxzc05OYS9KV2RW?=
 =?utf-8?B?dThyWTZKTHpyRzB6Y1IwNVJ1ZWw3bDBqejR4cUkwcFZMWjFydVRBc01DMjVy?=
 =?utf-8?B?blFuZmVoajF2SmtrMDhnVm1jWGRpNDE1cGJNSUg3NEtHUFR5ZjJCMlBwRnBp?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c953e8fb-8e6c-44e1-3593-08dd4570b6e9
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 23:07:36.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLBnjNKJUDbGd+u3Tyon18q5RxAY1NVk/bNaRUpFtn+4EpzNzblaQRYd7AD60VcVDk7ZyRMadxUZrYnZY+kaan3y+1rGaPhZmJ0uH4cFtv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6022
X-OriginatorOrg: intel.com



On 2/4/2025 2:42 PM, Jakub Kicinski wrote:
> Tony, the patches in your tree are missing your SoB, and I suspect
> you may need the same PR to get pulled into RDMA, so I'm not applying
> from the list... Please respin.

Oops. I had to do this a little differently than normal and, obviously, 
missed that step :( Will add it in and work with Michal to make the 
other changes.

Thanks,
Tony


