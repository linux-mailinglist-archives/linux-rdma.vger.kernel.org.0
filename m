Return-Path: <linux-rdma+bounces-9296-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BD4A82A2F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 17:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FEF189AA73
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B356A266F05;
	Wed,  9 Apr 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goPfuNZ+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607C69D2B;
	Wed,  9 Apr 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212092; cv=fail; b=cnd4YBbRzo4YkwlZMiYZHz3+G3cUAl6Kjpp4jvNjdXUBq6zaqYFVMrh9jh/l/6vpBM0PMRNaIrGxGZ5YEYiOTBc6+LGqu2oR00/R1TlEPtPN7GvoJObmfeurPRsD86ZwshdPPE+OmP8E3RNUzNY8xjuEzPlWPZT11CFAQVAcUMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212092; c=relaxed/simple;
	bh=yk6xPr0blV5rRC2jaflogeLiKYtwlkZslHsiqKpcEWY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tzb68jebjEUzcpqocowLg/E0Qc0FI4ikIItuw1LQjyxY9OPiFeTe6MmEZ6b/YDtVvDQsTCSeq3eyru77/9bzI4j1DiAEdT2d+O0aNUKyxJsAhzTYgw/8UbsSoSUpafmohWLenPRzvQhhnlE+Ol0b8wb7djqdZVgblnNowt6PQpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goPfuNZ+; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744212090; x=1775748090;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yk6xPr0blV5rRC2jaflogeLiKYtwlkZslHsiqKpcEWY=;
  b=goPfuNZ+EBwJVrWTNLYnShKTPiaY5bw+AIKpenQQTvZG2SgKfm1kXz+T
   CZa2arFEzcNbzus3Nq8a+cYEIijV7xB+TAmqeOSnVkTrSbm+yvBwhkjar
   gcdYrfNjj9MpIa/akzns0k/JeIFs5LF/HE3nme23ggmy+Qrc8VsIT90Fj
   i387HfHL/C1AykLIUOOuVug48Wuf2MqSDsVVicKXkGhX8Vaf8g8wQIQgU
   jbzhQMINkyw2B2iokhzfQJ19hI96k4nU20v1wamBWc73qwGRwq7AtL9sW
   KcijGAPKPBjvUoZ64xa9RNxVNX3PgJao0UeYpeQy9JwGODwHwPvECyAtF
   w==;
X-CSE-ConnectionGUID: 6CGngITKT3i3VFjriNU7ww==
X-CSE-MsgGUID: rl0hGQrQQ52H5DJzi8rgbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="57068694"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="57068694"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:21:29 -0700
X-CSE-ConnectionGUID: cVyuf7mpSZOolVJTyVrhuw==
X-CSE-MsgGUID: 6Ks4dVeCRq27d0ja/dxwbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133831349"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:21:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 08:21:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 08:21:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 08:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jC/R0S/yaJ/tK/MPWMNy4PG124hK+vVDuTfKat5y1vH4VZMGBZ3BPOm56D1DXF2jioIvwuO3lYaGlmyDl/hCzH9crkxOKS01oJ+87r9leaoeu4FXsB1Hc3hemQMOgdWP+MGDO3Lud/i0wxsXt49f0I0z9KOuJg6O1pibGEIwadao15D79A1Unel+s5Gneu3GOjW5Vrt+yGUnNmxzwT9QbBjEqHGOcrL/L1s0tfe0ms+SgMk9FQ/ezgBrZy78j3iesiRhzP1hOP3dw82ybx6Oh/CXtTYyCC6qV/RagfnvISEBP9H9I+4vkayaVChAAJYQmFeh1gqDe7yxdolu6JaSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBtS+spGBDEsnI00/P1Kwg3dNxdO9ZMW4MzjfE4CWWE=;
 b=HeX8rrToHh/uSgXtYMb+bFNvn9LqulTIU15eeGsIIHMW54vSUFlxfBUI0KdLSCD8wGOOPKZ6+DW7dy0lv5Dgi5d+iol4HWjNsbA3bH0tqvjtnxKvItUhg6CyjWmsOoYiVjwFbzvzi0/DIS9AgueGfoXyakApFJI0zh/yGCi4aLM147C/pRfpppwhx9qqDlyuGDCM3UuhimuaCkNk0OZ9wiMjIko4ovXg0BicLBNBIStx7oMcjT2xqZpm+wEv/A2rEbZfUoUdwxrHzJuXOEJP5z5JENEZU9JepDCpLAV38sym+Fg+1CzuckcZPqMToqBwLgi5YDbwCf8ydgv0WmqXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 15:21:24 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 15:21:23 +0000
Date: Wed, 9 Apr 2025 17:21:11 +0200
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
Subject: Re: [PATCH net-next 01/12] net/mlx5: HWS, Fix matcher action
 template attach
Message-ID: <Z/aQZzRYWkSLV1r/@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744120856-341328-2-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SJ0PR11MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: fead1f06-f708-4a60-759e-08dd777a300e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xlxISPKlEZFNlzlhFp+6cJuRkpSE2nS0sVHgR/e1wAHzqUmJhkpbFUyvNFxm?=
 =?us-ascii?Q?6TY9Xrkb0nLTvQTSkPJFxpkqRjBNU+8TVGTSUDso+3lK9FFJKaF/3HHeYQ38?=
 =?us-ascii?Q?RSRVn47DmbdQoOiEmffezy+ih17Kr4UgOG/VffsIctQIFxWhe3mELwuPQfIP?=
 =?us-ascii?Q?e0mBwaAIhXNEy2zztf5zQaLlPf5iq4P9WucJH4CXpUnoaTl6cfwKxwXeLV35?=
 =?us-ascii?Q?7ZZVZq6a8TDnRSKaIoBSckrAAvqGAI83d0HvtZM0ImP8NNTv3jObGvefb7GJ?=
 =?us-ascii?Q?rb8UgfE1zcxm1wPRLvocd9Va/nLDD+9gyRmmnbRcEcULQFMUrgMXyAgpEjdF?=
 =?us-ascii?Q?nQTcxDCrT64e5miXNVSZRSgZ0XXC0NFKUKxHctcLq67y2eXiBGgvU0resmhK?=
 =?us-ascii?Q?4pn9SaXxWQhDZD6PfXkhxZi2xmqMDbrnS6UvJW/9vPVC39lr3JvMVWOxOzg0?=
 =?us-ascii?Q?RKrz8vHQqed0Nl3KdlFM7UbB51AFTh8EaYLWLBCYw9oev7FaFnpoPe3+GmcX?=
 =?us-ascii?Q?gvpJQqfyR2OUWUnA9HiPdjo/CHBMKLNNQO2GUtoSqNKBDcF/kQYQCVwzl9zz?=
 =?us-ascii?Q?nr8Zu21OHsraikj66hrRVmWGLJz9w/IMB2YiRyqrJa6+7VImzHB48Ce4nV7H?=
 =?us-ascii?Q?ZJ+mt+CyyIU86uQyIwYOFwb8qIYNUVzTD3ROjaD+HkhrAYFvF4srxzPhb0TF?=
 =?us-ascii?Q?x7F660SNLzh3iP/WerUvoX71zHUi4UhPXDSqs3jpwBkxEJpMOM4DLBUXzq7A?=
 =?us-ascii?Q?gvWP5zSdzNJ/ACcqTccS0CEOAodZCCdeuJpr0WpwYOqI2JAN4LAdX5zM2l62?=
 =?us-ascii?Q?4StA4qcMf6odWY+Ay/9uIRDZH4QvvQQOCz/qEXS4Vb1tO+MPWSF8DGLEq/Wy?=
 =?us-ascii?Q?koblhz83Hd1NMK7b6k8yObVKKtSEPvA/WE/ru8nkSNWaSKHZIRKQOZtBQo1B?=
 =?us-ascii?Q?U1H93pC67TlzOz26NbDNXdq+4el7U5fBHkjRNabY3CmDWFP3TuaRgbBsIjB7?=
 =?us-ascii?Q?nkqHAVOJCWpWvgqd78SFKU+e6MrtQr1LXxZ2p/UIJnk3an3MP4KD1WBqtuGV?=
 =?us-ascii?Q?hdzjtbtQYDe3qjoIMU6+ya4AwPZeJ6/Tobj2BLfitElLBwmmavpBeYUhnhHi?=
 =?us-ascii?Q?wziyuBzlgqZIrnXpVyUImpkBX6YuwSGdCHpqOGJlYKFXXBLrfVpJoGrQRJV8?=
 =?us-ascii?Q?NzFLFjTRTy61W1ASbpnMyOzZIL7jVff2VObgiuSMcAr3nTGCW9PTowIy+1Du?=
 =?us-ascii?Q?t+kq5CRID9R68LDSBH9JW+n7f5Ln/HzqWGuAg1An3Zb9up4iLkAwFb/bI6uq?=
 =?us-ascii?Q?xSHleAWoj+2Ed/vdsDZ+snkdSlSFcygViznVzQZXHiIiZu4RzbrC+HCIei2t?=
 =?us-ascii?Q?lmkWAljfVfg3OMhmVv6TARadwqlW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8JK7Ft+hJ0a+jRbZ+/8Et8fm0RmXcCD/rlFTqPsYq225Gz9kxI6s3IahUnqG?=
 =?us-ascii?Q?ZnJpPZm3s93+Xc3Zxk4FWdnZL2BX+rHUrdOXOhawtXAVTY8gbxlbWyYDgPzi?=
 =?us-ascii?Q?cxxZOVMR5NdFEoHzzl8R1QtaNDbSi2lS0l8BpeotO9xxu1DXA1b7KWrAjNhD?=
 =?us-ascii?Q?8SE2tAynOX9Rag+EvBqf4GyxhKANpvlXgH1J8cR/KremqFpsX5ZXLmeDYQKz?=
 =?us-ascii?Q?bXJXsV/S/niLHOkjqZIlCJ8kA240Bgfl0hZOu4dDv/ity6ic7l0VhXo/J/aX?=
 =?us-ascii?Q?peLyIig4fGx3gMJOzsq2MHyUyoPOkiaG+ZDP9U1oU4X06XjvKTe/cV1icO07?=
 =?us-ascii?Q?RH3BA0Alc0rSD4OeQghdK0apmh23P8dyiZrk6ZkdDl0JDWS8bkuCJrZmWaG4?=
 =?us-ascii?Q?E4W49YGWJm4/Q+h/NhhfwsWrURn3n9AIqwvlnzhKDWXHoHfvj2zfYIhDeW4f?=
 =?us-ascii?Q?XxN1i+HpsjQ7WZft7IgqHZkE68x+N8PTpL/8Ktr5KzkJbFSkt/hNlAUzJE/c?=
 =?us-ascii?Q?Z9Ff/PcTCsENXVu0hCb2uNlnjjMOD8td6rjfmEpEaEwJN4fi3JTgQpIVlNCr?=
 =?us-ascii?Q?N+q84iPM76sHejJE5DU2FyTgxMsnDIwn5vZ1ZGWsB78Oo3bqVd9S2sJ9Ufpc?=
 =?us-ascii?Q?Ze/2CMpIJBW3Yb+IHtvZTWoPdwZep5idTc8rGPQmENeuKN5zOgU/XC/pangZ?=
 =?us-ascii?Q?dE1e4atzE+r06ToBlPvzDL0HZNC2jBrQofgWhnErM4ZW0upNjS09/7yt5JqN?=
 =?us-ascii?Q?qMBaC4iTgwpY64QaFcPh1eadL8a9k1s4g889bMfULk5nArpzP7WwIyIZKqGi?=
 =?us-ascii?Q?1uwA4ownrRv36JgrGUYw9Q30TFlUrAd2rQfmZ+ICgGk2Cb7MAt0YNN15YRYz?=
 =?us-ascii?Q?KkJtZGzCaknfWuGTsf/iqHp0PkOoRcpbbpYUPhsj/4P1ahGTLtFpfJv6SK+W?=
 =?us-ascii?Q?pxLPXUXgYQdyqisSaBVOfbsMwGUcPny2vbzu/ojo7ucZJkLspGswf5SgZd45?=
 =?us-ascii?Q?KYa4kl38ZzY0XymqztpFyTFAVAsAbTsmbw39a08ve7sGkZUzuolyqi0gH7T/?=
 =?us-ascii?Q?0K+mKfcuBPjJScIUFGlfzTqQhgTyRJcryDEEAoYSEptEzltaBk1XbfMCuDYb?=
 =?us-ascii?Q?4QIP6ZY+xcsXYMZX1tgQsPoE1HGupLsGSJJG2S1TaNps5mfi1Dx2NR9GCbBa?=
 =?us-ascii?Q?1VOgPmXeo4ekUxpUleDLzTOn3q31f8Xzf/7F8MWHUHMNhcpeSpv0iL6tPdMy?=
 =?us-ascii?Q?vjKziYZtg4O2SvmxZ+cgvOYIzX2lXyMy5vscM5muD6ncSAI1CA8CjazTI2WY?=
 =?us-ascii?Q?9vqbbpE6PMJFLC1b+8tIBN5lI4+solbQEZDPGD+DvHXUHQHrTCxx55r3fqca?=
 =?us-ascii?Q?qbMDtbn5Fu8B5rkQcl5id8MAAx2u//dGKUvsgIlEffar2s3x3Lf0LHJne9i2?=
 =?us-ascii?Q?TnA3qFnqIqCogXB11zNyX+ozfaLTFyioaEvQ/4uzuobnpvTaIDmN4Ao3eig2?=
 =?us-ascii?Q?fKHZEjsC3wYQZrEjQzCJoqZeoOxgDxf6OxYwRDL9AoT4NdIkklMrzjF5hNLx?=
 =?us-ascii?Q?B+bm3JQawdIKAAAKqdizRzSatjh37BPxvcQNPvW2IrfXJztjG2sBUQRISP2k?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fead1f06-f708-4a60-759e-08dd777a300e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:21:23.4044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDnDsb0BKNuUMvPYC9LGNPlKBT7l0xGCEvYwEgjlaCebJqXSBaohT1KUI0ePWMh/Cwyx0ieqUp+gyYCeedl2oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 05:00:45PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> The procedure of attaching an action template to an existing matcher had
> a few issues:
> 
> 1. Attaching accidentally overran the `at` array in bwc_matcher, which
>    would result in memory corruption. This bug wasn't triggered, but it
>    is possible to trigger it by attaching action templates beyond the
>    initial buffer size of 8. Fix this by converting to a dynamically
>    sized buffer and reallocating if needed.
> 
> 2. Similarly, the `at` array inside the native matcher was never
>    reallocated. Fix this the same as above.
> 
> 3. The bwc layer treated any error in action template attach as a signal
>    that the matcher should be rehashed to account for a larger number of
>    action STEs. In reality, there are other unrelated errors that can
>    arise and they should be propagated upstack. Fix this by adding a
>    `need_rehash` output parameter that's orthogonal to error codes.
> 
> Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

In general the patch looks OK to me.
Just one request for clarification inline.

Thanks,
Michal

> ---
>  .../mellanox/mlx5/core/steering/hws/bwc.c     | 55 ++++++++++++++++---
>  .../mellanox/mlx5/core/steering/hws/bwc.h     |  9 ++-
>  .../mellanox/mlx5/core/steering/hws/matcher.c | 48 +++++++++++++---
>  .../mellanox/mlx5/core/steering/hws/matcher.h |  4 ++
>  .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  5 +-
>  5 files changed, 97 insertions(+), 24 deletions(-)
> 

[...]

> @@ -520,6 +529,23 @@ hws_bwc_matcher_extend_at(struct mlx5hws_bwc_matcher *bwc_matcher,
>  			  struct mlx5hws_rule_action rule_actions[])
>  {
>  	enum mlx5hws_action_type action_types[MLX5HWS_BWC_MAX_ACTS];
> +	void *p;
> +
> +	if (unlikely(bwc_matcher->num_of_at >= bwc_matcher->size_of_at_array)) {
> +		if (bwc_matcher->size_of_at_array >= MLX5HWS_MATCHER_MAX_AT)
> +			return -ENOMEM;
> +		bwc_matcher->size_of_at_array *= 2;

Is it possible that `num_of_at` is even greater than twice `size_of_array`?
If so, shouldn't you calculate how many multiplications by 2 you need to
do?

> +		p = krealloc(bwc_matcher->at,
> +			     bwc_matcher->size_of_at_array *
> +				     sizeof(*bwc_matcher->at),
> +			     __GFP_ZERO | GFP_KERNEL);
> +		if (!p) {
> +			bwc_matcher->size_of_at_array /= 2;
> +			return -ENOMEM;
> +		}
> +
> +		bwc_matcher->at = p;
> +	}
>  
>  	hws_bwc_rule_actions_to_action_types(rule_actions, action_types);
>  

