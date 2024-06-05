Return-Path: <linux-rdma+bounces-2906-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F6D8FD1EA
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFCF1C229E6
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C9613791C;
	Wed,  5 Jun 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mF78JPmP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A11D524;
	Wed,  5 Jun 2024 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602185; cv=fail; b=Odmjb4Y84sPiyBi3jzXl/RBx3Wff5/a2X0Xy1D0C0XsjZOIprCo5ARpQqdIjbfyqGTO/hr8V5u7MbwXvUeEp6jlbkwtQU5RHfocC+ZzdTEQhyQ9wQckeqKdqJdeR+JjdUrelQrfwprRK/JBptCFnw7kXumhhIzDGkny9nYsHMrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602185; c=relaxed/simple;
	bh=hfn6lmQLwFWYDPgQtp9Tv2pDEQaHBb0uqEmFX3uNddk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cWnrMcsmz/I7rgFr8Ng+TFRiFIgpi4wNaQBtnw2sD0EzNzHKwAiCsUjTBkNKQwqynvfG3zyHk7hYxkauzzNc25OLGLJqNrhMHEp+HF75vvxSbxfjI1/8hV+wXeIBwEjKIJ9fnkmmwNQyoATMciRoMAmhhkeC1cur8SUm+rNJ32w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mF78JPmP; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717602184; x=1749138184;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hfn6lmQLwFWYDPgQtp9Tv2pDEQaHBb0uqEmFX3uNddk=;
  b=mF78JPmPqysqrwca8wTk3Tt8pPDly1+g/3lyJq3BenjzNZjQS6aSUEpH
   4Ym11cZvkXSIj+EodlJam88rJJJQfoQd5/aSkxn8/RxdpcVWJiw1PfRIR
   5T2MpGBlz1Rnv9g5ihjO/2edfSZrLnseI3F2eMwHKxDHWu17FUlLhLIM8
   uwbxAAf9GmrAp7111AMirymVjQy9HGNlOYhT3id6T4zpDUHqmKU1RXgE3
   EPt857J7fHYdUhugtLVFVNFeXNiknwGQ/rdGbKgRnlwkYlij8wK7h2YuG
   P9GVriXtyjj8KZ6XeMXgB4FeXi5W5O1svxc7JmNOc11rpgx1fYKc0J8Ig
   w==;
X-CSE-ConnectionGUID: AVHFTbuMTyOmClUBlo9r7A==
X-CSE-MsgGUID: JNGt7kovQMKHI3DDf49dBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14106981"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14106981"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:43:03 -0700
X-CSE-ConnectionGUID: bWA0BFXORZmBvK2O8aMMjw==
X-CSE-MsgGUID: e+4Kv4N+SB+oQFEAe78cWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37766569"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 08:43:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 08:43:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 08:43:02 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 08:43:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4u4U4LoM+uOEpQ92tpWCCNxTr1iuP38WProvVtwpw8pPgHFdKjpiDAjGwSGkfsJnFZPus9Ook+cSfTeC0AFE8gA13COuEIDd0Mvqf9jXcx+VZ4cwzSeeCJvYzs8OrR0GcotnVmmfc59kUhCvExJUmSuWMrMaSrRxoDT0JUj5PROB2OdDGWGDdfBTtCY9oaEyAkNk2go1dxaQzIxzJE9ak6eR6iD9M/iP5uKXm5cGeSuxXemg1WcUOm8Fit/tZQmmHxVF+ZBEb28aQlE1ttJ/tD2VEpcAsvWDE/ly1QT3g6RPI5kYBdvrS4tGHKP0Fi4gXw5aJmwWXECQtUj/ZDz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G36aH3E2N09ARMGawB0UOwaW2J1GRCnoVqhL5fG7nbw=;
 b=D1tRp9OKloPBcmUDCcq9FIA8WJw+NSxz74wLCUxCdBZgxCVJp+4PF5T173XjnBoMzgmCW8ys1SgwiygtZ5wJO3weJzr+py8nXpR9VL0C8Yduw7rXuNF+nw4GUfROtpZzeSHeVH5/tBFlzj7C5OOSJmlltj7nndj0N2c12cVy0Rkd1XtwX7ugqeFWeO3cMmKa0JVenU1oPmANL1iujnUVuNsD7qAMYnaiSSoT2eUPw7ts69C4u2WswJpkMWrA98e34k6h3fLzHaqF4iUc8LUXI913MWPyZMKRxKWFG7pg3kn0hyP6Fn+8K16CmMeRER8GrbpAWO0DyTFhOICd7QH2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 15:42:58 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 15:42:58 +0000
Message-ID: <1cd4f08f-b0e2-46f0-a916-9f32b4bfc90a@intel.com>
Date: Wed, 5 Jun 2024 17:42:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] fwctl: Basic ioctl dispatch for the character device
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, "Itay
 Avraham" <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "Leon
 Romanovsky" <leon@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, "David
 Ahern" <dsahern@kernel.org>, Christoph Hellwig <hch@infradead.org>, Jiri
 Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
References: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA3PR11MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 5978fd1b-4298-4cce-39ac-08dc85762c89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2c4VXNuUDVXMXlldE41TjB0aTFLT3lDVm0yMHFkaFh1L1YxZEZhT2k1RUk3?=
 =?utf-8?B?Q0x4ekZ4WnFXQlJvM1BFRHQ2OGFYaUlFdlBvTTRwU25taVhuK0RXQjJpTjVt?=
 =?utf-8?B?cmg3QXdtenRGYnJKMTNRUjZPVjFRL21oV2phVWtNdGs2bTZFOS9wdEszT0RL?=
 =?utf-8?B?UjhFci9kVHdiZFZsS1l1QnB2TitYa2xSOEh5S3ZiNEJuTUw0NXM2SDZxaTRX?=
 =?utf-8?B?SERVVHBKZGJrU1VWYUtXL2cwTGV0Z054RThUUDNQUVd6dGhldEFZVExBV1lG?=
 =?utf-8?B?NjhtYlFSTlhIeW1mekp1SGlXSTB5M1dwSUZtTmZGVGFsNTVOVjNRZmxyTmdt?=
 =?utf-8?B?TEw2U3V5cEZiVS83d05rUmxxTHRheWRpSUh6NXNxbDBzZ1IxME9VaU5rT2ZE?=
 =?utf-8?B?VHMzSDNtbWdKK3JXRVV1enNYK2dlSGw5WE5hNDN5SGduNUNNT05sbUV3bmI5?=
 =?utf-8?B?Zmk5aEZhUitVT24rdHlJTDZHNjk2Z09tRlJwSndtR042ZHhwRkxDY3dHK2dm?=
 =?utf-8?B?d09TSVZyck1kM1Y1ZVd4N3dJQ3BIN25YaWwrVStCNlNXSWI5cEtxOC9DSjAy?=
 =?utf-8?B?Wll1NkNURlNsZHk0ZWcxUHJlZXVXZ04vZzhNdnp6bDR1eXdoczlPZlUrUTYx?=
 =?utf-8?B?VmpPUFg3VWNES3B3bEp5N25OMmpremozWWpLWmMxZ0NicFY4THcvSVgybzZi?=
 =?utf-8?B?MHBmRU5qa3FwVVFBdjN1d1lkTDFSemxNclNCSjhydmtHWGlzdWZuNFR1M3JI?=
 =?utf-8?B?cVc4U0RLTU0xa09md1JDa1RuTUtabm1tYkFQUnIyRVFWMFVsOUswV1Y2YjFh?=
 =?utf-8?B?T3dNeTh6SGoycmp5NTRNUktJajF0MW1IR3FEMHJTVm01NFBuaCtHeWROSUpK?=
 =?utf-8?B?eWR1dElZRWF4aTNJcnBDMjlmeXQ3NUxiK0w0NWQ0Q3hINmNhRTJVOVNISTlr?=
 =?utf-8?B?b2wrdmpGNFloRWVqeWRDMzlubVpaSCtwdnhMM0VsaWJaSUFUN3VVeHZmczZ6?=
 =?utf-8?B?dHozaXduNXZldC9VNEVzc2x6MnlIY01QQVFyc1M4c09FU09CVk03K2M2YWFt?=
 =?utf-8?B?b3NZM0l0RnRmQXRIdVNGWmFiZVhEd2hPUjJsS1dvRkVJUytUeGNPN1hPYkZS?=
 =?utf-8?B?UDMvZFY3dmJVRkR4SlJzbnd6NzBheWFOODBST3QzZjFwNTdQUTUvcVkwa2lI?=
 =?utf-8?B?eGJrZUtualh2Q0FTbWpqWlc4cTJ3RmZVckE2UTdTZlJFdmhkbWxSYlFpWDVx?=
 =?utf-8?B?VUVkb2lDbk0vU1hBbUtiQWVVaDUzcXhNODlpQ21ybUx4KzhHN0ExREI3Z0U3?=
 =?utf-8?B?RWVrSU10Ni8zOC9WZ24wZzlGVGZpYnc2SE5DWDdudWNTa0d0c3BpaG05UFd3?=
 =?utf-8?B?SzNlUnNxR3ptN1A1ei9MNG1oYmhCOFZseEVxUm5rR0V0WEJhMHp1NUVuWW5N?=
 =?utf-8?B?MWFVWUJmWEhJM3FscitTeEp2SUxhcEJxVVZTTUZuNDA3RE9xL0plL2dlakNj?=
 =?utf-8?B?T3NVYUx6SWQxcHN6VjhSWUJydGU2V29XdUZvZENsMThKL3JmQnJBR3JLK0c1?=
 =?utf-8?B?NVpNWXdKRGlwUmcxYytxQlA2VjNpMHFFWFN4bE55dm1mUGp0b1dVRy9sc2t6?=
 =?utf-8?B?OVlIb0JicDFQTndMVnY5b2lRcFVhUlN4YzRKQWJiL1dYNG5Hc0hKYU9DRk1r?=
 =?utf-8?B?ek1jOWlRemdWd21UMzJjMlVNVDZtTXJjcGR1ajFJdm4xbXdRdERZOUoxS1I2?=
 =?utf-8?B?VnA3cTB3RHI0cGlKSGtnS2tZSktOMHp2UEFFcktKcDVVbnVJVFhhN2pLdTlO?=
 =?utf-8?Q?ysA4mmHaeSyzUt9W2ioEOfB3T0rD3bB1RwRv8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGtxcHFpWENDWnltM2h1djlrZzJNRTF3NHRvd2pmK29TTi9rekt2aDhGMmU3?=
 =?utf-8?B?eWo2UVNwTy9WWko0WHR2WERmYVNHanFRYVZSUzZrYUtZU1IycG9uN0pTZVBn?=
 =?utf-8?B?dWVzK2g2ZkxYZmg1Umh0c1g2MmZDZlBxTEJ2YzBxOCsvcTQwSzhLWmFXK2Zq?=
 =?utf-8?B?VDlsN1lod3NPYlhxK3Vid0NwNWpqU1orMFpLZ0ZRVlBtMjdHNkpXRDZweXZp?=
 =?utf-8?B?M2xmSDhDTjdtMS8za2YvZnNjeno4RUFXd3pIZUJiVlNjcEc1Z3RvUkx5OERP?=
 =?utf-8?B?NVFiRWM2SVZNVjF0eUdaSkNxajJhRFd0aDNQRDNQMGgvU0VCdnZjdk5hUXIw?=
 =?utf-8?B?STJrYVJBRHlibXZmNWZ5cktHQzQ3RXRTdFFzS2s0Z0dFb1d6VzJVbWI3Vzdy?=
 =?utf-8?B?MGlodm5VNXRMaTVnbXZZMXg2WFBWck43SFh1dCttUUd2Rms3dkZWSCt5K2tl?=
 =?utf-8?B?SGx5YjVqdFdTS2xDc01tWGxQczhHQUVjbk1ZTTZPY01HNWpRRVFnS1oveDdB?=
 =?utf-8?B?YkZxYnFpWDl6Lys1MGJuQVUzVEJjdmJiRFB1ZUhXd21KOWNGOXE4ZisvRVY4?=
 =?utf-8?B?VTlrdlhSSjI4MVJCUFdpKzUrbW5aSTIzQTAzOEU2QWNqWkdGNWNSK2Rlc1h6?=
 =?utf-8?B?VjhUQmZGREkzRERxZ3VsbG1qTCtDbVVnRXF5SVVRREpXYzd1d2pBbjVMZHdX?=
 =?utf-8?B?cDhtalQvNTJQakRyQjVFb0dYYlZEd0ZtdmJFUXVSaGdraHFWOGdFejdFSGQ4?=
 =?utf-8?B?YVMxRUxYeGRrcytWZDgveWtHMmc3ZTdRN25kTmFwS3dKcFNreGVlRUZTMGJ4?=
 =?utf-8?B?Wldlb0tleXNnbDJTcStVblY4YkdBY2c0aG83OGJDcHN6dy9OZElGalN6QnVZ?=
 =?utf-8?B?aEx6UE4wbnJ4NHVBeG5nSHE4ZVg0UE9FdFdRQzlVSGZVTVcyTXVHV2MyYW9t?=
 =?utf-8?B?aGdXNVFvd2RoUkdoMFcwbURxWXgvbTJhTytVRXVrdzZsNTdQQ1BmVVk4Sko0?=
 =?utf-8?B?OWFlK2RtVVA3RWxkdTg0d1RrVGZGaE1QaWpWRHJKcEh2aWEvYUM1Zms1dUdT?=
 =?utf-8?B?NTVvaEp1Qnl4UnQxYTI0VW04MEJOVzBhcFRCQmxOZjE1eGdpV3FLeGNTcldw?=
 =?utf-8?B?RWZoQmQvN3BENTVtTmVkZDRuc1dNRU5TckFoOWFUeHVvcmZabGE5NEJQU0tX?=
 =?utf-8?B?Z29FTURMd3BqN2h4U0pYSVRtWW5oQkVXR0xwK28xb1hqenVGNDkyWWdEMWRL?=
 =?utf-8?B?Wk9vbzNsYjFBNHhpdTVlYnk2SVFIc0t4WC9BZFFIK0ZXbjFnSFBrdDArcTdV?=
 =?utf-8?B?cXFzOCtUcHQzSDhvS2dFOEVZSXRBZnZ2VDcyNnpWWmI4cVR6c3FJVnlYVVhJ?=
 =?utf-8?B?dUZzYjRRNGZOVW83cjhxNHkrajdtcE5LWk96VUZvd2JPTlp0YU5uOFc2RlRM?=
 =?utf-8?B?M2x5SzdWaTh2bzNwSlNPZExHOWhvb0hzVWNiYWFiTXN3U0ZxUEs0dVdwbUEr?=
 =?utf-8?B?amdVRnEvRG5mOXdmV2k2dGV6QVFwbi8ySGJEdVdsQWVoYkJpaEowTFl5aXVs?=
 =?utf-8?B?bWtjRkQ5MERONDY1SEJPeVNUaUUwL01MMDVJVkcyeDVWU1ZBaE9zQ0pMaHZm?=
 =?utf-8?B?YVZnbzY4NG9CQThrR0Y3TkIzdmtUT0VhZFRUZVBOUWpYeFR2cUg2amxWRmdQ?=
 =?utf-8?B?VUJIcTU0UzFOUXpPdkZQWStnRnFmZ2JBZEZtZ1R6a0IvMUN2UU9tcE0zeDAv?=
 =?utf-8?B?QkxIaDZ1TmI2OEs5RldvemdHNHhXNVpLWEdVaGl0UWRoaEI3UlNmUXB5SEhD?=
 =?utf-8?B?SGIySWRsTWZ4amIyVS9VTzE5NEpCZEppUWRlMUxDNnBZcWRwYm9CM1cvZy93?=
 =?utf-8?B?TEIzV3dneXVqWDNjbkpscThLLzhWalhpT0EzZEpXRDYyUnhYOWxCajU1L0xS?=
 =?utf-8?B?ZFVENThzeTVGdlhSdkQ1RkZwcUN6NFptcEU2cmRaMldqenZuS1Q2NTVLTVhp?=
 =?utf-8?B?Uy9LU2QvWTNaZkNmY2owT1N1MWYrM1Y5alBQeVdkVkNFQ0xLMW1tRHdOK2V3?=
 =?utf-8?B?REhsMFZEYkpNdFlBZzZUMGpFS21kUzdxZUQ2NytwaVIyWWdOcC9Cd1JlaFFF?=
 =?utf-8?B?dm1mWmVsMVA2a05YdXhYUEhXUXhrbjg2a2gya3RMWnhHRTRJNlVHMEd3aUNH?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5978fd1b-4298-4cce-39ac-08dc85762c89
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:42:58.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhMMMCpAidX41falePBzCOFSpHhH6tNDa23OAgdTOc+O+eS41ImjleP7BHSXtEOTL4NT2FMSuTBlmSArdysCRacpljutQj5K71CwR1az2r0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7461
X-OriginatorOrg: intel.com

On 6/3/24 17:53, Jason Gunthorpe wrote:
> Each file descriptor gets a chunk of per-FD driver specific context that
> allows the driver to attach a device specific struct to. The core code
> takes care of the memory lifetime for this structure.
> 
> The ioctl dispatch and design is based on what was built for iommufd. The
> ioctls have a struct which has a combined in/out behavior with a typical
> 'zero pad' scheme for future extension and backwards compatibility.

I would go one step further and introduce a new syscall, that would
smooth out typical problems of ioctl, and base it on some TLV scheme
(similar to netlink, in some kind a way smaller brother of protobuf).
Perhaps with the name more broad than fw-knob-tuning.

Then I would go two steps back and a driver layer to interpert those
syscalls to have at least some sort of openness.

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
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>   MAINTAINERS                                   |   1 +
>   drivers/fwctl/main.c                          | 124 +++++++++++++++++-
>   include/linux/fwctl.h                         |  31 +++++
>   include/uapi/fwctl/fwctl.h                    |  41 ++++++
>   5 files changed, 196 insertions(+), 2 deletions(-)
>   create mode 100644 include/uapi/fwctl/fwctl.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index a141e8e65c5d3a..4d91c5a20b98c8 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -324,6 +324,7 @@ Code  Seq#    Include File                                           Comments
>   0x97  00-7F  fs/ceph/ioctl.h                                         Ceph file system
>   0x99  00-0F                                                          537-Addinboard driver
>                                                                        <mailto:buk@buks.ipn.de>
> +0x9A  00-0F  include/uapi/fwctl/fwctl.h
>   0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
>                                                                        <mailto:kenji@bitgate.com>
>   0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 833b853808421e..94062161e9c4d7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9084,6 +9084,7 @@ S:	Maintained
>   F:	Documentation/userspace-api/fwctl.rst
>   F:	drivers/fwctl/
>   F:	include/linux/fwctl.h
> +F:	include/uapi/fwctl/
>   
>   GALAXYCORE GC0308 CAMERA SENSOR DRIVER
>   M:	Sebastian Reichel <sre@kernel.org>
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index ff9b7bad5a2b0d..7ecdabdd9dcb1e 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c
> @@ -9,26 +9,131 @@
>   #include <linux/container_of.h>
>   #include <linux/fs.h>
>   
> +#include <uapi/fwctl/fwctl.h>
> +
>   enum {
>   	FWCTL_MAX_DEVICES = 256,
>   };
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
> +};
> +
> +struct fwctl_ioctl_op {
> +	unsigned int size;
> +	unsigned int min_size;
> +	unsigned int ioctl_num;
> +	int (*execute)(struct fwctl_ucmd *ucmd);
> +};
> +
> +#define IOCTL_OP(_ioctl, _fn, _struct, _last)                         \
> +	[_IOC_NR(_ioctl) - FWCTL_CMD_BASE] = {                        \
> +		.size = sizeof(_struct) +                             \
> +			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) < \
> +					  sizeof(_struct)),           \
> +		.min_size = offsetofend(_struct, _last),              \
> +		.ioctl_num = _ioctl,                                  \
> +		.execute = _fn,                                       \
> +	}
> +static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
> +};
> +
> +static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
> +			       unsigned long arg)
> +{
> +	struct fwctl_uctx *uctx = filp->private_data;
> +	const struct fwctl_ioctl_op *op;
> +	struct fwctl_ucmd ucmd = {};
> +	union ucmd_buffer buf;
> +	unsigned int nr;
> +	int ret;
> +
> +	nr = _IOC_NR(cmd);
> +	if ((nr - FWCTL_CMD_BASE) >= ARRAY_SIZE(fwctl_ioctl_ops))
> +		return -ENOIOCTLCMD;
> +	op = &fwctl_ioctl_ops[nr - FWCTL_CMD_BASE];
> +	if (op->ioctl_num != cmd)
> +		return -ENOIOCTLCMD;
> +
> +	ucmd.uctx = uctx;
> +	ucmd.cmd = &buf;
> +	ucmd.ubuffer = (void __user *)arg;
> +	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
> +	if (ret)
> +		return ret;
> +
> +	if (ucmd.user_size < op->min_size)
> +		return -EINVAL;
> +
> +	ret = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
> +				    ucmd.user_size);
> +	if (ret)
> +		return ret;
> +
> +	guard(rwsem_read)(&uctx->fwctl->registration_lock);
> +	if (!uctx->fwctl->ops)
> +		return -ENODEV;
> +	return op->execute(&ucmd);
> +}
> +
>   static int fwctl_fops_open(struct inode *inode, struct file *filp)
>   {
>   	struct fwctl_device *fwctl =
>   		container_of(inode->i_cdev, struct fwctl_device, cdev);
> +	struct fwctl_uctx *uctx __free(kfree) = NULL;
> +	int ret;
> +
> +	guard(rwsem_read)(&fwctl->registration_lock);
> +	if (!fwctl->ops)
> +		return -ENODEV;
> +
> +	uctx = kzalloc(fwctl->ops->uctx_size, GFP_KERNEL |  GFP_KERNEL_ACCOUNT);
> +	if (!uctx)
> +		return -ENOMEM;
> +
> +	uctx->fwctl = fwctl;
> +	ret = fwctl->ops->open_uctx(uctx);
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &fwctl->uctx_list_lock) {
> +		list_add_tail(&uctx->uctx_list_entry, &fwctl->uctx_list);
> +	}
>   
>   	get_device(&fwctl->dev);
> -	filp->private_data = fwctl;
> +	filp->private_data = no_free_ptr(uctx);
>   	return 0;
>   }
>   
> +static void fwctl_destroy_uctx(struct fwctl_uctx *uctx)
> +{
> +	lockdep_assert_held(&uctx->fwctl->uctx_list_lock);
> +	list_del(&uctx->uctx_list_entry);
> +	uctx->fwctl->ops->close_uctx(uctx);
> +}
> +
>   static int fwctl_fops_release(struct inode *inode, struct file *filp)
>   {
> -	struct fwctl_device *fwctl = filp->private_data;
> +	struct fwctl_uctx *uctx = filp->private_data;
> +	struct fwctl_device *fwctl = uctx->fwctl;
>   
> +	scoped_guard(rwsem_read, &fwctl->registration_lock) {
> +		if (fwctl->ops) {
> +			guard(mutex)(&fwctl->uctx_list_lock);
> +			fwctl_destroy_uctx(uctx);
> +		}
> +	}
> +
> +	kfree(uctx);
>   	fwctl_put(fwctl);
>   	return 0;
>   }
> @@ -37,6 +142,7 @@ static const struct file_operations fwctl_fops = {
>   	.owner = THIS_MODULE,
>   	.open = fwctl_fops_open,
>   	.release = fwctl_fops_release,
> +	.unlocked_ioctl = fwctl_fops_ioctl,
>   };
>   
>   static void fwctl_device_release(struct device *device)
> @@ -46,6 +152,7 @@ static void fwctl_device_release(struct device *device)
>   
>   	if (fwctl->dev.devt)
>   		ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
> +	mutex_destroy(&fwctl->uctx_list_lock);
>   	kfree(fwctl);
>   }
>   
> @@ -69,6 +176,9 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
>   		return NULL;
>   	fwctl->dev.class = &fwctl_class;
>   	fwctl->dev.parent = parent;
> +	init_rwsem(&fwctl->registration_lock);
> +	mutex_init(&fwctl->uctx_list_lock);
> +	INIT_LIST_HEAD(&fwctl->uctx_list);
>   	device_initialize(&fwctl->dev);
>   	return_ptr(fwctl);
>   }
> @@ -134,8 +244,18 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, FWCTL);
>    */
>   void fwctl_unregister(struct fwctl_device *fwctl)
>   {
> +	struct fwctl_uctx *uctx;
> +
>   	cdev_device_del(&fwctl->cdev, &fwctl->dev);
>   
> +	/* Disable and free the driver's resources for any still open FDs. */
> +	guard(rwsem_write)(&fwctl->registration_lock);
> +	guard(mutex)(&fwctl->uctx_list_lock);
> +	while ((uctx = list_first_entry_or_null(&fwctl->uctx_list,
> +						struct fwctl_uctx,
> +						uctx_list_entry)))
> +		fwctl_destroy_uctx(uctx);
> +
>   	/*
>   	 * The driver module may unload after this returns, the op pointer will
>   	 * not be valid.
> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> index ef4eaa87c945e4..1d9651de92fc19 100644
> --- a/include/linux/fwctl.h
> +++ b/include/linux/fwctl.h
> @@ -11,7 +11,20 @@
>   struct fwctl_device;
>   struct fwctl_uctx;
>   
> +/**
> + * struct fwctl_ops - Driver provided operations
> + * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
> + *	bytes of this memory will be a fwctl_uctx. The driver can use the
> + *	remaining bytes as its private memory.
> + * @open_uctx: Called when a file descriptor is opened before the uctx is ever
> + *	used.
> + * @close_uctx: Called when the uctx is destroyed, usually when the FD is
> + *	closed.
> + */
>   struct fwctl_ops {
> +	size_t uctx_size;
> +	int (*open_uctx)(struct fwctl_uctx *uctx);
> +	void (*close_uctx)(struct fwctl_uctx *uctx);
>   };
>   
>   /**
> @@ -26,6 +39,10 @@ struct fwctl_device {
>   	struct device dev;
>   	/* private: */
>   	struct cdev cdev;
> +
> +	struct rw_semaphore registration_lock;
> +	struct mutex uctx_list_lock;
> +	struct list_head uctx_list;
>   	const struct fwctl_ops *ops;
>   };
>   
> @@ -65,4 +82,18 @@ DEFINE_FREE(fwctl, struct fwctl_device *, if (_T) fwctl_put(_T));
>   int fwctl_register(struct fwctl_device *fwctl);
>   void fwctl_unregister(struct fwctl_device *fwctl);
>   
> +/**
> + * struct fwctl_uctx - Per user FD context
> + * @fwctl: fwctl instance that owns the context
> + *
> + * Every FD opened by userspace will get a unique context allocation. Any driver
> + * private data will follow immediately after.
> + */
> +struct fwctl_uctx {
> +	struct fwctl_device *fwctl;
> +	/* private: */
> +	/* Head at fwctl_device::uctx_list */
> +	struct list_head uctx_list_entry;
> +};
> +
>   #endif
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> new file mode 100644
> index 00000000000000..0bdce95b6d69d9
> --- /dev/null
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES.
> + */
> +#ifndef _UAPI_FWCTL_H
> +#define _UAPI_FWCTL_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define FWCTL_TYPE 0x9A
> +
> +/**
> + * DOC: General ioctl format
> + *
> + * The ioctl interface follows a general format to allow for extensibility. Each
> + * ioctl is passed in a structure pointer as the argument providing the size of
> + * the structure in the first u32. The kernel checks that any structure space
> + * beyond what it understands is 0. This allows userspace to use the backward
> + * compatible portion while consistently using the newer, larger, structures.
> + *
> + * ioctls use a standard meaning for common errnos:
> + *
> + *  - ENOTTY: The IOCTL number itself is not supported at all
> + *  - E2BIG: The IOCTL number is supported, but the provided structure has
> + *    non-zero in a part the kernel does not understand.
> + *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
> + *    understood, however a known field has a value the kernel does not
> + *    understand or support.
> + *  - EINVAL: Everything about the IOCTL was understood, but a field is not
> + *    correct.
> + *  - ENOMEM: Out of memory.
> + *  - ENODEV: The underlying device has been hot-unplugged and the FD is
> + *            orphaned.
> + *
> + * As well as additional errnos, within specific ioctls.
> + */
> +enum {
> +	FWCTL_CMD_BASE = 0,
> +};
> +
> +#endif


