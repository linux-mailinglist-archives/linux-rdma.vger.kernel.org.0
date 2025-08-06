Return-Path: <linux-rdma+bounces-12598-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B657FB1C587
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 14:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3305218A6435
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 12:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C906E23314B;
	Wed,  6 Aug 2025 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="krLxwRkB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588DD1C5D44;
	Wed,  6 Aug 2025 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481775; cv=fail; b=r03VDtjBX/aZ+LBOGzNzjJCgu5fouG/n2Y2SRAmJ6QeYeEa1ZIpxlESLGF9GGDOP8sy6VOxALIQqONmLwJQ5/tJZCFWAo0POgFnsNj2Nlah6Y/Mme8LXkjij+vxcLxUuAFpPCDKNnmXzwvDot6szsFjf6yQyAunNXHn1rvRXh/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481775; c=relaxed/simple;
	bh=wGiDrzJLbWnuxsDXi2JDXUBEvF+2qAgPSbX6GpjEcr8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rMJys5AIaGbKxkI9bZr5FYbPwyoctKqgaj/3Gvnoa9E40lsoOdZ8V5/4W0CsNjpxHtalmJ7yrnL5Hc8Q9xZPGD8t8lnQ05KtkYrtfbwobyBFLJg+1Y0Ijl3fLVUMZTyn3vujKZIjO+Z7QI+cSCmktQ4e+3eQn+5q3DB0FCAXx+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=krLxwRkB; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754481773; x=1786017773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wGiDrzJLbWnuxsDXi2JDXUBEvF+2qAgPSbX6GpjEcr8=;
  b=krLxwRkBl/8qoFKFeCCz88VpfhTVS+SY8tSvqeOLv0g2cgxmH7H1i5hA
   NIwB1hy12uRHLaHqejkJu2yBVC3urmYzHMZqAoKS5xbDcdQmVZs7M3RA4
   Ti0yUxxvzRbi0F+zZg89lipUgygEXU/RcdxkpQ1QWu2MIXkEfEgQ33x2D
   QHTTAC8gof6TgGon3Wy2Q4R6j8uyKAXIbktavAhGzJhp7iCKksTQ4aCB/
   i0KEjxbGO/WcczW50UtwWYAJgPXWVzOBAHAC72C0IqQZh6Lod7L1Y4Vw+
   8iXMP/H0kItNyAyx9SPhki/NXBORgirEfhEV7+wa69rL9M6nEA7Wa8Msf
   w==;
X-CSE-ConnectionGUID: vf2ZUIEVQkeWbehhm3d5Ow==
X-CSE-MsgGUID: JiI8gvm3TO6wW9Ji6vCyiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56663062"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56663062"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 05:02:52 -0700
X-CSE-ConnectionGUID: vcnUJsR5TNSpSxpLNkm+qg==
X-CSE-MsgGUID: RbdeHWutRpu18rTrkIK3nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="195596117"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 05:02:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 05:02:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 05:02:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.84) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 05:02:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OP/uqNzxdiCoI6RjTULou7e4CyEy833cY9szzBuhr33RQ9BuZn1ftjQBK9GF9C5WR7+NlpTz1VWE2JrtzrZR31hfCOq6jXBr1Z96N6HU+lwvUtS+f1muXcMfnTN8B/OeD+ENp/tP09DwkVqICjZzWItahTjgYr+yd5kFBfDD8f5AktDOUqPGEKBesDHym5w+ZmlV/8K1GV8tQVX1E/ZTXSme8PMGoBJ5ufKGbA5ZjqIDOkn0ZK6EhLVNIF3n4KY1NIZ26BXLTCrMAlXh1kJFkP7s/Df2rTMiiS9DJK3iTuxdOoApq6SombyZ5ErJcN8pMneHa0HEzkIlGrsXq/XL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaJql0QvGmDfzkHDhZOhxtqwANRxqvRpv2xS3thACTI=;
 b=tns/WN0lBeOx5gdZSMQLyBrFtruGSXojxCabm14bZmqHbsQeTsbUM3gYNWQHTqsK1tBy+LHwKNs46OpFcanfAvuzJeITXvznSlF19IDpckwBsbC5106FgtpVM5zVdGARNNw56ef3TBQYdEBsq3kI83yqE8x7aluapx30iUIXGxEYOutW8HXnqTup3/ypcjQo2m/4W6B+vwZEa+3P06dJji6YBpxJoAZ5CtYMQuBdqv7R1mlqyn749UeFYuqeAcjlLxbViRPogBpchd4f4oj9elClt8wNftDa3CffaKUC4QjVlo03j5t/XhweEMytddo5S8mbSXY/qqbbs5Y2j7kFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA3PR11MB7464.namprd11.prod.outlook.com (2603:10b6:806:31b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 12:02:49 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 12:02:49 +0000
Date: Wed, 6 Aug 2025 14:02:38 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	<anthony.l.nguyen@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <jgg@nvidia.com>, <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <kuba@kernel.org>,
	Joshua Hay <joshua.a.hay@intel.com>
Subject: Re: [iwl-next v2 2/6] idpf: implement core RDMA auxiliary dev
 create, init, and destroy
Message-ID: <aJNEXjmbpTryJiBJ@soc-5CG4396X81.clients.intel.com>
References: <20250612220002.1120-1-tatyana.e.nikolova@intel.com>
 <20250612220002.1120-3-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612220002.1120-3-tatyana.e.nikolova@intel.com>
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA3PR11MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 7666c464-f861-4e57-4bdf-08ddd4e129db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?24rwjYhM1SjCEWnoR5ygAnINA7Y0Hqw6vnwgLxY6+6AK8BoxNIG3wMdq2/r3?=
 =?us-ascii?Q?nfNdMGS2cVSumaJZbgy77c78yyOC4LGoSK4rvOzMLf5g8mxz8em1TqcgzEXp?=
 =?us-ascii?Q?T0REl3UZMxn69S0wNHmXAukRdp2OmvblQrvQLwgN7YpIDy3Yhkk94ylxM6nJ?=
 =?us-ascii?Q?mqYotWII3GKkpNoUydTy2incCwFPyp/jkVcvMCTmeeJiy/CkANqW47UwUbzo?=
 =?us-ascii?Q?iyepKDNc/EUf1tvak7iOO1Oijz9IkIckZBM16jYvILl8YelKSuK+qOr8NZkP?=
 =?us-ascii?Q?MQN7zDz1jRwzo782woUqpLzRyT2Qncs6ZMR+qock95vniWVqM+C2/SRxJkDm?=
 =?us-ascii?Q?u5n6JP4WVqyCqHct3Dxl87H8ti7iHTjp5BiaW74sVHM3mZ/gd0FBO7JdoeDP?=
 =?us-ascii?Q?pV2iz84wFathRS4vH7TYfinuUoI9fuSMbcal3fsF/Pp9D+pmMcwM+hMf66Md?=
 =?us-ascii?Q?3ae1zK+ROvR9FKWK1f0zZvBwkDv1lONiQMtu4ZmWY3TDRIWhROpw6dIUP5D5?=
 =?us-ascii?Q?koPuulH53IusHTSidSD1CQifg7cpS0VZQ6UIHjq+F++pe1EsiOwrXZyMrpkY?=
 =?us-ascii?Q?kUvKZkwEL71ZUMGpSK0II9sF296a+4RkSUnF6TnPr4RlGnKDVSuMoxgAOpmj?=
 =?us-ascii?Q?lVYDtBKr3TzcUEp2GnQGW8OqvxtO+zZtNvs7gS1qfmMRQuqtfoS2ZUpsYSX2?=
 =?us-ascii?Q?sXDBp0TWcWCY2jdmplkLxeY5FDcP1nmKhaurlVUNtWhOFYeWPU+UPV+OZVDv?=
 =?us-ascii?Q?MC7UKmVXZWysjCZeEp8HY+aDpNtT3GO/pu/hxFfVq2HDcEV1J/i7j25AHhcH?=
 =?us-ascii?Q?s+n+bXy06g7UFMpYqlhQrspyBBJ25PTOLAfyybNQhMxmUHdngGt476k+akfU?=
 =?us-ascii?Q?xm+g4ek6s5HUylQ4mAumBNdqhrlnslXa8Ip34s5ALvZJqI8EAzfS07LmOegc?=
 =?us-ascii?Q?xlf4Ddz3GQo0KJsyunyFbVzMOo8T7K/LPLYFQeivX8ao5YxZXGkMipiZuJE7?=
 =?us-ascii?Q?3klNpAdG+yspoC1LKD3oo7gMn1UX67VgB6HG04u5p2+mmAuOQKLBWsq2K9/n?=
 =?us-ascii?Q?q7u/kLXqgOucCZExyQ4fKnnrW29NxJYlL9C2IfEdwDO56xwxO3TB6Bv+qECa?=
 =?us-ascii?Q?Uv6zLWrmfZ+TdcDTIk2+8WvDLqilbeRQJ/esGaUWncY0LYavA/YwKfgnJRMN?=
 =?us-ascii?Q?YhTMHFSp6kMG37YFZOfxDLnjv2311JRAPeAp3Gk7Gy9SAWTkNPc9w0VzH8Pa?=
 =?us-ascii?Q?SQPOHiTILmDH5sYeJC6tDfsNEXwhJjXJteTfN52hyjY5+lSAiYgv9UTTqiZ9?=
 =?us-ascii?Q?uV95dKzOp7HgnuPlUmqh8WofmTKuyXzRfuotwmeQtd8sJ/6x5j0h8jrmGW/F?=
 =?us-ascii?Q?m4RyLC5AySO8BA/S3EZr0hjLlIkLNa8LyVwyQdpeQ5UITo0k/Sb/H2n0v5pE?=
 =?us-ascii?Q?mMOZ7WxZ+qI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?81SlZkVUumWxZCq/YN3Day3HmMJB+9F39qejKQGP44hyNSSUIwwQpx6Hg2DF?=
 =?us-ascii?Q?UN04E77wu7m2PwIEv0ut8/ld+ywuaUdKV0S5kDdOI5jBm7s9GOZ5pJbn0lYU?=
 =?us-ascii?Q?OrK7LFNnqUaB0TlB0Q70Jw5cW2oKpnD4YjvtxNFoaxO7eWelFQY2/Avs6YxK?=
 =?us-ascii?Q?R3EbaSVJ6sWIsyfjVwtQCjMRseQbctmH6h3NITOgY8ePXREmuWwusqu3tV3+?=
 =?us-ascii?Q?cDQZlWU1D/QHPVam9Kzc4VAFXodj7dgoHn6gPxcBkE5oYNztSC/7QWBoFbEf?=
 =?us-ascii?Q?yBhozKUc0CtkamV1HFmk+9cNQGY8HkttwuGJ7aBaibeMtNAwECvOBM+oF64e?=
 =?us-ascii?Q?VgXNSSCnFVOI1OegmNOJBdf4MedGS4+e02eP+cCIe4yVGHJgGuEiK4LZy+xD?=
 =?us-ascii?Q?TvGeHPdf3PMHsmCNI0gABq10rxENYq6HwCtfOdfAH1bwuAD5SEd8sIguMV80?=
 =?us-ascii?Q?51RJp5Fx6cLPJijp6y1m46hYmkV8EWchpuHBY17dMJ2kasMT/Bro1AQD9A5p?=
 =?us-ascii?Q?pP08ZyNwhxd03bLtrPkydgxOooAw04muWpgraXFuopt7l1B2S4IL6ZlFQZPr?=
 =?us-ascii?Q?sQ0P0AfJA8k/AlnMGgQQHw7MOm4zqZKP2yHCMJgI5rptnjZgZTQxRCOK/cUb?=
 =?us-ascii?Q?SnDQJ4CCZOvRSJid4MXqzneBNV2V+JMX0dqLdulNY8B6ZszBlka2PYrVaHoD?=
 =?us-ascii?Q?rGH2egYSTYFWjDByYdPeZyhnLKoZeqC/ZA2p++Ld7ysYr5S6O+ynzdnE3au4?=
 =?us-ascii?Q?toUy9AO391qD5AmVk+lzKMyoGy9+iYn0AjUlpsceOhfmML8H5KclUnRNLtpA?=
 =?us-ascii?Q?GbfXgiekop7JZ/4iBhbsPHKIpcgxvt2MhMhpbd9pAJyPYQGFjEqkLJ93fin8?=
 =?us-ascii?Q?Oi00deYO7GrirEbFqrCBNO2HixzxHtlpQf9grKy5XaFxr4le9Owoo3TQTKhJ?=
 =?us-ascii?Q?lVYHrYcmnTsG93tB+On1MbphVh/Kh0KiwGt0HU7xCrl4OypXN4ZBsNkqRb4z?=
 =?us-ascii?Q?ZIzjTAiJ7q0xdWth59OsbZYVt1tPsY85iE/HNa6ZGpHUCfloJIuEQwdZNJae?=
 =?us-ascii?Q?HlU81wyfq0RUkuqFlvGoTzQ1BH+BSYyYlammKVCjf43p8yRYGQiAdnM1W/Ue?=
 =?us-ascii?Q?iqjT2n3iKZ+YbdnnKT/tT/gW97/zzdendmeXGwRrIB0f4cZN9T5dRHh6tcCY?=
 =?us-ascii?Q?zbHai64VOtxOV5g0nryN0W5mX13zb97r2XkiEv5rubcPUzZNXFFNYe7uoDqC?=
 =?us-ascii?Q?QLTnfZYJZ4Tb/NcGHyeREAX3IFNiMxcX9vPf6/1JsxUSCddIROK1dyIGHalG?=
 =?us-ascii?Q?wQoDmzMEQ/7z5IYT6uVtqJDh8Vaulev+Y+o/Kk/wuYvT7Mu81IPU30lHSIwP?=
 =?us-ascii?Q?GiSbsFA9Wdr4pItXtqo8tQHgXI/zcOxsskJL1VTyZR4XthmBfGWLTdOw4Dkf?=
 =?us-ascii?Q?7w7DdMcguBBT8YysF7+VxovRlHB4Z/CNx6E2PXioUXg06Gp3r1pnAPsnYhUL?=
 =?us-ascii?Q?FVE2bg+x1NfzQPh/Z4Dg6Or/qMZnly3S0NqGJ6vKTF7dnGiqxHplUKfODKy4?=
 =?us-ascii?Q?YejdkiW3ffBi3ogOP0w+D1v5E+X/y2r2N8TZB5Tx9XuU7MLRiA7vonXe6lbX?=
 =?us-ascii?Q?RZAqsv/OiPjb5yQScbK2T/sgGgxkzpF+xOVjuIvWL3vPq6ZqxYZ/joyhlMKr?=
 =?us-ascii?Q?DVgUFg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7666c464-f861-4e57-4bdf-08ddd4e129db
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 12:02:49.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+tdpQRXxVDiFcDUGRDNZ6u6ZOc0OyM0LfOCIBLPA0U6Np2NpM4gC16S7Np727uqf6yMgDwUziBmP/52CwOiiq8YMtMfsm8fGQ7X9ALzmik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7464
X-OriginatorOrg: intel.com

On Thu, Jun 12, 2025 at 04:59:58PM -0500, Tatyana Nikolova wrote:
> From: Joshua Hay <joshua.a.hay@intel.com>
> 
> Add the initial idpf_idc.c file with the functions to kick off the IDC
> initialization, create and initialize a core RDMA auxiliary device, and
> destroy said device.
> 
> The RDMA core has a dependency on the vports being created by the
> control plane before it can be initialized. Therefore, once all the
> vports are up after a hard reset (either during driver load a function
> level reset), the core RDMA device info will be created. It is populated
> with the function type (as distinguished by the IDC initialization
> function pointer), the core idc_ops function points (just stubs for
> now), the reserved RDMA MSIX table, and various other info the core RDMA
> auxiliary driver will need. It is then plugged on to the bus.
> 
> During a function level reset or driver unload, the device will be
> unplugged from the bus and destroyed.

Hello,

I am developing some changes using the current dev-queue and have noticed the 
following KASAN warning when doing rmmod idpf without any of my changes on top.

[  +6.231036] ==================================================================
[  +0.000065] BUG: KASAN: slab-use-after-free in idpf_idc_deinit_core_aux_device+0xf5/0x110 [idpf]
[  +0.000059] Read of size 4 at addr ff11001086758ae8 by task rmmod/2025

[  +0.000046] CPU: 40 UID: 0 PID: 2025 Comm: rmmod Not tainted 6.16.0-korg-netnext-standard+ #30 PREEMPT(full)
[  +0.000010] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C620.86B.01.01.0008.2305172341 05/17/2023
[  +0.000005] Call Trace:
[  +0.000003]  <TASK>
[  +0.000003]  dump_stack_lvl+0x5f/0x80
[  +0.000016]  print_report+0xd1/0x640
[  +0.000014]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  +0.000012]  ? kasan_complete_mode_report_info+0x64/0x200
[  +0.000009]  kasan_report+0xe5/0x120
[  +0.000007]  ? idpf_idc_deinit_core_aux_device+0xf5/0x110 [idpf]
[  +0.000017]  ? idpf_idc_deinit_core_aux_device+0xf5/0x110 [idpf]
[  +0.000016]  __asan_report_load4_noabort+0x18/0x20
[  +0.000010]  idpf_idc_deinit_core_aux_device+0xf5/0x110 [idpf]
[  +0.000014]  idpf_vc_core_deinit+0xbf/0x3a0 [idpf]
[  +0.000019]  idpf_remove+0xb0/0x7f0 [idpf]
[  +0.000017]  ? __kasan_check_write+0x18/0x20
[  +0.000009]  pci_device_remove+0xad/0x1d0
[  +0.000013]  device_remove+0xc4/0x170
[  +0.000012]  device_release_driver_internal+0x37e/0x540
[  +0.000011]  driver_detach+0xc7/0x1a0
[  +0.000008]  bus_remove_driver+0x127/0x2a0
[  +0.000008]  driver_unregister+0x71/0xa0
[  +0.000008]  pci_unregister_driver+0x2d/0x250
[  +0.000009]  idpf_driver_exit+0x14/0xe60 [idpf]
[  +0.000014]  __do_sys_delete_module.isra.0+0x2b7/0x500
[  +0.000012]  ? __pfx___do_sys_delete_module.isra.0+0x10/0x10
[  +0.000011]  __x64_sys_delete_module+0x35/0x50
[  +0.000008]  x64_sys_call+0x5c3/0x20d0
[  +0.000011]  do_syscall_64+0x7a/0x320
[  +0.000008]  ? clear_bhb_loop+0x60/0xb0
[  +0.000006]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000006] RIP: 0033:0x7f6c41b34abb
[  +0.000015] Code: 73 01 c3 48 8b 0d 55 13 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 25 13 0c 00 f7 d8 64 89 01 48
[  +0.000006] RSP: 002b:00007ffe4797b118 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  +0.000010] RAX: ffffffffffffffda RBX: 000055cbd564f700 RCX: 00007f6c41b34abb
[  +0.000005] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055cbd564f768
[  +0.000004] RBP: 00007ffe4797b140 R08: 1999999999999999 R09: 0000000000000000
[  +0.000005] R10: 00007f6c41ba5ac0 R11: 0000000000000206 R12: 0000000000000000
[  +0.000004] R13: 00007ffe4797b3a0 R14: 000055cbd564f700 R15: 0000000000000000
[  +0.000007]  </TASK>

[  +0.008179] Allocated by task 416:
[  +0.001205]  kasan_save_stack+0x3d/0x60
[  +0.000021]  kasan_save_track+0x18/0x40
[  +0.000011]  kasan_save_alloc_info+0x3b/0x50
[  +0.000013]  __kasan_kmalloc+0xb7/0xc0
[  +0.000010]  __kmalloc_cache_noprof+0x1ca/0x450
[  +0.000016]  idpf_idc_init_aux_core_dev+0x4f9/0xc80 [idpf]
[  +0.000027]  idpf_idc_register+0x14/0x20 [idpf]
[  +0.000025]  idpf_idc_init+0x5c/0xd0 [idpf]
[  +0.000025]  idpf_vc_event_task+0x658/0xdd0 [idpf]
[  +0.000026]  process_one_work+0x67b/0x1030
[  +0.000014]  worker_thread+0x65b/0xf40
[  +0.000009]  kthread+0x3a3/0x860
[  +0.000010]  ret_from_fork+0x24c/0x420
[  +0.000016]  ret_from_fork_asm+0x1a/0x30

[  +0.001183] Freed by task 2025:
[  +0.001070]  kasan_save_stack+0x3d/0x60
[  +0.000010]  kasan_save_track+0x18/0x40
[  +0.000007]  kasan_save_free_info+0x3f/0x60
[  +0.000008]  __kasan_slab_free+0x56/0x70
[  +0.000007]  kfree+0x12a/0x3d0
[  +0.000010]  idpf_core_adev_release+0x12/0x20 [idpf]
[  +0.000017]  device_release+0xa1/0x220
[  +0.000010]  kobject_put+0x18e/0x4f0
[  +0.000013]  put_device+0x17/0x30
[  +0.000006]  idpf_idc_deinit_core_aux_device+0x54/0x110 [idpf]
[  +0.000016]  idpf_vc_core_deinit+0xbf/0x3a0 [idpf]
[  +0.000018]  idpf_remove+0xb0/0x7f0 [idpf]
[  +0.000017]  pci_device_remove+0xad/0x1d0
[  +0.000011]  device_remove+0xc4/0x170
[  +0.000010]  device_release_driver_internal+0x37e/0x540
[  +0.000009]  driver_detach+0xc7/0x1a0
[  +0.000007]  bus_remove_driver+0x127/0x2a0
[  +0.000007]  driver_unregister+0x71/0xa0
[  +0.000008]  pci_unregister_driver+0x2d/0x250
[  +0.000008]  idpf_driver_exit+0x14/0xe60 [idpf]
[  +0.000017]  __do_sys_delete_module.isra.0+0x2b7/0x500
[  +0.000012]  __x64_sys_delete_module+0x35/0x50
[  +0.000008]  x64_sys_call+0x5c3/0x20d0
[  +0.000010]  do_syscall_64+0x7a/0x320
[  +0.000010]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  +0.000749] The buggy address belongs to the object at ff11001086758800
               which belongs to the cache kmalloc-1k of size 1024
[  +0.001509] The buggy address is located 744 bytes inside of
               freed 1024-byte region [ff11001086758800, ff11001086758c00)

[  +0.002163] The buggy address belongs to the physical page:
[  +0.000739] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1086758
[  +0.000010] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  +0.000006] flags: 0x6fffc0000000040(head|node=1|zone=2|lastcpupid=0x3fff)
[  +0.000009] page_type: f5(slab)
[  +0.000009] raw: 06fffc0000000040 ff11000100038dc0 dead000000000122 0000000000000000
[  +0.000007] raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
[  +0.000006] head: 06fffc0000000040 ff11000100038dc0 dead000000000122 0000000000000000
[  +0.000006] head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
[  +0.000006] head: 06fffc0000000003 ffd400004219d601 00000000ffffffff 00000000ffffffff
[  +0.000006] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[  +0.000004] page dumped because: kasan: bad access detected

[  +0.000732] Memory state around the buggy address:
[  +0.000744]  ff11001086758980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000764]  ff11001086758a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000750] >ff11001086758a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000735]                                                           ^
[  +0.000756]  ff11001086758b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000641]  ff11001086758b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000513] ==================================================================
[  +0.001104] Disabling lock debugging due to kernel taint

> 
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
> 
> v2:
> - initialize cdev_info earlier to properly free it in error path
> 
> Changes since split (v1):
> - replace core dev_ops with exported symbols
> - align with new header split scheme (idc_rdma->iidc_rdma and
>   iidc_rdma_idpf specific header)
> 
> [3]:
> - use signed ret value from ida_alloc and only assign
>   unsigned id if no err
> - capitalize some abbreviations
> - add missing field descriptions
> 
>  drivers/net/ethernet/intel/idpf/Makefile      |   1 +
>  drivers/net/ethernet/intel/idpf/idpf.h        |  11 +
>  drivers/net/ethernet/intel/idpf/idpf_dev.c    |  13 +
>  drivers/net/ethernet/intel/idpf/idpf_idc.c    | 223 ++++++++++++++++++
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   4 +
>  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  13 +
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  20 ++
>  .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   3 +
>  include/linux/net/intel/iidc_rdma_idpf.h      |  28 +++
>  9 files changed, 316 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/idpf/idpf_idc.c
>  create mode 100644 include/linux/net/intel/iidc_rdma_idpf.h
> 
> diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
> index 83ac5e296382..4ef4b2b5e37a 100644
> --- a/drivers/net/ethernet/intel/idpf/Makefile
> +++ b/drivers/net/ethernet/intel/idpf/Makefile
> @@ -10,6 +10,7 @@ idpf-y := \
>  	idpf_controlq_setup.o	\
>  	idpf_dev.o		\
>  	idpf_ethtool.o		\
> +	idpf_idc.o		\
>  	idpf_lib.o		\
>  	idpf_main.o		\
>  	idpf_txrx.o		\
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index d9f06764aba0..6b1cc55e34a3 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -17,6 +17,8 @@ struct idpf_vport_max_q;
>  #include <linux/sctp.h>
>  #include <linux/ethtool_netlink.h>
>  #include <net/gro.h>
> +#include <linux/net/intel/iidc_rdma.h>
> +#include <linux/net/intel/iidc_rdma_idpf.h>
>  
>  #include "virtchnl2.h"
>  #include "idpf_txrx.h"
> @@ -206,9 +208,12 @@ struct idpf_reg_ops {
>  /**
>   * struct idpf_dev_ops - Device specific operations
>   * @reg_ops: Register operations
> + * @idc_init: IDC initialization
>   */
>  struct idpf_dev_ops {
>  	struct idpf_reg_ops reg_ops;
> +
> +	int (*idc_init)(struct idpf_adapter *adapter);
>  };
>  
>  /**
> @@ -540,6 +545,7 @@ struct idpf_vc_xn_manager;
>   * @caps: Negotiated capabilities with device
>   * @vcxn_mngr: Virtchnl transaction manager
>   * @dev_ops: See idpf_dev_ops
> + * @cdev_info: IDC core device info pointer
>   * @num_vfs: Number of allocated VFs through sysfs. PF does not directly talk
>   *	     to VFs but is used to initialize them
>   * @crc_enable: Enable CRC insertion offload
> @@ -599,6 +605,7 @@ struct idpf_adapter {
>  	struct idpf_vc_xn_manager *vcxn_mngr;
>  
>  	struct idpf_dev_ops dev_ops;
> +	struct iidc_rdma_core_dev_info *cdev_info;
>  	int num_vfs;
>  	bool crc_enable;
>  	bool req_tx_splitq;
> @@ -877,5 +884,9 @@ int idpf_sriov_configure(struct pci_dev *pdev, int num_vfs);
>  
>  u8 idpf_vport_get_hsplit(const struct idpf_vport *vport);
>  bool idpf_vport_set_hsplit(const struct idpf_vport *vport, u8 val);
> +int idpf_idc_init(struct idpf_adapter *adapter);
> +int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
> +			       enum iidc_function_type ftype);
> +void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info);
>  
>  #endif /* !_IDPF_H_ */
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
> index 3fae81f1f988..dd227a4368fb 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
> @@ -161,6 +161,17 @@ static void idpf_ptp_reg_init(const struct idpf_adapter *adapter)
>  	adapter->ptp->cmd.exec_cmd_mask = PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
>  }
>  
> +/**
> + * idpf_idc_register - register for IDC callbacks
> + * @adapter: Driver specific private structure
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +static int idpf_idc_register(struct idpf_adapter *adapter)
> +{
> +	return idpf_idc_init_aux_core_dev(adapter, IIDC_FUNCTION_TYPE_PF);
> +}
> +
>  /**
>   * idpf_reg_ops_init - Initialize register API function pointers
>   * @adapter: Driver specific private structure
> @@ -182,4 +193,6 @@ static void idpf_reg_ops_init(struct idpf_adapter *adapter)
>  void idpf_dev_ops_init(struct idpf_adapter *adapter)
>  {
>  	idpf_reg_ops_init(adapter);
> +
> +	adapter->dev_ops.idc_init = idpf_idc_register;
>  }
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> new file mode 100644
> index 000000000000..5550802a3a7d
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#include "idpf.h"
> +#include "idpf_virtchnl.h"
> +
> +static DEFINE_IDA(idpf_idc_ida);
> +
> +#define IDPF_IDC_MAX_ADEV_NAME_LEN	15
> +
> +/**
> + * idpf_idc_init - Called to initialize IDC
> + * @adapter: driver private data structure
> + *
> + * Return: 0 on success or cap not enabled, error code on failure.
> + */
> +int idpf_idc_init(struct idpf_adapter *adapter)
> +{
> +	int err;
> +
> +	if (!idpf_is_rdma_cap_ena(adapter) ||
> +	    !adapter->dev_ops.idc_init)
> +		return 0;
> +
> +	err = adapter->dev_ops.idc_init(adapter);
> +	if (err)
> +		dev_err(&adapter->pdev->dev, "failed to initialize idc: %d\n",
> +			err);
> +
> +	return err;
> +}
> +
> +/**
> + * idpf_core_adev_release - function to be mapped to aux dev's release op
> + * @dev: pointer to device to free
> + */
> +static void idpf_core_adev_release(struct device *dev)
> +{
> +	struct iidc_rdma_core_auxiliary_dev *iadev;
> +
> +	iadev = container_of(dev, struct iidc_rdma_core_auxiliary_dev, adev.dev);
> +	kfree(iadev);
> +	iadev = NULL;
> +}
> +
> +/* idpf_plug_core_aux_dev - allocate and register an Auxiliary device
> + * @cdev_info: IDC core device info pointer
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
> +{
> +	struct iidc_rdma_core_auxiliary_dev *iadev;
> +	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
> +	if (!iadev)
> +		return -ENOMEM;
> +
> +	adev = &iadev->adev;
> +	cdev_info->adev = adev;
> +	iadev->cdev_info = cdev_info;
> +
> +	ret = ida_alloc(&idpf_idc_ida, GFP_KERNEL);
> +	if (ret < 0) {
> +		pr_err("failed to allocate unique device ID for Auxiliary driver\n");
> +		goto err_ida_alloc;
> +	}
> +	adev->id = ret;
> +	adev->dev.release = idpf_core_adev_release;
> +	adev->dev.parent = &cdev_info->pdev->dev;
> +	sprintf(name, "%04x.rdma.core", cdev_info->pdev->vendor);
> +	adev->name = name;
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret)
> +		goto err_aux_dev_init;
> +
> +	ret = auxiliary_device_add(adev);
> +	if (ret)
> +		goto err_aux_dev_add;
> +
> +	return 0;
> +
> +err_aux_dev_add:
> +	cdev_info->adev = NULL;
> +	auxiliary_device_uninit(adev);
> +err_aux_dev_init:
> +	ida_free(&idpf_idc_ida, adev->id);
> +err_ida_alloc:
> +	kfree(iadev);
> +
> +	return ret;
> +}
> +
> +/* idpf_unplug_aux_dev - unregister and free an Auxiliary device
> + * @adev: auxiliary device struct
> + */
> +static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
> +{
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +
> +	ida_free(&idpf_idc_ida, adev->id);
> +}
> +
> +/**
> + * idpf_idc_vport_dev_ctrl - Called by an Auxiliary Driver
> + * @cdev_info: IDC core device info pointer
> + * @up: RDMA core driver status
> + *
> + * This callback function is accessed by an Auxiliary Driver to indicate
> + * whether core driver is ready to support vport driver load or if vport
> + * drivers need to be taken down.
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +int idpf_idc_vport_dev_ctrl(struct iidc_rdma_core_dev_info *cdev_info, bool up)
> +{
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL_GPL(idpf_idc_vport_dev_ctrl);
> +
> +/**
> + * idpf_idc_request_reset - Called by an Auxiliary Driver
> + * @cdev_info: IDC core device info pointer
> + * @reset_type: function, core or other
> + *
> + * This callback function is accessed by an Auxiliary Driver to request a reset
> + * on the Auxiliary Device.
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +int idpf_idc_request_reset(struct iidc_rdma_core_dev_info *cdev_info,
> +			   enum iidc_rdma_reset_type __always_unused reset_type)
> +{
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL_GPL(idpf_idc_request_reset);
> +
> +/**
> + * idpf_idc_init_msix_data - initialize MSIX data for the cdev_info structure
> + * @adapter: driver private data structure
> + */
> +static void
> +idpf_idc_init_msix_data(struct idpf_adapter *adapter)
> +{
> +	struct iidc_rdma_core_dev_info *cdev_info;
> +	struct iidc_rdma_priv_dev_info *privd;
> +
> +	if (!adapter->rdma_msix_entries)
> +		return;
> +
> +	cdev_info = adapter->cdev_info;
> +	privd = cdev_info->iidc_priv;
> +
> +	privd->msix_entries = adapter->rdma_msix_entries;
> +	privd->msix_count = adapter->num_rdma_msix_entries;
> +}
> +
> +/**
> + * idpf_idc_init_aux_core_dev - initialize Auxiliary Device(s)
> + * @adapter: driver private data structure
> + * @ftype: PF or VF
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
> +			       enum iidc_function_type ftype)
> +{
> +	struct iidc_rdma_core_dev_info *cdev_info;
> +	struct iidc_rdma_priv_dev_info *privd;
> +	int err;
> +
> +	adapter->cdev_info = kzalloc(sizeof(*cdev_info), GFP_KERNEL);
> +	if (!adapter->cdev_info)
> +		return -ENOMEM;
> +	cdev_info = adapter->cdev_info;
> +
> +	privd = kzalloc(sizeof(*privd), GFP_KERNEL);
> +	if (!privd) {
> +		err = -ENOMEM;
> +		goto err_privd_alloc;
> +	}
> +
> +	cdev_info->iidc_priv = privd;
> +	cdev_info->pdev = adapter->pdev;
> +	cdev_info->rdma_protocol = IIDC_RDMA_PROTOCOL_ROCEV2;
> +	privd->ftype = ftype;
> +
> +	idpf_idc_init_msix_data(adapter);
> +
> +	err = idpf_plug_core_aux_dev(cdev_info);
> +	if (err)
> +		goto err_plug_aux_dev;
> +
> +	return 0;
> +
> +err_plug_aux_dev:
> +	kfree(privd);
> +err_privd_alloc:
> +	kfree(cdev_info);
> +	adapter->cdev_info = NULL;
> +
> +	return err;
> +}
> +
> +/**
> + * idpf_idc_deinit_core_aux_device - de-initialize Auxiliary Device(s)
> + * @cdev_info: IDC core device info pointer
> + */
> +void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info)
> +{
> +	if (!cdev_info)
> +		return;
> +
> +	idpf_unplug_aux_dev(cdev_info->adev);
> +
> +	kfree(cdev_info->iidc_priv);
> +	kfree(cdev_info);
> +}
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 71d1577ca9e4..2c9fda5783f8 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1834,6 +1834,10 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
>  unlock_mutex:
>  	mutex_unlock(&adapter->vport_ctrl_lock);
>  
> +	/* Wait until all vports are created to init RDMA CORE AUX */
> +	if (!err)
> +		err = idpf_idc_init(adapter);
> +
>  	return err;
>  }
>  
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> index aba828abcb17..2f84bd596ae4 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> @@ -147,6 +147,17 @@ static void idpf_vf_trigger_reset(struct idpf_adapter *adapter,
>  		idpf_send_mb_msg(adapter, VIRTCHNL2_OP_RESET_VF, 0, NULL, 0);
>  }
>  
> +/**
> + * idpf_idc_vf_register - register for IDC callbacks
> + * @adapter: Driver specific private structure
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +static int idpf_idc_vf_register(struct idpf_adapter *adapter)
> +{
> +	return idpf_idc_init_aux_core_dev(adapter, IIDC_FUNCTION_TYPE_VF);
> +}
> +
>  /**
>   * idpf_vf_reg_ops_init - Initialize register API function pointers
>   * @adapter: Driver specific private structure
> @@ -167,4 +178,6 @@ static void idpf_vf_reg_ops_init(struct idpf_adapter *adapter)
>  void idpf_vf_dev_ops_init(struct idpf_adapter *adapter)
>  {
>  	idpf_vf_reg_ops_init(adapter);
> +
> +	adapter->dev_ops.idc_init = idpf_idc_vf_register;
>  }
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 24febaaa8fbb..c6fa4644fd3c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -868,6 +868,7 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
>  
>  	caps.other_caps =
>  		cpu_to_le64(VIRTCHNL2_CAP_SRIOV			|
> +			    VIRTCHNL2_CAP_RDMA                  |
>  			    VIRTCHNL2_CAP_MACFILTER		|
>  			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
>  			    VIRTCHNL2_CAP_PROMISC		|
> @@ -3070,6 +3071,7 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
>  
>  	idpf_ptp_release(adapter);
>  	idpf_deinit_task(adapter);
> +	idpf_idc_deinit_core_aux_device(adapter->cdev_info);
>  	idpf_intr_rel(adapter);
>  
>  	if (remove_in_prog)
> @@ -3728,3 +3730,21 @@ int idpf_set_promiscuous(struct idpf_adapter *adapter,
>  
>  	return reply_sz < 0 ? reply_sz : 0;
>  }
> +
> +/**
> + * idpf_idc_rdma_vc_send_sync - virtchnl send callback for IDC registered drivers
> + * @cdev_info: IDC core device info pointer
> + * @send_msg: message to send
> + * @msg_size: size of message to send
> + * @recv_msg: message to populate on reception of response
> + * @recv_len: length of message copied into recv_msg or 0 on error
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info *cdev_info,
> +			       u8 *send_msg, u16 msg_size,
> +			       u8 *recv_msg, u16 *recv_len)
> +{
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL_GPL(idpf_idc_rdma_vc_send_sync);
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> index 77578206bada..7bae09483aed 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> @@ -151,5 +151,8 @@ int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
>  int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
>  int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
>  void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
> +int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info *cdev_info,
> +			       u8 *send_msg, u16 msg_size,
> +			       u8 *recv_msg, u16 *recv_len);
>  
>  #endif /* _IDPF_VIRTCHNL_H_ */
> diff --git a/include/linux/net/intel/iidc_rdma_idpf.h b/include/linux/net/intel/iidc_rdma_idpf.h
> new file mode 100644
> index 000000000000..f2fe1844f660
> --- /dev/null
> +++ b/include/linux/net/intel/iidc_rdma_idpf.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2025 Intel Corporation. */
> +
> +#ifndef _IIDC_RDMA_IDPF_H_
> +#define _IIDC_RDMA_IDPF_H_
> +
> +#include <linux/auxiliary_bus.h>
> +
> +/* struct to be populated by core LAN PCI driver */
> +enum iidc_function_type {
> +	IIDC_FUNCTION_TYPE_PF,
> +	IIDC_FUNCTION_TYPE_VF,
> +};
> +
> +struct iidc_rdma_priv_dev_info {
> +	struct msix_entry *msix_entries;
> +	u16 msix_count; /* How many vectors are reserved for this device */
> +	enum iidc_function_type ftype;
> +};
> +
> +int idpf_idc_vport_dev_ctrl(struct iidc_rdma_core_dev_info *cdev_info, bool up);
> +int idpf_idc_request_reset(struct iidc_rdma_core_dev_info *cdev_info,
> +			   enum iidc_rdma_reset_type __always_unused reset_type);
> +int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info *cdev_info,
> +			       u8 *send_msg, u16 msg_size,
> +			       u8 *recv_msg, u16 *recv_len);
> +
> +#endif /* _IIDC_RDMA_IDPF_H_ */
> -- 
> 2.31.1
> 
> 

