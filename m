Return-Path: <linux-rdma+bounces-14738-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC80C82E6B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 01:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E7844E1833
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 00:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD11548C;
	Tue, 25 Nov 2025 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hS3lhrsf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447FBB67E
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028923; cv=fail; b=PORZIMX8oob/jIcMVU2BVImNJ58AX30JttrvYglu94ashO5PJ5uyycQhLbkeCs763Wh4jXZcegUcVxbXnukzaC0y2RtfJlzouANlwthHXpKfOUC0ALsUFOXdR26OO4hUXlho6kCm+x8VKa/oYH6PQ8OlCYyLYteDn/tCejFNGas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028923; c=relaxed/simple;
	bh=gglzkH/QNNFtADKG69iub1laSXIVFdvg5g7r9jHOaeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=go1Iiht7vRjZePDAQgMF3997SIXMErkIXDdNJqUYKnQryb5QQNodPsv5YmDLUhengOyIo9aPEvHxWbyF0f5KBTy1wLX43ftvwlFzDM1V49ajWxl3b03O9e/G57aT2UYGPw7lxsLWJc4Tx8plTMSnXMDXesS3KD0pDeK5MdeyJUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hS3lhrsf; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764028920; x=1795564920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gglzkH/QNNFtADKG69iub1laSXIVFdvg5g7r9jHOaeA=;
  b=hS3lhrsfxiyidIUstNysJ4c02ETK6VDftsQV4rIId4PhCeVpmYn5ZL05
   nugF5qGn8EBNG9pG8aiiC2NyP9QRUfP814+7rtAURnT3cW3jXTz26hgnT
   RCuKNS2NMDEF+EPKqOzqNnRKGaUy1CBppDgSPiS/Lfz+WXuVYO+EsqSEv
   DaI1ufKvX1pr2uRgrdn8VGHjFm/DPc/TeUNllLP2qMaZkYgLvszykcgD5
   o5TL/36QnRTUHEeoa2fEgg2fkZxanY95v+xSgq31XbzzzfDqB7XzDl7rr
   NLclhDNb4Mi0rbc39TRNPfm6psXaQ8KJCrMjac1nlhdsyRQ1ZFYHsDgat
   g==;
X-CSE-ConnectionGUID: jQETzoolSH2wR9421QSypg==
X-CSE-MsgGUID: kSO5penfSK2KwCqDv8igFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77151880"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="77151880"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 16:01:59 -0800
X-CSE-ConnectionGUID: 9WDud/rkQT2zev+68JPfew==
X-CSE-MsgGUID: X2ODwQrgSsSswAqMXThT6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="192475572"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 16:02:01 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 16:02:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 16:02:00 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 24 Nov 2025 16:02:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rnsv+NQHGlL/ef7k7zWE8EG6wn8bbPv92lhod6tUZnXMa/ZiE13ecIVMrXejxvjg5Gr+6HMO6Lhtrv7ehxAEi6QOLzoP1XSVyTIFY8ZTyehHs/QTiXvpCV/9qcdNORe2MP0ALhZADdqYKnc5HpUN8crevuMM2Khxa9DoAh1oGzdG3bVv3ZmFtIMjjXl021Kyw4yrtHirspCfOrSjMntt/sCB1kkgZUdnt8a9V7Cj6tmycEGuJAsMBHpWmcCBH1D2dq4/Djs9bNVdTSkiUG/snZiLE2CxzYZ9Y8q+5R0yY4MvQK0SBqFhInmXpQ+lCnIOBrCpzggdJrXR72mtSojoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbV/6BB0heTPfBabpTk3grIoxpmSGpy2cWxJ24ywfPs=;
 b=dU6lWCRZ53xYIQboA/tPFohvTrg8C1JW/67/sdCDOFcgOFtxp7H6O6IfWer0DxBijqWQlwom4XTumdV7NsAW/gCKkqVuZTPOiS0RgFWA25t7HwslBRQQfw63y7ktVBUT25Joeok4Vbz8xnWFvDbg6f+AQ+FrVaJ9iGVJgVGOuHvlbXqibqtnQFp+9BBPYngmVMZm7hynxriDHGnASWZevnNaiuzWDoqmKfFpKQ45jOHlxMtAKcgft/JSR1fX9STR49AEdYd6+oQnODw/pOLYYHG5Ag8PMBXU/81LtXPccZHQ77YkutVTm2oHc5NIJomM19REstN7h/LgPOYa7rmWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17)
 by DM4PR11MB6550.namprd11.prod.outlook.com (2603:10b6:8:b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 00:01:56 +0000
Received: from IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::a99c:3219:bf01:5875]) by IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::a99c:3219:bf01:5875%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 00:01:56 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "Czurylo, Krzysztof"
	<krzysztof.czurylo@intel.com>
Subject: RE: [PATCH] RDMA/irdma: Fix data race in irdma_sc_ccq_arm
Thread-Topic: [PATCH] RDMA/irdma: Fix data race in irdma_sc_ccq_arm
Thread-Index: AQHcWAZN5LNIOxGS1kWYxN/uKXoNY7T/+fEAgAKTG4A=
Date: Tue, 25 Nov 2025 00:01:56 +0000
Message-ID: <IA1PR11MB7727155974748AE0A8479073CBD1A@IA1PR11MB7727.namprd11.prod.outlook.com>
References: <20251117210756.723-1-tatyana.e.nikolova@intel.com>
 <20251123084144.GA16619@unreal>
In-Reply-To: <20251123084144.GA16619@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7727:EE_|DM4PR11MB6550:EE_
x-ms-office365-filtering-correlation-id: ff2bc566-a9d1-457c-643f-08de2bb5d934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?2sQnqDA8el80Uy+Dz7lUljwq8Cw/Po/MU7ksjSF6HYtlEafiDqmF0ZCWGwnd?=
 =?us-ascii?Q?jbBf6cyOE5Uw1ErWLOJwGd7KoPjdGnIJvb69VVQhDCr54NYsnU/7TuymtH+v?=
 =?us-ascii?Q?DNlJUpflp7+D/1suWBcg8rQsOGov4/xjGNBmzXjKsy82HmWltzSzwY7QRFyo?=
 =?us-ascii?Q?/o8V/kMF466Z22GSdnhHN+4Gskp0xWlSdgXIRWI719zTrbVszBDWw+MsHfqt?=
 =?us-ascii?Q?S0im+N8f6qixL7grKYdnm0YZDC5XngCCyQXsvPt2BUJp53ebAONOlX9eO1Zg?=
 =?us-ascii?Q?h6VwGa8ryRpH3MHhDzl2H+s9a9ZjQSkg3FPPDMlQmdvqsklzh4BO/FuSG3Tv?=
 =?us-ascii?Q?aNEAXAlkq+zXGxAlfV6D7iTCqmq2IzoewW7A9XfiQyJGFgOIJ88ui01KqGMa?=
 =?us-ascii?Q?4RzXdiK8qYc9rAJIeZFumZNV8vmN3UhQFX7/tX1pD+Yyrc0hcnfHXWpOgmSv?=
 =?us-ascii?Q?aZeqbsUGcUhGCOWziu0bcJ9u8v5TDenj+noh1mEtmOim4tTndeCga6HWK7ll?=
 =?us-ascii?Q?3EnstPPTz9Qt4qbpez5XNxekVkb73Xqmxv0EjVZlInlHF+Vo7CVy6eAFNrzv?=
 =?us-ascii?Q?8dYLqjXkSqQP+8kxPXDbq7EdSasUV0GXuy9sdfOivuKwE2+8jZu2FatHu8C7?=
 =?us-ascii?Q?VvYOFIyBuCyZ1D5DcMx5w484BwbttiLH5vBCWIUlzL/i8SCx6P2HYiwKmD4b?=
 =?us-ascii?Q?ailpSHQPRAjSVblgnpn/PdA1/G2ELePeYgdRw1BdOBLgrMdaEBIDbCAQD8Ze?=
 =?us-ascii?Q?LdYS0aGHs0YBRUFppLgSB/gXd4G9fbjtdCB7pqkH603u4EqXi04FN2xHihUO?=
 =?us-ascii?Q?2gB36Ttz/Y6AX7Q3CdNPeb5u2q58MvAjAPPGYv+V7YVJjZZy87h+zs6oJQYE?=
 =?us-ascii?Q?qcCAGKAraMM7IOizQoko5UsbPVYFY2BT9wumE2hVPNaNi/Pbxwqhe91/QnCd?=
 =?us-ascii?Q?+TUbTZqDRa06ekzWH8Faxjb7N+G/Y7lSk4hnHJrtJ3FV5U5zFLJpLgnXzjF9?=
 =?us-ascii?Q?Ie8ebwYH9YBHX6X2avBH6cFYdLaoZJzCkN2ViAOC7KXZO5l9kwZ8hwMg+GWc?=
 =?us-ascii?Q?Wkw57OtJQ3dTMXfN5OgKtStjncWfuINYWiJiIabRm0gtgE77C2ACkdO30fJT?=
 =?us-ascii?Q?cCPv4tS4GQK1x7HIsqqqqa+5XM4gwOmyChh8JETgMruuXSCL8dutk07ku9nc?=
 =?us-ascii?Q?pz6JR/qc0WSF7l/U3ARvDTwnTSGTEe6vT3f2zILVLh09NHCJe516HCgzqYDW?=
 =?us-ascii?Q?vlqYiw1Pjwss2yI3CaKpYLYVv1BOeu/Z9hEjt0SbVjeAsCF2R0PCEYYSpFlA?=
 =?us-ascii?Q?U1PN2mwzU/A6O7Sgd7cDnP5tauOaCj8K8ud6anuC/vO2R9esb78EPGl8xq8j?=
 =?us-ascii?Q?b/iFqgMZ/Rln189/slqTxuUdu7bXCtxjQJXnFoSJaVNG72gm88ubrinJKZPL?=
 =?us-ascii?Q?diSR4lyrAm4raVmepY0MbUVhxnKXm5BP021AxQTGADnAwqDegRYU2wUiVCZt?=
 =?us-ascii?Q?3hy5faX4dv/xl52mfDz1V1imT3XuWSOsVeqm?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ya9Urqaga+SSYzEKeNxnQLhkIFra4gZ24rz+/pnDtZYMjc+PviUHKSumXM3n?=
 =?us-ascii?Q?myPskXFkET80rjrLIUlUCQ8YhctD+9OURBqE0tNg7f/DN5RR7r8+6V9Qyg1h?=
 =?us-ascii?Q?zsDu9BdDpHy9KimqamP8CZ0yJqJ2wiV+15sc4KPVWbz8ox/f+DEpMmkIW21L?=
 =?us-ascii?Q?ztQqPWg9w+21P6OyODd8HLkDeVC4F7BqUDz6TNKr9ITOD8fEEkjsFuHcVhbB?=
 =?us-ascii?Q?ZKkrSmJIKjBiRfCHtcPmaMlD4rMuXV00do3CU6fR1hk+nksRSVNkiTTYwhEl?=
 =?us-ascii?Q?BwX2xZ7y6aFcSnwujeTOhf0QmaGiz2MnPhObyQAivvUe87nKJvMX2qCBJVHV?=
 =?us-ascii?Q?lyjjpSY9Rc2C/yv8S+M9yQxLVu6zPhZQ+zTFf+8ZCGGweSrU+JeSN+WQuXFA?=
 =?us-ascii?Q?UQpYZC5GdtmaBxWw8i5L/b2GFhbCVAE/1MWJ2pR97Z3BqufZIa1a4SN2tyPw?=
 =?us-ascii?Q?BygMqVWKVYhz6yjfe6xZMuP9SofXa4L+jLJeJeficOAfBRQnEYlnPSk1NnMw?=
 =?us-ascii?Q?rgkBf3AZdxOc3pk9puAXyJChZuQLD/6qNf9firmpY9lnkYG9Ai5bZgS3Bka2?=
 =?us-ascii?Q?Ce3J4Z5tdRGuKhAhiSDHAeuFfGR4oAOeT5OzVXY9ECCE4OPAmt1MBGS3R7wV?=
 =?us-ascii?Q?VjY4L8DKxRxoFvyIOUKgCHNgugD6AWi2I1yj0azQW37QSM5Uf8zsPukiDatA?=
 =?us-ascii?Q?9yqYLhWaBV38tEwx4gxi2YLabV6BQL2nGq709+HHRSeCjXWZWeX+X3RrCkwy?=
 =?us-ascii?Q?BuEWqcELLa2gR0orw3ojSj4oYmwc7eY7mlK45FZGfcRZnqfxQysc0JyUodG6?=
 =?us-ascii?Q?wbO6VWWqQ2iCYEMt5dbn0WRu0G3mRGT0sCnggAEHCqhsS6i64yVRwP4fcrO9?=
 =?us-ascii?Q?oP5vk7rRLq2h/bm3Q+EETkNWEPdk9iKXTJoZM89dergKrgzqEZI0amdlHGk7?=
 =?us-ascii?Q?Xqn94y2rQKuzrGVsod4e39/5/UBdRhOW9ybPF0C9sqXlcvZybMyWnUfq6+es?=
 =?us-ascii?Q?K7lQoT98mvFAHwzsmLZHz4yDNXXWEX0cPN/wZnoKQB+hpm/Xk/IpPJBMh6Vz?=
 =?us-ascii?Q?fb45ibeGyPGBJChUZUbHqu6D85dN4Xh+LW/zRAvGJ74UHKiK/k0MmM8qafxX?=
 =?us-ascii?Q?hOhvcGIZpmC/T1fBUykWdrKpunCzg298wBkuO6tQ2KNbXaUq6dU87OajbZei?=
 =?us-ascii?Q?+6OrzNavU402w527aTEJRKt4RRmCq736ahRaor1fmFllYnHi3VWKO7SE/RtX?=
 =?us-ascii?Q?zsdXX9vChx2fcAhBgdnm8Iy1dvlfJPYC3BNKsjQ1d8vUpxS+n83C67FXU8zV?=
 =?us-ascii?Q?xiv0z35at+JgFQ/+H7EWGyubk6mzoYu6sEpT/F9w06WoDaehRV/n4RJhh7fR?=
 =?us-ascii?Q?fYADITxfmb8QcS2zy14MrBiiPKOaSApjzTZzO9CHNwx19k7JVs0Z2DdjI8+w?=
 =?us-ascii?Q?lRAXSSPTIjJLoxxifQgxWF1+AT9WVtwDQNSa38L71N86Puo04vNfPXyvoHx6?=
 =?us-ascii?Q?G6P8OyZx30HeglRorKEbUMvEmbQWAKkkY1PddX+RYJ3iGgWHGTy8s56oHxKA?=
 =?us-ascii?Q?i+sV6zVg9jkhMMDIw7upkVQ2/Igc3JZwO7dUeVEkSOWgOOX0oapdysr/yC5W?=
 =?us-ascii?Q?Fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2bc566-a9d1-457c-643f-08de2bb5d934
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 00:01:56.5894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7xmYLomXOaYhArxF+pqGLN9CixPNs2yQ5fPPjJv0MQaLBT4xUeFDHqpqLqRVWX+Sc7S7kidLIYk/i3vnsJe6LZRh/Qk84OvEjxd7p0QtpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6550
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Sunday, November 23, 2025 2:42 AM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: jgg@nvidia.com; linux-rdma@vger.kernel.org; Czurylo, Krzysztof
> <krzysztof.czurylo@intel.com>
> Subject: Re: [PATCH] RDMA/irdma: Fix data race in irdma_sc_ccq_arm
>=20
> On Mon, Nov 17, 2025 at 03:07:49PM -0600, Tatyana Nikolova wrote:
> > From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> >
> > - Adds a lock around irdma_sc_ccq_arm body to prevent inter-thread
> >   data race.
> >
> > - Fixes data race in irdma_sc_ccq_arm() reported by KCSAN:
> >
> > BUG: KCSAN: data-race in irdma_sc_ccq_arm [irdma] / irdma_sc_ccq_arm
> > [irdma]
> >
> > read to 0xffff9d51b4034220 of 8 bytes by task 255 on cpu 11:
> >  irdma_sc_ccq_arm+0x36/0xd0 [irdma]
> >  irdma_cqp_ce_handler+0x300/0x310 [irdma]
> >  cqp_compl_worker+0x2a/0x40 [irdma]
> >  process_one_work+0x402/0x7e0
> >  worker_thread+0xb3/0x6d0
> >  kthread+0x178/0x1a0
> >  ret_from_fork+0x2c/0x50
> >
> > write to 0xffff9d51b4034220 of 8 bytes by task 89 on cpu 3:
> >  irdma_sc_ccq_arm+0x7e/0xd0 [irdma]
> >  irdma_cqp_ce_handler+0x300/0x310 [irdma]
> >  irdma_wait_event+0xd4/0x3e0 [irdma]
> >  irdma_handle_cqp_op+0xa5/0x220 [irdma]
> >  irdma_hw_flush_wqes+0xb1/0x300 [irdma]
> >  irdma_flush_wqes+0x22e/0x3a0 [irdma]
> >  irdma_cm_disconn_true+0x4c7/0x5d0 [irdma]
> >  irdma_disconnect_worker+0x35/0x50 [irdma]
> >  process_one_work+0x402/0x7e0
> >  worker_thread+0xb3/0x6d0
> >  kthread+0x178/0x1a0
> >  ret_from_fork+0x2c/0x50
> >
> > value changed: 0x0000000000024000 -> 0x0000000000034000
> >
> > Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > ---
> >  drivers/infiniband/hw/irdma/ctrl.c | 3 +++
> >  1 file changed, 3 insertions(+)
>=20
> Please add Fixes line to all these patches and send them as a series and =
not
> as standalone patches with reply-to to some random patch as it is now.

Will do. Thanks
>=20
> Thanks

