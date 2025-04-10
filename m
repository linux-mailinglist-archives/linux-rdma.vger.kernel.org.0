Return-Path: <linux-rdma+bounces-9328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E475BA841E5
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 13:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB92F9E619A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FE32836A5;
	Thu, 10 Apr 2025 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXhjzKxf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6E2036F3;
	Thu, 10 Apr 2025 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285146; cv=fail; b=GvfWtmrsTBxrGHpaUZpNHp+rVTW1GJNl2rnuq9EXGE63m6NKMZM/SIOgJi5rp1r+jemiVyRNxV60aXvIMaHZGQLtXqHcy/znKrtu8w5eacU7fEbltx6YkVhuK11C3gyZZDjWpynASSj0m9deEycxVecx1ZoGBL9hNJbOecasfwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285146; c=relaxed/simple;
	bh=QJpY99YGWkRgfD9cpG/DuhU6gVhEKnA3KUwZ4jDK+BU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hi2E8YaFIxp3TylWT0UHjgFVVFHGfmeUjGN7D7iCD//Zkbc8ZykGGbdPOuXqJwB+kcOutln5JmaQGcyWqt0SAnA1PdrnnegzChUkzmm7NGKiQTWDaj1mEB6a7hTZLZrlaNwMk0x54TuOhV6bjm1/XKSK9z4R1Es4lsjQn5qdMrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXhjzKxf; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744285144; x=1775821144;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QJpY99YGWkRgfD9cpG/DuhU6gVhEKnA3KUwZ4jDK+BU=;
  b=QXhjzKxfqLWxGgU3jjRi1r68bDmVXnGv+sXy8DuFIe8Vh/YvadjNl22b
   PinDUa1pD1du4ver9dI7vSCG4VA16Rb5bk1lXVaBAL5omcEn9u2VQ97BO
   Yn6jH/mVIJT6pRhXQfDwKObpvR8KgbKbtVhzcqcLvsl8fn26wqsZmnXAC
   mVE+ma1DCCMay1lMTszgNmAE0tTF3S5hblvNoDM/RQ2di2Px9IreHpwYa
   rZtBrGVh0gJ9d1NEu73QiL/rHtpdqbqzT4Kf5ESI4kGO1Z8B7hQTV66wb
   vWy4D/EjI/cnZZE9FKqFxFQoZn+HnQI+GK27avJt0zikei+mbVSp/ca/H
   A==;
X-CSE-ConnectionGUID: D9QnTTZvQDmgHRt11Ad8PA==
X-CSE-MsgGUID: /m1qpnBfTXm4riQcBnmh2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45686881"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45686881"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 04:39:03 -0700
X-CSE-ConnectionGUID: GLPu3fSrTUelW6e3y1TC/g==
X-CSE-MsgGUID: ppUmCwytSHOYUkXcUFrkSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="128620974"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 04:39:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 04:39:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 04:39:03 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 04:39:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SO1fmdgVzP798KFkEm7bTcW3A1k5wPXN3riww7vVeoi97AXN5nS/eVhuc6PEF+rMNOAZ9xqPgZCpB/sVV9rfBKOtWYEoppZ57qFr08Mo9SLgvVFfvUXeCynG6Ce44QYtyMn49GBXpas3KNYI8M9GYrWV7r3e8lBxLIZFDSKAbs6B38DsxUqXan693Y/le1UcMTAmOmRH5FobY1Kdhnm1l9+ti6XXtZEHjVhpJ02q4OrwzkYDZF1S5OyZnbWJERFCQCeCK6NrBogD1lNnBtHQ3YzHV9u7eUz3hNZaupTaG1PPgj2si7LyWIsGoUvVGkqu3iWzsc4l+0NhrJAvTLvsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL3zgoL1ycJmMxSNbLeXGCXtmm+tknyWkJukj+BsKMU=;
 b=yUaNh+0LqcpT1lqg401UaZc3cAjAdHeU53Ht4DXVIQ6KOw82pOmV7Wt6dQl3klJsejboYX6Ko0oZCYGKQ4RsJvn4cnL5Qy8qIYlwbXNhkETjw5av2R+wcbWqrs8s+YS7eEnDlkSOt3kvEmUagS8fGAe2IFaVOVeCVk1G8EE794hgJ7jmvQuq8Pwqs+sKtyZBJz49bjtAgt4f8ZRqx/1aOYMGAI0VkTTg/Q8sXYNyVKhyc3037L0bD0hcpiIezzz1vCfwJSrM6iy5gbGXStRPNtC9PYJY80S5HTPpWhoncD5her21b8OJOAtZvWgzVDOB2TunfQr1apOdwf1kcl9cMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.22; Thu, 10 Apr 2025 11:38:54 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 11:38:53 +0000
Date: Thu, 10 Apr 2025 13:38:42 +0200
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
Subject: Re: [PATCH net-next 06/12] net/mlx5: HWS, Add fullness tracking to
 pool
Message-ID: <Z/etwjHhvokpPCUN@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-7-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744120856-341328-7-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: DUZPR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::12) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DM6PR11MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a156abf-21dd-495d-db64-08dd7824457e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aKQg0Xjr+v7NgpOp0E2rEyWncv7ATvX6Q1hRzRBTF5ycoyZ5lQJhBAtskCCg?=
 =?us-ascii?Q?Z7zVNIOX93dVhc7P29IcxQN2JgOfxjihc0seYb3AAAPLkrGbeJ/bb4I2ZgKN?=
 =?us-ascii?Q?J8nyaBKsmbSam/Pd78DkuWf6uOsXt8LAZ5SZxf6+OjxuHgTrkRXBOV44PgUB?=
 =?us-ascii?Q?GrJZYTG9yLtOCY0kYm1GIrpPRSwQZ0ovwn+TRmdw1TKPG3eyaPpp8Gh27BAd?=
 =?us-ascii?Q?U15XZGh5z6LL8Q/8jM73Lh0KYhPVoRD5Oabx3k+5I65fn8DqpjVjuAuZ3gxT?=
 =?us-ascii?Q?jUW7lxkitoITgsIljvQTd6WZncdiZ8gkOZLdzaWKSAAWyrFL5kw01Xm0Cvz3?=
 =?us-ascii?Q?MFG9ohrsJTMwjf9CkdVCclPQOvU9HkgLwFPdDp9abEOdE3U4083sNt/ktGEe?=
 =?us-ascii?Q?Wo7MG4NsfMVt82xyK0+0ivzvsu9gkcLoEz7O8SxddOZIBSLTJ7XJe0eU5P+m?=
 =?us-ascii?Q?mWE2d7Doeq0dlyfetb3Lx9bnAAcYENm4DRc6WMPguCWgLOU4nBSr3AOsKfOJ?=
 =?us-ascii?Q?OGpWA2eHrfiXxeliT/nkDc1HOcIlrjqPnAPREO4zxaWNgGNMNP2Qqe5GWTME?=
 =?us-ascii?Q?l6S2mqYdBQ8chVqiH1awaMmxNegxyhY6VlWHdqSdV/FBiDnVZnLuFUg4Dq5o?=
 =?us-ascii?Q?UG9rgrKTtKnEem24EMGe8abrbf0Ru13xE72qh67PeXlK8daqxc5iPYyL4IG6?=
 =?us-ascii?Q?s288XVxNHteQS5u6YcCu8ONFgrbsUMD5SfGLUN9tURQ6OGzls5zgPwNobHS1?=
 =?us-ascii?Q?vvoZrdBf3fx22aYs//ZE+f+bDCHKUFJIdU4W53jKk6yiinwe+m0H2iUGI3Th?=
 =?us-ascii?Q?yE8MiYFzYoWsqKHyil7QtAusKU6ueKnvn9aA32CDW8FJmdPfK/9M+n+nYTN3?=
 =?us-ascii?Q?QxfOfmI0dW440ABTM/uKwbk+PzrEJthbDP1heYXUjsBk6aZGoFQWEI8+awKs?=
 =?us-ascii?Q?SVYP8tENBMMou5vDrGYThiFSsyN84HxappTc4EwyuK/cJlb/hOav9QiZjhsP?=
 =?us-ascii?Q?k0mjjnSogEYop3cuZvnGYaE7c0/simSbDe+r5n4wGUkV1wU9/pPOOn/1xmgP?=
 =?us-ascii?Q?pB0Lk68GDh+FPvXJBtHgEpDXXgxD9vBN0kVmuRj11+75+GosY9DZ3uPt4WOv?=
 =?us-ascii?Q?6xlhOM0jV76kUQHTLT5fsZoU7Wkbgh8hDVgwMmxMnEr/ot1r95L2xF72lhUL?=
 =?us-ascii?Q?QkXWs/VoT1eN3wXJULfCFXGnRt1iNhnA3le9EQ+nV+lGEBPY+hyzhyJzplXK?=
 =?us-ascii?Q?zzbFzZgLxlKABfnpV/by6Je+jr8CUo1ub3yuMmIs+5wV6mE/ap4w/JCRmL5j?=
 =?us-ascii?Q?2uzUfMovwaCeFmtGixeBUeFhvlWNKyoQaS2Cn22sgxK4Y1XlJvJW9xGRaOXG?=
 =?us-ascii?Q?WXQ50S35gwaW6YCaOsshKF1yGFTOBXC8k/dUvxPTt5m8ZC/RYsu1KNC91/Uu?=
 =?us-ascii?Q?syfXGo5+SkQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LmXk8zgCfpsIDRJ1N2Zwp5zS1IRpIA/sN+UFFK1/U2yzVmdEmi7caFhQZsDD?=
 =?us-ascii?Q?lT7kZu0KvG/z33wBksiTk6PLAbbPFzoEhIn9s4+WoceUGbWats4Ae8N6rbNr?=
 =?us-ascii?Q?UnXJc8uvi8pgTSZYqEh0DGUAGze7rKj5863/mlAA3pPh5m1VgU7bx0UIZHzv?=
 =?us-ascii?Q?blY6xhcYxImc8d9Uo5e9VIN20OkOfupQQD8tP4QQrsYznrjF+POLShOLZd8N?=
 =?us-ascii?Q?avwoVinNGTgJPYN0KLDIEC2a5PbCNOMcSF+2NlLjCt4LrVQ3bP8ZJU8KdUNp?=
 =?us-ascii?Q?+ETYlyuNMjpFRdCct8kemoWUBWP33nd4nxr1tN1POO2231veAo2Qsd95C0Xj?=
 =?us-ascii?Q?GlN6+rodGCDH5hovDz3GjrATfT9s+KWLbh7fOtadq+wD8df826+6/O2/1AcP?=
 =?us-ascii?Q?Y5thmERQmEAzTB5Ww0RC8o2J9EVXUprYE2vmdvejW13FisGsEXqa9zIF5/1O?=
 =?us-ascii?Q?pd2r0t+AqRfBOnYJy4E7LpbuL8Tt4cpw50M4zPVxif9/RjRdUFqhref+joUF?=
 =?us-ascii?Q?CDVGt3bf6vtB0fJt7Jg/ddmuYWj/hh/3cWmHRW7ICK2yT+XbqwWWJE1dWCzM?=
 =?us-ascii?Q?UhPQqMnNHkHFenEEySM+m0Io9vMhJ5Y+5eamg3XolMMvjiubFeitk+uGN2jW?=
 =?us-ascii?Q?SmnLSWfe1FjzwPbVD+w/Qvaa5+Tt8gXy91mCIgs9zBeT+OQtQKcKKnDiz8yw?=
 =?us-ascii?Q?5UvzxRo6rQfklD8hVhF1dJapQobizUxLHc87A8W1/euHlnkne+PtJ2POfavC?=
 =?us-ascii?Q?gNqO41CNWMV3V1/3t1o5hRNbyHdr9y/zPTQIk0cKJdhEl7KARN/lzsCWQjtP?=
 =?us-ascii?Q?JHj/3b1ZX/mUJfp9i51GPKNkwUka1E9kmciu/3/mo8GNEaLxJAFqulxTuCg7?=
 =?us-ascii?Q?qkqu0pgFQ5FayijnnKpI1ex6xwW8my1lLaTh663hH6RrFC1OsuicmOm/DXs9?=
 =?us-ascii?Q?1aq6UQNM01+Kscst1/DemOqpXpJyXLpW6WZyXzXSMFHo/ELuSpErBw5Mf6BK?=
 =?us-ascii?Q?ktrrpiUnv5Oom3cBwH96UfYAW1mvnZ/X0c5Nz43Pw7nH5IA2s9ovLlau4WQr?=
 =?us-ascii?Q?yPgqdCH50JbsOJeGtAwN2FmUcja/WqdBF7222wrPzUnfM9YofaI9W6ViYNKm?=
 =?us-ascii?Q?WGdTRQArbRnF/NRg6WaUygJZzxq0Xvoy+kBqT/FLcBAeMlanKvrn2NIk3g/+?=
 =?us-ascii?Q?0nJoWk+3mlNlGN8W0gpsuGTz5k6IQA/culK91QKoaYiK6QQgnT2mUQIrr5Ty?=
 =?us-ascii?Q?6XUtzdupuMz/Hxumud0CC83qXIPVxmqJufEpjjUohzHRvv0yICUiQBYTh1PR?=
 =?us-ascii?Q?V68gxR5JQhrt6eyzq++xcZjqRF/IIHLbAg+yqjCadYCodS1BE6a/H8yFGFEE?=
 =?us-ascii?Q?JyYN/gkWGlSX07JJPIjuYfVrfq6GSpLbPwsF3kwBsCNv21iTz28FNuAvnFM1?=
 =?us-ascii?Q?W6o5fQma0EVw6y4t3VbclK5ePt0HPW7o4A3sMGbZ6R/6UvfYkzwPmbdJp7sP?=
 =?us-ascii?Q?zcwIE7AD8RvMjUSK0rwHcC7O2bycUxRljnIZOiD7xpoCrpfe4pDsp3zVjCv9?=
 =?us-ascii?Q?MnLLE1uafVxALKBCvovWSj3+oBHLaltRziVEOIeFiS6G9l5E7Iom6/oAXDAl?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a156abf-21dd-495d-db64-08dd7824457e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:38:53.8314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWQG0W6K5ZtKm0YyuKOVx1z+8bVb4tOxHXXyMoOLQQR45bG0YJKWuHM36+6KA/3Oj70AA4oca/ynLnLXr75jsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 05:00:50PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Future users will need to query whether a pool is empty.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/steering/hws/pool.c    |  7 ++++++
>  .../mellanox/mlx5/core/steering/hws/pool.h    | 25 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

