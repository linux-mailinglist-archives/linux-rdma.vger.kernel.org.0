Return-Path: <linux-rdma+bounces-18869-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAcgKQdfzGmlSgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18869-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 01:55:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E161372F18
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 01:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC2223035894
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3476C3DCDAF;
	Tue, 31 Mar 2026 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgJ9o4xA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2A2F60CC;
	Tue, 31 Mar 2026 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001345; cv=fail; b=TDbiuxfOIAH1T+cf/sTOtu6MgA3UokbNTW9r2ClC1lqlAj013fWg1bhMA/io9sRNZPyciJrv+iL0xvEgnPWsDBMFXEZKJ8WNUNlZ4rRTicNSIIys0E1uOPQuC4Rvh56a8TIKOcsZ7dXY5H2yse8b1bOUJV93enhQzWSp3nVEmTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001345; c=relaxed/simple;
	bh=T5F1FVPgQs+H2nZq9NMNj01Vv6pmhDAeyahzGRvPwRk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EHAL57wocD4pUCSK8nL32rOIBcSvMTiKuMOFm2nJ8lfidms3bmUYZVWEVcBYGJft+kn3jdCFxpuVvMTzMOiVOI3H4ZywMbJbzUQSGDFNMTjd0YH7q5DP2yyGOxrsMWX7y4BuY7qDLP0YBuGyLrN4Gnji5MiSH9kLBGw6avIph74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgJ9o4xA; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775001342; x=1806537342;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T5F1FVPgQs+H2nZq9NMNj01Vv6pmhDAeyahzGRvPwRk=;
  b=IgJ9o4xA2zpnI0HgaZPtRgojmVtn3ZaTWrLUMTQc8SmkQ8opE/JPTxBR
   PBFqbQRsDH+Nv2tjh/hAIi7J1nCkRLsixwyLiqTFy3vNgo9DqV/s4/Oja
   K3QWP4B6WSA5qVYYE72mJLPF+kUHTRIwv1VooStycqJYTNysG66btBMOB
   yS/PJk9LTWQQgNK0Azct2QYL524fqsTI39yWZu7SCIKxi6jfRO8gfjWuO
   O7pYgk2BZMUL/SFzD+Pot0YPcw2GwQwL0V0j0r4XHig8Rz7pP0Z98Gxyi
   FyTR+zZkIl3WG2YPxjkWwL3rYxDtjYr0JFBhBG6nQD7GhAQaKLX6HZndD
   A==;
X-CSE-ConnectionGUID: QVEqCpjiSEa3+mjXe65THQ==
X-CSE-MsgGUID: Booa6oo+QQ2M7q0phQUriA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75916181"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75916181"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 16:55:41 -0700
X-CSE-ConnectionGUID: ZPYBpPGiTRSFKm2aQ4zB5Q==
X-CSE-MsgGUID: LiPwAty7QCG6kEzhQTxdvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="223205599"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 16:55:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 16:55:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 16:55:39 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 16:55:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3zpPEI05ENrR35JTl8G6Kvl3OggXfhs3O5jnocAFeP1u2io9uyVwbezDpvubM391qhREwxUBlv2GJngi5xjJHZS9GYgx5IzRvH5k5PUKxnVK4ZyiFj3e7MySJoNzGhiIvPZTLgYqwL5d/643GZVEKxTWvQnt262ymqZlXOocPG04lCwOe0BIi9mBSfqDroZd6OB4TO9mgIY41kySOIOnIOm/nWIOqrcnoLRjarfqpxVnL4jN+BBRvGzOoXDjT8yd7w8/fa40bh2A5XxvUBJULTSZAm972cCGn9rrejeU5lfoD4aabAPF2IAaitoMeTM5RNSloQZcqPmJDu/yJOf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIhzDEIsELRq55NF4SFyhJD1s5f1RDL5GAmWWNjcWAU=;
 b=ZdlsHu9Dms2j84ulJT8ec5TWNmNWVj9rjYHlbViW+uNkwUNhL5nju6aTK//tNSGj5gfmQmupU/ild6KXeaPXXbdB5vMn10QF6T2TGgYvmKuElUKlOphfFLleyHAyaAzF6ztBQJJGN9Jc8vfAJ7KW2os8OYs0v1h52F61dwd+0Z8njwq+awCbB3Du8gUYyxoASQX4O3l46jnJ//9q87m02aj+cvPDYs5RiCwmt+kDmkYzWVrmhGkOsSg49s74AzEwrkTw1oSYmNm+ZWAHvm3xuBt2PALG3ODNXV/a6W/lnMX+9g2ZJXwiwzIAyt+7unfK5nCRTuGWPDAThHQDjPLp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 CY8PR11MB7169.namprd11.prod.outlook.com (2603:10b6:930:90::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.14; Tue, 31 Mar 2026 23:55:25 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9769.016; Tue, 31 Mar 2026
 23:55:25 +0000
Message-ID: <c547be19-adaf-4442-be2b-debcbafa4191@intel.com>
Date: Tue, 31 Mar 2026 16:55:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V9 02/14] devlink: Add helpers to lock nested-in
 instances
To: Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>
CC: "allison.henderson@oracle.com" <allison.henderson@oracle.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "daniel.zahka@gmail.com"
	<daniel.zahka@gmail.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matttbe@kernel.org" <matttbe@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, Parav Pandit
	<parav@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>, "kees@kernel.org"
	<kees@kernel.org>, "willemb@google.com" <willemb@google.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "razor@blackwall.org" <razor@blackwall.org>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Dan Jurgens <danielj@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"minhquangbui99@gmail.com" <minhquangbui99@gmail.com>, Nimrod Oren
	<noren@nvidia.com>, "dw@davidwei.uk" <dw@davidwei.uk>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, Petr Machata
	<petrm@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"antonio@openvpn.net" <antonio@openvpn.net>, "mst@redhat.com"
	<mst@redhat.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Shay Drori <shayd@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, Gal Pressman <gal@nvidia.com>, "joe@dama.to"
	<joe@dama.to>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260326065949.44058-3-tariqt@nvidia.com>
 <20260331020807.3524811-1-kuba@kernel.org>
 <ff5b2ec46d6cb639872318bdde429c46cac77f5b.camel@nvidia.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <ff5b2ec46d6cb639872318bdde429c46cac77f5b.camel@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::28) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|CY8PR11MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 576a11da-cfa0-417f-11f7-08de8f80fa4d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: mG6412DrF1LkQsrxCsxfnLVOvwaD9dgQKZjes+3PuB6/7Sk5nd6sCP/fbcT8nu2nsJdln+HopyqYHRQ99mSk5sz4bPmcCuXlWlOZ8TTW2Ub0yO5IojX+9XY4vzgqWc1W3fxJdCDz2z9rXBuiDObtU2FjidQ2nq4VniwvRgP65XdEPN8pHiHUPDICfdu+sesOu1495ro1PH9mIbscvnk1HfVZPxhXh7HtYWxEz8rkaBj57Ik/65TGdp2IsIRaaSLgMn+Yp1rD+Rfj5f8zwsM5J5Q0SB18QJxbOlm10URK+O3Xcu1MnwSPMV3kK6PunVbmh7R9b4bM9KSoQe5WkGGBgQGV+ofzmlhjIDmmOxjvghmJVCx7YHnP8u+OiKPlwNpFMSYTEgm6VRXpIuqCZSltOEEJ5CVN9rT4RdgXRFTvkqiIuLJJXv5mL/6qLwxJzY0XdMZkzDJ//L7ZVfBY2vndcGMHp5JkPZn1vQlu0j4v8MK0427rJd0FLDjloLiVr9CjuZj1KMNCRHeCYhxhbbIrn2+DRa+P1hntyrS3npmaDYIpc+s8jT6kLemhvbIf0AyiES3spI/W6qlsBmG++iWJzXM/AEiegIqIYtjNgkemgiSz741pPPhnwBmmgGYQ4ntkwYmld9uKL/KKkGqzUtwpZowA7BmOKYI530aQmKI9Xfgo84thOA49iOcZDLqIV4VBUFr+HKAvTEGinckjzq5VIVE5F3wirs2pESIBpzcqO+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHVUTEkwNm9RcmlEUUlMSVlhdDE0UlBlL0dhY3VFZzhzM1NBQjEzMklJOTFM?=
 =?utf-8?B?OVdnSlRGQis5eURaTE5LWWU4ZWl2cktmaTNOci9HUEUyZkN5MDE1b2NPWjla?=
 =?utf-8?B?VkJjUGVUTHMyRTBVdGNZOXZlS1hZTzloOFRyd0FTYmUzS0JqeDBkSDhHOXNH?=
 =?utf-8?B?bmZPaW92UG0wN25tMGNrUElKQWFDcVBkdmtCVFFSQU5sYzNIYVZBdHF1S0Qz?=
 =?utf-8?B?RHJpc05WbzdYbUxMMURDc2dYU0p2ekF6UllCNE1SWmExd1RGZmwvM1ZDU3k0?=
 =?utf-8?B?ck9Rb01Zb0ZLNFQ2dG12SWxUbmRJWUp5QW9UKzRXaGJSYVFXVTc4ZnFkczJO?=
 =?utf-8?B?S0ZoM3FMbjFLem85S2JuUlZGa3JWK1JRaDc1SU14czN3b1RFV1ovYnNPQ0ZX?=
 =?utf-8?B?cnJpWmlvS1pUcjZ3a3dOd0gwL0VYUk1KYU5XMllaZ2dDNmdrTzdWcWdJWlN5?=
 =?utf-8?B?b3VKSzdXaEtEdlBFdG1pTlg4MVp0bmo5Yld3MUNVbjhQVWo1UTh4TGw0N2I4?=
 =?utf-8?B?MjBKTGV5bFkvMERIZ1ZrdTd2Z1puaURqTkNtbkRTN3BtdDJEanY4blhQWGZD?=
 =?utf-8?B?Znk5SXNod21lUjZNMnJLSTloUk5OU1hCLzJJNHg5ckdoMWErb05KNUFBcTFV?=
 =?utf-8?B?WDdwRGN2emsvNmxxTENUeGRWcEdYbjcwODREdndQOWszREZ6UktRMjJQUzZP?=
 =?utf-8?B?anQwRVMzS3cyKzZVUExGeWpacnMyalowckNhaWh2VlFvQ2tWSnhhbHJ6Q0tQ?=
 =?utf-8?B?TVhTZXgrQ2h4dk1KcTdobHNqTjdhMnN4U2pKd25XcU02N29OU2pHNWJpT3k5?=
 =?utf-8?B?eTUzdTlHSDIrWWZJejNjUnZIcGQxdEdSNHlPUG43MTZ2Z2k5U2FaZTdURFps?=
 =?utf-8?B?dXlZZnV6R2VhdGN5QVpCSkN2UHRhOFZtbTFhcXN0MVU3ZWd1bUlVUy9Ga3RW?=
 =?utf-8?B?TEJMcytXR21QYmgyZjFsYlJOUE1qZjZxdXJZSFRabG1QQmd4MUxWa0N1T0JC?=
 =?utf-8?B?VUo5N3pvaW1Pd2VXVTZjci9OWUR4Z09zUkpHeWdlckNKOUNINHVMK1hnUkpX?=
 =?utf-8?B?bHNqUExzZmZqQ1pTUSs5d2tmREo0ai94V29GN0NMeko4N21ENnc5aEYrUkZ4?=
 =?utf-8?B?anRYSCs5dGRTZlRONU4zbHZRdXJUNU5FSkFpN3YrN2pkQUUxT3h1MjZHYnVX?=
 =?utf-8?B?ckM4YysvRWN0VDRBQ0tvU1RrbFVIMFJNQzNHQ2lDR1JrdmhYeWpvQzdBc04y?=
 =?utf-8?B?Q1cxaVM3cmdnODNNcGQya2MxcGxEUHQ4ZG9CNEMxRThTWDM1V1pUd1h1Y2VF?=
 =?utf-8?B?WHZzVG9LUXB3OERrSDQ0SitxK2hPaXJOdHJ0T1dNOXFhQ25xUjFOamdIR3ND?=
 =?utf-8?B?MWIvelY1SjFTQ2hqYmJwOThzb2lCUndOUkh2VnNhRFROeWc2aTNjQUJTdVJm?=
 =?utf-8?B?V1QzdG1HLzhIMFd0TVhkaXlMTVRweGp3dkN2OENrdVFSOFo0RzRoTkswREtB?=
 =?utf-8?B?bndCM3NUSVZVTkVWSXZEZ0hTWGx0djU4TUZ0UDU5dXpnSGwxWXp0YmlDb0JT?=
 =?utf-8?B?b3RLV3Bmd0tUelNkbG1PZStnSVUvYVNqdzFWdkZrVjN4eXJINWR2STNGbHJ2?=
 =?utf-8?B?RXVvTy9CY2RpS3hkZFRQUWpCa29uNC9yaENHNEFuTmFYZmd4R3NyK21CeFZ1?=
 =?utf-8?B?VVhubG9KcFlGVXBLWjdGQ3ROT0xCRVYxMW5FdHpqRVN2d01VRTA3VkhGZTQr?=
 =?utf-8?B?MkNXeVZIQ1lLbk02VzROcG44UkVWZkJmeEdxSHFUMHNrRHdvcm1hd2V4K1NV?=
 =?utf-8?B?RTQxZTAxL3c5UGRrQlM3ajRXVUhvN1liVnRhTUF2M092V1EzaXpRZ0JTUHhB?=
 =?utf-8?B?TS90UG8yTmtMSEtIZm5oblZkQkRQWGh6MlM1UVVMQ2pkOEFOV0Z6VHE4L3Ay?=
 =?utf-8?B?VE9CdEpwR2htUGxrRHc2ZWlhZ3Z2b0xCWHFwd1dNV2pDZUxCQThpUE05dktl?=
 =?utf-8?B?cDNjNk1sZkRhTkNBR0lVZDdpWmUzY0ZPK3dIWWRHbHpKZEllUkMxd3RLY0Nn?=
 =?utf-8?B?aUIxWGgzZFljSUxNa2dHZ0o0WGdBZzVHZWJRS0xuemEvbmtreHlGcFNhZ2w3?=
 =?utf-8?B?MG9BQlBmcUtvTnRZcTJodWVnL2dYM3VyczFZQ0dHM2hRc1ZVa0tWOW5oNUx0?=
 =?utf-8?B?VGFCdUZXMDhuK0UwK2RlWHJDVmRRVURHT3JOckdPM0xWcFNUZERad0hrc0RG?=
 =?utf-8?B?Y0hMcmxnY3VZWTlrMllBZ1lZeTFHbFVHK1Jtd0JVNWpielZrbHBaQXVOQllT?=
 =?utf-8?B?NjNYLzVtVksrY2pUOUZUK2dlMEV0bzFXOUdoZ2xwcktYTFBjbU9FcDd3TVZE?=
 =?utf-8?Q?Ymy7qL40AT7HuV5M=3D?=
X-Exchange-RoutingPolicyChecked: PW2qzZ3mUyetpz1LLNHr8R/x/Y/YhHZUe+q0sb0lmS38vTaOTnp8EVv8TdNWYzM/4tmC6BVvi24Oznkt8PMfMpMiI4hiFi5tEk45NaSUTvk47FDUxCb5g+1/oVzktfPPL78HzCG2wmQPycNw5XkyfOQ1q4FDR824rm8xUmuck93IkV2lztqrX31tB67y9lQFKtrkD1u421OZnwrLHlz5op0M4jt9T9cdtNglGtVvjxmD165q/GUHPIU/DLmRga3oSUJkOCHUXgX9k4fMUQn1ZaptGal42iKnXb3JQdWNCAi2CP93HcrugKDdCdLKyzD7ob2r+4dtC3fUbKTOg70q5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 576a11da-cfa0-417f-11f7-08de8f80fa4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 23:55:25.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsgRdiNx/9jTBFTa/iHTvidTVBziR6ri0RtXvgxd7Ytnu7PjnZrmrl1iZwAn5rGnZAvRp7UjHRLzhOQiQkyaxBsjXPHNJXzf3cQ2tUkRLgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7169
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
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18869-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,nvidia.com,resnulli.us,davemloft.net,gmail.com,vger.kernel.org,kernel.org,redhat.com,lwn.net,google.com,blackwall.org,linux.dev,lunn.ch,iogearbox.net,davidwei.uk,linuxfoundation.org,openvpn.net,fomichev.me,dama.to];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4E161372F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/2026 5:20 AM, Cosmin Ratiu wrote:
> On Mon, 2026-03-30 at 19:08 -0700, Jakub Kicinski wrote:
>> This is an AI-generated review of your patch. The human sending this
>> email has considered the AI review valid, or at least plausible.
>> ---
>> devlink: Add helpers to lock nested-in instances
>>
>> Upcoming code will need to obtain a reference to locked nested-in
>> devlink instances. Add helpers to lock, obtain an already locked
>> reference and unlock/unref the nested-in instance.
>>
>>> diff --git a/net/devlink/core.c b/net/devlink/core.c
>>> index eeb6a71f5f56e..db11248df7120 100644
>>> --- a/net/devlink/core.c
>>> +++ b/net/devlink/core.c
>>
>> [ ... ]
>>
>>> +/* Returns the nested in devlink object and validates its lock is
>>> held. */
>>> +struct devlink *devlink_nested_in_get_locked(struct devlink_rel
>>> *rel)
>>> +{
>>> +	struct devlink *devlink;
>>> +	unsigned long index;
>>> +
>>> +	if (!rel)
>>> +		return NULL;
>>> +	index = rel->nested_in.devlink_index;
>>> +	devlink = xa_find(&devlinks, &index, index,
>>> DEVLINK_REGISTERED);
>>> +	if (devlink)
>>> +		devl_assert_locked(devlink);
>>
>> Can this dereference a freed pointer if the lock is not actually
>> held?
>>
>> xa_find() acquires and releases the RCU read lock internally. When it
>> returns,
>> the devlink pointer is no longer protected by RCU or a reference
>> count.
>>
>> If a caller invokes this helper without holding the devlink lock
>> (which is the
>> exact scenario the assertion is designed to detect), another thread
>> could
>> concurrently unregister and free the devlink.
>>
>> If the RCU grace period expires before the assertion executes,
>> devl_assert_locked() would dereference freed memory. Should the
>> lookup and
>> assertion be enclosed within an explicit rcu_read_lock() block to
>> safely
>> assert the lock?
> 
> This function is meant to be invoked by callers already holding all
> locks from a given instance up the nesting tree. Calling it outside
> this context could indeed lead to a race as described, where another
> entity unregisters a devlink about-to-be-asserted on.
> 

Hmm. I'm struggling to follow this. If you already expect the parent to
hold the nested devlink's lock, it must have a pointer to this devlink
instance. In that case, why would you even need
devlink_nested_in_get_locked in the first place?

> All current callers hold the locks, but to make it more robust, I will
> add the rcu_read_lock/unlock section around the find+assert.
> 

You should at least do that. It is the correct pattern when dealing with
reference counting data structures from the xarray. That's already how
devlinks_xa_get() is implemented.

>>
>>> +	return devlink;
>>> +}
>>> +
>>> +void devlink_nested_in_put_unlock(struct devlink_rel *rel)
>>> +{
>>> +	struct devlink *devlink =
>>> devlink_nested_in_get_locked(rel);
>>
>> Could this corrupt the mutex state and cause a refcount underflow?
>>
>> This helper takes a devlink_rel pointer instead of the devlink
>> pointer
>> acquired by devlink_nested_in_get_lock(), and performs a secondary
>> global
>> lookup to find the devlink.
>>
>> If a caller mistakenly calls this in an error cleanup path where they
>> did not
>> actually acquire the lock, the global xa_find() will still locate the
>> registered devlink. This would execute devl_unlock() and
>> devlink_put() on a
>> devlink the current thread does not own.
>>

If the caller already held the lock, why is devlink_nested_in_put_unlock
calling the devl_unlock instead of the caller anyways? That seems
confusing. Wouldn't the normal pattern be to
devlink_nested_in_get_lock()? Oh, that is a separate function. Ok I see.

>> Would it be safer for unlock/put helpers to take the exact pointer
>> returned by
>> the lock/get helper to ensure safe resource cleanup?
> 
> 2 issues here:
> 1) Mistakenly calling this without having acquired the lock. This is
> akin to saying mutex_unlock is dangerous if the lock isn't held.
> Technically true, but moot.
> 2) The rel argument: It is intentional, so that all 3 functions are
> symmetrical.
> 

IMO it would make more sense for the put version to be a put on the
returned devlink pointer. I guess its not symmetrical, but it removes
the need to perform the second lookup and it makes it easier to reason
about the pointer you're releasing being the same one.

Having put take different arguments from get is the usual pattern for
such a behavior.

Also devlink_nested_in_get_locked() doesn't increase the ref count so it
is sort of "relying" on the caller already having a reference to it,
which makes me think its not very useful. The only valid way to call
this function as it exists now safely is to already hold a reference to
the object, which also already requires you to have a valid pointer
making me wonder why you'd ever need to call it in the first place.

The only example you have is to make devlink_nested_in_put_unlock() take
a devlink_rel pointer as its argument instead of just calling it on the
pointer returned by devlink_nested_in_get_lock().

This implementation seems confusing and likely to lead to errors.

Thanks,
Jake

