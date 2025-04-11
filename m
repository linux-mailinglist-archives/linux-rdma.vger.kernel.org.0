Return-Path: <linux-rdma+bounces-9374-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5B2A85BA1
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 13:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB1D7B89F9
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 11:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD154278E4B;
	Fri, 11 Apr 2025 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amK0S0h/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37CF238C1A;
	Fri, 11 Apr 2025 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744370971; cv=fail; b=ghAF46wAoo5UNeZ51McHTKJhaTicmhP1o/EDByIblbq0L2NPJ6qsb8dCkKHrc0k3OwJFPH+d8Gz36Jkzi3ojo1I4tg/4pJrhuGaZkpPfo3F/WFBimPpceLb+FEerNPpxS0OdAwHaHs5dAOmHsihG0+cJJCd7W8+0RLue7WSABR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744370971; c=relaxed/simple;
	bh=sshYi2jCZ3zF/JfBSfxFw2yknYxfLDtYTG0D8vYEHuA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ejV06ZmmMnyp22woxHm2LLhpdDpepZ34lWj9akA87vAmfQSf/2wBYsyXVQRBByuBpuHpv0mzDJuRoT2RUDMJWH11KKGG0tcYij6/H6bZYdYYz46f5fgrcqgXJfff1kEnJv3jUw01UUYzDJDk0M0GR3uCWHDEc+371VzpIsaE3nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amK0S0h/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744370970; x=1775906970;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sshYi2jCZ3zF/JfBSfxFw2yknYxfLDtYTG0D8vYEHuA=;
  b=amK0S0h/RPdSQZkb4P479oFmsoVThJ0LkL8ipcRS2MZ0Gm0YaB/madHE
   /VsGGFDqPMYtr021zyVqfkU7v904H4ZHk9aEwWcRVm64P6JZoRSxjEuYE
   avAFHtK4Dbf0hYpVNWrGlxsjS+jpTIgvyBp48vtKbk64JS9/sWnHQlvhr
   9Js5OQSzHQpIHvJtHYjT3OIRF0o29UpJ3x4wiI27nAwqlaHsLmapLEve/
   dD23R3bIhLSDC09gWxnlXCE1C+lMwv18O8PvXwin+sJwpTXUqII7ei5Bg
   RKwLKrixMTrDEDDqRV5ZJOS1jUXm5nDqtpRXdGAmpmGIihBpOvpKd8MQq
   g==;
X-CSE-ConnectionGUID: 7ldlz+3NRJyMcIVt1CI/xw==
X-CSE-MsgGUID: SxrUQVhmQZ2aa5+TvzmG4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="46010236"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="46010236"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 04:29:29 -0700
X-CSE-ConnectionGUID: /ZZZyei9RpWod4laUlam5A==
X-CSE-MsgGUID: ZsHAwvm8TZ2Ueu1BdO9lkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="134153952"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 04:29:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 04:29:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 04:29:29 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 04:29:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7cskr2We69TfWCykTI90HYvY41dBm6LCpYkF/55SG+o8SDeHNgyrtV5lRv1BWillAeGDsnwQrEDi7GFKn7E3m0vmR/xsunNMF6/dTPnXSfeNQUE8agy4UX8gJyPAKd1AVVPB3pCQuTP4nt5dZEmwRJCTeDTdtMSlNLxJbPJroyFUh+1DHBlGi19ZCBiKT88/gocCPsZszqjvRWuEuaXoHNSojw2HjQ6MfVCfZtaFnCqPCOQnDIbjOUnggQwKM+tULTIcCop0uEeGIXOimat4Dl+sQybUwhuSylnBjFmKP7PlRghSL4WOdBF7Ssj5fShtWiPBtfPXdsufuFWeMINQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xQEbQaTLIodd5xbhPmRk0p9KskhTVHJRvhE2KTnOY4=;
 b=vHBJ2q+3fVRaqch9x11xeDwmoYBppXUvXeWbPmAtv+Kw8Bn4TtQ3sljjDtqkQ1GLmQzcRPKQNoHl8ULn3AUImdBK/aMaYc+/Z6mWG9Z18yTWSVzRsr+c74xbuluUSYS5B6hE5LAH8ZM6+oQ9jm88DQGQjLVJVUq+N1zI8381P/reywiEqXNCHX6V3AVPZghO7ILVciouJgUZ4B/aDaCILG43pOatFhm2ZR+uD5km9yyNVUlCKYZETZ19jI50AnhanPtFb71sDtm6DhQfpOuXfEDetqSyKA+zBe5YWssHvj78U83D02ZR2cN+LkHN88CRoYf3usma5eMcPUuH3uKKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SA0PR11MB4543.namprd11.prod.outlook.com (2603:10b6:806:99::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.27; Fri, 11 Apr 2025 11:29:26 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 11:29:26 +0000
Date: Fri, 11 Apr 2025 13:29:20 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>
Subject: Re: [PATCH net-next V2 00/12] net/mlx5: HWS, Refactor action STE
 handling
Message-ID: <Z/j9EKhBnMdNLNpl@localhost.localdomain>
References: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: DB6PR0301CA0067.eurprd03.prod.outlook.com
 (2603:10a6:6:30::14) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SA0PR11MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: c94f5587-6252-43ac-272c-08dd78ec1db7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tG3ReSW+VtfKrb8gnW50O98lQfvHQ0hZ/JXIIddo6u1UvtAFdz+sH3Y5YiAc?=
 =?us-ascii?Q?nThvbcxXCtlASCyR1zfGIiOF/xRyD+CZu6cPay7mUtdTeDTBp/6NaexIxiho?=
 =?us-ascii?Q?0XLf661sCWNjItOXpCON+zL1U/mcaZU/5ksod/DfmvrxIoUhWdtFPIX8onZw?=
 =?us-ascii?Q?/6JKd32pnxNGehDbFx126XGLucmGMHGEolJvsHDTVJWatz2DONRYEtQkfU6b?=
 =?us-ascii?Q?wNs0ks+Qja2FTbN1DWyQKzxPM/Gm1IGcfTaLI2EtNwccRyo2VXUxxC1IJFi0?=
 =?us-ascii?Q?hEj8p5jd/ouua9l37tfjvwqY69lKKftVOdB8IY8g2UJLAqYyLFTWhQQcjlAO?=
 =?us-ascii?Q?N4jAcu+FfP2dg09VSx78ndt/TJR3olsgwSWyGqmd3UbYYjUl8aRzCMqfoVcz?=
 =?us-ascii?Q?nppZQQd+anmD3gWgQpkphwc8FVWPiVSOKPPvjxA2aQjOXstg3dMnLfih7vbG?=
 =?us-ascii?Q?86oIF9A3V3dAuLmbd8kv1PWiCSojih7y937pfNxqSwOSJ4lBtU3bPpY6roao?=
 =?us-ascii?Q?WZXSG0ALO7r5gjiu7W1KEuCGTkY8J+jkYZn+ulv6UXGkYUXQWFhUU6N0R13U?=
 =?us-ascii?Q?3etMChoTz8U1hb9AU5KnoqnCw2sptY7DTIRYj2kKhzcWM2LSj229m3dgahtZ?=
 =?us-ascii?Q?dFOwn4wiC6FY8lUsoPq8oZ/m4JPR1Y5jQ/F0y9BLAwIsTdujHtcNj4ZIiXhN?=
 =?us-ascii?Q?5+M0TAvnsD1clTAXWTv+FfxMrjhwMiH0dEWfUxtHA9D+uXtkAVKlYvp1G1HL?=
 =?us-ascii?Q?G4PiV+1C+1KFNbR6HTJ2OuAozcSXiXL4YGInh7gWcz478dWb9MSYnsfqUfTR?=
 =?us-ascii?Q?Uq3KC/FU11/41IG4EVGTk1LTTDhhi9zlo097HmaX1wxn6MdmisWPVMWGJwJT?=
 =?us-ascii?Q?Ujpm7sB0G3+WAwEJkVfdQFfiq/xJBdLUrkvh978BUfCum4ZoxHctT3vTyJEs?=
 =?us-ascii?Q?i6KJKW0e5lMrn8pzcImpW+5pHTTmrXH+KcGxJKoiBHTghOuhmFESuOjpvbUR?=
 =?us-ascii?Q?NlCp/klGtVK4sXpgr/J0emb7IvNZy1lITM6pv+o4v3OxLltTyv1RH2N/n8Ry?=
 =?us-ascii?Q?hiMgX/nPTz7ZBosb6osrYebpIN1DSzx6Z7VmsSnCEQ5CceDfwNsH7epRuw59?=
 =?us-ascii?Q?sdL9Iv5v5hS97tl7aQA99FVdo5euGT8YhwkDEQOwTYRy1F7Z/49tL4bt2Mzh?=
 =?us-ascii?Q?tHKkNP17agJL4/p34pPoQsQfSCpTBGgi+bk40G+a5k2835P6N0/LwpF31DFd?=
 =?us-ascii?Q?TKHYAFMDRtC+BzY05aBvpLNkQhjA8Z7nPZZN9cH7x579C8KSjzcl1vd/aNgo?=
 =?us-ascii?Q?LuH1tyDSe0mMz/zh+sDn7JCUO5JTDLKjS29/gcxuLEpUzdBQ0glNbRkc9/yP?=
 =?us-ascii?Q?dQjOwH8m23HBCM4b/ncpufddv1Cz0ZSYZ0oLmZ8ZNjWyFE3Tnw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eff7Pc9lTpAmqXv6qx2QDOjrg7oC1WGFdyXPf2bZxCBNaWbljhEwYDcFPqXd?=
 =?us-ascii?Q?H3VQQhuq2DajtZ2Gw+UC8P9WWI0nvraNbarzcrp3FjFANf/5AZaBE7EZz7sD?=
 =?us-ascii?Q?H98ilOgzaw7OMyMAs4xIo84iX1b3NjgxLeLJKhFFCZ4Rz7BaEdnxKKHayZD+?=
 =?us-ascii?Q?a21/4n5xVpfQvJTsxsgEnVZ5BiXSqJNDpDg6zRQeZRSBrhpOLv6eHds8BPqZ?=
 =?us-ascii?Q?IQRu+TPnhkcnO/YgNfkpPkOUDX2i/pQc9jIZuphj5Am/jWUD2NgSjnTIkHp0?=
 =?us-ascii?Q?sN6yALkSL8Drw4PhbRhOupbzm6zQcHIsbhTzSktAXI5RScoN7gr56vq050ta?=
 =?us-ascii?Q?wwdrbXCoVrX6jKhCDVOFEls60Lh+Cvc0wBIpNtBLsUoKirxZ2fjc5imaCJvg?=
 =?us-ascii?Q?nH2xEb09TLhaer/rIv0ytONYwZm0zwLw9VyAPlCqkxhRKCbD4Ks/QwJlO2Z3?=
 =?us-ascii?Q?td8I3KvLrwioaGaCM81FLZA8FGqZkF8E9cmcLCkIZEAKkJPIosWHr0SN3HDg?=
 =?us-ascii?Q?E82vhDZCKXXwHFmzy2H0dGOdF6Q2YsFfcBT7XdeQJCHjCtkXivrsQeKrKvOh?=
 =?us-ascii?Q?UaUwVEl1uMQYyJAq70IA+lI3Ww/6pkPok1ZHVNmVSj244hLXHmeJuIv8gVvM?=
 =?us-ascii?Q?2kupWh0exWeVvD6QyAxFm4Rl2KxFbGTekw30KfDncDzVwauIelL0xhT2BHeQ?=
 =?us-ascii?Q?FBYps2wEjMjDkNIRd1JoATO/wg+olZJ+psCMuHjFQl5AmohrC2rE5bnQVQUh?=
 =?us-ascii?Q?8lCezwCTe7Amec883/faUPYDMOv10loGorZ45AT5N8lv8Pl1/apc6Wu6TwHf?=
 =?us-ascii?Q?88e32tj7e0Jy6Z90c+ntcfjtkrW2wUGx1FqhLdHuBWWqyLfGe+J/rKmxxQtv?=
 =?us-ascii?Q?kAsdFM5D7VbzWg4YA0iN4gJMc9YCueQYB44GyzeKV8/BIcP+XtRElus69pWS?=
 =?us-ascii?Q?fx9oKwSu1qEGhpLImDIznqlJKHyLeFmpm75wKo5Mo1c2KiC+zPKw5VYGInGw?=
 =?us-ascii?Q?gJ+uLS4iLzCaom+j52+u6kEv3tm1LPs4UZjBh/4GLLFutEm3Gu0W7h6NAZ74?=
 =?us-ascii?Q?YdzEgQIB+pEZhDAjlpxI/GEn/AuMmrpo6IVFfW62B9lG5IUhhppjLAmwdREA?=
 =?us-ascii?Q?euFDlyvGcKyYrf38ifN6Pu1aC3FBBo/CXqU1JABeSBJoQqz4+9JT96qo6nix?=
 =?us-ascii?Q?n2jwdYTlZ976P7px/dW3c1jlFcvYall9TyKyTU+Y9Hh8XYDW4XHR/riJiqtQ?=
 =?us-ascii?Q?XPU8FOI+iwV4nUXD7kmCnt5IjjMlR2zi7nurfY0Xa0903dxkbXST9pS2NbTK?=
 =?us-ascii?Q?T5wySTljrbHJZujmgweuQSwdOzlD8cJQ1/SyB8GGZ+Uhl0HLil2yOAjhkQXy?=
 =?us-ascii?Q?hVGjyElHDYH5mHrWHJpTSE0zxOcGpztmqOZWoS35FCYqWPfCTqiQfjMIbfkf?=
 =?us-ascii?Q?+21wcKRzCRGWr9OMeP2UGvYqA6a19a3lz1GcKHSSxjeDe68OZTfjQXRm+fXs?=
 =?us-ascii?Q?hbR1WQ6QUorUOg+FFfBRGJK8RPZzCOBS7OLV+nttTbh0Vv1EEMelWONh1tk8?=
 =?us-ascii?Q?OQTdN7zR2JLfl+NhTiS+gv3bqveDBYwQR4vRbEwLaqQANYJUdxgA+7T9B/rq?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c94f5587-6252-43ac-272c-08dd78ec1db7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 11:29:26.4533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyTyM9quqiJLneLIN8HNonPImimq7egNpoK+GfSzOphi9/aegDKhHeomxAmX0xLSKwa8SBgN9B7sCbKrhfLMsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4543
X-OriginatorOrg: intel.com

On Thu, Apr 10, 2025 at 10:17:30PM +0300, Tariq Toukan wrote:
> This patch series by Vlad refactors how action STEs are handled for
> hardware steering.
> 
> See detailed description by Vlad below.
> 
> Regards,
> Tariq
> 
> V2:
> - Remove always-zero ste_offset field (Michal Kubiak).
> - Add review tags of Michal Kubiak.
> 


Thank you for addressing my comments! The series looks good to me.

For the series:
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

Thanks,
Michal

