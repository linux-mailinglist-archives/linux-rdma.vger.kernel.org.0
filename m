Return-Path: <linux-rdma+bounces-11845-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E81AF60A0
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EEF520ADA
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F47309DB3;
	Wed,  2 Jul 2025 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUvMDDw5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8A309A74;
	Wed,  2 Jul 2025 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479110; cv=fail; b=ixdOxpUizNzl9KD1oqyj3X9V214YY39JWnt6hNMwLqXTPqnVTqJrG/UX0LqN4AB3qSXRxp9MObJSv3/GIbErN6bIdS/maQevW7Hi1hBUcHUt+WtqYRvnGiL3jH46sBX/fZP8n3i8VPN5PfQoGJy0UYvGOazbWDjAj/NoUSHwKac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479110; c=relaxed/simple;
	bh=fUdFmb6w2CbWXFvJaEi8cVRvmQsGM3/4yxnQDX8JeX4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eihXgwKctbXOgNbGya0v/BvCP46B8Jd6XUO1RzZ32Dz8SgTO3+n/ayk0+3FdC7FKFRJzGUCNZh1W8uyW+fwvVBUuF2a4IJNyxKSVV/CzyFpUK+Kk64v6hfNuVvT5aq8izY0Qvs+iwh8zAqRpt1yrixiOboNp8qtRTeFsY9hRzPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUvMDDw5; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751479108; x=1783015108;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=fUdFmb6w2CbWXFvJaEi8cVRvmQsGM3/4yxnQDX8JeX4=;
  b=mUvMDDw5/2TMKKtQsKTJbwQeM/AqO6ZRDGqK+N5Tt9jc6hm4dkPNBFDZ
   GDAkyjtG3NfESQ6vFGvgFhXDiSoH6NT8gKKRMEbG1nAPUi1C7VFfg2Nbj
   h9vQVIkAOoI5sseGsoRDrEb3Dp5hw9GsZVFdH08vMrwTjr1z5ej7lisjC
   uXa21hu7pJK1kZlnUoR50e3S/GKVpfeQ6geH47XVuv0HD09FIKwUk6suk
   sNJBYrfIL9JEw3kDA48+P9/dE4t3uIVafqYnJpeN9HRhoDajF1uFvEhmm
   gRI3UQORc4pfaiVO7MoRHE0/JEd22rdPKervv/SNSFCvWe1Fp5nJAFml7
   A==;
X-CSE-ConnectionGUID: tkqIjMXSRrabuc9yF9pzZA==
X-CSE-MsgGUID: zkot13zwQ+WR0Q7Z0e40KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="76337169"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="asc'?scan'208";a="76337169"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 10:58:28 -0700
X-CSE-ConnectionGUID: pWBHMpyzStaX9VtCgV4S1Q==
X-CSE-MsgGUID: dVk5NBSoTL6qR2mwdqddVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="asc'?scan'208";a="154707692"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 10:58:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 10:58:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 10:58:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 10:58:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3qtRMq1vxshx16I6Ee/IjkUsok3k+bqPry55jz+eYWdE4yOpFRS4suD9LeOqza2ZwWef/ypNMvzx8e3MvrhAiwf1GZYM6j+hGQmHkF+NEALDTkMbBicdZOs7z93gW3j8Hhe6vA7tzlk9vhjzvUFXXbtSUyjI0BdYO7ALTAl5Qgh6WQk33UzjGg2F/tCwpziHTJY4ad++IfkVO2VivSHmbP3MPkCRIYFc0PycD6M2tHsc3Gl9dl7OrdQpt6gABELxES+Yy7MPmr438FzCPH3qn2qmgR0v/jB9Qd4b4YypBSCHNKeSiXIFQzoOaDZvzuPkUavTH2MwukX10wYPrBeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUdFmb6w2CbWXFvJaEi8cVRvmQsGM3/4yxnQDX8JeX4=;
 b=I6/AxGJkLaQdM2ufWDsOGWKurgVau5xlSm1eQ4UdH6HizaLu3F/gIMUo4tiV1lrooGOyZLrctCaCn4oGuwk2CuNfpVcpfh2cZWMJqXh4HeFVRIuBr+OxzZ1YgBjegMGfVFtUcgRVRxdpxXWe1yuMVK4pKIK8suBgtEeY1PwP7o54IQ2lUGmU0/lHkug6XZZArbjR5IsT5DM82EW4nz6Rw4oEbNLeBNMv+4C0LBWM3yXFyf9liQSN59rjQ8J/w1WxxwAzwbqHejPCoUr9iqtTWTg5d86mEsjgIZm+7S8nd5HCtCDWyqI90VqeFaQFrSbCTDSIDZx6YFQip86GE7wxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 17:58:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 17:58:24 +0000
Message-ID: <9022a20f-47a7-47f2-9d87-b242cf75b55a@intel.com>
Date: Wed, 2 Jul 2025 10:58:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
To: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"shayd@nvidia.com" <shayd@nvidia.com>, "elic@nvidia.com" <elic@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anand Khoje
	<anand.a.khoje@oracle.com>, Manjunath Patil <manjunath.b.patil@oracle.com>,
	Rama Nichanamatlu <rama.nichanamatlu@oracle.com>, Rajesh Sivaramasubramaniom
	<rajesh.sivaramasubramaniom@oracle.com>, Rohit Sajan Kumar
	<rohit.sajan.kumar@oracle.com>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Qing Huang <qing.huang@oracle.com>
References: <1eda4785-6e3e-4660-ac04-62e474133d71@oracle.com>
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
In-Reply-To: <1eda4785-6e3e-4660-ac04-62e474133d71@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------hnLQx94K60yOdTw0U00AtjUD"
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM6PR11MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: 448d1221-49e8-4510-37db-08ddb9920a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b05sMHpSeTNMZ2JRQ0NJOHdkT1pROURMQmpTaGVlSlhhaEs3NHoxOU1BajRi?=
 =?utf-8?B?S1oyQ2QrUkxvRGswV0ZUaDFneW81T052STlQQjNzRDhrdmEvWTFGRUFvNXRv?=
 =?utf-8?B?WXZCK1ZEK3ZQSHZMR2JyTFdyYjE5RE4ycXlPcVM1MHY5a293b1I3bFptbmtr?=
 =?utf-8?B?d1g3c3B2aHgxZU5oeHpHck4zYkdNZTJ5M3hiNmFmbnl2Unh5cXhMVUplUmts?=
 =?utf-8?B?cFhDNFNMYlJKSmJ3ZUlOd09pcHBxRzRxMUdmWXFWK09hbUpXbDhNSTMySU9i?=
 =?utf-8?B?NVFnL2NGRzB2QWJUbkpHVkIyYTdkTFpCNEdjb2ZtL0l6b2Jma3l0Nm53OHhK?=
 =?utf-8?B?V3NmNUMxbDFHTDdodGk4SjRMaDljaDdUMFIvNDVGSTNzU1ZDdzlVVUdJUlcz?=
 =?utf-8?B?aThmbWJlV1hJV3phTDVOWkN0SHpZcDZxQ1p4ajlEekJ2N05OM1dUeGw1c3pI?=
 =?utf-8?B?K3dGeEVvRU5DNTFqcUNKMEJEeHJtOVhUeW94cTZjY3FQSkIrbXlvbVRaUkxQ?=
 =?utf-8?B?WGJVMDh0S2k2VndoQkJRV3RwSlBjWVdFbElNejVpWm1KMy9IYUQzSjBGajVR?=
 =?utf-8?B?OGpUSkdyUXAvWDIycGxzVC9FdjNiVnZmUFprbGNKekJUNENicFcreFZSTG1H?=
 =?utf-8?B?NzlFbGRTTXdnTENSajFxUDFSbFVSZlJNYlNNSk95OHlNc0RwQVJQems1ejM3?=
 =?utf-8?B?N0FRcFZmdEswWU1CeHVYMEZHV0JnaFdDNGhpOWlyMnVKOEUrZ3IzWVFjdmZT?=
 =?utf-8?B?ajc1RGhSK3lyOWZnSkF5dTYwczV1RzdpY2M0RDZWWDlBUndIODVsOWtuRVNK?=
 =?utf-8?B?ZlFJVW5JSExVRXNzR2lKSlFyLzBpcHN0WjV3aDZsa3pkYmZjY3poZnFUMWRn?=
 =?utf-8?B?cmZzd016VXhKSTU1bVp1eG1qT2ZRZXJyc2hTZzlKejhZdVpLbGRPd01qeEtz?=
 =?utf-8?B?dFlnRlJ5aWtka1AvNFdtNHR0dk9ZUmdVNnNjd0ljQWZMalFpNzJGb0Q2QjFj?=
 =?utf-8?B?ZjQ1MUpmUWJ0cER1RzVLalhDb29ITzJCazFleGxPS0MzNlZvcXVlajg5Ukdu?=
 =?utf-8?B?SWZQYzRwV0tDMnYyUVlidUxIM2R6N0Q1ZzZwZ3BzejRWSFpsTkY4M3lyR2wx?=
 =?utf-8?B?SFk5YXlnaEROUU5tTkthSmRnRkVhYlRzdFBTUUhneGIzZ0FHRUEvQTdTcjhW?=
 =?utf-8?B?bmFRdDExVDVUY1kzKzFvT05Gd1dtYTNKMXRpbUZJUjZ1bmMzRXdhQWpJbGNp?=
 =?utf-8?B?RmdXQnZya2VWWXFaMGxtKzRmZlJYUWlEOFFMMXlDTFpUZHFZOHg2K0FmZ21k?=
 =?utf-8?B?dmNMOTc0ZDJvM1pINTBMK2IwalJFRFdKSUVhbTJVdmxiSXlTZVIrb3EyNG1z?=
 =?utf-8?B?SkRuVTl0aDF0M3N3RnNBZ1V2WDU4ZE5hYXBHWjVGNjZmS21LUFg0bUdSbHdL?=
 =?utf-8?B?amdHcHlzOURHdlZGSGcxOWM1dlU4dEthOGV5OGVZTUxhaStNTzhadkxwTDlm?=
 =?utf-8?B?TzluSEJKMjk3RmduV1ZiRWVGbnJvUHFXbnZoUEhJdjM2U2h5YlRDVmhlTVMw?=
 =?utf-8?B?UzE3cHpJaER0R0w5WnNjL2N6NlVOeFZYTnJvVTZDYmRTL1VYdm5UTE5VL0dm?=
 =?utf-8?B?VWhySk0vV2FkQ0VUL3Q2dm5VVXVaQlV5YW13R2hOU2F0cWM3c1BoSERNTkRS?=
 =?utf-8?B?VDRhaTlSZGlYY2tzSk1nVEZFMXhPOVVWVmtoRDBUVzIzYmV4UjZhMkxJMWFH?=
 =?utf-8?B?Z3ZPY3ZuUml6MklSRmVUM01RSDZaaTlSdktxUlNobFNBSlg2UXdnZ0hTdWFV?=
 =?utf-8?B?VWVYbFYwUmtsalpNemgyLzJHMFZmU2huaGIrRW41WHdTdUdKQUhzYmNGUUJY?=
 =?utf-8?B?Q1N6MUVBdUVFR2tiUmJyaEZ3eFczVm14WFhhNXljUkgwcmdDL3VYN091WFJr?=
 =?utf-8?Q?trlmYA2ocy4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTBmNzdWOXk1cndwKzQwUnVqNTZzcnJIY3VGUkJaQmFWVHR6SG42bmxaTmFP?=
 =?utf-8?B?SFd1R2FEbHZrNWw2TStEc2EyR2JvWGNoNzNkY09GaWZEVUx2NjFrR3U1aHVZ?=
 =?utf-8?B?TXBITEJtd0QxOEZmRFNjTmlvRmhuU1NDWGhZTnp1Q0dvV1RqN1FlOUpiVFI4?=
 =?utf-8?B?T1E0alF6SkdzQlZJYi9BdVRqS0JMSk9ZTnhJZm9DaENldkJNNzdveHdhdkJX?=
 =?utf-8?B?cDd0SmFmNDhFemhDTUV2UkdmTkdwUEJaVXh5c1hBV01KUDd1UWtnM3hxd2Ez?=
 =?utf-8?B?N21yaVZRbStjQ1R4c1NFL2xJbExHWjFaZGpKZGtVczNMMDdsemNlZGg3OTJT?=
 =?utf-8?B?eHM5WndaNWIveGVYbm9yd3czSUs0c2wvTE1wWktCNVgxb1dXUjBVUWt2Ti9W?=
 =?utf-8?B?K3RYbTk2M2tsbVVUdGZ4ejIrRS8zYzJ5VHBkdkRRNHppQUdERXpDcVBUdDR2?=
 =?utf-8?B?dFZCTTFJbjk0Ylp1djVBWUFPVW1rZmk4T255Q3ZId1hpZVVFTndTRjNCSkJY?=
 =?utf-8?B?YXYvbkYxL0tnZTEranJ0eEJqcjJ1RU4rUFhlcHc0VjduVXh0MXV5aTQ4ZWJt?=
 =?utf-8?B?VU10OHQ2VTBxa1ZxWHlmL1hDRlpTUTYvNllRQjI0MjdSRVJUYWIwZ0R6UjY3?=
 =?utf-8?B?TVcwdmErd0svQ3lIeTN4dVJsOXV3Vkp6dGhQNG84Y3U4VUtJRDdVU1ArZUsr?=
 =?utf-8?B?UWNsSTVyc1pRUGdObnMxTHNFWlV2WGNwQThwc01nWXFDeUJPeUYxVy9vQWZS?=
 =?utf-8?B?N3ZuajlQbWhvdkMwZkFVek1qVjhwOWdRVWx3U0RSK3A3MDRsZk1MdWJJR24r?=
 =?utf-8?B?UHpJaTdNMU1vWXY5Ni9wS0tJS1lWV1RiYjFNYnNpM1ZHNjdTNFhDamUzYnRa?=
 =?utf-8?B?YUsvb2s2Y2Jna3hHQ0l0MXNOdFFGOW5wVEc0QUdmWHlqa2xaUnBMdENFQm9v?=
 =?utf-8?B?SDAzbms1TDJrSVBYREx3c3NzK2NuMkl5YlBadFY4Tnp1TUlQRWsyZzl5aklS?=
 =?utf-8?B?bFlxSytNNnEwcS9RSjJyVHhVZlVicnlmaURKOEhUTllsWHZOMHQ1cUdURFZR?=
 =?utf-8?B?Y3k1VmxPV1hTem0wZmlkU1NaZGhTUTRLckd2NHBSMmNrMmlUVG55RXB1YkpL?=
 =?utf-8?B?dWhYUmpLR0U2citDRytORzIxcG5sYzlCQU40ZXNxS1FldmZycjBUY2ZHODgz?=
 =?utf-8?B?TDdCL2NYcW1mYWJLTlpjMnk4cHZLbEI3MlRyS0dIZ3MwUk1rbFdaVlpDd1N5?=
 =?utf-8?B?c0grRmFLK3JGUXJxZVlkRkNmdHo4dVFCUXg2N1h3R09vVlhva0ZsMWVubHk4?=
 =?utf-8?B?bVZudFhCYjNFNWZtWmFCN3BpUnlsTkRVdUNJYmUvSUlRQko0dDgra0drRjF0?=
 =?utf-8?B?bE91WWhicVlaSGoyUW5NbFo0OGhPUmtUcXlFSEdVNENnQzk4UGpBUG43K3Jl?=
 =?utf-8?B?b3BTSWhMVnlzaTBHU3pxQ21JdmkrUU9mU0EzSTFaUjY2TmI3cDFwSDhMa0xF?=
 =?utf-8?B?cEZGbTU1eWlJUDNmcHR5b25kTkFrWXFHZC9qUHpmZG5RWWNnZUpCNWNyOW8r?=
 =?utf-8?B?T25FNi8zZGxQTVFxZHl1Wi9COHBnbWdPczZhYmZXVDVwOUJEb0R5MkQ2Y0d4?=
 =?utf-8?B?QTVuS3dJY0xkNEIwbjNrb0tVQkdpUWVESXA2M2VBTk1XWVdaWTRYOUYrUEFE?=
 =?utf-8?B?MXZZc1FVRDJLbDVqZWRPc250Si9RUCtndWpOZnQ3OXlRSHNtcHAwVWlSUjJh?=
 =?utf-8?B?eXYwU3I1NktwYXg1Y2tFMVB3Y1BMRUJuUnNzMVdxV1lwVFRWZHRHVTJ2cXlR?=
 =?utf-8?B?OEdrVUQ1MWNuVWloY3laYUZUYnZFWHc4UjhlTngzcTFBVFFkYkZSbHJhRkFq?=
 =?utf-8?B?elZtSmVpN3ljNTZwV09VL2VGd1FQTlNXdk9XL3F1S1JsckRORVd0S2tIbUNB?=
 =?utf-8?B?ZVdJVFV5TFFQL3RUbzBKUFVES216MW16UjZSRS9raUJCcmhEOUN1WUtvQXlF?=
 =?utf-8?B?Y1FSNCtTNHVSK3grMzdXbElrV0s3UGNzM0hNZUdhNUJSaEtpRUxPRitHbjBW?=
 =?utf-8?B?SldlZlhCU21heUhTRW5iOUFSMmYxNUxoV0NodmY3M0dtS3EzYVlKRmVrL2tl?=
 =?utf-8?B?bEtKM0Mrd1JRZVIwNEdRcWlxSHNQZ3hCaEkxNTFzRzdhbzJ5MXRBcTJ3VVJj?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 448d1221-49e8-4510-37db-08ddb9920a0c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:58:24.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VkDxqw1cywm7wrvRg1p1j0csQtXvEI/hpz8VFhb72wmhyOyHv9avOAT5Jww2r32bgaodmccZLsw8KH6CsdRSIwI9sg5Ux2cRyLqKd29I8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-OriginatorOrg: intel.com

--------------hnLQx94K60yOdTw0U00AtjUD
Content-Type: multipart/mixed; boundary="------------SJRN0WwDWfeiI3ETcXuaPP8h";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org"
 <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "shayd@nvidia.com" <shayd@nvidia.com>,
 "elic@nvidia.com" <elic@nvidia.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anand Khoje <anand.a.khoje@oracle.com>,
 Manjunath Patil <manjunath.b.patil@oracle.com>,
 Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
 Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
 Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
 Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Qing Huang <qing.huang@oracle.com>
Message-ID: <9022a20f-47a7-47f2-9d87-b242cf75b55a@intel.com>
Subject: Re: [PATCH net 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
References: <1eda4785-6e3e-4660-ac04-62e474133d71@oracle.com>
In-Reply-To: <1eda4785-6e3e-4660-ac04-62e474133d71@oracle.com>

--------------SJRN0WwDWfeiI3ETcXuaPP8h
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/26/2025 11:50 PM, Mohith Kumar Thummaluru wrote:
> The mlx5_irq_alloc() function can inadvertently free the entire rmap
> and end up in a crash[1] when the other threads tries to access this,
> when request_irq() fails due to exhausted IRQ vectors. This commit
> modifies the cleanup to remove only the specific IRQ mapping that was
> just added.
>=20
> This prevents removal of other valid mappings and ensures precise
> cleanup of the failed IRQ allocation's associated glue object.
>=20
> Note: This error is observed when both fwctl and rds configs are enable=
d.
>=20
FWIW, figured i should add it here:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------SJRN0WwDWfeiI3ETcXuaPP8h--

--------------hnLQx94K60yOdTw0U00AtjUD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaGVzPgUDAAAAAAAKCRBqll0+bw8o6Git
AP0Vj45eY67Bylb/fnmS0XHxIzeA3/rAgy4lYvg79hPNyAD9GkZ+hB7cVQ8ZQs9pcmQrDjnVdg5Z
grFjKgAGePzJGAI=
=ao9x
-----END PGP SIGNATURE-----

--------------hnLQx94K60yOdTw0U00AtjUD--

