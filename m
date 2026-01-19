Return-Path: <linux-rdma+bounces-15687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74121D3A08A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 08:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78E4C3011EFB
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 07:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E28A3382DF;
	Mon, 19 Jan 2026 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arPdwWvn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D59500964;
	Mon, 19 Jan 2026 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809029; cv=fail; b=lJbGzz4NLRDzWFllIdbw9g9DvNjCQM6aKm2i3cgD0sSHvtKsOf1T40c1bUwbCBlTREeA0UtDx5Um59+dBSCBxwo0UT3Ba65+q8idEpizj/+M5nspu8dX7e/WLKN/Sf1onUUzBRA1o40rbqyjLW6ciGTnXKyo4z4lmLQc2P1msNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809029; c=relaxed/simple;
	bh=lSa3B1z9bkJyX54cukNbBfdG1gjB5HH+U6UABT3p0oM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MXF8inM47PPPHTUgar4mUfJKJ/iYU0NOFn4HhVwu9HQ587kqmlL/52szd8ecDK4y4vEuKW/KKU0t2fj1W0rjYkHzkCI6XoAjnxEnqC9OtzYet4hfqqvr67Ik4dtjyivtwXW1NiDDz8DYGlpI+hHLGVBsssx9MMw6ODevVi368Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arPdwWvn; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768809028; x=1800345028;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lSa3B1z9bkJyX54cukNbBfdG1gjB5HH+U6UABT3p0oM=;
  b=arPdwWvnIk0rSd7YABhCvte4bhQGRP/4NZzC9QeGIg052c8s3UpLdpb/
   Edov0JfUzt64WhNkMdPovkdk8o2e0ybB51IaOMIxCRJMVkY+e2LkauQSD
   hq4vhK/aAQQ9KDMnSZ5IUHypg+2LbI5bKzw4vBUH8t1QDwQyT01xBtbic
   mQm2/AnUHwgfES8MdCU/wh3V3EELXMBop7lzAbvL6eMsG9kPnOfSIPm7U
   pGjKyilIrFy7hJmg6KXAUThI0GbfY8gke5EzXjiy7db5cMPMAjzVOGdCC
   NWEGsjZYrlDC1RlPhLkAA675SutpEbWREN0UXotdqnS2//fjTgrVfCo7j
   w==;
X-CSE-ConnectionGUID: g3z0uWVtRVO101aNOfUZsg==
X-CSE-MsgGUID: biICyz++Rni/F3KntqPdcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69916984"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="69916984"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:50:27 -0800
X-CSE-ConnectionGUID: 7RjeuxeuSIaMZkaFxWZEuA==
X-CSE-MsgGUID: 4U6jzoHHSDmVYVcsAoh+Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="209940431"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:50:26 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 18 Jan 2026 23:50:25 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 18 Jan 2026 23:50:25 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 18 Jan 2026 23:50:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVU5oho0IuXcfSTs3oK87LpBeVf0m2tL4dilYu8pOTAKoHwxRS+aAComc/nHnp5kJe5glTxK7ytx4WmNU/osOmP58NfmtVlg1HG92KbxGhKMa/st/osjnCQzZ16wIy36RQA39pLsm7ZOcbSKUqYW5nWriusckFWqfh6C0eonGFjCMYi25qno06M9vVqtO1CfLh64O5N56NoIdbTjvtnUR14P19iO1IDr68JP/VzZF1rCV1A7oyFAbVjldlosE6obmRkRDeMdS51OYZe7Cpmn72JMYibS9SEg3hdxW44FviF2pSqAJY9Y1wJwtP6X9rfju1U/VLlCu84xpll11pcWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPwLz6ScisaSfd2XrKInZ3r1Meem42AR8mJnbjydRlM=;
 b=ZGulyBh1oY9RKsbEXgb/wobiLB+R7lZMMwfCg8ZGArHkz+m0qjEzvESfeH/KbnamULf7dOjo92mb21O5pxD/jncV/qTZfkWH3TeYXyIxvByUv3LvWZqiaK0s4BRJ5HbvIjFS5kIGZ4smiDVGE02cSmHE146hT9D7apSemC4MQHUbokCcTOmTkSEC5pHB8VKCLX+zlvFJvsCwu+31tnGKD4Ye5gpIYprjwmuXQosKw++oWOfpM1QogGv2/FxdB3tEu+GWqWrO+ALVipFRsIqJI/pwi12/BdacF6ZB+Ju6lLwXgI0MU0uUf4qaU/3gLtP1ALLn6B9sM2cfRFcEAPL8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4813.namprd11.prod.outlook.com (2603:10b6:a03:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Mon, 19 Jan
 2026 07:50:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 07:50:21 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 07/12] dpll: zl3073x: Add
 support for mux pin type
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 07/12] dpll: zl3073x: Add
 support for mux pin type
Thread-Index: AQHchxied5jbcNRftkWxBZXkb5OrQLVZIkCg
Date: Mon, 19 Jan 2026 07:50:21 +0000
Message-ID: <IA3PR11MB8986A1E00CAFCEEA237FD939E588A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260116184610.147591-1-ivecera@redhat.com>
 <20260116184610.147591-8-ivecera@redhat.com>
In-Reply-To: <20260116184610.147591-8-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4813:EE_
x-ms-office365-filtering-correlation-id: b80ff398-32b7-4bf2-f6ac-08de572f65ee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?qJ4iB6Bq5o4rdGBTRtZug7SnsMSaTdPGywV8eKMssOh1SZ0yn7NKodnJjoNu?=
 =?us-ascii?Q?GwkuUBvOY6+f5HeM9Xn4g0EKalpp5n4TFvAbHAT1hpxu8NO3F9DpkWZMcMHE?=
 =?us-ascii?Q?fcuQcrr3z8gj8QCCWXdjMnDIKHMAV0cAhPp4qVFB3IXAudUCXp86ya5rNYb/?=
 =?us-ascii?Q?hMwwzVL6iuW58175ayVFQoaKgWo0MTrZoeuc3IKLWQkLLSATyj0lt0i+3NuF?=
 =?us-ascii?Q?KE1pNUW1cbgQi3iTx+DucNbgPjU9kf8HadZGNCaUCTw6gRq92nlgYM1/cUDS?=
 =?us-ascii?Q?QJvTJc6f6eSaG19qg9m/VgXgvuek5Y7E3tZEwn5F/7ltQXltf5GAxGmw2g3i?=
 =?us-ascii?Q?mKqC/cbBgR9019UmsguJjYFuR52GbFpye5SKOcG2bcPX7DI/19S3X4acty8e?=
 =?us-ascii?Q?TpHhjfotpIbz+fMTHuQPNNAtTOIGvanOKig4p930qo3rRtilFJFSFowWhzB6?=
 =?us-ascii?Q?frZzVtmdLvrI34shS0RQ6/PmZouGripxdUDXCoYlNdfbo+rCzuzWc5TUeRDW?=
 =?us-ascii?Q?BOiFTXjjwiI+hJRSKb6mePzDNCfpkHvfqmibLoSWl+YXSThs5JKwDRudVnQ2?=
 =?us-ascii?Q?Z9/Mp1Fx+Cx5RTQPpHlh0q/dBLsSmNJSHezRJPAIdmZKJpMP9UNakekU2mGg?=
 =?us-ascii?Q?IT4FWR0B3LeySESDtZSmSCuMPR3mEXTT+L2Br3qePd7rG7ZdwLl4sehDfUDN?=
 =?us-ascii?Q?+DKKyXDUUcKI2jPSaYhaE451xaGYnTKohMiVfjmSWMaYejwsdkG9GACkS9l/?=
 =?us-ascii?Q?Cq+WrzDAOr/AclrOphzyOMVGe4pKMWeHUd7ife3vXTOh6qBfmlqT9xLmHdY1?=
 =?us-ascii?Q?0GWzBQPI30xd8W/MvCyHbaAd28MbZZLe2yHloqv+sMY3o5MuvM1eGgHcGpOC?=
 =?us-ascii?Q?gXjNV+SgHOSFxEO3qLMeZDn5BvMHbaEhsVonmCDnWdaJhVvHGEf/z+XYH0mI?=
 =?us-ascii?Q?QonafA9gtd8wHai1+ewhtTuVY+4QX8vEmrWLIIA1oJX7yPkgnttyvZTSKCs4?=
 =?us-ascii?Q?NamTLcB4QSdptFfZKLt2xXBA2sjBO0zW910/NH6oInygHnxPjM5Mgvz0lj3c?=
 =?us-ascii?Q?5tOf3Sa1JY5AhLhAsdTbFT+HESbkQc0NM8XF9yilkiAm96sZN00HdaStf74l?=
 =?us-ascii?Q?nmkfoblopr1gx58rdkAnzqme1xThWw/V0tS1iHnK7TA3o4AXzLjIShhaWelL?=
 =?us-ascii?Q?ys85liMxv316f0TxbvIadJvnPAK6h8HNtoTzWqg0K6ZmHm+Bc2IKm3KAc9iW?=
 =?us-ascii?Q?2HcNTf2tkEpLAAiIM/1DAG4lCSMrlotWoxJlLsq6tTfGiojvSb0nIMiqBKA+?=
 =?us-ascii?Q?zt9MxytJi3E37TOvsBqVA05bIfeAtQ6heqBhHUc2/77kaVkvYcXgJ7HngKbX?=
 =?us-ascii?Q?9Alq3G9Zj/yLB9KpurH4g/zsr7Tc3MbsmlClKbj4Z9kAIoZ/oABV+/Kj2DTb?=
 =?us-ascii?Q?dxz92L9nkmnmC0sexITMdGrBLWQt8cp6/8fbr8M2cCwc25qvIsbmz7VOCmKe?=
 =?us-ascii?Q?tQilSfotaQVrnf5ALZ330OTdiX9oJDFjiBL1KWpvDpIwtugR62cLPxgGLx3D?=
 =?us-ascii?Q?pOWsj7LLQN5UvCvWDhzuZJd3iPK139j0k/7yZQbMctv3SFyAxfasHL3hGP3T?=
 =?us-ascii?Q?N3dj9DvUKhBYjoDZGMWU/uo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?muxdQPdIjMNioigJELqnZBFXC8opOWe64mu1e6iv0zrQvNP7ziECvjqLt7vO?=
 =?us-ascii?Q?YlGZ6fSu1kE9jOJm0NzF2vSkmee18FgB35M8QEv8sABhAhfIjEHzMX4gVUCN?=
 =?us-ascii?Q?pN+Vt+ltF1MxZQBBidDhQBaDSOHR2ldWFTzyyKFES805ovyZXWNi53xE8Zls?=
 =?us-ascii?Q?J4K2fKe+9Q5dy11fIsIUAREfz3CItBW2nVPldTp7T2kbV+fiw7DRiamlbVbK?=
 =?us-ascii?Q?EJKgpTgIcHazUaF3CPOqjxOHTZQT9fF6j3vKUmKZwAzXe4UrALYi/0OmcQzB?=
 =?us-ascii?Q?cZqBR8oTaqPN13yHakeskZ6JC81ANiw0iJieIRZBMK9BaEEBiQEwJwLL0BJP?=
 =?us-ascii?Q?plzbpqpZiz2udPXlbHIdPvi2fUKSDyBx0+gXmWodWlruuWBHXHUirYCpEUPj?=
 =?us-ascii?Q?RmFTT5ztOnjO/ogjEYrLC8WWEQusT2032fqb23EvFJH6hVYM3eCTQridup7g?=
 =?us-ascii?Q?wiRT+Be7k9GlP0Sv5cyGtd6f3Re4OKfL2XtEMM/UQDZ/oxFNeiLC6SlHZsVI?=
 =?us-ascii?Q?7Ip7qzAQsBizglQOKoE7G5XuqPsmn5ccVk5vcxwDqhxmLLw6lhSi5mXLtm//?=
 =?us-ascii?Q?7sVRfvGbBQPCI6B2NuZh+zvuZLk0F13sJVhejrrMM2jSNx0zpH24ugh8Kdrc?=
 =?us-ascii?Q?ZfXPjh74u2Vig7NnCk4tjF9le5gT5FXlOoYKAgDwJr3KvaKma8pM+tFxwK8W?=
 =?us-ascii?Q?9vSzoHLC0LMbNJ8oy2Ln4OgQWMSbvzhoAdUmHn2zCJsIXgRYk5jZyRckUbew?=
 =?us-ascii?Q?RND0ffp/n5rm+2ZCPam+tWVdFTi88HLF6ntF+YUfSQfiYJ5WZVui/eRDKtSN?=
 =?us-ascii?Q?eQdKb2PGWROPuzsgaVdBKCY3PoIpCd2aCcvtYYiItmfBNkCOJPVCUQd/H08r?=
 =?us-ascii?Q?QF+yWJk+CV45s6MLno2++Cwf4+DsHZpRxn1vgMI0Wyqx+pGR1sCAVnx4MXyB?=
 =?us-ascii?Q?l/kkBmUDZKvYXr7izGyjtsREvsjSzALJHK4N6EDqrMzKzlhtIAA5Yx20rKzC?=
 =?us-ascii?Q?2oZjbHVt1h4OHPWUUttgCdD8GFtBdvTDs05A0j9V+rH21Fb5R7tPeZRcmLG4?=
 =?us-ascii?Q?nGm/bp+4bFAkMQtFE4NAU7G6jpOvHm8bS5g7oj7COabqiUsp+r3hxKwYVcyk?=
 =?us-ascii?Q?+BvJgkf5gWAzqZgCB3cFc3mMGV4lwvTPMVf0KAknHTdxeEXB+iV+K3oqH1P4?=
 =?us-ascii?Q?pRVznDj2kjRtgUm6I11qkgJ2Zut9sj5TU9QL5oLsEk/lbdysaZNvvZijS2x+?=
 =?us-ascii?Q?Ywv3uVk+Hw2YbsTM6hq+pRCOCHA+z07ATUPIFmW54b5AoOv/yhsT3aVSvdi1?=
 =?us-ascii?Q?kLXeIaxDB1q4R/+NOhQkbTtPpLp+bKPQGZ5kvARjZrSEh4GJt35hEABSBhkm?=
 =?us-ascii?Q?/95L3lEJhNK/y6mETpEebvLd9gUX48dtoSe/j2Zb2jHieaaQKlcwbFr9Junc?=
 =?us-ascii?Q?PennalepnUYJQq2LYu33m0TJqkhC0SjI7vD1Q/xEbfF9Zlv7Lz7OKqkE/uon?=
 =?us-ascii?Q?hHGHFawrbJn9yWFAk8JfcRK1sQzorhWo769IZODiTGLEgbAx2RGiGFDqheg5?=
 =?us-ascii?Q?uAetCuVtv9PZDKfQSCT7h32XjEYgkqNpQ+w952Q8WYMWfCiHYhyE8beUmHXE?=
 =?us-ascii?Q?xLAWAvH/qXZAdAfj9WOhd2FeDliBi8oZ8Ze3A1STTeZz3Rw2TC8Dy9yqchUk?=
 =?us-ascii?Q?Nn4OhABAj/UVtGt4KRw0ukS8SJgZjcHumgVUQlF1yl8/oG/Nbqm04wNL/8Ku?=
 =?us-ascii?Q?uEfvlXqVwkB06AIRRHCQ0IGCNztsTaE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b80ff398-32b7-4bf2-f6ac-08de572f65ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 07:50:21.7953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rmj1BFEQlNMKV8V9u6QAdoRApCxYoJEbD53Ix6lArVRHaPchFG4Od3w5lUCpkw1BfIna6qfJWsGDhtAw4lnzKRF5yIlqWw2AKPJkYJw8P0w=
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 07/12] dpll: zl3073x:
> Add support for mux pin type
>=20
> Add parsing for the "mux" string in the 'connection-type' pin property
> mapping it to DPLL_PIN_TYPE_MUX.
>=20
> Recognizing this type in the driver allows these pins to be taken as
> parent pins for pin-on-pin pins coming from different modules (e.g.
> network drivers).
>=20
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/dpll/zl3073x/prop.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
> index 4ed153087570b..ad1f099cbe2b5 100644
> --- a/drivers/dpll/zl3073x/prop.c
> +++ b/drivers/dpll/zl3073x/prop.c
> @@ -249,6 +249,8 @@ struct zl3073x_pin_props
> *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
>  			props->dpll_props.type =3D
> DPLL_PIN_TYPE_INT_OSCILLATOR;
>  		else if (!strcmp(type, "synce"))
>  			props->dpll_props.type =3D
> DPLL_PIN_TYPE_SYNCE_ETH_PORT;
> +		else if (!strcmp(type, "mux"))
> +			props->dpll_props.type =3D DPLL_PIN_TYPE_MUX;
>  		else
>  			dev_warn(zldev->dev,
>  				 "Unknown or unsupported pin type '%s'\n",
> --
> 2.52.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

