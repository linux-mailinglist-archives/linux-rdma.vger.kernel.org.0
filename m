Return-Path: <linux-rdma+bounces-7720-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA4A33F61
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 13:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B267A4E0F
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B3221706;
	Thu, 13 Feb 2025 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3aaFnEk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F2221570;
	Thu, 13 Feb 2025 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450608; cv=fail; b=uwIFxXL69tn4U56HL6OhlteswKrNxyJqMZOououwwLTk88/8wloOOyoqK3PGdTp03KZXbk1bVo/NNNrqmnKNJWkHltLjlV1pN7vajo0ne1jh/j5SADekUv/914i0wbUKBJEg0KMJvb+mS5heM5hL9f7u1aZPirLjQCrUThBxlCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450608; c=relaxed/simple;
	bh=Tk4+4R+I0+mmtbFbVSp2n2RvY07siVnm7wulWT2YJTg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4QDhEMzqjiucjcvIsVD2I5+WcA261vCz6BgDmEJao+jegekGCf9zJUmox0t152YaYE5IDVgx46azEX2hDbGtcwA7pgGPOlLSM0pRoo60gw7JlspU4uLPqw5Ro06CNJgz6nKplbsknZdGVzjxlkMgVVyChFef3wXIodsoJDC1tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3aaFnEk; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739450606; x=1770986606;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tk4+4R+I0+mmtbFbVSp2n2RvY07siVnm7wulWT2YJTg=;
  b=m3aaFnEkqz4lbxT52SkZO1rl3L1OQ+tbeloZPnmqm0ePO33yBSX7LcrL
   75zeIrk6dE9BItbWQPjhDtl6ZZSSJ7GcrCigBqVwKjoXE8Yo0hCGLCnbH
   Ao310lCErhEWW/soSBVY6Z+5KBk5aRrFxUbbICEZuOS4j/tbzmc8jqT8w
   XTsrZlBMuujMhkpDKOV2xTLpfXGQbkbvcTcfre01t+d473EnPX810HZPu
   ulC3/d6YhHH+8aQyJ9/ESHkxvhbVbTo72p082ka2UdrxJUFBDmoVryNVs
   OR2n99UjO7J17ovJksYlLoyWQfcoHAXRYYWjNr28X23+J04DaeqbxXOZ0
   w==;
X-CSE-ConnectionGUID: sJQhGn0FRUmGUPPNeKs5iA==
X-CSE-MsgGUID: VE8RGsRYRXuNuF8N/VP+0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40272308"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40272308"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 04:43:23 -0800
X-CSE-ConnectionGUID: P5EcbRm6SsWKmGFgTjr1YA==
X-CSE-MsgGUID: 4TBHJm+DRm6mLfIOfd6Z3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112891054"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 04:43:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 04:43:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 04:43:22 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 04:43:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvAfPcBP9H5i4bdLtJmkd8Pqc+hQaIpjb7jwPPKlQGOBPeeQ9lxhhaZhQ7lxxFKocjRfuYWoxFBfKfzWDSX1YwMjDI6o2KHj7fCMD7r6MP1WIs6hg0FZQwbVIduU0UlZp60gIxqVOpnw412MSycSNDQFiiUyi0eDXGGbPH1q0UZQ3Ap6GD63l2Lx08zsDzn27yyeUcLq2QqKVmIvk8Dl784YobJs3qsfR2HKsT7gHId8/oNT4ofgKTM3OGDGgIfmaMvmiIR+tTzNXf38Y9Cj1oTG0axBet8W5yan5gHCGkfJU1QBndUDBwdW9OplrhMhJS3aIX+5L61k/faNB7LWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6PevJEYgSCFM4VY00lh51QqIykctUAqodZ9MnBcqoM=;
 b=W159Bzp0JeFeRSsetRDVKUtW03g/OaEf7ZvIo6y5Hrm9jwr0WtQul+ftC9e1bALlbzJXediSGztejii5GB6qvEB1kgcxs6q9vTZMyFtWwe7rz5zuPSje+q+EPO73i3R9TR5IibatQ5oV8a2snvebA661oRGRKaoH76rNDpZ3e3rylj+fh/bnfY6JpRxxyPAElCGOOmVayXXITBryGMKv2LLfatnGTrPTPXhVI9rg6RimuMoW5kixLAhbbJXBvsrvwzDTiwdiMwGe6kENBe57Ptkj4J1qpE36UFNCLenXanv52iOrJWhTSaFzXOiTqOydfJDnmBlnKW110oyWBX4QMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ0PR11MB6815.namprd11.prod.outlook.com (2603:10b6:a03:484::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 12:42:52 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 12:42:52 +0000
Message-ID: <b25e45e0-7c37-4e93-8372-e3fbfc3b7903@intel.com>
Date: Thu, 13 Feb 2025 13:42:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] fwctl: Basic ioctl dispatch for the character
 device
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, "Daniel
 Vetter" <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, "David
 Ahern" <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>, "Christoph
 Hellwig" <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, "Nelson, Shannon" <shannon.nelson@amd.com>
References: <2-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <2-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0039.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::28) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ0PR11MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d53b430-edb3-4b2c-07d0-08dd4c2bee57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjRVZzMxYVNnb1Z4Njd3OFRhOXlqNUlWU1BZVEJ2c09TOXB0RWJpUlVrYjBZ?=
 =?utf-8?B?eHFCZ3dIckNBa2NnYU1kMUl4a1BRdmtqVmRzNHIrZXZOUU1TZm11OFFNdVEy?=
 =?utf-8?B?R043dHRpT3hONmpyRmY0RGtLNlhibEpNWUJ3WU5xNFlMT09PN1NMb1lGTkNI?=
 =?utf-8?B?MlhpQldTbnBpZWtuRXczcXhYVTB3UmJlbnVyelRPRXJCRzYvRmVHTjNqcnBv?=
 =?utf-8?B?cUx3bUlXNXYyN3hON3hUdFdMUzNuZmRROHFQZlpnQXkzQzUvbzRJekF4cTJp?=
 =?utf-8?B?TFBROC9tTkR4dkNSc3Uyc2dxNFgrSnlOOFJFSUlqQXQ4RkUyLytjZzVyN1BJ?=
 =?utf-8?B?cnF1Z3RYTlR1UUl6K092NWVCV3JURXZzNFlIdzY4enlRSWxzR2hhcXZBZGFM?=
 =?utf-8?B?WlZPRGVhVVdpN0dMejJib2NIOGEyZWYraTdMSGJsdjFRWjNnWmxyZ09XVk1H?=
 =?utf-8?B?bnJJcDlnNVZiSDlQV3E4d2JLWHkyb2RVVkY0TFM2Y3E2Y0ZEQkt4aXVBWlVG?=
 =?utf-8?B?UjJ2MG11aGI2d0tsSkVZbU43RXZDZ2J0d2ZCUERXSkZvYXFCY1ZwcnJRL0Fm?=
 =?utf-8?B?QXJ4RHlGd093MDY0Q1cwYzBieTJFZ3ZQVjM5aXJqN3ZLY2pJL2dpNVdhSmVB?=
 =?utf-8?B?YVFpUGlJdGcycGJUUlpMSldPVlNOK2xtNjlGVXZDTHpwVVR5cXlMQVJ5bzhs?=
 =?utf-8?B?UGRBRzljVUNnbWJVdEgvZHlmbWNtY09vdWxVcWJrQzE0SmhnR2xvTUlhNGMr?=
 =?utf-8?B?Vml4NFpDY2szdGF2UmNuWlMvWHgwS2hBMHcwWkE3RStQM3hsemtuWitoOUpC?=
 =?utf-8?B?SFZKdmlwZ1BXMm85Y1gxZkVOQktkOXlyUU5PT1o5bitMemhVNDhBS0cyNmIz?=
 =?utf-8?B?SnZwWlZhK3ZEU2FLNUdwcXpJd3RLbVlkUmNwWEI2Zy9YbEorN2poY20wY3dY?=
 =?utf-8?B?aFhaNjF0TG14YTd5UTZ0dGxnSFpVcEtqOUdyaHE4THRiWDBRWjNTY2FmdCtC?=
 =?utf-8?B?c2JIY1hiYlQvcVNyUHRvTWVWUVlRLytRS1M2OHJSRWRuYVIrU0lLYjZYWGtQ?=
 =?utf-8?B?dGtJSVRuNTkvVGlQSHUrOEhLYnhzVTVETzJsQVRLd3czTGtlRXduVkoyN3k3?=
 =?utf-8?B?TklJQTFIMDYrZlBwOWl2OTd5OStSeW1YcFQ4MDBsTG9tUlVLdnNwSjZIWkdK?=
 =?utf-8?B?MlFrWENMWklMakZDNFNXYlJReWpZL0twcERqaDlWLys2OGcwN1laaGx5WnpI?=
 =?utf-8?B?NzRTcmJjbEc2WnV2UzY3aEwwajNpSWJEMFZDRk1sSWhxU2licWV5ekZGdkpZ?=
 =?utf-8?B?TmhxNWJUL0pJc2tDOXB2RVgyR1hGR0lDR29sRGlOQ21FdzF6b3puRGZrbUZP?=
 =?utf-8?B?RGRuc2ltckI5T01udzBYNmczckFlSTY1Y3h4Ny92RUNUQ2lCQk93bnFvTXJn?=
 =?utf-8?B?SU9MalZSbG9LdkF4aGtZaVVRSmszUkFVZHdQMkFqT1lnSVlwNUJNKytlMko0?=
 =?utf-8?B?bzZoVWI5QjdNdk1JNUxUNWpPNVRycTdXSjRVaVdLekhGL0ZXNGRmZHNhSytZ?=
 =?utf-8?B?NmcyM0w5ZVJpeVJRS3RXQUVwT1BWYjlWY3k3R251TlltY2NYM2tZUFJQRFVs?=
 =?utf-8?B?UVNHMmNlRVhnUUhFY3pVSGorbkw3c2xobHlhL2RYcVFmRWVxUWMzMkM0d1Bp?=
 =?utf-8?B?NUlXdENzMmtnaFJWOFlxaHp1WVBRTnRQUmhsOWRpT0VjbVBvTUFCTmFMN3Fr?=
 =?utf-8?B?U2hQclRpZzFrc1FvTUxmOFY3dEhnMDRxYzBxOHhVMi8zd2hPb1VLcHhxdmMr?=
 =?utf-8?B?MTYxT1AxNG8yS3RsTnpROFprdHdHYXdqcFRyalpXM1NFNGRIdGR1dDI2QzJ2?=
 =?utf-8?Q?p7qe7eBalQTEo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZiOEZlNlJYOVZtemNMSVV4YW1jb3R4NkhCcTFUMDNEa3Q1R05nM3RIbDZ3?=
 =?utf-8?B?dlJ1M25xQklmUXFTN0grY2NERWRueUw5TTZBenZJRllhQmgvNS9sWXorc3hI?=
 =?utf-8?B?N21NQzE1NFRCbEgxc3FmTGJ0cHBjRURaa005UU9jM3FIc1FnK1hKNTU3Z0Ni?=
 =?utf-8?B?QUtqUnNSSVgvNG1pQUhnUE1UbHpmZTJUUzZYdjNpMmN4Zmx4SlQ2K2JlMnFV?=
 =?utf-8?B?VDBUMWxGbnZLYnRSdUVGblB1RGtiUG9LZ29DSC90bDBoWFk4bTFZclV2MUR2?=
 =?utf-8?B?VEd0TlpZaU1ONjdhandtWkx5K1FLaWd6d003RmNtbk94RTF1ZWJMREFrcEpz?=
 =?utf-8?B?SUFUZHg0VGJoV2xoNjBsb3JyRzNMK3ZWc3ZOZE1VaTRPdEVqOUZEaU03UC9t?=
 =?utf-8?B?aS9LREVoNXlScWo3akswUUNmdWd6MEsvSm1RMjlYdHhzNnd3TFgyQjV6dm8x?=
 =?utf-8?B?czBZWnFCQ3ZvQXVZR0xGWEtBUHZXYzdUT3Yzamthb0JKQ2pCckJjUERGR0Zl?=
 =?utf-8?B?MEM1OWt6TldkOWc3bCtjVmE3aW5BOHVBL2dHdUtPc0NaeHRMMEQ3TlpyRSta?=
 =?utf-8?B?UzhuTkZTMklTM1Z2VkFDbHRyVyt3VWZoNnIyUmgwM0wvN0tuOHVuSUNjY0N3?=
 =?utf-8?B?VEZ5bU1aWDFFUjJmbGlJVmlmSzJlMmdjZXNwdVJaQVdOSTV5cFZqR1FrVEpv?=
 =?utf-8?B?ZnhoakREUU5Ed3dKODViSko5WktvQ043aDVYL3dSQ1poODQvYTdNOEFWV2s1?=
 =?utf-8?B?YzJvbENWazZCd2FBZnJkdkJhWmxRTkFuWWY1bG1tekVOYTdBWU51ZzFmc3oz?=
 =?utf-8?B?RDdNMUNHKzdneGZEN095eWZNeGdoL1VEMCsySVhxb09ZbHl6SytzK3JoTE1Q?=
 =?utf-8?B?cEdVa3JZRXVpYW0zNlNKb1JZSHgzRHJLRzdhcDRMUkFibno3TFB5QUZ0Y3Br?=
 =?utf-8?B?RGhuZjdkQ01zejZqZjNNUW51azR5UnRBVEpjS2FJcjVSTXlWN2p3dzFoU2o4?=
 =?utf-8?B?eFFMN0x2cFBCRVk4TXNPM1BuVGN0clZmR2RHZEpUMXNMSC81UHFDN1U4TTdU?=
 =?utf-8?B?cW12R3hsZnZ2aGppSDZPOTV6NENpWlAxMm8wTGpieDhrNk00ekVjZW0yNVpj?=
 =?utf-8?B?ZnpOUExPZDhNRDJJZHlabWtRSENjUXlWb2d6VmJJMHpCVFBQSmlmL0cwaWFO?=
 =?utf-8?B?eW9LdnhEdE5pNGpZNy9SWVZNck1UNTI0cEZxcTBWRlRQSVdESHVtRkxUZllQ?=
 =?utf-8?B?UHpFcFZDVjNyL3hIVWNGMHo5Y1c2NDMzMDFwS0NjODJmL0d3QXBQTy9vRUxG?=
 =?utf-8?B?OFZVZnpaRDI5emY3aGxEaGMzRHk3cmdPUk5UYUFiMXlFditXRlZzWDB3SmRJ?=
 =?utf-8?B?TlpZMEZGL1hUdWpTVll0anI1ZUdWWXpNT2Z2VEJwWlh5TWl0T3RDbVlmN1Bp?=
 =?utf-8?B?R2YyaTJtcTY2cEZIWVIxNHRRb01SK1h5V29aNWFKYTJuQSsxNXl5SmZsTklE?=
 =?utf-8?B?Wk9KU2J4VTBoR3NiQzJwV1FiUTg3MkMwSEVHWXNMakl0ZzZ4bTBzZDA1S1lE?=
 =?utf-8?B?enoxV1NuMk5iR3hWT3lTWDZzallTMVhpeXpwcURocGZNcFNHTG1mMDNFMGdS?=
 =?utf-8?B?b3d6Y3hVU3Y0VVA0clcwcWtITCtoQ1FWdXdyd2dDVVRxUXdtMzRlV2NpS0FT?=
 =?utf-8?B?cndGeXhUdzJIbE1qSjhBOU5idlIybDU2L1R6UHBlM0MwOUNoOVFKZVoyNFgw?=
 =?utf-8?B?azlzcW92TExveUNpTFluekJSZUhlc2J5andkdE5jeVpPdWdobXVKbERFdFdy?=
 =?utf-8?B?aTRYOUtZaGJFMVhkL1lDR2QyWTRDdGZJY3FMZTVQejJQVEFlMUVTcWRoc2Fn?=
 =?utf-8?B?SVR4Rmw3d0JYL1llSkN3dld2UnpBSk11TzJ0d0ZlaVg1WlBMeDFkcnhSRzdC?=
 =?utf-8?B?TkkyRlVoYVRublhDTVQ5RzR1SUhyQWR0Y1luQ3VCWklwdEM2M0VvNlBsVE5J?=
 =?utf-8?B?aTQwZWNSS2dxM0hXYzc5N3BLeFlzVFJnT3NFWEM3NGdnREFXTGJiWi9VS3VK?=
 =?utf-8?B?NGxFTUh3Z29vdFd5c0RJL2IraXZzaVR1WG1BNEozYzNBb1VkdENOaXErREh5?=
 =?utf-8?B?R3lhaUdGUlpvMk5kZ1JTR3pZbUg2WitPMDBIQ0twK241NVZaZHVrSFJQNWMx?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d53b430-edb3-4b2c-07d0-08dd4c2bee57
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:42:52.3652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poRle0yezSXnxPqNDN3P3M6BApd+8FtfyyKlcJwbfGaz/shZqLLT+3Cz+V3BIz4bMyo/z/Q02/iPmOZyEecn2uNRV4ObFm1YsEhhTPgw4VA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6815
X-OriginatorOrg: intel.com

On 2/7/25 01:13, Jason Gunthorpe wrote:
> Each file descriptor gets a chunk of per-FD driver specific context that
> allows the driver to attach a device specific struct to. The core code
> takes care of the memory lifetime for this structure.
> 
> The ioctl dispatch and design is based on what was built for iommufd. The
> ioctls have a struct which has a combined in/out behavior with a typical
> 'zero pad' scheme for future extension and backwards compatibility.
> 
> Like iommufd some shared logic does most of the ioctl marshalling and
> compatibility work and tables diatches to some function pointers for
> each unique iotcl.
> 
> This approach has proven to work quite well in the iommufd and rdma
> subsystems.
> 
> Allocate an ioctl number space for the subsystem.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>


> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index 34946bdc3bf3d7..d561deaf2b86d8 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c
> @@ -10,6 +10,8 @@
>   #include <linux/module.h>
>   #include <linux/slab.h>
>   
> +#include <uapi/fwctl/fwctl.h>
> +
>   enum {
>   	FWCTL_MAX_DEVICES = 4096,
>   };
> @@ -18,20 +20,128 @@ static_assert(FWCTL_MAX_DEVICES < (1U << MINORBITS));
>   static dev_t fwctl_dev;
>   static DEFINE_IDA(fwctl_ida);
>   
> +struct fwctl_ucmd {
> +	struct fwctl_uctx *uctx;
> +	void __user *ubuffer;
> +	void *cmd;
> +	u32 user_size;
> +};
> +
> +/* On stack memory for the ioctl structs */
> +union ucmd_buffer {

for most names you follow the usual prefixing rules, would be good
to do for all



