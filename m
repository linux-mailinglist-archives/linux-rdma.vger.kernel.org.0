Return-Path: <linux-rdma+bounces-8818-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1B1A689E9
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 11:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28CD19C2CAA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D69253B48;
	Wed, 19 Mar 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIytO01w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A022F19;
	Wed, 19 Mar 2025 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381189; cv=fail; b=i3+QyTkW44evbN2g3Te/YtVMgnHYsBCHT7CVMy9r7UZA3cw5sovyrdomzJN70UHi/dUeiBHgeYn/w/WHG0qR11vGnmCTR9nRLk2Mea7+S38jY/s4NctTmY8ZXYInd8Stt3tjwpEZrYR87D8hxLSPje6i/rBqI1qEfQnteysOez8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381189; c=relaxed/simple;
	bh=dEnXFD3SF3+zr1vNvUDTUiNCiQAPcHm/BAEpjvBIwuI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NRT0iATdAmLkc4XkvSBVuiMO+qOZi0NcsJu5wtgEiTj2Wx5giy5e/rS4cCYUIfDoe/9IPUQ/Tk5PdA6A7eCkrhQYNlXSsmBsYnyd8otjnb5htt0Oh6lh1Ust9AzbxSrTttrGPP5kJqjo3nO6DtcqWIjB2zQC84you/ADnE6Sw1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIytO01w; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742381188; x=1773917188;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dEnXFD3SF3+zr1vNvUDTUiNCiQAPcHm/BAEpjvBIwuI=;
  b=nIytO01wwKrmN+botnE4eiBN7dK7TIU9/ffQwhQnZUQdsJFbdgr1t6oK
   PHQDhlQZqrpjO89Fmh4YvOV2NNKgUzaJIONiF3LHK3/TXGxx46uG7s/dT
   JRqCiFZnaGYfVHcEqLRh+gSxhTQn9H55ASgFcv4sSmZHoFNfP4jJ4+nya
   QCTvjRGcY+x5WkbUiMbnGo8NgDaVzErxW+EKrxuLx3EbZnJBXrqXXCLIV
   leSKQHW0MBM/zhD22xkX+rowkQdmrO9Yba6fiyoKyfzYc3SsRkpIstU2I
   FDgFVgwTtNs1amEN3ruw/xeDvnO4XZ+po08Nt0P3Y2JtDItgHrvdpHC5i
   w==;
X-CSE-ConnectionGUID: oVHrgz6OTeSpZNMVcYwvng==
X-CSE-MsgGUID: R7xwdM3SSDqvuVHosITBzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54557872"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="54557872"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:46:27 -0700
X-CSE-ConnectionGUID: tVcCutgfQPOcbW2qeKFoyQ==
X-CSE-MsgGUID: 8AMekW+OR/qB4BnQGqwpcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122586644"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:46:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 03:46:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 03:46:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 03:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avxCZDHzyEKsPLip+m84L6jww4hp3V94bmhL1mrrXKBtsR0H3MPVh4dyX8DKIZ2B/Ga+M+j2mtdWxkjEgRxtA12eWAHRLnx2mmnnx7DXaJC1f0b/2VhQ/YHz4pqALfyi+5ymABj+cQFox+E76NnvnUfRIgJJPzkGkoPKZMFKWlFetAd1Y++EhzQsVPieRhmp6zlSAXhjJDMtBo3fBObHHYN4eoAPySnROinOuK+E7LXLoMUztYnAc045toOXlgka0rhe6+xYY1UF5Em/fCTZT5t0DEmFMJdblclBpXDsDA7aZ7/R2eRbB02o8GFoXVibeU9cYIu8b51xJpqLaFhPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEnXFD3SF3+zr1vNvUDTUiNCiQAPcHm/BAEpjvBIwuI=;
 b=YZP1obBxp5jK39pLcinZhEyYdOLqzfSajtuBICS1Qo8bVsuNlpyg7Ubg6u8w9zKccJJz+FgRs042+pFu9BZfnUQa7T/+gxbYZm9UIU+RAIyxHGWL77APMSbo6x8QEMdLv/xFpiIjesOPZKlJlYIBqCYCjbMbLVff4Slc1ZUZgC4K4RG7O7ZKtJjbvBQ97vSzAJv5x5MjWdlCKTmmu6TiBcYZG83HM74nqxBoXP78dWmSNxWZMOw0jg3taH/KpbsGCvjMzKi6oZS1h2SLyXf87bGvLRyrFI3FJIeQFJFqg3S1k/zF+w0/HxKML2mU8BRgGLkK5F01HmZzmPTk6iqjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:46:23 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 10:46:22 +0000
Message-ID: <81005d10-15ae-4d85-bf67-9362a2169151@intel.com>
Date: Wed, 19 Mar 2025 11:46:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
To: Leon Romanovsky <leon@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, David Ahern <dsahern@kernel.org>, "Nelson,
 Shannon" <shannon.nelson@amd.com>, Jiri Pirko <jiri@resnulli.us>, "Jakub
 Kicinski" <kuba@kernel.org>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, Daniel Vetter
	<daniel.vetter@ffwll.ch>, "Christoph Hellwig" <hch@infradead.org>, Itay
 Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "Leonid Bloch" <lbloch@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, "Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
References: <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
 <20250317123333.GB9311@nvidia.com>
 <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
 <CO1PR11MB5089AB36220DFEACBF7A5D1CD6DF2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <2025031840-phrasing-rink-c7bb@gregkh> <20250318132528.GR9311@nvidia.com>
 <9e3019af-7817-49db-a293-3242e2962c22@intel.com>
 <2025031836-monastery-imaginary-7f5e@gregkh>
 <95da9782-7c46-4ddc-8d7e-ffb3db31ebc3@intel.com>
 <20250319081416.GE1322339@unreal>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250319081416.GE1322339@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6d5ab0-9844-41c8-dd2c-08dd66d34a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2FEREhRVmUwVTV1N040MGV1ZFBlUCtrQzlVcmVoMTNrY0huTy9WUE5WTTRG?=
 =?utf-8?B?cjltUGFIZG9ldVROYnpieGNjcG5tamhnekM4YWRzRDFiR081dTFaV2JTUTdK?=
 =?utf-8?B?dTdCSDBVWEl6cHVNZFdpc2NFMUw4ZUVNcG5sRXNIVGJwLzBkWEVsNWlqSlN1?=
 =?utf-8?B?WC9EdmU0aTRJOTlha3FrcFZuVGNqWjhVSW1KLzMraGVGVGxhYTFUeDRQM29P?=
 =?utf-8?B?bHYvaHlGd1lFeGZ3aDJlVnFHZnBoQmlKME5KaCs0OEdYMERHRTRzdUhGa1k1?=
 =?utf-8?B?cXJmcFhWc3lzMjk1eGZhOFUxRWdoem9vZndSbTZFYXJ6STM0NXBTOUYwRVVW?=
 =?utf-8?B?RGp5UTd1MlN0WVgwS3FNamtEL2RnYXpJbndyb2NDS3ZFYVk4YUxYc25sRTRv?=
 =?utf-8?B?ODBTckhCM3E2QlovWFlTeXN6UUtvTmlNU0s1cy83MnRXZGhxd0p1clhUaWRJ?=
 =?utf-8?B?OFhWVzhkTXJWd2F6b2RqNUdzaEhuVFQrcWVsQ2ExakxOMlRiTThhNVg3TWdR?=
 =?utf-8?B?TUxtNTA5NnIxcVViMXV5VkwzNUtnMC9DWHlabFhLRk5TV3hWWUdPbXpjc2JV?=
 =?utf-8?B?aUt3QWl5Qys4RWhadTNlMXdqRWpWQWIvc1Z1MkVtOENwalFBYkVua0tieTJL?=
 =?utf-8?B?R1VISVRLNzVzSkZjaTh0aEJQZngxbm9rTFNmUDhoV1U3Y04zYmVkQVJuOHRT?=
 =?utf-8?B?MVZHNEIvck1nUnJlRHU4VkVVTFJWTjJ5S0RzSVBJNHhJa2gzTUlXOHFhZ3JE?=
 =?utf-8?B?cjEwZ2pmSnVqRk5YRlBmNjYvWStFWml2Ui9RU2xUTkpQd3gwZUNQN0ZiWTEv?=
 =?utf-8?B?N1gxN1Nad2x6dlNzMDRBZGtDZVNONXFLWUVTU2R1Y3FrMGkwSlBUeDhuRUh5?=
 =?utf-8?B?MDIvSGZaZFhQbkswRzlmYUcrVmhxSE5vSVpaT255M2YyTDNaOEs1Q0hpN0Fh?=
 =?utf-8?B?ajRzOHEzSFVpeXBZRndiZDA5SStnSTJSQzBnYjlkWVgvY3Fwai9wRytoM1Y4?=
 =?utf-8?B?YlhzRmJrWUNYZVNtVzhWS0Z4QituT3N1Wkt1U0wycVU1a3ZKdFN6cmR3V0Yz?=
 =?utf-8?B?eVRFekppZzhFNDgrbXFlYllZWWhTOUlCZ3psNEdQeWVQbmdGN2hEOUM3c0tu?=
 =?utf-8?B?cDNUZTVSTStBa0lwZ2VzdGZxdTlyNmltTDNESFhheUVwakhMbGY5MGtsWVNL?=
 =?utf-8?B?dlJMajZHeXB3TXcxekhJZFpsWFVBZHp3eElSNnkzSkJCU0RxN2p3b0FMVklJ?=
 =?utf-8?B?ZkF1cXNMbDZFUXRkVVJjZEwzVkg0WnA4QUp6cXUzOVZxOEZVU2VSQU82WVI4?=
 =?utf-8?B?NXM1Zk9wOW5veUVkV09iTFFMNDAxODVOYWRndTVPSnBjN21iZHdQTDBPeUVB?=
 =?utf-8?B?elhnOFd4UWh0NEhNQTAwWlFubUNDVGJxb2tHTFVFNWk5b0lmMmZtQ3JyY1F2?=
 =?utf-8?B?T0RyUjFYWXNyalFnRlJidXBRNWFiaE1zSEdoSHVsWk9YQWdRSmg0QytuMDVn?=
 =?utf-8?B?VWs5MzNLbEdnaHlHNEFqWkRvdllscDY0YStMSWRpTnNLcllZTC9TZzAySzJV?=
 =?utf-8?B?Mm1NdExNRktmUmlUdTlzeFArby9lWGlaUS9mZXg5T0NIdnRveUJMWnMxWUJS?=
 =?utf-8?B?UUw5KzE4V3hxMDZ6VWc5QWJiWXJwWnJEOWJCRXNsM0Vqa1FVMGJPYnlUcTVX?=
 =?utf-8?B?cm1RSllvOFNxRUhQOG5XTkFJUjFhODdOZVowUzBMbU5nU2N2S2VhYUM5eU1w?=
 =?utf-8?B?dXVJTE9vMGJ4Z3dSR3FoRFBBTWtKaE03bWdZdFhwVUtMOHJCeHA3N2E4d3Nn?=
 =?utf-8?B?VkdzRXJtZTBSZ3VXMDVEUXhhU2hudk5vdEwzYjlqMWtoam05NGFUNFRpMXhi?=
 =?utf-8?Q?9EMs5yxyo9V1Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TC9TTXQveHpWajJxbmZ0ZE9wdXdORUE0OGhZbUJhRUJmbDJOcEM2Q3Jwc2Jq?=
 =?utf-8?B?SWZsVUZocGpUakhDelVadDFaYWJOaDMwTkx0VU03TUZLcjU5Um96Z2pQS1Zi?=
 =?utf-8?B?ZWhSWGtVUnAydFBweFpPQWVsUXZtWXM0MmQ2ako3bG41YWFOS2h6UXIxbVNs?=
 =?utf-8?B?WG91d3hJbjR2ZFhZT1JnMmEzNVVhYUFzZ28vMC90aUtwdUVtRC9JTWdHNDhl?=
 =?utf-8?B?RlJkbEN0Z1JxT0t6Wk5XdUJRTi9OZElwTjJ1VDVzb3ZoWlUwT2l2M0RGazFN?=
 =?utf-8?B?RngrcmFOVHNGTENXOFNFSTNGeGx3d2cvM09OM0FZU1JpeklGYXEwSS9hVUZK?=
 =?utf-8?B?OHZhZFJ5Tk1QQWNPL0ZSOGZrQnhKdDBma1lVdmNLSHJvbFppalFKaElTSWJ5?=
 =?utf-8?B?bXJSckRqRFVZTjQwaUdRRzJadXBBVE1FUFRmQUlEY1l6bmRMN0lNV1JkajVh?=
 =?utf-8?B?ZEhtYXhOSEdYcVBKdk5JQy8rK0dnUWVnUnh5bldwN2U3eWtxdjRCU2hZdnFS?=
 =?utf-8?B?TWViQWVMM3l3Q2pIV0JNZktYUExIMXJZMDYwMkZZbjRNcUxsMURLRUhqOUox?=
 =?utf-8?B?SEtlaHNpdU9YRkVmV3Q2ZXNqbkxuOVk0WUU0MHhKNEs3a3liSC9vY21McWV0?=
 =?utf-8?B?cUJydFhXU1JpY3BBdFVpYi93ZWErRVUwZmx5SVFDdDZvak5mR05oMDhpRzZh?=
 =?utf-8?B?SGZUMWlmUElvV1FvZURZc3VBQXNDRnJwTWt4WXZteFdYMEwzWFIzU0R4ZTJK?=
 =?utf-8?B?dWU3MkdCcW9MM2tQcE0xNUlHOXI4TzNmVVhnY0lzUWROcmY1Rm5FcjJza0Jv?=
 =?utf-8?B?NGdlQi8waUtqeGY2b0RCS0pWcFc4MzN2TUVoOC9FbmZ1THNhM0p5VEEyZTl4?=
 =?utf-8?B?cmFzSXBwOFZYbG1EVVFkM09naElLUFUwY3QwVEx0VVlWckR5LzBZVk9Ud2dV?=
 =?utf-8?B?dkx5L3R4RlNKVVVmVXRURnIzTG8zdVQ5VDZucUh2UTBqNHVGOE1xYnAyb3J2?=
 =?utf-8?B?Sk5NcTM0djJON2JaZVFlRU0xeUVvOGJtRmhrczBsNy9XRTM5dE9EaklZTWN6?=
 =?utf-8?B?R0dkbXdPTUFQZXpRbWNaZSsrb0lxYUhXT0x0THppUDA4a1NkSFFNeVU3eFhS?=
 =?utf-8?B?M3pZcm1WdUZsZE8vdUF6TEEzU3BqQ2duR1pUQWRHVE1idE0yK2UrWGV6MnFW?=
 =?utf-8?B?RGxHRDNINnBLV0xBUGZzV1J6STdxd3FWWUJHMHFxVG1SdUpYcWlQc2RHRnF1?=
 =?utf-8?B?OSttQy9SbHVVWEltSVVwMENITkxMVnlMT1o2NUFRdjM3cm9ENnpmWVdsSVhO?=
 =?utf-8?B?Vy9tc3UvQ3VqTHQwNlBvb2hOcHlHQ2dDZnplZkI5OFZXd05FNEtlbHBqMC9j?=
 =?utf-8?B?WVNKb1ZNcmVGSStqVDF5eDBJSFYwR2JrbU4zZmdvYVJ0UVM4eEZnaWk5WlFq?=
 =?utf-8?B?eDFyWUo5cld1ZmNhZm5mZkx1NmZTVklYT2NvTkNQS2Fyc3VvN1VRbFdNTUlE?=
 =?utf-8?B?OVRrV3ZmbXBsaElnUnh6V08wQnJ0UWNtR0taWlJPd1AzQnRGWENQeVVxblNE?=
 =?utf-8?B?enNUUmFaVlRoayt1UktEZGRvUUdUSEhvcWk3Qi9pUU5GNHRZQjBSU1RLbHRm?=
 =?utf-8?B?QUV5M0g5YnJUYXVnYWczdStBUnBZR2xBdXhIRi9EWGtibThldlQxUWRSeHVp?=
 =?utf-8?B?T3QyZ0FOMjQrMkpQeWpvMWhtdmpEdWZuK2Z4cFV1dEFXYURiSGxOeHVqTkRx?=
 =?utf-8?B?d1F1Szd4Ujk3UDF6RlNXNjdqK0FSOWZjTWpWUHN3OEJ6TEk5eXEvNzlwT0cw?=
 =?utf-8?B?VTVDWVdtd3MzL3cvMWttSGdTUjJVYmlBcTBJRUh5ZlNHd2M5VnFzMkRqd1h2?=
 =?utf-8?B?eEptYVlCSUdWd3k1MW9MWDFCSm5MY285U0lxUGxxa2paQTFCTnZqK2JhTzF4?=
 =?utf-8?B?VmUralZwQTlmcUxPL1lPVmZ3cUxHSWdKT3hKa3NqVWx0Y2M0R3luY1lISkxy?=
 =?utf-8?B?cmk3TUtzaTBQTklhVzg3TWhDME1xR0thYmdVRG9qUGxaQW51UXNHaGhuUnYv?=
 =?utf-8?B?aWRQMlkySnBWZXNtb0FZU0J1QVo1WkJlQjF6c0pjSE4vZXVZOUYrcW1HdFMz?=
 =?utf-8?B?a2R1MXQwU2RQb2NQQTRqSkFmU0FzRFE3dy9vL3doK2dQakdFd3FNQnUraFVZ?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6d5ab0-9844-41c8-dd2c-08dd66d34a56
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:46:22.9062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AuOyBJi5j8k4a6hnnOiyAmimnmb2PAZcr1O1qzoVRWYp8Jimj0JIk/yktP2WsG+N27nvWwAD8fkiVPUCFLCGUIvEHpl2IOvA7EiznurFts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-OriginatorOrg: intel.com


> We are discussing where to move XXX_core drivers which historically were
> located in drivers/net/ethernet/XXX/, see this idea https://lore.kernel.org/all/20250211075553.GF17863@unreal/

yes, I know

> FWCTL is unrelated to this discussion and

it is related,
I see the move as a workaround for "netdev maintainer complains more
than I would like", sorry :P

> you are not forced to use it
> if you don't like it.

I know, time will tell if I would be forced to use it to don't
let competitors to make a short term advantage by going by the
"who cares, we have fwctl" route.


