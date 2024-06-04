Return-Path: <linux-rdma+bounces-2866-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E7E8FC03E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 01:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294821F2536D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D75514E2D9;
	Tue,  4 Jun 2024 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbrNS1kQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC8B14D2A5;
	Tue,  4 Jun 2024 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717545428; cv=fail; b=OyrH1djB2MB2KbD+IVsQA9q55iJwxoXb42kXV9ZGt7IYo0tAgS/s8c3yQvM6pjVn7T0sSGcQl3935TUXu7lEnzR0wZBpdjJmi5IXyJGex1JtPIj/FD3yfD3v+vx6F9F6soO05eMNEcu7ZQU4kZZgBAS46LCST5JBy4GBsSjISLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717545428; c=relaxed/simple;
	bh=CvnaW4DYtg4z5ulEv9/K/6bYYGbKQX14EJC74mybrK0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R+yHGj3Ev8Bm/qpAdPdPQ/sWWaNpYug4/p5Bbkae0ljSU6eJWjvRzu173C9pPLMrRPFunYaUUA+r8diZbepqp7KMiqZfJ0KoEdJfTMajh2uuaFFXJCRaLH8nyPeG0+sLi2/oCh/r5NeazsqayJqhF8pwFUL8s5uTeOqRVB7g4oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbrNS1kQ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717545427; x=1749081427;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CvnaW4DYtg4z5ulEv9/K/6bYYGbKQX14EJC74mybrK0=;
  b=DbrNS1kQFaXYmI7SLSOCYIXmO3g2E/tLKCspI1F4BMZrDGEHv59qsWYX
   9Y/tpztQKznc+QnQONfFm0NvEONUUstGUwnX4OMYeQivv/NZ+TexilH98
   yy502zmbxcWtQxybmRo4KXGshNWPyU3zbO5K/Bcz4D3pyoh8C1JxXoFJ+
   TqLBpXCIDCtXHu2wXLtq6s/gnthoZfBG+JSpIpNf154fblkCsQqYHvlSt
   +SliHnOo7r3O2ETlKdwdG3cEIIG2c12GWzOaaAhmXRsve02m7VVhYtcnq
   ZQdCfqZuHafXuW6pUTuSJZaRDcaAKIlWSjY7cYXGDoDYALXk2L/Df919X
   A==;
X-CSE-ConnectionGUID: EtMKdFAcT36MH0Ncv81kgg==
X-CSE-MsgGUID: jpOCx0XhT0+H23H+UUL5qQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17909787"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="17909787"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 16:57:06 -0700
X-CSE-ConnectionGUID: NysIjUNAQnKpJKUhL95DpA==
X-CSE-MsgGUID: 6ClKJ7trQp6FLOTK5m1oqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37968117"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 16:57:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 16:57:05 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 16:57:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 16:57:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 16:57:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB2wi2fLco7sgyMs/nrxYyXnhEt1qXzY1O1Cskdft2tnmfh/dEBlMrwx3/2bZPXPJ5DfT7sV2u7dqoB2v7VVjxRJCsZjNfcEHw0A+LxbL9zotZ/bbwWnBPFRAQbvv8oKM1pAuRT316V7jM6Gb4L8Uzl2mpW124oqevda1nbUwWTjKWtg03u4iJZId6kQZbHjRZik3oCXdPnTcpIZan5CxtAyf6M1Fl9dhSeQxijE5tpdGO8iafptNt5zO/gxNnEYWVukPUREfnOrQbhq0vJaNp6QMloGAX75e/xv3bRTOOdZgYq9JW4gauIcz4nZ2N8EZ/8b0WniM/j7PS8z9lvSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwrRkV3flNqAdELArVvCBMOJhG9liffT+spAb2pGN+o=;
 b=e9BVqyaMm4CqFKtRyqoZssYCvA0TZ+HvJ5GxjaAo358jXkcyrpw4rj7OMnMK4a1Khshs0DmToTVr1TKmadqmZ4SHpgcYoYlKiP4DCUzGEb+R8xqHPOZmuVqqylUJrVbYlY+EdEYGG8PRFzZ+Varhs18tYDvnbKd/i/Thl3gHqcy1jG3Z1L7JGJmoR4YxTeAa/m/ZwTkjzpN5RqwbMWfwdZoZPOlb952n5qs82rNPjASr3LrVT6JSXq6+nCNE6gGY0kyNDJ64z1HKJK2AFA4Kxpn/3syzW9BGMDyRBo6qJnVQe/BcdJoNd0t7k+brilZhaKzkYGVAuaPKtkaDg8iPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY1PR11MB8127.namprd11.prod.outlook.com (2603:10b6:a03:531::20)
 by SJ2PR11MB8469.namprd11.prod.outlook.com (2603:10b6:a03:57b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 23:57:00 +0000
Received: from BY1PR11MB8127.namprd11.prod.outlook.com
 ([fe80::6f9b:50de:e910:9aaa]) by BY1PR11MB8127.namprd11.prod.outlook.com
 ([fe80::6f9b:50de:e910:9aaa%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 23:57:00 +0000
Date: Tue, 4 Jun 2024 16:56:57 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, "Itay
 Avraham" <itayavr@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig
	<hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
	<lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240604070451.79cfb280@kernel.org>
X-ClientProxiedBy: MW4PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:303:87::26) To BY1PR11MB8127.namprd11.prod.outlook.com
 (2603:10b6:a03:531::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PR11MB8127:EE_|SJ2PR11MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fb35e3-68e1-4f0f-f4eb-08dc84f2065e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mdi6iJiAo3fl97MstPieJlfInikCsWDcfp0NxzwgttOwNVW9EdFFjUdW3f4L?=
 =?us-ascii?Q?GxWW6IXyLEIdMmEp6SyHZ3Q0AkKfTYnp4SoUT3ToOUEszPfBmU1wQN1+W/zq?=
 =?us-ascii?Q?Of8vmxdYczydzR1KLrfQ6PVyTLWYEevEKkUU9opGYfkhu31Kf0s4Eh5E+GgQ?=
 =?us-ascii?Q?mGs2trxKEj1Mobwh1ek1vzYrtdAuFYqLu2ps9SyzEJokYQNHKLvEnhZbJHja?=
 =?us-ascii?Q?z3+q5BH5ZGK3klZCOk7h+kRsD4Db564ofQS5TwlX8jx7AYOmMIB2OU4kOrtM?=
 =?us-ascii?Q?K501VcJygECC9Yel17FMTe+jjtn9zlOhM/uc4idLlmA/7663REUve+Hqz7vG?=
 =?us-ascii?Q?2r0alV0/xmqFqKPtfBkr1X6lupT1+HmBs3glu3AxKdnZylW8y/txi0Ilp+1K?=
 =?us-ascii?Q?0vopEJJt8/qA0thV1IuUiHR8ymd6SgIpRDe+FiZc3dZwTLf5f9Fq3e/ZDPkY?=
 =?us-ascii?Q?LRXhQVhsUn9rTdXoBcYSKXmA+ykazyPrNtjb0AHT8JXC6nQiPpasKqXYoDA/?=
 =?us-ascii?Q?d3DUFxy3Hc6bsf8mR4cPRDFYLL7Z6CE8B1piDC4vDKDATgQ5lDG8HHFyto14?=
 =?us-ascii?Q?Vyffqs8KxJsSC10n+ym5m0uw9OCyVr1yndvD96aEGueO207dBMnpgq1Fdv4e?=
 =?us-ascii?Q?8fZJUPQ6hQwhNbupMJSEsISQg2WbxIodsXLHlMr8x5+YByzpq0eagIGSiZ81?=
 =?us-ascii?Q?GjEfA6JV7sZKdU28EdRILtmgYsYMwkr7CCOz8P/F/ip842IvlSOvMxl3h/34?=
 =?us-ascii?Q?/b3ZuRZrMMIQTJY4AMYNH150ov/WYLq6sDIGmNscRXlMJJFkOACz7UlhPUMC?=
 =?us-ascii?Q?LM9rUrEoDMH0gNIoKKjuNh6b005rmyyAaWx+Svi7xGioVIc9E1PG0eHzwoS5?=
 =?us-ascii?Q?lhM55pp3vVzvAFweUPPA1HR0nXwS5CpbyuRpq50k+DCdp3sQSAAICOt4cJdR?=
 =?us-ascii?Q?EQxmBg9uamgUFdQLrdl2XQaBV0K7GC7pEqe2XeqX9LFe29KqCDyr6O9R8l57?=
 =?us-ascii?Q?qPAhy+SOOoskIL/tPZ5JHxdQJ5QbYGOlEjCOnjgC00w0AqCyU3n940kVk6s8?=
 =?us-ascii?Q?F/r8vak/UjYvQgGN/EHjk9iNmAP0vGbDcS8YmPVtaNSFHw76oPfkcZPwwvC/?=
 =?us-ascii?Q?VWUJ4v4MDRz53MLItoa2Wzu7rgCCOTSykly+pIAchsC1g2BIaMdVNawKKb7y?=
 =?us-ascii?Q?WRt6c+O8JV0sHBGwY0rFr8VhhSL5Sr55cVzL8bSQrZFLYYIHGdOKWOj/IM+T?=
 =?us-ascii?Q?F/y1j1b5hFuql+jmmvfPl7oSEHW7gPVK7WhPy6MXK+G/82zobmHeZwjnUzZN?=
 =?us-ascii?Q?+qI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR11MB8127.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SIpq5ssReBptGZkQj6TgBtCuClTUQEWUnmmyN1f6YOxgTyhIwIAKU2ZynMjt?=
 =?us-ascii?Q?2bkRIP6S+aBCPH/U1mHbyM634bWm/+pDG7lA0pBP9zFAYUOrAavHii5Jnuy1?=
 =?us-ascii?Q?EoQ/GBiMYV+OKpvD3+K7OiSF7GvbQUFh//uNt0k3WYcxR6EzdFwLPaWElOW/?=
 =?us-ascii?Q?sJpaS/0q+i7X4eyS5g+sMYN2+lRdwzu/8ZBvrkbpWOWSbvaZGjXeAUTw6YGr?=
 =?us-ascii?Q?+e0jNeaoObjaxzTZXVBC71GXsOTHnRS5Ah3lgc8W91CJfcwooeQhd2m6UD6Z?=
 =?us-ascii?Q?mCcJW/vhqL4DN4UCPsxDC+Y2GPemmkr7aZXsfdxAKpGrBZp2WiHNm5aH9baD?=
 =?us-ascii?Q?Ix9bjyu1Gn4SfKmf8EbM/gJ/gEKUR8xvXSvXtX1yfZas1aiRMYtSwYOT3QZt?=
 =?us-ascii?Q?CBs+b+WNTrqNgRWh2ICsXImQURJwK0vGV9pf7zgG4kTDNtc/Dwida47WZb5W?=
 =?us-ascii?Q?ohM7LjJxLIcK7geDV1h4bDwkHr6XS+DazhKbfDYI8PRpcFEvqwGWIn/nxUKh?=
 =?us-ascii?Q?8+jxaaDlvwHL0XDnqKFoDTmiuLYYmbz56WcnQj/KUnPEbv1GIUxhnEH/Ipz5?=
 =?us-ascii?Q?UEo4CATKkgawlzI56EOjyQRYTqYls3C6mg1+Dl9ZaJ5jDBRYKOVFu06wu5u4?=
 =?us-ascii?Q?q0uLeMSsC4jEFcOfc5rdp+1Oqa6SvGsKM06I2qRJJoeMNZNUqk9KR5Sq/a9Q?=
 =?us-ascii?Q?k3OwaSL7R2KZEZF5jn6GgFLCc26Rb4V5XXTyPolUtP88J6fxlKX0zqWHIbDs?=
 =?us-ascii?Q?J0cxOyBiBEBNVRXtc3vnrJW4qkSbjG2yJyJ5YQSVMSfR8imMDPJr7MMtT445?=
 =?us-ascii?Q?C9Xld3oy4u25Wl74WiJTQv4KUbPV/ugnlav4jt4pqqbZtdjJtLYRNlhzwTrP?=
 =?us-ascii?Q?eB5J+mDEtoEYswwoDdBXbnWgp1KVKKyGqpMXFAImUUaqJSoI+HE/a/hlOcS7?=
 =?us-ascii?Q?brvfRFb4jBxqZlWN8czxYAxsosV8b5EfyK3R1by0bSyAS9PrzsgGXCnPWZ7q?=
 =?us-ascii?Q?3ampxsvi2NLzMRapG/j1AlnXUEi1i8wUGL2akMfUY8fFIXNV7RiHJZzspLtv?=
 =?us-ascii?Q?2n3bDPmuXAIl13MxvwBUqvMdUPRIhGToI/gvst0A7J1sE/LbAbo6IUvi++Dv?=
 =?us-ascii?Q?yTP4Kr4sSe9kLFbsHfnGb5cdS/LW+Q9dBry3zrgQvlnuorIKbAweeMA5SigQ?=
 =?us-ascii?Q?5CryxLCrqjvrGje8eyMNZkXbbLOI42kh+WVlOdRAIeSLY9CCiKsGgjzKtKUJ?=
 =?us-ascii?Q?MSMfJfoSIPZbKZ9NO3oPMrDQhfOqa/uq2oLYUnvjJUZKpBFIHjZJSovwg9Ab?=
 =?us-ascii?Q?CAYhwu/th/9yTBrK6tn72F2ORBk6uaGaZRLuFPwE84RW0x815CJpXtDTjGQW?=
 =?us-ascii?Q?+oSo2pF7XdDrc1u9Mkhol7+0VjS0q7VuhTZaxjxsT52LFafL/MEsJeUCR1J6?=
 =?us-ascii?Q?6CW5G7+XvLKn4717FCwSHsCaa/I4yBLheT3xCwAlfR+FX+VP4DzOELDhcuEo?=
 =?us-ascii?Q?KM0EnzZukkYumAexRTOLdTRMLE/LttDkbEKgJKX+488VhYA/xQrhQCGE8Ut+?=
 =?us-ascii?Q?5WRfijMH4/PgGEpIX8MUq4feOGjJJ8DtZelzoiCqcOoBwpXg8+SH8sUg5Yyj?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fb35e3-68e1-4f0f-f4eb-08dc84f2065e
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8127.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 23:57:00.5452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cg+e+LLhCyg120+rQv3+BdcRsQrdqil4QMyX+qURSTmz4FD8zpz9ogVUHR0V5ZaKr+T7qZ5v53NTLxT7dxoUGgWAENseC8KoKyQeZm0YUTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8469
X-OriginatorOrg: intel.com

Jakub Kicinski wrote:
[..]
> I don't begrudge anyone building proprietary options, but leave
> upstream out of it.

So I am of 2 minds here. In general, how is upstream benefited by
requiring every vendor command to be wrapped by a Linux command?

Mind you, I am coming at this from the perspective of being a maintainer
of a subsystem that does *not* allow unrestricted vendor commands. Since
day one, the CXL subsystem has matched netdev's general sentiment and
been more restrictive than NVMe. It places all vendor commands and even
all yet-to-be-Linux-wrapped-standard-commands behind a
CONFIG_CXL_MEM_RAW_COMMANDS option. That default-off option, when
enabled, allows any command to be sent but it taints the kernel with a
WARN(). CXL devices theoretically allow direct manipulation of system
memory without IOMMU protection which is in contrast to NVMe which would
need to work harder to violate kernel-lockdown protections.

The expectation that I laid out here [1] is based on the observation
that a significant portion of the vendor commands these devices support
are for pre-release hardware qualification and debug flows. The
recommendation to device vendors was "if you need wide distribution of
kernels that allow unrestricted vendor passthrough, work with Linux
distributions to enable this option in debug kernels, run those debug
kernels for your pre-release hardware flows, ignore the warnings".

3 years on from that recommendation it seems no vendor has even needed
that level of distribution help. I.e. checking a few distro kernels
(Fedora, openSUSE) shows no uptake for CONFIG_CXL_MEM_RAW_COMMANDS=y in
their debug builds. I can only assume that locally compiled custom
kernel binaries are filling the need.

So all seems quiet with current restriction for CXL endpoint vendor
commands, but this stance was recently challenged in this thread [2] by
CXL switch vendors with an assertion that fabric switch configuration
has need for more and varied vendor flows than endpoint configuration.
 
While I am not clear on the veracity of that claim, it at least
challenged me to do the thought experiment of "what would it look like
to relax the CXL command restriction?". Maybe we can come up with a
community answer to the "so you want to build a
userpace-to-device-firmware tunnel?" to at least get all the various
concerns documented in one place, and provide guidance for how device
vendors should navigate this space across subsystems. Between NVMe
"allow all the things", CXL "allow all the things only after tainting
the kernel", and the "never allow vendor passthrough" position (I am
sure there are other nuanced positions) it at least seems useful to
document the concerns. Here is a start for that guidance from the CXL
perspective:

* Integrity: Subsystem has a responsibility to meet kernel-lockdown
  expectations:

  Distros and system owners need to be assured that root's ability to
  modify the running kernel image are mitigated. For CXL there are 2 ways
  to do this, require Linux wrapper commands for all the low level
  commands (status quo), or a new trust the device to publish which
  commands have user data effects in something CXL calls the "Command
  Effects Log". In that "trust Command Effects" scenario the kernel still
  has no idea what the command is actually doing, but it can at least
  assert that the device does not claim that the command changes the
  contents of system-memory. Now, you might say, "the device can just
  lie", but that betrays a conceit of the kernel restriction. A device
  could lie that a Linux wrapped command when passed certain payloads does
  not in turn proxy to a restricted command. So at some point there is
  almost always an out-of-tree way to get around the kernel restriction,
  so the question is are we better off giving a blessed path or force
  vendors into ugly out-of-tree workarounds?

* Introspection / validation: Subsystem community needs to be able to
  audit behavior after the fact.

  To me this means even if the kernel is letting a command through based
  on the stated Command Effect of "Configuration Change after Cold Reset"
  upstream community has a need to be able to read the vendor
  specification for that command. I.e. commands might be vendor-specific,
  but never vendor-private. I see this as similar to the requirement for
  open source userspace for sophisticated accelerators.

* Collaboration: open standards support open driver maintenance.

  Without standards we end up with awkward situations like Confidential
  Computing where every vendor races to implement the same functionality
  in arbitrarily different and vendor specific ways.

  For CXL devices, and I believe the devices fwctl is targeting, there
  are a whole class of commands for vendor specific configuration and
  debug. Commands that the kernel really need not worry about.

  Some subsystems may want to allow high-performance science experiments
  like what NVMe allows, but it seems worth asking the question if
  standardizing device configuration and debug is really the best use of
  upstream's limited time?

  One of the release valves in the CXL space is openly specified
  commands with opaque payloads, like "Read Vendor Debug Log". That is
  clear what it does, likely a payload the kernel need never worry
  about, and the "Command Effects" is empty. However, going forward there
  is a new class of commands called "Set/Get Feature" that allow a wide
  range of vendor toggles to be deployed which will need an upstream
  response for the driver policy to vendor-specific "Features".

So if fwctl, or something like it, can strike a balance of enforcing
integrity and introspection while encouraging collaboration on the
aspects that are worth upstream collaboration, I think that is a
conversation worth having.

[1]: http://lore.kernel.org/r/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8ZkcmHnPp3B0cw@mail.gmail.com/
[2]: http://lore.kernel.org/r/20240321174423.00007e0d@Huawei.com

