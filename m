Return-Path: <linux-rdma+bounces-2927-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEB88FDDF4
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 06:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC211C23B09
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 04:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6183E381C2;
	Thu,  6 Jun 2024 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWwQhZeL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D9E1EB3E;
	Thu,  6 Jun 2024 04:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649784; cv=fail; b=S/0qzNG8JaxfzdcRYO+wtba7hdPhONpGif+cJjWTr7fB/mFvyiJ5+ZpzkhhblUb+bUVHPODR0s9epX1fWc5JS5efLCyjygE6LmEoH4QFmPuYE+g93vMhDWbP1XlkBBeOinYHB+BEMWK5whlDbeAscolZGKwRXmd+lHcuiF7QKCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649784; c=relaxed/simple;
	bh=P1+LYDtF3jm+rZiK+7oCVg328nlx5VY4VG++9AOM/14=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zwc7Iu94fd6PkVGOpUmLGZp5AndN9bPstu4K6NTfcLguZKKAvnkPTTEwLFICyBn88//DiXvzdnwoWEkMRCaqyhLrbds0fBMhYymSZbFBvG2I5veenFmUkTf6JX1rHkRuVe1Bc2u5RS4ovVZLYg9A66mHb+/qP9JYS41jbkuDhFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWwQhZeL; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717649782; x=1749185782;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P1+LYDtF3jm+rZiK+7oCVg328nlx5VY4VG++9AOM/14=;
  b=nWwQhZeLfvpSLXeJewbAkVzyY+JPI8D1yTITnTR/TBf5KxOm124CLXbe
   CN6WSI4+PpC8WsRCMkX2BkGOM/Hvh5pXnPYFTv74/9n/o5VX4HVQ645RJ
   YeVSPAYE2QH9E4aMUrYmdSK3DaoI4e7ZhwrgQ83WI053AfGdp7PY2BXon
   P5zv0DIbfAqYufdYf4DRcq7PL50yBng1iRaJqK3A4IqxuPU7PpK7ed+/H
   PIso0eusNeUAjvcylQFqCWJWcTDpSTwT+EJ0xrmGrkeKHie6skTdJ8eIX
   4ZQihBGaVIRWfYdycfYz0e+zT2/yM1iKShjhddFxw0iAja6a/rrR6fD85
   g==;
X-CSE-ConnectionGUID: OZflfffGQVyB039huu+g8A==
X-CSE-MsgGUID: p/vok/0JQFyZ7Wf57Z2PIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14518103"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14518103"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 21:56:21 -0700
X-CSE-ConnectionGUID: /PbfVjO0SuysmjON/3cm7A==
X-CSE-MsgGUID: ysecXo+cTmqdgXuTv+6k8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="75310444"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 21:56:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 21:56:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 21:56:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 21:56:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 21:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNqJfL0waewhg+f5+yUYYtnnJckX6vv4s6k9zWQF2wsy2jha9pBr+Tl4fpfP7IIub3XwVHrRNV8yud6c7r6mBnq5DKnMMsJ1svEQOqO/UdYMlSqRE8G0EJE2IKf49oDA56Ih6O6jf1LGG8dzCgW/Si7FgLgZzaZQu3V6/xWV53Hv+isaPUptXbmjPriC0nQDSlfVNS+PZge95xnfVCrs/capA2rr82ZPV2RGbCQ2sYwMDAlzW8YkEeTUwkc1UyAmSQ5JMEKFByY0LymXAP8YHKI4wk+Jjqt6Ir81Z/6gX1ed/rkQyt9x0bhSUzqkgKiyqDC9O8dqw3PMPR6lwnV6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKWgrbe1G8eQZtaKz0boYxGwFZcBrLzdSNjBiKP9R+U=;
 b=hJQghwPKfjK6faucIwglmiZYl+9S6mv1jivuuJwG2yloIxIxpWdaiZObWfvYPF4QrLVsf9SydqbC4ULzH4BDex/th7iRkKc78RwuGAneirLeNfBqT8JiNILCttD8p3uo2elyO0SngtEqdrJpyI1Pt8SgfnK8wKSGo4AczjGrtGR/qijAvHenwHh7W9qRbNzypmBd/GE+HdNXc0NLGiBTeCkQndrMa2Pmuh3fPNN0tR3gnU2k92tWQZRkdigqjdBdCVRmZo6uEXgsTvJ2sbZttHCHccimkK/1pSUmb9v8V9c+jDdo8PX34r4sfCrxnKggeIwje5q00O/BqxdmLaGpcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6971.namprd11.prod.outlook.com (2603:10b6:806:2ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Thu, 6 Jun
 2024 04:56:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 04:56:18 +0000
Date: Wed, 5 Jun 2024 21:56:14 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, "Aron
 Silverton" <aron.silverton@oracle.com>, Christoph Hellwig
	<hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
	<lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <6661416ed4334_2d412294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240605135911.GT19897@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0390.namprd04.prod.outlook.com
 (2603:10b6:303:81::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e2e001-b7ca-42c1-0707-08dc85e50069
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EjmiC5S2nkfabNB2EFONha40ir8sCe0rb7YCQ/PLzYRZGC7YzSHooIn1/3ot?=
 =?us-ascii?Q?WcDSmVh/Cyz0rIOhCIoNFEoBWWkZxsdwYqyg2u3zvjp3K15FYo2WfRX0Bf9i?=
 =?us-ascii?Q?GNIUd2of/r+QfkO6NUycyutzzKZE+XfzsPN3lFngGI7Is2g03aMhXfPX9o/E?=
 =?us-ascii?Q?+qqEcwuHhGySzPBb2u2msKZvBdxv/kPEzyVCKcBC+K1l/UGRmtA0np8+qPuX?=
 =?us-ascii?Q?Po4+2hEnws8dhkYjGxpgwFgHqh9Rk9rUSg6KUjsG9x3SX5QFKZw4YaKChnAQ?=
 =?us-ascii?Q?OxJggxaDkcQ2hkTe2xLRll+Mp+2AcuMCsxF5sXcp13ynMWkMqOSKrvozbSfO?=
 =?us-ascii?Q?v8VpGMTwupm7JIIIG+STg0InlfD/8FqeyCsTeL6LQdqJKa3BYTrdVpLoyKrl?=
 =?us-ascii?Q?cyPX/9BjvZxPTlGPXSI2RbMH4P25nOl2+HgzeMziw0PlgaB8MfRiKUF1mdKo?=
 =?us-ascii?Q?JD3XihN0GU6MmAbBj4Cdy+1rj+aQzlK3EdBYHIWbgf9bnm79m/swRfGDPxti?=
 =?us-ascii?Q?dTVNZkZ4rTCGUCqB1X0E1Z4R0kaLBkc54rKN3XbCnN5gVnu0igCSa7Falq1o?=
 =?us-ascii?Q?pOJFaG0Bg7HEexHN3nN2quPk6G/wN22HLECl32fIctaCSb/DAj83Kww3QUbE?=
 =?us-ascii?Q?uWZEjRdQh2Rj6xB4mOfQJ5b0sATJRG+v6fy37RQDHmVQCg1Y3meIuN4OJb/5?=
 =?us-ascii?Q?ZQIxQVZtZi+kxBpzT7j+KJmXEWYWBdsQe1I8KOxHqO0kEYVmJ+2nSuX2629K?=
 =?us-ascii?Q?dkLJv7wX8eamrxBWLuHJ3pKIr4abY7MDXfBMNYH99MGSUNqtdk6DhLh/WWkx?=
 =?us-ascii?Q?w1MtlLxK6N7i8USIvAm/L7zzm+qSGPi5SEn+/KJ0vFoC6AfmSqlbHsJTmSNU?=
 =?us-ascii?Q?/U4QNJ0lLsPAa9rlmg70SKAh+aBwNmCCQcED1zZCRiuIqsBYjx5N/GfVj5e4?=
 =?us-ascii?Q?hvuuej4th2hkAZif4zzqbyPY3s3nWkW/7XSKRzPnFmA0HurH0Xnh1X0DaJ3P?=
 =?us-ascii?Q?hfahkambF1cni1Myj40w8EDvJ72TwrkZdn5WfWvVXwRaBW7At2tcxPr3mTuS?=
 =?us-ascii?Q?wwJIqo+bGEUdYfte2EFbqyv9WKWu8dXqDSwxeOEiy3Y5p5p6MOiUfTUxaG9+?=
 =?us-ascii?Q?sqXIKlwI3OQHs7Xfp1ocbeiEXyOvLUGPrHFEUfPj4hpeHLupRQ+yMxZBPCWm?=
 =?us-ascii?Q?Kf/m8TWf7zgHS7kkgjFUjmAWs8dZaVYCPN5mw0dhgR4okXNOQ0jstXtDmBmP?=
 =?us-ascii?Q?QgsIbfmgtb0/FUWoNZa1iNdH9r8duShZHwUh0siP365BS25Sd452NVwra0eC?=
 =?us-ascii?Q?Rh3PO3sD9an3ySz1PxhiVjWg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dn/eIqPuEd8wyV92ZBl2bnJOBLAuUUm4mQOHY2wMq/6m47/MTilwbtstIypO?=
 =?us-ascii?Q?5DNaGwfxYaOclT3l1yxF8yzFpH57J8PSQe4IO1Vk8KhkqNLGwSbWemWfSL/4?=
 =?us-ascii?Q?VG9bMhrw3b8kwfLKuyw0J0oeiiNLvpcE8ehUk8J5zU7NpL5IwNFR5YECHTRF?=
 =?us-ascii?Q?QGKf8Y1qFcPChzikTEu58mDpu4ExxJ9zjC8flHiguCmkJzvDrG8uJyb9Sz2r?=
 =?us-ascii?Q?adNqVNtem6BfyjYX95aty0pTxKvwcaP8jX17FQMvecnBEJbp8Ep+8DmQ1qVw?=
 =?us-ascii?Q?6U+TbzLmCG/T0wHBGom9iHYf8Ee1tgb03F2I8MZt5K2j6x1+6KqLb03bscc3?=
 =?us-ascii?Q?H+UenT3dSQRxLTEQjUzE342+qwwG+CN6xgKshWuizuROmpFsmmbGXY4EBuhE?=
 =?us-ascii?Q?K7GvUPaMOk1+hr3QSHaAEuuAZtiTTinmoBoG8NffaBsbgWJyU4096gQv88ub?=
 =?us-ascii?Q?f96wOT4ZUFgHAIiWzWC/6MoJBayBIREhLiuV/6UAQKfY1DpJCo0pj6heOKK8?=
 =?us-ascii?Q?1H/heONTvffXoOoe05jb7dn/sfV8fyhBTrpvzxKpeU5I78kU2l8xJ6BdGYTm?=
 =?us-ascii?Q?vlgTO6jMm+WwiRYsf35BJW+OJ7h7iXJLZ0tPGmfAlKKToojGHK9EDmf2h+8o?=
 =?us-ascii?Q?5TaFFNsSPy9dOCjqkExwaC9wxbDuq9g3jgxw5cP1WrYEOPT/46mT7WWiT9I9?=
 =?us-ascii?Q?CRUi2pv1aCBz0/t+y3zkEY6zG4TCH5zJE/u24ohUySwbSfZgMFzFY3eWk1s1?=
 =?us-ascii?Q?739UM/4mQW+fUif6PrJqAEG3yiwgv4TSibgPs/HFWB2aEqqNjve//o8njhk0?=
 =?us-ascii?Q?8CwG2fU2VroHbg6tE2UxTET3aZoUAU4QDosfOuK154AT6n2lvssbA1P14ha4?=
 =?us-ascii?Q?4Qlr5M2Tmr/PaV+ktSoYp1OZd2iHcvD2ZNmzyqn5MX8m7dPBnUkY83baPb6M?=
 =?us-ascii?Q?4p45yp+urAQf42h7haG8CuM4Ue3p6bYyh6SUpNbW/37Aj9PYLnLaPm9QiYht?=
 =?us-ascii?Q?JEA8o1m4v2m6ObbhxpHE4jnGrqmdPX63Ae1lKz+XF83eXN10xeBZxAgLGhMW?=
 =?us-ascii?Q?U7LHTHY1gdhr84EjvB1dvSpqsEJFl2MpxtpRMC0ASf8jTaFII4Gqq47GDOHB?=
 =?us-ascii?Q?RSBA44YQnslgg0doddFCE02wn8oXCxqiXdMcfQd3VPvQgpthMSHjxa0oWDBp?=
 =?us-ascii?Q?AyfYrQPBi6yv6uLsN0h9wivUAEXGPyS7akyjYL61a2G89plpLUmx3UCdQfzl?=
 =?us-ascii?Q?RamuyPnMyFLKSlIrfGl+HEgWbgPK/y+HguFzgEwlajcaw6fv3cXMLk3ShDsz?=
 =?us-ascii?Q?g1PhcDTyf5ozrBeOm6F9olMydVQJcTxdbTS+EaQB9KugV9jIxFaHYpHUA7/7?=
 =?us-ascii?Q?veUgSL5gJ5KjoEeXHe357vUICEKflBuRFEZw9rVgVBBOqPAYCzAj1rlW4Pcc?=
 =?us-ascii?Q?r+nAq3GPLgYPJnCsrBnwhm52p3Kc4Y4JT4M6UtIonf3yWVh7muODqbQpNILQ?=
 =?us-ascii?Q?aYiIYLXg+HxU56qZnNXbVJAvgVaZDqCKa9SygXM+I1ub1+l8ymrrWknnw0DL?=
 =?us-ascii?Q?5/PzU4o5Pb5v6EotWhHbFkxRGJluDc+IL5MFivDlox4chjwq2l1gqKGIYjeT?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e2e001-b7ca-42c1-0707-08dc85e50069
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 04:56:18.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mr+JXgoIcRzlkfBcq6poRB2g0oqzBFY6zbEUOYR70NF640P4AueKBrjrZO0GkqUDNeglA5fHk7vtekGTeNnBTQ1CFvmsJWq55MlysePFNEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6971
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
[..]
> > 3 years on from that recommendation it seems no vendor has even needed
> > that level of distribution help. I.e. checking a few distro kernels
> > (Fedora, openSUSE) shows no uptake for CONFIG_CXL_MEM_RAW_COMMANDS=y in
> > their debug builds. I can only assume that locally compiled custom
> > kernel binaries are filling the need.
> 
> My strong advice would be to be careful about this. Android-ism where
> nobody runs the upstream kernel is a real thing. For something
> emerging like CXL there is a real risk that the hyperscale folks will
> go off and do their own OOT stuff and in-tree CXL will be something
> usuable but inferior. I've seen this happen enough times..

Hence my openness to considering fwctl...

> If people come and say we need X and the maintainer says no, they
> don't just give up and stop doing X, the go and do X anyhow out of
> tree. This has become especially true now that the center of business
> activity in server-Linux is driven by the hyperscale crowd that don't
> care much about upstream.

"...don't care much about upstream...". This could be a whole separate
thread unto itself.

> Linux maintainer's don't actually have the power to force the industry
> to do things, though people do keep trying.. Maintainers can only
> lead, and productive leading is not done with a NO.
> 
> You will start to see this pain in maybe 5-10 years if CXL starts to
> be something deployed in an enterprise RedHat/Dell/etc sort of
> environment. Then that missing X becomes a critical issue because it
> turns out the hyperscale folks long since figured out it is really
> important but didn't do anything to enable it upstream.

This matches other feedback I have heard recently. Yes, distros hate
contending with every vendor's userspace toolkit, that was the original
distro feedback motivating CONFIG_CXL_MEM_RAW_COMMANDS to have a poison
pill of WARN() on use. However, allowing more vendor commands is more
preferable than contending with vendor out-of-tree drivers that likely
help keep the enterprise-distro-kernel stable-ABI train rolling. In
other words, legalize it in order to centrally regulate it.

[..]
> This is my effort here. If we document the expectations there is a
> much better chance that a standard body or device manufacturer can
> implement their interfaces in a way that works with the OS. There is a
> much higher chance they will attract CVEs and be forced to fix it if
> the security expectations are clearly laid out. You had a good
> observation in one of those links about how they are not OS
> people. Let's help them do better.
> 
> Shunt the less robust stuff to fwctl and then people can also make
> their own security choices, don't enable or load the fwctl modules and
> you get more protection. It is closer to your
> CONFIG_CXL_MEM_RAW_COMMANDS=y but at runtime.
> 
> I think I captured most of your commentary below here in patch 6.

I will take a look...

> >   Effects Log". In that "trust Command Effects" scenario the kernel still
> >   has no idea what the command is actually doing, but it can at least
> >   assert that the device does not claim that the command changes the
> >   contents of system-memory. Now, you might say, "the device can just
> >   lie", but that betrays a conceit of the kernel restriction. A device
> >   could lie that a Linux wrapped command when passed certain payloads does
> >   not in turn proxy to a restricted command.
> 
> Yeah, we have to trust the device. If the device is hostile toward the
> OS then there are already big problems. We need to allow for
> unintentional defects in the devices, but we don't need to be
> paranoid.
> 
> IMHO a command effects report, in conjunction with a robust OS centric
> defintion is something we can trust in.

So this is where I want to start and see if we can bridge the trust gap.

I am warming to your assertion that there is a wide array of
vendor-specific configuration and debug that are not an efficient use of
upstream's time to wrap in a shared Linux ABI. I want to explore fwctl
for CXL for that use case, I personally don't want to marshal a Linux
command to each vendor's slightly different backend CXL toggles.

At the same time, I also agree with the contention that a "do anything
you want and get away with it" tunnel invites shenanigans from folks
that may not care about the long term health of the Linux kernel vs
their short term interests. That it is difficult to unring the bell once
a tunnel is in place. While subsystems will rightly take different
stances to fwctl policy, that lack of one-size-fits all seems not
sufficient reason to keep the concept out of the kernel entirely.

I appreciate that you crafted this interface with an eye towards making
it unsuitable for data-path operations.

So my questions to try to understand the specific sticking points more
are:

1/ Can you think of a Command Effect that the device could enumerate to
address the specific shenanigan's that netdev is worried about? In other
words if every command a device enables has the stated effect of
"Configuration Change after Reset" does that cut out a significant
portion of the concern? Make this a debate on finer grained effects not
coarse grained binary decision on whether fwctl should move forward at
all.

2/ About the "what if the device lies?" question. We can't revert code
that used to work, but we can definitely work with enterprise distros to
turn off fwctl where there is concern it may lead or is leading to
shenanigans. So, document what each subsystem's stance towards fwctl is,
like maybe a distro only wants fwctl to front publicly documented vendor
commands, or maybe private vendor commands ok, but only with a
constrained set of Command Effects (I potentially see CXL here). A
distro should know what they are opting into for each fwctl instance, it
likely will always need to be subsystem specific policy. A distro can
also decide lockdown policy based on Command Effects above and beyond
the ones that clearly state they allow the device to modify the running
kernel.

