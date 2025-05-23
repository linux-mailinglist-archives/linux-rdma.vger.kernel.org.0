Return-Path: <linux-rdma+bounces-10624-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8BAC2683
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 17:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3750542FF4
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8298221288;
	Fri, 23 May 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMhNUVy7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D01C84D9;
	Fri, 23 May 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014328; cv=fail; b=hQFohbGNQA9fgN/NOCQ/xWxayspV1a1PSrW4kckTq1i6emltWQCMQNdKv/K2ySOVI0a+zRhnUeC7YPSWj3kB9bHjX2Z0fnAHvEmWYQzMDXPXoAmm14/wf291v50ESRgw3s0GTGjle51TTDfHBE/ITIHY+cPZxe67TOayjazxmqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014328; c=relaxed/simple;
	bh=J/NLPHB3FcqLrIM9ApwUqR0mYs0j945AvEw61o6Tlxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ErVdN78PlP5ROtikL3IfLdUPlbTcCHtvd1i5/Ab95PASH0MJCTiQFyaGKnh3mdG+wY4bm4FqaX8PArTWhMhup0bhJ4wVYaea5gKeYLcI2Uhfh9uobeCe9hrQnjs+OJwTm4B8TFuvYkF0NVm7FQNWNeKQOETJdVwSmMYuY4RXQKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMhNUVy7; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748014327; x=1779550327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J/NLPHB3FcqLrIM9ApwUqR0mYs0j945AvEw61o6Tlxg=;
  b=CMhNUVy7zI546UchJo0Q22JbJADmAcD6or+oSwanh8iB7vMg0c9yDGgS
   8eoUbGKk3PGz32Y+X1n4ZkMxCu53MyoD8uJBLDI8QvVJt4yPimVn151oe
   sc0LgQjQeiz3TowJCi4BJU6DvZK8swSbBJuT3zoM6QLFCrLF//NLIQlZk
   lIU62Gm0BZnQMiNsLb74ASsdwAHElraw/M4HlbvjA5XZSCjz2KoNQd8mz
   ezhioIPj0N03wlLOmnOW21aszpw44SEz89JD2XF5Z8YGrmLxZXCuAX2Hf
   QfJGwhja7qhVDsSIvDFns1BacVi+oMK9PPYGiuyCqu+UZYqe6IRZuzbkn
   w==;
X-CSE-ConnectionGUID: b09TMaspTka+uYxczifCig==
X-CSE-MsgGUID: LF5591kfRE6iJMF4F4V9YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="67635928"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="67635928"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 08:32:05 -0700
X-CSE-ConnectionGUID: fzNXMSTZToGS7MLkNUaftQ==
X-CSE-MsgGUID: edpaDn2tR9iWpsLBwZvtoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="146033509"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 08:32:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 08:32:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 08:32:03 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.53) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 08:32:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEvic+VuoMZ8XRSDzzUR1P2tBYfQzRLPgGyDiDeIkpYqWZcoWYBKcLzCi1gRqJBXOtSxQCmkLDwijtDDeA/JVIvvXaTrD0ssKXe5I8xe5Jpu0PZ4XoG+BZ6uoOu2Ct4Qa9Zf/rdtmPZV9cVXUL6KgwBFh0U9PuAuy8SuXDLCuomgUTxUVJq5nZ2e2wq6hTUl0Giv+4DbaSBhNiv39s6WtE8U9CMOcRpMqtEaNOnkBBiU7U1zaSumLobRbcp3bsP5y7dzJbms07qTTFCKQo8FL3PekZZxXpo0mC6yCnOAaoNZQDYBZSp047VNeo0o2preqV8WuH/lWcnBfBI64BnN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TK8fPbV3hvJ3i+/IuF7WEsq50+bHZPVk9j88EqK7iE=;
 b=J910BODzBDtmvHgGLugS4YDrluaLwWCphplx+6lOFu4t5U+6k+WOMKutf+PavivR8vlFcyXbhjTR5KEmBcsI21HVU26ElfEE+ppWdbkLPtVA19QNA2zCnTOKWBi3O82Kyo8JvbJivtAXuLY5npiXsHlSy8s2K4im7zu8ONDKmpGTuoS+0zxB+O87oO+Xc9g1gpA+qr34LINqfFCp3/vN5usAEuGpD25m/Nyf+JSgsLcmfMsFX1Bs8w7GmCNEE98BMNUVcq5RWcm4+CGWBsWMol9GCrw+6MBspDEpknPNPUA2OMhqopnukUnYFJxUWnq5L9xGVtFmf+jpzlycxxmruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8446.namprd11.prod.outlook.com (2603:10b6:806:3a7::5)
 by DS4PPF6F32BC4DA.namprd11.prod.outlook.com (2603:10b6:f:fc02::2e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 23 May
 2025 15:32:01 +0000
Received: from SA1PR11MB8446.namprd11.prod.outlook.com
 ([fe80::789f:41c7:7151:23fb]) by SA1PR11MB8446.namprd11.prod.outlook.com
 ([fe80::789f:41c7:7151:23fb%6]) with mapi id 15.20.8746.032; Fri, 23 May 2025
 15:32:01 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Olech, Milena"
	<milena.olech@intel.com>
Subject: RE: [PATCH net-next v3 2/3] dpll: add reference sync get/set
Thread-Topic: [PATCH net-next v3 2/3] dpll: add reference sync get/set
Thread-Index: AQHbyzeawkxWVnkpPk+8yYL38f0PYLPgIcmAgAA1x2A=
Date: Fri, 23 May 2025 15:32:01 +0000
Message-ID: <SA1PR11MB84461A12A44760B9F713BAAF9B98A@SA1PR11MB8446.namprd11.prod.outlook.com>
References: <20250522162938.1490791-1-arkadiusz.kubalewski@intel.com>
 <20250522162938.1490791-3-arkadiusz.kubalewski@intel.com>
 <yklt5svyyahn56bynp7b2ba4ceonyo2ivddtr3fr2ye5ubyjjj@jpnmxnsweyf5>
In-Reply-To: <yklt5svyyahn56bynp7b2ba4ceonyo2ivddtr3fr2ye5ubyjjj@jpnmxnsweyf5>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8446:EE_|DS4PPF6F32BC4DA:EE_
x-ms-office365-filtering-correlation-id: f660b439-b6ed-4477-73b8-08dd9a0ef6a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mxs8CkEFFHqnUyWts6GJ+r9OwaJzTpXdQnUAx5YSO3N0esRCYkUWaAFriFc3?=
 =?us-ascii?Q?EQJEl4RNR6j1mjCJwfJwuLY5PTAlG/8x/bydfSaIRpuLYKvo6ciR3m9ybeET?=
 =?us-ascii?Q?xhuZc8nR2AArMWXXCuRHhUAqcwnnBFsWqniEWOKjrgfpg63n7qTKNmRAQbPs?=
 =?us-ascii?Q?9bkmUGBcZ+Iw5aD7pYH0O4/Zyx/M0ckfjURVKz+28vmqlILgwPtAf+cWKoVd?=
 =?us-ascii?Q?No4FT6en8u4sW93d0sCdSMBqMcFhcL+aeMoe1ApwwA2oh0BBttV46p8adZeq?=
 =?us-ascii?Q?SIuFI3yEtNI5CEKghW6wRPXWFcQX8k1xEs2SjwmVX1gOR2jImQrGWz37gUyo?=
 =?us-ascii?Q?tTXYilDRoONXG440YUe7bpLeWkBEEVaNoBoA7FvxO6Z9JeN2Nt5QrNsZF8ZJ?=
 =?us-ascii?Q?sZu/RPVn04vbNrHjY0qFClWyk9LU9jJMauaR1tNQz58fw2KZLik18iBLNZjy?=
 =?us-ascii?Q?vPwHWZpkx7ylgSLbck6/k2KcS8GppwxzX/XJYy0wlQSNf275jvW+Tlc9M6Vw?=
 =?us-ascii?Q?YK+FCwB0McRUDCfyFHPAaaw3Oyy8ZlcWcJueOLREIjtfgTv2vYN6XhnPIw/c?=
 =?us-ascii?Q?GWk1iQnGbgYhSgMg6yu4YtmgbhEsXtgXohi1p/DqQsfFaPowaIkKKE7VzN6x?=
 =?us-ascii?Q?nbcX0xjNY+oD4VBMwnWn8WGa1AKt4Zi7WsIObtjxSSIXFVkBFebM73pfF+OZ?=
 =?us-ascii?Q?Q0M/dkiDy77LtZZxpdqcglhColTtAUvRYo+zU2MOwNfvSrffvjEpJ/gB8WiB?=
 =?us-ascii?Q?ol+hsA/ZMbJrcVTcgn1Nh1hPzWcA8m3PSSUrYCIk8g0+GqH+6+R9yUeFckpo?=
 =?us-ascii?Q?M9XFrMxe9HjYWJ8v5MrOqQxPixHGQhp7RLYJMyOCR5SfmAWBceCjdKEw+ald?=
 =?us-ascii?Q?ZFCbXMroGNAJ9/P1pNd2uH9MKiYDk7uj2dE2PaOys460i/j+FumG1Et7dTXC?=
 =?us-ascii?Q?B66aUIucnRk2P9ABn5IdmxSUVqDahR0xD2EooPndEqFV7GpWfcFU7ecRln5P?=
 =?us-ascii?Q?W2YBkT62JcK3gCLiXVsOZDbB6IJccUhk0F/7M3Z/tOhGVYHPEi3dxgErAiX+?=
 =?us-ascii?Q?Ne3qT53SNlAXbpbcYA3B26Gx2g6J705Bli/iZtE5RQbgbt1kNWcNt13OutLp?=
 =?us-ascii?Q?IFmgkbqOW3gtS0D4LpJZHYpRLPlp+zczm46hVMaEf6sNdul8vLp1zxQHzlXH?=
 =?us-ascii?Q?r2krOf9Kdb+GlgiU2sFukFraEf6e1vpCrWw3LVjtmxUJZuDwGMrgK6Q8aa/E?=
 =?us-ascii?Q?G3P7uO/VrMLb8NCTpqj2YSdY2V847tSMLiqccpIw/AjOIrlc/xYT65lbQAYq?=
 =?us-ascii?Q?JCMAdHCGgw3M2ECmkRGyFKMJl9dUcRJy6E/jQhlJ5BegzcCX2SabEz05qwFl?=
 =?us-ascii?Q?UrmZNkYib2YIvcrjSa/wJA9euXgVnro+zwNjP/DLfRoe3ASgRTlUXq0wGXiv?=
 =?us-ascii?Q?HzHuJvQ4RfwwnFKEMg+Ym743EK1jog4oZnX7ojM9gajTdhRg8Wqp2g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8446.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ngCr8nhnwWwZg9M0IKR+pMGdXLKeRmxHDCcG0T5SzUFIrBUBk5twj1ShItj1?=
 =?us-ascii?Q?BSdmSvmZKaMjmcIWaZBed6cHrYhv/Z9sdNjazRBVENi7sl8HSoFcXzHEKAIp?=
 =?us-ascii?Q?JroyqGS3U8qPR4XGmuS5MSxiPRgdTa6eNHLNhVOkfUH5CkyCnE6hZZG1Ik1B?=
 =?us-ascii?Q?h1FKG+n4DLpYT7c9OU5o772YVdV6Tx4qIL2mYXy4B2+aYttB39sflGTuZVbv?=
 =?us-ascii?Q?tigoGlcghcObtOrSv8J9dAeW2wKHIU0eOruJ29JSwL4G4cBwjvyK7kB00q99?=
 =?us-ascii?Q?W9n7rDi491AdrXk8rnIR0Ks4OU7SVEMjKL8E8geSfulBY7MaqC/NmNpoX7eK?=
 =?us-ascii?Q?lvUBQls/d2ao3l9Yhj8JDfNhRMT3apcA3N/Vg5GinnkSImQutfbBpoykuESJ?=
 =?us-ascii?Q?uGyLFXLhC0ZZuFBjzicVB3dEn2w6cY8ZfnyQUMvV2Dq/+sdF4HcNHdrv0NTs?=
 =?us-ascii?Q?D9LO2F/TGZa/tDhIS1dWlU2PKgiwr4TuJ629Ct/vaWl5+KPeYQJTeBOMw0Pj?=
 =?us-ascii?Q?+QmEhyUPGmdg9J5C9VuS2r7Yob8815aMnUs3KCKIf1A4W77B/nG/tx4TBlqS?=
 =?us-ascii?Q?7UkenRaSFla5gakA13hPDUsQNDVkO+3QpMsnOkDr2Ci6ShKudCcZWx9gOQ6p?=
 =?us-ascii?Q?Y593dLM1Eg0dntUhfenIH2nqwHLx6YLom4QQ6yj1eA5xYywOLsCkWjVQrjRQ?=
 =?us-ascii?Q?f/WrI6zSGxrifvVFWRNMMdC01Z8jCWI4H05aarqqYChZFOkxF0EEuRyWt1ys?=
 =?us-ascii?Q?OoQOI8hk0wE7P9Urwcs3y/frTWPLE/tbWs1XMLC6NxdovQoOuvI0bFl45Ozl?=
 =?us-ascii?Q?CT1kiQEF1E2b/i7/akcqg0xRos6DLT7etRfNuhYOy0cN7K8XiP1D44Hv2MBF?=
 =?us-ascii?Q?hYYZxnq5L+66Wsp3q6bnRZT+JcDMebzc6X4cQhxPK3hKvrXheP5Ih5HbRNw+?=
 =?us-ascii?Q?M73s8S189BGCd86Qnt1ABvMjejlDVqicjeJOLIISyOgdjofV8ubT1Xd9cA9N?=
 =?us-ascii?Q?LIDRTO8WUH3TgQKJ/bZkb5C3KGbWC0rnwTWfS2cHScg98YkIZmOimwlO9FI5?=
 =?us-ascii?Q?hCEI0+8dwrVHJ+vR+a0j6sHwDqyQ3SWhWPkIq95x8Xw+/Q8vxLMicilUqRNn?=
 =?us-ascii?Q?qg+nkzctDpzWGfBzAeCwXt4Zt9zgiCzG4mEpgIo/8Cu6ibAX1TgXFR/PbUAE?=
 =?us-ascii?Q?FIMCzFt6oxYJEE0ltAm437bOwrDjy5j2lgUhkzAXQe9fDcDX7EBtbMpRw8tE?=
 =?us-ascii?Q?3Ifhj7bYITazlUsMSPaujQU0ggl/m+YsSsDPwvf0YMfxeV+uyR7twO3nLPTK?=
 =?us-ascii?Q?/r5Xuki2Fan5LS4PMQOmH96i6NxRGWoIoQXtq7DY23PB56gGKxB4/Mp18nYG?=
 =?us-ascii?Q?Wsybn/iz6+91XOkN9BW8u4VUf2eR8dxXCyNZCHDjh6jWHK5YcAcFgh+PL8Dc?=
 =?us-ascii?Q?6U6UTp12e/vmAEhRqpax9YVsyHCsA1yNPWlgmuTM5DYYkM15kELRL8ddmt/4?=
 =?us-ascii?Q?xjv0jlijKee/prEbvHpGdSeYYLHFwVw3NB1iQ8I6g/7HQhvLfAm1uTUrb29R?=
 =?us-ascii?Q?WBluo0tdChxLKju4Uji6d6gx9xLOTiBH7yBYXuOmIkdbquaK4FaAKIfb7UHr?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8446.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f660b439-b6ed-4477-73b8-08dd9a0ef6a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 15:32:01.4324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6xDK/z5STVGRAWjdkqPEqNUIXkAOPVfxWYHIowfeVjZ8dxyZoCBuvQLrAflQ5qYvjq2dCuY+y/k5hgcar0EacI8UyMDXawi/zoADP90Yejc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6F32BC4DA
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, May 23, 2025 2:14 PM
>
>Thu, May 22, 2025 at 06:29:37PM +0200, arkadiusz.kubalewski@intel.com
>wrote:
>>Define function for reference sync pin registration and callback ops to
>>set/get current feature state.
>>
>>Implement netlink handler to fill netlink messages with reference sync
>>pin configuration of capable pins (pin-get).
>>
>>Implement netlink handler to call proper ops and configure reference
>>sync pin state (pin-set).
>>
>>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>Reviewed-by: Milena Olech <milena.olech@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>> v3:
>>- fix kdoc missing ':' after argument name ref_sync_pins,
>>- propagate ret in dpll_pin_ref_sync_state_set().
>>---
>> drivers/dpll/dpll_core.c    |  27 ++++++
>> drivers/dpll/dpll_core.h    |   2 +
>> drivers/dpll/dpll_netlink.c | 188 ++++++++++++++++++++++++++++++++----
>> include/linux/dpll.h        |  10 ++
>> 4 files changed, 209 insertions(+), 18 deletions(-)
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>index 20bdc52f63a5..805c7aca58c5 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -506,6 +506,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>module *module,
>> 	refcount_set(&pin->refcount, 1);
>> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>>+	xa_init_flags(&pin->ref_sync_pins, XA_FLAGS_ALLOC);
>> 	ret =3D xa_alloc_cyclic(&dpll_pin_xa, &pin->id, pin, xa_limit_32b,
>> 			      &dpll_pin_xa_id, GFP_KERNEL);
>> 	if (ret < 0)
>>@@ -514,6 +515,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>module *module,
>> err_xa_alloc:
>> 	xa_destroy(&pin->dpll_refs);
>> 	xa_destroy(&pin->parent_refs);
>>+	xa_destroy(&pin->ref_sync_pins);
>> 	dpll_pin_prop_free(&pin->prop);
>> err_pin_prop:
>> 	kfree(pin);
>>@@ -595,6 +597,7 @@ void dpll_pin_put(struct dpll_pin *pin)
>> 		xa_erase(&dpll_pin_xa, pin->id);
>> 		xa_destroy(&pin->dpll_refs);
>> 		xa_destroy(&pin->parent_refs);
>>+		xa_destroy(&pin->ref_sync_pins);
>> 		dpll_pin_prop_free(&pin->prop);
>> 		kfree_rcu(pin, rcu);
>> 	}
>>@@ -783,6 +786,30 @@ void dpll_pin_on_pin_unregister(struct dpll_pin
>>*parent, struct dpll_pin *pin,
>> }
>> EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
>>
>>+/**
>>+ * dpll_pin_ref_sync_pair_add - create a reference sync signal pin pair
>>+ * @base: pin which produces the base frequency
>>+ * @sync: pin which produces the sync signal
>>+ *
>>+ * Once pins are paired, the user-space configuration of reference sync
>>pair
>>+ * is possible.
>>+ * Context: Acquires a lock (dpll_lock)
>>+ * Return:
>>+ * * 0 on success
>>+ * * negative - error value
>>+ */
>>+int dpll_pin_ref_sync_pair_add(struct dpll_pin *base, struct dpll_pin
>>*sync)
>
>Perhaps call it "pin" and "ref_sync_pin"?
>

Sure, makes sense, will fix.

>
>>+{
>>+	int ret;
>>+
>>+	mutex_lock(&dpll_lock);
>>+	ret =3D xa_insert(&base->ref_sync_pins, sync->pin_idx, sync,
>>GFP_KERNEL);
>>+	mutex_unlock(&dpll_lock);
>>+
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_GPL(dpll_pin_ref_sync_pair_add);
>
>How do you handle remove?
>

I did not, this is hidden issue when you unregister sequentially.
Will fix that in next version.

>
>>+
>> static struct dpll_device_registration *
>> dpll_device_registration_first(struct dpll_device *dpll)
>> {
>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>>index 2b6d8ef1cdf3..93c68e78b351 100644
>>--- a/drivers/dpll/dpll_core.h
>>+++ b/drivers/dpll/dpll_core.h
>>@@ -44,6 +44,7 @@ struct dpll_device {
>>  * @module:		module of creator
>>  * @dpll_refs:		hold referencees to dplls pin was registered with
>>  * @parent_refs:	hold references to parent pins pin was registered
>>with
>>+ * @ref_sync_pins:	hold references to pins for Reference SYNC feature
>>  * @prop:		pin properties copied from the registerer
>>  * @rclk_dev_name:	holds name of device when pin can recover clock
>>from it
>>  * @refcount:		refcount
>>@@ -56,6 +57,7 @@ struct dpll_pin {
>> 	struct module *module;
>> 	struct xarray dpll_refs;
>> 	struct xarray parent_refs;
>>+	struct xarray ref_sync_pins;
>> 	struct dpll_pin_properties prop;
>> 	refcount_t refcount;
>> 	struct rcu_head rcu;
>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>index c130f87147fa..854bd46a7d27 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -48,6 +48,24 @@ dpll_msg_add_dev_parent_handle(struct sk_buff *msg, u3=
2
>>id)
>> 	return 0;
>> }
>>
>>+static bool dpll_pin_available(struct dpll_pin *pin)
>>+{
>>+	struct dpll_pin_ref *par_ref;
>>+	unsigned long i;
>>+
>>+	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>>+		return false;
>>+	xa_for_each(&pin->parent_refs, i, par_ref)
>>+		if (xa_get_mark(&dpll_pin_xa, par_ref->pin->id,
>>+				DPLL_REGISTERED))
>>+			return true;
>>+	xa_for_each(&pin->dpll_refs, i, par_ref)
>>+		if (xa_get_mark(&dpll_device_xa, par_ref->dpll->id,
>>+				DPLL_REGISTERED))
>>+			return true;
>>+	return false;
>>+}
>>+
>> /**
>>  * dpll_msg_add_pin_handle - attach pin handle attribute to a given
>>message
>>  * @msg: pointer to sk_buff message to attach a pin handle
>>@@ -408,6 +426,47 @@ dpll_msg_add_pin_esync(struct sk_buff *msg, struct
>>dpll_pin *pin,
>> 	return -EMSGSIZE;
>> }
>>
>>+static int
>>+dpll_msg_add_pin_ref_sync(struct sk_buff *msg, struct dpll_pin *pin,
>>+			  struct dpll_pin_ref *ref,
>>+			  struct netlink_ext_ack *extack)
>>+{
>>+	const struct dpll_pin_ops *ops =3D dpll_pin_ops(ref);
>>+	struct dpll_device *dpll =3D ref->dpll;
>>+	enum dpll_pin_state state;
>>+	void *pin_priv, *sp_priv;
>>+	struct dpll_pin *sp;
>
>Make sure you are consistent in variables naming. You call this "sync"
>whan you add it.
>

Sure, will do.

>
>>+	struct nlattr *nest;
>>+	unsigned long index;
>>+	int ret;
>>+
>>+	pin_priv =3D dpll_pin_on_dpll_priv(dpll, pin);
>>+	xa_for_each(&pin->ref_sync_pins, index, sp) {
>>+		if (!dpll_pin_available(sp))
>>+			continue;
>>+		sp_priv =3D dpll_pin_on_dpll_priv(dpll, sp);
>>+		if (WARN_ON(!ops->ref_sync_get))
>>+			return -EOPNOTSUPP;
>>+		ret =3D ops->ref_sync_get(pin, pin_priv, sp, sp_priv,
>>+					&state, extack);
>>+		if (ret)
>>+			return ret;
>>+		nest =3D nla_nest_start(msg, DPLL_A_PIN_REFERENCE_SYNC);
>>+		if (!nest)
>>+			return -EMSGSIZE;
>>+		if (nla_put_s32(msg, DPLL_A_PIN_ID, sp->id))
>>+			goto nest_cancel;
>>+		if (nla_put_s32(msg, DPLL_A_PIN_STATE, state))
>>+			goto nest_cancel;
>>+		nla_nest_end(msg, nest);
>>+	}
>>+	return 0;
>>+
>>+nest_cancel:
>>+	nla_nest_cancel(msg, nest);
>>+	return -EMSGSIZE;
>>+}
>>+
>> static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
>> {
>> 	int fs;
>>@@ -550,6 +609,10 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct
>>dpll_pin *pin,
>> 	if (ret)
>> 		return ret;
>> 	ret =3D dpll_msg_add_pin_esync(msg, pin, ref, extack);
>>+	if (ret)
>>+		return ret;
>>+	if (!xa_empty(&pin->ref_sync_pins))
>>+		ret =3D dpll_msg_add_pin_ref_sync(msg, pin, ref, extack);
>> 	if (ret)
>> 		return ret;
>> 	if (xa_empty(&pin->parent_refs))
>>@@ -642,24 +705,6 @@ __dpll_device_change_ntf(struct dpll_device *dpll)
>> 	return dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
>> }
>>
>>-static bool dpll_pin_available(struct dpll_pin *pin)
>>-{
>>-	struct dpll_pin_ref *par_ref;
>>-	unsigned long i;
>>-
>>-	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>>-		return false;
>>-	xa_for_each(&pin->parent_refs, i, par_ref)
>>-		if (xa_get_mark(&dpll_pin_xa, par_ref->pin->id,
>>-				DPLL_REGISTERED))
>>-			return true;
>>-	xa_for_each(&pin->dpll_refs, i, par_ref)
>>-		if (xa_get_mark(&dpll_device_xa, par_ref->dpll->id,
>>-				DPLL_REGISTERED))
>>-			return true;
>>-	return false;
>>-}
>>-
>> /**
>>  * dpll_device_change_ntf - notify that the dpll device has been changed
>>  * @dpll: registered dpll pointer
>>@@ -887,6 +932,108 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct
>>nlattr *a,
>> 	return ret;
>> }
>>
>>+static int
>>+dpll_pin_ref_sync_state_set(struct dpll_pin *pin, unsigned long
>>sync_pin_idx,
>>+			    const enum dpll_pin_state state,
>>+			    struct netlink_ext_ack *extack)
>>+
>>+{
>>+	struct dpll_pin_ref *ref, *failed;
>>+	const struct dpll_pin_ops *ops;
>>+	enum dpll_pin_state old_state;
>>+	struct dpll_pin *sync_pin;
>
>Again, please name this consistently...
>

Sure, will fix.

>
>>+	struct dpll_device *dpll;
>>+	unsigned long i;
>>+	int ret;
>>+
>>+	if (state !=3D DPLL_PIN_STATE_CONNECTED &&
>>+	    state !=3D DPLL_PIN_STATE_DISCONNECTED)
>
>Extack message? But, isn't this sanitized already by policy? Then,
>please remove.
>

True, will remove.

>
>>+		return -EINVAL;
>>+	sync_pin =3D xa_find(&pin->ref_sync_pins, &sync_pin_idx, ULONG_MAX,
>>+			   XA_PRESENT);
>>+	if (!sync_pin) {
>>+		NL_SET_ERR_MSG(extack, "reference sync pin not found");
>>+		return -EINVAL;
>>+	}
>>+	if (!dpll_pin_available(sync_pin)) {
>>+		NL_SET_ERR_MSG(extack, "reference sync pin not available");
>>+		return -EINVAL;
>>+	}
>>+	ref =3D dpll_xa_ref_dpll_first(&pin->dpll_refs);
>>+	ASSERT_NOT_NULL(ref);
>>+	ops =3D dpll_pin_ops(ref);
>>+	if (!ops->ref_sync_set || !ops->ref_sync_get) {
>>+		NL_SET_ERR_MSG(extack, "reference sync not supported by this
>>pin");
>>+		return -EOPNOTSUPP;
>>+	}
>>+	dpll =3D ref->dpll;
>>+	ret =3D ops->ref_sync_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
>>sync_pin,
>>+				dpll_pin_on_dpll_priv(dpll, sync_pin),
>>+				&old_state, extack);
>>+	if (ret) {
>>+		NL_SET_ERR_MSG(extack, "unable to get old reference sync
>>state");
>>+		return ret;
>>+	}
>>+	if (state =3D=3D old_state)
>>+		return 0;
>>+	xa_for_each(&pin->dpll_refs, i, ref) {
>>+		ops =3D dpll_pin_ops(ref);
>>+		dpll =3D ref->dpll;
>>+		ret =3D ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>>+					sync_pin,
>>+					dpll_pin_on_dpll_priv(dpll, sync_pin),
>>+					state, extack);
>>+		if (ret) {
>>+			failed =3D ref;
>>+			NL_SET_ERR_MSG_FMT(extack, "reference sync set failed for
>>dpll_id:%u",
>>+					   dpll->id);
>>+			goto rollback;
>>+		}
>>+	}
>>+	__dpll_pin_change_ntf(pin);
>>+
>>+	return 0;
>>+
>>+rollback:
>>+	xa_for_each(&pin->dpll_refs, i, ref) {
>>+		if (ref =3D=3D failed)
>>+			break;
>>+		ops =3D dpll_pin_ops(ref);
>>+		dpll =3D ref->dpll;
>>+		if (ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>>+				      sync_pin,
>>+				      dpll_pin_on_dpll_priv(dpll, sync_pin),
>>+				      old_state, extack))
>>+			NL_SET_ERR_MSG(extack, "set reference sync rollback
>>failed");
>>+	}
>>+	return ret;
>>+}
>>+
>>+static int
>>+dpll_pin_ref_sync_set(struct dpll_pin *pin, struct nlattr *nest,
>>+		      struct netlink_ext_ack *extack)
>>+{
>>+	struct nlattr *tb[DPLL_A_PIN_MAX + 1];
>>+	enum dpll_pin_state state;
>>+	u32 sync_pin_id;
>>+
>>+	nla_parse_nested(tb, DPLL_A_PIN_MAX, nest,
>>+			 dpll_reference_sync_nl_policy, extack);
>>+	if (!tb[DPLL_A_PIN_ID]) {
>>+		NL_SET_ERR_MSG(extack, "sync pin id expected");
>>+		return -EINVAL;
>>+	}
>>+	sync_pin_id =3D nla_get_u32(tb[DPLL_A_PIN_ID]);
>>+
>>+	if (!tb[DPLL_A_PIN_STATE]) {
>>+		NL_SET_ERR_MSG(extack, "sync pin state expected");
>>+		return -EINVAL;
>>+	}
>>+	state =3D nla_get_u32(tb[DPLL_A_PIN_STATE]);
>>+
>>+	return dpll_pin_ref_sync_state_set(pin, sync_pin_id, state, extack);
>>+}
>>+
>> static int
>> dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
>> 			  enum dpll_pin_state state,
>>@@ -1193,6 +1340,11 @@ dpll_pin_set_from_nlattr(struct dpll_pin *pin,
>>struct genl_info *info)
>> 			if (ret)
>> 				return ret;
>> 			break;
>>+		case DPLL_A_PIN_REFERENCE_SYNC:
>>+			ret =3D dpll_pin_ref_sync_set(pin, a, info->extack);
>>+			if (ret)
>>+				return ret;
>>+			break;
>> 		}
>> 	}
>>
>>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>>index 5e4f9ab1cf75..f1f1fdda67fe 100644
>>--- a/include/linux/dpll.h
>>+++ b/include/linux/dpll.h
>>@@ -95,6 +95,14 @@ struct dpll_pin_ops {
>> 			 const struct dpll_device *dpll, void *dpll_priv,
>> 			 struct dpll_pin_esync *esync,
>> 			 struct netlink_ext_ack *extack);
>>+	int (*ref_sync_set)(const struct dpll_pin *pin, void *pin_priv,
>>+			    const struct dpll_pin *ref_pin, void *ref_pin_priv,
>>+			    const enum dpll_pin_state state,
>>+			    struct netlink_ext_ack *extack);
>>+	int (*ref_sync_get)(const struct dpll_pin *pin, void *pin_priv,
>>+			    const struct dpll_pin *ref_pin, void *ref_pin_priv,
>
>"ref_pin". This is 4th name of the same variable. Weird...
>

Yes, going to fix them all.

Thank you!
Arkadiusz

>
>>+			    enum dpll_pin_state *state,
>>+			    struct netlink_ext_ack *extack);
>> };
>>
>> struct dpll_pin_frequency {
>>@@ -194,6 +202,8 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent,
>>struct dpll_pin *pin,
>> void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin
>>*pin,
>> 				const struct dpll_pin_ops *ops, void *priv);
>>
>>+int dpll_pin_ref_sync_pair_add(struct dpll_pin *base, struct dpll_pin
>>*sync);
>>+
>> int dpll_device_change_ntf(struct dpll_device *dpll);
>>
>> int dpll_pin_change_ntf(struct dpll_pin *pin);
>>--
>>2.38.1
>>

