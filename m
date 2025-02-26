Return-Path: <linux-rdma+bounces-8166-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F28EA46834
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 18:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5B43ADC6C
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 17:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F104B2253F9;
	Wed, 26 Feb 2025 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abSw/0WJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A1224B15;
	Wed, 26 Feb 2025 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591423; cv=fail; b=U6nJn+1eooG0fBpXfrmXDRfyXXoMQFOwCkf2GcjYjXm2ZW2bB5aEzcl5Fi+JC2/5gd4iotvgl0R4pvjI0UGclHSjrbhSm5332V9M3uEwY7GfbIHV5WFiN4sA8U1kDsfHyg+i0fKAkeqJ9bdeFRp9VAX/SfziiwPYU4RDuUofFbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591423; c=relaxed/simple;
	bh=Dl/ylogwQn4G7ikFm4xqms93w6o2+ry8dLo6mB91iJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l94Mny9bbpyjU1xMfwwewNplOYATAqs6AZkGFTjSLU0fUNPsHoAImGLXgU08R3auO/thGgcDr9rFBHUtYLVsYM2/QmCD986IHqzU1Ou/ZLp57ND62w3eiRK0H3EyHYy2lZ5miVtoncAxCLAmzoN1ClV4a0Lb57bWrXuyq7d/jT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abSw/0WJ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740591422; x=1772127422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dl/ylogwQn4G7ikFm4xqms93w6o2+ry8dLo6mB91iJE=;
  b=abSw/0WJl5ldz/TanNWQIGgY4e2c5KcWLScLi8L4Jy0VPI5zonv6X234
   s78z/SRLs+wDwbE5uLZZ/C8uG26qCdd+3HxDHLNQQWRixL2vB0dkjPuHt
   zf4wKMMUja79Gl4KQwWC7okulArhYzSlsnQ+CuAlp5cqP28reYms5+YqT
   vU4hC3s3dkbPSiZZAZ+ceQm04joQTn2S94XfzHh6mugmUvnTTx2RjezeP
   FNhzI+HjC/vQcS4XG9ujayJtetA2VsNplropGFhrrNzBFcLxgb6ebPtzE
   s57xSTrrDH/DJWqUL0GK10+5HnKwcKr7MaInIu3D/xaYcc1rrgNemoiJh
   Q==;
X-CSE-ConnectionGUID: 5Q7qsjEGQG271bA9Z++UkA==
X-CSE-MsgGUID: mjQWxaj+Rc+vhojB+5CLMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52850691"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="52850691"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:37:01 -0800
X-CSE-ConnectionGUID: Z5JGUmzEQ9eo88wWuYtPnQ==
X-CSE-MsgGUID: cfFMAOs/TJ2bmTekLObDBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116550998"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2025 09:37:01 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 09:37:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 09:37:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 09:37:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URQiCDzukYIyPsjGAqhuE1iiILTbtG7HWTQyszsY+DhqiCFZz5zQHZAqZpVToFbmHyj/+b5artQkqeTHrzfLN2PdCbRjqMnm3XZ0bE95Imp79zpPFBFDx6htDjY2dYPEKRS+GBxhuc7G5dVxOAk798RPzV3MhvRl4dSDAg7mQBj17jMvg2wL+kk73VFq/ynmcklax96b4TOdb0oZSFL8b69vsf0GCwhPuxOfKCgrcZLd9nJFd1gzVrzcF4/myWdB5tEYzUG6sr6pPzia9pYO3BgMjDCEjA695gOYN/4jsaHM8ezvukWe3SdsDwhHI5CgLZtCf3gknCkn1L+p9OW3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+CFq6gELgHqcrDa9KYDElKpgAKB3L1hC4siFG3OcWA=;
 b=JBnR62TT45rkVbbILJeHC1ljCtsdNGeuOb6U1cmhrZRh2k8B7K+vG071zqBglKxJU0ryi5Obbpmc2KUyOmpp33dY3oMtPfUMiueM/NOAOG3j1YvWIkNiEpwwyg6GfKlFeN4Hf7v4I4yHMPGZh8CCIqe7LcVQRKeScj7hbCbdYZP/1ilysiEK+Z3xgrcOgeKm7wo2xgFQAqN30F1A+lByZvv8MtkVwJ94MULeLLbx6Lfy//jjbS4cu4w5Ux2ZMhdy1myjd2hLsPYV+EuP1989VN6JkMZHt5Zzr2p4kmLYQ25akxnrzVdheHPEzI/e7XipNwNq/gnWKYGJ4ri1FGpQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22)
 by PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 17:36:44 +0000
Received: from IA1PR11MB6194.namprd11.prod.outlook.com
 ([fe80::4fd6:580b:40b9:bd73]) by IA1PR11MB6194.namprd11.prod.outlook.com
 ([fe80::4fd6:580b:40b9:bd73%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 17:36:44 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: Leon Romanovsky <leon@kernel.org>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support multiple
 consumers
Thread-Topic: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support multiple
 consumers
Thread-Index: AQHbh0Lrc4Ejq0Eq70KEJtqLnJXSa7NXpsEAgAEFtbA=
Date: Wed, 26 Feb 2025 17:36:44 +0000
Message-ID: <IA1PR11MB61944C74491DECA111E84021DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
References: <20250225050428.2166-1-tatyana.e.nikolova@intel.com>
 <20250225050428.2166-2-tatyana.e.nikolova@intel.com>
 <20250225075530.GD53094@unreal>
In-Reply-To: <20250225075530.GD53094@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6194:EE_|PH7PR11MB7608:EE_
x-ms-office365-filtering-correlation-id: dae9cf0f-9af5-4958-ca9a-08dd568c2328
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YA9mpbwofxNQMHQHIf4Lg4E6WWeWHGs/JxIMe3RacZnu0/pxir/cjywf2kEz?=
 =?us-ascii?Q?z3GOFoqwP7yMNO+jhv573vSvcouD1xmk5I+slFkc8FqSCRgM1vcip7S9Gswy?=
 =?us-ascii?Q?sVBpl+UsrbsCQlhAH4TMzZq4KBMHJdhH7pRoZwsXp7NGodI/ClApHGm2M3mF?=
 =?us-ascii?Q?6CPKicLR3x4TVjZLrYTEFRTEhUAN2QrETtSQe88vIP7jdvRIyVG2OL7J8pXJ?=
 =?us-ascii?Q?kgb84Vg9Q2HKNEmmE/gleZyxVA+m9KEmH3sruOFiqSatVpxAJxq/rTMLbNhk?=
 =?us-ascii?Q?6LAThoXx+rF2pKQFW/Neob3Y5glJD2kY1mF/ELRQK5J57ooYEELSx1UCxfUI?=
 =?us-ascii?Q?SE852NHBGGxSpn19FpMVNlBpHXFRkaNd6MTpa1JBkMWYUFIIEFG3j3NYwh/6?=
 =?us-ascii?Q?mVi9FdsA7bDIMM4tlepe8t5nE1eOivvoeFIyFBOEzjGK9oKhufSZNTkt+Eju?=
 =?us-ascii?Q?b30qo0K3suMpyjOzSL9P3e/2fZ7EQMII0pQyVyfHYCHZ8Kqz4+sK9ELRtigL?=
 =?us-ascii?Q?jIt5slD/5PbrlNzcTt6dbRvf30Dwgol4Erqf0Ttad24Bc4MZEcoKzzwDC1qt?=
 =?us-ascii?Q?sIkz97i2/V9xsougrLekIJSvHlxXcZe694JdN9C5KVWr/zM9V3WLC2oK7i8h?=
 =?us-ascii?Q?1zr8CpD1rrOdSHhuhFzS5sW8yMsMTnN7LJHWpeGIH9Rag67b8JBIAD82Aq7I?=
 =?us-ascii?Q?uRR+t3ehNWxC0LPzOz8ul+4rojHwT07fxU+X84y0Y+aJNCPV9Uf0vpoiuXpE?=
 =?us-ascii?Q?ocCr5F93Oke0OJUGSlUurh4yyBlTFwNPJlcH/2U8O3zcLCUPLV6iRMumdbBb?=
 =?us-ascii?Q?koQ43dtLPXHSJtGF9VNTo/EPJw/xa6x4CcGJrv2GO80fxlboFO302TNh84DO?=
 =?us-ascii?Q?uOVEj1TyYtGz1rzrT2UkpiUZUZyv27H+bmZVnSMImY7Ebhyik2taG6ELKJi4?=
 =?us-ascii?Q?HRTgXKYtJk90YRThQJxYuCcniSGBC2XHa8PqlcSNMTIXdK3FLQd5DvkAp7Mf?=
 =?us-ascii?Q?cM7kjmLs9ONULOeESM6NGgTlQE5kj/sprt8ON0EztW2sozDTZciTfzdCWZsD?=
 =?us-ascii?Q?TyMQANzt2p7K4qoCrwplII2V0S2xMzobNwK3JfkdIf376PMNVpoqFfmDj3v0?=
 =?us-ascii?Q?YEl1UsFuOmnyKpRGg5MJZcc6VcsfoHKuryuY1WnkLc9lpI5dbvSw8pHFOX0V?=
 =?us-ascii?Q?/MtPNdg0rL7iJnk0ewyjiwDVVfc5VvIPW8jgBbPImylfm6k+9v0zr+5i5mms?=
 =?us-ascii?Q?A704LMgIOVmxw8ZiF2uazNHrchFV0MAALoJ/etk5pJnh477c61Loq8My1oKJ?=
 =?us-ascii?Q?o/8nPjITx9r1XWyP8mPyxkfAYNmyM872FVAPUIsq7Tdu+YoDbRmsgIy9jBcZ?=
 =?us-ascii?Q?iRtJRdZW06jKjA29+ct8AiJL3moDWfyyyBymSqdhTpoUpZVZw1tJSrW3gjbC?=
 =?us-ascii?Q?ZfgIW2zOp0BHnUDU+Qs6JBvQl731bvyj?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6194.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DWwiRc1CXOvdTMimImn/9esyU6dX5oK/mh3YsMgypQYLcsRaF7JedDj/sFYv?=
 =?us-ascii?Q?ime2V5dm/QO0eeq01pYZS9y5v+CXmGiVDsUpBWEbBjFoQWGQ02DvkTNfI7ae?=
 =?us-ascii?Q?OnfbzYiRe9FJSEdkf2JmycutbZcAfvYYp3cP4q8DShtRwTU4YJwR/AIpoQjf?=
 =?us-ascii?Q?g0c0eeo68nugGQaFjatxI712BLtR7SXaVp9qONXobWHesFXswGP231vLRnJC?=
 =?us-ascii?Q?2XRxOGHFpF3b9DC0A7qG+2LhhEA6PpRAGXX4rcX/0qfSlSSlbnbyj0xGBKPD?=
 =?us-ascii?Q?sdI+52ysnJbfo3Nla3gCeke19fbCBxwJErs6OYk1CjqlcQEtLU0gLqfX9zxr?=
 =?us-ascii?Q?xFXXvYTecBlCIIPTDl7aEdPlkvflH9/xccCISq7CuMvDsJ06sDPKTuLCX/Mj?=
 =?us-ascii?Q?vZwOZGJE0UCjr8x1ERHJez6MxHNx5IamDosRWrnrlWDdLgCqSTbYNtgEnSPG?=
 =?us-ascii?Q?3UeIgIeuPh5vNYiK8/95YIlAcG7AtBdTnWjs9yJljtL9Z/Y0qh4m9/X8/tLu?=
 =?us-ascii?Q?7SvYuD8RWCU9hkBWuL6Yd+DK7x16CM3rWXfJdR61rcUGDa0QbjJA+yVQatTc?=
 =?us-ascii?Q?KjjkKaH14dUDz1mPTKOnYIzNIJqJhhTo+5XbNCEwlrvyZxUu+tS0+cNT9Vxc?=
 =?us-ascii?Q?/37F3UEI2ypNAzG/klJ4N7on5IZLuImRpzUtZG0IOCi8dY6H7QKO5Em/fRkh?=
 =?us-ascii?Q?BR+fbPE8f0gjbDwMJsZo6TmI4+rwzizGZ+t8rNgXPmd1G1rwzIIG7KbeltKa?=
 =?us-ascii?Q?mj3lyBaep80nv1Z/Je/+Vwcek7eaBEMnKLkeoNNCp/t3BRG8eQRhYauIeu9h?=
 =?us-ascii?Q?E6OqejPCQa+7vWo17SHr1wQnEw0IvGefEUyePDqRQXrWdwCc6sdjJdOOrBsO?=
 =?us-ascii?Q?hbaduV8upSG4N1PDpJ6iz0jl9GTnkfvpvhVvpVY+w5mPTqOcnyhBupY+kDdk?=
 =?us-ascii?Q?w6/gpoNbxZAQhIQLBOOKORbVmW/A+OMXeppNZobFHCuOvpmf7vugSQ5kREx6?=
 =?us-ascii?Q?raigbL8ZCOMKhmT4F6gFU75+LsdnPSjvmCeQP6tbxK1v4ELjxUyMlAQjdb8Z?=
 =?us-ascii?Q?9M9yKv6s70W1xeXoAxsAnOacgJj/gnAJMSrsf/JUoMqBYNmln75a5dp5/JE5?=
 =?us-ascii?Q?cejR/aX/fRV14CYaF2K96DSERMQEz7KMxGSPCXQbQ2OIuuFv7+s4MgpaqPOF?=
 =?us-ascii?Q?73t/W18WiMdsAQ6fdAB2eEdV6SoHyxNi2O9wSuYl8i5+MluVwdELk3ldoPO6?=
 =?us-ascii?Q?Ft9rzOe2kBy8+J23i5z6FIQI2iriBDXcRbK75tXl2uIj9j/mqaL62CBHFufM?=
 =?us-ascii?Q?WxFvm7Y8c9oUXq3R4MTvOs+O4lo1dOZXpborW2lRVypUq3LHt5Xob2hOsXG3?=
 =?us-ascii?Q?wpiODkV9BX7Z/zWQ7H9+GcKlhlJZMXU/mpyf/G+i9Ye7PUnKDqfdFPCenci0?=
 =?us-ascii?Q?b8C5i2ANrvPlnHt2JA7V4vUV7QdaUVtldoeYyaSwAEWrb+qWWWiGgy3rdV1a?=
 =?us-ascii?Q?wr6gaecwMNcYSTBNvJTm68ZKtXl+WaE6aWsg6Cuh87+wIT+L/+aZd1mSiXdG?=
 =?us-ascii?Q?bQXrLrEXVb7fsOxjUbQfvyV7NL++gWwDYebHD1o9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6194.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae9cf0f-9af5-4958-ca9a-08dd568c2328
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:36:44.1400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLh1BGnlWrPMH46TO2LpVQpCTQogqE2YEaYHAMqpCVpE/8TIZWyHbX3Jqn7ASQz7fRnc/ow1osqPpwsZOzw+DPoEBqFW179Vl/TwmB6lZvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7608
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Monday, February 24, 2025 11:56 PM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: jgg@nvidia.com; intel-wired-lan@lists.osuosl.org; linux-
> rdma@vger.kernel.org; netdev@vger.kernel.org; Ertman, David M
> <david.m.ertman@intel.com>
> Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support mult=
iple
> consumers
>=20
> On Mon, Feb 24, 2025 at 11:04:28PM -0600, Tatyana Nikolova wrote:
> > From: Dave Ertman <david.m.ertman@intel.com>
> >
> > To support RDMA for E2000 product, the idpf driver will use the IDC
> > interface with the irdma auxiliary driver, thus becoming a second
> > consumer of it. This requires the IDC be updated to support multiple
> > consumers. The use of exported symbols no longer makes sense because it
> > will require all core drivers (ice/idpf) that can interface with irdma
> > auxiliary driver to be loaded even if hardware is not present for those
> > drivers.
>=20
> In auxiliary bus world, the code drivers (ice/idpf) need to created
> auxiliary devices only if specific device present. That auxiliary device
> will trigger the load of specific module (irdma in our case).
>=20
> EXPORT_SYMBOL won't trigger load of irdma driver, but the opposite is
> true, load of irdma will trigger load of ice/idpf drivers (depends on
> their exported symbol).
>=20
> >
> > To address this, implement an ops struct that will be universal set of
> > naked function pointers that will be populated by each core driver for
> > the irdma auxiliary driver to call.
>=20
> No, we worked very hard to make proper HW discovery and driver autoload,
> let's not return back. For now, it is no-go.

Hi Leon,

I am a little confused about what the problem here is.  The main issue I pu=
ll
from your response is: Removing exported symbols will stop ice/idpf from
autoloading when irdma loads.  Is this correct or did I miss your point?

But, if there is an ice or idpf supported device present in the system, the
appropriate driver will have already been loaded anyway (and gone through i=
ts
probe flow to create auxiliary devices).  If it is not loaded, then the sys=
tem owner
has either unloaded it manually or blacklisted it.  This would not cause an=
 issue
anyway, since irdma and ice/idpf can load in any order.

>=20
> <...>
>=20
> > +/* Following APIs are implemented by core PCI driver */
> > +struct idc_rdma_core_ops {
> > +	int (*vc_send_sync)(struct idc_rdma_core_dev_info *cdev_info, u8
> *msg,
> > +			    u16 len, u8 *recv_msg, u16 *recv_len);
> > +	int (*vc_queue_vec_map_unmap)(struct idc_rdma_core_dev_info
> *cdev_info,
> > +				      struct idc_rdma_qvlist_info *qvl_info,
> > +				      bool map);
> > +	/* vport_dev_ctrl is for RDMA CORE driver to indicate it is either
> ready
> > +	 * for individual vport aux devices, or it is leaving the state where=
 it
> > +	 * can support vports and they need to be downed
> > +	 */
> > +	int (*vport_dev_ctrl)(struct idc_rdma_core_dev_info *cdev_info,
> > +			      bool up);
> > +	int (*request_reset)(struct idc_rdma_core_dev_info *cdev_info,
> > +			     enum idc_rdma_reset_type reset_type);
> > +};
>=20
> Core driver can call to callbacks in irdma, like you already have for
> irdma_iidc_event_handler(), but all calls from irdma to core driver must
> be through exported symbols. It gives us race-free world in whole driver
> except one very specific place (irdma_iidc_event_handler).

I am confused here as well.  Calling a function through an exported symbol,
or calling the same function from a function pointer should not affect the
generation of a race condition, as the same function is being called.
What is inherently better about an exported symbol versus a function
pointer when considering race conditions?

Also, why is calling a function pointer from the irdma module ok, but calli=
ng
one from the core module not?

Again - Thank you for the review, and if I completely missed your points, p=
lease let me know!

Thanks
DaveE

>=20
> Thanks


