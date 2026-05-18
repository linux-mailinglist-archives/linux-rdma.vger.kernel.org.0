Return-Path: <linux-rdma+bounces-20888-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBTCN97VCmpK8gQAu9opvQ
	(envelope-from <linux-rdma+bounces-20888-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:03:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 805F8569488
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5D623062F44
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9F53E3D94;
	Mon, 18 May 2026 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBPe0BRx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A003E1207;
	Mon, 18 May 2026 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094676; cv=fail; b=IznrVBnDNfMbbt3RtT+f11ryz7YwboJoOb6IDFQQ3847a6pvBHb0pUyGBC+fjmSWbvqYjQ5clECkrXiGMRUwh0LCMQIRNXSmp0xjgEArq/bJGk8b0RFXi38188Rna8IN4UW9IVcSolf3ZpcoAXBuH2gIrQy+pps7lwf1n5Er8Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094676; c=relaxed/simple;
	bh=WMHhJh+wSBZdhmLlhq8ukbGcO04R45kHS8le2qXYjIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X6HCEx7SSP1duy1pLqzUQJiB8FMIPrY8NcFTSm7lkcXdl7C+6Q7LbtWZUjDK2Q72L5Mh/9A67YegS38ONzo/xFR9L9sH3FdiQ0hxjrcJqBCT3GJPa6tVukxH9Y/3ScEDu2bYmNY1LMizA67AP5Rmgal+CWNTwWmICSvXwQmnnh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBPe0BRx; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779094673; x=1810630673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WMHhJh+wSBZdhmLlhq8ukbGcO04R45kHS8le2qXYjIc=;
  b=CBPe0BRxvekppioPC5rKnfGVbH5/zbddrHzx5J44XAyyd8cF8swpBiiB
   XiGd8qq+73GfCDNXC4OB8jPVFL3e7S9DbTvFMOKP/zLz3dFCj56y1zpE/
   weWA2smt5DuBdhzNI5eqOTW/yhl/vZBF1vqZkvNZ9c4/atcWBwOVsvwjC
   CcnHtlEccwe+S1cjoOUbZDUBfLdh6fBp4Z8UOEx6eZgQSa6ALVNAromfv
   bqWT0d91fx3327oY4oBlqsjj523W2S9m4QgKlt59bUJCfETKoEfGuethC
   kEni1UlGfNM0dTSMYzP1p09BVTAxW/ULp0Zy6Gijj5Smmtfnj6nI8Xc5V
   Q==;
X-CSE-ConnectionGUID: Llt/TvAYSpmOp2uztYSXiw==
X-CSE-MsgGUID: IgHdlLabR3ayaUW/XTPC4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="105403147"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="105403147"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:57:53 -0700
X-CSE-ConnectionGUID: AKZr62Q3Rx2y03FjolAlBw==
X-CSE-MsgGUID: 60Q28BheQSWOK9ez00xqFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="244342777"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:57:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 01:57:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 01:57:52 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 01:57:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ts2R+dZaXoH/WIkW5/2Vovmvlv4SA3OQn4nud61qh9iZ+NaaA48KswUTGJ7ml6uoWQfFLfQXuMB2jHj+CjEemoYO4zG/1LXMIpHLqY1lhIFCVbCZneknUa0e9ONy8FCRz1Bw/CoT20z84Z9qnjGUAdEM0xi9C7oOR6urlds15LYBhGNUqdBK5huySrzsg88lvLgtIT0uVkCh27YWq7ZIJ2nENtthF+TqQHvo2qUm6H7SSvflOUTEuzWJChrMPGrooLBFeenW4GEb/CdP6YGxG4CVxAbj6B2Ue9d+Bc43uhMNaTihtjlCNyNAGIeAm3DQVDXLS4ykJZHbBlP0rTvORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMwp5k8Sx4nn28ffRAmgAOBvYdvrZjYkhsJdT3wRN2o=;
 b=UbkLpojur25MDTBAWEm35TCVQP73dNplt5RKsCmMsqTMVwwvsvikCjhUBtRdZNYsA7Y4tm06L7PTyD/S/XL0jvQMO0yIY6Iya1WXxRra4XhVob0noZgM+RZ5PgO+45tqqjs3oYtJZiZqRTNKoDKFoueorP+X0/tK8JeVfN6ZunI9oMxFh11WnSuBVbixl95H1Kda/FH19b14H7BUkBtMIVOlJmydweAFzi0PxpVP1r6gx1tvo0EjyF0ZLf5lNKnUW7sZhzXLqwrWdrxo8yQyVHSaPtmqzZjvX2Y/dPANjljXb+COt/7k70ti56doM3pRwlGK9gnsQOsGGsvDKkxGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY5PR11MB6283.namprd11.prod.outlook.com (2603:10b6:930:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 08:57:49 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 08:57:49 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, David Ahern <dsahern@kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Nikolay Aleksandrov
	<nikolay@nvidia.com>
Subject: RE: [PATCH net-next 1/2] devlink: add generic device max_sfs
 parameter
Thread-Topic: [PATCH net-next 1/2] devlink: add generic device max_sfs
 parameter
Thread-Index: AQHc5fAqyBv8g4eHK0GeZOOg2rKOH7YTfNQA
Date: Mon, 18 May 2026 08:57:49 +0000
Message-ID: <IA3PR11MB89862198768E41FCA4A1FADDE5032@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260517112700.343575-1-tariqt@nvidia.com>
 <20260517112700.343575-2-tariqt@nvidia.com>
In-Reply-To: <20260517112700.343575-2-tariqt@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY5PR11MB6283:EE_
x-ms-office365-filtering-correlation-id: 21765de3-0d90-42c6-1e1d-08deb4bb8986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003|4143699003|11063799003;
x-microsoft-antispam-message-info: 34/HGa37W4HE72+TA7+TgI9wyYA4Zzul4bU6eXMlRQ+49WH4qrXDFITuiu+aEAg/F6KegF7CKkubcUf25r1Gfer669Dbc+ErK1nMSGkGsXnpVwZR6HQGtpoXwMewduTy4TY+yuDBWWRDlrzwxAn96yBRUbI7ed++bbnoat74p+OiqSKcKtQHbxmbSu4dlhOLuJt//hKjH9raBk0J39jLJ7TiFwgL4q+9Ym38oyZqgc4VPIQe7I6reGhdXnQ9iPT53g+VufuIH/DClFBQDcyn1gCarcDjoLTYKjWyuzW5qjvxZs3p/N3P11YGiM5P0teXGEez7NSAcEGSIRNPiWDrX1Buufg96jK1z5LKeYO48wPWGq7QRRo5G1sSL+iE8iGbMoDupDORUU/ymLVAE9SeZOd4XrscC75jdJZV42rUQiKg3V3KfARmBslZ08qGji8Gf6yncb1zhNse8EndRSRPkuJ8l+T8TkAAdfnHU69ScKmxFpE0gxKWkJEiyv1447txFTRirXONuKoxL88JaA2jBRh736DBZ2AYtnQ4pM4lXkX37GIN9MXziO3o4W40cCl6CvawKMPFYdZ+ABNjOP/PiG3odYqvqjrUr78jZ9lMccHXuzjvntALYb4YVUlWzTmdZbiTwCbHyoyA/NDo6RcgGHXv7awRQKbBE2/sW4qfQp37w9VSHLM2TNCMWUustkeKEJ+032MWd3XRY6s/cY7z7ZW7Cb59S/VF0+3G37LQYTLRHMAK/pq68I6qoOMnOCUs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hGoQI22jpwwrvAefzyrt3JfYyT4LWHcocbu7TLmRE82YOE6ntF+LaLBhREfd?=
 =?us-ascii?Q?dlVZWQoLVRBoMLYFstRJtVdBASYyzZsaU5YRcO0jB6aQbCrOO9WUGw/aXf65?=
 =?us-ascii?Q?PiXPdKxvhoDFXwBPSyLfjYqvLGNxvipbAbQNAOgntXw2kGLchBC3jJ1aKFv2?=
 =?us-ascii?Q?SEluz+GdwPWUpz3ec1Z+xZKPzFb080h3AWMAdrLi33TdAhtt1b6wUKrFYdzw?=
 =?us-ascii?Q?UlodvkGy3ncUu2ckxr0hbr6IGf8PpWO2Ougpfr9OOlmn17LuOyNSekKYqQYL?=
 =?us-ascii?Q?K5sHCvgM2eKs2ymN1rgeL7aufA4Sp3lyZ6ozVjV/BJ6d1J6bIjKZIqDZSeK/?=
 =?us-ascii?Q?23iwVDlR4qOSuvzgYCwQFhFXtoyNL/cM7jlGnKsTSZwFZF3GKQ2vYI0Vkta8?=
 =?us-ascii?Q?WGE10NPXHSF2ARnizztR0em26MDRngVm5sr1sOzFp1spa6baxnP2xCBVMcfk?=
 =?us-ascii?Q?WuRD4McuO0qU0igk8Qs8IR8O/+9v/uGAkrXC0veYdFD3jhp107at77gX5+At?=
 =?us-ascii?Q?xXUwOGHt0jM5YUSUFjqQmF34S4iH1tczkkCogDFS1SHF5pvA1wOdXIavY9gC?=
 =?us-ascii?Q?aZeuJ00jKansq+Hs7P3xeA1YSNNjnqehfHhS4CFTNZvWIwhxj23pgv6W+ET2?=
 =?us-ascii?Q?4N3JfGzBeKYiGYDQumGGe1qO5VlkRM5d6Z7Kho+Qg3aVTTZiJp6+z739U7Z9?=
 =?us-ascii?Q?mTvEQ5lHA5QpmbcXlDLrZDT1oTBoOz0Fa1CEAUjwVaHR6ST75yurwJ7tTiUD?=
 =?us-ascii?Q?CjrFnQ/Y7nG18Nc4IFN0nS/3hCOwg6oW05UUt1Jq6eB5bdoyyMh8ZsNG+1Jx?=
 =?us-ascii?Q?QSzWAvaZ1BmlPIg+EQEb+OzU4IX/WGj2H4zTh/J/rlbV/GMSL5bRleVJcH8y?=
 =?us-ascii?Q?gdCKG7ZkUvwU2WmC/wTYEzDHQjJ/ydrjZaWR6lxObQd5S8GYalUQSVQcyfF0?=
 =?us-ascii?Q?dQQuvq0Q+J7lbgVsG6Z6TGnS7qHo5j/pIwJpI3Udq4xzc1ysgQIqbHEvj19a?=
 =?us-ascii?Q?Jyi0gZ2ZbLL+b/vMzfAJl7/J/afPPyOnn7pFdnkVz3C3iK0kDmFRktgoOIeX?=
 =?us-ascii?Q?FELujJKhmUHCNDd54q731I0dh+K2nApDdL/4LFUMJw+cXGWw5VnivaZm686x?=
 =?us-ascii?Q?yXw6y7NmAct+8w3ZmMgezIeCYHbPympXuK8Fi/KrnrNrdV1O0YlhH1kMXJwg?=
 =?us-ascii?Q?Lmd+ORFd0D6cm+vyF5pCYYf6dSQs/KRNnJEO2aQqddef8nTKIwUCv8ZNT7ow?=
 =?us-ascii?Q?Ekq1cp/8X4jb/JHfjyesM+e0NAqgAUG+Vi9A/Qc0NwrGN2EbGlPdrH4391ty?=
 =?us-ascii?Q?NaSZvUxmBFSJdhT81ZSuSNWKhziRCy/qXSasq9XWYawKeYhcfSfAbxwu9pjN?=
 =?us-ascii?Q?8Hk5Al499vjhX0lqYmqIJI43nMC+QIuA2eH7jhFiQpBW8/eI81aP40IXM3fY?=
 =?us-ascii?Q?PBe4oChTL0L6g53ikouJFoQGt/q5XNY/AgT6Nf5esjof6Ozbo5+COX+aRRCe?=
 =?us-ascii?Q?5PxNb5eniCq9S0pSoNw4iH7ktHBGiDp5OVOOLRnwPF2aDrO+0mK+KIr2F+se?=
 =?us-ascii?Q?ntqzPvfHQS8OFLBG2C6nS5Ru+kFucud1Fux8caj351ZH3KJ1mrOn7jCIW/oA?=
 =?us-ascii?Q?5CxqO4e9V4DgSCkP6C5WaU2/pOgSsu1yfECAJHOom+dzzYpmHXTnsaWyTlIN?=
 =?us-ascii?Q?xTOV/J1bLQk7k5cbqBbwlB6WHEE+lw4UMZwygAoN3imP2VqDZbDdszzB6gnE?=
 =?us-ascii?Q?2+L18UY3RTOuFkbuGxxbL0Y/rAuQMi4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HRoA2fahp/2uLAw4NtYw+wrt7r70Ytl+fYzCRofTJRwDrgJo1i1vfXeQb4uTor3SuifZefjOCIyLW82pYb5AW0abWyQdozVtc1/5x6YK5lzcIsoWx9gxJAoRaZte28JIem9umHflzi4WmOIDitQBOUk0/+gnV2X+XBjKJw1851nwjK8CMR048A1baLG3kxBr9O8UrMwU/M8ZT40qHN1WFJYDvVHITwiE273zhL+2OucA/HDFs/MgBKeKua9TjWthM8B5gh+MlPafUeFG/SDO8QLY8Y84iqJUvv186Tn/YXZesiFnSrTHT1IDMRY8UuYd23yPdiqWwpAxANUEApoJFg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21765de3-0d90-42c6-1e1d-08deb4bb8986
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 08:57:49.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ND9BtRjIdE/SSzFh7gS8dQi7qxvvgKPoOrvF618sbCPThkT8enrR86fwI7XhmFjvOjPgeXEYANmVNBDWASq+ek8hD/YfU6dVh90/+z5zwsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6283
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 805F8569488
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20888-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,gmail.com,blackwall.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Tariq Toukan <tariqt@nvidia.com>
> Sent: Sunday, May 17, 2026 1:27 PM
> To: Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>
> Cc: Jiri Pirko <jiri@resnulli.us>; Simon Horman <horms@kernel.org>;
> Jonathan Corbet <corbet@lwn.net>; Shuah Khan
> <skhan@linuxfoundation.org>; Saeed Mahameed <saeedm@nvidia.com>; Leon
> Romanovsky <leon@kernel.org>; Tariq Toukan <tariqt@nvidia.com>; Mark
> Bloch <mbloch@nvidia.com>; Vlad Dumitrescu <vdumitrescu@nvidia.com>;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Daniel Zahka
> <daniel.zahka@gmail.com>; David Ahern <dsahern@kernel.org>; Nikolay
> Aleksandrov <razor@blackwall.org>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Gal Pressman <gal@nvidia.com>; Dragos Tatulea
> <dtatulea@nvidia.com>; Jiri Pirko <jiri@nvidia.com>; Nikolay
> Aleksandrov <nikolay@nvidia.com>
> Subject: [PATCH net-next 1/2] devlink: add generic device max_sfs
> parameter
>=20
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
>=20
> Add a new generic devlink device parameter (max_sfs) to control if and
> how many light-weight NIC subfunctions can be created. Subfunctions
> are a light-weight network functions backed by an underlying PCI
> function.
> Their lifecycle can already be managed by devlink, but currently users
> cannot enable them in the device. They can be enabled/disabled only
> via external vendor tools. This parameter allows subfunctions to be
> enabled
> (>0) or disabled (0) via devlink. A subsequent patch will add support
> for max_sfs to the mlx5 driver.
>=20
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  Documentation/networking/devlink/devlink-params.rst | 6 ++++++
>  include/net/devlink.h                               | 4 ++++
>  net/devlink/param.c                                 | 5 +++++
>  3 files changed, 15 insertions(+)
>=20
> diff --git a/Documentation/networking/devlink/devlink-params.rst
> b/Documentation/networking/devlink/devlink-params.rst
> index ea17756dcda6..29b8a9246fb6 100644
> --- a/Documentation/networking/devlink/devlink-params.rst
> +++ b/Documentation/networking/devlink/devlink-params.rst
> @@ -165,3 +165,9 @@ own name.
>       - u32
>       - Controls the maximum number of MAC address filters that can be
> assigned
>         to a Virtual Function (VF).
> +   * - ``max_sfs``
> +     - u32
> +     - The maximum number of subfunctions which can be created on the
> device.
> +       Modifying this parameter may require a device restart and PCI
> bus
> +       rescanning because the BAR layout may change. A value of 0
> disables
> +       subfunction creation.
> diff --git a/include/net/devlink.h b/include/net/devlink.h index
> bcd31de1f890..4ec455cfe7a4 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -546,6 +546,7 @@ enum devlink_param_generic_id {
>  	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
>  	DEVLINK_PARAM_GENERIC_ID_NUM_DOORBELLS,
>  	DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
> +	DEVLINK_PARAM_GENERIC_ID_MAX_SFS,
>=20
>  	/* add new param generic ids above here*/
>  	__DEVLINK_PARAM_GENERIC_ID_MAX,
> @@ -619,6 +620,9 @@ enum devlink_param_generic_id {  #define
> DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME "max_mac_per_vf"
>  #define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE
> DEVLINK_PARAM_TYPE_U32
>=20
> +#define DEVLINK_PARAM_GENERIC_MAX_SFS_NAME "max_sfs"
> +#define DEVLINK_PARAM_GENERIC_MAX_SFS_TYPE DEVLINK_PARAM_TYPE_U32
> +
>  #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
>  {									\
>  	.id =3D DEVLINK_PARAM_GENERIC_ID_##_id,				\
> diff --git a/net/devlink/param.c b/net/devlink/param.c index
> cf95268da5b0..523243e49d88 100644
> --- a/net/devlink/param.c
> +++ b/net/devlink/param.c
> @@ -117,6 +117,11 @@ static const struct devlink_param
> devlink_param_generic[] =3D {
>  		.name =3D DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME,
>  		.type =3D DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE,
>  	},
> +	{
> +		.id =3D DEVLINK_PARAM_GENERIC_ID_MAX_SFS,
> +		.name =3D DEVLINK_PARAM_GENERIC_MAX_SFS_NAME,
> +		.type =3D DEVLINK_PARAM_GENERIC_MAX_SFS_TYPE,
> +	},
>  };
>=20
>  static int devlink_param_generic_verify(const struct devlink_param
> *param)
> --
> 2.44.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

