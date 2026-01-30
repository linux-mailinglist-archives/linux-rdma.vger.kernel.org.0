Return-Path: <linux-rdma+bounces-16272-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG8wLbLvfGndPQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16272-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 18:51:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED29BD786
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 18:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64DC53009518
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 17:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60235C180;
	Fri, 30 Jan 2026 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9zYXuMG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B9D344056;
	Fri, 30 Jan 2026 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795497; cv=fail; b=n6v/hIxhNlVbmnpbv5a68m08bw/5/6ou6jzKWaqRycPvShd5n5f+iQfsrZJccRsE5pYQAX7bKaiYfW49VlkRtQz7sTpUC8pfSX5SZVKsn7/3vEj+ENd9lZBXKjoQz31+d37j0cm6iAX2Izq1DbmpIfvQfvvOACYYqkR2S6xP9Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795497; c=relaxed/simple;
	bh=Z8B0KJeY1Db+klEsnKz1KkxnFueISVKihU04MD06oro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=suogJiostK+lh95ihqLGvNAe14bzOMbCDu9T85u34l74lM9i0hSuk9S3kxxFjDtlZIVUvtY2F+/bdwxJkVKOIgzsCHsQ7+yvCj7NlGIGziNdNSKldwI6MyE3JQ890dOziVSUxl2myf74lV7ldk/Tuyem7asdSdp6LaJIfpvdDAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9zYXuMG; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769795495; x=1801331495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z8B0KJeY1Db+klEsnKz1KkxnFueISVKihU04MD06oro=;
  b=K9zYXuMGob/vBiqpUsqGfhSV3SMrVnmf3tw5H55N/5dtiYII13C3k3EU
   1LY0CN1YyeKH2GfxRxvS3i8zpo7qbd+P9qV7XCNdKbPhSIx2+m8ik/tei
   5arTwgTdbR+NueJh9zX2mfyrsTyCAmVil8FOviNhAtAT+CEiyYmpv8cxM
   Rbxz8WweuMDFCTb83vG6NERUElUMEIa6+xLxklR98ElTJvOYJ3MrEktEa
   nlBhcEO0VRXbGNKGjqTRgSnUg2aCob80UqIBXEOW5xe/mWo9f5WlxOA09
   oa13kxconL3ekG/0X9TcqazWah7hJxGA1jC5cbpH2TnSD416/u1FZ7dLj
   w==;
X-CSE-ConnectionGUID: yURRR9HyRoa1zj73+H2nTA==
X-CSE-MsgGUID: uUB1In+TSo+5k+QlOqkUnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="82474623"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="82474623"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 09:51:34 -0800
X-CSE-ConnectionGUID: +vxe/N8QS2qtPQ4tCM0qxQ==
X-CSE-MsgGUID: bgtDkLKmT0u2VmZKtY3jyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="239635197"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 09:51:34 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 09:51:33 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 09:51:33 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 09:51:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLKSMKHPIxDOEec7LBoG5L6AL/qhMgCB2E88fAal+jMnCwWpPqf+Amb4Nw0DBa74/vNKxCwM8kielN1Wwt6unzSRuX59WMqQWyV+2kIppdeczav5q1yfHkG0W7qO7pz4Zl3lyPi7nOKlZwydfMFNpdAre6vcz8PYShCwhJyXv9WbBW0VF5bJmHMmdT9d4IK6g1NF3a46u/WeVJkFuMS6b20zAqgFNjCWxEIXPEYVziBolqBWlMs7Ep/QnwMeMgY+7T9xf1irCtf54/VxeWV2x2He/rAM/bzDuOwUW72nWM0pYor9//JOYCloeWYRPSbRbfZAN535MNwp9zLCa4s8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDKoHJTlzym54S1ruYU4ygbEuTbeMFb8Xexof7jmc98=;
 b=pv2Iv/LKESB6qu/2qKDQ6tdCzauP5rSiYGXxHgxX6rwowB1jfiNMe2Ym8mHuQaJy8Z9zVAKv776ssJGbgZJxPOvbczLRgOSQ1znSbyMCxiirR0llh+7FJv8CuWUUK2mFiBcaZv3C8RDCY3W/bCDBZZI9cTBwTcvscDr3+XuzThkA4/PTXhuMmsaicfCoR29b19AU3/dZO/HFGOLGRD8H5ITUyqXrHyTNjsTh83v5kN9e63ExzVxytitvC/MFR1ATaEApWuxuKrvvGVbYW/+7jAf73UM+4/US6mzW7/F5GMkyGfvOrg6Ta6fAZqN8s5aGU5DZYhNScWx2WmyZUT+ZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by CH3PR11MB8344.namprd11.prod.outlook.com
 (2603:10b6:610:17f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 17:51:29 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::f7b3:4461:b4f9:1a0]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::f7b3:4461:b4f9:1a0%5]) with mapi id 15.20.9564.007; Fri, 30 Jan 2026
 17:51:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Jiri
 Pirko" <jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Paolo Abeni
	<pabeni@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v3 6/9] dpll: Enhance and
 consolidate reference counting logic
Thread-Topic: [Intel-wired-lan] [PATCH net-next v3 6/9] dpll: Enhance and
 consolidate reference counting logic
Thread-Index: AQHckgkndivovsLFxUemfUsMNg+CXbVq/evg
Date: Fri, 30 Jan 2026 17:51:28 +0000
Message-ID: <PH3PPF7A88A980A57770D04E34B234A86EAE59FA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
References: <20260130165338.101860-1-ivecera@redhat.com>
 <20260130165338.101860-7-ivecera@redhat.com>
In-Reply-To: <20260130165338.101860-7-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|CH3PR11MB8344:EE_
x-ms-office365-filtering-correlation-id: f9c10801-28b4-4144-9831-08de6028321a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?k7otF6YeqIseZ1a+jmAuOpPxmofTyOrPupNGrRphYXcZTuzkqYFf2DUfmVMs?=
 =?us-ascii?Q?XnbCd1ss3JC8tpYII4+G5kJ9bJ6ihhwPqUAums4OfJ6E6W/kdlJ7mWTMRblN?=
 =?us-ascii?Q?2Xs+fLvcUZFjJJ9U04caOhZgWb3RtjsWE4cbH97T7JIVonIyoNuuPXzB3O2B?=
 =?us-ascii?Q?cW20gh54lkK0JPzbuZA6P7zb8kwrTj+YMyrsScTA2MFoSOWfEcK9N/+9nA6A?=
 =?us-ascii?Q?BIKXZB32JYgo6YeD3YhDIuTTWK/UAedybFKn6trHcxbwyQO4OCZHCqt73gyp?=
 =?us-ascii?Q?/hv3pDd1vD9ctZNLSie3aMtf0NRM75AJBwYSbUHnEVCm543VbmbhXpAJ2M0X?=
 =?us-ascii?Q?5CddOedBFGGL2yxscVW1ffoSGAbeeER8iJDGx1YNOrCYyJ0ndeJRkbLGpwc7?=
 =?us-ascii?Q?VhgowqpBonLalM02Oq9cABnN9H60k8XaFlQ3xnxeD4DgUs+JoRDMRsFDiLk2?=
 =?us-ascii?Q?CskaKkjOP+ksnyV86nVo05mELMiodoBCLryGHTowCQWwU2W3cb5i++ajjhkj?=
 =?us-ascii?Q?CC0+B7z45+2nthsksV7qCFJQGfIwoAKnahl2T/krgZ23piphGSG3JrxJZc4K?=
 =?us-ascii?Q?whJLeu6NuYMer7UFtSjmH2tnczZxoZxudfYD1O5ypM59DCpIHOqYntaVJ3RB?=
 =?us-ascii?Q?O4K191uhU0g0hHzx1RW1ZlgYVmK6JXBaimSdyufyDxJR6b2fK29qHxisR49R?=
 =?us-ascii?Q?E2AnHepwaC9YYoVwwCLJhrqcPYlc6ylQxLuqPkEyx42dxb1zkOKWvdTW7/bP?=
 =?us-ascii?Q?ADRyPkY98Glfu3JwEjQPygymwI3P6BWmE2yUCFOtonElzumr7uCg7EXCy+lQ?=
 =?us-ascii?Q?vag9/XFMYKfyyzIq5WyzrrpciEHtd1KItGIBAk/q/MNxIzs7Gs0yd0bHYYQL?=
 =?us-ascii?Q?UBwt48FYkFHWxpvGSblWcFnXXcOEbgZG84Pi6lCndj7djGEVhFPm8oSNBzV6?=
 =?us-ascii?Q?fj6rkCMdeowIkvcWE9iU0pkgStnq6sU670MpfropuVFHXPUHyc6wmg8Zr6kd?=
 =?us-ascii?Q?Qsp8VzjJ23W85aWDQOt8kk3/5sGxhb08l4BCzQsbcI1XS82yrlA6NIzsfvbd?=
 =?us-ascii?Q?Dq4/mLnlT07n65J9yEQX65IB5162mezThwmm87j1QKH9N7E6uEy/Se9JYa2O?=
 =?us-ascii?Q?6ZwhTL+QSRa5xNEE0SpfUcjVLscbxjiwECVhkPFPLdpiuJGbKK7Bsoh0Mb7n?=
 =?us-ascii?Q?S16CLCZGJJINILJE7CbYlTtgqr9WKYg1s/4WUMHYTTt7LrkS2dgmh74J7Gzc?=
 =?us-ascii?Q?eYPsXAjWMnw5bVS7XZFNmGOipnQO09SlRzD9mPCzDeXdoH1ICVzPLYD90ETM?=
 =?us-ascii?Q?hiQ9+DWaPRFjaYfkKThzfK97i5r+SSNpk8ymxKI/XW8sRnPYZZWlmwbX2Zku?=
 =?us-ascii?Q?x9et1/GbW0F4ImJD3oTITcMc/RGZvt5sTh9b97oNUs5lCtgZwcvvS6H/CEog?=
 =?us-ascii?Q?jprwdDr09f0cKlvX1IupkZQ0may72P7Zqcwma/59v67c4jRx1bISJhFqG5TR?=
 =?us-ascii?Q?83MgPJTeOI3ajnIQFG/bMlAQdQRGN1ms4/+qy5DQGB5ZSKxRom8BYSlzNnKK?=
 =?us-ascii?Q?YBXwzAsfnNK5FzJKCg2BjSWxemfGRMERkv+iZjSo9kH3A6kMY+2+fKs4npiR?=
 =?us-ascii?Q?Vkwz0G+BjDevYJC9YxG23QM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF7A88A980A.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PzDZCZj3sSgp1WOsRRussoq4ry7JGy+l5cKdnf4Y5L7ebN1VtE0cptm6z/yq?=
 =?us-ascii?Q?epdAtR5ULiyJShgdr6L37NsdCTh8f3TBk3MhwIwYEHYHL9pgzYHI9ia5jZ4Y?=
 =?us-ascii?Q?w0wLmYgrw2S451cpU5MQAakD/F1xK/oFZ0BQRBOCX3fOglWRDpLZ4ST1/N2K?=
 =?us-ascii?Q?WoUhZY1f1ZzmvSs/c/1spaA6W/7SQennGkf+f0QMkW3X/Yz7bXtGkUYfaKMm?=
 =?us-ascii?Q?v/+7BZCfICLjY5lgFAX9xQFAL997qWGBX6hL3wyrOlgeRy7Vos52Oeykc1jV?=
 =?us-ascii?Q?RyO/WI9AAjmyUdAbfgtTWa0t9ggqJ7pMe/CFsFVxSKVcFA5wal504g/7p4yT?=
 =?us-ascii?Q?roOObA1Xmt0/BGpObaKc6j97VlbPFPVVIMCXaROzbiRs6kjJfWTSOrcuCcUv?=
 =?us-ascii?Q?Su/VIdu6qibGcFWdYXi5ofU3pULc3oZ+jmT0Bs4FzAgAt37sOf1f9uxy81UQ?=
 =?us-ascii?Q?qfoTvNs4xqWwswoJRTaqKSY/ctAHax+XNArrxetFPvyn+XrKOiQyL+w8crqg?=
 =?us-ascii?Q?2RbmJA0CZI8y3yzG9VmKbUQdGF+CSp21IdLu9IXwMhPbVAVGNIiVU+1hGP3T?=
 =?us-ascii?Q?1nRl+90tv9TuyZiElOaYLdtAiNXY2F5AGLnof1RuaHIVLdqugEWs+GGEvFd5?=
 =?us-ascii?Q?G0VU912eFQHD9NOGUdK0ER8pB8mm774wwQ00LZu0m9scFgRc52CHpjXhnoyd?=
 =?us-ascii?Q?Tu9MqdaeTy+8Y725+fiZekPCayOA8h7ZJHqpwpOd+CoiZRb329QUdu618nur?=
 =?us-ascii?Q?9pJpw9t6MxKKySV/y9dFB3K3vn9YG+URgBdVm6x8Z9qULbn5BPP2OYNm/eCj?=
 =?us-ascii?Q?XVcfB4FHFGUkCuRAjegkyNFr9lO30CuwwBuWsA3Rrg1BYIo4lbHxAe6F4HjL?=
 =?us-ascii?Q?2rLr2CoLt8B3og3CbozB5GwhXO5eK5Hv0nMDiysuuLn85eZbcmN4IDmf0YP0?=
 =?us-ascii?Q?ZS7QzfVHiAsIjlp0b/lfv0DeoGHVyXSZULGImgLyE2VjK9WKigAcO+JUMFE6?=
 =?us-ascii?Q?EhrEU5OheyFKx68ev3ztEEn6l5fvnMpXohM3lCuAgaCq4oifBleC+1cNQLxz?=
 =?us-ascii?Q?LtiyCDJ8rjYvG69ygxrBoC1QmNy1ZZBEigF3jbnOWJ2ZSxY/wGoX4bN0sAVy?=
 =?us-ascii?Q?JsmN5b7p7Tg5jPFRV4DLxrDfQBZfrri006sXFimmr4tRHzDDClL1IhxIIs+j?=
 =?us-ascii?Q?Awrd0F1So5lLt3qDi3boLFJrsYUnaMmMX2v8DDPMQ48S+2+UMU5YrDmBluVY?=
 =?us-ascii?Q?p7PqCr/aN7ib4WIZmKe7hulVeWEB9ELdoD6KL7xP2MhmM2kZP1NOdYGSXh2Z?=
 =?us-ascii?Q?6J4cLk34ztP3F2fUnI/QLHZD8jDZqaSo3wX+LDXwd1CILGPrR42CnJlGlW/G?=
 =?us-ascii?Q?k3khZNil/yt89VcGl8LBedE3svMjomDFUnGxTFpEFLeOcTEKYDEyekl8gtak?=
 =?us-ascii?Q?dZ9bwFZ8nVxSDVwpIT9s0uDFmMgkkpVxnmK+GLIqFpLuSQOT5ysLzzEzu3VH?=
 =?us-ascii?Q?VJUH2dVUjJSzDUWbEkmiWGGvrPOIWgz+ZA/lt05eO7y0VD0N10m3KCEtNGSl?=
 =?us-ascii?Q?rbA6u/WqwnabnO9yJGsWBR1PJ/JQM0iY5Vem70JLpAasUC1mVehhTBYjiMMF?=
 =?us-ascii?Q?5tKb68zjcNU2a0arNca1osO+SlXFdLL77QOKdpByW4Vj8wD/rikGQ2MSCVp8?=
 =?us-ascii?Q?rgC326k5DdLo7CrA//Gsm+okswdMkrgJ7xw54BOHRKfY/IJRoLy0noOtpiCw?=
 =?us-ascii?Q?9UKtcSLu8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF7A88A980A.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c10801-28b4-4144-9831-08de6028321a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 17:51:28.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p//V8riWyyxfGIDZyp9BX+Yo3qeE6j6d/oxxeO5qo3IFLinaOrVuAIgsZ9ZGiQpQkkEPfVA74fp0xX/a0KenOBhk16ZZSsftMp8S6V7q5A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8344
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16272-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,osuosl.org:email,PH3PPF7A88A980A.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5ED29BD786
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Ivan Vecera
> Sent: Friday, January 30, 2026 5:54 PM
> To: netdev@vger.kernel.org
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Jiri Pirko <jiri@resnulli.us>; Jonathan
> Lemon <jonathan.lemon@gmail.com>; Leon Romanovsky <leon@kernel.org>;
> Mark Bloch <mbloch@nvidia.com>; Paolo Abeni <pabeni@redhat.com>;
> Prathosh Satish <Prathosh.Satish@microchip.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Richard Cochran
> <richardcochran@gmail.com>; Saeed Mahameed <saeedm@nvidia.com>; Tariq
> Toukan <tariqt@nvidia.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Vadim Fedorenko
> <vadim.fedorenko@linux.dev>; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 6/9] dpll: Enhance and
> consolidate reference counting logic
>=20
> Refactor the reference counting mechanism for DPLL devices and pins to
> improve consistency and prevent potential lifetime issues.
>=20
> Introduce internal helpers __dpll_{device,pin}_{hold,put}() to
> centralize reference management.
>=20
> Update the internal XArray reference helpers (dpll_xa_ref_*) to
> automatically grab a reference to the target object when it is added
> to a list, and release it when removed. This ensures that objects
> linked internally (e.g., pins referenced by parent pins) are properly
> kept alive without relying on the caller to manually manage the count.
>=20
> Consequently, remove the now redundant manual `refcount_inc/dec` calls
> in dpll_pin_on_pin_{,un}register()`, as ownership is now correctly
> handled by the dpll_xa_ref_* functions.
>=20
> Additionally, ensure that dpll_device_{,un}register()` takes/releases
> a reference to the device, ensuring the device object remains valid
> for the duration of its registration.
>=20
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/dpll/dpll_core.c | 74 +++++++++++++++++++++++++++------------
> -
>  1 file changed, 50 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c index
> b91f4dc6bb972..33333bc2f0cc8 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -83,6 +83,45 @@ void dpll_pin_notify(struct dpll_pin *pin, unsigned
> long action)

...

> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

