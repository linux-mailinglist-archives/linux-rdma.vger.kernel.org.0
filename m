Return-Path: <linux-rdma+bounces-15686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B8D3A09F
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 08:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC32F3045DCB
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 07:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61263382C4;
	Mon, 19 Jan 2026 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyY95RXH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8F2DEA95;
	Mon, 19 Jan 2026 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808994; cv=fail; b=snlVLUsqMbdRCfgDfRvFVwU5WMq8R5sTFe6+PqX2SI66+29jL65LSEHhwi8UPLasHU0WFldU+NGJ0BXqqib9yi+w/osFL2zeY/HfZjTjQGaViVSqMHzJ9v57hlbT7r2lspTBGMJumz80GXI0ilJYcGAfkLR7L7Fi/Ql9jRr+PoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808994; c=relaxed/simple;
	bh=V0V89s73pBXrugzr9SJCaD9UROLU9eC7eugBpwGwwmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ag2MvLVgNYIJtGVpMx7VIz6VDP0WtEcVLqgGS78HxYERI+6VU4HeJ275Cmpa28/D/AayB4lH3cHEQ/G0/TVNm3P+ki5VNWNQ4doXf7RdB/ULFQyArbAyuboYIdlUnH2IZjGAYjj7TfpYc309WzN1DdilM/WAc/mq9bLj/NQAMXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyY95RXH; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768808992; x=1800344992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V0V89s73pBXrugzr9SJCaD9UROLU9eC7eugBpwGwwmU=;
  b=EyY95RXHcjyd2xEP5IBUI75AmY5ziPIVvWELxxjZ//64K9Eibf9sRYCF
   dTjkUcjiPryD/2lg/D79Nocd32D91aD7YreKGxQjyJpNEAMJGSl5+cZ4q
   urULBszQuTGIrKqq3GoghTUDxoTa3DBwIZ5eRrDUTpIeCi0jk4zBNVmpY
   K3eSO2m9I+HBe0rHvbdV+PvSK8aQD8RAJidVD1yCEb7UaCrMqAW7VJULb
   +76ihQiO843p3SnNHdxpgoaCnNYs43yQvDRDyjQ6WbJttO/U2GZjN6IKm
   qwdacXzMnJwvkyPp+qXC1wyjnJfGLu2oyiGN43nmfHLnfLv3zI3/Df09S
   g==;
X-CSE-ConnectionGUID: iJyFPouBTDOb1DJOGK0FmA==
X-CSE-MsgGUID: nMqB7b9FRX2MIIG/RF39Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69916920"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="69916920"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:49:52 -0800
X-CSE-ConnectionGUID: R5q28MhbQ3WwGlyaRA/Thg==
X-CSE-MsgGUID: NlFImY6XTVSJxW5TFwgd/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205416915"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:49:51 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 18 Jan 2026 23:49:51 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 18 Jan 2026 23:49:51 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 18 Jan 2026 23:49:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlI2SmXOHjPIjJByxqTQS04kppRKGhQfMiuh+pkyk3iWxjTVd3fSNoGxnavsKeWetxWLM4fd2kj4TMvOwDeFp50TUoWrT6TykuHDXVVC94IfWIYqS1I0/QbsgWbhFFTmdSzMWTCJiCtJRir/U1/Tr3KEIskF4bd+pbwvQGvBj43fLfpwPl8ox8VdiH3huGUzqO28KcGcfGjmgeAceQaS4JkuSoIqJp9hPLcmdxLTq4brBH16+jRB+Unid4N/lY02a0tqMnD9mAD0eNMB6chaWhLm2LdeETEKeEdFHUBdgHL+2D3148aCNbpY1Radedja3HtGczfxPeHyXH5v8NeHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG+shXP6HnMqtrJvafbH/Y5tyGKE9x65PQucipW6JJM=;
 b=KH77UgMGg1EsNJekUiRPz3sNL1w6HiAC0rkNLYUFuiw5dYFsRwfoSL5nGa89DEuagPxGyuuDEK9CaS/6SNcnohZemdlnDN9tZyPFs0ektqc5Iv+jUtT3przFn/s7+Y+kzwseQfEdF3dsx5PeDtvp5bIQBn3kAqWFV5it9Qf6nZoyMz+OC90/LRGY5aKXTNdEjTb6+Ud1Vnu2s7iHTI31JEQgIO4IsP6GDJCuzg+HO2rCzJVYiwd2kg0vpRQF9Lu9X+H1gNzeh6bRt+6oXcg7Yk5IIwgcRZB5umOpyipTlLZ+HLRVeo2diofoo+AaIICPtrGqNuEEyMLoexWDyyyFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4813.namprd11.prod.outlook.com (2603:10b6:a03:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Mon, 19 Jan
 2026 07:49:48 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 07:49:48 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Rob Herring <robh@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Richard Cochran <richardcochran@gmail.com>, "Saravana
 Kannan" <saravanak@kernel.org>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mark Bloch <mbloch@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jonathan Lemon <jonathan.lemon@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 04/12] dpll: zl3073x:
 Associate pin with fwnode handle
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 04/12] dpll: zl3073x:
 Associate pin with fwnode handle
Thread-Index: AQHchxiTg+0wzSscC0ySLY3lALMlHLVZIh2A
Date: Mon, 19 Jan 2026 07:49:48 +0000
Message-ID: <IA3PR11MB89869B15A3F6D2599F1329A4E588A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260116184610.147591-1-ivecera@redhat.com>
 <20260116184610.147591-5-ivecera@redhat.com>
In-Reply-To: <20260116184610.147591-5-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4813:EE_
x-ms-office365-filtering-correlation-id: 1a288bcc-d50e-4f3d-fcab-08de572f5207
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?7G7Jj1/eRJ9Zxp1IckHKKDkTHIf1JvTKYg3JeEbMHBTXijcsbmk1xPwfMvoP?=
 =?us-ascii?Q?KXsBlyQ7ZKJnYJ3bT8/VigmJtZqdXP9aiq7D/vRZzjLTzbnw3r6TnCqbyBJ6?=
 =?us-ascii?Q?dS/yvr/4hnrlqfXkYnDMVT/XzXs9jWogoI06nPFz3IVHRKcbkUy0/nm5ni1j?=
 =?us-ascii?Q?Rbn+RenI1GOq1QsQg/J0jIR++tgARJHSfw5Y8xjJ2BOi5q/+6HBQpEajPUud?=
 =?us-ascii?Q?fcf08wztJc85SE//ayJXXpwDJts3VTEeNOq4Wd4fHVqGotkS7DyU0IHHA08/?=
 =?us-ascii?Q?D/wa96OkgvGmIyh3gE1T2n1yZhxk0hCiY6eZ0EL5g+JzzbNyMfI4xfEZKQ7/?=
 =?us-ascii?Q?tlDt2vNnWfCL/XBdWO3Jez60uD/lJbwDH3C/W84ZSP4r1iNnwsRHNmb3YcSd?=
 =?us-ascii?Q?IFxWSA/9iuuyrWyf+5jUctTOkTP8aowyBVnigQ0mEP/NVw40zwF1BrCwU3r6?=
 =?us-ascii?Q?czLthREA9lzQ2oNR+whQmiwZJ2IKvm8Sx0aezSfNE/R97aRd+f7lk7REtP+s?=
 =?us-ascii?Q?lYFgE5thjM84Ss13Awg5gpllFt5yIjSxSnHU3aYdVQawiqW6VEYcB4/58yUs?=
 =?us-ascii?Q?qeU9wz3xDq/PNqUo6ny3+JRbgNWCevQ3NVrRvjHt6+oog6IX+pchRTfakXe9?=
 =?us-ascii?Q?VCZUPujq0lIbD5I55ehmxjQkvhaSo6Z6mF+/cj5dMLjnx3R+tetniPIPnPIY?=
 =?us-ascii?Q?NmM9vsX/jF58/mqIcWA3VQZSuDnlMcdpz0BQ9/n64d2p+WEt3HPLC1H5mNWT?=
 =?us-ascii?Q?sPIu/rwHpxod9JWmWa27fo0657iHEU5Q+X2iPKyiT785vcftWcyZ8Cxu9MpF?=
 =?us-ascii?Q?WM/36Hh1kXGAe4cImjCqfmPQs/YjKLL7EGsItQmizVSo/4PRfLU+1SGv/XLu?=
 =?us-ascii?Q?M0JRPp07vwSubrorRshRIRvY7IGRwm/9NOTwHjXnftQ8N83tH7QaTCQjxM8+?=
 =?us-ascii?Q?CzQuoXUSdciKx51Zllj8T9c3+CpEHAmriAP4Pk4XP2xfJ19C3BsnYD9149IT?=
 =?us-ascii?Q?foT+SSwGFUIMx07BxruMSQMLnq5f+cx5sA3A/8naL5T32zn9lM7AtkPLzRky?=
 =?us-ascii?Q?ay7LbUgc2LKHqkbi6lPpzrIxEfqIM8A1VGFt/wzFrtQjgrOgRamN0QA806py?=
 =?us-ascii?Q?/tvnnco3sdXah51BRc5YhPmQi/Xps5TrkGZWszCGzqnY8RGys49YJWQ8kG0R?=
 =?us-ascii?Q?tYAmj/vuLGBkLP2b37uDW57iRMcBwC4E11HyUwNRIOtrWziQOJ0vbnZdpHrp?=
 =?us-ascii?Q?LRDPFAmUY9t9cI1cAMdWuECV3kZgmHmi2U0xprLPMlYXnZ5so0YIMMlY1yrR?=
 =?us-ascii?Q?6gFnp7twucYZx9YYmh/l4/9SQQ1jI66hWe+l+uo+MIfBm4ISzhqt9U7sPmFe?=
 =?us-ascii?Q?f6p5/9CE1TxyhVSeVYj2bgcqvtXdnU/gb2d1M/QyKZDMNWJy3MZYRtCvyi6Q?=
 =?us-ascii?Q?JJlG/t6wjjad+jfR0j/Scx2aJDcaF/znaor/5Kw2fdGCW7FKz3SHLdxVi1ao?=
 =?us-ascii?Q?nzKOcQUnsv4MV76oU1WF3QtkRrGn1jJn5Igd9yTQvSDaKVPRkT2z6pICBpxm?=
 =?us-ascii?Q?tZybPEY5TeTZ1M920WcAyEx33tVqt2/3a+cQ9t9boLWkMwVZZIbSo5/HnfRA?=
 =?us-ascii?Q?RnATQHLnX0EV1q0DNHkNmyo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9yP0nC+IxSylRjMip7P5LEHv28M1GrgCoWfA0eE+PcBVCSR9JrpRXgMJab2y?=
 =?us-ascii?Q?j1RXNNIo/D1+YMLemOevbZe6AVBp0L0hKEirDdx9uFHHRY4bINWLHoURF5WD?=
 =?us-ascii?Q?4DeRdMMmyu89ZclkLoqTBjoKjHLSuWKGgdpYNTJxUbuPk767kW35AhOb7TZ3?=
 =?us-ascii?Q?femhFxI8craIDJ3S+8Rd5oOhEUVl94BLJS1WvylBrUEUbv8pHz2UX4c1CZ36?=
 =?us-ascii?Q?adXob1kkKqdtDyXIOh3vrRXoRb9u569Zx6qxMN6h6xFQy3mM1EjvRMNtUT5g?=
 =?us-ascii?Q?rZAq6jpBotjwnj9sCJitG8FNrsynPl12tBs0oqQmJRt0gQZzMH/EwmnZ2bMO?=
 =?us-ascii?Q?81FZ/kKli+HFNFULggPFeR0J5xqml3tgVwCyQ4XxSzM1Vh/UOBlG+qGU35ie?=
 =?us-ascii?Q?g9w66a5ITzTCrgAsMtrl3xJ+DzHvraFJIBDK4yKxV50/T11cWvvktrwOf1iI?=
 =?us-ascii?Q?4XauJu/ma12LxXdiSigw5SG1+ydNGav4X6hfKx5umQEAKIw8XjMUaPrTF3d3?=
 =?us-ascii?Q?R/U5uwhIWK/ens1lytf9FHKC5tYh7I50Q7+mchDKuU/g/KXy8ajPvsToGdmD?=
 =?us-ascii?Q?EvsPvxlq8ygb+mJkrD3SFoNtSY4EwNbqnTVT9Gl7cI/vWfiLls4LPaW9b0jj?=
 =?us-ascii?Q?rlfOV2CmClUR7xlt9Z/WlGdWQmB9x+U0H26kRCaLinzXa0nY/TIVIn/c6ZyK?=
 =?us-ascii?Q?+slvQfisPkpOZByXcYUAv6D83J+2T65DOAi+8vYuEBGNHuwvx6e623JbSbpa?=
 =?us-ascii?Q?QtrqsXbmiJXctnxgfiCgifdZA9k1asL3a0lR93otgP7+0jorZYU44n6Xthyq?=
 =?us-ascii?Q?pB90XsW9tYp19dnzJg0N3HnCn6saEaY+nhytwEvo7Sh12jg5NiBp7OgTn0CT?=
 =?us-ascii?Q?GSc7/RCOYiLZwr16Qn6RaHksHYDzUZPX/KBYggbqnP3UWO/4RxW51IsX82Qh?=
 =?us-ascii?Q?3YQ6pecCPXTBQPTWXbm+gy57jFYbgmBvkZ72R+eAHXCdaec3NcItxSOvfdvF?=
 =?us-ascii?Q?t8U8JvCNDObZhFi28j11L+kfFsOU1qkc/eO2wyZFsSDzXBnwXKVo/ZfT5/Ak?=
 =?us-ascii?Q?70wnggmQYR6h99AwxxoLiu2o+1PfAf677HytJhxOMI+jhAvD7x1ByNID8s8C?=
 =?us-ascii?Q?JmjEVuoTEsHzBo7BQJm9CwoEJPtFwRojq0deJ8cAJtUz1iU4lSzI2j13tLbZ?=
 =?us-ascii?Q?hWTeYSquJtLTUqIqf2XCZ7OpQPpsfrjzjKQzLynP7m5l3jFkJCxetjTxNv89?=
 =?us-ascii?Q?rBUkOZNBkbz9SUa0E5n6zIZeRc5EnkDvPHQUB3UQe67r/0Kld0Dgm3JPYvKK?=
 =?us-ascii?Q?Px1WKPtGGZl4TyVZSBm0Da24M8aitQ4UXbV0vRsKnWyv3zNILFNk9x/jVRqi?=
 =?us-ascii?Q?DkiYKBpror3Jj7dlAOajNAAxXXCFZW3zpLvyjmoC2Bq14lJf3NAlMSIxkp/I?=
 =?us-ascii?Q?yIVzTacChnr8b8RLmKHh8wqV2SQvWg93+gyO9ku+/cN455g9jt/WTCQYWnJt?=
 =?us-ascii?Q?ooQucsEAezqXd0B03Azqj23FIgl8OVI1TF5NrzDZ/Ixoh81iBWInGTkvm3aw?=
 =?us-ascii?Q?Z/Mk9Ms+M9fODuHvUF6JfmyX+tHqr3pZQ3lHzSXBvDB/TBa/yv8OnKloILxf?=
 =?us-ascii?Q?E5SE0NVxXKPcYag4JPAr8vcqod6HxmmKDr0Yx20yI4deqPD0QLumvPoGJYfb?=
 =?us-ascii?Q?i6eYHkqt8knNepwc0xxHNk+YEe/beLYnpj9H1DfgthHHQYqHiqkOvkn32vsu?=
 =?us-ascii?Q?CBAmBhj+QFzS9FDGfskPqpypp+q4aT0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a288bcc-d50e-4f3d-fcab-08de572f5207
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 07:49:48.4052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwiE85mDZ1xxJAtIX6bSNi4N2hahqJqO3198c7kHzezBX+RDj0AVL8UgsFnBszFwtkfal10SRu8PeTg3JBAWiZAbbLg7JKSJyglcfAgQmto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4813
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Ivan Vecera
> Sent: Friday, January 16, 2026 7:46 PM
> To: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Rob Herring <robh@kernel.org>; Leon
> Romanovsky <leon@kernel.org>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; linux-rdma@vger.kernel.org; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; intel-wired-lan@lists.osuosl.org;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> devicetree@vger.kernel.org; Conor Dooley <conor+dt@kernel.org>; Jiri
> Pirko <jiri@resnulli.us>; Richard Cochran <richardcochran@gmail.com>;
> Saravana Kannan <saravanak@kernel.org>; Prathosh Satish
> <Prathosh.Satish@microchip.com>; Vadim Fedorenko
> <vadim.fedorenko@linux.dev>; Mark Bloch <mbloch@nvidia.com>; linux-
> kernel@vger.kernel.org; Tariq Toukan <tariqt@nvidia.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; Jonathan Lemon <jonathan.lemon@gmail.com>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Saeed Mahameed
> <saeedm@nvidia.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net-next v2 04/12] dpll: zl3073x:
> Associate pin with fwnode handle
>=20
> Associate the registered DPLL pin with its firmware node by calling
> dpll_pin_fwnode_set().
>=20
> This links the created pin object to its corresponding DT/ACPI node in
> the DPLL core. Consequently, this enables consumer drivers (such as
> network drivers) to locate and request this specific pin using the
> fwnode_dpll_pin_find() helper.
>=20
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/dpll/zl3073x/dpll.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 9879d85d29af0..d43e2cea24a67 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -1373,6 +1373,7 @@ zl3073x_dpll_pin_register(struct
> zl3073x_dpll_pin *pin, u32 index)
>  		rc =3D PTR_ERR(pin->dpll_pin);
>  		goto err_pin_get;
>  	}
> +	dpll_pin_fwnode_set(pin->dpll_pin, props->fwnode);
>=20
>  	if (zl3073x_dpll_is_input_pin(pin))
>  		ops =3D &zl3073x_dpll_input_pin_ops;
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

