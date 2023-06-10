Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C6672AB57
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Jun 2023 14:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjFJMFP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Jun 2023 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjFJMFO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 10 Jun 2023 08:05:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FBAF0
        for <linux-rdma@vger.kernel.org>; Sat, 10 Jun 2023 05:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1YEE2d60kicUBBKdnbBJZdSV7fWmgbD3/AfoLh+98Uei1B3fBlbUSmrer4WS1/xAf2QHiMfCY/QY9sAk/LWuY1X/HX2W4w/82ZUjZkMsFnOpysl2xqX6slSytH7zKStmJHXM8L0p2HFTbgmbEje6Zj06N1cshXiBJtQaidSilg3HW9EW5p2PDpmVn9bL4cmhyuKXk7Kgn6iYDYw2euW7MDgiq0ze7jJAanNfjcMCOtppGBRyoTJ6lcbVSQO1lqNIP51Sfy+bxazLPvEIpPGr3CUuhiQGzm+Xos3ehzLGyWEdlOiod1nKfHwOugRSuh8QucPHJ4oZQkBbx2qTxwkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVOq97ETKLDJRzIiwo93I4bOMmc2MWSZiJ4QfDIQ9ek=;
 b=eYsyc3WS+fjW76z+2T5+Ko1Cf2nYsKW+bbRXwOYMn7V4FH52O12+SqlACrWsipGo/0JXIBa8ERipQwmlPRmU1oMeFGzqFMeurD4g3mWN8AI/uZM1vo6/FfAWHYHXhK8hgnxlV2lfllCIGTGttG2dfsUfzh1LGdoty17gaNotK80f9I1bWhJzw54nyjNmcfZgUUuIz3rxbYRFFOtiaoD6X0hRjU816yxi0yv6NEBCEucCwYMScRMQWTmdTBj6VbC+U8LRY8G2k/ryxMyh94YaVwG4nJEeP7u8gH1GZXq6k1zFJw1O5l/MK4hHngUTi8GCx+O9OZ3nM4U0C4hL1Ne3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVOq97ETKLDJRzIiwo93I4bOMmc2MWSZiJ4QfDIQ9ek=;
 b=TmOZc9SpWpIZ+hz+mFF07miHRY6JyQe4+pdVicd0n6kzvGGXnO+47+s3LCzuK3lkgkTJk6J09goYGaCiaC2Ptyrv+wgR1VGuDfJuBivNK2DjibdYGtYidcTh6MEkOWFP/QPLOdmSH+5mOjywfV6tg2p8x0Z+hjMNjD0q0gIq5OulGgI+5JMEVuthx/Uca0yzC541rKuLbg2DcZy7Z4H7VD8h4REu7TKFIDCbls98654W+VHrxv3FLF6FQhhP7rAma5OKB8T5yVE0nygS9ODcKNZpchz5rUF5df4xCAZXTY7lBi/5qMiszkueKziCfVX/oJ8ZkOpWyndaDDnwsy4zfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Sat, 10 Jun
 2023 12:05:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 12:05:11 +0000
Date:   Sat, 10 Jun 2023 09:05:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tom Talpey <tom@talpey.com>
Cc:     Chuck Lever <cel@kernel.org>, BMT@zurich.ibm.com,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
Message-ID: <ZIRm9s9xjq3ioKtQ@nvidia.com>
References: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
 <dd9f65ab-d54f-7830-8043-57ea66c76149@talpey.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd9f65ab-d54f-7830-8043-57ea66c76149@talpey.com>
X-ClientProxiedBy: BL1PR13CA0312.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 551aa96a-bcbe-4d20-aafa-08db69aaf133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bp7lDFZ9ZVG2mG6RmK9FqRZ0zzDqo2Bvxd5oBN+TudICT0XIEvPjgyfqeNWCEJYyTtqjl9vFZc/rODV80e7taX0zjbdwhynIeGkBZOR/NYfkQcbIEZCr/uVkPxvV1qofXiZyMTbMzYrjh9ytpgiyxPZh4F+9BuPDVDvVXMviFsPyz59Nx6+PHORX22EW+/2diPYyYEi5+ytfjNBn73hh4E9Mmhp61uwQMScCrW1kiTBiqvzbkpoVnV1WtvQqYKUiebcDxzHtNTfPIUoKXTmf2iToQSLudLgfxuGvDwHmWLRqbaG+i8TEpchgJVOHUsdDLM07zJLmyE24RgoI4xRRL0bBGdDYVQQ0OkB8DSKYvdGZ+w3NUUIuTd5PAvFafnDBNDDYbI/lnJUONsW+HcxRCXnRiIU+//YYSyMQ0MD+ZspD1V1m8P4ZVkXeYd1CBnhqbcnRPw465wWuuTXt8sc082uR/OKB3GaRgeZ6br7c1t/LTUiKZJsl5rF+nbvFHAzO1xdk8T2lgGFfut4wdxRPBytk3IMJMAuyoX3+YB+yyXtIFHSHsA4ZUlDKjAa0C+Fd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(54906003)(478600001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(66476007)(4326008)(66946007)(316002)(6916009)(66556008)(186003)(41300700001)(38100700002)(53546011)(6506007)(6512007)(26005)(6486002)(66899021)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ziq8ShVYAqo8k3ocM+QvN6r/RSIRKU6hfjUsE6Mxy/0Iw8us3cK45psGIA9R?=
 =?us-ascii?Q?Pbd7gdjNLjuXCQBxSi+qV0OpRuPmihZK5JTAyMBIjKMGyD5Ed1mA/A/rqoh2?=
 =?us-ascii?Q?4yaag5AZiuVbBAlShwe07AIkvGfwvVszUa8wxYn5c4a8ieZrDzfv2yKxzY6A?=
 =?us-ascii?Q?1SEtmvSJ5E8mmvs9xC6oEQDPzQ9ELsQmzd5h4KXURTUB3ww4uM08mFzEbS8p?=
 =?us-ascii?Q?wZPkN7El93BVKPNTIZpPKSykK+2+2xI/TGR5o9DUosf6gl5iNyyb8WbaeWi4?=
 =?us-ascii?Q?Accu0y6f8Ss6EI83GYHqUglKI6ZYl9ftj0dFgOLwkdbTjIZZaSBrFXBGXejR?=
 =?us-ascii?Q?iQl+EBVbf/0JyDax9EJeoz1ufHatgK45Bp7t6QPklwyhipSrdXBn1wG28ias?=
 =?us-ascii?Q?UFtRWyLONYJyKS5SLovVoHxBJK1PGka6ZsuCqb+713YUxTDKXbuo9H3x6F//?=
 =?us-ascii?Q?pos85yRYmjXYtGvivkW+L4QXoE9JZVLQR0srSEIyq8aV8yWyXVU6gPfEwX4r?=
 =?us-ascii?Q?u6LhB3Dos8McC4y20r1AcrDG7GS7zQP6JFSITWIRRZrB8k/NfASpZEUY09k/?=
 =?us-ascii?Q?FitggwYeJxggj22+XlGYskrLlsgka7MkhOW9w1GBt/rN77WboM7pLPv6H3mQ?=
 =?us-ascii?Q?InQ2U8IY7nKTF/ectlRozXWYNGuUaLJ6d2rnSGveuENJg2b+caJMqkEOn64F?=
 =?us-ascii?Q?tncMvqGfzZhkQsRuAwIbiFGP7wJxcbbaRLZmUxEs1ADxFXIuky1sviXYtnlh?=
 =?us-ascii?Q?gCrq4PYZAycPvYmIky9UciSRXOZCzTNZOxOAtK1AR435rmxOjghUNsWw9EuG?=
 =?us-ascii?Q?h1srSeiRA/Iqrt+VPsmGYfUQc0hRRDE02N52TcqsnUAWBfD+PW9if/7FuHgl?=
 =?us-ascii?Q?MPnik8ECQwFyofV89+rCCHklcmBngPsZRAwP+RRj//5F0OrgomFG7a8wrGyF?=
 =?us-ascii?Q?LTqUP5zW6V6buZwrfn7SkqUuf9ldz6FlYDu5KLrT9n/Wt4VWyvJYwhEnGZlL?=
 =?us-ascii?Q?8MTetQjpz91av9lKH9po+3fDEB0qTcxle/JCDvDzFhjRuVRFgXRA7l6RQI9C?=
 =?us-ascii?Q?cwliD2uzfjCcsWMXGCj7Bx8VaGvF8R8xJasDxidZ7c5q+nh2EpNjHW7FGkSu?=
 =?us-ascii?Q?FPvBDtFJ8nY7PH5Cb/7dD/dAoBpT5BvXrqtuIlLsYDhKi1WtuFq1J4SzgQ7/?=
 =?us-ascii?Q?UXXfyKt2LjmhQF1elI3chEOHQQraNiq66XUulvg/F8nshQTo/dbpVdXGSfho?=
 =?us-ascii?Q?XHmooomO7Bl8c6+nE2fqvRl1TALv00lpQeQmACnckA2mcsHFDo/kGs3fwS3T?=
 =?us-ascii?Q?JspvXi0gc1fA06NImuzHzIwpqSwJD4zMc0AAEKfe/oc+mpg+MCf7sNHXNaR5?=
 =?us-ascii?Q?lpHDk+6I4lYvBz9ypCgvCmMczLkBCTfK8AXSKYqVCLDiZg4uPnQUnZf/JoCr?=
 =?us-ascii?Q?TE9dNUcJ4DhVul2zxQfebBTvBcx+aac28xetVXOaLZ/KH6aWLFCJBMNEfooP?=
 =?us-ascii?Q?1s6IT939v2wXSqEaL0zt6hTEO1IvtINXTvTv52r8UFEmZaGHnBYMrBMT+4ua?=
 =?us-ascii?Q?kp5hkVufH2xp8qI3a15CPuBICtGERH6yjmN2Xnur?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551aa96a-bcbe-4d20-aafa-08db69aaf133
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 12:05:11.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkgiIp7/NrNlXkkvhwLTQ6EllG23L9J2FHfvy0uELxvBlr82OGi338VYuETUB8Bz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 09, 2023 at 04:49:49PM -0400, Tom Talpey wrote:
> On 6/7/2023 3:43 PM, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > We would like to enable the use of siw on top of a VPN that is
> > constructed and managed via a tun device. That hasn't worked up
> > until now because ARPHRD_NONE devices (such as tun devices) have
> > no GID for the RDMA/core to look up.
> > 
> > But it turns out that the egress device has already been picked for
> > us. addr_handler() just has to do the right thing with it.
> > 
> > Tested with siw and qedr, both initiator and target.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >   drivers/infiniband/core/cma.c |    3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > This of course needs broader testing, but it seems to work, and it's
> > a little nicer than "if (dev_type == ARPHRD_NONE)".
> > 
> > One thing I discovered is that the NFS/RDMA server implementation
> > does not deal at all with more than one RDMA device on the system.
> > I will address that with an ib_client; SunRPC patches forthcoming.
> > 
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index 56e568fcd32b..c9a2bdb49e3c 100644
> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -694,6 +694,9 @@ cma_validate_port(struct ib_device *device, u32 port,
> >   	if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
> >   		return ERR_PTR(-ENODEV);
> > +	if (rdma_protocol_iwarp(device, port))
> > +		return rdma_get_gid_attr(device, port, 0);
> 
> This might work, but I'm skeptical of the conditional. There's nothing
> special about iWARP that says a GID should come from the outgoing device
> mac. And, other protocols without IB GID addressing won't benefit.

The GID represents the source address, so it better come from the
outgoing device or something is really wrong.

iWARP gets a conditional because iwarp always has a single GID, other
devices do not work that way.

Jason
