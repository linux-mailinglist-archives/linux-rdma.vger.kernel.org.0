Return-Path: <linux-rdma+bounces-11120-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFDDAD2C46
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 05:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7B33A5183
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 03:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578FB25D536;
	Tue, 10 Jun 2025 03:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNMT8avU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730835789D;
	Tue, 10 Jun 2025 03:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749527356; cv=fail; b=b9ueynRB+0tigeRjkU6uwX6iyfI9o1Ns7mBYT9PRN5BiN1SWn+3P1JaWiOsa78u7T5UhMIPiNgz8EZW98B+1m+Nwx+nrEYGHa97lXUfYbfx/PTbIhTmFmnkxLnDwn/x+4u0eXFydHZH5uSdTdYrqN/iEnAdfDHWJGO/28RHbYlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749527356; c=relaxed/simple;
	bh=5qsQUBgj1+vLB9YSIOWdqLGVEQNOnMCWRgJpiLAD8i4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YoybxngHaaCnxDQFDXyU1vCHZQ2KVz4Km51yCPVvC9QEsvQJXJJR+xQtKlswJjngKmHG556/dxZ3utUzAIlCQJssCzAdlpGdlG60EiBkzPDNzrSzn66CMDlAVO4XNEKxd7EOIB0NDN4dfDsdjGLSoSfspFHVYO7n3YjGbpXdtbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNMT8avU; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749527355; x=1781063355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5qsQUBgj1+vLB9YSIOWdqLGVEQNOnMCWRgJpiLAD8i4=;
  b=RNMT8avUbB1yMZ5+qbuQPtKFAnCgnWVvHiDlomdylAIicSCRaZmOm8bG
   4Rpw1gHDQC3eEuflw97fRxoa3S1BwHIGRmhWIeUGH/TumD/PAFZb7mHOG
   76zAx8trE413Zo/vILHNeK0RDRAKw2gbCbe9e94WwrRryyz3YW2XCGzzY
   XPkGqmRvkSQjYUS+FM2rPchfBUMkPmR09djaGMB4fbHpv9RHXf5nA2dSA
   04PthzoL6Yutgml3Qhk+bq9755sMYl2lnzgF9rOdh6dXGnt7z8stpyj6S
   CjBRE8XRuzbUhcHm3PCsklA/pyI3xBle9TAFqvqG3x/H4gHaR9vq1C7cH
   g==;
X-CSE-ConnectionGUID: p2pAiPqwSDOeFuxWvYp/XQ==
X-CSE-MsgGUID: 5LVFNXKLTWWh5ivngDSjTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="61889931"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="61889931"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 20:49:14 -0700
X-CSE-ConnectionGUID: 3eXtqR6FRoasuUOiW5WyCA==
X-CSE-MsgGUID: 8bvXhbQCRcGoVBlc8Oi8Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="147216924"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 20:49:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 20:49:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 20:49:12 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.58)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 20:49:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgU37Lj8A0LgnpQkxgICSGH9aCeKkNKHBVpsRiz6ru+hW/8KD0Vm4veLzYZvvoKFWydOFGQMufVWuQFwfu4q+aQcOELHhK9GzCWk3TUVjcKXZuIuxt1wzMz5OcYTpuXp+B1kdfyZV1FiHU29g+GL+73XJlY3jFbGczpilwrc1m19b3lMB1D2UImPXGG+3CPSsavrs5kpyw1dBRN7//zSDw3ZMZPtfF6MoTUqBzB2Zok4EAU6K5u9RGiIM6N4WeQkoGaCicSzhqZ27za3augq2bzDnIxtXtv4XJ8xDpaMh/+FcqvLMeRBizVvGkpjS3tvsHMZeGMqN14sEGiE1v4jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qsQUBgj1+vLB9YSIOWdqLGVEQNOnMCWRgJpiLAD8i4=;
 b=ZL2aSbwoTZBPj6kWTnkKu2CyiMUBn2lwye5rR0FQ5R1gHS1DfxzRBmZurIFw/WZ5zVtP2o8Phu4OEx5BDjGVER0MCaVVdFaz5I6mszAdtsHR8dj0+xD8lXL/XpeWlXB0SfQBnt275Z+T3mYXoVIMG+jxOjqJ5ZLFcNoIVpfXAMSoHOvBLOJUDNqPo+MsaXdm8OlPHMiSuY+BMpZey9kj2flrCeb7W7MTvz+eL1NaP6Zn3WJKMysQXMnqhaYuUeopjmjoYzey0DlwfEh0AQPXgTkHzq2hkC/HgRZjw1Pe+iXBDZ8xSBoqgUawtnvH7jxESfNgdOM2ZaQ8miT/aDbcEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 10 Jun
 2025 03:49:03 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%6]) with mapi id 15.20.8813.022; Tue, 10 Jun 2025
 03:49:03 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "Nguyen, Anthony L"
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
Subject: RE: [Intel-wired-lan] [PATCH net-next v4 1/3] dpll: add
 reference-sync netlink attribute
Thread-Topic: [Intel-wired-lan] [PATCH net-next v4 1/3] dpll: add
 reference-sync netlink attribute
Thread-Index: AQHbzAj1jskmVX+BgEmMcDrLZVwUNbPqYUIAgBFoa0A=
Date: Tue, 10 Jun 2025 03:49:03 +0000
Message-ID: <SJ2PR11MB8452C09EFD87AAE4CE9A44819B6AA@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250523172650.1517164-1-arkadiusz.kubalewski@intel.com>
 <20250523172650.1517164-2-arkadiusz.kubalewski@intel.com>
 <20250529174914.179c1a34@kernel.org>
In-Reply-To: <20250529174914.179c1a34@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|DS0PR11MB7410:EE_
x-ms-office365-filtering-correlation-id: ce579bea-8ab9-4550-1f30-08dda7d1be04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?arT8JKTjgx+XbZ5Gt2ckQMN5vEZ2RqmZmr6Qok0L+gGZTvve5tYc3ZxorekQ?=
 =?us-ascii?Q?ZYoY5zP+/aB6+Lrgrtxe7uCRTEhzCyXFSQxCHItb73FT0vBWxuO4PDk+nU4w?=
 =?us-ascii?Q?WFq7eIskOKVY71Ee/qF1j4phmC6wB5SDI/Oull1EO99nPQFagjUfM7iVHyRu?=
 =?us-ascii?Q?akHVigasjd22QarVQzYFtCMFEEjUITk5eRc3ZZfZLOwzmnSDi0AfxCyGYEBT?=
 =?us-ascii?Q?KFE3WBd0Rm35w+TSv7zlu3i/WgVAgG/rgvHB6i6Q7zBkMSTyNo0MLlbVf6wz?=
 =?us-ascii?Q?CcEqvaGa5d8Ru4eJK380cQabmUzYTk3qhgD5ckTCcYuIJQyJ9ktbhdX8YiBa?=
 =?us-ascii?Q?8/MV/IndWhh2EZ0rZVdjL8FJB4YtNsn4x6uiQ8Bs7KVuwhPn34dxBzXogI40?=
 =?us-ascii?Q?xOL8QJF9UPuVe3uA40AC1PETIpn2te70S7PNXhnz9Q7WngPLpJWh9udUL/fG?=
 =?us-ascii?Q?pGlwwq1tAlp3eYiLfDMZfyXCDQeUi9SUuRKiaL01alzYHRte3JtTqGbS8tpi?=
 =?us-ascii?Q?DvOt4dAa9WoINMknlqMMnVysSrAlig70SV96dq1a5xZzui25TjoH9ewmQDAZ?=
 =?us-ascii?Q?Vo51ilB8CJXvHsn9Fh8QZmftwADB9250wZsb6l0e5zgT2gF5zNY0qYakkZAf?=
 =?us-ascii?Q?ZswCWAJ+P/wE2GF/BuLDTiIpFTI9iEUIzv8PHFa/k/q6slortUchSH93yuVc?=
 =?us-ascii?Q?DosEY0v1/BVDYaF6iyPm6shYpNEc/bwFSPcgLtxDaX1OW7TQRWmk0LsJ/+O7?=
 =?us-ascii?Q?D8Ful3JZNaThoAjqrbXXnvUwpV45R/dnGMFFCJXiPDU27f1Sc+Ty8cCY6DCh?=
 =?us-ascii?Q?l4k55rIFLTmMXAxiEMVpN4hyr5JgOSTkmYi/S5OG7exSHWXiZADq1CSyGuUv?=
 =?us-ascii?Q?Pu/9kTS7sQVLqbEA3F3IoAerS+PSxa1MHuJVUB3IzrK18HTUHzYBEvv5UGoS?=
 =?us-ascii?Q?tG8Mu7pQNGyXlLVLVgY7/zVDUgW32qzrAI13H8BP60HcXNV8XVigF9k7QXQd?=
 =?us-ascii?Q?yGh7n4Zrthhk1t3uRbtW5TMPpaW4MmfIVosBwHMGMyVhFkfA36QHUxGHS3vu?=
 =?us-ascii?Q?Q0oR0LrWhyFeXnUUzlaSMsI9hDEaVt1f7bisJE+AuOvjk+1SDQ+mxb8A/I1p?=
 =?us-ascii?Q?nONugyG7hXJqj3XK3Hab26TRV3lo2Ft8gkfhZq+zw8Kn9Tg1VQD0NkoFyFce?=
 =?us-ascii?Q?a3eZOocaoGXrCiFNbDafHDShzOGwp8zb/nYsv4Kezq/YcEU3usnVpB17Jpmm?=
 =?us-ascii?Q?68gqX31wYTgVW6+RmR521uwbRr7dQYvoKw4aj6MIGydKnLpV9ZbGrJqpD80w?=
 =?us-ascii?Q?BLwpCCDoYdaUYfzd3mqeDCxb12Ai0Jlqv9BfT0HPQ0IyGtBSCwVQIJBGOwN7?=
 =?us-ascii?Q?wTsFbP7QNztmV7VJWogtx/chldgTwZVv8qadg1l7V1jzgfh3rCYatIH/WIYj?=
 =?us-ascii?Q?zMVwkk7P8+wVfkpBBc8o7rjDfQhhfJkt1q8dPNBM7rooenb/ktvoTReFg/6K?=
 =?us-ascii?Q?QJ1mti0Um6iVP2I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fB7FVEtsVchs07SYS7DxmcK+ljrShiKpqYLo5YBkht4ol3jLwzQjDKnZrTBE?=
 =?us-ascii?Q?N12CiRMWBuFGG05nRg8YuKC6QavtwLR4d8q7Q11+TMeXVdkeR1RfO98ZIHQ8?=
 =?us-ascii?Q?TdQ2VhstyadpZXlvUTTmM05pqIWk5+U4aEP7iSR64m/ZSo1xJCCIaZ9BxzjM?=
 =?us-ascii?Q?7gvStAzVfXi92XYCHwZhUyrO1fnVT52cY/1V3AJ6dkMnSIvfa2r3fd87I4j2?=
 =?us-ascii?Q?eC34Xrw5bLL5lKZaJ0FSyruRsyRqPRg/rjVD0XyGH54hEqbWLhpa5Yp4dkh8?=
 =?us-ascii?Q?3tuvHHCcah5rURSZV7uTITGQV1Zmqho7XFDmN/8jvyk6s1t8cTquI+20iomY?=
 =?us-ascii?Q?yQc9ia3q3nFgnSkbg/ZnCg5h0YzJKH9bP5gAibeByPRhFQgJsiOi5HBHr+NN?=
 =?us-ascii?Q?259uP1f6AE5ynFjFz7LPqVonomaJ0/RjicUZCqZve2DCDVSozxqOoaseOZ5X?=
 =?us-ascii?Q?l40samUfHeKQwRgOYNjfbWpP/fBGwjFALbZzWP9tyH/jMdMxVhhJGnYvsfpC?=
 =?us-ascii?Q?9W4K9LfiTztdVzOV2BRqx9Mp5fKhDj6bmsuIPc7l4JNU+/YAXYSnDHGw4VAy?=
 =?us-ascii?Q?iwVQM9GEleA156JW3n/OHTnbJs2EZtJCx9dG4g2nsN5EsBJmCnRMQsz1r57n?=
 =?us-ascii?Q?jh+VUEnqvACgDR6J6NP4A7WtHasJrsLMXT9T/+AAqTqyQ7zo7vfG4xJqfMSb?=
 =?us-ascii?Q?VI/5sJPE9o9ynu1AnqhWz1ombIN6WA58Lst24OLaW+PkrLlxkN/PyRZANV4P?=
 =?us-ascii?Q?9U2ltzDDGnak8r3eJ199RVJtxZJxUnoUuRvkQVGKVURiJsZ0hWZ8+mtZOZ1/?=
 =?us-ascii?Q?zAgu2Od12ZEacwj2lB1l/XqjOVF9Ep9JVm8oY27GuucUBCTJA7oS7JRnd5kl?=
 =?us-ascii?Q?ZnLl957uJTBpJIgnETxD1FOLC93hCEVkmnay2kniCjoR2ED+7WZOjZVmfJ0w?=
 =?us-ascii?Q?MXb0WfV4HMK7536nXRd6TIgkZ+bBAYJLE2kybV9F5bPW/hGRhObRHRgXbnL2?=
 =?us-ascii?Q?/biw7R96irz2X+C/qbFm06CzedutY1EdFDQJTQpnSM9c4TZNLL4I6CYXbwTS?=
 =?us-ascii?Q?cvDCf4kpwuFinegd+V5Be16Hc0J6MwFNKw9f7Amtju/67KYuq5ZMLiAapQLy?=
 =?us-ascii?Q?uxEWwC3kaQsx8rAJHtbVV70crbawhaSKYBmdC49qyCahSl/maNJj40L2AF5X?=
 =?us-ascii?Q?4KFx/ULCMIelRXvPOCtNhYcTkmv9YGOqFuNc1mxKv6EsMRRFl09wz1B4Xpma?=
 =?us-ascii?Q?UmqUuy6H+G/hE9DA/x0L51i1EV0Ddz9RUopg7JAupAyNaKyUgJj+n5X6DXe+?=
 =?us-ascii?Q?ssr2AMirtOUILTgH1GtwPoD/W1m5HSNGRpb2AUovgQ5/k34AcSQaNhbct7Cl?=
 =?us-ascii?Q?RfT/UZ2JpDsDN2Q6ee99DSFWPLG1ACm+TIvInX045tkv03IeOsvIIY5hM1Um?=
 =?us-ascii?Q?GuX82eUULyOI9LDMQcJAmrMRUdVHwLjjzmtWrJ5dVggHkz24GPOcg9rhiI4z?=
 =?us-ascii?Q?lIxrFosqYFqaJSpeXJQsHXIbNy1Aonm/Sp7wvh4Ds/aMiFHe9okTeVHkcGNj?=
 =?us-ascii?Q?c/hKfW/fD2vGwIdKir9Kh/s1irKkFQ/l3gPakSgkKNjIFrJnLJF1M5GCeYKP?=
 =?us-ascii?Q?/g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce579bea-8ab9-4550-1f30-08dda7d1be04
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 03:49:03.4089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3dx4ht/ZINCvxNSEb6uCRP2hxh4x+dwWoqJVDS2YkyIZf92aXkQiFa5wXARINaWxVWlvsTbcGDgWZ3SSPSBSRQPkhQTdmGkocRaolplrh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7410
X-OriginatorOrg: intel.com

>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Jakub Kicinski
>Sent: Friday, May 30, 2025 2:49 AM
>
>On Fri, 23 May 2025 19:26:48 +0200 Arkadiusz Kubalewski wrote:
>> +The device may support the Reference SYNC feature, which allows the
>>combination
>> +of two inputs into a Reference SYNC pair. In this configuration, clock
>>signals
>> +from both inputs are used to synchronize the dpll device. The higher
>>frequency
>> +signal is utilized for the loop bandwidth of the DPLL, while the lower
>>frequency
>> +signal is used to syntonize the output signal of the DPLL device. This
>>feature
>> +enables the provision of a high-quality loop bandwidth signal from an
>>external
>> +source.
>
>I'm uninitiated into the deeper arts of time sync, but to me this
>sounds like a reference clock. Are you trying not to call it clock
>because in time clock means a ticker, and this is an oscillator?
>

We shall refer to a reference clock for each input pin, right?
TBH, I have reused the name from dpll chip docs, I believe they have
tried to make similar features and naming convention for both:
Embedded SYNC/Reference SYNC, and that makes some sense.

>> +A capable input provides a list of inputs that can be paired to create =
a
>> +Reference SYNC pair. To control this feature, the user must request a
>>desired
>> +state for a target pin: use ``DPLL_PIN_STATE_CONNECTED`` to enable or
>> +``DPLL_PIN_STATE_DISCONNECTED`` to disable the feature. Only two pins
>>can be
>> +bound to form a Reference SYNC pair at any given time.
>
>Mostly I got confused by the doc saying "Reference SYNC pair".
>I was expecting that you'll have to provide 2 ref sync signals.
>But IIUC the first signal is still the existing signal we lock
>into, so the pair is of a reference sync + an input pin?
>Not a pair of two reference syncs.
>
>IOW my reading of the doc made me expect 2 pins to always be passed in
>as ref sync, but the example from the cover letter shows only adding
>one.

Yes, exactly, will try to improve this in next version.

Thank you!
Arkadiusz

