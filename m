Return-Path: <linux-rdma+bounces-16562-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CwPNbhfhGng2gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16562-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 10:15:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F76AF0717
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 10:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0D0A30260AD
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 09:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7883921E7;
	Thu,  5 Feb 2026 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2sUVGz1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C17138F255;
	Thu,  5 Feb 2026 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281951; cv=fail; b=PDksQbiixsbY9whFxeZ1beMFRSEZ+m3op08f+Lojx23ZyK/sJEQYOwqXUGqYolLZLxQDpe5HXs6gvqCBEwjms42tP9EygfhJWbKPnDzNm/XIxsmaPw+BmENnjlmNeHM3HAmr7eHnpLSiO/tl6hJ7NkdgE5H/1BepxUS7HMx5fig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281951; c=relaxed/simple;
	bh=bIv1GEbeIfWs6B5UF6uegD2Rc9thzIHI1vCAm652y8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RUHSQJQXnTeiAV4dLAs+oEpTmn5DplAnZX49t3FvC8knFf4+okJg9aHJQXP9ET9zgkE9rQQrXKATze8X0nrxN3167ul9SkMJXCHHKalv3Q3gKVRc4P8w1hAqRjF0lnudj7dRXHZrO7ahJ6JcRKPgho1VzN2XnphfF4OZ4KBV770=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2sUVGz1; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770281951; x=1801817951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bIv1GEbeIfWs6B5UF6uegD2Rc9thzIHI1vCAm652y8E=;
  b=C2sUVGz1fmY5eHTM7bc65emuStKruoGGPTRd7H7DZzODW/VRACFkXUPO
   5LqAaRBQdlPNiP4MyG0bc8d/TToegDxvaBawf4DP2DYazo2m6xu7BRlA3
   Bf0bSgdxPtwUgb5t03OUNCE6lbkCAkb2UwVh4AFEal4f42CbUw1evb9WJ
   Tg9+zXRNNAyO1A4Ca3pGdVSsZXWnQPk/j9l/4wl42efuAuKA7TxIlh8Kr
   f3OVXh6wRzeXfTaTiwA4BDIO7f5F8tbiN/3y1YOOzI84iCy2mbgc7IADw
   z/9qh0OaU43UGCxggOsuiPAI2pRlm/AyFgxTK5p0OiJwvrGIHQWsxQpty
   Q==;
X-CSE-ConnectionGUID: BHglwjQ7T9+B+v+AkSwmxQ==
X-CSE-MsgGUID: A+tIFlWbQSCZ224qlKA2+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71465643"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71465643"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:58:44 -0800
X-CSE-ConnectionGUID: mPoSnpY2Thmxv4E7QkOM2w==
X-CSE-MsgGUID: xXBjaApTRGqgdQS0bGirpg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:58:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:58:43 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 00:58:43 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:58:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBP+ZtbjoXXpWbHvsR2oz5LkzrpTY4ZhP7M+C9EI8keqo38UHwD0H6zjKZbTQYyCTM4mt2m2StLfU++r2w2TxIet9PnvgtF2IKsXkztHGa99Nw8RW3XC/24FeumPhFI+cmouc9nEHY5qMAz5/N40TkluiONOLpYoWPOfDjX4wO0yBItCeE5hqRG0wk6/lhW7+qcRArITw7iA2jpLGtgDGs2bYbCGN3eg1zLJZOlKFG4Lip1Zxa27jgbDYBVVOAlcSwxyHqoA9GFa0k4iw1+/c9Uq/4MsQJTSK8pmUtGLvlDNY4gm8Or9xW4rC18DcjKwAZxQ02kFYPDuaYV3IllB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PskJhg6W5EcLiubGdmB7xkl/fkzI1MEOGnLViUpRvmI=;
 b=EIxqtc0GVkME6KDZOtylvrONeC/0PNhe6UtH/DRVdye+aIu5n+DmZdQLt9CNpQris3Wf5Y3AcStYR2rC6OXcE3JTnETY0SsnQ9V3tNmSpUkRI2K2YPTD3TAKU24cgwVBjGgKAdTqYvAGJSOyTExOrBZu/JoVCPkccwblc5y0JGIrL31uiWhxuxaqji32WTRIdhjSv2HphXTZNq5IzEFVFav1X/DXG/aiQcE3Bb7dRaS8xT48PGZWup1xwAYdzsOZSBh31oc6dlCmrnH8g3ubh7ipSWji1/m/PT5BdYJiB5QVO83Wi51NwEJCdr8iJniRyobsdjcFYRuGNKzVXM3iwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14)
 by SJ5PPF263E38237.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 08:58:38 +0000
Received: from LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed]) by LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed%3]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 08:58:38 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Paolo Abeni
	<pabeni@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v5 8/9] drivers: Add support for DPLL reference
 count tracking
Thread-Topic: [PATCH net-next v5 8/9] drivers: Add support for DPLL reference
 count tracking
Thread-Index: AQHclTRXG3jOdqOXOUSEj6SBUvhlWLVzz5Iw
Date: Thu, 5 Feb 2026 08:58:38 +0000
Message-ID: <LV4PR11MB94919A77580A9D1A29E5BD489B99A@LV4PR11MB9491.namprd11.prod.outlook.com>
References: <20260203174002.705176-1-ivecera@redhat.com>
 <20260203174002.705176-9-ivecera@redhat.com>
In-Reply-To: <20260203174002.705176-9-ivecera@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9491:EE_|SJ5PPF263E38237:EE_
x-ms-office365-filtering-correlation-id: 27eb1268-bedb-477d-0c00-08de6494c0b8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ygr+hbakDlzfKdFiGPEwNfmjmb+aC57eVtyiCEapDhfe59R6CwBYGnBXRpjf?=
 =?us-ascii?Q?6roGTYLF+RQ3TBEJdMABLVbyTFE8lAa+y2aRUps3D6OjF383QoN/QS0KwIrt?=
 =?us-ascii?Q?GrOejVbDm34TC52u0fIfsCctABAbdiKxwaoXWWOiJvAzm7mL8G/6Lcn9/3kQ?=
 =?us-ascii?Q?z3ogqx13d5D/+R9/VWCNcux8K0xS1iLD7JDJI20Set6l+w4FwWIUUcEMkkf+?=
 =?us-ascii?Q?79dbqpzQ8R2fhtIHtnXcNCmLMl044jSSDkj6OZSTz2d/KDiYySfkmq6ucxTn?=
 =?us-ascii?Q?VA0qZJIs4IcUm3n5WRYVeDlUMTSys5/oE6Po7QmdSrf/JzSssPGb1OdxrWcy?=
 =?us-ascii?Q?iIP+M2OFjmALuXpSP1/FJDmt0ucsqdk4EaxEa1PYYY/JDjL9l0UWDif5Zo7Q?=
 =?us-ascii?Q?jJ7XAqZJIj/rZsGpBHn2RzRIroD6qApFmXrqyy3vVD/vCJknvx6Yz4bSpWrJ?=
 =?us-ascii?Q?SmKD0xX9xBPgy2AxwsqTVISQyEjjupnP5Loev5JJZsrdNkYcTEvJ5kOc9MJ+?=
 =?us-ascii?Q?rwwP84TDPoNQvAM8FfiTjJgMsBHcu5Rt5u0vkBdoNwmwrJkv2zUidIt2O7QO?=
 =?us-ascii?Q?NsNVJblx2npC1qr4KmlVk2hwOQG4Rmp1zlH1TRtRnTPCCWv43BouBfV1r0Mc?=
 =?us-ascii?Q?AjUsQjjY/HHON0apaAUW4WZZy736Jrf4+fLQ8gKIJFcaIMfqpe5zltdq3/gd?=
 =?us-ascii?Q?6MtM1NT5/0YwQ8DQUyU+5CP/Pbrk62kt3jhoxwyUBA/Lp9GMCryB6MAq9mdN?=
 =?us-ascii?Q?3h6rwVejKe8TNgQey6yHvVI1vvtWeAjRxXe87oFCq/SuyFJ0htMBlu5r50cN?=
 =?us-ascii?Q?9N2YV9pik9kec1gjhV5rtlftuJ7XLmigl5by/N4RnOaYTmLNGHUOEXv5x5Ij?=
 =?us-ascii?Q?PiKKUiWlBxOLOznrW9sJGhQBFGOcRohB66+7hVT9tUbff0h2S1HulWkd9IGG?=
 =?us-ascii?Q?Ij7QDP+j7Gew0CSLVQOQTV254UkhctdbW9S4OL4nWfJToVyL7ijDG+RS7lVS?=
 =?us-ascii?Q?0jZyavXp6+bzjNqWaaSpRxmOpKkSLV0aaoayaQv6kVGcAC7agOgcHQYRXi+Y?=
 =?us-ascii?Q?aqcfeCwg3hJBaEtlKMh8kV0olk+LoDL988D4jmbkTF+wowAyeDN3PKMjfFKT?=
 =?us-ascii?Q?mpZV/ZQAe9PP0yAcqQvmRR0PYVF//nX6VBjTCGlub66O/7AVgIT9bcTcQAod?=
 =?us-ascii?Q?iRnTDa3hwzvkir9O3vZiyU8heh4fuf8s0hg+/QFC9eI7GosJWD2vhTvhsi96?=
 =?us-ascii?Q?lJ8o0vDRasoMZIaismQ5Kf0Ac3+CtkD4o+GlOpAEvtfyyeXX9SUGwaleXrvO?=
 =?us-ascii?Q?73IS2GTvqhH9mx+XHaidTrKb4s4DPmIUACwonGmV/rCdoXIGmKwviLAp0+vn?=
 =?us-ascii?Q?9Kt6stiigfWx+v8iUUtcCD7kIjkZF0MjBLQTyh+Q/AUoANgGC5+URAVUWxHt?=
 =?us-ascii?Q?+tpEV74S8AF/8ZDvI11UtMahSTJUP8+Od7ErRdRw13AHNgdEdlFdxCMa9iPy?=
 =?us-ascii?Q?dHQ5RJEC/iyzqiwmekCeBpKiL+e7S7VjjJ5ew61bw18JrPtqQUaTmf+FsNRo?=
 =?us-ascii?Q?ARbSzyAlpP2jEGG2lHWTNUo024DBRA6pcqCX6zwjrZfR2aDBHC5qNIzBBlWp?=
 =?us-ascii?Q?O+7j5QwwDrmwEyQN24rKDqU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DyrFVDernaz+bLVs5BcOyUEbV2HyMFE+KePVuo5BnAPBjwh7+ict0vR06NFG?=
 =?us-ascii?Q?GmBjBXWWTu5bLDA7htFWxVtnQ8we2R3O0FkZmF6Q9B/vEAEmmnjHeqG72H2D?=
 =?us-ascii?Q?SpVpvCxGXDBEWtk1oD8ipW/pGTb1Bk9Lpa0x0T9vtq6BSJce5RB8mt6mPQpP?=
 =?us-ascii?Q?ILtqwdcFvttcp5pkur/5uyYFL8nWaCPZC03j5c51Pu3lvvlKzadqFot9It90?=
 =?us-ascii?Q?pcLbopxQgAR6b4osWz1l0Z8xq3RwOCxB3TdX2678TsyvhwlFaF+q43wSXpEK?=
 =?us-ascii?Q?fMaKYCz0wLq7EQLG56FXyzN4v4V1UUrLXBm4/1biMreVxB4XG0O452LmMdKi?=
 =?us-ascii?Q?bel8o2q0LS/OGdeuqbuTSuOfy5yy13Qco4tLxwX8YihDq06PUpdb3s4UOFAN?=
 =?us-ascii?Q?5OY2N1DwG8x9ZcToNHN4pdBNq+wxywA/Gkem4zLsTgnwVwfDr9cJnGj1GrD+?=
 =?us-ascii?Q?t5wccGt9kwOALWcdgU/kbFauW5BaJAiTy2qwI2WqntH2/3MtS2EnXSJD6K8U?=
 =?us-ascii?Q?JPSunfFATyFqom/3CoMFjtAHKV3MR4NQUcN2UGK4jrdbuoUCvoA8hNheoMjl?=
 =?us-ascii?Q?b6cnVbs67HXk7TMhTqQSQpHHVvqdLtdIY7+N8u8Cccb0SJsG350rjOOnT16g?=
 =?us-ascii?Q?rGiKDWCqE5trLvYvqP2S22eYqr2DMa5DHMxckjHJF+gbKLDCYGEWzWr6tZdT?=
 =?us-ascii?Q?tEVY6X5SggQVaoFSFu2vGh6fVCDEH54LKD+40cS5nMOGf/1dfhN9owNwZENA?=
 =?us-ascii?Q?DXSHvQQWL8HPZEbn3ANbbgsgUL4SFAjyviOGn+w67nM74DGDo2Uk+CmwZqjo?=
 =?us-ascii?Q?4kq/IRJXCUPFmoxX3pLumKDuD5TdvJtdQ/E5EOxY+0B7uB+O5Qqja0o27qex?=
 =?us-ascii?Q?/eUA9WPv/gchOkS4VkaoO03Xchh24ratycC8lKsubYvQp0k8G2R8YusBPH0g?=
 =?us-ascii?Q?gRI6BemgndRn8zZ4yhcrTforgdVn5fl22slyXsrSu9K+rrbcMf4k5FSBUwAR?=
 =?us-ascii?Q?juxXV9b+sPh0HWuYAnq80sORuxUDyBmyEuU4sf7qVsyF4E1Pi/bnkcS/VkZa?=
 =?us-ascii?Q?mMa94m3jnP8HcPJEnHt+ck9o6uedcA9QmHarQ0s6hyYCg+pEujtcXjLhB7L5?=
 =?us-ascii?Q?cXl8tN6WWL0F6RZFX2H716QzJiSArCDsAfitX9viFVjpQjpZZAqWhwjtVmiX?=
 =?us-ascii?Q?8H3vyHsjJvLkiTlXgSoLVA5H+a5MF87DA6+KXhhUUlDYl6riyShKISWaPou0?=
 =?us-ascii?Q?Ltz8fugv2u2po5nxeDQvBqDWDKLp4EDKIZ0oC6ATcwaDCpn/kdwEAuN6zdCk?=
 =?us-ascii?Q?uCkM2ZTxhb+uJX5DUbRSerKgGxlyJxNQHMoVzTrj5ScffiLToZIzGiwev+Do?=
 =?us-ascii?Q?0Gui2j8XR1YxZR6GEB0OnNfebGLsPZ+884Hk7UKUEoKKSh8d9/mLDHaxYREX?=
 =?us-ascii?Q?4X6NbTuo40srbdc4LBm9H59ShBPs32vKa8pOvYm48RkNdbgXG31+GA6V8euA?=
 =?us-ascii?Q?JMztk9v/s0/Brxhc+q2QdwW1AT08IHjIxzHz1eX9TwygiJXNceSYk+3n82j4?=
 =?us-ascii?Q?DwpvXLP5R/EJJyWpTTXL8fEdmdsmlekzJrCxnuugQxmKxIIYnsFz63Oxm9wy?=
 =?us-ascii?Q?YTU5m6oVf6MdoJkmfnQzkGDfQ5ei7QQuXLaWXuDBSIUO1IayXYWmR84Gjcda?=
 =?us-ascii?Q?x+c4uyqd3OyFvsfAYPC0d6QBhcYa5j7T+f9YuHzZEtN84G+ih5c849csBnjG?=
 =?us-ascii?Q?UB0hgwtxSavzCXbTFtefClLbji+8x0E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eb1268-bedb-477d-0c00-08de6494c0b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 08:58:38.4081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njBJ3fDfml6hvuQoe8lm0VZeaw1HAIEK/phSxNqSay6TWRwBTLllACnUPskIUD4G3yVKL6yPxQ7HKn6tO+1QYXyuE4iYotC7ErEDVerhz+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF263E38237
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-16562-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0F76AF0717
X-Rspamd-Action: no action

>From: Ivan Vecera <ivecera@redhat.com>
>Sent: Tuesday, February 3, 2026 6:40 PM
>
>Update existing DPLL drivers to utilize the DPLL reference count
>tracking infrastructure.
>
>Add dpll_tracker fields to the drivers' internal device and pin
>structures. Pass pointers to these trackers when calling
>dpll_device_get/put() and dpll_pin_get/put().
>
>This allows developers to inspect the specific references held by this
>driver via debugfs when CONFIG_DPLL_REFCNT_TRACKER is enabled, aiding
>in the debugging of resource leaks.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

LGTM,
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>---
> drivers/dpll/zl3073x/dpll.c                    | 14 ++++++++------
> drivers/dpll/zl3073x/dpll.h                    |  2 ++
> drivers/net/ethernet/intel/ice/ice_dpll.c      | 15 ++++++++-------
> drivers/net/ethernet/intel/ice/ice_dpll.h      |  4 ++++
> drivers/net/ethernet/mellanox/mlx5/core/dpll.c | 15 +++++++++------
> drivers/ptp/ptp_ocp.c                          | 17 ++++++++++-------
> 6 files changed, 41 insertions(+), 26 deletions(-)
>
>diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>index 8788bcab7ec53..a99d143a7acde 100644
>--- a/drivers/dpll/zl3073x/dpll.c
>+++ b/drivers/dpll/zl3073x/dpll.c
>@@ -29,6 +29,7 @@
>  * @list: this DPLL pin list entry
>  * @dpll: DPLL the pin is registered to
>  * @dpll_pin: pointer to registered dpll_pin
>+ * @tracker: tracking object for the acquired reference
>  * @label: package label
>  * @dir: pin direction
>  * @id: pin id
>@@ -44,6 +45,7 @@ struct zl3073x_dpll_pin {
> 	struct list_head	list;
> 	struct zl3073x_dpll	*dpll;
> 	struct dpll_pin		*dpll_pin;
>+	dpll_tracker		tracker;
> 	char			label[8];
> 	enum dpll_pin_direction	dir;
> 	u8			id;
>@@ -1480,7 +1482,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin
>*pin, u32 index)
>
> 	/* Create or get existing DPLL pin */
> 	pin->dpll_pin =3D dpll_pin_get(zldpll->dev->clock_id, index,
>THIS_MODULE,
>-				     &props->dpll_props, NULL);
>+				     &props->dpll_props, &pin->tracker);
> 	if (IS_ERR(pin->dpll_pin)) {
> 		rc =3D PTR_ERR(pin->dpll_pin);
> 		goto err_pin_get;
>@@ -1503,7 +1505,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin
>*pin, u32 index)
> 	return 0;
>
> err_register:
>-	dpll_pin_put(pin->dpll_pin, NULL);
>+	dpll_pin_put(pin->dpll_pin, &pin->tracker);
> err_prio_get:
> 	pin->dpll_pin =3D NULL;
> err_pin_get:
>@@ -1534,7 +1536,7 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin
>*pin)
> 	/* Unregister the pin */
> 	dpll_pin_unregister(zldpll->dpll_dev, pin->dpll_pin, ops, pin);
>
>-	dpll_pin_put(pin->dpll_pin, NULL);
>+	dpll_pin_put(pin->dpll_pin, &pin->tracker);
> 	pin->dpll_pin =3D NULL;
> }
>
>@@ -1708,7 +1710,7 @@ zl3073x_dpll_device_register(struct zl3073x_dpll
>*zldpll)
> 				       dpll_mode_refsel);
>
> 	zldpll->dpll_dev =3D dpll_device_get(zldev->clock_id, zldpll->id,
>-					   THIS_MODULE, NULL);
>+					   THIS_MODULE, &zldpll->tracker);
> 	if (IS_ERR(zldpll->dpll_dev)) {
> 		rc =3D PTR_ERR(zldpll->dpll_dev);
> 		zldpll->dpll_dev =3D NULL;
>@@ -1720,7 +1722,7 @@ zl3073x_dpll_device_register(struct zl3073x_dpll
>*zldpll)
> 				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
> 				  &zl3073x_dpll_device_ops, zldpll);
> 	if (rc) {
>-		dpll_device_put(zldpll->dpll_dev, NULL);
>+		dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
> 		zldpll->dpll_dev =3D NULL;
> 	}
>
>@@ -1743,7 +1745,7 @@ zl3073x_dpll_device_unregister(struct zl3073x_dpll
>*zldpll)
>
> 	dpll_device_unregister(zldpll->dpll_dev, &zl3073x_dpll_device_ops,
> 			       zldpll);
>-	dpll_device_put(zldpll->dpll_dev, NULL);
>+	dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
> 	zldpll->dpll_dev =3D NULL;
> }
>
>diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
>index e8c39b44b356c..c65c798c37927 100644
>--- a/drivers/dpll/zl3073x/dpll.h
>+++ b/drivers/dpll/zl3073x/dpll.h
>@@ -18,6 +18,7 @@
>  * @check_count: periodic check counter
>  * @phase_monitor: is phase offset monitor enabled
>  * @dpll_dev: pointer to registered DPLL device
>+ * @tracker: tracking object for the acquired reference
>  * @lock_status: last saved DPLL lock status
>  * @pins: list of pins
>  * @change_work: device change notification work
>@@ -31,6 +32,7 @@ struct zl3073x_dpll {
> 	u8				check_count;
> 	bool				phase_monitor;
> 	struct dpll_device		*dpll_dev;
>+	dpll_tracker			tracker;
> 	enum dpll_lock_status		lock_status;
> 	struct list_head		pins;
> 	struct work_struct		change_work;
>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
>b/drivers/net/ethernet/intel/ice/ice_dpll.c
>index 64b7b045ecd58..4eca62688d834 100644
>--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>@@ -2814,7 +2814,7 @@ static void ice_dpll_release_pins(struct
>ice_dpll_pin *pins, int count)
> 	int i;
>
> 	for (i =3D 0; i < count; i++)
>-		dpll_pin_put(pins[i].pin, NULL);
>+		dpll_pin_put(pins[i].pin, &pins[i].tracker);
> }
>
> /**
>@@ -2840,7 +2840,7 @@ ice_dpll_get_pins(struct ice_pf *pf, struct
>ice_dpll_pin *pins,
>
> 	for (i =3D 0; i < count; i++) {
> 		pins[i].pin =3D dpll_pin_get(clock_id, i + start_idx,
>THIS_MODULE,
>-					   &pins[i].prop, NULL);
>+					   &pins[i].prop, &pins[i].tracker);
> 		if (IS_ERR(pins[i].pin)) {
> 			ret =3D PTR_ERR(pins[i].pin);
> 			goto release_pins;
>@@ -2851,7 +2851,7 @@ ice_dpll_get_pins(struct ice_pf *pf, struct
>ice_dpll_pin *pins,
>
> release_pins:
> 	while (--i >=3D 0)
>-		dpll_pin_put(pins[i].pin, NULL);
>+		dpll_pin_put(pins[i].pin, &pins[i].tracker);
> 	return ret;
> }
>
>@@ -3037,7 +3037,7 @@ static void ice_dpll_deinit_rclk_pin(struct ice_pf
>*pf)
> 	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
> 		return;
> 	dpll_netdev_pin_clear(vsi->netdev);
>-	dpll_pin_put(rclk->pin, NULL);
>+	dpll_pin_put(rclk->pin, &rclk->tracker);
> }
>
> /**
>@@ -3247,7 +3247,7 @@ ice_dpll_deinit_dpll(struct ice_pf *pf, struct
>ice_dpll *d, bool cgu)
> {
> 	if (cgu)
> 		dpll_device_unregister(d->dpll, d->ops, d);
>-	dpll_device_put(d->dpll, NULL);
>+	dpll_device_put(d->dpll, &d->tracker);
> }
>
> /**
>@@ -3271,7 +3271,8 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct
>ice_dpll *d, bool cgu,
> 	u64 clock_id =3D pf->dplls.clock_id;
> 	int ret;
>
>-	d->dpll =3D dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE, NULL);
>+	d->dpll =3D dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE,
>+				  &d->tracker);
> 	if (IS_ERR(d->dpll)) {
> 		ret =3D PTR_ERR(d->dpll);
> 		dev_err(ice_pf_to_dev(pf),
>@@ -3287,7 +3288,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct
>ice_dpll *d, bool cgu,
> 		ice_dpll_update_state(pf, d, true);
> 		ret =3D dpll_device_register(d->dpll, type, ops, d);
> 		if (ret) {
>-			dpll_device_put(d->dpll, NULL);
>+			dpll_device_put(d->dpll, &d->tracker);
> 			return ret;
> 		}
> 		d->ops =3D ops;
>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h
>b/drivers/net/ethernet/intel/ice/ice_dpll.h
>index c0da03384ce91..63fac6510df6e 100644
>--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
>@@ -23,6 +23,7 @@ enum ice_dpll_pin_sw {
> /** ice_dpll_pin - store info about pins
>  * @pin: dpll pin structure
>  * @pf: pointer to pf, which has registered the dpll_pin
>+ * @tracker: reference count tracker
>  * @idx: ice pin private idx
>  * @num_parents: hols number of parent pins
>  * @parent_idx: hold indexes of parent pins
>@@ -37,6 +38,7 @@ enum ice_dpll_pin_sw {
> struct ice_dpll_pin {
> 	struct dpll_pin *pin;
> 	struct ice_pf *pf;
>+	dpll_tracker tracker;
> 	u8 idx;
> 	u8 num_parents;
> 	u8 parent_idx[ICE_DPLL_RCLK_NUM_MAX];
>@@ -58,6 +60,7 @@ struct ice_dpll_pin {
> /** ice_dpll - store info required for DPLL control
>  * @dpll: pointer to dpll dev
>  * @pf: pointer to pf, which has registered the dpll_device
>+ * @tracker: reference count tracker
>  * @dpll_idx: index of dpll on the NIC
>  * @input_idx: currently selected input index
>  * @prev_input_idx: previously selected input index
>@@ -76,6 +79,7 @@ struct ice_dpll_pin {
> struct ice_dpll {
> 	struct dpll_device *dpll;
> 	struct ice_pf *pf;
>+	dpll_tracker tracker;
> 	u8 dpll_idx;
> 	u8 input_idx;
> 	u8 prev_input_idx;
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>index 541d83e5d7183..3981dd81d4c17 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>@@ -9,7 +9,9 @@
>  */
> struct mlx5_dpll {
> 	struct dpll_device *dpll;
>+	dpll_tracker dpll_tracker;
> 	struct dpll_pin *dpll_pin;
>+	dpll_tracker pin_tracker;
> 	struct mlx5_core_dev *mdev;
> 	struct workqueue_struct *wq;
> 	struct delayed_work work;
>@@ -438,7 +440,8 @@ static int mlx5_dpll_probe(struct auxiliary_device
>*adev,
> 	auxiliary_set_drvdata(adev, mdpll);
>
> 	/* Multiple mdev instances might share one DPLL device. */
>-	mdpll->dpll =3D dpll_device_get(clock_id, 0, THIS_MODULE, NULL);
>+	mdpll->dpll =3D dpll_device_get(clock_id, 0, THIS_MODULE,
>+				      &mdpll->dpll_tracker);
> 	if (IS_ERR(mdpll->dpll)) {
> 		err =3D PTR_ERR(mdpll->dpll);
> 		goto err_free_mdpll;
>@@ -452,7 +455,7 @@ static int mlx5_dpll_probe(struct auxiliary_device
>*adev,
> 	/* Multiple mdev instances might share one DPLL pin. */
> 	mdpll->dpll_pin =3D dpll_pin_get(clock_id, mlx5_get_dev_index(mdev),
> 				       THIS_MODULE, &mlx5_dpll_pin_properties,
>-				       NULL);
>+				       &mdpll->pin_tracker);
> 	if (IS_ERR(mdpll->dpll_pin)) {
> 		err =3D PTR_ERR(mdpll->dpll_pin);
> 		goto err_unregister_dpll_device;
>@@ -480,11 +483,11 @@ static int mlx5_dpll_probe(struct auxiliary_device
>*adev,
> 	dpll_pin_unregister(mdpll->dpll, mdpll->dpll_pin,
> 			    &mlx5_dpll_pins_ops, mdpll);
> err_put_dpll_pin:
>-	dpll_pin_put(mdpll->dpll_pin, NULL);
>+	dpll_pin_put(mdpll->dpll_pin, &mdpll->pin_tracker);
> err_unregister_dpll_device:
> 	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
> err_put_dpll_device:
>-	dpll_device_put(mdpll->dpll, NULL);
>+	dpll_device_put(mdpll->dpll, &mdpll->dpll_tracker);
> err_free_mdpll:
> 	kfree(mdpll);
> 	return err;
>@@ -500,9 +503,9 @@ static void mlx5_dpll_remove(struct auxiliary_device
>*adev)
> 	destroy_workqueue(mdpll->wq);
> 	dpll_pin_unregister(mdpll->dpll, mdpll->dpll_pin,
> 			    &mlx5_dpll_pins_ops, mdpll);
>-	dpll_pin_put(mdpll->dpll_pin, NULL);
>+	dpll_pin_put(mdpll->dpll_pin, &mdpll->pin_tracker);
> 	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
>-	dpll_device_put(mdpll->dpll, NULL);
>+	dpll_device_put(mdpll->dpll, &mdpll->dpll_tracker);
> 	kfree(mdpll);
>
> 	mlx5_dpll_synce_status_set(mdev,
>diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
>index f39b3966b3e8c..1b16a9c3d7fdc 100644
>--- a/drivers/ptp/ptp_ocp.c
>+++ b/drivers/ptp/ptp_ocp.c
>@@ -285,6 +285,7 @@ struct ptp_ocp_sma_connector {
> 	u8	default_fcn;
> 	struct dpll_pin		   *dpll_pin;
> 	struct dpll_pin_properties dpll_prop;
>+	dpll_tracker		   tracker;
> };
>
> struct ocp_attr_group {
>@@ -383,6 +384,7 @@ struct ptp_ocp {
> 	struct ptp_ocp_sma_connector sma[OCP_SMA_NUM];
> 	const struct ocp_sma_op *sma_op;
> 	struct dpll_device *dpll;
>+	dpll_tracker tracker;
> 	int signals_nr;
> 	int freq_in_nr;
> };
>@@ -4788,7 +4790,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct
>pci_device_id *id)
> 	devlink_register(devlink);
>
> 	clkid =3D pci_get_dsn(pdev);
>-	bp->dpll =3D dpll_device_get(clkid, 0, THIS_MODULE, NULL);
>+	bp->dpll =3D dpll_device_get(clkid, 0, THIS_MODULE, &bp->tracker);
> 	if (IS_ERR(bp->dpll)) {
> 		err =3D PTR_ERR(bp->dpll);
> 		dev_err(&pdev->dev, "dpll_device_alloc failed\n");
>@@ -4801,7 +4803,8 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct
>pci_device_id *id)
>
> 	for (i =3D 0; i < OCP_SMA_NUM; i++) {
> 		bp->sma[i].dpll_pin =3D dpll_pin_get(clkid, i, THIS_MODULE,
>-						   &bp->sma[i].dpll_prop, NULL);
>+						   &bp->sma[i].dpll_prop,
>+						   &bp->sma[i].tracker);
> 		if (IS_ERR(bp->sma[i].dpll_pin)) {
> 			err =3D PTR_ERR(bp->sma[i].dpll_pin);
> 			goto out_dpll;
>@@ -4810,7 +4813,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct
>pci_device_id *id)
> 		err =3D dpll_pin_register(bp->dpll, bp->sma[i].dpll_pin,
>&dpll_pins_ops,
> 					&bp->sma[i]);
> 		if (err) {
>-			dpll_pin_put(bp->sma[i].dpll_pin, NULL);
>+			dpll_pin_put(bp->sma[i].dpll_pin, &bp->sma[i].tracker);
> 			goto out_dpll;
> 		}
> 	}
>@@ -4820,9 +4823,9 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct
>pci_device_id *id)
> out_dpll:
> 	while (i--) {
> 		dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin,
>&dpll_pins_ops, &bp->sma[i]);
>-		dpll_pin_put(bp->sma[i].dpll_pin, NULL);
>+		dpll_pin_put(bp->sma[i].dpll_pin, &bp->sma[i].tracker);
> 	}
>-	dpll_device_put(bp->dpll, NULL);
>+	dpll_device_put(bp->dpll, &bp->tracker);
> out:
> 	ptp_ocp_detach(bp);
> out_disable:
>@@ -4843,11 +4846,11 @@ ptp_ocp_remove(struct pci_dev *pdev)
> 	for (i =3D 0; i < OCP_SMA_NUM; i++) {
> 		if (bp->sma[i].dpll_pin) {
> 			dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin,
>&dpll_pins_ops, &bp->sma[i]);
>-			dpll_pin_put(bp->sma[i].dpll_pin, NULL);
>+			dpll_pin_put(bp->sma[i].dpll_pin, &bp->sma[i].tracker);
> 		}
> 	}
> 	dpll_device_unregister(bp->dpll, &dpll_ops, bp);
>-	dpll_device_put(bp->dpll, NULL);
>+	dpll_device_put(bp->dpll, &bp->tracker);
> 	devlink_unregister(devlink);
> 	ptp_ocp_detach(bp);
> 	pci_disable_device(pdev);
>--
>2.52.0


