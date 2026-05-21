Return-Path: <linux-rdma+bounces-21080-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MAoGG3QDmrOCQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21080-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:29:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D80B95A256A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B128F300E146
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521293769E6;
	Thu, 21 May 2026 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="joX77WAa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F2282F1E;
	Thu, 21 May 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355752; cv=fail; b=hghnRM2s5W2tb7VYj8Xk7Y3j3MCnEBKiUjFLqpeaO3vvGQI5Oi/M5oTDBeyfd0Z+0fBi3wfFgWULPAjEfGE/Hdie8K+GxZ/TY8K7/0y7bs10PalHzluXfmrx5lcV+JL0kzU+n/pURUIQXwLj8uNyaSukcx0vI7UJzJOKzxQDtqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355752; c=relaxed/simple;
	bh=cbS2AaC45f1mQKNcZXxFDRmegZNys4j3WrbU3L9xXO8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YkA8nuCpjn8qeBFuDy3igl5BUc2jioYYRSzkp7gz/kvBeE7bFJFRogubaPm4GbHEZ7VHtS8E75E836Uz3ls19Byhbmz1qFlWhia+NXeWT0JlfvCUIX/3q3JImjhzxt7191m8KEr4STbzqwlSD0uQhSlfJFeQlrwydIk97W9fm44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=joX77WAa; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779355751; x=1810891751;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cbS2AaC45f1mQKNcZXxFDRmegZNys4j3WrbU3L9xXO8=;
  b=joX77WAacbOu9uxyBUT57Pwg1991aPPaffmr0hawmVNNzHPEXpFDyJ0V
   YtT9+njLD+Mje/AdPdrWKqAMl8IOOf0GdYWljtI3yyVEJuYky6pwT5doW
   WQYMGNE6gUICt3NOkg9R+LnFxOvd0Y2oY0naIv3z4uRi8uYrI74ZZ/OGp
   vT8Fuvj+A3LmRfofRLv4hNKsnEkulwQwB5dCwsayijeumdby2pTj2N6Ek
   5Wvh3MHd5hqKBX9sTZqTdY0fVqSfcxP2mRNjitZpn5q4nlkOzZvjyHqkB
   MlZIdVBjWnqRBiOtGhflxORkltCYRsdz2O+ggoS/+XT8Fc6LrmfT/qUun
   A==;
X-CSE-ConnectionGUID: W2qG2QDPRdOcdKMVIAO34g==
X-CSE-MsgGUID: r8N99OygTXeNeTjxu9S16Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80171876"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80171876"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 02:29:10 -0700
X-CSE-ConnectionGUID: G7VIPIlFThOaxeUNGwl9LA==
X-CSE-MsgGUID: fo+ADXlcRu+DQm1dOCipXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="263998439"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 02:29:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 02:29:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 02:29:08 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 02:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cv/BYYcy/YnceUWhQGrO5TiYUu1Y12KDmTdB1TaOjaG0ZDMKdqqWiAkTX+9nepRb45+QHl06OcUZFzBzyDEDUc/CL+8K4trmbyG0ISmYzuqhtPKFCD35+NMzcpNArginvZoH01NWhuIQa5QoyyY1uIzQuY+75rWpUdkyVSAzzN9EkPkR3eq92dvxZtqnHEZU6J+luSuqlyl3LdxVk6uOhVWwVDpl1T0W8aNoXDXyLqC93l1VTqxneROV2T8s0b6oigw8qE5qUcIQiCOK+Exi2BaNBmD5/gKrQB8lNqJt2UfXSox/kc33nLrE3NMupDi9xJjhuW8ro4fMeAsBv84ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlcdXieeKaywclaJOLvhi0vqKmWBHgjtboQqGtxYmbI=;
 b=K3aGQfXrP1nDkZ+SMmkQSGLfzbs0pu2ze6QRkCSmsGB7Iyg39PEy4BNdJyV+FYMsJCoJx7VAvQxzOJw50aG0b2dxS2q2+PkJyX/2dvOfe53trGKHr7Z3s1DWrqxFwiS2O+C/yC/BYEaWdpzjZzZ93C5lvL0XURPLo3hK7HWwqAfdOncT01TFi+f75RXs21Uny94yTL+Rmg1P96rQGSMILW+RdLDZ7VfvwHJZf18jp8gV9UYvGYPPAMPGNRf4kSZY2IXfvQEd0mY+XnxbfCW+IY65J/pTceIJWh/I3SbKDrCbpz3sMRAOPoQietFf1+BdEfRLmzWF1U4qoBBlcRS53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CY8PR11MB7291.namprd11.prod.outlook.com (2603:10b6:930:9b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 09:29:05 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 09:29:04 +0000
Date: Thu, 21 May 2026 11:28:50 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<anjali.singhai@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	<tatyana.e.nikolova@intel.com>, <krzysztof.czurylo@intel.com>,
	<jgg@ziepe.ca>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>, Samuel Salin
	<Samuel.salin@intel.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 01/14] virtchnl: create 'include/linux/intel'
 and move necessary header files
Message-ID: <ag7QUgfpM5UAAE2z@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-2-anthony.l.nguyen@intel.com>
 <20260520175201.72f83c4a@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520175201.72f83c4a@kernel.org>
X-ClientProxiedBy: VI1PR09CA0144.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::28) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CY8PR11MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: aceaf1e5-13ee-4bf6-e2d4-08deb71b667f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: FukZ5HKAbLtB7EsSHprZdi26npJ24jsv23kg0I/zfUzK7nLp8xFl2QnMB0RHABRB9Q6N/hccSisVZ5jjSfb2h3yvw6WDn8c5Fx1Fx1WVgWIaWDTPnWN1vQkAHcbQbUrss2joWEo8o3SThax9G8BOYppLE5ITd2GlwU0dbnljRcxYfU1JGYSUwwWE7W72rO/qZ62g/BGzy2Xe11+84TXQBah+vBkCNR1qyDFRC+Lbl4xJOwMK9vqGD0Jdr/waB6EVWJ+r+Q0Uw9Rq/cmBmxGLMJbz5UrQTBBEKVMV2cOS5JISOiZAi9V/6YRLFW87L44hFq+oZnEJzfZAX1j15ajFFDiCR8dCKJcfIdXCq573rt9CbQl6YCvv1kduj/0gBzqvcK8hnmvlOsA9d/j5lozRfUgaCGD8+jn7qODE63HEk1+syrfJhUzgY4B7e0Vl/ieuTSyHbgjEP+k0wkq+fGVl7OBHRuzzTXIKeRxGWueUs1N2pPa+FDWWv0zTTb9A8Fe1XZtpDS/uWdEUU0YqGfbs2yONtT0/RrY/0VCXMQX5hUmMKw5ibY3i+1FOgkbOm2gRSUUPlNAgxeXGYmXBOur648fi94pNQMQevtktSUOyq/0nWsjzfK1AvbWpiZSg30HVPSQi/Q16CHEvr06eIa97cnCWvSHeDiUPRIUIqc53bdTi60Tsc64AKrqS/i+AAWtv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aLlb1ytQejDg9HO8EwiA+WchsxklZS5IasZhT+RpJLQysXNw4wugo+5kW+gP?=
 =?us-ascii?Q?IzoRWxTNu0BPavNj2KtLcPXzz2JMpNjuIJII4/Gm8uL/1gYfPKTKJwxMDD6f?=
 =?us-ascii?Q?T1ZYupMsq2WxmqeuuUWuQGONey508OfzYREOKwIM+TJgYOUb2yB29sqHeTeg?=
 =?us-ascii?Q?eHEY6kqq2/YUs65QA+971DvyMnhAuysaCd1ZYs4q13q2zxUHe1qLW3/eHkcd?=
 =?us-ascii?Q?YgwZ34moK0D7M1sWA2g1oQ488irMeqdt4ROHSDRMkha/oIpakD1gvMcEplud?=
 =?us-ascii?Q?V3YiAWHQ5jMM8V2WDHI4tXH/PO38m/yk2iH9Zgaa6wGk4fSnF6X/ijXuJk8+?=
 =?us-ascii?Q?DWCcgA7oofqPxssxm0b5W9aE4JVeF2fu/6YO6kQM+8LmnqjSEsH2tLXVWzCw?=
 =?us-ascii?Q?NCiz1hECsWyuWdSxhCkwC5rymdlVFC7EYW3pjE//JYiFU5DGunNdCGoZxDWG?=
 =?us-ascii?Q?FBo/BadOO/4uXx0xHTPzNU6fJsguppxH860PbWRayQ/DjaL5f2sVC+jGjE1W?=
 =?us-ascii?Q?BJn5lXX1ke53jUectC3TbmDz6pcV84bxia/J/n9gOc3A2+k93o0gWQQLjW8Z?=
 =?us-ascii?Q?yQhH8uWsdMxZrCU+FJwJ0d/FXc+dc1g7WQstez5wnmb+weMMtOzNU+tEfscd?=
 =?us-ascii?Q?1ygpGeJvqdTp8dULOHq1pt9eTSRZG5421xd1bRYBE5YCC32pz6PkvXQrcIuc?=
 =?us-ascii?Q?itspYrcP64fz+dUvR5uFSQKOPI/SGs15HKoofTX7PzxbHlwYWN0m39FwLK2h?=
 =?us-ascii?Q?wlqfmOaAOYdeaxZOcnrFQuFvrmgALDR0PLJmOCq1jJM2sgiIOP7XVWK+44Pi?=
 =?us-ascii?Q?N41BBWPtLajtq6iqsxjUxVLOnpbwH4swv94d+4MlBg6A3Iha2upMdtploTtC?=
 =?us-ascii?Q?WfkcpO8j4ESbd71Mp5MGRQDPZr+VM6PEtghLBrLsf4ZizER782P4lDox8ZMY?=
 =?us-ascii?Q?fcBReA+kY7oPbepeXE1eYfVEukCylZXtJ5mOQbmh4twW8TvA6Ybvv9ykbQ8t?=
 =?us-ascii?Q?UQeX6RviWFEEilN/d1m6UEiYQ6EYk01Sm2wUabCPXvVQSBVvEZ/aJU/eHcKT?=
 =?us-ascii?Q?RbF8FLOjQdCCXOlsAV5c+82DNKBQy5MjGo8oFSDbnIWkeMaTPX079Mzcazog?=
 =?us-ascii?Q?idTik6QV/s2yDcNCDWnTq7tfIBBJaFbfF5vAfT3KLgbdkMOn/MCHCiSjrwew?=
 =?us-ascii?Q?RJ576h5udQmKGpRsPA5n1wYxOHu5+LtYuOvV4LO591WTvSdbtnzDLX9wi2sn?=
 =?us-ascii?Q?n5FuCNXTbYSRywxnO/6N2Fajb0bMHr6uINkAjfR5yrEOr3KLCMavVENEyuea?=
 =?us-ascii?Q?lkgi3Mad+fwtJ7iCtSN+k7cGvjNr2VDXok+H3GjRJhc/CumJK3ghQ1CukwnC?=
 =?us-ascii?Q?LwfQN94dxzx7Un7efAHk8Ib7Uoq7/KnYeHvN7sPthKM4QiKFaGuZIeboD8Rf?=
 =?us-ascii?Q?2xidOB2L9Lh+VO87nUyheWm3YEWv6GIOHHBc99cX/lhDw0A07d8mB77oACgb?=
 =?us-ascii?Q?oh/4KuT5pbDbUZHCH5bQLfzrgh+dqQEItrqLcCXXS4KnyCXGAnyC4ICXVKvc?=
 =?us-ascii?Q?ifB0nfamCmcnSt1LWxr/r30wTktiGaxsJWMAEa/KsMpOCiOfSLGcl9nsNI14?=
 =?us-ascii?Q?MZZ6OE+EmZOvNI0tAqXHNa2dSzLSfkk3RsiGhM5CQotJo803OBUCUe6yJvzy?=
 =?us-ascii?Q?nJ87bsAcCuQteJJ2U9DNQKw1/afiD5buuLieTm6Yc06d0kN/9PqnLdJZsTps?=
 =?us-ascii?Q?CVezRffeHxnOHPT9sPKuEtjKeltmzte6DYyXaq7/xiQBHPqCLI8ZNewPyyl3?=
X-MS-Exchange-AntiSpam-MessageData-1: Ar68Db5w5CZ5JW+txWIj8IGOStuW4uztRyA=
X-Exchange-RoutingPolicyChecked: IahJPeQqdIoxuH6+ToX8Mtq6IEgGE9m7VEpLdxmlO5l//+kHzyYrhjlseMjARRDFJ+1Ah3GnTIeAiC7D6ZaKkhv4xL175U/M5NkM4N0qV9toM9WNpMnUw4ULR8xkUA9FMjKfRnNnNnCqH8G4vxtGC/Mefznajd6fYEPP5nCHzQprcOdxUHA+OyjTc2zMYUcJkuU/YHtTm3OEN1ANdpylKpAFI/WBVQdyEOAzoIazL9mW8/xhzsKSPbpce/tpMKys5mZUL2Vh3wlKe9bbnw/5ArNTGhSDQC0HeoG2TIqw1fCuWGZRAj0ytf6ud9xg4epyRJ1x6InHvWyNCOC6zH803Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: aceaf1e5-13ee-4bf6-e2d4-08deb71b667f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:29:04.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHnQduymgAm9Wg9byrWkLNeScDezBczJausqdecFaWyFvgnXAjU+3B3i5j99E/fym0g4D0Idh95FQfmDXqd9HmR3npa0KKUd7chG26MtZ5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7291
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
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21080-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D80B95A256A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 05:52:01PM -0700, Jakub Kicinski wrote:
> On Fri, 15 May 2026 15:44:25 -0700 Tony Nguyen wrote:
> > include/linux/intel is vacant
> 
> I don't see any other vendor directory under include/linux

There are at least

include/linux/mlx4, include/linux/mlx5 and include/linux/bnxt.

Those are per-driver and not per-vendor, but intel ethernet has too many drivers 
to have separate folders for them.

I just do not think this creates a precedent neccessarily.

Folder structure is for you to decide as a maintainer, but it would be nice to 
have known about such doubts earlier.

> and TBH I don't want to be the maintainer making a precedent
> for this sort of stuff. include/net/intel is a better choice.
> Or rather, at least its in "our" section of the tree so nobody
> will complain.
> 

