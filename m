Return-Path: <linux-rdma+bounces-14588-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 090CEC67E7B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 08:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A0F84F4D09
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 07:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE16E2FCC1A;
	Tue, 18 Nov 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfwXEE55"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D32D9EDA;
	Tue, 18 Nov 2025 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450297; cv=fail; b=pfPoRWBwiFsW9X3/Z/BLue76y46l55tO/lCVSAV9h8DzsjF/A0TdUhdPHYRQJPzT0aQDPn9OBRpWhnS0iFo5PtYIJQpBzupKgCwWo1gHPdFYpwusvVoOcyk9isZd4a3o1trwnvhzOrRqPTtqLcsQ83ZLH+VPHZMNUiZgWdJfzrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450297; c=relaxed/simple;
	bh=2QFG5HKxkHG/kR52d/adFZpZUUljuhweCXnKiSJf1qw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ISd5fXTfJvAAP4O0ZijmEgmap/nOof7L15JsPzffCpYaLfvf0uTLWGA+BwMEJtn6sx9x4VqqbNverf3tHqqsD2zgjM1EVR4UUhW/3bigptRKgUw+zBHLnjAVZeuLJPC/l6mM/6WgqslVnAUZf4wS+L+nNnYLU6MI/UxditrHBrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfwXEE55; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763450296; x=1794986296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2QFG5HKxkHG/kR52d/adFZpZUUljuhweCXnKiSJf1qw=;
  b=kfwXEE55pHBupiQPExzCi6UUlR1LNsJUJXzQ8EjPHC+8x5O1tEJ/bsmx
   PzOKhC9He4hwkTQ8EW3ZJVE0DYwQ2rPP4vrQ4GLVVNMTqufNsHZmcLYTc
   qgPu3CM7kHX7CKAwloR6j9Xfp/8KCGCUaIVeDIfg9k2DlH30qxzTPf5PB
   U9TxVklxTUAavqH+s/grxm2LupTH5BOimi2XExXV7sAoT2liALlqvHJI0
   ygpTjIYmNiPCazRhTcib0MZkt3vNlU4dD/Ky0jT0QMC/MTdX3JPbteMdN
   cNseGQvxXMoxj2OK1OG4DuQR+aS0oTGxokYRQQjQL53Nl2L5NFYFKKPb1
   Q==;
X-CSE-ConnectionGUID: W0bxoB9jQJKUQeleL0yvcg==
X-CSE-MsgGUID: us3kAgHVTOGbni1beh5vDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65401505"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65401505"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 23:18:15 -0800
X-CSE-ConnectionGUID: W4CyNSLrT9qTy40nafVstg==
X-CSE-MsgGUID: PNP0Cy5TRVSI8OFEeJ/4wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="214074880"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 23:18:14 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 23:18:14 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 23:18:14 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 23:18:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEfD7Vsve1ZLW+Gv1lCh/HAR6YQrproqPuXFjVbhkGPWVeqDJaVqCm52eSA8x/i1lhBbZEXnlsLgonUFtz9p7LukCBn3zZuWT4kyiUMYsKJUFKeqLN9GuAMO9xm5N5oWjmTIlLorYAF8WwMJRu+aUeEYwyk93P1cdREGBYTxmCQzd7p78vZm/HDDl5b6QcOfUWEN/5bDmZN1PPpjHB6n5Kj0DiWR9xY58vjIHsSc7PbPpg48sfLAkUXrh+Izr0w92s2f1KimuujIPJDu1aoUEpXSoWbE7AKaBKxs0SS08bmsxEKarTfVuPgIuPw6AccH1F+eE8ln4HBPHgM1BD+HBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0bs4CHhaDMMDwI+oQY28XNuuCiJkW+kT8/tOdza+lE=;
 b=LvKhxkGm+WcAaRa7KWY033T8ryBXJd5UQCau8eke8ZZNVc8L0Ay2meWPHVFZFEuSO8+ONOK/BEMciXi65D7sckWlo1G3WJCqAeEbfhIHcZ+DHabYE49mhE1LaEETP7I9NjiBT2mbpbnoFPiaRVGno050yTns+o7+rap/ZexW/r/Cx5J5PpmjZxhLfBSxSVMphbmcUPE4izJHAhmJppFHpiTlTq+8k9MicOisiD/RJC4qye3CQDVqKsgK/Gj/WnmnmC1CR6MV5IEvV3FUV36Htqc8hWgo+9N6or20yKzCKkw48hD7Fu3qOY0M8pnsyr+HoowDIyPF1XZM8Ks5yync6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB8246.namprd11.prod.outlook.com (2603:10b6:208:445::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 07:18:11 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 07:18:11 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Srujana Challa
	<schalla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Brett Creeley <brett.creeley@amd.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Goutham, Sunil Kovvuri"
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Tariq Toukan
	<tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
	<manishc@marvell.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Loic Poulain
	<loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean
	<olteanv@gmail.com>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"Ertman, David M" <david.m.ertman@intel.com>, Vlad Dumitrescu
	<vdumitrescu@nvidia.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, Alexander Sverdlin
	<alexander.sverdlin@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v4 2/6] devlink: refactor
 devlink_nl_param_value_fill_one()
Thread-Topic: [PATCH net-next v4 2/6] devlink: refactor
 devlink_nl_param_value_fill_one()
Thread-Index: AQHcWCHH3M5Z6abaBUS8c2x/Bs4+87T4BqHQ
Date: Tue, 18 Nov 2025 07:18:11 +0000
Message-ID: <IA3PR11MB8986E87D02332340BFB35451E5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251118002433.332272-1-daniel.zahka@gmail.com>
 <20251118002433.332272-3-daniel.zahka@gmail.com>
In-Reply-To: <20251118002433.332272-3-daniel.zahka@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB8246:EE_
x-ms-office365-filtering-correlation-id: d51d0583-287a-432b-45ff-08de2672a1ab
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?4Hybpjp6a+MR3KE+VyFyzfJx8ZZcG7cIfQn1dm+umQLEMFll+YdgnnKzOiLY?=
 =?us-ascii?Q?vlBztsDZ4j3WkJNkNBx+BfZ/If1vfQtIl6B0Cs9w4iFW0hd8mTUW+O/BEBoc?=
 =?us-ascii?Q?iuRafcwKU6dyVqRD30/UfKPVnrFKxjAXv2dJmEPk2Q31ayuCrNML3itFg7Lr?=
 =?us-ascii?Q?P7W3qDJSu1YynDnPta6GDxjVsx0cuMvw5Lq4O8hXmQLe1WjJin0CcFUu3SZR?=
 =?us-ascii?Q?+uJDmPAlKtclRf0RfHEI7eVxzusc4i00yLV8ZTS51wwTeZezPaFzwEU2PLSU?=
 =?us-ascii?Q?OcmYXXbrFHWFtR4YeytixSgwO63ykV31f9/3GbuQpptZJkYfAxv/t3PpMAUY?=
 =?us-ascii?Q?GOOsrIsN9uMxBoB6PNsjb52XcJd2nwj6be1CLNLsDgjn3T+k72QeiQfl+b/W?=
 =?us-ascii?Q?UBv9IRTLBveecO5It30zzB6X/G9MBZMNYkHcaOhP56IHCGu4Y0eFo1AMqRgP?=
 =?us-ascii?Q?aGxodOnVc1UlLEU/ih07j7oKmtUqiv0om/0sr5FslBcjaTzdwYDGIMJjsLwo?=
 =?us-ascii?Q?ruMLm4IY4EDtOoT7pB4AzLq/K8fDYA7FjNMH6Dw6MmBtfz0qUzQhSpTuSTwO?=
 =?us-ascii?Q?I/02Nke2C93ypVvHl1tanqyiLHYb94+qJD8iUZKOy8mBV506H+R3ye1LfepU?=
 =?us-ascii?Q?nHMjjiXEMcVNgv5NtcYi4drxZ8/t4hgEHTLRHUDnuzR8xf06Lxh0Qqnk7ehe?=
 =?us-ascii?Q?mn5iCprUjA03WQU4Oz4nNc8u6O/vp9XJNH+bvuByl3OdORhh5OQGSO4KXQpv?=
 =?us-ascii?Q?m819tke62pmyMOI1UkSnyZOpw5fnf6l6yf5ag8H8j7RFs2mRv3SOxluj7mJ2?=
 =?us-ascii?Q?MwtzJTZS448g9MMjOdGGH1sFh7N9DSS8hRRuFIMZtbZ4KEdViz0IFPMo9g/Z?=
 =?us-ascii?Q?oRTICc91DCIOsL7LaARhClFxTW6pMGe48WyVWuG/3W7iiwm5mtnbyvTvKxD1?=
 =?us-ascii?Q?Ptkto8XQ1m5o5Kv4qlLpnuUOtnZxwSU8n81WQVAxwPTUqXn14xF26ybYPTfU?=
 =?us-ascii?Q?3gQlF42n28/qXwN8L1p0cBXduTccg5/FMJi92Q3tUEyImRJU3qef/LBBLQzz?=
 =?us-ascii?Q?K1BlGUxjgcD4P+HxL44U0JHDFhvljEx4v3S1RmwUROt5q3az/Jj825RWH0lB?=
 =?us-ascii?Q?qTSFWM0nmJb3vG43tgrydJYT4SE8za3SWMXIHybRiQHhSzu262RdnmL3W8Bw?=
 =?us-ascii?Q?8sMCq/KrOsaD6LJuq2255Jpg+J4DN1DKMi7b/9EKGRyEUDh7bgn3BecTtB8D?=
 =?us-ascii?Q?kdlODLixn02Li+dhMTR46Z7sq6xGz8Eav5Vwk11No7A92ZVyHA6HEL/dF6Ql?=
 =?us-ascii?Q?+aOK++HmCFGvcJ8QdkVqyPqJmW4yOoZFz9KLj35WmYuQjOgJsfQ7ltQKQtsz?=
 =?us-ascii?Q?lz6OyvxWP0VwC4YynnrcEnIweM9XWtQ7yTJENfMPEW3Lp1NHgyPvdgaMTcLh?=
 =?us-ascii?Q?Zs1KlCoeuPwnvxd1F+cuy9a3tSIvPha0ClM9H0sWY7Km1vn+EzE5fZlLthvq?=
 =?us-ascii?Q?cnHUxQHPru0Rx3UGcxNO69MiSk6gVcGsSgolmi9umzK/k00CEeVlVsPODw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qwHw1H2jtUG7xuW9HsmWOKxyhBPeQZdM/wziUhTfr+bKYgB7QKy5GcLXyrz6?=
 =?us-ascii?Q?iCmUKOU8auegp7YpeMU6uRlflyHcoyF8vCdaNnZFdIRPqTEpfZWoZnTHiVCO?=
 =?us-ascii?Q?cYOgDZmHuQIYLfdR6BgPi2tDPQPmw1Ai0JvnbGFqsCN8K47sQ6yT17a17go8?=
 =?us-ascii?Q?s7UbE19vEBsVFUXHTa0Ys0dOdpdHtDST9vPSh9Lcs4ErzGBBlU0iuTy1DyN4?=
 =?us-ascii?Q?KacOUUE/PvfBDAD7tCTo/T19YFIWMJWQ3mMEszqPaDLslSwTT2LSQmri9t3x?=
 =?us-ascii?Q?r2Qs0B1P6EynfcnRcbdWMKzJTZr6+RbSyHfhfjWcWaIun8TbEjv+VhwRhJJ0?=
 =?us-ascii?Q?gmpzb4QqG9zVqNtHXWoq5qt3pRDkJ/bCts8WZpDdtH7qd9Rw7/eojZyngg2V?=
 =?us-ascii?Q?h9XJis6fg0EJvAI9lOqNkDpCkxHHE/4IUrYbRHuYjMvOHlw/YtHjiBBBGw9W?=
 =?us-ascii?Q?ZY8g7kdu/0wYIQzwITUrOeNH47d/+ysPYrjINn+JSzQkYiqs9C0ueYWpDBDR?=
 =?us-ascii?Q?kNsDyqedsgxwPSLnur78A79CJcKv3qtVjIzOL3VEzghv0zxeCzPSEibEv4BK?=
 =?us-ascii?Q?egx3jAkqp7fL7mBpw5VOsHuNKmIiI3sr58WqcmgUZyg2KMvzqu+0eK+lP6i/?=
 =?us-ascii?Q?6oKeO2CcuHSSkrrpQiPFrX3/y+ieA9r9eY6HSlhtm4bU0Tja6remqjXzradJ?=
 =?us-ascii?Q?jeD/blqkTvr/6NjX0jU+/aq0Ag75QpMBxj0lksoyJJ0IPGe8jZF+QA/rONl2?=
 =?us-ascii?Q?eQatRANc1TbKPEgmAmgDGNi+/IHcDHiVWxjgZCXG6TInm+EgblXDAyPqAQTD?=
 =?us-ascii?Q?vAQwgEnR2edwWtIg/qyfZqhoEaorZd1H5rDUBjKHw5N8mEgNb9enWBtxUhGg?=
 =?us-ascii?Q?2gDZMh5U59cphSnhk+py1UJcphrkWaEDLPm5r4hzyOpYmOQpa61yblRAjjxM?=
 =?us-ascii?Q?7CmPGCpZOfWcjNSqHV+rIy9YqdOji7Or7IPslcsG98lkN2I9gUYtp+ks4amV?=
 =?us-ascii?Q?7kyaf4nWzTN6serTvvy7TbIm8Cew9xhDvakgMEoaS+5DysnZFcA/9fiiVLmr?=
 =?us-ascii?Q?oArsr0f8aaKGag2et766yrO9T/mMfqvTUAhxWvN9k6EZ880ceRdDU/G2VIKZ?=
 =?us-ascii?Q?4C2AyB4EOg1GTj2y+bGJ2Ihaynuy8W25Hq5+Wr0QznEoO+CRKMdt4WqIoKYo?=
 =?us-ascii?Q?gpgM/b+4lp9xuizO3ZdY5fb9wF5P0MqDSBGoumj3Rwq7eA6j2hRTFZRXRZ4s?=
 =?us-ascii?Q?WSqDN7io0MLCIXLGr81waSYl7eMiC6wuoAd4gRBLx+iUQkLET4BKHldTfrbm?=
 =?us-ascii?Q?7wpeJlGG5ooamwnlu408mmpyNkcd+1qF2AMXhtln3kZ6ISKFMgC3cYl4HabS?=
 =?us-ascii?Q?cZ5MAJc3ul5y5zaeRjXAydJg1lT6o4nS05IuKz7SFiJ9eHLMtRpbguXIfSU1?=
 =?us-ascii?Q?yYySNe2+uEorIuX6hW1wTXBqoN+GQJ3DakY9gyO4YwPX6wB3VmYcRclFzwy5?=
 =?us-ascii?Q?x8prjR3JwTGiiwZhd66LUnCOBENvsa4NgJQ/5MhAYw9A8soPmfcpwQO8J8yu?=
 =?us-ascii?Q?3RAosVRA8s/Ek9sSkxqtmm4GOqHi1TcNfCajT6u7vFH4jMnv8CTD7xAvrNMb?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51d0583-287a-432b-45ff-08de2672a1ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 07:18:11.3527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWtsgRv3ATkLjzc6amuUUZCFpVyTSt/iHg5bpj3aH13nmG4z0ZGHBo5EyJkxn0APcr4lRhN2bRVKxSUfghed276BdBvJ1pHfsWBmjBFcHTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8246
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Daniel Zahka <daniel.zahka@gmail.com>
> Sent: Tuesday, November 18, 2025 1:24 AM
> To: Jiri Pirko <jiri@resnulli.us>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon
> Horman <horms@kernel.org>; Jonathan Corbet <corbet@lwn.net>; Srujana
> Challa <schalla@marvell.com>; Bharat Bhushan <bbhushan2@marvell.com>;
> Herbert Xu <herbert@gondor.apana.org.au>; Brett Creeley
> <brett.creeley@amd.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Michael
> Chan <michael.chan@broadcom.com>; Pavan Chebbi
> <pavan.chebbi@broadcom.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Goutham, Sunil Kovvuri
> <sgoutham@marvell.com>; Linu Cherian <lcherian@marvell.com>; Geetha
> sowjanya <gakula@marvell.com>; Jerin Jacob <jerinj@marvell.com>;
> hariprasad <hkelam@marvell.com>; Subbaraya Sundeep
> <sbhatta@marvell.com>; Tariq Toukan <tariqt@nvidia.com>; Saeed
> Mahameed <saeedm@nvidia.com>; Leon Romanovsky <leon@kernel.org>; Mark
> Bloch <mbloch@nvidia.com>; Ido Schimmel <idosch@nvidia.com>; Petr
> Machata <petrm@nvidia.com>; Manish Chopra <manishc@marvell.com>;
> Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Siddharth Vadapalli <s-
> vadapalli@ti.com>; Roger Quadros <rogerq@kernel.org>; Loic Poulain
> <loic.poulain@oss.qualcomm.com>; Sergey Ryazanov
> <ryazanov.s.a@gmail.com>; Johannes Berg <johannes@sipsolutions.net>;
> Vladimir Oltean <olteanv@gmail.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Ertman, David M
> <david.m.ertman@intel.com>; Vlad Dumitrescu <vdumitrescu@nvidia.com>;
> Russell King (Oracle) <rmk+kernel@armlinux.org.uk>; Alexander Sverdlin
> <alexander.sverdlin@gmail.com>; Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: netdev@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Subject: [PATCH net-next v4 2/6] devlink: refactor
> devlink_nl_param_value_fill_one()
>=20
> Lift the param type demux and value attr placement into a separate
> function. This new function, devlink_nl_param_put(), can be used to
> place additional types values in the value array, e.g., default,
> current, next values. This commit has no functional change.
>=20
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  net/devlink/param.c | 70 +++++++++++++++++++++++++-------------------
> -
>  1 file changed, 39 insertions(+), 31 deletions(-)
>=20

...

> --
> 2.47.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

