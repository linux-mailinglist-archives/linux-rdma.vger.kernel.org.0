Return-Path: <linux-rdma+bounces-14593-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FFFC681C4
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 09:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA3CA34DC42
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D06305E0C;
	Tue, 18 Nov 2025 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJhko107"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59980302153;
	Tue, 18 Nov 2025 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763452732; cv=fail; b=aWFyCv7pI9TgXyfpWu+OXUmzcg9FkNCIZ0tQJYaXIEaY9XY7YGzkffkY6JM1F4Am+UZvst5jTOiAlbIp+dcz0L2mOyA0gRKZjpFJdSV5hJGbSu//6oiswwEHs+qBBl68w0c/wErgM2YQ3gHb45tpAVkgWTAAxaJTY+aC4aFVJ5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763452732; c=relaxed/simple;
	bh=sf/Tpoac8/QDWalRFFNLOuhSQUtLuZv9R82FnK7Iqr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gvp2vUiV8bDUeLdhGeGHNWzDqLQsZyE+vjlNOFUafXnUm5RiJczJPRFl28DDhZRuJES4hHJzDmUvVIYXEQIX3TYAsuGX37rwj4N6dmSPN/RVEAgOXz215mIljjpHiC5vby1xiGDfk1yRbPptIIe704yNNiikH6IhJH+V1iPs6oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJhko107; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763452730; x=1794988730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sf/Tpoac8/QDWalRFFNLOuhSQUtLuZv9R82FnK7Iqr8=;
  b=eJhko107PPGp/Nsbl/AgofgrT71tQco3DYX7+CrBE/GXtRdvMfCcKEsA
   odsMp2Ojnr8KzOaUnwDXNGDCR749opJ8MX9Vsczq2KR7lqFdXgmEscFOX
   HoTee0WoqqkD8CXD+l6nlntaDJJsHiol6x6CyDC71hR/0wFvUR6kNGeNE
   D7v20OP0SDSuSwxrpM9QwA9yR4MzXwP/NhJFV+Wwz06WhNzjXlCTQovAQ
   a5yyZ0MRhVnjrZ8FrGrpIy3kWDXIbw75WbKqEwhpj5Co0uG1n7oBO3pcc
   q1XkwKz4BKdDXS5DDh7/ByIzad73THdoQU9xlo/ZgmdWx3NOazxEBs+Zb
   Q==;
X-CSE-ConnectionGUID: Qxzmza7HT2iymmFqYoBd0A==
X-CSE-MsgGUID: 9UFDKBvNRsyLa5l6ZLfzNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="75785501"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="75785501"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 23:17:46 -0800
X-CSE-ConnectionGUID: BbUrWAKTRsSlQnqXhwVbZg==
X-CSE-MsgGUID: piAZ0evDRrWB60gtUGFG8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190843170"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 23:17:46 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 23:17:45 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 23:17:45 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 23:17:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPpMl6DHSP0ZPImiJm5iSebQZDPdT0N/nUWOn3ABQoqc+qvw1A6AhvnxWKw7af4508ne6EKRoSBhbkptFc9dCN8YyLMbtnzj/YT4VmZvR2CzeyA85Vew1bP9ofs2mIIRAP2NcZkw0LPQ8MyHl3ThqjxzIqLJ06oouhmxotUzO3dh5I+eDaRHZciZBiYF4gVC9OwyAE3fD5rlDSPsLtii4jfz5x7KSN/StKl0mmIWtNod+18gjCJ/2bo7aeLgI0sliGlAY2EeplNUfd/20jGycNdybfxNJpjW+LTrtetRJ7ZH2506Myu5ScdGm2z83FwggVWlai9QFXGfdN96pONJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w8fsPqF+ZqJLMn0hJKIZv2uYvgG5juKeqU8xystr6c=;
 b=RKAcA2bxw2Ax+sJNfhEOTO7Y6RTON7pvFcDETnSaD5JU4QQqNSdNM1ZO/1sV7CctS+kWz/cVM0a9kOlG95kGCU5sVAQM+7iSIxcNX60wFtETGUJa3ArN3vN0j0jycyeHw30vA4Nc7qsOWrAZAo0RXInlh70X7qHk2wjOjGC9KE27M7qhUQP9vua7D8QoZ6vatD1Uik2qVtjBnOgrQGBrCS8NYKYCEzqMTGKRlTJCCW+92RTovi+JrntiZ7oZTHzU1DkBG4TTLZ7hZKCpyHMZRbVKgXwpQoXYpprGAXPTzdz/xbHDpZPGiahEfst5KfKJsMxMcxz8eaxLrbo+2qb5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB8246.namprd11.prod.outlook.com (2603:10b6:208:445::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 07:17:42 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 07:17:42 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Srujana Challa
	<schalla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Brett Creeley <brett.creeley@amd.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Goutham, Sunil Kovvuri"
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Tariq Toukan
	<tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
	<manishc@marvell.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Loic Poulain
	<loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean
	<olteanv@gmail.com>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"Ertman, David M" <david.m.ertman@intel.com>, Vlad Dumitrescu
	<vdumitrescu@nvidia.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, Alexander Sverdlin
	<alexander.sverdlin@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v4 1/6] devlink: pass extack through to
 devlink_param::get()
Thread-Topic: [PATCH net-next v4 1/6] devlink: pass extack through to
 devlink_param::get()
Thread-Index: AQHcWCHFkPPKsRsPUUeR/1TMj5i2d7T4BnHQ
Date: Tue, 18 Nov 2025 07:17:41 +0000
Message-ID: <IA3PR11MB8986A51FD457CD040F2D73FDE5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251118002433.332272-1-daniel.zahka@gmail.com>
 <20251118002433.332272-2-daniel.zahka@gmail.com>
In-Reply-To: <20251118002433.332272-2-daniel.zahka@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB8246:EE_
x-ms-office365-filtering-correlation-id: 080d348d-7c2e-4044-89e2-08de26729026
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?987oVIUUgIy7ZeQ5GX6DbyW0lfyG490NrtNMbhXUW17An4Lm2sCHvMPSGI7z?=
 =?us-ascii?Q?pKl3PRQgRbfOVS9Wle7h0dBnaieWphDqVoA2aisXjr1RWRqMq+emIpJRcZUM?=
 =?us-ascii?Q?lUdRdwBUEiBCUGpU1/Gf/TS9jq3HNO+IRPI51DoP3a3X1bFK5vPNSH6gw9N0?=
 =?us-ascii?Q?a6RbM+75dj6pAp5NoF9uKo9Ha/lwHH1fbKN9OIt5nKbyO/EqcqCTY+hIKKGq?=
 =?us-ascii?Q?y47vaaCgjGJj4de9JvB+TV6mx2EEzl3T1TvgoLPOH+rRXhxuBo0XO0+1Yerk?=
 =?us-ascii?Q?VTLY6aE8ZBpM+MLPuIF+csXzgtObADwTdm4G0l+ztPOZ9u2p39GRVbTriJmU?=
 =?us-ascii?Q?C5eM8seNrn7qbvnDMmWQCzKGjzzFlh3wnP9R09ii+fSefy0B7a5LpY+u/1MM?=
 =?us-ascii?Q?ERfrUkk6m/YAhJdVJEg/+DrHarXZZ1a/NtzGcpupvRV6BF3Ik3H+CYUu1NPi?=
 =?us-ascii?Q?hyb/GB5yGJtdCRh/w19w8KGiboJ3/JPXGtehYQbl97+qjiF3rRTgbqUQvWRa?=
 =?us-ascii?Q?epOMcNhRRTKgewm5odIpB5QoFj3T/pz5IdnOdLbz+Y2WbqhRHhGA7EP+dDah?=
 =?us-ascii?Q?XvMqChyyRvDFwvvVTaq+sqI5SnlCes0R5ikMDVwN5ZQ4FyRjZM3ZZxV3ter3?=
 =?us-ascii?Q?ZldtLGoSmMfJ60/zk4ZQpAZuRt5mbdz3jQ/74eKfFJH/IbX0AHkaBFhDPrDw?=
 =?us-ascii?Q?BYcUUNbWFA1e40e6YYH2RjZ8CR84v/l94yz7Gu6mDmrphrRU1Gayn4RBBhyF?=
 =?us-ascii?Q?yoBbd/kr14phMQtrCqOsT77OxKmp2TZvHI0P4mZpcc1NslEgb6MhTLy/YOwB?=
 =?us-ascii?Q?cFCKI9Z0RX+qTiTKSbV84Sj5FYDXcB0JPhFOUZRnZkZ67R58nMeKRkFMc287?=
 =?us-ascii?Q?d3kDYZD8tmM+B/m/9yFmcNOBoXy+QQSlFScoHZFPEBpPzSEbO0PaM3GsmlcW?=
 =?us-ascii?Q?bnTus2QGPwGA/ku7c3kQZzEwagg4fwScpD2POEPzYck7oRSFYRW6FKefW6zB?=
 =?us-ascii?Q?cUJSHf263Fs30Kx2hhL8hRiN62pcNo0IgnzwOP/XofRPSThDUOgXkH5lji5u?=
 =?us-ascii?Q?vSwUJoZ7gWhBXcPACXmYD0m6VKXS8ZrUfUOYI9D6WxyW5swX6tRhn1dSFV+L?=
 =?us-ascii?Q?PodMOFp89nOy7PIPIkgJ4vF1jSsUa7R9MzEfIEyLHmwkIwIpqh+GgrEtvLT6?=
 =?us-ascii?Q?pwbpEO5IxkC2QkLDFcgZmV/lhy3GgMK86mbZlKlY1YhZESmerKTx2HQ08hPd?=
 =?us-ascii?Q?tmpg9qBQnH91TlXxOPT8dH5tZ69H4geIVstmr86/6L0j6JQ9mJUpgTPhU2KD?=
 =?us-ascii?Q?0Cx/eCs+eZx822rgYd8X566zw+9vPrF8tcuczxKa5+MfuskXWpY5IHeKBWSD?=
 =?us-ascii?Q?ptT3hiItz44ecb4iBp6/AxuVp1qeQX8Z3JMQXuNvUCdmhlmvrDYZOOVb43tT?=
 =?us-ascii?Q?atEtg7BM/H/m46U8pVjv2ugVvVm/8DitFxetO9JTQdtYghzUXXUmxV3c+utD?=
 =?us-ascii?Q?rUD/yPaWBwnrJ4WpPChirbUSmNvT2u2JYxlAxv6sMp6eWqo5pfdx5Avaow?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xoFZOFV3RCvLQc2VM2I5KMcM/9WLgLypaYybn6bb12gv2hAJzWKQ8GFP2GTH?=
 =?us-ascii?Q?Tmdf7qCI52UpNP8I19maElr06bsb2lDdjpeLUQhp1ktoCtsnHSYYJ8UwGlZi?=
 =?us-ascii?Q?2gA+Rr5HV8u8mok1YeVrAa9NsYsOo0eOa2x9wZquv/U6I1Wxqz9PagTDPtbk?=
 =?us-ascii?Q?skvBMTUWWL0wh2EJgfx8aH14o1BBUSHW5TGwbYpcw0LxG6qbcImPK9F5FtAN?=
 =?us-ascii?Q?a9rXwvTuX1RDZyX2XLi2gIf3gh6y53+gvbqh3BfOAiD3r8m+/W2zTbEmh9l3?=
 =?us-ascii?Q?uMPA1FgwOPTcK/7kELQRK/XzFqJNFPXl3/LzF/YwcUE5lUtv4belyix3Sazn?=
 =?us-ascii?Q?JLdwl3JNdmyNPvBd/cdDTAk+rShJ49h0ABotPxDOdNZO+lJ1/lmNgk8+Q2hl?=
 =?us-ascii?Q?AoqD8JhsJ6GFMITOjJvVzEgXsEWcndHOEhgOq1IPAlgqqJrNEAgc5RZwwF8c?=
 =?us-ascii?Q?AIf+6Y8+aUZy6eINgXtE/0xFHwkzAH3tqZEkvusKnLGx4/gYWTSKkplVGhQu?=
 =?us-ascii?Q?Tx+6BYEh9VjNQI52xhNtDgV1zY941gO2qGAZv+TDf6EL/S7gg4D24YVo80T8?=
 =?us-ascii?Q?Rqlm/58UpFegyPM9lIo+0632JQHWAWBLap5ZXQTpUh3H17KY3p7v7lIaH2Gv?=
 =?us-ascii?Q?rOCeIHeFdcmOq1GpwlKw+3PMT5OrnmfrD5sOs87lPN4qBIeYxK1FVhbEM62B?=
 =?us-ascii?Q?VqJL7nkUOPpRuSC47UHXtJXAmeU+3PrQRJCYdWAXye3ldLwfZoTmViYZLDP/?=
 =?us-ascii?Q?by8KGp3nA2E4tBOYMof46zq7zFvcTz/6BHI7KpQzlGr/0qr3D94SctVwydgk?=
 =?us-ascii?Q?u+mWsh7a4llBaKnDywsjS4Y6br2ol/0bkOWRraywlNnexTbl8vMi9AdM1jwc?=
 =?us-ascii?Q?WzXPTBJhsdChNW2UE5Psc3sbiqcZiUbq7DgNXTfHe57N8XPO+miFL/0iaB2S?=
 =?us-ascii?Q?rAwObmvaCRPEPDby52QEPGJWeqjHvRAkcaHOdLhgXPJxl6Ly5kdRpl+zZ03h?=
 =?us-ascii?Q?6K2OjH8kxy2vINcKpFaY2HMX3wDY48CKoZ+AQb1vw9br3w3vGUitE2TaV3vY?=
 =?us-ascii?Q?7ykoGRCvX1dr9JHLSZ2rSjlYX2MRgAXOuZV5STdVMzscep122MSEWyy+Nb6A?=
 =?us-ascii?Q?PXRa2EDSWRis30aG/gAHnJkeK9FFzHB4xG5AggxV5a/1Zp0MX/YrVYL7y4kl?=
 =?us-ascii?Q?N+VofKOo4GRmOFm3w0LhQNX8hQdJ1iBvzFfCg7sjmUWOtkZYnn5kSW3htMzb?=
 =?us-ascii?Q?iAZw0rx1JqI7R+Q2EG4fHrB63hqFJo8sZNysPVyC669ydSozwKAAwNR22Ky4?=
 =?us-ascii?Q?ehaGkEGKLF3d+vBeCDXSlPe36Dn1ICKKgfaJ45ZWjdwMiYsmGwi55aFXDslD?=
 =?us-ascii?Q?GLOySZM/Ao8cv0blq/JBW1FMzWbxfkudV0Y9A4ZmqDv/JkuxJhMHDx3kt7oV?=
 =?us-ascii?Q?fa6lXHNOQs8tWNsHeNmQCV6Po0BjWpqqqIDJKFZN7g8mxvz2Q2zxyLaMV0Yv?=
 =?us-ascii?Q?tI24pPgHqnqI8SfVyAMQnvOU6cM8wNK2A3zbwjtyFQl9VUU6WEeG/nXF5oZH?=
 =?us-ascii?Q?6kxGOcEgW2J2oUO4im/aw+WQtH787vCTI6IRulOA3l/jCyMwLVoNgjKANh62?=
 =?us-ascii?Q?yQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080d348d-7c2e-4044-89e2-08de26729026
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 07:17:41.9160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ct1pmnO3YGCbmYOr0jtXniHT6+DPJgMpTIKfdVeMr8C0jrunnRRBYOLDlq0OsjIdChKu/fd10AveDAjldwesryRPnEoD1niyLs/HzOPSra8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8246
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Daniel Zahka <daniel.zahka@gmail.com>
> Sent: Tuesday, November 18, 2025 1:24 AM
> To: Jiri Pirko <jiri@resnulli.us>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon
> Horman <horms@kernel.org>; Jonathan Corbet <corbet@lwn.net>; Srujana
> Challa <schalla@marvell.com>; Bharat Bhushan <bbhushan2@marvell.com>;
> Herbert Xu <herbert@gondor.apana.org.au>; Brett Creeley
> <brett.creeley@amd.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Michael
> Chan <michael.chan@broadcom.com>; Pavan Chebbi
> <pavan.chebbi@broadcom.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Goutham, Sunil Kovvuri
> <sgoutham@marvell.com>; Linu Cherian <lcherian@marvell.com>; Geetha
> sowjanya <gakula@marvell.com>; Jerin Jacob <jerinj@marvell.com>;
> hariprasad <hkelam@marvell.com>; Subbaraya Sundeep
> <sbhatta@marvell.com>; Tariq Toukan <tariqt@nvidia.com>; Saeed
> Mahameed <saeedm@nvidia.com>; Leon Romanovsky <leon@kernel.org>; Mark
> Bloch <mbloch@nvidia.com>; Ido Schimmel <idosch@nvidia.com>; Petr
> Machata <petrm@nvidia.com>; Manish Chopra <manishc@marvell.com>;
> Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Siddharth Vadapalli <s-
> vadapalli@ti.com>; Roger Quadros <rogerq@kernel.org>; Loic Poulain
> <loic.poulain@oss.qualcomm.com>; Sergey Ryazanov
> <ryazanov.s.a@gmail.com>; Johannes Berg <johannes@sipsolutions.net>;
> Vladimir Oltean <olteanv@gmail.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Ertman, David M
> <david.m.ertman@intel.com>; Vlad Dumitrescu <vdumitrescu@nvidia.com>;
> Russell King (Oracle) <rmk+kernel@armlinux.org.uk>; Alexander Sverdlin
> <alexander.sverdlin@gmail.com>; Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: netdev@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Subject: [PATCH net-next v4 1/6] devlink: pass extack through to
> devlink_param::get()
>=20
> Allow devlink_param::get() handlers to report error messages via
> extack. This function is called in a few different contexts, but not
> all of them will have an valid extack to use.
>=20
> When devlink_param::get() is called from param_get_doit or
> param_get_dumpit contexts, pass the extack through so that drivers can
> report errors when retrieving param values. devlink_param::get() is
> called from the context of devlink_param_notify(), pass NULL in for
> the extack.
>=20
> Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>=20
> Notes:
>     v3:
>     - fix warnings about undocumented param in intel ice driver
>=20

...

>=20
> --
> 2.47.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


