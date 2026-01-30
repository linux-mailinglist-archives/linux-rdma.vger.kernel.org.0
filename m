Return-Path: <linux-rdma+bounces-16273-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIu9OOzvfGndPQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16273-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 18:52:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 468B2BD7E5
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 18:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17F87300E3BE
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F3F35C180;
	Fri, 30 Jan 2026 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmWGcMna"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96D344056;
	Fri, 30 Jan 2026 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795534; cv=fail; b=b5znqrMgAX5MrCLUfmXMfLLiG9hC0u6yTc9SNIdyr84VzziSktsM7GvMj3dVuz5fCgmaSKqNZZOih1B+Y0UG33ppWdDz1godqvQbmcbtON/FHrzoLXmyo+aEILmhtEuNT2LLi0aXmqrQ8GkfSJ+cMwzoIVgpjOksvBElcIkSiLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795534; c=relaxed/simple;
	bh=XZXsPtDh6ziN13af+YYUPj8ksYfLjG/7wr/snAPhIko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pseS1+NrwtiN1uXLnkjY9PosvA5C9vI0uzYVmVtvku8VzZZtVqyPUvXnhrgnAxU1iBoYa5Zbt9UEKzZxpEbTdMMRhDsX9Yea7NVM0LrX72jw1D6bxGXVmQ0668n7TwXoM62e+1FajyIPvg21g5k+lP3XaRKkRtrkACqA9RW7THI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmWGcMna; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769795532; x=1801331532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XZXsPtDh6ziN13af+YYUPj8ksYfLjG/7wr/snAPhIko=;
  b=QmWGcMnaPJUT0mWi2z1LWEI9D+I0o6VWQ+pKWyfGoA48SipxdewVXl4q
   fNGG6ArZsESaf203eeusSkySbTtjPuk06O8/o8IlATqvK/hHiWRyekQAB
   Ke0nF50i2KbTJkWzrfMXSULGxxN3vbbPyh67VSTyfsjPsCz7vbZKGw2SX
   Xe8CnBrMmcTQQHBtlv5tZJQMiBIFKO92wrfqbXEO9FTFMvyiWvTVS4qXI
   NwtDBsH2fT5rT946l7ycQwVXTYO2b6YTBWied6EQmLaChgWydZLgpDZIK
   C88vwMAEF4VbJdP1ZhhlJSuirfAWBzuStrtp83mk71OlioHQgV/8EaM8O
   w==;
X-CSE-ConnectionGUID: 97yJf2EWS5GQy6SOMUCd+Q==
X-CSE-MsgGUID: 9z/Qcot0QuaCPgAofb8mow==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="70067909"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="70067909"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 09:52:12 -0800
X-CSE-ConnectionGUID: V2irwwV6SjCMGWt7w7RH0A==
X-CSE-MsgGUID: nVKgPKZKT7yEGyXC8yC+1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="246534855"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 09:52:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 09:52:11 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 09:52:11 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 09:52:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr2gvQDEi2y3rtabUeJngZvy7CwGSVhqy78XHx/ZOCa9cDqEvPJb0UF99xv+FbET6KtWJHi2L6LFLP03cqB6gbWX8WyxkL15qzH+DcLejC09CUGTg7STVjw2XGBohDkwKDKqdzdTVeonuMayZXUESZmtCVeAYIRudXY78J1hMBryIXCWCaI3KPFtdFYfv4ElBa9LArVzIPujiUN/8IdWudmzRDwcsuZkxfm+27qjMF66jHZE+NFwUhby4529MK+RYzKxJTfqD979dIBa7r2X5osqxXtQtbsGp+mYWH4TUV9tCANPtl86FZ0naF0N4rJCSDs7Yq3+QBcXz6ZbmrxSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUwxH63kZpLBLI8CizEMPCYE9q47MZGTrMxkVhe8348=;
 b=I1qjts3QJuqLrWo1yCQdS+tzHIL9dvQm37LclQpmRaoArnSkLjyL0aGr7TRiLZRuQ8Ix+f09o4g1z3GF6G45I9eQsxdnYLOYuR9KM92cZ3Gzg86zCs/FuJmmy47Y2sDUG1xsnvsl0giOjcFTKK86FQtCSjT/FMSCoJ8LbAhCxD00FxNuVD+AAozp+mu+7kqFWwWQTPWjJS8fMykQSqomo6DtaVRIeaOZNpLP1V2fn6XTwH1V8/X77CENknknDHM8ZFV9MrTypo5RDEnZacE/EsNPUE3dILHzgdDtuY/MBj8oXs4Q8Zkjp/QbpqVTUx+DT8jbmzxzuEih/P6ot960zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by DM4PR11MB7277.namprd11.prod.outlook.com
 (2603:10b6:8:10b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 17:52:07 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::f7b3:4461:b4f9:1a0]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::f7b3:4461:b4f9:1a0%5]) with mapi id 15.20.9564.007; Fri, 30 Jan 2026
 17:52:07 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Leon Romanovsky <leon@kernel.org>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Richard Cochran
	<richardcochran@gmail.com>, Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Mark Bloch <mbloch@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next v3 7/9] dpll: Add reference
 count tracking support
Thread-Topic: [Intel-wired-lan] [PATCH net-next v3 7/9] dpll: Add reference
 count tracking support
Thread-Index: AQHckgkx3hzhEw8tAkS35uViyBXdvbVq/hqQ
Date: Fri, 30 Jan 2026 17:52:07 +0000
Message-ID: <PH3PPF7A88A980A2874FA7C4CE826958826E59FA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
References: <20260130165338.101860-1-ivecera@redhat.com>
 <20260130165338.101860-8-ivecera@redhat.com>
In-Reply-To: <20260130165338.101860-8-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|DM4PR11MB7277:EE_
x-ms-office365-filtering-correlation-id: bbe47e1b-2387-4c06-f722-08de60284941
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?GZwEaTvO9bg7Ye8DfzalugzfoJtEqwPPLYYDNIow6eqHPOmKqpaR14fKMiij?=
 =?us-ascii?Q?YpIED5/8TdneDN30Qg6dwP9aZiD/GpyTGY1DauP2y/geaCGy7O3UJKFjtDMS?=
 =?us-ascii?Q?SlJiXMtEGMOeB6QDmv9YDCXaH7urUFjxRtcQqPt/fOdc912R/5gK+bs8x39z?=
 =?us-ascii?Q?+9lz4B8x2uDMeRgMexB5nRFIGrqWDAf68qeYjNQaDRJDvEEarTP8VX0RQ147?=
 =?us-ascii?Q?MrDkB0pAqksx3i3ynov+u0lr759qPGIwRw8ztnRb4Ff+XxB4Y8rC0LmbkwXC?=
 =?us-ascii?Q?RCfHNrmkIK0zBSRbIprsf5uLq5DIf3WuVHlgoBuua+izk9iSkzFktLpiXhdG?=
 =?us-ascii?Q?tPViI0w+LwCsc8bqvjWRqMCpzKQx3lO9oG2+Q7YHocW1Deur/N0olkHIl69/?=
 =?us-ascii?Q?tE1KRN5+4hoeRdF2b4uJDsOUL2xKnmBwhXhVTMwNvY9OgYf/zfD2GoO30Kx9?=
 =?us-ascii?Q?p09fS9D06OUfl4nFLaWTsH9cISuEE7rO6XSVAYcCycuGkvDljtgbV9stMcty?=
 =?us-ascii?Q?YtWYby/qRf9SsopaRgQSLna0ysbYpzFgofPj82lPWjhsk+O6/QqznGWjRlvs?=
 =?us-ascii?Q?V5K7JaTRhSlrmBaGGMsACeim2c7Z/DOv/uEvEgvvbcNsYNwZN7XViegLtuST?=
 =?us-ascii?Q?WKbcLOTbMYkM9YuUylLi1uLFGDg3wbPgEFtrVa02GCtLmiu63eMfrnUSc0VD?=
 =?us-ascii?Q?DVogs0Uek48uefieyI2bZ/IdOTbucwi2J/v84NmuDqRDmxCLQo+i689IzIEr?=
 =?us-ascii?Q?huhQBiswZaqktXIvMGCAfGDoAvQYs2mLflW3dntlgSsID0HAV/VEmGas+sVo?=
 =?us-ascii?Q?ZzYi742N+jZtMNiBpf5rhFbe/a8y2twrliuf6Wrn8ds1T2leZBDkkkDi3+io?=
 =?us-ascii?Q?QYW2HS+IJdUADufP73eBhs9jC+TqtbCou4F3Z2vU9tPj4TXIjUth79wWT6X5?=
 =?us-ascii?Q?0a3OxqEWSIwrVfrEVj38HUSlVNaqRSlONxkvpqDqxV6jVA1g/1TC0H64zxL/?=
 =?us-ascii?Q?0ibRZVW9NiXAAtqz0x61eObP5OXsyiFOWdW3TacwjamH2uAO0YUWA/zNJmZq?=
 =?us-ascii?Q?RF1DHdXEXZEzTl64ML/9apk3hsBkoHajOxFJj2bUD4+HS6xphawFr9oqkZr4?=
 =?us-ascii?Q?R/UPkkyrRAxtVZ/EalgeKz0zCUHqXF7c0h6cq2bMkOvELtwUEYVPg+ZVfRnK?=
 =?us-ascii?Q?Vi4WLgIU3PwUy0jFp0zK9aYiNe3i4/YlIF17Itg4vdqZZ5BE1vnohXMJAQpB?=
 =?us-ascii?Q?THia8G3/zPRIn9JLZST/wQq3FlGO9HJJPxWd2daWellbQdhjfvGrm1cl19nL?=
 =?us-ascii?Q?rY0tU7nCjqcXu2oHrZrkJ7/F89OU0efjHrlTw3dBU9+QkS/4ZpE2OvIo+IgR?=
 =?us-ascii?Q?FTQKZR7JfL//2m92l66kSGgmgozdHrveJkKo5A/FTy6STHdrltOifuKJE3QJ?=
 =?us-ascii?Q?stdJ2AivsoaG2qoo+9eI6eHxiX9sLJrgg/tQ5EXfrlzvB5+rWVh20KyiGjgz?=
 =?us-ascii?Q?jnsncw/y26+sDKuWLIkmlQFbOf0ZThxOglgTOJXqx4dWUDwIszp+YPltMzrC?=
 =?us-ascii?Q?mBK33q4okaqsPwLSEUPbCOs1b2gu258dOorl/yfSKiD9JqukzpX3rul2vghK?=
 =?us-ascii?Q?TN5Nbfed68luJhi5epQGOwA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF7A88A980A.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UudBAWSXBDNRZfuNF2GnRbH6hM++pGz8ruhIHOdH43izQSzbklHyzCUPysT2?=
 =?us-ascii?Q?CJ2vaMPzIEXefrZZfcAoO/id/S2Z3PEZpEFTePweg7mVJ1hb9KrUXtUEEppx?=
 =?us-ascii?Q?LPo10UwbNm2mzp3D5STSyKwLoINwegLkr4AYMnywxlPTOMnuPZvgi6S7LbLR?=
 =?us-ascii?Q?g6YivVfXvSByqDNsulxwebYvEDuSlgn+ar3bFMNIBc8I5QvjVV/o7kVsEGyl?=
 =?us-ascii?Q?YdUEYLHIiY1CqDREi947k4L3I1X2XMK+07HlHOEdK7JpK5b/c7B56wEzQSuX?=
 =?us-ascii?Q?4Wp2PVaAmtJn3mwodHfUO3Quv0YlAZ6WdivvBTl1sg3dKiubej0IkF/i2rtB?=
 =?us-ascii?Q?vFmNL+D6MFO8F2dc1NToMawOoOXxQ7kD3ffYDovKY8CP8h23s9Zu3ox+5mNg?=
 =?us-ascii?Q?93YsO+UDXAxRY5NGRBrIN+X5S8DbZiBp07snFpXdBvYjlsRs6Qsaq8tSPEar?=
 =?us-ascii?Q?rFDg+jcMQgnZQiYYLW0mzW0Bn00LQxbN3CG/fcLrQdeGe2nzylMGyanvFviy?=
 =?us-ascii?Q?wlgykexOir0mQ9nD33zeLu/7xM0NDx1ONGG78NjPWGjMTlSJb0PUq7KB+NSC?=
 =?us-ascii?Q?HJdC9FhD/8isPeBp1TXZnHoyvE49v8jW6W5PG/O8lRBtMbDnQMuh6/99KERJ?=
 =?us-ascii?Q?F6EW2/z17GsnDribftQkYbGwKLC65UYvHztoY9hkP7YkzyHz2Q86ZIGEYQqC?=
 =?us-ascii?Q?ItapSztIxl7vDRTHoVUM70AvStODGKvj/JjF/sUp8elpRNI/AVn+tfBrVlDo?=
 =?us-ascii?Q?ETsg0vqLa01R3Y95Z9SB2dwuUYHXhP0HwbsYhb5DBQfBq3sV7dmaAZ+Ph4qR?=
 =?us-ascii?Q?aZsHN4oYS6d1BsK0dvGDF9yCR6Ir2lwGc+JctQiuyzYl6GsDd+Aer+ucj0T6?=
 =?us-ascii?Q?DWBWJ/2Nralrmnrca2QA0huk/kN8JE/M4kgFeXKYX7OeIn5+xLfkrKaTxVwc?=
 =?us-ascii?Q?AqaHFgSI9hDGYY34mPFdytijNJS9RinYIhlbhh6ZMUjum3THVGl0GEl1t3he?=
 =?us-ascii?Q?FnynIojqusgF3kzB2CIQ86NieZYS1iUB0wz0PHvdHzrfAcflNVsD2B5NmwKA?=
 =?us-ascii?Q?xrGNra2K0Y788cUKOy0sJqWJctzuTMrnCsyiI12oRiq3RYnQjWje1saTsaHW?=
 =?us-ascii?Q?lkT8cIzphXJBTcaeLtocW0Nlo7mbENE4G0ndKt0etB6XFyixYRjxbXNQYzEa?=
 =?us-ascii?Q?1o1hhvK2BgU8lpRSEOAdpDnj5bmBh8KCEAxg3LAFhdcPd8bslockukGi+P3H?=
 =?us-ascii?Q?e7ztBKl/Pah6fnTtyXBcsc/d9yHCvFble6I1ZUJ5fbeGOY3f1iuhSnE6P4uh?=
 =?us-ascii?Q?YYbGIZixRGOOY9M4LSS6E6xP2SwD3/Zpo7gRu+nMIgrqJhpByKqWDnCEeTnL?=
 =?us-ascii?Q?r/8hPOK6qzzbMgl8cXbe4sE/IPJlzNTJ/YktOaKCaFYRQmbl4Bu+pzCtRBH0?=
 =?us-ascii?Q?fAZZsP/MlNsRZu4SwMD1tncyDsXkYq7VQi/8yRBo0kGrhFx3cHY2Nyw0tcK1?=
 =?us-ascii?Q?3YDIQd0jXSZ7hNcZw5QOotgTN/in9V4sC25DUJEl/xqxiLVFPAVDyA0OpOrn?=
 =?us-ascii?Q?SPs9c3HWGgGpdoESB0tmX+F+f5mPqRjz6exUZ+fXR+31RrvyM9u90YW6wb1L?=
 =?us-ascii?Q?hDFGNUvyR7kZzg//zD9ovrMvCjmqE+zdThzINq3j73fCPu26BkM2wteDCnjD?=
 =?us-ascii?Q?cJdpq7hlam5M/40ywbIhT0m3eAsTQYkTS+cgEc+Biwp53X3mS9fRGg1cuhVB?=
 =?us-ascii?Q?+jYadaPmsw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF7A88A980A.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe47e1b-2387-4c06-f722-08de60284941
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 17:52:07.6552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FdR3K2U38Vyl+pYBts0I4TMYHqZ/YmV5SHhINOQzC5x0T1/GgOkC55dF1pSMXv+TEFyREran8kFDDrIvHx0pDoA21UTy1QRYXkj9opAFUmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7277
X-OriginatorOrg: intel.com
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
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16273-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,intel.com,kernel.org,vger.kernel.org,lists.osuosl.org,redhat.com,resnulli.us,gmail.com,microchip.com,linux.dev,nvidia.com,lunn.ch,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,osuosl.org:email,PH3PPF7A88A980A.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email];
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
X-Rspamd-Queue-Id: 468B2BD7E5
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Ivan Vecera
> Sent: Friday, January 30, 2026 5:54 PM
> To: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Leon Romanovsky <leon@kernel.org>;
> Lobakin, Aleksander <aleksander.lobakin@intel.com>; linux-
> rdma@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; intel-wired-lan@lists.osuosl.org;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> Jiri Pirko <jiri@resnulli.us>; Richard Cochran
> <richardcochran@gmail.com>; Prathosh Satish
> <Prathosh.Satish@microchip.com>; Vadim Fedorenko
> <vadim.fedorenko@linux.dev>; Mark Bloch <mbloch@nvidia.com>; linux-
> kernel@vger.kernel.org; Tariq Toukan <tariqt@nvidia.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; Jonathan Lemon <jonathan.lemon@gmail.com>;
> Saeed Mahameed <saeedm@nvidia.com>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net-next v3 7/9] dpll: Add reference
> count tracking support
>=20
> Add support for the REF_TRACKER infrastructure to the DPLL subsystem.
>=20
> When enabled, this allows developers to track and debug reference
> counting leaks or imbalances for dpll_device and dpll_pin objects. It
> records stack traces for every get/put operation and exposes this
> information via debugfs at:
>   /sys/kernel/debug/ref_tracker/dpll_device_*
>   /sys/kernel/debug/ref_tracker/dpll_pin_*
>=20
> The following API changes are made to support this:
> 1. dpll_device_get() / dpll_device_put() now accept a 'dpll_tracker *'
>    (which is a typedef to 'struct ref_tracker *' when enabled, or an
> empty
>    struct otherwise).
> 2. dpll_pin_get() / dpll_pin_put() and fwnode_dpll_pin_find()
> similarly
>    accept the tracker argument.
> 3. Internal registration structures now hold a tracker to associate
> the
>    reference held by the registration with the specific owner.
>=20
> All existing in-tree drivers (ice, mlx5, ptp_ocp, zl3073x) are updated
> to pass NULL for the new tracker argument, maintaining current
> behavior while enabling future debugging capabilities.
>=20
> Co-developed-by: Petr Oros <poros@redhat.com>
> Signed-off-by: Petr Oros <poros@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> v3:
> * added Kconfig dependency on STACKTRACE_SUPPORT and DEBUG_KERNEL
> ---
>  drivers/dpll/Kconfig                          | 15 +++
>  drivers/dpll/dpll_core.c                      | 98 ++++++++++++++----
> -
>  drivers/dpll/dpll_core.h                      |  5 +
>  drivers/dpll/zl3073x/dpll.c                   | 12 +--
>  drivers/net/ethernet/intel/ice/ice_dpll.c     | 14 +--
>  .../net/ethernet/mellanox/mlx5/core/dpll.c    | 13 +--
>  drivers/ptp/ptp_ocp.c                         | 15 +--
>  include/linux/dpll.h                          | 19 +++-
>  8 files changed, 138 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig index
> ade872c915ac6..be98969f040ab 100644
> --- a/drivers/dpll/Kconfig
> +++ b/drivers/dpll/Kconfig
> @@ -8,6 +8,21 @@ menu "DPLL device support"
>  config DPLL
>  	bool
>=20
> +config DPLL_REFCNT_TRACKER
> +	bool "DPLL reference count tracking"
> +	depends on DEBUG_KERNEL && STACKTRACE_SUPPORT && DPLL
> +	select REF_TRACKER
> +	help
> +	  Enable reference count tracking for DPLL devices and pins.
> +	  This helps debugging reference leaks and use-after-free bugs
> +	  by recording stack traces for each get/put operation.
> +
> +	  The tracking information is exposed via debugfs at:
> +	    /sys/kernel/debug/ref_tracker/dpll_device_*
> +	    /sys/kernel/debug/ref_tracker/dpll_pin_*
> +
> +	  If unsure, say N.
> +
>  source "drivers/dpll/zl3073x/Kconfig"
>=20
>  endmenu
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c index
> 33333bc2f0cc8..52b2398b9f3ec 100644

...

> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


