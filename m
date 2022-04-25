Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D7750E9C7
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 21:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245066AbiDYTzk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 15:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245059AbiDYTzd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 15:55:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A326443C5;
        Mon, 25 Apr 2022 12:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSDKATDbnsUQPifRaItmTrZWDappy0GFsXPKTKf7VzNj7nrcJM6pv8pXWmX6gJno6Bgot+KMbj5ZHbCpp7k95Pb257DwZ4iUagRuVZmoWLtwbF6Kv2yc5U/Yp51zgsCuLPw2b0J8sAQde/Th1DPXG2o1vm6/4uzZ8Y4WKx+R1MHTcg3F8vIVIv571cU14PSjkNX6i0sRg4k02qBa5NNMlpjQ1Et0F59J3vNWFbvIXTTXiUHEOO5D7xuMYRtwxQ9DpxOsQbVpXntSoZkJpYqynY+o0+lRpvZFEhxaCVVTQ9ZZxcRu6rIBMiIwCDcmFOvLyJ7Fla2/mrv7fe4xp6xoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvveR0FLcr0/d2v7m5D9XSyJbEwMY0hl5pSxZfvyeGI=;
 b=Xjo5KepiIaQ77FLj73/9I6unrUVsfdIhzgwcZUJAoQbVnP2xAoAxzYG45WC1I9AwkmzPu7fPiivGt3rPkbNTrGHVKa5XnQ/9t7AqAsS5Y3Gt5/xfJb8ZcsbjncrieWq3UKmKtAM0RDzr+d4wVrgUjtKKVkC2wqotnuKpeVCjGOY99nSiFFUkJJ+eXIlmFMbKHOnlug/fn3oImVGhOdH1uv3ev0L1vcHQCTweXc1XLv4jrQm2LjpAHbQ672BvhtBGW/23PFcazCRDdl+0S0xrrTRgB1/kWbfD1YdcTHCzrRE2RHt0aeDGJfi/tAnHhgi+TT7wEwC9XlPBHkbbAdtoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvveR0FLcr0/d2v7m5D9XSyJbEwMY0hl5pSxZfvyeGI=;
 b=KG77bdOhtWkGruJS5D7sa0WHe1KD3bKcjj3nhP/cUeVjeH2yvMfjxpXx+bCLaSsFhEkps6f1EZhuso3YnUQOqv0Gr1YpwzrsFIDhYDuv5THzzFOCSrRPnRk+Mb3sTN73t2uvWThrwuSRxssYE/rQ0wXqcWl1DxOVN8gJ9feMcyHrtW52+RkReLwvxTKpIczkJOO3OKlU73sUdK/TS8CfjFMBNCLv0dw4nsmYkZhIho8Tj5/GL6UTy3UbUSkp9rNq53OLiUhmhna0L+RGjjDRic9cdxupMPhhBU1HdIUST7Q9Ou+qHtiWPARylD9/StXGposqSEGn4pDVfIPTjNU5tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1636.namprd12.prod.outlook.com (2603:10b6:405:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 19:52:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 19:52:23 +0000
Date:   Mon, 25 Apr 2022 16:52:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] RDMA/rxe: Remove useless parameters for
 update_state()
Message-ID: <20220425195222.GA2255698@nvidia.com>
References: <20220412022903.574238-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412022903.574238-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:208:178::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35ff0c85-3d75-4bd7-86e7-08da26f51d9e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1636:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1636C7BBF313BBB85F0F0FEEC2F89@BN6PR12MB1636.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6W40XH5OVDdQR9/RXIBR9DTAjZCYmP5kLbNxyXVXd9yfhuL+f5UcMLos5nvjlSji3KpNPMTDkaG2BIVn1W9HCYZ/BTsa21YEl9Q5uXl8EZumCXZqkfXk3kQS4IRsfE2oQrlln39lJT2kwqN0cJHkmtYjUHKaXE2SR/h+O8i/1UZuJdi6bZnE9LFHJh9bjA49i8HYso1HcH9A/EMX42Z61fcKrtEs8J2YhNia/yh+xGlA1Mv+2v2a74va4fwKVAe/u2c3sGOpw+dCeQ1qeh61RB6HFV8ER+EeFss+w9s05NvaaHqyXmBknoFdbVDbDXzvpBhlL8shbGWxSaRP1M6CnY+xmVzWLpP85Ul7eAgFE0Af1yOg639r6cCHpIjNxEAIIahjbwM0598zz7Yy871r+5MY6W96RjvPsLNhJnKqWYaiV/aSCKk0bv82IGWkCZqqGPqB8Nej6KF10WG9MdRZP4eJ1a5rEUPfklF8+9W650PNsa3P5yBrkJnvogzEoB+GIrI4ahIDDjhCEWrve4yOoJtGVO16yNg6oEmHDD4zKRJDTwYi2IAEwWjRoDohaFOEAm72O7IiT/wY5aipWrxVxQSl4zDrdX4M+U9LepIwMaUbtVcCnzvNQLeCo8/u/hsUS6FSvnAmPFWiii4FpIzyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(6916009)(6512007)(26005)(86362001)(508600001)(38100700002)(83380400001)(6506007)(2616005)(1076003)(186003)(4744005)(2906002)(8936002)(5660300002)(36756003)(15650500001)(66476007)(8676002)(4326008)(33656002)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJrpb0u9qj+4/QbMi7P0NYzQCkrdZl3zNFd7r3b9xwOWPZ3aNSVsGRLGIZHG?=
 =?us-ascii?Q?K4eYweIyt9vXTXxvc5p0krJ7koeP5Qz/fAbhlLm2xtgplDm5sNZCAle4RfbA?=
 =?us-ascii?Q?tEp9utHBiOLtrIQVY0AfcZnDvXq4v0p4jBz4Mbr89Usdmr71dSX1gWlNmupm?=
 =?us-ascii?Q?WiKDi5sqx93E15oiAMPE28Kym6qW8+U17scTAGOquJOo2+ModnrlixNTCaCu?=
 =?us-ascii?Q?mm37ZMGvfV1HwShDy9uXuEDhbiH1z/iW5LqyS6GP+2bDQ8HGefnELKOdJn27?=
 =?us-ascii?Q?ZpkQkb/2Uh1QiMEh+2CEXYQoaGpaEx9vve8h+xttvIphN67Nw6d4x4PgOAcp?=
 =?us-ascii?Q?AJ9/m/0uv0qy6q/+qAhOoD8E5EkxWWz6FYF5O9n4PeA8gtAy+YCsizsPBoMu?=
 =?us-ascii?Q?B9AQCqx/fmnkvHK0DBRz0o9o5evfMPLuIYyyxY10iCcsZY3hkBzygdFwjz/k?=
 =?us-ascii?Q?3+z0p4ut6xFtR08vBNZsiuL/xrnkMiDVzzS8iXfu/vpI5xUweQNYJXg9Ea+U?=
 =?us-ascii?Q?EpHuXkwLvY1TC0TWpvE1SVnJp7bHk0gDLBDckv2OGUz9l2ufOHCTyr1x8Lh0?=
 =?us-ascii?Q?9/Srmb4q9OfW5pQRT7NXT14IPpj+sDr7BYX1tTRdO4eU/4tA/WKLmxNdpmi0?=
 =?us-ascii?Q?cYcmb0WbvhI/6F/pO5+smvK0MyGsMU8XVPlLSn+p4MxItHo3xVV04Zj5Zydv?=
 =?us-ascii?Q?xPI4eJJFYGvNlo7RiZNgDjveAm3nyiw+qnqBlr0uj0B91jOh7cvqe06KBaz1?=
 =?us-ascii?Q?dW2DZBMfo1+hx9sxSwV5QNcRb9qwUZdk/qGSkoHamF+XpSf/QDs4c8uT7x/X?=
 =?us-ascii?Q?Rn9GPHu6QyjvgScAwd5xfKdvndhhpb1+aMkLzRmvLpUK6ZiGImrn+/hE7U+E?=
 =?us-ascii?Q?MxUJTcbxag8YLPCWPBZ67TGibF4kGiAmXK94axkXw9KohuG4dNeNDrlhjhV/?=
 =?us-ascii?Q?u8S/2LO+2opNHLmeloWwfMZJj4EWy3h+yXp65DoxRENkfwjM6HfH3T4QEuXY?=
 =?us-ascii?Q?NAdSg7oXr18YZn9DTy3Sg43LY5kuwEcjAg+/j3CJFGqr962oPhkYCC/rrjHk?=
 =?us-ascii?Q?fmIOq2C97e777mmqZ4vQvX/I4EAzOPsFIzYy0wWfiIcwjGW/9b/yYfdQetdX?=
 =?us-ascii?Q?R6S3RONWLbixIy2CpBBMvnw1lozzJ0oIW5bRZrGU87ltDVxlMoOAW3hn7Wi1?=
 =?us-ascii?Q?HJmFWbFyKVD6P4FJzj+Kr5r6bBkJ+cT75D0yCYITzdga4ozkDsCbJHA829fZ?=
 =?us-ascii?Q?LCa8QklfWs3u6oI3LrdVaODa9QU2yynz+H9iJHKb53Hkyz5CODoFwy84GPuv?=
 =?us-ascii?Q?59CYkkbfPm5gz2NEL6vK9KiLELg/p8TZOt/aKPkAwotDlXiiadXpI1zlGw9S?=
 =?us-ascii?Q?F/6QrDlWxW56DpkZJVelvGYJrMHtnfIO8nZG0vIHhnet4fs0WjKMIFNe1ghL?=
 =?us-ascii?Q?Nr+1Urb7lWilZth9KCGfG6z52/mIrN90tHy5VY+Q9AbYoQxLH8GewplHDRFd?=
 =?us-ascii?Q?+d33jQ47Hs0lDGLgdHu61ZptHYK2Yol3UfZVskWje1SPI288WMMO3ki98g9N?=
 =?us-ascii?Q?+Re648khQM3VOP/n7d5rTjZ6IgW8HxblPy1DJJlwkbfuOb07SK8eHy9QB+P+?=
 =?us-ascii?Q?YjQSQw8utZRzzCAJidch9Vhd+Fy2kzDfliddqnATSz1VXM8MhbIWGh+YiXaT?=
 =?us-ascii?Q?m9FopGdA3xYLrOzigne9WE5Z5+uLpULpPFh56iuO7SCvQhg1fXXwHOYjGP3/?=
 =?us-ascii?Q?jukP73N8PQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ff0c85-3d75-4bd7-86e7-08da26f51d9e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 19:52:23.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0iHV7NgpkptwUPmWSvKYA79D77FoSblINHuZ4IpdXw/gqbnKsqKLMFxJ/leb3Eg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1636
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 12, 2022 at 10:29:01AM +0800, Li Zhijian wrote:
> wqe was not used by update_state() so far.
> 
> aaaf62e06623 ("RDMA/rxe: Remove useless argument for update_state()")
> just did a partial fixes.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

I applied just this patch to for-next

Thanks,
Jason
