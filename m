Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B9B7AA571
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 01:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjIUXFm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 19:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjIUXFb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 19:05:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9783820A51;
        Thu, 21 Sep 2023 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695328949; x=1726864949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ScfhnJZXIIGO8CIiB3AtfPBNYdp0W0erA3aPtcec8Hw=;
  b=Id0Lpz18vQCP2rcOMbF/RrMyM8ZPc52PCKcAZD8MbAm47c/Rb3h2MoDW
   5CXTs92ugNXNn9mI0tlBTLIjejw8fUmg8UgcdVxXkT1c65tNQhGunqm1O
   OLQghbNzf8PDfa9JtczvgeTVolddNzGvOQLy04Twe5td3VqqXNK0CQY7o
   iH7V/M3aECu7TLkaFbqC3rWzdb4bvF/+OB7DqpebpqmHZVvXYDc5jqHXk
   K4MS2QVJWn7nmKVRCO/5VYLVx3WoIxV+HeJ/ydLIThvOScK8mlePzX0h1
   rGeXPbl79A93aFUgOG8vTC28QnvEyvfJHY67Zhb6akDTLNi2QsFcIluZS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="411591621"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="411591621"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 13:42:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="837448770"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="837448770"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 13:42:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 13:42:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 13:42:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 13:42:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLVdr8YaGIn1k/2Tpe45MwMDUqSwTgdAW7O/90oqqKo/hd8iE05Iqt9xx1b0NH1jVqEZw/Yfgq3AJTW3cK5HiKNN4DU3Q9XOePpdaLR9i3xtDbaC1+Gu9khLeTHBDG+iXT+QNq7rcOf0uAeOtsag5TpT0N+gNUvEyPoqNCJZBlAzVJPy3BFOHzft5SS6yhl7hcrY7zd3NhTbcbYEqizPaJGixJ1cO7tCJdKPTcFXqEJ9tUj8Vk5XdOE5J9V2aJggSVsD/I245zQEVehDSAe+01NZ8mh4Lw9nXn049wzVAUHpCFZbujAzzzsDxRw1mifXmfq0IxEnCveZkOMs9Fehww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAGXXhv8c5du2ehrOwM6iGjToOCBt32OLntw7QLU0co=;
 b=Ptkw2GJb7Ls2z8/JL4l0UO/h6X6EEjrU8E8JZcYHG/IEa6VOdYlGVhwb/MHImmcuQAqddpvLdmrRiUI+WY9n9mh8M5EiwAyWXvEYgSJPCYdho1m0WFC1xEYWplCuGh/ufoLrdxXgTNoGomUXTv7ofI/+vVAmyqezvymmHVtqSTvaZ4eBcE+Xcz9oGFn40wM9LcqJoPGYtAkZo7sa97vSD11M+Vmk64qFXexLTxtwum4gfAXvUt8Z6DXfhjH6++2ERO2xcFtf7PSDLo6YBMc5RVLlxJ2GP+oGJLwIow2tFaf8rjXuS7A9HScBm2kcZygRjWzA2RA8DoUssQJCt8rVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5675.namprd11.prod.outlook.com (2603:10b6:510:d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 20:42:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 20:42:18 +0000
Message-ID: <5e81e781-8220-9fc6-0f36-15c8bbbfac04@intel.com>
Date:   Thu, 21 Sep 2023 13:42:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH rdma-next 0/6] Add 800Gb (XDR) speed support
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markzhang@nvidia.com>, <netdev@vger.kernel.org>,
        Or Har-Toov <ohartoov@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
References: <cover.1695204156.git.leon@kernel.org>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <cover.1695204156.git.leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:303:2b::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c15cdd-bbd4-40f9-aa7e-08dbbae33f0e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2rcTmZyk7TnBjZUZT1AMnodhfuFQsEIf8eyNql+IjZPvsrVMYNdQlq8Y/koSyQbGDqfj/ejjCyEzode2BZahfCHr8kymMA4chJ04cZlzI4KF6E8AmYR09yoRA9Au1k7CHgfv1eoAtC81lRGNlvvuV+AagjUZ5q0tpVITjWtSMlFWYsLLwb7jUaFW2uBKUmrGlHxCPKj55k9L5TEK/MRBtZaeDukH/GFNmtYFADOh5ZJ5w4d7Z1UPzeG2amN+u9YFOs1ptU+4jSdt7rRqKrDefea0DSRC7HRpDTLKojCnI1enCp0aMlW/MHUYBeOHSc8+Iu8xx9lsx55FIR6lUwRwdwXJ/uwhTzGvJ09ohmrpHiFiF3nPWDfVvmBGtbP0MWYm9yICR14jPGS4W6U8B6LdAW8m28V5rlXgtLYxjK9xZGfVnIIdOGsbvEsCcyQEWH1ZdCktK5DpSFLwI6oBEkeeqs8MXWkLCAMsBJk6XntQjbas8kBxsqisCgm3f9WuLrrxO+jMdqkuWe/h4Ao7L/nwOhP/mlAh5K/dT7GWwXfLZicYLPMjTX8FJOTnE8RXyN6v040Rwya+kHM+5ethyVMmuZ6gms9w37IG8SjCjh146gADF7nss+YPYPdhPTCDeR5HEX6S+a9qNA55jIwOmQBCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(186009)(1800799009)(451199024)(7416002)(6486002)(6666004)(53546011)(6506007)(5660300002)(83380400001)(8676002)(8936002)(66946007)(6512007)(478600001)(2906002)(54906003)(110136005)(66556008)(41300700001)(66476007)(316002)(26005)(4326008)(31696002)(86362001)(2616005)(36756003)(82960400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WSsyaXFUc2JMY1MvMXVhVTdrR2tXSnFSbWRrcDdaZUpQK0ErTXNrZnJTRUsz?=
 =?utf-8?B?eko4VUJvMXhQYVVNQjY3Q2YzcjF6VEtETGM4eldGQWhyVWMwVlN5aUVGWU5q?=
 =?utf-8?B?L29DQzB6ZTN4ZHBKY0xvaGVZOVhob2hOd2dwZlBNSEV5QjVadHJha1Jra1dP?=
 =?utf-8?B?dFpVWVMzZ0hpd2RENUVGajRqbDZPMit6dkhoK0xwOFp2UytnZHcyc2RGNjY2?=
 =?utf-8?B?STNMVmVsQ1d0QmtudE15N1F3TjM2NTlYT2ovNWtBMDhweDlsOTNHNFo1TC9V?=
 =?utf-8?B?cnl6cHZNSHkxSnkra1dldFlGSXFnZGZGVStzRVliVmt5SnFSVXFQd0pPOVIw?=
 =?utf-8?B?Q25WdE56eUR2bVdLVWdFdHBKYUNBL1Rya0NnOE8zRkJDTEpvQzRYMU5WejQv?=
 =?utf-8?B?MFpWR1RRdndmMnJVMWtRd1hpZ0FiOHd1eFNscm1kd29UNEtnaGh2Z0QyQkJv?=
 =?utf-8?B?TVBMNEllRFVqcnpwMjQ5MGMwMFdMNXdVdDVianNPL3JFZytyNC9WSExsUHJw?=
 =?utf-8?B?ZFAxTWJaL0l6R05SRE4vcU9NUmtTbHZPM0sybU1IdFFPTVc1bG9IaXB4alpC?=
 =?utf-8?B?Umh6WXM2SEY0WHI1Z1NHY0Vxd09QM3dTaDlRQ1hlc21EMmh6Z1llZDIwQkYz?=
 =?utf-8?B?STFBa2xkb1k0cVkzSXN6c3JsYXNLQ2lRQlFNclZEZmpNOUZ2Q1phTUt2V2ZD?=
 =?utf-8?B?eTVLMWVQQXFpRnpnZUF1UnVoelB3aS9BY25LSzFGRWRIeDl0NytCQXY3aEdv?=
 =?utf-8?B?enRPNHdqeXQ1dENaazNxM0wwTERxS0lydFoxdG1Ecm1UK2EzNGlpRVZXTWRB?=
 =?utf-8?B?Sm5DSldFZDBQV2pJb0E5d0Zoc1dNQWxzTjYrNU11dnM0NTV4UkJZQlN0L1BB?=
 =?utf-8?B?WUxtaDR2eXZxVUxEdUJ3ZyszakdDdkxienBVUjduWWQ5c056RlM3N0l5SldD?=
 =?utf-8?B?Q0haU0JoQmVHZy8zLzBCTi9JcXJ2UTJxczN6WWZVM0hLNXNnaWhCemI4aE5n?=
 =?utf-8?B?dmdTMTZ5Z29qeHVzdE1SdnV0M0lXc2Q1b2FsaVcrWkZBU3NFWEhkZWlsNGZn?=
 =?utf-8?B?SmNqZmdRU0pQT0o4QW1pbFFRaU8xbFh5NGpYZlhCZTBXakg0cGJWWko5U3dx?=
 =?utf-8?B?ZGw0dFp1Y1NEUHFjLzhZRDg1Z2F6TytqaGFmODdsZEdRcTRIbWdsemtrUGhK?=
 =?utf-8?B?UHJRelpMaTBWYXZoWWFnVkljbXlyd09VbS9UREJkU2hXMGwrakpPWmpmZVV6?=
 =?utf-8?B?ZVZlU3JCRzI3OE11aWRTVWJYTWJ0VGRNY0xzUXVhVzUvRG1TcWhvYmd6ZnRx?=
 =?utf-8?B?cTFLS3cyQ3ZvZ25WYS9BWFRMU3RNRXg4SWtuRUJKTE0xN1JRNFRGOUE1TmNp?=
 =?utf-8?B?NmNDNlNOYWZOT3FaTGhVaGJsYnFXN1JCZ0daRTIrTGJRUDBHTWhpYjA4UGI0?=
 =?utf-8?B?OUpFV0xjM01pY2VrcGYyVDZHcVAxa0wxa21aR3FKaEF4enFPSkNwSTlKdUVm?=
 =?utf-8?B?ZmVEMVZseExzbHlRM3N6S3UyL1Zsanp2YUxFU0Q4MDF2SWIrNXllZUpsUklu?=
 =?utf-8?B?VlNOMElkMWFvQTNKT1laRjVad2Q1N0grR0NzL1hWQ2FuN1dlYlkwUEdobzZY?=
 =?utf-8?B?WFdGMFNabXNvTHpBY2wva1B0VHZLZ0hneGZBZ0EyQndhMXhJekhFcVpaT1o2?=
 =?utf-8?B?a1FLL2pJaDl6RGhObHd4OGl0S0RicEF1YmR6Tjg1eEJjekFhTzZsQ2dKMFRu?=
 =?utf-8?B?VGRBcVNybnZRQ2VzckttRXhSL2V1UE9ENEZNZGp6bnJabnVUSTB2WEp1YlBv?=
 =?utf-8?B?d2JLMUZRZnpZSURpN2l1NEI5WFpXU1N1L0xTcFlGTDNoRXhwSm9PVlQyWUpC?=
 =?utf-8?B?NnpLUGpCUEJSbVJJZDFGTVhxVi81MzR0Z25xb3BqL2V0RVFITWZ1MUN6R2NW?=
 =?utf-8?B?Y0c5bDcwaEhHOHBoUGRLd3o2eGNTZ1FMaVhaeHNvd29oRUo2cXFBdnNlMnZz?=
 =?utf-8?B?Q3d4MzhIdEFoRHc0NTBkak9BeEw1ZEUydVV5amFvTGExRGhmdkRFU2ZLZU9L?=
 =?utf-8?B?NVdxR3c0RlBXVzEvdnVaZC9Hd0x6bUJuMkJGVVZ1UlNpOHFxWEdNeXF6UGdJ?=
 =?utf-8?B?dVpmU3kyMFJKajI0Lyt1ZjIzZnJNa2xpKzAwK1EwTFRSZzV6ZWRQd1dobFp5?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c15cdd-bbd4-40f9-aa7e-08dbbae33f0e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 20:42:18.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tRhwa7kuA4eybaJHUxkr20F4kMJc1fZHUdZQj6QLqT+/4w7fB2vfD6xi+g/QSDCHmM9J2VdsGIMelkzM9hjUQ0uJ1KupRaNWnk4SNQ8Yao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5675
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/20/2023 3:07 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This series extends RDMA subsystem and mlx5_ib driver to support 800Gb
> (XDR) speed which was added to IBTA v1.7 specification.
> 
> Thanks
> 
> Or Har-Toov (2):
>   IB/core: Add support for XDR link speed
>   IB/mlx5: Expose XDR speed through MAD
> 
> Patrisious Haddad (4):
>   IB/mlx5: Add support for 800G_8X lane speed
>   IB/mlx5: Rename 400G_8X speed to comply to naming convention
>   IB/mlx5: Adjust mlx5 rate mapping to support 800Gb
>   RDMA/ipoib: Add support for XDR speed in ethtool
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/infiniband/core/sysfs.c                   |  4 ++++
>  drivers/infiniband/core/uverbs_std_types_device.c |  3 ++-
>  drivers/infiniband/core/verbs.c                   |  3 +++
>  drivers/infiniband/hw/mlx5/mad.c                  | 13 +++++++++++++
>  drivers/infiniband/hw/mlx5/main.c                 |  6 +++++-
>  drivers/infiniband/hw/mlx5/qp.c                   |  2 +-
>  drivers/infiniband/ulp/ipoib/ipoib_ethtool.c      |  2 ++
>  drivers/net/ethernet/mellanox/mlx5/core/port.c    |  3 ++-
>  include/linux/mlx5/port.h                         |  3 ++-
>  include/rdma/ib_mad.h                             |  2 ++
>  include/rdma/ib_verbs.h                           |  2 ++
>  include/uapi/rdma/ib_user_ioctl_verbs.h           |  3 ++-
>  12 files changed, 40 insertions(+), 6 deletions(-)
> 
