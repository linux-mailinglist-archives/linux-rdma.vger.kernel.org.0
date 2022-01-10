Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9892248992E
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 14:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiAJNFd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 08:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiAJNE5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jan 2022 08:04:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37393C06173F
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jan 2022 05:03:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01276B81648
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jan 2022 13:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D747BC36AE3;
        Mon, 10 Jan 2022 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641819820;
        bh=GoJKTmgyZO20bmWDy8Ip+GPBZnB1PTxxEyzEHJe/LIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HzxTzMV1RRsgKG5h8na2/wOHY0YP91Rd0jv8V1kFoTZwURHjUQK13SdJOOx1HmeqO
         M8Tixb/gG/iaq5PKb0I8B+xJTmekDLg/VpGArKVlmd6di6jtf8j3b6JuHVSDCilRS/
         7jlt2jzg7+CXLxj7UCZQzSxbGhqWqQVO+1SItMIWqKxo2tAeF139DYXhXvLuNTE34Y
         UO7MVG4fz1AI5PBcdoiTtdt/7Squ24gwIfuCrihIDXNUFXzThHIk2B1ZyM4t9DJplf
         xOPzlh//JtHY1D4SIKhP+LFbUcpndjLjpfW7oz0s4rweACb4vX9yO1A5nhOT4A8fGg
         SjmCkQZNBQu/g==
Date:   Mon, 10 Jan 2022 15:03:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     yanjun.zhu@linux.dev, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/irdma: Remove the redundant return
Message-ID: <YdwuqDCMQjLKRESJ@unreal>
References: <20220110073733.3221379-1-yanjun.zhu@linux.dev>
 <YdstJ/u/HF5e6s0y@unreal>
 <20220110125407.GE6467@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110125407.GE6467@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 10, 2022 at 08:54:07AM -0400, Jason Gunthorpe wrote:
> On Sun, Jan 09, 2022 at 08:44:55PM +0200, Leon Romanovsky wrote:
> > On Mon, Jan 10, 2022 at 02:37:33AM -0500, yanjun.zhu@linux.dev wrote:
> > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > 
> > > The type of the function i40iw_remove is void. So remove
> > > the unnecessary return.
> > > 
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > >  drivers/infiniband/hw/irdma/i40iw_if.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
> > > index d219f64b2c3d..43e962b97d6a 100644
> > > +++ b/drivers/infiniband/hw/irdma/i40iw_if.c
> > > @@ -198,7 +198,7 @@ static void i40iw_remove(struct auxiliary_device *aux_dev)
> > >  							       aux_dev);
> > >  	struct i40e_info *cdev_info = i40e_adev->ldev;
> > >  
> > > -	return i40e_client_device_unregister(cdev_info);
> > > +	i40e_client_device_unregister(cdev_info);
> > 
> > I'm surprised that compiler didn't warn about extra parameter to return.
> 
> It is odd, but valid, C to return void like this..

Any idea where such C expression can be useful?

Thanks

> 
> Jason
