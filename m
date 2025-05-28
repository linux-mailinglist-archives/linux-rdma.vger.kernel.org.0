Return-Path: <linux-rdma+bounces-10864-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D980CAC72D7
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 23:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C994E36D4
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 21:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F56220694;
	Wed, 28 May 2025 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4Cv0JF+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331620A5F3;
	Wed, 28 May 2025 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748468130; cv=fail; b=SmwuELnmit9Y+N0rHOeWHTPCu48w+fH3v9v7Bi+kkqZYfA08YTwr1tA2cH2M6NpQ5JqSrtUGuBBBSwsaPV8g1SnKhbFuiCr1EFnVHJC/B8heQ2+55EeKvO5Su+BtzTiWUCLS3xq8P0XwL3aO7AdNo7nv6JHNO65JLkhl/CFYaTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748468130; c=relaxed/simple;
	bh=6h3SuDdLez/zZVGv/8ClHaj3JGgo3RXPncrk8dYh8lg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L1N9k7TPyXiWdxIUHAkBZfto3zNc3fGXX0KuBfM52PoGZXBd/wcbq1sN2shm/4Qjtg/0aNPxAh4pwENMg+rHIPf80g9vqoQsKoU93DwrabsoyNU4PEqtzWJneKV+QvZ4NfYjwO1vyjBwC0HdNMc+ggwirwaS4vWCaxLDeHu2qxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4Cv0JF+; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748468129; x=1780004129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6h3SuDdLez/zZVGv/8ClHaj3JGgo3RXPncrk8dYh8lg=;
  b=f4Cv0JF+a+zZc7tUZya9Kw+3B8oWYV5XSo+22CPR0JO9A57rnltXBZGG
   ccSGowgV+DirrKrlMYUIqmso6VOAlcRnX/A3nKLPJeBAoJs9LxUro+KR1
   CSdNSknPbJSWt4l4tPUKu81c1w+RflyrdAbk+75CczgYqd5kmYbnLlyB9
   YYbiqmxWkLCYPAYv97Lz2DqZJvy2SJmOB44n209XuGeNnihSHenaGFM8J
   R+/2Wm2y7nIBHOcTe8/gZYe4JaWccBSIs6WVDg92SbTZISXcJi/Kb0y0K
   1tzpOthMXgpU25WcEEgplhSg2wMnM2v5qGWxo7xgOSzHGg/cB+Hs7KzRL
   g==;
X-CSE-ConnectionGUID: 1S5N2sTkRVGSkA1zxo1d+A==
X-CSE-MsgGUID: yxi8wdbTSh6f/1BaK89zzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61865547"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="61865547"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 14:35:29 -0700
X-CSE-ConnectionGUID: ugKboVT8T0aAGqyGjPo35A==
X-CSE-MsgGUID: g7eQaQqZS1e/Kz+Y3iPzmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="166521992"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 14:35:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 14:35:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 14:35:27 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.87)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 14:35:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnDIw3nkr5fv2hm/4+oY/2xD6wOPYdVirPJNVqsaXJr7uptOQHzRg3Lpyxoak+jBL8FYSjyHQYhHkvZuAfaHCwhdbjpeMYzB1hUhY8HMvmhvQkdyh7IzcoemprXjsqOne+anTjVBng5UnNJblygsOoyTtLf32cJfTRZWH91vlxbqh4+tRdSZQl2cfXTAcAuGT/lXTWX/mgqNyQFAFj3eyQ/NCefAZbb4F7ZFco2a0LhaSGqi1Y0aLo6YlkLgccYnBgtm0UXFzpzcGsyzPpRD33TAlH4xj29A2U/VKnRGaEnrr1yzD7WEpZcPxsWcQ8jLl9T0Q69Qem6PPEG7v213wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9UrVaSDypkZbiuPtoyZz4KcsGeAcCXbzbmcVUhPgjM=;
 b=iWAp/JlvN8EpDJNtUR5WvfOjiEF/jnO6zWt0gJnbX2LK1oN5UK6EyiNIwztXn+wjkzaDyCmO/KnJgCV3h5MAcrKpjC1MBZLZbMcCdgqouaeWtekt7wEb58QMjvWjNX7YVY9rCMYP5KgK4gUUGoOufPi6ODb4MLJX+0KwKw6r9cxFomT7T0vz+cEemD6utgrMZm0ybTAzKBxiXYn7MYQ5iE0L5Hbp8CYCfGXFK27VGCveKwWhfQQo+xDCGN09B0QfeEjB3dlZ7UJDix4pHFOn5VmYByQvSEaa8Mhhv3kvj/8FDKFLEMtMeDKoc6d0/X7dSVBkgN2ok47HIIttT0I1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB6055.namprd11.prod.outlook.com (2603:10b6:510:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 21:35:23 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 21:35:20 +0000
From: "Hay, Joshua A" <joshua.a.hay@intel.com>
To: Simon Horman <horms@kernel.org>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [iwl-next 6/6] idpf: implement get LAN MMIO memory regions
Thread-Topic: [iwl-next 6/6] idpf: implement get LAN MMIO memory regions
Thread-Index: AQHbzAT8Yb0pSS1FwUi1w1y6NzBMMbPn4tWAgACrixA=
Date: Wed, 28 May 2025 21:35:04 +0000
Deferred-Delivery: Wed, 28 May 2025 21:32:35 +0000
Message-ID: <DM4PR11MB65022C4B91166794FE816CDDD467A@DM4PR11MB6502.namprd11.prod.outlook.com>
References: <20250523170435.668-1-tatyana.e.nikolova@intel.com>
 <20250523170435.668-7-tatyana.e.nikolova@intel.com>
 <20250528104407.GB365796@horms.kernel.org>
In-Reply-To: <20250528104407.GB365796@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6502:EE_|PH7PR11MB6055:EE_
x-ms-office365-filtering-correlation-id: b5dfc796-f064-41e8-1e49-08dd9e2f8c2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hVuuERj40A4pGftm0VjgjHYvuo/9rhF1CqAwMqDkbv1JonIVoQuJ6aO55ywC?=
 =?us-ascii?Q?5VId2Bgmzopsk1G4DhGcmLGbdoSb2zbM5qB7PiJVmvNeoS1/MuPeJ/v88PST?=
 =?us-ascii?Q?iuVou8j33PcdTaG+zflcyB9P3qcvS8QJsX/HAu7LIg6onVekAcT4G9GHIdBo?=
 =?us-ascii?Q?jSxwYElyjVljbN4kKy968J67zzXD6rBTB6sxp6Znj70vgf2Vzop2qDce33sg?=
 =?us-ascii?Q?RlKF4IwmZ0w3Y3tukRnkE5Pm4TsoGNCvsdIWGuwCxiZyEDbaPNCaSMv0HJZ+?=
 =?us-ascii?Q?rsn6Xq/STGLGY6amBk3WU6NYxhZxvDCTULhIVTC04N6Vhd6wGzlElLWQDbU1?=
 =?us-ascii?Q?umdcOhQX8BJK8dVvPLWG4VJa86f20BTQpqDcOvEhT+pylxux01XuiIk807KJ?=
 =?us-ascii?Q?upVXQQ3gASLfWx01Iqn7jyDXvqKYDbceD2/916mmCsXCVvyz/GT01Pc85/44?=
 =?us-ascii?Q?NB5/wezC9bayqnGY65E99RdJK6T+knJPsqELFpe/1g9ktl/8nAAW/6pw8hZc?=
 =?us-ascii?Q?w6zVhobaRXXakswJDJLOj+nuo1wPcAwbaoP58wcEVJwRQnCQvwX/udirDS9H?=
 =?us-ascii?Q?3ILue1qahpMnw496MJsB6S5Swp2j5yNPixKg2QeaUpXiHMt46KOUxAdTrCPm?=
 =?us-ascii?Q?lZKvQ6Ibhgzh8kf5dM9MbnyJogCiKUNjOYorkvNCEE5Epp6RPP9TcYJjgQHC?=
 =?us-ascii?Q?hAXVyZODR1jR1KIH046Iz0TK47UMaX9Ax6+Ra5mpO2FY8JLbE2eN7HdzpIBT?=
 =?us-ascii?Q?ws8nega3Z9hn6nWfI9sAZTcojo5nqL+49uo5C6Q73rpIEDqpmnzgymTmQQxw?=
 =?us-ascii?Q?0OdlRsogQ12V48ci8sbpnusPgf9ZZRo1Mrs6ELpywRf1tHYiOPBfdWYeRRnl?=
 =?us-ascii?Q?gpY3FBA6JVwOWTTXp3v4QEfXqaqOee8/GoCpUj0vzEzVvefi0RYrtePvXVkk?=
 =?us-ascii?Q?Cr6JjK4t68XyJatXdb9V+9/XkVcniF36SbsVPugAMaWykHxkh+CXVgsz7FC3?=
 =?us-ascii?Q?BmUS97ZJRFp83R0g6DyCTAC2PQ7G9Go+U7abXkD+tm+Jxpk/g542FrG72/AR?=
 =?us-ascii?Q?3LutQuG4TzH0QVjRQxTZCArOpb3y6YcbcoYLfylWGJIbW92m1tTw/eeUxgsZ?=
 =?us-ascii?Q?6Ik9KKLnvLWWwJbuXFeV4HCeQzzQE7rEw8ZX4d5ukGkSGsgxJ8I/IpP6ZpwI?=
 =?us-ascii?Q?rAa712V2K+Sfoq057G/QfwN90i/J44aJT+phSwn/zGHsIRxBmebHXG5OWgyL?=
 =?us-ascii?Q?slFMJqGsWCSgVEAeMH+TUsorTG1SBEbhVjiOFGTX5q9pvGKPflC8ksV5krYl?=
 =?us-ascii?Q?uwQc5YMbimVW5LcPWbvLYCaV7pkEo1cOJ7xwthbkeyd1yYTXFdUrvb7yh0O/?=
 =?us-ascii?Q?g4feRiQiLSiPbsoYURHBosKMxZ0NYpkB+3crgcY3IumNVPDWl4C9NNUE+eak?=
 =?us-ascii?Q?j3taW/nQKmSHNC+6Cw4kvYaibbutiB0AvpY4QTNVgP18EJX/7hFIKQz+XNNb?=
 =?us-ascii?Q?GjJdzRaHJJr182s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6502.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HYEGoFhhPljv+aFHw+RH01twYeGfNh/LhUIo9TPZFBWv0pq0nfmJkpQUyxbX?=
 =?us-ascii?Q?jaCXkjz9Qv3KbpT3K+4SvUdKl+1apZoewd3vppn/3KRvP7Y/S3buC4XeAOcV?=
 =?us-ascii?Q?BQaHLX1Lf4j5854jMfCvzMx7w0CwpkKU0HWIH1uwcXuGVaxylXRDPFcR9jBc?=
 =?us-ascii?Q?amXOJ3CmSJLqSMJ5k29kqO4Dzb2zOCq4gMdeRr94oMdozgpSR+ukbdtcOiSs?=
 =?us-ascii?Q?mi5jVpR+RTkAUgCGd78Dh785ib3QNvbXtTEQen0WvkXSl1HEdT5oP66nT/U/?=
 =?us-ascii?Q?7Z9Krc3chbbC2rSuwXDRB+GMfDCKUTRW78U+FAZyD9uduVvWGl0fJBjfl6sO?=
 =?us-ascii?Q?/XgakvO/Ug1TKSgdI2YxrZ2mzwLvHmptLfvAyjHWE5qXgcUDoSzmuYmSRyUx?=
 =?us-ascii?Q?OgbzhRH3WGWaAwlH6QnxG5uq8iLEetWmaURb1C+gi3iRaIHR19fbn/S3r/56?=
 =?us-ascii?Q?g2Hu/BaqEbu9lP+bIUZ4w8FOmAr6XOVrjjtEACZNcMzVG3XZrLKXBEbVNbpy?=
 =?us-ascii?Q?SmATCSClSYMjnIGzahKqFoUT131MVYx5hT6r90sHv1IUi90hZ0+DnCIZV6sW?=
 =?us-ascii?Q?+3wAG/ORpQ2PlZTxxHuQgT0cUkYHv9hMQ6jBAFW5mSUnhlFHGHQf919vlqFN?=
 =?us-ascii?Q?kcJSzr8xgzozL75gF1+I0dKl6XSCVbKYYF+6omMH+mEUz19LjFP5qJ0ABZbP?=
 =?us-ascii?Q?HpdXKiXbmfZVYBCrO0clzXfox7Cn55lJXOy3Iuipr8FqjSnjxwUn9hbNQ/fS?=
 =?us-ascii?Q?l7jPhfuYvnOhRt2vXbx5Uqo96/2dB9PLIeeMWNHV1sZslhZBlMnipIXrQtjQ?=
 =?us-ascii?Q?i1R77XPq9ZX5fB/bpIPFH+xCwHV6D9WUBPynIf+79iAVR3Y6iHU6889WExUD?=
 =?us-ascii?Q?h4VPwasGTiMwYSCkQUiwavBcNRrGGQEdReVQ17GgrgDlM+TD1fKzf8QgzhTA?=
 =?us-ascii?Q?Ccd/oFFo2CGN//PUJAcE0S1ZwBx1rTiG5se77yT4hlEwHhl61jLHu43Mxjjr?=
 =?us-ascii?Q?qzRX6fgFkqlZFhETQbozuUvfzN4Kf2CDOjE0YErDuysJxxNCMQcD+fpssyBv?=
 =?us-ascii?Q?XjOlWlF+MbNch+q0uW49FpFMfvzAL2OcZ77/3ebb6RaOLhsfGV2BXLuVsPhg?=
 =?us-ascii?Q?j2nsqLZxLXhRsnXkCxKheZ6FGvDwUY7jCGFrdGhnGI4IPpK1jODe9PIBbaVC?=
 =?us-ascii?Q?OFTncooBftUNiNvwj/HNga2/RI8U/oaMqy3N6XBOaK+IAFL8XBa9V/hU4+tn?=
 =?us-ascii?Q?s3udM6qrqoYTLwKBgpRGG3hnnUROG5GUtJSOpegGIkWH0yLEXIUfIr3Jyk8e?=
 =?us-ascii?Q?xz9nSQAbGqN2APd+LR50OB3dkJ94hmE+HJMh2ZxnCG+Dfx7T6vaH858HWbfR?=
 =?us-ascii?Q?hEd8JWViVy5F7C+ZAuwJ6oOjDP3zGek0IfJ7i7wWl48pNfp1rMR+M+z+r2Pa?=
 =?us-ascii?Q?mQER3093IJJy/11kaELPU8/wZYvlI4i+s5y03tFS/4+UeUN6PEeNL/cqfx6e?=
 =?us-ascii?Q?wUxj2R4nNzEBstzqKJb64S2ihHJccE5vZu57ieCBslRAJ9s37sWTWQeQr/uF?=
 =?us-ascii?Q?imU7vro6NCKOzNt0Ulf8RzmiDHmsEMAES1iyplgT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dfc796-f064-41e8-1e49-08dd9e2f8c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 21:35:19.7189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbQCz2n+74TR3NuNxVEleA76nT/A6ArZRZijJ8xcXy0r8LYeDlri9AY8E6RQqX76K8H5O0kFk9H5vT12MX5fFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6055
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Wednesday, May 28, 2025 3:44 AM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; jgg@nvidia.com; leon@kernel.org; li=
nux-
> rdma@vger.kernel.org; netdev@vger.kernel.org; kuba@kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>
> Subject: Re: [iwl-next 6/6] idpf: implement get LAN MMIO memory regions
>=20
> On Fri, May 23, 2025 at 12:04:35PM -0500, Tatyana Nikolova wrote:
> > From: Joshua Hay <joshua.a.hay@intel.com>
> >
> > The RDMA driver needs to map its own MMIO regions for the sake of
> > performance, meaning the IDPF needs to avoid mapping portions of the BA=
R
> > space. However, the IDPF cannot assume where these are and must avoid
> > mapping hard coded regions as much as possible.
> >
> > The IDPF maps the bare minimum to load and communicate with the
> > control plane, i.e., the mailbox registers and the reset state
> > registers. Because of how and when mailbox reigster offsets are
> > initialized, it is easier to adjust the existing defines to be relative
> > to the mailbox region starting address. Use a specific mailbox register
> > write function that uses these relative offsets. The reset state
> > register addresses are calculated the same way as for other registers,
> > described below.
> >
> > The IDPF then calls a new virtchnl op to fetch a list of MMIO regions
> > that it should map. The addresses for the registers in these regions ar=
e
> > calculated by determining what region the register resides in, adjustin=
g
> > the offset to be relative to that region, and then adding the
> > register's offset to that region's mapped address.
> >
> > If the new virtchnl op is not supported, the IDPF will fallback to
> > mapping the whole bar. However, it will still map them as separate
> > regions outside the mailbox and reset state registers. This way we can
> > use the same logic in both cases to access the MMIO space.
> >
> > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> b/drivers/net/ethernet/intel/idpf/idpf_idc.c
>=20
> ...
>=20
> > @@ -447,12 +469,15 @@ int idpf_idc_init_aux_core_dev(struct
> idpf_adapter *adapter,
> >   */
> >  void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info
> *cdev_info)
> >  {
> > +	struct iidc_rdma_priv_dev_info *privd =3D cdev_info->iidc_priv;
> > +
>=20
> Hi Joshua, Tatyana, all,
>=20
> On the line below it is assumed that cdev_info may be NULL.
> But on the line above cdev_info is unconditionally dereferenced.
> This doesn't seem consistent.
>=20
> Flagged by Smatch.

Right, that is a mistake. Will fix in v2.=20

Thanks,
Josh

>=20
> >  	if (!cdev_info)
> >  		return;
> >
> >  	idpf_unplug_aux_dev(cdev_info->adev);
> >
> > -	kfree(cdev_info->iidc_priv);
> > +	kfree(privd->mapped_mem_regions);
> > +	kfree(privd);
> >  	kfree(cdev_info);
> >  }
> >
>=20
> ...

