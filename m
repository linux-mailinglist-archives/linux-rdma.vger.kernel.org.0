Return-Path: <linux-rdma+bounces-2954-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD578FF3A5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 19:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D6A284BE2
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937061990D7;
	Thu,  6 Jun 2024 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mab8GGgL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDFD197A8F;
	Thu,  6 Jun 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694741; cv=fail; b=s7NEuGTl0Sk741Wk6Sk2ePlNP9vPKhQCLFrBdTVzAXbjqZXs57guf0j0mcEH0xtayyfPspYkHEwZbpZU4d9czozlVq7eez0Fw78PRI/q6EfEI5AdzbdBs75kPyRoObrR/FzwvoJY8DINnTREfAKwUjuARvkTIWvj7hY3ZA0/xJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694741; c=relaxed/simple;
	bh=SXl5+H1gPOp+9KAtV6lux4inQ6Eo+QmnDx9cy9vC1os=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kwgcHPQHakRrjhwzrciGXL8foATYwDSTfOdY5cfGPIDeyYEy6jrvHlXOC/dwObNuv4kJX8xbOih4g8zjrMCNK9LvTvLxkcjwl3lOTbypMY0j6DGBJen92uSAx7ZioSokU5OneQ1Y7TTdYuUEv3Ex5w7NOMaLFYtUXlDYDQdzatU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mab8GGgL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717694740; x=1749230740;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SXl5+H1gPOp+9KAtV6lux4inQ6Eo+QmnDx9cy9vC1os=;
  b=Mab8GGgLxX/ixU3e0bTRwHxc1jxi1825ZE+wcK+56Q9ue2vZTKpWBV+e
   mx952qeKKl6K2JGhuXK1mkfcqr0zd3MgFosvdjqpeiDR/9brmy5echRpF
   3vCMnmUfCJwCeHhOgR/2Fs8cD7s2JewKw5gcSDkG6Sla2KT9Q0+WklALu
   6TrsT78FyyIUwPxLH3lP5I8iLYFstW9f8WtbUkMMB3tNn+/8d3AKvGPjs
   Icy4+zD/rmJlmup67JC5Nt2SEdCRSA/BZ1jxTQum7yeibmBOF6EmNkb0F
   XMywTp/RIUZhZFrTKLN4CViGPNRDH2drLq1yTU5CRmqlM1Ol3wn/grXoT
   Q==;
X-CSE-ConnectionGUID: 52aJPgiUSz+1J6UnPK6zzg==
X-CSE-MsgGUID: 9d/T9ZWFQ0uayGFG1iE7Ig==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14565374"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14565374"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 10:24:52 -0700
X-CSE-ConnectionGUID: XDOphvHHR1Ot3BAjY/5pWg==
X-CSE-MsgGUID: nTN75uK5Rm2JB8QP6wD67A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="61249209"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 10:24:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 10:24:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 10:24:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 10:24:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQtPKpZ5szsiJ6BXB7jJeRG/dez2km+8OgA3vBN3xMZD+DUp1W3L+/Wi1rY143VUK5zJhv9WoW5tDZHRT16BVc+GRt6dQZsia7t6vLF/KyH87ac6UMwkrz+gU0IU4U+i+f0U30Avn+qewoZibwwe6BGFKgUrt1bjUdCOgv3WBa0HdRhNgzjvvox7i9i3+SlkboUC9EEJBWp/2vaaXDX63KQRyctacpz5+kdxvgenh0L8EOdoMrubAcAQ06czQgAiUlp3AuuJYaudIWwzLLlJ4/33Rceh61RNF9lvUVJ6Ifkn65pD49jD2filZouptmyyJvLWOmKKomBPFhbcxo0cFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S44lXLLsFyEnUjvm4BhGIjehPZrsNYEuQH+9rfRYnso=;
 b=FVh4Fa/evF9PCTD5HxvwqhwcCSE7LsN0r4NoR33ImAV1Y6Zqgb91mDBa2khgAc+uBTIYDEYjRrcSy/70dL3+Xd53nhpCvUg0a6knQtM9Z8VEku0j8bNFAHhKpiIwvO1VTUTR9YluXFyNM6hmPIHijCOqyGkOwVY7INwGr/eOJJXKX5PlH6ylayfSsELGH06Bw/6Z+K05991CzKHL9A/EXwtUEmJyXO3/MhbvvgArfnKgKE7ngrh3vMC8pC56Xkqt6g9TygVAlzw3rWpJfS8qj3Vm9d4CFKkunNXYMNU7vgmuqpNxbqFcYkTpgLBmf+wl+WJPVgovkVnubs8yMxBU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5771.namprd11.prod.outlook.com (2603:10b6:a03:424::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 17:24:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 17:24:49 +0000
Date: Thu, 6 Jun 2024 10:24:46 -0700
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
	<lbloch@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <6661f0dead72_2d412294ec@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <6661416ed4334_2d412294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240606144102.GB19897@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606144102.GB19897@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0289.namprd04.prod.outlook.com
 (2603:10b6:303:89::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 2730e3fb-d6fa-4aff-60c7-08dc864d915f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wGEfVMmJKDskyAvfi/Rd+3g4IX2usUtm/nq21QaTFNiUr1i3FMq9/pvZT0bS?=
 =?us-ascii?Q?PuSenJk5cK3WBBHWyhgc9xqlUtfh0mQdjhQUcWLsPdfdFg2cc5BvAatYdlVT?=
 =?us-ascii?Q?4Z2jn9V7a4L4Q00h1nCxhrExbdS4MDd3Ck9t+ShmsxAa87KT/NA2/1LCaCuv?=
 =?us-ascii?Q?U+PR+ZH0az0Wkg0sDsCkkxApcXHFN9nXkMApZH+I2C6pm9qB9Cf/tp/Wxo8z?=
 =?us-ascii?Q?BgeQUn9eEeVN64MGseEcvy+BhP3IgbxK4f1r2RWua4csfJG/p9M0Lf/maMNS?=
 =?us-ascii?Q?wggPvpbP4DG5zjqoIQGcS36FkoHL7DwVJ19D5M9vLQVJenoR65wxV3JQg49Z?=
 =?us-ascii?Q?DAhUqrpaFxZb6IQh/dPQaDQ6/HHaOV32Jv1Kicbf+Asp6/TXLYvf7dp7ltVP?=
 =?us-ascii?Q?tdoCmXuFkFl/D99+AlpErTpK7iuhSp2OLuVfDTyL/PK0GZoWdNz5gOwn4AkG?=
 =?us-ascii?Q?T2HseBXAGhnBSdWOu0MuXvn10EkeV/IJAG10TZ4SxpYutwjm84LW2l3vjFzE?=
 =?us-ascii?Q?Wep2S6kNonrXqHFxTaXogdn5A/t479SYcfw/1giuSwWr2Lkbs0DpfctaOw7R?=
 =?us-ascii?Q?KRpaoFvmr+o7tl3GywB4c4xfN2JdJu1HrZSUeMcTXxCwvXartA6JLCZVXyTr?=
 =?us-ascii?Q?QAV2ib8NHmShgm6g+nGgie3oiJqbF6qyTJl9mt0MRctGDJAaExP7/eL2Vzbj?=
 =?us-ascii?Q?IwbGtUFkBW7h2qW3RU2TsqD9yLJRqzBM5niqAfhslXQp4RQhvPb5jlGlVDe+?=
 =?us-ascii?Q?nXWTwd0aubjF2aEGebmfsra7kAsOmuTg6gOoo5RKtbA/LKX44W7QdciwkdIy?=
 =?us-ascii?Q?h4SsgvOKtDP5wuUsdjF0YPnW8+L/lOQhq0HRVpXkEFy499LSzmVEVuZFthTP?=
 =?us-ascii?Q?HXqFaMHFCdeAY5mLLGgv1IFL2Zb56teMWLEdNz6Wj1I9LaLQaMlhDAiesuMj?=
 =?us-ascii?Q?cEmpgUZSL6gzaFZwQNAlxyZqvUGSx/bUGuJCg8NJIoPQp+2EoKBK6Nbgq3po?=
 =?us-ascii?Q?5MTIuH7jHw5KpWZGO1ZQ8v509/G4nhNfEERxeNqKFuo1DEJJIQ8QDCCfTYjW?=
 =?us-ascii?Q?Vn5c3nPGyfkYgrZ7aPTQn42cqQxh1R94SB/ZEr0t33C3/AfbUNbVj41vz87z?=
 =?us-ascii?Q?nnKqMFBtDxd0VTSzXQeQAncjejnSoabB/43LFI5o7rDkB+GvM6Ng/H1gFe+N?=
 =?us-ascii?Q?fjAAHaeK/8QjkWo++lMfXEk1gBLZKS7hK2+yUIWNDEbdBv4ZDgVMf8LgjWRI?=
 =?us-ascii?Q?iLOJQqnP/hqnLTwNOOOMzPEqwGaVWaCNw+s7l765n0NUwrqYR3OVa0T+amQ4?=
 =?us-ascii?Q?xGnVEqpMxh9jdZD26lCPJ50t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q5DSM+JNHHdHK+WLPnMCyzEedAK/nODQCvVpGh+/mt5sHK6/TxOXE+GBzR9A?=
 =?us-ascii?Q?p3j8SogUbUs2NlPPr7bfSVk+Ji/MZ0O8ZfILmWA5c2VGdVc0GCSzCewcXmBN?=
 =?us-ascii?Q?6rjOZgo8IrX5/sE5S6O4Aw4OSPYaXFREdMSKhcIzAFfcfab7GHBotsbtwMc/?=
 =?us-ascii?Q?Im/S5qcsGuuCXzT4hqk3BM6LBKwLiC0cIVuDs64q+yaLH1QpssKwn3A7Z3qP?=
 =?us-ascii?Q?4Ay36BqbXm4bCPuK4uTSeHb6xnKVmxsR3CbE6CB4n9L99+e72wooLxOugdJL?=
 =?us-ascii?Q?OIGPJMY+/38PIsCqllld5imeLdd+fF44kjKoX+YRKzDebwzLd+8w/mq/9MVl?=
 =?us-ascii?Q?LhmeEL8M6lnSWWWriHQZAsMllmaOJJqJGqqJSvk1kFdFgOMz+bW5r0ZxX2T6?=
 =?us-ascii?Q?kd1OPduCp9ePB5HoOyUziSiyC8p/XJjo+il2npLtDXVBuieuiASBL3scC+E6?=
 =?us-ascii?Q?0YW6qq6l8H5iwx3XBASkJmqd3+SDhFdijH1dtZ/N3mgDODbgREfeNT7oYVgu?=
 =?us-ascii?Q?ouP90OwmcOH0CaCZ9xlt8zF3WVAeAHGPg4XR/0O3y9wLdHfZ95vityTPXNkO?=
 =?us-ascii?Q?l3yl3AQeS8JbUiLfL/SrIVsuZltIoVZY8OywtWSfa16P0A0CbW7z2nIrz/C5?=
 =?us-ascii?Q?VPuBLmhit4/zMo4UEkwS8nPVeYR4VeBCX0OfJW/GQtVosFEsOxcDzDUlFkfP?=
 =?us-ascii?Q?zbnFjAmLAHRju55QUhRgo5jjOEffhxG3tofgMtDnGnBDDIPpeYRWcgBp2weH?=
 =?us-ascii?Q?dLvxFsxcEmg9B3Vz7gQbSV3cfvEViKaFRXbw0OgkW3xSS7v6IaRVZxP5ZvK7?=
 =?us-ascii?Q?cuZGRsbWUm5dmcFzuG7E4ETcR4Nem1CK5ncbh6m/F8wAF9vihSnILFW9NsIj?=
 =?us-ascii?Q?qVtpUVZuRUGfgUJdmTlZBS9Kay28I5XKyrrVesSqm/9FNl1yHIlSKZCGIqys?=
 =?us-ascii?Q?pk1hoVsXt/R+BYpnTXGTqmWCi3qWdahy4jr/1XXTBI8T/AyF5DL+RkGWIGXy?=
 =?us-ascii?Q?2HFL/tTqinIUJFFmtCS1QyLotKLqXCsIf9XKuRpskW4qQuhwBkzuS1wrdsqi?=
 =?us-ascii?Q?0VVnazf+eDBjsThECRjQzd3xFBZ2zwPrEHjrzemfiSVWkF6n4Ws7EDQKJEvD?=
 =?us-ascii?Q?LI9QXb1Sm0WKPzVkoNkM+tlaYpekvmmyOl0QOcT/e0K88iequvdu53canuLe?=
 =?us-ascii?Q?xsXHHIDw7dbi+oi3aCJyU2s5kZt/ZsLou4r/Biwp9bJhddqDDwL5F/4tv+yh?=
 =?us-ascii?Q?UwWu7uHTw/WkT/WHp+aND1TPatGSh/iTRv46xBLk4MyY7qNZulq33WgdvWHI?=
 =?us-ascii?Q?KJOTC/6RI6c4mXGVr+FEUcm/FgWJk1GgCZphn+3UuKczAmzyag8Ajgy+tVF9?=
 =?us-ascii?Q?trWp3M6PKsfyXEdpH0rYCYMgtGCmFrLvfICwUp1vuD3A6Gbr/IvyoR2/T1Iu?=
 =?us-ascii?Q?sKVC0XPZafF0CbN5SNJX16b0Lt5rvafwt61en0aMCWceVY1B9YhzyCOJKGHr?=
 =?us-ascii?Q?xVHvrDzTKK5Pyxf5qspdG5B185nQVILrnXx3iaqqm1aekJGijEdBkybRG9Sg?=
 =?us-ascii?Q?Xej9QYu35XH3GV/Yy3JQ4Y/hsqW8ntqLektRMWP4mszOtojfIDmUeB8xXYXr?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2730e3fb-d6fa-4aff-60c7-08dc864d915f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 17:24:49.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzYJk78PnZo/LCpA7Lko3eCxXZ8iu09SzyXrFEQur+hcCkczWISZJG0JPrlAAcVHm4OIat0ySaW49yJYCOBdI3DqCcqxjWQi5I+Or9/TaqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5771
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
[..]
> > I am warming to your assertion that there is a wide array of
> > vendor-specific configuration and debug that are not an efficient use of
> > upstream's time to wrap in a shared Linux ABI. I want to explore fwctl
> > for CXL for that use case, I personally don't want to marshal a Linux
> > command to each vendor's slightly different backend CXL toggles.
> 
> Personally I think this idea to marshal/unmarshal everything in the
> kernel is often misguided. If it is truely obvious and actually shared
> multi-vendor capability then by all means go and do it.
> 
> But if you are spending weeks/months fighting about uAPI because all
> the vendors are so different, it isn't obvious what is "generic" then
> you've probably already lost. The very worst outcome is a per-device
> uAPI masquerading as an obfuscated "generic" uAPI that wasted ages of
> peoples time to argue out.

Certainly once you have gotten to the "months of arguing" point it begs the
question "was there really any generic benefit to reap in the first
place?"

That said, *some* grappling, especially when muliple vendors hit the
list with the similar feature at the same time, has yielded
collaboration in the past. So I might be a few rungs back on the
spectrum from where you are, but I concede that yes, there is a point of
diminishing to negative returns.

> > At the same time, I also agree with the contention that a "do anything
> > you want and get away with it" tunnel invites shenanigans from folks
> > that may not care about the long term health of the Linux kernel vs
> > their short term interests.
> 
> IMHO this is disproven by history. The above mstflint I linked to is
> as old as as mlx5 HW, it runs today over PCI config space and an OOT
> driver. Where is real the damage to the long term health of Linux or
> the ecosystem?
> 
> Like I said before I view there is a difference between DRM wanting a
> Vulkan stack and doing some device specific
> configuration/debugging. One has vastly more open source value than
> the other.

Fair.

> > So my questions to try to understand the specific sticking points more
> > are:
> > 
> > 1/ Can you think of a Command Effect that the device could enumerate to
> > address the specific shenanigan's that netdev is worried about? 
> 
> Nothing comes to mind..

Ugh, that indeed seems too severe.

> > In other words if every command a device enables has the stated
> > effect of "Configuration Change after Reset" does that cut out a
> > significant portion of the concern?
> > In other words if every command a device enables has the stated
> > effect of "Configuration Change after Reset" does that cut out a
> > significant portion of the concern?
> 
> Related to configuration - one of Saeed's oringinal ideas was to
> way that mlx5 could implement all of its options, ideally with
> configurables discovered dynamically from the running device. This LPC
> presentation was so agressively rejected by Jakub that Saeed abandoned
> it. In the discussion it was clear Jakub is requesting to review and
> possibly reject every configurable.
> between "netdev is the gatekeeper for all FLASH configurables" and
> "devices can be fully configured regardless of their design".

This gets back to the unspoken conceit of the kernel restriction that I
mentioned earlier. At some point the kernel restriction begets a cynical
in-tree workaround or an out-of-tree workaround which either way means
upstream Linux loses.

> > 2/ About the "what if the device lies?" question. We can't revert code
> > that used to work, but we can definitely work with enterprise distros to
> > turn off fwctl where there is concern it may lead or is leading to
> > shenanigans. 
> 
> Security is the one place where Linus has tolerated userspace
> regressions. In this specific case I documented (or at least that was
> the intent) there would be regression consequences to breaking the
> security rules. Commands can be retroactively restricted to higher CAP
> levels and rejected from lockdown if the device attracts a CVE.
> 
> IMHO the ecosystem is strongly motived to do security seriously these
> days, I am not so worried.

That is a good point, if a Command Effect gets tied to a CVE, or a
cynical workaround gets tied to a CVE, both of those demand an upstream
and distro response.

> > So, document what each subsystem's stance towards fwctl is,
> > like maybe a distro only wants fwctl to front publicly documented vendor
> > commands, or maybe private vendor commands ok, but only with a
> > constrained set of Command Effects (I potentially see CXL here). 
> 
> I wouldn't say subsystem here, but techonology. I think it is
> reasonable that a CXL fwctl driver have some kconfig tunables like you
> already have. This idea works alot better if the underlying thing is
> already standards based.

True, I worry about these technologies that cross upstream maintainer
boundaries. When you have a composable switch that enables net, block,
and/or mem use cases, which upstream maintainer policy applies to the
fwctl posture of that thing?

