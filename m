Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B821EBBA5
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 14:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgFBM1H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 08:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgFBM1H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jun 2020 08:27:07 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AEEC061A0E
        for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2020 05:27:06 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j32so10381666qte.10
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2020 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=smiduw+OlrATxkidVCjN44expuSDCDFSz/NbQHHRZE4=;
        b=Niq2Elg1bv0WhlZ7s9t4xWqbZlMeHUbOXZzfBgD5cYiKM28Dz3sqPpw5Ohebxt5SPu
         15OxqLR457f0FWwR6s/+/cYPOgs/zxa6jkC3zYP0ujXROfDnVveRwrTXI+k0RUigSZ5j
         LJZBPZIWr85miJG/cufEV5O8RwKb/K/2XIvAFh93UpMUX4PbPsNbwpfEihtTiIEaFURk
         TbfgvnV3xgwSHvrrTM7dRIXo10wxULxBdftCmanoBsqoRb6Ezes1IGmio4q4YiyZ9t/o
         yJfuZg1tKwwh7TViMudXWaJCtp55u+FKEYsANkt68OfWl4RvVvVnhWP0nHm4NwAUtaaH
         QJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=smiduw+OlrATxkidVCjN44expuSDCDFSz/NbQHHRZE4=;
        b=O4TY/cG1+wFOZKGM0p/hqX6UN6KR2qAiThOaObujrZ5xifvBC4nasrYM9u8o4wrQXX
         ZHR1PBjCPOAH5Uszg7wcE98KmEyohfmciCqn96j/TbCdgbFO9WpnsmI+D/SbxiEe6exV
         UQvBvtB+IEPg2goCDMfFBA81liLQOHgkCKEVFe9ByUItvVOCIBwz0AKEMSWhKWmAf7E4
         kHY3kMgv/NFV9aAk5vwykx3wM6CPtQrH2M+hc57twZL8RiF51sQAU7uKcHzZ5ZpVP+yF
         TnjWiShywFpZOSLhPnzF5za4fiz5Zm+dwwC06rWUQjME929tgvR9qLU/2nEGFDhVXkxn
         MY7A==
X-Gm-Message-State: AOAM531kCJvVOSmnT5taoZ4SO765RitIJifMd4ozQG/oMhhiWnq5x2tb
        5VTckl6WvqEzzDcSg47L/wBoDQ==
X-Google-Smtp-Source: ABdhPJxigd9XRDgDRvZN8QWrFd1G0PswiCDXUaJoJZlDGTJN64t1NQdmK6PEhRg3JV5T3qgvyBoDxg==
X-Received: by 2002:ac8:7383:: with SMTP id t3mr28559000qtp.221.1591100825098;
        Tue, 02 Jun 2020 05:27:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d16sm2676973qte.49.2020.06.02.05.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 05:27:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jg60U-00099B-Oj; Tue, 02 Jun 2020 09:27:02 -0300
Date:   Tue, 2 Jun 2020 09:27:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 11/11] RDMA/mlx5: Add support to get MR
 resource in RAW format
Message-ID: <20200602122702.GB6578@ziepe.ca>
References: <20200527135408.480878-1-leon@kernel.org>
 <20200527135408.480878-12-leon@kernel.org>
 <20200529233121.GA3296@ziepe.ca>
 <20200531095414.GE66309@unreal>
 <20200601122646.GA4872@ziepe.ca>
 <20200602062118.GC56352@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602062118.GC56352@unreal>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 02, 2020 at 09:21:18AM +0300, Leon Romanovsky wrote:
> On Mon, Jun 01, 2020 at 09:26:46AM -0300, Jason Gunthorpe wrote:
> > On Sun, May 31, 2020 at 12:54:14PM +0300, Leon Romanovsky wrote:
> > > On Fri, May 29, 2020 at 08:31:21PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, May 27, 2020 at 04:54:08PM +0300, Leon Romanovsky wrote:
> > > > > From: Maor Gottlieb <maorg@mellanox.com>
> > > > >
> > > > > Add support to get MR (mkey) resource dump in RAW format.
> > > > >
> > > > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > >  drivers/infiniband/hw/mlx5/restrack.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
> > > > > index 9e1389b8dd9f..834886536127 100644
> > > > > +++ b/drivers/infiniband/hw/mlx5/restrack.c
> > > > > @@ -116,7 +116,8 @@ int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
> > > > >  	struct nlattr *table_attr;
> > > > >
> > > > >  	if (raw)
> > > > > -		return -EOPNOTSUPP;
> > > > > +		return fill_res_raw(msg, mr->dev, MLX5_SGMT_TYPE_PRM_QUERY_MKEY,
> > > > > +				    mlx5_mkey_to_idx(mr->mmkey.key));
> > > >
> > > > None of the raw functions actually share any code with the non raw
> > > > part, why are the in the same function? In fact all the implemenations
> > > > just call some other function for raw.
> > > >
> > > > To me this looks like they should should all be a new op
> > > > 'fill_raw_res_mr_entry' and drop the 'bool'
> > >
> > > I don't think that this is right approach, we already created ops per-objects
> > > o remove API multiplexing. Extra de-duplication will create too much ops
> > > without any real benefit.
> >
> > If there is no code sharing then they should not be in the same
> > function at all. More ops is not really a problem.
> 
> Logically they are the same, user asks to get object property, driver returns.

I'm starting to think it is also a mistake to have the same netlink op
and trigger it by an inbound attribute. Are there other examples of
that in netlink? Feels wrong

Jason
