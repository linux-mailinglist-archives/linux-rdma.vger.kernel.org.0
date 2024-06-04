Return-Path: <linux-rdma+bounces-2843-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0768FB6D4
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 17:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AC9B27941
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C7413D52C;
	Tue,  4 Jun 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSnkc0Md"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3B13C827;
	Tue,  4 Jun 2024 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514460; cv=fail; b=LrmxKJ6fD1dfGAF/6JIyap8VZxusw4TLfwdgNqFjwt82Ug/cToQWD/43W1EGUSCi5kN9yawnDHhLtqNoAi9TAzoAjLRgJvXcjAs8977w9mr7wxcO+d3whLVagg/n+ksuzwBi9mdDbgXSvkeBEyTgTmAZxpRMJLonlAQm6803oNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514460; c=relaxed/simple;
	bh=EGdVvHCpd8REGvNRx2QcyjmuJxKMI0w2DOsl/cy0ivw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UshzwPGLYsb+oSx57wMhVgjkqIdveIs17Px270sGwQBFK1ST2uMZL21/NAvpAfsNSN5mYa06kixztoswWwPt8w1v8mZdNgG+9yh4kdetpqx5NNa+8Sn2UnGgINB1dWFX3mu2rh0Q4FjV8csK7USzqCefGEEMJCfz4gGgXxENO/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSnkc0Md; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717514459; x=1749050459;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EGdVvHCpd8REGvNRx2QcyjmuJxKMI0w2DOsl/cy0ivw=;
  b=jSnkc0Md0JW6TyuXWCuuJ+OAbmULH7EHQNzdJcL1vNipDMwhqHhCp0HL
   x2aD9JEt6XCD9CN5Uc8wvnhlgrxpxkNQiynX7R61WjgSxMZbuGyBgbb1T
   xkqditA+zcoPXf5ofNj6oFc3suJoKrwJ6pTq7P9PPHK69Ta8R1yCN+wxk
   YFHzi0fFjxiRlm2DT1YDt/OfiMNWUVmLMk1wQN5nAR1DgtwxPckHY3QOI
   9rLUXsk7iO/iloOBJAusal5hzRjS7SJ5ZPRqYqJFWc8Du9e5f7tl5uOq8
   mYxajgGT+rxV9f3VuSQT4FpiPhTW5CsM0GTTNeHZ6Opj/h6Dfib0TsGNy
   g==;
X-CSE-ConnectionGUID: RjdJPmV/TuKNvcw3UaMyug==
X-CSE-MsgGUID: o+hEJTwoTYycRVgqQfSK9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17907868"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="17907868"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:20:58 -0700
X-CSE-ConnectionGUID: 72IRceEFQ/KveLma8Y2d2g==
X-CSE-MsgGUID: 2qf1SRLPR8OWBWwoF9d+Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="74766033"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 08:20:58 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 08:20:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 08:20:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 08:20:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fA+h/adOhRw97LD8Ey/AobegB+lorgtcl2plz+OqRPrBQUUil4adAutwl/N5RpjrvQ6K+nvr1dKw+ZVMfpBhUwgF7xH2hrCz2VU/tO2FprXfDRtGad7BNybjDtwjOKo13PlQKadmlCv97ni3c6ODNRHiCCj5NmsL5sR847K9SSBjup9LLuF7A6m/3PsQOCY84A1I6Q/SHzl8llS81df4v/Gefp5gpBpijfl7Cgpn1CYwwgaLeZbsRQhvEO8d+snGHigKNgrX4W6POAjaDbaBy7+a1nn3f4/m3AnSphwrrqlHUxJZ5JYJ5jwdHiCS21rtUU/yyS5pufhw9l2QbERUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcNICryQ2KBvt/IMeCvjE9aWxSwJqsGV+8yT7FpkgQc=;
 b=IiAo/Fn3Xp5I+V4KzmKeot124auNe9b5QGAvOu7ToTw+N+FpQ4es9u3sTZ/TlVqobwLuzXVz0TbTce/dcFqxu982gpduJdcj9tdP4VPnm0wvj2UeEGVG3Q3Ksy733hcYxQU+19QTe6/maBVJW97xgyn4iijBcY8Uf/v0c6tST2OLDxqd+absEOWoXzZldk3u0dIilkopMfVQHsMGhhU2RLYyPSC16er+v0lRFW8qMP+3LbMxL9dRYi4nJWleo7gIWkxTk1rXJeAoDlENY+xSt9EEGS8xM0G77TmR5fMz/4gL/3UH6SfDNQVp2K8CHse9sWJhkzlk6FAQA++yiHdwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4883.namprd11.prod.outlook.com (2603:10b6:303:9b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 15:20:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Tue, 4 Jun 2024
 15:20:55 +0000
Date: Tue, 4 Jun 2024 08:20:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Imre Deak <imre.deak@intel.com>, Leon Romanovsky <leon@kernel.org>
CC: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang
	<qiang.zhang1211@gmail.com>, Gal Pressman <gal@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, RDMA mailing list <linux-rdma@vger.kernel.org>, "Hillf
 Danton" <hdanton@sina.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <665f30d54276e_4a4e629427@dwillia2-xfh.jf.intel.com.notmuch>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <Zl8k/8/yQLnZcGd3@ideak-desk.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zl8k/8/yQLnZcGd3@ideak-desk.fi.intel.com>
X-ClientProxiedBy: MW4PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:303:dc::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: 528ae2fb-6fd1-4c16-b592-08dc84a9edf7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9lvnJ5AP9i0abP7G8ARNI0cKGZUfzPuj6oOCy2YInEmTJpMj6p45YIE87AMF?=
 =?us-ascii?Q?lMDh0OKE575nQfgY9ug4byxFbMOqDQ2eNJUPBwwlOSWTsL6/IsplkMs6bgOE?=
 =?us-ascii?Q?+XM4LUUg3YhP5DxgzflIKVt5PPqdIaoTso+3EEc1oVSTeLTK1U/YbfL5GJcF?=
 =?us-ascii?Q?hULWtzZrvIEnxgI0GGWNb3T9cwZIaqYIzep4aH2Z9yXX8NKzSweYix1JM7m3?=
 =?us-ascii?Q?3K3+BckcF5EXu/3gUOHuRz2HpUPx35L3lRdSCzyDowbxucwTvbocZUe3PgW2?=
 =?us-ascii?Q?gbQXqgm+5X5IkX7YP0vV1hxY2kE9ZCD5kTCL9tvhWUaKXSS1A9qGkLGNvifJ?=
 =?us-ascii?Q?fiqkqpLouP6M3XFWUvSW7gJQKmMWsZzLSsJ0D2B750UzoFfyAbFnY7wwHiq2?=
 =?us-ascii?Q?/5gzozVO74A7UJUhmCUKLU3Thdl6c05VzCozgSg30QoBfj4flIWntZG6VyqT?=
 =?us-ascii?Q?EEgZo9hmGHdOXyeIqUE+WV0EEBhuLlFaZYwuTg8GmpkTTN4JdWst3BpU9pjF?=
 =?us-ascii?Q?zfpLPmincu2pWgPdjkTaNHx3FD3QA5P5KRlv9Qm9bQ2XVahLOccQMZ4nREwv?=
 =?us-ascii?Q?cUYbz/rVSoedAv4/+li4WeRFlBkHIOnbbhLImNNlP+eYRpjNOJ8y5PkPdAM3?=
 =?us-ascii?Q?TxeFOrGKziyCC/Xs+H4AxEWrXc5RKihaJsyzGLm5D1/Y8QCuFdqRK43yXQpN?=
 =?us-ascii?Q?AKxAXpbbNb7AXOua2vwHrDWRQHgUlYk77ysySM9ptlIgEjExkyjYoHrephHP?=
 =?us-ascii?Q?C23QZ2ngkQjU1re16K1a19YPe1ypBkSJ6HmRPl2X2ASgBHSh+j9FWq4V2laj?=
 =?us-ascii?Q?pmcJ3mST9tPi3OBhPZ2IQJFWGhRF1k/VDiaWufN9F/1LO8ajl0TJDuWftlJW?=
 =?us-ascii?Q?lsfkUB0R8YwD5pyZKPl8lDS+rYdOvys2IeN5GE1n7xpmnnrW78Z8thEIVLWz?=
 =?us-ascii?Q?SqkrC+xzhyxPOxmC2sqLcfgwCs/WsIS3pJrwrdfQAE9q5r/Y5HvLEvLm/TcJ?=
 =?us-ascii?Q?1SArKwJCiBaJBuZBLYNi9REr3Xz865auOVsbtt7WjKrGzc+Qu2sambGZN0L1?=
 =?us-ascii?Q?Pq3W/Ko8SRQ05NV4WbPg6StLJxgon4SEfHbgIT9JLYVZPxM1GQAO/9X1PSgb?=
 =?us-ascii?Q?S1AdSfCqFdyi3Leb+kMT0/v8J/F435WyUSV7TELNL1x47A2PG64cbKHuLzeK?=
 =?us-ascii?Q?XS1uU4j0+Pwxqg/AEVGVi2i2kV5JjZTlvUXlVs1kzAyFILatThdYdAk8ErXC?=
 =?us-ascii?Q?p9oV3aPaSOA5KOvL/SxDcPhszFmTTOgNS2B7F5IlVQWSzukLgzD5Ro6djCk/?=
 =?us-ascii?Q?2KjqbttUeJ36Zx0nnZtjgt+x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+iddlY/ztqR1BVGiY5909X75JwUhmn8d+e/cnMOz3QoBotIGdhhf5abPAuy+?=
 =?us-ascii?Q?/zFoa1SeQgZtwNvuEQynldlFuXvnWKLSdqj8ivUxOUvWGGpep8dtDaLw8CYZ?=
 =?us-ascii?Q?X08b9C1OwOgDKuuJbFm+28sT6Yd0NDSEEm4VOVzw0TYzW8bCxGWgxQB1hOdB?=
 =?us-ascii?Q?VrjXCPrVfpsrY0CTNeFiW6ZQWM2um2lnlwVMT1eNsHYY6iTUvTGVucr1boNj?=
 =?us-ascii?Q?HjVOQyH98DHiJxfryH9euxfLRGg4YDqHvlbf0BxDHfBIcQKaCGg/dS0msRTt?=
 =?us-ascii?Q?Nx7qA5+ge3maAfj/alHO9B9ac3NDjT0yDU0Jr220YDMVyQamCH2wMgoGNozJ?=
 =?us-ascii?Q?8hDbbeU85iEy0tWpwHWjmFSDho4YkqA0DDPugD433+yCNQD/MQ2o+LKBIQJE?=
 =?us-ascii?Q?8Yotx2oADnQFI/NfrOmPWTdcTaX+coRoDDSfKywFwsPXoNRnepAJk8o0rubS?=
 =?us-ascii?Q?8AIjGFpIszwiMVCOR5iKvv7Y4u2fChZ7TrS39J73Wt6WEdr10cZCc9Dw+RDl?=
 =?us-ascii?Q?MsgAXx2h73YF8sFzrgpB9fNcINAGQmA7uEXLZ3jG4cJmgGe+cyDaWBtcNGvb?=
 =?us-ascii?Q?ynGMpVEicyoT5nYUaT463fuLczIYt8I3G31MyKds96FhuRxh8Sn9nOt/dlSy?=
 =?us-ascii?Q?5kTeuuoNOpkbux/UA08h8iNllkmVgoU6fLf23AHASdmVJhHVqxFg8waZsJmK?=
 =?us-ascii?Q?eWaFvMgR/TRdaCa1FKqUG4Pi4dE6k6KsHqlqM1Sq8ipR8uqa31SDRfRjNyL+?=
 =?us-ascii?Q?LdLdgP9ErGuWTxTfQqolHEdexE8iiQ0ISTrOXvAl/GHKcCMjfqyBZJkWsyEu?=
 =?us-ascii?Q?CAHSA3PkJi48oiJUntDJRz9pPh7fd3GuokO0KVX27f7cpUqj5o8iHAmBjj75?=
 =?us-ascii?Q?4uKpTv7lFSUF90VzhE0zMJNbo0xFDldNSsXcEaadP3/DXezWsHk4cERXGP4k?=
 =?us-ascii?Q?lMoutGe+dhPfM8Eu60ah37XSBfiC96v5rIISUO08jlaicSLsFBeF3q5v7BoR?=
 =?us-ascii?Q?2qbBDJK66C6DRO0LvpGnPl2rA7Z2QahLsWh5YdL34/xpWa33zyGOYBhIjbQn?=
 =?us-ascii?Q?BYdr/g+omUR7Yzqwh2MmQ0F9ldTeIe0aqvNNvucuv+ExzHUsPC1+lsc2GT3m?=
 =?us-ascii?Q?n0Tq0nGcf3NtmOLkmwcuRJq+gbdloy9ewtgEga4RnuJ7jxaHL4tXlQTYyXFx?=
 =?us-ascii?Q?6p5x0a5qaqfw7QLUQS4a8LMt8+WvLwqO8CMf05aRwv14uDZ6LYuIc1j86M4W?=
 =?us-ascii?Q?8hVK+nEyd5RM0nck3n3kJ0KWhpf500wLCO1eeOnC2y9aoTekREpifeu/IT+D?=
 =?us-ascii?Q?Tovr02rWcckCw8q/zDON3eHOlWTIpWBEnLlR/xWu5y9Dl3q4ZaoAviWu8oGG?=
 =?us-ascii?Q?N6fAh3bp3uj1pj+g6mLD0w9j2g+vgDtuA8AspozMNjYb8ZrrwJ1L6YtfUfEr?=
 =?us-ascii?Q?YCuD6CO0PAYbWWNBnz0iO+82tAaSdwEdRaftzQpf09XSdL705LMzxn2WmueR?=
 =?us-ascii?Q?I0In36G/q68nTvBFKVuRvtYOAWCbKJpTThAAbfCGJCQlnwrZ64giY9JlQQ/V?=
 =?us-ascii?Q?+cIP+SCkqxYQlumBB0NP230mpPR4a3CWdGDLGDcwfPuHs+tgoVD+QaMFW2/i?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 528ae2fb-6fd1-4c16-b592-08dc84a9edf7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 15:20:55.7662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhgUA60r1zCmT6zo7RxxWQQYG8loPgHcfevoD+M0J9HuzNXxazTY7soORpjDVc6a4wqkFG3kRGSz6cpnDU4ObcT00+4Te/488gZzVRM3KKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4883
X-OriginatorOrg: intel.com

Imre Deak wrote:
> Hi,
> 
> [Sorry for the previous message, resending it now
>  with proper In-reply-to: header added.]
> 
> I see a similar issue, a corruption in the lock_keys_hash while
> alloc_workqueue()->lockdep_register_key() iterates it, see [1] for the
> stacktrace.
> 
> Not sure if related or even will solve [1], but [2] will revert
> 
> commit 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> 
> which does
> 
> lockdep_register_key(&dev->cfg_access_key);
> 
> in pci_device_add() and doesn't unregister the key when the pci device is
> removed (and potentially freed); so basically 7e89efc6e9e4 was missing a
> 
> lockdep_unregister_key();
> 
> in pci_destroy_dev().
> 
> Based on the above I wonder if 7e89efc6e9e4 could also lead to the
> corruption of lock_keys_hash after a pci device is removed.o

Are you running with the revert applied and still seeing issues?

