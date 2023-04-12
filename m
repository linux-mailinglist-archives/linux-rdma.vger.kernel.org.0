Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BE26DFAC0
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Apr 2023 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDLQCx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Apr 2023 12:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDLQCw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Apr 2023 12:02:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117522D63;
        Wed, 12 Apr 2023 09:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9stCWM7dFIfbIvlrRqrXCkstzGqg1ZD9R+CNiaBW3yzOxBMLhM+G7wqWw0dYyi3PHxGRIyuZs9NdguZM+3h8PjmLCsbEy+tSGaKgA8fGqO3H0JhtYMLyzkVbo1fUgfe438GdYRn9Ai80r3BPxzUhgQOrTOXSEzJcXG7OULbkHEcDJWciatVwW9fgbtk9urBvyrAGzvijP3axSD2tym7E11mdRpmKICiAPbNaa8ZSzaOOahNFlWs07Lv4SPl2SSAdxDzY9bF/PkSfMcTDfDu19G6nn1XzAs4VKb6Jk3ZMID7c8zy8VYJ+/kISMvqyqivCZZruRfGCK+GLZsl4DSwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osPjgTqC4dY9YqyJPmBhpfZdM/gvsHdTEuQjkjaSPf8=;
 b=f8KyrZwDxUgcv773dtcaGtuADDSGYhaX2EgFWLdLIYigsWBphPjRgZIeCzaoBref6XGKmMatprIWJSs/nzWVzxbW6xWnOUkW/TzLT9e6oYwZnZUdkzvaW6oV2E3U4k+qlfWQTxNyOPzQye+5dbjKTDp0wJ1rlGaKIhuKFCrH6SxxdwT+LLWVK5fxY5QFnbUaKQW20aDTKOnWqFBKC2/ZGa8CsAm/DRc87Nhzh7LrfshKDQIT6OkNPRGLPdjdw0mK4OKQdhlixILHpEvPrLzfnmdQ9qryM8VbcL9kl4f4iL9TYBPJMj7THzdHKnyQ/wObUHzGSL9q+YZi1JMB3EhD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osPjgTqC4dY9YqyJPmBhpfZdM/gvsHdTEuQjkjaSPf8=;
 b=UdNZyf0lGHGBlUNrXEZAmdrUxdcTORJCS1IYf5EPxnTtN/qif5XK2vvmx0n+uw4be08yoYcFvs1JS7oW6nImism2vuiIDaIGMl3i8VR9EJterAx1vu8NxSZIB7CPHyw/snQdEU1aam43YtwhV+KCkk5mIhwI8w+zoJ9DJSnBDVgUlLSrHpMULJpHtqHWkHG9rdIjnqpZoCFerz/G+5W60ZJqVvjLhmrwQcax4PNrKotg7nfKuxAtRUOLxe0n1FMkc8NoVwi9VNb/HpLxQNHOmeYc7jBB+QnrYozgvuyao3IR0st55PiJ0bVZcilKlkl3286lfrD1VlCufha70DrR/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 16:02:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 16:02:49 +0000
Date:   Wed, 12 Apr 2023 13:02:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Slightly optimize irdma_form_ah_cm_frame()
Message-ID: <ZDbWJcqTbCducrUO@nvidia.com>
References: <098e3c397be0436f1867899245ecfe656c472110.1675369386.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098e3c397be0436f1867899245ecfe656c472110.1675369386.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BYAPR11CA0100.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fea878-1b3b-4048-0f8b-08db3b6f5cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6BunGC53EyQuLAunF4iLmjjhJAS/MVKla6HALbAQnT2n7MbMpnTHWAnFeKTFlKmPKevFwAjC6LOkfw4n5gsq5F4UJQa9eWMT0k5xqP4kDZBijvP/xLJWq6aHKMO2/qvWyYCC12a6a/V5MrWAh042z3yyLRLIfOM2GlRkbGlGlk/HLS0xv0jVInOYpWPqf7VEznrSv4aIpKMFeNJau28Ud6b0o97puUIyMW9M5QYZV2f8kCLC1UdFonBC2FrSDOFD4Az6t8fCK9nFuZLvBFZbMJCwnobnnCt8RFsjrDaFh2JDqkS2i2AGX8BjCowggjWE2g2gumOiHausSK6VoQmye2/0wMHUidAWrWk5XjHzSNsx6oMoyya564J1H5AuKBcMCr9CdiaOAUBDXKZeT6xxw2ksHSTrWLPuy5FNAxONKLeP8QEn0IjyAecezcZoXvCeCzFXbK/qB3yvkcbQWsBDU9KzzsMC8NQto3K3wfbrMQdZ6R+7S3vXA01iG7UaMUeaPJkaE5P7uvO5aysj1nXcEShwH/26Zfj4R279aXUv6+Ktw8mhn9zF43rQ5IIeihV1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(6666004)(8936002)(6486002)(5660300002)(86362001)(8676002)(66476007)(66946007)(4326008)(66556008)(478600001)(38100700002)(110136005)(54906003)(2906002)(6512007)(83380400001)(6506007)(2616005)(186003)(316002)(36756003)(41300700001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WtS9lEWireQZ73iSFMkiVztFqHn1iQl/EnDmIBIdRmTHoDoPXZ5awdxl3VRi?=
 =?us-ascii?Q?ReVghe7nmM69IuRKbjBplktNgzadoMBhOT6xoYCfSCSKOUiJxe+QEDTx2Loh?=
 =?us-ascii?Q?8hovXyCe8aysFeWdTa9KGpoc6sMH7ZkJXgK3AM1JGgJWqLVBjwiFnFmbwzun?=
 =?us-ascii?Q?hH8i5ZbU1uJ2C1T/LxtsK5q0+JApiP2CxdSj7ZILDGKMY9hcEj9Oz8ttgzgn?=
 =?us-ascii?Q?ksFRXxOIvVySjEnvxik1KeSuwGXZ7cWJljYTGaR+bWK1MQ9UUgIy5VrJG/Ri?=
 =?us-ascii?Q?2QVX4BI9bJT3Kmrlq8cwKf3Aub38fsai2ern5IOi94NXyMmWgzNYLGs/NQZR?=
 =?us-ascii?Q?wNVvOryp+wevgrj5nFV0RYStCV+Ey97BA3+Fla+NEtu51sFqB3YDIfA37uSF?=
 =?us-ascii?Q?stu51/Mt+QmDDJLE86pzk3ZOLug4mjliOCmBA7NG1Zk/24GEC65j0xVhM4PZ?=
 =?us-ascii?Q?S1+jozol6IA+xNHkjnepgewVjSNgKr8Gp+0lDITV7P+PaFqdzjUaDLCuc08m?=
 =?us-ascii?Q?1pgkVFh2G2gykvSWOJagdLmfwQ/G0833CBzZOwxUcZcpnsUU5++dCUU00Ipl?=
 =?us-ascii?Q?CvtsYzHmKjrrLOGeTOXykHastXQf4qNx/wjTEeC4Ht7eij9pcICbViuRKHCy?=
 =?us-ascii?Q?tgG+k9RCHHHuL+6Hdi3PvQ61XOrPVY9Fuplgbw1TuKxQ7IwI3HV6I3Mec3sZ?=
 =?us-ascii?Q?kplxELe6YeIkPr2OLYHKtylCzbEtWpZO+s4IX8+XRF6/8YvCoQhM6E+sAC2E?=
 =?us-ascii?Q?nkXBZ/H+Uf8xRb8BqVxtZM+iHr7ptD+Z3MISH3EJKKq3IJvPT/sklrX59FKd?=
 =?us-ascii?Q?JPkLI2nzroc/jJIZLpjk63+PRxXHSr7EtgZdz/iVkeZv6r5BzTC5qVZCXp+B?=
 =?us-ascii?Q?4LA/Ea8nhKuQD+ufJNyAuqJEgyClo21czx3hl6yxIW3OoImGMhB5LTTaSe7H?=
 =?us-ascii?Q?kB5zN8eFVwFWyGwxr0V7lSUfbuwJ2Ev/tEujn+x9HYFpLc/ZfTxiVJE2LM4w?=
 =?us-ascii?Q?qrWqDM46tZnPwuogPB6iKzn2XXGfIQDlcqy+WeDG4SkFGUidzOVx/j6Zg/Di?=
 =?us-ascii?Q?mJMdBldiE1gyZgTFddYy8J1Syy/Y7AVGTVvvj3rfxC574KLKmb7HOrjY2IYp?=
 =?us-ascii?Q?nJfrS4mAJCU2xRGz5ioZS2tXOMkzC0lGL4tKetKYp4/vOuCA4Mdu+xdKE8d5?=
 =?us-ascii?Q?t/vhpoKAyb6N6wlJ/DREAeLOndhrpmi4RzR3nDW19yi3qQtYAGuRkzFRBLj4?=
 =?us-ascii?Q?Qp6XyhGwtuUvjlumNqTWt3brEChYak8N0zQxgGkZ306D6pJvY4LLtjGQeUrM?=
 =?us-ascii?Q?/dM36vIVSNSNDAedzMIoL8z2V5pGduKPhYv/2//CM0orw/B3rW6nVP8QbJpR?=
 =?us-ascii?Q?gXmY7UA9TyyllX5XmyaTfhy7yhS8jXNku4M7FTLjhF53D7i4zCQOprKGstly?=
 =?us-ascii?Q?ZjSUJ/K8toR5Dv0WZOxNK9KVpOMSlYMxYnytoLzBqDpb5zsdC95Gq7bxCHrR?=
 =?us-ascii?Q?lA/vvbryhkszwFx2qCaTiusdxUufKN6GbSmprkztxjw/AVHMU5M/VTcHccpm?=
 =?us-ascii?Q?eooeFXdAAz93WVRKE7Dzq+0dPLk74sB2/CQFT+4j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fea878-1b3b-4048-0f8b-08db3b6f5cc8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:02:49.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mab/wJt6hJokOfjuDfbdpKHwZTbvZ5Po3y1/r9f4O8bkEo8hnqImHrPPlzZo/6aQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 02, 2023 at 09:23:24PM +0100, Christophe JAILLET wrote:
> There is no need to zero 'pktsize' bytes of 'buf', only the header needs
> to be cleared, to be safe.
> All the other bytes are already written with some memcpy() at the end of
> the function.
> 
> Doing so also gives the opportunity to the compiler to avoid the memset()
> call. It can be inlined now that the length is known as compile time.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Just in case, here is the diff of what is generated by gcc 11.3.0 before
> and after the patch.
> 
>  .L736:
> -# drivers/infiniband/hw/irdma/cm.c:340: 	memset(buf, 0, pktsize);
> +# drivers/infiniband/hw/irdma/cm.c:340: 	memset(buf, 0, sizeof(*tcph));
>  	call	__sanitizer_cov_trace_pc	#
> -	xorl	%esi, %esi	#
> -	movzwl	%r13w, %edx	# _194, __fortify_size
> -	movq	%rbp, %rdi	# buf,
> -	call	memset	#
> -	leaq	104(%r12), %rax	#, _259
> +	movl	$0, 16(%rbp)	#, MEM <char[1:20]> [(void *)buf_114]
> +	leaq	104(%r12), %rax	#, _295
> +# drivers/infiniband/hw/irdma/cm.c:342: 	sqbuf->totallen = pktsize;
> +	movzwl	%r13w, %r13d	# _192, _192
> +# drivers/infiniband/hw/irdma/cm.c:340: 	memset(buf, 0, sizeof(*tcph));
> +	movq	$0, 0(%rbp)	#, MEM <char[1:20]> [(void *)buf_114]
> +# drivers/infiniband/hw/irdma/cm.c:342: 	sqbuf->totallen = pktsize;
> +	movq	%rax, %rdi	# _295,
> +# drivers/infiniband/hw/irdma/cm.c:340: 	memset(buf, 0, sizeof(*tcph));
> +	movq	$0, 8(%rbp)	#, MEM <char[1:20]> [(void *)buf_114]
> +	movq	%rax, 64(%rsp)	# _295, %sfp
>  # drivers/infiniband/hw/irdma/cm.c:342: 	sqbuf->totallen = pktsize;
> ---
>  drivers/infiniband/hw/irdma/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Shiraz??

Jason
