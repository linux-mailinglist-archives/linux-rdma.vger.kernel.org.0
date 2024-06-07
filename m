Return-Path: <linux-rdma+bounces-2990-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54281900125
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 12:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6E51F23D34
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B78186293;
	Fri,  7 Jun 2024 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVvyC+ur"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC961FCE;
	Fri,  7 Jun 2024 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757276; cv=fail; b=MBqqLVB28ryXVbopKhxZVOxYvvu3aGgZ4GSF5OcQ7mtnuSC7ce74lr58jECZ8crbbUumkIMNvdXANzc+y0QZ+KkXFLeNjGcopaNyhxbDwDqBIqjmhh7BIVYkzTCZMvJ5Ew3zDK5qWqY6ujSH2K4sZ9jLchpnqnMWHfTAY+rybGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757276; c=relaxed/simple;
	bh=lrdpDHs2pvFdQu/kD/hYOW7XQr9ITMSH9rhj4sXMoJA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SxRI0vQxY/X53SQT9QpOFBPboxe0PKSToI4kw+9pHFNDN7aRvsNIZ2mvP8jayAN684H1i0eRdrhGhPEF4GGPHhDPjO3csk8SvEZuA4eAuuJv7pRKcVbGiQmEgpvm/1TZRVG6zP7G1uH/TM+hgqHoymDjsVIrDQhXD/lmqG+bUK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVvyC+ur; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717757275; x=1749293275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lrdpDHs2pvFdQu/kD/hYOW7XQr9ITMSH9rhj4sXMoJA=;
  b=UVvyC+urwZbSBuhBRAVYXbdTiMRSu4dG+vYi0QcsJLioYztlqkTNDJ0C
   myC/E935dxqXhhYuMRG0sosTd2y0nv9GNYKYsuRtygzXgzxXRfSUFwSwI
   tsldwSkztEvIcGoI9wQ7+ym0k/pzhLisyaP0jCieCd6mBDNtoEgwRpFwb
   21libKfYRKun3q8Zf9PvK1XJvHLrIN8uhYRemAPAp8+sIiiFQ0oBlDk0E
   TOIAZaqCL4WJ//Z9+XJnmyxFjg+uDPAmL56xNavOvyZVAxGRGGyE6oKfT
   b/MpoUMRvh9o7T94+mT+O4CRWnxUJelByqW9sX5Qw4M/H6Ko4W7K3lW3A
   w==;
X-CSE-ConnectionGUID: FhJYoto4QWa7JE0VdFnF6w==
X-CSE-MsgGUID: TM8tyqghRki7GP4MiaSQZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="39872898"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="39872898"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 03:47:54 -0700
X-CSE-ConnectionGUID: UZ/m9DxqS12WxmL0Dhl9PQ==
X-CSE-MsgGUID: 6rkWAMxDQ7a+QWxYysCy9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38366571"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 03:47:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 03:47:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 03:47:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 03:47:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 03:47:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkOykfTt/7uhIr4ytDzGIrF/6XXLMFtvLDdmveXIE1nYeOUKnd1iq3QVY1xr3sR9WRyjliWaFLyzqVI4tIYLzAwnY9J4++ifP0V518XJL06B8fGxwy8VcWn1jh5VC22uyZLU1zdwIGA78fw/NnSYdFA7DnkOw2YG1JuRyKi8JQbXtayUcjK+P8xxQ6U7f9679ZSuPm34ok7coqcaEg4jAmmVKX34hsWaensIBavHeCWkW3vNY7hqNif0jhKYCruVlhFpoxdfi+NAhJliPqiaMPnhQT6yGa7LLN0Ywykdeeq8ZedtxvwQZfAuqCqEGPWCD1t7fHAC2QB5XVkPSZtp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7hRbGoOjm+2o9e4WUQUuB5UXt2H/Bv7HhtdIhJttyg=;
 b=BhsYyH0W/311CvX/SDq0Akf4/6i0b388CvlUbaz++7s0ShLVMmdb7FQh1zxvkXKQqFve+nipA8dukD5Cllf1N9LPi4IZUDDrBFkXqYR/xXEF/xoBr36TRZ0u7Hoe2UkHUPNnSgsAts8DiouDEumzgGeXpgcqyflfKHOHOAoImpRx7zaRn+NEaDtjg2k7M7FgycdnXoOBYvsXQ8Ycnrp1w9Bt0u95maDPpLcI0fhVAtGqmFBUCfzgEi5VLZyM10ZK2ryWdQF+iyFsyLt306NSfo+RDclae78LPbd2TFQhIvJcmlQGMYQ0pxsjmgSpa98yxYL9gw66b+qz7lSrZOtBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 10:47:50 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7633.036; Fri, 7 Jun 2024
 10:47:49 +0000
Message-ID: <f1ad4141-c72c-47ee-9cf3-42ff550661d1@intel.com>
Date: Fri, 7 Jun 2024 12:47:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, "Aron
 Silverton" <aron.silverton@oracle.com>, Christoph Hellwig
	<hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
	<lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <6661416ed4334_2d412294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240606144102.GB19897@nvidia.com>
 <6661f0dead72_2d412294ec@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240607002536.GI19897@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240607002536.GI19897@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM6PR11MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c13252-c107-4417-67d4-08dc86df4669
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmVJZUdjZnM5UWNrYWxYQnNwQ0hjaGVybmg2MWxnVzlNQmlqTnMycTY1RE1I?=
 =?utf-8?B?aGpSYzc2LzRqcEllMGl6ajk5ZEJlanhmOVhnempjZHExNU84TjdoUUZKOEZr?=
 =?utf-8?B?ZXhNa05JSHdGejY5ZHhaU241UStvb0lnWjNhQUZRUWVtWGpsL0FMNmRUVVlK?=
 =?utf-8?B?eHhKTTE1WElvMUpEb2IxL2phamZ6MjZYZ3JIV0xFVFBNTDJNM2M5RXBtNUFh?=
 =?utf-8?B?RzBaZmdabC9ZSFZRK3ExWnVoZWZmM09oNXdSSVJZRFgxRDFEc3dLMDI0WjRB?=
 =?utf-8?B?NDUrdXBySkpNZ2Z5NUlzM2xPekx1RGd1aGhEa1FySWVVb3lBa2phMjgydzY4?=
 =?utf-8?B?QUJoS1RZZ0JNdmN5TVRjZ3ZNdWY5OE9iVXFRWExrTEhNRnJqMW5xczl5ZWZl?=
 =?utf-8?B?bzJ4MGZGKzVSVXV2M3F1RU8vVVY4ZjB2cGRQNGZsUDMxUmp1d2VLdVo1eS9o?=
 =?utf-8?B?UEliZkZuaHRDV1RCeTVKT2xGM1k4RGRDTzhHc3BhMmFlM3dOT0dUT2tEdWlz?=
 =?utf-8?B?ZHpyVzlQQlc2cm4yeDFLTTdqLzRLRVJ6cmwwdHl2VGs5U2cwVXA2d3prVGlR?=
 =?utf-8?B?aThPOTV1S0lXeXkzYllBSURqSnpVU2JhcjNkVW1nMS9FZTFqR0FnQmxaOVky?=
 =?utf-8?B?VG9RSzk3UzJjaEJyTkY3ZTRTMFFNQ3R3c2YvdGZpUEVMSFVyT3pJeUhPL2tB?=
 =?utf-8?B?SFE2d1BHcmhXYTN4dWUzZVozbjZVSk9rL0dGZTlMQUxtTStRbjJjeDBjZDZn?=
 =?utf-8?B?RWhWOHBuNzNob3lzTmk0SU1yQWJHZC9DSGNpTmlVM0ZQYkJUNWdWb28yQjRm?=
 =?utf-8?B?TXcwSXV1MkV6QStFREtDOVVkNHM5UHhqRTlRS0orUHdnWjB2aStjbmUzT0Va?=
 =?utf-8?B?U2RCdXFaREY3aGxwWnQxWjZQMzVzZVBYTTNSdGQrNW9tT01jYUgwZHRBSks0?=
 =?utf-8?B?UEhQMzU3V1cvTnFtdzVDeUUxMWhZODNXRE1rZEpEWUJKR0RZY1BFWGpuTzdD?=
 =?utf-8?B?UFlHZGQvcnZMUVBsZnpuaGtWdGliOXZ1aWcySUdEQ3lacFU0WVVFNHgwWm5o?=
 =?utf-8?B?WjdkaTd5NUQyQmZEWHJCZTl1M2ltL3lIQWh5N1pnZ1BEQ2d1T0pOa3Y4Q3lK?=
 =?utf-8?B?cDVudmZVd0tpUVJsbm9qaXZkRjE5d0tuNjFOTjJTV3VGMHBlTDJBb3VkbXQr?=
 =?utf-8?B?OEY1WFZ2aVZlWWt0c0Qzd0N0anVWZTgzWUcvaWdXeDNzdllKeEVIT2ZMT3Vn?=
 =?utf-8?B?S1lnOU5OTXRWK3dyVVNqSWtvYy9VQ2pZTVpMdjY3cVFxVXA5aklQQkY4aDdE?=
 =?utf-8?B?MFIxbzZrNkZ6cFZINnRSKzE0ZFZNbVBFMVY0dDNFbGYvNEZlZVQveXJlT1Jt?=
 =?utf-8?B?Q3QrZXZXWVVRQkVKaWJGc0NTWUF3UHN4bERxU2RlbUhSTTFoVjRCK0R3a0dS?=
 =?utf-8?B?QmN6VWUyd21IMWwzVEV6ZG9hc2NJaS9BaUl0TWRSVG1GaUs2UDhDajBzVFdR?=
 =?utf-8?B?LzN6U1NJVFkzc3E1cU5rUWpOT1J3UHJGYWtOeGE1ZUlaeTh0dnRSS3dQUFlS?=
 =?utf-8?B?U0NqcGtacHBUVzIrQ2JvczdYTWpMWnp3M0pnTGZiTGpNYm96aGZnQXJSbEty?=
 =?utf-8?B?d2ZheFlJQThiRS9oTE4rRVNhVFhBWjhFY1RZVW5yem02eHQ0a0tqRkpkYzFm?=
 =?utf-8?B?SmZmem9jajNCWU5jMEhDMlNVVnF6cEcydVdzZUVvS2ZWZitFVlhFNGk1WHFP?=
 =?utf-8?Q?DhAHyGbB1kpfOS+/lqZiTnBN30WKqPCkXK6J+E9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnpaMXdKdGJrODRsYTlXMmdhdEFDd0M3bDFKWUdoNnp4dy9ZVXpQT1BIYlQ1?=
 =?utf-8?B?UllaWk5JMFJhVTd1cEhCTG5CQ2hnZkZUN0l0MmVhWEFCdDNSWTQrVWdvMGRE?=
 =?utf-8?B?OUtpZ2JKbHdKYklUc0dhaTEzdHBxeTF1OVNlT1gzSTBPaGdYci9UUUIwR00w?=
 =?utf-8?B?TXhkLzVEbVZhMmhJY3lJekNHcVRDUCttL1dwZG1YT3ZnemNYZW9YbCtiUTY0?=
 =?utf-8?B?TEIwTnNkL2l1b09YcVkxR29lbTRoS0N1ZlJIc2svVEQ4R0YwZkhxcFBnajFh?=
 =?utf-8?B?cnBTcEdSd2xJKys3SjNTNitLbHVYeTQrVjRQQXJYcnFPaEprTWpLZnNVbmlN?=
 =?utf-8?B?d25sUStCbFdvOHNaZ0FtOEZZRjlGSVRzN3UyNFJ2citpMTFsRU5TTkhzbExs?=
 =?utf-8?B?b1VmRG9HTTVZcnVxanYyTTJVRTc5UW1tbCtyM1FtZnhieWRRVjZDcm5UYUUv?=
 =?utf-8?B?Z2NBMXJ1VXY0OExLOEJQeHdVeFBqUEVEVEsrVWZSVEswNkhxY3BReWhHSnlY?=
 =?utf-8?B?NVJFRHMwQ2V6VWRIdjhmN0QvRnhZY3NudHpMb2dXNjVwQVcxeTJQenlJZGcr?=
 =?utf-8?B?YjM0SXZpeEhVZzJlSVFqbkRjOWhkWmZkVTRuNVBjU1k4VkxsbUJJVmVFUk9l?=
 =?utf-8?B?amRvaTgxOUZtMHdTVlBnaEV0V0hFNEZKa1FVcW9uanNBeTRGbGFPTEpwMTFN?=
 =?utf-8?B?L1dWYzBVU0J4RDB1eXFVYXlqbnpkR2xpck04Z2pDYWZrVnFjM1VaOVpnMXNY?=
 =?utf-8?B?ZVY2VjFhZ3lYOXNJTjl0QzZUSDhEb1hoQ1pqR20zTFd5M1J4eFdxUHhHVmY0?=
 =?utf-8?B?N3owb2t3WVI4Q3pjQ0F3VFJIaVlQZ3IwQzNock95SkJ5MVR1RGp6QkpJdEl1?=
 =?utf-8?B?T3VFWmNmd1B1ZWZ1YW0xZHJwaHZtR0dhT1pXRVF3cFFzYXc1TDgvVkFGUzda?=
 =?utf-8?B?ZFZQckI1ZUllN0RjUUFtZE5IT0pWVW9MUmttT3laSzJ3ZVk0MlRjY3FhVVIz?=
 =?utf-8?B?c28vRXFGWWVUOXpxTGxYMjVkUXhZY0srMlVuekh0aDRaejJrc3RMcVRRbmZ2?=
 =?utf-8?B?RVFRdUc0UlVGdllTZFRkSmlqdGc1cWZVRFJPNUhJR0R4N2tBRTNLVDRQdTl4?=
 =?utf-8?B?OVBKYkpTREdwWXNwQ25ZNEtVcnRTeERJUGhSNzNxM2h6cXdpdVliaERSS0JW?=
 =?utf-8?B?YXJLWE9ZVEo3WERsSkRQZVdSdlJHWTJGSG1LRzB1NHZLMStGUWhWY2V4aHRW?=
 =?utf-8?B?WHo4b2NmUEU0cCtETnp3QzZVZVVqOU1QMi9ZV1ZDR3VUL1A5WUxtOC9pYnEw?=
 =?utf-8?B?MU1JM3NxanovRDJBNW9XRmlHaFdkM3ltMktoNW9Udk9GRDdIV0p6MXg4Mis5?=
 =?utf-8?B?TDlwQndwQU15VTUwREJFVFBMaDN5c0k0S3JaU1ZlWE9lVE9pNzJGWnRxWGs1?=
 =?utf-8?B?NWZQKzVzOG40TUJtd1BtOGtpS0xyOGRMbDNwM2RQZ3gyTDhaSDlDaStoUkcw?=
 =?utf-8?B?Ri9hTmZZblN5alk1NVhwVGplUHI1amVkTytNV1NHUkw0TjY4ZWNnTkc2Z1pu?=
 =?utf-8?B?TlIyU0VEVnhQUWt3TnRqU1JLdnpqcElIeXhIdXRON2xGTFJ3dTFwNG12K0Jq?=
 =?utf-8?B?WHVDMWNremp5L0VaZ3lKV3hmTSt2QUpUNlJReU5OcEc1Vm9USDAvd09tU0JX?=
 =?utf-8?B?S2lIeUZXNE9UZVk5ZEJTV3F3VW1rSFZrUFRXaFdnditvTnpzYTBhVlA2QTg5?=
 =?utf-8?B?R0FGRGVuOExCM3RWQmE3ZVBwVGJZYzdXaWdkWmNtNVY0Ti8vcEpGK0Z4TlVH?=
 =?utf-8?B?WW01TjNxOHZwZmRENE5pYlYzZ29QeWYvNURXd0VGaVh0UFlTUkdBY0U2OTZa?=
 =?utf-8?B?Q0xGYjFiYmhOODlVZG8vT00zMncyMzFBUWJDbmx2RDNmS1lER1dzU2pud1Zx?=
 =?utf-8?B?TFNBUlYxYnB3OUJoY3N4azhJaURLVmFVdkcwbUNZRkYwaGlHMndNczJONXFv?=
 =?utf-8?B?UC9VL1A1NGloL0JEc0ZUcW56UG9mKy83dmN4Qm81TEF5SGhWUzZKb1I2bHFn?=
 =?utf-8?B?SUIxdGwxOWZtd3J6WVFiU1hIa2I1U0FWYjFOZ0pWa3V0cDFRQWI0ZnczSlVR?=
 =?utf-8?B?YXkvTVR0dlBFV1JPTDR2TnR0eVp5SG56VW9wU2w1RXIzRlFSZmw4ZHBVZlFH?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c13252-c107-4417-67d4-08dc86df4669
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:47:49.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bc91X86NRAnLH170mxBFrlbDSAJH0rDfDdcF9WEtjSEMq2Tmp5ivVkhMQ8PrU62NEtss8sQY7YD33AQpIinJaURoVmUgE9XvLp8K1JlL1e8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
X-OriginatorOrg: intel.com

On 6/7/24 02:25, Jason Gunthorpe wrote:
> On Thu, Jun 06, 2024 at 10:24:46AM -0700, Dan Williams wrote:
>> Jason Gunthorpe wrote:
>> [..]
>>>> I am warming to your assertion that there is a wide array of
>>>> vendor-specific configuration and debug that are not an efficient use of
>>>> upstream's time to wrap in a shared Linux ABI. I want to explore fwctl
>>>> for CXL for that use case, I personally don't want to marshal a Linux
>>>> command to each vendor's slightly different backend CXL toggles.
>>>
>>> Personally I think this idea to marshal/unmarshal everything in the
>>> kernel is often misguided. If it is truely obvious and actually shared
>>> multi-vendor capability then by all means go and do it.
>>>
>>> But if you are spending weeks/months fighting about uAPI because all
>>> the vendors are so different, it isn't obvious what is "generic" then
>>> you've probably already lost. The very worst outcome is a per-device
>>> uAPI masquerading as an obfuscated "generic" uAPI that wasted ages of
>>> peoples time to argue out.
>>
>> Certainly once you have gotten to the "months of arguing" point it begs the
>> question "was there really any generic benefit to reap in the first
>> place?"
> 
> Indeed, but I've seen, and participated, in these things many times :)
> 
>> That said, *some* grappling, especially when muliple vendors hit the
>> list with the similar feature at the same time, has yielded
>> collaboration in the past.
> 
> Absolutely! But we have also frequently done that retroactively, like
> see three examples and then consolidate the common APIs. The challenge
> is uAPI. Since we can't change uAPI people like to rush to make it
> future proof without examples. Broadly I lean towards waiting until we
> have several examples to build a standard uAPI and let the examples
> evolve on their own.
> 
> If there is value in the commonality then people will change over.

what has changed over decades is that now Linux has much more users than
implementations of given tool

I would love to see a move of the uAPI barrier closer to the user,
we will be free to refactor kernel APIs, given "the system tool" will be
updated at the same time.
Obviously for a new uAPI that would (re)move the promise on the very
beginning.


