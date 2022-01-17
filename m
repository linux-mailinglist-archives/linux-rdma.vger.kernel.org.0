Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8649106B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jan 2022 19:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiAQSij (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 13:38:39 -0500
Received: from mail-dm6nam12on2080.outbound.protection.outlook.com ([40.107.243.80]:23137
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230519AbiAQSij (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jan 2022 13:38:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfS8jcMqgHGdlL8e0vRX+Lt+ntxMCoId6pm1FPLk2c3rdebq0mlIaS9gY5sNdnjexX0gslUs2rEPRfYcltnf1hHQNiWKPpVxj8EeHS0UDEzBjdsqhqJLOmnzY1SmzqiFs+M2kZ+9HhJTySLywZz0qHvZsX3AEbTIi0jIMcC+oQUss1+o46HUuMZQhN5Ri5FTPnD0cjUZPr+gp/hmiJf2kdk587iKJgrdZb+S4tIhyXWdO5hSFmtKDXfxRDeetcQaHCKkdQr4v3DkZuTsvugv0T0SLaTjqxjeqyRmQ2EdUOc9bm+eE3r4TWDAiwsBsU6pxzIOlg6dlicqY2IAPj81YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVd94PBesjdDdrUPuRE2kF/UIngSHeE3KrA8p4G4vfE=;
 b=NIv78tcnbnBGQ7kWdi6gxwZmoTrnPlqWoAp5NViZ9Z9BgmvgK6BIWV2TkJEX2almykj0tI4c+qUluelJkA5PyOfotmbBO9bkCxQCr/5kBv3WkkVURGesZPm5O1hYAdj94WXOoYF/HInRR7v5N357r3U/jzp2V7B5uAEz7JrHEbliEZTeVlP8iRv6L46xfzUGozgQHG96Xg/tMI5A7kB0TqLCy+zqSDlYzxSb3bYx43bztpWh7Rtk7fR9ciw6Q1b8WYX1qkX/5NSAelHHgzYHy3Jmp8QZ/hJYdnVseWLOiT5Mlh5mnMqSUmmbxIUZ704wahVuUzG+XOJ69GkFmyc/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVd94PBesjdDdrUPuRE2kF/UIngSHeE3KrA8p4G4vfE=;
 b=fXsraHnM/ukoLqNhDOmw8lAxiK8mf2owgq+HJzpDztJWDZeKZsJP165VgKQo52B3opCeBjhZ/Dx2+kEWBKfBnYqHcOAS4GrF8sJSHtGwW1PCZdjcma4pkTMx22kBYhcPI+5FZP4TbHotwq9ylMdIOYhjCiL0nZLJJGCqbdP2c4QGHORHtv2/n1EzprSjlzqmVo/OkNPyLu3DQ1fldVq/EhrfBKIpKL7Z01HymMyL8R6RhAF0zDI2ybtzZRNr9HKon9y2BEnSf0cLlh7G41mavX/dIFWcszyLK6cRICatbNIqGtxhw+58RoIGn1sP4YDeBeSh6lHj10KS8s9x0NQ5kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Mon, 17 Jan
 2022 18:38:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 18:38:33 +0000
Date:   Mon, 17 Jan 2022 14:38:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Clear all multicast request fields
Message-ID: <20220117183832.GD84788@nvidia.com>
References: <1876bacbbcb6f82af3948e5c37a09da6ea3fcae5.1641474841.git.leonro@nvidia.com>
 <20220106173941.GA2963550@nvidia.com>
 <YdrTbNDTg7VdR2iu@unreal>
 <20220110153619.GC2328285@nvidia.com>
 <Ydx1dDSa1JDJGFdJ@unreal>
 <20220117161621.GC84788@nvidia.com>
 <YeWzeA/8TgXalrD8@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeWzeA/8TgXalrD8@unreal>
X-ClientProxiedBy: BL0PR02CA0073.namprd02.prod.outlook.com
 (2603:10b6:208:51::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65698d72-ea3a-4d1c-6996-08d9d9e8908e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4382CE0FF1196813ECF9910FC2579@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BppAGVRruoNFBOAp2+iQWf3EHlXgxiNSYn+MO2ITWHEw0ITLCPmecZx1lvR9Cl3Lt3eauMYDDg49sMSnGV4icRYxCeDqsixXs8H9CSXM0Yd0ZJhDnxAFhIDzlZilqzCTDCx6E91XNihVgYakfyJEpGsD9XERtMWjWtDQwkjIqG/oblgNQvNKAdSU3CsLqgV2IslENVJWsXGGpGwWdXtJgLTyl5kngl/AiKg+cbb5Dc0Wk0BeW9tKFA8ifHnqiaKHCI1GVBccD2sHeU5UlcvWBxadr4RqnExHHiikUdC2VXZKNNch6+SYSnoqrnDpyftY9C8NcbGIL78sVo/eE6a4vSQBhNlLUEzoQkbTWJPqmGH9Im49WcTDYCHI29h2OyaYVUoQ9WUh1jBkMyEs7GuvhxvQ3DZAjJHEVlFesaHdgiej8crj6a/XsYQxGhPCXnQQ22grwOIp3x4kUnjLDbURGDUjwL+k3m5rzEPwgiFWa1z9lwxSHWcEilyj/p5b41dqPLT1KR36vdMG2yZ31B87O8k9d4upzSX6u66XfZG33kKO/76X3/vZoEVl4CpFEmU13kKcmJ+2RtYhQczw12H+U03BI2BsgH3AkepmNUzUSJG+lfJLtrgFYh8VlHiDO/jaMrcEHoXKFggW6CzlEXqag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(1076003)(186003)(316002)(6486002)(66556008)(66476007)(66946007)(26005)(6916009)(36756003)(33656002)(2616005)(38100700002)(8936002)(8676002)(2906002)(6512007)(6506007)(508600001)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pOXrCW6NY3jk9lHCie5+v00Q7lf5Xf3WF3EbKBLXXMywfsJRfOt6gNhvPNsB?=
 =?us-ascii?Q?MIZ0/Y7SfmWVsYAUSEHX6whW/2osRfuXt2U05u8TzI9etog15gboTeBHWSwb?=
 =?us-ascii?Q?5aNNFFl4CyskNjBEp9ZvVQBa8cxzIvzspv7ZXl8r3GNm5elEgVPvE2SBdQ3J?=
 =?us-ascii?Q?UiXP6Z8IdAZoejEwSIxp3uNFa0WR2+ARUoMYCRepr4K/3rnArOEp3yLTQ3l5?=
 =?us-ascii?Q?AA3AfmfVTgFTJVltSzvsCN13wj7mhsQt4OaTPS/QDZXAMkiup1o3RDv1clT4?=
 =?us-ascii?Q?qQV7bSzUXspR9OKMl7TOIkBeRvqvyIpP8fWkhecZpeLmbg4rRmTNTkFiplJs?=
 =?us-ascii?Q?w14mx8J9QVeHM5eQ9IlBk93k+q/iFA1k3LV6I966fqIm4Ggysnz7WUXi4vw/?=
 =?us-ascii?Q?S+/MVI9FseGrE14Bc4zJoGcB5/wCwr8wMBop9mtSRj6OykzW+dpuwoqUrAXQ?=
 =?us-ascii?Q?/UORb7cl76V9Wfkw+tJCBnuvQcI8ToBrb8pAfAllpl+Y+bwxse6qPVd9J8M2?=
 =?us-ascii?Q?umk1GpX9U+sKDDrg/En/VLk/zs+7EWpI7xvPYqK8F013g2r630uIHtp0Ni0N?=
 =?us-ascii?Q?4fjyA/x2Ycxjhoypj2hm++Bwicb69R2u+J8vaQUHgFEAP33w6GTPwMVHwEZk?=
 =?us-ascii?Q?OUn/kKamNlPmvJgFHTkQM1/OlId6eM2zySI1W/du5q+QgmmtKGXzwWhIfAm6?=
 =?us-ascii?Q?fsVi+FRw+CjP7FelPetuiBn9hxu3BK+x6GlOWGIK9f55HiohbSLOBDYJt3Gy?=
 =?us-ascii?Q?NG6JiwvPl8pQDcaDpuJZexxkpmQMxgJuZZ7yTuSUzpL1SgWBqlfoEMnMSAno?=
 =?us-ascii?Q?tsm4bcJwlaMalhVx8yAPqm26FdCDv49NeYYWpLONDpSH8wAW69g8f4mj/gsT?=
 =?us-ascii?Q?AVbho6ioaOX+U2VzqDoJVrTv2SHfWM1dyL3Vd6DXxndgapST5/hhDAUPaflr?=
 =?us-ascii?Q?EOkXmyVqeNGF+ieKFa6dj5LYNnUkIuto/8YBEh/zmdGofV8lVNw+cc4E4TtM?=
 =?us-ascii?Q?QHlsR7R/0HXGp0FwwYgMCJgbdotyUqwLg55BL3b/xuomdfo8AaQbtWAxq0wE?=
 =?us-ascii?Q?xwtg2OOpLiVtrM3Wt+tayVMC1pds/oqSHFMgo1qEjlId2ZrBo8ny4jOWn1MK?=
 =?us-ascii?Q?/dUlkWafhCAstyMvAyoRC9FuH5KN8Sp/YVsMOaN6QGgpeYYYodLzPKzT7Amz?=
 =?us-ascii?Q?yR19yAHJwPWZZPKD6mdXDEdzwhtdsHDtpjdANWcavpNh1mbdyAHO1wvZA/zZ?=
 =?us-ascii?Q?/FerciBHBTfTuiA0wtwX/h8RygITWVL6NMr6R1TuvG8krlMbtcNElxV1jLbH?=
 =?us-ascii?Q?dl475/sF3MfFvNbbX/51Cg2POQUY5n4SjIX4aIw4fzRRHOuLprpmI3dIx4bj?=
 =?us-ascii?Q?OLSl8XDknAOa9lGxcMO8cqJF5Yv8HfxKwRKVvwPxkigoaoesyuwUr9Md2MJH?=
 =?us-ascii?Q?lmS4tNUyY245SsdYbjmTMnicYAKI7MtrYexxanN4E4wbK8UubLRQuVz4Q5b/?=
 =?us-ascii?Q?cvTs8+9BSm0OY//oKwaXRNDvBF7p/VIaDRA9s1qqcdGA9u8oajQVfaJokOrC?=
 =?us-ascii?Q?cObrK0LLTO/jZ262DQ8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65698d72-ea3a-4d1c-6996-08d9d9e8908e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 18:38:33.1934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m365EvRtQLVUe0VBrt8NTCYOcZxT8hVrf0qNcthpoqFowRFmfYI1RHVkIgKWc5nh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 17, 2022 at 08:20:40PM +0200, Leon Romanovsky wrote:
> On Mon, Jan 17, 2022 at 12:16:21PM -0400, Jason Gunthorpe wrote:
> > On Mon, Jan 10, 2022 at 08:05:40PM +0200, Leon Romanovsky wrote:
> > 
> > > > We should probably check the PS even earlier to prevent the IB side
> > > > from having the same issue.
> > > 
> > > What do you think about this?
> > 
> > IB is a bit different, it has a bunch of PS's that are UD compatible..
> > 
> > Probably what we really want here is to check/restrict the CM ID to
> > SIDR mode, which does have the qkey and is the only mode that makes
> > sense to be mixed with multicast, and then forget about port space
> > entirely.
> > 
> > It may be that port space indirectly restricts the CM ID to SIDR mode,
> > but the language here should be 'is in sidr mode', not some confusing
> > open coded port space check.
> > 
> > I'm also not sure of the lifecycle of the qkey, qkeys only exist in
> > SIDR mode so obviously anything that sets/gets a qkey should be
> > restriced to SIDR CM IDs..
> > 
> > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > index 835ac54d4a24..0a1f008ca929 100644
> > > +++ b/drivers/infiniband/core/cma.c
> > > @@ -4669,12 +4669,8 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
> > >         if (ret)
> > >                 return ret;
> > > 
> > > -       ret = cma_set_qkey(id_priv, 0);
> > > -       if (ret)
> > > -               return ret;
> > > -
> > >         cma_set_mgid(id_priv, (struct sockaddr *) &mc->addr, &rec.mgid);
> > > -       rec.qkey = cpu_to_be32(id_priv->qkey);
> > > +       rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> > 
> > And I'm not sure this makes sense? The UD qkey should still be
> > negotiated right?
> 
> Yes, I think so, it will be changed in SIDR phase.
> 
> The original code has "cma_set_qkey(id_priv, 0)" call, that in IB case will
> execute this switch anyway:
>    515         switch (id_priv->id.ps) {
>    516         case RDMA_PS_UDP:
>    517         case RDMA_PS_IB:
>    518                 id_priv->qkey = RDMA_UDP_QKEY;
> 
> The difference is that we won't store RDMA_UDP_QKEY in id_priv->qkey,
> but I'm unsure that this is right.

Well the whoele cma_set_qkey() function appears to be complete
jumblied nonsense as if qkey is zero then it doesn't do anything if
the qkey was already set.

When called with 0 it is really some sort of 'make a default qkey if
the user hasn't set one already' and in that case defaulting to
RDMA_UDP_QKEY does makes some kind of sense.

The functions purposes should be split into two functions really.

So, we end up with 'make sure the cm id is in SDIR mode' then 'if the
qkey is not set, set it to a default', so that the net result is the
qkey is always set once the function returns.

Though, I'm not sure what the semantics are for qkey during SIDR
negotiation, that should be checked in the spec.

Jason
