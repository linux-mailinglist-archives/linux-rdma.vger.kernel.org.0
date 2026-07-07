Return-Path: <linux-rdma+bounces-22837-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +UeNK/wNTWo3uQEAu9opvQ
	(envelope-from <linux-rdma+bounces-22837-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 16:32:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415571CA87
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 16:32:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=BvjKBCSc;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22837-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22837-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD9B630EFC32
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 14:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951CA423765;
	Tue,  7 Jul 2026 14:15:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8933ADAC;
	Tue,  7 Jul 2026 14:15:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433759; cv=fail; b=kuzwEN3yxUbZ9Or+stkM/kWKCvgegCjwl8rewHbJS8glhR2y4mmcRQ0BxmFBcntfUetQRXlmCKLRwQdpBimhbewZHfWl2L143eF80sFTn69OU+NTeNZd24Y3hlIEFUdzwoqQFp7S0GJ5+MAMxT9KMRFIqIXvnfdfJzUOEkn8dh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433759; c=relaxed/simple;
	bh=dS/yiVBnIaJSXtSBcWfsh0WWNACq1YwwFxmDrho8DY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fKcZfE3FPI/xYXq45eZDFJ64Ih5fwN88Mr20bt/Kf/Y0e9hROUGDys3OEqx3fdKhXNUjnn0/Gm6TAa5l5Mx0ZhrycuNRCNPpNDH9vMJl3TgK8DDk3AO5WIg6R8qi4kh3F7WDo5oimpn1kXAl1ZFChlVHHJtTLBBo6gU1qczfYjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvjKBCSc; arc=fail smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783433757; x=1814969757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dS/yiVBnIaJSXtSBcWfsh0WWNACq1YwwFxmDrho8DY4=;
  b=BvjKBCScLszYKHgD/yIEZE9+qKq4c4i7Lm88cBXCkN43xN6IFTq/udEW
   GCmqq1hNFdX8Kc0c9IhhfCG9ZkTBtzgxM+K8wEMlcohroYB2GVH4q+ZGY
   9uVvfXBVkxw7cR1tzrXpuqIo9UTU0nWEggAMCHldpqAOCYvGdjuDHfV3Q
   HJEpY5lTiyDjyQOUppsfPP1iC3V+uWX3IDn2SB8AkmGravhzLs2jLNYpZ
   CMmESJwJcFJ8yodBmOzlwEEvgkkQS62R5kDtRlTSF9rucUd/E0K6cldrV
   NqAeul12kl27kwo58FA1rNd44nfVz+T3tNi04OlwLLG6cDX015Cv2ZJIL
   w==;
X-CSE-ConnectionGUID: Wnp/4+r9SICTXG9oJTE7CA==
X-CSE-MsgGUID: /MiLGDuxQZuM2dg9Xpfnzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84200480"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84200480"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 07:15:56 -0700
X-CSE-ConnectionGUID: IrEs4ZaOT0u1aybNAwNiFA==
X-CSE-MsgGUID: SUsB0qcfSXSuGI1tY1Sy3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="249579632"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 07:15:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 07:15:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 07:15:55 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 07:15:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiiDU+xe5jMzZQy4lFHblCaGfGiPLtC63qulO/uJpMRAjwovKdEoHFBv20ac/BdZJ8GATZs9bj9APKvwqiKcDBQPA3tj5NFG5l+exPMW01Q1sTv/Rv7+y54poww2R4d8MfhduvFDEwByY62uJkOW4JNAwlLZW4rjYzW3MuEic5I1EYUwSnpXSScXTbKmvpXrNlo/GnJ5luZ4CDveCJBeKWoVvFPUvWKQrWZEZxWp7e6p85MsAmtiN0Dwn5u8y8nG62kVHVSfnKghUl6804xgZ51Nvn2f1Z+b67dncv6xCEXvEERsKM2r48zJRMkoMNJSaQr9UR9ZzoCEerwBoOOmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9SMYNLXNQehrPboeD87CaES2Gjzd8AYz0ggwch1GxE=;
 b=RjtDhwk6b8zsgYUgvZCsvGZ7B3VP1C0weWa6LNgKUuCYJn/212iaEGJE835ijRMgDKQc6jXizXRuApCyBmHccyMWseB1eqSDkYu3k27Wf+tz0eEl1Q0oEnaJjBPLhbpHeXDw5hT9zkBTHGXu0HskQZWAU71O9N0OTMC+LEiMMFimkRWW0tc4JXuFb0gmA3MchvqbJ1VPe6lUsxKwELd7DNWNYnaPkBfw28Qo1PPhRGMYv4hr0BDjg5maOQM3PvBwzw5DJN0Fs0qpoi0umM4Ae1eHjBDa2lyczrux15aWuBU1G0MgFlUy/85+dxQyKdoZwFMK1k3YDYYNe3CztAajhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PHXPR11MB9685.namprd11.prod.outlook.com (2603:10b6:510:3ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 7 Jul
 2026 14:15:53 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:15:52 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Boris Pismenny <borisp@nvidia.com>, Chris Mi <cmi@nvidia.com>, "Cosmin,
 Ratiu" <cratiu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Keller, Jacob
 E" <jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Stanislav Fomichev <sdf.kernel@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: RE: [PATCH net-next 03/15] net/mlx5e: psp: Remove unneeded ref
 counting for PSP steering
Thread-Topic: [PATCH net-next 03/15] net/mlx5e: psp: Remove unneeded ref
 counting for PSP steering
Thread-Index: AQHdDhIhYWqml6oMEkqLrBDtPcH6o7ZiGf3Q
Date: Tue, 7 Jul 2026 14:15:52 +0000
Message-ID: <IA3PR11MB8986BE0665111CF123CD4267E5F02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
 <20260707130858.969928-4-tariqt@nvidia.com>
In-Reply-To: <20260707130858.969928-4-tariqt@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PHXPR11MB9685:EE_
x-ms-office365-filtering-correlation-id: cc0d9567-5b2f-4609-7a83-08dedc3240e8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|38070700021|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: DTIiQWeOy5gUps17X9GyP56V66bwh6NAbXp5sMh7lfxVZGx+jfK+GWzP5j3qPNo0P56qJGi47Wp4GomV+rK3wAqZAVOSKsOOa3OwczCiy16oAnsoD9wuDKFdJ1eqdq0sHYBi4sue3hzcIeZw6cC8M5E1UU5RBq5yYqvIG1Srf+f86cujiAHCnKogkFMbwk2nb9Eao9f0pJB8LVjD40eng/2dqIJGG3DZzRAEspCALbs2KU/4IAEbRbcXSgxHerIcG1BxZSBY658bkutcLqHpNuWGLfkGKY4O2tECQeyFvEcJIJJdPZhTxYpZ7tUDWG+zmuCXrP6qThLQ04ECPZBv+iS2M2ZkqXAyixaiQicq5cR5g77ycoA65LsFyzwUXKQghHpLzbpjdkE+BOtjA4LfjBWaYQsAU2kG7I6zyF73dFD/l3D1nN/HhD5odnC1jTpNFdqLsPhc1cHwoiXOCQ9tOj0yeXoCfbhJ+wlG/VHQdayq2LBbaxTR724TYHRfVC9Vtm1J7kPEHODY7RRkO3iVn/1UD7tmelaco8Dx46JB+7HpWTVyt3tHYuisbls8JoqjoZICVM4z6gdw9/I4cSP2rCUkStPj92qsJt7pu5A8z3Ubfq+lv6RpuEV3YM4gItQF+4cB8mzUtCb7NEgcS2z70dy6T3h5PoJXDhv9Cb07IYMBg3X5+gfDxQa/f6kVsiN1RETlyQslOQsnGXhktgpPuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(38070700021)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B7r6q3Ev57mXw8rfCFYU942dSsXMsszx71SWSdoFY6zVaH58f1Cvy76J7gjM?=
 =?us-ascii?Q?OW3a7ADoB01K72QCLQGYQDVka9qvfWM0fVMfZrVDeiJQ/l0Pf+uDft27uahZ?=
 =?us-ascii?Q?ytZ/Y/lEuZc8/NFh2VNnx4LjD6fm81EYGcRmvh4nF3HyqWHZGOpTQbYdNCxV?=
 =?us-ascii?Q?8u00ZM/J3JTpXqeCfUsZcb8DX7ceXwnsSD+ahoXwFJHRoWdVBgJLjMfPZ7eY?=
 =?us-ascii?Q?YzuObOr/wVPcrwdnYCyinJpD9QkHEqqt1tTx8JVh9wyz+jXZoHU9KY8k1C/G?=
 =?us-ascii?Q?9RYfL0msLsKrTxYRUMNTjGAlWpQjSSxRC3qTKVtIkSI6RufK2imp6YmnA0kJ?=
 =?us-ascii?Q?N0C55+XpHb5dizA0yqp07Zc2AlWBTfsFBXCqZTOp5FSxZ5KbbaQO+SMUAw/Q?=
 =?us-ascii?Q?CKOTNUdKD0SPe2quGrr8DcxIN3nibWA5lfkbXnuzRhJ4PUzI/Sj7Qfv2xTeF?=
 =?us-ascii?Q?vt/t+Pnu39TKWrlmm1RJYWDzEKqcQaATiqJDHj4L14eyjqOiEm9VbYfV3y7G?=
 =?us-ascii?Q?D379OPv6TdeIUR20ny+CrbSO27TPuUTtgKtwlXQqvZol1jC0XK32+QTgh6xq?=
 =?us-ascii?Q?iTK5dVLsC5Vy+iBbdEtAnTACUrY3LvGHm4a01zoL5pbU49nuwGej/wV/UFXo?=
 =?us-ascii?Q?Hb0gFPEk6NAfRL9xfVPuvbIE7rVQph0nzk85xqkQvH4FlryFxkk6thF7yM3n?=
 =?us-ascii?Q?mX5f1aP6T9QlpA01tzys7gLQf7bqnFcWBeLYNnpTnu2BKEMKTWWRQ9hMZkw5?=
 =?us-ascii?Q?XffNiVD5CPKQmfJo+Gv9UVoTwSzTJhuB9ebww5ZBbASgTnWKEs9rG/7zUmGk?=
 =?us-ascii?Q?Hfd5yDkMOMPetBha5EyL7tuhH0GOQnpuqc9DcbZYR55FTIz0hMUDOcfMzff6?=
 =?us-ascii?Q?W5bKqDir/VCOumGXN1pKIP3TVyhKuM3OAPJrvM+M9rGDNu/XPdYOtESOOU+4?=
 =?us-ascii?Q?L48QXQW5zPTJESSYHHdTg0Ul/R1yWSaBJSNz8DJwTCKiznQxUOZFMsY5uFpo?=
 =?us-ascii?Q?55a4VL8znt4uv7kTp43frNqrIEP6+OZ+XBD5VytFBzm9zpkd+utbX8Xmp/Ih?=
 =?us-ascii?Q?ep3jZCaPVmMrHGXCLE7FoDOHtJP6cMJt+LQv091lpheO2g6FkWeRN7LYwq8K?=
 =?us-ascii?Q?pY6S4L7IE62GvXsA7C3TqRl/X1mtV5jnbTBrQSGlyCwFumxWRryorGs2cI7g?=
 =?us-ascii?Q?SuRKqQryrc9dEELZ95JgBRpHNhMgXaBSUpQniYRVGLOziK+e8nC8ZqHg8a4X?=
 =?us-ascii?Q?xfJXJpWa+xx9sBVbtB2rs0rVrfoRTP1RNdLONP2oJXl0qFxgiwE+7/8KaF+x?=
 =?us-ascii?Q?CH0j1OyuVTv8YsE4eOZ7cKjUrpMJ22hqoA3XJoAvW2Fm/dg0h/aV+cnSo1+A?=
 =?us-ascii?Q?GIcn4i1if7bMvoNVFDH5WqLQUyNGEcQH/sGYbgfRJyho96ELZHBs9ef0aLKk?=
 =?us-ascii?Q?aoXJ0A31Kqj2JsTp6Sphol6gkVOMZJ0jZQ8Nm8+7qbva5xwP0Pul4ozbV/Zr?=
 =?us-ascii?Q?34DHGY4knVp51cng0nqwfuyxq520egrM/Pm2NsmlhisDPdsKox2IIF1JUbav?=
 =?us-ascii?Q?sYhGdo/iha3saEK3KbmeRFYDp0Rcvi2RLazakyUee4CJEB8TQc5FotuwfVOz?=
 =?us-ascii?Q?a24RHqoLchqJB8URafxU7JrhH1DId5ngEF75jJGx/MVeOYGFvbM+fR13uo1E?=
 =?us-ascii?Q?II4y0TBHrHVo5ab6EeEzjIPrcNzyG42icUCNxcF7xjpWEg/pZWMSI2uK6ggF?=
 =?us-ascii?Q?+hKjv+dBvEhGPYpZ3ARE4Z4uXu6h+Ok=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MBpuJOZ9pIFHXWTXleIhvLwv2bIAEFl2Y5M47LxUla4+LN3+18iR97AXS3Kz0bN93ynecpyNDHuZFzsUAqtDadgWGEdAjaCLiu6OdJep1GOwObNqLWQvgQbGHuJBMRm1sCXooaeyMMjDGBqUaq4Hku0oZx2SpwjvyPtwKaIQQMi6Q5DpfmWW8kpBQRFFtAAP5S4mf3nb5H/7wsydxryvqRDFk2axJPa6cpTyfRQyg/sj918TwNFTj48W802OqIhKE5YWMuOfTGsvxqOdKJclwzRaayyPv3lJzN/14xHQ6338rI0jqpeqHTHHolDufBrmvyzTMofxxroaFRf98fqOPw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0d9567-5b2f-4609-7a83-08dedc3240e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 14:15:52.8230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqhgR+qaFkd/b5C1nYqXC/VB9mlx5yBuXU51zQO0a4AOVNcQEIoBTmTW1f/taVoKhr71J/s/6k8S4gFb9NtuWzJ0yxO7H4nxcBpOO2gBoz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9685
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22837-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,intel.com,kernel.org,vger.kernel.org,fomichev.me];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6415571CA87



> -----Original Message-----
> From: Tariq Toukan <tariqt@nvidia.com>
> Sent: Tuesday, July 7, 2026 3:09 PM
> To: Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; netdev@vger.kernel.org; Paolo Abeni
> <pabeni@redhat.com>
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Boris
> Pismenny <borisp@nvidia.com>; Chris Mi <cmi@nvidia.com>; Cosmin, Ratiu
> <cratiu@nvidia.com>; Daniel Zahka <daniel.zahka@gmail.com>; Dragos
> Tatulea <dtatulea@nvidia.com>; Gal Pressman <gal@nvidia.com>; Keller,
> Jacob E <jacob.e.keller@intel.com>; Jianbo Liu <jianbol@nvidia.com>;
> Lama Kayal <lkayal@nvidia.com>; Leon Romanovsky <leon@kernel.org>;
> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Mark Bloch
> <mbloch@nvidia.com>; Raed Salem <raeds@nvidia.com>; Rahul Rameshbabu
> <rrameshbabu@nvidia.com>; Saeed Mahameed <saeedm@nvidia.com>;
> Stanislav Fomichev <sdf@fomichev.me>; Stanislav Fomichev
> <sdf.kernel@gmail.com>; Tariq Toukan <tariqt@nvidia.com>; Willem de
> Bruijn <willemdebruijn.kernel@gmail.com>
> Subject: [PATCH net-next 03/15] net/mlx5e: psp: Remove unneeded ref
> counting for PSP steering
>=20
> From: Cosmin Ratiu <cratiu@nvidia.com>
>=20
> PSP steering uses reference counting for TX and RX steering tables,
> but there's only a single reference for each acquired and thus the
> reference counting is unnecessary.
>=20
> Remove it and consolidate functions to simplify the code.
>=20
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/en_accel/psp.c         | 129 +++++------------
> -
>  1 file changed, 33 insertions(+), 96 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> index d4686b5af776..a69c4e2821e9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> @@ -26,7 +26,6 @@ struct mlx5e_psp_tx {
>  	struct mlx5_flow_table *ft;
>  	struct mlx5_flow_group *fg;
>  	struct mlx5_flow_handle *rule;

...

>  }
>=20
>  static void mlx5e_accel_psp_fs_cleanup(struct mlx5e_psp_fs *fs)
> --
> 2.44.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

