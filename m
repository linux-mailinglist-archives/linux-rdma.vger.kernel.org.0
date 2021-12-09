Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E305546DF52
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 01:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbhLIAQn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 19:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241385AbhLIAQm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Dec 2021 19:16:42 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF6C0617A1
        for <linux-rdma@vger.kernel.org>; Wed,  8 Dec 2021 16:13:10 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 193so3571703qkh.10
        for <linux-rdma@vger.kernel.org>; Wed, 08 Dec 2021 16:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZXLHaCEAH+un64UyYr7XPJdqJejjDqylFmPh2v+jPdo=;
        b=MjibJv3o5tsb8iCd1BtOBtYVQbisRTNO9bO/03va81K4ZALLn/8lApsdvNug85KI5c
         30zrzTFQ+pr8kE364wkrnctxQpgBxPc1Hr7lo8IcizUnA1A4kgIurVFHu4QH2TLClnKW
         R+vavanFDKv4jo9cPJNI3jBpDGEQAfxTfSNK2s7fGCeGQqD2k6Ia7ej16DXmuhGu+lmX
         wUoU9vOFvwpTkkRNCzdDEiVgZyDpP4rRVVYY2TeXMhHK0AM+5+SNH+l7AP10kfQ+BFY8
         kn1bc6/PM3AZEiKlgcCxYKxb9WZ/vYAtiDedypnYiTgvoQX+uU7tYDr7XnhXhkgYX4i0
         Vl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZXLHaCEAH+un64UyYr7XPJdqJejjDqylFmPh2v+jPdo=;
        b=tyPkErAsnC+mND1iMdYGyy19dyiPQKDob0vCW0wgNAgpPMnN/RiMxKKkPvgLVuIJKa
         fLCtGWtIIsHs3Bq4q6vL0yhc579HijxMhtpxCA66EapF+6MeGOiT8Egh7/6VzXYNg4bd
         2aCyIuBxxIRFS16/X6c9RAVejaDkGNPrUHctb27mYRRjIt6G/An+vjNR6zkPwVI+eZNT
         SJrQgmrTdbWCL9aJGB+AwJnjt+HG45h7aHy4Ov01aO5HwCwlUBS6x9ip4o2H1BsywuAU
         G5Jn38mPKijWcIiVnl7ugQwOil5BK5Suq1vW7QRFIitaqWnDnTmZP5c+icJOLJs8k/+f
         RpgA==
X-Gm-Message-State: AOAM532X8g+l8LjlQEZ57UCiJ4BOkQwezwNN6v9letkn8oyU7uA+x1jZ
        17RWj7cjXg24crYfZsgi8Ave5w==
X-Google-Smtp-Source: ABdhPJxD0j5IiffK3Q+3ztXHc65b0Zcnp4aqeM+nHJ+HWNiav8thR/LMLpAyPBRxw2WGB75PTHKd0A==
X-Received: by 2002:a37:9d44:: with SMTP id g65mr10531227qke.495.1639008789316;
        Wed, 08 Dec 2021 16:13:09 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f11sm2204053qko.84.2021.12.08.16.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 16:13:08 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mv73b-000wes-5K; Wed, 08 Dec 2021 20:13:07 -0400
Date:   Wed, 8 Dec 2021 20:13:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH rdma-next 2/3] RDMA/core: Let ib_find_gid() continue
 search even after empty entry
Message-ID: <20211209001307.GD6467@ziepe.ca>
References: <cover.1637581778.git.leonro@nvidia.com>
 <aab136be84ad03185a1084cb2e1ca9cad322ab23.1637581778.git.leonro@nvidia.com>
 <20211207184304.GB114160@nvidia.com>
 <YbBWD5rDm+wBxVjU@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbBWD5rDm+wBxVjU@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 08, 2021 at 08:51:59AM +0200, Leon Romanovsky wrote:
> On Tue, Dec 07, 2021 at 02:43:04PM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 22, 2021 at 01:53:57PM +0200, Leon Romanovsky wrote:
> > > From: Avihai Horon <avihaih@nvidia.com>
> > > 
> > > Currently, ib_find_gid() will stop searching after encountering the
> > > first empty GID table entry. This behavior is wrong since neither IB
> > > nor RoCE spec enforce tightly packed GID tables.
> > > 
> > > For example, when a valid GID entry exists at index N, and if a GID
> > > entry is empty at index N-1, ib_find_gid() will fail to find the valid
> > > entry.
> > > 
> > > Fix it by making ib_find_gid() continue searching even after
> > > encountering missing entries.
> > > 
> > > Fixes: 5eb620c81ce3 ("IB/core: Add helpers for uncached GID and P_Key searches")
> > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > Reviewed-by: Mark Zhang <markzhang@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > >  drivers/infiniband/core/device.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > > index 22a4adda7981..b5d8443030d4 100644
> > > +++ b/drivers/infiniband/core/device.c
> > > @@ -2460,8 +2460,11 @@ int ib_find_gid(struct ib_device *device, union ib_gid *gid,
> > >  		for (i = 0; i < device->port_data[port].immutable.gid_tbl_len;
> > >  		     ++i) {
> > >  			ret = rdma_query_gid(device, port, i, &tmp_gid);
> > > +			if (ret == -ENOENT)
> > > +				continue;
> > >  			if (ret)
> > >  				return ret;
> > 
> > There is no return code from rdma_query_gid that means stop searching,
> 
> In rdma_query_gid() any error stopped searching, and here we continue
> same behaviour as before. You can argue that this function can't really
> get illegal parameters and it never returns -EINVAL, but someone needs
> to check all callers that this is true.
> 
> > so just write
> > 
> > if (ret)
> >    continue
> 
> As long as we don't delete input validity checks, it is not correct.

It is fine, there is no return condition that means stop searching,
and even if we fail the validity checks that is a WARN_ON and keep
going, not a stop searching event here.

So just do continue, no need for complications.

Jason
