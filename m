Return-Path: <linux-rdma+bounces-18345-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGYyBSnSummfcAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18345-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:26:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9232BF419
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A26231924BB
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92983D6CD8;
	Wed, 18 Mar 2026 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZiWSGcA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5A2D4B40;
	Wed, 18 Mar 2026 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848506; cv=fail; b=NAemWWwQa2BhR3g4r1pqBsH0Mps3usjqUG6OC1hc9oy5iUua+HBrwmSMn8Yiw/0XKR60J91pTsOkN24x28J+bKzC01dHj6rlcWlpfsINVMVnzja0ZVpRmbNPx38QhsOdgXYe/pDfAhTzVdFEI/1xcLaODDoWKv7892E17E+JtRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848506; c=relaxed/simple;
	bh=FBM1u4q0eiLpQcnmMV0Jz0JENNrXgeeSloV48uHNqpA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SYIaxxE7Gh9noNI+n5g5yBZ8LGEOru3Ztu+hwT+dJnjQHcQOP5Ko8K3OnU3ZowoRm4tURL83VizAp+X5mYni5okUj3Z++yvUqfWg8RZxL18nxnFlPvnC7v7pMHphh816ZLHN+tpDJ3xmdZh5gqYdVEc+FOqStT4KJoZK9CUPtkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZiWSGcA; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773848502; x=1805384502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FBM1u4q0eiLpQcnmMV0Jz0JENNrXgeeSloV48uHNqpA=;
  b=GZiWSGcARkoWyP80zAIi31B8vTGclYSCZU7hLlJ8E52Q4ucqECyweSDz
   I+JH4yjzQ9Dka38Y2JMkGfSjQoJ5/UJxha+s6GEz5SEU9E4sNbKzh9j9q
   Jz8nvfRZs0hm4LP54RNc9hmnwTEDuccsJWFRp/pw51N6ZKqj5tH1dkH2J
   wlEkyVINoOEP1Ae9fQromkNzebTKWZAULja+vkrh2syBjgMfRIkR4YPib
   fDgHXbqBvIEDhGATjnGTKnsNFxlsm9Ef2DbN2SaUnTz4tkhfDnNLeBQkM
   VggiKgwgcAWV2BMuoWGGasHg2u9Y++E2ZI37KhgF4lUS2YBnqKeT9ud88
   g==;
X-CSE-ConnectionGUID: a0oQ3yPOQqSMn85S3OXMPw==
X-CSE-MsgGUID: MlYcog7kSAOGLLIwoyWcRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75028015"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="75028015"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:41:41 -0700
X-CSE-ConnectionGUID: IbHpInGwQOixssHPd/og2w==
X-CSE-MsgGUID: Y02+OCKZQSahCM+UOAx6xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="247125880"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:41:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:41:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 08:41:40 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:41:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSrHwIAUg3ktRvIkOpEJvGsagNSLAZaGX4Sc13fjWVcTvSNEoL+m+zAR4lXMK8EASbmg8qlmHSSrWrRbe7likZ+uuB7WdXL9vcAYy+DLZXLVxYyoYEROy2PDsYuTZmpug5vWnICWGB1kdVcIS0BzyM3b+Vsx2sbgANJt95WdsvE4JTCr86/1KUMaV+GmLMKQKsMvHr12DfvdO1uRKGGcXMBzLe77GJ6mqIWNcmlsnxbTC8rZ72r5pzH7g8zrgy3OsxlILfhY8RaKRFAIYLr3bxqp8P99381T2RDix9LV8Dl8gjR3Fj9Fxvoq/QAi9g2EY+nGdqRaPTySraGS0TSNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PU84QAzZE5JTMd58zm2JN8wPJ+kwtovW4KZIx//MT8=;
 b=V56fZdOfG9ERY8wdhpE6zMPAPQrhMz51RZeoLK0HvS+2z1urSwcobTY4pD2mOKj61oa8bhuwpmEh9bJo0eAZWjQoFJ5DRrD/uHcRFT6tfKNaoSvd+GTHcKHWX5EvIIiL+ewkDNvlBPMe32yuPAW0m06aFBxi6jGZagq+brzHJxBDVc5VRx8pHETYANaPtmAZCsWUZ2Fl8XGIvdxXzI9tllvv0w8aYLb9h5r+tutrnGMB5SWeFWeRhsz+EcXkcNKWXhYT2cGB1LTp0Bk6MXCQ3h1EWJW+Yku12KNR/03jU2mhfzJmhwJNkM3g130ge7+azuoaZyvT3tCQlAz1P9d5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6549.namprd11.prod.outlook.com (2603:10b6:8:8e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Wed, 18 Mar 2026 15:41:36 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 15:41:36 +0000
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
	"bestswngs@gmail.com" <bestswngs@gmail.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 02/13] wifi: cfg80211: use
 __rtnl_unlock in nl80211_pre_doit
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 02/13] wifi: cfg80211: use
 __rtnl_unlock in nl80211_pre_doit
Thread-Index: AQHctuhnac+cX1DTHUev8LjCoXO1lrW0bYyA
Date: Wed, 18 Mar 2026 15:41:36 +0000
Message-ID: <IA3PR11MB898647AED422AD63361C4072E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260318150305.123900-1-sdf@fomichev.me>
 <20260318150305.123900-3-sdf@fomichev.me>
In-Reply-To: <20260318150305.123900-3-sdf@fomichev.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6549:EE_
x-ms-office365-filtering-correlation-id: a4ef135d-014a-44e9-0ec2-08de8504d709
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: aLEKe6ervtUcTDxbBC167CRnBuBO105EepmGZj9Q1Awa1ZXMBBnLx/TUVzNmyn55V2QFTXFQnwBwluaCQbvAyq64zKymht24kxQa/CxmKaknHhuQqZhhKh7XtJybXnQV+oi170/BK9BEUiPjZLgsJPpjwQDR/JQAiEBcZcGI3XriDaqtKQurEHqwPvJs0NOVBEmEFnTl4m4no+O3j1UywOiYmXhLutP3KnpgD3/qCyni/WBbf33RlQ63BeMlz5JnndPjeG71MYpeGqNJb2/bn+wQY6uMrOOwdXG7NgZbD1EsDffTLFcmT6GkZCfLp1WfopTQHP965XYXkLAAOQEvYstZZYPT5V+ob0Gs3yrxu+IRRYiaCUmM2ea/LjRjoOOYGEl+4te6qhQTWux2eKgKYeg9E9/RSCmQr9ks3K1TZioJcwh5fejXhDS5NTodRGw6zUXanjDrTupBRr/QBg52S1Wpryy54SId5IheXhIquda7GtmAFSX59wCwPRwxQ4FsbLN5CUsXdIedJBzjeVH2MCdBP0H1B1zjCWKARgmB0ab+IaP3IDyaWlRYrRN/0OW6eI7KeVmLcU51ycodQ5dqa4jM7JnA/kaiSO9n+DSw6IQcoyXXFJG0bw1e6wlI8V/fWPZsgkTKXmCTjiDxercHF1mmWm0VnJ6gCUkcAeuYsyuxwLdXrbV1d//3LOEe1KjLAmo+R6TdXz4YSO7fSUXMrC7gLUF5kqsaPxrjkJfLDM78MF1ZV9SK5AohJbEYT74fwg/h1epZViT1GEstokG7GnRes/btlomx9/EZCVaTCU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RHlX6aOASH5RAoSD66D+YsjBxCam/syOV6NW+4wtF1DxpYRII9VzFg2ECVme?=
 =?us-ascii?Q?OsJMimIZ1uVucjaseC3PD9DuH+Gye8Ls0gf6fet9irPROu61I91pNI3vDTDR?=
 =?us-ascii?Q?DX/KPFypIz9WRQ6OZRGNkMGVHiTdQiDMimpUm17IWokSwOBfegumc//mfyy4?=
 =?us-ascii?Q?mClRymA9R1evyqlC3rfvNRJrxmkKOVMhQwnh8LD7MmQKcUugCyPRxlPA/TNG?=
 =?us-ascii?Q?Gq2kxpmE6jxIe4+q4Scv/wkyAiOIo6J1BLcTRj4oiX0sYkBOVxhe3Y5WRfbV?=
 =?us-ascii?Q?LbhxXgyawlcigfMiIG+Ylbp95Rj1Seyfqy4jBgoBIVlvqrPhxdGDxdKJcCJ1?=
 =?us-ascii?Q?1U+MNMBMrkSFlqtkd89oA6ubmWcB9z6BMYeNHcA8mxYlMjAT70P2Q9sY7Gue?=
 =?us-ascii?Q?uZp4Umqk6w/nhnTRc7lm5jPeFqfkxbSvJzqTxhlifmvRtWayFad2Wd0qlxqO?=
 =?us-ascii?Q?/+ClQJujoirwUzWXRtfAVxT6BGMfjV1uvd/LN+FzJmTi8Dw8r1L1w/d1tVzW?=
 =?us-ascii?Q?FmblqOOhaihKBbzIUTYSD2Mz3TgT4+8u53hHZdN7B2aa04vBzOK9X+iVGz5I?=
 =?us-ascii?Q?WXSff3oko6KUmYhgUFr0nAQ0r4HAch7ge3VG4rWtpqfJ8/s+6VFqJbYb0HV9?=
 =?us-ascii?Q?fLvYlGGdQ5OtxVzDIO5QZYeDKy69IZjgL/Z6JWreUkWSJcwHCmPmNRLqRMnU?=
 =?us-ascii?Q?h9UdB1q3EhbmAQnaADB4zJx73c9kFhaAsmFoK80AeGFsCi8c1yL9sC1Z7Xml?=
 =?us-ascii?Q?BZMrVRqq1L7uRlt43Dvll2cBKFNJThMAPNliFCxDDbxb0gooDnfCGaxv+qRv?=
 =?us-ascii?Q?DZ/EyohylwMh4PzxldcFMHVSm+8il9i2m0XyHTuwMROJBSHzhzI8EZI04jyk?=
 =?us-ascii?Q?83HqHlL6sO4nwydMTCnHzn+cRbMMynVe6T6Az3uq3C4Xkk+T/7zdfi1ZZ6Ie?=
 =?us-ascii?Q?9RO4XEmtbLcfBRJvIs8cDM7FuO0uScS8HFhaFehB3xvRj5ieGuUudUCFxQy0?=
 =?us-ascii?Q?7eQ0bXFB8ql6+N+K8rhXIPnWQ+nNhO4G6e7dGObhWlhsyZS1cWRPCskfSVii?=
 =?us-ascii?Q?X9S3v9JK0r4QsBz6N7KzO52RUXueZc2ISNaANk8n+eCubG8+0eabyCXNL5uT?=
 =?us-ascii?Q?ahUGbaInekcgpNibQbSNNi5K8Mq2SZ+N48Intg9SErdPHO+mT+nG13dYWnkE?=
 =?us-ascii?Q?NRMzckZBPPd6Am4UT6sDstqj1sNRtsG6AdJqYjcKoBS8CWoER9uPNggrU4RE?=
 =?us-ascii?Q?5stcD/fUpefSD3MEg/Vi1rWPDZIfIHwtukCqsfViUCfTjbvplDpu2TuL7cNS?=
 =?us-ascii?Q?nI8us86PCsgMmMdN1gbq3KHF3q2dShazV5CTk4k9eiJaE0LuVSpdSQ5aQzg+?=
 =?us-ascii?Q?2fgvH7v8WZm+CbHiCIC6FsTje1wrW6TuZVftRNoxIG/CH+Mg3FnBXHlc6vRl?=
 =?us-ascii?Q?JMoDcvduUjpDgliKjw5dbteb0qsRK8kJKjQukXPMTVjBeMpWHwOrkYvt/OKc?=
 =?us-ascii?Q?mrlCf38t5BG0tArm6co4CJFw+tpH29V80gLyOGtMnwAoXaDfxEZOve6TXLPS?=
 =?us-ascii?Q?TkZK4Va3mVcByzx85/SAGfERDaaJhxf5p4lMoUCC6BSrWz7hOYXwLvSEvbP1?=
 =?us-ascii?Q?hMnqnqK2RPabpqTzOst58Es14cfE3RalfkBND7t3bWqz4dkfgQHx0kkh4NxB?=
 =?us-ascii?Q?eEQDsYtxNxAYAxdFa+/gKzSGDpKdwvJH1ri1/bvtS9Gl9cjYgxcqitWLJW4a?=
 =?us-ascii?Q?bSlSVnON+zvfPK5HgcY/UqcLhFWGqcA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tZ+h7cAu2bxR+dV700A/PSM/BchJrJVlq8GI/jdJl7YdAZN6sQSVyxaQMRGzx2gkNYAwe63ZJwj2dcT9TFCrtUL0QU2txoqIjR32fTuLhtj4S4upuStD0u0nsO3lijzXJ9uxlPA95HQIdNKExAbEVA/Pdq8MlBUr67TIf8D/UvZm5UeEOg2xx8TxfJ5h2yhdao/4zUMGlV7JyZoMY+QKWbDZKtevvBi0jFl7L4up2i9qO+L0Y3s6H83VH7nqiLP/hOljLdsPMHXasY6oqqX0htqgo7wZMNp31DVARtWhtStwY9xedbqsjNWOFjprNN8YPqm515x+GGTixOmo1jRoKw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ef135d-014a-44e9-0ec2-08de8504d709
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 15:41:36.7027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+Ra/vFOKr6wV1gRJpH8dEzzv8bkLfnLeSxwM3niE5jjZAPBgfGHITfuWr7biNK0ZcDtyP28z8rODuk1399v+fTln/Yt/qQMxTNthgKVJLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18345-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.921];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1B9232BF419
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Stanislav Fomichev
> Sent: Wednesday, March 18, 2026 4:03 PM
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
> skhawaja@google.com; bestswngs@gmail.com; linux-doc@vger.kernel.org;
> linux-kernel@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> rdma@vger.kernel.org; linux-wireless@vger.kernel.org; linux-
> kselftest@vger.kernel.org; leon@kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 02/13] wifi: cfg80211:
> use __rtnl_unlock in nl80211_pre_doit
>=20
> nl80211_pre_doit acquires rtnl_lock and then wiphy_lock, releasing
> rtnl while keeping wiphy_lock held until post_doit. With the
> introduction of rx_mode_wq and its flush in netdev_run_todo, calling
> rtnl_unlock here creates a circular lock dependency:
>=20
>   Chain exists of:
>     (wq_completion)rx_mode_wq --> rtnl_mutex --> &rdev->wiphy.mtx
>=20
>    Possible unsafe locking scenario:
>=20
>          CPU0                    CPU1
>          ----                    ----
>     lock(&rdev->wiphy.mtx);
>                                  lock(rtnl_mutex);
>                                  lock(&rdev->wiphy.mtx);
>     lock((wq_completion)rx_mode_wq);
>=20
> Switch to __rtnl_unlock to skip netdev_run_todo in nl80211_pre_doit.
> This seems safe because we run before the op.
>=20
> Link:
> http://lore.kernel.org/netdev/69b5ad67.a00a0220.3b25d1.001a.GAE@google
> .com
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/wireless/nl80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c index
> 2225f5d0b124..ce5f25d4c87e 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -18192,7 +18192,7 @@ static int nl80211_pre_doit(const struct
> genl_split_ops *ops,
>  		__release(&rdev->wiphy.mtx);
>  	}
>  	if (!(internal_flags & NL80211_FLAG_NEED_RTNL))
> -		rtnl_unlock();
> +		__rtnl_unlock();
>=20
>  	return 0;
>  out_unlock:
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


