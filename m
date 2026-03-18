Return-Path: <linux-rdma+bounces-18343-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APjbIS3OummfcAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18343-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:09:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 984D82BF0B3
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD5D5318235C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C638F3CD8D3;
	Wed, 18 Mar 2026 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAP8btGO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD43E51F8;
	Wed, 18 Mar 2026 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848470; cv=fail; b=S+LSDBO03MM0kMerVoBcphm11tmTub+6L+WO1S9+7r1o4yf/HLQg42EyIVx9Ht/B3/aGGl6u4+Dh9Cu2UXhsZ5F2//4Avy5uaaAqZBCVx4ebO08V43K9RzgF3N6LwH24RGZSqR+hFbrIB7F9axq5o3OAPv8o4t/3zSJBABmY7aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848470; c=relaxed/simple;
	bh=KZtTeT5XqNTciYK4gVk+zJTAhnmsG8qpeCJK5A+JtfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fwKxbasmZqXfuIlaMDLhJM2kXSaQt1ippmoHafC24HfIseAY/1v48z5j3Yyf+8bUJbsq4AP1Wbu6hJE+Cq6VUkFBRPULbraJvx3YEVfRnAeugdQr74X9qLK/mAOf9+0batgtixwNzNK4nWzfz8WYQcBAFVALG3kUqlOMrR0PW18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAP8btGO; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773848465; x=1805384465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KZtTeT5XqNTciYK4gVk+zJTAhnmsG8qpeCJK5A+JtfY=;
  b=FAP8btGOIrBhza0loZwx+jcHMYh3hOhzyUU7M1p1gTwn5NpPFyq2J6fx
   eTB2/WTdATgVwlwRqu64DUrBulfywqDyuw0uM4OjP8fuy/B1J3dsym05d
   PGX/S5zyx89ZcgZGg99r0T0j4e56c4Tr362yNaJsnOkgOoATn4TKqGsQI
   QuYYOI8CFDvoSrz456qWgffbwkM2O9wTI//fCMW0wsZBAAIUibCSs6FAE
   BWtYgdJXTr1nzNrfDDrZLwhsw/4++JJwdgADx/W8rP8U8CrfhM/aiQ2NT
   HT+pfub0Zb76DhtniTqpoHGVPLDuBiZuK7dbXt5fz+/3Fz3MEGAScuzwk
   Q==;
X-CSE-ConnectionGUID: idglKPwXTV2TlKtXph4HUQ==
X-CSE-MsgGUID: fVcEYMkbT8Oekg7028GwaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74606123"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74606123"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:41:04 -0700
X-CSE-ConnectionGUID: wr2p51lsQsC5ikB7Y3VhHA==
X-CSE-MsgGUID: d4LhSlJtR66m7Mky6wVkfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227353025"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:41:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:41:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 08:41:02 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:41:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIt0PUO2uV1Z+eJN24CCrgQn+FLkpIHkDAwT9JjF6CuRlj58P15WVKVC5hmfiZ5YCopN3U5q/BGxAQ4LJXCdE4KlZLRlV9BDssdQvPUbV38V4LrSf4BhyoR0rdFCqkVACnHyJS6uzQxWhzFgbxaEU/Bk99X2ZRJt/DDZsxwyg870hrAS75ssRe0wPBZ94yAV2HYroQA+ai1561aMSU44GBkdlRXwwBIhZm/gFfHaPs5+FuALAa1U/wcrdoH4D5s35WESPoGlByU4zDPaDcqqU8wM9guPqWlA+s7a+uB+nfgBcwET89R/s1+rPZE6KLDgckKqCHhTIK0khqfW9knScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8NWObKLT+a8zpsAfEQq05EsxuRzNe/gXKF+QwHQQ1c=;
 b=ocjqXk5gMYo20QMMYKNzFjvdz+tYH6BRRM3jXZFOAi0AL5u8BR83sBh0U8WHbd2JPnrUv98OjHTt61fku/QyQoyX4EeJuQj3VHukJ3t82Vt5dmt0v1mNxMNhPWewOqO2Vv528jtvvlnXAOFIFmvuzUliQGpkFY4zSQ7bVpP9ptRpaDpiRO4zJiO6lC7gpu0202Uzua+yTfR4n0GqDC8Ci5G8Nn/0i4z8O+PiotaGOGUWnyw5tordiYV+OsKzk5AY3Ci0j/wF+JtoGg75EfCZjJk5fCNnLy4tPaDp75dXJ+qt1GZsSb+i+zgOUFWyi+jp5JuoFQNr4urttMZCg6qg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS7PR11MB7907.namprd11.prod.outlook.com (2603:10b6:8:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 15:40:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 15:40:58 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 01/13] net: add address list
 snapshot and reconciliation infrastructure
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 01/13] net: add address
 list snapshot and reconciliation infrastructure
Thread-Index: AQHctuhy9ZK7rV8t8km9ASem5KvNKbW0bVNg
Date: Wed, 18 Mar 2026 15:40:57 +0000
Message-ID: <IA3PR11MB8986059F85B957AC59961BB0E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260318150305.123900-1-sdf@fomichev.me>
 <20260318150305.123900-2-sdf@fomichev.me>
In-Reply-To: <20260318150305.123900-2-sdf@fomichev.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS7PR11MB7907:EE_
x-ms-office365-filtering-correlation-id: 2d99f035-96b9-48b5-f8a2-08de8504bfee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|7053199007|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: SCYvnE0vGHzB877QiVTiAX/HC+EjQpaxEu1SlMpIhcflyqHzKPkMxGh4C2dILRXIEysJ5XXqJpEuSt6iAoGg19MbMjINdDaxuZCt+C5GFocro4ki8y86ZklYz7L4qLq86KJsYZ394g7ujVZx0mTDqezCgi+JP1VApE8JLeSQxdcs+4P39pdgDcw6mUqTBLT/sjSBzwxXhIuMrVSXSCngov/Q1bNM3mqJGnROyG9vZ2AJKKhLgHK4laQH5sT52az8L23DK71YafmM6MLrRHm87//Xp5gLInfMO98RLYEH8K7kfMjVHkdX33M2X+jwQ6Rx9Y2pxWN+pKZUDWf0k6GIxnuVR8FUkIdrYnRmK220MLw9bR93tuoKpVaLfPzlZDahtcciLpDspYwUPFEfZlLN4rBuSIgxmMXjO9VuUnybfMBGeTJ/g21Nkx0EcCvuwIYeQcrrPYcqj0JKf0dge8p+eRshF2keYe5ZdC+mbh29tS0zQRYOn42uNfu+25JrsncGadrts2a2cBOiHDDt+wJ4WImjyhmTzY3W3HqBgooaKvp1nGIeYRy1thTNM0SayvsZUExK46vAgnggmdnx3Ux1qzKqQqn4XHyINZsqebupKzJ+6ivJrI0ds+0ohNffeLe79Tvxmo7wTW7YN0xpP2zHqUfqoVcaWOAyp/Vzeo4FxbJ3Uaw7a6VHLkPCmBGsFuPxRNzx8s5YHNUAQkoJtDw/W557wdatXNG+SiPwfuZl/1ebjT/jOED19+3v1QrbkwIkodvsFlANDTja87amO21lDXDpkqAM3AtPR5GOL/0trt8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+KMc4+SUuyBqYNxhv5D9u0N9Kl8LSKr5xvtxBfLew1CxOcaTGGNga9lfvHfK?=
 =?us-ascii?Q?nkMxesOMgiWRkts1G6lZ9KWkfwFS9i23Yp4PqhZknyIVdzqx0BqfW4Z95afP?=
 =?us-ascii?Q?UbvKbnK2CyeLWj3hyRm6zdjjBFCrowOGYKfFIqMRDy2ucXjgspaq+Ot8PTGe?=
 =?us-ascii?Q?LXTLXkbFIdeC9ihw864vJqpuROMR5yvDrmQNnkpJiAyrqiBcRqo4Owkh+fO9?=
 =?us-ascii?Q?fe293PEtCJy15ox2g2zWertyoETK8l4uNBxFEqJeVXOHEnSAQzm44qc2Ytah?=
 =?us-ascii?Q?8dhEVlQXHEmfuTQp5+sNxdU99Syz3VsZXPedKzfeZNG9mvWEwm42wxLHvbID?=
 =?us-ascii?Q?j9o2zoAWZSsQqqR4xqoy3RYJwAY3H8JipmzKbE8/t49vT3hXB17DVgjxU1gI?=
 =?us-ascii?Q?QpPKZiRtSMklCpnoatBB2cRaD7bMf9hHWp2BHSrUJ85ONPlt+7rWarXa7Boa?=
 =?us-ascii?Q?BpSPrH5wcI6/nxuV0fMz1IOe8qGR8pY8fraUPgHvSVnszHpx6OAvLRsHkbmP?=
 =?us-ascii?Q?xHbRl6GcVpFQWKZZJd3Jfv7CLF9x4jMb+n0PeMdg+6yFmfGg9guXL8Opr9l/?=
 =?us-ascii?Q?j3julqRgpjA3Hs+UlWMCqE6h7Pu9IIYUKsuTBzq8zx6b3DC7zIa+FrLkXJ1i?=
 =?us-ascii?Q?2GPnM8UeH88CFKvOgWCFMHQB9uDJCzVFOtHFiowaYR7BGjeOPc2sig+xPV8s?=
 =?us-ascii?Q?4KFzqCAyq74kbKYQ8O45xpEayXXSRbBovPlurdwj6gOUFZ9hwlJluV/02zU/?=
 =?us-ascii?Q?z+nZlR42wJDYaKhmg/UTyS57Y5O8eakPLN2jo+jPu3wx+rlIDuce6PKUjd7P?=
 =?us-ascii?Q?xY59xDQAebeiwKqUbSdgHLGirADkc4UoGNv67ub01jjCn1E986+y7imEOTwP?=
 =?us-ascii?Q?u6TEBA04XZVRSMLsYed7dwDr6v9mPwVfcaqHn2LDrZYIzYeZPdYFUUQVFPnG?=
 =?us-ascii?Q?lSFpxNcctzzN74UHF77ntYsZEOGeDSPZ2Wyq7c3qsZptYpQzsB8SA/8OJEXw?=
 =?us-ascii?Q?ea53m9oYsMpNTr6piBw6CrSXzv0oMO4kDwTyNWB8UdN7yLU63IZohKB+lMvO?=
 =?us-ascii?Q?y2qBHRqToWA1XGaKVvV9Grk1X/hSADMKGif1vmZD0IvX/c6MYLSl26/S722k?=
 =?us-ascii?Q?ReaDmtW5UTbH1Km0RO1QRmfWnura03H9fLFF2UZDpN1mXXJshGtLrRcB2vso?=
 =?us-ascii?Q?cWM0uK9o6G2NzWgJwa9aRT/k+jWvZghKJ4VTTAC7NEi37+cAmfgxzPZHgadP?=
 =?us-ascii?Q?+i0TvEOzaluBI9tIwEL615Gk15K65MB+2ohBWoGulPbdyEMy/by/q3uSnyio?=
 =?us-ascii?Q?MuQob4t8AIN53rK4RGfPqo9qxv4dwdrK6xFecxagORUiL46tXNsosaOZ6MiZ?=
 =?us-ascii?Q?tmVXJrmZ1CfjSpSbJTOkzl30fnMyIXBGlTYmJPyMMwYCgcyFjRDZhFohGzxR?=
 =?us-ascii?Q?ixSZxzusManeE/2A1RJPnP5dSKSFEBfHxcgzp3LU2NnZlKppQpSOEQMbC1Bn?=
 =?us-ascii?Q?9nMZRLvtDbJE1fIzcrpPk9UOG2dz4NtM49Q9LffXt0Kv/xp2tFBwdiJsOWlz?=
 =?us-ascii?Q?k32H+m0J1YjNntg5l/WSRoRGuhTs27xNrj/NgRehgMdMfHOEXHLzyA3by7JJ?=
 =?us-ascii?Q?w1eiD+vq4ADMDguBhl7W5seshUMmeG4KwEOl/Yjmx+eZZtD3KZV7xrJcRP4d?=
 =?us-ascii?Q?pySbIiXTjKkRS481WwHYW/WA2xIXeKAoyH3bHMkHX0ygfnB8N28oTgoV+Zcy?=
 =?us-ascii?Q?Xjnr6qKWyY9MqnZpqMdfcF2EXSst9No=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jH6IChe8AjBSbg66IR5bqG2gEgfoj0l17ElKgyISrlI4nAXQ0ZOicRKvz8oec5BW4FzL7zI498JSLX2eSMuKFvdXDVGDkhcxZrPDE9UyTr41x5VgHrNt1TdAWToZBn8IZZPdouy+9l+H/yl8abkWI05LuiMy8lxEXKB7FhEaYxZsh+TpVczEIoZILavVJ0I7iTkAqW3y3ZkrBiNZU5IhZEF8Dxz2wmsReC8y+99gWJYNR/NsdROoeNJx/WGjU7BNjTLHhU4S+AqSqMaESCzGwl9bfwGYc/1NmcK38e8b3ut9B6P5LuT3MgsDRMfXI32cno6QGd5Uooa6tJeVi+TOkA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d99f035-96b9-48b5-f8a2-08de8504bfee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 15:40:57.9308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2xomekCixlxXL9Y09uOGglXkDlJXXN8rY0DYlS47pJLC/jK+u5Is0AMK04zL/WCv4NPDOfr0LJBjynjdp4FtrvV19kCzr2zH13mXEcdNOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7907
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
	TAGGED_FROM(0.00)[bounces-18343-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.955];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 984D82BF0B3
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 01/13] net: add address
> list snapshot and reconciliation infrastructure
>=20
> Introduce __hw_addr_list_snapshot() and __hw_addr_list_reconcile() for
> use by the upcoming ndo_set_rx_mode_async callback.
>=20
> The async rx_mode path needs to snapshot the device's unicast and
> multicast address lists under the addr_lock, hand those snapshots to
> the driver (which may sleep), and then propagate any sync_cnt changes
> back to the real lists. Two identical snapshots are taken:
> a work copy for the driver to pass to __hw_addr_sync_dev() and a
> reference copy to compute deltas against.
>=20
> __hw_addr_list_reconcile() walks the reference snapshot comparing each
> entry against the work snapshot to determine what the driver synced or
> unsynced. It then applies those deltas to the real list, handling
> concurrent modifications:
>=20
>   - If the real entry was concurrently removed but the driver synced
>     it to hardware (delta > 0), re-insert a stale entry so the next
>     work run properly unsyncs it from hardware.
>   - If the entry still exists, apply the delta normally. An entry
>     whose refcount drops to zero is removed.
>=20
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  include/linux/netdevice.h      |   6 +
>  net/core/dev.h                 |   1 +
>  net/core/dev_addr_lists.c      | 110 ++++++++++-
>  net/core/dev_addr_lists_test.c | 321
> ++++++++++++++++++++++++++++++++-
>  4 files changed, 435 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index ae269a2e7f4d..469b7cdb3237 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4985,6 +4985,12 @@ void __hw_addr_unsync_dev(struct
> netdev_hw_addr_list *list,
>  			  int (*unsync)(struct net_device *,
>  					const unsigned char *));
>  void __hw_addr_init(struct netdev_hw_addr_list *list);
> +int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
> +			    const struct netdev_hw_addr_list *list,
> +			    int addr_len);
> +void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
> +			      struct netdev_hw_addr_list *work,
> +			      struct netdev_hw_addr_list *ref, int
> addr_len);
>=20
>  /* Functions used for device addresses handling */  void
> dev_addr_mod(struct net_device *dev, unsigned int offset, diff --git
> a/net/core/dev.h b/net/core/dev.h index 781619e76b3e..acc925b7b337
> 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -69,6 +69,7 @@ void linkwatch_run_queue(void);  void
> dev_addr_flush(struct net_device *dev);  int dev_addr_init(struct
> net_device *dev);  void dev_addr_check(struct net_device *dev);
> +void __hw_addr_flush(struct netdev_hw_addr_list *list);
>=20
>  #if IS_ENABLED(CONFIG_NET_SHAPER)
>  void net_shaper_flush_netdev(struct net_device *dev); diff --git
> a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c index
> 76c91f224886..754f5ea4c3db 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -481,7 +481,7 @@ void __hw_addr_unsync_dev(struct
> netdev_hw_addr_list *list,  }  EXPORT_SYMBOL(__hw_addr_unsync_dev);
>=20
> -static void __hw_addr_flush(struct netdev_hw_addr_list *list)
> +void __hw_addr_flush(struct netdev_hw_addr_list *list)
>  {
>  	struct netdev_hw_addr *ha, *tmp;
>=20
> @@ -501,6 +501,114 @@ void __hw_addr_init(struct netdev_hw_addr_list
> *list)  }  EXPORT_SYMBOL(__hw_addr_init);
>=20

...

>  	{}
>  };
>=20
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

