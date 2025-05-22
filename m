Return-Path: <linux-rdma+bounces-10556-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A4AC1158
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 18:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D494A189B55A
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452B228C875;
	Thu, 22 May 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1jDldSY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3AF25486F;
	Thu, 22 May 2025 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932198; cv=fail; b=VcgDm3NcYgvtt05EzJqLPd7F23162t9AmY70P5xFbUMPORTguoVu94ylp+yyus1C8dQN8L+G0ATsJy6Dtmq098MU4jAP3H8VKHuDAfP47R+sPB1WvgTsx+xU56YRZ3H11bXhin3lcFb0TDNyQFBTGLRGkhmjIX5mOMBfxpKOD88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932198; c=relaxed/simple;
	bh=ugQhScny+rhaqHBmoPi4U8Lx3ujWBf/UQVyQ3zjTSP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eDbDHoUXldkfe/dsLQlmsbC4BwHv09C31iGkJCnQIhyUuIQJcJrEjrKZScSAXAnhSbbu/iZYl640kfZbxFzG8mcxGflEuMNOjzGcgMp/ZwSjjVMadtm34LMvGxmq4WKfmYSAE3a+0PALG9xbm61Pkg6brpWweAecw5y1qsOOR8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1jDldSY; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747932198; x=1779468198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ugQhScny+rhaqHBmoPi4U8Lx3ujWBf/UQVyQ3zjTSP0=;
  b=Y1jDldSYsQMcwW5ijNXt9aSH7stI3Jk/PqYyoBF77r6wgeps9V4GNDon
   6kLY5Lv5ZT4O9f9IUXa5/UILmyRp6CoorofKDWppP69juhOlf4AGKWe5n
   JhC39YTlQgllxjUfIf2qPQ+ADqh9dVnpu+36ebx3kbTO0RlIKeKqS5c1g
   84qaYRNyMBxySu+G3jS+zp+5hvqXY59OK0p4ZFmfoltCeO/E1jFsfQMNn
   ekPnrxE+ITtIQIOTTI1zPh50tTxedDYA6SdOgGoH0I65YpTnjsgCqxC81
   6PBVGXp1On9jXsIXxSwavsjgN6vELw0dWvCREn5m2TuvG3VrYeyYtM1xn
   Q==;
X-CSE-ConnectionGUID: xFp+36pCTgyjBQTe89zGTQ==
X-CSE-MsgGUID: 63yEuJNzTpe9wV40wMwxvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49889943"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="49889943"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 09:43:12 -0700
X-CSE-ConnectionGUID: L6a92VjuS/+ma6s4d3QovQ==
X-CSE-MsgGUID: AXfMzFk6SdGD4N6fPB6ong==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="145635229"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 09:43:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 09:43:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 09:43:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.57)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 09:43:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdyI6VIuOydbXAeBy6rkZkikRamc7Od0xexkfyRLspFsBhwLXn9CsMYCBozmDgfBXJ8RTIEzkImbIfKPDFr6d/M9QAe2mkzkccqoFsDnLW9aAWBCJQbg2ReuaVU8vDGSVS+nMSl4aQRnEO1kAloH9GLnVHthp6aOL1cEc1uPgF4BbSe2SZuxFanHBopIyjXoJ9dSsRGT/7WDuGKV4q3grgDxwLBTibMHrN4aEBBY8AujMKjuyPB4a/qEkWzp9/gkP8I+y8ZXPYY3aldNTaK+pawUSEfDIyhOHbF/2QRwJbwvnl0qmgokcwmOMMUdAInmCVqvUI5qQeVrNA12td4DFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnSZNTJWG6Q+LG88aaJINqdOgQINGbXOqm6bk9TWFHs=;
 b=kPG9aT1KVaFkgfzKlqOGJkUYnTFme7/pW2xTB5l5g9oQmKPm8R+P86rnqH2qkll8uiYbp6CrPcQLVB+NJGcLTL4fptJM6K4yoln9bpOhW8FZ1S71q+CFRx8yqcY19X/O8gHflWvCAMv5tmXGLw/lvCJdmen5nVcDKWE4qrgGY6kGfXjQitIp8J0x1Toifaslaewfwp71yEa5bb1452Oqe0du6FfVPcS+o8IvxQO7nY+f25lC4FDRq6j81sR2UAbV5bVau905R3E3cNSTNSBfaUMBh7JbAcdRvkvVg2k5YEotQjgrriwU0tzFX3w6GbM/Ayqff77jDdOUmSllFi79+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by PH0PR11MB7711.namprd11.prod.outlook.com (2603:10b6:510:291::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.36; Thu, 22 May
 2025 16:42:40 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%7]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 16:42:40 +0000
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
	<aleksandr.loktionov@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [PATCH net-next v2 2/3] dpll: add Reference SYNC get/set
Thread-Topic: [PATCH net-next v2 2/3] dpll: add Reference SYNC get/set
Thread-Index: AQHbwOFOGrGnya94jEWLCaOc2iE6HbPLS74AgBOh3JA=
Date: Thu, 22 May 2025 16:42:40 +0000
Message-ID: <SJ2PR11MB845204F3E5CDBBF5CB34FE969B99A@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250509124651.1227098-1-arkadiusz.kubalewski@intel.com>
 <20250509124651.1227098-3-arkadiusz.kubalewski@intel.com>
 <icbprtryf7dhdwymtuvntfcfvl43b4rbzxukg7romz32cx2vmn@dkgfespynxln>
In-Reply-To: <icbprtryf7dhdwymtuvntfcfvl43b4rbzxukg7romz32cx2vmn@dkgfespynxln>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|PH0PR11MB7711:EE_
x-ms-office365-filtering-correlation-id: c221b8f1-11ac-4fcc-86bf-08dd994faab1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?eOjCVzz8F9i9BFFmoFOLiqG5JXbFOpLpFy6Anfp3X618xLnQHP61zWQKs76V?=
 =?us-ascii?Q?u9Fid+XxunBIcN86jE03AvQrD5K2KSlqbTnD3/wcWdGB52sIkqYWDkv4Uu28?=
 =?us-ascii?Q?xt+vqns0vPce3V5k05DNmHRk+tFPSB1kW3Xh7BqIoa3XDi10X3IUF2CUdLC1?=
 =?us-ascii?Q?I5V+TfaTpW/qM9t6qLx/NSSWLoXWSRnKJtN7ddhnLFK41p9Lc7xdwI0AHJsS?=
 =?us-ascii?Q?Ee9HHIrLQCa8mU2pRdO0Bqn6qCft5EikgUn3D4ube0s+ZwFSOVQCRkVdbyPb?=
 =?us-ascii?Q?usJ2S53x8qJVZJIiX7Kq27pUnKleZhhpVK6VRNPVbMQ5qeL83uwLw92UF6s9?=
 =?us-ascii?Q?S7b08M/C23CbmbDkPpSBHLku7kxDqh72LkXmPgFsqkgcHm21Y6MStTf5aAWn?=
 =?us-ascii?Q?GH9ZDkxy8lamcpiau2bdnipUAihYv4lmP8t6+QXX688MQH9IEY7CbrutwQYH?=
 =?us-ascii?Q?qQq2T9oeF602L/K/U34ICAULp4arhEjAOzfpv0QHgeZnYatoIf3JD7mOPs98?=
 =?us-ascii?Q?AvfLotY2pGPToUIO5MseKE+dCkNzuaetnLVHs2CphK/V8D+VgzO1RsNsSoaK?=
 =?us-ascii?Q?JY2lXgZqDbYO9CzE073JxxWY+yuU+ghIXGhZv/wJgXyuuSRidsKFst4XCUGT?=
 =?us-ascii?Q?0AJRtcR7tCywGTErjia1Ax38VqCQs0pVvTaxq+rDVit/D/Sy7GIRjPyIubd+?=
 =?us-ascii?Q?H0kQuzJLmEnULsa7lyxzlYUEBrgiK5YlJasHS3S4/LZ8OFi5qP2Ju8RO53RK?=
 =?us-ascii?Q?rVZ+a8wHWAgWRtYoKVqHeIfz0HBNiw1m6K6lTQrVUvU3PsRehVsE2A1ttBXj?=
 =?us-ascii?Q?SG17JioElZ++BWDVp9h1Pj/4khGaY+32Hc/eT6Ker92hHbuskhAYddFIVEPo?=
 =?us-ascii?Q?BadTmeTMf0P/+CRfix+CPMpxGNo4Bwl3Ru1hDjzU1XR7KIxeNNFv0SG/3QvF?=
 =?us-ascii?Q?i44e5DPIuIRhW8dFzlazVtrvI3Mnb9L/9J0dKnhhtb9nYplduF1Ws/04pMyF?=
 =?us-ascii?Q?OHpEwPB1ssETQ4Te/dCg4Gv1eKqr9QW0iTlD1DwcV5/3Z2PolWIVXY6DuNaf?=
 =?us-ascii?Q?oBTjDNNg0z9lKjJJi4A0KkAYBOWq4daAqwz0Gmc9iNiC7Axy3dotgcQv7wJ3?=
 =?us-ascii?Q?t3EFdExhDwBgRp1HgfVgPB6rn1aYjuTW8vl55iBnVZ/9gK/xIQoaI3g3JYek?=
 =?us-ascii?Q?X14LXv1CvHrvvQLy3sl68YSWJj1or6EEL+6xOp/d3AobIruXomenfyb/ky6e?=
 =?us-ascii?Q?MNSLJGOIjudZyt1cWk15QWNReO2PNOKemLMJ0ud9GH3qQA+mGrjKmEsDdAuH?=
 =?us-ascii?Q?oIvEhjgtPIZBcc9OwWEgZJ9I+HysGFkCu7FZSzZVnQLf4BT/gmmWYoKdHZIP?=
 =?us-ascii?Q?6MZatpfuaMAnaNJnF3IvC6joc3o+DTXjA/fcVbNGxhT8HYx5UvWNS2br/VvG?=
 =?us-ascii?Q?2S4djYF2VmVWwnxhftZ20p5TdEzNdKt9VzSDklhdyxlpIG2uxjjb6A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HCayC2kNY6g2Afx7gR/8vsdxIQ8q+7MWAcsD8bn4evWysqeOh2ewBWaMfzfa?=
 =?us-ascii?Q?9Q7VY/ebNl8DRSprtsA84iD2OCGerja82O7NB4t8A6iBf3FGGu4jn+hn/xOg?=
 =?us-ascii?Q?LRMR9YyrNFSNUL5rH+EbD/8Jkgj5qNgx2grPXlYkYSDyQ6v2ShyXsWOeb4gv?=
 =?us-ascii?Q?90IUpNRwyHJLN79QZznIko42SzxeaE6TI3mdO4vkuOpOj1nK3JC+oUAKmKqN?=
 =?us-ascii?Q?vnsqzAiIpIEYq3NTCRZe81Hp1zZt9wzDqhWczbDTe8jE5Ddu0Q3pGV4Ykrcv?=
 =?us-ascii?Q?qq+AHcx5pOm9b3AjuZcLvYPHzxoRPcPdh18bPZPeCpDD7SIgT+5UP8e2cI4f?=
 =?us-ascii?Q?pJjVxbc5EmBWCv0xNkuHP4Rotct5fL2v05dy2lOY3XCHnOJzWcfPPG5MZ3dW?=
 =?us-ascii?Q?3VU7A8CyWlX80YR5uV2F9IWqmyez6WG9bQsu3tnDpIlbXGRr/Ub1lRcCV2g4?=
 =?us-ascii?Q?SMR/QASIxoYnTTdPPtEisg5zoettTMiHa/OVi5hI018XRw6xsKg/aicFYeNw?=
 =?us-ascii?Q?vzdWXVMEDu0k303xr/WBea0ZsZfqEKJ1SR2kPvGWXo8XryY9GNgxwszUHK49?=
 =?us-ascii?Q?1Ovi5kVmeubEw0E07mVwh3uMqSkwfoK4kLA5AA/NrxbuivwJQX7UG3rH4gtR?=
 =?us-ascii?Q?ug7vfSpgNz2d3C8LhRYN4TOuQEaDpSzLlUCPtdvdTs4UNgLjZaUrg/HfL2yF?=
 =?us-ascii?Q?Kmmc6QOCe5MgpwzqnZaVGSP7cun0/UpVa1xgoewgFtTvG5GBU/vqJOI6abqb?=
 =?us-ascii?Q?eRiSxseYrtERBnAnbVlwBOdTBQ1ZgsjtB8enrjkBe4rrxIe456gTZxYdyEYH?=
 =?us-ascii?Q?E4XA6wGcOOFDYGIIbCa+OIo2C7U8Ufk0pS5VeFdR2WJkQwGySQ8yXtLlX2pF?=
 =?us-ascii?Q?V6q4XigV3UimsaKVn4afDyBnBwAEkhQegfVdEXdV2LAv0c6yY4WcDVe4sP0Q?=
 =?us-ascii?Q?H+xWLky0lLS/IX6iBPD7K/9zWNejLCRN6Mv3K6i+o8HnVC+g7sFsVTyLB+wV?=
 =?us-ascii?Q?ErPMBiO35mnPWV8OM+LiXE/U55q7ZdMB7fALym15j/ULCxxWTT19sEI/JFnZ?=
 =?us-ascii?Q?XZq+rKQt0+ncpw3PFnmqnEprrOVaNrjqh3yhPTw/6E3pphPwYdLYaKqEoo+F?=
 =?us-ascii?Q?y+c6oM0EWrgklVMMZRaA41Wyw2CI2gojjLF2wSN0V99gHvztIIjKb4dDwdr6?=
 =?us-ascii?Q?wfebJftZI3Uuxn8v63g3vZQKC7UDu52w4WL2LKCGnWeYRGt4254xYC4kJxK9?=
 =?us-ascii?Q?zP2Ougjc3OdgideYbeCB2KTSjkyZRVw/R75rcPkgazYhUByOV373C1wJ/QHE?=
 =?us-ascii?Q?E3v+w9ar7GGbrF37NZdS/qx3NOKQmLhRGjQe6aNPkZqHOMB8l4tsVnrfrk8C?=
 =?us-ascii?Q?ru2zjSbFo35UjEOJ1DYNUfdpXr9VzcHifhaKf22XhSxdChTs9FylNyeSwrHZ?=
 =?us-ascii?Q?Xe0E0Clj4+uIZaVFL/raxDrdpbJ/TE+UBxF1LtkWA7DX8ougTa484XFDWDJB?=
 =?us-ascii?Q?h4FZ4Jayf6FsxOQhdleUvRLQVd3BIwkxlEqipu3C1hJk3CAahRdhrjJXmuq/?=
 =?us-ascii?Q?7yyQ0jhZUzkqviBeyUv3SH9OMolGLUqoiID6HY3poAwv0L8+aCaLlmadrIMR?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8452.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c221b8f1-11ac-4fcc-86bf-08dd994faab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 16:42:40.1158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1fI2A6BhRcuRdss/OE43Qx/HqMhASmE10AZyuN/cP1IGa2iUTDsrKmjounTrEttHSOVXgxWi7vJGhT3lvZXgnvtmbRtkFG2tlK+FxYLjRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7711
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Saturday, May 10, 2025 6:48 AM
>

[..]

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
>>+	struct dpll_device *dpll;
>>+	unsigned long i;
>>+	int ret;
>>+
>>+	if (state !=3D DPLL_PIN_STATE_CONNECTED &&
>>+	    state !=3D DPLL_PIN_STATE_DISCONNECTED)
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
>sync_pin,
>>+				dpll_pin_on_dpll_priv(dpll, sync_pin),
>>+				&old_state, extack);
>>+	if (ret) {
>>+		NL_SET_ERR_MSG(extack, "unable to get old reference sync
>>state");
>>+		return -EINVAL;
>
>Propagate ret. Not sure why you ignored my comment about this.
>

Not ignored, this was on the other series, just missed it, fixed in v3.

>
>
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
>dpll_id:%u",
>>+					   dpll->id);
>
>Why you print id? User knows what he works on, don't he?
>

This is for easier debugging in case multiple parent dpll devices, that
pin can be connected with. If that fails on one it is better to know which
one caused failure.

Thank you!
Arkadiusz

[...]

