Return-Path: <linux-rdma+bounces-3831-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB5492ECDF
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 18:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCBB1C21AC2
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4066A16D4EE;
	Thu, 11 Jul 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOnB1Qhj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1916B752;
	Thu, 11 Jul 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715801; cv=fail; b=RbCL7IamZxxwuQ4UPL1ldtK0oFn9SX1UPcmgIJclnN7mpGXqzGoMh0ggt7icXdtBZqQEUKHMMiSIylcI2lxhgUGO28HM99ziT4LjPn7R8PhQduEUv03EPr97cJ0OG21Ly2eB/9NaR9iXBP9ubI7TCDMAtkwQkJDCv2/289Ba6ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715801; c=relaxed/simple;
	bh=un26M+24/whS7pCsqcy4GGmTN/2VZItaf9VNMJkm9v0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lleA62U2kFRYNhlhwJ/Z3rWII5Te5ccIHZ2j6lCkf4GmSrzJENje/LnJVDgTpjuIgk/eiFbfS+T7bHGQdv4pr3D3bThSjoWBd6pQmq+JvCRINWU/qlSRmxRiIYos8/H0ont/dasQxFPh8SlnoTmPur5DDoMagU05fesCvUN1elE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOnB1Qhj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720715799; x=1752251799;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=un26M+24/whS7pCsqcy4GGmTN/2VZItaf9VNMJkm9v0=;
  b=gOnB1Qhjqt+t4rTSgnMD0hKdbdLOmI1oKL0v/xVEPwE4fhL/Y6ERvmVN
   qBUMFWWVujolGxQyyT5lCDPvB7wYM/zeKD501DZOnWwsu4TXRQ70zLgnA
   W3BcwYa8nbxq4IQyfRkst3W9jrqY2P3grhX7Umu+rsRk4RK6i3C8lkkuS
   Cp+arUl5msEr3tSgN/qPguCV3eyR52PDkPbhhz7MPX9Yi6w1ZjdTBTYVp
   L1RswYFzfaHKL8AlTDPYElmZwwiy93y2oRgqCd3rv6Pdkag02PnbgsAw8
   aSaOI6IDPlbAADlOr+TEGP//7bNdoZZZyXxZIktlpCXgETN6tkXKQFbR3
   w==;
X-CSE-ConnectionGUID: HGRDHeT7SZ6Go0qtlCCmnQ==
X-CSE-MsgGUID: Yx/wfh4CRZib3euBls0z1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18261226"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="18261226"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 09:36:38 -0700
X-CSE-ConnectionGUID: ulZIGwaxRkSNVgLjfSg1gQ==
X-CSE-MsgGUID: xpdBG833SEaaVUN+tFAt5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="53564325"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 09:36:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 09:36:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 09:36:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 09:36:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyUzQ9amnULVABP21OkjP0KYrfEQtd3GWpgVXd03tQaqzMhMHXO9yF0SaEsRU6BBHPaY5DD7JvUDT0JOU9mCkvrp6+c3PnS0/hSDXEYbeqtf+OPPMEolyeehccbo0fSDhDq6CEl1Onbg8pzAPw7IqqqNlqoorgdbRw1UD7E7yjfgkAKxITYK8swwFMeoaZm2qUX3lWczi3Ncz12m1CNW4f/8pTZszyW7x+5GcZy8a3GT53QJBfLvPiP8OYphGSc7JbObWmLTqzcTZKqUxNDnLb5RwLfmSctfCUlgyf6aqnqDBKIbYsp3M9EIyNRQfxUzTLjyC0nD+t+3Uue96iolAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5+f/pg2M1YDTQT+qyTt0eVYTBuqUpUqxO7U6pX3jsQ=;
 b=HRbE6/tiKmlfvW0lT8uX4d0LO1LY2XORZnEwJ741rMPDskrSX//fEK9duiNpW7WvvZ58gCltMdT2l7B91TD8Chlz+aVlc5n/ygnZhIJrMu7sxeVD4Heg5l/6kST0Nq/illVv4kpI4qqmKsDYEbh03sAfaH5zmqHV1h6ZwxFMtfITr35C7cbNLtIXfP7n1JssYkO3nvCD9xim40UOco2RJ0WCU4An1QQIH44/EPjiIkJBpsfK2RnBvBm581nqlu5PTNKVedDlI0S86K/nMLWVJM1g/FeMQfbqSTMIb+COm7XkhVvN7LVdCMQUX/Qgx3EdU318mwYX70LKQKs4dfk4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7692.namprd11.prod.outlook.com (2603:10b6:8:ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 16:36:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 16:36:29 +0000
Date: Thu, 11 Jul 2024 09:36:27 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: James Bottomley <James.Bottomley@hansenpartnership.com>,
	<ksummit@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <66900a0b9770d_1a7742942c@dwillia2-xfh.jf.intel.com.notmuch>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
 <20240710142238.00007295@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240710142238.00007295@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:303:86::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: d593be2f-6586-4b11-0e87-08dca1c79dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y2EbSbHQuKzooiZJ6pFwmiaHgh6pPmwO9u4sew+yoj0rGfIS7L618jLh21Qz?=
 =?us-ascii?Q?khAL0m6VndFUfwWCIek60ciIXivPimu1nf+GuNYWDrGsW57//RlbXxyWO/TI?=
 =?us-ascii?Q?SaV8jgcLZfwtRxXNrLXisfdjh1nwyXn0H0FcbTbeLD51IYlnG21BF3NrqOfX?=
 =?us-ascii?Q?/p1zFmq9eCh3iNPVcNZ458fvVlLZr4lCmdr/HdSlXuokZT49D692DT3pKsaU?=
 =?us-ascii?Q?cJEBEpF3pUHLpXN0NrjBTDX8LHwMLOFYPrMi16o3sUR+8fGI7lXjE7cMxxza?=
 =?us-ascii?Q?EFqVvr3Wyt9hFsFb10EiKX8CYcwdTSIONJ85vsFT5Aup9mkhfnY+GDSjYtbK?=
 =?us-ascii?Q?xj4tvort9NhHk9VIzDbBg09BLIEh1RimeS6TVaVRrup+HSIRpLaUZxmNWFIn?=
 =?us-ascii?Q?VKFBlk7B/vIxW7DY61qJoaIh6ulGa5ynofGWzccmMC8rdsEC5wJF61IraVbs?=
 =?us-ascii?Q?1HjqYJ7Rib8drHNyyLzA9vVx7OnJnd+yZPpySSeT4+f4rxtG0IjXTmTr89R4?=
 =?us-ascii?Q?cpemWFdCqdCwyCe5SAGyK/cFDlERC+4gnr/pAm3YcjhTklguMkgWaMykWB1W?=
 =?us-ascii?Q?hp/rYYt/ClRJSA330Xox4aBrWA354lpCHkBd7SWMpw4NypvcgR8pCg/Ojcx1?=
 =?us-ascii?Q?qQmMPWHgJhqHp8YxqacZHl3oxxVH0yd0t00neYGNl60h3dMldYvJOPiY/mHD?=
 =?us-ascii?Q?BkQmIpwi8RsPrnNJJTCKKaM5NL+oMrUHO1GZRfC9fIE5j2rMpWnlVQjmKar5?=
 =?us-ascii?Q?sw5c72nEoxSPqFMYcHE0kWgr0KyV4vBV+fqJdc8TX2k3XgxTm2iFHt8/RzEp?=
 =?us-ascii?Q?VzockDBJXxL7YaueMiPfIIeYBDt1V7vojdRaTk4lZGZP1vUkh1XGlB91QQDS?=
 =?us-ascii?Q?UKo4s+26AeWj1wkA1fpCo0pzV1KUanzm6As1yLXh6iOCTe56aZJxgQDZu3Ix?=
 =?us-ascii?Q?4L6mJUaQlwygUcOLQVAWHULvcfWdZqP5loGFmO7Drr4mKR8owcuAt/fGqMsq?=
 =?us-ascii?Q?laYnYPZRj0PeGYKiuYoq7oj5ObPOFmCW0Q9pahxIyshNTUC1qJA6qb/a/COF?=
 =?us-ascii?Q?P4+jDg2wVIGXol1IJeP6gGWIDS00LlCZNeedUnxQqaC2GP2+G89VkOpXpdpa?=
 =?us-ascii?Q?bvMcl8UOy5K9SxL8lLgGU/HTsSmKNDur6oEIC6WOr9pHuBBe4wrS+zbmvAOJ?=
 =?us-ascii?Q?rdK4dWk9PEpuNrNW8aY7s04TLlJpJKnQv0cUH3kqjtGMrfoWEuNHuKUuyOUi?=
 =?us-ascii?Q?muqzrhemn5XngOi/oeqtfhqffPCSsOe/oqWrBiOnWIC6ZRkmWdjHOltTvrXs?=
 =?us-ascii?Q?Myg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KTort5NbwgMqBEfllU1WV1zWpEIjdyNDep84QIZjNd7MtFHtBaaIBhhO/aA3?=
 =?us-ascii?Q?gYNMrx8D4d8HFP71DDs6uvaYqxwdH3Cig0OjrH3akcKUMAALN1CqzUn5SfUX?=
 =?us-ascii?Q?4ZwgBkrxcN5WLN6ejNhG19d1y5OhZ5skpcZMOaaCzGhPt/wzOP4CPP9FHzwy?=
 =?us-ascii?Q?D23UjdUdBr0ASdXjQ31z0mhCfWnKlsHWLUeje5xYrW991qGpcJWNSysVDtCq?=
 =?us-ascii?Q?Rxr5KmlDCtHYW4uZ17k/LxyuBL+bkO0ETMRLPWUR1yS3CRuuL/TkCjJlEQS4?=
 =?us-ascii?Q?vCi+BGCuY+l3C0kbJIbkM33MpqDOLQiOVOEUvOzZJ1/NG0eC8MVHo4Zkbn6d?=
 =?us-ascii?Q?y/qfF3o4r10SqphMZkBJ59M8GHErQsqs1+K1mp8MxzSyI97jH/U2Z14SraTI?=
 =?us-ascii?Q?gpCo8TVPH9rhEa4VzoaAIt6jOA8B4cY8xtkKz5xFf3IRiTICSg2EaWWTB7fq?=
 =?us-ascii?Q?Be1jx5q1juuIStuf12gyEQmBjIyIW5Vs3srogFEQ807QxGrTOe7YO1r6vNyO?=
 =?us-ascii?Q?coUYdsPR1gNijK0JDsWBnhRWyCCu/LcIC1P9v7/4SPUFCqxLerOjRdFeAAF7?=
 =?us-ascii?Q?LoosiRWUF7YZ5F2w9Xiard/kkiNndQgu1JJk94RE4CfCFHVr5GUxD7akGxi/?=
 =?us-ascii?Q?hyltaH4L/k9EGqGVOBnWX/vLJaaqM1ZoaooIYQwWnrf1vvh/b6KHtPq8xkDQ?=
 =?us-ascii?Q?bPW995hlu0XKyDPLzvHm2ZmONMV0IX9SmyHWR21nvKHHUyXEnSgaxj+Tw0WT?=
 =?us-ascii?Q?ithWoYm7f3XMdlWedB/whvQGzVxfDBKnISc8bnBvEdzbQ4BWCytv4uHNhfvX?=
 =?us-ascii?Q?LzzN20YJW3ls/T1MsQijhMV1X9LO1mGEBfIPxh6qtzBdg7C9+AQ143+OZU+l?=
 =?us-ascii?Q?5IRe4I6hK/c4SFRDqCuXRBX0dYTGUwvBZ0F5KDudnjexpmrTpeiL9I8uiIF4?=
 =?us-ascii?Q?ibFzOmXqD/cGe6PvGWJDT0uZzcxJuAMAJDFBfWhhtXGzOjq4OpmPdkr2Wb8X?=
 =?us-ascii?Q?ZibfAiBc8xLd3B1K9O1lvX7BhBBzssVPaKI6CYhysT7ZYWn8c91Ntw5ZkY51?=
 =?us-ascii?Q?Oe3Ofk2GDJq0I6ZE7r7NUsodEWCPIkyDPP0yWOwg11cE2Ot65bn1OWz5Ro3f?=
 =?us-ascii?Q?XEUY1d6gNgMAazVmHnrzx2Ri4nb7In1Kys7tYT2S9hnM2XNUSiCFgqn8SwYP?=
 =?us-ascii?Q?jbDywW6fHfvzPEwUQEN+eUDALoQ8TYHGcyE2N+nsVcFq0guUBV3EJWRuhgIe?=
 =?us-ascii?Q?Q+KZ3u5NVpcKnPzNdjs2XafYnQWDHGcRuLFU3RUkrDQ+5xmJcHw9FuPRaHLm?=
 =?us-ascii?Q?34Gl0L6aZkzhfjdF/m5Niid4MejcKD+dxdo7cPe1cDAzLvbFV7nUOa4IAydF?=
 =?us-ascii?Q?tZWWJvkpmvO7KLpKe3SXrGY5xnSG998qtZb1Otfni41/HOQ+o6EdwcuFMpZO?=
 =?us-ascii?Q?SGixDEoi+9mDJ+f3NxO8XUrcxu0k1TxJ6uQfQOlOLNtmeD5/VPI9sRJPDAwX?=
 =?us-ascii?Q?GHujRRUZn5CeuXRK64olfZlguP3G6orCS+MOsODgH7cEHaT18mq6h69Oxa8p?=
 =?us-ascii?Q?UylykdLNlIXba/0fPr9yX8QZBEwEUDZ/sz+gYnHpW6kJVf/1MeIanYwdE/EI?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d593be2f-6586-4b11-0e87-08dca1c79dce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:36:29.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tL5H/HAflt6lrVvLn0J1zZTrsTghx6wxBMJ42y6IYqCYaTfpS4+5hHv96hbtWJcLJiZVgDpx48XvsYGWruVfWBpdln5CJFPvlIBGZdYoe7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7692
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 9 Jul 2024 15:15:13 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > James Bottomley wrote:
> > > > The upstream discussion has yielded the full spectrum of positions on
> > > > device specific functionality, and it is a topic that needs cross-
> > > > kernel consensus as hardware increasingly spans cross-subsystem
> > > > concerns. Please consider it for a Maintainers Summit discussion.  
> > > 
> > > I'm with Greg on this ... can you point to some of the contrary
> > > positions?  
> > 
> > This thread has that discussion:
> > 
> > http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> > 
> > I do not want to speak for others on the saliency of their points, all I
> > can say is that the contrary positions have so far not moved me to drop
> > consideration of fwctl for CXL.
> 
> I was resisting rat holing. Oh well...
> 
> For a 'subset' of CXL.  There are a wide range of controls that are highly
> destructive, potentially to other hosts (simplest one is a command that
> will surprise remove someone else's memory). For those I'm not sure
> fwctl gets us anywhere - but we still need a solution (Subject to
> config gates etc as typically this is BMCs not hosts).
> Maybe fwctl eventually ends up with levels of 'safety' (beyond the
> current read vs write vs write_full, or maybe those are enough).

It is not clear to me that fwctl needs more levels of safety vs the
local subsystem config options controlling what can and can not be sent
over the channel. The CXL backend for fwctl adds the local "command
effects" level of safety.

For the "Linux as BMC" case the security model is external to the
kernel, right? Which means it does not present a protocol that the
kernel can reason about.

Unless and until someone develops an authorization model for BMC nodes
to join a network topology I think that use case is orthogonal to the
primary in-band use case for fwctl.

It is still useful there to avoid defining yet another transport, but a
node that has unfettered access to wreak havoc on the network is not the
kernel's problem.

> Complexities such as message tunneling to multiple components are also
> going to be fun, but we want the non destructive bits of those to work
> as part of the safe set, so we can get telemetry from downstream devices.
> 
> Good to cover the debug and telemetry usecase, but it still leaves us with
> gaping holes were we need to solve the permissions problem, perhaps that
> is layered on top of fwctl, perhaps something else is needed.

But that's more a CXL switch-management command security protocol
problem than fwctl, right? In other words, as far as I understand, there
is no spec provided permission model for switch management that Linux
could enforce, so it's more in the category of build a kernel that can
pass any payload and hope someone else has solved the problem of
limiting what damage that node can inflict.

> So if fwctl is adopted, I do want the means to use it for the highly
> destructive stuff as well!  Maybe that's a future discussion.
> 
> > Where CXL has a Command Effects Log that is a reasonable protocol for
> > making decisions about opaque command codes, and that CXL already has a
> > few years of experience with the commands that *do* need a Linux-command
> > wrapper.
> 
> Worth asking if this will incorporate unknown but not vendor defined
> commands.  There is a long tail of stuff in the spec we haven't caught up
> with yet.  Or you thinking keep this for the strictly vendor defined stuff?

Long term, yes, it should be able to expand to any command code family.
Short term, to get started, the CXL "Feature" facility at least conveys
whether opcodes are reads or writes, independent of their side effects,
and are scoped to be "settings".

There is still the matter of background commands need to support
cancellation to avoid indefinite background-command-slot monopolization,
and there are still commands that need kernel coordination. So, I see
fwctl command support arriving in stages.

