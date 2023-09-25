Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD4D7AE1D9
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 00:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjIYWpq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 18:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjIYWpp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 18:45:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC96126;
        Mon, 25 Sep 2023 15:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695681937; x=1727217937;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zUDSVdchkkkfvB06x5QdbcNsbfxlSREH70QteQRmCcs=;
  b=J+e2Emjb592zI+qjGG0LfhPEP2vaKsTjnz9MchB9FvafSiEQkdkp040I
   yYmDcR34WsSpd1p1/aWmFz8rJTYqq0B1xtUZHDXAQHF932f3Frhsj1GdH
   9QScpZ15U3IFUAs2y/1kSeV/DlzwK2yzQgFYME0lU0NT72WiTYptRqZA/
   M20QWnJbD7MSX72eMyeKsnblPYr8jgTL3ZTyruXJwqx5SxblX+cNnGa53
   4dxQDn9q8OVrfBRaEPVlZhOLlCneZcHNCBTkQbr5wmATcnxPHetj/rcwW
   A/NHbWNV7H8KKsCjDSwqQ8BjOqJeSsvH9E/S5UJfTZiPzmRwwqBdKFuwd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380292392"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="380292392"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 15:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995579627"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="995579627"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 15:45:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:45:35 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:45:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 15:45:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 15:45:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhomtWpSB84ez3itfBdKR/1FFjMC0cNpObjWn/xyDlT1fU7pV6P0NMk5WT1nl+BSsJcrsw+I5XicmgfzX4vosgrmJM7ON4LDzF9bPlNWZ4w2PGOhwlmiquay2BJBgPXmKOE8I5COdWLJoBLzA9PrXhWgGp+zll1AMK/jwDsH4pQpWnZK/M/SMlbF2pgDUmvnqyiZjRQ95odEgcvH+7e8718hVRhc9ql9KhMQr8Lb9bKC513i/X8xiailOjLF1k4uHse1W1Ma0jVtbuBwPFJEBebmfzjPrxG6sLLYobHYB2TyYaoZEwpLNHIvoGB8tW1kxFsXn54MnwoShm7ZPzvpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/v9Cb19b5MsG5fVOsPQ3Nb5niq1qbjgKwSwbP1QDRg4=;
 b=DyafIZ+Fg1g/6AzPwF1e2fBsmNKJedKfVwukJTeWLIiP0WRJL2ogMr57D5Juts6cFQvS66pYLIqSuEI6Y7Q/ycoZEL+I6kl40uEPlr3kztR1i3YxkKm99HzYOgWxjEcHQWOjOFaYm3r0yJqTiJ+hWfEiq5vLlGCIp/2uGjQ+WNg0Gc88q7uGh3PWMzb4TEJKOnMAguYO03ZGNNZW9uyrdM7d8cG9ObOhwjnB3FiEYlo+aKrZ2p7rZMJQmzEqD9v3aZxDXaBmlbssWQBs0aakoTMLmH9tR9mTBpDj+qTwTAaTfsgBCaiI7vICvQj9Wf9V5hgsd/OJEE+lA3rzgd5SPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 25 Sep
 2023 22:45:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Mon, 25 Sep 2023
 22:45:26 +0000
Message-ID: <d708c1a8-1b7a-c772-9457-f06b59d6235e@intel.com>
Date:   Mon, 25 Sep 2023 15:45:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] net: mellanox: drop mlx5_cpumask_default_spread()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
CC:     Tariq Toukan <ttoukan.linux@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Maher Sanalla <msanalla@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Yury Norov <ynorov@nvidia.com>
References: <20230925020528.777578-1-yury.norov@gmail.com>
 <20230925020528.777578-2-yury.norov@gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230925020528.777578-2-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd0a46e-c0d9-48e7-f073-08dbbe191c8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndlyy9qj4Kw2V7xBlvN1mxGoZFPOcAjvG0dv9AKyZmrChQVMo0xJRsjKhkR6i0juVxQOzesMAsp1mFs0bawHkL8q9jotcAuceJugOiPEX8JprOfCD326GiaD3dHLz1MgwHId+434KxzM0xpK5DZV2HS3cGeaMVOmxnakqgxfSJ4t0tFl9CKlgu99gkolE1trQFEwulmuDSHA/0CeurawDuTHjxMjYwLWaVyEpL7LFj2I+hs3Sy85txhw+jsKmFXA3eMUNzIcT4yXiVOL/aYoBnyUuk30S52LE387Xc2tOhOP6V+mo/8a1LH1VzrIyur+Xxza7LlUZNsKInKwpQmTcKvkhD3W/sZZxtabzbHWHu0Y9tf5L+fbkrxkngSZSvFTFeQEMzzEIuvwb/+EGmmt4z41UsgpNoN2oXvOFgLJB45wCWVLyf9dtXcFeAcjab/dvl+8qeididw2a9eFWycksPn5wNyUc3YqGb9r4GtbCfwp9LruhAePr5ECTLrpuYblMGRQzVtE/kPdJIABE+iyIKP/gvhXWfTtZc15fb2bEHWhFU4nTsY17ShU8xQUGed6gnvz2B+yjPLL95AXsIQJwR/wu0KAlDlfYpgOO3m8AZ+pgMUK+F5yH1RJxPAlH7g/jdGTF4oD7D0W0qZJCpRYpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(26005)(6666004)(478600001)(2616005)(36756003)(83380400001)(31696002)(86362001)(82960400001)(6486002)(53546011)(5660300002)(6506007)(38100700002)(6512007)(2906002)(4326008)(8676002)(31686004)(54906003)(41300700001)(316002)(66946007)(66556008)(66476007)(7416002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhiK29qV21zcnhjNHZEaFdIOVdlRURuSjZwRmpnY0dDeXdOY1hYeHQwOWNs?=
 =?utf-8?B?c21xdlpmT05FZWNVTm9ZUVlRUjVJbkNBUXpLTWpkU3d3SkREVGNuUHdENzF0?=
 =?utf-8?B?Z0FMeUlIWUFuS29RcWdWQUJCeDJTbkpIUGpsbEc0dGxuQ2o3TmhuK3VLQkZ5?=
 =?utf-8?B?RC9YOVoxT2lFUjhncHUzU0dvWVBsbDFmZlJZYnBocWRCdlh1N2NKSFdrOXo5?=
 =?utf-8?B?TVpZU0JoRUMxM3lycUNFQnVzSW5kNTNSbFp2S1NUTytyNTFqa2VZQ1JXdmJP?=
 =?utf-8?B?dGJKUmZaeXIzakxOc2h2dm9hUWFpQnRKbnJ3QjZHemFaQSt0aE94TDNMN1FC?=
 =?utf-8?B?VHBiWWJwdjBFb3QySHZpUmJVZWJ5YVgycmt5ZGRDVWR0Y01aSzFkK0N1NUlq?=
 =?utf-8?B?S2ZEMnkvbnNOZ0RqaWxWUDR4aXRlZUJ0Ymc5cUxZZnBrRUlGZEJRTHJaUjBU?=
 =?utf-8?B?Y2xWK0RkMHRXU0JaWWFQQk1DQTdvYjh2cUJxNkdQRUJxMExTTW1VckxZRDBz?=
 =?utf-8?B?dzR3Q0lMdm1Mb0RuaStwOUxhemFyVUgzRzM4NHR6WmhudnlVTmxTS1lycmti?=
 =?utf-8?B?TWlBSGkyOVJNQXROeU9zQXQrWmc3akJnbmtmamtzMG0xa0FlMldYZWo2TitJ?=
 =?utf-8?B?THBaUk9wbUt2bXJMTWIya3F3aXJLbU1KMmZXcXpNeHBjZW5nN0ZNT1ZOQThx?=
 =?utf-8?B?aUU4ajVVZFVraW9RV0Y4R0Q2NDRmeTFuMy9vM2hjMUNVU0UzRHpNSXJhY2x3?=
 =?utf-8?B?UG5lbkpZYnJseVFpbTdFTTYyVjc1bVJ3ZlZrd2l3cmVSOHZYQ015aUpwVE9L?=
 =?utf-8?B?MFpuZFk4QWh2dUNrMy9pSHB4NUNWQ3p4OWE3ekhHQmZtT0cwY3RsTzR3Y3px?=
 =?utf-8?B?QnJ4VHhpdHdRQzFDYUg4NDhmVnNNbVFBaXJjOEE0YmdsSFlDWWxwUmk0bkRI?=
 =?utf-8?B?YW5MNWJFbllZSEtoMHI2SFRXL2hSQkZKUno1N1pUUFNWSmZHdFZrOGNFUjcr?=
 =?utf-8?B?QmZpUkRKV3B5dDhJVzVnYjFxSHRIVURROFIwZERUMU9mSlhiK1VMcHg0TUFh?=
 =?utf-8?B?Z0VTeGFWakJxbllNS0Q2dTBOVFRuY3JyWi8rZ1pTUE16Q0hMZHRYeno4OXVL?=
 =?utf-8?B?NTN0UW01dFhQU0FaRUdrU1MrS1YvYUxLNFdIVjQ5RlRVS1RLVlNOZUFHSWJo?=
 =?utf-8?B?bCtENEF0TG40K0h0MzBObTJrVllMYnh5di9YUW1lODNmZHVBUENwdUIwVEFv?=
 =?utf-8?B?K3FVK1FWSTF2ek5FdFJjRkdRbEJlR0pZdTRuQkpSWUVnZVM2d3dyb25lYjNX?=
 =?utf-8?B?c0RGME1GU2VzbG1Ld0FEM25ZSzZrM2hQTnpmbTNKbEpnVmpWVjdIVFFWcllk?=
 =?utf-8?B?QXc1ZC80ZXR0UlozRU5aZytyVVhRVlhIUWJXczBUN2F4TmJOdmtKT0tMTEFw?=
 =?utf-8?B?UlMzN1RhMWxFWWI3Zi9ZdFdXRnh0eEtlRmY1ckpacjk1dGVQWGZKcWdLNWl1?=
 =?utf-8?B?QmFjQmVMUDZSbTRGYnRLd0g5NlRsbWF3ZHk3SktPUU8wWkw0TGlObVk3VHBm?=
 =?utf-8?B?OHdLb3VBY3NPT3J2ZWN5Y2lOLzZCaU4xK0VIUVNXdEd6RWZBUEZoUERNRmtt?=
 =?utf-8?B?SC84a1ZPWmVMNFJiTDdnLzVGS1dMbTNCc2xEOVlJeHQ3aWVoRTVVampkQmli?=
 =?utf-8?B?bHdyQ3RQL2ZQTW1MVlBPOCsrMDlmYzk5QStqSHExWG9XY1pHNm02VGJUamF6?=
 =?utf-8?B?WjB1MmxGUjFSd3ZmcHNuM3ZLNXBNV3phaWhVdGZlTVNwOUZDdmhjZmFQQUIr?=
 =?utf-8?B?aXI5TGNtbkRXRUVMUmxhVEgyUzk5TEh3Nk1NNlU2VXJzd0h6OHNkWVFKVHY2?=
 =?utf-8?B?QVVicWFTZVRCUnlwWVZ3OVZzeTJSSS91T1lDVCtJVnQ1RGhnRVY5Z0hiaHBW?=
 =?utf-8?B?eWtHREkwQUloU0U4L0N3VFVFUEJlWUg1OEpHVkVCVUhzOWRESGVxMHMzdXVw?=
 =?utf-8?B?SG1lcXlhcGhNdGpiRnZmRTVlWWVXbFdZUjFIZnhEY1FJOFB4NTVHUzFkcXZK?=
 =?utf-8?B?d1NsL1lYb0ErUTRRa2NaQklUbDdkZ0FOV3RPa21ycmNaeUNLWnk3SXR4eWxF?=
 =?utf-8?B?cVNSbTZ5b3JIM1JTcTZuT1ZTSGhWcEw2Ky9OajJJNDllMEVyT0h1b2g1VmhN?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd0a46e-c0d9-48e7-f073-08dbbe191c8f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 22:45:26.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vMCf2FkZWvb0VzHNm3Bl1Sk0tqyOp04fHa9yrNJ68JRzpcVPz1GspKqG4JZ4YTGWK4SFOUhTakx6Abdobe/9IpqdPM9mXljaqv7drp3hVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/24/2023 7:05 PM, Yury Norov wrote:
> The function duplicates existing cpumask_local_spread(), and it's O(N),
> while cpumask_local_spread() implementation is based on bsearch, and
> thus is O(log n), so drop mlx5_cpumask_default_spread() and use generic
> cpumask_local_spread().
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 28 ++------------------
>  1 file changed, 2 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> index ea0405e0a43f..bd9f857cc52d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> @@ -828,30 +828,6 @@ static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx)
>  	mlx5_irq_release_vector(irq);
>  }
>  

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> -static int mlx5_cpumask_default_spread(int numa_node, int index)
> -{
> -	const struct cpumask *prev = cpu_none_mask;
> -	const struct cpumask *mask;
> -	int found_cpu = 0;
> -	int i = 0;
> -	int cpu;
> -
> -	rcu_read_lock();
> -	for_each_numa_hop_mask(mask, numa_node) {
> -		for_each_cpu_andnot(cpu, mask, prev) {
> -			if (i++ == index) {
> -				found_cpu = cpu;
> -				goto spread_done;
> -			}
> -		}
> -		prev = mask;
> -	}
> -
> -spread_done:
> -	rcu_read_unlock();
> -	return found_cpu;
> -}
> -
>  static struct cpu_rmap *mlx5_eq_table_get_pci_rmap(struct mlx5_core_dev *dev)
>  {
>  #ifdef CONFIG_RFS_ACCEL
> @@ -873,7 +849,7 @@ static int comp_irq_request_pci(struct mlx5_core_dev *dev, u16 vecidx)
>  	int cpu;
>  
>  	rmap = mlx5_eq_table_get_pci_rmap(dev);
> -	cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vecidx);
> +	cpu = cpumask_local_spread(vecidx, dev->priv.numa_node);
>  	irq = mlx5_irq_request_vector(dev, cpu, vecidx, &rmap);
>  	if (IS_ERR(irq))
>  		return PTR_ERR(irq);
> @@ -1125,7 +1101,7 @@ int mlx5_comp_vector_get_cpu(struct mlx5_core_dev *dev, int vector)
>  	if (mask)
>  		cpu = cpumask_first(mask);
>  	else
> -		cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vector);
> +		cpu = cpumask_local_spread(vector, dev->priv.numa_node);
>  
>  	return cpu;
>  }
