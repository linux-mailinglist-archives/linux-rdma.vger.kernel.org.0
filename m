Return-Path: <linux-rdma+bounces-9329-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB51A842F7
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 14:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3665F4A8B23
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 12:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B70284B42;
	Thu, 10 Apr 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoZtjUUj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B4E1E0B62;
	Thu, 10 Apr 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287703; cv=fail; b=lAJwHzVzHLihWKzOQGHQWkRCZuqT4q56oUAyIPpJjoIfgdeEWJzVb5HMDHRhK1I4eWkzfCrUxNto8fnEJ6VEDreb0jKKY2rnQMlpPvgB852Lttg5sEFJX/5skqYYx75wzVNwSGIO3x9g1NF9jdoEezzmZFA0e6VlrhMjaHpUVEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287703; c=relaxed/simple;
	bh=GNYf3+f7bDgKSF89d9SUwJEJ9SYBFTnI1JFRxKtS2xo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XpJ4y0S5Sm4ZXI2ab84ckNn8cqhlCjgMJQq08z6k7LOyy1LHJi8DNoAF0JmlU87dp/HmRma5mq1qeZ+PzPRNolgHREGC8Byk4O6aPUOxYlRRQuYwI1es+p3apBnf3BHul4RxwsEta/r3AnNT/gxIKYun/S3H0TLP/FT8vri0w/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QoZtjUUj; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744287702; x=1775823702;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GNYf3+f7bDgKSF89d9SUwJEJ9SYBFTnI1JFRxKtS2xo=;
  b=QoZtjUUjnVcw/hdqRFv25yfceNSsLAeOKrTYlhtcX3VHmCdf+WUoiGaE
   DtGK5dOrb66Tqousv7cJvl454FNAHjuUmAqFgAad879TbaZ4ii6GzySLI
   kg93fudYVQM122teFJi+EQ3YGgDcm3WkNI5EgxYN9/815FVjK+wRyxJ4H
   gqsLo77NdUu+BuNr6tvbRBDKVuUxiVJfEHm0YvZzwmlDnMD+CsVbdCwuq
   WQdoxgbAjofH8vvD8JLsxvhVvJ8SAP7ZpWCehfgWb0UF1hJknS+RQe7d+
   eU/74w8NEXz0EkJsoWSZ6tAFU/XcHN/bTo9GLAl5cWwWRhlbBDrOJtVyH
   Q==;
X-CSE-ConnectionGUID: cUxtyqnsS5STP7OEEq2pxA==
X-CSE-MsgGUID: WeShBVCCTFK2E+a7Iqg5mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49461907"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="49461907"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:21:40 -0700
X-CSE-ConnectionGUID: fiHV81EmS/2knu+VTtvGRg==
X-CSE-MsgGUID: QZwjPHWbQe6lJ3vCiuRqVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129422248"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:21:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 05:21:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 05:21:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 05:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4kmxA6OK52JrPGF5hkFrMsGinNtJG9VQWKPVJJ3Clxk3eBPZplDM8pUJjakCsTPM+s88+OT+HAFOtBmpvyDwfZFEvc96m8TliWABoM/fsPlcicrGs8DkaDtztW2X8X95iY8p/lszeVcYG+Y1PbRTc4I0uurlenxWe8jbTcrR1Hx0yutYXt3Gw3edEKeDosIjzJZxEtCCVLMoPMlIsO636lI1WK3ByWB70rw+WixhT1HgBmptjvlWXWlh0R2Y8VwjJp8TvoKOs4RFLAnmEuvfg3EsmoTKWRzAwEfC8ZbVDgGZ3EmOQDwKBL+GMf8TOw0/WTtyIwRDw3cdPQsV0P/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsJwE8Om0NUYPBfEQctF3dnYZVv2rxW0ewvWSRXfWAg=;
 b=d3NNta1Ej1j1k0Hs8vXXHTf+avK0bMyFQrvbmaSUSgvpbm+kTMYLz5QV1bfy0TbtdQGlm8X83XflM+ef9BNyozKMzXP8yBkBJRWqiILstHuObvkSAn0D6z150n8dgGnzf0SO+zp2zI7vmUgDbbcfX4X1Ji1ugvnM2Cn0Aj4WZD9QH7GbM+FSXUqKG8BhBpw6GvAZEBuJG5WgC6lqywtcwg/NQBfiQwJFnziZ1n+ivAY9xUx36spBivGP0fF9p9AZn1hypcepf924ShACHlglN/FZqY5To3mWPVEnkWEOYNdUHYppkiM6MefH9QHtD7Qoabp6ivNVphhk9eJjcZzRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DS7PR11MB7781.namprd11.prod.outlook.com (2603:10b6:8:e1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.32; Thu, 10 Apr 2025 12:21:34 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 12:21:34 +0000
Date: Thu, 10 Apr 2025 14:21:21 +0200
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
Subject: Re: [PATCH net-next 07/12] net/mlx5: HWS, Fix pool size optimization
Message-ID: <Z/e3wc7q3uGQvwVC@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-8-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744120856-341328-8-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: DU7P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::20) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DS7PR11MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c0a951-b8b0-4fc2-4ede-08dd782a3baf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XApncPTxkZLZVncY2xAoX3dcYtep/APYt5G9FEX2c7m+AD5xIvtuFRzK5DH7?=
 =?us-ascii?Q?vKpgDlOPgGj8T4Pi0rO6SeP+H00j2sZHyQFEfzVShtTlOBglJaWBTO5Qg58F?=
 =?us-ascii?Q?nBhqVU3CuAyg/IQ+M6DD1oV49MCr0vrbD8fiHWmVWws+bd/PNR/5LEppDSYL?=
 =?us-ascii?Q?+xU/AP09GG9eBuL+76v4CfpsmUSI/63l7I5UM6x0XoRacyCVQyZAj/ZppFe+?=
 =?us-ascii?Q?0cBtoE75NkxDgTW/Cdp1OIf/Tu7M+KjOHZyJ09RGiBEpdUfSfk7aBOsDjlY/?=
 =?us-ascii?Q?uYX+6lbURaNb3dgkGZhY2HsqgCebR57B7cvUiosBYA+2rV13MX0yUNGFcXqD?=
 =?us-ascii?Q?zMFvPVCbCmV5J54mjQi6AUFuauM/kQKmUkCEfoO1dFdyAs6iAuUmMnwTwbc8?=
 =?us-ascii?Q?G5ijlV918cxkyopTH6n5CqicsqS2avcnB76oEAGLO60WguHRRwLpN6s+6dNp?=
 =?us-ascii?Q?N2+0oNjoj1dqtr5BHitLm4gRIflqA8xxgvQpt3WOWS+5gsTbmhQVg90jgITx?=
 =?us-ascii?Q?MzZ3fhm/02BmxeSh4cC8bygXp7dBhkf501U1AcWjAsl7AOCZIAl1NzRnzM0I?=
 =?us-ascii?Q?IGuGAT2EKLqk88/vLxI8XJxd7Ilco3nAZibBTOz7yqT0lmqdOChCxeoB/PBx?=
 =?us-ascii?Q?xqhZSzNH/bVeCcr9uoC2PASDhTcjFoU+tAizvM1y1I4aApan/jSqCuWSUZZx?=
 =?us-ascii?Q?hcRlrwAMQ2ELmO/+KksYfuJjFG2lOHAc3F86E01wG8PEZ5PumLsv8JW0dK8c?=
 =?us-ascii?Q?6HQWkQ7GxClaStUhL4rmLy11fSKP906I/cNR0/+yzV1sDlIn+65Jgqo+KCw3?=
 =?us-ascii?Q?pUijXsQmtpSYkzv1NtgE7/jRRftPnpopPlyIy7Mv1BnMc6cKykoSp8qK5FjS?=
 =?us-ascii?Q?ehLL7tu4WTNzorvUCe8NxRZc4VIeJJyS8asEbfkWW0D7SJ3GvReuC5LQbaOG?=
 =?us-ascii?Q?eBjlA0MUu93sr6J0add26niCh5BYuhxS7T7XpfJHgeFqIxhPOgiTq1H1j1rZ?=
 =?us-ascii?Q?UuvYzeM1S7TzKG+XWwV5ZebOD1C/qgkEUlFf86xPoZm2ugKHo3F12A9kyZie?=
 =?us-ascii?Q?ieC8mDIhZdk/U7w7ivnKZbyTPkL7Bgo38LB5TUDSwgHKCcEFPoRN4gVY5Yju?=
 =?us-ascii?Q?ma5xk5pRiow0S3/yJIvQH3Sv797LIxbrBeRMAdgr71B9BrfWGATVwcIVqCWM?=
 =?us-ascii?Q?58+FcoZfHpOEXjWW6sFBwIWGqqKmUcOHQ6KwBaoAf90fEuYIR9r/vOCDpAdJ?=
 =?us-ascii?Q?V4q9gjZBBEGuG1sL82j3/YS4tNlhqY8l61RckG45zbkyP25jHskmeeg7yJRz?=
 =?us-ascii?Q?Pw2lkLTIkXeusZPP99fE3jaLNCJMWZsUurq5aqT1DpplVCu0HRIg5e1n1ca/?=
 =?us-ascii?Q?k6aZDRdmu0Nnje7h01RhObCAUs1z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/47TTJp/h1AZcB21NYcUBrOhxmwGMWBtCl8e+TEKraujDw3AClovaxrPaQ7?=
 =?us-ascii?Q?694M+T8ujJRJJp3Uq97DWX7Cp34TLEQaYdBx+l2TkfyNJp1J6YdMhodxI0wJ?=
 =?us-ascii?Q?vD3pX7/LBbHqXohnyEAzuwlFx8WvsfHqzHQStXsEnOu7EHcVEYNNTprvuqj4?=
 =?us-ascii?Q?TRbwK6TKu+5DvX+uZZ6I4VM41WGil0j/DDOUaQoIMbmbiRZWvhdnBC/eZNdG?=
 =?us-ascii?Q?Qmr7DGJEtDX2vmRDQxrVpohoig4m6g5Bc29zjsCJ7TCWZcbWZR6mNNAK2ccP?=
 =?us-ascii?Q?aCoBXWgI2h9SdwLJgleAhMdvCdGlmLbFuTpSPE9g+5Xba+OjuSFfMuZbXphJ?=
 =?us-ascii?Q?0oMENP4nbFk32eQhCNHYr+HpeZWV/V7uTj0FDEvCVl8wOcYTYgporgV93mqo?=
 =?us-ascii?Q?zax/wQBMrETxVqA37ZqXfbPfhN6OObRE2wsH6lb7y/Z/Wv2L1JvnBfDSn3Br?=
 =?us-ascii?Q?p4p3eLKX7s8CkSVwavLkAogLYkvyp59Bv1oSPbmTtGogmmnnsbLRnzLc+Ol+?=
 =?us-ascii?Q?w4LR0NMeN6oW5/80KFE/M54PsRm6uOrkDrdm07ddQa7D1VD+BOWq0X6YyzQR?=
 =?us-ascii?Q?gHFEpleVioHyNmY5sDem7WhnPJFquaDvYFJ5ldbTakCe/x9kFhs/m2kLIj2w?=
 =?us-ascii?Q?I5klNd0Hd4DBPoWtRe87qvVUdmgDvSh1BT21VwA5YvUW9bHK4OvMER1KUMmi?=
 =?us-ascii?Q?7GM4Ktmfl1/S4GQjSogGZU3jMYGZzaoksggaOeRdITZUOHeKQUzxjZq5zKrT?=
 =?us-ascii?Q?NuN5n4yuvZjdM60TjdYOkdj6Oiex338fQJNpWo5lFtGvYkIZ7zyNGSGHCiTc?=
 =?us-ascii?Q?gBk4xukV8E46GvYyT6Hovz3xjz3FDAB/O8QkyTjMTxaa7V39ip2t0xn/QPVY?=
 =?us-ascii?Q?MYLrSc6wmfSL6VorD54UJScD37dNIOBmL17gUpH21rznrOZpl+SWYGF+vfZb?=
 =?us-ascii?Q?jaOv5J5EcTjM4CnIavnteNzU4z5osGnna1mnqZsKkD30edVH+ACFqZys67H9?=
 =?us-ascii?Q?14OmkyZf2lXysDbBs3aollLlbhaD3R+Iubx2KxARPPLKj6emlbeZeJ/GQYVZ?=
 =?us-ascii?Q?rZ/7uc/6Q5KLSYKmd2ffg5uKBZcUoVfLFgVFYeRppL6y4TZM35eZU33H5c/I?=
 =?us-ascii?Q?VpEEYBMoG+F62mL6T1e1y8cg6dv/A+7rV+9bmUvqb2dxCuYfpUbKO2ss+Re4?=
 =?us-ascii?Q?bu6d5IZSJ0eb1Dti39jUUG1wGhcMm6R+WJOvDx7Zp1oHXsnxmbrxKka6msxE?=
 =?us-ascii?Q?z1SCJBAaF5NYCacPKU3qsiD7tECr3uB5yCMmFNiMFe62eJ2TGV3Tt7CqQ/Q/?=
 =?us-ascii?Q?Cz9TgsCl3tkAhlshrwv2RKDv0ezTe3AVTsTOZwlKEqNTEiDbWXCHj7XzENUq?=
 =?us-ascii?Q?ow6b7KbnsZBfDQDuJb5abklpkeuMtJ7TkP8ki9k9NiGkKmmOJSudD2MJ4iqq?=
 =?us-ascii?Q?EZS3UsVE7LTJPFD9scZiZ4rKmY+acyhhyngCjO0sO+A2kNw2ACpVOBBqQ4Rt?=
 =?us-ascii?Q?JVnJCAI5YXndISciF/eHbBEJvvF8j+jAMEZ+DtX4FPrS9Z/XxUta+sQGaysa?=
 =?us-ascii?Q?B51I+59olorqe1G4lT/Mi4UEmkto9sGXsGQmMSWBP2vSgau3FTM2ORzziwMF?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c0a951-b8b0-4fc2-4ede-08dd782a3baf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 12:21:34.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oio9vsSePin6dabdqkRoBp/6DAtjMmK6125CZcvNZbSag9c58I/DLSI9Zv6fImtkzt0udh9Z/3nkYYar3aLlfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7781
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 05:00:51PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> The optimization to create a size-one STE range for the unused direction
> was broken. The hardware prevents us from creating RTCs over unallocated
> STE space, so the only reason this has worked so far is because the
> optimization was never used.
> 

Is there any chance that the optimization can be used (enabled) by
someone on previous kernels? If so, maybe the patch is a better candidate
for the "net" tree?

Thanks,
Michal


> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
> index 26d85fe3c417..7e37d6e9eb83 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
> @@ -80,7 +80,7 @@ static int hws_pool_resource_alloc(struct mlx5hws_pool *pool)
>  	u32 fw_ft_type, opt_log_range;
>  
>  	fw_ft_type = mlx5hws_table_get_res_fw_ft_type(pool->tbl_type, false);
> -	opt_log_range = pool->opt_type == MLX5HWS_POOL_OPTIMIZE_ORIG ?
> +	opt_log_range = pool->opt_type == MLX5HWS_POOL_OPTIMIZE_MIRROR ?
>  				0 : pool->alloc_log_sz;
>  	resource = hws_pool_create_one_resource(pool, opt_log_range, fw_ft_type);
>  	if (!resource) {
> @@ -94,7 +94,7 @@ static int hws_pool_resource_alloc(struct mlx5hws_pool *pool)
>  		struct mlx5hws_pool_resource *mirror_resource;
>  
>  		fw_ft_type = mlx5hws_table_get_res_fw_ft_type(pool->tbl_type, true);
> -		opt_log_range = pool->opt_type == MLX5HWS_POOL_OPTIMIZE_MIRROR ?
> +		opt_log_range = pool->opt_type == MLX5HWS_POOL_OPTIMIZE_ORIG ?
>  					0 : pool->alloc_log_sz;
>  		mirror_resource = hws_pool_create_one_resource(pool, opt_log_range, fw_ft_type);
>  		if (!mirror_resource) {
> -- 
> 2.31.1
> 
> 

