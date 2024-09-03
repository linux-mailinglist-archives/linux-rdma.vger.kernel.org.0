Return-Path: <linux-rdma+bounces-4725-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AED969D42
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 14:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8351B231F1
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312943AD2;
	Tue,  3 Sep 2024 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYc0Tc2W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354861B12DE;
	Tue,  3 Sep 2024 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365768; cv=fail; b=D/5IiCC9QjcEuAssiqROUNXxBgkCs0oCfCAPN3OYhUqrGbadJBEb6UiQL9VrvEz4HQee2cJ2cQvjKzpy4AAw67pznu06hSznqSeRDhjtYAeeAHDwlwTvMfEEa0+mxhGbxr+IwbX/F8qZyA4B3MRYMwvicgyStVZqi8wQjhyD0ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365768; c=relaxed/simple;
	bh=niqTS2G8ZqhdbqVFcVRqD2zu7gqdw2jXOB4yJQ5poOY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fn41xUyABsDGu/qIXm+bYTZOyD/hBHYUauxh8Hr+G3pkNC4uaXcsiRwIOkCOr80gBxX5tx44FzwFfWgs9p8hcuIIM2dB3POvYrJcK4nImy/XjnpfBIgW/V22K5Su3vU/EzAoyqFccnfu432fJNKEJpoz/4SKkphvergtJLJfjnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYc0Tc2W; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725365766; x=1756901766;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=niqTS2G8ZqhdbqVFcVRqD2zu7gqdw2jXOB4yJQ5poOY=;
  b=BYc0Tc2Wck9CABt6fM/MqbV6r/Qv9FPtQJAq27qFkjoRVoxyrZ3ZG9Qu
   YgpAQIShTo+G/X9WHD49szrZZHZy+zvHgHt2hcX+hQfXmDqG3qJTFOcyE
   6jyz2j/Qr0vwsZpnBJPLBQ/ru+IzPyguX1NVm3a/zh2Ve2HJQ+kk6MXmC
   em77g6IeyLCPpRAhJ8/uYfbapkEF2Cqo7JnUQE0EF2gxp0xu6XS8lTHdD
   PgkGU1lPja6/DP4w2/B5mM2TFtYh/e1mqm9IsEvNiVL5ODxNyIEGitmkq
   QMmXuELAC3bIdtaa6ZimiHLicnZg2DVgmrhaaMc5vL6j/aXjlHMT6fukA
   A==;
X-CSE-ConnectionGUID: uPs7X3VjSJ6wMN17uzWgxw==
X-CSE-MsgGUID: kNAfkQXSTJiZU+vDH5Sgtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35351634"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="35351634"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 05:16:05 -0700
X-CSE-ConnectionGUID: iq/P6bUOT42Mw5PKA64KFw==
X-CSE-MsgGUID: BQCkAwWQTeKZi0s9snDN5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="95618744"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 05:16:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 05:16:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 05:16:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 05:16:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRYbtpMF7ZNsL9CSSkADphvcKqL9Ddk4t2sT3y0x8nMNocaTeacgyR7XaeSG5n1tIIu1wjNynbxJ8aH/hl7B1deu1EUilJ+YVU7EV3br7i9NZVfdpJJZzmfN/2ZQDjL0mZwvHgSfI6DSAt2UsQ+ZWoyKUYpnsbSIupn3evlm0Ij0fbdtwv5K/oXf57Pfnq3GyQ1a2bkNopx7rLa81Cm2OxMF2y5JhWGCn0iVcOjRjgsN4UdM/XDBIn/xGaIQuLOYxpq9qU8a/mKy9LOMP7E5Vi09PRAPgBmC/cmYKjDUSrIbeQpA7mQ74tGoz0aIQPE4+Z/0ieBegv8fo6aVgRgh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0mttzLGxdulMbDAcelG3XfguEmQGAcBtyDQQHJys30=;
 b=cQ0wz90QkXwR+jTpfCHlon4vPzpLp3wp9dawCs0mmMHQ45Klcn5tIrjli7xcFDE+37EOFaJs663P6QpT17Qdict6T3vJfRhFs0Um50AnggQQg/a4zpPZAh95fBNP88OaLNnDK9ZdC+1HZWggrYkKmUW8/hNSspoVHqlT+zcm8dDDGeAShz3cOTkmah4vL5cMPM/CmeUuAdSwx3ZXrAmzlTxagKRh1MKvRSfgQ80Oojt18ikMp+YruAlTH372zUK5wBD53ZVX927d1xDN1qKCG4+uI5PbH/rJZck5hCVMyQh9wq8o45+PrzmjFz6LuzBTzjcLMPys6yvQfbCwXRT47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH0PR11MB5314.namprd11.prod.outlook.com (2603:10b6:610:bd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 12:16:01 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Tue, 3 Sep 2024
 12:16:01 +0000
Message-ID: <519a5d22-9e0c-43eb-9710-9ccd6c78bfe3@intel.com>
Date: Tue, 3 Sep 2024 14:14:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] net/mlx5: Added cond_resched() to crdump
 collection
To: Mohamed Khalfella <mkhalfella@purestorage.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<yzhong@purestorage.com>, Tariq Toukan <tariqt@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
 <20240829213856.77619-2-mkhalfella@purestorage.com>
 <cbec42b2-6b9f-4957-8f71-46b42df1b35c@intel.com> <ZtII7_XLo2i1aZcj@ceto>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZtII7_XLo2i1aZcj@ceto>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0002.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH0PR11MB5314:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c827d61-e78d-45ac-0515-08dccc122cc5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFFtWHh6YUNaZkU2bitZSElybDY2M28rWUkwS2ZxQkV4S2REL003RTN3SE8r?=
 =?utf-8?B?OW5wT3QxZnhLZ0JCcTNWSXB4aFNqQ0NIZW5zMEQwaXZQZDBvL0MyWktRN3JI?=
 =?utf-8?B?cVl6TUhMeXFaZy9CQWd3blV3bEV5clJDRk5MUkJqTC8rS2NXYXE3dlNueUtO?=
 =?utf-8?B?TEdVZzRYYTdFMXVVL1I1ZXN6Y2FBWHB1dlRUeVdSN3Fabm1Ma0RBRHdjb2E1?=
 =?utf-8?B?UWNtUzQzQ011VlFRcEpTdEU3N3hFdkYyejRzUGZMY2xtNUFFZmgrdkZCSWNw?=
 =?utf-8?B?N0Z0RjlWd3pXMUQxZHJVWEd0T1FpbVRMdGY2ektBaWdmTFZqdjlNSlptRnNt?=
 =?utf-8?B?NExqUEpBQ1lDVDEzQVJoOVB4VmRmbFliaTlDY3lQaW1temdnZWZrbEF0UW9x?=
 =?utf-8?B?WEV6d1ZwVHFhcFpoVStuVkw1V2g0N2JWWnBKNjdjQXVTbDluK3o3cUZHby9U?=
 =?utf-8?B?Yi9oOTFrMVZVbmFMUjN4ZW9ueG9kaGFKUFcyT0VhY3JJelRpWkFPSHk3UVBP?=
 =?utf-8?B?cGFySENwbG9JRFJqMERDejdkK2lDdTRtRENVckZVc0VtMXRzMld0NWJyeVh4?=
 =?utf-8?B?RDZYRlN0TWFCcktTYUF6dkJIaDdhYVZGZGMycWRsL2JEeTVWOVhndk5QMDQr?=
 =?utf-8?B?eGhnYzQrWG84VUIrQmZaVGVvS1Vsa0tZdUlsSW1sdll3M3BJcDZNd2l2U25I?=
 =?utf-8?B?T0lQeHV2Q1FKRDc4ZEtCTVZrTjdPbkpqU0RIS0FPR1ZCOTN4K2dZMC81QkpB?=
 =?utf-8?B?c0xDU1BwcE9wd2tKU3FObmp5amw5QXR0TmhnajRlSWVNL0FUVm84OFltbzFI?=
 =?utf-8?B?ZUwwQzk5cDBIQUdselNiNTBOV1pzRjhOTXVUZnBITURsSzR5NGZYNjFTRUZ1?=
 =?utf-8?B?cU9oc3RKY2pTQ3dyVW9mM1UydlFQSTdBaVNkZFVFSzRXcWtzN2k2VUJYaUU3?=
 =?utf-8?B?MVJ3NXdEdEhlR2pyRVhRRjZSajhuQjN3MHhpeEpTNDVueWFHb0tyYWwxVEYw?=
 =?utf-8?B?WDd0M1hpeUhQMnhWVU1VMHhmQy91RDlJWGd6M1p1RzlkaGduZVNJZ3A1OG9h?=
 =?utf-8?B?czE4K05qVk1YOXN1MGQ1cThYeGIyeGIvMTg5bVZPYyt1M3AvQ3pWU2ZPLys4?=
 =?utf-8?B?a002VUdhRmpuZzBjK1NPYzl5K1VNclFMYVpXZno2bm9ZM2MxdnZhT21MejRn?=
 =?utf-8?B?M2RXNkx2UWkwdnp3K3NyblA1U1ZsZXZhNTJWK3ZFQS8zKzVTb292eFZheldp?=
 =?utf-8?B?UFB4Um5QVEVOR2J4cVEycWhOVFVZeTFZNld1R24wdXFLcFZyT2FLZ1R2U0lZ?=
 =?utf-8?B?eXZFVjJPaUN0WkE2Mk83WVFzM213WVNLZ0ZlZDJmV2ZQd2V3WkVtWW5uWXVD?=
 =?utf-8?B?alo2U1lod0wxWmt1clhNSEcyMnU4M3lhT0ZzTWVGUHRUN0tzMGF6REoyZm54?=
 =?utf-8?B?allVbGhWeGsxQmh0Y3RQNXlHT1h3eWxGL3BxaFhtbE1EYkhRbkRQbE81eGRH?=
 =?utf-8?B?THI0UG9CVi9TVVRuaEhldlE3OFE2SkwyN1FOQnEzd25LS3VLZDVVMURUZzI4?=
 =?utf-8?B?U3NWYVFBZXNyQUNMZ0VYcW93MWMvVUNaQUNlRmRZWVhKSUROUEJDNm05cWZ3?=
 =?utf-8?B?Vmh6MDRsT1Y4clpmRDBUQmFsRkhPRkJlK1B2N2NLVVlvUXlnYnBLMXFHQm9q?=
 =?utf-8?B?TFMrUEgzZEtzQVBpZlIxQzRrdnNDMmgyaUtzUStUTDhTOFRaSHVQUDlKK2tI?=
 =?utf-8?B?YWx0bGVocE1IWHN5R05relZoWHErUDg3ajE0cGVJbTZhZXZ6aElHVW80L3RK?=
 =?utf-8?B?Q1I2V2FzWXhuMGNoZ0o1QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHJocWdtbXlTeWZkeDN4VEZ3bmxHdUxIRG54amd2MlBBTmM2Y0NxODRTenVI?=
 =?utf-8?B?eFY2ZmNyM1dERVh3N3l5cnZ1VzVWeUVoa25rKy9HeG9oUVBEbTFGeFM0ZTRN?=
 =?utf-8?B?TlEva3VUOGdZOGp5MjdDbnBMM1o1N1Nna3pWTkVBU2cwMnZ6dnBGYzlHanI5?=
 =?utf-8?B?dm43UGtOU3FFMjNqTnVOVUhSRWt6VE51UmI3cnJWZGRKVE1xWXpCbWFzQ0ds?=
 =?utf-8?B?YXFXdXZlTXlpTFFUQU56R2h3WG9mOXVscWc1OER1Q0tDWmxaQWc1QUNLb3lk?=
 =?utf-8?B?Sk53VXVoZWErRUpDRThkMTA4SUhxV1RkNXQzSFE0TU1jUUtoS1RsV2UrSCtB?=
 =?utf-8?B?M3RPOXdzc2J0WmJmUkYvb2pGL2ZvY0oybHhHS1p4VEdXQnltNENNZVVOYURT?=
 =?utf-8?B?WkozaTkrWSt2cDlENFJZQUQ5dy9RVTZmalBiaHhTRW13dThlbHpTSEZISVdH?=
 =?utf-8?B?cFdPRVVqbnIvWGZVOW9oY3VSZzY4NmtObG02L09zZVdXTUdtSFZCTEV2eVZI?=
 =?utf-8?B?a3dWWThyRC9rQlBwdjFxeXdicmlsQ3dGam1hUWd3K25RMWx6Y1lrUTkzNTFx?=
 =?utf-8?B?d2lnVS9IMWtmcm40YklBQWRkRGlOL3VLWGt4Z0xwVG9WZDUyNWxCYmllT3Rk?=
 =?utf-8?B?dkgxN2Q1dUw4LzdzdHV4REg0UUlMbmJvWkFOSnNIaFNvTVFLWjFJZzVCZ1kv?=
 =?utf-8?B?LzVSUHgva1hrYmlhVzYzS2RXQm1IbEZ2QXA4Nk1peis3QTdON051QUpBZVZK?=
 =?utf-8?B?V1p5OStodzlxMG9CZDJpSHcvKzZxSS9Dc3ZuRGMrLy9jVWF5ejFLbUlHMFoy?=
 =?utf-8?B?eXZ2Q2poWlg0MFdXeGN4UDhERVRWUXlSQldBV2VLWXE1NERrSm4zdTFucTlK?=
 =?utf-8?B?M3Arb01YRWtwaHdpakt6c3RNVldic0dSVXBxOXpuWU43ai9DRXZIM0pybXY5?=
 =?utf-8?B?SmFjVkhGTVdqbEdpcHdUdlB1Z3IyNEowbE9qRmtsbGJYc1NXMGFmQ3N6VHgr?=
 =?utf-8?B?VnU0NEc1MnM4dWJ1QWFESk1CZUltOXpJRWNWWlR1MWJDWlU3UVJndG9xc0Vk?=
 =?utf-8?B?Z0ozMmtiL1NrWmdPZS9SMmxCdHBMakdaK0xRa2E0WkNFcVhCaUV6UERod1dj?=
 =?utf-8?B?Vi9tczNiMFNZOG5sUFFxbGFZTmxQSkZYb0x3NmVxdmtrZGd2RkxQMGdoTDFh?=
 =?utf-8?B?aTdNbXBUeVA2Qk5jUEtTNVY4Rm1TSWtDVlcvQml1eTBUdm5XY2RMbkRxU2Y4?=
 =?utf-8?B?L0JFUm1GejJjVVJWaUhaL2pUTEpsQWZ6T0RRU3prMjZBeTIwT0VGb29DR2pw?=
 =?utf-8?B?S2FJY0RKSnUwcXo1d2oyT0paYzg4U3A5TEJ6d3U0cDNGOVdKZVNtWEE5OVFE?=
 =?utf-8?B?M3IzNHZEVnhXR1ZXaThPVk5STitxVEZFRzdoaFB0blRUZXdrZnQ2T2p1Ymkr?=
 =?utf-8?B?ZGc0YTg2bWFxUFRMdUNGRjNQNU1XRlIyUmtQTnZTWC93dUlXNk53Nm90QUJC?=
 =?utf-8?B?Wm0zM0MzOXFVU2VLUmVHNWFyZ1d6OTNWSHpKczlXYVBUOTJMRUFJdUl5OEpk?=
 =?utf-8?B?WS9zdkl3ZHpYNnZmdjVBZ0poU3pTY0ZBMU52THBuTmlINVhRSTZwWkdBRWg3?=
 =?utf-8?B?a0R0aGxFVlJmQUJVcGNwU3MzZDdJTDFMYldPR3ZpRUpBR0xUUmx5NExMaHNG?=
 =?utf-8?B?d0t3WHAxRTdRUm9mVnZ1RThzbTlXVlRONTF4NXhyR3FnVzlXenFRODlBSzhT?=
 =?utf-8?B?Y2J2RHc2aE9LL2ltNkVoS0lCM3ZLQzA3VWtQUEtyMmVUYzVrTlNKVlRTakRo?=
 =?utf-8?B?M0JjYTZUcnkwM1VNUmEzRjJvSmZCWXBkZHBMMFNhZXRpT0hrZFhjTlk5Zm54?=
 =?utf-8?B?bE5DOXJEUFJhdmd0Z0M2dVVEQnUwNHhwNUZjSSt1bWhVTCt0cDhLRzVSSGxv?=
 =?utf-8?B?R1BWVzRsdXFSbUFDQVdmZXhzT0J0Q08wSG1JNWV2eUtnblQzY0tVcE1SdDVr?=
 =?utf-8?B?SWNRN1lyTHJjRkV5SU1oWXV2dEp5SFdvMExISEZaMms4RTd0MkYyd2JKeHpq?=
 =?utf-8?B?TFJ0OEh0eWFpa1h0VHZqV1Fyb01sUnB1Z2ZvaUlXdnQyRE0yMU1sSUJCaENU?=
 =?utf-8?B?OGsvZXFRRXdMNFN0bVNTTTJ5ZXVtWElzV0UwQnJRVXFKbmJOS01pNUE1aEZN?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c827d61-e78d-45ac-0515-08dccc122cc5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 12:16:01.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nf3fJfcFpkOo8Bg7sb5VJGQ3uOchNZzktU7wifQ5c6ch3wnZmEs3w3rs0rwMp/c7MPi69xHJGsDjZabGBKXGg6WFWEePqP9gDFk9qBr+JnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5314
X-OriginatorOrg: intel.com

From: Mohamed Khalfella <mkhalfella@purestorage.com>
Date: Fri, 30 Aug 2024 11:01:19 -0700

> On 2024-08-30 15:07:45 +0200, Alexander Lobakin wrote:
>> From: Mohamed Khalfella <mkhalfella@purestorage.com>
>> Date: Thu, 29 Aug 2024 15:38:56 -0600
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
>>> index 6b774e0c2766..bc6c38a68702 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
>>> @@ -269,6 +269,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
>>>  {
>>>  	unsigned int next_read_addr = 0;
>>>  	unsigned int read_addr = 0;
>>> +	unsigned int count = 0;
>>>  
>>>  	while (read_addr < length) {
>>>  		if (mlx5_vsc_gw_read_fast(dev, read_addr, &next_read_addr,
>>> @@ -276,6 +277,9 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
>>>  			return read_addr;
>>>  
>>>  		read_addr = next_read_addr;
>>> +		/* Yield the cpu every 128 register read */
>>> +		if ((++count & 0x7f) == 0)
>>> +			cond_resched();
>>
>> Why & 0x7f, could it be written more clearly?
>>
>> 		if (++count == 128) {
>> 			cond_resched();
>> 			count = 0;
>> 		}
>>
>> Also, I'd make this open-coded value a #define somewhere at the
>> beginning of the file with a comment with a short explanation.

This is still valid.

> 
> What you are suggesting should work also. I copied the style from
> mlx5_vsc_wait_on_flag() to keep the code consistent. The comment above
> the line should make it clear.

I just don't see a reason to make the code less readable.

> 
>>
>> BTW, why 128? Not 64, not 256 etc? You just picked it, I don't see any
>> explanation in the commitmsg or here in the code why exactly 128. Have
>> you tried different values?
> 
> This mostly subjective. For the numbers I saw in the lab, this will
> release the cpu after ~4.51ms. If crdump takes ~5s, the code should
> release the cpu after ~18.0ms. These numbers look reasonable to me.

So just mention in the commit message that you tried different values
and 128 gave you the best results.

Thanks,
Olek

