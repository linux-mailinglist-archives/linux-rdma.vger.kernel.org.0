Return-Path: <linux-rdma+bounces-14028-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414DBC0215B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 17:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C2C3A4B62
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6F1333725;
	Thu, 23 Oct 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hhz4WD0d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D630C368;
	Thu, 23 Oct 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232595; cv=fail; b=FjZe7Yw3wHj8CNqusxt67QJXSlDZmgLvPbaXw/UeG603fGHc059/SeBUKiQExeoghRX7LVah1wJQIzscWcdnfJij1HdxQUZ4dosrpPBhgoegvUCKxArglEKK0pT8OHPaaQBgRYlZBasAjebcrgnGVNXgySRP74e+Y4ZZFMnPz8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232595; c=relaxed/simple;
	bh=00hlsdeFJIN0ZYMBfxlvWrydW4wWeuMtMvfv3nxMdxc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HeV85d+yw9NNVDBb7pECZwqX5PbXT20HQ6PEK+QThKInzeRtdlSp2d5L9BY446WeFgSOusjidM+WpB6WU/jkzervNn7XzcyF6WUowuhW9UEYi0teMFDMqncccxkCZLRHdMuOZ66QCj4e3+4qYa1ZLMDQ5pCRwQ3maQcAUsGNO7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hhz4WD0d; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761232594; x=1792768594;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=00hlsdeFJIN0ZYMBfxlvWrydW4wWeuMtMvfv3nxMdxc=;
  b=Hhz4WD0du562t23X4V+5ARmeNcZ3FWiY9p3XeW8QKerNQzcJE9JNR2e+
   kNibhFYCM5m25yRNHoRKF7pgasXyQqGdmRuwAwGKl5GYeHm95IfiJuvKr
   6hFY/eVXrdj9hL0L+8L1n8CRKZvX90bFqWOq0BmIEhknRrT9quHrNzxx4
   JPGGltwhbV1K2XcHG4jejIWCx8TtBkErdCzjr5JbZ/HUfk5gVVC6+MlWD
   AzcV1FjRzq/+x4t/yiWgpEL12rq2ElwxJsU6rosleAoWpF2v72ksjruzx
   CC4aw87PrsLr4bgILAuf6Ex3lzw4QEr/Zu2+49b8vEVk3QupaNSZB/wZI
   Q==;
X-CSE-ConnectionGUID: VzQXNUflTs6FBV1Lq0eGKg==
X-CSE-MsgGUID: VY7cUuGUTXiLeknX8wueDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81030767"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="81030767"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 08:16:34 -0700
X-CSE-ConnectionGUID: PO6ftbNmRIy9dTwRH1mP0g==
X-CSE-MsgGUID: mNqMbZoQR+S6HC4278gIhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="184110471"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 08:16:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 08:16:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 08:16:32 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 08:16:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEfAAaoF94j0TEeYNt72xUW98cQfBjuMtSvLpFzlRCMCsd1NMtAbQPZWYMaN3xw7Cuh2JfiJHv5mndtrnvgbtTVp1G60QK5NweJ802pw/u5IjX4s0fJpTjXHNbhfkQOfHvTxH39s5LQuRiYYs9UINirUJS2w2tKxmIEBu6kiTEyxfPTIBr1x5VLoIVq4Y7aM0vvfOZPxMT9EYbEYruK0cF73j44grGX6eNTycBK9CFnt0VhXJXlvBxziSmoXZJvCL8nU/w4/VR23po4VjmURl4eWlnXnhlq4qHBUryq5cTVX2Et7aXds8spZjr36oa5UtD9rpGiVw9WvLirj452B4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ow7+ims3jEnKurAVcR+PsxlEEkOlZtm204gi4gGWr4=;
 b=bg0XKaZuSwAEWRvakKwxejcbvC28Ss9Af51gw8jX5w8MVtaohGHZLc9Gnfxi2EFOdNGzu+IYJ54UTADCLC9iSiiOkVmpW1rAmCbW6O3JGo0G74i/S84I8XdhpLe2f+frM36cWAbc8fAeCZ2yA3hTgt5Apt3Q1O+RGAxCurgAWvVhqDNTAnoWpWuF9EHOfsuub7pjf58iGl7sUKGXpXlnYY6UbleIrsd+z8MgF/17AXx+pYqojhW92xfs/8RIGXoxsOfNQPZWtX8YBE6lMqliqL82j7Tg8Ka3LkDdSuh1vGIxdCVGKKvfUGPV0XhFaohN2a+ZGvYSAEec8bqtzWMy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN0PR11MB6232.namprd11.prod.outlook.com (2603:10b6:208:3c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 15:16:24 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:16:24 +0000
Message-ID: <eea7d0ea-4aec-4f95-8a0d-e9765225fe48@intel.com>
Date: Thu, 23 Oct 2025 17:16:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dibs: Remove reset of static vars in
 dibs_init()
To: Alexandra Winter <wintera@linux.ibm.com>
CC: Julian Ruess <julianr@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
	<wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Mahanta Jambigi
	<mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
	<guwen@linux.alibaba.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20251023150636.3995476-1-wintera@linux.ibm.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251023150636.3995476-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0032.eurprd08.prod.outlook.com (2603:10a6:8::45)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN0PR11MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f82997-6e2e-458f-7f42-08de124720ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW8wV0dqMzB2eWJVRldUSzA4ejdZRFZzM3MzMm9KQTEwNW1FeWVUUE1PYWdy?=
 =?utf-8?B?azRGYS8vSDdjcW9JVmQvb3FERUdZZlJlVHdiSEZLWjZqV1k3RnU0aDhKb2dm?=
 =?utf-8?B?cXhLckdIZmxxRUN0eXBEMVR5dXNLcGE5UzRhNzdjemZGUm1COUVJZGtFUyt6?=
 =?utf-8?B?dlpNMFJrMWNZa0tld2Q3SnUxRFU3REhJdUllNnU1RzRsbUEvSWY3ekJMekFs?=
 =?utf-8?B?RWthTmh6WGliV1A4RUZxeE8rVktSNGhSMDhqbkxlMXBaa3VMOWJZb2hBZ1or?=
 =?utf-8?B?WVlnZDlvWmlKTWM0TUxORHZMMWpBNVFxbnFicDhLZDdVVFJaSlpBNCtVRExS?=
 =?utf-8?B?Z0FxTlJ5TTBwWmpZVmoxWFdpQU4rYm1Xc2F6MkR1RmpXTUlBZ2k0WVVzdUgw?=
 =?utf-8?B?U2ZVZmlnWjdxMUtuTDBwMFhJKzVkYmk1ZG0wRTdHSmRZSHNuN2QzVWtRdUU3?=
 =?utf-8?B?YmpqbGVYak5ndWpYMjB6VW0vY0lvU2ExeVNDTEFtOFQ0bGcxdm1LMnl5Y2JN?=
 =?utf-8?B?NGtPWWw4VEZCVzRHQ3I4Y2RmeGdyVCtBR3FXdytJLzZDc3JKcTYvb28vd2NF?=
 =?utf-8?B?MGNpeEtuOWg5Z3Qva0ZzSHJjUDhxRnJ6U1VET2JvVnVPamZNZzVoVDZCWXFy?=
 =?utf-8?B?T2J5WjFIUHA5YTNYMFE1UngzUWNjM3JRdzNBVkxuNXNxcGlqS2hvUExGWUtB?=
 =?utf-8?B?VDNhL0ptbDFNb1ZBaVQyeDhyRnU2TzVWNTM5V3BEUSs0VW1qMzFGTFVBVTNE?=
 =?utf-8?B?eEhKNC9zQmZuSG1CRnkwQjRhTmdBSkhKK0dyd0o1YTNvbmZrQTZzVGxGc2Zh?=
 =?utf-8?B?eUkybW92R3k4S2hZUC9IU0RvK1ZBUll5b2VDdTZJcE5mZDhHcWsyK0dDZ01q?=
 =?utf-8?B?OGQvVU1OYURPZ2kwMDM4RjgzaUlvNjd0d0srNzJ5VTJiaGVQMGl3V1U0bUZH?=
 =?utf-8?B?ajh2bFVPSkFXbW1EV2hJRTFKc1NhTzJYTE9UMFJnUXBGWTJYZ2k5TVdvVU92?=
 =?utf-8?B?dDFFMWVTbVloR3pUYjZEWWtxeHJteW90MlJTVUFoMXdpbnZMTFUvSXZ2eTNH?=
 =?utf-8?B?K3pYSXlZRXlPU0NEYTM2elFnT0dOcDVzenJhTGg5eEFzeWd3VG1FeWk0bytF?=
 =?utf-8?B?VDNIMk1rRVFDcXRWQnJVVjRVZ050UEZhbDRscW5acnNZRjQ1L2dxaHlKK20r?=
 =?utf-8?B?VHd0N0Vhb3FnMFRyR1MwamJwL2tuWHR1T2xYcEc3TXBsZFU0Y01mNGtDb0hl?=
 =?utf-8?B?NUVPSDJQUzdvTXFta0VQSDgraEltd1dXOVlBMzFwbXFadnhuNkxBcjRaY29X?=
 =?utf-8?B?WHZKeXJrNlM4TEI2V2FsZ2Flc09PNXA5cXRNWkhKQ0RCcHArZmZaTkdsbjdu?=
 =?utf-8?B?OFlXbFIxSkIxZVp2QjgyTkFIUjhmbmwyaWwxcUNLNFZ4YXhBMXlCUlZkTXlk?=
 =?utf-8?B?emN0enN3Q3BGOGJhaWh3SVE2WERhQjRlZVh1Z3VIUEdBbXYxVS9SdjQyNkpN?=
 =?utf-8?B?WUd2bWhIMHRxMTJUVmFONUZRRGNxZlNaQjUxSDRqZzNRa05pK0xpZlpDUmo4?=
 =?utf-8?B?WkIxMEpQQ24xTDRMSnNzVFBaMGx6ZUNiSUM1dXZrUXkvZzMrcWdGVTRkL1p2?=
 =?utf-8?B?SEx3Q0xudXVyQnpKWXFITHJvUGQ2RVhSNDEzK005TkVTd3J5TFNxTTlqUDJp?=
 =?utf-8?B?YU14a1VzV0s3Z3hwMi9ZMVBpSnh0ZjFNSEswV3BlSkZxeUl1N1c3ZUQyaWVY?=
 =?utf-8?B?T3VxcTluZjI5dnN2SU5NL25FdXhzdCtPR2s5amZWYVdubHI4bGR2L3B1eURY?=
 =?utf-8?B?QjhGSEdKZE8xVGpRRG9zeDMvVkdzM1ZNbW1aQVhNM2E4NlBieXpXdFlnbU1K?=
 =?utf-8?B?UGM2MHFWVG0yNzhJNzlBcEhZNDFkUHBSNW9XWk1tUE90cmVGWHRsenpScG5y?=
 =?utf-8?Q?AXYuST5ygTYc8xV24M9bFjNcULIqNZcy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NURUdFJ6OXdPNnNmKzRFUURpZ1g0b3RjMS90Z0twQ21NRm00WldtRWgzZDBj?=
 =?utf-8?B?L1g4bW9YZlFkalZCVUpMakVHcStzL2lMaUVvSnhPa2ZDMGNMcmlRTWdqSFFJ?=
 =?utf-8?B?Y0t3TkQ0S3RYYTFoUldGeVU2aDRUeC9GZG1kYy8ydWNhaXZleUtSdk5EbnBF?=
 =?utf-8?B?TUtIazZRQWlqWm8rNmVDZXl4ZVhUajEvM2YyejdtMm1Bbk1aSlRNUk02Z0Ix?=
 =?utf-8?B?REtId1FYY00xd0VkVWIxNEdMNHBkWXdpMjFlTW9QOVZ2RW1SSHNEdzdzcU1y?=
 =?utf-8?B?S1M1S1doSS85Ync0WGlpaWNCVUhoYkVRVEdHVmxGR0pCc0NNZWJOQ1JuQ1VM?=
 =?utf-8?B?c1B5aERkdUlqOU11SnlNUkpvME5BZ3lqdkhGMktjdnZrZTZ5ZVMwUGNVcEhs?=
 =?utf-8?B?NzBUVzlqU0ovb2lWS2JFaUoyWmFzZGVFYVZBUGdNMFVlWmJzSHNuSWNISmdB?=
 =?utf-8?B?aEtLNGNYRmZyT01tR3ZtT0k3Nk5WUjNpVkVTdXdBZ3N3dDkxUHoyZFg5eXdS?=
 =?utf-8?B?bHlaMXFjcVM4Y3FHblpQZlY0QVk2T002TTJoZlQ1eWY5dTJlY1FYVGNTZU9T?=
 =?utf-8?B?S3hzMk55eFhheG1YRGV1eWRtQ0Z5bzdaU0RFWHhJZURMMEJaNFUyZTBGcjVU?=
 =?utf-8?B?ajd5VnpmeElrelY3bm12SmVRclhmYWdCNTl5b21PRysvaThxUjUwVnZhdDZH?=
 =?utf-8?B?ZFRTdU83d1VuRWFhTU9iNDNaako4RW84MFBLSjlKUmgyZWQrcVBhY2FaTUxa?=
 =?utf-8?B?clZhT2lkUm41VlZkT3ZUMXpZSzVSM0RCVEtqRWpHUWVRVFVWbEVWZm11anNs?=
 =?utf-8?B?MUhUa28rMnI0VTcycUNjWFh3T2RFTW5xMlJzMitua0h5cVUrSnRHSXZwaVlj?=
 =?utf-8?B?TWRGdzFTZDlnMnpjYkpCc1BZWVFROHZyNFZZMVFSOWJrSGQ4TDJNM01aOERW?=
 =?utf-8?B?SjFYUGJTVmxDYXJyY2psNGRnRHdPS1oyb0V0NGE2dTA5RWc1MjZxdklpazlV?=
 =?utf-8?B?OW1qT0FCZmRlVGFMZWc4VUpUUmFSLy9IeXFNekZSTUdUSnRYWENJRGpKT3hD?=
 =?utf-8?B?TDY3WmkrOFpOSmdwOHM5a0xxWFd5S092cVJoUmdnb3p6QlpiWHA1TWZmTGpR?=
 =?utf-8?B?U1dyd0Q2UzlpYmhKSkM1SVVLRS8vVUdlSnZIYzJSQTF4Ry85TVpLNUdscEtv?=
 =?utf-8?B?Nk1WK0RKQ2JaazFyRGVONzlwR1ZBV05tVnFSWUd2MU91VTNaRzhYWGxNMWJo?=
 =?utf-8?B?SjZaSi9OazlEZUhvdDMvOThZc3doVnBJelJxbVpRWHVkbkM3Q0dCR21PakNp?=
 =?utf-8?B?aVo1Ym0vV1QwZXYrZ2hvNEd1WWVONzgyQWdOaEFjZUtKNms2MmxSeHFYWnVV?=
 =?utf-8?B?c3FjTm5XMllQcHcrQTZtdk8xSENqbTV2YVdOU0JGZTBmaVdGSnQ5QjUzTDU0?=
 =?utf-8?B?Sisxb0NsSGdwclRpUjQ5K0pScmUxcWFMR3ErV2FkMWFVdXN1bUVhaTBpK2FL?=
 =?utf-8?B?RkY1S3pLUDE0ZGUrTGRkQ01CUjZCcEN2WExWWWlYUTRxcHAvOHlBK1ZlNWNJ?=
 =?utf-8?B?ZXNMWXEvOFlRSjJ0dDVabk54ME9FdUhzeTVEZVQ1M1VuYXY0WmI3MHcxUW1T?=
 =?utf-8?B?Q01QeU0ycSttNlpxakZWRnFzL0RMME1ERzk5Q0VKN0M0bkVOeDVXT0Q3Q1Jt?=
 =?utf-8?B?cDF2RGJYSmIvR1F0cHh0RzU1enFTZEJjVk90eWlSVjJMaUZvVUt2VkNCRlBi?=
 =?utf-8?B?eVAvdWxmOVlOQkNEL0VaWlpGajBxcEhCZVhyd1hpYi90TXN4R0ZTZFFCSEc1?=
 =?utf-8?B?MDVUSFBPb0U2UEJOaXBBanhmM3Z6U3pmZnYzN2dpUExrL3QyeVJkelJGNFhB?=
 =?utf-8?B?T20yZE1MRXBmK0xBUGNmMkRNQ3NYQzMvb0JzaTVMN3JDb0tMYVVPcHpqdzdH?=
 =?utf-8?B?aUJqVkpKR1lMTTdENWdpejRRZGRyUERwY3dBQXJUVkFmbUI1aU4zQkxoUVhP?=
 =?utf-8?B?eGV3MWdxSkNia3RsaHZjbHh0bXZTOVFKUTg5MnYrZTVlZHdXd1g1RUxDVlE0?=
 =?utf-8?B?blE3dDBISk5rUlJUeldXY3pyQS9UQ2ptc0ZqTEtmakQ5ajBrK3FkNUM4eDIv?=
 =?utf-8?B?R0xEL0lsamdQTFE3Z01JRU4rQjg4N0ROVnZEVGc2SEdaY2FXYlh4RE9YQkxO?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f82997-6e2e-458f-7f42-08de124720ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:16:24.0048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbWNLnAgJdCM8TiN7dPcswjQcisksadnO/J5ueeIg/y9CE9FkjmtYOvl//GHgTE790rU8lJoEfLPPGz7Nf+mz+AVvHV4loBx8hh805RTatI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6232
X-OriginatorOrg: intel.com

From: Alexandra Winter <wintera@linux.ibm.com>
Date: Thu, 23 Oct 2025 17:06:35 +0200

> 'clients' and 'max_client' are static variables and therefore don't need to
> be initialized.
> 
> Reported-by: Mete Durlu <meted@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/dibs/dibs_main.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
> index 0374f8350ff7..b015578b4d2e 100644
> --- a/drivers/dibs/dibs_main.c
> +++ b/drivers/dibs/dibs_main.c
> @@ -254,9 +254,6 @@ static int __init dibs_init(void)
>  {
>  	int rc;
>  
> -	memset(clients, 0, sizeof(clients));
> -	max_client = 0;
> -
>  	dibs_class = class_create("dibs");
>  	if (IS_ERR(dibs_class))
>  		return PTR_ERR(dibs_class);

Thanks,
Olek

