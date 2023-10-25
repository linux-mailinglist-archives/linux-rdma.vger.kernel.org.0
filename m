Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5897D663B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjJYJHm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjJYJHk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 05:07:40 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 02:07:37 PDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904D1E5;
        Wed, 25 Oct 2023 02:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698224857; x=1729760857;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8pHZdhqGfZOMo78SvmR8BMgTwMV+ZtUxUM3NR8vwxQA=;
  b=itLFOdJTzcasjZ6EGwf8fSM6n9sFPdqAq7cIk7SbxLKS99ui00H3JoQf
   GOXGObcxWZ4qKfiyVyhl7DgrL7Gd30xFHqaxvnZgbDdhXYV4kqqCjfIyK
   4FjRO4lJmfl0uRY6a+e5kXdY1irpKPa3qLWVnJZK8DjpWBA0mWkd3g37a
   APclkjTzX8cOlvFowaUQb08natbKer/Vv3DrgrN0eXeyhvfZUfaL+boS/
   LGnZ5Mc/0EwZBd1YxtZDowavu7MC9pXXFlOk0LdSpr3Aq1dGRdoWVyC43
   8cgnOa9mu8TbGj1x/O5q8PsVx8LUHxtsO4Swo6M/YIC0R9782wTIM88aR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="25109"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="25109"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="735319171"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="735319171"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 02:06:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 02:06:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 02:06:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 02:06:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPwePkA4d/SGhsOQGHlwcV4HumpQRgsOEYDgxUBhxJPOzyyHml+RFYRE/jNjs5iNaEqehJan4qp60LAyZT2mzyDZn2MQE+HYJXY+vbTAvOZt2kGwW442dpfvxukfjcBQgjPgCGJRpc5EZSgsdBZwGMa3T3TXrxKAB8wJhlMkddQ7gofwCUYnXw5nRQWuu0jI6Ox5ga6pVV8sQW27ryXApH+8z+walnSXajCMze92dD+Y03QxSs86fznPIorvfpp1/HO0J2Rz2TOBPrBxFK+RJOUCOvkvo/PQgLXD80QFBvUM5b9xPbA9GioIPgrMSlYq7Ky7VL68l7VkBNfSYLXBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMawvH1UKxUTuw7ptSl5bdSFyyWoyWYlavsqC6uvB7Y=;
 b=THHbYFxs1WWrcEkRUYodODsIZGLfYuPMrc1dQXH+e6JmJIsU1TZdfmrPqcnM/9q1rVLOtTtibnpco42fTWB3JrueCWe0DncLZzreucRwmRRrarnFALXwvIBYRd5rAVeA6X9wEg7AsAgd+nC+L9ZT5fIaFKYdt5bkaZ8YUshsoVMQ93/dhqTqDKi21vUKxKwb2G2hPvh6GPpv2eFdFYOCPKfvkcq43pnTVkE1CCG/2pyKg9so65fY8w88mn5R6DfrDddZAItESPs5Sa9AZidDC59J3iRcQrv0cnA3dPuoZFX5IVMRVjnxy7fUK/uc7kPaiQS6s2OSPqqbowYmzj2JNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB8569.namprd11.prod.outlook.com (2603:10b6:510:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 09:06:31 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 09:06:31 +0000
Message-ID: <5a89b15e-e4ca-4e06-9069-6f005c6884f2@intel.com>
Date:   Wed, 25 Oct 2023 11:06:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: fix double free of encap_header
Content-Language: en-US
To:     Dust Li <dust.li@linux.alibaba.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Cruz Zhao <cruzzhao@linux.alibaba.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>
References: <20231025032712.79026-1-dust.li@linux.alibaba.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231025032712.79026-1-dust.li@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0037.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::17) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH7PR11MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 084b59c2-dae8-438e-6ffb-08dbd539ade0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p19yrB0MyrUZVsDe+7O3RMMjsdNND7HF8iM/A5AAvvdnqxW6oO5Z3sAZZ2rIAWlAcGZgKtvMAoMQjGfd442w0JI1kUSxUuRDmrf6FsowYxoPdgzhZbNwzB2TlFMRMxQuhDghGjMLCY7JDKmq5a/x8WU8uxW1kZ66553D8/TPX4fc8nNI/p6QyNPn6Ht4kFkiuxu1WWxf1yUt/dTRfCYwuw+jScrjvkIPBVChGNzFfh2CBgXWpGVBIGE1jnMIMUHdszXFTeDXQ7KZXyaGSvLal+xVWZ9dESzIhRht0oBMwuEC0uW6BbtZinACIZGAaxm48sHvClhJjBSdhdeW86AQOmYTSooanNZ+ApPlIW9SzOQEUuawX101qpOqs0Zh6kPRXgpOjQ9G4SmJNxflyuX+zO4aqhMgXQ75YR7f65YjVht8qaLMOjUr5Aixt7MGwcswgSdyKlnBbxDFIV3T2lyIBnRBlgLinPdfE6jdJHHvzB1hHnPWXNW7pOio5iAAsbpzlbMaG8NuQVqh/ePsfo47xLa2/hdAW2LUUXu29onZwYKhzgIRJ6GwapmiWUE0zT60VuxXCJddGHZHotBHORzbhotu2EGHkkFzbZ0d6YxZ6CgKDghNMVRBXQ+A0vNzHgMMm77g2kHNILs0hJb220b0ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(41300700001)(83380400001)(66946007)(54906003)(31686004)(66476007)(110136005)(7416002)(66556008)(8676002)(478600001)(4326008)(8936002)(316002)(5660300002)(53546011)(6506007)(82960400001)(2906002)(6512007)(38100700002)(26005)(36756003)(66899024)(6666004)(44832011)(31696002)(86362001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0lwSGRIbDdwVVQvSlZDbC9QbUZwZmN4bExYUzhHOFA3eWI5UGpVTjhMZ05O?=
 =?utf-8?B?Qk53cjBGYUxZYVFtTlUyNTRaQmRKOTdoVmhBQm4xTE5RM3NMSTlTa2I0SGVs?=
 =?utf-8?B?RWFxeEVaUWdSb3IzZFUrelpKdGJnMENGL241OWRjVzhrTVdrTlB1N2lkT3RS?=
 =?utf-8?B?U1pjMjFRc3FmbWpreklFcXVGb2NpUHpaSGlOWmdCMXVlSnVic0J3U3dEb3RT?=
 =?utf-8?B?S1hqcVUwOG14Q05rOXRMZm9zZm4vMG8raHh4OE1zcWVqWGlOVmh0TmxWN0Va?=
 =?utf-8?B?M1Z4SEx5MnZ6VmttOW53aGpxL0dPMzhVd0ZQY2pwS3hlMHNZdXU1dU5zN0V1?=
 =?utf-8?B?UjhvQzN1akU4bGJWQ05FT0tWaWNKTW1Gc0hrdEpCaEZNeFpHb1hWUVo2bW9h?=
 =?utf-8?B?cTVrdDMvU0FaYk1EZlFkOVpKMnE4UEdIMEVBeGllWkVwRExqd280WC92L28y?=
 =?utf-8?B?NVFLY1REcXNoUjJMVGVMdG0xWjFLeW9vWGNOUzZVMU9halRKUHR1cmRPeG1k?=
 =?utf-8?B?SlFNazh6ZThDWnJaZG1Pb0tjMmZFcXlIT1U0QmNydUVMWWNLbFVDMHFBZnBi?=
 =?utf-8?B?U1BoeU9nUGVOY3pvQUxUYTdOM041L3ovbHc1b3BTa3ZrRGI0WUFpenNKZXBk?=
 =?utf-8?B?Kzg3NmNhYlhjN3dBeGdPTmJmclNSa0dodUpRR0VucTJMdjRKSmd0WUxXVmd1?=
 =?utf-8?B?Ylo4aVRLd2ZmdTd1WmR1clZTVFBIUlluZFZ0U2tmdDlQSHpVb3dDdXhDNkpm?=
 =?utf-8?B?b2NkRExjR0NNdmJxSEJQWVVhVm0zRUllR21RSDlLTlRHWklUZWNUVWN3N2tN?=
 =?utf-8?B?RTlsNkJCd1RSQWhmcmRCV2dnc2dJMko0clhhcW92OFlWT3crRlVsWmNSdXVl?=
 =?utf-8?B?MGZsUkVvV0c0V3ZLY2hnR1NJbVRVdytjbnhSUVdvZm9rWGIrdnRyam5hZEg5?=
 =?utf-8?B?dW1zRnc2WFNsWGdNb2I5dXVyeUhLQ0wxQmN3V3lBWUNZeVZmQzJSeEJXN1dS?=
 =?utf-8?B?Ni9mRyt1dlRCdTQ1bkFqbS8rSTBEcGY4M2t1V3BQYWFQYjhheVc5WmRSRStD?=
 =?utf-8?B?UFgvMXQwdWhaSmd4Y1VhZmhYY3hEWUZjM3paWHNJUDAxSmE5bWpuWkovMEti?=
 =?utf-8?B?UDFBNGVCSjVPbVB5c0JOU0pNcUkxaUxqQUpFbjZ1UERLNVZZSVhSSWVoNEJt?=
 =?utf-8?B?QWM0WFJENGtxbXV6anp1aFFKNWJFRkI4azFCZTR4RXVrSDN1M3NtZUhuNGo1?=
 =?utf-8?B?VHNlZnhmV203RzA1Z0cxbE1DTWFzS0xBdTJJVWtYVktMQ0FPQ1ZwMGorUDZi?=
 =?utf-8?B?QVVsZXBER0dPdFRvSXB1NlBLcnZ4c0kxaTNmOUtSbmpib1VKbEVSMDdZR1J4?=
 =?utf-8?B?b1RCcU1FaEVRQTk5MUpEdVN2SUs2T1FXYW10S3dUNHo0bmRtaGFFajBtN2px?=
 =?utf-8?B?cjZndXhJTi93NkwwL1NmaXMxYnNoZ21rVlBEVDBOak1ka3JFT2kvYUxvR1h1?=
 =?utf-8?B?aytqZ2o0eFEvNGdhVmg0YlZaY2lkNG0yVUdZZU9mWGV1Q3ExMkJscmRrZkJH?=
 =?utf-8?B?RDBDalNjQ3JJUy9LTzc4L2pQb2F2RDl3WmliUk5mL01wTGNjbDE1MlJsNCsx?=
 =?utf-8?B?T0ZwUWNxYlBjWDlBbmZoZnpDSDF3WUlsbDI4QzVscEdxQVVBUlIyVjIraWR3?=
 =?utf-8?B?VDV4dW9VNXNBaXpQd0VKTytFdVZrOE4xWG1uZ0g3SG12SFM5RVhVc1g0S25K?=
 =?utf-8?B?cWdVMjV2ejVvMkRlWDlodi9Vei9NSlp5Q0RhZ2RRVnQrWEZUODU2OUtvZnUr?=
 =?utf-8?B?VGFtc2NtbHc5Zk1HZGJpWDRMQ0hWb3ZCc2tuemhSSmRKWDgxWm51QUhsaFFS?=
 =?utf-8?B?dVZCOVVNbWZMOTJJZ1ZWSS9XQkpUNms5dGRYbWVjNE1FeWJpTnFIWlJCaHhy?=
 =?utf-8?B?WDYxdWtLb2tBcUEybkp3UnFNVDkzZVNibnEwS1N4KzFmeU9CVG40NWtUeGtH?=
 =?utf-8?B?M01Zemp3bThQQS8zUkFoNFBIN1BLOHQ5eHB5MHVSTDRDY01adHpHSUZFT05W?=
 =?utf-8?B?bmkydVZGTGdQQ2ZmcEZHdVZBT2o2QkhwdmhDbmJDbVB6d3dDSXkvWDE2MG5H?=
 =?utf-8?B?RnpCanFKd3lzRi9kUERNWVRvTko1YlV2TUpjZGU5ZFBkazY3NEhtTGRhS2hD?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 084b59c2-dae8-438e-6ffb-08dbd539ade0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:06:31.3427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEmLX4ooPfLDoeLvrDd7zdvD7IRLnKPpgeERPt6K4BlzAm05dpVgtX6e+mrrfoJjmkNScxD2HFvxEpUSuT7k8VElRw+m0U2mRDF0PS8/bEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8569
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 25.10.2023 05:27, Dust Li wrote:
> When mlx5_packet_reformat_alloc() fails, the encap_header allocated in
> mlx5e_tc_tun_create_header_ipv4{6} will be released within it. However,
> e->encap_header is already set to the previously freed encap_header
> before mlx5_packet_reformat_alloc(). As a result, the later
> mlx5e_encap_put() will free e->encap_header again, causing a double free
> issue.
> 
> mlx5e_encap_put()
>     --> mlx5e_encap_dealloc()
>         --> kfree(e->encap_header)

nit: I think it should mlx5e_encap_put_locked not mlx5e_encap_put to be precise.

> 
> This happens when cmd: MLX5_CMD_OP_ALLOC_PACKET_REFORMAT_CONTEXT fail.
> 
> This patch fix it by not setting e->encap_header until
> mlx5_packet_reformat_alloc() success.
> 
> Fixes: d589e785baf5e("net/mlx5e: Allow concurrent creation of encap entries")
> Reported-by: Cruz Zhao <cruzzhao@linux.alibaba.com>
> Reported-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
> index 00a04fdd756f..8bca696b6658 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
> @@ -300,9 +300,6 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
>  	if (err)
>  		goto destroy_neigh_entry;
>  
> -	e->encap_size = ipv4_encap_size;
> -	e->encap_header = encap_header;
> -
>  	if (!(nud_state & NUD_VALID)) {
>  		neigh_event_send(attr.n, NULL);
>  		/* the encap entry will be made valid on neigh update event
> @@ -322,6 +319,8 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
>  		goto destroy_neigh_entry;
>  	}
>  
> +	e->encap_size = ipv4_encap_size;
> +	e->encap_header = encap_header;
>  	e->flags |= MLX5_ENCAP_ENTRY_VALID;
>  	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
>  	mlx5e_route_lookup_ipv4_put(&attr);
> @@ -568,9 +567,6 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
>  	if (err)
>  		goto destroy_neigh_entry;
>  
> -	e->encap_size = ipv6_encap_size;
> -	e->encap_header = encap_header;
> -
>  	if (!(nud_state & NUD_VALID)) {
>  		neigh_event_send(attr.n, NULL);
>  		/* the encap entry will be made valid on neigh update event
> @@ -590,6 +586,8 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
>  		goto destroy_neigh_entry;
>  	}
>  
> +	e->encap_size = ipv6_encap_size;
> +	e->encap_header = encap_header;
>  	e->flags |= MLX5_ENCAP_ENTRY_VALID;
>  	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
>  	mlx5e_route_lookup_ipv6_put(&attr);
