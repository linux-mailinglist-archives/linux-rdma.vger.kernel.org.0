Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE2F7B3AF2
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 22:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjI2UJP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 16:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjI2UJO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 16:09:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9F1113;
        Fri, 29 Sep 2023 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696018151; x=1727554151;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9ARhcEAzTzCNvU+A5ICgXFHuKMibmNa3XO6q5pfh5bI=;
  b=WizcQr2wjKRYYxTJZJ7swZ+fvlLmTOHPBK7tD0Xv7rDr5fUL3CyoentU
   cgEJpCHlhWf4TQ0zK91kzaJJgMPO/Mx4XaUALqlsWSTSUcK2288nxdV5g
   JdP+8Vkuxo4/syJ5oUpRmF5i9aEwGHk/ZSAcoO8N9OKbTfTJ3R8OZZDMC
   VEddWPDuEih5HqirUkWrYSd0btGb1nW+LDbB1DwqxyFicHYrOeyf6IkzT
   QbPKh3Z2ysnARmkhgL/QsOvRKWkRZ+C57s2Za1c156ZV8x86BJlZkibL9
   ITgsaiV56gIVQP3xDE2g9uD//snNdy1YVkjrFaQHVcx41K1saSq3ZLD0/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="379627568"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="379627568"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 10:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="785163768"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="785163768"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 10:56:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:56:41 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:56:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 10:56:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 10:56:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ba5s6tIrStVly1oYpIPnc9+kIBDNE1F+dc3LFzqin9yy4LF4ohhMJzzEuUihFddZleAbMFO7IEgOAystBPn80zNpP9hM10tgMqVOrLXaTHnTYQw53vxIAQWTqAQHPoJTNANx1Epd6/G36FAvgnTVTcZ3sszB/WxMuP13R5tMqpCQ4F9xNTPdN6E3CkOSPgu+cRU7IkQM8Qew3VADy3L0UEVlu8VqKTtdFqH7g83FnHNGDKcqcoc/KFee53atW0ZzTDChQE7iZ8X0LFUjHBX2fVITTppfewLknscV70h/H89/kZyt0FwneTCmTjpe9IMbBIspxIkWs8T4bt9CXR8GgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXDC+6vMHys3ratcyhf1UiswP5HsdJ2NCGIsiCgUdd0=;
 b=BJjhaLPa1NsTcSOY5ikkb9J19KnD+DTKtVyZSxPztCzosgINe9oP5daUyl49TpXP02ldFvtPo0IFS9GJPc9Z2MUfJrH0ZmHsNVbVsUXURJT2TlN0mKuNrfi8qMX2NnRawovy59k8eNWnJdbKXke8vuIImbbSNXV43Lat0WduDZ5to9d5KOhxU05PDGTff3l4WidsW3Ss5yXhili5G/93s++EUPtfrOcnh1YxBrqVrnSZ9KKzaEdElHTRdU1g/xgNdGAVEiYH+O5DnQF7EeOx+bGU7oXVBjCB7W0Z1CVB2JFiAgvRGrhpfPSGGyB0Zcj0XoXMSTSE6RJ0qji0eDexHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB4984.namprd11.prod.outlook.com (2603:10b6:510:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 29 Sep
 2023 17:56:37 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 17:56:37 +0000
Message-ID: <c01f684c-8b4d-1032-5e32-d9fa910d473e@intel.com>
Date:   Fri, 29 Sep 2023 10:56:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net v2] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shay Drory <shayd@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230929-mlx5_init_fix-v2-1-51ed2094c9d8@linux.ibm.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230929-mlx5_init_fix-v2-1-51ed2094c9d8@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0238.namprd04.prod.outlook.com
 (2603:10b6:303:87::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: cc568815-c9eb-4862-7899-08dbc1156d2d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTQWOecGybZi5CGYGVAjMMgi8uXdhiSoOz5ygUeCmFQ/2agPD/Y6B1u3PDTembCLsTJyQEs8x5HUSYN/qNsJ8ns1z1HjG/K+IWv3u/xgn80WGutfSfZjsFAO4Vi8uLqVKygfa2uFLGio1oWvCr4XQ4+wTp3hHex+Zp6IYDgXtA+E3ZMTUPr4vGrAtswo/EhgTElG6z9f/eyHvaS6CLWGHH6QBV6++csRbIcYBFvyRQQNxGwv374On7SKX5SQoZvcIkBA6FgBvLybE0t2+mAkvpF5qQzcJ0w2R5w2vd4G0MQNGf1LdedEOr3YYAYbKlgv/YRerr5uRyusP7fnMYyO8Up7HhNF5vRoPJixCgKstbftNR5XAfjjeCZIZ3Tpf9ZnpW1pm6B34u/9ml7VTwX8T+8VrN7pC47eaOt5+aCuvFfRZE1mrWLv1bxvdZQFbOR6yGfq0l8rMibqqYpfp1b4VRrgHCa0ACPJuBQ5/Kxex/6bna/P8pHVhNXvbZjHIJwPV3aXWKfPGwY2+AhKDC32xv4Z5hwqvlyralnSKoH9ojXn+CagYL/KLroNf/6lUlhS24p6UZj85WCPAdfK5ZjhKpV9wTSAFvbq9aLx5+ot/+lgG0hle7MuHH8axj+BBymwsLYyP6bs44WaDEPTmFtYfcve4jwTdHeFHfUN0BLL/mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(66476007)(6486002)(82960400001)(966005)(6506007)(110136005)(31696002)(478600001)(6666004)(53546011)(316002)(66946007)(66556008)(41300700001)(31686004)(6512007)(4326008)(8676002)(2616005)(8936002)(921005)(26005)(5660300002)(7416002)(36756003)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGI0MC81UUdTMDJnRnZkMlFPMzBnM0Fkb05wRlVIaVFNUS9OVUxTblFuVmdj?=
 =?utf-8?B?SlB4alhkVks3OG5aR2NMY3FaVWFIWCsrNEtiWFVVQjRVSEg0Ujk4M01XcGp0?=
 =?utf-8?B?R2FwWTRFOExFcTZWeUNJaVMxNWpyYUlJUzgwN0Jha2w5cmZkYVpEVU1EUUJ6?=
 =?utf-8?B?aUlZSDZkK1U2VnVRWGlFMEZtUzhMc1dWcks2SmlOZ1h4Qk05ZW5sVzVtZTNN?=
 =?utf-8?B?Umc0UGJ5UDU1Uk04RUhkcnZUYXk0aktoT0ZwSzFyd0pyK1BseWtuY3pyckVR?=
 =?utf-8?B?UWVzOXAvVi81K05VTUd3d0laNHFLaEt0b2hxTDdnTEtkVDMyN3pUZXFneC8x?=
 =?utf-8?B?ODYxKytTcEIxWStYRTJkaUVIb2laU2xaTGNxWkdQZHdZbnF5cWZEVVVrSVU4?=
 =?utf-8?B?QmVYWHBuVnd0bjdTUWhSUTdzM3hhaytIUDF4eHZSVFA2dURmZXRtbHBua0lN?=
 =?utf-8?B?dTFpbzU1SUxUc3prTHZHZEI4STRCWTFlWWJFdUlsUnlqaFpIQzZTNU5pUFVy?=
 =?utf-8?B?K0tSRHJMUXZMSURIeVllV0czN0RKc2F1bjM2R3M4TW1mSGRCaDFqOVZaUE5O?=
 =?utf-8?B?Tkxyb3JrVWw5MHBnNmRFd2hKSS9JOGRldlBoQUVweUFYVXVTbStsNHozZ0Vv?=
 =?utf-8?B?TmVGZ0VVUm5LdUdiZkFsdXN5b0RCbzcyUHIvOVo2a2VONmJheGM2VnJzaWhE?=
 =?utf-8?B?YUZNd1JNYWhFaEgvMHF1SGR3MVA2TFh1eDIyUXYzeGorYXhjT0hUTFJhR2dZ?=
 =?utf-8?B?QmZxNitaVXFKOUJFOGV5WGJZS0tSWjJTL3FGZTRmTGpGVkZFSy9xK2hnOFVF?=
 =?utf-8?B?UDlob2VteHpYLzdFWFphcHVOVlRHNEE5NVF0ZEQyb2VHV0FMWHdkWmp4UmFi?=
 =?utf-8?B?QWdSVzY0cG9sczZIdEFhQklkdE84aGRZeHMzdFZYTVBHUEdMMXlkdndVSy9m?=
 =?utf-8?B?R3g3a1lULyt0MERJODRaektpSHNia0J3cTRXellid016dDhCUGhZTndyTkNX?=
 =?utf-8?B?aW9sMUp6Qk15VFFDTlBBcWI3RWxZL0FOd0RUaEVsWE5pN0lEVVY4ZjUwWnlr?=
 =?utf-8?B?MVFJd2Z6dE1WUlVPYzRCNkhtaXdUZjc3Uk5Ha2EwdUV3Z2NDSk9oQWFHTjBO?=
 =?utf-8?B?TmpjTEc4eEUrS3EyYkp1eWZaeWFndmxGM1diQ2xqYmZkSVQvMDJjSTQzRGpq?=
 =?utf-8?B?NDNKQnQ3dnVuZEloa2xUR2k0NWZlcGRNTUdwY3lSK2JRcWxqY0x4SC9KOEhw?=
 =?utf-8?B?enM4SXY3WVordmNHQmdxNkZmM2lsY3RiK3VQcG9oZ2xHTnZzdDNodmlSYkxi?=
 =?utf-8?B?YnBpL3dySU5sSlRqYSt5c09Oc1hjd2pBUnRUTEM1ZEx6RlVJTVIrQ2RQTGZn?=
 =?utf-8?B?UWxuYytSR0NpaGZUNlJ4cTBDcVVRS1AyZW90OXREUjNlOVFwTS9mSDc2NUZ1?=
 =?utf-8?B?ZytXSGh3VXdkTkhTWkk1aFQxYTFvY1lGS2kydzNORjluNWtkNG9oRDF0TDdu?=
 =?utf-8?B?VE8wZDZsaVFQSHh1VTJSR1dib3g1c2dZSGZBeDRnaGNyQnJGVU82ZDRhQU53?=
 =?utf-8?B?UDBXTnFGU1FPNXBtdDlyd2krNnZFQ3R5emUwYUhCc1JaSlVQSE1rOUhSaUFj?=
 =?utf-8?B?b3RseXg1MXVzM3dxcnhwS00rOHRmRkJ5aEkvSUFVNGVScEw5YTBma3RoQmw0?=
 =?utf-8?B?cW5EclZqdlMvVmhxUEV2ckN6TkVUMFlwaTRqVElUd1ZzbUVNKzdBOFZod2ov?=
 =?utf-8?B?OHN5RFB0cytDTTlmTnU2WnpCZHlYa250NGlyRDJ0STNmVzBXb2dKbnluRkhF?=
 =?utf-8?B?b01aMW80NVRaYkc1ZmpKMVNaRDFWa3h6WXprZ1BXVHpwR004bXZkWGR5ZENT?=
 =?utf-8?B?MUdpY3JqRE9COWVtMytmNnp6Um5vTy9NcXQvUUl0dEsvaDJLVERneWxSd2I1?=
 =?utf-8?B?ZEJXNDdwVU54NGZENmkxd3kyRjFwTG5JL1BMYmc1cExFM0x2VGFvZEMwYTNY?=
 =?utf-8?B?MjJSRmJRUUN5bzB2cTZoZmxEU1padDRRVjhTc0VxcnJacmVRWlVBZWlhVnFw?=
 =?utf-8?B?TFhvWjZLUXBzWU1hRk9qUS9Da0N3UFBnSms5TkpXY2cxREk2c1QwbTFBbkZI?=
 =?utf-8?B?Tk5RU01VSjZJWUJ2ZEttQXlXNnJNaktEaTEyWXk1RG9RTFFvQldHdlE0bjhh?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc568815-c9eb-4862-7899-08dbc1156d2d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:56:37.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZiIEdX8ekzmp4TsblluzVABZsLHWifevLAsDxBcdcNWJNzhf/gmNIhzoIMy0guDPhyDlGq+/49X7Hv0nCOzdc3dLdb6+RrIsAyHCegGxaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4984
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/29/2023 5:15 AM, Niklas Schnelle wrote:
> Since commit 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and
> reload routines") mlx5_cmd_init() is called in mlx5_mdev_init() which is
> called in probe_one() before mlx5_pci_init(). This is a problem because
> mlx5_pci_init() is where the DMA and coherent mask is set but
> mlx5_cmd_init() already does a dma_alloc_coherent(). Thus a DMA
> allocation is done during probe before the correct mask is set. This
> causes probe to fail initialization of the cmdif SW structs on s390x
> after that is converted to the common dma-iommu code. This is because on
> s390x DMA addresses below 4 GiB are reserved on current machines and
> unlike the old s390x specific DMA API implementation common code
> enforces DMA masks.
> 
> Fix this by moving set_dma_caps() out of mlx5_pci_init() and into
> probe_one() before mlx5_mdev_init(). To match the overall naming scheme
> rename it to mlx5_dma_init().
> 
> Link: https://lore.kernel.org/linux-iommu/cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com/
> Fixes: 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and reload routines")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: I ran into this while testing the linked series for converting
> s390x to use dma-iommu. The existing s390x specific DMA API
> implementation doesn't respect DMA masks and is thus not affected
> despite of course also only supporting DMA addresses above 4 GiB.
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
