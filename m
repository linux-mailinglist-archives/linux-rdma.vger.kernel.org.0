Return-Path: <linux-rdma+bounces-2711-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4C98D545D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 23:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D39B261E1
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE1A186295;
	Thu, 30 May 2024 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ea8DXL5d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D62E85A;
	Thu, 30 May 2024 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103491; cv=fail; b=aSSUQmTQ9GzejwcT6gLS/VVMsDtP+2p6C13nZsOa+pZpTV6yZCAf4p2rKM1SfBJKnx7OdQE1kIg9trf5hMfro91vPXl3iCBewg/efmwZ/QXJLPAtu9oFwoT7aPjJ1T/hWCY7KPK/mgJMmtQiYlP+iwu212hTs1+rNnaOgi2T3CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103491; c=relaxed/simple;
	bh=W2Qpcpy5s9x3++Luohcn/Tu8UuXEwS58fuqxpkdwGTw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kknZdP/hhIQlnU3ISy1/RVK18G3eWzUorT3536ZcAe7n1jLTuOVskqYXctRdf6u1IY6Fe/cSBcy9SmbRPmrMZw3GNaM0Ducb9FOm7oq7hRpRJ5EITXanfMkO16hnm2++DFCpv5KG9vPp/9oDDa2dwXWAj27eXrO0gDPnOBbu0o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ea8DXL5d; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717103490; x=1748639490;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W2Qpcpy5s9x3++Luohcn/Tu8UuXEwS58fuqxpkdwGTw=;
  b=Ea8DXL5dCw5UKLreLm67DVsOtb88/njTabVE5l5fEUIZWJMzUiZ3na6D
   xc/T2PZcwpCi0f6IyZ1Iupv0WlGD3zxP6oP9hctaPJ38RKNDE//+xBAVJ
   aEamoouIc4uHvvDWC1rMwa0vE0mn6PavS5QGz61P2VGTNqfZHclvHGVvg
   +ky0gLzFtRXO6JKtlO9fyPoryAlfb1A1C/wtuWtp99EsjIpqyL8kH6mpJ
   YrDVkbg1Umx69CDaiwyeQ2KDVMPN4a4Y7lu4d6dGjHDTI/cYfO/sG+Hmy
   DwbK/x9PByocCEw86grl8O62Ii42l/vPkZ0Y6TckLozBz+lz8q4Zmhdfb
   g==;
X-CSE-ConnectionGUID: ABnq47BoTQ6AEcfnBSVDSA==
X-CSE-MsgGUID: 5sPzT4zyQBSHrfMaAiIwWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13850221"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13850221"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 14:11:29 -0700
X-CSE-ConnectionGUID: 4/PtMZUeQruqctcVSfwN1g==
X-CSE-MsgGUID: HTQrEZOBSBmhAYmh1X1W7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36448442"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 14:11:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 14:11:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 14:11:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 14:11:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 14:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsA5xD7qAaTtHV1lHl+FR1UyPqw1yxnw+L5dzm+RqaKVendUkDKAGACC5yb7YeKfcOWHuBRRSYoMikmX1Obt0v0kyCTO1gFnOeOwXNWfxZnktMrTexs8OlTglglCHtexIyR/SAx6sq6vs3qx78RUpNkJS03dU5NE0t4c1DQjl+0m/NyOsnzId4UQWCFra2bLZD571+FZs1MC4Hji1f85ALUIfwsJzKl30stOvbLsVHcUTphiJUZYjrR7VBBZzs7JycwR5t9sEn1U2iS34JgRN8PqMumboHGB2IBEuhTK+SDgdfxqjcAUDBZATNrt9kVz2lub2dDKIUkKGH+B5nZ01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEQaXa7tAB48CclLel3UNEmHmTXdy48uv4frnyBKyKo=;
 b=JaZjDXzy41zBB07PkftmO3i2i6RtYqh1THo4aEXctSeNdx2CFklQUemCrUtGys8zAXkuQH1JlGc/h5qRsIoasCxW8QN8OAKHydonLjm3XJM+b+n0W/lDgufOY+5viqn/8l8QZju9a7Y52UPp/gVmNbhgZ5MphgLESSI6V3Sphn7QDJ0NyGHsAussjH7gV9GPTzpxr3nEfls7pz7oFWhwwE5lZqqXoMIdfb7wA31Rl9B1FsM1Q62UjMqxVJZpUw9kupWRGk3tGQgDB50tFjvRafCR8OMMJ4HmZmCGgQlogGAAERme/AZWLoCR6LCNk9R6yUrfC2YeY0BD4/X/krMpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 21:11:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 21:11:20 +0000
Message-ID: <3d1cf564-c77b-4c8b-95ba-e33658596a93@intel.com>
Date: Thu, 30 May 2024 14:11:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] net/mlx4: support per-queue statistics
 via netlink
To: Joe Damato <jdamato@fastly.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <nalramli@fastly.com>, <mkarsten@uwaterloo.ca>, Tariq Toukan
	<tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "open list:MELLANOX MLX4 core VPI driver"
	<linux-rdma@vger.kernel.org>
References: <20240528181139.515070-1-jdamato@fastly.com>
 <20240528181139.515070-4-jdamato@fastly.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240528181139.515070-4-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0375.namprd04.prod.outlook.com
 (2603:10b6:303:81::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b81e2f-5ae8-45ee-fe48-08dc80ed0dc3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnN1ZytoTzZ2WWhYMEk1MVVQWWJBTFY4WDNGcU9oUVJVQ3NHSndWNTNyeDhh?=
 =?utf-8?B?TEFwSzlPaFluYTV2U2pJMVNibmxtcE1IbmtKSHQ4aTZVWVZoWWlUQjk3M29Q?=
 =?utf-8?B?VXJDY1NvN0NmNzM2eXR0VTlRSTY0VlBianZCOXZxN3JaTG9uYnczOTB5RXBs?=
 =?utf-8?B?cVVrNGlBSk5LV0RZR29CV0tMSTZURUFKaGpQM3hDT1ZRWFg2L09KeGt6SVVo?=
 =?utf-8?B?L0JjZG9Mb0UxNXBMQW9NR1JnODgreTVxL1hUYWh2NXhCbVNKWVNLNEVFbm9S?=
 =?utf-8?B?aHZVMGo4QkRPc052bTFyNkNBY2NrNGxReHVjbmlZdERHZEdiZlhOelRWVm5a?=
 =?utf-8?B?bHg5SFRqaUprZzVVSHRiOEtBcW5aNE9UQ0t6KzJ5R2k3WnZoYy81SVZ1cmxr?=
 =?utf-8?B?RFZtUVJGK1VoZ3A3NmYwbHlVb1QwcnhzOGMzQTZhODdNQXZwcm9uYWFadk0w?=
 =?utf-8?B?TzdLZVNEZkRQUzdGSDdNSmJ3eHJRK0JWUEN1cmt2ZnJsTGpWU3pzVXkzL052?=
 =?utf-8?B?MFE0OVkxVnUwWnFocDdBQUlPaFplbkVUQ3RhOUtRR2FKVENDTlNUWmhkdEVQ?=
 =?utf-8?B?OFp6b203WThjbm84QUNsU2FOOVFLUDd0b1BjaUMySG5CQWt1TmVUKzViSEtG?=
 =?utf-8?B?SUJYNVZzem1URnZ1L1NBQ2pEd2tmRjRUVE1MaHloakIxUVZXMkRQK3NJYUhh?=
 =?utf-8?B?RThwUUNFZG5JZlk3KzNWU0JxeEcyclM3Tm94K1RZelZERVlBRGVKZWVRWnhz?=
 =?utf-8?B?ZWxJc2NMclh3N0l5bGhndnYyNmlkWmtTeWF6RUdZRytyVmNmNW42NDl1YWNG?=
 =?utf-8?B?NTJLOHV6ZkpZRS9RTnZ5YUkxTDdzaFBTQWZuMkNodC9ja1BZOXFvTElOTVZk?=
 =?utf-8?B?RG5GaVVBZVFKNzRGWWlpTFFNZVBjeE5WQ1F4L3lCNG1PWGdsN3BoOHhYa0Nm?=
 =?utf-8?B?cjc4cDMrN1JIK1ZtQ3JPTGxQVCtHenZTblJjSkxWaWFjMERRWWw0U1ZVN296?=
 =?utf-8?B?cGpLa1FUZUg1OE5LNFJmY055N0RjbWEydEhONStOZXQ3bWN1SzlQWGoyZzNq?=
 =?utf-8?B?a2diQ1psVmJya3d1ZUxjMHZaTHVLRWE5cDRCSzJucGd5Mlh5MlVoUjJOK241?=
 =?utf-8?B?VkRuNHhnNWl0ejFJS25QVTRoVk5IQzIxbDU5dktFTy8rdURHWUcxSldjcnZC?=
 =?utf-8?B?TkVvS3RZRDA0dkxzOFJwMTJTeDVtK0RZQ0ZJVURZckc1VFRzL2NiRGY0VjVL?=
 =?utf-8?B?TmJzNWhDR3J1ZHduaHJKdHkyWkMzL0MrV1A4RGlLVnczUEtOWXozYStJbGxP?=
 =?utf-8?B?MlFLTkNmZDNxQkpXOXhYNkc4ZlYza2tHMnZNaXFBRXdIWHA0bGF2RXNHd0ZK?=
 =?utf-8?B?cUxZU2RjMHJzNkF4d0xycGNUVmFKS1NyN1JKY1VpWnF1Y3Y3WFdrc3B0MGRJ?=
 =?utf-8?B?Yy80aFl0TjNRczY4c0ZXcTFUVkNyR2lSTWl3L3NkV1dBSXJUT2tFb2t2ckx4?=
 =?utf-8?B?R29sNTBVTzk5UlRPWUVHY1RIMGwvVmg5VTZoYjlaMm5hZENaR3YvL2JaZGhu?=
 =?utf-8?B?M1l0ZEtSN3VGeVBBUDJXQWZ3dGl4Q1BRbGhidURUNlJPVGszUk5KelNkQmF2?=
 =?utf-8?B?ZUN4RWx3VHRXUHJ4Z2ZlSWJEbC9TWHcwZnBvVGVlR0xnRjhrdE01Y0puczN2?=
 =?utf-8?B?M0luaHJsQ0VZTGJhMkp1cENpUTRLc2w2YjEvWVQwUzBMRHJyd283ZHJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlBlYkQvd0tnalArZ0lINDYwbmtvVnNmcUZpeHNMcDZZeVAzWFIwLzlJamJF?=
 =?utf-8?B?WmlXa1QrckxOazJEVUpnYjh0UlVZakdxWURJSlRiSnB2dEhkWm1jNlg0SmZE?=
 =?utf-8?B?Q0pDR2tHL2lWM1NZbXdHRjQxUVEybWFWNkNvYjk0QnZTNTZWTXZONTU3Y1J1?=
 =?utf-8?B?Vm10RWx0alJnTGxsZDIyMWp6ZCsrRVdQMW1QZ2tjVEtYenZROE9RMkFRWDRI?=
 =?utf-8?B?N2ExVHhpSVU3OC8wdms5R3VKeWxkNE1XWkhpSmJ0aXdtSUxIWVoxYTBteFhj?=
 =?utf-8?B?V2RuMUFSdUxmTndoUlJYWmQvRzh2VVozdVpqQjlCR2IwWm1DZzhCZ3JnT0U5?=
 =?utf-8?B?d0pIemtONkZ2UFpqWmI0MkVjZHBwVHF5VmhmU3pCN3RWbURFZ0dvUlcwYllE?=
 =?utf-8?B?Nm9ISDYyZVk2TUhXZ1pDR3Y3cG9lK2M0SkdvZmdnMnhROVorVm1FSG4wR3Yx?=
 =?utf-8?B?cGtXR05xT3JRdkxVRGVpa2RLS2ZQVlFEYVlGYTRiQ3ZnT3FlbVlCWmlKYlJY?=
 =?utf-8?B?cFV4YlJjZHBUUjd6aUZkTVB5MHJuYjJwOE5xNGI4bDBkTkZ3Z0xoM2FiNGk2?=
 =?utf-8?B?K0JHbUM2cndpZXFDUGRMU01YM3pCbWJoTUNSNnZzdnlCTll2SWpPQ2JaeWQw?=
 =?utf-8?B?ZFdwS29ib0dlWlFjelNIbnV1NEVIdE45bXRmaXNXVWdsSkhPNzFkVnNCNndH?=
 =?utf-8?B?eDJQa3J5bDdPdG9hMk1ZNjhERlR0S1NrY1dIQ29VbUlqV1cvZ2k0SWhUbVpw?=
 =?utf-8?B?U2Q5Z3NoWld5MFRORXQyTmFlQUhvTUZHbVpubjJ5ZFZFU01VbzBiQ1ZvcXBs?=
 =?utf-8?B?cGoxQjhoT1hIN3NyN1RNbnRLNDlDZVY0VXhMdTNkOGdVTE4yUnZEVzRZZURq?=
 =?utf-8?B?UFpScHVBbXJaU0lVQkFtaXVoSGpSZmpOUHJzZmdwV0xQRktqVCtPZUxFNTJN?=
 =?utf-8?B?MnlJSGtUaDRtZjBJS0w1YUJpL3FHVDA2UEZyaHZpTmVQQXlrMFg1UWFqN0k0?=
 =?utf-8?B?RlFVQ2tScUNUT0UxRE41dW5LbkFzajhwOGJ4NFpCL0ttWEZ0Vll4QmdIV0Jp?=
 =?utf-8?B?NmFoaWZOWDh1R1d1K0RqSWEwb29jSGs4QlVubm5DUHlrN3FxMEE1b3hlTHkv?=
 =?utf-8?B?aUpxMTFRcXdyNTZkN2xWaUhCZk5FaytQNWR2N25iYzBOYlMzYVhJS2E4QXpR?=
 =?utf-8?B?WDJZWksrK1cxZEYvYitTeUlhTktDVnFzc0RJeUFIbTVWbWFiWjdiWXR3NHRR?=
 =?utf-8?B?MFU3Yi9uM0IwYzYvV05XcG5YNXlDZU9MUHltbVRWVDhOL1ZINXd5eDA5Tk8r?=
 =?utf-8?B?L0wrbFhNWSs0WkRteEhRZzNubTkvdjcxT056cGFYaVI3S1U3eUtZRWpvejF6?=
 =?utf-8?B?YmVZYjA0L2FCOGhhV3pzVlNkN2dhVFpqWmNKVUlOeE8wUzZvTXZJbzRZbnhy?=
 =?utf-8?B?Q1hzMkIyVHM1VDRobi8zR1h0NnlsanpvQUQvODVuci9JNU1ieHNtcEdQTCsy?=
 =?utf-8?B?RmtuemZOdDR2bDNibno0TEF2T1QwaTNhTlhVT0JpNkgyMTRkUURFMy9VTVNz?=
 =?utf-8?B?UnpicXVucXBONzBRQ2hFTGRiR3BCRGtRUml0SlNhRGVFOE1TVEhWS1pHcXVt?=
 =?utf-8?B?eGxMMnpmQ0VpTG9Dc0I2Qk9QTjBZbjBHTXk2OHMrcXJjUzkyaEhiSjJyOW9w?=
 =?utf-8?B?QUY0WlNOemgrY2x6L1liRE5oeEs5OTVmYTFFTm1Fd3V5c3liK0VaWUNCMExu?=
 =?utf-8?B?UnpIV1FhL3pTRzZWZE9KNGl1NEo4TlRVWHZVS050TDV6VS9oSTJmNHlEUSt3?=
 =?utf-8?B?M2ZXcDVvOG5kcVdENHB1MGxRUzFwYnlPcStUeUY3RHE3bGpycDlRZHlqZzhW?=
 =?utf-8?B?MGlpSWd2YmNQOUR1c0hqQzVzMit2RXFCWXZUdXg4Z0tZNWJ6WHNDZmV4cGlO?=
 =?utf-8?B?Wkg3MXdvbEp2ZWUzZ3UzVHBhN0dTcVFkczJFMGlwWnFFNlBKNHU4YlUzUjBY?=
 =?utf-8?B?VlUra1ZaNkNrTSt2UEVDZFc2clAzTHRKWTdGZW9IY2RlZGVueDQydmVLR0Zp?=
 =?utf-8?B?cDVFM0dHOE56azlxOGZ1L1VNZnZ0REhZSFE4cG5pdkUvQU16cE13U3A4aUJF?=
 =?utf-8?B?RkNwU2dyalBiTWJnQ3FzaUZrNlJ1eXZQUnE3eUhFN241MlpCSEtEaGtrTUNM?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b81e2f-5ae8-45ee-fe48-08dc80ed0dc3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:11:20.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S44Pbc7w9RfWMvYz89bRu91Kjusu7R3Lnt3uW0A951eOaqXpWRvLf5UdOO9OxCLyD265iSHdTAagygagfQpuIR7sIbcSZq4+NExzgUpmFTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
X-OriginatorOrg: intel.com



On 5/28/2024 11:11 AM, Joe Damato wrote:
> Make mlx4 compatible with the newly added netlink queue stats API.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx4/en_netdev.c    | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> index 4d2f8c458346..281b34af0bb4 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> @@ -43,6 +43,7 @@
>  #include <net/vxlan.h>
>  #include <net/devlink.h>
>  #include <net/rps.h>
> +#include <net/netdev_queues.h>
>  
>  #include <linux/mlx4/driver.h>
>  #include <linux/mlx4/device.h>
> @@ -3100,6 +3101,77 @@ void mlx4_en_set_stats_bitmap(struct mlx4_dev *dev,
>  	last_i += NUM_PHY_STATS;
>  }
>  
> +static void mlx4_get_queue_stats_rx(struct net_device *dev, int i,
> +				    struct netdev_queue_stats_rx *stats)
> +{
> +	struct mlx4_en_priv *priv = netdev_priv(dev);
> +	const struct mlx4_en_rx_ring *ring;
> +
> +	spin_lock_bh(&priv->stats_lock);
> +
> +	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
> +		goto out_unlock;
> +
> +	ring = priv->rx_ring[i];
> +	stats->packets = READ_ONCE(ring->packets);
> +	stats->bytes   = READ_ONCE(ring->bytes);
> +	stats->alloc_fail = READ_ONCE(ring->alloc_fail);
> +

Ahh, allocation failures is reported here. Ok. I probably would have
re-ordered patches so that the implementation of alloc_fail came after
and it was a bit more obvious how it would be used.

Either way, I don't think that deserves a resend.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

