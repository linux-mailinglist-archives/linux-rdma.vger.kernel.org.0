Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F91772D1B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 19:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjHGRgS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 13:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHGRgQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 13:36:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4170107;
        Mon,  7 Aug 2023 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691429776; x=1722965776;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=BMMKaYktb3L7/bwl7hWEHs6tY0E8XnRmHEzdMbgqVyg=;
  b=BXQLwgXmv1lCjOtOPNwSpsFwi8PsSTIMwGgIaIzf5jxXD2Ek/ltiZyis
   7K8ZRNrsgbfQ9+ICVcsd+rsN3qdth+Yj2CcrszfHgl0rAAOOkGN5Lry80
   LrWEr9+fqOs8W6Vr7Y57rSg3GB2MrEWHRgcjZCNICRSQieY6EXFxNxsAA
   Ndwa7wLgXqz41k1P1aApJn+BoexakRqgiQEPjTANqovQK3kMGnO0+KKc6
   XzzoX3y6szZBPBRdlVJP84TWhcSNLMvW9hk3Ym9KWVS5rxrTV7njpzZjx
   hUu45VdEu8NN3/k8k9pjaa/qjcuJk51GPuYY7bU58Qwd2ngy9EMPGfv/r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360697315"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="360697315"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 10:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1061671237"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="1061671237"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2023 10:36:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 10:36:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 10:36:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 10:36:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 10:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8L1w5vM3MSJJbce6n5FnHv8BQANHdPaUR8l0H9XY9qtVKIHXb/Jma7xe0IvYXLV68lXncoSkSrVnwzrhbZgPI/ZKZcqv4MOFVUsmd8NVHLDESMIAb98UXpVWqJPmG4Sb0ZYpme9Jp6CjIN3/xCHiU74lWzsYK6vs8+2I42KrMLqHGrW4L8QJAQ0n7y8kx6ECcDr0f0p1erMhdjDzdUifsB6PH711oZ7MTWO+9En5SV2WoOJ0h1jXdTkUnQ27x18wWmO3xH29rcd585giB6FJJmPQa3GjiSnOzTmZEWSuZpzamoDL/dEVrdG9Nzyt72GfD5ljJtXOreoeBeDgVK68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGBh+jxoj49F6kSoBIn/f8G2w9KbO3I3eqKD153xoxE=;
 b=BVfm9z4uuiN6+vDub4H3jpp93ZoCTQUAMzfH9X45mhsAwsKqfpIEqjrcwUnPwwvy7MqtDbFB5zalgDQwSr+XbK5PYAHwiw8Z+4AWC+n9cP5nTMsMoGL1tRleZVehz+DcVP9hhxXDhLNWVgDGRMX+PFqHfiCPtqLm3Y8j+zFmIirrHFrCoRbxj9ecUsWU2KS/hSY19yqG0xH8706PlTFSyq8cp40/oi8/1fwN3QXU3iYgeppsKu+6dVtjFesGC8cfAl0cOlHpWeCOFVLlLz0phVsAV7L8xSaiFYj6CxmXioK1itsLEX/xwWN0/gW1I8e7gRCbJ5Ut0ZBkimgbulZn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB4970.namprd11.prod.outlook.com (2603:10b6:806:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 17:35:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::cb4c:eb85:42f6:e3ae]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::cb4c:eb85:42f6:e3ae%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 17:35:54 +0000
Message-ID: <84f63b86-6d7d-9547-d4b7-d66a44b23c30@intel.com>
Date:   Mon, 7 Aug 2023 10:35:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next 2/6] ethernet/intel: Remove unnecessary ternary
 operators
Content-Language: en-US
To:     Ruan Jinjie <ruanjinjie@huawei.com>, <sgoutham@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <jesse.brandeburg@intel.com>,
        <anthony.l.nguyen@intel.com>, <tariqt@nvidia.com>,
        <s.shtylyov@omp.ru>, <aspriel@gmail.com>,
        <franky.lin@broadcom.com>, <hante.meuleman@broadcom.com>,
        <kvalo@kernel.org>, <richardcochran@gmail.com>,
        <yoshihiro.shimoda.uh@renesas.com>,
        <u.kleine-koenig@pengutronix.de>, <mkl@pengutronix.de>,
        <lee@kernel.org>, <set_pte_at@outlook.com>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>
References: <20230804035346.2879318-1-ruanjinjie@huawei.com>
 <20230804035346.2879318-3-ruanjinjie@huawei.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230804035346.2879318-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB4970:EE_
X-MS-Office365-Filtering-Correlation-Id: 5497e048-9f20-4b2c-18d8-08db976cc091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27LBOGNRttLD9r+EMONmPznYqn3yrgAw/4bwu4jkLgMmaDQa9rKShG+y+pyFv7jF3Entw1erxtyiz9vTGJQypHGSES08RNIo+R/3LX898Kop+Io7PNusNkQsAJ4qUfTtIY7giJKcJkFmR5QITX1e5COJf7qfkwS9T15lpEpLnxmTKJxSDNWq2yVJ1teG4RqZpRcELcZPCVr+2PmfviZjISX+x1h7PXRdg26bK36z7rWFD5dlBSTCR1YbCgB+FuldxSYLOx22jbdsv91LX5lsJMMHSBJOWKA4ohZ4U+hiTo4phHE2v5HPqj3C0hdDi8HjV0AbKPu/3meo5N32Cbs/qlxbA1JN1thA9CMBl7qiE4H3R2Ojgqw+Rel8FdnE3I7HdkqoLehr4t3rALP5FV84ppPcf1wLUSxjiq7aZD9tEnpOjSjzBrwQm/wwTb+vaUM5LlF5OOduwqqRQ2KtCONxDBxq7VoCC0AczIM7wpgfEsDKs92aBpWGGaTKVEf05GCdYEXPvvCyh9OYtB72UbgMfUOLRoJYw8+1InpckFk788Tjxg3GCYfXtyXobfl35Gn29oFGHx4pqJPE0FUtJxfz76b4v9IMO4ViIJyMkKsHwNNYt2ztb+osd/5svBHNvYS0FDCu3kyxuD7uuEZ176WXgRW/7f+dwThJhIdJL73Q31E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(316002)(86362001)(921005)(38100700002)(66946007)(478600001)(66556008)(66476007)(6486002)(31696002)(53546011)(6506007)(82960400001)(41300700001)(26005)(8676002)(8936002)(2906002)(83380400001)(7416002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjFhcElwUEdtdk9VWkpWaTBtbnhqRlRlTy9WOUN5NGgrRGFWQ2tGWDZhMVZR?=
 =?utf-8?B?bTRVcnpYS1dmbWFSTUl4MVVTRjdPeXlQaThNN3cwL1BMc2VCRXI2OUszakhv?=
 =?utf-8?B?cE9BN2xZV0Z0KzRHd3VoblQ2aWtleDAzSDF0VG8wdGVrQllCMUpaS1VXNHhP?=
 =?utf-8?B?Z1gra1NOVnBLeDVHdXB6YkhFZWlmMWtMY3pRZjNTV1J5YnZoUFBoaGNjYldY?=
 =?utf-8?B?S0FFL1pENWFvTVVJanVmNXh6bGp6RndNME5Ba0pHK2J6YVMvTDRCVHhmOU5s?=
 =?utf-8?B?NXZqRkRoN1Y3bng4UHo0aTZvbCttc2NGN2kvWkVRdElWZkp5U3kwQk1VRlp6?=
 =?utf-8?B?QVpMNzhMdUVXWFR1MXI1bGNUaXBPZHMvTy9zc0lBeHdlalZQVXNPaXdvNEFo?=
 =?utf-8?B?bUNjSjV1aUJFSnZQRS80am9yY1M5Y2JMa2lTaUIzcnlTQWdxeFNWUUJNK29o?=
 =?utf-8?B?TFVkcFpmTVlaNDd6T2RBZkRKL0l5dmduNjRaNG94WGZLeDVQZVZBMEp6cHZI?=
 =?utf-8?B?bUZ1UEdaS0l6S3RjOGE4cFdkc3EwMDFnaVlFMGtmY3BkZ01LSkhoNlhPdmZm?=
 =?utf-8?B?RFI5RkFXODBQd0Y1Ykc3Q3VBWForVFdwM2R4aUZlRTkwbnEvRUQzZ0Y4U2VQ?=
 =?utf-8?B?U2d3b3drNmpibGdOc0VCbHlzOGZ2ejNNRDhNd01Gc1ZQclRLN1F4andIM2Za?=
 =?utf-8?B?TzRRcGJuSE1uOW0wVEZWVjlYQ0JnQ0J6bS9sd0ZmM3ZoMWVMeUdZSmt5ZVo5?=
 =?utf-8?B?TFhLZFNPNHUyOGhtZktiblBTR0dkSktxTVpTWHhyd0xRMGFWZ1ZyVTJnUWN6?=
 =?utf-8?B?TGw1UHRMb3NmQm5hU005L2Z4UElmMHA1QXBySHdoRWV0K0RyVmsvVldaaldk?=
 =?utf-8?B?NkUvZHdsOFYrY2lUblBQN2xWTlBORmtiUGJsN3NHVUlIUllWTnA4UVRZWFox?=
 =?utf-8?B?RGJ0cVhJekYwakhRRnlKbTlSekR3dVJGVHFSTkl5ZmZoL1JyTUpEQW8vRjl0?=
 =?utf-8?B?dVZCc2RDTGNkd3E3TXZ1b0Uwakh4Z1ppUkEvaGpvckdncjFuQTgxM2J4WEY1?=
 =?utf-8?B?MzdnS2xFQ0hDak9qUzZGaHBwdnB6UGU5UUVkRXZhcDdGOE5CeDh1K0t6UkZO?=
 =?utf-8?B?dlgyeFZFUUFaTzYxb3dKV3hQNDM1cE5CVm1aWVB5amYrRUE1R0x4R2h0SmN5?=
 =?utf-8?B?djNudmtPTVpBRy82NTlZbE55WGc5RWpybGwrc29hUU5NTzFKNHlyakJXaEsv?=
 =?utf-8?B?WE1RL2JRUzJGQyt4eUxIcmVLUTBJMlRTanJib1lieEZ2YlRtQWZnc3BIa3dq?=
 =?utf-8?B?QURtRllDRDZ5L1R4QkN3QVBOeUNNQS9FN2Y4cmtQN1FBVjdRQW12aVZmVUpE?=
 =?utf-8?B?SGpvdWpheWd3cE5teWY2NXdPWjlvT2l0MWIwYWg4MCt1SjJ1S1BnZ29aT3lW?=
 =?utf-8?B?OHdocUFxYVhncng3RklYanpGR3RPZGtodG5uYXVVcS9nbFFPZjhsaXYxRHdZ?=
 =?utf-8?B?MUM0VHRkMzdhVzZNMlUzTEpaR1NETkN2djJza1BSV1ltOCtLYlRzdVBuOEZE?=
 =?utf-8?B?N3EzUVJtSEZ6dWtEUU1sOXJQNVVodTJjOXdxcVMvWGFWYXBTcFF0a1I0elNl?=
 =?utf-8?B?bWpubUhEaWl5K2dzc1VIY2prbWdNeUVEblhOY3dPRFZOOXBBdXR5Tkwzajkx?=
 =?utf-8?B?SU5LWEYvU0FMU3lwQWpiRDMxQWxLV3g5SEpNdzg5Q2VmWll4ZFNqWHdpQS80?=
 =?utf-8?B?VUdHNlVrblNyYVJWbGM1OTRhWFdIQXJtSVE0RDRnQVBFVE9sbmtoYUk3WmRn?=
 =?utf-8?B?bUV0aGJrTDEzM1FhREViTUhwZXJQS0VHbUtLOFUxeTBRd1pMWVdUQzBiVUtv?=
 =?utf-8?B?eFZaV2VNNHQ5RTZac2huanVJMFF1andkd3NlQkYxU1pyd2VVa21GUE1BRmhi?=
 =?utf-8?B?TE1xRkZ5SHBkb3k4c1M3VjVabXBybmJMeWNybmY0aE1nT2VteVVxMWRsT1l4?=
 =?utf-8?B?ODVTTXRVM1FYVFZ0OXJyTjA3SVIxVXNnVkxzWEI2VmIrZW5yZFgzWXBGeVQ2?=
 =?utf-8?B?eXZZTitPNUk1VG9SRzdEanVZM0o4cmNOcGxmQWVlbDNoRWp4Y3d5Um9oSU9n?=
 =?utf-8?B?TmlzdlpHcE9ReG9NbUdPZEFtTnVSNmZ3SGV4T3Q0Zis2TE1GL1hSYWRTcmM2?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5497e048-9f20-4b2c-18d8-08db976cc091
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 17:35:54.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CA596xZm1SuwvlrSCr3eFeWfsh3doIE8/GV6PPR0a3iYXc6f7T4VTegxaEzUTCIQ8KmtwGow4NmOWTLvYC8tNMQlA3oKxLTQ2H3g3oPkqLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4970
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/3/2023 8:53 PM, Ruan Jinjie wrote:
> Ther are a little ternary operators, the true or false judgement
> of which is unnecessary in C language semantics.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_phy.c | 2 +-
>  drivers/net/ethernet/intel/igc/igc_phy.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
> index a018000f7db9..c123c9dd6a49 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_phy.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
> @@ -1652,7 +1652,7 @@ s32 igb_phy_has_link(struct e1000_hw *hw, u32 iterations,
>  			udelay(usec_interval);
>  	}
>  
> -	*success = (i < iterations) ? true : false;
> +	*success = i < iterations;
>  
>  	return ret_val;
>  }
> diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
> index 53b77c969c85..a553e9d719e7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_phy.c
> +++ b/drivers/net/ethernet/intel/igc/igc_phy.c
> @@ -93,7 +93,7 @@ s32 igc_phy_has_link(struct igc_hw *hw, u32 iterations,
>  			udelay(usec_interval);
>  	}
>  
> -	*success = (i < iterations) ? true : false;
> +	*success = i < iterations;
>  
>  	return ret_val;
>  }

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
