Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E95246C3E5
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 20:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhLGTs7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 14:48:59 -0500
Received: from mail-bn8nam12on2079.outbound.protection.outlook.com ([40.107.237.79]:24586
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236490AbhLGTs7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 14:48:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFjigTBt3yqIAphN2JHZ3Lu9wBqQW6eU59ySttj7u6jqlABnS6C87KELou1O1MG9JC9+EVn9KAP+rqOTapAQU1lzb7JWy6vZwmEyTyeUkezTox+ycJMwKP+SlOdNYDp3wfx10Zllh9LX4i44/jbLMrLXVYjfc2PiAdz/71e4G3bYv+NOwOxX5p6/sxn04hIccScdtjsWMaYfei0HxxpYie+XeXYihxkrmq4gITNDu2VLiZbE5wAzePC+KlUmpn6RO2rs9z5/IoaxIYBrJTpco3kLv+2TqcHoJVi3OD6knYhDh9cbodpfH5n6At8P/8VS4qn7/fVuKl5HkIS6HZN6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01fZ64+vt89N+WgsuvJuIhSFWBBccZnWcNNdm5B9nSc=;
 b=TA/8rk3gfY6SOy8h6iLUu6Xl66WOq9juD771bGHDEYGHkhSarF2A658WGrC6TmVi1iALnya5w6/vlOhwYCpURowl/umKRixDOsuujvNPNevV7/W38F1xvdlEY4IyECDi1TuXCP5FWAZTt9FuLnFWXcnKu3urd2FpKhD4TC1kyGtwbxDRvpq3um+X+WlAJ9pQNDeNsM4LIgO0L94c7hPtPC2nRLmch3TlsFP4y80duJwxsPbKkBGmillPJMODaGd6NI8G6eb+98y2rFbudHIPNHh5+XhQRFOLlCuSz+pIjvs25ewcSjrosiDPhYbEAkPcLlHrHsBrmQRwXs7WqjkFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01fZ64+vt89N+WgsuvJuIhSFWBBccZnWcNNdm5B9nSc=;
 b=YkNvftROh12GoB5TVmU/WbgrDssnga591pe5D75VSxZZUCvOx3ZoWLDv/HtgIiz2Haz/GILBAjLevYY71cGoBqn0+07aBWyg1nshsu7zYtcN9BX+J7jPsiE14HBsSBxCwx6LpRMykCqXE/HyunMKb4MMfm5oW1xE6wdBukbLDyF8m+14LUx7D9vqObtrXuF8o8O0NFspoBm7H2gbFafI9OKF0p5YP99ZdMmDBEFOdJwVr1uuWt3hgPHEZkwGVi1pKiY+Z1sXl+qbjoM2/6RP4MXfnuFmQmUyl7moNnTlRnZcs7TA5L7l7alFbno/dfcaQPNRnkSOCdAcuIXMz0G+GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Tue, 7 Dec
 2021 19:45:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 19:45:26 +0000
Date:   Tue, 7 Dec 2021 15:45:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr
Message-ID: <20211207194525.GL6385@nvidia.com>
References: <20211118203138.1287134-1-keescook@chromium.org>
 <YZpPr2P11LJNtrIm@unreal>
 <20211207184729.GA118570@nvidia.com>
 <202112071138.64C168D@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112071138.64C168D@keescook>
X-ClientProxiedBy: CH0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:610:cc::9) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:610:cc::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 19:45:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mugOz-000XO5-8o; Tue, 07 Dec 2021 15:45:25 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94c564ae-cb10-4252-2bfd-08d9b9ba1dbf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52554041790EF4EB014EAD50C26E9@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plc+yeu9rNh4u1G5ZFXNOBYCaQ8zoH9vsNN88KTjom82w0WXPaSFFk3Shuc/7PhCjMV+iat9I98GyL/rqbm7fSuwzqwIf00ZU4UPu/QjCdGQeGbT8NmTx9D9ZrHtb1J3ZF0G0pdM8NDbLUB7FS3SACMx2uadNKE4MPFQcQyEc7aJXWWIWYm9354HGLLq/pRcDa6BZ5y1KXdslpk3jhHnM4JKM+QxnkFaTsN4964W0Kckc1cOMMLwL+eJVe42jd5h2kui2CkESyRl1UNvIoPwzJ1lfxHeDKpEIZ4BSSJhOmih8RWh1AWRzjMMwEqADOvIl0YdJ4h0tkMfwym0WNHTBDv+4I11AcNXij+rZMjVPf0JH7vG2gTnoQbPdfT4A/62euCigK3P3Qzp7BJi6PjbjYsQhsV+dJwT40j/yCI1U3qbYg3ume8KbTOnaIbe/KstYL+r5bVfjN0TGAHI9nwhQYQv2an5mV07TeX1k7gV0LMn5l8PV46pBHacBX+Qb+ohGYhyNb0Pm6cqBWufVr+DZw6Pf9faa2pfAM69LgE6IWp7RRPGGWwW5kEh1G2ncfmXpgh2PSMHMnVVoLgHlTARBrrHVJQ/3QfkWvKpkkjgNH0BEPPfAQC/98G+O1iSl1SRY3IScq8i6ah+iiyYlHVgSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(4326008)(8936002)(316002)(86362001)(186003)(6916009)(66556008)(66946007)(2906002)(26005)(36756003)(66476007)(38100700002)(5660300002)(508600001)(33656002)(1076003)(426003)(83380400001)(9746002)(9786002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ve+neO/atdxqxUT0SwA7BuEWuOwjV6r46QVuxeI60ee3qHSgmchXuH2NXPdP?=
 =?us-ascii?Q?UcbwLeG7sHS2s47a+OIAP0pS9xFEE9Y/uI7T7091CukhCnhaXcw84ryIUp1a?=
 =?us-ascii?Q?q6qBVMEsvPsiJ4mP3dhLHuzgGsWkk9y7veT2MJzhW+/z6o1vd0GlUBf6oPSN?=
 =?us-ascii?Q?PCEwUTejmNajlJxH1D7zMlp0wkgSD3JBA8OPJc/RXKND/HUVZg2oRqidApQh?=
 =?us-ascii?Q?FWzRO1usYffCkaMLY1W9AIxA1Ru5FKrAQQjjnUG9XoTuSJjz6Vv24IdMf8mM?=
 =?us-ascii?Q?GjuIHcHOAEAlETOSxRGSaQI/Lk/2+dz4E1Sb3eazNuAS0NDRu/uLGecWYsyW?=
 =?us-ascii?Q?bzCVpX5+VAFBbVKHl+3oRLUINltwDMAT3brYkDIGH+89UlTz2FY5I8uM2hP9?=
 =?us-ascii?Q?8gooL85vHfz0BBUC0MxA52h/xJexbIiBHgtjah0OHxldxeofQsOQhfXZ5NOq?=
 =?us-ascii?Q?iteyEyKF/A1yx1FAKpdMnGS3M8zB3qZmvJhOSOXck0UCTdl4onfCKWVH+nTD?=
 =?us-ascii?Q?kTndKv9zS+x0ea6tQdbozw/8BQ2vEdnJS5jHy90NnQnbrVBGKI15+YMVQJwL?=
 =?us-ascii?Q?Aicc5D3gQRZsrG/DiZd9HYFVNijUH8MW/2G4lsLcJSDfQuuerRBUADyoywTh?=
 =?us-ascii?Q?tuEgqQx8hO6rLwm6SnciDCiqcNfbU4dEWDIvgn+tM/HizEBU/Ykfc2GgSY1d?=
 =?us-ascii?Q?4ZS8YA1zVvvpLW9bfXCSXYV36n7BJmQAUeBWn7znFxQvzG3S9qyPw+puQdm+?=
 =?us-ascii?Q?JOmYCXyZ62QYv2uGBrkpqSghnMwZp7NTVbcUXM3rJx/kjr9V9I/6Ki2WMB89?=
 =?us-ascii?Q?xqv7cbOOQ7bCDl3V4c5FM3VC9E9s84da8RivRoxoyjNE1mLv3ULquNrACfTc?=
 =?us-ascii?Q?nVRolCaZBhzc4S19S0bZ3JcHlNPDX2c4aScKuQWlIQj3FWSPhZRHQ4xDhtJ5?=
 =?us-ascii?Q?sieylF/xW9tjFFZIs31otBtW05w7+dBLlrGexmqzvaN43wk39azNX3BwcrVC?=
 =?us-ascii?Q?Za1zjILegfbjIZFz/t7WiODvifnh4TNuT5MbHeTwcOY4HyLXxdRPwCSdvQvd?=
 =?us-ascii?Q?vnD9gLFTDzQsyr9ea6xmcsMBXT8Xiwpg8UQGDNu6RDte0CewlpoAYbJNEiGv?=
 =?us-ascii?Q?mG8e1XoPrd8zAKbXIqqH9rfRQgpFG1JIWXL4Nv8ZTPgwCU32/TrK2DEmQKsj?=
 =?us-ascii?Q?CJ1OmnN0vo6QYAHK+krxT3cvJIA4doAIb03S/S3pCE9Go77LHJULfwnPaFVa?=
 =?us-ascii?Q?FylkIIy6cRA5eVkGY8tYOXvX5S7xz4UHnKCK6PgJ7rhVp7OB2jiTK8AFCrJo?=
 =?us-ascii?Q?C+t6PJXcYP4vu7+sPWSEfawbQmXjeVC+eJuxFbT7+MvzWaqfX4NxSykqKbzX?=
 =?us-ascii?Q?65SrK9P9Ub6K96xwoq3putb6HPSR3YH/tUbZC7228pMdekKpbQpQAAchj5fG?=
 =?us-ascii?Q?wW4URDF2a04SdVx+4CX01YCKkuzahdNjxQb1K5VqIR74gjKJko+TIlj/2AQJ?=
 =?us-ascii?Q?XQkocJPqwGR/LG1eYuecJqfE/7wRMTDqyR0VxxGxS5ig2TfgKUrkjItBGrwh?=
 =?us-ascii?Q?2hUthvOEmpNqbZITY1w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c564ae-cb10-4252-2bfd-08d9b9ba1dbf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:45:26.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFtO+afkgk6J/sOCMD0D8NcgS4fwc4OA83vI7TJ/D3XYFqQX9U6ZILpFpSC4Q93u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 07, 2021 at 11:41:07AM -0800, Kees Cook wrote:
> On Tue, Dec 07, 2021 at 02:47:29PM -0400, Jason Gunthorpe wrote:
> > On Sun, Nov 21, 2021 at 03:54:55PM +0200, Leon Romanovsky wrote:
> > > On Thu, Nov 18, 2021 at 12:31:38PM -0800, Kees Cook wrote:
> > > > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > > > field bounds checking for memset(), avoid intentionally writing across
> > > > neighboring fields.
> > > > 
> > > > Use memset_after() to zero the end of struct mlx5_ib_mr that should
> > > > be initialized.
> > > > 
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > >  drivers/infiniband/hw/mlx5/mlx5_ib.h | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > > > index e636e954f6bf..af94c9fe8753 100644
> > > > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > > > @@ -665,8 +665,7 @@ struct mlx5_ib_mr {
> > > >  	/* User MR data */
> > > >  	struct mlx5_cache_ent *cache_ent;
> > > >  	struct ib_umem *umem;
> > > > -
> > > > -	/* This is zero'd when the MR is allocated */
> > > > +	/* Everything after umem is zero'd when the MR is allocated */
> > > >  	union {
> > > >  		/* Used only while the MR is in the cache */
> > > >  		struct {
> > > > @@ -718,7 +717,7 @@ struct mlx5_ib_mr {
> > > >  /* Zero the fields in the mr that are variant depending on usage */
> > > >  static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
> > > >  {
> > > > -	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
> > > > +	memset_after(mr, 0, umem);
> > > 
> > > I think that it is not equivalent change and you need "memset_after(mr, 0, cache_ent);"
> > > to clear umem pointer too.
> > 
> > Kees?
> 
> Oops, sorry, I missed the ealrier reply!
> 
> I don't think that matches -- the original code wipes from the start of
> "out" to the end of the struct. "out" is the first thing in the union
> after "umem", so "umem" was not wiped before. I retained that behavior
> ("wipe everything after umem").
> 
> Am I misunderstanding the desired behavior here?

Ah, it is this patch:

commit f0ae4afe3d35e67db042c58a52909e06262b740f
Author: Alaa Hleihel <alaa@nvidia.com>
Date:   Mon Nov 22 13:41:51 2021 +0200

    RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow

Which moved umem into the union that is causing the confusion

It hasn't quite made it to a rc release yet, so I suppose the answer
is to rebase this on that then it is as Leon  says about cache_ent

Jason
