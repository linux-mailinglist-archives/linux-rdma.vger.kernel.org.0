Return-Path: <linux-rdma+bounces-1022-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C868D85540F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Feb 2024 21:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6761F22229
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Feb 2024 20:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F8738F86;
	Wed, 14 Feb 2024 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ky2ZA0ge"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2F1DDC1;
	Wed, 14 Feb 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942886; cv=fail; b=dD6IfBNLS8W06jo50IdUbiDkykReagCbrnhHwV/HP5J68baFZrWTfrq8Q6//1WVYaepxgu3Z/b05qA5D8oBgTnPVULOto4AmZx1WmGqJmwYXQeNAudYlUIhb3Yz/qFGJ/S0UBXvxzTG5VieTNp2W6VwV8prxGIn5UUZPb+WTs38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942886; c=relaxed/simple;
	bh=l2SJeDo9aPkhjIX6NJP5udyXSjtLyU6KCQl0SYjvxnw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hYnOpnDoXLsvbkDXChXnEoW8WsNOb2xed3BjFLd9DllGF7l284IQBBrM9fxL1P3uXOuRYNJnmRsxy4/8xiesTTmoLe3qEDcaKW3yGfioBKHiOgXGRNZutSa3nz26xidmQ6MYD+xOUvLachCvhJcPlCNRPqLvycs/4XmygTA+Etc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ky2ZA0ge; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707942884; x=1739478884;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l2SJeDo9aPkhjIX6NJP5udyXSjtLyU6KCQl0SYjvxnw=;
  b=ky2ZA0geN3h7FkWHG6f0pUJDdP1RcpWhqM3FJvxKB0mTgrvgV5W0m+6m
   5DItyZJNlZjFT8E+plogTv+tLwgxmdUpiyfDJ9oQcnRcmj/ItnHkrG/xa
   AJGNcuU4jU5qXqIdIIMV4bQn2/7R3qiTBdquU4SyksXd+ihJdlCO/4ygZ
   Ro95OVbJYi52t3Gif3HTLrgkhjgXPO6A26kQ4aNrjXSHUAtJ1fXIl0Q6+
   KuJMnqsC8pnbn9o3wXsCgH3faaxRwYSf7k0SPnmyBpFBg0EYA96o124hC
   FQCqfIQmMkgw9fZ1vSM/X21nBTum9daXd/zdPSCj/oNDl41nnXS1tvz9v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19425536"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19425536"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 12:34:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="40798796"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 12:34:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 12:34:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 12:34:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 12:34:42 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 12:34:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpajXNn016GeZ8gNRO4VyDZeEynxpFO/OX57L2cNseU2n9x0b1ykjXlL1SHkqUCu0aXFNcpEJa88WGE2VtXEBXMZp89JFt9VHT+80GA1GO68kUiBzNxE6irV+DTIegtv4eUk2tm3tcH+lywFYXOQHTry1oiLSBw9cqA9w6oO7sSUepvOScqYdCj9lYFRyWMRYogB8wtGcDnt12/2GS9Eb3ghlh/dCofyljzo+5sQyF4UvfqB7/1Xpl2mtjbVM9QLRgUIRIHpdOInuO3V2YWzC1xsIhqTHDauyuPFXZynMQPQ+5TESoGlLDcdbpV8CDaSBhCGJz8I4V4E4IJz8Xd3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avlc3GEe6Ir6nQt5ZaYv5bZo07fL1E2Eypju2XGCrIo=;
 b=L/08kCPlYfvmzVCzjRFlA6bPrHYZjIp52neOijLEDMrriwTyNZ39Lb7d+6PjwH2Acqp6MIxRkTZCUn7nwf+8aIk5cVdBjbRjvs6YIgs8/DL9qVHDwspyC4Gtmdh+7ujrh8XoyENpeTGokezze8CmFuKOsx35LIiqwOpI9PnU4V2X7tGd3Cb8M8+Tu+6I+bit+2yyT/kznEPQsbBk17NTfnWB7s/pCdPaiuxKc64OBDTeLxdcJ90PSw8yFELaf6RlSrcQQ3sVQlrEp9hZwq+uUj8u0VS4KnC8CKrkXuC9PjUZgvNHEnW/Onr2yC5IyRwzbr/xrEYwYl7HKqKjcZmXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7898.namprd11.prod.outlook.com (2603:10b6:930:7b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 20:34:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 20:34:38 +0000
Message-ID: <c4ac6063-b2e1-4edf-9116-39c24218a5bb@intel.com>
Date: Wed, 14 Feb 2024 12:34:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix possible stack overflows
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "Alex
 Vesker" <valex@nvidia.com>, Hamdan Igbaria <hamdani@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240213100848.458819-1-arnd@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240213100848.458819-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 2158de70-a347-4a31-dc5a-08dc2d9c5d1a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vrw+wxSRdHshihCcEauFNa8ltP6HCnkz/vUIjoQJ4+B0YWQXW28dECZX4LUuAx4CwnIfc7cJPSCFJyrAJImpTsmhR68iEfxusUHLDQa2ZOhwclyMOqRTSTQXx7YaJC3D+bz5HFmOWCfqCH//1HUY8vC0DL8VToSikwMGlxS9m8qm/guR7g7dIesh9JPxdGeqxYqE7JB3kUSAKzrqsqVIZSdBAgA3Uy7+bkwu0L7skHVD9QEl3zjGkm3ueVTLapzkM2deQ2FIhloyRzuWLeL0O16XR8q3vodFMFelINu0IcHy4jFLRWegdGcVXgr9t+KQD9PbgDukS4nMd/vOKf9zcK9kKmv1QHRQWMKnxCdjdnuXP7GuaZpuX4S6iiM4A6G1Fv/fSPjIaDO2FESyJrzCrqtOHIJ982R2dgU8iSz0R1MV35R/CaYLuvblXVDTc9sBangF6SOWW9QENjnKk/Lno2jSxGGaGTGMotVcTxLaWtBBknbAo89N8UKze6bPvfMn519Qn/+ETL6PQmbuilzF2hLvv6Ko5y+9ortm3rlKimV2W4lQML8FIZCb4mnHHAGR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31696002)(8676002)(8936002)(38100700002)(83380400001)(82960400001)(4326008)(2906002)(7416002)(66476007)(66556008)(66946007)(5660300002)(26005)(41300700001)(2616005)(316002)(6512007)(478600001)(110136005)(6506007)(54906003)(6666004)(53546011)(6486002)(86362001)(36756003)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTRhbFlvd0JLNFdjRDY1NnhRU29HeGF4TWF6dDQ3VHFhNk55VXVYaVVwdWNz?=
 =?utf-8?B?QkFDL1FQeGVrUEsrMncrRExzVHpucmJ3dzNETkhFUGg0WjVZT2JpWk5Ccmd2?=
 =?utf-8?B?LzRPR0ZGdjlLc1lrZU5xVXZHNWlLNWlzVDFTUHdsNmlJTVA5Q0N2Ri91RFFt?=
 =?utf-8?B?RzlmVGNNdmptRnd6LzJTd2NXYks4ZVBxUS9BMFp3UjB3Vmt6dkVKdnc4S2hY?=
 =?utf-8?B?b3FoNnYyeGhsekxQV2liTVVzV2loUWsrWXB1TVBpRmpPZ09ONHpCWWlrUmlM?=
 =?utf-8?B?SUx5SnIrWlZLU3pIU0hKcUVsVmVrY3l4ZkJYKzBrdXdMUjAzc3Y4MkJNS1Yx?=
 =?utf-8?B?Y0FNQ3BqUmpCOTIvV0lBUlhoaTYrNlFLOGpocmpXWGgrSzhkTFJUQ1BpT3Fi?=
 =?utf-8?B?cXJMSk1QUkd1cWZKVkxwd2JVaUM0cVlhbDVmNW13WGVveUxHSXFHdFh0K2dq?=
 =?utf-8?B?V1BIbmdZNER3Wk5yY2ZoUzROaHFJeHBGV29UdnNJck5ReFpnUXZ1MVJEaG91?=
 =?utf-8?B?NXl3WGtaVm9ZcEdNTkVPcDF1dExVek80L2g5aXRCeXo2SFRlUksyaExGOVMy?=
 =?utf-8?B?UTNpa2o4ZTZ1cmVBbHVnZnNwdTJaNFl2NEdMcm9CNU1hN3M4VEsxVWRuUTly?=
 =?utf-8?B?Nkk0SWRORVZGOHd5MXpZRTVJU0ptbVc3Q0RsZ3hQb3FaTGtUd1NXQ1J6NWtE?=
 =?utf-8?B?K2ErZW44TXMxVHYxK3pkcFdnM2J3MzFvZXYwNDlxS0JVeUFFSTVQR1JETFZ5?=
 =?utf-8?B?R05hNmQ3blAvQWk2Yno4eEM5U3YzR2dQUnlkUTBGK29XbXRUK1lLUTlsRnJR?=
 =?utf-8?B?TXdkVmRFeXUyWDZqaDhHdXdFSVlFTlV3RGJaS2lDeVlLdloxZFZSNkE2M2U0?=
 =?utf-8?B?RVFXRllOVkdRa21uU3ZNWkQ3QjRNcTdvYVNjNnhUdi95dkgvZ0Ezbkc5aXU4?=
 =?utf-8?B?MjV6bnZlK3ZINmRzek5TZnMvN3ZDYjVBRE5ualA3Rkx0ZWFrQ09xYmRWeHBJ?=
 =?utf-8?B?Y1VnOGZuT1RhUEZ1OHJpUVpEUzBVcFNLL3VuTmRQdkVBTHpTTFRUaVY2c3g5?=
 =?utf-8?B?VWtrYmRPcVNXcVB2NnM5bFFpekZ6UklhTm10V2RuNUVwV2RPUGd5Nmh4Z3ZU?=
 =?utf-8?B?a0tCaGI0ZitOVjNUZzdlV25NZ3RyTlFRUWlOMDgrV0pod1pFZEtZVzZGZUtP?=
 =?utf-8?B?czVGTFdsMGlWaytNemlxRUFvNjBrZmhOcjFUZ2NiUUlvRGRqRlJMMmpVNENh?=
 =?utf-8?B?bHpyNVFOcXoyTHhGS2cvdnlxT2JVUkpidWZoekVONnQzZGF6c0FsZ2lwbnNT?=
 =?utf-8?B?MTVLbHVISnI0NUI4R3F2TFB0Yzhoc3kvQThJZXRJeVR6SE1vQ2NDaS9qS0ZR?=
 =?utf-8?B?dTA5Z3haM0xEMVR0ejBzS1o0d1hHKzJhUFh1UytRVDA0dlpuSEFXdm9hQlBi?=
 =?utf-8?B?VHluU1FlaHQrQjhmeWRsQUFwRmVlN1ZFbElUMURmTWhWQjJmOU1IWlVMUllU?=
 =?utf-8?B?UEJIbDg2YWFSVmN6Q3AybEh3dzBMQ2l0VUF0QXNsaklJL0RXWUFjRk12ZWQv?=
 =?utf-8?B?a2Zwa3hlYmh0aWpoWXBRak9wOVdmeGdjZnNGK3JNU0pFLytNWEc1TXZNWGpu?=
 =?utf-8?B?Vk1jMGxReWd0cmFCRlVQQXBHblhIVXNEc1NDY3JuVC9mbWN1QUVzUEpDYTc1?=
 =?utf-8?B?TFpDaURONjZNNWtJeVlGMWhGc1oyOThJSHlvbHRIS1FyMjVsR2tXazh1RTNJ?=
 =?utf-8?B?K3BBTmNDcmJNbW52ek54WFRES0RTTVZVbm13KzR4TEt2NUlLZldPWkxINi9t?=
 =?utf-8?B?aTNDY2VkRkpZcVRKYnB6cFRDWHQwN3lzRmhlMnNjcXBhQ1V5dmx1cWsvVU5u?=
 =?utf-8?B?MGM5Y0xwYTFRYkF4YisxZVljUEc4eDZQY2FpYnE3TXZxejdrR0lMcUZnVGpE?=
 =?utf-8?B?VmlLUTJQdjJxZ3pET0hPWFJxMjl5Q3hSTDBJb2JhOWt0UjdFdEs2WDFwV0t6?=
 =?utf-8?B?TUdtZU56YmN4eXpKSGFYNHRNK0NWalF4d1BkWGxrb2YzZFZXTDREZFh2MmxQ?=
 =?utf-8?B?UTZsWDhkQUxKTmZjaG1VYmxRVnUzKzRMN1FueW42Ukc2QzBvMy9Jem8zZFlk?=
 =?utf-8?B?NkZ1QjA2aHZDeFlSR25HNVl3ZTRVZ2JMc1FEZnU4YnV6QTJwUG8xakN4L0RR?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2158de70-a347-4a31-dc5a-08dc2d9c5d1a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:34:38.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UKfx68oCMF1od6wepu3CDPwb/6Epnc3334fUFTnV276QDLusTymNgDPWLXKGsfy0F09YfwQzXDxiFu4WJQ2D3otshQ/H7mn166NXA8xJLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7898
X-OriginatorOrg: intel.com



On 2/13/2024 2:08 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A couple of debug functions use a 512 byte temporary buffer and call another
> function that has another buffer of the same size, which in turn exceeds the
> usual warning limit for excessive stack usage:
> 
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1073:1: error: stack frame size (1448) exceeds limit (1024) in 'dr_dump_start' [-Werror,-Wframe-larger-than]
> dr_dump_start(struct seq_file *file, loff_t *pos)
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1009:1: error: stack frame size (1120) exceeds limit (1024) in 'dr_dump_domain' [-Werror,-Wframe-larger-than]
> dr_dump_domain(struct seq_file *file, struct mlx5dr_domain *dmn)
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:705:1: error: stack frame size (1104) exceeds limit (1024) in 'dr_dump_matcher_rx_tx' [-Werror,-Wframe-larger-than]
> dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
> 
> Rework these so that each of the various code paths only ever has one of
> these buffers in it, and exactly the functions that declare one have
> the 'noinline_for_stack' annotation that prevents them from all being
> inlined into the same caller.
> 
> Fixes: 917d1e799ddf ("net/mlx5: DR, Change SWS usage to debug fs seq_file interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

