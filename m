Return-Path: <linux-rdma+bounces-22123-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F9HhLNLYKmoZyAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22123-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:48:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3944F673304
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:48:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=agqrByK6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22123-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22123-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 818E030C345E
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22883546E2;
	Thu, 11 Jun 2026 15:48:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F72D593E;
	Thu, 11 Jun 2026 15:48:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192907; cv=fail; b=cdbIxSvAI3wJtonyiOJ0GVxSqtjctXEbSNYIuAqHgHvOVAGza8pbLc22D/Q67Zi5UoLGin4DspU33X26ZDssqI6oQ/4AoAQUwNTlDhPbo4Hfwai3F2EitVdG5nCuAsdZPCOYFOk4UuzksmAzBiB6h5latdV8LsxAx950rVvFAEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192907; c=relaxed/simple;
	bh=VwNEBjg27GLR9FsxNfdpOdBBL0Ca85PFJPDPcNEePSQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I40pwCAscxcvMslgdrn/HKogK24syaK2IykaZ3aEvTwmsLlVgOeA8/25ZtM0lAN9EzTI9QqTshjidFrSd+v4XRDegSUG83Is0jQVpQSpHaFnoBwrrr8MfCBjkO9sNrNqMdhw4GDpSlRn1TbCJksG+RT2dBy8O0uBtnhChMunJiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agqrByK6; arc=fail smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781192907; x=1812728907;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VwNEBjg27GLR9FsxNfdpOdBBL0Ca85PFJPDPcNEePSQ=;
  b=agqrByK6+yNIUylm323GmNbql718uXvtdxkRDy9+nyYUTQarq07CtexR
   5g/2qoWusTceZFQPh/hQa7DuMUHYWq2zrdnb+uVw6j5DbqlxRqauVlZFI
   f2KtuWtrdEgKbikMMoGa7SolJcxWZJjxQ1I7unIjDf3EhrtCCBoBpNAiN
   NnbzAJGfDA+y9Mp4S/kcr+Sb6pSMDZ/ITeXIegxIp63dIugZLmi39BDDx
   3LxLOCxJkPmp+xU1igsyT458uvkyoybQeCLPIQZJY12MAlN/+ixlkxNbE
   ndKY4q+YFkZtCyaV/OEr4rv4pg/dksqC5dw85LvylWFx7AOQs4VQTjozH
   A==;
X-CSE-ConnectionGUID: UyUctFoCTVu26ENnAk3fJw==
X-CSE-MsgGUID: Og8vLC1hQbqK1Yv808JD/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93399027"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="93399027"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 08:48:26 -0700
X-CSE-ConnectionGUID: lQtyCeLCQfS5ce3EBfcmqQ==
X-CSE-MsgGUID: OQRk3oMZR5OGVGa2I2aVTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="251608067"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 08:48:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 08:48:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 08:48:25 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 08:48:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H11q1dTQhSDR2TONqH/pAWs7y4OF+2gY2Sidx1SzF43lcZQuPz9UxPGzEjS5/TM6Hy0b7PT9roLxDtSowz5JqtUaI3ilVk4v3aLH8qvGTOZTZ/qvWHRiIA/a47aq7VszQl5b8tZ29jz1/1ehc3AmaLg0mqxgXNJeSfX6huc55B+G0LYE4ObYs2QNbEyR3gTsbqWAAc46Ga/tkgUY8MvFE3CUr7/gteqkRCgOuKHjICfOnKR30wXHyQwkNLaKbZEk/DkpRpsZ9NUmwlyzQPznsU1F4Xw6K8q5e3JdHouTcZPesUPl+xMgG2majJJEGSD+jCqg5QQRDgKLUggpN8dbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iHJfcfv5uhaEhLc+w0r+n1VzXsQn67TLvF9gsX1HJs=;
 b=wWOuBdhMWTy6gs/OAABUVw4qLmUsHLtzQXN55gXq5DTwOXcBjuA/LdKt+ynp0F+ZIML0EMWmxYYQQT2ACXb4EB9tzHS+ThWPsXtDvsNZPSaU+GPxkK/9Hi1TTRVq/AlWXR8gQK+GeupT4RQFdbSGBASUJzoD2YwcxkPDBLqmfTqbrxXw9Qu7hfPGbKrWAo3gGeK00reoYHlBty4i6SVupOp/BGx2bvt8cjMH421T5Uc4ETxw4oNnHkl58m7PbBiKrMLQiM0au9OsV+LAsnZUOONLKUD+SkJu5Fa5lLNuzM2mBELYSQAP7mI82HxU/rNHMwi2UA7v1LLCtne07xTagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 15:48:22 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 15:48:21 +0000
Message-ID: <e7ad343c-0d78-4d0c-9533-52a61afc8214@intel.com>
Date: Thu, 11 Jun 2026 17:48:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Check max_macs devlink param value against
 max capability
To: Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>
References: <20260611135230.534513-1-tariqt@nvidia.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260611135230.534513-1-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0046.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN0PR11MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: fd602768-483f-42c8-4139-08dec7d0dd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|7416014|1800799024|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JymKVW6EA3ERRhUSdNC2BsnCao5HuXrJHahpgq4ZXV751S9ZhBe+2ZY9l7XBr63vsa5oETekTe6OlUYYSJYxTLHmRwkivb1HnR3Y1egrU5WMAX/AQc2sfKl1xF9khgbwzhL/8zNOesEUAesBu6hh1Esl5iuhEd4aaT5fYzTaUeklHEs88OBOnSmpZR1e83NCGW9nHkWTX2GuDnvdBPNvVLztOipPuhmCxKkkOju8oWMBT9GyqtuPaN9a3w8CuLIaOuGtABo/+H8ZjK8qKbnmhnI1WIcIZdNvmMZmtic8FaADOEwrutbKuXbl5BkAKnSIy3QLAxp4B3iv/ka/s/NUPlkGsLxDbyIQ7WRShMzKRlQIl1xBekc153VN9kphLgFi61qJK0l9ZtIHXqUDWgbouPoYCHsfB3uXjtQ+1FfRUx0gkQJZBiA9R4t+fCFSm4W/115RnNPMD9n46ON+ZMFgZF8hbDvO2zSuJavkW/uxsPRGiiyLPMy74ySytw7fZpVvcovcTm8YfKMB5Je6fhB9xhi0eRXynDyUR+5twFSYQY6UjYvfNN1dhDChHwUawx8SOazNCqkvQXoJk8OmEQrD+4mPTegci7TOfD3r+TWyQsHW12VI83zRWlS0fWxNJBfJbPr7THQPlKBkTDRq4L5XV+gKHuK5/t1nnvYmew/iBXlBDVMfrl7Btrym0F5S/WAX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TytDajRFRFRJT0JTWW1wbytJTUJkWjVjNUE0dm5hMjBOMXVxYTloaDdmbllw?=
 =?utf-8?B?YWM4eksycmRnZTNTQ1MwZGxONjl3MmZhdWZJMlZLQWVFSzd4VUdNTmVhbkZ3?=
 =?utf-8?B?L1V0Mk5EZ0dMRytwWVFvcDExaFo1dnRPR3kxRmx6Mmo1OTMvNEtvT0grMjYx?=
 =?utf-8?B?eHZrNkhsRGxUd1hrWnV0TnUyZUJsL0pvYjNoRUVYTHo4YktTdE55M1ZpOTJ1?=
 =?utf-8?B?cEs2Rk9UbGdzczNPM3Q1WmVEWWRueWVFeFgxamM3TUl0N2c3UDI3TzFlVGdV?=
 =?utf-8?B?dkNDb0xnTkRnMXF5a3VFZTNBeXJPbFdoUTMyUVRqV0MzOFd4OURsaTlkazdy?=
 =?utf-8?B?Yi9XOStCUUQreFBmZmU4S3UxcGdmVVV3ck5SdHQzazNLbWxzaDNQcWdwSS81?=
 =?utf-8?B?TU5RVHdRakMxcU9oSVgrYlVEa1I5bmdtK0tjaWFlRVBKYlMzU3N6QlJhdTJP?=
 =?utf-8?B?RXc0L2hkUnZ3cUE4d2UxRG4zTmQxbktkNS9XdU5yZkxPem56ZlpNcytsc25i?=
 =?utf-8?B?OVp3ZlkyVmFXV29leTRhYXRRT1RHWHdsbUcvd29EWkhmRERodDlJUWRvdFFq?=
 =?utf-8?B?aW5lQ09LdW4ra0hKcmdMS0p5ZXRMYmRvTFZsV3JGdGFqbVpBMnl3TUNPQkU2?=
 =?utf-8?B?cXNhSTdybHpnWU1mQnVid3AxSHVmNTE2YWVTcnk2UUh1Z0dzNDR2QzZYL2xC?=
 =?utf-8?B?c0J2M3Z4cVFIYUF1TjJUYUJFUUF5T2Uya3pxeloveDRPWFZieU5xam1hUjVY?=
 =?utf-8?B?TnVjUVNIMmdnZzB6ZTNpY3VSVU1hYSt2Vk16T3J5aE1HZHJta2RKR0ptVkJV?=
 =?utf-8?B?b25HUkF1NUNzL2orU3lId0dvRXVxc2pYUFRhZ1pZVWFCdG85TmhYdHY0K0w3?=
 =?utf-8?B?aU1lUitldDNhcHFza3JDUkRoaDRGbGZGOXhQR0pJMmNRKzRuWlZHKzhYMllj?=
 =?utf-8?B?a2dEcUZGRytWWmdrbzJBNSt5R1JoVStTdkdMei9jNnU5d243ZmNyS202ZW1v?=
 =?utf-8?B?VjBlL25ya1N5Q0dzRU45TU5kS1BaMWpLajY0NWU4MjZ1VmZ3bW8xb1hTR3Zu?=
 =?utf-8?B?ajJIa0JOY3VJRzczRUN1ZXJWTjdEL2FuUGNPMDN5Wm1icTkvMGRIelZCemxp?=
 =?utf-8?B?ejdYYXFrZTVIaC9DYjdDMkhZRFZOUWpBWUV1YXBNTGE1ZTArYkxwYkpscWxo?=
 =?utf-8?B?YU1vZ1N1elVqdDA2Y3B3dU1kem5CQXd2U0NNN25RaGxhM0t0MERySk9tSlNZ?=
 =?utf-8?B?em1ZZ2x5Z3ZNQlZrRDBzRk5yTHIyQm1UTGx1WC9xWGxSMUk3c2w0b3BvNE9u?=
 =?utf-8?B?cGo4cG9uK2FTbGZNVlpjV21NTXVqYkwvaldQNVQzQmkvcXhRRVBkcmIvNU9B?=
 =?utf-8?B?YnFmRyt4UldHRlZ4QkpGYVk1dDZ6YUtyM0NvRnh3VnJaNm1tQ3V1ZXhWMEEx?=
 =?utf-8?B?dTZvVG5QelM3NGVUSFRPRlV0N2hpTCtZWTN0a2hwUG1QNExQWURYb1QwOXJG?=
 =?utf-8?B?WmtCWkdWSnNIRUhndkxSL2RtR0t4UERVS3dtZFRxTkdoMTNrQzNMV2o2ZzZB?=
 =?utf-8?B?V0NLWnBzVHNtRWt2UFFtU05hUVR2bU03Z0dJdytMY2MvTTFMMERvSDB6K3hO?=
 =?utf-8?B?blVrZ3JISmRxeU9yZDRoUW1PWDJqcm1wQlFwWGg1bkE5dFZaWldIZlNRVGFi?=
 =?utf-8?B?N1FFa04zSXl5aERWT3cyNHBKSmVVeFRWUVV3aXJDYytCVWRvNHltRjFHcnVN?=
 =?utf-8?B?WG9KOXlhV0I1NUVZeDVXczJ5RUE2ZytVSXc2MW9NT1BUSDhrMG40VzRrRXVI?=
 =?utf-8?B?S0tvamNzU1gwMXVNeTlyUVJ0b1o3cDN2Sk1QbjlOeDZpSTdtTW9QNU5nNm1B?=
 =?utf-8?B?VVpEQmdkMTN6SGJSU0MwUEZaSER5TVFKbGl4TkF2b3h6Q2RWOFZPWUsvRXFn?=
 =?utf-8?B?Z2crM0p1Z2RuWFV5QWZGdmhBUnNvWFhzU2xQVTQzYUFMNThxQUFidlVIeGp0?=
 =?utf-8?B?bzZ4cU5jVzRNb3F1R1hkclc4TnVuTTBVUFNGNjExTlNhM0EycHNqMVdkRnR0?=
 =?utf-8?B?b1RPeUI2MEtsc1lTVDY1ZHlDRVJXY2xHb1IxYm1SZG1va2F6SXhodzFkcUFV?=
 =?utf-8?B?Wi9IVEc5RFlaOGUySXdPcmcyblUwZmNwdElJd3poTmhIZy9KU0NkTjdaYVFp?=
 =?utf-8?B?WVNDK3FHNFE0NURUdDdhVk0wWE56RTgwcTNpTmNRM3JibnY5QTNoMFZSL28w?=
 =?utf-8?B?NWp5ZHZCamJHczQ2ZDhreEw3UityWnBxSW9TRXJRa1RDQUJWMWdRUFRmUlF3?=
 =?utf-8?B?YjBSRUF4d1RRbzNMOS9ucTRLc0dKcGIvK3BPLzk0VXcwOERLMG9UL0xmblB0?=
 =?utf-8?Q?qVjSY8wqD9qM+jnw=3D?=
X-Exchange-RoutingPolicyChecked: NW8pWGFrf7vN5whKkeZ4vKvqJqcpwEqI13f4xF1hTtncmjwlvBU/aLGf8WX5ZwOmspC8aKwF3mj9R5l2kQ5mWcyYDSw80jfh13PkP99WLK4k6OH1AK36mmC9//dBIvyVwyKnC3MGKm9J43EuVoAkNaAZ7OmU0ipYVD2nRFx55X6E6AOyP5jPXM8lOjzdIJS+ByH06ilCsCIjUrmd+fmBb0Llwd8GsJ44ur/Z9UGgw21etWR0oYFXueA2Z51WQw4lAmtWWYRbuoHtLveKmRomWMHn0gBFIHrUzhSpXJSOv9Mh3tD3wyyuYvV3RC/8bL3UXqLJG1Cp3JQScb5oXPoVPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd602768-483f-42c8-4139-08dec7d0dd47
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:48:21.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTFaTyyQfVH3m5cTf2xccKapsl/xIooS8I7CdgGTYJkSHu20pYDscgiWoouOSNwPuksURTeaaHNHVT/wjTIaz0Dqr2IOtvYBLrfoZm+ULgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22123-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:parav@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:ychemla@nvidia.com,m:cjubran@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3944F673304

From: Tariq Toukan <tariqt@nvidia.com>
Date: Thu, 11 Jun 2026 16:52:30 +0300

> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> The max_macs devlink param is checked against the FW max value only at
> param register time (driver load) and inside the validate callback
> (devlink param set). The stored DRIVERINIT value persists across FW
> resets and devlink reloads without any further checks against the max.
> 
> If the FW link type changes from Ethernet to IB and a FW reset happens,
> the MAX cap for log_max_current_uc_list will become zero, but the
> previously stored max_macs value remains and is unconditionally
> programmed into the HCA caps in handle_hca_cap(). FW will then return a
> syndrome during SET_HCA_CAP:
> 
>  mlx5_cmd_out_err:839:(pid 3831): SET_HCA_CAP(0x109) op_mod(0x0) failed,
>  status bad parameter(0x3), syndrome (0x537801), err(-22)
>  set_hca_cap:907:(pid 3831): handle_hca_cap failed
> 
> This results in a failure to register the RDMA device.
> 
> This patch skips programming log_max_current_uc_list when the MAX
> capability is 0 (in case of IB).
> 
> Fixes: 8680a60fc1fc ("net/mlx5: Let user configure max_macs generic param")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Yael Chemla <ychemla@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

