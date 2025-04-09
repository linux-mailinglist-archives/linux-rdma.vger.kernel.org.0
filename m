Return-Path: <linux-rdma+bounces-9314-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E39A83353
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 23:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B61B4A15AF
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 21:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB8121481D;
	Wed,  9 Apr 2025 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5LSc4iA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625A1E5B8A;
	Wed,  9 Apr 2025 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744233907; cv=fail; b=BmVrEScHIgZp9Rv4TJp7bEr3ifFsF/YgxuXEMLDLugwv7dKSdHXVQBlvS4wNMfahcep6gwKQMPUHAjGRgB36qOKrOalgwCW/0/1bjWxtEkTGXaakUn8BHIdIhneOWyquFL72sXsH92+EIFceHsrHppFUsIxPoYHBJqf8QOUv5wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744233907; c=relaxed/simple;
	bh=+1xGOEyJkXs2ovlagbCNFq8vlzUCqy957Qh61CUBLzk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q5gkb9rmFW7+ZX0cOqsAzAt5sz+2Cg6fuaeqwB+gGJyWhJmmC8Vu5U3eVLBh5UGStf8r3B0iuucRMnEW+DUjoczRh6rw7j/UeggHTN5D8ncwkyS5Vyr3sJvztEqnquVei3RtHrZVysBcC1KCf9Fw1qqdQEv8xei+GWGm9gFi5t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5LSc4iA; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744233905; x=1775769905;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+1xGOEyJkXs2ovlagbCNFq8vlzUCqy957Qh61CUBLzk=;
  b=A5LSc4iA6xxX8mJCbgdJDEBXEnzy7uO6vFCY2HtqnW+wLJ0uiEvD2NDX
   qQm38L1NvfbVYu374+f0t2gbYkL2HWyPLJjYmBKA5k1mH6wvyJkNU5B4/
   Yhq3FDY28yK9FxOWIaQRizU9RNaEJ+NFyB6NLnERTrsFr1EX76qYhzafw
   nA/35yQKfRiedgDqOy3IdWQ8oLaZMrf9JSEnID7z/zcd8HFZh5VXUoQKe
   LIN1NPowGmzqTN/+yWWZJNxRh5UpV0trsTbLuJM3UTUgyfxmB+gedoXEn
   9ItK90Ve7t0Z0sEygxb49xXNhT4T4WrvY5mR8ez1mX29hIhkcOwFFZUgZ
   Q==;
X-CSE-ConnectionGUID: wkVjk7J3REadPwtkLSbFtQ==
X-CSE-MsgGUID: M0cCQJtfR9eZwGeDk4zNkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="68215384"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="68215384"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 14:25:04 -0700
X-CSE-ConnectionGUID: ZAkC9k+BTNylhTqtqnDypA==
X-CSE-MsgGUID: C/bgrCd6RmK3O5HDNU5R+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="129231734"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 14:25:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 14:25:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 14:25:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 14:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=op+HF8kFxsZ2VTPxjsyoMSjpH9r4hlzYwzW3qwp5Z7VZOeFM4Rot/Kf2ws3+828fUzK2+3LYDU7/NznEsbEkT4XBSNNekH7mdM80O3Vo8H3dzbB1wx5ZRazKd48UgD9gk9yUnMSaB40BGOkdGmAGl6zcc0K1uWM6uJxgo/lSW5tIYEXILN9R6Sw+Cd0xriShwJj6VjczmFqyTM0m3zBwv4Eka9gpYqLz0ty/BE0PzwmRXgOR7GKmLb4Vl/5p8/eoRFulqnJePmKWMtdF02uZSu138pmX28qETR6hUzToa17aoDjtCgOLGu+silWxnsH+RvcjY5vR5U5l4MS9GtDoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4y3uI95TfK/j1juApgBAXAp4GNpr8I3U36pmmrBqPk=;
 b=go+nduvFLQLfBjL6pADfosQgJMUuXXd/CS7jtVlDCm+iq//ON++IqouzpoFxE6bcymEW2E3mtYnKnmxDj4WJnnG5p+X+kxmXQ5fgjvYVDAFU1Pr4shnvVoQ9p0BGTmbWDLIDivTs/kgpVQnAOajBRssQUSWGxcdyoDk3y3u7bpKebMTYngsWUS9d5/NXkfhc7bV3nPBGhd9vIAOdF2oG2CjP7mjS+IMlGvh4PAWq8CrS89/PWlOfp1ITM9UtcD47cZp44qLHA2E8fC74NWQCipr+IAUVBsakTwphVyNEd+1YVfakOeMf6sbWVbwMXtPeUvsJTp1ngxUiqSajXZFJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DS0PR11MB6328.namprd11.prod.outlook.com (2603:10b6:8:cc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.23; Wed, 9 Apr 2025 21:24:58 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 21:24:58 +0000
Date: Wed, 9 Apr 2025 23:24:51 +0200
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
Subject: Re: [PATCH net-next 04/12] net/mlx5: HWS, Refactor pool
 implementation
Message-ID: <Z/blo3k29Lir+mm6@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-5-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744120856-341328-5-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DS0PR11MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 30996014-69de-40f8-2778-08dd77acfac9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hlix9VUBGfCwhxscHHo/lCoyO9o599Xo6TS0CEO08kii0J+fn4ZEy669jH4+?=
 =?us-ascii?Q?4GvvQ13/hdxwTNIJobYvAbsEbaWpT1oIDavXSbZLCbPKM+njaKeV2/S97Q7E?=
 =?us-ascii?Q?qqIvAA6bQeYzA4cez5cNq+tXc21FkGWwcaNm5mtvISKa0/CFDx/I0noApVrr?=
 =?us-ascii?Q?jD4o/Z7MiPrnlNQz5ESvxYPiscSvz9Lvqch0rf537r8oV/NDiJvwYdC2zc06?=
 =?us-ascii?Q?LaqdDbafz1ugEchcYKN9qOd+vzBWGkVoCVw8FyVx4wTykVFL49I6e9SPfYuy?=
 =?us-ascii?Q?ohgytEKAxhon7LFM/kjo10U20r9Sg7Av71BiR7NEyPiP9fRQfC/i0FN2TyHJ?=
 =?us-ascii?Q?ag+G0l6z7wml/v46H0QBELDzgUwWmCyjYWAIjfu//NJeRNGn+DHc46hQu+yg?=
 =?us-ascii?Q?hKDk7e6SiVtXJ9HBcCCZAUyyutVnLplv8rHIw4rGSi9vtUNPUGxpW3QVKfhV?=
 =?us-ascii?Q?ra5ZfQxk/jTJ55Oc4Fed132mBNJoK74j+8eDJRWdcUPZCw6X4tyEz+Y102Ue?=
 =?us-ascii?Q?UuNCD95fg0TVfTMGnmeOYfkkogeTlYn/dA/9dZnM3o7QCPq6rSjsrMdlBVHu?=
 =?us-ascii?Q?zATj6svXWull6RayvZ+jdbO6I1UlNatFMeXwnRKnKHzSE7zdQ6mKDpf4AJDG?=
 =?us-ascii?Q?P5Oy2HKey7gcCvE3BwNNW4royEmaz8KO8/HN+VtU0PBvWFviwSe8i5LCZQI4?=
 =?us-ascii?Q?5/Fs9U+3QNDKnRx6XtGmM30zP9TtTRGxfM7D57+XygWlve5KsW0awNyRTeO/?=
 =?us-ascii?Q?LFq8IM1LXzY8LCSUi+PtZMrg6l0keo8foUTvM1HCraTIatxUkgpRiE6myA4B?=
 =?us-ascii?Q?Ko+4LQVD9H5YmxvOn9ih3VDcF8whBQXLMj/PH03D9poB+42V5Qvbs+QXRvsd?=
 =?us-ascii?Q?gVeBxP1ytNxALMkm0g2Yh+RBIhx2GqrZ4lZtgSktcQNfsYl0jfAux33vxf/F?=
 =?us-ascii?Q?k13puByTIDffyy6iDEe4ANtZCuXqblfofEyfkfOdqOct7VZeRjm4fXdfklWC?=
 =?us-ascii?Q?Jzff3CUni2Ritr4Y8ZKRO9j0S5YfrW4RrmvftHegd+UA9rcOraMzqseLwgpu?=
 =?us-ascii?Q?LY21H67aI9KzEYjAm2uyo4UXg4y3vBmuO4BJUAeUqTjm8YOK12N+F1ynKSEE?=
 =?us-ascii?Q?/CKqGvlEmO3R1sMocWi6KRCNvQgewKyfOIgH7aJ6XVFFbs3lST0atnvj5kdu?=
 =?us-ascii?Q?BgC6F1zA6MWlLN5f//eTdUPAt8Hq3Vo0MNHrWumAW0szfrBGFGb8eiOz/rzX?=
 =?us-ascii?Q?WWibUPUJPhjRGMkxqXDWhISHeLJD6rgCimOebCOjNdx01jD/HZ7nZORACfXn?=
 =?us-ascii?Q?x8ggrqHoaElCMtV9zskrvAhAwJtHk+9co6qgm8R8mEgUevwrmWhiFM/0gbWs?=
 =?us-ascii?Q?Nax59d/OGbMzS6+lQ6dw5UAvLZ43TRAFuirLEo76UfWuOuE7kUNdLjL9QUgZ?=
 =?us-ascii?Q?iDa8EeMVRvM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vDPz1kxMJ5Tq5teDy1govpgrc7jVwQq8gIXMi059iZMR3XBP1MC8iIPTWhRX?=
 =?us-ascii?Q?oAQzyv2PvH2exPEW3FI8BQ+8rSK/bfBcSbg5Op7JC1O3ZhJPfrBbUxVU4qa0?=
 =?us-ascii?Q?TjzA1hQn/6/VhocFlvkgQWH/mJtZWojhQjzDRSL/EuGsFkbpnAx4vbCNjpmF?=
 =?us-ascii?Q?Z+DKlGMdClwAgtudzlv9svNEJdgLxNVUNfRnxrSyc4px3oKUI3Yu2xFqhO/L?=
 =?us-ascii?Q?pMLWL76T6H5TSZ59+LlTSQW5CsUFAAhA9PRcsNDhk2Zj7J9VUUrUf8aVp1cF?=
 =?us-ascii?Q?PHfdk5Zf3LPDOqxxPmsj52uRdIYFIjizZxClGLitFXyXKJ/N4IurGI0m75cT?=
 =?us-ascii?Q?a1icLj5QDlzFYNSZVJKkw8z/czIw8tzVogoGq2cBoYNueAG97iilD/otDqD0?=
 =?us-ascii?Q?kfTzzihcOwxy2aG+7q4T4LsbBwoUR2kx8fZfPjW5VgV7jRrEAWf80rtoiQ0W?=
 =?us-ascii?Q?6hvXKCFD6IKOaagHWM/FVisl0RA1WzlsWXOLS8UJe3OLsbCGzfSOZVRMWr4v?=
 =?us-ascii?Q?CFUe/zmnUXRo/zEvuJ1DALeRGdW4uq4sx3oBbklnjLFz0C72zMuZqB7zcvJw?=
 =?us-ascii?Q?ezhxrNHvsrJvx9yBatZKWFmE+QQa4PIkePoGHL0vrMsJfnzpINa2D3HHKlm0?=
 =?us-ascii?Q?Hl94FfilLeAtoYsuphCHySq6YB8CdjpX16zw+w3n1n7Rl8zDmgGGjTWxmzRp?=
 =?us-ascii?Q?ETjlBnTSqZrldnhpByrkNr1TdTTGZS/xd3/CAHZVJnk+iV95++1ept03DScU?=
 =?us-ascii?Q?W2fZtxH6I9gwLUHwVARGU3qCy9CR11rVeqDqEBQjrx1ba/EamndK/K7nEWbe?=
 =?us-ascii?Q?LQsgYGSsecBygauJRvgfwmSYuPcEDjKf8QkWsYrZ5qN4FUluS+V0GCjmTHpE?=
 =?us-ascii?Q?stxaUWgTx9QHWqgVkzD6HBUVY9XZ5SIh7YreqFu4MH0neLs8QbW5VBsqqeZE?=
 =?us-ascii?Q?kHyoD4AOjeOWJy8bAV3D+B5hr+4nbSrFcsWaY68VdrqzlxTD3cEDrZ3d9ok+?=
 =?us-ascii?Q?1LJDeH1Y1wgaWcPhWrGoZNPsA2t+AOSg8wZ+4fQd8fface7fZb85J6Xetz/q?=
 =?us-ascii?Q?XAkDEU3RjCq5qCCWrruEiM+TBeeIvWqTFE15oMTYcKPbQOlh9RnQOTeTVrJ4?=
 =?us-ascii?Q?vEzVIKZj8VNxIpCVNJm5hRAuG0NQjDd3XE1pWiGSNer6+roamsummJFDM+n8?=
 =?us-ascii?Q?fY8AA4dBzCk9yq7mTLxpHFJ5cFZUdSrIF+kV1DSMyuX8NGdZ4C3/IUOmmttb?=
 =?us-ascii?Q?GFhpW9LGgkttY/bAxwtusDbpSwGMDb91d7aSW0zBDhax5SqvdFYg5avfax5g?=
 =?us-ascii?Q?UknWLPHOp0DzbLj6/qDEnwl1CtESbPeBbkojsoA4v0eXKTa6DNWGVvX9EE3p?=
 =?us-ascii?Q?pHoodMsjYI/XEC8lTHVuLm3OcpeBVbvAGSkvxITWFC1GhLaKv9yruJc9Uzzs?=
 =?us-ascii?Q?jUE3cYNpJ16MTCAtnrnFDAR4yXnJjyQdjIPHGvRESAe6jCnXLCqjy9jHGXyw?=
 =?us-ascii?Q?FnkgUDQijTddCtHzzWsWaZlJyOhQspGkDzi7K5cdrvIQ93ckFTiQuafODLrG?=
 =?us-ascii?Q?5dQd72HenJvzN5WRDLlaOA+48mlCqTltT0Yh7o4HCcFpq2nsIdFxuUkLcELI?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30996014-69de-40f8-2778-08dd77acfac9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 21:24:58.3192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 718UEHDNliahHRAzzTr6Qhk5+yOC724J2giTI6wU/Y5rSl7Q363fO/MLD2QkJ9kY39QlXvFE++8kjmIDt6sjNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6328
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 05:00:48PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Refactor the pool implementation to remove unused flags and clarify its
> usage. A pool represents a single range of STEs or STCs which are
> allocated at pool creation time.
> 
> Pools are used under three patterns:
> 
> 1. STCs are allocated one at a time from a global pool using a bitmap
>    based implementation.
> 
> 2. Action STEs are allocated in power-of-two blocks using a buddy
>    algorithm.
> 
> 3. Match STEs do not use allocation, since insertion into these tables
>    is based on hashes or direct addressing. In such cases we use a pool
>    only to create the STE range.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


