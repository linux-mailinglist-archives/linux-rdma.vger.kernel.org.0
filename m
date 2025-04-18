Return-Path: <linux-rdma+bounces-9594-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B70FA93BCF
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 19:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66414617FA
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 17:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B5F21ABB1;
	Fri, 18 Apr 2025 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3AmXe2u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72601211488;
	Fri, 18 Apr 2025 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744996470; cv=fail; b=G80uPUVGcVMAGowbc+S9bL82lMWo0VJH0A3NXnDC2RD015punkiDbcrno5uTtrQU+4e7c5zo3jmUUzh+PsGdpZvZgJ0s61R1OaHKsMER5ULzfjBb7II5pdkF0Hzsy3RwJK17x1UPfGttN9WbQ5zBmzxiZMoUIw5jlOFy5xwpOG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744996470; c=relaxed/simple;
	bh=e7+/SFlWJJ/WXkLH4pzuzJK+ZRBeSHH006H93VUUA50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l72/voGHmCYFXqVxGWAZ2cUTzMFHU/ZF9CAz3njYuMyiIdDCs/si3RBgOMMiJmaH5PkHTnEnw7N+NgTq4ovr9RE35ZUHLUWXusP65zUb9eN2ss7TwCCcn3y203F6TPyx55YHTnutp60j0RFBAlKcWY07UowQmU2T4xPWXRIWADg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3AmXe2u; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744996468; x=1776532468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e7+/SFlWJJ/WXkLH4pzuzJK+ZRBeSHH006H93VUUA50=;
  b=I3AmXe2uSuhaiq8bBmRJzKOLJd5Kego8Pvnvcs+kR7psxxZzwf1uHnpr
   sih32E/dyy8jE9hxZjWfIMCcM4+gqtnnECRaw2bk6Wbw6YRQ9xqrwea1c
   tFjzPso1GIldCBfMda/HXtCrU7POAdtd4R0iCQInfsCVRIa1ZC2J0UCxY
   F1+uTG/nyoqiXGK+l+e/seB1cTc4yD9sLOiMsA7gph4gshzRuPJw7dTfV
   Y6wufA5sTPiSdyEPkhwJNVpvwfxa/QJG/9ScTioy3y/TIhr6Ei0uLEtnH
   mgvd5iDy1Rvmjec5wI+TPAM24Q7kNmLPAyfJAMLqq+AyGQ/96mhx2Jdkv
   g==;
X-CSE-ConnectionGUID: AC+CnLVERemAUvaCqxylSA==
X-CSE-MsgGUID: te5k2ZkRSfCuujzRcD62VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="72017403"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="72017403"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 10:14:28 -0700
X-CSE-ConnectionGUID: q7ZYvkKPRaOOTQQeN8KO5w==
X-CSE-MsgGUID: 8oAqHstORN6ApWxQnk5BhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="135261313"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 10:14:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 10:14:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 10:14:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 10:14:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zdng+LCobPmVn4bmh116RgBlpDHyrVoLo5yvk5XDo66K7I4Hb+fU1FKNM5uW1jBcCJ/2SK3JgiC9Yb5mQD0AqJH9rDTOFuKQSAraOHptUhEOnr5OayEXfrDW6BZJ9LtVIZDH/eO+8dwYMr6TdZJCVPI/mZvAX/jRti1KaPKWcVJgOofUgSeDyyQ0ylC5/UGNtZB/hje/b/luqBNKXTV3qzNLaPSiPtBJxkd9aCyGiS/TzBWIPh+ZfU0YXWFM6Ktz7j0aLXcYZJzsWv/M64dXd93kYa92SYj5YhJ7ituIZQiwyCae4ZePqc7AG5l5RtEZHX2MmbM6ikpGvdyB5FULYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAO2NQq0nJXiOZ2PFbKSUl37+JWsEZGcNsPEdaagx9s=;
 b=NWpqVWEMl4mmHySxL/fqXoD+JxRTew6CH+yiv47kjk8dDyUgbG2ZwXeqnDFoLc8I7wt/zDiy2Uvl5U874LYkbEr3fNqwtK9263YaMLKaU70ZHUer9w4furxipNlZ33uvvo5ALMSEKT00GWlU2FsXIjcmSglof2MlCY/Ku9yGjnHi8lD0nuaNRHAT3BeG4WlIHCsKC1+F/oi7NN0r57jC1UsCOyvrenEwttwRy3GU4NU4st++IxudBmzOUQCC2QpydvCNZj8j+deAsBWV8fKxX32wOyW0ZDfBUCaEY7S7B9PE9cA5bDMV7PWnjkCKgcFlFFHRMghu2fB6UORFKl2FZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22)
 by DS0PR11MB7972.namprd11.prod.outlook.com (2603:10b6:8:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 17:14:24 +0000
Received: from IA1PR11MB6194.namprd11.prod.outlook.com
 ([fe80::4fd6:580b:40b9:bd73]) by IA1PR11MB6194.namprd11.prod.outlook.com
 ([fe80::4fd6:580b:40b9:bd73%5]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 17:14:24 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: Simon Horman <horms@kernel.org>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [iwl-next v5 5/5] iidc/ice/irdma: Update IDC to
 support multiple consumers
Thread-Topic: [Intel-wired-lan] [iwl-next v5 5/5] iidc/ice/irdma: Update IDC
 to support multiple consumers
Thread-Index: AQHbrnWgFTg+TFv+T0yRuUaTRIvTubOnuN+AgAH0HKA=
Date: Fri, 18 Apr 2025 17:14:24 +0000
Message-ID: <IA1PR11MB6194FD66BA60E12D6430DF22DDBF2@IA1PR11MB6194.namprd11.prod.outlook.com>
References: <20250416021549.606-1-tatyana.e.nikolova@intel.com>
 <20250416021549.606-6-tatyana.e.nikolova@intel.com>
 <20250417112143.GE2430521@horms.kernel.org>
In-Reply-To: <20250417112143.GE2430521@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6194:EE_|DS0PR11MB7972:EE_
x-ms-office365-filtering-correlation-id: a515f2d5-4be1-4791-cca2-08dd7e9c77a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ngK5LwW9YQL4wKFWGf7Jsdy3r1+6Id0C7W5QS5JZq//3g0CB5jhNYMS+OGNu?=
 =?us-ascii?Q?8Fib8F40A2Y4V5QwoAZ9FcG54nTlp2RPs2ZzM5GhKZtx9MApSpmCGfurTE5c?=
 =?us-ascii?Q?Cnhw0eiFgsj3DI790hi1Eq0cRz5fk2RYP6pRu2E5yr0XuEvfblOfpsWtxmNq?=
 =?us-ascii?Q?N1uR+CWseujrpNQHYoARgAhDGnq1DZlJhW2MtO6q72Z91KVlCoR04uQtST7q?=
 =?us-ascii?Q?WLzVhboLP5gLgaRJOsfz36i5E9Cyu4VwcL8vVhEtHB3u6o1pxEDdimiZtIm9?=
 =?us-ascii?Q?A8QLyt0ev524WUTFRQfcVJxlBgCC+tObGSvFa9M82tPjAlhgkJWWXd+M8i6c?=
 =?us-ascii?Q?HrJQVmlEuIMe2OOh2XOT3YdBEJ7WL+gaRSNs2kdNlgq9Ibyuk2rrQoeCP+jf?=
 =?us-ascii?Q?v1QO4zrmIdvc8wZQoDM3y9FSUiuvxcqwKGfoCWzADmFYXulqbmRfF6DG49Mf?=
 =?us-ascii?Q?Gxgjksa5AT/zgQcHYjcHlg9JJt9/qhnQfkLyAyufCAIBfG8NMVvO8yFCOB86?=
 =?us-ascii?Q?sfoZSv3SoqVV/DU3+ehr3/1cv5xEmE4XkZK7/ugRLib9DBHuoipw3nUdZq1q?=
 =?us-ascii?Q?TVBem4eOJ2tK3PBpEH5L1A9/Ip1hZ8CJMGyqtfX393nyJDNBht1VFaKpbDq0?=
 =?us-ascii?Q?GX6yoOckmxpYXLMPKjOBup5lduaiKHo/n31NFofdvyrBXtxEN6n2PdkYxIak?=
 =?us-ascii?Q?dY9XXhvnOXCjz0h6SqX6JXa8VrF2dKpz/0FDjdRr+7hkmBD6DgBb/7O8hC1m?=
 =?us-ascii?Q?FkulpHeqv8mkwu7gjpPeU6CGj9LxUN1hwgGlfAEs+lxaX1NG3S0gJqpYWciW?=
 =?us-ascii?Q?8jPPvc2VPrkvsZRgIkjcNmMtaWuNtT9GCzCCZHcOSAm1Z8OadGb+qH0QihXi?=
 =?us-ascii?Q?U21vm2wTrlt9lTQYQxGVc06+VpxGJcy9kAET3NyNUh/Gpxzuv9WelT5an0Ow?=
 =?us-ascii?Q?VARE5IDxpFCQm1Bd6yFYmSQr7Mg3h+AVSKCK28XaHurkR8eQZZbGh8WKtufI?=
 =?us-ascii?Q?lrtg8uA1Nc5eWiosThgwaBAVyR3+iLIatfBghJJkuucyx7mOWPlubWQH4r+o?=
 =?us-ascii?Q?YeubN4lMysoxOWWPHGEQvwfo55jGhDiUDEIRPoJZA+kyzRwVLl7/J5djkJcd?=
 =?us-ascii?Q?juuW4Ig3IAKPFTP1MBr7RtJH/jOA57HAQvPiCYX40ONXkTTxR8Un29tvpJMA?=
 =?us-ascii?Q?Z6TRriLRaFerDMpjejp1+RBFDwEK5OA2r8iuLXMxUOzCoE5k22JjGhEv/P97?=
 =?us-ascii?Q?deVEMFlBTbD0nVSt2Uw97a0oAe0OEbNIpsFU5uTQZBHAizLtrLIrpj5lSnqy?=
 =?us-ascii?Q?4f+sFhGWHItDy7fDi7OD7ym5O0JIVvBI6gPL2vLfAfSZ94X2cf0y8YVUE2UM?=
 =?us-ascii?Q?m7GzkPbGLHyK9auCvLkCGLyNvhug0uiBsYatymcXLTTUUjL4TdU13iYIykrp?=
 =?us-ascii?Q?2uYoV0K98NVnCdZSh2BFqk3NcI9857V0JabL8G0Pg8ztXSXoSB2ekvoO57bf?=
 =?us-ascii?Q?QBejDBW2GggeJvo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6194.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+E5qs+0faF1d2SmqLMofGDXQUeLObgc8ZehghF/92+CgQnv6udBZIa+1r30b?=
 =?us-ascii?Q?Lm3k9wpEEXiK1WLiDqUMfxqUUntvBoOx2XoLddzbzKE9xa8iJWsGjuEZAsrc?=
 =?us-ascii?Q?3+rhLSFVzcKucyDnZLbjLi0wJbqx/O8fmrRFtY5yiSRfvVjjA/cOQ021KrpR?=
 =?us-ascii?Q?rB12G6lNiU/PDEba9ERB9lzw4TPXgaXp17BUvF0+0pDuHsmGlxyAtunj68b5?=
 =?us-ascii?Q?b7e2UQDLH4NMT4U4LuHNTcVt8AB/oiYrK9GJeuFNVxuF6zLsiFdQdxq1Dm7A?=
 =?us-ascii?Q?zFL+jhGU8d9/Y2HuV+U5NZ8KZUIVc0vik7oHlfo5TnZy4Ib2HXfickM96OjE?=
 =?us-ascii?Q?moNWsm1QaYzsy0hDPO2L3E8rhZrW3R6dwgK6/QcHXbSGbhg5o/DL0RadehDi?=
 =?us-ascii?Q?7bK/oCtWpolnwLc90oSBaTrClVZOFYcmDQW8pPfwhh0uZ0p3DPAvWo2QjcpT?=
 =?us-ascii?Q?hByAbhC82KTnILDWRk0Ah8m7CGLvlVnbniP0XYA3eOUxu5I9R05liujoKdfM?=
 =?us-ascii?Q?zIFwwM61nBxEBcauSKSPHIBhAZrFXXNe2hHv9PgQpNDgZq2O7LFpJilj6wm6?=
 =?us-ascii?Q?jf1KcjfuCFmhi4rnix4z+FZ8ryldNNZnC7x+Udth0lLIeVdLSi4WOX5334M7?=
 =?us-ascii?Q?CXyOj0te4LwjgnAoYKSxxWyL16dF95BKiXAFVR3rFE12CElghrK80Knudt+k?=
 =?us-ascii?Q?EGANf9FrzBclMQJtwao4RgvlHmHReG87L6AIFUT+U6klr/MyQmKLu8WLlJq5?=
 =?us-ascii?Q?Cyf/Y/ARykeprwWyKWPZY8FJE3/8AU1rEd9XQezvIFoudexRLVDXj3KV56Uk?=
 =?us-ascii?Q?0lv5LJZCmH0Crmo2h24Dn+sctF7A2LYIF3vt2J1vknzGoH3qOqAW6KunBnLy?=
 =?us-ascii?Q?1+VZBNn7+Y1RlRSC1gsxt7cXA9oq1pp+gHGKZarYrXcjAFvRGgc88lQEq53c?=
 =?us-ascii?Q?V8vybpBFe1GMlD3s7Kv5jmrNz7DMNRtKNMLPG9rnG56rKD9baBgbmIqOJigG?=
 =?us-ascii?Q?K9nvkbzCCr1esLYAfdJYNMz+C8yGEv+nHjn7Si4LglmdHUXvWrRgZFFikkpG?=
 =?us-ascii?Q?Pf/uJa9PnMd8SHFM7R6iwI7e7OUgldUVz4W53w84ll1ufPnARbU3Cz/oDCve?=
 =?us-ascii?Q?DOAW2ZFvC6I2ypN8Gr9iAfIoE2MdAuePN5LnzO8Ly4/ClyhVOaN17Zm2X3GC?=
 =?us-ascii?Q?bxt80k4YQH/mTOziZzrPVNlYvDzCbWiGNILCWuROei30xWQ8VT+udFPefkg4?=
 =?us-ascii?Q?P3meL6jHgc+Iwsw2aPjGjsuZcDtK7vIHyDoqtmAEHGy++yj4JPHxbqPGMCR6?=
 =?us-ascii?Q?Ou5QPptMmm6o+N5fP4ev2Z/a6NPrzF8cgy3fAXcBw9NCzd6E4A/zgI+9ImMj?=
 =?us-ascii?Q?E3xEUxIu+x8YyuixnyFipaJXnsnlGAVwcfNUrr9uGSDUQHtiJaD1zX/tIECE?=
 =?us-ascii?Q?x71C40F5fC+BRdcVqgqgzZcz4vk4NCYrv53HWux2KBmqSMZMhp7UGJauXAec?=
 =?us-ascii?Q?n7V6ga28SvOAzpgeyNLiOBRkDq5t8nYlHEFdf3Rr7spkv0pQ94ew9meZm5PO?=
 =?us-ascii?Q?GrUTD/G0MuIbeSqiks0NZjnUpNPIeJOajp0u8oKl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a515f2d5-4be1-4791-cca2-08dd7e9c77a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 17:14:24.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3CwqH6PcTDOSfeJ6FL4jkdzEM9iwnGbYVL37IO0eRY2WmXYep/Oei2nwhvYW8BuF3prl7h880UKD00ZvotzOxvo05tv4sCWWp0vWxc/JZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7972
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Thursday, April 17, 2025 4:22 AM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: jgg@nvidia.com; leon@kernel.org; intel-wired-lan@lists.osuosl.org; li=
nux-
> rdma@vger.kernel.org; netdev@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [iwl-next v5 5/5] iidc/ice/irdma: Update I=
DC to
> support multiple consumers
>=20
> On Tue, Apr 15, 2025 at 09:15:49PM -0500, Tatyana Nikolova wrote:
> > From: Dave Ertman <david.m.ertman@intel.com>
> >
> > In preparation of supporting more than a single core PCI driver
> > for RDMA, move ice specific structs like qset_params, qos_info
> > and qos_params from iidc_rdma.h to iidc_rdma_ice.h.
> >
> > Previously, the ice driver was just exporting its entire PF struct
> > to the auxiliary driver, but since each core driver will have its own
> > different PF struct, implement a universal struct that all core drivers
> > can provide to the auxiliary driver through the probe call.
> >
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > Co-developed-by: Mustafa Ismail <mustafa.ismail@intel.com>
> > Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> > Co-developed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > Co-developed-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > index fcb199efbea5..4af60e2f37df 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > @@ -1339,8 +1339,13 @@ ice_devlink_enable_roce_get(struct devlink
> *devlink, u32 id,
> >  			    struct devlink_param_gset_ctx *ctx)
> >  {
> >  	struct ice_pf *pf =3D devlink_priv(devlink);
> > +	struct iidc_rdma_core_dev_info *cdev;
> >
> > -	ctx->val.vbool =3D pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2
> ? true : false;
> > +	cdev =3D pf->cdev_info;
> > +	if (!cdev)
> > +		return -ENODEV;
>=20
> Is it possible for cdev to be NULL here?
>=20
> Likewise for other checks for NULL arguments passed to functions
> elsewhere in this patch.

Hi Simon,

In the resume path from Sx states it is possible to have a NULL pointer for
the cdev_info pointer.  This is due to us not wanting to fail on resuming u=
nless
absolutely necessary.  I went through the rest of the patch looking for NUL=
L checks
and all of them are valid from my inspection (possible to be NULL).

Thanks for the review!

DaveE

>=20
> > +
> > +	ctx->val.vbool =3D !!(cdev->rdma_protocol &
> IIDC_RDMA_PROTOCOL_ROCEV2);
> >
> >  	return 0;
> >  }
>=20
> ...

