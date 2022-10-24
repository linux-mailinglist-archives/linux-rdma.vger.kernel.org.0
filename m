Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF4E60B579
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 20:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiJXS2h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 14:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiJXS2M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 14:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10F1E5EDD
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 10:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55CF1612B1
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 17:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360E7C433D7;
        Mon, 24 Oct 2022 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666631305;
        bh=yOvyFp+pfTzK8y0hodpHnU68rJe5WCqb8VybHSXMCvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5e1r0t/cKX4FfXnqxiQTLm1r7bXVk/Avm5E7Q4Y3Uyng/fp2rGX1mc3NT4zPx5X8
         XNjRj23Qu7ru5ecKvjgLKENCbbsYaffCdVr55XrA4ZsLTxJ3+hV4BzcTl6BAmiSr2V
         +lscxihleV3GpPJpyTKcz91v2MISn0GeXArM7Djz5Ts3S7bHX5xVfVTlplPJQmrjkQ
         aTsIYa+WbEeSpzcWOXPbY48ZRZqqLjKczqTxHkRpRgQ16YAmXAl9/h+EtAY4g8kifo
         9bt7fu5sqHPOUUtzmuX8Z80h9zoEqzItut2bl5DZw1fW8cWVIx+LDybC0Stfv6OCG5
         cIxCqXAYvqrDw==
Date:   Mon, 24 Oct 2022 20:08:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/rxe: Remove the member 'type' of struct rxe_mr
Message-ID: <Y1bGhcbwBWYrfrsD@unreal>
References: <20221021134513.17730-1-yangx.jy@fujitsu.com>
 <Y1Z8R7xB1omokwZ/@unreal>
 <be29ec7e-9f9e-40a1-358f-4a44c5defc0c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be29ec7e-9f9e-40a1-358f-4a44c5defc0c@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 24, 2022 at 09:07:11AM -0500, Bob Pearson wrote:
> On 10/24/22 06:51, Leon Romanovsky wrote:
> > On Fri, Oct 21, 2022 at 01:45:17PM +0000, yangx.jy@fujitsu.com wrote:
> >> The member 'type' is included in both struct rxe_mr and struct ib_mr
> >> so remove the duplicate one of struct rxe_mr.
> >>
> >> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe_mr.c    | 16 ++++++++--------
> >>  drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
> >>  2 files changed, 8 insertions(+), 9 deletions(-)
> > 
> > <...>
> > 
> >>  	default:
> >>  		pr_warn("%s: mr type (%d) not supported\n",
> >> -			__func__, mr->type);
> >> +			__func__, mr->ibmr.type);
> >>  		return -EFAULT;
> > 
> > <...>
> > 
> >> -	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
> >> -		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
> >> +	if (unlikely(mr->ibmr.type != IB_MR_TYPE_MEM_REG)) {
> >> +		pr_warn("%s: mr type (%d) is wrong\n", __func__, mr->ibmr.type);
> > 
> > Someone needs to convert pr_*() calls to ibdev_*() prints.
> > 
> > Thanks
> 
> I have a patch laying around that does this. Hoping some of the backlog of rxe patches gets
> accepted so I don't have to backport everything.

The way to move forward with RXE patches is to collect Reviewed-by from
other active RXE contributors.

I'm not taking RXE patches without ROB, that don't apply cleanly and which
don't follow kernel coding style both in code and in commit messages.

Thanks

> 
> Bob
