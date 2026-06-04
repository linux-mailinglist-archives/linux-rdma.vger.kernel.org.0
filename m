Return-Path: <linux-rdma+bounces-21801-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6f+nA0nRIWpCOwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21801-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 21:26:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D24642DD4
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 21:26:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ksJ3qW3u;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21801-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21801-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97B7D300C004
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 19:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E383BFAF2;
	Thu,  4 Jun 2026 19:25:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C9314D06;
	Thu,  4 Jun 2026 19:25:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601154; cv=fail; b=E8XkuUur73gwgr9aTfzI+bqevTVPSs/GNTqsPWmTuOhM8ALrU0Dd6yIaLZ/9qj0r//WJ/vlH0of6f7lXrXkPSpRtoQm44Fvx6KnjFJmdxUZfwukjoPhDi1dguIaHAB9UC2IANA3U1YHvegb1nCt3vZzb05s/rO68yzzeiTwA/h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601154; c=relaxed/simple;
	bh=pUWsG8fVbURV5bqA5JY0PjNPJNTfWPX76yvJfvz5mQE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UTlZSKtsHi7XKuMYI8WfX8RwP6c+Fk0zF9TZJ8mt5gYGGnNUF1EIJo5b1wKQ2Nix1KrU6HDcDML4lAxWfGseHPMv3SUOiVV5F1XAotjGEQV6NJrPCaB6PzsErPEoaF1gawC0Cw28v1oisoFxqKNgPjqIqELqvZ00br1EEmVCOJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksJ3qW3u; arc=fail smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780601153; x=1812137153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pUWsG8fVbURV5bqA5JY0PjNPJNTfWPX76yvJfvz5mQE=;
  b=ksJ3qW3u6ybgwC7aeYgkESAj7X+yTmM3t+GV42WMXa/dv1QkSoxzHK0t
   +cVNnXpMLIk8W7XKAZ0MiSj9wikP0ZIRzr+kUpkwXScSZY5sxWCunEuMF
   AE1tY3G+Cdgoi49Y4/jrQuHrRDcSEb6bovP0lN1DxBxq3Y8vBixomqnj+
   RDSKHiyxjMrfo/n6Fww+DhdI38LfajCk7W6J/2gRckE/XXVyCRavRdp5H
   YylkCogfyddAx4JsEmIQd2lUziAfWse3v1+pz4N+z3KYpDxeLAl10OCbs
   lGZ1WR6mliQNeFTvgFSTa5Ik3KFKZAXY8D7bfbL5A6AKxio8DlBlzFJm4
   w==;
X-CSE-ConnectionGUID: qAcawMLNRGSxdifvSfOjxg==
X-CSE-MsgGUID: 6QSOcL8lQU+rgpdum3to9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81559685"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81559685"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:25:52 -0700
X-CSE-ConnectionGUID: 4bq4pboaTdur1pDD02aVGQ==
X-CSE-MsgGUID: Q8NAqQRPSvWzNOoywP5L2Q==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:25:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 12:25:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 12:25:51 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 12:25:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lc2dBKXwx6TxE8C4/ANOwwoCKmb6NMkFNOso3T72HIp1tMunuAZsW+dCLoyrbSgXTIw/Rvszjw7E8Fcw1uWuXnPQPpbr1WLYYERQ0TXBcEHzZEN466RvqrwuaD31SSsUssGcWjl+Gx9qVAZxLjw6U0e3IqYkgrE0Dkr9OhbVIFRZx6Sz/09W9n8m0KIU7dEfr9bMHstHlr5ru0HiS5PkSt3MmwSMb3YMp70rLfrJu7sq22MZvSRsH88Kvmr+UyQl/maIyXMQQXKLOqWR34vJMnEkjvZWLYCvxHJ42dsD9Eil+YoJvKteHNLDc8Alp6lKAkYrdSHqp0XScMKNsns3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9NnDYRI/OpxI62QOsiJ1VYj6Qw14ZalX9HiCTUbJ+U=;
 b=Aeloo3f6s9gD7JxG3LoL2aczEKEVesk32Q68OLGivsEECQAD1H7WnBvIkgTCA2uNpmBWIYyKhLQ2x2hRsXxZPNsO5260ELCRMMHeUPMLHOfj0E65c0EEclf0jq4wFygm9Q38692uAKMEAJ+3iUPB7xRv9yt5wsOGEeLBsaQV8n7kFFs2vRaRwkfXe1Dh/8dcOq9h7gGBqC2eEeJy3gEo6+6u8BO/VIRcvG0Dj0xP0ruXwA+HoTvkzKx2JGQqoJ6mgVlCf/SUpRFZWnuLHu4l2fbmOjkbH3OG0vNIylE5EAeKUwAawOLSWjA8UYusFckSOh2K6n13DJqq8jUGtPTFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ0PR11MB4815.namprd11.prod.outlook.com (2603:10b6:a03:2dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 19:25:47 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 19:25:47 +0000
Message-ID: <b5b9dcc6-ada7-4387-80fa-b5ceba839634@intel.com>
Date: Thu, 4 Jun 2026 12:25:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] net/mlx5e: Fix HV VHCA stats agent registration
 race
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>, Feng Liu
	<feliu@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Simon Horman <horms@kernel.org>, Alexei Lazar
	<alazar@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Kees Cook <kees@kernel.org>, Lama Kayal
	<lkayal@nvidia.com>, Eran Ben Elisha <eranbe@mellanox.com>, Saeed Mahameed
	<saeedm@mellanox.com>, Haiyang Zhang <haiyangz@microsoft.com>, Joe Damato
	<joe@dama.to>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260604135041.455754-1-tariqt@nvidia.com>
 <20260604135041.455754-3-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260604135041.455754-3-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ0PR11MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b15eee-9de8-4770-05db-08dec26f13d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|6133799003|18002099003|3023799007|5023799004|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: Cwe5AynvPKVNS+DPzR0fubUDDk4d+9TXRqMCBH9Ck1kzJmw9yzRcaapeR/hvgFKm94LL98WxKP9KQu8GVPdSoZSTVGYdRlmDTEeL0Q7QqmXyNt4GxZNALttIdusFZdZqqiQ0QcRggiexZ434xF9Fsmuj4YpnGySDj58WdwPRttCsC+uW8JYEtZBnhel2Yt6Mx8ntCMl94D0eOZooptiTy0exQmLrN0try4O55UzRXVZQaGpBNLfZqak3q9i8YqCzEsroYZkOhSCi1gGBEgUKHPplexnZYuKRSme0lAuGv0DvhQnz0QH1MDnQGEeqrtQ4sIBF4A1jPpe/sKNvhZNoM34K7oAaSFELLLoIzvGvyP5TtndCC6YYyjn1V/aLf8PsUfwSk1YbYc2Zrgqji5aSlGmg7D857HJSaOy5hOfqd436jjvNq/ZZA5hsLsSIQeo6hO7U39Zca526tjXxmg2qpSrWlJtueFIrkTAfZTijCVEP9JEZKfG4Rme0dwHOG0IpR9i3RwgGoP2BMJ4x6XLxaiI+5Tk63gCmlfUPSb2SdwJWqlGaIYTUxXF2H4f1F9cInkhGwyU7jaPung6hGfYwONVo6dDVEuQifJeoqdXaWs7k/rxgcAmZvWVypzf945sD6A9fRNtx32IZZz1LYAqKCacXo4MpZuv1WXzFXQiNe/pValDY7y1Io2LimIvOFi4j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(6133799003)(18002099003)(3023799007)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJmSUJGaDdJK0pDQnhuQVY0K0ZHZCtKYisyM0UxWFI3Ykt6M01ocE43SGdR?=
 =?utf-8?B?bXQzVk5IaWNWN0xSbVl6M25BakpWVkZvVmYxY0g1OU1wNEVoMkF6dWp2eDMw?=
 =?utf-8?B?N0pxYVdrQTluSWdlNFNaZ1NkeS9mbFRsUmVydHhhZ1d2SFFKWWxrZFdYNlNr?=
 =?utf-8?B?WTgzdUNBQ29MWFlZZ2tmMGFQV251QUtud3Vic0ZTNEx3VTQzMEVHSFRKVVpG?=
 =?utf-8?B?V3NtNHluc2xmUFVKU3o3QlZuWXd3Rnp4TVpQR2RnTTFVQ0pUY0wyM0NmWFpT?=
 =?utf-8?B?cHF3N2toczBZTEpZYzNIS1BkZU5yUm1NN0pkWnhJQ1VITS9rZUNCV3BNMlN0?=
 =?utf-8?B?M1REMFl6SGV6MWRBbkNvSlM0cS9sMzNCNzVXbWJNamVxa3J5VTVSRjlBRG1O?=
 =?utf-8?B?NzJEWlpyczJrVnIzby9yMWhCM1NHWWc1SmUrbExRR09mc3hUTUl0M1V0disx?=
 =?utf-8?B?YzBmZHBiQnVjdVVnWGxpdDkzMWxTS0kraHVzUEg1dFhGanRwYnc5OTQwSnpG?=
 =?utf-8?B?MmszSVQybU0yaElYaUdocStUMC9VQnRnM2hEWHl0L3JwS1g0cng4UlpOWEFE?=
 =?utf-8?B?aU00YmZZOGZxWkZxYmdVWmRncktSVHVRN1g5Ym1XdTN0V0JrcHNTVFpQMnV0?=
 =?utf-8?B?WitmbG5WOHljSWtxZU83anRRVThXWVdqNFBFQTlYeUI4alpvVDIwd25SMEZk?=
 =?utf-8?B?OGtvK2xvRlFZKzlGSENlQUZReHZFNjg2bUJQb0hpWUhCK0xzdVRTSG1hRDhv?=
 =?utf-8?B?dEdNaDB5N2dLQkh4MVh5Y2J0RS8rK1EvSEsrWUlPclpwV09SRjhjSFZ4K3I3?=
 =?utf-8?B?K2xoOEhteG9BY1dqR2dHbEVQNW1aWVE1ZEFZcXlqNUVlVmZPYmxxY1NqNk12?=
 =?utf-8?B?clh0Rjd5V0FiRm9XYTJoZ2trVUJIeU1jbUN1VE5xVHBSb3A2RHR4Skc4SHFm?=
 =?utf-8?B?QzBWRFdLeWJsMkRweUllN0dRR2x0RlR6TkoreFQ2aTdKcDE5Z1JPT0tqZ3pr?=
 =?utf-8?B?SWFFUW9yaFN1eWg4S2tJWGFZRWEzNHkyWllnQ250clZIWWxSek82Nk1zUnpw?=
 =?utf-8?B?ZE5NejN5WFFyUVB2eHpVOHE0NnpGTnFnSmxtRXMrTW9IWG5SbnREMFdnY1lu?=
 =?utf-8?B?Y1FqRXRsTjl3WDRkVGhDRUsvQU9udHUzT2Zla2gyV0JvYTBneDh0WlBUaTk2?=
 =?utf-8?B?U2pjNXArYlRGWERJL0VRb09OdG1yQkxrT1BxazJrYnZQNkpOUjl6SnEzQmlV?=
 =?utf-8?B?aHRPQjdmY1l6SGl4YnRabUt3ODBranBNb3BicXJzcm83Zk1WblRmNzRyQ29l?=
 =?utf-8?B?eDY3cUJhYm02UGIvTTI3SnlEZytVYU91MWtMVnpvVzBJbVJMQlp1enBkV3Fy?=
 =?utf-8?B?cnhERlhhZ1REMERuR0Z1elhkeUZrbW11U0NPdXFzVkJSeks0NWFKc0Q2OGg1?=
 =?utf-8?B?RUdGbDI5K2NOSTkrTVhXR3BmREFFcHJpOHVla3N6OFZ4NExncWhIQkJsaStz?=
 =?utf-8?B?SGVUSS9rNDlsczFjQjhURVU2SHh0K0ZLUXlPZTJRT3lzNjBRQkFXMjVGRFpm?=
 =?utf-8?B?aGorazBnaU5hSmJva01RUXBpV2Zsc1RnZ3FSRkE0Y2VyZy9kUmo2VkYxd05V?=
 =?utf-8?B?YTZCSzB0a0taekVGNUlwNEZ5bWNwTDJiR1A1bkdtNjk4cEp2NDZyVHluY0Z0?=
 =?utf-8?B?WE0vam9TOVYvSVFGM1prT3Q2QmlTeGdKT3FDRGpPb2Nta1pJWGhxSDh6aXhK?=
 =?utf-8?B?anhzdzQ3RllUcTh2UTdrbXgvbnZDQitrcDJOWTNZU0x3L08vS0hqN0k0Y1lT?=
 =?utf-8?B?Nm9RRStWM3ovM3Z2ek5ZWUdLOERYL2MySmloZ0UraVlaaWlDN1hpdUVGRERj?=
 =?utf-8?B?ak1DZ2cvR2NqVkdKSXhySlh6NFNScTFEV05LWSs2UU0zUHRydE5mZGRFbGZD?=
 =?utf-8?B?akZadEpQRnBDaFJRV3MreVNaa0EyUFVCMjZiT2JFemwvQng4bDdPVktQUjNk?=
 =?utf-8?B?TGJJL0V3c1dad0tCTUxKa0FYSVdodE5haXFJa3pseWEzczlZbUhlODRibDBW?=
 =?utf-8?B?UXU4UTR1MVNndXJNc1lJZmY1MVJjTlN5ZDE0R29JdE5Nc3VJRThCL0JPRnRv?=
 =?utf-8?B?WmRVdjRKYkUrYzIxU081Q1hOdGpoUy9hc01wbjBTNlh1SDk5L2JYdUZFWHBF?=
 =?utf-8?B?ZjBvQThHK3ZZTHJwdmFHdWZ0VkZWSnZiVjFZM1ZWNXJ2TnZCZkdGc3JTNnl1?=
 =?utf-8?B?WEh3QkN0OG01Vmh2a0k0b3dEOFlDOWU0ODBqZm12Y2FJbWJMdzA0Q0Njc2w3?=
 =?utf-8?B?V0gxT1FrYXp2QlU2dFJ4Q29MZ01VVTZ2cC83VmpDYml2ZUNaOHdjL2orQUVy?=
 =?utf-8?Q?WvcQ57sOQ/Y5sz9I=3D?=
X-Exchange-RoutingPolicyChecked: ZvvCIa4+rgNRn1TC9XSNduPsOCjDzQde9g+4XpAKGb25go+34uRmPIrjEEerjY6E480aI2HOpBmj95XsrlTrG+wAce+Oi6gxXBAWmP6tdpJa2+6wL0n0PTv16JucGFWR+QRo1pJ7QF4ly/iJEHCS4qdjqWTBCUqWSGoxASmIJwKcFVaLpOwUGhKCfD6pjRLIpmN9S4LPhPVDs27u0uxFuPbFD5ndM8RiQbs+Fw1RLorCtBfCfXaqbKkvtCIQc3Eb9/HUZikS5eGb2U/BYLtN/vBDsw0tqDa8nasBRKFaZpUKpEJl3J6Ns+gR4xaR9PApdEcbu/x7kjPN9VIu8LzmLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b15eee-9de8-4770-05db-08dec26f13d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 19:25:46.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JGcszWPCUjrvnhK+icXFbCsDrcY2NQjfEPSYCnvt3ULndfowp3Vs4tqcrh2PExqDzq1+CXma+3r5T7ostfiPpeNGta3/9d1k7c5ulKFeSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4815
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-21801-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:cratiu@nvidia.com,m:gal@nvidia.com,m:horms@kernel.org,m:alazar@nvidia.com,m:noren@nvidia.com,m:cjubran@nvidia.com,m:kees@kernel.org,m:lkayal@nvidia.com,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:haiyangz@microsoft.com,m:joe@dama.to,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,vger.kernel.org:from_smtp,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52D24642DD4

On 6/4/2026 6:50 AM, Tariq Toukan wrote:
> From: Feng Liu <feliu@nvidia.com>
> 
> mlx5e_hv_vhca_stats_create() registers the stats agent through
> mlx5_hv_vhca_agent_create(). The helper publishes the agent in
> hv_vhca->agents[type] under agents_lock and immediately schedules an
> asynchronous control invalidation on the HV VHCA workqueue before
> returning to mlx5e.
> 
> The asynchronous invalidation invokes the control agent's invalidate
> callback, which reads the hypervisor control block and forwards the
> command to mlx5e_hv_vhca_stats_control(). That callback may either:
> 
>   - call cancel_delayed_work_sync(&priv->stats_agent.work), or
>   - call queue_delayed_work(priv->wq, &sagent->work, sagent->delay).
> 
> However, the delayed_work and priv->stats_agent.agent are only
> initialized after mlx5_hv_vhca_agent_create() returns to mlx5e:
> 
>     agent = mlx5_hv_vhca_agent_create(...);   /* publish + invalidate */
>     ...
>     priv->stats_agent.agent = agent;          /* too late */
>     INIT_DELAYED_WORK(&priv->stats_agent.work, ...); /* too late */
> 
> If the asynchronous control path runs before the two assignments
> above, it can:
> 
>   - Operate on an uninitialized delayed_work whose timer.function is
>     NULL. queue_delayed_work() calls add_timer() unconditionally, so
>     when the timer expires the timer softirq invokes a NULL function
>     pointer.
>   - Re-initialize the timer later through INIT_DELAYED_WORK() while
>     the timer is already enqueued in the timer wheel, corrupting the
>     hlist (entry.pprev cleared while the previous bucket node still
>     points at this entry).
>   - When the worker eventually runs, mlx5e_hv_vhca_stats_work() reads
>     sagent->agent (NULL) and dereferences it inside
>     mlx5_hv_vhca_agent_write().
> 
> Fix this by:
> 
>   - Initializing priv->stats_agent.work before invoking
>     mlx5_hv_vhca_agent_create(), so the work is always in a valid
>     state when the control callback observes it.
>   - Adding a struct mlx5_hv_vhca_agent **ctx_update out-parameter
>     to mlx5_hv_vhca_agent_create(). The helper writes the agent
>     pointer to *ctx_update before publishing into hv_vhca->agents[]
>     and triggering the agents_update flow, so any callback
>     subsequently invoked from that flow already sees a valid
>     priv->stats_agent.agent. This avoids having the control
>     callback participate in agent initialization.
> 
> While at it, clear priv->stats_agent.{agent,buf} after teardown and
> on the agent_create() failure path. Without this, an enable/disable
> cycle hitting an early-return in create can lead to a UAF or
> double-destroy of stale pointers from the previous cycle.
> 
> Fixes: cef35af34d6d ("net/mlx5e: Add mlx5e HV VHCA stats agent")
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

