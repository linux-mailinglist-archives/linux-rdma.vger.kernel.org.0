Return-Path: <linux-rdma+bounces-12271-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800C6B0913A
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 18:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349833A5865
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA6E1F8723;
	Thu, 17 Jul 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0AbGyKp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9813D53B;
	Thu, 17 Jul 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768111; cv=fail; b=hLIjOmO26RPhCrFmBw341Gb0CKJFKh1om6gewy9AX930SOEzSMF4OANwmzQz9OUMF0+CTmqtPh9JBuyylYhLm7JhiTCHe14/vKO5WDF7sU9+UJFC2IN6Ww4PKq+DtWk9PJ9F8ir0s9VIpsWVkISlI52bzONc+1/4cCl98xgqCl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768111; c=relaxed/simple;
	bh=/WpyiNclAC9xvEMWqZi5cajW+9z1Qogtd+bbqUVJGUs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDt5BOKJG0T81kVlyyYCV6VSSUwRlHLvURZXctnhXB38DVMJ50IAGrhesRS7ph1BPGarbZWBpQtl5LBcWq/xZGxrodzTAUjz1FnTSm5+DJQt2Nw6alFBcTBrHYaWOhmNKPWdfP9E7iYxu2iN7/gLisM0mdXJu0BOyN7Z2xrI11I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0AbGyKp; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752768110; x=1784304110;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/WpyiNclAC9xvEMWqZi5cajW+9z1Qogtd+bbqUVJGUs=;
  b=N0AbGyKpVjwbofEGgxR5nGIrEUgOfYeVCpoBHepH8rOTo9xTIB2FJYtD
   m2L6Gb/C4zxXuSdvQDkBjtKdhyLQI4bcNegq1J4KRqn7iN84uLpDanql7
   K/Zv9QhZVYW4jSAYgwa6eDP31cT2qGw58EfrzF0LZ8vrAzItIxUaoxdDs
   z4rA4DmU7nZYlCxcLZd6H/kJZRgd0jgIDT4AAQt9q7Mqod85kipPsLhQ/
   4D+AxGV6JiT+HtGXn6LIsd2DzbCN9USkZwdCE5MbiPhhL8xkzPiPivJHt
   p93ityYRkEYl9uxhpsmLDqT7VOm85Tt3dX3CuYvPPZ5byEzSIm+bR4gmE
   Q==;
X-CSE-ConnectionGUID: AAO2rWX4Sq+LA9bGa0tjyA==
X-CSE-MsgGUID: JXvkqiE1R6K3FKlXW6OqKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54987855"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54987855"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 09:01:34 -0700
X-CSE-ConnectionGUID: Tz9wkFL7T7ekxJoLUmqxjA==
X-CSE-MsgGUID: UwMwfAOERK6CdQ0gCxiHKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="188775657"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 09:01:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 09:01:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 09:01:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 09:01:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktnxU3+NYVjgeKsnX9RkWugPK/m+DiHn8rhHJ8IQdKTye8/IaYRCQItNqZDAK4xZjrL24ha5CxL8dhCemcCMq5w45TaoLNnbXywZu7yNH9omGkKCpOKk+0fRD5yhRicQnl0pLScBDJS0RI2wCWqa7lvVJTwWSZEY0l3IY/goDlaP70uIAL4s3FT90CTW6Y06L6Rvi9GaT8Dj+w6qXf/BXE/t+1UzcYuAkEy/wX4ZoXaHfRMmA8bhlgWrlbj0EMCyZoWBE+E7ZFW7MtG8vFdJWUN+NjdQ4BoAfl+gHNoeIU267AQdYGU/W6GH1B9AIF+ISzqQEdQFYvJWvGHqRij4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+DHnDN5t4ubVbAZPNeZlh6xuAwTkpUx8fPgtBms1js=;
 b=cRf6FMJQRGLc1VYrBgqp/+MiMAFQZjk3LxqT3SmX7n70btuSW9FdEGypK42TG8vV/VCCuleIYxvDNWE3PKTpajwqAXgyTJcadFYhjVorePKz5hDTWOJOX61r6EYPAkYLGtkT8p3iB0DsINHchW6ImI+dONGM/W7vdu/i9FBaxkOQnUrkCBlaTl6FLE7Vn0ufg5dspBED+J7QvcGLDFK8PDs5pX2bU6mSgPdbC4rAdAw3BzGIZKRhVAk/0KJHTWJTKH92fuFjYGR9KXDYQHyUxxNQ5EniirikE60gPG9lmaxmJqUdiXKuIFvBgeZb95KGxeQJnyBF0xDLP0gkuIvHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.35; Thu, 17 Jul 2025 16:01:12 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%4]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 16:01:12 +0000
Message-ID: <78d4bf2c-c436-4f7c-8940-6ae9f6241133@intel.com>
Date: Thu, 17 Jul 2025 09:01:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,rdma-next 0/6][pull request] Add RDMA support for
 Intel IPU E2000 in idpf
To: Paolo Abeni <pabeni@redhat.com>
CC: <tatyana.e.nikolova@intel.com>, <joshua.a.hay@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<jgg@ziepe.ca>, <andrew+netdev@lunn.ch>, <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20250714181002.2865694-1-anthony.l.nguyen@intel.com>
 <245a03a1-a2a0-4975-a68b-c70d22d01d97@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <245a03a1-a2a0-4975-a68b-c70d22d01d97@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:303:b8::31) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DS0PR11MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef8ebf2-b63a-4caa-4c69-08ddc54b269c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzA0Ym1SRjJzamZXczFab3AyN0Z3S09XNmwvbENCWGhvaXdjODJ5UDdpNFFD?=
 =?utf-8?B?OGdxTXRvdGhqWDJPL0h0eE1XMDNvVWFvWGpDT0huQTJwSVJBMGV6YUhsbHUz?=
 =?utf-8?B?Nzh1VjkrRms5QVJ3Y1I2ZEZZaEd1VXI5S0NHa1A4ZmJrZHl3amZqL3dhQ3Zj?=
 =?utf-8?B?WWIwRE5uQytFV0w4b0xsRHRyUjRMcTN0OXZhdWVzVVIvaE1uc3pMWDJXMlFM?=
 =?utf-8?B?RnI4enNJaWpyc0VvUk1aT3dkY2NDWXJ5RUdqekVxcXVueXBIdE1saGtzeEpN?=
 =?utf-8?B?TFZlSUJXbGJxZnpGYnNNdGplbGR6RXVnUlo2MllnOGtVNmVpd1VYQzY5eGlR?=
 =?utf-8?B?aGhZU1puazc0S2c0UjNiVGRITnJ4KzQ4VUZZQTd2VFRhaGx0aFlDZEpXWS9Q?=
 =?utf-8?B?dHRoU0IrSWkrMTVIeXJFd1U4TUhCVnNyWHlEYVhtRHdNS3QzUFlsWmpFS1FK?=
 =?utf-8?B?c2FBYStHa3FaVUFyUUpxeWVheGtKM094QmpDdlZIL1cxU2l1ZFFKcFVHcktD?=
 =?utf-8?B?R0gySFdmZVhjVk04ajlVbm40OXhBOUthMVJ5T1k3ZkFZRFhZVVZjVi9sT3Q4?=
 =?utf-8?B?bWQ1NWl2eVluM1BjOGxsSnBsYzZuZHQramlyd0NaNnc5Q3NaNmx0WlBFSmlh?=
 =?utf-8?B?SHJIU1AvRzg5VklXZ0JQQWdPeW16NVlTejBIY3RnTVZEbjU4T1FoL0gxcjg5?=
 =?utf-8?B?Mjg3NFN3a1k5eUgzZFZRY1hSOXNiYy9Cd3JLbGo5KytUSjY1anh1dEJWdkZQ?=
 =?utf-8?B?MUJjNzduNENjRDBHUndSbFk2eldJMjh6b0RwMm5CckgyQ0lkQ0NnZ3lNOGF3?=
 =?utf-8?B?aytLRGlmaHFCU0tSR1ExeWZHSVROSEZlK0t1SW42NzlqNlhnQzNTalU0WUli?=
 =?utf-8?B?NEtwelRtRzRUd3dHN1BscFRVZnpqSTMvTEY1VjdENVF6NUw3NWVjZVJEbkxR?=
 =?utf-8?B?cSswWGNZM1lzQXIyNWhhSW1RcFRlQml5TlhlUVUwSTFYaVNadEFLSGVHMnhp?=
 =?utf-8?B?WVNBZ2trYlpUaXpkbm15Z2VpTjNFQm9SeHpVT0k1R2E4NkIwR3NzcWlzckZh?=
 =?utf-8?B?ZnQrTTZGRXl5WFVOS1BDVGY1dlJLK1gzZ2svU3BlMkM0YWx0eWtpYzhiQ0RV?=
 =?utf-8?B?UjRUS1dQMEplWnVMRG1xRVp2emtuejl6YmR2OTE4aFBJQWtxZEtHSUEvUHNL?=
 =?utf-8?B?dS9GWWJXU1RYdmM1WVFkbWZHS3FhSGdzQmhDYVFnOWlGQzNXUTI1eGVOMkZ2?=
 =?utf-8?B?aWpTSGorL3RYZnVYL3VJc1RtUWd4bzhwYWlIY1lqQVlMc1grK3RFVUxGeHpU?=
 =?utf-8?B?Sy9Pckl1R0JLc0ZETXp4S09razZ0MVlmeVZzaitEZENXeWNGTXl4QmRhaXpE?=
 =?utf-8?B?STNyMWY1Q0U5MHR5WTRybHRzVlVsVGlNc0RkTHdpR1RBelZBTzZiU3p5b1hl?=
 =?utf-8?B?akJvS3JxVklqNTJ3ZWc3a3d0RGhXWFNiMmlIUjM0S2RDU3ZNNnl6RVhwRGxk?=
 =?utf-8?B?U1RNYnVvUzlUenhoc1Qyc1NwbEVsYklrcUcrTlFIUGttUVdWSUorNzVrVmtJ?=
 =?utf-8?B?U0JZRDJSZjB6Z0NqRWsyTmNWYmRJRHFUQ2hGOURCUUw3eVhNemdaVXUrS2U1?=
 =?utf-8?B?amE1MGNva0hPR0wxUXFNeUxid3h4ejFEam9JUG91d01PN2VxelhQM3VGa3hY?=
 =?utf-8?B?c3ZnQlZ4Y3RXZzk5SldYQnVjSTZVTW4zdWlRbEdXVWdOcjNSTGJVclZ1Zkda?=
 =?utf-8?B?cXdSY1Z3TE9NV29FbjlTc0VVbzcyZ2dXU0FKT1preDVtb2tNczdWQXB0Zi9n?=
 =?utf-8?B?M3k4bUZPSDRMcjVMaDJoSCsxZld3TVFpbU5KOU9RRmUrWVdTakc2TjN6Y0dX?=
 =?utf-8?B?RU13U0tZRlJOV3I4VmFJVXNCU0JzeWVHZWVRT0hmdWdkelA3djB3TTRFS0FK?=
 =?utf-8?Q?J94cnjz/oD8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STBrYUNLSS90TXRPelVHa09hSGNkcDF3WDc4VFRoaHFGSzZsY1MxUUlJRS9a?=
 =?utf-8?B?akMxZTZxbVBqQlFDK21uVk1yZlhVNXNjbkYzaDQrQTJoajVqa2xxMTl2VXVV?=
 =?utf-8?B?S1ljK3E4Vmt4U2FMVVNSdmx4WnFxYnRzTElVNUoyY2srS2Nkd3hZWVZLM09G?=
 =?utf-8?B?NnZhTGRkc3BoWmFpT3dQMTB5NlluZnNCYVpYZ1U2dTJyU2RTNFRUZ0FyQTRh?=
 =?utf-8?B?bUNHN0YvdElja0NrR3VBUDNZaDVEaCtJcmRxOTVLNzI5Sy83eG1XZ3dIRzhS?=
 =?utf-8?B?WDd6Zk5zbHUvTGU3d25YV0FKN2NMbXEwZEQyckhNSzV6MW5qSEJyOFNqMzZq?=
 =?utf-8?B?YlFBNEVGeVdnSmlGZUErMXVoQXV5ZzBicmhwcE9sQzF5SUFzaUhSQTZNTm12?=
 =?utf-8?B?ZnRxVExiVmRJMHdwUk1DQ2lyREhkRFRJQkozUXQzYmViVFE3WUVKK0hJZVNQ?=
 =?utf-8?B?L0xuOW1hMlpDcjduWGtNR1lEeEJrTDYzZk5scmVnb1JtN0o0Q2cwV3U3Q2V5?=
 =?utf-8?B?TlZ6R2hQOWJQMkh4b1h6SGU4ak9kaVNlcjZ1NUE3TWMrNVZseWlCWERCVEl5?=
 =?utf-8?B?OExOR0ltTGpsYWJYdjZ3Y050MjhBeDUxUnZvSEoxeTdaNHlVUlQzWjQvMmdm?=
 =?utf-8?B?ZkZzYnNDVFV6QUhJa0VuejdHc3dkMmp2b2JubUM0VTJVUm94NFV3cTUrTEdI?=
 =?utf-8?B?R0VYR3hYQkNoS1lOK0NDSWtKdFRQUXl0MlY3Y3dTa2E4ajRQNDNqYTArdnJV?=
 =?utf-8?B?emV4Tk0wdFovZlVwV2VJbFNGaUNVdi81UDQ3R29Qam5yY1QxWlBXdGNBZ2Rx?=
 =?utf-8?B?TE9IaFJ0NTdDYjVXSDJsVTJVQmlxeEZ3Z0g5R3JILzBaN2sxUWJ0Nk5OUXVl?=
 =?utf-8?B?WUUyKzVYbC81OEFqdUR0THV4dExwMW9kcUpEU2hOT29NMFNianlNU1N0SFBU?=
 =?utf-8?B?bloxcFJJNE1FMHVlTWsya1QvRVdWSlgxZDkxb1RxWmZSTzllS1E3OFpVVUx0?=
 =?utf-8?B?bWhkdVFvYzNaaUJkeVNEZTYxSThlN0k1MjlyaWtxMEYycU9vczRNNVhlUS9v?=
 =?utf-8?B?UWRWUkhTeDZ4U0w2TmovR1ZVNXp3aFZXNHl0VS9xUERtSkhZLzdzSzVJeFBu?=
 =?utf-8?B?MzBCbldiT1JHR2pSWVF4Q2RkN3VoTENxV245aStreW5wWlV5V2JzVnZTRVo4?=
 =?utf-8?B?RmpwU1ljRmhiemQvbC9xZ0djYXc4ZnMvZlo1RjRtWVJIK1dLWXU0VHo2MG5r?=
 =?utf-8?B?cERGZmFHN2hOSTBrYlg5MFlibFBSUVN4SHFiK0xRdDdHZFkvc0JMVkZKd21B?=
 =?utf-8?B?TkpoUUhaOHB0cm9TeHdSY0JvcHBWRXJFMUdEM051K1BRU0hmc2N2TFFtYURC?=
 =?utf-8?B?QTJlaFNvbUJVaThsNUFXejdPMDFqL3hsbVhxc2lrM2ZGK3poWE94N0lURkEy?=
 =?utf-8?B?ODA4a3A3L2lERXQ3aVgrcnVucTJKMDBmWGtvSCtKaENWZnZHbU9SR3RrMTI0?=
 =?utf-8?B?SHk4eEVlaGF4Ri9aRWhaempBRHFIYi85bUNIZzFueHM2YUJhUE5tUUJyYzYx?=
 =?utf-8?B?OEt3K0dWcjFwWllLbVA2OVkwS3d2dkQ0M0RPK2QwemdLbHg4MGpyWXhCKy9q?=
 =?utf-8?B?QmsrNUZlQzJYT2J3Um1vT3hHRXJDRG9FSHFhRFRLVlUvVFF6VXBQZHVmdHVN?=
 =?utf-8?B?SmZ6cmFsb1J6bUVuNXlIUzdrblh5MEIrZVRzU1hkNllLTFA2aWk1OUhmdHZV?=
 =?utf-8?B?TXNUcGd0WXVHRWwrMG9YUWJYeVkvU09DNk42cHY1L2hHZkk3anZzbUtjMzhs?=
 =?utf-8?B?QTlmRnF4L0VOYmNqYktPWVkvaDJvaFNCaDExTlQ1SDB4ckhUMHZsWlF2dW9h?=
 =?utf-8?B?dCtxdStpVmcvTzBteEhnUnN5OTlNeWlhQWE5NjRzbWloOVFzcGhoM1VLSEc2?=
 =?utf-8?B?UFJuUHN5Z2NjR3lJSXNtYUNtbjRtOG5DUVlJY0hjV25qRTVSSFFxVHhMeGc1?=
 =?utf-8?B?MG02Rm8zK3pBWWwwL0RVN0pDcmJSaVRCTFQrMEI4N0FaNjgxNTJJd3YxenZ0?=
 =?utf-8?B?TXEvdklQb0ROcVNSYkc2eHk5MnU3NjRUTVVzeExnRFlmaHhPWEhPUmFtd1Bl?=
 =?utf-8?B?enlDMExnQ0l4Q3pOZUZPNEwvUUsxSW9CR0FRTVdBWXpRZ0p3aWtSYnB3NTRW?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef8ebf2-b63a-4caa-4c69-08ddc54b269c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:01:12.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Wumho3Ew8xf51k22JpaoA5ntkBKMYIYk/e6q+glyRtuHzxExZktSGA1sXk8eScnPwIdqYP2MGHQUp2/+paHlNnS+TGxQSPuRXNd3CPhZXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6399
X-OriginatorOrg: intel.com



On 7/17/2025 3:28 AM, Paolo Abeni wrote:
> On 7/14/25 8:09 PM, Tony Nguyen wrote:
>> This is part two in adding RDMA support for idpf.
>> This shared pull request targets both net-next and rdma-next branches
>> and is based on tag v6.16-rc1.
>>
>> IWL reviews:
>> v3: https://lore.kernel.org/all/20250708210554.1662-1-tatyana.e.nikolova@intel.com/
>> v2: https://lore.kernel.org/all/20250612220002.1120-1-tatyana.e.nikolova@intel.com/
>> v1 (split from previous series):
>>      https://lore.kernel.org/all/20250523170435.668-1-tatyana.e.nikolova@intel.com/
>>
>> v3: https://lore.kernel.org/all/20250207194931.1569-1-tatyana.e.nikolova@intel.com/
>> RFC v2: https://lore.kernel.org/all/20240824031924.421-1-tatyana.e.nikolova@intel.com/
>> RFC: https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/
>>
>> ----------------------------------------------------------------
>> Tatyana Nikolova says:
>>
>> This idpf patch series is the second part of the staged submission for
>> introducing RDMA RoCEv2 support for the IPU E2000 line of products,
>> referred to as GEN3.
>>
>> To support RDMA GEN3 devices, the idpf driver uses common definitions
>> of the IIDC interface and implements specific device functionality in
>> iidc_rdma_idpf.h.
>>
>> The IPU model can host one or more logical network endpoints called
>> vPorts per PCI function that are flexibly associated with a physical
>> port or an internal communication port.
>>
>> Other features as it pertains to GEN3 devices include:
>> * MMIO learning
>> * RDMA capability negotiation
>> * RDMA vectors discovery between idpf and control plane
>>
>> These patches are split from the submission "Add RDMA support for Intel
>> IPU E2000 (GEN3)" [1]. The patches have been tested on a range of hosts
>> and platforms with a variety of general RDMA applications which include
>> standalone verbs (rping, perftest, etc.), storage and HPC applications.
>>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>
>> [1] https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/
>>
>> ----------------------------------------------------------------
> 
> I had some conflict while pulling; the automatic resolution looked
> correct, but could you please have a look?

It looks good to me. Thanks Paolo.

- Tony

