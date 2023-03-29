Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102716CF6C3
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 01:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjC2XQ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 19:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2XQ0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 19:16:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EAA3596
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 16:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRmd9qE4evQW5zUygXoTGfNlCWTLtsZidABzgf2ApFBC5YLt0OhbWtNSi0XMQF2H33oKvH/EqXQ+Z17L5PEdEmAYdlx6hbfAB86QZOtDbvbIfHxhuV6RGlWYPS/HxrCSTDffLnsTZaVBjvVFJZJPdEsZex4bxsjlYRuzMrR/djUiORKzN3BeWOoz0l0bQJqA6LRWikhIjvQt8HsQmKSYbEKsH/nTp5nglRP6qI6gcdnsE5ZjJJfS/Tm687QmFMqYBewbfywqaBZylE3rLMPRwSIO3TZnoQFfY1DJRFKG1zZ5SR53AwoiH6/kY2vodUZp/XMMqt6NWcQBRhOSSRX3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgCg+MnozKNLSNAiNRV81epcSkJtW5KEVDfz+T3LO9I=;
 b=NwZu75SSPNJpLOHeq8v6+Iyoal/ySYC5pXvjaGm8WbWxNbeHrgZeMnl1zk5d+EB6+wt+cX5h1pEudcSMsEQ+49bS+MkZP4LH1Sp38eGq6ozY6ReTNd6sKX96t9+C2grSfksBfyGewngxTqHJvw5fyDmelsOJMrIdcIVPIkTRdsdhM5LfK5rEhKc925dt8+smz2ux2IqkyQrV1RxaWS5Mj6kTMqfCkjP7FekkNKbCW+exKIusLVIHu/JhxlGEt9AUGYYW5dDjMYrG1RHQu7pkQ+bebqaPwUxZ+KdU/T2bFlmfT/ZwbiR1AVapYMaXPlP/RtsOGtgFvaq/cajZGPxzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgCg+MnozKNLSNAiNRV81epcSkJtW5KEVDfz+T3LO9I=;
 b=Zjugp5jFKHQHqGJiKg8AcgMhv47UPwRihsAwvAikjHuCY7x2XfSrpBC59ReIMEWBMBXchiuxz+luq0fAszBIH7Q3r04IW2s/tjVTVIu0tipFnyNuA41IUWKiW/SxfoxS46RKJwjtMs6y/1iRI+KZFrCHt61Hx+MEn2D9jyv4IqqkoeCRKs4bW+E5oNQY9ghel08PwXxlkjce4iY7sCC6v3tnDsCA1apxwL45C36IvM3RDNnKTRVkc67yJmBFVk6N6PWhgk51zhglQgOT1hq4GdLS3nvIT0BP9ZLtJsVPFBmgJdRJ0vy7Lm2077kOdZ8JjXymq2KbGGalJ6hVvt4vxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 23:16:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:16:20 +0000
Date:   Wed, 29 Mar 2023 20:16:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Pass a pointer to virt_to_page()
Message-ID: <ZCTGw3+9rYQAmlJS@nvidia.com>
References: <20230324103252.712107-1-linus.walleij@linaro.org>
 <ZB2s3GeaN/FBpR5K@nvidia.com>
 <CACRpkdYTynQS3XwW8j_vamb7wcRwu0Ji1ZZ-HDDs0wQQy4SRzA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYTynQS3XwW8j_vamb7wcRwu0Ji1ZZ-HDDs0wQQy4SRzA@mail.gmail.com>
X-ClientProxiedBy: BL0PR0102CA0017.prod.exchangelabs.com
 (2603:10b6:207:18::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b68c20-97f0-44be-358f-08db30ab9b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LvXtpLQ6FMf6w7G/+xMi+VaV3Dpv+o89fhUVM3dDtg5euvGNLYpCPVJm9Tk30yn7RZNE5h/nXhnJuI5bihsZr15dqJDmVEUCG+ul702VAjC/13q/92YEF2FZbMXo7f8MNQQhSiN3lYIFIK3YZ74KqmiaGvglzjX4KIutdDlswZscPWiBdBlTbguQIS/3MfUU1Ji/5SCzGlCPockwdMU+3NOLcmrm2ol87SmKt/XGIM+mzw+LEBcoQs6p9tZaNLDfoSn4cWa3wEh3xBZ/24dLtE77p7JAUF+8HVACCal/OqpgpIgXBVcsfKZ4r2sOKe1Bgi8yUzrxbju+oh/vmCO2DaoN+tbvuSpqpadaniLrmUxx++OEz0hAWVxdFfBWiHoAqnzuRphzIt1iFvZrJT3tGqTqgZ/LGMU2g0YWnvd45xw3w+MyxkazzV9DkyWUKtTMTLbWk2ZKHc2tFHgqpp5ksncO/NLuc+SaGQ+y8fin7sLH3FnIsAxyf5v4EaFjmxo3lwVatHLhMssoueFD5RGLpXEN5NFQHLgnnED4vhUHMMsWgS6kpLC5X1tbDlWwYGIcxaGyEfK+9eucVy+LoanVIJvc/NqZQ0xpaJmVL/vnXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(6486002)(478600001)(54906003)(26005)(6512007)(6506007)(4326008)(2616005)(4744005)(8936002)(5660300002)(41300700001)(186003)(2906002)(86362001)(316002)(38100700002)(6916009)(66946007)(8676002)(66556008)(66476007)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2FvsNHMrCsaaENKBERrue3x+jsfgXuzviVzchJOnmdmf8eYq5eZJW828wWFn?=
 =?us-ascii?Q?pDHrkVWS3ZBkMA9ojAd2hnU5m/AZqJN/5OWsKCEpMyyx3U+MkSBUbMaXq1XX?=
 =?us-ascii?Q?5+dynmVFbeLHfUgz/4o3LA5mN2ox3r4AC2S5KQkayXgrJlSv/8s1sBROhBeM?=
 =?us-ascii?Q?Alni9QDPMJ9Ft58TjuezjVr6FGK8VAJpy+/kcZFI5EdKuUh+XjnSe4wFyk/K?=
 =?us-ascii?Q?Sa0VJ0MXYJKAbjoLAlaA5FsUi4AWFqT0nepNCdROTA0NP1TbTEQ3xA1zvf5s?=
 =?us-ascii?Q?MVF2SFn3SVvdYGJ6Oj/Nnc7TAP7dvybTYArWqesp/AMvtnA74OLhoiQpAj01?=
 =?us-ascii?Q?bfWUpSl+7CHOLapNI+XBEu0hd2hzA3RlZ4GgG7xP9T3Mzant1y5WtMY+xCIV?=
 =?us-ascii?Q?9sKPCi/wuFTDInt/wKUdSH2oS7zmRuAnf70GFN0uxx5o/UN/Cq6HpHSho6LH?=
 =?us-ascii?Q?nZRZhWHI+hd3UkaAWtdj+gCC0/BVlTVTKDJ9dJxiAS3cVNGpjVT87sZMxvJM?=
 =?us-ascii?Q?hApHEfR0iHCuHMiGhB6wCXoZ+Vj+lDvasVFM1U/Zv70fG/topOWvKsaPQmj7?=
 =?us-ascii?Q?J7Gb7x3nkoZc5y203XD0jMEbP0iyy8fOhj2fzS6RVrNMLsXAHCpBJLPMspx/?=
 =?us-ascii?Q?3hKNRxYVnXkzbdSawSgzolrt5UNbsWBNACprod0mDA5irqfjCh+AliCLXYPK?=
 =?us-ascii?Q?JVth+HJCFYLFqCGMeJ3Sl+zJQczRjLMRjfXMDyd23/MBoZLBNxwEYIGNqWUi?=
 =?us-ascii?Q?t+IfmlDake/DhV48YMn69wf24ieqBEOP0C5ECN3M240rTdVD5sYlkARthbrX?=
 =?us-ascii?Q?oVyYJWRbe83bNn7j2PNSQGlf0ePlFKnRypwHM9lbZfVA7yEvUMZnE4UQ91hH?=
 =?us-ascii?Q?hX3RfjQo4jRsebj8hB5qJP46jGNj1ZeQMR35270SJpBterJAj1g4dqx9RQaZ?=
 =?us-ascii?Q?iVI2r7lURNK9EPlbgRXUTEtV7HvRkMRVi6eUcE3ZUz0C3Irq1RPUHT0adK3c?=
 =?us-ascii?Q?5hgzv0cuUSgapL7yYo/2Vbpo3UcxyDT1meunkVA8tYQ1ybW+ckr2ntoZYaj9?=
 =?us-ascii?Q?Af016v+MTNjs55R9JEZPTB7vkBC/axVGeCJmceEyXJgQIH6eIxLzsOwNSd87?=
 =?us-ascii?Q?1uhy1rMPbT0gE51a4Opduh0/SeOHPRolbB8uCD7LUZWC2TPv6EU/jYzzgYh/?=
 =?us-ascii?Q?az1gKi2whCwoeBEnux5Ijbc1VrXiYADqUgGa3snHOs6b2P69xbuBaKIcgvp+?=
 =?us-ascii?Q?xfk+hze3MFWRS8UpH+44AkLnsXZPSPx63dOmIv/56E0RCvPeBF0Cu+IhPvdk?=
 =?us-ascii?Q?SQD02iAHUEW1wxe4dO6IKLZuPIsfWNeY/v/v6PgnFNSIYhTRz9xZcklj9VH8?=
 =?us-ascii?Q?YOnv5x/j8v35RdwrYELVQyJ5SWeZ88wlYP7NdZuXpX9QXrkx/HvDKYAhPQoV?=
 =?us-ascii?Q?L6e5BYUUo+ZmUKnE30xjBlrMdxT50fbYyrB2/sTAGgNYGvJdUoyfvBlbOK9X?=
 =?us-ascii?Q?9AqN79r6y0hgkdu8V4Sg5/hYQsgTMnJGWXLXuil3opVkGyK6PedCZ22L+Qih?=
 =?us-ascii?Q?YYNdKBmxUfNB8E/Pc3IkzogUnt8mEPOKNQxFOz4/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b68c20-97f0-44be-358f-08db30ab9b07
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:16:20.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quFjl2EIcnO+8hkbNwcP7LWIfz6pnYcZM2zzjmvZ/5wMaOvOLrtMzVRoqSCz1P36
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 29, 2023 at 04:28:08PM +0200, Linus Walleij wrote:

> I'm a bit puzzled: could the above code (which exist in
> three instances in the driver) even work as it is? Or is it not used?
> Or is there some failover from DMA to something else that is constantly
> happening?

The physical address dma type IB_MR_TYPE_DMA is rarely used and maybe
nobody ever tested it, at least in a configuration where kva != pa

Then again, maybe I got it wrong and it is still a kva in this case
because it is still ultimately DMA mapped when using IB_MR_TYPE_DMA?

Bob?

Jason
