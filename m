Return-Path: <linux-rdma+bounces-2392-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8908C1E4B
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 08:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318851F21D8F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 06:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E341487F7;
	Fri, 10 May 2024 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDYr2qtl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89305286AE;
	Fri, 10 May 2024 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323485; cv=fail; b=iUfOBes/sUT6lc6kJpwFGSKiBEgbTuARCEsjZ5TNhXW6ecQhnfwb3/+pG2RToYV+m7jGm9gXDwcWDQ6U/MnFL8DOWeXz++YfwZaYyLP+HJYVur6HbMV+8ZobgIoszkAcn9bIJX2ndb6IdPe/FswJP6/ilRVkK1SyHrPryxfx698=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323485; c=relaxed/simple;
	bh=iYC8id+Xac3M5ThY78oc/j6roNowJ+0BVwpNx2isYcA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DDoaQ8INuW7qkngfvnFZHF1AsfkFtYY7q6gxX2s7VKf6oKsi2HTXKFaYHSViGsYz1Gh5ZLQmmRhvo2l6EZd2hMkYnH3SQSpH/ZQZ6M2KYO+afY1XQRdmRX7Fq9Zh6f+76tVWLc3IVpWw0N88DOEiPVXV3O5RPqH9v0yGK+7JAxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDYr2qtl; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715323484; x=1746859484;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iYC8id+Xac3M5ThY78oc/j6roNowJ+0BVwpNx2isYcA=;
  b=eDYr2qtldYfOAvn/cEfvnz/7+hWX2wGVMSNtK8L6DeQpiRERL2mFUflK
   gORxbdfDtdDnC6JAG3QsLWsb0Ij2gu1nZQxVX9tqH4bQ//pmINrMwWeUc
   4fXvikKB9U11/JGmf3ScudE2jlozIGy7tmLszutjac+5ypweiB7illSQF
   9ITWNnI78KMVHmm1iBT8HHmGykAScplpeuEbtHYSBUj5sj2zweRuzVazT
   LadWssqIeY4wP29X2YmPzSH+tnPyOb9ewFbusaAbSvqhFVbFlDQrCx4gC
   8ZZs4E1yYZT1UdaB4UGZHXriJk3OmdffkdJJN3PMo2Puz2Ifv/A5MPuop
   Q==;
X-CSE-ConnectionGUID: 5OtaX9liSx2AI1rvyWseHw==
X-CSE-MsgGUID: iokyHhuPRju81jG+Xc/OMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15122949"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="15122949"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 23:44:43 -0700
X-CSE-ConnectionGUID: cNWrCP/IRwy8buuy2KTjXg==
X-CSE-MsgGUID: f2F/A6o/T6C6DZY8eKnT9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29373734"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 23:44:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 23:44:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 23:44:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 23:44:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVL7UvzL7DulCq6bS/WNq7kvcPWvpcJLUCbFnNH9j4wY7vW414dK65786oLQOl6oEKlnf0qUEDrp9RnZ/rfLpnfx+ZrwmpIRfk/clDQSLy88nF+b+PC7Flfxk6FWKCEc7llvTkUM5/ksKw3N1diImYSClmEUwmt3lO/8cmi1ZnzotlRFkONV6otQAvxdK8x7CvL9MWgXFMR8Mv4TYscqUFA1YkHcnZA16piWd7f6XdZ2pTf5Od71jB7+ROgqCSFeH4Z/Q5eiY+3T9gV8S2S73qpaht+hQ7yBS4SDCBY0dmDKEdoxUAKHuwheLOlNoqrtzBUItnUFWbY8pgrNQyaFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asHA4NKsg6kaHMBqx6h3wk1eoMu9XAKuQc++YAcQlcY=;
 b=fAJ6Hc/5BDTqaYUTqTcP8nDyehGKcsZ+1SAWK/23D4ekMAixOPtXaBgFx1wnksm3Ok2b0dGSTiSDGoUq7nwHO8g2gwNmDQRNYxhcr2rhQGMqf3The1sdsGP3LANcT2DOvx2z/tr4WDXLjnwhtwKERRkqi6dKXqkFQ+avsWHDG7rFLtKO4SKGNOl0Z90xM/AB7oa7NbZ7OmSCIiO+xFiPJ3tFhLOQbYAO0RPbwwMzvtYwVvGp/VZIc/dqUQ7qm90iVQUcByL9D9zzJUO7kc8uGUaBzIub7JO+c29K0GeonTSf2crTiz4GUTn8NZtjedYSl4FB8oazGgnQCxgOhXxRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH8PR11MB8106.namprd11.prod.outlook.com (2603:10b6:510:255::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Fri, 10 May
 2024 06:44:32 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 06:44:32 +0000
Date: Fri, 10 May 2024 08:44:26 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Shay Drory <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Moshe Shemesh
	<moshe@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net] net/mlx5: Fix error handling in mlx5_init_one_light()
Message-ID: <Zj3CShR731VUdEUA@lzaremba-mobl.ger.corp.intel.com>
References: <a2bb6a55-5415-4c15-bee9-9e63f4b6a339@moroto.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a2bb6a55-5415-4c15-bee9-9e63f4b6a339@moroto.mountain>
X-ClientProxiedBy: WA1P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::29) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH8PR11MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dced2b8-9345-4ec4-d77d-08dc70bca63b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YoGf7lce/wg/McHrr+FMIzNXVcQhCg5WTODbedE3DKaBwTIkg4jvFmioBfv3?=
 =?us-ascii?Q?WWpLZuaPkYeIF0ynOiWuOajupefso44j6FwqZDcS446QNxRiElK/yEhVhSGH?=
 =?us-ascii?Q?ZzIN46ZxhcOpMCreivcufWFdYJJk0PCVn38HYjnY30Csf8yZLw6ZgAn6acQj?=
 =?us-ascii?Q?4jwttAeEvpy5R9sZCFS+BmLvsaaI9pEFO7Zb9LcLD/5fWNmTuSYJsbaqw3Lq?=
 =?us-ascii?Q?sf2DR93sNo9h6ySpvncQsThdnsCCpjxWDd+iEaGjaIFM9PNOk1yjUnznW+mw?=
 =?us-ascii?Q?MrPYfIqOte3SbV+al/T45X3MK733UFtfOenxvmcA9sd7FNO03oWFUyjENJ3/?=
 =?us-ascii?Q?Y0vrKZu28/IMtn2jgDnU9oBpdlCYod+OlGmE0yPvBkCE7lgbehy6qCJ4gEvU?=
 =?us-ascii?Q?2ldDYNA1d2+T2+LFVbxJdlzJ4wPKaFySM1HqqhwerAV7uXiZxF8BROrokLa5?=
 =?us-ascii?Q?W3GzqRz7PseQDnWNaOtEMQbMJSzD7eodvM7i1ulojv2bpN6mJrYYRsN6+dUK?=
 =?us-ascii?Q?cWAQfl8omI+74OtVf35s7xbFld5jTx5N0g61PdFDh2O4KI7cgvZ7h4JWOYEU?=
 =?us-ascii?Q?l+8QwaETrzabtDmmSdp+4kNfYvhuWyPk0kQzG8ciOjtlllGME1kleetzSdks?=
 =?us-ascii?Q?FVFVrD1Uk7fCn0cGvVJBUFroBxvLKsOx73Cl6DBxra+GAU7leueagfKh0Z7Y?=
 =?us-ascii?Q?CppWBjAl2VTb6V01KFggQGiE1PQ+/1kchHDlPMk92wykT0fylK6Qn5mRBjZb?=
 =?us-ascii?Q?LOWi5XHaXs4xW4sJhYNXsPcMEnXBNPwWPVpD4E1Fm+qgHO90TONrN66vFTl4?=
 =?us-ascii?Q?1CJ+xBS/4n+3g6ywFnQ5LtiDxXVY9QlIi+3h1JfdMvlf2k8fY2VH6kaFfmLV?=
 =?us-ascii?Q?wwes6rkGQ8AzIYlExIsqhq0uhHjb6l9iMkZlDVNwBkjO8IzugQQzh8ZVP/Yd?=
 =?us-ascii?Q?goEyTzF/GmljnTjp6aQoVprM5BlaMNmcNH/OQWtf/HPCRYBJrbGz/2CgGt5s?=
 =?us-ascii?Q?SeaVXZENW7zMriyI13/oGwMWiTWOKbra4E2jCV0JExeXdc3s5Dr6BuGAzF9H?=
 =?us-ascii?Q?ODvMcS1GiJp0PRntk9UxKFvaoywRyCHcFsUeZZHHtZJGYaMwPxo2Yo0hdlNS?=
 =?us-ascii?Q?Bt0rI7XIJ9mIiRplYM2aCg9729395pGpr2IWo5rLiMie6DH7NzqRpuYtog8P?=
 =?us-ascii?Q?lC20yobLncysnHufJAeLrkGI01BCpOuu1ekBioyJUf/PVdU9WmqiLIPQAGxy?=
 =?us-ascii?Q?g+xrMZlEH2O63UK6Hfo6uzE/cLuTa5U+IuxvzIEs4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iyxBsQbRQT/rU268DZkXFuuuauShhY8r6M08a+hKeuF00w1etUMAtoBvPxhE?=
 =?us-ascii?Q?ZTqyjs90VYVFYBAs2230QsXnVjbNZG4Jj1Qp8sNvHyEVgfwKNsOgmqjeh5Pw?=
 =?us-ascii?Q?7odOgXpHFqCXABFNjgEBS9yiVgMcIiDfn/o7qeouX0aNCbTXklLGrifJAvAD?=
 =?us-ascii?Q?y8d+M/fMsmm5lneopVaOJzwKyCIiwK4YC2hVI7JAvFVjFXEAAq0YOt5QEINN?=
 =?us-ascii?Q?C4zKZN0XCZkWiyLP9+Mgl9IkKfFfTi2SqOLPxwePfFe2sz7uiF6poCXwqCS5?=
 =?us-ascii?Q?RPB3Q6VV5S0fBraN34kRRMw1hVj4EdOfBFKWHVtUTxyfcdDMjU8X/CPnT8I2?=
 =?us-ascii?Q?mD1B2+cUpwvix8MOEi5HcLOgmN5YCH0k6PgVaX8ZZ9xMU5M8qr+Ga8aN5cJj?=
 =?us-ascii?Q?gpVtNLNk4QLSmsAbWkdwVgqamJKLl8QvQNS64SZQEheFLyd1OjUYCcLubXWb?=
 =?us-ascii?Q?7Vo58yzFxYaiCrqdAJqxJmmvKqWfX4ZHCDmdFxz/OI2AVhvFMKVqUMKhh7IP?=
 =?us-ascii?Q?qgrweWMJGyxYfUrD4Acj/PfNH3/xApgnEeFumWv1aCqxYh2ltMH6/txLsuQD?=
 =?us-ascii?Q?Z1pw2pgSjQiJkbTI95DRr/14kkl+W/XIyfQDFQOzoRZtcs5EZb9TftONOHVH?=
 =?us-ascii?Q?idHPfXqf/aVfm+ubPU2HthnVBVf99pog9ofQH9hf3hrF/Fpsp3E78DWw84+T?=
 =?us-ascii?Q?cxaKOHWlqNYlpKLuGXoAc0FxX2oSvddUBtQpFKSF6ciIQp2EjDH0eZel0qzy?=
 =?us-ascii?Q?6HeADQVYyBn4/Ulcp8QTBEL1qlD6A92B97+i855lr9KgiU8xhSCniZQB+JSG?=
 =?us-ascii?Q?JVBFopcid1/YQYW0PbdjIyRfZmsMeVoNbk6mhkid/cFdUElTe1unqjvg6B6A?=
 =?us-ascii?Q?gPTlKxfRTiM3x2pfT2PYVDkIn05uXv6Cva5d/7W9sn3W3SjIeuZI5E42EUdG?=
 =?us-ascii?Q?5PyhpVpbU/uOuf7k8a3b88cI9P4SG0qjMOV5UO9qteZsTPLCDQXRpLtrALli?=
 =?us-ascii?Q?Fb00XW5HZcHYS7FnngrrArYSNpBMta9k3NytVyttcfd/1wLxbGXEBT1ykKzE?=
 =?us-ascii?Q?R5S1rlyzu3AWucTVkEQbQNyZDZGM/x1jU2ksfJWrURHwALlW101LY46tzc6k?=
 =?us-ascii?Q?gdO18s+gub39RcH2fCdFOf5ph119Kpo8xdtxogCSazmdjCpKqPTP5zCDoRTb?=
 =?us-ascii?Q?AnfL9/TeGyjvk0x20z+CV+vQq/K6SwX+iyirUhpiVp9kgTiWwkHkUE7FVJM2?=
 =?us-ascii?Q?gWw1cXFlRvWa++yVEngBfGshkNUUe2QidCqiszJLrMZxmOJWPS1Lx+JtdAig?=
 =?us-ascii?Q?FxoS+Gih8YocKqMSACntHeY7FMKkaLD5yS4v+t5TufRBDPFdymQW7x9RbZrx?=
 =?us-ascii?Q?6XadNw1BFmQQGPFBxfWINBvCB4pPFp7+HUwPW0UrWf4CdPbyv1nLkZ3SBQp1?=
 =?us-ascii?Q?L5okCZnLPZ7goaZxukkcI36ZKbGq4bVYzj5LDKWmpVf79RH35LFsKjGU/tE8?=
 =?us-ascii?Q?KTPaZ67iJHfNztHuxLPoGlBzVsksDn3XPMRXM81FoPzCsHdZLDYu6RDc6H9q?=
 =?us-ascii?Q?fiStKWQzFL2Ki+xQw40BQ474nM7jPEiN/Mha1DgdsmdwUFMixAFo3CAg2fsZ?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dced2b8-9345-4ec4-d77d-08dc70bca63b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 06:44:32.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITJHTy28bC3h7qt8/Z0U07/UFemv0gkVeFFuxuhyUhI5CYmgYD7g+HIdbFhQNri/QCMw/URWi33mC+s/L8OpT853X5d1quQeNzTHpifflLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8106
X-OriginatorOrg: intel.com

On Thu, May 09, 2024 at 02:00:18PM +0300, Dan Carpenter wrote:
> If mlx5_query_hca_caps_light() fails then calling devl_unregister() or
> devl_unlock() is a bug.  It's not registered and it's not locked.  That
> will trigger a stack trace in this case because devl_unregister() checks
> both those things at the start of the function.
> 
> If mlx5_devlink_params_register() fails then this code will call
> devl_unregister() and devl_unlock() twice which will again lead to a
> stack trace or possibly something worse as well.
> 
> Fixes: bf729988303a ("net/mlx5: Restore mistakenly dropped parts in register devlink flow")
> Fixes: c6e77aa9dd82 ("net/mlx5: Register devlink first under devlink lock")

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/main.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 331ce47f51a1..105c98160327 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -1690,7 +1690,7 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
>  	err = mlx5_query_hca_caps_light(dev);
>  	if (err) {
>  		mlx5_core_warn(dev, "mlx5_query_hca_caps_light err=%d\n", err);
> -		goto query_hca_caps_err;
> +		goto err_function_disable;
>  	}
>  
>  	devl_lock(devlink);
> @@ -1699,18 +1699,16 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
>  	err = mlx5_devlink_params_register(priv_to_devlink(dev));
>  	if (err) {
>  		mlx5_core_warn(dev, "mlx5_devlink_param_reg err = %d\n", err);
> -		goto params_reg_err;
> +		goto err_unregister;
>  	}
>  
>  	devl_unlock(devlink);
>  	return 0;
>  
> -params_reg_err:
> -	devl_unregister(devlink);
> -	devl_unlock(devlink);
> -query_hca_caps_err:
> +err_unregister:
>  	devl_unregister(devlink);
>  	devl_unlock(devlink);
> +err_function_disable:
>  	mlx5_function_disable(dev, true);
>  out:
>  	dev->state = MLX5_DEVICE_STATE_INTERNAL_ERROR;
> -- 
> 2.43.0
> 
> 

