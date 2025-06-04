Return-Path: <linux-rdma+bounces-10973-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78C1ACDA25
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 10:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F890174584
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4428B4E3;
	Wed,  4 Jun 2025 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZ6jntUM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344771A08DB;
	Wed,  4 Jun 2025 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749026593; cv=fail; b=mB/+/pLFrnYB45oIYyhIjPw7830rxefEe4xKdwcIurGosaaLaEtsXPOpuNR/W7tvko51zyQj7KT2ZZ2MAcRygwLjDUO+R/bRpA6Ox94d/AJM0yoslkgZ42nWM1B1tpRGSsZ0C35Pda8R7EoTGotmTD6QaaRD7X8sn+jg2yWXuus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749026593; c=relaxed/simple;
	bh=dqeTOemjCMBhLf7EHfR3jc521d+Muav2++1yIxM5+J4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uLPHnsil3kqRk5hsJRDuF0E2cXj6PpyEhVHOwG3ilAisoKntebLMV1a2qP5Kj2XkkziUouY1K46OeGYcw04gQk6PLkAR6heFXqyyq47+6U3D7wEo7J96WpeF1qN9exo+luWvhznYd7X1wuAvfZjDPqZl4+gYanmtNb1k+eYEw0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZ6jntUM; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749026590; x=1780562590;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dqeTOemjCMBhLf7EHfR3jc521d+Muav2++1yIxM5+J4=;
  b=SZ6jntUMCMyvmX3OHYb75ETzhy0OgOczXJ8RHrWg9ARmpj7T/gFs7eRQ
   0CRnk9ouk144ltYi2G6oCXhUlm0/NGPnezdFpsPf7srVvcs8IRu6pgYpZ
   lFE/nv7uNRON3dyp3cfGnXXiW3QJdCnKU0HDLG5fIVhTTLrjr1IGE42my
   dJ7u9pdbu65arHsctkqmE3dgnIIZajchlD+PPiSfq3C3TmLte/+Y02NC0
   M5cUjQ3ufqSe2vQIKnQpoHK7AN7WTthzw2sLm8Kix7GCNg/FT846XLYgR
   +yqJKVe0WCYCHHBh7EVwCFbxMnQhq7edk7y/ZMgqUDm3exvwn9WvsEh5k
   g==;
X-CSE-ConnectionGUID: HaYo8JKURaO46f3/ywaIJQ==
X-CSE-MsgGUID: 19nVu8FITEO/zWaGg0GCJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61363147"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="61363147"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 01:43:06 -0700
X-CSE-ConnectionGUID: YwCyxzeWTESwJiS7KWpZ/g==
X-CSE-MsgGUID: uZo/g+mDSkqU0eAxITd4HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="150277070"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 01:43:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 01:43:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 01:43:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.54)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 01:43:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Unt2MxbYfQoXwHcJR02qB7unQnsaUx24xd+qWD+OjoK2EKvUXUKkW2W8L0DQTW7sJSq4KtpxDhdJw6IqY0ifG3XyRO3f76dZTy3burtSM8eHkPabRqiCjeGc3n54IVADx2Qt/rzoIdI80Ox3Fzy4MdHhISGzhdZ/QqN+RvdSRnvK8sh+tZuARDGUbOWKjhPW5RiaB7EEJ+SoSNddvNwGygF5E/zb8Rks34FOzlyfuMO41H1fOeWSox2D7uM+Yj6+EE6DCouJ2Zy8RzPS/vjh+kp5/5T/U21yJhvv3SVmfZKWBnv+MDNEZwm5EVKUDqeocsZL4MnihgPjL7MS/get2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Np/n7/pfMi+h101LaOxxVN85WFXGjZOLir3oimiRgA=;
 b=fFJqEncHS53ASdi8MrX/mFIo5fRb8jnhCvOFeQ0vsofqNv1hS8Erq5pxv3ZFM8diRfVYLhcNJkR9mvusQUIV1dbxCriJG78YJaYcGAaCFVCHHILeEY7PEDXGSdTBXoj8ic2lRZ1vmu/FuoNwqjtWoKGs0HlGfAHmP0dVVBKHbYzMCEG/iISKQAz8tq0KNJCrkVX5Z6WqChQyhZ8zCstXhg7Py8rckcGYcz9nixDvYUWgWveLIxUk1pFCclfwmVKUUnUEPO8y5CAZdMF8JqrluqiVGLCBjXeoWuk3/Nww2iJ658nxcxaBe2n2EGD/hxF+NiD6STIIrM8kL8wE2LpBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7495.namprd11.prod.outlook.com (2603:10b6:510:289::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 4 Jun
 2025 08:42:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 08:42:47 +0000
Date: Wed, 4 Jun 2025 16:42:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Allison Henderson
	<allison.henderson@oracle.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [rds]  c50d295c37:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <202506041623.e45e4f7d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU0P306CA0021.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: d186b636-c9b6-43f8-4ce3-08dda343c86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kEQDDiuV1bqgw+ZVodgw2ZVzgbp8sdYeuNbAIDbXDiHOxxEryQur8PckMYBM?=
 =?us-ascii?Q?YgUegRu499lOMZOeMi8DSaXu3ABRzywcmahthq6c9O1exFq4BjEJyDTTZ1K+?=
 =?us-ascii?Q?vvJ393BhLj7KlekPARosmREj0Hq1dd6uQR4R1vThTdDYjJmARutSQZf3wks1?=
 =?us-ascii?Q?e0qLpFZ5/9UPLobJN0sRVFjhO/ckAmMQ28+0crIB2MuC6R+MimcYORA2ImKM?=
 =?us-ascii?Q?yum6INifmbN46iyldOKLI7ZTE5TKqeY53zeE1OcdYpQTKX3WgXjCA1dtlekk?=
 =?us-ascii?Q?zY0kEggPbvPrGUQyMZWVsP2yJgDh7TuOnPjX2VZUn+JNzZzek1APgmOKA1o3?=
 =?us-ascii?Q?Y3EqYoINENxOcUus3GD1e7yPH8twBVz1i6iF3d+lIR3RwDp3GKsyLVra/mVV?=
 =?us-ascii?Q?SAm0qY0gDxbbv8gBAg531N+cC3TMgN1JGu2UAPRSeFIz3vDhmL38vaiuPP6e?=
 =?us-ascii?Q?mLcHrBRsb3QvQh6RuqYI5ZGc7hBT2FSxduNyQNrTR+RFvFQNlkb6D9qgK7It?=
 =?us-ascii?Q?PMDb0XpW0B8VyPLiB7vZnCe3HXMc9/ivgzlTRcVfm+YgdDPeTVsHeboWnTEP?=
 =?us-ascii?Q?NyeAi1VVjGTja0M3wRCs3hsrHquT0rEO4prb0Rl7cb+aHWdC8Up3O1ElZ7aI?=
 =?us-ascii?Q?yb0PzTt/WHS+De1Va/RT2KcJAUwv9RxCW8AiARyh5t84icCKz37VoMOoP4Dv?=
 =?us-ascii?Q?rN/kDr3tTKETw2o952eyRYFw9lS3cfDd2JIQaSFTUyjZmr8pg1aUzyNJKGjP?=
 =?us-ascii?Q?6J2bKzRHZkEIbxx0iWSYqs8+1eCZpwbYmhTvN7FoNhc1OzxK86M5smWtoI4Y?=
 =?us-ascii?Q?DJUcZCeim+tqXQk5M583vF5Y+N5inkEIamcE/641pA9Do6xd+0Rm2Rk/iZSk?=
 =?us-ascii?Q?aoMzBwPdsJLYhHrIqGb6SZR0PzSNFCbFHGB/B9r2qFH9Nfmogh89q0afhVs/?=
 =?us-ascii?Q?KK6QTu9fy3+zCblReRA+G82VQzceyI3ZoL6q+1UD3d+4YOVNv5vhRoZUnoW4?=
 =?us-ascii?Q?LF7gFVi0JdUxNL6KRK0biHghFo1TvAZB8M14TbBLcha8vkfTBnqjIcAmDN6M?=
 =?us-ascii?Q?zGP/7Zoah/edwtlI1dihvxBQFL0EwUMSgXToy6S1ALBUdpcE7XAL+x1To4tD?=
 =?us-ascii?Q?9meS8edS0opAi9N9mjy3+6tCSAUVPjMAoEQIttja+nJquwOU1etrffSOkmnX?=
 =?us-ascii?Q?np5qCRAhrRE+Pysz7NFUfhZSWf5UnB2oNUJRgiA0fL2TXmLwGgepY2GGLxn5?=
 =?us-ascii?Q?6ir6VpRws9R3FtimcO8Z8LZ4oXxLh6DZXxpcS8aEe/1/MRT/juW/Umf54jF7?=
 =?us-ascii?Q?EuyhQSFgYY5ICqqPfvF3w+BOmOeBrGSWOE058AOTmgLr+i3c+zjK0rfCPHyg?=
 =?us-ascii?Q?id9WdyZO4jaiUIdFZl7ZRGZN+84C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e7/giROsjcOJnpzNdIQ2+qpfQgflypMveMMvPTDQdDwE71iHJPwzrCDbLLou?=
 =?us-ascii?Q?IFYd7dhoAiMHlVf4cHttIgmdVAsyxP5Dh0ddx/IHCJay62g13az5d7nJ+KD3?=
 =?us-ascii?Q?429uU3xMrVwXRV65KGND4w2C9oSFc10EbJ1wX4VM5zWWwgzmnzDRM0NM3DkF?=
 =?us-ascii?Q?PGKPAmubdLv9aNcPLR8kPLUPcOdGFN0h/SL4+omMPtOMZysHqk/4IWltmclN?=
 =?us-ascii?Q?3lu8rKXi0xVbQ5eYitifzupqLIDG4Ghqy+go0bkmLyH/KETIBAXCcrCFwWzm?=
 =?us-ascii?Q?Uibl8fBirJV5fFqJb8GhVoaYZmVslrPl+oNI3iufGaiQb7L5eD7emHsS3jkV?=
 =?us-ascii?Q?snmIM89zWlMTYvmBpQXQqMCSFb0CTZJVS+SL96fCgZMWcnsJXxIp4NN4ZByk?=
 =?us-ascii?Q?qFlTr40pmwpIP3ECiIcN+hlZB9zljuqog4iyGWwIJf2C3pe2uIfckdFiCcy2?=
 =?us-ascii?Q?2BjUyz5RlFlXCUVMgk2YimG1Hol9hWdZtMJ+ri9qV6Gzu0RG0az/om1/EZMO?=
 =?us-ascii?Q?lw0F/dp8u3q+TLwKgh8NCsDAHr9M3P2LEsvxMA6zsGtYLKmBNEvi1lzKvAeA?=
 =?us-ascii?Q?FweKXoGT0s0d2GTQkYHZGElefWlRwyLokuw5tQGlk5T64wpGso3Yxsu9Zeaq?=
 =?us-ascii?Q?pkEvpocpS6uY5tTe4QGjWFfCpN4nUXn+GukAtsXJ2yeWZekDWnTQNq4JDeKU?=
 =?us-ascii?Q?0BXOGjA4qaPe0+gEPQ3Gbs5L92EypqXEKwPDFD03DEzCn7OHN0quU561ofPf?=
 =?us-ascii?Q?nrO+AcFNPjesJv4dlA3TgLyh4/Bd6hEAy7MVbyNXYaMl3BDpezkV/e9KUysv?=
 =?us-ascii?Q?mUv6glaHk02PeffhsBhO+6TNUmlb+hg8M9Kkp3RaBxRcY48oavZk+VKzJWUL?=
 =?us-ascii?Q?exeude5FjGCxZ8BHpUG/iCkB4PG3wxn2mZbaFede5ooPUR3OzqQWva045u02?=
 =?us-ascii?Q?VAGbpaKqAbiNvfuXxejTPxFkHsIDKuKJ+Zrfv7hub7gxEjHqzJS77e8Ddvso?=
 =?us-ascii?Q?z4TJOlneq1TnTiIxVOX4vKPiDl+XC23xzUt9133VtXubgKvs9yfA81tX+eIw?=
 =?us-ascii?Q?hlZEdem6auZHi6bZofOrvSQgc6TyAP8WQBTTsnxxtlRZ4/S/UXSpmqWKC36E?=
 =?us-ascii?Q?1n0zGHc7+s/nNL+GAMp6m2VivQ8+5Ts/Hk0/9814zYXWsqnMdOl6lneejgBu?=
 =?us-ascii?Q?iqFkxfNsMnqPglQTLzFDd90LGuvQ/MQ9mc0NeXsjdhLz3TagewQxEEofv39X?=
 =?us-ascii?Q?IitoaUZ3bQoNqXkwqjpNIdbtZzW3b8qvY3HR6ZXYfFFd/BgaYPjLKj2f0Coe?=
 =?us-ascii?Q?efwlXVjYQC9mHWz5Kp0QANM3E12NFSYcVPzrOkEca6l4k6cso5PLDjDeUfU4?=
 =?us-ascii?Q?34hTKTaIxumpUTLTpfTcOxniXs73T4jpX/A97+wn7+37VybLIyx5aD3otPcW?=
 =?us-ascii?Q?dOkEHHkaGXnob2KAiMhH+iAMVXJ1mC7AEz2JGaYO+R34/4g84fYOvgRGjEoU?=
 =?us-ascii?Q?Z4V2PxHB655r7mf9Mcbitndut8hfNZcW7BoOBw+b4+D/N1tP0+sAgxVNHDNp?=
 =?us-ascii?Q?7egXEL8EG5S3EeuQxfxYxBzoquSN6RU4Hfw18FoO7x3UtJGb3pp6ZOKPdysi?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d186b636-c9b6-43f8-4ce3-08dda343c86b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 08:42:47.9069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jey7InJ9SFbs3TOYNDJQGJqVi7GWVwLQpxKY2drPhZTlL8uZnHTtR6Of0hOQpv/YFE7XkEj0pACakVXS3EFEiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7495
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: c50d295c37f2648a8d9e8a572fedaad027d134bb ("rds: Use nested-BH locking for rds_page_remainder")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      dee264c16a6334dcdbea5c186f5ff35f98b1df42]
[test failed on linux-next/master 3a83b350b5be4b4f6bd895eecf9a92080200ee5d]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5


config: i386-randconfig-017-20250530
compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


the issue does not always happen, 45 times out of 200 runs as below. but parent
keeps clean.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/group/nr_groups:
  vm-snb-i386/trinity/debian-11.1-i386-20220923.cgz/i386-randconfig-017-20250530/gcc-12/300s/group-01/5

0af5928f358c40c1 c50d295c37f2648a8d9e8a572fe
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200         22%          45:200   dmesg.BUG:unable_to_handle_page_fault_for_address
           :200         22%          45:200   dmesg.EIP:strcmp
           :200         22%          45:200   dmesg.Kernel_panic-not_syncing:Fatal_exception_in_interrupt
           :200         22%          45:200   dmesg.Oops
           :200         22%          45:200   dmesg.boot_failures



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506041623.e45e4f7d-lkp@intel.com


[   66.659921][ T3569] BUG: unable to handle page fault for address: 00001010
[   66.660296][ T3569] #PF: supervisor read access in kernel mode
[   66.660593][ T3569] #PF: error_code(0x0000) - not-present page
[   66.660880][ T3569] *pde = 00000000
[   66.661062][ T3569] Oops: Oops: 0000 [#1] SMP
[   66.661283][ T3569] CPU: 0 UID: 65534 PID: 3569 Comm: trinity-c6 Not tainted 6.15.0-rc5-01128-gc50d295c37f2 #1 PREEMPT(full)  36e7369f99e2cec5fc7af69ab3b5e48162ffa3ce
[   66.661987][ T3569] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 66.662476][ T3569] EIP: strcmp (kbuild/obj/consumer/i386-randconfig-017-20250530/arch/x86/lib/string_32.c:100) 
[ 66.662689][ T3569] Code: c9 ff f2 ae 4f 8b 4d f0 49 78 06 ac aa 84 c0 75 f7 31 c0 aa 5e 89 d8 5b 5e 5f 5d 31 d2 31 c9 c3 55 89 e5 57 89 d7 56 89 c6 ac <ae> 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 5e 5f 5d 31 d2 c3 55
All code
========
   0:	c9                   	leave
   1:	ff f2                	push   %rdx
   3:	ae                   	scas   %es:(%rdi),%al
   4:	4f 8b 4d f0          	rex.WRXB mov -0x10(%r13),%r9
   8:	49 78 06             	rex.WB js 0x11
   b:	ac                   	lods   %ds:(%rsi),%al
   c:	aa                   	stos   %al,%es:(%rdi)
   d:	84 c0                	test   %al,%al
   f:	75 f7                	jne    0x8
  11:	31 c0                	xor    %eax,%eax
  13:	aa                   	stos   %al,%es:(%rdi)
  14:	5e                   	pop    %rsi
  15:	89 d8                	mov    %ebx,%eax
  17:	5b                   	pop    %rbx
  18:	5e                   	pop    %rsi
  19:	5f                   	pop    %rdi
  1a:	5d                   	pop    %rbp
  1b:	31 d2                	xor    %edx,%edx
  1d:	31 c9                	xor    %ecx,%ecx
  1f:	c3                   	ret
  20:	55                   	push   %rbp
  21:	89 e5                	mov    %esp,%ebp
  23:	57                   	push   %rdi
  24:	89 d7                	mov    %edx,%edi
  26:	56                   	push   %rsi
  27:	89 c6                	mov    %eax,%esi
  29:	ac                   	lods   %ds:(%rsi),%al
  2a:*	ae                   	scas   %es:(%rdi),%al		<-- trapping instruction
  2b:	75 08                	jne    0x35
  2d:	84 c0                	test   %al,%al
  2f:	75 f8                	jne    0x29
  31:	31 c0                	xor    %eax,%eax
  33:	eb 04                	jmp    0x39
  35:	19 c0                	sbb    %eax,%eax
  37:	0c 01                	or     $0x1,%al
  39:	5e                   	pop    %rsi
  3a:	5f                   	pop    %rdi
  3b:	5d                   	pop    %rbp
  3c:	31 d2                	xor    %edx,%edx
  3e:	c3                   	ret
  3f:	55                   	push   %rbp

Code starting with the faulting instruction
===========================================
   0:	ae                   	scas   %es:(%rdi),%al
   1:	75 08                	jne    0xb
   3:	84 c0                	test   %al,%al
   5:	75 f8                	jne    0xffffffffffffffff
   7:	31 c0                	xor    %eax,%eax
   9:	eb 04                	jmp    0xf
   b:	19 c0                	sbb    %eax,%eax
   d:	0c 01                	or     $0x1,%al
   f:	5e                   	pop    %rsi
  10:	5f                   	pop    %rdi
  11:	5d                   	pop    %rbp
  12:	31 d2                	xor    %edx,%edx
  14:	c3                   	ret
  15:	55                   	push   %rbp
[   66.663604][ T3569] EAX: c6326063 EBX: e336dc08 ECX: c6d03c10 EDX: 00001010
[   66.663941][ T3569] ESI: c63260c3 EDI: 00001010 EBP: ed5b7c4c ESP: ed5b7c44
[   66.664278][ T3569] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010082
[   66.664650][ T3569] CR0: 80050033 CR2: 00001010 CR3: 3c528000 CR4: 000406d0
[   66.664987][ T3569] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   66.665323][ T3569] DR6: fffe0ff0 DR7: 00000400
[   66.665548][ T3569] Call Trace:
[ 66.665709][ T3569] register_lock_class (kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:880 kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:1345) 
[ 66.665957][ T3569] __lock_acquire (kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:5111) 
[ 66.666178][ T3569] ? unknown_module_param_cb (kbuild/obj/consumer/i386-randconfig-017-20250530/include/linux/rcupdate.h:1155) 
[ 66.666439][ T3569] ? lock_acquire (kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:472 kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:5868 kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:5823) 
[ 66.666661][ T3569] ? unknown_module_param_cb (kbuild/obj/consumer/i386-randconfig-017-20250530/include/linux/rcupdate.h:1155) 
[ 66.666921][ T3569] ? mem_alloc_profiling_enabled (kbuild/obj/consumer/i386-randconfig-017-20250530/include/linux/list.h:83 kbuild/obj/consumer/i386-randconfig-017-20250530/include/linux/list.h:150) rds 
[ 66.667383][ T3569] lock_acquire (kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:472 kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:5868 kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:5823) 
[ 66.667598][ T3569] ? mem_alloc_profiling_enabled (kbuild/obj/consumer/i386-randconfig-017-20250530/include/linux/list.h:83 kbuild/obj/consumer/i386-randconfig-017-20250530/include/linux/list.h:150) rds 
[ 66.668058][ T3569] ? lock_release (kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:472 kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:5889) 
[ 66.668275][ T3569] ? class_rcu_destructor+0x5a/0x69 
[ 66.668562][ T3569] local_lock_acquire (kbuild/obj/consumer/i386-randconfig-017-20250530/include/linux/local_lock_internal.h:39) rds 
[ 66.668991][ T3569] ? mem_alloc_profiling_enabled (kbuild/obj/consumer/i386-randconfig-017-20250530/include/linux/list.h:83 kbuild/obj/consumer/i386-randconfig-017-20250530/include/linux/list.h:150) rds 
[ 66.669453][ T3569] rds_page_remainder_alloc (kbuild/obj/consumer/i386-randconfig-017-20250530/net/rds/page.c:93 (discriminator 34)) rds 
[ 66.669907][ T3569] ? __init_waitqueue_head (kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/sched/wait.c:12) 
[ 66.670162][ T3569] rds_message_copy_from_user (kbuild/obj/consumer/i386-randconfig-017-20250530/net/rds/message.c:440) rds 
[ 66.670625][ T3569] ? rds_message_alloc_sgs (kbuild/obj/consumer/i386-randconfig-017-20250530/net/rds/message.c:329) rds 
[ 66.671072][ T3569] rds_sendmsg (kbuild/obj/consumer/i386-randconfig-017-20250530/net/rds/send.c:1280) rds 
[ 66.671480][ T3569] ? __import_iovec (kbuild/obj/consumer/i386-randconfig-017-20250530/lib/iov_iter.c:1445 kbuild/obj/consumer/i386-randconfig-017-20250530/lib/iov_iter.c:1459) 
[ 66.671712][ T3569] sock_sendmsg_nosec (kbuild/obj/consumer/i386-randconfig-017-20250530/net/socket.c:715) 
[ 66.671949][ T3569] ____sys_sendmsg (kbuild/obj/consumer/i386-randconfig-017-20250530/net/socket.c:727 kbuild/obj/consumer/i386-randconfig-017-20250530/net/socket.c:2566) 
[ 66.672178][ T3569] ___sys_sendmsg (kbuild/obj/consumer/i386-randconfig-017-20250530/net/socket.c:2620) 
[ 66.672413][ T3569] ? unlock_hrtimer_base+0xa/0x10 
[ 66.672693][ T3569] ? __lock_release+0x49/0x105 
[ 66.672951][ T3569] ? unlock_hrtimer_base+0xa/0x10 
[ 66.673221][ T3569] ? mark_lock (kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:4732 (discriminator 3)) 
[ 66.673430][ T3569] ? __lock_acquire (kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:5235) 
[ 66.673664][ T3569] ? rcu_read_unlock (kbuild/obj/consumer/i386-randconfig-017-20250530/include/linux/rcupdate.h:329) 
[ 66.673897][ T3569] ? lock_acquire (kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:472 kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:5868 kbuild/obj/consumer/i386-randconfig-017-20250530/kernel/locking/lockdep.c:5823) 
[ 66.674119][ T3569] ? __fget_light (kbuild/obj/consumer/i386-randconfig-017-20250530/fs/file.c:1154) 
[ 66.674339][ T3569] __sys_sendmsg (kbuild/obj/consumer/i386-randconfig-017-20250530/net/socket.c:2652) 
[ 66.674556][ T3569] __ia32_sys_sendmsg (kbuild/obj/consumer/i386-randconfig-017-20250530/net/socket.c:2655) 
[ 66.674791][ T3569] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-017-20250530/./arch/x86/include/generated/asm/syscalls_32.h:371) 
[ 66.675017][ T3569] do_int80_syscall_32 (kbuild/obj/consumer/i386-randconfig-017-20250530/arch/x86/entry/syscall_32.c:83 kbuild/obj/consumer/i386-randconfig-017-20250530/arch/x86/entry/syscall_32.c:259) 
[ 66.675256][ T3569] entry_INT80_32 (kbuild/obj/consumer/i386-randconfig-017-20250530/arch/x86/entry/entry_32.S:945) 
[   66.675482][ T3569] EIP: 0xa7edd092
[ 66.675660][ T3569] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250604/202506041623.e45e4f7d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


