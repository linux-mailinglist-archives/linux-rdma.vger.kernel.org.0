Return-Path: <linux-rdma+bounces-16550-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKmFAte/g2kouAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16550-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 22:53:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A41FCECDDB
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 22:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 117D0300ACBE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 21:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA0352F98;
	Wed,  4 Feb 2026 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UScGCgUA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD892BAF7;
	Wed,  4 Feb 2026 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242001; cv=fail; b=CBzY3JcmWLeSDxE1TKeCg+RRMMi5WELzliHnP2cwiJK1EL3M6c0kn+la0K/4pUZsmWPBrR3bOqmll3xJh4R00J72YHO8Frb/JFiJdTmOrDq0QnDUO7MPtTuWsIVHQ3DaQLYd7cQIiSrPIx256wxwNDlU+ToEQaAxmtQpAC9dsiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242001; c=relaxed/simple;
	bh=nNlzOHSnIrOa+oMOoZqeZw5fK2OXTd/ahDXP7ssJJxY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RUqvPot9uFrN20DQXXuSszcmZqDm/+i8m+pBoiLPvDYyHMAjV+3A71oT1FuzVgS1qs1NZxo8rhhuboZxiDEz3nkpvAINLUceA4D1TxYg7B588wzvhB3pC63EfjTbYs+UskhOO+8BFA4EnStu5YACvTAAJleMv/XaUXulEAMoPYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UScGCgUA; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770242002; x=1801778002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nNlzOHSnIrOa+oMOoZqeZw5fK2OXTd/ahDXP7ssJJxY=;
  b=UScGCgUAKRf8v9NX11HLkEGo6Z5Shl2KhxWHD95Q+qmbLjsF/BTYfxlJ
   g3DlAaYTWmsTeH8VyC/NoK+pc02VXww1YJ8TW5wIwPowmPnUavXdZmqQs
   mzGU58cOftrLTaUIRuznHdOfgovTr0QLCbo63xThLke8VP9Xo9J9Lmacl
   q6hnPmmbl9KMGACfjaN+saj6bNmWUaA+X5wKImB1A8qNnzIIvGOklxPO4
   XbMi9z4tM8jPY3e5HfLBw5bsfzCiSSChiY5x/t5+xb0LRayFC0qVtKw3t
   NUvH4HRAuGZsLrbILj4isPjIMdOoDP+lRGQWWnZWmyV08Nm7paEyESpGz
   w==;
X-CSE-ConnectionGUID: cY6GRO92QxuWNhkEEqJKRg==
X-CSE-MsgGUID: YGXWB91/Q8erIHCXcKhQog==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82553445"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="82553445"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 13:53:21 -0800
X-CSE-ConnectionGUID: ywIXLYKNRbinDJwXqWwVEA==
X-CSE-MsgGUID: Jmk229PMQ6uBRWLyCt9crw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="210275347"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 13:53:20 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 13:53:19 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 13:53:19 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 13:53:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3fvIHL/IXtMaAtimh3ksfCdDYuZppOb4pWe6rKeoyqVA2EFbybyv1Wv/0gwb03YKdQntntqZIcQbcqNoCwQ1abSsYts6Rei3setYU7uA4gy/ZvtLuRbCM+qw+7ia58HhiUODSOCqH63Yh4MW+ghhsI2s5K4ksFf5zROwwKsFB0PtN/df34k2t5QrOikwxn1vG4P1d9Qe1l14GnPeQtbniKtueuDCIw8CabUkT2x4vKGW58uwATV772+BcqJqHxAEqcoxnGnc6vTztbi/QokkJ70FJDC2Z8sgoxMBNC+Ugl9/w9MEj6rVrTD04zuE7ys9hz5UhYb1/II/geDoP6rOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOEYUK1UjniWn3UnTo/5g9NcvgMcy7Y0apcTj2IceFc=;
 b=Tz7WpzYLSwkTyaivSeAXB07qH899F9UUjIisPYDJ5Al28AYwA1+at58vzH8VHOw0r3zNk1vu1W7Sujqp/fEtQYDxR1GPZ+oy8r6EEPH7cPCB9abjHY89B+Y9Ds1Qvji5L26OHEbW2vt7ZMYXJFaqkr6KImLl0T4cnt7yE4/05jpfSjNofWqqCSzQYkNx1rlWMqolrkFPgkZZXUPde2qXFs4D3ktFNXVpP2g6fBgZgCggA6/H98PmeaFOFoF4md27ejrcleWPX73+JCGZIMmLyEFqAMwr5Zi3z6jatGKC2iehBC6YoCCveXSjGDMqmdJ95RsyvNsCcDrKJjCxx/gLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH7PR11MB6608.namprd11.prod.outlook.com (2603:10b6:510:1b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 21:53:16 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 21:53:16 +0000
Message-ID: <e2048f08-22ce-48b7-a5b2-dc933fdbda54@intel.com>
Date: Wed, 4 Feb 2026 13:53:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2] net/mlx5e: SHAMPO, Switch to header memcpy
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <20260204200345.1724098-1-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260204200345.1724098-1-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0354.namprd04.prod.outlook.com
 (2603:10b6:303:8a::29) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH7PR11MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 646cdd43-b311-4d4a-e984-08de6437cd5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2EvclJkUW9WYzZNWVFROGlDWXZZMFBoWmQ3bHVUYTVvY2pUUFZtNDJuRGVh?=
 =?utf-8?B?QVhUZUpid3FtVEQ1Y2RKSElUV2ZHdy82UnoyV3d2a0xrRUFYREplb09JYzR0?=
 =?utf-8?B?MzZhNTBESjQ0TnJYSG1oZmVYNzZWUytuN1F5ejFZWE1vK2YyN0gwNHF2NEw5?=
 =?utf-8?B?bHpBV2l0czhJTGxSNkc0b0U0MUZzKzN0MDJEMVlUM2xybFJ0Z3VDcFhtS3RC?=
 =?utf-8?B?bjV2K0M2b05uMUhsZWY3bzZLTlJQUXdCSFVnN1BvR1NoVkxxclB4Z3pETlpn?=
 =?utf-8?B?dFdhWnlNMjJMZEZvREE3Z3N4aWV5aUZpUDZmOEJwMUppL21HdHhsMk9Wbkoz?=
 =?utf-8?B?Wk05R0ZuMnVJM2Y4TWozajlzYmVZd2lUZlpSWXRXZXQxN0M1akFVNnQwU09B?=
 =?utf-8?B?SVh0ZzZZQTlTSTI3Z3BYajRBM1BEVTNWODBoR1VmNkVMdHEwclEySGgvdVln?=
 =?utf-8?B?OHM2RkJta3Z0RFJJazFGYi9MRzNCSUtRZUlNOW1DSUNkUDRFT3NYMWxOMXBU?=
 =?utf-8?B?RC95RVNubGJOVlJHdk5vT1BMQUJJMTc1VkpZbFUwR1hSQlBLY0tLNDA5UERv?=
 =?utf-8?B?bzQ4ZDB5cUpOZ2Rrd2lzb283aHh6L0VYTjNnTjNRb0FnR3RlOWNLSUhYYjA1?=
 =?utf-8?B?RDFsMmRHdk10UnlUVXoxUmU5c1hyUXFoQ2Y2aGx6c1ltR3JkVGVDcmplSkFK?=
 =?utf-8?B?c1dyTnJNdlFseENzNktTcFA0MnBXYy9HT29hVy8welN2a1pNdVNBVzg0L1pT?=
 =?utf-8?B?MUNLS0pSNitGcFVaMFNqMEdYdW1EK0pWZ2I1UmxUVlNJR3VtSGh0MGF1bTFy?=
 =?utf-8?B?K24yOW4rdlhmYzI3bUFXb3JaU2E5MjFqdEkxZENqeXZ5UFNHd1dBaU4vRFkw?=
 =?utf-8?B?OU1tMFVyUk0ycUduYmloV05tbEdMVzlIbGlRZloyZFVqcmxWczdYLzNmNXhM?=
 =?utf-8?B?cVFqekh3YlBEQ2x1MmY0bmcxTWNwWkFKKzd6KzNMRElZM3hNM3VTNnk2aGVo?=
 =?utf-8?B?YmUrNndad0FGaUo1WXc5L2xnZFpFaVN1a1hlZW15c1RHaFF1bHdIU09zQ2Zt?=
 =?utf-8?B?L2lEZlJUcWZnZWpPMjRGWTZxUVBrUGV2QUZFbDlSVkxRckZiamx0MVJ6b1Vq?=
 =?utf-8?B?WXFNb1BFeGUxR2ZsS09zY0lWYmZrMW0rY05LTURPWkUyVklsK1pFdEtLdFZt?=
 =?utf-8?B?VjdqM3JjbHJ3c1FITmlLS1hvSnFJRGYrejRkT3gvOFVieEZyVnBVcWx6amU4?=
 =?utf-8?B?MFIyVVNCaVBqckNad25pbU1kUUFHdGc2LzFxdDUxN0xCeHZJQXZ0MlZBdEpI?=
 =?utf-8?B?SkdUeUJ0cVViRmhGWm9OR3lvODZ0ZkYwbDhHZy9iMnlua1pIVm1YWUd1cVlq?=
 =?utf-8?B?WGdZaFlkYlNyMDBPUHAzRms0UDVHSmFiZ05NTTZrTjVKdDB3aU5pRlByMGpX?=
 =?utf-8?B?SjVFMFJUb3lhdDgzZEVmeFZLWlcxbnhlS051anZ6TEpVQUNlOGpuVlBsMFJJ?=
 =?utf-8?B?M25KZjJVekNKOGhrODBiQU9EWUg3aXBuUWtnZ3NLMUlyK3pFOHJ0aTFjVDhY?=
 =?utf-8?B?U1VKV3F3Ykg4WXZQS2lPOEFpM1c2R2t5aDZ6K211VkVWSGQ0OWxzeXBEK2x6?=
 =?utf-8?B?RDNwc3pLL2pKWVBuQ0psZ0M2cWdMaFVSQUhPUjF4eXZSMHJ5clpOVVB0bnVj?=
 =?utf-8?B?N2tQazkrN3VnVTRlUlJ1WU5MUGQ1WWJhSzRnK3lQRVp4a0h4dmFQbUUxWnVR?=
 =?utf-8?B?UXFHTzhLNXh1b0l2UUsyUTBmV0wra3hkME9HSmwzRElNSUlNbzJscEFodUFQ?=
 =?utf-8?B?bDlWeU10WXhudTN2NFI2UGhma3pmanQxR3h3WGNRTC9ncGFQSUFvQlkrdjlW?=
 =?utf-8?B?VEp4d3czUzZPelBaaVRRcUpzR3Rhc0I1ZEtlcnNiWmZyVklydjVaTUJ5cE1x?=
 =?utf-8?B?a2NueG5XV21qSlVVQWR2QVNHRW9lN252dGk2MTZkTS9oMkUwUU5xVkRKRFRY?=
 =?utf-8?B?MXBPSW9QdVlDN09obkVwM3B2eWpaVmtVaEllRFBYTkQ4NG9Tc3JpQUhxK3hO?=
 =?utf-8?B?ZU1sY05vejNKbnZFS0ZzR3YzL1RwcUxXbG41WFUwR3VOczhKVE1TVHRLN1d3?=
 =?utf-8?Q?zQNk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlBQRXkrQ2Y2Znp5eTBEWWpNeFkwazRKOHZPT3ZkQUxJT1E0YlJOOVNNL0x0?=
 =?utf-8?B?TWx2cW42ajJRU2NrNCtvejVCNzRRR2tpYnlKcW92TEZVMnhlK0NDR3Evc1Ji?=
 =?utf-8?B?bFpHSlV6MWxoSEhWZU1udVRyK2t5cDByd0V3ZzR0TVpNL0lha3lQaUlQMXNO?=
 =?utf-8?B?VjRJTXlNTFIwZVh0dmJ5RTUzT1VRS281UUhzczJpUXQ3Y00xM1dDaWhzMFc0?=
 =?utf-8?B?NVhac2xkd0VZWVRFUExkUHlIaFZTY0NHeUlGaFQ1WmI2cTdvWW5aYjJPRkVP?=
 =?utf-8?B?UFRKemZybHFwbmJjYkNDN05vd25mUGEzR1dpRm0wT1BBY2ZZME9UQkFNbVBY?=
 =?utf-8?B?Mms4UlU0WTNzcXMzdDdCamkveUpyeGxXOXVkUENIdEczcmJmK2lGeTdsbHpR?=
 =?utf-8?B?VXhzNnNoU0JwY2pJMTVwWkk5eE1idjhmdzdwRVBoOFMyWUl1OTIvaEF1ZVY5?=
 =?utf-8?B?RjRNSEZ2MFhZZ2FjVXptRTY2VGwzVVBsMzh5YUhkQk1xZHFZVG5xTndpcE9M?=
 =?utf-8?B?YTA0ektjU0F1N3I2MUY0OTZWeFZyWW9UTzFRU3Nza2ZacUNMQ250a2wyUmcz?=
 =?utf-8?B?QVVtZVhsdVFJVHduMThHeUxqTVFnRnM2Ky9wWTlMUkpXdllmU043ZTdmM0hO?=
 =?utf-8?B?NG83akRtdmRrdGVvYlBDWHlJd3Rkb0V1TmxLMHhETlpiRjRUUFloaUk2Rm5x?=
 =?utf-8?B?MlZYclVoZVdwUUNuNzVkSGtVcWl4RFlwMFF6aTRVSEhsRU9HZ3MzaFF1ZVNT?=
 =?utf-8?B?cWdaSkFjYnVYWVJQZjJzNDJNU05pK3NZK0FDWkVQcDJ5TnZ4R2MyNDN0ZTNP?=
 =?utf-8?B?aWRKaU1PakQ4SDlnVEpoUVdrNWV0SUErSWV0dy9EMTIwYWZLVlpNR0lCVURB?=
 =?utf-8?B?TmgzSWg0R1JnZUJqYVB2cWZrdjhoSjdWOU5rTCtrMmxNazIvcmV5bGZlQ0hG?=
 =?utf-8?B?SHFBQUlhczlZMXBsK2ZnVGFubG9LUFVhckJoTUwvejMxakphUE5LZWErZ3Qz?=
 =?utf-8?B?bjAvRlBZQStTUWNEcTFSQnBkSEJtdmZybHFDVUY2c1lIT0JGYnZzSVF6VWZh?=
 =?utf-8?B?eWt0V1Znb3JxT1RxeUtHM3ZCMXB6RmN0ak1wa0I1VDI1R1JINm02WnJ0ZElI?=
 =?utf-8?B?S3dzSGtGeUV5clVVUU5nMU02dWpkclMwME1vVVhCSVNhV3d3N2dpcjNkRy9X?=
 =?utf-8?B?aVJvamIzaEVOa0NDZ1hWOUZlVit3U09FM2VOZkQ0dVFBSE1XRjNGYWhJK3pw?=
 =?utf-8?B?UkhQSTcxQ256Y0NyNFN5T1ArK0Y0Z0xPNTRuVmNLZVRmcGxSQXJFbkFCbVdZ?=
 =?utf-8?B?V2ppWHdQWERxU1lRSGRjRnhOWXFYcUNzTEw5YVl1bXFuSkZWY0c5bmhoNStJ?=
 =?utf-8?B?cm44aUZOdUhBaGZqMHBWdTN0MWJZanBEVE1FSzNWQ21NbHBpSmVXRUtycGNn?=
 =?utf-8?B?ci9nVDVsSVZiN01GZEYyeUY4S2c5bXpWc2tjdCtscDR1N1diSnRSZWxSTWEx?=
 =?utf-8?B?RlZqUWpCa3p3b0FZNDBiQXc3TVFzWjhYbDNDdktSaVBBSm5BamdFQ3hsZ1JR?=
 =?utf-8?B?M3FMaE1Cd3pIZ2ZtODliZzJYN25KRVV2RFEzVXVSaE9UN2hNL0dQMmRlTjc5?=
 =?utf-8?B?amtCWXlsb2NCU3dsNWJ4Tm5hYUh0ZWtYa25WYldVNHNGM1YvdUY5WnVBTzg3?=
 =?utf-8?B?cExUN0Y4WVVhUzZpNEd5dHJ6Uy95aFhjZjN4S2ROdm5tNDZDM1BVVUYycHZk?=
 =?utf-8?B?ek5hQVArR2xpc2xoZ2xDd1pRbGg2bmxvT0xEc0NSVVI2NDBDaFo1VUNaQWpZ?=
 =?utf-8?B?eG02WUtGTGw4N0VWV1ZJb2k0bWJCekJiYUdyOGxpTWFTeWowazZOMENhbnE4?=
 =?utf-8?B?MHpndDVZR1RzaURJYk9jZnhMOGtiSmNnazNXQjVLb1BzZzREd2tJQ05kSlpm?=
 =?utf-8?B?RG1lV210SVZ6b1JqUEFlVzA0dk1OM0JLUzkyV2plYjdzeTJsdkpBV1N2bklv?=
 =?utf-8?B?Yk40aiswajlMTFU2QUw4ejFqZmtiRnRsSDhkaHZvK2IxZENaUmNXYlR0eGVM?=
 =?utf-8?B?eDYwWVNjS2Q3amQ1WE5ReG11NktwQWh6eEoxeVExaUw0VzR2Qis3cGtUTDlB?=
 =?utf-8?B?SWt3WC9CendMc3dqVHhSNzY3Vi93R1RoeGo4d0Z2cHF2Qk5zd0NsdW44aEQ3?=
 =?utf-8?B?VDhRQ29Ec282emdjby9RdFp2QUZ2QWRyZlNlTE1tVkhNL2hhaGlUakVDUHlH?=
 =?utf-8?B?LzJsV1FXK3E3LzBLWTVGdjJHNmQyelBWOTcxOGRHOHZBaXpoWlhwajhZZTh5?=
 =?utf-8?B?ZU9zVlovcGw3a0twaGR4V3F5S0tsdWN1bHdJaUNoN1FMRlNkUlpwb1g5VmlC?=
 =?utf-8?Q?/7bO5RSsxeVfoRNI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 646cdd43-b311-4d4a-e984-08de6437cd5e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 21:53:16.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlgRtoQbF1aj5GeRcbzHfKvX4Eo/dtPXs+AvROM0XJ3M4AfOM48+McvJo90/IOH7kGoYpIIxiePD3Voq1EhYxlSjKG69OjTA4vMSMWYA+gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6608
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-16550-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A41FCECDDB
X-Rspamd-Action: no action



On 2/4/2026 12:03 PM, Tariq Toukan wrote:
> Performance numbers for x86:
> +---------------------------------------------------------+
> | Test                | Baseline   | Header Copy | Change |
> |---------------------+------------+-------------+--------|
> | iperf3 oncpu        |  59.5 Gbps |  64.00 Gbps |   7 %  |
> | iperf3 offcpu       | 102.5 Gbps | 104.20 Gbps |   2 %  |
> | kperf oncpu         | 115.0 Gbps | 130.00 Gbps |  12 %  |
> | XDP_DROP (skb mode) |   3.9 Mpps |   3.9 Mpps  |   0 %  |
> +---------------------------------------------------------+
> 
> Notes on test:
> - System: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz
> - oncpu: NAPI and application running on same CPU
> - offcpu: NAPI and application running on different CPUs
> - MTU: 1500
> - iperf3 tests are single stream, 60s with IPv6 (for slightly larger
>    headers)
> - kperf version [1]
> 
> [1] git://git.kernel.dk/kperf.git
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en.h  |  20 +-
>   .../ethernet/mellanox/mlx5/core/en/params.c   |  23 --
>   .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   1 -
>   .../net/ethernet/mellanox/mlx5/core/en_main.c | 287 +++++++--------
>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 341 +++---------------
>   5 files changed, 188 insertions(+), 484 deletions(-)
> 

Faster and less code is always a nice thing to see.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

