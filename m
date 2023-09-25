Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1407AE1DC
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 00:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjIYWqk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 18:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIYWqj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 18:46:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE78109;
        Mon, 25 Sep 2023 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695681992; x=1727217992;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1jobufczIAk8ekLaRO8jUd2PWK6TvzQyyfyvf40WYyM=;
  b=kWXygZKCi42LATB1Ye5jeQnYRQWdSDy71KG9mzhFqxjELkip6ryHgRMt
   OmiBIHkvZOxpl+SXXYKl0ePqGp/rbDPQePcmuHP3Q3iJU/PaQFUeTljgi
   JnQKddxLGXCIR4efQX1g7/YQ2nTR3bNBHMl7s5E8SYEgVYd35vGAM88Bo
   2OAEBVy3/ud47+VN/bYGUUGjvlk2oR6JfhKrTpHk9AnWtYqrk4YRtzrJm
   Wo/jsdYmbxS7dUC3S3W2+hfqY3BLYGRKsFn95gL6wK6te/6x7h3FX/yW3
   fFE2rMg6ZVxmTwosZeXCTx4t8GDXglGvn5AkBDfVFf0ql5cJS9H0Twuqh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380292676"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="380292676"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 15:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995579737"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="995579737"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 15:46:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:46:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:46:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 15:46:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 15:46:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtE3EYVjuGotVgxCdjF/E7nrvq++/ruHZCqnuq1IFrTjDEP+VB8xsQibv2O3YUjDc1uL7qkA+/darVP0SkuRdWXP4WynySlDwViRnMdttxdj/UartR3vSmsGwMA1v/l9H7hZbCASZaiq/RbWW8vd0zqOKZI4flT6ppMYCVGvix0ftLSASExcNKuQ+4hT1hZ2dw7Dp1W99Vn42ugAOT7nMcdybup5XHQvn0fzu9jDfs0gPl2D4IRa6odaMGqLV4H6+LhXnXrup/U78VOnBLOtUCpvNxLvthvR48speWArDuAW/KbLknINAQUIW8jDq4HA6/nwDhprcCPFNBC5Y13Ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkJglissnvi7mfa63T+ejdmrFtwXSOo5Oh3EolTIELc=;
 b=Zt6plhsKV2Cds1MzqAQz4kK1djfyQ7wJCCyvcwYFHeKL2LeY2ZK9+Z1FuljjH0HqsALDYaLCm3vBKSLtDb50ZXagMXgeueQRa2sroP150yoVGFWAb21p/CVqVQNO1cO9bAMnFpPlHgV/+b13fBGAG/S9cKQgk9KNNVQtvVt7fwTkxL/EQqJGCGqALQ1HJEwYIwGM9RxOBiO2uJ+wu5TOJ8wNOpFX0az547pCq2rx74QWfpdf2XGLhbwc3Cdr1gaktOZUpmemv2W4+tlOIM7uGCfBRarLJ6izJa4V389DCQC1nbX7MA9MlCxv5RHjQfDmo1jnaAjr/OxXiuqBzF6nFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 25 Sep
 2023 22:46:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Mon, 25 Sep 2023
 22:46:28 +0000
Message-ID: <e9f8466e-d138-3cc6-11c6-2d62f4c9dc4a@intel.com>
Date:   Mon, 25 Sep 2023 15:46:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] Revert "sched/topology: Introduce
 sched_numa_hop_mask()"
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
 <20230925020528.777578-4-yury.norov@gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230925020528.777578-4-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:303:dc::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 18eb968f-b105-4135-d87c-08dbbe19413f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOHx6Xlrcy877+0f8FcqxFIFq6aEZoN15Qs7DYGSSYZ8oJv1u+GJ7repAoigc3B8O0fRtw7z8I4GJwucRqgqTWFduf/ki3aasCl9C3szaGEeOfT14s4JbuUeXenZgPEoIxRsM/4k96SHr2BdE/sLCTRF4dGEsbDG/yzPu+2CNbC0QqUQffMydzNyXQVGlI9tfjOC3CVp/PYDdxNSrr5cS62dsgQe94o77YcS/zgbkgBHRGB8aFwyjG4+8gMIghcRmVZOyCFonqbQSP23BPCeMZ+TxE9uSnQ8groCpljxBrFwp0EPEH5OFdNzzMMOq4nzjWQtx2+moykCRk552Qb5+MCP8DDlrDlHKaQ+ur6EsEwFj8XQFQ4X07naavRu5LvGsaukTXMFUdMxWkF+AizrTGBLR08rxlWzzYo6JoBfl5tMXU63A0yvPWnpZM1SunfT4M3T6zmPAfvMp+LE7vZnTqSV45brurVfTaX57949705MtrMiTfdisRkmTuexrN8WJaqu5aikAjSRaws65ABqfp4IvYbLbVbiofCsf37l//+/i9JoslMrh9zRQjGcrhKyJZaBnZZkxYo2aKx7QRmzh9TUgBmp6dgXReqw1tli6B9hAI0yHqzC3YXimZT7dvSrmIC7oMwEnXsUCoqTyB+j0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(26005)(6666004)(478600001)(2616005)(36756003)(83380400001)(31696002)(86362001)(82960400001)(6486002)(53546011)(5660300002)(6506007)(38100700002)(6512007)(2906002)(4326008)(8676002)(31686004)(54906003)(41300700001)(316002)(66946007)(66556008)(66476007)(7416002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdOcWJNUUE1WFRDT0xRWnpaWFZQRXpTRzhUd2tGamNNeFZpVXBZRTdzQzhJ?=
 =?utf-8?B?R0hGNXpkMnpzcldjUkt6L29JcElsUW9PUmdzWmRDakNtb093R0hsdGFTWXoz?=
 =?utf-8?B?RUV5bkM5OG8xL3JReXpNT2k2eWdpYUYvS3NWcXhmTnE1TEprcTlXTEpnL28y?=
 =?utf-8?B?bWhoR2ZyOGRoSkd3QndUQVlyenhIaW9Fa1RId3B1aUNKdUVWQzhrSElxbWZo?=
 =?utf-8?B?eUp6WGdueEZtKzFqY2F1Q2VlYm9PZWdSd0l4M2NoTGw0c05vTzg3eXo4dWRT?=
 =?utf-8?B?aHdaOW9CcDk4Ym1hd1F3cElRTU5BbWhLUzV1aS9wY0pFQ2dWSWk5UjRoTkcz?=
 =?utf-8?B?RlBGTU51UEsrTFVuNktRYVF3K0tNVks1K2hFYnhmMmdyQmdsQS9mYkU0RzZG?=
 =?utf-8?B?VWhubk8xTU5iRDBUc2tzV1M4bFBnNXVab09hWFNocWRVQ1hwK0E3N3cwb3hC?=
 =?utf-8?B?RnpFT3NIak9ZS2w0QXltRytUQ0lsSHppSjRrNFNaQU02S21QdTYxWTRHU1JQ?=
 =?utf-8?B?SE8zTTh4ZkhJS0MrUWJVMzhETjc5VHVFRTMySzBRR2VDUDVvd0xPcDR6Yk42?=
 =?utf-8?B?d040ZkxacGZVMXZ5Y2pJWHlvRytWMnNsdHMyVlU0M2t5aDVOOXFLYloxNTli?=
 =?utf-8?B?dTdTdzNaTDJGakZSYXpyVHArVWVTd1A4cGJkNFN5dkxmL1dXMWpON1Z4Rzlr?=
 =?utf-8?B?MzgvaVBrbnhWSmsybklZb1lVVWRORWtJdEhKL0Q5TzVXaHE2bFhvQVFmUERs?=
 =?utf-8?B?dElkcXdJT0pBNlhkeHN4bUx3Yzh2cUJCTmZWQ2gxeUZxVXBhdzdvTWdSNElq?=
 =?utf-8?B?RWlLSVA2QTlSQ1ZhblZpV2lzMy9uZC9laXExT09xOEpQTmJUTlNMeUVmaWlX?=
 =?utf-8?B?RTNoWFFWd2tZM2t6SGdPYmdMQUtaZkF3SFJ0anZlMmhnOXN5WCtUcFNnaUt4?=
 =?utf-8?B?a0Ntb3BENUFueHhpK3Z1a2p4SEljMWtJenNUcWRzRmpZbnY4a2xLWm1zYjFB?=
 =?utf-8?B?cWVJVjJlU1JXS0FpNEFLUFY3ODBLREtmcWFFQnZsZmkySlFVaGwvTSt6MmJu?=
 =?utf-8?B?QTR3TjRUNFFLOTlkMm0vMGpHNU50ZUNrays5dldYSlZvQlhaKzBEK2hYSjhw?=
 =?utf-8?B?ajBUVHBEb3IzaDdVM09wSVFnWE82aXdkQmFEN1BxbHZmMFg2WDJSUm11WUg3?=
 =?utf-8?B?Ry9DajhOeW9PVCtLaHZRbGQxbFYvb2w0S2trNHpMck91dnJINnN5anQ5SnNC?=
 =?utf-8?B?aWtBam5jVWNyOWJJOVhqOStPekdlUUNFU21FNmJRbWlYV2QwK1ZqNllTa21l?=
 =?utf-8?B?Y3ptcDQyaVJXTlRYNXhjSU85NUlmVEgzYkluL2Q1K3dMTDdpZXAzZFRFN3hT?=
 =?utf-8?B?djdaWWhwVXdIWTJ3SUlaZHQydVpSTVRiMFhjSkNWM2QvMHk4eXJZMi9WWmE4?=
 =?utf-8?B?ZTRXVEFQM3lVbnUweXBqQTY5N1JRMDE1NGJHYjNLT0pxSk9vQkl3STJOODcw?=
 =?utf-8?B?eEFYWUdHOEtFRnpDVjhuWkJ6UEI0ZGJKWHkyVnpnWVFwTnpteWxXVmNEWFU2?=
 =?utf-8?B?NVVtYlJyY1BoOVFXblYyTGxQbGpZRlV1aktRMEdpQ3FOL2pDTEt6bjhrSzMz?=
 =?utf-8?B?V1EwUndSbTQxNXA5UHdOOW5zaHRyUFNYdXJhaEVVSVNNV3FwWHZ3RTloZkV1?=
 =?utf-8?B?NnViRXgxQ1hBekpITlg2bnFOOVdmVlVkZE9ZM1FyWVBObkFrTkFTUFNGV0pt?=
 =?utf-8?B?SDJsM2VRMGZYVDlZQWJjSVphd0hsdzZiUHJVVE5WWUpySXVFZm1PLytvbmRC?=
 =?utf-8?B?R1VIYWo2MmUrOTE1TGlPcWZYaHZhQWtCdVZqT2xSakdhSHgvNWRyMFIvYXRx?=
 =?utf-8?B?Nmc0WmZoZXE4dWdmRFdzazRpVHEvTU1iZTcwSm42TEEza2xJM1ZrTXoyd2FE?=
 =?utf-8?B?ZHhNWm9ieURteUFuaVZaKzlDa2NGdTRlTTVwTWZteEFwR29ZMkJHb3F3Mm81?=
 =?utf-8?B?RGhwbmFjTXFncGxXOGNqanduWlJ0WEdXSCtzeExaNCs2V2R4UFJEWVJLRUV6?=
 =?utf-8?B?Rjc4dnFuZ0gycEd4bFJyMUZOOG1YNHYyZWR3Z1haeGt3enpQVnAyT1luUWRR?=
 =?utf-8?B?UGZ6V2gxK2MvaDA1VlNPU21Xd2tWTjg1NHdYSmdlK25PVldpVkpSVWZ1UTkv?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18eb968f-b105-4135-d87c-08dbbe19413f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 22:46:28.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9NBLLZtdJI0zNiCKvsoHcatpMrYGVRzEXRZMsGwU4FLMNRHW1c/87HP5Av47SGoVtj9czQHkRHcird3Wm/6Rkc3LCj5C9q9Zoh1CpzAN0Y=
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
> This reverts commit 9feae65845f7b16376716fe70b7d4b9bf8721848.
> 
> Now that for_each_numa_hop_mask() is reverted, revert underlying
> machinery.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  include/linux/topology.h |  7 -------
>  kernel/sched/topology.c  | 33 ---------------------------------
>  2 files changed, 40 deletions(-)
> 


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 344c2362755a..72f264575698 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -247,18 +247,11 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
>  
>  #ifdef CONFIG_NUMA
>  int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node);
> -extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops);
>  #else
>  static __always_inline int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
>  {
>  	return cpumask_nth(cpu, cpus);
>  }
> -
> -static inline const struct cpumask *
> -sched_numa_hop_mask(unsigned int node, unsigned int hops)
> -{
> -	return ERR_PTR(-EOPNOTSUPP);
> -}
>  #endif	/* CONFIG_NUMA */
>  
>  #endif /* _LINUX_TOPOLOGY_H */
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 05a5bc678c08..3f1c09a9ef6d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2143,39 +2143,6 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(sched_numa_find_nth_cpu);
> -
> -/**
> - * sched_numa_hop_mask() - Get the cpumask of CPUs at most @hops hops away from
> - *                         @node
> - * @node: The node to count hops from.
> - * @hops: Include CPUs up to that many hops away. 0 means local node.
> - *
> - * Return: On success, a pointer to a cpumask of CPUs at most @hops away from
> - * @node, an error value otherwise.
> - *
> - * Requires rcu_lock to be held. Returned cpumask is only valid within that
> - * read-side section, copy it if required beyond that.
> - *
> - * Note that not all hops are equal in distance; see sched_init_numa() for how
> - * distances and masks are handled.
> - * Also note that this is a reflection of sched_domains_numa_masks, which may change
> - * during the lifetime of the system (offline nodes are taken out of the masks).
> - */
> -const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops)
> -{
> -	struct cpumask ***masks;
> -
> -	if (node >= nr_node_ids || hops >= sched_domains_numa_levels)
> -		return ERR_PTR(-EINVAL);
> -
> -	masks = rcu_dereference(sched_domains_numa_masks);
> -	if (!masks)
> -		return ERR_PTR(-EBUSY);
> -
> -	return masks[hops][node];
> -}
> -EXPORT_SYMBOL_GPL(sched_numa_hop_mask);
> -
>  #endif /* CONFIG_NUMA */
>  
>  static int __sdt_alloc(const struct cpumask *cpu_map)
