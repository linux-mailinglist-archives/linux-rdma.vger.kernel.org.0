Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1758AFAB
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbiHESVJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 14:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiHESVI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 14:21:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9721DF97
        for <linux-rdma@vger.kernel.org>; Fri,  5 Aug 2022 11:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmewiGmwiMg98WTSKwdeJ4hL56ecJVQU6HA7J/ZXMllpAIbMP+Du//GPFkGytfDrqdzhjZeXVaCy4KRDTNn0PRc7OWcnOaJhjeINpqz83RVYhBJBVVrcwXvQlzLRAVeke6TrxowdJ8cKLJcbyF+JN6YkEzN6Tlawm8CLX/WnPt1Ie6p4KoJ2wANFFAWuF4Fl8FJs9yRP1zhgSoIP0VCQ44URzH4f5E4WYZNtwZ8PUz2DFIvwXKNwfLqm1qE1MD2dZu4VY3+Y50AzAZrVlqDdT4/Wn3mC/P+/gTCTcm7+GRV5EtmJYzCRy9gsA8yeG5FllnQInWcy+Vymzn6gF4DCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HEJuFPjPQVVGQRtpBjNzPwhRj2/P2Vlp4zSn3XqtqI=;
 b=KictzwY6YTL7mis6j4zxcq0+qIDQmqDtXixtm9u0zK0i27D7/47tKshHQ0XFjfS/zE7y9x7elL6YOLx0Xj5XhgVInA/TYEsrCJSsSYEmIE0LdlWigk1k7mtDG32+aUIKlUJFG48ngQeLZ1OG1VF8uwaaRZDoio//CgqmLE8HZ1Mgsqg6kJJspzL9mD6/qQ3BavZBS3Vqy1D8Z1i//R7n9/nJ72X4t2Hj6pkspLYgWvjkxt4yY8HFAC80fAoskXqQonAy1Hj7jvlx3F8ZL0hc5ZH4AB3he/YkUo/DVLFhZRoA8xxyKyBM43tyMHxIHMDh7ZFDpDE/ma6YD0JXHm/AZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HEJuFPjPQVVGQRtpBjNzPwhRj2/P2Vlp4zSn3XqtqI=;
 b=QJkpYIg5ZHREiJUpHOWwGUJF13Z+RotxNHdjio3lAtu/h167/8XnZHJypkyuEFQupjp1S8W7+alw/MptfJ46Vg96x+yXCY6cID50jAIsPtJFtpPRtpwrJ1RWx6EwjQSXMYFX5moF6Tgjm/n7IbcVSmHgNE9NfLwnj2P4tK+oH2aAzdf6Yl09pIRAQWnyM6XuOSOYKdppVhQ5gEfDF0hI3rz0Na10hhxKtZu7Vkc5/6C0GeEQbmGIZrgPJF34OK0z4daKkPXDSnoFZ5mX4a/AEWL9Sml7W2mnzPe66AlbMSKoj36UZOkM1zb7ZX7tPeuIhc0m3ECsMTZ7ek0Xlzx4zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 18:21:06 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::1a7:7daa:9230:1372]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::1a7:7daa:9230:1372%7]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 18:21:05 +0000
Date:   Fri, 5 Aug 2022 15:21:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v4 for-next] RDMA/rxe: Fix error paths in MR alloc
 routines
Message-ID: <Yu1fj7KrQ84r7A1y@nvidia.com>
References: <20220804043731.3737-1-rpearsonhpe@gmail.com>
 <5db7d9d6-5c7a-90f6-4848-4e348a0630af@fujitsu.com>
 <cf1c298c-11bb-e072-8f5e-ff4aad4963c2@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf1c298c-11bb-e072-8f5e-ff4aad4963c2@gmail.com>
X-ClientProxiedBy: MN2PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:208:237::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecc7b3d1-e1d6-423b-925a-08da770f42e4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3661:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4NteTIz/lLsvMMi/PV7kyrorkHDiWleXnYOGpat26aR8keRDjuqAk3mh8GR1rXsZHwoqSh9fmqbnpU3wo7ylmMFfmcN5YjfLa2H587eK7605fZ/000FA+q6sNbggyC8ExtX+HXDcChc974uGZastq2FzoLSjE37AxQnCWqRcAODRvBfyc4/yE2K44xY5kMcSO2wux08wNCfH8oIL/R7qa060r2vJ5OqpoTFEpD0V58DKk7uZ63hMc04Oof52oTkraF7NLborWFua4f552JQVGnJmYon71T+2ZLRpfSoQsxLigXruwxot8253CWjj+WKFx49fUlvehNeApgLfR7HPM1CZuC9FSumliA1CaTdAG6XOirCIRyqblWbLkVEaokgIIEUaiTGDVRZWzwEBsUcZQZ9mrrpMrfpEjXEQR9F6le3KbGzUSE7wjR6iX141CkLW0xx6hjAEjP0DsagzW8WgpS6C9oMDDe/te1cSi6TfL8zAkPcZBgJNC5dXR29e7solzXLJGRyITqTLz2bHOgcWgKQy88ayRZQ8cSq4lBclvtZxAY09xrHypoasuj4my2kCk2EvTFctF9EW7sOmpdSbv7mHEEtXCZ/TwCURE6y5fB+j0UMyDQT6n2zQ7kAqm0DvkWjDWd+euVRJYvMnnhVF6A8wbSxLNOMCkOKNNQI19BtzWjnzuqdxnijSsP1IWhPq93yuKt2kdboC6zpOtfnyDJq89Rv9O908ZQ3N3SrMjsM9QEi36QV1U4mbbU6SpqF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(8676002)(4326008)(36756003)(5660300002)(4744005)(66476007)(66556008)(66946007)(478600001)(6486002)(316002)(54906003)(2906002)(6916009)(38100700002)(86362001)(41300700001)(6506007)(53546011)(26005)(6512007)(8936002)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Ut8I25qnxA0xfEkYQn5uiNU4JeeeZHEmnBKgd9QVhhtEddn2GK8ImicjS0s?=
 =?us-ascii?Q?FuUTz00sL9RJMv6kOCI07SM3hwnzYRgy5p0zNH8MwVdJbevRdDjrW9N84a2f?=
 =?us-ascii?Q?AyaCWNH6OJ244DpifL/Y/ONrXYR4txHtixG2TedpgpbaNgMfBvgq8HNxrXdh?=
 =?us-ascii?Q?1Y3o39/LLxaD25CxrU0Gu3fRHSdjyU0ouxVwNrl/00jTIX7z+D5CilWpCGsd?=
 =?us-ascii?Q?KlzDDiNv9Mx6uEDGgADVC0MSn7yWXMKq6x5qyEpZTApbqYUtue1zc7PAkQf2?=
 =?us-ascii?Q?tDdcrCrjlo2s56dmmbxAAZhFdpWiU4WtsIWAz/GLJQmXBwY55jzxfvU0P+2N?=
 =?us-ascii?Q?vasPhfqzA4JTjpYTYtsBQa30WL9BNnVKz8fIOEda1gU0OyYkCaetpU+hn1lI?=
 =?us-ascii?Q?hChyh6wA41gbfPUgPX0jHqIm7EbBoLw8mFQ2X4xXoKnrKvjgbDkn4gg9Tp+W?=
 =?us-ascii?Q?cmJ77m0K2XxqGm+pARNGHV4QrhtQ1qBp2ArPGL0yZSwfxRcWtD34+IrP8oVB?=
 =?us-ascii?Q?dsyaM9pFFjg3i/tnmeqGpiW9CA+dTt25TuJ+hnLae1DAH6YmLcRG+UzVpA6w?=
 =?us-ascii?Q?B1XxcGXF/4zd4LtN8yFzmUMB3Np01U7YbdaZAU0+HEFzF5LtD0eyLkUcOuwB?=
 =?us-ascii?Q?e4/dZWnYHTbEZlZ1AYPCr0ghFgHc2CiPh59b4qmgZWxatneZmxXTapRxE7+C?=
 =?us-ascii?Q?XAz66Z6BTNrf0PtA8GXeFVuK3oVetZApBX1GSj7XVLolJQLckKWoXhjVx/Ln?=
 =?us-ascii?Q?L++Zromg7XsS8JmEuTtoYy4V9uY0pfiU/oPR6rj7xcAMXh5mtSgekkDkUtXX?=
 =?us-ascii?Q?r/jeAh1mKW3s+KoQyH/UB1A3nQ2ieZKKAPV9w0VB3WUvyKSwmXdoPGoL96tU?=
 =?us-ascii?Q?n3Dw4+RJIV57Cyj9D6691OVhh/+1o9OBr8VkTBxvPvAtRtT8/RK4WzQQKHp5?=
 =?us-ascii?Q?O6D1tkHlNBT4PQLvt870/tClgQ8VJYfz9E5O+dHnhIssPirBBYGobUXnadsH?=
 =?us-ascii?Q?Ja2l7LMzHJ4do4sbSbLD9i5J/ZjF2sZwBHFbvKtpvdhfC51BEim/3c+e+V4v?=
 =?us-ascii?Q?v2yjCxCtNG/umZG/tSs92cE6FBrVVRtuCz0tFDaKr3YMBv2mjzKXFUKEoEfn?=
 =?us-ascii?Q?U4vr4x3kkMYPcgs8arTAciTNB8PBqjxnJ8gxT6Kwu5ZC5qQHFQ4cQBZ/m502?=
 =?us-ascii?Q?E6NzDkeNyJ6PeI3aI5QIYgzPtVA+pGqe3kw0iCDNNK/vlbVWNQwWs1c/8ewF?=
 =?us-ascii?Q?W6KB5DmZcuGnu78JrykQM4sb9450p1WUwboOa0uuh1AErs5j/XlMOOAdEmO4?=
 =?us-ascii?Q?MZmA1MeciblmsawjJFqbgSlfczHUm9Tbnd3YL8FjgyL+j3TbeGukLw2XLiUh?=
 =?us-ascii?Q?SZm/IJ0Yan1iIqlzrP/QjaCX0vn5N5UDxg+lpGPVzEBXvvNPouWxpjwQuSdF?=
 =?us-ascii?Q?cT071VXS17Sp/3QYiwCHPT8Bbck6cdEjyMUiDz5IHwOufgjVyT+aD6vSQrPF?=
 =?us-ascii?Q?ulyGc8hZRCADZ6d2EBVb7olbKAMG6tnzhyG6HBmBuU8r8rvUIMsjEzUz3/R9?=
 =?us-ascii?Q?PusjDb+V/P8ucp0Teww/bQiwoJUUUOhGmKmmw//q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc7b3d1-e1d6-423b-925a-08da770f42e4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:21:05.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Xw6jaWbVLVn8bMPgyAgc3CvXRvwS9g3BZ68+zF/dDkV3wjzwtyh+1ok8it2Sf9g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3661
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 05, 2022 at 12:48:32PM -0500, Bob Pearson wrote:
> On 8/5/22 02:08, lizhijian@fujitsu.com wrote:
> > Bob
> > 
> > It does fix the panic.
> > 
> > TBH i'm not a big fan with you patches style, you didn't make the smallest patch.
> > You made a lots of extra cleanups and coding style fixes which is good to me in logical
> > but it make patches massive. that would take people more attention to have a review.
> > 
> > I'd like a smallest fix + extra cleanup if needed, the decision is up to the maintainers :)
> > 
> > 
> > 
> Li,
> 
> OK. I'll split it up. I'm ambivalent on goto's. Some days I like them and some I don't. No logical reason.
> In this particular case I was concerned with making absolutely sure that the cleanups balanced out.
> So I touched all that code in passing. Now that it works. I can reduce the change.

kernel style is goto unwind on error, you should use it freely and
never duplicate error unwind in branches..

Jason
