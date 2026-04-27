Return-Path: <linux-rdma+bounces-19593-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL4MO5aO72mhCwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19593-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 18:28:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D74765CE
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 18:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0696A312CF79
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB0134F275;
	Mon, 27 Apr 2026 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/LY17o0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032930EF75
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777306202; cv=fail; b=YZ1mR6EROtsGUEm06eSqmArXutiumvZaFtl7gFNxM8rEd9p6sZRYNnlh2U893g5ki/fa2nY2Up207Mj2sNhBQjPU1X/rLSjPzixp8scC/9ibXyCdi7G8P8m5O7atSPRi8ESFGtIx5zhBXVXBgRw160F7jb+HhYMqHmgg5kWM07c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777306202; c=relaxed/simple;
	bh=3smLnV0nM/q3k/Kw3UEuoIHLsQTuqbC+IYP/EuLgVgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dcrlZeWGPxSiWQi6uKDpzE0NdTpC1/wvBBVDBBC3zmWB+EpmFZTDXTMbBQyq+TmBF6s7E9afEu6+ENNKthzjoUlMwJeQiJvGmCEO6YO0RGifWwoCKu0Nkqq2WLcO4hYJ7EwSN2UUeXLW2YO1IGQuFkyDZP7ePR2V4EQIoNeqL04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/LY17o0; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777306201; x=1808842201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3smLnV0nM/q3k/Kw3UEuoIHLsQTuqbC+IYP/EuLgVgg=;
  b=X/LY17o03JNEBcdd6VUhVdMsdxUmhObZxDpcPNgAKpw6XTAqEhGsIkO4
   Pes0ioNgVVUyRXYerBCikubBBJtvRgtFlFTAZPvaw/d+u3pcE0ToYpAX8
   +jKqxQN/KQNLrSlcjkgrxqTmrxkVVvj9Acv/9VnOALECUeNJ3L4IDyFYH
   lNEbwbnwkd1chhf4yAvYw+AYVkLsRncVGfL3KEJOYDlqU2wH2f1EKAR9o
   f8sejgJ7rdoenQuj+sHmrv1eLLGtBffWM9D057wB+p6Qeuyu1hEv65Dmy
   P9RFaOW/8cI94DNRvboG4l4MXqgGRqLSxMJqvj1vXKdyRivHHoy7jvpV/
   g==;
X-CSE-ConnectionGUID: WEVPy+xlRTKXST1E3lo3yQ==
X-CSE-MsgGUID: g5XfnbsSSDuitd1j0gssZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78217797"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78217797"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 09:10:01 -0700
X-CSE-ConnectionGUID: 6nULNJaPShu/MRtTO/VP2g==
X-CSE-MsgGUID: e9sRFjeRSxO4SvjrqD1SDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238667460"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 09:09:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 09:09:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 09:09:59 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 09:09:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRF37GTUHrRqVvZKvFRVL+y7THaqj6mxsHbOJRcakpMmwEDCN9rhUHrQ01CgH0Ss3EDIynZQC38tENqDItm31qj2GjBkJ/kvDfS2BseeLQtvZmlh1NAOve3e0UZJ+B9qf4XZgS+tX+f+alRqESSRIWC9F3xYw3NA5URmbhFVg9nR797MoC4mJFlSVnSQU3/wSTS8KUQkVQmHjocycf7/++VjErS0S5ijYkRVAjaWxWJRLcB4Z+V1N3t64T139zRPNf8UnQ+EB+6g/jmIZLFHXaYI9ORGx5vCcYQAPQOIE4RhYyKjIJcctGb+FnXpjCF1/gmI87wT4bwMAzIFyCa+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3smLnV0nM/q3k/Kw3UEuoIHLsQTuqbC+IYP/EuLgVgg=;
 b=edY5D4Zhbh4IgGs8iAcMY0I8XKsBSH/KYN6razMFZ/qOxL2bbkDwLVk9qHes2hJiffVFy/RUJhQZ9V73ReD4lr05he3oBb3B6ID5OyQf44uA0GENNb8ZXLXuLYV4JXJ5oeJzkQjBpQbPGIHh461+biRD/Fr8dF7r5waqK4Y+kamhakSDyNYeZmoIC0F28lk92qctCxBuu/SXAra2eVRBBIRNFuLjyZ4PEJkOKdPrDQaacgWWeQHGC3VAWRKnCL69QPC5lUSCk4m71VLAvFiP9FH30RT2R1Cst/76llYKqKKG5rM+aIzsrbXAfFHrfFXDeUJKqUQLDkpkMNkeLhaAyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) by
 IA1PR11MB8248.namprd11.prod.outlook.com (2603:10b6:208:447::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 16:09:55 +0000
Received: from DS7PR11MB7740.namprd11.prod.outlook.com
 ([fe80::ef15:dd09:86c1:9979]) by DS7PR11MB7740.namprd11.prod.outlook.com
 ([fe80::ef15:dd09:86c1:9979%2]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 16:09:55 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Jacob Moroni <jmoroni@google.com>
Subject: RE: rdma-core user space irdma
Thread-Topic: rdma-core user space irdma
Thread-Index: AdzRtFOnr3MtxlquT7qKWQvP2MogiACQ3rmAAJmzx8A=
Date: Mon, 27 Apr 2026 16:09:55 +0000
Message-ID: <DS7PR11MB774061A88AD7DFDF4555EFA6CB362@DS7PR11MB7740.namprd11.prod.outlook.com>
References: <IA1PR11MB7727AFB5228A90E1C7115C21CB2C2@IA1PR11MB7727.namprd11.prod.outlook.com>
 <20260424143659.GC3611611@ziepe.ca>
In-Reply-To: <20260424143659.GC3611611@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB7740:EE_|IA1PR11MB8248:EE_
x-ms-office365-filtering-correlation-id: 7fcdfbd6-feb1-4104-234d-08dea4776c19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: L238Ze2w58QlNBgpTiaXciWJ3OVn/jioWqmbSlRPqOhY4fQwEHd1Wltw1EQb2kmSJrPXajpFxNUtgQ+lgRObMfAq3Zz+Fh0ymPlscYXsWCSw/77N2mio605s/sxT0DM4g97hM4iNUvnEI8GT+n46lX25q6YTPdPtMsyWV/PbQtfuq567zBdcBza+w1HkqpUw8LfOhjtAnAEK/cdKQ2rKJd7qKtGbV0i3p+jfrd6ehFUCi7ZE9fD/7DXgCBSrKmAhByw6lt+7J43ZS9UFGhXjmJBV2/rsnRIIuLabThBz3q0LMLDHtNGAzUPdwBbhwDC5OYo9U/1piRfKYeYO+0hA71Fy47mYaCWnzd19Nd919nfhWIqystdJRYvJQE5VegVO+wIHNHw0W1jtwr6YI7GovrbVVjoUpZONLTrr70f3RKZ3cQ4gNmpF666sp4g1s6iiHL9aAWGzsj52OoTdFIqqR4gQZskJMSgMGweYuQBs9xGRbfXihMvd089UWGznukNMgZDxcAUAuFHIpMWvGy7SrigxIeSFVnXNZO5Wxo2KrnVov6QVcPsyzuH8QSznT9oir1iyd59puSrwly7AZoa0nsYnGuuujC0SEIzjselF60st4CZoxFTuTop7257oXuN3T0vKIHhkCnp7np6uJIV4TwnuZ6ijk7odfWaG7o8vZsYpeHistrv6poJJQvzRrZ8pP0RBlDYsL0UaDV33ssGq/oj5pMgi7gheSYPhuM/x63/tapURLPrnULLWTzsFDKPUGSCHrdd/2/HLyC1QHWI7/6DB1abRcKNjy5qiAQLQN1g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB7740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gtOA9G14kNRQeLmvkdhXchEBcC5z6K5WP2kRT77Vnz48+j2fbmtXjBP8AWCE?=
 =?us-ascii?Q?LJvMdlfzIslf5399AAFeBVfnPx3V43VNRb2qjg4lukOmxgcM/Ozds5v0QSnS?=
 =?us-ascii?Q?0GBkL5Ll/SEKDtulYSEdOMIkVv8GX8zodfccGvKgCwCan2FUFV0q5Jgr1maZ?=
 =?us-ascii?Q?cZ9c6k0N/o/wLsEAXwKdR5pEYd8ltfFxJh0IwzvmLH+6fUZfNl1ovPdBtsQe?=
 =?us-ascii?Q?zbhBSOdpndKuAtNt6qluMt0rR9dh0DuJ9xEzaYuuQhzlYDDeYoqO+9kAI87l?=
 =?us-ascii?Q?XqHLVdayCx4inTp4e6aF+XQzRJxKuYdk/ggMNGdhXak6NwiaSWmjDs9WWs0A?=
 =?us-ascii?Q?0lhoTqeZ6lX67cax0ca04SKz6EhkFWf1ZEnN27wijfAu/lAPOsoS0XE8caxx?=
 =?us-ascii?Q?WAod0aC3SiO+214QNbR7hlz+OsJECL8o/Wpzu36DXY+1BG9kjE6vUZgYK62L?=
 =?us-ascii?Q?Hwg2tPnIuuuZfZMtF11GQ0AeG9UkGTlMCf/3xxhprJZshjkcrDhQ+zKNRBBK?=
 =?us-ascii?Q?L7PWiJ8P5YNk3DrwlEawCy1zouOQFeIruZTdR18mfod73l7ePMwO5hjKt0wH?=
 =?us-ascii?Q?SUOp9fLzgW4Cll4uR9rxw4mbd/GbMW2DtDwXt+2PSXT98scHBMEWSNXoklXm?=
 =?us-ascii?Q?7uRdAmRzZP1A5rvKUUWoo8bP5y+AT55raBj5ZGq3octsXw/HPq7cTKvWKphQ?=
 =?us-ascii?Q?Qhl7CApHRO7SOf4Z3/8nkARhI9OuDjTUw87cT8yCfyBXNFdHp4BP2cHRsOY1?=
 =?us-ascii?Q?KL90/ts+W1czi+MxKrKmxCeDO/9iazfka9MI5ar3J+zZGWrgePDIklY2GP4D?=
 =?us-ascii?Q?zimuvCVxzpy4O5ICckKvMI/CbvWl9An5wTYkFJtKGhDPGBrI3e9X/cdX39gU?=
 =?us-ascii?Q?30ujAqhcB1nPTKTOJdaP6ctUSMpdWPp7pUtayl1IJjRaGS5Ldl1ZXYIoyptY?=
 =?us-ascii?Q?RJKjl74tLlGlG/+jeuBqvmg6IyJfDG7K4sHPYEKUO/tl01saZb4FjQd/lKsg?=
 =?us-ascii?Q?PvC/yBsKt603DNoyV9Nau0mGRgcgVt3f8nXcEqAvmplPFVIPvssvAdPj0CF2?=
 =?us-ascii?Q?IUNHDgRdxnOFG4m5CbLQRzWx8n9roWqHDiSgag2aS7tIRto+51VGxwk8TJ/i?=
 =?us-ascii?Q?LiN8lPgrY/p6kXZL08GcV4sgChkPObj+uGF+0hz+4ORAyd+qdRll8jZGdaqt?=
 =?us-ascii?Q?thFFf2mhtwfJvfkhBxUdP3nBM28BOfWXKZtwAks6jBeJJIRhlY52wTPBAQll?=
 =?us-ascii?Q?gkvN0gIQuLLTsWV6NaXPyM+mdMwsTUq/jvIGIhu4xlufAY+GtT84VZ2dxDvp?=
 =?us-ascii?Q?KJVT8lsHKFM3/0wqZWq1LI1gNjekLgWXzC29IFsI+IhcRkI9Sw2z0oVALrDX?=
 =?us-ascii?Q?WcCOOw7WpG9fZW8v0IZOu7okGEeE/YUiHbbVqW+M0SCowESlXVr3g7wJ/SaZ?=
 =?us-ascii?Q?jq4KhPfxhNCzAHcAMiZgnpqY7sO4SQwMa47+TzZvdV/sbt9OZz+60QUhn5yc?=
 =?us-ascii?Q?SwbEQIKN1Kz45NKLdyZHWS6cO9rU6icTetEH4/VcsC7sVk6aFJ9SJFTfcReo?=
 =?us-ascii?Q?wipJw1u4mgpIJycFVbdmsMm6CNRgC8oUhLjGpDeF9HCLzzI3XHC35p3KP8r2?=
 =?us-ascii?Q?Cgxvy3P0R7w8nMzEeIST16AxBaxEwrWPSJtk+LaI2ZvK3hpF6fdEMF34LNwo?=
 =?us-ascii?Q?xaZs/ddPzwuSZNWUkwR9K4Uu72tuIpVoP5fC3JPVlvPxI612sg5QpIw4Lbuf?=
 =?us-ascii?Q?Pgh5CdyLqQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VQaAtKqH7IQOCwDcqIihabzw6zJVwh65R22ujlOMUoT7f211B1eZn+wbXeuY47D4u09jPjkX4dFc9FkGSJ8XkerbK28V7MFqOI3heVL/WWFkRbZyucLjXtJTXnKTKoBcTQ+BUGJFfu6kowDEHi4GL9OOEFuokWhcpbq3DK4N72DlPb1yrtq9m3CFNpsRlNJytnkqg7jyzefRt5nYzqZM/UeUqQmSy7li9b/XisVosBQVt+GEK6Wlp3e0UiQtH2mXGSyP/sUHadJ7D6/oZqN1Pll85H+Pqhp9g2V48RDgpShBqT7XwTYM8pZb/lvx3Z8wVBSi5Jc3MW7qFYlZkT7agg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB7740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcdfbd6-feb1-4104-234d-08dea4776c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 16:09:55.4418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtasEQ9MX7Z3c6rZyIg0Z9ljSMxkkz3DyOlJHPGqZBTBieNVg5snWMV5S5xXJqwUWRdlEtpFao2VQOqMvXc9qODSYAqmfyzFRGu16igZCJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8248
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4C7D74765CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19593-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tatyana.e.nikolova@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, April 24, 2026 9:37 AM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: Leon Romanovsky <leon@kernel.org>; linux-rdma@vger.kernel.org; Jacob
> Moroni <jmoroni@google.com>
> Subject: Re: rdma-core user space irdma
>=20
> On Tue, Apr 21, 2026 at 05:32:50PM +0000, Nikolova, Tatyana E wrote:
> > Hi Jason and Leon,
> >
> > Could you please review the irdma user space PR at
> https://github.com/linux-rdma/rdma-core/pull/1640 and provide guidance
> on how to proceed with it?
> > I have rebased it and the required kernel patches have been merged.
>=20
> Is it ready now? I admit to being confused what its state is over all
> this time?
>=20
> Jason

Hi Jason,

The PR is ready. We have been testing our upstream irdma driver with latest=
 rdma-core and this PR applied.
Regarding the PR state over time, it needed kernel headers when it was firs=
t submitted, later GEN 3 support in irdma driver was merged and the kernel =
headers became available.=20

Thank you,
Tatyana



