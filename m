Return-Path: <linux-rdma+bounces-18346-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FWlMTXKumm6bwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18346-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:52:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6FD2BEAD9
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5A6C30B6017
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6F4329C6D;
	Wed, 18 Mar 2026 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+xLwNwR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395033ACA7D;
	Wed, 18 Mar 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848539; cv=fail; b=R3BNe1/WfpZaQ5wRHHoL4Wjisa4Z7mOQ9UprK9+4GC+yBPcHn0Bb0Sx3WnARSC8w7Q3mNFywCthii3WhDmsj3TOABmZryHQ9QfH/AQmI3vz1Z0mfnZOsANmQKXEru9GCtgqP4JXk6JiXMx9tBMhWkgBuovMAyICZ0tzMalGACJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848539; c=relaxed/simple;
	bh=3vuEIOUg9tV8q4RjEju+O8LtYKTJL1t63pcpPsODF4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OPx512OSB33lbnUll4GkmySqNRaGso8bKiYX/cpDrc4i/xvPgPDY8hU4vz8KSoQgsmPkd3C0g4RYbohYgGJi/piiwzuzd0G3RqcyNFCO/L5gbNiaEvOlV/Xytwf8ICqE7WJ8ejIa6P3W6rOVCkFkOQK8uVYgC0jPAPc+g7v0I8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+xLwNwR; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773848535; x=1805384535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3vuEIOUg9tV8q4RjEju+O8LtYKTJL1t63pcpPsODF4s=;
  b=Q+xLwNwR0FKY2qv3xiKFq3pvNeRlJyL1RJxTkw229LY2kSs+mEoIFvwN
   Gu1zU8BMMLbQA/K02I0tzDP9RDBZCgEsZLDkCb2inQepYKsYmOkYU6C5e
   mA+Ez4yPNzPZpz3S8vdEvEPS4eI01AFwgxGGsvJsICvnYEOTUcAARKAln
   S0w5rHS2hxsw7F8yXRoW9CBRChd9vsktz7zBbCr5cH2RMzQ7HU3cunAxf
   AaSPRWlzaggKGp/AL+0OA3mWEq3UZ7fck3Wjv3EhHDtk78mNwNX9izOdQ
   auM9hDKSaUmeK9onkUzQT11wwVozLWpDuzg/qBNVxPJx9ZfO/SjlTjcTI
   g==;
X-CSE-ConnectionGUID: TazgMVbDSguwNtTd+MZH5g==
X-CSE-MsgGUID: e6hmdE2OSqGnv02lRFM0Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75028115"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="75028115"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:42:14 -0700
X-CSE-ConnectionGUID: XqnNlO9lQTS8LrZawKDQvw==
X-CSE-MsgGUID: 1AbsFM74TDKS3Ze9sZyNsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="247125937"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:42:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:42:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 08:42:13 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHwrxeudkJMDXlLUSJiRbd+NwXCgXuQrpoVCAi/euT2x0DUA1Ajz+nTpsei4B0ehtc8PDt83TV1Z4KHCM6MRtaSStHR3xKcSELPKNnkTtqLlxcvTPltZuQ9oKV/qHoOhcsvtao/qQ1jmwVmnVjMNCEvO0uhCL6CPw2xtDB6Dc0OnWnXbsFNrTL7x6WZm/nb+rPyzuIz2THZdXMc42VTQ4g65yhNJH3dwsT5jXOakzyhysqoT9ACyAADWaYIApH2a9VidXVrKK8CwTYPLsYmZIRY4Ic3+TLnATkM/HSS/D7U4AxzAV64PmUeDbQoIDvcQYPaCVsksNOJHrhKfDo6Wqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NxKH4J1TuFzkS1Hz1R13I7PB9BhRvV/bcZ2VYkqAzo=;
 b=QZNhUrMHQGZcNW4Z5dZlzP9nt8eUHjXBCY6txJjs/9CX53hohtC41LN5T2jDHz65IPToe6Sk0N7Dj8FNyIBN7oTJ2S8J74SV+7+ts9WPOxLx4TOkmouaL0sX+Io1aetx9XuRpdBgrvmLvsXEOzuaTt1CHXM2ZtByHBqX5RrQzE7brskS7Rv+vr17DD/brOi1K4ptaZFjQothO0Xfucdk7WgXobG78Y+KalDWz3a9Ty1ix9ZfOejGVIyhzzZFHIBliP16wLUFTe4iH764jKfJLU9iW1hC0ND2PbBPlLqPdhFPlVy9i6+omM7FkorO1VupRqXftPrphc/kTK03+e5M/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS4PPF11A2D5672.namprd11.prod.outlook.com (2603:10b6:f:fc02::b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 18 Mar
 2026 15:42:10 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 15:42:10 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 03/13] net: introduce
 ndo_set_rx_mode_async and dev_rx_mode_work
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 03/13] net: introduce
 ndo_set_rx_mode_async and dev_rx_mode_work
Thread-Index: AQHctuhwc+65en+LXkW7/ZJyOjrTuLW0ba0g
Date: Wed, 18 Mar 2026 15:42:10 +0000
Message-ID: <IA3PR11MB898690405E0DCA71C5C3472EE54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260318150305.123900-1-sdf@fomichev.me>
 <20260318150305.123900-4-sdf@fomichev.me>
In-Reply-To: <20260318150305.123900-4-sdf@fomichev.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS4PPF11A2D5672:EE_
x-ms-office365-filtering-correlation-id: 206ba756-6067-451d-c5de-08de8504eb1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700021|56012099003|18002099003|22082099003|7053199007;
x-microsoft-antispam-message-info: gow0RmjsujDotu4CCA3Xvsnm6aUyAsghC72uaqKWEZJceiI4CCSPXYyUtgpCFHhTxusGxE0L1RUyZhxx2lhlpPHkRx5Ej8ikpWze+vZMT82cHcddQqFzNmI8j2H5E2nl7efMyTH/p2BLi53u2B8MIEA6zumMW+WRab+BaS0SLzsKPNQwnhgqDdNK7bOYAc8JU/EUAXUi9GB+4YCXtL/zUNCvi6DQHMoUyHpHCda0uSPL4WEsIkiPojHR0Kn6Fk3a9IvdNL4UGqJkinEMCJ5WpkwMJPGFUp3q7CG/Nls/n/rbmfKfsT9GVyCYnjmNZkE1BDdel2xBruq3lsuFjd+kojyfq8GkIZhOOXwItyX7P3TxcMlNABrgqnp3JxlmXt5zpWby7+FBh6UqYQmKQGJwHhI7uLirKnvSP9/DqdtaEDmLD0YZpwA869XNnmqcNPsoTZTVhxHeZuD1aKBMRJVtMPqtMfSV2gBAXi28HiCqEfxjbaTDvyzO4n2kxJmNC8lAgqJR2Kq+9kfMXcT4RV6TrnVJ2x115tC3bHEljeA9YGz76eXbWmWlL1+g1U7N9jODETJQBaK55TOqYhnrGAhl/eIfQlCB68iK6Vc7sanUKftBy6hIZGJVXXn7D8At93Hx6knK6T1wwYJgbNdNMtluqtokMGk05CWomLcse3pVBgUB3VEC7pdwJ8gCP+y5aaZa70ffMqcVruEVT5b1VDddreq9FPLUZE6dbG0GlOG0JmcNjOcfatIEbGyVvfi6sH2EuU2SYQasrrEcll/5R4sX8DzF22iKwK4fz3K3xv4ohDM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ppPP0tBXDXJsub/s6CYT6f38VIrlb8YHk40HfMNddCOg7bELNtItKM8bZ+Bo?=
 =?us-ascii?Q?ZW83NgbHfWt/pi+vcK+Vc03pgLGig0dplEYdxab4J+Lmn/0GWzZOTCZQPzBB?=
 =?us-ascii?Q?PlAX7eTVJduWlp/XfhQ7Gq4KvXsbfA7FxxWrfkmTa048zkFEZKhR5KMB6eUF?=
 =?us-ascii?Q?1ighnfkI6+i1Pht48Cg2aibvA+ECwhAd7y4Qo6jxKFYiSXRMcoKx0FCRj52B?=
 =?us-ascii?Q?TcN11v0TQNZXhVqzA+3IC/eu0lWppP93+SPng5kU98emmyZmcY5ZesxCAxjU?=
 =?us-ascii?Q?8zvUG0i3IbprbMYY/v1J6h3oWOy5heEno3v7iTsnbl/amMRBMih6fbaMeSV7?=
 =?us-ascii?Q?dNjBWpoJ5TF/1kJzzNtHb+l1gII35bdX90nehMXoaGbkV4ARepwKcK56WPSx?=
 =?us-ascii?Q?2cU1/QJm7+UJZrSslFaUeUVq+QXi1SJZU7Mgcn8Qemvj09SaLdqhoniRzY5r?=
 =?us-ascii?Q?xjTBBJOVb8Jb3O+GDZJm6VGEcJ/8pXrE4VANp76Dz8CZs9Csiq2tuduW/tuW?=
 =?us-ascii?Q?hXtY5zXUgxEVht/ntgh5p8uwLfjtkN3AZzc+wfh/9YE9WywO9pLl1s7Rpckz?=
 =?us-ascii?Q?U6TNrWnb8GqixwnVEOaHkkQWfEn5H6irOj82x7uBKiYNiMJAv79xaAV3KsnA?=
 =?us-ascii?Q?QmeQj0jBpxE6Q5uR/8hUEOKIzuMNOq9NBGoXC1kcvxu8stD4d0dpIaaC9pNJ?=
 =?us-ascii?Q?A71GQazXQJvVCyd1O+H2qEEeAFe8AXzHuBusgwFno42WZ35hBwIkEcJM6N/N?=
 =?us-ascii?Q?laMhddPdvOtH19z/jbwiEbZ1K0Xkccvc5+QtEzG5v9FfmSeJASGhvLFt8kKm?=
 =?us-ascii?Q?tES7fKGs+ZStH3GdGhl1jR/NBt7xGF7lNvozdXenYern5D63iNVEDVF2Ssbu?=
 =?us-ascii?Q?SeswKsU22K99yfCcxbTyFPZnLizHL883X4ONtLlSFC/OZHqX764d1kTIRLHO?=
 =?us-ascii?Q?AgFwabOfwBlXI/sKC19FNna9vB8mUhVSUPQ2Mdf9BFAKesjEza0JIEwPNncZ?=
 =?us-ascii?Q?LN8xjmMJAkffxHLTALQw7tRnw/gTTL5exmcQvzwdVOWVqkhtBW19Pe/wuith?=
 =?us-ascii?Q?7dzFPX49dUiHwCEBOi1VAvXmS2GcuoJWJPghJcrk8xMytMowLWf8YTEet36L?=
 =?us-ascii?Q?T8TPxaj3LUmwksq7F/qKGz0M0J3aneder6YAx6Ll49GJiYtlCvpk44CB+wVL?=
 =?us-ascii?Q?YiAAOHaDs9RecQVHViPOyCfIIk4FPgtbgJX6x7TZFa0knxLLjj6YwovEQ2qu?=
 =?us-ascii?Q?73gwUObKIbK3i401IF5xeIsL8ePRIuahvuWud3wLVNF3Xk9TQdaJhVVF/Elo?=
 =?us-ascii?Q?c7hSyI+QciNfJ3MwFZ5YMqsLW45yQ3HrB2Eo1oLElpjCMSguiMbC9w2b0i7K?=
 =?us-ascii?Q?oXJhwldDf0fpIugJvmwvz3nI46kJ/af2vadzmXbL0i6OY4/I/bLhijuuG8kz?=
 =?us-ascii?Q?oZzGRtzl8I/RA1qgoVfb3LATpFdkMgtiaZ8p87jvzBBpjDJBObUCelYLxy7T?=
 =?us-ascii?Q?nJ7CYBqiejFJBnjLeyUY7DrNqha6/MzRTFKgCv5Y0IQ6pz0wIhMSZ9RcWUl6?=
 =?us-ascii?Q?YV+rM9TqZwAmoC9vdvD1spfWz4F3/URYU07d4xb12na20kb0e+GCBqIZVQ3M?=
 =?us-ascii?Q?CT8E69lnN62kSfncrO4TetSQ5bgkXbl2gNekJZIGX3nRpQNrWUzzEz4fizIS?=
 =?us-ascii?Q?irGvta6M8x5ciwSREQbV1kBSZM0Jfce0JrWWr9mAeGryXSvc78kcnWZEwLVJ?=
 =?us-ascii?Q?eCGrkKCKMqB2UkYJo1ziby8jjWS04aA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gARPogZ/zV7qb/leuVunD9JO+KcUDMPMv9+VtqS6/tsiFdsnRhCObJkSdqrRM+h8JrhA75JM2BEOVAg4SF2/RLkt8mjyKaeC0Pk6frqyGJCmttZ+3IbBNbrGg/MlF0uAxCmJPbyaFi+7ABpuyATE2IC68GQC/BHCiUwIgcKVoZztFs3Opi2wOOFsaCI1pba3XcmHK7PfXfTyP06rku9uMWe4AlgvGmJQIBZGyhXDZzTlHrJ2fZ6H1LEm8qrhiTxMyPHF/VEG7a9Nka1r76DRx6u8wPtltW2SoO/LjZqP66S+T4mgqHmoSZZyBDImOaGs2HrXuF07aUyc0grNnhxMVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206ba756-6067-451d-c5de-08de8504eb1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 15:42:10.3881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ph8Wp7UmnJWWi1Kqlfit18Yc2Ki5DP2HzN7zsfm2H1XfuMvyd9y5SNEQigw0IGdT4thkAFfiC0VH4ku0wmTmmxLT6vx45b7LErKC4FKRDho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF11A2D5672
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18346-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.956];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7E6FD2BEAD9
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 03/13] net: introduce
> ndo_set_rx_mode_async and dev_rx_mode_work
>=20
> Add ndo_set_rx_mode_async callback that drivers can implement instead
> of the legacy ndo_set_rx_mode. The legacy callback runs under the
> netif_addr_lock spinlock with BHs disabled, preventing drivers from
> sleeping. The async variant runs from a work queue with rtnl_lock and
> netdev_lock_ops held, in fully sleepable context.
>=20
> When __dev_set_rx_mode() sees ndo_set_rx_mode_async, it schedules
> dev_rx_mode_work instead of calling the driver inline. The work
> function takes two snapshots of each address list (uc/mc) under the
> addr_lock, then drops the lock and calls the driver with the work
> copies. After the driver returns, it reconciles the snapshots back to
> the real lists under the lock.
>=20
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  Documentation/networking/netdevices.rst |  8 +++
>  include/linux/netdevice.h               | 20 ++++++
>  net/core/dev.c                          | 94 +++++++++++++++++++++++-
> -
>  3 files changed, 115 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/networking/netdevices.rst
> b/Documentation/networking/netdevices.rst
> index 35704d115312..dc83d78d3b27 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -289,6 +289,14 @@ struct net_device synchronization rules
>  ndo_set_rx_mode:
>  	Synchronization: netif_addr_lock spinlock.
>  	Context: BHs disabled

...

>  	open_softirq(NET_TX_SOFTIRQ, net_tx_action);
>  	open_softirq(NET_RX_SOFTIRQ, net_rx_action);
>=20
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

