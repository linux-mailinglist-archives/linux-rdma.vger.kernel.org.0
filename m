Return-Path: <linux-rdma+bounces-14606-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EBAC6C109
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 00:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08D64349ABF
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 23:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB23311C1B;
	Tue, 18 Nov 2025 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OM8RdtLn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7027E1D5;
	Tue, 18 Nov 2025 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763510325; cv=fail; b=pkggZDPPEH6X6iu0i3oZYrJ0AMqZzdCc6s/ybh2IZ6FDthcDuDjc1ceKF6AoJV1LveR1BgVK6ch4w7qNC+jyWEiwF2Axf1Jpj1yXsscco5TbMVWDyWGsbOHLzTAfUjDQR9axmVtRf7DBbu5TMp1M883WkgvZcXHInE2oZkhjl+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763510325; c=relaxed/simple;
	bh=QnUJBPkM0aebrKHhvoCNi9yMbWYOohEEV1OWgWCRl94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pf3edExe0eGwkVFxaK/Kun9jt6SeCAzoZ3r7zOHD/4h+3qmg2xy6rX2dC5bVxwfFiJYy2USGuu5bHCKC4tA2Q8f15wEOIw2MXDPYm29WH3iGUeWg0Uf8i7/xj3CHeC0z81EMOVQa/E9y18Dg5NPAtcb5EgCmLpr0zKAuKPYscPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OM8RdtLn; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763510324; x=1795046324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QnUJBPkM0aebrKHhvoCNi9yMbWYOohEEV1OWgWCRl94=;
  b=OM8RdtLnAaZzzPAT3edCeuClHWbFIXVtNTnLffCNrS8cdDf7R1lG/XkB
   8+ort7lVfesBYw0oEZsyBWl9cZs91POpxHLQuGeCAcOVZPtQc7xJ+PEF7
   2CnKQ77mU2jZSqLX+TnmtDoHj9x3arWQKy442YNtFsKirCmUeHxaYpP+G
   TSmtDm6GBWUIIRb6bxRhOCftse8aLDodpSpnBFSgZTSdW3uXzbbOOhnFn
   i57FqQBsKPeUyuPc7uQDDfQoOyAdoWLouTVZIeUFkrYUaH3frpWrbrS5T
   XDFv3nu4koxMYLzhN6oVKcOEmJhZzCs6/w0ip1/L4LLAXq8jQyS0KYWXO
   A==;
X-CSE-ConnectionGUID: n7aEsm6zRDeh2Q0OTZeZVQ==
X-CSE-MsgGUID: IxUa4AFVQz+jP6OcOaBIKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="91020885"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="91020885"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:58:43 -0800
X-CSE-ConnectionGUID: hsUvCZffQ16C4PL/7wej0g==
X-CSE-MsgGUID: 5eJ9P+iuTHiqQd1WGHz84g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191029564"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:58:42 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 15:58:42 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 15:58:42 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 15:58:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZYbADBS8bXhEd2KoC+Qym27MrQBmMD2YuDlqrLgbnKRuXAAg4bvv7KzTQwPYCVeubLh8B4GWSP1717l287/Jmk6O/grQO81vUWfLoUfW4mGtx26VRd+djoJd/b1h0pWokPP5FaKzV/d/+jhB2IZKb5tnN9OQhpU5EHw3xDmRKZ1Yr7aUw6sy/edAxJ6qIvcx/9db++p8AlAuW8eBA+dTxmnxIOUQH9DS3ZGFnhe1pEizYhJd0rVpx4d8uG6ER2ds28m+kJbsMQXBy3MTuLF+9QxbAFdsXubeUSK+Na6aj3YA+ajUSbPKiJ9Alg/184wc2IX1IgI8UnSABgHurwLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeSFdzDGIFBsG8WgjDbHnENMivkC89eWR+YmfgBG5MI=;
 b=Cj5YKv/sIbxP2bwVjKOxuG6/8x746EpDCB28OyHJfejYlGWVOl/iUAcVH7WbqNwWLqVrKsP8yG9XH9RwkrObXz2gmp0Q5EruCl34jVvUXSi+JDm+RDqiV3MDRcYAChBixbBi8aDjB7KnTaslOxY48GHqWwy5441SFRpUH37OiudJZDGV8oO7LQw08lRtmilYm3uMvA827myLOA0S6Q9lkBt+3Am8juSUmKmyfDwAzn+lp3+NxevsSF9HzgwoqqfZFlsVDGdAYAAV+EfASvB2GjFWI4DOZw7CHVqwh78ipFeZet6JTT/ZbPKbWmHhchhXSYBZTNFx8urRxRlZP0ZPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB8045.namprd11.prod.outlook.com (2603:10b6:806:2fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 23:58:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 23:58:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Benvenuti <benve@cisco.com>, Heiko Stuebner <heiko@sntech.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Joerg Roedel <joro@8bytes.org>, Leon Romanovsky
	<leon@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, Matthias Brugger <matthias.bgg@gmail.com>,
	Nelson Escobar <neescoba@cisco.com>, Rob Clark
	<robin.clark@oss.qualcomm.com>, Robin Murphy <robin.murphy@arm.com>, "Samuel
 Holland" <samuel@sholland.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Chen-Yu Tsai <wens@csie.org>, Will Deacon
	<will@kernel.org>, Yong Wu <yong.wu@mediatek.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v2 2/3] iommu/amd: Don't call report_iommu_fault()
Thread-Topic: [PATCH v2 2/3] iommu/amd: Don't call report_iommu_fault()
Thread-Index: AQHcT1zx1rq1OvEj8UmhXRdRHYnbsLT2epyAgAJhU4CAAFNZcA==
Date: Tue, 18 Nov 2025 23:58:39 +0000
Message-ID: <BN9PR11MB5276858062B57F944A7EBE778CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
 <2-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
 <BN9PR11MB5276EFE7D236FF918A79263C8CC9A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251118185831.GQ10864@nvidia.com>
In-Reply-To: <20251118185831.GQ10864@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB8045:EE_
x-ms-office365-filtering-correlation-id: d458caf0-aa60-4f97-c91f-08de26fe6562
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?IQRMfLgj15b3mKlYab0VdhdTC7jV1u9MNj8nIX7y+f2zMF3Z6e+hqvKtzfjV?=
 =?us-ascii?Q?SdoevKPlTkHpW5Agaw4O8SHkVJTZQEJ25Fst7MeFF2pAhAykMLNefOck0mj+?=
 =?us-ascii?Q?JJq2TcZBzCBEIq73Xb+UywPkS7pf19dmxH0iv11eCLNAT41/iH6nTyYZ1fPm?=
 =?us-ascii?Q?WG3DLjo1vBKIQCXd4qCetp/Wre8++X/9ndsqduUpMo0CpCjOBvBKm8NhOtTA?=
 =?us-ascii?Q?qPBiuVnmiIX4+7eyedygMluwq6oZK5pFCoiogFjapr4PTOckaYHvi3ng3R5P?=
 =?us-ascii?Q?AjIIEongUkLbcpmKnLQxoCYDtAL+qjvurtki0KgpgdFrP+CPWXXrjYe8E9vn?=
 =?us-ascii?Q?gOBNk3d1+2uUPN9QrXcqqdVB+zHS/6XJJfw/4i/1LzlE4A+cG/QoadnmxMFa?=
 =?us-ascii?Q?DKBU0oVw8gSY1WCDzFsIl5+S6sE6j4uRbU+1aUZPqgvNHbb7YUUc6SgdrruD?=
 =?us-ascii?Q?ExF2s8nWeHD8lyRdJapzp49M/WAFMXbB8EsGQ1mhoSdhPG1Q46hqDtVHbdOQ?=
 =?us-ascii?Q?WVvTvx2NtnKAjMPjgBKhhoZG8UxtAjqLoEu0e7osltYBRz92h/vOX2v1GvTv?=
 =?us-ascii?Q?EFCoS2GjaV7d1sqr3Bargh+vghhmbO48CIH1nJzhnadXQxzn/g7S2rBhNi3c?=
 =?us-ascii?Q?1sCtKT77W6H5OsWni2Je2+n1PvXAruU2gT+o9iaCqimOvfDgXFOH6aogavmr?=
 =?us-ascii?Q?vXTTSV3jJjOqAhQjK0YLhxke/hr4MaHxcgX3xfzSLL2EYTzpHdDvUtOUYv47?=
 =?us-ascii?Q?ecEh0bzEv5xqiSfiz14ysyms3uEhx1/xMXG5i/+HGWhfrCyUJq7N6qmlkIIl?=
 =?us-ascii?Q?bg1qfe3PIaLQrPqMxqC86HwnumTPxXqR4yQl6AVMTWx3ThZkhIVL1hIl+NAd?=
 =?us-ascii?Q?8JSd6R/SzGUWX7oHq7Iz0gOsFWWTACscD+E+K4pqmFEFooUYn3Nv5++cW36O?=
 =?us-ascii?Q?5w9KeF5Qi+TgAnSVbU9BGKH3A+kNbm0AE6d1jq8DuMi0UrWL+x/8Cb7xdFOf?=
 =?us-ascii?Q?d3LQmcIhU+OmJmJ/j57Fy2DgZL8ilHOSiyhcZJDDkeMAjR1nD9tvbDFixwfz?=
 =?us-ascii?Q?dbQ+UPmx/eead2QuYsxwCcNbuyQ1oW9iYeCwWBpatF8b1GhIMALXqektrq8R?=
 =?us-ascii?Q?R3x46LzkgEx7EuVWAPF1jevo4fSsei8soqdyMI0fgcokVZIwmcb2Ivg2D8oT?=
 =?us-ascii?Q?GdBG9nR3yzx8C7cmPR12fL7ABm/Y2QXevqS7DUgiZ1wSDmeso7K4D8olawuN?=
 =?us-ascii?Q?Qw9pHYJqXeVuHkFAgf2pYJKdD14XMuThTRbBSx0bMoWV5zjYdzRDMiztV78Q?=
 =?us-ascii?Q?RmKu0J5vxtHMNSE6zbV0FC6DCGvV035gbOUE1FBLU2C4LSuksdLw8uCJvROP?=
 =?us-ascii?Q?eOecnROaXY7AC3IPDalElwtyLximYvGlVT9R8ZLs2baAEXAkbn9bFkksmo90?=
 =?us-ascii?Q?diu7HLyYLSayI5iuwWhAZQi0VwKJWLX+lGcIy0diwsvuuRNn9+E+GT/AexXg?=
 =?us-ascii?Q?eVgDawaaSphfEH+57ptNFL/KEJu3mbpcTpqe?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UHBTr1b/rAcbZnONhcdpo8fwj0o22jvK9PZz8Am435O2m0q8jabGwMHQCV03?=
 =?us-ascii?Q?YjmesUSfxZNrVDvqIB3qxySKAAp1JqO7MqYvcet1KnFKksmLrIvFeWwEAzDO?=
 =?us-ascii?Q?fVOIpE9pJG46ad0H7tzwabOzCGmtzs6A5aI+Xa7/TwgnAx1PAS4+Tp4YwFAM?=
 =?us-ascii?Q?l6oMh/zjwLc+4MuVqXptOyffV7UCZwNG9bFqAp+Phk0BBFRJ8rPl51oa1I51?=
 =?us-ascii?Q?+ObSzjKJkBGw7xBbBnXSs2cc7UYyRG+Xrw2FpdcuZG0EKn4FtkaT9KOHBgib?=
 =?us-ascii?Q?VSaaMm7kuk8wwf+CQApenwCa8oVB4Mwk90CgGDJrFD4QaIFdFeqPn2bFFDfV?=
 =?us-ascii?Q?JHN4omKgNJ5zncJNdIYZJP/++cOQ1KaFOy5gmbLOlQd0/fTwmM0bspBpi1UU?=
 =?us-ascii?Q?ByNG9hLA7OE0bGxsULwGsl2S0595sxILqVvRKSh+9tYZrqu7XGG6k0nT5cwu?=
 =?us-ascii?Q?Q+YtHzedcZlGfRq5RjP1t5KD4/svz4tU2UIGp0jZ4+4JkeGmzazEgwlSe1sc?=
 =?us-ascii?Q?t/ED6bIWDbBjSyBTRkUDl5o88g1gLIMrIT0GQXK02RbEdEWFdQ/kmzDx2rNE?=
 =?us-ascii?Q?3ukU/W74JFy+hW/5ELhTXPrGNT0wy1mkJwYSLvv7UjTvARuQCyuJ5+O7c40G?=
 =?us-ascii?Q?6f6Yrke0smc2HHi13i6I2A/Lz45KEMRxaAH0f0XWQpE+ggbxTBfwqOH9ttts?=
 =?us-ascii?Q?n8HUvfO6rGFaRgZlki/xeP6RDACl6P5iKfRivB/98fAoBgHpUC+uV1htA2th?=
 =?us-ascii?Q?LQbTUjN9EyU/2JYezh5rgnzaaDzXQv9cm1YsG2cPlH/U8m4a4uJhuobQEjcX?=
 =?us-ascii?Q?2JSc+QaVpl2R9nUoNs/Ln55n2wz4Uml0sI6GlTYt0K5a+hxYRFCrS5QSghYc?=
 =?us-ascii?Q?EYBw2JBdcaeVwfA7/khGa3u7QCMNjlD8hOvuqRHabvW4Dx/zyEnVoyRk9WdI?=
 =?us-ascii?Q?yBqiYkbXIZRNmfppGlG1rddxEiljeMq6gJmQsQ0ZRgnA9e18hjduFb5xqvyV?=
 =?us-ascii?Q?jdUVg9T2gLriCTgYNL8z7lZ4bigqadkBhriVl/ZCXtnMO0Or9FgW/dcRw0Im?=
 =?us-ascii?Q?pwPc546IlRDzFC0SWmuMMvt/jclT6uV0O29bSnJooeEMhVdrB4/J4LeJpMcT?=
 =?us-ascii?Q?QHwdPwyt1Y6gwjYipyEbblCPPuk64MgowU936KIzg8UX3w0xpxIfVBKFpxdm?=
 =?us-ascii?Q?8SyRcyinYfORLIQWwZyXyw/KwDUTzIANhIg+PqqB8IBVjupzIgUrKphjugxG?=
 =?us-ascii?Q?MtFFM+H5ERHKeRDzwMyyMBOputNivrgXhjj+uV5tChHOGWJIck2GbyJoSdWo?=
 =?us-ascii?Q?xdB4m88d+a6EWzG+qNwuM9LlEXOGAxA0yW2ecRrddJoO1HyMosYT9HeHTWuu?=
 =?us-ascii?Q?SObvvwp6iHIdEElU3ZuHxZUjbZQQ4s84tS9GmbyiMoZnGti5Y9XKonchO3di?=
 =?us-ascii?Q?+mfOs59uLKI/QQS5H+XSiVgjUUqkr5hE6gCHwIIxUHh7K00UBsJsUaEX7fWK?=
 =?us-ascii?Q?Q3wv9b9zKiOkuJJIWyxDkL6Jwxr9dGzFhgehf4Q4CU4swDJAeOeLYrVc/EW0?=
 =?us-ascii?Q?ef2jqegYT8u5WDArqIy1Iq3e1S7BB6bQWTfE0gu8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d458caf0-aa60-4f97-c91f-08de26fe6562
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 23:58:39.7452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nVsPHHg5YFyiqu9uxtVQ/c0bNnjJI5AJqWGmW38r+Af11aUTJN/JfUiPQWh5F6+939B1YmXyvTc/0JT4Qp1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8045
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, November 19, 2025 2:59 AM
>=20
> On Mon, Nov 17, 2025 at 06:38:51AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, November 7, 2025 4:35 AM
> > >
> > > This old style API is only used by drivers/gpu/drm/msm,
> > > drivers/remoteproc/omap_remoteproc.c, and
> > > drivers/remoteproc/qcom_q6v5_adsp.c none are used on x86 HW.
> > >
> > > Remove the dead code to discourage new users.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > ---
> > >  drivers/iommu/amd/iommu.c | 7 -------
> > >  1 file changed, 7 deletions(-)
> > >
> > > diff --git a/drivers/iommu/amd/iommu.c
> b/drivers/iommu/amd/iommu.c
> > > index 2e1865daa1cee8..d4d9a5dbfa6333 100644
> > > --- a/drivers/iommu/amd/iommu.c
> > > +++ b/drivers/iommu/amd/iommu.c
> > > @@ -854,13 +854,6 @@ static void
> amd_iommu_report_page_fault(struct
> > > amd_iommu *iommu,
> > >  						   PCI_FUNC(devid),
> > > domain_id);
> > >  				goto out;
> > >  			}
> > > -
> > > -			if (!report_iommu_fault(&dev_data->domain-
> > > >domain,
> > > -						&pdev->dev, address,
> > > -						IS_WRITE_REQUEST(flags) ?
> > > -
> > > 	IOMMU_FAULT_WRITE :
> > > -
> > > 	IOMMU_FAULT_READ))
> > > -				goto out;
> > >  		}
> > >
> > >  		if (__ratelimit(&dev_data->rs)) {
> >
> > Remove amd_iommu_report_page_fault() too?
>=20
> I don't understand this remark?
>=20
> amd_iommu_report_page_fault() generates the dmesg logging on iommu
> faults?
>=20

sorry I meant generating the dmesg logging same as other error
types in iommu_print_event(). No need for a separate function.

