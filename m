Return-Path: <linux-rdma+bounces-6548-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FCD9F3815
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 18:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5E01883BF9
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE366206F0F;
	Mon, 16 Dec 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A70L6rmt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F57206F0B;
	Mon, 16 Dec 2024 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371795; cv=fail; b=WUjJDGqcAtRToEbmNDgbnUMRvXoS/zPMQuECcCl72H4QM0K8YX9R1SWZ/YjcOymE/s3aYQpKTPYQlcaqiuC/eRZPfuDLKYta2EQZxJ0OMXJ7wAlUvN56tcNmIhM3qCJych/JQqOHeZWkkH7s8UB3G6dQ4pRB6mCOu3CyFirl/0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371795; c=relaxed/simple;
	bh=jrqweLQ9rM9u+lj21oqa/WxJ7uvxch2tQ60tWSBVNmc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XioXy9nU01GciwEGnH32KzrCMjvdhy+QF6bExrQ2nxfVZChNbc9kq5yGyEQrZkHI+OABdHF7h92xmdw/NTuCAFTq4Y23H1Gue8mszSQdk9bRwp8mfwYSmKYQuGB5IzFFhy1L4GskH5snfRSIdugqyO2Dk1tFMxpz5ILQXL+Wvfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A70L6rmt; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371793; x=1765907793;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jrqweLQ9rM9u+lj21oqa/WxJ7uvxch2tQ60tWSBVNmc=;
  b=A70L6rmtpy98zZw2yeeU3uo4BgkAlyW3GcKP+sZ23IxO9UfwjN9JIEFO
   pu88ZI/3lS1hZkQvCUSmhdmq4RrpDtQE29e+1aJ7HZGhZcjgT1aCrF1PE
   N0fgvUTig7XjRj0hep32JmHAuwYvPuLyPBgU1AgGHqr0MOj6jMXxKxG1C
   FsCz35jLeygU6XrxNJEIufB2KA0CDoa2qUFOolR100FRbL58q/JFIPiI6
   /hOx24gpj2ZYQ2ORIzn9glXpznHwMxoZl6XrBWfh6fYibqqRTPMuCoy1N
   wPE2iZ53ZORyma6ZpFpFcD8lruVKoIJP/pxEx3XCqtpUAgO2Xk089bg8N
   g==;
X-CSE-ConnectionGUID: XbGeGqkgS3OFaVAtZhPqHA==
X-CSE-MsgGUID: 0HX5/8j1S5W7dDg1TsMvQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45772053"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45772053"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:56:32 -0800
X-CSE-ConnectionGUID: Mo+7lmSMSxOtCks3ulI80A==
X-CSE-MsgGUID: q292A0/wTpqhtn5UNrHmog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102257743"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 09:56:32 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 09:56:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 09:56:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 09:56:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9LeWqD5DW3f5gFR0uH9v4XOzSbb/15QXsCLgnQuA/MwZr+efjXVzuTSLwI/jQYfOK8e2ZUvDlG+U6cvMAXeWda1rDnaJdCw6sy6K5oeVC7Sr9Pnl8if1IaG6ab2SsTaxmDK8AzSRdg+3ZzqdQeoWurYLi4PePKLYujEx/ifEfqA6sdCHftmcCBLnF/qN75l+caJvOgB3OkYMwfHtX6eoyEoNpN2QIdB7e3IMsTfqot5e/PQY0aWi/E5ymrofd1qjHHFdWCF1S4/kcV4yhm4qyp0r8LoGK9DSChEu+78mNYt4t03cf5ITdK0bQYQUtFOKwuykHwYigH4XvcGHZm1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77qFjnqyFpLG14j9va6nUk1dLX2JnL8ue6dcnOBrdjE=;
 b=AIfcISNUtGUsgPKStTv9JIVHpj1iAuaAI2BnLeEmNaMBBeOkZ94HUISK4BD0sfNrUGscFQ70Iu9CxWo8jLTuOiiPTo6Karji/oWgykaQ/TKOScD4NmEHUg3u/0diRnVUe0rKEpXtxkG6mr0PvSFlTX2J3h9eBVcFgarUpcG4nDz66VzMNMy3zcUBvye+3pidKmO1MkjhIisKlJ0Q6ZyjigIyJAN1jnsYB/7Bf713AloOBKyC38pZXxxjludjf5X0yppSpV2oXg7fs+99tjrbW6Smc21Riar8RZjuJcCWalzrpgx840YmcXFJdhqdn11ijD/rv3zQBajEYJ8SvGt0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 17:55:58 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 17:55:57 +0000
Message-ID: <93a38917-954c-48bb-a637-011533649ed1@intel.com>
Date: Mon, 16 Dec 2024 18:55:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/12] net/mlx5: LAG, Refactor lag logic
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Rongwei Liu
	<rongweil@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-3-tariqt@nvidia.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241211134223.389616-3-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: f303d1b7-af51-47c3-4253-08dd1dfae4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE9mLzB4N2tjT3FoUUVWdVp2UHFDMWFwd3NQeGNEZXZhT1B3Tjcxb29FaU95?=
 =?utf-8?B?R1dvUkNuV081NlFoaGtvM0hZaDcvM0o1bjdxMmNjK29DN1pwVHd2dk41c28x?=
 =?utf-8?B?TW9WR1ZHU2ExeGM5Rjl6VDlHWHNhTDhqZnF6ZktGckdPYVRLUDBDelRzUDh2?=
 =?utf-8?B?NEw0eisyRGRNb1ZPMzFDalM5WHRjd3gzQ2dsbzQwV2NXMUNFSjJ1T256S0FQ?=
 =?utf-8?B?aVc1ZTVDOGUxR3ZPZ3hiNVZQbXVtRDAwdXJDVnlBZFpZN1dKVEdaWFN5dHJE?=
 =?utf-8?B?VTRiWkk5Qmh4NkRTZ0QrTzB6QU0xUWlIMGpINTQrY1RWWU5VRGFrYVFBVkJj?=
 =?utf-8?B?R21sOEVZSG9aNUFJMGJDSHRQUnA5Q0tNZEdWS21TV2psZkpZRUZFNFhVQWZl?=
 =?utf-8?B?WDg5Zno3TnY0bmcwenVkUTVYRzBtNmFJN0pVVy9VR0lsNXB2N3A2eFBreXRG?=
 =?utf-8?B?aFQ1SHhJYjZ4UTMxUHA1OHNqVUpDZVBHL2RQVysvTlcwTU9NNUFtQWZqWnM2?=
 =?utf-8?B?eEVDa2E5ZWNSUlA5SDlVdVBTM2lmN1ZXdlFraWZXdy9OZU1RVUk1OWpUSVUr?=
 =?utf-8?B?elM2RUM3MzEzV0VTbDN1cTAvcGlDNzRKVm10dVc1YlBYRzl4cW1OaVVPbzZn?=
 =?utf-8?B?YjFwOFoxV2NzSmdJWmJoSWI0cGdMVmRldDhFK2JJamYwMk1RVjhMU1FtaEdz?=
 =?utf-8?B?dFJLNEZDWlIwYXo3ZzIxUE9tN0RVNG1JQ0F2TitzVDU3Umc4NmFxekZvcXV3?=
 =?utf-8?B?UC8zbklaOHFGcGhpUU5sR2I0YTduUWtoUENOVnJZU2lld2h1T1h2bkUrNkhD?=
 =?utf-8?B?Zk51Y2FoM2pJR3psLzRVaDE0QmpFbzI4aFhTY0JuL3RnWFUvWHpKdjJITXQx?=
 =?utf-8?B?L3phTFROWjVOU01kbEYzUzBQSy9MS2pSU2Jmd2lQTUN2dUVEMEVIL2VPdlZJ?=
 =?utf-8?B?dlNXTnhLUXVmSWxRZEV2cXBWeE1GOUZoVEVHcGw3RXNRM0NaVzZqLzR6c2dC?=
 =?utf-8?B?OXM5RVVNdlNONm9tS2I1OGVpbURtZzZBUTdqdmQ1NlBad2ZuQU9xb0pjM1BJ?=
 =?utf-8?B?U0JGdWF0RWoveWp5My94aFIxRjF5VjRackpTOHRtSTd1ckpWRzJTeStPQVdS?=
 =?utf-8?B?UFI1SDJGU2FJV1FqckNKblZwMnhKUFAxNzZOcENiak5WMjc1SU1iVVRjU09E?=
 =?utf-8?B?U0g3VHdVT0xFMTJzT2ZBcFcyUVZ1ZHQxaW52T2RLU1ZlczF2ZTZjVmlQUGhU?=
 =?utf-8?B?T1ZPYUo3alF3Nyt6WnpPdFpRbFFGWkNFZEp5bVF3cU1YQjJqcS9GeDAzWVRs?=
 =?utf-8?B?eDNDa09ZOHo5VVYzTGpBZE5UMVlycHNDYXZlNHRocmR1dVFWYWQwME1xNWRO?=
 =?utf-8?B?NnZmUWtyWFhQdGZIenBOTnlMYkgvQW9SblFGRVdXQlRNcDAwWWVXek1mR1gr?=
 =?utf-8?B?WHBPbEVKN0xOZ24vY2dlUXZnQWJMQytHeEhVcmVwK1gzbDVpSU0reUpEZHpq?=
 =?utf-8?B?RFJKa29MR3hFdGdydTlDYmdpTHJNMHNneXZad3RWclgxTWl6K0U0T0dGT0hi?=
 =?utf-8?B?RzJIbHdmMVR3NmVrU2UwMW1NbTZqOGFaZDBIQjFSZVhiRHJCV1RFQkI1bWJa?=
 =?utf-8?B?eTh3NFNiYlMrRzBHUlExcW5KUVo5VXJPT2lzZWRBUkZmWTg3M2JkWlRQZHY1?=
 =?utf-8?B?dXFya2RjZ2UycllmWEtZRDFKTGZVdWFXWi9WTDd5SUVKS1VXYTFTNE1sd2pG?=
 =?utf-8?B?ejdXS1I4b3FSNnduUEZkUi9MWEZCcWpTOXdSYWc3RmQ5RlFHWnZaRHQwUnRx?=
 =?utf-8?B?dUhwQmo1Ykp0dE84QVZ1RVJFaHYrVEM4ellFbjF4NFZTQzhlUXY3UmpSbE1V?=
 =?utf-8?Q?K1O7axTRmRXAs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3gxZkhoWHRZRFhmS2xRcVl1blRrdnAvSU1rbms2M3E4VjdQWVoyTHg3VjQy?=
 =?utf-8?B?dWx0RUlJRDR3U2tWcHZNNmQvM1lZVkl2TEorUVR4NmRhUytzbTM3R1BqbUFt?=
 =?utf-8?B?dm5YTnVLSk5OYzdsOTN3YVgzdzlNQk5LNDNkU09kaXlncmkxY242ZUNWMUpL?=
 =?utf-8?B?VmxwRkJDWUtJYWtycUNEWEhWZFhGNjBpdklxSEJhTHRqczlBYWIyYTNyR3Jv?=
 =?utf-8?B?eWdKWnJlR1ZnOG5Jd0hQRXQ1QUJHaFpxTjlBbFdqR3BMRFh3dkJlcXBRbE81?=
 =?utf-8?B?TU1ZK2Q2VHY5VlVqSlRndFB6eVlFb3lsN3dtNVRDdWx0MEdSdEFWOEhLaEJu?=
 =?utf-8?B?eS9pUHFiSGwxNzgxVFZhem00b3lGZWEyUCtFbkpiVFA1WE8zUFB6cjNoSGFT?=
 =?utf-8?B?VXNUTGRhc3BsM0RtRENmZ3oyVVRtNUF4N0o4NUErNENNdGlvWmZKZlprZGlT?=
 =?utf-8?B?b3l4QUk3QXN1VHVRbHhEbzZaeTYrbmpUSS8yb1lCSkVobWI3OFphOHlmelJs?=
 =?utf-8?B?ckZJZGMzb0gxUGZSNDlQL29zUkRSVGN1clUrNjlxOTE4QzhvdjZjRE5qZDBw?=
 =?utf-8?B?Nlh6U05hZ0thczM3aW1CUHU2a3BTRU84TG10cm5jZjZFMFJ0ZUlDd3FjazZz?=
 =?utf-8?B?ejh6TU1uRVFvYnVvNkpMdzF3RSs0bHlGUUpqTHZZalBWUUJjUTlYOUN0aU9j?=
 =?utf-8?B?ZlJWc1huU1NMVks3dGFDVi94Z3BTMmNPKzBSSW5xVERWbUNPMG5Od3FqSlRl?=
 =?utf-8?B?TVpOUTVnQ1NRbWU3d1REN0c3cUh6K3VVYXVjb05BUWFYTlByL0RPTVhuMlVC?=
 =?utf-8?B?cDBZYjZzTTJDb0JmTUo1SDc1eEx0ZW5UNnpCcEs2ZVRvY1BDb2VXWDFyQ21z?=
 =?utf-8?B?SmEwdDdYLzRxRFMvWFdGRmlhVnFtZ2dtVjdhTWd1QUN5dzVQZVp1d2FiQjVI?=
 =?utf-8?B?bWVxTHVReEczalpvMXdZSGNOemtGbXo2TGpCaVBNRjJuK2I4UzJkVklxNjZZ?=
 =?utf-8?B?SlIrMjNZVUNKK3ZiNFVxYkJncXd5R3F5UDE0djRkbjBmS1o3L0RyZzNHSVZ6?=
 =?utf-8?B?UmFMWTY4VnVCRkpKbWY1QnNtblg3QUpNcDVaVUxoWFhzZ29td05jSW1hUFdV?=
 =?utf-8?B?V1RHTWcyL2J3d1dGZEtzdTFteWhmOWsyTFFVMVJhY3lPZUF1TERUY0l4a2h0?=
 =?utf-8?B?SW1tN0I4WkRPMFdrNEQvRmhCaXFPTnZFNE9VZFFUQ3IvRi8yUEFHQjAvMHVp?=
 =?utf-8?B?YUs5aUF6aFhabnVRM0ZoY1djYkVFaDgwZ0ZscEdUSDlBVWxseFQwWlMxb05Y?=
 =?utf-8?B?NWhYV3ptRzNZZnRKeHNHbkNZaDR3T3JvNDZxVUlnQ1lGNnRmdVJrZ0F0cE9I?=
 =?utf-8?B?azhiWkV1NTBIRGRIK2xsVS9pSDRYOVErbVdVSURmZC81UTJ0RlFvSXVQNTFS?=
 =?utf-8?B?YzgzdEd4T2FWWnhaWVd4S0RyWmNQUUpMdE53UDF4UXN5eXN4MVR5ZUVuWFhC?=
 =?utf-8?B?WkRycnAvQXJGVC94a3lnK1N1K29EYlhKY2NlbDdrTDQ1aDhGNnlmdlhUUWxE?=
 =?utf-8?B?UVJuRG41bFlLZWFwT1NjU1o4bGQ3dTFZR3NjalY5MGo5WnE3cE10WUIxcGx0?=
 =?utf-8?B?YzQxWkZMaXpydWE2Rkx1Qnl2QWJCQTltbUFTdHJVcDBoTG9zTWZPQnNodytm?=
 =?utf-8?B?OW1OSThoajJFckFwSlFTa1ZzMzVwckU3b1N0VEJ1Tm1QMlVhVG5vSk56SjIx?=
 =?utf-8?B?ZU9CTCtTbXpzUm9ra3djc1NWM3VndVFaeXZrRnExYjVTdm1EUWRONytjVmJS?=
 =?utf-8?B?NHVGS0hMdTZBcTZsMm1FU3VyOGFuRStZemY3NlpRdkIzZllZUkFGdGVUOFQr?=
 =?utf-8?B?MHVRbEZDM2g0S05aOFkvY1VUQlRTQU9sOGNwaWR2WmVpQzdZWEIwSmpDS1JJ?=
 =?utf-8?B?TWtjd0IzcTEyRGpwbjBjSHl5dDdQMmlEKzhVR0lvd2oxQ3FWMmRlbDNYYkpS?=
 =?utf-8?B?MGF1RTNhNWUyYWdUOTNwRTc4TEVqeVVrTVJGcm56VTBBVU9ZakxMVWxYQ1Y4?=
 =?utf-8?B?RXJTcmo3Wjd5NGRtbFhNWTBmYTNtY0FXeENsUHExcit0Y0h3N3FSVEJicDhs?=
 =?utf-8?B?bnlob1orQ3E2RWJRV2RZdkhZWElFcXM1Y2xPQVNIVkpmTEd2WFRDZm9QZjd4?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f303d1b7-af51-47c3-4253-08dd1dfae4e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:55:57.8637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l735QEizbrDgUcpwQM6yInw5LjcEaua/DpeU8C+Z6pQp0h02qo5POBPJilerMUW6KxLeMaYDkB/1BhE9C2MNZghvaFurPCycPMf79YuWmX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6320
X-OriginatorOrg: intel.com

From: Tariq Toukan <tariqt@nvidia.com>
Date: Wed, 11 Dec 2024 15:42:13 +0200

> From: Rongwei Liu <rongweil@nvidia.com>
> 
> Wrap the lag pf access into two new macros:
> 1. ldev_for_each()
> 2. ldev_for_each_reverse()
> The maximum number of lag ports and the index to `natvie_port_num`
> mapping will be handled by the two new macros.
> Users shouldn't use the for loop anymore.

[...]

> @@ -1417,6 +1398,26 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
>  	mlx5_queue_bond_work(ldev, 0);
>  }
>  
> +int get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx)
> +{
> +	int i;
> +
> +	for (i = start_idx; i >= end_idx; i--)
> +		if (ldev->pf[i].dev)
> +			return i;
> +	return -1;
> +}
> +
> +int get_next_ldev_func(struct mlx5_lag *ldev, int start_idx)
> +{
> +	int i;
> +
> +	for (i = start_idx; i < MLX5_MAX_PORTS; i++)
> +		if (ldev->pf[i].dev)
> +			return i;
> +	return MLX5_MAX_PORTS;
> +}

Why aren't these two prefixed with mlx5?

> +
>  bool mlx5_lag_is_roce(struct mlx5_core_dev *dev)
>  {
>  	struct mlx5_lag *ldev;

[...]

>  
> +#define ldev_for_each(i, start_index, ldev) \
> +	for (int tmp = start_index; tmp = get_next_ldev_func(ldev, tmp), \
> +	     i = tmp, tmp < MLX5_MAX_PORTS; tmp++)
> +
> +#define ldev_for_each_reverse(i, start_index, end_index, ldev)      \
> +	for (int tmp = start_index, tmp1 = end_index; \
> +	     tmp = get_pre_ldev_func(ldev, tmp, tmp1), \
> +	     i = tmp, tmp >= tmp1; tmp--)

Same?

Thanks,
Olek

