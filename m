Return-Path: <linux-rdma+bounces-12038-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5757B008D0
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 18:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5829177984
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB402EFDB0;
	Thu, 10 Jul 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2fVSU1V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD22EFDA3;
	Thu, 10 Jul 2025 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165133; cv=fail; b=Nt+EIW7+cQgWbifHspR5cazVZWwhaBYkR8pu4BUGp/RJLCeSlY1SOIQ8J6wzh0ZC3lfbLXdKrTfjSxxhPqOqJmgSy/HcX5c/XDV9nzKj68hmGFuJW3SGtCugkhCs7ZBOu4dupus03i/J/t67JZYSfZq3ZQWtOIrqZmZUslDyBGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165133; c=relaxed/simple;
	bh=9yavjLMWPI8yN/eRk1WYzwkwa1Uhl3VqI6XA0hFOna0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tfba77RGpRsECZA6PMRd74UJqra0cyWy+DsUFxwWlvalcUTqtNoa2hPUbEQPgaW9xWvC+cKMjJHwy3Oz5FU95DVUsef32Ir4GhYQ9Dl/C7E5Q9yDf0w98xkz7deIAbww/Ghh8XHf7YSBenmr9KjS2XJjL+CfxO9UVI9trE4u7Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2fVSU1V; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752165132; x=1783701132;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=9yavjLMWPI8yN/eRk1WYzwkwa1Uhl3VqI6XA0hFOna0=;
  b=e2fVSU1VWcdjiol2D3EDizyXEhQLRisWfnwr25Q6uPURGuaIN+M1du0Q
   3++/ka4/pGbw4o9cAFI7fuUMvb/NgTgL1EFsj8sa3LsUNIPCkU528bxXw
   JHVs0dOrgPwO7PbNXiJn/lsbCOUdLlciQL/L7+NAvA1YpS2lccpzCM4x/
   ImsYnvJ33EnUUA/YMH+vNeH3YPRCsBGNQ/CbHSm/wPIbbPhGNqZvQwsIz
   3Ne7LanW2e1U6G/44f0I/+W6dPywasyMDL68zRAEH0PMFrwJhDLXXA8Xw
   oNLexmkT6sVCaJo+/1/2QphtOixZmroWbysgamJEAdhWYm4GApjoxGrJK
   A==;
X-CSE-ConnectionGUID: KnBJsGFcSpi4ve3neoVhAQ==
X-CSE-MsgGUID: zPgdq+aqRsO4clM/NkEQzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65904185"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="asc'?scan'208";a="65904185"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:31:51 -0700
X-CSE-ConnectionGUID: ZeEae25vRH+WLXtXSqF+5A==
X-CSE-MsgGUID: 9Ousmm9kQrSBKNgZiWg4KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="asc'?scan'208";a="156484517"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:31:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 09:31:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 09:31:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 09:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9a6Dbsbnv+sM83oHqOIjBKpnAqFXTIuZLZu6A4vrdM0ZpDsh0DVFJNUPGeZTgTq8g+pBdXmY/dGxTeVSYqP7ZFPeyxdPiaBTve87V+afRMXZ6fRCwXXE31jeH7pbwD0UAdNytp744LGOJUQ/5YWLURwAq5ggKpMugnfUWezU3/eHM/+7ePARy5R5wKNpy1iOxcxu6EoA96fkZfia0beOrgf0zbmzvVSwf3kDInVdgoy18mZWV50zOYtQcyedlbBd8Kkeus43MAztCf0+9vzSD1PKD4pwGlnRr2OnAQlKiJENerPg7bwsxOlNwSHJW81ZXoJPV8AaGXy1dAce/1KEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESnZj8ifFsgdcIITuYTCbh4iJ0FIrbTyR0GgFMgA618=;
 b=SR1QORDp917xjfgc7yorpkX9uUPQXvUzVDNIwLG94uM2fd4ldiqIgAwb4FaWtGfKvG0przRq3HvA315/Qb5BelsNhR7EbyUS24XnFpqNd82SXgeltvYck0D7bnsfy96PxuqMWnci2yLrLWjCGyeAF8VOi7ssZsBaqZo5MfULZm92nD1qbJo8yriYp0LbEWglOkfxIyhOUnDMmbiLs1uHy/JEcuOHjE5zqtCPjU6pS4TAlK732REwvuFTj7OLXAhPcZnxC3DA7DbTfFvtOmJ8i6+kJhoo1kYVRmj1F7EgkXg7PAKVmqjQQyBn0Ph8f5FbjNg6jqAA0Q03nWzRDZ0s1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 16:31:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 16:31:18 +0000
Message-ID: <a3262f60-31c0-4606-be0d-2dd14505329d@intel.com>
Date: Thu, 10 Jul 2025 09:31:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net/mlx5e: Fix race between DIM disable and
 net_dim()
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>
References: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
 <1752155624-24095-3-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <1752155624-24095-3-git-send-email-tariqt@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------dsrKHf3MenZetlYl0ZE063ne"
X-ClientProxiedBy: MW4PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:303:86::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f43c3b7-4ad2-4669-4dae-08ddbfcf324d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkNBZDJ1VGNzSGM2ODkwN2JmM3ZVTTN4U1EyenhvclJRMnN0Qlo0Z2FlSENX?=
 =?utf-8?B?MTQ3S3Q1T0gvSzM2UENjMnFwZmg1OHZsdlJRWk1aa3F1Q3l6TUZndlRpdUw3?=
 =?utf-8?B?eTFCQmhZL3RlSm84Mit3MlpybHhtdkR5QUJqRlMxanprakozaHJGaVdMZU1M?=
 =?utf-8?B?SWpEdUgwZ3FuUCtUYXZhZW80SmJuZlBSSmRFZnhFeEw1WUdPdjhKQlRIdWVH?=
 =?utf-8?B?Y2VTUCtOL3B4amhDMjU1N3N4WXlqMlFjcGZ0d1g0ZXY3VFM4UVg5cCtRUWNL?=
 =?utf-8?B?dWFBUStzU3dFY2YrMXJOeTRRM05oUVgvUUgvdEpPSGtkN1c2MG1OZkRoVjRp?=
 =?utf-8?B?ZGQ1NU1yWWpFUnVSUUdNSEpKQnFnSDJNOTVzRjFVa1B4bFA3MFJhWDdBUjlu?=
 =?utf-8?B?K3dFVitJOFJJRGpQVEZ5UzhJOHpDUUlQL1FSRlZFZjJSZFdjU1ZTTVFGNkR1?=
 =?utf-8?B?UC9TbVc0Mm1rVUhYaTUrZzVuVlp2OHpjVWsvZ3RCMFAxc3RtTjBCalRoSGdW?=
 =?utf-8?B?dVlKcW5aVWx1dWY0SnJKUTNjZ3dHRTFjT2hUMWNrMHhwYkx5TWNwYTFEbWJi?=
 =?utf-8?B?RnV2U2RRL2s1UC92d1pOZjcwZ0Zsa3ZQSkk3UUtBSFRsV3JKcnBkY0hXc1hC?=
 =?utf-8?B?NEx5SlVJRVRNNVJwTElYSUdWSUw1SXU1UU1NSDAyU1AxWHN5L05QVWhRa3g2?=
 =?utf-8?B?Z3NZSWRCU25GdWs5WTdxTFBHaHJOZ0FyUHRqdkk4cittNGtZdHAyNkhuSFdQ?=
 =?utf-8?B?UFJPTjNORDc2R0xIS0MrbU5CYzkzRnkxdGNQN0NJVjI3eHVPMnQzSnJpR1pa?=
 =?utf-8?B?RTBQdG0yeXJNS1lGa3hHUXFHWEw5V1RoS2VHeXFEcDd1UHAxckZPK254UVVS?=
 =?utf-8?B?MFVjdUEwMEVyeVdZS0hzTGJReFBPZVQzdFQwbnkyUHVHS0N5UnFnL21aZzBY?=
 =?utf-8?B?Z21yVVNoTnp4LzE2Yk1xbWlDQUlUUVpoS2M2d3JGd1VIQXdUNWRINkt6cTVM?=
 =?utf-8?B?bVRkcG9ackc4dGlQUnJWYUVNdk9jakZyRGRLQXY4Z1FTT1FEYzJ4WmcxUEJD?=
 =?utf-8?B?ZFN6bHNENngrd0xsVEVNdC9yRGJOcnFZUTV2ZTlMSEkyNEN0bTBjZnN1U3lG?=
 =?utf-8?B?NE04aUpVSTUrWkppUXJTNE5JRE1MVVUrREZwTlJZVjY0dkFiVnlKSU55TWlm?=
 =?utf-8?B?aUV2QnNQV1ZUeVZVQ2pOZEdUakVYanRsY0tNSDdRZjFSVFZHZHp6MG5SSUJG?=
 =?utf-8?B?WUcrWXVuSnk1MEFmY0UvZTk0TmxBejhEREV6bnNsU0toTXNyeCtmeEszdEhW?=
 =?utf-8?B?Tmo5L05Pb2NqcnRBT1E3SmU0ZloyYU1UMzJvK2FGV0dBbndhbFNjTTR5c3BG?=
 =?utf-8?B?bytWTG9iTFQrOUhFZjRyVUNOQjVsNS9ZdlRuWTAyZG9MQzZrQ1FlTFZBY01K?=
 =?utf-8?B?SHhPYUQybnY3S1BOMG9ON254R1lKWkZUb0U5YmMwZk5yc3BxR3luNjZKRXF0?=
 =?utf-8?B?Y2hSekQ5Q0xzM0s2VjJzcWM3cWoyM3ZMQnJ4T2xKWm5Ud0pJSlpqKzZzZ1dE?=
 =?utf-8?B?NEkwNE1kTUlONGpYeW12U0hEZGhZTXMyTG5oOWVFZit0R3pnaDNiUFQ3Mk0z?=
 =?utf-8?B?NW5ZNnBFK1hWbjRvdU1mc1FlSVFlK2NrNlNxakdlN0ZXRnpFVTgrNjBrNjlM?=
 =?utf-8?B?QjNxb3RNNk5reU94Ylp0UXV6N2VWM21SS1dqeTlWb2ZIR1RKblZscWJwTm9G?=
 =?utf-8?B?MUluazM1bHVJOXRWb1lrUDVDOEVxM3BlV0Q4bEMwdThWNVEzTXdXejlaanRH?=
 =?utf-8?B?WVdramU4bTVtTDA4M1lRUWxwMzJuekxJYnVGdldmVk0yWFVoS1lpdm5ldlhM?=
 =?utf-8?B?SGh0VUJsRTZsYmtTUnNQZGY5aWJDQnJUeG0zRmpCbmsxZmJqN3VsemJINEpW?=
 =?utf-8?Q?K9H9K9OBsrU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHh6U2IxcFNramlzNThYUDIrbTE4akRtcU5vc3c0UE1BZ3VZU2NPWjhJYTh1?=
 =?utf-8?B?RDh1cU0zY2FjK0I0TVVoekJNL1pjSlR3amFxTitxOEQvRU50SExqZGNjZEV3?=
 =?utf-8?B?VHRYS091SEkyWXYvRktRbi85Lzh3TG5Idm9DVjkxMndlRHFsQTVJY3lTNkVl?=
 =?utf-8?B?UitwaW9uVU1DMXBUQ20zUnNSanplNzBTcWdxT0cxSjNSM1hud1ZlN2VtRHdW?=
 =?utf-8?B?NUhydTdteHpTVnZnWWRzaTVqWlFUQ3NPYmphZzB2MXJERlMvS3A4Zmc0MTBt?=
 =?utf-8?B?TG1iR1lKOFdweFQvSERydVJ3Mjl0YXNSQkpXcmxvMVZKL1pkWU5uM0ZVN2px?=
 =?utf-8?B?M01HSDVqTWFTMGJoRHFiTGkzUHJXQmVoelFuWXlBSUY1QURzZGdkNGttZU1H?=
 =?utf-8?B?RDFBVHZkekJqNGhmN1VDRzQ4TlRaWnFQZWxJOUVCaXpDN1RWMXBnbDRKT2N2?=
 =?utf-8?B?cVdMczFBR1B3YWNYaG9jS2t6NEdRb1FneHZ3bHNaTnl1NWxwMG1yUUdjbWxh?=
 =?utf-8?B?aXljT3ZGanJDaEh4cjBZb2t6eDRHc0kxS1BGRjAya2srTzV2STYyM3hQSnd4?=
 =?utf-8?B?emt5VXRBZG52bFQ3WDgyR3A2c2FkRlM4S0puSk80OEhIckpzOG9vM2svQ0tG?=
 =?utf-8?B?THB0NkQwT3psQmNOWXBvYjUwc1dCYzFYOFdGemZGTDJoK013a0pkaG1leFg2?=
 =?utf-8?B?QnJiVFJXTitCQmpQRVJ6dVB0WGtQTTZmbGQ0N3R1eGdvbmN5M1hMVzNoV3JZ?=
 =?utf-8?B?V1c0eUZtWEZKUlFnQXd0eXRVazFBRDNtNVpLSWs2SEhTMmxXcFBuNU1jcU11?=
 =?utf-8?B?TzBmWGlMaCt2YmlkVnQ4S3FlQVZaUGhiM2RHSWJkaGQ5aFhUeUNpZG0xUFJy?=
 =?utf-8?B?UDNJcEpVazA1ZS82U2Ria2M0OUEzRWkvTTQxTHdoVzBqSFE5US9BQm9NSlQ1?=
 =?utf-8?B?VjhtWDhCNHF1OTVOeklHNWpUOExYb1BIMWh5Q1lWQm84eERDNWVCK0VJeVlV?=
 =?utf-8?B?M0w0QUFWc1p0YjJRK0p6dUVPRVlnOXpoU05kNmpIdVlEb0oyTy9GZEV2TW4r?=
 =?utf-8?B?V0YrUkFoMWlNRThFd3Q0Y1oxOW5vMnBkd3B0SFhvOXp3aEM0UmhsdmNmTjhZ?=
 =?utf-8?B?d0theUY2N1RhdVN5bXRLMkpZbHBOVG5pRWxoQWxJQVBJSkVKekNqc2ZKcFNX?=
 =?utf-8?B?WDJSRUlZQXhJSzB0QnNpaU1yUkp1dXpnYzlFMzJZVWZubUtFMXZKcURIbHlB?=
 =?utf-8?B?RVRNbVl4elloR1B3YlhDcEJhQlc0UDl6RjZIN1FmZ0VIbkNFSHNTNTRYckhG?=
 =?utf-8?B?bGVZQXd2MEZRaEM5bGZhRjdIY3d1WjBQa3VMRG9LY3dFZlVVcjNsdjdZT3NY?=
 =?utf-8?B?aFlvYk92ZlB6emRnSHExSmo3YXk3R1ZWeVpRVnhxc21qZWlXQ1FGM2l0R0ps?=
 =?utf-8?B?aXA2Y2ZLWHdYRloyOGJpSHhVYUpTalFyNFI2V0FreUQ0ZFh2cHFtYktKVHJ3?=
 =?utf-8?B?U3phWHRselV5UnlPc3RJamNsSHFNMVJOdW1LRnJheFF3U0RPWmhUdEZpcW5Z?=
 =?utf-8?B?bmI2WEV2RnFiZ050WERKWXlmMExqV0w5c1J4RStJNzkvVFd5SHZaTWp4R2Nu?=
 =?utf-8?B?ZkdjbXBpRERDWGJMMUd2ZHJFb1I1a0pmYW5QV3NZNmVjckdWQUFJSzZ6MFdK?=
 =?utf-8?B?dmVEcGtiSHI0YWd6MjVsa0I4QkV3aUk5ZWorcGtDUnNST0krS0J6RHNuczd2?=
 =?utf-8?B?RnJhUEF3STdtNGh2MTdCcXMwVVk1Sm1sR2JrMG1NUW1YZjdmbEhaTmt1RmxY?=
 =?utf-8?B?dDEzVmlzVk1zdTZGYzVyMDhHbFdiREJGL0YwMGh4OTJZN2RKT1ZMK2RwR1BL?=
 =?utf-8?B?WEdpL0pUMzlKZENoWTlpcWQ5ZUdYdVdWemRDbHRQTk81U0RUYlllUmdoanFT?=
 =?utf-8?B?c1ExZ29peWtKYlpxbTF4aGNsNjNjSUduS1hnMzBZNVVyMWFHSDBhWGNkZGF4?=
 =?utf-8?B?UWNsK0FkY0lyMDEzeldjZVpWMFdhTDhsOUcyK1hmM3JHN05TMnB1TTFSSlNr?=
 =?utf-8?B?cXcyZ2dvY3ZRQ1NjUnpKVFcvVytEVWlWVjFibFN1bVdlZHlyRlBXQ2NYb1BO?=
 =?utf-8?B?b0VZaWJ1Vk5IejhzekhPU3hxSHpEamk3aFNWL0RqbjZwZlhXN2FQbDRRbHF3?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f43c3b7-4ad2-4669-4dae-08ddbfcf324d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 16:31:18.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Bdl/1X8VfQMpWF0teISGYlEl3g5QRmbxUgInFgs+5vDoVt73mh1AqoXGUd6h3EICB/kx76fxgFHlLMwPSILzwj1DnjRRFhNGArekvvb6Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731
X-OriginatorOrg: intel.com

--------------dsrKHf3MenZetlYl0ZE063ne
Content-Type: multipart/mixed; boundary="------------F0g8vPVWRF6pWbazHvVTLuWN";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Carolina Jubran <cjubran@nvidia.com>
Message-ID: <a3262f60-31c0-4606-be0d-2dd14505329d@intel.com>
Subject: Re: [PATCH net 2/3] net/mlx5e: Fix race between DIM disable and
 net_dim()
References: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
 <1752155624-24095-3-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752155624-24095-3-git-send-email-tariqt@nvidia.com>

--------------F0g8vPVWRF6pWbazHvVTLuWN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/10/2025 6:53 AM, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
>=20
> There's a race between disabling DIM and NAPI callbacks using the dim
> pointer on the RQ or SQ.
>=20
> If NAPI checks the DIM state bit and sees it still set, it assumes
> `rq->dim` or `sq->dim` is valid. But if DIM gets disabled right after
> that check, the pointer might already be set to NULL, leading to a NULL=

> pointer dereference in net_dim().
>=20
> Fix this by calling `synchronize_net()` before freeing the DIM context.=

> This ensures all in-progress NAPI callbacks are finished before the
> pointer is cleared.
>=20
> Kernel log:
>=20
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> RIP: 0010:net_dim+0x23/0x190
> ...
> Call Trace:
>  <TASK>
>  ? __die+0x20/0x60
>  ? page_fault_oops+0x150/0x3e0
>  ? common_interrupt+0xf/0xa0
>  ? sysvec_call_function_single+0xb/0x90
>  ? exc_page_fault+0x74/0x130
>  ? asm_exc_page_fault+0x22/0x30
>  ? net_dim+0x23/0x190
>  ? mlx5e_poll_ico_cq+0x41/0x6f0 [mlx5_core]
>  ? sysvec_apic_timer_interrupt+0xb/0x90
>  mlx5e_handle_rx_dim+0x92/0xd0 [mlx5_core]
>  mlx5e_napi_poll+0x2cd/0xac0 [mlx5_core]
>  ? mlx5e_poll_ico_cq+0xe5/0x6f0 [mlx5_core]
>  busy_poll_stop+0xa2/0x200
>  ? mlx5e_napi_poll+0x1d9/0xac0 [mlx5_core]
>  ? mlx5e_trigger_irq+0x130/0x130 [mlx5_core]
>  __napi_busy_loop+0x345/0x3b0
>  ? sysvec_call_function_single+0xb/0x90
>  ? asm_sysvec_call_function_single+0x16/0x20
>  ? sysvec_apic_timer_interrupt+0xb/0x90
>  ? pcpu_free_area+0x1e4/0x2e0
>  napi_busy_loop+0x11/0x20
>  xsk_recvmsg+0x10c/0x130
>  sock_recvmsg+0x44/0x70
>  __sys_recvfrom+0xbc/0x130
>  ? __schedule+0x398/0x890
>  __x64_sys_recvfrom+0x20/0x30
>  do_syscall_64+0x4c/0x100
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> ...
> ---[ end trace 0000000000000000 ]---
> ...
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>=20

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Fixes: 445a25f6e1a2 ("net/mlx5e: Support updating coalescing configurat=
ion without resetting channels")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_dim.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers=
/net/ethernet/mellanox/mlx5/core/en_dim.c
> index 298bb74ec5e9..d1d629697e28 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
> @@ -113,7 +113,7 @@ int mlx5e_dim_rx_change(struct mlx5e_rq *rq, bool e=
nable)
>  		__set_bit(MLX5E_RQ_STATE_DIM, &rq->state);
>  	} else {
>  		__clear_bit(MLX5E_RQ_STATE_DIM, &rq->state);
> -
> +		synchronize_net();

We've requested NAPI be disabled by this point, and just need to
guarantee that the already running threads close. Makes sense.

>  		mlx5e_dim_disable(rq->dim);
>  		rq->dim =3D NULL;
>  	}
> @@ -140,7 +140,7 @@ int mlx5e_dim_tx_change(struct mlx5e_txqsq *sq, boo=
l enable)
>  		__set_bit(MLX5E_SQ_STATE_DIM, &sq->state);
>  	} else {
>  		__clear_bit(MLX5E_SQ_STATE_DIM, &sq->state);
> -
> +		synchronize_net();
>  		mlx5e_dim_disable(sq->dim);
>  		sq->dim =3D NULL;
>  	}



--------------F0g8vPVWRF6pWbazHvVTLuWN--

--------------dsrKHf3MenZetlYl0ZE063ne
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaG/q1AUDAAAAAAAKCRBqll0+bw8o6JCc
AQDUoGwvqv9aGt8wbBeI2nUNULNwNnx8w8ZN7ZVink688AD/X0P32Ku2CFqfdQEjnoeQilyKiGMn
lo8FGN8m1r4gyws=
=pkgL
-----END PGP SIGNATURE-----

--------------dsrKHf3MenZetlYl0ZE063ne--

