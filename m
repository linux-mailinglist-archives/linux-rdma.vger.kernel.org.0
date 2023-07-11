Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFDB74F64E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 19:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjGKRBM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjGKRBH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 13:01:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443631704;
        Tue, 11 Jul 2023 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689094865; x=1720630865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9S0/GbS3c/XNLGp8FUcNXxXM2r8FSvJKkCSBZE3ZVjE=;
  b=J41zEXS5Q8f4VE1qQrebXsR65664uqBh62quF1+qmUxpjnrdlFjBjUGQ
   Wrk3rMFr5gLjqLpCDMXvytsNqcUHXNRdekD9jDBexPYbTaDfUxg0vGSJa
   uOaGfg7yRmokDW7MYdCUYFD2x131KbAh0prSdVXQzf060T6kLmLjPqXuJ
   9toJJuBXbOOGHHsGWDeQhwliuIN2zCZk5ZKAxdnRN9gq80xAvp4AdaGaV
   hXrwLBaT4BxBpb7JE8icerOnq0en8ZfEY/XzUV2fdxCn8eYchJj2qOv/3
   0vfb6eY44tvqlxHjOAvse5NEXfKvgpSEjn2aDfTE4gquK7Ho+Q0D99Ma3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362142391"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="362142391"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:00:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="865787653"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="865787653"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2023 10:00:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 10:00:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 10:00:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 10:00:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 10:00:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWvi0GZM6orxeMNqSOvqjVjNuTTyjYKxFBs6OYMVsYvX8ZJYbHn6EysU2zXdCsj5XmA9odd5jHehbuh1/geRoJ0oo3BwXk4R30v3WQoQ85w3G6/dhSxTZxIwyGaFGotSIORGEGSMg6eoD52VS32hehCHbQOuFX0s2w+rBHprvfJ97PFwZBc9hZ1zeCyf+01IbB/P0kQFwLjE3TYTvLdWC78VSWhIUUF1hyk9kfEBFcbye8OJMYR5/npABFBPw66HwnpdElECGoQ3mrFFhOkKKVqoYjcXor3kRfw3+bmAWQd5Fc3EUYFU006bQxIKoPAS7ngSVILm329mOAvjt9ssYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYrhqpa2oIEupEZ54GoSe7o4ZIeH+KImUXi1i6F8fwU=;
 b=bxYi4hNc5K9P/lTDCoNUQhiNCpQ7mrQZuHHA4Uio8OEekgtq6LRZ3IlNCjmf0a1l3uYjC8yJcD8UMNzb6YR6aHmSRIbjoXo5j2zi+V7onPMnxiai4mev00qh8dO4WjZmt6nhA+vlemAPM1RGKpouBgqzJYNKlezf3MtLWzMzUldxrai0E++q3nFRc7llgU9V4wC8bY87qL9mGdsWDhxWin0QjmObsMZk/lHDtJ5hCVzMxUbvpgXgV+7cwVtNoZNtGxZcH/0YGeTnKC2cNZ9h7TFyz0c8mHBj+xNLyhSDprqB21ogpSzzSaA6SbpQP0I9d5fD6JvTEmA0QR7VTq17rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 17:00:48 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 17:00:48 +0000
Message-ID: <1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
Date:   Tue, 11 Jul 2023 18:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Yunsheng Lin <yunshenglin0825@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, <davem@davemloft.net>,
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
 <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
 <20230711093705.45454e41@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230711093705.45454e41@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CY8PR11MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 799d7b31-869e-43e1-c861-08db82305fd0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLKYzrJJJjA/SNuByG6k8pC7Y62w/8z+oFGmtJdphfVT2N2+WrH+vhtOCWsRDBD0URAWHuN2agTN2GPQOkWeg/2gvpO5lYSfWTWy2TT0tXOCVuvUlRuv6Nk6YKInAttnSKgDOfI47PNmAK8licLV8/yLPK1wS9GWe6RVM/xS9cRMk9Tlwr/vCdG5aHh4gAOovHGUPHtuB6Hd9RKWwvU6RShtmYDtmf+Xw0D5hFysAbZmieqmaoM6ArskSC+t1zmLTCNB7RkdV9BA+cPQrLhY6p5S50HbN29kFtV40URq50/SIrnZryycstb647rTkbU+A7t7KT5NpvEvmTnHXb2QQj5FPCyKndzPzssrzzUBv0W4j2UogTIPyraTCsBTFc4AEKcyGkBmZIcK6bjh8PVD6UZi/uDjXvC4e4smr4s8qfqD+pswc2baLYt/X7chpxdpUYN3KjDkmI14e0rgp4j2Xq9ey06f+/TOWmzU6C5CqD4+MmKsRgvwrNenWZr0UB9auI1gi0E7ySirOH9D8Dtx/DIhYSWHbTZoD//r8cWhffuFC/E67pav5b2H1QVjWZUqdiKK8Ju6akOUUsb3e/tFyOAkjb4HAAZkZcY3S9mey2U6XoxJmeHllHsD/4FLl+wwfN4ipOBjlw9Zj6oIjkZ6og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199021)(54906003)(38100700002)(82960400001)(41300700001)(8676002)(8936002)(316002)(26005)(86362001)(83380400001)(7416002)(6512007)(31696002)(186003)(36756003)(66946007)(66556008)(4326008)(6486002)(6916009)(66476007)(31686004)(2906002)(2616005)(6666004)(6506007)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGpzL0RzVXFRTU9NYlBqdXkyVEJzRERnRlU1UDNBK3FVVy9wMFAwcHAwQW1a?=
 =?utf-8?B?VzNrZG9GZTFnaG0zaDVUc0M1ZmlKNktxakRRK2JxMFdsdUxVQ0xSSFFUYzBD?=
 =?utf-8?B?dzF0cnVKN3RYcWEzWHBZelZjSnJSZW8yckRwSk5PSnpLTEc4T2t4RW5Rdm1W?=
 =?utf-8?B?cTErV2ZEMGw5Z0hVZFFXODh0MHprbng0NGkrdmhaU0NXWTJOREdDQ0w0Mmht?=
 =?utf-8?B?U0swWndwYTJEbUxlcVJSNzM2cHA2aER2TjZLc0FZU2NEZjhlUlprSjJzVXk2?=
 =?utf-8?B?cHB0VEhmVE1ZbDk3MGN5MXZlSlc2QXlhUG0vV2ZuTnlzN0hVeWlRUWE5WXlp?=
 =?utf-8?B?VE9MWVl2Y3hkcEQyNXRWNjFvQzNnR3hvZkpabTdJTm5UUkhxNVJlUjZHUTJ2?=
 =?utf-8?B?TnhZVDh2SHJqbGJaNGg2NzB2UWZUOExjYklYWUwzSXlDSWVlU1BTSDlQaS91?=
 =?utf-8?B?Q3VZRTljZERWSU5HeXRmZkNCL1FWMEFZbFY2UVdHWE5xcXdKODEvK1gvVmtK?=
 =?utf-8?B?MVk1UEI4ODN2WUtOdm9vb2p4WmZXTXpWVGlkd3h2akxMS2JsdVpyUlJEVTRL?=
 =?utf-8?B?M1lDb0VFUjZpNHpvaXFUbm1ydnJ4WmJjT0JjSEFZNldacVZkUElUSVlJWTFa?=
 =?utf-8?B?cDJqenRXcGFYUkVzVlVuY2toNzZMbGVzQ1RTQ283ZmlUbjk0UTFhT1FXWEFS?=
 =?utf-8?B?TUtXbnM3azJFbzlxNHBkQlFJb29sYVFyZkp0b3hBVU05b2hnOTVVMlk1ZlA2?=
 =?utf-8?B?ZTRqazJjNVBKWndtNzBmSWlRa245V0dhU3R6Z083NnZ4UTV6QTVnZjJyeVhC?=
 =?utf-8?B?eTlTWXdMRXZZWnlmbkZ1L1JIWmszQ05xU0REcmVKODdWdHp0MG9qcmRJU2lp?=
 =?utf-8?B?QSs1Q2N6dHgwMkNFL1oyRitCTEEwVEJGbXNlRkZnTnJKVU1HWEFEeXpIcFVK?=
 =?utf-8?B?ZHNHQnNWVXQyS2dIbnU5NldoUFpuMUZlMmFDMlpMb1M1Vzc0QzBncXNxM2RQ?=
 =?utf-8?B?dFpnUzN2M3NydDdvUFhWSzBFN3dCNk1zWEsvOTNFTDN4a25LTmdKMXNnMUI1?=
 =?utf-8?B?UHNpdTZ1RVBaczhLVWwwYjBRTmNYYVNlV2VVWmU5cUdQOGxSeW40MHZmR2pJ?=
 =?utf-8?B?aXNjMWZualBLYWdqUXdxMUIzMGIweFRpWThGa3Z5OGV5Mlh3RW5tMGN4Smp0?=
 =?utf-8?B?clB1akdDZVJjei9NTWh6NWdZY1RKd3hOb0s3TUhNQVVWb2RSZ3hENDIxeHll?=
 =?utf-8?B?TzVvUVphTURpT1JyUHZCcVdqcTE2cC9MQmlOanh2VEg1Y2dCNmkvVW1Bcjk5?=
 =?utf-8?B?SXg3eWw0RmswQnJ0MGVaaGlwK0lvVXBqaXlzYXNnRXNVRW5xM1ZNcng5UmMr?=
 =?utf-8?B?bHRTV0VzY0pLY0ROcnU1R1c2a3BGOHZ5ZEQwbVRCODltSmVlWkMvM0F1Vkdi?=
 =?utf-8?B?UmQwZWdRRDZXbjE1Qit4dkw2QTlsVjRqU0FQc2Y2ZmxDTWxFLytaRm1UQUdz?=
 =?utf-8?B?bTZTN2gzbUptNTRIWkU1a0dMQTVHcFdPNk9jTytvQkg2SXlPMjY2WXZkMzBl?=
 =?utf-8?B?V1grYXA2MWp4NThkU1RsMDlLN0ZZL1VTRVRLYTZiUEw1MkZWR2dBanFTVWJ5?=
 =?utf-8?B?cVdya1FpQ0lvU0RhWVhpOVo1NjV1S0VyajRXZ3luWWR4b3hubGNCeGVqVGdt?=
 =?utf-8?B?UEhiYmZnZDRjZ2U1MUdNcFE2SXExSnh6Mkd1ZXpCeVg4bTQ4R0NZbFU0Ynl5?=
 =?utf-8?B?Q2xIcmYrZjhKd3VBcUNpL0J6VkppUStBQ2ovdFVZa3pLS0M4VHBXYmV3MXZa?=
 =?utf-8?B?ZXdZREtXSlVqL0hhYmUvbU1sUllhZCszZmtjZmI2Yk1WMzlQa0dDQ2FpWkxw?=
 =?utf-8?B?ZnNqcDVOUWt0aHRNZDRNVUtiWjZvaE9pem5oNkhjUk0raXk0WlFCdXFSZjNh?=
 =?utf-8?B?eUtYUHlaSE1hWStqcFdaRmtRRzR6TUNFYUxRdHVRUXhUVnNkbkZLUEE5eSt1?=
 =?utf-8?B?TWQzaTlsYWNPTURMM3hzcG1lRWxOYVlnYkJjamxNS2o1bkprcGVxM3o5RUhs?=
 =?utf-8?B?WGxvWk9ENDh5RkNMN0lrT01MNm1IbFY1NjJROVMwSkprQzFHbVgzcmNxV29E?=
 =?utf-8?B?dUJIcEZzak9zeVV1Z0N6ZXdqZU00OTVTNTlPN1h5WTJ2dFpVUHNIMFJlOWhh?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 799d7b31-869e-43e1-c861-08db82305fd0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:00:48.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0gnaI1yIl/igMl8Hv4qTUF+AVo7Y8lMBquNFLfQP70IZKoJyocGM7TRaK+/9uBz5wXoQRpFoFgXl28tj48zZEwBAZAe5XVX7nFwbNbo9gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 11 Jul 2023 09:37:05 -0700

> On Tue, 11 Jul 2023 12:59:00 +0200 Alexander Lobakin wrote:
>> I'm fine with that, although ain't really able to work on this myself
>> now :s (BTW I almost finished Netlink bigints, just some more libie/IAVF
>> crap).
> 
> FWIW I was thinking about the bigints recently, and from ynl
> perspective I think we may want two flavors :( One which is at
> most the length of platform's long long, and another which is

(not sure we shouldn't split a separate thread off this one at this
 point :D)

`long long` or `long`? `long long` is always 64-bit unless I'm missing
something. On my 32-bit MIPS they were :D
If `long long`, what's the point then if we have %NLA_U64 and would
still have to add dumb padding attrs? :D I thought the idea was to carry
64+ bits encapsulated in 32-bit primitives.

> always a bigint. The latter will be more work for user space
> to handle, so given 99% of use cases don't need more than 64b
> we should make its life easier?
> 
>> It just needs to be carefully designed, because if we want move ALL the
>> inlines to a new header, we may end up including 2 PP's headers in each
>> file. That's why I'd prefer "core/driver" separation. Let's say skbuff.c
>> doesn't need page_pool_create(), page_pool_alloc(), and so on, while
>> drivers don't need some of its internal functions.
>> OTOH after my patch it's included in only around 20-30 files on
>> allmodconfig. That is literally nothing comparing to e.g. kernel.h
>> (w/includes) :D
> 
> Well, once you have to rebuilding 100+ files it gets pretty hard to
> clean things up ;) 
> 
> I think I described the preferred setup, previously:
> 
> $path/page_pool.h:
> 
> #include <$path/page_pool/types.h>
> #include <$path/page_pool/helpers.h>
> 
> $path/page_pool/types.h - has types
> $path/page_pool/helpers.h - has all the inlines
> 
> C sources can include $path/page_pool.h, headers should generally only
> include $path/page_pool/types.h.

Aaah okay, I did read it backwards ._. Moreover, generic stack barely
uses PP's inlines, it needs externals mostly.

Thanks,
Olek
