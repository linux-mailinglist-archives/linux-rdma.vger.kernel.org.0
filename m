Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE3F4ED678
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Mar 2022 11:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiCaJHa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Mar 2022 05:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiCaJH3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Mar 2022 05:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23298C1E;
        Thu, 31 Mar 2022 02:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A577B6199D;
        Thu, 31 Mar 2022 09:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9DDC340EE;
        Thu, 31 Mar 2022 09:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648717542;
        bh=O9mbqJV3/2zhXLz1A++FCmBwPUA6tFJLaXZiovQ4JXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXCEVL+6+yKs1Zpypor4ip+GLvHnIJ+ifBVaCT8mlroDbv0hrI9ei/XyQ0BqEGK/d
         PgJ2dduYgYovBlHn2DbOX8k22xPW/AZ5VEydxBQEwpwg8PISd6fR1XLxdFeFPJnOIq
         JTt3qfQuPt7cSwa4+7eGS/mfEg+dgDB+ZQ4NunedczqUifYdmvSjkpewwx6F2BJhuj
         4NjcuX2DzVXERGzgqZpgV/xq2eE3bcUlfDI1UBqHhN/wFvMd93M5M6lC0r1E1BwfqS
         SnXT8uaBJN8+eLp1+tlse+A2WWvTH5+9vAYVbX7rjdl/VffAzIrNmHrDLQMORUvm0+
         XS1OH0sjygmpw==
Date:   Thu, 31 Mar 2022 12:05:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "zhengkui_guo@outlook.com" <zhengkui_guo@outlook.com>
Subject: Re: [PATCH linux-next] RDMA: simplify if-if to if-else
Message-ID: <YkVu3vqjIPFRSGtM@unreal>
References: <20220328130900.8539-1-guozhengkui@vivo.com>
 <YkQ43f9pFnU+BnC7@unreal>
 <76AE36BF-01F9-420B-B7BF-A7C9F523A45C@oracle.com>
 <YkQ/092IYsQxU9bi@unreal>
 <93D39EC2-6C71-45D8-883A-F8DAA6ECFEDF@oracle.com>
 <YkRTidagKVgSUGld@unreal>
 <38d43b49-9999-af2d-e3cd-3917c481651b@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38d43b49-9999-af2d-e3cd-3917c481651b@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 31, 2022 at 11:03:30AM +0800, Guo Zhengkui wrote:
> On 2022/3/30 20:56, Leon Romanovsky wrote:
> > On Wed, Mar 30, 2022 at 12:26:51PM +0000, Haakon Bugge wrote:
> > > 
> > > 
> > > > On 30 Mar 2022, at 13:32, Leon Romanovsky <leon@kernel.org> wrote:
> > > > 
> > > > On Wed, Mar 30, 2022 at 11:06:03AM +0000, Haakon Bugge wrote:
> > > > > 
> > > > > 
> > > > > > On 30 Mar 2022, at 13:02, Leon Romanovsky <leon@kernel.org> wrote:
> > > > > > 
> > > > > > On Mon, Mar 28, 2022 at 09:08:59PM +0800, Guo Zhengkui wrote:
> > > > > > > `if (!ret)` can be replaced with `else` for simplification.
> > > > > > > 
> > > > > > > Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> > > > > > > ---
> > > > > > > drivers/infiniband/hw/irdma/puda.c | 4 ++--
> > > > > > > drivers/infiniband/hw/mlx4/mcg.c   | 3 +--
> > > > > > > 2 files changed, 3 insertions(+), 4 deletions(-)
> > > > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > 
> > > > > Fix the unbalanced curly brackets at the same time?
> > > > 
> > > > I think that it is ok to have if () ... else { ... } code.
> > > 
> > > 
> > > Hmm, doesn't the kernel coding style say:
> > > 
> > > "Do not unnecessarily use braces where a single statement will do."
> > > 
> > > [snip]
> > > 
> > > "This does not apply if only one branch of a conditional statement is a single statement; in the latter case use braces in both branches"
> > 
> > ok, if it is written in documentation, let's follow it.
> > 
> > Thanks for pointing that out.
> 
> Should I resubmit the patch including unbalanced curly brackets fixing? If
> not, I can submit another patch to fix this problem.

Your patch wasn't merged yet, so new version should be sent.

Thanks 
> 
> > 
> > > 
> > > 
> > > Thxs, Håkon
> > > 
> > > 
> > > > 
> > > > There is one place that needs an indentation fix, in mlx4, but it is
> > > > faster to fix when applying the patch instead of asking to resubmit.
> > > > 
> > > > thanks
> > > > 
> > > > > 
> > > > > 
> > > > > Thxs, Håkon
> > > 
> 
> Thanks,
> 
> Zhengkui
