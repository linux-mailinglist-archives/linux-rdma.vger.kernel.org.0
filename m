Return-Path: <linux-rdma+bounces-16184-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNuZNxgbe2msBQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16184-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 09:32:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DF4AD869
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 09:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82218300B534
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C966737AA88;
	Thu, 29 Jan 2026 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDSVsBBM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FC32861B;
	Thu, 29 Jan 2026 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674832; cv=fail; b=YxxLL0uM7NBrcBgLusy2ljohzEAcTaMSG8Pc+Mi3i47Dt2lBZjzE/UnOmyE5nh2XgNAprla41l5JVME76n7MR0RyLpUGCtehvElunpH1OyoCQjpNg41uWIlVHZcDQSEdMzoUntyAnK2fO6UXizEi3upihOgY+Cy9ExRA+hQNj7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674832; c=relaxed/simple;
	bh=WI3xoCxFbkzbLV4OOmLMgE515GmDJCqyf/4Bo2bWSho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XQbAiCBxeLSIikLqb5LClrie3qXResS5QYZi+7sLDUziQJ87q4AT4bnN56gomZrkJA/yTNcFITvrqvm4zYJrIBLRNO2pcWMH3CFqOgc1YJALv/eoZKCcjxfqjHSy7F+dmeJTAKqSHx9e/YoFykZdPPqmvNcdJeRnroxYkOIdLK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDSVsBBM; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769674831; x=1801210831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WI3xoCxFbkzbLV4OOmLMgE515GmDJCqyf/4Bo2bWSho=;
  b=BDSVsBBM5fkkjaftuyBxRTpgpIrqR36U04QGzuqx9VXO1cmIg/7DdPSP
   TXPUQEfh07fFdeBJQ06lG22SNCFbdw9sny6PUsalJBw+MiW9YvlDE8DQ1
   eOMZDiX7srWDmY8ZLBucU0zdexftepJ03aKKXCos9O27Ta/zvy+tQS2O/
   l78abj9yC4yazW2nJP+2jCHzJN27G8nkwj0+RA8dAkgzMWdDFRRC0j3lw
   gfSfLTGSsnrKtnzMrzptIEws23fDghMEo4FSCAQHNjhBZXjQ39xp4vmUo
   anjeKpZt7Qf43soXUDEy65aAAw5dhnEuPU6tTTbfQQUqQ684PqA9r2MIs
   g==;
X-CSE-ConnectionGUID: m6HSJmNlTT6NAE0TBTdfDQ==
X-CSE-MsgGUID: bnfzsxqQRwmwSijMJwds9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="74754185"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="74754185"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 00:20:30 -0800
X-CSE-ConnectionGUID: vDR6vsuwR82srDYirEq26A==
X-CSE-MsgGUID: LZVxDJQER1aZuiXnhwE5iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="213012276"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 00:20:29 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 00:20:28 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 00:20:28 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 00:20:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/9sFTwEbQg1vEPHlP95CTD9vSLY6JxOg13UKdZhIEUbmg/o+jpCztP0VZz5Cwv2saLqR63cVVSxKp2iwzx5CjkQmjtK+IVSgkcOjxpoXSHJ9TqO8trdR4dsj8hFQcC0d6w0sqiL6Zuk5bMng1DG3gRUm4WXvTj9WmsdA6xEKhxBDCJKkUuacV0va+HFHbGXA8zAtB4zQG7bDql3kjwt1EH51CwpxCWGvrQ3cICjFLUgWOOI/ZCrQS2eTSs2oK/PKom0+vAAYQQK/od1tW4iNEje64p6SghLG2twB4A6gpie6kSvLVoa/Kn8LAjgfxQ/xsPkBlkCEj569qHuPw+mIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJC8K4xGdIQqNLOA7L+zCnNsGM7DM/5SOEh6g5eDYg4=;
 b=dt56LOwRb7mY+WSrbX/JD0+SFRqiQCBe0bevkP5GlUy9vF8Lys2PtaM7eHjVUpGhBl8jIAFJgsC0iHuQ4f2SjG5h4rXTR4j0IYesUp7TirPrGhmm6JEY9ypwpYMRIhO8j48lN4c0kPaEZBi295HYPS2sws5u9NaocUQfzOLBWLl0au4xG1jiN0O3Kiqsx5ceCHXytaaRWgBHZ1K2ENl/bAG067MI8NqSVlHSwuaazig7Ds9ZkA7/zgrOL8j257IHirZ7jOUjbz+k/qvPGT3AiB0chxDo4EqUtd8MmKPz9U/2+S/8/+yBn0x5Q8/3bd3TTPmD1XcDgpCpAxeiblaqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14)
 by CH0PR11MB8144.namprd11.prod.outlook.com (2603:10b6:610:18d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:20:20 +0000
Received: from LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::f110:9a4f:b4cb:2eeb]) by LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::f110:9a4f:b4cb:2eeb%7]) with mapi id 15.20.9542.015; Thu, 29 Jan 2026
 08:20:20 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "Oros, Petr" <poros@redhat.com>, open list
	<linux-kernel@vger.kernel.org>, "open list:MELLANOX MLX5 core VPI driver"
	<linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next] dpll: expose fractional frequency offset in ppt
Thread-Topic: [PATCH net-next] dpll: expose fractional frequency offset in ppt
Thread-Index: AQHcjuAXbuOWmFPkhUuIAJEneE3FeLVo0i+w
Date: Thu, 29 Jan 2026 08:20:20 +0000
Message-ID: <LV4PR11MB94914ECAC431DCFA6AF952479B9EA@LV4PR11MB9491.namprd11.prod.outlook.com>
References: <20260126162253.27890-1-ivecera@redhat.com>
In-Reply-To: <20260126162253.27890-1-ivecera@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9491:EE_|CH0PR11MB8144:EE_
x-ms-office365-filtering-correlation-id: dd091dcf-7e31-4878-8ac8-08de5f0f3e22
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?RlltxRRNRzGnFyFmh6+v+3yzpmY0JGBmkG300ei0r9OhO71TcJP2mP1kTCOG?=
 =?us-ascii?Q?g8S0c4+LXQxILT4tJIb1rav0CqbVXOaBep3cR7yLBmPTyIWq98turBvgMaLu?=
 =?us-ascii?Q?iAChYJ/JwRCu+vT5ZP8qhwB85uQtNdjsQD4zPL7LoybGLqbdgrwd6sfRd9eg?=
 =?us-ascii?Q?Cf18VFbo++SjC0XSaDgxtCf9kx03BZBn8WTGRfkzC1ONDzgXg36Zs/HJCNiT?=
 =?us-ascii?Q?/GXZ5xZXNU1D24krNgW4WZtriYuuybN/9UPzfFxhsIR99tXrY0Cdlpvlme6Q?=
 =?us-ascii?Q?FSKySClZEAu3Js89HKKVI2SBlgkdmHOIBBb/5aWfWeFxIknfMqoCyxtRfkBK?=
 =?us-ascii?Q?9Vo2IQbVsE8tXjoywe4x9cj3R+02fI6KMhVaiLBiVTW5QR5WTeNnr18Ak/eu?=
 =?us-ascii?Q?lXYiaNCjZf0kCVs4Y/DX7FTGjciyg/U+IsktIVukMWE3vxWym7+vabsJ3vwo?=
 =?us-ascii?Q?SeacjPtZN9gNVjYH/04jXnrlZUW9aeV3TIMYdzHuQB82OAgetFmgl8TQAAG3?=
 =?us-ascii?Q?78CR4IjI4uG0VCVfcwlYi+HkrXhB0WTKRH7vQE57xiXJnVb29WzAtOcRY5LJ?=
 =?us-ascii?Q?US1MAayW98wrkOFAckHNpGgqLIWpgDAhfz4jrYtPrK6Rch19weY7Umw9wZRw?=
 =?us-ascii?Q?ioaQft2FqtZJjdc50mfmi0c1jkG1G2h7OsNaujZdKZKG3wQ2S1/88CfLvMsO?=
 =?us-ascii?Q?O7pVXvuQ9otJV/2Nx3JyKXInY72wK//ykLPP/MYuqAXGRVObJAWSKAYj0vXL?=
 =?us-ascii?Q?RPJSH9LgCFBDpMK+M72xpeqpr9Y8p5u8z4aEBpZLWH0SXfHAZftAxJjI4D7f?=
 =?us-ascii?Q?yT+2kjDr1m+r7gbMThlyB/vy9r/IYPzTYOdN1CGXg3CMjQ3w9vQ/KtlnSlQj?=
 =?us-ascii?Q?QPeu2zUcb1ucH228BE2ccqT0Iw927QUPLu+Xk64GsbjQxxTLcIH4afiFkpuw?=
 =?us-ascii?Q?l+Bx/kvMRxJiquv/B+US2r1GAK910JHije3izhyd4skcd+8owxFnyuOEOC4L?=
 =?us-ascii?Q?u1/ycyWiNksEO3lAe3mYUBBRuMK08KyE4tjft4zueZL64LJ+mrvw3VRZynJP?=
 =?us-ascii?Q?4dDCS1N3BNeVDFK7z3C5VovFIaz5g7P47AJuAb7qUjw2Ax8DN0XaClpi3fhV?=
 =?us-ascii?Q?7R5A06LV8w60Sq95j4yk+WN4dXylR3U5mx/LFiQpoVkFxXMpRTuzCVZQ2GNQ?=
 =?us-ascii?Q?vvt3hL9tESCO3zjzRmmXL2aNX+ydJnu0SKI05TTeTJq8mMrfNA1wEOSPecy0?=
 =?us-ascii?Q?RGT7GvofhXqz4tjO2LZBroHfr3orfWBBotiAZLZGb753Lx8EZ+vjU3ArrgO2?=
 =?us-ascii?Q?8xo0KwvTfih68bGwgyJPrHs2Vq/tbkgAqPPDY/PSkK+jc3vjpbM8iDmUqRJr?=
 =?us-ascii?Q?UT7/LVIQQkeB4oI6hsuT38vWXPHFgAGbvP/baJM7mvsy3cPj109LS86vtR1K?=
 =?us-ascii?Q?xf2cuVrz21eGhlClBfxkv9bhfUU6BP8GAgcSW19+I8ICKK6r2tBKjNztUZhb?=
 =?us-ascii?Q?1mzqelrWpnVUCJKbY+sVYeSSFuHnwsp7lq5T9VeCLYO5PCQMkg3CK4Q43TsU?=
 =?us-ascii?Q?tt9hNqQQuenVvTUkfVbhJGn6gGYbiy2PZC0oYfvUAL9rZxwLsDIZtH0FVawt?=
 =?us-ascii?Q?YDveUy4WBkcMpbfOJ7GvE64=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CBSt4lbm13khrRsV//+qStipaWqDnpN97VdcvbyA8iMML38daRQYtNcYnDBA?=
 =?us-ascii?Q?p+ms3c7U29VVx7cwOc9ygNJ4w9vfitMUpoPYF9/2nb9LQahn5oLSO7SQZT/f?=
 =?us-ascii?Q?5vTX70jkMGyfTqvxR/K7ssDr0gs7aSZ4cDoh65h8wj9boHj1AvxC2NU5AbXp?=
 =?us-ascii?Q?3d8r1nVdOi37wLKTCrvwi2mUVCwMQBRLs7Q6S7FD7tBthIDm56UDANUC1J6z?=
 =?us-ascii?Q?q7ACP/rJ4BzCBGkJFUWmZWR8/O91A2wPQgf3u6MhAx5k6RdCzkMXn7rNVnA5?=
 =?us-ascii?Q?ZFM02PCNV5iQia6iHr2Iip9sL37Cz4GW/7hQLR259LLIV7wuzlQ5mraFVb8q?=
 =?us-ascii?Q?9Cqfq30hRFrLc+5JuLte/elzpCzUm5GtYlnsDAcokgaHEtRJv9ttTe3OuchZ?=
 =?us-ascii?Q?Utoknm3MCg53Khsq1K+tCJT/lRl00u4E3SIy4ZTPQOiPgVFxNuJpirYOcOTT?=
 =?us-ascii?Q?Rly1oKldkZhvc1nuE5a1Zra4n8YYRKDr/VxV8dJMoJymSbO9+KoMqmHI92NQ?=
 =?us-ascii?Q?UDL9l4gafOA19kAnxzplsqk0fCFdT5coc4hgiO1WN15SDVZsmbpquObqgoIa?=
 =?us-ascii?Q?LU24g97eP4L82HURQbVsrUkLOHDOcDygQfxFF9xv2mlNKraWzcXNK1QuMcNK?=
 =?us-ascii?Q?mC8ElVBmzKLzvr8e7WmZOeTB/ZQO2ICNn2RWOxXRrw/0Xd9ylxe6BgR0uloD?=
 =?us-ascii?Q?LHeTHrWlD+UMJBKf1m5+Che6rD0ku9LMhZTZ7OkWuPBGp3D2w35WMeFxzp1/?=
 =?us-ascii?Q?bpbkebV0bH35JCTb02owR0WKlcIvJqj0z1yzknQPAiA1pVWB6514yimgZam/?=
 =?us-ascii?Q?oICVrvKp+JnbZtznYLNhbwlmMp2o3/+kp3vErYUfLl4c/LgALgg8lBP1bltw?=
 =?us-ascii?Q?JFNYGEtAnPa5/zS/zm9u+rOHFSuLkXeO+ti0SCNNOn6bSEbUxY9JTldg4DBb?=
 =?us-ascii?Q?XqYi4afGNP8/LB/Rlgddy8vyPVv7nYuwqHYWAYSekURYxGg3Qfvy7tyMFJpR?=
 =?us-ascii?Q?EWjiVUvfBbvj92ThO8wxbebHeji3G6D4LjK444GOqS6BE89hw5VosAAOMnfT?=
 =?us-ascii?Q?nDY6wHtJ28Oitme2xHkKVrwjPzSgRxQQTwtToFnKOa1ASZ1vpxMrvoRDyc/h?=
 =?us-ascii?Q?hiE9CwJMNTSn/2gatfe5OROfV2ptWrsB66EGJTEkialwZ+0eNEWLGgLlm3/q?=
 =?us-ascii?Q?SgTJbn4KWNZdDdnuyOeWfT6ADcxAtsIHG3fTlrQFyXNPTq3rqvOUeiQLJjqU?=
 =?us-ascii?Q?s81ckbLQdeQwXrNdjnxMRs8l2rwKPEhfJe3LOW8lB32oG4xAHAEv4KRT3Zo0?=
 =?us-ascii?Q?GSGNjz+OGzEKUiTt77A1n2jVCkK1xUKvE4Uby0JkQctJvKNcDCyPGmdJU/XR?=
 =?us-ascii?Q?PzRUAy2HQH10e0z5gfv6Iej62qnx/9lT0ckZJhDVG4ZbVlgzM1rbUj47qf/X?=
 =?us-ascii?Q?/yaxYbaPJIaJFIEN3H23AsDfcjX32ZpIJSCSP4FpnBiCsigrzSeAqK43j+dM?=
 =?us-ascii?Q?s7crNJNN83g2w0Jtq5I57zNcqLGH5TI/wLnMIqA2sPGSNF6RmTXef+xSyg4L?=
 =?us-ascii?Q?XMU8zoIl7jBVycbSTclDcVmkXdG4Xv2O7y+rtOOO/2I7sWHBkG1Cp3/XPtbD?=
 =?us-ascii?Q?6uWBz3v9U2rW9IF250rtK2aebEQSjqBVcnAP/Odb0cPGTfA5q8Ylb/d8ulzX?=
 =?us-ascii?Q?3oH9KZ/ctLY9hlqjA2He2GVoJnPK99UrCF4mPc+pYN7xwkPYgseJ9YK2e62N?=
 =?us-ascii?Q?E6CYdMriqOKd28OOo0HDvQtdQ/AwnVc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd091dcf-7e31-4878-8ac8-08de5f0f3e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:20:20.4166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfFEvuWIc3ia0Bj+7POYihI/J5vPoHxfeANDUuKZY7Tv5mdsX67tf2AIaVTz9MPXZA64i45O6EuvXa3tyv0rLKL41yqK7o8wI2/AoHVAktA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8144
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16184-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,linux.dev,resnulli.us,microchip.com,nvidia.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C5DF4AD869
X-Rspamd-Action: no action

>From: Ivan Vecera <ivecera@redhat.com>
>Sent: Monday, January 26, 2026 5:23 PM
>
>Currently, the dpll subsystem exports the fractional frequency offset
>(FFO) in parts per million (ppm). This granularity is insufficient for
>high-precision synchronization scenarios which often require parts per
>trillion (ppt) resolution.
>
>Add a new netlink attribute DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT
>to expose the FFO in ppt.
>
>Update the dpll netlink core to expect the driver-provided FFO value
>to be in ppt. To maintain backward compatibility with existing userspace
>tools, populate the legacy DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET
>attribute by dividing the new ppt value by 1,000,000.
>
>Update the zl3073x and mlx5 drivers to provide the FFO value in ppt:
>- zl3073x: adjust the fixed-point calculation to produce ppt (10^12)
>  instead of ppm (10^6).
>- mlx5: scale the existing ppm value by 1,000,000.
>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>---
> Documentation/netlink/specs/dpll.yaml          | 11 +++++++++++
> drivers/dpll/dpll_netlink.c                    | 10 +++++++++-
> drivers/dpll/zl3073x/core.c                    |  7 +++++--
> drivers/net/ethernet/mellanox/mlx5/core/dpll.c |  2 +-
> include/uapi/linux/dpll.h                      |  1 +
> 5 files changed, 27 insertions(+), 4 deletions(-)
>
>diff --git a/Documentation/netlink/specs/dpll.yaml
>b/Documentation/netlink/specs/dpll.yaml
>index b55afa77eac4b..3dd48a32f7837 100644
>--- a/Documentation/netlink/specs/dpll.yaml
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -446,6 +446,16 @@ attribute-sets:
>         doc: |
>           Granularity of phase adjustment, in picoseconds. The value of
>           phase adjustment must be a multiple of this granularity.
>+      -
>+        name: fractional-frequency-offset-ppt
>+        type: sint
>+        doc: |
>+          The FFO (Fractional Frequency Offset) of the pin with respect
>to
>+          the nominal frequency.
>+          Value =3D (frequency_measured - frequency_nominal) /
>frequency_nominal
>+          Value is in PPT (parts per trillion, 10^-12).
>+          Note: This attribute provides higher resolution than the
>standard
>+          fractional-frequency-offset (which is in PPM).
>
>   -
>     name: pin-parent-device
>@@ -628,6 +638,7 @@ operations:
>             - phase-adjust-max
>             - phase-adjust
>             - fractional-frequency-offset
>+            - fractional-frequency-offset-ppt
>             - esync-frequency
>             - esync-frequency-supported
>             - esync-pulse
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 499bca460b1e1..904199ddd1781 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -389,7 +389,15 @@ static int dpll_msg_add_ffo(struct sk_buff *msg,
>struct dpll_pin *pin,
> 			return 0;
> 		return ret;
> 	}
>-	return nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
>ffo);
>+	/* Put the FFO value in PPM to preserve compatibility with older
>+	 * programs.
>+	 */
>+	ret =3D nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
>+			   div_s64(ffo, 1000000));
>+	if (ret)
>+		return -EMSGSIZE;
>+	return nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
>+			    ffo);
> }
>
> static int
>diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
>index 383e2397dd033..63bd97181b9ee 100644
>--- a/drivers/dpll/zl3073x/core.c
>+++ b/drivers/dpll/zl3073x/core.c
>@@ -710,8 +710,11 @@ zl3073x_ref_ffo_update(struct zl3073x_dev *zldev)
> 		if (rc)
> 			return rc;
>
>-		/* Convert to ppm -> ffo =3D (10^6 * value) / 2^32 */
>-		zldev->ref[i].ffo =3D mul_s64_u64_shr(value, 1000000, 32);
>+		/* Convert to ppt
>+		 * ffo =3D (10^12 * value) / 2^32
>+		 * ffo =3D ( 5^12 * value) / 2^20
>+		 */
>+		zldev->ref[i].ffo =3D mul_s64_u64_shr(value, 244140625, 20);
> 	}
>
> 	return 0;
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>index 1e5522a194839..3ea8a1766ae28 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>@@ -136,7 +136,7 @@ mlx5_dpll_pin_ffo_get(struct mlx5_dpll_synce_status
>*synce_status,
> {
> 	if (!synce_status->oper_freq_measure)
> 		return -ENODATA;
>-	*ffo =3D synce_status->frequency_diff;
>+	*ffo =3D 1000000LL * synce_status->frequency_diff;
> 	return 0;
> }
>
>diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
>index b7ff9c44f9aa0..de0005f28e5c5 100644
>--- a/include/uapi/linux/dpll.h
>+++ b/include/uapi/linux/dpll.h
>@@ -253,6 +253,7 @@ enum dpll_a_pin {
> 	DPLL_A_PIN_ESYNC_PULSE,
> 	DPLL_A_PIN_REFERENCE_SYNC,
> 	DPLL_A_PIN_PHASE_ADJUST_GRAN,
>+	DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
>
> 	__DPLL_A_PIN_MAX,
> 	DPLL_A_PIN_MAX =3D (__DPLL_A_PIN_MAX - 1)
>--
>2.52.0

LGTM,
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

