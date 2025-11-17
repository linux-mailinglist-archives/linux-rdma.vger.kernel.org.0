Return-Path: <linux-rdma+bounces-14530-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11043C62910
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 07:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3474736127E
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 06:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06033315D3E;
	Mon, 17 Nov 2025 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJXrhSOl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D5930FF23;
	Mon, 17 Nov 2025 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763361798; cv=fail; b=antLhk9wehoqqxhHekkskTlAzv1OTk9fJFx6s3o+J/Gl/BhzV/LtCRuAbBj3NDPZDXQwPW7t6+R3NbUa9wofbqBlS8nQaOuhfx645IeDkjpk4bQFFRXXQS6z0GrTYmI3MAzs7FoUhycr0lfyRIYNt/y6mKput1Yg+4i5wYxTGno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763361798; c=relaxed/simple;
	bh=th53rxsrGj/njergN6mAd8BKplBDeO6zuwoCYrhA74U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q/75e+ZW4sC4A6Wka+Gzzb22v3SlIYcSLEibcSCGZImK7/+1VHS4p5eBMdUx6xMWM3KVr2/Gy1Z7LkyW9AeD6Yw4hRVmseCOHqaZCch5ReCjVcBRrY05G6bBlamfnKMj5hYzgNlMrQyACPS7npt//YCbuoo6x9n6L3hQSsUDu7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJXrhSOl; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763361798; x=1794897798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=th53rxsrGj/njergN6mAd8BKplBDeO6zuwoCYrhA74U=;
  b=HJXrhSOlPplhmOON+2mu/RkpF+GW9n5JsYE0WFeY30Vryn2nt7/nscXO
   uwFLqpZ7rxVEnHpXoPvRT8iwEU/XKuGS6bRomk3wtpwBQluMqMlXQ4J/5
   Qtpzsf9oBc2ULXG4+a1tRgH6teI6x0urYOmG5WaHj/4ZQAAxpdDAdSrAA
   8OfQvbiERY975nKxWH4R+PFohaITjJAw1Qb3rVjF33dWPG4tKRrfdU+iG
   bKak3wvne/LiZC2lfcgIgjRxyKVEi0ta3qefq42JQU1zjpJaHJZQAQer3
   iCmNVbHUOK+KuwU8wpoRdnLPCvkn+Ab9Xkt/hsC93UEhoQdyRdTSSvet7
   g==;
X-CSE-ConnectionGUID: t7mL8FbHTPS2OAbKSkM4ug==
X-CSE-MsgGUID: iOuFbDLQSTeI1nycotzt9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="64558648"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="64558648"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 22:43:17 -0800
X-CSE-ConnectionGUID: 1VkqQtvwQKOC0nZg7oor6A==
X-CSE-MsgGUID: uQAWpNIkSCeqyKAkHeNzzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="190162554"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 22:43:16 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 22:43:16 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 16 Nov 2025 22:43:16 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 22:43:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POOUkzdip8eJM828IpYHOhDrXEXhM9BOVcpqEk3r0LbT3NNkep3gjTrD6q+BPUOIT1Mm2I9Y/O12jljBg/vqL/ZtIFaCYD7uHLn9hXI2XeB9HaRDwz1RQ2DBgJ0bNHrGPnLESdxRkUyJAxP6ZhU3QTrZGOc0cHv+mgbcbvxXkUsHxsVMK9XPkTsoxPNtIRyreMSV8G0C0xgz7mdGu3aXh1wBxdvqe/qWM1Z3hbSj9QoVIFVoONHUQlz+ef+udHEu1+hYGlfeoEuAnlxfG8jLw5zqGV1fgKbwT+VqdmF3WzlTSW3bZV2LQBNdq74JOZ3su8QsZ56unpEz1klNqljMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzL645LsVSjlvBO9UBH0QJ5hmWFcPL55eORdNQPpujk=;
 b=Wzh3ugA83TOuZ/C1R1t61A/Ai2UJHs4ctvTqcrQ4mvU5kLc00jqx269lVjsDKQiw1FYh3qDKwTvYsHQ7xEtwU++qxGxkZ9zXftkRNZ4j3KDDpacQTGEK6/pJZxBC/C1bgXoLzUB39wxF/8JaSF5wE3c7bTPMIfM3q8XFgkA+OGlDeV03X197PZtNxYTDWmAh7Xrp6Mgwk0MgJLkJv/7LkRDAFzez8Yo7vPHRrqHy/Sb5RCrA2HvJcB8ZJIEUVfkeubnKTZc83CYxGcnrVUMwbUba1b/HWh/ye3Cr+N67gkvMtKwjUsfc+yHGL2fxuqO0KHQ8lzUErTMutxW4i+gPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6518.namprd11.prod.outlook.com (2603:10b6:8:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 06:43:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 06:43:14 +0000
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
Subject: RE: [PATCH v2 3/3] iommu: Allow drivers to say if they use
 report_iommu_fault()
Thread-Topic: [PATCH v2 3/3] iommu: Allow drivers to say if they use
 report_iommu_fault()
Thread-Index: AQHcT1zt0kQh67eiIUSdYNh5kaNV3LT2evbQ
Date: Mon, 17 Nov 2025 06:43:13 +0000
Message-ID: <BN9PR11MB527652DC5E566D67AD54FEA98CC9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
 <3-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
In-Reply-To: <3-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6518:EE_
x-ms-office365-filtering-correlation-id: a1e621af-cf73-4776-95b1-08de25a49521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Lu3cIX/2j2hsfz6nbEcIBGuVV6ZfsUp1u6u+pGwI10NKR5a6WbyP5XYg5Bzb?=
 =?us-ascii?Q?HTr54wuhUaFXVB3rcUzbXSgIwXBpxxCHVe/F1GAWHo0YQb4Z/MPT7jIkKAAz?=
 =?us-ascii?Q?xKwako15mR94jRkgz89pn/qxSXw0j64qQ9xRQf3CVvC2hwFH5TeQ4ryB7Iat?=
 =?us-ascii?Q?u+yI5AcgZoduXkoxBcnjK/7eXbcBhZUpCd6DY6VFVTXZahNhpJWDOQrCy0Mv?=
 =?us-ascii?Q?cKF6kBO2yV8oCuQ5JLXYtLohbmug6ri3PLN7DRc+QBX2vEm8FmrOupnPRyBO?=
 =?us-ascii?Q?4i/rPgtlDHX4wmWUUQ9aDUfhb9uprRHrdry13/03IjRtrE/h5n7oKoZIJ7P2?=
 =?us-ascii?Q?+G8CSVEoLvsvG6PSzLh8Xs1DMKGpchQMkv3jsmg5sLqoNwDCOWNocL/eseqo?=
 =?us-ascii?Q?Hb8LkkUHsJH2f1rPNgEt/HDhkPv4D9TCUmCSLIhOQ1LdfU3X7tGakVb/vaKo?=
 =?us-ascii?Q?ecnGwCEaSEQW0MOBwBrejT/8Rr7gM+KgBbYewUZZ/Oxh2TqqvyMHgfKb0spF?=
 =?us-ascii?Q?a+MFaJxm5TkBdn8ocK38DMbqdxoJeRNzZv9ag6AC7sZ84h9enzFVVEPF1veK?=
 =?us-ascii?Q?VPxZJUvOds7lqUof5H3T1ABRrxFjLwden3m8MXYTS0rK6DKENsRlW6qbIZ82?=
 =?us-ascii?Q?RcDazbbjGgGvV+dbzd2LXHJxkEO0c41fiV0nOXYmW/Mf5B6Kr6pSWA15uypZ?=
 =?us-ascii?Q?LA8R6YODpg83QBd+5ut3UMwDMt6ClTyvAZYGapDMAB3Kj6rf3utSWTMyep9y?=
 =?us-ascii?Q?1fOmSTIaFyATdfCLTWwLtmajVINNXU945jXjZX3wYdPaFgPXhijbxml70/lE?=
 =?us-ascii?Q?FXxC9ont1wQNCtbdNz+eZNAkp5qlwq8cPky+vo04iUDgUpvxITiIr1XAS/4u?=
 =?us-ascii?Q?ahNksDzjNG0OL+vlADdOKtAENzeWz10+W755GpuNnW52m8K3L7d2CTlqMSd3?=
 =?us-ascii?Q?g+Nk4l6iNPI7QEBEObSwy9hRhM5hAmQ0yDrKeYkFZX0jpeTdyKplcdIRJY81?=
 =?us-ascii?Q?/cKx8XYmrNslX4iSTWEkPsKd/pntLchXZEYqbcXGMGnhFiijKHBJga3x8GbX?=
 =?us-ascii?Q?FEe20yKbT+5VfHYV2YTe7Ix3VM2AMSafupbQL2MuOKMGqGNkVYvHODWKSkyd?=
 =?us-ascii?Q?Ere34j0X8NABbZcT5RidU2IOJM/L2ye5o8yI8mBQsiw8misQyjtgc8wl2qOj?=
 =?us-ascii?Q?uqb0qOlut8I0TpXmZdKjZSsH6Hgf2OcBkP5Levh232Va4/5pVQIsSO9BFKYJ?=
 =?us-ascii?Q?rmx9Np9etHAurRR+bGEpa1gGxDYsyIpM0cFHQa+1BETTzP3MlaxLFqtneEhA?=
 =?us-ascii?Q?/qo43JKvJdqRk3Pw2gWnE0qDy59kPrHnLdFWE8RZrpdAPJgbFd86xZFvGF1/?=
 =?us-ascii?Q?F1epX14a4vv9xiZAgqne0aEg656zm/35T7lp4SBSUxT0lvFtBjWx2QagNy4e?=
 =?us-ascii?Q?Bre0A25a5K1ztrTlogdhCIbMnBh110yMPLpZNdq9lyCsRH46aqaWjghzxIzf?=
 =?us-ascii?Q?iLA5iLJoch2ECKydKwsvk5E5QvAOKCGnhah7T0dvuRN9DeYB3G0FG2p76w?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9efYELwxsVOBGD+5La36bdUZ1ez9kbvmhxqN2btaoF/6NO3AGvKtcEQsqkWm?=
 =?us-ascii?Q?BoiAe18sCReMnJ9j4LjnUrWc3K32O23jgL2u0vS1JfKhFMiP30YDAa/TzlXG?=
 =?us-ascii?Q?509cYEYWyB/RKr67vg163o5nBJUJvJ/lXnZtRWg5M4G/9H84AMQxExJZddex?=
 =?us-ascii?Q?x6OPLHiH57krgwBeOKorQBU73n8hjRNNgZMtJxSt3MF1XwLQ9ehk2lY8YPGl?=
 =?us-ascii?Q?JgWl2wKSAojOSc224uZxpGDMmmfhzRTPpoYMbvhEOjCytO7YOXOpiAedfbDg?=
 =?us-ascii?Q?VOXwORUo7j+fPWLYVFLDk5tGqKdXH0am1gINO/ga8IxqDICDT/6WkeOFaWDN?=
 =?us-ascii?Q?2SUe1/R4OORRjv+7qe1rTUShnIFTeY8THwIKph2/l+R/J8S27He3DG4+LsGA?=
 =?us-ascii?Q?Ywc6EgLnsS2k9UYv8bFj9Pg2tgLAAi2ObQ8p0W/Dv4YpIVHctqQDmNrkJcyc?=
 =?us-ascii?Q?up6AU44HwI3TapXstHXXuDaz3EyulCSl9pEDmBSMq9cW24gMN202FkIemdFQ?=
 =?us-ascii?Q?F1Gfd/15QeTtFA0xzLwuBzXMlpRORGhvuhxyHK8m+GoNPB26HctU7N/YdnQa?=
 =?us-ascii?Q?+PetpUSXRn7QXhMHwH1r40xrA4MvlQza5+NKLhmav+PAKKdw5t7wY2kTeXv4?=
 =?us-ascii?Q?deyNEKdUNWdOLDAL6h8hBnnlBrd32CyHMA06KV/Un5sY6hUN4T4ohMqD+Drn?=
 =?us-ascii?Q?XrJF0ph8MeFWdc2NdTVA+WZB9E7UOEgKNLDiVcR2dvv3RekKf2oGulx4EWXc?=
 =?us-ascii?Q?6lczj4Ag7T+MZLJk+0upyCte/glGwQfSwcwdtRXrhcYvMy37HjiTrXq7B0gh?=
 =?us-ascii?Q?Hjw3pyAHu+dzJok4YUop50cXLn4l4iCo37U8En0z5dBi6i4wtwca/vh4v2SL?=
 =?us-ascii?Q?aFbU7RrfttTj9onS7iWVtK2rt9+caTEScyVWVobBffi+ayvjFSpMRzaf2lHE?=
 =?us-ascii?Q?W+3Ye1Xl1+HMIWaM6r+8djNaXAXWTJ5STcnUcwT6eRbC9rDKm3dbBt59CK1H?=
 =?us-ascii?Q?UPCtB9VRuHeJ0UsJxTNvkQBM0plXB57g2QD0KXtDdc3onTSGCxpNM9DjiJFT?=
 =?us-ascii?Q?ZK1i8V6CoDV4DsJ2gS5SWyqx2WMKr001JLEUb/w8R6Ft5lwRTmjfBeBYYnZ7?=
 =?us-ascii?Q?fWQ/6WiH0j5NmCnFaRsKze/bV4LPXQAfMHvXTuRialVs0qpnuV8rjiXoDJWG?=
 =?us-ascii?Q?tuGUVy6U2NxL9NX354/xJl4YK/hIRnNdzGRZcK1/3L0ZQq/gmfuJIJwU0FZt?=
 =?us-ascii?Q?UKqUJB575Gaz8QjFBy7hrI2R7VPQJVnsotcphe1b/RNWdkYq4P4Bxb/sl/Hj?=
 =?us-ascii?Q?EqgS+Acv6YRJMFLtSssK6uf4UVKubCM1uAICtM14QOqClImFneASrT3JQf1n?=
 =?us-ascii?Q?0bF6JW8UidGMTi0UlWZmfL0IvDUpD2mcXtVZyO4+L9ffhD8U/P7i62ZW4oV2?=
 =?us-ascii?Q?uls8Lw7YurMdEQ+14wOmT0Hw5cOqANkguCxg3FA3QSMeP4I4yGYEQuNekLex?=
 =?us-ascii?Q?qeC4NgALZysOtQXKuM7occVuhat40PdboXsAom7xNc13JT6bmuH7sSeEikuD?=
 =?us-ascii?Q?MAzsFpgfvESVEinBdp8xMlHsNI0jZtUkpIfDo1Wc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e621af-cf73-4776-95b1-08de25a49521
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 06:43:13.9426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y1IY0nqEGU+D2cpHvX5aYO8R8RWfpMHEPTY4/B8lru4V3iYktG/uuw4aFhK12zBiZdP+kASq9vRUgkM4vvw7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6518
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, November 7, 2025 4:35 AM
>=20
> @@ -1643,6 +1643,7 @@ static const struct iommu_ops arm_smmu_ops =3D {
>  	.get_resv_regions	=3D arm_smmu_get_resv_regions,
>  	.def_domain_type	=3D arm_smmu_def_domain_type,
>  	.owner			=3D THIS_MODULE,
> +	.report_iommu_fault_supported =3D true,

'_supported' could be removed.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

