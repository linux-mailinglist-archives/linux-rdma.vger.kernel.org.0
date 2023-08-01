Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EE776BBBC
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Aug 2023 19:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjHARzV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Aug 2023 13:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHARzT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Aug 2023 13:55:19 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B5E1BF5;
        Tue,  1 Aug 2023 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690912519; x=1722448519;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=TqBoy1uQHCIlA5l+4wE1dkL7Cv9/YUapUC2zyQT9+S0=;
  b=QWEJGwvrQj49gVYCSiG1mFycoVSrPk8BDGlENd1GA6Gbpl74M0/dYfrG
   Usiqw/7uduhptDoptJK3ktJa/TlavrXO79P9lQTkWeU7rlf0Xckw1zsRv
   jPqRCi+3u1a7vZc98MYTLIjbIEuvClNErLxXq4to9K49rnNh67/XI6Xgm
   LO+KjzUXrP4yF/y7b1En0jn+JJlCp9pHQ2x7yVeH5JifYZ0MLqo/af8fv
   zGNey9WiSOqqxOqmZ3K8Gjr579iZlQR++eXIsWRz3j83yxyTtwUkeh4xh
   LBUAlKPmHOAfrEwm4ZqTsfgF43AsjpHhvIexvNCUDub7q/BrhjfH+2Gll
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="348975566"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="348975566"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:55:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="975393163"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="975393163"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2023 10:55:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 10:55:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 10:55:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 10:55:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 10:55:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4kyvkDTuxzt65jMw6uoNe/MsmcTVj7luJvVlseAHNzrgBm88VsSo+PCoCbmq85539gBcOAzOi3xF1mSDx7y2uEkBIpMtJPdmZq/GDn6y7V0Br42mSWpn8p5aBeOUstDYy1gC4lZO4FTSdxPWGzOqxQl0xdqQ51UBEdeDfq2Hld00MUItkI81irAa4AkX+Ui5jp2lt2MgA5ysyiLznPYu/N+UmJCdWSoO77HpSv2MzslWdBCgCXwcAI15n1l6m/3i5KlXoEGXib3taMsiqQibHcz3xPs/YcooMPg0/86BKUp9PivRrKaaa0puRt2ZbCEf+S649MZaKs3RyvL/qs60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddEO1bXFpi3awdGk2uduY0vRNRG091tHPtFHyEdn2S0=;
 b=EdlgnM10DJAWMQeRGMjQe7vb09YxXg+CgWTvX5DWap86fWXgzXHKH4+raDsPA0lsQe84C65N0jSpsBBY79QyQJTKoTgzTYvy+lB4PgTcMe+9i4duxKZG7W84+SDJGraIDfKJKyel8OgP8zmM7MPdFE/Tk8aucHAtBGXY2+TBWNiMrrlYctTnTaVKuDasf7qIaet86dmBcyWUaUgAoMIIcfCWLQLM4JoIcIdsFJFCaAgyCOX0zofRb9ZZYtL4BcOIaxRnHK2SQfn1jIF1OukgwKHYHmsAZgILCmjs6lCDothXNFGreY8X1pk2XtnSuhMMTxUqLi389KjAJPKfkplbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 17:55:16 +0000
Received: from SA2PR11MB4921.namprd11.prod.outlook.com
 ([fe80::2c53:803a:f26:b3b0]) by SA2PR11MB4921.namprd11.prod.outlook.com
 ([fe80::2c53:803a:f26:b3b0%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:55:15 +0000
Message-ID: <4811ee1d-45d7-c484-f4f0-20228afc048b@intel.com>
Date:   Tue, 1 Aug 2023 10:55:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] net/mlx4: remove many unnecessary NULL values
Content-Language: en-US
To:     Ruan Jinjie <ruanjinjie@huawei.com>, <tariqt@nvidia.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>
References: <20230801123422.374541-1-ruanjinjie@huawei.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20230801123422.374541-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:303:b7::34) To SA2PR11MB4921.namprd11.prod.outlook.com
 (2603:10b6:806:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4921:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d0074b-1da3-46bc-a7f7-08db92b875ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHUKjKoL/m2Th8zgdlJlC1bRB+iOgoullGLMzMFIRmIAcVwCdfpC9eHt26aiyfP/iGb4vt7JxUia0NTb3ZVCQRWWU7qXsfwc8p1Gq7/rcEmBerWjE1q6q1ogKl4iNwcIQMxOdYhAmgDgkL63kLJvtbU7J2Dn5fUchkIFtpWZXon/4+Au2qeQ0whhOjUKapcwhruWpyjS00bMbSSoUEKS5tcV/g8EkL/y2g5LTl/ohfL+bXVDdZTGH4SJ6PFTOPrHZDTH5uMW7KxO6crwRKeSuoT0sRFnto0MbmydTur8gDeUzecDxBQTHZzkve2zC9Wq7Ai+i9xtyvhZDKY395Q5n/+RpsLNJhu29o7GOz7PZerZavmXVMmTdeyC13YNMbDv43pWLWEDORjhmiLreQEAwrmqBZFxpIT8cnLy3XTs/aQRzYtFvEzyBShckyMUd5YRpriWJpnnhL7KBl1P7isIeyqXwfdQg3RxJEd/Murs6SuP11OKmwHmrpv2iKK6vqNsIbMxMYxEk5XxylweeNVlio4kMGHOBUOse7ZfqTAMp20o+ea8cnxgr0mxEhy7tNnLrEnK4BNtmOcl97nzqzYAAKKyRq2c1skJOUTjhhSvFT2gI5g3GDkLXrZRJyiqM3kiMyjN/xKcvm9PoN1w8FCFeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4921.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(6486002)(31686004)(8676002)(8936002)(478600001)(316002)(66556008)(66476007)(66946007)(83380400001)(6512007)(38100700002)(41300700001)(44832011)(186003)(53546011)(5660300002)(36756003)(6506007)(26005)(86362001)(31696002)(2906002)(2616005)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHZtRWVJdlUvY3dWcWh6Q0ZQSUFvdUorL3llVkhWMXpTTXhrU3l4dVJKeVV0?=
 =?utf-8?B?Smg2Znl6L0VCU05DZXBSMEpnV2M5UWZRVjNYRDR6NVhVMllmVkovNmkxNzVz?=
 =?utf-8?B?ZlN6SENYYTVJSkJXYVhONjA3Rm1EVXNmZWNkYkdnd1g2QlQraURPZTgwYUc3?=
 =?utf-8?B?Y3MwMTNXZWxYU2pLWXZCNEM5QW9xNkJrbEJVeGZqa1pjd1VDdzBHYTlDV00v?=
 =?utf-8?B?ZldUMXNYWEl2REM4U0dQL0tKeVpUQ0V1UHNVbWd5eTMzdHFmajJEV2FuS3hh?=
 =?utf-8?B?WW5GUXVnQWVwaGhnU1RLc253dEdmYldxVldlTVZvM0pvdVFQeXgvbWJ3WkZO?=
 =?utf-8?B?NWU1QkpycEFGbTN0b3FKTVdwUFUzNHk0WWluZlNhV09vbzkvUGw3K3V1YUNS?=
 =?utf-8?B?WTNSbWQrUHhtNFNzNHlQckx1d1Bhek9DZit0MHRrcURoUmxQSi85Q0dsNnd5?=
 =?utf-8?B?MUNqbGZUTUcyRjhUY0x1RHBGWE4zdUczeWZTa3FFTElZRDNTSlkrTytwN0xO?=
 =?utf-8?B?RFM3T0ZxbjFSNCtqWkpaci9qa0N3eG5XMWlyb2x1THdzN0ljVEVJdXhFelI4?=
 =?utf-8?B?MndGc2wwRStaNFc3YVdCV09JT0dIL3FTZS9YNzBsQzNZem1DcHArUDBQckU3?=
 =?utf-8?B?WjhpeWgrMFI4MGJkWGtLV1k5VEo3UksxZlZSemRkTThSZDl3NThJSXYxSHNp?=
 =?utf-8?B?YkhtWlFBTXY1Y1FPT2hjc1BPYWFPQXpDMk9jcWc1UnJzRWhHdGVHQnFjQWxX?=
 =?utf-8?B?dXRreXFmaGgrUVFjUlliRVRQUTZqUGd6bWcyZ1ZzK1RYNER4ekF1dlcwdkZZ?=
 =?utf-8?B?RVNMUDFVbmcxS1dIelNDOVlHb1RDbklQa0hIMSt2V3kxaFhJL09GV1JuYzlS?=
 =?utf-8?B?K2pmME5iMC9jSlR4dHk0TldDRk1KRGFVOEhEcEUwSE9UbW81RVdVWnFDYmIx?=
 =?utf-8?B?bStMK2NFSDlLTWpObXV1TWI5d1IvN0ozWlpCSEpUQSt2aTBQV3BWQVp6Z0Ex?=
 =?utf-8?B?dDRlOE1hNThBVzRyY2ZDZ0pDclZDSmozMGE4SnB0K0hHUTJuckN4ZEtwNkZI?=
 =?utf-8?B?eDVOcXBHKzdra3RVaC9adGl0YVlyblBWWXdoZXZERVI0RVl3VXpQQ0xBTkVC?=
 =?utf-8?B?K29MSHdwSm0rTFJ0RnpXOWhLTFRiS3Z1MUxTRHdWWlcyeUUyYmE3S3lQU2VE?=
 =?utf-8?B?d00vS0RpVk9NVmJGOHliSytsQUpTRDdCbmVCZDY0Ym9EN0hjTXFMNzNkeDhu?=
 =?utf-8?B?ZlF4Z1huZ2dLR09XZC85UmcxQVVvYkZLaVRZLzFYUmpSSHlYMHd1QkVMOHZG?=
 =?utf-8?B?QnpReHNaTHVOY0p4bENVQ05kdXJnRGZsekY5UGxucEVuRTIybHB4TEtVUm5Z?=
 =?utf-8?B?RmJKeVBIR3BVSnBBSGxMRHV3bGhUUXNOd2ZHRlJtWTJQSkJCdWt4SzlsVVRi?=
 =?utf-8?B?R2V3aFg2c1oxYTNyK1Jsc29CczBrZElhVmJxOHoxMThwMDROSHBwL0VFdVlz?=
 =?utf-8?B?Nk5mVnlDY2V3SG9md29tZ0tnQkZmOEhiZTVoUzkya09hcm9BKzZiRE1KOTFD?=
 =?utf-8?B?c2prNGQxaEFCb2pKNHVyL3BJU2hzWUpoNW13aGFsTW5veWlLSjY1ditwdzM1?=
 =?utf-8?B?NkxFQ1hWMkF6OFpZTXNkUGdrRkw3ZVdqTmpNRFoyUXhiNG1QZDNqSU9GTzk4?=
 =?utf-8?B?OThVcjViZWlKVEt0SHMyckU4UGlPbkYrelNQK2ZoL2ZvaElpNmFESitpT3lT?=
 =?utf-8?B?ckl4dmxtSFZaRlhla1lCS1lENU5HYTRyYWNMTDFFS0wwUUJ2anJmeFVPZUhN?=
 =?utf-8?B?STVXSUlrd3F5UnJjOG1ENFMvSDVZNzQvUG1tN3htYmt5M3A1WUo0K3hlaTls?=
 =?utf-8?B?L00zYzZsZTFzNTJGbzBJUWRDSjNUMlRhUlhQWURVVjA1OHBhcEFoenZocDAr?=
 =?utf-8?B?SzVkUk1vTXhFN2FqbndTNnJXbVNTOXNGS1JPRlJRR2JDVDIvdlJBVGsrZG5Z?=
 =?utf-8?B?WXlKSEd6RjZZQzFicmt2Ynk5S0kyN2pObksreHF0aHlmL080N0tzSU9FdXNS?=
 =?utf-8?B?SEM5RU1LOXJtSWZZZG15eFF2cGFLUG12RlY3VmVzVnlwT0JaYmI0eCtYSW5U?=
 =?utf-8?B?L09aaTBRalgyazhnaHhJN28vWnc1azdIbjU3RE05dG1sdjY1OEZHa0MxTi8x?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d0074b-1da3-46bc-a7f7-08db92b875ef
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4921.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 17:55:15.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suMglbawb545iULKpyE8q2AqRQcX5hYpzRrrNWX2RLQybnsnYRQNY5hvI4zDqA5CF5dmqmUfITdYvCME4CLtrpqnbWhF5j2avPxceMgLHuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
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

On 8/1/2023 5:34 AM, Ruan Jinjie wrote:
> Ther are many pointers assigned first, which need not to be initialized, so
> remove the NULL assignment.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Thanks for your patch, make sure you're always explaining "why" you're
making a change in your commit message.

but see below please.

> ---
>  drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 10 +++++-----
>  drivers/net/ethernet/mellanox/mlx4/en_netdev.c  |  4 ++--
>  drivers/net/ethernet/mellanox/mlx4/main.c       | 12 ++++++------
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> index 7d45f1d55f79..164a13272faa 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> @@ -1467,8 +1467,8 @@ static int add_ip_rule(struct mlx4_en_priv *priv,
>  		       struct list_head *list_h)
>  {
>  	int err;
> -	struct mlx4_spec_list *spec_l2 = NULL;
> -	struct mlx4_spec_list *spec_l3 = NULL;
> +	struct mlx4_spec_list *spec_l2;
> +	struct mlx4_spec_list *spec_l3;

What sequence of commands did you use to identify this set of things to
change? That would be useful data for the commit message.

gcc with -Wunused-something?
cppcheck?

I've sent these types of patches before, but they've been rejected as
churn if they don't fix a clear W=1 or C=2 warning.

Did you run the above and see these issues?


>  	struct ethtool_usrip4_spec *l3_mask = &cmd->fs.m_u.usr_ip4_spec;
>  
>  	spec_l3 = kzalloc(sizeof(*spec_l3), GFP_KERNEL);
> @@ -1505,9 +1505,9 @@ static int add_tcp_udp_rule(struct mlx4_en_priv *priv,
>  			     struct list_head *list_h, int proto)
>  {
>  	int err;
> -	struct mlx4_spec_list *spec_l2 = NULL;
> -	struct mlx4_spec_list *spec_l3 = NULL;
> -	struct mlx4_spec_list *spec_l4 = NULL;
> +	struct mlx4_spec_list *spec_l2;
> +	struct mlx4_spec_list *spec_l3;
> +	struct mlx4_spec_list *spec_l4;
>  	struct ethtool_tcpip4_spec *l4_mask = &cmd->fs.m_u.tcp_ip4_spec;
>  
>  	spec_l2 = kzalloc(sizeof(*spec_l2), GFP_KERNEL);

I suggest if you want to have these kind of changes committed you spend
more time to make a detailed commit message and explain what's going on
for the change as otherwise it's not going to be accepted.


