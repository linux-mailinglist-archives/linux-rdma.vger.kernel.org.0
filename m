Return-Path: <linux-rdma+bounces-6578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 548309F49FB
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 12:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDD3188CD4C
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C21EC4D6;
	Tue, 17 Dec 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PO/dEUMI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D081DDA35;
	Tue, 17 Dec 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435186; cv=fail; b=bACbmfaMFfsm50Ue8Pt3V/GPpTjKp2CisDmwF+norf8NLosrPKDrHXgCm5wnmbu6RbPPkFjAt+kBcH1FlSDbbJIO3eNFauywHRlyMnWunAon525oeK8VKAjxrf6g5MLTiibrOeiuby+Kg/v++w1r4SchP12Ww3Pp9ApHU2BYi8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435186; c=relaxed/simple;
	bh=ncUTPcK6Fg9mNbt6p9v4MBZxGrvrPc60BDtKDEyMOgk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rTunMW8ya4nlXw5LWXrwhyYSG2yGfUetJyZv+aLITenSal2Sz3VxosFMRVaY7kIyp2+1Hpj2zfPus5fYq3iQo+MJBsy0YrQAXJTB9OinBDnDjXX3BMJ/3BoqR6u0AO0sTNVIZK1Y7Wm5TzVnCMhaNKhI0av+V8etDz2IQrKbF4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PO/dEUMI; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734435185; x=1765971185;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ncUTPcK6Fg9mNbt6p9v4MBZxGrvrPc60BDtKDEyMOgk=;
  b=PO/dEUMIE66/gZy2LxEPqR3I2BF8mNKWENyzsxI4/x0jg9P44//0/sVM
   fsE+l9YKXH5oHnWwg25gCiVml0cqb/SWYb8Yl3VPMgEP5WrHNoo8kkez/
   Pt/7knysH2qhKbY4RZYlgsYJC4EA7OyLdfq8GceuyiRdy2D+EtV8b8Fzj
   ldFkSLz+MM8rvB34dDZBTsGiuZqkB2k8tI8/Pf3tncizIzNA/u212K91m
   coVRgrCErsyH2e02qp36Slj16/um3oMOlylNrT6ZtsEREJru22xwtSNPD
   y9B649tH4B2udim4QmC+HypkNPA70jtvwCV8pCFlGcml8tIcUDmJV2Cla
   Q==;
X-CSE-ConnectionGUID: gGhgRY1PRI+x7c6iYgXCkg==
X-CSE-MsgGUID: DH2q/T06Tg6YQ+xIfu4vHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="45548322"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="45548322"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 03:33:04 -0800
X-CSE-ConnectionGUID: +4KiCjstTsK2oDJZksvpPg==
X-CSE-MsgGUID: GEkTcBQIQYKdKCMivMJpLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102493185"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 03:33:01 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 03:33:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 03:33:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 03:33:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKX3/Kx1GPbfJJt5EZuvfGz4ovPt1qkOxZ9ihSPvdmWWM+EPeCjVvxMQaKPIEBp8kFc5oU2nxghDXBGjLQzOyodxWrpA7nNTgQ8Pkb40N+8r/p0uYRt1/yhkvjmr2bjxZo4wIDzeRz6RJgRz7hPmLMCvWOTUXNN6poa8MvLMFerOHxnH11bM92yOHnqC9Ca0cRamvQzw5u6Z7dcIEZohukInauKu9riPcl2YU/sSjjVx25fBAl+PY1I2g0HuM43WgAF419mpUK8az63YQRAvqdHjQJGMAto3q5PChqRWMz1vEvdl9p5T73xwrChClMB9urkdErbPyJIREeWmPbjQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5NRAILgd9NfI0BOWG1RMrEl4qjp5qFEDy8ayR0PTE4=;
 b=c+0udmCmtho2oszvNhuNfYTm+Tadi5Ry7HW8peHvuRhIuDSoOZPEhhQq6inX+ZYjQ7YcM2Del8M8LfDel3SdqAAAwCtmh1j2Si+FGO39Bsx/I6w4LqF0TghkzG9+tthPu9yy+1TYJZX6upR5+pBsyf4D1w6TVceeWRAYcDBp4L+RRSmMuH6kCFY2rknXTkAudyT6Furl2z+lCIeu1Bqdgmp7VvAZ38xAMufGW0UkUi5H2OH90TjL9rTMuxder7XU8R+Y2WtyZ/UgCEsuJkdznftSbfEYNKz2dVPLGQQGuWHZOhY9yWXq9l+mucFwkxfqXD5I1i/2td49OrAmKvYZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 11:33:01 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 11:33:01 +0000
Message-ID: <abfe7b20-61d7-4b5f-908c-170697429900@intel.com>
Date: Tue, 17 Dec 2024 12:32:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/12] net/mlx5: LAG, Refactor lag logic
To: rongwei liu <rongweil@nvidia.com>
CC: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Leon
 Romanovsky" <leonro@nvidia.com>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-3-tariqt@nvidia.com>
 <93a38917-954c-48bb-a637-011533649ed1@intel.com>
 <981b2b0f-9c35-4968-a5e8-dd0d36ebec05@nvidia.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <981b2b0f-9c35-4968-a5e8-dd0d36ebec05@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0121.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f800ad6-d4f2-4929-451a-08dd1e8e8ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NElLcTdKZzBIZGtWNWRabWdNNFlXS3RjSGRMNzhNR2wwVFlKK2JzdU5qRTBj?=
 =?utf-8?B?QzBNRVV0akdyUFpkTVNRcENtbUZOb2tDaFRvT1puakVpcmlOeS9paS9HT2JN?=
 =?utf-8?B?S0RONC9KdUQrdDkrODhzUktxdS80Ny9aMm1IazVReVlYeUhDK21naXRmci9E?=
 =?utf-8?B?NWtMUmhYSmZydjlGRDRMcHJOS1hQYjgzU2hyRzY4MktBZU01eE5RbmNJcU1I?=
 =?utf-8?B?Wmc4cERnMHhIN0oxMFVqWGxTN0xPZmVUaEdwVEhjeDR2ZVVGSGZmVENVWTVZ?=
 =?utf-8?B?MEJnZ3o5MHBUSjcvY29PVElLNTdaSVhGYU9CemtodE1lMk05d1BsTk5xR25h?=
 =?utf-8?B?MUhiNEhwYTRRaUQxb2pReHU2OW5sNGFhQkl2SnlYRFZFT0hmcGx3dWpVREhy?=
 =?utf-8?B?WVE3bFZCR3kzM3hpR2FQckhWVWxUcVY2ZWJQZTN0bnBaeUhFazRuWWVCL3pt?=
 =?utf-8?B?T3lZd3BJSmJwR1NuTVFPczV6T2U4a3l4NWpFMExQdjhPUkNqbmZDRFh5WFFM?=
 =?utf-8?B?aGhmT0FNamhLTUpNdFM2N1lXUTM4RGxxUEpJRUZwNENsR1RHdUV5SVNENWdm?=
 =?utf-8?B?R2RXWW1jWDUxQ2hncWszSmhRRmFRZWlGZ2F3WklMeTQxcDhid0M1ZzRGcFRu?=
 =?utf-8?B?bEQ4cDI2L0lZaWF5bkMrTUdEcWFvTmRtNUlYNUhjUnNYRTY5TFJ0YlY0dTM2?=
 =?utf-8?B?SHFSS21LRHVnMjF4VVowVjg2MEZhVVhrUjlHTld0N0MwS05hQ2tZTzZkekQ0?=
 =?utf-8?B?UER0Mm16ZUdSVEl5ZXBqOU56WUFFaUNJUUcxT2FZSEkzQmxCVkpkandQR2p3?=
 =?utf-8?B?cWtNd0U5WmFLOFpBTHF3alg4ZGRWbEdHeEMwTkdrNVlvckV1dVRPWnZOU3ho?=
 =?utf-8?B?VXp5YlVsSFptakRxTE5pUDlXUVhURGNHUjRESWRqVzJyeWt3L3dqQlk3MGpG?=
 =?utf-8?B?Yk1SSmZSdHA3NHdwVW9jNkEzMlZiK2RzaTd0VzZqb24xQXJwem9RdDBDWmNL?=
 =?utf-8?B?REc2bzZyZjcvZTJ5K0RFcHBGcVpCUk4zS1c5cmhENVJrcG9HWXBrVkpuS2Vq?=
 =?utf-8?B?dHJjeFpFWXNMRFJVSWRVSFZBeENaU3lLLzNabUFYVHFKZW1jN2hpQm1tbS9R?=
 =?utf-8?B?ZUkyR1NhMWdIMm12QUo4TWlRMlNjeUNpcDI0MmRSN3p3bXo3Mm9adjFETkww?=
 =?utf-8?B?T2NDeEM2dTRVU3A1c2ZGWTk3QmFXOHAxOUhZK21sYUExTmxWd2dHZEpJdm00?=
 =?utf-8?B?Qm1zZnp5YlRuZVoyaG5CdFJvOGpkaVJKbFdwc2VJblgvZTlIMm5RMWZJZjhS?=
 =?utf-8?B?NXZzbXhJbDFLM0VvQkRlME1rZXFHRjM2YW9TbGhWdnlvTzFQOVhsdGRHTlhO?=
 =?utf-8?B?aFkyQXI4RXpQL3NWcTJsOW13RUhJaVRMOERSdi9sLzlBVjBYSHdNZXU0YThu?=
 =?utf-8?B?VjFkdUpqV3U1L1c4VUdoSHBZbEl0c2R0V0RFSDJubENvMnovanNlVk5kdkYv?=
 =?utf-8?B?aGRJeGF2TGk2SldHTVhjYkJ0ZmZrZjcvVGtBVUtscU55UmRSMW43Sll0dzF4?=
 =?utf-8?B?ZXMvMkhRaXlGdVpQeUhNaEZuSUxWQUlTZlNzKzJrVlA0VUtvRGxZOUQyZjZr?=
 =?utf-8?B?WHFXTTI2aWhnSVhzZlhmZy9OMlU0ZDhFbmJVQ0VZa0FCQk9iMW1uYTVOeVc0?=
 =?utf-8?B?M1NUWHg4SWNTVjZYK1JadVVhU0NXTkRxOU5hblpVa0lRTWY4cldTYXk5WTFG?=
 =?utf-8?B?b1QrcEh5NXJwaHFyNHEvN2lzLzhKVkdER3pCTHZVYUovdVVHdlhkQzBWemRq?=
 =?utf-8?B?SW5JSmV4R0RlZlpFdHlhM3FUZExsUUY5US9zN3liYkNZQXZUdXRXc3NqeWlh?=
 =?utf-8?Q?TWM4nOYdNXlcx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2lObXdzbDhZcVJ4MWZyZUVFVU9BWDNBa1VVZ3dHTGh5WlA4QmFiYWMxajBQ?=
 =?utf-8?B?SUJpakxCOXQ1WjFubUt0ek8rcHJ1REl1bUFiR2Y3eGZsbjRLUHFTZXh2eXdI?=
 =?utf-8?B?S1VuK1EvejRqOHFsYk1IYjBJOCt2cU51SFcxKzVqL0lRYWhmbVBMUjZlVytD?=
 =?utf-8?B?aFhsVFAybFN6dHVXTGlGNW1PQU1tWGVFVllncVExK0lWZ0pzaGNUNlBQSVZv?=
 =?utf-8?B?VFE4U3BQTm9icFZHK0JkTVRVNC8xMWJGbVlUNlFDWjVzQzYxTXhFb21YVncz?=
 =?utf-8?B?a3hFemRmeTlDRFpabzBMSThkd1g5SEFBbTZEaWdtSXlmbm1rNk9xRW5TWEZr?=
 =?utf-8?B?cGdXTkU4eGc1NExINlFhQml4dTRocTZDaGNpZnJiWWYvUTRLck5vQmtqdnli?=
 =?utf-8?B?ZWNOak1zMDVsNlIxWnc3RXo3cjhnRlZ1L3ZucDFyQ2duVFNBWkJWVG1CSElU?=
 =?utf-8?B?ZnFMV0FJK2RueG1maVdNdjhMdmQybTB0Z0pCNkErajBPdEJQc2o3cjR1MmF4?=
 =?utf-8?B?eEJiVDYzaWlqZTJXUW5oeGRXZEdGVE5LL255MXBjRUJGemwyRGZkeFY5Qkh1?=
 =?utf-8?B?bE9IUDVWR2V1dzh2eWI0dzhYVUsyUHI4dVVsMnhNNUxjR25iR2UzT3pnZVZJ?=
 =?utf-8?B?WmZnUEVjNHo1eVlUNzUwVFVMSWRpNWZtcVB2ek5za2RqVTVMdHZqdkRMMVpQ?=
 =?utf-8?B?eHRwVHdQa1dxRm1nREtNZTVZTkZvdHcwb3NzQTNid0E4aWw1bzdMbi9pelI1?=
 =?utf-8?B?VGxCYmhKUmZWci9nSHFGLzI4MUJLaEVXZmhoS0V2Zm54UFlhUTNnMXJvTFRB?=
 =?utf-8?B?QXJMNStxTE05TXZLUFVWaVdSNUFjSWdvVERzN3dsdnY5cUpodDA4N1ZUM1J1?=
 =?utf-8?B?WFdLTmhhSmJLck1JYmJZSXpPRDNERFBoZm40QnYwR2gzN1Yzc21qWjF0bmlX?=
 =?utf-8?B?V0lvdlp1T28rMjkzNVR6a0p3cVdPSWFxZVUvUzR2OSthZVBIZ1hWM0pOeWtq?=
 =?utf-8?B?TWE5d1dXTk10ajNrT3ViNlVUOEc4Y1dheEl0NDhma2dia1hXQS9icHpDWTlS?=
 =?utf-8?B?SjYya0doNzd4Zyt4YmlaeERkQzJnTzQ0R0ZQRHZWbnUwTi9aN3NsQWFZUTk1?=
 =?utf-8?B?VnUvSE1zcnY5VHJ6ZGNXa1h0dzBtUndSdUUzWmJ2akQzd3pSV3FFL1FWdlpH?=
 =?utf-8?B?dzFPdGtkYW54OFVRM29kd1JTWk5tak1xR0FKQm16N0VtZmlRTjA4aXVDUHU4?=
 =?utf-8?B?dDNheVM2NTc2VmFiWnd6aW95c1J2QnViY1NQeEhzVlJhN09XdmE2dGs2VWFO?=
 =?utf-8?B?SU1iYWlOdlRMMWd0dS9SWDZnOStuZ1YxbVZOdzVvMmN3SDYvU1JZQzlVdjFY?=
 =?utf-8?B?dHNTdjloaWJlYUk1ZjV3MFZFV1JkbW5LUi83ZzhlS2RZWVR6djkvZzZ6TnFs?=
 =?utf-8?B?dTFTZFRwVXo5V1NBRmZiZERvU2lKa2xEQmdGS0c5S05TaW9vdVQvR3lYSzY4?=
 =?utf-8?B?Z2VUd0FwM0ZWVWFaVlpoVWZwN09sQ2xRUGpDS0lFa2FOODFmbXM1MFNGbjJz?=
 =?utf-8?B?ZXkrS1JZWmxMY1lhVm96QTRsTnZVT0orOUVLNGVJRE5hNGNubFJxeXNEUnNu?=
 =?utf-8?B?aVRaQ3IvM1YycUNnTVdOazVNakRJdjF5U2I5cEJNVnBuenRPOU9PQmIvbEZN?=
 =?utf-8?B?THV1ZWpRUm9OVkRKYlhsQUo3QkZHNE5BTXlVeGV3ejc4TnF6Wmsva3NCT1pI?=
 =?utf-8?B?eFBoZG80TU1yYXlUcmI2SEE2cXg3c2hOWE5hcU0wcHpGRHJSYWsyMUFzY0lB?=
 =?utf-8?B?cHR2N1ZKSnhaS2NHTVN6M0RreDBoTnpxaXhUR3pXd0ludXRhWC94Mm1uYkk4?=
 =?utf-8?B?RjVYbGkzOUJKeEdCWXpUdVZPdGZxQnRmRGFTVjhxcFdwaGtFRTltTmNWb3d0?=
 =?utf-8?B?YURFanU1SHJ3RkNvK1FOOHpIQnpJN2xLRUEweWlrZUFiOVlPVHhIbW51Z3pl?=
 =?utf-8?B?bUdGbmJjRFhJMmt3T2RRaS9ObnZNeHRRYzJoK0hIZUhpNjB0NVVvSWZhMDF3?=
 =?utf-8?B?S0xqemUvNENZV0JzQTU3RHpleE1jKy9hai9wWFFITlZPVjlTQ1lrUmNCRFlS?=
 =?utf-8?B?cStMK3NsQkZvSDRJN3pkbktFbzVWcFhzNXpvZS9hR01wcW13d2tWR3lZQzFB?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f800ad6-d4f2-4929-451a-08dd1e8e8ffa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 11:33:00.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4uEIvYcC47kDaoZ8w5OK9bHBpD2fyP/IIcSGLvzO4JOS6X0Rt+vN0ch8t3gyZ6Uu58flSNyJv2tciUPzjoQlDKBtOwDYEP8xsI7kNw/50E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com

From: Rongwei Liu <rongweil@nvidia.com>
Date: Tue, 17 Dec 2024 13:44:07 +0800

> 
> 
> On 2024/12/17 01:55, Alexander Lobakin wrote:
>> From: Tariq Toukan <tariqt@nvidia.com>
>> Date: Wed, 11 Dec 2024 15:42:13 +0200
>>
>>> From: Rongwei Liu <rongweil@nvidia.com>
>>>
>>> Wrap the lag pf access into two new macros:
>>> 1. ldev_for_each()
>>> 2. ldev_for_each_reverse()
>>> The maximum number of lag ports and the index to `natvie_port_num`
>>> mapping will be handled by the two new macros.
>>> Users shouldn't use the for loop anymore.
>>
>> [...]
>>
>>> @@ -1417,6 +1398,26 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
>>>  	mlx5_queue_bond_work(ldev, 0);
>>>  }
>>>  
>>> +int get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = start_idx; i >= end_idx; i--)
>>> +		if (ldev->pf[i].dev)
>>> +			return i;
>>> +	return -1;
>>> +}
>>> +
>>> +int get_next_ldev_func(struct mlx5_lag *ldev, int start_idx)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = start_idx; i < MLX5_MAX_PORTS; i++)
>>> +		if (ldev->pf[i].dev)
>>> +			return i;
>>> +	return MLX5_MAX_PORTS;
>>> +}
>>
>> Why aren't these two prefixed with mlx5?
>> We can have. No mlx5 prefix aligns with "ldev_for_each/ldev_for_each_reverse()", simple, short and meaningful.

All drivers must have its symbols prefixed, otherwise there might be
name conflicts at anytime and also it's not clear where a definition
comes from if it's not prefixed.

>>> +
>>>  bool mlx5_lag_is_roce(struct mlx5_core_dev *dev)
>>>  {
>>>  	struct mlx5_lag *ldev;
>>
>> [...]
>>
>>>  
>>> +#define ldev_for_each(i, start_index, ldev) \
>>> +	for (int tmp = start_index; tmp = get_next_ldev_func(ldev, tmp), \
>>> +	     i = tmp, tmp < MLX5_MAX_PORTS; tmp++)
>>> +
>>> +#define ldev_for_each_reverse(i, start_index, end_index, ldev)      \
>>> +	for (int tmp = start_index, tmp1 = end_index; \
>>> +	     tmp = get_pre_ldev_func(ldev, tmp, tmp1), \
>>> +	     i = tmp, tmp >= tmp1; tmp--)
>>
>> Same?
> Reverse is used to the error handling. Add end index is more convenient.
> Of course, we can remove the end_index. 
> But all the logic need to add:
> 	if (i < end_index)
> 		break;
> If no strong comments, I would like to keep as now.

By "same?" I meant that there two are also not prefixed with mlx5_, the
same as the two above.

Thanks,
Olek

