Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F67AE1E3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 00:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjIYWsc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 18:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjIYWsb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 18:48:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBECE;
        Mon, 25 Sep 2023 15:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695682105; x=1727218105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=geQHVYIaCJOi19xElALFuiZsszO7Ti2zrMOdNYsLc/Q=;
  b=Sv7Ece3z2z2cRUPFzhAcWP+mPmYHtks23cDNKnq1sv336mdF6bfLuinR
   PrIxbWOEUTtL7n7qRGdZHBpFGoz8C3sJX0TbIbKLBZgcgmkZiUs64XmNs
   acAsVuAPrdR5AqNUit3kx3dKGJJdsMee0AYhUr8K1MGTXtURf4cL2wBdr
   uc++5TUazBG5mD2F1/BLYJiw8+IVmHXSg4VpgZvGqogIne5eYBJqK7ASy
   cWvYE1JClisVdbLqo+sOl6HAVouanFohloqn+tsJqwF8WRUH7LtO1DJ50
   AKeeZ6wggm6qRFtw0Lo+QL4ww8LJl9p36PNvrV6PZecsGXdKfUm8subjD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412344037"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="412344037"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 15:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079450348"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="1079450348"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 15:48:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:48:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:48:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 15:48:08 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 15:48:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PomeBuI/xRFlnu3+n7L8nQpopmb65MBhSlG0sQx2rgvVTiWpvD9hZMYT6M4CyLSr1T+NjIU1qoZEMBOFTwM8DGQ94Rz/n2SGGPAJrDk+MCnurRBE2D9KvKvqYjARcuSyYQxs/tKHlj0jRoq2fxOWmvTCU5Ga9XhGSdmwZJ0S2KtWYivVZkYa9BIrLwDkeIygfgT4xlWGcXy2KiQm8W2U+Y5yeNY5L6Nt0VFqPbHR8o4Vbx2cWMWR2qmNZrHiElOVrW5WzYLM8CRTSRes5hqW74uGn11tt++yQ+c8f6Z0csZKUN+0C/Nia7ZsqbrC1w6/j7sS0w2lJ9iYn8sz7O1X8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu1wp3H0nlmLfQUL8in1AizrO8oIZwIYNl14tOeq0Ko=;
 b=K5LepO8YeK5LJrhYEi1cyibD7tcxK6uEb93NLBfTSKBteIroP4/KT/Vfbz/ojhKSi1aobQno/8jqzyp8bV4UGZdvJ9XsZyobTmHiYrO+qmp2RuoBaUWst6cj3rsoPPrhHUvpxn91ebRv/ZqgMZB7GEjzSEYVZqziqyhjfIH+P3qfskIgovrYHLT7lmTBRe/ykjwPvxsbYPsg4prrO55xxa1Hhnp9TLtWcy2//YYI1zOygq5pQiFVy5UKqcSByaTCnl+wUPqM0X6dPl34dOE5warIZHinClGGe0NZSTMtV5nC9UJ5nSpyVUTpWGTlRHvasgEGqmYlCZMxKm3gTh/L9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7289.namprd11.prod.outlook.com (2603:10b6:930:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 25 Sep
 2023 22:48:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Mon, 25 Sep 2023
 22:48:00 +0000
Message-ID: <dbfd06ab-26f3-7b32-6025-2c55e223c576@intel.com>
Date:   Mon, 25 Sep 2023 15:47:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] lib/cpumask: don't mention for_each_numa_hop_mask in
 cpumask_local_spread()"
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
 <20230925020528.777578-5-yury.norov@gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230925020528.777578-5-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:303:8d::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: a5557b75-f756-4bf4-6970-08dbbe1977fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8/iujsYFuadSNn8iAhXcHd7RkIgZz0TGKiLcQmb6UEZWyJA83z/3Pcondx+5dKy4IoL/6+t7dH2Udwg93QHXyRHwMANh/YT2JnzIQd0JDRLugQ69FSoSorhxytphaMEunpM8xzJLh0NRah9BFoU9ZwkZmu6iblQ/Cqdl73vUY+kFYCYWscBEEa++1n4uV3ixLiyN/DKGMVqrX5dLt5YnRWw+5w7TCMKsUzo6NZOxmG9fkd0l+F6871o4+pFKVJS0w3oJzeQf2ogmoEplxo/3w+qQWks8y2J3vRmbVW7OYwWKuqIIYwaoduchppcUf7wQ4ekT0CMxHbSdE9V6ft8iRUq7kvFr3mwpj+Ak/EHGIFzjghRet28ILl7PgYTCEs77a1T6GVLW9SKhLHvVPTfAvWlBbhvnUyc3LRibhZqI+dn1J7qSWeo6G1s5r58QmUcykXMwmrU266OlRX3vI6eZhIuCIaaJ3XaIb8c9nuronfiFEgrU0yXp7pZi63Eu2mM9R3qaWkLbcmzTUJGpUEMI0js5z0m1EKylGe9HyKfjnChp+rbVYisn0OhRPHSxmixOEipyg5dWFucRa+nihYAZg7E9L9+MjeULFoPrvr5pUgIEumHlhiGVqvxqdeA2K2313VdLhFc3rw80HhvcIGo7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(2616005)(83380400001)(31686004)(5660300002)(53546011)(6486002)(478600001)(6666004)(6506007)(8676002)(82960400001)(36756003)(38100700002)(2906002)(86362001)(26005)(316002)(6512007)(66556008)(8936002)(7416002)(31696002)(66946007)(4326008)(66476007)(54906003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWVMNXA3aERqaTVTZ0xkSFYyUnBsTzVHRmJDUktZb0V0VW1ucEdyMEtuYjhu?=
 =?utf-8?B?aWpsVWsxbUVONWUveFdzUmhJenpmSHAycENBYXJ2SHM5L2F6ekYxMm5nVDNi?=
 =?utf-8?B?SU5IaXErckpGdGVRK25OU2NpaEVuR2FxSU9PU25CWkI1Q3NMQXo0NU5nY2sy?=
 =?utf-8?B?aHFkTmpnSTZtWkxjaVAzT1pON1N2UzMwTzJLaVJPOE5la0lrMktJNFRmWWhu?=
 =?utf-8?B?elpPYjVtZzl2TlhZUXcwa2JvSDNoSlczZ2UzSUUzMFMyMW5odW94a1diZW5a?=
 =?utf-8?B?Ukw2QnlsbFRqUUJNS0xqQ043aFdZWVp4WVNHRTZuRDJGODQ1MEplZzFQdlkz?=
 =?utf-8?B?MFBFMDNBa1ppc2MxNVAxQnhEUTR3QU55WWhNRGdHLy9jeEFsZklORk5UTW9H?=
 =?utf-8?B?VUwvQ1JnbUhaZDkrM3gvK2pWWUZiRGF1ejR2Y050dFpET1VMNVhUZmZtYnFr?=
 =?utf-8?B?NldDNjE2VFcxK3h0aDRpb2U2alc1c1V2bWwva2xOYkFQS2ZUSEJrTjJxUUFU?=
 =?utf-8?B?NWhVa0VUbTB3YW5aVmZZTDUwcGRlTXRnZmQ0bGZkZks5QWM0Tk1UN09UUmxY?=
 =?utf-8?B?WmdUUzNtMkRIYWRYZ0loZGhkKzEwZzBKU2Y2ZU5iRXZKKzRZZHA4OUJ4VDU1?=
 =?utf-8?B?M2NncVZtQTRvU0w5eFRKNlI1WE1mbXRienRrODRlNEdQajNTQ3cySm1LWXp6?=
 =?utf-8?B?VEM2RDZjdTFNcnkwMEIxeC9ZZC96Vmw5Wk5IMUtxYllydlZYVWRSRDdRNlJE?=
 =?utf-8?B?cWdPUzZFWW5naHpUTE85MHJSdFY4bnNsak1xdjlUUlEzRjhrUk1mWG05Y2Fo?=
 =?utf-8?B?VHBIemtWSUNqaUQyekhXTDlLTEpUSzhGY2laeFNaeTAvckUxT1k1Tm5rUS9G?=
 =?utf-8?B?RVVENDB1Tk5Wc0xtTlRDOGFudG1mRXhjb2VLbzBqWm9aVTBzWnQ1aTl1d1Np?=
 =?utf-8?B?YVh3RlkzNFdtNVJaNVRMVEtZZ2Q4QVB0c3Y5Tk92S2JkcDRCQjZ0TkZaS0tT?=
 =?utf-8?B?UFVvcVRiUjRBTFpUNmNFK093Y0RNQ0xROHE1MmR4T0hmK0l4YlkzR2tBZVoy?=
 =?utf-8?B?OXQ1cWhzMjhYZzMrQ2J4QXV5NC81OEw4RkYwVWhTbVNOSkZGVGo5b1V1THlo?=
 =?utf-8?B?L281a05YdXcxQTMyQ3p1bkxZUHNWRUU1R213UTlkeDZscXBlSWsvbGNSNk9v?=
 =?utf-8?B?R09Rblk1R1ZvbXlGMno5OWV4VGNHMk16U0l0b1paOHdQalh2VmxWOTZvNXFM?=
 =?utf-8?B?QjhyaXJQQTZNM1BTQWlSWnBHYVNERHVFOC9WU2s1bE9HYjduQy80WFM2TUxK?=
 =?utf-8?B?WHhuK29pcm1KeHFpbUZCdGNMM0FwOFY1VnlWOWpadTVYS3M5VWNEUU8wak5G?=
 =?utf-8?B?ZXVQWXRRWmVtOHZITDFaNTh4RHJYSFNKSWgrR3VmRVd3emsxZVZ4d0lmeGxT?=
 =?utf-8?B?MHIwZWFjbDk1UHNjQ1VQdWR0SWNXTlZaMFFTSlBsdFo0eTczZDlNWFp4K1N4?=
 =?utf-8?B?T3duanVzN2RJcFFETUhLSUJodjMrSXUwSWlvWGdabCtuQXhjZ01JVFN5SUd3?=
 =?utf-8?B?VmRyTnREKzJCRFp3RGV3Sm1PZDE1NDJOQnhyNC8yYnprNzVTb1hCVlkyNEVL?=
 =?utf-8?B?L0JTN3dGdGpMa1FFSGFEcXhHM2NKdkFlZ1NoVXlpaTZBckYyVmpPenR1S3lt?=
 =?utf-8?B?OWtGVndOb0Q5ZDlCZ1FxTHczMVUxNU9uSE12Z2hqc2doZTErbDVZaFFvMElv?=
 =?utf-8?B?UUR1bG5vTGYwNWRUUzJReTZyUHF1T0R2YnByMU1hZFBNcURXV2tGUFgvTVR6?=
 =?utf-8?B?WHBuQlk5b3A1K1d3dTJpYzhZcWtwMmtlNStObWpoNVNjbFFXcm0xc2oyZEVo?=
 =?utf-8?B?UmpORDFyUTFXR2dpY21SdFR4c0RVOXQ5N2xvSTV6Y0ZWS0g0Vk1ZS1BaRU90?=
 =?utf-8?B?clZaQXhZU05wQXZONGRhdmlpanhCbXpianM0OTVhVm5iVzVSak1ib3BiNncx?=
 =?utf-8?B?L0JsclZYVVN4M3BhYTlUQ25xZ1BYeXdTSC9XS2VPOUw5NFB4cERseFZwSmhm?=
 =?utf-8?B?QmNkdkp6RzI0ME5GbEcxTUQ4R0p4SEU4R0JqMXdSSnJKa2VQT3FMMkRGeFlL?=
 =?utf-8?B?cTRXdEducDVETE8zbWFhaHNJZlpxd25heHdDaDhKdlAwTUhxN3Q3RkhsTGVz?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5557b75-f756-4bf4-6970-08dbbe1977fb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 22:48:00.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8cXEEoLVOw26X1PfRd0KAxXkc6+UedCQrgwVbXquBHt3OJC3S4Jmoa49BY//vQRGR9dgctynmmJ4Pe9cU9bL2HoujCGssdCtC0aSoolT3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7289
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
> Now that for_each_numa_hop_mask() is reverted, also revert reference to
> it in the comment to cpumask_local_spread().
> 
> This partially reverts commit 2ac4980c57f5 ("lib/cpumask: update comment
> for cpumask_local_spread()")
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---

Interesting to see both sign-offs here. Not sure what that implies here
since both represent you :)

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  lib/cpumask.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
> 
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index a7fd02b5ae26..d341fb71a8a9 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -117,27 +117,6 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>   *
>   * Returns online CPU according to a numa aware policy; local cpus are returned
>   * first, followed by non-local ones, then it wraps around.
> - *
> - * For those who wants to enumerate all CPUs based on their NUMA distances,
> - * i.e. call this function in a loop, like:
> - *
> - * for (i = 0; i < num_online_cpus(); i++) {
> - *	cpu = cpumask_local_spread(i, node);
> - *	do_something(cpu);
> - * }
> - *
> - * There's a better alternative based on for_each()-like iterators:
> - *
> - *	for_each_numa_hop_mask(mask, node) {
> - *		for_each_cpu_andnot(cpu, mask, prev)
> - *			do_something(cpu);
> - *		prev = mask;
> - *	}
> - *
> - * It's simpler and more verbose than above. Complexity of iterator-based
> - * enumeration is O(sched_domains_numa_levels * nr_cpu_ids), while
> - * cpumask_local_spread() when called for each cpu is
> - * O(sched_domains_numa_levels * nr_cpu_ids * log(nr_cpu_ids)).
>   */
>  unsigned int cpumask_local_spread(unsigned int i, int node)
>  {
