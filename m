Return-Path: <linux-rdma+bounces-14678-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8402EC7B158
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Nov 2025 18:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE8574E2FBC
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Nov 2025 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF52C2EBDEB;
	Fri, 21 Nov 2025 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Saw/OqeP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6C254AE4;
	Fri, 21 Nov 2025 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763746529; cv=fail; b=eTK4SHvIvo6BU9PCQO0GwryhtccKoLAD/RIMOTDf54VEHxKCL4ID0GmyW47SssGkg1LaiXGyjoxNpshngyC5qopiB3+uAom6+jlIKInevz0Hl3Y3XoUT7W9v6o8+e0eTnNXgm0Edhhl2u1YPceqyRG9BLn0IcMPGnElB9ZFIePo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763746529; c=relaxed/simple;
	bh=Un5MbcxnofICdwdRUYJ77NvKwo/RMvCebUxY34Gqjj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R1Cag8lQlXQjnWgmh5d3FUxltwZUQfxwol6FOKx2iOaSXfYQX1yQt23hrLhfjGdCoBtnSmrpu4TVoP0eQQZqtQPI9NV+Si7SUA1lPIB3Fd2/OQOwbpwVK0U1UkWB1/QvVdnLdzCxgujPK93QgYKDOtNiTnwxD5EWAgneW/kCBps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Saw/OqeP; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763746528; x=1795282528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Un5MbcxnofICdwdRUYJ77NvKwo/RMvCebUxY34Gqjj8=;
  b=Saw/OqePKu92ELCfdHJFOrJykTd4TkhB5Gvz/g53xnvoOOZoUiEloNxW
   mh9bn1Zv28nwoN5/jTM4eLv8SKUoYlFK+RA41dh8qsTMNsp3j1R2PCoxB
   2T8XZpqRqml0SnRRpqOkj4lDATshJa0pbE1kLGpadOe35lTb+iEzi087c
   P2ca/jjfs1DSQH+sbHdI5jtqoVyY+v2QsANW91f/l66RIppMv+PlQulWL
   lJ3cgJVpfmpmV8Vlm6M6xR4vu0/RA14HgFDhA7/ZftUtWtFT+ifAvUUoT
   vbiSSZDmH5USiSPU3s3BBxhfd3ov4tHUnNRjFhihMTJP86NyBRpj86Er9
   g==;
X-CSE-ConnectionGUID: zfaDoJ37TYeoO5j90HRDrg==
X-CSE-MsgGUID: 2uEAdkMzTFqqnQWj+ACRQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65737986"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="65737986"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 09:35:26 -0800
X-CSE-ConnectionGUID: lKELs3QiSYStMtJ4v79SFQ==
X-CSE-MsgGUID: i0xgSmNpSW6Kl0laoMt7sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="191527659"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 09:35:26 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 09:35:25 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 21 Nov 2025 09:35:25 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.51)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 09:35:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fh8/M1Yh77SdrB+AhXyfvG+jOZASgrfqd2g0Iina+CYntliVuv2LftQgh6Ldk74nCWLGG8FqCYgVlTTZTlmYi2Oyh2LUjTx1f/5S6t5wJDbwlLtVF+HvFuuAsHyZIvwOklxDzGkOGUf541t9HgUOYHW+bhchCmwnpD79JrWD/FpNeEXkEd6DI4GEanZ+9vHizpJUQUNZiJIsGOwRonDhaHAif0kXXnXAxBj8Kjec7NRGxU++MVtVBWhK3a/ZAcJyPejy0i2MJGKrCX2QeDKtwnkJDR0sjGk9N/z+c6Pf5hrbWONfiT415gsdQkwcgFPqbsF4k56pg1GsdMdCvpbqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8aAtbgAQOqJTSDay/rz/vv+pUcCdKD3joarfS+5oe0=;
 b=KNWgspX9AKcMRRPFCDR2qxna7kgX7Bf6AsnM05vAm4oH4u33Z1kZtXNVjUHbYadcn2V3OkJ4XSFJ6+YckDzpKFwt02PpSOVKEtARDbpNZEqaKSBvY50A/+NmhgVPxkjKBy71M4bRv4Rtm2stoIc0bMEV+gz1VWk9143B5M4/mLapXlP7iaSfFhSy1Baus7PMD5fgnzU77oq1OCaVBXshDv5JKkD0JmygupPxBBCljfVeq/HW4GJnc9Fo4WQQy++pVjqEw2iL3ECzMbIHW0qjz6JbVofTkGHCe5uhlA0ZsoOIoyXJpPyAp8qoUgdCcpnrEsEF5mHP+Gw9oEyOXfHTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 17:35:17 +0000
Received: from IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::a99c:3219:bf01:5875]) by IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::a99c:3219:bf01:5875%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 17:35:17 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: Wentao Guan <guanwentao@uniontech.com>, "leon@kernel.org"
	<leon@kernel.org>
CC: "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zhanjun@uniontech.com" <zhanjun@uniontech.com>, "niecheng1@uniontech.com"
	<niecheng1@uniontech.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: fix Kconfig dependency
Thread-Topic: [PATCH] RDMA/irdma: fix Kconfig dependency
Thread-Index: AQHcV7qahIyWo2fBAUGwd+yBTDlze7T9Zf/w
Date: Fri, 21 Nov 2025 17:35:17 +0000
Message-ID: <IA1PR11MB7727692DE0ECFE84E9B52F02CBD5A@IA1PR11MB7727.namprd11.prod.outlook.com>
References: <20251117120551.1672104-1-guanwentao@uniontech.com>
In-Reply-To: <20251117120551.1672104-1-guanwentao@uniontech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7727:EE_|BL3PR11MB6506:EE_
x-ms-office365-filtering-correlation-id: 33e61ed5-248b-4bf9-1b50-08de2924566c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?027uBC8FEwwMfQE6sKhkvNzBWNul1sT9kNkHJFqiG0PfH1If5r9FRb5T5e3h?=
 =?us-ascii?Q?bFoQOg6TnnLUHNooZdNLweCh/KWL4XQihF0GdC6eZW/W6rTwzoyVPxNUjGWR?=
 =?us-ascii?Q?0s839kmgddcuFifHEt+Gir/r4alTxDK2Ut5AMQQFlzUiZQkJWsSymUZ7Fcb5?=
 =?us-ascii?Q?a+/o2pnYPIbbktD/zUeiU3v0vt5+46eOE4oChRr8dUMMlfW3lb9eIwMrheIB?=
 =?us-ascii?Q?z4chXUzLyGkcYVm3ENqE3jf33GWgfxv8WVVfnSTlyZ7LEUcvamcn4Rdx/del?=
 =?us-ascii?Q?AgqwpFdtZNaJJcX9EYY4UsBeO1Xpza4ZfRNocPbAF+3z0T0d3lpO9adbuHJ4?=
 =?us-ascii?Q?fwPhLNXWhhiBMQO/jONxQA429rH2ReLzTk7VrtxD+6CnYYtV2q6PTNxchAZ5?=
 =?us-ascii?Q?xD3Jg754D5/Ub8Qj3wHeXR57ImPmY7QBePwxaohUgtydsPF+8zODpUjVoeVn?=
 =?us-ascii?Q?MTdgkT3ZY+DX4dV9V0Dv1AGrXuh2e2hbXk6tBnnHsFLW4O/0rAogJzM1ygm1?=
 =?us-ascii?Q?L/3maENWieU6NnQ4258VEk/FjlZoUJhesOjTZyFN9bfUONCCIevvHah5HU96?=
 =?us-ascii?Q?70kDwtj2WCFZ8Nqv2k8LAkK+eINzbSqmY9RqOPcnFZuCk9n7KgrmbpXHP2j0?=
 =?us-ascii?Q?ihbbEqOaFzxQHhPBZeybclyqKzQxiUz8VMzbKWiXclw5ekhxIm6pnGLbRpL+?=
 =?us-ascii?Q?OCK9way4uKitr5r7ADEEObWeQzVzabsLG1WIBckks2zN11TZu7ArWEx2iRAd?=
 =?us-ascii?Q?kq4A6smJaIDmbDN4IzA2Zv/Dkr1vjwwC7EKiGYK50rjnyLCio1Bvo24LOPj0?=
 =?us-ascii?Q?MCyNSjHc7G+VQn0m4LZD7hFa2Oz+V1issym1Q6aE21A4hULSm/khy7aHsc8Y?=
 =?us-ascii?Q?Rz2Oqs94j+MjJnOge8VbSWgSDFAR3nsuJ9VRjwbvadZIeZM0a6iW2qH/2bEG?=
 =?us-ascii?Q?FqfNbrKa2iLn8udxDiEpslQ102umX3uKi/K6qjlDDTZ2do1CSuvQm01WkpkP?=
 =?us-ascii?Q?bE0a0apNnZ2vm23c6HD6CFDKJoMCTk0LxeKEdWO49OGlBTutHf2SWXd3CFCW?=
 =?us-ascii?Q?2lSCDK8upuHSIx0COwCnHq7imgynUQscucuXiTglPYibkvKgfY2AVETSNFdz?=
 =?us-ascii?Q?S6jcSJu8XXrZrpkqHCc4tZkcHHIgV1rhKEaAWkvd037TWK8EJRt9hsokkNvy?=
 =?us-ascii?Q?NH22CiHP7+iXsBU4+NHu67pEs3GD5TT/wIUoNo0CDqOtWEGmN5pJtWvW30F2?=
 =?us-ascii?Q?iuD0R5cri2To/HCExyq07HOXwlKg/YEWa5Lh+9m1kPLDDYqBDJ5nAnZbEBLP?=
 =?us-ascii?Q?m8N7SQbVGXwGsgxvTNQZygCClfvHpXy3HmX2fTuBmKVyeAxaYj8XN2HopdQy?=
 =?us-ascii?Q?P6Tarrvj6iYeXA4zC2qWxn1rn0614V5CjOAr8F6YFCwYAssbHOmZZHSCwBYi?=
 =?us-ascii?Q?ULFzvN3hJi78ndNX8fbCXhtDpJ4kIf8S1yfGCy/fZZwg8AcfAClz67gZ0SPj?=
 =?us-ascii?Q?dvjFMGQ7g7X3JWLg8hApRw5t1JsviIWk32Ac?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DrzSUekXi4s0Ehb43ro0SEKS4agqfMXJj96gRw6S5v+z8qorNXyVGZfKf2a3?=
 =?us-ascii?Q?rPZI8oE+8Bx74ptG1oyQDm5RXPepAQGJG/LZ1IGiUeM+XCQgGBRhICW72rdr?=
 =?us-ascii?Q?azkqw6Sm2lF5zJfukA0G0ouPQTf/wQbN/AKYdHl6viwzsZ9Gyh+mRpU/11LH?=
 =?us-ascii?Q?w4HZRLcJ+u9TIPEWd1z20f75k89LuFSGF0kUMhtqpjIWP2uLpYjtYE7ZbyzJ?=
 =?us-ascii?Q?bd5Q8kvGpY74yP/GkZJaAo2GK5gvv0Uzlv1V4mY/IiHOHf6p24YzI0iZutB1?=
 =?us-ascii?Q?1Pq97iXmsz/WnB52rkp11tVcv3Qa+/KmqNf4LtUkQdOYlf36Temg5tUYHnbF?=
 =?us-ascii?Q?e/PwGPug+Cgo9/1wWglfIcLhirX8EgU7IDiO78KhbuRYGBvvxUgsa9h1ntzt?=
 =?us-ascii?Q?bQdtvKdf3xUmEem0aot9rKwQsgFb2iwfjQ2i+GY0duyUK4noZPB5Wpi0crjJ?=
 =?us-ascii?Q?Uv5/v7vvMyu+cTUQ+1lztslZwXDoYT3F60QPMBl3ilX/bavjCDhQ10vDR2bV?=
 =?us-ascii?Q?zerD1ox/JdcOWs4HXUnBTQ/qY4TBpPPOp08zeBoSN+VlQTrvK5rlCmb2grMi?=
 =?us-ascii?Q?NrWARJq6VXvnnoOrXFmlK7AI8kZJdc2yQZZYuh5OVBE9oHhyRXA7PF2F4koI?=
 =?us-ascii?Q?35xlTngWnb1/3pRBgK1JmIPvoydNLWp1mdaXL0iQi9TPv9ST4RHC+knCZviy?=
 =?us-ascii?Q?ZHpMzygkD8/1oVDXvRWOezSgMdGwRlcMNPEvaXEw1+s/652m1BueFVi47kRf?=
 =?us-ascii?Q?XTTKZ4Aq9mV5f2UxEHCmm2SWRlE3tSB2SkaoBtI91MLne6HfcLCrm+wfZwVJ?=
 =?us-ascii?Q?pfHIzNApq3B0YajRRhwPLAy68MjWiGWhjOJ7bnR/8V2eOLSzQyMGbV0z6nQf?=
 =?us-ascii?Q?neuOHBF8+Ed9Orpxc1Ypr7TOi0E1saOF5SXh0ZcmDHE5R7sF77lEUN6XE+GQ?=
 =?us-ascii?Q?vo/c2tZWgtX5LiQMgIa4qTdOmjY2zgpqbk104mpPi03iW6y5xg7AGu2rRiXg?=
 =?us-ascii?Q?UI8ZKgN3Y9LTYpYsZTSJ0nA4Wi140jF9Roz5yRTpk38V7zH/DW8fHaogL2pw?=
 =?us-ascii?Q?6Km2hsYTuCKPlBYDYrr30Pv7MHOXsGRD6UmnVRwSnqTGqX6HQX4GWTv1wXDD?=
 =?us-ascii?Q?4d4E9Afe4mivcCZwYvucaAHF1blDatUUrBfTmxoqWmfYmSS8R+cwBIapP+JI?=
 =?us-ascii?Q?fnP7HDf+Gi4ohBqgHbRHIN1XIb1Mie0J8MGbUnwQ4u+SIn9WjSfxqUpkGlvz?=
 =?us-ascii?Q?PD3FqLCjKkQ33wCb8plrBYZqfcPgZOc4aN6XtyCxUUn6nyyqHmjo4eqfvKKX?=
 =?us-ascii?Q?nUs2wZNeZDdxisp2ykZjPaRis6UTaEWUHY66PStyHAl38EQlLp+RF7HRxh4m?=
 =?us-ascii?Q?P9i8g56b04xqbotRbJw9AE7Fp0cAJWVpokCrChXn6uvtGlKdYnhidUSyLflp?=
 =?us-ascii?Q?P+MFAtameeTdljrL0foYYj65PcMmzC45mClz18GoCUWLQvrPRXiglbiBVD63?=
 =?us-ascii?Q?F9nMHxWgr1GduLKYf2h8QcFMH1pEqCjxDnOGOk5Gnz9SliECMwZ4gSasl8LT?=
 =?us-ascii?Q?nxgaXCwPIBdgD5SKR2/xxsQbDVhb+pFTWg1pRf5Wt5kubmjCbNEIhpPyofKY?=
 =?us-ascii?Q?gA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e61ed5-248b-4bf9-1b50-08de2924566c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 17:35:17.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FtYi3cMTyYcQPI5MRvSq84VjiTSdbYxccOGcPKqBicD3ct5/5SmaQBmjShy98WsXVda8a39dR1kDXFOf+DX9eUWojoe/jE+qm1Tw/bj8js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Wentao Guan <guanwentao@uniontech.com>
> Sent: Monday, November 17, 2025 6:06 AM
> To: leon@kernel.org
> Cc: shiraz.saleem@intel.com; Nikolova, Tatyana E
> <tatyana.e.nikolova@intel.com>; linux-rdma@vger.kernel.org; linux-
> kernel@vger.kernel.org; zhanjun@uniontech.com;
> niecheng1@uniontech.com; Wentao Guan <guanwentao@uniontech.com>;
> stable@vger.kernel.org
> Subject: [PATCH] RDMA/irdma: fix Kconfig dependency
>=20
> Any combination of (IDPF || ICE || I40E) can register auxiliary_dev, so u=
se '||'
> instead of '&&' in IRDMA config.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 060842fed53f ("RDMA/irdma: Update Kconfig")
> Fixes: fa0cf568fd76 ("RDMA/irdma: Add irdma Kconfig/Makefile and remove
> i40iw")
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
>=20
> ---
> PS: found in stable v6.12.58, it makes IRDMA be removed when select
> ICE+I40E+(!IDPF).


Hi Wentao,=20

Thank you for finding this. The Kconfig dependency change 060842fed53f ("RD=
MA/irdma: Update Kconfig") went in linux kernel 6.18 where RDMA IDPF suppor=
t was merged.=20

Even though IDPF driver exists in older kernels, it doesn't provide RDMA su=
pport so there is no need for IRDMA to depend on IDPF in kernels <=3D 6.17.

060842fed53f ("RDMA/irdma: Update Kconfig") patch shouldn't have been backp=
orted in kernels <=3D 6.17 and it should be reverted.

Then the line "depends on ICE && I40E" should resolve the issue you are see=
ing.

diff --git a/drivers/infiniband/hw/irdma/Kconfig b/drivers/infiniband/hw/ir=
dma/Kconfig
index 5f49a58590ed7..0bd7e3fca1fbb 100644
--- a/drivers/infiniband/hw/irdma/Kconfig
+++ b/drivers/infiniband/hw/irdma/Kconfig
@@ -4,10 +4,11 @@ config INFINIBAND_IRDMA
 	depends on INET
 	depends on IPV6 || !IPV6
 	depends on PCI
-	depends on ICE && I40E
+	depends on IDPF && ICE && I40E
 	select GENERIC_ALLOCATOR
 	select AUXILIARY_BUS
 	select CRC32
 	help
-	  This is an Intel(R) Ethernet Protocol Driver for RDMA driver
-	  that support E810 (iWARP/RoCE) and X722 (iWARP) network devices.
+	  This is an Intel(R) Ethernet Protocol Driver for RDMA that
+	  supports IPU E2000 (RoCEv2), E810 (iWARP/RoCEv2) and X722 (iWARP)
+	  network devices.


Thank you,
Tatyana











> ---
> ---
>  drivers/infiniband/hw/irdma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/Kconfig
> b/drivers/infiniband/hw/irdma/Kconfig
> index 0bd7e3fca1fbb..83a55b23c1325 100644
> --- a/drivers/infiniband/hw/irdma/Kconfig
> +++ b/drivers/infiniband/hw/irdma/Kconfig
> @@ -4,7 +4,7 @@ config INFINIBAND_IRDMA
>  	depends on INET
>  	depends on IPV6 || !IPV6
>  	depends on PCI
> -	depends on IDPF && ICE && I40E
> +	depends on IDPF || ICE || I40E
>  	select GENERIC_ALLOCATOR
>  	select AUXILIARY_BUS
>  	select CRC32
>=20
> base-commit: 9b9e43704d2b05514aeeaea36311addba2c72408
> --
> 2.20.1


