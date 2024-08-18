Return-Path: <linux-rdma+bounces-4405-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB372955B51
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2024 08:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F291F21D7C
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2024 06:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8E6DDAB;
	Sun, 18 Aug 2024 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSBGr8P6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD8FDDA9;
	Sun, 18 Aug 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962312; cv=fail; b=NUczROyK+wygNziRqGsQ2tuT+rIhd1YlenjIagxxPQd9dGDRFfy9NNxeIhm02XJwEJ+WxHtjjrPX/PoqVCftlaULyqkuJxsDngGdM7X0XKjLEybM2v1DzpEW05AQ/Pyk2akad9Zs8lkhuVGeXqIZJQb93ID8t+pI5GFpl7anpCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962312; c=relaxed/simple;
	bh=j68uvuNsxR5yAfzlxnTQD7Od7XKnghGZUGueVmYDEWE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=op9KuRc2gYI+Vb+eOev+37eK4mWLO7xfCroHRwUHsM1WUJv2hmpDj+Ir6vZaqm9NnSwVYm3/xlENsyUZ+mc33JWh3hjqRKzmVjw+J4V/7HMuqRw0a0ZZ2OHMc0LyDqzc8q5hO969jzJPbMaOO7iMZccLDMcXa0nRCBJVjQYf3ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSBGr8P6; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723962311; x=1755498311;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=j68uvuNsxR5yAfzlxnTQD7Od7XKnghGZUGueVmYDEWE=;
  b=dSBGr8P653H9w70RDpU4j4fXlMCKfASTX5x1mhc/a3TWspBcyxBn3hYO
   HkVrfVoIRQSNdyNE7KowR+69jbYraqDf3sT8+mYeT7ZxEWhCEURXtl+vi
   JOvHUx0JfRXF6BSj1uW3kMWEh18kanegHL0gBU/PekRiZPyUvmcKtDQ1+
   /6Kg+lB38r1Q+LzZw7WcrdLLqrPwSXpVPebWdLNkc3uDLK1bzMnCrwhNm
   OcM9dx330AI9WaDwEhtvECQh/2SgH26VxUWqng465ldXzxSezd076BYBd
   P9qcC9NoJbws8yNGSbbyT/PqJXtbhFh7D8ZNDholkxEpAi6MKJQ2UgzB3
   w==;
X-CSE-ConnectionGUID: sCpKMb9eQESW53W0TWY8LQ==
X-CSE-MsgGUID: QqLPDVLVT0yZoh2Brj8JZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="32889123"
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="32889123"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 23:25:10 -0700
X-CSE-ConnectionGUID: JjgKAfA7Tc+KpS5dwEXizw==
X-CSE-MsgGUID: zztUl6OnSfmqNH1S6M4pjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="64956315"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Aug 2024 23:25:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 17 Aug 2024 23:25:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 17 Aug 2024 23:25:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 17 Aug 2024 23:25:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7ewD5foC9ky2sx2pIO8/mXMr/amIgzA/UDFWKsQDDPQcT7tTnzMHoXIWlUk+B1RlWkTL17+EIBs+bAYxA4XdbTmqFyyqQ4wL0VJgYoJnZNsDvs9GgP58se+4ShoU39vq8qn1sR1VqAq7bmuyFpSKTCHt7IjKR5W7DOue11FrNUbVxPpYD3LFjXv5y2hhuLPzuekm188ubP3aqpZ11MKoiimEwOOnHBcc0ok8QZAvRynH5YCG/EoYnq0TYQXVqIyu0lKhqvG5Esg82ee+RpqdRFVu+w9IAmTUXgGMWbzHGHFuYXhgY0Y/tzunhajZ55ZAVQY7IhU28qxsrw+5exTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbFOsxJ5fZq423ehbirNAB/UyNBnnn/R3CfBWBiAFE0=;
 b=DrN0nSoOoB4expZOm89ivKNv8UfDMV6LN3khf6c57v1XYqqA98k2c1BNqdmP59Txf4IOOoD/CyHk5jzalXKjojEEbPIq5hySD7EJyrNn4si5ImauL4Rp4MqOpw5/dHWudT9aJ+9NGEViBgOc8rDyr2/o9UFjDfRUxXAw/p9aZCScayxezWji3mqP54XTfJgdGaQY3XbgUBmpHxJ7zELTfhGQsV8A2GNWb5U1Sur5ueD/YAiQMajdu7o6vMfz3xCngprh66hHNJaoRTZMZ10ScY/MVhXSQPVi2+1GdJDgjOYdDHHLCr/QlCr7SRbSM+aEvBtaXl8Q47ASJse+DdaCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Sun, 18 Aug
 2024 06:25:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Sun, 18 Aug 2024
 06:25:02 +0000
Date: Sun, 18 Aug 2024 14:24:52 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
CC: Bart Van Assche <bvanassche@acm.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Leon Romanovsky
	<leon@kernel.org>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	<linux-rdma@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [RDMA/iwcm] aee2424246:
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
Message-ID: <ZsGTtLzYjawssOs9@xsang-OptiPlex-9020>
References: <202408151633.fc01893c-oliver.sang@intel.com>
 <c64a2f6e-ea18-4e8d-b808-0f1732c6d004@linux.dev>
 <4254277c-2037-44bc-9756-c32b41c01bdf@linux.dev>
 <717ccc9e-87e0-49da-a26c-d8a0d3c5d8f8@linux.dev>
 <3411d2cd-1aa5-4648-9c30-3ea5228f111f@acm.org>
 <5377e3e7-9644-4e71-8d2f-b34b2b5ae676@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5377e3e7-9644-4e71-8d2f-b34b2b5ae676@linux.dev>
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 449a4044-80a9-4eeb-dfc1-08dcbf4e7e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlR6YzNpT3E2WmVPb3I2NTAzSnhWVFNIOEE0b3JPb21WTXFoNmpCb0pHbUJ0?=
 =?utf-8?B?V0V1NmpGWVMzZWdhSnNtcFlGRG5EWmFZcnd6US8zYWNPTHl5OXYvV0Yzb01J?=
 =?utf-8?B?b3A1b1pLdWxLdzYvTmdxQlNRdDc2RUpCUUhZMjIzU29NaG1LbzNiUUVCbTJD?=
 =?utf-8?B?Q0pVSDhxYzhHclJqTlpHZnd4ZGNqWkkvdzVrMmRJQzJSS0JMQk4xRDRuNlFZ?=
 =?utf-8?B?a1lOT2JMZEt6WVRYWG40SHNzenBIQ3M2V0JHZDZuUjVHTE5LVDJrWksrSGYx?=
 =?utf-8?B?eEFGVURaM0dpTlE1TmxJL2ZhcmxxUnNOYnlaSlhuYU1rNTJWS0Y4cGo5NUg4?=
 =?utf-8?B?RUQyTlVaS1VSU1NURDFpT3lDTVBoQXFnVENuNmpjbTQ4NDYxYzNFYWhjS3ZB?=
 =?utf-8?B?QStTUTJBaUUwYjIrWUliS3pGTStzS05XcWpGZVlzeDZDeTVSUDRvWFY2a29l?=
 =?utf-8?B?WFNsOGdDeVE4cUthWXNkWXJDUFg2ZzYvczM4clB1V2FkdGlNeEpNTUNIRTM5?=
 =?utf-8?B?VjByd2JmM28ycVh4UzVEcmZLc0ZkNFNabGlSMTVMTFYxRUtDRk0ycUdER1ps?=
 =?utf-8?B?eHZWV0xwcGFLenNjK2ladGNQT0tkcFIxRG5HUFBMZlhlcFRRTlc4NzNBekpY?=
 =?utf-8?B?Z0pneDBZSWx3ZVNBZFR4RUE0bjJxN21KZ1FKUklHZjRPVUxXK0VxU2hualls?=
 =?utf-8?B?dzIrRnRqSnFGNU1vMVp0LzBVZllOOTQ1TndDcUVsR3Uxb0Z1K21YWkhwbHZu?=
 =?utf-8?B?OXQ3ditCc1N1eGNtZ3JpOWZ5cjU2L2tjTEpHSjgvc2RxS3ZqMDlISGc4NVF0?=
 =?utf-8?B?V3VpQ0N3Ums1bVk4VGltdVZsdWpYVWQvcnRQY0NNMmJ5RDlYUjhnUURadHVh?=
 =?utf-8?B?VWJlb0oxakhKaDA5SlVSaDlVV09IdktiYjJobkkySmVSTEFNSk96ZEV2dmNM?=
 =?utf-8?B?N2picTF5dXdwYytxQ1o1TDJBVXlvV3dTMEFqYUFNN0JncnFwZTBicWgyTkFq?=
 =?utf-8?B?Wkx2cUxncEJhTkZJbXFBcGI1ZW9TQVhvOEJIa3JnQTVydHd2ZzkyYnk0QU01?=
 =?utf-8?B?RXFybzlTMDkzNGI3YTcrd3FtalFuV2s5dis5aE9jbCtyY2VrRVZHdi9UbjF2?=
 =?utf-8?B?VGw5Z0E3Zi9JZWFKa0lmTzJVcUh6VDlGeE16VUdlQmtlKzVmSk9jcVY0dllO?=
 =?utf-8?B?ZkdpM3BRT2F6NTRqQTROUUhRMXJSTEU2MkdCZ3NOdzcrVmVlL2xiM0MzOFlu?=
 =?utf-8?B?b1lZRXhkZG5BdU84TUpWeTh0b1NjbVlUNUExNWMxZ3hyVnZHcnFtMHlwSVBi?=
 =?utf-8?B?a1Nhc2p0VXRjQUg0VHRrc2ZvQzRsY2xWakRUZGpIdWZ3STJHM2FwVWM0YkxC?=
 =?utf-8?B?eTF2S1lYUHk5QlBoM0J0THBjSDhvenpPLzBHUGwreDVaYTkvSEs3NWU3WHUz?=
 =?utf-8?B?RXQ2UGtFRUhOT1lETkpWZEx1cUY2b01RQkUzQzhHdEFGOWUvN2wwbXoydUVG?=
 =?utf-8?B?V1V4bitBSzF5RTE3NkhvUXNaRjlnb0lZck9ZZFhPSmd2UTZMMnprYWlRTXpM?=
 =?utf-8?B?NnpZU2Jxdm5UUTJKUkVsVzNDRTVnbnhvRGxJbkE4bEt4cmVLeUMxOWdLNkph?=
 =?utf-8?B?YklkZThqNXRUR0tNMnlwVVNsMjY4ZDg2ZTNYdnYvT2wwMjBLS0M2cERIVXFy?=
 =?utf-8?B?MFgyaGcvRDlINVFQSUVicDdHVjE5ZUwvc0VUSEpFSzFYM2N3VitnTk1LSlhX?=
 =?utf-8?B?aHF0ZDU4L2k2d09CMzBQT21HUkRNVzBBWTNROXMxRUdnUlVqMjV3eFRzMHpp?=
 =?utf-8?B?YlJKMnRhWVo3TmlxWEo2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGw4T28zcVlYNURnNHp1T1ZncjQ5NThFbTg1VUNVQXdOOUUzSWE5dlRVckF3?=
 =?utf-8?B?WEp4NCsvQzUzLyttSUd6eWhmc1dhd2I4S1RucCsvYTVyUllEOWJQMDZQMi9p?=
 =?utf-8?B?R0s1RUF0bk9kL0JDVTVPS0lJQ0dFWDZhaWJWbXVIMk4zUEpTNk05bEdqVjcr?=
 =?utf-8?B?Y21LTjJzK2ovZExteW1VKzIzNUVnakx5K3VjN201NkdXR3EzaklLZU9GOUpJ?=
 =?utf-8?B?U1VWc3NUVmRkdjBxU29GS093V1M3ampLb1lTYm9wNUtCcjZ3MGtVWEtVemZi?=
 =?utf-8?B?cXc2azQrbm9rejBZQnd5eUJTVnFadm5MN2pEcWF1dW9yeEQwa1JRcHFIZk9E?=
 =?utf-8?B?WlA3cHE2QitZdFk5R2txVlN1d1I3LzVOR2t1aGpIbFhhTEVxdVZqVmZyQWYv?=
 =?utf-8?B?RzJOdDByZXdsUy80UWRpTEFXZ0FpTUdjdW9Ud1o0cFMrcTFRNTVRZyt3a05m?=
 =?utf-8?B?c3dTVDNQSmJLUzJuK3d0b0xUSFJTUDlSVVVhdE9CTnh2L2R2OEtlVUY4NXF3?=
 =?utf-8?B?UkU0Zk5YU1h4c3ZwMU14UGRuVjJxVU5oVVM5Q1ZSVUxvSkJLaC9IOVNqTUhZ?=
 =?utf-8?B?YTVoNHZ4L3dLMzJlSEt4cUZOanlCMzN6YWxxWVRYODNwYzBzQVZjaWJEbitD?=
 =?utf-8?B?NnBkMndzZEI0VEZJVjBYc0hhN1E0bnlOSDBPWGgvbkpta1A2K2hsUzRWeWF1?=
 =?utf-8?B?Qk1LUE5BOVF3a0tTdmxzc1E4MFl5Sm92T2pZNmZDazFESmdJNk5rQlRJckpJ?=
 =?utf-8?B?c2xITGRNYm9MTlNtUE9mV21sVVJIU1l3SldvRWh4VlVNWVZQUXVNQUtIT3lx?=
 =?utf-8?B?R1duSDJRRU9EamNkYWhYU0FrbTBUTTQ1RlRwZmVRZlNod1FReFg1SUhGYW56?=
 =?utf-8?B?bENpbDVLR1ZMK3hWNUF6VTZGU2tmYi9ZaWJrR0puOHNDY1Axa2YyOVJ1aThw?=
 =?utf-8?B?cVQrUkduNEk1R21kOTJvVTJSRUpaUVRDSmU3dzFRTHdPbUhocmI4NnQ1UUUx?=
 =?utf-8?B?d3EvTHRPeENzdHBKRzNZSFlDbEl0dWtwRDVYaFVyRzc5Y1NTeTJiL0Rwc2Zy?=
 =?utf-8?B?QTEwbzEyL1YvY0xNVXRZYUpMNUhHd2dkVXZneGlqVVhPem85bDNtdTUyWElE?=
 =?utf-8?B?dmFoRXVyemNGaFhzWktoZkFzM21xQklpR2RhRzJIbDJoZXhqNzYzb2xBeGFy?=
 =?utf-8?B?d2RXaVFUMmtyQ2U2SjFXK0hsSXM0a3RKOG9LWnJneTdOcDF4dDNoazBhWmI3?=
 =?utf-8?B?Z0R0SWdnYlB4VlBDNHM5djJicVYrSmR4cWpZdFFVRUFFeDk3c3U1TTRvRlhm?=
 =?utf-8?B?RWEyd2RFS3E4L1MrVWN0OHRPOUpPQmg2aGVWZ1QzcUludHV2d2ZrREkxeXAx?=
 =?utf-8?B?cUkrb21Xa3lhQlovN3NyTHJoaXBXQ3AvYmVIQjhXUmNWMWhoZzY5cjh5RWFW?=
 =?utf-8?B?clpMMVJqRnRXL2FGcG9jWjBZd29JMVZwMUxBS1ZqM0FUZmNqZHpJQW0wT3lT?=
 =?utf-8?B?Q3hEU3JuSGp2cmdlZmtFT2p6d1JqMXk4VVFleCt0bFJ3R1l5YjVENEhjWGdN?=
 =?utf-8?B?Y21QdFM4Qi9wNFVoQ00rNTQrbWFTdkdLUTlDbnZUUmRxQkUyaXYyejJHQVZl?=
 =?utf-8?B?KzZacHRXZmJWSUxxam1DdnJ0bi9nczhvOTFEald1bHk3Z2lZczhTYnJ0NjRr?=
 =?utf-8?B?RmRkcndhZS9YNmtxU2NWeDc2V1BETkNURi9jVllHUjdZK3J0R1l1TlJIZUxM?=
 =?utf-8?B?Y1k2UERSc3piTitMQ3pSN2dEZndycDhSWEROWXZUYzZqOTFUYklZSWxtYkZV?=
 =?utf-8?B?cU9GVVZsRzN3ZWpFTW95UzdYZ3BKWWdDUXU4ZlZYZUl5MVRibkZuR3o0Mit6?=
 =?utf-8?B?eUV6NC9scFZoSlFPcW1FTGZ5N3NIVndZMjVWVjZ5UW1hZ0RkTVBCcTUyRnpI?=
 =?utf-8?B?UFJmeU0wYnRsWUZvNHUxWStvTmdKS05Ec0tZYnJ5U0Q0QWZ4RkR0clhCNDhn?=
 =?utf-8?B?Y3VkbmM1ZmxNT25Zc1FIa1d6SG5nN01KYVR6Z09XYXBkVWdsMzRva2VUL3Zp?=
 =?utf-8?B?MHdJc2luYysrL3d6UVdBWG9heHlGcFVxdG5wcHFBS3owdkx4Ly85b0Fmd3pC?=
 =?utf-8?Q?ESh1fTrB1YzqZuBnJiUv1bjG4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 449a4044-80a9-4eeb-dfc1-08dcbf4e7e00
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2024 06:25:02.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75PIzfZGQpxCvjazX7es0fB4Q3GtSQEVGCKqRDU4BM12JhkAYPP/CdSD9DGy+42QQM2LAZhkCqswjWLlxy7N1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
X-OriginatorOrg: intel.com

hi, Yanjun.Zhu,

On Sat, Aug 17, 2024 at 04:46:23PM +0800, Zhu Yanjun wrote:
> 
> 在 2024/8/17 1:10, Bart Van Assche 写道:
> > On 8/16/24 5:49 AM, Zhu Yanjun wrote:
> > > Hi, kernel test robot
> > > 
> > > Please help to make tests with the following commits.
> > > 
> > > Please let us know the result.
> > I don't think that the kernel test robot understands the above request.
> 
> Got it. I do not know how to let test robot make tests with this patch.^_^

we can test the patch for you. just cannot test quickly due to resource
constraint. will let you know the results in one or two days. thanks

> 
> Follow your advice, I have sent out a patch to rdma maillist. Please review.
> 
> Best Regards,
> 
> Zhu Yanjun
> 
> > 
> > Thanks,
> > 
> > Bart.
> 
> -- 
> Best Regards,
> Yanjun.Zhu
> 

