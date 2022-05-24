Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDAC532C47
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbiEXOa6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 10:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbiEXOaz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 10:30:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522126B08B;
        Tue, 24 May 2022 07:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAtl82ILfuDDch0Miou7UU8bn9HhyDOt0ZCiLcq2wQFL7PK/sRpkmbgSUmoPx+oBxcxegYJZ3kXZZWCerY62cfgAvcYHHICaexEm+wrcLMjX0KnELx53vwDMJ+Lm9hYpZ+Y/8eQH9kQxleXAJrPDWomFRKJvSEAE1jsjqtm0eyQM5VbsaYqLtDHuxsJ0Uxvq3zCd7gOKzr7Oy05kuh8grbcUng2IvH6yIHPGd8xClJoTCFIqV8NPlxHNT9FUWFdf+98S9Hy7ampmy9FuAB9nyCsAI9k0HjtXbnpRPIYyxN1UT03RaCmdtlXwzDLbpomZWZA2SLchrUCYoNIzA8V4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boi7QRaDsQU3/ndd84ImVE6f3DRcerp58DzV+a08Lo8=;
 b=Kztja8c/WVcAVEsVDUVWe/iVXqCg6RbTFuQd/6eYgalrx6RJtUhz+T9Iydl+whQHNKxKbOQIdQNumTEHcRnlVXAOao8QWJPltkreleaU/yVrLyOv+jhu1T53NQP00tmz8+EFHdCssevNZeCVePX5/IWzt2LD/XwUHW1yz/PAIwUcCKCRBL1PWe0WbVx+c1BwAvAVebWt3XF10sUYDTMqwUTY8Ooj//aODFi+ioROGaF9EgdukmGxpWwtiDgbWbxzWkM6SfCkMg06mQuwwPFPYpZ4ES0qFolreJyXC6t2Sv2WtjM2379OgeaizNb5at93c7OKzWG+ncQ68xfAy9jt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boi7QRaDsQU3/ndd84ImVE6f3DRcerp58DzV+a08Lo8=;
 b=ZnHV8EQbfXCiFXnXpUDFsL4rz9D4WtFQafpceeiUcdIBFGLcuyzB/P0bNxKwhkeuXIFwNvHP3CfFuwvJqn7yPpXVantN4gZ+NxSI98r4/5HFSbcq6HEgOTuinDb2+FW+ZiXAwM0haz5tQQVglvwuWNJXegplgi1N5AprsFxGgAXta6oPVTVLdams4nEQpV5DHdtXh/T+URKIBWnncOZsBd/2b++oEew+W68w8JVZB5q3ABsqdieUh4mIzdv/CW800zKPNA0tY1OJxDMUFXkzwFIrSyiNr2H/qY/sXW15guCv1qpam3ixOzdJEGukhKpbOprrMEBjcG0hoKKXNtr9TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 14:30:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 14:30:52 +0000
Date:   Tue, 24 May 2022 11:30:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Sagi Grimberg <sagi@grimberg.me>, kernel-janitors@vger.kernel.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/iser: fix typo in comment
Message-ID: <20220524143050.GA2679903@nvidia.com>
References: <20220521111145.81697-4-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-4-Julia.Lawall@inria.fr>
X-ClientProxiedBy: BL0PR02CA0092.namprd02.prod.outlook.com
 (2603:10b6:208:51::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1c5e976-7fb7-4db7-23c9-08da3d92012e
X-MS-TrafficTypeDiagnostic: PH7PR12MB5997:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB599711F962BF6C7E2D5A1F32C2D79@PH7PR12MB5997.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSJ+o4/jC+429hn+iKF5nt2/LIU0RJicvxm6ncBpOhRfNjhAEqXzvj8UZKXNva0c9yJmF4LOzmyDkNFLIX/R/YYr/Hnzd7raUd9xDeILn0yIf6qWtMbMpTkSJLLlE9tntqjernNmnxwXpwoehHjFum13sbNcWwPOo4hwKbmrL00S5xsUZzcDTBl6iIuaONEXwSsdSb6WkzwXRIuuZ5PTy2qcP3JQ3+VZo1XZU6Cd0Eg70E5ntYBJe99S/xCw9Yrdgs9CY3oskjkXyS/mKTKEJoaH7QkZvUDKBazGEzbTqflMhIIP8Ze56vafk/4vfcGwtR09ZT5y9f3mTztHWOP5aclT9gnRbW1W3YbpTfkiRA8JR6iOOOnuqZmQxKDG8aMEhueASPzqFAK/RCiZAIXFEPb+B89Ttu5yey6+S4nPh/X6h57YRfy+NH+cnPIvmtxHyFLAZWv1Dj3OvaJ0evaTNDgxHSgxyhijJIc9bNhHW67uodhKBPfyv8LmPXfWEFMBIjRPMa/thqMl2fgR7PkAqOkjj/Hca2TormkYrD0EXIl+edAaU/vSFKk4+84IuUTPEjAo5Wc64zu+PD0kSU21H7j2b0T4GayCqERN8OTrRQYABA6MjNyW+gZxcsULPw31OvknOZfYycBtBCb1lO45qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(66476007)(6486002)(54906003)(1076003)(508600001)(66556008)(6916009)(66946007)(2906002)(5660300002)(4326008)(26005)(8676002)(186003)(316002)(38100700002)(83380400001)(33656002)(6506007)(6512007)(8936002)(4744005)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rwvfcXtj4we+DYzSwn1s3Zi4IIm3icPeUWrxuwA8w6oBzjnZQpaJvR02+rRo?=
 =?us-ascii?Q?g6wNTspkVJo0GxCqvykiC2O1G9OLDT/iaFrhGOoqhuC0Q2lY1OLxfJxBR0lM?=
 =?us-ascii?Q?syUisyGDsogBj1UA3Zk3CZ6WRzL2KkTxq4S8oCGbow91rDEbsNylv9fxJ9Fi?=
 =?us-ascii?Q?nX1PjPVK/bC7bGF8Ck2PcBNMcxC+kYN4sWUHFL/BrrFFrmDG89NPevsP2gIX?=
 =?us-ascii?Q?zonNu/ZrOzIEc08YHAsm22h9DNOoqN4mgLjwvoDVMg7/qTU3hPK5QD98a0RL?=
 =?us-ascii?Q?BDesxaQw9CILqklEW0Pq5rmzIZsXjl8h84HrLKgtyihciNR/UpcnERKBTeuO?=
 =?us-ascii?Q?C509Dvt+YhkkPnUz8oj2vMDwR696iZqeADqgJjYEgRu1l/VltkkrV3PkYpG3?=
 =?us-ascii?Q?bHskBacXo6ir/21183AHgLYJOkfPpaMjv8OqRUUKqLPtL6IumMZW7t1eHFs9?=
 =?us-ascii?Q?dFHp8c6/GUOxtHHhKyS3ROOB1CZoO6vmOcXN5tzo3xg09nJiOW52AyB0U7dO?=
 =?us-ascii?Q?LwRlNjM42rCokElGPDj8LAn7tlhfhkKznJdJmMmjJ9Fd0UORXgR4lmEb6JMu?=
 =?us-ascii?Q?uzo7nMGs+OfTe39oHVI3Ba5kBHTY6iLsY6knSCulx4szZoQtfLDOl+8+TR8D?=
 =?us-ascii?Q?v22fVfvDUDZJ6RA/2Qdftd84V5r5B2R5qnryvORxSCYZIhEjkdHC6q1uj259?=
 =?us-ascii?Q?duaprI6EaLDwApja2mkxDoxjdgJUpvs6vv4DmBUWgEOudo+WAN2GxOb2z8Bm?=
 =?us-ascii?Q?O/oyIAdSlUj60/ift0HDVwGgoid/0GVxv6z90EOAQ3UBVPMfv5q8ymVg+A6B?=
 =?us-ascii?Q?veKW9UxnhStp0BxhAtSVOCkoNvuqT8PEPt7ajhI5X28RiXgGV8o3iJ/pX+hW?=
 =?us-ascii?Q?MbXaeadvLn4xHgAn1wxNNNXnhcCmhE2K2D9q2V+KBDYU0Wokeb/gbFNg5/HM?=
 =?us-ascii?Q?8Fs1Nx1oB1yAJoK+kenJz1bVBt1Xn3sSDJBrTsVIpu0Amnwm7Q62yM0/g4+g?=
 =?us-ascii?Q?O4Sp6OPA5kxy+f9z5dVsvK9lXuIS/lhCIuuYk5YsNUOkXuaYv3cZAMEL02x7?=
 =?us-ascii?Q?B44fL30JKIJy3M9CpTYeuSB9aOhymV7T8o+Dy9yYwCBA0Fboojls8tG1zLUy?=
 =?us-ascii?Q?rg6MyEd6X6FM8GmoTRTl2xZBIk0zjJ2wMY+m55erYLhxG4OfsFwVrW++bWjJ?=
 =?us-ascii?Q?YsrGtpycLR0Trbptg/6NO8NyTwmB77a9qxfp/LFGpPK51ImdQjBgeJzLoJeC?=
 =?us-ascii?Q?X4qpYEeZgMgwQ5lYkvVevRt/pfoB0z6fHWW5uaixPFWje7Ie2Mpeoz6d1lmp?=
 =?us-ascii?Q?MUAqOsYlpios7BsIXuhj6F82rWkc8igwIqRE7mIqqCFXLLoEvYoKW2hlmlAK?=
 =?us-ascii?Q?wa2wW0Gd/83js3c8jLr7EU23r144wUu+YGsHa9SzLsfy2HJQCqFbJO0ubLyO?=
 =?us-ascii?Q?yMyL1jgf4fkrL2lrPcg1CW6rSywrIQR+3MRy3mpm5kRHhaUwpVGIfvrXcaVd?=
 =?us-ascii?Q?Ph7FfxlQuvdqLmyYghCeY+MCZvYMg274yj1Ngy2Vom6raIhRsB7Vmi+6UnjY?=
 =?us-ascii?Q?BHA5eDBcuhQbXVxhXHmg8FJ+attLNTmq6+kn7A3cOYvBG1NLXlSGMkFi2QVp?=
 =?us-ascii?Q?GTApvCCluPDrono5S0aQYKpPllD+mnGxileMdJBj2L74WP3GxO6gWctcC6iX?=
 =?us-ascii?Q?DpPdgtL+bqYUe4MJayM1Z+km6nr83/+pALDJIRpaO7ar7YO7WBNnn1R7lwvm?=
 =?us-ascii?Q?bpdozAFneA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c5e976-7fb7-4db7-23c9-08da3d92012e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 14:30:52.2229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaBbktUPXicLONmJREFV9wBViWYUcGNT+qqEjj9ThPEk4rZ8UQO02QCtu6cS+Hzo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 21, 2022 at 01:10:14PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/infiniband/ulp/iser/iscsi_iser.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Json
