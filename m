Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A28E46C313
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 19:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhLGSvE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 13:51:04 -0500
Received: from mail-bn7nam10on2043.outbound.protection.outlook.com ([40.107.92.43]:21985
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231469AbhLGSvD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 13:51:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwcqUF+7bwoQbfQMuYusWejdKFeNkAg3CzZ8NhvmnKebPVbbpnUCBLvCtyIZ/2O2nrGR9DQZ4mceqdoaBtE3cipVcP2oNsxtDqwsL5mighvfyK3Rau5CcZVjtWLa0HHm5JNOXKO8+32ppR1B227FjOq0CT+T9JbeMpB11o6uLSIk+eiWGME8x3EBdW0jRqgxU0sihisIVLB4M4mckwSW7e1EOvyLYkc83ytPUajiUiRAF7E4rkgfFEdv+PGHp8tMcm0yHu20TltYDekm+d2xdbgY0HGWfO9rrEGk0Qp3bo1dfqtXq86GX9vMNfp+oeY0oFyemm8GePa56+ijC1f8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u3BVxBauFQIDJwg5DrBx3W+I5fpwDxqyH7nP9PTWGE=;
 b=S0XfC2OlS+B5pfZSoHRCrpx0tt0bvQXHUPps1K8wAoGfsYnw+tv37Fn1QLbrn7p/Gi3vXUrcayVLvJhKexYxYrM9t75tQj3KMixpueW9OyozRpJmHBjQuwL8fSmftXWE2iYTZWpCMWwamPwgf+RVAKFlfq/3KJS5bpoKC7wBqz1z9F9W9B4R+cc5q3cv7fc6rPgchveXnU8jUHCnZgfayfAiGMOqGJKddA+2/+XePiCt4nra1TKYAm3iTA90FSeg13yNbaIhgg4H/qFfWXweT6x9aVxCPtoWG928oX46zHqUkPHlte62U4tr84/jSKOWkC/M8CnvNwiUmyzNbVYfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u3BVxBauFQIDJwg5DrBx3W+I5fpwDxqyH7nP9PTWGE=;
 b=hMVH414DA4U/ZnrrB+PrZnwBz3LodDilsmYnCg6XCVsPF6YwXizE7P/MFimBL3tkCTgxXm64CpcPH5VVBqLr3exWtCPsPuIATaJxMQ4h/ZJN0B7ZkMkz+sV8acMowEhVUIL8f6g8lXp4kUZng3qLadCPPQUNrkIlMRRFBuAyplc7GvJFxifJOVMWIDCC8ofzdjg2LbG0xlL38Y4inv2mGa6lIIdG1kS0Vv8bmuumbWS/tDD/oOG76aBv3aDf2FBTMt/KwqyTz3bBb5ZgGISfbPZyY/nrEwDZs/ddMNCjN4jdNXaV3iFtCFiUf9zbuvdCyldlcwxLyleQtNxXvI4fnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 7 Dec
 2021 18:47:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 18:47:31 +0000
Date:   Tue, 7 Dec 2021 14:47:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr
Message-ID: <20211207184729.GA118570@nvidia.com>
References: <20211118203138.1287134-1-keescook@chromium.org>
 <YZpPr2P11LJNtrIm@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZpPr2P11LJNtrIm@unreal>
X-ClientProxiedBy: SJ0PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::9) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR13CA0154.namprd13.prod.outlook.com (2603:10b6:a03:2c7::9) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 18:47:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mufUv-000Ur9-9O; Tue, 07 Dec 2021 14:47:29 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6790399-03d7-4a51-0e6b-08d9b9b2067a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB506303F81E319BCC59F0D9DFC26E9@BL1PR12MB5063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1YFp9oxv8/EA0frcQTqNHUpLjcrwuMZlFNE42NMJNk3oOZnv5WDIpqfHlCttJ3EcVe5he0dgNFSdtEVnTjhgOSo+CMZ+V8y51eKqg/RSk9sIyd2FifdIAyXm7//hwXmRH0LDoGWL5vgCzzHeiKvFSo9s0F/Dw2GnHf/8sZeHn0PMFuzIXzafmCxBbjnse2RzLwV5EINnSFnR47h3/cfBOkApy7oKCwvf8ftkG/DNgbFh5TYhI4oLZrKRsPGru289JIijmTA/tpoEhEVtt37Ey52DL4OeSumNNuqu/LCLn/AeoCzS7aUKwYqCUw2hoikZZJf0PM16GDqLccSy/c6C0Xp2n7Q5hGVcrBf5+xnRdeLiJVvJ8LrcsbC1GmNAwRMTFp8KV66pn3Wo3OAdjnqXXzPoF14LoPin4j8hmIrZ9kg8UyPWlr4TIXJ7KtfGquDn2fBUWiSzsDIeG0y1Q9X+JQ8zrRdzJE+DLZ9UMEo/KRoWj5ilJO+7Mog9mf204Kz7uzp/DEM/dnb/VbYundz7azVg5Ad5sPEkfasLYpdgIVFoytLjKKEqjgPtshfi7AQfEOyHHJpRs21LskUV8P8KcJQYEhSrIhWMbxL+8dBKolwEsj0IsSajTXjwIDLmEyn3NZAYjTx4jrfnX0zD3ooi+MvkKOIL4e9Q9NzyL39TxIUTlJl+ka731pBLnm7Als/wB+qAopJEffC6o/vXrRDKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(426003)(26005)(86362001)(4326008)(38100700002)(508600001)(33656002)(2906002)(83380400001)(186003)(9786002)(1076003)(9746002)(5660300002)(36756003)(66946007)(66476007)(66556008)(316002)(2616005)(110136005)(8676002)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n3MyA35gkJxfDpO3IMyyT/rZZ+ue4dIHrZJc+PS0eHUKLJgS9zFZ2SKL4nI0?=
 =?us-ascii?Q?8mCTnU3QPYcqTbrXSMxnvsfB9Ccn9niZb0UqijmnFUDOLCaaJ1wGpqvrkgnt?=
 =?us-ascii?Q?KIm5xR2tK61N3BuXKmdECvfy5pnl3yW4PMCVNlUj/1v9k49XzV+Zo37d+UTZ?=
 =?us-ascii?Q?FDvUgae/l21u70Ottdd9mDWpKiJh+5oWi0RTw7IIwsKaR8HJe9xrjT18tgQ5?=
 =?us-ascii?Q?RDAEqDO8HOJox6YP6MxAxCiTwt4ZFknGt9GDHoI3y6TZX3kuL+cmbRW4X0wv?=
 =?us-ascii?Q?9Zh2ka6Z8ZCAZg6xrPo6sfa533nlQ5tpi1Baa/jniQ4l6eWi05G4DXtrGC2Z?=
 =?us-ascii?Q?jpUS+DDtpaov+704HgZ2ABnAwAmDkX9BpRTKhWs8cLKsPutfAg53jSthO+mU?=
 =?us-ascii?Q?J4xQ28IhfqN46OFX54uYdWMJ92YReEZRZyxxDpy2XTUu1esNC0ymYPaFBJkM?=
 =?us-ascii?Q?vyFImxKxVVrJLBoTopT2S9a0S06IUR7qEO67HNuUGe0m6Y5eoFLrmRwJ98nq?=
 =?us-ascii?Q?VHQCOa/YjhPatG4cxnwz1JSEvFW/Es7l86Qr3sWuqQ+MxiYVdSCTsbecgYbR?=
 =?us-ascii?Q?sfHxcg+BPtL3PdLI/jANn/MTMDkmjpt8Ax9BMzpQ9EVrd86igcDOmexpCWzs?=
 =?us-ascii?Q?WSZPUUP/Sh9X9mKnt2IDDD+cyyZpGUON4zITvkQYOvswVoy38jMYG6IZ9TGN?=
 =?us-ascii?Q?lPX3lbZXffPOGejEWcAnrJXavEzDilWUwRLQtBYuZFaQVK2Bj4I7iO2+D4xd?=
 =?us-ascii?Q?qw3t+SvMaEkGNADNJArS+p1K+HYyKzkQjGNL0h+gLHXAhAT6W7vLDbPO8qe0?=
 =?us-ascii?Q?E0ZsHjLZXqa89H+ypKIXA4hQH/AfXfoOkblOhxjPXtZJohP81G7PbVuFWJoS?=
 =?us-ascii?Q?VU8rZPNuim3lX/2W4lL5AwBqDKPox7YmTvFYz2DnsDcVhziHmvM70VmwIfb7?=
 =?us-ascii?Q?qAfHu8h1tuBPVH9gbVimjCLW6MS4M4S7hgGoA/TUDCtY2DSjY0VDFfxUoMSh?=
 =?us-ascii?Q?ZzHjI3FtdYCoQ9LvcaGz8mMzj0fC9RkMht2U77hkgIgCxXX9/M8jwWtM1S/T?=
 =?us-ascii?Q?YhIEcIKefV7A6xX17bcUnUGl1ECvzvM4G1whMv+ogTDuLiIzv9z4DYaoqzSg?=
 =?us-ascii?Q?f21Tlcqypijli7RzqO6Ajc+knzy7DxavDumRWu27QMPGIAbDUUtVof7wlBW2?=
 =?us-ascii?Q?xryQePHyJPoQrGSfWPDgvuK3RdI5ubzJsusL7mZLPKwVaLTWyDiP4BunrSj/?=
 =?us-ascii?Q?Xo0zOA6D8+pa+Lp7NeifkcHSZzSK7KiCzKgerMJJAdP4qCuq6Fw2fAPV5/iC?=
 =?us-ascii?Q?gTwIqqV7zdhG92SaAdTOJj6MB066HZDPIPz8HMOxi5X3ua8nNuz1g3sRDAWK?=
 =?us-ascii?Q?J3F/0i/JdxXy2rXCgPsd1EwQUFSCnseH92+YLk2I3BwQmcObEX9znqfc9Xly?=
 =?us-ascii?Q?Uf/mpsvNIR6akjD630buE6iAxGPBTfv5QYIKW7B7G3+CO6ZiDWwZDV9xcz91?=
 =?us-ascii?Q?x3uILRhOjp9uQkDf8lZedZtAsbyJ7Ib6enVanbxYGkCEyB/Pc9a4rfFtSCDv?=
 =?us-ascii?Q?hNwG4g3Dpw+LdGXZcY8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6790399-03d7-4a51-0e6b-08d9b9b2067a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 18:47:31.5970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYicOuY/pCrUkQA06wj5EqpG5Szldy4fNTFM123AbXVk+oAi41lgPJitrT60eH0u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 21, 2021 at 03:54:55PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 18, 2021 at 12:31:38PM -0800, Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memset(), avoid intentionally writing across
> > neighboring fields.
> > 
> > Use memset_after() to zero the end of struct mlx5_ib_mr that should
> > be initialized.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > index e636e954f6bf..af94c9fe8753 100644
> > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > @@ -665,8 +665,7 @@ struct mlx5_ib_mr {
> >  	/* User MR data */
> >  	struct mlx5_cache_ent *cache_ent;
> >  	struct ib_umem *umem;
> > -
> > -	/* This is zero'd when the MR is allocated */
> > +	/* Everything after umem is zero'd when the MR is allocated */
> >  	union {
> >  		/* Used only while the MR is in the cache */
> >  		struct {
> > @@ -718,7 +717,7 @@ struct mlx5_ib_mr {
> >  /* Zero the fields in the mr that are variant depending on usage */
> >  static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
> >  {
> > -	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
> > +	memset_after(mr, 0, umem);
> 
> I think that it is not equivalent change and you need "memset_after(mr, 0, cache_ent);"
> to clear umem pointer too.

Kees?

Jason
