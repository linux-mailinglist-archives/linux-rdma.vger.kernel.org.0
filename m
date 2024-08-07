Return-Path: <linux-rdma+bounces-4224-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC14949C91
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 02:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801F61F22B33
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 00:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2557EDE;
	Wed,  7 Aug 2024 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Go9pdQRn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AEF372;
	Wed,  7 Aug 2024 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722989183; cv=fail; b=YbJMt3sY80xWHaFNmhr+o9bZ8CMBb+Jq7hbgeXkoX6KmIaA3He/Jb1WhLPJtR0JtKSUtLVzGksV/IsJA7S0CiA707JxDdO9b8kQtRw8igwn8b06qvBNFMcJQe4aUvyeA3RuqFtjctEMmVUuI5SqcLBgNd+JwQwMxr3P/GyE94YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722989183; c=relaxed/simple;
	bh=3AgOCRiMPsRiu71CQICESeFKV3gT8O0ie+CgM9EzsPo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mi1atnbx5tDdTdDHIg5rFskZekl+qlxV6VGeBGjIL727S4MNPI9VawFiDaLevEEcQ2UQ4ON4diNvEVd7srq1CcPZIRXFBgmipbPclP5WB/Gl4gQvHVeVtGXOdfDegxJ+1hMM/shpsyn89dE+tQUPysZIODHd7K/UjIe2FRLAT34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Go9pdQRn; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722989181; x=1754525181;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3AgOCRiMPsRiu71CQICESeFKV3gT8O0ie+CgM9EzsPo=;
  b=Go9pdQRnhBVNfHsIfnVbxYe8ZMCQTOiOkhmYs33ectJEq9PLaS1AHthA
   s3d8HOIIZjE2sFNR6myzkr9AHz35/aCa3rRrRU9eKeexJhurF2htGE1+w
   tI4xBxMKm5/Gn3h2Kp+3TlnDhNtImuPTjj+o1ckwei55iXhxTlBpEpNvM
   G1XgOsyKzkv3EuXYURIurptAgjAwaL60fadrK/2IJ4maimjIU2Luos9rb
   SLzdgluZhkqwwD9zop1hRqElzZhCIud4/loNi/Jr8yuZqiUorTNRZCPD2
   b3LK71bEMilpjr66vrcj9gicEQA3J6ufn5ntlWIVEclROmVYHVvgpf/Zu
   Q==;
X-CSE-ConnectionGUID: dsUa3TUbTiulsx/8HVsiww==
X-CSE-MsgGUID: N/ZRycqXQY+ogNxl/9vyOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="32441726"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="32441726"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 17:06:20 -0700
X-CSE-ConnectionGUID: pHbKLelkQzOBgEpezEM9mQ==
X-CSE-MsgGUID: UWKghPfPQMCCTDayLIF1Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="94239145"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 17:06:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 17:06:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 17:06:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 17:06:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlXeiiJ8/8Ed7OakX4wzFrs0F88x5RXsfDILSJcFgdZY3JUMb186MIjzHKB97dHhWPnttGEBd3rE/By2/SS7Hr+igJQN0pz5gzYVDI8mDqp5mP3qIU9FXkfsHcM362AkGKUhzxO3rt3eMEabN6yBJvAxTU8H49j1MPhL2pGHnfkaGTZz1uoi/aWBfj/aKWJuHjEoSBCl1Q4LaUn1q2O73C7a43+v37a5dEcPPMh3SmcafLjOYm+4TUzXVYMqDOvE0IR6+RLhaEJHOyRjEVrUSqFF4cOGRv7G2HnSdezh5RwgHVNSkZcLOAffxrKMhLxjFrb+Ewc7VWlOgaxbChP+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My2WiJFwat5i5D0D9k5H0oWj+Aa87p6NROqNyeEiYCU=;
 b=HQWVUUlUlQ6wssed1YQYWbFbhQ7aAjQNdo4vFb1Ce5040DO1o3fCRErcVIOkDdnoPsrDNsNL0jNevExaUAz5Wh7oQLxH0RylzAdCzNpzFUUVyBs2BAk0IEyn5u8jWXNyJP76rpUfo/tzXwGVL6HOYRDs1bVtdyWmuxp1flHge89thnf1enw/A53EPKzNbDahTlxuGGkvGjV5het8BiZJeEpIk2ZiKJlv1xiFXwJa9iq8pu4RW5pRuKyekoTaOmaUax8GogaQthsg6Uy7EYCQUlgc1wteUB4nq6lvrho1QOba7RffR89x8TzHBeSAm+T0ecWWBMA7UYC3kIOpcoewbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Wed, 7 Aug
 2024 00:06:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Wed, 7 Aug 2024
 00:06:11 +0000
Date: Tue, 6 Aug 2024 17:06:09 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, James Bottomley
	<James.Bottomley@hansenpartnership.com>
CC: Greg KH <gregkh@linuxfoundation.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Dan Williams <dan.j.williams@intel.com>,
	<ksummit@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <66b2ba7150128_c1448294fe@dwillia2-xfh.jf.intel.com.notmuch>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240726142731.GG28621@pendragon.ideasonboard.com>
 <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240728111826.GA30973@pendragon.ideasonboard.com>
 <2024072802-amendable-unwatched-e656@gregkh>
 <2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com>
 <2024072909-stopwatch-quartet-b65c@gregkh>
 <206bf94bb2eb7ca701ffff0d9d45e27a8b8caed3.camel@HansenPartnership.com>
 <20240801144149.GO3371438@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240801144149.GO3371438@nvidia.com>
X-ClientProxiedBy: PH8PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d485795-518c-4a20-2493-08dcb674bef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2gAgQ4gDM/RavYnPqIkknnDnPvxusenM1hln87IG99iK/gXQYzvxElvabVn6?=
 =?us-ascii?Q?TTlq6wYqfaQnH7QCrztiIBy7Ck2XSnfslpvQ84Vz9Cr9aRWgi5Wjjm4a+Wgk?=
 =?us-ascii?Q?ae/PRgsh0vfgUeFvKuYfzAlDaeuGCr/OjRHk/9XCHKwW15QjwzYmSlgUOHvO?=
 =?us-ascii?Q?99W7Bl2qKz+VzVHP7cxm/YWJZr/V80c33Px9MkCBOPWdHmOMBN/xkHNHyZuW?=
 =?us-ascii?Q?GmE380bLN4cxStmI85PXWQrDZ7v6IQ7MnF2UbjJwm2JMPaOZNpmgEVplUsUd?=
 =?us-ascii?Q?IzHupyvAkcKG4SMJqRf07PRVQEBx/vfZkkTyQz/N5zpm9ER1WmdxKJ1lYgjf?=
 =?us-ascii?Q?QaXYQz9fXloRwyCLa8epfFxsLZoBW7rU/1l4DyOIMxzbYi/TvQgWslHK8IGY?=
 =?us-ascii?Q?dOtIOTw8R3rwoGwAx5EmILvm19QNhpqgprj1bUQUxWYZ0mYFJ/FGaO6Aoehs?=
 =?us-ascii?Q?rc0hv0EcahxC1P6B2Np1xxIpmRh6RgwIbdkvlKCD3Hdzd+rm4q6xVLTA5wfX?=
 =?us-ascii?Q?5ltEcjMK94f+dHkw4JKAAB1/+VDXR/MY8zc/5UDvlYto1kvMQiRQer0XKwen?=
 =?us-ascii?Q?bLI3sTKHAktW/h3yxtbkggxY3dKAl0CRki5i7twRDyCjj6Xy6zLwfQzeSjgw?=
 =?us-ascii?Q?fbzEtBu618tgWXeHD0ODZ2yJS0Q0lvxPlM8nurUsdk2XeMJ4TCqCZA/Pk4OK?=
 =?us-ascii?Q?fOzg5ZNTC73dp9NSJOF5+meYvD7MhVnKJENcJkXTYXbwRys2PhCbMqoaGcRm?=
 =?us-ascii?Q?mxiN2/S39ue5fHQF7DO8ucrtgnmwTIIn/tC6AEymuV5knC4cqaO7hHdR2mIX?=
 =?us-ascii?Q?58Fo2giKREKN1GEuwWMzpOEl8kd8fRnwaMPNj4e5ZOy4q626wMRp1S+tAraU?=
 =?us-ascii?Q?r3bjfCD09Xdazemd6ybuKZJuXe9r6Y6e3DQqn0Z8R1QdWlFRPqqlQ4e478UL?=
 =?us-ascii?Q?sP9W5mkZ1nA2HQzz3uMWgkp+bqqKcvUXIfk38yH+3W2TVUjPgLrdqaqQXgbw?=
 =?us-ascii?Q?tpbkzYq9c68zK/+orcb40+01EL66cWb1PxIzeu88uuvzkfaW2KTJ7uR7aUzS?=
 =?us-ascii?Q?kMkA4Tx5jbECTndjhVl+rNpYeSfLv2wImIWcWszswHwAropGbsggqhEbUWTG?=
 =?us-ascii?Q?TIRBdIw2Er58wx7Tz14jtl/APT4MqD2bR2S3a5S6pw4zEw66Yd3H8oCZPD9d?=
 =?us-ascii?Q?HocpxTISwvCqbPIZIN8GIhrVJ7Y17Km/I2Ouz0xfAsObxKxz+lz4dLOAzUBS?=
 =?us-ascii?Q?sMGEAKCFYv3mxtupVDJ+utiixfCoHAim1hF7VwpYRJBaci3IwcqncKZlxI+x?=
 =?us-ascii?Q?ApG1XTISaZQNTJukgFKCE0iYUL+bbekkc2Upcoi1E7cxAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ScidiGo4EBTRupyi3rMA7dKSDIxZPKESi9s6Ahj64WG1zKz2ikyAlrwYv6vS?=
 =?us-ascii?Q?H6dxgxX4gfM2DppIoYqa3cNIYzxGE+fxq89DYqvXmOAehcQlVb9rovCgWs8o?=
 =?us-ascii?Q?6NCDxAM7pXMnC15eW8Y8umJWGiNNtND2HcouuH/KkDOp1SuK23jYl+aI472n?=
 =?us-ascii?Q?c3MKO4IMme8YcMvmiMnUPDJ/Yel8Tj0aeY9c3QPHBReBRkQ8zDUkfakJFOQN?=
 =?us-ascii?Q?4+6I7jGWtvI/8KSazj83oVDENOhpJ5TmqjmvJufGdf67YGWmDcHX7W9rBObD?=
 =?us-ascii?Q?lLZlgH1lLgpc6nHL0gJCZsvaBIFu9O6Pp4KV7xX80amPNTMNXU8dedlqJ1Tm?=
 =?us-ascii?Q?gj85ZPdw+wfGKVdssWLJT8YBaXtafugrXo8G/Ut24ZEp0hgH4jN/CCQTP+mF?=
 =?us-ascii?Q?3EfWt2RezxLqGud05Eylpxno+5YB8v3EYvvJbfyKd+38Tri2ShdmDQvYHvqa?=
 =?us-ascii?Q?zyT4wBq3Rd5xK60mUT6ox+lC1RzxtwzyVcDonDSbQXgPvgAuk4Q3gSxpXBqr?=
 =?us-ascii?Q?oxesS3K7OMQmnslRt/j1bsNwqITY6e1ylJFX8Eu1b3dEyRj+xSy/lxFq+/nw?=
 =?us-ascii?Q?dvwn+uYXzusV8AXyDiG2C2fiaJOqyvy3muwfLJ+TPTUi7iaDYOAXUrCtwwHX?=
 =?us-ascii?Q?bttKFrF/6FYi4E2oM630bH7Xai60+CTneODE8xe5iEINouLdOo6qeUjA5POO?=
 =?us-ascii?Q?xDVn96zE+1yCeCEwCPLLLzueaSZwuVbhGr4/ET4iR6+Wxsqf3zeTP5XIHrio?=
 =?us-ascii?Q?QoQ869oSDYTSwiSn4wkNN5JRLGye0gvyhvBZzi5n5eTpUAY4/Fvh/S452oKZ?=
 =?us-ascii?Q?GBV05pLBCOIRcZoy/LsnxinLrYPXmHGZ3/8byeGmTR3kCoB0hKfE/KfzBhsm?=
 =?us-ascii?Q?6Nu5E1s90RkUj8UUBHyc2VZccFQGtBSTg6ECGrEN81SdLt7XFcLNumMvuMJe?=
 =?us-ascii?Q?0JB6T+nUxPl2k//PkFZWclPU2xw8YIO6gpHQe3V5MMsURG8BdDLFptfBuYOW?=
 =?us-ascii?Q?6vypQKDKryCH4nXrspTGfp7kap00i0hJYk3k+jLhMisQwJ8SJJTEXN7KuImE?=
 =?us-ascii?Q?Gx88AQEMDn918Ale8scekQ0znhTIaC879NLSRPSegLf91SwnjT/+rN3d4mFl?=
 =?us-ascii?Q?E+J8zeqOYXbLm734fLehTmxaPJFQarkQMbIa+tKsBzmEzQV396z95M/pLQjj?=
 =?us-ascii?Q?iNHLzLO73vMbg2BGmEYDLvEmWlnTJO8Rk6/1zZNeSUjZXODj6qvwXxeeNjHh?=
 =?us-ascii?Q?IAPKG9CHADLJAsE9HhxGB/98BY5LJZpKa96fDBFPFauHEtt7Drq1we53+0jC?=
 =?us-ascii?Q?NrK0AV+KlMOgP5HN4T5UktGtqp/J1z0KT9zCmYSEpTX/xZuhpxXspRSxw4ov?=
 =?us-ascii?Q?7v/tNuX7tUe0VWyrj5ID+J65N0X5UGpQGi5C4YbAF02PzESz4CT6iG8IkOxh?=
 =?us-ascii?Q?cfNGDl+CsJo3kTSCLMuX0UM33D5S4iy22JK5KgeUglHEBGaue9VeOOm68p7s?=
 =?us-ascii?Q?JEnidCuK02rM+RYOeiUsssbgyyF2tNdUNPN5PZVEFuirgnUyjAM8x6Oj8rd7?=
 =?us-ascii?Q?rYLyYONSN38ymSpjhlIV6Y/5A4H55uQUWlA6+vGPnFjvzxy89dnjgeRlEY6U?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d485795-518c-4a20-2493-08dcb674bef6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 00:06:11.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlRWJPjG/DDGEjTz7Pz3Squjx3cx01DttP63CAdLkgAftqhIPQza+B2qUYBSegeV762fKEnhn7gxu/RsB0aCjh4GFPOvlWfkT7292ZtN2BA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Wed, Jul 31, 2024 at 08:33:36AM -0400, James Bottomley wrote:
> 
> > For the specific issue of discussing fwctl, the Plumbers session would
> > be better because it can likely gather all interested parties.
> 
> Keep in mind fwctl is already at the end of a long journey of
> conference discussions and talks spanning 3 years back now. It now
> represents the generalized consensus between multiple driver
> maintainers for at least one side of the debate.
> 
> There was also a fwctl presentation at netdev conf a few weeks ago.
> 
> In as far as the cross-subsystem NAK, I don't expect more discussion
> to result in any change to people's opinions. RDMA side will continue
> to want access to the shared device FW, and netdev side will continue
> to want to deny access to the shared device FW.

As I mentioned before, this is what I hoped to mediate. The on-list
discussion has seem to hit a deficit of trust roadblock, not a deficit
of technical merit.

All I can say is the discussion is worth a try. With respect to a
precedent for a stalemate moving forward, I point to the MGLRU example.
That proposal had all of the technical merit on the list, but was not
making any clear progress to being merged. It was interesting to watch
that all thaw in real time at LSF/MM (2022) where in person
collaboration yielded strategy concessions, and mutual understanding
that email was never going to produce.

