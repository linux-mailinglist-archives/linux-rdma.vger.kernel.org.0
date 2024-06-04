Return-Path: <linux-rdma+bounces-2864-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC58B8FBE58
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 23:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1AB0B22278
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 21:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C4A14C58A;
	Tue,  4 Jun 2024 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7vhzEGq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752684E1C;
	Tue,  4 Jun 2024 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538313; cv=fail; b=i9470JdIIWSozgPvIhwkr23RT2EZ6NQpixPTXGPsa86dyhQxeZ7IWDXVsYpj7EyrjAfGRAKOVP+k5qFf6Nk1x7IgS4bjXCPcs4daFQI0EBPhER/exMpqR7UbejCc+tuUcSThXvf9e05aY0f5tAB82oakoAjpRv4sWwXdEdJId/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538313; c=relaxed/simple;
	bh=x6RrwsvIac3rkk/YPkqikUzodMLLymQlh/yMocwd4tg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rDkY7SGH+4J9vyDJfTF2j5fxM+JYGhlhlia/dTYLXLVwkyNrE/xFgwFFqEq6TIUSlalKuEpTetP7QoSwVkt4HeyPRXAbec9RoWWcSgmztmjpDByL008ICD8bnLOS22/9wJbS6hf9U0h6a3N/skhFEFCZNSjmeeZ/y5LnIJqmx1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7vhzEGq; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717538312; x=1749074312;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x6RrwsvIac3rkk/YPkqikUzodMLLymQlh/yMocwd4tg=;
  b=D7vhzEGq/4acKpXs56Irdnh8qqwfWKceOc4yxJFFtCBYWtp0H7xyf+Lm
   Tidry8IWeZLRACF6jSscFEySB/jq2u+/+gIZc8H7/4Yrq4h1lQDcxmcGR
   JhiDPtCe4WXy2aNOge95zpQFZkaKKDGM/3eTo1bmJqWBrYZsxLRAZSiOS
   kF9mF5kTE2gCZE1hTEJTWnMNpY/3S14zMxBeVXoTr7XX3pUrSPzI+gcYu
   +XqfBzTnj1gR7yvIAL4H6L8NAkr/dqLcoTZx6XYBgRJiEzaqCzY/gYrtH
   af2FDEhztpuGo8LKrB4dyhlfuoJLz7Ngu8ZbR3lZ7XmkNVXegl/aKeGET
   g==;
X-CSE-ConnectionGUID: ZXgr8YZbTH+IvutnuMB3xQ==
X-CSE-MsgGUID: OGdObCEoRFaRlzIDatOjRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24746654"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="24746654"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 14:58:30 -0700
X-CSE-ConnectionGUID: aYOU2iI6RpqYtUkjYBSusQ==
X-CSE-MsgGUID: zHkXj69sR/uN/rL1VShiMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37499685"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 14:58:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 14:58:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 14:58:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 14:58:29 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 14:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2Jrd3yJVy20qWDvxgNFYZQDcXezWixTytX7abfIDa0xLiRaBfIzesnG3/eEaNUAh0/McDEZPw8zhePGw+iQSCGSmyS8glDPNtV5r3A/7aCjFPgYAemBPuheypvD5fk23L+8db3Bs21MH3ri3QoWTWWIwlcZ5F2hvI0oqU1gbrN2at+Jz9PAxPAmR/0IBMkGra1EVjfS8RCRdX5Y6lDxUR4E32wr6HeEFws2xQd98mVncZ50AoATR7Pgpmb1Wdrd2I0Zw4C22CWihX4vXd/U+NYpU7uPuFaaK97IGVNomj4esMKsRDqc44Wg3VCXKIxLWQw7glb8MuWNrR+aL4i0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxh2V/6R0w9lGIzo351dNDuz/cvTeshpd8gduq8CyrQ=;
 b=FCjARvGHVaM7NXtcjHP7zHfbsdTB2NzCCmFuRNUfNDyUq+fj8VtKoEqkzb1WSsLlIds5/GiVHIFngWCkE8upzNrWp4nWeOLVFtgzy60oFyeI2uLEqRkH1ohYdn4bFXShzgJkvaJ6EoDQL/BXcpt5ftmqi6aQE8HIBlTFUN58ptv+YW8RtCFd2pdGE8MMQ6eOE3ijkmAGe6l578HoFwmGJse8ndmxPxoarC3oElsr02q+2sDV8cCAZaUjNYpfCUZATaOlJI3fw7l2bMsYXXuCM7lwg5sXluejb+1qCRGmP2RRoZ/ga/dzIzODRaLcp4QG4BVprWTfrQGwT/5rFyqtgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 21:58:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 21:58:25 +0000
Message-ID: <2b09c707-208c-43ea-870a-1c637ca8ed53@intel.com>
Date: Tue, 4 Jun 2024 14:58:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fix tainted pointer delete is case of flow
 rules creation fail
To: Aleksandr Mishin <amishin@t-argos.ru>, Mark Bloch <mbloch@nvidia.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Maor Gottlieb <maorg@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Jinjie Ruan
	<ruanjinjie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20240604100552.25201-1-amishin@t-argos.ru>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240604100552.25201-1-amishin@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0288.namprd04.prod.outlook.com
 (2603:10b6:303:89::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bfea1c-c5a7-4379-2af4-08dc84e17575
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3Vla1EwY2E5VytZb0dNUmh5U3RWRE8xYTdMNEd0bGRneXY5ZDh3T0M4dFlw?=
 =?utf-8?B?dHNPNkFYSXNUbEhGUjN6eEFRNit1NVBGQ2dvcmJnMjRjK052OEw2QkZBNmhj?=
 =?utf-8?B?Q3VIQVQ3TExqdzdsc1MydEtyeTdJTVVZdEFIdTdpWHhZaU9aK3dhVVZXaXJ3?=
 =?utf-8?B?ellFR1F2S1lqZmFXTDZiRnZkQTJLOTdmRkpYTlYwU3hLVzAvL3dETDU2bUJR?=
 =?utf-8?B?RTBIdlA5MWVJTFBBTWdFVWNMWlhFSlBabmEwR3dwV25qcG1SMVlPdy9EMWRi?=
 =?utf-8?B?L0l4M3QrRHNoekxkZU5WU0MyZ01FSW9EdDVVQWU5b2UwcHZMWkVRUWRUeHBs?=
 =?utf-8?B?Zm9BSzI5cXQ0TWRFUTBaZVAvZjhSNGRlMC9tTGdOYUduLy9YS1NUTWRzc29u?=
 =?utf-8?B?Qzh3dHh6WUtDZStkbWpJUjlIdkttaW4xU1oxZ3o2NHFRSkF4d3RWeWNDZTBj?=
 =?utf-8?B?WVRSTnN0VHNiMWJuWEFuS3ZrTWp5L1RjWHdVbGV1MlgweWFLRTJFNGJRSFMr?=
 =?utf-8?B?YnB1Y0c4UUlycEF5TG1sTDYrZFFmTDdNQnlyWTRjUXljZ25leVVEVTd1clZv?=
 =?utf-8?B?SmVZbXB1eldYZjdQVWRYQWFNUzViOS9sS09DM1dwQXlEYVVlQXNVN0ptdHBB?=
 =?utf-8?B?YnU0WFlHY0QxTWVVQ2wvSXRZb3kyRVcrMkV6T2V6alVNcXhmUGRWVW9RSnBV?=
 =?utf-8?B?WGFSMThhU3VxZ1YrRnkrR2dSalRVb3o4MnloNDhaQ2V0T2cvaGZSK2NIWmxV?=
 =?utf-8?B?VGJTSWIyQmZUVzg3T0hTT1ExckxSd05SdFVRK2Y1V3IvK09SczM0ZGc2Sk5p?=
 =?utf-8?B?QnZKNVp1M3kyUFBOQk5WZHplRUlSazJyQ1kxaEdIdzdxTlpFL1F6Q3NlejVx?=
 =?utf-8?B?R3pCazc4Q1FhMzVFUk9XTnAzV09iUGNNdEhDWXlycWthK3FkYnlucU1acjhH?=
 =?utf-8?B?YmtzQWdwL2dIaDBWaDlhdEZOSlV1QTBLN3FTTDhLRkU1YTRiY1RIQXlIclNo?=
 =?utf-8?B?Z0RndUFwbDZqWjBTaXdJck85OFk5QVpNdjVaWGsrRHVVY2lVQWhmNlF4dGFM?=
 =?utf-8?B?NW9WeWVuazNnemd5cHFBLzRrc1U4TVgwVEYxSkxFV1pMWU8wenpYK0Jqdzk2?=
 =?utf-8?B?dkkxWm00dWF5dlFCT2s1dHhmNk1XUXYzdmYza0xnemFyT1pGN3dvR2l1enBQ?=
 =?utf-8?B?SnVRa0xmR250UmRsNDRPL1gwbnBIL2N3VjR6WFpBTTJPWDhUMFZvck9NcGNh?=
 =?utf-8?B?WnR1VS9pWXRBM1JhZWpwWStkYW8wUXZ2RU1YU1BqSGdTVmI2L2QxOGJ2S3A1?=
 =?utf-8?B?cWpjS0ltQktLV3BDV1ltM01uSlZ2dmtsY2FiV2Q5bEpZUUlHbVR2UklEMmVz?=
 =?utf-8?B?MGtwM3pTc2dYS1JjbnZXUVNHN2ExT2w3UjdNbTVPT0I1blNNODg2NndDN0No?=
 =?utf-8?B?ODVJRVBxZlRaNFp5c1dSbVNMcXRlM2EvcXMyMmRHUXMvWCtHSkZpeGh0c3VW?=
 =?utf-8?B?U0JVcGhoSGJ3VGo5VWpMWjBpa2dKZDRXYWR0TkloY1hoVjU4RTI3bHQvTnlD?=
 =?utf-8?B?dStKTDdtcCtsa2NNVHc1VTloR1Q5dnpOcXp3aTRnRmFnKzA5K3FaWVBjMnZl?=
 =?utf-8?B?K3pob2lkeDdJbXpRYnRuUklMczNLUVZwd0p2ZUhqRVZORUpyS29PUGh4dFk3?=
 =?utf-8?B?dW9tZU1JRXdMc1MxSnk1TVVOMWp2SnRCVUNDRGZ2TkNrYlZYQm9lOTNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUtLaEJSVXFNaUdRUkppZE5MS2RPT25icERTYVh2ajA4ZzFLdHprR2ZWTmFZ?=
 =?utf-8?B?NkYyRi9BZlc0SVBtSXUyMWtmU2dQdk5LMGdjWXpSYlN5TVV3YUFkUEZ0WDJE?=
 =?utf-8?B?UDNCcXZwYWZvWVFVTk52Y01SbGxjRVFUY0FsbmpPQzJZNWkyMnpKdVorbXA3?=
 =?utf-8?B?R0Q4NVBCemFwOWRiUU0vM2tMM1hZS3NYeERLdFFUQ01PSkxXWWNzQmdUM3gx?=
 =?utf-8?B?dU1KaUZNZ04rdkJ6WVkvSnZsSk9iOVZKRGsvaVlnNGwzSHFITG9ZSmdJS3hF?=
 =?utf-8?B?N1lYR3JhekIvMWpNSEF3UGE0bTJUNTRjRVhEYVVjd2ZJU0dMWU1ObnpTUTho?=
 =?utf-8?B?WUNoclUwUTZDRlVXUDRqTGY0ekkwRXdLZkFqOGdOdFZsSFlpL2J3aWJWaklX?=
 =?utf-8?B?Ry9JeU9yd0ZPdkN2VUluaVhLU1Jqam1acXEwK20zOG9TelBuWEJ2Ykd3STZR?=
 =?utf-8?B?R25PcFlHSGhCTVpVNW9Gbjl5anJYbTN1S2FiS1JFbmdFVVlURGxrTTh3QVox?=
 =?utf-8?B?Vzc1a3Z1alh1UXgvMVJPVnFneXRrcXVnZVJ1Vm44OXZKT1RHVmhaNTJOV0lG?=
 =?utf-8?B?aU0rK3pSTHV2ZWlpc2QwQnUxMGg0bjJFTTVIWHRqVVQ0R0FOeXpvOVVXT2VX?=
 =?utf-8?B?SkFqVUdxWitMcEFna0IzMjNDRlRWcFJrUisvSUtVT0ZwYTJyalA0blBmeVQ2?=
 =?utf-8?B?RkRjNWpmZEdrSDBkaTE1aW1LQ2R1Rk1CajJPanJuUU1UeUp2ZFNqeEZGcEVu?=
 =?utf-8?B?dnV0K2hTbEhadHJUUVd0M0lWRFF2UGxEbGpFSUN3WUdxZHRDTlJEOWFuS2Jp?=
 =?utf-8?B?VG9OemN0dWtJb2ZXRzR5dXc0ODhpUDFWa0NpKzhwd0l2LzhwK1ZpMzhPUVEr?=
 =?utf-8?B?NXZzTlpiVllydmR5YmUvQjRuVGtBc2ZVNG4yMys2WElvNkg5Rk84dGNPWXN6?=
 =?utf-8?B?d1dPOXE0TWNzVWJpczYzaDUwblBVNFdmb3BxL2ltazBrWjU3dW9za1IwVFVi?=
 =?utf-8?B?L1pHUEgyRjBybHVJTGVBL2JOUjgzVkhXSGxBTkFkYmF5bXhxd2JVbFlMMmpQ?=
 =?utf-8?B?MFE2TEdvWGhPbnFlZzYwcjVUb0h6UDNFZ1dBSTIvWldHbzMxT1l6OEhHc3RD?=
 =?utf-8?B?Sjl3TkZscjlLRWdZdzlkOU9xZ2cxL2pRajJKZXRpTloyb0lEMUo5dFAySWU4?=
 =?utf-8?B?REh3M2RNS2JCTUE0T2lDblVhbnpvNzI1L2dJeEZJTGY0SmRuam9nTkJtL2cv?=
 =?utf-8?B?QzF2QnQrWjBpQVpWRVFJdFNIMnoybTJqYS91dExRZW9NS0JnaXgvd2ZrSGM0?=
 =?utf-8?B?K1NPa2lCOGZCTWRWMUFMYU1ocndDVXZBYUp6enNPaEZJVk9iaUN3M2ZNdFN5?=
 =?utf-8?B?bkwyRDkrRWRKZzM4Vmc0K05zZkxhSTB1Qmd4UUpFQkpGQkhzMG5ubEU3bHhy?=
 =?utf-8?B?OXI4TTBHTXJYbXVIMUhCbXlvMzNnS2QrSWNvQmxCZVE0MmtKeW54NzJWTlBW?=
 =?utf-8?B?RjFYcE5zUEg4OTU3WDhrTDhwRlV4QzlHOXkzWjg3YytHdlhiNHZHZlRsMUhk?=
 =?utf-8?B?Zk8rcXJRazIzUEYveElQNGhLNEJ5T3NFWXFxY1lLNDBDWEJKbVYyVWlqRmh2?=
 =?utf-8?B?emxxSmNuSUhha2l1eWgybng4cjRYcmhlNUNrM2pKZVBwTFVpOTE3dng3eVRm?=
 =?utf-8?B?Mlc4QjR5dkJMTlBSaGVaL0hkWjZjNFJYQkJpd2pvWWxMcStiR0h3TFExSWNn?=
 =?utf-8?B?VGV4T1gzWGo3Zzl0RGVzUTZKVHc1ZHNDV3pGREFGbWRJcnhETm1uaENtdUJi?=
 =?utf-8?B?N3ZadXlmQUNhTDdjQVR6MDZVdGpKak01NUx2d3pheURJVGRraWJGdXZqUldR?=
 =?utf-8?B?eVJET29ZSmhtNFlDaGZpOCt0MWo5QkFTajd0TUtYaDFScTV5Z2FvajNqZVZL?=
 =?utf-8?B?NDljcytYeE5mc0U2V0R4WXZvZ1V6TFg1T3RrN0R3SHNUNjNJSTJzS3h4WlNm?=
 =?utf-8?B?OVZhY3NJVzJDbTF0VW9OaGhQS3dWekRMK0N0S0o2ZXh6bzVFYWtkTVlrVmFp?=
 =?utf-8?B?ZnFLa3ZQNzZtQWtNTkxXTDVnZ1l3eEMra251eGphdEZvYS8wYURwSzBqQ0xV?=
 =?utf-8?B?MTA5ZmlZYnc2cEFnQU5jclpxR3hxRHlzUlJnbVF2byt0bzFUS2ZzalNKbEFM?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bfea1c-c5a7-4379-2af4-08dc84e17575
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 21:58:25.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBj4vpKIew8BVbbP4ZYF6dCL6zKyvPxPNdsry7wcocwt5WjtSnLsNFeUwpBAPRQmr9MHk9KErnjONWKYkOeCg3QvCQ2IPCPmu5l7ribs//I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com



On 6/4/2024 3:05 AM, Aleksandr Mishin wrote:
> In case of flow rule creation fail in mlx5_lag_create_port_sel_table(),
> instead of previously created rules, the tainted pointer is deleted
> deveral times.
> Fix this bug by using correct flow rules pointers.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 352899f384d4 ("net/mlx5: Lag, use buckets in hash mode")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
> index c16b462ddedf..ab2717012b79 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
> @@ -88,9 +88,13 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
>  								      &dest, 1);
>  			if (IS_ERR(lag_definer->rules[idx])) {
>  				err = PTR_ERR(lag_definer->rules[idx]);
> -				while (i--)
> -					while (j--)
> +				do {
> +					while (j--) {
> +						idx = i * ldev->buckets + j;
>  						mlx5_del_flow_rules(lag_definer->rules[idx]);
> +					}
> +					j = ldev->buckets;
> +				} while (i--);

So, before the code was:

while (i--)
    while (j--)
        mlx5_del_flow_rules(lag_definer->rules[idx]);

That just calls mlx5_del_flow_rules a bunch of times but keeps using the
wrong index, which is obviously wrong.

The new fix is to calculate the index properly (hence the switch to a do
{ } while (0) loop, so that we properly delete all of the older rules
rather than calling mlx5_del_flow_rules multiple times on the wrong index.

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  				goto destroy_fg;
>  			}
>  		}

