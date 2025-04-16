Return-Path: <linux-rdma+bounces-9483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C56A8B9BE
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 15:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC9B188AEF9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15736F53E;
	Wed, 16 Apr 2025 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhFV42cp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19132F56;
	Wed, 16 Apr 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744808483; cv=fail; b=j0aG77HNhBisdu65B2L22rqHVWZROYnPVXrpPZzKiqU0T/kcCN0FXfk1QMSqaG8YZOfOwSCi8Q6hLa6uKhcUHFuK6TweqKYYCua5QLxvr+r9xudOSHVJ1qcRcbSpMO993S0OfCFBANDl8tK5glHiXhGzRiaiYQCkIUlAd6Vd/Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744808483; c=relaxed/simple;
	bh=TumuOi874nDbpX1lI27qUZfZ5llz2MoRabZ8uydlNec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p1RVt4+Qbwm4nlgYz7sLyIgpEfjG9bmHKU/CofnmIhNW0d/AMRAPrxfQ28Ew6sRw6u2qj3MMEoidl6xeiiNsOxs8O6p2aDph0t3HgN99EjViYSLrphmJfFx6R04lquztpOvnM5seUjNdjlr8Yl7vuMK4xn4hKTutvRJw7Pv4UIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhFV42cp; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744808481; x=1776344481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TumuOi874nDbpX1lI27qUZfZ5llz2MoRabZ8uydlNec=;
  b=lhFV42cpYpf52puPCovKN4UXCxM0t9DnKmSBkJ4IA/1Uq479JoUdhEYA
   PoNikaQxvCe8P+Adz2/rLDBVN/U8BVJVb5mbINZPkIwN/seE0V/3FL53t
   HqHXdah8QKS1Y+gQYRZOdEwRMm4uWWwyF+QhGR/Ch16FTWzkdAHzwizCc
   l4xW8+cBdi8M+1s0OJ0cGwOntzaaCEODgk6DzEKKpY8zAhdA4CcXFmBH8
   ++CYdkQ3uT50scjDojmnpbi/Mq3wXTmeTvXL8yy3seunoIZN+fWWrGzCq
   w4wM1t6ZOXkaL6ay+aXBgJ1gBY0po3En/kcIaHeu72bZjDGQr0JqASyKl
   Q==;
X-CSE-ConnectionGUID: 99BXh4pnT8q/x+KqVt7e6A==
X-CSE-MsgGUID: s30KIfowSeunTzcdL6Je5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="33970865"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="33970865"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 06:01:19 -0700
X-CSE-ConnectionGUID: iukJdbBvS3mt//V1BwD1JQ==
X-CSE-MsgGUID: zVUA+kLWQdazgVup/P2LOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="130779295"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 06:01:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 06:01:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 06:01:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 06:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SR6yNH28f5UsRl78dtBJzdFqs1hkjSxfhnKQoYkpZjNuU693HEuyQHrJh068Vnl+vb29YKZmTBAYEFsY12ANmHkhz/Izr0cZjjgb+jL10gZwJeDE0k3rYZJ7bxbBfWXlhJE55dtnUzo3rCJMq+Od40Nlh0yuh8bT8SCMn2axvq7IdSy2o5CjkM+cm3M61pg6y1skn/X0IFxD5pLCB8UsPpF/cNIghodsWBTOQ4y+LBcfuopYBOQkhuuhh7ejFwk3jiYjkw1Kn9ohi9ylvPzu3Ht7apAe4gtKtf0TPHGtCj4icVYpOdSO9SmxzuEzAftJp4QwQC4+f5QgazTC71D/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxJahgqPFLzMydpW/e0AA4h5LfmuYzjKj8sSZixgPs4=;
 b=d4lQEPxCwLpg2emjJtbAqyAWdnFIjuS2Y+qkPw1frYeww9Wk0FqOt3Z+GrrvsnqKB+d5kwxzWQtkCWVi6rQbhOGL8VcrhahuvipGWscOB+gd1+tWma/FBbqKgvH/UEW8sGxJ4+A0R5RtIILu0CZs762btC/O0/6kBDmQ5PZtsBi6UhtqcBcVeQFyA7yjnGABKtpj7D3dCA4wpDBP3e4xf17kL/htHcL1eOgVO20jUZL6cj1f8g7t+XhFY5JLmorxY4Yps4Emtn8rLYYyUcbv9B3GA/Iz/Vxy8UmdEHCirpCwSR9IKv8lby3thttNvqGO/IDvnyAE+LTTL57j/bhlhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by IA1PR11MB8100.namprd11.prod.outlook.com (2603:10b6:208:445::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 13:01:11 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%5]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 13:01:11 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "Dumazet,
 Eric" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v1 0/3] dpll: add ref-sync pins feature
Thread-Topic: [PATCH net-next v1 0/3] dpll: add ref-sync pins feature
Thread-Index: AQHbrqdaVgt+WIaD1k2hT63HVyuLV7OmNVnw
Date: Wed, 16 Apr 2025 13:01:11 +0000
Message-ID: <SJ2PR11MB8452F78213CB1A405B1E72C09BBD2@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250415175115.1066641-1-arkadiusz.kubalewski@intel.com>
 <6ss5qghishcbbbmj6ifitafl6fnbfhnw6crrkitgunays4qtqv@ixvlqemyij6x>
In-Reply-To: <6ss5qghishcbbbmj6ifitafl6fnbfhnw6crrkitgunays4qtqv@ixvlqemyij6x>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|IA1PR11MB8100:EE_
x-ms-office365-filtering-correlation-id: c569cab2-482c-47fa-4dc1-08dd7ce6c341
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JNpaT/ke1GqqGIDyAE/vlKOUJ9K22na7AIUvuZUp/Q1ZAkvxTTX+45ZF97hW?=
 =?us-ascii?Q?Q2k9BLoS6/WIWF6rp9YEJFn+VuiwxVBguQ6Vo3R91MNqf65dkyc3GNJQuTBH?=
 =?us-ascii?Q?3UPxSyYnhCXSFfkbDfMo3Pq4LSZDIsW4Qt9kavolzHd6AL0Cca6PfnvU92ZL?=
 =?us-ascii?Q?Wx6cXO9EIPZTo8daOHglY0T7fDQdmd+L6lR3XXXczuMwBYQN8tWpB8Q95mwe?=
 =?us-ascii?Q?5R954/DtA6EO+rtGvLBD60VHBMuTk5GnODlQwKPTHgvaK4ptWnUHe04AQQR8?=
 =?us-ascii?Q?8CNCPQwy/NhfV9pxrLB8d5Zl6UjtdwB/1RTM/QyOmIy76mSySprT8AetEc2X?=
 =?us-ascii?Q?FplmK0YLHek/vzAcj6Af2A7DpV2+RryGoIV42uvRCwhkD8WsIbnkI6kF3xXz?=
 =?us-ascii?Q?S+IwnwLBEfJATCeysjnBdYcfiuOp7+AisVW8EhkMm6J71aM3DenXA6akibyt?=
 =?us-ascii?Q?kiR86dZ4cYU0TWsb4v//Q0NYAdL2enkTy7wjtG5GRJGPZwFbgmHy9/rV4k1X?=
 =?us-ascii?Q?7t+c8rTeXsTgqgSih8tTU9Zn1f0hISXm021D8gB6jBWuDuFZb0f3l2nGYPjM?=
 =?us-ascii?Q?ucg+sYuCQPmhgklGGC8rC+DRR6QHAZR42s1CuEca0+yjkPVCThUVpuiROddZ?=
 =?us-ascii?Q?duexrpsnk3t95pGBs5YaM3FA0EUZRp7PHU3zkeffMHqple2pI0KNNR77d3lg?=
 =?us-ascii?Q?T7/D/qUr4em2qy8vgnhNLjV6Ckt4RWge8GWm8TOqC1Fx8xc/o9IHFQe4azyh?=
 =?us-ascii?Q?eC/8xmvnpRjc1V0cF8aSxx6H/7GcIVuWewnJpV8MNmQGpZMyt+7CwXsL5G/5?=
 =?us-ascii?Q?Ei/qXm2PKktkFdaM+hiktYq+xB6LaCQqhEE+CH3PxOdYhIRP39sPiE8cJU+7?=
 =?us-ascii?Q?X6D0YpPWhj76Ksc6v+tN7gS6Bitm7/7tUtKvuKYWlLdffHGjtm4/hZ5E64NO?=
 =?us-ascii?Q?SZAxy1QKpErePw2n2tHwqs8u0Eg/Sv49p6d4HHP+LtXOCdP5NTx7MLS2nmNJ?=
 =?us-ascii?Q?KToGSUwoCx3zVor5SuHlCNBzxKfZdz3NFZhe4Shn/7mqrhgSE3IrI1+o4IoA?=
 =?us-ascii?Q?oFqLh5lmvlRxVm81XH3ktFy4zAVDXZeDlCnfEHkjd2yLoPtvrHi7V6W53ds3?=
 =?us-ascii?Q?TJkaJ5HnOQHQXfjEh/KdV2X3C1qsTxsYWIbqPi35cvulECCW371jm9jC0flz?=
 =?us-ascii?Q?k1Gy/T5S9ZKJyJH5w+1WAT512MLD51jtstL7oDC2JfRmznVOldMQvumsMUxl?=
 =?us-ascii?Q?F9fSOAEkt2VsevG2EDJotKrZsuWZm2+3zOCtxYZXQB4BczwJ5z6OWY6+WMeB?=
 =?us-ascii?Q?8T4LhLw+86Ul+F698YT74CD+Ra7Zk+hvxTML3q2H7LsWpTKxyP8gbNcnFQ3A?=
 =?us-ascii?Q?hjw7HDymfcpidS8lmj4+Bx9vy12JOq+f5e0k6O7Yv+LU3902qSn+j9V0LPzU?=
 =?us-ascii?Q?cyF+kG5rutM5a7R7TQoARA007ecuQYsFp1kHTH3NN3f53+7aGF25bg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zh/ZwBDJZnqV69Z6XeZucJBCvxe+23JJehpYVwkuMpkbE7xRlzGMHkWZjM1k?=
 =?us-ascii?Q?w7Gs6U7aOMeE/Y0xu1WOXwPBVP4E4rNBwWrGgEsQS5/YmeS00g7epjSayfW5?=
 =?us-ascii?Q?Dm2Onhl8FK6LxBtpUPNCjFoIeDVIGi9mnAFAS7lG9ioWOOYzqv61/vB5NVWP?=
 =?us-ascii?Q?pgeVD+P54UregWYRLt8V7QtD9mRwSxeEGJUhx+pqB9jASDfZ2wcCXl4GbSr5?=
 =?us-ascii?Q?ietLt5IvqEWTz5DWcQMw64VcVNYUTX694LRjfMG6cxNwUia4TqKouK6i7LYT?=
 =?us-ascii?Q?vHOuMFpE6dcQFifWBHKB0vnSmBBhsHVrrVczdiIssTrKL0JQ/H2a+F0azIXT?=
 =?us-ascii?Q?+8VAxJOm4Y0yVTNYumwHY+xldyCroQrNNuCfjBX8rl3ynhpMGURiJQpvQUp6?=
 =?us-ascii?Q?hs5S4EjzHtSn6BF76sRLkmNHA9U3J7ZZLiimN4AhVTwT+bvMjvOqnSJs1Aw/?=
 =?us-ascii?Q?kNYLwA2VXJoOMo426gaWy7+Mv0yFVGGePeBg5Aett7plp/KX1l2WTbEjN+NY?=
 =?us-ascii?Q?h6gr0YDUnil72PWQozfArf4Lrjf6FkwkOFGsK3/11SRPqqrQ74+ka4rAWAXX?=
 =?us-ascii?Q?KPZYbUjbWEjxaprOnL8aifb8vh7IOvtU2lX9CzAi1ukKeSkus8DWGLMw5E24?=
 =?us-ascii?Q?mXAD35fot8lG0DCN90PBWHDpPIKGQV4fAXlBkxmnhDql0Uv0/B7bmqaT7baZ?=
 =?us-ascii?Q?uyEmLJpY88xAl783f8mVRJeLfiIopAx13HgL+IMKKbjKoJfIktSMPLXink3M?=
 =?us-ascii?Q?igp23SjQcqRgcMOTcRjBO42WYGo0TLsNdX+BM+fJiaGH9folVbYDHK3JQH2j?=
 =?us-ascii?Q?YouGHXlwB7PaV3JMxOx+5/Ts+dG6j2ERPiOR4f6XwFRcR2UfuKadDQsKTrnB?=
 =?us-ascii?Q?msRq+ojGJeWgeBan/MCTWZTufhmj1Nyhp1JGkV7G+IdtASwj4Wwy1WN//o4H?=
 =?us-ascii?Q?HP5bqVtkRQXUaSLnrznVmBQp6JAAc2iP278hkPdyp5ZWqFN3F/OIcWCwObuz?=
 =?us-ascii?Q?1AVWm1WBzXYFtUiaBrbgTt1/QGDdgCX4gjWlfg+6zpqh2qjdJv+WCjj763Wg?=
 =?us-ascii?Q?hfTpdTo7ERRsNAA8v+5euOKmUKafvxAUP1ja8tgzr0grnO2AkeP3kqJZQLRr?=
 =?us-ascii?Q?rFkeeeY4HqR0UYOR3loir7m5feFcZHUe/dh5eb6JFskAQvuINW9iGnLnAR/c?=
 =?us-ascii?Q?jN+zrZ5jYKgubENmRO2yLzGuvACPOYkdoLg6rGhthVXQCQCFVln9nh6sHd2B?=
 =?us-ascii?Q?TKJg2FH8yPyJK8yl0RS218A1ixdiRG31I6CydpNZSX14kIT7mJYLiUGfXlmO?=
 =?us-ascii?Q?kt5p5eAXA9ERsOBzjbMCTg3wOf7Pu2Jar3zPWKi/C2cpSNnPpZLwAiYdu7xv?=
 =?us-ascii?Q?CWIKK5AcvG3rymuYDBQnnIsiY6FssmsaZ6Qg/DLF9JBHPYe6TmiGZFbgwvY9?=
 =?us-ascii?Q?Dk57u17AoIdJATZLjIH16SiSiL8QTQzM5YO3PMwu+0AG9rGI2/1V4nwqxa0c?=
 =?us-ascii?Q?cHH749eCEJiWY94G+iRjGZ+EbUCOD0uEdkqNYsvQLIn4jeqfw9sQhAWcpI4m?=
 =?us-ascii?Q?SaISL1jL0qGVOj+p+3VumHQtRVBX90H/59VX8pjekEpe+urBdfkLZZ+e5eN9?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8452.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c569cab2-482c-47fa-4dc1-08dd7ce6c341
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 13:01:11.6546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKZdZIwbL3l7k9p2VVoafL8nXviSmaZppWsaNsWIpJ6V9jjQMzHypglo+RvmtE3snNFzf/KcKEvWvghVXYpKJRMmN8HDaw7AmxcMJaWXTOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8100
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, April 16, 2025 10:12 AM
>
>Tue, Apr 15, 2025 at 07:51:12PM +0200, arkadiusz.kubalewski@intel.com
>wrote:
>>Allow to bind two pins and become a single source of clock signal, where
>>first of the pins is carring the base frequency and second provides SYNC
>>pulses.
>
>This is not enough. Could you please provide more details about this.
>Motivation is needed. Also, from the examples below looks like you allow
>to bind 2 pins, in async way. Would make sense to bind more than 2 pins
>together?
>

Sure, will try.

It would be possible to have a single pin to be able to create a reference
sync pair with multiple pins (strictly depends on HW), but only one at the
time can be active. Thus rebinding to a new one shall unbind from previous.

>Honestly, I don't understand what this is about.
>

Most basic explanation would be that this feature is similar to Embedded
Sync feature, where single signal carrier is used to pass both base
frequency and SYNC signal.
With Reference-SYNC two input pins are tied together to create a kind of
Embedded Sync signal (from dpll device perspective), where dpll device is
able to use both higher (base) and lower (SYNC) frequency signals for its
operation.

AFAIK the base frequency signal in this case is used for dpll's loop
bandwidth. The lower (SYNC) frequency is used to actually syntonize to.
This is mainly cost saving as the higher quality XO (i.e. TCXO/OCXO) signal
can be provided externally and board could use low-cost XO.

Will try to include some additional explanations on this for next version.

Thank you!
Arkadiusz

>
>>
>>Verify pins bind state/capabilities:
>>$ ./tools/net/ynl/pyynl/cli.py \
>> --spec Documentation/netlink/specs/dpll.yaml \
>> --do pin-get \
>> --json '{"id":0}'
>>{'board-label': 'CVL-SDP22',
>> 'id': 0,
>> [...]
>> 'reference-sync': [{'id': 1, 'state': 'disconnected'}],
>> [...]}
>>
>>Bind the pins by setting connected state between them:
>>$ ./tools/net/ynl/pyynl/cli.py \
>> --spec Documentation/netlink/specs/dpll.yaml \
>> --do pin-set \
>> --json '{"id":0, "reference-sync":{"id":1, "state":"connected"}}'
>>
>>Verify pins bind state:
>>$ ./tools/net/ynl/pyynl/cli.py \
>> --spec Documentation/netlink/specs/dpll.yaml \
>> --do pin-get \
>> --json '{"id":0}'
>>{'board-label': 'CVL-SDP22',
>> 'id': 0,
>> [...]
>> 'reference-sync': [{'id': 1, 'state': 'connected'}],
>> [...]}
>>
>>Unbind the pins by setting disconnected state between them:
>>$ ./tools/net/ynl/pyynl/cli.py \
>> --spec Documentation/netlink/specs/dpll.yaml \
>> --do pin-set \
>> --json '{"id":0, "reference-sync":{"id":1, "state":"disconnected"}}'
>>
>>
>>Arkadiusz Kubalewski (3):
>>  dpll: add reference-sync netlink attribute
>>  dpll: add reference sync get/set
>>  ice: add ref-sync dpll pins
>>
>> Documentation/netlink/specs/dpll.yaml         |  19 ++
>> drivers/dpll/dpll_core.c                      |  27 +++
>> drivers/dpll/dpll_core.h                      |   1 +
>> drivers/dpll/dpll_netlink.c                   | 188 ++++++++++++++++--
>> drivers/dpll/dpll_nl.c                        |  10 +-
>> drivers/dpll/dpll_nl.h                        |   1 +
>> .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
>> drivers/net/ethernet/intel/ice/ice_dpll.c     | 186 +++++++++++++++++
>> include/linux/dpll.h                          |  10 +
>> include/uapi/linux/dpll.h                     |   1 +
>> 10 files changed, 425 insertions(+), 20 deletions(-)
>>
>>
>>base-commit: 420aabef3ab5fa743afb4d3d391f03ef0e777ca8
>>--
>>2.38.1
>>


