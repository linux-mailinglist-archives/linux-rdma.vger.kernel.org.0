Return-Path: <linux-rdma+bounces-14591-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3245C67F93
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 08:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5298C4F506C
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78A2F39BF;
	Tue, 18 Nov 2025 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFYUeYpZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B11A4F3C;
	Tue, 18 Nov 2025 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450835; cv=fail; b=DP/XV+obAIchiHLftut5aba7JqP5JztIxCK2KddwNNLtIiOLcbjVzDjXBtlQN9jEBZGWEqfjPZg1x+K0WudM/dCeCUBAme4BfzHLOTqaVGF9VmhRDfxyptkmjQ0fil3B6yEqCeGgtFZsk2EWSkeSQgfyvII+HHY6A5mUvoZ2CUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450835; c=relaxed/simple;
	bh=PcR/Z3nyXRUIIydlcbHkWKIW4lIL1CfHiSX1T5YtW2c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oExrT2QMyK5d2JMZEWbxoDQmaCsn0vjC7b1iwq9IOWoEKcH1kTBe+e01jQV/kImQm2Atjh2HInpX4+M5SgBz2SzcPISUSQJlXbYBjf2Q3VZeSE0+jpuHv5NvsXXathpSrqzDM3WtA06NzKQaBHvisp8mOLgCsRXH9t4175rTTzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFYUeYpZ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763450833; x=1794986833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PcR/Z3nyXRUIIydlcbHkWKIW4lIL1CfHiSX1T5YtW2c=;
  b=HFYUeYpZivenkfPQB2jKr+R47gzFgnsFScwNnz9qSfiMmcEQ9/EASrVV
   7q2pUn47Fusj9CMXfXKyWQApklVSKwJgq7dmdv2fwKbuHB9ZQUms6NHCP
   vjENryJlnBZJdQpyBM8d5aikDlpS4DXikchZ2pMFkHCAZdF/dgraJPQX1
   ItS070+v7V7HbVhQSkZF4n/lnzLj+cjXHHhqaU6RIIk/J3Bw6fEiepQUb
   RH5f/dSU/MyJA5zqHHS9bBOMXoY20d/AzMEO8SBPngFSMoYa76saA2Rj2
   tHqh++PSAoRgUiJqNYt8F3Ed/Mrtln2qloC9ZvdQXKXfUFtxdtqqYHnRH
   g==;
X-CSE-ConnectionGUID: 8Ob0V+ZhS5a9JyasgMffhA==
X-CSE-MsgGUID: 2vgoQPayTVmsvg1HT+O+QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65620508"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65620508"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 23:27:08 -0800
X-CSE-ConnectionGUID: HLgImguRQbiiU++1fNlGsA==
X-CSE-MsgGUID: hHl09tlvTPGa7OtniuBoZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="221583448"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 23:27:07 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 23:27:06 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 23:27:06 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 23:27:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/pi0hDh7auRpZuZC9bZg/2ms7UCJrZyvCT01DSi0FCee7SyNFLvRf8FjbT1cuUaAHO0m9A+s61wdO28AxZnXm1qFn9sjal3ELZUBg1B6/lr98BfMmkEPHU58HUzy4oUkb+LQ2HvYftF2YuJ+RbGsIejW2ftHvP1wCMB9M5tnAktSZcrOVUcH0RAfCny68Yhbn1Neq04Q76DBqZEKjNS8fFl47MCphK23hOa3MCnH4kScmfA6KhLwyUpzvPGXkvOOyBKBb3IFLm49KxR2mJ/ndoOKrQF7wt9RDXyfcdcP5xYAq7jzm5wvz+5eGwCocaGEP68LLjMdUaMry/IhKg3hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4D3EPA5pbbPdBmaJY61FFRzPyNv5J5xU6FjsqGycD0=;
 b=kLCB9HpSCkZoXvaXTzlvUZ18mENzMGTbY3ED4Qe9rcULk7cHcKYq1ZifYygfosl2CCyG/IPGPxIxiyApu7iAP74cLt/iIr+m9r8VKZHl5sXyANLNFP3I6PlwCwK3k7cedi0JPuyoYf1pA9ohla2MyW1CBl9AfU9hW78UssmrYzSuuRfqTYBOzNk+e+mhMHKK40JOSML1VMDu2lGY3aZ/tKQavyL5yZvHafq03MrOF7Iucom1V234VYSKFf7qAfkgnio8rRKr5sTVSH8Qp+LK9zhElZipiZYGKrC2SVbHtUW46twSaiQaXMXPJ5z4cRQ2sH2ss48hW/OQXJkRfPgN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 07:27:03 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 07:27:03 +0000
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
Subject: RE: [PATCH net-next v4 3/6] devlink: support default values for
 param-get and param-set
Thread-Topic: [PATCH net-next v4 3/6] devlink: support default values for
 param-get and param-set
Thread-Index: AQHcWCHHANu8EqK8fEOfI4bG/WA6K7T4CAmA
Date: Tue, 18 Nov 2025 07:27:03 +0000
Message-ID: <IA3PR11MB89861F9E74B15B19734A12A1E5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251118002433.332272-1-daniel.zahka@gmail.com>
 <20251118002433.332272-4-daniel.zahka@gmail.com>
In-Reply-To: <20251118002433.332272-4-daniel.zahka@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4831:EE_
x-ms-office365-filtering-correlation-id: 3c9a1e43-634e-4574-1fbc-08de2673defa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?2Ak8AVjrSvy+AYe572Pyt5daoI8+bUXsMn9IrxYqhI8bN2Ek7ktRF+hdYQek?=
 =?us-ascii?Q?JVJrMGOKFfOagE0P3y3wnDKWWMvyapQL1ata3AsZaW7bUE/l20aeX6+Wv5nN?=
 =?us-ascii?Q?rQCXNsl/spkuuk1RKtklsBufAnOHbfGA697yrLPb93XnRHvCCyScru1KIN90?=
 =?us-ascii?Q?PO/NSzIM1w2FL8K5vBs/leu8atgI3tGpngIwgACTYpZIV3xvTN5EKStcYtdQ?=
 =?us-ascii?Q?aOoKc14VqjAIdNiQBFdgHkSXbBDyH+2y+Dde48ahPX5vo1hIHasvJ/mrnMmr?=
 =?us-ascii?Q?mbJYjMiUtAWieRsPvBR1UOsazEaQGGSKc4H8IEmoVwdFuZMbDUtDN+Do/uvu?=
 =?us-ascii?Q?duepXmGrphpHKXj29JHvLCoHXGa4ErmPQkPwp/eUV4hI3KXwQI0gBkG2oL0S?=
 =?us-ascii?Q?4fuqEpV8M1ppp8JCh9sJ3IlgEf+GUMkcv1Lp8xlgtj+OdWrgN+KVepgLcNWa?=
 =?us-ascii?Q?vFkDWSHyGow03HxpYidPGTcsCPrrPDf5dz+R/1nqWtql74k4FfdeWelJidXs?=
 =?us-ascii?Q?tP2aVNxzCiWAwfYXoBkxEUZbNfM/zSyEoRIlMT98wqX7roHLTBj4PxFZo8MP?=
 =?us-ascii?Q?/Wsd53UaoxGd7JRDSZIp7M1NdfHUh01LlatFbdShcJy9BsXWFhK3/pF1Sdcm?=
 =?us-ascii?Q?sVgdeRgRvffirFiA7t9NBVTYXzkaMrwqq5cvfXgEmpm9+lvagDM17CNC+odu?=
 =?us-ascii?Q?V6L52sriZDQjA9kl9lyiJUcGOVJxEp5ZQEuDdGvwgiz+Ki9rkUWiz/jelTUh?=
 =?us-ascii?Q?IdL2eWYpIaAwSRcE+EnWZ43FlCsDcjTQgBD/5zyI6uh8upzgJ63t7xvyX8Ho?=
 =?us-ascii?Q?1HBoTUJnINoLMKUl4QuXRUZnfOzbofGBy/GePRpWcAeaZWT4UkbVAvLu6Yt4?=
 =?us-ascii?Q?8zKuvAR+e8Bw0cUL3jApwNHvAj9sAFpq7li/5pNRcdafpn0ZfP3y71EKsSXx?=
 =?us-ascii?Q?CYKzZyM9GVdbq5mIqGQJaadeS3HpQJAcGAxHC6eUOASjsRhw04siF6QgVp8e?=
 =?us-ascii?Q?RYnuOhQ892Y2B9RlQobutCTBYjdLxLV4iCEBO2tJcLN14um6Bb2mdep92gjm?=
 =?us-ascii?Q?51i1MPhM661TdyfCUx8ITJFCNzxGA9ZEsgTzXqbAkHJz5KcH7iCOYotqA96Z?=
 =?us-ascii?Q?ZKWdKqzv0t/mPRGDD0umsmEZS37dgDZ/pPw6f92551xzAMb9nvIxDr8SVRw+?=
 =?us-ascii?Q?BNw5X7MlT/W8gsAQoP3VaaCo1rmYm9tXeQ5UDmxo/srNijWlzVPIjnBKib5L?=
 =?us-ascii?Q?XhwrRjuzOXCdjZr+q/+h3G+jVgFNMOlDN/6B25w+e2PD4kJBsv95yRd9aceW?=
 =?us-ascii?Q?7vFfdhccr2VRzBmYIwdPUNwWQGunpNpExpE1j2w1/e6sK7bEe8SSQjzG6Xsj?=
 =?us-ascii?Q?oKjSWlvUZW/8qJhW74PW9pVcDKPcmHcKo/prnwqBOFO9JHCKOlYPGbIENvxs?=
 =?us-ascii?Q?lVSn0svY7J2S1rQcdsXIOxRFaTvaRGwDDT+T56OeTuWRIe7eA9EL7u09NZam?=
 =?us-ascii?Q?GyxTHlaQV4r2me/dFZa9Ul0bWSweQ+mbNnFHQptE2vmnq+ROkrgapNtbmQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8P3oulyOyyzxVEvI9l0nj8GsBBQlXSyF+Ah4riQu6C+vfCax/o3EbThaDsSB?=
 =?us-ascii?Q?89aF3IN0WXqePkVso6kvjfnq8VNi0yH928KeU2O9HxU9llNmUe6t7CoAeN2D?=
 =?us-ascii?Q?svWH3+W/O4UD4S3pFphXaKybLs9poXk0GeNj/g9bVdOR5JNCg4JPMWf8EK1j?=
 =?us-ascii?Q?4STUjicV2Gt3jjlLhYbKuyYFiqqMNXlv1YQum6URnrb9ntSfXYthYCfW8EJw?=
 =?us-ascii?Q?Qy6/OgIzIt3NPZ4v+kpfRLq3n5njokLdyd1/JHZv3m8PJ0JmV9tFc1AT1Rko?=
 =?us-ascii?Q?d86uSoRlwpOiPshL3u8/iQOMBaGNnfUjtgk48QBEN7e7mQYftRJglrovs4kZ?=
 =?us-ascii?Q?sSrdy2pdMF8sfpniQdk67TOksS05rDPq/FpOrluBgh+okp0Q/siV/R84x30L?=
 =?us-ascii?Q?eS0d3tT4hrqhgqq1OdyCBhs73mqVMy4DvXCnrsjAUdtpt7IJzQOdCWS2MliR?=
 =?us-ascii?Q?e8O4NSXDL8YUKTCzt7FcnRImhqBSEhYM1VFs2KBpGOTrRjt+bjaOAg9D8eDF?=
 =?us-ascii?Q?UWfJlbDBLH+2M/wbY9UnC2kT+UoLwcrmo/0GfcSGAzZQvy9cOHQfKZib+piR?=
 =?us-ascii?Q?Mlc7MkXgibB9HB6Z/pRh367LLSnpmqQ3PAa03Ijop638r6irGpDeYX1d9xj9?=
 =?us-ascii?Q?UC+B7eCXj5gXGo7EEh2ROIDDjZZq2dDb5iEKMZbA88LenZuer99TPycOYuHV?=
 =?us-ascii?Q?/HepdujwqdnCWUDG0tOveIxW5mwGv2tBcHbkiRYP3R/5Xl7Wb9aDvZV2E6ay?=
 =?us-ascii?Q?mEMW6BCNy3WV3kgm/RvdehvFFWDH667ug/Pj3qU96I7V8k5V6jQcqvTF17GP?=
 =?us-ascii?Q?aQk82lsqn+793hNxZIb3aPbdId+xca0LhDDo99KRQ/C/ks5fSFKYHZopAMNH?=
 =?us-ascii?Q?460hGUddJRHMDBoRgn8nmwne3tiBZg1ACahigQWDkW4gxustwn1F1R2zPCDy?=
 =?us-ascii?Q?R1MsaZ9redCf5m7JZ//kcA6xj38y4gnzCYJuXhmqUZZC124KEX7vthE6bjJw?=
 =?us-ascii?Q?aXDheKM/XIUupkf9HGz0e6CNCZ/dCz7qZRNu/E2Tp/RqGMf06jkZFOnIYBrv?=
 =?us-ascii?Q?TOsKCxjWwOqFoSLtBzloxNT2fgW2X8eSGX8Ua/8ETCTorXY6HerZTaw/pILU?=
 =?us-ascii?Q?Wsnn/xS8X2BHafskI64BKX0dzRy+nwDB2Qm3Wq31v3OhAuOtT7dreZ2+itSu?=
 =?us-ascii?Q?lSII0BXAdC3WOUSGkS/TdLXwL1omAi5fQdT6fSesORq3OmaQfVDPtpPNQZxW?=
 =?us-ascii?Q?kCHpeSyiTjs9poiHkNLwgcNHoc8Mp3EobNN0RMitgrTPddfS+PkRBr8H1YPj?=
 =?us-ascii?Q?C18h6QBKEy1xJ9FLc+vbXCjLAZ7GlRVdHydoOnoWUMEBb/Iyb8T8zY246z8c?=
 =?us-ascii?Q?E1vH1RLA00VhW38VQHvLipVlgqVPNlSncGLBZkA6VO5wDyoyJpi44eFgzy6f?=
 =?us-ascii?Q?oI8ZjVr3FKXB2t0Hux6GAb4GL9Q+NaSgd1UhqO0OcmLCF96jDLSPVqgvOIUm?=
 =?us-ascii?Q?X9tcDUSj2Z2xmkFQ3in1/4pAOGyN8u26l45euoyD6q5HN5WBKsAChdLd1pkq?=
 =?us-ascii?Q?uE9PCunHiE2emfP/4vcR88sY5DL+HoyRwsGHLXC9XMDgmdHrCAOS3uJiQu1E?=
 =?us-ascii?Q?hA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9a1e43-634e-4574-1fbc-08de2673defa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 07:27:03.7158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ss+YMi82Npvna4V9O6hBT5Pifdj5IkQhNN3Q8mZYscQH7ecW5SD2IUG1wAxcbA/yOQgNTzPpz+wnqLs8CP8ffKBE4FZ50GAtuVxIj5fNE64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4831
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
> Subject: [PATCH net-next v4 3/6] devlink: support default values for
> param-get and param-set
>=20
> Support querying and resetting to default param values.
>=20
> Introduce two new devlink netlink attrs:
> DEVLINK_ATTR_PARAM_VALUE_DEFAULT and
> DEVLINK_ATTR_PARAM_RESET_DEFAULT. The former is used to contain an
> optional parameter value inside of the param_value nested attribute.
> The latter is used in param-set requests from userspace to indicate
> that the driver should reset the param to its default value.
>=20
> To implement this, two new functions are added to the devlink driver
> api: devlink_param::get_default() and
> devlink_param::reset_default(). These callbacks allow drivers to
> implement default param actions for runtime and permanent cmodes. For
> driverinit params, the core latches the last value set by a driver via
> devl_param_driverinit_value_set(), and uses that as the default value
> for a param.
>=20
> Because default parameter values are optional, it would be impossible
> to discern whether or not a param of type bool has default value of
> false or not provided if the default value is encoded using a netlink
> flag type. For this reason, when a DEVLINK_PARAM_TYPE_BOOL has an
> associated default value, the default value is encoded using a u8
> type.
>=20
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  Documentation/netlink/specs/devlink.yaml      |   9 ++
>  .../networking/devlink/devlink-params.rst     |  10 ++
>  include/net/devlink.h                         |  42 +++++++
>  include/uapi/linux/devlink.h                  |   3 +
>  net/devlink/netlink_gen.c                     |   5 +-
>  net/devlink/param.c                           | 105 ++++++++++++++++-
> -
>  6 files changed, 160 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/netlink/specs/devlink.yaml
> b/Documentation/netlink/specs/devlink.yaml
> index 426d5aa7d955..837112da6738 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -859,6 +859,14 @@ attribute-sets:
>          name: health-reporter-burst-period
>          type: u64
>          doc: Time (in msec) for recoveries before starting the grace
> period.
> +

...

> diff --git a/include/uapi/linux/devlink.h
> b/include/uapi/linux/devlink.h index 157f11d3fb72..e7d6b6d13470 100644
> --- a/include/uapi/linux/devlink.h
> +++ b/include/uapi/linux/devlink.h
> @@ -639,6 +639,9 @@ enum devlink_attr {
>=20
>  	DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,	/* u64 */
>=20
> +	DEVLINK_ATTR_PARAM_VALUE_DEFAULT,	/* dynamic */
> +	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
> +
The patch introduces a new UAPI attribute DEVLINK_ATTR_PARAM_VALUE_DEFAULT =
but Documentation/netlink/specs/devlink.yaml only documents param-reset-def=
ault.
The spec should also describe the output attribute that appears in the nest=
ed param-value dump ("default" value), otherwise the generated tooling/spec=
s are out of sync with UAPI and the committed generated C (netlink_gen.c).

I'm afraid you forgot to add a YAML entry for the nested attribute (e.g. un=
der the param-value attribute set, typically alongside param-value-data and=
 param-value-cmode), describing its type per param and the bool/u8 encoding=
 rule covered in the commit message.
Am I right?

With the best regards
Alex

> --
> 2.47.3


