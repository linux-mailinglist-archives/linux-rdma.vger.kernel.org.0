Return-Path: <linux-rdma+bounces-4966-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A05979EA7
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 11:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53266281242
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED514E2E3;
	Mon, 16 Sep 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpIC8yLe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365014C5BE;
	Mon, 16 Sep 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479910; cv=fail; b=D1N3jnYIG7jj7jg0KwV/GJVeL8kRdsN+5iVgGv+P+swC9+gI8/9uAaFrZdALiSjh0sru2gsgOcqZs/DG28oT49YYL/FlNRfwHbngWlufzV8+KwgY9k4aqTQFCz6KUgbFyl5diQmkICST2ljvV/4+M3PP/2JrRQ+OGAQBwRtaviw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479910; c=relaxed/simple;
	bh=eS0RqB105H234QbmfCA/EO9vveWsVzUVaUd4kyCEHwI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EJ+hGz8FWZGo/GrsvjbBclimeFUuiEyiYrzYSBd5RXTQaUCmMfDbokFV5XzbvjMoa5l/RgmvhTNWWN4xhkYJkq6CHH15LI2hMXcu1oP6ioJwypLyd6HSvaT3Ukg2LrHyah0HQuuzJUMWICizV7TYb6PtjmUrfTZ/vnNj/hCBZiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpIC8yLe; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726479908; x=1758015908;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eS0RqB105H234QbmfCA/EO9vveWsVzUVaUd4kyCEHwI=;
  b=mpIC8yLeMg/NxwirBmblTYlMKPNMjoAWItaW0c2GSVRiqqvsBOY7/VxA
   v7Z4f2R2y8QZxWx0NcVFB3auH34IFDx1eL5kxsXHGahE0b/yD9VyICBgM
   JX1A7P3na1pVyeCQwdrKpD4NGnAuBO7IRrhbN1ZLQA/E817lrYcWrgGGc
   pZj3MuFu2rpoZgF8rY9cffXZ2Y8nPmYzATDgcUN5Q7+tsx+V0kaLO+9Ws
   YSVIOsmz3l6PvZjnuKoro9H6kRo1RrzI01Us1XIRw9ILEsR89u9NyfXhV
   RYj3A+euxFQ22Gpp61pz2NCHQWsnsR3rnGZ2VwxoASgf8jicKXGqESW+J
   g==;
X-CSE-ConnectionGUID: 1goolqmTSJmGOygd9b+9Bw==
X-CSE-MsgGUID: rSVZYCMLTSqNI2DVJWIHfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25425197"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25425197"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 02:45:08 -0700
X-CSE-ConnectionGUID: mzwVCSsqQaG2t0itaZAQuw==
X-CSE-MsgGUID: WFWxcwi+SEKuICK4IVT1dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="69064454"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 02:45:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 02:45:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 02:45:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 02:45:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 02:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ytt+cnRB+LXM0kbRjveQFbpqenOuQAOuzp9VWfHpuflrLwkipULNprwGx07v759xK8kaaagyVbxLD31/VCGkM00Gb6+QloDrOKNZRwAUnYnYRilawMxKoUJWYWgw9mEDFIDM2jNRIMaDM79rM9NdU4+W//vC6u0cjXLQ8GyuD8jT+n+lKFcBYlStQybEBicdT6OT9xiFBnUTgkgZUMGfYqRP9ivwLHLehYlUCAPMYlJIB3+5IXo8FW11KEeCMwfmLrrJ0glaeJEf6mgoD4DY3OW3eIltAurypmxwG5w34BjmCFRnOyAj4GERd12PL2y3Cm/EtQBU+Qc/9Vl/Da4Qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBoIJbM87UMC3HhorVTJb4l+dACFMePFVTs+Z62fjak=;
 b=rRLz0oBvgeCn3Ei/2uGvKuIhIQw2OYqg8BUlF3sJT+bxEZYdLJ8D2SyE6RPilWtL09WgJY/A8m9BHuQAszQri8lzO5mWbuUx1LWE9lpQsm6rTBI2JrhQhT5uUNV8t0k0M/G4335APxKFIpxYCEzOo08FIygJQfn6buMCYp6xFgAH9UBxXAPByoiZNztV90QA8v3Q3GrzQmvSH67gEl+1GG7r6tEdPWAv16ieGulJ82TQWJLFnP7Tp0V4UIajDb9Ppa58wyF8E6UYxwXd9cq4eYexFwC6apWh7cssY0ss3NBiaHu+lgoKhFLTsOE6d09hgS22OmPJtmiiIfCBpvMJ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 09:45:02 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 09:45:02 +0000
Message-ID: <8e5d257f-dc4e-44e9-96c8-7698451a71bb@intel.com>
Date: Mon, 16 Sep 2024 11:44:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] mlx4: Do not mask failure accessing page A2h
 (0x51)
To: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>, Tariq Toukan
	<tariqt@nvidia.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
	<gal@nvidia.com>, Amir Vadai <amirv@mellanox.com>, Saeed Mahameed
	<saeedm@mellanox.com>
References: <2aa0787e-a148-456e-b1b5-8f1e9785ed04@ans.pl>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <2aa0787e-a148-456e-b1b5-8f1e9785ed04@ans.pl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::24) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: af4ae811-2b00-4fad-c67e-08dcd6343ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STZIS25USG1wU2grL3VpV25qSFNYMFVxc1hFL0U1UjVsUHVJT1BaZWZrdURV?=
 =?utf-8?B?SisvazBtZENCeDJVU0U1VncveEdtWFVxNVI2eDlHZzJEZnNNclRDTGpoM05z?=
 =?utf-8?B?ZUkzL2ZFR3hPVXNubDhWT1VmUkMzRHA3WDMyc29UdnluY1QzOW9SSlBwY1VD?=
 =?utf-8?B?ajNmZDBaZFlxb3BramJRNjcyQ3hXWXhkckluS0Frd0xBV0dKSUhLd3l2dEtj?=
 =?utf-8?B?VjkxL3BDbEJuSFlZSFVYdGlPVTBLWEpFV21aQ3dYVzFndmoyM3BEUVRjRUU4?=
 =?utf-8?B?bG1DOTdUaGNXOUc2bWRKOHNFWHpySnlmNGNhK0VhVmoxUjRvc21YeUZjMkQ4?=
 =?utf-8?B?UDA4aE1Ycmdzd3FEVlZxZUN1TG5xMmE5ZWl5Y3FNSHBDL0hJbTNObklTYTB4?=
 =?utf-8?B?bHA1UkhEeFNBRkNmTmNPN2lvR1U2V0xLWmFSS3JabzBxWmhRaThtK0puRHZI?=
 =?utf-8?B?M3QyeCtpOC9mQWk4QWhnY1dUbVp2cDRjd25Ra1p1TzNISmFOUm1JeUFWZjZO?=
 =?utf-8?B?aUJDajY4Q2dXMnR3Y2lFOUVRUERiNzVXeFh3SmF6d24xQUpMMUt0V1RoQXhC?=
 =?utf-8?B?ZG5idW4vSFRCL0tWZG5aQUs3RDVMN1JjcmZJcFZrV0hWZy94cWwxbzJkdmJm?=
 =?utf-8?B?azVWK1M5bnZKRmgrRWNPODJMMy9jMVdhQVBJRDE4SlNMUENWMEVuVGFwcHUr?=
 =?utf-8?B?bGZyZXl0TURLWDVXYW5NMkk0dVk3M2FkQmFkVGJmaW1XMm9CVnNLcXd0N3M5?=
 =?utf-8?B?S1RUSm9FSVo2MDVMWm5KeEdqYU5iNTFJQUFMMmphT05WR1Q1ZGpkbFVmWVJv?=
 =?utf-8?B?bk1OWm5xZkRvMjZSOERMWkN4enVuUWo4R2RkU0pKdEN0TjFQRjBQeGtWbkYv?=
 =?utf-8?B?WkNmLzN5ZmM0WDRYV1hFYVZ2SU9OQjVaL0VrV3p6aHduZFVSVHpIL2orWUlV?=
 =?utf-8?B?UUViQjhqeXJVZTZGSnNqUjJudW1VQVIvTVJjcjU2eFhYZGlGSkV5ZlVDckJE?=
 =?utf-8?B?MFFKaCtsOHdYamphSVZ5Tm01bzdEQ2FCUHpNQXVkQ0xYVU1pUlZQM3lCRkpL?=
 =?utf-8?B?aWNVc3dTd3JLNmZzWm9OUUFNWklDVm9lbnJJM08wcmtYb0dWSEthcGtEYWFw?=
 =?utf-8?B?cE1QUDFwQ2FpM0NNV2hydTZFQXN4dXBWOWZmN3hBMVAwZWp6aDM0VjB3Y2Jw?=
 =?utf-8?B?Y3czRHpjM1V0ZGpyRzdERldRZEs2SGZQdzYxcFVHRDZGdEkyQWxwYnp6K2x4?=
 =?utf-8?B?cTRHcW12T1BrbEtndTZMeW1TaUUzSEdvUjZQNzhUTUxocDdUNVBBQlhUdGx3?=
 =?utf-8?B?RDhXOEhyaWdXVUFWbHhudWlLRFJIQnl4WXc4Tk5MMWs1SGc1Z2cwbVVXRmIx?=
 =?utf-8?B?RmEzYm9BdmQxaWh6RFp5VGxwWXM3Q2RkRGlkNDZYMjNISGkvZDB3VVBCOUQv?=
 =?utf-8?B?MjhvYmYyaitPMzB2WHR0ZldDUmErcUdVeUVRbFBxUUtSaGlhNjhNMlcwOHl2?=
 =?utf-8?B?L2tuMDlTaEVrWFJqZHIxaFVHQ1JCSk9UclVKM3B5S0dqS0xrMDJxQjgrejRw?=
 =?utf-8?B?MGtUdDFhVjVYWjJlbEJ2R2Q2RmpjWG1IQXkxdkZIbjgySmZqU0dZM0FJNCtv?=
 =?utf-8?B?emRwSkVtUEgzdENrYTV2MkpMTUhjSFZZWUF2cU5KeGRhcWdJNnlRQnBMek1z?=
 =?utf-8?B?cDhrWnpFVDVJelMxQWU2NnlBUmdKOFA2SFU2YkI5dWwydVN4SGNqN29hcDZT?=
 =?utf-8?B?ZWpPUDNRTkYyNU5JM1MxSWFsL3VBZUlEdVVtQnptRDFKYjYrVmpIYXdOV2VL?=
 =?utf-8?B?SVV5UWNQRWVoYk5pNWZ2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TklERm1WOU9PR0RwYWlLVi84ZXpxNUFIcGR2Rk5BbXQ4RVJNajZrUFVWa1Bo?=
 =?utf-8?B?aHhLNWJobVNsMXRZWWlNSklpcmJGVDNyVmlwZUZ3eVR1WXVzL1FBVklTVk16?=
 =?utf-8?B?SnovZVVWZFVQY0ZmUUU0Z0JMVVFTNVJxYzhISE1BVDBZM1d2STVjeDRwcFZN?=
 =?utf-8?B?aGhHK1RGT0UrRkhyZ1IvYlcvMGdycVUzeXpXOE80YzB2VEx0NGV4cDV2OHlY?=
 =?utf-8?B?MC92WmJBUHk0WDNORDIzNFp5SjFUK1FrYXJGemhYVmdJbGNCUWdTS1R1RXBn?=
 =?utf-8?B?UWtsQ3lxN2kvQ0t0ZkY1WVF4aC83Tng2aGgvUkhwanh3bUZ6ZGVBaEpYK1lq?=
 =?utf-8?B?THlYS2RHTDcvTU9PTTVjNlk5UlpNUEdFckhyMTI1R0x1MHVCUGYwZEVqSkNW?=
 =?utf-8?B?aFhwbXdTeHp6YXcxdS9nclpHWWkyaktHQnRXbVIySEc1TFV4L0hGWnF4Qjd6?=
 =?utf-8?B?WitXSmM3ZmdONUNCLzNETkFlNldPM3cyejZmUlQrZGk2NWFvOXRRVG9zUllj?=
 =?utf-8?B?WmlUQXpmSFB1aXZab1dNTVRWNE1sRExkQXFDQi9UYjlnV3lVUHB6VGZOUlZX?=
 =?utf-8?B?am1WUGM2RnVzc2w5K2NRZzRFNGxma2s3bnMvN3d5L1ArbTFtN092WktDZ0Fp?=
 =?utf-8?B?OHZRK1RXZktBK0dxMEkyVnBaUnliT0VScWc0T09kZ0RnallTVHJmTWVYbEpu?=
 =?utf-8?B?VlRFZmMzVFl2NDBWeERPTTVGSVIxYW5TYmVEb1VVdjQzQ0Q0cktsc1JraEs1?=
 =?utf-8?B?OWpXNFk3dWtmczcvcHJVUGlWY3pTdVg0VURxak15S25ZTGVaQStpbTV3RkZL?=
 =?utf-8?B?RkVhMW5aM3RHaS9PYkg5dEo1NHpyeVpROFFvUVlPR2htazFPckNqOUVXc0ww?=
 =?utf-8?B?MlYycCtjck5zOFp6aGFqVFFpYmU0WVJ1MjlzRDc3TXhrdmR1U1RCUTAwcHds?=
 =?utf-8?B?d2lOS09IdGZIOCtyRVRjd1VHbnFQeUJ5N3h2TXlPcW5oTFloU0RFRlo5clNu?=
 =?utf-8?B?TGFKRFFVVFhWak5yZ05EcmxMNlQyZUpnbHNRa2txS01ML3Z2VTJDN1k3YlJJ?=
 =?utf-8?B?QlVRVlNZQkd2anR0akwxMzFHTUhjaHZlS0x6RUh6V2wrYjhPQnVWcDVTR1Fv?=
 =?utf-8?B?R0FHc1l5TUNiaUpheVJlY2poWXkvQXpxTDlSbDJraWU3cis1YlJ4ZlVqUHNU?=
 =?utf-8?B?Mm9OZXJIejdFRkpIbjExQlRBR0QxMkdzMG8xY2FzL3ZLYldHRnRYZ3JyaDd3?=
 =?utf-8?B?UkJMU0szR2doVFJFaGhuS3dsT3ZSc052aHpDU0g0SGVUZ1hQMTd0TWRvN054?=
 =?utf-8?B?S25XcVkxYU02aXYyS2MwN3ZoMjJGbHlqQy9Mai91K1Q2UnpvV2w3a3Y3U3d3?=
 =?utf-8?B?RjBBd1R5bTRLdk9EM1A5U2ozaGxYVHhSVmVPeGFsRno2a0hDVkJpYkZvM3dY?=
 =?utf-8?B?RGhtVEJnUWVORHdaOFo0LzN0VjZyY2RQakxzL0dxQUZQa090Tyt1OHVnOXdD?=
 =?utf-8?B?NEZaSVB0MnhxU3U3YUNncHI2Y1FWSXM4SXpwTXMzaDcyK2RzM1NnY2dGL2hk?=
 =?utf-8?B?ZTVwZXNoMU5uaXM3WGErWDZrbnBEcmYyNmx2bFN0dEJ5OC9qcFBUbHFjcVNP?=
 =?utf-8?B?VENYNnhOM1BGYmVycVFmSXVSaGF5OGpCZzk0ZkVMWGh4aUdxNUR0T2cxd1RY?=
 =?utf-8?B?M3pKRXBuTUgvMWR0YWZKZDF4S2x2NU54ZUs5R2Y0a2NnT0dyeWRWQjN1Zy9w?=
 =?utf-8?B?NzlHTTREYmN5R0dlZTdHY1BSRm5NejhQZzl5UG5jeTZTbURJOXVvdVJoS0Z3?=
 =?utf-8?B?RlQ5OGRTdFJsM3NqcHpvUHQvZlJlQ1BaQ1hWK2Y0bWdlSkhtd2FSMHl4bmNT?=
 =?utf-8?B?ZVlZMno5Nzl2Y1hjUzNMVjgzL05kbTJmRE1JSEdTcm0yODZUeVFNRlhkYno4?=
 =?utf-8?B?dzgvcVRYeEl6OHRLa2VoK1BhbnlkbVVpazJKMDVGZ2J4cSs4UkRBZE0vWGR1?=
 =?utf-8?B?VVN2TFdWRDF4RlMwOHhkN3FrZndRNHdEcmsyWFZmOXBYRm4rcEJXU1NoSHA2?=
 =?utf-8?B?eWxDbG9DdHo5cVlUaUlmT1FoZml4cWZPTnlYRWd3a215K0lTS1Q2czNlZDhV?=
 =?utf-8?B?V0grY3hEc1NsR2VSTTJmRTErbFdua2JPUWJPVjk0aW4vb0hxWlI4TTI2K1BH?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af4ae811-2b00-4fad-c67e-08dcd6343ccb
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 09:45:02.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pObUO9OeVRFcgWcDnmZYUIfuSFAnsRWgcAWipq6gzhcDY1w9tR3hmvdditzDKsJXZuunmaoogfqkyKLz50KpvtunvcLIKzfJyuhFYD8fkaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5820
X-OriginatorOrg: intel.com

On 9/12/24 08:41, Krzysztof Olędzki wrote:
> Due to HW/FW limitation, page A2h (I2C 0x51) may not be available.
> Do not mask the problem so the userspace can properly handle it.
> 
> When returning the error to the userspace, use -EIO instead of
> "err" because it holds MAD_STATUS.
> 
> Fixes: f5826c8c9d57 ("net/mlx4_en: Fix wrong return value on ioctl EEPROM query failure")
> Fixes: 32a173c7f9e9 ("net/mlx4_core: Introduce mlx4_get_module_info for cable module info reading")
> Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 2 +-
>   drivers/net/ethernet/mellanox/mlx4/port.c       | 9 +--------
>   2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> index 4c985d62af12..677917168bd5 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> @@ -2094,7 +2094,7 @@ static int mlx4_en_get_module_eeprom(struct net_device *dev,
>   			en_err(priv,
>   			       "mlx4_get_module_info i(%d) offset(%d) bytes_to_read(%d) - FAILED (0x%x)\n",
>   			       i, offset, ee->len - i, ret);
> -			return ret;
> +			return -EIO;

here you are masking also all other explicit error paths of
mlx4_get_module_info(), what is not good in general, I would instead
mask below (see next comment)

>   		}
>   
>   		i += ret;
> diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
> index 1ebd459d1d21..8c2a384404f9 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/port.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/port.c
> @@ -2198,14 +2198,7 @@ int mlx4_get_module_info(struct mlx4_dev *dev, u8 port,
>   			  MLX4_ATTR_CABLE_INFO, port, i2c_addr, offset, size,
>   			  ret, cable_info_mad_err_str(ret));
>   
> -		if (i2c_addr == I2C_ADDR_HIGH &&
> -		    MAD_STATUS_2_CABLE_ERR(ret) == CABLE_INF_I2C_ADDR)
> -			/* Some SFP cables do not support i2c slave
> -			 * address 0x51 (high page), abort silently.
> -			 */
> -			ret = 0;
> -		else
> -			ret = -ret;
> +		ret = -ret;

this is the only place that mlx4_get_module_info() returns non standard
error code so, I believe, it's here where we want to overwrite with -EIO

then you could limit to just a single Fixes: tag (the second one)

