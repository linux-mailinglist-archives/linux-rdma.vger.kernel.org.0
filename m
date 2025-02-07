Return-Path: <linux-rdma+bounces-7561-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC9AA2CFEA
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 22:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0FB27A125B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 21:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979E1A0BC5;
	Fri,  7 Feb 2025 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k28xstTO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D223C8CB;
	Fri,  7 Feb 2025 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964541; cv=fail; b=D3+aX9kZ3uBUPtN/VAV7YPn0w+/zoa6zT88ab8tZw+J0bhkHFwrSwgvdg6j8e5hkXtuAqSoRG6KESajvrnfMkzCoFgYnkD4FNxSiZzO6QJXvIcrK3XFL7BwyTDOHzgF9tuxzUizlYDjDHxv7ioOw8StFTdWHVOVJoV93D2AdWmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964541; c=relaxed/simple;
	bh=5qNYh4+a4EkpSdKA0gEDj69RbRx1PTRavuRrblz4hsE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J7KXl0FkB385h6775iQAyxPA/GC7UhVmr/usCU+0HS4NWzhDqYZKhDjzbAdJ2ksFg0dT+JBLK8RuQZ2BNduilbvZNmznL0kmQfdQYa0zgML3un8he2UNVHHHf60hK6/GT6/HfMmfVZ5GWHpgw0TDs5+ZjueLqZJDwhuOQEODHLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k28xstTO; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738964540; x=1770500540;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5qNYh4+a4EkpSdKA0gEDj69RbRx1PTRavuRrblz4hsE=;
  b=k28xstTOwaIg66B9+JblanrYWAhS0VoY/SW0bgHnQbogh7JIyHR+V05I
   lPnKfVXlgtGl3vlr5XTSbWSsz0Gfwido0Pga37rlDiIR2Nawr1Xp5vObx
   vGtBl7vKhv0kaz3yJu6hCCDZBM66wFWZQ7ocJHbRAI+cvnJDX6tf4K2lN
   xmE3aAYFami4WiZt3dZRvXTX1FqnC4/+XVYec1fGbDInYwCTNcr/ELfFc
   +ixIPGhVstjn+YQ9971F/V8QwhH7tQ+nHPSDUJ9FG1MbkvkD19lpvyTYt
   YYYXqI4rltDIanDAMmshC/k0xturE8zSab+6wdvPYI57CDeAXOMlP3B1+
   g==;
X-CSE-ConnectionGUID: V2y30QTvT96LQ89OTgxOyA==
X-CSE-MsgGUID: zt3GcTnjQO2dk/r9xAwbgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50242938"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="50242938"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 13:42:19 -0800
X-CSE-ConnectionGUID: NYVifmHxQIumygNK6hJTIw==
X-CSE-MsgGUID: PzF85kzMTA6S/KiIiKf0nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116576131"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 13:42:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 13:42:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 13:42:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 13:42:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnC4ERlr/2gg5sQPjNbELQkMMPlOs3MxQK1OhEPwe5Zf42b47W3ARUPXTcud7X6ECSSJr1xvNLSDv8HNafXEngr7zjBXV22AiqYYoMZ7NI1nfy5Nf9U1iI2R0bQqvlr4YPUZadGmD0NUQDILXwiQdJKfvrUCBPv+xV5n9lbun2vTAKlwFu8KPW/iXv3NQvFJVX/EZMRivWdn0er5PqqLdnmZkVXEj0YPS3g4xleFbSdJVhBN2qaB6qd+RDjRrThXo0P8Hir5a4qTFtdtWkvMHiSGxPgQXNBe8RP6qAeaBeKdbbrUXovo1Tnbq7na1X9xazgYFPB0T3PsosZ09WAM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TsoK7CRIgUYLELx4dqw3YWYvhFfaOvsZks7z9fQwDQ=;
 b=hL9wo/GIB9gS3F9hy4Zv83BooxsThv+Q4u6TEDXIWlxZ0DPkPxXebxAiosBvIPne9USzQnTDIr0/DSCg+O5pQge2WZW+TCU9WZ3zGw/qLfzzcjtRQGtKmCCACQHGp9hUZmA2j33An6CWr2c6aimmzsWfuBAa1oN/GUIHU74WoCINML+WLE66UFaqXxWzO59Mgp9lGnXh3nhhluhIM/DeAT8y90ATBwG6nxfCUKcdiND6kreH1boNpzmk3adiv639/PCUc+O3LWJJ8z3Qj3KssAX1DRQzaaihhd5HgkxWtivfWWKOi60n2UTCZYxWJPEoLoRS8/6/hAN5y34S9aemjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8201.namprd11.prod.outlook.com (2603:10b6:8:18a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 21:41:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 21:41:46 +0000
Date: Fri, 7 Feb 2025 13:41:43 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, "Daniel
 Vetter" <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, "David
 Ahern" <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>, "Christoph
 Hellwig" <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, "Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 00/10] Introduce fwctl subystem
Message-ID: <67a67e1750f67_2d2c294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:303:8f::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 421326ae-f729-4bfd-1f44-08dd47c03887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZHM9VGEpDiLO2DEbuzpx+um4RG3jmpvEos+DWcEfH1HnjK8Yt4FGOOxhtfqx?=
 =?us-ascii?Q?rAq1Q3dsqeSaUOHc4MS2cWB4ablkbtFkvUmBJxINtNC7vYXGq7sk8ocI+vtd?=
 =?us-ascii?Q?wFVPxjVW4wq6ioTFM2axiOQLY6Laoy3uj/0YFhDj1OqLYdZ9i2CKZmf7KCOE?=
 =?us-ascii?Q?ijYGX+/i+XlY7UFUcOMsRb47MdrtteQxkEKbckbnipk6QXROc6A767q3wUZU?=
 =?us-ascii?Q?ZcoLpQIuPgZKSASxOy6UD04e+S1atgWjTbcTMaU4vMPJOyXMgJBy/mNfjtDj?=
 =?us-ascii?Q?0MAolAilK4wGnhfTUaPneRoS1A0bkAGFzQq8DMV7FL/SO9XAOKvMB46Cq3nr?=
 =?us-ascii?Q?vL+0zkmendDB0okWEpH3k7f+/lXHLBS4rzW0+or3xXb+5MQk8Lk94dwFKtEn?=
 =?us-ascii?Q?Ge/I2LPC2QN3ERtXAzFH64DeIwdzijvu6I+BPHmhkPv5wVJ5RFOhkS9GrqDz?=
 =?us-ascii?Q?rUPK+LG6XaVeuYVKk/xg0Xho4i4G2NcteKwKPV42NqDso8SBn+zpJNl84RC7?=
 =?us-ascii?Q?p8WVyK4oAslRo7MSb44cB3V5SQitJ+7oZLi/3uTRj5x2/cOjG72sI9SnyTn3?=
 =?us-ascii?Q?EU3YIpleUA+0MoDCzg2n9DC/H8UH3zor/CFQLLV7kkyApXeYe3qnIOpPHPGu?=
 =?us-ascii?Q?kWcqDRp8+VM5Qnp8GMz60zNLxJ13QWFUNddXRVzr67e58A07ytBTunO9k9O6?=
 =?us-ascii?Q?1Gy0hCR36q2BodhoQdLDzTTOdKQxxqe+tsLbVWmJyVm9pOBKMHo2FHfwvod6?=
 =?us-ascii?Q?eocLxDJ7bC1aIRkcPsk6QD28DReWhH8anUOqBy6RJLTeRAgwSpeQxLCP+HUM?=
 =?us-ascii?Q?3jNln1CVTIsPIs9F4qRvw7ex5WL+dqBrptTQrBrxlOBG2Za83oRmOZhLeQ8r?=
 =?us-ascii?Q?R1ZQuzXNa3foazZylD5gygtIyMAcopgzyHOCWHfCEFhYu8rKwyAkkNbS8rUw?=
 =?us-ascii?Q?FrgmqefFODBVVT8Mu9EldHAqL6BTbnCXq1vBGY9N14OyZky2aTTbaUL6W+LN?=
 =?us-ascii?Q?bbbAAtN2jPJS4+aXR7NAMbk4Q9qCjg887y1zGAR2p/HH+uEt6tA/SeetSVFu?=
 =?us-ascii?Q?TzRozd4+bxpnfGiDy/PWqFQgSX3Dq+cCP8Mn+54u5233Mcs+ZoNVJTp/Kl7d?=
 =?us-ascii?Q?rB8eWv5FNpDxlsjreS2ZenYtbTu8enDGMr2DjuQevLyq82jKC5GHgcfgg0rC?=
 =?us-ascii?Q?e31KytahF9ZS0Q7r6I2vcCI6hy99I4rBW2XtGetvSiLNWkn3+wXiTdFudXWU?=
 =?us-ascii?Q?bRYj6kW/OOddrDbRtb1ecyICQQPP6i4J0VXW51N14ROjH26e3YeUW4N7abfO?=
 =?us-ascii?Q?w5ZsQnM6HJNaboak48z+OMT8YGd0qoVcjvVL8niQMxMgHOlWTp1wf7ZsCZbR?=
 =?us-ascii?Q?nDZrz0rtHzIZGAsE1HrLVdPcLioA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WvzP1gCsF1Y9riEV9LrthVmWjX461mrPBkvJQUaltOMIppFTtBvm7vIbDCsU?=
 =?us-ascii?Q?JoT30Hfo3KRd4q6lDYYAycJt1QE0qtxrTi4JQBn6Ng0xQlZgAqZqxq7yB4jy?=
 =?us-ascii?Q?ZnOjCwu4kcUojnJZSkMtMNpA9vNHjD9SizSN8vWTTfKL6/ZhQD8oEMmWAzQw?=
 =?us-ascii?Q?UelKk8Ynq65+qi6bw/SAimnJmMc4bGukBNpNEwXQSvUvxj6cOxXjwLPxWMon?=
 =?us-ascii?Q?6orCFH5hdjf5BgChsHRqjukovuHmDtWSn2DmOik6aa4512kZynS06Lju0Agb?=
 =?us-ascii?Q?VSUoktFbGbFaET7TAjMtbBh8slkvmANTFLTCtgRtirNYjFAbDorawrR2QS/b?=
 =?us-ascii?Q?ghKtNeQB/Gaf3zjcFyAV4xwqCk+MV3lShaLrrJb3LXUcufgGCvRcQvppELEk?=
 =?us-ascii?Q?eXhH5WJiWBWcMFulX0+QsDicoJpC+jTvTUnn+09yyUtBu+fsGYaVibmpWmmT?=
 =?us-ascii?Q?lk3mISWv1lRBOhZIpixTd4A8oCNYqJ1N/KBfWt8Q9truU4vG2uBb/Kf59c13?=
 =?us-ascii?Q?i9ZqTKcUTlyVi0RNJ4uEVycQCOZ80nc2P6Y6zGUbTtopynUj+QUbAtF8qanY?=
 =?us-ascii?Q?RIDpfFB2oNc5kBoNIgwHVjJEKB7dUFExegvervLqmyY+tnaZVGe3NcXC6D5z?=
 =?us-ascii?Q?bX+abzzN3XuHxS39dXE2C6XMowjNJ4M5lJktlTwIumpw1ebcaAXDRQ+36scj?=
 =?us-ascii?Q?oKwZhtCeOSMZjqHlX4ciqJ29WevoB4PydJXvSIPTdLE3IhiGx5piUPVrf2TP?=
 =?us-ascii?Q?5HZWvYvgq/eJUpU5gUgbyoHTL6kcdapXjMuL1DIP0YZyi7D9yZtaKANMGsUf?=
 =?us-ascii?Q?AIEvAhAnpRl7YqKLsx6yRSku1YzzcRrFykpQKFwvlkyKgqJfGhqkgb+CE2qv?=
 =?us-ascii?Q?2DWtrZg/VSvdoo53aQRSs0e2gZVoUBEpCfK3JiGm76aNTuGbn9WGH4zRIT2F?=
 =?us-ascii?Q?NrJFgrvoVdswPyM6azgj7pDSC0bplz27aMHYsrC/oPjLXzT3iSzMdaW1mDiO?=
 =?us-ascii?Q?2y4JVykaKGknomwlh/6pSq2Cjr9KICYYKYAU5IYrnI6d/mkYc++yBBkvENU7?=
 =?us-ascii?Q?+PRVkLaFMLdsgkWFWZR5adOzyZXv0efH6Ax05KK80nRTTSSqIcUkGqiWzMAE?=
 =?us-ascii?Q?U0PDLvhaLu6kZGrFDmnjx/Qqd06k+MXkeH6CtF2T+ReLdb7Pdio1GCyjzhZA?=
 =?us-ascii?Q?qjhVgVqQjG0r+xBHc6xis8ymEKJ4SXk0A/JEMrmCoeJ1rKSo6Y2+8g/cWElh?=
 =?us-ascii?Q?ccaIsseWmaBsvvvVMPXU1rDEpSxM/MCOHNOb76Gvd9czs74lY1VxhqNRnJj5?=
 =?us-ascii?Q?fQvhTMEZ+9aQcrb1WrcUnYrHQlZq+zFLYJVfQ0jiOlCFwKjN6WhfUXlXDySb?=
 =?us-ascii?Q?bxbiUzhOr4oU/w/lB1BK0JY8+ZfyjGIF9CZNCpXyKc6bnI/c+y5ALAHG08KN?=
 =?us-ascii?Q?nmnIwkqkDiFYWq2JGU+DEtRhMcyqgORrUjdiajIL6jPMypWVbMw9q+2JQUuy?=
 =?us-ascii?Q?owjGC/Cqf3jL0vzjG3S9dmpanDVz51sXBV9RNwybfMKddZnb+LrFyNvjfegC?=
 =?us-ascii?Q?agWyBGsv3q80/Qh5QiZeduxnmQICRfyvMcHRYZMsX7uN/TQKLBJoTMpTMvDE?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 421326ae-f729-4bfd-1f44-08dd47c03887
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 21:41:46.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mco1o4ETAh6Y+Bsy/xOdtIVOHAdg5Ay6QW2D9PK2gkj/dg1kEy67Y5IcYXVypt/Jj8jQ59/dsc7+E0x1Y7O25MWt3e59WIRzlUOeguxYwDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8201
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> [
> Many people were away around the holiday period, but work is back in full
> swing now with Dave already at v3 on his CXL work over the past couple
> weeks. We are looking at a good chance of reaching this merge window. I
> will work out some shared branches with CXL and get it into linux-next
> once all three drivers can be assembled and reviews seem to be concluding.
> 
> There are couple open notes
>  - Greg was interested in a new name, but nobody offered any bikesheds

Here is a straw-bikeshed that I hope conveys the following sentiments:

- "This is the long tail interface for all the knobs and tunables that
   are past the knee of the curve of diminishing returns for a
   cross-vendor kernel-wrapped ABI." 

- "This interface is for non-primary functionality of the device. An OSV
   is free to disable this interface and your device will still fulfill
   all its primary objectives."

In that light, how about "auxctl"?

>  - I would like a co-maintainer

I expect someone from linux-cxl@ land to take you up on this, and I
assume you would not say no to more than 1 co-maintainer. ...stay
tuned.

