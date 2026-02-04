Return-Path: <linux-rdma+bounces-16551-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCbVDpjKg2m6uQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16551-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 23:39:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AC7ED035
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 23:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0F24301547A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 22:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF0231E0EB;
	Wed,  4 Feb 2026 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcPCwC7e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15232192FA;
	Wed,  4 Feb 2026 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244754; cv=fail; b=bjTe/Hh+JI1SZ9DZRKijdONvkjyUfWdQYFbLmLOMQ47zUKtCLnf7arfT12qoFdWfqUGkfhatOhFSHTu4NsECuNk/8mMuM2/Zpdu6+8beU8x3EJdpQKRC4DSRDSFSfXxSanOyBpuyUtq1yWyHZZmt3W4Mjh3TgtpDnxig9hoqF7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244754; c=relaxed/simple;
	bh=TY+rR5i28+mplUETGRp2AErCcbyqjzgf9WUlsjIUfxM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hxsw1yHPsA/qiPQ9R/dRCaST8WV7gbCXfQnHrBRaro45hm4MvAvh1iNGJr3o5210LK0XZCaTR+Nvcpxwm3GJsyacn4xO1u3HzpHj0hCqAbOd0PZ28bAb3AR0XtP19MX40F1vS6soKhdnPcr/JgwQkfcpk2A+VqyHOruUMmLT9Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcPCwC7e; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770244754; x=1801780754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TY+rR5i28+mplUETGRp2AErCcbyqjzgf9WUlsjIUfxM=;
  b=BcPCwC7eSQ19Lurc3OR1veUFE2OmCYv/+hDd3fuVi6UAY8Kh+rjzv7T5
   IOnyCytyI2Gfae4qWcYU90dlua2OAx9S3K8XYXDVCr5xUIrG6FMIUVDED
   9++oSO+QYuoW747ifTDJhQZ475M/pbpdu6If9Zz6Xu/foAGE/FhPeBlP0
   jSmCjIjVLDRf+/z6IMSajAXjsm2T+oIC4L5SBiMwatKHuex5KCnYS0tTz
   nSto655lHe0pLKWzow81TT/2Q/Gq/PKL5cw0u1BQhnVXjGYoFRi5mn35B
   v7Le0hT0ACXpsxFWDyLWT/02eJF2k0KqJs7V75PDWQWzj5Fz4vW2+n/yG
   g==;
X-CSE-ConnectionGUID: YaMR+WyCTIKV9ckvcodyMA==
X-CSE-MsgGUID: dzGw5q39S8WbDg5GkF+gVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="59017866"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="59017866"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 14:39:13 -0800
X-CSE-ConnectionGUID: m882muhIQj2fryUAS0/vIw==
X-CSE-MsgGUID: 6ciVu7icQSe29tyZDHejAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="247896087"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 14:39:13 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 14:39:12 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 14:39:12 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 14:39:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vhl9msT35uTP0vp/gPvU3+alb25V5Q86bixCae2MbieoskjoyykOWpSr/609KW69OPohB8PbxJFsw8gCoyM1adFgSLVMhccm8XZgEOxYrZ1Vkba/W1sXM7k52PVd7XxPs1DpR/K/2HZn8bkfk1fZUcxoJSRYAmniSPwRD3V8L0QLd89shoU/ES35osl8npZnQLy97epD4NmMmSB8W1/hiKqFuqjhgtPV97UlcJqUglw2LD/bjFQ2fOqDpWaeyT7EjChFRSe7jw4QxpUHcWW8FhCDAH4Gfol+4J3AfUEn6oOFfxxUP4G+B9m6bsw4It81OgifUxKWwC42bHX0InEFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OkoDkDldaOiLFzXH2K+r/vSChs4RUVL+S+Awf3B0aU=;
 b=EV879imOs2vD7tt5yzZRdtwABFWoA6PQBVrBNHsdCvbceIU/QNUUyJ6vnuBfamncgtJaIsQCEZl451xIuZYs5fobT48frCAn8mokRfeNCZnbTqzo/gwttZM7qsU0Jzk3VPvph/BN0FO4AqwDPnhQvmscRQiw42cuisVHyUVvOljwbf7i6HDuxmlckt9pdkqMfh65UJbdb3wtezm8KKNjG0wLHM6/IACQlINTDF1D4+d3I2Q4K2Csu5UX+LFepQZ3dwkWEtmIWDyvjNp8f594eXF6qIkoya+eT+H8QFXRRvtLQLcNabhNx4RdowbmqR+iQfl/GubYzlkbPkzzISDrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 22:39:09 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 22:39:09 +0000
Message-ID: <5513093e-5215-448c-b282-ff42f1db2087@intel.com>
Date: Wed, 4 Feb 2026 14:39:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Fix 1600G link mode enum naming
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Dawid Osuchowski
	<dawid.osuchowski@linux.intel.com>, Shahar Shitrit <shshitrit@nvidia.com>
References: <20260204194324.1723534-1-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260204194324.1723534-1-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::21) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|LV2PR11MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: f3277112-5ebb-42d1-bb3b-08de643e361f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blVISW10ZlhTU0lubU9nMmVEYThKZGxKaXllRUl5NkJWbFdyaHRZVm1ZYzlI?=
 =?utf-8?B?VW82WFB4anRPMno1SlpiRWlEckEwelBINUhXM2dqbm5SczBYTTlYdjVqdUtC?=
 =?utf-8?B?ZkY4bnI4VlNiUVRYd3hIdVlJcCtXem5GbmVwK2t5dXIvaUovVm4rckZOdlpI?=
 =?utf-8?B?S205WDlkREt4T1RUVFg2YXZyNjJSRnF4ZEdxdXpFVU1SR3N1b2ExcFZhSWVn?=
 =?utf-8?B?TnZyd2kzN1dLQTMxZEE5dUNrYTZxYVZJSUpVbTB1WEN0c2ZSdm03SUp5U1V0?=
 =?utf-8?B?MSs1SUhYQXNmenpaUFVSK0t4WStJek5PYmxuNWxrd2FZMGhzS0FIRksrT2Fs?=
 =?utf-8?B?dDljMUxlQWMvV3NRSE1Za2toc2hnWjRzVXhnclY3ck1yZVJieDFsYVZjYm84?=
 =?utf-8?B?cjdHL3JCZ2ZTMk1KT2lvblE0c3BnbCszS3cybHJLcGVMUXI4QW5TTXRXUjg3?=
 =?utf-8?B?VWtCNytTWDVhZy9pZm9YbkJ3U0QxWFRtNHFnQXRIeFhOWWdkSHo0N20zdUtK?=
 =?utf-8?B?N0VxY3VMV2ZBVkFsWnoyNy9LYSsxNWdoQmxkOFNEN0xDeWQvMmJ3MnQxR2xW?=
 =?utf-8?B?WUxrd1BBMzFtbUl4V1NqemRHRFdwYkhvNE1vKzBJQmduejQ1TzZLdFo1QlNm?=
 =?utf-8?B?WEZTNDlHNHNjNzFXNUFWTFQ4eWlvYldTZDlyY3JoOXFUQ0tBWDJkcklZMi9S?=
 =?utf-8?B?MDRZQXJqMjFuQ0JodC82QnQrMlpVUC9yb1NEV3pTZnowYXRuUVpTWU9sRTEv?=
 =?utf-8?B?MHE4Y3VBcW0zV1dnTk9zYzJSWWRxd2duaFJreGtrOEdmVk9tcWUvUFVNeG1x?=
 =?utf-8?B?SmhpUFB5Vk5HM0NYeGVzM1Y5M25sSFNjU0t1ZlJrNmZoU2tWUmVJWlRHTWpy?=
 =?utf-8?B?bzhxay9Zb0ZjekRXUVNpeDlqRXVzWVQ2Kys4dXhlZzdsL3hFUnRqQWowRWJr?=
 =?utf-8?B?OVY2ZEhoR1VRanl0QWVIMlpYL3oxUGdlQ1hjdTFiaW14S2pFRGZjMVc0aVdS?=
 =?utf-8?B?eHo0QXRBSWtvWGFDUElOQVQ0aDg3RTBnTUlWK1ZsajlhQlJiOUJreGIyNGtu?=
 =?utf-8?B?aHdJNGlaU3J1YzcrcjJmcmNSNG5OOUJQSmgvZXg4bEJJN3licTJ2UlJuK2R0?=
 =?utf-8?B?VU1oWGpEYWxlV3FpOXdBTFJIWDlHWUxwblF4dytYUFJuUkUyL2psVTV4bDZv?=
 =?utf-8?B?OXNKSEVQbjdQZElBTHZRODYwMkNSVFFpVmVzak96My9xYTdJclpXVmE0azF6?=
 =?utf-8?B?aGdVWU1RR2J3U29IbGxDOUc0cXYvMURmYjRoQ3ZjcWJ1bTBSUHVhL2YxZU8v?=
 =?utf-8?B?WWx0MnQxTHA5UXUvQ2NWSnE5S04zMCtUTmMzWDdCUkRUS1ZYdVh2dzkyUzZx?=
 =?utf-8?B?cW9EZHdnb0dNbzJ5ZEpxSFhmUVlTdFYvcnFUQ21LM3IxQXRIWDZpdEFQeENy?=
 =?utf-8?B?MTRCVSs3b0doVzBEbm5KS2RQWG9RVnUvWHpFVVRsckRwUTMwdUcyQ1lVS3lm?=
 =?utf-8?B?STh0R2VpcERhM0pMRHpHZkNPVUh2aEhsQ1BiWVlVOGQxcklFQVkxdVRyTFBQ?=
 =?utf-8?B?QmU2UlM4M1FINHV5WTBDQnVuWE5PTlJwUVNEL2NmWVFWSE1tMWNYODdwTXpr?=
 =?utf-8?B?VkVaSVB1Q2QybHhFNjd3cjNGcnVWRmxHRG1UTXdjSS9ZMEZrbFN2Ry9hZDgx?=
 =?utf-8?B?dFo2WVMvRXdvUVdabk5WOUIzRVVmcXNJa01Uc0xQbFlUTEFLcjZtQ2xic2tZ?=
 =?utf-8?B?YmZ1bGNHRWk5cHhkWXFIUHMyMVlQL2p5WUh5WUEvRmRRZ3I4cjFadFpkYit1?=
 =?utf-8?B?aTdpTWpFUWphYi8xRXBUNkFHZXV3a1BxelY0SEovYkN4RnZuN1BWNHJpZDE3?=
 =?utf-8?B?SGQ0YUloQ2VDa0dwU1ZPUDE1THkrSDhQRHZRRUpjWi84Y1BIQ05KVjdPaUdk?=
 =?utf-8?B?VlVPZDBGZTgyNkE0ZktrWHgvWGZ4dkpITEsrNHF5bHVrNFY1aEpCYlBYMlVt?=
 =?utf-8?B?alNjc042bURzVEdrOW12bGpFM1o3aWxUWWlQeE0yZ0p0NUs3ME03dDl3eHFh?=
 =?utf-8?B?aHlPTzVXTG1sbmpCZ3MrSzRySHQ4OUVoRXNoc0NCS0tRdGdPdE9oM3NVOGpP?=
 =?utf-8?Q?7Z8w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWU3UC96VzB5cEhQU1ljTExZRFJ2YXZ4b1k5c3hoLy8zSXRqaCtMN1A1L2xI?=
 =?utf-8?B?aFo4cmhacUkzK3gwRUc3RTVNZTZzOHhZMXM5clhlTUVkR3JzRStiZVdHMkw0?=
 =?utf-8?B?ZG51NmNnRWlHV2h4K2JpSHlOdW8rK0NocDd6cDVwcFNzNW1RaDVYR3d5SU5r?=
 =?utf-8?B?RnBKSFg3a3MxU3N5M3k0Z1Jkak9XdzR3b255L3hGVmltaGowU3ZlWWpaK29r?=
 =?utf-8?B?VU9HU05ONm54SnN6Vk8yRDZZUkNiZUlwQlFFK1lOVElBSDczR0phYTVkelI2?=
 =?utf-8?B?UEx2c3RjRHF3a2E4QlNNSzBDZW1Qb3hLd0VySkM0UERUaTROTDdJaHJmNFo5?=
 =?utf-8?B?QVh1N0lIQTZwaEJPZ2gwVTljNkJ2TytyaWFjN2lhRXIxdnpLVHJBLzBGT3J2?=
 =?utf-8?B?RVRYOU9SNEEyZytXbWZkM2dtenpzS1IwTmQ5SmNPV2wrWVlOSCt6TWR0MmhC?=
 =?utf-8?B?T3VLVHhFSHlCbnFQTGo4YlJpM0VqWGVDc1NZRkRHTnI2WHY1ZldBeEdKVnFG?=
 =?utf-8?B?Y3FmS2tOT3RFS1g2UWRjYm1COUlPQXhXUWRsK3dHNnJkQkkzQlNDUG8vakxM?=
 =?utf-8?B?YnI0RDk2V2ZJZFgzYmZUYTgwdDYzRW5xUXFubWlhZmh3cVJKYTBRZW10S3JL?=
 =?utf-8?B?RVN0QkpjWVdMNVZlTmFTazY1UVNrY0xRYittVWdaT3FZRStralhSOUgwbGtv?=
 =?utf-8?B?TzNzODVpbU9mMHNwQ1VyL2lFa0pZK2V6dHQycm5keXFveUtXVTNzNnJJMVJz?=
 =?utf-8?B?MitEMnl1MmJhUHJqY3lxZzVHTDY3NVpQY3A3aks1VWN5Q1JJMGQ4OHpCemZY?=
 =?utf-8?B?dXd2Z1hqOHFVc0dhVVZWb1lrbG9GUk9uQVAyRzhlV3FmbE9TSTNodS9XTTEv?=
 =?utf-8?B?eXVCS3NWSUxqKzZTcWdkUEhMWU1jbmhJRlZCSUR4ZGdhTG5hUVJNS0hnT3dB?=
 =?utf-8?B?ejlldUdiZ0RaOWc1Und4RjgwMTB0U1BVK3k2c2R1cDBEbW9YUFRmKy9SSnJY?=
 =?utf-8?B?YzNzOXRJcTZYTHU4QTlvNEI0aG5yQnRTSTdXc2dtS2R1TTZKdEQrZHlkRFky?=
 =?utf-8?B?ZkJwcTVIbFBQUWZRSklwUHp1NEo2YmlQOHN5KzZVNmFkcTUyVUphR3pFeFh3?=
 =?utf-8?B?Q0M4WEtCTEdyNkJBVDBHeHlJZm5oTUt4SC9pdzVraUZvUitCK2ZRbFcrWStx?=
 =?utf-8?B?NnRTbjdxSFFwQzd5QWJjU1RlVVRLcmZjT1YvcXJYcXArL2o2NDRZVVlwUWFH?=
 =?utf-8?B?Q1lBRFFZaTFNRzRlSFRRWmdDZ3RaT09SYVBwR3ZjdFBtdjZZVTYrMEh3SGRz?=
 =?utf-8?B?cWxDTTNqWG9tejQvZkxBN2s3Qk10ZkVSTEtNUW14ZGZ0dHFjQktjbGlOamlM?=
 =?utf-8?B?WVNVcmQ3eXJ2cVcxRWFsZmZUUmw5Yks4NW1rRVFpa1hJS2d2dzNyOExFdVVQ?=
 =?utf-8?B?ek5QOEpTT1ZYd1l4dUNoaFZQOUFIdStPOVRDRmpyeWtIL0tBNXF0cUw2OEJV?=
 =?utf-8?B?azV4bDdZYk9sVlMwQ1lLTzdzcGFML0R0TmEzVkdjRFBNdXZlSXJiNFY4bWtm?=
 =?utf-8?B?alg4OXFveUtEeXBIN04rZVo1NGJnNmxZaWQwalVRTEFldXVhZFE5aHpGQU8w?=
 =?utf-8?B?L2YwN1lJQ0pQNFB2NUcrUlVsb0J1N0dhcUVRWUcvS1NqQmllNkhubThGcThI?=
 =?utf-8?B?RVQreXFRVjlmclN4amMvNm4wRHV4RUVtTlIzZUswazBhaFlKTHZUcFRCVkxS?=
 =?utf-8?B?VldITHgwQzJKMUpHa0pUMmxqSFJjbGpiMS9qZVQwblQvUnNGNGdnTmJKbGtP?=
 =?utf-8?B?T0dPWWhieFYvemlZMi9iZVN3bG02YUhFcXFkMTFRV3lJdXd4aTd4SXZadHNx?=
 =?utf-8?B?OXIrM1RSUFN2OHJNQUNHTThKK0U0dmxSSUhkdTVYbmZza2loblNnaGRaaElh?=
 =?utf-8?B?ajJOT3pyc0JJbDArNU9vNFdwM2lDa09tNWNQMjEwS0hMTVA0bkpob2UvZCtB?=
 =?utf-8?B?LzZObjA0cm9tV2pSSDQ0M0U2V2g1NUYvYVhDRnVTUjEvVE1BU3E3d3VncGZ6?=
 =?utf-8?B?Z293bnEveCs5UTVsMTBFU3BpdmhDZTRZRUpiUFUzS05nTVJsY0tGajVyVE5r?=
 =?utf-8?B?YklXWHJQZmlZeTVoVUxaaG44MHVwbXBodGQwcjd2MG8wbEMxNUJoWGJGbEkw?=
 =?utf-8?B?NVJvTzhlZ3ZmSjRIRVllTUNNMXRaS0NOaWpBbGFaS01mazB2VUFta1JjOFZS?=
 =?utf-8?B?Sy93czdFcWNadHEzUnVyZGVZTDFjcGhnSWVCMUFOVFM0amhkT3AyUkU1L3Zu?=
 =?utf-8?B?ZE0vVDRNcjZuS2w0Qmd5dVpsNy9mOXlKRngxRFFqb3V1UTVIdDhDY3pCTTgw?=
 =?utf-8?Q?xMODerrITmxeKKGI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3277112-5ebb-42d1-bb3b-08de643e361f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:39:09.3588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRferxQ3UVj3d/3eKR1mGoHlQ+jvPvit+joglDR7VtnXp/BbQf4B/Yx2R6Nr2WEYQtDXUQSVnFhHxgFT1LoWQ3Xi76eLvFs3ibBvQurm4Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16551-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 95AC7ED035
X-Rspamd-Action: no action



On 2/4/2026 11:43 AM, Tariq Toukan wrote:
> From: Yael Chemla <ychemla@nvidia.com>
> 
> Rename TAUI/TBASE to GAUI/GBASE in 1600G link mode identifier and its
> usage in ethtool and link-info tables.
> 
> Reported-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Yael Chemla <ychemla@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

