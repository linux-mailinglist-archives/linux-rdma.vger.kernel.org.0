Return-Path: <linux-rdma+bounces-3754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7141792AC08
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 00:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26708281F8E
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 22:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F4F150990;
	Mon,  8 Jul 2024 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gplWeo1S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B603CF63;
	Mon,  8 Jul 2024 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477612; cv=fail; b=O02kQ0s9gBmFlEs8mfIjUoVpt4IgQGlVdy6JOx4n/kB4YTqwVF/ncsOun0ha9UTysDeifbANhRdZvi3Y44Fy3kToEEEX8Z8zJPiaPv+XL/9YJ+ccW7fZm5k4Duzs5LGsYkI/NTujGvrfy4WdMsxd9Z1HVGqJvihwaLlulitc1n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477612; c=relaxed/simple;
	bh=piexSMP7guEWKt6aSkEH0x5WZK3/I1tzUk/NArmGKao=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZfAWxzcnaXX1O2Ifq5eulQ9/psp7KHlmeQ6RJYAEJ/sLIQSBvOVIo11RAXyG5gUhiwFWGNPAbxODgMBK5p4tbXzyjgsjEJ18shNC9jQcWBsbjR780Pqbs3fhGptLXfxkINkYwXO13k0c6FVIUdCQw648DLjetY0HZ4XfDCSthQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gplWeo1S; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720477611; x=1752013611;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=piexSMP7guEWKt6aSkEH0x5WZK3/I1tzUk/NArmGKao=;
  b=gplWeo1SaMkJx09ndPOyywn/wXDS4tGYRPTi1t1ir+MCTf8Dh83D0vwQ
   bM94stFbn1vp2ZM7DC+dFjRqjdbIoMFnDz6ng9HdA5GgN68iXmgFAbwNG
   ISyoFUcEvEsSPGNg4gno+iRhiGQ6ckWDVodF2HvytKCLnXUFziHd3RvK8
   PrLNbp3mfm2PIXc/kU75r3cDEIyP1XH5+K3J94vxw8fp0P1/UrirUsA4C
   NN8kdj3HSe3hPLILc089nX2M6hLtKQVNCQBmDoSo1SpjEZpQOX/iOHKhi
   LNUxJZVXrwJorcwQbISPCGalwgyZSwFzoZMDUXCGb/yunxl8qEz+MigoO
   A==;
X-CSE-ConnectionGUID: SxDHl4zkR1ieWlA2XMS1zA==
X-CSE-MsgGUID: jtEYDtwFRIazi80epRCu8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28310082"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="28310082"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 15:26:50 -0700
X-CSE-ConnectionGUID: 1tk0kZEySXW8ns10TPnxOQ==
X-CSE-MsgGUID: gxU3gwj8S9ObPtiZnnSCCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="52446755"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 15:26:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 15:26:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 15:26:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 15:26:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 15:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFwOEKySkGpKTjjFC+ay/TOgPFQVIfMYe2Ob3xJTdrQtsiaIWfahUkrgFfwB2RqCKHs8e/YWtq4nXBbmtXd7K+KIFZ2+3eCVuvs1iQayA8kDKrcFEaiElDyDVnnxqcrkcBv7uUHD7hAGvZD79UGW6aR7UzIJ2AqYEGk4eEaJZNPFM2xXMKt+rbcUJId7b8eeRkMKZLIQ+g11DZd9bkWmFt50PofhGN8ASAtARohsVdqGMx098MJ3ogczxmRwV9oQ8xVtASSSQFs6OJtFp/PIDZdffWKy3WPq6fwUdaGADRHHiyJS5rBm9bBeoPP0cP3HI9swqs1g1DXpX16EmXyl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVZnR4wvlYpKjLt6D2Hff8WNnrKI1i/eV9uK4kGWbfc=;
 b=LP+YLIqioUO/odTOPSdBS4laSlqf1ivWvgU9LsCCH37fv80BbAsQBTa8leOEkmZBP8qL1TUTdI+zpO/PVr04xp+dHlYHAEGf2BVO//QtgMZtTfABoGDyhLAAcbYz45Yz1+ae6gD02YZkQiI1Lb4AgD4E9RNGeLHNRntM6qzEXGidcJRv2xBNtuJWdlvxUji/5YOg2jHhHyWi2WeTkmaQgk+PoTy+XaAvgRpF/uCAYZZNMAiX2MN5LqtqvkZvNwewW6aU71DmRYPnquBq0PbaHIkgZv1q898bPv76Z8ufs00CArzbESnlNHjqu1koU1ClAxOSW4eQsm+QWKnvof2vBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6133.namprd11.prod.outlook.com (2603:10b6:208:3cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 22:26:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Mon, 8 Jul 2024
 22:26:46 +0000
Date: Mon, 8 Jul 2024 15:26:43 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <ksummit@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <jgg@nvidia.com>
Subject: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:303:b5::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: f73d1cf4-780f-423b-b483-08dc9f9d0d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8eo+9nzhVqPwn5aHEp+rwUisGCJwCiBbCK8Vbuub/NSD5jEni4ByASqw+pdt?=
 =?us-ascii?Q?9scU5DoFCCskui0qNLS7qnbfYWhoJHBwF5SfU1oa9hlWQRWti2Kt5j4PjqXi?=
 =?us-ascii?Q?565QeXKuCN0gve2buyvsKrzNgg97z34ppGc9PBqiBUj7Q/i2atGt/6EjO1Iy?=
 =?us-ascii?Q?olc4K65zTPM2uJeKTd50nSaH10TC92fnkZP/Lc7SvoeXnlB9SYE5myRBicyi?=
 =?us-ascii?Q?gFySRLHKuCX9bwMy9mCM8DQ9Gdb/GaTQ5+oebUV7ORAqAWNEqNdZXu2hSxvD?=
 =?us-ascii?Q?RhH18kPgOKLmfbwrzxyThc5fibfSCSN0SoWgusrte9NtYMHETEdw0TMju21g?=
 =?us-ascii?Q?sZH7g0ob9XTQDrvsS0K5N2o0Yhx5QiUIW4LqIcDOgj73fGmb1K4W9n6XYs8S?=
 =?us-ascii?Q?ZLy7dgXQ7AfMsJwVgW1L6wv+QxwPVo2vzI/pvjYfudTC10rqyddbTuhOHTKY?=
 =?us-ascii?Q?ZyBrwbPDP+i65k8ASbhS22VKHBMfYoIrcx0s+VUmcVwRO6CWvcdQpK0hKmm1?=
 =?us-ascii?Q?M8p3OEYQ5Z0eoRhNpWG1VV3h9aVGTd/URD6XcU4zlpmLsimEPdcZK16pAR3w?=
 =?us-ascii?Q?46mHDJmnd8YSabDFbBZZy6nZ96PmidN4Hyxe/4D7B/OT/vKkvsWF+Grp40nc?=
 =?us-ascii?Q?XmppX8daZ1yKCfzWhn90ynQ62uswQnL+7xsAIBalE4fCqK5rFRcTmNtXUALv?=
 =?us-ascii?Q?eBFVBjP4VQ0UUA7Da/95wfV7T7dLDkkJZT3bAU7XfMoFiVspInDgyU85dZ53?=
 =?us-ascii?Q?JytsfkOANJKblUWNWv1RZB4r+urF8PlqEbRiGQIn5J5pr6efiWfuXzWsqPTN?=
 =?us-ascii?Q?/y1RM7BzkoHW0MLAJcvxjzUliKOTtwvo73QpFYjk5y75HSOmnTaiW5W6FU2J?=
 =?us-ascii?Q?EU+0XolYlLRK8p3k3pxdFPmblLm37AiHmjNO54CWs+4KbzcseocE3NgOfkkl?=
 =?us-ascii?Q?oF0Bwd0yd5EDnjb+J+hho3qNgSN7olf49y5jvHRPmBf42DFruHtzbrAEud0t?=
 =?us-ascii?Q?GeJFIpcKiHrPj7t5phFLChlt0hn8Xp/EtK3e8C690QSTWASriU5M8r+T+U1f?=
 =?us-ascii?Q?2fkyvMweLuW7DV5jb0PMDvAUQ+QIEF0T5VJE8LPXpb3VIkCzi1lZq52g4qXW?=
 =?us-ascii?Q?b2VM4SdEHp7cQd8dylwkMtplOq2DKe1R6n9Ep6NGQaxvGDfly34q/YhQFeV7?=
 =?us-ascii?Q?0+75wVIvnKxtXuLVSCGC48z6nM65CVk2P3DwnaGIFCh1w/Hwzjnt4VSKYDDc?=
 =?us-ascii?Q?oqTbOTHN94yrlGXJGOX+RB1hRHcRaOcICf2UmRMGQODJNi9l+QgRa11MrV04?=
 =?us-ascii?Q?Xu8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l8vzBuKmiqCnCIpPBW7KBnz2RGkHgnNTPQ4UCRRMXzyZmaJOKUlZ6SHm/Bz3?=
 =?us-ascii?Q?8aXTfgbmoul3S1p0Tj1bfTHM3Knl2lf9vhta/bGKDThHUsdLU4iGJJaclWyt?=
 =?us-ascii?Q?n/KJLjwuE9WEzyab0/GGD4gbpV8GAU6sd6QMBKIekW4fPIQvhB2KdoMw6GCZ?=
 =?us-ascii?Q?/brkS37C/8NBjuQWtogmzSSADWCFs8Y7oj2BBc4zi4YR+uWUjTvSW79gvFyE?=
 =?us-ascii?Q?u7m9Mt/xyT+krFRKxfLofi+8e96ii0ZAgjaKyhk7kl1v7jhDM69vkVMfmeX5?=
 =?us-ascii?Q?YRYYHWNK9VyiddWXxx6MwxRb5EfT1n29HcOhH3yRvxrpkUdbefkkWgGlEWdo?=
 =?us-ascii?Q?GYVJmO1WZDXW7LYNiJVvUrtlfo9Jk/XGXAL+eNCTCRFJ8pFSxbQcNK0Ea6CU?=
 =?us-ascii?Q?e6orAEnoXxepyoV0b2MXAkMzqKww9gy81G8AUalaqko4xjpeJmE1DahZr0pG?=
 =?us-ascii?Q?+xc9gqq8yyd9+t4BFZ5UC7qS6GRQ/fbD4ePZaVQq8uk/ldikcaRy/UeW4Onb?=
 =?us-ascii?Q?IJAyKnx8h/kFr9rkqkqc2JK7ML/sqqAdK4EGB6V7dwAugagy+TMSo2DSJR68?=
 =?us-ascii?Q?VHbIxZuODurln6yU3PkhkuI8h7g80nIIUJptF5+N0UspUs7CP2sX+C0Yx69e?=
 =?us-ascii?Q?eIoFacl6NlSH7bYhLxKFYSkL+K9b95WNNzMjiu25Lu/apybZsP1XVNULQvSM?=
 =?us-ascii?Q?Im6Ytu9h9wu4k4DSuvhAiGZL+0UlgP556OUKIFb4yG8/tiCbRM/arp5Y7D+I?=
 =?us-ascii?Q?6hfVE9j7l1oXKnAJqBFunGOV8DfGD8BCjQkT6fgSBOxVyt9a/+KXKdRE5f+/?=
 =?us-ascii?Q?I1JfHDTRogop8JySHEq2vVWv43N90i7Jdd2kPz8Q4c2fO6QrqPQ+d9trpdBQ?=
 =?us-ascii?Q?UR06rmjjkmYvKjkabXpBK1jUNx7BdEKooJ33pCz+pfMuelnocOYeYQx8qakm?=
 =?us-ascii?Q?P5QCfUGi2D/YrCPpwjBtwJ5jui3ZtQ9FTyxV4Zs76evAnR1mQj9UsLHVzFK8?=
 =?us-ascii?Q?SaeDuIUXPQsfcLQiPjPuCWIA76Q/TpxiZo1tI0Rd2I3AAQHlWZiyJZsN+O2y?=
 =?us-ascii?Q?tqXI5ZBKcNDLNeuI2lrOQvDjStBGYnbBtPHzP9GJAqfVXx1SNetMzBeqSQxB?=
 =?us-ascii?Q?HjkIFwQ7znt4lk0nQVFzatMCELzsmlDGORIo2cjEl8y3lgIgWYZBGK1O1b9d?=
 =?us-ascii?Q?LZDVj0s6BkcKv9pR/gEWqvB4SoOSNFaX7yrk8LNmyxVYKavjgZSkSUgGJhX1?=
 =?us-ascii?Q?7vJh6iY7afA7+Rx3iv4dZqg3vp00kzYyAbH5hPru4URFAlQtYSXqK2YVeJwR?=
 =?us-ascii?Q?ZAwvR2fiA+staNTLd/WtGcQVvBVukj2/yQ1X4B/H80xS+Xwgo+2ljpAM+ujn?=
 =?us-ascii?Q?yoUZ7EvsSyn4xD0JwzQEIWDr1h+jXqpxcVLfS8e2c0pvtAv4knVtOUWxtlMG?=
 =?us-ascii?Q?+g1eITJG4bYMD154qwRYiwW/Sv+LYJel0P9f6K+5a/5RQt3pUwVomZFTSko7?=
 =?us-ascii?Q?zM4wk23egmT1nzbXWwZAcKURKwP5+9+K9+fjLJIA0tXXCuPA6NSwvAlKDF2Y?=
 =?us-ascii?Q?n0WbHJg6FNFFPj1anFoqFoDBvd38Ql24ae+DvMiFWkY0xUQMC66ZLHgCheKc?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f73d1cf4-780f-423b-b483-08dc9f9d0d45
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 22:26:46.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oE8mmHv9PSwkZgtjvYB9oGaD+G7F6Uma9tlhsstPuRb6A6EumEwQqS+JIppG1se2RU+AQiN1Fd9Ue+/7vGRQJNoKiLUVacHjfr6z6HxUJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6133
X-OriginatorOrg: intel.com

Early in my Linux career there was palpable concern around Linux being
locked out of future computing platforms by hardware vendors who did not
provide open drivers, or even documentation for their hardware. For the
hardware vendors that did participate upstream, maintainers used code
acceptance to influence them towards common Linux commands and
cross-vendor cooperation.

The internalized lesson from those days was: "Be wary of vendors pushing
'do anything you want and get away with it' passthrough tunnels. Demand
open documentation of all interfaces."

Present day realities and discussions merit revisiting that lesson:

1/ The truth of the matter is that until the Kernel Lockdown facility
   arrived, device vendors *had* an unfettered passthrough tunnel via
   userspace driver mechanisms like /dev/mem and pci-sysfs. The presence of
   those facilities did not appear to injure the ascension of Linux.

2/ Device passthrough, kernel passing opaque payloads, is already taken
   for granted in many subsystems. USB and HID have "raw" interfaces, EFI
   variables provide platform-specific configuration, and the oft-cited
   examples of SCSI and NVME that provide facilities to marshal any command
   payload whether mainline maintainers think the functionality is a good
   idea or not. In the case of NVME, the specification continues to evolve
   despite this Linux bypass.

3/ The practice of requiring Linux commands to wrap all device commands
   does not appear to have accelerated upstream participation in the CXL
   subsystem. I.e. CXL, in contrast to NVME, relegates passthrough to a
   build-time debug option. Some vendors are even shipping vendor
   specific firmware update facilities even though mainline has support for
   the CXL standard firmware update mechanism.

   With the impending arrival of CXL switch devices wanting to share
   mailbox handling code with the CXL core, the prohibition of
   device-specific commands is going to generate significant upstream work
   to wrap all that in Linux commands with little perceivable long term
   benefit to the subsystem.

CXL and RDMA are also foreshadowing conflicts across subsystems. It is
not difficult to imagine a future CXL or RDMA device that supports mem,
block, net, and drm/accel functionality. Which subsystem's
device-command policy applies to such a thing?

Enter the fwctl proposal [1]. From the CXL subsystem perspective it
looks like a long-term solution to the problem of managing expectations
between hardware vendors and mainline subsystems. It disclaims support
for the fast-path (data-plane) and is targeted at the long tail of
slow-path (config/debug plane) device-specific operations that are often
uninteresting to mainline. It sets expectations that the device must
advertise the effect of all commands so that the kernel can deploy
reasonable Kernel Lockdown policy, or otherwise require CAP_SYS_RAWIO
for commands that may affect user-data. It sets common expectations for
device designers, distribution maintainers, and kernel developers. It is
complimentary to the Linux-command path for operations that need deeper
kernel coordination.

The upstream discussion has yielded the full spectrum of positions on
device specific functionality, and it is a topic that needs cross-kernel
consensus as hardware increasingly spans cross-subsystem concerns.
Please consider it for a Maintainers Summit discussion.

[1]: http://lore.kernel.org/0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com

