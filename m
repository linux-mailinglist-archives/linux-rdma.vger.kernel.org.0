Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC01F39FB
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2020 13:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgFILmb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jun 2020 07:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgFILm0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jun 2020 07:42:26 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85CC05BD1E
        for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2020 04:42:26 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n141so20413912qke.2
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2020 04:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T7UWzrg6IFJEbQM0ITdQA37PoFS/aYRgz3NK79JHalU=;
        b=E6yuZULJji00wmYUNOpoJRPPlBydmBJ8ilBcxOYaUs8PJJBCfKVj+FDuXJc6V6XtqT
         muLnU3+yOoAJ4/2kr7VPBE3ER5Xtuu2/ATqDEZBCJZBCwqRDiBtZ7kuSMu79tuD+Oc9p
         uiIWEH+urBo1AvzvOSOMHpMM5cgzxdqw4CiagigLWFHlyidVjEudgHwLsLPhiWi/iZOq
         MI2/pJKrtFIw+D+p9wIYrjwMkF1o7fJ/BZdlU+MUXGysfzOdQ4v8ckp84wlP84wyznVx
         DRYBgoMbtj5v6Wqx6HXoXZPx+2rU9aiXS2Df0lS9+16kWSNnaGB1Lhv8AtHbvuWSxJHJ
         W6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T7UWzrg6IFJEbQM0ITdQA37PoFS/aYRgz3NK79JHalU=;
        b=tyTIiY2Rcz05D5vC+ZRiKjuHCBzHqcf4bDZ4IP92yIEUPwdQqAFA7GQMHTqCGmPrcb
         deN5znGvPNWkprmQ5jB1tFjTQCurJ0I23hdMpxIOMsPLo24pEI9DqoZyjEEAYbwypNB3
         VaiYIhw0RBu/3br1eMszsG4y3lk8i+nALuXlSbm4753qnImUgewE2DVngxVDYGkoS1s9
         Oaw0dfRL8+AAQ53WL2i7kHg3NJiqvcgpQgJyx6zVnCeSoKzQwU6SazFxnKOdwNLsF0op
         eAjFnXqPwLx48LTgX4U1gJ/3T+N7arp4u4c/klTrYCyfAcHUUvLZjeyFeLBbMkD3ms++
         45Bw==
X-Gm-Message-State: AOAM5312Tvc3e+PuMTENSbYF/bbfM0C8aWRFUosgBr13uJK+fkI4sM1W
        hMyp63Nkt3Guk7+cnLb41AE9ZA==
X-Google-Smtp-Source: ABdhPJyNaZEgWzhGpmN5bi7JbIDO7IQmgJCu80QseIlucSkDVah1JamHGLN7GUC2vE3KVfe3yb33PA==
X-Received: by 2002:a37:4b88:: with SMTP id y130mr26950313qka.80.1591702945695;
        Tue, 09 Jun 2020 04:42:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o3sm10496727qkj.97.2020.06.09.04.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 04:42:24 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jice8-004i2I-Bp; Tue, 09 Jun 2020 08:42:24 -0300
Date:   Tue, 9 Jun 2020 08:42:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 11/11] RDMA/mlx5: Add support to get MR
 resource in RAW format
Message-ID: <20200609114224.GT6578@ziepe.ca>
References: <20200527135408.480878-12-leon@kernel.org>
 <20200529233121.GA3296@ziepe.ca>
 <20200531095414.GE66309@unreal>
 <20200601122646.GA4872@ziepe.ca>
 <20200602062118.GC56352@unreal>
 <20200602122702.GB6578@ziepe.ca>
 <20200602132303.GC55778@unreal>
 <703aa4a6-9c00-34f8-ce5e-5eb54180ed70@mellanox.com>
 <20200608114654.GS6578@ziepe.ca>
 <7840e2c7-8e9a-834d-b199-b1ebfa31fee3@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7840e2c7-8e9a-834d-b199-b1ebfa31fee3@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 09, 2020 at 11:27:08AM +0300, Maor Gottlieb wrote:
> 
> On 6/8/2020 2:46 PM, Jason Gunthorpe wrote:
> > On Sun, Jun 07, 2020 at 11:47:11AM +0300, Maor Gottlieb wrote:
> > > On 6/2/2020 4:23 PM, Leon Romanovsky wrote:
> > > > On Tue, Jun 02, 2020 at 09:27:02AM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, Jun 02, 2020 at 09:21:18AM +0300, Leon Romanovsky wrote:
> > > > > > On Mon, Jun 01, 2020 at 09:26:46AM -0300, Jason Gunthorpe wrote:
> > > > > > > On Sun, May 31, 2020 at 12:54:14PM +0300, Leon Romanovsky wrote:
> > > > > > > > On Fri, May 29, 2020 at 08:31:21PM -0300, Jason Gunthorpe wrote:
> > > > > > > > > On Wed, May 27, 2020 at 04:54:08PM +0300, Leon Romanovsky wrote:
> > > > > > > > > > From: Maor Gottlieb <maorg@mellanox.com>
> > > > > > > > > > 
> > > > > > > > > > Add support to get MR (mkey) resource dump in RAW format.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > > > > > > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > > > > > > >    drivers/infiniband/hw/mlx5/restrack.c | 3 ++-
> > > > > > > > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
> > > > > > > > > > index 9e1389b8dd9f..834886536127 100644
> > > > > > > > > > +++ b/drivers/infiniband/hw/mlx5/restrack.c
> > > > > > > > > > @@ -116,7 +116,8 @@ int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
> > > > > > > > > >    	struct nlattr *table_attr;
> > > > > > > > > > 
> > > > > > > > > >    	if (raw)
> > > > > > > > > > -		return -EOPNOTSUPP;
> > > > > > > > > > +		return fill_res_raw(msg, mr->dev, MLX5_SGMT_TYPE_PRM_QUERY_MKEY,
> > > > > > > > > > +				    mlx5_mkey_to_idx(mr->mmkey.key));
> > > > > > > > > None of the raw functions actually share any code with the non raw
> > > > > > > > > part, why are the in the same function? In fact all the implemenations
> > > > > > > > > just call some other function for raw.
> > > > > > > > > 
> > > > > > > > > To me this looks like they should should all be a new op
> > > > > > > > > 'fill_raw_res_mr_entry' and drop the 'bool'
> > > > > > > > I don't think that this is right approach, we already created ops per-objects
> > > > > > > > o remove API multiplexing. Extra de-duplication will create too much ops
> > > > > > > > without any real benefit.
> > > > > > > If there is no code sharing then they should not be in the same
> > > > > > > function at all. More ops is not really a problem.
> > > > > > Logically they are the same, user asks to get object property, driver returns.
> > > > > I'm starting to think it is also a mistake to have the same netlink op
> > > > > and trigger it by an inbound attribute. Are there other examples of
> > > > > that in netlink? Feels wrong
> > > > I have no idea, don't see it in devlink.c
> > > Jason, do you mean trigger the raw by inbound attribute? I don't see a
> > > reason why not do that. Netlink attributes used for input and
> > > output.
> > What examples do you have where the input attribute completely changes
> > the output format?
> > 
> > Jason
> 
> I don't have. Anyway I am planning to send v2 with new netlink ops.

Well, I think you need to look at the netlink interface side too.

Jason
