Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9526C60F742
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 14:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiJ0MaT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 08:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiJ0M3z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 08:29:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238631704B
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 05:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D04AEB8254D
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 12:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0B3C433D6;
        Thu, 27 Oct 2022 12:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666873791;
        bh=R11vC7hgHUKuESkco2DjgSO1yECw9k6cU33r3P8RUH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAFx71GCGyUoxu0KH7hULQTk6sTAuxs+29DilKpN4bfGm5yZd/Ka5VW+sVaxKZzPQ
         A1mfogrqIWlic/lfHsdKkOVIRNwGHbJ5lwUdGfMs6FMVi6SjHb4JmSklzDfcOU80IY
         uv62Siu9pEDr8GL2e3ARyYMPoQBt2xZG2SjsfMlfVQss7Ni8iHZdmnVM7hVpqf7dZj
         sZ1CCGenDBGnG7Jnk/ELQGK21yL8ls/m7NOzkrWv+OGh4CuTTb6RVb9UrreFYLP4H2
         PhFBxuvccwI1m1xS7ShHBGoq9gciUldePxpNVrumE2L1kYhZf+/iCurxO68tK65SJY
         SrXCu2DCCWDWQ==
Date:   Thu, 27 Oct 2022 15:29:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Ariel Elior <aelior@marvell.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH rdma-rc] RDMA/qedr: Destroy XArray during release of
 resources
Message-ID: <Y1p5u9I1C2c8PCHo@unreal>
References: <3af204a14d3dadf4102cd55ef50f0d927bb97884.1666871711.git.leonro@nvidia.com>
 <Y1pz9LYGUScO2Zpt@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1pz9LYGUScO2Zpt@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 27, 2022 at 09:05:08AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 27, 2022 at 03:01:16PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Destroy XArray while releasing qedr resources.
> > 
> > Fixes: b6014f9e5f39 ("qedr: Convert qpidr to XArray")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > I'm sending it to -rc just because of dependency on
> > https://lore.kernel.org/linux-rdma/166687129991.306571.17052575958640789335.b4-ty@kernel.org/T/#m0e945baa7f2c87ede9f1711c992889602ede7875
> > qps is empty and nothing is really leaked here.
> 
> if qps is known to be empty then this should be WARN_ON(!xa_empty()) -
> destroying an xarray that holds allocated memory is never correct - it
> will leak the elements
> 
> Also, this isn't "for-rc", so it should go to -next. With a dependency
> like this the patch waits until linus merges the rc branch and then
> -next merges linus's rcX tag to resolve the conflict.

Let's drop this patch. QPS is empty.

Thanks

> 
> Jason
