Return-Path: <linux-rdma+bounces-8800-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3630CA67F5E
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 23:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49D8189CEBB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 22:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8674920FAAB;
	Tue, 18 Mar 2025 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcWOMt53"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D22066F1;
	Tue, 18 Mar 2025 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335669; cv=fail; b=Y8uT6A7GOy1ILxEs53DTlenzLqImUQKFhsUM8KeX7FNS2SMqP1vOuSHT12y5GU5XRFl5dccBMXjySt/Gm7LCuby+wTl7epwMnGnhSZsfb9F15wF/lCtMu+tIjTsBioCLfNd67IxpKmw3Es+Z4QQurr46SZZmSSFhMeBwW55cbIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335669; c=relaxed/simple;
	bh=i0I4NldoK3PuXx52ay8rfpN4+4C/w3OraTewQ61zpfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WhHy3R/bZXVckwQNfIoso4AFCXwtaWpkJZbm8MYEUGUWJHc5442jI/QgWdNlR6YglCDCfEgXsqgHOhsUwQAAt7vwepaPzvFmglDvlRzZ1WL2Ti2rkNyArBtlm1XXoVUgEXqRLfh71F+6PlSCCZ1dfISEsXOp2ak5ALPu7Ak8XhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcWOMt53; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742335668; x=1773871668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i0I4NldoK3PuXx52ay8rfpN4+4C/w3OraTewQ61zpfQ=;
  b=PcWOMt532rh3jbVMQZicWLJFdLvFkpIVqhZ1qPFGgPaue5C/Ukf9PrcJ
   Toxm7wmOmLIl/9r4imlZN1vpshUfDFEV/nuAIe2JZ/8wm+GOWeZjh4d/r
   GXKnxoxBVbkQBHAfbHpevgAt4BB53ED5tGccQ1cR1rRQvmFHt97uTxi5I
   ZizDAuyV/nF/e7cFMq7bRnUYdz5bD5zxpad3rER965Idh1MGwI3ecX//6
   agmOFoTdjDqOzpQ6ABCKfhUTZO6K08wiJM5B7tIIGRuEPs3HpigkEqDZB
   KzbAcxFfgL8umQUl/ElvcAJcpIWkMgc62lsE9yQVSU5ce6+g13r+KEWmX
   g==;
X-CSE-ConnectionGUID: 6xgmuXv1T+GYsCjJgh/Q6A==
X-CSE-MsgGUID: xUavT9ycRNyDX8Xtw90ojA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54495803"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="54495803"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:07:45 -0700
X-CSE-ConnectionGUID: ICbE+oKYQuGpWAVjtuI0Cg==
X-CSE-MsgGUID: 8JhKLLqATR2+2x2+Us51GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="122409799"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:07:44 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 18 Mar 2025 15:07:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Mar 2025 15:07:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 15:07:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9SCYAWlZ6Y0L/Z9iGAfuXZJca0d5tTThHeWyPLifpI+gBi4wg0KuTXoVJYErJ3JQE0iMQRGejtAannJ/Upvw5ejK56jggFswUb35+ecoIDyFNeKZG4qKywbiJI8czYNGZeNlcetgSoguxypvIplWIMwZsBFLdz8EcfJChCXqFLABD0MxBPVkveqTuVTYoq20tbAp9i6Sv68nLcrAbQB1rBUBJVhSRpdWQGWa2O8Vka1eeJ7E93PywmMLtUKrGVIGWW8URUIqN+fUf4UMV5QZd7sR1k/KKP6WN1ZjWhwdDj8LmWGiczo3ar/SDEuGNCfTB/Gake9TkSIHXB6zahntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVHNG68gYd02E005f2+fGZ6TRvA39fSN36d+1xUn87w=;
 b=e2e+fME3khmNCkF0C18tez63XxTDxIDemBXvoeUMBXZlgrDOQgyoq5DjEPJMFoi72EVPZt12oD/yg8A+FvgBvdRC3LflKHKOhY31442MLR2Hz2yP8fqakLyr+HS+H5kAxOvhSoHT2o09LPIXgEUzSMxHJSpgRYbjHxpHH4MAW9Da8D7O+wMT10Bx/Cvjksls0q8suIvm9IBbNGVEJKpQzT8jDLHlMDHht737SL+SGCe4b/a2gjgLCdek22+BsU/y55XB22Ooa6ZLrDE5QdFZ0qu58leuP3A1NLy6lUdbvac5hfgjHDm/Btu/siiwzLlAjD74A/3aODq4wCItZJmB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 22:07:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 22:07:00 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: David Ahern <dsahern@kernel.org>, "Nelson, Shannon"
	<shannon.nelson@amd.com>, Leon Romanovsky <leon@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, Daniel Vetter
	<daniel.vetter@ffwll.ch>, "Jiang, Dave" <dave.jiang@intel.com>, "Christoph
 Hellwig" <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Leonid
 Bloch" <lbloch@nvidia.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Sinyuk,
 Konstantin" <konstantin.sinyuk@intel.com>
Subject: RE: [PATCH v5 0/8] Introduce fwctl subystem
Thread-Topic: [PATCH v5 0/8] Introduce fwctl subystem
Thread-Index: AQHbiXePa8N9PItF+EWGRwtFqKO2hLNiPacAgADLBACAALM5gIAA118AgAAaqYCAADTOgIAAAzuAgAwuoACAAAUBgIAAeEcAgAFzvoCABFkNgIAAbCyAgAAZqnCAARmvgIAAAVEAgACRemA=
Date: Tue, 18 Mar 2025 22:07:00 +0000
Message-ID: <CO1PR11MB5089FED1E4623016EC9E0126D6DE2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
 <20250317123333.GB9311@nvidia.com>
 <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
 <CO1PR11MB5089AB36220DFEACBF7A5D1CD6DF2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <2025031840-phrasing-rink-c7bb@gregkh> <20250318132528.GR9311@nvidia.com>
In-Reply-To: <20250318132528.GR9311@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|PH0PR11MB5901:EE_
x-ms-office365-filtering-correlation-id: 29cb9dc6-03f5-41a8-e16d-08dd66693509
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?biTXH82icej4ds2YI7s9JnJfog3zFeKXExdQrpveUb/uRhUOLMEMuwkJtK9B?=
 =?us-ascii?Q?3y0eVkU3LXZQRvVqVjH+qIi5swzpNQm08yGQX9NIdI4dFokmvcjd1uc/FNKX?=
 =?us-ascii?Q?FABQTH1Tc1OSYgJ1N7TyONo/CdPemLeaZSmGkoHgpyI8zo/pNx5THpu9gwAS?=
 =?us-ascii?Q?Juemf6TGK66PP0qGMAYP1nSiLl3E6POHSEEQ9D7dAc/0jzyx03TlJhjM8G8w?=
 =?us-ascii?Q?uPh0Bj+5b7zUidoCxwD0fu9b3OjQ/XBclnQUIeqLC2kNO+4/T3WnxH+yezCs?=
 =?us-ascii?Q?AV9Ng7dQPwgM+/HJy54jJRJL1s/X6Goy7G3WA4WRD0eFNO7Wd1fp191ITWCg?=
 =?us-ascii?Q?XlD2teysI90BAO4UsoEiKbuRf1nREDLjOIlpedq1A+cpGQjttIDTLfwAKOa4?=
 =?us-ascii?Q?lMu2uiB/tWopWypgcKD8TOYuFHk0JAYkAS79U91IDdlQ7YWKllgrxyEb0kGc?=
 =?us-ascii?Q?PHDq76sn8HZZuDT67QXvxPSdgAYqtQDbFI3kI7JWzeT/BdP8DpQvEvQT2Lya?=
 =?us-ascii?Q?xHnyuNNwc3/nogpQykLdoj/arG3hlANRH5d0tx7TIEzpih5WU/UY1ycqfqIz?=
 =?us-ascii?Q?W/zTEJ6n/rkZalDmoqQbdzUXquytyg45qvLgv+ho6kHQqVTll3VBsiekHX+Z?=
 =?us-ascii?Q?5bJBtQBYM4fM3S7GumUyXRHJyzVzOI3J84cvkRzsoz3y+zRqL5tlP2cLCN19?=
 =?us-ascii?Q?mShTPBCAirLVgWxAEJp2bSWGqnrpJDQjn/8OLQisWP7XR4+LF3gLnFk7yrO6?=
 =?us-ascii?Q?sP7qQwaJCv5TtwG0o/YRmsBHAHmHQ3/I5szFmoqaQ9khKOPJ1cPODOPz/lRe?=
 =?us-ascii?Q?HESsIermYbe7O4WNLjd7e0c6c5zH/cN/DZYi14X52MTLPrMRemCMMowKWL3h?=
 =?us-ascii?Q?cl8fdeG6flc9ntAZdchOrzeJStwcyt1XWUlUwRV3LmuQp4eNnoUmOMo1XdWq?=
 =?us-ascii?Q?mlJULgvB8Ili2fkyQDoTdXBtxseZBKzNw71EzFlcCq5TsABfT9NSgp+5auMK?=
 =?us-ascii?Q?vm1jGOZuCn9fzXl9u8G5haBZWTKEs8MEwXDnAcrBOsV/ih9O/tQZBHN9ildU?=
 =?us-ascii?Q?qUav+gV+huJwCljgtF/Y0o6wgrsIlTgbl/IzvYJB+oQsd5AImGtowmC/nudO?=
 =?us-ascii?Q?pRtMkn9okdl8Ue9CpFNgUQHaa7r7BP/iDoPMg+R4mb9xKRpZbVrmXNKxKIPQ?=
 =?us-ascii?Q?+khRGNLpsHslAnne9Jl76s6YD/Qs9f1OlO4EcUs5VOeSZvjivsx1+t2enOcg?=
 =?us-ascii?Q?7zmT4odyYy6phBIWH6bP5TJmSdx0ADQmScfV/THBM4XX6Z/yE7374dR+8d8U?=
 =?us-ascii?Q?GoHrtBWUWrb/S3m2rDYK1A4Cwioe02gG1RUL7abwb8cSH8LeKUliFRq5Mmlc?=
 =?us-ascii?Q?UAVnf6pqAmUZoh1W7Mt/09E+Vbc7rCCORzvXRAbsUAk6Fb/gWfu1NRwhgWt7?=
 =?us-ascii?Q?PEQp3NU5Rs2Kiucl5BcPsqoXxxePysr0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gz6rothpOvaUplf4Y0od+v/Fp73CE/9MnsL5MSqFUHwQTlDmjqKzlxB7rqUm?=
 =?us-ascii?Q?p/IfyIFvlnYBpBZjRkqc+KBch+vaBT+lv6q2ODHaO3woSPZNVFz6W0teuquM?=
 =?us-ascii?Q?/RVNfGKOkWf4/0Hee3ib4ehu/YagNvrTg9WiDArtrAurXqqkW5kE3tHu2jT5?=
 =?us-ascii?Q?W5iUCphFR4Bd6Tr0o+KhjUE3G8Kop7KfaHT26wWoT8Eug32vFojfwdsys7L+?=
 =?us-ascii?Q?TYvTCtkmscg8/i+qMpQefBb+dgdFVmE53qVHeBSTvaRZx2INIGJ2SDK4IvGr?=
 =?us-ascii?Q?GtmWEeG/HZICIorovDr4O2sJZrs8jW+EcCvL3/3QmUD0Pei959ZjH5GvI9yK?=
 =?us-ascii?Q?ZjBEGClLvvEXMslqXc7tghiB30fPPzP76F+Ge+NaUef8bOCA5Rucmogg8A9K?=
 =?us-ascii?Q?bhIiLQDHsL62bmLUbUWGsp3HboxqcFmajLhHlSbvBT3TNHxkrKb03do0ab3l?=
 =?us-ascii?Q?EGevCNlkuidzMjkiAfBz2zl+5OM6CGEBWkqf85sAV326AgQ87lLp4KiwSDEe?=
 =?us-ascii?Q?eDNmNX/npr+Gspn5VnZhPQPjbZDqhqh3IjTs4O95WwZz9T0HtSWFTPCXinVY?=
 =?us-ascii?Q?dJsYoLpL9lbNCt4bWPRics3+sDpB4Z6/WbgvcwvRILBtrbtTpKgiJnZSGxj6?=
 =?us-ascii?Q?Xnw0YthmHmthSvLdcTsVY9bVuzJ1xzFa8UcoBMPQaV+r9WtKaiOF+fi/qdqS?=
 =?us-ascii?Q?l9m5AsL2XNPkqjBZPhTjncLCbZ32AbS9aXrXFhUpkQ4rXphBzCMAytFzngQz?=
 =?us-ascii?Q?GeKultK5ykz+2HSzvJ+fS5uXS17rDbnhPUp9mY6Lie+AudMWdO7gYqKchrnv?=
 =?us-ascii?Q?IUjiWkR5/W1SchaqNUXi6W1xZwRGuA8O9RhmVRD18I10eIEmFuclvQqFKAp8?=
 =?us-ascii?Q?bPQ3QxzPfaB0gbz2/0616OsF45AsQND9x1pCsIYofgR192seaHeXmJ+hcDNa?=
 =?us-ascii?Q?tEs32g4HGmkoo5QvFspquycPYShzprbPGXlOpL5AyE5GSHsUp2ybYm6rjEop?=
 =?us-ascii?Q?a+qrShlOGdJv0EobOFEnOXVzxsT44Lbp8UF77zTM6HVCFpisZGTmJZvX7e3u?=
 =?us-ascii?Q?3UHu7+IYhf1aG5y2VOQzRQhGEs1iQHKCVQ+84ts3DuanEbKjXA+nhQBLKoXz?=
 =?us-ascii?Q?obTMNHqScUdMJzIcUJhRgOCJvg+mNV/Jy0NAUPUKpPPP1rYCtrPp1iZGGtgp?=
 =?us-ascii?Q?l0EG4Rwt4v/7wFoAGwhy+KruGY+a4t6rNl0pqDxoSzrgKoJI0nHK+wu18wui?=
 =?us-ascii?Q?LC5/bzmQrxhfqz430ovT1LifJK2EZtSyHXed5WUylJkaRRViTONUhu5qh+c6?=
 =?us-ascii?Q?1iLC02XLMrr47AdGG1gEMXMPeUoLmp3Chs1xaZy5WQqGyrIqpj7h4YlJpA6t?=
 =?us-ascii?Q?FOHQLFI2BOIn9+igfjvsOX96O6fUWATknV9J+7aS4toXShBnc+RGwYcsVxVw?=
 =?us-ascii?Q?p05yL1vjgO5b6kuy5FDps3Jmza0qEAlTvH3baLpjzoMYqEDxD635pNezolk7?=
 =?us-ascii?Q?S8DCOg9/HcbNZLkfyEI2IZpAkXPhcwphc5172Ptrm8mNYvx4kyIeT5CaBYsm?=
 =?us-ascii?Q?7ffkiwL//Fd8pX8Cn+mPnuTkboW6ViaS+rj+mz9O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cb9dc6-03f5-41a8-e16d-08dd66693509
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 22:07:00.3573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiFwbcLV9jFkf1qMicnf2rr5XYHVrsyy+5cRHoCHdrJxJTQalmMCrIVbcwp1hKDalyFWtGF2D+pIe0V5iCNpWWF1s0bfYFI+gusLP/+ptT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 18, 2025 6:25 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; David Ahern
> <dsahern@kernel.org>; Nelson, Shannon <shannon.nelson@amd.com>; Leon
> Romanovsky <leon@kernel.org>; Jiri Pirko <jiri@resnulli.us>; Jakub Kicins=
ki
> <kuba@kernel.org>; Andy Gospodarek <andrew.gospodarek@broadcom.com>;
> Aron Silverton <aron.silverton@oracle.com>; Williams, Dan J
> <dan.j.williams@intel.com>; Daniel Vetter <daniel.vetter@ffwll.ch>; Jiang=
, Dave
> <dave.jiang@intel.com>; Christoph Hellwig <hch@infradead.org>; Itay Avrah=
am
> <itayavr@nvidia.com>; Jiri Pirko <jiri@nvidia.com>; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>; Leonid Bloch <lbloch@nvidia.com>; linux-
> cxl@vger.kernel.org; linux-rdma@vger.kernel.org; netdev@vger.kernel.org; =
Saeed
> Mahameed <saeedm@nvidia.com>; Sinyuk, Konstantin
> <konstantin.sinyuk@intel.com>
> Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
>=20
> On Tue, Mar 18, 2025 at 02:20:45PM +0100, Greg Kroah-Hartman wrote:
>=20
> > Yes, note, the issue came up in the 2.5.x kernel days, _WAY_ before we
> > had git, so this wasn't a git issue.  I'm all for "drivers/core/" but
> > note, that really looks like "the driver core" area of the kernel, so
> > maybe pick a different name?
>=20
> Yeah, +1. We have lots of places calling what is in drivers/base 'core'.
>=20
> Jason

Core is quite often used like "the core of the kernel that is non-driver st=
uff", i.e. "the networking core", "the PTP core", etc.

Naming things is indeed hard.

