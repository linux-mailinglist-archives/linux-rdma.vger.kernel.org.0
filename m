Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571B31F181E
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2020 13:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgFHLrA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jun 2020 07:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgFHLq5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jun 2020 07:46:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ED5C08C5C2
        for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2020 04:46:56 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l17so3016057qki.9
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jun 2020 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1/y9YknownIHf+AL80R9HN3ZqxVEy7BnxT1Bev4lRHc=;
        b=NqZJm/KOd72QtiPYp6QcIh1ltzMPdbDSjGhwOxYhh+/M9cRPPPHpkJMZdtujjHcNUY
         PDeoglgHRHNkTBFIWyCleRxc5zUT//doKrk33OK26Jy9/6EY9BPU5pE3QfOfVmGH3u/6
         d7rIyXO6KLJullf/4aFOtZpsc8MCkEvjrUjhr0qMHyDRY+bArRuYrR4WA/J4k72INeNX
         SX3qXBbiWTlc8o2tAnw3PZPxrn+8VE6aiwuQ0y7Gr+zd5DzQ3DKkeM0nJkGQYV35+C9Z
         VlD1AlzsZdurHFw8ZwAU4QdT3T3ZjEY9WETdnJGL5psgTXrdr1zi3gYAYJvxkGU5qBfE
         kgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1/y9YknownIHf+AL80R9HN3ZqxVEy7BnxT1Bev4lRHc=;
        b=QlZ5CkRuNrPCHaYk5Lhdr+6l9V0NitwAwWjsiSUXnbxiWEcDVVOUzWWjy1cBVNIfDE
         gLglt1aoSKJ25DGaLQ+Qe+3ZTCR7WmFEHeDg2IwWKpkz/60OjMBznzDIWvXX43FicUaZ
         9firVnjqvznGeHgOVsX/2+822I/DsZ+b3tlpnMRk01hgJq1PqfQ3utyFU7s484G9Np9t
         eLClf/befIOVP2enGWej5drhUZVbAO5GoEVJGle1/kxXXyS9/ZXPjVjw94o3jX5Pp27f
         qHtA1OSFlmBR3xpITf7xnz/MSSMWeZdSKtFIsrNOQWnO7B/APn9QSneLIAZtw5SONGFR
         pY5Q==
X-Gm-Message-State: AOAM5323sMvIH+6nb8J7bup/BWGywweMQSAjA6ZEjVeOruMaTyjameDy
        3ON3/aTBToI/N/vaKOpzFJDJbQ==
X-Google-Smtp-Source: ABdhPJx0x+Ag0nq9uHqn/iBg4l5xeaw1fzoXqpKuiseblt3EG2VjoU40YLH2ZweryOV/JncYHEjsNg==
X-Received: by 2002:a37:655:: with SMTP id 82mr21244818qkg.77.1591616815932;
        Mon, 08 Jun 2020 04:46:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s201sm6726695qka.8.2020.06.08.04.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 04:46:55 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jiGEw-003s8z-PT; Mon, 08 Jun 2020 08:46:54 -0300
Date:   Mon, 8 Jun 2020 08:46:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 11/11] RDMA/mlx5: Add support to get MR
 resource in RAW format
Message-ID: <20200608114654.GS6578@ziepe.ca>
References: <20200527135408.480878-1-leon@kernel.org>
 <20200527135408.480878-12-leon@kernel.org>
 <20200529233121.GA3296@ziepe.ca>
 <20200531095414.GE66309@unreal>
 <20200601122646.GA4872@ziepe.ca>
 <20200602062118.GC56352@unreal>
 <20200602122702.GB6578@ziepe.ca>
 <20200602132303.GC55778@unreal>
 <703aa4a6-9c00-34f8-ce5e-5eb54180ed70@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703aa4a6-9c00-34f8-ce5e-5eb54180ed70@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 07, 2020 at 11:47:11AM +0300, Maor Gottlieb wrote:
> 
> On 6/2/2020 4:23 PM, Leon Romanovsky wrote:
> > On Tue, Jun 02, 2020 at 09:27:02AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 02, 2020 at 09:21:18AM +0300, Leon Romanovsky wrote:
> > > > On Mon, Jun 01, 2020 at 09:26:46AM -0300, Jason Gunthorpe wrote:
> > > > > On Sun, May 31, 2020 at 12:54:14PM +0300, Leon Romanovsky wrote:
> > > > > > On Fri, May 29, 2020 at 08:31:21PM -0300, Jason Gunthorpe wrote:
> > > > > > > On Wed, May 27, 2020 at 04:54:08PM +0300, Leon Romanovsky wrote:
> > > > > > > > From: Maor Gottlieb <maorg@mellanox.com>
> > > > > > > > 
> > > > > > > > Add support to get MR (mkey) resource dump in RAW format.
> > > > > > > > 
> > > > > > > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > > > > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > > > > >   drivers/infiniband/hw/mlx5/restrack.c | 3 ++-
> > > > > > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
> > > > > > > > index 9e1389b8dd9f..834886536127 100644
> > > > > > > > +++ b/drivers/infiniband/hw/mlx5/restrack.c
> > > > > > > > @@ -116,7 +116,8 @@ int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
> > > > > > > >   	struct nlattr *table_attr;
> > > > > > > > 
> > > > > > > >   	if (raw)
> > > > > > > > -		return -EOPNOTSUPP;
> > > > > > > > +		return fill_res_raw(msg, mr->dev, MLX5_SGMT_TYPE_PRM_QUERY_MKEY,
> > > > > > > > +				    mlx5_mkey_to_idx(mr->mmkey.key));
> > > > > > > None of the raw functions actually share any code with the non raw
> > > > > > > part, why are the in the same function? In fact all the implemenations
> > > > > > > just call some other function for raw.
> > > > > > > 
> > > > > > > To me this looks like they should should all be a new op
> > > > > > > 'fill_raw_res_mr_entry' and drop the 'bool'
> > > > > > I don't think that this is right approach, we already created ops per-objects
> > > > > > o remove API multiplexing. Extra de-duplication will create too much ops
> > > > > > without any real benefit.
> > > > > If there is no code sharing then they should not be in the same
> > > > > function at all. More ops is not really a problem.
> > > > Logically they are the same, user asks to get object property, driver returns.
> > > I'm starting to think it is also a mistake to have the same netlink op
> > > and trigger it by an inbound attribute. Are there other examples of
> > > that in netlink? Feels wrong
> > I have no idea, don't see it in devlink.c
> 
> Jason, do you mean trigger the raw by inbound attribute? I don't see a
> reason why not do that. Netlink attributes used for input and
> output. 

What examples do you have where the input attribute completely changes
the output format?

Jason
