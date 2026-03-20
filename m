Return-Path: <linux-rdma+bounces-18431-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AvHOYX8vGn15AIAu9opvQ
	(envelope-from <linux-rdma+bounces-18431-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 08:51:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F3D2D6CE7
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 08:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0EC03013257
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0450635F19C;
	Fri, 20 Mar 2026 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwftcwtB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC7230BE9;
	Fri, 20 Mar 2026 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993086; cv=fail; b=iIdmzTvpibMdFRCkcIrJyMAoWScsL732Un0F4GwmUxTzB9znrTGTyHp4ELL2baHoWhrxCLXFNnhYt2PQgCVlogaolMGmI7lF+5m5D//8csqmfso4/i9g/1el8JFNuuEVjK1blmEJJMMTuvHXLkMx64VOAvP58LPuMcs+byp8pSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993086; c=relaxed/simple;
	bh=h9xxbRXYxnYMt79X12IWN1681WmkdI/U3cXRie4nmYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CQr5b7ut3m/9fIl3v/VCpLDLDUwYcH4oTyy39qVu+tueggJqGouaEeUcRdJvV9PZTPFx2oq3NijoVWdkpj66zqLxTw/4pbKkF8cwVgaq/2p8Yit8ubV2hqgOoZYSYGN3IKRN5ukLt0vWxi+ncI9dMOl5Qic487ps/mKKnT9hvmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwftcwtB; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773993084; x=1805529084;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h9xxbRXYxnYMt79X12IWN1681WmkdI/U3cXRie4nmYU=;
  b=fwftcwtBu1qEOsloeWYWxiZvdVEF+JC4KubYz+l+Wgkmyke8dNks1UKj
   afn6b1FiH6eDRuWaL/3+zWrIdxDVthR58sdPn7MifazUOh9aZ2wt2hhfU
   uJA5n8r5sZe38ptyZXxi6EcW4NMfWu3ust4Bl/7VLOQhjXUCE8/ykdW8d
   nABUNbqYDcK1fQZNuTZZ5WxJ1Rkix6ihkiTGzlb+ou7MTLkTNorpO6GVg
   XG0UAPmZbLtKQQUWJsJYt9QU1+HiG92pKEZOYph250qb0OstckdSwFh6x
   lRaRSXd+B1kVTMfP2YNxnzidOlu6CYV0oTRHKSMhn9wuhR5aQJByytVSU
   g==;
X-CSE-ConnectionGUID: lViBCroBRAGZOx/Sb1RULA==
X-CSE-MsgGUID: 6a7Y0MzgTkSBB4JRo5sWNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86436836"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86436836"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:51:17 -0700
X-CSE-ConnectionGUID: LunLEA1HQQiXWqcWyrsaNA==
X-CSE-MsgGUID: Y/eP7jh9SUS9Zb8qXp+SVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="220576750"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:51:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 00:51:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 00:51:17 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 00:51:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrrJu1ovfdUsMIQ2S//0TZMHlCMpcTt3f3Iqx/bX5+iYYybEIH2M/pK835BLz+XR389UAdTJfsBLZmtQ6R5pvYeN/OQRi4yd28xzH3iBv0Z95ZddHDEzZG8nJdzyfP5Y2vzvQ7AR7pFUaxF94JnKwbSt6MMW+sgsSd4EXVlcIBsWMXGnFnwMmBlBsiuiMt92eU3n0P+8w9oYDoy0vx13HbQAfHtCyjflz1IxOw0zbuTvi9Q5eXXOY78v8B25hNTQ+ixtLr28/Og94DrP9Jz5Mpnk7f/+eCZMkHx/XCed8qN8zhf5WeKd4i4xIvKtibeaMNPcJCc4U7x41Kazs9eg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiUE9Zl0LqbsogMYkKR2vd/KnL1FiOT5YJeEGIlJZPY=;
 b=Du3GU0dH8EBqCcDPXoiDTr+DJs/uqkG5UFyJrLZuoTfKNC0HmsU8aW2GQblcyhgGohA8BFAh9aO2xPXuoq+dcH1zbSZ7kcE9G5GXwrON7FvSFgc8XLTjbORzOh6MZRu6fBbUwsOIOBxCQ5Wx0/9OJXjT8R7+srSZB+3YJaihbxObQgLEaQOM5PjZbFSJS4AQVppcswRcWY66OVFCljhIG1/e+DNE3hfSF3HhBX2cxAerUnCU8H6ju3FJhki0nxSvtD4R3ZFN9GFz0cnFJiL0MLwxmBLYewJTYAjG1z6EPVfuFqCD37KVLwOD/ynw8nQTHXSuRBFcW+9xd1IxjyJBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB6871.namprd11.prod.outlook.com (2603:10b6:806:2b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 07:51:11 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Fri, 20 Mar 2026
 07:51:10 +0000
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
Subject: RE: [PATCH net-next v3 08/13] bnxt: use snapshot in bnxt_cfg_rx_mode
Thread-Topic: [PATCH net-next v3 08/13] bnxt: use snapshot in bnxt_cfg_rx_mode
Thread-Index: AQHcuAhzrn0fIfT1YEi2ihiXJiuQy7W3DICA
Date: Fri, 20 Mar 2026 07:51:10 +0000
Message-ID: <IA3PR11MB898624C8232DEE3DBAA10822E54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-9-sdf@fomichev.me>
In-Reply-To: <20260320012501.2033548-9-sdf@fomichev.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB6871:EE_
x-ms-office365-filtering-correlation-id: 85474c37-74f0-4308-b84a-08de865573f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|7053199007|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: MHREShIcMV3yxGJ6CO7DjmXftJ788YowMJ0nnZcNa4MppCOookEOHFsWvnIddxS/MQPCRSlP/qqR1E79BotHfHKIVD4BgxAFhhHcL/Tf0pQdAbMORqZR4Atzw6W6BZ/2HDfEQlhe/cRXs7JQBptfe4pdmbjsDOBpDZu6R8DVivxELAwlgEJ19xjewBelKOCmcYLzu9K0XvdUyzk8i4cJZgzgsuRSf16muNk7NkanEQPlNKzfGErsba/H/MEqkaZXph6JUoMapbivBQioAHQ0nOYNr6J2xdAY2wGmsO2pNHAYp1u47uqOll4bl7qcm260y6h2Dapm1VQxvNG4OYRllyRwNqVAz7phbXnxtKIqjVk7ymbssokJTomefktd2mzCgiMw7AArdFWpMdgFPA/curWzy8z0IhN/dDwwaciSNdRblpNTyGWywFUArCLAMQn8jRiwvz0R/eO0QeM1MQ07fgEBKK3k1s4esVHzrpiZl6Q1p0bodfcu9VYpngdqROyteIosx5ky3KHszb0g+dZiHxczQ0nr9SR/oV9btY/QMYY2BeI8J3/KF7FfUclnKg0B16O7RLOBmj+t6INcr75eIRHEJy7nVfvsGHsoMcBkXjY6BYPFbmynFCPOeF+BJwy7mJPMEHBHGvNjeUHEwCPrQJeNDdmSpR49Y9iSNp7kF4qnMv19yWYO1o4FzC6ns+c2sXeKLIBrfXIwcNSACL/jdOl4qgEe7TROU5vrrs3FQHv73GctdpMRfrk4um0XwfCd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y1C5Ovfzbcv4tm/y0iyaEBgz6NkDkgo6QUWdIcx8V4hmDhOjqSi7VbnM/ZU/?=
 =?us-ascii?Q?RyA+HUFk6duWw476LBOI+Gs4CDAFJV7y7HuTqLTLRYWHogpLCTHFe7qq3F15?=
 =?us-ascii?Q?1mXA34qKsF76FSiehMZ9QABqP4aeZ+IDtSsbOm+cdFynmWpKKjbdjvb6ptAY?=
 =?us-ascii?Q?KpHmL/6oNv9nvOHv9J7UduRPD4SzPcC0RAax/umg2aWKugGzI/WyN+SiC2Vp?=
 =?us-ascii?Q?vrLPxz/PI3pgnn1U99Ouy0vRyDuxof95ZATuAKlNjGvjjt+ncBYwlhyWZRSG?=
 =?us-ascii?Q?uDBYfcwSc+wyuYqCoVKYLAejLKwtjCxPfy/+5j/xmmw1cgk/P163W1CxYC3M?=
 =?us-ascii?Q?/GWM5/VnukuduC7gDKUrJqhAV5HCiFi9avxVqSYrag7lxfZwaUT8DusOm3f1?=
 =?us-ascii?Q?EuzdxjaKoSA0caAyRVYyByrIDTIiUnQd7845kh3Xe9HtbNEHzB6LkTWC8ObT?=
 =?us-ascii?Q?JZO/pSPWeEbhy9nU7pUYskom6//dR5040DcbccaAA416ux/u+4V4pav+4qPp?=
 =?us-ascii?Q?UySPxyIxPoifPH+nQ98a4a9Od6TrQ0mYJf+nYWUsI3tWcxF59Z1RtwhBN28y?=
 =?us-ascii?Q?mKVQIjfGtV5FcFpI82VhjSFgjDvdAq7CylKalO/8vPQ5Kl1J/3UKMFKGBAv7?=
 =?us-ascii?Q?We7v8H2AE+SC5gdgAf2eNij1Jt1+tU9r3Xe/TIgZmgLnIgrbqMjBehQ9kGPg?=
 =?us-ascii?Q?MutIjvBGbSt0QN62gvk2TfY/3hr1PPQCzbfkWtKzxHSS4zYeUwvQgnucZVRX?=
 =?us-ascii?Q?WlHNyDqlpLZdVK1gTnE6usMWLBBmVMSbDadOJqJ0asjx5Fm5A6Zt42Co1pe5?=
 =?us-ascii?Q?NpvzHVi6dLqfHy1oILdPFkbBEddm3mIMKwjJVeAO7kBTbqRZvA91RZMZpM8B?=
 =?us-ascii?Q?mCwV3gmSFjbFmlSoQ2g0gPOxIXkGost0sCT72EhcEw5E8jnjtFl0AVommlKa?=
 =?us-ascii?Q?Baym7CqC3uZzC4hj7+vumIn5tNnaY7zgyKURg0NdC/F+oWM5HPo3RlKNiptr?=
 =?us-ascii?Q?XwHpG/mc8SeodBeM60vX5e+QDxvL0GqsqI3zrzAJijCz394opR3oRUFLKxYx?=
 =?us-ascii?Q?tZfPFDRY9PjFrIWFUB/nlWNVM+mV39uHwX2WZO5s9ly8YfxjkciacWx11aGg?=
 =?us-ascii?Q?1tD0LA+2h1HsQ2keRrGgMmzZ+hyArGtOG6wWi3+FqtMFtb6czIY5rqKW/NdI?=
 =?us-ascii?Q?pSJCLkp6ijxqqGmvbsi/jHqRRtclBBKft1ikuZCt/5ZKpJL7Wg6F/62IAAoU?=
 =?us-ascii?Q?V+WWkp6QaAxJeNhVb3XASoouAYO6eDrUwPWAhmaOsySGb3vlL8fvyU1Yo/ax?=
 =?us-ascii?Q?5fL0uFFvQQaxLalPoTKyNPneTEKZhXcwFZj4SiGrj1qRLLXyix+++s9uOxip?=
 =?us-ascii?Q?z5icxZAz8iLKhal1tu8G6FeMAy4A5hchwXmul1c2hqRnC5MDrlM1ux5qu+Rr?=
 =?us-ascii?Q?Y0f6QxMznuCHrqfpHPX1ZglpZb/L7h8XTVr8FB6ay3F1g3Gu0jNnbaIPaQAk?=
 =?us-ascii?Q?cfowgtlRo3kSk+FJrHIlRcQNRMbXX3SX05CJQ2a12C1HVosMqdaAWRe7D/aK?=
 =?us-ascii?Q?oWjCGIXijH3Ct0IEvXfLdk4tJMSH3XcfkPRxjB8H1zSZ3YOqq1kQoLdUWKGy?=
 =?us-ascii?Q?4uwsCk9LmrtphTFCrVGAVpg0Wbr4rvho8kNsg8Z8ILkppr/dXJhJgKgAcqS7?=
 =?us-ascii?Q?9jrAR+uaEBGpVUGBPWnJC5kULEy/q0bM/bVifFWtkZcy86GFYMGRAfaVoisG?=
 =?us-ascii?Q?++PvPZEUVVQv5ZmQBKQzTwH8lQOeV4U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uZdhgKFyviyEz+Kr+R+yZy9hI/Et7+Efr+HMBVC/NnRjgB+9ZLb+QIoA6+A1rLl769BIhZ98uLG+b+HPfwFfPH/Rd5GS637Zy3RuITgy7hGkGb2pXo0uCK0TWYtvFb8W5YgCGX8kv3rXdOz9aPo2beGSoF33R9hV/LfFEclCzS8CSM0eTOkxpuzN+ZMxJCBV76JZvWiC7DYF7SpOR3PdDUyd5YQSrT+uS+g/oEhdxoVbIh+oKOUZAnFQXjY7s6RqdeNHsCEouFsjP+6uZXcfRSDzuFlYuGqZDXB5d9g3wzlyLSu1HhZPDqYETWXLZScvZx7D+QbIMqbONVsVhMSZ4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85474c37-74f0-4308-b84a-08de865573f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 07:51:10.8197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbZwBjqnfqlQvbUO3lH+i6aOXH62Dq1Pyv7YARyvpwQ90guq08GphLYU7Pgnp35AVKHt8GcV24/nf4feMCiueomiwcPNwMjWwVlH522++3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6871
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[36];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18431-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.909];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 89F3D2D6CE7
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
> Subject: [PATCH net-next v3 08/13] bnxt: use snapshot in
> bnxt_cfg_rx_mode
>=20
> With the introduction of ndo_set_rx_mode_async (as discussed in [0])
> we can call bnxt_cfg_rx_mode directly. Convert bnxt_cfg_rx_mode to use
> uc/mc snapshots and move its call in bnxt_sp_task to the section that
> resets BNXT_STATE_IN_SP_TASK. Switch to direct call in
> bnxt_set_rx_mode.
>=20
> 0:
> https://lore.kernel.org/netdev/CACKFLi=3D5vj8hPqEUKDd8RTw3au5G+zRgQEqjF+
> 6NZnyoNm90KA@mail.gmail.com/
>=20
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++--------
> -
>  1 file changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 225217b32e4b..12265bd7fda4 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -11039,7 +11039,8 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt
> *bp)
>  	return rc;
>  }
>=20
> -static int bnxt_cfg_rx_mode(struct bnxt *);
> +static int bnxt_cfg_rx_mode(struct bnxt *, struct netdev_hw_addr_list
> *,
> +			    struct netdev_hw_addr_list *);
>  static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
>  				 const struct netdev_hw_addr_list *);
>=20
> @@ -11135,7 +11136,7 @@ static int bnxt_init_chip(struct bnxt *bp,
> bool irq_re_init)
>  		vnic->rx_mask |=3D mask;
>  	}
>=20
> -	rc =3D bnxt_cfg_rx_mode(bp);
> +	rc =3D bnxt_cfg_rx_mode(bp, &bp->dev->uc, &bp->dev->mc);
>  	if (rc)
>  		goto err_out;
>=20
> @@ -13610,11 +13611,12 @@ static void bnxt_set_rx_mode(struct
> net_device *dev,
>  	if (mask !=3D vnic->rx_mask || uc_update || mc_update) {
>  		vnic->rx_mask =3D mask;
>=20
> -		bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
> +		bnxt_cfg_rx_mode(bp, uc, mc);
>  	}
>  }
>=20
> -static int bnxt_cfg_rx_mode(struct bnxt *bp)
> +static int bnxt_cfg_rx_mode(struct bnxt *bp, struct
> netdev_hw_addr_list *uc,
> +			    struct netdev_hw_addr_list *mc)
>  {
>  	struct net_device *dev =3D bp->dev;
>  	struct bnxt_vnic_info *vnic =3D &bp-
> >vnic_info[BNXT_VNIC_DEFAULT];
> @@ -13623,7 +13625,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
>  	bool uc_update;
>=20
>  	netif_addr_lock_bh(dev);
> -	uc_update =3D bnxt_uc_list_updated(bp, &dev->uc);
> +	uc_update =3D bnxt_uc_list_updated(bp, uc);
>  	netif_addr_unlock_bh(dev);
>=20
>  	if (!uc_update)
> @@ -13639,10 +13641,10 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
>  	vnic->uc_filter_count =3D 1;
>=20
>  	netif_addr_lock_bh(dev);
> -	if (netdev_uc_count(dev) > (BNXT_MAX_UC_ADDRS - 1)) {
> +	if (netdev_hw_addr_list_count(uc) > (BNXT_MAX_UC_ADDRS - 1)) {
>  		vnic->rx_mask |=3D
> CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
>  	} else {
> -		netdev_for_each_uc_addr(ha, dev) {
> +		netdev_hw_addr_list_for_each(ha, uc) {
>  			memcpy(vnic->uc_list + off, ha->addr, ETH_ALEN);
>  			off +=3D ETH_ALEN;
>  			vnic->uc_filter_count++;
> @@ -14600,6 +14602,7 @@ static void bnxt_ulp_restart(struct bnxt *bp)
> static void bnxt_sp_task(struct work_struct *work)  {
>  	struct bnxt *bp =3D container_of(work, struct bnxt, sp_task);
> +	struct net_device *dev =3D bp->dev;
>=20
>  	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
>  	smp_mb__after_atomic();
> @@ -14613,9 +14616,6 @@ static void bnxt_sp_task(struct work_struct
> *work)
>  		bnxt_reenable_sriov(bp);
>  	}
>=20
> -	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event))
> -		bnxt_cfg_rx_mode(bp);
> -
>  	if (test_and_clear_bit(BNXT_RX_NTP_FLTR_SP_EVENT, &bp-
> >sp_event))
>  		bnxt_cfg_ntp_filters(bp);
>  	if (test_and_clear_bit(BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT, &bp-
> >sp_event)) @@ -14680,6 +14680,12 @@ static void bnxt_sp_task(struct
> work_struct *work)
>  	/* These functions below will clear BNXT_STATE_IN_SP_TASK.
> They
>  	 * must be the last functions to be called before exiting.
>  	 */
> +	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event)) {
> +		bnxt_lock_sp(bp);
> +		bnxt_cfg_rx_mode(bp, &dev->uc, &dev->mc);
> +		bnxt_unlock_sp(bp);
> +	}
> +
>  	if (test_and_clear_bit(BNXT_RESET_TASK_SP_EVENT, &bp-
> >sp_event))
>  		bnxt_reset(bp, false);
>=20
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


