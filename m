Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BDA7AE1FF
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 01:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjIYXBh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 19:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjIYXBf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 19:01:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF25A3;
        Mon, 25 Sep 2023 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695682888; x=1727218888;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BYQo5tJUcfO39S6jxWAUimxiLXFU5V5n8T8CkWXqSRY=;
  b=lmkhUaBQg8E+oZC555SblA7o96zw8LaudXr23HWqM3d7zuYNfefNRSYG
   5zqllFdDvus62BjPl0YfPWlSS1aQv91AkeKWdSqeovqSXgd4W9z7DRwjn
   LeB3/ot+EqzTlU0QMVTnUWqLKOdrwUpaXSOEsaxI9oM0reDICtOwSZvLI
   bmdRdQvl+8XdzcICBQPbo1t5X4Z11gHiNtmLTiK4gyWfgIYr06oxcZnRW
   FbAwFMerx37nUFT7AMnZk/TYzWMoD7re6UNx3MrXTH41KhEu4ggBKMr3Q
   TXK+E7ajUhbCIaVE+x/lXgUNgGWHEwTIK3Vf5GX/TGwbj8Y+txMPab03e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371764909"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="371764909"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748580351"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="748580351"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 16:01:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:01:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:01:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 16:01:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 16:01:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2aCi3qft0ywLIV2El6rCURYC4Jj9tGZlNu9L/cGNz+jOLNd/LPHf3qr7yjTO+cV5u7/pU+B1EkMOTh16dW7K0VtBafdzNYVT6WdBAwtOSPJWMLbYQs1m5DzsnUYUuvRRTQ4fcKEMfvTfbaGFMlCgek17usV0i4DJdwRBHG2cTy7TfSM09wnRG2i42x0ov+A8e3R6tajQdQ1rsKB0speMF9ZkKl7J51VpAYLgEbo3vRykfTXlUFFoJwk1RTyI2sVDBD8oRVrOhflTJgx1GF6KPz1URTfMJPb53ZT2xhQnuP221aLEEEkcVdgHvazsZ18MF7uigyUFT+YMpzApaQSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5crwO3mIPjFA6U5EH5UyBzjFFnpQZqEsrbjT4zbNXQ=;
 b=Tr3u3sE75SNBw0npKe9FHo0tRTtQDyspG6zh56PXwKz84PTpZxBUmtJvcX9I8WwyOyxX5lbmfSv8AZ+od9EpIKLhzIAtGosgkSS6lLZZb1bbdGeKSrVd7S7m/zw8StE6dTMbyB+1P9y4AH1ayLbLiTIGc2LEDFInO7Ky4NwNKcEVkmf4cVh+/QVO9fwjBsoVVrLl+AHcO+i9jpGWPAkuuvB97cLerXaK/IyWNQMOs7ldfNn7RRh9M7Q4GSHX4+FWUXXsVPv7hLxvUyU5gtXI40EXIGJIJoGqxWFvKOHyJNX64G1ZnSrZMbVKCrsc2NxZSmufQwkijdJNq095Q7NDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6240.namprd11.prod.outlook.com (2603:10b6:8:a6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Mon, 25 Sep 2023 23:01:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Mon, 25 Sep 2023
 23:01:19 +0000
Message-ID: <26fc07a6-9d8d-dd6a-9348-36d3ee5c973c@intel.com>
Date:   Mon, 25 Sep 2023 16:01:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] Revert "sched/topology: Introduce
 for_each_numa_hop_mask()"
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>,
        Tariq Toukan <ttoukan.linux@gmail.com>,
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
 <49c0fa46-3787-99c5-2b8b-3da71ce33216@intel.com>
 <CAAH8bW_Lu_wk7q6eu6evV-ejVXJZn0s3ikw=e=r_tJfYOvqg0Q@mail.gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAAH8bW_Lu_wk7q6eu6evV-ejVXJZn0s3ikw=e=r_tJfYOvqg0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:907::24)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9d8d49-2e3f-4129-5e90-08dbbe1b5456
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zPlz0cT7j9kF3DdwTh1ywkM7xTllSqASiwFobp26cS0IulNsjHRFCAi1MNO6L1MY8bp8W2lHg9j2ztWavMev515QVrfBYz04RRfdyZpoEKC+594j8AnI2enT4sTcRcRK44iCwB4rE56Y+eQXNE4Fozs6Qv7J1uzgg/zT7K89O7IVIi9AQevckN+Ug6EDPhxRSEJaJihbMkU+wSvzRvjpmtriQ5rTa3jRNbuat5uFRg+qt9Wsb/BSeGkcCcyG1WCjhlWqrnlV+UXGAp3gRNYMR8ucqQCzTBMdBKaxeq1nkW0QucBMhgUOzZBSusA+3Noyp4NQLpYgl2o5VV070XtC/kjGI7zGNu+0y5+e7ndmEK3OycHjEIdBPe0f3Qk1FRwwGJ5J4LuWGA96bM0iEFnkkTsvJJSOy/H5opwuyGQgWLe3VKMXQsasU2O7KUw3LBiFolP3pO+ZEFzvflpVNlFLRRk+BWAIum8pGC1ITDKbX/+6EJjc+T2QJf9FWR+ikCfF62VYMB+vqcJobng5HjA0e1JmV75OS4F+QyGOPW8I0rnc9dC+70To7uv7NhWyA5g6Smmhy3EtMmzI/XzxgwROBqFtKbzzWbblRS/2hSPT14Yp+ACWaiAqoNk6BOQtgkWOymzBlzm8lV20OPrkE16nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(6512007)(66899024)(6486002)(53546011)(2906002)(6506007)(2616005)(31696002)(86362001)(6666004)(36756003)(478600001)(8676002)(8936002)(4326008)(82960400001)(41300700001)(83380400001)(38100700002)(5660300002)(31686004)(316002)(26005)(54906003)(66476007)(66556008)(6916009)(66946007)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWtBNGUvSit3VWZKVm5LdVFzaXNqMVI0Rmo3NW9VdDRJd1hyS0JaTVFwbnB3?=
 =?utf-8?B?K0h5TFFiMG5HTmhsNm9lY0p2MUhrOFlHS2hCYXA5MXVMRGNQU25wQXBINFdv?=
 =?utf-8?B?N0xwdzdXayswM1JWMTU1SHN5MlhKRkpPbk1ZbCt1VjhjK1dISktvNlZQcGli?=
 =?utf-8?B?N0poNE9vY0taWHdoL2p4TzVOSHpielhFN2dGbk1PVnFHWWRUeU1GYW9ybHdq?=
 =?utf-8?B?dzgzMTRoVjdxOXg3dlh1SVUrVm5SZHJ0YlNQVnBUakJLeWdoWnBHdDFXN3VR?=
 =?utf-8?B?VmdvMndEOHVUaklTaFZiU3RFM3pqclNLNmNBR1hyQTdGc2hPUTFKR05td08v?=
 =?utf-8?B?WTR5QlFoSkxaRXJtQzdQak0xY1NEN0tPNHFVTXZQSVlrbnl1NjZCQlF3ZzRG?=
 =?utf-8?B?UTFsNHhlYlI3WG01eWpUQXJSRS9jMUsvUm9jTDA0TnU2cFJ3MitGelordDBp?=
 =?utf-8?B?MWhtS1ZvMXhaV2tVWmdXOVlGVTMycWdFc1A0eGdmNnlLVHZqYjRyclBJdjNZ?=
 =?utf-8?B?NWVMS3ZsZVJOZGJvZExOUVpXQmZoNU4vQjBKb2tTVXFsbHJscXdLdVlLQU1s?=
 =?utf-8?B?dzhIMWFIMjhNQmc4ckc0VFkwNEZYeWdnOU9LLzYydGNqY1dYdFdPOWJqYXdK?=
 =?utf-8?B?RzRNZmVIYkRoOFpBMy9FUkVUUUw0Vm9YRkpkZHQ2RlpoNlhFSkFIb2FYSWY2?=
 =?utf-8?B?SnlBV3pQSTN4d1dadUpOU0dNVnVsRVovRkptdWdDUytkZ3p1Mm9aajU0cDJi?=
 =?utf-8?B?d1lIcGlIeTFlTjI5UnZua2NNbWNvdVYwOEZ0WkRiMEMyNGplUU9SbkwxVjJY?=
 =?utf-8?B?eG5VaHlUQUpncC9FVGhDN05MN2xXUGNyeXJQdWhYNnlGdUFmY2NrWmxXV2xz?=
 =?utf-8?B?S0FoMHFzM1NnZmJjWmlXK3ZJa2FJbklkK1ArVzFWRVdyUmhkN2l2WGgrTG5a?=
 =?utf-8?B?eFQ4ZEhNMzJEemVocEFsMlpmSmpWOHJCNFhoMmJjNmd1WmdjWUk5c1pzL0Iy?=
 =?utf-8?B?SEFnNHJNV0FxK2s1NW96OVE4ZlgrZVIwNGZPNWUvOFY0Nmo5QzJmdEJJcnAy?=
 =?utf-8?B?cXluRS9QNzhFK2Qzb2M2VEVqMStCeVZEN29kdzdSRHNPNUdhZzZNUE9EMkRN?=
 =?utf-8?B?dkdpZUNMajViSVgwRHIwZUFXa3ZzeTNjWG0vWXU5OGpyZU53TzhzZUw4aVJH?=
 =?utf-8?B?WFowTEtCUjA2OXA2T0ZoSWlXMldHRDFacDMzcFFtMkh5VG9yMXNsV2loQUdi?=
 =?utf-8?B?ajlHUnlTL0Qvd3FxVFVWRjhSSFNVWEMwRFNDVURvcTg1VXlLRVc1RytscFFM?=
 =?utf-8?B?MHJWQlRER3NhdE9PMFZmUG5SNkRYdnpOT1BHQXNZakRyRVhBcU4zZlp5Q2Zw?=
 =?utf-8?B?a2plTU9tYmVZTmtvN3diSU5PLzArOTdvbThqdFh5bDFEaC9scERuOFBvblZN?=
 =?utf-8?B?VXYxQk5EOEl1Z0VLcmIzUW92TEd6aWFlRnBjdURJOVZvRE9zdExySHFFS0NP?=
 =?utf-8?B?bUJVZ3FKbjhTNWp6VUNzbzh5VkdyMnRGbHNqdHkzcHlHRHphdmZzYlhPZUVn?=
 =?utf-8?B?aWdoVHcyTllzNHdwSFU4VWd6Mnp0NzY4YTRxN24yNk5aTDYwMm1DM09ReXhY?=
 =?utf-8?B?T2c3NEZhWloyMnlQMm41VFlmUm1Zbmw1Rk1RVWhIdHhCTUJra1oweFByMVI1?=
 =?utf-8?B?a2V3NzZ2cUFnYU9LOGhaeVNXWW1KNm5HQ0dnK2ZvK3lkYVRwc3hYY1BOQUJq?=
 =?utf-8?B?Vndsa1pLMUdkSUdUZVBTOUd4djU2cE9TL2hrclpQNkZKbmV4UXQwL21VelY0?=
 =?utf-8?B?L3RKSVRIZ0NLZWtIcnhXZ0dWQUU5UG9McXFCbkUzV09wNkdZYUVhMk51eTVl?=
 =?utf-8?B?MEw4M29NencwL0s5Y3BrbDBHWVk5aG1QZ0FmOWRINnRLWTVHSS85Y1lVckRk?=
 =?utf-8?B?RnhlY25zN1FwR2hFcGVhM3o4eUxOeVZjdVRacUN0Z1BUTHlQUXhoZmpFMFJx?=
 =?utf-8?B?elJXdkJ6d3FXZzZ4cmVwNlV1dExyemJoTG1VZ2dFUnh5T0FhSUhBUEthbTBm?=
 =?utf-8?B?ZkY3QXNldjdVcFZ2eWJjZHQrVitvYk9CSXJPak5jR1FxdnhSby8xMldMOHFi?=
 =?utf-8?B?a0dZMUU2T3ZabFUzTXJUVG4vcU5HVFZ5bmFOZ1l1MC94YlgzLzF3WHZZdHIx?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9d8d49-2e3f-4129-5e90-08dbbe1b5456
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:01:19.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTetVg2zNU3QrHDTXA3CSwEQ01A2cqquhpJ0QQqhkAOwii+JxXhTpuBnu7QSmp33jSxYOG7AkdlHMeeCxvAi3dM5wbN8YgtwT6CAd3s/yw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6240
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/25/2023 3:55 PM, Yury Norov wrote:
> On Mon, Sep 25, 2023 at 3:46 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>>
>>
>> On 9/24/2023 7:05 PM, Yury Norov wrote:
>>> Now that the only user of for_each_numa_hop_mask() is switched to using
>>> cpumask_local_spread(), for_each_numa_hop_mask() is a dead code. Thus,
>>> revert commit 06ac01721f7d ("sched/topology: Introduce
>>> for_each_numa_hop_mask()").
>>>
>>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
>>> Signed-off-by: Yury Norov <ynorov@nvidia.com>
>>> ---
>>>  include/linux/topology.h | 18 ------------------
>>>  1 file changed, 18 deletions(-)
>>>
>>> diff --git a/include/linux/topology.h b/include/linux/topology.h
>>> index fea32377f7c7..344c2362755a 100644
>>> --- a/include/linux/topology.h
>>> +++ b/include/linux/topology.h
>>> @@ -261,22 +261,4 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
>>>  }
>>>  #endif       /* CONFIG_NUMA */
>>>
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>
>> I might have squashed all of 2 through 4 into a single patch but not a
>> big deal.
> 
> I just wanted to keep the changes more trackable. No objections to squash 2-4,
> whatever maintainers will feel better.
> 
> Thanks,
> Yury

I'm fine with keeping them separate.
