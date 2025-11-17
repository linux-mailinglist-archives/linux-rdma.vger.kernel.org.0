Return-Path: <linux-rdma+bounces-14529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB54C628B6
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 07:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1839B4E6033
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 06:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA1E315D57;
	Mon, 17 Nov 2025 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJiywY0Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F95315789;
	Mon, 17 Nov 2025 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763361536; cv=fail; b=dYURWj+sJXtgozZPNUChKFChk7UXOGopom+/2cICWZQYuOi4EOU0e2yKlweUQlMUGbcoGlYiQYROZ3RgMqG4JpJsJUsqcPW2LaICrhhrkUthx5ZkgQI/vC8idliG6h5S4PfCPp2kLYQCj6p3xfOvCoKE5M84m/xpMkCg17sqtFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763361536; c=relaxed/simple;
	bh=t0puF8qdGHAVwJ3j6UMK6x2M7I8+8Vg0gOHG1awkPJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W9sGkB7Om2gY3082RvyqzBs/WnbmhXT+3HjkiocGhSmLOxsEwTcbYZM1qCCpkSnS46eFhSiGEk2I3ND8t8xCuuMis97mbpCOKczzqS8QDBt4YEQj5C0V0WmDbaob/XV0XINtvtpPnwRrN5EJAY6jGFduFdUAaRhxC62HNDgb8+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJiywY0Q; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763361535; x=1794897535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t0puF8qdGHAVwJ3j6UMK6x2M7I8+8Vg0gOHG1awkPJw=;
  b=YJiywY0QXsV5sv1G+g+komCF6ACBHjMeMUM7wehW6XTOwWvP9+yCWlSx
   HzEyAKVwHPVxQH4/X+WNbdEq/dwnTt9zTXJObKMuKc9GGpdasQ8tZgkOU
   ulZFnWJyS9oyB8v3Szi9NMVwm4x92M3KsV3h98stg2zrnwRGhOCIsKrnU
   srCn+vP+itPG0Bbp91qax4VwYf+59s18NGtYOKg1eE0Gw4BFLxsoGcu29
   LNB17EV9857hP07rk247gARiTXfw5dzSvYipvK36Naopoaz+eUnj8SlU3
   M09rpopXV4/9jXf1h2Dc5counq97fLMjYYf3mfT6jgiVNCN8vSnj3rFcL
   g==;
X-CSE-ConnectionGUID: w9sLFhsJRliKyvU2PT/+Vg==
X-CSE-MsgGUID: vqocrPHLS+OYpoTURk1bMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="75673467"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="75673467"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 22:38:55 -0800
X-CSE-ConnectionGUID: BbcOzU3jSHyvyEV/T13L7w==
X-CSE-MsgGUID: HLTFrlCMRmWxV87Ooo7zCw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 22:38:54 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 22:38:54 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 16 Nov 2025 22:38:54 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 22:38:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaGRdSQtoLODArSv/z6tWvvUQFPpXfWNegL/qCh07j0vIfrf2jaoJnF5jwxnsZPpOLvDxlef0TjRz1fM4/H4jY6r9+5FCecTWamNHG9bcjJcIWZHA7yr5zv0b3Mmx5IgxCKkPHJO6OBArJvE+Yvwtyysh00SzwYFaml2CYePSqSePQVE7ufFh3ZCgedw0CSX35i1lCaDrT0FF0e8pnlTKB2EGm3vqBsb9TtyBHCSaJH7PusZjADTwW9z6UtHprGLG+2O6rmpjnTqG0LJzQzwUl1fK3OMnPrLGFa073Si3yIoKV9SYZaOguusLtrAYS0mu8FyNE9yFlEwwKhDKjXZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRWPAlP9MuqcFIQ4zC3bhKl9NWAA98y6P4oFR6kQLcw=;
 b=Q+JrMOFaHL84DJ7kArIQ2i1Oj5n6PzLWXaMb/DibwjWORn3lVJSbEWgpuxuZSgMsdaM3TvKolSkRkCVYHMTtVA+IJM9v92xwmdODLvbMV/11aitafmt3jWJo9z0EEpTk06SEvYgbLZcaBwbp0mGAdcry1xJok5KXOWpIcOWXzE2xpgL/1Qp4vpT1Wf3/AsciwB9jTtPZpmYUB892isHwkRhzgDM6LT6d6aw9hvDGrk9PzL4CFzavC+bcga/F9lL8X1MepTkAv4W0bCjkWF9c7vwYoX0kOzxDt177Vp8u8UPP3L5A65JuOQ+IwlY+wnLjxOQJ8nhCEM9GVc1pfUtg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6518.namprd11.prod.outlook.com (2603:10b6:8:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 06:38:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 06:38:51 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Christian Benvenuti
	<benve@cisco.com>, Heiko Stuebner <heiko@sntech.de>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Joerg
 Roedel" <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
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
	<will@kernel.org>, Yong Wu <yong.wu@mediatek.com>
CC: Lu Baolu <baolu.lu@linux.intel.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v2 2/3] iommu/amd: Don't call report_iommu_fault()
Thread-Topic: [PATCH v2 2/3] iommu/amd: Don't call report_iommu_fault()
Thread-Index: AQHcT1zx1rq1OvEj8UmhXRdRHYnbsLT2epyA
Date: Mon, 17 Nov 2025 06:38:51 +0000
Message-ID: <BN9PR11MB5276EFE7D236FF918A79263C8CC9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
 <2-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
In-Reply-To: <2-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6518:EE_
x-ms-office365-filtering-correlation-id: 21abf98d-f535-44ad-cccf-08de25a3f876
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?RW5xBT51HW9q95NhJjQmTPBIYzOvEdfJFl55Bd2K+NxI8kJs/l1CmYs42F8o?=
 =?us-ascii?Q?mjb/hefC/NJIYEfo+cK+2bAeoIsSc525YjJOC6V8PKfG/jK1NAJth5aQG5Cd?=
 =?us-ascii?Q?KaJZuPou08A3vfVoanb0Twy0fUb2JYRV/lGkGZsd0wtMUpVhaDP5AjxKyIoA?=
 =?us-ascii?Q?FfHsSMmzfxjMnVC9pVrwyHD429oLGSIlqBugooFM9N9f9flZoDuLVNOJz9k0?=
 =?us-ascii?Q?Yzs2mRmr3oF2BStXD1titR0l9CvYBV9InlBvixDhDeCNkDPXuYL/Ux7GGtAi?=
 =?us-ascii?Q?8TJoqt3k8hIe1YzzKrm3g4Xwm91l27VhBV7RMJtOLFD4H9v62p/ltLpVyNa8?=
 =?us-ascii?Q?TDx0Xca7DyQZLxTmQTYzkp+3/uBGuPOZAlVMxsSEMSTvyyBQ3ewmpzX7EUzr?=
 =?us-ascii?Q?IxL26oj4I29WwhBwEARaS+JVPLsoEENPwmNOZLq9mpvoSrhvyxtPOrt9RCTC?=
 =?us-ascii?Q?Agsm2/gL208h5QMD2eSQTgsWCjc557DsriEgxMTN4WKeNucinIgodoHHu7Lr?=
 =?us-ascii?Q?2314GXEPErlXv6k0mhbnP81P2JXHeUqMl8fVDJmyQxMXG63SZk7SJwn8YPuZ?=
 =?us-ascii?Q?Yc9rJ3IeYgirLir7euhTo38ag296+W5RXGo5WOz9qfBH5NxMjHmGVn1RKVs5?=
 =?us-ascii?Q?hyR6TQQ6Y3M/j/78fZ5qTWH4xBJDejwe3Ph+5RuoJcOOnqrQWh5pQBs0QZ6C?=
 =?us-ascii?Q?InHeJRZaF7h+N5CeF0zOoF+q/oiHRk6kRQoIYzP2NO0vCBCWKjlOgXaluY9U?=
 =?us-ascii?Q?z1FZRG040t39rdhCEMEj4n+OQnSDkpndm2XD/BVnO4HwMmNePM4/u9BBtnXS?=
 =?us-ascii?Q?C4mkgCN7sIyhQq2YDtaZNczwB/ohEOttYwR9LzgAgyD9SfOBlJaO0FxDxAfH?=
 =?us-ascii?Q?jvIIixXk5+mcPi6ifcWU9yGMF0ssg1yqAodPdlRIjwIAlIiRoHz8DdaaL6Xw?=
 =?us-ascii?Q?//NHEfFwYKlbZEYj6uDt3JGp8xdgvjNRsVPj30vnPkJxS4jJcibd2Vq07ej2?=
 =?us-ascii?Q?Uvdwe3y+GjGphKtDDykqoSkLL7fMEkEtNxTwLRPzA95fElLjHcBovQVOLPR7?=
 =?us-ascii?Q?QXg2lflRhG0YoJxYxXFGWD7cUG3yRM8Ppn75hYKK/GSM5lmITGtS82YAHiGX?=
 =?us-ascii?Q?F53J4np0nNBjhDn/ojtiJekutJuaf/Z28uLYr0dtxivigkrO+/XrqCyfrG8B?=
 =?us-ascii?Q?9GXon7YRcgnLxEkqO9uX6RS2tfxiGulFaf4aveeWB36K9KitiVwR1morWm/r?=
 =?us-ascii?Q?lVw+lgCLiRR9KuOQfUufMvDlhouR/ah85XVJcFo4kv39Rbk+XaQyYcOVtCuB?=
 =?us-ascii?Q?0PQScxnYVkgwrDLwg1pq0Hun46B8KaJh8Y5sCikBYQ7l3XsKoEXdwUgM479G?=
 =?us-ascii?Q?TLeUVHHWWtxKGXr/OMkN6xeNDrBXR+QfE1IMGM05aOQotlEiYISeDl6Fx5vS?=
 =?us-ascii?Q?OeE6ItbUJ6UEvZUpo/ApCpfH2TF9GcFmOgNbL9TNbsjAogxYOmFGLXUj2fwl?=
 =?us-ascii?Q?lBcEeowtOd1mqKTi/g/agGAZPgW/op0vuINPdlZaZwq0PF/IF7WKxyKmLg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8yUHbk4/zqlDo+23NUBOFRbFaZ2F/mHbNnPa4j1/n18Au5ELq9/y8vB1eV6k?=
 =?us-ascii?Q?ivsBM9yOBrmjfZBsstwXcDPbdiOZywWrIbKqqDaE8dehZNMLRdFZy1Cj3Olq?=
 =?us-ascii?Q?u0A/LTalhgnAIR+Aij9ayPF606OK6YB8ctd2SnbsW8BSLBfRPYlWC/1T7d8R?=
 =?us-ascii?Q?qmuFJ5O2j8yfj3/liTAiGJbszBqrtSkCbC3KbpdzvTKQA/ECh/iLxoUMsM7X?=
 =?us-ascii?Q?jk7ql0GyjWFtcIa3XO1kSTyBAYCvmG6jdWmLufbvfsi20OnVyULVOHe+Wz1a?=
 =?us-ascii?Q?kZKIc3oxC3FeieMGe3SBm3MUzr3gDnp4ZmXV32c7trLJC5BSNV9Jw/JEJ7ME?=
 =?us-ascii?Q?9IGa/tF7qjfe2mTGJ8ZmTeA56RvbKGcAdPkSOMDnbIM8AHhQRoe04ISiWuXp?=
 =?us-ascii?Q?V/7I0m7EgjOQDME1PUsZ6zYRZVdxhful3wlocHA1GOzoXTUfSeXu/PELgE5v?=
 =?us-ascii?Q?Xj5DlId3T3j+bO1zWoH0YL1A9oTPyp9Nh0jAzI98SgexRfdv52M27ob/RfCw?=
 =?us-ascii?Q?QtIyDVGUp9hk439N/cvupHnrZVuBkSsY023ggIEFONcCUaqz5RU4gGQOkpu1?=
 =?us-ascii?Q?JpKLdsbw5Nncnl8dik1iJgSe9kEytxFjYNc+moJSGuOxLjxOInXHPJQlwkVJ?=
 =?us-ascii?Q?TpVj3hoJvMFPl4z1aIWqsZI0cyVCsw7JUpPSpTwoXaytPkWlYHPqNuOfWQwm?=
 =?us-ascii?Q?kogG0MdQh0RD6fIMLxgiU8KvQGfyj2hpKT/IN8LGIPSRZhd9oodrgewQyv7C?=
 =?us-ascii?Q?k7TGy9pTYMTW+yVwdfUrCLpBNhMbsE1M3MmbyNi+KmXcwR5xvuMOKp6Qc1sm?=
 =?us-ascii?Q?rtzrUYX67yuFI6PgkcIK4+jNwqKqZdU0t98WHZ+Rz9iujgISk7eInCXMbCiP?=
 =?us-ascii?Q?gSgY0Ogu6HJzHRLys24joiHC+LkLk26sDvJyr0opySmFUIjuwSV/g5IaF748?=
 =?us-ascii?Q?Ov+pVk9Iv7Y6m3XWHYnNAoaSlv1MYkQoA3Bg2ykL9ecF0+5sDN7Srm1DCXg/?=
 =?us-ascii?Q?+rpg5J2X8KwFfn8P/QJ97Hda4TGzsEaFKWpNhrbod1lJ3eF5aQlXaXVUzluj?=
 =?us-ascii?Q?nWCaoW49Ry5p6kLUsvqeStsatgEaXV5YkX2s16M5KOnkKv9xm0I01Iza+h2R?=
 =?us-ascii?Q?emIzyjThmZVk4TnZiSIKVBjUd9LjP7Wzq941xj7tgEo/pXX+NAxec1Wy+Bub?=
 =?us-ascii?Q?G47QKB3YmVL+lRrTWz6xkxFDAYVc4v/sWd/9ys6KJeoTCzwqLgDL6hhlgwLv?=
 =?us-ascii?Q?nsaA3kf5IvRbfXqr9whRgbgV0dmctZzI7CNIo3gaKYcetDFyXv2MA/2bsy9N?=
 =?us-ascii?Q?TKCzOucwWQZyrbtjD5vlB1TX6p60qpLzGj8OVULVfLZddWbfrtEypYhG7YIm?=
 =?us-ascii?Q?ZExH6SYcT14lZVx37KL3yv1W5faVE5I1UjDDapZUskreVmLutl6BEiqcYPyf?=
 =?us-ascii?Q?FhemA/nTn+mdnz5kOUxTRSg0+rSZ3syMSO60XGwMdpTa3N/Y52g24TfvsUw7?=
 =?us-ascii?Q?TbKHdkb/uRvMm//wsqzFsAkY6fByH8pWbkyYf9k99iQ5wYHavu5qk98JOoF4?=
 =?us-ascii?Q?4248x97xsU0q0l0G6y+ZuZ7wO+jI9QhdcbMVZgn0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21abf98d-f535-44ad-cccf-08de25a3f876
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 06:38:51.1272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMDFLd+TCRea8827kUSgX9h9i6SDt0W1BJ8c5A+N05GlZrkDzie+csP74uoGxmamNHd7YmaMTD6BR/xq7SeSxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6518
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, November 7, 2025 4:35 AM
>=20
> This old style API is only used by drivers/gpu/drm/msm,
> drivers/remoteproc/omap_remoteproc.c, and
> drivers/remoteproc/qcom_q6v5_adsp.c none are used on x86 HW.
>=20
> Remove the dead code to discourage new users.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/amd/iommu.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 2e1865daa1cee8..d4d9a5dbfa6333 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -854,13 +854,6 @@ static void amd_iommu_report_page_fault(struct
> amd_iommu *iommu,
>  						   PCI_FUNC(devid),
> domain_id);
>  				goto out;
>  			}
> -
> -			if (!report_iommu_fault(&dev_data->domain-
> >domain,
> -						&pdev->dev, address,
> -						IS_WRITE_REQUEST(flags) ?
> -
> 	IOMMU_FAULT_WRITE :
> -
> 	IOMMU_FAULT_READ))
> -				goto out;
>  		}
>=20
>  		if (__ratelimit(&dev_data->rs)) {
> --
> 2.43.0
>=20

Remove amd_iommu_report_page_fault() too?

