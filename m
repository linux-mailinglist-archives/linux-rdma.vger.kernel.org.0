Return-Path: <linux-rdma+bounces-16568-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JmHDz9hhGng2gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16568-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 10:22:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF61F092B
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3E873004C3A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480EA38F94B;
	Thu,  5 Feb 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCDEwmIp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325035E529;
	Thu,  5 Feb 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283167; cv=fail; b=ZYCJ4aOxlGe44ArLHN4VCidapPCATgEQNSHku+sDUmuurgw5BtUlnzNVgknZc/YZAvTkbjnauyO9y66DH/4gSZsCVwQT1lWYAsQbM21Y3cvaFXEgwaX8fkr5sx1xW6Vsdr9MjMwwlg5xFdlQOhJ4iw1ikCL5L8gL28DnPf2rr1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283167; c=relaxed/simple;
	bh=tMcXMdLlCTR5ZfAvdLAGGqWBsAm5gy1gswrYpPL2nBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oNVOo2Kc4KhDYo60zGegxT3+s42T4Y80M0Ka85ryO22PDtN7hCtT/kGrCJE/76ZdyBeMvWfzxpvDpYROKN4P9jOom8HaVRgmFbhJ5E3UilVb5DPdJgvK2fd6SNiAow1xKwP3FlbwUh/w6iOh0+tcQseJg/ppetbLDcT46NgfwQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCDEwmIp; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770283166; x=1801819166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tMcXMdLlCTR5ZfAvdLAGGqWBsAm5gy1gswrYpPL2nBM=;
  b=hCDEwmIpP1LfmZHKmDSUbZJA6EKtg8TJxTsC+cMjZkQ4cpkxluLuLmfo
   5N8fWcye1x7no60klYtx50zFGxCBJ3jCBPo4f+BokPV0kbhLtZ6Myu5Zb
   PcEfI2zXO7edFOIxpArtNBHZa0kOOblrlZLdAS/Kq9e9RMwJAVPlFbwpc
   wEQp+1w2FEBOPU1sg0SCy4/V6o+RcxWnfxIYF7HlboQBdZM3giItwmFua
   J6wl0WCTBYBb7fHcTl5K3Bz1fILlB6Jibhwg1W7yOoWIp4L7ypqUb43GW
   0JNSjt9J1L7v9E3Jz+zCnE1i8A6WSIzpEkqJ47EHIIcoP2CFwNNAtEGYe
   g==;
X-CSE-ConnectionGUID: LPR0VuvWRpK9++N5TSo3dw==
X-CSE-MsgGUID: Qz9Uj/5STKavZmhiV6jufg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82597148"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="82597148"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 01:19:25 -0800
X-CSE-ConnectionGUID: 2be6hEO0QYSI+MpbaiLbJg==
X-CSE-MsgGUID: YoCbgpeDQgKXOnDAewS0Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="215430545"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 01:19:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 01:19:24 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 01:19:24 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 01:19:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuZIuuwJ0kSiyzk7h/Nzq9eaCGnigbD/THNZ7Otsk2jFZ3WONFLQavEw7+ofnAqZDEy6/B0gCszMnnM8qUaY9V9rQDETmowGlSewUbcou/jqCAn95glHpC+w2o+WspM7nAPSc3AnW4wRrrQvZNNcWA76iqDO4KH2hi6Ta7913bbEeVeAsbKoCaeGVpLk++HCsQwUFwOZSMX8dvNCNGLsXetgFzWj/fNJ1YuVjg+NfizSM820afi7bonOj+xYKT5AR19ZQXUJlCqAJO5YW3Xxr6YwlG35GrRBoF1bxoYVwdmeNyJvhnlFEkzEeEf+dLei9j0dF8OPlBR/Ko1BbtqeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfESR4fdGmnDY0KEn/qLUtWwmmXBgfb6GJpSfdSH/sU=;
 b=jaohk3Vvpy6BorVgCFSIiqdFlKpYDFmZyQzJWE4R/2mxEjtPYLWK5/oBx+3U4Vlm+EW6zDLksRpsKd3c8/LW/sKQ9+YOaK0GHjof4gas4Iw3ap5gdrDRgDTk/X1hXWKzzkXfAJb8dDeAilzi02+DrswcqQCksHDzDJawhf0aCeSZ/wJh5bHR+scxF16SQwgIMGccB6lG+sSs7pVqkcOU/Qir7Hu9Gj9tg7N2YdWvRwsoUaz+gW7iZoBEmJZWCooc/hH9h6rB51iNbtIfig1hWHoqTdHXNjHwQHtXaJaBRYCD3o5C2MiqplgySYP6tI5JIAbk0dg348Y8FHPonIGPZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14)
 by CH3PR11MB7866.namprd11.prod.outlook.com (2603:10b6:610:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 09:19:22 +0000
Received: from LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed]) by LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed%3]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 09:19:22 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v5 3/9] dpll: Add notifier chain for dpll events
Thread-Topic: [PATCH net-next v5 3/9] dpll: Add notifier chain for dpll events
Thread-Index: AQHclTRHvnYaVEjkMEKrqVu+t7n087Vz0VwQ
Date: Thu, 5 Feb 2026 09:19:21 +0000
Message-ID: <LV4PR11MB9491D093C1A1D3B86B6DF8B49B99A@LV4PR11MB9491.namprd11.prod.outlook.com>
References: <20260203174002.705176-1-ivecera@redhat.com>
 <20260203174002.705176-4-ivecera@redhat.com>
In-Reply-To: <20260203174002.705176-4-ivecera@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9491:EE_|CH3PR11MB7866:EE_
x-ms-office365-filtering-correlation-id: ab4802a5-2c41-4e66-707e-08de6497a5f1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?9izTE555H9qNF4Digtx4pWxeqlYohhtvCGBub9n66mvmke4lIxSihPAbmfqY?=
 =?us-ascii?Q?5KV5xBu6H7NxTxnG9o2jdcbQ5se/w5h87zTx5fmrQcFBuCToZImBF/7LTHcx?=
 =?us-ascii?Q?65DBolSO8W7kd9zDOHpCxK8vaQmma0V9L05rG05JlCiZmTRBT7BrvgV7vwf1?=
 =?us-ascii?Q?pTWpaSqv01VNYeJ4GpoqdMhwOcg3iiyFQ9ZQRKdmrxOmpte+YZY9D95qJ5/C?=
 =?us-ascii?Q?QUfJJYmXcISKq83YavliIQaSSaRdfq35VV8u7GdEdKj2QUmk4WhKy+xwehmw?=
 =?us-ascii?Q?uAUApUPsHSqfcyhzOLP9K/i9Er4fpKemhsBDXmj0k8DcHd/BipQiD43L6kJT?=
 =?us-ascii?Q?ry4VfHXIB0hyTlw8Kcjvkcc19O1sDiK4oau+noQCCiWm/TbPy4iz63uHufBe?=
 =?us-ascii?Q?uOIdTo6/AseXEuVIbXsnUN9dnQ0yb+L54Gg+hwyLpmeGuZc/MVtQnoP4CjNy?=
 =?us-ascii?Q?pWbAi2gXPKMye4GeCTFsQdXIpEja29sgDkJx9MYdbt//SBk2Z47ZNW4je1s7?=
 =?us-ascii?Q?UnMPo2n7Dqc53tS3acUB/bY9PaoP03PqJ8X81onlOnW3KpiYFD3barXA20EC?=
 =?us-ascii?Q?6ct/kszPrs5HO452sjXuSX2dOiLsMBZIx1TLzUJ0HndHSqmjx9nrcfHHuPwL?=
 =?us-ascii?Q?MGf52Y8LOgnHDXjj/hzKr+JVp4PY4dLIzj5GKvdpen+W5hfO1zXHq8lz4YNn?=
 =?us-ascii?Q?/4FaMChdXhjrOS0Kt/Tr6P9xbfbRlXTUeKXBF0BazHoo8KrCkRGccqYCEzh+?=
 =?us-ascii?Q?Ua4laOJWlDQCdqMwrmy52ep/Ai1xp4DpqZuufiMRoyYSgOWozl06AKDca6fx?=
 =?us-ascii?Q?+dKfxV3NVUmVDqSO6jYBukR2PBENH6wCDCfnJ6aJdLZyyNslnkc0C5iCzgAD?=
 =?us-ascii?Q?UHfUE86WeiPXFroyLp5+RILTohesbNaCgZ4EJIe9SDyhbIPt43zdRAZSu8NT?=
 =?us-ascii?Q?0jvkCJz5ofvVzIAbOFLliWrHUP8ydJkFsgPsVFYSQfKJqp/vtAFas4Pl6M3i?=
 =?us-ascii?Q?uhix+7mTgQUal8FIENU07XFe71fr8eR1K7qL53A4aHlM7z65PKiH4ZXd5y9I?=
 =?us-ascii?Q?YjrQ3xPck0e8cY4HZY6+eGovXmJF06BVI6541hoFZci17/6cVPzkP7kHSkHK?=
 =?us-ascii?Q?eySbA5O0wh2KrSrgDUE1zwMXYD/THAA5UryYf6OBQnSzU13BSCmytG/WxHT7?=
 =?us-ascii?Q?hTZED7bGBGv9GMp0yXPv2PEUqC6wOXU0fnOZbQf5Lz7X4gs/nTDVk6XUXdRv?=
 =?us-ascii?Q?sB4rx8FEhlbfpjXc1JBPK+A8v1hG0QkFwUkOJ7vDlSjS6UGw8NmvWwN/2RDF?=
 =?us-ascii?Q?leb7wCJo5mCHihfE/o7tuaAatjwTf/rQtcq7zzQIDkf5iXWctSerAiuaAt6D?=
 =?us-ascii?Q?Ykl71wwSYr2iwNOHRGsl76V/hZRpeI+hZUnkH3YGASWPM+AdkZ6zK3ZzxaY6?=
 =?us-ascii?Q?MfHsYjhxXlmuOCTbmSf0NIhbLSnM3xwgDKxDhpklu9mlodbJPzrcv5/I+Jdo?=
 =?us-ascii?Q?iOtbU4EhJ0NEFbH+ycWkqD2kP5pay3Ci+q931bIPI7W1VkB9XRis6u+Bp1b6?=
 =?us-ascii?Q?vj0VdoQqTMOJoCYrfg4HFoe0xWKUs2msiwNXkXzmaApAn5X86yqGwv9TITXa?=
 =?us-ascii?Q?K3To6vnZT6kdJG17BnWMtlE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NQLzKUBKPQYFwXiH5sFHwgN/cPESs4mg/y6rKASSXC2jFI/MATQV3tZm2XIk?=
 =?us-ascii?Q?seci1Chk7zOlneT35TruD+FF04Z2I6OgPsDD/txDV+gHh8LsNmk794SsEqWe?=
 =?us-ascii?Q?6NNodbkWvkluhT3ANhqRrce7hRjG6esqBiEaevngjMii32GvI3w1LDBd7XdN?=
 =?us-ascii?Q?AH2LWxzpe2fukVm/oVPTKDpj0/CMJgh4VQGucGzrjj3W36yVua+9gPaR5412?=
 =?us-ascii?Q?iO+MLcNRH38S+AndhXf04EgF5qzQV7fLYdx/vZXV6xdhOy8U8agWvMOQ51bt?=
 =?us-ascii?Q?CJNACQcrdjv0mGG0XKWkDRIOipyQmPwCjSgdPnqRgdzKeNMcD1uwNMKopXib?=
 =?us-ascii?Q?sEAwdGIN46TqFhDLBWv6b6JrYO9H4uZqoMlezwaY8gEMF+0X3RWM0m96GX4G?=
 =?us-ascii?Q?QBL0mz1ct2Zv5NCt8GELxrCq+ArOKhoxA9eVY648eJsVe8G1IMg7racb6pPD?=
 =?us-ascii?Q?g+9/mbMaIZLHlf1rht9xN4GstnXMvr00/2rqhA6B3EVIbNoUhcEObl2MZL7w?=
 =?us-ascii?Q?c0kDrivyyU0oj4FUYRc4zikrn7uZ+zGo+alpPA2L6ZHxPGM/aG5blC0sy5k/?=
 =?us-ascii?Q?CrNj/OLp2+IeMBJ9bPN5CMImLxqYGj1XOvDUKGjoBkSiJ62r42PU+oqOPNSt?=
 =?us-ascii?Q?O4XZY1BLo8SWB2HtFBLoMA9UrqhMWtMjl9zBf129SsZlSiR8qtgZvFtvWbGj?=
 =?us-ascii?Q?iUVtugeskTAQt/UdscIrxNqMlGe4HdvrMjXLYtb2BDy4ZO5omtDjsaL3er2o?=
 =?us-ascii?Q?VNemLQXyPYn+t0EJyjcWXGXn6XnCp2CsHED2DaWl9j9bhePMy2MJivmMgvCP?=
 =?us-ascii?Q?OhZ0DAj6ljWLjxgJjhdj5kchB6EKtQmhy+MzUTJeRAmuZ5YaufTX9yBTtj9E?=
 =?us-ascii?Q?cqLnNAPKTSsLjVl1w2KKHLTMau0hC9YiMk1xKir330QeS/nKcT3xAUXFIdqa?=
 =?us-ascii?Q?CKZXu08c3QDF/dEsqfpJsLR0xXyDMK2ki7ARmIfK8ZfaNYsX6XlHLJpWkGN1?=
 =?us-ascii?Q?ST507ECLEiNf9ZdOTWC6LkNqLFSYVy6TMaed7UoiETYFQOL/qJ4MKKTFyLyZ?=
 =?us-ascii?Q?RfbX0buPIKgruscyg6lgWb/XFEHUnipOSqWVPS3hBYmsyRCZMRO4dbB3twqb?=
 =?us-ascii?Q?IKr5/eZ37K6Tn2nAjtBurvkSG8+Fw8+ei71lPdpPXaAaZuLTzVYoE/Dssqhe?=
 =?us-ascii?Q?jz5uKs4mWndJmRTDXpUH6U8M3tN2Bog63bHfOciHd2iqOKYe8MDk0u1dzPSa?=
 =?us-ascii?Q?HPgA7EjB8HhFcaHwTMgFnV7bvs2BTAWXd1kDWz11y35RYYBsdsZJH/IAknPU?=
 =?us-ascii?Q?iypBScBC/Ny4kK4tpvcHQJkexzwsIy4LfUsTFXmeqV+4kBoZI994bL6/koB3?=
 =?us-ascii?Q?dbMs+7MHn15zO1SCH6zT9A/NP5HpVOIHftIBylsikNPx1J3qi8SQLAuDewYL?=
 =?us-ascii?Q?pXjBEkJuty5bsDeK0tRSxGcADo8Aa68SwBQq+ZuvIeOGYE6ca0xws1r0WYCb?=
 =?us-ascii?Q?0RhhMr6pMtY0LQjXBil72S9iGyF6nI2VZWuSavnCYweG3/0YFF8hP2avaNJ5?=
 =?us-ascii?Q?T5E20teLF26uZr35jcsTU6l2y5omxTuNqghdUu3Wp4w3uRJ2JDxC4moeQ1Kp?=
 =?us-ascii?Q?5x1rz/xmox2utj2Kgb1T8aKgbP6b72m3Pa/fquaKDpQU8X88WoDwJeZ3EH0y?=
 =?us-ascii?Q?XkMoGumlLMVLMnwVNrKyDLCArRtYGt7QM71FLhbOvrWcPOR2QiN0O3uddv2d?=
 =?us-ascii?Q?tnh53n7Bw6q2xlwbeimEnZfnLohkJ4k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4802a5-2c41-4e66-707e-08de6497a5f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 09:19:21.9928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDeuLNwLyeiBIaXc6tiqHsdRRtREJKYfoShYwFnMtLjg29+k4Uy+5V7DxD8l39ErGO+y0xytZ34TO/+sleQ3XtPRjLPPDoPOtD11VGsz8LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7866
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16568-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,microchip.com,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.dev:email,LV4PR11MB9491.namprd11.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5EF61F092B
X-Rspamd-Action: no action

>From: Ivan Vecera <ivecera@redhat.com>
>Sent: Tuesday, February 3, 2026 6:40 PM
>
>From: Petr Oros <poros@redhat.com>
>
>Currently, the DPLL subsystem reports events (creation, deletion, changes)
>to userspace via Netlink. However, there is no mechanism for other kernel
>components to be notified of these events directly.
>
>Add a raw notifier chain to the DPLL core protected by dpll_lock. This
>allows other kernel subsystems or drivers to register callbacks and
>receive notifications when DPLL devices or pins are created, deleted,
>or modified.
>
>Define the following:
>- Registration helpers: {,un}register_dpll_notifier()
>- Event types: DPLL_DEVICE_CREATED, DPLL_PIN_CREATED, etc.
>- Context structures: dpll_{device,pin}_notifier_info  to pass relevant
>  data to the listeners.
>
>The notification chain is invoked alongside the existing Netlink event
>generation to ensure in-kernel listeners are kept in sync with the
>subsystem state.
>
>Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

LGTM,
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>Co-developed-by: Ivan Vecera <ivecera@redhat.com>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/dpll/dpll_core.c    | 57 +++++++++++++++++++++++++++++++++++++
> drivers/dpll/dpll_core.h    |  4 +++
> drivers/dpll/dpll_netlink.c |  6 ++++
> include/linux/dpll.h        | 29 +++++++++++++++++++
> 4 files changed, 96 insertions(+)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index f04ed7195cadd..b05fe2ba46d91 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -23,6 +23,8 @@ DEFINE_MUTEX(dpll_lock);
> DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
> DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
>
>+static RAW_NOTIFIER_HEAD(dpll_notifier_chain);
>+
> static u32 dpll_device_xa_id;
> static u32 dpll_pin_xa_id;
>
>@@ -46,6 +48,39 @@ struct dpll_pin_registration {
> 	void *cookie;
> };
>
>+static int call_dpll_notifiers(unsigned long action, void *info)
>+{
>+	lockdep_assert_held(&dpll_lock);
>+	return raw_notifier_call_chain(&dpll_notifier_chain, action, info);
>+}
>+
>+void dpll_device_notify(struct dpll_device *dpll, unsigned long action)
>+{
>+	struct dpll_device_notifier_info info =3D {
>+		.dpll =3D dpll,
>+		.id =3D dpll->id,
>+		.idx =3D dpll->device_idx,
>+		.clock_id =3D dpll->clock_id,
>+		.type =3D dpll->type,
>+	};
>+
>+	call_dpll_notifiers(action, &info);
>+}
>+
>+void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
>+{
>+	struct dpll_pin_notifier_info info =3D {
>+		.pin =3D pin,
>+		.id =3D pin->id,
>+		.idx =3D pin->pin_idx,
>+		.clock_id =3D pin->clock_id,
>+		.fwnode =3D pin->fwnode,
>+		.prop =3D &pin->prop,
>+	};
>+
>+	call_dpll_notifiers(action, &info);
>+}
>+
> struct dpll_device *dpll_device_get_by_id(int id)
> {
> 	if (xa_get_mark(&dpll_device_xa, id, DPLL_REGISTERED))
>@@ -539,6 +574,28 @@ void dpll_netdev_pin_clear(struct net_device *dev)
> }
> EXPORT_SYMBOL(dpll_netdev_pin_clear);
>
>+int register_dpll_notifier(struct notifier_block *nb)
>+{
>+	int ret;
>+
>+	mutex_lock(&dpll_lock);
>+	ret =3D raw_notifier_chain_register(&dpll_notifier_chain, nb);
>+	mutex_unlock(&dpll_lock);
>+	return ret;
>+}
>+EXPORT_SYMBOL_GPL(register_dpll_notifier);
>+
>+int unregister_dpll_notifier(struct notifier_block *nb)
>+{
>+	int ret;
>+
>+	mutex_lock(&dpll_lock);
>+	ret =3D raw_notifier_chain_unregister(&dpll_notifier_chain, nb);
>+	mutex_unlock(&dpll_lock);
>+	return ret;
>+}
>+EXPORT_SYMBOL_GPL(unregister_dpll_notifier);
>+
> /**
>  * dpll_pin_get - find existing or create new dpll pin
>  * @clock_id: clock_id of creator
>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>index d3e17ff0ecef0..b7b4bb251f739 100644
>--- a/drivers/dpll/dpll_core.h
>+++ b/drivers/dpll/dpll_core.h
>@@ -91,4 +91,8 @@ struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct
>xarray *xa_refs);
> extern struct xarray dpll_device_xa;
> extern struct xarray dpll_pin_xa;
> extern struct mutex dpll_lock;
>+
>+void dpll_device_notify(struct dpll_device *dpll, unsigned long action);
>+void dpll_pin_notify(struct dpll_pin *pin, unsigned long action);
>+
> #endif
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 904199ddd1781..83cbd64abf5a4 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -761,17 +761,20 @@ dpll_device_event_send(enum dpll_cmd event, struct
>dpll_device *dpll)
>
> int dpll_device_create_ntf(struct dpll_device *dpll)
> {
>+	dpll_device_notify(dpll, DPLL_DEVICE_CREATED);
> 	return dpll_device_event_send(DPLL_CMD_DEVICE_CREATE_NTF, dpll);
> }
>
> int dpll_device_delete_ntf(struct dpll_device *dpll)
> {
>+	dpll_device_notify(dpll, DPLL_DEVICE_DELETED);
> 	return dpll_device_event_send(DPLL_CMD_DEVICE_DELETE_NTF, dpll);
> }
>
> static int
> __dpll_device_change_ntf(struct dpll_device *dpll)
> {
>+	dpll_device_notify(dpll, DPLL_DEVICE_CHANGED);
> 	return dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
> }
>
>@@ -829,16 +832,19 @@ dpll_pin_event_send(enum dpll_cmd event, struct
>dpll_pin *pin)
>
> int dpll_pin_create_ntf(struct dpll_pin *pin)
> {
>+	dpll_pin_notify(pin, DPLL_PIN_CREATED);
> 	return dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
> }
>
> int dpll_pin_delete_ntf(struct dpll_pin *pin)
> {
>+	dpll_pin_notify(pin, DPLL_PIN_DELETED);
> 	return dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
> }
>
> int __dpll_pin_change_ntf(struct dpll_pin *pin)
> {
>+	dpll_pin_notify(pin, DPLL_PIN_CHANGED);
> 	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
> }
>
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index f2e8660e90cdf..8ed90dfc65f05 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -11,6 +11,7 @@
> #include <linux/device.h>
> #include <linux/netlink.h>
> #include <linux/netdevice.h>
>+#include <linux/notifier.h>
> #include <linux/rtnetlink.h>
>
> struct dpll_device;
>@@ -172,6 +173,30 @@ struct dpll_pin_properties {
> 	u32 phase_gran;
> };
>
>+#define DPLL_DEVICE_CREATED	1
>+#define DPLL_DEVICE_DELETED	2
>+#define DPLL_DEVICE_CHANGED	3
>+#define DPLL_PIN_CREATED	4
>+#define DPLL_PIN_DELETED	5
>+#define DPLL_PIN_CHANGED	6
>+
>+struct dpll_device_notifier_info {
>+	struct dpll_device *dpll;
>+	u32 id;
>+	u32 idx;
>+	u64 clock_id;
>+	enum dpll_type type;
>+};
>+
>+struct dpll_pin_notifier_info {
>+	struct dpll_pin *pin;
>+	u32 id;
>+	u32 idx;
>+	u64 clock_id;
>+	const struct fwnode_handle *fwnode;
>+	const struct dpll_pin_properties *prop;
>+};
>+
> #if IS_ENABLED(CONFIG_DPLL)
> void dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin
>*dpll_pin);
> void dpll_netdev_pin_clear(struct net_device *dev);
>@@ -242,4 +267,8 @@ int dpll_device_change_ntf(struct dpll_device *dpll);
>
> int dpll_pin_change_ntf(struct dpll_pin *pin);
>
>+int register_dpll_notifier(struct notifier_block *nb);
>+
>+int unregister_dpll_notifier(struct notifier_block *nb);
>+
> #endif
>--
>2.52.0


