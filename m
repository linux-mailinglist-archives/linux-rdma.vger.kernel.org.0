Return-Path: <linux-rdma+bounces-8805-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFDEA684AB
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 06:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2953BC481
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 05:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7496D210F4D;
	Wed, 19 Mar 2025 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCG/B1h/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7EA8F6D;
	Wed, 19 Mar 2025 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742363346; cv=fail; b=FEFUwf9n1JRlDFuHueQNaYnFa4wjw/FBNz5f6MjC7PLAwX0Nh6cgyY7gq3iklvJSK4CdtHiL3yTnWe/KPcAlTRvIxmFMYnMrMOsclhoj7fb4B4OURYCRYbPOlPqCFLu0eGOZ7ybRINmDy/AQaq3LAmPBRazFnnC/Xv6PCkUFB64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742363346; c=relaxed/simple;
	bh=kSx+UorXLvkNfKfn5ShdJ/qwKLNSeI/rFCsVdvjVChc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m9QULsrgb97zkk20GLeZXsZq6yuEPNdVN1En3xCPhuYSmwBf0gQVmJEqrXufZb+ZABGAdEOQB+uen2Jw5ihxXq4uvhLInwjEzOtWzzLoYi2l5PwVtlMxaCo7sSYj2jjzTvlcCDZ0SrbIfMWSSMZcNE77ZszccCX+M1CXpjCOaZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCG/B1h/; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742363345; x=1773899345;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kSx+UorXLvkNfKfn5ShdJ/qwKLNSeI/rFCsVdvjVChc=;
  b=GCG/B1h/acNXxxjwwyAdZ2ehI/1OAgjVbw8JYJrTH/fBP3+xPGV8XTNz
   hUaW1rRFPMZdL3Be7FKiI6zI5K+8MUl1qoQ9s9TmXbfZeZPdNaOpgfC8x
   VRmWroxLCdHRLVsVzvJe8+g7xitZ+a0zMa74QbsrsGwqF1sxMsxQqqlWr
   aUt0sE5pcMUxeizVxkXLA7xu4oFuJ/RHogkKO69XGcMUlSp8GvHAusTI+
   j/KyHEo6DDEPTzCQ1oFSesw/4f7VCQWeB7b0TjPMWtsz++k9QhER31zjX
   uVc6iBg/tuZoePa5M/+6NbZb8nQwsrj87T8fGXTPvIXvP8yHpWzsPLyXO
   Q==;
X-CSE-ConnectionGUID: pzFhoKxLR8ik0uxZ1ICl3Q==
X-CSE-MsgGUID: pRcIkxAmQdiEwlPH4NZLMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43425499"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="43425499"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 22:49:04 -0700
X-CSE-ConnectionGUID: m4ElzbfqTlq4+/gcBMMk1g==
X-CSE-MsgGUID: YhgQCKLeQhebaTboy/2c8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="127294791"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 22:49:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 22:49:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 22:49:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 22:49:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ga0mj1opkSCI7+uvLMnCy/s0GbKTPuuPlRfL/OsA38dWAdAt+YZ2rWwunyZsguniNKV8kp2Ba88H9gI2xxD2JJzxpVxVijf9i3qd+w2F3eGeAYFuT7fa68LVd3hCxutv55bJHajLRxExrTs+SyJT1TGU4p3soSgANyAeFHRE8ztbjOZvFFVzntv88PHf/hIM4eyLn7sSBHlXKTazdgTGIQ+biy3LWPUmAGx7EyN3tcrm6/FQo7QOZlWYPVtQZzwqK65sL1FY27vPbiaxa+hcWB37mrsQEE5KsGYzbZsadrynmHYA5q1QDuL7jg3xkUyxvUGVHBZswgROccF8Vg0hOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1v9AA1x/OhveWpRJHERT6pXcg1SKxX5+9x6QULbV1w=;
 b=IzsiOGUrFHQ3JRm6b/SFyihqo8BOJU/IIJDJe/rg6fdvSNdr2b/12sZMJG60SCfkxdHsAyRzxYtNM2DPPjq34IArhpDY5nNeV3mo+HWeEMWmc408T7+zHP72MVjOeAIpthmRq0eCU+JarZcpT52o9lkoKd3PNvRjnxcxGQgnM2r2LBI/vwXWUEUWXsbouq+UMFcsseLAD2jYJ/ff+Qz00EIh1cZafuyP3gq5XdTCGHQ7YWWUZY39cjBEnFqUE0KS0wEqRHQdcD0z4fKMVb+uz7qk+zJGefw7y9IumG9ZSWBveqA/LDuhpvZvlWsb49SO6yPIU+hablJjcTYzEWOgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 05:48:55 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 05:48:55 +0000
Message-ID: <95da9782-7c46-4ddc-8d7e-ffb3db31ebc3@intel.com>
Date: Wed, 19 Mar 2025 06:48:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: Dave Jiang <dave.jiang@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, David Ahern <dsahern@kernel.org>, "Nelson,
 Shannon" <shannon.nelson@amd.com>, Leon Romanovsky <leon@kernel.org>, "Jiri
 Pirko" <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, Daniel Vetter
	<daniel.vetter@ffwll.ch>, Christoph Hellwig <hch@infradead.org>, Itay Avraham
	<itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, "Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
References: <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
 <20250317123333.GB9311@nvidia.com>
 <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
 <CO1PR11MB5089AB36220DFEACBF7A5D1CD6DF2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <2025031840-phrasing-rink-c7bb@gregkh> <20250318132528.GR9311@nvidia.com>
 <9e3019af-7817-49db-a293-3242e2962c22@intel.com>
 <2025031836-monastery-imaginary-7f5e@gregkh>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <2025031836-monastery-imaginary-7f5e@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0037.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d67496-d73d-46e2-2f55-08dd66a9bc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEhsR0luT2lWamlwQzdQWFZJNEJkY0tUSmJzNXdocGtaNTRSYi9XV3p4bGpV?=
 =?utf-8?B?MWhhMmpjRWZ6Z2txaVJxU2hiNENuczJ2c3l4Z0h2Uzg3YkVhemc4M3YxeHN6?=
 =?utf-8?B?ZG5hN09USWNHVWt4bkd5NC80MzQvYUFOVzBHQUovUEREc291dTlieGl6bFFn?=
 =?utf-8?B?YzMrVEhZdElXbDRmNVNLa3RVczF0bW5QZ0xFbUxjc0hWV1Z1dXBEWHFveFpv?=
 =?utf-8?B?WTgremx6ek1ickpWeUFGUHRFR0s1T3kxY1oxQ01scmkrRFU5bGNZVGhvQzNM?=
 =?utf-8?B?NUt4bkExMm9CdnNKMmJKUjN3RytFNi9zNG1WbTZoZzB3Qy9mUjNjUCtxQVl2?=
 =?utf-8?B?YkY2WXZMZFFIaXFrQkw5V1JMREoyMTc0VTlsUGFVMUNHL3V6c0VHbVpPcDBw?=
 =?utf-8?B?MG5URUVQTTJDQjBuVzFwREZlWFp0cW1XbzNPaWZ6djlUd2ZlbW9PUkkwQ1Vu?=
 =?utf-8?B?Q2c3MnJoLzBzSk1MdVJieHNWWmVsRFh0L3M3dXkremo1RXlKdVdTeXhraXEx?=
 =?utf-8?B?U1dCd3dCSWJQNFhMSzZRaDJHaU5lTjloRnNENWZwQ0UvS2tYTEt5K3hMY0w3?=
 =?utf-8?B?N3RFK1h5NDBuRjJTdkNSZVQvYTRucm5SazJGKytqNnZBNmlVb1BuSmRXd09v?=
 =?utf-8?B?aW1vU0hDaWZVa3l4Uk10N0NGUEZDaUFIS1Q4TFhydTR1WDdyYmREeFdsYUxB?=
 =?utf-8?B?QVlhK1lsZTh6NytreXZlbEhWV3VxdFA5TVMvOXRydWxMdFA2SkZqM0FKYnUw?=
 =?utf-8?B?bXdmVkRDMDZkZm00VDVITTJFZytXS3RPQlpmVXd0Zm14L0JCcEpranMzTTl5?=
 =?utf-8?B?cUhtZ3NveTZKbHB3bkduM1VsbklFeWhzeXVMYXgxTGVDbE11RDNPckxtUDZL?=
 =?utf-8?B?cDZUTEplZU5QTTJ6L0RyVHpZb01TNHZjT3BZUkJjWGVoWm1zVDEwWElKOXZm?=
 =?utf-8?B?THB4SjZXTWdzaHh0Z2NJb25iOXN4SjRxTFVsTTBacHRrQ3AyOWZMcUFSMXRy?=
 =?utf-8?B?VUdhWkI2RG1ncU1EbVVRVnlHbjk0c0ROZWU4cjZwSVgxaTZNZVU2Z3owTy94?=
 =?utf-8?B?V3N1aTFsNzRNcFBWUW12UEpwTzhsU3ZsK2lKWU9vTHB6VHFmSlh2ZCtLUWZO?=
 =?utf-8?B?VUdiNlVNTHF3YndlRXlhd2orZ1dwUFB6dlN5MlJIUU1CN2JOSXlyOWtSSHhU?=
 =?utf-8?B?b2M4bWpPVmdFNmt5ZWtFaEJveGdCRFB5RFlITllnNnp5dXk5dU9HLyt5MnEw?=
 =?utf-8?B?a1U0QlVWRXhBZ0JHMHB5ZXI5bGtiVE9oeFlKZEV2Y0FYT3hBWmlMMVFHN0Rp?=
 =?utf-8?B?ek9QQWROemExRHQ2dWRkNVFkdU4vYStRQ2dlSDdVZVNEbm83S2J1N09iTTBv?=
 =?utf-8?B?SjlrNk9YOVd2c25zQXhQU2NtaHpPNU41b1Vmd084U0tXcUY1bk9KUVR1bmI3?=
 =?utf-8?B?WktDV1pwQWJNZ1o3R0RpeU94QnRCcUx1WXBIMXk5TEJQcElDYSt4cU5pcDlp?=
 =?utf-8?B?eFBIOGkzTmdud0t6dWJEREdQYXZLVUxXKzNWdkV2SDNOZFBGUDFrQ3JLOEVO?=
 =?utf-8?B?WDBIam9NenNSZ3pKZXpPam8ranZNSFdJRzV1MU90b25CTDNxNlVTdkg1SVhZ?=
 =?utf-8?B?dXBBU0xFNWtoaUlneDBNblNmdnBQMm1IL0t2ZkFVQnErRkI4dWZiV3gvRVZw?=
 =?utf-8?B?Mk5vZVp3YnhuR0kybk5vRURVc3FwN1dXUjJaendDZ21YNGhKNldWK0RTNW5v?=
 =?utf-8?B?S1pTRTMveW8wbnpTTGZpY0UxbmJDemNsdXBXSWRXeVZ6ajdzQlg2RFFDSXZn?=
 =?utf-8?B?T2xLNTB2MDY1bkE4Wk9hUnhaWnIrN3lDZ2tEMUdxN0FCSjd6OXNTNm8zU1Q0?=
 =?utf-8?Q?iGR74y9BAN3Zr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJMNEJ6dlVVUENkNk04ZWs1WlplMG42L1grZ2Y3S24ydmQrdytWWlVrQVU2?=
 =?utf-8?B?Ny9zNnFnUU4xU0pCS045WnRUZW4wRlgwOUN6bEFzM0ViSlpBUmpvQ3J4Vytu?=
 =?utf-8?B?ZThzeGtHWlRSMGxwcGliUXgzbGNBV21JeGQrckVPRC9BMUx3REN5Rm5NRzEz?=
 =?utf-8?B?NngzVUZLVzRURlEycmVuTUMwalVZQWwxbDVDQWxXcUZtMTRHdlVjMVRsSVM4?=
 =?utf-8?B?YVYydnJ3YzU5dWd0V1FBRU5kbjJyM3VWTG9FY0VlcHlPdm1uY3RZTHNvR1Rl?=
 =?utf-8?B?WEdDV29TMVdBVzJRcE9vWmNtdzR2aHU1MFhVNytDYzQzZDVhbjZKQXFMVkwr?=
 =?utf-8?B?dFVaUHhNcU45bnVZREhCSW5mQ0NucnJlcVBqWFY4VUV5UEZ0Y3p5ZmhrejB5?=
 =?utf-8?B?TlpFNjhuZ0t5V296eitGNC9MWENqcW0vMitWYWg2QzZQRVQ4ejVka1lsbHox?=
 =?utf-8?B?ZkhaU0t2U0tUcXdYaktqaFBGbGRGMUJIblQ1ZnFRMENrWjdWTjlLbUJSMWdz?=
 =?utf-8?B?aWMvZTR1ZVJSalQ0TWY2SWlLOG1UNUFZeGt2dEg4WDljMmMrYy96aFc1VkdH?=
 =?utf-8?B?Yzd1bERjdXhyT09YejVjRUo1ak1TTklPdUxwRStZSnZwdUgvMGtDY3c3cFFz?=
 =?utf-8?B?MG5lK2kwWjB4d2RRNk1vWTZ1Zmk4bG50Ly84MnBocEMyOE55U2NQRVc4MmV0?=
 =?utf-8?B?dzJScnlIT3h4S3pYZHk4YmlXT25FQTM3YTIyMi94R3hvSkhpN2FYTGlkZ2V0?=
 =?utf-8?B?WXp6RmtRMGE5RTFBc3RIUi9Ub2lxTjdSSnhsTm9CcStqcDRBNElHQU4rbWNC?=
 =?utf-8?B?ZVNLTEVySDVaTDh0U0Q0bFlVMms5NVgxeVhETjcxeW5HMlBEYzllTWVlWWE3?=
 =?utf-8?B?SjRlWjIrd2hGbCttTUtQYkx0MGlRSVV3eUFQN3pNeGpxNnBoRGQ2WjRJaXBO?=
 =?utf-8?B?b2h2eEpWU2xMbkJPeldXM0tRY0JIVm9yM1ZFNXZ5ZFY1NW5sbk5GU0JOSjZt?=
 =?utf-8?B?SlJiOVJCUFhYVis3UWdSVUsvSmdLbHdEaTdDZldocDNOQ1ZPUkUwai8vbDho?=
 =?utf-8?B?emFsTW5GT3d2eWJKZ242dGZ1ZzVhR1pjZU9JMXFXTU4xVkNCOXpxaldXV1N1?=
 =?utf-8?B?eFZ0VGh1U1E3V2QxOUs0Wkt1cktlZEd6R1FhejZRM3o2TGE2QWtSb1RTc0dY?=
 =?utf-8?B?aEYrWUZMdVVGeFJycG9FUEsvazlkaXh6ZHZiK3dzMlg2TjdzQXJVSjF3Wkow?=
 =?utf-8?B?TFh3QjdSZnF3NTMwZWxqaVRVYTRVc1FIbEFRUGtzNXRKemlNS2VZVi9mc1kz?=
 =?utf-8?B?bnpKeERSd0prZGJXdW9GRVVhYTJNVEpHNVpxdytpQU55eTdMRHo0Y3Y1NFdh?=
 =?utf-8?B?NDQ2WE95UC9rYmFFbEFEcmhpRTZPK1F3NmdMd1JzRU1qQnVKdndmSlFwSTVu?=
 =?utf-8?B?c1lXSC84dXk5YUc5a1BtaGhzUCtkUXpSUUV6YkVqTU9OOHRsTHNEZ08wQ0VG?=
 =?utf-8?B?Y3RlUGErVXY1YXVuUjNWNXJWOUlreSt0cnNYeVBhSlgya0drdlNqb0RKZUtE?=
 =?utf-8?B?N1F3dUF5RXZmN01PeHRMbFFsNzMyd09iUzhCamQ4cDU2RytiWkxCeXVyUi9B?=
 =?utf-8?B?RGFydEZCbCt6Yjc4b1YxMnU4MXpJbjI4aUdSc1Vrc0RadDdjWnVCcmdTaURD?=
 =?utf-8?B?VmRkWm5lWFo1a0VtZG1mZ1BZdWtHRlhJbnlkSmducnhoZE9IMWJnMmZ5UTNv?=
 =?utf-8?B?c25EM002OFF1ZzRDdGd6ZHZLTW54cC9Ja2ZEK2JsVGVuLzVtd3RmRVJDUDZ6?=
 =?utf-8?B?M01aa1orMnVQWUJIUS9mZTQ4NXhtOEdkaGNMOUYzdDRTdDRKWmtGOWsxYzJJ?=
 =?utf-8?B?R1NueUxuRU93d1NsM1Q2SHFmbEo2UGw1SFErM242MXNXYWs1RjBDZ0kvNmtZ?=
 =?utf-8?B?d1dhNUxkZmVEWUVSNjFwenVONCt0V2czK3VPSUhXcFd0eStmZWM4VGROajdt?=
 =?utf-8?B?QURKdmZIS0Z4LzQzcXRmQWlLK1Z3WFphTjREeTBOWnc0Q0tUb1lRWVc5dFgw?=
 =?utf-8?B?eVRPeXlUN1dSdFNCdjZ1WXpIakVtMFcyUUNNcXZMRTNTLzBpTEVHWE52RFEr?=
 =?utf-8?B?dCsyMDYxZExZd2Q0cVdnbCtpZ3pVNldyVHdMZzhZTHpIZFpJdzZGb1lJTm96?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d67496-d73d-46e2-2f55-08dd66a9bc8a
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 05:48:55.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DLYHJgDDZyDLAWW0aorUVofktXSRVoPS5bvn0MiiPGCD7xXpYgn94abQkoGC+Gsujw6w5YjpLwjXXWAw+6Mx5q77rVypLukrddsJEO2vnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4886
X-OriginatorOrg: intel.com

On 3/18/25 17:06, Greg Kroah-Hartman wrote:
> On Tue, Mar 18, 2025 at 08:39:50AM -0700, Dave Jiang wrote:
>>
>>
>> On 3/18/25 6:25 AM, Jason Gunthorpe wrote:
>>> On Tue, Mar 18, 2025 at 02:20:45PM +0100, Greg Kroah-Hartman wrote:
>>>
>>>> Yes, note, the issue came up in the 2.5.x kernel days, _WAY_ before we
>>>> had git, so this wasn't a git issue.  I'm all for "drivers/core/" but
>>>> note, that really looks like "the driver core" area of the kernel, so
>>>> maybe pick a different name?
>>>
>>> Yeah, +1. We have lots of places calling what is in drivers/base 'core'.
>>
>> just throwing in my 2c
>>
>> drivers/main
> 
> Implies the "driver core"
> 
>> drivers/common
> 
> lib/ maybe?
> 
>> drivers/primary
> 
> It's not going to be the primary drivers for my laptop :)
> 
> Naming is hard.  Let's see some code first...
> 
> greg k-h
> 

"platfrom" would also suggest a wider thing, so:
"complex"?

anyway, I don't like fwctl, so maybe "fwctl" to at least reveal the real
reason :P

