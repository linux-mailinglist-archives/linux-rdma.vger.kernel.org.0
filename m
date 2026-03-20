Return-Path: <linux-rdma+bounces-18433-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGwyEEv9vGn15AIAu9opvQ
	(envelope-from <linux-rdma+bounces-18433-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 08:54:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B55392D6D9B
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 08:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38675305A411
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 07:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9621C40DFCA;
	Fri, 20 Mar 2026 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4cBsicw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096631F9AA;
	Fri, 20 Mar 2026 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993275; cv=fail; b=rZSUZd3JbJm49TcGNAgmj7wipUg+019HURykZJnlOjfn4NkzV6tFzG/IaoPR+q0TDY14Jt0fBAwInsh7aI5iLHUjLCK/hGB9vp78+/b2YT18v5OWYeItRVHzNihJWBsAw1mkE5Kz5iiAYGZpZj6rf+b2VzJTUyxpvOtG4bhSs9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993275; c=relaxed/simple;
	bh=1tlWLM7cdQjxZkXEONQOD3jMl+HkuxcRUYMjnAwSPOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fBOxxwN5gNkO/5GC8xdjIQzF3iJN3gxfxSdpgzsCqvq9abfsDgl1fPPmA6UJUjm9Bzl4a17mSzI9XWav0NqkJdrX61KERCehDLu55PXd0q8tl/tcoxeobm2JryqPGn3vZqbnRXvfWwdlHzNrd0IIAA61NM/Wki/RzztL6Y3wlXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4cBsicw; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773993271; x=1805529271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1tlWLM7cdQjxZkXEONQOD3jMl+HkuxcRUYMjnAwSPOQ=;
  b=a4cBsicwoP4slN8bU1eeatIl5k9snZp+7FdSXMWg4TYw7Hx29NDam5IV
   NI0y+tOooHtTbS9L1S3B5m0KwNcz0xq9OPen0+iuhdt6r/BseeV1Ev34c
   qT15yCwHnVC64NJPzJoMzoNp6yY+lyjIdAMljzjco7oM10UnjdHa+92wv
   xxQgMfd4KBdA/lfxOnMUgLJ4J0OAJKVQt2thWCdnWVLv4rHROUow6q0q0
   ynXpzA4B6YsHPWYLUGILBFg/LgNzOGvZPKw9jPBmvwCPjS3SBWOhNixhV
   60cf/VdrB5IXSy23kjFy2/UIQJZp72ghyR24v9wY5+VQjdiLHv/eAS8AD
   g==;
X-CSE-ConnectionGUID: uXTA01eOSayzmvO+VA1Hug==
X-CSE-MsgGUID: jzcspL4uTQiDBgqPOX73jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="78933357"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="78933357"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:54:29 -0700
X-CSE-ConnectionGUID: R7U2d/dLQu+AJoYJ69GJVQ==
X-CSE-MsgGUID: CdR75OBjQka2GxKEERq0cA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:54:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 00:54:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 00:54:27 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.62)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 00:54:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3W4u8PNkDDQLX4P7N+dm7hdz/ooV2lrq8XfUfh5Lc9YbP3ZuSUsOkZjUiE/Xs3lyqFD/bfoOqwsFizqNGW2acTROdPJkNCmTX2qsTXtm7K0DvkneGe6s9spMzu2VExVFNBIC1zBu7xRd58wdWoxg7JDQc2/ZPMClEZ1Fb/4d6tGuT3BY3ZvcnkY4Rj+8U/Sg374PKeG1xj63c/iycQ3CFS2XjRmfytyyK0o5qYt3G2ra8GOW4ELT1ZFGSpRJxGPhqfuIdL8mnWs2bMQnGD/UcrpWQ0U6IbArLF8R2k7RjrQgrIpqmPoAY8ef5TvC9gWvm4xUTyOPrOvu9G2InlilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBHAWUo2bV3UNFTxAbw0A8MhT8704zieHXf3eSAENto=;
 b=QBjDeP0krG+V7DuV9ZgOItX+CRPGNKq2Kxly4xW9OOP1o3He2i17FdDSkXNHDPrRNffZh7UnniCQSV4m3gXfCLIdiFSZFYfQBcBStsNXAyB6ZUChrqZQLssPv9o1mNYIOqrr8hl1WvNz/b3dh3q+W0eZcxHbuwr/r/yJx+qF+qizm/lXZAJV3RVKE7vHYbOFNCnNbCa+YeERcFy+a+m5GEDY6uU63mzGZe41tO2urTGzviehwHLFzUOZTa/qgFxrbNe0En82plyTvTEPt0EEzj5/wuSEWUg8d/rMWmklSHEVSK2o8pHenzAqB7fB0v+JZTJ75B0Imxfi73Y8KvG5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB7938.namprd11.prod.outlook.com (2603:10b6:610:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 07:54:25 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Fri, 20 Mar 2026
 07:54:24 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "pavan.chebbi@broadcom.com"
	<pavan.chebbi@broadcom.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "mbloch@nvidia.com"
	<mbloch@nvidia.com>, "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"jianbol@nvidia.com" <jianbol@nvidia.com>, "dtatulea@nvidia.com"
	<dtatulea@nvidia.com>, "mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "willemb@google.com"
	<willemb@google.com>, "skhawaja@google.com" <skhawaja@google.com>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>, "kees@kernel.org"
	<kees@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
Subject: RE: [PATCH net-next v3 11/13] dummy: convert to ndo_set_rx_mode_async
Thread-Topic: [PATCH net-next v3 11/13] dummy: convert to
 ndo_set_rx_mode_async
Thread-Index: AQHcuAhxIgwNsHlDykeJ2WPIce7jKbW3DV3w
Date: Fri, 20 Mar 2026 07:54:24 +0000
Message-ID: <IA3PR11MB89868197E2482701583AFF6DE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-12-sdf@fomichev.me>
In-Reply-To: <20260320012501.2033548-12-sdf@fomichev.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB7938:EE_
x-ms-office365-filtering-correlation-id: 171a6f0d-1940-4395-a805-08de8655e788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: BYkWAZQEvX5cRzL/AYjE0Tz+QlGJ3E7xwoBWbmoyZAumnyzCEpvefvTy1PvEREca78vsv6ds8TxOLCG0uqo+KYByWdHgLT5HPa7I8BK8NiohTp9Ku17eLux4eEarM1QMBPVCMgWVmMX13/Jt5k1h88n+i2pp4CjrPu7r9Ztone4SbZs58JmfhBY5F6LIXEhObUYuJAcLAfUhADgRIrGn0J0P2JxdSI5E9cxG9D4Rl3v/eZqdEcnrkC7awOLyUNAFFM7PgsD4qL/EVpsmcuHEGqj7EqEnJbUsIpmWCRrHWO0K18CUu0k+Jp0NokGi8V0+QUonQ3u3tGTxH5mrzxWNW/GZc58UWlS2Uuh3cY2c+vN6WDl6X3BuBTkNwXD82ccsJKwq+knUWVHLbqHR0ywEWP6Y/ye7XIXxfgElhjNMOc5t7yzezZHEI40qPXVKNaXh6TJKiVE6IdUvTZbI5nCNTfD8dLES8sU6wjQkRQvfUrRLZuCRB1CbopfZfS5yTErNCSoiSIreRzm+2NBiM8EP1DNvYB2dqOFRVaEevwd8REiHafgwfb3mNNQYPghfGLoxlrZQA1GcjfpGkggLi/LmBAn7OaGszmioFJXGhSRgODAznN1SSjgDuW1kq6WWiIPBtgoEbE+994ZOiCoMUgbwzNmgMyZZ2l5SjvE0nm1mTMkrznGM034+yIvLhnXjxYUkCOYaxJfR4sZrYHfsdEtXOFth5JmCTifAmpQbbamlQWyLCcCYYHby+V1dpD6lmMr+cpM44G8sPWop9nTlyHcSRPv5JVldSRGRYVjj6x75ri4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qiTp6cNEj82NT5PG7fo/mtqhv+8P7EJh5weQgrTkP1wmG5LKwvdeZXNQa21G?=
 =?us-ascii?Q?9BVIUNmOi2nw9dCvp9WpOpLPd1QLp5PNrbWJowa3WB1j0rLnnM12Tutk0rsB?=
 =?us-ascii?Q?wqPpzMOpzAOvdfexhFrI+YEHXrOovbF26DmBSQ1pmycZLXdCKANKQMA67nPj?=
 =?us-ascii?Q?9iJOpuZb9Rn51cgOVHF0tCqMtzhmqlXVY/rimRAOqIs/KyEi3ZHm0JccP6jS?=
 =?us-ascii?Q?0KPTiUlA63Do0zEMAxnxFzPoFie+bnzx1c3BskPMSqfoSHY8ZKdu3/gnPl+l?=
 =?us-ascii?Q?+XQUX6u+0oeDREEUYfWmkLEAqkhnvP38KA8yw69apkxNCwdZ5hRfk803d9yH?=
 =?us-ascii?Q?8jV03JULkpDDczEhCgzcj2hyZeI6wtZzqOgcADSHxRTWqv0SvrkRqFP90TED?=
 =?us-ascii?Q?9n/kDr05iaAfB0iV49OV7/EllrvRRU4i6Jvxu9oKvY3kxMPo95bcTp5PNn3K?=
 =?us-ascii?Q?k9If/BRF8/CX4lBdBglQqAPB5Xuu7txUkjGIArlPW3Jsu+ZVxEXbbgIhnjA4?=
 =?us-ascii?Q?PVXQk5GmSBVHqCWcB5VX/usAZv3gz54R7HfUBM81RT9LU1rjsqw4PatsgKCn?=
 =?us-ascii?Q?0IH1TdFxZEM7uBAWWIlunI1C6ZKNrwgEGcG4G2U4itCfpdGylnQuJUbVgA/m?=
 =?us-ascii?Q?7EIpPZ0D0KMp9NwZpCkPtgQhHkfES4VotbMv2Vf1bYF/iGriKuumjljqrIzK?=
 =?us-ascii?Q?/APrQNEH6IJpf9KUNkwWBv46xxe/doOUpL3wsySOLBTQCbRBxClYacDusxyL?=
 =?us-ascii?Q?TMQ/qEgmWYTRtPhJXONhPhfPU55qm9NPP7fvI3N/cfgYrUmbOrU7fd6mcTYD?=
 =?us-ascii?Q?v5F7UlfPjBu0I8L89ZUA6/HOzp3PnAfk+wC+fAw/F+pfeB4oeofNj6fCmz4Z?=
 =?us-ascii?Q?js/S1p6ONLn9FAxB5jv8+BK3n94O7OOLqiaFCXvhd69MJ2b2h/XJ+FkWHekx?=
 =?us-ascii?Q?Gs4ARRcp1yy4cyvyfW/pG5oDM540nZ4jbOpXAQYMGawvE7T6zinyEJm4boPj?=
 =?us-ascii?Q?0hIFm9Ob3ZSznH3oqfrQZ6mPQtA0xxUVNkPew51GPRS6dTAOpu+mCrn1pmIY?=
 =?us-ascii?Q?fCPi4EpmRWIuOl2ldpay2K7LK7HxJnwwjttZi22lxuq8p/wPqbh3X3uhGONC?=
 =?us-ascii?Q?AenEwYHcsJSbhXCpJpa5LuBlQ5hVjozdLeKzIlXYRNjw9Qh8UTXYuiataJap?=
 =?us-ascii?Q?6w36wYvHvF6d15Bl44ZR07uvTG/7PHAXheTO91WuKXnNHsejTPZzdyq69wkE?=
 =?us-ascii?Q?BF92+J7t0CsyhfVl/LrrwRnXQM1Uih6BHnSmwAXTU0ni8B8tojlgfVvLolpv?=
 =?us-ascii?Q?8x+WUmkfrxkyK/245a4YjmPnFY+iBTSeiVKDfxG1srImPjuRxr3GphIv7cGe?=
 =?us-ascii?Q?W/12Si8zOtysWHF7REcDC1PxaZ1Zoum+tDcW3Wy9cttyQ9plCzcfruq4UO8q?=
 =?us-ascii?Q?T7cVERWIV6OnMl6xSkoFd1eJ2nK8yxFz/xhFM9ULJD1MRklbrL+ZIB/LTO7g?=
 =?us-ascii?Q?5wCgZh6rcBnJn44+K0xvHvIfCGNy3vHZLDYa3UMROw57GnoCDpVi7xJdsll1?=
 =?us-ascii?Q?v85YEieUIgvp0sjsFkKI3fb6GPGHHNryffnEs0BrQdvlZbK6CXqzjGcHJlTy?=
 =?us-ascii?Q?vRJLfXi0wpwROb1+3C7tlQDh8Paok25XNwoGXrmHwVmMJWMTfW7BlFZyohPn?=
 =?us-ascii?Q?KBllX/onljuHCwBBw8YJvhflSR/lQHvZO2pe7nupQYIM4DYeFdZJ//iZev/a?=
 =?us-ascii?Q?0fijiVhtmMpstNZgF/1r9hLOWq8hRHA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J3sOfI2wFakwCco6hi32NAxQFRfF8FuNJSXVOxSR+mPKYV9yd/xaXV1RQx1t360BNL6joklFMqhP4e3OrqJMTgmou27pRqk2mZjz58roaXh1GphQWWRq38uWm/dtx5Y3d+F2iyRnToRw9A2+OTEfynYiuhQVcpivlEuZ/Yj3caetDK563f1i7Mfb1HQ6Xig63HMNfczqFv5yXAs132Nl0AjFy51bEqBnMEcy7h1ST9ARUormvkkSqSqLoJPvcuWAL5RMGSFzvoQqV9bvd6fkQ2+PAngqc5x5b+3URX6fJUqN/rOCKvpjPiVpyFXU7ZkYfGboJqMnWZzqaSILsOsfqQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171a6f0d-1940-4395-a805-08de8655e788
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 07:54:24.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtFd5cPNSSTeza7FY+sRtKFmlyPVIR1q3dPhQLfIE8hLysUXtSmYjPhx1GKN0ZuPduDglBoQjbOKdfdQY+4DF3bKN9jJ4gGb9hl5rRiU9oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7938
X-OriginatorOrg: intel.com
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
	RCPT_COUNT_TWELVE(0.00)[36];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18433-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.950];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B55392D6D9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Stanislav Fomichev <sdf@fomichev.me>
> Sent: Friday, March 20, 2026 2:25 AM
> To: netdev@vger.kernel.org
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; horms@kernel.org; corbet@lwn.net;
> skhan@linuxfoundation.org; andrew+netdev@lunn.ch;
> michael.chan@broadcom.com; pavan.chebbi@broadcom.com; Nguyen, Anthony
> L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; saeedm@nvidia.com; tariqt@nvidia.com;
> mbloch@nvidia.com; alexanderduyck@fb.com; kernel-team@meta.com;
> johannes@sipsolutions.net; sd@queasysnail.net; jianbol@nvidia.com;
> dtatulea@nvidia.com; sdf@fomichev.me; mohsin.bashr@gmail.com; Keller,
> Jacob E <jacob.e.keller@intel.com>; willemb@google.com;
> skhawaja@google.com; bestswngs@gmail.com; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; kees@kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-rdma@vger.kernel.org; linux-
> wireless@vger.kernel.org; linux-kselftest@vger.kernel.org;
> leon@kernel.org
> Subject: [PATCH net-next v3 11/13] dummy: convert to
> ndo_set_rx_mode_async
>=20
> Convert dummy driver from ndo_set_rx_mode to ndo_set_rx_mode_async.
> The dummy driver's set_multicast_list is a no-op, so the conversion is
> straightforward: update the signature and the ops assignment.
>=20
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/net/dummy.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c index
> d6bdad4baadd..f8a4eb365c3d 100644
> --- a/drivers/net/dummy.c
> +++ b/drivers/net/dummy.c
> @@ -47,7 +47,9 @@
>  static int numdummies =3D 1;
>=20
>  /* fake multicast ability */
> -static void set_multicast_list(struct net_device *dev)
> +static void set_multicast_list(struct net_device *dev,
> +			       struct netdev_hw_addr_list *uc,
> +			       struct netdev_hw_addr_list *mc)
>  {
>  }
>=20
> @@ -87,7 +89,7 @@ static const struct net_device_ops dummy_netdev_ops
> =3D {
>  	.ndo_init		=3D dummy_dev_init,
>  	.ndo_start_xmit		=3D dummy_xmit,
>  	.ndo_validate_addr	=3D eth_validate_addr,
> -	.ndo_set_rx_mode	=3D set_multicast_list,
> +	.ndo_set_rx_mode_async	=3D set_multicast_list,
>  	.ndo_set_mac_address	=3D eth_mac_addr,
>  	.ndo_get_stats64	=3D dummy_get_stats64,
>  	.ndo_change_carrier	=3D dummy_change_carrier,
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

