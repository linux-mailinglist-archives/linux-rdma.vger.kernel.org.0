Return-Path: <linux-rdma+bounces-14592-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A3FC67F05
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 08:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B10A82916B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 07:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79FD2690D1;
	Tue, 18 Nov 2025 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpmnZnLx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C113DBA0;
	Tue, 18 Nov 2025 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450938; cv=fail; b=gtuSCVWntUv1xbDLvrfNIPWxecSaGLrsaZyjjhKwDgKtR/FYQ0RROd+b2Wd9CbdCUoedVfWR8ijVW0XOGqBXdMkjM3kChowGudW2URSTje/o1KOlgsypkT1f9A/ZT/zTYP9lGNQ6pSY2RQVAHA3V8WJNFOgIIntpbgTqq+EO8KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450938; c=relaxed/simple;
	bh=3+1lqHoz6Ry4PwQ+CnI+jARBZO4+Ne7kAIH08/SRQ/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n7sxHa8f7TnEIIcVmWevySeqI6zW44b565CL9Tsh/oMnTiQWRXd0QnO8pQWLUFxjwude8AmxvRa9bsnxzfWy45dgiyG41YJIFtRWlwxYYKp3qu0ev9bncdcAEK3QhfXwXJQ6B90/epmCoezext/Nmfm6vv6Je4vEP99pVqBg7wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpmnZnLx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763450936; x=1794986936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3+1lqHoz6Ry4PwQ+CnI+jARBZO4+Ne7kAIH08/SRQ/4=;
  b=LpmnZnLx9jMwhK5hcsSdhGsQwJ0m+gKGDYFZe48fjJJW8r6J3SORBd2t
   4RFbTOolfC/PhYPPrMHMhl3rAgYjjyjUBZxYLLATAywOfeoUwdV3w6XRh
   VMMWXw0bLULaXeUsjur7vHL0cmatpIXTwE9PWA4ctYWuuWy1CPIxr1DyO
   5NsP6I5r3j7kNs/wN6MJ6gHXlmleZ0FtnXk2ubzK0uuNqRNFcHdIQ6vnF
   gv8LqUmSPZIquCJygUCjNFsbxwJQd4Gd2TUhR8p/ICWgVHmwhTNqJJ6o0
   QduhVB9QjsCi6VR3jS9DW2dG7agdrw4MMRd1y4p5rggKiI+86tGwTPrar
   w==;
X-CSE-ConnectionGUID: AdHNjwpfTXWoMZioYYMMJw==
X-CSE-MsgGUID: qt+UDddeSiqQQfluO5/cJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68069125"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="68069125"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 23:28:55 -0800
X-CSE-ConnectionGUID: cXTc6/FJSW6D+B6iRHhU/A==
X-CSE-MsgGUID: fnc4jro8RzChFOunNN7TvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="194788752"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 23:28:55 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 23:28:54 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 23:28:54 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 23:28:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8iNvXcE4j+U05MJzJ+ndadajUWwGtln5z+6CYPNzQjmBX6HbT6xALO5coK40lHeqEi+/jIrHYcdwHEOyM0GlypX9PmzpHzCyN3dQv1gYU8g48K7TAVSOSeBQms+svxOH3fiK98xdkFhHzi7lKD91AO4F+rpQOu/lvoMw+z75lCidDmo1QOk3EfSLdtyixjwZm8Lj29ZS4RLWt5MNjG3f8I+n9QGMLdSavD5evft5deTQ9N6+pnvdhDFcH/yL+nR+SSUfwZ4pn3mv1xE2ojcWI/c8NUqEL9hjRBjmGFtONmP9rZnL6KCrbP36f4I3UXImZxsiEvv5T6BDYZb8GFwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5FjJpc3WCoz4BCJiBtvSSnXNDDO5G8B8bv8ebRyn3I=;
 b=Uo0enk1VQxKSV/vNMPkGmHoAJPB+x13Tfnnydou71RAtmOMI/p9NEEGxllzsK9AIwScGbDauzhH5ukWRIrnkrAcRYjUkMwy/qnJQ9Y0kANXNPXXPsEIcS1m1Y4KPDhSa9ws6kcgDdfmXwNBBCx73dd1P34QfOMVqNqOpSOhPMa9GDMRPBVepsREJLEfDOuFJfVbaCavdiJkMr3o/2RA51KoKHzNDgSUpyPtGCAKx3oKjDz09g4uR0d5uwi0Kz625fKlFH4Hi1eOoZK8zOyRPJmd1M14USMyMQ/CRX8HlrAL07vv2eSlqTi9V/OEG8gCoKFj++o7PfTL7xzbBsBqoRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 07:28:51 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 07:28:51 +0000
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
Subject: RE: [PATCH net-next v4 0/6] devlink: net/mlx5: implement
 swp_l4_csum_mode via devlink params
Thread-Topic: [PATCH net-next v4 0/6] devlink: net/mlx5: implement
 swp_l4_csum_mode via devlink params
Thread-Index: AQHcWCG/6n8FHQBRh06Etwcbl6q/QbT4CV0A
Date: Tue, 18 Nov 2025 07:28:51 +0000
Message-ID: <IA3PR11MB8986E7B15563BB1647B0C68AE5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251118002433.332272-1-daniel.zahka@gmail.com>
In-Reply-To: <20251118002433.332272-1-daniel.zahka@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA2PR11MB5193:EE_
x-ms-office365-filtering-correlation-id: d5bde627-2449-4d0d-3a0a-08de26741f15
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021;
x-microsoft-antispam-message-info: =?iso-2022-jp?B?MHNMTmdrUnl3MHMxUC9aME9RSFV3UDArTFV4Qi83OS9LSjBPWjFnVHNF?=
 =?iso-2022-jp?B?a0pqeTZWQzFMTitEQWs2UjFLRmhwQ1VlaEZNeDhNYVlma1VYMGpXL2Yr?=
 =?iso-2022-jp?B?aks5Mys5eGZpRHpMbUZUaFBVNDRLc21qV2VyQnh6bGR3UnlZelV1ME0z?=
 =?iso-2022-jp?B?ZjJVV2xoWlUyVjhQa0U1YUc2SENvUm13WWw3eHczQWFyalA0bjJLYmNU?=
 =?iso-2022-jp?B?eUprMG1GTUVqZ1MvbzFlMFBXak8xTEJiZ2F5cTV5bXhtT2ZpamtxWDdX?=
 =?iso-2022-jp?B?S3BLUEFhUlhrRzZiSU5acDZHOGZ5MEZGRGdXKzdNclppdzRmVjlmZ0JW?=
 =?iso-2022-jp?B?VFhjTXdUUU5JMHBKSGJuNEtiZlBnaFRQNm84WlQ0VnZ2L01WSHlISFM0?=
 =?iso-2022-jp?B?MGJUVC93VGplU0lVS3ZNQ3VLVnpObmV4N3ZUaTFUQ0FLTStKQjdvaVEx?=
 =?iso-2022-jp?B?NDRSKzhjNTVJWms0MHJ6NmM1V1pmNTdkMHYvdzAwVEdJYUlJRUttWjYv?=
 =?iso-2022-jp?B?cm1JNE9pMi9WV3QycnBLR0ZNYjVOcjFNcE1XcngwczlPRVBwTlNiSDlU?=
 =?iso-2022-jp?B?TWJZaElQWlAxVFlENUpBNWNxLytsbVN5emxlUUh5THlRQkY1OGViazVn?=
 =?iso-2022-jp?B?dWNjNVM4ZDlOVlVZZHF6bkNJdDF6dFJBbmx2QVVZWHFTNW16Q1lvb1RF?=
 =?iso-2022-jp?B?cEZZUzQ2R3JPRjhHVHIwTHN0SXVrUkYxbjVBQ3VBQTU1NEo1WEJFOXR3?=
 =?iso-2022-jp?B?M2xCdTE5aHZJZlhzaHA4QlBHaFdsVklpMlJGYU8wc1pOOFFpSXhjdTR4?=
 =?iso-2022-jp?B?T0NmZnRFdDNUU0dTM0pyNDdUekFvcFJtc0lHa3RpVXh0cTg5NUEwa3E1?=
 =?iso-2022-jp?B?MnVQQVVHQ1J3cFc5enB3cTB2MTAxSExwNDA1UFIxRHNCbGZrMiszVEV3?=
 =?iso-2022-jp?B?TTJHN1gvdDNua1huSlF3YUNBN0hUV2VMUlpMc0tNWFhUVzJQREVQVFBm?=
 =?iso-2022-jp?B?T1QxMUJiNDBqUFVONmhvYVNSYmh4VDRJalpnWmNMQkptb280MmVaR21k?=
 =?iso-2022-jp?B?bGNMMEQvUVZORjdONlFNTE9CQ0xEYURxYlFtekNhQTRRbTcxQjRBUzlq?=
 =?iso-2022-jp?B?dVh1eHFhd2dYVU1FZ2FMbVlOZE9lUUlCVWMvUXpjaGNPK09BWmg4d1R2?=
 =?iso-2022-jp?B?YjFNOW1LYTVTeHFKOWpFKy9QY0JIZHROQU03R0gwT3d5eSthKzcxb29B?=
 =?iso-2022-jp?B?QmxlaVBleGJ0RWNwcUVrdG0zMEU5M2VJeXdaNWluNFQ4OVJEOWh0RWJB?=
 =?iso-2022-jp?B?T003Z2lVOHFxR2pBb3ZlOEJkajVWOUd4elp4NEZUUExldEsvckxFbEtQ?=
 =?iso-2022-jp?B?SjdVdE5rblFUZjNwUGRHVnV6TDdtdVdZUjF2OU5JaEUzbDJBdnRxeHI4?=
 =?iso-2022-jp?B?alkyRHZ1S0k2WlE1QTN5VTlVaFZaNmhvS28vL1N0Y2lRWEdBUlhuSXhv?=
 =?iso-2022-jp?B?b0dGeDFDRnpRWFdSOGdnUUM5RkJYVXkydHpDRUoxUlRyV0Nad2o5WG4v?=
 =?iso-2022-jp?B?WHZTQWdtbW05Sk5yVjFkaHM4UmF0aVBRUDhqWnZ4ZitSZk9PRi9iczlT?=
 =?iso-2022-jp?B?UStaZTRxaTBCdVNrYlZtQVZLaFAzc3dWUHp3VmsrM2kxQXhyU1hJeDNM?=
 =?iso-2022-jp?B?VHRpZ3BWeTMvZmtuc1YxRWVrRmdxdE5WMEJOTUkwNGRmbnhJblNZTkYv?=
 =?iso-2022-jp?B?OHYzQlUxbExnYWlDWGVxa2xSM1NYMjVZSGFPQjJtOHQ3Y0ltbFlHY1hX?=
 =?iso-2022-jp?B?OW1CK21VZ3k0UjUySDZRVXFNQ1VpUDk5cUFLNzZMZmphbXNnZlNDQ2Ux?=
 =?iso-2022-jp?B?MWVneFZsdXRIbHUzd3o1OXprN1lCam5QM0ppSFhtY2JzLytnbWxDUVhC?=
 =?iso-2022-jp?B?Slk2RDJlZG5BOUpRMmo5Nmp6UFA5enc2L1BPZFl4YmoxQTRpSlF4SEhz?=
 =?iso-2022-jp?B?bE9BRVBRSUY1Y2FaVy90UnlYTG12N0wzd0FRYVpiRTZid1FyYldoQ2tB?=
 =?iso-2022-jp?B?dG1vaDljVSt6cTY3U1BmaHluUkNUelVlZzNNMmJLY2xGZzdOdW5NUm1W?=
 =?iso-2022-jp?B?UXgrYkJMaGIwQkxFaDZIOFJ5N0l3SWkySHREWnI3eDNNQkdkaEVsZVUy?=
 =?iso-2022-jp?B?OEFTYmRGeU5BUUswS0syY0VPVGdXVlVSZjVBVlZ4VGJUckpaMFVlRkJo?=
 =?iso-2022-jp?B?SjNjK2hUbVdKOHRUUWM4RXpHdDR3WEEwMD0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UVY4S1QzSnpaMnJ4WERrQkxob1JUWVlNY2NMbDU1Vkp3dUpFR1p0bGow?=
 =?iso-2022-jp?B?TE1RWFU5S3V2SHFXY1FOSUI4TG10c1ZzQUlhQXJ3b1g0ZldrSWE3aHRy?=
 =?iso-2022-jp?B?NXpaTHQveVBqWklVNU1LanBYMGJDVVA4aDdIZURPQWV6Q24waVJMbzRm?=
 =?iso-2022-jp?B?Q2NtVUI2S2NhVFR0NGxSb1FjbUJTMExwdDIzYzZCbEJtQ1FxWE5JTlhv?=
 =?iso-2022-jp?B?MFJBL0Q0cjdzUCtJMTNZMVlXUW01UjFtcVA0R0ZSS09QNkxwU25LVjhl?=
 =?iso-2022-jp?B?MkpwZlMzMUFEeGRHS2k1cG5iSitDUEdYejBCU2huUGVaZHVWaEJMZTVw?=
 =?iso-2022-jp?B?dm5IV1hvanVoWkdURU04SEJZM0txeDlkMEdvcDlxUng3UVRLc2wzTWw5?=
 =?iso-2022-jp?B?SUUyM1pwWktteE1DNzN4UXQzV3MySXF2NDlSeHpvVmxUU3JVWHozdGVx?=
 =?iso-2022-jp?B?blM2UXg3aGYzcGFXcXBpMG5XL0lWT0JUdVRTSmtYdUtVbllzWkZKdjcw?=
 =?iso-2022-jp?B?K3lVSXgwK29wa0RxL3FaL1ZCZENaZi9mUC9PdlorVzJvaGxZTmZsSkhu?=
 =?iso-2022-jp?B?b0xvYWhLNyt6d1BMUnpvV0l2SDU0TmVUKzZIZi9JYTdvblhCaXhmS3JL?=
 =?iso-2022-jp?B?OEZITGY1NmxmRkhzZkhKR3p6M085QlluVXBnNWx4WlVmZHBNNUdRd2JU?=
 =?iso-2022-jp?B?dWgvRXltTXhpK085NlZsZDE2K1dka0VGandBUnRZUkthd0ozMGp6Njdl?=
 =?iso-2022-jp?B?bnBOZzJ4NXNHUHd0YWp3Nk1ZQThxZlFrbGxyeW41U3YyQVJkMHYwQ3Yr?=
 =?iso-2022-jp?B?WS9OalFCaXl4bEdNZnBJYUloTllTM01VVWZHTnFVQ0J4azdtZStMZTQ0?=
 =?iso-2022-jp?B?OUFRRUZyVlowQ05HQVF5WUxMWlRtOFhnUWhBVy9QaXZYUDFYclZWV2U0?=
 =?iso-2022-jp?B?QUx5RVo3czBxdzJaZXlOMkE3NitsRDBUQnJXOGZTcWxNUjFRT2tOejNz?=
 =?iso-2022-jp?B?NGdicEt4UWdVN1FPNE9EczRZUmhjTmxFWHJDd0FiektVK09Ya1JpaFIv?=
 =?iso-2022-jp?B?M0pRc1J0L2kxd3pJNTMxNEwvcHNUNFRzOWgrbzgzMFpwRDZmKzJ0b2Rt?=
 =?iso-2022-jp?B?VEhMMkR1SVoyNTN1TGRUSml6VE85SXZGd1lkV0xCZmdyU3hHOGlVNlJS?=
 =?iso-2022-jp?B?NzljcUZ2WFN4VFkzV2VVQUVyalNNOEplYS9pOXlKcWFzOXYyK2NQZUN3?=
 =?iso-2022-jp?B?L1R0N0FwTXp0Z2t5dG5EOVV0WjR1REFOZnl3QkVJQzV0ck1NazBsSW1m?=
 =?iso-2022-jp?B?dnJMdjdMNUF1bkhEWnlXUExLOGV6OGZhYkdtbnh5eGhqQkZGOFRrc1Uv?=
 =?iso-2022-jp?B?dGlUWnd0UjBBbnE4NDRzMkw4WlNiYXJ5NGFJcFdxdG9wUCtkTUd5NSs2?=
 =?iso-2022-jp?B?SVRiNGxUMk9ocENuZThZd3lZaWh2TWptdmpydDVEcWZOeXVWYVZ2Z0V5?=
 =?iso-2022-jp?B?YmRwZmt6azRNQURIMU91d3NUeVhISlVIUWlOb01FSmZEM284TlR3VjBX?=
 =?iso-2022-jp?B?Mi9kaTg2UmtVZndvclltNVBjZ3VxaThGUVl1bUNVbzc4RS9mWGNUd2Z3?=
 =?iso-2022-jp?B?bGxEdjNBbnRtWkhEYzljc25wbENWcnJsbTloeFBnY1BzSC9LbkdMalFV?=
 =?iso-2022-jp?B?MkFWcm1WLzdxT1JTZUtkOWh2UHpVajFjTWxHbVpzSnBpY0RFcTFuMjdD?=
 =?iso-2022-jp?B?bEtDRGp5bmR1aWppeWIydGt5Vjk2cWxhTkZ5Ynh1R05id29Xcm5uTXZD?=
 =?iso-2022-jp?B?UVFjTk54ZVNGc044MWJtL0tVbGxaWXorVmM4RFVrRHVpQld2TUt4a2hW?=
 =?iso-2022-jp?B?clhqNmI5S3R4dTQ1RTZzTUpEd0drRWJwdWoyS2xWaXYvcjRZSHdqNlZJ?=
 =?iso-2022-jp?B?azdocHZJWTdNRnRCV211cnZ3Qk5VSGFxUFRDbHZ3aXA0b3JSYzRrYWxP?=
 =?iso-2022-jp?B?LzN0Z0xCZVFuVXAzMmVxSWRDa3NDbjhvaU5mRWR3MDNMZ3VSMlZzT0Nh?=
 =?iso-2022-jp?B?Nm5GNUJQOUhwVStVNnVBb3RLbkNGL1NsK1N2WWdjRk1Kc0pkcXlPNnpx?=
 =?iso-2022-jp?B?cS9raURjUS9TcjJzdlMvMXVDVnBNeGVZbE1XNkJvNnNub01QOEo3djRs?=
 =?iso-2022-jp?B?SU51b3pER2dOdHlCYm5UN1JqN0g4Y1hOeDV6dXZ5KzNNUmlvY0xrNi9P?=
 =?iso-2022-jp?B?ZXFiTnF5amszVE1idXhFSS92K1ArTTlFdTdDWkV0WERDZ3JvR2cwUThD?=
 =?iso-2022-jp?B?S3UxMlBtNHpPTUg3dVdtTUpnMGxEa3dBOUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bde627-2449-4d0d-3a0a-08de26741f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 07:28:51.2554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIqWPns/EqkVb6C1JRFmEbztrKnySwVK71Mk8GeaErRHmGEJidItPNSYWr86cjjrHdS4968jM5rM3c75UDRSWjocnijx6uw8ghs2+GlkQDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193
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
> Subject: [PATCH net-next v4 0/6] devlink: net/mlx5: implement
> swp_l4_csum_mode via devlink params
>=20
> This series introduces a new devlink feature for querying param
> default values, and resetting params to their default values. This
> feature is then used to implement a new mlx5 driver param.
>=20
> The series starts with two pure refactor patches: one that passes
> through the extack to devlink_param::get() implementations. And a
> second small refactor that prepares the netlink tlv handling code in
> the devlink_param::get() path to better handle default parameter
> values.
>=20
> The third patch introduces the uapi and driver api for default
> parameter values. The driver api is opt-in, and both the uapi and
> driver api preserve existing behavior when not used by drivers or
> older userapace binaries.

=1B$B!H=1B(Bolder userapace binaries=1B$B!I=1B(B =1B$B"*=1B(B userspace.
=1B$B!H=1B(Bintroduces the a new mlx5 driver param=1B$B!I=1B(B =1B$B"*=1B(B=
 the (or drop =1B$B!H=1B(Bthe=1B$B!I=1B(B)
=20
It's minor, but trivial to fix before applying; also helps searchability in=
 lore.

With the best regards
Alex

> The fourth patch introduces the a new mlx5 driver param,
> swp_l4_csum_mode, for controlling tx csum behavior. The "l4_only"
> value of this param is a dependency for PSP initialization on CX7
> NICs.
>=20
> Lastly, the series introduces a new driver param with cmode runtime to
> netdevsim, and then uses this param in a new testcase for netdevsim
> devlink params.
>=20
> Here are some examples of using the default param uapi with the
> devlink cli. Note the devlink cli binary I am using has changes which
> I am posting in accompanying series targeting iproute2-next:
>=20
>   # netdevsim
> ./devlink dev param show netdevsim/netdevsim0
> netdevsim/netdevsim0:
>   name max_macs type generic
>     values:
>       cmode driverinit value 32 default 32
>   name test1 type driver-specific
>     values:
>       cmode driverinit value true default true
>=20
>   # set to false
> ./devlink dev param set netdevsim/netdevsim0 name test1 value false
> cmode driverinit ./devlink dev param show netdevsim/netdevsim0
> netdevsim/netdevsim0:
>   name max_macs type generic
>     values:
>       cmode driverinit value 32 default 32
>   name test1 type driver-specific
>     values:
>       cmode driverinit value false default true
>=20
>   # set back to default
> ./devlink dev param set netdevsim/netdevsim0 name test1 default cmode
> driverinit ./devlink dev param show netdevsim/netdevsim0
> netdevsim/netdevsim0:
>   name max_macs type generic
>     values:
>       cmode driverinit value 32 default 32
>   name test1 type driver-specific
>     values:
>       cmode driverinit value true default true
>=20
>  # mlx5 params on cx7
> ./devlink dev param show pci/0000:01:00.0
> pci/0000:01:00.0:
>   name max_macs type generic
>     values:
>       cmode driverinit value 128 default 128 ...
>   name swp_l4_csum_mode type driver-specific
>     values:
>       cmode permanent value default default default
>=20
>   # set to l4_only
> ./devlink dev param set pci/0000:01:00.0 name swp_l4_csum_mode value
> l4_only cmode permanent ./devlink dev param show pci/0000:01:00.0 name
> swp_l4_csum_mode
> pci/0000:01:00.0:
>   name swp_l4_csum_mode type driver-specific
>     values:
>       cmode permanent value l4_only default default
>=20
>   # reset to default
> ./devlink dev param set pci/0000:01:00.0 name swp_l4_csum_mode default
> cmode permanent ./devlink dev param show pci/0000:01:00.0 name
> swp_l4_csum_mode
> pci/0000:01:00.0:
>   name swp_l4_csum_mode type driver-specific
>     values:
>       cmode permanent value default default default
>=20
> CHANGES:
> v4:
>   - add test case for default params.
>   - add new cmode runtime test param to netdevsim.
>   - introduce uapi and driver api for supporting default param values.
>   - rename device_default to default in mlx5 patch.
> v3: https://lore.kernel.org/netdev/20251107204347.4060542-1-
> daniel.zahka@gmail.com/
>   - fix warnings about undocumented param in intel ice driver
> v2: https://lore.kernel.org/netdev/20251103194554.3203178-1-
> daniel.zahka@gmail.com/
>   - fix indentation issue in new mlx5.rst entry
>   - use extack in mlx5_nv_param_devlink_swp_l4_csum_mode_get()
>   - introduce extack patch.
> v1: https://lore.kernel.org/netdev/20251022190932.1073898-1-
> daniel.zahka@gmail.com/
>=20
> Daniel Zahka (6):
>   devlink: pass extack through to devlink_param::get()
>   devlink: refactor devlink_nl_param_value_fill_one()
>   devlink: support default values for param-get and param-set
>   net/mlx5: implement swp_l4_csum_mode via devlink params
>   netdevsim: register a new devlink param with default value interface
>   selftest: netdevsim: test devlink default params
>=20
>  Documentation/netlink/specs/devlink.yaml      |   9 +
>  .../networking/devlink/devlink-params.rst     |  10 +
>  Documentation/networking/devlink/mlx5.rst     |  14 ++
>  .../marvell/octeontx2/otx2_cpt_devlink.c      |   6 +-
>  drivers/net/ethernet/amd/pds_core/core.h      |   3 +-
>  drivers/net/ethernet/amd/pds_core/devlink.c   |   3 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   6 +-
>  .../net/ethernet/intel/i40e/i40e_devlink.c    |   3 +-
>  .../net/ethernet/intel/ice/devlink/devlink.c  |  14 +-
>  .../marvell/octeontx2/af/rvu_devlink.c        |  15 +-
>  .../marvell/octeontx2/nic/otx2_devlink.c      |   6 +-
>  drivers/net/ethernet/mellanox/mlx4/main.c     |   6 +-
>  .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +-
>  .../net/ethernet/mellanox/mlx5/core/eswitch.c |   3 +-
>  .../mellanox/mlx5/core/eswitch_offloads.c     |   3 +-
>  .../net/ethernet/mellanox/mlx5/core/fs_core.c |   3 +-
>  .../ethernet/mellanox/mlx5/core/fw_reset.c    |   3 +-
>  .../mellanox/mlx5/core/lib/nv_param.c         | 238
> +++++++++++++++++-
>  .../mellanox/mlxsw/spectrum_acl_tcam.c        |   3 +-
>  .../ethernet/netronome/nfp/devlink_param.c    |   3 +-
>  drivers/net/ethernet/qlogic/qed/qed_devlink.c |   3 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |   3 +-
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c      |   3 +-
>  drivers/net/ethernet/ti/cpsw_new.c            |   6 +-
>  drivers/net/netdevsim/dev.c                   |  55 ++++
>  drivers/net/netdevsim/netdevsim.h             |   1 +
>  drivers/net/wwan/iosm/iosm_ipc_devlink.c      |   3 +-
>  include/net/devlink.h                         |  45 +++-
>  include/net/dsa.h                             |   3 +-
>  include/uapi/linux/devlink.h                  |   3 +
>  net/devlink/netlink_gen.c                     |   5 +-
>  net/devlink/param.c                           | 180 +++++++++----
>  net/dsa/devlink.c                             |   3 +-
>  .../drivers/net/netdevsim/devlink.sh          | 113 ++++++++-
>  34 files changed, 689 insertions(+), 91 deletions(-)
>=20
> --
> 2.47.3


