Return-Path: <linux-rdma+bounces-18348-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Hy/KC7Lumm6bwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18348-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:56:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 220292BEC56
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B6B83049533
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124893E9F61;
	Wed, 18 Mar 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFirRXyN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5672D3E95A7;
	Wed, 18 Mar 2026 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848624; cv=fail; b=A/Xpu/ZnjMLqRPjpNPLm5DYxrTWWZTmw94l0danKUm9IqQuoP8VOaAJJ8oVerJl0vGDElDa/iQNnDxgCqR0EmqD+B+wm/9X4lhgdft6jMNwu9SV3IPACNHkfjWPSp3nnkYmBoKd3vwrB+hmk9dPK0loLEA3nIDCVfbY+5KEFU2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848624; c=relaxed/simple;
	bh=WpIHEcsY8k1XtzRIvpkIeQrSMBLRyv91K1xUl0JIiaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sTolt12Z0ARGMQFdh+XvNLfSP2W3c8fcdr2PMUDNzx3SGJPoENYEPs96Y9VF+PjV3U49A7HRuV+VUzGOgOVLZMKW0CQOFBeuGlBn1TqWNE8kmrSaGQtC/XpK5PFOgEE8LP7NF67m+7b33+noZZFObY5ZN+dhQorNk5lcTZ/WA+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFirRXyN; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773848620; x=1805384620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WpIHEcsY8k1XtzRIvpkIeQrSMBLRyv91K1xUl0JIiaE=;
  b=cFirRXyNQoN/pLX4CgfEJSQs+yXP4eZFoxgi/SlaK+lqCnx5kPVYvLbs
   Z6wjyT/RKcUa4GogTNHepYGdtpCW5jOEx4bznW2r7gijs8m07Kkw2+pnc
   9om7/x6BcV5iLFigZoeAyahiHbsotHQaBYjXXKzkUtkjQ1aOogxPUEBSM
   B3Fvn+4K/1EmokiNh12pI3Q2EGRf6aXnAqYBvBi8tBfAaO6yetF0TA1Zx
   YszLU82XomIeGlSgN58BQ5TS4D8DsKnPLOvKBBJb03iwJeqSKTE/GLMnq
   OV3l+kYSn1Nq9R1mUkRi8K6QJdXZF9Q927vzKCZsd/kQInIYcldo5ui+r
   A==;
X-CSE-ConnectionGUID: gAc0As9RSUKaeQ7aQrlozA==
X-CSE-MsgGUID: Yy557TkPTWSirwg7xGhDXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85982791"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85982791"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:43:38 -0700
X-CSE-ConnectionGUID: Hu3R6JRhTtenB8UQNFFm6g==
X-CSE-MsgGUID: 8xInKqdQTXicraU2+uZN/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227145461"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:43:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:43:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 08:43:37 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:43:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kq3gxNUUo6WQ/eZMEAjI8TswTiLCsibQdSJDjPQnOF1cO0t8osFkz5Ti6+CH6jxv9FUP0aF4kcEoIqzAnKjEc556xbo0Qe+vCdkSd+t+3vLpYhbqscrWDjEBQWmtv//JXIgoHTW7e2gwOZ491Z8wSYnu6tL8YMuuPyT1WJnSDZGDbu8rr1u8aitVt1nopjbuD9jy0kyhOrmkoi6MzS+wA2voFHnSsryFaVIjTso0m8lbg80tToMEQIA85m8kpJA77hFzm+2h0vQpMn2DvsiprjnlAu0R5GpQYaP2Fq/pfoac5UXMQrg8ktzquaRYKvZaNeMcRdRwSkmVVW9JTCZL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msKDyjoELua7jifb9fZRdw+KMHFpgvtcivjD19evpsI=;
 b=WtE9KqhWkqQLgLbD26nLlgxM5nBub8qKxNc6OP7QYu7s1Tg2MYzS7mSM+ZHBGpWNhu7A2AxCmEE9NCjlloAOwBsrO5jNVkJVmNLVDe+KWC8Wz1cdjqW6PeFqwuyC1sqdM/tic9KtkNPmoJ2wUCAul1lzxRB6zZscO0ym1mhWUzhkZT6G2ClZlRTlp/mUuWocnYGofvLMJ+ygvcOzAzO1ZNu7jNXxLOsg+WBjF80EdLztNnie7qx1mHmBwlddlZg1aSQ6Za9oUcOdNn/eDcClxByx837id2vl/9STMvIuB2BULrDDFqyu3FToBu+R4ZxmK7rf2LRfN0JDI5/dwh+Mow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6549.namprd11.prod.outlook.com (2603:10b6:8:8e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Wed, 18 Mar 2026 15:43:33 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 15:43:33 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 05/13] fbnic: convert to
 ndo_set_rx_mode_async
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 05/13] fbnic: convert to
 ndo_set_rx_mode_async
Thread-Index: AQHctuhtgzjNAPoIFUWxvACsaocgh7W0bgaQ
Date: Wed, 18 Mar 2026 15:43:33 +0000
Message-ID: <IA3PR11MB8986D56600DEC5368EF08C07E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260318150305.123900-1-sdf@fomichev.me>
 <20260318150305.123900-6-sdf@fomichev.me>
In-Reply-To: <20260318150305.123900-6-sdf@fomichev.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6549:EE_
x-ms-office365-filtering-correlation-id: ff634681-98fc-4e8d-1854-08de85051c67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: aIFRGHZ5qw9TF1TlwshHSeldVrTr2LU1fgIkfPATVHKeA26QweKpY/dgkx5TG3De8XHi9OjMn6YrcuXcIUFZ6jXxeCqynoQ+8lWgSCSSlFDa/b65+4Bl+KX90UYK4XoWB3wchXTJU6qGZIw8nWaPPvPC2KP9ALd5pfIki9AcPPQ/Y8sr9K2i6spR16XKhqbS09w+OYF0bKCgu88eIBSWBRdyRD1dvuc2L1KmnLCiwecp/OgwKkAkWWwQXRY09F8Go7DluxlX6QFF+lhr6cJoURBJOn+k1qihM3dSYy94NnAN4hXSW7XhihqTF3r2l0Bb2p4unvUB6jlZOvf9lXZpxnRHfDg3K0HbmMtV8yHAPJsac5FkK6gogX7IeGXUvp5HURUdwrZ0y6iw3XHz0ICAw1sywop/Is9vrPAx3uO0axeL5PVReOrkEaw2mvTZF+ww/SBnpWj5kOIP/NB1p1B7qMKgMM+AUrbh49OeQ4hKPkmG9qBa5nRDD4WEh09S9rZfmqAsjMYsoLZPz2EdFGduyreOG1guFXi0lTIGYymjRWMNPMK7UpU1OLEPt5JTtcRztvERf3UmVDDIlcjl7jph4jTuUgAgq7OV+swiyjy5SWdD4S4M1f8kwrZ2eXGUhglvY1DfX8VQXh9YDPlHrzVCtoQT67ltgwDU1TtPQs01sdDfbRW3IWjQq6alOG68Uwa+5gAr39tUK1xYrJPjBySElWkHHdciZ2Zlg24f3SDdv2sh8W1W9D5k/3tTLq0DnHg2dqebUs6PDUIe+yLLi2KvKzo174AjQT1M4VhObaxtoaE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pOm0V6KNPGiAL73gtNJ0pjMNV9tkC9HttI7RbubsUDizaf6266PYfE7qZm6j?=
 =?us-ascii?Q?bP0/vmyJ1KHFK2mG4JJP3BQvSIuW2+Yfm8MIoQhnxwJhSpPngJKXTL1I99V8?=
 =?us-ascii?Q?LRVhgZQo54HZNlATyt8k8A5hXjDUjHo3XO+AaXsb5TB3YWkkge/yKYzBCi5+?=
 =?us-ascii?Q?jGwrAnxdO+R9gJvigAKEPqT4SnCUTwQJbc3BubhxrlefZ7RO/wpzE2BQbvgu?=
 =?us-ascii?Q?YjuBKNJAi5BGyHcviSo/Y0tJRF1u3XAOXXcTXLuIqZaYp4soxoPw5DAhgBIh?=
 =?us-ascii?Q?F5Koo6uCHhYimboVTYuFDfMTnLKcCbBuvn7l0dLrgK3rBUsD/rGyiBqfX0mr?=
 =?us-ascii?Q?h2iGv6aRDXPULSwvWRS2ENtnm+CixldUoVlbIQg+AdRk03kQfXsc+ggfSmZR?=
 =?us-ascii?Q?kDi2xRSTKw9Dt7etYANqpUJKNFc3K3RrvYlZUpczF6AsDYcY91M5TP4VVA1L?=
 =?us-ascii?Q?hzTHwU4j3Pzfmn3qzcVJSqLqUEkfEFUQSJ0xXe15G463VeTCsj6+jerA29n6?=
 =?us-ascii?Q?X/mYTn4UcUyUrY9vOUWYLZ8me22/8qVoS9Y89/eEj9WkJSgRdFvdBar/jAap?=
 =?us-ascii?Q?bjJc0v1CoA96+bdZ9iwnhL0cPiY6FYwYAyqFKadZ+LOiKG4DCkLkG0I1dkLX?=
 =?us-ascii?Q?H+TKRHoe6bwLFhZm4LRyOuvrlox61qEmRk44aMqRkbtz13Y6fxGpZEQdddiI?=
 =?us-ascii?Q?YJTWQgtxgj8d+PCrDz6JBYz2COWqs1XuOhPbwLinMKedAuXR7IbTCO7QqquD?=
 =?us-ascii?Q?4K5pPoSsTj3GdWabBbC1b4jZvDuUoVrShI7FzOM/QBYtDpPXiVwGOf9PYd7C?=
 =?us-ascii?Q?yvOXfa1CCaKqZjdVqJ8xXu3z0w8NAdQr7HZVPum6u4j+OaEi6Hc8a5eyObjC?=
 =?us-ascii?Q?Lda2WJ+Z/sKPbZ5kT0IYqW7Rwvy3KrNqiZc8tBrZAuNuj1mwPNd8/CSJJbkD?=
 =?us-ascii?Q?u08IJ+XLN4vqvG5PiWMHoeJypih2hHDJS3QlBF+69FRphm7tubW5Te1Hq8f3?=
 =?us-ascii?Q?wBiY2YAo3KlfChfqHVdhWdCsWDe2JY3NoGfB6dyaMIcuMqpChMdGUDENokGe?=
 =?us-ascii?Q?IKQRKbzb6aqcR4Kd0CHqsGfZb5CScErmn3tWwIbF/6DuGOfdgsOZg3cMO+Ag?=
 =?us-ascii?Q?ociIv2MaJbXKSz4wwu73A/YEiFiO6jcByDO74OAgvSiUNqUnkddy1AP2D3ju?=
 =?us-ascii?Q?sGYuXc6+4K8IOM1euMBkH4Kwj8lDSL83gO4hRdFG368S3DDZ/LxmJfuIinAz?=
 =?us-ascii?Q?XpM+ZmkSDoQYoRmjwI2txxbD/yaj+CCGruNqfjiHvUrKdERZ6oCcNo3vWtHb?=
 =?us-ascii?Q?eHQ65pcS5H/w3IEQBVRSMcw72YQNjSMZNVSsypF4Zw6Sp9uIYtQIaDDlujH5?=
 =?us-ascii?Q?7wDQIap7R3wMAR2r6L37TynfsCio2X3yo3MzINXfr0ijIwrcL+oGWj2N0c78?=
 =?us-ascii?Q?0WGYdwYN+5k+Io6b9xWL/uz5cyojHVittNepSBgJCWJA8sBaIKFk5NHB/NPM?=
 =?us-ascii?Q?UeNCaupNOSnXrd+JM4aMa3n2X1/Yaqugmbk1+3KH2ZvFhumEaERkCLwIX6YO?=
 =?us-ascii?Q?2YCBQUsZIsXE4TUNHgMNaIq0trN+uf2RYkluVnwITzElRaf1YV3gqmD9Cpru?=
 =?us-ascii?Q?6aNHSY/Mc0VmxutChkZYKeV0uBAio/9+TNttCtWxcjIZ6YpP0w0hWrlGZI7K?=
 =?us-ascii?Q?wT/H6mCnVesQzWcPM77B2g4HRD3ofKs3rd59j8qdB5Db0CFk9CAwsg3ZWftV?=
 =?us-ascii?Q?XhcvJbjVDAsqZ9SctO1U5xuHMWCJU1Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TDZEWvweB+Hh5rgjtjNPjnSJL1nHgDursQP7V/LVGcBIKcGOUOt1U++Km0cgs4I81Fp0r7Byzxpz6SNyEClcubAeFfhkQuj9f5XLY9VS7jv5h38cuALoEKMYuh8nzPZBcXKW6pA8vo0St/cyYiWJlTpgcv0FrozliP1yD59m6HulQqc84waxRa/7kHfTPs8/fKRDb7mFoQNJPrO50GuNyWuKXLz3bw1hFdlrQ6UlXm72vccQipFHfPTT7PMmqNEn1oFHTmEEltNnszNqL9ssfKoX3rF3KuhAYf1IHO4C3+oxyWNmNzh00NtG+JzDYttTrLUZTqkSxtr9UzwsmAvj4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff634681-98fc-4e8d-1854-08de85051c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 15:43:33.0793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dAobMH3hJpVQIFczDqXOONTjO0CpD8idSsIzBNTboAv+0p76mYQd47WHBRZQ69nhL1yKDerAX300rY900mKWOUU8atrIvjgFE34ZWOXKUDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18348-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.957];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 220292BEC56
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 05/13] fbnic: convert to
> ndo_set_rx_mode_async
>=20
> Convert fbnic from ndo_set_rx_mode to ndo_set_rx_mode_async. The
> driver's __fbnic_set_rx_mode() now takes explicit uc/mc list
> parameters and uses __hw_addr_sync_dev() on the snapshots instead of
> __dev_uc_sync/__dev_mc_sync on the netdev directly.
>=20
> Update callers in fbnic_up, fbnic_fw_config_after_crash,
> fbnic_bmc_rpc_check and fbnic_set_mac to pass the real address lists
> calling __fbnic_set_rx_mode outside the async work path.
>=20
> Cc: Alexander Duyck <alexanderduyck@fb.com>
> Cc: kernel-team@meta.com
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 20 ++++++++++++------
> -
>  .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  4 +++-
>  drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  4 ++--
>  drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  2 +-
>  4 files changed, 19 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index b4b396ca9bce..c406a3b56b37 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -183,7 +183,9 @@ static int fbnic_mc_unsync(struct net_device
> *netdev, const unsigned char *addr)
>  	return ret;
>  }
>=20

...

> >mc);
>  		fbd->fw_cap.need_bmc_tcam_reinit =3D false;
>  	}
>=20
> --
> 2.53.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

