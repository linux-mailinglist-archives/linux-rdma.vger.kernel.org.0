Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2569874EC20
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 13:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGKLAG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 07:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGKLAE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 07:00:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD23E7A;
        Tue, 11 Jul 2023 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689073200; x=1720609200;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zrf4wGUY+TX7RuWiaKM1OTz3SrtH/rb07mwJz1qMlTA=;
  b=XLbFJHjEFWcQPd6HqHqugjfonwsJ2ZVksnc2Syqz5PXIZtQyogYcYziN
   tUGDRayGfAJYODc0A7o0QZv1I9KerhhWvd3gKROnuY1iR9FCyy3w28Wwb
   KfabhwDUtjA6vX0zXPk2IopDzBXauuET/RNN4IMMDEFBi6xyek98UmmX5
   l1CmX6lgY+xpHglgd1rR3qCFvgpjKz0QJYBKlIiCfDOl3Or5idzp3ZWgE
   eY1kdIShPdPZS+Ivy0gOV0COK8JJqT+Pr3s/3hi7uxnI0XO/Wt9uCazbs
   F6WSeROVKJDzQIFkjO2C+0CRU77tm6EEmZ4JNAy3zSnlKlFfO/kK6PujV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="395372850"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="395372850"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 03:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="865704420"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="865704420"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2023 03:59:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 03:59:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 03:59:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 03:59:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkD4wKsOxsz6ap2iT9wKDfX66IGQ96ws3wOK4B0jWuED/xnhFX+cNYZJNzMQsAyjuPupXSWINCuC3RL5MwUTwyNua+G6sPNdstfwzPxhOYV1pzR6A2qVmYs0AfK9/LJK4gSQXF0eyXtqnys47K4vt4lqad9LgW0ixy/WNTKrupldIKi/etRVx3BnnqVRajVqvfOYpYgBqbqP8EMTHXlN+OydY1CjWQm+EdorFe5++GwEQCMvVcWynjyrJJOduPAPwO7qjPOQk0duEZf0sLQepMeAtWXXUZ8FhwC0VkdmWV3u0vOZEX0LKKNehJWXJZzxdF2euAL27Iq9HksgMJsEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00l4dlnTGe7pJbJ4rGWoKimkMaj0r5H/emGFICjo0oY=;
 b=B9UxfSnbMUINNW+3mhyTpIwdBVCynmtaAsQkU/tCJAiuGUyHTIpn+UtqsVJxNsrU5Gqj/bS0yCtFNrIku9HFK92VPFrp292G8TomHEXPfdgewDBE2ZoacTBgNOmIv4CbKSa6uZeN6jG4ahFfj06iKV0DrKFaqEVPrh2HaFH1pRB9/134eEhPpI63zTj/zpA7+p70Z8XmHDX+no3jji6lGDPWAPuFzYxd4gmZvqUdYc/IBXyeCORNnrJP8VCq3q4Re4sOgIRwOCkiHsXwc2PuQrEpPMWNFF9zI9llz3kZhtlk/p6/l8pglkhzewOnSvaarTTu1kjF6jKexXMB/nfT7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA2PR11MB5050.namprd11.prod.outlook.com (2603:10b6:806:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 10:59:55 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 10:59:55 +0000
Message-ID: <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
Date:   Tue, 11 Jul 2023 12:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Yunsheng Lin <yunshenglin0825@gmail.com>
CC:     Yunsheng Lin <linyunsheng@huawei.com>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <20230629120226.14854-2-linyunsheng@huawei.com>
 <20230707170157.12727e44@kernel.org>
 <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
 <20230710113841.482cbeac@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230710113841.482cbeac@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA2PR11MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ababa3-5d0c-416c-b8ee-08db81fdf590
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vzs0AUamAV42QZGUgclm11jpviUp5IoWu3eDZ3cg0Wzmhx+WA/REALROHkG9uEA60oCoSGcC7e5LvXBiE+wWEi+64CQS9QuAcMY59Xgd7IDUcNi5TGUGre/DNr9/QkO/Bn+onpRTDQk2Lz0691zP0bU6PPVdodrwIKabQ7VU0sD/QwLFE5vsf6+3pNXljysepIYH2ebhE2SZ0UbQ0NPSiv9HgoUWaSbCOkeR7tvGz9s07/ltBfgTZqLKls/QsGedJWS1rzOvr2pQ87ZvLYrllx79kL6RUcZzkyaW3w9g0QCy4N8JNjfLmeC9td3ru48fBnNVj3u1VTutvM8xppcgZmtRFZdq7mHduC+KA1OvSydDwKwgLxM7ItWtASjcA2KAUe+9EYK5i5OYzPmOGYD+Swv3sU6pIb7SyPSU4/oArqHtHSfvK6b+yj/daWeGGt4uv5E/DIqNvtLwhIBBP7IbvcN4unAl/gkS3uhjCz6f1fIR02279+q/EeAF5U0pWA+I8TB7o6cfUmiwpP1DqQNIaJ/hddubkyr4b3jPcFI0etuOR2nc7f5hbSFw1NfvQ+jJTkiIbbCXDiqn87WX91+kzZQKW1FCYN3Q3MIbLSKzonu0FN4WSIq4KAeuc/5BrFg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(86362001)(38100700002)(31696002)(82960400001)(31686004)(36756003)(6666004)(6486002)(54906003)(110136005)(6506007)(26005)(186003)(966005)(6512007)(2616005)(7416002)(5660300002)(66556008)(2906002)(316002)(66946007)(8936002)(66476007)(8676002)(4326008)(478600001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVZrQ1lCQU1sTWc2WHlXeHZIUHExVStCWnJFcUUyWEV3UGhtdUQ3bnNFbi9n?=
 =?utf-8?B?clo0UmxUSEh6MEdsQmRKQTBwUklJSjJlMjV2UkRWTnBGL3cxaWlRNjUvdkhV?=
 =?utf-8?B?bDNzOFV5M3U2bnUzNjFibUI5Ly96TjI4Nzdrb0pKSE9Bb1FlYlEyZEFFdU9k?=
 =?utf-8?B?Q0toZlZ5TmtOWGl2VWJ1SHdPaWt1N1BITEllVGI2QkJGSzBJYllTekYxUGtq?=
 =?utf-8?B?VVhnNWhMbDdxM3JLL29TeWx6ejFadlE5eFlYemdVcmJoU3ZRclpyMERQcG13?=
 =?utf-8?B?c3lEVmlhSitjY3V4cnpiZUcxZVI0bmRFQlhweTF1amN5Qm5zSWd2K3pxUFNP?=
 =?utf-8?B?VXpzUU5EUWR5SjVwVnJhUThkelluUERIQ1hIS0ozS1VWUnVscU82TlpyTUU0?=
 =?utf-8?B?ZWxVU3FWNW5uSHdFREo4TVBONU5SdVo3cVhWN1NkTVVjdzV0Yk9wMklpQytu?=
 =?utf-8?B?ZFlrZUxob0x3d3h2cU5MUUw2TStHd3BTcmlxRHczODZBcENTZXNPUzJORFUy?=
 =?utf-8?B?NDBiTWY5WWZkazA2aUJQM3lqekhWU0tnL203WW12dzJ3dEo2MjVKWjR1T0d6?=
 =?utf-8?B?dGlSa0FSOHJYd1RrQTFaMmRmbHh0TW1IaXQycTVNY3JnSEE0R2pnbUc2Mm1Z?=
 =?utf-8?B?K2JjMWFTYnpUM2kyYkEvUEw1NzloYStaVFFvZzFaVXRkaU13NFh0QldHSnYy?=
 =?utf-8?B?dmFPNGxIRzhIN0lzMUsvazBzcjVpdkFLRGpyUUV2K0hSMzhwMkQzVnhaaTFa?=
 =?utf-8?B?T0tJRHQ3c3Q1UXFkKy9OQWkzd0trMXZESStoNzdVbnRNN0JQQWlwQy9TMmRt?=
 =?utf-8?B?bWpJTmMvUFR4SU56UWFHcGdndkgvQ1dFNDgwbzJoeXo0QUZwb0s0K0MranF6?=
 =?utf-8?B?U3BJU2tDSHk5dEQ5Q1BVb2xpQmdadThCaCtZbjBlUEJVem1VdWJiV21yZVV3?=
 =?utf-8?B?bWY1MmtOM2xROE10eHpWd05TNkFBNDVZUmJXeWV0MWxXZzIxTVh3NUF5MTMv?=
 =?utf-8?B?bzNxR2Z2OEp2VHQ3eGpJSEdzbktnQWU3OWlObjE1TzArVlBNaG15em1QUGpz?=
 =?utf-8?B?NWxBdDhJbHYra3FrQnFEMVh1QVZjRGY4UnlQUTNPeEt3S3MxTUdGK0VaRTdM?=
 =?utf-8?B?eW1XY24zM1FZRHVuVFZzZkxTRWh5anM5VXNsZmkwTUduUkN3dzkwSFVxdzJ4?=
 =?utf-8?B?QzMyaVdsTUFlaDRMbDFUNHJXUXBHenBieDJVNmsyajRUVGMyQndzT2JFWlV3?=
 =?utf-8?B?bkN4TkkvTE8zYXhHbnQ3Z0svaWhmOHhJNDJtaUFYMGtsOUhnTDNFNmxnVWpJ?=
 =?utf-8?B?M2M3T04rOWlLYUlvVVBCMjdIeXIyZnBLQ2RNN1lkUDJGQnRxYUtDbkNlK3J5?=
 =?utf-8?B?enovQndWRmNpeVBaT1Noa2tCaXVlSTFnSVkyMVorZE55TUNKUzlZYTdXUnIx?=
 =?utf-8?B?NDQ4eDBsUXJ2bDNVdWJ5ZE1PdHc2MFl5Ti9TQXRqYytYaHRkOGxGL1BYREQ0?=
 =?utf-8?B?U2FRU0JQZFRtMmo2VTE5eGFTRGMzOTJBVlVZaE9SMGd6Yk1GY2lnNHFWejhi?=
 =?utf-8?B?TmxIVTI4a1M0UlBxemdzcXltaHpBbFlzam1JMTA3RGlaQys3QUFXMlo4WEFu?=
 =?utf-8?B?MSs4bEZkQnpFVUxVdXRBc2VKMTQxdnRSd1p5Qzh0U2lTYVFxbXRmVGZzZmNR?=
 =?utf-8?B?M2YweDErRDBPM1lhaHJZVlFaSGZBbjhKT0pJYnlqZXk2ZW8xaXFldlNJMklI?=
 =?utf-8?B?YjI3d012dHJ5a3NVNWVQN3ZXZkJUM0ZzdVpaR1VtcC80cnR4blJFS29KMDF5?=
 =?utf-8?B?NmVWcWJzVHE2U0V6c3JoMktucWFEQlZTRytJT0dwYXZSWVBwRkpyUlpoWnZl?=
 =?utf-8?B?VXc4UUtkNC8ybWwrVW9hVEd2WGcvVGpMNU9FeDEwR0Vwemc5WUthQmRjYzVH?=
 =?utf-8?B?N3h0NEE5cEh4dGVhSE85UjR0TitFWWtURUQ2MVl5OVp6dVVmZ0w2ZDVOS1k1?=
 =?utf-8?B?a3ptVXZxeVhkWUFXNGYzU0xuekp2cjA4WWpHa2pDYXpiL0lmckplOVlLcTUv?=
 =?utf-8?B?V0tZeEs2dlZzZVVtMnZmRWRkQW9SS1F4enhwaVExMTFNMElGdW9Ga0lnUXVk?=
 =?utf-8?B?MC8zZGpmd0RMYi9vU21JRXJsb05TK0FMWERVajZ2dHdLMVhaUDRFNkhMS21w?=
 =?utf-8?Q?7jKKjxYonACV4zJX9uKU3io=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ababa3-5d0c-416c-b8ee-08db81fdf590
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 10:59:55.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Yg51blIIGkFrO3934JLK5X1RkxAtZTc7MgX4SCBWGHk3lysrDQmpey22QyEiNz5meJCKiNKx2PidfwMrfYTlkO05Mok5SPkCvGCfx9aQRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5050
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 10 Jul 2023 11:38:41 -0700

> On Sun, 9 Jul 2023 20:54:12 +0800 Yunsheng Lin wrote:
>>> And the include is still here, too, eh..  
>>
>> In V4, it has:
>>
>> --- a/include/net/page_pool.h
>> +++ b/include/net/page_pool.h
>> @@ -33,6 +33,7 @@ 
>>  #include <linux/mm.h> /* Needed by ptr_ring */
>>  #include <linux/ptr_ring.h>
>>  #include <linux/dma-direction.h>
>> +#include <linux/dma-mapping.h>
>>
>> As dma_get_cache_alignment() defined in dma-mapping.h is used
>> here, so we need to include dma-mapping.h.
>>
>> I though the agreement is that this patch only remove the
>> "#include <linux/dma-direction.h>" as we dma-mapping.h has included
>> dma-direction.h.
>>
>> And Alexander will work on excluding page_pool.h from skbuff.h
>> https://lore.kernel.org/all/09842498-b3ba-320d-be8d-348b85e8d525@intel.com/
>>
>> Did I miss something obvious here？ Or there is better way to do it
>> than the method discussed in the above thread?
> 
> We're adding a ton of static inline functions to what is a fairly core
> header for networking, that's what re-triggered by complaint:
> 
>  include/net/page_pool.h                       | 179 ++++++++++++++----
> 
> Maybe we should revisit the idea of creating a new header file for
> inline helpers... Olek, WDYT?

I'm fine with that, although ain't really able to work on this myself
now :s (BTW I almost finished Netlink bigints, just some more libie/IAVF
crap).
It just needs to be carefully designed, because if we want move ALL the
inlines to a new header, we may end up including 2 PP's headers in each
file. That's why I'd prefer "core/driver" separation. Let's say skbuff.c
doesn't need page_pool_create(), page_pool_alloc(), and so on, while
drivers don't need some of its internal functions.
OTOH after my patch it's included in only around 20-30 files on
allmodconfig. That is literally nothing comparing to e.g. kernel.h
(w/includes) :D

Thanks,
Olek
