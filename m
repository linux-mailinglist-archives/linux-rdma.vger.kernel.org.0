Return-Path: <linux-rdma+bounces-10460-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAE8ABEB27
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 07:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE37C7A486A
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 05:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6602422F743;
	Wed, 21 May 2025 05:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a64QLov6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40A28E7;
	Wed, 21 May 2025 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747804459; cv=fail; b=bu0fo5qQuYcoxteUJ/vOh7XvxztpOM6+e9VgHFw62BcWDCnok8f4iBkFeyDjMbPcDNAoOe9wthYIvcz0Ove8TXYtN3ecqBrTWd93tcCN8KpdRehge+Ix262LP0xTDmsq2M9Ll2tBKJRIv45MIBoDRikICsBGbOn+6Icfc3+galk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747804459; c=relaxed/simple;
	bh=otAXwhLTy0rKgf5s269HHlP2TygZVeR0y8TudFBUlzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ChSHEt5czCg3BiTJnxdprB1oNm03L8SazHjKKQ+49DntwvlJprcicmuU3SEplqHwXewyj4hV2pUT8t+yn7Gt/8JHugkRubemGyTHKPH0q6PlxC01QnTfDYJjJdISP9TV5EraWC+8pwPhG9aZh9pKQ+Nwz0U6SbG4D8EtVBlVLA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a64QLov6; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747804457; x=1779340457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=otAXwhLTy0rKgf5s269HHlP2TygZVeR0y8TudFBUlzk=;
  b=a64QLov6oO17DBcm5QUEnEf7xqINoZ3ssZl8u8ySgUv8eePpUPqqVhT3
   K6UqnpMJe+CGPN8w4MGMrzTfshVIDmVRXK+yRZQTOHma1cVEqeiWuCVS5
   Ro4zEU3j/KFtBmaRSOmwphPYNZATZ4Sex4EtyOBap8all0qk8tq0NXTFy
   g1r1OX/IjAqdmpa/btnA+K1WkITjhbidDBZKbQ4eptc3pj5Y4GklbKqvK
   mL7pW0AbIkLg/tfA4T5+xaf6ntq7G82TL2QYB4+d4tPmvARfOsdchhwv/
   aC6Ev7E/ThHVy1OxRaH+20J8hercrdorTLar3dpzGsXDc2vmKNiHRH1Hc
   Q==;
X-CSE-ConnectionGUID: 4NmSBYdpRPuct4GhQ37I8w==
X-CSE-MsgGUID: L9VQfj+MQOS1VPMJaljwJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="61167199"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="61167199"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 22:14:15 -0700
X-CSE-ConnectionGUID: 0ImITnt9QTyvyRt/ZNw8fw==
X-CSE-MsgGUID: Gdqj1WVAQ1uYletXGWHvZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="144645709"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 22:14:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 22:14:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 22:14:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 22:14:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKv6dhEkkZNRElYxWZFTeNjrjoshgZgB+fscgh4f0Es4qyzjkXpHPYky1TSa+plW3J/0PntO5LSyb2Sx4bdd0xlWZMZLyLxfRh2RyQUhKFUaa2Q1oPScQEuaWe1luUShr/l2SjQdctKgtvakEcwNwUA0IEJ9AkvmBbgb1ndQjPdiYDfunWmkCriSlBak7Q+BAiUA2VhW+EpohMR718KFEEaEnr7BnjyBJE8eAtaddTgtaof37m/gMzk6s0S5TGJHDIzq0ldN3BZckopyTTeP7Kl2NV86pF7L8VBEUwv4125Scnnvqtbq24mebH26peORiivB+hSimZEw+oqBIfbl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gxh7lWweKA/mDy0Xjj3XLZoY1rvB/M65yrL8MzVoNAQ=;
 b=YjP80rtfs8Z3ctKFuKGisNP0VMVtHZUTdOyOOfMf+4H1sWDjl4+KRFOHBI1d0FFyGIVJHuh+xTM0NltAyW1GgYyxdfu1/FzpTonrfrkc5KZZ1rxBHZNZ6YOrGXjApvVj5pzIlAn65LGZEC9Wh0PRTHJ8m0TTlQUc3F9CSsIgou3uZ1T9oDIRfMAdKudGZSeLGObsSxFbuDyo235pvFiaUz4q3NnPi+FcrfBdoCBAmAAnRpmiDFOmwTZz4aJ+8E8pb3/qMKoTwR7F26X7W7ORILK+eJoFjlsSPRRQXgGMfI9M3EkX3v1YIHfLqgucAh63ILlO7KoZHxTJeezvFz0Jjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 05:14:11 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%3]) with mapi id 15.20.8699.019; Wed, 21 May 2025
 05:14:11 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net-next 1/3] net: ASSERT_RTNL remove
 netif_set_real_num_{rx, tx}_queues
Thread-Topic: [Intel-wired-lan] [PATCH net-next 1/3] net: ASSERT_RTNL remove
 netif_set_real_num_{rx, tx}_queues
Thread-Index: AQHbycbjEW12aUskwU+Sv/HmqXpClrPcik5A
Date: Wed, 21 May 2025 05:14:11 +0000
Message-ID: <SJ0PR11MB58660E85F76E4A347197C768E59EA@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250520203614.2693870-1-stfomichev@gmail.com>
 <20250520203614.2693870-2-stfomichev@gmail.com>
In-Reply-To: <20250520203614.2693870-2-stfomichev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|MW3PR11MB4681:EE_
x-ms-office365-filtering-correlation-id: e0a2f8d0-4519-485c-9595-08dd98265292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?JwoCLnD3ZcJ36XB1g/Nyns8jXfMQemc+Y0zporW7Ew+K7EBLiZLngsgw9tPI?=
 =?us-ascii?Q?IeW9FDQT72rwPxNPDiQiVzGmI0z/IOLzSvBqYvn4gZyH78QL26OwB5GsmBd9?=
 =?us-ascii?Q?QBnXPIh3z2roMGYqVWATSUsgb3utznJKbuIVqFsFQlfCl75qN8JF9AA2NkE1?=
 =?us-ascii?Q?qUhB5Eij+bsZSRJNVcvUl/m+YVSiba8rGNUkkLjFGSf4oYN1I5oZ18pEEwGy?=
 =?us-ascii?Q?zZwvy1OJa83terjJh0l/Q0c/rpyVR89rmtum6vfaLKTGQLIB2Ps/FjOSC7Yg?=
 =?us-ascii?Q?f4osr3tf7Qzp68aVdcuCTWie0JksVtgxQcGfaqgWDcxxf7MwfDGv1ATo5UB8?=
 =?us-ascii?Q?YwwtZ9t1Z1xjGj6Q/lUwC2GsuOqAwTim0ayBgre5Os9xEn2Yrb2Kbql79wC9?=
 =?us-ascii?Q?QmP1TT4nL73X/5Yab3zw0Rw9Wt0oH0M6S5rv4rgrhByTwsIHaXR+Z7iDFLF7?=
 =?us-ascii?Q?IToqbH6T1ZTHT5cZBiCZRTBip8TDNh5x3+qqAGPV16keLjgwjQOoivWyU8Wq?=
 =?us-ascii?Q?DVwy0BuvwzjS5djfgn9KOUzLtP9MebMh1e/kO4w5wCKdMxH0PPcrqv94tjRT?=
 =?us-ascii?Q?sm/2Ll1mMrT1vWfVe4WKzpKtjFJaeKwdB0R3Jk8eWb39OfGiNLRvdENgj6Wr?=
 =?us-ascii?Q?4djNP7YIowlZPpxCJqPOzsVL4WQAa1O5NI4iQEpO7xrAwX3LiGpiw+2grTPN?=
 =?us-ascii?Q?c+5C6WS9YwDcsjj8r+iR0yFGt4mIDNXkqQgAU1NVFfWVGAFOYuAZg3uzRDnu?=
 =?us-ascii?Q?V27MXRLn5gMly14fxeaH8Ry5b5nlFV5ZmA5yUahCPJ3RtnHALJCLfWkaDhev?=
 =?us-ascii?Q?Di1M/X70PhVpptmOWhWCz7pLt+8lAG7/tHWrbhwY/VxUtgtYsYtbp7/syPJq?=
 =?us-ascii?Q?K5njWAX2HxhoPyZlhnu6Nv0i28fTSASvSoFCM+d6z0kZQUa8GJbp3l8GLNKr?=
 =?us-ascii?Q?6wff/oybgW4ji7CswZ448AKkxb2ItFLLC3qQiK0R6w/+ex5lmBYsPCe8WnM0?=
 =?us-ascii?Q?rt4oVhY0DnPCVSDAlVRrVjpVPtklKq4NZBnU8tEVXxjXWzaQwHjbyuV/Sd4q?=
 =?us-ascii?Q?askG0uXVofrd+VYJxsIc8wMEuhZ6VvpAtUk3HhBh53+UoP7ESKJJ4g28GbBI?=
 =?us-ascii?Q?KgzaLcnBTxAiNhO/D1X31pPJAh4cpcO7At8IlH7YjKQpKfs9knO3oYukipyn?=
 =?us-ascii?Q?M7b9Cb2cH0S2ks4n5NxHwjZS/16ed22y05d6Oxk48Vm2BI4c/IWN1w3pPb32?=
 =?us-ascii?Q?sux9rdHV65Zi8hxYCo+rLm3uDXg/AV0uLhV/dx3hU/qMO7coujQ37ORE3UJe?=
 =?us-ascii?Q?I/VOpWgXoFsVaFSfupefvnU2Yv1MnUA58Ny7YnUkW45JAXR3smGowRT38BjH?=
 =?us-ascii?Q?vouHsLeXwvNUrFi84Wgv6r5QNhc0LDkUb31I6UVH7T69Qk+NqzBAJ2Wshziy?=
 =?us-ascii?Q?CauObgBnqcnQeaa7Msf2fNIaB0q3XewWWbqncB6TL8WctVOtnsLqBg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Scan4HSCaDQHe6gAIBhg9xqjbxpz7kZIY2vdmKAIkmJzj4dxq/mXW96mc2wa?=
 =?us-ascii?Q?9sgmrYEoGRer3DVodJgr8XaB3FLbRSx1YWKip79NzhZocRIcacg+iK6/8BzZ?=
 =?us-ascii?Q?C/DLLjriR0eA45Lcy0c00tZu9C889q0ns675PhdrZ0AJDI+lnOtSQ7IB9RyZ?=
 =?us-ascii?Q?NU2ZRrnHX7VS2M54ynKITIe6CFfZRhiUq0MNwzjELviHv0m7qMTcSJZ038d1?=
 =?us-ascii?Q?H1QBAwcat5Cc8Ujf1VfFX9H5Ukoz0jVnoLzSJ/qMdKN2AJk/Cu4dxkKEhoCX?=
 =?us-ascii?Q?zQ5HGPSPvc1pL6G3YBjlAgXzvOpyLVUu5lVxfk485JlSUZPNFwldjGqBGpCg?=
 =?us-ascii?Q?0+GQPlq/otziEQIUHQgbYg6lSOT5TwCjYGhxod1HZcFI7Tsm8M+H8BxRkS+z?=
 =?us-ascii?Q?F/b4dlOnbst7hUJLvqZmjabVDWm6gSbQiIZbJtPVUG4CSIlzeBVOQpSzjqbs?=
 =?us-ascii?Q?rXFf84Zcg8e8lcZYYfIAmXMuoN/Zdvv6MLoBGWN5HpTYcDUjWQNPAYFZS4Gh?=
 =?us-ascii?Q?ccmELZrpAmb5xaMty/keo8mUENm4sfDNytEVMeGaajBeeOIf621OnzcDYjBu?=
 =?us-ascii?Q?OwY3Ejf3fNkrWVsHIGIAvAy+COznh7iqpS6r3/8gvqQismzff61AME6Rp1Ep?=
 =?us-ascii?Q?gAbTX/KvTk0yqGNOyna5SPLmJcvm++1FIM12JjQxKjVLdGXsSb4i8dLuFKp+?=
 =?us-ascii?Q?S5G36fPf72c9cuPdXcieyKqEgUaEHnCPcHqyk/KwAzKxyblLthYq9cOqW1qT?=
 =?us-ascii?Q?H1eBp3R6rVXeTiUYzEJg22EdYD9aYpMWgMJqLMFDflshUQNPKfYTGJnKjIF6?=
 =?us-ascii?Q?HYP/aBhdq65/CdIJh4+zf47EmDIwEeNdD3EJOQhGdfC0QCAQPG8AZCMHX6qj?=
 =?us-ascii?Q?68tCC0D28HM3rwCQs0mp2H5/dqFqmrzTyBeldHrVOpZuNt+3Ri92R/PtlO0f?=
 =?us-ascii?Q?3DE6qPkC2E4yzyE4IE6oEqL+uTUrPq+4TRRCMpq0zyVhd1G3BGl8CrCVbyYR?=
 =?us-ascii?Q?giEHGEqw6JOptfmjJfzbnG9dkYtv+urELe0SV3php86mZ62J6itWo6oYIkOy?=
 =?us-ascii?Q?Uuj0BRttoV7uFMXAKjizk6+gGAvPvmqq6Cc3BRkg7gYE8r5bpO4aL4EHvOmS?=
 =?us-ascii?Q?hBVNu0aWJJ2K3zeORpmCi/b6/XHTo2RE9rBAH1erPUBgcElD4Wn6g3jJeirH?=
 =?us-ascii?Q?vIBEuyY3H33AGpgh1ImzvU9UycDaGsc0ypIf5V5X6KD6D/Q9NsBsV0o57nJu?=
 =?us-ascii?Q?YhLAWIreJguDld6e3WUmvgnalndFEt+08jtKuHwiLfl6hRTlDBUyegiDBpbF?=
 =?us-ascii?Q?hsS44JcOsxAvwwUoLfMVXi5onV3wyDK8qnSuQYHp3xXORZsg3WJxADoU/c2n?=
 =?us-ascii?Q?Age6zIaBi0uWEa9pZVsfJwBECBONv2qIzu20DUVDT/nFE0PFNhBEU8kftdGL?=
 =?us-ascii?Q?QmiYw98AnfwoCKt/8sRIBX2FSBvXhzLZfFoqHJiXnL0u9mb/zlVH6pAiBsfo?=
 =?us-ascii?Q?UJBViBNv2KZxWnXujCFvhJtd8YQ6oWdn/B+wFJ69y/JmtZWFu1+3tQIS5Sk/?=
 =?us-ascii?Q?SuUNP3JEAjRHEkWoW6gloHeH1du1dXNnYl9AMtgCLJEbpVTIwSs5iCbzSIj5?=
 =?us-ascii?Q?Ow=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a2f8d0-4519-485c-9595-08dd98265292
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 05:14:11.7933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vVJgML+xoz69kkfcwocZNYTuBvsT4pozXM5IV453DfCBKvBH9ZLUN5DzDuNq6+UOT25ExZBBcpytA5dtdOKCneVDFIJXkF4XnZGCPF7gLqE=
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
> Subject: [Intel-wired-lan] [PATCH net-next 1/3] net: ASSERT_RTNL
> remove netif_set_real_num_{rx, tx}_queues
>=20
Can you consider more explicit title like:
net: remove redundant ASSERT_RTNL() in queue setup functions
?

> Existing netdev_ops_assert_locked takes care of asserting either
> netdev lock or RTNL.
>=20
I'd recommend rephrasing like:
The existing netdev_ops_assert_locked() already asserts that either
the RTNL lock or the per-device lock is held, making the explicit
ASSERT_RTNL() redundant.


> Cc: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
>  net/core/dev.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/net/core/dev.c b/net/core/dev.c index
> fccf2167b235..5ea718036921 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3179,7 +3179,6 @@ int netif_set_real_num_tx_queues(struct
> net_device *dev, unsigned int txq)
>=20
>  	if (dev->reg_state =3D=3D NETREG_REGISTERED ||
>  	    dev->reg_state =3D=3D NETREG_UNREGISTERING) {
> -		ASSERT_RTNL();
>  		netdev_ops_assert_locked(dev);
>=20
>  		rc =3D netdev_queue_update_kobjects(dev, dev-
> >real_num_tx_queues, @@ -3229,7 +3228,6 @@ int
> netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
>  		return -EINVAL;
>=20
>  	if (dev->reg_state =3D=3D NETREG_REGISTERED) {
> -		ASSERT_RTNL();
>  		netdev_ops_assert_locked(dev);
>=20
>  		rc =3D net_rx_queue_update_kobjects(dev, dev-
> >real_num_rx_queues,
> --
> 2.49.0


