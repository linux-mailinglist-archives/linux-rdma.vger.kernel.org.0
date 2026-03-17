Return-Path: <linux-rdma+bounces-18250-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB/vIONGuWmK+QEAu9opvQ
	(envelope-from <linux-rdma+bounces-18250-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 13:19:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30262A9B5E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 13:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3268030C1C01
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DACB3BD629;
	Tue, 17 Mar 2026 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W214ypAu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B603BD25C
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749668; cv=fail; b=RveclZ5AODTse+1u8arSVHOz65dAIvw22EV5+veQoxLm89OXPDU5Pminv+hBQQMUQL12t43H1RoGs6jJrp/Vfkh0qUfPJybqAVYTO9K6djs+pfHnxl8Uc3G0ekQ+AbPhReF0dTG6uE65ZHKIY//ktmUl1371LEx/cN0t55E+u/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749668; c=relaxed/simple;
	bh=Jk6YvpIoDnbL0awN8Oi9gulv1NIh7A+JffcN/SxklDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L5EQkAHpY6bLMBy8cYSyggnrSeWySsbFUoVnohCuAmE+x3RaGVWDdbaS6MfzLj+zDZR1n3EQWqNAIa6I2+1WLNIsYPZxmZ2gpKF/Rzu/uvLjEZBDcvpyZSsIPpj7wtGfSnToZdPh3q09z9HpQUVZp/vRbCHTfNkDe4x3dKFZm3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W214ypAu; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773749666; x=1805285666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jk6YvpIoDnbL0awN8Oi9gulv1NIh7A+JffcN/SxklDs=;
  b=W214ypAur75F7/jsx4Cp2AJGG40aqWrAJTmSu2PO1J6yeu7xPTqznhjK
   fS58vBrsKdY+AjlD2CmIwfFXhWvK9MiGVMjBuz9HNisLMLDkUBeFmKUUh
   MEKfceX7RHXUHOALmVMMnZoWzLPzuud4Ge88VRInkiYp+ZJ9U1+P8ikZB
   gi034N88lT/N+MF7zrJP+fwbTw8xebWGvDjr/Exb6mAa4vELkvn90lPGt
   jUbHBJbchJLw7Alr5snUHwtDajRRrYiWrcxctItYWmqcQOEVtjFdFOvpI
   KkDMgUXxA4q1lT+XE02J/8ZjJFPVndivLMcB/oW9dDIXs+VC+mrsIMYcR
   A==;
X-CSE-ConnectionGUID: qRbwjp2rRFS3esKVbKip7w==
X-CSE-MsgGUID: tAFOguO5RNC/cAcXZSspJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92162987"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92162987"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 05:14:26 -0700
X-CSE-ConnectionGUID: DBVq/PdhShawc5EdRVOHZA==
X-CSE-MsgGUID: SUYsdPScSdSFg+Lnzd7FiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="219752639"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 05:14:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 05:14:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 05:14:24 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 05:14:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlzE7LM5NsEWjeD+xutHt0mlJ0cT+I2FTywQICZWjY39IOra5o0Y1UFmL+/edew1jQg9Iy+CltR4a+M3HjAo9VGDUK2c9N4OPxTMQkXUyi+n6w/03LRafnQHx2HbZTP3l4am9oYmpF+x2FkQ0mcwksK3KkDKxFw/vXCadkx4PcsGIWAM5Weov+ChYsfOLMhd9EnFXix97ypN6gpG3odTHUQYa/zd2s9qG2yUSDBYlPm3Z9h/gK85Q3JZ4XlYTGqI0GCi9QXQf0LhUoFk8zaxivesSYnRcqc/IlIr697x/qXM/uQNWnM5Aq0ASbLXpnn3ary/YbGgYQTqGETZo5tCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MxO9lLPCEjeTuvMw0Z2nzFn0XTWPF9FG6lwOp4iglU=;
 b=QBeP54KmEq6bPzVVC1PCSfI3TEDFMzTHlGuhZmVRCWzINTaLtoyP1Vaz+n8jV4Q6UXmBnHBC88qZLsqUXudW5P9/yHemBwq+y9tmxqhFZ5ljWA195MdQiK05Y85PVhVYU/lieFaeVPQ5pqL09SlmWX2MZly80d3/JvDltauFglBtgt3ZWynku0y6TR2mOEnm/QYdEVoDB5XIS2acpBqCWbiIsOMEgyq6exaJGsMPiwyzJde+eEyj1L7b0uDnswWotcEg8GzbuDqmVeaVi/9LDoApIYTYbgWaG2IPO2+Jfz2S4J0weVg9GSrys+igSY+RKFN0dllpWE6E4bWT8044zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) by
 SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 12:14:21 +0000
Received: from DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::f7c7:f271:a7b:7a68]) by DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::f7c7:f271:a7b:7a68%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 12:14:21 +0000
From: "Czurylo, Krzysztof" <krzysztof.czurylo@intel.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>, "Czurylo, Krzysztof"
	<krzysztof.czurylo@intel.com>
Subject: RE: [for-next 02/12] RDMA/irdma: Fix data race on
 cqp_request->request_done
Thread-Topic: [for-next 02/12] RDMA/irdma: Fix data race on
 cqp_request->request_done
Thread-Index: AQHctXRt43rUJ0TzJEqXIPxjmI4k97WykvsAgAAKP5A=
Date: Tue, 17 Mar 2026 12:14:21 +0000
Message-ID: <DS0PR11MB7736961A569FE56FDB09631EEB41A@DS0PR11MB7736.namprd11.prod.outlook.com>
References: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
 <20260316183949.261-3-tatyana.e.nikolova@intel.com>
 <20260317111230.GW61385@unreal>
In-Reply-To: <20260317111230.GW61385@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7736:EE_|SA1PR11MB5900:EE_
x-ms-office365-filtering-correlation-id: 208b968a-50e6-49a9-45b7-08de841eb88b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|42112799006|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 9vajNwpiONHvl1RAtrIACqOm5UOvYzZ2lhC7nhlcDf2nhBL9BnR6gpwznhwdgSOAMmEz5Denv1DtBACxtluTAIOSaTRoQR9ltmAtd1GXHaXw97pTB+tcwOvSt4pUBMxDSOnEROG74tR+nclImm2MM0EG3G7CvOUYXCAtBHSbiWVbbGhe8o4Xq7437CfrrqOCIyuDe+q71fAge/cYnfROXZGPDwwH3Qq3SixBbBByAQgJzFh1Ttqa1l7Bo0fb4PHwJ1pjA2aBC01FupqszfBrAIgPNpRoap21BsG3txa4IZTcv1i9ONER6us+Lom8WrMyaomdfHUGbVkho/arwpreV9JR9nQt8Xgde5jZKh4pO+zpg6t73sH1WOZ1o3EGE3wz8JudF++EKMxW6dkzAqa416gupjWsyQ3mdZdX7njY79vJo+Ss/uKK6qe5LnWD3dQmbfgwEW+ocLLrvWe3iW6n8994eVpCtJ70cfOExfZu05fRx5anx5stXil21eSPM1mtNHIhmZZ2rGdF55PQJXZ5WKFfxk4pvV+KgT9em7N40U1xiG5otjpDLF3mzA+eF1gUpSSV75Uv2uEbSdLouPDMcvqSIyy1v0GNZOPz7hnu0bGR1RtF5+69JJod0QuI+8S6wQNsRFI5s3yeUx+DsuvLmHb/yhbPugXVZCGNBPmp7yP+c99pdJ0jJ6+/piA8tre9a+PrtrK9PNAsQkARGRMcV75tg1HJxRU7hshn0npn5R9ggvVBs0WkfvLbQE7lHpn4OWl5ttYCD05fvpAJq9PGSnRUPLX5Z37R3dytfu2oKq8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(42112799006)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n1FKyqa6ZXOVDUNXAoSmcce4YZ9E8/dhiSCauBcRj3+ivnET7ibv2mQz22Vi?=
 =?us-ascii?Q?4JGSWQjawBn0FuloPJiyZE/GKcuSsizUYbZ7Ly432BhfQMJzH9RLUGIgSffZ?=
 =?us-ascii?Q?ztzbyNw5oDxbL1HJkjsMEQJQxTJ5kiLrq0ETRuLNl+9c4wxf5Eh1amJ6reO2?=
 =?us-ascii?Q?l+oqJy11cSXHnB+dYukScqXxqaSm6n/xkjJnSMzUubaKc31g1qZLkiMakVk+?=
 =?us-ascii?Q?eqxtzhUie4z0JaKkOCwDeD7my04Ln9T03F9znwzy81HL72Wldxwe/4mgdIqZ?=
 =?us-ascii?Q?tgHzDBCfY+WAXgj0nSuj1axAcOtaudNot7z0/oTrhEI23utT14dn4EpFlWHR?=
 =?us-ascii?Q?6SR80GtKA4AF9lcu6Z+PinLsIEhX6+I4fJbxSDXd1iilRJWpIukhoSKYNvd4?=
 =?us-ascii?Q?KHhCXVDpOwgxwc8vHmDmFHglfyXuEsvhTgIx9Tnq3yqOz+oxUsfVLZvVXpZW?=
 =?us-ascii?Q?0sG61RdKW7dFgKnKHn+YqaR4PFAnrFGVQaMWoC/oELarq+yB9wJDtKERH6q7?=
 =?us-ascii?Q?kZTIbSe+YiWaZASdhlIsQ0yxgQv6xkKnuNVJc3AXr+PAy+Pc2G/7B1cEAgde?=
 =?us-ascii?Q?PypSqLw5EN8Q2y+2NloZFzcjcuKuPg330c3Vr3dpr9NZxlfL1zAPb6YchUp+?=
 =?us-ascii?Q?PFH+Dvm2We8ZtDLZ9vBdanMdfnfYyo17tosI+MBmE1k1jI3QkdVkl/GKjMy/?=
 =?us-ascii?Q?mI+nS4mgJDurKABQbBabUX6tE1Eh32VpwoLWQ12xvgbaSqiCrpP5rujuRYqi?=
 =?us-ascii?Q?9Sw6l0rbYL/LAc4cKzoBRre6BI7ZOlqrlIw7Bw+WBkG3h/VbywHIHJBWle0q?=
 =?us-ascii?Q?pfSJ8oQ8XW35dsdn+s/iitgpgbaJQcdmk5i5dbRks2fPc/WDwfP0XPKtGyJM?=
 =?us-ascii?Q?L5IfxXQC36VYvqbc3Hdbt2m9S+Jk0SVdm3exdolesEOyZypNeJgg1H7g0JXT?=
 =?us-ascii?Q?OM9T1RWuhiGLAxoYKNmE95VmcXi+tQZcHkBOuQ6EzKjpVZkoeT2heHj8GbiN?=
 =?us-ascii?Q?KgZDNZe9Unz908qXTl8rSOAqN1SOEeJuU4cbk8A89fPsh1D4YHQ5liD7R8F8?=
 =?us-ascii?Q?vuVPI6kN+GzH2jxga3HBfJ10LywgAUh2DbJe4nL2Qy3Sd863AvnAvoJXI3pR?=
 =?us-ascii?Q?IYxAbEob9AJfdYbwB8Sk5PSNhIcwQGUXlyJTPGqFL8A2AsHRUEJ2W7x3o7gJ?=
 =?us-ascii?Q?+Ie9ETZ2xWspohEXyq1ODA9kwDKI+sJk9htk9EP5/JNP93/92Q81r/CLOnf8?=
 =?us-ascii?Q?uUf4StScC0pyHvVUZcKmcLLeIMUsIxFyaibXJjIH1eoATZdo7T/6kVaYaQqJ?=
 =?us-ascii?Q?tCQOxG6VjYTi5qi4hg6LgdS0Xm74lYGixNS4aJTPAobkF5V6qKkasVuXL0TP?=
 =?us-ascii?Q?dT0G1J7yZOgQZKtkvyh68NgCYFJwT0n9dWTgEMSrh8CFSv5fdbsaqTsBq9nU?=
 =?us-ascii?Q?sELMMms9WL04tn68FlvvHHlPiBkIeQn1UWHmARg0e3cVFgqKA76zB7JF/5X/?=
 =?us-ascii?Q?uoT+Lph+gztTYoe4emvadPMLzp/EGhFVKikYwyW9wzfEjGpj9FUYm8arQMEk?=
 =?us-ascii?Q?DBiNovGF4A5Uv3KL1SZBLvTFzJ41BjMfQrn/fa9eQfgwW4qwpc2jrozNkSgY?=
 =?us-ascii?Q?wjAkobt4G49RcDCdyUvsgydnZWPOjyPA1iz6KieWJ8DmzaLYnq88lLIbo+/n?=
 =?us-ascii?Q?RNd/ono+nxHOovWDlyS99/m/Eosv6TDO38cSdt5xmvWdM6c3i2IUZc5PnL4L?=
 =?us-ascii?Q?Em4HdFoJyw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: we7bLKpdpmJ+RVFqSLwKH0pyfvDbElTsZZ7nfY+7cLQsK5+VgyUxyuDW1dsoytsRMeZ955zEdSncY7yWXrdbDb5/K3myKgkcxeI4SJn3N3Ujvr7gxFvKXEtMrGtLbNujztjzbGkM7S0z/cLM99fX0AWdgPR7eBBYQYOKBCqYhtJYjVb4mVk/8GYqG1MQeNV0FsiOHG/5MyUip6MSoLECvJQmQTRmEG/zPcrF8GJ8P3zdh6eLkC3uI9Fdx39IDAB6Rs3wstTlRxgkSIgxJk6TIHGmJIhhcbvrDZDCp4BrO1ysinXxhg3xR3GBuY8gG0A/PpATgf54/ElMDo6NtvAQyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208b968a-50e6-49a9-45b7-08de841eb88b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 12:14:21.2452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzEx8ESpsS6WIvYWt5TTBIHdzwHS/HDRMzgqvGa6z9BMnVQeQIWZs1SSg9Q7AAs/5dM7EBksIVKitLAkqXrKXCkuEfZu/ujG0YOIXoXKSws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5900
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18250-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.czurylo@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C30262A9B5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: 17 March, 2026 12:13
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: jgg@nvidia.com; linux-rdma@vger.kernel.org; Czurylo, Krzysztof
> <krzysztof.czurylo@intel.com>
> Subject: Re: [for-next 02/12] RDMA/irdma: Fix data race on cqp_request-
> >request_done
>=20
> On Mon, Mar 16, 2026 at 01:39:39PM -0500, Tatyana Nikolova wrote:
> > From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> >
> > Changes type of request_done flag from bool to atomic_t to fix
> > data race in irdma_complete_cqp_request / irdma_wait_event
> > reported by KCSAN:
>=20
> Again, this fix is wrong too.

Could you please elaborate on what is wrong with this fix?
And/or suggest how to fix it properly?

Please note 'request_done' is _not_ a bitfield and we only do simple
load/store operations on it.  There is no RMW.
Despite this, KCSAN still reports a data race on it.

Honestly, the original idea was just to change the type from
'bool' to 'u8'.  This is enough to silence KCSAN, but it is
not clear why.  Perhaps it indicates a bug in KCSAN?
I mean, maybe the report below is a false positive?

Thanks

>=20
> Thanks
>=20
> >
> > BUG: KCSAN: data-race in irdma_complete_cqp_request [irdma] /
> irdma_wait_event [irdma]
> >
> > write (marked) to 0xffffa0bef390ad5c of 1 bytes by task 7761 on cpu 0:
> >  irdma_complete_cqp_request+0x19/0x90 [irdma]
> >  irdma_cqp_ce_handler+0x22d/0x290 [irdma]
> >  cqp_compl_worker+0x1f/0x30 [irdma]
> >  process_one_work+0x3dc/0x7c0
> >  worker_thread+0xa6/0x6c0
> >  kthread+0x17f/0x1c0
> >  ret_from_fork+0x2c/0x50
> >
> > read to 0xffffa0bef390ad5c of 1 bytes by task 28566 on cpu 3:
> >  irdma_wait_event+0x242/0x390 [irdma]
> >  irdma_handle_cqp_op+0x93/0x210 [irdma]
> >  irdma_hw_modify_qp+0xe3/0x2f0 [irdma]
> >  irdma_modify_qp_roce+0x13df/0x1630 [irdma]
> >  ib_security_modify_qp+0x34a/0x640 [ib_core]
> >  _ib_modify_qp+0x16b/0x620 [ib_core]
> >  ib_modify_qp_with_udata+0x3c/0x50 [ib_core]
> >  modify_qp+0x6e1/0x920 [ib_uverbs]
> >  ib_uverbs_ex_modify_qp+0xa6/0xf0 [ib_uverbs]
> >  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x16c/0x200 [ib_uverbs]
> >  ib_uverbs_run_method+0x342/0x380 [ib_uverbs]
> >  ib_uverbs_cmd_verbs+0x365/0x440 [ib_uverbs]
> >  ib_uverbs_ioctl+0x111/0x190 [ib_uverbs]
> >  __x64_sys_ioctl+0xc3/0x100
> >  do_syscall_64+0x3f/0x90
> >  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >
> > value changed: 0x00 -> 0x01
> >
> > Fixes: f0842bb3d388 ("RDMA/irdma: Fix data race on CQP request done")
> > Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > ---
> >  drivers/infiniband/hw/irdma/hw.c    | 2 +-
> >  drivers/infiniband/hw/irdma/main.h  | 2 +-
> >  drivers/infiniband/hw/irdma/utils.c | 6 +++---
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/irdma/hw.c
> b/drivers/infiniband/hw/irdma/hw.c
> > index 6e0466ce83d1..3ba4809bc1ef 100644
> > --- a/drivers/infiniband/hw/irdma/hw.c
> > +++ b/drivers/infiniband/hw/irdma/hw.c
> > @@ -235,7 +235,7 @@ static void irdma_complete_cqp_request(struct
> irdma_cqp *cqp,
> >  				       struct irdma_cqp_request *cqp_request)
> >  {
> >  	if (cqp_request->waiting) {
> > -		WRITE_ONCE(cqp_request->request_done, true);
> > +		atomic_set(&cqp_request->request_done, true);
> >  		wake_up(&cqp_request->waitq);
> >  	} else if (cqp_request->callback_fcn) {
> >  		cqp_request->callback_fcn(cqp_request);
> > diff --git a/drivers/infiniband/hw/irdma/main.h
> b/drivers/infiniband/hw/irdma/main.h
> > index 3d49bd57bae7..e22160e2ba33 100644
> > --- a/drivers/infiniband/hw/irdma/main.h
> > +++ b/drivers/infiniband/hw/irdma/main.h
> > @@ -167,7 +167,7 @@ struct irdma_cqp_request {
> >  	void (*callback_fcn)(struct irdma_cqp_request *cqp_request);
> >  	void *param;
> >  	struct irdma_cqp_compl_info compl_info;
> > -	bool request_done; /* READ/WRITE_ONCE macros operate on it */
> > +	atomic_t request_done;
> >  	bool waiting:1;
> >  	bool dynamic:1;
> >  	bool pending:1;
> > diff --git a/drivers/infiniband/hw/irdma/utils.c
> b/drivers/infiniband/hw/irdma/utils.c
> > index ab8c5284d4be..f9c99c216a2c 100644
> > --- a/drivers/infiniband/hw/irdma/utils.c
> > +++ b/drivers/infiniband/hw/irdma/utils.c
> > @@ -480,7 +480,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
> >  	if (cqp_request->dynamic) {
> >  		kfree(cqp_request);
> >  	} else {
> > -		WRITE_ONCE(cqp_request->request_done, false);
> > +		atomic_set(&cqp_request->request_done, false);
> >  		cqp_request->callback_fcn =3D NULL;
> >  		cqp_request->waiting =3D false;
> >  		cqp_request->pending =3D false;
> > @@ -515,7 +515,7 @@ irdma_free_pending_cqp_request(struct irdma_cqp
> *cqp,
> >  {
> >  	if (cqp_request->waiting) {
> >  		cqp_request->compl_info.error =3D true;
> > -		WRITE_ONCE(cqp_request->request_done, true);
> > +		atomic_set(&cqp_request->request_done, true);
> >  		wake_up(&cqp_request->waitq);
> >  	}
> >  	wait_event_timeout(cqp->remove_wq,
> > @@ -610,7 +610,7 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
> >  	do {
> >  		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
> >  		if (wait_event_timeout(cqp_request->waitq,
> > -				       READ_ONCE(cqp_request->request_done),
> > +				       atomic_read(&cqp_request->request_done),
> >  				       msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
> >  			break;
> >
> > --
> > 2.31.1
> >

