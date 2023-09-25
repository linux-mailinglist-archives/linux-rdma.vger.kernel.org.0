Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FEC7AE1DF
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 00:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjIYWqn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 18:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjIYWqk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 18:46:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F29F120;
        Mon, 25 Sep 2023 15:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695681994; x=1727217994;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pp3MWONHyrg3bbPPx5o8PNr9gWyk96vsm6A66UBACDc=;
  b=ApeX3GDcMyqTBFY0YCFzhfnR7z43+YHcVjF8aJUZjQiSKVzk5pmWKS2W
   i06pdKKtStteXP375ZBT+KTV6E+zeLH9TTyVoMMvonxED7zVLFER9P4O6
   UhRHLp6CUJjw891nLubGMBHIm2tmI7mNlYF9JFNj9v9+JIsA9qySTvoUC
   yJHXvEIb3ctmPvNRrSFrkQYUQe6sYMulD6ju4al8dum2xLYIvxz7FCfoz
   ADhPHoo6mmCLmrMYirZx7D5yPAAI3WedsDss84oOVbhMhO+bzHo/oJvNr
   mYzrEirobN8YMDHTGyYJdqjId1bQBdACqRU0nYbQDyssaa1a3FwrcyeTk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412343323"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="412343323"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 15:46:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698240306"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="698240306"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 15:46:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:46:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 15:46:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 15:46:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ep3/NsrcOsDVmw/TTDHxQcTI4bui9QKOh6mFpqq/iwnuH9foiabgmgd9n8OXTfhpdYsZvnrvc09lN6XDtcz5bT9IFEb+H7MBt7LgTy7RKI3xBDOmaG0/krcTEq1Oqv6iltP6c4XpFze4JCUzwBA4Hwhjo3uEy/7vrg/Nk5lyPcI0b215CRgsxxQFHcwB06nGmQ5WoKc+GZ8OdBukDtTD8PBUV3IUUfkXbSxN4Rtw5qjLOX+hVft1pDf67Q7zpF3ElBk3DJrxsfMfb2nyPe56yYWCqziYWUoghkzgHCg6VbDUrMnobMYbHd2wyNSi1LGTi4a5DHho5dcZTLEeAvke4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RSkbxjf/9OHOUa7FKLGXxud+phaEvgd37iHZRxqTqc=;
 b=FzrgJXAHBH2WwIFVcxhBqedvXH38Py2fsSdtmLg8pmIUzUhha/o0HkSAxowM1KFWaNK+ADRBWfRkob6gDOq+BiylKfsw0Ak6wqB3psF+BtR4J9a7f14iN5hmy8DtDqTdz9TbiqFytwvXk6WajrFcnf/6xq+WEp2dH5I3ZSTE72t4aO3D88FzkKOHFga6zNXZPhdVpZVER2Phqw6w3sKoOmhiVJBBefkHqb1Lrkywp+ngciVa0Q/uw3iBhgRyFOejW6gDjseGXLZCmqSdWSB7u34CZVPH32IeYEBVN+uB5PNnspxAsu0DbRxBixR25dNke7mrHGY5YCB/vvvPncfnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 25 Sep
 2023 22:46:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Mon, 25 Sep 2023
 22:46:13 +0000
Message-ID: <49c0fa46-3787-99c5-2b8b-3da71ce33216@intel.com>
Date:   Mon, 25 Sep 2023 15:46:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] Revert "sched/topology: Introduce
 for_each_numa_hop_mask()"
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
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Yury Norov <ynorov@nvidia.com>
References: <20230925020528.777578-1-yury.norov@gmail.com>
 <20230925020528.777578-3-yury.norov@gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230925020528.777578-3-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0287.namprd04.prod.outlook.com
 (2603:10b6:303:89::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c82850c-8274-49bd-4e4b-08dbbe193848
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zfz0c5LmUytGynNxzhzsQ7kMnguePJEyi2xLM4xzLZ7Zo6ksRD2tQsP4wWmT6D+O6Naap942CeHMLR1JCCMOLX4CVbxtmfsfpRPTZKX11258Jp5mGk3w6a7/pPtww7j0QVNcrgoTAFtxEPPuGMfcwUfEBrkmGWhV2UfMcs0kbWgjp86pCeI02jJOIHoDwlxnqCG32fz5qf3w05vrzz4KD7GNExTzH35kXeFlySXvNP0hPocZjKRO0vD9rvWqcOBz/RmV7ehJJV2EMxivicjXRMPD5UWwx5puBLOkYsSkW56ZpW31gvCKQCKWPjUug9AtTPVwR8lpffVf0Waha5Grc2FsUH3ayZxCYG6a77ZKQofrf1uK0zGNa4o3qcpESewX+DVysajrTgR8llf/MT0LRnOBmq6ThEFr24uWZYa+wa7Dzlc9rqHVT2Fdw1t/I/OW6lCxjASxC5F/DdYkkgRhmoU3QfOEYQ0ume7Q9fBgFDJtGhlZTp44dKvq+n1dLJAIHKm/z8oQvb6SAbB6wTzvJQapA/hDo8MpVCzOzgjlo5OMxLxC2cdWIsY83TCaoSWqZIYIMZzboCdK51r4NlN/g6BJfLHXyNwX/EcwVkknJMpoo7H5Scp0Xo5UQjrrHBMyUoJKeaDaL769GkNtSmL8BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(26005)(478600001)(66899024)(2616005)(36756003)(83380400001)(31696002)(86362001)(82960400001)(6486002)(53546011)(5660300002)(6506007)(38100700002)(6512007)(2906002)(4326008)(8676002)(31686004)(54906003)(41300700001)(316002)(66946007)(66556008)(66476007)(7416002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUFiYTVCSVNXVk5UTmxzQ09HMkRuM1lzUmZ1dlJHNDYvSlk4Z2FDSzFWVEtH?=
 =?utf-8?B?czBaKzFvcFlsK05hRll1WGVZaTl5V3RsV0E4N1kremtxQzlEZ3ZUMEpUZm9y?=
 =?utf-8?B?YnN2aEZya0ZZTVBZWWVxYlpyR0RZUHJKRWtKTCtyaHI5UXI5c09jZmJGa1BZ?=
 =?utf-8?B?L0FlOXlDb2NQWTJSWTFkS2pXby8yY1YyOHJOWEc4UzkvRFpmUWk1NkhEeXhR?=
 =?utf-8?B?QUdBR0NNRHl4S3dvZHllWHdjVVRKU0o2Rzc2VUpvdVppZnc5T2pHczdpTjdL?=
 =?utf-8?B?NkRURFNoM242aXI3aC9WQm1BU2F5REo3WFNzQk52VHY4VGY3TkljTkVlOC9o?=
 =?utf-8?B?eG5kZVkwWHBlMXlNS25iR1QrNVVHaVRMNVc4enhERUs2cGFkTUpNb3ZNTXVT?=
 =?utf-8?B?ZVBPZ25MTlZLVnppTmErY2hHQ1MyUEJwSzlZejg0WmxPb3pmaGl0RHlDVHBE?=
 =?utf-8?B?WlB4R0FLa3daWm5vQnJjdERQOXBEK3pSallRNzh6RHhxMnBCbzZnSU5tMm53?=
 =?utf-8?B?ZWpIeWJFWGJSSE1lY1RINE84WUQyUjFoUDlZaUg0dk1iTlpIK2dmV2FoYjNT?=
 =?utf-8?B?bTRQMXc4NEh5SHYyN051V2hVVHVXNkRFQVp4QVBuVm0raVllYnlHVFRVb0Rl?=
 =?utf-8?B?N2tNd3JTdWxZSTkrU2hsNFN2Smd6NFZkWk5JVHIrSUtBbGtUc0pkMjh6cDRW?=
 =?utf-8?B?R2tVYkE4Mys5bDFMaWdCUUQ3a2c1dDY0QVRqR09Udk4xdldUZXVzWE9oRkR3?=
 =?utf-8?B?a0lJRzBKR0tOdGo1QmNaNjJLVUE0aU9EOTBWYXdqaGsyNVcvVUwvZmMxOC84?=
 =?utf-8?B?ZCs3THRQcmhUbWdyaXZoUEdFQTA5L0FLYkdFZktMWDhoTHZYRlMySU51NjRp?=
 =?utf-8?B?MloydlU1RWIrV2JxRXdDaVduRDY4NStqbVN2dFR1MndKR09ZYyswNXpnWnpG?=
 =?utf-8?B?MkdlUW8zZm9oenRPb0ZvWjJXNjJmbHNBODRlaC9yNHlpOGhMRG1Ea0JZZ1B4?=
 =?utf-8?B?RkUyRTNDeTFiUGljR1JrZDVYNlQwK0JSenRkYW02R0NkUGVvYmZzcVNGdzVr?=
 =?utf-8?B?OFZ3Yi90NU9ReW1RY1VjRldZbVpBVHMyNTlSQ0JGRjRkTy9Yc3JJOGx5dkRD?=
 =?utf-8?B?YkpJWC9LVUlPMGdCNmZ2YlJLelQ0M0E0a3YzbEtnLzk5bGpRRkpTb2cyMlpL?=
 =?utf-8?B?THlPS1hUeVg0QWNqd2lHQWp1bzF4cGkrYUg0NytmNHA3Z3orWVZZTm1WOEFo?=
 =?utf-8?B?WnlGRVBwMWtMdStQRm1jclA0REhodHFBL1RmLzA2VjkxY2JMRm05aEVFT2FP?=
 =?utf-8?B?c3Y2VTkybmthbzVlaFM5MlJMNHoyUkxnVnFQY3dJaEpCLzFRK3IzRWJ6NERi?=
 =?utf-8?B?TkNUTmRlV1VLOE1OdElLeFB2cmtkOS9uY20zQzRPK3AwcWxKRDY0dmVRNWE0?=
 =?utf-8?B?b0ZEV3NGZjZya3l5M21zUllrd1lBazh5NFRMcTlhZldBWlZzM3ZkcXVmQis2?=
 =?utf-8?B?YnRER2tJbVl6YStSQ2hLeC9kVC90b2tMcFNRalQ4VUZrRXhRQ09TUFkyUUVL?=
 =?utf-8?B?ZGNQd2ZobklpSVhnQzNWZ2VJVUZCVGd3SHdWL2Z3dHdJbnFlL1VlNDBseWNa?=
 =?utf-8?B?VmhsbUJEbHRocjlTZVpaVXprbXFZb21WVml4UklUWlUzbFlGSG9JakQvaW5Z?=
 =?utf-8?B?K3VabXRDUGR3QkZrVGhueE90MjFVWERsbHFZeU1JOVJYQkQ1SlptMVJhVnhj?=
 =?utf-8?B?ZWloOWFnWUhHQU5ta1JjMjBLcWhlc0V1V0N1Rm5uWFVjZFN2S1ZVTEp1VUlI?=
 =?utf-8?B?WUpOdDVPaEV2ZmRxWEQ5d3dFbFRRNzUxSVY0QTBKblNoeU9nc2hhRE9aMjdE?=
 =?utf-8?B?akNOK1VEZGlBVDduSFV6TFUzYkRpTmc2VjU0V0xYVXFYcmhHUTJHYUxXMDZZ?=
 =?utf-8?B?R1dTMnAwa1hIRmlQbkhobnNhYW5IbHJ1OTFqUk5xeUQ0Vm55YU81eGcxd2Jw?=
 =?utf-8?B?M3VuNGN4SElCdk9mNnZrbm5STktTVWdSV2ZVRWZWN0RlcSt6RVBCTzU2azJw?=
 =?utf-8?B?OXVQUmd6Q0dPVXErTFBOQzB3VXRkZ0o4QVRTbGY1UEt5b1NYTHRGZ015NGZQ?=
 =?utf-8?B?YllGVEtMek8wZjFLWDhuT0RwZzBrWmRsSTIzcE0vZVY2OFNTRFJsaUt1UVhj?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c82850c-8274-49bd-4e4b-08dbbe193848
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 22:46:13.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSP+K+s9uYiS8S4fpnU55GtR/qI2OuvR1VdcgTeb1yu8gtIAdAWKtirY+2nI1HP49GeRbCMasNCkzMf4KcZ2xVuc1cV9ByCwm/+6QW1zP8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/24/2023 7:05 PM, Yury Norov wrote:
> Now that the only user of for_each_numa_hop_mask() is switched to using
> cpumask_local_spread(), for_each_numa_hop_mask() is a dead code. Thus,
> revert commit 06ac01721f7d ("sched/topology: Introduce
> for_each_numa_hop_mask()").
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  include/linux/topology.h | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index fea32377f7c7..344c2362755a 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -261,22 +261,4 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
>  }
>  #endif	/* CONFIG_NUMA */
>  

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

I might have squashed all of 2 through 4 into a single patch but not a
big deal.

> -/**
> - * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
> - *                          from a given node.
> - * @mask: the iteration variable.
> - * @node: the NUMA node to start the search from.
> - *
> - * Requires rcu_lock to be held.
> - *
> - * Yields cpu_online_mask for @node == NUMA_NO_NODE.
> - */
> -#define for_each_numa_hop_mask(mask, node)				       \
> -	for (unsigned int __hops = 0;					       \
> -	     mask = (node != NUMA_NO_NODE || __hops) ?			       \
> -		     sched_numa_hop_mask(node, __hops) :		       \
> -		     cpu_online_mask,					       \
> -	     !IS_ERR_OR_NULL(mask);					       \
> -	     __hops++)
> -
>  #endif /* _LINUX_TOPOLOGY_H */
