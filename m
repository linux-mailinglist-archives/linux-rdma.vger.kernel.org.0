Return-Path: <linux-rdma+bounces-9304-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDC5A82BDD
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 18:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06864411DF
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696DD1C5D7B;
	Wed,  9 Apr 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7tvkRH7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BD1C1F0C;
	Wed,  9 Apr 2025 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214481; cv=fail; b=DHqMEiEo0qlrSIe+JbiN6/LJFi/6zMbIMxhCsVfq/72ARlxS9F4dRnJGHN51TL5oOhfHYGf3KJqqyuut8WdPH1vAyo+Rx1VVLQ6erFizdFRAdO/gh1s6tcgUf+xGAuUpRxAKNVsavAkhwF4Wrylp2TYCA7lRl9HjDWL0GV/qHoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214481; c=relaxed/simple;
	bh=7MR7tKocEUQ/EM/vrJ8yBZmoOXwxv9BcyiujwLmd3u0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=awqZYpdKuagugUlCu6dJZ3lxGy9qUmc9Sj8grTf50MaCDKk4uvy0mn13cTxxM7NnhNnRweTsZ8uj4j1H4lBCeCWuUB3OV1NYJYEP7d4px9w+4oMPzC7CG3lSIn7e0qZvEr8jjRGYvdUZdYbZuLIRrrNa57x+q55PaO9erN6QK00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7tvkRH7; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744214479; x=1775750479;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7MR7tKocEUQ/EM/vrJ8yBZmoOXwxv9BcyiujwLmd3u0=;
  b=V7tvkRH7vz+PM5WN+tzKfqIFHMEBT+HpuU2bowV99U4C/JTNP7HX0nAO
   57YJpjvSTWBpkwl0Q6E4268+Y7WKdg1gEcYU9U2Tiz21fDLnxDd5P8RjF
   Zocj9APnf3GEB7UQWMNkksxWqAMCkp4B7kula7befTuWuVnYEN8SwVodF
   QE38HbUDGQruX/AWq2FIDyyiIXgGNyRIFMNS+F2dwSGYQZG1RIiCJz7Ym
   2pWlYPIT/um9JOnga8NujhKQpkx8qy9JjJyKJNyjJ3eJfzjZ+xKniGmuF
   7gqKidQNuUXCGpubOHgnEJaWCYnAVVrzpwdgMh14/WwxJtBZkKYKkxcCW
   A==;
X-CSE-ConnectionGUID: MCOPZHM9Sbyqpe8dKN0Ikg==
X-CSE-MsgGUID: qFGWFnESSmmqntGZNwni0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45829638"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45829638"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:01:18 -0700
X-CSE-ConnectionGUID: xiSFV9gxQeuKKEjKFL2Hmw==
X-CSE-MsgGUID: WlG4QRhuRuapofx4ugFw2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133609315"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:01:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 09:01:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 09:01:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 09:01:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrMDovz8N/1HToDB1MHWjKszpidZ3v0BVij7PPV7535aBIK1A4pZPhTvvkVyUM5INOfOB5LCatHAK9DeNdac6WtAL96ScT+DRpbeosFmtZrQSkagJcPfayThNH4M7uQBL87w0PHK3n34PWPm4ge/x23r+3SFDw4gvs1IuKZOf5zweV+yKCtMy9O78k/l4Ze7GXEC5UeGT98l/V8aaVBdX7ZNblAG5eZW57NCcoX7yajj4S/z5Hv/Zxe33c2Zb17qjwKo6YdE7JgyJFL3fsLnCKm4XBbMxxJZ+qnvPAstdnIQVQEj64zezG/lQLKvBhB/RbxDEPjRtEPYIEmNMZ+5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IIt7z44cx7lg2bQPr0/sNzKKIHvQCsntKCnHlOSzXM=;
 b=jLfynK+vTbWJgYgEil4ecG9tdIdfhjY46lSUEQx9sH4anWZPL7o7sl0V8k6z0jkG24G8k8bHc7j3m3dR8Df04+79lsoPpX1l1au1LhBOhi05sBun7HUTPO8fkNPq4LknsXfGn2z5GWSL33qk58yOy36MyyEvMqG4KsBE883wCmtd2m/JxoBbbxEKYqwp5WjVqJXPg+zjWsr+Uu2sw9ZZymQK8kVzFW9BAuFqsL4qbCnaj2WNTmIHlWBNUK1AFb1CsAKXVik7UBsV1UFuvoWYI2lKaUJEz/46uHmu81QymwtiSrh8OjibGPB24yi3Q67G0MHh6H0Bq3UMtdZpbOpnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SJ2PR11MB7427.namprd11.prod.outlook.com (2603:10b6:a03:4c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 16:01:00 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 16:01:00 +0000
Date: Wed, 9 Apr 2025 18:00:52 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Vlad Dogaru <vdogaru@nvidia.com>
CC: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Gal
 Pressman" <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 01/12] net/mlx5: HWS, Fix matcher action
 template attach
Message-ID: <Z/aZtDJdSSunX1Fz@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-2-git-send-email-tariqt@nvidia.com>
 <Z/aQZzRYWkSLV1r/@localhost.localdomain>
 <8358f9a8-3a39-4e85-b2fe-5298da3d36cf@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8358f9a8-3a39-4e85-b2fe-5298da3d36cf@nvidia.com>
X-ClientProxiedBy: ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::15) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SJ2PR11MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 746fc75b-7d6d-4f2a-1c3a-08dd777fb8f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vcv4oHWshyuv0amv9u4f2fMlDhniCe0CdQ7mzSAeXfTbfV0fSn2iuJgC3gaD?=
 =?us-ascii?Q?krBALt8efcK9nM4ZUr6rMyLJa2qix2yTZAjSAWq0k+KE/7p8MjmYGfCjfF4r?=
 =?us-ascii?Q?dUTI6SAB9LnYmlp1ccmQCjekRZtMK30VaYPUmrJhUaKQ6lhLwtFZxayA87vu?=
 =?us-ascii?Q?qT6IiPs5vCqEDpSiMT834SF/eCqoNHNs2eTJQCQ7AjzIHWA6PZ2M6UAN+JqC?=
 =?us-ascii?Q?1mKTq0CpURrjROya5QMrYTRlf0KpEpD9ZC2IfcI0IaE5Fr6HPO3kBuHV6MbG?=
 =?us-ascii?Q?PjYxSdPmVlySJtEe6BMfUAEtcslDJd0ahiK0VNmxIRrZNN35rd62PaZBsig5?=
 =?us-ascii?Q?CQDnCTmWjg0edbNF/6NiEge0Ax4AGRn3mwybNClV/M35PhFujHcVh5Dpisil?=
 =?us-ascii?Q?Omo7lFcdmaSRz3Sh910DUJJeSnYrUQ2+36r92hxd6Lbw+S3xT1EvphY1iAYs?=
 =?us-ascii?Q?Di4eWvKR2B4v4dHF2HIxn9EgCgqofXq51HlO+pMhippm6UqYXI9HyBGqddwf?=
 =?us-ascii?Q?0YqKRYZmOAtQboSI4QSuE9rNbOAsvuGrawT5XBkRCxeQD69JSV8ZHqkIdljZ?=
 =?us-ascii?Q?7pYd0QqW47SKOwasf+dadGEi0+x/0KA8dBpOtukZoKSXE6FdF07CH3ihT020?=
 =?us-ascii?Q?FgW6CMls5DEj3bAqWmZZijNiqRwX+/Ehd5Vg+NeSlobg6p40bhUvGL2r3elI?=
 =?us-ascii?Q?8GOZTeiXwjlI4A9Dr78Ew1zuHBdjahfbzqsKKSPwahvgWye/M9J8oIVJrDjX?=
 =?us-ascii?Q?9hFtzlGOJzkfzwhTE8AAPOp2dB5/dvdxP3sXDf1Z+C48lAI1bqTyjFuelQ9I?=
 =?us-ascii?Q?7mSRPoOOFwYfBzckWQPAPBOJM/DujE+nxXYcHRGLqyYWV2tgeNgcBHT+OZYS?=
 =?us-ascii?Q?8wEz6tx0Tk2dTqZh+wYFQj8DvWba6+oEk1vZY9jxjCyHiFeggq5vJQEUvjzF?=
 =?us-ascii?Q?N7dUnP/iAKh5aLmOYrb2sCsz4MeZG8eV6YVUB3lcb1pJUoy+LcWmxA41zYIg?=
 =?us-ascii?Q?AHyYAAa8/ci1wkLX4urNBQoWARhWFQX+CuFLrFIuuIeTbplNTZ7LUNRLXsJS?=
 =?us-ascii?Q?8n2NQyZN6QFussXow6Pp7dDUvhXLxpca4QNqehWkjVZlLttEgkPGXF+EXVxV?=
 =?us-ascii?Q?v9L8pvouN8NdjjWc/MGJ9tR0vnNhibQanqy1eCVsBCzjxZ0IqNkUm677uX4F?=
 =?us-ascii?Q?6BNuBv9XFuxjgeDbxw65f9ids502pdhGZigT8TMR+KNF5AvAzsVoDBKNQkP6?=
 =?us-ascii?Q?WniLJ548YjNbRmfjpsy4J9SXG1OZtw+h/lWIbcPmxXByOP2FQuote3WCI3wq?=
 =?us-ascii?Q?oixtcH+oSRk3UsWDWVzTqF/n4QpauSJpY0cEda8XWWImrqY2DiVlUwUAQCTa?=
 =?us-ascii?Q?Zobm7NyyYodOfseIvxGZuGcIy6nr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TCTT4mp3yB4a/TONrNN0oNQZQpPQ4e7iZTiIdbdV2yzgzCbFn4Y+CZ97n3pX?=
 =?us-ascii?Q?SrF5HIN0cRDMT6snvmUkvfDMikvdBYcIqXTihEmp3naXbDKVP/Nn/Ewtuh5n?=
 =?us-ascii?Q?Cup6yFKBbAWf0mUUaxTjoLE7w3x26CMiw9x2VEYr2rhzMCtWgwDzLo5f7P9P?=
 =?us-ascii?Q?vb24Pag1VCZdOCy9B/9K8hSC51ajJYN8wNoo3xmicf47DBHcQGEDs2SSA1W4?=
 =?us-ascii?Q?CeFAP/UjBG8/GzBwviRiLekf3Q1k+elbTC7tkf24Q7FhduqWYty3tdaUWXnC?=
 =?us-ascii?Q?b/CR8aZepASOzLFitDT8orFjfuwMRAJVqxN1ZAPOsZG5t8uzJegCH1aIqCqm?=
 =?us-ascii?Q?te4woNwu+Q/upOvRS+cRIwYGmqIBidNOyqgCtKRLyslO4z9P959vm/v6AWCX?=
 =?us-ascii?Q?5ywco3LtONq5t+cKXke0/JuDDKNOeBnn+7W/jM2SV8COgHIV7H33/S2/7V2F?=
 =?us-ascii?Q?sjX2EYWyERNna6NzYAm8s+006HuoHrkyivc4rUdkNyxNfOQwcEXu70q7mL/x?=
 =?us-ascii?Q?fG3GT4NYLmX9JF+ezrn8yDahhjKHfATg/Z6DKOAlPkDg+RH0/qShSDufTTOC?=
 =?us-ascii?Q?VhlF8zufJgQIMT2NH24CMyOnQwCqC8Rbv5xsourMlvLofwZuXlc7b0Sm73I7?=
 =?us-ascii?Q?LfGvakVhlTxx9yZ4PnBYTbsmHSUR8CGaIEVZvfUYvtUHEmu86aPddTLTLQPh?=
 =?us-ascii?Q?OEiJub4G9+/N2qBUDENhM7g7yicG3p+2uRkzsOvcseAWXuouL8zMosZpYox2?=
 =?us-ascii?Q?NRGwNsHzWT6Rt52HzYpttm7tORx3x6GIuIVXZ9bKCkux8HMNlaP9knxFIQXN?=
 =?us-ascii?Q?wlo17FsS1aHlTztLKawMRSoQBvXMf7OTCUObYbi2b0lfNPLTJwmRSzNdzvVw?=
 =?us-ascii?Q?6xWTL5yZ0/feufZDfTBmSvRA8R0zSOvhq4VwlRulhUL8qqpLd7v+n5Wmiaos?=
 =?us-ascii?Q?N7q2aASzvi8IIohn5Mpns0cOqe8QhD9Gzw7YlSAdBsse+9JTKL8KoWLrXr1J?=
 =?us-ascii?Q?67jZaKiD+6XSZE50FF/ee1V1O8SBFSXGcR5/vR2WnKcCx7atGG9oKRs3xm5Y?=
 =?us-ascii?Q?hFkbYL6WQsWp0kN5iVZOYfzUlt6HaIc6U87obYmwfr6o0BMf6JrIDO605c3j?=
 =?us-ascii?Q?lNlQrnUOmP/PMHti5eNkssg/0J3hOUW2jNA231nzyswZjUYE/35YqognlziT?=
 =?us-ascii?Q?G3QNw3jurOWYC1WiU/Tb5AQ0WuU4KYWRF6O9RNSnPEgoHyXcQ7GQ3Wbn1GL6?=
 =?us-ascii?Q?qrfpGrxmdHQdlkg1wVhidp44faZhlAeS8HSUcU3s1ZwiMZpvg+Jq4gHwHuHE?=
 =?us-ascii?Q?LRXEBE1R2xBaOKjZF63fFFasR67gvTe+571SDKx0IQB/AJkEMlRWU7LF9urd?=
 =?us-ascii?Q?bNSxZssAvdEI5s28k7+jeyTwUVtnSdsfduEUxFHviDLaZhGFYEN6y0jl+FPf?=
 =?us-ascii?Q?YtfbnyBg0gmZPBeQjOTJV6zBfJNhSdAEkTgOEikTlrBgEx/H2Vj+vNp+7dl8?=
 =?us-ascii?Q?jQC46zRhThfjk9S6bRV0DXVRBo/dA46f4hmlzX8lE81Aqv7pzdIVM6tHf3U+?=
 =?us-ascii?Q?jl1LK8VTz3gizSbbwvNLJ8ZpWes4x/5YkBD+mdGfLMG03M1jv+WX9p2BbNvl?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 746fc75b-7d6d-4f2a-1c3a-08dd777fb8f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 16:01:00.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2l3D8saFRq6tp/KMQiEVOTDxDlp417WBzqxAI0xLPrSAI2RYdic8U6+qkGiq/vKSHh4fDFxery9961iUTVvMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7427
X-OriginatorOrg: intel.com

On Wed, Apr 09, 2025 at 05:56:19PM +0200, Vlad Dogaru wrote:
> On 4/9/25 17:21, Michal Kubiak wrote:
> > On Tue, Apr 08, 2025 at 05:00:45PM +0300, Tariq Toukan wrote:
> > > From: Vlad Dogaru <vdogaru@nvidia.com>
> > > 
> > > The procedure of attaching an action template to an existing matcher had
> > > a few issues:
> > > 
> > > 1. Attaching accidentally overran the `at` array in bwc_matcher, which
> > >     would result in memory corruption. This bug wasn't triggered, but it
> > >     is possible to trigger it by attaching action templates beyond the
> > >     initial buffer size of 8. Fix this by converting to a dynamically
> > >     sized buffer and reallocating if needed.
> > > 
> > > 2. Similarly, the `at` array inside the native matcher was never
> > >     reallocated. Fix this the same as above.
> > > 
> > > 3. The bwc layer treated any error in action template attach as a signal
> > >     that the matcher should be rehashed to account for a larger number of
> > >     action STEs. In reality, there are other unrelated errors that can
> > >     arise and they should be propagated upstack. Fix this by adding a
> > >     `need_rehash` output parameter that's orthogonal to error codes.
> > > 
> > > Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
> > > Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> > > Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> > > Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > 
> > In general the patch looks OK to me.
> > Just one request for clarification inline.
> 
> Thank you for reviewing.
> 
> > > ---
> > >   .../mellanox/mlx5/core/steering/hws/bwc.c     | 55 ++++++++++++++++---
> > >   .../mellanox/mlx5/core/steering/hws/bwc.h     |  9 ++-
> > >   .../mellanox/mlx5/core/steering/hws/matcher.c | 48 +++++++++++++---
> > >   .../mellanox/mlx5/core/steering/hws/matcher.h |  4 ++
> > >   .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  5 +-
> > >   5 files changed, 97 insertions(+), 24 deletions(-)
> > > 
> > 
> > [...]
> > 
> > > @@ -520,6 +529,23 @@ hws_bwc_matcher_extend_at(struct mlx5hws_bwc_matcher *bwc_matcher,
> > >   			  struct mlx5hws_rule_action rule_actions[])
> > >   {
> > >   	enum mlx5hws_action_type action_types[MLX5HWS_BWC_MAX_ACTS];
> > > +	void *p;
> > > +
> > > +	if (unlikely(bwc_matcher->num_of_at >= bwc_matcher->size_of_at_array)) {
> > > +		if (bwc_matcher->size_of_at_array >= MLX5HWS_MATCHER_MAX_AT)
> > > +			return -ENOMEM;
> > > +		bwc_matcher->size_of_at_array *= 2;
> > 
> > Is it possible that `num_of_at` is even greater than twice `size_of_array`?
> > If so, shouldn't you calculate how many multiplications by 2 you need to
> > do?
> 
> We only extend the array by one template at a time, immediately after this
> check, so this can't happen.
> 
> Cheers,
> Vlad

Thank you for the clarification! Just double checking :-).

Cheers,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


