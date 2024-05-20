Return-Path: <linux-rdma+bounces-2541-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033898C9F33
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2024 17:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B207B221E2
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2024 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19844136E21;
	Mon, 20 May 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjbM9FUS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC028E7;
	Mon, 20 May 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217330; cv=fail; b=Ovc2LmrJxHH2fCfIR5/24wU9cfNAexqcBVtwM/AiFE/BY5LIw2EGI1+K/Tr1NhtK922BmLGCwMMfaeslkyYiVkn0Vgl/cuHBB10tVV2pB5+nJSKhVIKuxneVxH5YBCUbE7CaMViQkCOnptJkK9LuWU2OGe8+HxgMH/de4XZIBRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217330; c=relaxed/simple;
	bh=Cgv4DdzT31/hoNnP/h19hDzyXjklnwOrmMM4sVlSfgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WH3fmlNjRDd+UL0ETEi2HcGPAKEoIJ7N6PWgJc7R96FITkqxTGfYayu2aK1jjiYY4wwEOFcSzupIsCpDG3PpXFs0YhMtemrmEO8OmxBFBT3tcoIkIvHIh0EG0dOpfbAY6IXG47vsxkBbbBND47lyVyei00uJTMjLDdTHjmxW5Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjbM9FUS; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716217329; x=1747753329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cgv4DdzT31/hoNnP/h19hDzyXjklnwOrmMM4sVlSfgI=;
  b=IjbM9FUSrHYo3JER37fIh3vwNHesmdQgSjT1PPMVkx4fT8qDgqVThZbx
   N5bOK4QARjoaUnSzWNKjP8W3epQt8R8KKAXGNOsDs89A5/uKvOJ6lRW06
   t6BFBk+2FcVINJc50Em+rGFFVFkjATvwcE+XBz4sZfVx7w7/RUdP3AVcT
   Wry82yGQ3AbKnwdzhHlVXBX1tAVmJqUrLLTYdHIVRblFuQrmICUR5xvxA
   T3uqF4uD7Nld4rNTEIm6C/CyWCn9ERtcs6RDyDPvOnbSlHM7E7nSChS9W
   DYhXAeyC8/iWNbWkM3S1mpT4b4IuX4DQQtvfSKhm9kU1iHxCS0TJvLhlg
   A==;
X-CSE-ConnectionGUID: hDaSmjhFQJCbLvdbv+nvEg==
X-CSE-MsgGUID: Adpyw4dVS8CH2RXKoLqOhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="16186707"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="16186707"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 08:02:08 -0700
X-CSE-ConnectionGUID: BQkYIN8nS4uFOTCcl/lILQ==
X-CSE-MsgGUID: 0dvuxxZARQ2UbRT7neT+Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="32543456"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 08:02:07 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 08:02:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 08:02:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 08:02:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaLZOBtcNTeriNDQNk2Rspit40oeFjYc+HCaaCCuwsLd55CZIdH4U+cYOBy5X6grx/UVUqxIVFCUBv15SI5uZ7DBsLC9g7CBqNR6PmJDVUclNrxbUZcJvOc4C3Aocpnzci2unexgMIiwXUSoT3dSOmozaQ7TWLAJZqWgrrVoTde9lr/yxrhvsaDtOgVZWAHAqKX3Gz0dn1+RBZsXlFt/EqpO+7G+qlDy2Ykk1IDpeLjkIbHs24xWSwA1ciaJzyjqtd/d4JgLgrl3zDMPJ/DU3S2N96zOrC8Hsf/n3sHzMGXjFQCAztisDrWuQghHP7UKsSCnw41H9NvfYXxJaWMUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqilOzSubAQal2X+293obb4dUI/kPwqkGYpibuQyNSc=;
 b=RAWyiDSVWhLaXdNhtKfhpOCbJw9bKhly/wSr0thN9q6+UyIkrgO2gqOOAcL5qDFtbt1Np8ArhzIXqqTm1Vwo8OKAcmL3AJnOHB9Z6a3dxaEXTdv/azaOGcaENYH7fOu+rGH+zmPq1geeRwBJPPXzKRnCNIIOtdrw6TzILwCvkTVuxD45WE9mXvv/MF+wc4UeXJ1AHNuMjWhtVpA16TQcG4wksCmnqAQmn5KdTrG7MHUlCgmZeNCCfPdeH8mKOnihLaKbX8ORWmN5S5dg2MRYlDFRnyMirY8YPPsK4NBhFdKXywPJnkbu9gJ/X3wrf0QxBGmpedGSEkEqfPQTOknMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7317.namprd11.prod.outlook.com (2603:10b6:208:427::6)
 by SJ2PR11MB7600.namprd11.prod.outlook.com (2603:10b6:a03:4cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 15:02:02 +0000
Received: from IA1PR11MB7317.namprd11.prod.outlook.com
 ([fe80::1ab6:9756:350b:dba8]) by IA1PR11MB7317.namprd11.prod.outlook.com
 ([fe80::1ab6:9756:350b:dba8%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 15:02:01 +0000
From: "Saleem, Shiraz" <shiraz.saleem@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Ismail, Mustafa"
	<mustafa.ismail@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: Annotate  flexible array with __counted_by()
 in struct irdma_qvlist_info
Thread-Topic: [PATCH] RDMA/irdma: Annotate  flexible array with __counted_by()
 in struct irdma_qvlist_info
Thread-Index: AQHaqbqLrIM5z5IgKUCP6kN3olXXYLGgOYbQ
Date: Mon, 20 May 2024 15:02:01 +0000
Message-ID: <IA1PR11MB7317A294F4AAFFBE7263EA6CE9E92@IA1PR11MB7317.namprd11.prod.outlook.com>
References: <2ca8b14adf79c4795d7aa95bbfc79253a6bfed82.1716102112.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <2ca8b14adf79c4795d7aa95bbfc79253a6bfed82.1716102112.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7317:EE_|SJ2PR11MB7600:EE_
x-ms-office365-filtering-correlation-id: 4d737ab3-2b1a-43b8-bc7e-08dc78ddcdf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?BKJzn/A3UkE+yHWX07B2FUQyTerBU4p8MfbPACXYufjMB/EFjW+6rs4PdSao?=
 =?us-ascii?Q?FNkomPB234vUs1047Y6oA6akJyM64La2iZMYAzEa2B1HVmk3GudWxzNgJoNu?=
 =?us-ascii?Q?8MwvUyar4g2oqcJd/fpcJ8+sxcKdCvECKFDa0tgxKEhy7zbT/D2KDHazxw8p?=
 =?us-ascii?Q?OQn2viTraW39BLNSyNF2o5sWsi5QQi6A76Vy/clzURBdBY5NxF6dh2HS1zIw?=
 =?us-ascii?Q?ogoaDZlbZKKoplibAnqBnbmmk2Mv4zUNwbiQ00QQv/q3axHHbPk6P2oclXYX?=
 =?us-ascii?Q?a4cykpQ+iah/3jkXv7151BCUkjKvU8CrkzyvAH6Nki6Pn9boKRIfIb8CwDoZ?=
 =?us-ascii?Q?XzwmOem06YrGGSl2THj5eCL0lQwAUjnX9ikZQbGZHn7ij+dd5tBTiEyeQxL3?=
 =?us-ascii?Q?vkaUjfnbcNIgBVuysEhkkwTH+9KhLEGNBwrFsWCEuVQVGCeSHtQboJ/AQZyH?=
 =?us-ascii?Q?pqSMvU2TXwb5YjW6rO1j2wnKJIwg4DFuKicCBXhi/CqyclUSSPDdRX/RlnqU?=
 =?us-ascii?Q?Gh2dZad/FeSmtIx3gNeVoCf6Qrur7moJE5exWDKK88pno8sCvgKOctdm+vbf?=
 =?us-ascii?Q?bDz8/7HC3eQ7ed3tmJ5I+yoyH4HvAMSrlDuoTzZdWqE9JnP1cTXWges/9iT5?=
 =?us-ascii?Q?QLLiKZNdOnzr1/aisJ5w5VwSrE7CRBELSlCvdWkZOzVHqpPyDzBTvLQqmvOq?=
 =?us-ascii?Q?KFW5vYZAVe0KMRl6b3qy/Ezc3E+JPziscLxLlC5TM8tNtDtbXMMxlPKiZXaZ?=
 =?us-ascii?Q?uFe45F+T5kr6aDBNDt8iMXxoqzjpkjluKTSUZgoGLs7Ku+8cDSeRScVV5fdE?=
 =?us-ascii?Q?A43W/EVQZcsjj6eUIZf34RY7H2qxeGJWQ210aa0r5CvfuXE5jihPdcIkfzhR?=
 =?us-ascii?Q?dR/c7i04ZbUAtY7DxGVU8aD7ujXh+Wdsp8WjkafZNcKiw09YtHlreI0+ieu7?=
 =?us-ascii?Q?WaxeTDw6zeopKI1NdcNxWrRRy5DcOUHCSMGKd+PEPMdqF97bSk2z4ns3vENG?=
 =?us-ascii?Q?TrJ8j6Jwa5xbg4Dw+7Ej1VtZLKzdATSnqNnwfekzK5lvXGhkoE2xc+vV9hrK?=
 =?us-ascii?Q?sBHFA/z6kpNEk2w4cB8W7EJgw/7Tvk22pBBqujJZ7SuIbWHTHcna/ZGZsKZS?=
 =?us-ascii?Q?4vFLtCUq+IvI5Q7UJdEUnAEwhfDYIluYSE4SZRjT2rE7Z4cDqesPg9e/K9hd?=
 =?us-ascii?Q?WIa4Rk5phfKM7tMrfR4N66LQykn/TCMXtuzCZB1VTq4hcz75WexmdZvBmuhw?=
 =?us-ascii?Q?Y5Vtg8CoZkZup5iOsFL4Qz1cWn4gGdkwSO6+1OfUKWAcjEF0gEfyBw7VOZr4?=
 =?us-ascii?Q?xiJd3MyQFmdouWG9nEm0o8g/9kHguVC/Y1TJ81Lau+UHkA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7317.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eSTM2lIaHXZDUYYErNFZX2QSnFevPjpWOKrs+s4vYa6FD9yePfS8DFpSBWcU?=
 =?us-ascii?Q?owmFQh+Sr9PxqNR+OZpJFwuK7vEhEgsjakWyhed/setOdX60kA3eKpPtA2z7?=
 =?us-ascii?Q?zcMvjcpWgGs+Q/kHBDtlb3PJAmErc95xiYKSm2cOpRSrMqqMo5sMFHYT7SBC?=
 =?us-ascii?Q?M0jyL2Cne4gx3RX6cmg7DKYxRf5LeMh3XFpjm9eHCnQDr5y/5mACxcrd3Ld1?=
 =?us-ascii?Q?sDw3UTz6aIpJNMO9anp4Vn6nmUsF/lHRpb7OoTkuKdeNz8tEgmoPn7fB73H7?=
 =?us-ascii?Q?A1kFgCKKl3RshcbVyQ3AhLi2pSf+yX09JEBeHEG+SJWLUJgNjO9Tey0nttFj?=
 =?us-ascii?Q?bfAjxPifBrZLXF1XAjezaw/368ng3czsWlqIj6PM8jpPVVwkVou2+5j8NpmR?=
 =?us-ascii?Q?GYJf0YwBjmT335CgeJfwjDsDL3jZC8iRSQRaww3fuBkpPHGGhLwUkGk6dFhR?=
 =?us-ascii?Q?Nkf9o9/T3kNOMa0EekGHrgjWfuzX9XcFcdu4v14OYh0Sw27g0AtPburx6y36?=
 =?us-ascii?Q?TNgyhG0KDSZeQ5wmmqI21Z+a7ekk5c6rX8+UKDSPMmPiVrFzrTXjVm8DId0T?=
 =?us-ascii?Q?cjCv4mb1eBiUTKuNPfkgElRUbzguc4o6OjwLbDg7KbywnP1UDGdqRT7YovT5?=
 =?us-ascii?Q?0NiDXUmMp9Jgt9C6vPxhUm64ZIPXDjXbGIjDK1AWYSEjU5venKT0DRrxNAlW?=
 =?us-ascii?Q?lHwj5AWa2HKrEOPiphwAt68iHPq2QTTqt0WZj6a2PJO9i59EzGO/MGtQSxEi?=
 =?us-ascii?Q?o7cc/Re3XGPcSYK1X5qf7qO9B9S1H/tvyTFljwJJGke3FKyPcSWUFBomP2Xz?=
 =?us-ascii?Q?0JSVOTXMPNr7H5cuEwmuIGfktOGQYchxNVGNWCLUkRvScB32jWEDTWo7XOLt?=
 =?us-ascii?Q?BsMbbMSG4wv5W/eoWAudCA2tob+loR0yyOjm25R0kwzRc4tzPmQ1ihIWzhUw?=
 =?us-ascii?Q?bMpp8Pvknj64ZjdT987j+px0g0k8RwQrIWXglKNxr/zGGomKrBjKCqWQwxL+?=
 =?us-ascii?Q?uDsEAZUsZk+P23MztBtC16fTqOUxrd5dZ7jdZ/cEpT7MnqIGR09agSEVnupi?=
 =?us-ascii?Q?+P9utdaIoIqJcZHHiRO2x1ECYEbBMRV3GjKO8H5OBSbFyQkC+QYkIjmTiHN+?=
 =?us-ascii?Q?2YRT/uQVFa4S/+lO78Y6Q1YYEcYqYmNEnQbcq+PTkDGPJpfUDRTx3BZ1H6++?=
 =?us-ascii?Q?osIae8sJk4SiKip4RQJCLYljQOJuBKiOdm6TqkihcCQTrdKNrCWR4fB3EZ/h?=
 =?us-ascii?Q?el2BDRZECtlzQvW80ZRXDGwXN2V6zcMSx97jVngEpxYReP/zYFNbgJm+3hLa?=
 =?us-ascii?Q?XI4cNuTGzmqwTU6JdIZ85JpN5jM7EP8COrL5TNfyjU2w5Gz+peN99JvCTmRe?=
 =?us-ascii?Q?SqDVLdF1rG++ND3IrxdbHF7JxVp/bU/5UM2GJNEGzWW08iw+IENyvlOkLwoG?=
 =?us-ascii?Q?DzriolK4UaN9E7njQEB610BCnrA8hBoqnQrjZgKkQlTQ6FujohZ1+/SvZJsK?=
 =?us-ascii?Q?R7d/9ASkJO5k2aOULjfXlB4ERZmONDUW2Oti/jxyPx8roJx7oXcy/Msw+F2m?=
 =?us-ascii?Q?cb/5ajvrakUn2KiLFuLHZJdF8dHiwOEHYkEPUV5N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7317.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d737ab3-2b1a-43b8-bc7e-08dc78ddcdf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 15:02:01.7694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2j9FUpJuuCuUV5SCMOdB8UP1e7g5z7REAmfrUbHAR10NSTHfzt/08OY4PjGu1sLYZz6N6RoQICrwZuxKzOeKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7600
X-OriginatorOrg: intel.com

> Subject: [PATCH] RDMA/irdma: Annotate flexible array with __counted_by() =
in
> struct irdma_qvlist_info
>=20
> 'num_vectors' is used to count the number of elements in the 'qv_info'
> flexible array in "struct irdma_qvlist_info".
>=20
> So annotate it with __counted_by() to make it explicit and enable some
> additional checks.
>=20
> This allocation is done in irdma_save_msix_info().
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/irdma/main.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/main.h
> b/drivers/infiniband/hw/irdma/main.h
> index b65bc2ea542f..9f0ed6e84471 100644
> --- a/drivers/infiniband/hw/irdma/main.h
> +++ b/drivers/infiniband/hw/irdma/main.h
> @@ -239,7 +239,7 @@ struct irdma_qv_info {
>=20
>  struct irdma_qvlist_info {
>  	u32 num_vectors;
> -	struct irdma_qv_info qv_info[];
> +	struct irdma_qv_info qv_info[] __counted_by(num_vectors);
>  };

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>

