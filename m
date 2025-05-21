Return-Path: <linux-rdma+bounces-10461-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C08F5ABEB2B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 07:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB461B66162
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 05:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F04B22D9E0;
	Wed, 21 May 2025 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faD8zz/9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271391A5B85;
	Wed, 21 May 2025 05:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747804591; cv=fail; b=eYAdmZ3mouVuaW1V0ghR1yHgnxQBISvPH0yFub7THPD7IgclIKyFwRA9dhFNv+ivNIQZL3ix3VQVmeA3bXZ5IHysyK6RKE4TIX9fNk2UgzvrB2PZdb66ZybT1gcEQD11VSzvawwWdoIGgRakh+KhZnud9dhjqLHPNPMtBvw6ZH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747804591; c=relaxed/simple;
	bh=OZquuEtoHJ97pnbJK+Kq6KhoeUuptORQne/Sh5eOfUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oAdQil7q2EZpg4GYWaTCjTymkBmDvglp2eAa469qng7HIbuZDSqzrqOHjiDM9pYe7pcimcNYZxpUwOb8KvWt/AjncKYa3fEUUfptoLURloimEZr8dGuPE8xdW4G8H779LpSQ+14SARVOkKcgZdqHiEewCJxuajPDCqCT9SimJRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faD8zz/9; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747804589; x=1779340589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OZquuEtoHJ97pnbJK+Kq6KhoeUuptORQne/Sh5eOfUs=;
  b=faD8zz/9G3EMvzLlmE3H/x4pRGL3HPC5IedsfraNe1YdvtUC3oPxHULV
   sSrQr27yET9rQXzKOWpPX0/8AHyNNO9yoIsBwVPzdXOFJelvypCJ3zeT9
   5+D02jIyGfiOALqklOYBIywqtZMyfZCWuQxoUrEYbWK5PvFiSp2F4wnPa
   PfJtT3H3qxFmB0hjbjudlVagqc4dzdeY9ubIAbH/lz8Bd44HCBoGJ21ur
   R7HGFp7Rgqv5sF8oEAzsaiDQ05B0rWQjqN52pMoHSWSUZSZE5eaEQl++3
   ebjD331av+btqkxyTOFEYflFKUFGFzO4YC7zLygxz3Li2ttEjungk+gnO
   Q==;
X-CSE-ConnectionGUID: itRt1G+wSx2QqDWCvMgchQ==
X-CSE-MsgGUID: iLSOtYrLRRWUlIdOCd0n4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60802944"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="60802944"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 22:16:28 -0700
X-CSE-ConnectionGUID: tqpEJp21SNOz+fJWpnJYkw==
X-CSE-MsgGUID: O+6c7RwjTz6/U1o7vwrXcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140437078"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 22:16:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 22:16:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 22:16:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 22:16:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DB0kjsu9BG22CTJB9l64mb6UF8hPJbAlbLYCCQQ4i0KHr2l0itgF1IVvr890VpaYZJGJhqdRafTcii9VixuJ4ldh4Yp6Oh34ZfysBQRnRdox80cIQGmkh71Xu3m4OaiT7ISvF1XWxzckyqA20rnPnxlUki2U6OcL2mV5NgJEG1eWINQzmyFaw0oHSjiANnqQsTXa+PulsC8ZibC7QOued6ClZp3hNqZJ1WKkTF4FZU6TDiX9QnzeSJQubddvKgU4jy4aw5EvqNfaVpeNUt7zI5AzLagimFi1BgIdSnGvBFdudJbE2eB3Y2IinAidr2VTC7kz0FLSHb7i8GmLUdioiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHpAdeOorm/+0RNiFfg59mD5alW41QTJI7nPLRPccx0=;
 b=CzATO5lFN5j6kI3oTlCJ9hAkj2cmPp/FjHsFK+MwMxJr6c/lDE/RsqZBfyTtlnmmHgZJc5yFk2CPQ0nRUoR59XVWklsvNW2DvJY13Yrl1AsERaERNS64xCyW8TZN/hp2vnHZbe7/zwfYXZYbgNUzKSKdTf6J20Z3Qdia9K+H+el2ah5lPX2CE85wcPRr6sThziD3LaPB46uaa+T+HOpSA6ceuyv6wSEs30tN6ggCL7v2tOEmAQoCvKPnjlz+G7R3Rr2L2VE4PM2OMt2F0aL+MFA0Tk/9erVLKupHgfI/Od8eH9uSV7dDrcNUvvqnuY/57MD7XvLh7myLisqOtKx0LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 05:15:56 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%3]) with mapi id 15.20.8699.019; Wed, 21 May 2025
 05:15:56 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "skalluru@marvell.com"
	<skalluru@marvell.com>, "manishc@marvell.com" <manishc@marvell.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "pavan.chebbi@broadcom.com"
	<pavan.chebbi@broadcom.com>, "ajit.khaparde@broadcom.com"
	<ajit.khaparde@broadcom.com>, "sriharsha.basavapatna@broadcom.com"
	<sriharsha.basavapatna@broadcom.com>, "somnath.kotur@broadcom.com"
	<somnath.kotur@broadcom.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "louis.peens@corigine.com"
	<louis.peens@corigine.com>, "shshaikh@marvell.com" <shshaikh@marvell.com>,
	"GR-Linux-NIC-Dev@marvell.com" <GR-Linux-NIC-Dev@marvell.com>,
	"ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>, "horms@kernel.org"
	<horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>, "mheib@redhat.com"
	<mheib@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "oss-drivers@corigine.com"
	<oss-drivers@corigine.com>, "linux-net-drivers@amd.com"
	<linux-net-drivers@amd.com>, "leon@kernel.org" <leon@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next 3/3] Revert "bnxt_en: bring
 back rtnl_lock() in the bnxt_open() path"
Thread-Topic: [Intel-wired-lan] [PATCH net-next 3/3] Revert "bnxt_en: bring
 back rtnl_lock() in the bnxt_open() path"
Thread-Index: AQHbycbr9mzGc/i4BEugEh1PC1rUQ7PciztQ
Date: Wed, 21 May 2025 05:15:56 +0000
Message-ID: <SJ0PR11MB5866E19DD8B4B386B87C5416E59EA@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250520203614.2693870-1-stfomichev@gmail.com>
 <20250520203614.2693870-4-stfomichev@gmail.com>
In-Reply-To: <20250520203614.2693870-4-stfomichev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|MW3PR11MB4681:EE_
x-ms-office365-filtering-correlation-id: 27cf074f-df4c-4d6f-174e-08dd982690c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?a5J8mo4L15MiZYC7mrkGXjHi3bDgvSWjqPpOeEXSSgOfJ4FXo5DAbXyyJQt7?=
 =?us-ascii?Q?fHPh6vZpst2hfgXbmGl9PJxAmHs/Z6GZJMaIvndL2ElDSxjaQSvPQAsfN5ye?=
 =?us-ascii?Q?D6zDHGA2V2b/LeDSa+sa+VRia387x9Ut0ilhgMsK07KWD4EQDHmtdtKtXYT1?=
 =?us-ascii?Q?qb8p7kIatDiFKWLg3lb5KmksbscJmEZH44IMoyVwv5Gs0wjM0772oVTUBcLi?=
 =?us-ascii?Q?yFwcI81Dr9LGZl6NJch0tu3eUlSlNXBR4PIusjxxKgM0v+E+0Cbhjhz323f/?=
 =?us-ascii?Q?0olqeST1Ru1zfaj5yPNs8gX27ESwm2dRKR/gdACghQMZ8pruhfad/lhCkK6q?=
 =?us-ascii?Q?mwmox+kkaXwifHfsrVPtRjKzqq+QXdtnmN3ZCZyovML1AJKVsUKJOkrec4rC?=
 =?us-ascii?Q?x2MlkkHXP7190cWp8BBDU4Occ+Ql7sYOKnfT3AN72MQPMTGcEm1qJIwMvY3L?=
 =?us-ascii?Q?ikYKb6GGyOpQUGftl7U2OtGv+9wQqspFAy2yfrRcFqk70uOwvjmA2mJ/zXA3?=
 =?us-ascii?Q?BKpVSbqi1vUN1dBuvgWFuAuStnTJY5Ygl+Baz2GdY3uqN6QszCjt7w1moqGi?=
 =?us-ascii?Q?vPxsNZiVdouE12VI6R5maJW7sXNSSdRHkDO6FI9To1oqK5leDoh5AQsJ9QPz?=
 =?us-ascii?Q?QzjRdd4iJhtv6vVR4ZgEy8/cwkBq0+/YqEBgNfuinKNFOxkGJjMNdcCST/oQ?=
 =?us-ascii?Q?++CWl7yX/fW7REdZ+7FHsFhs6rORTpO8/8VY5mcMQLmp0tYACto26IlcMMWq?=
 =?us-ascii?Q?8SmJYNc9scjeKxvMGbytX1RR/wRUNXBV979X6AtpNdW5ojxAoGtseuXztTTF?=
 =?us-ascii?Q?jykV64qrT6S/IjhUZ/1yD2+4xW9VWEWB724Hj1b+0UJNM3GMsSpPdulGfq5a?=
 =?us-ascii?Q?P9YmUmPUJGcrTbO3Yq6foNTz+csT7HhN2NEZws1ZokXo9mQscNyEzaQJkgRz?=
 =?us-ascii?Q?Od4OsMb5iHn16YVnXue3rykdeAx2N+50Lb26x2FChri3PdC39ARWgMDoctPo?=
 =?us-ascii?Q?V9mm68OAhY4qIuxw+gSfPo6YKLS1lOV2HGx3CbNb56mhUlTOvVL7ZDjiLaS6?=
 =?us-ascii?Q?+QAu5UtxpfukKHKYgsY/ECLmd9AsSqaFIQ+XA9Swrwr5iaOeOR8vOL3XA+Pp?=
 =?us-ascii?Q?gMpHqJTqlFxdeBe0+NBEVl1dBGJt5vzgLXujFnLKcBymcwvmS3fZUiCJ7/FP?=
 =?us-ascii?Q?mC8o3RtHPrZx5v+Btza9saGASlSCVujMhrV00NzePikWFYl59UF5zs6aL9/Z?=
 =?us-ascii?Q?h1wXlD9/U3yVEqEreeL8XNMGzVhkire4m93wbPqLb4uyuiuph62QdT/9MCmF?=
 =?us-ascii?Q?uKZTCvt7viqucbDQ0Vl7mAUQn9qKdgTo4SjNGPjYBE2sizLwBcGwfT2TitfX?=
 =?us-ascii?Q?88vQKZdeeh7ODOrNgRe7rTU2TwCmvwqp5wOCOLi84F0MhMyJQoz1PkAcjxwc?=
 =?us-ascii?Q?8caXKs5KojB24+jZAw0llJX9RWjiBYBadRM7xuVavDIRhHIIM9yZMw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gCSkkaQdAfpPOdC1nrhLvr6pdgm4GXEU1ys6tBi8uho6Oz2UGJiynW++6usG?=
 =?us-ascii?Q?SAMDkAcFghl/IaMC/X51u7y5Aty6VdED5lNVrGJa+I1idA3Nk0FfddLAdA0U?=
 =?us-ascii?Q?mq8mLRTKri3UC3rNpcfHXzFf9uYAkaDxybbpxS6+PjdsQ4M6CG2CcRH4XO01?=
 =?us-ascii?Q?X5IeXKeeufjos2uA/gkI44bvMDaObavlVjMPmGxjWr9o2t58YKpRPcAZKdtK?=
 =?us-ascii?Q?XpAiAr6GiFj4Qoyr9xIOz64k/OU8EOi5+VTS9Od/GHOBmb+b8p2WaSxiCECL?=
 =?us-ascii?Q?d3hlCQFvzIpc7Nce9VmM6CIoYHROfP1e6qG+GLHx6oVOVjjMSrAegrdOHBDa?=
 =?us-ascii?Q?yqX8YRB0Yb36gJOqTxY6r8uKqjb0aG7HW/fjDvZvoU1iAhyemf4OiybaMnkD?=
 =?us-ascii?Q?riD73dvfAjEWYf9KG8Z+XFqXC4uKgt008K+Lx9NVDC6Ass0Igv4yUNIpA7cR?=
 =?us-ascii?Q?oMbHx4azbZ8bN+d8/kXvj0hqZUkUpXI4XNvLynPFjnxvDp5HEy4FFhnOIIp+?=
 =?us-ascii?Q?R+4ew+xV4c2TVU2TWEHTQtQbUd48pJHU02cs/W0Js0ai/tOQA+dS+PTzLXoW?=
 =?us-ascii?Q?6iARbKGlSR5BOjuBO2dCGy0+fpYBiKPivDcku0+EN1om9fEwHoz3WmoDENJ0?=
 =?us-ascii?Q?uN0ILm1Mv7/mFmolzFUshrTzs9PuWygOpD58E/5uDtBFIUBUpiRZdztiPF3h?=
 =?us-ascii?Q?00atpqy+iSQqiMqkqp2I7xXuiULxGh6NV0CRvKUpCVs+uPPSsO8LITz0MDKE?=
 =?us-ascii?Q?trEmIAxzfyO2rwwbP6zUTbUNWIKshn949mAWtYt6QlBDKhyTDiUocl37r+Zg?=
 =?us-ascii?Q?PckCphzLErTAfnKX8S1uroufbD7jmyiv0UfGexKaxjbsxtCuEX1WTIhBIBNE?=
 =?us-ascii?Q?/OmxhkDkZHIqmh4CVmlgU5cUNHKofM2t1S+Gjieh58e1644OMqpzJ2XvCqFd?=
 =?us-ascii?Q?0oYYRZ0kRr7nNth7d6x5G9cKPBhoNLTjpOS+bad+RRIQYRGXz5YRSf2RMrwR?=
 =?us-ascii?Q?Blx4qIbNI8mJnf4Wyle8aX9JgGkwbs1osi61alfO8Wsu+MBOlaWINnkx6Gh9?=
 =?us-ascii?Q?230ekcqikjju9G79RH+wbF9mimbdkbCzs5IAkbmMll7BKIx8jlr3YCPCTSi8?=
 =?us-ascii?Q?pzGsMm5nAKbzqpyjlGNjtTgW0mlXAvQt8TBSRzsVNS8ZCE/z6LWi5Bi+zoAc?=
 =?us-ascii?Q?AF6hChQJU2y6YZYKAimjb5g5+RXXVnvApuyJUMeQE7Ke57ssPAhFT0osKBko?=
 =?us-ascii?Q?He0TYDCp5nvpQ9qE3hBG5ebTUCOG7zB5v+DYjHLufsGA/W+nz+fyT+NkaP77?=
 =?us-ascii?Q?FAOXGMlSFzPpf6ggqlWLrB/29r5uXlgip74xOqlrE2UpzgURH8rCrBSNUWfd?=
 =?us-ascii?Q?6r1If0+35DcaXUJA4dYKrWFO0NYCv7ayqGg5QLJ5KtLHay4HW8kH0iCWpfre?=
 =?us-ascii?Q?UuuG6szO9LA9l+wfvgobN6Y3bkCtJvD+RMyCbFojvITQHAjthu13S7CjRzyS?=
 =?us-ascii?Q?hUerWMPRBwaAaDPkwyrJTTCXH49gJ3uAYItmerwC+k7/IcmuUragbRj67mX8?=
 =?us-ascii?Q?m8iAhpHVDfyA1YLZWwtPk3fa3pKrs1Kc3PRr9/UqcqNKYtVVYoksyc0CAlTJ?=
 =?us-ascii?Q?UQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cf074f-df4c-4d6f-174e-08dd982690c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 05:15:56.0898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgUXcSgN0sJQowUrh+vQpQ6ljlu22Zri1Yjkm2GaHqEN/CHlPMIXX5VcFfxkPDWVUTEz/fNthK/OfxHbx3dK6LGBb6l8EHW0EwJirY1wGdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Stanislav Fomichev
> Sent: Tuesday, May 20, 2025 10:36 PM
> To: netdev@vger.kernel.org
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; skalluru@marvell.com; manishc@marvell.com;
> andrew+netdev@lunn.ch; michael.chan@broadcom.com;
> pavan.chebbi@broadcom.com; ajit.khaparde@broadcom.com;
> sriharsha.basavapatna@broadcom.com; somnath.kotur@broadcom.com;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; tariqt@nvidia.com; saeedm@nvidia.com;
> louis.peens@corigine.com; shshaikh@marvell.com; GR-Linux-NIC-
> Dev@marvell.com; ecree.xilinx@gmail.com; horms@kernel.org;
> dsahern@kernel.org; ruanjinjie@huawei.com; mheib@redhat.com;
> stfomichev@gmail.com; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-rdma@vger.kernel.org; oss-
> drivers@corigine.com; linux-net-drivers@amd.com; leon@kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next 3/3] Revert "bnxt_en: bring
> back rtnl_lock() in the bnxt_open() path"
>=20
> This reverts commit 325eb217e41fa14f307c7cc702bd18d0bb38fe84.
>=20
> udp_tunnel infra doesn't need RTNL, should be safe to get back to only
> netdev instance lock.
>=20
> Cc: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 +++++-----------------
> -
>  1 file changed, 7 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index a3dadde65b8d..1da208c36572 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14055,28 +14055,13 @@ static void bnxt_unlock_sp(struct bnxt *bp)
>  	netdev_unlock(bp->dev);
>  }
>=20
> -/* Same as bnxt_lock_sp() with additional rtnl_lock */ -static void
> bnxt_rtnl_lock_sp(struct bnxt *bp) -{
> -	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
> -	rtnl_lock();
> -	netdev_lock(bp->dev);
> -}
> -
> -static void bnxt_rtnl_unlock_sp(struct bnxt *bp) -{
> -	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
> -	netdev_unlock(bp->dev);
> -	rtnl_unlock();
> -}
> -
>  /* Only called from bnxt_sp_task() */
>  static void bnxt_reset(struct bnxt *bp, bool silent)  {
> -	bnxt_rtnl_lock_sp(bp);
> +	bnxt_lock_sp(bp);
>  	if (test_bit(BNXT_STATE_OPEN, &bp->state))
>  		bnxt_reset_task(bp, silent);
> -	bnxt_rtnl_unlock_sp(bp);
> +	bnxt_unlock_sp(bp);
>  }
>=20
>  /* Only called from bnxt_sp_task() */
> @@ -14084,9 +14069,9 @@ static void bnxt_rx_ring_reset(struct bnxt
> *bp)  {
>  	int i;
>=20
> -	bnxt_rtnl_lock_sp(bp);
> +	bnxt_lock_sp(bp);
>  	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
> -		bnxt_rtnl_unlock_sp(bp);
> +		bnxt_unlock_sp(bp);
>  		return;
>  	}
>  	/* Disable and flush TPA before resetting the RX ring */ @@ -
> 14125,7 +14110,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
>  	}
>  	if (bp->flags & BNXT_FLAG_TPA)
>  		bnxt_set_tpa(bp, true);
> -	bnxt_rtnl_unlock_sp(bp);
> +	bnxt_unlock_sp(bp);
>  }
>=20
>  static void bnxt_fw_fatal_close(struct bnxt *bp) @@ -15017,17
> +15002,15 @@ static void bnxt_fw_reset_task(struct work_struct *work)
>  		bp->fw_reset_state =3D BNXT_FW_RESET_STATE_OPENING;
>  		fallthrough;
>  	case BNXT_FW_RESET_STATE_OPENING:
> -		while (!rtnl_trylock()) {
> +		while (!netdev_trylock(bp->dev)) {
>  			bnxt_queue_fw_reset_work(bp, HZ / 10);
>  			return;
>  		}
> -		netdev_lock(bp->dev);
>  		rc =3D bnxt_open(bp->dev);
>  		if (rc) {
>  			netdev_err(bp->dev, "bnxt_open() failed during FW
> reset\n");
>  			bnxt_fw_reset_abort(bp, rc);
>  			netdev_unlock(bp->dev);
> -			rtnl_unlock();
>  			goto ulp_start;
>  		}
>=20
> @@ -15047,7 +15030,6 @@ static void bnxt_fw_reset_task(struct
> work_struct *work)
>  			bnxt_dl_health_fw_status_update(bp, true);
>  		}
>  		netdev_unlock(bp->dev);
> -		rtnl_unlock();
>  		bnxt_ulp_start(bp, 0);
>  		bnxt_reenable_sriov(bp);
>  		netdev_lock(bp->dev);
> @@ -15996,7 +15978,7 @@ static int bnxt_queue_start(struct net_device
> *dev, void *qmem, int idx)
>  		   rc);
>  	napi_enable_locked(&bnapi->napi);
>  	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
> -	netif_close(dev);
> +	bnxt_reset_task(bp, true);
>  	return rc;
>  }
>=20
> @@ -16812,7 +16794,6 @@ static int bnxt_resume(struct device *device)
>  	struct bnxt *bp =3D netdev_priv(dev);
>  	int rc =3D 0;
>=20
> -	rtnl_lock();
>  	netdev_lock(dev);
>  	rc =3D pci_enable_device(bp->pdev);
>  	if (rc) {
> @@ -16857,7 +16838,6 @@ static int bnxt_resume(struct device *device)
>=20
>  resume_exit:
>  	netdev_unlock(bp->dev);
> -	rtnl_unlock();
>  	bnxt_ulp_start(bp, rc);
>  	if (!rc)
>  		bnxt_reenable_sriov(bp);
> @@ -17023,7 +17003,6 @@ static void bnxt_io_resume(struct pci_dev
> *pdev)
>  	int err;
>=20
>  	netdev_info(bp->dev, "PCI Slot Resume\n");
> -	rtnl_lock();
>  	netdev_lock(netdev);
>=20
>  	err =3D bnxt_hwrm_func_qcaps(bp);
> @@ -17041,7 +17020,6 @@ static void bnxt_io_resume(struct pci_dev
> *pdev)
>  		netif_device_attach(netdev);
>=20
>  	netdev_unlock(netdev);
> -	rtnl_unlock();
>  	bnxt_ulp_start(bp, err);
>  	if (!err)
>  		bnxt_reenable_sriov(bp);
> --
> 2.49.0


