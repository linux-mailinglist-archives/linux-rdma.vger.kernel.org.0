Return-Path: <linux-rdma+bounces-8609-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1942A5DCDC
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 13:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93278178DAC
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 12:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0521C24337B;
	Wed, 12 Mar 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/XC9opL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11EC24167F;
	Wed, 12 Mar 2025 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783262; cv=fail; b=DPAv4Qr43jv+bAarWfp5hgkY63YymkZYMuZ529HYRrvS83uXpMwct7vF9E0vWfg5rN9gs5n3BS1vTgNovv+qN9aT33dHtLkdQAKyv8yxIzQYSKPsqMWkp7whmZnaso5AqQscDZArwYcSkpZWwYv9WdDE91B3ZSCOH93qn/EPPRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783262; c=relaxed/simple;
	bh=iMuy6uERJsvdUcwb9y6LB2xOzMYQkSKz9D8ONJgxXm0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uYV4MTajxNO4qukvDE/xCq/K7NdBdYrs1ebZZQZlmYRWnBAz/ziwVeQItmGpK9pIIsl9ECe5gZVC8jdawKn2Kb0uyfP29Sia1DLrxNCwDNUfCl/szdLpCrM5441Nja96jbCZQt+o8D9StSRYmNR4HxJz87+3ijfGRmmzZIwkqMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/XC9opL; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741783261; x=1773319261;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iMuy6uERJsvdUcwb9y6LB2xOzMYQkSKz9D8ONJgxXm0=;
  b=P/XC9opL7X+x7zYZ6T6to3KKmG1SKTaLJMW55an8VmEbynEFf1llKIjC
   QMZ0ikfsHWIqyq/VzpVPBwc9AitN/ZYk4T8yPmJRNP4GVEDWwkuSFRnth
   Zh0Q3Mn0LgB/r6BuT/GdcT4feMuA4T3hq321qoC40kD22gNnmGV0hCCUb
   3Dorm9qkwoW2Rr6LbeNRCsn/thhfmzYwbL0pA5mvpBuXwt99M6bqILIhV
   obUVLUFKUJk7KvI2/Mx2SBzju4PRp0BZlJs1ahLpxvYjcLMRMw9vv95a9
   /clC4R+/TnJa4BrFcYuETs8y4wwxtXiuUBzQlFpabbe+iKFR2iAdLe0KT
   g==;
X-CSE-ConnectionGUID: Q29m0guzRK6t+ISW16a6Rw==
X-CSE-MsgGUID: n9p04qcZTxeEya0XsKb/Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42769976"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42769976"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 05:41:00 -0700
X-CSE-ConnectionGUID: uLPJ6Gl3TOybJkMEw+oouw==
X-CSE-MsgGUID: T/j/fRhERr+3c+5lpd2O7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="151437494"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 05:41:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 12 Mar 2025 05:40:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Mar 2025 05:40:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 05:40:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPbgGnHpfLQ+prKhO6Gjpi9v2n5N6UFI8S/GZIjfNQ08vZ+fEuyM9vT/0/3WUoa4aqPX0s/QLACN+YN3JwELly8wjMXFFCSGW6MXtNWDjhiMplOp/7PEFPtN6YYmIOMXpATH5tSJksD7YirjVkROTbDCmFACO1g8yjn1GyXKear7t/dOplC3vDXTrEPjUTxoay1TWLpl5vfWYARoqv0qomvQYeFwUh9QX63YHlhoE7WrloMOHIcXQMr/ReQDK3KS/aqGQ6eaX2JCJstESqadCvh3SpNwf1O9vpEUTQpKCXCVYW3nD3QXxz9QINfLs41Q4gUgAMMjM62mmUScIFZPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSzWb99kiXoDQZxpjq/YQwtsic0lYf+UzgTpIx9MvIc=;
 b=mtqUjbxyefwUYXvQY47/lw2+ToDQEpgb8YCDNEBnJp3xdXNm/kDrxM0vfAfwuV95c+sKBQc+P+O7OWarOcaUOd1djE828ytL5/0RqWP5Vlh8VM44dhgrCQemSwqAclPCjFUpFFCpfoWnFwTwRiRa34RvqrS//WbAsfxZxNJYMsGnKhM+t3eOhFN2f+MldxWyFMBctFNzSGATdzJJoX+AV/gXb4baUQfeUFRRSm31jAu2ucK4HnZtVKOGUFt1HWq2Ui4BM+7W4gamNVxUJMiizKl3AJ7MBOTZE7NaFpS2d7oJ36SYu/44tZ4gNzoGe0SPJGwSkdIlT37jE4q03sARHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DS0PR11MB6352.namprd11.prod.outlook.com (2603:10b6:8:cb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 12:40:29 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 12:40:28 +0000
Date: Wed, 12 Mar 2025 13:40:17 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman
	<gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] net/mlx5: HW Steering cleanups
Message-ID: <Z9GAsQQT+1RjXZeH@localhost.localdomain>
References: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: ZR0P278CA0151.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::12) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DS0PR11MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 3712145b-7eae-44e8-7ddb-08dd616311f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MRz9GxVHGE3wkj7CYDD96ih49rj0mWvgoirxT4NNEWLb3DUtpS5scCmXke4Y?=
 =?us-ascii?Q?yMPx0ZkXqfbJE3b0I6v/QBVXUvyh6kmUtWE1NFGd4mGBkLaw3+Ef4kYMBaib?=
 =?us-ascii?Q?I/g7pLgKyBhXtRLdUnY3KLJY12nvxYK/C+3A22Dm1UPFMCXOrsmzVgjEjoli?=
 =?us-ascii?Q?6UZKn/ejzZovvoQjGDO7bXQrnCC6S9poPr9buR4KPbkvuISYnGb1jISiSiFM?=
 =?us-ascii?Q?Ohi1Z3cmDhrhGt9xkfGhx3DOyYT6lwFZpIjN4UCBZ59A6643zBy4/RuYJzRz?=
 =?us-ascii?Q?1MCxznsv1WATEqSKl8p3d4wV8cx/241cZSkNVCSu7kAQKqM4CUH8Hb9p8Rof?=
 =?us-ascii?Q?plFY5KY7WGywSr+RsdMD5AnfvKkI9ZY43WJevAJsnEsCP252g1N+jsurKJBt?=
 =?us-ascii?Q?nh5Oe1YCQZnhLRS2tIKUK0bCdDQ/c5DC4tzLtVtegTxofYcgOunh2KE92ctG?=
 =?us-ascii?Q?Y5CPs3olG+nQsf2P/IflftgLm7V/VrTEgByYsXK2zjsOrnekvENi1FndpAV5?=
 =?us-ascii?Q?qgTWGG45SN/9uqe+RAnmjRBChVLS3JoRNM/IvxdeeON3k0BCMMwHUbDb+ERp?=
 =?us-ascii?Q?QKY2zUeZF3AOo9oyjj2azdjnBr2fqCfZwyucEI6isgwzrctO8+HFVLdNCh0a?=
 =?us-ascii?Q?Os1f+wI+IHmW0wqfbOIM4x79hdJ46mas5q+wWd2sSkrUxGKhOhYHsWcdso9o?=
 =?us-ascii?Q?k25uAtVrRzFcwMOpgfVZG7FI+qFHqx/LTQVw9cJUzDWPheD4i+hlGzmPF8r1?=
 =?us-ascii?Q?7DDyPxqSX6gol8PyDSOMc5Z9vKQ03sNAa3dMNTrUwe974Rhsn4xofqgDHpcz?=
 =?us-ascii?Q?UCAP3iv4Tq4YjSiUjzDiBfeiWrwPIeN3xGKWhSX8O6uvQO1gFTBW7ABL/oaR?=
 =?us-ascii?Q?BYJpGjpGiv8ts1RQob3V1NykMoSsYoj8EcfQlN8jJAiSVd8DaxaP9H8QQgVU?=
 =?us-ascii?Q?gA9zIx5c6XCRagVJSz6t58ebNPzNEGiqGVDP+XaDjjthYwbDCXV9ICzd7fmQ?=
 =?us-ascii?Q?dOf6BGOFBnHfnGqD/zWtlBl6pm5ML6fO3IY4OebsffDNTz4YxRXv/s+R3k17?=
 =?us-ascii?Q?Z5SAPLD/edhcBYjeTN4UgtWU3QCogNCW4iqLEBoD883nY1CX8FpjzKmEmLX4?=
 =?us-ascii?Q?U+CiYwXLgZxikNAKeOnTisF0/XGbrXOCnBmEMf0xwStsMWZ39bjbmEsoJROE?=
 =?us-ascii?Q?96wjbZK/djaj4fQqe9aIosyan9wOCcCJlBtAOMdKKHYaeQWdis5k8k83d8sL?=
 =?us-ascii?Q?oJMW4tCK5lRtvGE0XoZZclyU8eohqAce8Xigx5h962Tr5DmfmuCKabv5fbeB?=
 =?us-ascii?Q?C8HIme473iUcRkjbuekYw534ecszA4uoJU6OGxahUdfE2ljldiEAIfH9Nakh?=
 =?us-ascii?Q?igaK9s6tWrCDe9clC66sRGKcTG2x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0DFkqDAJjy1Ro5q/vsMaFdKyai4bEtKbrq9r3HIy5oXlP/du9ZkDlHIYTjEk?=
 =?us-ascii?Q?zRbdc2PWwO+W3Cgrx4rnh/PCchbDNQU+bdNs4G2Y83F1jLowdQ/rGNAGu+I6?=
 =?us-ascii?Q?0NfxxPIzYLflSR0mYz6zmQl9fMScW1a2JM9RPv/5qCOBfLJP/0D4TlHUf6Fp?=
 =?us-ascii?Q?Kq9hM7Oqg8DR/ps/YKsoF5DDjzngOvmqv/Uu3Q/OxoHKaHJcgHos63Uc6Zst?=
 =?us-ascii?Q?YGMRQXFWTg8uZaWVm0IvGfrv+FrgW0mr+PTyLjs5gKLypgPcBwxa59tp0h56?=
 =?us-ascii?Q?sDTXfp74t5hidVA7ULsHW4jEW5SEyMForRUqwUl/0IAUjpY81CubX2kwoWRR?=
 =?us-ascii?Q?GDTNb4zWqNuOgcVPEVjaTK+f08Nyon4gY+JbsG3Kbb102ib3RKYUy3I7Xqb4?=
 =?us-ascii?Q?Mh1Kob2qDSBrOyr+g+2rmEyZ5ExK1R7Ojf1mCFMMa5Vs5/f0E5EMAlosn9Au?=
 =?us-ascii?Q?tQM9Xi8fqj2+HZtPDS//4m4Bsk4+Pgc7AY3y9OgWGDkbLKHnsJUiyI2Uf/IC?=
 =?us-ascii?Q?aHjlru0uTFwmQo743/UOAnu/pyFzaOJ+3IeoLrb+Ur1TS8nR8MtSA3xJsvob?=
 =?us-ascii?Q?egDywCJwX8a1IBc3UrquhgcQ9auSYo8lz5raQYSg9jZ0Qtku9KPkKsraiika?=
 =?us-ascii?Q?ithvKX13DYIyGvyrFu0PshpIbUMbQrPByCSWE5woyLKmm3i4ok62deN/yHGR?=
 =?us-ascii?Q?ISljNTbk0XEs+xfTo15DYUgoTmdbeUs7H8LlhuDD1aOOOt/Qw6BXlWxCQV+z?=
 =?us-ascii?Q?ThEPrj9iQLvfKMobC8axmYMNBLszoFF7KiTjWikHWaqPMAEXrVB0A1iDpkIT?=
 =?us-ascii?Q?SeZjHXBqI767g2/Hc4dPEjV+j3VWN1M4V+A/3iRJ22KfdQ+gf3qvHnc8KyeE?=
 =?us-ascii?Q?s9tRClIFf0dl8walazfKSmDH+fBOIi6mumOSk4lqjUuDiDZq3oSaQmBea48t?=
 =?us-ascii?Q?TCV00JYcOFpMaaALEsw1L790J/mc8M96xswxBu+97gYvJ1LBPTd5WoB3/htJ?=
 =?us-ascii?Q?ssYL3DSpZDKx/x1pknzOuzPfZ1Sb9fY/DgvyyKyMyRsZVqXXZrlsJvK2n6zq?=
 =?us-ascii?Q?qWtLeCdnnF66oru5Ct1L5qD5gs/GZ0ayKivsWlh+/df1x2QuMLnmRt76K/g/?=
 =?us-ascii?Q?Zgitn8UXmxxchb4jNz0f+jY3nQ6jkYtae8C/U76YK/wDbGc9uzdrgGLh51IW?=
 =?us-ascii?Q?dcLKhOI/XvG7uozIPZNY9+TkG+yPeni6NtZcv6rVKxqW3RRBe84RpN7kEVp4?=
 =?us-ascii?Q?8W8uHjeDxikf/0sY3ywox4E7kl6BlVA00AjIgzA1jJrIrsC3nQ8zmXs8r/Gd?=
 =?us-ascii?Q?aGS1GZpPd9Am1xDDIOyc/Wwt3iCJHTI4iJSvXYzJvDfS7cvB3LEblhzTj4Pr?=
 =?us-ascii?Q?hY5IsyU3A7H8VzwRdRdn4dPlP2C/ZLzZ6GZt4cu2fIBwfxS+69+lflf6Jh/E?=
 =?us-ascii?Q?BT89FG83yNQhdYZZSjpeU9cXGc+2u5LDKS87ahiZxHnQCcuBKHEid7Guc2Hf?=
 =?us-ascii?Q?b8iTJ1vjpHwxqC9OM248mKF43UdaopLCB18gYy1g7x/EvDlFiQr3mc1pS60C?=
 =?us-ascii?Q?h2FV3dVva3Hvy4EDGbUoNwQwvW6A4uaKu0qfTJ2Fd7tGqwhe2D3H1pu8sfot?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3712145b-7eae-44e8-7ddb-08dd616311f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 12:40:28.8867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UmDu+pNh1c39iafuiFiFe0XAVogy0hceZqDHXBSKCuOv21RlYq1eJoG3WcV0eXwhpph2qfZEoP3ttPGm4V6vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6352
X-OriginatorOrg: intel.com

On Wed, Mar 12, 2025 at 01:49:51PM +0200, Tariq Toukan wrote:
> This short series by Yevgeny contains several small HW Steering cleanups:
> 
> - Patch 1: removing unused FW commands
> - Patch 2: using list_move() instead of list_del/add
> - Patch 3: printing the unsupported combination of match fields
> 
> Regards,
> Tariq
> 
> Yevgeny Kliteynik (3):
>   net/mlx5: HWS, remove unused code for alias flow tables
>   net/mlx5: HWS, use list_move() instead of del/add
>   net/mlx5: HWS, log the unsupported mask in definer
> 
>  drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c  | 6 ------
>  drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h  | 3 ---
>  .../net/ethernet/mellanox/mlx5/core/steering/hws/definer.c  | 6 +++---
>  .../net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c  | 3 +--
>  4 files changed, 4 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
> -- 
> 2.31.1
> 
> 

The series looks OK.

Thanks,
Michal

For the series:
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

