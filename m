Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897D6630847
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Nov 2022 02:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiKSBSj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 20:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiKSBSR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 20:18:17 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692C8F609B;
        Fri, 18 Nov 2022 16:15:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSSDZCaecXsWoNfmywONQnOE7QbSsOXgjtTlsJRtSE2FoSvbqAH9CrL3SymioTDo2/lVcDAedqV+0V7rde9AKxM8CJubdZzcAK5OqIVKB+drBiNFn4K+JN0rI9j666x1k6yMQBpb7AC5hT4AfqbXTN2oWu0O5kMQfgvj3f9MbmOdZ8RBo33a5+zjZZC0KrYnkqb3x5tfjkQ+HWiREazM9KR+9seDDZoAnejo9wytvtm+7XSGF3U99JHP/fBkt4e2SD9zQFiunlksNZ5meUzZ9dGB+U7BsN/d5DAlcLMlXSvebP6jghAuoutwNvTDBYqkqWS5DLMp2qBCWzBkoPQAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WxMHIsGK3Vazr79CiLT8AgFYH95KleYUaval098P3k=;
 b=FreYWLVntSskYyGcDcZxz4X0tGKgPCX4fuDXzwW/nzFFxosxLDmCJ7Pz+dHMXLf+RMQO1dpLMvIVreTQBd3INjlmB77I5I4cEmDDx4r+OiNsg3l6vzOZA43KAa0Lu/71oZ3hla5OIBsxx/Yd+PtPO7Tv7pGU7zDmp9Y/rXxJ8zNl438zdpgAtJL5ppDngzlsQZyWNTcWThXl9fXGqy9L/9z39YkWoTblFigBqxbcx36+kuH6pF6PfQQNMEn/m4Q+x+46z3GRP5HQPwFRtOEnasvPEQjZChXPnV2S9MDKYiJK3u+ByDb7ok0KDPLqpBndQhcFIhh5i0jLjXMMRq8BPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WxMHIsGK3Vazr79CiLT8AgFYH95KleYUaval098P3k=;
 b=Y1A7Dw7YI0hnOKCMq1bThR7rWUtaWkvf/dzQrNlPtE/AtljXJzrYRo45/bKYITZF96GB9GhR6PiiNXk/ZbTLQHrY5MHMxcymIAcF3Ff6cMynR3sTDa/mW0mOA5GhxtoM8sNVk57AQzTc5y3NUYg7O7eRK65a86Cugmhe27LcTPlzyeMiD/8MnpbdsdFT+nRflB8NolSGnBaacb+eyFfaR3RM5WW5buEZi6yQ1NXkG+6M2pLkvaj8TCNYSALpqt20LMU+mPqRdRDqVbuIlFBlFLM5AFQ7WhQLPSo1UypsVBdjbjjszSfqr2OCCic2VpjK4R5Z6YOSAt2Te7wEgqw7zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Sat, 19 Nov
 2022 00:15:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Sat, 19 Nov 2022
 00:15:45 +0000
Date:   Fri, 18 Nov 2022 20:15:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix mr->map double free
Message-ID: <Y3ggL8RJw6mDaWxT@nvidia.com>
References: <1667099073-2-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667099073-2-1-git-send-email-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: c713d7f4-67dd-4752-8cf9-08dac9c33397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJOGSItixlYUukx6RYYNF0rwZdVASrki6ujCCN1IxB0HnmYalc61xc026DJhXqzToro1K7amcV8bH8a5ti++Zeqc4UjZjOOrWLsGNW9dQZ+Ppi0uaTvbhncGbfaOdvWe79ico3BVnNRs/wXQaeXgr+0BBZraQeK459gBLnU5uUzcbm/uf/HqZXC7EPZkRKCffgwpYJ7gkcs8TYvLxp79gvq6E57SVng9eR7eSbYj8htrTZcC/WvUgFu/+hFkfhztrppAKtE0dVadfpJlTvP+y1JtZpcBtFL9e0oQzbyWq/T26DML2lEslRbriUQ/M+gqLslRVQoOeWoqxjqDOsg7XtWS3ubV+pGLN6WLGMeTFbL5pC+XRC2GwQ76OPA0tCfSuAd9huOQCtoKXt29n3GpLP/QevWdefhhFLmJcVe4QH5Bcc2sc52P+R4TkcMTVMXFtX0KZbqRuAanu7qwpBfw2yt0bDQsnw1hcctiJzjoM0c2rbksTe4WvHtebEMKTXYjx4Sp9Df5vdg1yHK85bz0jw3ZQ6PFRLjcM2lkyycfJixKWjdtGp7ir3A+1o1JYyvBjWfhhv8mbMKSgvktkf3tpcrA4bMT1jhzhwxGp1pUWTpWeanEPNbl6QxPIf+bRfb8SE7opRML6Fm6Ntbl9xoiUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(2906002)(83380400001)(36756003)(2616005)(41300700001)(66946007)(186003)(86362001)(6506007)(6512007)(6916009)(38100700002)(26005)(4326008)(5660300002)(8936002)(66476007)(66556008)(8676002)(6486002)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Khcnn/iUhtCWQy4v7Ah2wDqcHZSrgeob0C+bnEoV0RQUL7mQEzQCJ3p2WUc9?=
 =?us-ascii?Q?OncHWKX5JcOgGFUBAqLqAplLcH6XlQtT4pxecfSMrZ61fLZFw6RvbGnhw2dg?=
 =?us-ascii?Q?Vpkzz6D9sIC65TOgJfi3UiN6mFNhAityFy5CTlH/6LLT/wqUm2L9I4hO9Hik?=
 =?us-ascii?Q?IpdfqFPAaLkGWMvFzgAQFHZ3E7DIrU1HHo6On8to8rCBF9iyLAmni1j1gaPh?=
 =?us-ascii?Q?8u6DWuiJc7VBS09rsy8a0MfZOmj8RJeYchDZi9c/9PMx/aT7WX/Z+GVM/l78?=
 =?us-ascii?Q?Kj6jHGSgGqnEfKHIIGEh5K0HdaoVLtP6rQIdGYVVkcakmLnfeIAep4RO8hcA?=
 =?us-ascii?Q?9o6lijPWLb/VWHWLT9gcmZVkJoM/+dUJ71XD5FIyEyJEw/LBu2hHdveKcEF0?=
 =?us-ascii?Q?/jeE48MwYAhdrXmGhchGje909yidGEatlY/hbtPiXBAoiDai9HJszecZnekS?=
 =?us-ascii?Q?MFH1EiDvze7vBjRd55gZg6vJLgMCzjJzwkm2oJfTvDynn35LpgdS6CCD8P5x?=
 =?us-ascii?Q?MPKJF4dLl+58h62JCac9pKpk9ppbEQbPs6gO4oKMyb/xymrRyqV+A9Ee53CI?=
 =?us-ascii?Q?xFS2uIOPB/zlCHmb4WaVbzJVvLBudk5PoinCSmRN3zKiHcjANzYOb3naByIJ?=
 =?us-ascii?Q?qzVpdKw4lS9K9x+O0SqEZOyN/kZ+oOIRyOp4IcI+PgrY8Rhsq3DzpKibyp+T?=
 =?us-ascii?Q?8xlF67Go+Ckx+3+gW4Uoic3nIi8C7e58qslU2leZu2IGEnrAOJUHvBkGRtzZ?=
 =?us-ascii?Q?sbNw7VwhDiLBkECtaeiuNzVP16efjzr9pTjYVNCo+F7M1Lr1rRwbLXhq9e93?=
 =?us-ascii?Q?tccr2bEriR63tnilPyl02HFQgIwXxjaRDbbIWKeqm30imNbmqKzvvxcHYKm/?=
 =?us-ascii?Q?MifOwS45TX95vgUea5esC6uSIYzxF+Ayk8OBdgSDcFi+dxIfgJAJje0sTePo?=
 =?us-ascii?Q?u2FbT3fr3utFgVh/UoCqro1+DGDpsWIov36hzwamHkL7ZhtFJrYLugMatV30?=
 =?us-ascii?Q?b4i/BdwV95/JgZXglmRBd9auBybBsPQjNER4IZRBbTazsYFPKwIpBpiyr1f2?=
 =?us-ascii?Q?ZLgxTiFUX9IXwgpYrTNZD6NU1YhLXxH+Cf0lPqoH83sNHYmWmcnlcsIrgp9j?=
 =?us-ascii?Q?jA3W9gB2dMyRyoEirbAw/Um/VZd5TjWmfidxCOcluFo1wRUEKHIcIiCtZ7uw?=
 =?us-ascii?Q?ZVfJdA/vmeggLt683s3KrDlBQg8mYi9xU6TgFUEIUX1YycWRRgxC/5JOuDcH?=
 =?us-ascii?Q?HnVm7b+5mLYyLselNBsppZLxdC6+vcg2tiCNIbKaP9ZMjXou7PYboRFQ5xmr?=
 =?us-ascii?Q?eyG2jzcwLQWAFNpAziFKOJ5Q/QU54VKhsWOtnR6HOOg0XqksMYz7sLfdEqc6?=
 =?us-ascii?Q?ixPa0QrZWXjEM3SHW9Z6NnfZxOr4bcX17C3UP5GnzFQcmJXnyJ3RHUAp3Q1+?=
 =?us-ascii?Q?+2WK5INGKTaq2LlCPZnzYsEZ3Oeub6Edp7T3iWmmU3ys4euxgcrjkMxPOyvd?=
 =?us-ascii?Q?VA4eCguR+4Zu59Mtv2n65CeEjiiDpKKrueuE5xx4qlJn2nWRCaucl89cQlMm?=
 =?us-ascii?Q?uh2jMeWvtQwaiTdwxGQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c713d7f4-67dd-4752-8cf9-08dac9c33397
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 00:15:44.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTmbaKVJoIql6s1UzU11LRafitaghqyVR2OecqEeu3Tt8m2Z8wPQLiWDtARZYykn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 30, 2022 at 03:04:33AM +0000, Li Zhijian wrote:
> rxe_mr_cleanup() which tries to free mr->map again will be called
> when rxe_mr_init_user() fails.
> 
> [43895.939883] CPU: 0 PID: 4917 Comm: rdma_flush_serv Kdump: loaded Not tainted 6.1.0-rc1-roce-flush+ #25
> [43895.942341] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [43895.945208] Call Trace:
> [43895.946130]  <TASK>
> [43895.946931]  dump_stack_lvl+0x45/0x5d
> [43895.948049]  panic+0x19e/0x349
> [43895.949010]  ? panic_print_sys_info.part.0+0x77/0x77
> [43895.950356]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [43895.952589]  ? preempt_count_sub+0x14/0xc0
> [43895.953809]  end_report.part.0+0x54/0x7c
> [43895.954993]  ? rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
> [43895.956406]  kasan_report.cold+0xa/0xf
> [43895.957668]  ? rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
> [43895.959090]  rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
> [43895.960502]  __rxe_cleanup+0x10a/0x1e0 [rdma_rxe]
> [43895.961983]  rxe_reg_user_mr+0xb7/0xd0 [rdma_rxe]
> [43895.963456]  ib_uverbs_reg_mr+0x26a/0x480 [ib_uverbs]
> [43895.964921]  ? __lock_acquire+0x876/0x31e0
> [43895.966182]  ? ib_uverbs_ex_create_wq+0x630/0x630 [ib_uverbs]
> [43895.967739]  ? uverbs_fill_udata+0x1c6/0x330 [ib_uverbs]
> [43895.969204]  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x1a2/0x250 [ib_uverbs]
> [43895.971126]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
> [43895.973094]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
> [43895.975096]  ? uverbs_fill_udata+0x25f/0x330 [ib_uverbs]
> [43895.976466]  ib_uverbs_cmd_verbs+0x1397/0x15a0 [ib_uverbs]
> [43895.977930]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
> [43895.979937]  ? uverbs_fill_udata+0x330/0x330 [ib_uverbs]

Please dont include timestamps in commit messages

> @@ -163,9 +163,8 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>  				pr_warn("%s: Unable to get virtual address\n",
>  						__func__);
>  				err = -ENOMEM;
> -				goto err_cleanup_map;
> +				goto err_release_umem;
>  			}
> -

page_address() fails if this is a highmem system and the page hasn't
been kmap'd yet. So the right thing to do is to use kmap..

But this looks right, so applied to for-next

Thanks,
Jason
